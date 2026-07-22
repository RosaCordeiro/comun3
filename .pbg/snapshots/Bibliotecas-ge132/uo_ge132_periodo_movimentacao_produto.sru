HA$PBExportHeader$uo_ge132_periodo_movimentacao_produto.sru
forward
global type uo_ge132_periodo_movimentacao_produto from nonvisualobject
end type
end forward

global type uo_ge132_periodo_movimentacao_produto from nonvisualobject
end type
global uo_ge132_periodo_movimentacao_produto uo_ge132_periodo_movimentacao_produto

forward prototypes
public function boolean of_movimentacao_produto (long al_filial, long al_produto, long al_promocao, ref date adh_inclusao, ref date adh_primeira_entrada, ref date adh_primeira_venda, ref date adh_ultima_entrada, ref date adh_ultima_venda)
public function boolean of_recupera_informacoes (string as_id_tipo_promocao, st_ge132_filial_produto_promocao ast_filial_produto_promocao[], ref dc_uo_ds_base ads_excel)
end prototypes

public function boolean of_movimentacao_produto (long al_filial, long al_produto, long al_promocao, ref date adh_inclusao, ref date adh_primeira_entrada, ref date adh_primeira_venda, ref date adh_ultima_entrada, ref date adh_ultima_venda);String ls_Erro

SetNull (adh_Inclusao)

//Inclus$$HEX1$$e300$$ENDHEX$$o GC / C$$HEX1$$f300$$ENDHEX$$digo da promo$$HEX2$$e700e300$$ENDHEX$$o
Select Top 1 h.dh_alteracao
	Into :adh_Inclusao
From historico_promocao_estoque_min h
	Inner Join promocao_sos s
		On s.cd_promocao_sos = h.cd_promocao
Where h.cd_filial = :al_Filial
	And h.cd_produto = :al_Produto
	And h.cd_promocao = :al_Promocao
	And s.id_tipo_promocao = 'P'
	And s.dh_inicio <= (Select dh_movimentacao From parametro Where id_parametro = '1')
	And (s.dh_termino >= (Select dh_movimentacao From parametro Where id_parametro = '1') Or s.dh_termino Is Null)
	And coalesce(h.qt_estoque_minimo_anterior, 0) <> coalesce(h.qt_estoque_minimo_atual, 0)
Order By h.dh_alteracao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0

	Case 100
		
	Case -1
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_RollBack();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar a data de inclus$$HEX1$$e300$$ENDHEX$$o do produto '" + String(al_Produto) + "' na filial '" + String(al_Filial) + "'. " + ls_Erro, StopSign!)
		Return False
End Choose

SetNull(adh_Primeira_Entrada)

//Primeira Entrada
Select Min(dh_movimento)
	Into: adh_Primeira_Entrada
From movimento_estoque
Where cd_filial_movimento = :al_Filial
	And cd_produto = :al_Produto
	And dh_movimento >= '20110101'
	And cd_tipo_movimento In (3,5,8)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar a primeira entrada na filial '" + String(al_Filial) + "' do produto '" + String(al_Produto) + "'. " + ls_Erro, StopSign!)
	Return False
End If

SetNull(adh_Primeira_Venda)

//Primeira Venda
Select Min(dh_movimento)
	Into: adh_Primeira_Venda
From movimento_estoque
Where cd_filial_movimento = :al_Filial
	And cd_produto = :al_Produto
	And dh_movimento >= '20110101'
	And cd_tipo_movimento In (1)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar a primeira venda na filial '" + String(al_Filial) + "' do produto '" + String(al_Produto) + "'. " + ls_Erro, StopSign!)
	Return False
End If

SetNull(adh_Ultima_Entrada)

//$$HEX1$$da00$$ENDHEX$$ltima Entrada
Select Max(dh_movimento)
	Into: adh_Ultima_Entrada
From movimento_estoque
Where cd_filial_movimento = :al_Filial
	And cd_produto = :al_Produto
	And dh_movimento >= '20110101'
	And cd_tipo_movimento In (3,5,8)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar a $$HEX1$$fa00$$ENDHEX$$ltima entrada na filial '" + String(al_Filial) + "' do produto '" + String(al_Produto) + "'. " + ls_Erro, StopSign!)
	Return False
End If

SetNull(adh_Ultima_Venda)

//$$HEX1$$da00$$ENDHEX$$ltima Venda
Select Max(dh_movimento)
	Into: adh_Ultima_Venda
From movimento_estoque
Where cd_filial_movimento = :al_Filial
	And cd_produto = :al_Produto
	And dh_movimento >= '20110101'
	And cd_tipo_movimento In (1)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar a $$HEX1$$fa00$$ENDHEX$$ltima venda na filial '" + String(al_Filial) + "' do produto '" + String(al_Produto) + "'. " + ls_Erro, StopSign!)
	Return False
End If

Return True
end function

public function boolean of_recupera_informacoes (string as_id_tipo_promocao, st_ge132_filial_produto_promocao ast_filial_produto_promocao[], ref dc_uo_ds_base ads_excel);Date ldh_Inclusao
Date ldh_Primeira_Entrada
Date ldh_Primeira_Venda
Date ldh_Ultima_Entrada
Date ldh_Ultima_Venda

