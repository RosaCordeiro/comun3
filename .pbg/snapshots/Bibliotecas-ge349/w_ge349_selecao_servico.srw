HA$PBExportHeader$w_ge349_selecao_servico.srw
forward
global type w_ge349_selecao_servico from dc_w_selecao_generica
end type
end forward

global type w_ge349_selecao_servico from dc_w_selecao_generica
integer width = 2473
string title = "GE349 - Sele$$HEX2$$e700e300$$ENDHEX$$o Servi$$HEX1$$e700$$ENDHEX$$o"
end type
global w_ge349_selecao_servico w_ge349_selecao_servico

on w_ge349_selecao_servico.create
call super::create
end on

on w_ge349_selecao_servico.destroy
call super::destroy
end on

event open;call super::open;String lvs_Pesquisa

lvs_Pesquisa = Message.StringParm

If Not(IsNull(lvs_Pesquisa)) and (Trim(lvs_Pesquisa) <> '') Then
	dw_1.Object.nm_servico [1] = lvs_Pesquisa
	
	dw_2.Event ue_Retrieve()
End If


end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge349_selecao_servico
boolean visible = false
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge349_selecao_servico
integer y = 292
integer width = 2400
integer height = 988
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge349_selecao_servico
integer width = 1321
integer height = 272
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge349_selecao_servico
integer width = 1239
integer height = 188
string dataobject = "dw_ge349_servico_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge349_selecao_servico
integer y = 364
integer width = 2318
integer height = 888
string dataobject = "dw_ge349_lista_servico"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Servico

Long lvl_Tipo

dw_1.Accepttext( )

lvs_Servico 	= dw_1.Object.nm_servico	[1]
lvl_Tipo		= dw_1.Object.cd_tipo		[1]

If Not(IsNull(lvs_Servico)) and (Trim(lvs_Servico) <> '') Then
	This.of_appendwhere("Upper(s.nm_servico) like '%"+Upper(lvs_Servico)+"%'")
End If

If Not(IsNull(lvl_Tipo)) and (lvl_Tipo > 0) Then
	This.of_appendwhere("ts.cd_tipo ="+String(lvl_Tipo))
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge349_selecao_servico
integer x = 1678
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha
Long lvl_Servico

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Servico = dw_2.Object.cd_servico [lvl_Linha]
	CloseWithReturn(Parent, String(lvl_Servico))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um servi$$HEX1$$e700$$ENDHEX$$o.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge349_selecao_servico
integer x = 2066
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent, '0')
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge349_selecao_servico
integer x = 1234
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge349_selecao_servico
end type

