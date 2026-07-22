HA$PBExportHeader$w_ge112_coleta_campo_string.srw
forward
global type w_ge112_coleta_campo_string from Window
end type
type st_titulo3 from statictext within w_ge112_coleta_campo_string
end type
type st_titulo2 from statictext within w_ge112_coleta_campo_string
end type
type st_titulo1 from statictext within w_ge112_coleta_campo_string
end type
type cb_voltar from commandbutton within w_ge112_coleta_campo_string
end type
type st_transacao from statictext within w_ge112_coleta_campo_string
end type
type em_1 from editmask within w_ge112_coleta_campo_string
end type
type cb_confirmar from commandbutton within w_ge112_coleta_campo_string
end type
type cb_cancelar from commandbutton within w_ge112_coleta_campo_string
end type
type gb_1 from groupbox within w_ge112_coleta_campo_string
end type
end forward

global type w_ge112_coleta_campo_string from Window
int X=741
int Y=932
int Width=2149
int Height=804
boolean TitleBar=true
string Title="Transa$$HEX2$$e700e300$$ENDHEX$$o TEF"
long BackColor=80269524
WindowType WindowType=response!
st_titulo3 st_titulo3
st_titulo2 st_titulo2
st_titulo1 st_titulo1
cb_voltar cb_voltar
st_transacao st_transacao
em_1 em_1
cb_confirmar cb_confirmar
cb_cancelar cb_cancelar
gb_1 gb_1
end type
global w_ge112_coleta_campo_string w_ge112_coleta_campo_string

type variables
Long Comando
Long TamanhoMinimo
Long TamanhoMaximo
end variables

forward prototypes
public subroutine wf_titulo (string ps_titulo)
end prototypes

public subroutine wf_titulo (string ps_titulo);
String ls_titulo

Long   ll_Pos    = 0
Long   ll_Titulo = 1

For ll_Pos = 1 To LenA(ps_titulo)
	
	If MidA(ps_titulo,ll_Pos,1) <> CharA(10) Then
		ls_Titulo += Upper(MidA(ps_titulo,ll_Pos,1))
	End If	
		
	If MidA(ps_titulo,ll_Pos,1) = CharA(10) or ll_Pos = LenA(ps_Titulo) Then	

		Choose Case ll_Titulo
			Case 1				
				st_titulo1.text = ls_titulo
			Case 2
				st_titulo2.text = ls_titulo
			Case 3	
				st_titulo3.text = ls_titulo
		End Choose
		
		ll_Titulo ++
		ls_Titulo = ''
		
	End If
	
Next
end subroutine

on w_ge112_coleta_campo_string.create
this.st_titulo3=create st_titulo3
this.st_titulo2=create st_titulo2
this.st_titulo1=create st_titulo1
this.cb_voltar=create cb_voltar
this.st_transacao=create st_transacao
this.em_1=create em_1
this.cb_confirmar=create cb_confirmar
this.cb_cancelar=create cb_cancelar
this.gb_1=create gb_1
this.Control[]={this.st_titulo3,&
this.st_titulo2,&
this.st_titulo1,&
this.cb_voltar,&
this.st_transacao,&
this.em_1,&
this.cb_confirmar,&
this.cb_cancelar,&
this.gb_1}
end on

on w_ge112_coleta_campo_string.destroy
destroy(this.st_titulo3)
destroy(this.st_titulo2)
destroy(this.st_titulo1)
destroy(this.cb_voltar)
destroy(this.st_transacao)
destroy(this.em_1)
destroy(this.cb_confirmar)
destroy(this.cb_cancelar)
destroy(this.gb_1)
end on

event open;
String ls_Titulo
String ls_Recarga


This.x = ( 3680 - This.Width ) / 2
This.y = ( 2000 - This.Height) / 2

This.Comando       = Long(MidA(Message.StringParm,01,5))
This.TamanhoMinimo = Long(MidA(Message.StringParm,07,5))
This.TamanhoMaximo = Long(MidA(Message.StringParm,13,5))

ls_Recarga = MidA(Message.StringParm,19,50)
ls_Titulo  = MidA(Message.StringParm,70)

Wf_Titulo(ls_Titulo)

//This.Title = ls_Titulo

This.st_transacao.Text = ls_Recarga

