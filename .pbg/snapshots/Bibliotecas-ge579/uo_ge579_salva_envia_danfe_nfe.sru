HA$PBExportHeader$uo_ge579_salva_envia_danfe_nfe.sru
forward
global type uo_ge579_salva_envia_danfe_nfe from nonvisualobject
end type
end forward

global type uo_ge579_salva_envia_danfe_nfe from nonvisualobject
end type
global uo_ge579_salva_envia_danfe_nfe uo_ge579_salva_envia_danfe_nfe

type prototypes
Function Integer ExportarDanfe(String as_XML, String as_GerarNoDiretorio, Ref String as_Retorno)  library "C:\Sistemas\DLL\SEFAZ\Eventos_Sefaz.dll" alias for "ExportarDanfe;Ansi"
end prototypes

type variables

end variables

forward prototypes
private function boolean of_parametro_conexao_ftp (ref string as_ftp_endereco, ref string as_ftp_usuario, ref string as_ftp_senha, ref string as_erro_log)
private function boolean of_baixa_xml_ftp (string as_chave_acesso, date adt_emissao, string as_cnpj_origem, string as_diretorio_arquivo, ref string as_erro_log)
public function boolean of_envia_email_filial (long al_filial, string as_mensagem, string as_anexos[], ref string al_msg_erro)
private function boolean of_exclui_arquivo (string as_arquivo, ref string as_erro)
private function boolean of_ler_xml (string as_diretorio_arquivo, ref string as_conteudo_arquivo, ref string as_erro_log)
private function boolean of_zipar_arquivos (string as_arquivos[], ref string as_diretorio_arquivo_zip, ref string as_erro_log)
public function boolean of_salva_danfe_xml_nfe (long al_filial, long al_nota, string as_especie, string as_serie, string as_chave_acesso, date adt_emissao, long al_cd_filial_pedido, long al_nr_pedido, string as_para_email, integer al_tipo_envio_arquivo, ref string as_erro)
public function boolean of_salva_danfe_xml_nfe (uo_ge040_args auo_args[], ref string as_nfs_ignoradas, ref string as_erro)
public subroutine of_ignora_nota (long al_nota, ref string as_nfs_ignoradas)
public function boolean of_envia_email (string as_email_destinatario, string as_mensagem, string as_anexos[], ref string al_msg_erro)
end prototypes

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

private function boolean of_baixa_xml_ftp (string as_chave_acesso, date adt_emissao, string as_cnpj_origem, string as_diretorio_arquivo, ref string as_erro_log);String		ls_Ano,&
			ls_Mes,&
			ls_Dia,&
			ls_Cnpj,&
			ls_Arquivo_Xml,&
			ls_Diretorio,&
			ls_Endereco_Ftp,&
			ls_Usuario_Ftp,&
			ls_Senha_Ftp
			
Long	ll_Ano,&
		ll_Mes,&
		ll_Dia

dc_uo_Ftp lo_Ftp

Try
	
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
			If not lo_Ftp.of_Ftp_GetFile(ls_Arquivo_Xml, as_Diretorio_Arquivo+ls_Arquivo_Xml, Ref as_Erro_Log) Then
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
	
Catch ( runtimeerror  lo_rte )
	as_Erro_Log = "Ocorreu erro ao buscar o XML no FTP. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try	

Return True
end function

public function boolean of_envia_email_filial (long al_filial, string as_mensagem, string as_anexos[], ref string al_msg_erro);Long ll_Linha

s_email lst_Email

For ll_Linha = 1 To UpperBound (as_anexos[])
	lst_Email.ps_anexo[ll_Linha] = as_anexos[ll_Linha]
Next

lst_Email.ps_mensagem = as_mensagem
lst_Email.pb_assinatura = True

If Not IsNull(al_filial) Then
	lst_email.ps_to[UpperBound(lst_email.ps_to)+1] = String(al_Filial, "0000") + '@clamedlocal.com.br'
End If

If Not gf_ge202_envia_email_padrao(301, lst_email, False) Then
	al_msg_erro = 'Erro ao enviar email para Filial: ' + string(al_filial)
	Return False	
End If

Return True

end function

private function boolean of_exclui_arquivo (string as_arquivo, ref string as_erro);	
Try
	Return FileDelete (as_Arquivo)
	
