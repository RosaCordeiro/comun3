HA$PBExportHeader$w_ge393_digitalizacao.srw
forward
global type w_ge393_digitalizacao from dc_w_response_ok_cancela
end type
type cb_pre from commandbutton within w_ge393_digitalizacao
end type
type ole_visualizar from olecustomcontrol within w_ge393_digitalizacao
end type
type r_visual from rectangle within w_ge393_digitalizacao
end type
type oleobject_1 from oleobject within w_ge393_digitalizacao
end type
end forward

global type w_ge393_digitalizacao from dc_w_response_ok_cancela
integer width = 3602
integer height = 1808
string title = "GE393 - Digitaliza$$HEX2$$e700e300$$ENDHEX$$o"
cb_pre cb_pre
ole_visualizar ole_visualizar
r_visual r_visual
oleobject_1 oleobject_1
end type
global w_ge393_digitalizacao w_ge393_digitalizacao

type prototypes

end prototypes

type variables
uo_ge393_twain4				ivo_twain4
String is_arquivo
end variables

on w_ge393_digitalizacao.create
int iCurrent
call super::create
this.cb_pre=create cb_pre
this.ole_visualizar=create ole_visualizar
this.r_visual=create r_visual
this.oleobject_1=create oleobject_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_pre
this.Control[iCurrent+2]=this.ole_visualizar
this.Control[iCurrent+3]=this.r_visual
end on

on w_ge393_digitalizacao.destroy
call super::destroy
destroy(this.cb_pre)
destroy(this.ole_visualizar)
destroy(this.r_visual)
destroy(this.oleobject_1)
end on

event close;call super::close;Destroy(ivo_twain4)
Destroy(ole_visualizar)
end event

event open;call super::open;ivo_twain4	=	Create uo_ge393_twain4

ivo_twain4   = Message.PowerObjectParm

If ivo_twain4.is_Tipo = 'CAIXA' Then
	ivo_twain4.is_caminho = "C:\Sistemas\RL\docs"
	ivo_twain4.ib_envia_ftp = True
End If

ivo_twain4.of_verifica_arquivos()

end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge393_digitalizacao
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge393_digitalizacao
boolean visible = false
integer y = 0
integer width = 178
integer height = 216
integer taborder = 20
boolean enabled = false
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge393_digitalizacao
boolean visible = false
integer width = 78
integer height = 64
integer taborder = 70
boolean enabled = false
string dataobject = "dw_ge393_imagem"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge393_digitalizacao
integer x = 2907
integer y = 1600
integer taborder = 30
boolean enabled = false
end type

