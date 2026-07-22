HA$PBExportHeader$uo_texto_paf.sru
forward
global type uo_texto_paf from userobject
end type
type st_msg_menu from statictext within uo_texto_paf
end type
end forward

global type uo_texto_paf from userobject
integer width = 1189
integer height = 84
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_msg_menu st_msg_menu
end type
global uo_texto_paf uo_texto_paf

on uo_texto_paf.create
this.st_msg_menu=create st_msg_menu
this.Control[]={this.st_msg_menu}
end on

on uo_texto_paf.destroy
destroy(this.st_msg_menu)
end on

type st_msg_menu from statictext within uo_texto_paf
integer y = 12
integer width = 1198
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "MENU FISCAL INACESS$$HEX1$$cd00$$ENDHEX$$VEL NESTA TELA"
alignment alignment = center!
boolean focusrectangle = false
end type

