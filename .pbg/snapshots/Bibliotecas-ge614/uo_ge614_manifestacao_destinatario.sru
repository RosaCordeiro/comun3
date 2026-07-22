HA$PBExportHeader$uo_ge614_manifestacao_destinatario.sru
forward
global type uo_ge614_manifestacao_destinatario from nonvisualobject
end type
end forward

global type uo_ge614_manifestacao_destinatario from nonvisualobject
end type
global uo_ge614_manifestacao_destinatario uo_ge614_manifestacao_destinatario

type variables
Integer	ii_Log,&
			ii_Arquivo_Envio
			
String is_Dir_Arquivo_Manifestacao


end variables

forward prototypes
public function boolean of_grava_retorno (string as_chave_acesso, string as_situacao_nf, integer ai_evento, datetime adh_evento, string as_protocolo, string as_justificativa, string as_falta_xml, ref string as_erro)
public function boolean of_abre_log ()
public function boolean of_grava_log (string as_mensagem)
public function boolean of_manifestacao_genesio (ref string as_retorno)
public function boolean of_finaliza_arquivo (ref string as_retorno)
public function boolean of_monta_arquivo_manifestacao (long al_item, string as_xml_envio, string as_xml_retorno, ref string as_retorno)
public function boolean of_envia_arquivo_fornecedor (string as_fornecedor, string as_dir_arquivo, string as_nm_arquivo, ref string as_retorno)
public function boolean of_arquivo_enviado_sefaz (string as_chave_acesso, ref string as_arquivo_envio, ref string as_retorno)
public function boolean of_inicia_arquivo (string as_nome_arquivo, ref string as_retorno)
public function boolean of_move_arquivo_para_bkp (string as_arquivo, ref string as_retorno)
public function boolean of_exclui_bkp_antigo (ref string as_retorno)
public function boolean of_grava_dh_envio_manifestacao (string as_chave_acesso, string as_id_manifestacao, ref string as_erro)
public function boolean of_parametro_conexao_ftp (ref string as_ftp_xml_endereco, ref string as_ftp_xml_usuario, ref string as_xml_ftp_senha, ref string as_erro)
public function boolean of_envia_ftp_clamed (string as_diretorio_arquivo_xml, string as_chave_acesso, ref string as_erro)
public function boolean of_verifica_xms_existe_no_ftp (string as_chave_acesso, long al_filial, date adt_emissao, string as_cgc_destino, long al_nf, string as_serie, ref string as_erro)
public function boolean of_grava_dh_envio_manifestacao (string as_chave_acesso, string as_id_manifestacao, string as_mensagem_log, ref string as_erro)
public function boolean of_grava_log_envio_sefaz (string as_chave_acesso, string as_id_manifestacao, string as_mensagem_log, ref string as_erro)
public function boolean of_manifestacao_destinatario (string as_tipo, ref string as_retorno)
public function boolean of_processa_manifestacao_destinatario (string as_tipo)
end prototypes

public function boolean of_grava_retorno (string as_chave_acesso, string as_situacao_nf, integer ai_evento, datetime adh_evento, string as_protocolo, string as_justificativa, string as_falta_xml, ref string as_erro);String		ls_Evento,&
			ls_Chave_Acesso

 Choose Case ai_Evento 
	Case 1
		ls_Evento = "210200" //Confirmacao da operacao
	Case 2
		ls_Evento = "210210" //Ci$$HEX1$$ea00$$ENDHEX$$ncia da Opera$$HEX2$$e700e300$$ENDHEX$$o
	Case 3 
		ls_Evento = "210220" //Desconhecimento da Opera$$HEX2$$e700e300$$ENDHEX$$o
	Case 4 
		ls_Evento = "210240" //Opera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o Realizada
End Choose

Select de_chave_acesso
Into :ls_Chave_Acesso
From nfe_manifestacao
where de_chave_acesso	= :as_Chave_Acesso
	and id_situacao_nf		= :as_Situacao_Nf
	and id_evento			= :ls_Evento
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
	Case 100
		Insert into nfe_manifestacao(
			de_chave_acesso, 
			id_situacao_nf, 
			id_evento, 
			dh_evento, 
			nr_protocolo, 
			de_justificativa, 
			id_falta_xml) 
		Values(	:as_Chave_Acesso,
					:as_Situacao_Nf,
					:ls_Evento,
					:adh_Evento,
					:as_Protocolo,
					:as_Justificativa,
					:as_Falta_Xml)
		Using SqlCa;		
		
		If SqlCa.SqlCode = -1 Then
			as_Erro = "Erro ao inserir o registro na tabela 'nfe_manifestacao'. " + SqlCa.sqlErrText
			Return False
		End If

	Case -1
		as_Erro = "Erro ao verificar se j$$HEX1$$e100$$ENDHEX$$ existe o registro noa tabela 'nfe_manifestacao'. " + SqlCa.sqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_abre_log ();String ls_Path

ls_Path 	= gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")

If IsNull(ls_Path) or Trim(ls_Path) = '' Then  
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Diret$$HEX1$$f300$$ENDHEX$$rio para a grava$$HEX2$$e700e300$$ENDHEX$$o do log n$$HEX1$$e300$$ENDHEX$$o foi localizado no INI da aplica$$HEX2$$e700e300$$ENDHEX$$o. Chave: Diretorio | Se$$HEX2$$e700e300$$ENDHEX$$o: Diretorio = c:\sistemas\ex\arquivos\ .", StopSign!)
	Return False
End If

ls_Path = ls_Path + "Manifestacao_Destinatario_" + string(Today(),"ddmm")

If Not gf_Cria_Logs(ls_Path, 4, ref ii_log) Then
	Return False
End If

Return True


end function

public function boolean of_grava_log (string as_mensagem);return gf_grava_log_basico(ii_log, as_mensagem)
end function

public function boolean of_manifestacao_genesio (ref string as_retorno);
dc_uo_ds_Base			lds_Fornecedor_Genesio
dc_uo_ds_Base			lds_Filiais
dc_uo_ds_Base			lds_Notas
dc_uo_nfe				lo_Nfe

dc_uo_eventos_sefaz	lo_Evento_Sefaz

