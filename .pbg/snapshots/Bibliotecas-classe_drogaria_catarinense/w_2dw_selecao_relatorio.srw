HA$PBExportHeader$w_2dw_selecao_relatorio.srw
forward
global type w_2dw_selecao_relatorio from w_sheet
end type
type dw_selecao from u_dw within w_2dw_selecao_relatorio
end type
type dw_relatorio from u_dw within w_2dw_selecao_relatorio
end type
type gb_1 from groupbox within w_2dw_selecao_relatorio
end type
end forward

global type w_2dw_selecao_relatorio from w_sheet
int Width=1687
int Height=1176
boolean TitleBar=true
string Title="Relat$$HEX1$$f300$$ENDHEX$$rio de Altera$$HEX2$$e700f500$$ENDHEX$$es de Pre$$HEX1$$e700$$ENDHEX$$os"
dw_selecao dw_selecao
dw_relatorio dw_relatorio
gb_1 gb_1
end type
global w_2dw_selecao_relatorio w_2dw_selecao_relatorio

type variables
//
STRING		ivs_sql_original
//
end variables

on w_2dw_selecao_relatorio.create
int iCurrent
call super::create
this.dw_selecao=create dw_selecao
this.dw_relatorio=create dw_relatorio
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_selecao
this.Control[iCurrent+2]=this.dw_relatorio
this.Control[iCurrent+3]=this.gb_1
end on

on w_2dw_selecao_relatorio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_selecao)
destroy(this.dw_relatorio)
destroy(this.gb_1)
end on

event pfc_print;Long lvl_Linhas

SetPointer(HourGlass!)

// Recupera as linhas conforme os par$$HEX1$$e200$$ENDHEX$$metros
// informados na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
lvl_Linhas = dw_Relatorio.Event pfc_Retrieve()

// Verifica se foram encontradas as informa$$HEX2$$e700f500$$ENDHEX$$es
IF lvl_Linhas > 0 THEN
	// Executa o evento de impress$$HEX1$$e300$$ENDHEX$$o da PFC
	dw_Relatorio.Event pfc_Print()
ELSEIF lvl_linhas = 0 THEN
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem Informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!, Ok!)
END IF

RETURN 0
end event

event pfc_printimmediate;Long lvl_Linhas

SetPointer(HourGlass!)

// Recupera as linhas conforme os par$$HEX1$$e200$$ENDHEX$$metros
// informados na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
lvl_Linhas = dw_Relatorio.Event pfc_Retrieve()

// Verifica se foram encontradas as informa$$HEX2$$e700f500$$ENDHEX$$es
IF lvl_Linhas > 0 THEN
	// Executa o evento de impress$$HEX1$$e300$$ENDHEX$$o imediata da PFC
	dw_Relatorio.Event pfc_PrintImmediate()
ELSEIF lvl_linhas = 0 THEN
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o do relat$$HEX1$$f300$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o localizadas.", Information!, Ok!)
END IF

RETURN 0
end event

event pfc_postopen;call super::pfc_postopen;// Insere uma linha na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
dw_Selecao.Event pfc_AddRow()
dw_Selecao.SetFocus()
//
ivs_sql_original = dw_relatorio.GetSQLSelect()
//
end event

type dw_selecao from u_dw within w_2dw_selecao_relatorio
int X=46
int Y=88
int Width=1371
int Height=380
int TabOrder=10
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
end type

event constructor;call super::constructor;// Desabilita o Update da DW
ib_isUpdateAble = False
end event

type dw_relatorio from u_dw within w_2dw_selecao_relatorio
event type string formula_clausula_where ( )
int X=41
int Y=644
int Width=1545
int TabOrder=20
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event constructor;call super::constructor;// Desabilita o Update da DW
ib_IsUpdateAble = False

This.Modify("DataWindow.Print.Preview=Yes")
end event

event recuperar;call super::recuperar;//
RETURN THIS.Retrieve()
//
end event

event pfc_retrieve;call super::pfc_retrieve;//
BOOLEAN 	lvb_habilita
STRING	lvs_sql		, lvs_where

// Verifica qual a condi$$HEX2$$e700e300$$ENDHEX$$o de consulta
lvs_Where = This.Event Formula_Clausula_Where()

// Se faltar algum par$$HEX1$$e200$$ENDHEX$$metro de preenchimento retorna Erro
If lvs_Where = "ERRO" Then Return 0

// Concatena o SQL original com a condi$$HEX2$$e700e300$$ENDHEX$$o de consulta
lvs_SQL = ivs_SQL_Original + lvs_Where

// Atualiza o SQL da DW
This.SetSQLSelect(lvs_SQL)

RETURN This.Event Recuperar()

end event

type gb_1 from groupbox within w_2dw_selecao_relatorio
int X=27
int Y=16
int Width=1440
int Height=496
int TabOrder=10
string Text="Par$$HEX1$$e200$$ENDHEX$$metros de Sele$$HEX2$$e700e300$$ENDHEX$$o"
BorderStyle BorderStyle=StyleLowered!
long TextColor=8388608
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

