HA$PBExportHeader$w_ge252_resolver.srw
forward
global type w_ge252_resolver from window
end type
type st_2 from statictext within w_ge252_resolver
end type
type cbx_1 from checkbox within w_ge252_resolver
end type
type st_1 from statictext within w_ge252_resolver
end type
type cb_3 from commandbutton within w_ge252_resolver
end type
type cb_2 from commandbutton within w_ge252_resolver
end type
type cb_1 from commandbutton within w_ge252_resolver
end type
end forward

global type w_ge252_resolver from window
integer width = 1966
integer height = 900
boolean titlebar = true
string title = "GE0252 - Resolver"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_2 st_2
cbx_1 cbx_1
st_1 st_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_ge252_resolver w_ge252_resolver

type variables
Long il_Agrupamento
end variables

on w_ge252_resolver.create
this.st_2=create st_2
this.cbx_1=create cbx_1
this.st_1=create st_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_2,&
this.cbx_1,&
this.st_1,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_ge252_resolver.destroy
destroy(this.st_2)
destroy(this.cbx_1)
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;Boolean	lb_Iniciado_Operacao_SAP
String	ls_msg, &
			ls_agrupamento

il_Agrupamento = Message.DoubleParm	

ls_agrupamento = Iif (il_Agrupamento = 0, '(v$$HEX1$$e100$$ENDHEX$$rios)', String (il_Agrupamento))

st_1.Text = 'Agrupamento: ' + ls_Agrupamento

if not gf_verifica_inicio_operacao_sap('DH_INICIO_OPERACAO_SAP', ref lb_Iniciado_Operacao_SAP, ref ls_msg ) then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a data de in$$HEX1$$ed00$$ENDHEX$$cio de opera$$HEX2$$e700e300$$ENDHEX$$o do SAP.', StopSign!)
	Close(this)
end if

if not lb_Iniciado_Operacao_SAP then
	st_2.Visible 	= True
	cbx_1.Visible	= True
	cb_1.y			= 116
	cb_2.y			= 304
end if

end event

type st_2 from statictext within w_ge252_resolver
boolean visible = false
integer x = 325
integer y = 460
integer width = 1330
integer height = 152
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Agrupar as Notas de Origem em uma $$HEX1$$fa00$$ENDHEX$$nica Nota de Devolu$$HEX2$$e700e300$$ENDHEX$$o de compra?"
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_ge252_resolver
boolean visible = false
integer x = 242
integer y = 456
integer width = 87
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
end type

type st_1 from statictext within w_ge252_resolver
integer width = 1915
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_ge252_resolver
integer x = 1618
integer y = 692
integer width = 270
integer height = 80
integer taborder = 30
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar"
end type

event clicked;CloseWithReturn(Parent, "")
end event

type cb_2 from commandbutton within w_ge252_resolver
integer x = 238
integer y = 412
integer width = 1376
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "EMITIR NOTA DE DEVOLU$$HEX2$$c700c300$$ENDHEX$$O DE COMPRA"
end type

event clicked;String 	ls_MSG,&
			ls_Parametro

ls_MSG =	'Confirma a altera$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do(s) agrupamento(s) selecionado(s) para RESOLVIDO?' + '~r~r' + &
			'Obs.: O sistema ir$$HEX1$$e100$$ENDHEX$$ gerar a nota fiscal de devolu$$HEX2$$e700e300$$ENDHEX$$o automaticamente.'

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, Question!, YesNo!, 2) = 2 Then
	Return 1
End If		

If cbx_1.Checked Then
	ls_Parametro = "N"+"S"	
Else
	ls_Parametro = "N"+"N"
End If
					
CloseWithReturn(Parent, ls_Parametro)
end event

type cb_1 from commandbutton within w_ge252_resolver
integer x = 686
integer y = 224
integer width = 530
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "DESCARTAR"
end type

event clicked;String ls_MSG

//If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja realmente descartar o agrupamento?", Question!, YesNo!, 2) = 2 Then
//	Return 1
//End If

ls_MSG =	'Confirma a altera$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do(s) agrupamento(s) selecionado(s) para RESOLVIDO?' + '~r~r' + &
			'Obs.: O sistema ir$$HEX1$$e100$$ENDHEX$$ DESCARTAR o agrupamento e fazer automaticamente os ajustes de estoques.'
				 
If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, Question!, YesNo!, 2) = 2 Then
	Return 1
End If		


CloseWithReturn(Parent, "D")
end event

