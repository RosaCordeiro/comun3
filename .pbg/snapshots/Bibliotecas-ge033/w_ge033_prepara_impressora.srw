HA$PBExportHeader$w_ge033_prepara_impressora.srw
forward
global type w_ge033_prepara_impressora from dc_w_response
end type
type gb_1 from groupbox within w_ge033_prepara_impressora
end type
type st_1 from statictext within w_ge033_prepara_impressora
end type
type cb_imprimir from commandbutton within w_ge033_prepara_impressora
end type
type cb_setup from commandbutton within w_ge033_prepara_impressora
end type
type st_2 from statictext within w_ge033_prepara_impressora
end type
end forward

global type w_ge033_prepara_impressora from dc_w_response
integer x = 1097
integer y = 916
integer width = 1477
integer height = 552
string title = "Configura$$HEX2$$e700e300$$ENDHEX$$o da Impressora"
boolean controlmenu = false
gb_1 gb_1
st_1 st_1
cb_imprimir cb_imprimir
cb_setup cb_setup
st_2 st_2
end type
global w_ge033_prepara_impressora w_ge033_prepara_impressora

on w_ge033_prepara_impressora.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.st_1=create st_1
this.cb_imprimir=create cb_imprimir
this.cb_setup=create cb_setup
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_imprimir
this.Control[iCurrent+4]=this.cb_setup
this.Control[iCurrent+5]=this.st_2
end on

on w_ge033_prepara_impressora.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.cb_imprimir)
destroy(this.cb_setup)
destroy(this.st_2)
end on

type pb_help from dc_w_response`pb_help within w_ge033_prepara_impressora
end type

type gb_1 from groupbox within w_ge033_prepara_impressora
integer x = 27
integer y = 4
integer width = 1394
integer height = 296
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
borderstyle borderstyle = styleraised!
end type

type st_1 from statictext within w_ge033_prepara_impressora
integer x = 46
integer y = 148
integer width = 1362
integer height = 128
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
string text = "Verifique se a impressora est$$HEX1$$e100$$ENDHEX$$ corretamente posicionada para imprimir."
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_imprimir from commandbutton within w_ge033_prepara_impressora
integer x = 599
integer y = 324
integer width = 402
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Imprimir"
boolean default = true
end type

event clicked;Close(Parent)
end event

type cb_setup from commandbutton within w_ge033_prepara_impressora
integer x = 1019
integer y = 324
integer width = 402
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Impre&ssora"
end type

event clicked;PrintSetup()
end event

type st_2 from statictext within w_ge033_prepara_impressora
integer x = 41
integer y = 64
integer width = 1367
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 79741120
boolean enabled = false
string text = "A T E N $$HEX1$$c700$$ENDHEX$$ $$HEX1$$c300$$ENDHEX$$ O"
alignment alignment = center!
boolean focusrectangle = false
end type

