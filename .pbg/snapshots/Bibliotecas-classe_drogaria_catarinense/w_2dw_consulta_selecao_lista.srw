HA$PBExportHeader$w_2dw_consulta_selecao_lista.srw
forward
global type w_2dw_consulta_selecao_lista from w_sheet
end type
type dw_1 from u_dw within w_2dw_consulta_selecao_lista
end type
type dw_2 from u_dw within w_2dw_consulta_selecao_lista
end type
type gb_2 from groupbox within w_2dw_consulta_selecao_lista
end type
type gb_1 from groupbox within w_2dw_consulta_selecao_lista
end type
type dw_3 from u_dw within w_2dw_consulta_selecao_lista
end type
end forward

global type w_2dw_consulta_selecao_lista from w_sheet
int Width=2862
int Height=1400
event pfc_retrieve ( )
dw_1 dw_1
dw_2 dw_2
gb_2 gb_2
gb_1 gb_1
dw_3 dw_3
end type
global w_2dw_consulta_selecao_lista w_2dw_consulta_selecao_lista

type variables
String ivs_SQL_Original

Boolean ivb_Impressao = False, &
              ivb_Imprimindo

uo_Controle_Menu_DW ivo_Menu_dw1, &
                                       ivo_Menu_dw2
end variables

event pfc_retrieve;// Identifica que o usu$$HEX1$$e100$$ENDHEX$$rio clicou a fun$$HEX2$$e700e300$$ENDHEX$$o de leitura e n$$HEX1$$e300$$ENDHEX$$o de impress$$HEX1$$e300$$ENDHEX$$o
ivb_Imprimindo = False

dw_2.Event pfc_Retrieve()
end event

on w_2dw_consulta_selecao_lista.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.dw_3
end on

on w_2dw_consulta_selecao_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_3)
end on

event pfc_postopen;call super::pfc_postopen;SetPointer(HourGlass!)

// Insere uma linha da DW de sele$$HEX2$$e700e300$$ENDHEX$$o
dw_1.Event pfc_AddRow()
dw_1.SetFocus()

// Verifica qual o SQL original da DW de lista
ivs_SQL_Original = dw_2.GetSQLSelect()
end event

event pfc_print;call super::pfc_print;Long lvl_Linhas

SetPointer(HourGlass!)

// Identifica que o usu$$HEX1$$e100$$ENDHEX$$rio clicou a fun$$HEX2$$e700e300$$ENDHEX$$o de impress$$HEX1$$e300$$ENDHEX$$o e n$$HEX1$$e300$$ENDHEX$$o de leitura
ivb_Imprimindo = True

// Recupera as linhas conforme os par$$HEX1$$e200$$ENDHEX$$metros
// informados na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
lvl_Linhas = dw_3.Event pfc_Retrieve()

// Verifica se foram encontradas as informa$$HEX2$$e700f500$$ENDHEX$$es
If lvl_Linhas > 0 Then
	// Executa o evento de impress$$HEX1$$e300$$ENDHEX$$o da PFC
	dw_3.Event pfc_Print()
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
lvl_Linhas = dw_3.Event pfc_Retrieve()

// Verifica se foram encontradas as informa$$HEX2$$e700f500$$ENDHEX$$es
If lvl_Linhas > 0 Then
	// Executa o evento de impress$$HEX1$$e300$$ENDHEX$$o da PFC
	dw_3.Event pfc_PrintImmediate()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!, Ok!)
End If

Return 0
end event

event close;call super::close;Destroy(ivo_Menu_dw1)
Destroy(ivo_Menu_dw2)
end event

event open;call super::open;ivo_Menu_dw1 = Create uo_Controle_Menu_dw
ivo_Menu_dw2 = Create uo_Controle_Menu_dw

ivo_Menu_dw1.of_SetMenu(ivm_Menu_Janela)
ivo_Menu_dw2.of_SetMenu(ivm_Menu_Janela)
end event

