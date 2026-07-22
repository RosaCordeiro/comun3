HA$PBExportHeader$w_1dw_cadastro_lista.srw
forward
global type w_1dw_cadastro_lista from w_sheet
end type
type dw_1 from u_dw within w_1dw_cadastro_lista
end type
end forward

global type w_1dw_cadastro_lista from w_sheet
int Width=1842
int Height=1488
dw_1 dw_1
end type
global w_1dw_cadastro_lista w_1dw_cadastro_lista

on w_1dw_cadastro_lista.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_1dw_cadastro_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

event pfc_postopen;call super::pfc_postopen;SetPointer(HourGlass!)

// Recupera as informa$$HEX2$$e700f500$$ENDHEX$$es da DW
dw_1.Event pfc_Retrieve()
dw_1.SetFocus()

// Habilita o menu de inclus$$HEX1$$e300$$ENDHEX$$o conforme o n$$HEX1$$ed00$$ENDHEX$$vel de acesso do usu$$HEX1$$e100$$ENDHEX$$rio
wf_Habilita_Menu("I")

end event

event cancelar;SetPointer(HourGlass!)

// Chama o evento de cancelamento da DW
dw_1.Event Cancelar()
end event

type dw_1 from u_dw within w_1dw_cadastro_lista
int X=27
int Y=20
int Width=1623
int Height=1148
int TabOrder=10
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event constructor;call super::constructor;SetPointer(HourGlass!)

// Estabelece o tipo de a$$HEX2$$e700e300$$ENDHEX$$o no cancelamento
ivi_Tipo_Cancelar = RETRIEVE

// Habilita a fun$$HEX2$$e700e300$$ENDHEX$$o de sele$$HEX2$$e700e300$$ENDHEX$$o de linhas
of_SetRowSelect(True)
end event

event editchanged;call super::editchanged;// Habilita os menus de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento
ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = True
ivm_Menu_Janela.m_Editar.m_CancelarOperacao.Enabled = True
end event

event itemchanged;call super::itemchanged;// Habilita os menus de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento
ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = True
ivm_Menu_Janela.m_Editar.m_CancelarOperacao.Enabled = True
end event

event itemerror;call super::itemerror;// Passa pela valida$$HEX2$$e700e300$$ENDHEX$$o de erro p/ n$$HEX1$$e300$$ENDHEX$$o dar problema na inclus$$HEX1$$e300$$ENDHEX$$o do registro
Return 1
end event

event pfc_addrow;call super::pfc_addrow;SetPointer(HourGlass!)

// Se existir mais de uma linha na DW
If This.RowCount() > 1 Then
	// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es de classifica$$HEX2$$e700e300$$ENDHEX$$o, filtro e localiza$$HEX2$$e700e300$$ENDHEX$$o
	ivm_Menu_Janela.m_Editar.m_Classificar.Enabled = True
	ivm_Menu_Janela.m_Editar.m_Filtrar.Enabled = True
	ivm_Menu_Janela.m_Editar.m_Localizar.Enabled = True

	// Habilita o menu de exclus$$HEX1$$e300$$ENDHEX$$o conforme o n$$HEX1$$ed00$$ENDHEX$$vel de acesso do usu$$HEX1$$e100$$ENDHEX$$rio
	wf_Habilita_Menu("E")
End If

Return AncestorReturnValue
end event

event pfc_retrieve;call super::pfc_retrieve;SetPointer(HourGlass!)

Long lvl_Linha

// Recupera as informa$$HEX2$$e700f500$$ENDHEX$$es dw DW
lvl_Linha = This.Event Recuperar()

// Se recuperou alguma linha
If lvl_Linha > 0 Then
	// Se recuperou mais de uma linha
	// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es de classifica$$HEX2$$e700e300$$ENDHEX$$o, filtro e localiza$$HEX2$$e700e300$$ENDHEX$$o
	If lvl_Linha > 1 Then
		ivm_Menu_Janela.m_Editar.m_Classificar.Enabled = True
		ivm_Menu_Janela.m_Editar.m_Filtrar.Enabled = True
		ivm_Menu_Janela.m_Editar.m_Localizar.Enabled = True
	End If
	
	// Habilita o menu de exclus$$HEX1$$e300$$ENDHEX$$o conforme o n$$HEX1$$ed00$$ENDHEX$$vel de acesso do usu$$HEX1$$e100$$ENDHEX$$rio
	wf_Habilita_Menu("E")

	// Coloca o foco na primeira linha da DW
	This.SetRow(1)
	This.SetFocus()
Else
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!, Ok! )
End If

Return lvl_Linha
end event

event recuperar;// Este evento est$$HEX1$$e100$$ENDHEX$$ programada na classe, pois a maioria das janelas
// far$$HEX1$$e300$$ENDHEX$$o retrieve sem nenhum par$$HEX1$$e200$$ENDHEX$$metro.

// Em caso de necessidade de retrieve espec$$HEX1$$ed00$$ENDHEX$$fico com par$$HEX1$$e200$$ENDHEX$$metros
// dever$$HEX1$$e100$$ENDHEX$$ ser programado no objeto decendente, executando o OVERRIDE.

SetPointer(HourGlass!)

Long lvl_Linha

// Recupera as informa$$HEX2$$e700f500$$ENDHEX$$es da DW
lvl_Linha = This.Retrieve()

Return lvl_linha
end event

