HA$PBExportHeader$dc_uo_xml_ftp_fornecedor.sru
forward
global type dc_uo_xml_ftp_fornecedor from nonvisualobject
end type
end forward

global type dc_uo_xml_ftp_fornecedor from nonvisualobject
end type
global dc_uo_xml_ftp_fornecedor dc_uo_xml_ftp_fornecedor

type variables
dc_uo_ftp ivo_Ftp
dc_uo_ftp ivo_Ftp_Clamed
dc_uo_nfe ivo_Nfe

String is_Dir_Xml
String is_Prefixo_FTP

Integer ii_Log

string is_ftp_xml_endereco, is_ftp_xml_usuario, is_ftp_xml_senha


end variables

forward prototypes
public function boolean of_busca_xml_fornecedor (string as_fornecedor, ref string as_mensagem_log)
public function boolean of_insere_nfe_indexacao (t_infnfe at_infnfe, ref string as_mensagem_log)
public function boolean of_busca_arquivos (string as_fornecedor, ref string as_mensagem_log)
private function boolean of_descompacta_arquivos (string as_dir_arquivo, string as_destino, ref string as_mensagem_log)
public function boolean of_conecta_ftp (string as_fornecedor, ref string as_mensagem_log)
public function boolean of_grava_log (integer ai_arquivo, string as_mensagem)
public function boolean of_parametro_conexao_ftp ()
public function boolean of_move_xml (string as_fornecedor, ref string as_mensagem_log)
public function boolean of_abre_log ()
end prototypes

public function boolean of_busca_xml_fornecedor (string as_fornecedor, ref string as_mensagem_log);String ls_Dir_Ftp, ls_UsuarioFtp, ls_Senha_Ftp
String ls_Mensagem_Erro

If Not DirectoryExists(is_Dir_Xml) Then
	If CreateDirectory(is_Dir_Xml) = -1 Then
		as_Mensagem_Log = "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio " + is_Dir_Xml
		Return False			
	End If
End If

//If Not of_diretorio_leitura_xml() Then Return False

Try
	Open(w_aguarde_1)
	w_Aguarde_1.y = 604
	w_aguarde_1.Title = "Conectando no FTP "+as_Fornecedor+". Aguarde..."
	w_aguarde_1.uo_Progress.of_SetMax(2)
	w_aguarde_1.uo_Progress.of_SetProgress(1)
	
	If This.of_Conecta_ftp(as_Fornecedor, Ref ls_Mensagem_Erro) Then
			
		If Not of_Busca_arquivos(as_fornecedor, Ref ls_Mensagem_Erro) Then
			as_Mensagem_Log = ls_Mensagem_Erro
			Return False	
		End If	
		
	Else	
		as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi possivel conectar ao servidor FTP da distribuidora '" + as_fornecedor + "'."
		Return False
	End If
	
Finally
	ivo_FTP.of_Desconecta_ftp()
	Close(w_aguarde_1)
End Try

If Not of_Move_Xml( as_fornecedor, Ref ls_Mensagem_Erro) Then
	as_Mensagem_Log = ls_Mensagem_Erro
	Return False	
End If

Return True
end function

public function boolean of_insere_nfe_indexacao (t_infnfe at_infnfe, ref string as_mensagem_log);String ls_Id_Nf, ls_Cgc_Origem, ls_Especie, ls_Serie, ls_Cgc_Destino, ls_Situacao
Long ll_Nf
Date ldt_Emissao, dh_Situacao, dh_Entrada

 //ls_Id_Nf				= 	Mid(at_InfNfe.id, 4)
 ls_Id_Nf				= 	at_InfNfe.id
 ls_Cgc_Origem	= 	at_InfNfe.emit.cnpj
 ls_Especie			=	"NFE"
 ls_Serie				=	at_InfNfe.ide.serie
 ls_Cgc_Destino	=	at_InfNfe.dest.cnpj
 ls_Situacao			=	"L"
 ll_Nf					=	at_InfNfe.ide.nnf
 ldt_Emissao		=	at_InfNfe.ide.demi
 dh_Situacao		=	Date(gf_GetServerDate())
 dh_Entrada		=	Date(gf_GetServerDate()) 
		
 Insert Into nfe_indexacao(
 			id_nf,
			cgc_origem,
			nr_nf,
			de_especie,
			de_serie,
			cgc_destino,
			dh_emissao,
			id_situacao,
			dh_situacao,
			dh_entrada)
 Values(	:ls_Id_Nf,
 			:ls_Cgc_Origem,
			:ll_Nf,
			:ls_Especie,
			:ls_Serie,
			:ls_Cgc_Destino,
			:ldt_Emissao,
			:ls_Situacao,
			:dh_Situacao,
			:dh_Entrada)
Using SqlCa;

