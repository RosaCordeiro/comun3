HA$PBExportHeader$dc_w_selecao_lista_detalhe.srw
forward
global type dc_w_selecao_lista_detalhe from dc_w_sheet
end type
type gb_3 from groupbox within dc_w_selecao_lista_detalhe
end type
type gb_1 from groupbox within dc_w_selecao_lista_detalhe
end type
type gb_2 from groupbox within dc_w_selecao_lista_detalhe
end type
type dw_1 from dc_uo_dw_base within dc_w_selecao_lista_detalhe
end type
type dw_2 from dc_uo_dw_base within dc_w_selecao_lista_detalhe
end type
type dw_3 from dc_uo_dw_base within dc_w_selecao_lista_detalhe
end type
end forward

global type dc_w_selecao_lista_detalhe from dc_w_sheet
integer width = 1961
integer height = 1776
event ue_retrieve ( )
gb_3 gb_3
gb_1 gb_1
gb_2 gb_2
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
end type
global dc_w_selecao_lista_detalhe dc_w_selecao_lista_detalhe

event ue_retrieve;dw_2.Event ue_Retrieve()
end event

on dc_w_selecao_lista_detalhe.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.gb_1=create gb_1
this.gb_2=create gb_2
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.dw_3
end on

on dc_w_selecao_lista_detalhe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()
dw_1.SetFocus()

dw_1.ivo_Controle_Menu.of_Recuperar(True)
dw_2.ivo_Controle_Menu.of_Recuperar(True)
dw_3.ivo_Controle_Menu.of_Recuperar(True)
end event

type gb_3 from groupbox within dc_w_selecao_lista_detalhe
integer x = 37
integer y = 1084
integer width = 1728
integer height = 360
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Detalhes"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within dc_w_selecao_lista_detalhe
integer x = 37
integer y = 16
integer width = 1728
integer height = 360
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within dc_w_selecao_lista_detalhe
integer x = 37
integer y = 388
integer width = 1728
integer height = 672
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within dc_w_selecao_lista_detalhe
integer x = 73
integer y = 84
integer width = 1659
integer height = 244
boolean bringtotop = true
end type

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event editchanged;call super::editchanged;dw_2.Event ue_Reset()
dw_3.Event ue_Reset()
end event

event ue_sort;//override
dw_2.Event ue_Sort()
end event

event ue_saveas;//override
dw_2.Event ue_SaveAs()
end event

event ue_print;//override
dw_2.Event ue_Print()
end event

event ue_printimmediate;//override
dw_2.Event ue_PrintImmediate()
end event

event ue_clearfilter;//override
dw_2.Event ue_ClearFilter()
end event

event ue_filter;//override
dw_2.Event ue_Filter()
end event

type dw_2 from dc_uo_dw_base within dc_w_selecao_lista_detalhe
integer x = 69
integer y = 464
integer width = 1659
integer height = 564
integer taborder = 20
boolean bringtotop = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;//This.ivb_Selecao_Linhas = True

This.of_SetRowSelection()
end event

event ue_postretrieve;Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Imprimir

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	lvb_Imprimir = True
	
	This.Event RowFocusChanged(1)
	
	This.SetRow(1)
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

This.ivo_Controle_Menu.of_Classificar(lvb_Classificar)
This.ivo_Controle_Menu.of_Filtrar(lvb_Filtrar)
This.ivo_Controle_Menu.of_Localizar(lvb_Localizar)

This.ivo_Controle_Menu.of_Imprimir(lvb_Imprimir)
dw_1.ivo_Controle_Menu.of_Imprimir(lvb_Imprimir)
dw_2.ivo_Controle_Menu.of_Imprimir(lvb_Imprimir)

Return pl_Linhas
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	dw_3.Event ue_Retrieve()
End If
end event

type dw_3 from dc_uo_dw_base within dc_w_selecao_lista_detalhe
integer x = 78
integer y = 1152
integer width = 1659
integer height = 244
integer taborder = 30
boolean bringtotop = true
end type

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_postretrieve;Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Imprimir

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	lvb_Imprimir = True
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Detalhes n$$HEX1$$e300$$ENDHEX$$o localizados.", Information!)
	End If
End If

This.ivo_Controle_Menu.of_Classificar(lvb_Classificar)
This.ivo_Controle_Menu.of_Filtrar(lvb_Filtrar)
This.ivo_Controle_Menu.of_Localizar(lvb_Localizar)
This.ivo_Controle_Menu.of_Imprimir(lvb_Imprimir)

Return pl_Linhas
end event

