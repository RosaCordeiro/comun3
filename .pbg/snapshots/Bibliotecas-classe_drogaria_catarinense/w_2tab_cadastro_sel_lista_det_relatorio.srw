HA$PBExportHeader$w_2tab_cadastro_sel_lista_det_relatorio.srw
forward
global type w_2tab_cadastro_sel_lista_det_relatorio from w_sheet
end type
type tab_1 from tab within w_2tab_cadastro_sel_lista_det_relatorio
end type
type tabpage_1 from userobject within tab_1
end type
type gb_2 from groupbox within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type dw_1 from u_dw within tabpage_1
end type
type dw_2 from u_dw within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_3 from u_dw within tabpage_2
end type
type dw_4 from u_dw within w_2tab_cadastro_sel_lista_det_relatorio
end type
type tabpage_1 from userobject within tab_1
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
end type
type tabpage_2 from userobject within tab_1
dw_3 dw_3
end type
type tab_1 from tab within w_2tab_cadastro_sel_lista_det_relatorio
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_2tab_cadastro_sel_lista_det_relatorio from w_sheet
int Width=2473
event pfc_addrow ( )
event type long preparar_impressao ( )
tab_1 tab_1
dw_4 dw_4
end type
global w_2tab_cadastro_sel_lista_det_relatorio w_2tab_cadastro_sel_lista_det_relatorio

type variables
// Indica como ocorreu a mudan$$HEX1$$e700$$ENDHEX$$a de folder
// Via AddRow ou Detalhes
Boolean ivb_AddRow

// Vari$$HEX1$$e100$$ENDHEX$$veis utilizadas para gerenciar a mudan$$HEX1$$e700$$ENDHEX$$a de 
// tamanho dos folders
Long ivl_Largura_1, &
         ivl_Altura_1, &
         ivl_Largura_2, &
         ivl_Altura_2

// Indica onde ser$$HEX1$$e100$$ENDHEX$$ dado o insertrow
BOOLEAN	ivb_insere_dw2
BOOLEAN	ivb_insere_dw3

// Vari$$HEX1$$e100$$ENDHEX$$veis utilizadas para gerenciar 
// a habilita$$HEX2$$e700e300$$ENDHEX$$o das fun$$HEX2$$e700f500$$ENDHEX$$es do menu
// conforme a dw ativa
uo_Controle_Menu_dw ivo_Menu_dw1, &
                                     ivo_Menu_dw2, &
                                     ivo_Menu_dw3


// Vari$$HEX1$$e100$$ENDHEX$$vel para gerenciar as linhas de detalhe
// alteradas ou inclu$$HEX1$$ed00$$ENDHEX$$das
Boolean ivb_Update_Detalhe

// Vari$$HEX1$$e100$$ENDHEX$$vel para armazenar o SQLSelect original 
// da DW de lista
String ivs_SQL_Original
end variables

event pfc_addrow;//
If Tab_1.SelectedTab = 1 Then
	IF ivb_insere_dw2 THEN
		Tab_1.TabPage_1.dw_2.Event pfc_AddRow()
		ivb_AddRow = True
	ELSE
		ivb_AddRow = False
	END IF
Else
	IF ivb_insere_dw3 THEN
		Tab_1.TabPage_2.dw_3.Event pfc_AddRow()
		ivb_AddRow = True
	ELSE
		ivb_AddRow = False
	END IF
End If
//
end event

event preparar_impressao;Return dw_4.RowCount()
end event

on w_2tab_cadastro_sel_lista_det_relatorio.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_4
end on

on w_2tab_cadastro_sel_lista_det_relatorio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.dw_4)
end on

event pfc_postopen;call super::pfc_postopen;Boolean lvb_Incluir

SetPointer(HourGlass!)

// Determina a ordem de execu$$HEX2$$e700e300$$ENDHEX$$o do pfc_Save() para os objetos
// Declara um array de objetos
PowerObject lvo_Objects[]

