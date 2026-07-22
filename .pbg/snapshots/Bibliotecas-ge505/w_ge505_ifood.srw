HA$PBExportHeader$w_ge505_ifood.srw
forward
global type w_ge505_ifood from window
end type
type cb_7 from commandbutton within w_ge505_ifood
end type
type cb_6 from commandbutton within w_ge505_ifood
end type
type cb_5 from commandbutton within w_ge505_ifood
end type
type cb_4 from commandbutton within w_ge505_ifood
end type
type cb_3 from commandbutton within w_ge505_ifood
end type
type cb_2 from commandbutton within w_ge505_ifood
end type
type cb_1 from commandbutton within w_ge505_ifood
end type
end forward

global type w_ge505_ifood from window
integer width = 2729
integer height = 1496
boolean titlebar = true
string title = "GE505 - Integra$$HEX2$$e700e300$$ENDHEX$$o IFOOD"
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
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_ge505_ifood w_ge505_ifood

on w_ge505_ifood.create
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_ge505_ifood.destroy
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type cb_7 from commandbutton within w_ge505_ifood
integer x = 1422
integer y = 364
integer width = 640
integer height = 132
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cadastrar Lojas PP"
end type

event clicked;uo_ge505_cadastro_loja luo_loja

luo_loja = create uo_ge505_cadastro_loja

luo_loja.of_cadastrar_lojas( 'PP')

destroy(luo_loja)
end event

type cb_6 from commandbutton within w_ge505_ifood
integer x = 1422
integer y = 220
integer width = 640
integer height = 132
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cadastrar Lojas DC"
end type

event clicked;uo_ge505_cadastro_loja luo_loja

luo_loja = create uo_ge505_cadastro_loja

luo_loja.of_cadastrar_lojas( 'DC')

destroy(luo_loja)
end event

type cb_5 from commandbutton within w_ge505_ifood
integer x = 411
integer y = 832
integer width = 640
integer height = 132
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "5 - Pedidos Status"
end type

event clicked;boolean lb_encontrou
uo_ge505_pedido_status luo_prod

luo_prod = create uo_ge505_pedido_status

luo_prod.of_processa_atualizacao_status( )

destroy(luo_prod)
end event

type cb_4 from commandbutton within w_ge505_ifood
integer x = 411
integer y = 664
integer width = 640
integer height = 132
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "4 - Baixa Pedidos Loja"
end type

event clicked;
string ls_log
string ls_Rede, ls_pedido, ls_filial_ecommerce
long ll_cd_filial
uo_ge505_pedido_loja luo_prod

// DEBUG
str_ge505_dados_debug str

Open(w_ge505_debug)

str = Message.PowerObjectParm

ls_pedido = str.nr_pedido
ll_cd_filial = str.cd_filial

if ll_cd_filial = 0 or isnull(ll_cd_filial) then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Informe a filial.')
	return -1
end if

luo_prod = create uo_ge505_pedido_loja

//if ls_pedido <> '' and not isnull(ls_pedido) Then
//	luo_prod.is_pedido_debug	= ls_pedido
//end if
//	
Select id_rede_filial, cd_warehouseid
into :ls_rede, :ls_filial_ecommerce
from ecommerce_rede_filial
where id_ecommerce = '3'
and cd_filial = :ll_cd_filial
and id_situacao = 'A';

if sqlca.sqlcode = -1 then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', sqlca.sqlerrtext)
	return -1
end if
	
luo_prod.of_processa_atualizacao_pedido(ls_rede,ll_cd_filial )	
	

destroy(luo_prod)
end event

type cb_3 from commandbutton within w_ge505_ifood
integer x = 411
integer y = 508
integer width = 640
integer height = 132
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "3 - Baixa Pedidos"
end type

event clicked;string ls_log
string ls_Rede, ls_pedido, ls_filial_ecommerce
long ll_cd_filial
uo_ge505_pedido_baixa luo_prod

// DEBUG
str_ge505_dados_debug str

Open(w_ge505_debug)

str = Message.PowerObjectParm

ls_pedido = str.nr_pedido
ll_cd_filial = str.cd_filial

if ll_cd_filial = 0 or isnull(ll_cd_filial) then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Informe a filial.')
	return -1
end if

luo_prod = create uo_ge505_pedido_baixa

if ls_pedido <> '' and not isnull(ls_pedido) Then
	luo_prod.is_pedido_debug	= ls_pedido
end if
	
Select id_rede_filial, cd_warehouseid
into :ls_rede, :ls_filial_ecommerce
from ecommerce_rede_filial
where id_ecommerce = '3'
and cd_filial = :ll_cd_filial
and id_situacao = 'A';

if sqlca.sqlcode = -1 then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', sqlca.sqlerrtext)
	return -1
end if
	
luo_prod.of_processa_atualizacao_pedido( ls_rede, ll_cd_filial, ls_filial_ecommerce)

destroy(luo_prod)
end event

type cb_2 from commandbutton within w_ge505_ifood
integer x = 411
integer y = 360
integer width = 640
integer height = 132
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "2 - Feed Pedidos"
end type

event clicked;uo_ge505_pedido_feed luo_prod

luo_prod = create uo_ge505_pedido_feed

luo_prod.of_processa_atualizacao_pedido()

destroy(luo_prod)
end event

type cb_1 from commandbutton within w_ge505_ifood
integer x = 411
integer y = 220
integer width = 640
integer height = 132
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "1 - Produto"
end type

event clicked;uo_ge505_produto luo_prod

luo_prod = create uo_ge505_produto

//Todas lojas
//luo_prod.of_processa_atualizacao_produto( )

//Loja especifica
luo_prod.of_processa_atualizacao_produto(42,'DC',744327)

destroy(luo_prod)
end event