Long 	ll_Linhas_Genesio,&
		ll_Linha_Genesio,&
		ll_Linhas_Filial,&
		ll_Linha_Filial,&
		ll_Linhas_Notas,&
		ll_Linha_Notas,&
		ll_Filial,&
		ll_Retorno,&
		ll_Arquivos,&
		ll_Item
		
String		ls_Fornecedor,&
			ls_Chave_Acesso,&
			ls_CNPJ,&
			ls_Justificativa,&
			ls_Orgao,&
			ls_UF,&
			ls_Data_Evento,&
			ls_Status,&
			ls_Protocolo,&
			ls_Situacao_Nf,&
			ls_Lista_Arquivos[],&
			ls_Arquivo_Envio,&
			ls_Nome_Arquivo_Envio_Genesio,&
			ls_Nm_Fornecedor,&
			ls_Nm_Filial

Integer li_Evento

DateTime ldh_Evento


Try
	Open(w_ge614_aguarde)
	
	lds_Fornecedor_Genesio			= Create dc_uo_ds_Base
	lds_Filiais							= Create dc_uo_ds_Base
	lds_Notas							= Create dc_uo_ds_Base
	lo_Evento_Sefaz					= Create dc_uo_eventos_sefaz
	lo_Nfe								= Create dc_uo_nfe
	
	If Not lds_Fornecedor_Genesio.of_ChangeDataObject("ds_ge614_lista_fornecedor_genesio") Then
		as_Retorno = "Erro no changeDataObject da 'ds_ge614_lista_fornecedor_genesio'. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_manifestacao_genesio"
		Return False
	End If
	
	If Not lds_Filiais.of_ChangeDataObject("ds_ge614_lista_filiais") Then
		as_Retorno = "Erro no changeDataObject da 'ds_ge614_lista_filiais'. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_manifestacao_genesio"
		Return False
	End If
	
	If Not lds_Notas.of_ChangeDataObject("ds_ge614_lista_notas") Then
		as_Retorno = "Erro no changeDataObject da 'ds_ge614_lista_notas'. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_manifestacao_genesio"
		Return False
	End If
	
	ll_Linhas_Genesio	= lds_Fornecedor_Genesio.Retrieve()
	
	ll_Linhas_Filial		= lds_Filiais.Retrieve()
	
	w_ge614_aguarde.uo_Progress_1.of_setmax(ll_Linhas_Genesio)
	w_ge614_aguarde.uo_Progress_1.of_setprogress(0)
	
	For ll_Linha_Genesio = 1 To ll_Linhas_Genesio
		ls_Fornecedor 			= lds_Fornecedor_Genesio.Object.cd_fornecedor	[ll_Linha_Genesio]
		ls_Nm_Fornecedor		= lds_Fornecedor_Genesio.Object.nm_fantasia		[ll_Linha_Genesio]
		
		w_ge614_aguarde.st_fornecedor.Text = "("+Mid(ls_Fornecedor, 1, 4)+"-"+Mid(ls_Fornecedor, 5)+") "+ls_Nm_Fornecedor
		
		w_ge614_aguarde.uo_Progress_2.of_setmax(ll_Linhas_Filial)
		w_ge614_aguarde.uo_Progress_2.of_setprogress(0)
		
		
		For ll_Linha_Filial = 1 To ll_Linhas_Filial
			ll_Filial		= lds_Filiais.Object.cd_filial			[ll_Linha_Filial]
			ls_Nm_Filial	= lds_Filiais.Object.nm_fantasia	[ll_Linha_Filial]
			
			w_ge614_aguarde.st_filial.Text = "("+String(ll_Filial)+") "+ls_Nm_Filial
			
			ll_Linhas_Notas	= lds_Notas.Retrieve(ll_Filial, ls_Fornecedor)	
			
			ll_Item = 1
			
			ls_Nome_Arquivo_Envio_Genesio = "manifestacao"+String(gf_GetServerDate(), "_DD_MM_YYYY_HH_MM_SS")+".xml"
			
			If ll_Linhas_Notas > 0 Then
				
				//Inicia arquivo que ser$$HEX1$$e100$$ENDHEX$$ enviado para a Gen$$HEX1$$e900$$ENDHEX$$sio via FTP
				If Not of_Inicia_Arquivo(ls_Nome_Arquivo_Envio_Genesio, Ref as_Retorno) Then
					Return False
				End If
				
				w_ge614_aguarde.uo_Progress_3.of_setmax(ll_Linhas_Notas)
				w_ge614_aguarde.uo_Progress_3.of_setprogress(0)
				
				Try
					
					For ll_Linha_Notas = 1 To ll_Linhas_Notas
						w_ge614_aguarde.st_notas.Text = "Emitindo manifesta$$HEX2$$e700e300$$ENDHEX$$o "+String(ll_Linha_Notas)+" de "+String(ll_Linhas_Notas)
						Yield()
						
						li_Evento = 1
						ls_Chave_Acesso	= lds_Notas.Object.de_chave_acesso	[ll_Linha_Notas]
						ls_CNPJ				= lds_Filiais.Object.nr_cgc				[ll_Linha_Filial]
						ls_Justificativa		= "Confirmacao da Operacao"
						ls_Orgao				= '91';// Nacional
						ls_Situacao_Nf		= '1';
						ls_UF					= lds_Filiais.Object.de_uf				[ll_Linha_Filial]
						
						ldh_Evento			= lds_Filiais.Object.dh_atual[ll_Linhas_Filial]
						ls_Data_Evento		= String(ldh_Evento, "YYYY-MM-DD") +"T"+ String(ldh_Evento, "HH:MM:SS")
						
						
						If Not lo_Evento_Sefaz.of_Envia_Manifesta$$HEX2$$e700e300$$ENDHEX$$o_Destinatario_Novo(	li_Evento,&
																												ls_Chave_Acesso,&
																												ls_CNPJ,&
																												ls_Justificativa,&
																												ls_Orgao,&
																												ls_UF,&
																												ls_Data_Evento,&
																												Ref as_Retorno) Then
							as_Retorno = "Arquivo: "+ls_Nome_Arquivo_Envio_Genesio+" "+as_Retorno
							Return False																				
						End If	
						
						ls_Status = lo_Nfe.of_get_value_tag(as_Retorno, "<cStat>", 2)
					
						//Status
						//135 -> Evento registrado e vinculado a NF-e
						//573 -> Verificar duplicidade do evento (tpEvento + chNFe + nSeqEvento)
						//596 -> Evento apresentado fora do prazo: [prazo vigente]
						
						If (ls_Status = '135') or (ls_Status = '573') Then
							ls_Protocolo = lo_Nfe.of_get_value_tag(as_Retorno, '<nProt>', 1)
							
							If (Trim(ls_Protocolo) = '')	Then
								ls_Protocolo = 'DUPLICIDADE'
							End If
							
							If Not of_Arquivo_Enviado_Sefaz(ls_Chave_Acesso, Ref ls_Arquivo_Envio, Ref as_Retorno) Then
								as_Retorno = "Arquivo: "+ls_Nome_Arquivo_Envio_Genesio+" "+as_Retorno
								If Not of_Grava_Log(as_Retorno) Then
									as_Retorno = "Arquivo: "+ls_Nome_Arquivo_Envio_Genesio+" "+as_Retorno
									Return False
								End If
								Continue
							End If
								
							//Monta o arquivo para envio ao fornecedor com o arquivo de envio para a SEFAZ e retorno da SEFAZ
							If Not of_Monta_Arquivo_Manifestacao(ll_item, ls_Arquivo_Envio, as_Retorno, Ref as_Retorno) Then
								as_Retorno = "Arquivo: "+ls_Nome_Arquivo_Envio_Genesio+" "+as_Retorno
								Return False
							End If
	
							If of_Grava_Retorno(ls_Chave_Acesso, ls_Situacao_Nf, li_Evento, ldh_Evento, ls_Protocolo, ls_Justificativa, 'N', Ref as_Retorno) Then
								SqlCa.of_Commit()
							Else
								SqlCa.Of_Rollback()
								as_Retorno = "Arquivo: "+ls_Nome_Arquivo_Envio_Genesio+" "+as_Retorno
								Return False
							End If
							
							ll_item ++
							
						End If
						w_ge614_aguarde.uo_Progress_3.of_setprogress(ll_Linha_Notas)
						Yield()
					Next
					
				Finally
					//Finaliza arquivo que ser$$HEX1$$e100$$ENDHEX$$ enviado para a Gen$$HEX1$$e900$$ENDHEX$$sio via FTP
					If Not of_Finaliza_Arquivo(Ref as_Retorno) Then
						as_Retorno = "Arquivo: "+ls_Nome_Arquivo_Envio_Genesio+" "+as_Retorno
						Return False
					End If
					
					w_ge614_aguarde.st_ftp.Text = "Aguarde... Enviando arquivo para o FTP do fornecedor..."
					
					//Aqui envia o arquivo via FTP para a Gen$$HEX1$$e900$$ENDHEX$$sio
					If Not of_Envia_Arquivo_Fornecedor(ls_Fornecedor, is_Dir_Arquivo_Manifestacao, ls_Nome_Arquivo_Envio_Genesio, Ref as_Retorno) Then
						as_Retorno = "Arquivo: "+ls_Nome_Arquivo_Envio_Genesio+" "+as_Retorno
						Return False
					End If
					
					//Move o arquivo para BKP
					If Not of_Move_Arquivo_Para_BKP(ls_Nome_Arquivo_Envio_Genesio, Ref as_Retorno) Then
						as_Retorno = "Arquivo: "+ls_Nome_Arquivo_Envio_Genesio+" "+as_Retorno
						Return False
					End If
				End Try
				
				w_ge614_aguarde.st_ftp.Text = ""
				
			End If
			w_ge614_aguarde.uo_Progress_2.of_setprogress(ll_Linha_Filial)
		Next		
		w_ge614_aguarde.uo_Progress_1.of_setprogress(ll_Linha_Genesio)
	Next
	
	//Deleta os aquivos com mais de 30 dias do BKP
	w_ge614_aguarde.st_ftp.Text = "Limpando BKP antigo... Aguarde..."
	
	If Not of_Exclui_BKP_Antigo(Ref as_Retorno) Then
		Return False
	End If
