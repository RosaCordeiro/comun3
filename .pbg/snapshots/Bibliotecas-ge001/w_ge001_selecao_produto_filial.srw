HA$PBExportHeader$w_ge001_selecao_produto_filial.srw
forward
global type w_ge001_selecao_produto_filial from dc_w_selecao_generica
end type
end forward

global type w_ge001_selecao_produto_filial from dc_w_selecao_generica
integer x = 206
integer y = 364
integer width = 3607
integer height = 1900
string title = "GE001 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Produtos"
long backcolor = 80269524
end type
global w_ge001_selecao_produto_filial w_ge001_selecao_produto_filial

type variables
uo_Produto ivo_Produto_Parent
uo_parametro_filial	ivo_parametro

String is_utiliza_lista_tecnica
end variables

forward prototypes
public subroutine wf_inclui_produto (long pl_produto)
end prototypes

public subroutine wf_inclui_produto (long pl_produto);Integer li_Row

Try
	uo_produto lo_Produto // GE001
	lo_Produto = Create uo_Produto
	
	lo_Produto.of_Localiza_Codigo_Interno( pl_Produto )
	
	If lo_Produto.Localizado Then
		li_Row = dw_2.InsertRow( 1 )
		
		dw_2.Object.cd_Produto						[li_Row] = lo_Produto.cd_Produto
		dw_2.Object.de_Produto						[li_Row] = lo_Produto.de_Produto
		dw_2.Object.de_Apresentacao_Venda	[li_Row] = lo_Produto.de_Apresentacao_Venda
		dw_2.Object.cd_Grupo_Psico				[li_Row] = lo_Produto.cd_Grupo_Psico
		dw_2.Object.de_Apresentacao_Estoque	[li_Row] = lo_Produto.de_Apresentacao_Estoque
		dw_2.Object.id_Situacao_Filial				[li_Row] = lo_Produto.id_Situacao
		dw_2.Object.id_Situacao_Matriz			[li_Row] = '-'
		dw_2.Object.id_Lei_Generico				[li_Row] = lo_Produto.id_Lei_Generico
		dw_2.Object.de_Registro_MS				[li_Row] = lo_Produto.de_Registro_MS
		dw_2.Object.id_Promover_Venda			[li_Row] = lo_Produto.id_Promover_Venda
		dw_2.Object.qt_Saldo_Final					[li_Row] = lo_Produto.of_Saldo_Produto( pl_Produto )
		
		dw_2.Scrolltorow( li_Row )
	End If
	
Finally
	
	Destroy lo_Produto
End Try


end subroutine

on w_ge001_selecao_produto_filial.create
call super::create
end on

on w_ge001_selecao_produto_filial.destroy
call super::destroy
end on

event open;call super::open;String lvs_Produto
String lvs_DW

ivo_Produto_Parent = Message.PowerObjectParm

lvs_Produto = ivo_Produto_Parent.ivs_Parametro

If lvs_Produto <> "" Then
	dw_1.Object.De_Produto[1] = lvs_Produto
	dw_1.AcceptText()
	
	ivb_Pesquisa_Direta = True	
End If

If Not ivo_Produto_Parent.ivb_Inativo_Loja Then
	dw_1.Object.Id_Inativos[1] = "N"	
	dw_1.Object.Id_Inativos.Protect = 1
End If

ivo_parametro = Create uo_parametro_filial
ivo_parametro.of_localiza_parametro( 'ID_UTILIZA_LISTA_TECNICA', ref is_utiliza_lista_tecnica)
end event

event close;call super::close;If IsValid(ivo_Parametro) 			Then Destroy(ivo_Parametro)
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge001_selecao_produto_filial
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge001_selecao_produto_filial
integer x = 18
integer y = 376
integer width = 3543
integer height = 1272
long backcolor = 80269524
string text = "Lista de Produtos"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge001_selecao_produto_filial
integer x = 18
integer y = 8
integer width = 3063
integer height = 352
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge001_selecao_produto_filial
integer x = 37
integer y = 72
integer width = 3031
integer height = 272
string dataobject = "dw_ge001_selecao_filial"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge001_selecao_produto_filial
integer x = 46
integer y = 420
integer width = 3493
integer height = 1216
string dataobject = "dw_ge001_lista_filial"
boolean hscrollbar = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Descricao, &
       lvs_Barras, &
		 lvs_Situacao, &
		 lvs_Ativo, &
		 lvs_Pendente, &
		 lvs_Inativo, &
		 lvs_Registro_MS, &
		 lvs_Descricao_Busca, ls_cd_produto_sap, &
		 lvs_GTIN

