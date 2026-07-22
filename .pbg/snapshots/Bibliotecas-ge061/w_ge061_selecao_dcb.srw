HA$PBExportHeader$w_ge061_selecao_dcb.srw
forward
global type w_ge061_selecao_dcb from dc_w_selecao_generica
end type
end forward

global type w_ge061_selecao_dcb from dc_w_selecao_generica
int Width=2176
int Height=1528
boolean TitleBar=true
string Title="GE061 - Sele$$HEX2$$e700e300$$ENDHEX$$o de DCB's"
long BackColor=80269524
end type
global w_ge061_selecao_dcb w_ge061_selecao_dcb

type variables
uo_fabricante ivo_fabricante
end variables

on w_ge061_selecao_dcb.create
call super::create
end on

on w_ge061_selecao_dcb.destroy
call super::destroy
end on

event open;call super::open;String lvs_Parametro

lvs_Parametro = Message.StringParm

If lvs_Parametro <> "" Then
	dw_1.Object.De_DCB[1] = lvs_Parametro
	
	ivb_Pesquisa_Direta = True
End If
end event

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge061_selecao_dcb
int X=18
int Y=184
int Width=2112
int Height=1108
string Text="Lista de DCB's"
long BackColor=80269524
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge061_selecao_dcb
int X=18
int Y=8
int Width=1577
int Height=172
long BackColor=80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge061_selecao_dcb
int X=46
int Y=72
int Width=1541
int Height=88
boolean BringToTop=true
string DataObject="dw_ge061_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge061_selecao_dcb
int X=41
int Y=232
int Width=2071
int Height=1044
boolean BringToTop=true
string DataObject="dw_ge061_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Descricao

dw_1.AcceptText()

lvs_Descricao = dw_1.Object.De_DCB[1]

If lvs_Descricao <> "" Then
	This.of_AppendWhere("de_dcb like '" + lvs_Descricao + "%'")
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge061_selecao_dcb
int X=1371
boolean BringToTop=true
end type

event cb_selecionar::clicked;Long lvl_Linha

String lvs_DCB

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_DCB = dw_2.Object.Cd_DCB[lvl_Linha]
	
	CloseWithReturn(Parent, lvs_DCB)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um DCB.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge061_selecao_dcb
int X=1760
boolean BringToTop=true
end type

event cb_cancelar::clicked;String lvs_DCB

SetNull(lvs_DCB)

CloseWithReturn(Parent, lvs_DCB)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge061_selecao_dcb
int X=928
boolean BringToTop=true
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge061_selecao_dcb
int Width=859
boolean BringToTop=true
long BackColor=80269524
end type

