HA$PBExportHeader$w_ge471_revisao_log.srw
forward
global type w_ge471_revisao_log from dc_w_response_ok_cancela
end type
end forward

global type w_ge471_revisao_log from dc_w_response_ok_cancela
integer width = 1742
integer height = 792
string title = "GE471 - Revis$$HEX1$$e300$$ENDHEX$$o de Logs"
end type
global w_ge471_revisao_log w_ge471_revisao_log

on w_ge471_revisao_log.create
call super::create
end on

on w_ge471_revisao_log.destroy
call super::destroy
end on

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge471_revisao_log
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge471_revisao_log
integer width = 1673
integer height = 528
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge471_revisao_log
integer width = 1614
integer height = 436
string dataobject = "dw_ge471_revisao"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge471_revisao_log
integer x = 1042
integer y = 568
end type

event cb_ok::clicked;call super::clicked;String lvs_Id_Revisao
String lvs_De_Revisao

dw_1.AcceptText( )

lvs_Id_Revisao	= dw_1.Object.id_revisao	[1]
lvs_De_Revisao	= dw_1.Object.de_revisao	[1]

CloseWithReturn(Parent, lvs_Id_Revisao+";"+lvs_De_Revisao)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge471_revisao_log
integer x = 1376
integer y = 568
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent, '')
end event

