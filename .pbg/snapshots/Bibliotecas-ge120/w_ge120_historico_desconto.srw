HA$PBExportHeader$w_ge120_historico_desconto.srw
forward
global type w_ge120_historico_desconto from dc_w_response
end type
type gb_2 from groupbox within w_ge120_historico_desconto
end type
type gb_1 from groupbox within w_ge120_historico_desconto
end type
type dw_1 from dc_uo_dw_base within w_ge120_historico_desconto
end type
type dw_2 from dc_uo_dw_base within w_ge120_historico_desconto
end type
type cb_fechar from commandbutton within w_ge120_historico_desconto
end type
end forward

global type w_ge120_historico_desconto from dc_w_response
integer width = 2894
integer height = 1776
string title = "GE120 - Hist$$HEX1$$f300$$ENDHEX$$rico de Descontos"
boolean controlmenu = false
long backcolor = 80269524
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
cb_fechar cb_fechar
end type
global w_ge120_historico_desconto w_ge120_historico_desconto

type variables
long ivl_produto
end variables

on w_ge120_historico_desconto.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_fechar=create cb_fechar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_fechar
end on

on w_ge120_historico_desconto.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_fechar)
end on

event open;call super::open;ivl_Produto = Long(Message.StringParm)
end event

event ue_postopen;call super::ue_postopen;uo_Produto lvo_Produto
lvo_Produto = Create uo_Produto

lvo_Produto.of_Localiza_Codigo_Interno(ivl_Produto)

If lvo_Produto.Localizado Then
	dw_1.Event ue_AddRow()
	
	dw_1.Object.Cd_Produto[1] = lvo_Produto.Cd_Produto
	dw_1.Object.De_Produto[1] = lvo_Produto.ivs_Descricao_Apresentacao_Venda
	
	dw_2.Event ue_Retrieve()
End If

dw_2.SetFocus()

Destroy(lvo_Produto)
end event

type pb_help from dc_w_response`pb_help within w_ge120_historico_desconto
end type

type gb_2 from groupbox within w_ge120_historico_desconto
integer x = 23
integer y = 184
integer width = 2821
integer height = 1352
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Altera$$HEX2$$e700f500$$ENDHEX$$es de Desconto"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ge120_historico_desconto
integer x = 23
integer width = 1760
integer height = 172
integer taborder = 20
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

type dw_1 from dc_uo_dw_base within w_ge120_historico_desconto
integer x = 50
integer y = 60
integer width = 1723
integer height = 100
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge120_selecao_desconto"
end type

type dw_2 from dc_uo_dw_base within w_ge120_historico_desconto
integer x = 50
integer y = 236
integer width = 2775
integer height = 1280
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge120_lista_desconto"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;// Override

Return This.Retrieve(ivl_Produto)
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_fechar from commandbutton within w_ge120_historico_desconto
integer x = 2510
integer y = 1556
integer width = 334
integer height = 100
integer taborder = 50
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

