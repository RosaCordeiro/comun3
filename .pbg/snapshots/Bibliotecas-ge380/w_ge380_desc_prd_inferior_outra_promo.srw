HA$PBExportHeader$w_ge380_desc_prd_inferior_outra_promo.srw
forward
global type w_ge380_desc_prd_inferior_outra_promo from dc_w_response_ok_cancela
end type
type cb_1 from commandbutton within w_ge380_desc_prd_inferior_outra_promo
end type
end forward

global type w_ge380_desc_prd_inferior_outra_promo from dc_w_response_ok_cancela
integer width = 4626
integer height = 1624
string title = "GE380 - Produtos com Desconto Inferior em Outra Promo$$HEX2$$e700e300$$ENDHEX$$o e com Pre$$HEX1$$e700$$ENDHEX$$o Bloqueado"
cb_1 cb_1
end type
global w_ge380_desc_prd_inferior_outra_promo w_ge380_desc_prd_inferior_outra_promo

on w_ge380_desc_prd_inferior_outra_promo.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge380_desc_prd_inferior_outra_promo.destroy
call super::destroy
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;str_ge380_desc_infe_outra_promo st

st = Message.PowerObjectParm

Long ll_Linha

SetRedraw(False)

For ll_Linha = 1 To UpperBound(st.Cd_Produto[])
	dw_1.Event ue_AddRow()
	
	dw_1.Object.Cd_Produto				[ll_Linha] = st.Cd_Produto			[ ll_Linha ]
	dw_1.Object.De_Produto				[ll_Linha] = st.De_Produto			[ ll_Linha ]
	dw_1.Object.Pc_Desconto_Atual	[ll_Linha] = st.Pc_Desconto_Atual	[ ll_Linha ]
	dw_1.Object.Cd_Promocao_Sos	[ll_Linha] = st.Cd_Promocao_Sos	[ ll_Linha ]
	dw_1.Object.Nm_Promocao_Sos	[ll_Linha] = st.Nm_Promocao_Sos	[ ll_Linha ]
	dw_1.Object.Dh_Inicio				[ll_Linha] = st.Dh_Inicio				[ ll_Linha ]
	dw_1.Object.Dh_Termino			[ll_Linha] = st.Dh_Termino			[ ll_Linha ]
	dw_1.Object.Pc_Desconto			[ll_Linha] = st.Pc_Desconto			[ ll_Linha ]
Next

dw_1.SetFilter("not isnull(cd_produto)")
dw_1.Filter( )

SetRedraw(True)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge380_desc_prd_inferior_outra_promo
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge380_desc_prd_inferior_outra_promo
integer width = 4549
integer height = 1372
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge380_desc_prd_inferior_outra_promo
integer width = 4489
integer height = 1276
string dataobject = "dw_ge380_lista_desc_inferior"
boolean vscrollbar = true
end type

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()

This.ivb_Ordena_Colunas = True
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge380_desc_prd_inferior_outra_promo
integer x = 3858
integer y = 1408
integer width = 357
string text = "&Confirmar"
end type

event cb_ok::clicked;call super::clicked;If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Se confirmar as altera$$HEX2$$e700f500$$ENDHEX$$es ser$$HEX1$$e300$$ENDHEX$$o gravadas.~rDeseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then Return -1

CloseWithReturn(Parent, "OK")
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge380_desc_prd_inferior_outra_promo
integer x = 4261
integer y = 1408
end type

type cb_1 from commandbutton within w_ge380_desc_prd_inferior_outra_promo
integer x = 23
integer y = 1408
integer width = 617
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Salvar Lista em Excel"
end type

event clicked;dw_1.Event ue_SaveAs()
end event

