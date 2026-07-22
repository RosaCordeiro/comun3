HA$PBExportHeader$w_ge604_response_detalhes_remessa.srw
forward
global type w_ge604_response_detalhes_remessa from dc_w_response_ok_cancela
end type
type dw_2 from datawindow within w_ge604_response_detalhes_remessa
end type
type gb_2 from groupbox within w_ge604_response_detalhes_remessa
end type
end forward

global type w_ge604_response_detalhes_remessa from dc_w_response_ok_cancela
integer width = 5079
integer height = 2020
dw_2 dw_2
gb_2 gb_2
end type
global w_ge604_response_detalhes_remessa w_ge604_response_detalhes_remessa

type variables
String is_Parametro, is_Tipo, is_pedido, is_pedido_sap
end variables

forward prototypes
public subroutine wf_carrega_dados ()
end prototypes

public subroutine wf_carrega_dados ();
end subroutine

on w_ge604_response_detalhes_remessa.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.gb_2
end on

on w_ge604_response_detalhes_remessa.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.gb_2)
end on

event open;call super::open;is_Parametro = Message.stringparm

//is_Tipo = Left(is_Parametro, 3)

is_pedido = Mid(is_Parametro, (Pos(is_Parametro, ';')+1), ((LastPos(is_Parametro, ';')-1) - Pos(is_Parametro, ';')) )

is_pedido_sap = Mid(is_Parametro, (LastPos(is_Parametro, ';')+1) )

Dw_1.SetTransObject( SQLCA )
Dw_2.SetTransObject( SQLCA )
end event

event ue_postopen;call super::ue_postopen;String ls_De_Tipo

This.Title = 'GE604 - Detalhes Remessa - N$$HEX1$$ba00$$ENDHEX$$ Ped.: ' + String(is_pedido) + ' | Ped. SAP: ' + String(is_pedido_sap)

If (Not IsNull(is_pedido)) and (Trim(is_pedido)<>'') Then
	Dw_1.Of_appendwhere("rs.nr_pedido = "+is_pedido)
End If

If (Not IsNull(is_pedido_sap)) and (Trim(is_pedido_sap)<>'') Then
	Dw_1.Of_appendwhere("rs.nr_pedido_sap = '"+is_pedido_sap+"'")
End If

Open(w_aguarde)

Dw_1.Retrieve()

Close(w_aguarde)




end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge604_response_detalhes_remessa
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge604_response_detalhes_remessa
integer y = 12
integer width = 5024
integer height = 996
string text = "Detalhes das Remessas com Status IMPORTADO"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge604_response_detalhes_remessa
integer y = 76
integer width = 4965
integer height = 896
string dataobject = "dw_ge604_compras_detalhes_remessa"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::rowfocuschanged;call super::rowfocuschanged;Long		ll_linhas
String	ls_nr_recebimento

If currentrow > 0 then	
	ls_nr_recebimento = This.Object.nr_recebimento [currentrow]
	
	ll_linhas = Dw_2.Retrieve (ls_nr_recebimento)
	
	If ll_linhas < 0 Then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na leitura dos erros de importa$$HEX2$$e700e300$$ENDHEX$$o do recebimento ' + ls_nr_recebimento + '. SQLErrText: ' + SQLCA.SQLErrText, Exclamation!)
	End If
End if
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge604_response_detalhes_remessa
integer x = 4736
integer y = 1812
string text = "&Fechar"
boolean cancel = true
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Close(Parent)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge604_response_detalhes_remessa
boolean visible = false
integer x = 3890
integer y = 1804
boolean enabled = false
string text = "Cancelar"
end type

type dw_2 from datawindow within w_ge604_response_detalhes_remessa
integer x = 55
integer y = 1096
integer width = 4965
integer height = 644
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ge604_compras_erros_remessa"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type gb_2 from groupbox within w_ge604_response_detalhes_remessa
integer x = 23
integer y = 1032
integer width = 5024
integer height = 748
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Erros no Recebimento"
end type

