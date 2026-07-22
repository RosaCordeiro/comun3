HA$PBExportHeader$uo_ge481_est_base_min_promo.sru
forward
global type uo_ge481_est_base_min_promo from nonvisualobject
end type
end forward

global type uo_ge481_est_base_min_promo from nonvisualobject
end type
global uo_ge481_est_base_min_promo uo_ge481_est_base_min_promo

type variables
uo_ge470_sap_comum io_sap_comum
uo_ge473_comum lo_Comum

String is_Origem_Legado 		= "SYBASE"
Integer ii_Empresa				= 1000

String is_Termino_Cabecalho 	= '</Cabecalho>'
String is_Termino_Item 			= '</Item>'


String	is_URL,&
			is_Inicio_XML,&
			is_Termino_XML,&
			is_Arquivo_Log			
			
String is_Ambiente_SAP = 'PRD'
String ls_Grava_XML

Integer	ii_log

Long il_Filial,&
		il_cd_produto,&
		il_qt_estoque,&
		il_qt_min_base_planograma



String is_Fornecedor

Date idt_data
String idh_alteracao

String is_id_tipo,&
		 is_de_motivo_base,&
		 is_item_termino_vigencia,&
		 is_cd_produto_sap,&
		 is_filial_sap,&
		 is_cd_promocao_sap,&
		 is_Log,&
		 is_promocao,&
		 iis_Log,&
		 is_cd_promocao_planograma,&
		 is_matricula,&
		 is_origem
		 
Long  il_nr_atualzacao
boolean ib_monitor_exp=false

dc_uo_ds_base ivds_pedidos




end variables

forward prototypes
public function boolean of_ambiente_sap (ref string as_log)
public function boolean of_abre_log_est_base_min_promo ()
public function boolean of_grava_log_est_base_min_promo (string as_mensagem, boolean ab_envia_email)
public subroutine of_processa_envio_est_base_min_pro ()
public subroutine of_grava_xml (string as_nr_atualzacao, string as_xml)
public function boolean of_valida_dados (ref string as_log)
public function boolean of_processa_retorno_xml (string as_xml, ref string as_mensagem)
public function boolean of_atualiza_exportacao (long al_nr_atualizacao, ref string as_log, string as_ambiente_sap, string as_tipo, string as_msg)
public subroutine of_processa_envio_est_base_min_pro (long pl_nr_atualizacao)
public function string of_busca_valor (string as_xml, string as_tag, ref long al_pos)
end prototypes

public function boolean of_ambiente_sap (ref string as_log);return gf_ambiente_sap( ref is_ambiente_sap, ref as_log )
end function

public function boolean of_abre_log_est_base_min_promo ();String	lvs_Path

lvs_Path = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "")

If lvs_Path <> "" Then
	
	is_Arquivo_Log = lvs_Path + "integracao_est_base_min_promocao_sap.log"
	
	ii_log = FileOpen(is_Arquivo_Log, LineMode!, Write!, LockWrite!)
	
	If ii_log = -1 Then		
		Return False
	End If
Else
	Return False
End If

Return True
end function

public function boolean of_grava_log_est_base_min_promo (string as_mensagem, boolean ab_envia_email);String lvs_Mensagem

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
	Return False
End If
end function

public subroutine of_processa_envio_est_base_min_pro ();of_processa_envio_est_base_min_pro(0)
end subroutine

public subroutine of_grava_xml (string as_nr_atualzacao, string as_xml);String lvs_Path, lvs_Log

Integer li_Log

lvs_Path = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "")

If lvs_Path <> "" Then
	
	lvs_Log = lvs_Path + as_nr_atualzacao + "_"  + String(year(today()), "0000") + String(Month(today()), "00") + String(Day(today()), "00") + "_" + String(Hour(Now()), "00") +  String(Minute(Now()), "00") + String(Second ( Now() ), "00") +  ".xml"
	
	li_Log = FileOpen(lvs_Log, StreamMode!, Write!, LockReadWrite!, Replace!, EncodingUTF8!)
	
	If li_Log = -1 Then
		If Not gvb_Auto Then			
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

public function boolean of_valida_dados (ref string as_log);long ll_cd_promocao

