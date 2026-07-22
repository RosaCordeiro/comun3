HA$PBExportHeader$uo_ge642_volumes_excesso.sru
forward
global type uo_ge642_volumes_excesso from nonvisualobject
end type
end forward

global type uo_ge642_volumes_excesso from nonvisualobject
end type
global uo_ge642_volumes_excesso uo_ge642_volumes_excesso

type variables
Boolean	ib_ja_imprimiu_etiqueta
String	is_Nm_Bairro
end variables

forward prototypes
public function boolean of_imprime_etiqueta (long al_chv_volume, long al_filial, long al_nota, string as_especie, string as_serie, string as_lista_volumes)
public function boolean of_imprime_etiqueta (long al_filial, long al_nota, string as_especie, string as_serie, string as_lista_volumes)
public function boolean of_imprime_etiqueta (long al_chv_volume)
public function boolean of_retira_produto (long al_nr_chv_volume, long al_produto, string as_lote, datetime adh_validade, long al_qt_movimento, ref string as_erro)
end prototypes

public function boolean of_imprime_etiqueta (long al_chv_volume, long al_filial, long al_nota, string as_especie, string as_serie, string as_lista_volumes);// Declara$$HEX2$$e700f500$$ENDHEX$$es
Boolean			lb_Sucesso = False
DateTime			ldh_Impressao

dc_uo_ds_base	lds_Etiqueta, &
					lds_Volume

Long 				ll_Linha, &
					ll_Linhas

String 			ls_EAN13, &
					ls_Where, &
					ls_Erro

// Procedimentos

Try
	lds_Volume   = Create dc_uo_ds_base
	lds_Etiqueta = Create dc_uo_ds_base
	
	If Not lds_Volume.of_ChangeDataObject ('ds_ge642_dados_do_volume', False) then
		ls_Erro = 'Erro no changedataobject da ds_ge642_dados_do_volume'
		Return False
	End if
	
	If Not lds_Etiqueta.of_ChangeDataObject ('ds_ge259_etiqueta_segr_receb_dev', False) then
		ls_Erro = 'Erro no changedataobject da ds_ge259_etiqueta_segr_receb_dev'
		Return False
	End if
	
	If Not IsNull (al_chv_volume) then
		ls_Where = 'srd.nr_chave_volume = ' + String (al_chv_volume)
	else
		ls_Where = 'srd.cd_filial_origem = '  + String (al_filial) +  ' AND ' + &
					  'srd.nr_nf            = '  + String (al_nota)   +  ' AND ' + &
					  "srd.de_especie       = '" + as_especie         + "' AND " + &
					  "srd.de_serie         = '" + as_serie           + "'"
		If as_lista_volumes <> '0' then
			ls_Where += ' AND srd.nr_volume IN (' + as_lista_volumes + ')'
		else
			ls_Where += ' AND srd.dh_termino_registro IS NOT NULL'
		End if
	End if
	
	lds_Volume.of_AppendWhere (ls_Where)
	
	ll_Linhas = lds_Volume.Retrieve ()
	
	For ll_Linha = 1 to ll_Linhas
		
		al_chv_volume = lds_Volume.Object.nr_chave_volume [ll_Linha]
		ldh_Impressao = gf_GetServerDate ()
		
		UPDATE wms_segregado_receb_dev
			SET dh_impressao = :ldh_Impressao
		 WHERE nr_chave_volume = :al_chv_volume
		 USING SQLCA;
		
		If SQLCA.SQLCode <> 0 then
			ls_Erro = 'Erro ao atualizar o hor$$HEX1$$e100$$ENDHEX$$rio de impress$$HEX1$$e300$$ENDHEX$$o do volume ' + String (al_chv_volume) + ': ' + '~n~r' + SQLCA.SQLErrText
			Return False
		else
			//Quando o n$$HEX1$$fa00$$ENDHEX$$mero do volume $$HEX1$$e900$$ENDHEX$$ informado, trata-se de reimpress$$HEX1$$e300$$ENDHEX$$o, portanto, deve-se fazer o commit
			//Quando este n$$HEX1$$fa00$$ENDHEX$$mero n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ informado, $$HEX1$$e900$$ENDHEX$$ porque a impress$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ sendo feita durante o processo de
			//bipagem de um produto. Neste caso, o controle da transa$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ feito por aquele processo.
			If not IsNull (as_lista_volumes) then
				SQLCA.of_Commit ()
			End if
		End if
		
		lds_Etiqueta.InsertRow (0)
		
		lds_Etiqueta.Object.de_filial        [1] = lds_Volume.Object.nm_fantasia      [ll_Linha]
		lds_Etiqueta.Object.cd_filial        [1] = lds_Volume.Object.cd_filial_origem [ll_Linha]
		lds_Etiqueta.Object.nr_volume        [1] = lds_Volume.Object.nr_volume        [ll_Linha]
		lds_Etiqueta.Object.nr_chave_volume  [1] = al_chv_volume
		lds_Etiqueta.Object.de_tipo_retirada [1] = lds_Volume.Object.de_tipo_retirada [ll_Linha]
		lds_Etiqueta.Object.nr_nf            [1] = lds_Volume.Object.nr_nf            [ll_Linha]
		lds_Etiqueta.Object.de_especie       [1] = lds_Volume.Object.de_especie       [ll_Linha]
		lds_Etiqueta.Object.de_serie         [1] = lds_Volume.Object.de_serie         [ll_Linha]
		lds_Etiqueta.Object.dh_impressao     [1] = ldh_Impressao
		lds_Etiqueta.Object.nm_bairro        [1] = is_Nm_Bairro
		lds_Etiqueta.Object.id_usuario       [1] = 'Conf.: ' + gvo_Aplicacao.ivo_seguranca.nr_matricula + '-' + gvo_Aplicacao.ivo_seguranca.nm_usuario
	
		ls_EAN13 = String (al_chv_volume, '00000000')
		lds_Etiqueta.Object.de_codigo_barras [1] = '*' + ls_EAN13 + '*'		
		
		If not ib_ja_imprimiu_etiqueta then
			If PrintSetup () <> 1 then
				Return False
			End if
			ib_ja_imprimiu_etiqueta = True
		End if
		
		lds_Etiqueta.Print ()
		Sleep (2)
		lds_Etiqueta.Reset ()
	Next
	
	lb_Sucesso = True

