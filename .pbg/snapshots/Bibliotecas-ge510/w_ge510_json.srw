HA$PBExportHeader$w_ge510_json.srw
forward
global type w_ge510_json from window
end type
type cb_1 from commandbutton within w_ge510_json
end type
type dw_1 from dc_uo_dw_base within w_ge510_json
end type
type gb_1 from groupbox within w_ge510_json
end type
end forward

global type w_ge510_json from window
integer width = 3072
integer height = 1212
boolean titlebar = true
string title = "JSON"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge510_json w_ge510_json

on w_ge510_json.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.cb_1,&
this.dw_1,&
this.gb_1}
end on

on w_ge510_json.destroy
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;string ls_json

ls_json = message.stringparm

dw_1.insertrow(1)
dw_1.object.ds_json[1] = ls_json

end event

type cb_1 from commandbutton within w_ge510_json
integer x = 2482
integer y = 996
integer width = 503
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "OK"
boolean cancel = true
boolean default = true
end type

event clicked;Close(parent)
end event

type dw_1 from dc_uo_dw_base within w_ge510_json
integer x = 64
integer y = 56
integer width = 2917
integer height = 872
string dataobject = "dw_ge510_json"
boolean livescroll = false
end type

type gb_1 from groupbox within w_ge510_json
integer x = 27
integer y = 4
integer width = 2999
integer height = 956
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

