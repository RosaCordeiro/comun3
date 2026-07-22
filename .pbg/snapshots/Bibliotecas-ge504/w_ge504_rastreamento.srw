HA$PBExportHeader$w_ge504_rastreamento.srw
forward
global type w_ge504_rastreamento from dc_w_response_ok_cancela
end type
type st_1 from statictext within w_ge504_rastreamento
end type
end forward

global type w_ge504_rastreamento from dc_w_response_ok_cancela
integer width = 2711
integer height = 1644
string title = "GE504 - Rastreamento de Pedido"
st_1 st_1
end type
global w_ge504_rastreamento w_ge504_rastreamento

type variables
Long il_Pedido
end variables

on w_ge504_rastreamento.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_ge504_rastreamento.destroy
call super::destroy
destroy(this.st_1)
end on

event open;call super::open;il_pedido = Message.DoubleParm

st_1.Text = "Pedido: "+String(il_pedido)

dw_1.Event ue_Retrieve()

end event

event ue_postopen;//OverRide

ivo_dbError = Create dc_uo_dbError

//Registra Tela para Controle de Inatividade
If (Not(ivb_permite_fechar)) and (IsValid(gvo_Aplicacao)) Then
	If gvo_Aplicacao.ivb_Usa_Timer_Out Then
		gvo_Aplicacao.of_insere_tela(This.Title)
	End If
End If

// Insere a tela response do array de responses abertas
// Necess$$HEX1$$e100$$ENDHEX$$rio a armazenagem para fechar as telas por inatividade
If IsValid(gvo_Aplicacao) Then
	If gvo_Aplicacao.ivb_usa_timer_out Then
		If This.WindowType = Response! Then
			gvo_Aplicacao.of_insere_response(This)
		End if
	End If
End If

//Verifica se no grupo de acesso a tela est$$HEX1$$e100$$ENDHEX$$ sem permiss$$HEX1$$e300$$ENDHEX$$o de altera$$HEX2$$e700e300$$ENDHEX$$o
// e seta como somente leitura os campos
If This.WindowType <> Response! Then
	wf_set_somente_consulta()
End If	

dw_1.SetFocus()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge504_rastreamento
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge504_rastreamento
integer y = 0
integer width = 2647
integer height = 1432
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge504_rastreamento
integer y = 128
integer width = 2592
integer height = 1284
string dataobject = "dw_ge504_rastreamento"
boolean vscrollbar = true
end type

event dw_1::ue_preretrieve;call super::ue_preretrieve;This.of_AppendWhere( "a.nr_pedido_ecommerce = " + String( il_Pedido ) )

Return AncestorReturnValue
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge504_rastreamento
boolean visible = false
integer x = 1984
integer y = 1452
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge504_rastreamento
integer x = 2318
integer y = 1452
string text = "&Sair"
end type

type st_1 from statictext within w_ge504_rastreamento
integer x = 73
integer y = 52
integer width = 1147
integer height = 92
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Pedido: 0"
boolean focusrectangle = false
end type

