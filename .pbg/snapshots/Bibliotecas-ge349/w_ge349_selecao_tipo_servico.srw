HA$PBExportHeader$w_ge349_selecao_tipo_servico.srw
forward
global type w_ge349_selecao_tipo_servico from dc_w_selecao_generica
end type
end forward

global type w_ge349_selecao_tipo_servico from dc_w_selecao_generica
integer width = 1879
integer height = 1548
string title = "GE349 - Sele$$HEX2$$e700e300$$ENDHEX$$o Tipo Servi$$HEX1$$e700$$ENDHEX$$o"
end type
global w_ge349_selecao_tipo_servico w_ge349_selecao_tipo_servico

on w_ge349_selecao_tipo_servico.create
call super::create
end on

on w_ge349_selecao_tipo_servico.destroy
call super::destroy
end on

event open;call super::open;String lvs_Pesquisa

lvs_Pesquisa = Message.StringParm

If Not(IsNull(lvs_Pesquisa)) and (Trim(lvs_Pesquisa) <> '') Then
	dw_1.Object.de_tipo [1] = lvs_Pesquisa
	
	dw_2.Event ue_Retrieve()
End If


end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge349_selecao_tipo_servico
boolean visible = false
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge349_selecao_tipo_servico
integer y = 196
integer width = 1787
integer height = 1096
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge349_selecao_tipo_servico
integer width = 1399
integer height = 184
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge349_selecao_tipo_servico
integer width = 1317
integer height = 100
string dataobject = "dw_ge349_tipo_serv_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge349_selecao_tipo_servico
integer y = 268
integer width = 1705
integer height = 996
string dataobject = "dw_ge349_lista_tipo_servico"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Tipo

dw_1.Accepttext( )

lvs_Tipo 	= dw_1.Object.de_tipo	[1]

If Not(IsNull(lvs_Tipo)) and (Trim(lvs_Tipo) <> '') Then
	This.of_appendwhere("Upper(ts.de_tipo) like '%"+Upper(lvs_Tipo)+"%'")
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge349_selecao_tipo_servico
integer x = 1061
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha
Long lvl_Tipo

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Tipo = dw_2.Object.cd_tipo [lvl_Linha]
	CloseWithReturn(Parent, String(lvl_Tipo))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Selecione um Tipo de Servi$$HEX1$$e700$$ENDHEX$$o.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge349_selecao_tipo_servico
integer x = 1449
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent, '0')
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge349_selecao_tipo_servico
integer x = 617
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge349_selecao_tipo_servico
boolean visible = false
integer width = 1134
integer height = 184
end type