Finally
	Destroy(lds_Fornecedor_Genesio)
	Destroy(lds_Filiais)
	Destroy(lds_Notas)
	Destroy(lo_Evento_Sefaz)
	Destroy(lo_Nfe)
	Close(w_ge614_aguarde)
End Try

Return True
end function

public function boolean of_finaliza_arquivo (ref string as_retorno);String		ls_Parte_XML

Integer li_Write


ls_Parte_XML =  "</raiz>"

li_Write = FileWrite(ii_Arquivo_Envio, ls_Parte_XML)

If li_Write <> LenA(ls_Parte_XML) Then
	as_Retorno = "O arquivo foi corrompido ao finaliz$$HEX1$$e100$$ENDHEX$$-lo."
	Return False
End If

If FileClose(ii_Arquivo_Envio) = -1 Then
	as_Retorno = "Ocorreu erro ao fechar o arquivo XML que ser$$HEX1$$e100$$ENDHEX$$ enviado para a Gen$$HEX1$$e900$$ENDHEX$$sio."
	Return False
End If

Return True
end function

public function boolean of_monta_arquivo_manifestacao (long al_item, string as_xml_envio, string as_xml_retorno, ref string as_retorno);String ls_Parte_XML

Integer li_Write

ls_Parte_XML = '<item seq="'+String(al_Item)+'"><procEventoNFe><evento>'
ls_Parte_XML = ls_Parte_XML+ as_XML_Envio
ls_Parte_XML = ls_Parte_XML + '</evento><retEvento>'
ls_Parte_XML = ls_Parte_XML +  as_XML_Retorno
ls_Parte_XML = ls_Parte_XML +  '</retEvento></procEventoNFe></item>'

li_Write = FileWrite(ii_Arquivo_Envio, ls_Parte_XML)

If li_Write <> LenA(ls_Parte_XML) Then
	as_Retorno = "O arquivo foi corrompido ao montar o arquivo de envio ao fornecedor."
	Return False
End If

Return True
end function

public function boolean of_envia_arquivo_fornecedor (string as_fornecedor, string as_dir_arquivo, string as_nm_arquivo, ref string as_retorno);dc_uo_Ftp lo_Ftp

String	ls_Endereco_Ftp,&
		ls_Ususario_Ftp,&
		ls_Senha_Ftp

