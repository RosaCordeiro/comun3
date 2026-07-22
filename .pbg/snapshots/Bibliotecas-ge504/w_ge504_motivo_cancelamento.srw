HA$PBExportHeader$w_ge504_motivo_cancelamento.srw
forward
global type w_ge504_motivo_cancelamento from dc_w_response
end type
type cb_1 from commandbutton within w_ge504_motivo_cancelamento
end type
type cb_ok from commandbutton within w_ge504_motivo_cancelamento
end type
type dw_1 from dc_uo_dw_base within w_ge504_motivo_cancelamento
end type
end forward

global type w_ge504_motivo_cancelamento from dc_w_response
integer width = 1248
integer height = 768
string title = "GE504 - Motivo Cancelamento"
boolean controlmenu = false
cb_1 cb_1
cb_ok cb_ok
dw_1 dw_1
end type
global w_ge504_motivo_cancelamento w_ge504_motivo_cancelamento

on w_ge504_motivo_cancelamento.create
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

on w_ge504_motivo_cancelamento.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()
end event

type pb_help from dc_w_response`pb_help within w_ge504_motivo_cancelamento
integer y = 84
end type

type cb_1 from commandbutton within w_ge504_motivo_cancelamento
integer x = 23
integer y = 580
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

type cb_ok from commandbutton within w_ge504_motivo_cancelamento
integer x = 827
integer y = 580
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

event clicked;String ls_Motivo, ls_Motivo_Extenso

dw_1.AcceptText()

ls_Motivo = Trim(dw_1.Object.de_motivo[1] )
ls_Motivo_Extenso = Trim(dw_1.Object.de_motivo_extenso[1] )

If ls_Motivo = "" Or IsNull( ls_Motivo ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o motivo.")
	dw_1.Event ue_Pos(1, "de_motivo")
	Return -1	
End If

If ls_Motivo = 'OUTRO' Then
	If LenA( ls_Motivo_Extenso ) < 5 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O motivo informado deve conter pelo menos 5 caracteres.")
		dw_1.Event ue_Pos(1, "de_motivo_extenso")
		Return -1
	End If
	ls_Motivo = ls_Motivo_Extenso
End If

//If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja aplicar o motivo a todos os produtos com a $$HEX1$$1820$$ENDHEX$$situa$$HEX2$$e700e300$$ENDHEX$$o$$HEX1$$1920$$ENDHEX$$ alterada?", Question!, YesNo!, 1 ) = 2 Then
//	dw_1.Event ue_Pos(1, "de_motivo")
//	Return -1
//End If

CloseWithReturn( Parent, ls_Motivo )
end event

type dw_1 from dc_uo_dw_base within w_ge504_motivo_cancelamento
integer x = 14
integer y = 20
integer width = 1216
integer height = 528
string dataobject = "dw_ge504_motivo_cancelamento"
end type

event itemchanged;call super::itemchanged;This.accepttext()

If dwo.Name = "de_motivo" Then	
	If Data = 'OUTRO' Then
		This.Object.de_motivo_extenso.Visible = 1
		Return 0
	Else 
		This.Object.de_motivo_extenso.Visible = 0
		This.Object.de_motivo_extenso[1] = ''
		Return 0
	End If			
End if

end event

