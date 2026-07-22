HA$PBExportHeader$uo_ge330_agendamento_entrega.sru
forward
global type uo_ge330_agendamento_entrega from nonvisualobject
end type
end forward

global type uo_ge330_agendamento_entrega from nonvisualobject
end type
global uo_ge330_agendamento_entrega uo_ge330_agendamento_entrega

type variables
uo_ge073_gera_xml io_Xml

String		is_Token,&
			is_Http_WebService

Boolean 	ib_Envio_Entregou_Legado = False
end variables

forward prototypes
public function boolean of_processa_envio_arquivo_agendamento ()
private function boolean of_busca_xml_ftp (string as_chave_acesso, date adt_emissao, string as_cnpj_origem, ref string as_diretorio_arquivo, ref string as_erro_log)
private function boolean of_parametro_conexao_ftp (ref string as_ftp_endereco, ref string as_ftp_usuario, ref string as_ftp_senha, ref string as_erro_log)
private function boolean of_envia_arquivo (string as_xml_envio, ref string as_xml_retorno, ref string as_erro_log)
private function boolean of_grava_erro (string as_chave_acesso, string as_erro_log)
private function boolean of_processa_retorno_webservice (string as_xml_retorno, string as_chave_acesso, ref string as_erro_log)
private function boolean of_grava_entrega_nota (string as_chave_acesso, ref string as_erro_log)
private function boolean of_retira_caracteres_especiais (ref string as_xml_retorno, ref string as_erro_log)
public function boolean of_parametro ()
private function boolean of_monta_xml_envio (string as_chave_acesso, string as_diretorio_arquivo, ref string as_xml_envio, ref string as_erro_log)
private function boolean of_altera_qtd_volumes_nota (string as_chave_acesso, ref string as_xml_nota, ref string as_erro_log)
private function boolean of_localiza_qtde_volumes_nota (string as_chave_acesso, ref long al_qtde_volumes, ref string as_erro_log)
public function boolean of_distribuidora (string as_cnpj, ref string as_distribuidora, ref string as_erro_log)
public function boolean of_grava_historico (string as_chave_acesso, long al_qtde_volumes, ref string as_erro_log)
public function boolean of_url_entregou_com (ref string as_erro)
private function boolean of_grava_retorno_api (string as_chave_acesso, string as_xml_retorno, ref string as_erro)
end prototypes

public function boolean of_processa_envio_arquivo_agendamento ();dc_uo_ds_base lds_Notas

String		ls_Chave_Acesso,&
			ls_Cnpj_Fornecedor,&
			ls_Diretorio_Arquivo,&
			ls_Log,&
			ls_Xml_Envio,&
			ls_Xml_Retorno,&
			ls_Erro_Log
			
Date	ldh_Emissao	

Long	ll_Linha,&
		ll_Linhas
		
Boolean lb_Sucesso = False	

If Not of_Parametro() Then
	Return False
End If

Try

	lds_Notas 				= Create dc_uo_ds_base
	Open(w_Aguarde)
	w_Aguarde.Title = 'Enviando arquivos pra o site ...'
	
	If Not lds_Notas.of_ChangeDataObject("ds_ge330_lista_notas") Then Return False
	
	If lds_Notas.Retrieve() > 0 Then
			
		ll_Linhas	= lds_Notas.RowCount()
			
		w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
			
		For ll_Linha = 1 To ll_Linhas
				
			w_Aguarde.Title = 'Enviando arquivos pra o site ... '+String(ll_Linha)+' de '+String(ll_Linhas)
			w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
				
			ls_Chave_Acesso		= lds_Notas.Object.de_chave_acesso		[ll_Linha]
			ldh_Emissao				= Date(lds_Notas.Object.dh_emissao		[ll_Linha])
			ls_Cnpj_Fornecedor	= lds_Notas.Object.nr_cgc_fornecedor	[ll_Linha]
				
			If of_URL_Entregou_Com(Ref ls_Erro_Log) Then
				If of_Busca_Xml_Ftp(ls_Chave_Acesso, ldh_Emissao, ls_Cnpj_Fornecedor, Ref ls_Diretorio_Arquivo, Ref ls_Erro_Log) Then
					If of_Monta_Xml_Envio(ls_Chave_Acesso, ls_Diretorio_Arquivo, Ref ls_Xml_Envio, Ref ls_Erro_Log) Then
						If of_Envia_Arquivo(ls_Xml_Envio, Ref ls_Xml_Retorno, Ref ls_Erro_Log) Then			
							If of_Processa_Retorno_WebService(ls_Xml_Retorno, ls_Chave_Acesso, Ref ls_Erro_Log) Then
								If of_Grava_Entrega_Nota(ls_Chave_Acesso, Ref ls_Erro_Log) Then
									lb_Sucesso = True
								End If
							End If
						End If
					End If
				End If
			End If
				
			If Not lb_Sucesso Then
				If Not of_Grava_Erro(ls_Chave_Acesso, ls_Erro_Log) Then
					Return False
				End If
			End If
				
			//Deleta o arquivo j$$HEX1$$e100$$ENDHEX$$ utilizado
			If FileExists(ls_Diretorio_Arquivo) Then
				If Not FileDelete(ls_Diretorio_Arquivo )  Then
					ls_Log = "Erro ao deletar o arquivo j$$HEX1$$e100$$ENDHEX$$ utilizado. Diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_Diretorio_Arquivo + "'."
					Return False
				End If
			End If
		Next			
	End If

	
