HA$PBExportHeader$w_ge074_leitura_cartao_pinpad.srw
forward
global type w_ge074_leitura_cartao_pinpad from window
end type
type rb_outros from radiobutton within w_ge074_leitura_cartao_pinpad
end type
type rb_unimed from radiobutton within w_ge074_leitura_cartao_pinpad
end type
type cb_qrcode from commandbutton within w_ge074_leitura_cartao_pinpad
end type
type cb_ok from commandbutton within w_ge074_leitura_cartao_pinpad
end type
type st_cartao from singlelineedit within w_ge074_leitura_cartao_pinpad
end type
type cb_digitar from commandbutton within w_ge074_leitura_cartao_pinpad
end type
type cb_cancelar from commandbutton within w_ge074_leitura_cartao_pinpad
end type
type cb_leitor from commandbutton within w_ge074_leitura_cartao_pinpad
end type
type st_2 from statictext within w_ge074_leitura_cartao_pinpad
end type
type st_msg from statictext within w_ge074_leitura_cartao_pinpad
end type
type cb_1 from commandbutton within w_ge074_leitura_cartao_pinpad
end type
type st_qrcode from singlelineedit within w_ge074_leitura_cartao_pinpad
end type
end forward

global type w_ge074_leitura_cartao_pinpad from window
integer x = 1134
integer y = 964
integer width = 1600
integer height = 540
windowtype windowtype = response!
long backcolor = 80269524
event uo_postopen ( )
rb_outros rb_outros
rb_unimed rb_unimed
cb_qrcode cb_qrcode
cb_ok cb_ok
st_cartao st_cartao
cb_digitar cb_digitar
cb_cancelar cb_cancelar
cb_leitor cb_leitor
st_2 st_2
st_msg st_msg
cb_1 cb_1
st_qrcode st_qrcode
end type
global w_ge074_leitura_cartao_pinpad w_ge074_leitura_cartao_pinpad

type prototypes
FUNCTION String SESolicitaTrilha1_2( Ref String Status ) LIBRARY "sitpin32.dll" alias for "SESolicitaTrilha1_2;Ansi"

FUNCTION String SEObtemTrilha1_2( Ref String Trilha1, Ref String Trilha2, Ref String Status ) LIBRARY "sitpin32.dll" alias for "SEObtemTrilha1_2;Ansi"

FUNCTION String SEMsgPadrao( String Mensagem, String Status ) LIBRARY "sitpin32.dll" alias for "SEMsgPadrao;Ansi"

FUNCTION String SEFinalizar() LIBRARY "sitpin32.dll" alias for "SEFinalizar;Ansi"

FUNCTION String SEObtemSenha(Ref String Senha,Ref String Status) LIBRARY "sitpin32.dll" alias for "SEObtemSenha;Ansi"
end prototypes

type variables
uo_pinpad io_pinpad

String is_CPF_Cliente
end variables

forward prototypes
public subroutine wf_centraliza_janela ()
end prototypes

public subroutine wf_centraliza_janela ();Window w_Parent
w_Parent = ParentWindow()

This.X = (w_Parent.WorkSpaceWidth () - This.Width ) / 2
This.Y = (w_Parent.WorkSpaceHeight() - This.Height) / 2

//This.Show()
end subroutine

on w_ge074_leitura_cartao_pinpad.create
this.rb_outros=create rb_outros
this.rb_unimed=create rb_unimed
this.cb_qrcode=create cb_qrcode
this.cb_ok=create cb_ok
this.st_cartao=create st_cartao
this.cb_digitar=create cb_digitar
this.cb_cancelar=create cb_cancelar
this.cb_leitor=create cb_leitor
this.st_2=create st_2
this.st_msg=create st_msg
this.cb_1=create cb_1
this.st_qrcode=create st_qrcode
this.Control[]={this.rb_outros,&
this.rb_unimed,&
this.cb_qrcode,&
this.cb_ok,&
this.st_cartao,&
this.cb_digitar,&
this.cb_cancelar,&
this.cb_leitor,&
this.st_2,&
this.st_msg,&
this.cb_1,&
this.st_qrcode}
end on

