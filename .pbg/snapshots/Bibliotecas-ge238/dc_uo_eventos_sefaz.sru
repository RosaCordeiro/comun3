HA$PBExportHeader$dc_uo_eventos_sefaz.sru
forward
global type dc_uo_eventos_sefaz from nonvisualobject
end type
end forward

global type dc_uo_eventos_sefaz from nonvisualobject
end type
global dc_uo_eventos_sefaz dc_uo_eventos_sefaz

type prototypes
//Function Integer EnviarManifestacaoDestinatario (Byte aNrEvento, String asChaveNota, String asCNPJ, String asJust, String asDhEvento, String asFusoHorario, String asOrgao, String asUf, Ref String asProtocolo, Ref String asErroLog) library "Eventos_Sefaz.dll" alias for "EnviarManifestacaoDestinatario;Ansi"
//Function Integer DownloadXml (string aChave, String aCnpj, String aUf, Ref String aLogErro) library "Eventos_Sefaz.dll" alias for "DownloadXml;Ansi"

Function Integer EnviarManifestacaoDestinatario (Byte aNrEvento, String asChaveNota, String asCNPJ, String asJust, String asDhEvento, String asFusoHorario, String asOrgao, String asUf, Ref String asErroLog) library "C:\Sistemas\DLL\SEFAZ\Eventos_Sefaz.dll" alias for "EnviarManifestacaoDestinatario;Ansi"
Function Integer DownloadXml (string aChave, String aCnpj, String aUf, Ref String asErroLog) library "C:\Sistemas\DLL\SEFAZ\Eventos_Sefaz.dll" alias for "DownloadXml;Ansi"
Function Integer EnviaXmlPorEmail(String as_Chave_Acesso, String as_Email, String as_Email_Cc, String as_Mensagem, String as_Assunto, String as_Diretorio_Xml, Ref String as_Erro)library "C:\Sistemas\DLL\SEFAZ\Eventos_Sefaz.dll" alias for "EnviaXmlPorEmail;Ansi"
Function Integer EnviaManifestacaoDestinatario_Novo(Byte ai_Evento, String as_ChaveNota, String as_CNPJ, String as_Justificativa, String as_DhEvento, String as_FusoHorario, String as_Orgao, String as_UF, Ref String as_Retorno)library "C:\Sistemas\DLL\SEFAZ\Eventos_Sefaz.dll" alias for "EnviaManifestacaoDetinatario_Novo;Ansi"
Function Integer ConsultarNF(String as_Chave_Acesso, String as_Uf, Ref String as_Retorno)library "C:\Sistemas\DLL\SEFAZ\Eventos_Sefaz.dll" alias for "ConsultarNF;Ansi"
Function Integer ConsultarDistribuicaoDFeChave (String as_cdUF,  String as_deUF, String as_CNPJ, String as_ChaveAcesso, Ref Blob as_XML_Retorno) library "C:\Sistemas\DLL\SEFAZ\Eventos_Sefaz.dll" alias for "ConsultarDistribuicaoDFeChave;Ansi"
Function Integer DescompactarXMLZip(String as_ArquivoConpact, Ref String as_ArquivoDecompact)  library "C:\Sistemas\DLL\SEFAZ\Eventos_Sefaz.dll" alias for "DescompactarXMLZip;Ansi"
Function Integer ExportarDanfe(String as_XML, String as_GerarNoDiretorio, Ref String as_Retorno)  library "C:\Sistemas\DLL\SEFAZ\Eventos_Sefaz.dll" alias for "ExportarDanfe;Ansi"
Function Integer consultarGTIN(String as_GTIN, Ref String as_Retorno)  library "C:\Sistemas\DLL\SEFAZ\Eventos_Sefaz.dll" alias for "consultarGTIN;Ansi"
end prototypes

type variables
dc_uo_api ivo_api
uo_smtp ivo_smtp
end variables