Try	
	//	 Tipo Sempre Deve Existir
	If IsNull(is_id_tipo) or  trim(is_id_tipo) = ""  then
		is_Log	= " : Tabela Log_Exporacao_Sap - Sem Tipo de Operacao :"
		lf_ge470_log('Nr Atualizacao:' + String(il_nr_atualzacao) + is_Log, 1, is_id_tipo , 'EST_BASE_MIN', ii_log)
		Return False
	End If						
			
	// Valida Produto: N$$HEX1$$e300$$ENDHEX$$o pode ser vazio		
	if is_cd_produto_sap = '' or isnull(is_cd_produto_sap) Then
		is_Log	= " : Tabela Log_Exporacao_Sap - Produto do SAP Nulo : N$$HEX1$$e300$$ENDHEX$$o foi encontrada o c$$HEX1$$f300$$ENDHEX$$digo SAP para o produto " + string(il_cd_produto) + '.'
		lf_ge470_log('Nr Atualizacao:' + String(il_nr_atualzacao) + is_Log, 1, is_id_tipo , 'EST_BASE_MIN', ii_log)
		return false
	end if			
			
	// Valida Codigo da Filial 
	If Not lo_Comum.of_Localiza_Codigo_Filial_Legado(is_filial_sap, Ref il_Filial, Ref iis_Log) Then 
		is_Log	= " : Tabela Log_Exporacao_Sap - Filial SAP :"
		lf_ge470_log('Nr Atualizacao:' + String(il_nr_atualzacao) + is_Log, 1, is_id_tipo , 'EST_BASE_MIN', ii_log)
		Return False
	End If 				
				
	// Valida Codigo do Produto
	If Not lo_Comum.of_localiza_codigo_produto_legado( is_cd_produto_sap , Ref il_cd_produto, Ref iis_Log) Then 
		is_Log	= " : Tabela Log_Exporacao_Sap - Codigo do Produto SAP : "
		lf_ge470_log('Nr Atualizacao:' + String(il_nr_atualzacao) + is_Log, 1, is_id_tipo , 'EST_BASE_MIN', ii_log)
		Return False
	End If 
			
	// Valida Codigo da Promocao SAP
	If is_id_tipo = 'PRO' Then 
		
		If Not lo_Comum.of_localiza_codigo_promocao_legado(is_cd_promocao_sap, ref ll_cd_promocao , ref iis_Log) Then
			is_Log	= " : Tabela Log_Exporacao_Sap - Codigo do Promocao SAP : " + iis_log
			lf_ge470_log('Nr Atualizacao:' + String(il_nr_atualzacao) + is_Log, 1, is_id_tipo , 'EST_BASE_MIN', ii_log)
			Return False
		End If 
		
		is_promocao = string(ll_cd_promocao)
		
	End If 

	if isnull(is_matricula) Then
		is_matricula = 'SAP001'
	end if

Catch ( runtimeerror  lo_rte )
	as_Log = is_Log  + "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_processa_retorno_xml (string as_xml, ref string as_mensagem);long ll_contador=0
string ls_msg, ls_msg2, ls_msg3, ls_mensagem, ls_tag_ini, ls_tag_fim

DO 
	
	ll_contador++
	
	ls_msg = of_busca_valor(as_xml, '<id>', ll_contador)
	
	if ls_msg = '' or isnull(ls_msg) Then
		Exit
	end if
	
	if upper(ls_msg) <> 'S' Then
		
		ls_msg2 = of_busca_valor(as_xml, '<message>', ll_contador)
		
		ls_mensagem += ls_msg2
		
		ls_msg3 = of_busca_valor(as_xml, '<value>', ll_contador)
		
	end if
	
Loop While ll_contador > 0

as_mensagem = ls_mensagem

return True
end function

public function boolean of_atualiza_exportacao (long al_nr_atualizacao, ref string as_log, string as_ambiente_sap, string as_tipo, string as_msg);If as_tipo = 'S' Then 
	Update log_exportacao_sap
	Set dh_exportacao = getdate(), 
			  id_status_integracao = 'P',
			  id_situacao_docto  = 'P'
	Where nr_atualizacao  = :al_nr_atualizacao
	Using SqlCa;
					
	If SqlCa.Sqlcode = -1 Then
		as_log += "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o dos campos de exportacao na tabela 'log_exportacao_sap', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_atualiza_exportacao': " + SqlCa.SqlerrText
		Return False
	Else
		Return True
	End If 
	
