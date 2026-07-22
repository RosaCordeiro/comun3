HA$PBExportHeader$w_ge084_selecao_menu.srw
forward
global type w_ge084_selecao_menu from window
end type
type cb_voltar from commandbutton within w_ge084_selecao_menu
end type
type cb_confirmar from commandbutton within w_ge084_selecao_menu
end type
type cb_cancelar from commandbutton within w_ge084_selecao_menu
end type
type dw_1 from datawindow within w_ge084_selecao_menu
end type
type gb_1 from groupbox within w_ge084_selecao_menu
end type
end forward

global type w_ge084_selecao_menu from window
integer x = 1138
integer y = 868
integer width = 2446
integer height = 1360
boolean titlebar = true
string title = "TEF - Selecione uma das op$$HEX2$$e700f500$$ENDHEX$$es."
windowtype windowtype = response!
long backcolor = 80269524
cb_voltar cb_voltar
cb_confirmar cb_confirmar
cb_cancelar cb_cancelar
dw_1 dw_1
gb_1 gb_1
end type
global w_ge084_selecao_menu w_ge084_selecao_menu

forward prototypes
public function boolean wf_valor_minimo_recarga (ref decimal pdc_valor_minimo)
public subroutine wf_cria_menu_dinamico ()
end prototypes

public function boolean wf_valor_minimo_recarga (ref decimal pdc_valor_minimo);Boolean lb_Sucesso = False

String ls_Parametro

Long 		ll_Tabela

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

lb_Sucesso = lvo_Parametro.of_Localiza_Parametro("VL_MINIMO_RECARGA_CELULAR_TEF", ref ls_Parametro)

Destroy(lvo_Parametro)

If lb_Sucesso Then
	pdc_valor_minimo = Dec(ls_Parametro)
Else
	pdc_valor_minimo = 000.00
End If

Return lb_Sucesso
end function

public subroutine wf_cria_menu_dinamico ();
Decimal ldc_Valor_Recarga
Decimal ldc_Valor_Minimo_Recarga

Boolean lb_Recarga = False
Boolean lb_Recarga_Pagamento = False

String  ls_Menu
String  ls_Titulo
String  ls_Opcao
String  ls_Bonus
String  ls_Temp
String  ls_Valor

Integer li_Row
Integer li_Pos
Integer li_Pos2
Integer li_Pos3
Integer li_Byte
Integer li_Ind

ls_Menu   = Upper(Message.StringParm)

If MidA(ls_Menu,1,1) = "S" Then
	//Sele$$HEX2$$e700e300$$ENDHEX$$o da Forma de pagamento
	lb_Recarga_Pagamento = True
	ls_Menu	= MidA(ls_Menu,3)
End If

ls_Titulo = RightA(ls_Menu,LenA(ls_Menu)-(5+Integer(LeftA(ls_Menu,4))))
ls_Menu   = MidA(ls_Menu,6,Integer(LeftA(ls_Menu,4)))

//Retira Caracteres inv$$HEX1$$e100$$ENDHEX$$lidos 
For li_Byte = 1 To LenA(ls_Titulo)
	If MidA(ls_Titulo,li_Byte,1) <> CharA(10) Then
		ls_Temp += MidA(ls_Titulo,li_Byte,1)
	End If
Next

This.Title = ls_Temp

ls_Temp   = ''

//Retira Caracteres inv$$HEX1$$e100$$ENDHEX$$lidos 
For li_Byte = 1 To LenA(ls_Menu)
	If MidA(ls_Menu,li_Byte,1) <> CharA(10) Then
		ls_Temp += MidA(ls_Menu,li_Byte,1)
	End If
Next

ls_Menu = ls_Temp

//Monta Menu dinamicamente