Catch	( runtimeerror  lo_rte )
	as_Erro = "Erro ao excluir o arquivo "+as_Arquivo+": " + lo_rte.GetMessage()
	Return False
End Try
end function

private function boolean of_ler_xml (string as_diretorio_arquivo, ref string as_conteudo_arquivo, ref string as_erro_log);Long ll_FileOpen

Blob lbl_Conteudo, lbl_Conteudo_Temp

ll_FileOpen = FileOpen(as_diretorio_arquivo, streammode!)

DO WHILE FileRead(ll_FileOpen, lbl_Conteudo_Temp) > 0
	lbl_Conteudo += lbl_Conteudo_Temp
LOOP

FileClose(ll_FileOpen)
as_conteudo_arquivo = String(lbl_Conteudo, EncodingUTF8!)

If ll_FileOpen < 0 Then
	as_Erro_Log = "Erro na leitura do arquivo XML."
	Return False
End If

Return True
end function

private function boolean of_zipar_arquivos (string as_arquivos[], ref string as_diretorio_arquivo_zip, ref string as_erro_log);Integer li_Sucesso, li_SaveExtraPath

String ls_Arquivo_Zip, ls_Erro

Long ll_Linha

dc_uo_zip lo_Zip
lo_Zip = Create dc_uo_zip

For ll_Linha = 1 To UpperBound (as_arquivos[])
	
	ls_Erro = lo_zip.of_zip(as_arquivos[ll_Linha], as_diretorio_arquivo_zip)
	
	If ls_Erro <> "" Then
		as_erro_log = 'Erro ao tentar compactar arquivos ' + ls_Erro
		Return False
	End If
Next

Destroy(lo_zip)		

Return True
end function

public function boolean of_salva_danfe_xml_nfe (long al_filial, long al_nota, string as_especie, string as_serie, string as_chave_acesso, date adt_emissao, long al_cd_filial_pedido, long al_nr_pedido, string as_para_email, integer al_tipo_envio_arquivo, ref string as_erro);String ls_Xml,&
		ls_Arquivo_Pdf,&
		ls_Arquivo,&
		ls_Diretorio,&
		ls_Diretorio_Xml, ls_Diretorio_Pdf,&
		ls_Diretorio_Dll, &
		ls_Cnpj_Origem, lvs_Path, ls_Anexos[], ls_Mensagem, ls_Diretorio_Obrigatorio, ls_Diretorio_Zip, ls_Arquivos[]
		
Long ll_tipo_arquivo

