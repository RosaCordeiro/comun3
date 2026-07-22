HA$PBExportHeader$w_ge064_captura_receita.srw
forward
global type w_ge064_captura_receita from dc_w_response
end type
type bt_fechar from picturebutton within w_ge064_captura_receita
end type
type bt_captura from picturebutton within w_ge064_captura_receita
end type
type st_2 from statictext within w_ge064_captura_receita
end type
type st_1 from statictext within w_ge064_captura_receita
end type
type cb_ws from commandbutton within w_ge064_captura_receita
end type
end forward

global type w_ge064_captura_receita from dc_w_response
integer width = 1349
integer height = 748
string title = "GE064 - Digitaliza$$HEX2$$e700e300$$ENDHEX$$o de Receita"
boolean controlmenu = false
bt_fechar bt_fechar
bt_captura bt_captura
st_2 st_2
st_1 st_1
cb_ws cb_ws
end type
global w_ge064_captura_receita w_ge064_captura_receita

type variables
uo_ge064_epharma	ivo_epharma
//uo_twain				ivo_twain
uo_ge064_webservice_epharma	ivo_epharma_ws
//uo_twain4				ivo_twain4
end variables

forward prototypes
public function boolean wf_verifica_pendentes (string ps_cnpj, string ps_filial)
end prototypes

public function boolean wf_verifica_pendentes (string ps_cnpj, string ps_filial);Boolean 	lb_Sucesso = False, &
			lb_enviou_epharma, &
			lb_enviou_matriz
			
Long 	ll_Arquivo, &
		ll_Tamanho

String	ls_Arquivos[], &
		ls_Arquivo, &
		ls_Dir, &
		ls_Msg, &
		ls_Caminho
		
ls_Dir = "C:\Sistemas\RL\ePharma\Receitas"

