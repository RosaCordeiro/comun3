HA$PBExportHeader$w_ge331_localiza_st.srw
forward
global type w_ge331_localiza_st from dc_w_base
end type
type dw_1 from dc_uo_dw_base within w_ge331_localiza_st
end type
type cb_2 from commandbutton within w_ge331_localiza_st
end type
type cb_1 from commandbutton within w_ge331_localiza_st
end type
type gb_1 from groupbox within w_ge331_localiza_st
end type
end forward

global type w_ge331_localiza_st from dc_w_base
integer width = 1897
integer height = 444
boolean controlmenu = false
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
end type
global w_ge331_localiza_st w_ge331_localiza_st

on w_ge331_localiza_st.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_ge331_localiza_st.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;String ls_ST

ls_ST = Message.StringParm

dw_1.Object.cd_tributacao_icms[1]	= ls_ST
end event

event open;call super::open;dw_1.Event ue_AddRow()
end event

type dw_1 from dc_uo_dw_base within w_ge331_localiza_st
integer x = 50
integer y = 84
integer width = 1774
integer height = 108
integer taborder = 20
string dataobject = "dw_ge331_st"
end type

type cb_2 from commandbutton within w_ge331_localiza_st
integer x = 1019
integer y = 236
integer width = 402
integer height = 104
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Confirmar"
end type

event clicked;String ls_ST

dw_1.AcceptText()

ls_ST	 =	dw_1.Object.cd_tributacao_icms[1]

If isNull(ls_ST) or ls_ST = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma ST.")
	Return -1
End If

CloseWithReturn(Parent, ls_ST)
end event

type cb_1 from commandbutton within w_ge331_localiza_st
integer x = 1541
integer y = 236
integer width = 302
integer height = 104
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sair"
end type

event clicked;CloseWithReturn(Parent, "")
end event

type gb_1 from groupbox within w_ge331_localiza_st
integer x = 23
integer width = 1819
integer height = 208
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Situa$$HEX2$$e700e300$$ENDHEX$$o Tribut$$HEX1$$e100$$ENDHEX$$ria"
borderstyle borderstyle = styleraised!
end type

