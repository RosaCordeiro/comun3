HA$PBExportHeader$w_ge002_selecao_dependente_cliente_paf.srw
forward
global type w_ge002_selecao_dependente_cliente_paf from w_ge002_selecao_dependente_cliente
end type
type uo_1 from uo_texto_paf2 within w_ge002_selecao_dependente_cliente_paf
end type
end forward

global type w_ge002_selecao_dependente_cliente_paf from w_ge002_selecao_dependente_cliente
uo_1 uo_1
end type
global w_ge002_selecao_dependente_cliente_paf w_ge002_selecao_dependente_cliente_paf

on w_ge002_selecao_dependente_cliente_paf.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_ge002_selecao_dependente_cliente_paf.destroy
call super::destroy
destroy(this.uo_1)
end on

type pb_help from w_ge002_selecao_dependente_cliente`pb_help within w_ge002_selecao_dependente_cliente_paf
end type

type gb_2 from w_ge002_selecao_dependente_cliente`gb_2 within w_ge002_selecao_dependente_cliente_paf
end type

type gb_1 from w_ge002_selecao_dependente_cliente`gb_1 within w_ge002_selecao_dependente_cliente_paf
end type

type dw_1 from w_ge002_selecao_dependente_cliente`dw_1 within w_ge002_selecao_dependente_cliente_paf
end type

type dw_2 from w_ge002_selecao_dependente_cliente`dw_2 within w_ge002_selecao_dependente_cliente_paf
end type

type cb_selecionar from w_ge002_selecao_dependente_cliente`cb_selecionar within w_ge002_selecao_dependente_cliente_paf
end type

type cb_cancelar from w_ge002_selecao_dependente_cliente`cb_cancelar within w_ge002_selecao_dependente_cliente_paf
end type

type cb_pesquisar from w_ge002_selecao_dependente_cliente`cb_pesquisar within w_ge002_selecao_dependente_cliente_paf
end type

type st_mensagem from w_ge002_selecao_dependente_cliente`st_mensagem within w_ge002_selecao_dependente_cliente_paf
integer width = 1029
end type

type uo_1 from uo_texto_paf2 within w_ge002_selecao_dependente_cliente_paf
integer x = 1088
integer y = 1392
integer height = 108
integer taborder = 60
boolean bringtotop = true
end type

on uo_1.destroy
call uo_texto_paf2::destroy
end on

