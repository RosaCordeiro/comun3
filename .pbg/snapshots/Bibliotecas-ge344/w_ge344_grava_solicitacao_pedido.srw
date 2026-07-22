HA$PBExportHeader$w_ge344_grava_solicitacao_pedido.srw
forward
global type w_ge344_grava_solicitacao_pedido from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge344_grava_solicitacao_pedido
end type
type cb_importar from commandbutton within w_ge344_grava_solicitacao_pedido
end type
type gb_2 from groupbox within w_ge344_grava_solicitacao_pedido
end type
type str_solicitacao from structure within w_ge344_grava_solicitacao_pedido
end type
end forward

type str_solicitacao from structure
	long		cd_produto
	long		qt_pedida
	decimal {2}		vl_custo_unitario
	string		id_atualiza
end type

global type w_ge344_grava_solicitacao_pedido from dc_w_response_ok_cancela
integer width = 2583
integer height = 1860
string title = "GE344 - Grava Solicita$$HEX2$$e700e300$$ENDHEX$$o de Pedido Almoxarifado"
dw_2 dw_2
cb_importar cb_importar
gb_2 gb_2
end type
global w_ge344_grava_solicitacao_pedido w_ge344_grava_solicitacao_pedido

type variables
Boolean	ib_Check, &
			ib_Confirmou_Adicao

String	is_Tipo
end variables

forward prototypes
public function boolean wf_le_dados_planilha ()
public function boolean wf_preenche_custo_unitario (long al_produto, ref decimal ad_custo_unitario)
public function boolean wf_localiza_filial (long al_filial, ref string as_nome_fantasia, ref string as_uf_filial)
public function boolean wf_localiza_produto (long al_produto, ref string as_descricao, ref decimal adc_fat_conv, ref string as_uf_produto, ref long al_mix_produto)
public function boolean wf_verifica_resumo_reposicao_estoque (long al_filial, long al_produto, long al_mix_produto, ref long al_achou)
public function boolean wf_grava_cabecalho_solicitacao (date adt_pedido, long al_filial, ref long al_solicitacao)
public function boolean wf_atualiza_valor_solicitacao (long al_solicitacao, long al_filial, decimal adc_custo_total)
public function boolean wf_verifica_bloqueio (long al_filial, date adt_pedido)
public function boolean wf_verifica_saldo (long al_produto, ref long al_saldo)
public function boolean wf_grava_item_solicitacao (long al_solicitacao, long al_filial, boolean ab_solic_nova, str_solicitacao astr_solic[], ref decimal adc_valor_total)
public function boolean wf_verifica_solicitacao_ativa (date adt_data_pedido, long al_filial, ref long al_solicitacao)
end prototypes

public function boolean wf_le_dados_planilha ();//DECLARA$$HEX2$$c700d500$$ENDHEX$$ES
Any			la_Dado
Any			la_Nulo

Boolean		lb_eferiado

Date			ldt_Data_Pedido
Date			ldt_Hoje
dc_uo_excel	lo_Excel

Decimal		ldc_Custo_Unit
Decimal		ldc_Fat_Conv

Integer		li_Dia

Long			ll_Linha
Long			ll_Linhas
Long			ll_Produto
Long			ll_Qtd_Prod
Long			ll_Achou
Long			ll_Find
Long			ll_Linha_Dw = 0
Long			ll_Filial
Long			ll_Filial_Ant
Long			ll_Mix
Long			ll_Fat_Conv
Long			ll_Saldo

String		ls_Arquivo
String		ls_Descricao_Prod
String		ls_Nome_Fantasia
String		ls_UF_Produto
String		ls_UF_Filial
String		ls_UF_Divergente = 'N'

//PROCEDIMENTOS

SetNull (ll_Filial_Ant)

