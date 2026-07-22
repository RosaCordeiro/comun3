HA$PBExportHeader$w_2tab_consulta_lista_selecao_detalhe.srw
forward
global type w_2tab_consulta_lista_selecao_detalhe from w_sheet
end type
type tab_1 from tab within w_2tab_consulta_lista_selecao_detalhe
end type
type tabpage_1 from userobject within tab_1
end type
type gb_2 from groupbox within tabpage_1
end type
type dw_1 from u_dw within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_3 from u_dw within tabpage_2
end type
type gb_1 from groupbox within tabpage_2
end type
type dw_2 from u_dw within tabpage_2
end type
type dw_relatorio from u_dw within w_2tab_consulta_lista_selecao_detalhe
end type
type tabpage_1 from userobject within tab_1
gb_2 gb_2
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
dw_3 dw_3
gb_1 gb_1
dw_2 dw_2
end type
type tab_1 from tab within w_2tab_consulta_lista_selecao_detalhe
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_2tab_consulta_lista_selecao_detalhe from w_sheet
int Width=2816
event pfc_retrieve ( )
event type long preparar_impressao ( )
tab_1 tab_1
dw_relatorio dw_relatorio
end type
global w_2tab_consulta_lista_selecao_detalhe w_2tab_consulta_lista_selecao_detalhe

type variables
// Vari$$HEX1$$e100$$ENDHEX$$veis utilizadas para gerenciar a mudan$$HEX1$$e700$$ENDHEX$$a de 
// tamanho dos folders
Long ivl_Largura_1, &
         ivl_Altura_1, &
         ivl_Largura_2, &
         ivl_Altura_2

// Vari$$HEX1$$e100$$ENDHEX$$veis utilizadas para gerenciar 
// a habilita$$HEX2$$e700e300$$ENDHEX$$o das fun$$HEX2$$e700f500$$ENDHEX$$es do menu
// conforme a dw ativa
uo_Controle_Menu_dw ivo_Menu_dw1, &
                                     ivo_Menu_dw2, &
                                     ivo_Menu_dw3
 
String ivs_SQL_Original

Boolean 	ivb_Habilita

Boolean ivb_Impressao
end variables

event preparar_impressao;Return dw_relatorio.RowCount()
end event

on w_2tab_consulta_lista_selecao_detalhe.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_relatorio=create dw_relatorio
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_relatorio
end on

on w_2tab_consulta_lista_selecao_detalhe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.dw_relatorio)
end on

event pfc_postopen;call super::pfc_postopen;//
SetPointer(HourGlass!)
//
// Verifica qual o SQL original da DW de lista
ivs_SQL_Original = Tab_1.TabPage_1.dw_1.GetSQLSelect()
//
Tab_1.TabPage_1.dw_1.Event pfc_Retrieve()
//
Tab_1.TabPage_2.dw_2.Event pfc_AddRow()
//
tab_1.tabpage_1.dw_1.SetFocus()
//
end event

event close;call super::close;Destroy(ivo_Menu_dw1)
Destroy(ivo_Menu_dw2)
Destroy(ivo_Menu_dw3)
end event

event open;call super::open;// Cria os objetos para o gerenciamento do menu conforme a DW ativa
ivo_Menu_dw1 = Create uo_Controle_Menu_dw
ivo_Menu_dw2 = Create uo_Controle_Menu_dw
ivo_Menu_dw3 = Create uo_Controle_Menu_dw

ivo_Menu_dw1.of_SetMenu(ivm_Menu_Janela)
ivo_Menu_dw2.of_SetMenu(ivm_Menu_Janela)
ivo_Menu_dw3.of_SetMenu(ivm_Menu_Janela)


end event

event pfc_print;call super::pfc_print;Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas = This.Event Preparar_Impressao()

// Verifica se foram encontradas as informa$$HEX2$$e700f500$$ENDHEX$$es
If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		// Executa o evento de impress$$HEX1$$e300$$ENDHEX$$o da PFC
		dw_relatorio.Event pfc_Print()
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
		dw_relatorio.Event pfc_PrintImmediate()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!, Ok!)
	End If