//If lower(ls_Titulo) = 'selecione o valor a ser carregado no celular' Then
li_Pos3 = PosA(lower(ls_Titulo),'selecione o valor')
If li_Pos3 <> 0 And lb_Recarga_Pagamento = True Then

	lb_Recarga = True
	lb_Recarga_Pagamento = False
	
	wf_valor_minimo_recarga( Ref ldc_Valor_Minimo_Recarga )
	
End If	

For li_Byte = 1 To LenA(ls_Menu)
	
	If MidA(ls_Menu,li_Byte,1) = ";" Then
		
		ls_Opcao = LeftA(ls_Menu,li_Byte -1)
		
		li_Pos   = PosA(ls_Opcao,':')
		
		If li_Pos <> 0 Then
			
			ls_Menu = MidA(ls_Menu,li_Byte +1)
	
			li_Byte = 0
			
			If lb_Recarga Then				
				//Tratamento para quando a operadora manda outra informa$$HEX2$$e700e300$$ENDHEX$$o com o valor, como BONUS ou 30 dias.
				//Exemplo: 3:R$ 20,00, BONUS DE R$ 2,00;				
				//1:R$ 5,00 - 30 Dias				
				ls_temp = Trim(MidA(ls_Opcao, 1, PosA(ls_opcao,',') + 2))	
				//Separa o valor
				ls_Valor = MidA(Trim(ls_temp), PosA(ls_temp,'R$') + 2)
				//pode ter caracteres e espa$$HEX1$$e700$$ENDHEX$$os depois do valor
				li_Pos2 = PosA(ls_Valor,',')	
				//Separa o valor dos caracteres, pegando a primeira virgula e as 2 proximas posi$$HEX2$$e700f500$$ENDHEX$$es.
				ls_Valor = Trim(LeftA(ls_Valor, li_Pos2 + 2))
				ldc_Valor_Recarga = Dec(ls_Valor)					
				
//				li_Pos2 = PosA(ls_Opcao,'BONUS')
//				If li_Pos2 = 0 Then
//					li_Pos2 = PosA(ls_Opcao,'B$$HEX1$$d400$$ENDHEX$$NUS')	
//				End If
//				If li_Pos2 <> 0 Then
//					String ls_teste
//					//Pega texto antes do Bonus
//					ls_Bonus = Trim(LeftA(ls_Opcao, li_Pos2 - 1))
//					//Separa o valor
////					ls_Valor = RightA(ls_Bonus, PosA(ls_Bonus,'R$') + 3)	
//					ls_Valor = MidA(Trim(ls_Bonus), PosA(ls_Bonus,'R$') + 2)
//					//pode ter caracteres e espa$$HEX1$$e700$$ENDHEX$$os depois do valor
//					li_Pos2 = PosA(ls_Valor,',')	
//					//Separa o valor dos caracteres, pegando a primeira virgula e as 2 proximas posi$$HEX2$$e700f500$$ENDHEX$$es.
//					ls_Valor = Trim(LeftA(ls_Valor, li_Pos2 + 2))
//					ldc_Valor_Recarga = Dec(ls_Valor)					
//				Else							
////					ldc_Valor_Recarga = Dec(RightA(ls_Opcao, PosA(ls_Opcao,'R$') + 2))
//					ldc_Valor_Recarga = Dec(MidA(Trim(ls_Opcao), PosA(ls_Opcao,'R$') + 2))
//				End If
//				
				If ldc_Valor_Minimo_Recarga > 0 Then
				
					If ldc_Valor_Recarga < ldc_Valor_Minimo_Recarga Then Continue
					
				End If	
				
				//If Mid(ls_Opcao,1,li_Pos -1) <> 'DINHEIRO' Then Continue
				
			End If
			
			li_Row = dw_1.InsertRow(0)
			
			dw_1.object.id_menu[li_row] = MidA(ls_Opcao,1,li_Pos -1)		
			If Sitef.cd_funcao = 122 Then
				If Pos(Upper(Trim(MidA(ls_Opcao,li_Pos +1))), "MERCADO PAGO") > 0 Or Pos(Upper(Trim(MidA(ls_Opcao,li_Pos +1))), "MERCADOPAGO")  > 0 Then
					dw_1.object.de_menu[li_row] = "PIX OU MERCADOPAGO"
				Else					
					dw_1.object.de_menu[li_row] = Trim(MidA(ls_Opcao,li_Pos +1))	
				End If
			Else
				dw_1.object.de_menu[li_row] = Trim(MidA(ls_Opcao,li_Pos +1))					
			End If			
		End If	
		
	End If
	
