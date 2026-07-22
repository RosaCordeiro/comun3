HA$PBExportHeader$w_ge101_consulta_estoque_produto.srw
forward
global type w_ge101_consulta_estoque_produto from dc_w_response
end type
type gb_2 from groupbox within w_ge101_consulta_estoque_produto
end type
type gb_1 from groupbox within w_ge101_consulta_estoque_produto
end type
type dw_1 from dc_uo_dw_base within w_ge101_consulta_estoque_produto
end type
type cb_fechar from commandbutton within w_ge101_consulta_estoque_produto
end type
type dw_2 from dc_uo_dw_base within w_ge101_consulta_estoque_produto
end type
type cb_1 from commandbutton within w_ge101_consulta_estoque_produto
end type
type cb_2 from commandbutton within w_ge101_consulta_estoque_produto
end type
end forward

global type w_ge101_consulta_estoque_produto from dc_w_response
integer x = 599
integer y = 32
integer width = 1897
integer height = 1876
string title = "GE101 - Consulta Estoque do Produto"
boolean controlmenu = false
long backcolor = 80269524
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
cb_fechar cb_fechar
dw_2 dw_2
cb_1 cb_1
cb_2 cb_2
end type
global w_ge101_consulta_estoque_produto w_ge101_consulta_estoque_produto

type variables
long ivl_produto,&
        ivl_filial

string ivs_descricao

String ivs_filiais

String is_Saldo_Negativo

String is_Loja_Aberta

uo_ge216_filiais uo_filiais
end variables

on w_ge101_consulta_estoque_produto.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.cb_fechar=create cb_fechar
this.dw_2=create dw_2
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_fechar
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_2
end on

on w_ge101_consulta_estoque_produto.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cb_fechar)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;String lvs_Parametro

lvs_Parametro = Message.StringParm

ivl_Filial	  = Long(LeftA(lvs_Parametro, 4))
ivl_Produto   = Long(MidA(lvs_Parametro, 5, 6))
ivs_Descricao = MidA(lvs_Parametro, 11)

end event

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()

dw_1.Object.Cd_Produto[1] = ivl_Produto
dw_1.Object.De_Produto[1] = ivs_Descricao

uo_filiais = Create uo_ge216_filiais 

dw_2.Event ue_Retrieve()
end event

event close;call super::close;Destroy uo_filiais 
end event

type pb_help from dc_w_response`pb_help within w_ge101_consulta_estoque_produto
end type

type gb_2 from groupbox within w_ge101_consulta_estoque_produto
integer x = 18
integer y = 320
integer width = 1838
integer height = 1320
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista das Filiais com Estoque"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ge101_consulta_estoque_produto
integer x = 18
integer width = 1838
integer height = 312
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge101_consulta_estoque_produto
integer x = 46
integer y = 60
integer width = 1778
integer height = 232
boolean bringtotop = true
string dataobject = "dw_ge101_selecao_consulta_estoque"
end type

event itemchanged;call super::itemchanged;Long lvl_Lojas

String ls_Nulo

Setnull(ls_Nulo)

This.AcceptText()

If dw_1.GetColumnName() = "id_selecao_filiais" Then
	
	ivs_filiais = ls_Nulo 
	
	If Data = 'C' Then
				
		OpenWithParm(w_ge216_selecao_filiais, uo_Filiais)
		
		lvl_Lojas = Message.DoubleParm
		
		If lvl_Lojas > 0 Then
			ivs_filiais = uo_Filiais.ivs_filiais
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
		End If
		
	End If

	dw_2.Event ue_Retrieve()
	
End If

If dw_1.GetColumnName() = "id_saldo_negativo" Then
	is_Saldo_Negativo = data
	dw_2.Event ue_Retrieve()
End If 

If dw_1.GetColumnName() = "id_loja_aberta" Then
	is_Loja_Aberta = data
	dw_2.Event ue_Retrieve()
End If 

end event

type cb_fechar from commandbutton within w_ge101_consulta_estoque_produto
integer x = 1495
integer y = 1668
integer width = 357
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Fechar"
boolean cancel = true
end type

event clicked;Close(Parent)


end event

type dw_2 from dc_uo_dw_base within w_ge101_consulta_estoque_produto
integer x = 41
integer y = 372
integer width = 1787
integer height = 1228
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge101_lista_consulta_estoque"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_recuperar;// Override
String ls_Selecao


dw_1.AcceptText()

ls_Selecao			= dw_1.Object.id_selecao_filiais	[1]

If ls_Selecao = "C" Then
	If Not IsNull( ivs_Filiais ) or ivs_Filiais <> "" Then
		dw_2.of_AppendWhere_SubQuery("s.cd_filial in (" + ivs_Filiais + ")", 1)
	End If
End If

If is_Saldo_Negativo = 'S' Then
	dw_2.of_AppendWhere_SubQuery("s.qt_saldo_final < 0 ", 1)
	dw_2.of_AppendWhere_SubQuery("a.qt_saldo < 0 ", 2)
End If

If is_Loja_Aberta = "S" Then
	dw_2.of_AppendWhere_SubQuery("f.id_recebe_nf_transferencia = 'S'", 1)	
End If

//String ls_query
//ls_query = dw_2.getsqlselect()
//messagebox('Query', ls_query)


Return This.Retrieve(ivl_Produto)
end event

event ue_postretrieve;If pl_Linhas = -1 Then Return -1

If pl_Linhas > 0 Then
	This.SetFocus()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Este produto n$$HEX1$$e300$$ENDHEX$$o possui estoque em nenhuma filial e nem no estoque central.", Information!)
End If

Return pl_Linhas
end event

type cb_1 from commandbutton within w_ge101_consulta_estoque_produto
integer x = 1001
integer y = 1668
integer width = 416
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Imprimir"
end type

event clicked;Long lvl_Linha

dc_uo_ds_base lvds_1

uo_Produto lvo_Produto

String lvs_Produto

lvl_Linha = dw_2.RowCount()

If lvl_Linha < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o existem dados para impress$$HEX1$$e300$$ENDHEX$$o")
	Return
Else
	lvds_1 = Create dc_uo_ds_base
	lvo_Produto = Create uo_Produto
	lvo_Produto.of_Localiza_Codigo_Interno(ivl_Produto)
	lvs_Produto = lvo_Produto.De_Produto + " : " + lvo_Produto.De_Apresentacao_Venda
	
	lvds_1.of_ChangeDataObject("dw_ge101_relatorio_estoque")
	lvds_1.Retrieve(ivl_Produto)
	lvds_1.Object.Cabecalho_Produto.Text = lvs_Produto + " (" + String(ivl_produto) + ")"
	lvds_1.of_Print(False)
	
	Destroy(lvds_1)
	Destroy(lvo_Produto)
End If


end event

type cb_2 from commandbutton within w_ge101_consulta_estoque_produto
integer x = 439
integer y = 1668
integer width = 544
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Exportar p/ Excel"
end type

event clicked;If dw_2.RowCount() < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.")
	Return
Else
	dw_2.Event ue_SaveAs()
End If
end event

