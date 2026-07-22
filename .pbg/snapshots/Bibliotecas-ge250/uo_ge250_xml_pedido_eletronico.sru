HA$PBExportHeader$uo_ge250_xml_pedido_eletronico.sru
forward
global type uo_ge250_xml_pedido_eletronico from nonvisualobject
end type
end forward

global type uo_ge250_xml_pedido_eletronico from nonvisualobject
end type
global uo_ge250_xml_pedido_eletronico uo_ge250_xml_pedido_eletronico

type variables
Boolean ib_Importa_Sem_Pedido 	= False
Boolean ib_valida_teste_integrado = False
Boolean ib_Download_Sefaz		= False
Boolean ib_Importacao_Manual	= False
Boolean ib_Imp_Manual_Sem_Pedido_Conexao = False
boolean ib_marreta_reposicao_sta = False	// as vezes a STA envia XML sem a XVAN com a identica$$HEX2$$e700e300$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o
														// para a inclus$$HEX1$$e300$$ENDHEX$$o do pedido central

Boolean ib_envio_email = True 
Boolean ib_sem_xvan = False
Long il_Filial_Auxiliar
String is_Forn_Auxiliar

String is_ftp_xml_endereco, is_ftp_xml_usuario, is_ftp_xml_senha

dc_uo_transacao iuo_SqlCa_log

Long il_Tempo_Notas_Distrib
end variables

forward prototypes
public subroutine of_busca_xml_ftp (integer ai_log)
public subroutine of_envia_email (string as_mensagem)
public function boolean of_diretorio_importacao_xml (ref string as_diretorio)
public function boolean of_busca_xmls (dc_uo_ds_base ads)
public function boolean of_parametro_conexao_ftp ()
public function boolean of_verifica_nf_ja_validada (string as_chave_acesso, string as_tipo, ref string as_nf_validada, ref string as_mensagem_log)
public function boolean of_limpa_pasta_importacao (string as_diretorio, ref string as_mensagem_log)
public function boolean of_fornecedor_importa_nfe_compra_pendent (string as_cnpj_origem, ref string as_importa_nfe_compra_pendente, ref string as_erro)
public function boolean of_fecha_conexao_log ()
public function boolean of_grava_log (integer ai_arquivo, string as_mensagem)
public function boolean of_grava_log (integer ai_arquivo, string as_mensagem, boolean ab_envia_email, boolean ab_grava_arquivo)
public function boolean of_abre_conexao_log (ref string ps_log)
public function boolean of_atualiza_recebimento (string as_recebimento, ref string as_log)
public function boolean of_verifica_fornecedor_ativo (string ps_fornecedor, ref string ps_msg)
public function boolean of_verifica_nf_ja_importada (string ps_chave, ref string ps_msg)
public function boolean of_parametro_dias_pedido (ref integer ai_dias, ref string as_log)
public function boolean of_parametro_tempo_horas (ref long al_tempo, ref string as_log)
public function boolean of_tempo_horas_nota (string as_chave, ref long al_tempo_horas, ref string as_log)
public subroutine of_grava_log_bd (long al_filial, string as_fornecedor, long al_nota, long al_pedido, date adh_emissao, string as_chave_acesso, string as_mensagem, string as_resolvido, datetime adh_resolvido)
public function boolean of_verifica_destinadas (string ps_chave, ref string ps_msg)
public function boolean of_verifica_log_importacao_resolvido (string as_chave_acesso, ref string as_resolvido, ref string as_mensagem_log)
public function boolean of_cfop_simples_remessa (string as_chave_acesso, string as_diretorio_leitura)
public function boolean of_processa_atualizacao (string as_chave_auxiliar)
end prototypes

public subroutine of_busca_xml_ftp (integer ai_log);Long ll_Linha_Distribuidora
Long ll_Row

Time lt_Agora

String ls_Fornecedor
String ls_Fornecedor_Anterior
String ls_Log

// N$$HEX1$$e300$$ENDHEX$$o baixa da $$HEX1$$e100$$ENDHEX$$rea FTP da distribuidora quando for estoque
If il_Filial_Auxiliar = 534 Then Return

//Busca FTP distribuidora
dc_uo_ds_base lds_Distribuidoras
lds_Distribuidoras = Create dc_uo_ds_base

If Not lds_Distribuidoras.of_ChangeDataObject("ddw_fornecedor_distribuidora") Then
	Destroy( lds_Distribuidoras )
	Return	
End If

// Desenvolvimento
//lds_Distribuidoras.of_AppendWhere("cd_fornecedor = '053405477'", 1)
//lds_Distribuidoras.of_AppendWhere("cd_fornecedor = '053405477'", 2)

ll_Linha_Distribuidora = lds_Distribuidoras.Retrieve()

If ll_Linha_Distribuidora < 0 Then
	of_Grava_Log(ai_Log, "Erro no RETRIEVE lista distribuidora.")
End If

Open(w_Aguarde)
w_Aguarde.Title = "Localizando XML na $$HEX1$$e100$$ENDHEX$$rea FTP, aguarde..."


If ll_Linha_Distribuidora > 0 Then
	
	lds_Distribuidoras.SetSort("cd_fornecedor")
	lds_Distribuidoras.Sort()
	
	lt_Agora = Now()
	
	//Desenvolvimento
	//lt_Agora = Time("14:00:00")
	
	For ll_Row = 1 TO ll_Linha_Distribuidora
	
		ls_Log = ""
	
		ls_Fornecedor = lds_Distribuidoras.Object.cd_fornecedor[ ll_Row ]
		
		If ls_Fornecedor = "053404705" Or ls_Fornecedor = "053405371" Or ls_Fornecedor = "053405357" Or ls_Fornecedor = "053405274" Then Continue
		
		If ls_Fornecedor_Anterior <> ls_Fornecedor Then
				
			//Enquanto estiver gerando pedido n$$HEX1$$e300$$ENDHEX$$o conecta na $$HEX1$$e100$$ENDHEX$$rea FTP das distribuidoras
			If lt_Agora < Time('13:20:00') Or lt_Agora > Time('18:00:00') Then 
				
				w_Aguarde.Title = "Realizando download XML, Distribuidora:  '" + ls_Fornecedor + "' ..."
				
				dc_uo_xml_ftp_fornecedor lvo_Xml_Ftp_Fornecedor
				lvo_Xml_Ftp_Fornecedor = Create dc_uo_xml_ftp_fornecedor
				
				lvo_Xml_Ftp_Fornecedor.ii_Log = ai_Log
				
				If Not lvo_Xml_Ftp_Fornecedor.of_Move_XML(ls_Fornecedor, Ref ls_Log) Then
					of_Grava_Log(ai_Log, ls_Log)
				End If
				
				ls_Log = ""
				
				If Not lvo_Xml_Ftp_Fornecedor.of_busca_xml_fornecedor(ls_Fornecedor, Ref ls_Log) then
					of_Grava_Log(ai_Log, ls_Log)	
				End If
				
				Destroy(lvo_Xml_Ftp_Fornecedor)
					
			End If
			
			ls_Fornecedor_Anterior = ls_Fornecedor
			
		End If

	Next
	
End If

ls_Fornecedor 				= ""
ls_Fornecedor_Anterior 	= ""

Destroy( lds_Distribuidoras )
Close( w_Aguarde )
end subroutine

public subroutine of_envia_email (string as_mensagem);///

end subroutine

public function boolean of_diretorio_importacao_xml (ref string as_diretorio);If il_Filial_Auxiliar = 534 Then
	as_diretorio = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, 'Diretorio', 'xmlimportacao_EC', "")
Else
	as_diretorio = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, 'Diretorio', 'XMLImportacao', "")
End If

If as_Diretorio <> "" Then
	If Not DirectoryExists( as_Diretorio) Then
		If CreateDirectory(as_Diretorio ) = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio para a importa$$HEX2$$e700e300$$ENDHEX$$o do XML '" + as_Diretorio + "'.")
			Return False
		End If
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro  'XMLImportacao' n$$HEX1$$e300$$ENDHEX$$o localizado no INI da aplica$$HEX2$$e700e300$$ENDHEX$$o.")
	Return False
End If

Return True
end function

public function boolean of_busca_xmls (dc_uo_ds_base ads);Boolean lb_Localizado, lb_Download_Sefaz_Auto = False, lb_erro = False

Date			lvdt_Emissao

DateTime	ldt_Resolvido
		
String	ls_Chave_Acesso,&
			ls_Mensagem_Erro,&
			ls_Ano,&
			ls_Mes,&
			ls_Dia,&
			ls_Cnpj,&
			ls_Arquivo_Xml,&
			ls_Mensagem,&
			ls_Diretorio,&
			ls_Path_XML,&
			ls_Fornecedor,&
			ls_Importa_Nfe_Compra_Pendente,&
			ls_Verificado_Diverg_Ped,&
			ls_Distribuidora,&
			ls_Tipo,&
			ls_Arquivo,&
			ls_Permite_Nota_Sem_Pedido,&
			ls_Resolvido
			
