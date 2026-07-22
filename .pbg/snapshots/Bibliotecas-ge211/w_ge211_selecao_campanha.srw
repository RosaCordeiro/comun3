HA$PBExportHeader$w_ge211_selecao_campanha.srw
forward
global type w_ge211_selecao_campanha from dc_w_selecao_generica
end type
end forward

global type w_ge211_selecao_campanha from dc_w_selecao_generica
integer width = 2606
integer height = 1540
string title = "GE211 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Campanhas"
end type
global w_ge211_selecao_campanha w_ge211_selecao_campanha

on w_ge211_selecao_campanha.create
call super::create
end on

on w_ge211_selecao_campanha.destroy
call super::destroy
end on

event open;call super::open;String lvs_Parametro

lvs_Parametro = Message.StringParm

If lvs_Parametro <> "" Then
	dw_1.Object.nm_campanha[1] = lvs_Parametro
End If

ivb_Pesquisa_Direta = True
end event

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge211_selecao_campanha
integer y = 248
integer width = 2523
integer height = 1040
long backcolor = 67108864
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge211_selecao_campanha
integer width = 2085
integer height = 216
long backcolor = 67108864
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge211_selecao_campanha
integer x = 55
integer y = 96
integer width = 2039
integer height = 84
string dataobject = "dw_ge211_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge211_selecao_campanha
integer y = 320
integer width = 2446
integer height = 948
string dataobject = "dw_ge211_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Descricao

dw_1.AcceptText()

lvs_Descricao = dw_1.Object.nm_campanha[1]

If lvs_Descricao <> "" Then
	If IsNumber(lvs_Descricao) Then
		This.Of_AppendWhere("nr_campanha = " + lvs_Descricao)
	Else
		This.Of_AppendWhere("nm_campanha like '" + lvs_Descricao +"%'")
	End If
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge211_selecao_campanha
integer x = 1801
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha, &
     lvl_Campanha

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Campanha = dw_2.Object.nr_campanha[lvl_Linha]
	CloseWithReturn(Parent, String(lvl_campanha))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma campanha na lista.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge211_selecao_campanha
integer x = 2190
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Nulo

SetNull(lvs_Nulo)

CloseWithReturn(Parent, lvs_Nulo)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge211_selecao_campanha
integer x = 1358
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge211_selecao_campanha
long backcolor = 67108864
end type

