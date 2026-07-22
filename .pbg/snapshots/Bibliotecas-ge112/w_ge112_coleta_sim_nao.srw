HA$PBExportHeader$w_ge112_coleta_sim_nao.srw
forward
global type w_ge112_coleta_sim_nao from Window
end type
type cb_cancelar from commandbutton within w_ge112_coleta_sim_nao
end type
type st_titulo1 from statictext within w_ge112_coleta_sim_nao
end type
type cb_sim from commandbutton within w_ge112_coleta_sim_nao
end type
type cb_nao from commandbutton within w_ge112_coleta_sim_nao
end type
type gb_1 from groupbox within w_ge112_coleta_sim_nao
end type
end forward

global type w_ge112_coleta_sim_nao from Window
int X=741
int Y=932
int Width=2149
int Height=624
boolean TitleBar=true
string Title="Transa$$HEX2$$e700e300$$ENDHEX$$o TEF"
long BackColor=80269524
WindowType WindowType=response!
cb_cancelar cb_cancelar
st_titulo1 st_titulo1
cb_sim cb_sim
cb_nao cb_nao
gb_1 gb_1
end type
global w_ge112_coleta_sim_nao w_ge112_coleta_sim_nao

type variables

end variables

on w_ge112_coleta_sim_nao.create
this.cb_cancelar=create cb_cancelar
this.st_titulo1=create st_titulo1
this.cb_sim=create cb_sim
this.cb_nao=create cb_nao
this.gb_1=create gb_1
this.Control[]={this.cb_cancelar,&
this.st_titulo1,&
this.cb_sim,&
this.cb_nao,&
this.gb_1}
end on

on w_ge112_coleta_sim_nao.destroy
destroy(this.cb_cancelar)
destroy(this.st_titulo1)
destroy(this.cb_sim)
destroy(this.cb_nao)
destroy(this.gb_1)
end on

event open;
String ls_Titulo
String ls_Recarga

This.x = ( 3680 - This.Width ) / 2
This.y = ( 2000 - This.Height) / 2

ls_Titulo  = Message.StringParm

This.Show()

gf_Ativa_Janela(This)

This.Title = ls_Titulo
end event

type cb_cancelar from commandbutton within w_ge112_coleta_sim_nao
int X=37
int Y=380
int Width=370
int Height=108
int TabOrder=20
string Text="&Cancelar"
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

type st_titulo1 from statictext within w_ge112_coleta_sim_nao
int X=64
int Y=68
int Width=1998
int Height=272
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_sim from commandbutton within w_ge112_coleta_sim_nao
int X=1714
int Y=380
int Width=370
int Height=108
int TabOrder=20
string Text="&Sim"
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent,'S')
end event

event getfocus;This.Weight  = 700

end event

event losefocus;This.Weight  = 400
end event

type cb_nao from commandbutton within w_ge112_coleta_sim_nao
int X=1326
int Y=380
int Width=370
int Height=108
int TabOrder=30
string Text="&N$$HEX1$$e300$$ENDHEX$$o"
boolean Cancel=true
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent,'N')
end event

event getfocus;This.Weight  = 700
end event

event losefocus;This.Weight  = 400
end event

type gb_1 from groupbox within w_ge112_coleta_sim_nao
int X=37
int Y=12
int Width=2053
int Height=352
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