// Inicializa o array com os objetos
// que dever$$HEX1$$e300$$ENDHEX$$o fazer parte do pfc_Save com a ordem determinada
lvo_Objects = {Tab_1.TabPage_1.dw_2, Tab_1.TabPage_2.dw_3}

of_SetUpdateObjects(lvo_Objects)

// Insere uma linha na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
Tab_1.TabPage_1.dw_1.Event pfc_AddRow()
Tab_1.TabPage_1.dw_1.SetFocus()

// Habilita a fun$$HEX2$$e700e300$$ENDHEX$$o de inclus$$HEX1$$e300$$ENDHEX$$o do menu da janela
lvb_Incluir = wf_Habilita_Menu("I")
ivo_Menu_dw1.of_Incluir(lvb_Incluir)
ivo_Menu_dw2.of_Incluir(lvb_Incluir)
ivo_Menu_dw3.of_Incluir(lvb_Incluir)

// Verifica qual o SQL original da DW de lista
ivs_SQL_Original = Tab_1.TabPage_1.dw_2.GetSQLSelect()
end event

event close;call super::close;Destroy(ivo_Menu_dw1)
Destroy(ivo_Menu_dw2)
Destroy(ivo_Menu_dw3)
end event

event cancelar;call super::cancelar;If Tab_1.SelectedTab = 1 Then
	Tab_1.TabPage_1.dw_2.Event Cancelar()
Else
	Tab_1.TabPage_2.dw_3.Event Cancelar()
End If
end event

event open;call super::open;// Cria os objetos para o gerenciamento do menu conforme a DW ativa
ivo_Menu_dw1 = Create uo_Controle_Menu_dw
ivo_Menu_dw2 = Create uo_Controle_Menu_dw
ivo_Menu_dw3 = Create uo_Controle_Menu_dw

ivo_Menu_dw1.of_SetMenu(ivm_Menu_Janela)
ivo_Menu_dw2.of_SetMenu(ivm_Menu_Janela)
ivo_Menu_dw3.of_SetMenu(ivm_Menu_Janela)

ivb_insere_dw2 = TRUE
ivb_insere_dw3 = TRUE
end event

event pfc_print;call super::pfc_print;Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas = This.Event Preparar_Impressao()

// Verifica se foram encontradas as informa$$HEX2$$e700f500$$ENDHEX$$es
If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		// Executa o evento de impress$$HEX1$$e300$$ENDHEX$$o da PFC
		dw_4.Event pfc_Print()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!, Ok!)
	End If
End If

Return 0
end event

event pfc_printimmediate;call super::pfc_printimmediate;Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas  = This.Event Preparar_Impressao()

// Verifica se foram encontradas as informa$$HEX2$$e700f500$$ENDHEX$$es
If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		// Executa o evento de impress$$HEX1$$e300$$ENDHEX$$o da PFC
		dw_4.Event pfc_PrintImmediate()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!, Ok!)
	End If
End If

Return 0
end event

type tab_1 from tab within w_2tab_cadastro_sel_lista_det_relatorio
int Width=2048
int Height=1248
int TabOrder=10
boolean BringToTop=true
boolean RaggedRight=true
int SelectedTab=1
long BackColor=79741120
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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

event selectionchanging;Integer lvi_Retorno_Salva

SetPointer(HourGlass!)

If NewIndex = 2 Then
	//
	IF tab_1.tabpage_1.dw_2.GetRow() <= 0 THEN
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!, Ok!)
		RETURN 1
	END IF
	//
End If
//
// Verifica se houve altera$$HEX2$$e700e300$$ENDHEX$$o na DW de detalhes
lvi_Retorno_Salva = wf_Salva()