Finally
	Destroy(lds_Notas)
	Close(w_Aguarde)
End Try

Return True
end function

private function boolean of_busca_xml_ftp (string as_chave_acesso, date adt_emissao, string as_cnpj_origem, ref string as_diretorio_arquivo, ref string as_erro_log);String		ls_Ano,&
			ls_Mes,&
			ls_Dia,&
			ls_Cnpj,&
			ls_Arquivo_Xml,&
			ls_Diretorio,&
			ls_Endereco_Ftp,&
			ls_Usuario_Ftp,&
			ls_Senha_Ftp,&
			ls_Diretorio_Xml_Local
			
Long	ll_Ano,&
		ll_Mes,&
		ll_Dia

dc_uo_Ftp lo_Ftp

Try

	ls_Diretorio_Xml_Local = getcurrentdirectory()+"\Arquivos\"
	
	//Teste
	//ls_Diretorio_Xml_Local = "C:\Sistemas\WS"+"\Arquivos\"
	
	
	If Not FileExists(ls_Diretorio_Xml_Local) Then
		If CreateDirectory(ls_Diretorio_Xml_Local ) = -1 Then
			as_Erro_Log = "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio para a grava$$HEX2$$e700e300$$ENDHEX$$o do XML na m$$HEX1$$e100$$ENDHEX$$quina local. Diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_Diretorio_Xml_Local + "'."
			Return False
		End If
	End If
	
	If Not of_parametro_conexao_ftp(Ref ls_Endereco_Ftp, Ref ls_Usuario_Ftp, Ref ls_Senha_Ftp, Ref as_Erro_Log) Then Return False
	
	Try
		lo_Ftp = Create dc_uo_Ftp
		
		If Not lo_Ftp.of_Conecta_Ftp("", ls_Endereco_Ftp, ls_Usuario_Ftp, ls_Senha_Ftp, Ref as_Erro_Log) Then
			Return False
		End If
		
		ll_Ano = Year(adt_Emissao)
		ll_Mes = Month(adt_Emissao)
		ll_Dia = Day(adt_Emissao)
		
		ls_Ano = "Ano_"+String(ll_Ano)
		If ll_Mes < 10 Then ls_Mes = "Mes_0"+String(ll_Mes) Else ls_Mes = "Mes_"+String(ll_Mes)
		If ll_Dia < 10 Then ls_Dia = "Dia_0"+String(ll_Dia) Else ls_Dia = "Dia_"+String(ll_Dia)
		ls_Arquivo_Xml = as_Chave_Acesso+"-nfe.xml"
		
		ls_Diretorio = ls_Ano + "/" + ls_Mes + "/" + ls_Dia + "/" + as_Cnpj_Origem
		
		If lo_Ftp.of_Ftp_Set_Dir(ls_Diretorio, Ref as_Erro_Log) = 1 Then 
			If not lo_Ftp.of_Ftp_GetFile(ls_Arquivo_Xml, ls_Diretorio_Xml_Local+ls_Arquivo_Xml, Ref as_Erro_Log) Then
				as_Erro_Log += " XML n$$HEX1$$e300$$ENDHEX$$o localizado"
				Return False
			End If
		Else
			as_Erro_Log += " XML n$$HEX1$$e300$$ENDHEX$$o localizado"
			Return False
		End If

	Finally
		lo_Ftp.of_desconecta_ftp( )
		Destroy(lo_Ftp)
	End Try
	
	as_Diretorio_Arquivo = ls_Diretorio_Xml_Local+ls_Arquivo_Xml
	
Catch ( runtimeerror  lo_rte )
	as_Erro_Log = "Ocorreu erro ao buscar o XML no FTP. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try	

Return True
end function

