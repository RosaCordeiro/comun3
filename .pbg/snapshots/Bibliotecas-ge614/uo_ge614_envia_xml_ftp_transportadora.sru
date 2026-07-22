HA$PBExportHeader$uo_ge614_envia_xml_ftp_transportadora.sru
forward
global type uo_ge614_envia_xml_ftp_transportadora from nonvisualobject
end type
end forward

global type uo_ge614_envia_xml_ftp_transportadora from nonvisualobject
end type
global uo_ge614_envia_xml_ftp_transportadora uo_ge614_envia_xml_ftp_transportadora

type variables
String lvs_parametro1 = 'DH_ULTIMA_EXEC_ENVIO_XML_TRANSPORTADORA'
String lvs_parametro2 = 'TEMPO_MINUTOS_ENVIO_XML_TRANSPORTADORA'

Long   ll_Tempo_Executar
String ldh_data_agora
end variables

forward prototypes
private function boolean of_conecta_ftp_clamed (ref dc_uo_ftp ao_ftp_clamed, ref string as_erro_log)
private function boolean of_busca_xml_ftp (dc_uo_ftp ao_ftp_clamed, string as_chave_acesso, date adt_emissao, string as_cnpj_origem, ref string as_diretorio_arquivo, ref string as_erro_log)
public function boolean of_conecta_ftp_transportadora (string as_tansportadora, ref dc_uo_ftp ao_ftp, ref string as_erro)
public function boolean of_envia_arquivo_transportadora (dc_uo_ftp ao_ftp_transportadora, string as_dir_arquivo, string as_chave_acesso, ref string as_erro)
public function boolean of_atualiza_situacao_nota (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro)
public function boolean of_abre_log (ref integer ai_log)
public subroutine of_envia_xml_ftp_transportadora ()
public function boolean of_localiza_data_hora_ultima_execucao (ref string as_erro)
public function boolean of_grava_log (integer ai_log, string as_mensagem, boolean as_envia_email)
end prototypes

private function boolean of_conecta_ftp_clamed (ref dc_uo_ftp ao_ftp_clamed, ref string as_erro_log);String	ls_Ftp_Endereco,&
		ls_Ftp_Usuario,&
		ls_Ftp_Senha
Try
	//Endere$$HEX1$$e700$$ENDHEX$$o FTP
	select vl_parametro
	Into :ls_Ftp_Endereco
	From parametro_geral
	Where cd_parametro = 'DE_FTP_XML_ENDERECO'
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If IsNull(ls_Ftp_Endereco) or ls_Ftp_Endereco = '' Then
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
	Into :ls_Ftp_Usuario
	From parametro_geral
	Where cd_parametro = 'DE_FTP_XML_USUARIO'
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If IsNull(ls_Ftp_Usuario) or ls_Ftp_Usuario = '' Then
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
	Into :ls_Ftp_Senha
	From parametro_geral
	Where cd_parametro = 'DE_FTP_XML_SENHA'
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If IsNull(ls_Ftp_Senha) or ls_Ftp_Senha = '' Then
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
	
	//Conecta
	If Not ao_Ftp_Clamed.of_Conecta_Ftp("", ls_Ftp_Endereco, ls_Ftp_Usuario, ls_Ftp_Senha, Ref as_Erro_Log) Then
		Return False
	End If

Catch ( runtimeerror  lo_rte )
	as_Erro_Log = "Ocorreu erro ao localizar os par$$HEX1$$e200$$ENDHEX$$metro de conex$$HEX1$$e300$$ENDHEX$$o com o FTP. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try		
	
Return True
end function

private function boolean of_busca_xml_ftp (dc_uo_ftp ao_ftp_clamed, string as_chave_acesso, date adt_emissao, string as_cnpj_origem, ref string as_diretorio_arquivo, ref string as_erro_log);String		ls_Ano,&
			ls_Mes,&
			ls_Dia,&
			ls_Cnpj,&
			ls_Arquivo_Xml,&
			ls_Diretorio

			
