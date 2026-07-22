HA$PBExportHeader$w_response_selecao_lista.srw
forward
global type w_response_selecao_lista from w_response
end type
type gb_2 from groupbox within w_response_selecao_lista
end type
type gb_1 from groupbox within w_response_selecao_lista
end type
type dw_1 from u_dw within w_response_selecao_lista
end type
type dw_2 from u_dw within w_response_selecao_lista
end type
type cb_selecionar from commandbutton within w_response_selecao_lista
end type
type cb_cancelar from commandbutton within w_response_selecao_lista
end type
type cb_pesquisar from commandbutton within w_response_selecao_lista
end type
end forward

global type w_response_selecao_lista from w_response
int Width=2482
int Height=1536
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
cb_selecionar cb_selecionar
cb_cancelar cb_cancelar
cb_pesquisar cb_pesquisar
end type
global w_response_selecao_lista w_response_selecao_lista

type variables
String ivs_sql_original

Boolean ivb_Pesquisa_Direta = False
end variables

on w_response_selecao_lista.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_selecionar=create cb_selecionar
this.cb_cancelar=create cb_cancelar
this.cb_pesquisar=create cb_pesquisar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_selecionar
this.Control[iCurrent+6]=this.cb_cancelar
this.Control[iCurrent+7]=this.cb_pesquisar
end on

on w_response_selecao_lista.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_selecionar)
destroy(this.cb_cancelar)
destroy(this.cb_pesquisar)
end on

event open;call super::open;dw_1.Event pfc_AddRow()
dw_1.SetFocus()
end event

event pfc_postopen;ivs_Sql_Original = dw_2.GetSqlSelect()

// Executa a pesquisa na base de dados conforme os par$$HEX1$$e200$$ENDHEX$$metros informados durante a abertura
// da janela
If ivb_Pesquisa_Direta Then
	cb_Pesquisar.Event Clicked()
End If
end event

type gb_2 from groupbox within w_response_selecao_lista
int X=27
int Y=448
int Width=2423
int Height=832
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

type gb_1 from groupbox within w_response_selecao_lista
int X=27
int Y=8
int Width=2423
int Height=428
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

type dw_1 from u_dw within w_response_selecao_lista
int X=64
int Y=76
int Width=2345
int Height=324
int TabOrder=10
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
end type

event constructor;call super::constructor;ib_IsUpdateAble = False
end event

event pfc_retrieve;call super::pfc_retrieve;Return dw_2.Event pfc_Retrieve()
end event

event getfocus;call super::getfocus;//
cb_pesquisar.default = True
//
end event

event losefocus;call super::losefocus;//
cb_pesquisar.default = False
//
end event

type dw_2 from u_dw within w_response_selecao_lista
event type string formula_sql ( )
int X=64
int Y=504
int Width=2345
int Height=744
int TabOrder=30
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event constructor;call super::constructor;of_SetRowSelect(True)
ib_IsUpdateAble = False
this.SetRowFocusIndicator(FocusRect!)
end event

event pfc_retrieve;call super::pfc_retrieve;Long lvl_Linhas

String lvs_SQL

lvs_SQL = This.Event Formula_SQL()

dw_2.SetSQLSelect(lvs_SQL)

lvl_Linhas = This.Retrieve()

If lvl_Linhas > 0 Then
	cb_Selecionar.Enabled = True
	This.SetFocus()
	This.SetRow(1)
	This.SelectRow(1, TRUE)
Else
	cb_Selecionar.Enabled = False
	dw_1.SetFocus()
End If

Return lvl_Linhas
end event

event getfocus;call super::getfocus;//
cb_selecionar.default = True
//
end event

event losefocus;call super::losefocus;//
cb_selecionar.default = False
//
end event

type cb_selecionar from commandbutton within w_response_selecao_lista
int X=1838
int Y=1316
int Width=311
int Height=108
int TabOrder=40
boolean Enabled=false
boolean BringToTop=true
string Text="&Selecionar"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event losefocus;This.Default = False
end event

event getfocus;This.Default = True
end event

type cb_cancelar from commandbutton within w_response_selecao_lista
int X=2171
int Y=1316
int Width=274
int Height=108
int TabOrder=50
boolean BringToTop=true
string Text="&Cancelar"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;This.Default = True
end event

event losefocus;This.Default = False
end event

type cb_pesquisar from commandbutton within w_response_selecao_lista
int X=1399
int Y=1316
int Width=297
int Height=108
int TabOrder=20
boolean BringToTop=true
string Text="&Pesquisar"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SetPointer(HourGlass!)

// Recupera as informa$$HEX2$$e700f500$$ENDHEX$$es da DW de lista

dw_2.Event pfc_Retrieve()
end event

event getfocus;This.Default = True
end event

event losefocus;This.Default = False
end event

