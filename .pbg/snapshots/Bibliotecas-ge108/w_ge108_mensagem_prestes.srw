HA$PBExportHeader$w_ge108_mensagem_prestes.srw
forward
global type w_ge108_mensagem_prestes from dc_w_response_ok_cancela
end type
end forward

global type w_ge108_mensagem_prestes from dc_w_response_ok_cancela
integer width = 2505
integer height = 760
boolean titlebar = false
long backcolor = 15793151
end type
global w_ge108_mensagem_prestes w_ge108_mensagem_prestes

type variables
srt_mensagem_prestes istr_mensagem_prestes

Long il_Botao = 1
end variables

on w_ge108_mensagem_prestes.create
call super::create
end on

on w_ge108_mensagem_prestes.destroy
call super::destroy
end on

event open;call super::open;istr_mensagem_prestes = Message.PowerObjectParm
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.De_Titulo		[ 1 ] = istr_mensagem_prestes.De_Titulo
dw_1.Object.Desc_Produto	[ 1 ] = istr_mensagem_prestes.Desc_Produto
dw_1.Object.Pc_Desconto	[ 1 ] = istr_mensagem_prestes.Pc_Desconto
dw_1.Object.vl_Preco			[ 1 ] = istr_mensagem_prestes.vl_Venda
dw_1.Object.dh_Validade	[ 1 ] = istr_mensagem_prestes.dh_Validade
dw_1.Object.qt_Disponivel	[ 1 ] = istr_mensagem_prestes.qt_disponivel

This.BackColor = istr_mensagem_prestes.cd_backcolor
This.gb_1.BackColor = istr_mensagem_prestes.cd_backcolor
dw_1.Modify( "DataWindow.Color='" + String( istr_mensagem_prestes.cd_backcolor ) + "'" )

cb_Ok.SetFocus( )
end event

event key;call super::key;If Key = KeyLeftArrow! Or Key = KeyRightArrow! Then
	If This.il_Botao = 1 Then
		This.il_Botao = 2
		cb_Cancelar.Setfocus( )
	Else
		This.il_Botao = 1
		cb_Ok.Setfocus( )
	End If
End If
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge108_mensagem_prestes
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge108_mensagem_prestes
integer height = 564
long backcolor = 16777215
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge108_mensagem_prestes
integer height = 456
string dataobject = "dw_ge108_mensagem_prestes"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge108_mensagem_prestes
integer x = 1746
integer y = 612
string text = "&Sim"
boolean default = false
end type

event cb_ok::clicked;call super::clicked;CloseWithReturn(Parent, 'SIM')
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge108_mensagem_prestes
integer x = 2121
integer y = 608
string text = "&N$$HEX1$$e300$$ENDHEX$$o"
boolean cancel = false
end type