Try
	
	ldt_Hoje = Date (gf_GetServerDate ())
	lo_Excel = Create dc_uo_excel
	
	ls_Arquivo = dw_1.Object.De_Arquivo [1]
	
	Open (w_Aguarde)
	w_Aguarde.Title = 'Importando o arquivo: ' + ls_Arquivo + '...'
	
	SetNull (la_Nulo)
	
	SetRedraw (False)
	
	/* Solicita$$HEX2$$e700e300$$ENDHEX$$o de Pedido - Coluna A: C$$HEX1$$f300$$ENDHEX$$digo Filial, B: C$$HEX1$$f300$$ENDHEX$$digo Produto, C: Data Pedido, D: Qtd Pedida */
	
	// Referencia o arquivo 
	If lo_Excel.uo_Referencia_Objeto_Excel (ls_Arquivo) then
		
		ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo ('A')
		
		If ll_Linhas > 0 then
			w_Aguarde.uo_Progress.of_SetMax (ll_Linhas)
			
			For ll_Linha = 1 To ll_Linhas
				//
				//Coluna A - C$$HEX1$$f300$$ENDHEX$$digo da filial //////////////////////////////////////////////////////////////////////////////////
				//
				la_Dado = lo_Excel.uo_Lendo_Dados (ll_Linha, 'A')
				
				If Not IsNumber (String (la_Dado)) or IsNull (String (la_Dado)) then
					MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'C$$HEX1$$f300$$ENDHEX$$digo da filial $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido na linha [ ' + String (ll_Linha) + ' ]. ~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ inclu$$HEX1$$ed00$$ENDHEX$$do na lista.', Exclamation!)
					Continue
				End if
				
				ll_Filial = Long (la_Dado)
				
				If IsNull (ll_Filial_Ant) or ll_Filial <> ll_Filial_Ant then
					ll_Filial_Ant = ll_Filial
					If Not wf_Localiza_Filial (ll_Filial, Ref ls_Nome_Fantasia, Ref ls_UF_Filial) then Return False
				End if
				
				//Filial inv$$HEX1$$e100$$ENDHEX$$lida/n$$HEX1$$e300$$ENDHEX$$o localizada
				If ls_Nome_Fantasia = 'X' then
					Continue
				End if
				
				//
				//Coluna B - C$$HEX1$$f300$$ENDHEX$$digo do produto //////////////////////////////////////////////////////////////////////////////////
				//
				la_Dado = lo_Excel.uo_Lendo_Dados (ll_Linha, 'B')
				
				If Not IsNumber (String (la_Dado)) or IsNull (String (la_Dado)) then
					MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'C$$HEX1$$f300$$ENDHEX$$digo do produto $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido na linha [ ' + String (ll_Linha) + ' ]. ~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ inclu$$HEX1$$ed00$$ENDHEX$$do na lista.', Exclamation!)
					Continue
				End if
				
				ll_Produto = Long (la_Dado)
				
				If Not wf_Localiza_Produto (ll_Produto, Ref ls_Descricao_Prod, Ref ldc_Fat_Conv, Ref ls_UF_Produto, Ref ll_Mix) then Return False
				
				//Produto inv$$HEX1$$e100$$ENDHEX$$lido/n$$HEX1$$e300$$ENDHEX$$o localizado
				If ls_Descricao_Prod = 'X' then
					Continue
				End if
				
				ll_Fat_Conv = Long (ldc_Fat_Conv)
				
				//
				//Coluna C - Data para gera$$HEX2$$e700e300$$ENDHEX$$o do pedido //////////////////////////////////////////////////////////////////////////////////
				//
				la_Dado = lo_Excel.uo_Lendo_Dados (ll_Linha, 'C')
				
				If Not IsDate (String (la_Dado, 'YYYY-MM-DD')) then
					MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A data para cria$$HEX2$$e700e300$$ENDHEX$$o do pedido est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida na linha [ ' + String (ll_Linha) + ' ]. ~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ inclu$$HEX1$$ed00$$ENDHEX$$do na lista.')
					Continue
				End if
				
				ldt_Data_Pedido = Date (la_Dado)
				
				If ldt_Data_Pedido < ldt_Hoje then
					MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A data para cria$$HEX2$$e700e300$$ENDHEX$$o do pedido na linha [ ' + String (ll_Linha) + ' ] n$$HEX1$$e300$$ENDHEX$$o pode ser anterior a hoje. ~rCorrija o arquivo.')
					Return False
				End if
				
				ll_Find = dw_2.Find ('cd_produto = ' + String (ll_Produto) + ' and cd_filial = ' + String (ll_Filial) + " and dh_pedido = Date ('" + String (ldt_Data_Pedido, 'YYYY/MM/DD') + "')", 1, dw_2.RowCount())
				
				If ll_Find > 0 then
					MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O produto [ ' + String (ll_Produto) + ' ] foi informado mais de uma vez na planilha para a filial [ ' + String (ll_Filial) + ' ] na mesma data.' + &
									'~rSomente o primeiro registro ser$$HEX1$$e100$$ENDHEX$$ considerado.', Exclamation!)
					Continue
				End if
				
				li_Dia = DayNumber (ldt_Data_Pedido)
				
				Choose case li_Dia
					case 1, 2, 7
						MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A data para cria$$HEX2$$e700e300$$ENDHEX$$o do pedido na linha [ ' + String (ll_Linha) + ' ] cai em um S$$HEX1$$e100$$ENDHEX$$bado, Domingo ou Segunda-Feira, o que n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido. ~rCorrija o arquivo.')
						Return False
					case else
						//ver feriado
						
						If not gf_verifica_feriado ('M', 1, ldt_Data_Pedido, Ref lb_eferiado) then 
							SQLCA.of_MsgDBError ('Erro na consulta $$HEX1$$e000$$ENDHEX$$ tabela de feriados')
							Return False
						else
							If lb_eferiado then
								MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A data para cria$$HEX2$$e700e300$$ENDHEX$$o do pedido na linha [ ' + String (ll_Linha) + ' ] cai num feriado, o que n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido. ~rCorrija o arquivo.')
								Return False
							End if
						End if
						
						If not wf_verifica_bloqueio (ll_Filial, ldt_Data_Pedido) then Return False
						
				End Choose
				
				//
				//Coluna D - Quantidade pedida do produto //////////////////////////////////////////////////////////////////////////////////
				//
				la_Dado = lo_Excel.uo_Lendo_Dados (ll_Linha, 'D')
				
				If Not IsNumber (String (la_Dado)) then
					MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Quantidade pedida do produto $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida na linha [ ' + String (ll_Linha) + ' ]. ~rSer$$HEX1$$e100$$ENDHEX$$ inclu$$HEX1$$ed00$$ENDHEX$$do na lista com quantidade nula.')
					la_Dado = la_Nulo
				End if
				
				ll_Qtd_Prod = Long (la_Dado)
				
				If not wf_verifica_saldo (ll_Produto, Ref ll_Saldo) then Return False
				
				If ll_Saldo < ll_Qtd_Prod * ll_Fat_Conv then
					MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Saldo insuficiente para o produto na linha [ ' + String (ll_Linha) + ' ]. ~rCorrija o arquivo.')
					Return False
				End if
				
				If Not wf_Preenche_Custo_Unitario (ll_Produto, Ref ldc_Custo_Unit) then Return False
				
				If Not wf_Verifica_Resumo_Reposicao_Estoque (ll_Filial, ll_Produto, ll_Mix, Ref ll_Achou) then Return False
				
				ll_Linha_Dw = dw_2.InsertRow (0)
				
				//Se achou na resumo_reposicao_estoque
				If ll_Achou = 0 then
					dw_2.Object.Id_Divergencia [ll_Linha_Dw] = 1
					dw_2.Object.Id_Selecionado [ll_Linha_Dw] = 'N'
				else
					dw_2.Object.Id_Divergencia [ll_Linha_Dw] = 0
					dw_2.Object.Id_Selecionado [ll_Linha_Dw] = 'S'
				End if
				
				dw_2.Object.dh_pedido   [ll_Linha_Dw] = ldt_Data_Pedido
				dw_2.Object.Cd_Filial   [ll_Linha_Dw] = ll_Filial
				dw_2.Object.Nm_Fantasia [ll_Linha_Dw] = ls_Nome_Fantasia
				
				If is_Tipo = 'E' then
					If ls_UF_Produto <> ls_UF_Filial or IsNull (ls_UF_Produto) Or ls_UF_Produto = '' then
						ls_UF_Divergente                           = 'S'
						dw_2.Object.Id_UF_Divergente [ll_Linha_Dw] = 1
						dw_2.Object.Id_Selecionado   [ll_Linha_Dw] = 'N'
					End if
				End if
				
				dw_2.Object.Cd_Produto         [ll_Linha_Dw] = ll_Produto
				dw_2.Object.De_Produto         [ll_Linha_Dw] = ls_Descricao_Prod
				dw_2.Object.Qtd_Produto        [ll_Linha_Dw] = ll_Qtd_Prod
				dw_2.Object.Vl_Custo           [ll_Linha_Dw] = ldc_Custo_Unit
				dw_2.Object.Vl_Fator_Conversao [ll_Linha_Dw] = ll_Fat_Conv
				dw_2.Object.Cd_UF_Produto      [ll_Linha_Dw] = ls_UF_Produto
				dw_2.Object.Cd_UF_Filial       [ll_Linha_Dw] = ls_UF_Filial
			Next
			
			If dw_2.RowCount () > 0 then
				cb_Ok.Enabled = True
			End if
		End if
	End if
	
	Return True
	
