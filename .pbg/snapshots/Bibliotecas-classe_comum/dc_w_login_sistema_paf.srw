HA$PBExportHeader$dc_w_login_sistema_paf.srw
forward
global type dc_w_login_sistema_paf from dc_w_login_sistema
end type
type uo_1 from uo_texto_paf within dc_w_login_sistema_paf
end type
end forward

global type dc_w_login_sistema_paf from dc_w_login_sistema
uo_1 uo_1
end type
global dc_w_login_sistema_paf dc_w_login_sistema_paf

on dc_w_login_sistema_paf.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on dc_w_login_sistema_paf.destroy
call super::destroy
destroy(this.uo_1)
end on

type pb_help from dc_w_login_sistema`pb_help within dc_w_login_sistema_paf
end type

type cb_ok from dc_w_login_sistema`cb_ok within dc_w_login_sistema_paf
end type

type cb_cancelar from dc_w_login_sistema`cb_cancelar within dc_w_login_sistema_paf
end type

type dw_1 from dc_w_login_sistema`dw_1 within dc_w_login_sistema_paf
end type

type cb_procura_digital from dc_w_login_sistema`cb_procura_digital within dc_w_login_sistema_paf
end type

type uo_1 from uo_texto_paf within dc_w_login_sistema_paf
integer x = 14
integer y = 432
integer taborder = 30
end type

on uo_1.destroy
call uo_texto_paf::destroy
end on