Long	ll_Linhas, ll_Linha, ll_Contador, ll_Ano, ll_Mes, ll_Dia, ll_Nota, ll_Filial, ll_Nulo, ll_Cont_Array, ll_Notas_Sefaz, ll_Tempo_Nota

String ls_Chave_Acesso_Array[], ls_Anexo[]

Long ll_Filial_Array[]

Time lvt_Agora

SetNull(ll_Nulo)

ll_Linhas = ads.RowCount()

lvt_Agora = Now()

dc_uo_ftp lo_Ftp

If Not This.of_Diretorio_Importacao_XML(ref ls_Path_XML) Then Return False

try
	
	Open(w_Aguarde_1)
	
	w_Aguarde_1.uo_Progress.of_setmax(ll_Linhas)

	lo_Ftp = Create dc_uo_ftp 
	
	For ll_Linha = 1 To ll_Linhas
		
		w_Aguarde_1.Title = "Baixando XML ... " + String(ll_Linha) + " de " + String(ll_Linhas)
		
		ls_Chave_Acesso					= ads.Object.de_chave_acesso						[ll_Linha]
		lvdt_Emissao						= Date(ads.Object.dh_emissao						[ll_Linha])
		ll_Nota								= Long(ads.Object.nr_nf								[ll_Linha])
		ll_Filial								= ads.Object.cd_filial									[ll_Linha]
		ls_Fornecedor						= ads.Object.cd_fornecedor							[ll_Linha]
		ls_Verificado_Diverg_Ped		= ads.Object.id_verificado_divergencia_ped		[ll_Linha]
		ls_Distribuidora 					= ads.Object.id_distribuidora						[ll_Linha]	
		ls_Tipo								= ads.Object.Tipo										[ll_Linha]
		ls_Permite_Nota_Sem_Pedido	= ads.Object.id_permite_nota_sem_pedido		[ll_Linha]
		
		if ib_valida_teste_integrado then
			if IsNull(ls_Chave_Acesso) then
				ls_Mensagem	= 'Chave de Acesso Nula.'
				w_Aguarde_1.uo_Progress.of_setprogress(ll_Linha)
				of_grava_log_bd(ll_Filial, ls_Fornecedor, ll_Nota, ll_Nulo, lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
				Continue
			end if
			
			select de_chave_acesso_alterada
			  into :ls_Chave_Acesso
			  from recebimento_sap
			 where de_chave_acesso = :ls_Chave_Acesso
			using SQLCA;
			
			lb_erro	= False
			
			Choose Case SQLCA.SQLCode
				Case -1
					ls_Mensagem	= 'Erro ao localizar a chave de acesso do recebimento SAP. ' + SQLCA.SQLErrText
					lb_erro	= True
				Case 100
					ls_Mensagem	= 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar a chave de acesso do recebimento SAP.'
					lb_erro	= True
			End Choose

			if lb_erro then
				w_Aguarde_1.uo_Progress.of_setprogress(ll_Linha)
				of_grava_log_bd(ll_Filial, ls_Fornecedor, ll_Nota, ll_Nulo, lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
				Continue
			end if
			
			if IsNull(ls_Chave_Acesso) then
				ls_Mensagem	= 'Chave de Acesso origem Nula.'
				w_Aguarde_1.uo_Progress.of_setprogress(ll_Linha)
				of_grava_log_bd(ll_Filial, ls_Fornecedor, ll_Nota, ll_Nulo, lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
				Continue
			end if
		end if
		
		// Foi alterado o SQL da dw_ge250_lista_destinadas para pegar os XML  da filial 534 de fornecedores n$$HEX1$$e300$$ENDHEX$$o cadastrados.
		// Como come$$HEX1$$e700$$ENDHEX$$ou a gravar no agendamento notas indevidas de produtos n$$HEX1$$e300$$ENDHEX$$o comercializados foi colocado este controle para ignorar.
		If IsNull(ls_Fornecedor) Then
			w_Aguarde_1.uo_Progress.of_setprogress(ll_Linha)
			Continue
		End If
		
		If ls_Tipo = 'CTE' Then
			ls_Arquivo_Xml = ls_Chave_Acesso+"-cte.xml"
		Else
			ls_Arquivo_Xml = ls_Chave_Acesso+"-nfe.xml"
		End If
		
		If ll_Contador = 0 Then
			w_Aguarde_1.Title = "Baixando XML ... " + String(ll_Linha) + " de " + String(ll_Linhas) + '. <<< Conectando FTP >>>'
			lo_Ftp.of_Desconecta_ftp()
					
			If Not lo_Ftp.of_Conecta_ftp("RO", is_ftp_xml_endereco, is_ftp_xml_usuario, is_ftp_xml_senha, Ref ls_Mensagem) Then
				w_Aguarde_1.uo_Progress.of_setprogress(ll_Linha)
				of_grava_log_bd(ll_Filial, ls_Fornecedor, ll_Nota, ll_Nulo, lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
				Return False
			End If
			
			w_Aguarde_1.Title = "Baixando XML ... " + String(ll_Linha) + " de " + String(ll_Linhas)
		End If
		
		If ls_Tipo <> 'CTE' Then
			//Verifica se o fornecedor est$$HEX1$$e100$$ENDHEX$$ amrcado para importar a nota para a tabela nfe_compra_pendente, antes era apenas Quimidrol
			If Not of_Fornecedor_Importa_Nfe_Compra_Pendent(Mid(ls_Chave_Acesso, 7, 14), Ref ls_Importa_Nfe_Compra_Pendente, Ref ls_Mensagem) Then
				of_grava_log_bd(ll_Filial, ls_Fornecedor, ll_Nota, ll_Nulo, lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
				Return False
			End If
			
			// Se n$$HEX1$$e300$$ENDHEX$$o existir o arquivo / Estoque j$$HEX1$$e100$$ENDHEX$$ verificado diverg$$HEX1$$ea00$$ENDHEX$$ncia / Adicionado o CNPJ 84704683000662 da QUIMIDROL de Curitiba
			If	(FileExists(ls_Path_XML+ls_Arquivo_Xml) ) or &
				(ll_Filial = 534 and ls_Verificado_Diverg_Ped = 'S') or &
				((ll_Filial <> 534) and ((ls_Distribuidora = 'N' and ls_Permite_Nota_Sem_Pedido = "N")) and  &
				(ls_Importa_Nfe_Compra_Pendente <> "S")) Then
				
				ll_Contador ++	
				
				If ll_Contador >= 200 Then ll_Contador = 0
				
				w_Aguarde_1.uo_Progress.of_setprogress(ll_Linha)
				Continue
			End If
		End If
						
		If  lo_Ftp.of_ftp_set_dir('/',Ref ls_Mensagem_Erro)  = -1 Then
			ls_Mensagem = "Erro ao voltar ao diret$$HEX1$$f300$$ENDHEX$$rio raiz."
			of_grava_log_bd(ll_Filial, ls_Fornecedor, ll_Nota, ll_Nulo, lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
			Return False		
		End If
		
		ll_Ano = Year(lvdt_Emissao)
		ll_Mes = Month(lvdt_Emissao)
		ll_Dia = Day(lvdt_Emissao)
				
		ls_Ano = "Ano_"+String(ll_Ano)
		If ll_Mes < 10 Then ls_Mes = "Mes_0"+String(ll_Mes) Else ls_Mes = "Mes_"+String(ll_Mes)
		If ll_Dia < 10 Then ls_Dia = "Dia_0"+String(ll_Dia) Else ls_Dia = "Dia_"+String(ll_Dia)
		ls_Cnpj = Mid(ls_Chave_Acesso, 7, 14)

		If ls_Tipo = "CTE" Then
			ls_Diretorio = "CT-e/" + ls_Ano + "/" + ls_Mes + "/" + ls_Dia + "/" + ls_CNPJ
		Else
			ls_Diretorio = ls_Ano + "/" + ls_Mes + "/" + ls_Dia + "/" + ls_CNPJ
		End If
		
		lb_Localizado = True
		
		If lo_Ftp.of_Ftp_Set_Dir(ls_Diretorio, Ref ls_Mensagem) = -1 Then 
			ls_Mensagem = "XML n$$HEX1$$e300$$ENDHEX$$o localizado"
			If ls_Tipo <> 'CTE' Then
				of_grava_log_bd(ll_Filial, ls_Fornecedor, ll_Nota, ll_Nulo, lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
			End If
			lb_Localizado = False	
		End If
		
		If lb_Localizado Then
			If not lo_Ftp.of_Ftp_GetFile(ls_Arquivo_Xml, ls_Path_XML+ls_Arquivo_Xml, Ref ls_Mensagem) Then
				ls_Mensagem = "XML n$$HEX1$$e300$$ENDHEX$$o localizado na area FTP CLAMED"
				If ls_Tipo <> 'CTE' Then
					of_grava_log_bd(ll_Filial, ls_Fornecedor, ll_Nota, ll_Nulo, lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
				End If
				lb_Localizado = False
			End If
		End If	
			
		If Not lb_Localizado And ls_Tipo <> 'CTE' Then
			//Conecta no Sefaz todos os dias das 09:00 at$$HEX1$$e900$$ENDHEX$$ as 09:20
			//If lvt_Agora > Time('09:00:00') And lvt_Agora < Time('09:20:00') Then 
			//	ib_Download_Sefaz = True
			//	lb_Download_Sefaz_Auto = True
			//End If
			
			// Busca o Tempo:  Inser$$HEX2$$e700e300$$ENDHEX$$o na NFE_DESTINADAS(dh_inclusao), data desta execu$$HEX2$$e700e300$$ENDHEX$$o.
			If Not This.of_tempo_horas_nota(ls_Chave_Acesso,Ref ll_Tempo_Nota,Ref ls_Mensagem)  Then 
				This.of_grava_log_bd(ll_Filial,ls_Fornecedor, ll_Nota, ll_Nulo, lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)									
			End If 	

			If ll_Tempo_Nota > il_Tempo_Notas_Distrib Then 
				ib_Download_Sefaz = True
				lb_Download_Sefaz_Auto = True
			
				If ib_Download_Sefaz or ll_Filial = 534 Then
					ll_Cont_Array ++
					ls_Chave_Acesso_Array	[ll_Cont_Array] = ls_Chave_Acesso
					ll_Filial_Array				[ll_Cont_Array] = ll_Filial
				End If
			End If 	
		End If
			
		ll_Contador ++	
		
		If ll_Contador >= 200 Then ll_Contador = 0
		
		w_Aguarde_1.uo_Progress.of_setprogress(ll_Linha)
	Next
	
	ll_Linhas = UpperBound(ls_Chave_Acesso_Array[])
	
	// Baixa XML do SEFAZ
	If ll_Linhas > 0 Then
		
		//Se tiver mais 120 XML pra baixar do SEFAZ atrav$$HEX1$$e900$$ENDHEX$$s do download autom$$HEX1$$e100$$ENDHEX$$tico (09:00 $$HEX1$$e000$$ENDHEX$$s 09:20) o sistema n$$HEX1$$e300$$ENDHEX$$o realizar o downlaod e envia um e-mail ao operador
		//If ll_Linhas > 120 And lb_Download_Sefaz_Auto Then
		//	ls_Mensagem = "Quantidade " + String(ll_Linhas) + " de XML's pendentes $$HEX1$$e900$$ENDHEX$$ maior que o limite de 120.<br><br>Solicitar os XML's faltantes para os distribuidores."
		//	gf_ge202_envia_email_automatico(78, ' - Download Autom$$HEX1$$e100$$ENDHEX$$tico ocorre diariamente entre 09:00 e 09:20 horas', ls_Mensagem, ls_Anexo)
		//	Return True
		//End If
		
		dc_uo_importa_nf_pedido_eletronico lo_NFE
		lo_NFE = Create dc_uo_importa_nf_pedido_eletronico
		
		uo_ge238_importa_xml lo_Importa
		lo_Importa = Create uo_ge238_importa_xml
		
		If Not lo_Importa.of_diretorio_leitura_xml() Then Return False
					
		w_Aguarde_1.uo_Progress.of_Reset()
		
		w_Aguarde_1.uo_Progress.of_setmax(ll_Linhas)
		
		For ll_Linha = 1 To ll_Linhas			
			w_Aguarde_1.Title = "Baixando XML do SEFAZ ... " + String(ll_Linha) + " de " + String(ll_Linhas)
			
			ls_Chave_Acesso 	= ls_Chave_Acesso_Array	[ll_Linha]
			ll_Filial 				= ll_Filial_Array				[ll_Linha]
						
			If lo_NFE.of_verifica_cancelamento(ls_Chave_Acesso, ref ls_Mensagem) Then
				If Not lo_NFE.of_download_xml_sefaz(ls_Chave_Acesso, ll_Filial, ls_Mensagem, lo_Importa.is_Diretorio_Leitura, ls_Path_XML) Then
					This.of_grava_log_bd(ll_Filial, ls_Fornecedor, ll_Nota, ll_Nulo, lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
				Else
					ll_Notas_Sefaz ++
				End If		
			Else
				This.of_grava_log_bd(ll_Filial, ls_Fornecedor, ll_Nota, ll_Nulo, lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
			End If									
			w_Aguarde_1.uo_Progress.of_setprogress(ll_Linha)
		Next
		
		// Se algum XML foi baixado
		//If ll_Notas_Sefaz > 0 Then
		//lo_Importa.of_processa_leitura()
		//End If
	End If
	
	If Not lb_Localizado And ls_Tipo = 'CTE' Then		
		//CT-e n$$HEX1$$e300$$ENDHEX$$o conecta no SEFAZ pra baixar a nota, se n$$HEX1$$e300$$ENDHEX$$o foi localizado $$HEX1$$e900$$ENDHEX$$ enviado o e-mail abaixo.
		gf_ge202_Envia_Email_Automatico(92, "", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o XML '" + ls_Chave_Acesso + "'.",ls_Anexo[])
		Return False
	End If
	
finally
	lo_Ftp.of_Desconecta_ftp()
	destroy lo_Ftp
	If IsValid(lo_NFE) Then Destroy(lo_NFE)
	If IsValid(lo_Importa) Then Destroy(lo_Importa)
	Close(w_Aguarde_1)
end try

Return True
end function

public function boolean of_parametro_conexao_ftp ();String ls_Parametro

ls_Parametro = 'DE_FTP_XML_ENDERECO'

select vl_parametro
Into :is_ftp_xml_endereco
From parametro_geral
Where cd_parametro = :ls_Parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi localizado '" + ls_Parametro + "'.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o '" + ls_Parametro + "'.")
		Return False
End Choose

If IsNull(is_ftp_xml_endereco) or is_ftp_xml_endereco = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido '" + ls_Parametro + "'.")
	Return False
End If
is_ftp_xml_endereco = Lower(is_ftp_xml_endereco)

ls_Parametro = 'DE_FTP_XML_USUARIO'
select vl_parametro
Into :is_ftp_xml_usuario
From parametro_geral
Where cd_parametro = :ls_Parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi localizado '" + ls_Parametro + "'.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o '" + ls_Parametro + "'.")
		Return False
End Choose

If IsNull(is_ftp_xml_usuario) or is_ftp_xml_usuario = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido '" + ls_Parametro  + "'.")
	Return False
End If
is_ftp_xml_usuario = Lower(is_ftp_xml_usuario)

ls_Parametro = 'DE_FTP_XML_SENHA'
select vl_parametro
Into :is_ftp_xml_senha
From parametro_geral
Where cd_parametro = :ls_Parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi localizado '" + ls_Parametro + "'.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o '" + ls_Parametro + "'.")
		Return False
End Choose

If IsNull(is_ftp_xml_senha) or is_ftp_xml_senha = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido '" + ls_Parametro +  "'.")
	Return False
End If

is_ftp_xml_senha = Lower(is_ftp_xml_senha)

Return True
end function

public function boolean of_verifica_nf_ja_validada (string as_chave_acesso, string as_tipo, ref string as_nf_validada, ref string as_mensagem_log);If as_Tipo = "IND" Then
	
	Select Coalesce(id_verificado_divergencia_ped, "N")
		Into :as_nf_validada
	From nfe_destinadas
	Where de_chave_acesso = :as_Chave_Acesso
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode	
		Case 100
			as_nf_validada = "N"
			
		Case  -1
			as_Mensagem_Log = "Erro ao consultar o id_verificado_divergencia_ped da 'NFE_DESTINADAS'" + SqlCa.SqlErrText
			Return False
	End Choose
End If

If as_Tipo = "DEST" Then
	
	Select Coalesce(id_verificado_divergencia_ped, "N")
		Into :as_nf_validada
	From nfe_indexacao
	Where id_nf = :as_Chave_Acesso
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode	
		Case 100
			as_nf_validada = "N"
			
		Case  -1
			as_Mensagem_Log = "Erro ao consultar o id_verificado_divergencia_ped da 'NFE_INDEXACAO'" + SqlCa.SqlErrText
			Return False
	End Choose
End If

Return True
end function

public function boolean of_limpa_pasta_importacao (string as_diretorio, ref string as_mensagem_log);Long ll_Linha

String ls_Arquivo
String ls_Lista_Arquivos[]

gf_Dir_List(as_Diretorio, "*.xml", 1, Ref ls_Lista_Arquivos[])

For ll_Linha = 1 To UpperBound(ls_Lista_Arquivos[])
	ls_Arquivo = ls_Lista_Arquivos[ll_Linha]
	
	If Not FileDelete(ls_Arquivo) Then
		as_Mensagem_Log = "Erro ao excluir o arquivo '" + ls_Arquivo + "'."
		Return False
	End If
Next

Return True
end function

public function boolean of_fornecedor_importa_nfe_compra_pendent (string as_cnpj_origem, ref string as_importa_nfe_compra_pendente, ref string as_erro);Long	ll_Qtde

select count(*)
Into :ll_Qtde
from fornecedor
where coalesce(id_importacao_nfe, 'N')  = 'S'
and nr_cgc = :as_Cnpj_Origem
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao verificar se o fornecedor est$$HEX1$$e100$$ENDHEX$$ liberado para importar a nota para a tabela 'nfe_compra_pendente': "+SqlCa.SqlErrText
	Return False
End If

If ll_Qtde > 0 Then
	as_Importa_Nfe_Compra_Pendente = "S"
Else
	as_Importa_Nfe_Compra_Pendente = "N"
End If

Return True
end function

public function boolean of_fecha_conexao_log ();//Fecha conex$$HEX1$$e300$$ENDHEX$$o usada para gerar log.
if isvalid(iuo_SqlCa_log) Then
	iuo_SqlCa_log.of_disconnect( )
	destroy(iuo_SqlCa_log)
end if

return true
end function

public function boolean of_grava_log (integer ai_arquivo, string as_mensagem);Return This.of_grava_log(ai_arquivo, as_mensagem, False, True)


end function

public function boolean of_grava_log (integer ai_arquivo, string as_mensagem, boolean ab_envia_email, boolean ab_grava_arquivo);String lvs_Mensagem

String ls_Anexo[]

Integer lvi_Write

If ab_envia_email Then
	gf_ge202_envia_email_automatico(47, " - LOG ", as_mensagem, ls_Anexo)
End If

If ab_grava_arquivo Then
	lvs_Mensagem = String(Today(), "dd/mm/yyyy") + " " + String(Now(), "hh:mm:ss") + &
						" - " + as_Mensagem
	
	lvi_Write = FileWrite(ai_Arquivo, lvs_Mensagem)
	
	If lvi_Write = LenA(lvs_Mensagem) Then
		Return True
	Else
		Return False
	End If
End If

Return True
end function

public function boolean of_abre_conexao_log (ref string ps_log);///Abre uma nova transa$$HEX2$$e700e300$$ENDHEX$$o com o banco para gravar o registro.
if Not isvalid(iuo_SqlCa_log) Then
	iuo_SqlCa_log = create dc_uo_transacao
	iuo_SqlCa_log.ivs_database = "SYBASE"
end if

if Not iuo_SqlCa_log.of_isconnected() Then
	If Not iuo_SqlCa_log.of_Connect(gvo_Aplicacao.ivs_DataSource, gvo_Aplicacao.ivo_Seguranca.Cd_Sistema + "_" + gvo_Aplicacao.of_UserId(), False) Then
		ps_log =  'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_abre_conexao_log ~n' + "Erro ao conectar no Sybase."
		Return False
	End If
end if

return true
end function

public function boolean of_atualiza_recebimento (string as_recebimento, ref string as_log);update recebimento_sap
	set id_situacao = 'P'
 where nr_recebimento = :as_recebimento;
 
choose case sqlca.sqldbcode
	case -1
		as_log	= 'Erro: Problema ao atualizar a situa$$HEX2$$e700e300$$ENDHEX$$o do recebimento_sap. ' + Sqlca.sqlerrtext
		return false
	case 100
		return false
	case 0
		return true
end choose
end function

public function boolean of_verifica_fornecedor_ativo (string ps_fornecedor, ref string ps_msg);String lvs_Cnpj
Int lvi_Qtd

Select nr_cgc, count(*)
Into :lvs_Cnpj, :lvi_Qtd
From fornecedor
Where nr_cgc = (	Select nr_cgc
						From fornecedor f2
						Where f2.cd_fornecedor = :ps_Fornecedor)
	And id_situacao = 'A'
Group By nr_cgc
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		ps_Msg = "Erro ao verificar se existe mais do que um fornecedor ativo para o mesmo CNPJ. Fornecedor: "+ps_Fornecedor+"~r"+Sqlca.SqlErrText
		Return False
End Choose

// Tem outro ativo com mesmo CNPJ
If lvi_Qtd > 1 Then
	ps_Msg = "Existe mais de um fornecedor ativo para o CNPJ '"+lvs_Cnpj+"'."
	Return False
End if

Return True
end function

public function boolean of_verifica_nf_ja_importada (string ps_chave, ref string ps_msg);Int lvi_Qtd

Select 1
Into :lvi_Qtd
from parametro
where	exists(select 1 from nf_compra where de_chave_acesso = :ps_Chave)
	or		exists(select 1 from nf_compra_pendente where de_chave_acesso = :ps_Chave)
	or		exists(select 1 from nfe_compra_pendente where de_chave_acesso = :ps_Chave)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_Msg = "Erro ao verificar se a nota j$$HEX1$$e100$$ENDHEX$$ foi importada. Chave: "+ps_Chave+"~r"+Sqlca.SqlErrText
	Return False
End If

If lvi_Qtd > 0 Then
	ps_Msg = "A NF com a chave '"+ps_Chave+"' j$$HEX1$$e100$$ENDHEX$$ foi importada."
	Return False
End if

Return True
end function

public function boolean of_parametro_dias_pedido (ref integer ai_dias, ref string as_log);String ls_Parametro

select vl_parametro
Into :ls_Parametro
From parametro_geral
Where cd_parametro = 'NR_DIAS_EMISSAO_NF'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNumber(ls_Parametro) Then
			ai_dias = Integer(ls_Parametro)
		Else
			ai_dias = 10
		End If
		
	Case 100
		ai_dias = 10 
	Case -1
		as_log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro geral [NR_DIAS_EMISSAO_NF]"
		Return False
End Choose

Return True
end function

public function boolean of_parametro_tempo_horas (ref long al_tempo, ref string as_log);String ls_Parametro

Select vl_parametro
Into :ls_Parametro
From parametro_geral
Where cd_parametro = 'TEMPO_HORAS_XML_DISTRIB'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		al_tempo =  Long(ls_Parametro)				
		il_Tempo_Notas_Distrib = al_tempo
	Case 100
	Case -1		
		as_log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro geral [TEMPO_HORAS_XML_DISTRIB]"
		Return False
End Choose

Return True
end function

public function boolean of_tempo_horas_nota (string as_chave, ref long al_tempo_horas, ref string as_log);Long  ll_Tempo

al_tempo_horas  = 0 
ll_Tempo			  = 0 

Select coalesce(DATEDIFF(hh, dh_inclusao,getdate ()),0) 
Into :ll_Tempo
From nfe_destinadas
Where de_chave_acesso =:as_chave
and     id_situacao_nf 		<>  '3'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		al_tempo_horas =  ll_Tempo
	Case 100
	Case -1		
		as_log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos dados fun$$HEX2$$e700e300$$ENDHEX$$o :  of_tempo_horas_nota"
		Return False
End Choose

Return True



end function

public subroutine of_grava_log_bd (long al_filial, string as_fornecedor, long al_nota, long al_pedido, date adh_emissao, string as_chave_acesso, string as_mensagem, string as_resolvido, datetime adh_resolvido);Long ll_Log

String ls_Anexo[]

String ls_CGC_Forn, ls_MSG

String ls_Log

Date ldt_Movimento


ldt_Movimento = Date(gvo_parametro.of_Dh_Movimentacao())

as_mensagem = Upper(as_mensagem)

If Not This.of_abre_conexao_log(ls_Log) Then Return

Select max(nr_log)
Into :ll_Log
From log_importacao_nf_ped_elet
Where de_chave_acesso =:as_chave_acesso
Using iuo_SqlCa_log;

If iuo_SqlCa_log.SqlCode = - 1 Then
	ls_MSG = "Erro ao localizar o log da importa$$HEX2$$e700e300$$ENDHEX$$o de nota '" + as_Chave_Acesso + "'. " + iuo_SqlCa_log.SQLErrText
	gf_ge202_envia_email_automatico(47, " - LOG ", ls_MSG, ls_Anexo)
Else
	If Not IsNull(ll_Log) Then
		Update log_importacao_nf_ped_elet
		Set dh_movimentacao = cast(getdate() as date), dh_importacao = getdate(), de_log = :as_mensagem, nr_nf =:al_Nota, dh_emissao =:adh_emissao, nr_pedido = :al_pedido, id_resolvido = :as_resolvido,dh_resolvido = :adh_resolvido
		Where nr_log =:ll_Log
		Using iuo_SqlCa_log;
		
		If iuo_SqlCa_log.SqlCode = -1 Then
			ls_MSG = "Erro ao atualizar o log da importa$$HEX2$$e700e300$$ENDHEX$$o de nota '" + as_Chave_Acesso + "'. " + iuo_SqlCa_log.SQLErrText
			gf_ge202_envia_email_automatico(47, " - LOG ", ls_MSG, ls_Anexo)
			iuo_SqlCa_log.of_RollBack();
		Else
			iuo_SqlCa_log.of_Commit();
		End If
	Else
		INSERT INTO log_importacao_nf_ped_elet (	dh_movimentacao, dh_importacao, de_chave_acesso, cd_filial, cd_distribuidora, nr_nf, nr_pedido, dh_emissao, de_log, id_resolvido,dh_resolvido )  
		VALUES (cast(getdate() as date), getdate(), :as_chave_acesso, :al_filial, :as_fornecedor, :al_nota, :al_pedido, :adh_emissao, :as_mensagem,:as_resolvido,:adh_resolvido )
		Using iuo_SqlCa_log;
		
		If iuo_SqlCa_log.SqlCode = -1 Then
			ls_MSG = "Erro ao incluir o log da importa$$HEX2$$e700e300$$ENDHEX$$o de nota '" + as_Chave_Acesso + "'. " + iuo_SqlCa_log.SQLErrText
			gf_ge202_envia_email_automatico(47, " - LOG ", ls_MSG, ls_Anexo)
			iuo_SqlCa_log.of_RollBack();
		Else
			iuo_SqlCa_log.of_Commit();
		End If
		
	End If
End If
end subroutine

public function boolean of_verifica_destinadas (string ps_chave, ref string ps_msg);Int lvi_Qtd

select count(*)
into :lvi_Qtd
from dbo.nfe_destinadas 
where de_chave_acesso = :ps_chave;
//and coalesce(id_situacao_nf,'') = '1'

If SqlCa.SqlCode = -1 Then
	ps_Msg = "Erro ao verificar se a nota j$$HEX1$$e100$$ENDHEX$$ existe na NFE_DESTINADAS. Chave: "+ps_Chave+"~r"+Sqlca.SqlErrText
	Return False
End If

If lvi_Qtd = 0 or isnull(lvi_Qtd) Then
	ps_Msg = "A NF com a chave '"+ps_Chave+"' n$$HEX1$$e300$$ENDHEX$$o foi localizada na tabela NFE_DESTINADAS."
	Return False
End if

Return True
end function

public function boolean of_verifica_log_importacao_resolvido (string as_chave_acesso, ref string as_resolvido, ref string as_mensagem_log);Long ll_achou

Select count(1)
	Into :ll_achou
From log_importacao_nf_ped_elet
	Where de_chave_acesso = :as_Chave_Acesso
	and id_resolvido = 'S'
Using SqlCa;
	
If SqlCa.SqlCode = -1 Then 
	as_Mensagem_Log = "Erro ao consultar o id_resolvido da 'LOG_IMPORTACAO_NF_PED_ELET'" + SqlCa.SqlErrText
	Return False	
Else
	If ll_achou > 0 Then
		as_resolvido = 'S'
	Else
		as_resolvido = 'N'
	End if
End if
Return True
end function

public function boolean of_cfop_simples_remessa (string as_chave_acesso, string as_diretorio_leitura);
//Verifica se possui cfops de simples remessa ou brinde, se for nota entra pelo processo de destinadas. Chamado 2084657
String	ls_Arquivo_Leitura, ls_nat_op, ls_xml
Long	ll_modelo
Integer	li_FileOpen

t_infnfe lt_InfNFe
dc_uo_nfe lo_NFE

try
	
	ls_Arquivo_Leitura = as_diretorio_leitura + as_chave_acesso+"-nfe.xml"
	
	li_FileOpen = FileOpen (ls_Arquivo_Leitura  , TextMode! , Read!, LockRead! )
	FileReadEx (li_FileOpen, ls_Xml) 
	FileClose (li_FileOpen)
//	FileDelete (ls_Arquivo_Leitura)
			
	If ls_Xml <> "" Then

		lo_NFE 	= Create dc_uo_nfe
		If not lo_NFE.of_read_xml(ls_Xml, True, Ref lt_InfNFe) Then
			Return  False
		End If		
		
		ll_Modelo	=	lt_InfNFe.ide.modelo		
		//NFC-e
		If ll_Modelo = 65 Then
			Return False
		End If
		
		ls_Nat_Op                    = lt_InfNFe.det[1].prod.cfop
		If ls_Nat_Op = '5949' Or ls_Nat_Op = '6949' Or ls_Nat_Op = '5910' Or ls_Nat_Op = '6910' Then
			Return True
		End If		
		
	End If
finally
	Destroy lo_NFE
end try

Return False
end function

public function boolean of_processa_atualizacao (string as_chave_auxiliar);Date lvdt_Emissao
Date ld_data
Date ldt_Parametro

DateTime ldt_Nulo, ldh_solicitacao_estorno, ldt_Resolvido

Integer li_Log, ll_nulo, ll_Dias_Pedido

Long ll_Notas, ll_Linha, ll_Filial, ll_Pedido

Boolean lb_Download_XML_FTP, lb_Reimportacao, lb_simples_remessa_dest

Boolean lb_Iniciado_Operacao_SAP = False

String		ls_Mensagem_PBM,&
			ls_NatOperacao,&
			ls_Distribuidora,&
			ls_Chave_Acesso_Ant,&
			ls_Path_XML,&
			ls_Verificado_Divergencia_Ped,&
			ls_Path,&
			ls_Chave_Acesso,&
			ls_Mensagem,&
			ls_Fornecedor,&
			ls_Nota,&
			ls_Nome_Forn,&
			ls_Download_XML_FTP,&
			ls_INDEX_DEST,&
			ls_Verifica_Nf_Validada,&
			ls_Log,&
			ls_Importa_Nfe_Compra_Pendente,&
			ls_Recebimento_SAP, &
			ls_Dir_Xml,&
			ls_Permite_Nota_Sem_Pedido,&
			ls_Sistema_Java, &
			ls_de_chave_acesso_alterada, &
			ls_mover_xml,&
			ls_Emissao_Pedido,&
			ls_Emissao_CTE,&
			ls_Resolvido,&
			ls_dist_uso,&
			ls_dist_msg

SetNull( ll_nulo )
SetNull(ldt_Nulo)

If Not of_parametro_conexao_ftp() Then Return False

ls_Path 					= gvo_Aplicacao.of_GetFromINI("Diretorio", "NotasFiscais")
lb_Download_XML_FTP	= (gvo_Aplicacao.of_GetFromINI("Configuracao", "Downloadxmlftp") = "S")
ls_Dir_Xml 				= gvo_Aplicacao.of_GetFromINI("Diretorio", "XMLCompra") 
ls_mover_xml			= gvo_Aplicacao.of_GetFromINI("Diretorio", "XMLLeitura") 

ib_valida_teste_integrado	= gf_valida_teste_integrado()

If IsNull(ls_Path) or Trim(ls_Path) = '' Then Return False

ls_Path = ls_Path + "novo_nfc_" + string(Today(),"ddmm")

If Not gf_Cria_Logs(ls_Path, 4, ref li_log) Then	Return False 

if not gf_mover_arquivo_xml(ls_mover_xml, REF ls_Log) then
	This.of_Grava_Log(li_Log, ls_Log, True, True)
	Return False
end if

If Not This.of_Diretorio_Importacao_XML(ref ls_Path_XML) Then Return False

// Configura$$HEX2$$e700e300$$ENDHEX$$o Tempo para of_busca_xmls()
If Not This.of_parametro_tempo_horas(ref il_Tempo_Notas_Distrib, ref ls_Log) Then
	This.of_Grava_Log(li_Log, ls_Log, True, True)
	Return False
End If

ldt_Parametro = Date( gf_GetServerDate() )

//Importacao manual n$$HEX1$$e300$$ENDHEX$$o conecta na area FTP
If Not ib_Importacao_Manual Then
	//Se no .INI o parametro DownloadXMLFTP estiver 'N' n$$HEX1$$e300$$ENDHEX$$o conecta na area
	If lb_Download_XML_FTP Then
		//Busca os XMLs na area FTP dos fornecedores e envia p/ a nossa area
		This.of_Busca_xml_ftp( li_log )
	End If
End If

//Inicio Notas Fiscais Destinadas
dc_uo_ds_base lds_Notas_Destinadas

try
	lds_Notas_Destinadas = Create dc_uo_ds_base
	
	if ib_valida_teste_integrado then
		If Not lds_Notas_Destinadas.of_ChangeDataObject("dw_ge250_lista_destinadas_sap") Then Return False
	else
		If il_Filial_Auxiliar = 9998 then
			If Not lds_Notas_Destinadas.of_ChangeDataObject("dw_ge250_lista_destinadas_quimidrol") Then Return False
		Else
			If Not lds_Notas_Destinadas.of_ChangeDataObject("dw_ge250_lista_destinadas") Then	Return False
		End if
	end if
	
	If Not gf_verifica_inicio_operacao_sap('DH_INICIO_OPERACAO_SAP', ref lb_Iniciado_Operacao_SAP, ref ls_Mensagem) Then
		This.of_Grava_Log(li_Log, ls_Mensagem, True, True)
		Return False
	End If
		
	// Esta vari$$HEX1$$e100$$ENDHEX$$vel $$HEX1$$e900$$ENDHEX$$ abastecida somente quando for em modo de desenvolvimento
	If Not IsNull( is_Forn_Auxiliar ) And is_Forn_Auxiliar <> '' Then // ultimos dois unions n$$HEX1$$e300$$ENDHEX$$o possuem forn
		lds_Notas_Destinadas.Of_AppendWhere( "f.cd_fornecedor = '" + is_Forn_Auxiliar + "'"	, 1 )	
		lds_Notas_Destinadas.Of_AppendWhere( "f.cd_fornecedor = '" + is_Forn_Auxiliar + "'"	, 9 )	
		lds_Notas_Destinadas.Of_AppendWhere( "f.cd_fornecedor = '" + is_Forn_Auxiliar + "'"	, 15 )
		lds_Notas_Destinadas.Of_AppendWhere( "f.cd_fornecedor = '" + is_Forn_Auxiliar + "'"	, 24 )
		lds_Notas_Destinadas.Of_AppendWhere( "f.cd_fornecedor = '" + is_Forn_Auxiliar + "'"	, 25 )
	End If
	
	If Not IsNull( il_Filial_Auxiliar ) And il_Filial_Auxiliar > 0 Then	
		// Filiais					
		Choose Case il_Filial_Auxiliar
			Case 9999
				if not ib_valida_teste_integrado then
					lds_Notas_Destinadas.Of_AppendWhere( "v.cd_filial <> 534"	, 1 )	
					lds_Notas_Destinadas.Of_AppendWhere( "v.cd_filial <> 534"	, 9 )	
					lds_Notas_Destinadas.Of_AppendWhere( "v.cd_filial <> 534"	, 15 )
					lds_Notas_Destinadas.Of_AppendWhere( "v.cd_filial <> 534"	, 24 )
					lds_Notas_Destinadas.Of_AppendWhere( "v.cd_filial <> 534"	, 25 )
					lds_Notas_Destinadas.Of_AppendWhere( "v.cd_filial <> 534"	, 27 )
					lds_Notas_Destinadas.Of_AppendWhere( "v.cd_filial <> 534"	, 34 )
				else
					lds_Notas_Destinadas.Of_AppendWhere( "rs.cd_filial <> 534"	, 1 )	
				end if

			Case 9998
				if not ib_valida_teste_integrado then
					lds_Notas_Destinadas.Of_AppendWhere( "v.cd_filial <> 534"	, 1 )
				else
					lds_Notas_Destinadas.Of_AppendWhere( "rs.cd_filial <> 534"	, 1 )		
				end if

			Case Else
				if not ib_valida_teste_integrado then
					lds_Notas_Destinadas.Of_AppendWhere( "v.cd_filial = " + string(il_Filial_Auxiliar)	, 1 )	
					lds_Notas_Destinadas.Of_AppendWhere( "v.cd_filial = " + string(il_Filial_Auxiliar)	, 9 )	
					lds_Notas_Destinadas.Of_AppendWhere( "v.cd_filial = " + string(il_Filial_Auxiliar)	, 15 )
					lds_Notas_Destinadas.Of_AppendWhere( "v.cd_filial = " + string(il_Filial_Auxiliar)	, 24 )
					lds_Notas_Destinadas.Of_AppendWhere( "v.cd_filial = " + string(il_Filial_Auxiliar)	, 25 )
				else
					lds_Notas_Destinadas.Of_AppendWhere( "rs.cd_filial = " + string(il_Filial_Auxiliar)	, 1 )	
				end if
		End Choose	
	End If
 
	If Not IsNull( as_chave_auxiliar ) And as_chave_auxiliar <> '' Then
		if not ib_valida_teste_integrado then
			lds_Notas_Destinadas.Of_AppendWhere( "n.de_chave_acesso = '" + as_chave_auxiliar + "'"		, 1 )
			lds_Notas_Destinadas.Of_AppendWhere( "n.id_nf = '" + as_chave_auxiliar + "'"						, 9 )	
			lds_Notas_Destinadas.Of_AppendWhere( "n.id_nf = '" + as_chave_auxiliar + "'"						, 15 )	
			lds_Notas_Destinadas.Of_AppendWhere( "e.id_nf = '" + as_chave_auxiliar + "'"						, 24 )	
			lds_Notas_Destinadas.Of_AppendWhere( "n.id_nf = '" + as_chave_auxiliar + "'"						, 25 )	
			lds_Notas_Destinadas.Of_AppendWhere( "n.de_chave_acesso = '" + as_chave_auxiliar + "'"		, 27 )	
			lds_Notas_Destinadas.Of_AppendWhere( "n.id_nf = '" + as_chave_auxiliar + "'"						, 34 )							
			lds_Notas_Destinadas.Of_AppendWhere( "rs.de_chave_acesso_alterada = '" + as_chave_auxiliar + "'", 41 )			
			lds_Notas_Destinadas.Of_AppendWhere( "r.de_chave_acesso = '" + as_chave_auxiliar + "'"		, 48 )	
		else
			lds_Notas_Destinadas.Of_AppendWhere( "rs.de_chave_acesso_alterada = '" + as_chave_auxiliar + "'"		, 1 )	
		end if
	Else
		If Not This.of_parametro_dias_pedido(ref ll_Dias_Pedido, ref ls_Log) Then
			This.of_Grava_Log(li_Log, ls_Log, True, True)
			Return False
		End If
		
		ls_Emissao_Pedido 	= String( RelativeDate(ldt_Parametro, -ll_Dias_Pedido), 'yyyymmdd')
		ls_Emissao_CTE 		= String( RelativeDate(ldt_Parametro, -30), 'yyyymmdd')
				
		if not ib_valida_teste_integrado then
			//ll_Dias_Pedido => Qtde de dias que dever$$HEX1$$e300$$ENDHEX$$o ser considerados da emiss$$HEX1$$e300$$ENDHEX$$o do pedido
			If il_Filial_Auxiliar = 9998 Then
				lds_Notas_Destinadas.Of_AppendWhere("n.dh_emissao 		>= '" + ls_Emissao_Pedido + "'" , 1)
			Else
				lds_Notas_Destinadas.Of_AppendWhere("n.dh_emissao 		>= '" + ls_Emissao_Pedido + "'" , 1)
				lds_Notas_Destinadas.Of_AppendWhere("n.dh_emissao 		>= '" + ls_Emissao_Pedido + "'" , 9)
				lds_Notas_Destinadas.Of_AppendWhere("n.dh_emissao 		>= '" + ls_Emissao_Pedido + "'" , 15)
				lds_Notas_Destinadas.Of_AppendWhere("n.dh_emissao 		>= '" +  ls_Emissao_CTE + "'", 25 ) // CTE - considera 30 dias
				lds_Notas_Destinadas.Of_AppendWhere("n.dh_emissao 		>= '" + ls_Emissao_Pedido + "'" , 27)
				lds_Notas_Destinadas.Of_AppendWhere("n.dh_emissao 		>= '" + ls_Emissao_Pedido + "'" , 34)
				lds_Notas_Destinadas.Of_AppendWhere("rs.dh_recebimento 		>= '" + ls_Emissao_Pedido + "'" , 41)
			End if
		else
			lds_Notas_Destinadas.Of_AppendWhere("rs.dh_recebimento 		>= dateadd(day, - " + string(ll_Dias_Pedido) +  ", getdate())" , 1)
		end if
	End If
	
	ll_Notas = lds_Notas_Destinadas.Retrieve()
	
	If  ll_Notas < 0 Then
		This.of_Grava_Log(li_Log, "Erro ao recuperar as notas fiscais destinadas.", True, True)
		Return False
	End If
	
	If ll_Notas > 0 Then
		
		If Not of_busca_xmls(lds_Notas_Destinadas) Then Return False
			
		Open(w_Aguarde)
				
		Try
			dc_uo_importa_nf_pedido_eletronico lo_NFE
			lo_NFE = Create dc_uo_importa_nf_pedido_eletronico
			
			dc_uo_verifica_divergencia_notas lo_Divergencias
			lo_Divergencias = Create dc_uo_verifica_divergencia_notas
			
			uo_ge195_cte lo_Cte
			lo_Cte = Create uo_ge195_cte
			
			lo_NFE.ib_Imp_Manual_Sem_Pedido_Conexao = ib_Imp_Manual_Sem_Pedido_Conexao
						
			// A STACRUZ enviou o XML sem a tag XVAN, neste caso o sistema ir$$HEX1$$e100$$ENDHEX$$ tentar um pedido de conex$$HEX1$$e300$$ENDHEX$$o em aberto.
			lo_NFE.ib_sem_xvan = This.ib_sem_xvan
					
			w_Aguarde.uo_Progress.of_SetMax(ll_Notas)
			
			For ll_Linha = 1 To ll_Notas
				
				ib_Importa_Sem_Pedido	= False
				lb_Reimportacao			= False
				SetNull(ldt_Resolvido)
				SetNull(ls_Resolvido)
				ls_Mensagem_PBM 			= ""
				ls_Mensagem					= ""
				lo_NFE.il_Pedido = ll_nulo
				
				ll_Filial								= lds_Notas_Destinadas.Object.cd_filial								[ll_Linha]
				ls_Chave_Acesso						= lds_Notas_Destinadas.Object.de_chave_acesso						[ll_Linha]
				lvdt_Emissao							= date(lds_Notas_Destinadas.Object.dh_emissao						[ll_Linha])
				ls_Fornecedor							= lds_Notas_Destinadas.Object.cd_fornecedor							[ll_Linha]
				ls_Nota									= lds_Notas_Destinadas.Object.nr_nf										[ll_Linha]
				ls_Nome_Forn							= lds_Notas_Destinadas.Object.nm_fantasia								[ll_Linha]
				lb_Reimportacao						= (lds_Notas_Destinadas.Object.id_reimportacao 						[ll_Linha] = 'S')
				ls_Distribuidora 						= lds_Notas_Destinadas.Object.id_distribuidora						[ll_Linha]	
				ls_Verificado_Divergencia_Ped		= lds_Notas_Destinadas.Object.id_verificado_divergencia_ped		[ll_Linha]	
				ls_INDEX_DEST							= lds_Notas_Destinadas.Object.tipo										[ll_Linha]	
				ll_Pedido								= lds_Notas_Destinadas.Object.nr_pedido								[ll_Linha]	
				ls_Recebimento_SAP					= lds_Notas_Destinadas.Object.nr_recebimento							[ll_Linha]	
				ldh_solicitacao_estorno				= lds_Notas_Destinadas.Object.dh_solicitacao_estorno				[ll_Linha]	
				ls_Permite_Nota_Sem_Pedido			= lds_Notas_Destinadas.Object.id_permite_nota_sem_pedido			[ll_Linha]
				ls_Sistema_Java						= lds_Notas_Destinadas.Object.id_sistema_java						[ll_Linha]
				
				if not IsNull(ldh_solicitacao_estorno) then
					w_Aguarde.uo_Progress.of_SetProgress( ll_Linha )
					continue
				end if
				
				// Depois que o GRC (SAP) faz todas as valida$$HEX2$$e700f500$$ENDHEX$$es, ele faz o envio para o Sybase.
				// O dados s$$HEX1$$e300$$ENDHEX$$o gravados na tabela RECEBIMENTO_SAP, a partir deste momento o WMS poder$$HEX1$$e100$$ENDHEX$$ realizar a confer$$HEX1$$ea00$$ENDHEX$$ncia das mercadorias
				// ll_Pedido => RECEBIMENTO_SAP.NR_PEDIDO
				
				//Valida se a nota est$$HEX1$$e100$$ENDHEX$$ com situa$$HEX2$$e700e300$$ENDHEX$$o Resolvida ='S'
				If Not of_verifica_log_importacao_resolvido(ls_Chave_Acesso, Ref ls_Resolvido, Ref ls_Mensagem) Then
					of_grava_log_bd(ll_Filial, ls_Fornecedor, long(ls_Nota), Long(lo_NFE.il_Pedido), lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
					Continue
				End If
				
				If ls_Resolvido = 'S' Then
					Continue
				End if 
				
				If ls_Chave_Acesso <> ls_Chave_Acesso_Ant Then
					ls_Chave_Acesso_Ant = ls_Chave_Acesso
				Else
					w_Aguarde.uo_Progress.of_SetProgress( ll_Linha )
					Continue
				End If
				
				// Foi alterado o SQL da dw_ge250_lista_destinadas para pegar os XML  da filial 534 de fornecedores n$$HEX1$$e300$$ENDHEX$$o cadastrados.
				// Como come$$HEX1$$e700$$ENDHEX$$ou a gravar no agendamento notas indevidas de produtos n$$HEX1$$e300$$ENDHEX$$o comercializados foi colocado este controle para ignorar.
				If IsNull(ls_Fornecedor) Then
					w_Aguarde.uo_Progress.of_SetProgress( ll_Linha )
					Continue
				End If
				
				//Verifica se o fornecedor est$$HEX1$$e100$$ENDHEX$$ marcado para importar a nota para a tabela nfe_compra_pendente, antes era apenas Quimidrol
				If Not of_Fornecedor_Importa_Nfe_Compra_Pendent(Mid(ls_Chave_Acesso, 7, 14), Ref ls_Importa_Nfe_Compra_Pendente, Ref ls_Mensagem) Then
					of_grava_log_bd(ll_Filial, ls_Fornecedor, long(ls_Nota), Long(lo_NFE.il_Pedido), lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
					Continue
				End If
				
				// Pelo CNPJ do ls_Fornecedor, valida se possui apenas um ativo
				If Not of_verifica_fornecedor_ativo(ls_Fornecedor, ref ls_Mensagem) Then
					of_grava_log_bd(ll_Filial, ls_Fornecedor, long(ls_Nota), Long(lo_NFE.il_Pedido), lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
					Continue
				End If
				
				If ll_Filial <> 534 Then
					// Pela chave, valida se j$$HEX1$$e100$$ENDHEX$$ foi importada
					If Not of_verifica_nf_ja_importada(ls_Chave_Acesso, ref ls_Mensagem) Then
						of_grava_log_bd(ll_Filial, ls_Fornecedor, long(ls_Nota), Long(lo_NFE.il_Pedido), lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
						Continue
					End If
					
					//Valida se a chave j$$HEX1$$e100$$ENDHEX$$ existe na NFE_DESTINADAS
					If Not this.of_verifica_destinadas( ls_chave_acesso, ref ls_mensagem) Then
						of_grava_log_bd(ll_Filial, ls_Fornecedor, long(ls_Nota), Long(lo_NFE.il_Pedido), lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
						Continue
					ENd if
					
					//Verifica se $$HEX1$$e900$$ENDHEX$$ fornecedor uso_consumo e se a cfop $$HEX1$$e900$$ENDHEX$$ simples remessa/bonifc, se for sai do processo
					If lo_NFE.of_codigo_distribuidora( ls_Chave_Acesso, Ref ls_dist_uso, Ref ls_dist_msg) Then					
						If lo_NFE.is_id_fornecedor_uso_consumo = 'S' Then
							lb_simples_remessa_dest = This.of_cfop_simples_remessa( ls_Chave_Acesso, ls_Path_XML)
							If lb_simples_remessa_dest Then
								//of_grava_log_bd(ll_Filial, ls_Fornecedor, long(ls_Nota), Long(lo_NFE.il_Pedido), lvdt_Emissao, ls_Chave_Acesso, 'Fornecedor Uso/Consumo, mas nota simples remessa/bonifica$$HEX2$$e700e300$$ENDHEX$$o"',ls_Resolvido,ldt_Resolvido)								
								Continue
							End If
						End If
					End If
				
					If ls_Importa_Nfe_Compra_Pendente = "S" Then
						w_Aguarde.Title = "Importando NF / Forn [" + ls_Fornecedor +  "] / Filial [" + String(ll_Filial) + "]. Notas: " + String(ll_Linha) + " de " +  String(ll_Notas) + ". <<< Quimidrol >>>"
						If Not lo_NFE.of_insere_nf_quimidrol(ls_Chave_Acesso, ls_Path_XML, ref ls_Mensagem) Then
							of_grava_log_bd(ll_Filial, ls_Fornecedor, long(ls_Nota), Long(lo_NFE.il_Pedido), lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
							Continue
						End If
					End If
				End If
				
				w_Aguarde.Title = "Importando NF / Forn [" + ls_Fornecedor +  "] / Filial [" + String(ll_Filial) + "]. Notas: " + String(ll_Linha) + " de " +  String(ll_Notas) + "."
				
				If ls_INDEX_DEST = 'CTE' Then
					Continue
				Else
		
					If ll_Filial <> 534 Then
						// S$$HEX1$$f300$$ENDHEX$$ importa XML de distribuidora ou se o fornecedor permite importar nota sem pedido
						If ((ls_Distribuidora = 'N') and (ls_Permite_Nota_Sem_Pedido = "N")) Then Continue
						
//						//Utilizado para pedidos que est$$HEX1$$e300$$ENDHEX$$o sem retorno Pharmalink
//						If lvdt_Emissao < Date("21/11/2021") Then
//							ib_Importa_Sem_Pedido = True
//						End If
						
						// ib_Imp_Manual_Sem_Pedido_Conexao -> $$HEX1$$e900$$ENDHEX$$ informado atrav$$HEX1$$e900$$ENDHEX$$s da tela da gn001
						If ib_Imp_Manual_Sem_Pedido_Conexao Then ib_Importa_Sem_Pedido = True
						
						lo_NFE.is_Recebimento_SAP	= ls_Recebimento_SAP
						
						If Trim(ls_Recebimento_SAP) <> '' and not IsNull(ls_Recebimento_SAP) Then
							if not this.of_atualiza_recebimento(ls_Recebimento_SAP, Ref ls_Mensagem) then
								of_grava_log_bd(ll_Filial, ls_Fornecedor, long(ls_Nota), Long(lo_NFE.il_Pedido), lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
								Continue
							end if
						End If
						
						if ib_valida_teste_integrado then
							if IsNull(ls_Chave_Acesso) then
								ls_Mensagem	= "Chave de acesso nula"
								of_grava_log_bd(ll_Filial, ls_Fornecedor, long(ls_Nota), Long(lo_NFE.il_Pedido), lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
								continue
							end if
							
							select de_chave_acesso_alterada
							  into :ls_de_chave_acesso_alterada
							  from recebimento_sap
							 where de_chave_acesso	= :ls_Chave_Acesso;
							 
							if SQLCA.SQLCode = -1 then
								ls_Mensagem	= "Erro ao atualizar nf_compra " + SQLCA.SQLErrText
								of_grava_log_bd(ll_Filial, ls_Fornecedor, long(ls_Nota), Long(lo_NFE.il_Pedido), lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
								continue
							end if
							
							if IsNull(ls_de_chave_acesso_alterada) then
								ls_Mensagem	= "Chave de acesso original nula. "
								of_grava_log_bd(ll_Filial, ls_Fornecedor, long(ls_Nota), Long(lo_NFE.il_Pedido), lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
								continue
							End if
						else
							ls_de_chave_acesso_alterada	= ls_Chave_Acesso
						end if
						
						If Not lo_NFE.of_Importa_Nf(ls_de_chave_acesso_alterada, lvdt_Emissao, ll_nulo, ll_Filial, ls_Path_XML, ib_Importa_Sem_Pedido, ib_Download_Sefaz, lb_Reimportacao,&
															 Ref ls_Mensagem, ref ls_NatOperacao, li_Log, ll_pedido, ls_Permite_Nota_Sem_Pedido, ls_Sistema_Java, ls_Fornecedor,Ref ls_Resolvido,Ref ldt_Resolvido) Then
							If ls_NatOperacao <> '999 - Estorno de NF-e nao cancelada no prazo legal' Then
								of_grava_log_bd(ll_Filial, ls_Fornecedor, long(ls_Nota), Long(lo_NFE.il_Pedido), lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
							End If
						End If
					Else
						
						If ls_Verificado_Divergencia_Ped = 'N' Then
							//Faz mais uma valida$$HEX2$$e700e300$$ENDHEX$$o para consultar o id_verificado_divergencia_ped da tabela NFE_DESTINADAS/NFE_INDEXACAO, para n$$HEX1$$e300$$ENDHEX$$o correr o risco de processar uma nota mais de uma vez e enviar mais de um e-mail com diverg$$HEX1$$ea00$$ENDHEX$$ncias
							If Not of_Verifica_Nf_Ja_Validada(ls_Chave_Acesso, ls_INDEX_DEST, Ref ls_Verifica_Nf_Validada, Ref ls_Mensagem) Then
								of_Grava_Log(li_Log, ls_Mensagem)
							End If
							
							ls_Verificado_Divergencia_Ped = ls_Verifica_Nf_Validada
						End If
						
						If ls_Verificado_Divergencia_Ped = 'S' Then Continue
									
						//Esta vari$$HEX1$$e100$$ENDHEX$$vel de alterada conforme sele$$HEX2$$e700e300$$ENDHEX$$o do usu$$HEX1$$e100$$ENDHEX$$rio na w_nf001_processa_xml_pedido_eletronico
						lo_Divergencias.ib_marreta_reposicao_sta  = This.ib_marreta_reposicao_sta
						
						if ib_valida_teste_integrado then
							if IsNull(ls_Chave_Acesso) then
								ls_Mensagem	= "Chave de acesso nula"
								of_grava_log_bd(ll_Filial, ls_Fornecedor, long(ls_Nota), Long(lo_NFE.il_Pedido), lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
								continue
							end if
							
							select de_chave_acesso_alterada
							  into :ls_de_chave_acesso_alterada
							  from recebimento_sap
							 where de_chave_acesso	= :ls_Chave_Acesso;
							 
							if SQLCA.SQLCode = -1 then
								ls_Mensagem	= "Erro ao atualizar nf_compra " + SQLCA.SQLErrText
								of_grava_log_bd(ll_Filial, ls_Fornecedor, long(ls_Nota), Long(lo_NFE.il_Pedido), lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
								continue
							end if
							
							if IsNull(ls_de_chave_acesso_alterada) then
								ls_Mensagem	= "Chave de acesso original nula. "
								of_grava_log_bd(ll_Filial, ls_Fornecedor, long(ls_Nota), Long(lo_NFE.il_Pedido), lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
								continue
							End if
							
							update nf_compra
								set de_chave_acesso = :ls_Chave_Acesso
							 where de_chave_acesso	= :ls_de_chave_acesso_alterada;
							 
							if SQLCA.SQLCode = -1 then
								ls_Mensagem	= "Erro ao atualizar nf_compra " + SQLCA.SQLErrText
								of_grava_log_bd(ll_Filial, ls_Fornecedor, long(ls_Nota), Long(lo_NFE.il_Pedido), lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
								continue
							end if
							
							update nf_compra_pendente
								set de_chave_acesso = :ls_Chave_Acesso
							 where de_chave_acesso	= :ls_de_chave_acesso_alterada;
							 
							if SQLCA.SQLCode = -1 then
								ls_Mensagem	= "Erro ao atualizar nf_compra_pendente " + SQLCA.SQLErrText
								of_grava_log_bd(ll_Filial, ls_Fornecedor, long(ls_Nota), Long(lo_NFE.il_Pedido), lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
								continue
							end if
						else
							ls_de_chave_acesso_alterada	= ls_Chave_Acesso
						end if
						
						If Not lo_Divergencias.of_verifica_divergencias(ls_Chave_Acesso, &
																					lvdt_Emissao, &
																					ll_Pedido, &
																					ll_Filial, &
																					ls_Path_XML, &
																					Ref ls_Mensagem, &
																					Ref ls_Mensagem_PBM, &
																					li_Log, &
																					ls_INDEX_DEST, &
																					lb_Iniciado_Operacao_SAP,&
																					ls_Recebimento_SAP,&
																					Ref ib_envio_email,&
																					Ref ls_Resolvido,&
																					Ref ldt_Resolvido) Then
							If lb_Iniciado_Operacao_SAP Then
								of_Grava_Log(li_Log, ls_Fornecedor + ' - ' + "NOTA PERINI - Verifica Diverg$$HEX1$$ea00$$ENDHEX$$ncias:  "+ls_Mensagem + ' - ' + ls_Chave_Acesso, ib_envio_email , True)	
							Else
								of_Grava_Log(li_Log, ls_Fornecedor + ' - ' + "NOTA PERINI - Verifica Diverg$$HEX1$$ea00$$ENDHEX$$ncias:  "+ls_Mensagem + ' - ' + ls_Chave_Acesso)	
							End If
							
							of_grava_log_bd(ll_Filial, ls_Fornecedor, long(ls_Nota), Long(lo_NFE.il_Pedido), lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem,ls_Resolvido,ldt_Resolvido)
						End If
						
						If ls_Mensagem_PBM <> "" Then
							of_Grava_Log(li_Log, ls_Fornecedor + ' - ' + "NOTA PERINI - Verifica Diverg$$HEX1$$ea00$$ENDHEX$$ncias - PBM:  "+ ls_Mensagem_PBM + ' - ' + ls_Chave_Acesso)	
							of_grava_log_bd(ll_Filial, ls_Fornecedor, long(ls_Nota), Long(lo_NFE.il_Pedido), lvdt_Emissao, ls_Chave_Acesso, ls_Mensagem_PBM,ls_Resolvido,ldt_Resolvido)
						End If
						
					End If
			
					w_Aguarde.uo_Progress.of_SetProgress( ll_Linha )
				End If
			Next
			
			Return True
		Catch (RunTimeError RTE)
			This.of_Grava_Log(li_Log, RTE.GetMessage())
			
			Return False
		Finally	
			Destroy(lo_NFE)
			Destroy(lo_Divergencias)
			Destroy(lo_Cte)
		End Try
		
		If Not of_Limpa_Pasta_Importacao(ls_Path_XML, Ref ls_Log) Then of_Grava_Log(li_Log, ls_Log)
	Else
		This.of_Grava_Log(li_Log, "Nenhuma nota destinada foi encontrada para a importa$$HEX2$$e700e300$$ENDHEX$$o.")
	End If
catch (RunTimeError RTE2)
	This.of_Grava_Log(li_Log, RTE2.GetMessage())
finally
	If IsValid(lds_Notas_Destinadas) Then Destroy(lds_Notas_Destinadas)
	If IsValid(w_Aguarde) Then Close(w_Aguarde)
	FileClose(li_log)
end try
end function

on uo_ge250_xml_pedido_eletronico.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge250_xml_pedido_eletronico.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;this.of_fecha_conexao_log( )
end event

