HA$PBExportHeader$w_ge367_inconsistencia_preco_abcfarma.srw
forward
global type w_ge367_inconsistencia_preco_abcfarma from dc_w_response
end type
type gb_1 from groupbox within w_ge367_inconsistencia_preco_abcfarma
end type
type dw_1 from dc_uo_dw_base within w_ge367_inconsistencia_preco_abcfarma
end type
type cb_fechar from commandbutton within w_ge367_inconsistencia_preco_abcfarma
end type
type cb_salvarcomo from commandbutton within w_ge367_inconsistencia_preco_abcfarma
end type
end forward

global type w_ge367_inconsistencia_preco_abcfarma from dc_w_response
integer width = 3968
integer height = 1864
string title = "GE367 - Inconsist$$HEX1$$ea00$$ENDHEX$$ncia de Pre$$HEX1$$e700$$ENDHEX$$os ABC Farma"
long backcolor = 80269524
gb_1 gb_1
dw_1 dw_1
cb_fechar cb_fechar
cb_salvarcomo cb_salvarcomo
end type
global w_ge367_inconsistencia_preco_abcfarma w_ge367_inconsistencia_preco_abcfarma

on w_ge367_inconsistencia_preco_abcfarma.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.dw_1=create dw_1
this.cb_fechar=create cb_fechar
this.cb_salvarcomo=create cb_salvarcomo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_fechar
this.Control[iCurrent+4]=this.cb_salvarcomo
end on

on w_ge367_inconsistencia_preco_abcfarma.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cb_fechar)
destroy(this.cb_salvarcomo)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Retrieve()
end event

type pb_help from dc_w_response`pb_help within w_ge367_inconsistencia_preco_abcfarma
end type

type gb_1 from groupbox within w_ge367_inconsistencia_preco_abcfarma
integer x = 23
integer width = 3904
integer height = 1652
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Produtos"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge367_inconsistencia_preco_abcfarma
integer x = 50
integer y = 48
integer width = 3858
integer height = 1576
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge367_lista_inconsistencia"
boolean vscrollbar = true
end type

event ue_postretrieve;If pl_Linhas > 0 Then
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe nenhuma inconsist$$HEX1$$ea00$$ENDHEX$$ncia.")
	End If
	
	cb_Fechar.SetFocus()
End If

Return pl_Linhas
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_fechar from commandbutton within w_ge367_inconsistencia_preco_abcfarma
integer x = 3584
integer y = 1668
integer width = 347
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Fechar"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_salvarcomo from commandbutton within w_ge367_inconsistencia_preco_abcfarma
integer x = 3003
integer y = 1668
integer width = 489
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Salvar E&xcel..."
end type

event clicked;dw_1.Event ue_SaveAs()
end event

