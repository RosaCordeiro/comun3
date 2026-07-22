HA$PBExportHeader$w_ge570_consulta_desconto_produto.srw
forward
global type w_ge570_consulta_desconto_produto from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge570_consulta_desconto_produto
end type
type gb_2 from groupbox within w_ge570_consulta_desconto_produto
end type
end forward

global type w_ge570_consulta_desconto_produto from dc_w_response_ok_cancela
integer width = 3493
integer height = 1144
string title = "GE570 - Consulta Desconto Produto - Portal Drogaria"
dw_2 dw_2
gb_2 gb_2
end type
global w_ge570_consulta_desconto_produto w_ge570_consulta_desconto_produto

type variables
dc_uo_ds_base ids_Produtos
end variables

on w_ge570_consulta_desconto_produto.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.gb_2
end on

on w_ge570_consulta_desconto_produto.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.gb_2)
end on

event ue_preopen;call super::ue_preopen;ids_Produtos = Message.powerobjectparm
end event

event ue_postopen;call super::ue_postopen;//ids_Produtos.sharedata( dw_1)
Integer 	li_Row, li_Linhas, li_Insert
Long ll_produto, ll_Pbm

ll_Pbm = 175

dw_1.setredraw( False)
dw_2.setredraw( False)

li_linhas = ids_Produtos.RowCount()

If li_Linhas > 0 Then
	ll_Produto = ids_produtos.object.cd_produto [1]
	dw_2.Retrieve(ll_PBM, ll_Produto)
End If

dw_1.Reset()

For li_Row = 1 To li_Linhas
	li_Insert = dw_1.InsertRow(0)
	dw_1.Object.cd_produto				[li_Insert] 	= ids_produtos.object.cd_produto  				[li_Row]
	dw_1.Object.de_produto				[li_Insert] 	= ids_produtos.object.nm_produto 				[li_Row]
	dw_1.Object.qt_produto				[li_Insert]	= ids_produtos.object.qt_autorizada 				[li_Row]
	dw_1.object.vl_preco_bruto			[li_Insert]	= ids_produtos.object.vl_preco_bruto				[li_Row]
	dw_1.object.vl_preco_liquido 		[li_Insert]	= ids_produtos.object.vl_preco_liquido			[li_Row]
	dw_1.object.pc_desconto_padrao	[li_Insert]	= ids_produtos.object.pc_desconto_padrao		[li_Row]
	dw_1.object.pc_desconto			[li_Insert]	= ids_produtos.object.pc_desconto				[li_Row]
	dw_1.object.de_mensagem			[li_Insert]	= ids_produtos.object.de_msg_retorno			[li_Row]
	dw_1.object.vl_total_liquido			[li_Insert]	= ids_produtos.object.vl_total_liquido				[li_Row]
	
	If li_Insert = 6 Then
		Exit
	End If	
	//ids_produtos.object.id_erro						[li_Row] = li_Status
Next

dw_1.AcceptText()

dw_1.setredraw( True)
dw_2.setredraw( True)

end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge570_consulta_desconto_produto
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge570_consulta_desconto_produto
integer width = 1719
integer height = 1036
string text = "Pre$$HEX1$$e700$$ENDHEX$$o / Desconto - Retorno API"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge570_consulta_desconto_produto
integer width = 1673
integer height = 952
string dataobject = "dw_ge570_consulta_desconto_produto"
end type

event dw_1::constructor;call super::constructor;This.ivb_Selecao_Linhas = True
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge570_consulta_desconto_produto
integer x = 3154
integer y = 944
end type

event cb_ok::clicked;call super::clicked;String lvs_Retorno

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge570_consulta_desconto_produto
boolean visible = false
integer x = 32
integer y = 1564
boolean enabled = false
end type

type dw_2 from dc_uo_dw_base within w_ge570_consulta_desconto_produto
integer x = 1778
integer y = 68
integer width = 1659
integer height = 696
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge570_det_pbm_consulta_prd"
end type

type gb_2 from groupbox within w_ge570_consulta_desconto_produto
integer x = 1765
integer y = 8
integer width = 1691
integer height = 772
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Detalhes"
borderstyle borderstyle = styleraised!
end type

