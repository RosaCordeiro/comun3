HA$PBExportHeader$w_ge510_monitor_interfaces_detalhe.srw
forward
global type w_ge510_monitor_interfaces_detalhe from dc_w_response
end type
type uo_det from uo_ge510_detalhes within w_ge510_monitor_interfaces_detalhe
end type
type cb_1 from commandbutton within w_ge510_monitor_interfaces_detalhe
end type
type gb_1 from groupbox within w_ge510_monitor_interfaces_detalhe
end type
end forward

global type w_ge510_monitor_interfaces_detalhe from dc_w_response
integer width = 3854
integer height = 2224
string title = "GE510 - Detalhes"
uo_det uo_det
cb_1 cb_1
gb_1 gb_1
end type
global w_ge510_monitor_interfaces_detalhe w_ge510_monitor_interfaces_detalhe

type variables
long il_cd_tipo
long il_cd_filial
long il_nr_atualizacao
end variables

on w_ge510_monitor_interfaces_detalhe.create
int iCurrent
call super::create
this.uo_det=create uo_det
this.cb_1=create cb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_det
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.gb_1
end on

on w_ge510_monitor_interfaces_detalhe.destroy
call super::destroy
destroy(this.uo_det)
destroy(this.cb_1)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;uo_det.of_carrega_detalhes( il_cd_filial, il_nr_atualizacao, il_cd_tipo )
end event

event ue_preopen;call super::ue_preopen;st_ge510_detalhes lst_parametros

lst_parametros = message.powerobjectparm

il_cd_filial = lst_parametros.cd_filial
il_nr_atualizacao = lst_parametros.nr_atualizacao
il_cd_tipo = lst_parametros.cd_tipo
end event

type pb_help from dc_w_response`pb_help within w_ge510_monitor_interfaces_detalhe
end type

type uo_det from uo_ge510_detalhes within w_ge510_monitor_interfaces_detalhe
integer x = 46
integer y = 48
integer taborder = 20
boolean bringtotop = true
boolean ib_exibe_filtros = false
boolean ib_marca_erros = true
end type

on uo_det.destroy
call uo_ge510_detalhes::destroy
end on

type cb_1 from commandbutton within w_ge510_monitor_interfaces_detalhe
integer x = 3255
integer y = 1968
integer width = 439
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Fechar"
boolean cancel = true
end type

event clicked;Close(parent)
end event

type gb_1 from groupbox within w_ge510_monitor_interfaces_detalhe
integer x = 23
integer width = 3794
integer height = 2116
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