uo_udi	luo_udi

dw_1.AcceptText()

lvs_Descricao 		= dw_1.Object.De_Produto      				[1]
lvs_Barras   	 		= dw_1.Object.De_Codigo_Barras			[1]
lvs_Registro_MS 	= Trim(dw_1.Object.De_Registro_MS 	[1])
lvs_Ativo     			= dw_1.Object.Id_Ativos       				[1]
lvs_Pendente  		= dw_1.Object.Id_Pendentes    			[1]
lvs_Inativo   		= dw_1.Object.Id_Inativos     				[1]
ls_cd_produto_sap= dw_1.Object.cd_produto_sap				[1]

If (trim(ls_cd_produto_sap) = '' or isnull(ls_cd_produto_sap)) and (IsNull(lvs_Descricao) or Trim(lvs_Descricao) = "" or lvs_Descricao = '%') and (IsNull(lvs_Barras) or Trim(lvs_Barras) = "") and (IsNull(lvs_Registro_MS) or Trim(lvs_Registro_MS) = "") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe algum par$$HEX1$$e200$$ENDHEX$$metro de sele$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
	dw_1.Event ue_Pos(1, "de_produto")
	Return -1	
End If

If Not ivo_produto_parent.ivb_Nao_Liberado_Filial Then
	This.of_AppendWhere("g.id_liberado_filial = 'S'")		
End If

If ivo_Produto_Parent.ivb_Produto_Resgate_Clube Then
	This.of_AppendWhere("g.qt_pontos_resgate > 0")
End If

If Not IsNull(lvs_Descricao) and Trim(lvs_Descricao) <> "" Then
	/* Gambiarra - 28/01/2016 - Adapta$$HEX2$$e700e300$$ENDHEX$$o para a busca sempre mostrar tamb$$HEX1$$e900$$ENDHEX$$m os produtos de geladeira que comecem com o texto buscado
		Exemplo: NORIPURUM - ZZNORIPURU
	*/
	
	lvs_Descricao_Busca = lvs_Descricao
	
	If LeftA( lvs_Descricao, 2 ) = 'ZZ' Then
		lvs_Descricao_Busca = MidA( lvs_Descricao, 3 )
	End If
	
	If LeftA( lvs_Descricao, 3 ) = '%ZZ' Then
		This.of_appendwhere( "( g.de_produto like '%" + MidA( lvs_Descricao, 4 ) + "%' Or g.de_produto like '%ZZ" + MidA( lvs_Descricao, 4 ) + "%' Or  (Case When dbo.uf_metaphone( '" + lvs_Descricao_Busca + "' ) <> '' Then g.de_produto_metaphone like dbo.uf_metaphone( '" + lvs_Descricao_Busca + "' ) || '%' END) Or g.de_produto_metaphone like '%ZZ' || dbo.uf_metaphone( '" + MidA( lvs_Descricao, 4 ) + "' ) || '%' )")
	Else
		This.of_appendwhere("( g.de_produto like '" + lvs_Descricao_Busca + "%' Or g.de_produto like 'ZZ" + lvs_Descricao_Busca + "%' Or (Case When dbo.uf_metaphone( '" + lvs_Descricao_Busca + "' ) <> '' Then g.de_produto_metaphone like dbo.uf_metaphone( '" + lvs_Descricao_Busca + "' ) || '%' END) Or g.de_produto_metaphone like dbo.uf_metaphone( 'ZZ" + lvs_Descricao_Busca + "' ) || '%' )")		
	End If	
	
//	If LeftA( lvs_Descricao, 3 ) = '%ZZ' Then
//		This.of_AppendWhere("( g.de_produto like '%" + MidA( lvs_Descricao, 4 ) + "%' Or g.de_produto like '%ZZ" + MidA( lvs_Descricao, 4 ) + "%' Or g.de_produto_metaphone like '%' || dbo.uf_metaphone( '" + MidA( lvs_Descricao, 4 ) + "' ) || '%' Or g.de_produto_metaphone like '%ZZ' || dbo.uf_metaphone( '" + MidA( lvs_Descricao, 4 ) + "' ) || '%' )")
//	Else
//		This.of_AppendWhere("( g.de_produto like '" + lvs_Descricao_Busca + "%' Or g.de_produto like 'ZZ" + lvs_Descricao_Busca + "%' Or g.de_produto_metaphone like dbo.uf_metaphone( '" + lvs_Descricao_Busca + "' ) || '%' Or g.de_produto_metaphone like dbo.uf_metaphone( 'ZZ" + lvs_Descricao_Busca + "' ) || '%' )")		
//	End If
	
	/***/
