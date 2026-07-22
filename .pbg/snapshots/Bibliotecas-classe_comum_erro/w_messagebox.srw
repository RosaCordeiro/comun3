HA$PBExportHeader$w_messagebox.srw
forward
global type w_messagebox from window
end type
type st_1 from statictext within w_messagebox
end type
type cb_nao from commandbutton within w_messagebox
end type
type cb_cancelar from commandbutton within w_messagebox
end type
type cb_ok from commandbutton within w_messagebox
end type
type p_icon from picture within w_messagebox
end type
type st_mensagem from multilineedit within w_messagebox
end type
type cb_sim from commandbutton within w_messagebox
end type
end forward

global type w_messagebox from window
integer width = 2240
integer height = 756
boolean titlebar = true
string title = "Aten$$HEX2$$e700e300$$ENDHEX$$o"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
integer transparency = 2
st_1 st_1
cb_nao cb_nao
cb_cancelar cb_cancelar
cb_ok cb_ok
p_icon p_icon
st_mensagem st_mensagem
cb_sim cb_sim
end type
global w_messagebox w_messagebox

type variables
uo_messagebox ivo_Parametros
end variables

on w_messagebox.create
this.st_1=create st_1
this.cb_nao=create cb_nao
this.cb_cancelar=create cb_cancelar
this.cb_ok=create cb_ok
this.p_icon=create p_icon
this.st_mensagem=create st_mensagem
this.cb_sim=create cb_sim
this.Control[]={this.st_1,&
this.cb_nao,&
this.cb_cancelar,&
this.cb_ok,&
this.p_icon,&
this.st_mensagem,&
this.cb_sim}
end on

on w_messagebox.destroy
destroy(this.st_1)
destroy(this.cb_nao)
destroy(this.cb_cancelar)
destroy(this.cb_ok)
destroy(this.p_icon)
destroy(this.st_mensagem)
destroy(this.cb_sim)
end on

event open;String ls_Mensagem
String ls_Parte_String
Long ll_Pos

cb_Ok.Visible			= False
cb_Cancelar.Visible	= False
cb_Sim.Visible			= False
cb_Nao.Visible			= False

ivo_Parametros = Message.PowerObjectParm

This.Title			= ivo_Parametros.Titulo
ls_Mensagem	= ivo_Parametros.Texto

//Trata as quebras de linha, para funcionar como na fun$$HEX2$$e700e300$$ENDHEX$$o nativa.
ll_Pos = PosA( ls_Mensagem, '~r' )

Do While ll_Pos > 0
	
	ls_Parte_String = MidA( ls_Mensagem, ll_Pos +2, 2 )
	
	If ls_Parte_String <> '~n' And ls_Parte_String <> Char(13) + Char(10) Then
		ls_Parte_String = MidA( ls_Mensagem, 1, ll_Pos )
		ls_Parte_String += '~n'
		ls_Mensagem = ls_Parte_String + MidA( ls_Mensagem, ll_Pos +1 )
	End If	
	
	ll_Pos = PosA( ls_Mensagem, '~r', ll_Pos +3 )
Loop
//

st_Mensagem.Text	=	ls_Mensagem

If st_Mensagem.LineCount() > 9 Then
	st_Mensagem.vScrollBar = True
End If

Choose Case ivo_Parametros.Icone
	Case	Information!, &
			None!, &
			StopSign!, &
			Exclamation!
		
		p_icon.PictureName = "S:\Sistemas_PB12\Comuns\Figuras\information.png"
		
		If ivo_Parametros.Icone = StopSign! Then
			p_icon.PictureName = "S:\Sistemas_PB12\Comuns\Figuras\stopsign.png"
		End If
		
		If ivo_Parametros.Icone = Exclamation! Then
			p_icon.PictureName = "S:\Sistemas_PB12\Comuns\Figuras\exclamation.png"
		End If
		
		cb_Ok.X			= 1755
		cb_Ok.Visible	= True
		
	Case Question!
		
		If ivo_Parametros.Botao <> YesNoCancel! Then
			cb_Sim.X	= 1349
			cb_Nao.X	= 1792
		Else
			cb_Cancelar.Visible	= True
		End If
		
		st_1.Visible					=	False
		p_icon.PictureName		= "S:\Sistemas_PB12\Comuns\Figuras\question.png"
		cb_Sim.Visible = True
		cb_Nao.Visible = True
		
		Choose Case ivo_Parametros.Default
			Case 1
				cb_Sim.Default = True
			Case 2
				cb_Nao.Default = True
			Case 3
				cb_Cancelar.Default = True
		End Choose
		
End Choose
end event

type st_1 from statictext within w_messagebox
integer x = 32
integer y = 580
integer width = 1134
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 134217745
long backcolor = 67108864
string text = "$$HEX1$$c900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel copiar o texto se necess$$HEX1$$e100$$ENDHEX$$rio"
boolean focusrectangle = false
end type

type cb_nao from commandbutton within w_messagebox
integer x = 1353
integer y = 548
integer width = 402
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&N$$HEX1$$e300$$ENDHEX$$o"
end type

event clicked;CloseWithReturn( Parent, 2 )
end event

type cb_cancelar from commandbutton within w_messagebox
integer x = 1797
integer y = 548
integer width = 402
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, 3 )
end event

type cb_ok from commandbutton within w_messagebox
integer x = 1349
integer y = 548
integer width = 402
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&OK"
boolean default = true
end type

event clicked;Close( Parent )
end event

type p_icon from picture within w_messagebox
integer x = 32
integer y = 116
integer width = 389
integer height = 340
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\question.png"
boolean focusrectangle = false
end type

type st_mensagem from multilineedit within w_messagebox
integer x = 434
integer y = 32
integer width = 1755
integer height = 484
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean border = false
boolean displayonly = true
end type

type cb_sim from commandbutton within w_messagebox
integer x = 910
integer y = 548
integer width = 402
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Sim"
end type

event clicked;CloseWithReturn( Parent, 1 )
end event

