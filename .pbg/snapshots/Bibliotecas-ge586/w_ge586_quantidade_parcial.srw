HA$PBExportHeader$w_ge586_quantidade_parcial.srw
forward
global type w_ge586_quantidade_parcial from dc_w_response_ok_cancela
end type
end forward

global type w_ge586_quantidade_parcial from dc_w_response_ok_cancela
string tag = "w_ws164_selecao_motivo_bloqueio"
integer width = 1723
integer height = 520
string title = "WS164 - Sele$$HEX2$$e700e300$$ENDHEX$$o Motivo Bloqueio de Endere$$HEX1$$e700$$ENDHEX$$o"
end type
global w_ge586_quantidade_parcial w_ge586_quantidade_parcial

type variables
string ivs_Parametro,&
		is_Cd_Endereco

Long il_qtd_solicitacao
end variables

on w_ge586_quantidade_parcial.create
call super::create
end on

on w_ge586_quantidade_parcial.destroy
call super::destroy
end on

event open;call super::open;il_qtd_solicitacao = long(Message.StringParm)

end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge586_quantidade_parcial
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge586_quantidade_parcial
integer width = 1669
integer height = 300
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge586_quantidade_parcial
integer x = 169
integer y = 56
integer width = 1339
integer height = 232
string dataobject = "dw_ge586_quantidade_parcial"
boolean livescroll = false
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge586_quantidade_parcial
integer x = 1029
integer y = 312
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Long ll_Qtd_Parcial
String ls_Parametro, ls_Motivo

dw_1.AcceptText()

ll_Qtd_Parcial 	= Long(dw_1.Object.qtd_parcial[1])
ls_Motivo			= dw_1.Object.de_motivo[1]

If ll_Qtd_Parcial >= il_qtd_solicitacao Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Quantidade parcial deve ser menor que o total da solicita$$HEX2$$e700e300$$ENDHEX$$o! ~nQuantidade da Solicita$$HEX2$$e700e300$$ENDHEX$$o: ' + string(il_qtd_solicitacao))
	dw_1.Event ue_Pos(1, "qtd_parcial")
	Return 1
End If

If ll_Qtd_Parcial <= 0 Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Quantidade parcial n$$HEX1$$e300$$ENDHEX$$o pode ser negativa ou 0!')
	dw_1.Event ue_Pos(1, "qtd_parcial")
	Return 1
End If

If IsNull(ll_Qtd_Parcial) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Quantidade parcial inv$$HEX1$$e100$$ENDHEX$$lida!')
	dw_1.Event ue_Pos(1, "qtd_parcial")
	Return 1
End If

If IsNull(ls_Motivo) Or ls_Motivo = "" Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Favor informar um motivo!')
	dw_1.Event ue_Pos(1, "de_motivo")
	Return 1
End If

If Len(ls_Motivo) > 50 Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Tamanho m$$HEX1$$e100$$ENDHEX$$ximo do motivo excedido. ~nFavor reduzir o tamanho.')
	dw_1.Event ue_Pos(1, "de_motivo")
	Return 1
End If

ls_Parametro = string(ll_Qtd_Parcial)+';'+ls_Motivo

ClosewithReturn(Parent, ls_Parametro) 

return 1
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge586_quantidade_parcial
integer x = 1362
integer y = 312
end type