private function boolean of_parametro_conexao_ftp (ref string as_ftp_endereco, ref string as_ftp_usuario, ref string as_ftp_senha, ref string as_erro_log);Try
	//Endere$$HEX1$$e700$$ENDHEX$$o FTP
	select vl_parametro
	Into :as_Ftp_Endereco
	From parametro_geral
	Where cd_parametro = 'DE_FTP_XML_ENDERECO'
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If IsNull(as_Ftp_Endereco) or as_Ftp_Endereco = '' Then
				as_Erro_Log = "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o FTP inv$$HEX1$$e100$$ENDHEX$$lido 'DE_FTP_XML_ENDERECO'."
				Return False
			End If
		Case 100
			as_Erro_Log = "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi localizado 'DE_FTP_XML_ENDERECO'."
			Return False
		Case -1
			as_Erro_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o 'DE_FTP_XML_ENDERECO'."
			Return False
	End Choose
	
	//Usuario FTP
	select vl_parametro
	Into :as_Ftp_Usuario
	From parametro_geral
	Where cd_parametro = 'DE_FTP_XML_USUARIO'
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If IsNull(as_Ftp_Usuario) or as_Ftp_Usuario = '' Then
				as_Erro_Log = "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o FTP inv$$HEX1$$e100$$ENDHEX$$lido 'DE_FTP_XML_USUARIO'."
				Return False
			End If
		Case 100
			as_Erro_Log = "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi localizado 'DE_FTP_XML_USUARIO'."
			Return False
		Case -1
			as_Erro_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o 'DE_FTP_XML_USUARIO'."
			Return False
	End Choose
	
	
	//Senha FTP
	select vl_parametro
	Into :as_Ftp_Senha
	From parametro_geral
	Where cd_parametro = 'DE_FTP_XML_SENHA'
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If IsNull(as_Ftp_Senha) or as_Ftp_Senha = '' Then
				as_Erro_Log = "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o FTP inv$$HEX1$$e100$$ENDHEX$$lido 'DE_FTP_XML_SENHA'."
				Return False
			End If
		Case 100
			as_Erro_Log = "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o FTP n$$HEX1$$e300$$ENDHEX$$o foi localizado 'DE_FTP_XML_SENHA'."
			Return False
		Case -1
			as_Erro_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o ''DE_FTP_XML_SENHA''."
			Return False
	End Choose

Catch ( runtimeerror  lo_rte )
	as_Erro_Log = "Ocorreu erro ao localizar os par$$HEX1$$e200$$ENDHEX$$metro de conex$$HEX1$$e300$$ENDHEX$$o com o FTP. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try		
	
Return True
end function

private function boolean of_envia_arquivo (string as_xml_envio, ref string as_xml_retorno, ref string as_erro_log);String		ls_status_text

long   ll_status_code

OleObject lo_xmlhttp

Try
	Try
		lo_xmlhttp = CREATE oleobject
		
		lo_xmlhttp.ConnectToNewObject("Msxml2.ServerXMLHTTP.6.0")
		
		lo_xmlhttp.open ("POST", is_Http_WebService, False)
		
		lo_xmlhttp.setRequestHeader("Content-Type", "text/xml") 
		
		if IsNull(as_Xml_Envio) or Trim(as_Xml_Envio) = '' then
			as_Erro_Log = "XML de envio para o agendamento est$$HEX1$$e100$$ENDHEX$$ em branco."
			Return False
		end if
		
		lo_xmlhttp.send(as_Xml_Envio)
		
		//Pega a resposta do web service
		ls_status_text = lo_xmlhttp.StatusText
		ll_status_code = lo_xmlhttp.Status
		
		if ll_status_code >= 300 or ll_status_code = 0 then
			as_Erro_Log = "Erro no retorno do Web Service. C$$HEX1$$f300$$ENDHEX$$digo do erro:" +String(ll_status_code)+ " Descri$$HEX2$$e700e300$$ENDHEX$$o do erro:" + ls_status_text
		else
		//Pega o retorno do web service
			as_Xml_Retorno = lo_xmlhttp.ResponseText
		end if
	
		//Disconecta
		lo_xmlhttp.DisconnectObject()
	Finally
		Destroy(lo_xmlhttp)
	End Try
Catch (RuntimeError rte)
	as_Erro_Log = "Ocorreu erro ao enviar o arquivo para o Web Service. Erro: " + rte.getMessage()
	Return False
End Try

Return True
end function

private function boolean of_grava_erro (string as_chave_acesso, string as_erro_log);String ls_Erro

Update nf_agendamento_ent
Set de_retorno_webservice = left(:as_Erro_log, 250)
Where de_chave_acesso = :as_Chave_Acesso
Using SqlCa;

If  SqlCa.SqlCode  = -1 Then
	ls_Erro =  SqlCa.SQLErrText
	SqlCa.of_Rollback()
	MessageBox("Erro", "Erro ao gravar o log da nota referente a chave de acesso '"+as_Chave_Acesso+"' : "+ls_Erro)
	Return False			
End If

SqlCa.of_Commit()
Return True
end function

private function boolean of_processa_retorno_webservice (string as_xml_retorno, string as_chave_acesso, ref string as_erro_log);String		ls_Codigo_Retorno,&
			ls_Texto_Retorno
	
If Not of_Retira_Caracteres_Especiais(Ref as_Xml_Retorno, Ref as_Erro_Log) Then
	Return False
End If

If Not of_Grava_Retorno_Api(as_chave_acesso, as_xml_retorno, Ref as_erro_log) Then
	Return False
End If

If Pos(as_Xml_Retorno, '<ind_sucesso xsi:type="xsd:boolean">true</ind_sucesso>') > 0 Then
	Return True
Else
	ls_Codigo_Retorno		= io_Xml.of_busca_conteudo_tag(as_Xml_Retorno, "faultcode")
	ls_Texto_Retorno		= io_Xml.of_busca_conteudo_tag(as_Xml_Retorno, "faultstring")	
	
	as_Erro_Log = ls_Codigo_Retorno +" - "+ls_Texto_Retorno +" "+ as_Erro_Log
	
	Return False
End If

end function

private function boolean of_grava_entrega_nota (string as_chave_acesso, ref string as_erro_log);String ls_Erro

