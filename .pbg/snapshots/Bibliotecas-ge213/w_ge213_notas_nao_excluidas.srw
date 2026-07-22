HA$PBExportHeader$w_ge213_notas_nao_excluidas.srw
forward
global type w_ge213_notas_nao_excluidas from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge213_notas_nao_excluidas
end type
type cb_1 from commandbutton within w_ge213_notas_nao_excluidas
end type
type gb_2 from groupbox within w_ge213_notas_nao_excluidas
end type
end forward

global type w_ge213_notas_nao_excluidas from dc_w_response_ok_cancela
integer width = 2574
integer height = 1544
string title = "GE213 - Notas n$$HEX1$$e300$$ENDHEX$$o Exclu$$HEX1$$ed00$$ENDHEX$$das"
dw_2 dw_2
cb_1 cb_1
gb_2 gb_2
end type
global w_ge213_notas_nao_excluidas w_ge213_notas_nao_excluidas

type variables
dc_uo_dw_base idw
end variables

on w_ge213_notas_nao_excluidas.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_1=create cb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.gb_2
end on

on w_ge213_notas_nao_excluidas.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.gb_2)
end on

event ue_postopen;call super::ue_postopen;idw = Create dc_uo_dw_base

idw = Message.PowerObjectParm

If idw.ShareData(dw_1) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Share Data.", StopSign!)
	Return
End If

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Se for necess$$HEX1$$e100$$ENDHEX$$rio, salve em uma planilha as notas que n$$HEX1$$e300$$ENDHEX$$o foram exclu$$HEX1$$ed00$$ENDHEX$$das, utilizando o bot$$HEX1$$e300$$ENDHEX$$o [Salvar .(XLS)].")
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge213_notas_nao_excluidas
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge213_notas_nao_excluidas
integer width = 2514
string text = "Lista"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge213_notas_nao_excluidas
integer width = 2455
string dataobject = "dw_ge213_lista_planilha"
end type

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()
This.ivb_Ordena_Colunas = True
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	dw_2.Object.De_Mensagem[1] = This.Object.De_Mensagem[CurrentRow]
End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge213_notas_nao_excluidas
integer x = 2231
integer y = 1356
end type

event cb_ok::clicked;call super::clicked;cb_Cancelar.Event Clicked()
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge213_notas_nao_excluidas
boolean visible = false
integer x = 1906
integer y = 1356
end type

type dw_2 from dc_uo_dw_base within w_ge213_notas_nao_excluidas
integer x = 41
integer y = 1208
integer width = 2482
integer height = 128
integer taborder = 20
string dataobject = "dw_ge213_mensagem"
end type

type cb_1 from commandbutton within w_ge213_notas_nao_excluidas
integer x = 18
integer y = 1356
integer width = 411
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Salvar .(XLS)"
end type

event clicked;dw_1.Event ue_SaveAs()
end event

type gb_2 from groupbox within w_ge213_notas_nao_excluidas
integer x = 18
integer y = 1140
integer width = 2523
integer height = 212
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Detalhe"
borderstyle borderstyle = styleraised!
end type