If SqlCa.SqlCode  = -1 Then
	as_Mensagem_Log = "Erro no insert da tabela 'nfe_indexacao': "+ SqlCa.SQLErrText
	SqlCa.of_Rollback( )
	Return False	
Else
	SqlCa.of_Commit( )
End If	

Return True
end function

public function boolean of_busca_arquivos (string as_fornecedor, ref string as_mensagem_log);Long ll_Linhas, ll_Linha, ll_Contador, ll_Recebido = 0

String ls_Arquivos[]
String ls_Arquivo_Ftp, ls_Arquivo_Local, ls_Mensagem_Erro

ivo_FTP.of_ftp_Lista_Arquivos( is_Prefixo_FTP, Ref ls_Arquivos[])

ll_Linhas = UpperBound(ls_Arquivos[])

Try
	w_Aguarde_1.y = 604
	w_aguarde_1.Title = "Baixando XML..."
	w_aguarde_1.uo_Progress.of_SetMax(ll_Linhas)
	
	of_Abre_Log()
		
	For ll_Linha = 1 To ll_Linhas
	
		ls_Arquivo_Ftp = ls_Arquivos[ll_Linha]
		ls_Arquivo_Local = is_Dir_Xml+ls_Arquivo_Ftp
		
		If ivo_FTP.of_ftp_GetFile(ls_Arquivo_Ftp, ls_Arquivo_Local, ref ls_Mensagem_Erro, "BIN") Then
			ll_Recebido ++
			
			If Not ivo_FTP.of_ftp_deletefile(ls_Arquivo_Ftp, Ref ls_Mensagem_Erro)	Then
				as_Mensagem_Log = ls_Mensagem_Erro
				Return False
			End If	
		Else
			as_Mensagem_Log = ls_Mensagem_Erro
			Return False
		End If
		
		w_aguarde_1.uo_Progress.of_SetProgress(ll_Linha)
		
		ll_Contador++
		
		If ll_Contador = 40 Then
			ll_Contador = 1			
			
			If Not This.of_Conecta_ftp(as_Fornecedor, Ref ls_Mensagem_Erro) Then
				as_Mensagem_Log = ls_Mensagem_Erro
				Return False
			End If
		End If
		
	Next
	
	of_Grava_Log(ii_Log, "Distribuidora: " + as_Fornecedor)
	of_Grava_Log(ii_Log, "Total de Arquivos Dispon$$HEX1$$ed00$$ENDHEX$$veis: " + String(ll_Linhas))
	of_Grava_Log(ii_Log, "Total de Arquivos Recebidos: " + String(ll_Recebido))
Finally
	If Trim(as_Mensagem_Log) <> "" Then
		of_Grava_Log(ii_Log, as_Mensagem_Log)
	End If
	
	FileClose(ii_Log)
End Try

Return True
end function

private function boolean of_descompacta_arquivos (string as_dir_arquivo, string as_destino, ref string as_mensagem_log);String lvs_Error
		

dc_uo_zip lvo_Zip
lvo_Zip = Create dc_uo_zip

lvo_Zip.of_UnZip_Origem(as_Dir_Arquivo)
lvo_Zip.of_UnZip_Destino(as_Destino)
lvs_Error = lvo_Zip.of_UnZip(True)
		
If lvs_Error <> "" Then
	as_Mensagem_Log = lvs_Error
	Return False
End If

Sleep (1)

Return True
end function

public function boolean of_conecta_ftp (string as_fornecedor, ref string as_mensagem_log);String ls_Dir_Ftp, ls_Servidor_Ftp, ls_UsuarioFtp, ls_Senha_Ftp
String ls_Mensagem_Erro, ls_arquivo_nfc, ls_Tipo_Arquivo, ls_porta

select de_diretorio_nfc,
		de_endereco, 
		de_usuario, 
		de_senha,
		de_arquivo_nfc,
		id_tipo_arquivo_nfc,
		nr_porta_ftp
Into 	:ls_Dir_Ftp, 
		:ls_Servidor_Ftp, 
		:ls_UsuarioFtp, 
		:ls_Senha_Ftp,
		:ls_arquivo_nfc,
		:ls_Tipo_Arquivo,
		:ls_porta
from parametro_ftp_distribuidora
where cd_fornecedor = :as_fornecedor
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case -1
		as_Mensagem_Log = "Erro ao selecionar dados do ftp do fornecedor: "+ SqlCa.SQLErrText
		Return False
	Case 100
		as_Mensagem_Log = "Dados do ftp do fornecedor n$$HEX1$$e300$$ENDHEX$$o localizados: "+ SqlCa.SQLErrText
		Return False					
End Choose

//Valida Tipo Arquivo ZIP
If ls_Tipo_Arquivo = 'Z' Then
	ls_Tipo_Arquivo = '.ZIP'