Next

If dw_1.RowCount() = 0 Then
	cb_confirmar.Enabled = False
	MessageBox("uo_Sitef","Nenhuma op$$HEX2$$e700e300$$ENDHEX$$o dispon$$HEX1$$ed00$$ENDHEX$$vel para sele$$HEX2$$e700e300$$ENDHEX$$o",Exclamation!)
Else
	If lb_Recarga_Pagamento And Not lb_Recarga Then
		If dw_1.object.de_menu[1] = "DINHEIRO" Then
			dw_1.RowsMove(1, 1, Primary!, dw_1, dw_1.RowCount() + 1, Primary!)
		End If
	End If
	
	dw_1.Sort()
End If

SetPointer(Arrow!)
end subroutine

on w_ge084_selecao_menu.create
this.cb_voltar=create cb_voltar
this.cb_confirmar=create cb_confirmar
this.cb_cancelar=create cb_cancelar
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.cb_voltar,&
this.cb_confirmar,&
this.cb_cancelar,&
this.dw_1,&
this.gb_1}
end on

on w_ge084_selecao_menu.destroy
destroy(this.cb_voltar)
destroy(this.cb_confirmar)
destroy(this.cb_cancelar)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;
SetPointer(HourGlass!)

This.x = ( 3680 - This.Width ) / 2
This.y = ( 2000 - This.Height) / 2

wf_cria_menu_dinamico()

This.Show()

gf_Ativa_Janela(This)

dw_1.SetFocus()



end event

type cb_voltar from commandbutton within w_ge084_selecao_menu
integer x = 41
integer y = 1096
integer width = 439
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Voltar"
end type

event clicked;CloseWithReturn(Parent,'VOLTAR')
end event

event getfocus;This.Weight  = 700
This.Default = True
end event

event losefocus;This.Weight  = 400
This.Default = False
end event

type cb_confirmar from commandbutton within w_ge084_selecao_menu
integer x = 1957
integer y = 1096
integer width = 439
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Confirmar"
boolean default = true
end type

event clicked;String ls_Opcao

If dw_1.GetRow() = 0 Then
	MessageBox("uo_Sitef","Selecione uma op$$HEX2$$e700e300$$ENDHEX$$o.",Exclamation!)
	Return
End If	

ls_Opcao = dw_1.object.id_menu[dw_1.GetRow()]

CloseWithReturn(Parent,ls_Opcao)


end event

event getfocus;This.Weight  = 700
This.Default = True
end event

event losefocus;This.Weight  = 400
This.Default = False
end event

type cb_cancelar from commandbutton within w_ge084_selecao_menu
integer x = 1504
integer y = 1096
integer width = 439
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "C&ancelar"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent,'CANCELAR')
end event

event getfocus;This.Weight  = 700
This.Default = True
end event

event losefocus;This.Weight  = 400
This.Default = False
end event

type dw_1 from datawindow within w_ge084_selecao_menu
integer x = 78
integer y = 64
integer width = 2281
integer height = 984
integer taborder = 10
string dataobject = "dw_ge084_selecao_menu"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;cb_confirmar.Event Clicked()
end event

event getfocus;cb_confirmar.Weight  = 700
cb_confirmar.Default = True
end event

event losefocus;cb_confirmar.Weight  = 400
cb_confirmar.Default = False
end event

type gb_1 from groupbox within w_ge084_selecao_menu
integer x = 41
integer width = 2354
integer height = 1080
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