Finally
	If not lb_Sucesso then
		SQLCA.of_rollback ()
		
		If ls_erro <> '' then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_Erro, Exclamation!)
		End if
	End if
	
	Destroy lds_Etiqueta
	Destroy lds_Volume
End Try

Return True
end function

public function boolean of_imprime_etiqueta (long al_filial, long al_nota, string as_especie, string as_serie, string as_lista_volumes);Long		ll_Nulo

SetNull (ll_Nulo)

Return of_imprime_etiqueta (ll_Nulo, al_filial, al_nota, as_especie, as_serie, as_lista_volumes)
end function

public function boolean of_imprime_etiqueta (long al_chv_volume);Long		ll_Nulo

String	ls_Nulo

SetNull (ll_Nulo)
SetNull (ls_Nulo)

Return of_imprime_etiqueta (al_chv_volume, ll_Nulo, ll_Nulo, ls_Nulo, ls_Nulo, ls_Nulo)
end function

public function boolean of_retira_produto (long al_nr_chv_volume, long al_produto, string as_lote, datetime adh_validade, long al_qt_movimento, ref string as_erro);//
// ATEN$$HEX2$$c700c300$$ENDHEX$$O: Em caso de erro, sempre fazer rollback, pois a fun$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ chamada ap$$HEX1$$f300$$ENDHEX$$s outras atualiza$$HEX2$$e700f500$$ENDHEX$$es
//

//DECLARA$$HEX2$$c700d500$$ENDHEX$$ES
DateTime		ldh_Cancelamento, &
				ldh_Termino
				
Decimal {2}	ldc_qt_vol_total_caixa, &
				ldc_vol_prod_caixa,     &
				ldc_vol_prod
				
Decimal {3}	ll_qt_peso_total_caixa, &
				ldc_peso_prod_caixa,    &
				ldc_peso_prod
				
Long			ll_nr_volume, &
				ll_qt_registrada, &
				ll_qt_movimentada, &
				ll_qt_saldo
				
String		ls_matr_cancelamento

//PROCEDIMENTOS

as_erro = ''

