HA$PBExportHeader$w_ge226_importa_pedido.srw
forward
global type w_ge226_importa_pedido from dc_w_response_ok_cancela
end type
end forward

global type w_ge226_importa_pedido from dc_w_response_ok_cancela
integer width = 1285
integer height = 704
string title = "GE226 - Importa Pedido"
end type
global w_ge226_importa_pedido w_ge226_importa_pedido

on w_ge226_importa_pedido.create
call super::create
end on

on w_ge226_importa_pedido.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;// exclui o item TODAS
DataWindowChild ldw_Child
dw_1.GetChild("id_rede", ldw_Child)
ldw_Child.deleterow( 1 ) 
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge226_importa_pedido
integer y = 60
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge226_importa_pedido
integer width = 1230
integer height = 464
string facename = "Verdana"
string text = "Importa Pedido eCommerce"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge226_importa_pedido
integer y = 60
integer width = 1184
integer height = 380
string dataobject = "dw_ge226_importa_pedido"
end type

event dw_1::losefocus;call super::losefocus;String ls_Cep

This.AcceptText( )

ls_Cep = This.Object.Nr_Cep[ 1 ]

If Trim( ls_Cep ) = "" Then
	SetNull( ls_Cep )
	This.Object.Nr_Cep[ 1 ] = ls_Cep
End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge226_importa_pedido
integer x = 32
integer y = 500
integer width = 590
string text = "&Confirmar [ENTER]"
end type

event cb_ok::clicked;call super::clicked;Integer li_Resposta

Long ll_Pedido, ll_Nulo

String ls_Nulo
String ls_Cep_Inconsistente
String ls_Cep
String ls_Rede

// DESENV - Quando n$$HEX1$$e300$$ENDHEX$$o houver etiqueta do correio no pedido. Alterar ds_ge226_lista_status_pedido comentando os filtros e uo_ecommerce_vannon.of_importa_status_pedidos( )
//gvo_eCommerce_Vannon.of_importa_status_pedidos()
//SqlCa.of_Commit( )
//
//gvo_eCommerce_Vannon.of_SigepWeb( )
//MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Desenvolvimento (Sigep).", Exclamation! )
//Return

dw_1.AcceptText()

ll_Pedido					= dw_1.Object.nr_Pedido				[1]
ls_Cep_Inconsistente	= dw_1.Object.id_Cep_Inconsistente	[1]
ls_Cep					= dw_1.Object.nr_Cep					[1]
ls_Rede					= dw_1.Object.id_rede					[1]

SetNull( ll_Nulo )
SetNull( ls_Nulo )

If ls_Rede = 'TD' Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "informe uma rede ecommerce para importar o pedido.", Exclamation! )
	dw_1.Event ue_Pos( 1, "id_rede" )
	Return
End If

If  ( IsNull(ll_Pedido) ) Or ( LenA( String( ll_Pedido ) ) <> 9 ) Or ( ( LeftA( String( ll_Pedido ), 1 ) <> '1' ) AND ( LeftA( String( ll_Pedido ), 1 ) <> '4' )  AND ( LeftA( String( ll_Pedido ), 1 ) <> '2' ) AND ( LeftA( String( ll_Pedido ), 1 ) <> '3' )) then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o n$$HEX1$$fa00$$ENDHEX$$mero do pedido corretamente.", Exclamation! )
	dw_1.Event ue_Pos( 1, "nr_pedido" )
	Return
End If

If ls_Cep_Inconsistente = 'S' Then
	If IsNull( ls_Cep ) Or LenA( Trim( ls_Cep ) ) <> 8 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o n$$HEX1$$fa00$$ENDHEX$$mero do CEP corretamente (Formato: #####-###).", Exclamation! )
		dw_1.Event ue_Pos( 1, "nr_cep" )		
		Return
	End If
	
	li_Resposta = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a importa$$HEX2$$e700e300$$ENDHEX$$o do pedido '"  + String(ll_Pedido) + "' no CEP de entrega '" + ls_Cep + "' ?", Question!, YesNo!, 2)
Else
	If Not IsNull( ls_Cep ) Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para importar um pedido com substitui$$HEX2$$e700e300$$ENDHEX$$o do CEP, marque a op$$HEX2$$e700e300$$ENDHEX$$o [CEP inconsistente].", Exclamation! )
		dw_1.Event ue_Pos( 1, "nr_cep" )
		Return
	End If
	
	li_Resposta = MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a importa$$HEX2$$e700e300$$ENDHEX$$o do pedido '"  + String(ll_Pedido)+ "' ?", Question!, YesNo!, 2 )
End If

If li_Resposta = 1 Then

	Try
		uo_ecommerce_vannon lo_Ecommerce
		lo_Ecommerce = Create uo_ecommerce_vannon
			
		If lo_Ecommerce.of_Importa_Pedidos( ll_Pedido, ls_CEP, ls_Rede ) Then
			dw_1.Object.nr_pedido					[1] = ll_Nulo
			dw_1.Object.id_Cep_Inconsistente		[1] = 'N'
			dw_1.Object.nr_Cep						[1] = ls_Nulo
			dw_1.Object.id_rede						[1] = 'FA'
			dw_1.Event ue_Pos( 1, "nr_pedido" )
		End If	
	Finally
		If IsValid( lo_Ecommerce ) Then Destroy lo_Ecommerce
	End Try
End If


end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge226_importa_pedido
integer x = 791
integer y = 500
integer width = 462
string text = "Cancelar [ESC]"
end type

