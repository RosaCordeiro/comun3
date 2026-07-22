HA$PBExportHeader$w_ge084_erro_impressao_comprovante.srw
forward
global type w_ge084_erro_impressao_comprovante from window
end type
type st_3 from statictext within w_ge084_erro_impressao_comprovante
end type
type st_2 from statictext within w_ge084_erro_impressao_comprovante
end type
type p_1 from picture within w_ge084_erro_impressao_comprovante
end type
type cb_cancelar from commandbutton within w_ge084_erro_impressao_comprovante
end type
type cb_continuar from commandbutton within w_ge084_erro_impressao_comprovante
end type
type st_1 from statictext within w_ge084_erro_impressao_comprovante
end type
type gb_1 from groupbox within w_ge084_erro_impressao_comprovante
end type
end forward

global type w_ge084_erro_impressao_comprovante from window
integer x = 1216
integer y = 1140
integer width = 2277
integer height = 780
windowtype windowtype = response!
long backcolor = 80269524
event ue_posopen ( )
st_3 st_3
st_2 st_2
p_1 p_1
cb_cancelar cb_cancelar
cb_continuar cb_continuar
st_1 st_1
gb_1 gb_1
end type
global w_ge084_erro_impressao_comprovante w_ge084_erro_impressao_comprovante

event ue_posopen;gf_Ativa_Janela(This)

This.Show()

cb_continuar.SetFocus()
end event

on w_ge084_erro_impressao_comprovante.create
this.st_3=create st_3
this.st_2=create st_2
this.p_1=create p_1
this.cb_cancelar=create cb_cancelar
this.cb_continuar=create cb_continuar
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.st_3,&
this.st_2,&
this.p_1,&
this.cb_cancelar,&
this.cb_continuar,&
this.st_1,&
this.gb_1}
end on

on w_ge084_erro_impressao_comprovante.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.p_1)
destroy(this.cb_cancelar)
destroy(this.cb_continuar)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;This.Event ue_posopen()


end event

type st_3 from statictext within w_ge084_erro_impressao_comprovante
integer x = 50
integer y = 280
integer width = 2158
integer height = 108
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Deseja tentar imprimir novamente ?"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_ge084_erro_impressao_comprovante
integer x = 347
integer y = 76
integer width = 1861
integer height = 128
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Erro na impressora fiscal ao tentar imprimir o comprovante TEF."
alignment alignment = center!
boolean focusrectangle = false
end type

type p_1 from picture within w_ge084_erro_impressao_comprovante
integer x = 119
integer y = 84
integer width = 165
integer height = 136
boolean originalsize = true
string picturename = "s:\sistemas_pb12\caixa\figuras\problemas_ecf.bmp"
boolean focusrectangle = false
end type

type cb_cancelar from commandbutton within w_ge084_erro_impressao_comprovante
integer x = 1851
integer y = 632
integer width = 370
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&N$$HEX1$$c300$$ENDHEX$$O"
boolean cancel = true
end type

event clicked;String ls_Usuario

If gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("CANCELAMENTO_TRANSACAO_TEF", Ref ls_Usuario) Then

	CloseWithReturn(Parent,"2")
	
End If	
end event

event losefocus;cb_continuar.Default = True
This.Weight  = 400
end event

event getfocus;This.Default = True
This.Weight  = 700
end event

type cb_continuar from commandbutton within w_ge084_erro_impressao_comprovante
integer x = 1467
integer y = 632
integer width = 370
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&SIM"
boolean default = true
end type

event clicked;CloseWithReturn(Parent,"1")
end event

event getfocus;This.Default = True
This.Weight  = 700
end event

event losefocus;This.Default = False
This.Weight  = 400
end event

type st_1 from statictext within w_ge084_erro_impressao_comprovante
integer x = 50
integer y = 440
integer width = 2158
integer height = 128
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "Verifique a luz indicadora de papel, caso a mesma esteja acesa, efetue a troca da bobina e repita opera$$HEX2$$e700e300$$ENDHEX$$o usando a tecla [SIM]."
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_ge084_erro_impressao_comprovante
integer x = 32
integer y = 8
integer width = 2199
integer height = 584
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