Finally
	Close (w_Aguarde)
	If IsValid (lo_Excel) then Destroy (lo_Excel)
	
	SetRedraw (True)
	
	dw_2.SetFocus ()
	dw_2.Sort ()
	dw_2.GroupCalc ()
	
	dw_2.of_SetRowSelection ('if (id_uf_divergente > 0, if (getrow () = currentrow (), RGB (255, 0, 0), RGB (255, 255, 255)), if (getrow () = currentrow (), RGB (0, 128, 128), RGB (255, 255, 255)))', 'if (id_uf_divergente > 0, RGB (255, 0, 0), RGB(0, 0, 0))', False)
	
	If is_Tipo = 'E' then
		If ls_UF_Divergente = 'S' then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Existem produtos com diverg$$HEX1$$ea00$$ENDHEX$$ncia entre UF do produto e UF da filial, ou UF do produto n$$HEX1$$e300$$ENDHEX$$o cadastrada.')
		End if
	End if
	
End Try
end function

public function boolean wf_preenche_custo_unitario (long al_produto, ref decimal ad_custo_unitario);Select Coalesce(vl_custo_gerencial, 0)
	Into :ad_custo_unitario
From vw_saldo_atual_produto
Where cd_filial = 534
   And cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
		
	Case 100
		ad_custo_unitario = 0
		
	Case -1
		SqlCa.of_MsgdbError("Erro ao localizar o custo unit$$HEX1$$e100$$ENDHEX$$rio do produto na vw_saldo_atual_produto")
		Return False
		