Choose Case lvi_Retorno_Salva
	Case OK_SEM_PENDENCIAS, &
		  OK_COM_PENDENCIAS, &
		  OK_SUCESSO_UPDATE, &
		  OK_SEM_UPDATE
		  
		// Desabilita as fun$$HEX2$$e700f500$$ENDHEX$$es de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento
		ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = False
		ivm_Menu_Janela.m_Editar.m_CancelarOperacao.Enabled = False
		
		// Permite a troca de folder
		Return 0
	Case CANCELAR_ERRO_PENDENCIAS, &
		  CANCELAR_ERRO_UPDATE

		// Desabilita a fun$$HEX2$$e700e300$$ENDHEX$$o de confirma$$HEX2$$e700e300$$ENDHEX$$o
		ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = False

		// N$$HEX1$$e300$$ENDHEX$$o permite a troca de folder
		Return 1		  
	Case CANCELAR_UPDATE

		// N$$HEX1$$e300$$ENDHEX$$o permite a troca de folder
		Return 1
End Choose
//
end event

event selectionchanged;Integer lvi_Linha_Ativa

Choose Case NewIndex
	Case 1
		This.Width  = ivl_Largura_1
		This.Height = ivl_Altura_1
		Parent.Width = This.Width + 45
		Parent.Height = This.Height + 110			
		
		// Atualiza a vari$$HEX1$$e100$$ENDHEX$$vel de controle do folder de detalhes
		ivb_AddRow = False

		// Limpa a DW de detalhes
		Tab_1.TabPage_2.dw_3.Reset()
		
		// Se existirem linhas na DW de detalhes que foram atualizadas
		// Atualiza as informa$$HEX2$$e700f500$$ENDHEX$$es
		If ivb_Update_Detalhe Then 
			Tab_1.Tabpage_1.dw_2.Event pfc_Retrieve()
			tab_1.tabpage_1.dw_2.SetFocus()
		Else
			If tab_1.tabpage_1.dw_2.RowCount() > 0 Then
				tab_1.tabpage_1.dw_2.SetFocus()
			Else
				// Coloca o foco na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
				Tab_1.Tabpage_1.dw_1.SetFocus()
			End If
		End If
		
		ivb_Update_Detalhe = False
	Case 2
		This.Width  = ivl_Largura_2
		This.Height = ivl_Altura_2
		Parent.Width = This.Width + 45
		Parent.Height = This.Height + 110			
		
		// Verifica se a mudan$$HEX1$$e700$$ENDHEX$$a de folder foi atrav$$HEX1$$e900$$ENDHEX$$s do bot$$HEX1$$e300$$ENDHEX$$o de inclus$$HEX1$$e300$$ENDHEX$$o
		If Not ivb_AddRow Then
			// Verifica se foi selecionada uma linha na DW de lista
			lvi_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()
			
			If lvi_Linha_Ativa > 0 Then
				// Recupera as linhas da DW de detalhes
				Tab_1.TabPage_2.dw_3.Event pfc_Retrieve()
			Else
				// Insere uma linha da DW de detalhes
				Tab_1.TabPage_2.dw_3.Event pfc_AddRow()
			End If
		End If
			
		// Coloca o foco na DW de detalhes
		Tab_1.Tabpage_2.dw_3.SetFocus()
End Choose
end event

type tabpage_1 from userobject within tab_1
int X=18
int Y=108
int Width=2011
int Height=1124
long BackColor=79741120
string Text="Sele$$HEX2$$e700e300$$ENDHEX$$o"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=553648127
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
int X=18
int Y=404
int Width=1938
int Height=672
int TabOrder=10
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

type gb_1 from groupbox within tabpage_1
int X=18
int Y=20
int Width=1938
int Height=352
int TabOrder=21
string Text="Par$$HEX1$$e200$$ENDHEX$$metros"
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

type dw_1 from u_dw within tabpage_1
int X=55
int Y=84
int Width=1792
int Height=256
int TabOrder=11
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
end type

event constructor;call super::constructor;// Desabilita o Update da DW
ib_IsUpdateAble = False
end event

