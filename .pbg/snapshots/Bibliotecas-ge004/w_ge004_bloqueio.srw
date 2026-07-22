HA$PBExportHeader$w_ge004_bloqueio.srw
forward
global type w_ge004_bloqueio from dc_w_response
end type
type cb_1 from commandbutton within w_ge004_bloqueio
end type
type cb_2 from commandbutton within w_ge004_bloqueio
end type
type cb_3 from commandbutton within w_ge004_bloqueio
end type
type gb_1 from groupbox within w_ge004_bloqueio
end type
type st_1 from statictext within w_ge004_bloqueio
end type
end forward

global type w_ge004_bloqueio from dc_w_response
int X=1454
int Y=1316
int Width=1765
int Height=388
boolean TitleBar=false
long BackColor=80269524
boolean ControlMenu=false
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
gb_1 gb_1
st_1 st_1
end type
global w_ge004_bloqueio w_ge004_bloqueio

on w_ge004_bloqueio.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.gb_1=create gb_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.st_1
end on

on w_ge004_bloqueio.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.gb_1)
destroy(this.st_1)
end on

event open;call super::open;If Not Message.StringParm = "100" Then
	cb_1.Enabled = True
Else	
	cb_1.Enabled = False
End If

end event

type cb_1 from commandbutton within w_ge004_bloqueio
int X=571
int Y=248
int Width=370
int Height=100
int TabOrder=10
boolean BringToTop=true
string Text="&Liberar"
int TextSize=-8
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent,"LIBERAR")
end event

type cb_2 from commandbutton within w_ge004_bloqueio
int X=955
int Y=248
int Width=370
int Height=100
int TabOrder=20
boolean BringToTop=true
string Text="&Detalhes"
int TextSize=-8
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent,"DETALHES")


end event

type cb_3 from commandbutton within w_ge004_bloqueio
int X=1339
int Y=248
int Width=370
int Height=100
int TabOrder=30
boolean BringToTop=true
string Text="&Cancelar"
boolean Default=true
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent,"CANCELAR")
end event

type gb_1 from groupbox within w_ge004_bloqueio
int X=32
int Y=4
int Width=1678
int Height=224
int TabOrder=10
BorderStyle BorderStyle=StyleRaised!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_ge004_bloqueio
int X=55
int Y=52
int Width=1627
int Height=132
boolean Enabled=false
boolean BringToTop=true
string Text="Foram encontrados registros de bloqueios para o conv$$HEX1$$ea00$$ENDHEX$$nio e/ou conveniado."
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

