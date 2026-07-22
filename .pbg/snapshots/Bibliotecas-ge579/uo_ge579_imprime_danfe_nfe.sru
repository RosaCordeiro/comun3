HA$PBExportHeader$uo_ge579_imprime_danfe_nfe.sru
forward
global type uo_ge579_imprime_danfe_nfe from nonvisualobject
end type
end forward

global type uo_ge579_imprime_danfe_nfe from nonvisualobject
end type
global uo_ge579_imprime_danfe_nfe uo_ge579_imprime_danfe_nfe

type prototypes
Function Integer ImprimirDanfe(String as_XML, String as_GerarNoDiretorio, Ref String as_Retorno)  library "C:\Sistemas\DLL\SEFAZ\Sefaz.dll" alias for "ImprimirDanfe;Ansi"
end prototypes

type variables
Boolean ib_Imprime_Outra_Via = False
end variables

forward prototypes
private function boolean of_parametro_conexao_ftp (ref string as_ftp_endereco, ref string as_ftp_usuario, ref string as_ftp_senha, ref string as_erro_log)
private function boolean of_busca_xml_ftp (string as_chave_acesso, date adt_emissao, string as_cnpj_origem, string as_diretorio_arquivo, ref string as_erro_log)
public function boolean of_imprime_danfe_nfe (long al_filial, long al_nota, string as_especie, string as_serie, string as_chave_acesso, date adt_emissao, string as_impressora, ref string as_erro)
private function boolean of_exclui_arquivo_xml (string as_arquivo, ref string as_erro)
private function boolean of_ler_arquivo_xml (string as_arquivo, ref string as_xml, ref string as_erro)
public function boolean of_altera_situacao_para_impresso (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro, string as_tipo)
public function boolean of_alt_impresso_nf_transferencia (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro)
public function boolean of_imprime_danfe_nfe (long al_filial, long al_nota, string as_especie, string as_serie, string as_chave_acesso, date adt_emissao, string as_impressora, ref string as_erro, string as_tipo)
public function boolean of_valida_xml_nfe (long al_filial, long al_nota, string as_especie, string as_serie, string as_chave_acesso, date adt_emissao, ref string as_erro, ref boolean ab_xml_encontrado)
public function boolean of_verifica_arquivo_ftp (ref string as_erro_log, ref dc_uo_dw_base adw_nfe)
public function boolean of_imprime_danfe_nfe_new (long al_filial, long al_nota, string as_especie, string as_serie, string as_chave_acesso, date adt_emissao, string as_impressora, ref string as_erro, string as_tipo, string as_solicitacao)
public function boolean of_carrega_dados_jbdoc (string as_solicitacao, ref long al_docnum, ref string as_mandt, ref long al_nr_sequencial, ref string as_erro)
public function boolean of_altera_situacao_impresso_com_jactive (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro, string as_tipo, long al_docnum, string as_mandt, long al_nr_sequencial)
public function boolean of_alt_impresso_nf_transferencia_new (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro, ref long al_sqlnrows)
public function boolean of_alt_impresso_j_1bnfe_active_new (long al_nota, long al_docnum, string ls_mandt, long al_nr_sequencial, ref string as_erro, ref long al_sqlnrows)
public function boolean of_imprime_danfe_nfe_new (long al_filial, long al_nota, string as_especie, string as_serie, string as_chave_acesso, date adt_emissao, string as_impressora, ref string as_erro, string as_solicitacao)
public function boolean of_alt_impresso_nf_devolucao (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro)
public function boolean of_alt_impresso_nf_diversa (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro)
public function boolean of_alt_impresso_nf_venda (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro)
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

private function boolean of_busca_xml_ftp (string as_chave_acesso, date adt_emissao, string as_cnpj_origem, string as_diretorio_arquivo, ref string as_erro_log);String		ls_Ano,&
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