Try
	lo_Ftp = Create dc_uo_Ftp
	
	
	If as_Fornecedor = '053405371' Then //Genesio RS
        as_Fornecedor = '053400528' //Genesio
	End If

	select	de_endereco, 
			de_usuario,
			de_senha
	Into	:ls_Endereco_Ftp,
			:ls_Ususario_Ftp,
			:ls_Senha_Ftp
	from parametro_ftp_distribuidora
	where cd_fornecedor = :as_Fornecedor
	Using SqlCa;
													
	Choose Case SqlCa.SqlCode
		Case 0

		Case 100
			as_Retorno = "N$$HEX1$$e300$$ENDHEX$$o foi localizado os dados do FTP do fornecedor '"+as_Fornecedor+"'."
			Return False	
		Case -1
			as_Retorno = "Erro ao localizado os dados do FTP do fornecedor '"+as_Fornecedor+"': " + SqlCa.sqlErrText
			Return False
	End Choose												
													
													
	If Not lo_Ftp.of_Conecta_Ftp("", ls_Endereco_Ftp, ls_Ususario_Ftp, ls_Senha_Ftp, Ref as_Retorno ) Then	
		Return False
	End If

//	If Not lo_Ftp.of_Conecta_Ftp("", '10.0.0.4', 'nfe', 'nfe', Ref as_Retorno ) Then	
//		Return False
//	End If
	
	If lo_Ftp.of_Ftp_Set_Dir('minuta', Ref as_Retorno) = -1 Then 
		Return False
	End If
	
	If Not lo_Ftp.of_Ftp_Putfile( as_Dir_Arquivo+as_Nm_Arquivo, as_Nm_Arquivo, Ref as_Retorno) Then
		Return False
	End If
	
Finally
	Destroy(lo_Ftp)
End Try


Return True
end function

public function boolean of_arquivo_enviado_sefaz (string as_chave_acesso, ref string as_arquivo_envio, ref string as_retorno);String		ls_Lista_Arquivos[],&
			ls_Diretorio_Log,&
			ls_Xml

Long	ll_Qt_Arquivos,&
		ll_Linha,&
		ll_Linhas
		
Integer	li_FileOpen	

//ls_Diretorio_Log = "C:\NF\Log\"
ls_Diretorio_Log = "C:\NF\LogManifestacaoDestinatario\"

ll_Qt_Arquivos = gf_Dir_List(ls_Diretorio_Log, "*.xml", 1, ref ls_Lista_Arquivos[])
		
If ll_Qt_Arquivos > 0 Then
	
	ll_Linhas = UpperBound(ls_Lista_Arquivos[])
	
	For ll_Linha = 1 To ll_Linhas
		Try
			li_FileOpen = FileOpen (ls_Lista_Arquivos[ll_Linha] , TextMode! , Read!, LockRead! )
			FileReadEx (li_FileOpen, ls_Xml) 
		Finally
			FileClose (li_FileOpen)
		End Try
			
		If ls_Xml <> "" Then		
			If Pos(ls_Xml, as_Chave_Acesso) > 0 then
				If Pos(ls_Xml, '</envEvento>') > 0 then
					as_Arquivo_Envio = ls_Xml
					Return True
				End If
			End If
		End If		
	Next
			
End If

as_Retorno = "N$$HEX1$$c300$$ENDHEX$$O FOI LOCALIZADO O ARQUIVO XML DE ENVIO PARA A SEFAZ."

Return False
end function

public function boolean of_inicia_arquivo (string as_nome_arquivo, ref string as_retorno);String		ls_Parte_XML

Integer li_Write

as_Nome_Arquivo = is_Dir_Arquivo_Manifestacao + as_Nome_Arquivo

ii_Arquivo_Envio = FileOpen(as_Nome_Arquivo, LineMode!, Write!, LockWrite!, Append!)

If ii_Arquivo_Envio = -1 Then
	as_Retorno = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel criar o arquivo "+as_Nome_Arquivo
	Return False
End If


ls_Parte_XML =  "<raiz>"

li_Write = FileWrite(ii_Arquivo_Envio, ls_Parte_XML)

If li_Write <> LenA(ls_Parte_XML) Then
	as_Retorno = "O arquivo '"+as_Nome_Arquivo+"' est$$HEX1$$e100$$ENDHEX$$ corrompido."
	Return False
End If

Return True
end function

public function boolean of_move_arquivo_para_bkp (string as_arquivo, ref string as_retorno);Integer li_FileOpen



If Not FileExists (is_Dir_Arquivo_Manifestacao + "BKP/") Then
	If CreateDirectory(is_Dir_Arquivo_Manifestacao + "BKP/") <> 1 Then
		as_Retorno = "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio "+is_Dir_Arquivo_Manifestacao + "BKP/"
		Return False
	End If
End If

li_FileOpen = FileMove(is_Dir_Arquivo_Manifestacao + as_Arquivo, is_Dir_Arquivo_Manifestacao + "BKP/"+ as_Arquivo)	
					
If li_FileOpen < 0 Then 
	as_Retorno = "Erro ao mover o arquivo "+is_Dir_Arquivo_Manifestacao + as_Arquivo+" para o BKP."
	Return False
End If

Return True
end function

public function boolean of_exclui_bkp_antigo (ref string as_retorno);dc_uo_api lo_Api

String	ls_Arquivo,&
		ls_Lista_Arquivos[],&
		ls_Dir_BKP
		
Long	ll_Qt_Arquivos,&
		ll_Linha,&
		ll_Linhas
		
Date	ldt_Arquivo,&
		ldt_Atual

Try
	lo_Api = Create dc_uo_api
	
	ls_Dir_BKP	= is_Dir_Arquivo_Manifestacao+"BKP/"
	ldt_Atual		= Date(gf_GetServerDate())
	
	ll_Qt_Arquivos = gf_Dir_List(ls_Dir_BKP, "*.*", 1, ref ls_Lista_Arquivos[])
	
	If ll_Qt_Arquivos > 0 Then
	
		ll_Linhas = UpperBound(ls_Lista_Arquivos[])
		
		For ll_Linha = 1 To ll_Linhas
			ls_Arquivo = ls_Lista_Arquivos[ll_Linha] 
		
			ldt_Arquivo = Date(lo_Api.of_data_arquivo(ls_Dir_BKP	+	ls_Arquivo))
			
			ldt_Arquivo = RelativeDate(ldt_Arquivo, -30) 
			
			If ldt_Arquivo > ldt_Atual Then
				If Not FileDelete ( ls_Arquivo ) Then
					as_Retorno = "Erro ao excluir o BKP antigo. "+ls_Arquivo
					Return False
				End If
			End If
		Next
	End If
