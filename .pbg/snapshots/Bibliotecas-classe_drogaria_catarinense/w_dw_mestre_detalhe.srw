HA$PBExportHeader$w_dw_mestre_detalhe.srw
forward
global type w_dw_mestre_detalhe from w_sheet
end type
type dw_mestre from u_dw within w_dw_mestre_detalhe
end type
type dw_detalhe from u_dw within w_dw_mestre_detalhe
end type
end forward

global type w_dw_mestre_detalhe from w_sheet
int Width=1870
int Height=1160
dw_mestre dw_mestre
dw_detalhe dw_detalhe
end type
global w_dw_mestre_detalhe w_dw_mestre_detalhe

type variables
// Vari$$HEX1$$e100$$ENDHEX$$veis utilizadas para determinar
// as chaves prim$$HEX1$$e100$$ENDHEX$$rias das tabelas mestre e detalhe
String ivs_Chave_Mestre[], &
          ivs_Chave_Detalhe[]

// Vari$$HEX1$$e100$$ENDHEX$$veis utilizadas para gerenciar 
// a habilita$$HEX2$$e700e300$$ENDHEX$$o das fun$$HEX2$$e700f500$$ENDHEX$$es do menu
// conforme a dw ativa
uo_Controle_Menu_dw ivo_Menu_dw1, &
                                      ivo_Menu_dw2
end variables

on w_dw_mestre_detalhe.create
int iCurrent
call super::create
this.dw_mestre=create dw_mestre
this.dw_detalhe=create dw_detalhe
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mestre
this.Control[iCurrent+2]=this.dw_detalhe
end on

on w_dw_mestre_detalhe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_mestre)
destroy(this.dw_detalhe)
end on

event pfc_postopen;call super::pfc_postopen;// Determina a ordem de execu$$HEX2$$e700e300$$ENDHEX$$o do pfc_Save() para os objetos
// Declara um array de objetos
PowerObject lvo_Objects[]

// Inicializa o array com os objetos
// que dever$$HEX1$$e300$$ENDHEX$$o fazer parte do pfc_Save com a ordem determinada
lvo_Objects = {dw_Mestre, dw_Detalhe}

of_SetUpdateObjects(lvo_Objects)

// Coloca o foco na DW mestre
dw_Mestre.SetFocus()
end event

event pfc_preopen;call super::pfc_preopen;SetPointer(HourGlass!)

// Insere uma linha na DW mestre
//dw_Mestre.Reset()
dw_Mestre.Event pfc_AddRow()

// Insere uma linha na DW de detalhes
dw_Detalhe.Event pfc_AddRow()
end event

type dw_mestre from u_dw within w_dw_mestre_detalhe
int X=32
int Y=28
int Width=1774
int Height=376
int TabOrder=10
boolean BringToTop=true
string DataObject="dw_mestre"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
end type

event getfocus;call super::getfocus;// Desabilita os menus
ivm_Menu_Janela.m_Editar.m_Incluir.Enabled = False
ivm_Menu_Janela.m_Editar.m_Excluir.Enabled = False
ivm_Menu_Janela.m_Editar.m_Classificar.Enabled = False
ivm_Menu_Janela.m_Editar.m_Filtrar.Enabled = False
ivm_Menu_Janela.m_Editar.m_Localizar.Enabled = False
end event

type dw_detalhe from u_dw within w_dw_mestre_detalhe
int X=32
int Y=464
int Width=1774
int Height=376
int TabOrder=20
boolean BringToTop=true
string DataObject="dw_detalhe"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event pfc_preupdate;call super::pfc_preupdate;Integer lvi_Tamanho_Chave_Mestre, &
        lvi_Tamanho_Chave_Detalhe, &
		  lvi_Total_Linhas_Detalhe, &
        lvi_Linha_Detalhe, &
		  lvi_Coluna_Chave

String lvs_Coluna_Mestre, &
       lvs_Coluna_Detalhe

Any lvany_Valor_Coluna

// Verifica se as chaves das DWs mestre e detalhe foram definidas
// Caso n$$HEX1$$e300$$ENDHEX$$o estejam retorna erro e aborta o pfc_Save()
lvi_Tamanho_Chave_Mestre  = UpperBound(ivs_Chave_Mestre)
lvi_Tamanho_Chave_Detalhe = UpperBound(ivs_Chave_Detalhe)