public function boolean of_imprime_danfe_nfe (long al_filial, long al_nota, string as_especie, string as_serie, string as_chave_acesso, date adt_emissao, string as_impressora, ref string as_erro);Return of_imprime_danfe_nfe(al_filial, al_nota, as_especie, as_serie, as_chave_acesso, adt_emissao, as_impressora, as_erro, 'TRA')
end function

private function boolean of_exclui_arquivo_xml (string as_arquivo, ref string as_erro);		
Try
	Return FileDelete (as_Arquivo)
	
Catch	( runtimeerror  lo_rte )
	as_Erro = "Erro ao excluir o arquivo "+as_Arquivo+": " + lo_rte.GetMessage()
	Return False
End Try
end function

private function boolean of_ler_arquivo_xml (string as_arquivo, ref string as_xml, ref string as_erro);Long ll_FileOpen
Blob lbl_Conteudo, lbl_Conteudo_Temp	

Try
	Try
//		li_FileOpen = FileOpen(as_Arquivo, TextMode!, Read!, LockReadWrite!, Append!)
//		
//		If li_FileOpen = -1 Then
//			as_Erro = "Erro ao abrir o arquivo: "+as_Arquivo
//			Return False
//		End if
//		
//		li_File_Read = FileReadEx(li_FileOpen, as_Xml)
//		
//		Choose Case li_File_Read
//			Case -100
//				as_Erro = "-100 Erro ao ler o arquivo: "+as_Arquivo
//				Return False
//			Case -1
//				as_Erro = "-1 Erro ao ler o arquivo: "+as_Arquivo
//				Return False
//			Case 0
//				as_Erro = "0 Erro ao ler o arquivo: "+as_Arquivo
//				Return False
//		End Choose
		
		ll_FileOpen = FileOpen(as_Arquivo, streammode!)
		
		If ll_FileOpen = -1 Then
			as_Erro = "Erro ao abrir o arquivo: "+as_Arquivo
			Return False
		End if
		
		DO WHILE FileRead(ll_FileOpen, lbl_Conteudo_Temp) > 0
			lbl_Conteudo += lbl_Conteudo_Temp
		LOOP
		
		as_Xml = String(lbl_Conteudo, EncodingUTF8!)
		
		as_Xml   = gf_Replace(as_Xml, "~r~n ", "", 0)
		as_Xml   = gf_Replace(as_Xml, " ~r~n", "", 0)
		as_Xml   = gf_Replace(as_Xml, "~n ", "", 0)
		as_Xml   = gf_Replace(as_Xml, " ~n", "", 0)
		as_Xml   = gf_Replace(as_Xml, "~r ", "", 0)
		as_Xml   = gf_Replace(as_Xml, " ~r", "", 0)
		as_Xml   = gf_Replace(as_Xml, "~r~n", "", 0)
		as_Xml   = gf_Replace(as_Xml, "~n", "", 0)
		as_Xml   = gf_Replace(as_Xml, "~r", "", 0)
		
	Finally
		FileClose (ll_FileOpen)
	End Try
	
Catch	( runtimeerror  lo_rte )
	as_Erro = "Erro ao ler o arquivo "+as_Arquivo+": " + lo_rte.GetMessage()
	Return False
End Try

Return True
end function

public function boolean of_altera_situacao_para_impresso (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro, string as_tipo);Choose Case as_tipo
	Case 'TRA'
		Return of_alt_impresso_nf_transferencia(al_filial, al_nota, as_especie, as_serie, REF as_erro)
		
	Case 'DEV'
		Return of_alt_impresso_nf_devolucao(al_filial, al_nota, as_especie, as_serie, REF as_erro)
		
	Case 'LIC'
		Return of_alt_impresso_nf_venda(al_filial, al_nota, as_especie, as_serie, REF as_erro)
		
	Case 'SUC', 'DES', 'INV'
		Return of_alt_impresso_nf_diversa(al_filial, al_nota, as_especie, as_serie, REF as_erro)
		
	Case Else
		Return False
		
End Choose
end function