forward prototypes
public function boolean of_fuso_horario (string as_uf, ref string as_fuso_horario, ref string as_mensagem_log)
public function boolean of_envia_manifestacao_destinatario (integer ai_nr_evento, string as_chave_nota, string as_justificativa, long al_filial, ref string as_mensagem_log)
protected function boolean of_existe_destinadas (string as_chave_acesso, long al_filial, ref string as_mensagem_log)
public function boolean of_atualiza_id_download_sefaz (string as_chave, ref string as_mensagem)
public function boolean of_envia_xml_por_email (string as_chave_acesso, string as_email, string as_email_cc, string as_texto_email, string as_assunto, string as_diretorio_xml, ref string as_erro)
public function boolean of_envia_manifesta$$HEX2$$e700e300$$ENDHEX$$o_destinatario_novo (integer ai_evento, string as_chave_nota, string as_cnpj, string as_justificativa, string as_orgao, string as_uf, string as_data_evento, ref string as_retorno)
public function boolean of_consultar_nf (string as_chave_acesso, ref string as_retorno)
public function boolean of_uf_autorizadora (string as_chave_acesso, ref string as_uf, ref string as_erro)
public function boolean of_download_xml (string as_chave_nota, long al_filial, ref string as_mensagem_log, string as_diretorio_importacao, string as_diretorio_importacao_xml)
public function blob of_replace_blob (blob abs_assunto, string ps_pesquisa, string ps_substitui, long pl_qtde)
public function boolean of_gera_danfe_nfe (string as_xml, string as_arquivo, ref string as_erro)
public function boolean of_consultar_gtin (string as_gtin, ref string as_retorno)
end prototypes

public function boolean of_fuso_horario (string as_uf, ref string as_fuso_horario, ref string as_mensagem_log);
String ls_Id_Horario_Verao

as_Mensagem_Log = ""

select vl_parametro
into :ls_Id_Horario_Verao
from parametro_geral
where cd_parametro = 'ID_HORARIO_VERAO_NFE'
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case -1
		as_Mensagem_Log = "Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro ID_HORARIO_VERAO_NFE: "+ SqlCa.SQLErrText
		Return False
	Case 100
		as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o par$$HEX1$$e200$$ENDHEX$$metro ID_HORARIO_VERAO_NFE: "+ SqlCa.SQLErrText
		Return False					
End Choose		

as_Fuso_Horario = ""
If ls_Id_Horario_Verao = "S" Then
	as_Fuso_Horario = "-02:00"
Else
    as_Fuso_Horario = "-03:00"
End If

Return True

end function

public function boolean of_envia_manifestacao_destinatario (integer ai_nr_evento, string as_chave_nota, string as_justificativa, long al_filial, ref string as_mensagem_log);//ai_nr_evento: 	1 - Confirma$$HEX2$$e700e300$$ENDHEX$$o da Opera$$HEX2$$e700e300$$ENDHEX$$o
//						2 - Ci$$HEX1$$ea00$$ENDHEX$$ncia da Opera$$HEX2$$e700e300$$ENDHEX$$o
//						3 - Desconhecimento da Opera$$HEX2$$e700e300$$ENDHEX$$o
//						4 - Opera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o Realizada

String 	ls_Cgc,&
			ls_Uf,&
			ls_Fuso_Horario,&
			ls_Dh_Evento,&
			ls_Orgao,&
			ls_Evento,&
			ls_Situacao_Nf
			
DateTime ldh_Evento
Long ll_Qtde

select a.nr_cgc, b.cd_unidade_federacao 
into :ls_Cgc, :ls_Uf
from filial a
inner join cidade b on b.cd_cidade = a.cd_cidade
where cd_filial = :al_Filial
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case -1
		as_Mensagem_Log = "Erro ao selecionar dados da filial: "+ SqlCa.SQLErrText
		Return False
	Case 100
		as_Mensagem_Log = "Dados da filial "+String(al_Filial)+" n$$HEX1$$e300$$ENDHEX$$o localizados: "+ SqlCa.SQLErrText
		Return False	
				
