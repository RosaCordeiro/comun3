HA$PBExportHeader$uo_ge450_precificacao_calculo.sru
forward
global type uo_ge450_precificacao_calculo from nonvisualobject
end type
end forward

global type uo_ge450_precificacao_calculo from nonvisualobject
end type
global uo_ge450_precificacao_calculo uo_ge450_precificacao_calculo

type variables
//Private:
Long il_Tipo_Precificacao, il_NR_Precificacao

String is_Desc_Tipo_Precificacao
String ivs_Log
String ivs_Chave = "" 
String ivs_Subcategoria

dc_uo_ds_base ids_exponencial
dc_uo_ds_base ids_apresentacao_orig
dc_uo_ds_base ids_apresentacao_dest
dc_uo_ds_base ids_apresentacao_nao_med
dc_uo_ds_base ids_marcas_subcategoria
dc_uo_ds_base ids_marcas_categoria
dc_uo_ds_base ids_marcas_sub_proc
dc_uo_ds_base ids_marcas_sub_cat_proc
dc_uo_ds_base ids_preco_cidade
dc_uo_ds_base ids_preco_grupo_pricing
dc_uo_ds_base ids_grupo_pricing

dc_uo_transacao ivtr_Trans  //Trata os logs e informa$$HEX2$$e700f500$$ENDHEX$$es que ser$$HEX1$$e300$$ENDHEX$$o registradas na base independente do SQLCa


end variables

forward prototypes
public function boolean of_processa_precificacao ()
private function boolean of_exponencial_reducao_espacos_movimenta (boolean ab_reducao, long pl_tentativa, long al_ponto_inicio, long al_ponto_fim, long al_maximo_espacos, long al_qtde_espacos)
private function boolean of_verifica_preco_minimo_maximo (long pl_produto, ref decimal pdc_preco, decimal pdc_preco_minimo, decimal pdc_preco_maximo)
private function boolean of_preco_apresentacao_medicamento (string as_subcategoria, decimal adc_concentracao, string as_apresentacao, string as_unid_calc_preco)
private function boolean of_posicionamento_preco_med_ref (string as_subcategoria, decimal adc_concentracao, string as_id_apresentacao, string as_un_calc_preco, ref long al_produto_referencia, ref decimal adc_preco_referencia, ref long al_unidades_embalagem, ref decimal adc_volume, ref decimal adc_peso, ref boolean ab_passa_proximo_registro)
private function boolean of_periodo (integer ai_meses, ref date adh_inicio, ref date adh_termino)
private function boolean of_inclui_preco_minimo (long al_produto, string as_uf, string as_rede, long al_tipo_minimo, decimal adc_preco_minimo)
private function boolean of_grava_produto (string as_uf, string as_rede_filial, string as_subcategoria)
public function boolean of_grava_precificacao (integer ai_tipo_precificacao, string as_uf, string as_rede, string as_subcategoria, string as_matricula_responsavel)
private function boolean of_exponencial_verifica_preco ()
private function boolean of_exponencial_valor (string as_rede, string as_subcategoria, decimal adc_concentracao, string as_id_apresentacao, string as_un_calculo, long al_unidades_embalagem, decimal adc_volume, decimal adc_peso, long al_produto_referencia, decimal adc_preco_referencia, ref boolean ab_passa_proximo_registro)
private function boolean of_exponencial_reducao_espacos_curva (string as_rede, long pl_tentativa)
private function boolean of_exponencial_pontos (long al_pontos, decimal adc_coeficiente, decimal adc_preco_menor, decimal adc_preco_maior)
private function boolean of_exponencial_movimenta_sku (long pl_posicao_origem, long pl_posicao_destino)
private function boolean of_exponencial_laboratorio_parceiro ()
private function boolean of_exponencial_aloca_produto (long al_produto, decimal adc_valor_modelo, string as_lei_generico, string as_fornecedor_parceiro, decimal adc_preco_minimo, decimal adc_preco_maximo, decimal adc_faturamento_anual)
private function boolean of_executa_precificacao (long al_precificacao, long al_tipo_precificacao, string as_uf, string as_rede, string as_subcategoria)
private function boolean of_calcula_preco_med_rx (string as_rede)
private function boolean of_calcula_preco_med_mip (string as_rede)
private function boolean of_atualiza_preco_minimo_pbm (long al_produto, string as_uf, string as_rede_fil, date adt_inicio_resumo, date adt_termino_resumo, decimal adc_preco_atual)
private function boolean of_atualiza_preco_minimo_maior (long al_produto, string as_uf, string as_rede_fil)
private function boolean of_atualiza_preco_minimo_fpb (long al_produto, string as_uf, string as_rede_fil, string as_gratis_farm_pop, decimal adc_rembolso_fpb)
private function boolean of_atualiza_preco_minimo ()
private function boolean of_atualiza_preco_laboratorio_parceiro ()
private function boolean of_atualiza_preco_exponencial ()
private subroutine of_grava_log (string as_mensagem, string as_erro, string as_subcategoria, long al_produto, long al_cidade)
private subroutine of_grava_log (string as_mensagem, string as_erro, string as_subcategoria, long al_produto)
private subroutine of_grava_log (string as_mensagem, string as_erro, string as_subcategoria)
public subroutine of_grava_log (string as_mensagem, string as_erro)
public function boolean of_regionalizacao_preco (long al_precificacao, long al_tipo_precificacao, string as_tipo_precificacao, string as_uf, string as_rede_filial, datetime adh_inicio_calculo, dc_uo_ds_base ads_regionalizacao)
public function boolean of_regionalizacao_atualiza_faturamento (long al_precificacao, string as_tipo_precificacao, long al_tipo_precificacao)
private function boolean of_preco_liquido_medicamento (long al_produto, string as_uf, string as_rede, date adh_inicio, date adh_termino, decimal adc_preco_atual, ref decimal adc_preco_liquido)
public function boolean of_preco_psicologico_left (decimal adc_preco, decimal adc_preco_minimo, decimal adc_preco_maximo, ref decimal adc_preco_psicologico)
private function boolean of_atualiza_preco_minimo_marca_subcat (long al_produto, string as_uf, string as_rede_filial, date adt_inicio, date adt_termino, string as_subcategoria, string as_lei_generico, decimal adc_custo_medio)
private function boolean of_atualiza_preco_minimo_marca_categ (long al_produto, string as_uf, string as_rede_filial, date adt_inicio, date adt_termino, string as_subcategoria, long al_marca, decimal adc_custo_medio)
public function boolean of_calcula_preco_nao_med (string as_rede)
public function boolean of_preco_psicologico (long al_precificacao, long al_tipo_precificacao, string as_tipo_precificacao)
private function boolean of_preco_psicologico ()
private function boolean of_preco_apresentacao_nao_medicamento (string as_subcategoria, string as_descricao, string as_tipo_un_calc_preco, long al_tipo_produto_pricing)
private function boolean of_preco_unificado_grupo_pricing ()
private function boolean of_preco_produto_indexado ()
public function boolean of_preco_produto_indexador (long al_produto, ref decimal adc_preco, long pl_tentativa)
public function boolean of_preco_marca_propria ()
public function boolean of_processa_regionalizacao ()
private function boolean of_envia_email (boolean pb_sucesso, string ps_tipo)
public function boolean of_atualiza_inicio_termino (string as_inicio_termino, boolean ab_commit)
public function boolean of_preco_psicologico_faixa (decimal adc_preco, decimal adc_preco_minimo, decimal adc_preco_maximo, ref decimal adc_preco_psicologico)
end prototypes

public function boolean of_processa_precificacao ();Long ll_Linhas, ll_Linha, ll_Tipo, ll_Precificacao

String ls_UF, ls_Rede, ls_SubCategoria, ls_Msg

dc_uo_ds_base lds

Boolean lvb_Sucesso = False

try

	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge450_precificacao_pendente", False) Then 
		This.of_Grava_Log("Erro na troca da dw [ds_ge450_precificacao_pendente].", lds.ivo_dberror.ivs_sqlerrtext)
		Return False
	End If
	
	ll_Linhas = lds.Retrieve("C")
	
	If ll_Linhas > 0 Then
		
		Open(	w_ge450_aguarde)
				
		For ll_Linha = 1 To ll_Linhas
			lvb_Sucesso 		= False
			ll_Precificacao		= lds.Object.nr_precificacao			[ll_Linha]
			ll_Tipo 				= lds.Object.cd_tipo_precificacao	[ll_Linha]
			ls_UF					= lds.Object.cd_uf						[ll_Linha]
			ls_SubCategoria	= lds.Object.cd_subcategoria		[ll_Linha]
			ls_Rede				= lds.Object.id_rede_filial			[ll_Linha]
			
			il_NR_Precificacao = lds.Object.nr_precificacao			[ll_Linha]
			
			If Not IsValid(w_ge450_aguarde) Then Open(w_ge450_aguarde)
			w_ge450_aguarde.Title = "Executando Precifica$$HEX2$$e700e300$$ENDHEX$$o [" + String(ll_Precificacao) + "] ..."
			
			// INICIO
			If Not This.of_Atualiza_Inicio_Termino("I", True) Then Return False
				
			If Not This.of_Executa_Precificacao(ll_Precificacao, ll_Tipo, ls_UF, ls_Rede, ls_SubCategoria ) Then Return False
			
			// TERMINO
			If Not This.of_Atualiza_Inicio_Termino("T", False) Then Return False
			
			lvb_Sucesso = True
			SqlCa.of_Commit();
			This.of_Envia_Email( lvb_Sucesso , "C")
						
		Next
			
	ElseIf ll_Linhas < 0 Then
		SqlCa.of_RollBack();
		of_Grava_Log("Erro ao localizar as precifica$$HEX2$$e700f500$$ENDHEX$$es pendentes.", lds.ivo_DbError.ivs_SQLErrText)
		Return False
	End If
	
Catch (RuntimeError lvo_Erro)
		of_Grava_Log("Erro na execu$$HEX2$$e700e300$$ENDHEX$$o da fun$$HEX2$$e700e300$$ENDHEX$$o of_processa_precificacao().", lvo_Erro.GetMessage())
		Return False	
	
finally
	If il_NR_Precificacao > 0 Then
		If Not lvb_Sucesso Then 
			SqlCa.of_RollBack();
			
			This.of_Atualiza_Inicio_Termino("E", False) 
			This.of_Envia_Email( lvb_Sucesso , "C")
			SqlCa.of_Commit();
		End If
	End If
	
	If IsValid(w_ge450_aguarde) Then Close(w_ge450_aguarde)
end try

Return True
end function

private function boolean of_exponencial_reducao_espacos_movimenta (boolean ab_reducao, long pl_tentativa, long al_ponto_inicio, long al_ponto_fim, long al_maximo_espacos, long al_qtde_espacos);/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																										//
//									Redu$$HEX2$$e700e300$$ENDHEX$$o de Espa$$HEX1$$e700$$ENDHEX$$os de Pre$$HEX1$$e700$$ENDHEX$$o ao Longo da Curva Exponencial (1.III.d)											//
//																																										//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	REGRAS:																																							//
//			$$HEX1$$2220$$ENDHEX$$	O maior pre$$HEX1$$e700$$ENDHEX$$o e o menor pre$$HEX1$$e700$$ENDHEX$$o da curva n$$HEX1$$e300$$ENDHEX$$o se alteram.																				//
//			$$HEX1$$2220$$ENDHEX$$	Realizar a troca de posi$$HEX2$$e700f500$$ENDHEX$$es quando houver pelo menos 3 SKUs da combina$$HEX2$$e700e300$$ENDHEX$$o.													//
// 			$$HEX1$$2220$$ENDHEX$$	O c$$HEX1$$e100$$ENDHEX$$lculo da quantidade m$$HEX1$$e100$$ENDHEX$$xima de espa$$HEX1$$e700$$ENDHEX$$os de pre$$HEX1$$e700$$ENDHEX$$o me branco $$HEX1$$e900$$ENDHEX$$ calculado pela seguinte f$$HEX1$$f300$$ENDHEX$$rmula:							//
//				Espa$$HEX1$$e700$$ENDHEX$$os de Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$e100$$ENDHEX$$ximo= Arred.para Baixo (((Quantidade de SKUs * 2))/4)														//
//					Sendo 2 o menor valor a ser considerado																								//
//			$$HEX1$$2220$$ENDHEX$$	Toler$$HEX1$$e100$$ENDHEX$$vel salto de no m$$HEX1$$e100$$ENDHEX$$ximo 3 pontos na curva por SKU.																				//
//			$$HEX1$$2220$$ENDHEX$$	L$$HEX1$$f300$$ENDHEX$$gica PP: primeiro $$HEX1$$e900$$ENDHEX$$ avaliado a possibilidade de aumento de pre$$HEX1$$e700$$ENDHEX$$o.																	//
//			$$HEX1$$2220$$ENDHEX$$	L$$HEX1$$f300$$ENDHEX$$gica DC: primeiro $$HEX1$$e900$$ENDHEX$$ avaliado a possibilidade de redu$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o.																	//
//			$$HEX1$$2220$$ENDHEX$$	Preferencialmente a revis$$HEX1$$e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o deve ser para SKUs com menor faturamento l$$HEX1$$ed00$$ENDHEX$$quido (8) para reduzir o risco. 		//
//				Em casos de que o SKU pr$$HEX1$$f300$$ENDHEX$$ximo ao espa$$HEX1$$e700$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o tenha outro SKU na posi$$HEX2$$e700e300$$ENDHEX$$o ao lado na curva de pre$$HEX1$$e700$$ENDHEX$$o, deve-se 	//
//				avaliar o faturamento de ambos para definir qual SKU movimentar o pre$$HEX1$$e700$$ENDHEX$$o.															//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Constant long Maximo_Movimentacoes = 3

Long lvl_Find_1
Long lvl_Find_2
Long lvl_Ponto_1
Long lvl_Ponto_2
Long lvl_Prod_1
Long lvl_Prod_2
Long lvl_Ponto_Origem_1
Long lvl_Ponto_Origem_2
Long lvl_Ponto_Destino_1
Long lvl_Ponto_Destino_2

Decimal{2} lvdc_Fat_Anual_1
Decimal{2} lvdc_Fat_Anual_2

Try
	//Deve efetuar uma tentativa de aumento e caso n$$HEX1$$e300$$ENDHEX$$o seja poss$$HEX1$$ed00$$ENDHEX$$vel deve-se tentar o inverso, totalizando 2 tentativas
	If pl_tentativa >= 3 Then Return True
	
	ids_exponencial.SetSort("nr_ponto asc")
	If ids_exponencial.Sort() < 0 Then
		of_Grava_Log("Erro - Ordena$$HEX2$$e700e300$$ENDHEX$$o de produtos. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_exponencial_reducao_espacos_movimenta().", ids_exponencial.ivo_dberror.ivs_sqlerrtext, ivs_Subcategoria)
		Return False
	End If
	
	lvl_Ponto_1				= 0
	lvl_Ponto_2				= 0
	lvl_Ponto_Origem_1	= 0
	lvl_Ponto_Origem_2	= 0
	lvl_Prod_1				= 0
	lvl_Prod_2				= 0
	lvdc_Fat_Anual_1		= 0
	lvdc_Fat_Anual_2		= 0
	lvl_Ponto_Destino_1	= 0
	lvl_Ponto_Destino_2	= 0
	
	//L$$HEX1$$f300$$ENDHEX$$gica PP: primeiro $$HEX1$$e900$$ENDHEX$$ avaliado a possibilidade de aumento de pre$$HEX1$$e700$$ENDHEX$$o.		
	If (Not ab_reducao) Then
		//Avalia possibilidade de aumento, somente se o SKU anterior ao espa$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o for o primeiro (1$$HEX1$$ba00$$ENDHEX$$ e $$HEX1$$fa00$$ENDHEX$$ltimo n$$HEX1$$e300$$ENDHEX$$o podem ser movidos)
		If al_ponto_inicio > 1 Then
			//Posi$$HEX2$$e700e300$$ENDHEX$$o 1: $$HEX1$$fa00$$ENDHEX$$ltimo SKU antes do in$$HEX1$$ed00$$ENDHEX$$cio dos espa$$HEX1$$e700$$ENDHEX$$os vazios
			lvl_Find_1 = ids_exponencial.Find("nr_ponto = "+String(al_ponto_inicio), 1, ids_exponencial.RowCount())
			//Posi$$HEX2$$e700e300$$ENDHEX$$o 2: pen$$HEX1$$fa00$$ENDHEX$$ltimo SKU antes do in$$HEX1$$ed00$$ENDHEX$$cio dos espa$$HEX1$$e700$$ENDHEX$$os vazios (1 ponto antes da posi$$HEX2$$e700e300$$ENDHEX$$o 1)
			lvl_Find_2 = lvl_Find_1 - 1
			//Destino 1: Serve para movimentar o SKU da posi$$HEX2$$e700e300$$ENDHEX$$o 1, e deve progredir apenas 1 posi$$HEX2$$e700e300$$ENDHEX$$o, pois o ponto sucessor $$HEX1$$e900$$ENDHEX$$ vazio
			lvl_Ponto_Destino_1 = lvl_Find_1 + 1
			//Destino 2: Serve para movimentar o SKU da posi$$HEX2$$e700e300$$ENDHEX$$o 2, e deve progredir 2 posi$$HEX2$$e700f500$$ENDHEX$$es, pois o ponto sucessor $$HEX1$$e900$$ENDHEX$$ preenchido pelo SKU da posi$$HEX2$$e700e300$$ENDHEX$$o 1
			lvl_Ponto_Destino_2 = lvl_Find_2 + 2
		Else
			//Caso o SKU anterior ao espa$$HEX1$$e700$$ENDHEX$$o vazio esteja alocado no ponto 1 n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser movido, deve ser efetuado uma tentativa inversa
			Return This.of_Exponencial_Reducao_Espacos_Movimenta((not ab_reducao), pl_tentativa + 1, al_ponto_inicio, al_ponto_fim, al_maximo_espacos, al_qtde_espacos)
		End If
		
	//L$$HEX1$$f300$$ENDHEX$$gica DC: primeiro $$HEX1$$e900$$ENDHEX$$ avaliado a possibilidade de redu$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o.
	Else
		//Avalia possibilidade de aumento, somente se o SKU anterior ao espa$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o for o primeiro (1$$HEX1$$ba00$$ENDHEX$$ e $$HEX1$$fa00$$ENDHEX$$ltimo n$$HEX1$$e300$$ENDHEX$$o podem ser movidos)
		If al_ponto_fim < ids_exponencial.RowCount() Then
			lvl_Find_1 = ids_exponencial.Find("nr_ponto = "+String(al_ponto_fim), 1, ids_exponencial.RowCount())
			lvl_Find_2 = lvl_Find_1 + 1
			//Destino 1: Serve para movimentar o SKU da posi$$HEX2$$e700e300$$ENDHEX$$o 1, e deve regredir apenas 1 posi$$HEX2$$e700e300$$ENDHEX$$o, pois o ponto antecessor $$HEX1$$e900$$ENDHEX$$ vazio
			lvl_Ponto_Destino_1 = lvl_Find_1 - 1
			//Destino 2: Serve para movimentar o SKU da posi$$HEX2$$e700e300$$ENDHEX$$o 2, e deve regredir 2 posi$$HEX2$$e700f500$$ENDHEX$$es, pois o ponto antecessor $$HEX1$$e900$$ENDHEX$$ preenchido pelo SKU da posi$$HEX2$$e700e300$$ENDHEX$$o 1
			lvl_Ponto_Destino_2 = lvl_Find_2 - 2
		Else
			//Caso o SKU anterior ao espa$$HEX1$$e700$$ENDHEX$$o vazio esteja alocado no ponto 1 n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser movido, deve ser efetuado uma tentativa inversa
			Return This.of_Exponencial_Reducao_Espacos_Movimenta((not ab_reducao), pl_tentativa + 1, al_ponto_inicio, al_ponto_fim, al_maximo_espacos, al_qtde_espacos)
		End If
	End If
	
	//Verifica se foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar o registro no datasource
	If lvl_Find_1 > 0 Then
		//N$$HEX1$$e300$$ENDHEX$$o movimenta a primeira e $$HEX1$$fa00$$ENDHEX$$ltima posi$$HEX2$$e700e300$$ENDHEX$$o da curva
		If lvl_Find_1 > 1  and lvl_Find_1 < ids_exponencial.RowCount() Then 
			lvl_Ponto_1				= ids_exponencial.Object.nr_ponto					[lvl_Find_1]		
			lvl_Ponto_Origem_1	= ids_exponencial.Object.nr_ponto_origem			[lvl_Find_1]
			lvl_Prod_1				= ids_exponencial.Object.cd_produto					[lvl_Find_1] 
			lvdc_Fat_Anual_1		= ids_exponencial.Object.vl_faturamento_anual	[lvl_Find_1]
			
			//Verifica se este ponto j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ deslocado no m$$HEX1$$e100$$ENDHEX$$ximo
			If Abs(lvl_Ponto_1 - lvl_Ponto_Origem_1) > (Maximo_Movimentacoes) Then
				lvl_Ponto_1				= 0
				lvl_Prod_1				= 0
				lvl_Ponto_Origem_1	= 0
				lvdc_Fat_Anual_1		= 0
			End If
			
			//N$$HEX1$$e300$$ENDHEX$$o movimenta a primeira e $$HEX1$$fa00$$ENDHEX$$ltima posi$$HEX2$$e700e300$$ENDHEX$$o da curva
			If lvl_Find_2 > 1  and lvl_Find_2 < ids_exponencial.RowCount() Then 
				lvl_Ponto_2				= ids_exponencial.Object.nr_ponto					[lvl_Find_2]		
				lvl_Ponto_Origem_2	= ids_exponencial.Object.nr_ponto_origem			[lvl_Find_2]
				lvl_Prod_2				= ids_exponencial.Object.cd_produto					[lvl_Find_2] 
				lvdc_Fat_Anual_2		= ids_exponencial.Object.vl_faturamento_anual	[lvl_Find_2]	
				
				//Caso este ponto esteja vazio ou j$$HEX1$$e100$$ENDHEX$$ deslocado no m$$HEX1$$e100$$ENDHEX$$ximo permitido 
				If IsNull(lvl_Prod_2)or (lvl_Prod_2 = 0) or (Abs(lvl_Ponto_2 - lvl_Ponto_Origem_2) > (Maximo_Movimentacoes)) Then
					lvl_Ponto_2				= 0
					lvl_Ponto_Origem_2	= 0
					lvl_Prod_2				= 0
					lvdc_Fat_Anual_2		= 0
				End If
			End If
			
			//Caso n$$HEX1$$e300$$ENDHEX$$o seja poss$$HEX1$$ed00$$ENDHEX$$vel (SKU zerados os valores pelas outras regras acima) deslocar os pre$$HEX1$$e700$$ENDHEX$$os para cima, efetua a chamada da fun$$HEX2$$e700e300$$ENDHEX$$o para tentar reduzir
			If lvl_Prod_1 = 0 and lvl_Prod_2 = 0 Then
				Return This.of_Exponencial_Reducao_Espacos_Movimenta((not ab_reducao), pl_tentativa + 1, al_ponto_inicio, al_ponto_fim, al_maximo_espacos, al_qtde_espacos)
			End If
			
			//Se o ponto 1 for zero, considera o ponto 2, que $$HEX1$$e900$$ENDHEX$$ o anterior ao ponto 1 
			If lvl_Ponto_2 = 0 Then
				//Movimenta o Ponto 1 duas casa para frente
				Return This.Of_Exponencial_Movimenta_SKU( lvl_Ponto_1, lvl_Ponto_Destino_1)
			ElseIf lvl_Ponto_1 = 0 Then 
				//Movimenta o Ponto 2 duas casas para frente, pois na casa seguinte $$HEX1$$e900$$ENDHEX$$ o produto 1
				Return This.Of_Exponencial_Movimenta_SKU( lvl_Ponto_2, lvl_Ponto_Destino_2)
			Else 
				If lvdc_Fat_Anual_2 > lvdc_Fat_Anual_1 Then
					//Movimenta o Ponto 1 duas casa para frente
					Return This.Of_Exponencial_Movimenta_SKU( lvl_Ponto_1, lvl_Ponto_Destino_1)
				Else						
					//Movimenta o Ponto 2 duas casas para frente, pois na casa seguinte $$HEX1$$e900$$ENDHEX$$ o produto 1
					Return This.Of_Exponencial_Movimenta_SKU( lvl_Ponto_2, lvl_Ponto_Destino_2)
				End If
			End If
		End If
	Else
		This.Of_Grava_Log( "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel identificar o ponto "+String(IIF(ab_reducao, al_ponto_fim, al_ponto_inicio))+" na fun$$HEX2$$e700e300$$ENDHEX$$o of_exponencial_reducao_espacos_movimenta().", "", ivs_Subcategoria)
		Return False
	End If
	
Catch (RuntimeError lvo_Erro)
	This.Of_Grava_log( "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_exponencial_reducao_espacos_movimenta()." , lvo_Erro.GetMessage(), ivs_Subcategoria)
	Return False
	
Finally
	//
End Try

Return True
end function

private function boolean of_verifica_preco_minimo_maximo (long pl_produto, ref decimal pdc_preco, decimal pdc_preco_minimo, decimal pdc_preco_maximo);//	O sistema ir$$HEX1$$e100$$ENDHEX$$ verificar primeiro o m$$HEX1$$ed00$$ENDHEX$$nimo, pois caso o m$$HEX1$$ed00$$ENDHEX$$nimo esteja maior que o m$$HEX1$$e100$$ENDHEX$$ximo, deve respeitar o m$$HEX1$$e100$$ENDHEX$$ximo,
//	pois caso desrespeite o m$$HEX1$$e100$$ENDHEX$$ximo podemos estar calculando um pre$$HEX1$$e700$$ENDHEX$$o ilegal. 
If Not IsNull(pdc_preco_minimo) and (pdc_preco_minimo > 0) Then
	//Verifica se o pre$$HEX1$$e700$$ENDHEX$$o do ponto $$HEX1$$e900$$ENDHEX$$ inferior ao m$$HEX1$$ed00$$ENDHEX$$nimo
	If pdc_preco_minimo > pdc_preco Then
		//Caso seja inferior ao m$$HEX1$$ed00$$ENDHEX$$nimo deve considerar como pre$$HEX1$$e700$$ENDHEX$$o o m$$HEX1$$ed00$$ENDHEX$$nimo
		pdc_preco = pdc_preco_minimo
	End If
End If

If Not IsNull(pdc_preco_maximo) and (pdc_preco_maximo > 0) Then
	//Verifica se o pre$$HEX1$$e700$$ENDHEX$$o do ponto $$HEX1$$e900$$ENDHEX$$ superior ao m$$HEX1$$e100$$ENDHEX$$ximo
	If pdc_preco > pdc_preco_maximo Then
		//Caso seja superior ao m$$HEX1$$e100$$ENDHEX$$ximo deve considerar como pre$$HEX1$$e700$$ENDHEX$$o o m$$HEX1$$e100$$ENDHEX$$ximo
		pdc_preco = pdc_preco_maximo
	End If
	
	//Verifica$$HEX2$$e700e300$$ENDHEX$$o para gerar log de inconsist$$HEX1$$ea00$$ENDHEX$$ncia
	If Not IsNull(pdc_preco_minimo) and (pdc_preco_minimo > 0) Then
		If pdc_preco_minimo > pdc_preco_maximo Then
			This.Of_Grava_log( "Inconsist$$HEX1$$ea00$$ENDHEX$$ncia de informa$$HEX2$$e700f500$$ENDHEX$$es no produto "+String(pl_produto)+": Valor m$$HEX1$$ed00$$ENDHEX$$nimo "+String(pdc_preco_minimo, "#,##0.00")+" $$HEX1$$e900$$ENDHEX$$ superior ao valor m$$HEX1$$e100$$ENDHEX$$ximo "+String(pdc_preco_maximo, "#,##0.00")+"." , "")
			Return False
		End If 
	End If
End If

Return True
end function

private function boolean of_preco_apresentacao_medicamento (string as_subcategoria, decimal adc_concentracao, string as_apresentacao, string as_unid_calc_preco);///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																																//
//																			IV.	Pre$$HEX1$$e700$$ENDHEX$$o por Apresenta$$HEX2$$e700e300$$ENDHEX$$o (1.IV)																			//
//																																																//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	REGRAS:																																													//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//			$$HEX1$$2220$$ENDHEX$$	Definido o pre$$HEX1$$e700$$ENDHEX$$o da principal apresenta$$HEX2$$e700e300$$ENDHEX$$o por SUBCATEGORIA / CONCENTRA$$HEX2$$c700c300$$ENDHEX$$O / TIPO DE APRESENTA$$HEX2$$c700c300$$ENDHEX$$O / UNIDADE DE MEDIDA 		//
//				$$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel calcular o pre$$HEX1$$e700$$ENDHEX$$o para as demais apresenta$$HEX2$$e700f500$$ENDHEX$$es por laborat$$HEX1$$f300$$ENDHEX$$rio. A varia$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o por apresenta$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ fundamentada pelo 	//
//				pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio dos medicamentos. O pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio $$HEX1$$e900$$ENDHEX$$ calculado com base na classifica$$HEX2$$e700e300$$ENDHEX$$o por SKU do tipo de unidade que h$$HEX1$$e100$$ENDHEX$$ varia$$HEX2$$e700e300$$ENDHEX$$o 		//
//				por apresenta$$HEX2$$e700e300$$ENDHEX$$o (Quantidade/Peso/Volume). Para estas diferentes unidades foram definidas 3 equa$$HEX2$$e700f500$$ENDHEX$$es para calcular o pre$$HEX1$$e700$$ENDHEX$$o l$$HEX1$$ed00$$ENDHEX$$quido 	//
//				unit$$HEX1$$e100$$ENDHEX$$rio das demais apresenta$$HEX2$$e700f500$$ENDHEX$$es (1 + 2). As equa$$HEX2$$e700f500$$ENDHEX$$es s$$HEX1$$e300$$ENDHEX$$o:																									//
//					a)	Varia$$HEX2$$e700e300$$ENDHEX$$o Pre$$HEX1$$e700$$ENDHEX$$o Unit$$HEX1$$e100$$ENDHEX$$rio (Quantidade): 1 $$HEX1$$1222$$ENDHEX$$($$HEX1$$1222$$ENDHEX$$0,002 * Varia$$HEX2$$e700e300$$ENDHEX$$o de Comprimidos + 0,952)														//
//					b)	Varia$$HEX2$$e700e300$$ENDHEX$$o Pre$$HEX1$$e700$$ENDHEX$$o Unit$$HEX1$$e100$$ENDHEX$$rio (Volume): 1 $$HEX1$$1222$$ENDHEX$$ ($$HEX1$$1222$$ENDHEX$$0,001 * Varia$$HEX2$$e700e300$$ENDHEX$$o de Volume + 0,951)																	//
//					c)	Varia$$HEX2$$e700e300$$ENDHEX$$o Pre$$HEX1$$e700$$ENDHEX$$o Unit$$HEX1$$e100$$ENDHEX$$rio (Peso): 1 $$HEX1$$1222$$ENDHEX$$ ($$HEX1$$1222$$ENDHEX$$0,009 * Varia$$HEX2$$e700e300$$ENDHEX$$o de Peso + 1,034)																			//
//			$$HEX1$$2220$$ENDHEX$$	$$HEX1$$c900$$ENDHEX$$ recomend$$HEX1$$e100$$ENDHEX$$vel utilizar os valores de coeficiente angular e constante com mais casas decimais. 														//
//			$$HEX1$$2220$$ENDHEX$$	Deve-se avaliar o pre$$HEX1$$e700$$ENDHEX$$o calculado com o Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo e com o Pre$$HEX1$$e700$$ENDHEX$$o Bruto caso o SKU tenha Pre$$HEX1$$e700$$ENDHEX$$o Monitorado ou Pre$$HEX1$$e700$$ENDHEX$$o Liberado de 		//
//				F$$HEX1$$e100$$ENDHEX$$brica e alterar o novo pre$$HEX1$$e700$$ENDHEX$$o quando necess$$HEX1$$e100$$ENDHEX$$rio seguindo as mesmas regras.																			//
//			$$HEX1$$2220$$ENDHEX$$	Caso a Subcategoria tenha mais de 2 apresenta$$HEX2$$e700f500$$ENDHEX$$es distintas, a varia$$HEX2$$e700e300$$ENDHEX$$o de apresenta$$HEX2$$e700f500$$ENDHEX$$es deve ter como refer$$HEX1$$ea00$$ENDHEX$$ncia o SKU com o pre$$HEX1$$e700$$ENDHEX$$o	//
//				definido na etapa anterior (IV). As exce$$HEX2$$e700f500$$ENDHEX$$es s$$HEX1$$e300$$ENDHEX$$o medicamentos que n$$HEX1$$e300$$ENDHEX$$o tiveram seu pre$$HEX1$$e700$$ENDHEX$$o calculado na etapa anterior (IV) por ter			//
//				apresenta$$HEX2$$e700e300$$ENDHEX$$o diferente da principal apresenta$$HEX2$$e700e300$$ENDHEX$$o da SUBCATEGORIA / CONCENTRA$$HEX2$$c700c300$$ENDHEX$$O / TIPO DE APRESENTA$$HEX2$$c700c300$$ENDHEX$$O / UNID. DE MEDIDA. 	//
//				Para esses casos deve ser avaliado o Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo e se houver apresenta$$HEX2$$e700f500$$ENDHEX$$es diferentes aplicar o racional detalhado nesta se$$HEX2$$e700e300$$ENDHEX$$o.			//
//																																																//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	CONSIDERA$$HEX2$$c700d500$$ENDHEX$$ES:																																										//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//			Os pre$$HEX1$$e700$$ENDHEX$$os de produtos com fator de convers$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o tratados unitariamente, ou seja, o valor na precifica$$HEX2$$e700e300$$ENDHEX$$o estar$$HEX1$$e100$$ENDHEX$$ sempre dividido pelo 		//
//		fator de convers$$HEX1$$e300$$ENDHEX$$o. Sendo necess$$HEX1$$e100$$ENDHEX$$rio a gravar o pre$$HEX1$$e700$$ENDHEX$$o multiplicar pelo fator de convers$$HEX1$$e300$$ENDHEX$$o.																		//	
//																																																//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Long lvl_Linhas_Orig
Long lvl_Linhas_Dest
Long lvl_Linha
Long lvl_Find
Long lvl_Qtde_Emb_Orig
Long lvl_Qtde_Emb_Dest
Long lvl_Prod

String lvs_Lei_Gen
String lvs_CNPJ_Labor
String lvs_Msg

Decimal lvdc_Variacao
Decimal lvdc_Variacao_Min
Decimal lvdc_Variacao_Max
Decimal{2} lvdc_Preco_Minimo
Decimal{2} lvdc_Preco_Maximo
Decimal{2} lvdc_Preco_Exponencial
Decimal{2} lvdc_Preco_Apresentacao

Decimal{3} lvdc_Volume_Orig
Decimal{3} lvdc_Volume_Dest
Decimal{3} lvdc_Peso_Orig
Decimal{3} lvdc_Peso_Dest

Try
	w_ge450_aguarde.st_processo.Text = "C$$HEX1$$e100$$ENDHEX$$lculo Pre$$HEX1$$e700$$ENDHEX$$o - Varia$$HEX2$$e700e300$$ENDHEX$$o por Apresenta$$HEX2$$e700e300$$ENDHEX$$o"
	
	lvl_Linhas_Orig = ids_apresentacao_orig.Retrieve( il_NR_Precificacao, as_subcategoria, adc_concentracao, as_apresentacao, as_unid_calc_preco )
	
	If lvl_Linhas_Orig < 0 Then
		This.Of_Grava_log( "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es dos produtos da curva exponencial, na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_apresentacao_medicamento()." , ids_apresentacao_orig.ivo_dberror.ivs_sqlerrtext,  as_subcategoria)
		Return False
	End If
	
	lvl_Linhas_Dest = ids_apresentacao_dest.Retrieve( il_NR_Precificacao, as_subcategoria, adc_concentracao, as_apresentacao, as_unid_calc_preco )
	If lvl_Linhas_Dest < 0 Then
		This.Of_Grava_log( "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es dos produtos a serem precificados, na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_apresentacao_medicamento()." , ids_apresentacao_dest.ivo_dberror.ivs_sqlerrtext,  as_subcategoria)
		Return False
	End If
	
	//Defini$$HEX2$$e700e300$$ENDHEX$$o dos limites de varia$$HEX2$$e700e300$$ENDHEX$$o
	lvdc_Variacao_Min		= 0.05
	lvdc_Variacao_Max	= 0.20
	
	//ETAPA1: TENTA CALCULAR O PRE$$HEX1$$c700$$ENDHEX$$O PARA TODAS AS APRESENTA$$HEX2$$c700d500$$ENDHEX$$ES COM SKU REFER$$HEX1$$ca00$$ENDHEX$$NCIA NA CURVA DE EXPONENCIALIDADE
	For lvl_Linha = 1 To lvl_Linhas_Dest
		lvs_Lei_Gen 					= ids_apresentacao_dest.Object.id_lei_generico				[lvl_Linha]
		lvs_CNPJ_Labor				= ids_apresentacao_dest.Object.nr_cnpj_laboratorio			[lvl_Linha]
		lvl_Qtde_Emb_Dest		= ids_apresentacao_dest.Object.qt_unidades_embalagem	[lvl_Linha]
		lvdc_Volume_Dest			= ids_apresentacao_dest.Object.vl_volume						[lvl_Linha]
		lvdc_Peso_Dest				= ids_apresentacao_dest.Object.qt_peso_grama				[lvl_Linha]
		
		//Procura no datasource de SKUs de principal apresenta$$HEX2$$e700e300$$ENDHEX$$o um pre$$HEX1$$e700$$ENDHEX$$o exponencial do mesmo laborat$$HEX1$$f300$$ENDHEX$$rio e lei gen$$HEX1$$e900$$ENDHEX$$rico para o c$$HEX1$$e100$$ENDHEX$$lculo da varia$$HEX2$$e700e300$$ENDHEX$$o
		lvl_Find = ids_apresentacao_orig.Find( "nr_cnpj_laboratorio = '"+lvs_CNPJ_Labor+"' and id_lei_generico='"+lvs_Lei_Gen+"'", 1, lvl_Linhas_Orig)
		//Se der erro no FIND
		If lvl_Find < 0 Then
			This.Of_Grava_log( "Erro no find do datasource ids_apresentacao_orig da fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_apresentacao_medicamento()." , ids_apresentacao_orig.ivo_dberror.ivs_sqlerrtext,  as_subcategoria)
			Return False
		End If
		//Caso encontre um SKU do mesmo agrupamento, laborat$$HEX1$$f300$$ENDHEX$$rio e lei gen$$HEX1$$e900$$ENDHEX$$rico
		If lvl_Find > 0 Then
			lvdc_Preco_Exponencial	= ids_apresentacao_orig.Object.vl_preco_exponencial 		[lvl_Find]
			lvl_Qtde_Emb_Orig		= ids_apresentacao_orig.Object.qt_unidades_embalagem	[lvl_Find]
			lvdc_Volume_Orig			= ids_apresentacao_orig.Object.vl_volume						[lvl_Find]
			lvdc_Peso_Orig				= ids_apresentacao_orig.Object.qt_peso_grama				[lvl_Find]
			
			Choose Case as_unid_calc_preco
				Case 'Q'
					lvdc_Variacao = ( 1 - (-0.002 * (lvl_Qtde_Emb_Dest - lvl_Qtde_Emb_Orig) + 0.952) )
					If lvdc_Variacao > lvdc_Variacao_Max Then lvdc_Variacao = lvdc_Variacao_Max
					If lvdc_Variacao < lvdc_Variacao_Min Then lvdc_Variacao = lvdc_Variacao_Min
					If lvl_Qtde_Emb_Dest > lvl_Qtde_Emb_Orig Then lvdc_Variacao *= -1
					lvdc_Preco_Apresentacao = Round((lvdc_Preco_Exponencial / lvl_Qtde_Emb_Orig) * ( 1 + lvdc_Variacao) * lvl_Qtde_Emb_Dest, 2)
					
				Case 'P'
					lvdc_Variacao = ( 1 - (-0.001 * (lvdc_Peso_Dest - lvdc_Peso_Orig) + 0.951) )
					If lvdc_Peso_Dest > lvdc_Peso_Orig  Then lvdc_Variacao *= -1
					If lvdc_Variacao > lvdc_Variacao_Max Then lvdc_Variacao = lvdc_Variacao_Max
					If lvdc_Variacao < lvdc_Variacao_Min Then lvdc_Variacao = lvdc_Variacao_Min
					lvdc_Preco_Apresentacao = Round((lvdc_Preco_Exponencial / lvdc_Peso_Orig) * ( 1 + lvdc_Variacao) * lvdc_Peso_Dest, 2)
					
				Case 'V'
					lvdc_Variacao = ( 1 - (-0.009 * (lvdc_Volume_Dest - lvdc_Volume_Orig) + 1.034) )
					If lvdc_Volume_Dest > lvdc_Volume_Orig Then lvdc_Variacao *= -1
					If lvdc_Variacao > lvdc_Variacao_Max Then lvdc_Variacao = lvdc_Variacao_Max
					If lvdc_Variacao < lvdc_Variacao_Min Then lvdc_Variacao = lvdc_Variacao_Min
					lvdc_Preco_Apresentacao = Round((lvdc_Preco_Exponencial / lvdc_Volume_Orig) * ( 1 + lvdc_Variacao) * lvdc_Volume_Dest, 2)
					
			End Choose
			
			//Aplica o valor a datawindow
			ids_apresentacao_dest.Object.vl_preco_apresentacao [lvl_Linha] = lvdc_Preco_Apresentacao
		End If
	Next
	
	//ETAPA 2: TENTA CALCULAR OS SKUs SEM REFER$$HEX1$$ca00$$ENDHEX$$NCIA NA CURVA DE EXPONENCIALIDADE
	//Filtra somente os produtos ainda sem pre$$HEX1$$e700$$ENDHEX$$o de apresenta$$HEX2$$e700e300$$ENDHEX$$o por n$$HEX1$$e300$$ENDHEX$$o ter encontrado um produto do mesmo laborat$$HEX1$$f300$$ENDHEX$$rio na exponencial
	ids_apresentacao_dest.SetFilter("isNull(vl_preco_apresentacao) or (vl_preco_apresentacao=0.00)")
	If ids_apresentacao_dest.Filter() < 0 Then
		This.Of_grava_log( "Falha ao inserir o filtro no datasource ids_apresentacao_dest na fun$$HEX2$$e700e300$$ENDHEX$$o: of_preco_apresentacao_medicamento().", ids_apresentacao_dest.ivo_dberror.ivs_sqlerrtext,  as_subcategoria)
		Return False
	End If	
	//Ordena por maior faturamento
	ids_apresentacao_dest.SetSort("vl_fat_liquido_anual desc")
	If ids_apresentacao_dest.Sort() < 0 Then
		This.Of_grava_log( "Falha no sort no datasource ids_apresentacao_dest na fun$$HEX2$$e700e300$$ENDHEX$$o: of_preco_apresentacao_medicamento().", ids_apresentacao_dest.ivo_dberror.ivs_sqlerrtext,  as_subcategoria)
		Return False
	End If	
	//Recebe a quantidade de linhas ap$$HEX1$$f300$$ENDHEX$$s o filtro
	lvl_Linhas_Dest = ids_apresentacao_dest.RowCount()
	//Calcula o pre$$HEX1$$e700$$ENDHEX$$o de apresenta$$HEX2$$e700e300$$ENDHEX$$o para os produtos que n$$HEX1$$e300$$ENDHEX$$o encontraram SKU do mesmo laborat$$HEX1$$f300$$ENDHEX$$rio na exponencial
	For lvl_Linha = 1 To lvl_Linhas_Dest
		lvdc_Preco_Apresentacao	= ids_apresentacao_dest.Object.vl_preco_apresentacao [lvl_Linha]
		//Verifica se este SKU ainda n$$HEX1$$e300$$ENDHEX$$o tem pre$$HEX1$$e700$$ENDHEX$$o por aprensenta$$HEX2$$e700e300$$ENDHEX$$o definido (pode j$$HEX1$$e100$$ENDHEX$$ ter sido definido pelo WHILE abaixo)
		If IsNull(lvdc_Preco_Apresentacao) or (lvdc_Preco_Apresentacao = 0.00) Then			
			lvs_Lei_Gen				= ids_apresentacao_dest.Object.id_lei_generico				[lvl_Linha]
			lvs_CNPJ_Labor			= ids_apresentacao_dest.Object.nr_cnpj_laboratorio			[lvl_Linha]
			lvl_Qtde_Emb_Orig	= ids_apresentacao_dest.Object.qt_unidades_embalagem	[lvl_Linha]
			lvdc_Volume_Orig		= ids_apresentacao_dest.Object.vl_volume						[lvl_Linha]
			lvdc_Peso_Orig			= ids_apresentacao_dest.Object.qt_peso_grama				[lvl_Linha]
			//O produto de maior faturamento (que n$$HEX1$$e300$$ENDHEX$$o teve produto do mesmo laborat$$HEX1$$f300$$ENDHEX$$rio na curva exponencial) continuar$$HEX1$$e100$$ENDHEX$$ com o pre$$HEX1$$e700$$ENDHEX$$o liquido m$$HEX1$$e900$$ENDHEX$$dio atual
			ids_apresentacao_dest.Object.vl_preco_apresentacao [lvl_Linha] = ids_apresentacao_dest.Object.vl_preco_liquido [lvl_Linha]
			
			//Se a linha atual for a $$HEX1$$fa00$$ENDHEX$$ltima n$$HEX1$$e300$$ENDHEX$$o existe produto com menor faturamento para calcular
			If lvl_Linha = lvl_Linhas_Dest Then Exit
				
			//Procura no pr$$HEX1$$f300$$ENDHEX$$prio datasource por SKUs com mesmo laborat$$HEX1$$f300$$ENDHEX$$rio e lei gen$$HEX1$$e900$$ENDHEX$$rico para o c$$HEX1$$e100$$ENDHEX$$lculo da varia$$HEX2$$e700e300$$ENDHEX$$o
			lvl_Find = ids_apresentacao_dest.Find( "nr_cnpj_laboratorio = '"+lvs_CNPJ_Labor+"' and id_lei_generico='"+lvs_Lei_Gen+"'", lvl_Linha + 1, lvl_Linhas_Dest)
			Do While lvl_Find > 0
				lvl_Qtde_Emb_Dest		= ids_apresentacao_dest.Object.qt_unidades_embalagem	[lvl_Find]
				lvdc_Volume_Dest			= ids_apresentacao_dest.Object.vl_volume						[lvl_Find]
				lvdc_Peso_Dest				= ids_apresentacao_dest.Object.qt_peso_grama				[lvl_Find]
				
				//C$$HEX1$$e100$$ENDHEX$$lcula o pre$$HEX1$$e700$$ENDHEX$$o de apresenta$$HEX2$$e700e300$$ENDHEX$$o, aplicando a varia$$HEX2$$e700e300$$ENDHEX$$o sobre o pre$$HEX1$$e700$$ENDHEX$$o exponencial do SKU de refer$$HEX1$$ea00$$ENDHEX$$ncia
				Choose Case as_unid_calc_preco
					Case 'Q'
						lvdc_Variacao = ( 1 - (-0.002 * (lvl_Qtde_Emb_Dest - lvl_Qtde_Emb_Orig) + 0.952) )
						If lvl_Qtde_Emb_Orig > lvl_Qtde_Emb_Dest Then lvdc_Variacao *= -1
						lvdc_Preco_Apresentacao = Round((lvdc_Preco_Exponencial / lvl_Qtde_Emb_Orig) * ( 1 - lvdc_Variacao) * lvl_Qtde_Emb_Dest, 2)
						
					Case 'P'
						lvdc_Variacao = ( 1 - (-0.001 * (lvdc_Peso_Dest - lvdc_Peso_Orig) + 0.951) )
						If lvdc_Peso_Orig > lvdc_Peso_Dest Then lvdc_Variacao *= -1
						lvdc_Preco_Apresentacao = Round((lvdc_Preco_Exponencial / lvdc_Peso_Orig) * ( 1 - lvdc_Variacao) * lvdc_Peso_Dest, 2)
						
					Case 'V'
						lvdc_Variacao = ( 1 - (-0.009 * (lvdc_Volume_Dest - lvdc_Volume_Orig) + 1.034) )
						If lvdc_Volume_Orig > lvdc_Volume_Dest Then lvdc_Variacao *= -1
						lvdc_Preco_Apresentacao = Round((lvdc_Preco_Exponencial / lvdc_Volume_Orig) * ( 1 - lvdc_Variacao) * lvdc_Volume_Dest, 2)
						
				End Choose

				//Aplica o valor a datawindow
				ids_apresentacao_dest.Object.vl_preco_apresentacao [lvl_Find] = lvdc_Preco_Apresentacao
				// Se o SKU calculado $$HEX1$$e900$$ENDHEX$$ $$HEX1$$fa00$$ENDHEX$$ltimo sa$$HEX1$$ed00$$ENDHEX$$ do WHILE
				If lvl_Find = lvl_Linhas_Dest Then Exit
				//Procura outro produto para o c$$HEX1$$e100$$ENDHEX$$lculo
				lvl_Find = ids_apresentacao_dest.Find( "nr_cnpj_laboratorio = '"+lvs_CNPJ_Labor+"' and id_lei_generico='"+lvs_Lei_Gen+"'", lvl_Find + 1, lvl_Linhas_Dest)
			Loop
		End If
	Next	
	
	//ETAPA 3: GRAVA$$HEX2$$c700c300$$ENDHEX$$O DOS VALORES EM BANCO
	//Filtra somente os produtos ainda sem pre$$HEX1$$e700$$ENDHEX$$o de apresenta$$HEX2$$e700e300$$ENDHEX$$o por n$$HEX1$$e300$$ENDHEX$$o ter encontrado um produto do mesmo laborat$$HEX1$$f300$$ENDHEX$$rio na exponencial
	ids_apresentacao_dest.SetFilter("")
	If ids_apresentacao_dest.Filter() < 0 Then
		This.Of_grava_log( "Falha ao remover o filtro no datasource ids_apresentacao_dest na fun$$HEX2$$e700e300$$ENDHEX$$o: of_preco_apresentacao_medicamento().", ids_apresentacao_dest.ivo_dberror.ivs_sqlerrtext,  as_subcategoria)
		Return False
	End If	
	
	//Recebe a quantidade de linhas ap$$HEX1$$f300$$ENDHEX$$s o filtro
	lvl_Linhas_Dest = ids_apresentacao_dest.RowCount()
	//Calcula o pre$$HEX1$$e700$$ENDHEX$$o de apresenta$$HEX2$$e700e300$$ENDHEX$$o para os produtos que n$$HEX1$$e300$$ENDHEX$$o encontraram SKU do mesmo laborat$$HEX1$$f300$$ENDHEX$$rio na exponencial
	For lvl_Linha = 1 To lvl_Linhas_Dest
		lvl_Prod 							= ids_apresentacao_dest.Object.cd_produto				[lvl_Linha]
		lvdc_Preco_Apresentacao	= ids_apresentacao_dest.Object.vl_preco_apresentacao	[lvl_Linha]
		lvdc_Preco_Minimo			= ids_apresentacao_dest.Object.vl_preco_minimo			[lvl_Linha]
		lvdc_Preco_Maximo			= ids_apresentacao_dest.Object.vl_preco_maximo		[lvl_Linha]
		
		//Verifica se o valor est$$HEX1$$e100$$ENDHEX$$ acima do m$$HEX1$$ed00$$ENDHEX$$nimo e abaixo do m$$HEX1$$e100$$ENDHEX$$ximo
		This.of_Verifica_Preco_Minimo_Maximo(lvl_Prod, ref lvdc_Preco_Apresentacao, lvdc_Preco_Minimo, lvdc_Preco_Maximo)
		
		update precificacao_prd
		set vl_preco_apresentacao = :lvdc_Preco_Apresentacao
		Where cd_produto			= :lvl_Prod
			And nr_precificacao	= :il_NR_Precificacao
		Using SQLCa;
		
		If SQLCa.SQLCode = -1 Then
			lvs_Msg = SQLCa.SQLErrText
			SQLCa.of_RollBack()
			This.Of_Grava_Log( "Erro atualizar o pre$$HEX1$$e700$$ENDHEX$$o de apresenta$$HEX2$$e700e300$$ENDHEX$$o do produto "+String(lvl_Prod)+" na fun$$HEX2$$e700e300$$ENDHEX$$o: of_preco_apresentacao_medicamento().", lvs_Msg,  as_subcategoria, lvl_Prod)
			Return False
		End If		
	Next
	
Catch (RuntimeError lvo_Erro)
	This.Of_Grava_log( "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_apresentacao_medicamento()." , lvo_Erro.GetMessage(),  as_subcategoria)
	Return False
	
Finally
	//
	
End Try

Return True
end function

private function boolean of_posicionamento_preco_med_ref (string as_subcategoria, decimal adc_concentracao, string as_id_apresentacao, string as_un_calc_preco, ref long al_produto_referencia, ref decimal adc_preco_referencia, ref long al_unidades_embalagem, ref decimal adc_volume, ref decimal adc_peso, ref boolean ab_passa_proximo_registro);Long ll_Linha, ll_Linhas, ll_Qtde_PRD_Ref

String ls_Erro_BD

Decimal ldc_Qt_Concentracao, ldc_preco_liq_generico, ldc_preco_liq_equivalente, ldc_preco_liq_base

w_ge450_aguarde.st_processo.Text = "C$$HEX1$$e100$$ENDHEX$$lculo Pre$$HEX1$$e700$$ENDHEX$$o - Posicionamento de Pre$$HEX1$$e700$$ENDHEX$$os Med. Refer$$HEX1$$ea00$$ENDHEX$$ncia ..."

ab_passa_proximo_registro = False

SetNull(al_produto_referencia)
SetNull(adc_preco_referencia)

Choose Case as_un_calc_preco
	Case 'Q'	
		adc_volume	= 0
		adc_peso	= 0
		
		// Retorna a quantidade da embalagem que possuir o maior faturamento l$$HEX1$$ed00$$ENDHEX$$quido
		Select top 1 coalesce(qt_unidades_embalagem, 0)
		Into :al_unidades_embalagem
		From
		(
			select qt_unidades_embalagem, count(1) qt_produtos, sum(vl_fat_liquido_anual) vl_fat_liquido_anual
			from precificacao_prd
			where nr_precificacao 					= :il_NR_Precificacao
				and cd_subcategoria 					= :as_subcategoria
				and qt_concentracao 					= :adc_concentracao
				and id_apresentacao 					= :as_id_apresentacao
				and id_tipo_un_calc_preco			= :as_un_calc_preco
				and qt_unidades_embalagem 		> 0
			group by qt_unidades_embalagem
		) as tudo
		Order by vl_fat_liquido_anual desc
		Using SqlCa;
		
	Case 'P'
		adc_volume					= 0
		al_unidades_embalagem	= 0
		
		// Retorna a quantidade da embalagem que possuir o maior faturamento l$$HEX1$$ed00$$ENDHEX$$quido
		Select top 1 coalesce(qt_peso_grama, 0)
		Into :adc_peso
		From
		(
			select qt_peso_grama, count(1) qt_produtos, sum(vl_fat_liquido_anual) vl_fat_liquido_anual
			from precificacao_prd
			where nr_precificacao 					= :il_NR_Precificacao
				and cd_subcategoria 					= :as_subcategoria
				and qt_concentracao 					= :adc_concentracao
				and id_apresentacao 					= :as_id_apresentacao
				and id_tipo_un_calc_preco			= :as_un_calc_preco
				and qt_unidades_embalagem 		> 0
			group by qt_peso_grama
		) as tudo
		Order by vl_fat_liquido_anual desc
		Using SqlCa;
		
	Case 'V'
		adc_peso					= 0
		al_unidades_embalagem	= 0
		
		// Retorna a quantidade da embalagem que possuir o maior faturamento l$$HEX1$$ed00$$ENDHEX$$quido
		Select top 1 coalesce(vl_volume, 0)
		Into :adc_volume
		From
		(
			select vl_volume, count(1) qt_produtos, sum(vl_fat_liquido_anual) vl_fat_liquido_anual
			from precificacao_prd
			where nr_precificacao 					= :il_NR_Precificacao
				and cd_subcategoria 					= :as_subcategoria
				and qt_concentracao 					= :adc_concentracao
				and id_apresentacao 					= :as_id_apresentacao
				and id_tipo_un_calc_preco			= :as_un_calc_preco
				and qt_unidades_embalagem 		> 0
			group by vl_volume
		) as tudo
		Order by vl_fat_liquido_anual desc
		Using SqlCa;
		
	Case Else
		// Executa o pr$$HEX1$$f300$$ENDHEX$$ximo registro
		This.of_Grava_Log("Tipo de unidade de c$$HEX1$$e100$$ENDHEX$$lculo "+IIF(Trim(as_un_calc_preco)<>"","["+as_un_calc_preco+"] inv$$HEX1$$e100$$ENDHEX$$lida","n$$HEX1$$e300$$ENDHEX$$o preenchida")+".", '',  as_subcategoria)
		ab_passa_proximo_registro = True
		Return True
End Choose

If SqlCa.SqlCode = -1 Then
	ls_Erro_BD = SqlCa.SqlErrText
	SqlCa.of_RollBack()
	This.of_Grava_Log("Recuperar a unidade de embalagem com maior faturamento l$$HEX1$$ed00$$ENDHEX$$quido.", ls_Erro_BD,  as_subcategoria)
	Return False
End If

Choose Case as_un_calc_preco
	Case "Q"
		If IsNull(al_unidades_embalagem) or (al_unidades_embalagem = 0) Then
			// Executa o pr$$HEX1$$f300$$ENDHEX$$ximo registro
			This.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o foi localizada a quantidade de produtos na embalagem com maior faturamento.", '',  as_subcategoria)
			ab_passa_proximo_registro = True
			Return True
		End If

	Case "P"
		If IsNull(adc_peso) or (adc_peso = 0) Then
			// Executa o pr$$HEX1$$f300$$ENDHEX$$ximo registro
			This.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o foi localizada o peso do SKU com maior faturamento.", '',  as_subcategoria)
			ab_passa_proximo_registro = True
			Return True
		End If

	Case "V"
		If IsNull(adc_volume) or (adc_volume = 0) Then
			// Executa o pr$$HEX1$$f300$$ENDHEX$$ximo registro
			This.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o foi localizada o volume do SKU com maior faturamento.", '',  as_subcategoria)
			ab_passa_proximo_registro = True
			Return True
		End If
		
End Choose

Select  count(1)
Into :ll_Qtde_PRD_Ref
from precificacao_prd p
where p.nr_precificacao					= :il_NR_Precificacao
	and p.cd_subcategoria				= :as_subcategoria
	and p.qt_concentracao				= :adc_concentracao
	and p.id_apresentacao				= :as_id_apresentacao
	and p.id_tipo_un_calc_preco		= :as_un_calc_preco
	and ((coalesce(p.id_tipo_un_calc_preco,'') = 'Q' and p.qt_unidades_embalagem = :al_unidades_embalagem) or coalesce(p.id_tipo_un_calc_preco,'') <> 'Q')
	and ((coalesce(p.id_tipo_un_calc_preco,'') = 'P' and p.qt_peso_grama = :adc_peso) or coalesce(p.id_tipo_un_calc_preco,'') <> 'P')
	and ((coalesce(p.id_tipo_un_calc_preco,'') = 'V' and p.vl_volume = :adc_volume) or coalesce(p.id_tipo_un_calc_preco,'') <> 'V')
	and p.id_lei_generico 				= 'R'
Using SqlCa;
	
If SqlCa.SqlCode = -1 Then
	ls_Erro_BD = SqlCa.SqlErrText
	SqlCa.of_RollBack()
	This.of_Grava_Log("Recuperar a quantidade de produtos lei gen$$HEX1$$e900$$ENDHEX$$rico REFER$$HEX1$$ca00$$ENDHEX$$NCIA.", ls_Erro_BD,  as_subcategoria)
	Return False
End If

If ll_Qtde_PRD_Ref > 1 Then
	// Executa o pr$$HEX1$$f300$$ENDHEX$$ximo registro
	This.of_Grava_Log("Foi encontrado mais de um produto com a lei gen$$HEX1$$e900$$ENDHEX$$rico REFER$$HEX1$$ca00$$ENDHEX$$NCIA, o c$$HEX1$$e100$$ENDHEX$$lculo n$$HEX1$$e300$$ENDHEX$$o foi finalizado.", '',  as_subcategoria)
	//ab_passa_proximo_registro = True
	Return True
End If

If ll_Qtde_PRD_Ref = 0 Then
	// Executa o pr$$HEX1$$f300$$ENDHEX$$ximo registro
	This.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o foi localizado produto com a lei gen$$HEX1$$e900$$ENDHEX$$rico REFER$$HEX1$$ca00$$ENDHEX$$NCIA, o c$$HEX1$$e100$$ENDHEX$$lculo n$$HEX1$$e300$$ENDHEX$$o foi finalizado.", '',  as_subcategoria)
	ab_passa_proximo_registro = True
	Return True
End If

// Maior faturamento l$$HEX1$$ed00$$ENDHEX$$quido LEI GENERICO - REFER$$HEX1$$ca00$$ENDHEX$$NCIA
select  top 1 p.cd_produto, coalesce(p.vl_preco_liquido, 0)
Into :al_produto_referencia, :adc_preco_referencia		  
from precificacao_prd p
where p.nr_precificacao 						= :il_NR_Precificacao
	and p.cd_subcategoria 					= :as_subcategoria
	and p.qt_concentracao 					= :adc_concentracao
	and p.id_apresentacao 					= :as_id_apresentacao
	and p.id_tipo_un_calc_preco			= :as_un_calc_preco
	and p.id_lei_generico 					= 'R'
	and ((coalesce(p.id_tipo_un_calc_preco,'') = 'Q' and p.qt_unidades_embalagem = :al_unidades_embalagem) or coalesce(p.id_tipo_un_calc_preco,'') <> 'Q')
	and ((coalesce(p.id_tipo_un_calc_preco,'') = 'P' and p.qt_peso_grama = :adc_peso) or coalesce(p.id_tipo_un_calc_preco,'') <> 'P')
	and ((coalesce(p.id_tipo_un_calc_preco,'') = 'V' and p.vl_volume = :adc_volume) or coalesce(p.id_tipo_un_calc_preco,'') <> 'V')
order by p.vl_fat_liquido_anual desc
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro_BD = SqlCa.SqlErrText
	SqlCa.of_RollBack()
	This.of_Grava_Log("Recuperar o maior pre$$HEX1$$e700$$ENDHEX$$o do produto lei gen$$HEX1$$e900$$ENDHEX$$rico REFER$$HEX1$$ca00$$ENDHEX$$NCIA.", ls_Erro_BD,  as_subcategoria )
	Return False
End If

//A compara$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$os (REFER$$HEX1$$ca00$$ENDHEX$$NCIA => GEN$$HEX1$$c900$$ENDHEX$$RICO e REFER$$HEX1$$ca00$$ENDHEX$$NCIA => EQUIVALENTE) e altera$$HEX2$$e700e300$$ENDHEX$$o somente ocorre para o calculo MEDICAMENTO RX
If il_Tipo_Precificacao = 1 Then
	// Maior faturamento l$$HEX1$$ed00$$ENDHEX$$quido LEI GENERICO - GENERICO
	select  top 1 coalesce(p.vl_preco_liquido, 0)
	Into :ldc_preco_liq_generico
	from precificacao_prd p
	where p.nr_precificacao 						= :il_NR_Precificacao
		and p.cd_subcategoria 					= :as_subcategoria
		and p.qt_concentracao 					= :adc_concentracao
		and p.id_apresentacao 					= :as_id_apresentacao
		and p.id_tipo_un_calc_preco			= :as_un_calc_preco
		and p.id_lei_generico 					= 'G'
		and ((coalesce(p.id_tipo_un_calc_preco,'') = 'Q' and p.qt_unidades_embalagem = :al_unidades_embalagem) or coalesce(p.id_tipo_un_calc_preco,'') <> 'Q')
		and ((coalesce(p.id_tipo_un_calc_preco,'') = 'P' and p.qt_peso_grama = :adc_peso) or coalesce(p.id_tipo_un_calc_preco,'') <> 'P')
		and ((coalesce(p.id_tipo_un_calc_preco,'') = 'V' and p.vl_volume = :adc_volume) or coalesce(p.id_tipo_un_calc_preco,'') <> 'V')
	order by p.vl_fat_liquido_anual desc
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro_BD = SqlCa.SqlErrText
		SqlCa.of_RollBack()
		This.of_Grava_Log("Recuperar o maior pre$$HEX1$$e700$$ENDHEX$$o do produto lei gen$$HEX1$$e900$$ENDHEX$$rico GEN$$HEX1$$c900$$ENDHEX$$RICO.", ls_Erro_BD,  as_subcategoria )
		Return False
	End If
	
	// Maior faturamento l$$HEX1$$ed00$$ENDHEX$$quido LEI GENERICO - EQUIVALENTE
	select  top 1 coalesce(p.vl_preco_liquido, 0)
	Into :ldc_preco_liq_equivalente
	from precificacao_prd p
	where p.nr_precificacao 						= :il_NR_Precificacao
		and p.cd_subcategoria 					= :as_subcategoria
		and p.qt_concentracao 					= :adc_concentracao
		and p.id_apresentacao 					= :as_id_apresentacao
		and p.id_tipo_un_calc_preco			= :as_un_calc_preco
		and p.id_lei_generico 					= 'E'
		and ((coalesce(p.id_tipo_un_calc_preco,'') = 'Q' and p.qt_unidades_embalagem = :al_unidades_embalagem) or coalesce(p.id_tipo_un_calc_preco,'') <> 'Q')
		and ((coalesce(p.id_tipo_un_calc_preco,'') = 'P' and p.qt_peso_grama = :adc_peso) or coalesce(p.id_tipo_un_calc_preco,'') <> 'P')
		and ((coalesce(p.id_tipo_un_calc_preco,'') = 'V' and p.vl_volume = :adc_volume) or coalesce(p.id_tipo_un_calc_preco,'') <> 'V')
	order by p.vl_fat_liquido_anual desc
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro_BD = SqlCa.SqlErrText
		SqlCa.of_RollBack()
		This.of_Grava_Log("Recuperar o maior pre$$HEX1$$e700$$ENDHEX$$o do produto lei gen$$HEX1$$e900$$ENDHEX$$rico EQUIVALENTE.", ls_Erro_BD,  as_subcategoria )
		Return False
	End If

	If adc_preco_referencia > 0 Then
		If ldc_preco_liq_generico = 0 and ldc_preco_liq_equivalente = 0 Then
			// Executa o pr$$HEX1$$f300$$ENDHEX$$ximo registro
			This.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o existe produto GEN$$HEX1$$c900$$ENDHEX$$RICO e EQUIVALENTE com pre$$HEX1$$e700$$ENDHEX$$o l$$HEX1$$ed00$$ENDHEX$$quido maior que zero.", '',  as_subcategoria)
			ab_passa_proximo_registro = True
			Return True
		End If
		
		If (round(ldc_preco_liq_generico * 1.53, 2) > adc_preco_referencia) or (round(ldc_preco_liq_equivalente * 1.15, 2) > adc_preco_referencia) Then
			// O produto lei gen$$HEX1$$e900$$ENDHEX$$rico REFER$$HEX1$$ca00$$ENDHEX$$NCIA assume o pre$$HEX1$$e700$$ENDHEX$$o do gen$$HEX1$$e900$$ENDHEX$$rico acrescido de 53%
			If round(ldc_preco_liq_generico * 1.53, 2) > adc_preco_referencia  Then
				adc_preco_referencia = round(ldc_preco_liq_generico * 1.53, 2)
			Else
				// O produto lei gen$$HEX1$$e900$$ENDHEX$$rico EQUIVALENTE assume o pre$$HEX1$$e700$$ENDHEX$$o do equivalente acrescido de 15%
				adc_preco_referencia = round(ldc_preco_liq_equivalente * 1.15, 2)
			End If
		End If
	Else
		// Executa o pr$$HEX1$$f300$$ENDHEX$$ximo registro
		This.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o existe produto lei gen$$HEX1$$e900$$ENDHEX$$rico REFER$$HEX1$$ca00$$ENDHEX$$NCIA com pre$$HEX1$$e700$$ENDHEX$$o l$$HEX1$$ed00$$ENDHEX$$quido maior que zero.", '',  as_subcategoria)
	End If
End If

Return True
end function

private function boolean of_periodo (integer ai_meses, ref date adh_inicio, ref date adh_termino);Integer li_Cont

Date ldh_Parametro

If Not gf_Data_Parametro(ref ldh_Parametro) Then Return False

adh_termino = RelativeDate (gf_Primeiro_Dia_Mes(ldh_Parametro), -1)
adh_termino = gf_Primeiro_Dia_Mes(adh_termino)

adh_inicio = adh_termino

For li_Cont = 2 To ai_meses
	adh_inicio = RelativeDate (gf_Primeiro_Dia_Mes(adh_inicio), -1)
	adh_inicio = gf_Primeiro_Dia_Mes(adh_inicio)
Next










end function

private function boolean of_inclui_preco_minimo (long al_produto, string as_uf, string as_rede, long al_tipo_minimo, decimal adc_preco_minimo);String ls_MSG

INSERT INTO precificacao_prd_minimo  ( nr_precificacao, cd_produto, cd_unidade_federacao, id_rede_filial, cd_tipo_minimo, vl_preco_minimo )  
VALUES ( :il_NR_Precificacao, :al_produto, :as_uf, :as_rede,  :al_tipo_minimo, :adc_preco_minimo)
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	ls_MSG = SqlCa.SqlErrText
	SqlCa.of_RollBack()
	This.of_Grava_Log("Erro ao inserir o valor m$$HEX1$$ed00$$ENDHEX$$nimo para o produto [" + String(al_produto) + "].", ls_MSG, ivs_Subcategoria, al_produto)
	Return False
End If

Return True

end function

private function boolean of_grava_produto (string as_uf, string as_rede_filial, string as_subcategoria);Date ldt_Inicio_Resumo, ldt_Termino_Resumo, ldt_Inicio_Resumo_Ano, ldt_Termino_Resumo_Ano

Long ll_Linha, ll_Linhas, ll_Produto, ll_Qtde_Vendida_3, ll_Qtde_Vendida_12, ll_Subcat_Tier, ll_Subcat_Classif

String ls_Rede_Fil, ls_UF, ls_MSG, ls_Parceiro, ls_Un_Calc_Preco

Decimal ldc_Margem_Minima, ldc_Preco_Forn, ldc_Rembolso_FPB, ldc_Custo_Medio, ldc_Preco_Liquido, ldc_Fat_Liquido_Anual, ldc_Fator_Conversao

String ls_CD_SubCategoria, ls_DE_SubCategoria, ls_Apresentacao, ls_Farm_Pop, ls_Gratis_Farm_Pop, ls_PBM, ls_Lei_Generico, ls_UN_Venda, lvs_CNPJ_Lab
						
Decimal ldc_Concentracao, ldc_Preco_Venda, ldc_Peso, ldc_Volume, ldc_Preco_Maximo, ldc_Fator_Prod_Ref
			
Long ll_Grupo_Alt_Preco, ll_Marca, ll_Unid_Emb, ll_Prod_Ref

try	
	w_ge450_aguarde.uo_progress.of_setstart()
	w_ge450_aguarde.st_processo.Text = "Gravando Produtos ..."
	
	//of_Grava_Log("Erro - Recuperar a lista de produtos.")
	
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge450_lista_produto", False) Then 
		This.of_Grava_Log("Erro na troca da dw [ds_ge450_lista_produto].", '')
		Return False
	End If
	
	// Retorna os $$HEX1$$fa00$$ENDHEX$$ltimos tr$$HEX1$$ea00$$ENDHEX$$s meses de resumo
	If Not of_periodo(Integer(3), ref ldt_Inicio_Resumo, ldt_Termino_Resumo) Then Return False
		
	// Retorna os $$HEX1$$fa00$$ENDHEX$$ltimos 12 meses de resumo
	If Not of_periodo(Integer(12), ref ldt_Inicio_Resumo_Ano, ldt_Termino_Resumo_Ano) Then Return False
	
	If Not IsNull(as_uf) Then
		lds.of_appendwhere_subquery("u.cd_unidade_federacao = '" + as_UF + "'", 5)
	End If
	
	If Not IsNull(as_subcategoria) Then
		lds.of_appendwhere_subquery("g.cd_subcategoria =  '" + as_subcategoria + "'", 5)
	End If
	
	If Not IsNull(as_rede_filial) Then
		lds.of_appendwhere_subquery("f.id_rede_filial =  '" + as_rede_filial + "'", 5)
	End If
	
	ll_Linhas = lds.Retrieve(il_Tipo_Precificacao)
				
	If ll_Linhas > 0 Then
		
		w_ge450_aguarde.uo_progress.of_setmax(ll_Linhas)
								
		For ll_Linha = 1 To ll_Linhas
			
			ll_Produto 				= lds.Object.cd_produto						[ll_Linha]
			ls_Rede_Fil 				= lds.Object.id_rede_filial					[ll_Linha]
			ls_UF 						= lds.Object.cd_unidade_federacao		[ll_Linha]
			ldc_Margem_Minima 	= lds.Object.pc_margem_minima			[ll_Linha]
			ldc_Preco_Forn			= lds.Object.vl_preco_venda_fornecedor	[ll_Linha]
			ldc_Rembolso_FPB		= lds.Object.vl_reembolso_fpb				[ll_Linha]
			ls_CD_SubCategoria	= lds.Object.cd_subcategoria				[ll_Linha]
			ls_DE_SubCategoria	= lds.Object.de_subcategoria				[ll_Linha]
			ldc_Concentracao		= lds.Object.qt_concentracao				[ll_Linha]
			ls_Apresentacao		= lds.Object.id_apresentacao				[ll_Linha]
			ls_UN_Venda			= lds.Object.cd_unidade_medida_venda	[ll_Linha]
			ldc_Preco_Venda		= lds.Object.vl_preco_venda_atual		[ll_Linha]
			ldc_Preco_Maximo		= lds.Object.vl_preco_venda_maximo		[ll_Linha]
			ls_Farm_Pop			= lds.Object.id_farmacia_popular			[ll_Linha]
			ls_Gratis_Farm_Pop	= lds.Object.id_gratis_farm_popular		[ll_Linha]
			ls_PBM					= lds.Object.id_pbm							[ll_Linha]
			ls_Lei_Generico			= lds.Object.id_lei_generico					[ll_Linha]
			ll_Grupo_Alt_Preco	= lds.Object.cd_grupo_alteracao_preco	[ll_Linha]
			ll_Marca					= lds.Object.cd_marca						[ll_Linha]
			ll_Unid_Emb				= lds.Object.qt_unidades_embalagem	[ll_Linha]
			ls_Parceiro				= lds.Object.id_fornecedor_parceiro		[ll_Linha]
			ldc_Peso					= lds.Object.qt_peso_apresentacao		[ll_Linha]
			ldc_Volume				= lds.Object.vl_volume						[ll_Linha]
			ls_Un_Calc_Preco		= lds.Object.id_tipo_un_calc_preco		[ll_Linha]
			lvs_CNPJ_Lab			= lds.Object.nr_cnpj_laboratorio			[ll_Linha]
			ll_Subcat_Tier			= lds.Object.cd_tier							[ll_Linha]
			ll_Subcat_Classif		= lds.Object.cd_classificacao				[ll_Linha]
			ldc_Fator_Conversao	= lds.Object.vl_fator_conversao			[ll_Linha]
			ll_Prod_Ref				= lds.Object.cd_prod_referencia_preco	[ll_Linha]
			ldc_Fator_Prod_Ref	= lds.Object.pc_prod_referencia_preco	[ll_Linha]
			
			ldc_Preco_Liquido 		= ldc_Preco_Venda
			
			ivs_Chave =   "<b>SubCategoria:</b> "+ls_DE_SubCategoria+" ("+ls_CD_SubCategoria+")"
			
			//Verifica se foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a margem m$$HEX1$$ed00$$ENDHEX$$nima para este produto
			If IsNull(ldc_Margem_Minima) Then
				Choose Case il_Tipo_Precificacao
					Case 1
						If IsNull(ls_Lei_Generico) Then
							ls_MSG = "Lei Gen$$HEX1$$e900$$ENDHEX$$rico n$$HEX1$$e300$$ENDHEX$$o informada para o produto "+String(ll_Produto)+"."
						End If
					Case 2
						If IsNull(ll_Subcat_Classif) Then
							ls_MSG = "Papel/Classifica$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o informado para a subcategoria "+as_subcategoria+"."
						End If
					Case 3
						If IsNull(ll_Subcat_Tier) Then
							ls_MSG = "TIER n$$HEX1$$e300$$ENDHEX$$o informado para a subcategoria "+as_subcategoria+"."
						End If
						
						If IsNull(ls_Lei_Generico) Then
							ls_MSG = "Lei Gen$$HEX1$$e900$$ENDHEX$$rico n$$HEX1$$e300$$ENDHEX$$o informada para o produto "+String(ll_Produto)+"."
						End If
					
				End Choose
				
				This.of_Grava_Log(ls_MSG, '', as_subcategoria, ll_Produto)
				Continue
			End If
			
			//Valida informa$$HEX2$$e700e300$$ENDHEX$$o da Unidade de C$$HEX1$$e100$$ENDHEX$$lculo de Pre$$HEX1$$e700$$ENDHEX$$o (necess$$HEX1$$e100$$ENDHEX$$ria para o pre$$HEX1$$e700$$ENDHEX$$o por apresenta$$HEX2$$e700e300$$ENDHEX$$o)
			Choose Case ls_Un_Calc_Preco
				Case 'Q'
					If (IsNull(ll_Unid_Emb) or (ll_Unid_Emb <= 0)) Then
						This.of_Grava_Log("Produto "+String(ll_Produto)+" com tipo de unidade de c$$HEX1$$e100$$ENDHEX$$lculo QUANTIDADE, mas sem quantidade por embalagem informada.", '', as_subcategoria, ll_Produto)
						Continue
					End If

				Case 'P'
					If (IsNull(ldc_Peso) or (ldc_Peso <= 0)) Then
						This.of_Grava_Log("Produto "+String(ll_Produto)+" com tipo de unidade de c$$HEX1$$e100$$ENDHEX$$lculo PESO, mas sem peso apresenta$$HEX2$$e700e300$$ENDHEX$$o informado.", '', as_subcategoria, ll_Produto)
						Continue
					End If
					
				Case 'V'
					If (IsNull(ldc_Volume) or (ldc_Volume <= 0)) Then
						This.of_Grava_Log("Produto "+String(ll_Produto)+" com tipo de unidade de c$$HEX1$$e100$$ENDHEX$$lculo VOLUME, mas sem volume informado.", '', as_subcategoria, ll_Produto)
						Continue
					End If
					
				Case Else
					//Verifica se os produtos sem tipo unidade de c$$HEX1$$e100$$ENDHEX$$lculo de pre$$HEX1$$e700$$ENDHEX$$o (necess$$HEX1$$e100$$ENDHEX$$rio para medicamentos) 
					This.of_Grava_Log("Produto "+String(ll_Produto)+" sem tipo de unidade de c$$HEX1$$e100$$ENDHEX$$lculo preenchida.", '', as_subcategoria, ll_Produto)
					Continue
			End Choose
			
			If IsNull(ldc_Preco_Maximo) or (ldc_Preco_Maximo=0.00) Then
				//Para os tipos de c$$HEX1$$e100$$ENDHEX$$lculo MED. RX e MED. MIP, na aus$$HEX1$$ea00$$ENDHEX$$ncia de PMC, o valor bruto $$HEX1$$e900$$ENDHEX$$ o m$$HEX1$$e100$$ENDHEX$$ximo poss$$HEX1$$ed00$$ENDHEX$$vel
				If il_Tipo_Precificacao = 1 or il_Tipo_Precificacao = 3 Then
					ldc_Preco_Maximo = ldc_Preco_Venda
				End If
			End If
		
			// M$$HEX1$$e900$$ENDHEX$$dia dos custos de cada venda nos $$HEX1$$fa00$$ENDHEX$$ltimos 3 meses
			Select coalesce(round(sum(vl_custo) / sum(qt_vendida), 2), 0), sum(qt_vendida)
			Into :ldc_Custo_Medio, :ll_Qtde_Vendida_3
			From resumo_precificacao
			where cd_produto = :ll_Produto
			   and cd_uf = :ls_UF
			   and id_rede_filial = :ls_Rede_Fil
			   and dh_resumo >= :ldt_Inicio_Resumo
			   and dh_resumo <= :ldt_Termino_Resumo
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_MSG = SqlCa.SqlErrText
				SqlCa.of_RollBack()
				This.of_Grava_Log("Erro - Localizar o custo m$$HEX1$$e900$$ENDHEX$$dio do resumo do produto [" + String(ll_Produto) + "].", ls_MSG, ls_CD_SubCategoria, ll_Produto)
				Return False
			End If
			
			If ldc_Custo_Medio <= 0.00 Then	This.of_Grava_Log("Custo m$$HEX1$$e900$$ENDHEX$$dio do resumo do produto [" + String(ll_Produto) + "] est$$HEX1$$e100$$ENDHEX$$ "+IIF(ldc_Custo_Medio=0.00,"zerado","negativo")+".", ls_MSG, ls_CD_SubCategoria, ll_Produto)
			
			// Quantidade vendida nos $$HEX1$$fa00$$ENDHEX$$ltimos 12 meses
			Select coalesce(sum(qt_vendida), 0)
			Into :ll_Qtde_Vendida_12
			From resumo_precificacao
			where cd_produto 	= :ll_Produto
			   and cd_uf 			= :ls_UF
			   and id_rede_filial 	= :ls_Rede_Fil
			   and dh_resumo 		>= :ldt_Inicio_Resumo_Ano
			   and dh_resumo 		<= :ldt_Termino_Resumo_Ano
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_MSG = SqlCa.SqlErrText
				SqlCa.of_RollBack()
				This.of_Grava_Log("Erro - Localizar o custo m$$HEX1$$e900$$ENDHEX$$dio do resumo do produto [" + String(ll_Produto) + "].", ls_MSG, ls_CD_SubCategoria, ll_Produto)
				Return False
			End If
						
			// Pre$$HEX1$$e700$$ENDHEX$$o L$$HEX1$$ed00$$ENDHEX$$quido - Medicamento (RX  e MIP)
			If il_Tipo_Precificacao = 1 or il_Tipo_Precificacao = 3 Then
				If Not This.of_preco_liquido_medicamento(ll_Produto, ls_UF, ls_Rede_Fil, ldt_Inicio_Resumo, ldt_Termino_Resumo, ldc_Preco_Venda, ref ldc_Preco_Liquido ) Then Return False
			End If
			
			If ldc_Fator_Conversao <> 1 Then
				ldc_Preco_Venda	= Round(ldc_Preco_Venda / ldc_Fator_Conversao, 2)
				ldc_Preco_Liquido	= Round(ldc_Preco_Liquido / ldc_Fator_Conversao, 2)
				//Efetuar o truncate, pois caso o PMC n$$HEX1$$e300$$ENDHEX$$o seja divis$$HEX1$$ed00$$ENDHEX$$vel pelo fator de convers$$HEX1$$e300$$ENDHEX$$o e o arrendondamento
				// aumentar o valor unit$$HEX1$$e100$$ENDHEX$$rio, a precifica$$HEX2$$e700e300$$ENDHEX$$o final do produto poder$$HEX1$$e100$$ENDHEX$$ ser superior ao PMC
				ldc_Preco_Maximo	= Truncate(ldc_Preco_Maximo / ldc_Fator_Conversao, 2)
			End If
			
			ldc_Fat_Liquido_Anual = round(ll_Qtde_Vendida_12 * ldc_Preco_Liquido, 2)
											
			INSERT INTO precificacao_prd(	nr_precificacao,   
													cd_produto,   
													cd_unidade_federacao,   
													id_rede_filial,   
													cd_tipo_precificacao,
													vl_preco_minimo,   
													vl_preco_liquido,   
													qt_vendida_3, 
													qt_vendida_12,
													vl_fat_liquido_anual,   
													vl_preco_exponencial,   
													vl_preco_lab_parceiro,   
													vl_preco_psicologico,   
													vl_preco_final,
													pc_margem_minima,
													vl_preco_venda_fornecedor,
													vl_preco_maximo,
													vl_custo_medio,
													vl_reembolso_fpb,
													cd_subcategoria,
													qt_concentracao,
													id_apresentacao,
													cd_unidade_medida_venda,
													vl_preco_venda_atual,
													id_farmacia_popular,
													id_gratis_farm_popular,
													id_pbm,               
													id_lei_generico,      
													cd_grupo_alteracao_preco,
													cd_marca_produto,
													id_tipo_un_calc_preco, 
													qt_unidades_embalagem,
													qt_peso_grama,
													vl_volume,
													id_fornecedor_parceiro,
													nr_cnpj_laboratorio,
													cd_prod_referencia_preco,
													pc_prod_referencia_preco)
										  
			VALUES (:il_NR_Precificacao,  		//nr_precificacao,   
						:ll_Produto, 					//cd_produto,   
						:ls_UF, 						//cd_unidade_federacao,   
						:ls_Rede_Fil,				//id_rede_filial,   
						:il_Tipo_Precificacao,		//cd_tipo_precificacao
						0.00,							//vl_preco_minimo,   
						:ldc_Preco_Liquido,		//vl_preco_liquido,   
						:ll_Qtde_Vendida_3, 		//qt_vendida_3 (Quantidade Vendida nos $$HEX1$$fa00$$ENDHEX$$ltimos 3 meses)
						:ll_Qtde_Vendida_12, 	//qt_vendida_12 (Quantidade Vendida nos $$HEX1$$fa00$$ENDHEX$$ltimos 12 meses)
						:ldc_Fat_Liquido_Anual,	//vl_fat_liquido_anual,   
						0.00,							//vl_preco_exponencial,   
						0.00,							//vl_preco_lab_parceiro,   
						0.00,							//vl_preco_psicologico,   
						0.00,							//vl_preco_final
						:ldc_Margem_Minima, 	//pc_margem_minima
						:ldc_Preco_Forn	,		//vl_preco_venda_fornecedor
						:ldc_Preco_Maximo, 		//vl_preco_maximo
						:ldc_Custo_Medio,			//vl_custo_medio
						:ldc_Rembolso_FPB,		//vl_reembolso_fpb
						:ls_CD_SubCategoria,		//cd_subcategoria,
						:ldc_Concentracao,		//qt_concentracao,
						:ls_Apresentacao,			//id_apresentacao,
						:ls_UN_Venda,				//cd_unidade_medida_venda,
						:ldc_Preco_Venda,			//vl_preco_venda_atual,
						:ls_Farm_Pop,				//id_farmacia_popular,
						:ls_Gratis_Farm_Pop,		//id_gratis_farm_popular,
						:ls_PBM,						//id_pbm,               
						:ls_Lei_Generico,			//id_lei_generico,      
						:ll_Grupo_Alt_Preco,		//cd_grupo_alteracao_preco,
						:ll_Marca,					//cd_marca_produto
						:ls_Un_Calc_Preco, 		//id_tipo_un_calc_preco
						:ll_Unid_Emb,				//qt_unidades_embalagem
						:ldc_Peso, 					//qt_peso_grama
						:ldc_Volume, 				//vl_volume
						:ls_Parceiro,				//id_fornecedor_parceiro
						:lvs_CNPJ_Lab,				//nr_cnpj_laboratorio
						:ll_Prod_Ref,				//cd_prod_referencia_preco
						:ldc_Fator_Prod_Ref		//pc_prod_referencia_preco
						)					
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_MSG = SqlCa.SqlErrText
				SqlCa.of_RollBack()
				This.of_Grava_Log("Erro - Inserir o produto na tabela de precifica$$HEX2$$e700e300$$ENDHEX$$o [" + String(ll_Produto) + "].", ls_MSG, ls_CD_SubCategoria, ll_Produto)
				Return False
			End If
															
			w_ge450_aguarde.uo_progress.of_setprogress(ll_Linha)
			
		Next
		
	ElseIf ll_Linhas < 0 Then
		SqlCa.of_RollBack();
		of_Grava_Log("Erro - Recuperar a lista de produtos.", '')
		Return False
	End If
	
Catch ( RuntimeError  lo_rte )
	of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_produto()'.", lo_rte.GetMessage( ))
	SqlCa.of_RollBack();
	Return False		
	
finally
	If IsValid(lds) Then Destroy lds
end try

Return True
end function

public function boolean of_grava_precificacao (integer ai_tipo_precificacao, string as_uf, string as_rede, string as_subcategoria, string as_matricula_responsavel);Long ll_Proximo

Select coalesce(max(nr_precificacao), 0) + 1
Into :ll_Proximo
From precificacao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack();
	of_Grava_Log("Localiza$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo de precific$$HEX1$$e300$$ENDHEX$$o.", '')
	Return False
End If

INSERT INTO precificacao  ( nr_precificacao, cd_tipo_precificacao, cd_uf, id_rede_filial,  cd_subcategoria, dh_inclusao,  nr_matricula_responsavel, id_situacao)  
VALUES ( :ll_Proximo, :ai_tipo_precificacao, :as_uf,  :as_rede, :as_subcategoria, getdate(), :as_matricula_responsavel, 'C')
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack();
	of_Grava_Log("Erro ao incluir a precifica$$HEX2$$e700e300$$ENDHEX$$o.", '')
	Return False
End If

SqlCa.of_Commit();

Return True


end function

private function boolean of_exponencial_verifica_preco ();Long lvl_Linha
Long lvl_Prod

Decimal{2} lvdc_VL_Ponto
Decimal{2} lvdc_VL_Minimo
Decimal{2} lvdc_VL_Maximo
Decimal{2} lvdc_VL_Final

String lvs_MSG

Try
	ids_exponencial.SetFilter("not isNull(cd_produto)")
	If ids_exponencial.Filter() < 0 Then
		This.Of_grava_log( "Falha ao aplicar o filtro no datasource exponencial na fun$$HEX2$$e700e300$$ENDHEX$$o: of_exponencial_verifica_preco().", ids_exponencial.ivo_dberror.ivs_sqlerrtext, ivs_Subcategoria)
		Return False
	End If
	
	For lvl_Linha = 1 To ids_exponencial.RowCount()
		lvl_Prod				= ids_exponencial.Object.cd_produto			[lvl_Linha]
		lvdc_VL_Ponto		= ids_exponencial.Object.vl_preco_ponto	[lvl_Linha]
		lvdc_VL_Minimo	= ids_exponencial.Object.vl_preco_minimo	[lvl_Linha]
		lvdc_VL_Maximo	= ids_exponencial.Object.vl_preco_maximo	[lvl_Linha]
		lvdc_VL_Final		= lvdc_VL_Ponto
		
		//Verifica se o valor est$$HEX1$$e100$$ENDHEX$$ acima do m$$HEX1$$ed00$$ENDHEX$$nimo e abaixo do m$$HEX1$$e100$$ENDHEX$$ximo
		This.of_Verifica_Preco_Minimo_Maximo(lvl_Prod, ref lvdc_VL_Final, lvdc_VL_Minimo, lvdc_VL_Maximo)
		
		ids_exponencial.Object.vl_preco_exponencial	[lvl_Linha] = lvdc_VL_Final
	Next 
Catch (RuntimeError lvo_Erro)
	This.Of_grava_log( "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o: of_exponencial_verifica_preco().", lvo_Erro.GetMessage(), ivs_Subcategoria)
	Return False
	
Finally
	ids_exponencial.SetFilter("")
	If ids_exponencial.Filter() < 0 Then
		This.Of_grava_log( "Falha ao remover o filtro no datasource exponencial na fun$$HEX2$$e700e300$$ENDHEX$$o: of_exponencial_verifica_preco().", ids_exponencial.ivo_dberror.ivs_sqlerrtext, ivs_Subcategoria)
		Return False
	End If	
	
End Try

Return True
end function

private function boolean of_exponencial_valor (string as_rede, string as_subcategoria, decimal adc_concentracao, string as_id_apresentacao, string as_un_calculo, long al_unidades_embalagem, decimal adc_volume, decimal adc_peso, long al_produto_referencia, decimal adc_preco_referencia, ref boolean ab_passa_proximo_registro);Long ll_Linha, ll_Linhas, ll_Produto, ll_Produto_Menor_Preco

Decimal ldc_Preco_Liquido, ldc_Coef, ldc_Expoente, ldc_Fat_Liq_Anual, ldc_Preco_Minimo, ldc_Preco_Maximo

String ls_LeiGenerico, ls_Forn_Parceiro

ab_passa_proximo_registro = False

try
	w_ge450_aguarde.st_processo.Text = "C$$HEX1$$e100$$ENDHEX$$lculo Pre$$HEX1$$e700$$ENDHEX$$o - Exponencialidade de Valor"
	
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge450_exponencial", False) Then 
		This.of_Grava_Log("Erro na troca da dw [ds_ge450_exponencial].", lds.ivo_DbError.ivs_SQLErrText, ivs_Subcategoria)
		Return False
	End If
			
	ll_Linhas = lds.Retrieve(il_NR_Precificacao, as_subcategoria, adc_concentracao, as_id_apresentacao, as_un_calculo, al_unidades_embalagem, adc_volume, adc_peso)
	
	lds.SetSort("p.vl_preco_liquido asc")
	lds.Sort()
				
	If ll_Linhas > 0 Then
		If IsNull(al_produto_referencia) Then al_produto_referencia = lds.Object.cd_produto[ll_Linhas]
		
		// Verifica se o $$HEX1$$fa00$$ENDHEX$$ltimo produto $$HEX1$$e900$$ENDHEX$$ um GENERICO, conforme o departamento de PRICE todo produto medicamento deve ser um produto refer$$HEX1$$ea00$$ENDHEX$$ncia, com exce$$HEX2$$e700e300$$ENDHEX$$o de insulina 
		If lds.Object.id_lei_generico[ll_Linhas] = 'R' Then
			If  lds.Object.cd_produto	[ll_Linhas]  = al_produto_referencia Then
				If lds.Object.vl_preco_liquido[ll_Linhas] < adc_preco_referencia Then
					lds.Object.vl_preco_liquido[ll_Linhas] = adc_preco_referencia
				End If
			End If
		Else
			This.of_Grava_Log("SKU de maior valor $$HEX1$$e900$$ENDHEX$$ n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ um produto REFER$$HEX1$$ca00$$ENDHEX$$NCIA.", "", ivs_Subcategoria)
		End If
		
		ldc_Expoente 	= 1 / ((ll_Linhas * 2) - 1)
		ldc_Coef 			= (lds.Object.vl_preco_liquido[ll_Linhas] / lds.Object.vl_preco_liquido[1]) ^ ldc_Expoente
		
		If Not This.of_Exponencial_Pontos(ll_Linhas * 2, ldc_Coef, lds.Object.vl_preco_liquido[1], lds.Object.vl_preco_liquido[ll_Linhas] ) Then Return False
				
		ll_Produto_Menor_Preco = lds.Object.cd_produto[1]
		
		ids_exponencial.Object.nr_ponto_origem			[1]	=	1
		ids_exponencial.Object.cd_produto				[1]	=	ll_Produto_Menor_Preco
		ids_exponencial.Object.vl_preco_modelo			[1]	=	lds.Object.vl_preco_liquido			[1]
		ids_exponencial.Object.id_lei_generico			[1]	=	lds.Object.id_lei_generico			[1]
		ids_exponencial.Object.id_fornecedor_parceiro	[1]	=	lds.Object.id_fornecedor_parceiro	[1]
		ids_exponencial.Object.vl_preco_minimo			[1]	=	lds.Object.vl_preco_minimo			[1]
		ids_exponencial.Object.vl_preco_maximo		[1]	=	lds.Object.vl_preco_maximo			[1]
		ids_exponencial.Object.vl_faturamento_anual	[1]	=	lds.Object.vl_fat_liquido_anual		[1]
		
		ids_exponencial.Object.nr_ponto_origem			[ll_Linhas * 2]	=	ll_Linhas * 2
		ids_exponencial.Object.cd_produto				[ll_Linhas * 2] 	=	al_produto_referencia
		ids_exponencial.Object.vl_preco_modelo			[ll_Linhas * 2] 	=	lds.Object.vl_preco_liquido			[ll_Linhas]
		ids_exponencial.Object.id_lei_generico			[ll_Linhas * 2]	=	lds.Object.id_lei_generico			[ll_Linhas]
		ids_exponencial.Object.id_fornecedor_parceiro	[ll_Linhas * 2]	=	lds.Object.id_fornecedor_parceiro	[ll_Linhas]
		ids_exponencial.Object.vl_preco_minimo			[ll_Linhas * 2]	=	lds.Object.vl_preco_minimo			[ll_Linhas]
		ids_exponencial.Object.vl_preco_maximo		[ll_Linhas * 2]	=	lds.Object.vl_preco_maximo			[ll_Linhas]
		ids_exponencial.Object.vl_faturamento_anual	[ll_Linhas * 2]	=	lds.Object.vl_fat_liquido_anual		[ll_Linhas]
				
		// Retira os produtos com menor e maior pre$$HEX1$$e700$$ENDHEX$$o
		lds.of_AppendWhere(	"p.cd_produto Not in (" + 	String(al_produto_referencia) + "," + String(ll_Produto_Menor_Preco)  + ")")
		
		// Ordena os produtos conforme o faturamento DESC
		lds.SetSort("p.vl_fat_liquido_anual desc")
		lds.Sort()
		
		ll_Linhas = lds.Retrieve(il_NR_Precificacao, as_subcategoria, adc_concentracao, as_id_apresentacao, as_un_calculo, al_unidades_embalagem, adc_volume, adc_peso)
		
		If ll_Linhas > 0 Then
												
			For ll_Linha = 1 To ll_Linhas
				
				ll_Produto			= lds.Object.cd_produto						[ll_Linha]
				ldc_Preco_Liquido 	= lds.Object.vl_preco_liquido				[ll_Linha]
				ls_LeiGenerico 		= lds.Object.id_lei_generico					[ll_Linha]
				ls_Forn_Parceiro 	= lds.Object.id_fornecedor_parceiro		[ll_Linha]
				ldc_Preco_Minimo	= lds.Object.vl_preco_minimo				[ll_Linha]
				ldc_Preco_Maximo	= lds.Object.vl_preco_maximo				[ll_Linha]
				ldc_Fat_Liq_Anual 	= lds.Object.vl_fat_liquido_anual			[ll_Linha]
												
				If Not This.of_Exponencial_Aloca_Produto(ll_Produto, ldc_Preco_Liquido, ls_LeiGenerico, ls_Forn_Parceiro, ldc_Preco_Minimo, ldc_Preco_Maximo, ldc_Fat_Liq_Anual) Then Return False
									
			Next
			
			ids_exponencial.SetFilter("")
			ids_exponencial.Filter( )
			
			ids_exponencial.SetSort("nr_ponto asc")
			ids_exponencial.Sort()
			
			//ids_exponencial.SaveAs("c:\exponencial_aloca_sc-"+as_subcategoria+"_ct-"+gf_replace(String(adc_concentracao),",",".",0)+"_"+as_un_calculo+"_qt-"+String(al_unidades_embalagem)+"_p-"+String(adc_peso)+"_vl-"+String(adc_volume)+".xlsx", XLSX!, True)
			
			If Not This.of_exponencial_laboratorio_parceiro() Then Return False
			If Not This.of_atualiza_preco_laboratorio_parceiro() Then Return False
			//ids_exponencial.SaveAs("c:\exponencial_lab_parceiro_sc-"+as_subcategoria+"_ct-"+gf_replace(String(adc_concentracao),",",".",0)+"_"+as_un_calculo+"_qt-"+String(al_unidades_embalagem)+"_p-"+String(adc_peso)+"_vl-"+String(adc_volume)+".xlsx", XLSX!, True)
			
			If Not This.of_exponencial_reducao_espacos_curva( as_rede, 1 )  Then Return False
			//ids_exponencial.SaveAs("c:\exponencial_red_espaco_sc-"+as_subcategoria+"_ct-"+gf_replace(String(adc_concentracao),",",".",0)+"_"+as_un_calculo+"_qt-"+String(al_unidades_embalagem)+"_p-"+String(adc_peso)+"_vl-"+String(adc_volume)+".xlsx", XLSX!, True)
			
			If Not This.of_exponencial_verifica_preco() Then Return False
			If Not This.of_atualiza_preco_exponencial() Then Return False
			//ids_exponencial.SaveAs("c:\exponencial_final_sc-"+as_subcategoria+"_ct-"+gf_replace(String(adc_concentracao),",",".",0)+"_"+as_un_calculo+"_qt-"+String(al_unidades_embalagem)+"_p-"+String(adc_peso)+"_vl-"+String(adc_volume)+".xlsx", XLSX!, True)
	
		ElseIf ll_Linhas < 0 Then
			SqlCa.of_RollBack();
			of_Grava_Log("Erro - Recuperar a lista dos produtos para aloca$$HEX2$$e700e300$$ENDHEX$$o dos pontos da exponencial.", lds.ivo_DbError.ivs_SQLErrText, ivs_Subcategoria)
			Return False
		End If
		
	ElseIf ll_Linhas < 0 Then
		SqlCa.of_RollBack();
		of_Grava_Log("Erro - Recuperar a lista dos produtos para c$$HEX1$$e100$$ENDHEX$$lculo da exponencial.", lds.ivo_DbError.ivs_SQLErrText, ivs_Subcategoria)
		Return False
	ElseIf ll_Linhas = 0 Then
		// Executa o pr$$HEX1$$f300$$ENDHEX$$ximo registro
		This.of_Grava_Log("Alerta - Nenhum produto foi localizado para o c$$HEX1$$e100$$ENDHEX$$lculo da exponencial.", '', ivs_Subcategoria)
		ab_passa_proximo_registro = True
		Return True
	End If

Catch ( runtimeerror  lo_rte )
	of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_exponencial_valor()'. ", lo_rte.GetMessage( ), ivs_Subcategoria)
	SqlCa.of_RollBack();
	Return False			
	
Finally
	If IsValid(lds) Then Destroy lds
end try


Return True
end function

private function boolean of_exponencial_reducao_espacos_curva (string as_rede, long pl_tentativa);/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																										//
//									Redu$$HEX2$$e700e300$$ENDHEX$$o de Espa$$HEX1$$e700$$ENDHEX$$os de Pre$$HEX1$$e700$$ENDHEX$$o ao Longo da Curva Exponencial (1.III.d)											//
//																																										//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	REGRAS:																																							//
//			$$HEX1$$2220$$ENDHEX$$	O maior pre$$HEX1$$e700$$ENDHEX$$o e o menor pre$$HEX1$$e700$$ENDHEX$$o da curva n$$HEX1$$e300$$ENDHEX$$o se alteram.																				//
//			$$HEX1$$2220$$ENDHEX$$	Realizar a troca de posi$$HEX2$$e700f500$$ENDHEX$$es quando houver pelo menos 3 SKUs da combina$$HEX2$$e700e300$$ENDHEX$$o.													//
// 			$$HEX1$$2220$$ENDHEX$$	O c$$HEX1$$e100$$ENDHEX$$lculo da quantidade m$$HEX1$$e100$$ENDHEX$$xima de espa$$HEX1$$e700$$ENDHEX$$os de pre$$HEX1$$e700$$ENDHEX$$o me branco $$HEX1$$e900$$ENDHEX$$ calculado pela seguinte f$$HEX1$$f300$$ENDHEX$$rmula:							//
//				Espa$$HEX1$$e700$$ENDHEX$$os de Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$e100$$ENDHEX$$ximo= Arred.para Baixo (((Quantidade de SKUs * 2))/4)														//
//					Sendo 2 o menor valor a ser considerado																								//
//			$$HEX1$$2220$$ENDHEX$$	Toler$$HEX1$$e100$$ENDHEX$$vel salto de no m$$HEX1$$e100$$ENDHEX$$ximo 3 pontos na curva por SKU.																				//
//			$$HEX1$$2220$$ENDHEX$$	L$$HEX1$$f300$$ENDHEX$$gica PP: primeiro $$HEX1$$e900$$ENDHEX$$ avaliado a possibilidade de aumento de pre$$HEX1$$e700$$ENDHEX$$o.																	//
//			$$HEX1$$2220$$ENDHEX$$	L$$HEX1$$f300$$ENDHEX$$gica DC: primeiro $$HEX1$$e900$$ENDHEX$$ avaliado a possibilidade de redu$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o.																	//
//			$$HEX1$$2220$$ENDHEX$$	Preferencialmente a revis$$HEX1$$e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o deve ser para SKUs com menor faturamento l$$HEX1$$ed00$$ENDHEX$$quido (8) para reduzir o risco. 		//
//				Em casos de que o SKU pr$$HEX1$$f300$$ENDHEX$$ximo ao espa$$HEX1$$e700$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o tenha outro SKU na posi$$HEX2$$e700e300$$ENDHEX$$o ao lado na curva de pre$$HEX1$$e700$$ENDHEX$$o, deve-se 	//
//				avaliar o faturamento de ambos para definir qual SKU movimentar o pre$$HEX1$$e700$$ENDHEX$$o.															//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Long lvl_Max_Espacos
Long lvl_Espacos = 0
Long lvl_Linha
Long lvl_Ponto = 0
Long lvl_Ponto_Ult_SKU = 0


Try
	ids_exponencial.SetFilter("")
	ids_exponencial.Filter()
	
	//Realizar a troca de posi$$HEX2$$e700f500$$ENDHEX$$es quando houver pelo menos 3 SKUs da combina$$HEX2$$e700e300$$ENDHEX$$o (6 pontos na curva)
	If ids_exponencial.RowCount() > 6 Then
		//Espa$$HEX1$$e700$$ENDHEX$$os de Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$e100$$ENDHEX$$ximo = Arred.para Baixo ((Quantidade de SKUs * 2) / 4)
		lvl_Max_Espacos = Truncate(ids_exponencial.RowCount() / 4, 0)
		//Evitar loop infinito
		If pl_tentativa < lvl_Max_Espacos Then
			For lvl_Linha = ids_exponencial.RowCount() To 1 Step -1
				//Se o produto for nulo = espa$$HEX1$$e700$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ em branco
				If IsNull( ids_exponencial.Object.cd_produto[lvl_Linha] ) Then
					//Incrementa vari$$HEX1$$e100$$ENDHEX$$vel de quantidade de espa$$HEX1$$e700$$ENDHEX$$os sucessivos em branco
					lvl_Espacos ++
				Else
					//Se os espa$$HEX1$$e700$$ENDHEX$$os em branco entre SKUs forem superiores ao m$$HEX1$$e100$$ENDHEX$$ximo poss$$HEX1$$ed00$$ENDHEX$$vel, $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio a redu$$HEX2$$e700e300$$ENDHEX$$o
					If lvl_Espacos > lvl_Max_Espacos Then
						lvl_Ponto	= ids_exponencial.Object.nr_ponto [lvl_Linha]
						//Efetua uma movimenta$$HEX2$$e700e300$$ENDHEX$$o
						If Not This.of_Exponencial_Reducao_Espacos_Movimenta((as_rede = "DC"), 1, lvl_Ponto, lvl_Ponto_Ult_SKU, lvl_Max_Espacos, lvl_Espacos) Then Return False
						//ids_exponencial.SaveAs("c:\exponencial_red_espaco_temp_"+String(pl_tentativa)+".xlsx", XLSX!, True)
						//Chama a pr$$HEX1$$f300$$ENDHEX$$pria fun$$HEX2$$e700e300$$ENDHEX$$o para verificar se os espa$$HEX1$$e700$$ENDHEX$$os j$$HEX1$$e100$$ENDHEX$$ foram resolvidos
						If Not This.of_Exponencial_Reducao_Espacos_Curva(as_rede, pl_tentativa + 1) Then Return False
					End If
					
					//Caso o espa$$HEX1$$e700$$ENDHEX$$o esteja preenchido zera o contador de espa$$HEX1$$e700$$ENDHEX$$os em branco e armazena linha do SKU
					lvl_Ponto_Ult_SKU	= ids_exponencial.Object.nr_ponto [lvl_Linha]
					lvl_Espacos 			= 0
				End If
			Next
		End If
	End If
	
Catch (RuntimeError lvo_Erro)	
	This.Of_Grava_log( "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_exponencial_reducao_espacos_curva()", lvo_Erro.GetMessage(), ivs_Subcategoria)
	SQLCa.Of_Rollback()
	Return False
	
Finally
	
End Try

Return True
end function

private function boolean of_exponencial_pontos (long al_pontos, decimal adc_coeficiente, decimal adc_preco_menor, decimal adc_preco_maior);Long ll_Row, ll_Linha

try 
	// Limpa dados antigos
	ids_exponencial.Reset()
	
	For ll_Linha = 1 To al_pontos
		
		ll_Row = ids_exponencial.InsertRow(0)
		
		If ll_Row = -1 Then
			SqlCa.of_RollBack();
			of_Grava_Log("Erro - Inserir a linha na DW 'of_exponencial_pontos'.", ids_exponencial.ivo_dberror.ivs_sqlerrtext, ivs_Subcategoria)
			Return False
		End If
		
		ids_exponencial.Object.nr_ponto			[ll_Row] = ll_Row
		
		If ll_Row = 1 	Then 
			ids_exponencial.Object.vl_preco_ponto		[ll_Row] = adc_preco_menor
			ids_exponencial.Object.vl_preco_ponto_calc	[ll_Row] = adc_preco_menor
		End If
		
		If ll_Row = al_pontos 	Then 
			ids_exponencial.Object.vl_preco_ponto		[ll_Row] = adc_preco_maior
			ids_exponencial.Object.vl_preco_ponto_calc	[ll_Row] = adc_preco_maior
		End If
		
		If ll_Linha > 1 and ll_Linha < al_pontos Then
			//ids_exponencial.Object.vl_preco_ponto[ll_Row] = round( (ids_exponencial.Object.vl_preco_ponto[ll_Row - 1]) * adc_coeficiente, 2)
			ids_exponencial.Object.vl_preco_ponto_calc	[ll_Row] = ids_exponencial.Object.vl_preco_ponto_calc[ll_Row - 1] * adc_coeficiente
			ids_exponencial.Object.vl_preco_ponto		[ll_Row] = round(ids_exponencial.Object.vl_preco_ponto_calc[ll_Row], 2)
		End If
			
	Next
	
catch ( runtimeerror  lo_rte )
	of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_exponencial_pontos()'.", lo_rte.GetMessage( ), ivs_Subcategoria)
	SqlCa.of_RollBack();
	Return False			
end try

Return True
end function

private function boolean of_exponencial_movimenta_sku (long pl_posicao_origem, long pl_posicao_destino);Long lvl_Prod_Aux	
Long lvl_Ponto_Aux

String lvs_Labor_Parc_Aux
String lvs_Lei_Gen_Aux
String lvs_DW_Filter

Decimal lvdc_VL_Modelo_Aux
Decimal lvdc_VL_Preco_Min_Aux	
Decimal lvdc_VL_Preco_Max_Aux	
Decimal lvdc_VL_Preco_Lab_Aux	
Decimal lvdc_VL_Preco_Exp_Aux	
Decimal lvdc_VL_Fat_Liq_Anual_Aux

Try
	If Not (pl_posicao_origem >= 1 and pl_posicao_origem <= ids_exponencial.RowCount()) Then 
		This.Of_Grava_Log( "Posi$$HEX2$$e700e300$$ENDHEX$$o origem "+String(pl_posicao_origem)+" inv$$HEX1$$e100$$ENDHEX$$lida para efetuar a troca de posi$$HEX2$$e700f500$$ENDHEX$$es do datasource da exponencial na fun$$HEX2$$e700e300$$ENDHEX$$o of_exponencial_movimenta_sku().", "", ivs_Subcategoria)
		Return False
	End If
	
	If Not (pl_posicao_destino >= 1 and pl_posicao_destino <= ids_exponencial.RowCount()) Then 
		This.Of_Grava_Log( "Posi$$HEX2$$e700e300$$ENDHEX$$o destino "+String(pl_posicao_destino)+" inv$$HEX1$$e100$$ENDHEX$$lida para efetuar a troca de posi$$HEX2$$e700f500$$ENDHEX$$es do datasource da exponencial na fun$$HEX2$$e700e300$$ENDHEX$$o of_exponencial_movimenta_sku().", "", ivs_Subcategoria)
		Return False
	End If
	
	//Armazena os valores a serem trocados (DESTINO --> AUX)
	lvl_Prod_Aux					= ids_exponencial.Object.cd_produto					[pl_posicao_destino]
	lvs_Lei_Gen_Aux				= ids_exponencial.Object.id_lei_generico			[pl_posicao_destino]  
	lvl_Ponto_Aux					= ids_exponencial.Object.nr_ponto_origem			[pl_posicao_destino]  
	lvs_Labor_Parc_Aux			= ids_exponencial.Object.id_fornecedor_parceiro	[pl_posicao_destino]
	lvdc_VL_Preco_Min_Aux		= ids_exponencial.Object.vl_preco_minimo			[pl_posicao_destino] 
	lvdc_VL_Preco_Max_Aux		= ids_exponencial.Object.vl_preco_maximo			[pl_posicao_destino] 
	lvdc_VL_Fat_Liq_Anual_Aux	= ids_exponencial.Object.vl_faturamento_anual	[pl_posicao_destino] 
	lvdc_VL_Modelo_Aux			= ids_exponencial.Object.vl_preco_modelo			[pl_posicao_destino] 
	lvdc_VL_Preco_Lab_Aux		= ids_exponencial.Object.vl_preco_lab_parc		[pl_posicao_destino] 
	lvdc_VL_Preco_Exp_Aux		= ids_exponencial.Object.vl_preco_exponencial	[pl_posicao_destino] 
	
	//Efetua a primeira troca (ORIGEM --> DESTINO)
	ids_exponencial.Object.cd_produto				[pl_posicao_destino] = ids_exponencial.Object.cd_produto					[pl_posicao_origem]
	ids_exponencial.Object.id_lei_generico			[pl_posicao_destino] = ids_exponencial.Object.id_lei_generico				[pl_posicao_origem]
	ids_exponencial.Object.nr_ponto_origem			[pl_posicao_destino] = ids_exponencial.Object.nr_ponto_origem			[pl_posicao_origem]
	ids_exponencial.Object.id_fornecedor_parceiro	[pl_posicao_destino] = ids_exponencial.Object.id_fornecedor_parceiro	[pl_posicao_origem]
	ids_exponencial.Object.vl_preco_minimo			[pl_posicao_destino] = ids_exponencial.Object.vl_preco_minimo			[pl_posicao_origem]
	ids_exponencial.Object.vl_preco_maximo		[pl_posicao_destino] = ids_exponencial.Object.vl_preco_maximo			[pl_posicao_origem]
	ids_exponencial.Object.vl_faturamento_anual	[pl_posicao_destino] = ids_exponencial.Object.vl_faturamento_anual		[pl_posicao_origem]
	ids_exponencial.Object.vl_preco_modelo			[pl_posicao_destino] = ids_exponencial.Object.vl_preco_modelo			[pl_posicao_origem]
	ids_exponencial.Object.vl_preco_lab_parc		[pl_posicao_destino] = ids_exponencial.Object.vl_preco_lab_parc			[pl_posicao_origem]
	ids_exponencial.Object.vl_preco_exponencial	[pl_posicao_destino] = ids_exponencial.Object.vl_preco_exponencial		[pl_posicao_origem]
	
	//Efetua a segunda troca (AUX --> ORIGEM)
	ids_exponencial.Object.cd_produto				[pl_posicao_origem] = lvl_Prod_Aux
	ids_exponencial.Object.id_lei_generico			[pl_posicao_origem] = lvs_Lei_Gen_Aux
	ids_exponencial.Object.nr_ponto_origem			[pl_posicao_origem] = lvl_Ponto_Aux
	ids_exponencial.Object.id_fornecedor_parceiro	[pl_posicao_origem] = lvs_Labor_Parc_Aux
	ids_exponencial.Object.vl_preco_minimo			[pl_posicao_origem] = lvdc_VL_Preco_Min_Aux
	ids_exponencial.Object.vl_preco_maximo		[pl_posicao_origem] = lvdc_VL_Preco_Max_Aux
	ids_exponencial.Object.vl_faturamento_anual	[pl_posicao_origem] = lvdc_VL_Fat_Liq_Anual_Aux
	ids_exponencial.Object.vl_preco_modelo			[pl_posicao_origem] = lvdc_VL_Modelo_Aux
	ids_exponencial.Object.vl_preco_lab_parc		[pl_posicao_origem] = lvdc_VL_Preco_Lab_Aux
	ids_exponencial.Object.vl_preco_exponencial	[pl_posicao_origem] = lvdc_VL_Preco_Exp_Aux
	
Catch (RuntimeError lvo_Erro)
	This.Of_grava_log( "Erro ao efetuar a troca de posi$$HEX2$$e700f500$$ENDHEX$$es do datasource da exponencial na fun$$HEX2$$e700e300$$ENDHEX$$o of_exponencial_movimenta_sku().", lvo_Erro.GetMessage(), ivs_Subcategoria)
	SQLCa.Of_RollBack()
	Return False
	
End Try

Return True
end function

private function boolean of_exponencial_laboratorio_parceiro ();///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																						//
//								Revis$$HEX1$$e300$$ENDHEX$$o do Pre$$HEX1$$e700$$ENDHEX$$o de GEN$$HEX1$$c900$$ENDHEX$$RICOS para laborat$$HEX1$$f300$$ENDHEX$$rios parceiros (1.III.c)									//
//																																						//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	REGRAS:																																			//
// 				$$HEX1$$2220$$ENDHEX$$	Movimenta$$HEX2$$e700e300$$ENDHEX$$o de at$$HEX1$$e900$$ENDHEX$$ 2 pontos na curva de pre$$HEX1$$e700$$ENDHEX$$o.																		//
// 				$$HEX1$$2220$$ENDHEX$$	As posi$$HEX2$$e700f500$$ENDHEX$$es dos SKUs devem ser trocadas, ou seja, o SKU do laborat$$HEX1$$f300$$ENDHEX$$rio parceiro se move para a 		//
//					posi$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o do SKU do laborat$$HEX1$$f300$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o parceiro e este deve ser alocado na posi$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o 		//
//					original do laborat$$HEX1$$f300$$ENDHEX$$rio parceiro.																							//
// 				$$HEX1$$2220$$ENDHEX$$	Antes de ser feita a troca, deve ser avaliado o Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo do laborat$$HEX1$$f300$$ENDHEX$$rio parceiro. 						//
//					Caso o novo pre$$HEX1$$e700$$ENDHEX$$o esteja abaixo do Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo a troca de pre$$HEX1$$e700$$ENDHEX$$os n$$HEX1$$e300$$ENDHEX$$o deve feita.							//
// 				$$HEX1$$2220$$ENDHEX$$	Caso o menor pre$$HEX1$$e700$$ENDHEX$$o de gen$$HEX1$$e900$$ENDHEX$$rico na curva de pre$$HEX1$$e700$$ENDHEX$$o exponencial j$$HEX1$$e100$$ENDHEX$$ ser de um laborat$$HEX1$$f300$$ENDHEX$$rio parceiro, 		//
//					n$$HEX1$$e300$$ENDHEX$$o deve ser feito a troca.																									//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Long lvl_Linha
Long lvl_Linhas
Long lvl_Ponto
Long lvl_Ponto_NP

String lvs_Labor_Parc

Decimal lvdc_VL_Preco_Min
Decimal lvdc_VL_Preco_Max
Decimal lvdc_VL_Ponto_NP
Decimal lvdc_VL_Ponto_Parc

Try
	//Ordenar conforme n$$HEX1$$ba00$$ENDHEX$$ dos pontos
	ids_exponencial.SetSort("nr_ponto asc")
	ids_exponencial.Sort()
	If ids_exponencial.Sort() < 0 Then
		of_Grava_Log("Erro - Ordena$$HEX2$$e700e300$$ENDHEX$$o de produtos. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_exponencial_laboratorio_parceiro().", ids_exponencial.ivo_DbError.ivs_SQLErrText, ivs_Subcategoria)
		Return False
	End If
	
	//Filtra somente produtos gen$$HEX1$$e900$$ENDHEX$$ricos
	ids_exponencial.SetFilter("id_lei_generico = 'G'")
	If ids_exponencial.Filter() < 0 Then
		of_Grava_Log("Erro - Filtro de produtos gen$$HEX1$$e900$$ENDHEX$$ricos. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_exponencial_laboratorio_parceiro().", ids_exponencial.ivo_DbError.ivs_SQLErrText, ivs_Subcategoria)
		Return False
	End If
	
	lvl_Linhas = ids_exponencial.RowCount()
	//Efetua a troca entre produtos GEN$$HEX1$$c900$$ENDHEX$$RICOS, se houver somente um n$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ como efetuar a troca
	If lvl_Linhas > 1 Then
		//Caso o menor pre$$HEX1$$e700$$ENDHEX$$o de gen$$HEX1$$e900$$ENDHEX$$rico na curva de pre$$HEX1$$e700$$ENDHEX$$o exponencial j$$HEX1$$e100$$ENDHEX$$ ser de um laborat$$HEX1$$f300$$ENDHEX$$rio parceiro n$$HEX1$$e300$$ENDHEX$$o deve ser efetuado troca
		If ids_exponencial.Object.id_fornecedor_parceiro [1] = "S" Then Return True
		
		//Armazena os valores do SKU a ser substituido (laborat$$HEX1$$f300$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o parceiro)
		lvl_Ponto_NP			= ids_exponencial.Object.nr_ponto			[1]
		lvdc_VL_Ponto_NP		= ids_exponencial.Object.vl_preco_ponto	[1]
		lvdc_VL_Preco_Max	= ids_exponencial.Object.vl_preco_maximo	[1]
		
		//Inicia na posi$$HEX2$$e700e300$$ENDHEX$$o 2, pois a posi$$HEX2$$e700e300$$ENDHEX$$o 1 $$HEX1$$e900$$ENDHEX$$ do laborat$$HEX1$$f300$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o parceiro, e termina na posi$$HEX2$$e700e300$$ENDHEX$$o 3 pois somente pode ser movimentado 2 pontos
		If lvl_Linhas > 3 Then lvl_Linhas = 3
		For lvl_Linha = 2 To lvl_Linhas 
			If lvl_Linha > ids_exponencial.RowCount() Then Exit
			//Considera o ponto de origem para que n$$HEX1$$e300$$ENDHEX$$o se movimente mais que 2 posi$$HEX2$$e700f500$$ENDHEX$$es
			lvl_Ponto		 			= ids_exponencial.Object.nr_ponto_origem			[lvl_Linha]
			lvs_Labor_Parc 		= ids_exponencial.Object.id_fornecedor_parceiro	[lvl_Linha]
			lvdc_VL_Preco_Min	= ids_exponencial.Object.vl_preco_minimo			[lvl_Linha]
			lvdc_VL_Ponto_Parc	= ids_exponencial.Object.vl_preco_ponto			[lvl_Linha]
			
			//Somente tenta efetuar a troca por laborat$$HEX1$$f300$$ENDHEX$$rio parceiro
			If lvs_Labor_Parc = "S" Then
				//Movimenta$$HEX2$$e700e300$$ENDHEX$$o de at$$HEX1$$e900$$ENDHEX$$ 2 pontos na curva de pre$$HEX1$$e700$$ENDHEX$$o
				If (lvl_Ponto_NP + 2) >= lvl_Ponto Then
					// Se existe pre$$HEX1$$e700$$ENDHEX$$o m$$HEX1$$ed00$$ENDHEX$$nimo (fornecedor) o pre$$HEX1$$e700$$ENDHEX$$o do ponto de destino (n$$HEX1$$e300$$ENDHEX$$o parceiro) ter$$HEX1$$e100$$ENDHEX$$ de ser maior que o m$$HEX1$$ed00$$ENDHEX$$nimo.
					// Se existe pre$$HEX1$$e700$$ENDHEX$$o m$$HEX1$$e100$$ENDHEX$$ximo (PMC ou Bruto) o pre$$HEX1$$e700$$ENDHEX$$o do ponto de origem (parceiro) ter$$HEX1$$e100$$ENDHEX$$ de ser menor que o m$$HEX1$$e100$$ENDHEX$$ximo.
					If (IsNull(lvdc_VL_Preco_Min) or (lvdc_VL_Preco_Min = 0.00) or (lvdc_VL_Ponto_NP > lvdc_VL_Preco_Min)) and &
						(IsNull(lvdc_VL_Preco_Max) or (lvdc_VL_Preco_Max = 0.00) or (lvdc_VL_Preco_Max >= lvdc_VL_Ponto_Parc)) Then
						Return This.of_Exponencial_Movimenta_SKU(lvl_Linha, 1)
					End If
				End If
			End If
		Next 
	End If
	
Catch ( RuntimeError  lo_rte )
	of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_exponencial_laboratorio_parceiro().", lo_rte.GetMessage( ), ivs_Subcategoria)
	SqlCa.of_RollBack();
	Return False	
	
Finally
	
	Try
		//Remove filtro dos produtos gen$$HEX1$$e900$$ENDHEX$$ricos
		ids_exponencial.SetFilter("not isNull(cd_produto)")
		If ids_exponencial.Filter() < 0 Then
			of_Grava_Log("Erro - Remo$$HEX2$$e700e300$$ENDHEX$$o do filtro de produtos gen$$HEX1$$e900$$ENDHEX$$ricos. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_exponencial_laboratorio_parceiro().", ids_exponencial.ivo_DbError.ivs_SQLErrText, ivs_Subcategoria)
			Return False
		End If
		//Transporta os valores para o campo vl_preco_lab_parc para gravar posteriormente no BD
		For lvl_Linha = 1 To ids_exponencial.RowCount() 
			ids_exponencial.Object.vl_preco_lab_parc [lvl_Linha] = ids_exponencial.Object.vl_preco_ponto [lvl_Linha]
		Next
		
	Catch ( RuntimeError  lo_rte2 )
		of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_exponencial_laboratorio_parceiro().", lo_rte2.GetMessage( ), ivs_Subcategoria)
		SqlCa.of_RollBack();
		Return False	
	
	Finally
		//Remove filtro dos produtos gen$$HEX1$$e900$$ENDHEX$$ricos
		ids_exponencial.SetFilter("")
		If ids_exponencial.Filter() < 0 Then
			of_Grava_Log("Erro - Remo$$HEX2$$e700e300$$ENDHEX$$o do filtro de produtos gen$$HEX1$$e900$$ENDHEX$$ricos. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_exponencial_laboratorio_parceiro().", ids_exponencial.ivo_DbError.ivs_SQLErrText, ivs_Subcategoria)
			Return False
		End If
	End Try
End Try

Return True
end function

private function boolean of_exponencial_aloca_produto (long al_produto, decimal adc_valor_modelo, string as_lei_generico, string as_fornecedor_parceiro, decimal adc_preco_minimo, decimal adc_preco_maximo, decimal adc_faturamento_anual);Long ll_Linhas, ll_Linha, ll_Find, ll_NR_Ponto

Decimal ldc_Diferenca, ldc_Preco_Ponto

try 
	ids_exponencial.SetFilter('isnull(vl_preco_modelo) or (vl_preco_modelo = 0.00)')
	If ids_exponencial.Filter() = -1 Then
		SqlCa.of_RollBack();
		of_Grava_Log("Erro - Filtrar os produtos da DW 'of_exponencial_aloca_produto'.",ids_exponencial.ivo_dberror.ivs_sqlerrtext, ivs_Subcategoria)
		Return False
	End If
	
	ids_exponencial.SetSort("nr_ponto asc")
	ids_exponencial.Sort()
	
	ll_Linhas = ids_exponencial.RowCount()
	
	ll_Find = ids_exponencial.Find("vl_preco_ponto >= " + gf_Replace(String(adc_valor_modelo), ',', '.', 0), 1, ll_Linhas)
	
	If ll_Find = 0 Then
		ll_Find = ids_exponencial.Find("vl_preco_ponto < " + gf_Replace(String(adc_valor_modelo), ',', '.', 0),ll_Linhas, 1 )
	ElseIf ll_Find < 0 Then
		SqlCa.of_RollBack();
		of_Grava_Log("Erro - Find da DW 'of_exponencial_aloca_produto'.", ids_exponencial.ivo_DbError.ivs_SQLErrText, ivs_Subcategoria)
		Return False
	End If
	
	ldc_Diferenca = 99999
	
	If ll_Find > 2 Then
		If abs(ids_exponencial.Object.vl_preco_ponto[ll_Find - 1] - adc_valor_modelo) < ldc_Diferenca Then
			ldc_Diferenca	= 	abs(ids_exponencial.Object.vl_preco_ponto[ll_Find - 1] - adc_valor_modelo)
			ll_NR_Ponto		=  ll_Find - 1
		End If
	End If
	
	If abs(ids_exponencial.Object.vl_preco_ponto[ll_Find] - adc_valor_modelo) < ldc_Diferenca Then
		ldc_Diferenca	= 	abs(ids_exponencial.Object.vl_preco_ponto[ll_Find] - adc_valor_modelo)
		ll_NR_Ponto		=  ll_Find
	End If
	
	If ll_Find < ll_Linhas Then
		If abs(ids_exponencial.Object.vl_preco_ponto[ll_Find + 1] - adc_valor_modelo) < ldc_Diferenca Then
			ldc_Diferenca	= 	abs(ids_exponencial.Object.vl_preco_ponto[ll_Find + 1] - adc_valor_modelo)
			ll_NR_Ponto		=  ll_Find + 1
		End If
	End If
	
	ldc_Preco_Ponto = ids_exponencial.Object.vl_preco_ponto[ll_NR_Ponto]
	ids_exponencial.Object.nr_ponto_origem					[ll_NR_Ponto] = ids_exponencial.Object.nr_ponto	[ll_NR_Ponto]
	ids_exponencial.Object.cd_produto						[ll_NR_Ponto] = al_produto
	ids_exponencial.Object.vl_preco_modelo					[ll_NR_Ponto] = adc_valor_modelo
	ids_exponencial.Object.id_lei_generico					[ll_NR_Ponto] = as_lei_generico
	ids_exponencial.Object.id_fornecedor_parceiro			[ll_NR_Ponto] = as_fornecedor_parceiro
	ids_exponencial.Object.vl_preco_minimo					[ll_NR_Ponto] = adc_preco_minimo
	ids_exponencial.Object.vl_preco_maximo				[ll_NR_Ponto] = adc_preco_maximo
	ids_exponencial.Object.vl_faturamento_anual			[ll_NR_Ponto] = adc_faturamento_anual
	
	update precificacao_prd
	set vl_preco_alocacao = :ldc_Preco_Ponto
	Where cd_produto = :al_produto
		And nr_precificacao = :il_NR_Precificacao
	Using SQLCa;
	
	If SqlCa.SqlCode = -1 Then
		This.of_Grava_Log("Erro ao atualizar o pre$$HEX1$$e700$$ENDHEX$$o aloca$$HEX2$$e700e300$$ENDHEX$$o, na fun$$HEX2$$e700e300$$ENDHEX$$o: of_exponencial_aloca_produto().", SqlCa.SqlErrText, ivs_Subcategoria)
		SqlCa.of_RollBack()
		Return False
	End If
	
Catch ( runtimeerror  lo_rte )
	of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_exponencial_aloca_produto().", lo_rte.GetMessage( ), ivs_Subcategoria)
	SqlCa.of_RollBack();
	Return False		
	
Finally
	ids_exponencial.SetFilter('')
	If ids_exponencial.Filter() = -1 Then
		of_Grava_Log("Erro - Remover filtro os produtos da DW 'of_exponencial_aloca_produto'.", ids_exponencial.ivo_DbError.ivs_SQLErrText, ivs_Subcategoria)
		SqlCa.of_RollBack();
		Return False
	End If
end try

Return True
end function

private function boolean of_executa_precificacao (long al_precificacao, long al_tipo_precificacao, string as_uf, string as_rede, string as_subcategoria);Long ll_Linhas, ll_Linha

dc_uo_ds_base lds

try
	//Open(w_Aguarde_1)
	//w_Aguarde_1.y = 1700
	
	lds = Create dc_uo_ds_base
				
	If Not lds.of_ChangeDataObject("ds_ge450_tipo_precificacao", False) Then 
		This.of_Grava_Log("Erro na troca da dw [ds_ge450_tipo_precificacao].", '')
		Return False
	End If
	
	If Not IsNull(al_tipo_precificacao) Then
		lds.of_AppendWhere("cd_tipo_precificacao = " + String(al_tipo_precificacao) )
	End If
	
	ll_Linhas = lds.Retrieve()
	
	If ll_Linhas > 0 Then
		
		For ll_Linha  = 1 to ll_Linhas
			il_Tipo_Precificacao 			= lds.Object.cd_tipo_precificacao[ll_Linha]
			is_Desc_Tipo_Precificacao 	= lds.Object.de_tipo_precificacao[ll_Linha]
			
			w_ge450_aguarde.st_calculo.Text = "C$$HEX1$$e100$$ENDHEX$$lculo: "  + is_Desc_Tipo_Precificacao
			
			If Not This.of_grava_produto(as_uf, as_rede, as_subcategoria ) Then Return False
			
			If Not This.of_atualiza_preco_minimo() Then Return False
			
			Choose Case il_Tipo_Precificacao
				Case 1 // Medicamento RX
					If  Not This.of_Calcula_Preco_Med_RX(as_rede) Then Return False
					
				Case 2 // N$$HEX1$$e300$$ENDHEX$$o Medicamento
					If  Not This.of_Calcula_Preco_Nao_Med(as_rede) Then Return False
					
				Case 3 // Medicamento MIP
					If  Not This.of_Calcula_Preco_Med_MIP(as_rede) Then Return False
					
				Case Else
					of_Grava_Log("Tipo de precifica$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o previsto.", '')
					Return False
					
			End Choose
					
		Next
			
	ElseIf ll_Linhas < 0 Then
		SqlCa.of_RollBack();
		of_Grava_Log("Erro ao recuperar os tipos de precifica$$HEX2$$e700e300$$ENDHEX$$o.", '')
		Return False
	End If
	
Catch ( RuntimeError  lvo_Erro )
	of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_executa_precificacao().", lvo_Erro.GetMessage( ))
	SqlCa.of_RollBack();
	Return False		
	
Finally
	If IsValid(lds) Then Destroy lds
	//If IsValid(w_Aguarde_1) Then Close(w_Aguarde_1)
End try

Return True
end function

private function boolean of_calcula_preco_med_rx (string as_rede);Boolean lb_passa_proximo_registro

Long ll_Linha, ll_Linhas, ll_Prod_LeiGenerico_Ref, ll_unidades_embalagem

String ls_CD_SubCategoria, ls_DE_SubCategoria, ls_ID_Apresentacao, ls_DE_Apresentacao, ls_UN_Calc_Preco

Decimal ldc_Qt_Concentracao, ldc_Preco_PRD_LeiGenerico_Ref, ldc_Volume, ldc_Peso

try
	
	w_ge450_aguarde.uo_progress.of_setstart()
	w_ge450_aguarde.st_processo.Text = "C$$HEX1$$e100$$ENDHEX$$lculo Pre$$HEX1$$e700$$ENDHEX$$o"
		
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge450_subcategoria_med_ref", False) Then 
		This.of_Grava_Log("Erro na troca da dw [ds_ge450_subcategoria_med_ref].", lds.ivo_dberror.ivs_sqlerrtext)
		Return False
	End If
			
	ll_Linhas = lds.Retrieve(il_NR_Precificacao)
	
	// Lista as subcategorias conforme SUBCATEGORIA / CONCENTRACAO / TIPO APRESENTACAO (CP NORMAL OU REVESTIVO)/TIPO UNIDADE DE MEDIDA (QUANTIDADE/PESO/VOLUME)
	If ll_Linhas > 0 Then
		
		w_ge450_aguarde.uo_progress.of_setmax(ll_Linhas)
								
		For ll_Linha = 1 To ll_Linhas
			
			ls_CD_SubCategoria  	= lds.Object.cd_subcategoria				[ll_Linha]
			ls_DE_SubCategoria  	= lds.Object.de_subcategoria				[ll_Linha]
			ldc_Qt_Concentracao 	= lds.Object.qt_concentracao				[ll_Linha]
			ls_ID_Apresentacao  	= lds.Object.id_apresentacao				[ll_Linha]
			ls_DE_Apresentacao  	= lds.Object.de_apresentacao				[ll_Linha]
			ls_UN_Calc_Preco		= lds.Object.id_tipo_un_calc_preco		[ll_Linha] 
			
			ivs_Subcategoria = ls_CD_SubCategoria
			ivs_Chave =   "<b>SubCategoria:</b> "+ls_DE_SubCategoria+" ("+ls_CD_SubCategoria+")<br />"
			ivs_Chave += "<b>Concentra$$HEX2$$e700e300$$ENDHEX$$o:</b> "+String(ldc_Qt_Concentracao)+"<br />"
			ivs_Chave += "<b>Apresenta$$HEX2$$e700e300$$ENDHEX$$o:</b> "+ ls_DE_Apresentacao+" ("+ls_ID_Apresentacao+")<br />"
			ivs_Chave += "<b>Tipo Unidade de C$$HEX1$$e100$$ENDHEX$$lculo:</b> "+ ls_UN_Calc_Preco + " - "+ IIF(ls_UN_Calc_Preco="Q","QUANTIDADE",IIF(ls_UN_Calc_Preco="V","VOLUME","PESO"))
			
			If Not This.of_Posicionamento_Preco_Med_Ref(	ls_CD_SubCategoria, ldc_Qt_Concentracao, ls_ID_Apresentacao, ls_UN_Calc_Preco, &
																			ref ll_Prod_LeiGenerico_Ref, ref ldc_Preco_PRD_LeiGenerico_Ref,  ref ll_unidades_embalagem, &
																			ref ldc_Volume, ref ldc_Peso, ref lb_passa_proximo_registro) Then Return False
				
			// Neste caso os pre$$HEX1$$e700$$ENDHEX$$os SUBCATEGORIA/CONCENTRA$$HEX2$$c700c300$$ENDHEX$$O/TIPO DE APRESENTA$$HEX2$$c700c300$$ENDHEX$$O/UNIDADE DE MEDIDA n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o atualizados, pois o processo n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ continuado
			If lb_passa_proximo_registro  Then 
				w_ge450_aguarde.uo_progress.of_setprogress(ll_Linha)
				Continue
			End If
				
			If Not This.of_Exponencial_Valor(	as_rede, ls_CD_SubCategoria, ldc_Qt_Concentracao, ls_ID_Apresentacao, ls_UN_Calc_Preco, &
														ll_unidades_embalagem, ldc_Volume, ldc_Peso, ll_Prod_LeiGenerico_Ref,  ldc_Preco_PRD_LeiGenerico_Ref, &
														ref lb_passa_proximo_registro) Then Return False
														
			// Neste caso os pre$$HEX1$$e700$$ENDHEX$$os SUBCATEGORIA/CONCENTRA$$HEX2$$c700c300$$ENDHEX$$O/TIPO DE APRESENTA$$HEX2$$c700c300$$ENDHEX$$O/UNIDADE DE MEDIDA n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o atualizados, pois o processo n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ continuado
			If lb_passa_proximo_registro  Then 
				w_ge450_aguarde.uo_progress.of_setprogress(ll_Linha)
				Continue
			End If
				
			If Not This.of_Preco_Apresentacao_Medicamento(ls_CD_SubCategoria, ldc_Qt_Concentracao, ls_ID_Apresentacao, ls_UN_Calc_Preco) Then Return False
												
			w_ge450_aguarde.uo_progress.of_setprogress(ll_Linha)
			
		Next
		
		If Not This.Of_Preco_Psicologico() Then Return False
		
	ElseIf ll_Linhas < 0 Then
		SqlCa.of_RollBack();
		of_Grava_Log("Erro - Recuperar a lista SUBCATEGORIA/CONCENTRACAO/TIPO APRESENT/TIPO UNIDADE DE MEDIDA para o posicionamento de pre$$HEX1$$e700$$ENDHEX$$o.", '')
		Return False
	End If
Catch (RuntimeError lvo_Erro)	
	This.Of_Grava_log( "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_calcula_preco_med_rx().", lvo_Erro.GetMessage())
	Return False
	
finally
	ivs_Chave = ""
	SetNull(ivs_Subcategoria)
	If IsValid(lds) Then Destroy lds
end try

Return True
end function

private function boolean of_calcula_preco_med_mip (string as_rede);Boolean lb_passa_proximo_registro

Long ll_Linha, ll_Linhas, ll_Prod_LeiGenerico_Ref, ll_unidades_embalagem

String ls_CD_SubCategoria, ls_DE_SubCategoria, ls_ID_Apresentacao, ls_DE_Apresentacao, ls_UN_Calc_Preco

Decimal ldc_Qt_Concentracao, ldc_Preco_PRD_LeiGenerico_Ref, ldc_Volume, ldc_Peso

Try
	w_ge450_aguarde.uo_progress.of_setstart()
	w_ge450_aguarde.st_processo.Text = "C$$HEX1$$e100$$ENDHEX$$lculo Pre$$HEX1$$e700$$ENDHEX$$o"
		
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge450_subcategoria_med_ref", False) Then 
		This.of_Grava_Log("Erro na troca da dw [ds_ge450_subcategoria_med_ref].", lds.ivo_dberror.ivs_sqlerrtext)
		Return False
	End If
			
	ll_Linhas = lds.Retrieve(il_NR_Precificacao)
	
	// Lista as subcategorias conforme SUBCATEGORIA / CONCENTRACAO / TIPO APRESENTACAO (CP NORMAL OU REVESTIVO)/TIPO UNIDADE DE MEDIDA (QUANTIDADE/PESO/VOLUME)
	If ll_Linhas > 0 Then
		
		w_ge450_aguarde.uo_progress.of_setmax(ll_Linhas)
								
		For ll_Linha = 1 To ll_Linhas
			
			ls_CD_SubCategoria  	= lds.Object.cd_subcategoria				[ll_Linha]
			ls_DE_SubCategoria  	= lds.Object.de_subcategoria				[ll_Linha]
			ldc_Qt_Concentracao 	= lds.Object.qt_concentracao				[ll_Linha]
			ls_ID_Apresentacao  	= lds.Object.id_apresentacao				[ll_Linha]
			ls_DE_Apresentacao  	= lds.Object.de_apresentacao				[ll_Linha]
			ls_UN_Calc_Preco		= lds.Object.id_tipo_un_calc_preco		[ll_Linha] 
			
			ivs_Subcategoria = ls_CD_SubCategoria
			ivs_Chave =   "<b>SubCategoria:</b> "+ls_DE_SubCategoria+" ("+ls_CD_SubCategoria+")<br />"
			ivs_Chave += "<b>Concentra$$HEX2$$e700e300$$ENDHEX$$o:</b> "+String(ldc_Qt_Concentracao)+"<br />"
			ivs_Chave += "<b>Apresenta$$HEX2$$e700e300$$ENDHEX$$o:</b> "+ ls_DE_Apresentacao+" ("+ls_ID_Apresentacao+")<br />"
			ivs_Chave += "<b>Tipo Unidade de C$$HEX1$$e100$$ENDHEX$$lculo:</b> "+ ls_UN_Calc_Preco + " - "+ IIF(ls_UN_Calc_Preco="Q","QUANTIDADE",IIF(ls_UN_Calc_Preco="V","VOLUME","PESO"))
			
			//Localiza para esta SUBCATEGORIA/CONCENTRA$$HEX2$$c700c300$$ENDHEX$$O/TIPO DE APRESENTA$$HEX2$$c700c300$$ENDHEX$$O/UNIDADE DE MEDIDA o maior valor da unidade para a exponencial
			If Not This.of_Posicionamento_Preco_Med_Ref(	ls_CD_SubCategoria, ldc_Qt_Concentracao, ls_ID_Apresentacao, ls_UN_Calc_Preco, &
																			ref ll_Prod_LeiGenerico_Ref, ref ldc_Preco_PRD_LeiGenerico_Ref,  ref ll_unidades_embalagem, &
																			ref ldc_Volume, ref ldc_Peso, ref lb_passa_proximo_registro) Then Return False
				
			// Neste caso os pre$$HEX1$$e700$$ENDHEX$$os SUBCATEGORIA/CONCENTRA$$HEX2$$c700c300$$ENDHEX$$O/TIPO DE APRESENTA$$HEX2$$c700c300$$ENDHEX$$O/UNIDADE DE MEDIDA n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o atualizados, pois o processo n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ continuado
			If lb_passa_proximo_registro  Then 
				w_ge450_aguarde.uo_progress.of_setprogress(ll_Linha)
				Continue
			End If
			
			If Not This.of_Exponencial_Valor(	as_rede, ls_CD_SubCategoria, ldc_Qt_Concentracao, ls_ID_Apresentacao, ls_UN_Calc_Preco, &
														ll_unidades_embalagem, ldc_Volume, ldc_Peso, ll_Prod_LeiGenerico_Ref,  ldc_Preco_PRD_LeiGenerico_Ref, &
														ref lb_passa_proximo_registro) Then Return False
														
			// Neste caso os pre$$HEX1$$e700$$ENDHEX$$os SUBCATEGORIA/CONCENTRA$$HEX2$$c700c300$$ENDHEX$$O/TIPO DE APRESENTA$$HEX2$$c700c300$$ENDHEX$$O/UNIDADE DE MEDIDA n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o atualizados, pois o processo n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ continuado
			If lb_passa_proximo_registro  Then 
				w_ge450_aguarde.uo_progress.of_setprogress(ll_Linha)
				Continue
			End If
				
			If Not This.of_Preco_Apresentacao_Medicamento(ls_CD_SubCategoria, ldc_Qt_Concentracao, ls_ID_Apresentacao, ls_UN_Calc_Preco) Then Return False
												
			w_ge450_aguarde.uo_progress.of_SetProgress(ll_Linha)
			
		Next
		
		//Limpa chave de grava$$HEX2$$e700e300$$ENDHEX$$o de log
		ivs_Chave = ""
		
		//Unifica os pre$$HEX1$$e700$$ENDHEX$$os dos produtos com o mesmo grupo PRICING
		//		Apesar de na documenta$$HEX2$$e700e300$$ENDHEX$$o da QUANTIZ n$$HEX1$$e300$$ENDHEX$$o conter a unifica$$HEX2$$e700e300$$ENDHEX$$o para o c$$HEX1$$e100$$ENDHEX$$lculo do tipo MEDICAMENTO MIP
		// 		o setor de pricing solicitou que fosse considerado, em virtude por exemplo das pastilhas BENALET.
		If Not This.Of_Preco_Unificado_Grupo_Pricing() Then Return False
		//Aplica pre$$HEX1$$e700$$ENDHEX$$o psicol$$HEX1$$f300$$ENDHEX$$gico
		If Not This.Of_Preco_Psicologico() Then Return False
		//O produto indexado deve estar exatamente proporcional (desde que respeitado m$$HEX1$$ed00$$ENDHEX$$nimo), por isso deve ser feito ap$$HEX1$$f300$$ENDHEX$$s a aplica$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o psicol$$HEX1$$f300$$ENDHEX$$gico
		If Not This.Of_Preco_Produto_Indexado() Then Return False
		
	ElseIf ll_Linhas < 0 Then
		SqlCa.of_RollBack();
		of_Grava_Log("Erro - Recuperar a lista SUBCATEGORIA/CONCENTRACAO/TIPO APRESENT/TIPO UNIDADE DE MEDIDA para o posicionamento de pre$$HEX1$$e700$$ENDHEX$$o.", '')
		Return False
	End If
Catch (RuntimeError lvo_Erro)	
	This.Of_Grava_log( "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_calcula_preco_med_mip().", lvo_Erro.GetMessage())
	Return False
	
Finally
	SetNull(ivs_Subcategoria)
	ivs_Chave = ""
	If IsValid(lds) Then Destroy lds
end try

Return True
end function

private function boolean of_atualiza_preco_minimo_pbm (long al_produto, string as_uf, string as_rede_fil, date adt_inicio_resumo, date adt_termino_resumo, decimal adc_preco_atual);/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																										//
//																	Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo PBM																				//
//																																										//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	REGRAS:																																							//
//			3 - PBM:																																					//
//					C$$HEX1$$e100$$ENDHEX$$lculo desconto PBM: M$$HEX1$$e900$$ENDHEX$$dia de desconto aplicado com vendas PBM nos $$HEX1$$fa00$$ENDHEX$$ltimos 3 meses (5).								//
//					Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo $$HEX1$$e900$$ENDHEX$$ o pre$$HEX1$$e700$$ENDHEX$$o l$$HEX1$$ed00$$ENDHEX$$quido do desconto PBM calculado. Por exemplo, desconto PBM m$$HEX1$$e900$$ENDHEX$$dio para o SKU XXX 		//
//					nos $$HEX1$$fa00$$ENDHEX$$ltimos 3 meses foi de 15%. Para o Pre$$HEX1$$e700$$ENDHEX$$o Bruto de R$ 30,00 o Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo PBM $$HEX1$$e900$$ENDHEX$$ R$ 25,50 [30 * (1 $$HEX1$$1320$$ENDHEX$$ 15%)].	//
//																																										//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

String ls_MSG
Decimal{4} ldc_PC_Desc_Medio_PBM
Decimal{2} ldc_Minimo_PBM

Try
	Select coalesce(round(avg(pc_desconto_pbm) , 4), 0)
	Into :ldc_PC_Desc_Medio_PBM
	From resumo_precificacao
	where cd_produto 	= :al_Produto
		and cd_uf 			= :as_UF
		and id_rede_filial 	= :as_Rede_Fil
		and dh_resumo 	>= :adt_Inicio_Resumo
		and dh_resumo 	<= :adt_Termino_Resumo
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_MSG = SqlCa.SqlErrText
		SqlCa.of_RollBack()
		This.of_Grava_Log("Erro - Localizar o custo m$$HEX1$$e900$$ENDHEX$$dio do resumo do produto [" + String(al_Produto) + "].", ls_MSG, ivs_subcategoria, al_produto)
		Return False
	End If
	
	ldc_Minimo_PBM =  round(adc_Preco_Atual * (1 - (ldc_PC_Desc_Medio_PBM / 100)), 2)
	
	//3 	PBM
	If Not This.of_inclui_preco_minimo(al_Produto, as_UF, as_Rede_Fil,  3, ldc_Minimo_PBM) Then Return False
	
Catch (RuntimeError lvo_Erro)
	This.of_Grava_Log("Erro na execu$$HEX2$$e700e300$$ENDHEX$$o da fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_preco_minimo_pbm() para o produto [" + String(al_Produto) + "].", ls_MSG, ivs_subcategoria, al_produto)
	Return False
	
End Try
end function

private function boolean of_atualiza_preco_minimo_maior (long al_produto, string as_uf, string as_rede_fil);Decimal{2} ldc_Preco_Minimo
String ls_MSG

Try
	Select Coalesce(Max(vl_preco_minimo), 0)
	Into :ldc_Preco_Minimo
	From precificacao_prd_minimo
	Where nr_precificacao 			= :il_NR_Precificacao
		and cd_produto 				= :al_Produto
		and cd_unidade_federacao 	= :as_UF
		and id_rede_filial				= :as_Rede_Fil
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_MSG = SqlCa.SqlErrText
		SqlCa.of_RollBack()
		This.of_Grava_Log("Erro - Recuperar o pre$$HEX1$$e700$$ENDHEX$$o m$$HEX1$$ed00$$ENDHEX$$nimo do produto [" + String(al_Produto) + "].", ls_MSG, ivs_Subcategoria, al_Produto)
		Return False
	End If
	
	// Verificar se realmente existe a necessidade de possuir o m$$HEX1$$ed00$$ENDHEX$$nimo
	If ldc_Preco_Minimo = 0 Then
		This.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o foi encontrado o pre$$HEX1$$e700$$ENDHEX$$o m$$HEX1$$ed00$$ENDHEX$$nimo do produto [" + String(al_Produto) + "].","", ivs_Subcategoria, al_Produto)
		//Return False
	End If
	
	UPDATE precificacao_prd  
	SET vl_preco_minimo = :ldc_Preco_Minimo
	Where nr_precificacao 			= :il_NR_Precificacao
		and cd_produto 				= :al_Produto
		and cd_unidade_federacao 	= :as_UF
		and id_rede_filial				= :as_Rede_Fil
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_MSG = SqlCa.SqlErrText
		SqlCa.of_RollBack()
		This.of_Grava_Log("Erro - Atualizar o pre$$HEX1$$e700$$ENDHEX$$o m$$HEX1$$ed00$$ENDHEX$$nimo do produto [" + String(al_Produto) + "].", ls_MSG, ivs_Subcategoria, al_Produto)
		Return False
	End If
	
Catch (RuntimeError lvo_Erro)
		SqlCa.of_RollBack()
		This.of_Grava_Log("Erro - Atualizar o pre$$HEX1$$e700$$ENDHEX$$o m$$HEX1$$ed00$$ENDHEX$$nimo do produto [" + String(al_Produto) + "], na fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_preco_minimo_maior().", lvo_Erro.GetMessage(), ivs_Subcategoria)
		Return False
Finally
	
End Try

Return True
end function

private function boolean of_atualiza_preco_minimo_fpb (long al_produto, string as_uf, string as_rede_fil, string as_gratis_farm_pop, decimal adc_rembolso_fpb);/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																										//
//														Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo FARM$$HEX1$$c100$$ENDHEX$$CIA GOVERNO 																	//
//																																										//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	REGRAS:																																							//
//			2 - FARM$$HEX1$$c100$$ENDHEX$$CIA GOVERNO: 																															//
//					Para farm$$HEX1$$e100$$ENDHEX$$cia do Governo, o Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo se diferencia caso o modelo seja gratuito ou coparticipativo:				//
//					$$HEX1$$2220$$ENDHEX$$	Gratuito: Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo $$HEX1$$e900$$ENDHEX$$ igual ao valor de restitui$$HEX2$$e700e300$$ENDHEX$$o do governo (4)															//
//					$$HEX1$$2220$$ENDHEX$$	Coparticipativo: Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo $$HEX1$$e900$$ENDHEX$$ 10% maior que o valor de restitui$$HEX2$$e700e300$$ENDHEX$$o do governo 										//
//					Como exemplo, o SKU XXX $$HEX1$$e900$$ENDHEX$$ um medicamento da farm$$HEX1$$e100$$ENDHEX$$cia do governo do governo do modelo coparticipativo com 	//
//					restitui$$HEX2$$e700e300$$ENDHEX$$o do governo de R$ 22,00. Neste caso o Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo $$HEX1$$e900$$ENDHEX$$ 10% maior que R$ 22,00, ou seja, R$ 24,20.		//
//																																										//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Decimal{2} ldc_Minimo_Farm_Gov

Try
	// Gr$$HEX1$$e100$$ENDHEX$$tis $$HEX1$$e900$$ENDHEX$$ considerado o reembolso do governo
	If as_Gratis_Farm_Pop = 'S' Then
		ldc_Minimo_Farm_Gov = adc_Rembolso_FPB
	Else
		// Coparticipa$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ considerado o valor do reembolso do governo + 10%
		ldc_Minimo_Farm_Gov = Round(adc_Rembolso_FPB * 1.10, 2)
	End If
	
	//2	 FARMACIA GOVERNO
	If Not This.of_inclui_preco_minimo(al_Produto, as_UF, as_Rede_Fil,  2, ldc_Minimo_Farm_Gov) Then Return False
	
Catch (RuntimeError lvo_Erro)
	SQLCa.Of_Rollback()
	This.Of_Grava_log( "Erro na execu$$HEX2$$e700e300$$ENDHEX$$o da fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_preco_minimo_fpb()." , lvo_Erro.GetMessage(), ivs_Subcategoria)
	Return False
	
End Try

Return True
end function

private function boolean of_atualiza_preco_minimo ();/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																										//
//																			Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo																			//
//																																										//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	REGRAS:																																							//
//			Pre$$HEX1$$e700$$ENDHEX$$o m$$HEX1$$ed00$$ENDHEX$$nimo ser$$HEX1$$e100$$ENDHEX$$ o valor do qual o pre$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser inferior durante todo o c$$HEX1$$e100$$ENDHEX$$lculo. 											//
//			Deve-se estabelecer como Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo o maior valor entre os indicadores.															//
//			Cada um dos modelos de c$$HEX1$$e100$$ENDHEX$$lculo ter$$HEX1$$e100$$ENDHEX$$ diferentes m$$HEX1$$ed00$$ENDHEX$$nimos, conforme abaixo:															//
//				$$HEX1$$2220$$ENDHEX$$	MEDICAMENTO RX: Lei Gen$$HEX1$$e900$$ENDHEX$$rico (1), Farm$$HEX1$$e100$$ENDHEX$$cia do Governo (2), PBM (3) e Fornecedor (4);									//
//				$$HEX1$$2220$$ENDHEX$$	N$$HEX1$$c300$$ENDHEX$$O MEDICAMENTO: Papel Subcategoria (5), Marcas na Subcategoria (6), Marca em Dif. Subcategorias e 				//
//												Fornecedor (4);																									//
//				$$HEX1$$2220$$ENDHEX$$	MEDICAMENTO MIP: Tier Subcategorias (1), Marcas na Subcategoria (6) e Fornecedor (4)									//
//																																										//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	REGRAS PARA C$$HEX1$$c100$$ENDHEX$$LCULOS DOS M$$HEX1$$cd00$$ENDHEX$$NIMOS:																												//
//																																										//
//			1 - LEI GENERICO: 																																	//
//					Margem m$$HEX1$$ed00$$ENDHEX$$nima definida pela $$HEX1$$e100$$ENDHEX$$rea de Pricing por Lei do Gen$$HEX1$$e900$$ENDHEX$$rico, conforme tabela margem_resultado_preco 		//
//					(cd_tipo_margem = 1). A tabela deve se diferencia por Bandeira (PP e DC). 													//
//					O Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo deste indicador $$HEX1$$e900$$ENDHEX$$ calculado pela aplica$$HEX2$$e700e300$$ENDHEX$$o da margem m$$HEX1$$ed00$$ENDHEX$$nima sobre a m$$HEX1$$e900$$ENDHEX$$dia do custo de 3 meses	//
//					por SKU.																																			//
//					Por exemplo, SKU XXX $$HEX1$$e900$$ENDHEX$$ um Gen$$HEX1$$e900$$ENDHEX$$rico com custo m$$HEX1$$e900$$ENDHEX$$dio de R$ 20,00. Neste caso, aplica-se a margem de 25% 		//
//					sobre R$20,00 para chegar no resultado de R$ 26,67 [20 / (1 - 25%)].															//
//																																										//
//			2 - FARM$$HEX1$$c100$$ENDHEX$$CIA GOVERNO: 																															//
//					Para farm$$HEX1$$e100$$ENDHEX$$cia do Governo, o Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo se diferencia caso o modelo seja gratuito ou coparticipativo:				//
//					$$HEX1$$2220$$ENDHEX$$	Gratuito: Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo $$HEX1$$e900$$ENDHEX$$ igual ao valor de restitui$$HEX2$$e700e300$$ENDHEX$$o do governo (4)															//
//					$$HEX1$$2220$$ENDHEX$$	Coparticipativo: Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo $$HEX1$$e900$$ENDHEX$$ 10% maior que o valor de restitui$$HEX2$$e700e300$$ENDHEX$$o do governo 										//
//					Como exemplo, o SKU XXX $$HEX1$$e900$$ENDHEX$$ um medicamento da farm$$HEX1$$e100$$ENDHEX$$cia do governo do governo do modelo coparticipativo com 	//
//					restitui$$HEX2$$e700e300$$ENDHEX$$o do governo de R$ 22,00. Neste caso o Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo $$HEX1$$e900$$ENDHEX$$ 10% maior que R$ 22,00, ou seja, R$ 24,20.		//
//																																										//
//			3 - PBM:																																					//
//					C$$HEX1$$e100$$ENDHEX$$lculo desconto PBM: M$$HEX1$$e900$$ENDHEX$$dia de desconto aplicado com vendas PBM nos $$HEX1$$fa00$$ENDHEX$$ltimos 3 meses (5).								//
//					Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo $$HEX1$$e900$$ENDHEX$$ o pre$$HEX1$$e700$$ENDHEX$$o l$$HEX1$$ed00$$ENDHEX$$quido do desconto PBM calculado. Por exemplo, desconto PBM m$$HEX1$$e900$$ENDHEX$$dio para o SKU XXX 		//
//					nos $$HEX1$$fa00$$ENDHEX$$ltimos 3 meses foi de 15%. Para o Pre$$HEX1$$e700$$ENDHEX$$o Bruto de R$ 30,00 o Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo PBM $$HEX1$$e900$$ENDHEX$$ R$ 25,50 [30 * (1 $$HEX1$$1320$$ENDHEX$$ 15%)].	//
//																																										//
//			4 - FORNECEDOR:																																		//	
//					Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo estabelecido pelo fornecedor (6). Esta informa$$HEX2$$e700e300$$ENDHEX$$o deve ser atualizada pela $$HEX1$$e100$$ENDHEX$$rea de compras, e ficar$$HEX1$$e100$$ENDHEX$$ //
//					armazenada na tabela produto_uf no campo vl_preco_venda_fornecedor. 														//
//					Como exemplo, o SKU XXX tem o Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo provido pelo fornecedor de R$ 22,50.										//
//																																										//
//			5 - PAPEL SUBCATEGORIA:																															//
//					A $$HEX1$$e100$$ENDHEX$$rea de Pricing fica encarregada de liderar a revis$$HEX1$$e300$$ENDHEX$$o da classifica$$HEX2$$e700e300$$ENDHEX$$o das subcategorias periodicamente com as 	//
//					demais $$HEX1$$e100$$ENDHEX$$reas envolvidas. $$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio que cada subcategoria tenha alguma destas classifica$$HEX2$$e700f500$$ENDHEX$$es: Destino, Rotina, 	//
//					Sazonal, Ocasional e Conveni$$HEX1$$ea00$$ENDHEX$$ncia. Cada uma destas classifica$$HEX2$$e700f500$$ENDHEX$$es tem um % de margem para ser considerado 	//
//					como m$$HEX1$$ed00$$ENDHEX$$nimo aceit$$HEX1$$e100$$ENDHEX$$vel por Bandeira, estes valores estar$$HEX1$$e300$$ENDHEX$$o registrados na tabela margem_resultado_preco, com 	//
//					o cd_tipo_margem = 5.																														//
//					O Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo deste indicador $$HEX1$$e900$$ENDHEX$$ calculado pela aplica$$HEX2$$e700e300$$ENDHEX$$o da margem m$$HEX1$$ed00$$ENDHEX$$nima sobre a m$$HEX1$$e900$$ENDHEX$$dia do custo de 3 meses 	//
//					por SKU. 																																		//
//					Por exemplo, SKU YYY com classifica$$HEX2$$e700e300$$ENDHEX$$o DESTINO com custo m$$HEX1$$e900$$ENDHEX$$dio de R$ 10,00. Neste caso, aplica-se a margem 	//
//					de 12% sobre R$10,00 para chegar no Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo de R$ 11,43 [10 / (1 - 12%)].											//
//																																										//
//			6 - MARCAS DENTRO DA MESMA SUBCATEGORIA:																							//
//					Esta regra tem como objetivo avaliar a margem praticada pelas marcas com menor venda em compara$$HEX2$$e700e300$$ENDHEX$$o das 		//
//					marcas com maior giro. Para isso, deve-se avaliar a margem das marcas que representam pelo menos 80% da 		//
//					quantidade vendida, ou seja, se um conjunto de marcas somar 79,9% das vendas, $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio contemplar 			//
//					pelo menos mais uma marca para completar pelo menos 80%, podendo ultrapassar 80% das vendas. 					//
//					Este c$$HEX1$$e100$$ENDHEX$$lculo utiliza a quantidade vendida dos $$HEX1$$fa00$$ENDHEX$$ltimos 3 meses.																		//
//						$$HEX1$$2220$$ENDHEX$$	Avalia$$HEX2$$e700e300$$ENDHEX$$o das marcas que representam 80% das vendas;																	//
//						$$HEX1$$2220$$ENDHEX$$	Deve-se calcular a margem m$$HEX1$$e900$$ENDHEX$$dia ponderada das marcas que representam pelo menos 80% das vendas.		//
//							Para o exemplo, foi considerado as marcas JOHNSON&JOHNSON, DOVE E NIVEA para calcular a margem, 		//
//							resultando em 29,1%.																												//
//						$$HEX1$$2220$$ENDHEX$$	Para as marcas que representam 20% das vendas deve-se comparar a margem dos $$HEX1$$fa00$$ENDHEX$$ltimos 3 meses com a 	//
//							margem m$$HEX1$$e900$$ENDHEX$$dia calculada;																											//
//					O Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo para os SKUs das marcas deve ser o custo m$$HEX1$$e900$$ENDHEX$$dio dos $$HEX1$$fa00$$ENDHEX$$ltimos 3 meses acrescendo a margem 		//
//					m$$HEX1$$e900$$ENDHEX$$dia das marcas que representam 80% das vendas, como no exemplo abaixo para o SKU SAB PHEBO 100G 			//
//					TUBEROSA EGITO:																															//
//						$$HEX1$$2220$$ENDHEX$$	Custo: R$2,69																															//
//						$$HEX1$$2220$$ENDHEX$$	Margem M$$HEX1$$ed00$$ENDHEX$$nima: 29,1%																												//
//						$$HEX1$$2220$$ENDHEX$$	Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo: R$ 3,79 [2,69 / (1- 29,1%)]																						//
//																																										//
//			7 - MESMA MARCA POR DIFERENTES SUBCATEGORIAS DENTRO CATEGORIA:															//
//					Esta regra tem como objetivo avaliar a margem para menores subcategorias considerando a mesma marca e 		//
//					categoria de produto. Nos exemplos abaixo, $$HEX1$$e900$$ENDHEX$$ feita a compara$$HEX2$$e700e300$$ENDHEX$$o das diferentes subcategorias que as marcas 		//
//					GRANADO e DOVE possuem para a categoria SANONETES:																			//
//						$$HEX1$$2220$$ENDHEX$$	GRANADO: 																																//
//							o	Maior subcategoria: Barra Tradicional																						//
//							o	Margem: 14% 																														//
//							o	Demais Subcategorias com margem maior que 14% 																		//
//						$$HEX1$$2220$$ENDHEX$$	DOVE: 																																	//
//							o	Maior subcategoria: Barra Tradicional																						//
//							o	Margem: 35% 																														//
//							o	Demais subcategorias com margem inferior devem aproximas o valor a 35% de margem. Como por 		//
//								exemplo, SAB DOVE BABY 75G HIDRATACAO ENRIQUECIDA com custo de R$ 1,81  e aplicando a 				//
//								margem de 35%, chega-se ao Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo de R$ 2,78 [1,81 / (1- 35%)].											//
//																																										//
//			8 - TIER SUBCATEGORIAS:																															//
//					A $$HEX1$$e100$$ENDHEX$$rea de Pricing fica encarregada de liderar a revis$$HEX1$$e300$$ENDHEX$$o da classifica$$HEX2$$e700e300$$ENDHEX$$o das subcategorias periodicamente com as 	//
//					demais $$HEX1$$e100$$ENDHEX$$reas envolvidas. $$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio que cada subcategoria tenha alguma destas classifica$$HEX2$$e700f500$$ENDHEX$$es: TIER 1, TIER 2 e //
//					TIER 3, sendo TIER 1 com maior giro e TIER 3 com menor giro de vendas. Cada uma destas classifica$$HEX2$$e700f500$$ENDHEX$$es deve ter	//
//					um % de margem para ser considerado como m$$HEX1$$ed00$$ENDHEX$$nimo aceit$$HEX1$$e100$$ENDHEX$$vel por Bandeira e Lei do Gen$$HEX1$$e900$$ENDHEX$$rico, que estar$$HEX1$$e100$$ENDHEX$$			//
//					registrado na tabela margem_resultado_preco.																						//
//					O Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo deste indicador $$HEX1$$e900$$ENDHEX$$ calculado pela aplica$$HEX2$$e700e300$$ENDHEX$$o da margem m$$HEX1$$ed00$$ENDHEX$$nima sobre a m$$HEX1$$e900$$ENDHEX$$dia do custo de 3 meses 	//
//					por SKU (3). 																																	//
//					Por exemplo, medicamento ZZZ tem classifica$$HEX2$$e700e300$$ENDHEX$$o TIER 1 e Refer$$HEX1$$ea00$$ENDHEX$$ncia com custo m$$HEX1$$e900$$ENDHEX$$dio de R$ 33,00. Neste caso, 	//
//					aplica-se a margem de 10% sobre R$ 33,00 para chegar no resultado de R$ 36,67 [33 / (1 - 10%)].						//
//																																										//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Long ll_Linha, ll_Linhas, ll_Produto, ll_Marca

String ls_Rede_Fil, ls_UF, ls_MSG, ls_Farma_Pop, ls_Gratis_Farm_Pop, ls_PBM, ls_CD_SubCategoria, ls_DE_SubCategoria, ls_Lei_Gen

Decimal ldc_Margem_Minima, ldc_Preco_Forn, ldc_Rembolso_FPB, ldc_Custo_Medio, ldc_Minimo, ldc_Minimo_Farm_Gov, ldc_PC_Desc_Medio_PBM, ldc_Minimo_PBM, ldc_Preco_Atual, ldc_Preco_Minimo

Date ldt_Inicio_Resumo, ldt_Termino_Resumo

// Retorna os $$HEX1$$fa00$$ENDHEX$$ltimos tr$$HEX1$$ea00$$ENDHEX$$s meses de resumo
If Not of_periodo(Integer(3), ref ldt_Inicio_Resumo, ldt_Termino_Resumo) Then Return False

try
	w_ge450_aguarde.uo_progress.of_SetStart()
	w_ge450_aguarde.st_processo.Text = "Verificando Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo ..."
	
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge450_precificacao_produto", False) Then 
		This.of_Grava_Log("Erro na troca da dw [ds_ge450_precificacao_produto].", '')
		Return False
	End If
	
	ll_Linhas = lds.Retrieve(il_NR_Precificacao, il_Tipo_Precificacao)
				
	If ll_Linhas > 0 Then
		
		w_ge450_aguarde.uo_progress.of_setmax(ll_Linhas)
								
		For ll_Linha = 1 To ll_Linhas
			ll_Produto 				= lds.Object.cd_produto						[ll_Linha]
			ls_Rede_Fil 				= lds.Object.id_rede_filial					[ll_Linha]
			ls_UF 						= lds.Object.cd_unidade_federacao		[ll_Linha]
			ldc_Margem_Minima 	= lds.Object.pc_margem_minima			[ll_Linha]
			ldc_Preco_Forn			= lds.Object.vl_preco_venda_fornecedor	[ll_Linha]
			ldc_Rembolso_FPB		= lds.Object.vl_reembolso_fpb				[ll_Linha]
			ls_Farma_Pop			= lds.Object.id_farmacia_popular			[ll_Linha]
			ls_Gratis_Farm_Pop	= lds.Object.id_gratis_farm_popular		[ll_Linha]
			ls_PBM					= lds.Object.id_pbm							[ll_Linha]
			ldc_Preco_Atual		= lds.Object.vl_preco_venda_atual		[ll_Linha]
			ldc_Custo_Medio		= lds.Object.vl_custo_medio				[ll_Linha]
			ls_CD_SubCategoria	= lds.Object.cd_subcategoria				[ll_Linha]
			ls_DE_SubCategoria	= lds.Object.de_subcategoria				[ll_Linha] 
			ls_Lei_Gen				= lds.Object.id_lei_generico					[ll_Linha]
			ll_Marca					= lds.Object.cd_marca_produto			[ll_Linha]
			ivs_Subcategoria		= ls_CD_SubCategoria
			
			ivs_Chave =   "<b>SubCategoria:</b> "+ls_DE_SubCategoria+" ("+ls_CD_SubCategoria+")"
			
			// Esta parte ser$$HEX1$$e100$$ENDHEX$$ feita os tr$$HEX1$$ea00$$ENDHEX$$s modelos de c$$HEX1$$e100$$ENDHEX$$lculo.
			// 1 - M$$HEX1$$ed00$$ENDHEX$$nimo por Lei Gen$$HEX1$$e900$$ENDHEX$$rico, 5 - Papel Subcategoria ou 8 - Por Tier (o que muda nesses calculos $$HEX1$$e900$$ENDHEX$$ o % que est$$HEX1$$e100$$ENDHEX$$ tratado no datasource)
			ldc_Minimo = Round(ldc_Custo_Medio / (1 - (ldc_Margem_Minima / 100)), 2)
			If Not This.of_inclui_preco_minimo(ll_Produto, ls_UF, ls_Rede_Fil,  IIF(il_Tipo_Precificacao=1, 1, IIF(il_Tipo_Precificacao=2, 5, 8)), ldc_Minimo) Then Return False
			
			// 4 - Fornecedor	
			If ldc_Preco_Forn > 0 Then
				If Not This.of_inclui_preco_minimo(ll_Produto, ls_UF, ls_Rede_Fil,  4, ldc_Preco_Forn) Then Return False
			End If
			
			Choose Case il_Tipo_Precificacao
				Case 1 	// MEDICAMENTO RX 
					//2 - Farm$$HEX1$$e100$$ENDHEX$$cia do governo
					If ls_Farma_Pop = 'S' Then
						If Not This.Of_Atualiza_Preco_Minimo_FPB( ll_Produto, ls_UF, ls_Rede_Fil, ls_Gratis_Farm_Pop, ldc_Rembolso_FPB) Then Return False
					End If
					
					//3 - PBM
					If ls_PBM = 'S' Then
						If Not This.Of_Atualiza_Preco_Minimo_PBM( ll_Produto, ls_UF, ls_Rede_Fil, ldt_Inicio_Resumo, ldt_Termino_Resumo, ldc_Preco_Atual) Then Return False
					End If
					
				Case 2 	// N$$HEX1$$c300$$ENDHEX$$O MEDICAMENTO 
					If Not This.of_Atualiza_Preco_Minimo_Marca_Subcat( ll_Produto, ls_UF, ls_Rede_Fil, ldt_Inicio_Resumo, ldt_Termino_Resumo, ls_CD_SubCategoria, ls_Lei_Gen, ldc_Custo_Medio ) Then Return False
					If Not This.of_Atualiza_Preco_Minimo_Marca_Categ( ll_Produto, ls_UF, ls_Rede_Fil, ldt_Inicio_Resumo, ldt_Termino_Resumo, ls_CD_SubCategoria, ll_Marca, ldc_Custo_Medio ) Then Return False
					
				Case 3 	// MEDICAMENTO MIP
					If Not This.of_Atualiza_Preco_Minimo_Marca_Subcat( ll_Produto, ls_UF, ls_Rede_Fil, ldt_Inicio_Resumo, ldt_Termino_Resumo, ls_CD_SubCategoria, ls_Lei_Gen, ldc_Custo_Medio ) Then Return False
					
			End Choose
			
			//Atualiza na tabela precificacao_prd o campo vl_minimo para o maior valor m$$HEX1$$ed00$$ENDHEX$$nimo calculado para este produto, rede e UF
			If Not This.Of_Atualiza_Preco_Minimo_Maior( ll_Produto, ls_UF, ls_Rede_Fil) Then Return False
			
			w_ge450_aguarde.uo_progress.of_SetProgress(ll_Linha)
			
		Next
		
	ElseIf ll_Linhas < 0 Then
		SqlCa.of_RollBack();
		of_Grava_Log("Erro - Recuperar a lista de produtos.", '')
		Return False
	End If
	
finally
	If IsValid(lds) Then Destroy lds
	SetNull(ivs_Subcategoria)
	ivs_Chave = ""
end try

Return True
end function

private function boolean of_atualiza_preco_laboratorio_parceiro ();Long lvl_Linha
Long lvl_Prod

Decimal{2} lvdc_VL_Lab_Parc

String lvs_MSG

Try
	ids_exponencial.SetFilter("not isNull(cd_produto)")
	If ids_exponencial.Filter() < 0 Then
		This.Of_grava_log( "Falha ao aplicar o filtro no datasource exponencial na fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_preco_laboratorio_parceiro().", ids_exponencial.ivo_dberror.ivs_sqlerrtext, ivs_Subcategoria)
		Return False
	End If
	
	For lvl_Linha = 1 To ids_exponencial.RowCount()
		lvl_Prod 				= ids_exponencial.Object.cd_produto 		[lvl_Linha]
		lvdc_VL_Lab_Parc	= ids_exponencial.Object.vl_preco_lab_parc[lvl_Linha]
		
		update precificacao_prd
		set vl_preco_lab_parceiro = :lvdc_VL_Lab_Parc
		Where cd_produto = :lvl_Prod
			And nr_precificacao = :il_NR_Precificacao
		Using SQLCa;
		
		If SqlCa.SqlCode = -1 Then
			lvs_MSG = SqlCa.SqlErrText
			SqlCa.of_RollBack()
			This.of_Grava_Log("Erro ao atualizar o pre$$HEX1$$e700$$ENDHEX$$o final exponencial, na fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_preco_laboratorio_parceiro().", lvs_MSG, ivs_Subcategoria, lvl_Prod)
			Return False
		End If
	Next 
	
Catch (RuntimeError lvo_Erro)
	This.Of_grava_log( "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_preco_laboratorio_parceiro().", lvo_Erro.GetMessage(), ivs_Subcategoria)
	Return False
	
Finally
	ids_exponencial.SetFilter("")
	If ids_exponencial.Filter() < 0 Then
		This.Of_grava_log( "Falha ao remover o filtro no datasource exponencial na fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_preco_laboratorio_parceiro().", ids_exponencial.ivo_DbError.ivs_SQLErrText, ivs_Subcategoria)
		Return False
	End If	
	
End Try

Return True
end function

private function boolean of_atualiza_preco_exponencial ();Long lvl_Linha
Long lvl_Prod

Decimal{2} lvdc_VL_Exponencial

String lvs_MSG

Try
	ids_exponencial.SetFilter("not isNull(cd_produto)")
	If ids_exponencial.Filter() < 0 Then
		This.Of_grava_log( "Falha ao aplicar o filtro no datasource exponencial na fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_preco_exponencial().", ids_exponencial.ivo_dberror.ivs_sqlerrtext, ivs_Subcategoria)
		Return False
	End If
	
	For lvl_Linha = 1 To ids_exponencial.RowCount()
		lvl_Prod 					= ids_exponencial.Object.cd_produto 				[lvl_Linha]
		lvdc_VL_Exponencial	= ids_exponencial.Object.vl_preco_exponencial	[lvl_Linha]
		
		update precificacao_prd
		set vl_preco_exponencial = :lvdc_VL_Exponencial,
			 vl_preco_apresentacao = :lvdc_VL_Exponencial
		Where cd_produto			= :lvl_Prod
			And nr_precificacao	= :il_NR_Precificacao
		Using SQLCa;
		
		If SqlCa.SqlCode = -1 Then
			lvs_MSG = SqlCa.SqlErrText
			SqlCa.of_RollBack()
			This.of_Grava_Log("Erro ao atualizar o pre$$HEX1$$e700$$ENDHEX$$o final exponencial, na fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_preco_exponencial().", lvs_MSG, ivs_Subcategoria, lvl_Prod)
			Return False
		End If
	Next 
Catch (RuntimeError lvo_Erro)
	This.Of_grava_log( "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_preco_exponencial().", lvo_Erro.GetMessage(), ivs_Subcategoria)
	Return False
	
Finally
	ids_exponencial.SetFilter("")
	If ids_exponencial.Filter() < 0 Then
		This.Of_grava_log( "Falha ao remover o filtro no datasource exponencial na fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_preco_exponencial().", "")
		Return False
	End If	
	
End Try

Return True
end function

private subroutine of_grava_log (string as_mensagem, string as_erro, string as_subcategoria, long al_produto, long al_cidade);String ls_Mensagem = ""
String ls_Tipo
String ls_Chave
Long ll_Sequencial

ls_Tipo = IIF(Trim(as_erro)<>"", "E", "A")

If Pos(ivs_Log, ivs_Chave) = 0 Then 
	If Trim(ivs_Log) <> "" Then ivs_Log += "</ul><br />"
	ls_Mensagem = "<li>"+IIF(IsNull(ivs_Chave) or (trim(ivs_Chave)=""), "GERAL", ivs_Chave)+"</li><ul>"
End If


ls_Mensagem += "<li><u>Data/Hora:</u> "+String(Today(), "dd/mm/yyyy") + " " + String(Now(), "hh:mm:ss") + "<br />"
ls_Mensagem += "<u>Mensagem:</u> "+ as_mensagem+"<br />"

If Not IsNull(as_erro) and Trim(as_erro) <> "" Then
	ls_Mensagem += ls_Mensagem + '<u>Erro:</u> ' + as_erro
End If
ls_Mensagem += "</li>~n"

ivs_Log += ls_Mensagem

If Not IsNull(il_NR_Precificacao) Then
	select coalesce(max(nr_sequencial),0)+1
	Into :ll_Sequencial
	From precificacao_log
	Where nr_precificacao = :il_NR_Precificacao
	Using ivtr_trans;
	
	If ivtr_trans.SQLCode = -1 Then
		ivs_Log += "<br /><br /><b>N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar o sequencial do log, por este motivo o sistema n$$HEX1$$e300$$ENDHEX$$o gravou este log na base.</b> Erro: "+ivtr_trans.SQLErrText+".<br /><br />"
		Return
	End If
	
	ls_Chave			= gf_replace_tags_html(gf_replace(ivs_Chave, "<br />", " / ", 0))
	ls_Chave			= IIF(IsNull(ls_Chave) or (Trim(ls_Chave) = ""), "GERAL", ls_Chave)
	ls_Mensagem	= as_mensagem + IIF(Trim(as_erro)<>""," Erro: "+as_erro,"")
	ls_Mensagem	= Upper(ls_Mensagem)
	
	Insert Into precificacao_log (nr_precificacao, nr_sequencial, id_tipo_log, cd_subcategoria, cd_produto, cd_cidade, dh_log, de_chave, de_log)
	Values (:il_NR_Precificacao, :ll_Sequencial, :ls_Tipo, :as_subcategoria,  :al_produto, :al_cidade, getdate(), :ls_Chave, :ls_Mensagem)
	Using ivtr_trans;
	
	If ivtr_trans.SQLCode = -1 Then
		ivs_Log += "<br /><br /><b>N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gravar este log na base.</b> Erro: "+ivtr_trans.SQLErrText+".<br /><br />"
		Return
	End If
	
	ivtr_trans.Of_Commit()
End If
end subroutine

private subroutine of_grava_log (string as_mensagem, string as_erro, string as_subcategoria, long al_produto);Long lvl_Null

SetNull( lvl_Null )

This.of_grava_log( as_mensagem, as_erro, as_subcategoria, al_produto, lvl_Null)
end subroutine

private subroutine of_grava_log (string as_mensagem, string as_erro, string as_subcategoria);Long lvl_Null

SetNull( lvl_Null )

This.of_grava_log( as_mensagem, as_erro, as_subcategoria, lvl_Null)
end subroutine

public subroutine of_grava_log (string as_mensagem, string as_erro);This.of_grava_log( as_mensagem, as_erro, "")
end subroutine

public function boolean of_regionalizacao_preco (long al_precificacao, long al_tipo_precificacao, string as_tipo_precificacao, string as_uf, string as_rede_filial, datetime adh_inicio_calculo, dc_uo_ds_base ads_regionalizacao);Long lvl_Linha
Long lvl_Linhas
Long lvl_Cidade

String lvs_Subcategoria

Decimal lvdc_PC_Ajuste

Try
	il_Tipo_Precificacao			= al_tipo_precificacao
	il_NR_Precificacao				= al_precificacao
	is_Desc_Tipo_Precificacao	= as_tipo_precificacao
	lvl_Linhas = ads_regionalizacao.RowCount()
	
	If Not IsValid(w_ge450_aguarde) Then Open(w_ge450_aguarde)
	
	w_ge450_aguarde.uo_progress.of_SetStart()
	w_ge450_aguarde.Title 					= "Executando Precifica$$HEX2$$e700e300$$ENDHEX$$o [" + String(al_precificacao) + "] ..."
	w_ge450_aguarde.st_calculo.Text		= "C$$HEX1$$e100$$ENDHEX$$lculo: "  + as_tipo_precificacao
	w_ge450_aguarde.st_processo.Text	= "Aplicando Pre$$HEX1$$e700$$ENDHEX$$o Regionalizado..."
	w_ge450_aguarde.uo_progress.Of_SetMax(lvl_Linhas)
	
	For lvl_Linha = 1 To lvl_Linhas
	
		lvl_Cidade			= ads_regionalizacao.Object.cd_cidade 			[lvl_Linha]
		lvs_Subcategoria	= ads_regionalizacao.Object.cd_subcategoria	[lvl_Linha]
		lvdc_PC_Ajuste		= ads_regionalizacao.Object.pc_ajuste			[lvl_Linha]
	
		Insert into precificacao_prd_regional (nr_precificacao, cd_produto, cd_uf, id_rede_filial, cd_cidade, pc_ajuste_regional, vl_preco_regionalizado)
		Select 	pp.nr_precificacao, 
					pp.cd_produto, 
					pp.cd_unidade_federacao, 
					pp.id_rede_filial, 
					:lvl_Cidade, 
					:lvdc_PC_Ajuste, 
					round(coalesce(pp.vl_preco_final,0) * (1 + :lvdc_PC_Ajuste / 100 ), 2)
		From precificacao p
		inner join precificacao_prd pp
			on pp.nr_precificacao = p.nr_precificacao
		Where p.nr_precificacao = :al_precificacao
			And p.cd_subcategoria = :lvs_Subcategoria
			And coalesce(pp.vl_preco_final,0) > 0
		Using SQLCa;
	
		If SQLCa.SQLCode = -1 Then
			This.Of_Grava_log( "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_regionalizacao_preco().", SQLCa.SQLErrText, lvs_Subcategoria)
			SQLCa.Of_Rollback( )
			Return False
		End If
		
		w_ge450_aguarde.uo_progress.Of_SetProgress(lvl_Linha)
	Next
	
	w_ge450_aguarde.uo_progress.of_SetStart()
	w_ge450_aguarde.st_processo.Text	= "Atualizando Produtos Inferior ao Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo..."
	//Atualiza para pre$$HEX1$$e700$$ENDHEX$$o m$$HEX1$$ed00$$ENDHEX$$nimo os produtos abaixo do pre$$HEX1$$e700$$ENDHEX$$o m$$HEX1$$ed00$$ENDHEX$$nimo
	update precificacao_prd_regional
	set vl_preco_regionalizado = (select vl_preco_minimo from precificacao_prd pp1 where pp1.nr_precificacao = precificacao_prd_regional.nr_precificacao and pp1.cd_produto = precificacao_prd_regional.cd_produto)
	Where exists (	select 1 
						from precificacao_prd pp1 
						where pp1.nr_precificacao = precificacao_prd_regional.nr_precificacao 
						and pp1.cd_produto = precificacao_prd_regional.cd_produto
						and coalesce(pp1.vl_preco_minimo,0) > 0
						and pp1.vl_preco_minimo > precificacao_prd_regional.vl_preco_regionalizado)
		And nr_precificacao = :al_precificacao
	Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then
		This.Of_Grava_log( "Erro ao atualizar os produtos regionalizados inferiores ao min$$HEX1$$ed00$$ENDHEX$$mo na fun$$HEX2$$e700e300$$ENDHEX$$o of_regionalizacao_preco().", SQLCa.SQLErrText)
		SQLCa.Of_Rollback( )
		Return False
	End If
	
	w_ge450_aguarde.st_processo.Text	= "Atualizando Produtos Superior ao Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$e100$$ENDHEX$$ximo..."
	//Atualiza pre$$HEX1$$e700$$ENDHEX$$o dos produtos acima do pre$$HEX1$$e700$$ENDHEX$$o m$$HEX1$$e100$$ENDHEX$$ximo para o m$$HEX1$$e100$$ENDHEX$$ximo
	update precificacao_prd_regional
	set vl_preco_regionalizado = (select vl_preco_maximo from precificacao_prd pp1 where pp1.nr_precificacao = precificacao_prd_regional.nr_precificacao and pp1.cd_produto = precificacao_prd_regional.cd_produto)
	Where exists (	select 1 
						from precificacao_prd pp1 
						where pp1.nr_precificacao = precificacao_prd_regional.nr_precificacao 
						and pp1.cd_produto = precificacao_prd_regional.cd_produto
						and coalesce(pp1.vl_preco_maximo,0) > 0
						and pp1.vl_preco_maximo < precificacao_prd_regional.vl_preco_regionalizado)
		And nr_precificacao = :al_precificacao
	Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then
		This.Of_Grava_log( "Erro ao atualizar os produtos regionalizados superiores ao m$$HEX1$$e100$$ENDHEX$$ximo na fun$$HEX2$$e700e300$$ENDHEX$$o of_regionalizacao_preco().", SQLCa.SQLErrText)
		SQLCa.Of_Rollback( )
		Return False
	End If
	
	update precificacao
	set id_situacao						= "R", 
		 dh_regionalizacao 			= getDate(),
		 nr_matric_regionalizacao	= :gvo_aplicacao.ivo_seguranca.nr_matricula
	Where nr_precificacao 			= :al_precificacao
	Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then
		This.Of_Grava_log( "Erro ao atualizar status da precificacao, na fun$$HEX2$$e700e300$$ENDHEX$$o of_regionalizacao_preco().", SQLCa.SQLErrText)
		SQLCa.Of_RollBack()
		Return False
	End If 
	
Catch (RuntimeError lvo_Erro)
	This.Of_Grava_log( "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_regionalizacao_preco().", lvo_Erro.GetMessage())
	Return False

Finally
	If IsValid(w_ge450_aguarde) Then Close(w_ge450_aguarde)
End Try

Return True
end function

public function boolean of_regionalizacao_atualiza_faturamento (long al_precificacao, string as_tipo_precificacao, long al_tipo_precificacao);Long lvl_Linha
Long lvl_Linhas
Long lvl_Linha_Cid
Long lvl_Linhas_Cid
Long lvl_Produto
Long lvl_Cidade
Long lvl_Qtde_Faturada

String lvs_Rede_Filial
String lvs_UF

Decimal{2} lvdc_Preco_Bruto
Decimal{2} lvdc_Preco_Liquido
Decimal{2} lvdc_Faturamento_Bruto
Decimal{2} lvdc_Faturamento_Liquido

Datetime lvdh_Inicio
Datetime lvdh_Fim
Datetime lvdh_Aux

Try
	il_NR_Precificacao				= al_precificacao
	is_Desc_Tipo_Precificacao	= as_tipo_precificacao
	il_Tipo_Precificacao			= al_tipo_precificacao
	
	dc_uo_ds_base lvds_1
	lvds_1 = Create dc_uo_ds_base
	If Not lvds_1.Of_changedataobject("ds_ge450_prod_faturamento_regional", False) Then
		This.Of_Grava_Log("Falha ao trocar para a DW ds_ge450_prod_faturamento_regional, na fun$$HEX2$$e700e300$$ENDHEX$$o of_regionalizacao_atualiza_faturamento().", lvds_1.ivo_dberror.ivs_sqlerrtext)
		Return False
	End If
	
	If Not IsValid(w_ge450_aguarde) Then Open(w_ge450_aguarde)
	
	w_ge450_aguarde.uo_progress.of_SetStart()
	w_ge450_aguarde.Title 					= "Executando Precifica$$HEX2$$e700e300$$ENDHEX$$o [" + String(il_NR_Precificacao) + "] ..."
	w_ge450_aguarde.st_calculo.Text		= "C$$HEX1$$e100$$ENDHEX$$lculo: "  + is_Desc_Tipo_Precificacao
	w_ge450_aguarde.st_processo.Text	= "Atualizando Faturamento / Pre$$HEX1$$e700$$ENDHEX$$o Regionalizado..."
	
	lvl_Linhas = ids_preco_cidade.Retrieve(il_NR_Precificacao)
	
	w_ge450_aguarde.uo_Progress.Of_SetMax(lvl_Linhas)
	
	If lvl_Linhas > 0 Then
		lvdh_Aux		= ids_preco_cidade.Object.dh_inicio	[1]
		lvdh_Fim		= Datetime(RelativeDate(gf_primeiro_dia_mes(Date(lvdh_Aux)), -1))
		lvdh_Inicio	= Datetime(gf_primeiro_dia_mes(RelativeDate(Date(lvdh_Fim), -90)))
		
		For lvl_Linha = 1 To lvl_Linhas
			lvl_Produto		= ids_preco_cidade.Object.cd_produto 		[lvl_Linha]
			lvs_Rede_Filial	= ids_preco_cidade.Object.id_rede_filial		[lvl_Linha]
			lvs_UF			= ids_preco_cidade.Object.cd_uf				[lvl_Linha]
			
			lvl_Linhas_Cid = lvds_1.Retrieve(lvdh_Inicio, lvdh_Fim, lvl_Produto, lvs_Rede_Filial, lvs_UF)
			
			For lvl_Linha_Cid = 1 To lvl_Linhas_Cid
				lvl_Cidade						= lvds_1.Object.cd_cidade					[lvl_Linha_Cid]
				lvl_Qtde_Faturada				= lvds_1.Object.qt_faturada					[lvl_Linha_Cid]
				lvdc_Preco_Bruto				= lvds_1.Object.vl_preco_bruto				[lvl_Linha_Cid]
				lvdc_Preco_Liquido			= lvds_1.Object.vl_preco_liquido			[lvl_Linha_Cid]
				lvdc_Faturamento_Bruto		= lvds_1.Object.vl_faturamento_bruto	[lvl_Linha_Cid]
				lvdc_Faturamento_Liquido	= lvds_1.Object.vl_faturamento_liquido	[lvl_Linha_Cid]
				
				update precificacao_prd_regional
				set 	qt_faturada 							= :lvl_Qtde_Faturada,
						vl_preco_bruto						= :lvdc_Preco_Bruto,
						vl_preco_liquido					= :lvdc_Preco_Liquido,
						vl_faturamento_anual_bruto		= :lvl_Qtde_Faturada * :lvdc_Preco_Bruto,
						vl_faturamento_anual_liquido	= :lvl_Qtde_Faturada * :lvdc_Preco_Liquido
				Where nr_precificacao = :il_NR_Precificacao
					And cd_produto	= :lvl_Produto
					And cd_cidade 		= :lvl_Cidade
					And id_rede_filial	= :lvs_Rede_Filial
					And cd_uf			= :lvs_UF
				Using SQLCa;
				
				If SQLCa.SQLCode = -1 Then
					This.Of_Grava_log( "Falha ao atualizar as informa$$HEX2$$e700f500$$ENDHEX$$es de faturamento do produto "+String(lvl_Produto)+" para a cidade "+String(lvl_Cidade) + &
											", na fun$$HEX2$$e700e300$$ENDHEX$$o of_regionalizacao_atualiza_faturamento().", SQLCa.SQLErrText)
					SQLCa.Of_RollBack()
					Return False
				End If
			Next
			
			w_ge450_aguarde.uo_Progress.Of_SetProgress( lvl_Linha )
		Next
		
		update precificacao
		set id_situacao = 'F'
		Where nr_precificacao = :il_NR_Precificacao
		Using SQLCa;
		
		If SQLCa.SQLCode = -1 Then
			This.Of_Grava_log( "Falha ao atualizar o status da precificacao, na fun$$HEX2$$e700e300$$ENDHEX$$o of_regionalizacao_atualiza_faturamento().", SQLCa.SQLErrText)
			SQLCa.Of_RollBack()
			Return False
		End If
	End If

Catch (RuntimeError lvo_Erro)
	This.Of_Grava_log( "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_regionalizacao_atualiza_faturamento().", lvo_Erro.GetMessage())
	SQLCa.Of_RollBack()
	Return False
	
Finally
	If IsValid(lvds_1) Then Destroy(lvds_1)
	If IsValid(w_ge450_aguarde) Then Close(w_ge450_aguarde)
End Try

Return True
end function

private function boolean of_preco_liquido_medicamento (long al_produto, string as_uf, string as_rede, date adh_inicio, date adh_termino, decimal adc_preco_atual, ref decimal adc_preco_liquido);Long ll_Linhas, ll_Linha, ll_Elemento, ll_Elemento_2

Decimal ldc_PC_Desc

String ls_MSG

try
	//O sistema pega a mediana dos percentuais de desconto do $$HEX1$$fa00$$ENDHEX$$ltimo ano
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge450_mediana_perc_desc", False) Then 
		
		This.of_Grava_Log("Erro na troca da dw [ds_ge450_mediana_perc_desc].", lds.ivo_dberror.ivs_sqlerrtext, ivs_Subcategoria, al_produto)
		Return False
	End If
			
	ll_Linhas = lds.Retrieve(al_Produto, as_UF, as_Rede, adh_inicio, adh_termino)
	
	If al_produto = 691970 Then
		al_produto = al_produto
	End If
				
	If ll_Linhas > 0 Then
		
		// Identificar se $$HEX1$$e900$$ENDHEX$$ PAR
		If Mod(ll_Linhas, 2) = 0 Then
			ll_Elemento 		= ll_Linhas / 2
			ll_Elemento_2 	= ll_Elemento + 1
			
			ldc_PC_Desc = round((lds.Object.pc_desconto[ll_Elemento] + lds.Object.pc_desconto[ll_Elemento_2]) / 2, 2)
		Else
			//Agora conte a quantidade de elementos, some 1 e divide por 2. O resultado $$HEX1$$e900$$ENDHEX$$ o n$$HEX1$$fa00$$ENDHEX$$mero do elemento.
			ll_Elemento = (ll_Linhas + 1) / 2
			
			// Mediana
			ldc_PC_Desc = lds.Object.pc_desconto[ll_Elemento]
		End If
		
		If ldc_PC_Desc > 0 Then
			adc_preco_liquido =  round(adc_preco_atual * ((100 - ldc_PC_Desc) / 100), 2)
		Else
			adc_preco_liquido = adc_preco_atual
		End If
						
	ElseIf ll_Linhas < 0 Then
		SqlCa.of_RollBack();
		of_Grava_Log("Erro ao recuperar os percentuais de desconto para o c$$HEX1$$e100$$ENDHEX$$lculo do pre$$HEX1$$e700$$ENDHEX$$o l$$HEX1$$ed00$$ENDHEX$$quido.", '', ivs_Subcategoria, al_produto)
		Return False
	End If
	
finally
	If IsValid(lds) Then Destroy lds
end try

Return True
end function

public function boolean of_preco_psicologico_left (decimal adc_preco, decimal adc_preco_minimo, decimal adc_preco_maximo, ref decimal adc_preco_psicologico);/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																										//
//															Pre$$HEX1$$e700$$ENDHEX$$o Psicol$$HEX1$$f300$$ENDHEX$$gico - LEFT DIGIT																		//
//																																										//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	REGRAS:																																							//
//			Este tipo de arredondamento tem como objetivo reduzir o pre$$HEX1$$e700$$ENDHEX$$o quando houver altera$$HEX2$$e700e300$$ENDHEX$$o do d$$HEX1$$ed00$$ENDHEX$$gito da extrema 				//
//			esquerda do Pre$$HEX1$$e700$$ENDHEX$$o. A redu$$HEX2$$e700e300$$ENDHEX$$o m$$HEX1$$e100$$ENDHEX$$xima de de pre$$HEX1$$e700$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ de at$$HEX1$$e900$$ENDHEX$$ 2%. A regra $$HEX1$$e900$$ENDHEX$$ exemplificada abaixo:								//
//				$$HEX1$$2220$$ENDHEX$$	60,15 => 59,90 (var. -0,4%)																												//
//				$$HEX1$$2220$$ENDHEX$$	20,03 => 19,90 (var. -2,0%)																												//
//				$$HEX1$$2220$$ENDHEX$$	30,53 => 30,53 (var. para 29,90: -2,1%)																								//
//																																										//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	CONSIDERA$$HEX2$$c700d500$$ENDHEX$$ES																																				//
//		2018.02.19	- 	Conforme email de Rafael Paz, em acordo com Felipe Loro, quando poss$$HEX1$$ed00$$ENDHEX$$vel arrendondar para 0.99, em	 	//
//							valores inferiores a 10.00.																											//
//																																										//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Decimal{2} lvdc_Aux

Try
	//Pre$$HEX1$$e700$$ENDHEX$$o psicol$$HEX1$$f300$$ENDHEX$$gico ser$$HEX1$$e100$$ENDHEX$$ o mesmo caso n$$HEX1$$e300$$ENDHEX$$o seja poss$$HEX1$$ed00$$ENDHEX$$vel aplicar a redu$$HEX2$$e700e300$$ENDHEX$$o
	adc_preco_psicologico = adc_preco
	
	//Aplica a varia$$HEX2$$e700e300$$ENDHEX$$o m$$HEX1$$e100$$ENDHEX$$xima poss$$HEX1$$ed00$$ENDHEX$$vel para verificar se h$$HEX1$$e100$$ENDHEX$$ mudan$$HEX1$$e700$$ENDHEX$$a de d$$HEX1$$ed00$$ENDHEX$$gito da esquerda
	lvdc_Aux = Round(adc_preco - (adc_preco * 0.02), 2)
	
	//Verifica se a redu$$HEX2$$e700e300$$ENDHEX$$o aplicada ao valor alterou o d$$HEX1$$ed00$$ENDHEX$$gito da esquerda
	If Mid(String(adc_preco, '######0.00'), 1, 1) <> Mid(String(lvdc_Aux, '######0.00'), 1, 1) Then
		//Trunca os centavos e reduz 1.00
		lvdc_Aux = Truncate(adc_preco, 0) - 1
		//Reduz 1.00 at$$HEX1$$e900$$ENDHEX$$ alterar o d$$HEX1$$ed00$$ENDHEX$$gito da esquerda
		Do While Mid(String(adc_preco, '######0.00'), 1, 1) = Mid(String(lvdc_Aux, '######0.00'), 1, 1)
			lvdc_Aux -= 1
		Loop
		//Adiciona o final 0.90
		lvdc_Aux = lvdc_Aux + 0.90
		//Somente $$HEX1$$e900$$ENDHEX$$ deve ser aceito redu$$HEX2$$e700f500$$ENDHEX$$es, e valores positivos
		If (lvdc_Aux < adc_preco) and (lvdc_Aux > 0) Then
			If (1 - Round(lvdc_Aux / adc_preco, 4)) <= 0.02 Then
				adc_preco_psicologico = lvdc_Aux
			
			//Tenta alterar o d$$HEX1$$ed00$$ENDHEX$$gito da esquerda arredondando o valor do pre$$HEX1$$e700$$ENDHEX$$o para 0,99, somente at$$HEX1$$e900$$ENDHEX$$ 9,99.
			ElseIf lvdc_Aux <= 9.99 Then
				//Caso n$$HEX1$$e300$$ENDHEX$$o o percentual de redu$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o pscol$$HEX1$$f300$$ENDHEX$$gico com o valor terminado em .90 tenha ficado superior ao 2%, tenta com .99
				lvdc_Aux = Truncate(lvdc_Aux, 0) + 0.99
				//Somente $$HEX1$$e900$$ENDHEX$$ deve ser aceito redu$$HEX2$$e700f500$$ENDHEX$$es, e valores positivos
				If (lvdc_Aux < adc_preco) and (lvdc_Aux > 0) Then
					//Verifica se o valor est$$HEX1$$e100$$ENDHEX$$ dentro do limite de  2%
					If (1 - Round(lvdc_Aux / adc_preco, 4)) <= 0.02 Then
						adc_preco_psicologico = lvdc_Aux
					End If
				End If
			End If
		End If
	End If
	
	//Verifica pre$$HEX1$$e700$$ENDHEX$$o m$$HEX1$$ed00$$ENDHEX$$nimo e m$$HEX1$$e100$$ENDHEX$$ximo, caso exceda respeita o pre$$HEX1$$e700$$ENDHEX$$o da regionaliza$$HEX2$$e700e300$$ENDHEX$$o
	If 	(Not IsNull(adc_preco_minimo) and (adc_preco_minimo > 0.00) and (adc_preco_psicologico < adc_preco_minimo)) or &
		(Not IsNull(adc_preco_maximo) and (adc_preco_maximo > 0.00)  and (adc_preco_psicologico > adc_preco_maximo)) Then
		adc_preco_psicologico = adc_preco
	End If
	
Catch (RuntimeError lvo_Erro)
	This.Of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_psicologico_left().", lvo_Erro.GetMessage())
	Return False
End Try

Return True
end function

private function boolean of_atualiza_preco_minimo_marca_subcat (long al_produto, string as_uf, string as_rede_filial, date adt_inicio, date adt_termino, string as_subcategoria, string as_lei_generico, decimal adc_custo_medio);/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																										//
//										Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo - MARCAS DENTRO DA MESMA SUBCATEGORIA													//
//																																										//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	REGRAS:																																							//
//			6 - MARCAS DENTRO DA MESMA SUBCATEGORIA:																							//
//					Esta regra tem como objetivo avaliar a margem praticada pelas marcas com menor venda em compara$$HEX2$$e700e300$$ENDHEX$$o das 		//
//					marcas com maior giro. Para isso, deve-se avaliar a margem das marcas que representam pelo menos 80% da 		//
//					quantidade vendida, ou seja, se um conjunto de marcas somar 79,9% das vendas, $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio contemplar 			//
//					pelo menos mais uma marca para completar pelo menos 80%, podendo ultrapassar 80% das vendas. 					//
//					Este c$$HEX1$$e100$$ENDHEX$$lculo utiliza a quantidade vendida dos $$HEX1$$fa00$$ENDHEX$$ltimos 3 meses.																		//
//						$$HEX1$$2220$$ENDHEX$$	Avalia$$HEX2$$e700e300$$ENDHEX$$o das marcas que representam 80% das vendas;																	//
//						$$HEX1$$2220$$ENDHEX$$	Deve-se calcular a margem m$$HEX1$$e900$$ENDHEX$$dia ponderada das marcas que representam pelo menos 80% das vendas.		//
//							Para o exemplo, foi considerado as marcas JOHNSON&JOHNSON, DOVE E NIVEA para calcular a margem, 		//
//							resultando em 29,1%.																												//
//						$$HEX1$$2220$$ENDHEX$$	Para as marcas que representam 20% das vendas deve-se comparar a margem dos $$HEX1$$fa00$$ENDHEX$$ltimos 3 meses com a 	//
//							margem m$$HEX1$$e900$$ENDHEX$$dia calculada;																											//
//					O Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo para os SKUs das marcas deve ser o custo m$$HEX1$$e900$$ENDHEX$$dio dos $$HEX1$$fa00$$ENDHEX$$ltimos 3 meses acrescendo a margem 		//
//					m$$HEX1$$e900$$ENDHEX$$dia das marcas que representam 80% das vendas, como no exemplo abaixo para o SKU SAB PHEBO 100G 			//
//					TUBEROSA EGITO:																															//
//						$$HEX1$$2220$$ENDHEX$$	Custo: R$2,69																															//
//						$$HEX1$$2220$$ENDHEX$$	Margem M$$HEX1$$ed00$$ENDHEX$$nima: 29,1%																												//
//						$$HEX1$$2220$$ENDHEX$$	Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo: R$ 3,79 [2,69 / (1- 29,1%)]																						//
//																																										//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Long lvl_Find
Long lvl_Linha
Long lvl_Linhas
Longlong lvl_Qtde
Longlong lvl_Qtde_Total = 0
Decimal lvdc_Pc_Margem
Decimal lvdc_Pc_Margem_Pond
Decimal lvdc_Pc_Total_Particip = 0.00
Decimal lvdc_Pc_Particip
Decimal{2} lvdc_Minimo

Try
	lvl_Find = ids_marcas_sub_proc.Find("cd_subcategoria='"+as_subcategoria+"' and id_lei_generico = '"+as_lei_generico+"'", 1, ids_marcas_sub_proc.RowCount())
	
	If lvl_Find < 0 Then
		This.Of_Grava_log( "Falha ao localizar a margem no datasource para o produto "+String(al_produto)+ " na fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_preco_minimo_marca_subcat().", "Erro "+ids_marcas_sub_proc.ivo_dberror.ivs_sqlerrtext, as_subcategoria, al_produto)
		Return False
	End If

	//Caso n$$HEX1$$e300$$ENDHEX$$o exista processa a subcategoria para localizar a margem m$$HEX1$$e900$$ENDHEX$$dia ponderada das marcas de maior vendas
	If lvl_Find = 0 Then
		//Recupera as informa$$HEX2$$e700f500$$ENDHEX$$es por marca dessa subcategoria e lei generico
		lvl_Linhas = ids_marcas_subcategoria.Retrieve(adt_inicio, adt_termino, as_subcategoria, as_lei_generico)
		If lvl_Linhas < 0 Then
			This.Of_Grava_log( "Falha ao recuperar as margens por marca da subcategoria "+as_subcategoria+ " na fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_preco_minimo_marca_subcat().", "Erro "+ids_marcas_subcategoria.ivo_dberror.ivs_sqlerrtext, as_subcategoria, al_produto)
			Return False
		End If		
		
		//Percorre os registros para identificar at$$HEX1$$e900$$ENDHEX$$ qual linha dever$$HEX1$$e100$$ENDHEX$$ ser considerada para o 80% 
		For lvl_Linha = 1 To lvl_Linhas
			//Acumula o % de participa$$HEX2$$e700e300$$ENDHEX$$o na quantidade vendida
			lvdc_Pc_Total_Particip	+= ids_marcas_subcategoria.Object.pc_qt_vendida	[lvl_Linha]
			//Acumula a quantidade das marcas que comp$$HEX1$$f500$$ENDHEX$$e o 80%
			lvl_Qtde_Total				+= ids_marcas_subcategoria.Object.qt_vendida		[lvl_Linha]
			
			//Quando o percentual alcan$$HEX1$$e700$$ENDHEX$$ar ou superar 80%
			If lvdc_Pc_Total_Particip >= 0.80 Then
				//Altera o total de linhas para a linha atual, para o pr$$HEX1$$f300$$ENDHEX$$ximo FOR
				lvl_Linhas = lvl_Linha
				//Sai deste FOR
				Exit
			End If
		Next
		
		//Faz um novo FOR somente nas marcas que comp$$HEX1$$f500$$ENDHEX$$em o 80% da qtde vendida
		For lvl_Linha = 1 To lvl_Linhas
			lvl_Qtde				= ids_marcas_subcategoria.Object.qt_vendida		[lvl_Linha]
			lvdc_Pc_Margem	= ids_marcas_subcategoria.Object.pc_margem	[lvl_Linha]
			
			lvdc_Pc_Margem_Pond += (lvdc_Pc_Margem * (lvl_Qtde / lvl_Qtde_Total))
		Next
		
		//Insere as informa$$HEX2$$e700f500$$ENDHEX$$es calculadas dessa subcategoria e lei gen$$HEX1$$e900$$ENDHEX$$rico para que os pr$$HEX1$$f300$$ENDHEX$$ximos produtos n$$HEX1$$e300$$ENDHEX$$o necessitem recalcular.
		lvl_Find = ids_marcas_sub_proc.InsertRow(0)
		ids_marcas_sub_proc.Object.cd_subcategoria		[lvl_Find] = as_subcategoria
		ids_marcas_sub_proc.Object.id_lei_generico		[lvl_Find] = as_lei_generico
		ids_marcas_sub_proc.Object.pc_margem_marca	[lvl_Find] = lvdc_Pc_Margem_Pond
	Else
		lvdc_Pc_Margem_Pond = ids_marcas_sub_proc.Object.pc_margem_marca [lvl_Find]
	End If
	
	If lvdc_Pc_Margem_Pond > 0 Then
		lvdc_Minimo = Round(adc_custo_medio / (1 - lvdc_Pc_Margem_Pond),2)
		If Not This.of_inclui_preco_minimo(al_produto, as_uf, as_rede_filial,  6, lvdc_Minimo) Then Return False
	End If
	
Catch (RuntimeError lvo_Erro)
	This.Of_Grava_log( "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_preco_minimo_marca_subcat().", lvo_Erro.GetMessage(), as_subcategoria, al_produto)
	Return False
	
End Try

Return True
end function

private function boolean of_atualiza_preco_minimo_marca_categ (long al_produto, string as_uf, string as_rede_filial, date adt_inicio, date adt_termino, string as_subcategoria, long al_marca, decimal adc_custo_medio);/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																										//
//						Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo - MESMA MARCA POR DIFERENTES SUBCATEGORIAS DENTRO CATEGORIA								//
//																																										//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	REGRAS:																																							//
//			7 - MESMA MARCA POR DIFERENTES SUBCATEGORIAS DENTRO CATEGORIA:															//
//					Esta regra tem como objetivo avaliar a margem para menores subcategorias considerando a mesma marca e 		//
//					categoria de produto. Nos exemplos abaixo, $$HEX1$$e900$$ENDHEX$$ feita a compara$$HEX2$$e700e300$$ENDHEX$$o das diferentes subcategorias que as marcas 		//
//					GRANADO e DOVE possuem para a categoria SANONETES:																			//
//						$$HEX1$$2220$$ENDHEX$$	GRANADO: 																																//
//							o	Maior subcategoria: Barra Tradicional																						//
//							o	Margem: 14% 																														//
//							o	Demais Subcategorias com margem maior que 14% 																		//
//						$$HEX1$$2220$$ENDHEX$$	DOVE: 																																	//
//							o	Maior subcategoria: Barra Tradicional																						//
//							o	Margem: 35% 																														//
//							o	Demais subcategorias com margem inferior devem aproximas o valor a 35% de margem. Como por 		//
//								exemplo, SAB DOVE BABY 75G HIDRATACAO ENRIQUECIDA com custo de R$ 1,81  e aplicando a 				//
//								margem de 35%, chega-se ao Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo de R$ 2,78 [1,81 / (1- 35%)].											//
//																																										//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Long lvl_Find
Long lvl_Linha
Long lvl_Linhas
Decimal lvdc_Pc_Margem
Decimal{2} lvdc_Minimo
String lvs_Categoria
String lvs_Subcategoria

Try
	lvs_Categoria = Mid(as_subcategoria, 1, 6)
	
	lvl_Find = ids_marcas_sub_cat_proc.Find("cd_categoria='"+lvs_Categoria+"' and cd_marca = "+String(al_marca), 1, ids_marcas_sub_cat_proc.RowCount())
	
	If lvl_Find < 0 Then
		This.Of_Grava_log( "Falha ao localizar a margem no datasource para o produto "+String(al_produto)+ " na fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_preco_minimo_marca_categ().", ids_marcas_sub_cat_proc.ivo_dberror.ivs_sqlerrtext, as_subcategoria, al_produto)
		Return False
	End If
	
	//Caso n$$HEX1$$e300$$ENDHEX$$o exista processa a subcategoria para localizar a margem m$$HEX1$$e900$$ENDHEX$$dia ponderada das marcas de maior vendas
	If lvl_Find = 0 Then
		//Recupera as informa$$HEX2$$e700f500$$ENDHEX$$es por marca dessa subcategoria e lei generico
		lvl_Linhas = ids_marcas_categoria.Retrieve(adt_inicio, adt_termino, al_marca, lvs_Categoria)
		If lvl_Linhas < 0 Then
			This.Of_Grava_log( "Falha ao recuperar as margens por subcategoria da marca "+String(al_marca)+ " e categoria "+lvs_Categoria+" na fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_preco_minimo_marca_categ().", ids_marcas_categoria.ivo_dberror.ivs_sqlerrtext, as_subcategoria, al_produto)
			Return False
		ElseIf lvl_Linhas = 0 Then
			This.Of_Grava_log( "N$$HEX1$$e300$$ENDHEX$$o foi encontrado faturamento para a categoria e marca do produto "+String(al_produto)+".", "", as_subcategoria, al_produto)
			Return True
		End If		

		lvdc_Pc_Margem	= ids_marcas_categoria.Object.pc_margem			[1]
		lvs_Subcategoria	= ids_marcas_categoria.Object.cd_subcategoria	[1]
		
		//Insere as informa$$HEX2$$e700f500$$ENDHEX$$es calculadas dessa subcategoria e lei gen$$HEX1$$e900$$ENDHEX$$rico para que os pr$$HEX1$$f300$$ENDHEX$$ximos produtos n$$HEX1$$e300$$ENDHEX$$o necessitem recalcular.
		lvl_Find = ids_marcas_sub_cat_proc.InsertRow(0)
		ids_marcas_sub_cat_proc.Object.cd_categoria		[lvl_Find] = lvs_Categoria
		ids_marcas_sub_cat_proc.Object.cd_subcategoria	[lvl_Find] = lvs_Subcategoria
		ids_marcas_sub_cat_proc.Object.cd_marca			[lvl_Find] = al_marca
		ids_marcas_sub_cat_proc.Object.pc_margem		[lvl_Find] = lvdc_Pc_Margem
	Else
		lvs_Subcategoria	= ids_marcas_sub_cat_proc.Object.cd_subcategoria	[lvl_Find]
		lvdc_Pc_Margem	= ids_marcas_sub_cat_proc.Object.pc_margem		[lvl_Find]
	End If
	
	If (lvdc_Pc_Margem > 0) and (lvs_Subcategoria <> as_subcategoria) Then
		lvdc_Minimo = Round(adc_custo_medio / (1 - lvdc_Pc_Margem),2)
		If Not This.of_inclui_preco_minimo(al_produto, as_uf, as_rede_filial,  7, lvdc_Minimo) Then Return False
	End If
	
Catch (RuntimeError lvo_Erro)
	This.Of_Grava_log( "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_preco_minimo_marca_categ().", lvo_Erro.GetMessage(), as_subcategoria, al_produto)
	Return False
	
End Try

Return True
end function

public function boolean of_calcula_preco_nao_med (string as_rede);Boolean lb_passa_proximo_registro

Long ll_Linha, ll_Linhas, ll_CD_Tipo_Prod

String ls_CD_SubCategoria, ls_DE_SubCategoria, ls_DE_Produto, ls_DE_Tipo_Produto, ls_Tipo_UN_Calc_Preco

try
	
	w_ge450_aguarde.uo_progress.of_SetStart()
	w_ge450_aguarde.st_processo.Text = "C$$HEX1$$e100$$ENDHEX$$lculo Pre$$HEX1$$e700$$ENDHEX$$o"
		
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge450_subcategoria_prod_tipo", False) Then 
		This.of_Grava_Log("Erro na troca da dw [ds_ge450_subcategoria_prod_tipo].", ' '+lds.ivo_dberror.ivs_sqlerrtext)
		Return False
	End If
			
	ll_Linhas = lds.Retrieve(il_NR_Precificacao)
	
	// Lista as subcategorias conforme SUBCATEGORIA/DESCRI$$HEX2$$c700c300$$ENDHEX$$O PRODUTO/TIPO PROD. PRICING
	If ll_Linhas > 0 Then
		
		w_ge450_aguarde.uo_progress.of_setmax(ll_Linhas)
								
		For ll_Linha = 1 To ll_Linhas
			
			ls_CD_SubCategoria  		= lds.Object.cd_subcategoria				[ll_Linha]
			ls_DE_SubCategoria  		= lds.Object.de_subcategoria				[ll_Linha]
			ll_CD_Tipo_Prod	 		= lds.Object.cd_tipo_produto_pricing		[ll_Linha]
			ls_DE_Tipo_Produto		= lds.Object.de_tipo_produto_pricing		[ll_Linha]
			ls_DE_Produto				= lds.Object.de_produto						[ll_Linha]
			ls_Tipo_UN_Calc_Preco	= lds.Object.id_tipo_un_calc_preco		[ll_Linha]
			
			//Atualiza chave de grava$$HEX2$$e700e300$$ENDHEX$$o de log
			ivs_Subcategoria = ls_CD_SubCategoria
			ivs_Chave =   "<b>SubCategoria:</b> "+ls_DE_SubCategoria+" ("+ls_CD_SubCategoria+")<br />"
			ivs_Chave += "<b>Descri$$HEX2$$e700e300$$ENDHEX$$o Prod.:</b> "+ls_DE_Produto+"<br />"
			ivs_Chave += "<b>Tipo Unid. Calc.:</b> "+ ls_Tipo_UN_Calc_Preco + " - "+ IIF(ls_Tipo_UN_Calc_Preco="Q","QUANTIDADE",IIF(ls_Tipo_UN_Calc_Preco="V","VOLUME","PESO"))+"<br />"
			ivs_Chave += "<b>Tipo Produto:</b> "+ ls_DE_Tipo_Produto+" ("+String(ll_CD_Tipo_Prod)+")<br />"
			
			//Calcula varia$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o conforme a apresenta$$HEX2$$e700e300$$ENDHEX$$o
			If Not This.of_Preco_Apresentacao_Nao_Medicamento(ls_CD_SubCategoria, ls_DE_Produto, ls_Tipo_UN_Calc_Preco, ll_CD_Tipo_Prod) Then Return False
			//Atualiza barra de progresso
			w_ge450_aguarde.uo_progress.of_SetProgress(ll_Linha)
		Next
		
		//Limpa chave de grava$$HEX2$$e700e300$$ENDHEX$$o de log
		ivs_Chave = ""
		//Unifica os pre$$HEX1$$e700$$ENDHEX$$os dos produtos com o mesmo grupo PRICING
		If Not This.Of_Preco_Unificado_Grupo_Pricing() Then Return False
		//Verifica pre$$HEX1$$e700$$ENDHEX$$os de produtos de marca pr$$HEX1$$f300$$ENDHEX$$pria
		If Not This.Of_Preco_Marca_Propria() Then Return False
		//Aplica o pre$$HEX1$$e700$$ENDHEX$$o psicol$$HEX1$$f300$$ENDHEX$$gico
		If Not This.Of_Preco_Psicologico() Then Return False
		//O produto indexado deve estar exatamente proporcional (desde que respeitado m$$HEX1$$ed00$$ENDHEX$$nimo), por isso deve ser feito ap$$HEX1$$f300$$ENDHEX$$s a aplica$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o psicol$$HEX1$$f300$$ENDHEX$$gico
		If Not This.Of_Preco_Produto_Indexado() Then Return False

	ElseIf ll_Linhas < 0 Then
		SqlCa.of_RollBack();
		of_Grava_Log("Erro - Recuperar a lista SUBCATEGORIA/DESCRI$$HEX2$$c700c300$$ENDHEX$$O PRODUTO/TIPO PROD. PRICING para o c$$HEX1$$e100$$ENDHEX$$lculo de pre$$HEX1$$e700$$ENDHEX$$o.", '')
		Return False
	End If
	
Catch (RuntimeError lvo_Erro)	
	This.Of_Grava_log( "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_calcula_preco_nao_med().", lvo_Erro.GetMessage())
	Return False
	
finally
	ivs_Chave = ""
	SetNull(ivs_Subcategoria)
	If IsValid(lds) Then Destroy lds
end try

Return True
end function

public function boolean of_preco_psicologico (long al_precificacao, long al_tipo_precificacao, string as_tipo_precificacao);/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																										//
//																Pre$$HEX1$$e700$$ENDHEX$$o Psicol$$HEX1$$f300$$ENDHEX$$gico - Municipio																	//
//																																										//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	REGRAS:																																							//
//			O pre$$HEX1$$e700$$ENDHEX$$o psicol$$HEX1$$f300$$ENDHEX$$gico fundamenta-se no modo como o consumidor associa o pre$$HEX1$$e700$$ENDHEX$$o com as caracter$$HEX1$$ed00$$ENDHEX$$sticas e atributos do 		//
//			produto (ou do servi$$HEX1$$e700$$ENDHEX$$o), e se torna um aliado devido $$HEX1$$e000$$ENDHEX$$ elevad$$HEX1$$ed00$$ENDHEX$$ssima quantidade de informa$$HEX2$$e700e300$$ENDHEX$$o gerada atualmente para 	//
//			que os consumidores tenham de processar o que $$HEX1$$e900$$ENDHEX$$ relevante para si. $$HEX1$$c900$$ENDHEX$$ aquele que, propositalmente, a empresa coloca 	//
//			com centavos (geralmente na casa dos noventa), n$$HEX1$$e300$$ENDHEX$$o exibindo valores $$HEX1$$1c20$$ENDHEX$$redondos$$HEX1$$1d20$$ENDHEX$$, e outra forma de identifica-lo $$HEX1$$e900$$ENDHEX$$ $$HEX1$$1c20$$ENDHEX$$pre$$HEX1$$e700$$ENDHEX$$o 	//
//			quebrado$$HEX1$$1d20$$ENDHEX$$. Exemplos deste tipo de pre$$HEX1$$e700$$ENDHEX$$o s$$HEX1$$e300$$ENDHEX$$o R$ 19,99, R$ 49,95 ou R$ 199,90.														//
//			Neste c$$HEX1$$e100$$ENDHEX$$lculo ser$$HEX1$$e300$$ENDHEX$$o considerados dois modelos:																								//
//				$$HEX1$$2220$$ENDHEX$$	LEFT DIGIT: Este tipo de arredondamento tem como objetivo reduzir o pre$$HEX1$$e700$$ENDHEX$$o quando houver altera$$HEX2$$e700e300$$ENDHEX$$o do d$$HEX1$$ed00$$ENDHEX$$gito da 	//
//					extrema esquerda do Pre$$HEX1$$e700$$ENDHEX$$o. A redu$$HEX2$$e700e300$$ENDHEX$$o m$$HEX1$$e100$$ENDHEX$$xima de de pre$$HEX1$$e700$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ de at$$HEX1$$e900$$ENDHEX$$ 2%. 														//
//				$$HEX1$$2220$$ENDHEX$$	ARREDONDAMENTO POR FAIXA DE PRE$$HEX1$$c700$$ENDHEX$$O: consiste em aplicar arredondamentos de pre$$HEX1$$e700$$ENDHEX$$o diferenciados pelo n$$HEX1$$ed00$$ENDHEX$$vel 	//
//					de pre$$HEX1$$e700$$ENDHEX$$o definido pelo modelo.																												//
//																																										//
//			A regra de LEFT DIGIT deve sempre prevalecer sobre a regra de ARREDONDAMENTO POR FAIXA DE PRE$$HEX1$$c700$$ENDHEX$$O quando o 		//
//			modelo LEFT DIGIT resultar na altera$$HEX2$$e700e300$$ENDHEX$$o do d$$HEX1$$ed00$$ENDHEX$$gito da extrema esquerda. Por exemplo, caso o algoritmo resulte no pre$$HEX1$$e700$$ENDHEX$$o 	//
//			de R$ 10,10 para determinado produto, o modelo LEFT DIGIT resultar$$HEX1$$e100$$ENDHEX$$ no pre$$HEX1$$e700$$ENDHEX$$o R$ 9,90 enquanto o modelo 					//
//			ARREDONDAMENTO POR FAIXA DE PRE$$HEX1$$c700$$ENDHEX$$O resulta no pre$$HEX1$$e700$$ENDHEX$$o R$ 10,09.																	//
//																																										//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Long lvl_Municipio
Long lvl_Produto
Long lvl_Linha
Long lvl_Linhas

String lvs_Subcategoria

Decimal{2} lvdc_Preco
Decimal{2} lvdc_Preco_Max
Decimal{2} lvdc_Preco_Min
Decimal{2} lvdc_Preco_Psicologico

il_Tipo_Precificacao			= al_tipo_precificacao
il_NR_Precificacao				= al_precificacao
is_Desc_Tipo_Precificacao	= as_tipo_precificacao

Try
	If Not IsValid(w_ge450_aguarde) Then Open(w_ge450_aguarde)
	
	dc_uo_ds_base lvds_Prod
	lvds_Prod = Create dc_uo_ds_base

	/* Aplica o pre$$HEX1$$e700$$ENDHEX$$o psicol$$HEX1$$f300$$ENDHEX$$gico por Munic$$HEX1$$ed00$$ENDHEX$$pio */
	If Not lvds_Prod.of_ChangeDataObject("ds_ge450_preco_psic_regional", False) Then 
		This.of_Grava_Log("Erro na troca da dw [ds_ge450_preco_psic_regional].", lvds_Prod.ivo_dberror.ivs_sqlerrtext)
		Return False
	End If
	
	lvl_Linhas = lvds_Prod.Retrieve(al_precificacao)
	If lvl_Linhas < 0 Then 
		This.of_Grava_Log("Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da dw [ds_ge450_preco_psic_regional].", lvds_Prod.ivo_dberror.ivs_sqlerrtext)
		SQLCa.Of_RollBack()
		Return False
	End If
	
	w_ge450_aguarde.uo_progress.of_SetStart()
	w_ge450_aguarde.Title 					= "Executando Precifica$$HEX2$$e700e300$$ENDHEX$$o [" + String(al_precificacao) + "] ..."
	w_ge450_aguarde.st_calculo.Text		= "C$$HEX1$$e100$$ENDHEX$$lculo: "  + as_tipo_precificacao
	w_ge450_aguarde.st_processo.Text	= "Aplicando Pre$$HEX1$$e700$$ENDHEX$$o Psicol$$HEX1$$f300$$ENDHEX$$gico por Munic$$HEX1$$ed00$$ENDHEX$$pio..."
	w_ge450_aguarde.uo_progress.of_SetMax(lvl_Linhas)
	
	For lvl_Linha = 1 To lvl_Linhas
		lvl_Municipio		= lvds_Prod.Object.cd_cidade			[lvl_Linha]
		lvl_Produto			= lvds_Prod.Object.cd_produto			[lvl_Linha]
		lvs_Subcategoria	= lvds_Prod.Object.cd_subcategoria	[lvl_Linha] 
		lvdc_Preco_Min		= lvds_Prod.Object.vl_preco_minimo	[lvl_Linha]
		lvdc_Preco_Max	= lvds_Prod.Object.vl_preco_maximo	[lvl_Linha]
		lvdc_Preco			= lvds_Prod.Object.vl_preco				[lvl_Linha]
		
		//Aplica o pre$$HEX1$$e700$$ENDHEX$$o pelo m$$HEX1$$e900$$ENDHEX$$todo LEFT DIGIT, para todos os tipos de precifica$$HEX2$$e700e300$$ENDHEX$$o
		If Not This.Of_Preco_Psicologico_Left(lvdc_Preco, lvdc_Preco_Min, lvdc_Preco_Max, ref lvdc_Preco_Psicologico) Then Return False
		
		//N$$HEX1$$e300$$ENDHEX$$o aplica o pre$$HEX1$$e700$$ENDHEX$$o pelo m$$HEX1$$e900$$ENDHEX$$todo FAIXA PRE$$HEX1$$c700$$ENDHEX$$O, para o tipos de precifica$$HEX2$$e700e300$$ENDHEX$$o medicamento RX
		If (lvdc_Preco_Psicologico = lvdc_Preco) and (al_tipo_precificacao <> 1) Then
			If Not This.Of_Preco_Psicologico_Faixa(lvdc_Preco, lvdc_Preco_Min, lvdc_Preco_Max, ref lvdc_Preco_Psicologico) Then Return False
		End If
		
		Update precificacao_prd_regional
		Set vl_preco_psicologico	= :lvdc_Preco_Psicologico,
			 vl_preco_final 			= :lvdc_Preco_Psicologico
		Where nr_precificacao	= :al_precificacao
			and cd_produto			= :lvl_Produto
			and cd_cidade			= :lvl_Municipio
		Using SQLCa;
		
		If SQLCa.SQLCode = -1 Then 
			This.of_Grava_Log("Erro ao atualizar o pre$$HEX1$$e700$$ENDHEX$$o psicol$$HEX1$$f300$$ENDHEX$$gico regionalizado para o produto "+String(lvl_Produto)+" e cidade "+String(lvl_Municipio)+".", SQLCa.SQLErrtext, lvs_Subcategoria, lvl_Produto, lvl_Municipio)
			SQLCa.Of_RollBack()
			Return False
		End If	
		
		w_ge450_aguarde.uo_progress.of_SetProgress(lvl_Linhas)
	Next
	
Catch (RuntimeError lvo_Erro)
	This.of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_psicologico().", lvo_Erro.GetMessage())
	SQLCa.Of_RollBack()
	Return False
	
Finally
	If IsValid(lvds_Prod) Then Destroy(lvds_Prod)
	If IsValid(w_ge450_aguarde) Then Close(w_ge450_aguarde)
	
End Try

Return True

end function

private function boolean of_preco_psicologico ();/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																										//
//																	Pre$$HEX1$$e700$$ENDHEX$$o Psicol$$HEX1$$f300$$ENDHEX$$gico - UF																		//
//																																										//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	REGRAS:																																							//
//			O pre$$HEX1$$e700$$ENDHEX$$o psicol$$HEX1$$f300$$ENDHEX$$gico fundamenta-se no modo como o consumidor associa o pre$$HEX1$$e700$$ENDHEX$$o com as caracter$$HEX1$$ed00$$ENDHEX$$sticas e atributos do 		//
//			produto (ou do servi$$HEX1$$e700$$ENDHEX$$o), e se torna um aliado devido $$HEX1$$e000$$ENDHEX$$ elevad$$HEX1$$ed00$$ENDHEX$$ssima quantidade de informa$$HEX2$$e700e300$$ENDHEX$$o gerada atualmente para 	//
//			que os consumidores tenham de processar o que $$HEX1$$e900$$ENDHEX$$ relevante para si. $$HEX1$$c900$$ENDHEX$$ aquele que, propositalmente, a empresa coloca 	//
//			com centavos (geralmente na casa dos noventa), n$$HEX1$$e300$$ENDHEX$$o exibindo valores $$HEX1$$1c20$$ENDHEX$$redondos$$HEX1$$1d20$$ENDHEX$$, e outra forma de identifica-lo $$HEX1$$e900$$ENDHEX$$ $$HEX1$$1c20$$ENDHEX$$pre$$HEX1$$e700$$ENDHEX$$o 	//
//			quebrado$$HEX1$$1d20$$ENDHEX$$. Exemplos deste tipo de pre$$HEX1$$e700$$ENDHEX$$o s$$HEX1$$e300$$ENDHEX$$o R$ 19,99, R$ 49,95 ou R$ 199,90.														//
//			Neste c$$HEX1$$e100$$ENDHEX$$lculo ser$$HEX1$$e300$$ENDHEX$$o considerados dois modelos:																								//
//				$$HEX1$$2220$$ENDHEX$$	LEFT DIGIT: Este tipo de arredondamento tem como objetivo reduzir o pre$$HEX1$$e700$$ENDHEX$$o quando houver altera$$HEX2$$e700e300$$ENDHEX$$o do d$$HEX1$$ed00$$ENDHEX$$gito da 	//
//					extrema esquerda do Pre$$HEX1$$e700$$ENDHEX$$o. A redu$$HEX2$$e700e300$$ENDHEX$$o m$$HEX1$$e100$$ENDHEX$$xima de de pre$$HEX1$$e700$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ de at$$HEX1$$e900$$ENDHEX$$ 2%. 														//
//				$$HEX1$$2220$$ENDHEX$$	ARREDONDAMENTO POR FAIXA DE PRE$$HEX1$$c700$$ENDHEX$$O: consiste em aplicar arredondamentos de pre$$HEX1$$e700$$ENDHEX$$o diferenciados pelo n$$HEX1$$ed00$$ENDHEX$$vel 	//
//					de pre$$HEX1$$e700$$ENDHEX$$o definido pelo modelo.																												//
//																																										//
//			A regra de LEFT DIGIT deve sempre prevalecer sobre a regra de ARREDONDAMENTO POR FAIXA DE PRE$$HEX1$$c700$$ENDHEX$$O quando o 		//
//			modelo LEFT DIGIT resultar na altera$$HEX2$$e700e300$$ENDHEX$$o do d$$HEX1$$ed00$$ENDHEX$$gito da extrema esquerda. Por exemplo, caso o algoritmo resulte no pre$$HEX1$$e700$$ENDHEX$$o 	//
//			de R$ 10,10 para determinado produto, o modelo LEFT DIGIT resultar$$HEX1$$e100$$ENDHEX$$ no pre$$HEX1$$e700$$ENDHEX$$o R$ 9,90 enquanto o modelo 					//
//			ARREDONDAMENTO POR FAIXA DE PRE$$HEX1$$c700$$ENDHEX$$O resulta no pre$$HEX1$$e700$$ENDHEX$$o R$ 10,09.																	//
//																																										//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Long lvl_Produto
Long lvl_Linha
Long lvl_Linhas

String lvs_Subcategoria

Decimal{2} lvdc_Preco
Decimal{2} lvdc_Preco_Max
Decimal{2} lvdc_Preco_Min
Decimal{2} lvdc_Preco_Psicologico

Try
	If Not IsValid(w_ge450_aguarde) Then Open(w_ge450_aguarde)
	w_ge450_aguarde.uo_progress.of_SetStart()
	w_ge450_aguarde.Title 					= "Executando Precifica$$HEX2$$e700e300$$ENDHEX$$o [" + String(il_NR_Precificacao) + "] ..."
	w_ge450_aguarde.st_calculo.Text		= "C$$HEX1$$e100$$ENDHEX$$lculo: "  + is_Desc_Tipo_Precificacao
	w_ge450_aguarde.st_processo.Text	= "Aplicando Pre$$HEX1$$e700$$ENDHEX$$o Psicol$$HEX1$$f300$$ENDHEX$$gico UF..."
	
	dc_uo_ds_base lvds_Prod
	lvds_Prod = Create dc_uo_ds_base
	
	/* Aplica o pre$$HEX1$$e700$$ENDHEX$$o psicol$$HEX1$$f300$$ENDHEX$$gico no pre$$HEX1$$e700$$ENDHEX$$o geral da UF */
	If Not lvds_Prod.of_ChangeDataObject("ds_ge450_preco_psic_uf", False) Then 
		This.of_Grava_Log("Erro na troca da dw [ds_ge450_preco_psic_uf].", lvds_Prod.ivo_dberror.ivs_sqlerrtext)
		Return False
	End If
	
	lvl_Linhas = lvds_Prod.Retrieve(il_NR_Precificacao)
	If lvl_Linhas < 0 Then 
		This.of_Grava_Log("Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da dw [ds_ge450_preco_psic_uf].", lvds_Prod.ivo_dberror.ivs_sqlerrtext)
		Return False
	End If
	
	w_ge450_aguarde.uo_progress.of_SetMax(lvl_Linhas)
	For lvl_Linha = 1 To lvl_Linhas
		lvl_Produto			= lvds_Prod.Object.cd_produto			[lvl_Linha]
		lvs_Subcategoria	= lvds_Prod.Object.cd_subcategoria	[lvl_Linha] 
		lvdc_Preco_Min		= lvds_Prod.Object.vl_preco_minimo	[lvl_Linha]
		lvdc_Preco_Max	= lvds_Prod.Object.vl_preco_maximo	[lvl_Linha]
		lvdc_Preco			= lvds_Prod.Object.vl_preco				[lvl_Linha]
		
		If lvl_Produto = 725754 or lvl_Produto = 725755 Then
			lvl_Produto = lvl_Produto
		End If
		
		If IsNull(lvdc_Preco) Then
			This.Of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel calcular o pre$$HEX1$$e700$$ENDHEX$$o psicol$$HEX1$$f300$$ENDHEX$$gico do produto "+String(lvl_Produto)+", pre$$HEX1$$e700$$ENDHEX$$o apresenta$$HEX2$$e700e300$$ENDHEX$$o nulo.", "", lvs_Subcategoria, lvl_Produto)
			Continue
		End If
		
		//Aplica o pre$$HEX1$$e700$$ENDHEX$$o pelo m$$HEX1$$e900$$ENDHEX$$todo LEFT DIGIT, para todos os tipos de precifica$$HEX2$$e700e300$$ENDHEX$$o
		If Not This.Of_Preco_Psicologico_Left(lvdc_Preco, lvdc_Preco_Min, lvdc_Preco_Max, ref lvdc_Preco_Psicologico) Then Return False
		
		//N$$HEX1$$e300$$ENDHEX$$o aplica o pre$$HEX1$$e700$$ENDHEX$$o pelo m$$HEX1$$e900$$ENDHEX$$todo FAIXA PRE$$HEX1$$c700$$ENDHEX$$O, para o tipos de precifica$$HEX2$$e700e300$$ENDHEX$$o medicamento RX
		If (lvdc_Preco_Psicologico = lvdc_Preco) and (il_Tipo_Precificacao <> 1) Then
			If Not This.Of_Preco_Psicologico_Faixa(lvdc_Preco, lvdc_Preco_Min, lvdc_Preco_Max, ref lvdc_Preco_Psicologico) Then Return False
		End If
	
		Update precificacao_prd
		Set vl_preco_psicologico	= :lvdc_Preco_Psicologico,
			 vl_preco_final 			= :lvdc_Preco_Psicologico
		Where nr_precificacao	= :il_NR_Precificacao
			and cd_produto			= :lvl_Produto
		Using SQLCa;
		
		If SQLCa.SQLCode = -1 Then 
			This.of_Grava_Log("Erro ao atualizar o pre$$HEX1$$e700$$ENDHEX$$o psicol$$HEX1$$f300$$ENDHEX$$gico UF para o produto "+String(lvl_Produto)+".", SQLCa.SQLErrtext, lvs_Subcategoria, lvl_Produto)
			SQLCa.Of_RollBack()
			Return False
		End If	
		
		w_ge450_aguarde.uo_progress.of_SetProgress(lvl_Linhas)
	Next
	
Catch (RuntimeError lvo_Erro)
	This.of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_psicologico().", lvo_Erro.GetMessage())
	SQLCa.Of_RollBack()
	Return False
	
Finally
	If IsValid(lvds_Prod) Then Destroy(lvds_Prod)
	If IsValid(w_ge450_aguarde) Then Close(w_ge450_aguarde)
	
End Try

Return True

end function

private function boolean of_preco_apresentacao_nao_medicamento (string as_subcategoria, string as_descricao, string as_tipo_un_calc_preco, long al_tipo_produto_pricing);///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																																//
//																			II.	Pre$$HEX1$$e700$$ENDHEX$$o por Apresenta$$HEX2$$e700e300$$ENDHEX$$o (2.II)																			//
//																																																//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	REGRAS:																																													//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//				Ap$$HEX1$$f300$$ENDHEX$$s o c$$HEX1$$e100$$ENDHEX$$lculo de Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo para os SKUs, a apresenta$$HEX2$$e700e300$$ENDHEX$$o com maior faturamento l$$HEX1$$ed00$$ENDHEX$$quido (8) deve servir como base de c$$HEX1$$e100$$ENDHEX$$lculo para 	//
//			definir o pre$$HEX1$$e700$$ENDHEX$$o das demais apresenta$$HEX2$$e700f500$$ENDHEX$$es dos SKUs relativos com a seguinte combina$$HEX2$$e700e300$$ENDHEX$$o Subcategoria, Descri$$HEX2$$e700e300$$ENDHEX$$o Produto (sem 				//
//			apresenta$$HEX2$$e700e300$$ENDHEX$$o) e Tipo do Produto.																																			//
//			Para N$$HEX1$$e300$$ENDHEX$$o Medicamentos, a varia$$HEX2$$e700f500$$ENDHEX$$es das apresenta$$HEX2$$e700f500$$ENDHEX$$es s$$HEX1$$e300$$ENDHEX$$o calculadas proporcionalmente ao inv$$HEX1$$e900$$ENDHEX$$s da varia$$HEX2$$e700e300$$ENDHEX$$o absoluta entre as 				//
//			apresenta$$HEX2$$e700f500$$ENDHEX$$es para Medicamentos RX. A varia$$HEX2$$e700e300$$ENDHEX$$o proporcional $$HEX1$$e900$$ENDHEX$$ calculada sempre da maior apresenta$$HEX2$$e700e300$$ENDHEX$$o dividido pela menor 					//
//			apresenta$$HEX2$$e700e300$$ENDHEX$$o, independentemente do faturamento dos SKUs. Desta forma, a varia$$HEX2$$e700e300$$ENDHEX$$o sempre ser$$HEX1$$e100$$ENDHEX$$ um n$$HEX1$$fa00$$ENDHEX$$mero maior do que 1. 					//
//				A regra $$HEX1$$e900$$ENDHEX$$ de que produtos com maior apresenta$$HEX2$$e700e300$$ENDHEX$$o devem ter o pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio menor. Sendo assim, ao aplicar o % calculado sobre o 	//
//			valor unit$$HEX1$$e100$$ENDHEX$$rio da principal apresenta$$HEX2$$e700e300$$ENDHEX$$o deve-se saber se a varia$$HEX2$$e700e300$$ENDHEX$$o por apresenta$$HEX2$$e700f500$$ENDHEX$$es $$HEX1$$e900$$ENDHEX$$ negativa ou positiva.										//
//				Foram definidas 2 equa$$HEX2$$e700f500$$ENDHEX$$es para determinar a diferen$$HEX1$$e700$$ENDHEX$$a do pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio entre as apresenta$$HEX2$$e700f500$$ENDHEX$$es. Uma delas para apresenta$$HEX2$$e700e300$$ENDHEX$$o que 		//
//			varia Quantidade e outra que varia Peso ou Volume.																													//
//				Outra particularidade para N$$HEX1$$e300$$ENDHEX$$o Medicamentos $$HEX1$$e900$$ENDHEX$$ que foi definida uma $$HEX1$$e100$$ENDHEX$$rea em que a diferen$$HEX1$$e700$$ENDHEX$$a de pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio (1 + 2) entre 				//
//			apresenta$$HEX2$$e700f500$$ENDHEX$$es deve se posicionar. Se a varia$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio atual estiver dentro da $$HEX1$$e100$$ENDHEX$$rea definida o pre$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o deve alterar, caso 		//
//			contr$$HEX1$$e100$$ENDHEX$$rio o pre$$HEX1$$e700$$ENDHEX$$o deve alterar da seguinte maneira, considerando:																								//
//																																																//
//					Varia$$HEX2$$e700e300$$ENDHEX$$o Pre$$HEX1$$e700$$ENDHEX$$o Unit$$HEX1$$e100$$ENDHEX$$rio = 1 - ( (Pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio (maior apresenta$$HEX2$$e700e300$$ENDHEX$$o) ) / (Pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio (menor apresenta$$HEX2$$e700e300$$ENDHEX$$o) ) )							//
//						$$HEX1$$2220$$ENDHEX$$	Caso a varia$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio seja menor que 10%, a varia$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio deve ser 10%.										//
//						$$HEX1$$2220$$ENDHEX$$	Caso a varia$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio seja maior que 10%, a varia$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio vai depender da varia$$HEX2$$e700e300$$ENDHEX$$o proporcional 		//
//							das apresenta$$HEX2$$e700f500$$ENDHEX$$es. Caso atualmente esteja dentro da $$HEX1$$e100$$ENDHEX$$rea definida, o pre$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o deve ser alterado, caso contr$$HEX1$$e100$$ENDHEX$$rio a varia$$HEX2$$e700e300$$ENDHEX$$o 	//
//							do pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio deve ser no m$$HEX1$$e100$$ENDHEX$$ximo 30% para Quantidade e 40% para Volume e Peso.													//
//																																																//
//			As equa$$HEX2$$e700f500$$ENDHEX$$es s$$HEX1$$e300$$ENDHEX$$o detalhadas a seguir:																																	//
//				a)	Varia$$HEX2$$e700e300$$ENDHEX$$o Pre$$HEX1$$e700$$ENDHEX$$o Unit$$HEX1$$e100$$ENDHEX$$rio (Quantidade): 10% * Varia$$HEX2$$e700e300$$ENDHEX$$o Quantidade																						//
//					$$HEX1$$2220$$ENDHEX$$	Varia$$HEX2$$e700e300$$ENDHEX$$o m$$HEX1$$ed00$$ENDHEX$$nima de pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio: 10%																														//
//					$$HEX1$$2220$$ENDHEX$$	Varia$$HEX2$$e700e300$$ENDHEX$$o m$$HEX1$$e100$$ENDHEX$$xima de pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio: 30%																													//
//																																																//
//				b)	Varia$$HEX2$$e700e300$$ENDHEX$$o Pre$$HEX1$$e700$$ENDHEX$$o Unit$$HEX1$$e100$$ENDHEX$$rio (Volume/Peso): 15% * Varia$$HEX2$$e700e300$$ENDHEX$$o Volume/Peso $$HEX1$$1320$$ENDHEX$$ 5%																			//
//					$$HEX1$$2220$$ENDHEX$$	Varia$$HEX2$$e700e300$$ENDHEX$$o m$$HEX1$$ed00$$ENDHEX$$nima de pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio: 10%																														//
//					$$HEX1$$2220$$ENDHEX$$	Varia$$HEX2$$e700e300$$ENDHEX$$o m$$HEX1$$e100$$ENDHEX$$xima de pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio: 40%																													//
//																																																//
//				Ap$$HEX1$$f300$$ENDHEX$$s a aplica$$HEX2$$e700e300$$ENDHEX$$o das equa$$HEX2$$e700f500$$ENDHEX$$es nas apresenta$$HEX2$$e700f500$$ENDHEX$$es com menor faturamento (8) deve ser avaliado o Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo de cada SKU. Se o 		//
//			pre$$HEX1$$e700$$ENDHEX$$o calculado for menor que o Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo, o novo pre$$HEX1$$e700$$ENDHEX$$o deve ser igual ao Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo.																//
//			Exemplo de aplica$$HEX2$$e700e300$$ENDHEX$$o 1: ABS INTIMUS GEL (Subcategoria ABSORVENTES EXTERNOS)																		//
//																																																//
//				Para calcular o pre$$HEX1$$e700$$ENDHEX$$o por apresenta$$HEX2$$e700e300$$ENDHEX$$o deve-se comparar os produtos com a mesma combina$$HEX2$$e700e300$$ENDHEX$$o Subcategoria, Descri$$HEX2$$e700e300$$ENDHEX$$o Produto e 		//
//			Tipo do Produto. Neste caso, a apresenta$$HEX2$$e700e300$$ENDHEX$$o Noturno n$$HEX1$$e300$$ENDHEX$$o ter$$HEX1$$e100$$ENDHEX$$ compara$$HEX2$$e700e300$$ENDHEX$$o entre apresenta$$HEX2$$e700f500$$ENDHEX$$es. Para a apresenta$$HEX2$$e700f500$$ENDHEX$$es TIPO 1, a 				//
//			apresenta$$HEX2$$e700e300$$ENDHEX$$o com 16 unidades ser$$HEX1$$e100$$ENDHEX$$ a refer$$HEX1$$ea00$$ENDHEX$$ncia para definir a apresenta$$HEX2$$e700e300$$ENDHEX$$o com 32 unidades por ter maior faturamento l$$HEX1$$ed00$$ENDHEX$$quido. 				//
//																																																//
//				Como a varia$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio $$HEX1$$e900$$ENDHEX$$ menor que 10% [1 $$HEX1$$1320$$ENDHEX$$ (0,38/0,36)], a varia$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio deve ser de 10%. Sendo assim o 		//
//			pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio para a apresenta$$HEX2$$e700e300$$ENDHEX$$o de 32 deve ser de 0,32 [0,36 * (1 $$HEX1$$1320$$ENDHEX$$ 10%)] que resulta no pre$$HEX1$$e700$$ENDHEX$$o do SKU de R$ 10,26. Como o pre$$HEX1$$e700$$ENDHEX$$o 		//
//			calculado $$HEX1$$e900$$ENDHEX$$ menor que o Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo, o pre$$HEX1$$e700$$ENDHEX$$o final deve ser R$ 10,90.  																						//
//				Exemplo de aplica$$HEX2$$e700e300$$ENDHEX$$o 2: SAB LIQ ACTINE (Subcategoria SABONETE LIQUIDO ANTIACNE)																//
//																																																//
//				A varia$$HEX2$$e700e300$$ENDHEX$$o proporcional por apresenta$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ de 2,33 (maior apresenta$$HEX2$$e700e300$$ENDHEX$$o/menor apresenta$$HEX2$$e700e300$$ENDHEX$$o) [140/60]. Sendo assim, aplicando a 		//
//			varia$$HEX2$$e700e300$$ENDHEX$$o proporcional na equa$$HEX2$$e700e300$$ENDHEX$$o de varia$$HEX2$$e700e300$$ENDHEX$$o de Volume/Peso, encontramos a varia$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio de 30% [15% * 2,33 $$HEX1$$1320$$ENDHEX$$ 5%]. 		//
//			Sendo assim o pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio para a apresenta$$HEX2$$e700e300$$ENDHEX$$o de 60 ML deve ser 0,35 [0,27 * (1 + 30%)] que resulta no pre$$HEX1$$e700$$ENDHEX$$o de R$ 21,12, que $$HEX1$$e900$$ENDHEX$$ 		//
//			maior que o Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo.																																					//
//																																																//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	CONSIDERA$$HEX2$$c700d500$$ENDHEX$$ES:																																										//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//		1- Os pre$$HEX1$$e700$$ENDHEX$$os de produtos com fator de convers$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o tratados unitariamente, ou seja, o valor na precifica$$HEX2$$e700e300$$ENDHEX$$o estar$$HEX1$$e100$$ENDHEX$$ sempre dividido pelo 		//
//			fator de convers$$HEX1$$e300$$ENDHEX$$o. Sendo necess$$HEX1$$e100$$ENDHEX$$rio a gravar o pre$$HEX1$$e700$$ENDHEX$$o multiplicar pelo fator de convers$$HEX1$$e300$$ENDHEX$$o.																	//	
//		2- O m$$HEX1$$ed00$$ENDHEX$$nimo e m$$HEX1$$e100$$ENDHEX$$ximo s$$HEX1$$e300$$ENDHEX$$o tratados na DW, ou seja, o valor recuperado de vl_preco_bruto j$$HEX1$$e100$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ o valor bruto considerando o m$$HEX1$$ed00$$ENDHEX$$nimo calculado.	// 
//																																																//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Outras
Decimal{8} lvdc_Variacao_Geral
Decimal{8} lvdc_Variacao_Max
Decimal{8} lvdc_Variacao_Min
Long lvl_Linhas
Long lvl_Linha
Long lvl_Prod

//Vari$$HEX1$$e100$$ENDHEX$$veis Pre$$HEX1$$e700$$ENDHEX$$o Base
Decimal{8} lvdc_Preco_Unit_Base
Decimal{2} lvdc_Preco_Base
Decimal{3} lvdc_Qtde_Base
//Vari$$HEX1$$e100$$ENDHEX$$veis Pre$$HEX1$$e700$$ENDHEX$$o Analisado
Decimal{8} lvdc_Variacao_Preco_SKU
Decimal{8} lvdc_Variacao_SKU
Decimal{8} lvdc_Preco_Unit_SKU
Decimal{2} lvdc_Preco_SKU
Decimal{2} lvdc_Preco_Min_SKU
Decimal{2} lvdc_Preco_Max_SKU
Decimal{3} lvdc_Qtde_SKU
Decimal{2} lvdc_Preco_Novo_SKU
//Vari$$HEX1$$e100$$ENDHEX$$veis Pre$$HEX1$$e700$$ENDHEX$$o Maior Apresenta$$HEX2$$e700e300$$ENDHEX$$o
Decimal{2} lvdc_Preco_Maior
Decimal{3} lvdc_Qtde_Maior
//Vari$$HEX1$$e100$$ENDHEX$$veis Pre$$HEX1$$e700$$ENDHEX$$o Menor Apresenta$$HEX2$$e700e300$$ENDHEX$$o
Decimal{2} lvdc_Preco_Menor
Decimal{3} lvdc_Qtde_Menor


Try
	ivs_subcategoria = as_subcategoria
	w_ge450_aguarde.st_processo.Text = "C$$HEX1$$e100$$ENDHEX$$lculo Pre$$HEX1$$e700$$ENDHEX$$o - Varia$$HEX2$$e700e300$$ENDHEX$$o por Apresenta$$HEX2$$e700e300$$ENDHEX$$o"
	lvl_Linhas = ids_apresentacao_nao_med.Retrieve(il_NR_Precificacao, as_subcategoria, as_descricao, as_tipo_un_calc_preco, al_tipo_produto_pricing)
	
	If lvl_Linhas < 0 Then
		This.Of_Grava_Log("Falha ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es de produtos por apresenta$$HEX2$$e700e300$$ENDHEX$$o na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_apresentacao_nao_medicamento().", ids_apresentacao_nao_med.ivo_dberror.ivs_sqlerrtext, as_subcategoria)
		Return False
	ElseIf lvl_Linhas = 0 Then
		Return True
	End If
	
	//Somente se tiver mais de uma linha, caso contr$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ varia$$HEX2$$e700e300$$ENDHEX$$o
	If lvl_Linhas > 1 Then
		//Define os limites de varia$$HEX2$$e700e300$$ENDHEX$$o conforme a UNID. CALC.
		Choose Case as_tipo_un_calc_preco
			Case "Q"
				lvdc_Variacao_Min		= 0.10
				lvdc_Variacao_Max	= 0.30
				
			Case "V", "P"
				lvdc_Variacao_Min		= 0.10
				lvdc_Variacao_Max	= 0.40
				
			Case Else
				This.Of_Grava_Log("Tipo de Unidade C$$HEX1$$e100$$ENDHEX$$lculo de Pre$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o prevista para fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_apresentacao_nao_medicamento().", "Erro", as_subcategoria)
				Return False
		End Choose
		
		//Ordena por quantidade de apresenta$$HEX2$$e700e300$$ENDHEX$$o (Unid., Volume ou Peso)
		ids_apresentacao_nao_med.SetSort("qt_apresentacao desc, vl_preco_bruto desc")
		ids_apresentacao_nao_med.Sort()
		//Armazena o pre$$HEX1$$e700$$ENDHEX$$o e quantidade da maior apresenta$$HEX2$$e700e300$$ENDHEX$$o (1$$HEX1$$aa00$$ENDHEX$$ Linha)
		lvdc_Preco_Maior		= ids_apresentacao_nao_med.Object.vl_preco_bruto		[1]
		lvdc_Qtde_Maior		= ids_apresentacao_nao_med.Object.qt_apresentacao	[1]
		//Armazena o pre$$HEX1$$e700$$ENDHEX$$o e quantidade da menor apresenta$$HEX2$$e700e300$$ENDHEX$$o ($$HEX1$$da00$$ENDHEX$$ltima Linha)
		lvdc_Preco_Menor	= ids_apresentacao_nao_med.Object.vl_preco_bruto		[lvl_Linhas]	
		lvdc_Qtde_Menor	= ids_apresentacao_nao_med.Object.qt_apresentacao	[lvl_Linhas] 
		//Calcula a varia$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio existente entre o maior valor unit$$HEX1$$e100$$ENDHEX$$rio de apresenta$$HEX2$$e700e300$$ENDHEX$$o pelo menor
		lvdc_Variacao_Geral = (lvdc_Preco_Maior / lvdc_Qtde_Maior) / (lvdc_Preco_Menor / lvdc_Qtde_Menor) - 1
		//lvdc_Variacao_Geral = (lvdc_Preco_Maior / lvdc_Preco_Menor) - 1 
		
		//Tratamento de LIMITES
		//Se a varia$$HEX2$$e700e300$$ENDHEX$$o calculada for inferior ao limite m$$HEX1$$ed00$$ENDHEX$$nimo considera o m$$HEX1$$ed00$$ENDHEX$$nimo
		If lvdc_Variacao_Geral < lvdc_Variacao_Min Then lvdc_Variacao_Geral = lvdc_Variacao_Min
		//Se a varia$$HEX2$$e700e300$$ENDHEX$$o calculada for superior ao limite m$$HEX1$$e100$$ENDHEX$$ximo considera o m$$HEX1$$e100$$ENDHEX$$ximo
		If lvdc_Variacao_Geral > lvdc_Variacao_Max Then lvdc_Variacao_Geral = lvdc_Variacao_Max
		//Se o valor da varia$$HEX2$$e700e300$$ENDHEX$$o calculada for inferior ao m$$HEX1$$e100$$ENDHEX$$ximo, o m$$HEX1$$e100$$ENDHEX$$ximo assumir$$HEX1$$e100$$ENDHEX$$ essa varia$$HEX2$$e700e300$$ENDHEX$$o
		If lvdc_Variacao_Max > lvdc_Variacao_Geral Then lvdc_Variacao_Max = lvdc_Variacao_Geral
		
		//Ordena por faturamento liquido
		ids_apresentacao_nao_med.SetSort("vl_fat_liquido_anual desc")
		ids_apresentacao_nao_med.Sort()
		//Armazena os valores do produto com maior faturamento para servir de base o c$$HEX1$$e100$$ENDHEX$$lculo dos demais
		lvdc_Preco_Base		= ids_apresentacao_nao_med.Object.vl_preco_bruto		[1]
		lvdc_Qtde_Base		= ids_apresentacao_nao_med.Object.qt_apresentacao	[1]
		lvdc_Preco_Unit_Base	= (lvdc_Preco_Base / lvdc_Qtde_Base)
		
		//Inicia na segunda linha pois a primeira $$HEX1$$e900$$ENDHEX$$ o pre$$HEX1$$e700$$ENDHEX$$o base
		For lvl_Linha = 2 To lvl_Linhas
			lvl_Prod							= ids_apresentacao_nao_med.Object.cd_produto			[lvl_Linha]
			lvdc_Preco_SKU				= ids_apresentacao_nao_med.Object.vl_preco_bruto		[lvl_Linha]
			lvdc_Qtde_SKU					= ids_apresentacao_nao_med.Object.qt_apresentacao	[lvl_Linha]
			lvdc_Preco_Min_SKU			= ids_apresentacao_nao_med.Object.vl_preco_minimo	[lvl_Linha]
			lvdc_Preco_Max_SKU			= ids_apresentacao_nao_med.Object.vl_preco_maximo	[lvl_Linha]
			lvdc_Preco_Novo_SKU		= lvdc_Preco_SKU
			//Pre$$HEX1$$e700$$ENDHEX$$o do SKU na menor unidade de apresenta$$HEX2$$e700e300$$ENDHEX$$o (por unidade, mililitro ou grama)
			lvdc_Preco_Unit_SKU			= (lvdc_Preco_SKU / lvdc_Qtde_SKU)
			
			If lvdc_Qtde_Base <> lvdc_Qtde_SKU Then
				lvdc_Variacao_Preco_SKU 	= (lvdc_Preco_Unit_SKU / lvdc_Preco_Unit_Base) - 1
				
				//Se a varia$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio for maior que o m$$HEX1$$ed00$$ENDHEX$$nimo 10%, deve calcular a varia$$HEX2$$e700e300$$ENDHEX$$o por apresenta$$HEX2$$e700e300$$ENDHEX$$o
				If lvdc_Variacao_Geral > lvdc_Variacao_Min Then
					//Calcula a varia$$HEX2$$e700e300$$ENDHEX$$o por apresenta$$HEX2$$e700e300$$ENDHEX$$o, sempre a maior apresenta$$HEX2$$e700e300$$ENDHEX$$o pela menor
					Choose Case as_tipo_un_calc_preco
						Case "Q"
							If lvdc_Qtde_SKU > lvdc_Qtde_Base Then
								lvdc_Variacao_SKU = (0.10 * (lvdc_Qtde_SKU / lvdc_Qtde_Base))
							Else
								lvdc_Variacao_SKU = (0.10 * (lvdc_Qtde_Base / lvdc_Qtde_SKU))
							End If
							
						Case "V", "P"
							If lvdc_Qtde_SKU > lvdc_Qtde_Base Then
								lvdc_Variacao_SKU = (0.15 * (lvdc_Qtde_SKU / lvdc_Qtde_Base) - 0.05)
							Else
								lvdc_Variacao_SKU = (0.15 * (lvdc_Qtde_Base / lvdc_Qtde_SKU) - 0.05)
							End If
							
						Case Else
							This.Of_Grava_Log("Tipo de Unidade C$$HEX1$$e100$$ENDHEX$$lculo de Pre$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o prevista para fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_apresentacao_nao_medicamento().", "Erro", as_subcategoria, lvl_Prod)
							Return False
					End Choose
					//Verifica se a varia$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ dentro dos limites
					If lvdc_Variacao_SKU < lvdc_Variacao_Min Then lvdc_Variacao_SKU = lvdc_Variacao_Min
					If lvdc_Variacao_SKU > lvdc_Variacao_Max Then lvdc_Variacao_SKU = lvdc_Variacao_Max
				Else
					//Caso a varia$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o entre a maior e a menor apresenta$$HEX2$$e700e300$$ENDHEX$$o for inferior a 10%, deve usar o 10%
					lvdc_Variacao_SKU = lvdc_Variacao_Geral
				End If
				
				//Efetua a altera$$HEX2$$e700e300$$ENDHEX$$o somente se o produto estiver fora da $$HEX1$$e100$$ENDHEX$$rea de limite
				// 	se o SKU tiver maior apresenta$$HEX2$$e700e300$$ENDHEX$$o que o base a varia$$HEX2$$e700e300$$ENDHEX$$o deve ser negativada para reduzir o pre$$HEX1$$e700$$ENDHEX$$o
				If ((lvdc_Qtde_Base > lvdc_Qtde_SKU) and  (lvdc_Variacao_Preco_SKU > lvdc_Variacao_SKU) or (lvdc_Variacao_Preco_SKU < lvdc_Variacao_Min)) or &
					((lvdc_Qtde_SKU > lvdc_Qtde_Base) and  (lvdc_Variacao_Preco_SKU < (lvdc_Variacao_SKU * -1)) or (lvdc_Variacao_Preco_SKU > (lvdc_Variacao_Min * -1))) Then
					
					//Verifica se a varia$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ dentro dos limites (pode acontecer de produtos terem 5x ou mais de quantidade o que pode elevar o percentual al$$HEX1$$e900$$ENDHEX$$m do teto)
					If lvdc_Variacao_SKU > lvdc_Variacao_Max Then lvdc_Variacao_SKU = lvdc_Variacao_Max
					If lvdc_Variacao_SKU < lvdc_Variacao_Min Then lvdc_Variacao_SKU = lvdc_Variacao_Min
					//Se a quantidade do SKU analisado for superior o pre$$HEX1$$e700$$ENDHEX$$o deve ser inferior, por isso deve se inverter o sinal
					If lvdc_Qtde_SKU > lvdc_Qtde_Base Then lvdc_Variacao_SKU *= -1
					//C$$HEX1$$e100$$ENDHEX$$lcula o novo pre$$HEX1$$e700$$ENDHEX$$o do produto
					lvdc_Preco_Novo_SKU = Round(lvdc_Qtde_SKU * lvdc_Preco_Unit_Base * (1 + lvdc_Variacao_SKU), 2)
				End If
			End If
			
			//Verifica se o pre$$HEX1$$e700$$ENDHEX$$o calculado est$$HEX1$$e100$$ENDHEX$$ entre o m$$HEX1$$ed00$$ENDHEX$$nimo e m$$HEX1$$e100$$ENDHEX$$ximo
			If Not This.Of_verifica_preco_minimo_maximo( lvl_Prod, ref lvdc_Preco_Novo_SKU, lvdc_Preco_Min_SKU, lvdc_Preco_Max_SKU) Then Return False
			
			update precificacao_prd
			set vl_preco_apresentacao = :lvdc_Preco_Novo_SKU
			Where cd_produto			= :lvl_Prod
				And nr_precificacao	= :il_NR_Precificacao
			Using SQLCa;
			
			If SQLCa.SQLCode = -1 Then
				This.Of_Grava_Log( "Erro atualizar o pre$$HEX1$$e700$$ENDHEX$$o de apresenta$$HEX2$$e700e300$$ENDHEX$$o do produto "+String(lvl_Prod)+" na fun$$HEX2$$e700e300$$ENDHEX$$o: of_preco_apresentacao_nao_medicamento().", SQLCa.SQLErrText,  as_subcategoria, lvl_Prod)
				SQLCa.of_RollBack()
				Return False
			End If	
		Next
	End If
	
	//Executa a atualiza$$HEX2$$e700e300$$ENDHEX$$o para o primeiro produto, pois ele n$$HEX1$$e300$$ENDHEX$$o entra no FOR por ser o produto base
	lvl_Prod					= ids_apresentacao_nao_med.Object.cd_produto			[1]
	lvdc_Preco_Novo_SKU= ids_apresentacao_nao_med.Object.vl_preco_bruto		[1]
	lvdc_Preco_Min_SKU	= ids_apresentacao_nao_med.Object.vl_preco_minimo	[1]
	lvdc_Preco_Max_SKU	= ids_apresentacao_nao_med.Object.vl_preco_maximo	[1]
	
	//Verifica se o pre$$HEX1$$e700$$ENDHEX$$o calculado est$$HEX1$$e100$$ENDHEX$$ entre o m$$HEX1$$ed00$$ENDHEX$$nimo e m$$HEX1$$e100$$ENDHEX$$ximo
	If Not This.Of_verifica_preco_minimo_maximo( lvl_Prod, ref lvdc_Preco_Novo_SKU, lvdc_Preco_Min_SKU, lvdc_Preco_Max_SKU) Then Return False
	
	update precificacao_prd
	set vl_preco_apresentacao = :lvdc_Preco_Novo_SKU
	Where cd_produto			= :lvl_Prod
		And nr_precificacao	= :il_NR_Precificacao
	Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then
		This.Of_Grava_Log( "Erro atualizar o pre$$HEX1$$e700$$ENDHEX$$o de apresenta$$HEX2$$e700e300$$ENDHEX$$o do produto "+String(lvl_Prod)+" na fun$$HEX2$$e700e300$$ENDHEX$$o: of_preco_apresentacao_nao_medicamento().", SQLCa.SQLErrText,  as_subcategoria, lvl_Prod)
		SQLCa.of_RollBack()
		Return False
	End If			
	
Catch (RuntimeError lvo_Erro)
	This.Of_Grava_log( "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_apresentacao_nao_medicamento()." , lvo_Erro.GetMessage(),  as_subcategoria)
	Return False
	
Finally
	
End Try

Return True

end function

private function boolean of_preco_unificado_grupo_pricing ();/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																											//
//									III.	Unifica$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$o para produtos do mesmo Grupo de Pricing														//
//																																											//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	REGRAS:																																								//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//			Alguns SKUs devem ter o pre$$HEX1$$e700$$ENDHEX$$o igual, por exemplo, Fraldas (tamanho RN, P, M, G e GG) e Batom (diversas tonalidades). 		//
//		Com a classifica$$HEX2$$e700e300$$ENDHEX$$o destes grupos na base de dados, o pre$$HEX1$$e700$$ENDHEX$$o destes SKUs devem ser iguais. Por$$HEX1$$e900$$ENDHEX$$m caso um dos SKUs tenha		//
//		um pre$$HEX1$$e700$$ENDHEX$$o maior devido ao Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo calculado, o pre$$HEX1$$e700$$ENDHEX$$o para este grupo de produtos deve ser ponderado pela quantidade		//
//		vendida dos $$HEX1$$fa00$$ENDHEX$$ltimos 3 meses. No exemplo abaixo $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel observar um exemplo que ocorre a altera$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o de um dos 	//
//		produtos do mesmo grupo de Pricing:																													//
//																																											//
//			------------------------------------------------------------------------------------------------------------------------------------------		//																																									//
//			|									| Apresenta$$HEX2$$e700e300$$ENDHEX$$o	|				Qtde	|	   PRE$$HEX1$$c700$$ENDHEX$$O	| 	   PRE$$HEX1$$c700$$ENDHEX$$O	|	   PRE$$HEX1$$c700$$ENDHEX$$O	|						|		//
//			| Descri$$HEX2$$e700e300$$ENDHEX$$o Produto			| 			Venda| (ULT. 3 MESES)	| 	   BRUTO	| MIN	NOVO	|	PARCIAL	|	NOVO PRE$$HEX1$$c700$$ENDHEX$$O	|		//
//			|-------------------------------	|----------------	|--------------------	|-------------	|-------------	|-------------	|--------------------	|		//
//			| BASE MAYBELLINE FIT ME	|			100	|				120	|		38,00	|		37,00	|		38,00	|				38,10	|		//
//			| BASE MAYBELLINE FIT ME	|			120	|				145	|		38,00	|		37,00	|		38,00	|				38,10	|		//
//			| BASE MAYBELLINE FIT ME	|			140	|				  70	|		38,00	|		38,50	|		38,50	|				38,10	|		//
//			------------------------------------------------------------------------------------------------------------------------------------------		//
//																																											//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Long lvl_Linhas_Grupo
Long lvl_Linha_Grupo
Long lvl_Linhas_SKU
Long lvl_Linha_SKU
Long lvl_QT_Total_Vendido
Long lvl_QT_Vendido
Long lvl_Grupo_Pricing
Long lvl_Produto

String lvs_Grupo_Pricing
String lvs_Subcategoria

Decimal{2} lvdc_Preco_SKU
Decimal{8} lvdc_Preco_Ponderado

Try
	//Atualiza descri$$HEX2$$e700f500$$ENDHEX$$es da etapa da precifica$$HEX2$$e700e300$$ENDHEX$$o na tela de aguarde
	If Not IsValid(w_ge450_aguarde) Then Open(w_ge450_aguarde)
	w_ge450_aguarde.uo_progress.of_SetStart()
	w_ge450_aguarde.Title 					= "Executando Precifica$$HEX2$$e700e300$$ENDHEX$$o [" + String(il_NR_Precificacao) + "] ..."
	w_ge450_aguarde.st_calculo.Text		= "C$$HEX1$$e100$$ENDHEX$$lculo: "  + is_Desc_Tipo_Precificacao
	w_ge450_aguarde.st_processo.Text	= "Aplicando Unifica$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$os por Grupo Pricing..."
	//Recupera informa$$HEX2$$e700f500$$ENDHEX$$es
	lvl_Linhas_Grupo = ids_grupo_pricing.Retrieve(il_NR_Precificacao)
	If lvl_Linhas_Grupo < 0 Then
		This.Of_Grava_Log("Falha ao recuperar informa$$HEX2$$e700f500$$ENDHEX$$es na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_unificado_grupo_pricing().", "DW: ids_grupo_pricing~r"+ids_grupo_pricing.ivo_dberror.ivs_sqlerrtext)
		Return False
	End If
	
	//Atualiza m$$HEX1$$e100$$ENDHEX$$ximo de linhas para progresso
	w_ge450_aguarde.uo_progress.of_SetMax(lvl_Linhas_Grupo)
	
	//Executa para todos os grupos pricing existentes nessa precifica$$HEX2$$e700e300$$ENDHEX$$o
	For lvl_Linha_Grupo = 1 To lvl_Linhas_Grupo
		//Captura as informa$$HEX2$$e700f500$$ENDHEX$$es do grupo
		lvl_Grupo_Pricing 			= ids_grupo_pricing.Object.cd_grupo_alteracao_preco	[lvl_Linha_Grupo]
		lvs_Grupo_Pricing			= ids_grupo_pricing.Object.de_grupo_alteracao_preco	[lvl_Linha_Grupo]
		lvl_QT_Total_Vendido		= ids_grupo_pricing.Object.qt_vendida						[lvl_Linha_Grupo]
		
		//Seta a chave a ser gravada para eventuais logs
		ivs_Chave =   "<b>Grupo Pricing:</b> "+lvs_Grupo_Pricing+" ("+String(lvl_Grupo_Pricing)+")"
		
		//Recupera as informa$$HEX2$$e700f500$$ENDHEX$$es dos produtos existentes para esse grupo e precifica$$HEX2$$e700e300$$ENDHEX$$o
		lvl_Linhas_SKU = ids_preco_grupo_pricing.Retrieve(il_NR_Precificacao, lvl_Grupo_Pricing)
		If lvl_Linhas_SKU < 0 Then
			This.Of_Grava_Log("Falha ao recuperar informa$$HEX2$$e700f500$$ENDHEX$$es na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_unificado_grupo_pricing().", "DW: ids_preco_grupo_pricing~r"+ids_preco_grupo_pricing.ivo_dberror.ivs_sqlerrtext)
			Return False
		End If
	
		lvdc_Preco_Ponderado = 0
		//Executa para todos os produto existentes nesse grupos pricing
		For lvl_Linha_SKU= 1 To lvl_Linhas_SKU
			lvl_QT_Vendido		= ids_preco_grupo_pricing.Object.qt_vendida	[lvl_Linha_SKU]
			lvdc_Preco_SKU	= ids_preco_grupo_pricing.Object.vl_preco		[lvl_Linha_SKU]
			//Soma o pre$$HEX1$$e700$$ENDHEX$$o ponderado novo
			If lvdc_Preco_SKU > 0.00 Then
				//Se o pre$$HEX1$$e700$$ENDHEX$$o for maior que zero soma a pondera$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o do produto
				//	os produtos com valores zerados n$$HEX1$$e300$$ENDHEX$$o s$$HEX1$$e300$$ENDHEX$$o somados na quantidade total vendida para n$$HEX1$$e300$$ENDHEX$$o distorcer a m$$HEX1$$e900$$ENDHEX$$dia ponderada
				lvdc_Preco_Ponderado += Round(lvdc_Preco_SKU * (lvl_QT_Vendido / lvl_QT_Total_Vendido), 8)
			End If
		Next
		
		//Executa para todos os produto existentes nesse grupos pricing
		For lvl_Linha_SKU= 1 To lvl_Linhas_SKU
			lvl_Produto			= ids_preco_grupo_pricing.Object.cd_produto			[lvl_Linha_SKU]
			lvs_Subcategoria	= ids_preco_grupo_pricing.Object.cd_subcategoria	[lvl_Linha_SKU]
			
			Update precificacao_prd
			Set vl_preco_unificado	= round(:lvdc_Preco_Ponderado,2)
			Where nr_precificacao	= :il_NR_Precificacao
				and cd_produto			= :lvl_Produto
			Using SQLCa;
			
			If SQLCa.SQLCode = -1 Then 
				This.of_Grava_Log("Erro ao atualizar o pre$$HEX1$$e700$$ENDHEX$$o unificado para o produto "+String(lvl_Produto)+".", SQLCa.SQLErrText, lvs_Subcategoria, lvl_Produto)
				SQLCa.Of_RollBack()
				Return False
			End If	
		Next
		
		//Atualiza barra de progressos
		w_ge450_aguarde.uo_progress.of_SetProgress(lvl_Linha_Grupo)
	Next
	//Limpa a chave para n$$HEX1$$e300$$ENDHEX$$o haver logs gravados com chave incorreta
	ivs_Chave = ""
	
Catch (RuntimeError lvo_Erro)
	This.Of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_unificado_grupo_pricing().", lvo_Erro.GetMessage())
	Return False
	
Finally
	ivs_Chave = ""
	
End Try

Return True
end function

private function boolean of_preco_produto_indexado ();/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																											//
//													V.	Exece$$HEX2$$e700f500$$ENDHEX$$es algoritmo  ->	LEVE/PAGUE																		//
//																																											//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	REGRAS:																																								//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//			Com a identifica$$HEX2$$e700e300$$ENDHEX$$o na base de dados dos produtos leve e pague, Quantidade/Volume/Peso Pague e a menor apresenta$$HEX2$$e700e300$$ENDHEX$$o 	//
//		que deve ser utilizada para compara$$HEX2$$e700e300$$ENDHEX$$o. A regra $$HEX1$$e900$$ENDHEX$$ de multiplicar a Quantidade/Volume/Peso PAGUE pelo pre$$HEX1$$e700$$ENDHEX$$o da menor 			//
//		apresenta$$HEX2$$e700e300$$ENDHEX$$o. O Pre$$HEX1$$e700$$ENDHEX$$o final do Kit Leve Pague deve ser maior ou igual ao Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo definido. 										//
//																																											//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	CONSIDERA$$HEX2$$c700d500$$ENDHEX$$ES:																																					//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//			Essa fun$$HEX2$$e700e300$$ENDHEX$$o servir$$HEX1$$e100$$ENDHEX$$ para indexar o pre$$HEX1$$e700$$ENDHEX$$o de um produto a um outro produto, comumente ser$$HEX1$$e100$$ENDHEX$$ utilizada para o LEVE/PAGUE	//
//		mas poder$$HEX1$$e100$$ENDHEX$$ servir para precificar tamb$$HEX1$$e900$$ENDHEX$$m produtos de marca pr$$HEX1$$f300$$ENDHEX$$pria ou quaisquer outros produtos.										//
//																																											//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Long lvl_Linha
Long lvl_Linhas
Long lvl_Prod
Long lvl_Prod_Ref

String lvs_CD_Subcategoria
String lvs_DE_Subcategoria
String lvs_DE_Produto

Decimal{4} lvdc_PC_Fator_Ref
Decimal{2} lvdc_Preco_Prod_Ref
Decimal{2} lvdc_Preco_Novo
Decimal{2} lvdc_Preco_Min
Decimal{2} lvdc_Preco_Max

Try
	//Atualiza descri$$HEX2$$e700f500$$ENDHEX$$es da etapa da precifica$$HEX2$$e700e300$$ENDHEX$$o na tela de aguarde
	If Not IsValid(w_ge450_aguarde) Then Open(w_ge450_aguarde)
	w_ge450_aguarde.uo_progress.of_SetStart()
	w_ge450_aguarde.Title 					= "Executando Precifica$$HEX2$$e700e300$$ENDHEX$$o [" + String(il_NR_Precificacao) + "] ..."
	w_ge450_aguarde.st_calculo.Text		= "C$$HEX1$$e100$$ENDHEX$$lculo: "  + is_Desc_Tipo_Precificacao
	w_ge450_aguarde.st_processo.Text	= "Aplicando Pre$$HEX1$$e700$$ENDHEX$$os Indexados a Outros Produtos..."
	
	dc_uo_ds_base lvds_Prod
	lvds_Prod = Create dc_uo_ds_base
	If Not lvds_Prod.of_changedataobject("ds_ge450_preco_indexado", False) Then
		This.Of_Grava_Log("Falha na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_produto_indexado().","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel alterar para DW ds_ge450_preco_indexado. "+lvds_Prod.ivo_dberror.ivs_sqlerrtext)
		Return False
	End If
	
	lvl_Linhas = lvds_Prod.Retrieve(il_NR_Precificacao)
	If lvl_Linhas < 0 Then
		This.Of_Grava_Log("Falha ao recuperar informa$$HEX2$$e700f500$$ENDHEX$$es na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_produto_indexado().","DW ds_ge450_preco_indexado. "+lvds_Prod.ivo_dberror.ivs_sqlerrtext)
		Return False		
	End If
	
	For lvl_Linha = 1 To lvl_Linhas
		lvl_Prod 					= lvds_Prod.Object.cd_produto 					[lvl_Linha]
		lvs_DE_Produto			= lvds_Prod.Object.de_produto 					[lvl_Linha]
		lvl_Prod_Ref				= lvds_Prod.Object.cd_prod_referencia_preco	[lvl_Linha]
		lvdc_PC_Fator_Ref		= lvds_Prod.Object.pc_prod_referencia_preco	[lvl_Linha]
		lvs_CD_Subcategoria	= lvds_Prod.Object.cd_subcategoria				[lvl_Linha]		
		lvs_DE_Subcategoria	= lvds_Prod.Object.de_subcategoria				[lvl_Linha]	
		lvdc_Preco_Min			= lvds_Prod.Object.vl_preco_minimo				[lvl_Linha]
		lvdc_Preco_Max		= lvds_Prod.Object.vl_preco_maximo				[lvl_Linha]
		
		//Seta a chave a ser gravada para eventuais logs
		ivs_Chave =   "<b>Subcategoria:</b> "+lvs_DE_Subcategoria+" ("+lvs_CD_Subcategoria+")<br />"
		ivs_Chave += "<b>Produto:</b> "+lvs_DE_Produto+" ("+String(lvl_Prod)+")"
		
		//Retorna o Pre$$HEX1$$e700$$ENDHEX$$o do Produto Indexador
		If Not This.Of_Preco_Produto_Indexador( lvl_Prod_Ref, ref lvdc_Preco_Prod_Ref, 1) Then	Return False
		//Calcula o novo pre$$HEX1$$e700$$ENDHEX$$o
		lvdc_Preco_Novo	= Round(lvdc_Preco_Prod_Ref * lvdc_PC_Fator_Ref, 2)
		//Caso o pre$$HEX1$$e700$$ENDHEX$$o indexado for inferior ao m$$HEX1$$ed00$$ENDHEX$$nimo o setor PRICING deve ficar sabendo
		If Not IsNull(lvdc_Preco_Min) and (lvdc_Preco_Min > 0.00) and (lvdc_Preco_Novo < lvdc_Preco_Min) Then 
			This.of_Grava_Log("Pre$$HEX1$$e700$$ENDHEX$$o com valor indexado para o produto "+String(lvl_Prod)+" inferior ao m$$HEX1$$ed00$$ENDHEX$$nimo.", "", lvs_CD_Subcategoria, lvl_Prod)
		End If
		//Verifica m$$HEX1$$ed00$$ENDHEX$$nimo/m$$HEX1$$e100$$ENDHEX$$ximo
		This.of_Verifica_Preco_Minimo_Maximo( lvl_Prod, ref lvdc_Preco_Novo, lvdc_Preco_Min, lvdc_Preco_Max)
		//Atualiza no banco de dados
		Update precificacao_prd
		Set vl_preco_indexado	= :lvdc_Preco_Novo,
			 vl_preco_final			= :lvdc_Preco_Novo
		Where nr_precificacao	= :il_NR_Precificacao
			and cd_produto			= :lvl_Prod
		Using SQLCa;
		
		If SQLCa.SQLCode = -1 Then 
			This.of_Grava_Log("Erro ao atualizar o pre$$HEX1$$e700$$ENDHEX$$o indexado para o produto "+String(lvl_Prod)+".", SQLCa.SQLErrtext, lvs_CD_Subcategoria, lvl_Prod)
			SQLCa.Of_RollBack()
			Return False
		End If	
	Next
	
Catch (RuntimeError lvo_Erro)
	SQLCa.Of_RollBack()
	This.Of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_produto_indexado().", lvo_Erro.GetMessage())
	Return False
	
Finally
	If IsValid(lvds_Prod) Then Destroy(lvds_Prod)
	ivs_Chave = ""
End Try

Return True
end function

public function boolean of_preco_produto_indexador (long al_produto, ref decimal adc_preco, long pl_tentativa);/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																											//
//													V.	Exece$$HEX2$$e700f500$$ENDHEX$$es algoritmo  ->	LEVE/PAGUE																		//
//																																											//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	REGRAS:																																								//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//			Com a identifica$$HEX2$$e700e300$$ENDHEX$$o na base de dados dos produtos leve e pague, Quantidade/Volume/Peso Pague e a menor apresenta$$HEX2$$e700e300$$ENDHEX$$o 	//
//		que deve ser utilizada para compara$$HEX2$$e700e300$$ENDHEX$$o. A regra $$HEX1$$e900$$ENDHEX$$ de multiplicar a Quantidade/Volume/Peso PAGUE pelo pre$$HEX1$$e700$$ENDHEX$$o da menor 			//
//		apresenta$$HEX2$$e700e300$$ENDHEX$$o. O Pre$$HEX1$$e700$$ENDHEX$$o final do Kit Leve Pague deve ser maior ou igual ao Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo definido. 										//
//																																											//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	CONSIDERA$$HEX2$$c700d500$$ENDHEX$$ES:																																					//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//			Essa fun$$HEX2$$e700e300$$ENDHEX$$o servir$$HEX1$$e100$$ENDHEX$$ para buscar o pre$$HEX1$$e700$$ENDHEX$$o de um produto indexador (que servir$$HEX1$$e100$$ENDHEX$$ de refer$$HEX1$$ea00$$ENDHEX$$ncia para precifica$$HEX2$$e700e300$$ENDHEX$$o de outro),		//
//		podendo o produto indexador estar indexado a outro produto em no m$$HEX1$$e100$$ENDHEX$$ximo 5 n$$HEX1$$ed00$$ENDHEX$$veis. Al$$HEX1$$e900$$ENDHEX$$m disso foi considerada a possibilidade //
//		de um produto indexador n$$HEX1$$e300$$ENDHEX$$o estar sendo precificado.																								//
//																																											//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Decimal{2} lvdc_Preco
Decimal{2} lvdc_Preco_Min
Decimal{2} lvdc_Preco_Max
Decimal{4} lvdc_Fator_Ref

Long lvl_Produto
Long lvl_Produto_Ref

String lvs_UF
String lvs_Rede

Try
	SetNull(adc_preco)
	
	//Permite at$$HEX1$$e900$$ENDHEX$$ 5 n$$HEX1$$ed00$$ENDHEX$$veis de indexa$$HEX2$$e700e300$$ENDHEX$$o, ou seja, o produto 1 pode ser refer$$HEX1$$ea00$$ENDHEX$$ncia para o produto 2, que pode ser refer$$HEX1$$ea00$$ENDHEX$$ncia para o produto 3...
	// Limitado a 5 pois pode haver refer$$HEX1$$ea00$$ENDHEX$$ncias cruzadas, e isso evita o loop
	If pl_tentativa > 5 Then 
		This.of_Grava_Log("Pre$$HEX1$$e700$$ENDHEX$$o do produto indexador n$$HEX1$$e300$$ENDHEX$$o foi conclu$$HEX1$$ed00$$ENDHEX$$do em 5 etapas.", "Verifique a possibilidade de refer$$HEX1$$ea00$$ENDHEX$$ncia cruzada.", ivs_Subcategoria, al_produto)
		Return False
	End If
	
	//PRIMEIRO VERIFICA SE O PRODUTO FOI CALCULADO NA PRECIFICA$$HEX2$$c700c300$$ENDHEX$$O ATUAL
	select coalesce(pr.vl_preco_indexado, coalesce(pr.vl_preco_unificado, coalesce(pr.vl_preco_marca_propria, pr.vl_preco_apresentacao))), 
			pr.cd_prod_referencia_preco, 
			pr.pc_prod_referencia_preco,
			pr.vl_preco_minimo,
			pr.vl_preco_maximo
	Into :lvdc_Preco, :lvl_Produto_Ref, :lvdc_Fator_Ref, :lvdc_Preco_Min, :lvdc_Preco_Max
	From precificacao_prd pr
	Where pr.nr_precificacao = :il_NR_Precificacao
		And pr.cd_produto = :al_produto
	Using SQLCa;
	
	Choose Case SQLCa.SQLCode
		Case -1  //ERRO
			This.of_Grava_Log("Erro ao localizar o pre$$HEX1$$e700$$ENDHEX$$o do produto refer$$HEX1$$ea00$$ENDHEX$$ncia "+String(al_produto)+".", SQLCa.SQLErrtext, ivs_Subcategoria, al_produto)
			SQLCa.Of_RollBack()
			Return False
			
		Case 100 //N$$HEX1$$c300$$ENDHEX$$O RETORNOU REGISTRO  ==> N$$HEX1$$c300$$ENDHEX$$O FOI CALCULADO (tem de pegar o pre$$HEX1$$e700$$ENDHEX$$o atual)
			//Captura UF e REDE do c$$HEX1$$e100$$ENDHEX$$lculo atual para identificar o pre$$HEX1$$e700$$ENDHEX$$o atual
			Select cd_uf, 
					 id_rede_filial
			Into 	:lvs_UF,
					:lvs_Rede
			From precificacao
			Where nr_precificacao = :il_NR_Precificacao
			Using SQLCa;
			
			If SQLCa.SQLCode = -1 Then
				This.of_Grava_Log("Erro ao localizar a UF e REDE da precifica$$HEX2$$e700e300$$ENDHEX$$o para o produto "+String(al_produto)+" na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_produto_indexador().", SQLCa.SQLErrtext, ivs_Subcategoria, al_produto)
				SQLCa.Of_RollBack()
				Return False
			End If
			
			Select 	pu.vl_preco_venda_atual, 
						pc.cd_prod_referencia_preco, 
						pc.pc_prod_referencia_preco
			Into :lvdc_Preco, :lvl_Produto_Ref, :lvdc_Fator_Ref
			From produto_uf pu
			inner join produto_central pc
				on pc.cd_produto = pu.cd_produto
			Where pu.cd_produto = :al_produto
				And pu.cd_unidade_federacao = :lvs_UF
			Using SQLCa;
			
			If SQLCa.SQLCode = -1 Then
				This.of_Grava_Log("Erro ao localizar o pre$$HEX1$$e700$$ENDHEX$$o atual do produto "+String(al_produto)+" na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_produto_indexador().", SQLCa.SQLErrtext, ivs_Subcategoria, al_produto)
				SQLCa.Of_RollBack()
				Return False
			End If
			
			SetNull(lvdc_Preco_Min)
			SetNull(lvdc_Preco_Max)
	End Choose	
	
	//O produto referencia $$HEX1$$e900$$ENDHEX$$ indexado a outro produto
	If Not IsNull(lvl_Produto_Ref) and (lvdc_Fator_Ref > 0.0000) Then
		If Not This.Of_Preco_Produto_Indexador(lvl_Produto_Ref, ref lvdc_Preco, pl_tentativa + 1) Then Return False
		adc_preco = Round(lvdc_Preco * lvdc_Fator_Ref, 2)
	Else
		adc_preco = lvdc_Preco
	End If
	
	This.of_Verifica_Preco_Minimo_Maximo( al_produto, ref adc_preco, lvdc_Preco_Min, lvdc_Preco_Max)
	
Catch (RuntimeError lvo_Erro)
	This.of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_produto_indexador().", lvo_Erro.GetMessage(), ivs_Subcategoria, al_produto)
	SQLCa.Of_RollBack()
	Return False
	
Finally
	//
End Try

Return True
end function

public function boolean of_preco_marca_propria ();/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																											//
//													V.	Exece$$HEX2$$e700f500$$ENDHEX$$es algoritmo  ->	MARCA PR$$HEX1$$d300$$ENDHEX$$PRIA																//
//																																											//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	REGRAS:																																								//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//			A regra definida para produtos marca pr$$HEX1$$f300$$ENDHEX$$pria $$HEX1$$e900$$ENDHEX$$ de os pre$$HEX1$$e700$$ENDHEX$$os serem de 5% a 15% menor que a marca refer$$HEX1$$ea00$$ENDHEX$$ncia. Esta 		//
//		informa$$HEX2$$e700e300$$ENDHEX$$o deve estar na base de dados para a execu$$HEX2$$e700e300$$ENDHEX$$o desta regra. A combina$$HEX2$$e700e300$$ENDHEX$$o Subcategoria e Apresenta$$HEX2$$e700e300$$ENDHEX$$o deve ser o 	//
//		crit$$HEX1$$e900$$ENDHEX$$rio para esta avalia$$HEX2$$e700e300$$ENDHEX$$o.																																	//
//																																											//
//			---------------------------------------------------------------------------------------------------------------------------------------------	//
//			|AVALIAR MARCA PR$$HEX1$$d300$$ENDHEX$$PRIA	|Marca								| 	Produto	|PRE$$HEX1$$c700$$ENDHEX$$O BRUTO	|	PRE$$HEX1$$c700$$ENDHEX$$O MIN	|	NOVO PRE$$HEX1$$c700$$ENDHEX$$O	|	//
//			|-------------------------------	|----------------------------------	|-------------	|----------------	|----------------	|--------------------	|	//
//			|ACIDO BORICO P.S			|LABORATORIO CATARINENSE	|	  162909	|			4,90	|			4,73	|				4,90	|	//
//			|ACIDO BORICO P.S			|MARCA PROPRIA PP				|	  727396	|			2,99	|			1,80	|				4,17	|	//
//			|ACIDO BORICO P.S			|MARCA PROPRIA DC				|	  706715	|			2,99	|			2,36	|				4,17	|	//
//			---------------------------------------------------------------------------------------------------------------------------------------------	//
//																																											//
//		O pre$$HEX1$$e700$$ENDHEX$$o pode n$$HEX1$$e300$$ENDHEX$$o seguir a regra caso o pre$$HEX1$$e700$$ENDHEX$$o esteja abaixo do Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo. Neste caso, o Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$ed00$$ENDHEX$$nimo deve ser o pre$$HEX1$$e700$$ENDHEX$$o a 	//
//		ser considerado pelo algoritmo e a $$HEX1$$e100$$ENDHEX$$rea de Pricing deve ser informada com a lista destes produtos.										//
//																																											//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	CONSIDERA$$HEX2$$c700d500$$ENDHEX$$ES:																																					//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//			O sistema ir$$HEX1$$e100$$ENDHEX$$ considerar o produto mais vendido de marca n$$HEX1$$e300$$ENDHEX$$o pr$$HEX1$$f300$$ENDHEX$$pria da mesma subcategoria, tipo Pricing, unidade de 		//
//		calculo de pre$$HEX1$$e700$$ENDHEX$$o e quantidade/volume/peso.																											//
//																																											//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Long lvl_Linha
Long lvl_Linhas
Long lvl_CD_Produto
Long lvl_CD_Marca
Long lvl_CD_Tipo_Prod

String lvs_DE_Marca
String lvs_DE_Produto
String lvs_DE_Prod_Apres
String lvs_CD_Subcategoria
String lvs_DE_Subcategoria
String lvs_DE_Tipo_Prod
String lvs_Un_Calc_Preco

Decimal{2} lvdc_Preco
Decimal{2} lvdc_Preco_Novo
Decimal{2} lvdc_Preco_Min
Decimal{2} lvdc_Preco_Max
Decimal{2} lvdc_Preco_Ref
Decimal{2} lvdc_Variacao
Decimal{3} lvdc_QT_Apresent

Try
	//Atualiza descri$$HEX2$$e700f500$$ENDHEX$$es da etapa da precifica$$HEX2$$e700e300$$ENDHEX$$o na tela de aguarde
	If Not IsValid(w_ge450_aguarde) Then Open(w_ge450_aguarde)
	w_ge450_aguarde.uo_progress.of_SetStart()
	w_ge450_aguarde.Title 					= "Executando Precifica$$HEX2$$e700e300$$ENDHEX$$o [" + String(il_NR_Precificacao) + "] ..."
	w_ge450_aguarde.st_calculo.Text		= "C$$HEX1$$e100$$ENDHEX$$lculo: "  + is_Desc_Tipo_Precificacao
	w_ge450_aguarde.st_processo.Text	= "Aplicando Pre$$HEX1$$e700$$ENDHEX$$os Marca Pr$$HEX1$$f300$$ENDHEX$$pria..."
	
	dc_uo_ds_base lvds_Prod
	lvds_Prod = Create dc_uo_ds_base
	If Not lvds_Prod.Of_ChangeDataObject("ds_ge450_preco_marca_propria", False) Then
		This.Of_Grava_Log("Falha na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_marca_propria().","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel alterar para DW ds_ge450_preco_marca_propria. "+lvds_Prod.ivo_dberror.ivs_sqlerrtext)
		Return False
	End If
	
	lvl_Linhas = lvds_Prod.Retrieve(il_NR_Precificacao)
	If lvl_Linhas < 0 Then
		This.Of_Grava_Log("Falha ao recuperar informa$$HEX2$$e700f500$$ENDHEX$$es na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_marca_propria().","DW ds_ge450_preco_marca_propria. "+lvds_Prod.ivo_dberror.ivs_sqlerrtext)
		Return False		
	End If
	
	w_ge450_aguarde.uo_progress.of_SetMax(lvl_Linhas)
	For lvl_Linha = 1 To lvl_Linhas
		lvl_CD_Produto			= lvds_Prod.Object.cd_produto						[lvl_Linha]
		lvs_DE_Produto			= lvds_Prod.Object.de_produto						[lvl_Linha]
		lvs_DE_Prod_Apres	= lvds_Prod.Object.de_apresentacao_venda	[lvl_Linha]
		lvs_Un_Calc_Preco		= lvds_Prod.Object.id_tipo_un_calc_preco		[lvl_Linha]
		lvdc_QT_Apresent		= lvds_Prod.Object.qt_apresentacao				[lvl_Linha]
		lvl_CD_Marca			= lvds_Prod.Object.cd_marca						[lvl_Linha]
		lvs_DE_Marca			= lvds_Prod.Object.de_marca						[lvl_Linha]
		lvs_CD_Subcategoria	= lvds_Prod.Object.cd_subcategoria				[lvl_Linha]		
		lvs_DE_Subcategoria	= lvds_Prod.Object.de_subcategoria				[lvl_Linha]	
		lvdc_Preco				= lvds_Prod.Object.vl_preco							[lvl_Linha]
		lvdc_Preco_Min			= lvds_Prod.Object.vl_preco_minimo				[lvl_Linha]
		lvdc_Preco_Max		= lvds_Prod.Object.vl_preco_maximo				[lvl_Linha]
		lvl_CD_Tipo_Prod		= lvds_Prod.Object.cd_tipo_produto				[lvl_Linha]
		lvs_DE_Tipo_Prod		= lvds_Prod.Object.de_tipo_produto				[lvl_Linha]
		
		//Seta a chave a ser gravada para eventuais logs
		ivs_Chave =   "<b>Subcategoria:</b> "+lvs_DE_Subcategoria+" ("+lvs_CD_Subcategoria+")<br />"
		ivs_Chave += "<b>Marca:</b> "+lvs_DE_Marca+" ("+String(lvl_CD_Marca)+")+<br />"
		ivs_Chave += "<b>Tipo Produto:</b> "+lvs_DE_Tipo_Prod+" ("+String(lvl_CD_Tipo_Prod)+")+<br />"
		ivs_Chave += "<b>Produto:</b> "+lvs_DE_Produto+": "+lvs_DE_Prod_Apres+" ("+String(lvl_CD_Produto)+")"
		
		//Recuperar o pre$$HEX1$$e700$$ENDHEX$$o do produto (marca de terceiros) mais vendido de mesma SUBCATEGORIA / DESCRI$$HEX2$$c700c300$$ENDHEX$$O / TIPO
		Select TOP 1 coalesce(pr.vl_preco_indexado, coalesce(pr.vl_preco_unificado, coalesce(pr.vl_preco_marca_propria, pr.vl_preco_apresentacao))) as vl_preco
		Into :lvdc_Preco_Ref
		From precificacao_prd pr
		Inner Join produto_geral pg
			on pg.cd_produto = pr.cd_produto
		Left Outer Join marca_produto mp
			On mp.cd_marca = pr.cd_marca_produto
		Where pr.nr_precificacao = :il_NR_Precificacao
			And coalesce(pr.cd_tipo_produto_pricing,0) = coalesce(:lvl_CD_Tipo_Prod, 0)
			And pr.cd_subcategoria = :lvs_CD_Subcategoria
			And pr.id_tipo_un_calc_preco = :lvs_Un_Calc_Preco
			And ((pr.id_tipo_un_calc_preco <> 'Q')  or (pr.id_tipo_un_calc_preco = 'Q' and pr.qt_unidades_embalagem = cast(:lvdc_QT_Apresent as integer)))
			And ((pr.id_tipo_un_calc_preco <> 'P')  or (pr.id_tipo_un_calc_preco = 'P' and pr.qt_peso_grama = :lvdc_QT_Apresent))
			And ((pr.id_tipo_un_calc_preco <> 'V')  or (pr.id_tipo_un_calc_preco = 'V' and pr.vl_volume = :lvdc_QT_Apresent))
			And (pr.cd_marca_produto is null or coalesce(mp.id_marca_propria, 'N') = 'N')
		Order by qt_vendida_3 desc
		Using SQLCa;
		
		If SQLCa.SQLCode = -1 Then 
			This.of_Grava_Log("Erro ao recuperar o pre$$HEX1$$e700$$ENDHEX$$o do produto n$$HEX1$$e300$$ENDHEX$$o marca pr$$HEX1$$f300$$ENDHEX$$pria para o produto "+String(lvl_CD_Produto)+".", SQLCa.SQLErrtext, lvs_CD_Subcategoria, lvl_CD_Produto)
			SQLCa.Of_RollBack()
			Return False
		End If	
		
		//Somente se encontrar um produto n$$HEX1$$e300$$ENDHEX$$o sendo de marca pr$$HEX1$$f300$$ENDHEX$$pria como refer$$HEX1$$ea00$$ENDHEX$$ncia
		If Not IsNull(lvdc_Preco_Ref) and (lvdc_Preco_Ref > 0) Then
			//Varia$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ calculado com rela$$HEX2$$e700e300$$ENDHEX$$o ao pre$$HEX1$$e700$$ENDHEX$$o refer$$HEX1$$ea00$$ENDHEX$$ncia
			lvdc_Variacao = (lvdc_Preco / lvdc_Preco_Ref) - 1
			//Se estiver com pre$$HEX1$$e700$$ENDHEX$$o entre 15% a 5% menor n$$HEX1$$e300$$ENDHEX$$o altera pre$$HEX1$$e700$$ENDHEX$$o
			If (lvdc_Variacao < (- 0.15)) or (lvdc_Variacao > (- 0.05)) Then
				//Produtos com pre$$HEX1$$e700$$ENDHEX$$os inferiores a 85% do pre$$HEX1$$e700$$ENDHEX$$o do refer$$HEX1$$ea00$$ENDHEX$$ncia
				If (lvdc_Variacao < (- 0.15)) Then
					lvdc_Preco_Novo = Round(lvdc_Preco_Ref * 0.85, 2)
				Else  //Produtos que est$$HEX1$$e300$$ENDHEX$$o com pre$$HEX1$$e700$$ENDHEX$$os superiores a 95% 
					lvdc_Preco_Novo = Round(lvdc_Preco_Ref * 0.95, 2)
				End If
			Else
				lvdc_Preco_Novo = lvdc_Preco
			End If
			
			//Verifica m$$HEX1$$ed00$$ENDHEX$$nimo/m$$HEX1$$e100$$ENDHEX$$ximo
			This.of_Verifica_Preco_Minimo_Maximo( lvl_CD_Produto, ref lvdc_Preco_Novo, lvdc_Preco_Min, lvdc_Preco_Max)
		
			//Atualiza no banco de dados
			Update precificacao_prd
			Set vl_preco_marca_propria= :lvdc_Preco_Novo
			Where nr_precificacao		= :il_NR_Precificacao
				and cd_produto				= :lvl_CD_Produto
			Using SQLCa;
			
			If SQLCa.SQLCode = -1 Then 
				This.of_Grava_Log("Erro ao atualizar o pre$$HEX1$$e700$$ENDHEX$$o marca pr$$HEX1$$f300$$ENDHEX$$pria para o produto "+String(lvl_CD_Produto)+".", SQLCa.SQLErrtext, lvs_CD_Subcategoria, lvl_CD_Produto)
				SQLCa.Of_RollBack()
				Return False
			End If	
		End If
		
		w_ge450_aguarde.uo_progress.of_SetProgress(lvl_Linha)
	Next
	
Catch (RuntimeError lvo_Erro)
	SQLCa.Of_RollBack()
	This.Of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_marca_propria().", lvo_Erro.GetMessage())
	Return False
	
Finally
	If IsValid(lvds_Prod) Then Destroy(lvds_Prod)
	ivs_Chave = ""
End Try

Return True
end function

public function boolean of_processa_regionalizacao ();//Para processar as estimativas de vendas e faturamento por cidade
Long ll_Linhas, ll_Linha

String ls_UF, ls_Rede, ls_SubCategoria, ls_Msg

dc_uo_ds_base lds

Boolean lvb_Sucesso = False

try

	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge450_precificacao_pendente", False) Then 
		This.of_Grava_Log("Erro na troca da dw [ds_ge450_precificacao_pendente].", lds.ivo_dberror.ivs_sqlerrtext)
		Return False
	End If
	
	ll_Linhas = lds.Retrieve("R")
	
	If ll_Linhas > 0 Then
		
		Open(	w_ge450_aguarde)
				
		For ll_Linha = 1 To ll_Linhas
			lvb_Sucesso 					= False
			il_NR_Precificacao				= lds.Object.nr_precificacao			[ll_Linha]
			il_Tipo_Precificacao			= lds.Object.cd_tipo_precificacao	[ll_Linha]
			is_Desc_Tipo_Precificacao	= lds.Object.de_tipo_precificacao	[ll_Linha]
			ls_UF								= lds.Object.cd_uf						[ll_Linha]
			ls_SubCategoria				= lds.Object.cd_subcategoria		[ll_Linha]
			ls_Rede							= lds.Object.id_rede_filial			[ll_Linha]
			
			If Not IsValid(w_ge450_aguarde) Then Open(w_ge450_aguarde)
			w_ge450_aguarde.Title = "Executando Atualiza$$HEX2$$e700e300$$ENDHEX$$o de Faturamento Regionaliza$$HEX2$$e700e300$$ENDHEX$$o [" + String(il_NR_Precificacao) + "] ..."
			
			// INICIO
			If Not This.of_Atualiza_Inicio_Termino("A", True) Then Return False
				
			If Not This.Of_Regionalizacao_Atualiza_Faturamento(il_NR_Precificacao, is_Desc_Tipo_Precificacao, il_Tipo_Precificacao ) Then Return False
			
			// TERMINO
			If Not This.of_Atualiza_Inicio_Termino("F", False) Then Return False
			
			lvb_Sucesso = True
			SqlCa.of_Commit();
			This.of_Envia_Email( lvb_Sucesso, "R" )
						
		Next
			
	ElseIf ll_Linhas < 0 Then
		SqlCa.of_RollBack();
		of_Grava_Log("Erro ao localizar as precifica$$HEX2$$e700f500$$ENDHEX$$es pendentes de atualiza$$HEX2$$e700e300$$ENDHEX$$o das previs$$HEX1$$f500$$ENDHEX$$es de faturamento.", lds.ivo_DbError.ivs_SQLErrText)
		Return False
	End If
	
Catch (RuntimeError lvo_Erro)
		of_Grava_Log("Erro na execu$$HEX2$$e700e300$$ENDHEX$$o da fun$$HEX2$$e700e300$$ENDHEX$$o of_processa_regionalizacao().", lvo_Erro.GetMessage())
		Return False	
	
finally
	If il_NR_Precificacao > 0 Then
		If Not lvb_Sucesso Then 
			SqlCa.of_RollBack();
			
			This.of_Atualiza_Inicio_Termino("X", False) 
			This.of_Envia_Email( lvb_Sucesso, "R" )
			SqlCa.of_Commit();
		End If
	End If
	
	If IsValid(w_ge450_aguarde) Then Close(w_ge450_aguarde)
end try

Return True
end function

private function boolean of_envia_email (boolean pb_sucesso, string ps_tipo);//ps_tipo (R=Regionaliza$$HEX2$$e700e300$$ENDHEX$$o; C=C$$HEX1$$e100$$ENDHEX$$lculo Pre$$HEX1$$e700$$ENDHEX$$o)

s_email lst_email
String lvs_Email_Resp, lvs_Email_Reg
String lvs_Msg

select u.de_endereco_email, ur.de_endereco_email
Into :lvs_Email_Resp, :lvs_Email_Reg
from precificacao p
inner join usuario u
	on u.nr_matricula = p.nr_matricula_responsavel
left outer join usuario ur
	on ur.nr_matricula = p.nr_matric_regionalizacao
	and ur.nr_matricula <> p.nr_matricula_responsavel
Where nr_precificacao = :il_NR_Precificacao
	And (coalesce(u.de_endereco_email, '') <> '' or coalesce(ur.de_endereco_email, '') <> '')
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	This.Of_Grava_Log("Erro ao recuperar o email do usu$$HEX1$$e100$$ENDHEX$$rio da precifica$$HEX2$$e700e300$$ENDHEX$$o.", SQLCa.SQLErrText)
End If

lvs_Msg =	"Caro(a) Usu$$HEX1$$e100$$ENDHEX$$rio,<br />~n" + &
				"<br />~n"+ &
				"O processo de "+IIF(ps_tipo="C", "c$$HEX1$$e100$$ENDHEX$$lculo de pre$$HEX1$$e700$$ENDHEX$$o", "atualiza$$HEX2$$e700e300$$ENDHEX$$o de faturamento previsto ap$$HEX1$$f300$$ENDHEX$$s a regionaliza$$HEX2$$e700e300$$ENDHEX$$o")+" da precifica$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$ba00$$ENDHEX$$ "+String(il_NR_Precificacao,"#####000")+" de "+is_Desc_Tipo_Precificacao+" foi finalizado com "+IIF(pb_sucesso, "SUCESSO", "ERRO")+".<br />~n"+ &
				"<br />"+ &
				IIF(Trim(ivs_Log)<>"", "Abaixo ocorr$$HEX1$$ea00$$ENDHEX$$ncia(s) desse processo:<br><ul>", "")+ &
				ivs_Log+ &
				IIF(Trim(ivs_Log)<>"", "</ul></ul>", "")

If lvs_Email_Resp<>"" Then lst_email.ps_to [1] = lvs_Email_Resp
If lvs_Email_Reg<>"" Then lst_email.ps_to [UpperBound(lst_email.ps_to) + 1] = lvs_Email_Reg
lst_email.ps_mensagem	= lvs_Msg
lst_email.ps_telefone		= "(47) 3461-9956"
lst_email.pb_assinatura	= True

ivs_Log = ""

Return gf_ge202_envia_email_padrao(148, lst_email, False)
end function

public function boolean of_atualiza_inicio_termino (string as_inicio_termino, boolean ab_commit);String ls_MSG, ls_Operacao

Choose Case as_inicio_termino
	Case 'I' //INICIO C$$HEX1$$c100$$ENDHEX$$LCULO PRE$$HEX1$$c700$$ENDHEX$$O

		Update precificacao
		Set id_situacao = 'P', dh_inicio = getdate()
		Where nr_precificacao = :il_NR_Precificacao
		Using SqlCa;
		
		ls_Operacao = 'INICIO - '

	Case 'T' //T$$HEX1$$c900$$ENDHEX$$RMINO C$$HEX1$$c100$$ENDHEX$$LCULO PRE$$HEX1$$c700$$ENDHEX$$O

		Update precificacao
		Set id_situacao = 'T', dh_termino = getdate()
		Where nr_precificacao = :il_NR_Precificacao
		Using SqlCa;
		
		ls_Operacao = 'TERMINO - '
	
	Case 'E' 	// ERRO - C$$HEX1$$c100$$ENDHEX$$LCULO PRE$$HEX1$$c700$$ENDHEX$$O
		ls_Operacao = 'ERRO - '
		
		Update precificacao
		Set id_situacao = 'E', dh_termino = getdate()
		Where nr_precificacao = :il_NR_Precificacao
		Using SqlCa;
	
	Case Else
		ls_Operacao = as_inicio_termino+' - '
		
		Update precificacao
		Set id_situacao = :as_inicio_termino
		Where nr_precificacao = :il_NR_Precificacao
		Using SqlCa;
		
End Choose

If SqlCa.SqlCode = -1 Then
	ls_MSG = SqlCa.SqlErrText
	SqlCa.of_RollBack()
	This.of_Grava_Log(ls_Operacao + "Erro ao atualizar a situa$$HEX2$$e700e300$$ENDHEX$$o da precifica$$HEX2$$e700e300$$ENDHEX$$o [" + String(il_NR_Precificacao) + "] - '" +  ls_MSG + "'.", ls_MSG)
	Return False
End If

If ab_Commit Then SQLCa.Of_Commit()

Return True
end function

public function boolean of_preco_psicologico_faixa (decimal adc_preco, decimal adc_preco_minimo, decimal adc_preco_maximo, ref decimal adc_preco_psicologico);///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																																	//
//														Pre$$HEX1$$e700$$ENDHEX$$o Psicol$$HEX1$$f300$$ENDHEX$$gico - ARREDONDAMENTO POR FAIXA DE PRE$$HEX1$$c700$$ENDHEX$$O																//
//																																																	//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	REGRAS:																																														//
//			O m$$HEX1$$f300$$ENDHEX$$dulo ARREDONDAMENTO POR FAIXA DE PRE$$HEX1$$c700$$ENDHEX$$O consiste em aplicar arredondamentos de pre$$HEX1$$e700$$ENDHEX$$o diferenciados pelo n$$HEX1$$ed00$$ENDHEX$$vel de 						//
//			pre$$HEX1$$e700$$ENDHEX$$o definido pelo modelo. As faixas est$$HEX1$$e300$$ENDHEX$$o descritas abaixo:																											//
//																																																	//
//		N$$HEX1$$c300$$ENDHEX$$O MEDICAMENTOS:																																								//
//				$$HEX1$$2220$$ENDHEX$$	FAIXA 1:	  	  00,95 =>   20,00	: Arredondar para o mais pr$$HEX1$$f300$$ENDHEX$$ximo terminado em 0,09			(Ex.: 1,12 -> 1,09; 2,25 -> 2,29)				//
//				$$HEX1$$2220$$ENDHEX$$	FAIXA 2:		  20,01 =>   50,00	: Arredondar para o mais pr$$HEX1$$f300$$ENDHEX$$ximo terminado em 0,90			(Ex.: 20,12 -> 20,90; 38,62 -> 38,90)		//																										//
//				$$HEX1$$2220$$ENDHEX$$	FAIXA 3:		  50,01 => 150,00	: Arredondar para o maior terminado em 0,90 						(Ex.: 53,15 -> 53,90; 123,03 -> 123,90)		//
//				$$HEX1$$2220$$ENDHEX$$	FAIXA 4:		150,01 =>      [...]	: Arredondar para a dezena maior terminado em 4,90 ou 9,90	(Ex.: 202,12 -> 204,90; 226,34 -> 229,90)	// 		
//		MIP:																																														//
//				$$HEX1$$2220$$ENDHEX$$	FAIXA 1:		  00,95 =>   10,00	: Arredondar para o mais pr$$HEX1$$f300$$ENDHEX$$ximo terminado em 0,09			(Ex.: 1,12 -> 1,09; 2,25 -> 2,29)				//
//				$$HEX1$$2220$$ENDHEX$$	FAIXA 2:		  10,01 =>   30,00	: Arredondar para o mais pr$$HEX1$$f300$$ENDHEX$$ximo terminado em 0,90 			(Ex.: 11,12 -> 10,90; 18,58 -> 18,90) 		//																										//
//				$$HEX1$$2220$$ENDHEX$$	FAIXA 3:		  30,01 => 100,00	: Arredondar para o maior terminado em 0,90 						(Ex.: 33,15 -> 33,90; 72,03 -> 72,90)		//
//				$$HEX1$$2220$$ENDHEX$$	FAIXA 4:		100,01 =>      [...]	: Arredondar para a dezena maior terminado em 4,90 ou 9,90	(Ex.: 158,78 -> 159,90; 102,12 -> 104,90)	// 																							//
//																																																	//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Decimal{2} lvdc_Preco_1
Decimal{2} lvdc_Preco_2
Decimal{2} lvdc_Aux

Decimal{2} lvdc_Faixa_1
Decimal{2} lvdc_Faixa_2
Decimal{2} lvdc_Faixa_3
Decimal{2} lvdc_Faixa_4

Try
	Choose Case il_Tipo_Precificacao
		Case 1 //MEDICAMENTO RX - N$$HEX1$$e300$$ENDHEX$$o utiliza esta fun$$HEX2$$e700e300$$ENDHEX$$o
			adc_preco_psicologico = adc_preco
			Return True
			
		Case 2 //N$$HEX1$$c300$$ENDHEX$$O MEDICAMENTO
			lvdc_Faixa_1 = 0.95
			lvdc_Faixa_2 = 20.00
			lvdc_Faixa_3 = 50.00
			lvdc_Faixa_4 = 150.00	
			
		Case 3 //MEDICAMENTO MIP
			lvdc_Faixa_1 = 0.95
			lvdc_Faixa_2 = 10.00
			lvdc_Faixa_3 = 30.00
			lvdc_Faixa_4 = 100.00	
			
		Case Else
			This.Of_Grava_Log("Tipo de precifica$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lida na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_psicologico_faixa().", "Tipo de precifica$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lida.")
	End Choose
	
	Choose Case adc_preco
		//FAIXA 1
		Case lvdc_Faixa_1 to lvdc_Faixa_2
			//Remove o $$HEX1$$fa00$$ENDHEX$$ltimo d$$HEX1$$ed00$$ENDHEX$$gito centavo
			lvdc_Aux = Truncate(adc_preco * 10, 0) / 10
			//Adiciona 0.09 ao valor truncado sem o $$HEX1$$fa00$$ENDHEX$$ltimo d$$HEX1$$ed00$$ENDHEX$$gito
			lvdc_Preco_1 = lvdc_Aux + 0.09
			//Reduz 0.01 ao valor truncado sem o $$HEX1$$fa00$$ENDHEX$$ltimo d$$HEX1$$ed00$$ENDHEX$$gito
			lvdc_Preco_2 = lvdc_Aux - 0.01
			
			//Verifica menor diferen$$HEX1$$e700$$ENDHEX$$a
			If Abs(adc_preco - lvdc_Preco_1) < Abs(adc_preco - lvdc_Preco_2) Then
				adc_preco_psicologico = lvdc_Preco_1
			Else
				adc_preco_psicologico = lvdc_Preco_2
			End If
		
		//FAIXA 2
		Case   (lvdc_Faixa_2 + 0.01) to lvdc_Faixa_3
			//Remove o $$HEX1$$fa00$$ENDHEX$$ltimo d$$HEX1$$ed00$$ENDHEX$$gito centavo
			lvdc_Aux = Truncate(adc_preco, 0)
			//Adiciona 0.90 ao valor truncado sem os centavos
			lvdc_Preco_1 = lvdc_Aux + 0.90
			//Reduz 0.10 ao valor truncado sem os centavos
			lvdc_Preco_2 = lvdc_Aux - 0.10
			
			//Verifica menor diferen$$HEX1$$e700$$ENDHEX$$a
			If Abs(adc_preco - lvdc_Preco_1) < Abs(adc_preco - lvdc_Preco_2) Then
				adc_preco_psicologico = lvdc_Preco_1
			Else
				adc_preco_psicologico = lvdc_Preco_2
			End If
		
		//FAIXA 3
		Case (lvdc_Faixa_3 + 0.01) to lvdc_Faixa_4
			//Remove o $$HEX1$$fa00$$ENDHEX$$ltimo d$$HEX1$$ed00$$ENDHEX$$gito centavo
			lvdc_Aux = Truncate(adc_preco, 0)
			//Adiciona 0.90 ao valor truncado sem os centavos
			lvdc_Preco_1 = lvdc_Aux + 0.90
			
			adc_preco_psicologico = lvdc_Preco_1
		
		//FAIXA 4
		Case is > (lvdc_Faixa_4 + 0.01)
			//Remove o $$HEX1$$fa00$$ENDHEX$$ltimo d$$HEX1$$ed00$$ENDHEX$$gito centavo
			lvdc_Aux = Truncate(adc_preco / 10, 0) * 10
			//Adiciona 0.90 ao valor truncado sem os centavos
			lvdc_Preco_1 = lvdc_Aux + 4.90
			//Reduz 0.10 ao valor truncado sem os centavos
			lvdc_Preco_2 = lvdc_Aux + 9.90
			
			//Verifica menor diferen$$HEX1$$e700$$ENDHEX$$a
			If Abs(adc_preco - lvdc_Preco_1) < Abs(adc_preco - lvdc_Preco_2) Then
				adc_preco_psicologico = lvdc_Preco_1
			Else
				adc_preco_psicologico = lvdc_Preco_2
			End If
			
	End Choose
	
	//Verifica pre$$HEX1$$e700$$ENDHEX$$o m$$HEX1$$ed00$$ENDHEX$$nimo e m$$HEX1$$e100$$ENDHEX$$ximo, caso exceda respeita o pre$$HEX1$$e700$$ENDHEX$$o da regionaliza$$HEX2$$e700e300$$ENDHEX$$o
	If 	(Not IsNull(adc_preco_minimo) and (adc_preco_minimo > 0.00) and (adc_preco_psicologico < adc_preco_minimo)) or &
		(Not IsNull(adc_preco_maximo) and (adc_preco_maximo > 0.00)  and (adc_preco_psicologico > adc_preco_maximo)) Then
		adc_preco_psicologico = adc_preco
	End If
	
Catch (RuntimeError lvo_Erro)
	This.Of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_preco_psicologico_faixa().", lvo_Erro.GetMessage())
	Return False
End Try

Return True
end function

on uo_ge450_precificacao_calculo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge450_precificacao_calculo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivtr_Trans = Create dc_uo_transacao
ivtr_Trans.ivs_database = gvo_aplicacao.ivs_database
ivtr_trans.Of_connect( gvo_aplicacao.ivs_datasource, gvo_aplicacao.ivo_seguranca.cd_sistema+'_'+gvo_aplicacao.ivo_seguranca.of_get_usuario_windows( ), False)

ids_exponencial = Create dc_uo_ds_base
If Not ids_exponencial.of_ChangeDataObject("ds_ge450_exponencial_curva", False) Then 
	This.Of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o constructor do objecto "+This.ClassName(),"Erro ao alterar para DW ds_ge450_exponencial_curva")
End If

ids_apresentacao_orig = Create dc_uo_ds_base
If Not ids_apresentacao_orig.of_ChangeDataObject("ds_ge450_apresentacao_medic", False) Then 
	This.Of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o constructor do objecto "+This.ClassName(),"Erro ao alterar para DW ds_ge450_apresentacao_medic")
End If
ids_apresentacao_orig.of_AppendWhere("coalesce(vl_preco_exponencial,0) > 0")
 
ids_apresentacao_dest = Create dc_uo_ds_base
If Not ids_apresentacao_dest.of_ChangeDataObject("ds_ge450_apresentacao_medic", False) Then 
	This.Of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o constructor do objecto "+This.ClassName(),"Erro ao alterar para DW ds_ge450_apresentacao_medic")
End If
ids_apresentacao_dest.of_AppendWhere("coalesce(vl_preco_exponencial,0) = 0")

ids_marcas_subcategoria = Create dc_uo_ds_base
If Not ids_marcas_subcategoria.of_ChangeDataObject("ds_ge450_margem_marca_subcategoria", False) Then 
	This.Of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o constructor do objecto "+This.ClassName(),"Erro ao alterar para DW ds_ge450_margem_marca_subcategoria")
End If

ids_marcas_sub_proc = Create dc_uo_ds_base
If Not ids_marcas_sub_proc.of_ChangeDataObject("ds_ge450_margem_subcategoria", False) Then 
	This.Of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o constructor do objecto "+This.ClassName(),"Erro ao alterar para DW ds_ge450_margem_subcategoria")
End If

ids_preco_cidade = Create dc_uo_ds_base
If Not ids_preco_cidade.Of_ChangeDataObject("ds_ge450_produto_precificacao", False) Then 
	This.Of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o constructor do objecto "+This.ClassName(),"Erro ao alterar para DW ds_ge450_produto_precificacao")
End If

ids_marcas_sub_cat_proc = Create dc_uo_ds_base
If Not ids_marcas_sub_cat_proc.Of_ChangeDataObject("ds_ge450_margem_categoria_marca", False) Then 
	This.Of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o constructor do objecto "+This.ClassName(),"Erro ao alterar para DW ds_ge450_margem_categoria_marca")
End If

ids_marcas_categoria = Create dc_uo_ds_base
If Not ids_marcas_categoria.Of_ChangeDataObject("ds_ge450_margem_marca_categoria", False) Then 
	This.Of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o constructor do objecto "+This.ClassName(),"Erro ao alterar para DW ds_ge450_margem_marca_categoria")
End If

ids_apresentacao_nao_med = Create dc_uo_ds_base
If Not ids_apresentacao_nao_med.Of_ChangeDataObject("ds_ge450_apresentacao_nao_medic", False) Then 
	This.Of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o constructor do objecto "+This.ClassName(),"Erro ao alterar para DW ds_ge450_apresentacao_nao_medic")
End If

ids_preco_grupo_pricing = Create dc_uo_ds_base
If Not ids_preco_grupo_pricing.Of_ChangeDataObject("ds_ge450_preco_grupo_pricing", False) Then 
	This.Of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o constructor do objecto "+This.ClassName(),"Erro ao alterar para DW ds_ge450_preco_grupo_pricing")
End If

ids_grupo_pricing = Create dc_uo_ds_base
If Not ids_grupo_pricing.Of_ChangeDataObject("ds_ge450_precificacao_grupo_pricing", False) Then 
	This.Of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o constructor do objecto "+This.ClassName(),"Erro ao alterar para DW ds_ge450_precificacao_grupo_pricing")
End If

Return 0

end event

event destructor;Destroy ids_exponencial
Destroy ids_apresentacao_orig
Destroy ids_apresentacao_dest
Destroy ids_marcas_subcategoria
Destroy ids_marcas_sub_proc
Destroy ids_marcas_sub_cat_proc
Destroy ids_marcas_categoria
Destroy ids_apresentacao_nao_med
Destroy ids_preco_grupo_pricing
Destroy ids_grupo_pricing

If IsValid(ivtr_trans) Then
	If ivtr_trans.Of_Isconnected( ) Then ivtr_trans.of_disconnect( )
	Destroy(ivtr_trans)
End If
end event

