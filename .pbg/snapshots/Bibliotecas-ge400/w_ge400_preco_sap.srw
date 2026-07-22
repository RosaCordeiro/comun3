HA$PBExportHeader$w_ge400_preco_sap.srw
forward
global type w_ge400_preco_sap from dc_w_response_ok_cancela
end type
end forward

global type w_ge400_preco_sap from dc_w_response_ok_cancela
integer width = 1582
integer height = 612
string title = "GE400 - Pre$$HEX1$$e700$$ENDHEX$$o SAP"
end type
global w_ge400_preco_sap w_ge400_preco_sap

on w_ge400_preco_sap.create
call super::create
end on

on w_ge400_preco_sap.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;datastore lds_dados 

lds_dados = create datastore

lds_dados = message.powerobjectparm

dw_1.reset()

if lds_dados.rowscopy(1,lds_dados.rowcount(),primary!, dw_1, 1, primary! ) = -1 then 
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao executar m$$HEX1$$e900$$ENDHEX$$todo ROWSCOPY.')
	return
end if

if dw_1.rowcount( ) = 0 then
	dw_1.insertrow( 1)
end if
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge400_preco_sap
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge400_preco_sap
integer width = 1522
integer height = 364
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge400_preco_sap
integer width = 1472
integer height = 284
string dataobject = "dw_ge400_preco_sap"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge400_preco_sap
boolean visible = false
integer x = 27
integer y = 472
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge400_preco_sap
integer x = 1225
integer y = 396
string text = "&OK"
boolean cancel = false
boolean default = true
end type

