HA$PBExportHeader$uo_ge546_distribuidora_historico_nova.sru
forward
global type uo_ge546_distribuidora_historico_nova from nonvisualobject
end type
end forward

global type uo_ge546_distribuidora_historico_nova from nonvisualobject
end type
global uo_ge546_distribuidora_historico_nova uo_ge546_distribuidora_historico_nova

type variables
string is_Path_Precos 
end variables

forward prototypes
public function boolean of_processa_historico ()
public function boolean of_checa_campos_origem_destino (ref string as_mensagem, ref boolean ab_divergencia)
public function boolean of_grava_log (integer ai_arquivo, string as_mensagem, boolean ab_envia)
end prototypes

public function boolean of_processa_historico ();// funcao para fazer a carga da posicao atual da tabela distribuidora_produto na tabela distribuidora_produto_hist
// todos os dados da distribuidora_produto serao inseridos na distribuidora_produto_hist uma vez por dia (este processo rodara uma vez por dia)
// desta forma poderemos gerar um grafico com a evolucao dos precos dos produtos dia apos dia, conforme solicitacao do usuario

Date 		lvdt_movimento, lvdt_data_ultima_carga, lvdt_data_posicao

Long 		ll_row, ll_cont

Boolean 	lb_retorno

string 	lvs_mensagem, &
			lvs_Path_Precos, &
			lvs_Arquivo_Log

Boolean lvb_divergencia = false

int		lvi_Log

uo_parametro_geral lvo_parametro_geral

lvs_Path_Precos = gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")

if right(lvs_Path_Precos, 1) <> '\' then lvs_Path_Precos += '\'

lvs_Arquivo_Log = lvs_Path_Precos + "carga_distrib_prod_hist_" + String(Today(), "ddmm")

If Not gf_Cria_Logs(lvs_Arquivo_Log, 4, ref lvi_Log) Then
	Return false
End If

of_Grava_Log(lvi_Log, "In$$HEX1$$ed00$$ENDHEX$$cio da Gera$$HEX2$$e700e300$$ENDHEX$$o de Hist$$HEX1$$f300$$ENDHEX$$rico de Condi$$HEX2$$e700f500$$ENDHEX$$es da Distribuidora", false)

lvo_parametro_geral = create uo_parametro_geral

// busca parametro que guarda data da ultima carga de historico 
if not lvo_parametro_geral.of_localiza_parametro( 'DH_CARGA_DISTRIBUIDORA_PRODUTO_HIST', lvdt_data_ultima_carga) then
	of_Grava_Log(lvi_Log, 'Erro ao buscar valor do par$$HEX1$$e200$$ENDHEX$$metro DH_CARGA_DISTRIBUIDORA_PRODUTO_HIST', true)
	FileClose(lvi_Log)
	destroy lvo_parametro_geral
	return false
end if

lvdt_movimento = today()
lvdt_data_posicao = relativedate(lvdt_movimento, -1)

// se a data 
if daynumber(lvdt_data_posicao) = 1 then
	lvdt_data_posicao = relativedate(lvdt_data_posicao, -2)
end if

