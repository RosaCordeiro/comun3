HA$PBExportHeader$w_msg_versao_nova.srw
forward
global type w_msg_versao_nova from window
end type
type st_limite_execucao from statictext within w_msg_versao_nova
end type
type st_4 from statictext within w_msg_versao_nova
end type
type st_3 from statictext within w_msg_versao_nova
end type
type st_2 from statictext within w_msg_versao_nova
end type
type st_1 from statictext within w_msg_versao_nova
end type
type gb_1 from groupbox within w_msg_versao_nova
end type
end forward

global type w_msg_versao_nova from window
integer x = 1047
integer y = 900
integer width = 2610
integer height = 552
windowtype windowtype = response!
long backcolor = 255
boolean center = true
st_limite_execucao st_limite_execucao
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
gb_1 gb_1
end type
global w_msg_versao_nova w_msg_versao_nova

type variables
Boolean ib_Fecha_Sistema = False

DateTime idh_Limite_Execucao

STRING ivs_Liberar
end variables

on w_msg_versao_nova.create
this.st_limite_execucao=create st_limite_execucao
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.st_limite_execucao,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.gb_1}
end on

on w_msg_versao_nova.destroy
destroy(this.st_limite_execucao)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_1)
end on

event key;//CHOOSE CASE key 
//	CASE KeySpaceBar!
//		ivs_Liberar = "SIM"
//		CLOSE(THIS)
//END CHOOSE

CHOOSE CASE key 
	CASE KeyEscape!
		ivs_Liberar = "[ESC]"
		
		If Not This.ib_Fecha_Sistema Then
			CLOSE(THIS)
		Else
			gvo_Aplicacao.Event ue_Exit( )
		End If
END CHOOSE
end event

event open;String lvs_Produto

ivs_Liberar = "NAO"

This.idh_Limite_Execucao = gf_Relative_DateTime( gvo_Aplicacao.idh_Primeiro_Alerta_Versao_Nova, 1800 )

st_limite_execucao.Text = "Hor$$HEX1$$e100$$ENDHEX$$rio limite para atualizar: " + String( This.idh_Limite_Execucao, "dd/mm/yyyy hh:mm" )

If This.idh_Limite_Execucao < DateTime( Today( ), Now( ) ) Then
	st_limite_execucao.Text = ""
	st_4.Text = "O SISTEMA SER$$HEX1$$c100$$ENDHEX$$ ENCERRADO"
	This.ib_Fecha_Sistema = True
End If
end event

event close;CloseWithReturn(THIS,ivs_Liberar)
end event

type st_limite_execucao from statictext within w_msg_versao_nova
integer x = 69
integer y = 324
integer width = 2473
integer height = 84
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 65535
long backcolor = 255
string text = "Hor$$HEX1$$e100$$ENDHEX$$rio limite para atualizar: "
boolean focusrectangle = false
end type

type st_4 from statictext within w_msg_versao_nova
integer x = 69
integer y = 240
integer width = 2473
integer height = 84
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 65535
long backcolor = 255
boolean enabled = false
string text = "Feche o sistema e abra-o novamente assim que poss$$HEX1$$ed00$$ENDHEX$$vel para atualiz$$HEX1$$e100$$ENDHEX$$-lo."
boolean focusrectangle = false
end type

type st_3 from statictext within w_msg_versao_nova
integer x = 69
integer y = 156
integer width = 2386
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 65535
long backcolor = 255
boolean enabled = false
string text = "Existe uma vers$$HEX1$$e300$$ENDHEX$$o mais recente do sistema. "
boolean focusrectangle = false
end type

type st_2 from statictext within w_msg_versao_nova
integer x = 69
integer y = 412
integer width = 2386
integer height = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 16777215
long backcolor = 255
boolean enabled = false
string text = "Pressione [ESC] para fechar esta mensagem"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_msg_versao_nova
integer x = 69
integer y = 52
integer width = 2386
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 16777215
long backcolor = 255
boolean enabled = false
string text = "ATEN$$HEX2$$c700c300$$ENDHEX$$O"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_msg_versao_nova
integer x = 23
integer width = 2546
integer height = 516
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 255
borderstyle borderstyle = styleraised!
end type

