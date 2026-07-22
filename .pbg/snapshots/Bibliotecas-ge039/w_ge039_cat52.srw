HA$PBExportHeader$w_ge039_cat52.srw
forward
global type w_ge039_cat52 from dc_w_response
end type
type em_data from editmask within w_ge039_cat52
end type
type st_1 from statictext within w_ge039_cat52
end type
type cb_ok from commandbutton within w_ge039_cat52
end type
type cb_cancela from commandbutton within w_ge039_cat52
end type
type st_2 from statictext within w_ge039_cat52
end type
type st_3 from statictext within w_ge039_cat52
end type
end forward

global type w_ge039_cat52 from dc_w_response
integer width = 1065
integer height = 660
string title = "GE039 - Par$$HEX1$$e200$$ENDHEX$$metro CAT-52"
boolean center = true
em_data em_data
st_1 st_1
cb_ok cb_ok
cb_cancela cb_cancela
st_2 st_2
st_3 st_3
end type
global w_ge039_cat52 w_ge039_cat52

type variables
String ivs_parametro
end variables

on w_ge039_cat52.create
int iCurrent
call super::create
this.em_data=create em_data
this.st_1=create st_1
this.cb_ok=create cb_ok
this.cb_cancela=create cb_cancela
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_data
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.cb_cancela
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
end on

on w_ge039_cat52.destroy
call super::destroy
destroy(this.em_data)
destroy(this.st_1)
destroy(this.cb_ok)
destroy(this.cb_cancela)
destroy(this.st_2)
destroy(this.st_3)
end on

event open;call super::open;em_data.text = String(Today(),'dd/mm/yyyy')
end event

type pb_help from dc_w_response`pb_help within w_ge039_cat52
boolean visible = false
end type

type em_data from editmask within w_ge039_cat52
integer x = 325
integer y = 268
integer width = 389
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 33554431
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_1 from statictext within w_ge039_cat52
integer x = 78
integer y = 268
integer width = 224
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Data:"
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_ge039_cat52
integer x = 192
integer y = 424
integer width = 402
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&OK"
end type

event clicked;If IsDate(em_data.Text) Then
	ivs_parametro = String(Date(em_data.Text),'dd/mm/yyyy')
	CloseWithReturn(Parent,ivs_Parametro)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe uma Data V$$HEX1$$e100$$ENDHEX$$lida.")
end If
end event

type cb_cancela from commandbutton within w_ge039_cat52
integer x = 613
integer y = 424
integer width = 402
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancela"
end type

event clicked;ivs_Parametro = 'CANCELAR'

CloseWithReturn(Parent,ivs_Parametro)
end event

type st_2 from statictext within w_ge039_cat52
integer x = 101
integer y = 68
integer width = 855
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Informe a data para gerar o"
boolean focusrectangle = false
end type

type st_3 from statictext within w_ge039_cat52
integer x = 101
integer y = 144
integer width = 855
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Arquivo da NF Paulista"
boolean focusrectangle = false
end type