Finally
	Destroy(lo_Api)
End Try

Return True



end function

public function boolean of_grava_dh_envio_manifestacao (string as_chave_acesso, string as_id_manifestacao, ref string as_erro);string ls_nulo

setnull(ls_nulo)

return of_grava_dh_envio_manifestacao(as_chave_acesso, as_id_manifestacao, ls_nulo, as_erro)
end function

public function boolean of_parametro_conexao_ftp (ref string as_ftp_xml_endereco, ref string as_ftp_xml_usuario, ref string as_xml_ftp_senha, ref string as_erro);String ls_Parametro

ls_Parametro = 'DE_FTP_XML_ENDERECO'

select vl_parametro
Into :as_Ftp_Xml_Endereco
From parametro_geral
Where cd_parametro = :ls_Parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		as_Erro = "Par$$HEX1$$e200$$ENDHEX$$metro geral do FTP n$$HEX1$$e300$$ENDHEX$$o foi localizado '" + ls_Parametro + "'."
		Return False
	Case -1
		as_Erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro do FTP '" + ls_Parametro + "'."
		Return False
End Choose

If IsNull(as_Ftp_Xml_Endereco) or as_Ftp_Xml_Endereco = '' Then
	as_Erro = "Par$$HEX1$$e200$$ENDHEX$$metro do FTP inv$$HEX1$$e100$$ENDHEX$$lido '" + ls_Parametro + "'."
	Return False
End If

as_Ftp_Xml_Endereco = Lower(as_Ftp_Xml_Endereco)

ls_Parametro = 'DE_FTP_XML_USUARIO'

select vl_parametro
Into :as_Ftp_Xml_Usuario
From parametro_geral
Where cd_parametro = :ls_Parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		as_Erro = "Par$$HEX1$$e200$$ENDHEX$$mento usu$$HEX1$$e100$$ENDHEX$$rio FTP n$$HEX1$$e300$$ENDHEX$$o foi localizado '" + ls_Parametro + "'."
		Return False
	Case -1
		as_Erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro usu$$HEX1$$e100$$ENDHEX$$rio do FTP '" + ls_Parametro + "'."
		Return False
End Choose

If IsNull(as_Ftp_Xml_Usuario) or as_Ftp_Xml_Usuario = '' Then
	as_Erro = "Par$$HEX1$$e200$$ENDHEX$$metro usu$$HEX1$$e100$$ENDHEX$$rio FTP inv$$HEX1$$e100$$ENDHEX$$lido '" + ls_Parametro  + "'."
	Return False
End If

as_Ftp_Xml_Usuario = Lower(as_Ftp_Xml_Usuario)

ls_Parametro = 'DE_FTP_XML_SENHA'

select vl_parametro
Into :as_Xml_Ftp_Senha
From parametro_geral
Where cd_parametro = :ls_Parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		as_Erro = "Par$$HEX1$$e200$$ENDHEX$$metro senha FTP n$$HEX1$$e300$$ENDHEX$$o foi localizado '" + ls_Parametro + "'."
		Return False
	Case -1
		as_Erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro senha do FTP '" + ls_Parametro + "'."
		Return False
End Choose

If IsNull(as_Xml_Ftp_Senha) or as_Xml_Ftp_Senha = '' Then
	as_Erro = "Par$$HEX1$$e200$$ENDHEX$$metro senha do FTP inv$$HEX1$$e100$$ENDHEX$$lido '" + ls_Parametro +  "'."
	Return False
End If

as_Xml_Ftp_Senha = Lower(as_Xml_Ftp_Senha)

Return True
end function

public function boolean of_envia_ftp_clamed (string as_diretorio_arquivo_xml, string as_chave_acesso, ref string as_erro);Return True
end function

public function boolean of_verifica_xms_existe_no_ftp (string as_chave_acesso, long al_filial, date adt_emissao, string as_cgc_destino, long al_nf, string as_serie, ref string as_erro);dc_uo_ftp lo_Ftp //GE040

String	ls_Xml_Ftp_Endereco,&
		ls_Xml_Ftp_Usuario,&
		ls_Xml_Ftp_Senha,&
		ls_Ano,&
		ls_Mes,&
		ls_Dia,&
		ls_CNPJ,&
		ls_Diretorio,&
		ls_Erro
		
String		ls_Arquivos[],&
			ls_Nome_Arquivo,&
			ls_Nome_Arquivo_Ftp,&
			ls_Path_XML,&
			ls_Dt_Emissao

Long	ll_Linha

Boolean	lb_Xml_Existe_No_Ftp =  False,&
			lb_Suceso = False