Update nf_agendamento_ent
Set	dh_envio_site = getdate(),
		de_retorno_webservice = null	
Where de_chave_acesso = :as_Chave_Acesso
Using SqlCa;

If  SqlCa.SqlCode  = -1 Then
	ls_Erro =  SqlCa.SQLErrText
	SqlCa.of_Rollback()
	as_erro_log = "Erro ao gravar a data de entrega no site da nota referente a chave de acesso '"+as_Chave_Acesso+"' : "+ls_Erro
	Return False			
End If

SqlCa.of_Commit()

Return True


end function

private function boolean of_retira_caracteres_especiais (ref string as_xml_retorno, ref string as_erro_log);	//$$HEX1$$e700$$ENDHEX$$		->	$$HEX2$$c300a700$$ENDHEX$$
	//$$HEX1$$e300$$ENDHEX$$		->	$$HEX2$$c300a300$$ENDHEX$$ $$HEX2$$c300a300$$ENDHEX$$
	//$$HEX1$$e100$$ENDHEX$$		->	$$HEX2$$c300a100$$ENDHEX$$
	//$$HEX1$$ed00$$ENDHEX$$		->	$$HEX2$$c300ad00$$ENDHEX$$
	//$$HEX1$$ea00$$ENDHEX$$		->	$$HEX2$$c300aa00$$ENDHEX$$
	
Try	
	as_Xml_Retorno = gf_Replace(as_Xml_Retorno,	"$$HEX2$$c300a700$$ENDHEX$$",	"$$HEX1$$e700$$ENDHEX$$",	0)
	as_Xml_Retorno = gf_Replace(as_Xml_Retorno,	"$$HEX2$$c300a300$$ENDHEX$$",	"$$HEX1$$e300$$ENDHEX$$",	0)
	as_Xml_Retorno = gf_Replace(as_Xml_Retorno,	"$$HEX2$$c300a100$$ENDHEX$$",	"$$HEX1$$e100$$ENDHEX$$",	0)
	as_Xml_Retorno = gf_Replace(as_Xml_Retorno,	"$$HEX2$$c300ad00$$ENDHEX$$",	"$$HEX1$$ed00$$ENDHEX$$",		0)
	as_Xml_Retorno = gf_Replace(as_Xml_Retorno,	"$$HEX2$$c300aa00$$ENDHEX$$",	"$$HEX1$$ea00$$ENDHEX$$",	0)
	as_Xml_Retorno = gf_Replace(as_Xml_Retorno,	"$$HEX1$$ca00$$ENDHEX$$",	"E",	0)
	
	as_Xml_Retorno = gf_Replace(as_Xml_Retorno,	"$$HEX1$$ca00$$ENDHEX$$",	"E",	0)
	as_Xml_Retorno = gf_Replace(as_Xml_Retorno,	"$$HEX1$$c700$$ENDHEX$$", 	"C", 	0)
	as_Xml_Retorno = gf_Replace(as_Xml_Retorno,	 "$$HEX1$$c300$$ENDHEX$$", 	"A", 	0)
	
	as_Xml_Retorno = gf_Replace(as_Xml_Retorno,	 "#", 	"",	0)
	
	

	
	Catch ( runtimeerror  lo_rte )
	as_Erro_Log = "Ocorreu erro ao retirar os caracteres especiais do retorno do web service. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try	
	
	
Return TRue
end function

public function boolean of_parametro ();String	ls_Parametro

select vl_parametro
Into :ls_Parametro
from wms_parametro
where cd_parametro = 'ID_AGENDAMENTO'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If ls_Parametro <> 'S' Then
			Return False
		End If
		
	Case 100
		Return False
		
	Case -1
		MessageBox("Erro", "Erro ao verificar o par$$HEX1$$e200$$ENDHEX$$metro 'ID_AGENDAMENTO': "+SqlCa.SQLErrText)
		Return False
End Choose

/// Parametro Envia ou n$$HEX1$$e300$$ENDHEX$$o Pelo Legao.
ib_Envio_Entregou_Legado = gf_parametro_agendamento_legado()


Return True
end function

private function boolean of_monta_xml_envio (string as_chave_acesso, string as_diretorio_arquivo, ref string as_xml_envio, ref string as_erro_log);String		ls_Cnpj_Origem,&
			ls_Cnpj_Destino,&
			ls_Tipo_Arquivo,&
			ls_Conteudo_Arquivo,&
			ls_Parte_Xml,&
			ls_Transportadora,&
			ls_Aux
			
Integer li_FileOpen

Long	ll_Pos_Inicio,&
		ll_Pos_Fim, ll_FileOpen
		
Blob lbl_Conteudo, lbl_Conteudo_Temp

