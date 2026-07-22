HA$PBExportHeader$w_ge252_acao_importacao.srw
forward
global type w_ge252_acao_importacao from dc_w_response_ok_cancela
end type
type rb_fechar from radiobutton within w_ge252_acao_importacao
end type
type rb_resolver from radiobutton within w_ge252_acao_importacao
end type
type st_1 from statictext within w_ge252_acao_importacao
end type
type st_2 from statictext within w_ge252_acao_importacao
end type
end forward

global type w_ge252_acao_importacao from dc_w_response_ok_cancela
integer width = 2043
integer height = 1044
string title = "GE252 - A$$HEX2$$e700e300$$ENDHEX$$o sobre os agrupamentos"
rb_fechar rb_fechar
rb_resolver rb_resolver
st_1 st_1
st_2 st_2
end type
global w_ge252_acao_importacao w_ge252_acao_importacao

on w_ge252_acao_importacao.create
int iCurrent
call super::create
this.rb_fechar=create rb_fechar
this.rb_resolver=create rb_resolver
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_fechar
this.Control[iCurrent+2]=this.rb_resolver
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
end on

on w_ge252_acao_importacao.destroy
call super::destroy
destroy(this.rb_fechar)
destroy(this.rb_resolver)
destroy(this.st_1)
destroy(this.st_2)
end on

event ue_postopen;//Override
gb_1.SetFocus ()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge252_acao_importacao
boolean visible = false
integer y = 152
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge252_acao_importacao
integer x = 622
integer y = 276
integer width = 754
integer height = 388
string text = "A$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge252_acao_importacao
boolean visible = false
integer x = 1568
integer y = 232
integer width = 384
integer height = 352
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge252_acao_importacao
integer x = 1266
integer y = 824
end type

event cb_ok::clicked;call super::clicked;Choose case True
	case rb_fechar.Checked
		
		If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
							'Os agrupamentos listados na planilha ser$$HEX1$$e300$$ENDHEX$$o FECHADOS.~n~r' + & 
							'Portanto, s$$HEX1$$f300$$ENDHEX$$ ser$$HEX1$$e300$$ENDHEX$$o marcados os agrupamentos que estiverem com a situa$$HEX2$$e700e300$$ENDHEX$$o ABERTO.~n~r~r' + &
							'Confirma?', &
							Question!, YesNo!, 2) = 2 then
			Return
		End if
		
		CloseWithReturn (Parent, 'F')
		
	case rb_resolver.Checked
		
		If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
							'Os agrupamentos listados na planilha ser$$HEX1$$e300$$ENDHEX$$o RESOLVIDOS.~n~r' + &
							'Portanto, s$$HEX1$$f300$$ENDHEX$$ ser$$HEX1$$e300$$ENDHEX$$o marcados os agrupamentos que estiverem com a situa$$HEX2$$e700e300$$ENDHEX$$o FECHADO.~n~r~r' + &
							'Confirma?', &
							Question!, YesNo!, 2) = 2 then
			Return
		End if
		
		CloseWithReturn (Parent, 'R')
		
	case else
		
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe a a$$HEX2$$e700e300$$ENDHEX$$o a ser aplicada aos agrupamentos listados na planilha importada!')
		
End choose

Return
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge252_acao_importacao
integer x = 1600
integer y = 824
end type

type rb_fechar from radiobutton within w_ge252_acao_importacao
integer x = 850
integer y = 344
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 67108864
string text = "&Fechar"
end type

type rb_resolver from radiobutton within w_ge252_acao_importacao
integer x = 850
integer y = 484
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 67108864
string text = "&Resolver"
end type

type st_1 from statictext within w_ge252_acao_importacao
integer x = 37
integer y = 60
integer width = 1934
integer height = 160
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Informe a a$$HEX2$$e700e300$$ENDHEX$$o a ser executada sobre os agrupamentos importados da planilha:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_ge252_acao_importacao
integer x = 37
integer y = 744
integer width = 878
integer height = 180
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Obs.: Os dados na planilha devem estar da seguinte forma: Coluna A = Agrupamento"
boolean focusrectangle = false
end type

