HA$PBExportHeader$w_ge400_preco_legado.srw
forward
global type w_ge400_preco_legado from dc_w_response_ok_cancela
end type
end forward

global type w_ge400_preco_legado from dc_w_response_ok_cancela
integer width = 1582
integer height = 584
string title = "GE400 - Pre$$HEX1$$e700$$ENDHEX$$o Legado"
end type
global w_ge400_preco_legado w_ge400_preco_legado

on w_ge400_preco_legado.create
call super::create
end on

on w_ge400_preco_legado.destroy
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

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge400_preco_legado
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge400_preco_legado
integer width = 1522
integer height = 340
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge400_preco_legado
integer width = 1472
integer height = 260
string dataobject = "dw_ge400_preco_legado"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge400_preco_legado
boolean visible = false
integer x = 18
integer y = 452
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge400_preco_legado
integer x = 1225
integer y = 376
string text = "&OK"
boolean cancel = false
boolean default = true
end type