Try
	ll_FileOpen = FileOpen(as_diretorio_arquivo, streammode!)

	DO WHILE FileRead(ll_FileOpen, lbl_Conteudo_Temp) > 0
		lbl_Conteudo += lbl_Conteudo_Temp
	LOOP
	
	FileClose(ll_FileOpen)
	ls_Conteudo_Arquivo = String(lbl_Conteudo, EncodingUTF8!)
	
	If ll_FileOpen < 0 Then
		as_Erro_Log = "Erro na leitura do arquivo XML da Chave NF: " + as_chave_acesso
		Return False
	End If
	
	ls_Conteudo_Arquivo   = gf_Replace(ls_Conteudo_Arquivo, "~r~n ", "", 0)
	ls_Conteudo_Arquivo   = gf_Replace(ls_Conteudo_Arquivo, "~n ", "", 0)
	ls_Conteudo_Arquivo   = gf_Replace(ls_Conteudo_Arquivo, "~r ", "", 0)
	
	ls_Conteudo_Arquivo   = gf_Replace(ls_Conteudo_Arquivo, "~r~n", "", 0)
	ls_Conteudo_Arquivo   = gf_Replace(ls_Conteudo_Arquivo, "~n", "", 0)
	ls_Conteudo_Arquivo   = gf_Replace(ls_Conteudo_Arquivo, "~r", "", 0)
	
	// Adicionado devido a problemas com algumas notas (ver se porde ser usado na of_retira_caracteres_especiais)
//	ls_Conteudo_Arquivo   = gf_Replace(ls_Conteudo_Arquivo, "$$HEX1$$ca00$$ENDHEX$$", "E", 0)
//	ls_Conteudo_Arquivo   = gf_Replace(ls_Conteudo_Arquivo, "$$HEX1$$c700$$ENDHEX$$", "C", 0)
//	ls_Conteudo_Arquivo   = gf_Replace(ls_Conteudo_Arquivo, "$$HEX1$$c300$$ENDHEX$$", "A", 0)
	
	ls_Conteudo_Arquivo   = gf_Replace(ls_Conteudo_Arquivo, "$$HEX2$$c200ba00$$ENDHEX$$", "$$HEX1$$ba00$$ENDHEX$$", 0)
	//ls_Conteudo_Arquivo   = gf_Replace(ls_Conteudo_Arquivo, "%", "", 0)
	ls_Conteudo_Arquivo   = gf_Replace(ls_Conteudo_Arquivo, "$$HEX2$$c3006001$$ENDHEX$$", "E", 0)
	ls_Conteudo_Arquivo   = gf_Replace(ls_Conteudo_Arquivo, "$$HEX2$$c300a700$$ENDHEX$$", "$$HEX1$$c700$$ENDHEX$$", 0)
	ls_Conteudo_Arquivo   = gf_Replace(ls_Conteudo_Arquivo,"$$HEX2$$c300a300$$ENDHEX$$","$$HEX1$$e300$$ENDHEX$$", 0)		
	ls_Conteudo_Arquivo   = gf_Replace(ls_Conteudo_Arquivo,"$$HEX2$$c300b100$$ENDHEX$$","$$HEX1$$f100$$ENDHEX$$", 0)		
	ls_Conteudo_Arquivo   = gf_Replace(ls_Conteudo_Arquivo,"$$HEX2$$c300b100$$ENDHEX$$","$$HEX1$$f100$$ENDHEX$$", 0)	
	
	//ls_Conteudo_Arquivo   = gf_Replace(ls_Conteudo_Arquivo,"#","", 0)	
	ls_Conteudo_Arquivo   = gf_Replace(ls_Conteudo_Arquivo,"A$$HEX1$$a200$$ENDHEX$$","$$HEX1$$e200$$ENDHEX$$",0)
	

	//Retira  essa parte do XML, ocorre erro no WebService da Entregou.com e a nota n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ didponibilizada para agendamento
	DO
		ll_Pos_Inicio	= Pos(ls_Conteudo_Arquivo, "<![CDATA[")
		
		If ll_Pos_Inicio > 0 Then
			ll_Pos_Fim	= Pos(ls_Conteudo_Arquivo, "]]>") + Len("]]>")
	
			ls_Aux	= Mid(ls_Conteudo_Arquivo, ll_Pos_Inicio, ll_Pos_Fim - ll_Pos_Inicio)
		
			ls_Conteudo_Arquivo   = gf_Replace(ls_Conteudo_Arquivo, ls_Aux,"", 0)
		End if
	LOOP WHILE ll_Pos_Inicio > 0
	//
	

//	ls_Conteudo_Arquivo   = gf_retira_acentos(ls_Conteudo_Arquivo)	
	
	If Not of_Distribuidora(Mid(as_chave_acesso, 7, 14), Ref ls_Transportadora, Ref as_Erro_Log) Then
		Return False
	End If
	
	If ls_Transportadora = "S" Then
		If Not of_Altera_Qtd_Volumes_Nota(as_chave_acesso, Ref ls_Conteudo_Arquivo, Ref as_Erro_Log) Then
			Return False
		End If
	End If
	
	ls_Parte_Xml		= io_Xml.of_busca_conteudo_tag(ls_Conteudo_Arquivo, "emit")
	ls_Cnpj_Origem	= io_Xml.of_busca_conteudo_tag(ls_Parte_Xml, "CNPJ")
	
	ls_Parte_Xml		= io_Xml.of_busca_conteudo_tag(ls_Conteudo_Arquivo, "dest")
	ls_Cnpj_Destino	= io_Xml.of_busca_conteudo_tag(ls_Parte_Xml, "CNPJ")
	
	ls_Tipo_Arquivo	= "NOTAIN"
	
	as_Xml_Envio =	'<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '+&
							'xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" '+&
							'xmlns:urn="urn:xmethods-delayed-quotes">'+&
							'<soapenv:Header />'+&
							'<soapenv:Body>'+&
							'<urn:importFile soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+&
							'<arquivo>'+&
							'<token>'+is_Token+'</token>'+&
							'<cnpj_origem>'+ls_Cnpj_Origem+'</cnpj_origem>'+&
							'<cnpj_destino>'+ls_Cnpj_Destino+'</cnpj_destino>'+&
							'<tipo_arquivo>'+ls_Tipo_Arquivo+'</tipo_arquivo>'+&
							'<conteudo_arquivo>'+&
							'<![CDATA['+ls_Conteudo_Arquivo+']]>'+&
							'</conteudo_arquivo>'+&
							'</arquivo>'+&
							'</urn:importFile>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
	
