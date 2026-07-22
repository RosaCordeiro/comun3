HA$PBExportHeader$uo_ge481_sap_pedido.sru
forward
global type uo_ge481_sap_pedido from nonvisualobject
end type
end forward

global type uo_ge481_sap_pedido from nonvisualobject
end type
global uo_ge481_sap_pedido uo_ge481_sap_pedido

type variables
uo_ge470_sap_comum io_sap_comum

Boolean ib_Envia_Cadastro_Completo

String is_Origem_Legado 		= "SYBASE"
Integer ii_Empresa				= 1000

//String is_Termino_Cabecalho 	= '</Cab>'
String is_Termino_Item 			= '</T_Itens>'
String is_Termino_Requisicao	= '</Item_requisicao>'

String is_URL
String is_Inicio_XML
String is_Termino_XML
String is_Arquivo_Log
String is_Ambiente_SAP = 'PRD'
String is_Pedido_De_homologacao = '200853'
String is_Pedido_Para_homologacao = '200856'
String is_pedido_remessa_homologacao

Date idh_BD_SAP_Rest

Integer	ii_log

Long il_Itens_Teste

dc_uo_ds_base ivds_pedidos

boolean ib_monitor_exp=false


//of_parametros
Boolean	ib_valida_mov_estoque_pendente	= false

Long	il_nr_atualizacao, &
		il_nr_pedido_distribuidora, &
		il_cd_filial, &
		il_nr_pedido, &
		il_nr_integracao
		
String	is_cd_distribuidora, &
			is_cd_tipo_documento
//of_parametros


end variables

forward prototypes
public function string of_monta_xml_inicio ()
public function boolean of_de_para (string as_tabela, string as_chave_legado, ref string as_chave_sap)
public function boolean of_ambiente_sap (ref string as_log)
public function boolean of_controle_envio_email (string as_cpf_cgc, ref string as_retorno_sap)
public function boolean of_abre_log_pedido ()
public subroutine of_processa_envio_pedido ()
public function boolean of_grava_log_pedido (string as_mensagem, boolean ab_envia_email)
public subroutine of_grava_xml (string as_pedido, string as_xml)
public function boolean of_monta_xml_item_requisicao (long al_pedido, long al_filial, long al_cd_produto, long al_seq_item_pedido, ref string as_xml)
public subroutine of_processa_envio_pedido (long pl_nr_pedido)
public function boolean of_atualizar_nr_pedido_sap (ref string ps_log)
public function boolean of_parametros ()
public function boolean of_monta_xml_cabecalho (string as_nr_pedido, string ad_dh_pedido, string ad_dh_remessa, string as_id_tipo_solicitacao, string as_id_tipo_pedido, string as_cd_fornecedor, string as_grp_comp, string as_org_comp, ref string as_xml_cabecalho)
public function boolean of_monta_xml_item (long al_pedido_distribuidora, long al_filial, ref string as_xml)
public function boolean of_localiza_fornecedor_sap (long al_filial, long al_pedido, ref string as_fornecedor_sap, ref string as_erro)
public function boolean of_processa_retorno_xml (string as_xml_retorno, string as_log)
public function string of_busca_valor (string as_xml, string as_tag, ref long al_pos)
public function boolean of_atualiza_exportacao (long al_filial, long al_pedido_distribuidora, string as_distribuidora, long al_nr_atualizacao_sap, ref string as_log, string as_ambiente_sap, string as_status, string as_msg)
end prototypes

public function string of_monta_xml_inicio ();/*
//primeiro 
String ls_XML_Inicio
ls_XML_Inicio = 	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">'+&
				  		'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
							'<syn:MT_CreatePO_Request>'
Return ls_XML_Inicio

*/

String ls_XML_Inicio
ls_XML_Inicio = 	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">'+&
				  		'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
							'<syn:MT_Request_Revenda>'
Return ls_XML_Inicio
end function

public function boolean of_de_para (string as_tabela, string as_chave_legado, ref string as_chave_sap);If (as_Chave_Legado = "") or IsNull(as_Chave_Legado) Then
	Return True	
End If

Select cd_chave_sap
Into :as_chave_sap
From integracao_sap
Where cd_empresa		= 1000
	and cd_tabela			= :as_tabela
	and cd_chave_legado	= :as_chave_legado
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		
		If as_tabela =   "PORTADOR" Then
			as_chave_sap = '006'
		Else
			lf_ge470_log("N$$HEX1$$e300$$ENDHEX$$o foi localizado o [de->para] da empresa:[" + String(1000) + "] - tabela:[" + as_tabela + "] - chave legado:[" + as_Chave_Legado + "]", 1, 'CL', 'CLIENTE', ii_log)
			Return False
		End If

	Case -1
		lf_ge470_log("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do [de->para] da empresa:[" + String(1000) + "] - tabela:[" + as_tabela + "] - chave legado:[" + as_Chave_Legado + "]: " + SqlCa.SqlerrText, 1, 'CL', 'CLIENTE', ii_log)
		Return False
End Choose

Return True



end function