End If

If Not IsNull(lvs_Barras) and Trim(lvs_Barras) <> "" Then	
	lvs_GTIN = lvs_Barras
	
	If Len (lvs_Barras) > 20 then	//C$$HEX1$$f300$$ENDHEX$$digo de barras no formato UDI
		luo_udi = Create uo_udi
		Try
			If luo_udi.of_parse_udi (lvs_Barras) then
				lvs_GTIN = gf_tira_zero_esquerda (luo_udi.is_gtin)
			End if
		Finally
			Destroy luo_udi
		End try
	End if
	
	This.of_AppendWhere("g.cd_produto in (select cd_produto from codigo_barras_produto where de_codigo_barras = '" + lvs_GTIN + "')")
End If

If Not IsNull(lvs_Registro_MS) and Trim(lvs_Registro_MS) <> "" Then	
	This.of_AppendWhere("de_registro_ms like '" + lvs_Registro_MS + "%'")
End If

if not isnull( ls_cd_produto_sap ) and ls_cd_produto_sap <> '' Then
	
	if mid(ls_cd_produto_sap, 1,1) = '%' Then
		
		This.of_AppendWhere("g.cd_produto_sap like '" + ls_cd_produto_sap + "'")
		
	else
		
		This.of_AppendWhere("g.cd_produto_sap = '" + ls_cd_produto_sap + "'")
		
	end if
	
end if

// Verifica o filtro da situa$$HEX2$$e700e300$$ENDHEX$$o
If lvs_Ativo    = "S" Then	lvs_Situacao  = "A"
If lvs_Pendente = "S" Then	lvs_Situacao += "P"
If lvs_Inativo  = "S" Then	lvs_Situacao += "I"

If LenA(lvs_Situacao) > 0 Then
	If LenA(lvs_Situacao) < 3 Then
		If LenA(lvs_Situacao) = 1 Then
			This.of_AppendWhere("l.id_situacao = '" + lvs_Situacao + "'")
		Else
			This.of_AppendWhere("l.id_situacao in ('" + LeftA(lvs_Situacao, 1) + "', '" + RightA(lvs_Situacao, 1) + "')")
		End If
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos uma situa$$HEX2$$e700e300$$ENDHEX$$o.")
	dw_1.Event ue_Pos(1, "id_ativos")
	Return -1
End If

Return 1
end event

event dw_2::constructor;call super::constructor;// Quando o produto $$HEX1$$e900$$ENDHEX$$ adicionado pelo [F6], a linha fica com fundo na cor amarela
//This.of_SetRowSelection("if (id_situacao_matriz = ~"-~", rgb(255, 255, 0), rgb(255, 255, 255))","")
end event

event dw_2::ue_key;call super::ue_key;Long ll_Produto
Long ll_Produto_Busca_Facil
Long ll_Find

If This.RowCount() = 0 Then Return

Choose Case Key
	Case KeyF6!
		
	 	ll_Produto = This.Object.cd_produto[ This.GetRow() ]
		 
		If Not IsNull( ll_Produto ) Then
			
			SetNull( ll_Produto_Busca_Facil )
			
			If is_utiliza_lista_tecnica = 'S' Then
				OpenWithParm( w_ge001_Busca_Facil_Lista_Tecnica, ll_Produto )
			Else
				OpenWithParm( w_ge001_Busca_Facil, ll_Produto )
			End If
			
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

event dw_2::ue_postretrieve;If pl_Linhas > 0 Then
	cb_Selecionar.Enabled = True
	This.SetRow(1)
	This.ScrollToRow(1)
	This.SetFocus()

	If pl_Linhas = 1 Then
		st_Mensagem.Text = "1 registro."
	Else
		st_Mensagem.Text = String(pl_Linhas, "###,###,##0") + " registros."
	End If
Else
	cb_Selecionar.Enabled = False
	dw_1.SetFocus()
	st_Mensagem.Text = "Nenhum registro encontrado."
End If

Return pl_Linhas
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge001_selecao_produto_filial
integer x = 2793
integer y = 1684
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

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge001_selecao_produto_filial
integer x = 3191
integer y = 1684
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Produto

SetNull(lvs_Produto)

CloseWithReturn(Parent, lvs_Produto)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge001_selecao_produto_filial
integer x = 2199
integer y = 1684
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge001_selecao_produto_filial
integer x = 37
integer y = 1696
integer width = 2112
long backcolor = 80269524
end type