Long	ll_Ano,&
		ll_Mes,&
		ll_Dia


Try	
	If ao_Ftp_Clamed.of_Ftp_Set_Dir("/", Ref as_Erro_Log) = -1 Then 
		as_Erro_Log += " Erro ao voltar para o diret$$HEX1$$f300$$ENDHEX$$rio raiz do FTP."
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
	
	If ao_Ftp_Clamed.of_Ftp_Set_Dir(ls_Diretorio, Ref as_Erro_Log) = 1 Then 
		If not ao_Ftp_Clamed.of_Ftp_GetFile(ls_Arquivo_Xml, as_diretorio_arquivo+ls_Arquivo_Xml, Ref as_Erro_Log) Then
			as_Erro_Log += " XML n$$HEX1$$e300$$ENDHEX$$o localizado"
			Return False
		End If
	Else
		as_Erro_Log += " XML n$$HEX1$$e300$$ENDHEX$$o localizado"
		Return False
	End If

	
	as_diretorio_arquivo = as_diretorio_arquivo+ls_Arquivo_Xml
	
Catch ( runtimeerror  lo_rte )
	as_Erro_Log = "Ocorreu erro ao buscar o XML no FTP. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try	

Return True
end function

public function boolean of_conecta_ftp_transportadora (string as_tansportadora, ref dc_uo_ftp ao_ftp, ref string as_erro);String	ls_Endereco_Ftp,&
		ls_Ususario_Ftp,&
		ls_Senha_Ftp
		
select	de_endereco, 
			de_usuario,
			de_senha
	Into	:ls_Endereco_Ftp,
			:ls_Ususario_Ftp,
			:ls_Senha_Ftp
	from parametro_ftp_distribuidora
	where cd_fornecedor = :as_Tansportadora
	Using SqlCa;
													
	Choose Case SqlCa.SqlCode
		Case 0

		Case 100
			as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado os dados do FTP do fornecedor '"+as_Tansportadora+"'."
			Return False	
		Case -1
			as_Erro = "Erro ao localizado os dados do FTP do fornecedor '"+as_Tansportadora+"': " + SqlCa.sqlErrText
			Return False
	End Choose												
													
													
	If Not ao_Ftp.of_Conecta_Ftp("", ls_Endereco_Ftp, ls_Ususario_Ftp, ls_Senha_Ftp, Ref as_Erro ) Then	
		Return False
	End If
end function

public function boolean of_envia_arquivo_transportadora (dc_uo_ftp ao_ftp_transportadora, string as_dir_arquivo, string as_chave_acesso, ref string as_erro);
If ao_Ftp_Transportadora.of_Ftp_Set_Dir("/", Ref as_erro) = -1 Then 
	as_erro += " Erro ao voltar para o diret$$HEX1$$f300$$ENDHEX$$rio raiz do FTP."
	Return False
End If	


If ao_Ftp_Transportadora.of_Ftp_Set_Dir('XML_NFE', Ref as_Erro) = -1 Then 
	If Not ao_Ftp_Transportadora.of_ftp_cria_dir("XML_NFE",  Ref as_Erro) Then
		Return False
	End If
	
	If ao_Ftp_Transportadora.of_Ftp_Set_Dir('XML_NFE', Ref as_Erro) = -1 Then 
		Return False
	End If
End If

If Not ao_Ftp_Transportadora.of_Ftp_Putfile(as_Dir_Arquivo, as_Chave_Acesso+"-nfe.xml", Ref as_Erro) Then
	Return False
End If

Return True
end function

public function boolean of_atualiza_situacao_nota (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro);Datetime ldh_atualizacao
ldh_atualizacao	= gf_GetServerDate()

Update nf_transferencia_nfe
Set id_xml_enviado_ftp_transp = 'S',
	 dh_xml_enviado_ftp_transp =:ldh_atualizacao