End Choose
end function

public function boolean wf_localiza_filial (long al_filial, ref string as_nome_fantasia, ref string as_uf_filial);Select nm_fantasia, cd_uf
	Into :as_Nome_Fantasia, :as_UF_Filial
From vw_filial
Where cd_filial = :al_Filial
	And cd_filial Not In(534)
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo da filial '" + String(al_Filial) + "' $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido ou inativo. ~n~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ inclu$$HEX1$$ed00$$ENDHEX$$do na lista.", Exclamation!)
		as_Nome_Fantasia = "X"
		
	Case -1
		SqlCa.of_MsgdbError("Erro ao localizar o nome da filial")
		Return False
End Choose

Return True
end function

public function boolean wf_localiza_produto (long al_produto, ref string as_descricao, ref decimal adc_fat_conv, ref string as_uf_produto, ref long al_mix_produto);String ls_Descricao
String ls_Apresentacao_Estoque
String ls_Grupo

Select g.de_produto, g.de_apresentacao_estoque, substring(g.cd_subcategoria, 1, 1), g.vl_fator_conversao, c.cd_uf_encarte, c.cd_mix_produto
Into :ls_Descricao, :ls_Apresentacao_Estoque, :ls_Grupo, :adc_Fat_Conv, :as_Uf_Produto, :al_mix_produto
From produto_geral g
	Inner Join produto_central c
		On c.cd_produto = g.cd_produto
Where g.cd_produto = :al_produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		as_Descricao = ls_Descricao + " : " + ls_Apresentacao_Estoque
		
		If ls_Grupo <> '5' Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto '" + as_Descricao + "' c$$HEX1$$f300$$ENDHEX$$digo '" + String(al_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ almoxarifado.", Exclamation!)
			as_Descricao = "X"
		End If
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto '" + String(al_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", Exclamation!)
		as_Descricao = "X"
		
	Case -1
		SqlCa.of_MsgdbError("Erro ao localizar o produto na tabela PRODUTO_GERAL na fun$$HEX2$$e700e300$$ENDHEX$$o wf_localiza_produto")
		Return False
End Choose

Return True
end function

public function boolean wf_verifica_resumo_reposicao_estoque (long al_filial, long al_produto, long al_mix_produto, ref long al_achou);//O Mix 2 $$HEX1$$e900$$ENDHEX$$ [SOMENTE ENCOMENDA]. Se for este Mix n$$HEX1$$e300$$ENDHEX$$o passa na valida$$HEX2$$e700e300$$ENDHEX$$o abaixo, o produto n$$HEX1$$e300$$ENDHEX$$o necessariamente precisa estar no mix da loja.
If al_mix_produto = 2 Then
	al_Achou = 1
	Return True
End If
		
Select Count(*)
	Into :al_Achou
From resumo_reposicao_estoque
Where cd_filial		= :al_Filial
	And cd_produto= :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
		
	Case -1
		SqlCa.of_MsgdbError("Erro ao localizar o produto na RESUMO_REPOSICAO_ESTOQUE")
		Return False
End Choose
end function

public function boolean wf_grava_cabecalho_solicitacao (date adt_pedido, long al_filial, ref long al_solicitacao);If IsNull (al_solicitacao) then
	SELECT COALESCE (MAX (nr_solicitacao), 0) + 1
	  INTO :al_solicitacao
	  FROM pedido_solicitacao
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		SQLCA.of_MsgdbError ('Erro ao obter o n$$HEX1$$fa00$$ENDHEX$$mero da pr$$HEX1$$f300$$ENDHEX$$xima solicita$$HEX2$$e700e300$$ENDHEX$$o: ' + SQLCA.SqlErrText)
		SQLCA.of_RollBack ()
		Return False
	End if
	
	INSERT INTO pedido_solicitacao (
				nr_solicitacao
			,	cd_filial
			,	dh_pedido
			,	id_situacao
			,	nr_matricula_cadastramento
			,	id_tipo_pedido
			,	vl_custo_total
			,	dh_inclusao
				)
		VALUES (
				:al_solicitacao
			,	:al_filial
			,	:adt_pedido
			,	'A'
			,	:gvo_aplicacao.ivo_Seguranca.Nr_Matricula
			,	:is_Tipo
			,	0
			,	GETDATE ()
				)
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0  then
		SQLCA.of_RollBack ()
		SQLCA.of_MsgdbError ('Erro ao gravar o cabe$$HEX1$$e700$$ENDHEX$$alho da solicita$$HEX2$$e700e300$$ENDHEX$$o: ' + SQLCA.SqlErrText)
		Return False
	End If
End if