public function boolean of_alt_impresso_nf_transferencia (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro);Try
	Update nf_transferencia_nfe
	   set id_nfe_impressa 	= 'S',
			 dh_impressao 		= getdate()
	 where cd_filial_origem  	= :al_Filial
		and nr_nf  				 	= :al_nota
		and de_especie 			= :as_Especie
		and de_serie 				= :as_serie
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao atualizar a situa$$HEX2$$e700e300$$ENDHEX$$o da nota: " + SqlCa.SQLErrText
		Return False
	End If

	Return True
Catch	( runtimeerror  lo_rte )
	as_Erro = "Erro ao alterar a situa$$HEX2$$e700e300$$ENDHEX$$o da impress$$HEX1$$e300$$ENDHEX$$o da nota "+String(al_Nota)+": " + lo_rte.GetMessage()
	Return False
End Try	

end function

public function boolean of_imprime_danfe_nfe (long al_filial, long al_nota, string as_especie, string as_serie, string as_chave_acesso, date adt_emissao, string as_impressora, ref string as_erro, string as_tipo);String	ls_Diretorio_Arquivo,&
		ls_Xml,&
		ls_Arquivo_Pdf,&
		ls_Arquivo,&
		ls_Diretorio,&
		ls_Diretorio_Xml,&
		ls_Diretorio_Dll, &
		ls_Cnpj_Origem
		
Try
	ls_Diretorio_Dll = "C:\Sistemas\DLL\SEFAZ\Sefaz.dll"
	
	If Not FileExists(ls_Diretorio_Dll) Then
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado a DLL Eventos_Sefaz.dll no diret$$HEX1$$f300$$ENDHEX$$rio: " + ls_Diretorio_Dll
		Return False
	End If
	
	ls_Cnpj_Origem = Mid(as_Chave_Acesso, 7, 14)
	
	ls_Diretorio = getcurrentdirectory()+"Danfe\"
	
	If Not FileExists(ls_Diretorio) Then
		If CreateDirectory(ls_Diretorio ) = -1 Then
			as_Erro = "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio para a grava$$HEX2$$e700e300$$ENDHEX$$o do XML na m$$HEX1$$e100$$ENDHEX$$quina local. Diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_Diretorio + "'."
			Return False
		End If
	End If
	
	ls_Diretorio = ls_Diretorio + "xml\"
	
	If Not FileExists(ls_Diretorio) Then
		If CreateDirectory(ls_Diretorio ) = -1 Then
			as_Erro = "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio para a grava$$HEX2$$e700e300$$ENDHEX$$o do XML na m$$HEX1$$e100$$ENDHEX$$quina local. Diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_Diretorio + "'."
			Return False
		End If
	End If
	
	ls_Diretorio_Xml	= ls_Diretorio+as_Chave_Acesso+"-nfe.xml"
	
	If of_Busca_Xml_Ftp(as_Chave_Acesso, adt_Emissao, ls_Cnpj_Origem, ls_Diretorio, Ref as_Erro) Then
		If of_Ler_Arquivo_Xml(ls_Diretorio_Xml, Ref ls_Xml, Ref as_Erro) Then
			If ImprimirDanfe(ls_XML, as_Impressora, Ref as_Erro) = 1 Then
				If ib_Imprime_Outra_Via Then ImprimirDanfe(ls_XML, as_Impressora, Ref as_Erro)
				If of_Exclui_Arquivo_Xml(ls_Diretorio_Xml, Ref as_Erro) Then
					If of_Altera_Situacao_Para_Impresso(al_Filial, al_Nota, as_Especie, as_Serie, Ref as_Erro, as_tipo) Then
						SqlCa.of_Commit()
						Return True
					End If
				End If
			End If
		End If
	End If
	
	SqlCa.of_RollBack()
	Return False
	
Catch	( runtimeerror  lo_rte )
	as_Erro = "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_imprime_danfe_nfe': " + lo_rte.GetMessage()
End Try	
end function

public function boolean of_valida_xml_nfe (long al_filial, long al_nota, string as_especie, string as_serie, string as_chave_acesso, date adt_emissao, ref string as_erro, ref boolean ab_xml_encontrado);String	ls_Diretorio_Arquivo, ls_Xml, ls_Diretorio, ls_Diretorio_Xml, ls_Cnpj_Origem
		
