HA$PBExportHeader$w_ge252_escolhe_impressao_etiqueta.srw
forward
global type w_ge252_escolhe_impressao_etiqueta from dc_w_response
end type
type gb_1 from groupbox within w_ge252_escolhe_impressao_etiqueta
end type
type cb_selecionar from commandbutton within w_ge252_escolhe_impressao_etiqueta
end type
type cb_cancelar from commandbutton within w_ge252_escolhe_impressao_etiqueta
end type
type lb_tipos from listbox within w_ge252_escolhe_impressao_etiqueta
end type
end forward

global type w_ge252_escolhe_impressao_etiqueta from dc_w_response
integer width = 2542
integer height = 592
string title = "GE252 - Sele$$HEX2$$e700e300$$ENDHEX$$o do Tipo de Impress$$HEX1$$e300$$ENDHEX$$o da Eitqueta"
long backcolor = 80269524
gb_1 gb_1
cb_selecionar cb_selecionar
cb_cancelar cb_cancelar
lb_tipos lb_tipos
end type
global w_ge252_escolhe_impressao_etiqueta w_ge252_escolhe_impressao_etiqueta

type variables
st_parametros_impressao_etiqueta st_etiqueta
end variables

on w_ge252_escolhe_impressao_etiqueta.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.cb_selecionar=create cb_selecionar
this.cb_cancelar=create cb_cancelar
this.lb_tipos=create lb_tipos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.cb_selecionar
this.Control[iCurrent+3]=this.cb_cancelar
this.Control[iCurrent+4]=this.lb_tipos
end on

on w_ge252_escolhe_impressao_etiqueta.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.cb_selecionar)
destroy(this.cb_cancelar)
destroy(this.lb_tipos)
end on

type pb_help from dc_w_response`pb_help within w_ge252_escolhe_impressao_etiqueta
end type

type gb_1 from groupbox within w_ge252_escolhe_impressao_etiqueta
integer x = 46
integer y = 12
integer width = 2021
integer height = 460
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Tipo de impress$$HEX1$$e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type cb_selecionar from commandbutton within w_ge252_escolhe_impressao_etiqueta
integer x = 2117
integer y = 36
integer width = 375
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Selecionar"
boolean default = true
end type

event clicked;Choose Case lb_Tipos.SelectedItem ()
	case 'Papel A4'
		st_etiqueta.nome_dw    = 'dw_ge252_etiqueta_agrupamento'
		st_etiqueta.orientacao = 1
		
	case 'Etiqueta amarela'
		st_etiqueta.nome_dw    = 'dw_ge252_etiqueta_amarela_agrupamento'
		st_etiqueta.orientacao = 2
		
	case else
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o!', &
						'Selecione o tipo de impress$$HEX1$$e300$$ENDHEX$$o desejada!', &
						Exclamation!)
		Return 1
End choose

CloseWithReturn (Parent, st_etiqueta)
end event

type cb_cancelar from commandbutton within w_ge252_escolhe_impressao_etiqueta
integer x = 2117
integer y = 156
integer width = 375
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar "
end type

event clicked;SetNull (st_etiqueta.nome_dw)

CloseWithReturn (Parent, st_etiqueta)
end event

type lb_tipos from listbox within w_ge252_escolhe_impressao_etiqueta
integer x = 96
integer y = 80
integer width = 1920
integer height = 336
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"Papel A4","Etiqueta amarela"}
borderstyle borderstyle = stylelowered!
end type

