HA$PBExportHeader$w_ge108_consulta_reserva.srw
forward
global type w_ge108_consulta_reserva from dc_w_response_ok_cancela
end type
type dw_3 from dc_uo_dw_base within w_ge108_consulta_reserva
end type
type gb_3 from groupbox within w_ge108_consulta_reserva
end type
type dw_2 from dc_uo_dw_base within w_ge108_consulta_reserva
end type
type gb_2 from groupbox within w_ge108_consulta_reserva
end type
end forward

global type w_ge108_consulta_reserva from dc_w_response_ok_cancela
integer width = 2789
integer height = 1580
string title = "GE108 - Consulta Reserva de Produto"
dw_3 dw_3
gb_3 gb_3
dw_2 dw_2
gb_2 gb_2
end type
global w_ge108_consulta_reserva w_ge108_consulta_reserva

type variables
uo_Cliente io_Cliente

//Aux
String is_Cliente_Aux
end variables

forward prototypes
public function boolean wf_cancela_matriz_ped_empurrado (long al_sequencial, string as_matric_cancelamento)
end prototypes

public function boolean wf_cancela_matriz_ped_empurrado (long al_sequencial, string as_matric_cancelamento);Long ll_Linha
Long ll_Linhas
Long ll_Pedido
Long ll_Produto

Try

	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_rl076_lista_produto_empurrado") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no change da ds 'ds_rl076_lista_produto_empurrado'.", StopSign!)
		Return False
	End If
	
	ll_Linhas = lds.Retrieve(gvo_Parametro.Cd_Filial, al_Sequencial)
	
	If ll_Linhas < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da ds 'ds_rl076_lista_produto_empurrado'.", StopSign!)
		Return False
	End If
	
	If ll_Linhas = 0 Then
		//N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ pedido urgente/empurrado para o CD
		Return True
	End If	
		
	uo_ge108_reserva_produtos lo_Reserva
	lo_Reserva = Create uo_ge108_reserva_produtos
	
	For ll_Linha = 1 To lds.RowCount()
		ll_Pedido		= lds.Object.Nr_Pedido_Empurrado	[ll_Linha]
		ll_Produto	= lds.Object.Cd_Produto					[ll_Linha]
		
		If Not lo_Reserva.of_atualiza_ped_urgente_matriz( ll_Pedido, "X", ll_Produto, 0, as_Matric_Cancelamento) Then Return False	
	Next
	
	Return True
	
Finally
	If IsValid(lds) Then Destroy(lds)
	If IsValid(lo_Reserva) Then Destroy(lo_Reserva)
End Try
end function

on w_ge108_consulta_reserva.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.gb_3=create gb_3
this.dw_2=create dw_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.gb_2
end on

on w_ge108_consulta_reserva.destroy
call super::destroy
destroy(this.dw_3)
destroy(this.gb_3)
destroy(this.dw_2)
destroy(this.gb_2)
end on

event ue_postopen;call super::ue_postopen;Date ldt_Parametro

io_Cliente	= Create uo_Cliente

If Not IsNull( is_Cliente_Aux ) And is_Cliente_Aux <> "" Then
	io_Cliente.of_localiza_codigo( is_Cliente_Aux )
	
	If io_Cliente.Localizado Then
		dw_1.Object.Nm_Cliente	[ 1 ] = io_Cliente.Nm_Cliente
		dw_1.Object.Cd_Cliente	[ 1 ] = io_Cliente.Cd_Cliente
		
		dw_1.Object.nm_cliente.Protect = 1
		//If rgb( 220,220,220)	
		dw_1.Modify("nm_cliente.Background.Color='14474460'")
		
		cb_Ok.visible = True
		
		dw_2.Event ue_Retrieve()
		
		dw_2.SetFocus()
	End If
End If

pb_Help.visible = True
end event

event close;call super::close;If IsValid( io_Cliente ) 	Then Destroy io_Cliente
end event

event ue_preopen;call super::ue_preopen;is_Cliente_Aux = Message.StringParm


end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge108_consulta_reserva
integer x = 27
integer y = 1364
end type

event pb_help::clicked;call super::clicked;wf_Help( "Buscar Reservas (GE108)" )
end event

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge108_consulta_reserva
integer width = 2331
integer height = 172
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge108_consulta_reserva
integer x = 69
integer y = 64
integer width = 2254
integer height = 76
string dataobject = "dw_ge108_selecao_busca_reserva"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_cliente"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Trim(Data) <> io_Cliente.Nm_Cliente Then
				Return 1
			End If
		Else
			io_Cliente.Of_Inicializa()
			
			This.Object.cd_cliente	[1] = io_Cliente.Cd_cliente
			This.Object.nm_cliente	[1] = io_Cliente.Nm_Cliente
		End If
		
