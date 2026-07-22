HA$PBExportHeader$w_ge107_consulta_saldo_matriz_response.srw
forward
global type w_ge107_consulta_saldo_matriz_response from dc_w_response
end type
type gb_2 from groupbox within w_ge107_consulta_saldo_matriz_response
end type
type gb_1 from groupbox within w_ge107_consulta_saldo_matriz_response
end type
type dw_1 from dc_uo_dw_base within w_ge107_consulta_saldo_matriz_response
end type
type dw_2 from dc_uo_dw_base within w_ge107_consulta_saldo_matriz_response
end type
type cb_1 from commandbutton within w_ge107_consulta_saldo_matriz_response
end type
type cb_2 from commandbutton within w_ge107_consulta_saldo_matriz_response
end type
type cb_reserva_produto from commandbutton within w_ge107_consulta_saldo_matriz_response
end type
end forward

global type w_ge107_consulta_saldo_matriz_response from dc_w_response
integer width = 2725
integer height = 1732
string title = "GE107 - Consulta de Estoque de Outras Filiais"
boolean controlmenu = false
long backcolor = 80269524
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
cb_1 cb_1
cb_2 cb_2
cb_reserva_produto cb_reserva_produto
end type
global w_ge107_consulta_saldo_matriz_response w_ge107_consulta_saldo_matriz_response

type variables
uo_produto ivo_produto 

uo_filial ivo_filial 

uo_ge108_parametros io_Parametros

String ivs_nr_ddd_telefone_estoque, &
          ivs_nr_telefone_estoque
			
String is_Matricula_Vendedor
			 
Long il_Produto

Long il_Qtde_Solicitada

Long il_FIlial_Reserva



end variables

forward prototypes
public subroutine wf_ordena_filiais ()
end prototypes

public subroutine wf_ordena_filiais ();Long ll_Filial
Long ll_Linha
Long ll_Cidade
Long ll_Find = 0
Long ll_Produto
Long ll_Saldo

ll_Filial = gvo_Parametro.of_Filial()

If Not ivo_Filial.Localizada Then
	
	// Faz a ordenacao definida pela tabela estoque_outras_filiais_ordenacao
	DECLARE lcu_filial CURSOR FOR
	SELECT cd_filial_destino, COALESCE( nr_ordem, 9999 ) as nr_ordem 
	FROM estoque_outras_filiais_ordenacao 
	WHERE cd_filial = :ll_Filial;
	
	// Declara$$HEX2$$e700e300$$ENDHEX$$o vari$$HEX1$$e100$$ENDHEX$$veis de destino
	Long ll_Filial_Ordenacao
	Long ll_Ordem
	
	// Abrindo o cursor
	OPEN lcu_filial;
	
	// Buscar a primeira linha do resultado
	FETCH lcu_filial INTO :ll_Filial_Ordenacao, :ll_Ordem;
	
	// Repetir Enquanto Houver Linhas
	DO WHILE SQLCA.sqlcode = 0
		ll_Find = dw_2.Find( "cd_filial = " + String( ll_Filial_Ordenacao ), 1, dw_2.RowCount( ) )
		
		If ll_Find > 0 Then
			dw_2.Object.Cd_Ordem[ ll_Find ] = ll_Ordem
		End If
		
		//Busca pr$$HEX1$$f300$$ENDHEX$$ximo valor
		FETCH lcu_filial INTO :ll_Filial_Ordenacao, :ll_Ordem;
	LOOP
	
	// No fim fechar o cursor
	CLOSE lcu_filial;
	//  Termino da ordenacao definida pela tabela estoque_outras_filiais_ordenacao

End If

// Ordena as filiais que nao foram definidas na tabela estoque_outras_filiais_ordenacao e que sao da mesma cidade da filial que esta consultando
SELECT cd_cidade
INTO :ll_Cidade
FROM filial
WHERE cd_filial = :ll_Filial
USING SQLCa;
 
 If SQLCa.Sqlcode = -1 Then
	SQLCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da cidade da filial '" + String(ll_Cidade) + "'")
 ElseIf SQLCa.Sqlcode = 100 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cidade da filial '" + String(ll_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o localizada.")
	Return	
 End If

