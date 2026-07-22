HA$PBExportHeader$w_ge108_produto_favorito.srw
forward
global type w_ge108_produto_favorito from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge108_produto_favorito
end type
type cb_consultar from commandbutton within w_ge108_produto_favorito
end type
type gb_produtos from groupbox within w_ge108_produto_favorito
end type
end forward

global type w_ge108_produto_favorito from dc_w_response_ok_cancela
integer width = 2533
integer height = 1320
string title = "GE108 - Produtos Favoritos"
boolean controlmenu = true
dw_2 dw_2
cb_consultar cb_consultar
gb_produtos gb_produtos
end type
global w_ge108_produto_favorito w_ge108_produto_favorito

type variables
String  is_Cliente, is_Parametro, is_Produtos_Excluidos, is_Matricula

Long il_Produto

Boolean ib_Relatorio = False

uo_Transacao_Remota io_Conexao

uo_cliente io_Cliente
end variables

forward prototypes
public function boolean wf_importa_distribuido ()
public function boolean wf_atualiza_distribuido (string as_tipo_atualizacao, long al_produto, string as_situacao)
public function boolean wf_verifica_situacao_distribuido (ref string as_situacao_matriz)
end prototypes

public function boolean wf_importa_distribuido ();String ls_Retorno, ls_Situacao_Matriz

Long ll_Retrieve

Try
	dw_2.SetRedRaw(False)
	dc_uo_ds_base lo_produtos
	lo_Produtos = Create dc_uo_ds_base
	
	If Not lo_Produtos.of_changedataobject( "dw_ge108_lista_favorito" ) Then 
		Return False
	End If
	lo_Produtos.of_appendwhere( "c.cd_cliente = '" + String( io_Cliente.cd_cliente ) + "'")
	
	//Se for consulta via tela de atendimento compara o produto passado por par$$HEX1$$e200$$ENDHEX$$metro
	If Not ib_Relatorio Then
		//Verifica se o produto j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ marcado como favorito
		If Not wf_Verifica_Situacao_Distribuido(Ref ls_Situacao_Matriz) Then
			Return False
		End If
		
		//Atualiza / Insere o produto favorito na matriz		
		If IsNull( ls_Situacao_Matriz ) Then
			//Insert
			If Not wf_Atualiza_Distribuido('insert', il_Produto, 'A') Then
				Return False
			End If
		Else
			//Update
			If ls_Situacao_Matriz <> 'A' Then
				If Not wf_Atualiza_Distribuido('update', il_Produto, 'A') Then
					Return False
				End If
			End If
		End If	
	End If
	
	io_Conexao.of_define_variaveis( False )
	io_Conexao.of_Retrieve( lo_Produtos.GetSQLSelect(), Ref ls_Retorno )

	If io_Conexao.of_Erro_Execucao() Or io_Conexao.of_Erro_Conexao() Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.")
		Return False
	End If
	
	dw_2.Reset( )
	ll_Retrieve = dw_2.ImportString( ls_Retorno )
	dw_2.SetSort( "de_produto asc")
	dw_2.Sort()
	ll_Retrieve = dw_2.Find("cd_produto=" +String(il_Produto),1, dw_2.RowCount())
	
	If ll_Retrieve > 0 Then
		dw_2.Event ue_Pos(ll_Retrieve, "cd_produto")	
	End If
	
	dw_2.SetRedRaw(True)
	
	If dw_2.RowCount() = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum produto favorito localizado para o cliente.", Exclamation!)
	End if
	
	Return True
	
Finally
	If IsValid(lo_Produtos) 	Then Destroy lo_Produtos
End Try
end function

public function boolean wf_atualiza_distribuido (string as_tipo_atualizacao, long al_produto, string as_situacao);String ls_Tabela, ls_Colunas, ls_Values, ls_Set, ls_Where

String ls_Cliente

Long ll_Retorno

as_tipo_atualizacao = UPPER(as_tipo_atualizacao)

dw_1.AcceptText()

ls_Cliente = dw_1.Object.cd_cliente[1]

If IsNull(ls_Cliente) Or Trim(ls_Cliente)='' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione um cliente.",Exclamation!)
	Return False
End If

ls_Tabela = 'produto_favorito_cliente'