// se a data da ultima carga for maior ou igual a data desta geracao, nao permite gerar, pois podemos ter somente uma geracao por dia.
if string(lvdt_data_ultima_carga, 'YYYYMMDD') >= string(lvdt_movimento, 'YYYYMMDD') then
	of_Grava_Log(lvi_Log, 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gerar o hist$$HEX1$$f300$$ENDHEX$$rico pois o j$$HEX1$$e100$$ENDHEX$$ houve uma execu$$HEX2$$e700e300$$ENDHEX$$o para o dia ' + string(lvdt_movimento, 'DD/MM/YYYY'), true)
	FileClose(lvi_Log)
	destroy lvo_parametro_geral
	return false
end if

// verifica se ha divergencia entre colunas da tabela origem/destino
if not this.of_checa_campos_origem_destino(lvs_mensagem, lvb_divergencia) then
	of_Grava_Log(lvi_Log, lvs_mensagem, true)
	FileClose(lvi_Log)
	destroy lvo_parametro_geral
	return false
end if

//if lvb_divergencia then
//	of_Grava_Log(lvi_Log, lvs_mensagem, true)
//	FileClose(lvi_Log)
//	destroy lvo_parametro_geral
//	return false
//end if

Open(w_Aguarde)

w_Aguarde.Title = "Gerando carga de hist$$HEX1$$f300$$ENDHEX$$rico das condi$$HEX2$$e700f500$$ENDHEX$$es de pre$$HEX1$$e700$$ENDHEX$$o..."

// insere na tabela de historico a posicao da tabela distribuidora_produto neste momento
// alteracao para gravar o preco de compra do produto, para facilitar o uso do mesmo na aplica$$HEX2$$e700e300$$ENDHEX$$o, na montagem da tela do grafico de historico de precos.

insert into distribuidora_produto_hist
(	
	cd_distribuidora,
	cd_produto,
	cd_unidade_federacao,
	dh_data_posicao,
	cd_produto_distribuidora,
	vl_preco_atual,
	pc_desconto_atual,
	vl_preco_anterior,
	pc_desconto_anterior,
	dh_alteracao_preco_desconto,
	nr_matric_alteracao_preco,
	dh_inclusao,
	id_situacao,
	dh_alteracao_situacao,
	nr_matric_alteracao_situacao,
	de_alteracao_situacao,
	vl_preco_novo,
	pc_desconto_novo,
	pc_repasse_icms,
	pc_icms,
	pc_reducao_base_icms,
	dh_atualizacao_distribuidora,
	vl_preco_base_icms_st,
	vl_icms_st,
	nr_dias_pagamento,
	nr_dias_pagamento_anterior,
	id_situacao_anterior,
	id_produto_hpc,
	pc_desconto_conexao,
	vl_icms_st_farmacia_popular,
	de_codigo_barras_arquivo_preco,
	qt_embalagem_padrao_distrib,
	qt_estoque_disponivel,
	dh_atualizacao_estoque,
	id_estoque_maior_10dias,
	dh_arquivo_estoque,
	pc_comissao_midia,
	cd_imposto_sap,
	dh_alteracao_situacao_termino,
	ncm_produto,
	cd_cest,
	de_produto_distrib,
	cd_cst,
	vl_icms_st_retido,
	vl_bc_st_retido,
	pc_icms_st,
	pc_mva,
	vl_pmc,
	nr_embalagem_distrib,
	dh_exportacao_sap,
	vl_preco_compra,
	pc_promocao_desconto_finan,
	pc_desconto_acordo_sellin,
	dh_exportacao_divergencia_sap
)
select d.cd_distribuidora,
		 d.cd_produto,
		 d.cd_unidade_federacao,
		 :lvdt_data_posicao,
		 d.cd_produto_distribuidora,
		 d.vl_preco_atual,
		 d.pc_desconto_atual,
		 d.vl_preco_anterior,
		 d.pc_desconto_anterior,
		 d.dh_alteracao_preco_desconto,
		 d.nr_matric_alteracao_preco,
		 d.dh_inclusao,
		 d.id_situacao,
		 d.dh_alteracao_situacao,
		 d.nr_matric_alteracao_situacao,
		 d.de_alteracao_situacao,
		 d.vl_preco_novo,
		 d.pc_desconto_novo,
		 d.pc_repasse_icms,
		 d.pc_icms,
		 d.pc_reducao_base_icms,
		 d.dh_atualizacao_distribuidora,
		 d.vl_preco_base_icms_st,
		 d.vl_icms_st,
		 d.nr_dias_pagamento,
		 d.nr_dias_pagamento_anterior,
		 d.id_situacao_anterior,
		 d.id_produto_hpc,
		 d.pc_desconto_conexao,
		 d.vl_icms_st_farmacia_popular,
		 d.de_codigo_barras_arquivo_preco,
		 isnull(d.qt_embalagem_padrao_distrib,1),
		 d.qt_estoque_disponivel,
		 d.dh_atualizacao_estoque,
		 d.id_estoque_maior_10dias,
		 d.dh_arquivo_estoque,
		 d.pc_comissao_midia,
		 d.cd_imposto_sap,
		 d.dh_alteracao_situacao_termino,
		 d.ncm_produto,
		 d.cd_cest,
		 d.de_produto_distrib,
		 d.cd_cst,
		 d.vl_icms_st_retido,
		 d.vl_bc_st_retido,
		 d.pc_icms_st,
		 d.pc_mva,
		 d.vl_pmc,
		 d.nr_embalagem_distrib,
		 d.dh_exportacao_sap,
		 dbo.f_calc_preco_compra(d.cd_produto, d.cd_distribuidora, d.vl_preco_novo, d.vl_preco_atual, d.pc_desconto_conexao, d.pc_desconto_novo, d.pc_desconto_atual, d.pc_repasse_icms, d.vl_icms_st, d.qt_embalagem_padrao_distrib),
		 d.pc_promocao_desconto_finan,
		 d.pc_desconto_acordo_sellin,
		 d.dh_exportacao_divergencia_sap
  from distribuidora_produto d
 inner join produto_central c on c.cd_produto = d.cd_produto
 inner join conexao_distribuidora x on x.cd_distribuidora = d.cd_distribuidora
 where d.cd_produto in (select c.cd_produto from produto_central c
								 inner join conexao p on p.id_projeto_conexao = c.id_projeto_conexao
								 where p.id_situacao in ('A', 'P')) 		 
	and c.id_projeto_conexao = x.id_projeto_conexao
	and x.id_situacao = 'A'
using sqlca;

if sqlca.sqlcode = -1 then
	of_Grava_Log(lvi_Log, 'Erro ao inserir registros na tabela distribuidora_produto_hist (projeto conex$$HEX1$$e300$$ENDHEX$$o). ' + sqlca.sqlerrtext, true)
	FileClose(lvi_Log)
	SqlCa.of_rollback( ); 
	destroy lvo_parametro_geral
	return false
end if

	
// segundo insert, insere historico de precos dos produtos normais, ou seja, daqueles que nao fazem parte do projeto conexao
insert into distribuidora_produto_hist
(	
	cd_distribuidora,
	cd_produto,
	cd_unidade_federacao,
	dh_data_posicao,
	cd_produto_distribuidora,
	vl_preco_atual,
	pc_desconto_atual,
	vl_preco_anterior,
	pc_desconto_anterior,
	dh_alteracao_preco_desconto,
	nr_matric_alteracao_preco,
	dh_inclusao,
	id_situacao,
	dh_alteracao_situacao,
	nr_matric_alteracao_situacao,
	de_alteracao_situacao,
	vl_preco_novo,
	pc_desconto_novo,
	pc_repasse_icms,
	pc_icms,
	pc_reducao_base_icms,
	dh_atualizacao_distribuidora,
	vl_preco_base_icms_st,
	vl_icms_st,
	nr_dias_pagamento,
	nr_dias_pagamento_anterior,
	id_situacao_anterior,
	id_produto_hpc,
	pc_desconto_conexao,
	vl_icms_st_farmacia_popular,
	de_codigo_barras_arquivo_preco,
	qt_embalagem_padrao_distrib,
	qt_estoque_disponivel,
	dh_atualizacao_estoque,
	id_estoque_maior_10dias,
	dh_arquivo_estoque,
	pc_comissao_midia,
	cd_imposto_sap,
	dh_alteracao_situacao_termino,
	ncm_produto,
	cd_cest,
	de_produto_distrib,
	cd_cst,
	vl_icms_st_retido,
	vl_bc_st_retido,
	pc_icms_st,
	pc_mva,
	vl_pmc,
	nr_embalagem_distrib,
	dh_exportacao_sap,
	vl_preco_compra,
	pc_promocao_desconto_finan,
	pc_desconto_acordo_sellin,
	dh_exportacao_divergencia_sap
)
select d.cd_distribuidora,
		 d.cd_produto,
		 d.cd_unidade_federacao,
		 :lvdt_data_posicao,
		 d.cd_produto_distribuidora,
		 d.vl_preco_atual,
		 d.pc_desconto_atual,
		 d.vl_preco_anterior,
		 d.pc_desconto_anterior,
		 d.dh_alteracao_preco_desconto,
		 d.nr_matric_alteracao_preco,
		 d.dh_inclusao,
		 d.id_situacao,
		 d.dh_alteracao_situacao,
		 d.nr_matric_alteracao_situacao,
		 d.de_alteracao_situacao,
		 d.vl_preco_novo,
		 d.pc_desconto_novo,
		 d.pc_repasse_icms,
		 d.pc_icms,
		 d.pc_reducao_base_icms,
		 d.dh_atualizacao_distribuidora,
		 d.vl_preco_base_icms_st,
		 d.vl_icms_st,
		 d.nr_dias_pagamento,
		 d.nr_dias_pagamento_anterior,
		 d.id_situacao_anterior,
		 d.id_produto_hpc,
		 d.pc_desconto_conexao,
		 d.vl_icms_st_farmacia_popular,
		 d.de_codigo_barras_arquivo_preco,
		 isnull(d.qt_embalagem_padrao_distrib,1),
		 d.qt_estoque_disponivel,
		 d.dh_atualizacao_estoque,
		 d.id_estoque_maior_10dias,
		 d.dh_arquivo_estoque,
		 d.pc_comissao_midia,
		 d.cd_imposto_sap,
		 d.dh_alteracao_situacao_termino,
		 d.ncm_produto,
		 d.cd_cest,
		 d.de_produto_distrib,
		 d.cd_cst,
		 d.vl_icms_st_retido,
		 d.vl_bc_st_retido,
		 d.pc_icms_st,
		 d.pc_mva,
		 d.vl_pmc,
		 d.nr_embalagem_distrib,
		 d.dh_exportacao_sap,
		 dbo.f_calc_preco_compra(d.cd_produto, d.cd_distribuidora, d.vl_preco_novo, d.vl_preco_atual, d.pc_desconto_conexao, d.pc_desconto_novo, d.pc_desconto_atual, d.pc_repasse_icms, d.vl_icms_st, d.qt_embalagem_padrao_distrib),
		 d.pc_promocao_desconto_finan,
		 d.pc_desconto_acordo_sellin,
		 d.dh_exportacao_divergencia_sap
  from distribuidora_produto d
 where not exists (select 1 from distribuidora_produto_hist h
 						  where h.cd_distribuidora = d.cd_distribuidora
							 and h.cd_produto = d.cd_produto
							 and h.cd_unidade_federacao = d.cd_unidade_federacao
							 and h.dh_data_posicao = :lvdt_data_posicao)
 using sqlca;
	
Close(w_Aguarde)

if sqlca.sqlcode = -1 then
	of_Grava_Log(lvi_Log, 'Erro ao inserir registros na tabela distribuidora_produto_hist. ' + sqlca.sqlerrtext, true)
	FileClose(lvi_Log)
	SqlCa.of_rollback( ); 
	destroy lvo_parametro_geral
	return false
end if

if not lvo_parametro_geral.of_atualiza_parametro( 'DH_CARGA_DISTRIBUIDORA_PRODUTO_HIST', lvdt_movimento) then
	of_Grava_Log(lvi_Log, 'Erro ao buscar valor do par$$HEX1$$e200$$ENDHEX$$metro DH_CARGA_DISTRIBUIDORA_PRODUTO_HIST', true)
	FileClose(lvi_Log)
	destroy lvo_parametro_geral
	SqlCa.of_rollback( ); 
	return false
end if

SqlCa.of_commit( ); 

of_Grava_Log(lvi_Log, 'Processamento conclu$$HEX1$$ed00$$ENDHEX$$do.', false)
FileClose(lvi_Log)

return true

end function

public function boolean of_checa_campos_origem_destino (ref string as_mensagem, ref boolean ab_divergencia);// Funcao para verificar quantidade de campos da tabela origem e destino estao de acordo.
// Se a diferenca de campos entre as tabelas for diferente de 1, eh porque algum campo novo foi criado na tabela de origem,
// sendo necess$$HEX1$$e100$$ENDHEX$$rio atualizar este processo para incluir esta nova coluna na tabela destino e popula-la
long 	lvl_count_colunas_origem, &
		lvl_count_colunas_destino

//ab_divergencia = false

select count(1) 
  into :lvl_count_colunas_origem
  from syscolumns 
 where object_name(id) = 'distribuidora_produto'
 using sqlca;

if sqlca.sqlcode = -1 then
	as_mensagem += 'Erro ao buscar quantidade de colunas da tabela distribuidora_produto. ' + sqlca.sqlerrtext
	return false
end if

select count(1) 
  into :lvl_count_colunas_destino
  from syscolumns 
 where object_name(id) = 'distribuidora_produto_hist'
 using sqlca;

if sqlca.sqlcode = -1 then
	as_mensagem += 'Erro ao buscar quantidade de colunas da tabela distribuidora_produto_hist. ' + sqlca.sqlerrtext
	return false
end if

// a tabela de destino deve ter uma coluna a mais que a tabela de origem. 
// Se for diferente disso, $$HEX1$$e900$$ENDHEX$$ porque alguma coluna nova foi criada na distribuidora_produto, e $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio atualizar este processo para incluir esta nova coluna
if lvl_count_colunas_destino - 1 <> lvl_count_colunas_origem then
//	ab_divergencia = true
	as_mensagem += "Informativo: H$$HEX1$$e100$$ENDHEX$$ diverg$$HEX1$$ea00$$ENDHEX$$ncias entre as colunas da tabela origem (distribuidora_produto) e destino (distribuidora_produto_hist). " + &
						"Verifique se novas colunas foram adicionadas recentemente na tabela origem e destino (a tabela destino deve ter uma coluna a mais)."
end if

return true

end function

public function boolean of_grava_log (integer ai_arquivo, string as_mensagem, boolean ab_envia);Integer lvi_Write

String lvs_Mensagem
String ls_Anexo[]

lvs_Mensagem = String(Today(), "dd/mm/yyyy") + " " + String(Now(), "hh:mm:ss") + " - " + as_Mensagem

If ab_Envia Then
	//O par$$HEX1$$e200$$ENDHEX$$metro as_mensagem $$HEX1$$e900$$ENDHEX$$ o corpo do e-mail autom$$HEX1$$e100$$ENDHEX$$tico.
	//A vari$$HEX1$$e100$$ENDHEX$$vel lvs_Mensagem $$HEX1$$e900$$ENDHEX$$ a mensagem que grava no log.
	gf_ge202_envia_email_automatico(259, "", as_Mensagem , ls_Anexo)
End If

lvi_Write = FileWrite(ai_Arquivo, lvs_Mensagem)

If lvi_Write = LenA(lvs_Mensagem) Then
	Return True
Else
	gf_ge202_envia_email_automatico(51, "- Hist$$HEX1$$f300$$ENDHEX$$rico de Condi$$HEX2$$e700e300$$ENDHEX$$o das Distribuidoras", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo de LOG. Fun$$HEX2$$e700e300$$ENDHEX$$o of_grava_log (uo_ge546_distribuidora_historico). " + lvs_Mensagem, ls_Anexo[], False)
	
	Return True
End If

end function

on uo_ge546_distribuidora_historico_nova.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge546_distribuidora_historico_nova.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

