HA$PBExportHeader$w_ge331_historico_msg_recusa.srw
forward
global type w_ge331_historico_msg_recusa from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge331_historico_msg_recusa
end type
end forward

global type w_ge331_historico_msg_recusa from dc_w_response_ok_cancela
integer width = 4585
integer height = 1520
string title = "GE331 - Hist$$HEX1$$f300$$ENDHEX$$rico de Mensagem de Recusa"
dw_2 dw_2
end type
global w_ge331_historico_msg_recusa w_ge331_historico_msg_recusa

type variables
String is_Chave_Acesso
end variables

on w_ge331_historico_msg_recusa.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_ge331_historico_msg_recusa.destroy
call super::destroy
destroy(this.dw_2)
end on

event open;call super::open;is_Chave_Acesso = Message.StringParm

dw_1.Event ue_Retrieve()
end event

event ue_postopen;//OverRide
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge331_historico_msg_recusa
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge331_historico_msg_recusa
integer height = 516
string text = "Lista"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge331_historico_msg_recusa
integer height = 424
string dataobject = "dw_ge331_historico_msg_recusa"
end type

event dw_1::rowfocuschanged;call super::rowfocuschanged;If (Not IsNull(CurrentRow)) and (CurrentRow > 0) and (CurrentRow <= This.RowCount()) Then
	dw_2.Object.de_de	[1] = This.Object.de_alteracao_de	[CurrentRow]
	dw_2.Object.de_para	[1] = This.Object.de_alteracao_para	[CurrentRow]
Else
	dw_2.Object.de_de	[1] = ''
	dw_2.Object.de_para	[1] = ''
End If
end event

event dw_1::ue_recuperar;//OverRide

Return This.Retrieve(is_Chave_Acesso)
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	dw_2.Event RowFocusChanged(1)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "NF n$$HEX1$$e300$$ENDHEX$$o possui hist$$HEX1$$f300$$ENDHEX$$rico de mensagem recusa.")
	cb_Cancelar.Event Clicked()
End If

Return pl_Linhas
end event

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge331_historico_msg_recusa
integer x = 4206
integer y = 1304
end type

event cb_ok::clicked;call super::clicked;cb_Cancelar.Event Clicked()
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge331_historico_msg_recusa
boolean visible = false
integer x = 3799
integer y = 1304
end type

type dw_2 from dc_uo_dw_base within w_ge331_historico_msg_recusa
integer x = 23
integer y = 540
integer width = 4539
integer height = 748
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge331_alter_msg_recusa"
end type

