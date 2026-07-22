HA$PBExportHeader$w_ge074_solicita_senha_backup.srw
forward
global type w_ge074_solicita_senha_backup from Window
end type
type cb_repetir from commandbutton within w_ge074_solicita_senha_backup
end type
type cb_cancelar from commandbutton within w_ge074_solicita_senha_backup
end type
type st_erro from statictext within w_ge074_solicita_senha_backup
end type
type st_2 from statictext within w_ge074_solicita_senha_backup
end type
type st_msg from statictext within w_ge074_solicita_senha_backup
end type
type cb_1 from commandbutton within w_ge074_solicita_senha_backup
end type
end forward

global type w_ge074_solicita_senha_backup from Window
int X=1134
int Y=964
int Width=1321
int Height=456
long BackColor=80269524
WindowType WindowType=response!
event uo_postopen ( )
cb_repetir cb_repetir
cb_cancelar cb_cancelar
st_erro st_erro
st_2 st_2
st_msg st_msg
cb_1 cb_1
end type
global w_ge074_solicita_senha_backup w_ge074_solicita_senha_backup

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

st_erro.text = "Solicite digita$$HEX2$$e700e300$$ENDHEX$$o da senha no pinpad."

lb_Retorno = io_pinpad.of_senha_pinpad('Digite a senha :', Ref ls_senha_capturada)

If lb_Retorno Then

	If ls_senha_capturada <> io_pinpad.Senha Then
		
		st_erro.text = "Senha inv$$HEX1$$e100$$ENDHEX$$lida."
		
		cb_repetir.Enabled  = True
		cb_cancelar.Enabled = True
		
		Return
		
	Else
		
		io_pinpad.SenhaConfirmada = True
		
	End If
	
Else
			
	io_pinpad.SenhaConfirmada = False

End If

CloseWithReturn(This,io_pinpad)
end subroutine

on w_ge074_solicita_senha_backup.create
this.cb_repetir=create cb_repetir
this.cb_cancelar=create cb_cancelar
this.st_erro=create st_erro
this.st_2=create st_2
this.st_msg=create st_msg
this.cb_1=create cb_1
this.Control[]={this.cb_repetir,&
this.cb_cancelar,&
this.st_erro,&
this.st_2,&
this.st_msg,&
this.cb_1}
end on

on w_ge074_solicita_senha_backup.destroy
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

This.Show()

wf_confirma_senha()


end event

type cb_repetir from commandbutton within w_ge074_solicita_senha_backup
int X=507
int Y=300
int Width=370
int Height=100
int TabOrder=20
boolean Enabled=false
string Text="&Repetir"
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_confirma_senha()

end event

type cb_cancelar from commandbutton within w_ge074_solicita_senha_backup
int X=896
int Y=300
int Width=370
int Height=100
int TabOrder=10
boolean Enabled=false
string Text="&Cancelar"
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
io_pinpad.SenhaConfirmada = False

CloseWithReturn(Parent,io_pinpad)
end event

type st_erro from statictext within w_ge074_solicita_senha_backup
int X=32
int Y=176
int Width=1234
int Height=88
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="Solicite digita$$HEX2$$e700e300$$ENDHEX$$o da senha no pinpad"
boolean FocusRectangle=false
long TextColor=255
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_ge074_solicita_senha_backup
int X=242
int Y=996
int Width=1710
int Height=76
boolean Visible=false
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long BackColor=15793151
int TextSize=-8
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_msg from statictext within w_ge074_solicita_senha_backup
int X=32
int Y=52
int Width=1234
int Height=112
boolean Enabled=false
string Text="Senha de Seguran$$HEX1$$e700$$ENDHEX$$a"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-12
int Weight=700
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_ge074_solicita_senha_backup
int X=32
int Y=408
int Width=622
int Height=108
int TabOrder=30
boolean Visible=false
string Text="Cart$$HEX1$$e300$$ENDHEX$$o Margn$$HEX1$$e900$$ENDHEX$$tico"
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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

