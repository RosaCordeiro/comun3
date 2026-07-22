HA$PBExportHeader$uo_ge558_ajuste_lote.sru
forward
global type uo_ge558_ajuste_lote from nonvisualobject
end type
end forward

global type uo_ge558_ajuste_lote from nonvisualobject
end type
global uo_ge558_ajuste_lote uo_ge558_ajuste_lote

type variables
Datetime	idh_validade_original
Datetime	idh_validade_nova

Long		il_produto
Long		il_qtd_cxa_padrao
Long		il_qtd_original
Long		il_qtd_avariada

String	is_lote_original
String	is_lote_novo
String	is_endereco

end variables

forward prototypes
public function boolean of_valida_validade_diferente (long al_produto, string as_lote, datetime adt_validade)
private function boolean of_valida_dados ()
private function boolean of_verifica_movimentacao_produto ()
private function boolean of_verifica_movimentacao (string as_lote)
public function boolean of_ajusta_lote (long al_produto, long al_qtd_cxa_padrao, string as_lote_original, datetime adh_validade_original, long al_qtd_original, string as_lote_novo, datetime adh_validade_nova, long al_qtd_avariada, string as_endereco, string as_matricula)
end prototypes

public function boolean of_valida_validade_diferente (long al_produto, string as_lote, datetime adt_validade);Long	ll_qtd

SELECT count(*) 
  INTO :ll_qtd
  FROM wms_localizacao L
		INNER JOIN vw_wms_endereco E
				  ON L.cd_endereco = E.cd_endereco 
 WHERE L.cd_produto       = :al_produto
	AND E.id_flow_rack     = 'S'
	AND E.id_utiliza_saldo = 'S'
	AND L.nr_lote          = :as_lote
	AND L.dh_validade     <> :adt_validade
 USING SQLCA;

If SQLCA.SQLCode = -1 then
	SQLCA.of_MsgDbError ('Erro ao pesquisar produto/lote com validade diferente na wms_localizacao!')
	Return False
End if

If ll_qtd > 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O lote ' + String (as_lote) + ' do produto ' + String (al_produto) + ' j$$HEX1$$e100$$ENDHEX$$ existe com outra validade!~n~r~rOpera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o permitida!', Exclamation!)
	Return False
End if

Return True
end function

private function boolean of_valida_dados ();Date		ldh_Parametro

If IsNull (il_produto)            or &
	IsNull (il_qtd_cxa_padrao)     or &
	IsNull (il_qtd_original)       or &
	IsNull (il_qtd_avariada)       or &
	IsNull (is_lote_original)      or &
	IsNull (is_lote_novo)          or &
	IsNull (idh_validade_original) or &
	IsNull (idh_validade_nova)     or &
	IsNull (is_endereco)           then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Dados inv$$HEX1$$e100$$ENDHEX$$lidos para a gera$$HEX2$$e700e300$$ENDHEX$$o da movimenta$$HEX2$$e700e300$$ENDHEX$$o.', StopSign!)
	Return False
End If

// Valida data de Validade
ldh_Parametro = Date (gf_GetServerDate ())

If Date (String (idh_validade_nova, 'dd/mm/yyyy')) < Date ('01/' + String (Month (ldh_Parametro), '00') + '/' + string (Year (ldh_Parametro), '00')) or &
	IsNull (idh_validade_nova) then
	If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A data de validade $$HEX1$$e900$$ENDHEX$$ menor do que a data atual.~n~rDeseja continuar?', Question!, YesNo!, 2) = 2 then
		Return False
	End if
End if

// Verifica Conta do Saldo
If il_qtd_avariada <= 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O saldo deve ser maior que zero.')
	Return False
End if

// Verifica em Movimento
If Not of_verifica_movimentacao (is_lote_original) then
	Return False
End if

If Not of_verifica_movimentacao (is_lote_novo) then
	Return False
End if

// Verifica Produto e Lote com Validade Difetente
If Not of_valida_validade_diferente (il_produto, is_lote_novo, idh_validade_nova) then
	Return False
End if

Return True
end function

private function boolean of_verifica_movimentacao_produto ();Date	ldt_Data
Long	ll_Qtde

ldt_Data = RelativeDate (Date (gf_GetServerDate ()), -3)

SELECT COUNT (*)
  INTO :ll_Qtde
  FROM pedido_distribuidora PD
		INNER JOIN wms_lista_separacao LS
				  ON LS.cd_filial               = PD.cd_filial
				 AND LS.nr_pedido_distribuidora = PD.nr_pedido_distribuidora
		INNER JOIN wms_lista_separacao_produto LSP
				  ON LSP.cd_filial               = LS.cd_filial
				 AND LSP.nr_pedido_distribuidora = LS.nr_pedido_distribuidora
				 AND LSP.nr_volume               = LS.nr_volume
 WHERE PD.cd_distribuidora       = '053404705'
	AND PD.id_situacao            not in ('J', 'X')
	AND PD.dh_emissao             >= :ldt_Data
	AND LS.dh_inicio_conferencia  IS NOT NULL
	AND LS.dh_termino_conferencia	IS NULL
	AND LSP.cd_produto            = :il_produto
 USING SQLCA;

