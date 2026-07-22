HA$PBExportHeader$dc_w_cadastro_selecao_lista.srw
forward
global type dc_w_cadastro_selecao_lista from dc_w_sheet
end type
type dw_1 from dc_uo_dw_base within dc_w_cadastro_selecao_lista
end type
type gb_2 from groupbox within dc_w_cadastro_selecao_lista
end type
type gb_1 from groupbox within dc_w_cadastro_selecao_lista
end type
type dw_2 from dc_uo_dw_base within dc_w_cadastro_selecao_lista
end type
end forward

global type dc_w_cadastro_selecao_lista from dc_w_sheet
integer width = 2848
integer height = 1480
long backcolor = 80269524
event ue_retrieve ( )
event ue_addrow ( )
dw_1 dw_1
gb_2 gb_2
gb_1 gb_1
dw_2 dw_2
end type
global dc_w_cadastro_selecao_lista dc_w_cadastro_selecao_lista

forward prototypes
public subroutine wf_set_somente_consulta ()
end prototypes

event ue_retrieve;dw_2.Event ue_Retrieve()
end event

event ue_addrow;dw_2.Event ue_AddRow()
end event

public subroutine wf_set_somente_consulta ();dw_2.of_set_somente_leitura(This.ivm_Menu.ivb_permite_alterar)
end subroutine

on dc_w_cadastro_selecao_lista.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.dw_2
end on

on dc_w_cadastro_selecao_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_2)
end on

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_2}
This.wf_SetUpdate_DW(lvo_Update)

dw_1.Event ue_AddRow()

This.ivm_Menu.mf_Incluir(True)
This.ivm_Menu.mf_Recuperar(True)

//Est$$HEX1$$e100$$ENDHEX$$ habilitado o Aux$$HEX1$$ed00$$ENDHEX$$lio Visual no INI ?
If gvo_aplicacao.ivb_usa_aux_visual Then 
	//Adiciona Linha DW
	If dw_visual.RowCount() = 0 Then dw_visual.Event ue_AddRow()
	//Seta os valores de redimensionamento da tela para compatibilidade com telas redimensionam
	MaxWidth = This.Width
	MaxHeight = This.Height
	//Chama o redimensionamento da tela, onde est$$HEX1$$e100$$ENDHEX$$ tratado onde deve aparecer a DW
	This.Event Resize(0,MaxWidth - 72, MaxHeight)
	//Seta DW visivel
	gb_aux_visual.Visible = True
	dw_visual.Visible = True
	
	Yield()
End If

dw_1.SetFocus()


end event

event ue_cancel;call super::ue_cancel;//Caso necessite na tela filha que efetue o reset, addrow ou retrieve
// altere o ivi_tipo_cancelar da DW, ao inv$$HEX1$$e900$$ENDHEX$$s de fixar na tela pai
dw_1.Event ue_Cancel()
dw_2.Event ue_Cancel()

dw_1.SetFocus()
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

type dw_visual from dc_w_sheet`dw_visual within dc_w_cadastro_selecao_lista
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within dc_w_cadastro_selecao_lista
end type

type dw_1 from dc_uo_dw_base within dc_w_cadastro_selecao_lista
integer x = 82
integer y = 84
integer width = 1321
integer height = 168
boolean bringtotop = true
end type

event constructor;call super::constructor;ivi_Tipo_Cancelar = ADDROW
end event

event itemfocuschanged;call super::itemfocuschanged;If gvo_aplicacao.ivb_usa_aux_visual Then
	wf_set_descricao_nao_visual('Filtro ' + This.of_Titulo_Coluna(Dwo.Name))
End If
end event

event getfocus;call super::getfocus;This.ivm_Menu.mf_Excluir(False)

If gvo_aplicacao.ivb_usa_aux_visual Then
	wf_set_descricao_nao_visual('Filtro ' + This.of_Titulo_Coluna(This.GetColumnName( )))
End If
end event

type gb_2 from groupbox within dc_w_cadastro_selecao_lista
integer x = 37
integer y = 300
integer width = 2743
integer height = 980
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within dc_w_cadastro_selecao_lista
integer x = 37
integer y = 8
integer width = 1390
integer height = 276
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

type dw_2 from dc_uo_dw_base within dc_w_cadastro_selecao_lista
integer x = 82
integer y = 376
integer width = 2647
integer height = 860
integer taborder = 20
boolean bringtotop = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;ivi_Tipo_Cancelar = RESET

//ivb_Selecao_Linhas = True

This.of_SetRowSelection()
end event

event editchanged;call super::editchanged;Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)

end event

event itemchanged;call super::itemchanged;Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)
end event

event ue_postretrieve;Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Excluir

If pl_Linhas > 0 Then
	lvb_Classificar	= IsValid(This.ivo_Sort)
	lvb_Filtrar		= IsValid(This.ivo_Filter)
	lvb_Localizar	= IsValid(This.ivo_Find)
	
	lvb_Excluir = True

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
Parent.ivm_Menu.mf_Excluir(lvb_Excluir)

Return pl_Linhas
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	Parent.ivm_Menu.mf_Excluir(True)
End If

Return AncestorReturnValue
end event

event itemfocuschanged;call super::itemfocuschanged;If gvo_aplicacao.ivb_usa_aux_visual Then
	wf_set_descricao_nao_visual('Coluna ' + This.of_Titulo_Coluna(Dwo.Name)+'.')
End If
end event

event getfocus;call super::getfocus;If This.RowCount() > 0 Then
	This.ivm_Menu.mf_Excluir(True)
End If
end event