End Choose		
		
If Not of_Fuso_Horario(ls_Uf, Ref ls_Fuso_Horario, Ref as_Mensagem_Log) Then
	Return False	
End If

ls_Orgao = '91'  //Nacional
ldh_Evento = gf_GetServerDate()
ls_Dh_Evento = String(ldh_Evento, "YYYY-MM-DD")+"T"+String(ldh_Evento, "HH:MM:SS")

as_Mensagem_Log = Space(1000)

If EnviarManifestacaoDestinatario(ai_nr_evento, as_chave_nota, ls_Cgc, as_Justificativa, ls_Dh_Evento, ls_Fuso_Horario, ls_Orgao, ls_Uf, Ref as_Mensagem_Log) = 1 Then

	 Choose Case ai_Nr_Evento 
		Case 1
			ls_Evento = "210200" //Confirmacao da operacao
		Case 2
			ls_Evento = "210210" //Ci$$HEX1$$ea00$$ENDHEX$$ncia da Opera$$HEX2$$e700e300$$ENDHEX$$o
		Case 3 
			ls_Evento = "210220" //Desconhecimento da Opera$$HEX2$$e700e300$$ENDHEX$$o
		Case 4 
			ls_Evento = "210240" //Opera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o Realizada
	End Choose
	
	ls_Situacao_Nf = "1"
	//ls_Xml_Faltante = "S"
	
	Select count(*) 
	Into :ll_Qtde
	from nfe_manifestacao
	where de_chave_acesso = :as_chave_nota
	and id_situacao_nf = :ls_Situacao_Nf
	and id_evento = :ls_Evento 
	Using SqlCa;

	If SqlCa.SqlCode  = -1 Then
		as_Mensagem_Log = "Erro ao verificar se j$$HEX1$$e100$$ENDHEX$$ existe o registro na 'nfe_manifestacao': "+ SqlCa.SQLErrText
		Return False	
	Else
		If ll_Qtde < 1 Then
			If of_Existe_Destinadas(as_chave_nota, al_Filial, Ref as_Mensagem_Log) Then
				Insert into nfe_manifestacao(
							de_chave_acesso,
							id_situacao_nf,
							id_evento,
							dh_evento,
							nr_protocolo,
							de_justificativa,
							id_falta_xml )
				values(	:as_chave_nota,
							:ls_Situacao_Nf,
							:ls_Evento,
							:ldh_Evento,			  
							'',
							:as_Justificativa,
							'S')
				Using SqlCa;
			
				If SqlCa.SqlCode  = -1 Then
					as_Mensagem_Log = "Erro no insert da tabela 'nfe_manifestacao': "+ SqlCa.SQLErrText
					//SqlCa.of_Rollback( )
					Return False	
				Else
					//SqlCa.of_Commit( )
					Return True
				End If	
			Else
				Return False
			End If	
		End If
	End If				
Else	
	If IsNull(as_Mensagem_Log) or (as_Mensagem_Log = "") Then
		as_Mensagem_Log = "Erro ao enviar a manifesta$$HEX2$$e700e300$$ENDHEX$$o do destinat$$HEX1$$e100$$ENDHEX$$rio na SEFAZ" 
	End If
	
	Return False	
End If

Return True
end function

protected function boolean of_existe_destinadas (string as_chave_acesso, long al_filial, ref string as_mensagem_log);Long ll_Qtde
String 	ls_Cgc_Origem,&
			ls_Razao_Social_Origem,&
			ls_Inscricao_Estadual_Origem,&
			ls_Cgc_Destinatario


select count(*) 
Into :ll_Qtde
from nfe_destinadas 
where de_chave_acesso = :as_chave_acesso
Using SqlCa;

If SqlCa.SqlCode  = -1 Then
	as_Mensagem_Log = "Erro ao verificar se j$$HEX1$$e100$$ENDHEX$$ existe o registro na 'nfe_destinadas': "+ SqlCa.SQLErrText
	Return False	
