HA$PBExportHeader$w_ge030_consulta_destinada.srw
forward
global type w_ge030_consulta_destinada from dc_w_response
end type
type dw_1 from dc_uo_dw_base within w_ge030_consulta_destinada
end type
type cb_1 from commandbutton within w_ge030_consulta_destinada
end type
type gb_1 from groupbox within w_ge030_consulta_destinada
end type
end forward

global type w_ge030_consulta_destinada from dc_w_response
integer width = 4261
integer height = 1172
string title = "GE030 - Consulta Notas Destinadas"
dw_1 dw_1
cb_1 cb_1
gb_1 gb_1
end type
global w_ge030_consulta_destinada w_ge030_consulta_destinada

on w_ge030_consulta_destinada.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.gb_1
end on

on w_ge030_consulta_destinada.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.gb_1)
end on

event open;call super::open;dc_uo_ds_base lds_dados

if isvalid(message.powerobjectparm) Then
	
	lds_dados = create dc_uo_ds_base
	//lds_dados.of_changedataobject( message.powerobjectparm.classname( ) )
	
	lds_dados = message.powerobjectparm
	
	lds_dados.rowscopy( 1, lds_dados.rowcount(), primary!, dw_1, 1, primary!)
	
ENd if
end event

type pb_help from dc_w_response`pb_help within w_ge030_consulta_destinada
end type

type dw_1 from dc_uo_dw_base within w_ge030_consulta_destinada
integer x = 69
integer y = 72
integer width = 4128
integer height = 868
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge030_lista_destinadas"
boolean vscrollbar = true
end type

type cb_1 from commandbutton within w_ge030_consulta_destinada
integer x = 3698
integer y = 952
integer width = 402
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Fechar"
end type

event clicked;Close(parent)
end event

type gb_1 from groupbox within w_ge030_consulta_destinada
integer x = 27
integer y = 8
integer width = 4192
integer height = 1064
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