Try
	ls_Cnpj_Origem = Mid(as_Chave_Acesso, 7, 14)
	
	ls_Diretorio = getcurrentdirectory()+"Danfe\"
	
	If Not FileExists(ls_Diretorio) Then
		If CreateDirectory(ls_Diretorio ) = -1 Then
			as_Erro = "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio para a grava$$HEX2$$e700e300$$ENDHEX$$o do XML na m$$HEX1$$e100$$ENDHEX$$quina local. Diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_Diretorio + "'."
			Return False
		End If
	End If
	
	ls_Diretorio = ls_Diretorio + "xml\"
	
	If Not FileExists(ls_Diretorio) Then
		If CreateDirectory(ls_Diretorio ) = -1 Then
			as_Erro = "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio para a grava$$HEX2$$e700e300$$ENDHEX$$o do XML na m$$HEX1$$e100$$ENDHEX$$quina local. Diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_Diretorio + "'."
			Return False
		End If
	End If
	
	ls_Diretorio_Xml	= ls_Diretorio+as_Chave_Acesso+"-nfe.xml"
	
	If Not of_Busca_Xml_Ftp(as_Chave_Acesso, adt_Emissao, ls_Cnpj_Origem, ls_Diretorio, Ref as_Erro) Then
		ab_xml_encontrado = False
	else
		ab_xml_encontrado	= True
	End If
	
	Return True
Catch	( runtimeerror  lo_rte )
	as_Erro = "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_xml_nfe': " + lo_rte.GetMessage()
End Try	
end function

public function boolean of_verifica_arquivo_ftp (ref string as_erro_log, ref dc_uo_dw_base adw_nfe);Boolean	lb_achou

Date		ldt_data_anterior

String	ls_Ano,&
			ls_Mes,&
			ls_Dia,&
			ls_Arquivo_Xml,&
			ls_Diretorio,&
			ls_Endereco_Ftp,&
			ls_Usuario_Ftp,&
			ls_Senha_Ftp, &
			ls_arquivos_no_ftp [], &
			ls_filtro, &
			ls_cnpj_anterior
			
Long	ll_Ano,&
		ll_Mes,&
		ll_Dia, &
		ll_linha, &
		ll_lin_nfe

dc_uo_Ftp lo_Ftp

If adw_nfe.RowCount () = 0 then
	Return False
End if

If IsValid (w_aguarde) then
	w_Aguarde.uo_Progress.of_setmax (adw_nfe.RowCount ())
End if