event pfc_retrieve;call super::pfc_retrieve;// Recupera as linhas da DW de lista
// conforme os par$$HEX1$$e200$$ENDHEX$$metros informados na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
Return dw_2.Event pfc_Retrieve()
end event

event getfocus;call super::getfocus;// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es do menu da janela conforme a DW ativa
ivo_Menu_dw1.of_Atualiza()
end event

type dw_2 from u_dw within tabpage_1
event type string formula_clausula_where ( )
int X=55
int Y=468
int Width=1865
int Height=576
int TabOrder=11
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event pfc_retrieve;call super::pfc_retrieve;Boolean lvb_Habilita

Long lvl_Linhas

String lvs_SQL, &
       lvs_Where

// Verifica qual a condi$$HEX2$$e700e300$$ENDHEX$$o de consulta
lvs_Where = This.Event Formula_Clausula_Where()

// Se faltar algum par$$HEX1$$e200$$ENDHEX$$metro de preenchimento retorna Erro
If lvs_Where = "ERRO" Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe pelo menos um par$$HEX1$$e200$$ENDHEX$$metro para consulta.", Information!, Ok!)
	Return 0
End If

// Concatena o SQL original com a condi$$HEX2$$e700e300$$ENDHEX$$o de consulta
lvs_SQL = ivs_SQL_Original + lvs_Where

// Atualiza o SQL da DW
This.Object.Datawindow.Table.Select = lvs_SQL

// Recupera as linhas da DW de lista
// conforme os par$$HEX1$$e200$$ENDHEX$$metros informados na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
lvl_Linhas = This.Event Recuperar()

// Se recuperar alguma linha
If lvl_Linhas > 0 Then
	// Se recuperar mais de uma linha
	If lvl_Linhas > 1 Then
		lvb_Habilita = True
	Else
		lvb_Habilita = False
	End If
	
	// Atualiza o menu de exclus$$HEX1$$e300$$ENDHEX$$o
	ivo_Menu_dw2.of_Excluir(wf_Habilita_Menu("E"))
	
	This.ScrollToRow(1)
	This.SetRow(1)
	This.SetFocus()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!, Ok!)
	ivo_Menu_dw2.of_Excluir(False)
	lvb_Habilita = False
End If

// Atualiza o objeto de controle do menu da DW
ivo_Menu_dw2.of_Recuperar(ivo_Menu_dw1.ivb_Recuperar)
ivo_Menu_dw2.of_Classificar(lvb_Habilita)
ivo_Menu_dw2.of_Filtrar(lvb_Habilita)
ivo_Menu_dw2.of_Localizar(lvb_Habilita)

Return lvl_Linhas
end event

event constructor;call super::constructor;// Habilita a sele$$HEX2$$e700e300$$ENDHEX$$o de linhas da DW
of_SetRowSelect(True)

// Determina o tipo de fun$$HEX2$$e700e300$$ENDHEX$$o de cancelamento
ivi_Tipo_Cancelar = RETRIEVE

THIS.ShareData(dw_4)
//
end event

event getfocus;call super::getfocus;// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es do menu da janela conforme a DW ativa
ivo_Menu_dw2.of_Recuperar(ivo_Menu_dw1.ivb_Recuperar)
ivo_Menu_dw2.of_Atualiza()
end event

event recuperar;Return This.Retrieve()
end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=108
int Width=2011
int Height=1124
long BackColor=79741120
string Text="Detalhes"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=553648127
dw_3 dw_3
end type

on tabpage_2.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tabpage_2.destroy
destroy(this.dw_3)
end on

type dw_3 from u_dw within tabpage_2
int X=64
int Y=84
int Width=1947
int Height=924
int TabOrder=11
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
end type

event pfc_retrieve;call super::pfc_retrieve;Long lvl_Linha, &
     lvl_Linhas

// Verifica se foi selecionada uma linha na DW de lista
lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

