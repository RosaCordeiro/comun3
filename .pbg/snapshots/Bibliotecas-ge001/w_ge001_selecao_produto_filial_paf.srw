HA$PBExportHeader$w_ge001_selecao_produto_filial_paf.srw
forward
global type w_ge001_selecao_produto_filial_paf from w_ge001_selecao_produto_filial
end type
type uo_1 from uo_texto_paf2 within w_ge001_selecao_produto_filial_paf
end type
end forward

global type w_ge001_selecao_produto_filial_paf from w_ge001_selecao_produto_filial
uo_1 uo_1
end type
global w_ge001_selecao_produto_filial_paf w_ge001_selecao_produto_filial_paf

on w_ge001_selecao_produto_filial_paf.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_ge001_selecao_produto_filial_paf.destroy
call super::destroy
destroy(this.uo_1)
end on

type pb_help from w_ge001_selecao_produto_filial`pb_help within w_ge001_selecao_produto_filial_paf
end type

type gb_2 from w_ge001_selecao_produto_filial`gb_2 within w_ge001_selecao_produto_filial_paf
end type

type gb_1 from w_ge001_selecao_produto_filial`gb_1 within w_ge001_selecao_produto_filial_paf
end type

type dw_1 from w_ge001_selecao_produto_filial`dw_1 within w_ge001_selecao_produto_filial_paf
end type

type dw_2 from w_ge001_selecao_produto_filial`dw_2 within w_ge001_selecao_produto_filial_paf
end type

type cb_selecionar from w_ge001_selecao_produto_filial`cb_selecionar within w_ge001_selecao_produto_filial_paf
end type

type cb_cancelar from w_ge001_selecao_produto_filial`cb_cancelar within w_ge001_selecao_produto_filial_paf
end type

type cb_pesquisar from w_ge001_selecao_produto_filial`cb_pesquisar within w_ge001_selecao_produto_filial_paf
end type

type st_mensagem from w_ge001_selecao_produto_filial`st_mensagem within w_ge001_selecao_produto_filial_paf
integer width = 1280
end type

type uo_1 from uo_texto_paf2 within w_ge001_selecao_produto_filial_paf
integer x = 1362
integer y = 1676
integer taborder = 40
boolean bringtotop = true
end type

on uo_1.destroy
call uo_texto_paf2::destroy
end on

