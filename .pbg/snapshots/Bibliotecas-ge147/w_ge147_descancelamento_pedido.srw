HA$PBExportHeader$w_ge147_descancelamento_pedido.srw
forward
global type w_ge147_descancelamento_pedido from dc_w_response_ok_cancela
end type
end forward

global type w_ge147_descancelamento_pedido from dc_w_response_ok_cancela
integer width = 2098
integer height = 512
string title = "GE147 - Descancelamento Pedido"
end type
global w_ge147_descancelamento_pedido w_ge147_descancelamento_pedido

type variables
Long ivl_Pedido 

String ivs_Responsavel
end variables

on w_ge147_descancelamento_pedido.create
call super::create
end on

on w_ge147_descancelamento_pedido.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;ivl_Pedido = Long(Mid(Message.StringParm, 2, 10))

dw_1.Object.nr_pedido[1] = ivl_Pedido






end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge147_descancelamento_pedido
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge147_descancelamento_pedido
integer width = 2030
integer height = 272
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge147_descancelamento_pedido
integer width = 1938
integer height = 180
string dataobject = "dw_ge147_lista_descancelamento_pedido1"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge147_descancelamento_pedido
integer x = 1376
integer y = 304
integer width = 325
string text = "Confirmar"
end type

event cb_ok::clicked;call super::clicked;String lvs_Responsavel, &
		lvs_Motivo,&
		ls_Sit_Anterior,&
		ls_Sit_Nova
		
Integer lvi_Tamanho

lvs_Responsavel 	= Mid(Message.StringParm, 12)
ls_Sit_Anterior		= Mid(Message.StringParm, 1,1)

dw_1.AcceptText()

lvs_Motivo 		  = dw_1.Object.de_motivo[1]
lvi_Tamanho 	  = lenA(lvs_Motivo)

If IsNull(lvs_Motivo) Or lvs_Motivo = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o motivo do Descancelamento.")
	dw_1.Event ue_Pos(1,"de_motivo")
	Return -1	
End If
 
//If lvi_Tamanho < 15 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O motivo do Descancelamento deve conter pelo menos 15 caracteres.")
//	dw_1.Event ue_Pos(1,"de_motivo")
//	Return -1
//End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma o descancelamento do pedido '" + String(ivl_Pedido) + "' ?", Question!, YesNo!, 2) = 2 Then Return

If ls_Sit_Anterior = 'R' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pedido voltar$$HEX1$$e100$$ENDHEX$$ para a situa$$HEX2$$e700e300$$ENDHEX$$o [RASCUNHO].~r~rQuando o pedido foi cancelado pelo processo autom$$HEX1$$e100$$ENDHEX$$tico estava como [RASCUNHO].", Exclamation!)
	ls_Sit_Nova = 'R'
Else
	ls_Sit_Nova = 'C'
End If

SetPointer(HourGlass!)

Update pedido_central
Set id_situacao         					 = :ls_Sit_Nova,
	dh_cancelamento					 = null,
	nr_matricula_cancelamento 	 = null,
	nr_matricula_descancelamento =:lvs_Responsavel, 
	dh_descancelamento 				 = getDate(),
	de_motivo_descancelamento 	 =:lvs_Motivo	
Where nr_pedido 						 =:ivl_Pedido
Using SqlCa;


If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Descancelamento do Pedido")
Else
	SqlCa.of_Commit()	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pedido '" + String(ivl_Pedido) + "' foi descancelado com sucesso.", Information!)
End If

SetPointer(Arrow!)

Close(Parent)


end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge147_descancelamento_pedido
integer x = 1742
integer y = 304
string text = "Fechar"
end type

event cb_cancelar::clicked;//OverRide

Close(Parent)
end event