Where	cd_filial_origem	=	:al_Filial
	And	nr_nf					=	:al_Nota
	And	de_especie			=	:as_Especie
	And	de_serie				=	:as_Serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao atualizar a coluna 'id_xml_enviado_ftp_transp' da tabela 'nf_transferencia_nfe': "+SqlCa.sqlErrText
	SqlCa.of_Rollback()
	Return False
End If


///   Parametro para Ultima Data/Hora Execu$$HEX2$$e700e300$$ENDHEX$$o.
Update  	parametro_geral 
Set     	vl_parametro  = :ldh_data_agora
Where	cd_parametro  = 'DH_ULTIMA_EXEC_ENVIO_XML_TRANSPORTADORA'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao atualizar a coluna 'vl_parametro' da tabela 'parametro_geral.DH_ULTIMA_EXEC_ENVIO_XML_TRANSPORTADORA ': "+SqlCa.sqlErrText
	SqlCa.of_Rollback()
	Return False
End If


SqlCa.of_Commit()

Return True
end function

public function boolean of_abre_log (ref integer ai_log);String ls_Path

ls_Path 	= gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")

If IsNull(ls_Path) or Trim(ls_Path) = '' Then 
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Diret$$HEX1$$f300$$ENDHEX$$rio para a grava$$HEX2$$e700e300$$ENDHEX$$o do log n$$HEX1$$e300$$ENDHEX$$o foi localizado no INI da aplica$$HEX2$$e700e300$$ENDHEX$$o. Chave: Diretorio | Se$$HEX2$$e700e300$$ENDHEX$$o: Diretorio = c:\sistemas\gn\arquivos\ .", StopSign!)
	Return False
End If

ls_Path = ls_Path + "Envia_XML_FTP_Transportadora_" + string(Today(),"ddmm")

If Not gf_Cria_Logs(ls_Path, 4, ref ai_Log) Then
	Return False
End If

Return True


end function

public subroutine of_envia_xml_ftp_transportadora ();
dc_uo_ds_Base			lds_Notas

String	ls_Erro,&
		ls_Chave_Acesso,&
		ls_CNPJ,&
		ls_Diretorio_Arquivo,&
		ls_Transportadora[],&
		ls_Diretorio_Xml_Local,&
		ls_Cd_Transportadora,&
		ls_Especie,&
		ls_Serie

Long	ll_Linhas,&
		ll_Linha,&
		ll_Linha_Transp,&
		ll_Filial,&
		ll_Nota
		
Date	ldt_Emissao

dc_uo_Ftp	lo_Ftp_Clamed,&
				lo_Ftp_Transportadora
				
Integer	li_Log				
		