Try
	ls_Diretorio_Dll = "C:\Sistemas\DLL\SEFAZ\Eventos_Sefaz.dll"
	If Not FileExists(ls_Diretorio_Dll) Then
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado a DLL Eventos_Sefaz.dll no diret$$HEX1$$f300$$ENDHEX$$rio: " + ls_Diretorio_Dll
		Return False
	End If
	
	ls_Diretorio_Obrigatorio = "C:\NF\nfeconfig.ini"
	If Not FileExists(ls_Diretorio_Obrigatorio) Then
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o nfeConfig.ini no diret$$HEX1$$f300$$ENDHEX$$rio: " + ls_Diretorio_Obrigatorio
		Return False
	End If
	
	ls_Cnpj_Origem = Mid(as_Chave_Acesso, 7, 14)
	
	lvs_Path = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "")
	
	If lvs_Path = "" Then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o!','O diret$$HEX1$$f300$$ENDHEX$$rio default n$$HEX1$$e300$$ENDHEX$$o foi encontrado no arquivo INI da aplica$$HEX2$$e700e300$$ENDHEX$$o.')
		Return False
	End If
	
	lvs_Path = Trim (lvs_Path)
	If Mid (lvs_Path, Len (lvs_Path), 1) <> '\' then
		lvs_Path += '\'
	End if
	
	ls_Diretorio = lvs_Path + "Danfe\"
	
	If Not FileExists(ls_Diretorio) Then
		If CreateDirectory(ls_Diretorio ) = -1 Then
			as_Erro = "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio para a grava$$HEX2$$e700e300$$ENDHEX$$o do XML na m$$HEX1$$e100$$ENDHEX$$quina local. Diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_Diretorio + "'."
			Return False
		End If
	End If
	
	//Mensagem pro email
	ls_Mensagem = 'Ol$$HEX1$$e100$$ENDHEX$$,<br>Segue em anexo a DANFE/XML do Pedido: ' + string(al_nr_pedido) + ' - NF: ' + string(al_nota) + ', Especie: ' + as_especie + ', Serie: ' + as_serie + '<br>'
	
	//Baixa XML
	If Not of_Baixa_Xml_Ftp(as_Chave_Acesso, adt_Emissao, ls_Cnpj_Origem, ls_Diretorio, Ref as_Erro) Then
		Return False
	End If
	
	ls_Diretorio_Xml	= ls_Diretorio + as_Chave_Acesso + "-nfe.xml"
	ls_Diretorio_Pdf	= ls_Diretorio + as_Chave_Acesso + "-nfe.pdf"
	ls_Diretorio_Zip		= ls_Diretorio + as_Chave_Acesso + "-nfe.zip"
	
	//Ler XML
	If Not of_Ler_Xml(ls_Diretorio_Xml, Ref ls_XML, Ref as_Erro) Then
		Return False
	End If
	
	//Gera PDF
	If Not ExportarDanfe(ls_XML, ls_Diretorio_Pdf, Ref as_Erro) = 1 Then
		Return False
	End If
	
	If IsNull(al_tipo_envio_arquivo) Then 
		ll_tipo_arquivo = 1
	Else
		ll_tipo_arquivo = al_tipo_envio_arquivo
	End If
	
	If ll_tipo_arquivo = 1 Then
		ls_Arquivos[1] = ls_Diretorio_Xml
		ls_Arquivos[2] = ls_Diretorio_Pdf
				
	ElseIf ll_tipo_arquivo = 2 Then
		ls_Arquivos[1] = ls_Diretorio_Pdf
		
	ElseIf ll_tipo_arquivo = 3 Then
		ls_Arquivos[1] = ls_Diretorio_Xml
	End If
	
	//Zipar arquivos
	If Not of_Zipar_Arquivos(ls_Arquivos[], ls_Diretorio_Zip, Ref as_Erro) Then
		Return False
	End If
	
	ls_Anexos[1] = ls_Diretorio_Zip
	
	If IsNull(as_Para_Email) Then
		If Not of_Envia_Email_Filial (al_cd_filial_pedido, ls_Mensagem, ls_Anexos[], Ref as_Erro) Then
			Return False
		End If
	Else
		If Not of_Envia_Email (as_Para_Email, ls_Mensagem, ls_Anexos[], Ref as_Erro) Then
			Return False
		End If
	End If
	
	If Not of_Exclui_Arquivo(ls_Diretorio_Xml, Ref as_Erro) Then
		Return False
	End If
	
	If Not of_Exclui_Arquivo(ls_Diretorio_Pdf, Ref as_Erro) Then
		Return False
	End If
	
	If Not of_Exclui_Arquivo(ls_Diretorio_Zip, Ref as_Erro) Then
		Return False
	End If
	
	Return True
	
Catch	( runtimeerror  lo_rte )
	as_Erro = "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_salva_danfe_nfe': " + lo_rte.GetMessage()
End Try	
end function

public function boolean of_salva_danfe_xml_nfe (uo_ge040_args auo_args[], ref string as_nfs_ignoradas, ref string as_erro);Date		ldt_Emissao

String	ls_Xml,          &
			ls_Path,         &
			ls_Dll_Sefaz,    &
			ls_Diretorio,    &
			ls_Arquivo_Ini,  &
			ls_Arquivo_Pdf,  &
			ls_Arquivo_Xml,  &
			ls_Arquivo_Zip,  &
			ls_Cnpj_Origem,  &
			ls_Erro,         &
			ls_lista,        &
			ls_Mensagem,     &
			ls_Para_Email,   &
			ls_Chave_Acesso, &
			ls_Anexos [],    &
			ls_Arquivos [],  &
			ls_Arquivos_Excluir []

Long		ll_tipo_arquivo, &
			ll_qtd_notas,    &
			ll_linha,        &
			ll_anexos,       &
			ll_nota,         &
			ll_arqs

as_erro = ''

