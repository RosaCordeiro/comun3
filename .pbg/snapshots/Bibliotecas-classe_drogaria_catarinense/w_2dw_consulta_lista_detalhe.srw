HA$PBExportHeader$w_2dw_consulta_lista_detalhe.srw
forward
global type w_2dw_consulta_lista_detalhe from w_sheet
end type
type gb_2 from groupbox within w_2dw_consulta_lista_detalhe
end type
type gb_1 from groupbox within w_2dw_consulta_lista_detalhe
end type
type dw_1 from u_dw within w_2dw_consulta_lista_detalhe
end type
type dw_2 from u_dw within w_2dw_consulta_lista_detalhe
end type
end forward

global type w_2dw_consulta_lista_detalhe from w_sheet
int Width=2345
int Height=1632
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
end type
global w_2dw_consulta_lista_detalhe w_2dw_consulta_lista_detalhe

type variables
uo_Controle_Menu_dw ivo_Menu_dw1
uo_Controle_Menu_dw ivo_Menu_dw2
end variables

on w_2dw_consulta_lista_detalhe.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
end on

on w_2dw_consulta_lista_detalhe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event pfc_postopen;call super::pfc_postopen;SetPointer(HourGlass!)

// Recupera as linhas da DW de lista
dw_1.Event pfc_Retrieve()
dw_1.SetFocus()
end event

event close;call super::close;Destroy(ivo_Menu_dw1)
Destroy(ivo_Menu_dw2)
end event

event open;call super::open;// Cria os objetos para o gerenciamento do menu conforme a DW ativa
ivo_Menu_dw1 = Create uo_Controle_Menu_dw
ivo_Menu_dw2 = Create uo_Controle_Menu_dw

ivo_Menu_dw1.of_SetMenu(ivm_Menu_Janela)
ivo_Menu_dw2.of_SetMenu(ivm_Menu_Janela)
end event

type gb_2 from groupbox within w_2dw_consulta_lista_detalhe
int X=37
int Y=732
int Width=2258
int Height=704
int TabOrder=10
string Text="Detalhes"
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

type gb_1 from groupbox within w_2dw_consulta_lista_detalhe
int X=37
int Y=12
int Width=2258
int Height=704
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

type dw_1 from u_dw within w_2dw_consulta_lista_detalhe
int X=82
int Y=84
int Width=2158
int Height=588
int TabOrder=30
string Tag="dw_1"
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event constructor;call super::constructor;// Habilita a sele$$HEX2$$e700e300$$ENDHEX$$o de linhas da DW
of_SetRowSelect(True)

// Desabilita o Update da DW
ib_IsUpdateAble = False
end event

event pfc_retrieve;call super::pfc_retrieve;Boolean lvb_Habilita

Long lvl_Linhas

SetPointer(HourGlass!)

// Recupera as linhas da DW de lista
lvl_Linhas = This.Event Recuperar()

// Se recuperar alguma linha
If lvl_Linhas > 0 Then
	// Se recuperar mais de uma linha
	// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es de localiza$$HEX2$$e700e300$$ENDHEX$$o, classifica$$HEX2$$e700e300$$ENDHEX$$o e filtro da DW
	If lvl_Linhas > 1 Then
		lvb_Habilita = True
	Else
		lvb_Habilita = False
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!, Ok!)
	lvb_Habilita = False
End If

ivo_Menu_dw1.of_Classificar(lvb_Habilita)
ivo_Menu_dw1.of_Filtrar(lvb_Habilita)
ivo_Menu_dw1.of_Localizar(lvb_Habilita)

Return lvl_Linhas
end event

event rowfocuschanged;call super::rowfocuschanged;// Recupera as linhas da DW de detalhe
// conforme a linha selecionada na DW de lista
dw_2.Event pfc_Retrieve()
end event

event getfocus;call super::getfocus;// Atualiza o menu da janela conforme a DW ativa
ivo_Menu_dw1.of_Atualiza()
end event

event recuperar;// Este evento est$$HEX1$$e100$$ENDHEX$$ programada na classe, pois a maioria das janelas
// far$$HEX1$$e300$$ENDHEX$$o retrieve sem nenhum par$$HEX1$$e200$$ENDHEX$$metro.

// Em caso de necessidade de retrieve espec$$HEX1$$ed00$$ENDHEX$$fico com par$$HEX1$$e200$$ENDHEX$$metros
// dever$$HEX1$$e100$$ENDHEX$$ ser programado no objeto decendente, executando o OVERRIDE.
Return This.Retrieve()
end event

type dw_2 from u_dw within w_2dw_consulta_lista_detalhe
int X=87
int Y=808
int Width=2158
int Height=588
int TabOrder=11
string Tag="dw_2"
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event pfc_retrieve;call super::pfc_retrieve;Boolean lvb_Habilita

Long lvl_Linhas

SetPointer(HourGlass!)

// Recupera as linhas da DW de detalhe
// conforme a linha selecionada na DW de lista
lvl_Linhas = This.Event Recuperar()

// Se recuperar alguma linha
If lvl_Linhas > 0 Then
	// Se recuperar mais de uma linha
	// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es de localiza$$HEX2$$e700e300$$ENDHEX$$o, classifica$$HEX2$$e700e300$$ENDHEX$$o e filtro da DW
	If lvl_Linhas > 1 Then
		lvb_Habilita = True
	Else
		lvb_Habilita = False
	End If
Else
	lvb_Habilita = False
End If

ivo_Menu_dw2.of_Classificar(lvb_Habilita)
ivo_Menu_dw2.of_Filtrar(lvb_Habilita)
ivo_Menu_dw2.of_Localizar(lvb_Habilita)
		
Return lvl_Linhas
end event

event constructor;call super::constructor;// Desabilita o Update da DW
ib_IsUpdateAble = False
end event

event getfocus;call super::getfocus;// Atualiza o menu da janela conforme a DW ativa
ivo_Menu_dw2.of_Atualiza()
end event