If as_tipo_atualizacao = 'INSERT' Then
	ls_Colunas = 'cd_cliente,cd_produto,id_situacao,cd_filial_inclusao,nr_matricula_inclusao,dh_inclusao'
	ls_Values	= "'" + ls_Cliente + "'," + String(al_Produto) + ", '" + as_situacao + "'" +&
				"," +String(gvo_Parametro.Cd_Filial) + ",'" +is_Matricula + "', getdate() "
					  
	If Not io_Conexao.of_Insert_Registro(ls_Tabela,ls_Colunas,ls_Values, Ref ll_Retorno) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na inclus$$HEX1$$e300$$ENDHEX$$o do produto_favorito_cliente '" + String(al_Produto) + "/"+ls_Cliente+"'.")
		Return False
	End If	
	
Else //Update
	ls_Set		 = "id_situacao='" + as_Situacao +"', cd_filial_alteracao=" + String(gvo_Parametro.Cd_Filial) + ", nr_matricula_alteracao='" +is_Matricula + "',dh_alteracao=getdate() "
	
	//Atualizado na exclusao dos produtos favoritos
	If Not IsNull(is_Produtos_Excluidos) And Trim(is_Produtos_Excluidos) <> '' Then
		ls_Where = "cd_produto in (" +is_Produtos_Excluidos+ ") and cd_cliente = '" + ls_Cliente + "'"
	Else
		ls_Where = "cd_produto=" +String(al_produto)+ " and cd_cliente = '" + ls_Cliente + "'"
	End If
	
	If Not io_Conexao.of_Update_Registro(ls_Tabela, ls_Set , ls_Where, Ref ll_Retorno) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do produto_favorito_cliente '" + String(al_Produto) + "/"+ls_Cliente+"'.")
		Return False
	End If	
	
End If//Fim update

Return True
end function

public function boolean wf_verifica_situacao_distribuido (ref string as_situacao_matriz);//Verifica se o produto j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ marcado como favorito

SetNull(as_situacao_matriz)

io_Conexao.of_define_variaveis( True )
io_Conexao.of_Executa_Rotina("0006",{ "select id_situacao from produto_favorito_cliente where cd_produto = " + String(il_Produto) + " and cd_cliente = '" + io_Cliente.cd_Cliente + "'" } )
	
If io_Conexao.of_Erro_Execucao() Or io_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do produto_favorito_cliente. " + String(il_Produto) + " and cd_cliente = " +  io_Cliente.cd_Cliente, StopSign!)
	Return False
Else
	If io_Conexao.of_Linhas() > 0 Then
		io_Conexao.of_Retorno( "id_situacao", Ref as_situacao_matriz )
	End If
End If 

Return True
end function

on w_ge108_produto_favorito.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_consultar=create cb_consultar
this.gb_produtos=create gb_produtos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_consultar
this.Control[iCurrent+3]=this.gb_produtos
end on

on w_ge108_produto_favorito.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_consultar)
destroy(this.gb_produtos)
end on

event open;call super::open;is_Parametro = Message.StringParm
end event

event ue_postopen;call super::ue_postopen;Integer li_Pos

io_Conexao 	= Create uo_Transacao_Remota
io_Cliente 	= Create uo_cliente

//dw_2.Event ue_AddRow()

If Not IsNull(is_Parametro) And Trim(is_Parametro) <> '' Then
	cb_consultar.Enabled = False
	dw_1.Enabled = False
	dw_1.Object.cd_cliente.Background.Color='134217750'
	dw_1.Object.nm_cliente.Background.Color='134217750'
		
	//is_parametro = cliente|matricula|produto
	is_Cliente = MidA(is_Parametro, 1, 11)  //Cliente
	
	is_Parametro = MidA(is_Parametro, 13)
	li_Pos = PosA( is_Parametro, '|' )
	
	is_Matricula = MidA(is_Parametro, 1, 		(li_Pos - 1)  )
	il_Produto 	= Long( MidA(is_Parametro, 	(li_Pos + 1)  ))

	SetNull( is_Produtos_Excluidos )
	
	io_Cliente.of_localiza_codigo( is_Cliente)
	
	dw_1.Object.cd_cliente	[1] = io_Cliente.cd_cliente
	dw_1.Object.nm_cliente	[1] = io_Cliente.nm_cliente
		
	wf_importa_distribuido()
	
	dw_1.AcceptText()
	dw_2.AcceptText()

Else
	cb_consultar.Visible 	= True
	ib_Relatorio 			= True
End If

