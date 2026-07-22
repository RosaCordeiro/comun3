HA$PBExportHeader$w_ge021_selecao_tributacao.srw
forward
global type w_ge021_selecao_tributacao from dc_w_selecao_generica
end type
end forward

global type w_ge021_selecao_tributacao from dc_w_selecao_generica
integer width = 3045
string title = "GE021 - Sele$$HEX2$$e700e300$$ENDHEX$$o Tributa$$HEX2$$e700e300$$ENDHEX$$o CBS/IBS / IS"
end type
global w_ge021_selecao_tributacao w_ge021_selecao_tributacao

on w_ge021_selecao_tributacao.create
call super::create
end on

on w_ge021_selecao_tributacao.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;String	ls_Param

ls_Param = Message.StringParm

If Not IsNull (ls_Param) and Trim (ls_Param) <> '' then
	dw_1.Object.de_pesquisa [1] = ls_Param
	
	dw_2.Post Event ue_Retrieve()
End if
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge021_selecao_tributacao
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge021_selecao_tributacao
integer y = 224
integer width = 2990
integer height = 1056
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge021_selecao_tributacao
integer width = 1655
integer height = 188
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge021_selecao_tributacao
integer width = 1595
integer height = 104
string dataobject = "dw_ge021_selecao_tributacao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge021_selecao_tributacao
integer y = 296
integer width = 2939
integer height = 956
string dataobject = "dw_ge021_lista_tributacao"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String	ls_Pesq

dw_1.Accepttext ()

ls_Pesq = dw_1.Object.de_pesquisa [1]

If Not IsNull (ls_Pesq) and Trim (ls_Pesq) <> '' then
	This.of_AppendWhere ("it.id_imposto_tributacao LIKE '%" + ls_Pesq + "%' or " + &
								"it.de_imposto_tributacao LIKE '%" + ls_Pesq + "%'")
End if

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge021_selecao_tributacao
integer x = 2258
integer y = 1368
end type

event cb_selecionar::clicked;call super::clicked;Long		ll_Linha
String	ls_id_imposto_tributacao

ll_Linha = dw_2.GetRow ()

If ll_Linha > 0 then
	ls_id_imposto_tributacao = dw_2.Object.id_imposto_tributacao [ll_Linha]
	CloseWithReturn (Parent,  ls_id_imposto_tributacao)
else
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o!', 'Selecione um registro e depois clique em selecionar!', Exclamation!)
End if
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge021_selecao_tributacao
integer x = 2647
integer y = 1368
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn (Parent, '')
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge021_selecao_tributacao
integer x = 1815
integer y = 1368
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge021_selecao_tributacao
integer y = 1292
end type

