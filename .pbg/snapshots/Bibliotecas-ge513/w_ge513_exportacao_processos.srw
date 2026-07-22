HA$PBExportHeader$w_ge513_exportacao_processos.srw
forward
global type w_ge513_exportacao_processos from dc_w_response_ok_cancela
end type
type plb from picturelistbox within w_ge513_exportacao_processos
end type
end forward

global type w_ge513_exportacao_processos from dc_w_response_ok_cancela
integer width = 1755
integer height = 1552
string title = "GE513 - Exporta$$HEX2$$e700f500$$ENDHEX$$es Processos"
plb plb
end type
global w_ge513_exportacao_processos w_ge513_exportacao_processos

type variables
dc_uo_ftp 										ivo_FTP  					// GE040
dc_uo_api 										ivo_API 					// GE040
uo_parametro_geral							ivo_parametro 			// GE014
uo_ro098_importa_comum					ivo_comum				// RO098
uo_ge513_exporta_arquivos_farmacia 	ivo_exporta_farmacia // GE513

String	ivs_Path_Importacao, &
		ivs_Path_Backup = "Backup"
end variables

forward prototypes
public function boolean wf_baixa_arquivos_ftp (string ps_processo, long pl_convenio, string ps_path, ref string ps_log)
public function boolean wf_executa_processos (string ps_processo, long pl_convenio, string ps_path, ref string ps_log)
public function boolean wf_baixa_arquivos_skyline (string ps_processo, string ps_path, ref string ps_log)
end prototypes

public function boolean wf_baixa_arquivos_ftp (string ps_processo, long pl_convenio, string ps_path, ref string ps_log);Boolean lvb_Sucesso = True

String lvs_Endereco, &
		lvs_Usuario, &
		lvs_Senha, &
		lvs_Arquivos[], &
		lvs_Arquivo_FTP, &
		lvs_Arquivo_Local, &
		lvs_Arquivo_Novo, &
		lvs_Path_Backup
		
Long	lvl_Linhas, &
		lvl_Linha, &
		lvl_Recebido
		
Integer	lvi_Total

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("ds_ge513_config_ftp_convenio") Then
	Destroy(lvds_1)
	Return False
End If

lvi_Total	= lvds_1.Retrieve(pl_Convenio)