public function boolean of_ambiente_sap (ref string as_log);return gf_ambiente_sap( ref is_ambiente_sap, ref as_log )
end function

public function boolean of_controle_envio_email (string as_cpf_cgc, ref string as_retorno_sap);Long ll_Achou
Long ll_Proximo_Seq

String ls_Log

// MUDAR			
Select count(*)
Into :ll_Achou
From log_exportacao_sap
Where cd_empresa = 1000
	and cd_chave = :as_cpf_cgc
	and cd_ambiente_sap = :is_Ambiente_SAP
	and id_tipo_log = 13
	and id_tipo_nf = 'PED'
	and dh_exportacao >  dateadd(mi, -1440, getdate()) // 6 horas
Using SqlCa;

If SqlCa.SqlCode = - 1 Then
	as_retorno_sap += "Erro ao localizar o log_exportacao_sap " + SqlCa.SqlerrText
End If

If ll_Achou = 0 Then
	// Inclui um novo log
	If Not lf_ge470_proximo_sequencial_log(ref ll_Proximo_Seq, ls_Log) Then Return False
	
	INSERT INTO log_exportacao_sap (nr_atualizacao,cd_empresa,cd_chave,id_tipo_nf,id_tipo_log,cd_filial,dh_exportacao,cd_ambiente_sap,de_erro)  
  	VALUES (:ll_Proximo_Seq,1000,:as_cpf_cgc,'CLI',13,534,getdate(),:is_Ambiente_SAP,:as_retorno_sap)  ;
	  
	If SqlCa.SqlCode = - 1 Then
		as_retorno_sap += "Erro ao incluir o log_exportacao_sap " + SqlCa.SqlerrText
	End If
	
	Sqlca.of_Commit();
Else
	// Limpa o Log para n$$HEX1$$e300$$ENDHEX$$o enviar o e-mail, s$$HEX1$$f300$$ENDHEX$$ envia novamente depois de 60 minutos
	as_retorno_sap = ''
End If

Return True

end function

public function boolean of_abre_log_pedido ();String	lvs_Path

lvs_Path = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "")

If lvs_Path <> "" Then
	
	is_Arquivo_Log = lvs_Path + "integracao_pedido_sap.log"
	
	ii_log = FileOpen(is_Arquivo_Log, LineMode!, Write!, LockWrite!)
	
	If ii_log = -1 Then		
		Return False
	End If
Else
	Return False
End If

Return True
end function

public subroutine of_processa_envio_pedido ();of_processa_envio_pedido(0)
end subroutine

public function boolean of_grava_log_pedido (string as_mensagem, boolean ab_envia_email);String lvs_Mensagem

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

public subroutine of_grava_xml (string as_pedido, string as_xml);String lvs_Path, lvs_Log

blob lbl_xml

Integer li_Log

lbl_xml = blob(as_xml)

lvs_Path = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "")

If lvs_Path <> "" Then
	
	lvs_Log = lvs_Path + as_pedido + "_"  + String(year(today()), "0000") + String(Month(today()), "00") + String(Day(today()), "00") + "_" + String(Hour(Now()), "00") +  String(Minute(Now()), "00") + String(Second ( Now() ), "00") +  ".xml"
	
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

public function boolean of_monta_xml_item_requisicao (long al_pedido, long al_filial, long al_cd_produto, long al_seq_item_pedido, ref string as_xml);String 	ls_nr_pedido,&
			ls_nr_item_pedido,&
			ls_nr_requisicao,&
			ls_nr_item_requisicao,&
			ls_cd_produto_sap,&
			ls_qt_pedido
			
Long ll_linha
Long ll_Linhas

Try 	
	
	dc_uo_ds_base			lds_requisicao_item	
	lds_requisicao_item	= 	Create dc_uo_ds_base
			
	If Not lds_requisicao_item.of_ChangeDataObject("ds_ge481_item_requisicao", False) Then
		lf_ge470_log("Erro ao alterar a DW 'ds_ge481_item_requisicao' - uo_ge481_sap_pedido", 1, 'PED', 'PEDIDO', ii_log)
		Return False
	End If
	
	ll_Linhas = lds_requisicao_item.Retrieve(al_filial, al_pedido,  al_cd_produto, al_seq_item_pedido)
		
	If ll_Linhas > 0 Then
		
		ls_nr_pedido = String(al_pedido)
				
		For ll_Linha= 1 To ll_Linhas	
			
			ls_qt_pedido			= gf_coalesce(String ( lds_requisicao_item.Object.qt_requisicao[ll_linha]),'')
			ls_nr_requisicao 		= gf_coalesce(String(lds_requisicao_item.Object.nr_requisicao[ll_linha]),'')
			ls_nr_item_requisicao	= gf_coalesce(String(lds_requisicao_item.Object.nr_item_requisacao [ll_linha]),'')
			ls_cd_produto_sap 	= gf_coalesce(String(lds_requisicao_item.Object.cd_produto_sap[ll_linha]),'')
			
			// Somente para reenviar para testar no SAP
			If (ls_nr_pedido = is_Pedido_De_homologacao) Then
				ls_nr_pedido = is_Pedido_Para_homologacao
			End If
			
		   	as_xml += 	'<Item_requisicao>'+&
							'<nr_pedido>' +ls_nr_pedido + '</nr_pedido>'+&
							'<nr_item_pedido>'+ String(al_seq_item_pedido) +'</nr_item_pedido>'+&
							'<nr_requisicao>' + ls_nr_requisicao + '</nr_requisicao>'+&
							'<nr_item_requisicao>' + ls_nr_item_requisicao +'</nr_item_requisicao>'+&
							'<cd_produto_sap>'+ls_cd_produto_sap+'</cd_produto_sap>'+&
							'<qt_pedida>'+ls_qt_pedido+'</qt_pedida>'
															
			as_xml += is_Termino_Requisicao
		Next
	
	ElseIf ll_Linhas < 0 Then
			lf_ge470_log("Erro ao recuperar os dados da DW 'ds_ge481_pedido_distribuidoras_ec_requi' - uo_ge481_sap_pedido", 1, 'PED', 'PEDIDO', ii_log)
			Return False
	End If

