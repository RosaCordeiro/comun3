HA$PBExportHeader$w_ge002_bloqueio_paf.srw
forward
global type w_ge002_bloqueio_paf from w_ge002_bloqueio
end type
type uo_1 from uo_texto_paf within w_ge002_bloqueio_paf
end type
end forward

global type w_ge002_bloqueio_paf from w_ge002_bloqueio
integer height = 436
uo_1 uo_1
end type
global w_ge002_bloqueio_paf w_ge002_bloqueio_paf

on w_ge002_bloqueio_paf.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_ge002_bloqueio_paf.destroy
call super::destroy
destroy(this.uo_1)
end on

type pb_help from w_ge002_bloqueio`pb_help within w_ge002_bloqueio_paf
end type

type cb_1 from w_ge002_bloqueio`cb_1 within w_ge002_bloqueio_paf
end type

type cb_2 from w_ge002_bloqueio`cb_2 within w_ge002_bloqueio_paf
end type

type cb_3 from w_ge002_bloqueio`cb_3 within w_ge002_bloqueio_paf
end type

type gb_1 from w_ge002_bloqueio`gb_1 within w_ge002_bloqueio_paf
end type

type st_1 from w_ge002_bloqueio`st_1 within w_ge002_bloqueio_paf
end type

type uo_1 from uo_texto_paf within w_ge002_bloqueio_paf
integer x = 293
integer y = 352
integer height = 68
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_texto_paf::destroy
end on

