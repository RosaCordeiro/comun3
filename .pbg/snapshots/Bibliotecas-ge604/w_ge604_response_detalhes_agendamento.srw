HA$PBExportHeader$w_ge604_response_detalhes_agendamento.srw
forward
global type w_ge604_response_detalhes_agendamento from dc_w_response_ok_cancela
end type
end forward

global type w_ge604_response_detalhes_agendamento from dc_w_response_ok_cancela
integer width = 5454
integer height = 1384
end type
global w_ge604_response_detalhes_agendamento w_ge604_response_detalhes_agendamento

type variables
String is_Parametro, is_Tipo, is_pedido, is_pedido_sap
end variables

forward prototypes
public subroutine wf_carrega_dados ()
end prototypes

public subroutine wf_carrega_dados ();
end subroutine

on w_ge604_response_detalhes_agendamento.create
call super::create
end on

on w_ge604_response_detalhes_agendamento.destroy
call super::destroy
end on

event open;call super::open;is_Parametro = Message.stringparm

//is_Tipo = Left(is_Parametro, 3)

is_pedido = Mid(is_Parametro, (Pos(is_Parametro, ';')+1), ((LastPos(is_Parametro, ';')-1) - Pos(is_Parametro, ';')) )

is_pedido_sap = Mid(is_Parametro, (LastPos(is_Parametro, ';')+1) )





end event

event ue_postopen;call super::ue_postopen;String ls_Where, ls_SQL

This.Title = 'GE604 - Detalhes Agendamento - N$$HEX1$$ba00$$ENDHEX$$ Ped.: ' + String(is_pedido) + ' | Ped. SAP: ' + String(is_pedido_sap)

If (Not IsNull(is_pedido)) and (Trim(is_pedido)<>'') Then
	ls_Where = 'AG.nr_pedido_central = ' + is_pedido
End If

ls_SQL  = Dw_1.Object.DataWindow.Table.Select
ls_SQL += " WHERE " + ls_Where
Dw_1.of_changesql (ls_SQL)

Open(w_aguarde)
Dw_1.Retrieve()
Close(w_aguarde)


end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge604_response_detalhes_agendamento
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge604_response_detalhes_agendamento
integer width = 5399
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge604_response_detalhes_agendamento
integer width = 5339
string dataobject = "dw_ge604_compras_detalhes_agendamento"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge604_response_detalhes_agendamento
integer x = 5111
string text = "&Fechar"
boolean cancel = true
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Close(Parent)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge604_response_detalhes_agendamento
boolean visible = false
boolean enabled = false
string text = "Cancelar"
end type

