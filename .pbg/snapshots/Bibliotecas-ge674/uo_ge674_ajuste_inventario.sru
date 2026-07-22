HA$PBExportHeader$uo_ge674_ajuste_inventario.sru
forward
global type uo_ge674_ajuste_inventario from nonvisualobject
end type
end forward

global type uo_ge674_ajuste_inventario from nonvisualobject
end type
global uo_ge674_ajuste_inventario uo_ge674_ajuste_inventario

type variables
dc_uo_ds_base ids_pendentes
dc_uo_ds_base ids_itens
long      il_nr_integracao
string    is_ultimo_erro
end variables

forward prototypes
public function integer of_executar ()
public function integer of_inserir_itens (long al_nr_inventario, long al_nr_integracao, string as_id_entrada_saida)
public function integer of_inserir_cabecalho (long al_nr_inventario, ref long al_nr_integracao)
end prototypes

public function integer of_executar ();// ============================================================
// of_executar
// Orquestra todo o processo de integra$$HEX2$$e700e300$$ENDHEX$$o de invent$$HEX1$$e100$$ENDHEX$$rios
// ============================================================
Integer li_ret
Long    ll_row, ll_total, ll_nr_inventario


// --- 1. Inicializa datastores ---
ids_pendentes = CREATE dc_uo_ds_base
ids_pendentes.DataObject = 'ds_ge674_lista_inventarios_sem_wis'
ids_pendentes.SetTransObject(SQLCA)

ids_itens = CREATE dc_uo_ds_base
ids_itens.DataObject = 'ds_ge674_lista_itens_inventarios'
ids_itens.SetTransObject(SQLCA)

// --- 2. Busca invent$$HEX1$$e100$$ENDHEX$$rios pendentes ---
ll_total = ids_pendentes.Retrieve()

IF ll_total <= 0 THEN
    is_ultimo_erro = 'Nenhum invent$$HEX1$$e100$$ENDHEX$$rio pendente de integra$$HEX2$$e700e300$$ENDHEX$$o encontrado.'
    RETURN -1
END IF

// --- 3. Busca o maior nr_integracao atual ---
SELECT MAX(nr_integracao)
INTO :il_nr_integracao
FROM wms_int_sap;

IF SQLCA.SQLCode <> 0 THEN
    is_ultimo_erro = 'Erro ao buscar MAX(nr_integracao): ' + SQLCA.SQLErrText
    RETURN -1
END IF

IF IsNull(il_nr_integracao) THEN il_nr_integracao = 0

// --- 4. Loop por cada invent$$HEX1$$e100$$ENDHEX$$rio pendente ---
FOR ll_row = 1 TO ll_total

    ll_nr_inventario = ids_pendentes.GetItemNumber(ll_row, 'nr_inventario')

    // --- 4a. Insere cabe$$HEX1$$e700$$ENDHEX$$alho ---
    li_ret = of_inserir_cabecalho(ll_nr_inventario, il_nr_integracao)
    IF li_ret = -1 THEN
        ROLLBACK USING SQLCA;
        RETURN -1
    END IF

	COMMIT USING SQLCA;
	IF SQLCA.SQLCode <> 0 THEN
		 is_ultimo_erro = 'Erro no COMMIT: ' + SQLCA.SQLErrText
		 RETURN -1
	END IF
NEXT

// --- 6. Destroi datastores ---
DESTROY ids_pendentes
DESTROY ids_itens

RETURN 1
end function

public function integer of_inserir_itens (long al_nr_inventario, long al_nr_integracao, string as_id_entrada_saida);// ============================================================
// of_inserir_itens
// Insere linhas em wms_int_sap_detalhe para o invent$$HEX1$$e100$$ENDHEX$$rio.
// ============================================================
Long    	ll_row, ll_total, ll_seq, ll_cd_produto
String  	ls_nr_lote, ls_id_ent_saida, ls_dep_entrada, ls_dep_saida
Decimal	ld_qt_ajustada
Datetime	ldt_validade, ldt_null

