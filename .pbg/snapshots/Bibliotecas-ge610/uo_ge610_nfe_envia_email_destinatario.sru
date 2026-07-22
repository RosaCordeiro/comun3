HA$PBExportHeader$uo_ge610_nfe_envia_email_destinatario.sru
forward
global type uo_ge610_nfe_envia_email_destinatario from nonvisualobject
end type
end forward

global type uo_ge610_nfe_envia_email_destinatario from nonvisualobject
end type
global uo_ge610_nfe_envia_email_destinatario uo_ge610_nfe_envia_email_destinatario

forward prototypes
public subroutine of_envia_nfe_por_email ()
public function boolean of_diretorio_danfe (ref string as_diretorio, ref string as_erro)
public function boolean of_grava_situacao_envio_email (long al_filial, long al_nr_nf, string as_especie, string as_serie, boolean ab_sucesso, string as_log_envio_email, ref string as_erro)
public function boolean of_ler_arquivo_xml (string as_arquivo, ref string as_xml, ref string as_erro)
private function boolean of_busca_xml_ftp (date at_emissao, string as_chave_acesso, string as_arquivo, string as_ftp_endereco, string as_ftp_usuario, string as_ftp_senha, ref string as_xml, ref string as_erro)
private function boolean of_envia_email (string as_email, string as_arquivo_xml, string as_arquivo_pdf, ref string as_erro)
public function boolean of_exclui_arquivos (string as_diretorio, ref string as_erro)
private subroutine of_envia_email_erro_processamento (string as_erro)
end prototypes

public subroutine of_envia_nfe_por_email ();dc_uo_ds_Base			lds_Notas
dc_uo_eventos_sefaz	lo_Eventos_Sefaz

Long	ll_Linhas,&
		ll_Linha,&
		ll_Filial,&
		ll_Nr_Nf,&
		ll_Filial_Destino

String	ls_Chave_Acesso,&
		ls_Ftp_Endereco,&
		ls_Ftp_Usuario,&
		ls_Ftp_Senha,&
		ls_Diretorio,&
		ls_Arquivo_Xml,&
		ls_Arquivo_Pdf,&
		ls_Xml,&
		ls_Email,&
		ls_Especie,&
		ls_Serie,&
		ls_Email_Para_Filial_Destino,&
		ls_Erro
		
Date 	ldt_Emissao

Boolean lb_Sucesso = False