Try
	
	Open(w_Aguarde)
	
	lds_Notas					= Create dc_uo_ds_Base
	lo_Ftp_Clamed				= Create dc_uo_Ftp
	lo_Ftp_Transportadora	= Create dc_uo_Ftp
	
	
	
	If Not of_Abre_Log(Ref li_Log) Then
		If Not of_Grava_Log(li_Log, ls_Erro, True) Then
			MessageBox("Erro", "Erro ao abrir log na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_envia_xml_ftp_distribuidora' da 'GE614'.", StopSign!)
		End If
		Return
	End If

	//Array com os fornecedores.
	ls_Transportadora[1] = "053405677"
	ls_Transportadora[2] = "053406152"
	ls_Transportadora[3] = "053405992"
	
	
	ls_Diretorio_Xml_Local = getcurrentdirectory()+"\Arquivos\XML_FTP_Transportadora\"
	
	If Not FileExists(ls_Diretorio_Xml_Local) Then
		If CreateDirectory(ls_Diretorio_Xml_Local ) = -1 Then
			ls_Erro = "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio para a grava$$HEX2$$e700e300$$ENDHEX$$o do XML na m$$HEX1$$e100$$ENDHEX$$quina local. Diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_Diretorio_Xml_Local + "'."
			If Not of_Grava_Log(li_Log, ls_Erro, True ) Then
				MessageBox("Erro", "Erro ao gravar log na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_envia_xml_ftp_distribuidora' da 'GE614'.", StopSign!)
			End If
			Return 
		End If
	End If
		
	If Not lds_Notas.of_ChangeDataObject("ds_ge614_lista_notas_xml_ftp_transp") Then
		ls_Erro = "Erro no changeDataObject da 'ds_ge614_lista_notas_xml_ftp_transp'. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_envia_xml_ftp_distribuidora"
		If Not of_Grava_Log(li_Log, ls_Erro, True ) Then
			MessageBox("Erro", "Erro ao gravar log na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_envia_xml_ftp_distribuidora' da 'GE614'.", StopSign!)
		End If
		Return
	End If
	
	Try
		
		If Not This.of_localiza_data_hora_ultima_execucao( Ref ls_Erro ) Then 
			ls_Erro += " Horario Inv$$HEX1$$e100$$ENDHEX$$lido."
			If Not of_Grava_Log(li_Log, ls_Erro, False) Then 
				MessageBox("Erro", "Erro ao gravar log na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_envia_xml_ftp_distribuidora' da 'GE614'.", StopSign!)				
			End If 
			Return
		End If 
		
		
		If Not of_Conecta_Ftp_CLAMED(Ref lo_Ftp_Clamed, Ref ls_Erro) Then Return
			
		For ll_Linha_Transp = 1 To UpperBound(ls_Transportadora[])
			
			ls_Cd_Transportadora	= ls_Transportadora[ll_Linha_Transp]
			
			ll_Linhas	= lds_Notas.Retrieve(ls_Cd_Transportadora)
			
			If ll_Linhas > 0 Then
				Try
					w_Aguarde.Title = "Enviando XML de NF-e para a tansportadora "+ls_Cd_Transportadora+"..."
					
					w_Aguarde.uo_Progress.of_setmax(ll_Linhas)
				
					If Not	of_conecta_ftp_transportadora(ls_Cd_Transportadora, Ref lo_Ftp_Transportadora, Ref ls_Erro) Then
						If Not of_Grava_Log(li_Log, ls_Erro, True) Then
							MessageBox("Erro", "Erro ao gravar log na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_envia_xml_ftp_distribuidora' da 'GE614'.", StopSign!)
						End If
						Return
					End If
					
					For ll_Linha = 1 To ll_Linhas
						ls_Chave_Acesso		= lds_Notas.Object.de_chave_acesso	[ll_Linha]
						ldt_Emissao				= Date(lds_Notas.Object.dh_emissao	[ll_Linha])
						ls_CNPJ					= Mid(ls_Chave_Acesso, 7, 14)
						ls_Diretorio_Arquivo	= ls_Diretorio_Xml_Local
						ll_Filial					= lds_Notas.Object.cd_filial				[ll_Linha]
						ll_Nota					= lds_Notas.Object.nr_nf					[ll_Linha]
						ls_Especie				= lds_Notas.Object.de_especie			[ll_Linha]
						ls_Serie					= lds_Notas.Object.de_serie			[ll_Linha]
						
						If Not of_Busca_Xml_Ftp(lo_Ftp_Clamed, ls_Chave_Acesso, ldt_Emissao, ls_CNPJ, Ref ls_Diretorio_Arquivo, Ref ls_Erro) Then
							If Not of_Grava_Log(li_Log, ls_Erro, True ) Then
								MessageBox("Erro", "Erro ao gravar log na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_envia_xml_ftp_distribuidora' da 'GE614'.", StopSign!)
							End If
							
							//Realizado o continue para que o processo n$$HEX1$$e300$$ENDHEX$$o para de executar caso algum XML n$$HEX1$$e300$$ENDHEX$$o seja encontrado no FTP
							//Chamado 1106795
							Continue
						End If
						
						If Not of_Envia_Arquivo_Transportadora(lo_Ftp_Transportadora, ls_Diretorio_Arquivo, ls_Chave_Acesso, Ref ls_Erro) Then
							If Not of_Grava_Log(li_Log, ls_Erro, True ) Then
								MessageBox("Erro", "Erro ao gravar log na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_envia_xml_ftp_distribuidora' da 'GE614'.", StopSign!)
							End If
							Return
						End If
						
						If Not FileDelete ( ls_Diretorio_Arquivo ) Then
							ls_Erro = "Erro ao excluir o arquivo "+ls_Diretorio_Arquivo
							If Not of_Grava_Log(li_Log, ls_Erro, True ) Then
								MessageBox("Erro", "Erro ao gravar log na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_envia_xml_ftp_distribuidora' da 'GE614'.", StopSign!)
							End If
							Return
						End If
						
						If Not of_Atualiza_Situacao_Nota(ll_Filial, ll_Nota, ls_Especie, ls_Serie, Ref ls_Erro) Then
							If Not of_Grava_Log(li_Log, ls_Erro, True ) Then
								MessageBox("Erro", "Erro ao gravar log na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_envia_xml_ftp_distribuidora' da 'GE614'.", StopSign!)
							End If
							Return
						End If
						
						w_Aguarde.uo_Progress.of_setprogress(ll_Linha)
					Next			
					
				Finally
					lo_Ftp_Transportadora.of_desconecta_ftp( )
				End Try
			End If
		Next
	Finally	
		lo_Ftp_Clamed.of_desconecta_ftp( )
	End Try
	
