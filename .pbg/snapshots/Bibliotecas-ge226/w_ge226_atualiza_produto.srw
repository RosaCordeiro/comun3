HA$PBExportHeader$w_ge226_atualiza_produto.srw
forward
global type w_ge226_atualiza_produto from dc_w_response_ok_cancela
end type
type cb_1 from commandbutton within w_ge226_atualiza_produto
end type
type dw_2 from dc_uo_dw_base within w_ge226_atualiza_produto
end type
type gb_2 from groupbox within w_ge226_atualiza_produto
end type
type gb_3 from groupbox within w_ge226_atualiza_produto
end type
end forward

global type w_ge226_atualiza_produto from dc_w_response_ok_cancela
integer width = 1344
integer height = 1112
string title = "GE226 - Atualiza$$HEX2$$e700e300$$ENDHEX$$o de Produtos"
cb_1 cb_1
dw_2 dw_2
gb_2 gb_2
gb_3 gb_3
end type
global w_ge226_atualiza_produto w_ge226_atualiza_produto

type variables
uo_ecommerce_vannon iuo_ecommerce_vannon
end variables

on w_ge226_atualiza_produto.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_2=create dw_2
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.gb_3
end on

on w_ge226_atualiza_produto.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event ue_postopen;call super::ue_postopen;dw_2.Event ue_AddROw()

iuo_ecommerce_vannon = create uo_ecommerce_vannon
end event

event close;call super::close;destroy( iuo_ecommerce_vannon)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge226_atualiza_produto
integer x = 41
integer y = 952
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge226_atualiza_produto
integer x = 91
integer y = 256
integer width = 1134
integer height = 240
string text = "Por Produto"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge226_atualiza_produto
integer x = 137
integer y = 348
integer width = 640
integer height = 92
string dataobject = "dw_ge226_informa_produto"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge226_atualiza_produto
integer x = 795
integer y = 336
integer width = 379
string text = "&Atualizar"
end type

event cb_ok::clicked;call super::clicked;Long lvl_Produto, lvl_Nulo

String ls_Rede_EC

SetNull(lvl_Nulo)

dw_1.AcceptText()
dw_2.acceptText()

lvl_Produto 	= dw_1.Object.cd_produto[1]
ls_Rede_EC 	= dw_2.Object.id_rede_ecommerce[1]

If IsNull(lvl_Produto) then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o n$$HEX1$$fa00$$ENDHEX$$mero do produto corretamente.")
	dw_1.Event ue_Pos(1, "cd_produto")
	Return
End If

uo_Produto lo_Produto
lo_Produto = Create uo_Produto
lo_Produto.of_localiza_codigo_interno( lvl_Produto )

If Not lo_Produto.Localizado Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O produto informado n$$HEX1$$e300$$ENDHEX$$o localizado no cadastro.")
	Return -1
End If

Destroy lo_Produto

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a atualiza$$HEX2$$e700e300$$ENDHEX$$o do produto '"  + String(lvl_Produto) + "' " + IIF(ls_Rede_EC= "TD", "em todas as redes do ecommerce", "na rede " + ls_Rede_EC) +  " ?", Question!, YesNo!, 2) = 1 Then
	//Todas as redes
	If ls_Rede_EC = "TD" Then
		If iuo_eCommerce_Vannon.of_atualiza_produtos(lvl_Produto) Then
			dw_1.Object.cd_produto[1] = lvl_Nulo
			dw_1.Event ue_Pos(1, "cd_produto")
		End If	
	Else
		If iuo_eCommerce_Vannon.of_atualiza_produtos( lvl_Produto, ls_Rede_EC ) Then
			dw_1.Object.cd_produto[1] = lvl_Nulo
			dw_1.Event ue_Pos(1, "cd_produto")
		End If	
	End If	
End If


end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge226_atualiza_produto
integer x = 987
integer y = 900
integer height = 104
end type

type cb_1 from commandbutton within w_ge226_atualiza_produto
integer x = 256
integer y = 652
integer width = 800
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Atualizar todos"
end type

event clicked;String ls_Rede_EC

Long ll_Null

DW_2.acceptText()


ls_Rede_EC 	= dw_2.Object.id_rede_ecommerce[1]

SetNull(ll_Null)

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a atualiza$$HEX2$$e700e300$$ENDHEX$$o de todos os produtos " + IIF(ls_Rede_EC= "TD", "em todas as redes do ecommerce", "na rede " + ls_Rede_EC) +  " ?", Question!, YesNo!, 2) = 1 Then
	//Todas as redes
	If ls_Rede_EC = "TD" Then
		iuo_eCommerce_Vannon.of_atualiza_produtos(ll_Null)
	Else
		iuo_eCommerce_Vannon.of_atualiza_produtos( ll_Null, ls_Rede_EC )
	End If	
End If
end event

type dw_2 from dc_uo_dw_base within w_ge226_atualiza_produto
integer x = 73
integer y = 108
integer width = 1161
integer height = 100
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge226_rede_ecommerce"
end type

type gb_2 from groupbox within w_ge226_atualiza_produto
integer x = 91
integer y = 560
integer width = 1134
integer height = 252
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Todos os produtos"
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_ge226_atualiza_produto
integer x = 23
integer y = 4
integer width = 1275
integer height = 872
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o de produtos"
borderstyle borderstyle = styleraised!
end type

