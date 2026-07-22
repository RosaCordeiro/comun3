HA$PBExportHeader$w_ge001_selecao_produto_atendimento_sac.srw
forward
global type w_ge001_selecao_produto_atendimento_sac from dc_w_selecao_generica
end type
end forward

global type w_ge001_selecao_produto_atendimento_sac from dc_w_selecao_generica
integer width = 3333
integer height = 1808
string title = "GE001 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Produtos [Atendimento ao Cliente]"
end type
global w_ge001_selecao_produto_atendimento_sac w_ge001_selecao_produto_atendimento_sac

type variables
uo_Produto ivo_Produto_Parent

uo_categoria io_Categoria_Produto // GE022


Long ivl_Filial
end variables

forward prototypes
public subroutine wf_atualiza_precos ()
public subroutine wf_inclui_produto (long pl_produto)
public function integer wf_verifica_pbm (long pl_produto)
public function integer wf_verifica_dermaclub (long pl_produto)
end prototypes

public subroutine wf_atualiza_precos ();Long lvl_Linhas
Long lvl_Contador
Long lvl_Produto
Long lvl_Filial

Decimal ldc_Preco_Bruto
Decimal ldc_Desconto_Filial
Decimal ldc_Desconto_Clube
Decimal ldc_valor_fpb

uo_Produto lvo_Produto
lvo_Produto = Create uo_Produto

SetPointer(HourGlass!)
Open(w_Aguarde)
w_Aguarde.Title = "Verificando Pre$$HEX1$$e700$$ENDHEX$$os e Descontos..."

lvl_Linhas = dw_2.RowCount()
w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)

lvl_Filial = gvo_Parametro.of_Filial()

For lvl_Contador = 1 To lvl_Linhas
	lvl_Produto = dw_2.Object.Cd_Produto[lvl_Contador]	
	
	lvo_Produto.of_Localiza_Codigo_Interno(lvl_Produto)
	
	If lvo_Produto.Localizado Then		
		ldc_Preco_Bruto		= lvo_Produto.of_Preco_Venda_Filial( )
		ldc_Desconto_Clube	= lvo_Produto.of_Desconto_Clube( )
		ldc_Desconto_Filial	= lvo_Produto.of_Desconto_Filial( )
		
		If ldc_Desconto_Filial > ldc_Desconto_Clube Then
			ldc_Desconto_Clube = ldc_Desconto_Filial
		End If
		If IsNull(lvo_produto.vl_reembolso_fpb) or lvo_produto.vl_reembolso_fpb < 0 Then
			ldc_valor_fpb = 0
		Else
			ldc_valor_fpb = lvo_produto.vl_reembolso_fpb
		End If		
		
		dw_2.Object.Vl_Preco_Tabela	[lvl_Contador] = ldc_Preco_Bruto
		dw_2.Object.Vl_Preco_Liquido	[lvl_Contador] = Round( ldc_Preco_Bruto * ( ( 100 - ldc_Desconto_Filial ) / 100 ), 2 )
		dw_2.Object.Vl_Preco_Clube	[lvl_Contador] = Round( ldc_Preco_Bruto * ( ( 100 - ldc_Desconto_Clube ) / 100 ), 2 )
		If lvo_Produto.id_gratis_farm_popular <> 'S' Then
			If ldc_valor_fpb > 0 Then
				If (dw_2.Object.Vl_Preco_Liquido[lvl_Contador] * 0.9) >= ldc_valor_fpb Then
					dw_2.Object.Vl_Preco_Pago_FPB[lvl_Contador] =  Round( dw_2.Object.Vl_Preco_Liquido[lvl_Contador] - ldc_valor_fpb, 2 )
				Else
					dw_2.Object.Vl_Preco_Pago_FPB[lvl_Contador] = Round( dw_2.Object.Vl_Preco_Liquido[lvl_Contador] * 0.1, 2 )
				End If
			Else
				SetNull(ldc_valor_fpb)
				dw_2.Object.Vl_Preco_Pago_FPB[lvl_Contador] = ldc_valor_fpb
			End If
		Else
			dw_2.Object.Vl_Preco_Pago_FPB[lvl_Contador] = 0
		End If
		
	End If
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
Next

Destroy(lvo_Produto)

Close(w_Aguarde)
SetPointer(Arrow!)
end subroutine

public subroutine wf_inclui_produto (long pl_produto);Integer li_Row