Return True
end function

public function boolean wf_atualiza_valor_solicitacao (long al_solicitacao, long al_filial, decimal adc_custo_total);UPDATE pedido_solicitacao
	SET vl_custo_total = vl_custo_total + :adc_custo_total
 WHERE nr_solicitacao = :al_solicitacao
 	AND cd_filial      = :al_filial
 USING SQLCA;

If SQLCA.SQLCode < 0 then
	SQLCA.of_RollBack ()
	SQLCA.of_MsgDBError ('Erro ao atualizar o valor da solicita$$HEX2$$e700e300$$ENDHEX$$o')
	Return False
End if

Return True
end function

public function boolean wf_verifica_bloqueio (long al_filial, date adt_pedido);Long	ll_Achou

SELECT COUNT (*)
  INTO :ll_Achou
  FROM pedido_filial_bloqueio
 WHERE id_tipo_bloqueio = 'D'
	AND cd_filial        = :al_filial
 	AND (dh_pedido       = :adt_pedido
	 OR  :adt_pedido     BETWEEN dh_inicio_bloqueio AND dh_termino_bloqueio)
 USING SQLCA;

If SQLCA.SQLCode < 0 then
	SQLCA.of_MsgDBError ('Erro ao verificar se existe bloqueio de pedido para a filial ' + String (al_filial) + ' no dia ' + String (adt_pedido, 'DD/MM/YYYY'))
	Return False
End if

If ll_Achou > 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Existe bloqueio de pedido para a filial ' + String (al_filial) + ' no dia ' + String (adt_pedido, 'DD/MM/YYYY') + '. Corrija o arquivo.', Exclamation!)
	Return False
End if

Return True
end function

public function boolean wf_verifica_saldo (long al_produto, ref long al_saldo);SELECT SUM (qt_caixa_padrao * qt_saldo)
  INTO :al_saldo
  FROM wms_localizacao
 WHERE cd_produto = :al_produto
 USING SQLCA;

If SQLCA.SQLCode < 0 then
	SQLCA.of_msgdberror ('Erro ao verificar o saldo do produto ' + String (al_produto))
	Return False
End if

Return True
end function

public function boolean wf_grava_item_solicitacao (long al_solicitacao, long al_filial, boolean ab_solic_nova, str_solicitacao astr_solic[], ref decimal adc_valor_total);//DECLARA$$HEX2$$c700d500$$ENDHEX$$ES
Boolean	lb_insere

Decimal	ldc_custo_unit, &
			ldc_custo_anterior

Long		ll_Linha,         &
			ll_Linhas,        &
			ll_Produto,       &
			ll_Qtde,          &
			ll_Qtde_Anterior
//			, &
//			ll_Qtde_Selec

//PROCEDIMENTOS
//ll_Qtde_Selec = 0
ll_Linhas     = UpperBound (astr_solic [])

For ll_Linha = 1 To ll_Linhas
	
//	If astr_solic [ll_Linha].id_Atualiza = 'N' then Continue
	
//	ll_Qtde_Selec ++
	
	lb_insere          = False
	ll_Produto         = astr_solic [ll_Linha].cd_produto
	ll_Qtde            = astr_solic [ll_Linha].qt_pedida
	ldc_custo_unit     = astr_solic [ll_Linha].vl_custo_unitario
	ll_Qtde_Anterior   = 0
	ldc_custo_anterior = 0
	
	If not ab_solic_nova then
		
		SELECT qt_pedida
			  , vl_custo_unitario
		  INTO :ll_Qtde_Anterior
		     , :ldc_custo_anterior
		  FROM pedido_solicitacao_produto
		 WHERE nr_solicitacao = :al_solicitacao
			AND cd_filial      = :al_Filial
			AND cd_produto     = :ll_Produto
		 USING SQLCA;
		
		Choose Case SQLCA.SqlCode
			Case 0
				
				ll_Qtde += ll_Qtde_Anterior
				
				UPDATE pedido_solicitacao_produto
					SET qt_pedida         = :ll_Qtde
					  , vl_custo_unitario = :ldc_custo_unit
				 WHERE nr_solicitacao = :al_solicitacao
					AND cd_filial      = :al_Filial
					AND cd_produto     = :ll_Produto
				 USING SQLCA;
				
				If SQLCA.SqlCode < 0 then
					SQLCA.of_RollBack ()
					SQLCA.of_MsgdbError ('Erro ao atualizar o produto na solicita$$HEX2$$e700e300$$ENDHEX$$o')
					Return False
				End if
				
			Case 100
				
				lb_insere = True
				
			Case is < 0
				SQLCA.of_RollBack ()
				SQLCA.of_MsgdbError ('Erro ao pesquisar o produto na solicita$$HEX2$$e700e300$$ENDHEX$$o')
				Return False
		End Choose
		
	else
		lb_insere = True
	End if
	
	If lb_insere then
		INSERT INTO pedido_solicitacao_produto (
					nr_solicitacao
				,	cd_filial
				,	cd_produto
				,	qt_pedida
				,	vl_custo_unitario
				)
			VALUES (
					:al_solicitacao
				,	:al_filial
				,	:ll_Produto
				,	:ll_Qtde
				,	:ldc_custo_unit
				)
		USING SQLCA;
		
		If SQLCA.SQLCode < 0 then
			SQLCA.of_RollBack ()
			SQLCA.of_MsgdbError ('Erro ao inserir o item na solicita$$HEX2$$e700e300$$ENDHEX$$o: ' + SQLCA.SqlErrText)
			Return False
		End If
		
	End if
	
	adc_valor_total += (ll_qtde * ldc_custo_unit) - (ll_Qtde_Anterior * ldc_custo_anterior)