Else
	ls_Tipo_Arquivo = '.XML'
End If

//Valida Prefixo Arquivo FTP
If Trim(ls_arquivo_nfc) <> '' Then
	ls_arquivo_nfc += '*'
Else
	ls_arquivo_nfc = '*'
End If

is_Prefixo_FTP = ls_arquivo_nfc + ls_Tipo_Arquivo

ivo_FTP.of_Desconecta_ftp()

If ivo_FTP.of_Conecta_ftp("RO", ls_Servidor_Ftp, ls_UsuarioFtp, ls_Senha_Ftp,ls_porta,Ref ls_Mensagem_Erro) Then
	
	If Not IsNull(ls_Dir_Ftp) and trim(ls_Dir_Ftp) <> "" Then
		If ivo_FTP.of_ftp_Set_Dir(ls_Dir_Ftp, Ref as_Mensagem_Log ) = -1 Then
			//as_Mensagem_Log = "Erro ao mudar para o diretorio '" + ls_Dir_Ftp + "' FTP."
			Return False
		End If
	End If
	
Else	
	as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi possivel conectar ao servidor FTP  '" + ls_Servidor_Ftp + "' da distribuidora '" + as_fornecedor + "'."
	Return False
End If

Return True
end function

public function boolean of_grava_log (integer ai_arquivo, string as_mensagem);return gf_grava_log_basico(ai_arquivo, as_mensagem)
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

public function boolean of_move_xml (string as_fornecedor, ref string as_mensagem_log);String ls_Mensagem_Erro
Integer li_FileOpen
String ls_Xml, ls_Chave_Nota, ls_Cnpj, ls_Dt_Emissao, ls_Ano, ls_Mes, ls_Dia
Date ldt_Emissao
t_infnfe lt_InfNFe
Long ll_Qtde, ll_Contador
Boolean lb_Existe_Dir
Long ll_Qtde_Itens, ll_I
String ls_Dir_Arquivo, ls_Diretorio_Leitura
String lvs_Lista[]
Long ll_Move
String lvs_Arquivo, ls_Tipo_Arquivo
String ls_Anexo[]

ls_Diretorio_Leitura = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, 'Diretorio', 'XMLLeitura', "")

If Not of_parametro_conexao_ftp() Then Return False

Try
	dc_uo_ftp lo_Ftp
	
	window vlw_temp
	listbox vllb_temp
	
	Open(vlw_temp)
	vlw_temp.openUserObject( vllb_temp )
	
	Select id_tipo_arquivo_nfc
		Into :ls_Tipo_Arquivo
	From parametro_ftp_distribuidora
	Where cd_fornecedor = :as_Fornecedor
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If ls_Tipo_Arquivo = "Z" Then
				
				Try
					vllb_temp.DirList( is_Dir_Xml + "*.zip" , 1 )
								
					ll_Qtde_Itens = vllb_temp.TotalItems()
					
					Open(w_aguarde_1)
					w_Aguarde_1.y = 1604
					w_aguarde_1.Title = "Descompactando arquivos..."
					w_aguarde_1.uo_Progress.of_SetMax(ll_Qtde_Itens)
					
					For ll_I = 1 to ll_Qtde_Itens
						ls_Dir_Arquivo = is_Dir_Xml + vllb_temp.Text( ll_I )	
						
						If Not of_Descompacta_Arquivos(ls_Dir_Arquivo, ls_Diretorio_Leitura, Ref ls_Mensagem_Erro) Then
							as_Mensagem_Log = ls_Mensagem_Erro
							Return False
						End If
						
						FileDelete(ls_Dir_Arquivo)
						w_aguarde_1.uo_Progress.of_SetProgress(ll_I)
					Next
					
				Finally
					Close(w_aguarde_1)
				End Try
			End If
			
		Case 100
			as_Mensagem_Log =  "Dados do ftp do fornecedor n$$HEX1$$e300$$ENDHEX$$o localizados '" + as_Fornecedor + "'" 
			Return False
			
		Case -1
			as_Mensagem_Log = "Erro ao localizar os dados parametro de conex$$HEX1$$e300$$ENDHEX$$o FTP da distribuidora '" + as_Fornecedor + "' :"  + SqlCa.SQLErrText
			Return False			
	End Choose
	
