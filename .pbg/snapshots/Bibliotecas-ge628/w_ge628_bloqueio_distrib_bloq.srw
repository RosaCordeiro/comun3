HA$PBExportHeader$w_ge628_bloqueio_distrib_bloq.srw
forward
global type w_ge628_bloqueio_distrib_bloq from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge628_bloqueio_distrib_bloq from dc_w_cadastro_selecao_lista
end type
global w_ge628_bloqueio_distrib_bloq w_ge628_bloqueio_distrib_bloq

on w_ge628_bloqueio_distrib_bloq.create
call super::create
end on

on w_ge628_bloqueio_distrib_bloq.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge628_bloqueio_distrib_bloq
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge628_bloqueio_distrib_bloq
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge628_bloqueio_distrib_bloq
end type

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge628_bloqueio_distrib_bloq
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge628_bloqueio_distrib_bloq
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge628_bloqueio_distrib_bloq
end type