Decimal ldc_Preco_Bruto
Decimal ldc_Desconto_Clube
Decimal ldc_Desconto_Filial
Decimal ldc_valor_fpb

String lvs_Subcategoria

Try
	This.SetRedraw( False )
	
	uo_produto lo_Produto // GE001
	lo_Produto = Create uo_Produto
	
	lo_Produto.of_Localiza_Codigo_Interno( pl_Produto )
	
	If lo_Produto.Localizado Then
		li_Row = dw_2.InsertRow( 1 )
		
		select sc.de_subcategoria
		  Into :lvs_Subcategoria
		From subcategoria sc
		Inner Join categoria c
			On c.cd_categoria = sc.cd_categoria
		Inner Join subgrupo s
			on s.cd_subgrupo = c.cd_subgrupo
		Inner Join grupo g
			on g.cd_grupo = s.cd_grupo
		Where sc.cd_subcategoria = :lo_Produto.Cd_Subcategoria
		Using SqlCa;
		
		If SqlCa.SQLCode = -1 Then
			SqlCa.Of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o c$$HEX1$$f300$$ENDHEX$$digo subcategoria produto.')
		End If
		
		dw_2.Object.cd_Produto						[li_Row] = lo_Produto.cd_Produto
		dw_2.Object.de_Produto						[li_Row] = lo_Produto.de_Produto
		dw_2.Object.de_Apresentacao_Venda	[li_Row] = lo_Produto.de_Apresentacao_Venda
		dw_2.Object.cd_Grupo_Psico				[li_Row] = lo_Produto.cd_Grupo_Psico
		dw_2.Object.id_Lei_Generico				[li_Row] = lo_Produto.id_Lei_Generico
		dw_2.Object.cd_produto_pbm				[li_Row] = This.wf_Verifica_PBM(lo_Produto.cd_Produto)
		dw_2.Object.cd_produto_dermaclub		[li_Row] = This.wf_Verifica_Dermaclub(lo_Produto.cd_Produto)		
		dw_2.Object.de_subcategoria			     [li_Row] = lvs_Subcategoria
		dw_2.Object.id_Farmacia_Popular			[li_Row] = lo_Produto.id_Farmacia_Popular
		dw_2.Object.id_Situacao						[li_Row] = lo_Produto.id_Situacao
		
		dw_2.Scrolltorow( li_Row )
	End If
	
Finally
	This.SetRedraw( True )
	Destroy lo_Produto
End Try
end subroutine

public function integer wf_verifica_pbm (long pl_produto);//Mostra s$$HEX1$$ed00$$ENDHEX$$mbolo de PBM em cima do campo descri$$HEX2$$e700e300$$ENDHEX$$o do produto.

Long lvl_Count

Select Count(pp.cd_pbm)
  Into :lvl_Count
  From pbm_produto pp
  inner join pbm p
  	on p.cd_pbm = pp.cd_pbm
	 and coalesce (p.id_tipo, '') <> 'D'
 Where pp.cd_produto = :pl_produto
 Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos PBMs do produto '" + String(pl_Produto) + "'.")
	Return 0
End If

Return lvl_Count
end function

public function integer wf_verifica_dermaclub (long pl_produto);//Mostra s$$HEX1$$ed00$$ENDHEX$$mbolo de Dermaclub em cima do campo descri$$HEX2$$e700e300$$ENDHEX$$o do produto.

Long lvl_Count

Select Count(pp.cd_pbm)
  Into :lvl_Count
  From pbm_produto pp
  inner join pbm p
  	on p.cd_pbm = pp.cd_pbm
	 and coalesce (p.id_tipo, '') = 'D'
 Where pp.cd_produto = :pl_produto
 Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos PBMs do produto '" + String(pl_Produto) + "'.")
	Return 0
End If

Return lvl_Count
end function

on w_ge001_selecao_produto_atendimento_sac.create
call super::create
end on

on w_ge001_selecao_produto_atendimento_sac.destroy
call super::destroy
end on

event open;call super::open;String lvs_Produto
String lvs_DW

io_Categoria_Produto = Create uo_Categoria

lvs_Produto = ivo_Produto_Parent.ivs_Parametro

If lvs_Produto <> "" Then
	dw_1.Object.De_Produto[1] = lvs_Produto
	dw_1.AcceptText()
	
	ivb_Pesquisa_Direta = True	
End If

If Not ivo_Produto_Parent.ivb_Inativo_Loja Then
	dw_1.Object.Id_Inativos[1] 			= "N"	
	dw_1.Object.Id_Inativos.Protect 	= 1