em_1.Event uo_Config()

This.Show()

gf_Ativa_Janela(This)

em_1.SetFocus()

//Recupera informa$$HEX2$$e700f500$$ENDHEX$$es do pedido Disque
/*If Not IsNull(uo_sitef_retaguarda.nr_cartao_disque) And uo_sitef_retaguarda.Tipo_Campo = 512 Then
	em_1.Text = uo_sitef_retaguarda.nr_cartao_disque
End If

If Not IsNull(uo_sitef_retaguarda.dh_validade_cartao_disque) And uo_sitef_retaguarda.Tipo_Campo = 513 Then
	em_1.Text = uo_sitef_retaguarda.dh_validade_cartao_disque
End If

If Not IsNull(uo_sitef_retaguarda.cd_seguranca_cartao_disque) And uo_sitef_retaguarda.Tipo_Campo = 514 Then
	em_1.Text = uo_sitef_retaguarda.cd_seguranca_cartao_disque
End If*/
///
end event

type st_titulo3 from statictext within w_ge112_coleta_campo_string
int X=37
int Y=148
int Width=2053
int Height=60
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-7
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_titulo2 from statictext within w_ge112_coleta_campo_string
int X=37
int Y=80
int Width=2053
int Height=60
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-7
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_titulo1 from statictext within w_ge112_coleta_campo_string
int X=37
int Y=12
int Width=2053
int Height=60
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-7
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_voltar from commandbutton within w_ge112_coleta_campo_string
int X=37
int Y=544
int Width=370
int Height=108
int TabOrder=30
string Text="&Voltar"
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent,'VOLTAR')
end event

event getfocus;This.Weight  = 700
end event

event losefocus;This.Weight  = 400
end event

type st_transacao from statictext within w_ge112_coleta_campo_string
int X=78
int Y=264
int Width=1979
int Height=76
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-13
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_1 from editmask within w_ge112_coleta_campo_string
event uo_config ( )
int X=78
int Y=364
int Width=1979
int Height=112
int TabOrder=20
TextCase TextCase=Upper!
BorderStyle BorderStyle=StyleLowered!
MaskDataType MaskDataType=StringMask!
long TextColor=33554432
int TextSize=-13
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event uo_config;//Configura coleta de um campo string qualquer
		
This.MinMax = String(Parent.TamanhoMinimo) + " ~~ "+ String(Parent.TamanhoMaximo)

This.SetMask(StringMask!,FillA('x',Parent.TamanhoMaximo))

end event

event getfocus;cb_confirmar.Weight  = 700

end event

event losefocus;cb_confirmar.Weight  = 400
end event

type cb_confirmar from commandbutton within w_ge112_coleta_campo_string
int X=1714
int Y=544
int Width=370
int Height=108
int TabOrder=40
string Text="&Confirmar"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String ls_Campo

ls_Campo = em_1.text

If IsNull(ls_Campo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar os dados solicitados.",Exclamation!)
	Return
End If	

If LenA(ls_Campo) < Parent.TamanhoMinimo Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Dados informados s$$HEX1$$e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lidos (m$$HEX1$$ed00$$ENDHEX$$nimo " + String(Parent.TamanhoMinimo) + " posi$$HEX2$$e700f500$$ENDHEX$$es).",Exclamation!)
	Return
End If	

If LenA(ls_Campo) > Parent.TamanhoMaximo Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Dados informados s$$HEX1$$e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lidos (m$$HEX1$$e100$$ENDHEX$$ximo " + String(Parent.TamanhoMinimo) + " posi$$HEX2$$e700f500$$ENDHEX$$es).",Exclamation!)
	Return
End If	

CloseWithReturn(Parent,ls_Campo)
end event

event getfocus;This.Weight  = 700

end event

event losefocus;This.Weight  = 400
end event

type cb_cancelar from commandbutton within w_ge112_coleta_campo_string
int X=1326
int Y=544

int Width=370
int Height=108
int TabOrder=50
string Text="C&ancelar"
boolean Cancel=true
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent,'CANCELAR')
end event

event getfocus;This.Weight  = 700
end event

event losefocus;This.Weight  = 400
end event

type gb_1 from groupbox within w_ge112_coleta_campo_string
int X=37
int Y=216
int Width=2053
int Height=304
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

