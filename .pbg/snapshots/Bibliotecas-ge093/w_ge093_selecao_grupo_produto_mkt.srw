HA$PBExportHeader$w_ge093_selecao_grupo_produto_mkt.srw
forward
global type w_ge093_selecao_grupo_produto_mkt from dc_w_selecao_generica
end type
end forward

global type w_ge093_selecao_grupo_produto_mkt from dc_w_selecao_generica
int X=494
int Y=436
int Width=2491
int Height=1520
boolean TitleBar=true
string Title="GE093 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Grupos do Marketing"
long BackColor=80269524
end type
global w_ge093_selecao_grupo_produto_mkt w_ge093_selecao_grupo_produto_mkt

type variables
uo_grupo_produto_mkt ivo_grupo_produto_mkt


end variables

on w_ge093_selecao_grupo_produto_mkt.create
call super::create
end on

on w_ge093_selecao_grupo_produto_mkt.destroy
call super::destroy
end on

event open;call super::open;String lvs_Grupo

ivo_Grupo_Produto_MKT = Message.PowerObjectParm

lvs_Grupo = ivo_Grupo_Produto_MKT.ivs_Parametro_Selecao

If lvs_Grupo <> "" Then
	dw_1.Object.de_grupo[1] = lvs_Grupo
	ivb_Pesquisa_Direta = True
End If

end event

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge093_selecao_grupo_produto_mkt
int X=18
int Y=188
int Width=2432
int Height=1096
string Text="Lista de Grupos"
long BackColor=80269524
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge093_selecao_grupo_produto_mkt
int X=18
int Y=4
int Width=1381
int Height=176
long BackColor=80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge093_selecao_grupo_produto_mkt
int X=32
int Y=64
int Width=1339
int Height=96
boolean BringToTop=true
string DataObject="dw_ge093_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge093_selecao_grupo_produto_mkt
int X=55
int Y=240
int Width=2368
int Height=1008
boolean BringToTop=true
string DataObject="dw_ge093_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Grupo

dw_1.AcceptText()

lvs_Grupo = Trim(dw_1.Object.de_grupo[1])

If lvs_Grupo <> "" Then
	This.of_AppendWhere("p.de_grupo like '" + lvs_Grupo + "%'")
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge093_selecao_grupo_produto_mkt
int X=1682
int Y=1308
boolean BringToTop=true
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha, &
     lvl_Grupo

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Grupo = dw_2.Object.cd_grupo[lvl_Linha]
	CloseWithReturn(Parent, String(lvl_Grupo))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um grupo.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge093_selecao_grupo_produto_mkt
int X=2075
int Y=1308
boolean BringToTop=true
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Grupo

SetNull(lvs_Grupo)

CloseWithReturn(Parent, lvs_Grupo)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge093_selecao_grupo_produto_mkt
int X=1262
int Y=1308
boolean BringToTop=true
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge093_selecao_grupo_produto_mkt
int X=23
int Y=1320
int Width=1207
boolean BringToTop=true
long BackColor=80269524
end type

