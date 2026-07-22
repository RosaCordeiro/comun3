HA$PBExportHeader$uo_ge238_importa_xml.sru
forward
global type uo_ge238_importa_xml from nonvisualobject
end type
end forward

global type uo_ge238_importa_xml from nonvisualobject
end type
global uo_ge238_importa_xml uo_ge238_importa_xml

type variables
String is_Diretorio_Leitura, is_Diretorio_Erro_Leitura_XML

Integer ii_log

string is_ftp_xml_endereco, is_ftp_xml_usuario, is_ftp_xml_senha, is_evento

dc_uo_ftp io_Ftp
end variables

forward prototypes
public function boolean of_diretorio_leitura_xml ()
public function boolean of_grava_log (string as_mensagem)
public function boolean of_abre_log ()
public function boolean of_diretorio_erro_leitura_xml ()
public function boolean of_parametro_conexao_ftp ()
public function boolean of_leitura_xml_cte (string as_arquivo_xml, ref string as_chave, ref string as_data_emissao, ref string as_cnpj, ref string as_serie, ref string as_cnpj_destino, ref long al_nota, ref date adt_emissao)
public function boolean of_leitura_xml (string as_arquivo_xml, ref string as_chave, ref string as_data_emissao, ref string as_cnpj, ref string as_serie, ref string as_cnpj_destino, ref long al_nota, ref date adt_emissao, ref string as_tipo_xml)
public function boolean of_insere_nfe_indexacao (string as_chave, string as_cnpj_origem, string as_cnpj_destino, long al_nota, string as_serie, date adt_emissao, string as_tipo_xml)
public function boolean of_envia_ftp_clamed (string as_arquivo_xml, string as_data_emissao, string as_cnpj, string as_chave, string as_tipo_xml)
public function boolean of_baixa_cte_ftp ()
public function boolean of_leitura_xml_nfe (string as_arquivo_xml, ref string as_chave, ref string as_data_emissao, ref string as_cnpj, ref string as_serie, ref string as_cnpj_destino, ref long al_nota, ref date adt_emissao, ref string as_nfe_cte)
public function boolean of_processa_leitura ()
end prototypes

public function boolean of_diretorio_leitura_xml ();is_Diretorio_Leitura = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, 'Diretorio', 'XMLLeitura', "")

If is_Diretorio_Leitura <> "" Then
//	If Not DirectoryExists( as_Diretorio) Then
//		If CreateDirectory(as_Diretorio ) = -1 Then
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio para a importa$$HEX2$$e700e300$$ENDHEX$$o do XML '" + as_Diretorio + "'.")
//			Return False
//		End If
//	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro  'XMLLeitura' n$$HEX1$$e300$$ENDHEX$$o localizado no INI da aplica$$HEX2$$e700e300$$ENDHEX$$o <<< Pasta onde XML recebido via e-mail $$HEX1$$e900$$ENDHEX$$ gravado >>>.")
	Return False
End If

Return True
end function

public function boolean of_grava_log (string as_mensagem);return gf_grava_log_basico(ii_log, as_mensagem)
end function

public function boolean of_abre_log ();String ls_Path

ls_Path 	= gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")

If IsNull(ls_Path) or Trim(ls_Path) = '' Then 
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Diret$$HEX1$$f300$$ENDHEX$$rio para a grava$$HEX2$$e700e300$$ENDHEX$$o do log n$$HEX1$$e300$$ENDHEX$$o foi localizado no INI da aplica$$HEX2$$e700e300$$ENDHEX$$o. Chave: Diretorio | Se$$HEX2$$e700e300$$ENDHEX$$o: Diretorio = c:\sistemas\gn\arquivos\ .", StopSign!)
	Return False
End If

ls_Path = ls_Path + "xml_email_" + string(Today(),"ddmm")

If Not gf_Cria_Logs(ls_Path, 4, ref ii_log) Then
	Return False
End If

Return True
end function

public function boolean of_diretorio_erro_leitura_xml ();is_Diretorio_Erro_Leitura_XML = is_Diretorio_Leitura + "ErroLeituraXml\"

If Not DirectoryExists( is_Diretorio_Erro_Leitura_XML ) Then
	If CreateDirectory(is_Diretorio_Erro_Leitura_XML ) = -1 Then
		of_Grava_Log("Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio para a grava$$HEX2$$e700e300$$ENDHEX$$o de XML com erro '" + is_Diretorio_Erro_Leitura_XML + "'.")
		Return False
	End If