Try
	Try
		lds_Notas			= Create dc_uo_ds_Base
		lo_Eventos_Sefaz	= Create dc_uo_eventos_sefaz

		Open(w_Aguarde)
		
		If not of_ge238_parametros_conexao_ftp(Ref ls_Ftp_Endereco, Ref ls_Ftp_Usuario, Ref ls_Ftp_Senha, ref ls_Erro) Then
			MessageBox("Erro", ls_Erro)
			Return
		End If
		
		If Not lds_Notas.of_ChangeDataObject("ds_ge610_notas_pendente_envio_email") Then
			MessageBox("Erro", "Erro no ChageDataObject da ds_ge610_notas_pendente_envio_email.")
			Return
		End If
		
		ll_Linhas	= lds_Notas.Retrieve()
		
		If ll_Linhas < 0 Then
			MessageBox("Erro", "Erro no Retrieve da ds_ge610_notas_pendente_envio_email.")
			Return
		End If
		
		w_Aguarde.Title = "Baixando XML ... "
		w_Aguarde.uo_Progress.of_setmax(ll_Linhas)
		
		If Not of_Diretorio_Danfe(Ref ls_Diretorio, Ref ls_Erro) Then
			MessageBox("Erro", ls_Erro)
			Return
		End If
		
		For ll_Linha = 1 To ll_Linhas
			lb_Sucesso = False
			
			w_Aguarde.Title = "Enviando NF-e por e-mail ... " + String(ll_Linha) + " de " + String(ll_Linhas)
			w_Aguarde.uo_Progress.of_setprogress(ll_Linha)
			
			ldt_Emissao							=	Date(lds_Notas.Object.dh_emissao				[ll_Linha]	)
			ls_Chave_Acesso					=	lds_Notas.Object.de_chave_acesso				[ll_Linha]	
			ls_Email								=	lds_Notas.Object.de_email							[ll_Linha]	
			ll_Filial								=	lds_Notas.Object.cd_filial								[ll_Linha]	
			ll_Nr_Nf								=	lds_Notas.Object.nr_nf								[ll_Linha]	
			ls_Especie							=	lds_Notas.Object.de_especie						[ll_Linha]	
			ls_Serie								=	lds_Notas.Object.de_serie							[ll_Linha]	
			ls_Email_Para_Filial_Destino	=	lds_Notas.Object.id_email_para_filial_destino	[ll_Linha]	
			ll_Filial_Destino						=	lds_Notas.Object.cd_filial_destino					[ll_Linha]	
			
			//N$$HEX1$$e300$$ENDHEX$$o envia e-mail se o e-mail for para a filial e se a filial de destino for a matriz
			If ((ls_Email_Para_Filial_Destino = "S") and (ll_Filial_Destino = 2)) Then
				lb_Sucesso = True
			else	
				ls_Arquivo_Xml	= ls_Diretorio+ls_Chave_Acesso+"-nfe.xml"
				ls_Arquivo_Pdf	= ls_Diretorio+ls_Chave_Acesso+"-nfe.pdf"
				
				If of_Busca_Xml_Ftp(ldt_Emissao, ls_Chave_Acesso, ls_Arquivo_Xml, ls_Ftp_Endereco, ls_Ftp_Usuario, ls_Ftp_Senha, Ref ls_Xml, Ref ls_Erro) Then
					If lo_Eventos_Sefaz.of_gera_danfe_nfe(ls_Xml, ls_Arquivo_Pdf, Ref ls_Erro) Then
						If of_Envia_Email(ls_Email, ls_Arquivo_Xml, ls_Arquivo_Pdf, Ref ls_Erro) Then
							lb_Sucesso = True
						End If
					End If
				End If
				
				//Se o pr$$HEX1$$f300$$ENDHEX$$ximo registro for da mesma nota n$$HEX1$$e300$$ENDHEX$$o exclui para n$$HEX1$$e300$$ENDHEX$$o precisar baixar do FTP e gerar o pdf. Existe nota que s$$HEX1$$e300$$ENDHEX$$o enviadas para mais de um e-mail
				If (ll_Linha < ll_Linhas) Then
					If  (ls_Chave_Acesso <> lds_Notas.Object.de_chave_acesso	[ll_Linha + 1]) Then
						FileDelete(ls_Diretorio+ls_Chave_Acesso+"-nfe.pdf")
						FileDelete(ls_Diretorio+ls_Chave_Acesso+"-nfe.xml")
					End If
				End If
			End If
				
			If Not of_Grava_Situacao_Envio_Email(ll_Filial, ll_Nr_nf, ls_Especie, ls_Serie, lb_Sucesso, ls_Erro+" Nota: "+String(ll_Nr_Nf), Ref ls_Erro) Then
				of_envia_email_erro_processamento(ls_Erro)
				Return
			End If
		Next
		
		If Not of_Exclui_Arquivos(ls_Diretorio, Ref ls_Erro) Then		
			of_envia_email_erro_processamento(ls_Erro)
			Return
		End If
		
	Catch	( runtimeerror  lo_rte)	
		of_envia_email_erro_processamento("Erro: " + lo_rte.GetMessage())
		Return
	End Try
	
Finally
	Destroy(lds_Notas)
	Destroy(lo_Eventos_Sefaz)
	Close(w_Aguarde)
End Try

Return
end subroutine

public function boolean of_diretorio_danfe (ref string as_diretorio, ref string as_erro);Try
	as_Diretorio = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, 'Diretorio', 'danfe', "")
	
	If as_Diretorio <> "" Then
		If Not DirectoryExists( as_Diretorio) Then
			If CreateDirectory(as_Diretorio ) = -1 Then
				as_Erro = "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio para a importa$$HEX2$$e700e300$$ENDHEX$$o do XML '" + as_Diretorio + "'."
				Return False
			End If
		End If
	Else
		as_Erro = "Par$$HEX1$$e200$$ENDHEX$$metro 'danfe' n$$HEX1$$e300$$ENDHEX$$o localizado no INI da aplica$$HEX2$$e700e300$$ENDHEX$$o."
		Return False
	End If
Catch	( runtimeerror  lo_rte )
	as_Erro = "Erro ao buscar o diret$$HEX1$$f300$$ENDHEX$$rio onde ser$$HEX1$$e100$$ENDHEX$$ gerado a DANFE: " + lo_rte.GetMessage()
	
	Return False
End Try	

Return True
end function

public function boolean of_grava_situacao_envio_email (long al_filial, long al_nr_nf, string as_especie, string as_serie, boolean ab_sucesso, string as_log_envio_email, ref string as_erro);If ab_Sucesso Then
	Update nf_transferencia_nfe
	Set	id_xml_enviado_email = 'S',
			de_erro_xml_envio_email = null
	Where	cd_filial_origem	= :al_Filial
		and	nr_nf					= :al_Nr_Nf
		and	de_especie			= :as_Especie
		and	de_serie				= :as_Serie
	Using SqlCa;
