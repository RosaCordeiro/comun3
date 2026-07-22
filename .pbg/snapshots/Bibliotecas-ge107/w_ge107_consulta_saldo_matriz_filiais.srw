HA$PBExportHeader$w_ge107_consulta_saldo_matriz_filiais.srw
forward
global type w_ge107_consulta_saldo_matriz_filiais from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge107_consulta_saldo_matriz_filiais from dc_w_selecao_lista_relatorio
integer width = 2752
integer height = 1876
string title = "GE107 - Consulta de Estoque de Outras Filiais"
long backcolor = 80269524
end type
global w_ge107_consulta_saldo_matriz_filiais w_ge107_consulta_saldo_matriz_filiais

type variables
uo_produto ivo_produto 

uo_filial ivo_filial 

String ivs_nr_ddd_telefone_estoque, &
          ivs_nr_telefone_estoque
end variables

forward prototypes
public subroutine wf_ordena_filiais ()
end prototypes

public subroutine wf_ordena_filiais ();Long ll_Filial
Long ll_Linha
Long ll_Cidade
Long ll_Find = 0
Long ll_Saldo
Long ll_Produto

dw_1.AcceptText( )

ll_Filial = gvo_Parametro.of_Filial()

If Not ivo_filial.localizada Then
	
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
	
End If // If ivo_filial.localizada Then

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
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na consulta do saldo online do produto " + String( ll_Produto ), StopSign! )	
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

on w_ge107_consulta_saldo_matriz_filiais.create
call super::create
end on

on w_ge107_consulta_saldo_matriz_filiais.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Filial)
end event

event ue_postopen;call super::ue_postopen;ivo_Produto = Create uo_Produto
ivo_Filial  = Create uo_Filial

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

Long lvl_Produto

If Not lvo_Parametro.of_Localiza_Parametro("NR_DDD_TELEFONE_ESTOQUE_CENTRAL", ref ivs_Nr_DDD_Telefone_Estoque) Then
	ivs_Nr_DDD_Telefone_Estoque = ''
End If
	
If Not lvo_Parametro.of_Localiza_Parametro("NR_TELEFONE_ESTOQUE_CENTRAL", ref ivs_Nr_Telefone_Estoque) Then
	ivs_Nr_Telefone_Estoque = ''
End If

lvl_Produto = Message.DoubleParm	

If lvl_Produto > 0 Then
	dw_1.Object.cd_produto[1] = lvl_Produto
End If

Destroy(lvo_Parametro)
	
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge107_consulta_saldo_matriz_filiais
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge107_consulta_saldo_matriz_filiais
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge107_consulta_saldo_matriz_filiais
integer x = 18
integer y = 268
integer width = 2679
integer height = 1404
string text = "Lista de Filiais"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge107_consulta_saldo_matriz_filiais
integer x = 18
integer y = 4
integer width = 1751
integer height = 252
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge107_consulta_saldo_matriz_filiais
integer x = 50
integer y = 56
integer width = 1705
integer height = 184
string dataobject = "dw_ge107_selecao_consulta_saldo"
end type

event dw_1::ue_key;String lvs_Coluna

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
					dw_1.Object.Cd_Filial  [1] = ivo_Filial.Cd_Filial
					dw_1.Object.Nm_Fantasia[1] = ivo_Filial.Nm_Fantasia
				End If
			End If
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.name
	Case "de_produto"
		If Trim(Data) <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If	
		Else			
			SetNull(ivo_Produto.Cd_Produto)
			ivo_Produto.ivs_Descricao_Apresentacao_Venda = ""
			
			This.Object.Cd_Produto [1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto [1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
		End If
		
	Case "nm_fantasia"
		If Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_Fantasia Then
				Return 1
			End If	
		Else			
			ivo_Filial.of_inicializa( )
			
			This.Object.Cd_Filial  [1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Fantasia[1] = ivo_Filial.Nm_Fantasia			
		End If
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge107_consulta_saldo_matriz_filiais
integer x = 50
integer y = 316
integer width = 2619
integer height = 1332
string dataobject = "dw_ge107_lista_consulta_saldo"
end type

event dw_2::ue_recuperar;// OverRide

Long lvl_Produto
Long lvl_Filial
Long lvl_Retorno = -1

String lvs_Retorno
String ls_Sql

Try
	Open( w_Aguarde )
	w_Aguarde.Title = "Realizando conex$$HEX1$$e300$$ENDHEX$$o com a matriz..."
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
	
	w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es da matriz..."
	
	ls_Sql = This.GetSQLSelect()
	ls_Sql = gf_Replace( ls_Sql, ":filial_parametro", String( gvo_parametro.cd_filial ), 0 )
	
	lvo_Conexao.of_Retrieve( ls_Sql, Ref lvs_Retorno)
	
	w_Aguarde.Title = "Atualizando informa$$HEX2$$e700f500$$ENDHEX$$es para apresenta$$HEX2$$e700e300$$ENDHEX$$o..."
	
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
	Destroy(lvo_Conexao)
	This.SetRedraw(True)
	Close( w_Aguarde )
	
End Try
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_filial"}

lvs_Nome = {"Filial"}

This.of_SetFilter(lvs_Coluna, lvs_Nome)		 


end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Integer lvi_Find

If pl_Linhas > 0 Then
	lvi_Find = dw_2.Find("cd_filial = " + String(gvo_Parametro.of_Filial_Matriz()), 1, dw_2.RowCount())
	
	If lvi_Find > 0 Then
		dw_2.Object.nr_ddd[lvi_Find] = ivs_Nr_DDD_Telefone_Estoque
		dw_2.Object.nr_telefone[lvi_Find] = ivs_Nr_Telefone_Estoque
	End If
End If

Return pl_Linhas
end event

event dw_2::itemfocuschanged;//OverRide


end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge107_consulta_saldo_matriz_filiais
integer x = 1806
integer y = 16
integer width = 261
integer height = 236
integer taborder = 50
end type

