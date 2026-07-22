HA$PBExportHeader$w_ge032_cheque_pendente_cliente.srw
forward
global type w_ge032_cheque_pendente_cliente from window
end type
type dw_1 from dc_uo_dw_base within w_ge032_cheque_pendente_cliente
end type
type st_msg from statictext within w_ge032_cheque_pendente_cliente
end type
type cb_voltar from commandbutton within w_ge032_cheque_pendente_cliente
end type
type gb_1 from groupbox within w_ge032_cheque_pendente_cliente
end type
end forward

global type w_ge032_cheque_pendente_cliente from window
integer x = 283
integer y = 628
integer width = 3109
integer height = 1136
boolean titlebar = true
string title = "GE032 - Cheques Pendentes"
long backcolor = 79741120
dw_1 dw_1
st_msg st_msg
cb_voltar cb_voltar
gb_1 gb_1
end type
global w_ge032_cheque_pendente_cliente w_ge032_cheque_pendente_cliente

on w_ge032_cheque_pendente_cliente.create
this.dw_1=create dw_1
this.st_msg=create st_msg
this.cb_voltar=create cb_voltar
this.gb_1=create gb_1
this.Control[]={this.dw_1,&
this.st_msg,&
this.cb_voltar,&
this.gb_1}
end on

on w_ge032_cheque_pendente_cliente.destroy
destroy(this.dw_1)
destroy(this.st_msg)
destroy(this.cb_voltar)
destroy(this.gb_1)
end on

event open;String   lvs_cpf_cgc

Date     lvdt_Movimento

lvs_cpf_cgc    = Message.StringParm

lvdt_Movimento = Date(gvo_Parametro.of_dh_Movimentacao())
lvdt_Movimento = RelativeDate(lvdt_Movimento, -10)

dw_1.Retrieve(lvs_cpf_cgc,lvdt_Movimento)

If dw_1.RowCount() = 0 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","At$$HEX1$$e900$$ENDHEX$$ a data atual n$$HEX1$$e300$$ENDHEX$$o existem registros de cheques pendentes.")
	Close(This)
End If	
	
end event

type dw_1 from dc_uo_dw_base within w_ge032_cheque_pendente_cliente
integer x = 59
integer y = 72
integer width = 2999
integer height = 812
string dataobject = "dw_ge032_cheque_pendente_cliente"
boolean ivb_ordena_colunas = true
end type

type st_msg from statictext within w_ge032_cheque_pendente_cliente
integer x = 32
integer y = 936
integer width = 1801
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type cb_voltar from commandbutton within w_ge032_cheque_pendente_cliente
integer x = 2697
integer y = 916
integer width = 370
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Voltar"
boolean cancel = true
boolean default = true
end type

event clicked;
close(Parent)
end event

type gb_1 from groupbox within w_ge032_cheque_pendente_cliente
integer x = 27
integer y = 8
integer width = 3040
integer height = 896
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Cheques Pendentes"
borderstyle borderstyle = styleraised!
end type