Try
	ll_qtd_notas = UpperBound (auo_args [])
	
	If ll_qtd_notas = 0 then
		as_erro = '~n~r' + 'Nenhuma nota foi informada!'
		Return False
	End if
		
	ls_Dll_Sefaz = 'C:\Sistemas\DLL\SEFAZ\Eventos_Sefaz.dll'
	If Not FileExists (ls_Dll_Sefaz) then
		as_erro = '~n~r' + 'N$$HEX1$$e300$$ENDHEX$$o foi localizado a DLL Eventos_Sefaz.dll no diret$$HEX1$$f300$$ENDHEX$$rio: ' + ls_Dll_Sefaz
		Return False
	End if
	
	ls_Arquivo_Ini = 'C:\NF\nfeconfig.ini'
	If Not FileExists (ls_Arquivo_Ini) then
		as_erro = '~n~r' + 'O arquivo de configura$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi encontrado: ' + ls_Arquivo_Ini
		Return False
	End if
	
	ls_Path = ProfileString (gvo_Aplicacao.ivs_Arquivo_INI, 'Diretorio', 'Diretorio', '')
	
	If ls_Path = '' then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o!','O diret$$HEX1$$f300$$ENDHEX$$rio default n$$HEX1$$e300$$ENDHEX$$o foi encontrado no arquivo INI da aplica$$HEX2$$e700e300$$ENDHEX$$o.')
		Return False
	End if
	
	ls_Path = Trim (ls_Path)
	If Mid (ls_Path, Len (ls_Path), 1) <> '\' then
		ls_Path += '\'
	End if
	
	ls_Diretorio = ls_Path + 'Danfe\'
	
	If Not FileExists (ls_Diretorio) then
		If CreateDirectory(ls_Diretorio ) = -1 then
			as_erro = 'Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio para a grava$$HEX2$$e700e300$$ENDHEX$$o do XML na m$$HEX1$$e100$$ENDHEX$$quina local. Diret$$HEX1$$f300$$ENDHEX$$rio: ' + ls_Diretorio + '.'
			Return False
		End if
	End if
	
	//Valores constantes para todas as notas do array:
	ls_Cnpj_Origem  = Mid (auo_args [1].of_get_arg ('de_chave_acesso'), 7, 14)
	ls_Para_Email   =      auo_args [1].of_get_arg ('de_para_email')
	ll_tipo_arquivo =      auo_args [1].of_get_arg ('id_tipo_envio_arquivo')
	
	If IsNull (ll_tipo_arquivo) then 
		ll_tipo_arquivo = 1
	End if
	
	//Mensagem pro email
	ls_Mensagem = 'Segue(m) em anexo o(s) DANFE/XML da(s) nota(s) listada(s) abaixo:' + '~n~n~r' + &
						'~t' + 'NF' + '~t' + 'Esp$$HEX1$$e900$$ENDHEX$$cie' + '~t' + 'S$$HEX1$$e900$$ENDHEX$$rie' + '~n~n~r'
	
	For ll_linha = 1 to ll_qtd_notas
		
		ls_Chave_Acesso = auo_args [ll_linha].of_get_arg ('de_chave_acesso')
		ll_Nota         = auo_args [ll_linha].of_get_arg ('nr_nota')
		ldt_Emissao     = auo_args [ll_linha].of_get_arg ('dh_emissao')
		
		ls_lista +=  '$$HEX1$$2220$$ENDHEX$$ ' + String (ll_Nota) + '~t' + auo_args [ll_linha].of_get_arg ('de_especie') + '~t' + auo_args [ll_linha].of_get_arg ('de_serie') + '~n~r'
		
		//Baixa XML
		If Not of_Baixa_Xml_Ftp (ls_Chave_Acesso, ldt_Emissao, ls_Cnpj_Origem, ls_Diretorio, Ref ls_Erro) then
			as_erro += '~n~r~t' + String (ll_Nota) + '~t' + ls_Erro
			of_ignora_nota (ll_Nota, Ref as_nfs_ignoradas)
			Continue
		End if
		
		ls_Arquivo_Xml = ls_Diretorio + ls_Chave_Acesso + '-nfe.xml'
		ls_Arquivo_Pdf = ls_Diretorio + ls_Chave_Acesso + '-nfe.pdf'
		ls_Arquivo_Zip = ls_Diretorio + ls_Chave_Acesso + '-nfe.zip'
		
		//Ler XML
		If Not of_Ler_Xml (ls_Arquivo_Xml, Ref ls_XML, Ref ls_Erro) then
			as_erro += '~n~r~t' + String (ll_Nota) + '~t' + ls_Erro
			of_ignora_nota (ll_Nota, Ref as_nfs_ignoradas)
			Continue
		End if
		
		//Gera PDF
		If Not ExportarDanfe (ls_XML, ls_Arquivo_Pdf, Ref ls_Erro) = 1 then
			as_erro += '~n~r~t' + String (ll_Nota) + '~t' + ls_Erro
			of_ignora_nota (ll_Nota, Ref as_nfs_ignoradas)
			Continue
		End if
		
		Choose case ll_tipo_arquivo
			case 1
				ls_Arquivos [1] = ls_Arquivo_Xml
				ls_Arquivos [2] = ls_Arquivo_Pdf
					
			case 2
				ls_Arquivos [1] = ls_Arquivo_Pdf
			
			case 3
				ls_Arquivos [1] = ls_Arquivo_Xml
				
		End choose
		
		//Zipar arquivos
		If Not of_Zipar_Arquivos (ls_Arquivos[], ls_Arquivo_Zip, Ref ls_Erro) then
			as_erro += '~n~r~t' + String (ll_Nota) + '~t' + ls_Erro
			of_ignora_nota (ll_Nota, Ref as_nfs_ignoradas)
			Continue
		End if
		
		ll_anexos ++
		ls_Anexos [ll_anexos] = ls_Arquivo_Zip
		
		ll_arqs = UpperBound (ls_Arquivos_Excluir [])
		ls_Arquivos_Excluir [ll_arqs + 1] = ls_Arquivo_Xml
		ls_Arquivos_Excluir [ll_arqs + 2] = ls_Arquivo_Pdf
		ls_Arquivos_Excluir [ll_arqs + 3] = ls_Arquivo_Zip
	Next
	
	If ll_anexos > 0 then
		ls_Mensagem += ls_lista
							
		If Not of_Envia_Email (ls_Para_Email, ls_Mensagem, ls_Anexos [], Ref ls_Erro) then
			as_erro += 'Erro no envio dos arquivos para o fornecedor ' + ls_Cnpj_Origem + ':' + '~n~r~t' + ls_Erro
			Return False
		End if
	End if
	
	ll_arqs = UpperBound (ls_Arquivos_Excluir [])
	
	For ll_linha = 1 to ll_arqs
		If Not of_Exclui_Arquivo (ls_Arquivos_Excluir [ll_linha], Ref ls_Erro) then
			as_erro += '~n~r~t' + ls_Erro
			Return False
		End if
	Next
	
	Return True
	