End Choose
end event

event dw_1::ue_key;call super::ue_key;String ls_Localizacao

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()			
		Case "nm_cliente"
			ls_Localizacao = dw_1.GetText() 
			
			If LenA( ls_Localizacao ) = 11 And IsNumber( ls_Localizacao ) Then
				io_Cliente.of_Localiza_Cpf( ls_Localizacao )
			Else		
				io_Cliente.of_Localiza_Cliente( ls_Localizacao )
			End If
			
			If io_Cliente.Localizado Then
				This.Object.Cd_cliente		[1] = io_Cliente.Cd_Cliente
				This.Object.Nm_Cliente		[1] = io_Cliente.Nm_Cliente
			End If
			
	End Choose
	
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Reset()
dw_3.Reset()
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge108_consulta_reserva
boolean visible = false
integer x = 1838
integer y = 1376
integer width = 585
string text = "&Concluir Reserva"
end type

event cb_ok::clicked;call super::clicked;Long ll_Row, ll_Linhas
Long ll_Produto
Long ll_Qtde
Long ll_Sequencial_Cliente_Caixa

Try
	dw_3.SetSort("")
	dw_3.Sort()
	dw_3.SetSort( "de_produto, id_ordem desc" )
	dw_3.Sort()
	dw_3.AcceptText()
	
	dw_1.AcceptText()
	dw_2.AcceptText()
	
	If dw_2.RowCount() = 0 Then
		Return -1
	End If
	
	If dw_2.Object.id_situacao[ dw_2.GetRow() ] = 'X' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Reserva cancelada.")
		Return -1
	End If
	
	ll_Linhas = dw_3.RowCount()
	
	uo_ge108_reserva_produtos lo_Reserva
	lo_Reserva = Create uo_ge108_reserva_produtos
	
	lo_Reserva.il_Sequencial_Cliente_caixa 	= dw_2.Object.nr_sequencial				[ dw_2.GetRow() ] 
	lo_Reserva.is_Vendedor						= dw_2.Object.nr_matricula_vendedor	[ dw_2.GetRow() ]

	
	For ll_Row = 1 To ll_Linhas
		lo_Reserva.il_Produtos		[ ll_Row ] = dw_3.Object.cd_produto					[ ll_Row ]  
		lo_Reserva.il_Qtdes			[ ll_Row ] = dw_3.Object.qt_produto					[ ll_Row ]
		lo_Reserva.il_Seq				[ ll_Row ] = dw_3.Object.nr_sequencial				[ ll_Row ]
		lo_Reserva.il_Filial_transf 	[ ll_Row ] = dw_3.Object.cd_filial_transferencia	[ ll_Row ]
	Next
	
	If UpperBound( lo_Reserva.il_Produtos[ ] ) = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum produto selecionado.")
		If IsValid( lo_Reserva ) Then Destroy lo_Reserva
		Return -1
	End If
	
	CloseWithReturn(Parent, lo_Reserva)	
	
Finally
	
End Try

end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge108_consulta_reserva
integer x = 2441
integer y = 1376
string text = "&Sair"
end type

type dw_3 from dc_uo_dw_base within w_ge108_consulta_reserva
integer x = 59
integer y = 792
integer width = 2670
integer height = 544
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge108_produtos_reserva"
boolean vscrollbar = true
end type

event ue_recuperar;//OverRide

long ll_Row

dw_2.acceptText()

If dw_2.RowCount() > 0 Then 
	ll_Row = dw_2.getRow()
	
	Return This.Retrieve( dw_2.Object.nr_sequencial [ ll_Row ] )
End If


end event

event constructor;call super::constructor;This.of_SetRowSelection( )
end event

type gb_3 from groupbox within w_ge108_consulta_reserva
integer x = 27
integer y = 732
integer width = 2725
integer height = 624
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos"
borderstyle borderstyle = styleraised!
end type

type dw_2 from dc_uo_dw_base within w_ge108_consulta_reserva
integer x = 55
integer y = 244
integer width = 2674
integer height = 452
integer taborder = 20
string dataobject = "dw_ge108_lista_reserva_cliente"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection( " if (id_situacao = ~"X~", rgb(255, 0, 0), " + This.ivs_Cor_Linha_Padrao + ")", "", False )
end event

event ue_recuperar;//OverRide