Else
	Update nf_transferencia_nfe
	Set	id_xml_enviado_email = 'X',
			de_erro_xml_envio_email = :as_Log_Envio_Email
	Where	cd_filial_origem	= :al_Filial
		and	nr_nf					= :al_Nr_Nf
		and	de_especie			= :as_Especie
		and	de_serie				= :as_Serie
	Using SqlCa;
End If

Choose Case SqlCa.SqlCode
		Case 0
			SqlCa.of_commit()
		Case 100
			as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi alterado nenhum registro ao mudar a situa$$HEX2$$e700e300$$ENDHEX$$o da nota. Filial: "+String(al_Filial)+" Nota: "+String(al_Nr_Nf)+" S$$HEX1$$e900$$ENDHEX$$rie: "+as_Serie
			SqlCa.of_Rollback()
			Return False
		Case -1
			as_Erro = "Erro ao mudar a situa$$HEX2$$e700e300$$ENDHEX$$o da nota. Filial: "+String(al_Filial)+" Nota: "+String(al_Nr_Nf)+" S$$HEX1$$e900$$ENDHEX$$rie: "+as_Serie+" Erro: " + SqlCa.sqlErrText
			SqlCa.of_Rollback()
			Return False
	End Choose

Return True
end function

public function boolean of_ler_arquivo_xml (string as_arquivo, ref string as_xml, ref string as_erro);Integer	li_FileOpen,&
			li_File_Read
			
Try
	Try
		li_FileOpen = FileOpen(as_Arquivo , TextMode! , Read!, LockRead! )
		
		If li_FileOpen = -1 Then
			as_Erro = "Erro ao abrir o arquivo: "+as_Arquivo
			Return False
		End if
		
		li_File_Read = FileReadEx(li_FileOpen, as_Xml)
		
		Choose Case li_File_Read
			Case -100
				as_Erro = "-100 Erro ao ler o arquivo: "+as_Arquivo
				Return False
			Case -1
				as_Erro = "-1 Erro ao ler o arquivo: "+as_Arquivo
				Return False
			Case 0
				as_Erro = "0 Erro ao ler o arquivo: "+as_Arquivo
				Return False
		End Choose
		
		as_Xml   = gf_Replace(as_Xml, "~r~n ", "", 0)
		as_Xml   = gf_Replace(as_Xml, " ~r~n", "", 0)
		
		as_Xml   = gf_Replace(as_Xml, "~n ", "", 0)
		as_Xml   = gf_Replace(as_Xml, " ~n", "", 0)
		
		as_Xml   = gf_Replace(as_Xml, "~r ", "", 0)
		as_Xml   = gf_Replace(as_Xml, " ~r", "", 0)
		
	Finally
		FileClose (li_FileOpen)
	End Try
	
Catch	( runtimeerror  lo_rte )
	as_Erro = "Erro ao ler o arquivo "+as_Arquivo+": " + lo_rte.GetMessage()
	Return False
End Try

Return True
end function

private function boolean of_busca_xml_ftp (date at_emissao, string as_chave_acesso, string as_arquivo, string as_ftp_endereco, string as_ftp_usuario, string as_ftp_senha, ref string as_xml, ref string as_erro);String ls_Ano,&
		ls_Mes,&
		ls_Dia,&
		ls_Cnpj,&
		ls_Diretorio,&
		ls_Mensagem

Long	ll_Ano,&
		ll_Mes,&
		ll_Dia
			
			
dc_uo_ftp lo_Ftp

Try	
	If FileExists(as_Arquivo) Then
		If Not of_ler_arquivo_xml(as_Arquivo, Ref as_Xml, Ref as_Erro) Then
			Return False
		End If
		
		Return True
	End If
	
	Try
		lo_Ftp = Create dc_uo_ftp
		
		If Not lo_Ftp.of_Conecta_ftp("GN", as_Ftp_Endereco, as_Ftp_Usuario, as_Ftp_Senha, Ref as_Erro) Then
			as_Erro = "Erro ao conectar no FTP: "+as_Erro
			Return False
		End If
		
		ll_Ano = Year(at_Emissao)
		ll_Mes = Month(at_Emissao)
		ll_Dia = Day(at_Emissao)
				
		ls_Ano = "Ano_"+String(ll_Ano)
		If ll_Mes < 10 Then ls_Mes = "Mes_0"+String(ll_Mes) Else ls_Mes = "Mes_"+String(ll_Mes)
		If ll_Dia < 10 Then ls_Dia = "Dia_0"+String(ll_Dia) Else ls_Dia = "Dia_"+String(ll_Dia)
		ls_Cnpj = Mid(as_Chave_Acesso, 7, 14)
		
		ls_Diretorio = ls_Ano + "/" + ls_Mes + "/" + ls_Dia + "/" + ls_CNPJ
		
		If lo_Ftp.of_Ftp_Set_Dir(ls_Diretorio, Ref ls_Mensagem) = -1 Then 
			as_Erro = "Erro ao conectar no FTP:" + as_Chave_Acesso + " - " + ls_Mensagem
			Return False
		End If
		
		If not lo_Ftp.of_Ftp_GetFile(as_chave_acesso+"-nfe.xml", as_Arquivo, Ref ls_Mensagem) Then
			as_Erro = "Erro ao conectar no FTP:" + as_Chave_Acesso + " - " + ls_Mensagem
			
			Return False
		End If
		
		If Not of_ler_arquivo_xml(as_Arquivo, Ref as_Xml, Ref as_Erro) Then
			Return False
		End If
	Finally
		lo_Ftp.of_desconecta_ftp()
		Destroy(lo_Ftp)
	End Try
	
