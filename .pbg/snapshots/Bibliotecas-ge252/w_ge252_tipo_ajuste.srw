HA$PBExportHeader$w_ge252_tipo_ajuste.srw
forward
global type w_ge252_tipo_ajuste from dc_w_base
end type
type cb_2 from commandbutton within w_ge252_tipo_ajuste
end type
type cb_1 from commandbutton within w_ge252_tipo_ajuste
end type
type dw_1 from dc_uo_dw_base within w_ge252_tipo_ajuste
end type
type gb_1 from groupbox within w_ge252_tipo_ajuste
end type
end forward

global type w_ge252_tipo_ajuste from dc_w_base
integer width = 2153
integer height = 964
string title = "GE252 - Lote / Tipo Ajuste"
boolean controlmenu = false
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge252_tipo_ajuste w_ge252_tipo_ajuste

event open;call super::open;Long 	ll_Produto,&
		ll_Linhas
st_parametros_tipo_ajuste lst_Parametro	

ll_Produto = Message.DoubleParm	

ll_Linhas = dw_1.Retrieve(ll_Produto)

If ll_Linhas = 1 Then
	lst_Parametro.endereco 			= dw_1.Object.cd_endereco[dw_1.getRow()]
	lst_Parametro.lote 				= dw_1.Object.nr_lote[dw_1.getRow()]
	lst_Parametro.validade			= dw_1.Object.dh_validade[dw_1.getRow()]
	lst_Parametro.qt_saldo			= dw_1.Object.qt_saldo[dw_1.getRow()]
	lst_Parametro.id_confirmado	= "S"
	CloseWithReturn(This, lst_Parametro)
ElseIf ll_Linhas < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o produto em nenhum endere$$HEX1$$e700$$ENDHEX$$o do segregado." )
	lst_Parametro.id_confirmado	= "N"
	CloseWithReturn(This, lst_Parametro)
End If
end event

on w_ge252_tipo_ajuste.create
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

on w_ge252_tipo_ajuste.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

type cb_2 from commandbutton within w_ge252_tipo_ajuste
integer x = 1367
integer y = 780
integer width = 334
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Selecionar"
end type

event clicked;st_parametros_tipo_ajuste lst_Parametro

lst_Parametro.endereco 			= dw_1.Object.cd_endereco[dw_1.getRow()]
lst_Parametro.lote 				= dw_1.Object.nr_lote[dw_1.getRow()]
lst_Parametro.validade			= dw_1.Object.dh_validade[dw_1.getRow()]
lst_Parametro.qt_saldo			= dw_1.Object.qt_saldo[dw_1.getRow()]
lst_Parametro.id_confirmado	= "S"

CloseWithReturn(Parent, lst_Parametro)
end event

type cb_1 from commandbutton within w_ge252_tipo_ajuste
integer x = 1787
integer y = 780
integer width = 334
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar"
end type

event clicked;st_parametros_tipo_ajuste lst_Parametro

lst_Parametro.id_confirmado	= "N"
CloseWithReturn(Parent, lst_Parametro)
end event

type dw_1 from dc_uo_dw_base within w_ge252_tipo_ajuste
integer x = 55
integer y = 56
integer width = 2043
integer height = 676
string dataobject = "dw_ge252_tipo_ajuste"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection() 
end event

type gb_1 from groupbox within w_ge252_tipo_ajuste
integer x = 18
integer width = 2098
integer height = 768
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lotes"
end type

