HA$PBExportHeader$w_ge112_coleta_campo_senha.srw
forward
global type w_ge112_coleta_campo_senha from Window
end type
type em_1 from singlelineedit within w_ge112_coleta_campo_senha
end type
type st_titulo3 from statictext within w_ge112_coleta_campo_senha
end type
type st_titulo2 from statictext within w_ge112_coleta_campo_senha
end type
type st_titulo1 from statictext within w_ge112_coleta_campo_senha
end type
type cb_voltar from commandbutton within w_ge112_coleta_campo_senha
end type
type cb_confirmar from commandbutton within w_ge112_coleta_campo_senha
end type
type cb_cancelar from commandbutton within w_ge112_coleta_campo_senha
end type
type gb_1 from groupbox within w_ge112_coleta_campo_senha
end type
end forward

global type w_ge112_coleta_campo_senha from Window
int X=1294
int Y=1156
int Width=2149
int Height=804
boolean TitleBar=true
string Title="Transa$$HEX2$$e700e300$$ENDHEX$$o TEF"
long BackColor=80269524
WindowType WindowType=response!
em_1 em_1
st_titulo3 st_titulo3
st_titulo2 st_titulo2
st_titulo1 st_titulo1
cb_voltar cb_voltar
cb_confirmar cb_confirmar
cb_cancelar cb_cancelar
gb_1 gb_1
end type
global w_ge112_coleta_campo_senha w_ge112_coleta_campo_senha

type variables

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

on w_ge112_coleta_campo_senha.create
this.em_1=create em_1
this.st_titulo3=create st_titulo3
this.st_titulo2=create st_titulo2
this.st_titulo1=create st_titulo1
this.cb_voltar=create cb_voltar
this.cb_confirmar=create cb_confirmar
this.cb_cancelar=create cb_cancelar
this.gb_1=create gb_1
this.Control[]={this.em_1,&
this.st_titulo3,&
this.st_titulo2,&
this.st_titulo1,&
this.cb_voltar,&
this.cb_confirmar,&
this.cb_cancelar,&
this.gb_1}
end on

on w_ge112_coleta_campo_senha.destroy
destroy(this.em_1)
destroy(this.st_titulo3)
destroy(this.st_titulo2)
destroy(this.st_titulo1)
destroy(this.cb_voltar)
destroy(this.cb_confirmar)
destroy(this.cb_cancelar)
destroy(this.gb_1)
end on

event open;
String ls_Titulo

This.x = ( 3680 - This.Width ) / 2
This.y = ( 2000 - This.Height) / 2

ls_Titulo  = MidA(Message.StringParm,50)

Wf_Titulo(ls_Titulo)

This.Show()

gf_Ativa_Janela(This)

em_1.SetFocus()
end event

type em_1 from singlelineedit within w_ge112_coleta_campo_senha
int X=87
int Y=364
int Width=1979
int Height=112
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
long TextColor=33554432
int TextSize=-13
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_titulo3 from statictext within w_ge112_coleta_campo_senha
int X=41
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

type st_titulo2 from statictext within w_ge112_coleta_campo_senha
int X=41
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

type st_titulo1 from statictext within w_ge112_coleta_campo_senha
int X=41
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

type cb_voltar from commandbutton within w_ge112_coleta_campo_senha
int X=50
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

type cb_confirmar from commandbutton within w_ge112_coleta_campo_senha
int X=1723
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
	em_1.SetFocus()
	Return
End If	

If ls_Campo <> '13918' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","C$$HEX1$$f300$$ENDHEX$$digo do Supervisor Inv$$HEX1$$e100$$ENDHEX$$lido.",Exclamation!)
	em_1.SetFocus()
	Return
End If

CloseWithReturn(Parent,ls_Campo)
end event

event getfocus;This.Weight  = 700

end event

event losefocus;This.Weight  = 400
end event

type cb_cancelar from commandbutton within w_ge112_coleta_campo_senha
int X=1335
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

type gb_1 from groupbox within w_ge112_coleta_campo_senha
int X=41
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