End If

Return 0
end event

type tab_1 from tab within w_2tab_consulta_lista_selecao_detalhe
int Width=2194
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

event selectionchanging;If NewIndex = 2 Then
	If Tab_1.TabPage_1.dw_1.GetRow() > 0 Then
		// Permite a troca do folder
		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!, Ok!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If		
end event

event selectionchanged;//
Choose Case NewIndex
	Case 1
		This.Width  = ivl_Largura_1
		This.Height = ivl_Altura_1

		ivo_Menu_dw1.of_Classificar(ivb_Habilita)
		ivo_Menu_dw1.of_Filtrar(ivb_Habilita)
		ivo_Menu_dw1.of_Localizar(ivb_Habilita)

	Case 2
		This.Width  = ivl_Largura_2
		This.Height = ivl_Altura_2
		//
		tab_1.tabpage_2.dw_3.Reset()

		ivo_Menu_dw3.of_Classificar(FALSE)
		ivo_Menu_dw3.of_Filtrar(FALSE)
		ivo_Menu_dw3.of_Localizar(FALSE)

		//
End Choose

Parent.Width = This.Width + 45
Parent.Height = This.Height + 110
end event

type tabpage_1 from userobject within tab_1
int X=18
int Y=108
int Width=2158
int Height=1124
long BackColor=79741120
string Text="Lista"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=553648127
gb_2 gb_2
dw_1 dw_1
end type

on tabpage_1.create
this.gb_2=create gb_2
this.dw_1=create dw_1
this.Control[]={this.gb_2,&
this.dw_1}
end on

on tabpage_1.destroy
destroy(this.gb_2)
destroy(this.dw_1)
end on

type gb_2 from groupbox within tabpage_1
int X=18
int Y=20
int Width=1792
int Height=1040
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

type dw_1 from u_dw within tabpage_1
event type string formula_clausula_where ( )
int X=91
int Y=84
int Width=1682
int Height=952
int TabOrder=11
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event pfc_retrieve;call super::pfc_retrieve;Long 		lvl_Linhas
String 	lvs_SQL, &
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
This.SetSQLSelect(lvs_SQL)

// Recupera as linhas da DW de lista
// conforme os par$$HEX1$$e200$$ENDHEX$$metros informados na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
lvl_Linhas = This.Event Recuperar()

// Se recuperar alguma linha
If lvl_Linhas > 0 Then
	
	If ivb_Impressao Then
		ivm_Menu_Janela.m_Arquivo.m_Imprimir.Enabled = True
		ivm_Menu_Janela.m_Arquivo.m_ImprimirImediato.Enabled = True
	End If

	// Se recuperar mais de uma linha
	If lvl_Linhas > 1 Then
		ivb_Habilita = True
	Else
		ivb_Habilita = False
	End If
	
	This.ScrollToRow(1)
	This.SetRow(1)
	This.SetFocus()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!, Ok!)
	ivb_Habilita = False
End If

// Atualiza o objeto de controle do menu da DW
ivo_Menu_dw1.of_Classificar(ivb_Habilita)
ivo_Menu_dw1.of_Filtrar(ivb_Habilita)
ivo_Menu_dw1.of_Localizar(ivb_Habilita)

Return lvl_Linhas
end event

event constructor;call super::constructor;// Habilita a sele$$HEX2$$e700e300$$ENDHEX$$o de linhas da DW
of_SetRowSelect(True)

// Desabilita o Update da DW
ib_IsUpdateAble = False

This.ShareData(dw_relatorio)
end event

event getfocus;call super::getfocus;ivo_Menu_dw1.of_Recuperar(ivo_Menu_dw1.ivb_Recuperar)
ivo_Menu_dw1.of_Atualiza()

end event

event recuperar;//
Return This.Retrieve()
//
end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=108
int Width=2158
int Height=1124
long BackColor=79741120
string Text="Detalhes"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=553648127
dw_3 dw_3
gb_1 gb_1
dw_2 dw_2
end type

