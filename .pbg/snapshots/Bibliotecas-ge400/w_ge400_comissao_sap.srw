HA$PBExportHeader$w_ge400_comissao_sap.srw
forward
global type w_ge400_comissao_sap from dc_w_response_ok_cancela
end type
end forward

global type w_ge400_comissao_sap from dc_w_response_ok_cancela
integer width = 2757
integer height = 1028
string title = "GE400 - Comiss$$HEX1$$e300$$ENDHEX$$o SAP"
end type
global w_ge400_comissao_sap w_ge400_comissao_sap

type variables
st_comissao_sap str
end variables

on w_ge400_comissao_sap.create
call super::create
end on

on w_ge400_comissao_sap.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;str = Message.PowerObjectParm	

dw_1.Event ue_Retrieve()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge400_comissao_sap
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge400_comissao_sap
integer width = 2706
integer height = 800
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge400_comissao_sap
integer width = 2661
integer height = 708
string dataobject = "dw_ge400_lista_comissao_sap"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::ue_recuperar;// OverRide
Return This.Retrieve(str.cd_produto, str.cd_tipo_comissao)
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge400_comissao_sap
boolean visible = false
integer x = 1678
integer y = 824
boolean enabled = false
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge400_comissao_sap
integer x = 2363
integer y = 824
string text = "&Sair"
end type