on w_ge074_leitura_cartao_pinpad.destroy
destroy(this.rb_outros)
destroy(this.rb_unimed)
destroy(this.cb_qrcode)
destroy(this.cb_ok)
destroy(this.st_cartao)
destroy(this.cb_digitar)
destroy(this.cb_cancelar)
destroy(this.cb_leitor)
destroy(this.st_2)
destroy(this.st_msg)
destroy(this.cb_1)
destroy(this.st_qrcode)
end on

event close;
CloseWithReturn(This,io_pinpad)
end event

event open;call super::open;
wf_centraliza_janela()

io_pinpad = Create uo_pinpad

io_pinpad = Message.PowerObjectParm	

st_msg.textsize = 13

This.Show()

This.Event uo_postOpen()
/*
If gvo_parametro.id_rede_filial = 'PP' Then
	If gvo_aplicacao.ivo_seguranca.cd_sistema = 'RL' Then
		rb_unimed.enabled = False
		cb_qrcode.enabled = False
		If io_pinpad.Bandeira = 'CONTRATO' Then
			rb_outros.checked = True
			rb_outros.Event Clicked()
			cb_digitar.Event Clicked()
		End If
	Else
		rb_unimed.enabled = True
		rb_outros.enabled = True
	End If
Else
	//Demais Redes
	If io_pinpad.Bandeira = 'CONTRATO' And io_pinpad.id_cartao_plano_saude_digitado <> 'S' Then		
		cb_digitar.enabled = False
		If Not io_pinpad.Instalado Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esse tipo de Cart$$HEX1$$e300$$ENDHEX$$o requer leitura por Pinpad e o mesmo n$$HEX1$$e300$$ENDHEX$$o foi encontrado no PDV.", Information!)		
			Return 0
		End If	
	End If
	
	If io_pinpad.Bandeira = 'UNIMED' Or io_pinpad.Bandeira = 'UNIMED_INJETAVEIS' Then
		rb_outros.enabled = False
	End If
	
	If Not io_pinpad.Instalado Then 
		cb_leitor.Enabled = False
		If io_pinpad.Bandeira <> 'CONTRATO' Then
			cb_digitar.Event Clicked()
		End If
		
	End If
	
	If gvo_parametro.id_rede_filial = 'DC' and gvo_parametro.id_desconto_plano_saude = 'S'  Then
		cb_qrcode.enabled = True
	End If
End If
*/		
			
//If gvo_parametro.id_rede_filial <> 'DC' And gvo_parametro.id_rede_filial <> 'MP' And gvo_parametro.id_rede_filial <> 'PF' Then
//	rb_unimed.enabled = False
//	cb_qrcode.enabled = False
//	If io_pinpad.Bandeira = 'CONTRATO' Then
//		rb_outros.checked = True
//		rb_outros.Event Clicked()
//	Else
//		If io_pinpad.Bandeira = 'UNIMED' Or io_pinpad.Bandeira = 'UNIMED_INJETAVEIS' Then
//			rb_outros.enabled		= False
//			rb_outros.checked		= False
//			rb_unimed.enabled	= True
//			rb_unimed.checked	= True
//			cb_qrcode.enabled	= True
//			
//			If io_pinpad.id_cartao_plano_saude_digitado <> 'S' Then		
//				cb_digitar.enabled = False	
//			End If
//		End If
//	End If
//Else
	If ( io_pinpad.Bandeira = 'UNIMED' Or io_pinpad.Bandeira = 'UNIMED_INJETAVEIS' Or io_pinpad.Bandeira = 'CONTRATO' ) And io_pinpad.id_cartao_plano_saude_digitado <> 'S' Then
		cb_digitar.enabled = False
		If Not io_pinpad.Instalado Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esse tipo de Cart$$HEX1$$e300$$ENDHEX$$o requer leitura por Pinpad e o mesmo n$$HEX1$$e300$$ENDHEX$$o foi encontrado no PDV.", Information!)		
			Return 0
		End If	
	End If
	
	If io_pinpad.Bandeira = 'UNIMED' Or io_pinpad.Bandeira = 'UNIMED_INJETAVEIS' Then
		rb_outros.enabled = False
	End If
	
	If Not io_pinpad.Instalado Then 
			cb_leitor.Enabled = False
		If io_pinpad.Bandeira <> 'CONTRATO' Then
			cb_digitar.Event Clicked()
		End If
	End If
//End If

If gvo_parametro.id_desconto_plano_saude = 'S'  Then
	cb_qrcode.enabled = True
End If
end event

