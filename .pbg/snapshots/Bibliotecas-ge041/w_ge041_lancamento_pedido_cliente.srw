HA$PBExportHeader$w_ge041_lancamento_pedido_cliente.srw
forward
global type w_ge041_lancamento_pedido_cliente from dc_w_response
end type
type dw_1 from dc_uo_dw_base within w_ge041_lancamento_pedido_cliente
end type
type dw_2 from dc_uo_dw_base within w_ge041_lancamento_pedido_cliente
end type
type pb_1 from picturebutton within w_ge041_lancamento_pedido_cliente
end type
type pb_2 from picturebutton within w_ge041_lancamento_pedido_cliente
end type
type gb_1 from groupbox within w_ge041_lancamento_pedido_cliente
end type
type gb_2 from groupbox within w_ge041_lancamento_pedido_cliente
end type
end forward

global type w_ge041_lancamento_pedido_cliente from dc_w_response
integer width = 2414
integer height = 1780
string title = "GE041 - Lan$$HEX1$$e700$$ENDHEX$$amento Pedido Cliente"
dw_1 dw_1
dw_2 dw_2
pb_1 pb_1
pb_2 pb_2
gb_1 gb_1
gb_2 gb_2
end type
global w_ge041_lancamento_pedido_cliente w_ge041_lancamento_pedido_cliente

type variables
Long	il_Filial,&
		il_Nota
		
String	is_Especie,&
		is_Serie
end variables

on w_ge041_lancamento_pedido_cliente.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.pb_1=create pb_1
this.pb_2=create pb_2
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.gb_2
end on

on w_ge041_lancamento_pedido_cliente.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;String	ls_Parametro

This.ivb_Valida_Salva = False

ls_Parametro = Message.StringParm

il_Filial		= Long(Mid(ls_Parametro, 1, 4))
is_Especie	= Mid(ls_Parametro, 5, 3)
is_Serie		= String(Long(Mid(ls_Parametro, 8, 3)))
il_Nota		= Long(Mid(ls_Parametro, 11))
end event

event ue_postopen;call super::ue_postopen;Boolean lb_Sucesso = False

dw_1.Event ue_AddRow()
dw_1.SetFocus()

dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_1, dw_2}
This.wf_SetUpdate_DW(lvo_Update)


If dw_1.Retrieve(il_Filial, il_Nota, is_Especie, is_Serie) > 0 Then
	If dw_2.Retrieve(il_Filial, il_Nota, is_Especie, is_Serie) > 0 Then
		lb_Sucesso	= True
	End If	
End If

If Not lb_Sucesso Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o forma localizados os dados da nota.")
	Close(This)
	Return
End If
end event

type pb_help from dc_w_response`pb_help within w_ge041_lancamento_pedido_cliente
end type

type dw_1 from dc_uo_dw_base within w_ge041_lancamento_pedido_cliente
integer x = 78
integer y = 72
integer width = 2089
integer height = 244
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge041_pedido_cliente"
end type

type dw_2 from dc_uo_dw_base within w_ge041_lancamento_pedido_cliente
integer x = 64
integer y = 448
integer width = 2286
integer height = 1056
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge041_pedido_cliente_item"
boolean vscrollbar = true
end type

type pb_1 from picturebutton within w_ge041_lancamento_pedido_cliente
integer x = 1915
integer y = 1552
integer width = 448
integer height = 116
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_cancelar.png"
string disabledname = "S:\Sistemas_PB12\Comuns\Figuras\botao_cancelar.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;Close(Parent)
end event

type pb_2 from picturebutton within w_ge041_lancamento_pedido_cliente
integer x = 1385
integer y = 1552
integer width = 471
integer height = 116
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_confirmar.png"
string disabledname = "S:\Sistemas_PB12\Comuns\Figuras\botao_confirmar.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;Long	ll_Pedido_Item,&
		ll_Linha
		
String ls_Pedido, ls_Produto		

dw_1.AcceptText()
dw_2.AcceptText()

ls_Pedido = UPPER(dw_1.Object.nr_pedido_cliente[1])

ls_Pedido = gf_retira_caracteres_especiais( ls_Pedido )

dw_1.Object.nr_pedido_cliente[1] =  ls_Pedido

If IsNull(ls_Pedido) Or Trim(ls_Pedido) = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe um pedido v$$HEX1$$e100$$ENDHEX$$lido.")
	dw_1.Event ue_Pos(1, "nr_pedido_cliente")
	Return 1
End If

For ll_Linha =1 To dw_2.RowCount()
	ll_Pedido_Item	= dw_2.Object.nr_pedido_cliente_item	[ll_Linha]
	ls_Produto		= dw_2.Object.de_produto					[ll_Linha]
	
	If IsNull(ll_Pedido_Item) or (ll_Pedido_Item < 1) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe um pedido v$$HEX1$$e100$$ENDHEX$$lido para o produto '"+ls_Produto+"'.")
		dw_2.Event ue_Pos(ll_Linha, "nr_pedido_cliente_item")
		Return 1
	End If
Next

If Parent.Event ue_Save() = 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Dados salvos com sucesso.")
	Close(Parent)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foram feito altera$$HEX2$$e700f500$$ENDHEX$$es para serem salvas.")
End If
end event

type gb_1 from groupbox within w_ge041_lancamento_pedido_cliente
integer x = 27
integer y = 16
integer width = 2149
integer height = 336
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Nota"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_ge041_lancamento_pedido_cliente
integer x = 27
integer y = 380
integer width = 2341
integer height = 1152
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Itens"
borderstyle borderstyle = styleraised!
end type

