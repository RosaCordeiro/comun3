HA$PBExportHeader$w_ge667_lancamento_conta_cartao.srw
forward
global type w_ge667_lancamento_conta_cartao from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge667_lancamento_conta_cartao from dc_w_selecao_lista_relatorio
end type
global w_ge667_lancamento_conta_cartao w_ge667_lancamento_conta_cartao

on w_ge667_lancamento_conta_cartao.create
call super::create
end on

on w_ge667_lancamento_conta_cartao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge667_lancamento_conta_cartao
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge667_lancamento_conta_cartao
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge667_lancamento_conta_cartao
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge667_lancamento_conta_cartao
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge667_lancamento_conta_cartao
end type

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge667_lancamento_conta_cartao
end type

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge667_lancamento_conta_cartao
end type