Try
	lo_Ftp		= Create dc_uo_ftp
	
	ls_Dt_Emissao = String (adt_Emissao , "YYYYMMDD")
	
	ls_Ano	 			= "Ano_"+Mid(ls_Dt_Emissao, 1, 4)
	ls_Mes				= "Mes_"+Mid(ls_Dt_Emissao, 5, 2)
	ls_Dia  				= "Dia_"+Mid(ls_Dt_Emissao, 7, 2)
	ls_CNPJ				= Mid(as_Chave_Acesso, 7, 14)
	ls_Nome_Arquivo	= as_Chave_Acesso +"-nfe.xml"
	
	If Not of_Parametro_conexao_ftp(Ref ls_Xml_Ftp_Endereco, Ref ls_Xml_Ftp_Usuario, Ref ls_Xml_Ftp_Senha, Ref as_Erro) Then
		Return False
	End If
	
	lo_Ftp.of_Desconecta_ftp()

	If Not lo_Ftp.of_Conecta_ftp("GN", ls_Xml_Ftp_Endereco, ls_Xml_Ftp_Usuario, ls_Xml_Ftp_Senha, Ref as_Erro) Then
		Return False
	End If
	
	ls_Diretorio = ls_Ano + "/" + ls_Mes + "/" + ls_Dia + "/" + ls_CNPJ

	
	If lo_Ftp.of_Ftp_Set_Dir(ls_Diretorio, Ref as_Erro) <> -1 Then 
		lo_Ftp.of_ftp_lista_arquivos( "", ref ls_Arquivos)
	
		For ll_Linha = 1 To UpperBound(ls_Arquivos)
			ls_Nome_Arquivo_Ftp = ls_Arquivos[ll_Linha]
			
			If ls_Nome_Arquivo = ls_Nome_Arquivo_Ftp Then
				lb_Xml_Existe_No_Ftp = True
				Exit
			End If		
		Next
	End If
	
	If Not lb_Xml_Existe_No_Ftp Then
		Try
			dc_uo_importa_nf_pedido_eletronico lo_Importa_Pedido_Eletronico
			uo_ge238_importa_xml lo_Importar_Xml
			uo_ge250_xml_pedido_eletronico lo_Pedido_Eletronico
			
			lo_Importa_Pedido_Eletronico	= Create dc_uo_importa_nf_pedido_eletronico
			lo_Importar_Xml		= Create uo_ge238_importa_xml
			lo_Pedido_Eletronico	= Create uo_ge250_xml_pedido_eletronico
			
			If Not lo_Importar_Xml.of_diretorio_leitura_xml() Then
				as_Erro = "Erro ao localizar o diret$$HEX1$$f300$$ENDHEX$$rio de leitura do arquivo XML. Fun$$HEX2$$e700e300$$ENDHEX$$o  lo_Importar_Xml.of_diretorio_leitura_xml()"
				Return False
			End If
			
			If Not lo_Pedido_Eletronico.of_Diretorio_Importacao_XML(ref ls_Path_XML) Then Return False
			
			If Not lo_Importa_Pedido_Eletronico.of_download_xml_sefaz(as_Chave_Acesso, al_Filial, Ref as_Erro, lo_Importar_Xml.is_Diretorio_Leitura, ls_Path_XML) Then
				Return False
			End If
			
			If Not lo_Importar_Xml.io_ftp.of_conecta_ftp("GN", ls_Xml_Ftp_Endereco, ls_Xml_Ftp_Usuario, ls_Xml_Ftp_Senha, Ref as_Erro) Then
				Return False
			End If
			
			If lo_Importar_Xml.of_envia_ftp_clamed(  lo_Importar_Xml.is_Diretorio_Leitura + ls_Nome_Arquivo, ls_Dt_Emissao, ls_CNPJ, as_Chave_Acesso, "NFE") Then
				If lo_Importar_Xml.of_insere_nfe_indexacao(as_Chave_Acesso, Mid(as_Chave_Acesso, 7, 14), as_Cgc_Destino, al_Nf, as_Serie, adt_Emissao, "NFE") Then
					lb_Suceso = True
				End If
			End If
			
			If Not lb_Suceso Then
				as_Erro = "Erro ao enviar o XML "+as_Chave_Acesso+" para o ftp."
				Return False
			End If
		Finally
			lo_Importar_Xml.io_ftp.of_Desconecta_ftp()
			
			Destroy(lo_Importa_Pedido_Eletronico)
			Destroy(lo_Importar_Xml)
			Destroy(lo_Pedido_Eletronico)
		End Try
	End If
	
Finally
	lo_Ftp.of_desconecta_ftp()
	
	Destroy(lo_Ftp)
	Destroy(lo_Importar_Xml)
	Destroy(lo_Pedido_Eletronico)
End Try


Return True
end function

public function boolean of_grava_dh_envio_manifestacao (string as_chave_acesso, string as_id_manifestacao, string as_mensagem_log, ref string as_erro);String	ls_de_log_envio_sefaz

if isnull(as_mensagem_log) then
	
	update nfe_destinadas
	Set dh_envio_manifestacao	= GetDate()
	where de_chave_acesso		= :as_Chave_Acesso
		and id_manifestacao		= :as_id_manifestacao
	Using SqlCa;
	
else
	ls_de_log_envio_sefaz	= Left(as_mensagem_log, 255)
	
	update nfe_destinadas
	Set dh_envio_manifestacao	= GetDate(), de_log_envio_sefaz = :ls_de_log_envio_sefaz
	where de_chave_acesso		= :as_Chave_Acesso
		and id_manifestacao		= :as_id_manifestacao
	Using SqlCa;
	
end if

Choose Case SqlCa.SqlCode
	Case 0
		Return True
	Case -1
		as_Erro = "Erro ao gravar a dh_envio_manifestacao na tabela 'nf_destinadas'. " + SqlCa.sqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_grava_log_envio_sefaz (string as_chave_acesso, string as_id_manifestacao, string as_mensagem_log, ref string as_erro);
update nfe_destinadas
Set de_log_envio_sefaz = :as_mensagem_log
where de_chave_acesso		= :as_Chave_Acesso
	and id_manifestacao		= :as_id_manifestacao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
	Case -1
		as_Erro = "Erro ao gravar a de_log_envio_sefaz na tabela 'nf_destinadas'. " + SqlCa.sqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_manifestacao_destinatario (string as_tipo, ref string as_retorno);Long	ll_Linhas,&
		ll_Linha,&
		ll_Qtde,&
		ll_Filial,&
		ll_Nota,&
		ll_Prazo_Limite

Integer	li_Evento
		
String		ls_Chave_Acesso,&
			ls_Justificativa,&
			ls_Orgao,&
			ls_Situacao_Nf,&
			ls_CNPJ,&
			ls_UF,&
			ls_Status,&
			ls_Protocolo,&
			ls_Data_Evento,&
			ls_Id_Evento,&
			ls_Cnpj_Filial,&
			ls_Serie, &
			ls_log_mensagem
			
DateTime	ldh_Evento,&
				ldh_Emissao
				
String ls_De_Tipo				
			

dc_uo_ds_Base			lds_Notas
uo_ge614_eventos_Sefaz	lo_Evento_Sefaz
dc_uo_nfe				lo_Nfe