Try
	
	If Not of_parametro_conexao_ftp(Ref ls_Endereco_Ftp, Ref ls_Usuario_Ftp, Ref ls_Senha_Ftp, Ref as_Erro_Log) Then Return False
	
	Try
		lo_Ftp = Create dc_uo_Ftp
		
		//Reordena as notas para otimizar o acesso ao FTP
		adw_nfe.SetSort ('dh_emissao asc, nr_cgc_filial_origem asc')
		adw_nfe.Sort ()
		
		For ll_lin_nfe = 1 to adw_nfe.RowCount ()
			If adw_nfe.Object.id_autorizada [ll_lin_nfe] = 'S' then
				If Date (adw_nfe.Object.dh_emissao     [ll_lin_nfe]) <> ldt_data_anterior or &
					adw_nfe.Object.nr_cgc_filial_origem [ll_lin_nfe]  <> ls_cnpj_anterior then
					
					ldt_data_anterior = Date (adw_nfe.Object.dh_emissao     [ll_lin_nfe])
					ls_cnpj_anterior  = adw_nfe.Object.nr_cgc_filial_origem [ll_lin_nfe]
					
					ll_Ano = Year  (Date (adw_nfe.Object.dh_emissao [ll_lin_nfe]))
					ll_Mes = Month (Date (adw_nfe.Object.dh_emissao [ll_lin_nfe]))
					ll_Dia = Day   (Date (adw_nfe.Object.dh_emissao [ll_lin_nfe]))
					
					ls_Ano = 'Ano_' + String (ll_Ano)
					
					If ll_Mes < 10 Then ls_Mes = 'Mes_0' + String (ll_Mes) Else ls_Mes = 'Mes_' + String (ll_Mes)
					If ll_Dia < 10 Then ls_Dia = 'Dia_0' + String (ll_Dia) Else ls_Dia = 'Dia_' + String (ll_Dia)
					
					ls_Diretorio   = ls_Ano + '/' + ls_Mes + '/' + ls_Dia + '/' + adw_nfe.Object.nr_cgc_filial_origem [ll_lin_nfe]
					
					lo_Ftp.of_desconecta_ftp ()
					
					If Not lo_Ftp.of_Conecta_Ftp ('', ls_Endereco_Ftp, ls_Usuario_Ftp, ls_Senha_Ftp, Ref as_Erro_Log) Then
						Return False
					End If
					
					If lo_Ftp.of_Ftp_Set_Dir (ls_Diretorio, Ref as_Erro_Log) = 1 Then
						ls_filtro = '*.XML'
						lo_Ftp.of_ftp_lista_arquivos (ls_filtro, ls_arquivos_no_ftp [])
					Else
						as_Erro_Log += " no diret$$HEX1$$f300$$ENDHEX$$rio FTP. ~r~r" + &
						"O sistema GN legado ainda n$$HEX1$$e300$$ENDHEX$$o fez o envio autom$$HEX1$$e100$$ENDHEX$$tico dos XMLs para o FTP. Aguarde e tente novamente em alguns minutos."
						Return False
					End If
				End if
				
				ls_Arquivo_Xml = adw_nfe.Object.de_chave_acesso [ll_lin_nfe] + '-nfe.xml'
				lb_achou       = False
				
				For ll_linha = 1 to UpperBound (ls_arquivos_no_ftp [])
					If ls_Arquivo_Xml = ls_arquivos_no_ftp [ll_linha] then
						lb_achou = True
						Exit
					End if
				Next
				If not lb_achou then
					adw_nfe.Object.id_autorizada [ll_lin_nfe] = 'N'
				End if
				
				If IsValid (w_aguarde) then
					w_Aguarde.uo_Progress.of_setprogress (ll_lin_nfe)
				End if
			End if
		Next
	Finally
		adw_nfe.SetSort ('nr_prioridade_faturamento asc, nr_nf asc')
		adw_nfe.Sort ()

		lo_Ftp.of_desconecta_ftp ()
		Destroy (lo_Ftp)
	End Try
	
Catch (runtimeerror lo_rte)
	as_Erro_Log = 'Ocorreu erro ao buscar o XML no FTP. Erro: ' + lo_rte.GetMessage ()
	Return False						 
End Try

Return True
end function

public function boolean of_imprime_danfe_nfe_new (long al_filial, long al_nota, string as_especie, string as_serie, string as_chave_acesso, date adt_emissao, string as_impressora, ref string as_erro, string as_tipo, string as_solicitacao);String	ls_Diretorio_Arquivo,&
		ls_Xml,&
		ls_Arquivo_Pdf,&
		ls_Arquivo,&
		ls_Diretorio,&
		ls_Diretorio_Xml,&
		ls_Diretorio_Dll, &
		ls_Cnpj_Origem
		
String ls_mandt
Long ll_docnum, ll_nr_sequencial

