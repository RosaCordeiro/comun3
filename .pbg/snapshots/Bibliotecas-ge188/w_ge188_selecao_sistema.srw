HA$PBExportHeader$w_ge188_selecao_sistema.srw
forward
global type w_ge188_selecao_sistema from dc_w_selecao_generica
end type
end forward

global type w_ge188_selecao_sistema from dc_w_selecao_generica
integer width = 1838
string title = "GE188 - Sele$$HEX2$$e700e300$$ENDHEX$$o Sistema"
end type
global w_ge188_selecao_sistema w_ge188_selecao_sistema

on w_ge188_selecao_sistema.create
call super::create
end on

on w_ge188_selecao_sistema.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;String lvs_Filtro

lvs_Filtro = Message.StringParm
dw_1.Object.nm_sistema [1] = lvs_Filtro

If (Not IsNull(lvs_Filtro)) and (lvs_Filtro <> '') Then
	dw_2.Event ue_Retrieve()
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge188_selecao_sistema
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge188_selecao_sistema
integer y = 204
integer width = 1760
integer height = 1080
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge188_selecao_sistema
integer width = 1573
integer height = 180
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge188_selecao_sistema
integer width = 1522
integer height = 92
string dataobject = "dw_ge188_selecao_sistema"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge188_selecao_sistema
integer y = 276
integer width = 1710
integer height = 980
string dataobject = "dw_ge188_lista_selecao_sistema"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Descricao

dw_1.AcceptText( )

lvs_Descricao	= dw_1.Object.nm_sistema	[1]

If (Not IsNull(lvs_Descricao)) and (Trim(lvs_Descricao)<>'') Then
	This.Of_AppendWhere("upper(nm_sistema) like '%"+lvs_Descricao+"%'")
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge188_selecao_sistema
integer x = 1033
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha
String lvs_Sistema

lvl_Linha = dw_2.GetRow()
If lvl_Linha > 0 Then
	lvs_Sistema = dw_2.Object.cd_sistema [lvl_Linha]
	
	CloseWithReturn(Parent,lvs_Sistema)
Else
	cb_cancelar.Event Clicked( )
End If

end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge188_selecao_sistema
integer x = 1422
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent,'')
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge188_selecao_sistema
integer x = 590
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge188_selecao_sistema
integer width = 521
integer height = 128
end type

