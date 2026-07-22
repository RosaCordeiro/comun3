HA$PBExportHeader$dc_w_selecao_lista_relatorio.srw
forward
global type dc_w_selecao_lista_relatorio from dc_w_sheet
end type
type gb_2 from groupbox within dc_w_selecao_lista_relatorio
end type
type gb_1 from groupbox within dc_w_selecao_lista_relatorio
end type
type dw_1 from dc_uo_dw_base within dc_w_selecao_lista_relatorio
end type
type dw_2 from dc_uo_dw_base within dc_w_selecao_lista_relatorio
end type
type dw_3 from dc_uo_dw_base within dc_w_selecao_lista_relatorio
end type
end forward

global type dc_w_selecao_lista_relatorio from dc_w_sheet
integer width = 2487
integer height = 1612
event ue_retrieve ( )
event type integer ue_preprint ( )
event ue_sort ( )
event ue_find ( )
event ue_filter ( )
event ue_clearfilter ( )
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
end type
global dc_w_selecao_lista_relatorio dc_w_selecao_lista_relatorio

type variables

end variables

event ue_retrieve;dw_2.Event ue_Retrieve()
end event

event ue_preprint;dw_3.Object.DataWindow.Table.Select = dw_2.Object.DataWindow.Table.Select

Return dw_3.RowCount()
end event

event ue_sort();dw_2.Event ue_Sort()
end event

event ue_find;dw_2.Event ue_Find()
end event

event ue_filter;dw_2.Event ue_Filter()
end event

event ue_clearfilter;dw_2.Event ue_ClearFilter()
end event

on dc_w_selecao_lista_relatorio.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.dw_3
end on

on dc_w_selecao_lista_relatorio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
end on

event ue_postopen;call super::ue_postopen;If dw_1.RowCount()=0 Then dw_1.Event ue_AddRow()

//Est$$HEX1$$e100$$ENDHEX$$ habilitado o Aux$$HEX1$$ed00$$ENDHEX$$lio Visual no INI ?
If gvo_aplicacao.ivb_usa_aux_visual Then 
	//Adiciona Linha DW
	If dw_visual.RowCount()=0 Then dw_visual.Event ue_AddRow()
	//Seta os valores de redimensionamento da tela para compatibilidade com telas redimensionam
	MaxWidth = This.Width
	MaxHeight = This.Height
	//Chama o redimensionamento da tela, onde est$$HEX1$$e100$$ENDHEX$$ tratado onde deve aparecer a DW
	This.Event Resize(0,MaxWidth - 72, MaxHeight)
	//Seta DW visivel
	gb_aux_visual.Visible = True
	dw_visual.Visible = True
End If

dw_1.SetFocus()

This.ivm_Menu.mf_Recuperar(True)
end event

event ue_print;call super::ue_print;Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas  = This.Event ue_PrePrint()

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		dw_3.Event ue_Print()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
	End If
End If

SetPointer(Arrow!)
end event

event ue_printimmediate;call super::ue_printimmediate;Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas  = This.Event ue_PrePrint()

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		dw_3.Event ue_PrintImmediate()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
	End If
End If

SetPointer(Arrow!)
end event

event resize;call super::resize;If MaxWidth > 0 Then
	//Ajusta a largura do GroupBox com a nova largura da tela - 30
	gb_2.Width = NewWidth - gb_2.X - 30
	//Ajusta a largura da Datawindow com a nova largura da tela - 80
	Dw_2.Width = NewWidth - Dw_2.X - 80
	//Ajusta a largura do GroupBox com a nova largura da tela - 30
	gb_aux_visual.X = gb_2.X
	gb_aux_visual.Width = gb_2.Width
	//Ajusta a largura da Datawindow com a nova largura da tela - 80
	dw_visual.X = Dw_2.X
	dw_visual.Width = Dw_2.Width
	If dw_visual.RowCount() > 0 Then dw_visual.Object.coluna.Width = dw_visual.Width - 20
End If

If MaxHeight > 0 Then
	If gvo_aplicacao.ivb_usa_aux_visual Then
		//Ajusta a altura do GroupBox com a nova altura da tela - altura dos filtros
		gb_2.Height = NewHeight - gb_2.Y - 180 - gb_aux_visual.Height
		//Ajusta a altura da Datawindow com a nova altura da tela - altura dos filtros
		Dw_2.Height 		= NewHeight - Dw_2.Y - 240 - gb_aux_visual.Height
		gb_aux_visual.Y	= Dw_2.Y + Dw_2.Height + 72
		dw_visual.Y			= gb_aux_visual.Y + 72
	Else
		//Ajusta a altura do GroupBox com a nova altura da tela - altura dos filtros
		gb_2.Height = NewHeight - gb_2.Y - 30
		//Ajusta a altura da Datawindow com a nova altura da tela - altura dos filtros
		Dw_2.Height = NewHeight - Dw_2.Y - 80
	End If
