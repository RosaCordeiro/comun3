HA$PBExportHeader$w_ge252_selecao_nf_agrupadas.srw
forward
global type w_ge252_selecao_nf_agrupadas from dc_w_response_ok_cancela
end type
end forward

global type w_ge252_selecao_nf_agrupadas from dc_w_response_ok_cancela
integer width = 1006
integer height = 1116
string title = "Sele$$HEX2$$e700e300$$ENDHEX$$o de Notas"
end type
global w_ge252_selecao_nf_agrupadas w_ge252_selecao_nf_agrupadas

type variables
Long	il_nr_agrupamento
end variables

on w_ge252_selecao_nf_agrupadas.create
call super::create
end on

on w_ge252_selecao_nf_agrupadas.destroy
call super::destroy
end on

event open;call super::open;il_nr_agrupamento	= Message.DoubleParm

if il_nr_agrupamento < 1 then
	Close(this)
	return
end if
end event

event ue_postopen;call super::ue_postopen;if dw_1.Retrieve(il_nr_agrupamento) < 1 then
	Close(this)
	return
end if
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge252_selecao_nf_agrupadas
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge252_selecao_nf_agrupadas
integer width = 946
integer height = 900
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge252_selecao_nf_agrupadas
integer width = 905
integer height = 820
string dataobject = "dw_ge252_seleciona_nf_agrupadas"
boolean vscrollbar = true
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge252_selecao_nf_agrupadas
integer x = 329
integer y = 916
end type

event cb_ok::clicked;call super::clicked;Long		ll_for, ll_notas_selecionadas[]
String	ls_lista_notas

uo_ge040_array	luo_array


for ll_for = 1 to dw_1.RowCount()
	ll_notas_selecionadas[ll_for]	= dw_1.Object.nr_nf[ll_for]
next

ls_lista_notas	= luo_array.uof_array_to_list(ll_notas_selecionadas)

CloseWithReturn(Parent, ls_lista_notas)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge252_selecao_nf_agrupadas
integer x = 663
integer y = 916
end type