Finally
	FileClose (li_Log )
	Destroy(lds_Notas)
	Destroy(lo_Ftp_Clamed)
	Destroy(lo_Ftp_Transportadora)
	Close(w_Aguarde)
End Try

end subroutine

public function boolean of_localiza_data_hora_ultima_execucao (ref string as_erro);String ldh_data_parametro

Long   ll_Tempo

// Busca Data Hora Agora
ldh_data_agora = String(gf_getserverdate(), 'dd-mm-yyyy hh:mm')

// Busca Data Hora Ultima Execu$$HEX2$$e700e300$$ENDHEX$$o
Select  vl_parametro  
Into :ldh_data_parametro
From 		parametro_geral 
Where	cd_parametro  =:lvs_parametro1
Using SqlCA;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao localizar data e hora do ultimo processo :of_localiza_data_hora_ultima_execucao': "+SqlCa.sqlErrText
	SqlCa.of_Rollback()
	Return False
End If

// Busca Data Hora Ultima Execu$$HEX2$$e700e300$$ENDHEX$$o
Select  vl_parametro  
Into :ll_Tempo_Executar
From 		parametro_geral 
Where	cd_parametro  =:lvs_parametro2
Using SqlCA;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao localizar data e hora do ultimo processo :of_localiza_data_hora_ultima_execucao': "+SqlCa.sqlErrText
	SqlCa.of_Rollback()
	Return False
End If


ll_Tempo =  ( gf_secondsafter(DateTime(ldh_data_parametro), DateTime(ldh_data_agora))  / 60 ) 


If ll_Tempo> ll_Tempo_Executar Then 
	Return True 
Else
	Return False
End If 	
end function

public function boolean of_grava_log (integer ai_log, string as_mensagem, boolean as_envia_email);String lvs_Mensagem

Integer lvi_Write

s_email str
	
lvs_Mensagem = String(Today(), "dd/mm/yyyy") + " " + String(Now(), "hh:mm:ss") + &
               " - " + as_Mensagem

lvi_Write = FileWrite(ai_Log, lvs_Mensagem)

If lvi_Write = LenA(lvs_Mensagem) Then
	str.ps_mensagem = lvs_Mensagem					

	If as_envia_email Then 
		gf_ge202_envia_email_padrao(111, str)
	End If 
	
	Return True
Else
	Return False
End If
end function

on uo_ge614_envia_xml_ftp_transportadora.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge614_envia_xml_ftp_transportadora.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

