HA$PBExportHeader$dc_w_2tab_cadastro_selecao_lista_det.srw
forward
global type dc_w_2tab_cadastro_selecao_lista_det from dc_w_sheet
end type
type tab_1 from tab within dc_w_2tab_cadastro_selecao_lista_det
end type
type tabpage_1 from userobject within tab_1
end type
type gb_2 from groupbox within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type dw_2 from dc_uo_dw_base within tabpage_1
end type
type tabpage_1 from userobject within tab_1
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
end type
type tabpage_2 from userobject within tab_1
end type
type gb_3 from groupbox within tabpage_2
end type
type dw_3 from dc_uo_dw_base within tabpage_2
end type
type tabpage_2 from userobject within tab_1
gb_3 gb_3
dw_3 dw_3
end type
type tab_1 from tab within dc_w_2tab_cadastro_selecao_lista_det
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type dc_w_2tab_cadastro_selecao_lista_det from dc_w_sheet
integer width = 2647
integer height = 1664
event ue_retrieve ( )
event ue_addrow ( )
tab_1 tab_1
end type
global dc_w_2tab_cadastro_selecao_lista_det dc_w_2tab_cadastro_selecao_lista_det

type variables
long ivl_altura_1, &
        ivl_altura_2, &
        ivl_largura_1, &
        ivl_largura_2

boolean ivb_inclusao
end variables

forward prototypes
public subroutine wf_set_somente_consulta ()
end prototypes

event ue_retrieve;Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
end event

event ue_addrow;Tab_1.TabPage_2.dw_3.Event ue_AddRow()
end event

public subroutine wf_set_somente_consulta ();Tab_1.Tabpage_2.dw_3.of_set_somente_leitura(This.ivm_Menu.ivb_permite_alterar)
end subroutine

on dc_w_2tab_cadastro_selecao_lista_det.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on dc_w_2tab_cadastro_selecao_lista_det.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]
lvo_Update = {Tab_1.TabPage_2.dw_3}
This.wf_SetUpdate_DW(lvo_Update)

Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Recuperar(True)
Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Recuperar(True)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Recuperar(False)

Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Incluir(True)
Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Incluir(True)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Incluir(True)

Tab_1.TabPage_1.dw_1.Event ue_AddRow()
Tab_1.TabPage_1.dw_1.SetFocus()
end event

event ue_preopen;call super::ue_preopen;//This.ivl_Altura_1  = This.Height
//This.ivl_Largura_1 = This.Width
end event

event ue_cancel;call super::ue_cancel;Tab_1.TabPage_1.dw_1.Event ue_Cancel()
Tab_1.TabPage_1.dw_2.Event ue_Cancel()
Tab_1.TabPage_2.dw_3.Event ue_Cancel()
end event

event open;call super::open;If IsValid( This ) Then
	Tab_1.TabPage_1.dw_1.of_SetMenu(This.ivm_Menu)
	Tab_1.TabPage_1.dw_2.of_SetMenu(This.ivm_Menu)
	Tab_1.TabPage_2.dw_3.of_SetMenu(This.ivm_Menu)
End If
end event

type tab_1 from tab within dc_w_2tab_cadastro_selecao_lista_det
integer x = 9
integer y = 8
integer width = 2533
integer height = 1444
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanging;SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		If wf_Valida_Salva() > 0 Then
			If Tab_1.TabPage_1.dw_2.RowCount() > 0 Then Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
			Return 0
		Else
			Return 1
		End If		
	Case 2
		If Not Parent.ivb_Inclusao Then
			If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
				// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas das DW's de detalhes
				Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
		
				// Permite a troca do folder
				Return 0
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
				// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
				Return 1
			End If
		End If
End Choose

SetPointer(Arrow!)
end event

event selectionchanged;SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		This.Width  = Parent.ivl_Largura_1
		This.Height = Parent.ivl_Altura_1
		
		Tab_1.TabPage_1.dw_2.SetFocus()
	Case 2
		This.Width  = Parent.ivl_Largura_2		
		This.Height = Parent.ivl_Altura_2
		
		Tab_1.TabPage_2.dw_3.SetFocus()
		Parent.ivb_Inclusao = False