type rb_outros from radiobutton within w_ge074_leitura_cartao_pinpad
integer x = 850
integer y = 12
integer width = 366
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Clinipam"
end type

event clicked;String ls_CPF_Mask

rb_Unimed.checked 	= False

cb_digitar.enabled 	= True
cb_leitor.enabled 		= False
cb_qrcode.enabled	= False

st_msg.Text = 'Digite o n$$HEX1$$fa00$$ENDHEX$$mero do cart$$HEX1$$e300$$ENDHEX$$o'

Try
	uo_cliente lo_Cliente
	lo_Cliente = Create uo_Cliente
	lo_Cliente.of_localiza_codigo( io_pinpad.cd_cliente )
	
	If lo_Cliente.Localizado Then
		
		st_msg.textsize	= 13
		st_msg.Text 	= 'Se necess$$HEX1$$e100$$ENDHEX$$rio pressione o bot$$HEX1$$e300$$ENDHEX$$o [Digitar] para alterar o CPF do benefici$$HEX1$$e100$$ENDHEX$$rio'
		st_cartao.text 	= Mid(lo_Cliente.nr_cpf_cgc, 1, 3 ) + ".###.###-" + Mid(lo_Cliente.nr_cpf_cgc, 10, 2 )
		is_Cpf_Cliente	= lo_Cliente.nr_cpf_cgc
	Else
		st_msg.textsize	= 13
		st_msg.Text 	= 'Informe o CPF do benefici$$HEX1$$e100$$ENDHEX$$rio'
		st_cartao.text	= ""
	End If
Finally
	If IsValid(lo_Cliente) Then Destroy lo_Cliente
End Try
end event

type rb_unimed from radiobutton within w_ge074_leitura_cartao_pinpad
integer x = 338
integer y = 12
integer width = 311
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Unimed"
boolean checked = true
end type

event clicked;rb_outros.checked = False

If io_pinpad.id_cartao_plano_saude_digitado <> 'S' Then
	cb_digitar.enabled = False	
End If
cb_qrcode.enabled 	= True
cb_leitor.enabled 		= True
cb_qrcode.enabled	= True

st_cartao.Text    = ''
st_cartao.Enabled = False

st_msg.textsize = 13
st_msg.Text = 'Passe o cart$$HEX1$$e300$$ENDHEX$$o pelo leitor'

end event

type cb_qrcode from commandbutton within w_ge074_leitura_cartao_pinpad
integer x = 649
integer y = 404
integer width = 302
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&QR Code"
end type

event clicked;//Usando a dll do clisitef n$$HEX1$$e300$$ENDHEX$$o precisa fazer esse comando.
If io_pinpad.Status = "ON" Then  
 	SEFinalizar()
End If

st_msg.Text = 'Leia o Qr Code do Cart$$HEX1$$e300$$ENDHEX$$o'

st_cartao.Text    = ''
st_cartao.Enabled = False
st_qrcode.enabled = True
st_qrcode.SetFocus()

io_pinpad.Leitura   = False
io_pinpad.Digitacao = True

cb_ok.default = False

end event

type cb_ok from commandbutton within w_ge074_leitura_cartao_pinpad
integer x = 1262
integer y = 404
integer width = 302
integer height = 100
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&OK"
boolean default = true
end type

event clicked;
If io_pinpad.Status = "ON" Then
 	SEFinalizar()
Else
		
	If io_pinpad.Digitacao Then
	   io_pinpad.Cartao = st_cartao.Text	
	End If	
		
	If rb_unimed.checked Then
		io_pinpad.tipo_cartao_saude = '1'
	End If
	
	If rb_outros.checked Then
		//Se n$$HEX1$$e300$$ENDHEX$$o foi digitado $$HEX1$$e900$$ENDHEX$$ o CPF mascarado do cliente clube e precisa ser alterado
		If Not io_pinpad.Digitacao Then
			io_pinpad.Cartao = is_CPF_Cliente
		End If
		
		If Not gf_valida_cpf(io_pinpad.Cartao) Then
			Return -1			
		End If		
		
		io_pinpad.tipo_cartao_saude = '2'
		
		//Retorna como digitado o cpf do cliente clube
		io_pinpad.Digitacao = True 
	End If
	
	If IsNull(io_pinpad.Cartao) or Trim(io_pinpad.Cartao) = '' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cart$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o informado.", Exclamation!)
		Return 
	End If
	
	Close(Parent)
	