Try
	ls_Diretorio_Dll = "C:\Sistemas\DLL\SEFAZ\Sefaz.dll"
	
	If Not FileExists(ls_Diretorio_Dll) Then
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado a DLL Eventos_Sefaz.dll no diret$$HEX1$$f300$$ENDHEX$$rio: " + ls_Diretorio_Dll
		Return False
	End If
	
	ls_Cnpj_Origem = Mid(as_Chave_Acesso, 7, 14)
	
	ls_Diretorio = getcurrentdirectory()+"Danfe\"
	
	If Not FileExists(ls_Diretorio) Then
		If CreateDirectory(ls_Diretorio ) = -1 Then
			as_Erro = "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio para a grava$$HEX2$$e700e300$$ENDHEX$$o do XML na m$$HEX1$$e100$$ENDHEX$$quina local. Diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_Diretorio + "'."
			Return False
		End If
	End If
	
	ls_Diretorio = ls_Diretorio + "xml\"
	
	If Not FileExists(ls_Diretorio) Then
		If CreateDirectory(ls_Diretorio ) = -1 Then
			as_Erro = "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio para a grava$$HEX2$$e700e300$$ENDHEX$$o do XML na m$$HEX1$$e100$$ENDHEX$$quina local. Diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_Diretorio + "'."
			Return False
		End If
	End If
	
	ls_Diretorio_Xml	= ls_Diretorio+as_Chave_Acesso+"-nfe.xml"
	
	If Not of_carrega_dados_jbdoc(as_solicitacao, Ref ll_docnum, Ref ls_mandt, Ref ll_nr_sequencial, Ref as_Erro) Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!', as_Erro)
		Return False
	End If
	
	If of_Busca_Xml_Ftp(as_Chave_Acesso, adt_Emissao, ls_Cnpj_Origem, ls_Diretorio, Ref as_Erro) Then
		If of_Ler_Arquivo_Xml(ls_Diretorio_Xml, Ref ls_Xml, Ref as_Erro) Then
			If ImprimirDanfe(ls_XML, as_Impressora, Ref as_Erro) = 1 Then
				If ib_Imprime_Outra_Via Then ImprimirDanfe(ls_XML, as_Impressora, Ref as_Erro)
				If of_Exclui_Arquivo_Xml(ls_Diretorio_Xml, Ref as_Erro) Then
					If of_Altera_Situacao_Impresso_Com_jactive(al_Filial, al_Nota, as_Especie, as_Serie, Ref as_Erro, as_tipo, ll_docnum, ls_mandt, ll_nr_sequencial) Then
						SqlCa.of_Commit()
						Return True
					End If
				End If
			End If
		End If
	End If
	
	SqlCa.of_RollBack()
	Return False
	
Catch	( runtimeerror  lo_rte )
	as_Erro = "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_imprime_danfe_nfe': " + lo_rte.GetMessage()
End Try	
end function

public function boolean of_carrega_dados_jbdoc (string as_solicitacao, ref long al_docnum, ref string as_mandt, ref long al_nr_sequencial, ref string as_erro);SetNull(al_docnum)
SetNull(al_docnum)
SetNull(al_nr_sequencial)

select jbdoc.docnum, 
		 jbdoc.mandt,
		 jbdoc.nr_sequencial
 into :al_docnum,
		 :as_mandt,
		 :al_nr_sequencial
from dbo.j_1bnflin jblin
inner join dbo.j_1bnfdoc_1 jbdoc 
	 on jblin.mandt  			= jbdoc.mandt 
	and jblin.docnum 			= jbdoc.docnum 
	and jblin.nr_sequencial = jbdoc.nr_sequencial 
inner join dbo.j_1bnfdoc_2 jbdoc2 
	 on jbdoc.mandt 			= jbdoc2.mandt
	and jbdoc.docnum 			= jbdoc2.docnum
	and jbdoc.nr_sequencial	= jbdoc2.nr_sequencial
where jblin.xped 				= :as_solicitacao
	and jbdoc.id_substituida 	= 'N'
	and jbdoc.authdate 			is not null
	and jbdoc2.nftype				<> 'ZF'
	and UPPER(jbdoc.cancel)		<> 'X'
Group by 
	jbdoc.docnum, 
	jbdoc.mandt,
	jbdoc.nr_sequencial
using SQLCA;

If SQLCA.SQLCode = -1 Then
	as_erro = 'Erro ao localizar dados na j_1bnfdoc da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + as_solicitacao + '. Erro: ' + SQLCA.SQLErrText
	Return False
End If