Else
	If ll_Qtde < 1 Then
		
		ls_Cgc_Origem = Mid(as_chave_acesso, 7, 14)
		
		select Top 1	nm_razao_social,	nr_inscricao_estadual
		Into :ls_Razao_Social_Origem, :ls_Inscricao_Estadual_Origem
 		from fornecedor where nr_cgc= :ls_Cgc_Origem
		Using SqlCa;
		If SqlCa.SqlCode  = -1 Then
			as_Mensagem_Log = "Erro ao localizar dados do fornecedor: "+ SqlCa.SQLErrText
			Return False	
		End If
		
		Select nr_cgc
		Into :ls_Cgc_Destinatario
		from filial 
		where cd_filial = :al_Filial
		Using SqlCa;
		If SqlCa.SqlCode  = -1 Then
			as_Mensagem_Log = "Erro ao localizar dados da filial: "+ SqlCa.SQLErrText
			Return False	
		End If
		
		Insert Into nfe_destinadas(
					de_chave_acesso,
					id_situacao_nf,
					dh_emissao,
					nr_cgc_destino,
					nr_cgc_origem,
					nm_razao_social_origem,
					nr_inscricao_estadual_origem,
					vl_nf,
					id_tipo_nf,
					id_situacao_manifestacao )
		Values(	:as_chave_acesso,
					'1',
					dateadd(day,-1,getdate()),
					:ls_Cgc_Destinatario,
					:ls_Cgc_Origem,
					:ls_Razao_Social_Origem,
					:ls_Inscricao_Estadual_Origem,
					0,
					'1',
					'0'	)
		Using SqlCa;
		If SqlCa.SqlCode  = -1 Then
			as_Mensagem_Log = "Erro ao inserir registro na nfe_destinadas: "+ SqlCa.SQLErrText
			Return False	
		End If
	End If
	
End If


Return True
end function

public function boolean of_atualiza_id_download_sefaz (string as_chave, ref string as_mensagem);Update nfe_destinadas
	set id_download_sefaz 	= 'S'
where de_chave_acesso 	= :as_chave
	and id_situacao_nf			= '1'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_mensagem = 'Erro ao atualizar a coluna id_download_sefaz. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_Atualiza_id_download_sefaz. ' + SqlCa.sqlErrText
	Return False
End If

Return True
end function

public function boolean of_envia_xml_por_email (string as_chave_acesso, string as_email, string as_email_cc, string as_texto_email, string as_assunto, string as_diretorio_xml, ref string as_erro);
as_Erro = Space(1000)

If EnviaXmlPorEmail(as_Chave_Acesso, as_Email, as_Email_Cc, as_Texto_Email, as_Assunto, as_Diretorio_Xml, Ref as_Erro) = 1 Then
	Return True
Else
	Return False
End If
end function

public function boolean of_envia_manifesta$$HEX2$$e700e300$$ENDHEX$$o_destinatario_novo (integer ai_evento, string as_chave_nota, string as_cnpj, string as_justificativa, string as_orgao, string as_uf, string as_data_evento, ref string as_retorno);String 	ls_Fuso_Horario

Try
	If Not This.of_fuso_horario(as_UF, Ref ls_Fuso_Horario, Ref as_Retorno) Then
		Return False
	End If
	
	as_Retorno = Space(5000)
	
	If EnviaManifestacaoDestinatario_Novo(	ai_Evento,&
														as_Chave_Nota,&
														as_CNPJ,&
														as_Justificativa,&
														as_Data_Evento,&
														ls_Fuso_Horario,&
														as_Orgao,&
														as_UF,&
														Ref as_Retorno) = 1 Then
														
		Return True
	Else
		Return False
	End If
Catch ( runtimeerror  lo_rte )
	as_Retorno = "Ocorreu erro ao enviar manifesta$$HEX2$$e700e300$$ENDHEX$$o do destinat$$HEX1$$e100$$ENDHEX$$ro: "+lo_rte.GetMessage()
	Return False