ll_seq   	= 10   // sequencial inicial (incrementa de 10 em 10 como no identity original)
ll_total 	= ids_itens.Retrieve(al_nr_inventario, as_id_entrada_saida)

IF ll_total < 0 THEN
	is_ultimo_erro = 'Erro Retrieve itens inv ' + String(al_nr_inventario) + ': ' + SQLCA.SQLErrText
	RETURN -1
END IF

IF ll_total = 0 THEN
	is_ultimo_erro = 'Nenhum item encontrado para o inv ' + String(al_nr_inventario)
	RETURN -1
END IF

FOR ll_row = 1 TO ll_total

	ll_cd_produto		= ids_itens.GetItemNumber  (ll_row, 'cd_produto')
	ls_nr_lote    		= ids_itens.GetItemString  (ll_row, 'nr_lote')
	ld_qt_ajustada 		= ids_itens.GetItemDecimal (ll_row, 'qt_ajustada')
	ldt_validade   		= ids_itens.GetItemDateTime(ll_row, 'dh_validade')
	ls_id_ent_saida  	= ids_itens.GetItemString  (ll_row, 'id_entrada_saida')
	ls_dep_entrada   	= ids_itens.GetItemString  (ll_row, 'cd_deposito_entrada')
	ls_dep_saida     	= ids_itens.GetItemString  (ll_row, 'cd_deposito_saida')
	
	INSERT INTO wms_int_sap_detalhe (
		nr_integracao,
		nr_sequencial,
		cd_produto,
		nr_lote,
		qt_lote,
		dh_fabricacao,
		dh_validade,
		cd_chave_movimento_estoque_wms,
		nr_ajuste_estoque,
		id_entrada_saida,
		cd_deposito_sap_entrada,
		cd_deposito_sap_saida
	) VALUES (
		:al_nr_integracao,
		:ll_seq,
		:ll_cd_produto,
		:ls_nr_lote,
		:ld_qt_ajustada,
		NULL,               // dh_fabricacao $$HEX1$$1420$$ENDHEX$$ n$$HEX1$$e300$$ENDHEX$$o dispon$$HEX1$$ed00$$ENDHEX$$vel
		:ldt_validade,
		NULL,               // cd_chave_movimento_estoque_wms $$HEX1$$1420$$ENDHEX$$ verificar regra
		1,
		:ls_id_ent_saida,
		:ls_dep_entrada,
		:ls_dep_saida
	) USING SQLCA;
	
	IF SQLCA.SQLCode <> 0 THEN
		is_ultimo_erro = 'Erro INSERT detalhe inv ' + String(al_nr_inventario) + &
					 ' seq ' + String(ll_seq) + ': ' + SQLCA.SQLErrText
		RETURN -1
	END IF
	
	ll_seq = ll_seq + 10

NEXT

RETURN 1
end function

public function integer of_inserir_cabecalho (long al_nr_inventario, ref long al_nr_integracao);// ============================================================
// of_inserir_cabecalho
// Insere 1 linha em wms_int_sap para o invent$$HEX1$$e100$$ENDHEX$$rio informado.
// Pode gerar 2 linhas se houver movimentos de entrada E sa$$HEX1$$ed00$$ENDHEX$$da.
// ============================================================
Boolean 	lb_tem_s, lb_tem_e
Integer	li_ret, li_qtd_dir, li_i
Long		ll_row, ll_total
String		ls_tipo_mov, ls_direcao, ls_id_ent_saida, ls_direcoes[]

// Busca os movimentos distintos (S e/ou E) para esse invent$$HEX1$$e100$$ENDHEX$$rio
ll_total = ids_itens.Retrieve(al_nr_inventario, 'T')

IF ll_total < 0 THEN
	is_ultimo_erro = 'Erro Retrieve cabe$$HEX1$$e700$$ENDHEX$$alho inv ' + String(al_nr_inventario) + ': ' + ids_itens.ivo_dberror.ivs_sqlerrtext
	RETURN -1
END IF

