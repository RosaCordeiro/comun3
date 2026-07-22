HA$PBExportHeader$w_ge514_vmpay.srw
forward
global type w_ge514_vmpay from window
end type
type cb_7 from commandbutton within w_ge514_vmpay
end type
type cb_6 from commandbutton within w_ge514_vmpay
end type
type cb_5 from commandbutton within w_ge514_vmpay
end type
type cb_1 from commandbutton within w_ge514_vmpay
end type
type cb_4 from commandbutton within w_ge514_vmpay
end type
type cb_3 from commandbutton within w_ge514_vmpay
end type
type cb_2 from commandbutton within w_ge514_vmpay
end type
end forward

global type w_ge514_vmpay from window
integer width = 1550
integer height = 876
boolean titlebar = true
string title = "GE514 - VM Pay (Vendin Machine)"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_1 cb_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
end type
global w_ge514_vmpay w_ge514_vmpay

on w_ge514_vmpay.create
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_1=create cb_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.Control[]={this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_1,&
this.cb_4,&
this.cb_3,&
this.cb_2}
end on

on w_ge514_vmpay.destroy
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
end on

type cb_7 from commandbutton within w_ge514_vmpay
integer x = 663
integer y = 604
integer width = 571
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Grava Comp Venda"
end type

event clicked;string ls_situacao 
long ll_nr_pedido 
long ll_cd_filial
decimal ldc_valor
integer li_parcelas
string ls_estabelecimento
string ls_bandeira
string ls_nr_nsu
string ls_nr_autorizacao
string ls_nr_autorizacao_cd
string ls_nr_cartao
string ls_nr_psp_recebdor
string ls_tipo_uso_cd
string  ls_log

uo_ge514_pedido_loja luo_loja

luo_loja = create uo_ge514_pedido_loja

luo_loja.il_cd_filial 						= 495
luo_loja.is_nr_pedido_ecommerce 	= '170763818'
luo_loja.idc_total 							= 3.79
//luo_loja.is_nr_cartao_credito 			= ids_dados.object.nr_cartao_credito[pl_linha]
luo_loja.il_nr_pedido 					= 601310643
luo_loja.ii_parcelas 						= 1
luo_loja.is_bandeira_cartao 			= 'MASTERCARD DEBITO - PAGSEGURO'
luo_loja.is_estabelecimento 			= '028824580'
luo_loja.il_id_pagamento 				= 7
luo_loja.il_maquina 						= 5
luo_loja.is_Rede_Filial 					= 'DC'
//luo_loja.idh_compra 					= ids_dados.object.dh_compra[pl_linha]

luo_loja.is_Forma_Pagto 			= 'CA'
luo_loja.is_comprovante_cartao 	= '000410875001'
//luo_loja.is_autorizacao_cartao 	= ids_dados.object.nr_autorizacao_cartao_credito[pl_linha]

if Not luo_loja.of_grava_cartao_comp_venda( ref ls_log ) Then
	messagebox('Atencao', ls_log)
	return -1
ENd if




end event

type cb_6 from commandbutton within w_ge514_vmpay
integer x = 795
integer y = 408
integer width = 585
integer height = 128
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Produto"
end type

event clicked;uo_ge514_integracao_vmpay luo_pedido

luo_pedido = create uo_ge514_integracao_vmpay

luo_pedido.of_processa_integracao( 2 )

destroy(luo_pedido)
end event

type cb_5 from commandbutton within w_ge514_vmpay
integer x = 795
integer y = 244
integer width = 585
integer height = 128
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Categoria"
end type

event clicked;uo_ge514_integracao_vmpay luo_pedido

luo_pedido = create uo_ge514_integracao_vmpay

luo_pedido.of_processa_integracao( 22 )

destroy(luo_pedido)
end event

type cb_1 from commandbutton within w_ge514_vmpay
integer x = 795
integer y = 92
integer width = 585
integer height = 128
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Fabricante"
end type

event clicked;uo_ge514_integracao_vmpay luo_pedido

luo_pedido = create uo_ge514_integracao_vmpay

luo_pedido.of_processa_integracao( 21 )

destroy(luo_pedido)
end event

type cb_4 from commandbutton within w_ge514_vmpay
integer x = 123
integer y = 404
integer width = 585
integer height = 128
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Pedido - Status"
end type

event clicked;uo_ge514_integracao_vmpay luo_pedido

luo_pedido = create uo_ge514_integracao_vmpay

luo_pedido.of_processa_integracao( 13 )

destroy(luo_pedido)
end event

type cb_3 from commandbutton within w_ge514_vmpay
integer x = 123
integer y = 244
integer width = 585
integer height = 128
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Pedido - Loja"
end type

event clicked;uo_ge514_integracao_vmpay luo_pedido

luo_pedido = create uo_ge514_integracao_vmpay

luo_pedido.of_processa_integracao( 9 )

destroy(luo_pedido)
end event

type cb_2 from commandbutton within w_ge514_vmpay
integer x = 123
integer y = 92
integer width = 585
integer height = 128
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Pedido - Baixa"
end type

event clicked;uo_ge514_integracao_vmpay luo_pedido

luo_pedido = create uo_ge514_integracao_vmpay

luo_pedido.of_processa_integracao( 8 )

destroy(luo_pedido)
end event