If lvl_Linha > 0 Then
	// Recupera a linha de detalhe correspondente
	// a linha selecionada na DW de lista
	lvl_Linhas = This.Event Recuperar()
//	
	If lvl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Detalhes n$$HEX1$$e300$$ENDHEX$$o localizados.", Information!, Ok!)
	End If
End If

// Define o tipo de cancelamento da DW
ivi_Tipo_Cancelar = RETRIEVE

Return lvl_Linhas
end event

event getfocus;call super::getfocus;ivo_Menu_dw3.of_Atualiza()
end event

event itemchanged;call super::itemchanged;// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento da opera$$HEX2$$e700e300$$ENDHEX$$o
ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = True
ivm_Menu_Janela.m_Editar.m_CancelarOperacao.Enabled  = True
end event

event editchanged;call super::editchanged;// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento da opera$$HEX2$$e700e300$$ENDHEX$$o
ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = True
ivm_Menu_Janela.m_Editar.m_CancelarOperacao.Enabled  = True
end event

event pfc_postupdate;call super::pfc_postupdate;ivb_Update_Detalhe = True

Return 1
	

end event

event pfc_addrow;call super::pfc_addrow;Integer i

// Define o tipo de cancelamento da DW
ivi_Tipo_Cancelar = ADDROW

i = AncestorReturnValue 

Return AncestorReturnValue
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;//Integer lvi_Retorno_Salva
//
//SetPointer(HourGlass!)
//
// Verifica se houve altera$$HEX2$$e700e300$$ENDHEX$$o na DW de detalhes
//lvi_Retorno_Salva = wf_Salva()

//Choose Case lvi_Retorno_Salva
//	Case OK_SEM_PENDENCIAS, &
//		  OK_COM_PENDENCIAS, &
//		  OK_SUCESSO_UPDATE, &
//		  OK_SEM_UPDATE
//		  
//		// Desabilita as fun$$HEX2$$e700f500$$ENDHEX$$es de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento
//		ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = False
//		ivm_Menu_Janela.m_Editar.m_CancelarOperacao.Enabled = False
//		
//		Return 1
//	Case CANCELAR_ERRO_PENDENCIAS, &
//		  CANCELAR_ERRO_UPDATE
//
//		// Desabilita a fun$$HEX2$$e700e300$$ENDHEX$$o de confirma$$HEX2$$e700e300$$ENDHEX$$o
//		ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = False
//
//		// N$$HEX1$$e300$$ENDHEX$$o permite a inser$$HEX2$$e700e300$$ENDHEX$$o da linha
//		Return 0		  
//	Case CANCELAR_UPDATE
//
//		// N$$HEX1$$e300$$ENDHEX$$o permite a inser$$HEX2$$e700e300$$ENDHEX$$o da linha
//		Return 0
//End Choose
//
RETURN 1
//
end event

type dw_4 from u_dw within w_2tab_cadastro_sel_lista_det_relatorio
int X=2085
int Y=384
int TabOrder=11
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event constructor;call super::constructor;//
THIS.Modify("DataWindow.Print.Preview=Yes")
//
end event

event pfc_retrieve;call super::pfc_retrieve;integer i

String lvs_SQL, &
       lvs_Where

// Verifica qual a condi$$HEX2$$e700e300$$ENDHEX$$o de consulta
lvs_Where = tab_1.tabpage_1.dw_2.Event Formula_Clausula_Where()

// Se faltar algum par$$HEX1$$e200$$ENDHEX$$metro de preenchimento retorna Erro
If lvs_Where = "ERRO" Then Return 0

// Concatena o SQL original com a condi$$HEX2$$e700e300$$ENDHEX$$o de consulta
lvs_SQL = ivs_SQL_Original + lvs_Where

// Atualiza o SQL da DW
i = This.SetSQLSelect(lvs_SQL)

Return This.Event Recuperar()
end event

event recuperar;call super::recuperar;//
Return This.Retrieve()
//
end event