End If
end event

type dw_visual from dc_w_sheet`dw_visual within dc_w_selecao_lista_relatorio
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within dc_w_selecao_lista_relatorio
end type

type gb_2 from groupbox within dc_w_selecao_lista_relatorio
integer x = 37
integer y = 388
integer width = 1728
integer height = 772
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

type gb_1 from groupbox within dc_w_selecao_lista_relatorio
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

type dw_1 from dc_uo_dw_base within dc_w_selecao_lista_relatorio
integer x = 78
integer y = 84
integer width = 1659
integer height = 244
boolean bringtotop = true
end type

event itemchanged;call super::itemchanged;dw_2.Event ue_Reset()
end event

event editchanged;call super::editchanged;dw_2.Event ue_Reset()

end event

event constructor;call super::constructor;This.of_SetColSelection(True)
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

event ue_filter;//override
dw_2.Event ue_Filter()
end event

event ue_clearfilter;//override
dw_2.Event ue_ClearFilter()
end event

event itemfocuschanged;call super::itemfocuschanged;If gvo_aplicacao.ivb_usa_aux_visual Then
	wf_set_descricao_nao_visual('Filtro ' + This.of_Titulo_Coluna(Dwo.Name)+'.')
End If
end event

type dw_2 from dc_uo_dw_base within dc_w_selecao_lista_relatorio
integer x = 69
integer y = 464
integer width = 1659
integer height = 664
integer taborder = 20
boolean bringtotop = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.ShareData(dw_3)

This.of_SetRowSelection()

This.of_SetSort()
This.of_SetFilter()
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

Parent.ivm_Menu.mf_Classificar(lvb_Classificar)
Parent.ivm_Menu.mf_Filtrar(lvb_Filtrar)
Parent.ivm_Menu.mf_Localizar(lvb_Localizar)
Parent.ivm_Menu.mf_Imprimir(lvb_Imprimir)

Return pl_Linhas
end event

event ue_reset;call super::ue_reset;Parent.ivm_Menu.mf_Classificar(False)
Parent.ivm_Menu.mf_Filtrar(False)
Parent.ivm_Menu.mf_Localizar(False)
Parent.ivm_Menu.mf_Imprimir(False)
Parent.ivm_menu.mf_salvarcomo(False)
end event

event itemfocuschanged;call super::itemfocuschanged;If gvo_aplicacao.ivb_usa_aux_visual Then
	wf_set_descricao_nao_visual('Coluna ' + This.of_Titulo_Coluna(Dwo.Name)+'.')
End If
end event

type dw_3 from dc_uo_dw_base within dc_w_selecao_lista_relatorio
integer x = 1883
integer y = 244
integer width = 466
integer height = 248
integer taborder = 0
boolean bringtotop = true
boolean vscrollbar = true
boolean border = true
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;This.Visible = False
This.Modify("DataWindow.Print.Preview=Yes")
end event

event ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

event ue_preprint;//OverRide
String ls_Texto_Filtro_Existe

dw_2.ShareData( This ) // Compartilha os dados da dw_2 com a dw_3

ls_Texto_Filtro_Existe = This.Describe( "filtro_aplicado_t.Width" ) // Captura a largura do campo filtro_aplicado_t, apenas para testar se ele existe na dw

If ls_Texto_Filtro_Existe <> '!' Then // Verifica se o campo existe na dw
	If DW_2.ivo_Filter.ivs_Filtro_Traduzido <> "" And not IsNull(DW_2.ivo_Filter.ivs_Filtro_Traduzido) Then // Verifica se foi definido algum filtro (atrav$$HEX1$$e900$$ENDHEX$$s da menu Filtrar)
	/* Caso exista o campo texto [filtro_aplicado_t] na dw, o filtro aplicado ser$$HEX1$$e100$$ENDHEX$$ apresentado neste campo texto */
		This.Object.filtro_aplicado_t.Visible = True
		This.Object.filtro_aplicado_t.TEXT = "FILTRO APLICADO: " + DW_2.ivo_Filter.ivs_Filtro_Traduzido
	Else
		This.Object.filtro_aplicado_t.Visible = False
	End If
	
End If

Return SUPER::Event ue_PrePrint() // Executa o evento ancestral
end event