End Try
end function

public function boolean of_consultar_nf (string as_chave_acesso, ref string as_retorno);String ls_Uf

If Not This.of_uf_autorizadora(as_Chave_Acesso, Ref ls_Uf, Ref as_retorno) Then
	Return False
End If

as_Retorno = Space(15000)

If ConsultarNF(as_Chave_Acesso, ls_Uf, Ref as_Retorno) = 1 Then
	Return True
Else
	Return False
End If
end function

public function boolean of_uf_autorizadora (string as_chave_acesso, ref string as_uf, ref string as_erro);Long ll_Codigo_Uf

ll_Codigo_Uf = Long(Mid(as_Chave_Acesso , 1, 2))

  Choose Case ll_Codigo_Uf
	Case 11
		as_Uf = 'RO'
	Case 12
		as_Uf = 'AC'
	Case 13
		as_Uf = 'AM'
	Case 14
		as_Uf = 'RR'
	Case 15
		as_Uf = 'PA'
	Case 16
		as_Uf = 'AP'
	Case 17
		as_Uf = 'TO'
	Case 21
		as_Uf = 'MA'
	Case 22
		as_Uf = 'PI'
	Case 23
		as_Uf = 'CE'
	Case 24
		as_Uf = 'RN'
	Case 25
		as_Uf = 'PB'
	Case 26
		as_Uf = 'PE'
	Case 27
		as_Uf = 'AL'
	Case 28
		as_Uf = 'SE'
	Case 29
		as_Uf = 'BA'
	Case 31
		as_Uf = 'MG'
	Case 32
		as_Uf = 'ES'
	Case 33
		as_Uf = 'RJ'
	Case 35
		as_Uf = 'SP'
	Case 41
		as_Uf = 'PR'
	Case 42
		as_Uf = 'SC'
	Case 43
		as_Uf = 'RS'
	Case 50
		as_Uf = 'MS'
	Case 51
		as_Uf = 'MT'
	Case 52
		as_Uf = 'GO'
	Case 53
		as_Uf = 'DF'
	Case else
		as_Erro = 'UF n$$HEX1$$e300$$ENDHEX$$o localizada'
		Return False
End Choose
  
  Return True
end function

public function boolean of_download_xml (string as_chave_nota, long al_filial, ref string as_mensagem_log, string as_diretorio_importacao, string as_diretorio_importacao_xml);
String	ls_Cgc,&
		ls_Uf,&
		ls_Nm_Arquivo,&
		ls_Nm_Arquivo_Destino,&
		ls_Destinatario [] = {"nfe@clamed.com.br"},&
		ls_Copia[],&
		ls_Anexo[],&
		ls_XML,&
		ls_Cd_Uf,&
		ls_Parte_XML,&
		ls_Arquivo_Descompactado,&
		ls_XML_Descompactado
		
DateTime ldh_Evento

integer	li_FileNum,&
			li_Retorno

Blob	lblb_XML

Long	ll_Pos1,&
		ll_Pos2,&
		ll_Tamanho,&
		ll_FileLen,&
		ll_Loops,&
		ll_Step,&
		ll_resp
