HA$PBExportHeader$dc_w_msg.srw
forward
global type dc_w_msg from window
end type
type st_msg from statictext within dc_w_msg
end type
type st_titulo from statictext within dc_w_msg
end type
type gb_1 from groupbox within dc_w_msg
end type
end forward

global type dc_w_msg from window
integer x = 1097
integer y = 980
integer width = 1477
integer height = 436
windowtype windowtype = popup!
long backcolor = 79741120
st_msg st_msg
st_titulo st_titulo
gb_1 gb_1
end type
global dc_w_msg dc_w_msg

on dc_w_msg.create
this.st_msg=create st_msg
this.st_titulo=create st_titulo
this.gb_1=create gb_1
this.Control[]={this.st_msg,&
this.st_titulo,&
this.gb_1}
end on

on dc_w_msg.destroy
destroy(this.st_msg)
destroy(this.st_titulo)
destroy(this.gb_1)
end on

type st_msg from statictext within dc_w_msg
integer x = 50
integer y = 200
integer width = 1362
integer height = 164
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "<Mensagem>"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_titulo from statictext within dc_w_msg
integer x = 55
integer y = 100
integer width = 1362
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "AGUARDE"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within dc_w_msg
integer x = 37
integer width = 1399
integer height = 396
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