If SQLCA.SQLCode = -1 then
	SQLCA.of_MsgDbError ('Erro ao localizar a quantidade pendente da lista de separa$$HEX2$$e700e300$$ENDHEX$$o.')
	Return False
End if

If ll_Qtde > 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O produto est$$HEX1$$e100$$ENDHEX$$ em alguma lista de separa$$HEX2$$e700e300$$ENDHEX$$o que ainda n$$HEX1$$e300$$ENDHEX$$o foi conferida.', Exclamation!)
	Return False
End if

Return True
end function

private function boolean of_verifica_movimentacao (string as_lote);Long	ll_Qtde

SELECT COUNT (*)
 INTO :ll_Qtde
  FROM wms_movimentacao
 WHERE cd_produto = :il_produto
	AND nr_lote    = :as_lote
 USING SQLCA;

If SQLCA.SQLCode = -1 then
	SQLCA.of_MsgDbError ('Erro ao localizar a movimenta$$HEX2$$e700e300$$ENDHEX$$o do produto.')
	Return False
End if

If ll_Qtde > 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O lote ' + as_lote + ' est$$HEX1$$e100$$ENDHEX$$ em movimenta$$HEX2$$e700e300$$ENDHEX$$o.', Exclamation!)
	Return False
End if

Return True
end function

public function boolean of_ajusta_lote (long al_produto, long al_qtd_cxa_padrao, string as_lote_original, datetime adh_validade_original, long al_qtd_original, string as_lote_novo, datetime adh_validade_nova, long al_qtd_avariada, string as_endereco, string as_matricula);//DECLARA$$HEX2$$c700d500$$ENDHEX$$ES

Long		ll_Nulo

String	ls_Nulo,             &
			ls_Endereco_Entrada, &
			ls_Endereco_Saida

uo_ge258_movimentacao	lo_Movimentacao

//PROCEDIMENTOS

SetNull (ls_Nulo)
SetNull (ll_Nulo)

il_produto            = al_produto
il_qtd_cxa_padrao     = al_qtd_cxa_padrao
il_qtd_original       = al_qtd_original
il_qtd_avariada       = al_qtd_avariada
is_lote_original      = as_lote_original
is_lote_novo          = as_lote_novo
idh_validade_original = adh_validade_original
idh_validade_nova     = adh_validade_nova
is_endereco           = as_endereco

/// Valida$$HEX2$$e700f500$$ENDHEX$$es B$$HEX1$$e100$$ENDHEX$$sicas
If Not of_valida_dados () then
	Return False
End if

If Not of_verifica_movimentacao_produto () then
	Return False
End if

Try
	lo_Movimentacao = Create uo_ge258_movimentacao
	
	lo_Movimentacao.ivb_Commit = False
	
	// Gera um movimento de SA$$HEX1$$cd00$$ENDHEX$$DA com a quantidade avariada do lote que est$$HEX1$$e100$$ENDHEX$$ sendo alterado
	SetNull(ls_Endereco_Entrada)
	// cx.padrao alterada de 1 como na janela ws060 pra padr$$HEX1$$e300$$ENDHEX$$o, por causa do pulm$$HEX1$$e300$$ENDHEX$$o
	If Not lo_Movimentacao.of_insere_movimentacao (	ls_Endereco_Entrada,          &
																	is_endereco,                  &
																	il_Produto,                   &
																	il_qtd_cxa_padrao,            &
																	is_lote_original,             &
																	Date (idh_validade_original), &
																	il_qtd_avariada,              &
																	'K',                          &
																	ll_Nulo,                      &
																	ls_Nulo,                      &
																	ll_Nulo,                      &
																	ls_Nulo,                      &
																	ls_Nulo,                      &
																	as_Matricula,                 &
																	ll_Nulo) then
		SqlCa.of_Rollback()
		Return False	
	End If
	
	// Gera um movimento de ENTRADA para o lote novo
	SetNull(ls_Endereco_Saida)
	
	If Not lo_Movimentacao.of_insere_movimentacao ( is_endereco,              &
																	ls_Endereco_Saida,        &
																	il_Produto,               &
																	il_qtd_cxa_padrao,        &
																	is_lote_novo,             &
																	Date (idh_validade_nova), &
																	al_qtd_avariada,          &
																	'K',                      &
																	ll_Nulo,                  &
																	ls_Nulo,                  &
																	ll_Nulo,                  &
																	ls_Nulo,                  &
																	ls_Nulo,                  &
																	as_Matricula,             &
																	ll_Nulo) then
		SqlCa.of_Rollback()
		Return False
	End If
	
Finally
	If IsValid (lo_Movimentacao) then Destroy lo_Movimentacao
End Try

Return True
end function

on uo_ge558_ajuste_lote.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge558_ajuste_lote.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

