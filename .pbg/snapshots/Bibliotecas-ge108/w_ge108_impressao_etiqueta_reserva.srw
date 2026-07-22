HA$PBExportHeader$w_ge108_impressao_etiqueta_reserva.srw
forward
global type w_ge108_impressao_etiqueta_reserva from dc_w_response
end type
type cb_1 from commandbutton within w_ge108_impressao_etiqueta_reserva
end type
type cb_2 from commandbutton within w_ge108_impressao_etiqueta_reserva
end type
type cb_3 from commandbutton within w_ge108_impressao_etiqueta_reserva
end type
type dw_1 from dc_uo_dw_base within w_ge108_impressao_etiqueta_reserva
end type
type gb_1 from groupbox within w_ge108_impressao_etiqueta_reserva
end type
end forward

global type w_ge108_impressao_etiqueta_reserva from dc_w_response
integer width = 1659
integer height = 544
string title = "GE108 - Impress$$HEX1$$e300$$ENDHEX$$o de Etiqueta"
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
dw_1 dw_1
gb_1 gb_1
end type
global w_ge108_impressao_etiqueta_reserva w_ge108_impressao_etiqueta_reserva

on w_ge108_impressao_etiqueta_reserva.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.gb_1
end on

on w_ge108_impressao_etiqueta_reserva.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()
end event

type pb_help from dc_w_response`pb_help within w_ge108_impressao_etiqueta_reserva
integer x = 402
integer y = 672
integer taborder = 0
end type

type cb_1 from commandbutton within w_ge108_impressao_etiqueta_reserva
integer x = 27
integer y = 328
integer width = 603
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Imprimir (T$$HEX1$$e900$$ENDHEX$$rmica)"
boolean default = true
end type

event clicked;CloseWithReturn(Parent,"TERMICA")
end event

type cb_2 from commandbutton within w_ge108_impressao_etiqueta_reserva
integer x = 645
integer y = 328
integer width = 535
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Imprimir (Laser)"
end type

event clicked;CloseWithReturn(Parent,"LASER")
end event

type cb_3 from commandbutton within w_ge108_impressao_etiqueta_reserva
integer x = 1193
integer y = 328
integer width = 434
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "N$$HEX1$$e300$$ENDHEX$$o Imprimir"
end type

event clicked;CloseWithReturn(Parent,"X")
end event

type dw_1 from dc_uo_dw_base within w_ge108_impressao_etiqueta_reserva
integer x = 59
integer y = 68
integer width = 1481
integer height = 184
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_ge108_impressora_etiqueta_reserva"
end type

type gb_1 from groupbox within w_ge108_impressao_etiqueta_reserva
integer x = 23
integer width = 1600
integer height = 296
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

