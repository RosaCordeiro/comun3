HA$PBExportHeader$w_ge6334_pedidos_ecommerce.srw
forward
global type w_ge6334_pedidos_ecommerce from dc_w_2tab_consulta_selecao_lista_det
end type
end forward

global type w_ge6334_pedidos_ecommerce from dc_w_2tab_consulta_selecao_lista_det
end type
global w_ge6334_pedidos_ecommerce w_ge6334_pedidos_ecommerce

on w_ge6334_pedidos_ecommerce.create
call super::create
end on

on w_ge6334_pedidos_ecommerce.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge6334_pedidos_ecommerce
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge6334_pedidos_ecommerce
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge6334_pedidos_ecommerce
end type

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
end type

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
end type

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
end type

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
end type

