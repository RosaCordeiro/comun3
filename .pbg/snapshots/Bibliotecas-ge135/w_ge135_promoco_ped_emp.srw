HA$PBExportHeader$w_ge135_promoco_ped_emp.srw
forward
global type w_ge135_promoco_ped_emp from dc_w_response
end type
type cb_1 from commandbutton within w_ge135_promoco_ped_emp
end type
type cb_2 from commandbutton within w_ge135_promoco_ped_emp
end type
end forward

global type w_ge135_promoco_ped_emp from dc_w_response
integer width = 850
integer height = 360
string title = "GE135 - Consulta"
boolean controlmenu = false
cb_1 cb_1
cb_2 cb_2
end type
global w_ge135_promoco_ped_emp w_ge135_promoco_ped_emp

on w_ge135_promoco_ped_emp.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
end on

on w_ge135_promoco_ped_emp.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
end on

type pb_help from dc_w_response`pb_help within w_ge135_promoco_ped_emp
end type

type cb_1 from commandbutton within w_ge135_promoco_ped_emp
integer x = 41
integer y = 12
integer width = 759
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Hist. Pedido Empurrado"
end type

event clicked;CloseWithReturn(Parent, 'PED')
end event

type cb_2 from commandbutton within w_ge135_promoco_ped_emp
integer x = 41
integer y = 140
integer width = 759
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Promo$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;CloseWithReturn(Parent, 'PRO')
end event

