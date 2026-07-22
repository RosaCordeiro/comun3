HA$PBExportHeader$w_mensagem.srw
forward
global type w_mensagem from dc_w_response
end type
type gb_1 from groupbox within w_mensagem
end type
type st_1 from statictext within w_mensagem
end type
type st_2 from statictext within w_mensagem
end type
type st_3 from statictext within w_mensagem
end type
end forward

global type w_mensagem from dc_w_response
int Width=2249
int Height=368
boolean TitleBar=false
long BackColor=80269524
boolean ControlMenu=false
gb_1 gb_1
st_1 st_1
st_2 st_2
st_3 st_3
end type
global w_mensagem w_mensagem

on w_mensagem.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_3
end on

on w_mensagem.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
end on

event key;If Key = keyF8! Then
	Close(This)
End If
end event

event ue_postopen;call super::ue_postopen;This.SetFocus()
end event

type gb_1 from groupbox within w_mensagem
int X=27
int Width=2162
int Height=320
int TabOrder=10
BorderStyle BorderStyle=StyleRaised!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_mensagem
int X=46
int Y=64
int Width=2126
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="A venda foi cancelada na e-Pharma"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=80269524
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_mensagem
int X=46
int Y=144
int Width=2126
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="N$$HEX1$$e300$$ENDHEX$$o esque$$HEX1$$e700$$ENDHEX$$a de fazer a devolu$$HEX2$$e700e300$$ENDHEX$$o do cupom no Retaguarda de Loja"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=80269524
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_mensagem
int X=46
int Y=224
int Width=2126
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="<F8> Fecha a janela"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