Catch ( runtimeerror  lo_rte )
	as_Erro_Log = "Ocorreu erro ao montar o arquivo XML para envio. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try	

Return True
end function

private function boolean of_altera_qtd_volumes_nota (string as_chave_acesso, ref string as_xml_nota, ref string as_erro_log);Long	ll_Qtde_Volumes,&
		ll_Pos_1,&
		ll_Pos_2
		
String	ls_Tag_qVol,&
		ls_Tag_qVol_New

Try
	
	If of_Localiza_Qtde_Volumes_Nota(as_chave_acesso, Ref ll_Qtde_Volumes, Ref as_Erro_Log) Then
		If Not of_Grava_Historico(as_chave_acesso, ll_Qtde_Volumes, Ref as_Erro_Log) Then
			Return False
		End If
	Else
		Return False
	End If
	
	If ll_Qtde_Volumes > 0 Then
		ll_Pos_1 = Pos(as_Xml_Nota, "<qVol>")
		
		If ll_Pos_1 > 0 Then
			ll_Pos_2 = Pos(as_Xml_Nota, "</qVol>") + Len("</qVol>")
			
			ls_Tag_qVol = Mid(as_Xml_Nota, ll_Pos_1, ll_Pos_2 - ll_Pos_1)
			
			ls_Tag_qVol_New	= "<qVol>"+String(ll_Qtde_Volumes)+"</qVol>"
			
			as_Xml_Nota = gf_Replace(as_Xml_Nota, ls_Tag_qVol, ls_Tag_qVol_New, 1)
		Else
			If Pos(as_Xml_Nota, "</reboque>") > 0 Then
				ls_Tag_qVol_New	= "</reboque><vol><qVol>"+String(ll_Qtde_Volumes)+"</qVol></vol>"
				as_Xml_Nota = gf_Replace(as_Xml_Nota, "</reboque>", ls_Tag_qVol_New, 1)
				
			ElseIf Pos(as_Xml_Nota, "</veicTransp>") > 0 Then
				ls_Tag_qVol_New	= "</veicTransp><vol><qVol>"+String(ll_Qtde_Volumes)+"</qVol></vol>"
				as_Xml_Nota = gf_Replace(as_Xml_Nota, "</veicTransp>", ls_Tag_qVol_New, 1)	
				
			ElseIf Pos(as_Xml_Nota, "</retTransp>") > 0 Then
				ls_Tag_qVol_New	= "</retTransp><vol><qVol>"+String(ll_Qtde_Volumes)+"</qVol></vol>"
				as_Xml_Nota = gf_Replace(as_Xml_Nota, "</retTransp>", ls_Tag_qVol_New, 1)		
				
			ElseIf Pos(as_Xml_Nota, "</transporta>") > 0 Then
				ls_Tag_qVol_New	= "</transporta><vol><qVol>"+String(ll_Qtde_Volumes)+"</qVol></vol>"
				as_Xml_Nota = gf_Replace(as_Xml_Nota, "</transporta>", ls_Tag_qVol_New, 1)
			Else
				ls_Tag_qVol_New	= "</total><transp><modFrete>0</modFrete><vol><qVol>"+String(ll_Qtde_Volumes)+"</qVol></vol></transp>"
				as_Xml_Nota = gf_Replace(as_Xml_Nota, "</total>", ls_Tag_qVol_New, 1)
			End If
		End If
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Erro_Log = "Ocorreu erro ao alterar a quantidade de volumes da nota. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try	

Return True
end function

private function boolean of_localiza_qtde_volumes_nota (string as_chave_acesso, ref long al_qtde_volumes, ref string as_erro_log);Try
	Select	sum(case when coalesce(b.nr_embalagem_padrao, 0) = 0 then
						floor(a.qt_faturada)
					else
						floor(case when (a.qt_faturada % b.nr_embalagem_padrao) = 0 then
										a.qt_faturada / b.nr_embalagem_padrao
									else
										(a.qt_faturada / b.nr_embalagem_padrao) + (a.qt_faturada % b.nr_embalagem_padrao)
								end)
				end )
	Into :al_Qtde_Volumes		
	From nf_agendamento_ent_item a
	Left Join produto_geral b on b.cd_produto = a.cd_produto
	Where de_chave_acesso = :as_chave_acesso
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If IsNull(al_Qtde_Volumes) Then
				al_Qtde_Volumes = 0
			End If
		Case 100
			as_Erro_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado a quantidade de volumes da nota."
			Return False
		Case -1
			as_Erro_Log = "Erro ao localizar a quantidade de volumes da nota: "+SqlCa.SqlErrText
			Return False
	End Choose