Catch	( runtimeerror  lo_rte )
	as_Erro = "Erro ao buscar o XML no FTP: " + lo_rte.GetMessage()
	Return False
End Try

Return True

end function

private function boolean of_envia_email (string as_email, string as_arquivo_xml, string as_arquivo_pdf, ref string as_erro);uo_smtp lo_Email
String	ls_To[],&
		ls_CC[],&
		ls_Anexo[]

Try
	Try
		lo_Email = Create uo_smtp
		lo_Email.ib_grava_log_db = False
		
		ls_TO[1]	= as_Email
		
		ls_Anexo[1]	=	as_Arquivo_Xml
		ls_Anexo[2]	=	as_Arquivo_Pdf
		
		lo_Email.of_envia_email_anexo	(	'CLAMED Sistemas', &
													'nfe@clamed.com.br', &
													'XML - CIA LATINO AMERICANA DE MEDICAMENTOS', &
													'O arquivo est$$HEX1$$e100$$ENDHEX$$ anexo.', &
													ls_TO, &
													ls_CC, &
													ls_Anexo)
	Catch	( runtimeerror  lo_rte )
		as_Erro = "Erro ao enviar a nota por e-mail: " + lo_rte.GetMessage()
		
		Return False
	End Try

Finally
	Destroy lo_Email
End Try

Return True

end function

public function boolean of_exclui_arquivos (string as_diretorio, ref string as_erro);Long	ll_Retorno,&
		ll_Linhas,&
		ll_Linha

String	ls_Lista_Arquivos[],&
		ls_Arquivo

Try
	Open(w_Aguarde)
	
	ll_Retorno = gf_Dir_List(as_diretorio, "*", 1, ref ls_Lista_Arquivos[])
		
	If ll_Retorno > 0 Then
		
		ll_Linhas = UpperBound(ls_Lista_Arquivos[])
				
		w_Aguarde.uo_Progress.of_setmax(ll_Linhas)
		
		For ll_Linha = 1 To ll_Linhas
			
			w_Aguarde.Title = "Enviando arquivos... " + String(ll_Linha) + " de " + String(ll_Linhas)
			
			ls_Arquivo = ls_Lista_Arquivos[ll_Linha]
			
			If Not FileDelete(ls_Arquivo) Then
				as_Erro = "Erro ao deletear o arquivo: "+ls_Arquivo
				Return False
			End If
			
			w_Aguarde.uo_Progress.of_setprogress(ll_Linha)
		Next
	End If
Finally
	Close(w_Aguarde)
End Try

Return True
	
end function

private subroutine of_envia_email_erro_processamento (string as_erro);s_email str

String	ls_Email,&
		ls_Mensagem,&
		ls_Anexo

Try
	ls_Mensagem = '<p style="font-size:300%; color:red">Erro ao enviar as notas de transf$$HEX1$$ea00$$ENDHEX$$ncia do CD por e-mail:</p><br><br>'+as_Erro
	
	str.ps_to[1]			= ls_Email
	str.ps_anexo[1]	= ls_Anexo
	str.ps_Mensagem	= ls_Mensagem
	str.pb_assinatura = True
	
	If Not gf_ge202_envia_email_padrao(268, str) Then
		MessageBox("Erro", "Erro ao enviar e-mail de log na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_envia_email_erro_processamento' da 'GN012'.", StopSign!)	
	End If
Catch	( runtimeerror  lo_rte)	
	MessageBox("Erro", "Erro: " + lo_rte.GetMessage())
	Return
End Try	
end subroutine

on uo_ge610_nfe_envia_email_destinatario.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge610_nfe_envia_email_destinatario.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