If lvi_Total > 0 Then
	
	lvs_Endereco 		= lvds_1.Object.De_Endereco_FTP[1]
	lvs_Usuario			= lvds_1.Object.De_Usuario_FTP[1]
	lvs_Senha			= lvds_1.Object.De_Senha_FTP[1]
	lvs_Path_Backup 	= ivs_Path_Backup
	
	If ivo_FTP.of_Conecta_ftp("RO", lvs_Endereco, lvs_Usuario, lvs_Senha, Ref ps_Log) Then
		
		If ps_Path <> "" Then
			lvs_Path_Backup = ps_Path + "\" + ivs_Path_Backup
			
			If ivo_FTP.of_Ftp_Set_Dir(ps_path, ref ps_Log)  = -1 Then
				ps_Log += "Erro ao setar o diret$$HEX1$$f300$$ENDHEX$$rio: " + ps_Path + " no FTP."
				Return False
			End If
		End If			
		
		ivo_FTP.of_ftp_Lista_Arquivos("*.*", Ref lvs_Arquivos[])
		
		lvl_Linhas = UpperBound(lvs_Arquivos[])
		
		Open(w_Aguarde)	
		w_Aguarde.Title = "Verificando Arquivos na $$HEX1$$e100$$ENDHEX$$rea de FTP..."	
		w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)		
		SetPointer(HourGlass!)
		
		For lvl_Linha = 1 To lvl_Linhas
			
			lvs_Arquivo_FTP = lvs_Arquivos[lvl_Linha]
			
			w_Aguarde.Title = "Baixando Arquivo:[" + lvs_Arquivo_FTP + "]"
			w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
			w_Aguarde.Show()
			Yield()
			
			lvs_Arquivo_Local 	= ivs_Path_Importacao + "\" + lvs_Arquivo_FTP
			lvs_Arquivo_Novo	= ivs_Path_Importacao + "\" + ps_Processo + "_" + lvs_Arquivo_FTP
			
			If pl_Convenio = 52575 Then
				If MidA(lvs_Arquivo_FTP, 1, 2) = "MV" Then
					lvs_Arquivo_Novo	= ivs_Path_Importacao + "\" + ps_Processo + "_1" + lvs_Arquivo_FTP
				ElseIf MidA(lvs_Arquivo_FTP, 1, 2) = "DV" Then
					lvs_Arquivo_Novo	= ivs_Path_Importacao + "\" + ps_Processo + "_2" + lvs_Arquivo_FTP
				Else
					lvs_Arquivo_Novo	= ivs_Path_Importacao + "\" + ps_Processo + "_" + lvs_Arquivo_FTP
				End If
			End If
			
			If ivo_FTP.of_ftp_GetFile(lvs_Arquivo_FTP, lvs_Arquivo_Local, ref ps_Log, "BIN") Then
					
				lvl_Recebido ++
			
				// Verifica se realmente copiou o arquivo para $$HEX1$$e100$$ENDHEX$$rea local
				If FileExists(lvs_Arquivo_Local) Then
					If ivo_FTP.of_ftp_DeleteFile(lvs_Arquivo_FTP, ref ps_Log) Then
						If Not ivo_FTP.of_Ftp_Set_Dir(ivs_Path_Backup, ref ps_Log) = -1 Then
							If ivo_FTP.of_Ftp_PutFile(lvs_Arquivo_Local, lvs_Arquivo_FTP) Then				
								If FileLength(lvs_Arquivo_Local) > 0 Then
									If ivo_Api.of_Rename_File(lvs_Arquivo_Local, lvs_Arquivo_Novo) Then
										If Not ivo_FTP.of_Ftp_Set_Dir("..", ref ps_Log) = -1 Then
											lvb_Sucesso = True
										Else
											ps_Log += "Erro ao voltar para pasta origem no servidor FTP.~r"
											Exit
										End If
									Else
										ps_Log += "Erro ao renomear o arquivo:[" + lvs_Arquivo_Local + "] para:[" +  lvs_Arquivo_Novo
										Exit
									End If
								End If
							Else
								ps_Log += "Erro ao copiar o arquivo do diret$$HEX1$$f300$$ENDHEX$$rio copiado para o diret$$HEX1$$f300$$ENDHEX$$rio de backup do FTP..." 
								Exit
							End If
						Else
							ps_Log += "Erro ao setar o diret$$HEX1$$f300$$ENDHEX$$rio de backup do FTP..."
							Exit
						End If						
					Else
						ps_Log += "Erro ao excluir o arquivo do diret$$HEX1$$f300$$ENDHEX$$rio raiz do FTP..."
						Exit
					End If
				Else
					ps_Log += "Erro ao verificar se arquivo foi copiado..."
					Exit
				End If 
			Else
				ps_Log += "Erro ao baixar o arquivo do FTP..."
				Exit
			End If
		Next
		
		Close(w_Aguarde)	
		ivo_FTP.of_Desconecta_ftp()
	Else			
		ps_Log += "N$$HEX1$$e300$$ENDHEX$$o foi possivel conectar ao servidor FTP :'" 		
	End If	
End If	

Destroy(lvds_1)

If ps_Log <> "" Then Return False

Return lvb_Sucesso
end function

public function boolean wf_executa_processos (string ps_processo, long pl_convenio, string ps_path, ref string ps_log);Boolean 	lvb_Sucesso = False