gf_dir_list(ls_Dir + "\", '*.zip', 0+1, Ref ls_Arquivos)

If UpperBound( ls_Arquivos ) = 0 Then Return True

dc_uo_ftp lo_Ftp
lo_Ftp = Create dc_uo_ftp

For ll_Arquivo = 1 To UpperBound( ls_Arquivos )
	 ls_Arquivo = ls_Arquivos[ll_Arquivo]
	 ls_Caminho = ls_Dir + "\" + ls_Arquivo
	
	ll_Tamanho = FileLength(ls_arquivo)
		
	/* Se o arquivo for maior ou igual a 300 KB, n$$HEX1$$e300$$ENDHEX$$o envia e grava log.
		A fun$$HEX2$$e700e300$$ENDHEX$$o FileLenght retorna o tamanho do arquivo em bytes, por isso $$HEX1$$e900$$ENDHEX$$ testado ll_Tamanho >= 307200 */
	
	If ll_Tamanho >= 307200 Then
		gvo_Aplicacao.of_Grava_Log("Arquivo $$HEX1$$e900$$ENDHEX$$ maior que 300 KB.")
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo $$HEX1$$e900$$ENDHEX$$ maior que 300 KB, favor entrar em contato com o setor de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)
		Continue
	End If
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Arquivo sendo enviado para o servidor FTP 10.0.4.30"
	
	//FTP para MATRIZ		
	If lo_Ftp.of_Conecta_Ftp( 'PB - ' + ps_Filial, '10.0.4.30', 'pbm', 'pbm', Ref ls_Msg ) Then
		lo_Ftp.of_Ftp_Cria_Dir( ps_Filial, ref ls_Msg ) // Cria+
		
		If lo_Ftp.of_Ftp_Set_Dir( ps_Filial, ref ls_Msg ) >= 0 Then
			
			If lo_Ftp.of_Ftp_PutFile( ls_caminho, ls_arquivo, Ref ls_Msg ) Then
				lb_enviou_matriz = True
			Else
				w_Aguarde.Title = "Erro ao enviar arquivo para o servidor FTP 10.0.4.30"
			End If
		Else
			w_Aguarde.Title = "Erro ao localizar diret$$HEX1$$f300$$ENDHEX$$rio no servidor FTP 10.0.4.30"
		End If
		
		lo_Ftp.of_DesConecta_Ftp()
	Else
		w_Aguarde.Title = "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor FTP 10.0.4.30"
	End If
	
	Close(w_Aguarde)
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Arquivo sendo enviado para o servidor FTP do ePharma."
	
	//FTP para o EPHARMA
	If lo_Ftp.of_Conecta_Ftp( 'PB - ' + ps_CNPJ, 'ftp.epharmatecnologia.com.br', 'imgclamed481', 'eph@0001', Ref ls_Msg ) Then
		If lo_Ftp.of_Ftp_Set_Dir( ps_CNPJ, ref ls_Msg ) >= 0 Then					
			If lo_Ftp.of_Ftp_PutFile( ls_caminho, ls_arquivo, Ref ls_Msg ) Then
				lb_enviou_epharma = True
			Else
				w_Aguarde.Title = "Erro ao enviar arquivo para o servidor FTP do ePharma."
			End If
		Else
			w_Aguarde.Title = "Erro ao localizar diret$$HEX1$$f300$$ENDHEX$$rio no servidor FTP do ePharma."
		End If
		
		lo_Ftp.of_DesConecta_Ftp()
	Else
		w_Aguarde.Title = "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor FTP do ePharma."
	End If
	
	Close(w_Aguarde)
		
	//Verifica se os dois ftp tiveram sucesso para mover o arquivo para enviados.
	If lb_enviou_matriz And lb_enviou_epharma Then
		If FileCopy(ls_caminho, ls_dir + '\Enviadas\' + ls_arquivo, true) = 1 Then
			FileDelete(ls_caminho)
		End If
	End If	
		
Next

Destroy(lo_Ftp)

Return lb_Sucesso
end function

on w_ge064_captura_receita.create
int iCurrent
call super::create
this.bt_fechar=create bt_fechar
this.bt_captura=create bt_captura
this.st_2=create st_2
this.st_1=create st_1
this.cb_ws=create cb_ws
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.bt_fechar
this.Control[iCurrent+2]=this.bt_captura
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_ws
end on

on w_ge064_captura_receita.destroy
call super::destroy
destroy(this.bt_fechar)
destroy(this.bt_captura)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_ws)
end on

event ue_postopen;call super::ue_postopen;//ivo_twain		=	Create uo_twain
//ivo_twain4		=	Create uo_twain4
end event

event close;call super::close;//Destroy(ivo_twain)
//Destroy(ivo_twain4)
end event

event open;call super::open;ivo_epharma    = Create uo_ge064_epharma

ivo_epharma 	= Message.PowerObjectParm
//io_venda.retorno = ''

pb_Help.Visible = True

#IF DEFINED DEBUG THEN
      cb_ws.visible = true
#END IF

end event

event closequery;call super::closequery;IF KeyDown(KeyAlt!) and KeyDown(KeyF4!) Then Return 1
end event

