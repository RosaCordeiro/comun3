HA$PBExportHeader$w_ge191_selecao_motivo_ajuste.srw
forward
global type w_ge191_selecao_motivo_ajuste from dc_w_selecao_generica
end type
end forward

global type w_ge191_selecao_motivo_ajuste from dc_w_selecao_generica
integer width = 2510
integer height = 1548
string title = "GE191 - Sele$$HEX2$$e700e300$$ENDHEX$$o Motivo Ajuste Estoque"
end type
global w_ge191_selecao_motivo_ajuste w_ge191_selecao_motivo_ajuste

on w_ge191_selecao_motivo_ajuste.create
call super::create
end on

on w_ge191_selecao_motivo_ajuste.destroy
call super::destroy
end on

event ue_preopen;call super::ue_preopen;String lvs_Motivo

lvs_Motivo = Message.StringParm

If lvs_Motivo <> "" Then
	dw_1.Object.De_filtro [1] = lvs_Motivo
	This.ivb_Pesquisa_Direta = True
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge191_selecao_motivo_ajuste
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge191_selecao_motivo_ajuste
integer y = 216
integer height = 1064
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge191_selecao_motivo_ajuste
integer width = 1536
integer height = 184
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge191_selecao_motivo_ajuste
integer width = 1467
integer height = 84
string dataobject = "dw_ge191_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge191_selecao_motivo_ajuste
integer y = 288
integer width = 2350
integer height = 964
string dataobject = "dw_ge191_lista_selecao"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Filtro

dw_1.Accepttext( )

lvs_Filtro = dw_1.Object.de_filtro [1]

If (Not IsNull(lvs_Filtro)) and (Trim(lvs_Filtro)<>"") Then
	This.Of_appendwhere("de_motivo_ajuste like '%"+lvs_Filtro+"%'")
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge191_selecao_motivo_ajuste
end type

event cb_selecionar::clicked;call super::clicked;Long	lvl_Linha, &
		lvl_Motivo

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Motivo = dw_2.Object.cd_motivo_ajuste [lvl_Linha]
	CloseWithReturn(Parent, String(lvl_Motivo))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma conta.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge191_selecao_motivo_ajuste
string text = "Cancelar"
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent,'')
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge191_selecao_motivo_ajuste
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge191_selecao_motivo_ajuste
end type

