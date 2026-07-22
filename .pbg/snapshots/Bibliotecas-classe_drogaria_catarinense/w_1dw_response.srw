HA$PBExportHeader$w_1dw_response.srw
forward
global type w_1dw_response from w_response
end type
type gb_1 from groupbox within w_1dw_response
end type
type cb_ok from commandbutton within w_1dw_response
end type
type cb_cancelar from commandbutton within w_1dw_response
end type
type dw_1 from u_dw within w_1dw_response
end type
end forward

global type w_1dw_response from w_response
int Width=2112
int Height=1272
gb_1 gb_1
cb_ok cb_ok
cb_cancelar cb_cancelar
dw_1 dw_1
end type
global w_1dw_response w_1dw_response

on w_1dw_response.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.cb_ok=create cb_ok
this.cb_cancelar=create cb_cancelar
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancelar
this.Control[iCurrent+4]=this.dw_1
end on

on w_1dw_response.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.cb_ok)
destroy(this.cb_cancelar)
destroy(this.dw_1)
end on

event open;call super::open;//
dw_1.Event pfc_AddRow()
dw_1.SetFocus()
//
end event

type gb_1 from groupbox within w_1dw_response
int X=37
int Y=32
int Width=1975
int Height=992
int TabOrder=10
string Text="Sele$$HEX2$$e700e300$$ENDHEX$$o"
BorderStyle BorderStyle=StyleRaised!
long TextColor=8388608
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_ok from commandbutton within w_1dw_response
int X=1271
int Y=1068
int Width=352
int Height=92
int TabOrder=20
boolean BringToTop=true
string Text="O&k"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancelar from commandbutton within w_1dw_response
int X=1641
int Y=1068
int Width=352
int Height=92
int TabOrder=30
boolean BringToTop=true
string Text="&Cancelar"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//
CLOSE(PARENT)
//
end event

type dw_1 from u_dw within w_1dw_response
int X=73
int Y=96
int Width=1902
int Height=896
int TabOrder=11
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event constructor;call super::constructor;//
ib_isupdateable = FALSE
//
end event

