HA$PBExportHeader$w_ge002_lista_bloqueio_paf.srw
forward
global type w_ge002_lista_bloqueio_paf from w_ge002_lista_bloqueio
end type
type uo_1 from uo_texto_paf within w_ge002_lista_bloqueio_paf
end type
end forward

global type w_ge002_lista_bloqueio_paf from w_ge002_lista_bloqueio
integer height = 1588
uo_1 uo_1
end type
global w_ge002_lista_bloqueio_paf w_ge002_lista_bloqueio_paf

on w_ge002_lista_bloqueio_paf.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_ge002_lista_bloqueio_paf.destroy
call super::destroy
destroy(this.uo_1)
end on

type pb_help from w_ge002_lista_bloqueio`pb_help within w_ge002_lista_bloqueio_paf
end type

type gb_1 from w_ge002_lista_bloqueio`gb_1 within w_ge002_lista_bloqueio_paf
end type

type dw_1 from w_ge002_lista_bloqueio`dw_1 within w_ge002_lista_bloqueio_paf
end type

type cb_ok from w_ge002_lista_bloqueio`cb_ok within w_ge002_lista_bloqueio_paf
end type

type cb_cancelar from w_ge002_lista_bloqueio`cb_cancelar within w_ge002_lista_bloqueio_paf
end type

type st_1 from w_ge002_lista_bloqueio`st_1 within w_ge002_lista_bloqueio_paf
end type

type uo_1 from uo_texto_paf within w_ge002_lista_bloqueio_paf
integer x = 325
integer y = 1436
integer height = 68
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_texto_paf::destroy
end on