End If

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

public function boolean of_leitura_xml_cte (string as_arquivo_xml, ref string as_chave, ref string as_data_emissao, ref string as_cnpj, ref string as_serie, ref string as_cnpj_destino, ref long al_nota, ref date adt_emissao);String ls_Xml, ls_Arquivo_Leitura, ls_Arquivo_Erro, ls_Anexo[]

Integer li_FileOpen

DateTime ldh_Emissao

t_cte lt_InfNFe

uo_ge195_cte lo_NFE

try
	ls_Arquivo_Leitura = is_Diretorio_Leitura + as_arquivo_xml
	
	ls_Arquivo_Erro	= is_Diretorio_Erro_Leitura_XML + as_arquivo_xml
	
	li_FileOpen = FileOpen (ls_Arquivo_Leitura  , TextMode! , Read!, LockRead! )
	FileReadEx (li_FileOpen, ls_Xml) 
	FileClose (li_FileOpen)
			
	If ls_Xml <> "" Then
		
		lo_NFE 	= Create uo_ge195_cte
		If not lo_NFE.of_read_xml(ls_Xml, Ref lt_InfNFe) Then
			of_Grava_Log("Erro ao ler o arquivo XML '" + ls_Arquivo_Leitura)
			// Move para a pasta dos arquivos com erro
			FileMove (ls_Arquivo_Leitura, ls_Arquivo_Erro )
			Return  False
		End If
	
		as_chave 			= lt_InfNFe.id
		al_nota				= lt_InfNFe.ide.nct
		as_data_emissao	= String(Date(Mid(lt_InfNFe.ide.dhemi,9,2)+"/"+Mid(lt_InfNFe.ide.dhemi,6,2)+"/"+Mid(lt_InfNFe.ide.dhemi,1,4)+" "+Mid(lt_InfNFe.ide.dhemi,12,8)), "yyyymmdd")
		adt_emissao		= Date(Mid(lt_InfNFe.ide.dhemi,9,2)+"/"+Mid(lt_InfNFe.ide.dhemi,6,2)+"/"+Mid(lt_InfNFe.ide.dhemi,1,4)+" "+Mid(lt_InfNFe.ide.dhemi,12,8))
		as_serie				= lt_InfNFe.ide.serie
		as_cnpj 				= lt_InfNFe.emit.cnpj
		as_cnpj_destino	= lt_InfNFe.dest.cnpj
				 
	Else
		If Not FileDelete (ls_Arquivo_Leitura) Then
			of_Grava_Log("Erro ao excluir o arquivo '" + ls_Arquivo_Leitura + ".")
		End If
		
		Return  False
	End If

finally
	Destroy lo_NFE
end try

Return True
end function

public function boolean of_leitura_xml (string as_arquivo_xml, ref string as_chave, ref string as_data_emissao, ref string as_cnpj, ref string as_serie, ref string as_cnpj_destino, ref long al_nota, ref date adt_emissao, ref string as_tipo_xml);Integer li_FileOpen

String ls_Arquivo_Leitura, ls_Arquivo_Erro, ls_Xml, ls_NFE_CTE

Try

	ls_Arquivo_Leitura = is_Diretorio_Leitura + as_arquivo_xml
		
	ls_Arquivo_Erro	= is_Diretorio_Erro_Leitura_XML + as_arquivo_xml
	
	li_FileOpen = FileOpen (ls_Arquivo_Leitura  , TextMode! , Read!, LockRead! )
	FileReadEx (li_FileOpen, ls_Xml) 
	FileClose (li_FileOpen)
	
	// Quando 
	If Pos( ls_Xml, "<infCte" ) > 0 Then
		If Not of_leitura_xml_CTe(	as_arquivo_xml, &
											ref as_chave,  &
											ref as_data_emissao, &
											ref as_cnpj, &
											ref as_serie, &
											ref as_cnpj_destino, &
											ref al_nota, &
											ref adt_emissao ) Then Return False
		as_Tipo_Xml = "CTE"
	Else
		// NFE, cancelamento de NFE ou cancelamento de CTE
		If Not of_leitura_xml_NFe(	as_arquivo_xml, &
											ref as_chave,  &
											ref as_data_emissao, &
											ref as_cnpj, &
											ref as_serie, &
											ref as_cnpj_destino, &
											ref al_nota, &
											ref adt_emissao, &
											ref ls_NFE_CTE ) Then Return False	
		If ls_NFE_CTE = "" Then
			as_Tipo_Xml = 'NFE'
		Else
			as_Tipo_Xml = ls_NFE_CTE
		End If
	End If
	
