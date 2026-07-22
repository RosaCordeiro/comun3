HA$PBExportHeader$dc_w_selecao_generica.srw
forward
global type dc_w_selecao_generica from dc_w_response
end type
type gb_2 from groupbox within dc_w_selecao_generica
end type
type gb_1 from groupbox within dc_w_selecao_generica
end type
type dw_1 from dc_uo_dw_base within dc_w_selecao_generica
end type
type dw_2 from dc_uo_dw_base within dc_w_selecao_generica
end type
type cb_selecionar from commandbutton within dc_w_selecao_generica
end type
type cb_cancelar from commandbutton within dc_w_selecao_generica
end type
type cb_pesquisar from commandbutton within dc_w_selecao_generica
end type
type st_mensagem from statictext within dc_w_selecao_generica
end type
end forward

global type dc_w_selecao_generica from dc_w_response
integer x = 567
integer y = 424
integer width = 2533
integer height = 1556
boolean controlmenu = false
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
cb_selecionar cb_selecionar
cb_cancelar cb_cancelar
cb_pesquisar cb_pesquisar
st_mensagem st_mensagem
end type
global dc_w_selecao_generica dc_w_selecao_generica

type variables
boolean ivb_pesquisa_direta = false
end variables

on dc_w_selecao_generica.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_selecionar=create cb_selecionar
this.cb_cancelar=create cb_cancelar
this.cb_pesquisar=create cb_pesquisar
this.st_mensagem=create st_mensagem
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_selecionar
this.Control[iCurrent+6]=this.cb_cancelar
this.Control[iCurrent+7]=this.cb_pesquisar
this.Control[iCurrent+8]=this.st_mensagem
end on

on dc_w_selecao_generica.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_selecionar)
destroy(this.cb_cancelar)
destroy(this.cb_pesquisar)
destroy(this.st_mensagem)
end on

event ue_postopen;call super::ue_postopen;If ivb_Pesquisa_Direta Then
	cb_Pesquisar.Event Clicked()
End If
end event

event open;call super::open;st_Mensagem.Text = ""

dw_1.Event ue_AddRow()
dw_1.SetFocus()
end event

type pb_help from dc_w_response`pb_help within dc_w_selecao_generica
end type

type gb_2 from groupbox within dc_w_selecao_generica
integer x = 32
integer y = 452
integer width = 2423
integer height = 832
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within dc_w_selecao_generica
integer x = 32
integer y = 12
integer width = 2423
integer height = 428
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Par$$HEX1$$e200$$ENDHEX$$metros de Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within dc_w_selecao_generica
integer x = 69
integer y = 80
integer width = 2341
integer height = 328
integer taborder = 20
boolean bringtotop = true
end type

event getfocus;call super::getfocus;cb_Pesquisar.Default = True
cb_Selecionar.Default = False
end event

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event itemchanged;call super::itemchanged;dw_2.Event ue_Reset()
end event

event editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

type dw_2 from dc_uo_dw_base within dc_w_selecao_generica
integer x = 69
integer y = 524
integer width = 2341
integer height = 732
integer taborder = 30
boolean bringtotop = true
boolean vscrollbar = true
end type

event ue_postretrieve;If pl_Linhas > 0 Then
	cb_Selecionar.Enabled = True
	This.SetRow(1)
	This.ScrollToRow(1)
	This.SetFocus()

	If pl_Linhas = 1 Then
		st_Mensagem.Text = "1 registro."
	Else
		st_Mensagem.Text = String(pl_Linhas, "###,###,##0") + " registros."
	End If
Else
	cb_Selecionar.Enabled = False
	dw_1.SetFocus()
	st_Mensagem.Text = "Nenhum registro encontrado."
End If

Return pl_Linhas
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event getfocus;call super::getfocus;cb_Pesquisar.Default = False
cb_Selecionar.Default = True
end event

type cb_selecionar from commandbutton within dc_w_selecao_generica
integer x = 1696
integer y = 1316
integer width = 370
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Selecionar"
boolean default = true
end type

event getfocus;This.Weight = 700
This.Default = True
end event

event losefocus;This.Weight = 400
This.Default = False
end event

type cb_cancelar from commandbutton within dc_w_selecao_generica
integer x = 2085
integer y = 1316
integer width = 370
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
boolean cancel = true
end type

event getfocus;This.Weight = 700
This.Default = True
end event

event losefocus;This.Weight = 400
This.Default = False
end event

type cb_pesquisar from commandbutton within dc_w_selecao_generica
integer x = 1253
integer y = 1316
integer width = 370
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Pesquisar"
end type

event clicked;dw_2.Event ue_Retrieve()
end event

event getfocus;This.Weight = 700
This.Default = True
end event

event losefocus;This.Weight = 400
This.Default = False
end event

type st_mensagem from statictext within dc_w_selecao_generica
integer x = 32
integer y = 1316
integer width = 1147
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Mensagem :"
boolean focusrectangle = false
end type

