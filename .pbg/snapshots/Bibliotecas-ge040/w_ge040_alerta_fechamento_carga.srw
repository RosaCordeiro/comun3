HA$PBExportHeader$w_ge040_alerta_fechamento_carga.srw
forward
global type w_ge040_alerta_fechamento_carga from dc_w_response
end type
type cb_1 from commandbutton within w_ge040_alerta_fechamento_carga
end type
type st_1 from statictext within w_ge040_alerta_fechamento_carga
end type
type cb_2 from commandbutton within w_ge040_alerta_fechamento_carga
end type
type st_2 from statictext within w_ge040_alerta_fechamento_carga
end type
type gb_1 from groupbox within w_ge040_alerta_fechamento_carga
end type
end forward

global type w_ge040_alerta_fechamento_carga from dc_w_response
integer width = 1792
integer height = 508
string title = "CA - Alerta de Fechamento"
long backcolor = 16777215
cb_1 cb_1
st_1 st_1
cb_2 cb_2
st_2 st_2
gb_1 gb_1
end type
global w_ge040_alerta_fechamento_carga w_ge040_alerta_fechamento_carga

type variables

end variables

on w_ge040_alerta_fechamento_carga.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.st_1=create st_1
this.cb_2=create cb_2
this.st_2=create st_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.gb_1
end on

on w_ge040_alerta_fechamento_carga.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.gb_1)
end on

type pb_help from dc_w_response`pb_help within w_ge040_alerta_fechamento_carga
end type

type cb_1 from commandbutton within w_ge040_alerta_fechamento_carga
integer x = 1134
integer y = 296
integer width = 283
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sim"
end type

event clicked;CloseWithReturn(Parent, 1)
end event

type st_1 from statictext within w_ge040_alerta_fechamento_carga
integer x = 55
integer y = 172
integer width = 1257
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 16777215
string text = "Deseja fechar o sistema CARGA?"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_ge040_alerta_fechamento_carga
integer x = 1440
integer y = 296
integer width = 283
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "N$$HEX1$$e300$$ENDHEX$$o"
end type

event clicked;CloseWithReturn(Parent, -1)
end event

type st_2 from statictext within w_ge040_alerta_fechamento_carga
integer x = 55
integer y = 84
integer width = 1664
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 16777215
string text = "Certifique-se de que n$$HEX1$$e300$$ENDHEX$$o exista(m) processo(s) em execu$$HEX2$$e700e300$$ENDHEX$$o."
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_ge040_alerta_fechamento_carga
integer x = 18
integer y = 4
integer width = 1710
integer height = 272
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 16777215
end type

