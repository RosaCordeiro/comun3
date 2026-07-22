HA$PBExportHeader$w_ge087_selecao_fabricante.srw
forward
global type w_ge087_selecao_fabricante from dc_w_selecao_generica
end type
end forward

global type w_ge087_selecao_fabricante from dc_w_selecao_generica
int Width=2450
int Height=1528
boolean TitleBar=true
string Title="GE087 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Fabricante"
long BackColor=80269524
end type
global w_ge087_selecao_fabricante w_ge087_selecao_fabricante

type variables
uo_fabricante ivo_fabricante
end variables

on w_ge087_selecao_fabricante.create
call super::create
end on

on w_ge087_selecao_fabricante.destroy
call super::destroy
end on

event open;call super::open;STRING lvs_Fabricante

ivo_Fabricante = Message.PowerObjectParm

lvs_Fabricante = ivo_Fabricante.ivs_Parametro_Selecao

If lvs_Fabricante <> "" Then
	dw_1.Object.nm_razao_social[1] = lvs_Fabricante
	ivb_Pesquisa_Direta = True
End If
end event

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge087_selecao_fabricante
int X=18
int Y=184
int Width=2377
int Height=1108
long BackColor=80269524
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge087_selecao_fabricante
int X=18
int Y=8
int Width=1563
int Height=172
long BackColor=80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge087_selecao_fabricante
int X=50
int Y=72
int Width=1504
int Height=88
boolean BringToTop=true
string DataObject="dw_ge087_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge087_selecao_fabricante
int X=55
int Y=256
int Width=2309
int Height=1012
boolean BringToTop=true
string DataObject="dw_ge087_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Sql, &
       lvs_Razao_Social

dw_1.AcceptText()

lvs_Razao_Social = Trim(dw_1.Object.Nm_Razao_Social[1])

If lvs_Razao_Social <> "" Then
	This.of_AppendWhere("nm_razao_social like '" + lvs_Razao_Social + "%'")
	Return 1
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge087_selecao_fabricante
int X=1637
boolean BringToTop=true
end type

event cb_selecionar::clicked;Long lvl_Linha, &
     lvl_Fabricante

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Fabricante = dw_2.Object.Cd_Fabricante[lvl_Linha]
	CloseWithReturn(Parent, String(lvl_Fabricante))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um fabricante.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge087_selecao_fabricante
int X=2025
boolean BringToTop=true
end type

event cb_cancelar::clicked;STRING lvs_Fabricante

SetNull(lvs_Fabricante)

CloseWithReturn(Parent, lvs_Fabricante)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge087_selecao_fabricante
int X=1193
boolean BringToTop=true
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge087_selecao_fabricante
boolean BringToTop=true
long BackColor=80269524
end type