Catch (RuntimeError lo_rte)
	MessageBox("Erro", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_monta_xml_item_requisicao', objeto 'uo_ge481_sap_pedido'. Erro: "+lo_rte.GetMessage())
	Return False
Finally
	If IsValid(lds_requisicao_item) Then Destroy lds_requisicao_item
End Try		
	
Return True
end function

public subroutine of_processa_envio_pedido (long pl_nr_pedido);Boolean lb_Sucesso      = False

Integer li_pos

Long    ll_filial
Long    ll_Linhas
Long    ll_Linha
Long    ll_Log
Long    ll_Pedido
Long	  ll_Nr_Controle_Sap
Long	  ll_contador	

Date    ldt_dh_emissao
Date    ldt_dh_remessa
Date    ldh_Data_Pedido
Date    ldh_Inicio_SAP_CD
Date    ldh_Inicio_SAP_CD_Controlado

String  ls_tipo_solicitacao
String  ls_dh_remessa
String  ls_XML_Item
String  ls_XML
String  ls_XML_Cabecalho
String  ls_Log
String  ls_Xml_Retorno
String  ls_Fornecedor_Sap
String  ls_Grava_XML
String  ls_dh_emissao
String  ls_chave
String  ls_Pedido
String	 ls_status
String  ls_msg

dc_uo_ds_base lds
lds = Create dc_uo_ds_base

//Fecha o arquivo de log para n$$HEX1$$e300$$ENDHEX$$o dar erro quando tela do EX for utilizar o objeto, a abetura esta no construtor.
FileClose (io_sap_comum.ii_log )

gvs_Log_Geral = ''

if pl_nr_pedido > 0 then
	ib_monitor_exp = true
end if

// MUDAR DEPOIS 
	If Not of_ambiente_sap(ref ls_log) Then
		lf_ge470_log(ls_log, 1, 'PED', 'PEDIDO', ii_log)
		Return 
	End If

ls_Grava_XML = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Configuracao", "Grava_XML_Pedido", "")
ldh_Data_Pedido = RelativeDate(Date(gf_GetServerDate()), -3)

try 

	ls_Grava_XML = 'S' // grava o XML do pedido
	
/// Precisa ter a URL
	If Not gf_retorna_pametro_sap(SQLCA, is_Ambiente_SAP, 'CD_URL_PEDIDO_ENVIO', ref is_URL, ref ls_log) Then
		lf_ge470_log(ls_log, 1, 'PED', 'PEDIDO', ii_log)
		Return 
	End If

	ll_Log = FileLength(is_Arquivo_Log)
	
	If Not lds.of_ChangeDataObject("ds_ge481_pedido_distribuidora_ec_log_exp", False) Then
		lf_ge470_log("Erro ao alterar a DW 'ds_ge481_pedido_distribuidora_ec_log_exp' - uo_ge481_sap_pedido", 1, 'CL', 'CLIENTE', ii_log)
		Return
	End If
	
	If ib_monitor_exp = true Then
		lds.of_appendwhere('nr_atualizacao = ' + String(pl_nr_pedido), 1)
	End if
	
	
	If Not gf_inicio_operacao_cd_sap('DH_INICIO_CD_SAP', ref ldh_Inicio_SAP_CD, ref ls_Log) Then
		lf_ge470_log(ls_log, 1, 'PED', 'PEDIDO', ii_log)
		Return
	End If
	
	If Not gf_inicio_operacao_cd_sap('DH_INICIO_CD_SAP_CONTROLADO', ref ldh_Inicio_SAP_CD_Controlado, ref ls_Log) Then
		lf_ge470_log(ls_log, 1, 'PED', 'PEDIDO', ii_log)
		Return
	End If		
					
	ll_Linhas = lds.Retrieve()
	
	If ll_Linhas > 0 Then
		
		if ib_monitor_exp = false Then
			Open(w_Aguarde)
			w_aguarde.uo_progress.of_setmax(ll_Linhas)
			w_Aguarde.Title = "Atualizando os PEDIDOS no SAP ..."
		end if
		
		For ll_Linha = 1 To ll_Linhas
			lb_Sucesso = False
			SetNull(ls_XML)
			SetNull(ls_XML_Cabecalho)
			SetNull(ls_XML_Item)			
			
			// Inicio do XML
			ls_XML =is_Inicio_XML
			
			ls_chave					= lds.Object.cd_chave				[ll_Linha]
			ll_filial					= lds.Object.cd_filial					[ll_Linha]	
			ls_tipo_solicitacao		= lds.Object.id_reprocessar			[ll_Linha]
			ll_Nr_Controle_Sap	= lds.Object.nr_atualizacao			[ll_Linha]
			ldt_dh_emissao			= Date( gf_GetServerDate())
			ldt_dh_remessa		= RelativeDate(Date(gf_GetServerDate()), +10)
			ls_dh_emissao = String(ldt_dh_emissao, "yyyymmdd")
			ls_dh_remessa = String(ldt_dh_remessa, "yyyymmdd")
			
			li_pos = Pos(ls_chave, "@#!")
			If li_pos > 0 Then
				ls_pedido = Mid(ls_chave, li_pos + 3)
				ll_Pedido = long(ls_Pedido)
			End if
			
			If not of_localiza_fornecedor_sap(ll_filial, ll_Pedido, ref ls_Fornecedor_SAP, ref ls_log) Then
				lf_ge470_log(ls_log, 1, 'PED', 'PEDIDO', ii_log)
				Return
			End if
			
			// Cabe$$HEX1$$e700$$ENDHEX$$alho XML
			If Not This.of_monta_xml_cabecalho(	ls_Pedido, &
															ls_dh_emissao,&
															ls_dh_remessa, &
															ls_tipo_solicitacao,&
															'ZPL',&
															ls_Fornecedor_Sap,&
															'001',&
															'CL01',&
															Ref ls_XML_Cabecalho) Then Return
														
			ls_XML +=ls_XML_Cabecalho
			
			// Itens XML   ( tag item_requisicao $$HEX1$$e900$$ENDHEX$$ chamada dentro da fun$$HEX2$$e700e300$$ENDHEX$$o abaixo )
			If Not This.of_monta_xml_item(ll_Pedido, ll_filial, Ref ls_XML_Item) Then Return
			
			If IsNull(ls_XML_Item) Then Continue
			
			// Fim <\Item><\Item_Requisicao>
			ls_XML += ls_XML_Item
			
			// T$$HEX1$$e900$$ENDHEX$$rmino XML
			ls_XML += is_Termino_XML
						
			If ls_Grava_XML = "S" Then
				of_grava_xml(String (ll_Pedido) + '_' + String(ll_filial) , ls_XML)
			End If

			
			//  Quando tiver o retorno do xml d$$HEX1$$e100$$ENDHEX$$ para atualizar os dados na pedido_distribuidora
			If io_sap_comum.of_Envia_Webservice(is_URL, ls_XML, Ref ls_Xml_Retorno, Ref ls_log) Then
				ls_status = this.of_busca_valor(ls_Xml_Retorno, 'Status',  ll_contador)
				ls_msg = this.of_busca_valor(ls_Xml_Retorno, 'Mensagem',  ll_contador)
				
				If ls_status = 'S' Then
					ls_status = 'P'
				End if
				
					If This.of_atualiza_exportacao(ll_filial,  ll_Pedido, ls_Fornecedor_Sap,ll_Nr_Controle_Sap, ref ls_Log, 'PRD', ls_status,ls_msg)  Then
						lb_Sucesso = True
					End If
				
			End If 
							
			If lb_Sucesso Then
				SqlCa.of_Commit()
			Else
				SqlCa.of_Rollback()
				lf_ge470_log('Pedido Numero:' + String(ll_Pedido) + ls_log, 1, 'PED', 'PEDIDO', ii_log)
			End If
				
			if ib_monitor_exp = false then
				w_aguarde.uo_progress.of_setprogress(ll_Linha)			
			end if
			
		Next
					
	ElseIf ll_Linhas < 0 Then
		lf_ge470_log("Erro ao recuperar os dados da DW 'ds_ge481_pedido_distribuidoras_ec' - uo_ge481_sap_pedido - Erro: '" + lds.ivo_dbError.ivs_SqlErrText + "'.", 1, 'PED', 'PEDIDO', ii_log)
		Return
	End If

Catch (RuntimeError lo_rte)
	MessageBox("Erro", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_processa_envio_pedido', objeto 'uo_ge481_sap_pedido'. Erro: "+lo_rte.GetMessage())
	Return
Finally
	
	If not gvb_Auto and ib_monitor_exp Then
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
end try
end subroutine

public function boolean of_atualizar_nr_pedido_sap (ref string ps_log);long ll_linhas, ll_nr_pedido_empurrado, ll_nr_pedido_sap, ll_for, ll_cd_filial
dc_uo_ds_base luo_dados

luo_dados = create dc_uo_ds_base

luo_dados.of_changedataobject( 'ds_ge481_pedido_empurrado_sap' )

ll_linhas = luo_dados.retrieve( )

if ll_linhas < 0 Then
	ps_log = this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_atualizar_nr_pedido_sap ~n' + 'Problemas ao atualizar a tabela "pedido_empurrado": ' + sqlca.sqlerrtext
end if

for ll_for = 1 to ll_linhas

	ll_cd_filial = luo_dados.object.cd_filial[ll_for]
	ll_nr_pedido_empurrado = luo_dados.object.nr_pedido_empurrado[ll_for]
	ll_nr_pedido_sap = luo_dados.object.nr_pedido_sap[ll_for]
	
	if ll_nr_pedido_sap = -1 then
	
		//Gera o numero do pedido.
		//Deve chamar o mesmo processo da gera$$HEX2$$e700e300$$ENDHEX$$o do nr_pedido_distribuidora.
		If Not gf_ge040_proximo_pedido_distribuidora(ref ll_nr_pedido_sap, ref ps_log) then return false
	
		if ll_nr_pedido_sap > 0 then
	
			update pedido_empurrado
				set nr_pedido_sap = :ll_nr_pedido_sap
			where cd_filial = :ll_cd_filial
				and nr_pedido_empurrado = :ll_nr_pedido_empurrado;
			
				if sqlca.sqlcode = -1 then
					ps_log = 'Objeto: ' + this.classname( ) + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_atualizar_nr_pedido_sap ~n' + 'Problemas ao atualizar a tabela "pedido_empurrado": ' + sqlca.sqlerrtext
					return false
				end if

			Commit;

		end if
		
	end if

next


Return true 
end function

public function boolean of_parametros ();BOOLEAN ib_usa_cabecalho
STRING is_ds,is_objeto,is_nome_arquivo,is_parametro_url,is_tipo_log_exp,is_descricao_tipo_log,is_nome_interface
integer ii_contador_xml

//override
is_inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">'+&
   						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<imp:MT_ORDEMREMESSANF_REQ>'


is_termino_XML	=	'</imp:MT_ORDEMREMESSANF_REQ>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
ib_usa_cabecalho = False
is_ds = 'ds_ge481_wms_pedido_transferencia'
is_objeto = this.ClassName()
is_nome_arquivo = 'wms_pedido_transferencia'
is_parametro_url = 'CD_URL_WMS_ORDEM_VENDA'
is_tipo_log_exp = 'ENVIO_PEDIDO_TRANSFERENCIA'
is_descricao_tipo_log = 'ENVIO_PEDIDO_TRANSFERENCIA'
is_nome_interface = 'ENVIO_PEDIDO_TRANSFERENCIA'

// Subir um documento por vez
ii_contador_xml = 1

return True
end function

public function boolean of_monta_xml_cabecalho (string as_nr_pedido, string ad_dh_pedido, string ad_dh_remessa, string as_id_tipo_solicitacao, string as_id_tipo_pedido, string as_cd_fornecedor, string as_grp_comp, string as_org_comp, ref string as_xml_cabecalho);String	ls_XML_Cabecalho

Try 
	
		// Somente para reenviar para testar no SAP
		If (as_nr_pedido = is_Pedido_De_homologacao) Then
			as_nr_pedido = is_Pedido_Para_homologacao
		End If
		
		If Not IsNull(is_pedido_remessa_homologacao)  and is_pedido_remessa_homologacao <> '' Then
			ad_dh_pedido = is_pedido_remessa_homologacao
		End If
	
		If Not IsNull(as_nr_pedido) and Not IsNull(as_id_tipo_pedido) Then 
			ls_XML_Cabecalho += '<Cab>'+&
										'<NR_SOLICITACAO>'+as_nr_pedido+'</NR_SOLICITACAO>'+&
										'<DT_SOLIC>'+ad_dh_pedido+'</DT_SOLIC>'	+&	
										'<DT_REMESSA>'+ad_dh_remessa+'</DT_REMESSA>'	+&	
										'<TP_PO>' +as_id_tipo_pedido+'</TP_PO>'+&
										'<FORNEC>'+as_cd_fornecedor+'</FORNEC>'+&
										'<GRP_COMP>'+as_grp_comp+'</GRP_COMP>'+&			
										'<ORG_COMP>'+as_org_comp+'</ORG_COMP>'+&
										'<TP_SOLIC>' +as_id_tipo_solicitacao+'</TP_SOLIC>'+&
										 '</Cab>'
			as_XML_cabecalho = ls_XML_Cabecalho
		Else
			lf_ge470_log("Erro ao recuperar os dados do Cabe$$HEX1$$e700$$ENDHEX$$alho 'ds_ge481_pedido_distribuidoras_ec' - uo_ge481_sap_pedido", 1, 'PED', 'PEDIDO', ii_log)
			Return False
		End If
	Catch (RuntimeError lo_rte)
		MessageBox("Erro", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_monta_xml_cabecalho', objeto 'uo_ge481_sap_pedido'. Erro: "+lo_rte.GetMessage())
		Return False
	Finally		
End Try	


Return True

end function

public function boolean of_monta_xml_item (long al_pedido_distribuidora, long al_filial, ref string as_xml);DateTime ldh_Exporta_SAP
Decimal 	ldc_Fat_Conv
Long 		ll_Linhas_item, ll_Linha, ll_cd_filial_legado, ll_cd_produto_legado, ll_Achou, &
			ll_qt_embalagem_padrao_distrib
String	ls_XML_Item, ls_XML_Item_Requisicao, ls_Log, ls_MSG, ls_DW, ls_Tipo_Cliente, &
			ls_nr_pedido, ls_nr_iteml, ls_cd_produto_sap, ls_qt_pedido, ls_filial_transf, &
			ls_fornecedor, ls_cd_filial_sap, ls_vl_preco, ls_pc_repasse_icms, ls_pc_desconto,&
			ls_tipo_pedido, ls_cond_pgto, ls_Data_Pedido, ls_cd_origem_produto, ls_cd_produto_legado, &
			ls_Data_Remessa, ls_nr_requisicao, ls_nr_item_requisicao, ls_pc_desconto_financ , &
			ls_pc_desconto_midia, ls_UM_Compra


Try 
	dc_uo_ds_base lds_item	
	
	lds_item = Create dc_uo_ds_base
	
	ls_DW = 'ds_ge481_pedido_distribuidoras_ec_item'

		
	If Not lds_item.of_ChangeDataObject(ls_DW, False) Then
		lf_ge470_log("Erro ao alterar a DW '" + ls_DW + "' - uo_ge481_sap_pedido", 1, 'PED', 'PEDIDO', ii_log)
		Return False
	End If
		
	ll_Linhas_item = lds_item.Retrieve(al_pedido_distribuidora, al_filial )
	
	If ll_Linhas_item > 0 Then
		ls_XML_Item = ''	
		
		For ll_Linha= 1 To ll_Linhas_item
			ls_nr_pedido							= gf_coalesce(string(al_pedido_distribuidora),'')
			ls_nr_iteml								= gf_coalesce(string(lds_item.Object.nr_item						[ll_Linha]),'')
			ls_cd_produto_sap						= gf_coalesce(string(lds_item.Object.cd_produto_sap			[ll_Linha]),'')
			ls_qt_pedido 							= gf_coalesce(string(lds_item.Object.qt_pedida					[ll_Linha]), '')
			ls_cd_filial_sap							= gf_coalesce(string(lds_item.Object.cd_filial_sap					[ll_Linha]), '')
			ls_vl_preco 								= gf_coalesce (string(lds_item.Object.vl_preco						[ll_Linha]),'')
			ls_pc_repasse_icms					= gf_coalesce (string( lds_item.Object.pc_repasse_icms			[ll_Linha]),'')
			ls_pc_desconto							= gf_coalesce (string (lds_item.Object.pc_desconto				[ll_Linha]),'')
			ls_cd_origem_produto				= gf_coalesce(string(lds_item.Object.cd_origem_produto		[ll_Linha]),'')
			ls_pc_desconto_financ				= gf_coalesce (string( lds_item.Object.pc_desconto_financeiro	[ll_Linha]),'')
			ls_pc_desconto_midia					= gf_coalesce (string( lds_item.Object.pc_desconto_midia		[ll_Linha]),'')
			ls_Data_Remessa 						= String(lds_item.Object.dh_remessa									[ll_Linha])
			ll_cd_filial_legado						= lds_item.Object.cd_filial												[ll_Linha]
			ll_cd_produto_legado					= lds_item.Object.cd_produto_legado									[ll_Linha]			
			ldc_Fat_Conv							= lds_item.Object.vl_fator_conversao									[ll_Linha]
			ll_qt_embalagem_padrao_distrib	= lds_item.Object.qt_embalagem_padrao_distrib					[ll_Linha]
			
			ls_vl_preco					= gf_replace(ls_vl_preco, ',', '.', 0)
			ls_pc_repasse_icms		= gf_replace(ls_pc_repasse_icms, ',', '.', 0)
			ls_pc_desconto				= gf_replace(ls_pc_desconto, ',', '.', 0)
			ls_pc_desconto_financ	= gf_replace(ls_pc_desconto_financ, ',', '.', 0)
			ls_pc_desconto_midia		= gf_replace(ls_pc_desconto_midia, ',', '.', 0)

			If IsNull(ls_cd_produto_sap) or trim(ls_cd_produto_sap)  ='' Then Continue
			
			if ll_qt_embalagem_padrao_distrib > 1 then
				ls_UM_Compra = 'CXD'
			else
				If ldc_Fat_Conv > 1 Then
					ls_UM_Compra = 'CXU'
				Else
					ls_UM_Compra = 'UN'
				End If
			end if
									
			// Somente para reenviar para testar no SAP
			If (ls_nr_pedido = is_Pedido_De_homologacao) Then
				ls_nr_pedido = is_Pedido_Para_homologacao
			End If
			
			If Not IsNull(is_pedido_remessa_homologacao)  and is_pedido_remessa_homologacao <> '' Then
				ls_Data_Remessa = is_pedido_remessa_homologacao
			End If
						
			ls_XML_Item += 	'<T_Itens>'+&
										'<NR_ITEM>'+ls_nr_iteml +'</NR_ITEM>'+&
										'<MATERIAL>'+ls_cd_produto_sap +'</MATERIAL>'+&
										'<QT_SOLIC>'+ls_qt_pedido+'</QT_SOLIC>'+&
										'<UN_SOLIC>'+ls_UM_Compra +'</UN_SOLIC>'+&
										'<VL_BRUTO>'+ ls_vl_preco +'</VL_BRUTO>'+&
										'<CENTRO>'+'1156'+'</CENTRO>' 
								//		'<RA00>'+ls_pc_desconto+'</RA00>'	
																
				If Not This.of_monta_xml_item_requisicao(	al_pedido_distribuidora, &
																		al_filial, &
																		ll_cd_produto_legado, &
																		lds_item.Object.nr_item [ll_Linha], &
																		Ref ls_XML_Item) Then
					Return False
				End If
									
			ls_XML_Item +=  is_Termino_Item						
		Next 
		
		as_xml = ls_XML_Item 
		
		If IsNull(as_xml)	Then 
			lf_ge470_log("Algum valor anulou o XML na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml_item - uo_ge481_sap_pedido", 1, 'PED', 'PEDIDO', ii_log)
			Return False
		End If		
		
	ElseIf ll_Linhas_item < 0 Then
			lf_ge470_log("Erro ao recuperar os dados da DW 'ds_ge481_pedido_distribuidoras_ec_item' - uo_ge481_sap_pedido", 1, 'PED', 'PEDIDO', ii_log)
			Return False
			
	ElseIf ll_Linhas_item = 0 Then
			lf_ge470_log(" N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ produtos com qt_atendida maior que 0 no pedido: "+string(al_pedido_distribuidora)+".", 1, 'PED', 'PEDIDO', ii_log)
			Return False
	End If

Catch (RuntimeError lo_rte)
	MessageBox("Erro", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_monta_xml_item', objeto 'uo_ge481_sap_pedido'. Erro: "+lo_rte.GetMessage())
	Return False
Finally	
	If IsValid(lds_item) Then Destroy lds_item
	
End Try	

Return True
end function

public function boolean of_localiza_fornecedor_sap (long al_filial, long al_pedido, ref string as_fornecedor_sap, ref string as_erro);Select f.cd_fornecedor_sap
Into :as_fornecedor_sap
From pedido_distribuidora pd
Inner join fornecedor f
On pd.cd_distribuidora = f.cd_fornecedor
Where pd.cd_filial						= :al_Filial
And	pd.nr_pedido_distribuidora	= :al_Pedido
Using SQLCA;

Choose Case SqlCa.SqlCode
	Case is < 0 // Erro
		as_erro = "Erro ao procurar fornecedor do pedido: "+string(al_Pedido)+"da filial: "+string(al_Filial) + SqlCa.SqlerrText
		Return False
		
	Case 100 // N$$HEX1$$e300$$ENDHEX$$o achou
			as_erro = "Fornecedor do pedido: "+string(al_Pedido)+"da filial: "+string(al_Filial) +" n$$HEX1$$e300$$ENDHEX$$o localizado." + SqlCa.SqlerrText
			Return False
			
End Choose

Return True
end function

public function boolean of_processa_retorno_xml (string as_xml_retorno, string as_log);Long 		ll_contador = 1
String 	ls_status


//Aguardar para ver a mensagem real do retorno
ls_status = io_sap_comum.of_busca_valor(as_xml_retorno, '<STATUS>', ref ll_contador)

if ls_status <> 'Integrado com Sucesso' then	
//	io_sap_comum.of_atualiza_processado( il_nr_atualizacao, 'E', ls_status, ref as_log)
else
//	if Not io_sap_comum.of_atualiza_processado( il_nr_atualizacao, 'S', ls_status, ref as_log) then return false
end if

return true
end function

public function string of_busca_valor (string as_xml, string as_tag, ref long al_pos);//string ls_retorno
//string  ls_Xml_Aux
//long ll_pos1, ll_pos2
//
//as_Tag = gf_Replace(as_Tag, '/', '', 0)
//as_Tag = gf_Replace(as_Tag, '<', '', 0)
//as_Tag = gf_Replace(as_Tag, '>', '', 0)
//
//ls_Xml_Aux = as_xml
//
//ll_pos1 = Pos(ls_Xml_Aux, '<'+as_tag+'>', al_pos)
//ll_pos2 = Pos(ls_Xml_Aux, '</'+as_tag+'>', al_pos)
//
// ls_retorno = Mid(	ls_Xml_Aux,  ll_pos1 + LenA(as_tag)+2, ll_pos2 - ( ll_pos1 + LenA(as_tag)+2))
//
//al_pos = ll_pos2
//
//
//return ls_retorno

string ls_retorno
string ls_Xml_Aux
long ll_pos1, ll_pos2

// Se al_pos for <= 0, come$$HEX1$$e700$$ENDHEX$$a do in$$HEX1$$ed00$$ENDHEX$$cio
IF al_pos <= 0 THEN al_pos = 1

// Limpa a tag
as_Tag = gf_Replace(as_Tag, '/', '', 0)
as_Tag = gf_Replace(as_Tag, '<', '', 0) 
as_Tag = gf_Replace(as_Tag, '>', '', 0)

////////////////////////////////////////////////////////
blob lblob_utf8

lblob_utf8 = Blob(as_xml, EncodingUTF8!)

ls_Xml_Aux = String(lblob_utf8, EncodingUTF8!)

//ls_Xml_Aux = as_xml

ll_pos1 = Pos(ls_Xml_Aux, '<'+as_tag+'>', al_pos)
ll_pos2 = Pos(ls_Xml_Aux, '</'+as_tag+'>', al_pos)

// Verifica se encontrou as tags
IF ll_pos1 = 0 OR ll_pos2 = 0 THEN
    al_pos = 0  // Indica que n$$HEX1$$e300$$ENDHEX$$o encontrou
    RETURN ""
END IF

ls_retorno = Mid(ls_Xml_Aux, ll_pos1 + LenA(as_tag)+2, ll_pos2 - (ll_pos1 + LenA(as_tag)+2))
al_pos = ll_pos2

RETURN ls_retorno
end function

public function boolean of_atualiza_exportacao (long al_filial, long al_pedido_distribuidora, string as_distribuidora, long al_nr_atualizacao_sap, ref string as_log, string as_ambiente_sap, string as_status, string as_msg);//If as_ambiente_sap <> 'PRD' Then Return True

	If as_status = 'P' Then 
	
		Update	pedido_distribuidora 
		Set dh_exportacao_sap	= getdate(),
			 id_exportacao_sap	= 'I'
		From pedido_distribuidora pd
		Inner join fornecedor f on pd.cd_distribuidora = f.cd_fornecedor
		Where pd.nr_pedido_distribuidora = :al_pedido_distribuidora
		  And pd.cd_filial						= :al_filial
		  And f.cd_fornecedor_sap			= :as_distribuidora
		Using SQLCA;
		
		Update log_exportacao_sap
			Set	id_status_integracao = :as_status, 
					dh_exportacao		   = getdate()
		 Where nr_atualizacao		= :al_nr_atualizacao_sap
		Using SQLCA;		
		
		//log_exportacao_sap 
	Else
	
		Update pedido_distribuidora
		Set id_exportacao_sap = 'R' , 
			 de_erro_envio_sap = 'Erro no Envio das Informa$$HEX2$$e700f500$$ENDHEX$$es ao SAP'
		From pedido_distribuidora pd
		Inner join fornecedor f on pd.cd_distribuidora = f.cd_fornecedor
		Where pd.nr_pedido_distribuidora = :al_pedido_distribuidora
		  And pd.cd_filial						= :al_filial
		  And f.cd_fornecedor_sap			= :as_distribuidora
		Using SQLCA;
		
		Update log_exportacao_sap
			Set id_status_integracao	= :as_status, 
				 dh_exportacao			= getdate(),
				 de_erro					=  'Erro no Envio das Informa$$HEX2$$e700f500$$ENDHEX$$es ao SAP: ' + :as_msg 
		 Where nr_atualizacao = :al_nr_atualizacao_sap
		Using SQLCA;
		
	End If 
				
	If SqlCa.Sqlcode = -1 Then
		as_log += "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o dos campos de exportacao na tabela 'pedido_distribuidora', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_atualiza_exportacao': " + SqlCa.SqlerrText
		Return False
	End If
	

Return True



end function

on uo_ge481_sap_pedido.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge481_sap_pedido.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;/*
of_Abre_Log_Pedido()

io_sap_comum = Create uo_ge470_sap_comum

is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com" xmlns:syn="http://Criar_Pedido/SyncSOAP2Proxy">' + &
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<syn:MT_CreatePO_Request>'
							
is_Termino_XML	=	'</syn:MT_CreatePO_Request>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'


of_Abre_Log_Pedido()

io_sap_comum = Create uo_ge470_sap_comum

is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com" xmlns:syn="http://Criar_Pedido_Revenda/SyncSOAP2Proxy">' + &
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<syn:MT_Request_Revenda>'
							
is_Termino_XML	=	'</syn:MT_Request_Revenda>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
*/
of_Abre_Log_Pedido()

io_sap_comum = Create uo_ge470_sap_comum


is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:syn="http://Criar_Pedido_Revenda/SyncSOAP2Proxy">' + &
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<syn:MT_Request_Revenda>'
							
is_Termino_XML	=	'</syn:MT_Request_Revenda>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
end event

event destructor;Destroy(io_sap_comum)

FileClose(ii_Log)
end event