type pb_help from dc_w_response`pb_help within w_ge064_captura_receita
integer x = 14
integer y = 472
end type

event pb_help::clicked;call super::clicked;wf_Help( "ePharma, Digitaliza$$HEX2$$e700e300$$ENDHEX$$o de Receitas" )
end event

type bt_fechar from picturebutton within w_ge064_captura_receita
integer x = 759
integer y = 396
integer width = 453
integer height = 176
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Fechar"
boolean originalsize = true
vtextalign vtextalign = vcenter!
long textcolor = 30015488
long backcolor = 67108864
end type

event clicked;If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sair SEM capturar as imagens?", Question!, YesNo!, 2) = 1 Then
	ivo_epharma.retorno = 'CANCELAR'
	CloseWithReturn(Parent,ivo_epharma)
Else
	bt_captura.SetFocus()
End If
end event

type bt_captura from picturebutton within w_ge064_captura_receita
integer x = 187
integer y = 396
integer width = 453
integer height = 176
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Digitalizar Imagem"
boolean originalsize = true
vtextalign vtextalign = multiline!
long textcolor = 30015488
long backcolor = 67108864
end type

event clicked;Try
	Long	ll_handle, &
			ll_Tamanho
	
	String ls_dir, &
			ls_erro, &
			ls_arquivo, &
			ls_caminho, &
			ls_filial, &
			ls_CNPJ, &
			ls_msg,&
			ls_retorno
			
	Boolean 	lb_enviou_epharma, &
				lb_enviou_matriz		

	
uo_ge393_twain4 lo_twain
lo_twain = Create uo_ge393_twain4

If lo_twain.of_verifica_driver() Then
	lo_twain.of_inicializa()
	
	lo_twain.is_Tipo = 'EPHARMA'
	lo_twain.is_Autorizacao = ivo_epharma.nr_autorizacao
	lo_twain.idh_emissao = gf_getserverdate()
//	lo_twain.idh_movimento = Date(ivdh_Data_Caixa)
	lo_twain.is_caminho = 'C:\e-PharmaPlugin\ScannerImagens'

	w_ge393_digitalizacao lwo_digitalizar

	OpenWithParm(lwo_digitalizar,lo_twain, dc_w_mdi)
	
	ls_retorno = Message.stringparm
	
	If Trim(ls_retorno) <> '' And Not IsNull(ls_retorno) Then
		ivo_epharma.retorno 						= Trim(gf_captura_valor(ls_retorno, '|', 1, false))
		ivo_epharma.ivs_arquivo_digitalizado	= Trim(gf_captura_valor(ls_retorno, '|', 2, false))
	Else
		ivo_epharma.retorno = 'CANCELAR'
	End If	

	Destroy(lwo_digitalizar)
	Destroy(lo_twain)	
	
	CloseWithReturn(Parent,ivo_epharma)	
Else
	Destroy(lo_twain)
	Return -1
End If		
	
/*  ****************** PROCESSO ANTIGO  ***************	
	ls_Filial = String( gvo_Parametro.Cd_Filial, "0000" )
	ls_CNPJ = gvo_Parametro.nr_cgc
	
	//Verifica receitas pendentes de envio e envia.
	wf_verifica_pendentes(ls_CNPJ, ls_Filial)
	
	ll_handle = Handle(w_ge064_captura_receita)
	
//	If ivo_twain4.of_captura_funcional(ll_handle)	Then
//		ivo_epharma.retorno = 'OK'		
//		CloseWithReturn(Parent,ivo_epharma)
//	End If	
	
	If ivo_twain.of_captura_epharma(ll_handle, ivo_epharma.dh_emissao, ivo_epharma.nr_autorizacao, ls_dir, ls_arquivo) Then
		ls_caminho = ls_dir + ls_arquivo
	
		ls_caminho = ls_caminho + '.zip'		
		ls_arquivo = ls_arquivo + '.zip'
		
		ll_Tamanho = FileLength(ls_arquivo)
		
		/* Se o arquivo for maior ou igual a 300 KB, n$$HEX1$$e300$$ENDHEX$$o envia e grava log.
			A fun$$HEX2$$e700e300$$ENDHEX$$o FileLenght retorna o tamanho do arquivo em bytes, por isso $$HEX1$$e900$$ENDHEX$$ testado ll_Tamanho >= 307200 */
	
		If ll_Tamanho >= 307200 Then
			gvo_Aplicacao.of_Grava_Log("Arquivo $$HEX1$$e900$$ENDHEX$$ maior que 300 KB.")
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo $$HEX1$$e900$$ENDHEX$$ maior que 300 KB, favor entrar em contato com o setor de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)
		End If
		
		dc_uo_ftp lo_Ftp
		lo_Ftp = Create dc_uo_ftp
		
		lo_Ftp.of_DesConecta_Ftp()
		
		Open(w_Aguarde)
		w_Aguarde.Title = "Arquivo sendo enviado para o servidor FTP 10.0.0.4"
		
		//FTP para MATRIZ				
		If lo_Ftp.of_Conecta_Ftp( 'PB - ' + ls_Filial, '10.0.0.4', 'pbm', 'pbm', Ref ls_Msg ) Then
			lo_Ftp.of_Ftp_Cria_Dir( ls_Filial, ref ls_Msg ) // Cria+
			
			If lo_Ftp.of_Ftp_Set_Dir( ls_Filial, ref ls_Msg ) >= 0 Then
				
				If lo_Ftp.of_Ftp_PutFile( ls_caminho, ls_arquivo, Ref ls_Msg ) Then
					lb_enviou_matriz = True
				Else
					w_Aguarde.Title = "Erro ao enviar arquivo para o servidor FTP 10.0.0.4"
				End If
			Else
				w_Aguarde.Title = "Erro ao localizar diret$$HEX1$$f300$$ENDHEX$$rio no servidor FTP 10.0.0.4"
			End If
			
			lo_Ftp.of_DesConecta_Ftp()
		Else
			w_Aguarde.Title = "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor FTP 10.0.0.4"
		End If		
		
		Close(w_Aguarde)
		
		Open(w_Aguarde)
		w_Aguarde.Title = "Arquivo sendo enviado para o servidor FTP do ePharma."
		
		//FTP para o EPHARMA
		If lo_Ftp.of_Conecta_Ftp( 'PB - ' + ls_CNPJ, 'ftp.epharmatecnologia.com.br', 'imgclamed481', 'eph@0001', Ref ls_Msg ) Then
			If lo_Ftp.of_Ftp_Set_Dir( ls_CNPJ, ref ls_Msg ) >= 0 Then					
				If lo_Ftp.of_Ftp_PutFile( ls_caminho, ls_arquivo, Ref ls_Msg ) Then
					lb_enviou_epharma = True
				Else
					w_Aguarde.Title = "Erro ao enviar arquivo para o servidor FTP do ePharma."
				End If
			Else
				w_Aguarde.Title = "Erro ao localizar diret$$HEX1$$f300$$ENDHEX$$rio no servidor FTP do ePharma."
			End If
			
			lo_Ftp.of_DesConecta_Ftp()
		Else
			w_Aguarde.Title = "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor FTP ePharma."
		End If
		
		Close(w_Aguarde)
		
		//Verifica se os dois ftp tiveram sucesso para mover o arquivo para enviados.
		If lb_enviou_matriz And lb_enviou_epharma Then
			If FileCopy(ls_caminho, ls_dir + '\Enviadas\' + ls_arquivo, true) = 1 Then
				FileDelete(ls_caminho)
			End If
		End If
		
		Destroy(lo_Ftp)
		
		ivo_epharma.retorno = 'OK'
		
		CloseWithReturn(Parent,ivo_epharma)
	End If
*/	
Catch ( runtimeerror  lo_rte )
	MessageBox (	"Erro", "Problemas na Digitaliza$$HEX2$$e700e300$$ENDHEX$$o. ~r~r"+ & 						
 						lo_rte.GetMessage( ), StopSign!)
	
Finally	
	SetPointer(Arrow!)
End Try
end event

type st_2 from statictext within w_ge064_captura_receita
integer x = 32
integer y = 188
integer width = 1280
integer height = 164
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "Posicione os documentos no Scanner e clique no bot$$HEX1$$e300$$ENDHEX$$o Digitalizar Imagem:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_ge064_captura_receita
integer x = 32
integer y = 40
integer width = 1285
integer height = 148
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "Conv$$HEX1$$ea00$$ENDHEX$$nio obriga a digitaliza$$HEX2$$e700e300$$ENDHEX$$o de receita e documentos do paciente."
boolean focusrectangle = false
end type

type cb_ws from commandbutton within w_ge064_captura_receita
boolean visible = false
integer x = 549
integer y = 568
integer width = 393
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "WSePharma"
end type

event clicked;String ls_teste
ivo_epharma_ws    = Create uo_ge064_webservice_epharma
ivo_epharma_ws.of_enviar('', ref ls_teste)
end event

