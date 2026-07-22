HA$PBExportHeader$w_ge108_movimentacao_estoque.srw
forward
global type w_ge108_movimentacao_estoque from dc_w_response_ok_cancela
end type
type st_1 from statictext within w_ge108_movimentacao_estoque
end type
end forward

global type w_ge108_movimentacao_estoque from dc_w_response_ok_cancela
integer width = 3602
integer height = 1708
string title = "GE108 - Movimenta$$HEX2$$e700e300$$ENDHEX$$o de Estoque"
st_1 st_1
end type
global w_ge108_movimentacao_estoque w_ge108_movimentacao_estoque

type variables
Long ivl_Produto
end variables

on w_ge108_movimentacao_estoque.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_ge108_movimentacao_estoque.destroy
call super::destroy
destroy(this.st_1)
end on

event open;call super::open;ivl_Produto = Long( Message.DoubleParm )
end event

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Retrieve()

If IsValid( This ) Then
	This.SetRedraw( True )
End If
end event

event ue_preopen;call super::ue_preopen;This.SetRedraw( False )
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge108_movimentacao_estoque
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge108_movimentacao_estoque
integer x = 18
integer width = 3538
integer height = 1468
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge108_movimentacao_estoque
integer x = 50
integer y = 52
integer width = 3488
integer height = 1400
string dataobject = "dw_ge108_movimentacao_estoque"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;Long ll_Linhas
Long ll_Linha
Long ll_Insert
Long ll_Nulo
Long ll_Find
Long ll_Nota

String ls_Especie
String ls_Serie
String ls_Fantasia
String ls_Find
String ls_Desc_Movimento
String ls_Fornecedor_Aux

SetNull( ll_Nulo )

Open( w_Aguarde )
w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es de saldos pendentes..."

dc_uo_ds_base lds_1
lds_1 = Create dc_uo_ds_base
lds_1.of_ChangeDataObject( "ds_ge108_saldo_pendente" )

lds_1.of_AppendWhere( "v.cd_produto = " + String( ivl_Produto ) )

ll_Linhas = lds_1.Retrieve( )

For ll_Linha = 1 To ll_Linhas
	ls_Fornecedor_Aux	= lds_1.Object.Cd_Fornecedor			[ ll_Linha ]
	ls_Fantasia				= lds_1.Object.Nm_Fantasia			[ ll_Linha ]	
	ll_Nota					= iif( lds_1.Object.Nr_Nf					[ ll_Linha ] = 0, ll_Nulo, lds_1.Object.Nr_Nf [ ll_Linha ] )
	ls_Especie				= lds_1.Object.De_Especie				[ ll_Linha ]
	ls_Serie					= lds_1.Object.De_Serie					[ ll_Linha ]
	ls_Desc_Movimento 	= lds_1.Object.De_Tipo_Movimento	[ ll_Linha ]

	If ls_Desc_Movimento = 'PEDIDO ECOMMERCE' Then
		ls_Fornecedor_Aux = '99999' //Usado p/ mostrar o nr Pedido ecommerce no campo Origem/Destino
	End If
	
	ls_Find	= "filial_nm_fantasia = '" + ls_Fantasia + "' and nr_nf = " + String( ll_Nota ) + " and de_especie = '" + ls_Especie + "' and serie = '" + ls_Serie + "'"
	ll_Find	= This.Find( ls_Find, 1, This.RowCount( ) )
	
	If ll_Find > 0 Then
		ll_Insert = ll_Find
	Else	
		ll_Insert = This.InsertRow(0)
	End If
	
	This.Object.Dh_Emissao					[ ll_Insert ] = lds_1.Object.Dh_Emissao		[ ll_Linha ]
	This.Object.Nr_Nf							[ ll_Insert ] = ll_Nota
	This.Object.De_Especie					[ ll_Insert ] = ls_Especie
	This.Object.Serie							[ ll_Insert ] = ls_Serie
	This.Object.Cd_Tipo_Movimento		[ ll_Insert ] = 0
	This.Object.De_Tipo_Movimento		[ ll_Insert ] = lds_1.Object.De_Tipo_Movimento		[ ll_Linha ]
	This.Object.Cd_Fornecedor				[ ll_Insert ] = ls_Fornecedor_Aux 
	This.Object.Qt_Movimento				[ ll_Insert ] = lds_1.Object.Qt_Saldo						[ ll_Linha ]
	This.Object.Fornecedor_Nm_Fantasia	[ ll_Insert ] = ls_Fantasia
	This.Object.De_Produto					[ ll_Insert ] = lds_1.Object.De_Produto					[ ll_Linha ]
	This.Object.De_Apresentacao_Venda	[ ll_Insert ] = lds_1.Object.De_Apresentacao_Venda	[ ll_Linha ]
	
	Choose Case lds_1.Object.De_Tipo_Movimento[ ll_Linha ]
		Case 'PEDIDO ECOMMERCE', 'RESERVA CLIENTE', 'RESERVA VEND. MACHINE'
			This.Object.Cd_Tipo_Movimento[ ll_Insert ] = -1
		Case Else
			This.Object.De_Tipo_Movimento[ ll_Insert ] = lds_1.Object.De_Tipo_Movimento[ ll_Linha ] + ' (PENDENTE)'			
	End Choose
	
//	If lds_1.Object.De_Tipo_Movimento[ ll_Linha ] <> 'RESERVA CLIENTE' AND lds_1.Object.De_Tipo_Movimento[ ll_Linha ] <> 'RESERVA VEND. MACHINE' Then
//		This.Object.De_Tipo_Movimento[ ll_Insert ] = lds_1.Object.De_Tipo_Movimento[ ll_Linha ] + ' (PENDENTE)'
//	Else
//		This.Object.Cd_Tipo_Movimento[ ll_Insert ] = -1
//	End If
	
Next

Destroy lds_1

Close( w_Aguarde )

If pl_Linhas = 0 And ( ll_Linhas + ll_Insert ) = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma movimenta$$HEX2$$e700e300$$ENDHEX$$o encontrada nos $$HEX1$$fa00$$ENDHEX$$ltimos 10 dias.")
	Close( Parent )
Else
	This.of_SetRowSelection( "if(getrow() = currentrow(), rgb(0,128,128), if(cd_tipo_movimento = 0, rgb(255, 140, 105), if(cd_tipo_movimento = -1, rgb(173,216,230), rgb(255, 255, 255))))", "" )
End If

Return pl_Linhas
end event

event dw_1::ue_recuperar;// OverRide

Return This.Retrieve( ivl_Produto )
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge108_movimentacao_estoque
boolean visible = false
integer x = 3086
integer y = 1132
boolean enabled = false
boolean default = false
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge108_movimentacao_estoque
integer x = 3168
integer y = 1500
integer width = 389
end type

type st_1 from statictext within w_ge108_movimentacao_estoque
integer x = 37
integer y = 1516
integer width = 1463
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Data Hora: Para compras, $$HEX1$$e900$$ENDHEX$$ a atualiza$$HEX2$$e700e300$$ENDHEX$$o de estoque."
boolean focusrectangle = false
end type