// Monta lista de dire$$HEX2$$e700f500$$ENDHEX$$es distintas presentes nesse invent$$HEX1$$e100$$ENDHEX$$rio
FOR ll_row = 1 TO ll_total
	ls_id_ent_saida = ids_itens.GetItemString(ll_row, 'id_entrada_saida')
	IF ls_id_ent_saida = 'S' THEN lb_tem_s = TRUE
	IF ls_id_ent_saida = 'E' THEN lb_tem_e = TRUE
	IF lb_tem_e AND lb_tem_s THEN EXIT
NEXT

// Insere uma linha por dire$$HEX2$$e700e300$$ENDHEX$$o encontrada
IF lb_tem_s THEN
	al_nr_integracao ++
	
	INSERT INTO wms_int_sap (
		nr_integracao, 
		cd_tipo, 
		dh_inclusao, 
		id_situacao,
		cd_fornecedor, 
		cd_filial,
		dh_envio_sap, 
		dh_retorno_sap, 
		cd_transportadora,
		qt_volume, 
		de_especie_volume, 
		de_marca_volume, 
		nr_volume,
		qt_peso_liquido, 
		qt_peso_bruto, 
		de_dados_adicionais,
		nr_nf, 
		de_especie, 
		de_serie, 
		cd_motivo_devolucao,
		cd_tipo_movimento_sap, 
		cd_direcao_movimento_sap, 
		nr_inventario
	) VALUES (
		:al_nr_integracao, 
		3, 
		GetDate(), 
		'C',
		NULL, 
		534,
		NULL, 
		NULL, 
		NULL,
		NULL, 
		NULL, 
		NULL, 
		NULL,
		NULL, 
		NULL, 
		NULL,
		NULL, 
		NULL, 
		NULL, 
		NULL,
		'ZIS', 
		'3', 
		:al_nr_inventario
	) 
	USING SQLCA;
	
	IF SQLCA.SQLCode <> 0 THEN
		is_ultimo_erro = 'Erro INSERT cabecalho (S) inv ' + String(al_nr_inventario) + ': ' + SQLCA.SQLErrText
		RETURN -1
	END IF
	
	li_ret = of_inserir_itens(al_nr_inventario, al_nr_integracao, 'S')
	IF li_ret = -1 THEN
		ROLLBACK USING SQLCA;
		RETURN -1
	END IF
END IF

IF lb_tem_e THEN
	al_nr_integracao ++
	
	INSERT INTO wms_int_sap (
		nr_integracao, 
		cd_tipo, 
		dh_inclusao, 
		id_situacao,
		cd_fornecedor, 
		cd_filial,
		dh_envio_sap, 
		dh_retorno_sap, 
		cd_transportadora,
		qt_volume, 
		de_especie_volume, 
		de_marca_volume, 
		nr_volume,
		qt_peso_liquido, 
		qt_peso_bruto, 
		de_dados_adicionais,
		nr_nf, 
		de_especie, 
		de_serie, 
		cd_motivo_devolucao,
		cd_tipo_movimento_sap, 
		cd_direcao_movimento_sap, 
		nr_inventario
	) VALUES (
		:al_nr_integracao, 
		3, 
		GetDate(), 
		'C',
		NULL, 
		534,
		NULL, 
		NULL, 
		NULL,
		NULL, 
		NULL, 
		NULL, 
		NULL,
		NULL, 
		NULL, 
		NULL,
		NULL, 
		NULL, 
		NULL, 
		NULL,
		'ZIV', 
		'5', 
		:al_nr_inventario
	) USING SQLCA;
	
	IF SQLCA.SQLCode <> 0 THEN
		is_ultimo_erro = 'Erro INSERT cabecalho (E) inv ' + String(al_nr_inventario) + ': ' + SQLCA.SQLErrText
		RETURN -1
	END IF
	
	li_ret = of_inserir_itens(al_nr_inventario, al_nr_integracao, 'E')
	IF li_ret = -1 THEN
		ROLLBACK USING SQLCA;
		RETURN -1
	END IF
END IF

RETURN 1
end function

on uo_ge674_ajuste_inventario.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge674_ajuste_inventario.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