Catch ( runtimeerror  lo_rte )
	of_Grava_Log("Erro ao ler o arquivo XML: ["+  ls_Arquivo_Leitura + "] "+lo_rte.GetMessage())
	Return False
End Try		

Return True
end function

public function boolean of_insere_nfe_indexacao (string as_chave, string as_cnpj_origem, string as_cnpj_destino, long al_nota, string as_serie, date adt_emissao, string as_tipo_xml);Date ldh_Situacao

String ls_Achou

If is_evento = 'CANCELAMENTO' Then Return True

ldh_Situacao = Date(gf_GetServerDate())

Select id_nf
Into :ls_Achou
From nfe_indexacao
Where id_nf = :as_chave
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 0
	Case 100
		
		Insert Into nfe_indexacao(id_nf,cgc_origem,nr_nf,	de_especie,	de_serie,	cgc_destino,	dh_emissao,id_situacao,dh_situacao,	dh_entrada)
		 Values(	:as_chave,:as_cnpj_origem,:al_nota,	:as_tipo_xml,:as_serie,:as_cnpj_destino,:adt_emissao,'L',:ldh_Situacao, getdate())
		Using SqlCa;

		If SqlCa.SqlCode  = -1 Then
			of_Grava_Log("Erro no insert da tabela 'nfe_indexacao': "+ SqlCa.SQLErrText)
			SqlCa.of_Rollback( )
			Return False	
		End If	
		
	Case -1
		of_Grava_Log("Erro ao localizar a nota na tabela 'nfe_indexacao': "+ SqlCa.SQLErrText)
		SqlCa.of_Rollback( )
		Return False	
End Choose

Return True
end function

public function boolean of_envia_ftp_clamed (string as_arquivo_xml, string as_data_emissao, string as_cnpj, string as_chave, string as_tipo_xml);String ls_Ano, ls_Mes, ls_Dia, ls_Mensagem_Erro, ls_Arquivos[]

Long ll_Linhas
		
ls_Ano = "Ano_"+Mid(as_data_emissao, 1, 4)
ls_Mes = "Mes_"+Mid(as_data_emissao, 5, 2)
ls_Dia  = "Dia_"+Mid(as_data_emissao, 7, 2)