//Obt$$HEX1$$e900$$ENDHEX$$m os dados do volume
SELECT qt_capacidade_utilizada
	  , qt_peso_kg
	  , dh_termino_registro
	  , dh_cancelamento
	  , nr_volume
  INTO :ldc_qt_vol_total_caixa
	  , :ll_qt_peso_total_caixa
	  , :ldh_Termino
	  , :ldh_Cancelamento
	  , :ll_nr_volume
  FROM wms_segregado_receb_dev
 WHERE nr_chave_volume = :al_nr_chv_volume
 USING SQLCA;

Choose case SQLCA.SQLCode
	case 100
		as_erro = 'Volume com a etiqueta ' + String (al_nr_chv_volume) + ' n$$HEX1$$e300$$ENDHEX$$o encontrado para fazer a retirada do produto'
		Return False
	case is < 0
		as_erro = 'Erro ao localizar o volume com a etiqueta ' + String (al_nr_chv_volume) + ' para fazer a retirada do produto: ' + '~n~r' + SQLCA.SQLErrText
		Return False
End choose

If Not IsNull (ldh_Cancelamento) then
	as_erro = 'Este volume j$$HEX1$$e100$$ENDHEX$$ foi cancelado. Verifique a etiqueta. ' + '~n~r' + 'Movimenta$$HEX2$$e700e300$$ENDHEX$$o cancelada'
	Return False
End if


//Verifica se a quantidade do produto no volume suporta a quantidade a ser retirada
SELECT qt_registrada
	  , qt_movimento
	  , qt_capacidade_litros
	  , qt_peso_kg
  INTO :ll_qt_registrada
	  , :ll_qt_movimentada
	  , :ldc_vol_prod_caixa
	  , :ldc_peso_prod_caixa
  FROM wms_segregado_receb_dev_prd
 WHERE nr_chave_volume = :al_nr_chv_volume
	AND cd_produto      = :al_Produto
	AND nr_lote         = :as_Lote
	AND dh_validade     = :adh_Validade
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		as_erro = 'Erro ao localizar o produto ' + String (al_Produto) + ' no volume com etiqueta ' + String (al_nr_chv_volume) + ': ' + '~n~r' + SQLCA.SQLErrText
		Return False
		
	case 100
		as_erro = 'Produto n$$HEX1$$e300$$ENDHEX$$o encontrado no volume com etiqueta ' + String (al_nr_chv_volume) + ': ' + '~n~r~r' + &
					 'Produto: ' + String (al_Produto) + '~n~r' + &
					 'Lote: ' + as_Lote + '~n~r' + &
					 'Validade: ' + String (adh_Validade, 'dd/mm/yyyy')
		Return False
		
	case else
		ll_qt_saldo = ll_qt_registrada - ll_qt_movimentada
		
		If al_qt_movimento > ll_qt_saldo then
			as_erro = 'O volume ' + String (al_nr_chv_volume) + ' s$$HEX1$$f300$$ENDHEX$$ cont$$HEX1$$e900$$ENDHEX$$m ' + String (ll_qt_saldo) + ' unidade(s) do produto/lote informado.' + '~n~r' + &
						 'Refa$$HEX1$$e700$$ENDHEX$$a a movimenta$$HEX2$$e700e300$$ENDHEX$$o atendo-se a este limite.'
			Return False
		End if
End choose

//Obt$$HEX1$$e900$$ENDHEX$$m dimens$$HEX1$$f500$$ENDHEX$$es do produto
SELECT  ROUND ((COALESCE (qt_largura_cm_caixa_estoque, 0) * COALESCE (qt_altura_cm_caixa_estoque,  0) * COALESCE (qt_profund_cm_caixa_estoque, 0)) / 1000, 2)
		, COALESCE (qt_peso_kg_estoque, 0)
  INTO  :ldc_vol_prod
		, :ldc_peso_prod
  FROM produto_central
 WHERE cd_produto = :al_produto
 USING SQLCA;

Choose case SQLCA.SQLCode
	case 0
		If ldc_vol_prod = 0 and ldc_peso_prod = 0 then
			as_erro = 'O produto ' + String (al_Produto) + ' n$$HEX1$$e300$$ENDHEX$$o tem dimens$$HEX1$$f500$$ENDHEX$$es e peso cadastrados. Isto impede o rec$$HEX1$$e100$$ENDHEX$$lculo do volume ocupado da caixa.'
			Return False
		End if
	case is < 0
		as_erro = 'Erro na obten$$HEX2$$e700e300$$ENDHEX$$o das dimens$$HEX1$$f500$$ENDHEX$$es do produto ' + String (al_Produto) + ' para recalcular o volume ocupado da caixa: ' + '~n~n~r' + SQLCA.SQLErrText
		Return False
	case 100
		as_erro = 'Produto ' + String (al_Produto) + " n$$HEX1$$e300$$ENDHEX$$o localizado na tabela 'produto_central'"
		Return False
