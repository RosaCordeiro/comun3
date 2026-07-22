HA$PBExportHeader$w_lista_barra_selecao_vertical.srw
forward
global type w_lista_barra_selecao_vertical from w_sheet
end type
type dw_1 from u_dw within w_lista_barra_selecao_vertical
end type
type dw_2 from u_dw within w_lista_barra_selecao_vertical
end type
type dw_3 from u_dw within w_lista_barra_selecao_vertical
end type
type gb_3 from groupbox within w_lista_barra_selecao_vertical
end type
type gb_2 from groupbox within w_lista_barra_selecao_vertical
end type
type gb_1 from groupbox within w_lista_barra_selecao_vertical
end type
type uo_barra_selecao from uo_barra_selecao_vertical within w_lista_barra_selecao_vertical
end type
end forward

global type w_lista_barra_selecao_vertical from w_sheet
int Width=1435
int Height=1024
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
uo_barra_selecao uo_barra_selecao
end type
global w_lista_barra_selecao_vertical w_lista_barra_selecao_vertical

on w_lista_barra_selecao_vertical.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.uo_barra_selecao=create uo_barra_selecao
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.gb_3
this.Control[iCurrent+5]=this.gb_2
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.uo_barra_selecao
end on

on w_lista_barra_selecao_vertical.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.uo_barra_selecao)
end on

event pfc_postopen;call super::pfc_postopen;SetPointer(HourGlass!)

// Recupera as informa$$HEX2$$e700f500$$ENDHEX$$es da DW de sele$$HEX2$$e700e300$$ENDHEX$$o e da DW de lista

dw_1.Event pfc_Retrieve()
dw_2.Event pfc_Retrieve()

// Habilita o menu de inclus$$HEX1$$e300$$ENDHEX$$o

ivm_menu_janela.m_editar.m_incluir.Enabled = True
end event

event cancelar;SetPointer(HourGlass!)

// Chama o evento de cancelamento da DW

dw_3.Event Cancelar()

end event

type dw_1 from u_dw within w_lista_barra_selecao_vertical
int X=69
int Y=84
int TabOrder=10
boolean BringToTop=true
end type

event pfc_retrieve;call super::pfc_retrieve;SetPointer(HourGlass!)

Long lvl_linha

// Chama o evento recuperar da DW

lvl_linha = This.Event Recuperar()

// Se recuperou mais de uma linha, habilita o bot$$HEX1$$e300$$ENDHEX$$o de exclus$$HEX1$$e300$$ENDHEX$$o

If lvl_linha > 0 Then
	ivm_menu_janela.m_editar.m_excluir.Enabled = True
End If

Return lvl_linha
end event

event constructor;call super::constructor;SetPointer(HourGlass!)

// Habilita a fun$$HEX2$$e700e300$$ENDHEX$$o de sele$$HEX2$$e700e300$$ENDHEX$$o de linha

This.of_SetRowSelect(True)
end event

event rowfocuschanged;call super::rowfocuschanged;SetPointer(HourGlass!)

// Dispara o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o da DW de selecionadas

If This.RowCount() > 0 Then
	dw_3.Event pfc_Retrieve()
End If
end event

event rowfocuschanging;call super::rowfocuschanging;SetPointer(HourGlass!)

Integer lvi_retorno

// Verifica se houve mudan$$HEX1$$e700$$ENDHEX$$a na DW de selecionados, se sim n$$HEX1$$e300$$ENDHEX$$o deixa mudar sem salvar

If dw_3.ModifiedCount() > 0 or dw_3.DeletedCount() > 0 Then
	lvi_retorno = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Foram feitas altera$$HEX2$$e700f500$$ENDHEX$$es. Deseja salav$$HEX1$$e100$$ENDHEX$$-las?", Question!, YesNoCancel!, 3)
	CHOOSE CASE lvi_retorno
	CASE 1 // Salvar
		lvi_retorno = Parent.Event pfc_save()
	CASE 2 // N$$HEX1$$e300$$ENDHEX$$o salvar
		Return 0
	CASE 3 // N$$HEX1$$e300$$ENDHEX$$o trocar de linha
		Return 1
	END CHOOSE
End If

end event

event recuperar;SetPointer(HourGlass!)

// Recupera as informa$$HEX2$$e700f500$$ENDHEX$$es da DW

Return This.Retrieve()
end event

type dw_2 from u_dw within w_lista_barra_selecao_vertical
int X=87
int Y=480
int Height=252
int TabOrder=60
boolean BringToTop=true
end type

event pfc_retrieve;call super::pfc_retrieve;SetPointer(HourGlass!)

Long lvl_linha

// Chama o evento recuperar da DW

lvl_linha = This.Event Recuperar()

// Chama a fun$$HEX2$$e700e300$$ENDHEX$$o de habilita$$HEX2$$e700e300$$ENDHEX$$o dos bot$$HEX1$$f500$$ENDHEX$$es de sele$$HEX2$$e700e300$$ENDHEX$$o

uo_barra_selecao.of_Habilita()

