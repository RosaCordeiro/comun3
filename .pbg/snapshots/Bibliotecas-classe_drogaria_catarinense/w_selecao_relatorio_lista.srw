HA$PBExportHeader$w_selecao_relatorio_lista.srw
forward
global type w_selecao_relatorio_lista from w_sheet
end type
type dw_selecao from u_dw within w_selecao_relatorio_lista
end type
type dw_relatorio from u_dw within w_selecao_relatorio_lista
end type
end forward

global type w_selecao_relatorio_lista from w_sheet
int Width=1765
int Height=1436
dw_selecao dw_selecao
dw_relatorio dw_relatorio
end type
global w_selecao_relatorio_lista w_selecao_relatorio_lista

on w_selecao_relatorio_lista.create
int iCurrent
call super::create
this.dw_selecao=create dw_selecao
this.dw_relatorio=create dw_relatorio
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_selecao
this.Control[iCurrent+2]=this.dw_relatorio
end on

on w_selecao_relatorio_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_selecao)
destroy(this.dw_relatorio)
end on

event pfc_print;Long lvl_Linhas

SetPointer(HourGlass!)

// Recupera as linhas conforme os par$$HEX1$$e200$$ENDHEX$$metros
// informados na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
lvl_Linhas = dw_Relatorio.Event pfc_Retrieve()

// Verifica se foram encontradas as informa$$HEX2$$e700f500$$ENDHEX$$es
If lvl_Linhas > 0 Then
	// Executa o evento de impress$$HEX1$$e300$$ENDHEX$$o da PFC
	dw_Relatorio.Event pfc_Print()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o do relat$$HEX1$$f300$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o localizadas.", Information!, Ok!)
End If

Return 0
end event

event pfc_printimmediate;Long lvl_Linhas

SetPointer(HourGlass!)

// Recupera as linhas conforme os par$$HEX1$$e200$$ENDHEX$$metros
// informados na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
lvl_Linhas = dw_Relatorio.Event pfc_Retrieve()

// Verifica se foram encontradas as informa$$HEX2$$e700f500$$ENDHEX$$es
If lvl_Linhas > 0 Then
	// Executa o evento de impress$$HEX1$$e300$$ENDHEX$$o da PFC
	dw_Relatorio.Event pfc_PrintImmediate()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o do relat$$HEX1$$f300$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o localizadas.", Information!, Ok!)
End If

Return 0
end event

event pfc_postopen;call super::pfc_postopen;SetPointer(HourGlass!)

// Recupera as linhas da DW de lista
dw_Selecao.Event pfc_Retrieve()
end event

type dw_selecao from u_dw within w_selecao_relatorio_lista
int X=82
int Y=64
int Width=1449
int Height=460
int TabOrder=10
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event pfc_retrieve;call super::pfc_retrieve;Long lvl_Linhas

SetPointer(HourGlass!)

// Recupera as linhas da DW de lista
lvl_Linhas = This.Event Recuperar()

If lvl_linhas > 0 Then
	// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es de localiza$$HEX2$$e700e300$$ENDHEX$$o, filtro e classifica$$HEX2$$e700e300$$ENDHEX$$o da DW
	ivm_Menu_Janela.m_Editar.m_Classificar.Enabled = True
	ivm_Menu_Janela.m_Editar.m_Filtrar.Enabled = True
	ivm_Menu_Janela.m_Editar.m_Localizar.Enabled = True

	// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es de impress$$HEX1$$e300$$ENDHEX$$o da DW
	ivm_Menu_Janela.m_Arquivo.m_Imprimir.Enabled = True
	ivm_Menu_Janela.m_Arquivo.m_ImprimirImediato.Enabled = True
		
	// Coloca o foco na DW de lista
	This.SetFocus()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informa$$HEX2$$e700f500$$ENDHEX$$es da lista de par$$HEX1$$e200$$ENDHEX$$metros n$$HEX1$$e300$$ENDHEX$$o localizada.", Information!, Ok!)
End If

Return lvl_Linhas
end event

event constructor;call super::constructor;// Habilita a sele$$HEX2$$e700e300$$ENDHEX$$o de linhas da DW
of_SetRowSelect(True)

// Desabilita o Update da DW
ib_IsUpdateAble = False
end event

type dw_relatorio from u_dw within w_selecao_relatorio_lista
int X=421
int Y=612
int TabOrder=11
boolean BringToTop=true
end type

event constructor;call super::constructor;// Desabilita o Update da DW
ib_IsUpdateAble = False

This.Modify("DataWindow.Print.Preview=Yes")
end event