type dw_1 from u_dw within w_2dw_consulta_selecao_lista
int X=96
int Y=128
int Width=1655
int Height=356
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

type dw_2 from u_dw within w_2dw_consulta_selecao_lista
event type string formula_clausula_where ( )
int X=96
int Y=628
int Width=1655
int Height=508
int TabOrder=20
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event formula_clausula_where;Return ''
end event

event constructor;call super::constructor;// Habilita a sele$$HEX2$$e700e300$$ENDHEX$$o de linhas da DW
of_SetRowSelect(True)

// Desabilita o Update da DW
ib_IsUpdateAble = False

end event

event pfc_retrieve;call super::pfc_retrieve;Boolean lvb_Habilita

Long lvl_Linhas

String lvs_SQL, &
       lvs_Where

// Verifica qual a condi$$HEX2$$e700e300$$ENDHEX$$o de consulta
lvs_Where = This.Event Formula_Clausula_Where()

// Se faltar algum par$$HEX1$$e200$$ENDHEX$$metro de preenchimento retorna Erro
If lvs_Where = "ERRO" Then Return 0

// Concatena o SQL original com a condi$$HEX2$$e700e300$$ENDHEX$$o de consulta
lvs_SQL = ivs_SQL_Original + lvs_Where

// Atualiza o SQL da DW
This.Object.DataWindow.Table.Select = lvs_SQL

// Recupera as linhas da DW de lista
// conforme os par$$HEX1$$e200$$ENDHEX$$metros informados na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
lvl_Linhas = This.Event Recuperar()

If lvl_Linhas > 0 Then
	If ivb_Impressao Then
		ivm_Menu_Janela.m_Arquivo.m_Imprimir.Enabled = True
		ivm_Menu_Janela.m_Arquivo.m_ImprimirImediato.Enabled = True
	End If
	
	// Se recuperar mais de uma linha
	// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es de localiza$$HEX2$$e700e300$$ENDHEX$$o, classifica$$HEX2$$e700e300$$ENDHEX$$o e filtro
	If lvl_Linhas > 1 Then
		lvb_Habilita = True
	Else
		lvb_Habilita = False
	End If

	// Coloca o foco na DW de lista
	This.SetFocus()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!, Ok!)
	lvb_Habilita = False
	
	ivm_Menu_Janela.m_Arquivo.m_Imprimir.Enabled = False
	ivm_Menu_Janela.m_Arquivo.m_ImprimirImediato.Enabled = False
End If

ivo_Menu_dw2.of_Classificar(lvb_Habilita)
ivo_Menu_dw2.of_Filtrar(lvb_Habilita)
ivo_Menu_dw2.of_Localizar(lvb_Habilita)
ivo_Menu_dw2.of_Recuperar(ivo_Menu_dw1.ivb_Recuperar)

Return lvl_Linhas
end event

event recuperar;call super::recuperar;Return This.Retrieve()
end event

event getfocus;call super::getfocus;ivo_Menu_dw2.of_Recuperar(ivo_Menu_dw1.ivb_Recuperar)
ivo_Menu_dw2.of_Atualiza()
end event

type gb_2 from groupbox within w_2dw_consulta_selecao_lista
int X=55
int Y=40
int Width=1755
int Height=496
int TabOrder=30
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

type gb_1 from groupbox within w_2dw_consulta_selecao_lista
int X=55
int Y=564
int Width=1755
int Height=608
int TabOrder=40
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

type dw_3 from u_dw within w_2dw_consulta_selecao_lista
int X=2213
int Y=420
int TabOrder=11
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

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
This.Object.DataWindow.Table.Select = lvs_SQL
//i = This.SetSQLSelect(lvs_SQL)

Return This.Event Recuperar()
end event

event recuperar;call super::recuperar;Return This.Retrieve()
end event

event constructor;call super::constructor;This.Modify("DataWindow.Print.Preview=Yes")
end event

