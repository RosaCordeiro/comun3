HA$PBExportHeader$w_ge108_roteiro_entrega.srw
forward
global type w_ge108_roteiro_entrega from dc_w_response
end type
type cb_1 from commandbutton within w_ge108_roteiro_entrega
end type
type cb_2 from commandbutton within w_ge108_roteiro_entrega
end type
type gb_2 from groupbox within w_ge108_roteiro_entrega
end type
type dw_1 from dc_uo_dw_base within w_ge108_roteiro_entrega
end type
type gb_1 from groupbox within w_ge108_roteiro_entrega
end type
type dw_2 from dc_uo_dw_base within w_ge108_roteiro_entrega
end type
type st_1 from statictext within w_ge108_roteiro_entrega
end type
type st_mensagem from statictext within w_ge108_roteiro_entrega
end type
end forward

global type w_ge108_roteiro_entrega from dc_w_response
integer width = 2327
integer height = 1432
string title = "GE108 - Roteiro de Entrega"
cb_1 cb_1
cb_2 cb_2
gb_2 gb_2
dw_1 dw_1
gb_1 gb_1
dw_2 dw_2
st_1 st_1
st_mensagem st_mensagem
end type
global w_ge108_roteiro_entrega w_ge108_roteiro_entrega

on w_ge108_roteiro_entrega.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.gb_2=create gb_2
this.dw_1=create dw_1
this.gb_1=create gb_1
this.dw_2=create dw_2
this.st_1=create st_1
this.st_mensagem=create st_mensagem
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.st_mensagem
end on

on w_ge108_roteiro_entrega.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.gb_2)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.st_mensagem)
end on

event ue_postopen;call super::ue_postopen;DATAWINDOWCHILD	ivdwc_parametro

DateTime ldh_Servidor

String ls_Dias_entrega

dw_1.of_Populate_DDDW("id_parametro")




		


end event

event timer;call super::timer;Datetime ldh_Servidor

ldh_Servidor = gf_GetServerDate()

dw_1.Object.dh_servidor[1] = ldh_Servidor

dw_1.AcceptText()

end event

event open;call super::open;dw_1.Event ue_AddRow()
dw_2.Event ue_AddRow()

Timer(60)
end event

