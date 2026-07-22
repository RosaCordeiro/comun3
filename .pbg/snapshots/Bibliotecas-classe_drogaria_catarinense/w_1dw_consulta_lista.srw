HA$PBExportHeader$w_1dw_consulta_lista.srw
forward
global type w_1dw_consulta_lista from w_sheet
end type
type dw_1 from u_dw within w_1dw_consulta_lista
end type
type dw_2 from u_dw within w_1dw_consulta_lista
end type
end forward

global type w_1dw_consulta_lista from w_sheet
int Width=2281
int Height=1456
dw_1 dw_1
dw_2 dw_2
end type
global w_1dw_consulta_lista w_1dw_consulta_lista

type variables
Boolean ivb_Impressao = False


end variables

on w_1dw_consulta_lista.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
end on

on w_1dw_consulta_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event pfc_postopen;call super::pfc_postopen;SetPointer(HourGlass!)

// Recupera as informa$$HEX2$$e700f500$$ENDHEX$$es da DW
dw_1.Event pfc_Retrieve()
dw_1.SetFocus()

dw_1.ShareData(dw_2)
end event

event pfc_print;call super::pfc_print;Long lvl_Linhas

SetPointer(HourGlass!)

// Recupera as linhas conforme os par$$HEX1$$e200$$ENDHEX$$metros
// informados na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
lvl_Linhas = dw_2.RowCount()

// Verifica se foram encontradas as informa$$HEX2$$e700f500$$ENDHEX$$es
If lvl_Linhas > 0 Then
	// Executa o evento de impress$$HEX1$$e300$$ENDHEX$$o da PFC
	dw_2.Event pfc_Print()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem Informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!, Ok!)
End If

Return 0
end event

event pfc_printimmediate;call super::pfc_printimmediate;Long lvl_Linhas

SetPointer(HourGlass!)

// Recupera as linhas conforme os par$$HEX1$$e200$$ENDHEX$$metros
// informados na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
lvl_Linhas = dw_2.RowCount()

// Verifica se foram encontradas as informa$$HEX2$$e700f500$$ENDHEX$$es
If lvl_Linhas > 0 Then
	// Executa o evento de impress$$HEX1$$e300$$ENDHEX$$o da PFC
	dw_2.Event pfc_PrintImmediate()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!, Ok!)
End If

Return 0
end event

type dw_1 from u_dw within w_1dw_consulta_lista
int X=41
int Y=40
int Width=1243
int Height=936
int TabOrder=10
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event pfc_retrieve;call super::pfc_retrieve;SetPointer(HourGlass!)

Long lvl_Linha

// Recupera as informa$$HEX2$$e700f500$$ENDHEX$$es dw DW
lvl_Linha = This.Event Recuperar()

// Se recuperou alguma linha
If lvl_Linha > 0 Then
	// Habilita o menu de impress$$HEX1$$e300$$ENDHEX$$o
	If ivb_Impressao Then
		ivm_Menu_Janela.m_Arquivo.m_Imprimir.Enabled = True
		ivm_Menu_Janela.m_Arquivo.m_ImprimirImediato.Enabled = True
	End If
	
	// Se recuperou mais de uma linha
	// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es de classifica$$HEX2$$e700e300$$ENDHEX$$o, localiza$$HEX2$$e700e300$$ENDHEX$$o e filtro
	If lvl_Linha > 1 Then
		ivm_Menu_Janela.m_Editar.m_Classificar.Enabled = True
		ivm_Menu_Janela.m_Editar.m_Filtrar.Enabled     = True
		ivm_Menu_Janela.m_Editar.m_Localizar.Enabled   = True
	End If
Else
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!, Ok! )
	ivm_Menu_Janela.m_Arquivo.m_Imprimir.Enabled = False
	ivm_Menu_Janela.m_Arquivo.m_ImprimirImediato.Enabled = False
End If

Return lvl_Linha
end event

event recuperar;// Este evento est$$HEX1$$e100$$ENDHEX$$ programada na classe, pois a maioria das janelas
// far$$HEX1$$e300$$ENDHEX$$o retrieve sem nenhum par$$HEX1$$e200$$ENDHEX$$metro.

// Em caso de necessidade de retrieve espec$$HEX1$$ed00$$ENDHEX$$fico com par$$HEX1$$e200$$ENDHEX$$metros
// dever$$HEX1$$e100$$ENDHEX$$ ser programado no objeto descendente, executando o OVERRIDE.

SetPointer(HourGlass!)

Long lvl_Linha

// Recupera as informa$$HEX2$$e700f500$$ENDHEX$$es da DW
lvl_Linha = This.Retrieve()

Return lvl_linha
end event

event constructor;call super::constructor;// Desabilita o Update da DW
ib_IsUpdateAble = False

// Habilita a fun$$HEX2$$e700e300$$ENDHEX$$o de sele$$HEX2$$e700e300$$ENDHEX$$o de linhas
of_SetRowSelect(True)
end event

type dw_2 from u_dw within w_1dw_consulta_lista
int X=1595
int Y=148
int Width=453
int TabOrder=11
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event constructor;call super::constructor;This.Modify("DataWindow.Print.Preview=Yes")
end event