event cb_ok::clicked;call super::clicked;Boolean lb_sucesso = True
Long ll_retorno
Long ll_controle
Long ll_contador
Long ll_tamanho
String ls_erro
String ls_arquivo
String ls_caixa
String ls_msg
String ls_retorno
String ls_arquivos[]

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a digitaliza$$HEX2$$e700e300$$ENDHEX$$o?", Question!, YesNo!, 2) = 1 Then	
	Open(w_Janela_Aguarde)
	w_Janela_Aguarde.Wf_Mensagem("Digitalizando Imagem...")				

	If ivo_twain4.is_Tipo = 'CAIXA' Then

		ll_Tamanho = FileLength(ivo_twain4.is_caminho_pre+'\pre.pdf')
		/* Se o arquivo for maior ou igual a 500 KB, n$$HEX1$$e300$$ENDHEX$$o envia e grava log.
			A fun$$HEX2$$e700e300$$ENDHEX$$o FileLenght retorna o tamanho do arquivo em bytes, por isso $$HEX1$$e900$$ENDHEX$$ testado ll_Tamanho >= 512000 */	
		If ll_Tamanho >= 512000 Then
			gvo_Aplicacao.of_Grava_Log("Arquivo $$HEX1$$e900$$ENDHEX$$ maior que 500 KB.")
			Close(w_Janela_Aguarde)					
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo $$HEX1$$e900$$ENDHEX$$ maior que 500 KB. Fa$$HEX1$$e700$$ENDHEX$$a a Pr$$HEX1$$e900$$ENDHEX$$-Visualiza$$HEX2$$e700e300$$ENDHEX$$o novamente SEM alterar as configura$$HEX2$$e700f500$$ENDHEX$$es do Scanner. ~n" + &
										  "Se o problema persistir, favor entrar em contato com o SAF.", StopSign!)
			Return -1
		End If
		
		ls_caixa 		= Trim(gf_captura_valor(ivo_twain4.is_autorizacao, '|', 1, false))
		ll_controle	= Long(Trim(gf_captura_valor(ivo_twain4.is_autorizacao, '|', 2, false)))
		
		Select max(nr_contador_anexos) Into :ll_contador
		From controle_caixa
		Where cd_caixa          = :ls_Caixa
		  and nr_controle_caixa = :ll_Controle
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				If IsNull(ll_contador) Then ll_contador = 0
				ll_contador ++
			Case 100
				ll_contador = 1
			Case -1
				SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o contador anexos")
		End Choose		
		ls_arquivo = ls_caixa + String(ll_controle,'00000') + String(ll_contador,'000') + String( ivo_twain4.idh_movimento, 'YYYYMMDD') + '.pdf'
		//exemplo 0013000535900320170719.pdf
		ivo_twain4.is_caminho = "C:\Sistemas\RL\docs"
		
		If Not lb_sucesso Then 	
			Close(w_Janela_Aguarde)
			Return -1
		End If
		
		//Gravar arquivo		
		CreateDirectory(ivo_twain4.is_caminho)
		If FileExists(ivo_twain4.is_caminho+'\'+ls_arquivo) Then
			FileDelete(ivo_twain4.is_caminho+'\'+ls_arquivo)
		End If
		ll_retorno = FileCopy(ivo_twain4.is_caminho_pre+'\pre.pdf',  ivo_twain4.is_caminho+'\'+ls_arquivo, True)
		
		If ll_retorno <> 1 Then
			Close(w_Janela_Aguarde)
			MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign! )				
			Return -1			
		End If

		Update controle_caixa
		Set nr_contador_anexos = :ll_contador
		Where cd_caixa          = :ls_Caixa
		  and nr_controle_caixa = :ll_Controle
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()	
			SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do contador de anexos")
			lb_sucesso = False
		Else
			SqlCa.of_Commit()
		End If	
		
		If Not lb_sucesso Then 	
			Close(w_Janela_Aguarde)
			Return -1
		Else			
			Close(w_Janela_Aguarde)						
		End If					

	Else		
		ls_arquivo = ivo_twain4.is_autorizacao + String( ivo_twain4.idh_emissao, 'YYYYMMDDhhmmss') + '-a.pdf'  //padrao ePharma
		ivo_Twain4.is_arquivo_digitalizado = ls_arquivo
		
		CreateDirectory(ivo_twain4.is_caminho)
		If FileExists(ivo_twain4.is_caminho+'\'+ls_arquivo) Then
			FileDelete(ivo_twain4.is_caminho+'\'+ls_arquivo)
		End If
		ll_retorno = FileCopy(ivo_twain4.is_caminho_pre+'\pre.pdf',  ivo_twain4.is_caminho+'\'+ls_arquivo, True)
		
		If ll_retorno <> 1 Then
			Close(w_Janela_Aguarde)
			MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign! )				
			Return -1
		Else
			ivo_twain4.is_retorno = 'OK'
			ls_retorno = ivo_twain4.is_retorno + '|' + ivo_twain4.is_caminho+'\'+ls_arquivo + '|'
			Close(w_Janela_Aguarde)						
		End If
	End If	
	
	If lb_sucesso And ivo_twain4.ib_envia_ftp = True Then //Envia para o FTP.
		//Carrega dados envio FTP
		
		//Limpa diretorio de enviados do PDV, quando possuir mais de 500 arquivos o diretorio $$HEX1$$e900$$ENDHEX$$ limpo.
		gf_dir_list( ivo_twain4.is_caminho+'\enviados', '*.pdf', 0+1, Ref ls_Arquivos )
		If UpperBound( ls_Arquivos ) > 500 Then
			gf_limpa_diretorio( ivo_twain4.is_caminho+'\enviados' )
		End If
		
		ivo_twain4.is_caminho_ftp = 		String( ivo_twain4.idh_movimento, 'YYYY/MM/DD/' ) + String( gvo_Parametro.Cd_Filial, '0000' )
		ivo_twain4.is_usuario_ftp = 		'caixafilial'
		ivo_twain4.is_acesso_ftp = 			'Spum@qa8res#'
		ivo_twain4.is_info_ftp = 				'DIGITALIZACAO'
		ivo_twain4.idh_movimento_ftp =	ivo_twain4.idh_movimento
		
		If ivo_twain4.of_envia_ftp(ivo_twain4.is_caminho, ls_arquivo, Ref ls_msg) Then //Move arquivo para pasta enviadas.
			CreateDirectory(ivo_twain4.is_caminho+'\enviados')
		End If
		
		If IsNull(ls_msg) Then ls_msg = ""
		If ls_msg <> "" Then 
			gvo_Aplicacao.of_grava_log( "ERRO DIGITALIZACAO CAIXA: Ret.: " + ls_msg) 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na DIGITALIZA$$HEX2$$c700c300$$ENDHEX$$O DO CAIXA.~r~rLog: " + ls_msg)
		Else
			//Move o arquivo se realmente deu certo o envio
			FileMove(ivo_twain4.is_caminho+'\'+ls_arquivo, ivo_twain4.is_caminho+'\enviados\'+ls_arquivo)
		End If
		
	End If
	If lb_sucesso Then
		If ivo_twain4.is_Tipo = 'CAIXA' Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Digitaliza$$HEX2$$e700e300$$ENDHEX$$o conclu$$HEX1$$ed00$$ENDHEX$$da com sucesso!", Information!)			
			Close(parent)
		Else
			CloseWithReturn(Parent,ls_retorno)
		End If
	End If
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge393_digitalizacao
integer x = 3241
integer y = 1600
integer taborder = 40
end type

type cb_pre from commandbutton within w_ge393_digitalizacao
integer x = 1449
integer y = 1600
integer width = 453
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Pr$$HEX1$$e900$$ENDHEX$$-Visualizar"
end type

event clicked;long ll_handle
String ls_handle

r_visual.visible = True
cb_OK.enabled = False
ole_visualizar.visible = False
ole_visualizar.Object.Navigate('')
ll_handle = gf_retorna_janela_ativa()

If IsNull(ll_handle) Then
	ls_handle = 'NULO'	
Else
	ls_handle = String(ll_handle)
End If

gvo_aplicacao.of_grava_log("Digitalizacao: Abre sele$$HEX2$$e700e300$$ENDHEX$$o de dispositivo. Handle: " + ls_handle )
If ivo_twain4.of_selecao_dispositivo(False, ll_handle) Then

	FileDelete(ivo_twain4.is_caminho_pre + "\pre.pdf")
	
	If ivo_twain4.of_previsualizar(ll_handle) Then
		r_visual.visible = False
		ole_visualizar.visible = True
		ole_visualizar.enabled = True
		gvo_aplicacao.of_grava_log("Digitalizacao: Vai abrir a imagem.")
		ole_visualizar.Object.Navigate(ivo_twain4.is_caminho_pre + "\pre.pdf")
		cb_OK.enabled = True
	Else		
		dw_1.object.p_1.Filename = ""
		cb_OK.enabled = False		
	End If
End If

end event

type ole_visualizar from olecustomcontrol within w_ge393_digitalizacao
event statustextchange ( string text )
event progresschange ( long progress,  long progressmax )
event commandstatechange ( long command,  boolean enable )
event downloadbegin ( )
event downloadcomplete ( )
event titlechange ( string text )
event propertychange ( string szproperty )
event beforenavigate2 ( oleobject pdisp,  any url,  any flags,  any targetframename,  any postdata,  any headers,  ref boolean cancel )
event newwindow2 ( ref oleobject ppdisp,  ref boolean cancel )
event navigatecomplete2 ( oleobject pdisp,  any url )
event documentcomplete ( oleobject pdisp,  any url )
event onquit ( )
event onvisible ( boolean ocx_visible )
event ontoolbar ( boolean toolbar )
event onmenubar ( boolean menubar )
event onstatusbar ( boolean statusbar )
event onfullscreen ( boolean fullscreen )
event ontheatermode ( boolean theatermode )
event windowsetresizable ( boolean resizable )
event windowsetleft ( long left )
event windowsettop ( long top )
event windowsetwidth ( long ocx_width )
event windowsetheight ( long ocx_height )
event windowclosing ( boolean ischildwindow,  ref boolean cancel )
event clienttohostwindow ( ref long cx,  ref long cy )
event setsecurelockicon ( long securelockicon )
event filedownload ( boolean activedocument,  ref boolean cancel )
event navigateerror ( oleobject pdisp,  any url,  any frame,  any statuscode,  ref boolean cancel )
event printtemplateinstantiation ( oleobject pdisp )
event printtemplateteardown ( oleobject pdisp )
event updatepagestatus ( oleobject pdisp,  any npage,  any fdone )
event privacyimpactedstatechange ( boolean bimpacted )
event setphishingfilterstatus ( long phishingfilterstatus )
event newprocess ( long lcauseflag,  oleobject pwb2,  ref boolean cancel )
event redirectxdomainblocked ( oleobject pdisp,  any starturl,  any redirecturl,  any frame,  any statuscode )
event beforescriptexecute ( oleobject pdispwindow )
boolean visible = false
integer x = 23
integer y = 24
integer width = 3543
integer height = 1552
integer taborder = 80
boolean bringtotop = true
boolean enabled = false
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
string binarykey = "w_ge393_digitalizacao.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type r_visual from rectangle within w_ge393_digitalizacao
integer linethickness = 4
long fillcolor = 16777215
integer x = 27
integer y = 28
integer width = 3534
integer height = 1544
end type

type oleobject_1 from oleobject within w_ge393_digitalizacao descriptor "pb_nvo" = "true" 
end type

on oleobject_1.create
call super::create
TriggerEvent( this, "constructor" )
end on

on oleobject_1.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Cw_ge393_digitalizacao.bin 
2300000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000006a010e001d8977900000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f0000000006a010e001d8977906a010e001d89779000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c000050190000281a0000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c000050190000281a0000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Cw_ge393_digitalizacao.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