Return lvl_linha
end event

event constructor;call super::constructor;SetPointer(HourGlass!)

// Marca a DW como n$$HEX1$$e300$$ENDHEX$$o atualiz$$HEX1$$e100$$ENDHEX$$vel

ib_isupdateable = False

// Habilita a fun$$HEX2$$e700e300$$ENDHEX$$o de sele$$HEX2$$e700e300$$ENDHEX$$o de linha

This.of_SetRowSelect(True)

// Estabelece o tipo de a$$HEX2$$e700e300$$ENDHEX$$o no cancelamento
ivi_Tipo_Cancelar = RETRIEVE


end event

type dw_3 from u_dw within w_lista_barra_selecao_vertical
int X=923
int Y=496
int TabOrder=30
boolean BringToTop=true
end type

event pfc_retrieve;call super::pfc_retrieve;SetPointer(HourGlass!)

Long lvl_linha

// Chama o evento recuperar da DW

lvl_linha = This.Event Recuperar()

// Chama a fun$$HEX2$$e700e300$$ENDHEX$$o de habilita$$HEX2$$e700e300$$ENDHEX$$o dos bot$$HEX1$$f500$$ENDHEX$$es de sele$$HEX2$$e700e300$$ENDHEX$$o

uo_barra_selecao.of_Habilita()

Return lvl_linha
end event

event constructor;call super::constructor;SetPointer(HourGlass!)

// Habilita a fun$$HEX2$$e700e300$$ENDHEX$$o de sele$$HEX2$$e700e300$$ENDHEX$$o de linha

This.of_SetRowSelect(True)

// Estabelece o tipo de a$$HEX2$$e700e300$$ENDHEX$$o no cancelamento
ivi_Tipo_Cancelar = RETRIEVE


end event

type gb_3 from groupbox within w_lista_barra_selecao_vertical
int X=846
int Y=420
int Width=494
int Height=360
int TabOrder=40
string Text="Selecionadas"
BorderStyle BorderStyle=StyleRaised!
long TextColor=8388608
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_lista_barra_selecao_vertical
int X=41
int Y=416
int Width=494
int Height=360
int TabOrder=50
string Text="Dispon$$HEX1$$ed00$$ENDHEX$$veis"
BorderStyle BorderStyle=StyleRaised!
long TextColor=8388608
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_lista_barra_selecao_vertical
int X=41
int Y=20
int Width=494
int Height=360
int TabOrder=20
string Text="Lista"
BorderStyle BorderStyle=StyleRaised!
long TextColor=8388608
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_barra_selecao from uo_barra_selecao_vertical within w_lista_barra_selecao_vertical
int X=617
int Y=420
int TabOrder=70
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long BackColor=79741120
end type

on uo_barra_selecao.destroy
call uo_barra_selecao_vertical::destroy
end on

event constructor;call super::constructor;SetPointer(HourGlass!)

idw_origem = dw_2
idw_destino = dw_3
end event

event deseleciona_todos;call super::deseleciona_todos;If AncestorReturnValue = -1 Then
	Return AncestorReturnValue
End If

// Habilita os menus de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento

ivm_menu_janela.m_editar.m_confirmaroperacao.Enabled = True
ivm_menu_janela.m_editar.m_cancelaroperacao.Enabled = True

If AncestorReturnValue > 0 Then
	// Se for uma DW atualiz$$HEX1$$e100$$ENDHEX$$vel, habilita a valida$$HEX2$$e700e300$$ENDHEX$$o do closequery da janela
	If idw_destino.of_GetUpdateable() Then
		Parent.Post Event Valida_CloseQuery(True)
	End If
End If

Return AncestorReturnValue
end event

event seleciona_todos;call super::seleciona_todos;SetPointer(HourGlass!)

// Habilita os menus de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento

ivm_menu_janela.m_editar.m_confirmaroperacao.Enabled = True
ivm_menu_janela.m_editar.m_cancelaroperacao.Enabled = True

Return AncestorReturnValue

end event

event seleciona_um;call super::seleciona_um;SetPointer(HourGlass!)

Long lvl_linha

If AncestorReturnValue < 1 Then
	Return AncestorReturnValue
End If

// Habilita os menus de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento

ivm_menu_janela.m_editar.m_confirmaroperacao.Enabled = True
ivm_menu_janela.m_editar.m_cancelaroperacao.Enabled = True

Return AncestorReturnValue
end event

event deseleciona_um;call super::deseleciona_um;// Habilita os menus de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento

ivm_menu_janela.m_editar.m_confirmaroperacao.Enabled = True
ivm_menu_janela.m_editar.m_cancelaroperacao.Enabled = True

If AncestorReturnValue > 0 Then
	// Se for uma DW atualiz$$HEX1$$e100$$ENDHEX$$vel, habilita a valida$$HEX2$$e700e300$$ENDHEX$$o do closequery da janela
	If idw_destino.of_GetUpdateable() Then
		Parent.Post Event Valida_CloseQuery(True)
	End If
End If

Return AncestorReturnValue

end event

