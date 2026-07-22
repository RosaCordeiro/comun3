HA$PBExportHeader$w_ge224_qtde_volumes.srw
forward
global type w_ge224_qtde_volumes from dc_w_base
end type
type cb_2 from commandbutton within w_ge224_qtde_volumes
end type
type cb_1 from commandbutton within w_ge224_qtde_volumes
end type
type dw_1 from dc_uo_dw_base within w_ge224_qtde_volumes
end type
type gb_1 from groupbox within w_ge224_qtde_volumes
end type
end forward

global type w_ge224_qtde_volumes from dc_w_base
integer width = 951
integer height = 464
string title = "GE224 - Qtde Volumes"
boolean controlmenu = false
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge224_qtde_volumes w_ge224_qtde_volumes

event open;call super::open;dw_1.Event ue_AddRow()
end event

on w_ge224_qtde_volumes.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_ge224_qtde_volumes.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

type cb_2 from commandbutton within w_ge224_qtde_volumes
integer x = 558
integer y = 272
integer width = 352
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar"
end type

event clicked;CloseWithReturn(Parent, -1)
end event

type cb_1 from commandbutton within w_ge224_qtde_volumes
integer x = 23
integer y = 272
integer width = 338
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "OK"
end type

event clicked;Long ll_Qtde_Volumes

dw_1.AcceptText()

ll_Qtde_Volumes = dw_1.Object.qt_volumes[1]

If ll_Qtde_Volumes < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Quantidade inv$$HEX1$$e100$$ENDHEX$$lida!")
	Return -1
End If

CloseWithReturn(Parent, ll_Qtde_Volumes)
end event

type dw_1 from dc_uo_dw_base within w_ge224_qtde_volumes
integer x = 41
integer y = 100
integer width = 722
integer height = 108
string dataobject = "dw_ge224_qtde_volumes"
end type

type gb_1 from groupbox within w_ge224_qtde_volumes
integer x = 18
integer width = 896
integer height = 232
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