For ll_Linha = 1 To dw_2.RowCount( )
	If dw_2.Object.Cd_Cidade[ ll_Linha ] = ll_Cidade And dw_2.Object.Cd_Ordem[ ll_Linha ] = 9999 Then
		dw_2.Object.Cd_Ordem[ ll_Linha ] = 9998
	End If
	
	// Esconde a filial 534 para filiais que n$$HEX1$$e300$$ENDHEX$$o s$$HEX1$$e300$$ENDHEX$$o da Bahia e o produto $$HEX1$$e900$$ENDHEX$$ exclusivo para abastecimento das filiais da Bahia pelo Perini
	/*
	If dw_2.Object.cd_Filial[ ll_Linha ] = 534 Then
		uo_Transacao_Remota lo_Conexao
		lo_Conexao = Create uo_Transacao_Remota
		
		lo_Conexao.of_BancoProducao()
		
		lo_Conexao.of_Define_Variaveis(True)
		
		ll_Produto = dw_1.Object.Cd_Produto[1]
	
		lo_Conexao.of_Executa_Rotina("0006",{"SELECT dbo.saldo_atual_estoque_central( " + String( ll_Filial ) + ", " + String( ll_Produto ) + ", 'S' ) as qt_saldo"})
		
		If lo_Conexao.of_Erro_Execucao() Or lo_Conexao.of_Erro_Conexao() Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na consulta do saldo online do produto " + String( ll_Produto ), StopSign!)	
			ll_Saldo = 0
		Else
			If lo_Conexao.of_Linhas() > 0 Then
				If lo_Conexao.of_Retorno("qt_saldo", Ref ll_Saldo) Then
					If IsNull(ll_Saldo) Then ll_Saldo = 0
				End If
			Else
				ll_Saldo = 0
			End If
		End If
		
		Destroy(lo_Conexao)
		
		dw_2.Object.qt_Saldo_Final[ ll_Linha ] = ll_Saldo
	End If
	*/
Next
// Termino da ordenacao pela cidade

dw_2.GroupCalc()
dw_2.Sort()
end subroutine

on w_ge107_consulta_saldo_matriz_response.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_reserva_produto=create cb_reserva_produto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_reserva_produto
end on

on w_ge107_consulta_saldo_matriz_response.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_reserva_produto)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()

ivo_Produto = Create uo_Produto
ivo_Filial  = Create uo_Filial

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

If Not lvo_Parametro.of_Localiza_Parametro("NR_DDD_TELEFONE_ESTOQUE_CENTRAL", ref ivs_Nr_DDD_Telefone_Estoque) Then
	ivs_Nr_DDD_Telefone_Estoque = ''
End If
	
If Not lvo_Parametro.of_Localiza_Parametro("NR_TELEFONE_ESTOQUE_CENTRAL", ref ivs_Nr_Telefone_Estoque) Then
	ivs_Nr_Telefone_Estoque = ''
End If

If il_Produto > 0 Then
	dw_1.Object.cd_produto[1] = il_Produto
	
	ivo_Produto.of_Localiza_Codigo_Interno(il_Produto)
	
	If ivo_Produto.Localizado Then
		dw_1.Object.de_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
	End If

	dw_1.Object.de_Produto.protect = 1
	
	dw_2.Event ue_Recuperar()
End If

dw_2.SetFocus()

Destroy(lvo_Parametro)
end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Filial)
end event

event ue_preopen;call super::ue_preopen;io_Parametros = Message.PowerObjectParm

This.cb_reserva_produto.Visible = ( io_Parametros.habilita_botao_reserva_ge107 )

is_Matricula_Vendedor 	= io_Parametros.matricula_vendedor
il_Produto 					= io_Parametros.produto
il_Qtde_Solicitada			= io_Parametros.qtde_solicitada
il_FIlial_Reserva			= io_Parametros.Filial


//If IsValid( lo ) Then Destroy lo
/*
String ls_Parametro, ls_Reserva

ls_Parametro = Message.StringParm

ls_Reserva = MID( ls_Parametro, 1,1 )

If ls_Reserva = "" Then ls_Reserva = 'N'

This.cb_reserva_produto.Visible = ( ls_Reserva = 'S' )

is_Matricula_Vendedor = MID(ls_Parametro, 2, 6 )

il_Produto = Long( MID(ls_Parametro, 2) )

*/
end event

