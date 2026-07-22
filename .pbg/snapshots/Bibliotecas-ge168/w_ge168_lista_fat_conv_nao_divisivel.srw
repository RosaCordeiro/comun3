HA$PBExportHeader$w_ge168_lista_fat_conv_nao_divisivel.srw
forward
global type w_ge168_lista_fat_conv_nao_divisivel from dc_w_response_ok_cancela
end type
end forward

global type w_ge168_lista_fat_conv_nao_divisivel from dc_w_response_ok_cancela
integer width = 1614
integer height = 1228
string title = "GE168 - Filial Possui Produto com Estoque Base n$$HEX1$$e300$$ENDHEX$$o Divis$$HEX1$$ed00$$ENDHEX$$vel"
end type
global w_ge168_lista_fat_conv_nao_divisivel w_ge168_lista_fat_conv_nao_divisivel

on w_ge168_lista_fat_conv_nao_divisivel.create
call super::create
end on

on w_ge168_lista_fat_conv_nao_divisivel.destroy
call super::destroy
end on

event ue_postopen;//OverRide

dc_uo_dw_base ldw
ldw = Create dc_uo_dw_base

ldw = Message.PowerObjectParm

If ldw.ShareData(dw_1) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Share Data.", StopSign!)
	Destroy(ldw)
	Return
End If

dw_1.SetFocus()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge168_lista_fat_conv_nao_divisivel
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge168_lista_fat_conv_nao_divisivel
integer width = 1550
integer height = 996
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge168_lista_fat_conv_nao_divisivel
integer width = 1486
integer height = 900
string dataobject = "dw_ge168_lista_filial_conv_nao_divisivel"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge168_lista_fat_conv_nao_divisivel
integer x = 923
integer y = 1020
end type

event cb_ok::clicked;call super::clicked;String lvs_Retorno

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge168_lista_fat_conv_nao_divisivel
integer x = 1257
integer y = 1020
end type