End If	



end event

type st_cartao from singlelineedit within w_ge074_leitura_cartao_pinpad
integer x = 183
integer y = 288
integer width = 1234
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_digitar from commandbutton within w_ge074_leitura_cartao_pinpad
integer x = 343
integer y = 404
integer width = 302
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Digitar"
end type

event clicked;//Usando a dll do clisitef n$$HEX1$$e300$$ENDHEX$$o precisa fazer esse comando.
If io_pinpad.Status = "ON" Then  
 	SEFinalizar()
End If

If rb_outros.checked Then
	st_msg.Text = 'Informe o CPF do benefici$$HEX1$$e100$$ENDHEX$$rio'
Else
	st_msg.Text = 'Digite o n$$HEX1$$fa00$$ENDHEX$$mero do cart$$HEX1$$e300$$ENDHEX$$o'
End If

st_cartao.Text    = ''
st_cartao.Enabled = True
st_qrcode.enabled = False
st_cartao.SetFocus()

io_pinpad.Leitura   = False
io_pinpad.Digitacao = True

end event

type cb_cancelar from commandbutton within w_ge074_leitura_cartao_pinpad
integer x = 955
integer y = 404
integer width = 302
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;If io_pinpad.Status = "ON" Then
	SetPointer(HourGlass!)
 	SEFinalizar()
   SetPointer(Arrow!)
Else
	
	io_pinpad.Leitura   = False
	io_pinpad.Digitacao = False
	
	Close(Parent)
	
End If	




end event

type cb_leitor from commandbutton within w_ge074_leitura_cartao_pinpad
integer x = 37
integer y = 404
integer width = 302
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Pinpad"
boolean default = true
end type

event clicked;Boolean lb_Leitura
String ls_digitado
String ls_trilha1
String ls_trilha2

This.Enabled = True

cb_cancelar.SetFocus()

st_msg.Text = 'Passe o cart$$HEX1$$e300$$ENDHEX$$o pelo leitor'

st_cartao.Enabled = False
st_qrcode.enabled = False

This.Enabled = False

lb_Leitura = io_pinpad.of_leitura_cartao_magnetico()

//lb_Leitura = Sitef.of_leitura_cartao_interativo(Ref ls_digitado, Ref ls_trilha1, Ref ls_trilha2)

This.Enabled = True

If lb_Leitura Then
	
	st_cartao.text = io_pinpad.Cartao
	
	cb_ok.SetFocus()
	
End If

//If lb_Leitura Then
//	
//	io_pinpad.Trilha2 = ls_trilha2
//	If io_pinpad.of_captura_cartao_bandeira() Then
//		st_cartao.text = io_pinpad.Cartao
//		io_pinpad.Leitura   = True
//		io_pinpad.Digitacao = False		
//		
//		cb_ok.SetFocus()
//	End If	
//End If
end event

type st_2 from statictext within w_ge074_leitura_cartao_pinpad
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

type st_msg from statictext within w_ge074_leitura_cartao_pinpad
integer x = 69
integer y = 124
integer width = 1472
integer height = 148
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Passe o cart$$HEX1$$e300$$ENDHEX$$o pelo leitor"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_ge074_leitura_cartao_pinpad
boolean visible = false
integer x = 41
integer y = 516
integer width = 622
integer height = 108
integer taborder = 80
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

type st_qrcode from singlelineedit within w_ge074_leitura_cartao_pinpad
boolean visible = false
integer x = 14
integer y = 296
integer width = 5001
integer height = 92
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean enabled = false
boolean autohscroll = false
textcase textcase = upper!
integer limit = 200
borderstyle borderstyle = stylelowered!
end type

event modified;//Tratamento especifico pra UNIMED

String ls_texto
String ls_cartao

ls_texto = st_qrcode.text

If LenA(ls_texto) < 50 Or (LeftA(ls_texto, 5) <> "1=01=" And LeftA(ls_texto, 5) <> "2=01=" And LeftA(ls_texto, 5) <> "3=01=") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Leitura Qr Code incorreta!",Exclamation!)
	st_qrcode.text = ''
	Return -1
Else
	//Pega Peda$$HEX1$$e700$$ENDHEX$$o
	ls_cartao = Trim( MidA( ls_texto, 6, 17 ) )
	st_cartao.text = ls_cartao
	cb_ok.default = True
End If

end event