End choose

ldc_vol_prod_caixa  -= (ldc_vol_prod  * al_qt_movimento)
ldc_peso_prod_caixa -= (ldc_peso_prod * al_qt_movimento)

If al_qt_movimento   = ll_qt_registrada and &
	ll_qt_movimentada = 0 					 then
	//Exclui o produto do volume somente se nenhuma unidade foi movimentada para o segregado do excesso
	DELETE FROM wms_segregado_receb_dev_prd
	 WHERE nr_chave_volume = :al_nr_chv_volume
		AND cd_produto      = :al_Produto
		AND nr_lote         = :as_Lote
		AND dh_validade     = :adh_Validade
	 USING SQLCA;
	
	If SQLCA.SQLCode <> 0 then
		as_erro = 'Erro ao excluir o produto ' + String (al_Produto) + ' do volume ' + String (al_nr_chv_volume) + ': ' + '~n~r' + SQLCA.SQLErrText
		Return False
	End if
else
	//Diminui a quantidade do produto na caixa
	UPDATE wms_segregado_receb_dev_prd
		SET qt_registrada        = qt_registrada - :al_qt_movimento
		  , qt_capacidade_litros = :ldc_vol_prod_caixa
		  , qt_peso_kg           = :ldc_peso_prod_caixa
	 WHERE nr_chave_volume = :al_nr_chv_volume
		AND cd_produto      = :al_Produto
		AND nr_lote         = :as_Lote
		AND dh_validade     = :adh_Validade
	 USING SQLCA;
	 
	 If SQLCA.SQLCode <> 0 then
		as_erro = 'Erro ao atualizar a quantidade do produto ' + String (al_Produto) + ' no volume ' + String (al_nr_chv_volume) + ': ' + '~n~r' + SQLCA.SQLErrText
		Return False
	End if
	
End if

//Verifica a quantidade de produtos remanescente no volume
//Se ficar vazia e o volume j$$HEX1$$e100$$ENDHEX$$ estiver encerrado, o volume $$HEX1$$e900$$ENDHEX$$ cancelado
//Se n$$HEX1$$e300$$ENDHEX$$o, o peso e volume do produto exclu$$HEX1$$ed00$$ENDHEX$$do $$HEX1$$e900$$ENDHEX$$ subtra$$HEX1$$ed00$$ENDHEX$$do da caixa

//Atualiza o volume
ldc_qt_vol_total_caixa -= (ldc_vol_prod  * al_qt_movimento)
ll_qt_peso_total_caixa -= (ldc_peso_prod * al_qt_movimento)

//Se estiver retirando o $$HEX1$$fa00$$ENDHEX$$ltimo item da caixa, cancela o volume
If (ldc_qt_vol_total_caixa = 0 or &
	 ll_qt_peso_total_caixa = 0) and &
	Not IsNull (ldh_Termino) then
	ldh_Cancelamento     = gf_GetServerDate ()
	ls_matr_cancelamento = gvo_Aplicacao.ivo_seguranca.nr_matricula
	as_erro              = ' ~n~r ' + '$$HEX1$$da00$$ENDHEX$$ltimo produto retirado da caixa. Esta etiqueta foi cancelada.'
else
	SetNull (ldh_Cancelamento)
	SetNull (ls_matr_cancelamento)
End if

UPDATE wms_segregado_receb_dev
	SET qt_capacidade_utilizada   = :ldc_qt_vol_total_caixa
	  , qt_peso_kg                = :ll_qt_peso_total_caixa
	  , dh_cancelamento           = :ldh_Cancelamento
	  , nr_matricula_cancelamento = :ls_matr_cancelamento
 WHERE nr_chave_volume = :al_nr_chv_volume
 USING SQLCA;

If SQLCA.SQLCode <> 0 then
	as_erro = 'Erro ao atualizar o volume ' + String (al_nr_chv_volume) + ': ' + '~n~r' + SQLCA.SQLErrText
	Return False
End if

Return True
end function

on uo_ge642_volumes_excesso.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge642_volumes_excesso.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

