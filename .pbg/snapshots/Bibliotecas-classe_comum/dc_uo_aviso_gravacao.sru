HA$PBExportHeader$dc_uo_aviso_gravacao.sru
$PBExportComments$UO visual de aviso ao usuario para gravacao de CRUDs
forward
global type dc_uo_aviso_gravacao from userobject
end type
type st_1 from statictext within dc_uo_aviso_gravacao
end type
type p_1 from picture within dc_uo_aviso_gravacao
end type
type p_2 from picture within dc_uo_aviso_gravacao
end type
end forward

global type dc_uo_aviso_gravacao from userobject
integer width = 1801
integer height = 88
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_1 st_1
p_1 p_1
p_2 p_2
end type
global dc_uo_aviso_gravacao dc_uo_aviso_gravacao

on dc_uo_aviso_gravacao.create
this.st_1=create st_1
this.p_1=create p_1
this.p_2=create p_2
this.Control[]={this.st_1,&
this.p_1,&
this.p_2}
end on

on dc_uo_aviso_gravacao.destroy
destroy(this.st_1)
destroy(this.p_1)
destroy(this.p_2)
end on

type st_1 from statictext within dc_uo_aviso_gravacao
integer x = 110
integer y = 16
integer width = 1714
integer height = 52
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Utilize o bot$$HEX1$$e300$$ENDHEX$$o         da barra de ferramentas para confirmar as altera$$HEX2$$e700f500$$ENDHEX$$es"
boolean focusrectangle = false
end type

type p_1 from picture within dc_uo_aviso_gravacao
integer width = 91
integer height = 72
boolean bringtotop = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\information.png"
boolean focusrectangle = false
end type

type p_2 from picture within dc_uo_aviso_gravacao
integer x = 457
integer width = 91
integer height = 72
boolean bringtotop = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\confirmar_peq.gif"
boolean focusrectangle = false
end type

