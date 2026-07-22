HA$PBExportHeader$dc_w_liberacao_procedimento_paf.srw
forward
global type dc_w_liberacao_procedimento_paf from dc_w_liberacao_procedimento
end type
type uo_1 from uo_texto_paf2 within dc_w_liberacao_procedimento_paf
end type
end forward

global type dc_w_liberacao_procedimento_paf from dc_w_liberacao_procedimento
uo_1 uo_1
end type
global dc_w_liberacao_procedimento_paf dc_w_liberacao_procedimento_paf

on dc_w_liberacao_procedimento_paf.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on dc_w_liberacao_procedimento_paf.destroy
call super::destroy
destroy(this.uo_1)
end on

type pb_help from dc_w_liberacao_procedimento`pb_help within dc_w_liberacao_procedimento_paf
end type

type cb_ok from dc_w_liberacao_procedimento`cb_ok within dc_w_liberacao_procedimento_paf
end type

type cb_cancelar from dc_w_liberacao_procedimento`cb_cancelar within dc_w_liberacao_procedimento_paf
end type

type dw_1 from dc_w_liberacao_procedimento`dw_1 within dc_w_liberacao_procedimento_paf
end type

type uo_1 from uo_texto_paf2 within dc_w_liberacao_procedimento_paf
integer x = 192
integer y = 500
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_texto_paf2::destroy
end on

