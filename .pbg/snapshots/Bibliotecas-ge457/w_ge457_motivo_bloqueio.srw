HA$PBExportHeader$w_ge457_motivo_bloqueio.srw
forward
global type w_ge457_motivo_bloqueio from dc_w_response
end type
type cb_1 from commandbutton within w_ge457_motivo_bloqueio
end type
type cb_ok from commandbutton within w_ge457_motivo_bloqueio
end type
type dw_1 from dc_uo_dw_base within w_ge457_motivo_bloqueio
end type
end forward

global type w_ge457_motivo_bloqueio from dc_w_response
integer width = 1449
integer height = 668
string title = "GE457 - Motivo Bloqueio"
boolean controlmenu = false
cb_1 cb_1
cb_ok cb_ok
dw_1 dw_1
end type
global w_ge457_motivo_bloqueio w_ge457_motivo_bloqueio

type variables
String ivs_nova_situacao


end variables

on w_ge457_motivo_bloqueio.create
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

on w_ge457_motivo_bloqueio.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()
end event

type pb_help from dc_w_response`pb_help within w_ge457_motivo_bloqueio
integer x = 32
integer y = 228
end type

type cb_1 from commandbutton within w_ge457_motivo_bloqueio
integer x = 23
integer y = 464
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

type cb_ok from commandbutton within w_ge457_motivo_bloqueio
integer x = 992
integer y = 464
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
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o motivo de bloqueio.")
	dw_1.Event ue_Pos(1, "de_motivo")
	Return -1	
End If

If LenA( ls_Texto ) < 15 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O motivo informado deve conter pelo menos 15 caract$$HEX1$$e900$$ENDHEX$$res.")
	dw_1.Event ue_Pos(1, "de_motivo")
	Return -1
End If

CloseWithReturn( Parent, ls_Texto)
end event

type dw_1 from dc_uo_dw_base within w_ge457_motivo_bloqueio
integer x = 14
integer y = 16
integer width = 1390
integer height = 468
string dataobject = "dw_ge457_motivo_bloqueio"
end type