Next

////Se n$$HEX1$$e300$$ENDHEX$$o tem nenhum produto para atualizar faz o RollBack() para deletar o cabe$$HEX1$$e700$$ENDHEX$$alho
//If ll_Qtde_Selec = 0 then
//	SQLCA.of_RollBack ()
//End if

Return True
end function

public function boolean wf_verifica_solicitacao_ativa (date adt_data_pedido, long al_filial, ref long al_solicitacao);SELECT nr_solicitacao
  INTO :al_solicitacao
  FROM pedido_solicitacao
 WHERE dh_pedido      = :adt_data_pedido
 	AND cd_filial      = :al_filial
	AND id_tipo_pedido = :is_Tipo
 	AND id_situacao    = 'A'
 USING SQLCA;

Choose case SQLCA.SQLCode
	case 100
		SetNull (al_solicitacao)
	case is < 0
		SQLCA.of_msgdberror ('Erro ao verificar se j$$HEX1$$e100$$ENDHEX$$ existe solicita$$HEX2$$e700e300$$ENDHEX$$o de pedido ainda pendente para a mesma data/filial')
		Return False
	case 0
		If not ib_Confirmou_Adicao then
			If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
								'J$$HEX1$$e100$$ENDHEX$$ existe uma solicita$$HEX2$$e700e300$$ENDHEX$$o para gerar pedido do mesmo tipo para a filial ' + String (al_filial) + ' em ' + String (adt_data_pedido, 'dd/mm/yyyy') + '. ~n~r~r' + &
								'Os produtos desta planilha e suas quantidades ser$$HEX1$$e300$$ENDHEX$$o ADICIONADOS $$HEX1$$e000$$ENDHEX$$ solicita$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ existente.' + ' ~n~r' + &
								'O mesmo procedimento ser$$HEX1$$e100$$ENDHEX$$ adotado se houver, nesta planilha, outros casos assim.' + ' ~n~r~r' + &
								'Se n$$HEX1$$e300$$ENDHEX$$o quiser ADICIONAR os produtos $$HEX1$$e000$$ENDHEX$$(s) solicita$$HEX2$$e700e300$$ENDHEX$$o($$HEX1$$f500$$ENDHEX$$es) existentes, cancele e altere as datas na planilha.', &
								Question!, OkCancel!, 2) = 2 then
				Return False
			End if
			
			ib_Confirmou_Adicao = True
		End if
End Choose

Return True
end function

on w_ge344_grava_solicitacao_pedido.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_importar=create cb_importar
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_importar
this.Control[iCurrent+3]=this.gb_2
end on

on w_ge344_grava_solicitacao_pedido.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_importar)
destroy(this.gb_2)
end on

event ue_postopen;call super::ue_postopen;If is_Tipo <> 'E' then
	dw_2.Object.T_3.Visible = False
	dw_2.Object.T_4.Visible = False
End if

Choose Case is_Tipo
	Case 'A'
		This.Title = "GE344 - Grava Solicita$$HEX2$$e700e300$$ENDHEX$$o Pedido Almoxarifado"
	Case 'E'
		This.Title = 'GE344 - Grava Solicita$$HEX2$$e700e300$$ENDHEX$$o Pedido Empurrado - ENCARTE'
End Choose

dw_2.of_SetRowSelection ()

dw_1.SetFocus ()
end event

event open;call super::open;is_Tipo = Message.StringParm
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge344_grava_solicitacao_pedido
integer x = 0
integer y = 112
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge344_grava_solicitacao_pedido
integer width = 2281
integer height = 180
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge344_grava_solicitacao_pedido
integer width = 2217
integer height = 100
string dataobject = "dw_ge344_selecao_solicitacao_response"
end type

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset ()
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset ()
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge344_grava_solicitacao_pedido
integer x = 1399
integer y = 1648
integer width = 809
boolean enabled = false
string text = "Gravar Solicita$$HEX2$$e700e300$$ENDHEX$$o de Pedido"
end type

event cb_ok::clicked;call super::clicked;//DECLARA$$HEX2$$c700d500$$ENDHEX$$ES
Boolean				lb_Sucesso   = True
Boolean				lb_Alteracao = False
Boolean				lb_Solicitacao_Nova

