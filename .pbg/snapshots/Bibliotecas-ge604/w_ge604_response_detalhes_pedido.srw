HA$PBExportHeader$w_ge604_response_detalhes_pedido.srw
forward
global type w_ge604_response_detalhes_pedido from dc_w_response_ok_cancela
end type
end forward

global type w_ge604_response_detalhes_pedido from dc_w_response_ok_cancela
integer width = 2651
integer height = 1364
end type
global w_ge604_response_detalhes_pedido w_ge604_response_detalhes_pedido

type variables
String is_Parametro, is_Tipo, is_pedido, is_pedido_sap
end variables

forward prototypes
public subroutine wf_carrega_dados ()
end prototypes

public subroutine wf_carrega_dados ();
end subroutine

on w_ge604_response_detalhes_pedido.create
call super::create
end on

on w_ge604_response_detalhes_pedido.destroy
call super::destroy
end on

event open;call super::open;is_Parametro = Message.stringparm

//is_Tipo = Left(is_Parametro, 3)

is_pedido = Mid(is_Parametro, (Pos(is_Parametro, ';')+1), ((LastPos(is_Parametro, ';')-1) - Pos(is_Parametro, ';')) )

is_pedido_sap = Mid(is_Parametro, (LastPos(is_Parametro, ';')+1) )





end event

event ue_postopen;call super::ue_postopen;String ls_De_Tipo
This.Title = 'GE604 - Detalhes Pedido - N$$HEX1$$ba00$$ENDHEX$$ Ped.: ' + String(is_pedido) + ' | Ped. SAP: ' + String(is_pedido_sap)

If Not IsNull(is_pedido) AND Trim(is_pedido) <> '' Then
	Dw_1.Of_appendwhere("pc.nr_pedido = "+is_pedido)
Else
	If Not IsNull (is_pedido_sap) then
		Dw_1.Of_appendwhere( "isap.de_chave_sap = '" + is_pedido_sap + "'")
	End if
End If

Open(w_aguarde)
Dw_1.Retrieve()
Close(w_aguarde)


end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge604_response_detalhes_pedido
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge604_response_detalhes_pedido
integer width = 2597
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge604_response_detalhes_pedido
integer width = 2537
string dataobject = "dw_ge604_compras_detalhes_pedido"
boolean hscrollbar = true
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge604_response_detalhes_pedido
integer x = 2309
integer y = 1156
string text = "&Fechar"
boolean cancel = true
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Close(Parent)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge604_response_detalhes_pedido
boolean visible = false
integer x = 1879
integer y = 1148
boolean enabled = false
string text = "Cancelar"
end type