try
	
	If  io_Ftp.of_ftp_set_dir('/',Ref ls_Mensagem_Erro)  = -1 Then
		of_Grava_Log( "Erro ao voltar ao diret$$HEX1$$f300$$ENDHEX$$rio raiz " )
		Return False		
	End If
	
	If as_Tipo_Xml = 'CTE' Then
		If  io_Ftp.of_ftp_set_dir('CT-e',Ref ls_Mensagem_Erro)  = -1 Then
			If Not io_Ftp.of_ftp_cria_dir( 'CT-e', Ref ls_Mensagem_Erro) Then
				of_Grava_Log( "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio CT-e")
				Return False		
			Else
				If io_Ftp.of_ftp_set_dir( 'CT-e',Ref ls_Mensagem_Erro)  = -1 Then
					of_Grava_Log( "Erro setar o diret$$HEX1$$f300$$ENDHEX$$rio CT-e")
					Return False	
				End If
			End If
		End If
	End If	
		
	If  io_Ftp.of_ftp_set_dir( ls_Ano,Ref ls_Mensagem_Erro)  = -1 Then
		If Not io_Ftp.of_ftp_cria_dir( ls_Ano, Ref ls_Mensagem_Erro) Then
			of_Grava_Log( "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio "+ls_Ano )
			Return False		
		Else
			If io_Ftp.of_ftp_set_dir( ls_Ano,Ref ls_Mensagem_Erro)  = -1 Then
				of_Grava_Log( "Erro setar o diret$$HEX1$$f300$$ENDHEX$$rio "+ls_Ano)
				Return False	
			End If
		End If
	End If
						
	//Verifica mes***********************************************************
	If io_Ftp.of_ftp_set_dir( ls_Mes,Ref ls_Mensagem_Erro) = -1 Then
		If Not io_Ftp.of_ftp_cria_dir( ls_Mes, Ref ls_Mensagem_Erro)  Then
			of_Grava_Log("Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio "+ls_Mes)
			Return False	
		Else
			If  io_Ftp.of_ftp_set_dir( ls_Mes,Ref ls_Mensagem_Erro) = -1  Then
				of_Grava_Log("Erro setar o diret$$HEX1$$f300$$ENDHEX$$rio "+ls_Mes)
				Return False	
			End If
		End If
	End If
						
	//Verifica dia***********************************************************
	If io_Ftp.of_ftp_set_dir( ls_Dia,Ref ls_Mensagem_Erro) = -1 Then
		If Not io_Ftp.of_ftp_cria_dir( ls_Dia, Ref ls_Mensagem_Erro) Then
			of_Grava_Log("Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio "+ls_Dia)
			Return False	
		Else
			If io_Ftp.of_ftp_set_dir( ls_Dia,Ref ls_Mensagem_Erro) = -1 Then
				of_Grava_Log("Erro setar o diret$$HEX1$$f300$$ENDHEX$$rio "+ls_Dia)
				Return False	
			End If
		End If
	End If
						
	//Verifica Cnpj***********************************************************
	If io_Ftp.of_ftp_set_dir( as_cnpj,Ref ls_Mensagem_Erro) = -1 Then
		If Not io_Ftp.of_ftp_cria_dir( as_cnpj, Ref ls_Mensagem_Erro) Then
			of_Grava_Log("Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio "+as_cnpj)
			Return False		
		Else
			If io_Ftp.of_ftp_set_dir( as_cnpj,Ref ls_Mensagem_Erro) = -1 Then
				of_Grava_Log("Erro setar o diret$$HEX1$$f300$$ENDHEX$$rio "+as_cnpj)
				Return False	
			End If
		End If
	End If
	
	If is_evento = 'CANCELAMENTO' Then
		If Not io_Ftp.of_ftp_putfile(as_arquivo_xml, as_Chave+"-caneve.xml", Ref ls_Mensagem_Erro)	 Then
			of_Grava_Log("Erro ao enviar o arquivo para  FTP: "+ls_Mensagem_Erro)
			Return False	
		End If
	Else
		If as_Tipo_Xml = 'CTE' Then 
			If Not io_Ftp.of_ftp_putfile(as_arquivo_xml, as_Chave+"-cte.xml", Ref ls_Mensagem_Erro)	 Then
				of_Grava_Log("Erro ao enviar o arquivo para  FTP: "+ls_Mensagem_Erro)
				Return False	
			End If
		Else
			If Not io_Ftp.of_ftp_putfile(as_arquivo_xml, as_Chave+"-nfe.xml", Ref ls_Mensagem_Erro)	 Then
				of_Grava_Log("Erro ao enviar o arquivo para  FTP: "+ls_Mensagem_Erro)
				Return False	
			End If
		End If
	End If
finally
	
end try

Return True
end function

public function boolean of_baixa_cte_ftp ();String ls_Log

Time lt_Agora

lt_Agora = Now()

If (lt_Agora >= Time('08:00:00') And lt_Agora <= Time('09:00:00')) Or (lt_Agora >= Time('18:00:00') And lt_Agora <= Time('19:00:00')) Then
	
	dc_uo_xml_ftp_fornecedor lvo_Xml_Ftp_Fornecedor
	lvo_Xml_Ftp_Fornecedor = Create dc_uo_xml_ftp_fornecedor
	
	lvo_Xml_Ftp_Fornecedor.ii_Log = ii_log
	
	ls_Log = ""
	
	If Not lvo_Xml_Ftp_Fornecedor.of_busca_xml_fornecedor('053406083', Ref ls_Log) Then
		 of_Grava_Log(ls_Log)
	End If
	
	Destroy(lvo_Xml_Ftp_Fornecedor)
End If

Return True
end function

public function boolean of_leitura_xml_nfe (string as_arquivo_xml, ref string as_chave, ref string as_data_emissao, ref string as_cnpj, ref string as_serie, ref string as_cnpj_destino, ref long al_nota, ref date adt_emissao, ref string as_nfe_cte);String ls_Xml, ls_Arquivo_Leitura, ls_Arquivo_Erro, ls_Anexo[]

Integer li_FileOpen, li_Retorno

DateTime ldh_Emissao, ldt_Data_Servidor