Choose Case ps_Processo
//	Case "001", "002", "003", "004"
//		If Wf_Baixa_Arquivos_FTP(ps_Processo, pl_Convenio, ps_path, ref ps_Log) Then
//			lvb_Sucesso = True
//		End If
//		
//	Case "010"
//		If Wf_Baixa_Arquivos_Skyline(ps_Processo, ps_Path, ref ps_Log) Then
//			lvb_Sucesso = True
//		End If
		
	Case "011", "012", "013", "014", "015", "016", "017", "018", "019", "020", "021"
		If ivo_Exporta_Farmacia.of_Gera_Arquivos(ps_Processo, ref ps_Log) Then
			lvb_Sucesso = True
		End If	
End Choose
	
Return lvb_Sucesso
end function

public function boolean wf_baixa_arquivos_skyline (string ps_processo, string ps_path, ref string ps_log);Boolean lvb_Sucesso = True

Long lvl_Num_Process

String	lvs_DirList, &
		lvs_Arquivo, &
		lvs_Arquivo_Local, &
		lvs_Arquivo_Novo, &
		lvs_Path_Skyline, &
		lvs_Path_Antigo, &
		lvs_Path_Novo

Integer	lvi_Total, &
			lvi_Contador

// Executa o skyline
gf_Run("c:\skyline\skyline.exe", 2, True)

lvl_Num_Process = gf_process_is_running("skyline.exe*32")

Do While lvl_Num_Process > 0 
	
	lvl_Num_Process = gf_process_is_running("skyline.exe*32")
	
Loop

lvs_Path_Skyline 	= "c:\skyline\inbox\"
lvs_DirList 			= "c:\skyline\inbox\*.*"

If plb.DirList(lvs_DirList, 0) Then
	lvi_Total = plb.TotalItems()

	For lvi_Contador = 1 To lvi_Total
		plb.SelectItem(lvi_Contador)
	
		lvs_Arquivo 			= Trim(plb.SelectedItem())
		lvs_Path_Antigo	= lvs_Path_Skyline + lvs_Arquivo
		lvs_Path_Novo		= ivs_Path_Importacao + "\" + lvs_Arquivo
		lvs_Arquivo_Local 	= ivs_Path_Importacao + "\" + lvs_Arquivo
		lvs_Arquivo_Novo	= ivs_Path_Importacao + "\" + ps_Processo + "_" + lvs_Arquivo
		
		If lvs_Arquivo <> "" Then
			If ivo_Api.of_Move_File(lvs_Path_Antigo, lvs_Path_Novo) Then
				If ivo_Api.of_Rename_File(lvs_Arquivo_Local, lvs_Arquivo_Novo) Then
					lvb_Sucesso = True
				End If
			End If
		End If
	Next
End If

If ps_Log <> "" Then Return False

Return lvb_Sucesso
end function

on w_ge513_exportacao_processos.create
int iCurrent
call super::create
this.plb=create plb
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.plb
end on

on w_ge513_exportacao_processos.destroy
call super::destroy
destroy(this.plb)
end on

event close;call super::close;Destroy(ivo_FTP)
Destroy(ivo_API)
Destroy(ivo_Parametro)
Destroy(ivo_Comum)
Destroy(ivo_Exporta_Farmacia)
end event

event ue_postopen;call super::ue_postopen;// Cria$$HEX2$$e700e300$$ENDHEX$$o dos objetos
ivo_FTP 						= Create dc_uo_FTP
ivo_API 						= Create dc_uo_API
ivo_Parametro 				= Create uo_Parametro_Geral
ivo_Comum					= Create uo_RO098_Importa_Comum
ivo_Exporta_Farmacia 	= Create uo_ge513_exporta_arquivos_farmacia

// Path Importa$$HEX2$$e700e300$$ENDHEX$$o RO
If Not ivo_Parametro.of_Localiza_Parametro("DE_PATH_IMPORTACOES_RO", ref ivs_Path_Importacao) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Path para importa$$HEX2$$e700e300$$ENDHEX$$o dos arquivos n$$HEX1$$e300$$ENDHEX$$o parametrizado.", StopSign!)
	Halt Close
End If

ivs_Path_Importacao = ivs_Path_Importacao + "\Temp"

dw_1.retrieve()

