HA$PBExportHeader$dc_w_principal_fundo.srw
forward
global type dc_w_principal_fundo from window
end type
type st_descricao_cd from statictext within dc_w_principal_fundo
end type
end forward

global type dc_w_principal_fundo from window
integer width = 4718
integer height = 1876
boolean enabled = false
boolean border = false
windowtype windowtype = child!
long backcolor = 268435456
string icon = "AppIcon!"
boolean center = true
st_descricao_cd st_descricao_cd
end type
global dc_w_principal_fundo dc_w_principal_fundo

on dc_w_principal_fundo.create
this.st_descricao_cd=create st_descricao_cd
this.Control[]={this.st_descricao_cd}
end on

on dc_w_principal_fundo.destroy
destroy(this.st_descricao_cd)
end on

event resize;st_descricao_cd.x = ParentWindow().Width - st_descricao_cd.Width
end event

type st_descricao_cd from statictext within dc_w_principal_fundo
integer x = 91
integer y = 44
integer width = 1559
integer height = 548
integer textsize = -48
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 268435456
string text = "CD NOVO"
boolean focusrectangle = false
end type