elseif as_tipo = 'E' Then
	
	Update log_exportacao_sap
	Set dh_exportacao = getdate(), 
		  id_status_integracao = 'E',
		  id_situacao_docto  = 'C',
		  de_erro = :as_msg
	Where nr_atualizacao  = :al_nr_atualizacao
	Using SqlCa;
					
	If SqlCa.Sqlcode = -1 Then
		as_log += "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o dos campos de exportacao na tabela 'log_exportacao_sap', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_atualiza_exportacao': " + SqlCa.SqlerrText
		Return False
	Else
		Return True
	End If 
	
End If 


end function

public subroutine of_processa_envio_est_base_min_pro (long pl_nr_atualizacao);//Boolean lb_Envia_Sap
Boolean	 lb_Sucesso = False

Long	ll_Linhas,&
		ll_Linha,&
		ll_Seq_Log,&
		ll_Log, ll_progresso_geral=0

String	ls_XML_Item,&
		ls_XML,&
		ls_XML_Cabecalho,&
		ls_Xml_Retorno, ls_mensagem
				
dc_uo_ds_base lds

// Fecha o arquivo de log para n$$HEX1$$e300$$ENDHEX$$o dar erro quando tela do EX for utilizar o objeto, a abetura esta no construtor.
FileClose (io_sap_comum.ii_log )

gvs_Log_Geral = ''

if pl_nr_atualizacao > 0 Then
	ib_monitor_exp = True
end if

// MUDAR DEPOIS 
If Not of_ambiente_sap(ref is_Log) Then
	lf_ge470_log(is_Log, 1, 'EST', 'EST_BASE_MIN', ii_log)	
	Return 
End If

ls_Grava_XML = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Configuracao", "Grava_XML_EST_BASE_MINIMO", "")
idt_data = Date(gf_GetServerDate())
	