Try
	select a.nr_cgc, b.cd_unidade_federacao 
	into :ls_Cgc, :ls_Uf
	from filial a
	inner join cidade b on b.cd_cidade = a.cd_cidade
	where cd_filial = :al_Filial
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode 
		Case -1
			as_Mensagem_Log = "Erro ao selecionar dados da filial: "+ SqlCa.SQLErrText
			Return False
		Case 100
			as_Mensagem_Log = "Dados da filial "+String(al_Filial)+" n$$HEX1$$e300$$ENDHEX$$o localizados: "+ SqlCa.SQLErrText
			Return False					
	End Choose	
	
	
	ls_Cd_Uf = gf_Codigo_UF(ls_Uf)
	
	
	lblb_XML = Blob(Space(800000))
	
	ll_resp = ConsultarDistribuicaoDFeChave (ls_Cd_Uf, ls_UF, ls_Cgc, as_Chave_Nota, Ref lblb_XML)
	
	If ll_resp <> 1 Then
		as_Mensagem_Log = 'Erro:' + String(ll_resp) + ' - de_erro: ' + String(lblb_XML, EncodingANSI!)
		
		Return False
	End If
	
	If Pos(String(lblb_XML, EncodingANSI!), '<docZip') > 0 Then
		DO WHILE Pos(String(lblb_XML, EncodingANSI!), '<docZip') > 0
			
			ll_Pos1 = Pos(String(lblb_XML, EncodingANSI!), "<docZip", 1)
			ll_Pos2 = Pos(String(lblb_XML, EncodingANSI!), "</docZip>", 1)
			
			ll_Tamanho = (ll_Pos2 + LenA('</docZip>')) - ll_Pos1
		
			ls_Parte_XML = Mid(String(lblb_XML, EncodingANSI!), ll_Pos1, ll_Tamanho)
			
			If LenA(ls_Parte_XML) > 0 Then
				 lblb_XML = This.of_replace_blob(lblb_XML,  ls_Parte_XML , '', 0)	//Limpa parte j$$HEX1$$e100$$ENDHEX$$ utilizada
			End If
			
			If Pos(ls_Parte_XML, 'schema="procNFe') > 0 Then //Nota Fiscal Completa
				ll_Pos1 = Pos(ls_Parte_XML, '.xsd">') + LenA( '.xsd">')
				ll_Pos2 = Pos(ls_Parte_XML, "</docZip>")
			
				ll_Tamanho = ll_Pos2 - ll_Pos1
			
				ls_Parte_XML = Mid(ls_Parte_XML, ll_Pos1, ll_Tamanho)
				
				
				ls_Arquivo_Descompactado = Space(599999)
				
				If DescompactarXMLZip(ls_Parte_XML, Ref ls_Arquivo_Descompactado) = 1 Then
					If Pos(ls_Arquivo_Descompactado, "<det nItem=") > 0 Then	//Verifica se $$HEX1$$e900$$ENDHEX$$ nota fiscal
						ls_Nm_Arquivo 				= as_Chave_Nota+"-NFe.xml"
						ls_Nm_Arquivo_Destino 	= as_Chave_Nota+"-nfe.xml"
		
						Try
							li_FileNum = FileOpen("C:\NF\Download\"+ls_Nm_Arquivo,  LineMode!, Write!, LockWrite!, Append!)
							
							If (li_FileNum = -1) or IsNull(li_FileNum) Then
								as_Mensagem_Log = "Erro ao criar o arquivo 'C:\NF\Download\"+ls_Nm_Arquivo+"'"
								Return False
							End If
							
							ls_XML_Descompactado = '<?xml version="1.0" encoding="UTF-8"?>'+ls_Arquivo_Descompactado
							
							 ll_FileLen = Len(ls_XML_Descompactado)
							 
							 If ll_FileLen > 32765 Then
								  If Mod(ll_FileLen, 32765) = 0 Then
										ll_Loops = ll_FileLen/32765
								  Else
										ll_Loops = (ll_FileLen/32765) + 1
								  End If
							 Else
								  ll_Loops = 1
							 End If
							 For ll_Step = 1 To ll_Loops
								  li_Retorno = FileWrite(li_FileNum, Mid(ls_XML_Descompactado,((ll_Step - 1)*32765) + 1, 32765))
								  
								  If (li_Retorno = -1) or IsNull(li_Retorno) Then
									as_Mensagem_Log = "Erro ao escrever o arquivo 'C:\NF\Download\"+ls_Nm_Arquivo+"'"
									Return False
								End If
							 Next
							
						Finally
							FileClose(li_FileNum)
						End Try
						
						If Not ivo_Api.of_copy_file("C:\NF\Download\"+ls_Nm_Arquivo, as_diretorio_importacao +ls_Nm_Arquivo_Destino, False) Then
							as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel copiar o arquivo XML para o " + as_diretorio_importacao + " para ser importado"
							Return False	
						End If
						
						// Deixa um c$$HEX1$$f300$$ENDHEX$$pia para o GN importar
						If Not ivo_Api.of_copy_file("C:\NF\Download\"+ls_Nm_Arquivo, as_diretorio_importacao_xml +ls_Nm_Arquivo_Destino, False) Then
							as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel copiar o arquivo XML para o " + as_diretorio_importacao + " para ser importado"
							Return False	
						End If
			
						FileDelete("C:\NF\Download\"+ls_Nm_Arquivo)
					Else
						Return False
					End If	
				Else
					as_Mensagem_Log = "Erro ao descompactar o nta fiscal baixada da SEFAZ: "+ls_Arquivo_Descompactado
					Return False			
				End If	
			Else
				as_Mensagem_Log = "Nenhum documento localizado na SEFAZ." + String(lblb_XML, EncodingANSI!)
				Return False
			End If
		
		LOOP
	Else
		as_Mensagem_Log = "Nenhum documento localizado na SEFAZ." + String(lblb_XML, EncodingANSI!)
		Return False
	End If
	
Catch	( runtimeerror  lo_rte_1 )
	as_Mensagem_Log = "Erro ao fazer download do arquivo: "+ lo_rte_1.GetMessage()
	Return False
End Try

Return True
end function

public function blob of_replace_blob (blob abs_assunto, string ps_pesquisa, string ps_substitui, long pl_qtde);Long lvl_Pos, &
	  lvl_Contador, &
	  lvl_Len
 
  
 
lvl_Pos = PosA(String(abs_Assunto, EncodingANSI!), ps_Pesquisa)
lvl_Len = LenA(ps_Pesquisa)

If pl_Qtde = 0 Then
	
	Do While lvl_Pos > 0
		abs_Assunto = Blob(ReplaceA(String(abs_Assunto, EncodingANSI!), lvl_Pos, lvl_Len, ps_Substitui), EncodingUTF8!)
		lvl_Pos = PosA(String(abs_Assunto, EncodingANSI!), ps_Pesquisa)
	Loop
	
Else
	
	For lvl_Contador = 1 To pl_Qtde
		If lvl_Pos = 0 Then
			Exit
		End If
		abs_Assunto = Blob(ReplaceA(String(abs_Assunto, EncodingANSI!), lvl_Pos, lvl_Len, ps_Substitui), EncodingUTF8!)
		lvl_Pos = PosA(String(abs_Assunto, EncodingANSI!), ps_Pesquisa)
	Next
	
End If

Return abs_Assunto

end function

public function boolean of_gera_danfe_nfe (string as_xml, string as_arquivo, ref string as_erro);If (as_Arquivo = "") or IsNull(as_Arquivo) Then
	as_Erro = "O diret$$HEX1$$f300$$ENDHEX$$rio do arquivo para a gera$$HEX2$$e700e300$$ENDHEX$$o da DANFE n$$HEX1$$e300$$ENDHEX$$o foi informado."
	Return False
End If

If Not FileExists(as_Arquivo) Then
	If ExportarDanfe(as_XML, as_Arquivo, Ref as_Erro) <> 1 Then
		as_Erro = "Erro ao gerar a DANFE: "+as_Erro
		Return False	
	End If
End If

Return True

end function

public function boolean of_consultar_gtin (string as_gtin, ref string as_retorno);String ls_Uf

as_Retorno = Space(15000)

If this.consultarGTIN(as_GTIN, Ref as_Retorno) = 1 Then
	Return True
Else
	Return False
End If
end function

on dc_uo_eventos_sefaz.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_eventos_sefaz.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivo_api = Create dc_uo_api 
ivo_smtp = Create uo_smtp
ivo_smtp.ib_grava_log_db = False
end event

event destructor;Destroy(ivo_api)
Destroy(ivo_smtp)
end event

