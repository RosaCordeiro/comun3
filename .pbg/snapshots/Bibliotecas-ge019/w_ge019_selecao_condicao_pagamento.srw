HA$PBExportHeader$w_ge019_selecao_condicao_pagamento.srw
forward
global type w_ge019_selecao_condicao_pagamento from dc_w_selecao_generica
end type
type gb_3 from groupbox within w_ge019_selecao_condicao_pagamento
end type
type dw_3 from dc_uo_dw_base within w_ge019_selecao_condicao_pagamento
end type
end forward

global type w_ge019_selecao_condicao_pagamento from dc_w_selecao_generica
integer x = 123
integer y = 336
integer width = 3493
integer height = 1728
string title = "GE019 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Condi$$HEX2$$e700f500$$ENDHEX$$es de Pagamento"
long backcolor = 80269524
gb_3 gb_3
dw_3 dw_3
end type
global w_ge019_selecao_condicao_pagamento w_ge019_selecao_condicao_pagamento

on w_ge019_selecao_condicao_pagamento.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.dw_3
end on

on w_ge019_selecao_condicao_pagamento.destroy
call super::destroy
destroy(this.gb_3)
destroy(this.dw_3)
end on

event open;call super::open;String lvs_Parametro

Decimal lvdc_Simulacao

Date lvdt_Simulacao

lvs_Parametro = Message.StringParm

If Trim(lvs_Parametro) <> "" Then
	lvdc_Simulacao = Dec(LeftA(lvs_Parametro, 7) + "," + MidA(lvs_Parametro, 8, 2))
	lvdt_Simulacao = Date(MidA(lvs_Parametro, 10, 10))
	
	dw_1.Object.Vl_Simulacao[1] = lvdc_Simulacao
	dw_1.Object.Dt_Simulacao[1] = lvdt_Simulacao
	dw_1.Object.De_Condicao [1] = MidA(lvs_Parametro, 20)
	
	ivb_Pesquisa_Direta = True
End If

end event

event ue_postopen;call super::ue_postopen;//id_mostra_ativo

// Matriz
If gvo_Parametro.cd_filial  = gvo_Parametro.cd_filial_matriz Then
	dw_1.Object.id_mostra_ativo.Visible = TRUE
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge019_selecao_condicao_pagamento
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge019_selecao_condicao_pagamento
integer x = 23
integer y = 352
integer width = 1769
integer height = 1136
long backcolor = 80269524
string text = "Lista de Condi$$HEX2$$e700f500$$ENDHEX$$es"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge019_selecao_condicao_pagamento
integer x = 23
integer y = 4
integer width = 1573
integer height = 336
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge019_selecao_condicao_pagamento
integer x = 50
integer y = 68
integer width = 1536
integer height = 260
string dataobject = "dw_ge019_selecao"
end type

event dw_1::editchanged;call super::editchanged;dw_2.Reset()
dw_3.Reset()
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge019_selecao_condicao_pagamento
integer x = 46
integer y = 404
integer width = 1723
integer height = 1064
string dataobject = "dw_ge019_lista_condicao"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Descricao, ls_DW, ls_Mostra_Ativo

Long lvl_Parcelas

dw_1.AcceptText()

lvs_Descricao 		= dw_1.Object.De_Condicao	[1]
lvl_Parcelas  		= dw_1.Object.Qt_Parcelas		[1]
ls_Mostra_Ativo	= dw_1.Object.id_mostra_ativo[1]

// Matriz
If gvo_Parametro.cd_filial  = gvo_Parametro.cd_filial_matriz Then
	ls_DW = "dw_ge019_lista_condicao_matriz"
Else
	ls_DW = "dw_ge019_lista_condicao"
End If

If This.DataObject <> ls_DW Then
	This.of_ChangeDataObject(ls_DW)
End If

// Matriz
If ls_DW = "dw_ge019_lista_condicao_matriz" Then
	If ls_Mostra_Ativo = 'S' Then
		This.of_AppendWhere("(id_situacao = 'A' or id_situacao is null)")
	End If
End If

If Not IsNull(lvs_Descricao) and Trim(lvs_Descricao) <> "" Then
	This.of_AppendWhere("de_condicao like '" + lvs_Descricao + "%'")
End If

If Not IsNull(lvl_Parcelas) and lvl_Parcelas > 0 Then
	This.of_AppendWhere("qt_parcelas = " + String(lvl_Parcelas))
End If

Return 1
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	dw_3.Event ue_Retrieve()
End If
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.of_SetRowSelection()

If pl_Linhas > 0 Then
	This.Event RowFocusChanged(1)
Else
	dw_3.Reset()
End If

Return pl_Linhas
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge019_selecao_condicao_pagamento
integer x = 2688
integer y = 1512
end type

event cb_selecionar::clicked;Long lvl_Linha

String lvs_Condicao

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Condicao = String(dw_2.Object.Cd_Condicao[lvl_Linha])
	CloseWithReturn(Parent, lvs_Condicao)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma condi$$HEX2$$e700e300$$ENDHEX$$o na lista.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge019_selecao_condicao_pagamento
integer x = 3077
integer y = 1512
end type

event cb_cancelar::clicked;String lvs_Condicao

SetNull(lvs_Condicao)

CloseWithReturn(Parent, lvs_Condicao)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge019_selecao_condicao_pagamento
integer x = 2245
integer y = 1512
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge019_selecao_condicao_pagamento
integer x = 23
integer y = 1512
long backcolor = 80269524
end type

type gb_3 from groupbox within w_ge019_selecao_condicao_pagamento
integer x = 1883
integer y = 352
integer width = 1563
integer height = 1136
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Parcelas da Condi$$HEX2$$e700e300$$ENDHEX$$o Selecionada"
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within w_ge019_selecao_condicao_pagamento
integer x = 1897
integer y = 404
integer width = 1527
integer height = 1064
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge019_lista_parcela"
boolean vscrollbar = true
end type

event ue_recuperar;// Override

Long lvl_Condicao

lvl_Condicao = dw_2.Object.Cd_Condicao[dw_2.GetRow()]

Return This.Retrieve(lvl_Condicao)
end event

event ue_postretrieve;Long lvl_Linha, &
     lvl_Dias

Date lvdt_Simulacao, &
     lvdt_Parcela

Decimal lvdc_Simulacao, &
        lvdc_Percentual, &
		  lvdc_Parcela

If pl_Linhas > 0 Then
	lvdt_Simulacao = dw_1.Object.Dt_Simulacao[1]
	lvdc_Simulacao = dw_1.Object.Vl_Simulacao[1]
	
	For lvl_Linha = 1 To pl_Linhas
		lvdc_Percentual = This.Object.Pc_Valor_Total    [lvl_Linha]
		lvl_Dias        = This.Object.Qt_Dias_Vencimento[lvl_Linha]
		
		lvdt_Parcela = RelativeDate(lvdt_Simulacao, lvl_Dias)
		lvdc_Parcela = Round(lvdc_Simulacao * lvdc_Percentual / 100, 2)
		
		This.Object.Dt_Parcela[lvl_Linha] = lvdt_Parcela
		This.Object.Vl_Parcela[lvl_Linha] = lvdc_Parcela
	Next
End If

Return pl_Linhas
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