on tabpage_2.create
this.dw_3=create dw_3
this.gb_1=create gb_1
this.dw_2=create dw_2
this.Control[]={this.dw_3,&
this.gb_1,&
this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_3)
destroy(this.gb_1)
destroy(this.dw_2)
end on

type dw_3 from u_dw within tabpage_2
int X=18
int Y=532
int Width=2048
int Height=480
int TabOrder=11
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
end type

event constructor;call super::constructor;// Desabilita o Update da DW
ib_IsUpdateAble = False
end event

event getfocus;call super::getfocus;ivo_Menu_dw3.of_Recuperar(ivo_Menu_dw3.ivb_Recuperar)
ivo_Menu_dw3.of_Atualiza()

end event

event pfc_retrieve;call super::pfc_retrieve;Long 		lvl_Linhas
BOOLEAN	lvb_boolean

// Recupera a linha de detalhe correspondente
// a linha selecionada na DW de lista
lvl_Linhas = This.Event Recuperar()

If lvl_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Detalhes n$$HEX1$$e300$$ENDHEX$$o localizados.", Information!, Ok!)
	//
	lvb_boolean = FALSE
	//
Else
	IF lvl_linhas > 1 THEN
		lvb_boolean = TRUE
	ELSE
		lvb_boolean = FALSE
	END IF
End If
//
ivo_Menu_dw3.of_Classificar(lvb_boolean)
ivo_Menu_dw3.of_Filtrar(lvb_boolean)
ivo_Menu_dw3.of_Localizar(lvb_boolean)
ivo_Menu_dw3.of_Recuperar(lvb_boolean)
//

Return lvl_Linhas
end event

type gb_1 from groupbox within tabpage_2
int X=18
int Y=20
int Width=2085
int Height=448
int TabOrder=20
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

type dw_2 from u_dw within tabpage_2
int X=55
int Y=84
int Width=1975
int Height=352
int TabOrder=11
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
end type

event pfc_retrieve;call super::pfc_retrieve;// Recupera as linhas da DW de lista
// conforme os par$$HEX1$$e200$$ENDHEX$$metros informados na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
Return dw_3.Event pfc_Retrieve()
end event

event constructor;call super::constructor;// Desabilita o Update da DW
ib_IsUpdateAble = False
end event

event getfocus;call super::getfocus;// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es do menu da janela conforme a DW ativa
ivo_Menu_dw2.of_Recuperar(ivo_Menu_dw2.ivb_Recuperar)
ivo_Menu_dw2.of_Atualiza()

end event

event recuperar;call super::recuperar;//
RETURN tab_1.tabpage_2.dw_3.Event Recuperar()
//
end event

type dw_relatorio from u_dw within w_2tab_consulta_lista_selecao_detalhe
int X=2304
int Y=480
int TabOrder=11
boolean Visible=false
boolean BringToTop=true
end type

event constructor;call super::constructor;This.Modify("DataWindow.Print.Preview=Yes")
end event

event pfc_retrieve;call super::pfc_retrieve;Long lvl_Linhas

String lvs_SQL, &
       lvs_Where

// Verifica qual a condi$$HEX2$$e700e300$$ENDHEX$$o de consulta
lvs_Where = This.Event Formula_Clausula_Where()

// Se faltar algum par$$HEX1$$e200$$ENDHEX$$metro de preenchimento retorna Erro
If lvs_Where = "ERRO" Then Return -1

// Concatena o SQL original com a condi$$HEX2$$e700e300$$ENDHEX$$o de consulta
lvs_SQL = ivs_SQL_Original + lvs_Where

// Atualiza o SQL da DW
This.Object.DataWindow.Table.Select = lvs_SQL

// Recupera as linhas da DW de lista
// conforme os par$$HEX1$$e200$$ENDHEX$$metros informados na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
lvl_Linhas = This.Event Recuperar()

Return lvl_Linhas
end event