if SQLCA.SQLCode = 100 and pos(as_solicitacao, '/') = 0 then
	as_solicitacao	= as_solicitacao + '/01'
	
	select top 1 jbdoc.docnum, 
			 jbdoc.mandt,
			 jbdoc.nr_sequencial
	  into :al_docnum,
			 :as_mandt,
			 :al_nr_sequencial
	  from dbo.j_1bnflin jblin
	 inner join dbo.j_1bnfdoc_1 jbdoc 
		 on jblin.mandt  			= jbdoc.mandt 
		and jblin.docnum 			= jbdoc.docnum 
		and jblin.nr_sequencial = jbdoc.nr_sequencial 
	 inner join dbo.j_1bnfdoc_2 jbdoc2 
		 on jbdoc.mandt 			= jbdoc2.mandt
		and jbdoc.docnum 			= jbdoc2.docnum
		and jbdoc.nr_sequencial	= jbdoc2.nr_sequencial
	 where jblin.xped 				= :as_solicitacao
		and jbdoc.id_substituida 	= 'N'
		and jbdoc.authdate 			is not null
		and jbdoc2.nftype				<> 'ZF'
		and UPPER(jbdoc.cancel)		<> 'X'
	 group by jbdoc.docnum, 
				 jbdoc.mandt,
				 jbdoc.nr_sequencial
	using SQLCA;
end if

If SQLCA.SQLCode = -1 Then
	as_erro = 'Erro ao localizar dados na j_1bnfdoc_1 da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + as_solicitacao + '. Erro: ' + SQLCA.SQLErrText
	Return False
End If
	
Return True
end function

public function boolean of_altera_situacao_impresso_com_jactive (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro, string as_tipo, long al_docnum, string as_mandt, long al_nr_sequencial);Long ll_nrows_tr, ll_nrows_ja

Choose Case as_tipo
	Case 'TRA'
		if not of_alt_impresso_j_1bnfe_active_new(al_nota, al_docnum, as_mandt, al_nr_sequencial, Ref as_erro, Ref ll_nrows_ja) then
			Return False
		end if
		
		if not of_alt_impresso_nf_transferencia_new(al_filial, al_nota, as_especie, as_serie, REF as_erro, Ref ll_nrows_tr) then
			Return False
		end if
		
		Return True
	Case 'DEV', 'LIC', 'SUC'
		Return True
	Case Else
		Return False
End Choose
end function

public function boolean of_alt_impresso_nf_transferencia_new (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro, ref long al_sqlnrows);SetNull(al_sqlnrows)

Try
	Update nf_transferencia_nfe
	   set id_nfe_impressa = 'S',
			 dh_impressao = getdate()
	 where cd_filial_origem  = :al_Filial
		and nr_nf  		= :al_nota
		and de_especie = :as_Especie
		and de_serie 	= :as_serie
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao atualizar a situa$$HEX2$$e700e300$$ENDHEX$$o da nota na nf_transferencia_nfe: " + SqlCa.SQLErrText
		Return False
	End If

	al_sqlnrows = SqlCa.SqlNRows
	If al_sqlnrows > 1 Then
		as_Erro = "Deveria ter atualizado 1 nota na nf_transferencia_nfe, atualizou " + String(SqlCa.SqlNRows) 
		Return False
	End If

	Return True
Catch	( runtimeerror  lo_rte )
	as_Erro = "Erro ao alterar a situa$$HEX2$$e700e300$$ENDHEX$$o da impress$$HEX1$$e300$$ENDHEX$$o da nota na nf_transferencia_nfe, NF "+String(al_Nota)+": " + lo_rte.GetMessage()
End Try	

end function

public function boolean of_alt_impresso_j_1bnfe_active_new (long al_nota, long al_docnum, string ls_mandt, long al_nr_sequencial, ref string as_erro, ref long al_sqlnrows);SetNull(al_sqlnrows)

