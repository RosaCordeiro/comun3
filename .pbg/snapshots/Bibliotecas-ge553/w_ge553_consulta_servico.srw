HA$PBExportHeader$w_ge553_consulta_servico.srw
forward
global type w_ge553_consulta_servico from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge553_consulta_servico from dc_w_selecao_lista_relatorio
end type
global w_ge553_consulta_servico w_ge553_consulta_servico

on w_ge553_consulta_servico.create
call super::create
end on

on w_ge553_consulta_servico.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge553_consulta_servico
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge553_consulta_servico
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge553_consulta_servico
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge553_consulta_servico
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge553_consulta_servico
end type

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge553_consulta_servico
end type

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge553_consulta_servico
end type

