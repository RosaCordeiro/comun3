HA$PBExportHeader$w_ge108_alerta_default.srw
forward
global type w_ge108_alerta_default from window
end type
type st_3 from statictext within w_ge108_alerta_default
end type
type st_texto from statictext within w_ge108_alerta_default
end type
type gb_1 from groupbox within w_ge108_alerta_default
end type
end forward

global type w_ge108_alerta_default from window
integer x = 402
integer y = 1016
integer width = 3013
integer height = 684
windowtype windowtype = response!
long backcolor = 134217752
st_3 st_3
st_texto st_texto
gb_1 gb_1
end type
global w_ge108_alerta_default w_ge108_alerta_default

type variables
STRING ivs_mensagem

String ivs_Operador

uo_ge108_mensagem_campanha io_Mensagem
end variables

on w_ge108_alerta_default.create
this.st_3=create st_3
this.st_texto=create st_texto
this.gb_1=create gb_1
this.Control[]={this.st_3,&
this.st_texto,&
this.gb_1}
end on

on w_ge108_alerta_default.destroy
destroy(this.st_3)
destroy(this.st_texto)
destroy(this.gb_1)
end on

event key;String ls_Retorno
Choose Case Key 
	Case KeySpaceBar!, KeyEscape!
		
		SetNull(ls_Retorno)
		
		CloseWithReturn( This, ls_Retorno  )
End Choose

end event

event open;String ls_Texto

ls_Texto = Message.StringParm

If Not IsNull( ls_Texto ) Then
	st_Texto.text = ls_Texto
End If

Return
end event

type st_3 from statictext within w_ge108_alerta_default
integer x = 69
integer y = 544
integer width = 2875
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 134217752
boolean enabled = false
string text = "[ Espa$$HEX1$$e700$$ENDHEX$$o ] - Fechar"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_texto from statictext within w_ge108_alerta_default
integer x = 64
integer y = 104
integer width = 2875
integer height = 228
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 134217752
boolean enabled = false
string text = "texto"
alignment alignment = Center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_ge108_alerta_default
integer x = 32
integer y = 4
integer width = 2930
integer height = 640
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
borderstyle borderstyle = styleraised!
end type

