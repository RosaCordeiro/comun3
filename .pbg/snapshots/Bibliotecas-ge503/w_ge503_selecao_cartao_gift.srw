HA$PBExportHeader$w_ge503_selecao_cartao_gift.srw
forward
global type w_ge503_selecao_cartao_gift from dc_w_selecao_generica
end type
end forward

global type w_ge503_selecao_cartao_gift from dc_w_selecao_generica
end type
global w_ge503_selecao_cartao_gift w_ge503_selecao_cartao_gift

on w_ge503_selecao_cartao_gift.create
call super::create
end on

on w_ge503_selecao_cartao_gift.destroy
call super::destroy
end on

event open;call super::open;String lvs_Parametro

lvs_Parametro = Message.StringParm

If lvs_Parametro <> "" Then
	dw_1.Object.Nm_Cartao[1] = lvs_Parametro
End If

ivb_Pesquisa_Direta = True
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge503_selecao_cartao_gift
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge503_selecao_cartao_gift
integer y = 192
integer height = 1104
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge503_selecao_cartao_gift
integer width = 1819
integer height = 176
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge503_selecao_cartao_gift
integer width = 1746
integer height = 76
string dataobject = "dw_ge503_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge503_selecao_cartao_gift
integer y = 264
integer height = 996
string dataobject = "dw_ge503_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Descricao

dw_1.AcceptText()

lvs_Descricao = dw_1.Object.Nm_Cartao[1]

If lvs_Descricao <> "" Then
	If IsNumber(lvs_Descricao) Then
		This.Of_AppendWhere("nm_cartao = " + lvs_Descricao)
	Else
		This.Of_AppendWhere("nm_cartao like '" + lvs_Descricao +"%'")
	End If
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge503_selecao_cartao_gift
integer y = 1344
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha, &
     lvl_Cartao

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Cartao = dw_2.Object.Cd_Cartao[lvl_Linha]
	CloseWithReturn(Parent, String(lvl_Cartao))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o Cart$$HEX1$$e300$$ENDHEX$$o Gift.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge503_selecao_cartao_gift
integer y = 1344
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn ( Parent, 0 )
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge503_selecao_cartao_gift
integer y = 1344
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge503_selecao_cartao_gift
integer y = 1344
end type