Date					ldt_Pedido
Date					ldt_Prox_Data

dc_uo_ds_base		lds_itens

Decimal {2}			ldc_vl_total

Long					ll_Find
Long					ll_Filial
Long					ll_Solicitacao
Long					ll_Lin_Sel
Long					ll_Linhas
Long					ll_Fator
Long					ll_Qtd_Pedida
Long					ll_Produto
Long					ll_Nulo
Long					ll_Contador
Long					ll_Filial_Proxima

str_solicitacao	lstr_solic []
str_solicitacao	lstr_Nulo []

//PROCEDIMENTOS
SetNull (ll_Nulo)

dw_2.AcceptText ()

ll_Linhas = dw_2.RowCount ()
ll_Find   = dw_2.Find ("id_selecionado = 'S'", 1, ll_Linhas)

If ll_Find < 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro no Find da dw_2 no campo id_selecionado.', StopSign!)
	Return -1
End if

If ll_Find = 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Nenhum produto foi selecionado.')
	dw_2.SetFocus ()
	Return -1
End if

If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Confirma a gera$$HEX2$$e700e300$$ENDHEX$$o da solicita$$HEX2$$e700e300$$ENDHEX$$o de pedido?', Question!, YesNo!, 2) = 2 then
	Return -1
End if

ll_Find = dw_2.Find ('IsNull (qtd_produto) or qtd_produto <= 0', 1, ll_Linhas)

If ll_Find < 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro no Find da dw_2 no campo qtd_produto.', StopSign!)
	Return -1
End if

If ll_Find > 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe corretamente a quantidade pedida do produto.')
	dw_2.Event ue_Pos (ll_Find, 'qtd_produto')
	Return -1
End if

ll_Find = dw_2.Find ('Mod (Qtd_Produto, Vl_Fator_Conversao) <> 0', 1, ll_Linhas)

If ll_Find < 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro no Find da dw_2 no campo qtd_produto.', StopSign!)
	Return -1
End if

If ll_Find > 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A quantidade pedida deve ser m$$HEX1$$fa00$$ENDHEX$$ltipla do fator de convers$$HEX1$$e300$$ENDHEX$$o utilizado no Estoque Central.')
	dw_2.Event ue_Pos (ll_Find, 'qtd_produto')
	Return -1
End if

//Copia a DW para um DS para que se altere a classifica$$HEX2$$e700e300$$ENDHEX$$o sem afetar a DW
lds_itens = Create dc_uo_ds_base

If Not lds_itens.of_ChangeDataObject (dw_2.DataObject, True) then
	Return -1
End if

dw_2.RowsCopy (1, ll_Linhas, Primary!, lds_itens, 1, Primary!)

lds_itens.SetFilter ("id_selecionado = 'S'")
lds_itens.Filter ()

lds_itens.SetSort ('dh_pedido A, cd_filial A, cd_produto A')
lds_itens.Sort ()

ll_Linhas           = lds_itens.RowCount ()
ib_Confirmou_Adicao = False

For ll_Lin_Sel = 1 to ll_linhas
	
	lb_Alteracao = False
	ll_Contador  ++
	
	ldt_Pedido    = lds_itens.Object.dh_pedido          [ll_Lin_Sel]
	ll_Filial     = lds_itens.Object.Cd_Filial          [ll_Lin_Sel]
	ll_Qtd_Pedida = lds_itens.Object.Qtd_Produto        [ll_Lin_Sel]
	ll_Fator      = lds_itens.Object.Vl_Fator_Conversao [ll_Lin_Sel]
	ll_Produto    = lds_itens.Object.Cd_Produto         [ll_Lin_Sel]
	
	If ll_Lin_Sel < ll_Linhas then
		ldt_Prox_Data     = lds_itens.Object.dh_pedido [ll_Lin_Sel + 1]
		ll_Filial_Proxima = lds_itens.Object.Cd_Filial [ll_Lin_Sel + 1]
	End if
		
	lstr_solic [ll_Contador].cd_produto        = ll_Produto
	lstr_solic [ll_Contador].qt_pedida         = ll_Qtd_Pedida
	lstr_solic [ll_Contador].vl_custo_unitario = lds_itens.Object.vl_custo [ll_Lin_Sel]
	
	If ldt_Pedido <> ldt_Prox_Data or ll_Filial <> ll_Filial_Proxima or ll_Lin_Sel = ll_Linhas then
		If Not wf_verifica_solicitacao_ativa (ldt_Pedido, ll_Filial, Ref ll_Solicitacao) then Return -1
		
		If IsNull (ll_Solicitacao) then
			lb_Solicitacao_Nova = True
			If Not wf_Grava_Cabecalho_Solicitacao (ldt_Pedido, ll_Filial, Ref ll_Solicitacao) then Return -1
		else
			lb_Solicitacao_Nova = False
		End if
		
		ldc_vl_total = 0
		
		If not wf_Grava_Item_Solicitacao (ll_Solicitacao, ll_Filial, lb_Solicitacao_Nova, lstr_solic [], Ref ldc_vl_total) then Return -1
		
		If ldc_vl_total = 0 then
			SQLCA.of_RollBack ()
		else
			If not wf_atualiza_valor_solicitacao (ll_Solicitacao, ll_Filial, ldc_vl_total) then Return -1
			
			SQLCA.of_Commit ()
			lb_Alteracao = True
		End if
		
		ll_Contador   = 0
		lstr_solic [] = lstr_nulo []
	End if
	