String ls_Cliente, ls_Vigencia, ls_Cancelado, ls_in

Date ldt_Inicio, ldt_Termino

Try
	dw_1.AcceptText()
	
	ls_Cliente		= dw_1.Object.cd_cliente		[ 1 ]
//	ldt_Inicio 		= dw_1.Object.dh_inicio			[ 1 ]
//	ldt_Termino		= dw_1.Object.dh_termino		[ 1 ]
//	ls_Vigencia		= dw_1.Object.id_situacao		[ 1 ]	
//	ls_Cancelado 	= dw_1.Object.id_cancelado	[ 1 ]
	
	If IsNull(ls_Cliente) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um cliente.", Exclamation!)
		dw_1.Event ue_Pos(1,"nm_cliente")
		Return -1
	End If
	
//	If IsNull(ldt_Inicio) or Not IsDate(String(ldt_Inicio)) Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Information!)
//		dw_1.Event ue_Pos(1, "dh_inicio")
//		Return -1
//	End If
//	
//	If IsNull(ldt_Termino) or Not IsDate(String(ldt_Termino)) Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Information!)
//		dw_1.Event ue_Pos(1, "dh_termino")	
//		Return -1
//	End If
//	
//	If ldt_Inicio > ldt_Termino Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Information!)
//		dw_1.Event ue_Pos(1, "dh_termino")	
//		Return -1
//	End If
		

	//--------------
//	ls_in = " 'R' "
//
//	If ls_Cancelado = 'S' Then
//		ls_in = " 'R', 'X' "		
//	End If
//	
//	This.of_appendwhere( "id_situacao in (" + ls_in + ")" )
//	
//	Choose Case ls_Vigencia
//		Case 'S' //Vigente
//			This.of_appendwhere( "dh_inicio_reserva <= dbo.uf_dh_parametro() and dbo.uf_dh_parametro() <= dh_termino_reserva" )
//			
//		Case 'N' //Nao vigente
//			This.of_appendwhere( "dbo.uf_dh_parametro() > dh_termino_reserva" )
//			
//	End Choose
	
	Return This.Retrieve( ls_Cliente )
Finally
End Try
end event

event rowfocuschanged;call super::rowfocuschanged;If currentRow > 0 Then
	If currentRow <= This.RowCount() Then	
		dw_3.Reset()
		dw_3.Event ue_Retrieve( )
	Else
		Return -1
	End If
End If
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas = 0 Then
	dw_3.Reset()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
End If

Return pl_linhas
end event

event clicked;call super::clicked;Long ll_Sequencial

String ls_Justificativa
String ls_Cliente
String ls_Matric_Cancelamento

Date ldt_Reserva

If row > 0 Then
	If dwo.Name = 'bt_cancelar' Then
		ll_Sequencial 	= This.Object.nr_sequencial		[ row ]
		ls_Cliente		= This.Object.nm_responsavel	[ row ]
		ldt_Reserva		= This.Object.dh_reserva		[ row ]
		
		If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("CANCELAR_RESERVA", Ref ls_Matric_Cancelamento) Then 
			Return
		End If
		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja cancelar a reserva do cliente " + ls_Cliente + " ?" +&
											"~rData: " + String(ldt_Reserva, 'DD/MM/YYYY') , Question!,YesNo!, 2 ) = 1 Then
			
			OpenWithParm( w_justificativa, "05Informe o motivo do cancelamento:" )
			
			ls_Justificativa = Message.StringParm
			
			If IsNUll( ls_Justificativa ) Then
				Return -1	
			End If
			
			Update	cliente_caixa set id_situacao 		= 'X', 
						de_motivo_desistencia 				= :ls_Justificativa,
						nr_matric_cancelamento_reserva	= :ls_Matric_Cancelamento
				Where nr_sequencial 							= :ll_Sequencial
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_Rollback( )
					SqlCa.of_MsgDbError("Erro ao cancelar a reserva de n$$HEX1$$fa00$$ENDHEX$$mero " + String( ll_Sequencial ) )
					Return -1
				End If
				
				SqlCa.of_Commit()
				
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Reserva cancelada com sucesso.")
				
				wf_Cancela_Matriz_Ped_Empurrado(ll_Sequencial, ls_Matric_Cancelamento)
				
				dw_2.Event ue_retrieve()
				dw_3.Event ue_retrieve()
				Return -1
		End If
	End If
End If
end event

type gb_2 from groupbox within w_ge108_consulta_reserva
integer x = 23
integer y = 192
integer width = 2729
integer height = 524
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Reserva"
borderstyle borderstyle = styleraised!
end type

