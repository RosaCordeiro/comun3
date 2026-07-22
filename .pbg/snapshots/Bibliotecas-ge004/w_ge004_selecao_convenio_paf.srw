HA$PBExportHeader$w_ge004_selecao_convenio_paf.srw
forward
global type w_ge004_selecao_convenio_paf from w_ge004_selecao_convenio
end type
type uo_1 from uo_texto_paf2 within w_ge004_selecao_convenio_paf
end type
end forward

global type w_ge004_selecao_convenio_paf from w_ge004_selecao_convenio
uo_1 uo_1
end type
global w_ge004_selecao_convenio_paf w_ge004_selecao_convenio_paf

on w_ge004_selecao_convenio_paf.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_ge004_selecao_convenio_paf.destroy
call super::destroy
destroy(this.uo_1)
end on

type pb_help from w_ge004_selecao_convenio`pb_help within w_ge004_selecao_convenio_paf
end type

type gb_2 from w_ge004_selecao_convenio`gb_2 within w_ge004_selecao_convenio_paf
end type

type gb_1 from w_ge004_selecao_convenio`gb_1 within w_ge004_selecao_convenio_paf
end type

type dw_1 from w_ge004_selecao_convenio`dw_1 within w_ge004_selecao_convenio_paf
end type

type dw_2 from w_ge004_selecao_convenio`dw_2 within w_ge004_selecao_convenio_paf
end type

type cb_selecionar from w_ge004_selecao_convenio`cb_selecionar within w_ge004_selecao_convenio_paf
end type

type cb_cancelar from w_ge004_selecao_convenio`cb_cancelar within w_ge004_selecao_convenio_paf
end type

type cb_pesquisar from w_ge004_selecao_convenio`cb_pesquisar within w_ge004_selecao_convenio_paf
end type

type st_mensagem from w_ge004_selecao_convenio`st_mensagem within w_ge004_selecao_convenio_paf
integer width = 1042
end type

type uo_1 from uo_texto_paf2 within w_ge004_selecao_convenio_paf
integer x = 1093
integer y = 1312
integer height = 104
integer taborder = 60
boolean bringtotop = true
end type

on uo_1.destroy
call uo_texto_paf2::destroy
end on

