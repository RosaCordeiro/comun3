HA$PBExportHeader$w_ge252_localiza_nota_compra.srw
forward
global type w_ge252_localiza_nota_compra from dc_w_base
end type
type cb_2 from commandbutton within w_ge252_localiza_nota_compra
end type
type cb_1 from commandbutton within w_ge252_localiza_nota_compra
end type
type dw_1 from dc_uo_dw_base within w_ge252_localiza_nota_compra
end type
type gb_1 from groupbox within w_ge252_localiza_nota_compra
end type
end forward

global type w_ge252_localiza_nota_compra from dc_w_base
integer width = 2007
integer height = 1636
string title = "GE252 - Notas de Compra"
boolean controlmenu = false
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge252_localiza_nota_compra w_ge252_localiza_nota_compra

type variables
String is_Fornecedor

Long il_Produto

st_parametros_nota_compra ist_Parametro
end variables

on w_ge252_localiza_nota_compra.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_ge252_localiza_nota_compra.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;If dw_1.Retrieve(is_Fornecedor, il_Produto) < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhuma nota de compra.")
	CloseWithReturn(This, ist_Parametro)
	Return
End If
end event

event open;call super::open;String ls_Parametro

ls_Parametro = Message.StringParm	

is_Fornecedor = Mid(ls_Parametro, 1, 9)

il_Produto = Long(Mid(ls_Parametro, 10))

ist_Parametro.retorno = -1
end event

type cb_2 from commandbutton within w_ge252_localiza_nota_compra
integer x = 32
integer y = 1448
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Selecionar"
end type

event clicked;String 	ls_Fornecedor,&
			ls_Especie,&
			ls_Serie,&
			ls_Lote

Long 	ll_Nota,&
		ll_Natureza_Operacao,&
		ll_Row,&
		ll_Qtde
		
Decimal 	ldc_Preco_Unitario,&
			ldc_Desconto
			
dw_1.AcceptText()

ll_Row = dw_1.GetRow()

ls_Fornecedor				= dw_1.Object.cd_fornecedor				[ll_Row]
ll_Nota						= dw_1.Object.nr_nf							[ll_Row]
ls_Especie					= dw_1.Object.de_especie					[ll_Row]
ls_Serie						= dw_1.Object.de_serie						[ll_Row]
ll_Natureza_Operacao	= dw_1.Object.cd_natureza_operacao	[ll_Row]
ldc_Preco_Unitario			= dw_1.Object.vl_preco_unitario			[ll_Row]
ldc_Desconto				= dw_1.Object.pc_desconto					[ll_Row]
ls_Lote						= dw_1.Object.nr_lote						[ll_Row]
ll_Qtde						= dw_1.Object.qt_lote						[ll_Row]

ist_Parametro.retorno 						= 1
ist_Parametro.cd_fornecedor 				= ls_Fornecedor
ist_Parametro.nr_nf 							= ll_Nota
ist_Parametro.de_especie 					= ls_Especie
ist_Parametro.de_serie 						= ls_Serie
ist_Parametro.cd_natureza_operacao 	= ll_Natureza_Operacao
ist_Parametro.vl_preco_unitario 			= ldc_Preco_Unitario
ist_Parametro.pc_desconto 					= ldc_Desconto
ist_Parametro.nr_lote 						= ls_Lote
ist_Parametro.qt_lote							= ll_Qtde

CloseWithReturn(Parent, ist_Parametro)
end event

type cb_1 from commandbutton within w_ge252_localiza_nota_compra
integer x = 1682
integer y = 1448
integer width = 265
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sair"
end type

event clicked;
CloseWithReturn(Parent, ist_Parametro)
end event

type dw_1 from dc_uo_dw_base within w_ge252_localiza_nota_compra
integer x = 50
integer y = 76
integer width = 1879
integer height = 1336
integer taborder = 20
string dataobject = "ds_ge252_localiza_notas_compra"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()

ivb_ordena_colunas = True
end event

type gb_1 from groupbox within w_ge252_localiza_nota_compra
integer x = 27
integer y = 16
integer width = 1929
integer height = 1416
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista Notas"
end type

