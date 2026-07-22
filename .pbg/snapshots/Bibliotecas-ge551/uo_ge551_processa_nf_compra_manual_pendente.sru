HA$PBExportHeader$uo_ge551_processa_nf_compra_manual_pendente.sru
forward
global type uo_ge551_processa_nf_compra_manual_pendente from nonvisualobject
end type
end forward

global type uo_ge551_processa_nf_compra_manual_pendente from nonvisualobject
end type
global uo_ge551_processa_nf_compra_manual_pendente uo_ge551_processa_nf_compra_manual_pendente

forward prototypes
public function boolean of_processa_nf_compra_manual_pendente ()
public function boolean of_exclui_xml (string as_diretorio_xml, ref string as_mensagem_erro)
end prototypes

public function boolean of_processa_nf_compra_manual_pendente ();Boolean lb_Sucesso

Date ldt_Emissao_NF
DateTime ldh_Emissao

Integer li_FileOpen
Long ll_Linha
Long ll_Linhas
Long ll_Filial
Long ll_Natureza_Operacao

String ls_Diretorio_Xml
String ls_Arquivo_XML
String ls_Chave_Acesso
String ls_Mensagem_Log
String ls_Xml
String ls_Id_Notifica_Loja
String ls_Diretorio_Leitura
String ls_Anexo[]

Try

	Open(w_Aguarde)
	w_Aguarde.Title = "Verifica$$HEX2$$e700e300$$ENDHEX$$o dos XMLs de nota Fiscal de Compra SEM pedido pendente de entrada"

	dc_uo_ds_base lds
	dc_uo_verifica_divergencia_notas lo_diverg
	dc_uo_nfe lo_nfe
	dc_uo_importa_nf_pedido_eletronico lo_NFE_Sefaz
	
	lds = Create dc_uo_ds_base
	lo_diverg = Create dc_uo_verifica_divergencia_notas
	lo_nfe = Create dc_uo_nfe
	lo_NFE_Sefaz = Create dc_uo_importa_nf_pedido_eletronico
	
	
	//ds_utilizada tamb$$HEX1$$e900$$ENDHEX$$m no sistema Carga no objeto uo_fechamento da CA002
	If Not lds.of_ChangeDataObject("ds_ge551_lista_nf_manual_pendente_ent") Then
		gf_ge202_envia_email_automatico(269, "", "Erro ao carregar a ds 'ds_ge551_lista_nf_manual_pendente_ent' na fun$$HEX2$$e700e300$$ENDHEX$$o of_processa_nf_compra_manual_pendente", ls_Anexo, False)
		Return False
	End If
	
	ldh_Emissao = DateTime(RelativeDate(Today(), -2), Time('23:59:59'))
	
	ll_Linhas = lds.Retrieve(ldh_Emissao)
	
	Choose Case ll_Linhas
		Case 0			
			Return True			
		Case -1
			gf_ge202_envia_email_automatico(269, "", "Erro no retrieve do data store 'ds_ge551_lista_nf_manual_pendente_ent' - of_processa_nf_compra_manual_pendente.", ls_Anexo, False)
			Return False
	End Choose
	
	ls_Diretorio_Xml = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, 'Diretorio', 'XML_NF_PENDENTE', "")	
	ls_Diretorio_Leitura = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, 'Diretorio', 'XMLLeitura', "")	
	t_infnfe lt_InfNFe
	t_infnfe lt_Nulo
	
	If Not This.of_Exclui_XML(ls_Diretorio_Xml, Ref ls_Mensagem_Log) Then
		gf_ge202_envia_email_automatico(269, "", ls_Mensagem_Log, ls_Anexo, False)
		Return False
	End If
	
	w_Aguarde.uo_progress.of_setmax(ll_Linhas)
	
	For ll_Linha = 1 To ll_Linhas
	
		ls_Chave_Acesso	= lds.Object.De_Chave_Acesso	[ll_Linha]
		ldt_Emissao_NF	= Date(lds.Object.Dh_Emissao	[ll_Linha])
		ll_Filial				= lds.Object.Cd_Filial				[ll_Linha]
		
		lt_InfNFe = lt_Nulo	
		ll_Natureza_Operacao = 0
		ls_XML = ""
	
		ls_Arquivo_XML = ls_Diretorio_Xml + ls_Chave_Acesso + "-nfe.xml"
		
		lb_Sucesso = True
		
		// Todos os XML'S s$$HEX1$$e300$$ENDHEX$$o baixados da area FTP no inicio do processo, caso n$$HEX1$$e300$$ENDHEX$$o seja encontrado faz a busca no SEFAZ e neste caso precisa tentar baixar da area FTP novamente
		If Not FileExists(ls_Arquivo_XML) Then
			If Not lo_diverg.of_Busca_Xml_Ftp(ls_Chave_Acesso, ldt_Emissao_NF, ll_Filial, ls_Diretorio_Xml, Ref ls_Mensagem_Log) Then
				gvo_Aplicacao.of_Grava_Log(ls_Mensagem_Log)
			End If
		End If
		
		If Not FileExists(ls_Arquivo_XML) Then			
			If Not lo_NFE_Sefaz.of_download_xml_sefaz(ls_Chave_Acesso, ll_Filial, Ref ls_Mensagem_Log, ls_Diretorio_Leitura, ls_Diretorio_Xml) Then		
				lb_Sucesso = False
			End If
		End If
		
		If lb_Sucesso Then
			If FileLength(ls_Arquivo_XML) < 1 Then
				gf_ge202_envia_email_automatico(269, "", "Tamanho do arquivo: "+ ls_Arquivo_XML +" $$HEX1$$e900$$ENDHEX$$ 0 byte", ls_Anexo, False)
				lb_Sucesso = False
			End If
		End If
		
		If lb_Sucesso Then
			li_FileOpen = FileOpen (ls_Arquivo_Xml , TextMode! , Read!, LockRead!)
			FileReadEx (li_FileOpen, ls_Xml) 
			FileClose (li_FileOpen)
		
			If ls_Xml <> "" Then
	
				If Not lo_nfe.of_read_xml(ls_Xml, True, Ref lt_InfNFe) Then
					gf_ge202_envia_email_automatico(269, "", "Erro ao ler o arquivo XML " + ls_Arquivo_XML, ls_Anexo, False)
					lb_Sucesso = False
				Else
					ll_Natureza_Operacao = Long(lt_InfNFe.det[1].prod.cfop)
				End If
				
			Else
				lb_Sucesso = False
			End If
		End If
					
		//Se for comodadato (freezer da kibon) ou houve erro em algum ponto anterior, o ls_Id_Notifica_Loja fica N para n$$HEX1$$e300$$ENDHEX$$o enviar e-mail para a loja
		If ll_Natureza_Operacao = 5908 Or ll_Natureza_Operacao = 6908 Then
			ls_Id_Notifica_Loja = 'N'
		Else
			ls_Id_Notifica_Loja = 'S'
		End If
		
		Update nfe_destinadas
			Set 	cd_natureza_operacao 	= :ll_Natureza_Operacao,
					id_notifica_loja				= :ls_Id_Notifica_Loja
		Where de_chave_acesso = :ls_Chave_Acesso
		And id_situacao_nf = '1'
		Using SqlCa;
		
		If SqlCa.SqlCode = - 1 Then
			gf_ge202_envia_email_automatico(269, "", "Erro ao atualizar a nfe_destinadas. Fun$$HEX2$$e700e300$$ENDHEX$$o of_processa_nf_compra_manual_pendente. Chave de acesso: " + ls_Arquivo_XML, ls_Anexo, False)
			Return False
		End If

		SqlCa.of_Commit();

		w_Aguarde.Title = "Validando XML Compra manual Pendente. XML: " + String(ll_Linha) + " at$$HEX1$$e900$$ENDHEX$$ " + String(ll_Linhas)
		w_aguarde.uo_progress.of_setprogress(ll_Linha)
	Next
	
	//	lds.SaveAs("D:\TEMP\PREPARA_ENVIO_EMAIL.XLS", Excel!, TRUE)
		