t_infnfe lt_InfNFe
dc_uo_nfe lo_NFE

try
	ls_Arquivo_Leitura = is_Diretorio_Leitura + as_arquivo_xml
	
	ls_Arquivo_Erro	= is_Diretorio_Erro_Leitura_XML + as_arquivo_xml
	
	li_FileOpen = FileOpen (ls_Arquivo_Leitura  , TextMode! , Read!, LockRead! )
	FileReadEx (li_FileOpen, ls_Xml) 
	FileClose (li_FileOpen)
			
	If ls_Xml <> "" Then
		
//		If Pos(Upper(ls_Xml), Upper('versao="4.00"')) > 0 Then
//			gf_ge202_envia_email_automatico(47, "", "...ATEN$$HEX2$$c700c200$$ENDHEX$$O... Nota fiscal vers$$HEX1$$e300$$ENDHEX$$o 4.00 <br><br>Arquivo XML: "+as_arquivo_xml, ls_Anexo)  
//			//Return False
//		End If
		
		lo_NFE 	= Create dc_uo_nfe
		If not lo_NFE.of_read_xml(ls_Xml, True, Ref lt_InfNFe) Then
			If lo_NFE.is_evento <> 'CANCELAMENTO' Then
				of_Grava_Log("Erro ao ler o arquivo XML '" + ls_Arquivo_Leitura)
								
				If FileExists (ls_Arquivo_Erro) Then
					ldt_Data_Servidor = gf_GetServerDate()
					ls_Arquivo_Erro = Mid(ls_Arquivo_Erro, 1, Len(ls_Arquivo_Erro) - 4) + '_' + string(Day(Date(ldt_Data_Servidor)), '00') + string(Month(Date(ldt_Data_Servidor)), '00') +  string(Year(Date(ldt_Data_Servidor)), '00') + '_' +  string( Hour( time(ldt_Data_Servidor)  ) , '00') +  string( Minute ( time(ldt_Data_Servidor)  ) , '00') + '.xml'
				End If
				
				li_Retorno = FileMove (ls_Arquivo_Leitura, ls_Arquivo_Erro )
				
				// Move para a pasta dos arquivos com erro
				If  li_Retorno <> 1 Then
					of_Grava_Log("Erro ao mover o arquivo '" + ls_Arquivo_Erro + "'.")
				End If
				
				Return  False
			End If
		End If
		
		This.is_evento = lo_NFE.is_evento
		
		If This.is_evento = 'CANCELAMENTO' Then
			
			as_nfe_cte = lo_NFE.is_nfe_cte
			
			as_chave		= 	lo_NFE.is_nfe_cte + ' - ' + lo_NFE.is_chave_acesso_canc
			
			//N$$HEX1$$e300$$ENDHEX$$o envia e-mail para CTE
//			If as_nfe_cte <> 'CTE' Then
//				gf_ge202_envia_email_automatico(78, '- XML NF CANCELADA', as_chave, ls_Anexo)  
//			End If
			
			Select top 1 tudo.dh_emissao, nr_cgc_origem 
			Into :ldh_Emissao, :as_cnpj
			From 
				(
					select dh_emissao, cgc_origem as nr_cgc_origem
					from nfe_indexacao
					where id_nf = :lo_NFE.is_chave_acesso_canc
					
					union all
					
					select dh_emissao, nr_cgc_origem
					from nfe_destinadas
					where de_chave_acesso = :lo_NFE.is_chave_acesso_canc
					  and id_situacao_nf = '1'
				) as tudo
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case 0
					as_data_emissao = String(ldh_Emissao, "yyyymmdd")
				Case 100
					This.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o foi localizado o registro da chave '" +  as_chave + "' na tabela NFE_INDEXACAO.")
					Return False
				Case -1
					This.of_Grava_Log("Localiza$$HEX2$$e700e300$$ENDHEX$$o do registro da chave '" +  as_chave + "' na tabela NFE_INDEXACAO.")
					Return False
			End Choose
						
		Else
			as_chave 			= lt_InfNFe.id
			as_data_emissao	= String(lt_InfNFe.ide.demi, "yyyymmdd")
			as_cnpj 				= lt_InfNFe.emit.cnpj
			
			as_serie				=	lt_InfNFe.ide.serie
			as_cnpj_destino	=	lt_InfNFe.dest.cnpj
			al_nota				=	lt_InfNFe.ide.nnf
			adt_emissao		=	lt_InfNFe.ide.demi
		End If
				 
	Else
		If Not FileDelete (ls_Arquivo_Leitura) Then
			of_Grava_Log("Erro ao excluir o arquivo '" + ls_Arquivo_Leitura + ".")
		End If
		
		Return  False
	End If