//	//Descompacta os arquivos .zip
//	//STCruz /Dimesul /Florifarma
//	Choose Case as_Fornecedor
//		Case '053400519', '053405356', '053405539','053403312', '053405860' , '053401109', '053400527'
//			
//			Try
//				vllb_temp.DirList( is_Dir_Xml + "*.zip" , 1 )
//							
//				ll_Qtde_Itens = vllb_temp.TotalItems()
//				
//				Open(w_aguarde_1)
//				w_Aguarde_1.y = 1604
//				w_aguarde_1.Title = "Descompactando arquivos..."
//				w_aguarde_1.uo_Progress.of_SetMax(ll_Qtde_Itens)
//				
//				For ll_I = 1 to ll_Qtde_Itens
//					ls_Dir_Arquivo = is_Dir_Xml + vllb_temp.Text( ll_I )	
//					
//					If Not of_Descompacta_Arquivos(ls_Dir_Arquivo, ls_Diretorio_Leitura, Ref ls_Mensagem_Erro) Then
//						Return False
//					End If
//					
//					FileDelete(ls_Dir_Arquivo)
//					w_aguarde_1.uo_Progress.of_SetProgress(ll_I)
//				Next
//			Finally
//				Close(w_aguarde_1)
//			End Try
//				
//	End Choose
	
	ll_Qtde_Itens = 0
	ll_I = 0
	
	If Not DirectoryExists(is_Dir_Xml) Then
		If CreateDirectory(is_Dir_Xml) = -1 Then
			as_Mensagem_Log = "Diret$$HEX1$$f300$$ENDHEX$$rio '" + is_Dir_Xml + "' n$$HEX1$$e300$$ENDHEX$$o existe e n$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel cri$$HEX1$$e100$$ENDHEX$$-lo."
			Return False
		End If
	End If
	
	If gf_dir_list(is_Dir_Xml, "*.XML", 1, lvs_Lista[]) = -1 Then
		as_Mensagem_Log = "Erro ao listar os arquivos do diret$$HEX1$$f300$$ENDHEX$$rio " + ls_Diretorio_Leitura
		Return False
	End If
	
	ll_Qtde_Itens = UpperBound(lvs_Lista[])
	
	If ll_Qtde_Itens > 0 Then
	
		Open(w_aguarde_1)
		w_Aguarde_1.y = 1604
		w_aguarde_1.Title = "Movendo XML para o diret$$HEX1$$f300$$ENDHEX$$rio " + ls_Diretorio_Leitura
		w_aguarde_1.uo_Progress.of_SetMax(ll_Qtde_Itens)		
		
		For ll_I = 1 to ll_Qtde_Itens	
		
			lvs_Arquivo  = Upper(lvs_Lista[ ll_I ] )
			
			w_aguarde_1.Title = "Movendo XML para o diret$$HEX1$$f300$$ENDHEX$$rio " + ls_Diretorio_Leitura + ". " + String(ll_I) + " de " + String(ll_Qtde_Itens) + "..."
			
			//Se o arquivo j$$HEX1$$e100$$ENDHEX$$ existir na pasta de destino exclui o arquivo do diret$$HEX1$$f300$$ENDHEX$$rio atual, sen$$HEX1$$e300$$ENDHEX$$o move para o diret$$HEX1$$f300$$ENDHEX$$rio destino
			
			If Not FileExists(ls_Diretorio_Leitura + lvs_Arquivo) Then
				If FileMove(lvs_Arquivo, ls_Diretorio_Leitura + lvs_Arquivo) < 0 Then
					gf_ge202_Envia_Email_Automatico(90, "", "Erro ao mover o arquivo XML '" + lvs_Arquivo + "' do diret$$HEX1$$f300$$ENDHEX$$rio '" + is_Dir_Xml + "' para '" + ls_Diretorio_Leitura + "'.", ls_Anexo[])
					as_Mensagem_Log = "Erro ao mover o arquivo '" + lvs_Arquivo + "' para o diret$$HEX1$$f300$$ENDHEX$$rio '" + ls_Diretorio_Leitura
					Return False
				End If
			Else
				FileDelete(lvs_Arquivo)
			End If
		Next
	End If
	
Finally
	If IsValid(lo_Ftp) Then Destroy(lo_Ftp)
	vlw_temp.closeUserObject( vllb_temp )
	Close( vlw_temp )	
	Close( w_aguarde_1 )	
End Try

Return True
end function

public function boolean of_abre_log ();String ls_Path

ls_Path = gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")
ls_Path += "download_xml_ftp_distribuidora_" + String(Today(), "ddmm")

If Not gf_Cria_Logs(ls_Path, 4, ref ii_log) Then
	Return False
End If

Return True
end function

on dc_uo_xml_ftp_fornecedor.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_xml_ftp_fornecedor.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor; ivo_ftp 				= Create dc_uo_ftp
// ivo_Ftp_Clamed 	= Create dc_uo_ftp
 ivo_Nfe 				= Create dc_uo_nfe
 
 is_Dir_Xml = gvo_Aplicacao.of_GetFromINI("Diretorio", "XMLCompra") 
end event

event destructor;Destroy(ivo_ftp)
//Destroy(ivo_Ftp_Clamed)
Destroy(ivo_Nfe)
end event

