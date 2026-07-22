HA$PBExportHeader$w_ge001_desconto_negociavel.srw
forward
global type w_ge001_desconto_negociavel from dc_w_response_ok_cancela
end type
end forward

global type w_ge001_desconto_negociavel from dc_w_response_ok_cancela
int X=914
int Y=864
int Width=1842
int Height=660
boolean TitleBar=true
string Title="GE049 - Aplica$$HEX2$$e700e300$$ENDHEX$$o de Descontos Negoci$$HEX1$$e100$$ENDHEX$$veis"
long BackColor=80269524
end type
global w_ge001_desconto_negociavel w_ge001_desconto_negociavel

type variables
uo_produto ivo_produto
end variables

on w_ge001_desconto_negociavel.create
call super::create
end on

on w_ge001_desconto_negociavel.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.Cd_Produto				   [1] = ivo_Produto.Cd_Produto
dw_1.Object.De_Produto				   [1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
dw_1.Object.Vl_Preco_Venda_Atual    [1] = ivo_Produto.of_Preco_Venda_Filial()
dw_1.Object.Vl_Preco_Venda_Calculado[1] = ivo_Produto.of_Preco_Venda_Filial()
dw_1.Object.Pc_Desconto_Negociavel  [1] = ivo_Produto.of_Desconto_Negociavel()

dw_1.Event ue_Pos(1, "pc_desconto_aplicado")
dw_1.SelectText(1, 100)	
end event

event open;call super::open;ivo_Produto = Create uo_Produto

ivo_Produto = Message.PowerObjectParm
end event

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge001_desconto_negociavel
int X=32
int Y=0
int Width=1765
int Height=424
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge001_desconto_negociavel
int Y=52
int Width=1728
int Height=356
boolean BringToTop=true
string DataObject="dw_ge001_aplicacao_desconto_negociavel"
end type

event dw_1::itemfocuschanged;call super::itemfocuschanged;This.SelectText(1, 100)
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge001_desconto_negociavel
int X=1033
int Y=440
int Width=370
boolean BringToTop=true
string FaceName="Verdana"
end type

event cb_ok::clicked;call super::clicked;Decimal lvdc_Desconto

dw_1.AcceptText()

lvdc_Desconto = dw_1.Object.Pc_Desconto_Aplicado[1]

If lvdc_Desconto > dw_1.Object.Pc_Desconto_Negociavel[1] Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Desconto excede o valor m$$HEX1$$e100$$ENDHEX$$ximo permitido.", Information!)
	
	dw_1.Object.Pc_Desconto_Aplicado    [1] = 0
	dw_1.Object.Vl_Preco_Venda_Calculado[1] = dw_1.Object.Vl_Preco_Venda_Atual[1]
	
	dw_1.Event ue_Pos(1, "pc_desconto_aplicado")
	dw_1.SelectText(1, 100)
	Return
End If

If lvdc_Desconto = 0 or IsNull(lvdc_Desconto) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Desconto concedido deve ser maior que zero.", Information!)
	dw_1.Event ue_Pos(1, "pc_desconto_aplicado")
	dw_1.SelectText(1, 100)
	Return
End If

CloseWithReturn(Parent, String(lvdc_Desconto))
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge001_desconto_negociavel
int X=1426
int Y=440
int Width=370
boolean BringToTop=true
string FaceName="Verdana"
end type

event cb_cancelar::clicked;// Override
CloseWithReturn(Parent, "0")
end event

