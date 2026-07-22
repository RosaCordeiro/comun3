HA$PBExportHeader$w_ge370_rel_abcfarma_exist_nao_recebido.srw
forward
global type w_ge370_rel_abcfarma_exist_nao_recebido from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge370_rel_abcfarma_exist_nao_recebido from dc_w_selecao_lista_relatorio
integer y = 388
integer width = 3433
integer height = 1816
string title = "GE370 - Relat$$HEX1$$f300$$ENDHEX$$rio de Inconsist$$HEX1$$ea00$$ENDHEX$$ncias ABC Farma - Produtos Existentes n$$HEX1$$e300$$ENDHEX$$o Recebidos"
end type
global w_ge370_rel_abcfarma_exist_nao_recebido w_ge370_rel_abcfarma_exist_nao_recebido

on w_ge370_rel_abcfarma_exist_nao_recebido.create
call super::create
end on

on w_ge370_rel_abcfarma_exist_nao_recebido.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Retrieve()

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge370_rel_abcfarma_exist_nao_recebido
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge370_rel_abcfarma_exist_nao_recebido
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge370_rel_abcfarma_exist_nao_recebido
integer y = 280
integer width = 3314
integer height = 1320
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge370_rel_abcfarma_exist_nao_recebido
integer width = 1527
integer height = 252
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge370_rel_abcfarma_exist_nao_recebido
integer x = 46
integer y = 76
integer width = 1499
integer height = 164
string dataobject = "dw_ge370_selecao_relatorio_inconsistencia"
end type

event dw_1::ue_retrieve;call super::ue_retrieve;Return This.Retrieve()
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge370_rel_abcfarma_exist_nao_recebido
integer x = 59
integer y = 332
integer width = 3255
integer height = 1236
string dataobject = "dw_ge370_abcfarma_existente_nao_recebido"
end type

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge370_rel_abcfarma_exist_nao_recebido
integer x = 2784
integer y = 36
integer width = 434
integer height = 216
string dataobject = "dw_ge370_rel_abcfarma_existente_nao_recebido"
end type