type pb_help from dc_w_response`pb_help within w_ge107_consulta_saldo_matriz_response
end type

type gb_2 from groupbox within w_ge107_consulta_saldo_matriz_response
integer x = 27
integer y = 268
integer width = 2679
integer height = 1224
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Lista de Filiais"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ge107_consulta_saldo_matriz_response
integer x = 27
integer y = 4
integer width = 1751
integer height = 252
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge107_consulta_saldo_matriz_response
integer x = 59
integer y = 56
integer width = 1705
integer height = 184
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge107_selecao_consulta_saldo"
end type

event itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

Choose Case dwo.name
	Case "nm_fantasia"
		If Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_Fantasia Then
				Return 1
			End If	
		Else			
			ivo_Filial.of_inicializa()
			
			This.Object.Cd_Filial  		[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Fantasia	[1] = ivo_Filial.Nm_Fantasia			
		End If
End Choose
end event

event ue_key;String lvs_Coluna

lvs_Coluna = This.GetColumnName()

If Key = KeyEnter! Then
	
	Choose Case lvs_Coluna
		Case "de_produto"
			
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				dw_1.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
			End If
			
		Case "nm_fantasia"
			
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				
				If ivo_Filial.Cd_Filial <> gvo_Parametro.Cd_Filial Then
					dw_1.Object.Cd_Filial  		[1] = ivo_Filial.Cd_Filial
					dw_1.Object.Nm_Fantasia	[1] = ivo_Filial.Nm_Fantasia
				End If
			End If
	End Choose
End If
end event

event editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

event constructor;call super::constructor;of_SetColSelection(True)
end event

type dw_2 from dc_uo_dw_base within w_ge107_consulta_saldo_matriz_response
integer x = 64
integer y = 320
integer width = 2619
integer height = 1152
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge107_lista_consulta_saldo"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_postretrieve;Integer lvi_Find

If pl_Linhas > 0 Then
	lvi_Find = dw_2.Find("cd_filial = " + String(gvo_Parametro.of_Filial_Matriz()), 1, dw_2.RowCount())
	
	If lvi_Find > 0 Then
		dw_2.Object.nr_ddd     [lvi_Find] = ivs_Nr_DDD_Telefone_Estoque
		dw_2.Object.nr_telefone[lvi_Find] = ivs_Nr_Telefone_Estoque
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
End If

Return pl_Linhas
end event

event ue_recuperar;// OverRide

Long lvl_Produto
Long lvl_Filial
Long lvl_Retorno = -1

String ls_Sql
String lvs_Retorno

Try
	This.SetRedraw(False)
	
	This.Event ue_Reset()
	dw_1.AcceptText()
	
	lvl_Filial		= dw_1.Object.Cd_Filial [1]
	lvl_Produto	= dw_1.Object.Cd_Produto[1]
	
	If IsNull(lvl_Produto) or lvl_Produto = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o produto para consulta.", Information!)
		dw_1.Event ue_Pos(1, "de_produto")
		Return -1	
	End If
	
	This.of_AppendWhere_Subquery("v.cd_produto = " + String(lvl_Produto), 5)
	This.of_AppendWhere_Subquery("(c.cd_unidade_federacao = '" + Upper(gvo_Parametro.ivs_UF_Filial) + "'" + " or v.cd_filial = 534)",5)
	
	If Not IsNull( lvl_Filial ) Then
		This.of_AppendWhere_Subquery( "v.cd_filial = " + String( lvl_Filial ), 5 )
	End If
	
	uo_Transacao_Remota lvo_Conexao
	lvo_Conexao = Create uo_Transacao_Remota
	
	lvo_Conexao.of_BancoProducao()
	
	ls_Sql = This.GetSQLSelect()
	ls_Sql = gf_Replace( ls_Sql, ":filial_parametro", String( gvo_parametro.cd_filial ), 0 )
	
	lvo_Conexao.of_Retrieve( ls_Sql, Ref lvs_Retorno)
	
	If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.")
		lvl_Retorno = 0
	Else
		If IsNull( lvs_Retorno ) Or Trim( lvs_Retorno ) = '' Then
			lvl_Retorno = 0
		Else
			lvl_Retorno = This.ImportString( lvs_Retorno )
			
			If lvl_Retorno >= 0 Then
				lvl_Retorno = This.RowCount()
				
				If lvl_Retorno >= 0 Then
					wf_Ordena_Filiais()
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar os dados das filiais.")
				End If
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar os dados do servidor distribu$$HEX1$$ed00$$ENDHEX$$do.")
			End If
		End If
	End If
	
	This.VScrollBar = True
	
	Return lvl_Retorno
	
Finally
	x = 64
	y = 320
	
	Destroy(lvo_Conexao)
	This.SetRedraw(True)
	cb_1.Enabled = True
End Try

end event

type cb_1 from commandbutton within w_ge107_consulta_saldo_matriz_response
integer x = 1961
integer y = 1516
integer width = 347
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Recuperar"
end type

event clicked;dw_2.Event ue_Retrieve()
end event

type cb_2 from commandbutton within w_ge107_consulta_saldo_matriz_response
integer x = 2331
integer y = 1516
integer width = 347
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Fechar"
boolean cancel = true
end type

event clicked;String ls_Null

SetNull( ls_Null )
io_Parametros.Retorno = ls_Null

CloseWithReturn(Parent, io_Parametros)
end event

type cb_reserva_produto from commandbutton within w_ge107_consulta_saldo_matriz_response
boolean visible = false
integer x = 37
integer y = 1516
integer width = 503
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Reservar Produto"
end type

event clicked;Long ll_Filial
Long ll_Produto

String ls_Fantasia
String ls_Retorno
String ls_Matricula

dw_1.AcceptText( )
dw_2.AcceptText( )

Try

	If dw_2.RowCount( ) = 0 Then Return -1
	
	If IsNull( io_Parametros.Cliente ) Then
		MessageBox( "Reserva de produto", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio ter um cliente identificado.", Exclamation! )
		Return -1
	End If	
	
	ll_Produto	= dw_1.Object.cd_produto	[ 1 ]
	ll_Filial 		= dw_2.Object.cd_filial		[ dw_2.GetRow() ]
	ls_Fantasia 	= dw_2.Object.nm_fantasia	[ dw_2.GetRow() ]
	
	If il_FIlial_Reserva = 534 And ( il_FIlial_Reserva <> ll_Filial ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","J$$HEX1$$e100$$ENDHEX$$ existe um pedido urgente pr$$HEX1$$e900$$ENDHEX$$-reservado no CD.", Exclamation!)
		Return -1
	End If
		
//	uo_ge108_parametros lo
//	lo = Create uo_ge108_parametros
	
	//lo.matricula_resp_reserva	= ls_Matricula_Resp_Reserva
	//lo.Pedido_Empurrado		= ll_Pedido_Empurrado
	
	io_Parametros.filial 							= ll_Filial
	io_Parametros.produto 						= ll_Produto
	io_Parametros.matricula_vendedor		= is_Matricula_Vendedor
	io_Parametros.Qtde_solicitada				= il_Qtde_Solicitada
		
	OpenWithParm(w_ge108_transferencia_para_reserva, io_Parametros)
		
	io_Parametros = Message.PowerObjectParm
			
	If IsNull(io_Parametros.Retorno)  Then 
		Return -1
	Else
		ll_Filial 		= io_Parametros.filial
		ls_Matricula = io_Parametros.matricula_resp_reserva
				
		CloseWithReturn( Parent, io_Parametros )
	End If

Finally
	//If IsValid(lo) Then Destroy lo
End Try
		
	//FILIAL + Produto = 0000+00000181...
//	ls_Parametro = String(ll_Filial, "0000") + String(ll_Produto, "00000000")		
	
//	OpenWithParm(w_ge108_transferencia_para_reserva, ls_Parametro)
//	ls_Retorno = Message.StringParm 
//	
//	If IsNull( ls_Retorno ) Then Return -1
//	
//	ls_Usuario_Transf = Mid( ls_Retorno, 5 )
//	
//	If IsNull( ls_Usuario_Transf ) Then ls_Usuario_Transf = ""
//	
//	ls_Retorno = String( ll_Filial, "0000" ) + ls_Usuario_Transf
	
	//CloseWithReturn( Parent, lo )
	
	
end event

