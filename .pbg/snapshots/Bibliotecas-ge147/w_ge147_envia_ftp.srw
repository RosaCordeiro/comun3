HA$PBExportHeader$w_ge147_envia_ftp.srw
forward
global type w_ge147_envia_ftp from dc_w_response_ok_cancela
end type
end forward

global type w_ge147_envia_ftp from dc_w_response_ok_cancela
integer width = 1426
integer height = 1140
string title = "GE147 - Transmiss$$HEX1$$e300$$ENDHEX$$o via FTP"
end type
global w_ge147_envia_ftp w_ge147_envia_ftp

type variables
st_parametros_conexao str
String  is_protocolo_sftp
String is_Arquivo
String is_Tipo = "FTP"
end variables

forward prototypes
public subroutine wf_lista_arquivos ()
public function boolean wf_envia_ftp (string ps_path, string ps_arquivo_ftp)
public function boolean wf_envia_pedido_open_text ()
public function boolean wf_envia_pedido_open_text_sftp ()
end prototypes

public subroutine wf_lista_arquivos ();String lvs_Arquivo
String lvs_Lista[]

Long lvl_Total
Long lvl_Row
Long lvl_Linha

SetPointer(HourGlass!)
dw_1.SetReDraw(False)
dw_1.Reset()

lvl_Total = gf_dir_list(str.de_diretorio_local, "", 1, Ref lvs_Lista[])

If lvl_Total > 0 Then
	
	lvl_Total = UpperBound(lvs_Lista[])
	
	For lvl_Row = 1 To lvl_Total
		lvl_Linha = dw_1.InsertRow(0)
		
		lvs_Arquivo = Upper(lvs_Lista[ lvl_Row ] )
		
		dw_1.Object.Nm_Arquivo [ lvl_Linha ] = lvs_Arquivo
	Next
	
ElseIf lvl_Total < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos arquivos.", StopSign!)
End If

dw_1.SetReDraw(True)	
SetPointer(Arrow!)

If dw_1.RowCount() > 0 Then
	cb_OK.Enabled = True
Else
	cb_OK.Enabled = False
End If
end subroutine

public function boolean wf_envia_ftp (string ps_path, string ps_arquivo_ftp);Boolean lvb_Sucesso = True

String lvs_Msg

Open( w_Aguarde )

w_Aguarde.Title = "Enviando arquivo, aguarde..."

dc_uo_ftp lvo_ftp
lvo_ftp = create dc_uo_ftp

//If Not lvo_Ftp.of_Conecta_Ftp('RO', str.de_endereco, str.de_usuario, str.de_senha, Ref lvs_Msg, str.de_usuario_proxy, str.de_senha_proxy) Then	
If Not lvo_Ftp.of_Conecta_Ftp('RO', str.de_endereco, str.de_usuario, str.de_senha, Ref lvs_Msg) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor '" + str.de_endereco + "'. Tente novamente em alguns minutos.~r" + &
								 "        Se o problema persistir, entre em contato com o setor de inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)
	lvb_Sucesso = False
End If

If Not IsNull(str.de_diretorio_ftp) and Trim(str.de_diretorio_ftp) <> '' Then
	If lvo_ftp.of_ftp_Set_Dir(str.de_diretorio_ftp) = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao mudar para o diretorio '" + str.de_diretorio_ftp + "' FTP.")
		lvb_Sucesso = False
	End If
End If

If lvb_Sucesso Then
	If posA(upper(str.de_endereco),'INTERPLAYERS') > 0 Then
		If Not lvo_ftp.of_ftp_PutFile(ps_path, ps_arquivo_ftp, Ref lvs_Msg, True ) Then
			gvo_Aplicacao.of_Grava_Log("PEDIDO EDI *** " + lvs_Msg +  " - Arquivo: " + ps_path)
			lvb_Sucesso = False
		End If
	Else
		If Not lvo_ftp.of_ftp_PutFile(ps_path, ps_arquivo_ftp, Ref lvs_Msg, False ) Then
			gvo_Aplicacao.of_Grava_Log("PEDIDO EDI *** " + lvs_Msg +  " - Arquivo: " + ps_path)
			lvb_Sucesso = False
		End If
	End If
End If

Destroy(lvo_ftp)
Close( w_Aguarde )
Return lvb_Sucesso
end function

public function boolean wf_envia_pedido_open_text ();Integer li_Retorno

String ls_Dir_Arquivos

ls_Dir_Arquivos = gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")

//If Not FileExists("C:\Sistemas\Co\Arquivos\ftpgxs.bat") Then
If Not FileExists(ls_Dir_Arquivos + "ftpgxs.bat") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo 'ftpgxs.bat' n$$HEX1$$e300$$ENDHEX$$o localizado na pasta '" + ls_Dir_Arquivos + "'.", StopSign!)
	Return False
End If

//If Not FileExists("C:\Sistemas\Co\Arquivos\gxs_connection.txt") Then
If Not FileExists(ls_Dir_Arquivos + "gxs_connection.txt") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo 'gxs_connection.txt' n$$HEX1$$e300$$ENDHEX$$o localizado na pasta '" + ls_Dir_Arquivos + "'.")
	Return False
