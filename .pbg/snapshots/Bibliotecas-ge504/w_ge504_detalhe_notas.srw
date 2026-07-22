HA$PBExportHeader$w_ge504_detalhe_notas.srw
forward
global type w_ge504_detalhe_notas from dc_w_response
end type
type gb_1 from groupbox within w_ge504_detalhe_notas
end type
type dw_1 from dc_uo_dw_base within w_ge504_detalhe_notas
end type
type cb_ok from commandbutton within w_ge504_detalhe_notas
end type
type cb_cancelar from commandbutton within w_ge504_detalhe_notas
end type
end forward

global type w_ge504_detalhe_notas from dc_w_response
integer x = 567
integer y = 424
integer width = 3182
integer height = 780
string title = "GE504 - Lista de Notas"
boolean controlmenu = false
gb_1 gb_1
dw_1 dw_1
cb_ok cb_ok
cb_cancelar cb_cancelar
end type
global w_ge504_detalhe_notas w_ge504_detalhe_notas

type variables
boolean ivb_pesquisa_direta = false

Long il_pedido
end variables

on w_ge504_detalhe_notas.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.cb_cancelar
end on

on w_ge504_detalhe_notas.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.cb_cancelar)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()
dw_1.SetFocus()

dw_1.Event ue_Retrieve()

If dw_1.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ NFs para serem visualizadas nesse pedido.")
	CloseWithReturn(w_ge504_detalhe_notas, il_pedido)
End If
end event

event ue_preopen;call super::ue_preopen;il_pedido = Message.doubleparm
end event

type pb_help from dc_w_response`pb_help within w_ge504_detalhe_notas
integer x = 101
integer y = 572
end type

type gb_1 from groupbox within w_ge504_detalhe_notas
integer x = 27
integer y = 20
integer width = 3122
integer height = 536
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Notas"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge504_detalhe_notas
integer x = 50
integer y = 84
integer width = 3077
integer height = 448
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge504_lista_notas"
boolean vscrollbar = true
end type

event ue_recuperar;//Override

Return This.Retrieve(il_Pedido)
end event

event clicked;call super::clicked;Integer lvi_Retorno

If dwo.Name = "cb_copiar" Then
	
Parent.dw_1.Event ue_Pos(row, 'de_chave_acesso')
Parent.dw_1.SelectText(1, 44)

lvi_Retorno = Parent.dw_1.Copy()

Choose Case lvi_Retorno
	Case -1  // Vazio
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o foi selecionada para a c$$HEX1$$f300$$ENDHEX$$pia.")
	Case -2  // Erro na c$$HEX1$$f300$$ENDHEX$$pia
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na c$$HEX1$$f300$$ENDHEX$$pia.")
	Case -9  // Erro na c$$HEX1$$f300$$ENDHEX$$pia
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na c$$HEX1$$f300$$ENDHEX$$pia.")
End Choose

End If
end event

type cb_ok from commandbutton within w_ge504_detalhe_notas
integer x = 2825
integer y = 576
integer width = 311
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&OK"
boolean default = true
end type

event getfocus;This.Weight = 700
This.Default = True
end event

event losefocus;This.Weight = 400
This.Default = False
end event

event clicked;cb_Cancelar.Event Clicked()
end event

type cb_cancelar from commandbutton within w_ge504_detalhe_notas
boolean visible = false
integer x = 2418
integer y = 576
integer width = 311
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;String lvs_Retorno

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

event getfocus;This.Weight = 700
This.Default = True
end event

event losefocus;This.Weight = 400
This.Default = False
end event