Try
	Open(w_Aguarde)
	w_Aguarde.Title = "Emitindo Manifesta$$HEX2$$e700e300$$ENDHEX$$o do Destinat$$HEX1$$e100$$ENDHEX$$rio ..."
	
	lds_Notas			= Create dc_uo_ds_Base
	lo_Evento_Sefaz	= Create uo_ge614_eventos_Sefaz
	lo_Nfe				= Create dc_uo_nfe
	
	If Not lds_Notas.of_ChangeDataObject("ds_ge614_notas_manifestacao_destinatario") Then
		as_Retorno = "Erro no changeDataObject. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_manifestacao_destinatario"
		Return False
	End If
	
	If Not gvb_Auto Then
		This.of_Abre_Log()
	End If
	
	ll_Linhas = lds_Notas.Retrieve(as_tipo)
	
	If ll_Linhas < 0 Then
		as_Retorno = "Erro no Retrieve. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_manifestacao_destinatario"
		Return False
	End If
	
	w_Aguarde.uo_Progress.of_setmax(ll_Linhas)
	
	For ll_Linha = 1 To ll_Linhas
		
		w_Aguarde.Title = "Emitindo Manifesta$$HEX2$$e700e300$$ENDHEX$$o do Destinat$$HEX1$$e100$$ENDHEX$$rio ... " + String(ll_Linha) + " de " + String(ll_Linhas) + " (" + as_tipo + ")"
		
		ls_Id_Evento = lds_Notas.Object.id_manifestacao[ll_Linha]
		Choose Case ls_Id_Evento
			Case "210200"
				li_Evento			= 1
				ls_Justificativa	= "Confirmacao da Operacao"
				ll_Prazo_Limite	= 90
			Case "210210"
				li_Evento			= 2
				ls_Justificativa	= "Ciencia da Operacao"
				ll_Prazo_Limite	= 10
			Case "210220"
				li_Evento			= 3
				ls_Justificativa	= "Desconhecimento da Operacao"
				ll_Prazo_Limite 	= 90
			Case "210240"
				li_Evento			= 4
				ls_Justificativa	= "Operacao nao Realizada"
				ll_Prazo_Limite	= 90
			Case Else
				as_Retorno = "Codigo do evento inv$$HEX1$$e100$$ENDHEX$$lido. id_manifestacao: "+ ls_Id_Evento
				Return False
		End Choose
		
		ls_Chave_Acesso	= lds_Notas.Object.de_chave_acesso	[ll_Linha]
		ls_CNPJ				= lds_Notas.Object.cgc_destino		[ll_Linha]
		ls_Orgao				= '91'// Nacional
		ls_Situacao_Nf		= '1'
		ls_UF					= lds_Notas.Object.uf					[ll_Linha]
		ldh_Emissao			= lds_Notas.Object.dh_emissao			[ll_Linha]
		ls_De_Tipo			= lds_Notas.Object.de_tipo				[ll_Linha]
		ll_Filial			= lds_Notas.Object.cd_filial			[ll_Linha]
		ls_Cnpj_Filial		= lds_Notas.Object.nr_cgc				[ll_Linha]
		ll_Nota				= lds_Notas.Object.nr_nf				[ll_Linha]
		ls_Serie				= lds_Notas.Object.de_serie			[ll_Linha]
		
		ldh_Evento			= gf_GetServerDAte()
		ls_Data_Evento		= String(ldh_Evento, "YYYY-MM-DD") +"T"+ String(ldh_Evento, "HH:MM:SS")
		
		ls_log_mensagem = ''
		
		If ls_De_Tipo = "COMPRA" Then
			If not of_verifica_xms_existe_no_ftp(ls_Chave_Acesso, ll_Filial, Date(ldh_Emissao), ls_Cnpj_Filial, ll_Nota, ls_Serie, Ref as_Retorno) Then
				continue
			End If
		End If
			
		//Valida prazo legal para envio do evento
		If DaysAfter(Date(ldh_Emissao), Date(ldh_Evento)) >= ll_Prazo_Limite Then
			
			ls_log_mensagem = "J$$HEX1$$e100$$ENDHEX$$ passou o prazo legal de "+String(ll_Prazo_Limite)+" dias para efetuar o "+ls_Justificativa+". Chave acesso: "+ ls_Chave_Acesso
			
			If of_grava_dh_envio_manifestacao(ls_Chave_Acesso, ls_Id_Evento, ls_log_mensagem, Ref as_Retorno) Then
				SqlCa.of_Commit()
			Else
				SqlCa.Of_Rollback()
				Return False
			End If
			
			If Not This.of_Grava_Log(ls_log_mensagem) Then
				as_Retorno = "Erro ao gravar log"
				Return False
			End If
		
			Continue
			
		End If
		
		Select count(1)
		Into :ll_Qtde
		From nfe_manifestacao
		Where de_chave_acesso =:ls_Chave_Acesso
		and id_evento = :ls_Id_Evento
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Retorno = "Erro ao verificar se j$$HEX1$$e100$$ENDHEX$$ havia manifesta$$HEX2$$e700e300$$ENDHEX$$o para a nota: "+ SqlCa.SQLErrText
			Return False
		End If
		
		If ll_Qtde = 0 Then
			If Not lo_Evento_Sefaz.of_Envia_Manifestacao_Destinatario_Novo(	li_Evento,&
																									ls_Chave_Acesso,&
																									ls_CNPJ,&
																									ls_Justificativa,&
																									ls_Orgao,&
																									ls_UF,&
																									ls_Data_Evento,&
																									Ref as_Retorno) Then
				Return False																					
			End If	
			
			ls_Status = lo_Nfe.of_get_value_tag(as_Retorno, "<cStat>", 2)
			
			//Status
			//135 -> Evento registrado e vinculado a NF-e
			//573 -> Verificar duplicidade do evento (tpEvento + chNFe + nSeqEvento)
			//136 -> Evento registrado, mas n$$HEX1$$e300$$ENDHEX$$o vinculado a NF-e
			//650 -> Evento de Ciencia da Operacao para NFe cancelada ou denegada
			//491 -> Rejeicao: O tpEvento informado invalido
			//596 -> Rejei$$HEX2$$e700e300$$ENDHEX$$o: Evento apresentado fora do prazo: [prazo vigente] - 180 dias
			
			If (ls_Status = '135') or (ls_Status = '573') or (ls_Status = '136') or (ls_Status = '650') Then
				If ls_Status = '573' Then
					
					ls_log_mensagem = "Chave: "+ ls_Chave_Acesso + ". Fun$$HEX2$$e700e300$$ENDHEX$$o of_manifestacao_destinatario, e vai chamar a lo_Evento_Sefaz.of_consultar_nf(ls_Chave_Acesso, Ref as_Retorno)"
					
					If Not lo_Evento_Sefaz.of_consultar_nf(ls_Chave_Acesso, Ref as_Retorno) Then
						If Not This.of_Grava_Log(as_Retorno) Then
							as_Retorno = as_Retorno + "~r~rErro ao gravar log"
						End If
						
						Continue
					End If
					
					ls_log_mensagem = as_Retorno
					
					as_Retorno = Mid(as_Retorno, Pos('<retEvento', as_Retorno), Len(as_Retorno))
					
					ls_log_mensagem = as_Retorno	
				End If
	
				Choose case ls_Status
					case '135'
						ls_log_mensagem = 'Evento registrado e vinculado a NF-e.'
					case '136'
						ls_log_mensagem = 'Evento registrado, mas n$$HEX1$$e300$$ENDHEX$$o vinculado a NF-e.'
					case '650'
						ls_log_mensagem = 'Evento de Ciencia da Operacao para NFe cancelada ou denegada.'
				end choose
						
				ls_Protocolo =  lo_Nfe.of_get_value_tag(as_Retorno, '<nProt>', 1);
				
				If (Trim(ls_Protocolo) <> '') or (ls_Status = '650') Then
					If of_Grava_Retorno(ls_Chave_Acesso, ls_Situacao_Nf, li_Evento, ldh_Evento, ls_Protocolo, ls_Justificativa, 'N', Ref as_Retorno) Then
						If of_grava_dh_envio_manifestacao(ls_Chave_Acesso, ls_Id_Evento, ls_log_mensagem, Ref as_Retorno) Then							
							SqlCa.of_Commit()
						Else							
							SqlCa.Of_Rollback()
							Return False
						End If
					Else
						SqlCa.Of_Rollback()
						Return False
					End If
						 
				End If
			ElseIf  (ls_Status = '491') Then
				
				ls_log_mensagem = "(491) Rejeicao: O tpEvento informado invalido. Chave acesso: "+ ls_Chave_Acesso
				
				If of_Grava_Retorno(ls_Chave_Acesso, ls_Situacao_Nf, li_Evento, ldh_Evento, '000000000000000', ls_Justificativa, 'N', Ref as_Retorno) Then
					SqlCa.of_Commit()
				Else
					SqlCa.Of_Rollback()
					Return False
				End If
				
				If of_grava_log_envio_sefaz(ls_Chave_Acesso, ls_Id_Evento, ls_log_mensagem, Ref as_Retorno) Then
					SqlCa.of_Commit()
				Else
					SqlCa.Of_Rollback()
					Return False
				End If

				Sleep(3)
			elseif (ls_Status = '596') Then
				
				ls_log_mensagem = "(596) Rejei$$HEX2$$e700e300$$ENDHEX$$o: Evento apresentado fora do prazo: [prazo vigente] - "+String(ll_Prazo_Limite)+" dias. Chave acesso: "+ ls_Chave_Acesso
				
				If of_grava_dh_envio_manifestacao(ls_Chave_Acesso, ls_Id_Evento, ls_log_mensagem, Ref as_Retorno) Then
					SqlCa.of_Commit()
				Else
					SqlCa.Of_Rollback()
					Return False
				End If
				
				If Not This.of_Grava_Log(ls_log_mensagem) Then
					as_Retorno = "Erro ao gravar log"
					Return False
				End If
				
				Sleep(3)
			Else
				as_Retorno = "("+lo_Nfe.of_get_value_tag(as_Retorno, '<nProt>', 1)+") "+lo_Nfe.of_get_value_tag(as_Retorno, '<xMotivo>', 1)
				as_Retorno = as_Retorno+" "+"("+lo_Nfe.of_get_value_tag(as_Retorno, '<nProt>', 2)+") "+lo_Nfe.of_get_value_tag(as_Retorno, '<xMotivo>', 2)
				
				If Not This.of_Grava_Log(as_Retorno) Then
					as_Retorno = "Erro ao gravar log"
					Return False
				End If
			End If
		End If
		w_Aguarde.uo_Progress.of_setprogress(ll_Linha)
	Next
	