finally
	Destroy lo_NFE
end try

Return True
end function

public function boolean of_processa_leitura ();String ls_Lista_Arquivos[], ls_Arquivo_Receb, ls_Chave, ls_Data_Emissao, ls_CNPJ, ls_Mensagem_Erro
String ls_Serie, ls_Cgc_Destino, ls_Tipo_Xml

Long ll_Retorno, ll_Linha, ll_Contador, ll_Nf, ll_Linhas

Date ldt_Emissao

try
	Open(w_Aguarde)
	
	If Not of_abre_log() Then Return False
	If Not of_diretorio_leitura_xml() Then Return False
	If Not of_diretorio_erro_leitura_xml() Then Return False
	If Not of_parametro_conexao_ftp() Then Return False
	If Not of_Baixa_Cte_Ftp() Then Return False
	
	ll_Retorno = gf_Dir_List(is_Diretorio_Leitura, "*.xml", 1, ref ls_Lista_Arquivos[])
		
	If ll_Retorno > 0 Then
		
		ll_Linhas = UpperBound(ls_Lista_Arquivos[])
				
		w_Aguarde.uo_Progress.of_setmax(ll_Linhas)
		
		For ll_Linha = 1 To ll_Linhas
			
			w_Aguarde.Title = "Enviando XML para '" + is_ftp_xml_endereco + "'... " + String(ll_Linha) + " de " + String(ll_Linhas)
			
			of_Grava_Log("Enviando XML para '" + is_ftp_xml_endereco + "'... " + ls_Lista_Arquivos[ll_Linha])
			
			If ll_Contador = 0 Then
				io_Ftp.of_Desconecta_ftp()
				w_Aguarde.Title = "Enviando XML para '" + is_ftp_xml_endereco + "'... " + String(ll_Linha) + " de " + String(ll_Linhas) + " <<< Conectando FTP >>>"
				If Not io_Ftp.of_Conecta_ftp("RO", is_ftp_xml_endereco, is_ftp_xml_usuario, is_ftp_xml_senha, Ref ls_Mensagem_Erro) Then
					of_Grava_Log(ls_Mensagem_Erro)
					w_Aguarde.uo_Progress.of_setprogress(ll_Linha)
					Continue
				End If
				w_Aguarde.Title ="Enviando XML para '" + is_ftp_xml_endereco + "'... " + String(ll_Linha) + " de " + String(ll_Linhas)
			End If
									
			ls_Arquivo_Receb = ls_Lista_Arquivos[ll_Linha]
			
			If of_leitura_xml(ls_Arquivo_Receb, ref ls_Chave,  ref ls_Data_Emissao, ref ls_CNPJ, ref ls_Serie, ref ls_Cgc_Destino, ref ll_Nf, ref ldt_Emissao, ref ls_Tipo_Xml) Then
				If of_envia_ftp_clamed(ls_Arquivo_Receb, ls_Data_Emissao, ls_CNPJ, ls_Chave, ls_Tipo_Xml) Then
					If of_insere_nfe_indexacao(ls_Chave, ls_CNPJ, ls_Cgc_Destino, ll_Nf, ls_Serie, ldt_Emissao, ls_Tipo_Xml) Then
						FileDelete(is_Diretorio_Leitura + ls_Arquivo_Receb)
						SqlCa.of_Commit()
					End If
				End If
			End If
			
			ll_Contador ++
			
			// A cadas N arquivos desconecta e conecta novamente na area ftp
			If ll_Contador >= 200 Then ll_Contador = 0
			
			w_Aguarde.uo_Progress.of_setprogress(ll_Linha)
		Next
		
		Return True
	ElseIf ll_Retorno < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao listar os arquivos da pasta '" + is_Diretorio_Leitura + "'.", StopSign!)
		Return False
	End If
finally
	FileClose(ii_Log)
	io_Ftp.of_Desconecta_ftp()
	Close(w_Aguarde)
end try
end function

on uo_ge238_importa_xml.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge238_importa_xml.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Ftp = Create dc_uo_ftp 
end event

event destructor;Destroy io_Ftp
end event