// Verifica se o processo $$HEX1$$e900$$ENDHEX$$ autom$$HEX1$$e100$$ENDHEX$$tico
If gvb_Exp_Auto Then
	cb_ok.Event Clicked()
	Halt Close
End If
end event

event open;call super::open;plb.Visible	= False
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge513_exportacao_processos
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge513_exportacao_processos
integer width = 1682
integer height = 1308
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge513_exportacao_processos
integer x = 46
integer y = 56
integer width = 1637
integer height = 1208
string dataobject = "dw_ge513_selecao"
boolean vscrollbar = true
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge513_exportacao_processos
integer x = 1056
integer y = 1336
integer width = 325
string text = "&Exportar"
end type

event cb_ok::clicked;call super::clicked;Boolean	lvb_Sucesso = False, &
			lvb_Ok = False

Long	lvl_Log
Long ll_for, ll_linhas

Integer	lvi_Total

String	lvs_Path_Backup, &
			lvs_Log, &
			lvs_Processo, &
			lvs_Mensagem, &
			lvs_Log_processo

SetPointer(HourGlass!) 	
dw_1.AcceptText()

lvl_Log = FileLength(gvo_Aplicacao.ivs_Arquivo_LOG)

lvs_Log = ""

If Not gvb_Exp_Auto Then
	if dw_1.find('id_check = "S"',1, dw_1.rowcount( ) ) = 0 Then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Selecione ao menos um processo para realizar a exporta$$HEX2$$e700e300$$ENDHEX$$o.')
		return -1
	end if
end if

ll_linhas = dw_1.rowcount( ) 

for ll_for = 1 to ll_linhas

	if dw_1.object.id_check[ll_for] = 'N' then continue
	
	lvs_Log_processo = ''
	
	lvs_Processo = dw_1.object.cd_exportacao[ll_for]
	
	If Wf_Executa_Processos(lvs_Processo, 0, "", ref lvs_Log_processo) Then
		lvb_Sucesso = True
	End If

	If lvs_Log_processo <> "" Then
		lvs_Log += 'Processo ' + lvs_Processo + ': <br><br>' + lvs_Log_processo
	End If	

Next

SqlCa.of_commit( );
Yield()

lvs_Mensagem =	'Caro(a) usu$$HEX1$$e100$$ENDHEX$$rio(a),<br><br>'		+ &
						'Houveram problemas durante a exporta$$HEX2$$e700e300$$ENDHEX$$o de alguns arquivos. <br>'+ &
						'Veja abaixo o log: <br><br>'		+ &
						lvs_Log		+ &
						'</ul></ul>';	

If Not gvb_Exp_Auto Then
	If FileLength(gvo_Aplicacao.ivs_Arquivo_LOG) > lvl_Log or lvs_Log <> "" Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Alguns procedimentos n$$HEX1$$e300$$ENDHEX$$o puderam ser realizados, verifique o log no e-mail que ser$$HEX1$$e100$$ENDHEX$$ enviado ' + &
									  'para os usu$$HEX1$$e100$$ENDHEX$$rios do processo: ' + String(57), Exclamation!,Ok!)

		If lvs_Log <> "" Then
			gf_ge202_envia_email_automatico(57, '', lvs_Mensagem, {''})
		End If
	Else
		If lvb_Sucesso Then
			MessageBox('Sucesso!','Os procedimentos foram executados sem erros! ',Information!,Ok!)
		End If
	End If
Else	
	gf_atualiza_data_execucao_tarefa(9, True)
	
	If lvs_Log <> "" Then
		gf_ge202_envia_email_automatico(57, '', lvs_Mensagem)
	End If
End If

SetPointer(Arrow!)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge513_exportacao_processos
integer x = 1394
integer y = 1336
string text = "&Fechar"
end type

type plb from picturelistbox within w_ge513_exportacao_processos
integer x = 800
integer y = 360
integer width = 535
integer height = 276
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
long picturemaskcolor = 536870912
end type