Try
	update j_1bnfe_active
	   set id_impressa = 'S',
			 dh_impressa = getdate()
	 where docnum 			= :al_docnum
	 	and mandt 			= :ls_mandt
		and nr_sequencial = :al_nr_sequencial
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao atualizar a situa$$HEX2$$e700e300$$ENDHEX$$o da nota na j_1bnfe_active: " + SqlCa.SQLErrText
		Return False
	End If

	Return True
Catch	( runtimeerror  lo_rte )
	as_Erro = "Erro ao alterar a situa$$HEX2$$e700e300$$ENDHEX$$o da impress$$HEX1$$e300$$ENDHEX$$o da nota na j_1bnfe_active, NF "+String(al_Nota)+": " + lo_rte.GetMessage()
	Return False
End Try

Return True

end function

public function boolean of_imprime_danfe_nfe_new (long al_filial, long al_nota, string as_especie, string as_serie, string as_chave_acesso, date adt_emissao, string as_impressora, ref string as_erro, string as_solicitacao);Return of_imprime_danfe_nfe_new(al_filial, al_nota, as_especie, as_serie, as_chave_acesso, adt_emissao, as_impressora, as_erro, 'TRA', as_solicitacao)
end function

public function boolean of_alt_impresso_nf_devolucao (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro);Try	
	Update nf_devolucao_compra_nfe
	   set id_nfe_impressa 	= 'S',
			 dh_impressao 		= getdate()
	 where cd_filial				  	= :al_Filial
		and nr_nf  				 	= :al_nota
		and de_especie 			= :as_Especie
		and de_serie 				= :as_serie
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao atualizar a situa$$HEX2$$e700e300$$ENDHEX$$o da nota na nf_devolucao_compra_nfe: " + SqlCa.SQLErrText
		Return False
	End If

	Return True
Catch	( runtimeerror  lo_rte )
	as_Erro = "Erro ao alterar a situa$$HEX2$$e700e300$$ENDHEX$$o da impress$$HEX1$$e300$$ENDHEX$$o da nota "+String(al_Nota)+" na nf_devolucao_compra_nfe: " + lo_rte.GetMessage()
	Return False
End Try	
 
end function

public function boolean of_alt_impresso_nf_diversa (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro);Try	
	Update nf_diversa_nfe
	   set id_nfe_impressa 	= 'S',
			 dh_impressao 		= getdate()
	 where cd_filial_origem	  	= :al_Filial
		and nr_nf  				 	= :al_nota
		and de_especie 			= :as_Especie
		and de_serie 				= :as_serie
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao atualizar a situa$$HEX2$$e700e300$$ENDHEX$$o da nota na nf_diversa_nfe: " + SqlCa.SQLErrText
		Return False
	End If

	Return True
Catch	( runtimeerror  lo_rte )
	as_Erro = "Erro ao alterar a situa$$HEX2$$e700e300$$ENDHEX$$o da impress$$HEX1$$e300$$ENDHEX$$o da nota "+String(al_Nota)+" na nf_diversa_nfe: " + lo_rte.GetMessage()
	Return False
End Try	

end function

public function boolean of_alt_impresso_nf_venda (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro);Try	
	Update nf_venda
	   set id_nfe_impressa 	= 'S',
			 dh_impressao 		= getdate()
	 where cd_filial				  	= :al_Filial
		and nr_nf  				 	= :al_nota
		and de_especie 			= :as_Especie
		and de_serie 				= :as_serie
		and cd_canal_venda 		= 'LI'
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao atualizar a situa$$HEX2$$e700e300$$ENDHEX$$o da nota na nf_venda: " + SqlCa.SQLErrText
		Return False
	End If

	Return True
Catch	( runtimeerror  lo_rte )
	as_Erro = "Erro ao alterar a situa$$HEX2$$e700e300$$ENDHEX$$o da impress$$HEX1$$e300$$ENDHEX$$o da nota "+String(al_Nota)+" na nf_venda: " + lo_rte.GetMessage()
	Return False
End Try	

end function

on uo_ge579_imprime_danfe_nfe.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge579_imprime_danfe_nfe.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