If lvi_Tamanho_Chave_Mestre = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Defina a chave prim$$HEX1$$e100$$ENDHEX$$ria da tabela mestre.", Information!, Ok!)
	Return -1
End If

If lvi_Tamanho_Chave_Detalhe = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Defina a chave prim$$HEX1$$e100$$ENDHEX$$ria da tabela detalhe.", Information!, Ok!)
	Return -1
End If

// Verifica se o n$$HEX1$$fa00$$ENDHEX$$mero de colunas chave das DWs s$$HEX1$$e300$$ENDHEX$$o iguais
If lvi_Tamanho_Chave_Mestre <> lvi_Tamanho_Chave_Detalhe Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O n$$HEX1$$fa00$$ENDHEX$$mero de colunas chave das tabelas mestre e detalhes devem ser iguais.", Information!, Ok!)
	Return -1
End If

// Verifica quantas linhas existem na DW de detalhes
lvi_Total_Linhas_Detalhe = This.RowCount()

// Atualiza as colunas chaves da DW detalhe
// com os valores chave da DW mestre

For lvi_Coluna_Chave = 1 To lvi_Tamanho_Chave_Mestre
	// Verifica o nome das colunas na DW mestre e detalhe
	lvs_Coluna_Mestre  = ivs_Chave_Mestre[lvi_Coluna_Chave]
	lvs_Coluna_Detalhe = ivs_Chave_Detalhe[lvi_Coluna_Chave]
	
	// Verifica o valor da coluna na DW mestre
	lvany_Valor_Coluna = gf_Valor_Coluna_DW(dw_Mestre, 1, lvs_Coluna_Mestre)
	
	// Loop para atualizar as linhas na DW detalhe
	For lvi_Linha_Detalhe = 1 To lvi_Total_Linhas_Detalhe
		This.SetItem(lvi_Linha_Detalhe, lvs_Coluna_Detalhe, lvany_Valor_Coluna)
	Next
Next

// Retorna sucesso
Return 1
end event

event pfc_addrow;call super::pfc_addrow;SetPointer(HourGlass!)

// Habilita a fun$$HEX2$$e700e300$$ENDHEX$$o de exclus$$HEX1$$e300$$ENDHEX$$o
ivm_Menu_Janela.m_Editar.m_Excluir.Enabled = True
	
// Se existir mais de uma linha na DW
If This.RowCount() > 1 Then
	// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es de classifica$$HEX2$$e700e300$$ENDHEX$$o, filtro e localiza$$HEX2$$e700e300$$ENDHEX$$o
	ivm_Menu_Janela.m_Editar.m_Classificar.Enabled = True
	ivm_Menu_Janela.m_Editar.m_Filtrar.Enabled = True
	ivm_Menu_Janela.m_Editar.m_Localizar.Enabled = True
End If

Return AncestorReturnValue
end event

event getfocus;call super::getfocus;// Habilita a fun$$HEX2$$e700e300$$ENDHEX$$o de inclus$$HEX1$$e300$$ENDHEX$$o
ivm_Menu_Janela.m_Editar.m_Incluir.Enabled = True
	
// Se existir alguma linha na DW
If This.RowCount() > 0 Then
	// Habilita a fun$$HEX2$$e700e300$$ENDHEX$$o de exclus$$HEX1$$e300$$ENDHEX$$o
	ivm_Menu_Janela.m_Editar.m_Excluir.Enabled = True
End If

// Se existir mais de uma linha na DW
If This.RowCount() > 1 Then
	// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es de classifica$$HEX2$$e700e300$$ENDHEX$$o, filtro e localiza$$HEX2$$e700e300$$ENDHEX$$o
	ivm_Menu_Janela.m_Editar.m_Classificar.Enabled = True
	ivm_Menu_Janela.m_Editar.m_Filtrar.Enabled = True
	ivm_Menu_Janela.m_Editar.m_Localizar.Enabled = True
End If
end event

event constructor;call super::constructor;// Habilita a sele$$HEX2$$e700e300$$ENDHEX$$o de linhas da DW
of_SetRowSelect(True)
end event

