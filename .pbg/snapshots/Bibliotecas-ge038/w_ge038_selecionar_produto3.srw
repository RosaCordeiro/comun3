HA$PBExportHeader$w_ge038_selecionar_produto3.srw
forward
global type w_ge038_selecionar_produto3 from dc_w_response
end type
type dw_1 from dc_uo_dw_base within w_ge038_selecionar_produto3
end type
type cb_cancelar from commandbutton within w_ge038_selecionar_produto3
end type
type cb_confirma from commandbutton within w_ge038_selecionar_produto3
end type
type dw_2 from dc_uo_dw_base within w_ge038_selecionar_produto3
end type
type cb_adicionar from commandbutton within w_ge038_selecionar_produto3
end type
type cb_remover from commandbutton within w_ge038_selecionar_produto3
end type
type gb_2 from groupbox within w_ge038_selecionar_produto3
end type
type gb_1 from groupbox within w_ge038_selecionar_produto3
end type
end forward

global type w_ge038_selecionar_produto3 from dc_w_response
integer width = 2619
integer height = 1452
dw_1 dw_1
cb_cancelar cb_cancelar
cb_confirma cb_confirma
dw_2 dw_2
cb_adicionar cb_adicionar
cb_remover cb_remover
gb_2 gb_2
gb_1 gb_1
end type
global w_ge038_selecionar_produto3 w_ge038_selecionar_produto3

type variables
uo_Produto ivo_Produto
dc_uo_ds_base ivds_produto
end variables

on w_ge038_selecionar_produto3.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_cancelar=create cb_cancelar
this.cb_confirma=create cb_confirma
this.dw_2=create dw_2
this.cb_adicionar=create cb_adicionar
this.cb_remover=create cb_remover
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.cb_confirma
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_adicionar
this.Control[iCurrent+6]=this.cb_remover
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.gb_1
end on

on w_ge038_selecionar_produto3.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_cancelar)
destroy(this.cb_confirma)
destroy(this.dw_2)
destroy(this.cb_adicionar)
destroy(this.cb_remover)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;call super::open;ivds_produto = Message.PowerObjectParm
end event

event ue_postopen;call super::ue_postopen;ivo_Produto = Create uo_Produto

ivo_Produto.of_Inicializa()
end event