End If

pb_Help.Visible = False
end event

event close;call super::close;Destroy This.io_categoria_produto
end event

event ue_preopen;call super::ue_preopen;Boolean lvb_Sucesso = False

String ls_Odbc

ivo_Produto_Parent = Message.PowerObjectParm

/*
// Seleciona o c$$HEX1$$f300$$ENDHEX$$digo da Filial para consulta de informa$$HEX2$$e700f500$$ENDHEX$$es do produto
uo_Parametro_Geral lvo_Parametro
lvo_Parametro = Create uo_Parametro_Geral


If Not lvo_Parametro.of_Localiza_Parametro("CD_FILIAL_CONSULTA_PRODUTO_SAC", ref ivl_Filial) Then
	Destroy(lvo_Parametro)
	
	dw_1.of_ChangeDataObject("dw_ge001_selecao_matriz")
	dw_2.of_ChangeDataObject("dw_ge001_lista_matriz")	
	
	dw_1.of_SetTransObject( SQLCA )
	dw_2.of_SetTransObject( SQLCA )	
	Return
End If

Destroy(lvo_Parametro)

ivo_Odbc	= Create dc_uo_odbc
ivtr_Filial = Create uo_ge136_transacao_remota

ivo_Odbc.of_Atualiza_Odbcs( String( ivl_Filial ) )

lvb_Sucesso = gf_GE136_Conecta_Banco_Filial( ivl_Filial, Ref ivtr_Filial )

If lvb_Sucesso Then
	dw_1.of_SetTransObject( ivtr_Filial )
	dw_2.of_SetTransObject( ivtr_Filial )	
Else
	dw_1.of_ChangeDataObject("dw_ge001_selecao_matriz")
	dw_2.of_ChangeDataObject("dw_ge001_lista_matriz")	
	
	dw_1.of_SetTransObject( SQLCA )
	dw_2.of_SetTransObject( SQLCA )	
	
End If
*/
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge001_selecao_produto_atendimento_sac
integer x = 3397
integer y = 56
end type

event pb_help::clicked;call super::clicked;wf_Help( "Sele$$HEX2$$e700e300$$ENDHEX$$o de Produtos [Atendimento ao Cliente] (GE001)" )
end event

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge001_selecao_produto_atendimento_sac
integer x = 27
integer y = 364
integer width = 3269
integer height = 1204
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge001_selecao_produto_atendimento_sac
integer x = 27
integer width = 2985
integer height = 348
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge001_selecao_produto_atendimento_sac
integer x = 59
integer y = 64
integer width = 2917
integer height = 268
string dataobject = "dw_ge001_selecao_produto_atendimento_sac"
end type

event dw_1::ue_key;call super::ue_key;Choose Case Key
	Case KeyEnter!
		Choose Case GetColumnName()
			Case "de_categoria"				
				io_Categoria_Produto.of_Localiza( This.GetText( ) )
				
				If Parent.io_Categoria_Produto.Localizado Then
					This.Object.cd_Categoria[1] = Parent.io_Categoria_Produto.cd_Categoria
					This.Object.de_Categoria[1] = Parent.io_Categoria_Produto.de_Categoria
				End If
		End Choose
End Choose
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_categoria"
		
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Trim(Data) <> io_Categoria_Produto.de_Categoria Then
				Return 1
			End If
		Else
			io_Categoria_Produto.Of_Inicializa()
			
			This.Object.cd_Categoria[1] = io_Categoria_Produto.cd_Categoria
			This.Object.de_Categoria[1] = io_Categoria_Produto.de_Categoria
		End If		
End Choose
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge001_selecao_produto_atendimento_sac
integer x = 64
integer y = 412
integer width = 3223
integer height = 1136
string title = "GE001 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Produtos [Atendimento ao Cliente]"
string dataobject = "dw_ge001_lista_produto_atendimento_sac"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String	lvs_Descricao, &
		lvs_Barras, &
		lvs_Situacao, &
		lvs_Ativo, &
		lvs_Pendente, &
		lvs_Inativo, &
		lvs_Registro_MS, &
		lvs_Descricao_Busca
String ls_Categoria
String ls_SubCategoria
		
Dec ldc_Concentracao

Long ll_Unidades		

dw_1.AcceptText()