Catch	(runtimeerror  lo_rte )
	as_erro += '~n~r~t' + "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_salva_danfe_xml_nfe': " + lo_rte.GetMessage ()
	
End Try
end function

public subroutine of_ignora_nota (long al_nota, ref string as_nfs_ignoradas);String	ls_Nota

ls_Nota = String (al_nota)

If as_nfs_ignoradas = '' then
	as_nfs_ignoradas = ls_Nota
else
	If Not Match (as_nfs_ignoradas, ls_Nota) then
		as_nfs_ignoradas += ', ' + ls_Nota
	End if
End if

Return
end subroutine

public function boolean of_envia_email (string as_email_destinatario, string as_mensagem, string as_anexos[], ref string al_msg_erro);Long ll_Linha

s_email lst_Email

For ll_Linha = 1 To UpperBound (as_anexos[])
	lst_Email.ps_anexo[ll_Linha] = as_anexos[ll_Linha]
Next

lst_Email.ps_mensagem = as_mensagem
lst_Email.pb_assinatura = True

If Not IsNull(as_email_destinatario) Then
	lst_email.ps_to[UpperBound(lst_email.ps_to)+1] = as_email_destinatario
End If

If Not gf_ge202_envia_email_padrao(301, lst_email, False) Then
	al_msg_erro = 'Erro ao enviar email para o destinat$$HEX1$$e100$$ENDHEX$$rio: ' + as_email_destinatario
	Return False	
End If

Return True

end function

on uo_ge579_salva_envia_danfe_nfe.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge579_salva_envia_danfe_nfe.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