Try 
	
	if isvalid(w_aguarde_3) Then
		w_aguarde_3.uo_progress.of_setmax(3)
		
		w_aguarde_3.wf_settext('Validando as configura$$HEX2$$e700f500$$ENDHEX$$es da interface...', 2)
	end if
	
	/// Precisa ter a URL
	If Not gf_retorna_pametro_sap(SQLCA, is_Ambiente_SAP, 'CD_URL_EST_BASE_MINIMO_PROMO', ref is_URL, ref is_Log) Then
		lf_ge470_log(is_Log, 1, 'EST', 'EST_BASE_MIN', ii_log)
		Return 
	End If
		
	lds = Create dc_uo_ds_base
	ll_Log = FileLength(is_Arquivo_Log)
	
	If Not lds.of_ChangeDataObject("ds_ge481_est_base_mini_promocao", False) Then
		lf_ge470_log("Erro ao alterar a DW 'ds_ge481_est_base_mini_promocao' - uo_ge481_est_base_min_promo", 1, 'EST', 'EST_BASE_MIN', ii_log)
		Return
	End If

	if pl_nr_atualizacao > 0 Then
		lds.of_appendwhere_subquery( 'b.nr_atualizacao = ' + String(pl_nr_atualizacao), 1 )
		
		lds.of_appendwhere_subquery( 'a.nr_atualizacao = ' + String(pl_nr_atualizacao), 2 )
	else
		lds.of_appendwhere_subquery( "b.id_status_integracao = 'C' " , 1 )
		
		lds.of_appendwhere_subquery( "a.id_status_integracao = 'C' " , 2 )
	end if

	if isvalid(w_aguarde_3) Then
		ll_progresso_geral++
		w_aguarde_3.uo_progress.of_setprogress(ll_progresso_geral)
		
		w_aguarde_3.wf_settext('Buscando informa$$HEX2$$e700f500$$ENDHEX$$es do banco de dados...', 2)
	end if


	ll_Linhas = lds.Retrieve()
	// Limitador : Verificar com Tempo a necessidade
	//If ll_Linhas > 1000 then ll_Linhas = 1000
	
	if isvalid(w_aguarde_3) Then
		ll_progresso_geral++
		w_aguarde_3.uo_progress.of_setprogress(ll_progresso_geral)
	end if
	
	If ll_Linhas > 0 Then 
	
		if isvalid(w_aguarde_3) then
			
			w_aguarde_3.wf_settext('Enviando informa$$HEX2$$e700f500$$ENDHEX$$es para o SAP...', 2)
			
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_Linhas)
		end if
				
		For ll_Linha = 1 To ll_Linhas
			lb_Sucesso = False
			
			// Seta Nula as Variaveis
			SetNull(ls_XML)
			SetNull(ls_XML_Cabecalho)
			SetNull(ls_XML_Item)		
			SetNull(is_promocao)
			
			// Inicio do XML
			ls_XML =is_Inicio_XML	

			// Dados para os Campos
			is_id_tipo = lds.Object.id_tipo[ll_Linha]
			is_de_motivo_base = String(lds.Object.de_motivo[ll_Linha])
			is_item_termino_vigencia = String(Date(lds.Object.dh_termino_vigencia[ll_Linha])) 
			is_cd_produto_sap = lds.Object.cd_produto_sap[ll_Linha]
			is_filial_sap = lds.Object.id_filial_sap[ll_Linha]
			is_cd_promocao_sap = String(lds.Object.cd_promocao_sap[ll_Linha])
			il_nr_atualzacao = lds.Object.nr_atualizacao[ll_Linha]
			is_cd_promocao_planograma = String(lds.Object.cd_promocao[ll_Linha])
			il_qt_estoque = lds.Object.qt_estoque_atual[ll_Linha]
			is_matricula = lds.Object.nr_matricula_alteracao[ll_Linha]
			idh_alteracao = String(lds.Object.dh_documento[ll_Linha])
			is_origem =	lds.Object.id_alteracao[ll_Linha]
			il_qt_min_base_planograma	= lds.Object.qt_estoque_minimo_matriz[ll_Linha]
			il_cd_produto = lds.Object.cd_produto[ll_Linha]
				
			if isvalid(w_aguarde_3) Then	
				w_Aguarde_3.wf_settext( "Enviando XML " + string(ll_linha) + ' de ' + string(ll_linhas) + "..." , 2)		
				w_Aguarde_3.wf_settext( "Controle: " + string(il_nr_atualzacao) , 3)		
			end if
					
			If  IsNull(is_de_motivo_base) Then is_de_motivo_base=''
			If 	IsNull(is_item_termino_vigencia) Then is_item_termino_vigencia=''
			
			// Valida$$HEX2$$e700f500$$ENDHEX$$es Gerais dos Dados dos Campos
			If Not of_valida_dados( ref is_Log ) Then 
				lb_Sucesso = False
				Continue
			End If 			
			
			if is_item_termino_vigencia = '' Then
				//Quando a data for nula, envio uma data padr$$HEX1$$e300$$ENDHEX$$o para o SAP: Quando o SAP encontra essa data ele reconhece como nula.
				is_item_termino_vigencia = '31/12/9999'
			end if
			
			// Cabe$$HEX1$$e700$$ENDHEX$$alho XML
			ls_XML_Cabecalho = '<Cabecalho>'
			ls_XML_Cabecalho += '<id_tipo>'+is_id_tipo+'</id_tipo>'
			
			ls_XML_Item 	= 	'<Item>'
			ls_XML_Item += 	'<cd_promocao_planograma>'+is_cd_promocao_planograma+'</cd_promocao_planograma>'+&
										'<cd_promocao_sap>' +is_cd_promocao_sap+'</cd_promocao_sap>'+&
										'<cd_filial_sap>'+is_filial_sap+'</cd_filial_sap>'	+&
										'<cd_produto_sap>'	+	is_cd_produto_sap+	'</cd_produto_sap>'+&
										'<qt_estoque>'+	String(il_qt_estoque) +	'</qt_estoque>'+&
										'<dh_item_inicio_vigencia>'	+String(Date(idh_alteracao)) +	'</dh_item_inicio_vigencia>'+&
									    '<dh_item_termino_vigencia>'	+String(is_item_termino_vigencia)+	'</dh_item_termino_vigencia>'+&
										'<cd_motivo_alteracao>'	+is_de_motivo_base+ '</cd_motivo_alteracao>'+&
										'<nr_matricula>'+ is_matricula +'</nr_matricula>'+&
										'<qt_min_base_planograma>'+String(il_qt_min_base_planograma)+'</qt_min_base_planograma>'+&
										'<dh_alteracao>'+String(idh_alteracao)+'</dh_alteracao>'+&
										'<id_alteracao>'+is_origem+'</id_alteracao>'									
									
										
			If IsNull(ls_XML_Item) Then 
				is_Log	= " : XML gerado com Problemas : "
				lf_ge470_log('Nr Atualizacao:' + String(il_nr_atualzacao) + is_Log, 1, is_id_tipo , 'EST_BASE_MIN', ii_log)
				lb_Sucesso = False
			End If 
			
			// Termina o Arquivo
			ls_XML +=	ls_XML_Cabecalho
			ls_XML +=	ls_XML_Item
			ls_XML += is_Termino_Item
			ls_XML +=	is_Termino_Cabecalho  	
			ls_XML += is_Termino_XML
						
			// Grava o XML em Pasta Local
			If ls_Grava_XML = "S" Then
				of_grava_xml(String (il_nr_atualzacao) , ls_XML)
			End If
			
			// Faz o Envio do XML ao SAP
			If io_sap_comum.of_Envia_Webservice(is_URL, ls_XML, Ref ls_Xml_Retorno, Ref is_Log) Then
				
				if this.of_processa_retorno_xml( ls_xml_retorno, ref ls_mensagem) = false Then return 
				
				If isnull(ls_mensagem) or ls_mensagem = '' Then
					
					If This.of_atualiza_exportacao(il_nr_atualzacao, ref is_Log, 'PRD' , 'S','')  Then
						lb_Sucesso = True	
					else
						lb_Sucesso = false
					End If
					
				else
					
					If This.of_atualiza_exportacao(il_nr_atualzacao, ref is_Log, 'PRD' , 'E', ls_mensagem)  Then
						lb_Sucesso = True	
					else
						lb_Sucesso = false
					End If
				
				end if
					
			Else
				is_Log = "Erro no envio do XML ao SAP : uo_ge481_est_base_min_promo.of_processa_envio_est_base_min_pro : " + is_log
				lf_ge470_log('Nr Atualizacao:' + String(il_nr_atualzacao) + is_Log, 1, is_id_tipo , 'EST_BASE_MIN', ii_log)
				lb_Sucesso = False
				Continue				
			End If 							
			
			// Salva os dados Tabela Log_Exportacao_SAP
			If lb_Sucesso Then
				SqlCa.of_Commit()
			Else
				SqlCa.of_Rollback()
				lf_ge470_log('Tipo de Registro:' + is_id_tipo + ': Nr Atualizacao:' + String(il_nr_atualzacao) + is_Log, 1, is_id_tipo , 'EST_BASE_MIN', ii_log)
			End If				
			
			if isvalid(w_aguarde_3) then
				w_aguarde_3.uo_progress_2.of_setprogress(ll_Linha)					
			end if
		Next
					
	ElseIf ll_Linhas < 0 Then
		lf_ge470_log("Erro ao recuperar os dados da DW 'ds_ge481_est_base_mini_promocao' - uo_ge481_est_base_min_promo", 1, is_id_tipo, 'EST_BASE_MIN', ii_log)
		Return
	End If		

	if isvalid(w_aguarde_3) Then
		ll_progresso_geral++
		w_aguarde_3.uo_progress.of_setprogress(ll_progresso_geral)
	end if

Catch (RuntimeError lo_rte)
	MessageBox("Erro", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_processa_envio_est_base_min_promo', objeto 'uo_ge481_est_base_min_promo'. Erro: "+lo_rte.GetMessage())
	Return
Finally
	
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

	If IsValid(lds) Then Destroy lds
	Destroy lo_Comum	
	
End Try
end subroutine

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

on uo_ge481_est_base_min_promo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge481_est_base_min_promo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;of_abre_log_est_base_min_promo()
io_sap_comum = Create uo_ge470_sap_comum
lo_Comum = Create uo_ge473_comum

is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">'+&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<imp:MT_EstoqueBase_SyBASE_Request_Sync>'
							
is_Termino_XML	=	'</imp:MT_EstoqueBase_SyBASE_Request_Sync>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							


							

end event

event destructor;Destroy(io_sap_comum)
Destroy(lo_Comum)
FileClose(ii_Log)

							
end event

