HA$PBExportHeader$w_ge074_solicita_senha.srw
forward
global type w_ge074_solicita_senha from window
end type
type cb_liberacao from commandbutton within w_ge074_solicita_senha
end type
type cb_repetir from commandbutton within w_ge074_solicita_senha
end type
type cb_cancelar from commandbutton within w_ge074_solicita_senha
end type
type st_erro from statictext within w_ge074_solicita_senha
end type
type st_2 from statictext within w_ge074_solicita_senha
end type
type st_msg from statictext within w_ge074_solicita_senha
end type
type cb_1 from commandbutton within w_ge074_solicita_senha
end type
end forward

global type w_ge074_solicita_senha from window
integer x = 1134
integer y = 964
integer width = 1321
integer height = 456
windowtype windowtype = response!
long backcolor = 80269524
event uo_postopen ( )
cb_liberacao cb_liberacao
cb_repetir cb_repetir
cb_cancelar cb_cancelar
st_erro st_erro
st_2 st_2
st_msg st_msg
cb_1 cb_1
end type
global w_ge074_solicita_senha w_ge074_solicita_senha

type prototypes
FUNCTION String SESolicitaTrilha1_2( Ref String Status ) LIBRARY "sitpin32.dll" alias for "SESolicitaTrilha1_2;Ansi"

FUNCTION String SEObtemTrilha1_2( Ref String Trilha1, Ref String Trilha2, Ref String Status ) LIBRARY "sitpin32.dll" alias for "SEObtemTrilha1_2;Ansi"

FUNCTION String SEMsgPadrao( String Mensagem, String Status ) LIBRARY "sitpin32.dll" alias for "SEMsgPadrao;Ansi"

FUNCTION String SEFinalizar() LIBRARY "sitpin32.dll" alias for "SEFinalizar;Ansi"

FUNCTION String SEObtemSenha(Ref String Senha,Ref String Status) LIBRARY "sitpin32.dll" alias for "SEObtemSenha;Ansi"
end prototypes

type variables
uo_pinpad io_pinpad

String Senha
String Cartao

end variables

forward prototypes
public subroutine wf_confirma_senha ()
end prototypes

public subroutine wf_confirma_senha ();
String  ls_senha_capturada

Boolean lb_Retorno

Integer li_Tentativas

cb_repetir.Enabled  = False
cb_cancelar.Enabled = False
cb_liberacao.enabled = False

st_erro.text = "Solicite digita$$HEX2$$e700e300$$ENDHEX$$o da senha no pinpad."

gvo_Aplicacao.of_Grava_Log( "w_ge074_solicita_senha - wf_confirma_senha - Vai solicitar senha Pinpad." )	

lb_Retorno = io_pinpad.of_senha_pinpad('Digite a senha :', Ref ls_senha_capturada)
//lb_Retorno = io_pinpad.of_senha_aberta('Digite a senha :', Ref ls_senha_capturada)

If lb_Retorno Then
	
	//Verificacao no primeiro acesso do conveniado para receber a senha hash sem passar pelo recadastramento
	If io_pinpad.ib_atualiza_hash_senha Then
		io_pinpad.SenhaConfirmada 	= True
		io_pinpad.senhacapturada 		= ls_senha_capturada
	Else
		If ls_senha_capturada <> io_pinpad.Senha Then		
			cb_repetir.text = "&Repetir"
			st_erro.text = "Senha inv$$HEX1$$e100$$ENDHEX$$lida."		
			cb_repetir.Enabled  = True
			cb_cancelar.Enabled = True
			If io_pinpad.alteracaosenha = False Then
				cb_liberacao.enabled = True
			End If
			Return		
		Else		
			io_pinpad.SenhaConfirmada = True		
		End If
	End If
Else			

	If io_pinpad.Retorno = "12" Then
		st_erro.text = "Erro de comunica$$HEX2$$e700e300$$ENDHEX$$o com o pinpad."
		cb_cancelar.Enabled = True
		If io_pinpad.alteracaosenha = False Then		
			cb_liberacao.enabled = True		
		End If
		Return
	Else
		io_pinpad.SenhaConfirmada = False
	End If
End If

CloseWithReturn(This,io_pinpad)
end subroutine

on w_ge074_solicita_senha.create
this.cb_liberacao=create cb_liberacao
this.cb_repetir=create cb_repetir
this.cb_cancelar=create cb_cancelar
this.st_erro=create st_erro
this.st_2=create st_2
this.st_msg=create st_msg
this.cb_1=create cb_1
this.Control[]={this.cb_liberacao,&
this.cb_repetir,&
this.cb_cancelar,&
this.st_erro,&
this.st_2,&
this.st_msg,&
this.cb_1}
end on

