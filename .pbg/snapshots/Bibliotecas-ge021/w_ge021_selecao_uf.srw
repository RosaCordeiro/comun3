HA$PBExportHeader$w_ge021_selecao_uf.srw
forward
global type w_ge021_selecao_uf from dc_w_selecao_generica
end type
end forward

global type w_ge021_selecao_uf from dc_w_selecao_generica
integer width = 2167
string title = "GE021 - Sele$$HEX2$$e700e300$$ENDHEX$$o UF"
end type
global w_ge021_selecao_uf w_ge021_selecao_uf

on w_ge021_selecao_uf.create
call super::create
end on

on w_ge021_selecao_uf.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.de_filtro [1] = Message.StringParm

dw_2.Event ue_Retrieve()
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge021_selecao_uf
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge021_selecao_uf
integer y = 220
integer width = 2089
integer height = 1068
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge021_selecao_uf
integer width = 1495
integer height = 188
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge021_selecao_uf
integer width = 1413
integer height = 88
string dataobject = "dw_ge021_selecao_uf"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge021_selecao_uf
integer y = 292
integer width = 2007
integer height = 968
string dataobject = "dw_ge021_lista_uf"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Filtro

dw_1.Accepttext( )

lvs_Filtro = dw_1.Object.de_filtro [1]

If (Not IsNull(lvs_Filtro)) and (lvs_Filtro <> "") Then
	This.OF_appendwhere("nm_unidade_federacao like '%"+lvs_Filtro+"%'")
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge021_selecao_uf
integer x = 1367
end type

event cb_selecionar::clicked;call super::clicked;String lvs_Codigo

If dw_2.GetRow() > 0 Then
	lvs_Codigo = String(dw_2.Object.cd_unidade_federacao [ dw_2.GetRow() ])
	CloseWithReturn(Parent,lvs_Codigo)
Else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Selecione um registro antes de confirmar.',Exclamation!)
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge021_selecao_uf
integer x = 1755
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent,'')
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge021_selecao_uf
integer x = 923
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge021_selecao_uf
integer width = 878
integer height = 116
end type