lvs_Descricao		= dw_1.Object.De_Produto			[1]
lvs_Ativo				= dw_1.Object.Id_Ativos				[1]
lvs_Pendente		= dw_1.Object.Id_Pendentes		[1]
lvs_Inativo			= dw_1.Object.Id_Inativos			[1]
ls_Categoria			= dw_1.Object.Cd_Categoria 		[1]
ls_SubCategoria	= dw_1.Object.De_SubCategoria 	[1]
ldc_Concentracao	= dw_1.Object.qt_Concentracao	[1]
ll_Unidades			= dw_1.Object.qt_Unidades_Emb 	[1]

If (IsNull(lvs_Descricao) or Trim(lvs_Descricao) = "" or lvs_Descricao = '%') and (IsNull(ls_Categoria) or Trim(ls_Categoria) = "") and ( IsNull( ls_SubCategoria ) ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Informe algum par$$HEX1$$e200$$ENDHEX$$metro de sele$$HEX2$$e700e300$$ENDHEX$$o.", Exclamation!)
	dw_1.Event ue_Pos(1, "de_produto")
	Return -1	
End If

If Not IsNull( ls_Categoria ) Then
	This.of_appendwhere_subquery("left( g.cd_subcategoria, 6 ) = '" + ls_Categoria + "'", 3)
End If

If Not IsNull(lvs_Descricao) and Trim(lvs_Descricao) <> "" Then
	/* Gambiarra - 28/01/2016 - Adapta$$HEX2$$e700e300$$ENDHEX$$o para a busca sempre mostrar tamb$$HEX1$$e900$$ENDHEX$$m os produtos de geladeira que comecem com o texto buscado
		Exemplo: NORIPURUM - ZZNORIPURU
	*/
	
	lvs_Descricao_Busca = lvs_Descricao
	
	If LeftA( lvs_Descricao, 2 ) = 'ZZ' Then
		lvs_Descricao_Busca = MidA( lvs_Descricao, 4 )
	End If

	If LeftA( lvs_Descricao, 3 ) = '%ZZ' Then
//		This.of_appendwhere_subquery( "( g.de_produto like '%" + MidA( lvs_Descricao, 4 ) + "%' Or g.de_produto like '%ZZ" + MidA( lvs_Descricao, 4 ) + "%' Or  (Case When dbo.uf_metaphone( '" + lvs_Descricao_Busca + "' ) <> '' Then g.de_produto_metaphone like dbo.uf_metaphone( '" + lvs_Descricao_Busca + "' ) || '%' END) Or g.de_produto_metaphone like '%ZZ' || dbo.uf_metaphone( '" + MidA( lvs_Descricao, 4 ) + "' ) || '%' )", 3)
		This.of_appendwhere_subquery( "( g.de_produto like '%" + MidA( lvs_Descricao, 4 ) + "%' Or g.de_produto like '%ZZ" + MidA( lvs_Descricao, 4 ) + "% )", 3)
	Else
		//This.of_appendwhere_subquery("( g.de_produto like '" + lvs_Descricao_Busca + "%' Or g.de_produto like 'ZZ" + lvs_Descricao_Busca + "%' Or (Case When dbo.uf_metaphone( '" + lvs_Descricao_Busca + "' ) <> '' Then g.de_produto_metaphone like dbo.uf_metaphone( '" + lvs_Descricao_Busca + "' ) || '%' END) Or g.de_produto_metaphone like dbo.uf_metaphone( 'ZZ" + lvs_Descricao_Busca + "' ) || '%' )", 3)		
		This.of_appendwhere_subquery("( g.de_produto like '" + lvs_Descricao_Busca + "%' Or g.de_produto like 'ZZ" + lvs_Descricao_Busca + "%')", 3)		
	End If	
	
	/***/
End If

// Concentra$$HEX2$$e700e300$$ENDHEX$$o
If Not IsNull( ldc_Concentracao ) Then
	This.of_Appendwhere_Subquery( "exists (select 1 from composicao_produto cp where cp.cd_produto = g.cd_produto and cp.qt_concentracao = " + gf_Valor_Com_Ponto( ldc_Concentracao ) + ')', 3 ) 
End If

// Unidades por embalagam de venda
If Not IsNull( ll_Unidades ) Then
	// Se estiver preenchido no banco com 0, considera 1
	This.of_Appendwhere_Subquery( "( case qt_unidades_embalagem when 0 then 1 else qt_unidades_embalagem end )  = " + String( ll_Unidades ), 3 )
End If

// Verifica o filtro da situa$$HEX2$$e700e300$$ENDHEX$$o
If lvs_Ativo    = "S" Then	lvs_Situacao  = "A"
If lvs_Pendente = "S" Then	lvs_Situacao += "P"
If lvs_Inativo  = "S" Then	lvs_Situacao += "I"

If LenA(lvs_Situacao) > 0 Then
	If LenA(lvs_Situacao) < 3 Then
		If LenA(lvs_Situacao) = 1 Then
			This.of_appendwhere_subquery("g.id_situacao = '" + lvs_Situacao + "'", 3)
		Else
			This.of_appendwhere_subquery("g.id_situacao in ('" + LeftA(lvs_Situacao, 1) + "', '" + RightA(lvs_Situacao, 1) + "')", 3)
		End If
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Selecione pelo menos uma situa$$HEX2$$e700e300$$ENDHEX$$o.", Exclamation!)
	dw_1.Event ue_Pos(1, "id_ativos")
	Return -1
End If

If Not IsNull( ls_SubCategoria ) Then
	This.of_appendwhere_subquery("g.cd_subcategoria in ( SELECT cd_subcategoria FROM subcategoria WHERE de_subcategoria LIKE '" + ls_SubCategoria + "%' )", 3)
End If

This.SetRedRaw(False)

Return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;//wf_Atualiza_Precos()

This.SetRedRaw(True)

Return AncestorReturnValue
end event

event dw_2::ue_key;call super::ue_key;Long ll_Produto
Long ll_Produto_Busca_Facil
Long ll_Find

Choose Case Key
	Case KeyF5!
		
		If This.GetRow() = 0 Then Return
		
		ll_Produto = This.Object.cd_produto[ This.GetRow() ]
		
		If This.Object.cd_produto_pbm[ This.GetRow() ] = 0 And This.Object.cd_produto_dermaclub[ This.GetRow() ] = 0 Then						 
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String( ll_Produto ) + "' n$$HEX1$$e300$$ENDHEX$$o possui cadastro nos PBMs.", Information! )
		Else
			If Not IsNull( ll_Produto ) Then
				OpenWithParm( w_ge001_consulta_pbm_produto, ll_Produto )
			End If
		End If
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o		
		
	Case KeyF6!
		
	 	ll_Produto = This.Object.cd_produto[ This.GetRow() ]
		 
		If Not IsNull( ll_Produto ) Then
			
			SetNull( ll_Produto_Busca_Facil )
			
			OpenWithParm( w_ge120_Busca_Facil_Lista_Tecnica, ll_Produto )
			
			ll_Produto_Busca_Facil = Message.DoubleParm
			
			If Not IsNull( ll_Produto_Busca_Facil ) and ll_Produto_Busca_Facil > 0 Then
				ll_Find = This.Find( "cd_produto = " + String( ll_Produto_Busca_Facil ), 1, This.RowCount( ) )
				
				If ll_Find > 0 Then
					This.Scrolltorow( ll_Find )
				Else
					wf_Inclui_Produto( ll_Produto_Busca_Facil )
					
					If This.Rowcount( ) = 1 Then
						Parent.st_Mensagem.Text = "1 registro."
					Else
						Parent.st_Mensagem.Text = String( This.Rowcount( ), "###,###,##0") + " registros."
					End If
					
				End If
			End If 
		End If		
End Choose
end event

event dw_2::constructor;call super::constructor;// Quando o produto $$HEX1$$e900$$ENDHEX$$ adicionado pelo [F6], a linha fica com fundo na cor amarela
//This.of_SetRowSelection("if (vl_preco_pago_fpb < vl_preco_clube, rgb(255, 255, 0), rgb(255, 255, 255))","")

This.ivb_Ordena_Colunas = True
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge001_selecao_produto_atendimento_sac
integer x = 2514
integer y = 1592
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha

String lvs_Produto

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Produto = String(dw_2.Object.Cd_Produto[lvl_Linha])
	CloseWithReturn(Parent, lvs_Produto)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto na lista.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge001_selecao_produto_atendimento_sac
integer x = 2926
integer y = 1592
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Produto

SetNull(lvs_Produto)

CloseWithReturn(Parent, lvs_Produto)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge001_selecao_produto_atendimento_sac
integer x = 2107
integer y = 1592
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge001_selecao_produto_atendimento_sac
integer y = 1592
integer width = 1682
end type

