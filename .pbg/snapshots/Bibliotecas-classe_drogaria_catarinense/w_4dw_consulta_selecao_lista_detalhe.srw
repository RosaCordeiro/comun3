HA$PBExportHeader$w_4dw_consulta_selecao_lista_detalhe.srw
forward
global type w_4dw_consulta_selecao_lista_detalhe from w_sheet
end type
type dw_1 from u_dw within w_4dw_consulta_selecao_lista_detalhe
end type
type dw_2 from u_dw within w_4dw_consulta_selecao_lista_detalhe
end type
type dw_3 from u_dw within w_4dw_consulta_selecao_lista_detalhe
end type
type gb_3 from groupbox within w_4dw_consulta_selecao_lista_detalhe
end type
type gb_2 from groupbox within w_4dw_consulta_selecao_lista_detalhe
end type
type gb_1 from groupbox within w_4dw_consulta_selecao_lista_detalhe
end type
type dw_4 from u_dw within w_4dw_consulta_selecao_lista_detalhe
end type
end forward

global type w_4dw_consulta_selecao_lista_detalhe from w_sheet
int Width=2277
int Height=1536
event pfc_retrieve ( )
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
dw_4 dw_4
end type
global w_4dw_consulta_selecao_lista_detalhe w_4dw_consulta_selecao_lista_detalhe

type variables
// Vari$$HEX1$$e100$$ENDHEX$$veis utilizadas para gerenciar 
// a habilita$$HEX2$$e700e300$$ENDHEX$$o das fun$$HEX2$$e700f500$$ENDHEX$$es do menu
// conforme a dw ativa
uo_Controle_Menu_dw ivo_Menu_dw1, &
                                     ivo_Menu_dw2, &
                                     ivo_Menu_dw3

String 		ivs_SQL_Original

BOOLEAN	ivb_impressao
BOOLEAN	ivb_Imprimindo
end variables

event pfc_retrieve;// Identifica que o usu$$HEX1$$e100$$ENDHEX$$rio clicou a fun$$HEX2$$e700e300$$ENDHEX$$o de leitura e n$$HEX1$$e300$$ENDHEX$$o de impress$$HEX1$$e300$$ENDHEX$$o
ivb_Imprimindo = False

dw_2.Event pfc_Retrieve()
end event

on w_4dw_consulta_selecao_lista_detalhe.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.gb_3
this.Control[iCurrent+5]=this.gb_2
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.dw_4
end on

on w_4dw_consulta_selecao_lista_detalhe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_4)
end on

event pfc_postopen;call super::pfc_postopen;SetPointer(HourGlass!)

// Insere uma linha na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
dw_1.Event pfc_AddRow()
dw_1.SetFocus()

// Verifica qual o SQL original da DW de lista
ivs_SQL_Original = dw_2.GetSQLSelect()
end event

event close;call super::close;Destroy(ivo_Menu_dw1)
Destroy(ivo_Menu_dw2)
Destroy(ivo_Menu_dw3)

end event

event open;call super::open;//
// Autor: Alexandre Thizon
// Data : 13/07/1999
//
// Cria os objetos para o gerenciamento do menu conforme a DW ativa
ivo_Menu_dw1 = Create uo_Controle_Menu_dw
ivo_Menu_dw2 = Create uo_Controle_Menu_dw
ivo_Menu_dw3 = Create uo_Controle_Menu_dw

ivo_Menu_dw1.of_SetMenu(ivm_Menu_Janela)
ivo_Menu_dw2.of_SetMenu(ivm_Menu_Janela)
ivo_Menu_dw3.of_SetMenu(ivm_Menu_Janela)
end event

event pfc_print;call super::pfc_print;Long lvl_Linhas

SetPointer(HourGlass!)

// Identifica que o usu$$HEX1$$e100$$ENDHEX$$rio clicou a fun$$HEX2$$e700e300$$ENDHEX$$o de impress$$HEX1$$e300$$ENDHEX$$o e n$$HEX1$$e300$$ENDHEX$$o de leitura
ivb_Imprimindo = True

// Recupera as linhas conforme os par$$HEX1$$e200$$ENDHEX$$metros
// informados na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
lvl_Linhas = dw_4.Event pfc_Retrieve()

// Verifica se foram encontradas as informa$$HEX2$$e700f500$$ENDHEX$$es
If lvl_Linhas > 0 Then
	// Executa o evento de impress$$HEX1$$e300$$ENDHEX$$o da PFC
	dw_4.Event pfc_Print()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!, Ok!)
End If

Return 0
end event

event pfc_printimmediate;call super::pfc_printimmediate;Long lvl_Linhas

SetPointer(HourGlass!)

// Identifica que o usu$$HEX1$$e100$$ENDHEX$$rio clicou a fun$$HEX2$$e700e300$$ENDHEX$$o de impress$$HEX1$$e300$$ENDHEX$$o e n$$HEX1$$e300$$ENDHEX$$o de leitura
ivb_Imprimindo = True

// Recupera as linhas conforme os par$$HEX1$$e200$$ENDHEX$$metros
// informados na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
lvl_Linhas = dw_4.Event pfc_Retrieve()

// Verifica se foram encontradas as informa$$HEX2$$e700f500$$ENDHEX$$es
If lvl_Linhas > 0 Then
	// Executa o evento de impress$$HEX1$$e300$$ENDHEX$$o da PFC
	dw_4.Event pfc_PrintImmediate()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!, Ok!)
End If

Return 0
end event

type dw_1 from u_dw within w_4dw_consulta_selecao_lista_detalhe
int X=73
int Y=80
int Width=1701
int Height=268
int TabOrder=10
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
end type