on w_ge074_solicita_senha.destroy
destroy(this.cb_liberacao)
destroy(this.cb_repetir)
destroy(this.cb_cancelar)
destroy(this.st_erro)
destroy(this.st_2)
destroy(this.st_msg)
destroy(this.cb_1)
end on

event open;
io_pinpad = Create uo_pinpad

io_pinpad = Message.PowerObjectParm

cb_liberacao.Enabled = Not io_pinpad.AlteracaoSenha
	
This.Show()

If io_pinpad.alteracaosenha = True Then
	wf_confirma_senha()
End If


end event

event closequery;IF KeyDown(KeyAlt!) and KeyDown(KeyF4!) Then Return 1
end event

type cb_liberacao from commandbutton within w_ge074_solicita_senha
integer x = 27
integer y = 300
integer width = 375
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Libera$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;
//io_pinpad.SEFinalizar()

String ls_Matricula

If gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("LIBERACAO_RESTRICAO_SENHA",ls_Matricula) Then
	
	io_pinpad.MatriculaLiberacao = ls_Matricula
	io_pinpad.LiberacaoSenha 			 = True
	io_pinpad.ib_Atualiza_Hash_Senha = False
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A venda foi liberada sem uso de senha pessoal.",Exclamation!)		
	
	CloseWithReturn(Parent,io_pinpad)
End If	
end event

type cb_repetir from commandbutton within w_ge074_solicita_senha
integer x = 425
integer y = 300
integer width = 457
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Senha PinPad"
boolean default = true
end type

event clicked;wf_confirma_senha()

end event

type cb_cancelar from commandbutton within w_ge074_solicita_senha
integer x = 896
integer y = 300
integer width = 370
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
end type

event clicked;
io_pinpad.SenhaConfirmada = False

CloseWithReturn(Parent,io_pinpad)
end event

type st_erro from statictext within w_ge074_solicita_senha
integer x = 32
integer y = 176
integer width = 1234
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_ge074_solicita_senha
boolean visible = false
integer x = 242
integer y = 996
integer width = 1710
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 15793151
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_msg from statictext within w_ge074_solicita_senha
integer x = 32
integer y = 52
integer width = 1234
integer height = 112
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Senha de Seguran$$HEX1$$e700$$ENDHEX$$a"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_ge074_solicita_senha
boolean visible = false
integer x = 32
integer y = 408
integer width = 622
integer height = 108
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cart$$HEX1$$e300$$ENDHEX$$o Margn$$HEX1$$e900$$ENDHEX$$tico"
end type

event clicked;//
//String ls_status_cartao,&
//       ls_trilha1,&
//		 ls_trilha2
//
//Long   ll_retorno
//
//Time   lt_timeout
//
//st_1.text = ''
//st_2.text = ''
//
//ls_status_cartao = Fill(Space(1),2)
//
//ll_retorno = 0 
//
//lt_Timeout = RelativeTime(Now(),15)
//
//Do 
//	
//	SeSolicitaTrilha1_2(Ref ls_status_cartao)
//	
//	If ( ls_status_cartao = "99" ) or ( ls_status_cartao < "00" ) Then
//		
//		//Ocorreu timeout no aguardo da resposta
//		If Now() > lt_timeout Then
//			Exit
//		End If		
//		
//	Else
//		
//		If ls_status_cartao = "00" Then
//			Exit
//		End If	
//		
//	End If	
//	
//Loop Until ls_status_cartao = "00"
//
//ls_status_cartao = Fill(Space(1),2)
//
//ls_trilha1 = Fill(Space(1),80)
//ls_trilha2 = Fill(Space(1),40)
//
//lt_Timeout = RelativeTime(Now(),15)
//
//Do 
//		
//	SeObtemTrilha1_2(Ref ls_trilha1, Ref ls_trilha2, Ref ls_status_cartao )
//	
//	If ( ls_status_cartao = "99" ) Then
//		
//		//Ocorreu timeout no aguardo da resposta
//		If Now() > lt_timeout Then
//			Exit
//		End If		
//		
//	Else
//			
//		SEMsgPadrao(" DROGARIA CATARINENSE " + Space(22) + " A GENTE CUIDA DE VOCE", ls_status_cartao)	
//		Exit
//		
//	End If	
//	
//Loop Until ls_status_cartao = "00"
//
//SEFinalizar()
//
//st_1.text = ls_trilha1
//st_2.text = ls_trilha2
//
//
//
//
//
//
//
//
//
end event