type pb_help from dc_w_response`pb_help within w_ge108_roteiro_entrega
integer x = 1952
integer y = 20
end type

type cb_1 from commandbutton within w_ge108_roteiro_entrega
integer x = 1888
integer y = 1224
integer width = 402
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Voltar"
end type

event clicked;String ls_Null
SetNull(ls_Null)

CloseWithReturn(Parent, ls_Null)
end event

type cb_2 from commandbutton within w_ge108_roteiro_entrega
integer x = 1458
integer y = 1224
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
string text = "Ok"
end type

event clicked;Date ldt_Parametro
Date ldt_Agendamento

Time lt_Inicio, lt_Termino
Time lt_Saida, lt_Corte
Time lt_Hora_Local

Integer li_Qt_Limite, li_Qt_Usada
Integer li_LINHAS

Long ll_id_roteiro

String ls_Tipo //Demanda / Hr FIXO
String ls_Agendar
String ls_Retorno
String ls_Roteiro_Agendamento

String ls_Dia_entrega

dw_1.AcceptText()
dw_2.AcceptText()

ldt_Parametro = Date(gvo_Parametro.dh_movimentacao)

ll_id_roteiro = dw_1.Object.id_parametro		[1]
li_Qt_limite 	= dw_2.Object.qt_limite_pedido	[1] 
ls_Tipo		= dw_2.Object.id_tipo				[1] 
lt_Saida		= Time(dw_2.Object.dh_horario_saida 	[1] ) 
lt_Corte		= Time(dw_2.Object.dh_horario_corte 	[1] ) 
lt_Inicio		= Time(dw_2.Object.dh_inicio				[1] ) 
lt_Termino	= Time(dw_2.Object.dh_termino			[1] ) 

ls_Agendar 			= dw_1.Object.id_agendar			[1]

If ls_Agendar = 'S' Then
	ldt_Agendamento 	= dw_1.Object.dh_agendamento	[1]
	
	If IsNull(ldt_Agendamento) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe corretamente a data do agendamento.", Exclamation!)
		dw_1.Event ue_Pos(1, "dh_agendamento")
		Return -1
	End If
	
	If ldt_Agendamento <= ldt_Parametro Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A data do agendamento n$$HEX1$$e300$$ENDHEX$$o pode ser menor ou igual a data do par$$HEX1$$e200$$ENDHEX$$metro.", Exclamation!)
		dw_1.Event ue_Pos(1, "dh_agendamento")
		Return -1
	End If
	
//	Verifica se a data selecionada possui roteiro de entrega
	Choose Case DayNumber ( date(ldt_Agendamento) )
	Case 1 //Domingo
		ls_Dia_entrega = '3'
	Case 7 //Sabado
		ls_Dia_entrega = '2'
	Case Else //Dias de semana
		ls_Dia_entrega = '1'
	End Choose
	
	dc_uo_ds_base ldc 
	ldc = Create dc_uo_ds_base 
	
	If Not ldc.of_changedataobject("ddw_ge108_roteiro_parametro_ativo") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento of_changedataobject.")
		Return -1
	End If
	
	li_LINHAS = ldc.Retrieve( ls_Dia_entrega )
	
	If li_LINHAS = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no retrieve.")
		Return -1
	End If
	
	If li_LINHAS = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe roteiro definido para a data do agendamento.", Exclamation!)
		Return -1
	End If
	
	If li_LINHAS > 0 Then
		ll_id_roteiro 					= ldc.Object.id_parametro 	[1]
		ls_Roteiro_Agendamento 	= ldc.Object.de_parametro 	[1]
		
		If MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data Entrega: " + String(ldt_Agendamento, 'DD/MM/YYYY') + "~rRoteiro: "+ ls_Roteiro_Agendamento + "~r~rConfirma o agendamento ?", Question!, YesNo!, 2 ) = 2 Then
			Return -1	
		End If
				
		ls_Retorno = String(ll_id_roteiro) + '|'+ String(ldt_Agendamento, 'DD/MM/YYYY')
	End If

Else
	If IsNull(ll_id_roteiro) Or ll_id_roteiro = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione um roteiro de entrega.", Exclamation!)
		dw_1.Event ue_Pos(1, "id_parametro")
		Return -1
	End If
	
	lt_Hora_Local = Time( gf_GetServerDate() )
	
	If Not IsNull(lt_Corte) Then
		If lt_Hora_Local >= lt_Corte Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Este roteiro n$$HEX1$$e300$$ENDHEX$$o pode ser selecionado devido ao hor$$HEX1$$e100$$ENDHEX$$rio de corte.", Exclamation!)
			dw_1.Event ue_Pos(1, "id_parametro")
			Return -1
		End If
	End If
	
	If Not IsNull(lt_Saida) Then
		If lt_Hora_Local >= lt_Saida Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Hor$$HEX1$$e100$$ENDHEX$$rio de sa$$HEX1$$ed00$$ENDHEX$$da j$$HEX1$$e100$$ENDHEX$$ ultrapassado. Selecione outro roteiro.", Exclamation!)
			dw_1.Event ue_Pos(1, "id_parametro")
			Return -1
		End If
	End If
	
	If Not IsNull(lt_Termino) Then
		If lt_Hora_Local > lt_Termino Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Este roteiro n$$HEX1$$e300$$ENDHEX$$o pode ser selecionado devido ao hor$$HEX1$$e100$$ENDHEX$$rio de T$$HEX1$$e900$$ENDHEX$$rmino.", Exclamation!)
			dw_1.Event ue_Pos(1, "id_parametro")
			Return -1
		End If
	End If

	If ls_Tipo = 'F' Then //Horario Fixo
		select count(nr_roteiro) 
			into :li_Qt_Usada
		from roteiro_saida
		where dh_saida 			= :ldt_Parametro
			 and id_parametro 	= :ll_id_roteiro 
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_msgdberror( "Erro ao localizar os pedidos do roteiro.")	
			Return -1
		End If
		
		If IsNull(li_Qt_limite) 	Then li_Qt_limite 	= 0
		If IsNull(li_Qt_Usada) Then li_Qt_Usada 	= 0
		
		If li_Qt_limite > 0 Then
			If li_Qt_Usada >= li_Qt_limite Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O roteiro selecionado j$$HEX1$$e100$$ENDHEX$$ atingiu a quantidade limite do entregador.~rSelecione outro roteiro.", Exclamation!)
				Return -1
			End If
		End If
	End If
	
	ls_Retorno = String(ll_Id_Roteiro)	

End If //Agendar


CloseWithReturn(Parent, ls_Retorno)

end event

type gb_2 from groupbox within w_ge108_roteiro_entrega
integer x = 27
integer y = 392
integer width = 2263
integer height = 800
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Par$$HEX1$$e200$$ENDHEX$$metros"
end type

type dw_1 from dc_uo_dw_base within w_ge108_roteiro_entrega
integer x = 55
integer y = 96
integer width = 2208
integer height = 252
integer taborder = 20
string dataobject = "dw_ge108_selecao_roteiro"
end type

event ue_populate_dddw;call super::ue_populate_dddw;String ls_Dia_Entrega

DateTime ldh_Servidor

SetPointer(HourGlass!)

ldh_Servidor = gf_GetServerDate()

dw_1.Object.dh_servidor[1] = ldh_Servidor

/*dias entrega
1-segunda a sexta
2-sabado
3-domingo
*/
Choose Case DayNumber ( date(ldh_Servidor) )
	Case 1 //Domingo
		ls_Dia_entrega = '3'
	Case 7 //Sabado
		ls_Dia_entrega = '2'
	Case Else //Dias de semana
		ls_Dia_entrega = '1'
End Choose

pdwc_dddw.SetTransObject(SqlCa)

If ps_Coluna = "id_parametro" Then
	pdwc_dddw.Retrieve(ls_Dia_Entrega)
Else
	pdwc_dddw.Retrieve()
End If

SetPointer(Arrow!)
end event

event itemchanged;call super::itemchanged;Integer li_Cod

Date ldt_Agendamento

Choose Case dwo.Name
	Case 'id_parametro'
		li_Cod = Integer( Data )
		
		dw_2.Retrieve(li_Cod)
		
	Case 'id_agendar'
		ldt_Agendamento = Date(gvo_Parametro.dh_movimentacao )
		This.Object.dh_agendamento [1] = RelativeDate(ldt_Agendamento, 1)
		
		If Data = 'S' Then 
			dw_2.Visible = False
			st_mensagem.visible = True
			
		Else
			dw_2.Visible = True
			st_mensagem.visible = False
		End If
		
		This.AcceptText()
End Choose
end event

type gb_1 from groupbox within w_ge108_roteiro_entrega
integer x = 23
integer y = 24
integer width = 2263
integer height = 348
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Roteiro"
end type

type dw_2 from dc_uo_dw_base within w_ge108_roteiro_entrega
integer x = 73
integer y = 472
integer width = 2190
integer height = 680
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge108_lista_roteiro"
end type

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
//	Select Count(nr_roteiro)
//	 from roteiro_saida
//	 	where dh_saida	  	= :ldt_Saida
//		  and id_parametro	= :li_Parametro
//	Using SqlCa;
//	
//	If SqlCa.of_Code = -1 Then
//		SqlCa.of_msgdberror( "Erro ao localizar a qtde. dispon$$HEX1$$ed00$$ENDHEX$$vel no roteiro.")
//	End If
End If

//This.Object.nr

Return pl_Linhas
end event

type st_1 from statictext within w_ge108_roteiro_entrega
integer x = 128
integer y = 436
integer width = 2130
integer height = 436
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_mensagem from statictext within w_ge108_roteiro_entrega
boolean visible = false
integer x = 96
integer y = 512
integer width = 2153
integer height = 264
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "Ser$$HEX1$$e100$$ENDHEX$$ utilizado o primeiro roteiro dispon$$HEX1$$ed00$$ENDHEX$$vel no dia do agendamento"
alignment alignment = center!
boolean focusrectangle = false
end type