Catch ( runtimeerror  lo_rte )
	as_Erro_Log = "Ocorreu erro ao localizar a quantidade de volumes da nota. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try	

Return True
end function

public function boolean of_distribuidora (string as_cnpj, ref string as_distribuidora, ref string as_erro_log);Long	ll_Qtde

Try
	select count(*)
	Into	:ll_Qtde
	from fornecedor				a
	inner join cidade				b	on		b.cd_cidade					= a.cd_cidade
	inner join distribuidora_uf	c	on		c.cd_distribuidora			= a.cd_fornecedor
											and	c.cd_unidade_federacao	= b.cd_unidade_federacao
	where a.nr_cgc							= :as_Cnpj
	  and c.id_homologando_pedido	= 'N'
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		as_Erro_Log = "Erro ao verificar se o fornecedor $$HEX1$$e900$$ENDHEX$$ distribuidora: "+SqlCa.SqlErrText
		Return False
	End If
	
	If ll_Qtde > 0 Then
		as_Distribuidora	= "S"
	Else
		as_Distribuidora	= "N"
	End If
	
	//Considera os fornecedores abaixo como distribuidora [Chamado 348274]
	//02064224000192	= MAGIC BRAZIL
	//10978220000148	= J.MOSER
	//05573430000116	= SISTEMA DE CURA FLORAIS DA DEUSA LTDA
	//03649093000178	= CLASSIC DISTRIBUIDORA
	//82277955000155	= NOVO NORDISK
	//77765840000170	= CONTABILISTA PAPELARIA E SUPRI
	//83118505000182	= MERCADO DAS EMBALAGENS LTDA
	//08258346000104	= ADA TINA COSMETICOS LTDA
	//15262530000185	= CAC UNIFORMES LTDA ME
	//02760107000163	= MAGNATECH EMBALAGENS
	//06132919000115	= EMBALAGENS NOVA TRENTO
	//08674593000183	= DISTRIPRIME DISTRIBUIDORA DE COSMETICOS
	//72266828000105	= ROMANO DISTRIBUIDORA LTDA EPP
	
	If	as_Cnpj = "02064224000192" or	&
		as_Cnpj = "10978220000148" or	&
		as_Cnpj = "05573430000116" or	&
		as_Cnpj = "03649093000178" or	&
		as_Cnpj = "82277955000155" or	&
		as_Cnpj = "77765840000170" or	&
		as_Cnpj = "83118505000182" or	&
		as_Cnpj = "08258346000104" or	&
		as_Cnpj = "15262530000185" or	&
		as_Cnpj = "02760107000163" or	&
		as_Cnpj = "06132919000115" or	&
		as_Cnpj = "08674593000183" or	&
		as_Cnpj = "72266828000105" Then
		
		as_Distribuidora	= "S"
	End If

Catch ( runtimeerror  lo_rte )
	as_Erro_Log = "Ocorreu erro ao verificar se o fornecedor $$HEX1$$e900$$ENDHEX$$ distribuidora. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True

end function

public function boolean of_grava_historico (string as_chave_acesso, long al_qtde_volumes, ref string as_erro_log);Long	ll_Qtde

Try
	Select count(*)
	Into :ll_Qtde
	From historico_agendamento_qtde_vol
	where de_chave_acesso = :as_Chave_Acesso
	Using	SqlCa;

	If SqlCa.SqlCode = -1 Then
		as_Erro_Log = "Erro no select da tabela 'historico_agendamento_qtde_vol': "+SqlCa.SqlErrText
		Return False
	End If
	
	If ll_Qtde > 0 Then
		Update historico_agendamento_qtde_vol
		Set	qt_volumes	= :al_Qtde_Volumes,
				dh_calculo	= GetDate()
		Where de_chave_acesso = :as_Chave_Acesso
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Erro_Log = "Erro no update da tabela 'historico_agendamento_qtde_vol': "+SqlCa.SqlErrText
			Return False
		End If
	Else
		Insert into historico_agendamento_qtde_vol(
			de_chave_acesso,
			qt_volumes,
			dh_calculo)
		Values(	:as_Chave_Acesso,
					:al_Qtde_Volumes,
					GetDate())
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Erro_Log = "Erro no inseret da tabela 'historico_agendamento_qtde_vol': "+SqlCa.SqlErrText
			Return False
		End If
	End If

Catch ( runtimeerror  lo_rte )
	as_Erro_Log = "Ocorreu erro ao grava o hist$$HEX1$$f300$$ENDHEX$$rico de quantidade de volumes calculados. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try



Return True
end function