End Choose
	
Parent.Width  = This.Width + This.X + 75	
Parent.Height = This.Height + This.Y + 155		

SetPointer(Arrow!)
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2496
integer height = 1328
long backcolor = 79741120
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
end type

on tabpage_1.create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.gb_2,&
this.gb_1,&
this.dw_1,&
this.dw_2}
end on

on tabpage_1.destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

type gb_2 from groupbox within tabpage_1
integer x = 23
integer y = 384
integer width = 2446
integer height = 912
integer taborder = 20
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

type gb_1 from groupbox within tabpage_1
integer x = 23
integer y = 12
integer width = 2446
integer height = 360
integer taborder = 20
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

type dw_1 from dc_uo_dw_base within tabpage_1
integer x = 73
integer y = 84
integer width = 2363
integer height = 252
integer taborder = 20
boolean bringtotop = true
end type

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event constructor;call super::constructor;This.ivi_Tipo_Cancelar = ADDROW
end event

type dw_2 from dc_uo_dw_base within tabpage_1
integer x = 64
integer y = 464
integer width = 2363
integer height = 800
integer taborder = 30
boolean bringtotop = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.ivi_Tipo_Cancelar = RESET

//This.ivb_Selecao_Linhas = True

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

	This.SetRow(1)
	This.Event RowFocusChanged(1)
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

ivm_Menu.mf_Classificar(lvb_Classificar)
ivm_Menu.mf_Filtrar(lvb_Filtrar)
ivm_Menu.mf_Localizar(lvb_Localizar)
ivm_Menu.mf_Imprimir(lvb_Imprimir)

Return pl_Linhas
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_preretrieve;call super::ue_preretrieve;Tab_1.TabPage_1.dw_1.AcceptText()

Return 1
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2496
integer height = 1328
long backcolor = 79741120
string text = "Detalhes"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_3 gb_3
dw_3 dw_3
end type

on tabpage_2.create
this.gb_3=create gb_3
this.dw_3=create dw_3
this.Control[]={this.gb_3,&
this.dw_3}
end on

on tabpage_2.destroy
destroy(this.gb_3)
destroy(this.dw_3)
end on

type gb_3 from groupbox within tabpage_2
integer x = 23
integer y = 12
integer width = 2446
integer height = 1288
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Detalhes"
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within tabpage_2
integer x = 69
integer y = 76
integer width = 2363
integer height = 1192
integer taborder = 30
boolean bringtotop = true
end type

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_postretrieve;Boolean lvb_Ok = False

If pl_Linhas > 0 Then
	lvb_Ok = True
	
	This.ScrollToRow(1)
	This.SetRow(1)
	This.SetFocus()
	
	This.ivi_Tipo_Cancelar = RETRIEVE
ElseIf pl_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
End If

This.ivo_Controle_Menu.of_Excluir(lvb_Ok)

ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)

Return pl_Linhas
end event

event editchanged;call super::editchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Cancelar(True)
End If
end event

event itemchanged;call super::itemchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Cancelar(True)
End If
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	ivb_Inclusao = True
	
	Tab_1.SelectTab(2)
	This.ivi_Tipo_Cancelar = ADDROW
	This.ivo_Controle_Menu.of_Excluir(False)
	
	ivm_Menu.mf_Confirmar(False)
	ivm_Menu.mf_Cancelar(False)
End If

Return AncestorReturnValue
end event

event ue_deleterow;call super::ue_deleterow;Integer lvi_Retorno

If AncestorReturnValue Then
	ivi_Tipo_Cancelar = ADDROW
	lvi_Retorno = Event ue_Save()
	
	If lvi_Retorno > 0 Then
		This.Event ue_Cancel()
	End If
End If

Return AncestorReturnValue
end event

event ue_preinsertrow;call super::ue_preinsertrow;If wf_Valida_Salva() > 0 Then
	This.Reset()
	Return 1
Else
	Return -1
End If
end event

