HA$PBExportHeader$w_ge067_selecao_banco.srw
forward
global type w_ge067_selecao_banco from dc_w_selecao_generica
end type
end forward

global type w_ge067_selecao_banco from dc_w_selecao_generica
integer x = 1024
integer width = 1664
integer height = 1540
string title = "GE067 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Bancos"
end type
global w_ge067_selecao_banco w_ge067_selecao_banco

type variables
uo_banco ivo_banco


end variables

on w_ge067_selecao_banco.create
call super::create
end on

on w_ge067_selecao_banco.destroy
call super::destroy
end on

event open;call super::open;STRING lvs_Filial

ivo_Banco = Message.PowerObjectParm

lvs_Filial = ivo_Banco.ivs_Parametro_Selecao

If lvs_Filial <> "" Then
	
	dw_1.Object.nm_banco[1] = lvs_Filial
	
	ivb_Pesquisa_Direta = True
	
End If

end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge067_selecao_banco
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge067_selecao_banco
integer x = 18
integer y = 196
integer width = 1605
integer height = 1092
string text = "Lista de Filiais"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge067_selecao_banco
integer x = 18
integer width = 1605
integer height = 176
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge067_selecao_banco
integer x = 32
integer y = 64
integer width = 1573
integer height = 104
string dataobject = "dw_selecao_generica_banco"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge067_selecao_banco
integer x = 32
integer y = 252
integer width = 1554
integer height = 1016
string dataobject = "dw_lista_generica_banco"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_banco

dw_1.AcceptText()

lvs_banco = Trim(dw_1.Object.nm_banco[1])

If lvs_banco <> "" Then
	This.of_AppendWhere("nm_banco like '" + lvs_banco + "%'")
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge067_selecao_banco
integer x = 869
end type

event cb_selecionar::clicked;Long   lvl_Linha

String lvs_Banco

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Banco = dw_2.Object.cd_banco[lvl_Linha]
	CloseWithReturn(Parent,lvs_Banco)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma banco.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge067_selecao_banco
integer x = 1253
end type

event cb_cancelar::clicked;call super::clicked;STRING lvs_Filial

SetNull(lvs_Filial)

CloseWithReturn(Parent, lvs_Filial)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge067_selecao_banco
integer x = 480
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge067_selecao_banco
boolean visible = false
integer x = 37
integer y = 1324
integer width = 814
end type

