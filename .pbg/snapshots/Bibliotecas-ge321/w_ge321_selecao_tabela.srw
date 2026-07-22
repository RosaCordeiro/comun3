HA$PBExportHeader$w_ge321_selecao_tabela.srw
forward
global type w_ge321_selecao_tabela from dc_w_selecao_generica
end type
end forward

global type w_ge321_selecao_tabela from dc_w_selecao_generica
integer width = 1934
string title = "GE321 - Sele$$HEX2$$e700e300$$ENDHEX$$o Tabela"
end type
global w_ge321_selecao_tabela w_ge321_selecao_tabela

type variables
String ivs_Pesquisa
String ivs_Filtro_Tabelas
end variables

on w_ge321_selecao_tabela.create
call super::create
end on

on w_ge321_selecao_tabela.destroy
call super::destroy
end on

event ue_preopen;call super::ue_preopen;String lvs_Parametro

lvs_Parametro 		= Message.StringParm
ivs_Pesquisa		= Mid(lvs_Parametro, 1, Pos(lvs_Parametro, ";")-1)
ivs_Filtro_Tabelas = Mid(lvs_Parametro, Pos(lvs_Parametro, ";")+1)
end event

event ue_postopen;call super::ue_postopen;If (Not IsNull(ivs_Pesquisa)) and (Trim(ivs_Pesquisa)<>'') Then
	dw_1.Object.de_filtro [1] = ivs_Pesquisa
	dw_2.Event ue_Retrieve()
	dw_2.SetFocus()
Else
	dw_1.Event ue_Pos(1,'de_filtro')
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge321_selecao_tabela
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge321_selecao_tabela
integer y = 200
integer width = 1861
integer height = 1096
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge321_selecao_tabela
integer width = 1861
integer height = 180
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge321_selecao_tabela
integer width = 1778
integer height = 80
string dataobject = "dw_ge321_selecao_tabela"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge321_selecao_tabela
integer y = 272
integer width = 1806
integer height = 996
string dataobject = "dw_ge321_lista_tabela"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Filtro

dw_1.accepttext( )
lvs_Filtro = dw_1.Object.de_filtro [1]

If lvs_Filtro <> "" Then
	This.Of_AppendWhere("a.nm_tabela like '%"+lvs_Filtro+"%'", 1)
	This.Of_AppendWhere("upper(o.name) like '%"+lvs_Filtro+"%'", 2)
End If

If ivs_Filtro_Tabelas <> "" Then
	This.Of_AppendWhere("a.nm_tabela in ('"+gf_replace(gf_replace(ivs_Filtro_Tabelas, ",", "','", 0), " ", "", 0)+"')", 1)
	This.Of_AppendWhere("upper(o.name) in ('"+gf_replace(gf_replace(ivs_Filtro_Tabelas, ",", "','", 0), " ", "", 0)+"')", 2)
End If

Return AncestorReturnValue
end event

event dw_2::doubleclicked;call super::doubleclicked;cb_selecionar.event clicked( )
end event

event dw_2::ue_recuperar;//override
Return This.Retrieve(gvo_aplicacao.ivo_seguranca.cd_sistema)
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge321_selecao_tabela
integer x = 1134
boolean default = false
end type

event cb_selecionar::clicked;call super::clicked;String lvs_Tabela
Long lvl_Linha

lvl_Linha = dw_2.GetRow()

If (Not IsNull(lvl_Linha))and(lvl_Linha > 0) Then
	lvs_Tabela = dw_2.Object.nm_tabela [lvl_Linha]
	CloseWithReturn(Parent,lvs_Tabela)
Else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Selecione um registro antes de confirmar!')
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge321_selecao_tabela
integer x = 1522
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent,'')
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge321_selecao_tabela
integer x = 690
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge321_selecao_tabela
boolean visible = false
end type

