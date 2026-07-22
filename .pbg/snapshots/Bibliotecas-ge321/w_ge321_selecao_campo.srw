HA$PBExportHeader$w_ge321_selecao_campo.srw
forward
global type w_ge321_selecao_campo from dc_w_selecao_generica
end type
end forward

global type w_ge321_selecao_campo from dc_w_selecao_generica
integer width = 1934
string title = "GE321 - Sele$$HEX2$$e700e300$$ENDHEX$$o Campo LOG"
end type
global w_ge321_selecao_campo w_ge321_selecao_campo

type variables
uo_campo_log ivo_campo
end variables

on w_ge321_selecao_campo.create
call super::create
end on

on w_ge321_selecao_campo.destroy
call super::destroy
end on

event ue_preopen;call super::ue_preopen;ivo_campo = Message.PowerObjectParm

end event

event ue_postopen;call super::ue_postopen;dw_1.Object.nm_tabela [1] = ivo_campo.Tabela

If (Not IsNull(ivo_campo.Campo))and(Trim(ivo_campo.Campo)<>'') Then
	dw_1.Object.de_filtro [1] = ivo_campo.Campo
	dw_2.Event ue_Retrieve()
	dw_2.SetFocus()
Else
	dw_1.Event ue_Pos(1,'de_filtro')
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge321_selecao_campo
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge321_selecao_campo
integer y = 276
integer width = 1861
integer height = 1020
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge321_selecao_campo
integer width = 1861
integer height = 252
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge321_selecao_campo
integer width = 1778
integer height = 152
string dataobject = "dw_ge321_selecao_campo"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge321_selecao_campo
integer y = 348
integer width = 1806
integer height = 920
string dataobject = "dw_ge321_lista_campos"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Filtro
String lvs_Tabela

dw_1.accepttext( )
lvs_Filtro		= dw_1.Object.de_filtro		[1]
lvs_Tabela	= dw_1.Object.nm_tabela	[1]

If lvs_Tabela <> "" Then 
	This.Of_AppendWhere("a.nm_tabela = '"+Upper(lvs_Tabela)+"'", 1)
	This.Of_AppendWhere("a.nm_tabela = '"+Upper(lvs_Tabela)+"'", 2)
	This.Of_AppendWhere("upper(o.name) = '"+Upper(lvs_Tabela)+"'", 3)
End If

If lvs_Filtro <> "" Then 
	This.Of_AppendWhere("(upper(b.de_coluna) like '%"+Upper(lvs_Filtro)+"%' or a.nm_coluna like '%"+Upper(lvs_Filtro)+"%')", 1)
	This.Of_AppendWhere("(upper(b.de_coluna) like '%"+Upper(lvs_Filtro)+"%' or upper(c.name) like '%"+Upper(lvs_Filtro)+"%')", 2)
	This.Of_AppendWhere("(upper(b.de_coluna) like '%"+Upper(lvs_Filtro)+"%' or upper(c.name) like '%"+Upper(lvs_Filtro)+"%')", 3)	
	
	If ivo_campo.Filtro_Campos <> "" Then
		This.Of_AppendWhere("(upper(b.de_coluna) in ('"+gf_replace(ivo_campo.Filtro_Campos, ",", "','", 0)+"') or a.nm_coluna in ('"+gf_replace(ivo_campo.Filtro_Campos, ",", "','", 0)+"'))", 1)
		This.Of_AppendWhere("(upper(b.de_coluna) in ('"+gf_replace(ivo_campo.Filtro_Campos, ",", "','", 0)+"') or upper(c.name) in ('"+gf_replace(ivo_campo.Filtro_Campos, ",", "','", 0)+"'))", 2)
		This.Of_AppendWhere("(upper(b.de_coluna) in ('"+gf_replace(ivo_campo.Filtro_Campos, ",", "','", 0)+"') or upper(c.name) in ('"+gf_replace(ivo_campo.Filtro_Campos, ",", "','", 0)+"'))", 3)
	End If
End If

Return AncestorReturnValue
end event

event dw_2::doubleclicked;call super::doubleclicked;cb_selecionar.event clicked( )
end event

event dw_2::ue_recuperar;//override
Return This.Retrieve(gvo_aplicacao.ivo_seguranca.cd_sistema)
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge321_selecao_campo
integer x = 1134
boolean default = false
end type

event cb_selecionar::clicked;call super::clicked;String lvs_Coluna 
Long lvl_Linha

lvl_Linha = dw_2.GetRow()

If (Not IsNull(lvl_Linha))and(lvl_Linha > 0) Then
	lvs_Coluna = dw_2.Object.nm_coluna [lvl_Linha]
	CloseWithReturn(Parent,lvs_Coluna)
Else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Selecione um registro antes de confirmar!')
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge321_selecao_campo
integer x = 1522
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent,'')
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge321_selecao_campo
integer x = 690
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge321_selecao_campo
boolean visible = false
end type

