HA$PBExportHeader$w_ge204_sel_filial_grupo_semana.srw
forward
global type w_ge204_sel_filial_grupo_semana from dc_w_base
end type
type cb_2 from commandbutton within w_ge204_sel_filial_grupo_semana
end type
type cb_1 from commandbutton within w_ge204_sel_filial_grupo_semana
end type
type dw_1 from dc_uo_dw_base within w_ge204_sel_filial_grupo_semana
end type
type gb_1 from groupbox within w_ge204_sel_filial_grupo_semana
end type
end forward

global type w_ge204_sel_filial_grupo_semana from dc_w_base
integer x = 2199
integer y = 740
integer width = 768
integer height = 556
string title = "GE204 - Semana"
boolean controlmenu = false
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge204_sel_filial_grupo_semana w_ge204_sel_filial_grupo_semana

on w_ge204_sel_filial_grupo_semana.create
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

on w_ge204_sel_filial_grupo_semana.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;call super::open;dw_1.Event ue_AddRow()
end event

type cb_2 from commandbutton within w_ge204_sel_filial_grupo_semana
integer x = 32
integer y = 352
integer width = 334
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Confirmar"
end type

event clicked;String 	ls_Uf,&
			ls_Retorno

Long ll_Semana


dw_1.AcceptText()

ls_Uf			= dw_1.Object.de_uf			[1]
ll_Semana	= dw_1.Object.nr_semana	[1]

If IsNull(ll_Semana) or ll_Semana = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a Semana.")
	dw_1.Event ue_Pos(1, "nr_semana")
	Return 1
End If

If IsNull(ls_Uf) or ls_Uf = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a UF.")
	dw_1.Event ue_Pos(1, "de_uf")
	Return 1	
End If

ls_Retorno = ls_Uf + String(ll_Semana)

If IsNull(ls_Retorno) or ls_Retorno = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu erro ao retornar as informa$$HEX2$$e700f500$$ENDHEX$$es selecionadas.")
	dw_1.Event ue_Pos(1, "nr_semana")
	Return 1	
End If	

CloseWithReturn(Parent, ls_Retorno)
end event

type cb_1 from commandbutton within w_ge204_sel_filial_grupo_semana
integer x = 471
integer y = 352
integer width = 233
integer height = 92
integer taborder = 30
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

type dw_1 from dc_uo_dw_base within w_ge204_sel_filial_grupo_semana
integer x = 64
integer y = 72
integer width = 626
integer height = 168
integer taborder = 20
string dataobject = "dw_ge204_sel_filial_grupo_semana"
end type

event itemchanged;call super::itemchanged;DataWindowChild lvdwc

Long ll_Semana

String ls_Nulo

dw_1.AcceptText()

SetNull(ls_Nulo)

ll_Semana = dw_1.Object.nr_semana[row]
	
If dw_1.GetChild("de_uf", lvdwc) = 1 Then
	
	lvdwc.SetTransObject(SQLCA)
		
	lvdwc.Retrieve(ll_Semana)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild UF.")
End If

If Dwo.Name = "nr_semana" Then
	dw_1.Object.de_uf[row] = ls_Nulo
End If
end event

type gb_1 from groupbox within w_ge204_sel_filial_grupo_semana
integer x = 37
integer y = 12
integer width = 667
integer height = 264
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

