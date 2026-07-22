HA$PBExportHeader$w_ge252_localiza_produto_validade.srw
forward
global type w_ge252_localiza_produto_validade from dc_w_base
end type
type cb_2 from commandbutton within w_ge252_localiza_produto_validade
end type
type cb_1 from commandbutton within w_ge252_localiza_produto_validade
end type
type dw_1 from dc_uo_dw_base within w_ge252_localiza_produto_validade
end type
type gb_1 from groupbox within w_ge252_localiza_produto_validade
end type
end forward

global type w_ge252_localiza_produto_validade from dc_w_base
string tag = "w_ge252_localiza_produto_validade"
integer width = 3465
integer height = 1200
string title = "GE252 - Agrupamentos Produtos Lote Validade"
boolean controlmenu = false
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge252_localiza_produto_validade w_ge252_localiza_produto_validade

type variables

end variables

on w_ge252_localiza_produto_validade.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_ge252_localiza_produto_validade.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;call super::open;dc_uo_dw_base ldw
ldw = Create dc_uo_dw_base

ldw = Message.PowerObjectParm

If ldw.ShareData(dw_1) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no ShareData da dw_1.", StopSign!)
	Return -1
End If
end event

type cb_2 from commandbutton within w_ge252_localiza_produto_validade
integer x = 2725
integer y = 988
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Processar"
end type

event clicked;If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Todos os agrupamentos listados ser$$HEX1$$e300$$ENDHEX$$o atualizados com validade informada.~r~rDeseja continuar?", Question!, YesNo!, 2) = 2 Then Return -1

CloseWithReturn(Parent, "S")
end event

type cb_1 from commandbutton within w_ge252_localiza_produto_validade
integer x = 3131
integer y = 988
integer width = 288
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar"
end type

event clicked;CloseWithReturn(Parent, "N")
end event

type dw_1 from dc_uo_dw_base within w_ge252_localiza_produto_validade
integer x = 50
integer y = 76
integer width = 3301
integer height = 864
integer taborder = 20
string dataobject = "ds_ge252_localiza_prd_lotes_validade"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()

ivb_ordena_colunas = True
end event

type gb_1 from groupbox within w_ge252_localiza_produto_validade
integer x = 27
integer y = 16
integer width = 3383
integer height = 960
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Agrupamentos"
end type