Next

If lb_Sucesso And lb_Alteracao then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Solicita$$HEX2$$e700e300$$ENDHEX$$o($$HEX1$$f500$$ENDHEX$$es) gravada(s) com sucesso.')
	CloseWithReturn (Parent, 'OK')
End if
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge344_grava_solicitacao_pedido
integer x = 2213
integer y = 1648
end type

type dw_2 from dc_uo_dw_base within w_ge344_grava_solicitacao_pedido
integer x = 37
integer y = 248
integer width = 2446
integer height = 1356
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge344_lista_planilha_solicitacao"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event doubleclicked;call super::doubleclicked;Long		ll_Row

String	ls_Marcacao

If dwo.Name = 'st_selecionado' then
	
	If ib_Check then
		ls_Marcacao = 'N'
		ib_Check    = False
	else
		ls_Marcacao = 'S'
		ib_Check    = True
	End if
	
	This.AcceptText ()
	
	For ll_Row = 1 to This.RowCount ()
		
		If ls_Marcacao = 'S' then
			If This.Object.Id_Divergencia[ll_Row] > 0 Or This.Object.Id_UF_Divergente[ll_Row] > 0 then
				Continue
			End if
		End if
		
		This.Object.Id_Selecionado[ll_Row] = ls_Marcacao
	Next
End if
end event

event itemchanged;call super::itemchanged;String ls_Mensagem

This.AcceptText ()

Choose Case dwo.Name
	Case 'id_selecionado'
		
		If This.RowCount () = 0 then Return 1
		
		If is_Tipo = 'E' then	//Encarte
			If Data = 'S' then
				If This.Object.Id_UF_Divergente [row] > 0 Then
					If Not IsNull(This.Object.Cd_UF_Produto [row]) then
						ls_Mensagem = "A U.F. '" + This.Object.Cd_UF_Produto [row] + "' do produto '" + String (This.Object.Cd_Produto [row]) + "' $$HEX1$$e900$$ENDHEX$$ " + &
										  "diferente da U.F. '" + This.Object.Cd_UF_Filial [row] + "' da filial '" + String (This.Object.Cd_Filial [row]) + "'." + &
										  '~rDeseja inserir mesmo assim?'
														
						If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_Mensagem, Question!, YesNo!, 2) = 2 then Return 1
					
					Else
						MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', "UF do produto '" + String (This.Object.Cd_Produto [row]) + "' n$$HEX1$$e300$$ENDHEX$$o cadastrada.")
						Return 1
					End if
				End if
			End if
		End if
End choose
end event

type cb_importar from commandbutton within w_ge344_grava_solicitacao_pedido
integer x = 23
integer y = 1648
integer width = 507
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Importar Planilha"
end type

event clicked;Integer li_Retorno

String ls_Arquivo
String ls_Nome
String ls_Nulo

If dw_2.RowCount () > 0 then
	If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A planilha j$$HEX1$$e100$$ENDHEX$$ foi importada. Deseja desfazer e import$$HEX1$$e100$$ENDHEX$$-la novamente?', Question!, YesNo!, 2) = 2 then
		Return -1
	else
		dw_2.Event ue_Reset ()
	End if
End if

MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Os dados devem estar da seguinte forma:' + &
				'~rColuna A = C$$HEX1$$f300$$ENDHEX$$digo da filial' + &
				'~rColuna B = C$$HEX1$$f300$$ENDHEX$$digo do produto' + &
				'~rColuna C = Data para cria$$HEX2$$e700e300$$ENDHEX$$o do pedido' + &
				'~rColuna D = Quantidade pedida do produto')

li_Retorno = GetFileOpenName ('Seleciona o arquivo', + ls_Arquivo, ls_Nome, 'XLSX', 'Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS')

If li_Retorno = 1 then 
	dw_1.Object.De_Arquivo [1] = Upper (ls_Arquivo)
	
	If Not wf_Le_Dados_Planilha () then Return -1
else
	SetNull (ls_Nulo)
	dw_1.Object.De_Arquivo [1] = ls_Nulo
End if
end event

type gb_2 from groupbox within w_ge344_grava_solicitacao_pedido
integer x = 23
integer y = 192
integer width = 2501
integer height = 1444
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

