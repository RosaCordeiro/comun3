HA$PBExportHeader$w_ge331_motivo_liberacao.srw
forward
global type w_ge331_motivo_liberacao from dc_w_response
end type
type cb_1 from commandbutton within w_ge331_motivo_liberacao
end type
type cb_ok from commandbutton within w_ge331_motivo_liberacao
end type
type dw_1 from dc_uo_dw_base within w_ge331_motivo_liberacao
end type
end forward

global type w_ge331_motivo_liberacao from dc_w_response
integer width = 1431
integer height = 604
string title = "GE331 - Motivo da Libera$$HEX2$$e700e300$$ENDHEX$$o para o Agendamento"
boolean controlmenu = false
cb_1 cb_1
cb_ok cb_ok
dw_1 dw_1
end type
global w_ge331_motivo_liberacao w_ge331_motivo_liberacao

on w_ge331_motivo_liberacao.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_ok=create cb_ok
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_1
end on

on w_ge331_motivo_liberacao.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()
end event

event open;call super::open;String ls_Parametro

ls_Parametro = Message.StringParm	

If ls_Parametro = "CANCELAR" Then
	This.Title = "GE331 - Motivo de Cancelamento para o Agendamento"
	dw_1.Object.de_observacao_t.Text = "Informe o motivo do cancelamento do agendamento"
End If
end event

type pb_help from dc_w_response`pb_help within w_ge331_motivo_liberacao
integer y = 84
end type

type cb_1 from commandbutton within w_ge331_motivo_liberacao
integer x = 23
integer y = 404
integer width = 402
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar"
end type

event clicked;String ls_Retorno

SetNull(ls_Retorno)

CloseWithReturn(Parent, ls_Retorno )
end event

type cb_ok from commandbutton within w_ge331_motivo_liberacao
integer x = 992
integer y = 404
integer width = 402
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Confirmar"
end type

event clicked;String ls_Texto

dw_1.AcceptText()

ls_Texto = Trim( dw_1.Object.de_motivo[1] )

If ls_Texto = "" Or IsNull( ls_Texto ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o motivo.")
	dw_1.Event ue_Pos(1, "de_motivo")
	Return -1	
End If

If LenA( ls_Texto ) < 15 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O motivo informado deve conter pelo menos 15 caract$$HEX1$$e900$$ENDHEX$$res.")
	dw_1.Event ue_Pos(1, "de_motivo")
	Return -1
End If

//If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja aplicar o motivo a todos os produtos com a $$HEX1$$1820$$ENDHEX$$situa$$HEX2$$e700e300$$ENDHEX$$o$$HEX1$$1920$$ENDHEX$$ alterada?", Question!, YesNo!, 1 ) = 2 Then
//	dw_1.Event ue_Pos(1, "de_motivo")
//	Return -1
//End If

CloseWithReturn( Parent, ls_Texto )
end event

type dw_1 from dc_uo_dw_base within w_ge331_motivo_liberacao
integer x = 14
integer y = 20
integer width = 1385
integer height = 400
string dataobject = "dw_ge331_motivo_liberacao"
end type