public function boolean of_url_entregou_com (ref string as_erro);// Foi disponibilizado um amebiente de homolo$$HEX2$$e700e300$$ENDHEX$$o para o SAP, no entando n$$HEX1$$e300$$ENDHEX$$o foi feito nenhum teste via Sybase
// http://wshomolog.entregou.com.br/WSImportFile?wsdl

select vl_parametro
Into :is_Http_WebService
from wms_parametro
where cd_parametro = 'URL_ENTREGOU.COM'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o par$$HEX1$$e200$$ENDHEX$$metro 'URL_ENTREGOU.COM'."
		Return False
		
	Case -1
		as_Erro = "Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro 'URL_ENTREGOU.COM': "+SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

private function boolean of_grava_retorno_api (string as_chave_acesso, string as_xml_retorno, ref string as_erro);String ls_Erro, ls_Ind_Sucesso, ls_Nome_Arquivo, ls_Data_Hora_Agora
Integer li_Cod, ll_Pos_1, ll_Pos_2, ll_Pos_3, ll_Pos_4

SetNull(ls_Ind_Sucesso)
SetNull(ls_Nome_Arquivo)

ls_Data_Hora_Agora = string(gf_getserverdate(), 'yyyy-mm-dd hh:mm')

ll_Pos_1 	= (Pos(as_xml_retorno, '<ind_sucesso xsi:type="xsd:boolean">')) + 36
ll_Pos_2 	= (Pos(as_xml_retorno, '</ind_sucesso>'))
ls_Ind_Sucesso = Mid(as_xml_retorno, ll_Pos_1 , (ll_Pos_2 - ll_Pos_1) )

ll_Pos_3 = (Pos(as_xml_retorno, '<nm_arquivo xsi:type="xsd:string">')) + 34
ll_Pos_4 = (Pos(as_xml_retorno, '</nm_arquivo>')) 
ls_Nome_Arquivo = Mid(as_xml_retorno, ll_Pos_3 , (ll_Pos_4 - ll_Pos_3) )

Update nf_agendamento_ent
Set de_retorno_api = 'OK;' + :ls_Nome_Arquivo + ';' + :ls_Ind_Sucesso + ';' + :ls_Data_Hora_Agora
Where de_chave_acesso = :as_Chave_Acesso
Using SqlCa;

If  SqlCa.SqlCode  = -1 Then
	as_Erro = 'Erro ao gravar retorno api Chave: ' + as_chave_acesso + ';' + SqlCa.SQLErrText
	Return False			
End If

//******** Comentado porque no servidor falta o complemento de XML Parser e ai da erro -11 no importstring
//dc_uo_ds_base lds_Dados_Xml
//lds_Dados_Xml = Create dc_uo_ds_base
//If Not lds_Dados_Xml.of_ChangeDataObject("ds_ge330_importa_dados_xml") Then Return False
//li_Cod = lds_Dados_Xml.ImportString(XML!, as_Xml_Retorno)
//If li_Cod > 0 Then
//	ls_Ind_Sucesso 	= string(lds_Dados_Xml.object.ind_sucesso[1])
//	ls_Nome_Arquivo 	= string(lds_Dados_Xml.object.nm_arquivo[1])
//	If IsNull(ls_Nome_Arquivo) Or IsNull(ls_Ind_Sucesso) Then
//		Update nf_agendamento_ent
//		Set de_retorno_api = 'Erro;' + :ls_Nome_Arquivo + ';' + :ls_Ind_Sucesso + ';' + :ls_Data_Hora_Agora
//		Where de_chave_acesso = :as_Chave_Acesso
//		Using SqlCa;
//	Else
//		Update nf_agendamento_ent
//		Set de_retorno_api = 'OK;' + :ls_Nome_Arquivo + ';' + :ls_Ind_Sucesso + ';' + :ls_Data_Hora_Agora
//		Where de_chave_acesso = :as_Chave_Acesso
//		Using SqlCa;
//	End If
//	If  SqlCa.SqlCode  = -1 Then
//		as_Erro = 'Erro ao gravar retorno api Chave: ' + as_chave_acesso + ';' + SqlCa.SQLErrText
//		SqlCa.of_Rollback()
//		Return False			
//	End If
//Else
//	gvo_Aplicacao.of_Grava_Log("Erro na leitura do XML de retorno: " + string(li_Cod) )
//End If
//Destroy(lds_Dados_Xml)

Return True
end function

on uo_ge330_agendamento_entrega.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge330_agendamento_entrega.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Xml = Create uo_ge073_gera_xml

//Produ$$HEX2$$e700e300$$ENDHEX$$o
is_Token				= "3364F3EC1009DECA3B44940BCCBBBF09F57996FF"
//is_Http_WebService	= "http://ws.entregou.com.br/WSImportFile"  //ESSA URL FOI COLOCADA NO PAR$$HEX1$$c200$$ENDHEX$$METRO 'URL_ENTREGOU.COM', TABELA 'WMS_PARAMETRO'








//Homologa$$HEX2$$e700e300$$ENDHEX$$o
//is_Token					= "D7DDF8ED13F009AB510B6BDDDAA18D486210DAE8" 
//is_Http_WebService	= "http://wshomolog.entregou.com.br/WSImportFile"
end event

event destructor;Destroy(io_Xml)
end event

