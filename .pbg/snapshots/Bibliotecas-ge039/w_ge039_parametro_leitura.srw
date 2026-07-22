HA$PBExportHeader$w_ge039_parametro_leitura.srw
forward
global type w_ge039_parametro_leitura from window
end type
type cb_cancelar from commandbutton within w_ge039_parametro_leitura
end type
type cb_ok from commandbutton within w_ge039_parametro_leitura
end type
type dw_1 from datawindow within w_ge039_parametro_leitura
end type
type gb_1 from groupbox within w_ge039_parametro_leitura
end type
end forward

global type w_ge039_parametro_leitura from window
integer x = 1134
integer y = 952
integer width = 1335
integer height = 488
boolean titlebar = true
string title = "GE039 - Leitura da mem$$HEX1$$f300$$ENDHEX$$ria Fiscal"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 80269524
boolean center = true
cb_cancelar cb_cancelar
cb_ok cb_ok
dw_1 dw_1
gb_1 gb_1
end type
global w_ge039_parametro_leitura w_ge039_parametro_leitura

type variables

end variables

on w_ge039_parametro_leitura.create
this.cb_cancelar=create cb_cancelar
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.cb_cancelar,&
this.cb_ok,&
this.dw_1,&
this.gb_1}
end on

on w_ge039_parametro_leitura.destroy
destroy(this.cb_cancelar)
destroy(this.cb_ok)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;dw_1.SetReDraw(False)

dw_1.InsertRow(0)
dw_1.Object.dt_inicio[1] = Today()
dw_1.Object.dt_final [1] = Today()

dw_1.SetReDraw(True)

dw_1.SetFocus()
end event

type cb_cancelar from commandbutton within w_ge039_parametro_leitura
integer x = 517
integer y = 276
integer width = 370
integer height = 96
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_ok from commandbutton within w_ge039_parametro_leitura
integer x = 905
integer y = 276
integer width = 370
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Ok"
end type

event clicked;STRING lvs_Data_Inicio, &
       lvs_Data_Final

dw_1.AcceptText()

lvs_Data_Inicio  = String(dw_1.Object.dt_inicio	[1],'dd/mm/yy')
lvs_Data_Final = String(dw_1.Object.dt_final    [1],'dd/mm/yy')




end event

type dw_1 from datawindow within w_ge039_parametro_leitura
integer x = 46
integer y = 52
integer width = 1207
integer height = 176
string dataobject = "dw_selecao_leitura_memoria_fiscal"
boolean border = false
boolean livescroll = true
end type

type gb_1 from groupbox within w_ge039_parametro_leitura
integer x = 23
integer y = 8
integer width = 1257
integer height = 248
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