End If

//li_Retorno = Run("C:\Sistemas\Co\Arquivos\ftpgxs.bat", Maximized!)
li_Retorno = Run(ls_Dir_Arquivos + "ftpgxs.bat", Maximized!)

If li_Retorno = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no envio do arquivo.", StopSign!)
	Return False
End If

//Arquivos que devem ser utilizados para o envio de arquivo para a Bayer/OpenText

//ftpgxs.bat
//cd C:\OpenText
//FTP.EXE -s:C:\Sistemas\Co\Arquivos\gxs_connection.txt pftp-gate.ms.gxs.com
//copy ORD*.* C:\opentext\bkp
//del ORD*.*

//gxs_connection.txt
//CLAMED
//piU4jO3{
//user CLAMED@pftp.ms.gxs.com
//PASSWORD
//cd /CLAMED/BAYERBHC/BAYSAPEDIPFF
//prompt
//mput ORD*.*
//bye

Return True
end function

public function boolean wf_envia_pedido_open_text_sftp ();Integer li_Retorno

String ls_Dir_Arquivos

ls_Dir_Arquivos = gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")
// Arquivo parametros $$HEX1$$e900$$ENDHEX$$ chamado dentro do sftpgxs.bat

If Not FileExists(ls_Dir_Arquivos + "sftpgxs.bat") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo 'ftpgxs.bat' n$$HEX1$$e300$$ENDHEX$$o localizado na pasta '" + ls_Dir_Arquivos + "'.", StopSign!)
	Return False
End If

li_Retorno = Run(ls_Dir_Arquivos + "sftpgxs.bat", Maximized!)

If li_Retorno = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no envio do arquivo.", StopSign!)
	Return False
End If


Return True
end function

on w_ge147_envia_ftp.create
call super::create
end on

on w_ge147_envia_ftp.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;str = Message.PowerObjectParm

wf_lista_arquivos()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge147_envia_ftp
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge147_envia_ftp
integer width = 1367
integer height = 912
string text = "Lista de Arquivos"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge147_envia_ftp
integer y = 64
integer width = 1307
integer height = 828
string dataobject = "dw_ge147_lista_arquivos"
boolean vscrollbar = true
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge147_envia_ftp
integer x = 741
integer y = 940
integer weight = 700
string text = "&Enviar"
end type

event cb_ok::clicked;call super::clicked;Boolean lb_Sucesso = True

Long ll_Row
Long ll_Find

String ls_Arquivo
String ls_Selecionado

dw_1.AcceptText()

ll_Find = dw_1.Find("id_atualiza = 'S'", 1, dw_1.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find.", StopSign!)
	Return -1
ElseIf ll_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione ao menos um pedido para ser enviado.", Exclamation!)
	Return -1
End If

If Not DirectoryExists( str.de_diretorio_local_backup ) Then
	If CreateDirectory( str.de_diretorio_local_backup ) = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio '" + str.de_diretorio_local_backup + "'.", StopSign!)
		Return -1
	End If
End If

Try
	
	dc_uo_api lo_api
	lo_api = Create dc_uo_api
	
	For ll_Row = 1 To dw_1.RowCount()
			
		ls_Arquivo		= dw_1.Object.Nm_Arquivo	[ll_Row]
		ls_Selecionado	= dw_1.Object.Id_Atualiza	[ll_Row]
				
		If ls_Selecionado = "N" Then
			Continue
		End If

		If str.de_van = "OPENTEXT" Then
			If str.usa_sftp = "1" Then
				is_Tipo = "SFTP"
				If Not wf_envia_pedido_open_text_sftp() Then 
					lb_Sucesso = False
					Exit					
				End If 						
			Else	
				If Not wf_Envia_Pedido_Open_Text() Then
					lb_Sucesso = False
					Exit
				End If
			End If 
		Else			
			If Not wf_envia_ftp( str.de_diretorio_local + ls_Arquivo, ls_Arquivo ) Then
				lb_Sucesso = False
				Exit
			End If
		End If

		If str.usa_sftp <> "1" Then    // Para SFTP j$$HEX1$$e100$$ENDHEX$$ faz o Move dentro do .bat
			lo_Api.of_Move_File(str.de_diretorio_local + ls_Arquivo, str.de_diretorio_local_backup + "\" + ls_Arquivo , False )				
		End If 	
		
		gvo_Aplicacao.of_Grava_Log("PEDIDO EDI *** Arquivo " + str.de_diretorio_local + ls_Arquivo + " foi enviado via : "+is_Tipo + " com sucesso.")
	Next
	
	If lb_Sucesso  Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "T$$HEX1$$e900$$ENDHEX$$rmino do envio dos arquivos.~r~r" +&
						"D$$HEX1$$fa00$$ENDHEX$$vidas consulte o Log em: " + gvo_Aplicacao.ivs_Arquivo_LOG)
										
		CloseWithReturn(Parent, str)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro no envio do arquivo.", StopSign!)
	End If
	
Finally
	Destroy(lo_api)
End Try
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge147_envia_ftp
integer x = 1079
integer y = 940
end type