type pb_help from dc_w_response`pb_help within w_ge038_selecionar_produto3
integer taborder = 40
end type

type dw_1 from dc_uo_dw_base within w_ge038_selecionar_produto3
integer x = 119
integer y = 92
integer width = 1943
integer height = 120
boolean bringtotop = true
string dataobject = "dw_ge038_selecao_produto"
end type

event constructor;call super::constructor;dw_1.Insertrow(1)
dw_1.AcceptText()
dw_1.ScrollToRow(1)
dw_1.SetRow(1)
end event

event ue_key;call super::ue_key;String lvs_Coluna

If key = keyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = "de_produto" Then
		ivo_Produto.of_Localiza_Produto(This.GetText())
		
		If ivo_Produto.localizado Then
			dw_1.Object.de_produto[1] = ivo_Produto.de_produto
			dw_1.Object.cd_produto[1] = ivo_Produto.cd_produto
		End If
	End If
	
End If
end event

type cb_cancelar from commandbutton within w_ge038_selecionar_produto3
integer x = 2235
integer y = 1224
integer width = 325
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
end type

event clicked;Close(Parent)
end event

type cb_confirma from commandbutton within w_ge038_selecionar_produto3
integer x = 1810
integer y = 1224
integer width = 389
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Selecionar"
end type

event clicked;Long ll_row
Long ll_Linha

ivds_produto = Create dc_uo_ds_base

If Not ivds_produto.of_ChangeDataObject("dw_ge038_pafecf_estoque") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Problemas ao gerar lista de produtos.")
	Return
End If

For ll_row = 1 TO dw_2.RowCount()	
	
	ll_Linha = ivds_produto.InsertRow(0)
	
	ivds_produto.Object.Cd_Produto   		[ll_Linha] = dw_2.Object.cd_produto[ll_row]
	ivds_produto.Object.de_Produto   		[ll_Linha] = dw_2.Object.de_produto[ll_row]	
	ivds_produto.Object.Cd_Un				[ll_Linha] = dw_2.Object.cd_Un[ll_row]
	ivds_produto.Object.Qt_Saldo_Final	[ll_Linha] = dw_2.Object.Qt_Saldo_Final[ll_row]
	ivds_produto.Object.dh_ultima_venda	[ll_Linha] = dw_2.Object.dh_ultima_venda[ll_row]
	ivds_produto.Object.cd_cest				[ll_Linha] = dw_2.Object.cd_cest[ll_row]
	ivds_produto.Object.nr_classificacao_fiscal[ll_Linha] = dw_2.Object.nr_classificacao_fiscal[ll_row]	
Next

CloseWithReturn(Parent,ivds_produto)
end event

type dw_2 from dc_uo_dw_base within w_ge038_selecionar_produto3
integer x = 155
integer y = 364
integer width = 2217
integer height = 804
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_ge038_pafecf_estoque"
end type

type cb_adicionar from commandbutton within w_ge038_selecionar_produto3
integer x = 2208
integer y = 92
integer width = 325
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Adicionar"
end type

event clicked;Long lvl_Saldo
Long lvl_Linha

DateTime lvdh_Periodo
DateTime lvdh_Movimento

If IsNull(ivo_Produto.cd_produto) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Localize um produto antes de adicionar.")
	dw_1.SetFocus()
	Return -1
End If


lvl_Linha = dw_2.Find("cd_produto = " + String(ivo_Produto.cd_produto), 1, dw_2.RowCount())

If lvl_Linha = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao tentar localizar o produto.")
	Return -1
ElseIf lvl_Linha > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto j$$HEX1$$e100$$ENDHEX$$ foi adicionado.")
	ivo_Produto.of_Inicializa()
	dw_1.Object.cd_produto[1] = ivo_Produto.cd_produto
	dw_1.Object.de_produto[1] = ivo_Produto.de_produto	
	dw_1.SetFocus()
	Return -1
End If

lvdh_Periodo = DateTime(Date(String(Today(), "01/MM/YYYY")))

Select saldo_produto.qt_saldo_final, produto_loja.dh_ultima_venda
  Into :lvl_Saldo, :lvdh_Movimento
  From saldo_produto, produto_loja
 Where saldo_produto.cd_produto = :ivo_Produto.cd_produto
   and saldo_produto.cd_produto = produto_loja.cd_produto
   and saldo_produto.dh_saldo >=  :lvdh_Periodo
 Using SQLCa;
 
 If SQLCA.SQLCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o saldo do produto")
	dw_1.SetFocus()
	Return -1
 End If

lvl_Linha = dw_2.InsertRow(0)

dw_2.Object.cd_produto		[lvl_Linha] = ivo_Produto.cd_produto
dw_2.Object.de_produto		[lvl_Linha] = ivo_Produto.de_produto
dw_2.Object.cd_un				[lvl_Linha] = ivo_Produto.Cd_Unidade_Medida_Venda
dw_2.Object.qt_saldo_final	[lvl_Linha] = lvl_saldo
dw_2.Object.dh_ultima_venda[lvl_Linha] = lvdh_Movimento

dw_2.Sort()

ivo_Produto.of_Inicializa()

dw_1.Object.cd_produto[1] = ivo_Produto.cd_produto
dw_1.Object.de_produto[1] = ivo_Produto.de_produto

dw_1.SetFocus()

end event

type cb_remover from commandbutton within w_ge038_selecionar_produto3
integer x = 114
integer y = 1224
integer width = 325
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Remover"
end type

event clicked;If dw_2.RowCount() > 0 Then
	dw_2.DeleteRow(dw_2.GetRow())
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum produto para remover.")
End If
end event

type gb_2 from groupbox within w_ge038_selecionar_produto3
integer x = 59
integer y = 256
integer width = 2496
integer height = 936
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type gb_1 from groupbox within w_ge038_selecionar_produto3
integer x = 50
integer y = 16
integer width = 2030
integer height = 216
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