Long ll_Linha
Long ll_Linhas
Long ll_Linha_st
Long ll_Linha_excel
Long ll_Filial
Long ll_Produto
Long ll_Promocao

String	ls_Nm_Filial
String	ls_De_Produto
String	ls_Nm_Promocao
String	ls_Titulo

dc_uo_ds_base lds

Try
	
	lds = Create dc_uo_ds_base
		
	If Not lds.of_ChangeDataObject ('ds_ge132_promocao_filial_produto') Then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro ao carregar a ds 'ds_ge132_promocao_filial_produto'.", StopSign!)
		Return False
	End If
	
	For ll_Linha_st = 1 to UpperBound (ast_filial_produto_promocao[])

		If ast_filial_produto_promocao[ll_Linha_st].cd_filial <> 0 then
			lds.of_AppendWhere ('f.cd_filial = ' + String (ast_filial_produto_promocao[ll_Linha_st].cd_filial))
			ls_Titulo = 'Filial: ' + String (ast_filial_produto_promocao[ll_Linha_st].cd_filial)
		End If
		
		If ast_filial_produto_promocao[ll_Linha_st].cd_produto <> 0 then
			lds.of_AppendWhere ('pg.cd_produto = ' + String (ast_filial_produto_promocao[ll_Linha_st].cd_produto))
			If ls_Titulo <> '' then
				ls_Titulo += ' / '
			End if
			ls_Titulo += 'Produto: ' + String (ast_filial_produto_promocao[ll_Linha_st].cd_produto)
		End If
		
		If ast_filial_produto_promocao[ll_Linha_st].cd_promocao_sos <> 0 then
			lds.of_AppendWhere ('ps.cd_promocao_sos = ' + String (ast_filial_produto_promocao[ll_Linha_st].cd_promocao_sos))
			If ls_Titulo <> '' then
				ls_Titulo += ' / '
			End if
			ls_Titulo += 'Promo$$HEX2$$e700e300$$ENDHEX$$o: ' + String (ast_filial_produto_promocao[ll_Linha_st].cd_promocao_sos)
		End If
		
		If Not IsNull (as_id_tipo_promocao) and as_id_tipo_promocao <> '' and as_id_tipo_promocao <> 'T' then
			lds.of_AppendWhere ("ps.id_tipo_promocao = '" + as_id_tipo_promocao + "'")
		End if
		
		ll_Linhas = lds.Retrieve()
		
		If ll_Linhas < 0 Then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro no retrieve da dw 'ds_ge132_promocao_filial_produto'.", StopSign!)
			Return False
		End If
		
		lds.of_RestoreSqlOriginal ()
		w_Aguarde.Title = 'Gerando dados... ' + ls_Titulo + '. Aguarde...'
		w_aguarde.uo_progress.of_setmax (ll_Linhas)

		For ll_Linha = 1 To ll_Linhas
			w_aguarde.uo_progress.of_setprogress (ll_Linha)
			
			ll_Filial   = lds.Object.Cd_Filial       [ll_Linha]
			ll_Produto  = lds.Object.Cd_Produto      [ll_Linha]
			ll_Promocao = lds.Object.Cd_Promocao_sos [ll_Linha]
				
			If Not of_Movimentacao_Produto (ll_Filial, ll_Produto, ll_Promocao, Ref ldh_Inclusao, Ref ldh_Primeira_Entrada, Ref ldh_Primeira_Venda, Ref ldh_Ultima_Entrada, Ref ldh_Ultima_Venda) Then Return False
			
			ll_Linha_excel = ads_excel.InsertRow(0)
			ads_excel.Object.Cd_Filial           [ll_Linha_excel] = ll_Filial
			ads_excel.Object.Cd_Produto          [ll_Linha_excel] = ll_Produto
			ads_excel.Object.Cd_Promocao_sos     [ll_Linha_excel] = ll_Promocao
			ads_excel.Object.Nm_Filial           [ll_Linha_excel] = lds.Object.Nm_Fantasia     [ll_Linha]
			ads_excel.Object.De_Produto          [ll_Linha_excel] = lds.Object.De_Produto      [ll_Linha]
			ads_excel.Object.Nm_Promocao_sos     [ll_Linha_excel] = lds.Object.Nm_Promocao_sos [ll_Linha]
			ads_excel.Object.Dh_Inclusao         [ll_Linha_excel] = ldh_Inclusao
			ads_excel.Object.Dh_Primeira_Entrada [ll_Linha_excel] = ldh_Primeira_Entrada
			ads_excel.Object.Dh_Primeira_Venda   [ll_Linha_excel] = ldh_Primeira_Venda
			ads_excel.Object.Dh_Ultima_Entrada   [ll_Linha_excel] = ldh_Ultima_Entrada
			ads_excel.Object.Dh_Ultima_Venda     [ll_Linha_excel] = ldh_Ultima_Venda
			
		Next
	Next
	
Finally
	Destroy (lds)
End Try

Return True
end function

on uo_ge132_periodo_movimentacao_produto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge132_periodo_movimentacao_produto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

