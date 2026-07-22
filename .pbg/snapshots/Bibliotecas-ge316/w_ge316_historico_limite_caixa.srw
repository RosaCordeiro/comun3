HA$PBExportHeader$w_ge316_historico_limite_caixa.srw
forward
global type w_ge316_historico_limite_caixa from window
end type
type cb_1 from commandbutton within w_ge316_historico_limite_caixa
end type
type dw_1 from dc_uo_dw_base within w_ge316_historico_limite_caixa
end type
type gb_1 from groupbox within w_ge316_historico_limite_caixa
end type
end forward

global type w_ge316_historico_limite_caixa from window
integer x = 489
integer y = 480
integer width = 1477
integer height = 1032
windowtype windowtype = child!
long backcolor = 80269524
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge316_historico_limite_caixa w_ge316_historico_limite_caixa

on w_ge316_historico_limite_caixa.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.cb_1,&
this.dw_1,&
this.gb_1}
end on

on w_ge316_historico_limite_caixa.destroy
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;Long ll_filial

ll_filial = Long(Message.StringParm)

dw_1.Retrieve(ll_filial)
end event

type cb_1 from commandbutton within w_ge316_historico_limite_caixa
integer x = 23
integer y = 888
integer width = 370
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Sair"
end type

event clicked;Close(Parent)
end event

type dw_1 from dc_uo_dw_base within w_ge316_historico_limite_caixa
integer x = 50
integer y = 48
integer width = 1353
integer height = 796
integer taborder = 20
string dataobject = "dw_ge316_historico_limite"
boolean vscrollbar = true
end type

type gb_1 from groupbox within w_ge316_historico_limite_caixa
integer x = 23
integer width = 1413
integer height = 872
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

