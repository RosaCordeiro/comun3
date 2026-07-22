HA$PBExportHeader$dc_w_lista_relatorio.srw
forward
global type dc_w_lista_relatorio from dc_w_sheet
end type
type dw_1 from dc_uo_dw_base within dc_w_lista_relatorio
end type
type gb_1 from groupbox within dc_w_lista_relatorio
end type
type dw_2 from dc_uo_dw_base within dc_w_lista_relatorio
end type
end forward

global type dc_w_lista_relatorio from dc_w_sheet
integer width = 2981
integer height = 1716
event type long ue_preprint ( )
dw_1 dw_1
gb_1 gb_1
dw_2 dw_2
end type
global dc_w_lista_relatorio dc_w_lista_relatorio

event ue_preprint;dw_2.Object.DataWindow.Table.Select = dw_1.Object.DataWindow.Table.Select

Return dw_2.RowCount()
end event

on dc_w_lista_relatorio.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.gb_1=create gb_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_2
end on

on dc_w_lista_relatorio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.dw_2)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Retrieve()
dw_1.SetFocus()

If gvo_aplicacao.ivb_usa_aux_visual Then 
	dw_visual.Event ue_AddRow()
	MaxWidth = This.Width
	MaxHeight = This.Height
	This.Event Resize(0,MaxWidth - 72, MaxHeight)
	gb_aux_visual.Visible = True
	dw_visual.Visible = True
End If

This.ivm_Menu.mf_Recuperar(True)
end event

event ue_print;Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas  = This.Event ue_PrePrint()

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		dw_2.Event ue_Print()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
	End If
End If

SetPointer(Arrow!)
end event

event ue_printimmediate;Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas  = This.Event ue_PrePrint()

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		dw_2.Event ue_PrintImmediate()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
	End If
End If

SetPointer(Arrow!)
end event

event ue_preopen;call super::ue_preopen;dw_2.Visible = False
end event

event resize;call super::resize;If MaxWidth > 0 Then
	//Ajusta a largura do GroupBox com a nova largura da tela - 30
	gb_1.Width = NewWidth - gb_1.X - 30
	//Ajusta a largura da Datawindow com a nova largura da tela - 80
	Dw_1.Width = NewWidth - Dw_1.X - 80
	//Ajusta a largura do GroupBox com a nova largura da tela - 30
	gb_aux_visual.X = gb_1.X
	gb_aux_visual.Width = gb_1.Width
	//Ajusta a largura da Datawindow com a nova largura da tela - 80
	dw_visual.X = Dw_1.X
	dw_visual.Width = Dw_1.Width
	If dw_visual.RowCount() > 0 Then dw_visual.Object.coluna.Width = dw_visual.Width - 20
End If

If MaxHeight > 0 Then
	If gvo_aplicacao.ivb_usa_aux_visual Then
		//Ajusta a altura do GroupBox com a nova altura da tela - altura dos filtros
		gb_1.Height = NewHeight - gb_1.Y - 180 - gb_aux_visual.Height
		//Ajusta a altura da Datawindow com a nova altura da tela - altura dos filtros
		Dw_1.Height 		= NewHeight - Dw_1.Y - 240 - gb_aux_visual.Height
		gb_aux_visual.Y	= Dw_1.Y + Dw_1.Height + 72
		dw_visual.Y			= gb_aux_visual.Y + 72
	Else
		//Ajusta a altura do GroupBox com a nova altura da tela - altura dos filtros
		gb_1.Height = NewHeight - gb_1.Y - 30
		//Ajusta a altura da Datawindow com a nova altura da tela - altura dos filtros
		Dw_1.Height = NewHeight - Dw_1.Y - 80
	End If
End If
end event

type dw_visual from dc_w_sheet`dw_visual within dc_w_lista_relatorio
integer y = 1376
integer height = 136
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within dc_w_lista_relatorio
integer y = 1304
integer height = 224
end type

type dw_1 from dc_uo_dw_base within dc_w_lista_relatorio
integer x = 82
integer y = 88
integer width = 2158
integer height = 1156
boolean bringtotop = true
boolean vscrollbar = true
end type

event ue_postretrieve;Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Imprimir

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	lvb_Imprimir = True

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

event constructor;call super::constructor;//ivb_Selecao_Linhas = True

This.of_SetRowSelection()

This.ShareData(dw_2)
end event

event itemfocuschanged;call super::itemfocuschanged;If gvo_aplicacao.ivb_usa_aux_visual Then
	wf_set_descricao_nao_visual('Coluna: ' + This.of_Titulo_Coluna(Dwo.Name))
End If
end event

type gb_1 from groupbox within dc_w_lista_relatorio
integer x = 37
integer y = 12
integer width = 2254
integer height = 1276
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type dw_2 from dc_uo_dw_base within dc_w_lista_relatorio
integer x = 2395
integer y = 84
integer taborder = 0
boolean bringtotop = true
end type