Catch ( runtimeerror lo_rte )
	gf_ge202_envia_email_automatico(269, "", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_processa_nf_compra_manual_pendente: " + lo_rte.GetMessage( ), ls_Anexo, False)	
	Return False
Finally	
	If IsValid(lds) 				Then Destroy(lds)
	If IsValid(lo_diverg) 		Then Destroy(lo_diverg)
	If IsValid(lo_nfe) 			Then Destroy(lo_nfe)
	If IsValid(lo_NFE_Sefaz)	Then Destroy(lo_NFE_Sefaz)
	Close(w_Aguarde)
End Try
end function

public function boolean of_exclui_xml (string as_diretorio_xml, ref string as_mensagem_erro);Long ll_Linha
Long ll_Linhas

String ls_Arquivos[]

If gf_Dir_List(as_diretorio_xml, "*.xml", 0, ls_Arquivos[]) = -1 Then
	as_Mensagem_Erro = "Erro ao listar os arquivos xml. Fun$$HEX2$$e700e300$$ENDHEX$$o of_exclui_xml"
	Return False
End If

ll_Linhas = UpperBound(ls_Arquivos[])

For ll_Linha = 1 To ll_Linhas
	FileDelete(as_diretorio_xml + ls_Arquivos[ll_Linha])
Next

Return True
end function

on uo_ge551_processa_nf_compra_manual_pendente.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge551_processa_nf_compra_manual_pendente.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