end event

event close;call super::close;If IsValid(io_Conexao) Then Destroy io_Conexao
If IsValid(io_Cliente) 	 Then Destroy io_Cliente
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge108_produto_favorito
integer x = 23
integer y = 1104
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge108_produto_favorito
integer width = 2057
integer height = 204
string text = "Cliente"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge108_produto_favorito
integer y = 84
integer width = 1993
integer height = 80
string dataobject = "dw_ge108_selecao_favorito"
end type

event dw_1::ue_key;call super::ue_key;Boolean lb_Sucesso = False

String ls_Localizacao

If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_cliente" Then		
		ls_Localizacao = This.GetText()
		
		If LenA( ls_Localizacao ) = 11 And IsNumber( ls_Localizacao ) Then
			io_Cliente.of_Localiza_Cpf( ls_Localizacao )
		Else		
			io_Cliente.of_Localiza_Cliente( ls_Localizacao )
		End If
		
		If io_Cliente.Localizado Then
			This.Object.Cd_Cliente	[1] = io_Cliente.Cd_Cliente
			This.Object.Nm_Cliente	[1] = io_Cliente.Nm_Cliente	
		End If
	End If
End If






end event

event dw_1::editchanged;call super::editchanged;dw_2.Reset()
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.name
	Case "nm_cliente"
		If Not IsNull(Data) and Trim(Data) <> "" Then		
			If data <> io_Cliente.Nm_Cliente Then
				Return 1
			End If
		Else
			io_Cliente.of_Inicializa()
			
			dw_1.Object.cd_cliente[1] 	= io_Cliente.cd_cliente
			dw_1.Object.nm_cliente[1] = io_Cliente.nm_cliente
		End If
End Choose
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge108_produto_favorito
integer x = 2139
integer y = 1124
integer width = 357
string text = "&Excluir"
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Long ll_Produto, ll_Row, ll_Linhas

dw_2.AcceptText()

is_Produtos_Excluidos = ''

ll_Linhas = dw_2.RowCount()

If dw_2.Find("id_excluir='S'", 1, ll_Linhas ) = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum produto foi selecionado.", Exclamation!)
	Return -1	
End If

//Matricula alteracao
If Not gvo_Aplicacao.ivo_Seguranca.of_libera_acesso_usuario( Ref is_matricula ) Then
	Return -1
End If

For ll_Row = 1 To dw_2.RowCount()
	If dw_2.Object.id_excluir[ ll_Row ] = 'N' Then Continue
		
	ll_Produto =  dw_2.Object.cd_produto[ ll_Row ]
	is_Produtos_Excluidos += String(ll_Produto) + ','
		
	dw_2.deleterow( ll_Row )	
	ll_Row = ll_Row -1
Next

If Not IsNull(is_Produtos_Excluidos) Then
	//Retira a ultima virgula da string
	is_Produtos_Excluidos = MidA( is_Produtos_Excluidos, 1, LenA(is_Produtos_Excluidos) -1 )
	
	SetNull(ll_Produto )
	
	If Not wf_Atualiza_distribuido('update', ll_Produto, 'I') Then
		Return -1
	End If
End If

If ll_Linhas <> dw_2.RowCount() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto(s) exclu$$HEX1$$ed00$$ENDHEX$$do(s) da lista dos favoritos.", Exclamation!)
End if



end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge108_produto_favorito
boolean visible = false
integer x = 1312
integer y = 1120
boolean enabled = false
string text = "&Ok"
boolean cancel = false
end type

type dw_2 from dc_uo_dw_base within w_ge108_produto_favorito
integer x = 55
integer y = 280
integer width = 2409
integer height = 800
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge108_lista_favorito"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection( )
end event

type cb_consultar from commandbutton within w_ge108_produto_favorito
boolean visible = false
integer x = 2098
integer y = 104
integer width = 398
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Consultar"
end type

event clicked;String ls_Cliente

dw_1.AcceptText()

ls_Cliente = dw_1.Object.cd_cliente [1] 

If IsNull(ls_Cliente) Or Trim(ls_Cliente) = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione um cliente.", Exclamation!)
	Return -1
End If

wf_importa_distribuido()
end event

type gb_produtos from groupbox within w_ge108_produto_favorito
integer x = 27
integer y = 228
integer width = 2469
integer height = 880
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos Favoritos do Cliente"
end type