event constructor;call super::constructor;// Desabilita o Update da DW
ib_IsUpdateAble = False

end event

event getfocus;call super::getfocus;ivo_Menu_dw1.of_Atualiza()
end event

type dw_2 from u_dw within w_4dw_consulta_selecao_lista_detalhe
event type string formula_clausula_where ( )
int X=78
int Y=476
int Width=1673
int Height=280
int TabOrder=60
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event constructor;call super::constructor;// Habilita a sele$$HEX2$$e700e300$$ENDHEX$$o de linhas da DW
This.of_SetRowSelect(True)

// Desabilita o Update da DW
ib_IsUpdateAble = False

end event

event rowfocuschanged;call super::rowfocuschanged;// Recupera as linhas da DW de detalhes
// conforme a linha selecionada na DW de lista
dw_3.Event pfc_Retrieve()
end event

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
This.SetSQLSelect(lvs_SQL)

// Recupera as linhas da DW de lista
// conforme os par$$HEX1$$e200$$ENDHEX$$metros informados na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
lvl_Linhas = This.Retrieve()

// Se recuperar alguma linha
If lvl_Linhas > 0 Then
	This.Event RowFocusChanged(1)

	IF ivb_Impressao THEN
		ivm_Menu_Janela.m_Arquivo.m_Imprimir.Enabled 		  = TRUE
		ivm_Menu_Janela.m_Arquivo.m_ImprimirImediato.Enabled = TRUE
	END IF

	// Se recuperar mais de uma linha
	If lvl_Linhas > 1 Then
		lvb_Habilita = True
	Else
		lvb_Habilita = False
	End If
	
	This.ScrollToRow(1)
	This.SetRow(1)
	This.SetFocus()
Else
	dw_3.Reset()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!, Ok!)
	lvb_Habilita = False
	//
	ivm_Menu_Janela.m_Arquivo.m_Imprimir.Enabled 		  = FALSE
	ivm_Menu_Janela.m_Arquivo.m_ImprimirImediato.Enabled = FALSE
	//
End If

// Atualiza o objeto de controle do menu da DW
ivo_Menu_dw2.of_Recuperar(ivo_Menu_dw1.ivb_Recuperar)
ivo_Menu_dw2.of_Classificar(lvb_Habilita)
ivo_Menu_dw2.of_Filtrar(lvb_Habilita)
ivo_Menu_dw2.of_Localizar(lvb_Habilita)

Return lvl_Linhas
end event

event getfocus;call super::getfocus;ivo_Menu_dw2.of_Recuperar(ivo_Menu_dw1.ivb_Recuperar)
ivo_Menu_dw2.of_Atualiza()
end event

type dw_3 from u_dw within w_4dw_consulta_selecao_lista_detalhe
int X=87
int Y=896
int Width=1682
int Height=392
int TabOrder=50
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
end type

event constructor;call super::constructor;// Desabilita o Update da DW
ib_IsUpdateAble = False

end event

event pfc_retrieve;call super::pfc_retrieve;Boolean lvb_Habilita
Long lvl_Linhas

// Recupera as linhas da DW de detalhes
// conforme a linha selecionada na DW de lista
lvl_Linhas = This.Event Recuperar()

// Se recuperar alguma linha
If lvl_Linhas > 0 Then
	// Se recuperar mais de uma linha
	If lvl_Linhas > 1 Then
		lvb_Habilita = True
	Else
		lvb_Habilita = False
	End If	
Else
	lvb_Habilita = False
End If

// Atualiza o objeto de controle do menu da DW
ivo_Menu_dw3.of_Recuperar(ivo_Menu_dw1.ivb_Recuperar)
ivo_Menu_dw3.of_Classificar(lvb_Habilita)
ivo_Menu_dw3.of_Filtrar(lvb_Habilita)
ivo_Menu_dw3.of_Localizar(lvb_Habilita)

Return lvl_Linhas
end event

event getfocus;call super::getfocus;ivo_Menu_dw3.of_Recuperar(ivo_Menu_dw1.ivb_Recuperar)
ivo_Menu_dw3.of_Atualiza()
end event

type gb_3 from groupbox within w_4dw_consulta_selecao_lista_detalhe
int X=37
int Y=820
int Width=1792
int Height=516
int TabOrder=20
string Text="Detalhe"
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

type gb_2 from groupbox within w_4dw_consulta_selecao_lista_detalhe
int X=32
int Y=392
int Width=1792
int Height=404
int TabOrder=30
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

type gb_1 from groupbox within w_4dw_consulta_selecao_lista_detalhe
int X=32
int Y=16
int Width=1792
int Height=360
int TabOrder=40
string Text="Par$$HEX1$$e200$$ENDHEX$$metros de Sele$$HEX2$$e700e300$$ENDHEX$$o"
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

type dw_4 from u_dw within w_4dw_consulta_selecao_lista_detalhe
int X=1902
int Y=320
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
lvs_Where = dw_2.Event Formula_Clausula_Where()

// Se faltar algum par$$HEX1$$e200$$ENDHEX$$metro de preenchimento retorna Erro
If lvs_Where = "ERRO" Then Return 0

// Concatena o SQL original com a condi$$HEX2$$e700e300$$ENDHEX$$o de consulta
lvs_SQL = ivs_SQL_Original + lvs_Where

// Atualiza o SQL da DW
i = This.SetSQLSelect(lvs_SQL)

Return This.Event Recuperar()
end event

event recuperar;call super::recuperar;Return This.Retrieve()
end event