Catch ( runtimeerror  lo_rte )
	If Not This.of_Grava_Log( "Erro no envio de manifesto destinatario. Erro: "+lo_rte.GetMessage( )) Then
		as_Retorno = "Erro ao gravar log. Exception: "+lo_rte.GetMessage( )
	End If
	
	Return False
Finally
	If IsValid(lds_Notas) Then 
		If lds_Notas.RowCount() > 0 Then lds_Notas.RowsDiscard(1, lds_Notas.RowCount(), Primary!)
		Destroy(lds_Notas)
	End If
	
	If IsValid(lo_Evento_Sefaz) Then Destroy(lo_Evento_Sefaz)
	If IsValid(lo_Nfe) Then Destroy(lo_Nfe)
	If IsValid(w_Aguarde) Then Close(w_Aguarde)
End Try

Return True
end function

public function boolean of_processa_manifestacao_destinatario (string as_tipo);String ls_Retorno

Try
	of_Abre_Log()
	
	//Manifesta$$HEX2$$e700e300$$ENDHEX$$o de notas fiscais de compra com valor maior de R$100.000,00
	If Not This.of_manifestacao_destinatario(as_tipo, Ref ls_Retorno) Then
		This.of_Grava_Log(ls_Retorno) 
		Return False
	End If
	
	Return True
Finally
	FileClose (ii_Log )
End Try

end function

on uo_ge614_manifestacao_destinatario.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge614_manifestacao_destinatario.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_Dir_Arquivo_Manifestacao 	= gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")

If IsNull(is_Dir_Arquivo_Manifestacao) or Trim(is_Dir_Arquivo_Manifestacao) = '' Then 
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o diret$$HEX1$$f300$$ENDHEX$$rio 'c:\sistemas\gn\arquivos\' para a gera$$HEX2$$e700e300$$ENDHEX$$o do arquivo XML para enviar para o fornecedor .", StopSign!)
	Return -1
End If
end event

