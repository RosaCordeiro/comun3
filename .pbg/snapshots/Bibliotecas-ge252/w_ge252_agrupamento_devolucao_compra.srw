HA$PBExportHeader$w_ge252_agrupamento_devolucao_compra.srw
forward
global type w_ge252_agrupamento_devolucao_compra from dc_w_sheet
end type
type tab_1 from tab within w_ge252_agrupamento_devolucao_compra
end type
type tabpage_1 from userobject within tab_1
end type
type cb_7 from commandbutton within tabpage_1
end type
type cb_etiq_vol from commandbutton within tabpage_1
end type
type dw_12 from dc_uo_dw_base within tabpage_1
end type
type cb_3 from commandbutton within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type cb_etiquetas from commandbutton within tabpage_1
end type
type cb_incluir from commandbutton within tabpage_1
end type
type cb_inserir_volume from commandbutton within tabpage_1
end type
type cb_reabrir from commandbutton within tabpage_1
end type
type cb_resolver from commandbutton within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type dw_2 from dc_uo_dw_base within tabpage_1
end type
type cb_alterar from commandbutton within tabpage_1
end type
type cb_cancelar from commandbutton within tabpage_1
end type
type gb_6 from groupbox within tabpage_1
end type
type dw_9 from dc_uo_dw_base within tabpage_1
end type
type cb_fechar from commandbutton within tabpage_1
end type
type dw_10 from dc_uo_dw_base within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type cb_5 from commandbutton within tabpage_1
end type
type cb_6 from commandbutton within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_7 cb_7
cb_etiq_vol cb_etiq_vol
dw_12 dw_12
cb_3 cb_3
cb_2 cb_2
cb_etiquetas cb_etiquetas
cb_incluir cb_incluir
cb_inserir_volume cb_inserir_volume
cb_reabrir cb_reabrir
cb_resolver cb_resolver
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
cb_alterar cb_alterar
cb_cancelar cb_cancelar
gb_6 gb_6
dw_9 dw_9
cb_fechar cb_fechar
dw_10 dw_10
st_1 st_1
cb_5 cb_5
cb_6 cb_6
end type
type tabpage_2 from userobject within tab_1
end type
type st_2 from statictext within tabpage_2
end type
type gb_3 from groupbox within tabpage_2
end type
type dw_3 from dc_uo_dw_base within tabpage_2
end type
type dw_8 from dc_uo_dw_base within tabpage_2
end type
type cb_buscar from commandbutton within tabpage_2
end type
type st_mensagem from statictext within tabpage_2
end type
type cb_1 from commandbutton within tabpage_2
end type
type cb_4 from commandbutton within tabpage_2
end type
type cb_alterar_lote from commandbutton within tabpage_2
end type
type tabpage_2 from userobject within tab_1
st_2 st_2
gb_3 gb_3
dw_3 dw_3
dw_8 dw_8
cb_buscar cb_buscar
st_mensagem st_mensagem
cb_1 cb_1
cb_4 cb_4
cb_alterar_lote cb_alterar_lote
end type
type tabpage_3 from userobject within tab_1
end type
type cb_alterar_nota from commandbutton within tabpage_3
end type
type gb_4 from groupbox within tabpage_3
end type
type dw_4 from dc_uo_dw_base within tabpage_3
end type
type dw_6 from dc_uo_dw_base within tabpage_3
end type
type dw_11 from dc_uo_dw_base within tabpage_3
end type
type st_3 from statictext within tabpage_3
end type
type tabpage_3 from userobject within tab_1
cb_alterar_nota cb_alterar_nota
gb_4 gb_4
dw_4 dw_4
dw_6 dw_6
dw_11 dw_11
st_3 st_3
end type
type tabpage_4 from userobject within tab_1
end type
type gb_5 from groupbox within tabpage_4
end type
type dw_5 from dc_uo_dw_base within tabpage_4
end type
type dw_7 from dc_uo_dw_base within tabpage_4
end type
type tabpage_4 from userobject within tab_1
gb_5 gb_5
dw_5 dw_5
dw_7 dw_7
end type
type tabpage_5 from userobject within tab_1
end type
type dw_13 from dc_uo_dw_base within tabpage_5
end type
type gb_7 from groupbox within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_13 dw_13
gb_7 gb_7
end type
type tabpage_6 from userobject within tab_1
end type
type dw_14 from dc_uo_dw_base within tabpage_6
end type
type gb_8 from groupbox within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_14 dw_14
gb_8 gb_8
end type
type tab_1 from tab within w_ge252_agrupamento_devolucao_compra
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type
type dw_15 from datawindow within w_ge252_agrupamento_devolucao_compra
end type
type sle_localizar from singlelineedit within w_ge252_agrupamento_devolucao_compra
end type
end forward

global type w_ge252_agrupamento_devolucao_compra from dc_w_sheet
string accessiblename = "Devolu$$HEX2$$e700e300$$ENDHEX$$o de Produtos Vencidos para Fornecedor (GE252)"
integer width = 6327
integer height = 2512
string title = "GE252 - Devolu$$HEX2$$e700e300$$ENDHEX$$o de Produtos Agrupados por Fornecedor"
long backcolor = 80269524
event ue_recuperar ( )
tab_1 tab_1
dw_15 dw_15
sle_localizar sle_localizar
end type
global w_ge252_agrupamento_devolucao_compra w_ge252_agrupamento_devolucao_compra

type variables
uo_fornecedor ivo_fornecedor
uo_fornecedor ivo_forn
uo_produto ivo_produto
//uo_usuario	ivo_Usuario
uo_ge149_comprador io_Comprador
uo_ge258_movimentacao ivo_Movimentacao
uo_ge252_agrupamento_devolucao_compra ivo_Agrup_Dev_Compra

string ivs_valida_forn,&
		ivs_situacao,&
		ivs_Endereco_Agrupamento,&
		ivs_Endereco_Vencido_Danificado
		
string ivs_nova_regra_vencido_danificado, is_chave_movimento_estoque

long ivl_Linha_Selecionada, il_cd_motivo_devolucao_defeito_fabrica
long al_Agrupamentos_array[]
Long al_Array_Null []
date ivdt_Movimento

Boolean ib_Imprimir_Etiqueta, ib_Iniciado_Operacao_SAP = False, ib_envia_sol_descarte_sap = False

st_parametros_protocolo ist_parametros_protocolo

Boolean ivb_Valida_Inventario = False 
Boolean ivb_Endereco_Bloqueado = False
Boolean	ivb_Check, ivb_Check_Fechar, ivb_Check_Resolver

Boolean ib_transportadora_informada = False
String is_Cod_Transportador, is_Obs_NF

//Variaveis de controle de inser$$HEX2$$e700e300$$ENDHEX$$o de wms_int_sap por nota de origem / Devolu$$HEX2$$e700e300$$ENDHEX$$o
Long 		il_cd_filial_origem_ant			= 0
Long		il_nr_nf_origem_ant				= 0
Long		il_seq_wms							= 0
Long		il_nr_integracao					= 0
String 	is_cd_fornecedor_origem_ant	= ''
String	is_de_especie_origem_ant		= ''
String	is_de_serie_ant					= ''
String	is_de_chave_acesso				= ''
end variables

forward prototypes
public function boolean wf_verifica_pendente ()
public subroutine wf_atualiza_valores ()
public function integer wf_verifica_produto_distribuidora (long al_produto, string as_fornecedor)
public function boolean wf_preco_reposicao (long al_produto, ref decimal adc_preco_reposicao)
public function boolean wf_responsavel (ref string as_matricula, string as_procedimento)
public function boolean wf_atualiza_produto_agrupamento (integer al_agrupamento, long al_produto, decimal adc_preco, decimal adc_desconto)
public function boolean wf_situacao_agrupamento (ref string as_situacao)
public function boolean wf_update_valor_agrupamento (decimal adc_valor, long al_nr_agrupamento)
public function boolean wf_verifica_fornecedor_dev_compra (string as_fornecedor_usual, string as_fornecedor_agrupamento)
public function boolean wf_excluir_agrupamento_dev_produdo (integer ai_agrupamento, integer ai_produto, string as_endereco, string as_lote)
public function boolean wf_tipo_ajuste (long al_produto, ref string as_endereco, ref string as_lote, ref datetime adh_validade, ref long al_saldo)
public function boolean wf_carrega_parametro ()
public function boolean wf_deleta_produto (long al_agrupamento, long al_produto, string as_endereco, string as_lote, datetime adh_validade, long al_qtde, string as_destino_final, ref string as_erro)
public function boolean wf_localiza_sequencial_saldo (string as_endereco, long al_produto, string as_lote, date adt_validade, ref long al_sequencial, ref long al_saldo, ref string as_erro)
public function boolean wf_baixa_reserva_item_nf_compra_lote (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, long al_natureza_operacao, long al_produto, string as_lote, long al_qtde, ref string as_erro)
public function boolean wf_situacao_agrupamento_fechar (long al_agrupamento, ref string as_situacao)
public function boolean wf_altera_tipo_agrupamento (long al_agrupamento)
public function boolean wf_valida_notas_fornecedor (long al_agrupamento, ref string as_erro)
public function boolean wf_ajuste_entrada_vencido_danificado (long al_produto, string as_endereco, date adh_validade, long al_qtde_movimento, string as_lote, string as_responsavel, ref string as_erro)
public function boolean wf_exclui_nota_compra (long al_agrupamento, long al_produto, string as_endereco_agrupamento, string as_lote, long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, long al_natureza_operacao, ref string as_erro)
public function boolean wf_notas_canceladas (long al_agrupamento)
public function boolean wf_devolver_reserva_notas_compra (long al_agrupamento)
public function boolean wf_gera_nota_devolucao_compra (long al_agrupamento, string as_responsavel, boolean ab_agrupar_notas, ref string as_notas_geradas, ref string as_erro)
public subroutine wf_imprime_etiquetas_volume (string as_fornecedor, string as_nfe, string as_nfo, long al_volumes)
protected function boolean wf_comprador_do_produto (long al_produto, ref string as_matricula_comprador, ref string as_nm_comprador)
public function boolean wf_localiza_parametro_regra_vencido ()
public function boolean wf_gera_coleta_pendente (long al_agrupamento, ref string as_erro)
public function boolean wf_reabrir_agrupamento_descarte (long al_agrupamento, string as_responsavel, ref string as_erro)
public function boolean wf_divisao_forncedor_produto (string as_fornecedor, long al_produto, ref long al_divisao_fornecedor, ref string as_nm_divisao_fornecedor)
public function boolean wf_verifica_saldo_produto (long al_agrupamento)
public function boolean wf_baixa_reserva_item_nf_transf_lote (long al_filial, long al_nota, string as_especie, string as_serie, long al_natureza_operacao, long al_produto, string as_lote, ref long al_qtde, ref string as_erro)
public function boolean wf_verifica_notas_agrupamento (long al_agrupamento)
public function boolean wf_notas_diversas_canceladas (long al_agrupamento)
public function boolean wf_carrega_chave_movimento_estoque (ref string ps_log)
public function boolean wf_verifica_protocolo ()
public subroutine _documentacao ()
public subroutine wf_ajusta_lista_compras ()
public function boolean wf_busca_param_envia_solicitacao_descart (ref string as_log)
public function boolean wf_retira_reserva (long al_agrupamento, long al_produto, string as_endereco_agrupamento, string as_lote, boolean ab_resolvido, ref string as_erro, boolean ab_cancelar, long al_nr_nf, string as_de_serie, string as_de_especie, string as_cd_fornecedor)
public function boolean wf_retira_reserva (long al_agrupamento, long al_produto, string as_endereco_agrupamento, string as_lote, boolean ab_resolvido, ref string as_erro, boolean ab_cancelar)
public function boolean wf_retira_produtos_reserva_agrupamento (long al_agrupamento, ref string as_erro)
public function boolean wf_deleta_produto_nf (long al_agrupamento, long al_produto, string as_endereco, string as_lote, datetime adh_validade, long al_qtde, string as_destino_final, long al_nr_nf, string as_de_serie, string as_de_especie, string as_cd_fornecedor, ref string as_erro)
public function boolean wf_usuario_liberado (string as_matricula, ref boolean ab_usuario_liberado)
public function boolean wf_resolve_agrupamento (long al_linha, string as_obs, string as_responsavel, boolean ab_usuario_liberado, string as_tipo_resolucao, ref string as_resolvidos)
public function boolean wf_valida_wms_int_sap (long al_nr_agrupamento, ref long al_count_problemas, ref string as_log)
public function boolean wf_movimenta_produto (long al_produto, string as_endereco_saida, string as_endereco_destino, string as_lote, datetime adh_validade, long al_qtde, string as_matricula, string as_tipo_movimento, long al_agrupamento, ref string as_erro)
public function boolean wf_movimenta_saldo_divergente_para_agrup (long al_cd_produto, string as_nr_lote, datetime adt_dh_validade, long al_qt_caixa_padrao, long al_qt_movto, string as_cd_endereco_saida, string as_cd_endereco_entrada, string as_cd_fornecedor_agrup, long al_nr_nf_agrup, string as_de_especie_agrup, string as_de_serie_agrup, string as_nr_lote_agrup, datetime adt_dh_validade_agrup, long al_qt_caixa_padrao_agrup, long al_agrupamento, ref string as_erro)
public function boolean wf_qtde_produto (string as_acao, ref long al_qtde)
public function boolean wf_verifica_protocolo_agrupamento (long al_produto, string as_lote, long al_agrupamento, ref long al_qtde)
public function boolean wf_processa_exclusao_produto (long al_linha, string as_situacao_exclusao)
public function boolean wf_reinsere_produto (long al_linha, long al_qtde, string as_novo_agrupamento)
public function boolean wf_inserir_wms_int_sap (long al_agrupamento, long al_produto, string as_lote, long al_cd_motivo_devolucao, datetime adh_validade, string as_endereco, long al_linha, string as_cd_fornecedor_agrupamento, string as_destino_final, string as_responsavel, string as_cd_endereco_origem, long al_nr_nf_compra, string as_de_especie_compra, string as_de_serie_compra, long al_qt_notas, long al_contador_notas, long al_qt_sem_nota, string as_cod_transportadora, string as_observacao_transp, long al_motivo_ajuste, long al_cd_filial_origem)
end prototypes

event ue_recuperar();Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
end event

public function boolean wf_verifica_pendente ();Long lvl_Modificado

Tab_1.TabPage_2.dw_3.AcceptText()

lvl_Modificado = Tab_1.TabPage_2.dw_3.ModifiedCount() + Tab_1.TabPage_2.dw_3.DeletedCount()
							 
If lvl_Modificado > 0 Then
	Return True
Else
	Return False
End If
end function

public subroutine wf_atualiza_valores ();Integer lvi_Linha,&
		lvi_Linhas,&
		lvi_Agrupamento
		
Decimal lvdc_Valor
		
lvi_Linhas = Tab_1.TabPage_1.dw_2.RowCount()

For lvi_Linha = 1 To lvi_Linhas 
	
	lvi_Agrupamento = Tab_1.TabPage_1.dw_2.Object.nr_agrupamento[lvi_Linha]
	
	Select Sum(Round((l.qt_devolver * ( p.vl_preco_reposicao  * (1 - ( p.pc_desconto_fornecedor /100)))),2) )
	Into :lvdc_Valor
	From agrupamento_dev_compra_prd l, 
		 produto_central p
	Where l.nr_agrupamento =:lvi_Agrupamento
  	  and p.cd_produto = l.cd_produto
	Using SqlCa;
	
	If SqlCa.Sqlcode = -1 Then
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do valor da devolu$$HEX2$$e700e300$$ENDHEX$$o")
		lvdc_Valor = 0
	End If
	
	If IsNull(lvdc_Valor) Then lvdc_Valor = 0
		
	Tab_1.TabPage_1.dw_2.Object.vl_devolucao[lvi_Linha] = lvdc_Valor
Next


end subroutine

public function integer wf_verifica_produto_distribuidora (long al_produto, string as_fornecedor);Integer lvi_Contador, lvi_Retorno = 0

Select count(id_situacao)
Into  :lvi_Contador
From distribuidora_produto
 Where cd_produto 			= :al_Produto
 And cd_distribuidora 			= :as_Fornecedor
And id_situacao				= 'A'
Using SqlCa;
			
If SqlCa.SqlCode <> -1 Then
	If lvi_Contador > 0 Then
		lvi_Retorno = lvi_Contador
	End If
Else
	SqlCa.of_MsgDbError("Erro ao localizar o produto  na distribuidora")
	lvi_Retorno = -1
End If
		
Return lvi_Retorno
end function

public function boolean wf_preco_reposicao (long al_produto, ref decimal adc_preco_reposicao);Select round(vl_preco_reposicao  * ((100 - pc_desconto_fornecedor) /100) , 2)
Into :adc_preco_reposicao
From	produto_central
Where cd_produto =:al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If adc_Preco_Reposicao < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o esta com o valor negativo.")
			Return False
		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o do produto n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
		Return False
	Case -1 
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do valor de reposi$$HEX2$$e700e300$$ENDHEX$$o do produto")
		Return False
End Choose

Return True
	

end function

public function boolean wf_responsavel (ref string as_matricula, string as_procedimento);//dc_uo_aplicacao lvo_Aplicacao
//lvo_Aplicacao = Create dc_uo_aplicacao
//lvo_Aplicacao.ivo_seguranca.cd_sistema = "WS"

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento(as_procedimento, ref as_matricula) Then 
	Return False
End If

//Destroy(lvo_Aplicacao)

Return True
end function

public function boolean wf_atualiza_produto_agrupamento (integer al_agrupamento, long al_produto, decimal adc_preco, decimal adc_desconto);Update agrupamento_dev_compra_prd
Set vl_preco = :adc_preco,
	 pc_desconto_forn = :adc_desconto
where nr_agrupamento = :al_agrupamento
and cd_produto = :al_produto
Using SqlCa;

If  SqlCa.SqlCode = 0 Then
	//SqlCa.of_Commit()
	Return True
Else
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do produto do agrupamento")
	SqlCa.of_Rollback();
	Return False
End If




end function

public function boolean wf_situacao_agrupamento (ref string as_situacao);Long lvl_Agrupamento

Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Agrupamento = Tab_1.TabPage_1.dw_2.Object.nr_agrupamento[Tab_1.TabPage_1.dw_2.GetRow()]

Select id_situacao
Into :as_Situacao
From agrupamento_dev_compra
Where nr_agrupamento =:lvl_Agrupamento
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		// Aberto
		If IsNull(as_Situacao) Then as_Situacao = 'A'
			
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O agrupamento n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do agrupamento.")
End Choose

Return True
end function

public function boolean wf_update_valor_agrupamento (decimal adc_valor, long al_nr_agrupamento);Update agrupamento_dev_compra
Set 	  vl_agrupamento =:adc_Valor
Where nr_agrupamento =:al_Nr_Agrupamento
Using SqlCa;

If  SqlCa.SqlCode <> 0 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do valor total do agrupamento")
	SqlCa.of_Rollback();
	Return False
Else
	//SqlCa.of_Commit();
	Return True
End If


end function

public function boolean wf_verifica_fornecedor_dev_compra (string as_fornecedor_usual, string as_fornecedor_agrupamento);String lvs_Fornecedor_Devolucao,&
		lvs_Fantasia

Select cd_fornecedor_dev_compra
Into :lvs_Fornecedor_Devolucao
From fornecedor
Where cd_fornecedor = :as_Fornecedor_Usual
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0	
		If Not IsNull(lvs_Fornecedor_Devolucao) And lvs_Fornecedor_Devolucao <> as_Fornecedor_Agrupamento Then

			ivo_Fornecedor.of_Localiza_Codigo(lvs_Fornecedor_Devolucao)
		
			If ivo_Fornecedor.Localizado Then
				lvs_Fantasia = ivo_Fornecedor.nm_fantasia + " - (" + lvs_Fornecedor_Devolucao + ")"
			End If
				
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Este produto s$$HEX1$$f300$$ENDHEX$$ poder$$HEX1$$e100$$ENDHEX$$ ser devolvido para o fornecedor '" + lvs_Fantasia + "' .")
			Return False
		End If
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O fornecedor usual para a devolu$$HEX2$$e700e300$$ENDHEX$$o de compra n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
		Return False
		
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do fornecedor devolu$$HEX2$$e700e300$$ENDHEX$$o compra")
		Return False
End Choose

Return True

end function

public function boolean wf_excluir_agrupamento_dev_produdo (integer ai_agrupamento, integer ai_produto, string as_endereco, string as_lote);Delete from agrupamento_dev_compra_prd
Where nr_agrupamento =:ai_Agrupamento
And cd_produto =:ai_Produto
And cd_endereco_localizacao =:as_Endereco
And nr_lote =:as_Lote
Using sqlca;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o agrupamento de devolu$$HEX2$$e700e300$$ENDHEX$$o de produto.")
	Return False
End If

Return True
end function

public function boolean wf_tipo_ajuste (long al_produto, ref string as_endereco, ref string as_lote, ref datetime adh_validade, ref long al_saldo);st_parametros_tipo_ajuste lst_Parametro

OpenWithParm(w_ge252_tipo_ajuste, al_Produto)
lst_Parametro = Message.PowerObjectParm	

If lst_Parametro.id_confirmado <> "S" Then
	Return False
Else
	as_Endereco 	= lst_Parametro.endereco
	as_Lote			= lst_Parametro.lote
	adh_Validade	= lst_Parametro.validade
	al_Saldo			= lst_Parametro.qt_saldo
	Return True
End If
end function

public function boolean wf_carrega_parametro ();Select vl_parametro
Into :ivs_Endereco_Vencido_Danificado
From wms_parametro 
Where cd_parametro = 'CD_ENDERECO_SEGREGADO_VENCIDO_DANIFICADO'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro do WMS n$$HEX1$$e300$$ENDHEX$$o foi localizado 'CD_ENDERECO_SEGREGADO_VENCIDO_DANIFICADO'.")
	Case -1
		SqlCa.of_MsgDbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'CD_ENDERECO_SEGREGADO_VENCIDO_DANIFICADO'.")
End Choose

Return False
end function

public function boolean wf_deleta_produto (long al_agrupamento, long al_produto, string as_endereco, string as_lote, datetime adh_validade, long al_qtde, string as_destino_final, ref string as_erro);
Delete
from agrupamento_dev_compra_prd_nf
where nr_agrupamento 			= :al_Agrupamento
and cd_produto 					= :al_Produto
and cd_endereco_localizacao 	= :as_Endereco
and nr_lote 							= :as_Lote
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao deletar o produto da tabela 'agrupamento_dev_compra_prd_nf': "+SqlCa.SqlErrtext
	Return False
End If

Delete
from agrupamento_dev_compra_prd
where nr_agrupamento 			= :al_Agrupamento
and cd_produto 					= :al_Produto
and cd_endereco_localizacao 	= :as_Endereco
and nr_lote 						= :as_Lote
and dh_validade 					= :adh_Validade
and qt_devolver					= :al_Qtde
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao deletar o produto da tabela 'agrupamento_dev_compra_prd': "+SqlCa.SqlErrtext
	Return False
End If

Return True
end function

public function boolean wf_localiza_sequencial_saldo (string as_endereco, long al_produto, string as_lote, date adt_validade, ref long al_sequencial, ref long al_saldo, ref string as_erro);select nr_sequencial, qt_saldo
Into :al_Sequencial, :al_Saldo
From wms_localizacao
Where cd_endereco 		= :as_Endereco
  	and cd_produto 		= :al_Produto
  	and qt_caixa_padrao 	= 1
  	and nr_lote 				= :as_Lote
  	and dh_validade 		= :adt_validade
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
	Case 100
		as_Erro = "Sequencial do produto '" + String(al_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado no endere$$HEX1$$e700$$ENDHEX$$o "+as_Endereco+" do segregado."
	Case -1
		as_Erro = "Erro ao localizar o sequencial e o saldo do produto '" + String(al_Produto) + "': "+SqlCa.SqlErrText
End Choose

Return False
end function

public function boolean wf_baixa_reserva_item_nf_compra_lote (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, long al_natureza_operacao, long al_produto, string as_lote, long al_qtde, ref string as_erro);Decimal 	ldc_Qt_Devolver,&
			ldc_Qt_Reserva
			
//Valida para a quantidade de reserva n$$HEX1$$e300$$ENDHEX$$o ser maior do que a quantidade recebida
Select 	qt_reserva_devolucao
Into 	:ldc_Qt_Reserva
From 	item_nf_compra_lote
Where cd_filial 						= :al_Filial
	and cd_fornecedor 			= :as_Fornecedor
	and nr_nf 						= :al_Nota
	and de_especie 				= :as_Especie
	and de_serie 					= :as_Serie
	and cd_natureza_operacao 	= :al_Natureza_Operacao
	and cd_produto 				= :al_Produto
	and nr_lote 						= :as_Lote
Using SqlCa;

If  SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao validar a quantidade de reserva: "+SqlCa.SqlErrText
	Return False
End If
	
ldc_Qt_Devolver = al_Qtde	

If ldc_Qt_Devolver > ldc_Qt_Reserva Then
	as_Erro = "A quantidade '" + String(ldc_Qt_Devolver) + "' devolvida n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a quantidade '" + String(ldc_Qt_Reserva) + "' da reserva da tabela 'item_nf_compra_lote'.~r~r"+&
					"Fornecedor : "+as_Fornecedor+"~r"+&
					"Nota :"+String(al_Nota)+"~r"+&
					"Esp$$HEX1$$e900$$ENDHEX$$cie: "+as_Especie+"~r"+&
					"S$$HEX1$$e900$$ENDHEX$$rie: "+as_Serie+"~r"+&
					"Natureza de opera$$HEX2$$e700e300$$ENDHEX$$o: "+String(al_Natureza_Operacao)+"~r"+&
					"Produto: "+String(al_Produto)+"~r"+&
					"Lote: "+as_Lote
	Return False
End If

//Atualiza a quantidade de reserva
Update item_nf_compra_lote
Set 	qt_reserva_devolucao = isnull(qt_reserva_devolucao, 0) - :al_Qtde,
		qt_devolvida = isnull(qt_devolvida, 0) + :al_Qtde
Where cd_filial 						= :al_Filial
	and cd_fornecedor 			= :as_Fornecedor
	and nr_nf 						= :al_Nota
	and de_especie 				= :as_Especie
	and de_serie 					= :as_Serie
	and cd_natureza_operacao 	= :al_Natureza_Operacao
	and cd_produto 				= :al_Produto
	and nr_lote 						= :as_Lote
Using SqlCa;

If  SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao atualizar a reserva de devolu$$HEX2$$e700e300$$ENDHEX$$o na tabela 'item_nf_compra_lote': "+SqlCa.SqlErrText
	Return False
End If

Return True
end function

public function boolean wf_situacao_agrupamento_fechar (long al_agrupamento, ref string as_situacao);Select id_situacao
Into :as_Situacao
From agrupamento_dev_compra
Where nr_agrupamento =:al_agrupamento
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		// Aberto
		If IsNull(as_Situacao) Then as_Situacao = 'A'
			
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O agrupamento n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do agrupamento.")
End Choose

Return True
end function

public function boolean wf_altera_tipo_agrupamento (long al_agrupamento);String ls_Parametro,&
		ls_Erro
		
Long 	ll_Row,&
		ll_Linha,&
		ll_Linhas,&
		ll_Reserva
		
Long 	ll_Agrupamento,&
		ll_Produto,&
		ll_Filial,&
		ll_Nf,&
		ll_Natureza_Operacao,&
		ll_Qtde
		
String	ls_Endereco,&
		ls_Lote,&
		ls_Lote_Nf,&
		ls_Fornecedor,&
		ls_Especie,&
		ls_Serie
		
dc_uo_ds_base lds_Produtos

Try
	/*
	REVER C$$HEX1$$d300$$ENDHEX$$DIUGO COMENTADO
	A partira da nova vers$$HEX1$$e300$$ENDHEX$$o vamos gerar nota de descarte e deve ser mantido o agrupamento_dev_compra_prd_nf
	
	lds_Produtos = Create dc_uo_ds_base
	
	If Not lds_Produtos.of_ChangeDataObject("ds_ge252_agrupamento_dev_compra_prd_nf") Then
		Return False
	End If

	lds_Produtos.Retrieve(al_Agrupamento)
	
	ll_Linhas = lds_Produtos.RowCount()
	
	For ll_Linha = 1 To ll_Linhas
		
		ll_Produto 					= lds_Produtos.object.cd_produto						[ll_Linha]
		ls_Endereco 				= lds_Produtos.object.cd_endereco_localizacao	[ll_Linha]
		ls_Lote 						= lds_Produtos.object.nr_lote							[ll_Linha]
		ls_Lote_Nf					= lds_Produtos.object.nr_lote_Nf						[ll_Linha]
		ll_Filial 					= lds_Produtos.object.cd_filial						[ll_Linha]
		ls_Fornecedor 				= lds_Produtos.object.cd_fornecedor					[ll_Linha]
		ll_Nf 						= lds_Produtos.object.nr_nf							[ll_Linha]
		ls_Especie 					= lds_Produtos.object.de_especie						[ll_Linha]
		ls_Serie 					= lds_Produtos.object.de_serie						[ll_Linha]
		ll_Natureza_Operacao 	= lds_Produtos.object.cd_natureza_operacao		[ll_Linha]
		ll_Qtde						= lds_Produtos.object.qt_devolver					[ll_Linha]
		
		/*Delete from agrupamento_dev_compra_prd_nf
		where	nr_agrupamento 				= :al_Agrupamento
			and	cd_produto 					= :ll_Produto
			and	cd_endereco_localizacao = :ls_Endereco
			and	nr_lote 						= :ls_Lote
			and	cd_filial 					= :ll_Filial
			and	cd_fornecedor 				= :ls_Fornecedor
			and	nr_nf 						= :ll_Nf
			and	de_especie 					= :ls_Especie
			and	de_serie 					= :ls_Serie
			and	cd_natureza_operacao 	= :ll_Natureza_Operacao
		Using SqlCa;	
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_Rollback()
			MessageBox("Erro", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o da tabela 'agrupamento_dev_compra_prd_nf': "+ls_Erro)
			Return False
		End If*/
		
		//Localiza a reserva da nota
		Select qt_reserva_devolucao
		Into :ll_Reserva
		From item_nf_compra_lote
		Where cd_filial 						= :ll_Filial
			and cd_fornecedor 			= :ls_Fornecedor
			and nr_nf 						= :ll_Nf
			and de_especie 				= :ls_Especie
			and de_serie 					= :ls_Serie
			and cd_natureza_operacao 	= :ll_Natureza_Operacao
			and cd_produto 				= :ll_Produto
			and nr_lote 						= :ls_Lote_Nf
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode 
			Case 100
				ll_Reserva = 0
			Case -1
				ls_Erro = SqlCa.SqlErrText
				SqlCa.of_Rollback()
				MessageBox("Erro", "Erro ao localizar a reserva na tabela 'item_nf_compra_lote': "+ls_Erro)
				Return False
		End Choose
		
		//Se a reserva for negativa coloca zero
		ll_Reserva = ll_Reserva - ll_Qtde
		
		If ll_Reserva < 0 Then ll_Reserva = 0
			
		//Atualiza a quantidade de reserva
		/*Update item_nf_compra_lote
		Set qt_reserva_devolucao = :ll_Reserva
		Where cd_filial 						= :ll_Filial
			and cd_fornecedor 			= :ls_Fornecedor
			and nr_nf 						= :ll_Nf
			and de_especie 				= :ls_Especie
			and de_serie 					= :ls_Serie
			and cd_natureza_operacao 	= :ll_Natureza_Operacao
			and cd_produto 				= :ll_Produto
			and nr_lote 						= :ls_Lote_Nf
		Using SqlCa;
		
		If  SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_Rollback()
			MessageBox("Erro", "Erro ao atualizar a reserva de devolu$$HEX2$$e700e300$$ENDHEX$$o na tabela 'item_nf_compra_lote': "+ls_Erro)
			Return False
		End If*/

	Next*/
	
	Update agrupamento_dev_compra
	Set id_destino_final = 'D'
	Where nr_agrupamento = :al_Agrupamento
	Using SqlCa;
	
	If  SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback()
		MessageBox("Erro", "Erro ao atualizar a reserva de devolu$$HEX2$$e700e300$$ENDHEX$$o na tabela 'item_nf_compra_lote': "+ls_Erro)
		Return False
	End If
		
Finally
	Destroy(lds_Produtos)
End Try


Return True
end function

public function boolean wf_valida_notas_fornecedor (long al_agrupamento, ref string as_erro);dc_uo_ds_base lds_Notas_Compra
Long ll_Linhas

Try 
	lds_Notas_Compra = Create dc_uo_ds_base
	
	If Not lds_Notas_Compra.of_ChangeDataObject("dw_ge252_lista_nota_compras_emite_nota") Then Return False
	
	lds_Notas_Compra.of_appendwhere_subquery("a.cd_fornecedor <> (select cd_fornecedor from agrupamento_dev_compra where nr_agrupamento = a.nr_agrupamento)", 2)
	
	ll_Linhas = lds_Notas_Compra.Retrieve(al_agrupamento)
	
	If ll_Linhas > 0 Then
		as_Erro = "Existem produtos no agrupamento que s$$HEX1$$e300$$ENDHEX$$o de notas de fornecedor diferente do fornecedor do agrupamento."
		Return False
	End If

Finally
	Destroy(lds_Notas_Compra)
End Try

Return True
end function

public function boolean wf_ajuste_entrada_vencido_danificado (long al_produto, string as_endereco, date adh_validade, long al_qtde_movimento, string as_lote, string as_responsavel, ref string as_erro);Date dt_Movimentacao_Caixa

Long ll_Proximo_Ajuste


dt_Movimentacao_Caixa = Date(gf_GetServerDate())

Select coalesce(max(nr_ajuste), 0) + 1 
Into :ll_Proximo_Ajuste
From wms_ajuste_estoque
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro  = "Erro ao localizar o pr$$HEX1$$f300$$ENDHEX$$ximo n$$HEX1$$fa00$$ENDHEX$$mero de ajuste de entrada: "+ SqlCa.SQLErrText                         
	Return False
End If

INSERT INTO wms_ajuste_estoque (	nr_ajuste,   
												cd_produto,   
												cd_endereco,   
												nr_sequencial,   
												nr_lote,   
												dh_validade,   
												 qt_caixa_padrao,   
												qt_ajuste,   
												 id_entrada_saida,   
												dh_ajuste,   
												 dh_movimentacao_caixa,   
												 nr_matricula_responsavel,
																																																																								 cd_motivo_ajuste)  
VALUES (:ll_Proximo_Ajuste,    		//nr_ajuste,   
			:al_produto,            			//cd_produto,   
			:as_Endereco,              		 //cd_endereco,   
			null,								//nr_sequencial,   
			:as_Lote,							//nr_lote,   
			:adh_Validade,					//dh_validade,   
			1,									//qt_caixa_padrao,   
			:al_Qtde_Movimento,			//qt_ajuste,   
			'E',									//id_entrada_saida,   
			getdate(),						//dh_ajuste,   
			:dt_Movimentacao_Caixa,	//dh_movimentacao_caixa,   
			:as_Responsavel,				//nr_matricula_responsavel
			24)								//cd_motivo_ajuste
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao inserir dados na tabela 'wms_ajuste_estoque': "+ SqlCa.SQLErrText                          
	Return False
End If

Return True

end function

public function boolean wf_exclui_nota_compra (long al_agrupamento, long al_produto, string as_endereco_agrupamento, string as_lote, long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, long al_natureza_operacao, ref string as_erro);Delete
from agrupamento_dev_compra_prd_nf
where  nr_agrupamento 				= :al_Agrupamento
	and cd_produto 					= :al_Produto
	and cd_endereco_localizacao 	= :as_Endereco_Agrupamento
	and nr_lote 							= :as_Lote
	and cd_filial							= :al_Filial
	and cd_fornecedor					= :as_Fornecedor
	and nr_nf 							= :al_Nota
	and de_especie						= :as_Especie
	and de_serie						= :as_Serie
	and cd_natureza_operacao		= :al_Natureza_Operacao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao deletar a nota da tabela 'agrupamento_dev_compra_prd_nf': "+SqlCa.SqlErrtext														
	Return False	
End If

If SqlCa.Sqlnrows < 1 Then
	as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi exclu$$HEX1$$ed00$$ENDHEX$$do a nota no agrupamento.~rLinhas alteradas: "+String(SqlCa.Sqlnrows)														
	Return False
End If

Return True
end function

public function boolean wf_notas_canceladas (long al_agrupamento);dc_uo_ds_base lds_Notas

Long 	ll_Linhas,&
		ll_Linha

String ls_Notas = ""

Try
	lds_Notas = Create dc_uo_ds_base
	
	If Not lds_Notas.of_ChangeDataObject("ds_ge252_notas_nao_canceladas") Then
		Return False
	End If

	ll_Linhas = lds_Notas.Retrieve(al_Agrupamento)
	
	If ll_Linhas < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as notas n$$HEX1$$e300$$ENDHEX$$o canceladas.")
		Return False
	End If
	
	If ll_Linhas = 0 Then
		Return True
	Else
		For ll_Linha = 1 To ll_Linhas
			If ls_Notas = "" Then
				ls_Notas = String(lds_Notas.Object.nr_nf[ll_Linha])
			Else
				ls_Notas += ", "+ String(lds_Notas.Object.nr_nf[ll_Linha])
			End If
		Next
	End If
Finally
	Destroy(lds_Notas)
End Try

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para reabrir o agrupamento ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio cancelar as seguintes notas de devolu$$HEX2$$e700e300$$ENDHEX$$o de compra: "+ls_Notas+".")

Return False
end function

public function boolean wf_devolver_reserva_notas_compra (long al_agrupamento);dc_uo_ds_base lds_Notas_Compra	

Long 	ll_Linhas,&
		ll_Linha,&
		ll_Filial,&
		ll_Nota,&
		ll_Produto,&
		ll_Qt_Lote,&
		ll_Natureza_Operacao
		
String 	ls_Fornecedor,&		
			ls_Especie,&
			ls_Serie,&
			ls_Lote_Nota,&
			ls_Erro


Try
	lds_Notas_Compra = Create dc_uo_ds_base
	
	If Not lds_Notas_Compra.of_ChangeDataObject("dw_ge252_lista_nota_compras_emite_nota") Then Return False
	
	ll_Linhas = lds_Notas_Compra.Retrieve(al_Agrupamento)
	
	If ll_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum produto para devolver a reserva da devolu$$HEX2$$e700e300$$ENDHEX$$o de compra.")
		Return False
	End If
	
	If ll_Linhas < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar os produtos a serem devolvido a reserva.")
		Return False
	End If			
	
	For ll_Linha = 1 To ll_Linhas	
		ll_Filial						= 534
		ls_Fornecedor				= lds_Notas_Compra.Object.cd_fornecedor					[ll_Linha]
		ll_Nota						= lds_Notas_Compra.Object.nr_nf								[ll_Linha]
		ls_Especie					= lds_Notas_Compra.Object.de_especie						[ll_Linha]
		ls_Serie						= lds_Notas_Compra.Object.de_Serie						[ll_Linha]
		ll_Natureza_Operacao	= lds_Notas_Compra.Object.cd_natureza_operacao		[ll_Linha]		
		ll_Produto 					= lds_Notas_Compra.Object.cd_produto						[ll_Linha]
		ls_Lote_Nota				= lds_Notas_Compra.Object.nr_lote_nf						[ll_Linha]		
		ll_Qt_Lote					= lds_Notas_Compra.Object.qt_devolver						[ll_Linha]
		
		//Atualiza a quantidade de reserva
		Update item_nf_compra_lote
		Set 	qt_reserva_devolucao = isnull(qt_reserva_devolucao, 0) + :ll_Qt_Lote,
				qt_devolvida = isnull(qt_devolvida, 0) - :ll_Qt_Lote
		Where cd_filial 						= :ll_Filial
			and cd_fornecedor 			= :ls_Fornecedor
			and nr_nf 						= :ll_Nota
			and de_especie 				= :ls_Especie
			and de_serie 					= :ls_Serie
			and cd_natureza_operacao 	= :ll_Natureza_Operacao
			and cd_produto 				= :ll_Produto
			and nr_lote 						= :ls_Lote_Nota
		Using SqlCa;
		
		If  SqlCa.SqlCode = -1 Then
			ls_Erro = "Erro ao atualizar a reserva de devolu$$HEX2$$e700e300$$ENDHEX$$o na tabela 'item_nf_compra_lote': "+SqlCa.SqlErrText
			SqlCa.of_Rollback()
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro)
			Return False
		End If

	Next
	
Finally
	Destroy(lds_Notas_Compra)
End Try

Return True
end function

public function boolean wf_gera_nota_devolucao_compra (long al_agrupamento, string as_responsavel, boolean ab_agrupar_notas, ref string as_notas_geradas, ref string as_erro);dc_uo_ds_base lds_Notas_Compra	

uo_ge252_nota_fiscal_devolucao_compra lo_Nota
uo_ge224_etiqueta_vol_dev_compra lo_Etiqueta

Long 	ll_Linhas,&
		ll_Linha,&
		ll_Array[],&
		ll_Filial,&
		ll_Nota,&
		ll_Nota_Proximo,&		
		ll_Produto,&
		ll_Qt_Lote,&
		ll_Sequencial,&
		ll_Saldo,&
		ll_Contador,&
		ll_Natureza_Operacao,&
		ll_Nota_Gerada,&
		ll_Volumes,&
		ll_Nulo
		
String 	ls_Array[],&
			ls_Fornecedor,&
			ls_Fornecedor_Proximo,&			
			ls_Especie,&
			ls_Serie,&
			ls_Endereco,&
			ls_Lote,&
			ls_Lote_Nota,&
			ls_Obs_NF,&
			ls_Endereco_Segregado,&
			ls_Cod_Transportador,&
			ls_Fornecedor_Aux
			

Date 	ldh_Array[],&
		ldt_Validade
		
Boolean lb_Nova_Nota	

Decimal ldc_Peso


Try
	lo_Nota					= Create uo_ge252_nota_fiscal_devolucao_compra 
	lds_Notas_Compra		= Create dc_uo_ds_base
	lo_Etiqueta				= Create uo_ge224_etiqueta_vol_dev_compra
	SetNull(ls_Fornecedor_Aux)
	
	If Not lds_Notas_Compra.of_ChangeDataObject("ds_ge252_lista_nota_compras_emite_nota") Then Return False
	
	ll_Linhas = lds_Notas_Compra.Retrieve(al_agrupamento)
	
	If ll_Linhas = 0 Then
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum produto para ser gerado a nota de devolu$$HEX2$$e700e300$$ENDHEX$$o de compra."
		Return False
	End If
	
	If ll_Linhas < 0 Then
		as_Erro = "Erro ao recuperar os produtos a serem devolvidos."
		Return False
	End If

	ls_Fornecedor_Aux				= lds_Notas_Compra.Object.cd_fornecedor					[1]
 	// Message Cd_Transportador + ':' Observacao 
	OpenWithParm(w_ge252_observacao_nf, ls_Fornecedor_Aux )
   	 
	// Para : Observacao
	ls_Obs_NF = Mid(Message.StringParm, (PosA (String(Message.StringParm), ";", 1)+1) , 40)  
	
	// Valida para Observa$$HEX2$$e700e300$$ENDHEX$$o
	If Not Isnull(ls_Obs_NF) and Trim(ls_Obs_NF) <> '' Then
		lo_Nota.is_Obs_NF = ls_Obs_NF
	End If
	
	// Para : Codigo do Transportador
	ls_Cod_Transportador = Mid(Message.StringParm, 1, (PosA (String(Message.StringParm), ";", 1)-1))

	// Valida para Codigo do Transportador
	If Not Isnull(ls_Cod_Transportador) and Trim(ls_Cod_Transportador) <>'' and  Trim(ls_Cod_Transportador) <>'0' Then 
		lo_Nota.is_Transp_Codigo		=  	ls_Cod_Transportador
	Else
		SetNull(lo_Nota.is_Transp_Codigo)
	End If 
	
	
	lo_Nota.is_Operador 				= as_Responsavel
	lo_Nota.il_Motivo_Devolucao 	=	Tab_1.TabPage_1.dw_2.Object.cd_motivo_devolucao	[Tab_1.TabPage_1.dw_2.GetRow()]
	lo_Nota.il_Qtde_Volume			= 	Tab_1.TabPage_1.dw_9.Object.nr_volume					[1]
	lo_Nota.il_Agrupamento			= 	al_agrupamento


	lb_Nova_Nota 		= True
	
	For ll_Linha = 1 To ll_Linhas
		
		If lb_Nova_Nota Then
			lo_Nota.il_Filial					[] = ll_Array[]
			lo_Nota.is_Fornecedor		[] = ls_Array[]
			lo_Nota.il_Nota					[] = ll_Array[]
			lo_Nota.is_Especie				[] = ls_Array[]
			lo_Nota.is_Serie				[] = ls_Array[]
			lo_Nota.il_produto				[] = ll_Array[]
			lo_Nota.il_Qtde_Devolver	[] = ll_Array[]
			lo_Nota.is_Lote					[] = ls_Array[]
			lo_Nota.idh_Validade			[] = ldh_Array[]
			lo_Nota.is_Endereco			[] = ls_Array[]
			lo_Nota.il_Sequencial			[] = ll_Array[]
			lo_Nota.is_Lote_Nota			[] = ls_Array[]
			lo_Nota.il_Nr_Controle		[] = ll_Array[]
			
			ldc_Peso		= 0
			ll_Contador 	= 0

			lb_Nova_Nota = False
		End If		
		
		SetNull(ll_Nulo)
		ll_Filial						= 534
		ll_Nota						= lds_Notas_Compra.Object.nr_nf								[ll_Linha]
		ll_Produto 					= lds_Notas_Compra.Object.cd_produto						[ll_Linha]
		ll_Qt_Lote					= lds_Notas_Compra.Object.qt_devolver						[ll_Linha]
		ls_Fornecedor				= lds_Notas_Compra.Object.cd_fornecedor					[ll_Linha]
		ls_Especie					= lds_Notas_Compra.Object.de_especie						[ll_Linha]
		ls_Serie						= lds_Notas_Compra.Object.de_Serie						[ll_Linha]
		ls_Endereco					= lds_Notas_Compra.Object.cd_endereco_localizacao	[ll_Linha]
		ls_Lote						= lds_Notas_Compra.Object.nr_lote							[ll_Linha]
		ldt_Validade					= Date(lds_Notas_Compra.Object.dh_validade				[ll_Linha])
		ldc_Peso						+= lds_Notas_Compra.Object.qt_peso_kg					[ll_Linha]
		ls_Lote_Nota				= lds_Notas_Compra.Object.nr_lote_nf						[ll_Linha]
		ll_Natureza_Operacao	= lds_Notas_Compra.Object.cd_natureza_operacao		[ll_Linha]
		//ls_Endereco_Segregado	= lds_Notas_Compra.Object.cd_endereco_segregado		[ll_Linha]
		
			
		ll_Contador += 1
		
		lo_Nota.il_Filial					[ll_Contador] 	= ll_Filial
		lo_Nota.is_Fornecedor		[ll_Contador] 	= ls_Fornecedor
		lo_Nota.il_Nota					[ll_Contador] 	= ll_Nota
		lo_Nota.is_Especie				[ll_Contador] 	= ls_Especie
		lo_Nota.is_Serie				[ll_Contador]	= ls_Serie
		lo_Nota.il_produto				[ll_Contador] 	= ll_Produto
		lo_Nota.il_Qtde_Devolver		[ll_Contador]	= ll_Qt_Lote
		lo_Nota.is_Lote					[ll_Contador]	= ls_Lote
		lo_Nota.idh_Validade			[ll_Contador]	= ldt_Validade
		lo_Nota.is_Endereco			[ll_Contador]	= ls_Endereco	
		lo_Nota.is_Lote_Nota			[ll_Contador]	= ls_Lote
		lo_Nota.il_Nr_Controle		[ll_Contador]	= ll_Nulo
		
		//  Retirado parametro sempre com "S"
		//  A nova regra o sistema ir$$HEX1$$e100$$ENDHEX$$ gravar o movimento de entrada na filial 1 tamb$$HEX1$$e900$$ENDHEX$$m para os produtos VENCIDOS/DANIFICADOS
		//	If (ls_Endereco_Segregado = ivs_Endereco_Vencido_Danificado) and (ivs_nova_regra_vencido_danificado <> "S") Then
		//	If Not wf_Ajuste_Entrada_Vencido_Danificado(	ll_Produto,&
		//																ls_Endereco,&
		//																ldt_Validade,&
		//																ll_Qt_Lote,&
		//																ls_Lote,&
		//																as_Responsavel,&
		//																Ref as_erro) Then
		//		Return False
		//	End If
		//End If
				
		
		If Not wf_localiza_sequencial_saldo(ls_Endereco, ll_Produto, ls_Lote,&
														   ldt_Validade, ref ll_Sequencial, ref ll_Saldo, Ref as_Erro ) Then
			Return False
		End If
		
		lo_Nota.il_Sequencial[ll_Contador] = ll_Sequencial
		
		If ll_Qt_Lote > ll_Saldo Then
			as_Erro = 	"A quantidade devolvida n$$HEX1$$e300$$ENDHEX$$o pode ser maior que o saldo dispon$$HEX1$$ed00$$ENDHEX$$vel do lote no endere$$HEX1$$e700$$ENDHEX$$o do segregado.~r~r" + &
							"Produto:" + String(ll_Produto) +&
							"Lote:" + ls_Lote
			
			Return False
		End if
		
	
		If (ll_Linha + 1) <= ll_Linhas Then
			ls_Fornecedor_Proximo 	=  lds_Notas_Compra.Object.cd_fornecedor [ll_Linha + 1]
			ll_Nota_Proximo 			=  lds_Notas_Compra.Object.nr_nf [ll_Linha + 1]
		Else
			ls_Fornecedor_Proximo 	= ""
			ll_Nota_Proximo			= -1
		End If
		
		If (ls_Fornecedor <> ls_Fornecedor_Proximo) or (ll_Nota <> ll_Nota_Proximo) Then
			
			If (Not ab_Agrupar_Notas) or (ll_Nota_Proximo = -1) Then
				
				lo_Nota.idc_peso_bruto	=	ldc_Peso
				lo_Nota.idc_peso_liquido =	ldc_Peso
				
				If lo_Nota.of_Processa_Geracao_Nota(Ref ll_Nota_Gerada, Ref as_Erro) Then
					If IsNull(as_Notas_Geradas) or as_Notas_Geradas = "" Then
						as_Notas_Geradas = String(ll_Nota_Gerada)
					Else
						as_Notas_Geradas += ", "+String(ll_Nota_Gerada)
					End If
					
					If ab_Agrupar_Notas Then
						ll_Volumes = Tab_1.TabPage_1.dw_9.Object.nr_volume[1]
					Else
						ll_Volumes = 1
					End If
					
					If ib_Imprimir_Etiqueta Then
						lo_Etiqueta.of_emite_etiqueta(ll_Nota_Gerada, ll_Volumes)
					End If
				Else
					Return False
				End If
				
				lb_Nova_Nota = True
				
			End If
			
		End If
		
		If Not wf_Baixa_Reserva_item_nf_compra_lote(	ll_Filial,&
																		ls_Fornecedor,&
																		ll_Nota,&
																		ls_Especie,&
																		ls_Serie,&
																		ll_Natureza_Operacao,&
																		ll_Produto,&
																		ls_Lote_Nota,&
																		ll_Qt_Lote,&
																		Ref as_erro) Then
			Return False																	
		End If
	Next
	
Finally
	Destroy(lo_Nota)
	Destroy(lds_Notas_Compra)
	Destroy(lo_Etiqueta)
End Try

Return True		
end function

public subroutine wf_imprime_etiquetas_volume (string as_fornecedor, string as_nfe, string as_nfo, long al_volumes);
dc_uo_ds_base lds_Etiquetas

Long ll_Linha

//Abre tela para selecionar a impressora
If PrintSetup() = -1 Then
	MessageBox("Aviso", "Impress$$HEX1$$e300$$ENDHEX$$o cancelada.")
	Return
End If

Try
	lds_Etiquetas	= Create dc_uo_ds_base

	
	If Not lds_Etiquetas.of_ChangeDataObject("ds_ws010_etiqueta_dev_compra") Then
		Return
	End If
	
	For ll_Linha = 1 to al_Volumes
		lds_Etiquetas.Object.de_fornecedor		[ll_Linha] = as_Fornecedor
		lds_Etiquetas.Object.de_nfe					[ll_Linha] = as_Nfe
		lds_Etiquetas.Object.de_nfo					[ll_Linha] = as_Nfo
		lds_Etiquetas.Object.nr_volume			[ll_Linha] = ll_Linha
		lds_Etiquetas.Object.nr_total_volumes	[ll_Linha] = al_Volumes
		lds_Etiquetas.Object.dh_impressao		[ll_Linha] = Date(gf_GetServerDate())
	Next
	
	lds_Etiquetas.Print()
	
Finally
	Destroy(lds_Etiquetas)
End Try
	
end subroutine

protected function boolean wf_comprador_do_produto (long al_produto, ref string as_matricula_comprador, ref string as_nm_comprador);
select	a.nr_matricula_comprador,
		b.nm_usuario
Into	:as_Matricula_Comprador,
		:as_Nm_Comprador
from produto_central	a
Inner Join usuario		b on b.nr_matricula = a.nr_matricula_comprador
where a.cd_produto = :al_Produto
Using SqlCa;	

Choose Case  SqlCa.SqlCode
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o comprador do produto '"+String(al_Produto)+"'.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Verifica se o produto pertence ao comprador do agrupamento.")
		Return False
End Choose

Return True
end function

public function boolean wf_localiza_parametro_regra_vencido ();Select vl_parametro
Into :ivs_nova_regra_vencido_danificado
From wms_parametro 
Where cd_parametro = 'ID_UTILIZA_NOVA_REGRA_VENCIDO_DANIFICADO'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		If ivs_nova_regra_vencido_danificado <> 'S' and ivs_nova_regra_vencido_danificado <> 'N' Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro para tratar nova regra de vencido/danificado diferente do esperado S/N.")
			Return False
		End If
		
		Return True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro do WMS n$$HEX1$$e300$$ENDHEX$$o foi localizado 'ID_UTILIZA_NOVA_REGRA_VENCIDO_DANIFICADO'.")
	Case -1
		SqlCa.of_MsgDbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_UTILIZA_NOVA_REGRA_VENCIDO_DANIFICADO'.")
End Choose

Return False
end function

public function boolean wf_gera_coleta_pendente (long al_agrupamento, ref string as_erro);String	ls_Erro,&
		ls_Especie,&
		ls_Serie,&
		ls_Fornecedor

Long	ll_Linhas,&
		ll_Linha,&
		ll_Filial,&
		ll_Nota,&
		ll_Qtde

dc_uo_ds_base	lds_Notas

Try
	lds_Notas = Create dc_uo_ds_base
	If Not lds_Notas.of_ChangeDataObject("ds_ge252_notas_coleta_segregado") Then Return False
	
	ll_Linhas	= lds_Notas.Retrieve(al_agrupamento)
	
	If ll_Linhas < 0 Then
		as_Erro	= "Erro no retrieve da 'ds_ge252_notas_coleta_segregado'."
		Return False
	End If
	
	If ll_Linhas < 1 Then
		as_Erro	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhuma nota para ser gravado nas coletas do segregado."
		Return False
	End If
	
	For ll_Linha = 1 To ll_Linhas
		ll_Filial			= lds_Notas.Object.cd_filial			[ll_Linha]
		ll_Nota			= lds_Notas.Object.nr_nf				[ll_Linha]
		ls_Especie		= lds_Notas.Object.de_especie		[ll_Linha]
		ls_Serie			= lds_Notas.Object.de_serie		[ll_Linha]
		ls_Fornecedor	= lds_Notas.Object.cd_fornecedor	[ll_Linha]
		
		Select count(*)
		Into	:ll_Qtde
		From wms_segregado_coleta
		Where cd_filial					= :ll_Filial
			And	nr_nf					= :ll_Nota
			And	de_especie			= :ls_Especie
			And	de_serie				= :ls_Serie
			And	cd_fornecedor		= :ls_Fornecedor
			And	nr_agrupamento	= :al_agrupamento
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Erro	= "Erro ao verificar se a nota j$$HEX1$$e100$$ENDHEX$$ registrada para coleta: "+SqlCa.SqlErrText
			Return False
		End If
		
		If ll_Qtde = 0 Then
			Insert into wms_segregado_coleta (	
				cd_filial,
				nr_nf,
				de_especie,
				de_serie,
				cd_fornecedor,
				id_situacao,
				dh_situacao,
				nr_agrupamento,
				dh_envio_email)
			Values(	:ll_Filial,
						:ll_Nota,
						:ls_Especie,
						:ls_Serie,
						:ls_Fornecedor,
						'P',
						GetDate(),
						:al_agrupamento,
						GetDate())
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Erro = "Erro ao inserir dados na tabela 'wms_segregado_coleta': "+SqlCa.SQLErrText	
				Return False
			End If
		End If
	Next
Finally
	Destroy(lds_Notas)
End Try

Return True
end function

public function boolean wf_reabrir_agrupamento_descarte (long al_agrupamento, string as_responsavel, ref string as_erro);dc_uo_ds_base	lds_produto

Long	ll_Linhas,&
		ll_Linha,&
		ll_Movimento_Estoque,&
		ll_Filial_Movimento,&
		ll_Produto,&
		ll_Qt_Produto,&
		ll_Ajuste,&
		ll_Filial_Ajuste,&
		ll_Sequencial,&
		ll_Mes_Atual,&
		ll_Mes_Agupamento
		
String	ls_Situacao,&
		ls_Lote,&
		ls_Endereco,&
		ls_Endereco_Agrupamento

DateTime	ldh_Alteracao_Situacao,&
				ldh_Movimento,&
				ldh_Validade
				
Date	ldt_Saldo				

Try
	lds_produto = Create dc_uo_ds_base
	
	Open(w_Aguarde)
	
	w_Aguarde.Title = "Reabrindo agrupamento..."
	
	//Localiza informa$$HEX2$$e700f500$$ENDHEX$$es do agrupamento
	Select		id_situacao,
				dh_alteracao_situacao
	Into	:ls_Situacao,
			:ldh_Alteracao_Situacao
	From	agrupamento_dev_compra
	Where nr_agrupamento = :al_Agrupamento
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If ls_Situacao <> "R" Then
				as_Erro	= "O agrupamento "+String(al_Agrupamento)+" n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ mais com a situa$$HEX2$$e700e300$$ENDHEX$$o 'Resolvido'."
				Return False
			End If
			
			ldh_Alteracao_Situacao = DateTime(Date(ldh_Alteracao_Situacao))
		Case 100
			as_Erro	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado o agrupamento "+String(al_Agrupamento)+"."
			Return False
		Case -1
			as_Erro	= "Erro no select da tabela 'agrupamento_dev_compra': "+SqlCa.SqlErrText
			Return False
	End Choose
	
	//Verifica se o agrupamento foi resolvido no m$$HEX1$$ea00$$ENDHEX$$s atual
	ll_Mes_Agupamento	= Month(Date(ldh_Alteracao_Situacao))
	ll_Mes_Atual			= Month(Date(gf_GetServerDate()))
	
	If ll_Mes_Agupamento <> ll_Mes_Atual Then
		as_Erro	= "O m$$HEX1$$ea00$$ENDHEX$$s em que o agrupamento foi resolvido $$HEX1$$e900$$ENDHEX$$ diferente do m$$HEX1$$ea00$$ENDHEX$$s atual. O agrupamento n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser reaberto."
		Return False
	End If
	
	//Localiza o endere$$HEX1$$e700$$ENDHEX$$o do agrupamento
	Select		vl_parametro
	Into	:ls_Endereco_Agrupamento
	From	wms_parametro
	Where cd_parametro = 'CD_ENDERECO_SEGREGADO_AGRUPAMENTO_DEV'
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If IsNull(ls_Endereco_Agrupamento) or (ls_Endereco_Agrupamento = "") Then
				as_Erro	= "O par$$HEX1$$e200$$ENDHEX$$metro 'CD_ENDERECO_SEGREGADO_AGRUPAMENTO_DEV' est$$HEX1$$e100$$ENDHEX$$ nulo ou vazio."
				Return False
			End If
			
		Case 100
			as_Erro	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado o par$$HEX1$$e200$$ENDHEX$$metro 'CD_ENDERECO_SEGREGADO_AGRUPAMENTO_DEV'."
			Return False
			
		Case -1
			as_Erro	= "Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro 'CD_ENDERECO_SEGREGADO_AGRUPAMENTO_DEV': "+SqlCa.SqlErrText
			Return False
	End Choose
	
	
	//Muda a situa$$HEX2$$e700e300$$ENDHEX$$o do agrupamento para Aberto
	Update agrupamento_dev_compra
	Set	id_situacao = 'A', 
			dh_alteracao_situacao = getdate(), 
			nr_matric_alteracao_situacao =:as_Responsavel
	Where nr_agrupamento =:al_Agrupamento
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Erro	= "Erro no update da situa$$HEX2$$e700e300$$ENDHEX$$o para 'F': "+SqlCa.SqlErrText
		Return False
	End If


	If Not lds_Produto.of_ChangeDataObject("ds_ge252_lista_produto") Then 
		as_Erro	= "Erro no of_ChangeDataObject da ds_ge252_lista_produto."
		Return False
	End if
	
	ll_Linhas = lds_Produto.Retrieve(al_Agrupamento)
	
	If ll_Linhas < 1 Then
		as_Erro =  "Erro no retrieve da ds_ge252_lista_produto."
		Return False
	End If
	
	If ll_Linhas = 0 Then
		as_Erro =  "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ produtos no agrupamento."
		Return False
	End If
	
	w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
	
	For ll_Linha = 1 To ll_Linhas
		w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
		
		ll_Produto		= lds_Produto.Object.cd_produto	[ll_Linha]
		ll_Qt_Produto	= lds_Produto.Object.qt_devolver	[ll_Linha]
		ls_Lote			= lds_Produto.Object.nr_lote		[ll_Linha]
		ldh_Validade	= lds_Produto.Object.dh_validade	[ll_Linha]
		
		//***************************Exclui movimento da filial 1*************************************
		Select		top 1	
					nr_movimento_estoque,
					cd_filial_movimento,
					dh_movimento
		Into	:ll_Movimento_Estoque,
				:ll_Filial_Movimento,
				:ldh_Movimento
		From	movimento_estoque
		Where cd_filial_movimento	= 1
			and cd_produto				= :ll_Produto
			and dh_movimento		= :ldh_Alteracao_Situacao
			and cd_tipo_movimento	= 17	//WMS - SAIDA P/ SEGREGADO
			and qt_movimento			= :ll_Qt_Produto
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				delete from movimento_estoque
				where nr_movimento_estoque	= :ll_Movimento_Estoque
					and cd_filial_movimento		= :ll_Filial_Movimento
					and cd_produto					= :ll_Produto
					and dh_movimento			= :ldh_Movimento
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					as_Erro	= "Erro ao excluir o movimento da filial 1, produto "+String(ll_Produto)+": "+SqlCa.SqlErrText
					Return False
				End If
				
				If SqlCa.sqlnrows <> 1 Then
					as_Erro	= "Problema ao excluir o movimento da filial 1,  produto "+String(ll_Produto)+", deveria ter exclu$$HEX1$$ed00$$ENDHEX$$do 1 linha, mas excluiu "+String(SqlCa.sqlnrows)+" linha(s)."
					Return False
				End If
				
			Case 100
				as_Erro	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado o movimento na filial 1,  produto "+String(ll_Produto)+"."
				Return False
			Case -1
				as_Erro	= "Erro ao localizar o movimento na filial 1,  produto "+String(ll_Produto)+": "+SqlCa.SqlErrText
				Return False
		End Choose
		//************************************************************************************
		
		//***************************Exclui movimento da filial 534************************************
		Select		top 1	
					nr_movimento_estoque,
					cd_filial_movimento,
					dh_movimento
		Into	:ll_Movimento_Estoque,
				:ll_Filial_Movimento,
				:ldh_Movimento
		From	movimento_estoque
		Where cd_filial_movimento	= 534
			and cd_produto				= :ll_Produto
			and dh_movimento		= :ldh_Alteracao_Situacao
			and cd_tipo_movimento	= 18	//WMS - ENTRADA DO SEGREGADO
			and qt_movimento			= :ll_Qt_Produto
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				delete from movimento_estoque
				where nr_movimento_estoque	= :ll_Movimento_Estoque
					and cd_filial_movimento		= :ll_Filial_Movimento
					and cd_produto					= :ll_Produto
					and dh_movimento			= :ldh_Movimento
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					as_Erro	= "Erro ao excluir o movimento da filial 534,  produto "+String(ll_Produto)+": "+SqlCa.SqlErrText
					Return False
				End If
				
				If SqlCa.sqlnrows <> 1 Then
					as_Erro	= "Problema ao excluir o movimento da filial 534,  produto "+String(ll_Produto)+", deveria ter exclu$$HEX1$$ed00$$ENDHEX$$do 1 linha, mas excluiu "+String(SqlCa.sqlnrows)+" linha(s)."
					Return False
				End If
				
			Case 100
				as_Erro	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado o movimento na filial 534,  produto "+String(ll_Produto)+"."
				Return False
			Case -1
				as_Erro	= "Erro ao localizar o movimento na filial 534,  produto "+String(ll_Produto)+": "+SqlCa.SqlErrText
				Return False
		End Choose
		//************************************************************************************
		
		//***************************Exclui movimento da filial 534************************************
		Select		top 1	
					nr_movimento_estoque,
					cd_filial_movimento,
					dh_movimento
		Into	:ll_Movimento_Estoque,
				:ll_Filial_Movimento,
				:ldh_Movimento
		From	movimento_estoque
		Where cd_filial_movimento	= 534
			and cd_produto				= :ll_Produto
			and dh_movimento		= :ldh_Alteracao_Situacao
			and cd_tipo_movimento	= 9	//AJUSTE DE SA$$HEX1$$cd00$$ENDHEX$$DA
			and qt_movimento			= :ll_Qt_Produto
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				delete from movimento_estoque
				where nr_movimento_estoque	= :ll_Movimento_Estoque
					and cd_filial_movimento		= :ll_Filial_Movimento
					and cd_produto					= :ll_Produto
					and dh_movimento			= :ldh_Movimento
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					as_Erro	= "Erro ao excluir o movimento da filial 534,  produto "+String(ll_Produto)+": "+SqlCa.SqlErrText
					Return False
				End If
				
				If SqlCa.sqlnrows <> 1 Then
					as_Erro	= "Problema ao excluir o movimento da filial 534,  produto "+String(ll_Produto)+", deveria ter exclu$$HEX1$$ed00$$ENDHEX$$do 1 linha, mas excluiu "+String(SqlCa.sqlnrows)+" linha(s)."
					Return False
				End If
				
			Case 100
				as_Erro	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado o movimento na filial 534,  produto "+String(ll_Produto)+"."
				Return False
			Case -1
				as_Erro	= "Erro ao localizar o movimento na filial 534,  produto "+String(ll_Produto)+": "+SqlCa.SqlErrText
				Return False
		End Choose
		//************************************************************************************
		
		//***************************Exclui ajuste de estoque filial 534*********************************
		Select		top 1	
					nr_ajuste,
					cd_filial_ajuste
		Into	:ll_Ajuste,
				:ll_Filial_Ajuste
		From	ajuste_estoque
		Where cd_filial_ajuste			= 534
			and cd_produto					= :ll_Produto
			and cast(dh_ajuste as date)	= :ldh_Alteracao_Situacao
			and qt_ajuste					= :ll_Qt_Produto
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				delete from ajuste_estoque
				where nr_ajuste			= :ll_Ajuste
					and cd_filial_ajuste	= :ll_Filial_Ajuste
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					as_Erro	= "Erro ao excluir o ajuste da filial 534,  produto "+String(ll_Produto)+": "+SqlCa.SqlErrText
					Return False
				End If
				
				If SqlCa.sqlnrows <> 1 Then
					as_Erro	= "Problema ao excluir o ajuste da filial 534, produto "+String(ll_Produto)+", deveria ter exclu$$HEX1$$ed00$$ENDHEX$$do 1 linha, mas excluiu "+String(SqlCa.sqlnrows)+" linha(s)."
					Return False
				End If
				
			Case 100
				as_Erro	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado o ajuste da filial 534,  produto "+String(ll_Produto)+"."
				Return False
			Case -1
				as_Erro	= "Erro ao localizar o ajuste da filial 534,  produto "+String(ll_Produto)+": "+SqlCa.SqlErrText
				Return False
		End Choose
		//************************************************************************************
		
		//***************************Exclui movimento do WMS**************************************
		select top 1
				dh_movimento,
				nr_movimento
		into	:ldh_Movimento,
				:ll_Movimento_Estoque
		from wms_movimento_estoque
		where cd_produto 				= :ll_Produto
		and dh_movimento				= :ldh_Alteracao_Situacao
		and nr_lote 							= :ls_Lote
		and dh_validade					= :ldh_Validade
		and qt_movimento					= :ll_Qt_Produto
		and cd_tipo_movimento			= 23	//AJUSTE DE SAIDA
		and cd_endereco_localizacao	= :ls_Endereco_Agrupamento
		and qt_caixa_padrao				= 1
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				delete from wms_movimento_estoque
				where cd_produto 		= :ll_Produto
					and dh_movimento	= :ldh_Movimento
					and nr_movimento		= :ll_Movimento_Estoque
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					as_Erro	= "Erro ao excluir o movimento no WMS, produto "+String(ll_Produto)+": "+SqlCa.SqlErrText
					Return False
				End If
				
				If SqlCa.sqlnrows <> 1 Then
					as_Erro	= "Problema ao excluir o movimento no WMS, produto "+String(ll_Produto)+", deveria ter exclu$$HEX1$$ed00$$ENDHEX$$do 1 linha, mas excluiu "+String(SqlCa.sqlnrows)+" linha(s)."
					Return False
				End If
				
			Case 100
				as_Erro	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado o movimento no WMS, produto "+String(ll_Produto)+"."
				Return False
			Case -1
				as_Erro	= "Erro ao localizar o movimento no WMS, produto "+String(ll_Produto)+": "+SqlCa.SqlErrText
				Return False
		End Choose
		
		//************************************************************************************
		
		//***************************Volta saldo endere$$HEX1$$e700$$ENDHEX$$o WMS**************************************
		select 	nr_sequencial 
		into	:ll_Sequencial					
		from wms_localizacao
		where cd_produto		= :ll_Produto
		and cd_endereco		= :ls_Endereco_Agrupamento
		and qt_caixa_padrao	= 1
		and nr_lote				= :ls_Lote
		and dh_validade		= :ldh_Validade
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				update wms_localizacao
				set qt_saldo = qt_saldo + :ll_Qt_Produto
				where cd_endereco	= :ls_Endereco_Agrupamento
					and nr_sequencial	= :ll_Sequencial
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					as_Erro	= "Erro ao atualizar o saldo do produto "+String(ll_Produto)+" no endere$$HEX1$$e700$$ENDHEX$$o "+ls_Endereco+": "+SqlCa.SqlErrText
					Return False
				End If
				
				If SqlCa.sqlnrows <> 1 Then
					as_Erro	= "Problema ao atualizar o saldo do produto "+String(ll_Produto)+" no endere$$HEX1$$e700$$ENDHEX$$o "+ls_Endereco+", deveria ter atualizado 1 linha, mas atualizou "+String(SqlCa.sqlnrows)+" linha(s)."
					Return False
				End If
				
			Case 100
				select coalesce(max(nr_sequencial), 0) + 1
				into :ll_Sequencial
				from wms_localizacao
				where cd_endereco = :ls_Endereco_Agrupamento
				Using SqlCa;
				
				Choose Case SqlCa.SqlCode
					Case 0
					Case 100
						as_Erro	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado o sequencial do endere$$HEX1$$e700$$ENDHEX$$o "+ls_Endereco_Agrupamento+", produto "+String(ll_Produto)+": "+SqlCa.SqlErrText
						Return False
						
					Case -1
						as_Erro	= "Erro ao localizar o sequencial do endere$$HEX1$$e700$$ENDHEX$$o "+ls_Endereco_Agrupamento+", produto "+String(ll_Produto)+": "+SqlCa.SqlErrText
						Return False
				End Choose
				
				insert into wms_localizacao (
					cd_endereco,
					nr_sequencial,
					cd_produto, 
					qt_caixa_padrao, 
					nr_lote, 
					qt_saldo, 
					dh_validade)
				values(	:ls_Endereco_Agrupamento,
							:ll_Sequencial,
							:ll_Produto,
							1,
							:ls_Lote,
							:ll_Qt_Produto,
							:ldh_Validade)
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					as_Erro	= "Erro ao inserir o saldo do produto "+String(ll_Produto)+" no endere$$HEX1$$e700$$ENDHEX$$o "+ls_Endereco_Agrupamento+": "+SqlCa.SqlErrText
					Return False
				End If
				
				If SqlCa.sqlnrows <> 1 Then
					as_Erro	= "Problema ao inserir o saldo do produto "+String(ll_Produto)+" no endere$$HEX1$$e700$$ENDHEX$$o "+ls_Endereco_Agrupamento+", deveria ter atualizado 1 linha, mas atualizou "+String(SqlCa.sqlnrows)+" linha(s)."
					Return False
				End If
				
			Case -1
				as_Erro	= "Erro ao localizar o sequencial do produto "+String(ll_Produto)+" no endere$$HEX1$$e700$$ENDHEX$$o "+ls_Endereco_Agrupamento+": "+SqlCa.SqlErrText
				Return False
		End Choose
		
		//************************************************************************************	
		
		//***************************Exclui ajuste de estoque do WMS*********************************
		select	top 1
				nr_ajuste
		into :ll_Ajuste
		from wms_ajuste_estoque
		where cd_produto					= :ll_Produto
		and cd_endereco					= :ls_Endereco_Agrupamento
		and nr_lote							= :ls_Lote
		and dh_validade					= :ldh_Validade
		and qt_caixa_padrao				= 1
		and qt_ajuste						= :ll_Qt_Produto
		and id_entrada_saida				= 'S'
		and dh_movimentacao_caixa	= :ldh_Alteracao_Situacao
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				delete from wms_ajuste_estoque
				where nr_ajuste = :ll_Ajuste
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					as_Erro	= "Erro ao excluir o ajuste de estoque do produto "+String(ll_Produto)+" no WMS: "+SqlCa.SqlErrText
					Return False
				End If
				
				If SqlCa.sqlnrows <> 1 Then
					as_Erro	= "Problema ao excluir o ajuste de estoque do produto "+String(ll_Produto)+" no WMS, deveria ter exclu$$HEX1$$ed00$$ENDHEX$$do 1 linha, mas excluiu "+String(SqlCa.sqlnrows)+" linha(s)."
					Return False
				End If
				
			Case 100
				as_Erro	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado o ajuste de estoque do produto "+String(ll_Produto)+" no WMS."
				Return False
			Case -1
				as_Erro	= "Erro ao localizar o ajuste de estoque do produto "+String(ll_Produto)+" no WMS: "+SqlCa.SqlErrText
				Return False
		End Choose
		//************************************************************************************	
	Next
	
Finally
	Destroy(lds_produto)
	Close(w_Aguarde)
End Try

Return True
end function

public function boolean wf_divisao_forncedor_produto (string as_fornecedor, long al_produto, ref long al_divisao_fornecedor, ref string as_nm_divisao_fornecedor);Select		a.nr_divisao,
			a.nm_divisao
Into	:al_Divisao_Fornecedor,
		:as_Nm_Divisao_Fornecedor
From fornecedor_divisao a
inner join fornecedor_divisao_produto b on b.cd_fornecedor = a.cd_fornecedor and b.nr_divisao = a.nr_divisao
Where	a.cd_fornecedor	= :as_Fornecedor
	And	b.cd_produto		= :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 1
	Case 100
		SetNull(al_Divisao_Fornecedor)
	Case -1
		MessageBox("Erro", "Erro ao localizar a divis$$HEX1$$e300$$ENDHEX$$o de fornecedor do produto: "+SqlCa.SqlErrtext)
		Return False	
End Choose

Return True
end function

public function boolean wf_verifica_saldo_produto (long al_agrupamento);dc_uo_ds_base lds_Saldo

DateTime	ldh_Saldo

Long	ll_Linhas,&
		ll_Linha,&
		ll_Produto,&
		ll_Saldo_Segregado,&
		ll_Saldo_Filial_1
		
String	ls_Mensagem		

Try
	lds_Saldo = Create dc_uo_ds_base
	
	If Not lds_Saldo.of_ChangeDataObject("ds_ge252_qtde_saldo_produto_agrupamento") Then 
		Return False
	End If
	
	ldh_Saldo = DateTime(String(gf_GetServerDate(), '01/mm/yyyy'))
	
	ll_Linhas = lds_Saldo.Retrieve(al_Agrupamento, ldh_Saldo)
	
	If ll_Linhas < 0 Then
		MessageBox("Erro", "Erro no retrievr da 'ds_ge252_qtde_saldo_produto_agrupamento'")
		Return False
	End If
	
	If ll_Linhas > 0 Then
		ls_Mensagem = "Produtos sem saldo o suficiente na filial 1:~r~r"
		
		For ll_linha = 1 To ll_Linhas
			ll_Produto				= lds_Saldo.Object.cd_produto		[ll_linha]
			ll_Saldo_Segregado	= lds_Saldo.Object.qt_devolver		[ll_linha]
			ll_Saldo_Filial_1		= lds_Saldo.Object.qt_saldo_final	[ll_linha]
			
			ls_Mensagem += "Produto: "+String(ll_Produto)+ "   Saldo Segregado: "+String(ll_Saldo_Segregado)+"   Saldo Filial 1: "+String(ll_Saldo_Filial_1)+"~r"
		Next
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem)
		Return False
	End If

Finally
	Destroy(lds_Saldo)
End Try

Return True
end function

public function boolean wf_baixa_reserva_item_nf_transf_lote (long al_filial, long al_nota, string as_especie, string as_serie, long al_natureza_operacao, long al_produto, string as_lote, ref long al_qtde, ref string as_erro);Decimal 	ldc_Qt_Descartar,&
			ldc_Qt_Reserva
			
//Valida para a quantidade de reserva n$$HEX1$$e300$$ENDHEX$$o ser maior do que a quantidade recebida
Select 	qt_reserva_descarte
Into 	:ldc_Qt_Reserva
From 	item_nf_transferencia_lote
Where cd_filial_origem			= :al_Filial
	and nr_nf 						= :al_Nota
	and de_especie 				= :as_Especie
	and de_serie 					= :as_Serie
	and cd_natureza_operacao 	= :al_Natureza_Operacao
	and cd_produto 				= :al_Produto
	and nr_lote 					= :as_Lote
Using SqlCa;

If  SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao validar a quantidade de reserva: "+SqlCa.SqlErrText
	Return False
End If
	
ldc_Qt_Descartar = al_Qtde	

If ldc_Qt_Descartar > ldc_Qt_Reserva Then
	as_Erro = "A quantidade '" + String(ldc_Qt_Descartar) + "' descartada n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a quantidade '" + String(ldc_Qt_Reserva) + "' da reserva da tabela 'item_nf_transferencia_lote'.~r~r"+&
					"Nota :"+String(al_Nota)+"~r"+&
					"Esp$$HEX1$$e900$$ENDHEX$$cie: "+as_Especie+"~r"+&
					"S$$HEX1$$e900$$ENDHEX$$rie: "+as_Serie+"~r"+&
					"Natureza de opera$$HEX2$$e700e300$$ENDHEX$$o: "+String(al_Natureza_Operacao)+"~r"+&
					"Produto: "+String(al_Produto)+"~r"+&
					"Lote: "+as_Lote
	Return False
End If

//Atualiza a quantidade de reserva 
Update item_nf_transferencia_lote
Set 	qt_reserva_descarte = IsNull(qt_reserva_descarte, 0) - :ldc_Qt_Descartar,
		qt_descartada = IsNull(qt_descartada, 0) + :ldc_Qt_Descartar
Where cd_filial_origem			= :al_Filial
	and nr_nf 						= :al_Nota
	and de_especie 				= :as_Especie
	and de_serie 					= :as_Serie
	and cd_natureza_operacao 	= :al_Natureza_Operacao
	and cd_produto 				= :al_Produto
	and nr_lote 					= :as_Lote
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao atualizar a reserva de transfer$$HEX1$$ea00$$ENDHEX$$ncia na tabela 'item_nf_transferencia_lote': "+SqlCa.SqlErrText
	Return False
End If

Return True
end function

public function boolean wf_verifica_notas_agrupamento (long al_agrupamento);dc_uo_ds_base lds_Notas

Long 	ll_Linhas,&
		ll_Linha

String ls_Notas = ""


lds_Notas = Create dc_uo_ds_base

If Not lds_Notas.of_ChangeDataObject("ds_ge252_notas_agrupamento") Then
	Return False
End If

ll_Linhas = lds_Notas.Retrieve(al_Agrupamento)

If ll_Linhas < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as notas do agrupamento.")
	Return False
End If

If ll_Linhas > 0 Then
	Return True
End If

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado notas no agrupamento. Aguarde at$$HEX1$$e900$$ENDHEX$$ que as notas sejam geradas.")

Return False
end function

public function boolean wf_notas_diversas_canceladas (long al_agrupamento);dc_uo_ds_base lds_Notas

Long 	ll_Linhas,&
		ll_Linha

String ls_Notas = ""

Try
	lds_Notas = Create dc_uo_ds_base
	
	If Not lds_Notas.of_ChangeDataObject("ds_ge252_notas_diversas_nao_canceladas") Then
		Return False
	End If

	ll_Linhas = lds_Notas.Retrieve(al_Agrupamento)
	
	If ll_Linhas < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as notas diversas n$$HEX1$$e300$$ENDHEX$$o canceladas.")
		Return False
	End If
	
	If ll_Linhas = 0 Then
		Return True
	Else
		For ll_Linha = 1 To ll_Linhas
			If ls_Notas = "" Then
				ls_Notas = String(lds_Notas.Object.nr_nf[ll_Linha])
			Else
				ls_Notas += ", "+ String(lds_Notas.Object.nr_nf[ll_Linha])
			End If
		Next
	End If
Finally
	Destroy(lds_Notas)
End Try

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para reabrir o agrupamento ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio cancelar as seguintes notas diversas: "+ls_Notas+".")

Return False
end function

public function boolean wf_carrega_chave_movimento_estoque (ref string ps_log);select newid()
Into :is_chave_movimento_estoque
from parametro
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log	= "Erro ao localizar a chave do movimento de estoque. Erro: "+ SqlCa.SqlErrText
	Return False
End If

ivo_Movimentacao.is_chave_movimento	= is_chave_movimento_estoque

Return True
end function

public function boolean wf_verifica_protocolo ();long ll_count

SELECT count(cd_produto)
  INTO :ll_count
  FROM agrupamento_dev_compra_prd_prt
 WHERE nr_agrupamento = :ist_parametros_protocolo.nr_agrupamento
 USING SqlCa;		
 
If SqlCa.SqlCode = -1 Then
	Sqlca.of_MsgDbError("Erro ao consultar WMS_PROTOCOLO.")
	Return False
End If		

if ll_count = 0 then return false

return true
end function

public subroutine _documentacao ();/*
  Objetivo: Necessidade Segregado Defeito Fabrica
	Chamado: 924829

Tabelas: - wms_protocolo
         - item_nf_transf_lote_conf
         - item_nf_transferencia_lote	
         - agrupamento_dev_compra_prd_prt


Consulta, Exclui e Cancela agrupamento de produtos com Defeito de Fabrica
*/
end subroutine

public subroutine wf_ajusta_lista_compras ();integer i,&
        li_linhas,&
		  li_item,&
		  li_lista

string ls_nr_lote,&
		 ls_lote_lista

long ll_nr_nf_ds, ll_nr_nf_dw, ll_qt_devolver, ll_qtd_lista, ll_count = 0

double ldb_cd_produto, ldb_cd_produto_lista

dw_15.accepttext()
li_linhas = dw_15.rowcount()
li_lista = tab_1.tabpage_3.dw_4.rowcount()

for i = 1 to li_linhas
	
	ldb_cd_produto = double(dw_15.object.cd_produto[i])
	ls_nr_lote = dw_15.object.nr_lote[i]
	ll_qt_devolver = double(dw_15.object.qt_devolver[i])
	ll_nr_nf_ds = dw_15.object.nr_nf[i]
	
	for li_item = 1 to li_lista
		
		ldb_cd_produto_lista = double(tab_1.tabpage_3.dw_4.object.cd_produto[li_item])
		ls_lote_lista = tab_1.tabpage_3.dw_4.object.nr_lote[li_item]
		ll_qtd_lista = double(tab_1.tabpage_3.dw_4.object.qt_devolver[li_item])
		Choose Case tab_1.tabpage_3.dw_4.dataobject
			Case 'dw_ge252_lista_nota_compras_emite_nota'
				ll_nr_nf_dw =  tab_1.tabpage_3.dw_4.object.nr_nf[li_item]
				
				if (ldb_cd_produto_lista = ldb_cd_produto) and (ls_lote_lista = ls_nr_lote) and (ll_qtd_lista = ll_qt_devolver) and (ll_nr_nf_ds = ll_nr_nf_dw) then
					ll_count++
					
					if ll_count > 1 then
						tab_1.tabpage_3.dw_4.object.vl_preco_unitario[li_item] = 0
						tab_1.tabpage_3.dw_4.object.qt_devolver[li_item] = 0
						tab_1.tabpage_3.dw_4.object.pc_desconto[li_item] = 0
					end if
				end if
			Case 'dw_ge252_lista_nota_compras'
				if (ldb_cd_produto_lista = ldb_cd_produto) and (ls_lote_lista = ls_nr_lote) and (ll_qtd_lista = ll_qt_devolver) then
					ll_count++
					
					if ll_count > 1 then
						tab_1.tabpage_3.dw_4.object.vl_preco[li_item] = 0
						tab_1.tabpage_3.dw_4.object.qt_devolver[li_item] = 0
						tab_1.tabpage_3.dw_4.object.pc_desconto_forn[li_item] = 0
					end if
				end if
		End Choose
		
	next
	ll_count = 0
next

li_lista = tab_1.tabpage_3.dw_4.RowCount()

for li_item = li_lista to 1 step -1
	ll_qt_devolver = tab_1.tabpage_3.dw_4.object.qt_devolver[li_item]
	
	if ll_qt_devolver = 0 then
		tab_1.tabpage_3.dw_4.DeleteRow(li_item)
	end if
next

return
end subroutine

public function boolean wf_busca_param_envia_solicitacao_descart (ref string as_log);String	ls_vl_parametro


select vl_parametro
  into :ls_vl_parametro
  from wms_parametro
 where cd_parametro = 'ID_ENVIA_SOL_DESCARTE_SAP';
 
Choose Case SQLCA.SQLCode
	Case -1
		as_log	= 'Erro na fun$$HEX2$$e700e300$$ENDHEX$$o wf_busca_param_envia_solicitacao_descart.~r~rErro: ' + SQLCA.SQLErrText
		
		ib_envia_sol_descarte_sap	= False
		
		Return FALSE
	Case 100
		as_log	= 'Erro na fun$$HEX2$$e700e300$$ENDHEX$$o wf_busca_param_envia_solicitacao_descart.~r~rN$$HEX1$$e300$$ENDHEX$$o foi encontrado registro para o par$$HEX1$$e200$$ENDHEX$$metro "ID_ENVIA_SOL_DESCARTE_SAP" na tabela wms_parametro.'
		
		ib_envia_sol_descarte_sap	= False
		
		Return FALSE
	Case 0
		ib_envia_sol_descarte_sap = (ls_vl_parametro = 'S')
		
		Return TRUE
End Choose
end function

public function boolean wf_retira_reserva (long al_agrupamento, long al_produto, string as_endereco_agrupamento, string as_lote, boolean ab_resolvido, ref string as_erro, boolean ab_cancelar, long al_nr_nf, string as_de_serie, string as_de_especie, string as_cd_fornecedor);dc_uo_ds_base lds_Notas_Compra

Long 	ll_Linhas,&
		ll_Linha,&
		ll_Filial,&
		ll_Nota,&
		ll_Natureza_Operacao,&
		ll_Produto,&
		ll_Qt_Devolver,&
		ll_qt_reserva
		
String 	ls_Fornecedor,&
			ls_Especie,&
			ls_Serie,&
			ls_Lote, &
			ls_Lote_original
			
Try
	lds_Notas_Compra = Create dc_uo_ds_base
	If Not lds_Notas_Compra.of_ChangeDataObject("ds_ge252_lista_notas_compra") Then Return False
	
	If lds_Notas_Compra.Retrieve(al_agrupamento, al_produto, as_endereco_agrupamento, as_lote) < 0 Then
		as_Erro = "Erro ao localizar as notas de compra."
		Return False
	End If
	
	if not IsNull(al_nr_nf) then
		lds_Notas_Compra.SetFilter("b.nr_nf = " + String(al_nr_nf) + " and b.de_serie = '" + as_de_serie + "' and b.de_especie = '" + as_de_especie + &
											"' and b.cd_fornecedor = '" + as_cd_fornecedor + "'")
		
		lds_Notas_Compra.Filter()
	end if
	
	ll_Linhas = lds_Notas_Compra.RowCount()
	
	For ll_Linha = 1 To ll_Linhas
		ll_Filial					= lds_Notas_Compra.Object.cd_filial[ll_Linha]
		ls_Fornecedor				= lds_Notas_Compra.Object.cd_fornecedor[ll_Linha]
		ll_Nota						= lds_Notas_Compra.Object.nr_nf[ll_Linha]
		ls_Especie					= lds_Notas_Compra.Object.de_especie[ll_Linha]
		ls_Serie						= lds_Notas_Compra.Object.de_serie[ll_Linha]
		ll_Natureza_Operacao		= lds_Notas_Compra.Object.cd_natureza_operacao[ll_Linha]
		ll_Produto					= lds_Notas_Compra.Object.cd_produto[ll_Linha]
		ls_Lote						= lds_Notas_Compra.Object.nr_lote[ll_Linha]
		ls_Lote_original			= lds_Notas_Compra.Object.nr_lote_original[ll_Linha]
		ll_Qt_Devolver				= lds_Notas_Compra.Object.qt_devolver[ll_Linha]
				
		If ab_Resolvido Then
			if ab_cancelar then
				ll_qt_reserva	= 0
			else
				ll_qt_reserva	= ll_Qt_Devolver
			end if
			
			If ls_Fornecedor	 = '053404705' Then
				Update item_nf_transferencia_lote 
				Set qt_descartada = qt_descartada - :ll_Qt_Devolver,
					 qt_reserva_descarte = qt_reserva_descarte + :ll_qt_reserva
				Where cd_filial_origem			= :ll_Filial
					and nr_nf						= :ll_Nota
					and de_especie					= :ls_Especie
					and de_serie					= :ls_Serie
					and cd_natureza_operacao	= :ll_Natureza_Operacao
					and cd_produto					= :ll_Produto
					and nr_lote						= :ls_Lote
					Using SqlCa;
			Else
				Update item_nf_compra_lote 
				Set qt_devolvida  = qt_devolvida - :ll_Qt_Devolver,
					 qt_reserva_devolucao  = qt_reserva_devolucao + :ll_qt_reserva
				Where cd_filial						= :ll_Filial
					and cd_fornecedor				= :ls_Fornecedor
					and nr_nf						= :ll_Nota
					and de_especie					= :ls_Especie
					and de_serie					= :ls_Serie
					and cd_natureza_operacao	= :ll_Natureza_Operacao
					and cd_produto					= :ll_Produto
					and nr_lote						= :ls_Lote
					Using SqlCa;
			End If
				
			If SqlCa.SqlCode = -1 Then	
				as_Erro = "Erro ao atualizar a retirada da reserva: "+SqlCa.SqlErrtext
				Return False		
			End If
			
			If SqlCa.Sqlnrows < 1 Then
				as_Erro = "1 - N$$HEX1$$e300$$ENDHEX$$o foi atualizado a reserva da nota no agrupamento.~rLinhas alteradas: "+String(SqlCa.Sqlnrows)														
				Return False
			End If
		else
			If ls_Fornecedor	 = '053404705' Then
				Update item_nf_transferencia_lote 			
				Set qt_reserva_descarte	= qt_reserva_descarte - :ll_Qt_Devolver
				Where cd_filial_origem			= :ll_Filial
					and nr_nf						= :ll_Nota
					and de_especie					= :ls_Especie
					and de_serie					= :ls_Serie
					and cd_natureza_operacao	= :ll_Natureza_Operacao
					and cd_produto					= :ll_Produto
					and nr_lote						= :ls_Lote
					Using SqlCa;
			Else
				Update item_nf_compra_lote 			
				Set qt_reserva_devolucao  = qt_reserva_devolucao - :ll_Qt_Devolver
				Where cd_filial						= :ll_Filial
					and cd_fornecedor				= :ls_Fornecedor
					and nr_nf						= :ll_Nota
					and de_especie					= :ls_Especie
					and de_serie					= :ls_Serie
					and cd_natureza_operacao	= :ll_Natureza_Operacao
					and cd_produto					= :ll_Produto
					and nr_lote						= :ls_Lote
					Using SqlCa;
			End If
							
			If SqlCa.SqlCode = -1 Then	
				as_Erro = "Erro ao atualizar a retirada da reserva: "+SqlCa.SqlErrtext
				Return False		
			End If
			
			If SqlCa.Sqlnrows < 1 Then
				as_Erro = "2 - N$$HEX1$$e300$$ENDHEX$$o foi atualizado a rezerva da nota no agrupamento.~rLinhas alteradas: "+String(SqlCa.Sqlnrows)														
				Return False
			End If
			
		End If
	Next
	
Finally
	Destroy(lds_Notas_Compra)
End Try

Return True		
end function

public function boolean wf_retira_reserva (long al_agrupamento, long al_produto, string as_endereco_agrupamento, string as_lote, boolean ab_resolvido, ref string as_erro, boolean ab_cancelar);Long	ll_null
String	ls_null


SetNull(ll_null)
SetNull(ls_null)

return wf_retira_reserva(al_agrupamento, al_produto, as_endereco_agrupamento, as_lote, ab_resolvido, as_erro, ab_cancelar, ll_null, ls_null, ls_null, ls_null)
end function

public function boolean wf_retira_produtos_reserva_agrupamento (long al_agrupamento, ref string as_erro);Boolean	lb_Resolvido, lb_Sucesso = True
Long		ll_Produto, ll_Linha, ll_Linhas
String	ls_Endereco, ls_Lote, ls_id_Situacao	


dc_uo_ds_base	lds_produto


lds_produto = Create dc_uo_ds_base
		
If Not lds_Produto.of_ChangeDataObject("ds_ge252_lista_produto") Then Return false
													  
ll_Linhas = lds_Produto.Retrieve(al_Agrupamento) 

For ll_Linha = 1 To ll_Linhas
	ll_Produto			= lds_Produto.Object.cd_produto[ll_linha]
	ls_Endereco			= lds_Produto.Object.cd_endereco_localizacao[ll_linha]
	ls_Lote				= lds_Produto.Object.nr_lote[ll_linha]
	ls_id_Situacao		= lds_Produto.Object.id_situacao[ll_linha]
	
	if ls_id_Situacao = 'R' Then
		lb_Resolvido	= True
	Else
		lb_Resolvido	= False
	End If
	
	If Not wf_Retira_Reserva(	al_Agrupamento,&
										ll_Produto,&
										ls_Endereco,&
										ls_Lote,&
										lb_Resolvido,&
										Ref as_Erro,&
										false) Then
		lb_Sucesso = False
		Exit
	End If		
Next

return lb_Sucesso
end function

public function boolean wf_deleta_produto_nf (long al_agrupamento, long al_produto, string as_endereco, string as_lote, datetime adh_validade, long al_qtde, string as_destino_final, long al_nr_nf, string as_de_serie, string as_de_especie, string as_cd_fornecedor, ref string as_erro);Long	ll_qt_devolver


Delete
from agrupamento_dev_compra_prd_nf
where nr_agrupamento 			= :al_Agrupamento
and cd_produto 					= :al_Produto
and cd_endereco_localizacao 	= :as_Endereco
and nr_lote 						= :as_Lote
and nr_nf							= :al_nr_nf
and de_serie						= :as_de_serie
and de_especie						= :as_de_especie
and cd_fornecedor					= :as_cd_fornecedor
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao deletar o produto da tabela 'agrupamento_dev_compra_prd_nf': "+SqlCa.SqlErrtext
	Return False
End If

select SUM(qt_devolver)
into :ll_qt_devolver
from agrupamento_dev_compra_prd_nf
where nr_agrupamento 			= :al_Agrupamento
and cd_produto 					= :al_Produto
and cd_endereco_localizacao 	= :as_Endereco
and nr_lote 						= :as_Lote;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao buscar quantidade restante na tabela 'agrupamento_dev_compra_prd_nf'~r~rErro: "+SqlCa.SqlErrtext
	Return False
End If

if IsNull(ll_qt_devolver) then ll_qt_devolver = 0

if ll_qt_devolver = 0 then
	Delete
	from agrupamento_dev_compra_prd
	where nr_agrupamento 			= :al_Agrupamento
	and cd_produto 					= :al_Produto
	and cd_endereco_localizacao 	= :as_Endereco
	and nr_lote 						= :as_Lote
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao deletar o produto da tabela 'agrupamento_dev_compra_prd': "+SqlCa.SqlErrtext
		Return False
	End If
Else
	update agrupamento_dev_compra_prd
	set qt_devolver = :ll_qt_devolver
	where nr_agrupamento 			= :al_Agrupamento
	and cd_produto 					= :al_Produto
	and cd_endereco_localizacao 	= :as_Endereco
	and nr_lote 						= :as_Lote
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao atualizar o produto da tabela 'agrupamento_dev_compra_prd': "+SqlCa.SqlErrtext
		Return False
	End If
End If

Return True
end function

public function boolean wf_usuario_liberado (string as_matricula, ref boolean ab_usuario_liberado);String ls_Usuario

Select nr_matricula
Into :ls_Usuario
From usuario_sistema
Where cd_sistema 		= 'WS'
   and nr_matricula 		= :as_Matricula
   and cd_perfil_usuario 	in (1, 5, 32,41,30, 18 )
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ab_usuario_liberado = True
		Return True
	Case 100
		ab_usuario_liberado = False
		Return True
	Case -1 
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Localiza$$HEX2$$e700e300$$ENDHEX$$o do perfil do usuario do WS. ' + SqlCa.SqlErrText, Exclamation!)
End Choose

Return False
end function

public function boolean wf_resolve_agrupamento (long al_linha, string as_obs, string as_responsavel, boolean ab_usuario_liberado, string as_tipo_resolucao, ref string as_resolvidos);Boolean			lb_Sucesso       = True, &
					lb_Agrupar_Notas = False

Date 				ldt_Movimento

DateTime			ldh_Validade

dc_uo_ds_base	lds_produto, &
					lds_produto_agrupados

Long				ll_Agrupamento, &
					ll_Linha, &
					ll_Linhas, &
					ll_Produto, &
					ll_Qtde, &
					ll_Motivo_Ajuste, &
					ll_Find, &
					ll_cd_motivo_devolucao, &
					ll_nr_nf_compra, &
					ll_qt_nota, &
					ll_contador = 0, &
					ll_qt_sem_nota = 0, &
					ll_find_nota, &
					ll_qt_problema, &
					ll_Row, &
					ll_Rows, &
					ll_produtos_sem_nota[], &
					ll_for_prod, &
					ll_cd_filial

String			lvs_Situacao, &
					ls_Endereco, &
					ls_Lote, &
					ls_Erro, &
					ls_Endereco_Origem, &
					ls_Destino_Final, &
					ls_MSG, &
					ls_Notas_Geradas, &
					ls_id_Situacao_nova, &
					ls_cd_fornecedor_agrupamento, &
					ls_de_serie_compra, &
					ls_de_especie_compra, &
		 			ls_Lista_Fornecedores

il_cd_filial_origem_ant 			= 0
il_nr_nf_origem_ant 				= 0
is_cd_fornecedor_origem_ant 	= ''
is_de_especie_origem_ant 		= ''
is_de_serie_ant 					= ''
				
ll_Agrupamento 					= Tab_1.TabPage_1.dw_2.Object.nr_agrupamento      	[al_linha]
ls_Destino_Final					= Tab_1.TabPage_1.dw_2.Object.id_destino_final    		[al_linha]
ls_cd_fornecedor_agrupamento= Tab_1.TabPage_1.dw_2.Object.cd_fornecedor       	[al_linha]
ll_cd_motivo_devolucao			= Tab_1.TabPage_1.dw_2.Object.cd_motivo_devolucao [al_linha]

//Passou a utilizar a fun$$HEX2$$e700e300$$ENDHEX$$o abaixo porque a fun$$HEX2$$e700e300$$ENDHEX$$o sem o agrupamento como argumento acessava a linha da DW com foco, e agora s$$HEX1$$e300$$ENDHEX$$o processadas v$$HEX1$$e100$$ENDHEX$$rias linhas.
If not wf_Situacao_Agrupamento_Fechar (ll_Agrupamento, Ref lvs_Situacao) Then Return False

If ib_Iniciado_Operacao_SAP then
	If lvs_Situacao = 'P' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Para resolver o agrupamento ' + String (ll_Agrupamento) + ', aguarde at$$HEX1$$e900$$ENDHEX$$ o SAP gerar as notas fiscais.')
		Return False
	End If
end if

If lvs_Situacao <> 'F' Then
	If lvs_Situacao = 'R' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'O agrupamento ' + String (ll_Agrupamento) + ' j$$HEX1$$e100$$ENDHEX$$ foi resolvido. Recupere novamente as informa$$HEX2$$e700f500$$ENDHEX$$es.')
		Return False
	Else 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Agrupamento ' + String (ll_Agrupamento) + ' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ FECHADO. Somente os FECHADOS podem ser RESOLVIDOS.')
		Return False
	End If
End If

//Verifica se os produtos do agrupamento tem saldo na tabela SALDO_PRODUTO
If Not wf_Verifica_Saldo_Produto(ll_Agrupamento) Then
	Return False
End If

Try
	If ls_Destino_Final = "N" Then
		
		If as_tipo_resolucao = "D" Then
			ls_Destino_Final = "D"
			
			If wf_Altera_Tipo_Agrupamento(ll_Agrupamento) Then
				If Not ivo_Agrup_Dev_Compra.of_atualiza_valor_agrupamento(ll_Agrupamento, ls_Destino_Final, Ref ls_Erro) Then
					lb_Sucesso = False
					Return False
				End If
			Else
				Return False
			End If						
		Else
			//Verifica se $$HEX1$$e900$$ENDHEX$$ para agrupar tudo em uma $$HEX1$$fa00$$ENDHEX$$nica nota
			If Mid(as_tipo_resolucao, 2,1) = "S" Then
				lb_Agrupar_Notas = True
			End If
		End if
	End If
	
	If ls_Destino_Final = "N" Then//Nota de devolu$$HEX2$$e700e300$$ENDHEX$$o
		//Verifica se tem notas de fornecedor diferente do fornecedor do agrupamento
		If Not wf_Valida_Notas_Fornecedor(ll_Agrupamento, Ref ls_Erro) Then
			lb_Sucesso = False		
			Return False
		End If
	End If
	
	ivo_Movimentacao = Create uo_ge258_movimentacao
	ivo_Movimentacao.ivb_Commit = False

	lds_produto_agrupados = Create dc_uo_ds_base

	If Not lds_produto_agrupados.of_ChangeDataObject("dw_ge252_lista_produto_agrupados") Then 
		lb_Sucesso = False
		Return False
	End if
	
	If lds_produto_agrupados.Retrieve(ll_Agrupamento) < 1 Then
		ls_Erro    ='N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ produtos no agrupamento ' + String (ll_Agrupamento) + ' (dw_ge252_lista_produto_agrupados).'
		lb_Sucesso = False
		Return False
	End If
	
	lds_produto = Create dc_uo_ds_base

	If Not lds_Produto.of_ChangeDataObject("ds_ge252_lista_produto") Then 
		lb_Sucesso = False
		Return False
	End if
	
	ll_Linhas = lds_Produto.Retrieve(ll_Agrupamento)
	
	If ll_Linhas < 1 Then
		lb_Sucesso = False
		ls_Erro    = 'N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ produtos no agrupamento ' + String (ll_Agrupamento) + ' (ds_ge252_lista_produto).'
		Return False
	End If
	
	ll_Find = lds_produto.Find(	"Not Isnull(cd_grupo_psico)", 1, lds_produto.RowCount())
			
	If ll_Find < 0 Then
		lb_Sucesso = False
		ls_Erro    = 'Erro ao localizar produtos controlados no agrupamento ' + String (ll_Agrupamento) + '.'
		Return False
	End If
	
	If ll_Find > 0 Then
		If ls_Destino_Final = "D" Then
			If not ab_usuario_liberado then
				ls_Erro    = 'Existe produto controlado no agrupamento ' + String (ll_Agrupamento) + '. ~rUsu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o esta liberado para este procedimento. ~rPerfil autorizado: GERENTE LOGISTICA e COORDENADORES.'
				lb_Sucesso = False
				Return False
			End If
		End If
	End If
	
	if ib_Iniciado_Operacao_SAP and (ls_Destino_Final = "N" or (ls_Destino_Final = "D" and ib_envia_sol_descarte_sap)) then
		ls_id_Situacao_nova	= 'P'
	else
		ls_id_Situacao_nova	= 'R'
	end if 
	
	Update agrupamento_dev_compra
	Set	id_situacao = :ls_id_Situacao_nova, 
			dh_alteracao_situacao = getdate(), 
			nr_matric_alteracao_situacao =:as_Responsavel, 
			de_observacao =:as_obs
	Where nr_agrupamento =:ll_Agrupamento
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro    = 'Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do agrupamento ' + String (ll_Agrupamento) + ': ' + SqlCa.SQLErrText
		lb_Sucesso = False
		Return False
	End If
	
	ldt_Movimento 	= Date(gvo_Parametro.of_Dh_Movimentacao())

	// Se for descarte.
	If ls_Destino_Final <> "N" Then//Diferente de nota de devolu$$HEX2$$e700e300$$ENDHEX$$o
		ll_contador			= 1
		
		For ll_Linha = 1 To ll_Linhas
			ll_cd_filial				= lds_Produto.Object.cd_filial[ll_linha]
			ll_Agrupamento 			= lds_Produto.Object.nr_agrupamento[ll_linha]
			ll_Produto					= lds_Produto.Object.cd_produto[ll_linha]
			ls_Endereco					= ivs_Endereco_Agrupamento
			ls_Lote						= lds_Produto.Object.nr_lote[ll_linha]
			ldh_Validade				= lds_Produto.Object.dh_validade[ll_linha]
			ll_Qtde						= lds_Produto.Object.qt_devolver[ll_linha]
			ll_nr_nf_compra			= lds_Produto.Object.nr_nf[ll_linha]
			ls_de_especie_compra		= lds_Produto.Object.de_especie[ll_linha]
			ls_de_serie_compra		= lds_Produto.Object.de_serie[ll_linha]
			ll_Motivo_Ajuste			= lds_Produto.Object.cd_motivo_ajuste	[ll_Linha]	
			ls_Endereco_Origem 		= lds_Produto.Object.cd_endereco_localizacao[ll_Linha]
			ll_qt_nota					= lds_Produto.Object.qt_nota[ll_Linha]
			ll_qt_sem_nota				= lds_Produto.Object.qt_sem_nota[ll_Linha]
						
			// A nova regra o sistema ir$$HEX1$$e100$$ENDHEX$$ gravar o movimento de entrada na filial 1 tamb$$HEX1$$e900$$ENDHEX$$m para os produtos VENCIDOS/DANIFICADOS
			If ivs_nova_regra_vencido_danificado = "S" Then
				If IsNull(ll_Motivo_Ajuste) Then
					ls_Erro    = "O endere$$HEX1$$e700$$ENDHEX$$o '" + ls_Endereco_Origem + "' do produto '" + String (ll_Produto) + &
									 "' do agrupamento " + String (ll_Agrupamento) + " n$$HEX1$$e300$$ENDHEX$$o possui o motivo de ajuste de estoque cadastrado."
					lb_Sucesso = False
					Exit
				End If
			End If
			
			if ib_Iniciado_Operacao_SAP and ib_envia_sol_descarte_sap then
				ll_find_nota	= 0
				
				if ll_Linha = ll_Linhas then
					ll_find_nota	= -1
				else
					ll_find_nota	= lds_Produto.Find("cd_produto = " + String(ll_produto) + " and " + &
																 "nr_lote	= '" + ls_lote + "' and "+&
																 "nr_agrupamento = " + String(ll_agrupamento) + " and " + &
																 "cd_endereco_localizacao = '" + ls_Endereco_Origem + "'", ll_Linha + 1, lds_Produto.RowCount())
				end if								 
				
				if ll_find_nota > 0 then
					ll_contador	= 0
				else
					if ll_qt_nota > 0 then
						ll_contador	= ll_qt_nota
					else
						ll_contador	= 0
					end if
				end if
				
				if not wf_inserir_wms_int_sap(ll_Agrupamento, &
														ll_produto, &
														ls_Lote, &
														ll_cd_motivo_devolucao, &
														ldh_Validade, &
														ls_Endereco, &
														ll_linha, &
														ls_cd_fornecedor_agrupamento, &
														ls_Destino_Final, &
														as_Responsavel, &
														ls_Endereco_Origem, &
														ll_nr_nf_compra, &
														ls_de_especie_compra, &
														ls_de_serie_compra, &
														ll_qt_nota, &
														ll_contador, &
														ll_qt_sem_nota, &
														is_Cod_Transportador, &
														is_Obs_NF, &
														ll_Motivo_Ajuste, &
														ll_cd_filial) then 
					lb_Sucesso = False
					Exit
				end if
			else
				If Not wf_Movimenta_Produto(	ll_Produto,&
														ivs_Endereco_Agrupamento,&
														ls_Endereco,&
														ls_Lote,&
														ldh_Validade,&
														ll_Qtde,&
														as_Responsavel,&
														"J",&
														ll_Agrupamento, &
														Ref ls_Erro) Then		
					lb_Sucesso = False
					Exit
				End If
			end if
			
		Next
	Else //Se for devolu$$HEX2$$e700e300$$ENDHEX$$o
		
		If not ib_Iniciado_Operacao_SAP then
			If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Deseja imprimir as etiquetas dos volumes das notas fiscais do agrupamento ' + String (ll_agrupamento) + '?', Question!, YesNo!, 1) = 1 Then
				ib_Imprimir_Etiqueta = True
				
				//Abre tela para selecionar a impressora
				If PrintSetup() = -1 Then
					MessageBox("Aviso", "As etiquetas dos volumes das notas fiscais n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o impressas.")
					ib_Imprimir_Etiqueta = False 
				End If
			Else
				ib_Imprimir_Etiqueta = False
			End If
			
			If Not wf_gera_nota_devolucao_compra(ll_Agrupamento, as_Responsavel, lb_Agrupar_Notas, Ref ls_Notas_Geradas, Ref ls_Erro) Then
				lb_Sucesso = False
			End If
		Else
			
			If Not ib_transportadora_informada Then
				ll_Rows = Tab_1.TabPage_1.dw_2.rowcount()
				For ll_Row= 1 To ll_Rows
					If  Tab_1.TabPage_1.dw_2.Object.id_resolver[ll_Row] = 'S' Then
						If len(ls_Lista_Fornecedores) < 9 Then
							ls_Lista_Fornecedores += "'" + Tab_1.TabPage_1.dw_2.Object.cd_fornecedor[ll_Row] + "'"
						Else
							ls_Lista_Fornecedores += ",'" + Tab_1.TabPage_1.dw_2.Object.cd_fornecedor[ll_Row] + "'"
						End If
					End If
				Next
				
				OpenWithParm(w_ge252_observacao_nf, ls_Lista_Fornecedores)
				
				If IsNull(Message.StringParm) Or Message.StringParm = "" Then
					Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Processo abortado.')
					lb_Sucesso = False
					Return False
				End If
							
				is_Cod_Transportador = Mid(Message.StringParm, 1, (PosA (String(Message.StringParm), ";", 1)-1))
				is_Obs_NF = Mid(Message.StringParm, (PosA (String(Message.StringParm), ";", 1)+1) , 40)  
				
				ib_transportadora_informada = True
			End If
					
			ib_Imprimir_Etiqueta = False
			
			For ll_Linha = 1 To lds_Produto.RowCount()
				ll_Agrupamento 			= lds_Produto.Object.nr_agrupamento[ll_linha]
				ll_Produto					= lds_Produto.Object.cd_produto[ll_linha]
				ls_Endereco					= ivs_Endereco_Agrupamento
				ls_Lote						= lds_Produto.Object.nr_lote[ll_linha]
				ldh_Validade				= lds_Produto.Object.dh_validade[ll_linha]
				ll_Qtde						= lds_Produto.Object.qt_devolver[ll_linha]
				ls_Endereco_Origem 		= lds_Produto.Object.cd_endereco_localizacao[ll_Linha]	
				ll_nr_nf_compra			= lds_Produto.Object.nr_nf[ll_linha]
				ls_de_especie_compra		= lds_Produto.Object.de_especie[ll_linha]
				ls_de_serie_compra		= lds_Produto.Object.de_serie[ll_linha]
				
				If not wf_inserir_wms_int_sap(ll_Agrupamento, &
														ll_produto, &
														ls_Lote, &
														ll_cd_motivo_devolucao, &
														ldh_Validade, &
														ls_Endereco, &
														ll_linha, &
														ls_cd_fornecedor_agrupamento, &
														ls_Destino_Final, &
														as_Responsavel, &
														ls_Endereco_Origem, &
														ll_nr_nf_compra, &
														ls_de_especie_compra, &
														ls_de_serie_compra, &
														0, &
														0, &
														0, &
														is_Cod_Transportador, &
														is_Obs_NF, &
														ll_Motivo_Ajuste, &
														ll_cd_filial) then 
					lb_Sucesso = False
					Exit
				End if 
			Next
		End if
	End If
	
	// Grava os Registros para Coleta
	If lb_Sucesso and not ib_Iniciado_Operacao_SAP Then 
		If ls_Destino_Final = "N" Then 
			If Not wf_Gera_Coleta_Pendente (ll_Agrupamento, Ref ls_Erro	) Then 																		
				lb_Sucesso = False
			End If 				
		End If 
	End If 
	
	if lb_Sucesso then
		ll_qt_problema	= 0
		
		if not wf_valida_wms_int_sap(ll_agrupamento, REF ll_qt_problema, REF ls_erro) then
			lb_sucesso = False
		end if
	end if
	
	if lb_Sucesso then
		if ll_qt_problema > 0 then
			ls_erro = 'Quantidade devolvida/descartada n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ de acordo com o agrupamento. Favor informar a TI.'
			lb_sucesso = False
		end if
	end if
	
	If lb_Sucesso Then
		SqlCa.of_Commit()
		
		If not ib_Iniciado_Operacao_SAP and ls_Destino_Final = 'N' then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O agrupamento '" + String (ll_Agrupamento) + "' foi resolvido com sucesso.~r"+&
											"Foi gerado a(s) nota(s) "+ls_Notas_Geradas+" de devolu$$HEX2$$e700e300$$ENDHEX$$o de compra.")
		else
			If as_resolvidos = '' then
				as_resolvidos = String (ll_Agrupamento)
			else
				as_resolvidos += ', ' + String (ll_Agrupamento)
			End if
		End if
		
	else
		Return False
	End If
Catch (RunTimeError rte)
	SQLCA.of_rollback()
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', rte.GetMEssage(), StopSign!)
	
Finally
	If not lb_Sucesso then
		SqlCa.of_Rollback()
		If Trim (ls_Erro) <> '' then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_Erro)
		End if
	End if
	
	If IsValid (ivo_Movimentacao) then Destroy ivo_Movimentacao
	If IsValid (lds_produto)      then Destroy lds_produto
End Try

Return True
end function

public function boolean wf_valida_wms_int_sap (long al_nr_agrupamento, ref long al_count_problemas, ref string as_log);select 
	count(*)
into
	:al_count_problemas
from (
	select 
		ap.nr_agrupamento, 
		ap.cd_produto, 
		sum(ap.qt_devolver) qt_devolver 
	from 
		dbo.agrupamento_dev_compra a 
	inner join 
		dbo.agrupamento_dev_compra_prd ap 
		on ap.nr_agrupamento = a.nr_agrupamento  
		where 
			a.nr_agrupamento in (:al_nr_agrupamento) 
		group by 
			ap.nr_agrupamento, 
			ap.cd_produto ) as tudo
left outer join (
	select 
		wis.nr_agrupamento_dev_compra, 
		wd.cd_produto, 
		sum(wd.qt_lote) qt_lote 
	from 
		dbo.wms_int_sap wis 
	  inner join 
		dbo.wms_int_sap_detalhe wd
			on wd.nr_integracao = wis.nr_integracao 
	where 
		wis.nr_agrupamento_dev_compra in (:al_nr_agrupamento)
			and wis.id_situacao <> 'X'
	group by 
		wis.nr_agrupamento_dev_compra, 
		wd.cd_produto) as inte 
	on inte.nr_agrupamento_dev_compra = tudo.nr_agrupamento 
	and inte.cd_produto = tudo.cd_produto
where 
	tudo.qt_devolver <> inte.qt_lote;
	
choose case sqlca.sqlcode
	case -1
		as_log	= 'Erro ao validar a inser$$HEX2$$e700e300$$ENDHEX$$o da wms_int_sap para envio ao sap. Favor contatar a TI.~r~rErro: ' + sqlca.sqlerrtext
		Return False
end choose

Return True
end function

public function boolean wf_movimenta_produto (long al_produto, string as_endereco_saida, string as_endereco_destino, string as_lote, datetime adh_validade, long al_qtde, string as_matricula, string as_tipo_movimento, long al_agrupamento, ref string as_erro);String 	ls_Endereco_Entrada,&
			ls_Matricula,&
			ls_Nulo
			
Long 	ll_Nr_Movimentacao,&
		ll_Nulo

ls_Matricula = as_Matricula //gvo_aplicacao.ivo_seguranca.nr_matricula
SetNull(ls_Endereco_Entrada)
SetNull(ls_Nulo)
SetNull(ll_Nulo)

If al_Produto = 709276 Then
	al_Produto = 709276
End If

ivo_Movimentacao.ivb_Commit = False

//ivo_Movimentacao.cd_chave_movimento = is_chave_movimento_estoque

If Not ivo_Movimentacao.of_insere_movimentacao(	ls_Endereco_Entrada,&
																	as_Endereco_Saida,&
																	al_Produto,&
																	1,&
																	as_Lote,&
																	Date(adh_Validade),&
																	al_Qtde,&
																	as_Tipo_Movimento,&
																	ll_Nulo,&
																	ls_Nulo,&
																	al_agrupamento, &
																	'AGP',          &
																	ls_Nulo,&
																	ls_Matricula) Then
	Return False
End If																		


//Se o tipo de movimento for 'J' AJUSTE DE SAIDA, o produto n$$HEX1$$e300$$ENDHEX$$o fica em movimenta$$HEX2$$e700e300$$ENDHEX$$o
// O G s$$HEX1$$f300$$ENDHEX$$ vai existir quando iniciar a opera$$HEX2$$e700e300$$ENDHEX$$o do SAP
If as_Tipo_Movimento = "J" or as_Tipo_Movimento = 'G' Then
	Return True
End If

	//Pega o n$$HEX1$$fa00$$ENDHEX$$mero da movimenta$$HEX2$$e700e300$$ENDHEX$$o
select 	nr_movimentacao
Into 		:ll_Nr_Movimentacao
from wms_movimentacao
where cd_produto 						= :al_Produto
and	nr_matricula_responsavel 	= :ls_Matricula
and 	cd_endereco_saida 			= :as_Endereco_Saida
and 	nr_lote							= :as_Lote
and	qt_caixa_padrao 				= 1
and 	dh_validade 					= :adh_Validade
and id_tipo_movimento = :as_Tipo_Movimento // Tipo 'I' Movimento para agrupamento segregado
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1		
		as_Erro = "Erro selecionar dados do produto: "+ SqlCa.SQLErrText	
		Return False
		
	Case 100
		as_Erro = "Produto n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ em movimenta$$HEX2$$e700e300$$ENDHEX$$o."	
		Return False	
End Choose

If Not ivo_Movimentacao.of_Atualiza_Movimentacao(	as_Endereco_Destino,&
																	al_Produto,&
																	ll_Nr_Movimentacao,&
																	al_Qtde,&
																	as_Lote,&
																	1,&
																	adh_Validade) Then
	Return False
End If
	
Return True
end function

public function boolean wf_movimenta_saldo_divergente_para_agrup (long al_cd_produto, string as_nr_lote, datetime adt_dh_validade, long al_qt_caixa_padrao, long al_qt_movto, string as_cd_endereco_saida, string as_cd_endereco_entrada, string as_cd_fornecedor_agrup, long al_nr_nf_agrup, string as_de_especie_agrup, string as_de_serie_agrup, string as_nr_lote_agrup, datetime adt_dh_validade_agrup, long al_qt_caixa_padrao_agrup, long al_agrupamento, ref string as_erro);Long 		ll_sequencial_end_saida, ll_nr_movimentacao, ll_null
String 	ls_nr_matricula, ls_erro, ls_null

uo_ge258_movimentacao 	luo_movimentacao
dc_uo_ds_base				lds

SetNull(ls_null)
SetNull(ll_null)

ls_nr_matricula	= gvo_aplicacao.ivo_seguranca.nr_matricula

Try
	luo_movimentacao = Create uo_ge258_movimentacao	
	luo_movimentacao.ivb_Commit = False
	luo_movimentacao.ib_mostra_erro_tela	= False
	
	lds = Create dc_uo_ds_base
	
	//Movimento de saida do endere$$HEX1$$e700$$ENDHEX$$o
	If Not luo_movimentacao.of_insere_movimentacao(ls_null, 						/*Endere$$HEX1$$e700$$ENDHEX$$o de entrada*/ &
																  as_cd_endereco_saida, 	/*Endere$$HEX1$$e700$$ENDHEX$$o de sa$$HEX1$$ed00$$ENDHEX$$da*/ &
																  al_cd_produto, 				/*Produto*/ &
																  al_qt_caixa_padrao, 		/*Caixa padr$$HEX1$$e300$$ENDHEX$$o*/ &
																  as_nr_lote, 					/*Lote do produto*/ &
																  Date(adt_dh_validade), 	/*Validade do lote do produto*/ &
																  al_qt_movto, 				/*Quantidade movimentada*/ &
																  "A", 							/*Tipo do movimento SAIDA TOTAL DO ENDERECO*/ &
																  ll_null, 						/*Filial*/ &
																  ls_null, 						/*Fornecedor*/ &
																  al_agrupamento, 			/*Nota Fiscal (usando o n$$HEX1$$fa00$$ENDHEX$$mero do agrupamento)*/ &
																  'AGP', 						/*Esp$$HEX1$$e900$$ENDHEX$$cie*/ &
																  ls_null, 						/*S$$HEX1$$e900$$ENDHEX$$rie*/ &
																  ls_nr_matricula 			/*Matricula do usu$$HEX1$$e100$$ENDHEX$$rio*/ &
																  ) Then		
		as_erro = "Erro ao inserir movimenta$$HEX2$$e700e300$$ENDHEX$$o de DIVERG$$HEX1$$ca00$$ENDHEX$$NCIA para AGRUPAMENTO DEVOLU$$HEX2$$c700c300$$ENDHEX$$O. ~r~r" + luo_movimentacao.is_log_erro
		
		Return False
	End If
	
	If Not luo_movimentacao.of_buscar_ultima_movimentacao(al_cd_produto, 			/*Produto*/ &
																			as_cd_endereco_saida, 	/*Endere$$HEX1$$e700$$ENDHEX$$o de entrada ou sa$$HEX1$$ed00$$ENDHEX$$da*/ &
																			'S', 							/*Tipo do endere$$HEX1$$e700$$ENDHEX$$o E ou S*/ &
																			as_nr_lote, 				/*Lote do produto*/ &
																			al_qt_caixa_padrao, 		/*Caixa Padr$$HEX1$$e300$$ENDHEX$$o*/ &
																			Date(adt_dh_validade), 	/*Data de validade*/ &
																			'A', 							/*Tipo da movimenta$$HEX2$$e700e300$$ENDHEX$$o*/ &
																			ls_nr_matricula, 			/*Matricula do usu$$HEX1$$e100$$ENDHEX$$rio*/ &
																			REF ll_nr_movimentacao) Then
																			
		as_erro = luo_movimentacao.is_log_erro
		
		Return False
	End If
	
	If Not luo_movimentacao.of_atualiza_movimentacao(as_cd_endereco_entrada,	/*Endere$$HEX1$$e700$$ENDHEX$$o de entrada*/ &
																	 al_cd_produto,			 	/*Produto*/ &
																	 ll_nr_movimentacao,		 	/*Movimenta$$HEX2$$e700e300$$ENDHEX$$o*/ &
																	 al_qt_movto,					/*Quantidade movimentada*/ &
																	 as_nr_lote,					/*Lote do produto*/ &
																	 al_qt_caixa_padrao,			/*Caixa padr$$HEX1$$e300$$ENDHEX$$o*/ &
																	 adt_dh_validade				/*Data de validade*/) Then
		as_erro = luo_movimentacao.is_log_erro
		
		Return False
	End If
	
	//Movimenta$$HEX2$$e700e300$$ENDHEX$$o de altera$$HEX2$$e700e300$$ENDHEX$$o de lote
	If Not luo_movimentacao.of_insere_movimentacao(ls_null, 						/*Endere$$HEX1$$e700$$ENDHEX$$o de entrada*/ &
																  as_cd_endereco_entrada, 	/*Endere$$HEX1$$e700$$ENDHEX$$o de sa$$HEX1$$ed00$$ENDHEX$$da*/ &
																  al_cd_produto, 				/*Produto*/ &
																  al_qt_caixa_padrao, 		/*Caixa padr$$HEX1$$e300$$ENDHEX$$o*/ &
																  as_nr_lote, 					/*Lote do produto*/ &
																  Date(adt_dh_validade), 	/*Validade do lote do produto*/ &
																  al_qt_movto, 				/*Quantidade movimentada*/ &
																  "K", 							/*Tipo do movimento*/ &
																  ll_null, 						/*Filial*/ &
																  ls_null, 						/*Fornecedor*/ &
																  al_agrupamento, 			/*Nota Fiscal (usando o n$$HEX1$$fa00$$ENDHEX$$mero do agrupamento)*/ &
																  'AGP', 						/*Esp$$HEX1$$e900$$ENDHEX$$cie*/ &
																  ls_null, 						/*S$$HEX1$$e900$$ENDHEX$$rie*/ &
																  ls_nr_matricula 			/*Matricula do usu$$HEX1$$e100$$ENDHEX$$rio*/ &
																  ) Then		
		as_erro = "Erro ao inserir movimenta$$HEX2$$e700e300$$ENDHEX$$o de Altera$$HEX2$$e700e300$$ENDHEX$$o de Lote (retirada) da DIVERG$$HEX1$$ca00$$ENDHEX$$NCIA para AGRUPAMENTO DEVOLU$$HEX2$$c700c300$$ENDHEX$$O. ~r~r" + luo_movimentacao.is_log_erro
		
		Return False
	End If
	
	If Not luo_movimentacao.of_insere_movimentacao(as_cd_endereco_entrada, 			/*Endere$$HEX1$$e700$$ENDHEX$$o de entrada*/ &
																  ls_null, 								/*Endere$$HEX1$$e700$$ENDHEX$$o de sa$$HEX1$$ed00$$ENDHEX$$da*/ &
																  al_cd_produto, 						/*Produto*/ &
																  al_qt_caixa_padrao_agrup, 		/*Caixa padr$$HEX1$$e300$$ENDHEX$$o*/ &
																  as_nr_lote_agrup, 					/*Lote do produto*/ &
																  Date(adt_dh_validade_agrup),	/*Validade do lote do produto*/ &
																  al_qt_movto, 						/*Quantidade movimentada*/ &
																  "K", 									/*Tipo do movimento*/ &
																  ll_null, 								/*Filial*/ &
																  ls_null, 								/*Fornecedor*/ &
																  al_agrupamento, 			/*Nota Fiscal (usando o n$$HEX1$$fa00$$ENDHEX$$mero do agrupamento)*/ &
																  'AGP', 						/*Esp$$HEX1$$e900$$ENDHEX$$cie*/ &
																  ls_null, 								/*S$$HEX1$$e900$$ENDHEX$$rie*/ &
																  ls_nr_matricula 					/*Matricula do usu$$HEX1$$e100$$ENDHEX$$rio*/ &
																  ) Then		
		as_erro = "Erro ao inserir movimenta$$HEX2$$e700e300$$ENDHEX$$o de Altera$$HEX2$$e700e300$$ENDHEX$$o de Lote (entrada) da DIVERG$$HEX1$$ca00$$ENDHEX$$NCIA para AGRUPAMENTO DEVOLU$$HEX2$$c700c300$$ENDHEX$$O. ~r~r" + luo_movimentacao.is_log_erro
		
		Return False
	End If	
	
	//Insere registro no segregado recebimento
	insert into wms_segregado_recebimento(
			  cd_endereco,
			  cd_fornecedor,
			  nr_nf,
			  de_especie,
			  de_serie,
			  cd_produto,
			  nr_lote,
			  dh_validade,
			  qt_lote,
			  dh_inclusao)
	values (:as_cd_endereco_entrada,
			  :as_cd_fornecedor_agrup,
			  :al_nr_nf_agrup,
			  :as_de_especie_agrup,
			  :as_de_serie_agrup,
			  :al_cd_produto,
			  :as_nr_lote_agrup,
			  :adt_dh_validade_agrup,
			  :al_qt_movto,
			  GetDate())
	using SqlCa;
		
	If SQLCA.SQLCode = -1 Then
		as_erro	= SQLCA.SQLErrText
		
		SqlCa.of_Rollback()
		
		as_erro = "Erro no Insert da tabela 'wms_segregado_recebimento'. ~r~rErro: " + as_erro
		
		Return False
	End If
Finally
	Destroy(lds)
	Destroy(luo_movimentacao)
End Try

Return True
end function

public function boolean wf_qtde_produto (string as_acao, ref long al_qtde);st_parametros_qtd_produto	lstr_qtd

lstr_qtd.as_acao = as_acao
lstr_qtd.al_qtde = al_qtde

OpenWithParm (w_ge252_qtde_produto, lstr_qtd)

al_Qtde = Message.DoubleParm	

If al_Qtde < 0 Then
	Return False
Else
	Return True
End If
end function

public function boolean wf_verifica_protocolo_agrupamento (long al_produto, string as_lote, long al_agrupamento, ref long al_qtde);st_parametros_protocolo	lstr_ptc

lstr_ptc.cd_produto 		= al_produto
lstr_ptc.nr_lote 			= as_lote
lstr_ptc.nr_agrupamento = al_agrupamento

OpenWithParm (w_ge252_protocolo_agrupamento, lstr_ptc)

ist_parametros_protocolo = Message.powerobjectparm	

al_Qtde = ist_parametros_protocolo.qtd_protocolo

If al_Qtde < 0 Then
	Return False
Else
	Return True
End If
end function

public function boolean wf_processa_exclusao_produto (long al_linha, string as_situacao_exclusao);Long		ll_Agrupamento, &
			ll_Produto,     &
			ll_Qtde

String	ls_Endereco,      &
			ls_Lote,          &
			ls_Erro,          &
			ls_Destino_Final

DateTime	ldh_Validade

Tab_1.TabPage_1.dw_2.AcceptText ()

ls_Destino_Final = Tab_1.TabPage_1.dw_2.Object.id_destino_final [Tab_1.TabPage_1.dw_2.GetRow ()]

ll_Agrupamento = Tab_1.TabPage_2.dw_3.Object.nr_agrupamento          [al_linha]
ll_Produto     = Tab_1.TabPage_2.dw_3.Object.cd_produto              [al_linha]
ls_Endereco    = Tab_1.TabPage_2.dw_3.Object.cd_endereco_localizacao [al_linha]
ls_Lote        = Tab_1.TabPage_2.dw_3.Object.nr_lote                 [al_linha]
ldh_Validade   = Tab_1.TabPage_2.dw_3.Object.dh_validade             [al_linha]
ll_Qtde        = Tab_1.TabPage_2.dw_3.Object.qt_devolver             [al_linha]

If Not wf_Retira_Reserva (ll_Agrupamento, &
								  ll_Produto,     &
								  ls_Endereco,    &
								  ls_Lote,        &
								  False,          &
								  Ref ls_Erro,    &
								  False) then
	SQLCA.of_Rollback ()
	MessageBox ('Erro', ls_Erro)
	Return False
End if

// Apaga Agrupamento do Produto com Protocolo, usando Produto e Lote
ist_parametros_protocolo.nr_agrupamento  = ll_Agrupamento
ist_parametros_protocolo.cd_produto      = ll_Produto
ist_parametros_protocolo.nr_lote         = ls_lote
ist_parametros_protocolo.cd_endereco_wms = ls_endereco
ist_parametros_protocolo.de_situacao_exclusao = as_situacao_exclusao

If not ivo_Agrup_Dev_Compra.of_atualiza_agrupamento_protocolo(ist_parametros_protocolo, ls_erro) then
	SQLCA.of_Rollback ()
	MessageBox ('Erro', ls_Erro)
	Return False	
End if										

If Not wf_Deleta_Produto (ll_Agrupamento,   &
								  ll_Produto,       &
								  ls_Endereco,      &
								  ls_Lote,          &
								  ldh_Validade,     &
								  ll_Qtde,          &
								  ls_Destino_Final, &
								  Ref ls_Erro) then
	SQLCA.of_Rollback ()
	MessageBox ('Erro', ls_Erro)
	Return False	
End if

If Not ivo_Agrup_Dev_Compra.of_atualiza_valor_agrupamento (ll_Agrupamento, ls_Destino_Final, Ref ls_Erro) then 
	SQLCA.of_Rollback ()
	MessageBox ('Erro', ls_Erro)
	Return False
End if	

If Not wf_Movimenta_Produto(	ll_Produto,                               &
										ivs_Endereco_Agrupamento,                 &
										ls_Endereco,                              &
										ls_Lote,                                  &
										ldh_Validade,                             &
										ll_Qtde,                                  &
										gvo_aplicacao.ivo_seguranca.nr_matricula, &
										'I',                                      &
										ll_Agrupamento,                           &
										Ref ls_Erro) then
	SQLCA.of_Rollback ()
	MessageBox ('Erro', ls_Erro)
	Return False
End if

Return True
end function

public function boolean wf_reinsere_produto (long al_linha, long al_qtde, string as_novo_agrupamento);//DECLARA$$HEX2$$c700d500$$ENDHEX$$ES
DateTime ldh_Validade

Decimal 	ldc_Preco_Reposicao, &
			ldc_Desconto_Fornecedor

Long		ll_Agrupamento,      &
			ll_Nota,             &
			ll_Motivo_Devolucao, &
			ll_lin_dw2,          &
			ll_Produto

String	ls_Fornecedor,    &
			ls_Endereco,      &
			ls_Lote,          &
			ls_Serie,         &
			ls_Erro,          &
			ls_Destino_Final, &
			ls_Subcategoria

uo_ge040_args luo_args[]

//PROCEDIMENTOS
Tab_1.TabPage_1.dw_2.AcceptText ()
Tab_1.TabPage_2.dw_3.AcceptText ()

ll_lin_dw2 = Tab_1.TabPage_1.dw_2.GetRow ()

ll_Agrupamento        = Tab_1.TabPage_1.dw_2.Object.nr_agrupamento         [ll_lin_dw2]
ls_Fornecedor         = Tab_1.TabPage_1.dw_2.Object.cd_fornecedor          [ll_lin_dw2]
ls_Destino_Final      = Tab_1.TabPage_1.dw_2.Object.id_destino_final       [ll_lin_dw2]
ll_Motivo_Devolucao   = Tab_1.TabPage_1.dw_2.Object.cd_motivo_devolucao    [ll_lin_dw2]

ll_Produto      =      Tab_1.TabPage_2.dw_3.Object.cd_produto              [al_linha]
ls_Lote         =      Tab_1.TabPage_2.dw_3.Object.nr_lote                 [al_linha]
ls_Endereco     =      Tab_1.TabPage_2.dw_3.Object.cd_endereco_localizacao [al_linha]
ldh_Validade    =      Tab_1.TabPage_2.dw_3.Object.dh_validade             [al_linha]
ls_Subcategoria = Mid (Tab_1.TabPage_2.dw_3.Object.cd_subcategoria         [al_linha], 1, 1)

SetNull (ls_Serie)
SetNull (ll_Nota)

If Not ivo_Agrup_Dev_Compra.of_Insere_Produto_No_Agrupamento  (ll_Agrupamento,&
																					ls_Fornecedor,&
																					ll_Nota,&
																					ls_Serie,&
																					ll_Produto,&
																					ls_Lote,&
																					ls_Endereco,&
																					al_Qtde,&
																					ls_Destino_Final,&
																					ldh_Validade,&
																					ll_Motivo_Devolucao,&
																					ls_Subcategoria,&
																					Ref ldc_Preco_Reposicao,&
																					Ref ldc_Desconto_Fornecedor,&
																					Ref luo_args,&
																					Ref ls_erro) then
	SQLCA.of_Rollback ()
	If Trim (ls_erro) <> '' and Not Isnull (ls_erro) then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_erro)
	End if
	Return False
else
	Tab_1.TabPage_2.dw_3.Object.vl_preco               [al_linha] = ldc_Preco_Reposicao
	Tab_1.TabPage_2.dw_3.Object.pc_desconto_fornecedor [al_linha] = ldc_Desconto_Fornecedor
End if

If as_novo_agrupamento = 'S' Then
	If Not ivo_Agrup_Dev_Compra.of_insere_produto_no_agrupamento_protoco(ll_Agrupamento,&
																						ls_Fornecedor,&
																						ll_Nota,&
																						ls_Serie,&
																						ll_Produto,&
																						ls_Lote,&
																						ls_Endereco,&
																						al_Qtde,&
																						Ref ls_erro) then
		SQLCA.of_Rollback ()
		If Trim (ls_erro) <> '' and Not Isnull (ls_erro) then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_erro)
		End if
		Return False
	End If
End If	

Return True
end function

public function boolean wf_inserir_wms_int_sap (long al_agrupamento, long al_produto, string as_lote, long al_cd_motivo_devolucao, datetime adh_validade, string as_endereco, long al_linha, string as_cd_fornecedor_agrupamento, string as_destino_final, string as_responsavel, string as_cd_endereco_origem, long al_nr_nf_compra, string as_de_especie_compra, string as_de_serie_compra, long al_qt_notas, long al_contador_notas, long al_qt_sem_nota, string as_cod_transportadora, string as_observacao_transp, long al_motivo_ajuste, long al_cd_filial_origem);Boolean	lb_inserido_wms = False, lb_Sucesso = true
DateTime	ldh_Fabricacao, ldh_dt_emissao, ldh_Minimo = Datetime('01/01/2000')
Date		ld_Movimento
Long		ll_total_nf_origem, ll_linha_nf_origem, ll_cd_natureza_operacao, &
			ll_resposta, ll_id_tipo_wms, ll_qt_devolver, ll_cd_filial_origem, &
			ll_nr_nf_origem, ll_qt_volume, ll_qt_devolver_total, ll_index, &
			ll_qt_devolver_restante, ll_total_itens, ll_for
String	ls_de_especie_origem, ls_de_serie_origem, &
			ls_nr_lote, ls_cd_fornecedor, ls_mensagem, ls_dados_adicionais, &
			ls_cd_fornecedor_sap, ls_Erro, ls_cd_deposito_sap, ls_cd_fornecedor_incineracao, &
			ls_Tipo_Movimento_WMS, ls_Operador, ls_cd_fornecedor_origem

dc_uo_ds_base	lds_agrupamento_nf_origem
uo_ge040_args	luo_ge040_args[], luo_ge040_args_null[]

ls_Tipo_Movimento_WMS = 'J'

ls_Operador = gvo_aplicacao.ivo_seguranca.nr_matricula

ld_Movimento	= Date(gf_getserverdate())

if ib_Iniciado_Operacao_SAP then	
	if as_destino_final = 'D' then
		//ll_resposta	= MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Deseja solicitar ao SAP a emiss$$HEX1$$e300$$ENDHEX$$o da nota de incinera$$HEX2$$e700e300$$ENDHEX$$o?', Question!, YesNoCancel!, 3)
		
		//Resposta 2 significa que n$$HEX1$$e300$$ENDHEX$$o deseja a incinera$$HEX2$$e700e300$$ENDHEX$$o. Isso $$HEX1$$e900$$ENDHEX$$ feito por que n$$HEX1$$e300$$ENDHEX$$o devemos e emitir ela nesse momento.
		ll_resposta	= 2
		
		choose case ll_resposta
			case 1
				Open(w_ge252_selecao_fornecedor_inc)
				
				ls_cd_fornecedor_incineracao	 = Message.StringParm
				
				if IsNull(ls_cd_fornecedor_incineracao) or Trim(ls_cd_fornecedor_incineracao) = '' then
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O fornecedor n$$HEX1$$e300$$ENDHEX$$o foi selecionado, a opera$$HEX2$$e700e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ interrompida.', StopSign!)
				
					return False
				end if
			case 3
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Opera$$HEX2$$e700e300$$ENDHEX$$o cancelada pelo usu$$HEX1$$e100$$ENDHEX$$rio.', StopSign!)
				
				return False
		end choose
		
		if Trim(ls_cd_fornecedor_incineracao) = '' then
			SetNull(ls_cd_fornecedor_incineracao)
		end if
	Else
		ls_Tipo_Movimento_WMS = 'G'
	end if
	
	lds_agrupamento_nf_origem = Create dc_uo_ds_base
	
	If Not lds_agrupamento_nf_origem.of_ChangeDataObject("ds_ge252_lista_nf_origem") Then 
		SqlCa.of_Rollback()
		Return false
	End if

	If al_cd_filial_origem = 0 then SetNull(al_cd_filial_origem)
	
	ll_total_nf_origem = lds_agrupamento_nf_origem.Retrieve(al_agrupamento, al_produto, as_Lote, as_cd_endereco_origem, al_nr_nf_compra, as_de_especie_compra, as_de_serie_compra, al_cd_filial_origem)

	if ll_total_nf_origem <= 0 then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao carregar itens para envio para o SAP.', StopSign!)
		SqlCa.of_Rollback()
		Return false
	end if
	
	luo_ge040_args	= luo_ge040_args_null
	
	//Adiciona + 1 para incluir um registro dos descartes sem origem do agrupamento
	For ll_linha_nf_origem = 1 To ll_total_nf_origem + 1
		if ll_linha_nf_origem = ll_total_nf_origem + 1 and al_qt_notas = al_contador_notas and al_qt_notas > 0 then
			ll_total_itens	= UpperBound(luo_ge040_args)
			
			if ll_total_itens <= 0 then
				Continue
			end if
		elseif ll_linha_nf_origem = ll_total_nf_origem + 1 and al_qt_notas > al_contador_notas and al_qt_notas > 0  then
			Continue
		elseif ll_linha_nf_origem = ll_total_nf_origem + 1 and al_qt_notas = 0 then
			Continue
		else
			ll_total_itens	= 1
		end if
		
		for ll_for = 1 to ll_total_itens
			if ll_linha_nf_origem = ll_total_nf_origem + 1 then
				SetNull(ll_cd_filial_origem)
				SetNull(ls_cd_fornecedor_origem)
				SetNull(ll_nr_nf_origem)
				SetNull(ls_de_especie_origem)
				SetNull(ls_de_serie_origem)
				SetNull(ll_cd_natureza_operacao)
				
				ls_nr_lote					= luo_ge040_args[ll_for].of_get_arg('nr_lote')
				ls_cd_fornecedor			= luo_ge040_args[ll_for].of_get_arg('cd_fornecedor')
				ll_qt_devolver				= luo_ge040_args[ll_for].of_get_arg('qt_devolver')
				ll_qt_volume				= luo_ge040_args[ll_for].of_get_arg('qt_volume')
			else
				ll_cd_filial_origem		= lds_agrupamento_nf_origem.GetItemNumber(ll_linha_nf_origem, 'cd_filial')
				ls_cd_fornecedor_origem	= lds_agrupamento_nf_origem.GetItemString(ll_linha_nf_origem, 'cd_fornecedor')
				ll_nr_nf_origem			= lds_agrupamento_nf_origem.GetItemNumber(ll_linha_nf_origem, 'nr_nf')
				ls_de_especie_origem		= lds_agrupamento_nf_origem.GetItemString(ll_linha_nf_origem, 'de_especie')
				ls_de_serie_origem		= lds_agrupamento_nf_origem.GetItemString(ll_linha_nf_origem, 'de_serie')
				ls_nr_lote					= lds_agrupamento_nf_origem.GetItemString(ll_linha_nf_origem, 'nr_lote')
				ls_cd_fornecedor			= lds_agrupamento_nf_origem.GetItemString(ll_linha_nf_origem, 'cd_fornecedor')
				ll_cd_natureza_operacao	= lds_agrupamento_nf_origem.GetItemNumber(ll_linha_nf_origem, 'cd_natureza_operacao')
				ll_qt_devolver				= lds_agrupamento_nf_origem.GetItemNumber(ll_linha_nf_origem, 'qt_devolver_nf')
				ll_qt_devolver_total		= lds_agrupamento_nf_origem.GetItemNumber(ll_linha_nf_origem, 'qt_devolver')
				ll_qt_volume				= lds_agrupamento_nf_origem.GetItemNumber(ll_linha_nf_origem, 'qt_volume')
								
				if al_qt_notas = al_contador_notas and al_qt_notas > 0 then
					ll_qt_devolver_restante	= al_qt_sem_nota
					
					if ll_qt_devolver_restante > 0 then
						ll_index	= UpperBound(luo_ge040_args) + 1
						
						luo_ge040_args[ll_index].of_add_arg('nr_lote', ls_nr_lote)
						luo_ge040_args[ll_index].of_add_arg('cd_fornecedor', ls_cd_fornecedor)
						luo_ge040_args[ll_index].of_add_arg('qt_devolver', ll_qt_devolver_restante)
						luo_ge040_args[ll_index].of_add_arg('qt_volume', ll_qt_volume)
					end if
				end if
			end if
			
			if IsNull(ll_qt_volume) or ll_qt_volume <= 0 then
				ll_qt_volume = 1
			end if
			
			if IsNull(il_nr_nf_origem_ant) and IsNull(ll_nr_nf_origem) Then
				if al_linha = 1 then
					lb_inserido_wms	= False
				
					il_seq_wms	= 1
					
					is_de_chave_acesso	= ''
				else
					lb_inserido_wms	= True
				
					il_seq_wms ++
				end if
			elseif Not IsNull(il_nr_nf_origem_ant) and IsNull(ll_nr_nf_origem) then
				lb_inserido_wms	= False
				
				il_seq_wms	= 1
				
				is_de_chave_acesso	= ''
				
				SetNull(il_nr_nf_origem_ant)
			elseif (IsNull(il_nr_nf_origem_ant) and Not IsNull(ll_nr_nf_origem)) or &			
				ll_cd_filial_origem <> il_cd_filial_origem_ant or &
				is_cd_fornecedor_origem_ant <> ls_cd_fornecedor_origem or &
				il_nr_nf_origem_ant <> ll_nr_nf_origem or &
				is_de_especie_origem_ant <> ls_de_especie_origem or &
				is_de_serie_ant <> ls_de_serie_origem then
				lb_inserido_wms	= False
				
				il_seq_wms	= 1
				
				il_cd_filial_origem_ant			= ll_cd_filial_origem
				is_cd_fornecedor_origem_ant	= ls_cd_fornecedor_origem
				il_nr_nf_origem_ant				= ll_nr_nf_origem
				is_de_especie_origem_ant		= ls_de_especie_origem
				is_de_serie_ant					= ls_de_serie_origem
				
				is_de_chave_acesso	= ''
			Else
				lb_inserido_wms	= True
				
				il_seq_wms ++
			End If
			
			if not lb_inserido_wms then
				If not gf_proximo_seq_int_wms(ref il_nr_integracao, ref ls_mensagem) Then
					lb_Sucesso = False
					Exit
				End If
				
				ls_dados_adicionais	= 'Agrupamento: ' + String(al_Agrupamento) + ' - '
				
				if ls_cd_fornecedor = '053404705' then
					ls_dados_adicionais	+= 'NF Transf.: 1156'
					
					select de_chave_acesso
					  into :is_de_chave_acesso
					  from nf_transferencia_nfe
					 where nr_nf				= :ll_nr_nf_origem and
							 cd_filial_origem	= :ll_cd_filial_origem and
							 de_serie			= :ls_de_serie_origem and
							 de_especie			= :ls_de_especie_origem;
							 
					Choose Case SqlCa.SqlCode
						Case -1
							Sqlca.of_MsgDbError("Erro ao buscar chave de acesso da nota de transferencia.")
							
							lb_Sucesso = False
							Exit
					End Choose
					
					select dh_emissao
					  into :ldh_dt_emissao
					  from nf_transferencia
					 where nr_nf				= :ll_nr_nf_origem and
							 cd_filial_origem	= :ll_cd_filial_origem and
							 de_serie			= :ls_de_serie_origem and
							 de_especie			= :ls_de_especie_origem;
							 
					Choose Case SqlCa.SqlCode
						Case -1
							Sqlca.of_MsgDbError("Erro ao buscar data de emiss$$HEX1$$e300$$ENDHEX$$o da nota de transferencia.")
							
							lb_Sucesso = False
							Exit
					End Choose
				else
					select de_chave_acesso,
							 dh_emissao
					  into :is_de_chave_acesso,
							 :ldh_dt_emissao
					  from nf_compra
					 where nr_nf			= :ll_nr_nf_origem and
							 cd_fornecedor	= :ls_cd_fornecedor_origem and
							 cd_filial		= :ll_cd_filial_origem and
							 de_serie		= :ls_de_serie_origem and
							 de_especie		= :ls_de_especie_origem;
							 
					Choose Case SqlCa.SqlCode
						Case -1
							Sqlca.of_MsgDbError("Erro ao buscar chave de acesso da nota de compra.")
							
							lb_Sucesso = False
							Exit
					End Choose
					
					select cd_fornecedor_sap
					  into :ls_cd_fornecedor_sap
					  from fornecedor
					 where cd_fornecedor	= :ls_cd_fornecedor;
					 
					Choose Case SqlCa.SqlCode
						Case -1
							Sqlca.of_MsgDbError("Erro ao buscar c$$HEX1$$f300$$ENDHEX$$digo de fornecedor do SAP.")
							
							lb_Sucesso = False
							Exit
					End Choose
					
					if IsNull(ls_cd_fornecedor_sap) then ls_cd_fornecedor_sap = ''
					 
					 ls_dados_adicionais	+= 'NF Compra.: ' + ls_cd_fornecedor_sap
				end if
				
				if Not IsNull(ll_nr_nf_origem) and Not IsNull(ls_de_especie_origem) and Not IsNull(ls_de_serie_origem) then
					ls_dados_adicionais += '(' + String(ll_nr_nf_origem) + '/' + ls_de_especie_origem + '/' + ls_de_serie_origem + ')'
				end if
				
				ls_dados_adicionais += ' - DT. Emiss$$HEX1$$e300$$ENDHEX$$o: ' +  String(ldh_dt_emissao, 'dd/mm/yyyy')
		
				if as_destino_final = 'D' then
					ll_id_tipo_wms	= 4
				else
					ll_id_tipo_wms	= 2
				end if			
				
				If IsNull(as_observacao_transp) Then as_observacao_transp = ''
				
				ls_dados_adicionais = ls_dados_adicionais + '. ' + as_observacao_transp
				
				INSERT INTO wms_int_sap
								(nr_integracao,
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
								 nr_agrupamento_dev_compra,
								 cd_tipo_movimento_sap,
								 cd_direcao_movimento_sap,
								 cd_fornecedor_incineracao,
								 nr_matricula_responsavel)
					 VALUES  (:il_nr_integracao,					//nr_integracao
								 :ll_id_tipo_wms,						//cd_tipo
								 getdate(),								//dh_inclusao
								 'C',										//id_situacao
								 :ls_cd_fornecedor,					//cd_fornecedor
								 null,									//cd_filial
								 null,									//dh_envio_sap
								 null,									//dh_retorno_sap
								 :as_cod_transportadora,	//cd_transportadora
								 :ll_qt_volume,						//qt_volume
								 null,									//de_especie_volume
								 null,									//de_marca_volume
								 null,									//nr_volume
								 null,									//qt_peso_liquido
								 null,									//qt_peso_bruto
								 :ls_dados_adicionais,				//de_dados_adicionais
								 null,									//nr_nf
								 null,									//de_especie
								 null,									//de_serie
								 :al_cd_motivo_devolucao,			//cd_motivo_devolucao
								 :al_Agrupamento,						//nr_agrupamento_dev_compra
								 'ZUD',									//cd_tipo_movimento_sap
								 '03', 									//cd_direcao_movimento_sap
								 :ls_cd_fornecedor_incineracao, //cd_fornecedor_incineracao
								 :ls_Operador)	
				Using SqlCa;
		
				If SqlCa.SqlCode = -1 Then
					ls_Erro = SqlCa.SQLErrText
					SqlCa.of_RollBack()
					MessageBox("Erro", "Erro na inser$$HEX2$$e700e300$$ENDHEX$$o da wms_int_sap': "+ ls_Erro)	
					lb_Sucesso = False
					Exit
				End If
			End If
									
			ldh_Fabricacao = DateTime(RelativeDate(Date(adh_Validade), -90))
	
			If ldh_Fabricacao >= DateTime(Date(gf_GetServerDate())) Then
				ldh_Fabricacao = DateTime(RelativeDate(Date(gf_GetServerDate()), -30))
			End If
			
			If adh_Validade <= ldh_Minimo Then
				SqlCa.of_RollBack()
				MessageBox("Erro", "A Data de Validade n$$HEX1$$e300$$ENDHEX$$o pode ser menor que 01/01/2000! Produto: " + string(al_Produto) + ", Lote: " + as_lote + "~r~rProcesso abortado!", StopSign!)	
				lb_Sucesso = False
				Exit
			End If
			
			If ldh_Fabricacao <= ldh_Minimo Then
				SqlCa.of_RollBack()
				MessageBox("Erro", "A Data de Fabrica$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser menor que 01/01/2000! Produto: " + string(al_Produto) + ", Lote: " + as_lote + "~r~rProcesso abortado!", StopSign!)	
				lb_Sucesso = False
				Exit
			End If
			
			if not IsNull(as_Endereco) and trim(as_Endereco) <> '' then
				select cd_deposito_sap
				  into :ls_cd_deposito_sap
				  from wms_endereco w inner join wms_bairro b on b.cd_bairro = w.cd_bairro
				 where w.cd_endereco	= :as_Endereco;
				 
				If SqlCa.SqlCode = -1 Then
					ls_Erro = SqlCa.SQLErrText
					SqlCa.of_RollBack()
					MessageBox("Erro", "Erro ao buscar dep$$HEX1$$f300$$ENDHEX$$sito do SAP: "+ ls_Erro)	
					lb_Sucesso = False
					Exit
				End If
			end if
			
			if not wf_carrega_chave_movimento_estoque(ls_Erro) then
				SqlCa.of_RollBack()
				MessageBox("Erro", "Erro ao buscar chave de movimenta$$HEX2$$e700e300$$ENDHEX$$o de estoque': "+ ls_Erro)	
				lb_Sucesso = False
				Exit
			end if
			
			/*Guilherme Cordeiro - Movimenta estoque WMS apenas quando realiza uma devolu$$HEX2$$e700e300$$ENDHEX$$o*/
			if as_destino_final = 'N' then
				If Not wf_Movimenta_Produto(	al_Produto,&
														ivs_Endereco_Agrupamento,&
														as_Endereco,&
														as_Lote,&
														adh_Validade,&
														ll_qt_devolver,&
														as_responsavel,&
														ls_Tipo_Movimento_WMS,&
														al_agrupamento, &
														Ref ls_Erro) Then		
					MessageBox("Erro", "Erro na inser$$HEX2$$e700e300$$ENDHEX$$o na movimenta$$HEX2$$e700e300$$ENDHEX$$o de estoque. ': "+ ls_Erro)	
					lb_Sucesso = False
					Exit
				End If
			End If
			
			if al_motivo_ajuste = 0 then SetNull(al_motivo_ajuste)
			
			INSERT INTO wms_int_sap_detalhe
							(nr_integracao,
							 nr_sequencial,
							 cd_produto,
							 nr_lote,
							 qt_lote,
							 dh_fabricacao,
							 dh_validade,
							 cd_chave_movimento_estoque_wms,
							 id_entrada_saida,
							 cd_deposito_sap_saida,
							 cd_motivo_ajuste)
				  VALUES (:il_nr_integracao,
							 :il_seq_wms,
							 :al_Produto,
							 :as_Lote,
							 :ll_qt_devolver,
							 :ldh_Fabricacao,
							 :adh_Validade,
							 :is_chave_movimento_estoque,
							 'S',
							 :ls_cd_deposito_sap,
							 :al_motivo_ajuste) 
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SQLErrText
				SqlCa.of_RollBack()
				MessageBox("Erro", "Erro na inser$$HEX2$$e700e300$$ENDHEX$$o na wms_int_sap_detalhes': "+ ls_Erro)	
				lb_Sucesso = False
				Exit
			End If
			
			If ls_cd_fornecedor	 = '053404705' Then
				If not IsNull(ll_nr_nf_origem) then
					If Not wf_baixa_reserva_item_nf_transf_lote(	ll_cd_filial_origem,&
																				ll_nr_nf_origem,&
																				ls_de_especie_origem,&
																				ls_de_serie_origem,&
																				ll_cd_natureza_operacao,&
																				al_Produto,&
																				ls_nr_lote,&
																				ll_qt_devolver,&
																				Ref ls_Erro) Then
						SqlCa.of_Rollback()
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro)	
						Return False
					End if
				end if
			Else
				If not IsNull(ll_nr_nf_origem) then
					If Not wf_Baixa_Reserva_item_nf_compra_lote(	ll_cd_filial_origem,&
																				ls_cd_fornecedor_origem,&
																				ll_nr_nf_origem,&
																				ls_de_especie_origem,&
																				ls_de_serie_origem,&
																				ll_cd_natureza_operacao,&
																				al_Produto,&
																				ls_nr_lote,&
																				ll_qt_devolver,&
																				Ref ls_Erro) Then
						SqlCa.of_Rollback()
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro)	
						Return False
					End If
				End If
			end if
			
			INSERT INTO wms_int_sap_auxiliar  
							( nr_integracao,   
							  nr_sequencial,   
							  nr_item,   
							  nr_nf_origem,   
							  de_chave_acesso_origem )  
				  VALUES ( :il_nr_integracao,   
							  :il_seq_wms,   
							  :il_seq_wms,
							  :ll_nr_nf_origem,   
							  :is_de_chave_acesso);
							  
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SQLErrText
				SqlCa.of_RollBack()
				MessageBox("Erro", "Erro na inser$$HEX2$$e700e300$$ENDHEX$$o da wms_int_sap_auxiliar': "+ ls_Erro)	
				lb_Sucesso = False
				Exit
			End If
			
			lb_inserido_wms	= true
		next
	next
end if

return lb_Sucesso
end function

on w_ge252_agrupamento_devolucao_compra.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_15=create dw_15
this.sle_localizar=create sle_localizar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_15
this.Control[iCurrent+3]=this.sle_localizar
end on

on w_ge252_agrupamento_devolucao_compra.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.dw_15)
destroy(this.sle_localizar)
end on

event close;call super::close;Destroy(ivo_fornecedor)
Destroy(ivo_produto)
Destroy(ivo_forn)
//Destroy(ivo_Usuario)
Destroy(ivo_Agrup_Dev_Compra)
Destroy(io_Comprador)
end event

event ue_postopen;call super::ue_postopen;Long		ll_total_agrupamento, ll_for, ll_nr_agrupamento, ll_exists
String	ls_msg, ls_lista_agrupamento, ls_cd_motivo_devolucao_defeito_fabrica
dc_uo_ds_base	lds_agrupamento_problema

sle_localizar.visible = false

//dc_uo_dw_Base lvo_Update[]
//lvo_Update = {Tab_1.TabPage_2.dw_3}
//This.wf_SetUpdate_DW(lvo_Update)

if not gf_verifica_inicio_operacao_sap('DH_INICIO_OPERACAO_SAP', ref ib_Iniciado_Operacao_SAP, ref ls_msg ) then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a data de in$$HEX1$$ed00$$ENDHEX$$cio de opera$$HEX2$$e700e300$$ENDHEX$$o do SAP.', StopSign!)
	Close(this)
end if

if not wf_busca_param_envia_solicitacao_descart(ref ls_msg) then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_msg, StopSign!)
	Close(this)
end if

Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Recuperar(True)
Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Recuperar(True)

Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Incluir (True)

Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Imprimir(True)
Tab_1.TabPage_3.dw_4.ivo_Controle_Menu.of_Imprimir(True)
Tab_1.TabPage_4.dw_5.ivo_Controle_Menu.of_Imprimir(True)

Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Tab_1.TabPage_3.dw_4.ivo_Controle_Menu.of_SalvarComo(True)
Tab_1.TabPage_4.dw_5.ivo_Controle_Menu.of_SalvarComo(True)

This.ivm_Menu.ivb_Permite_Imprimir = True

ivo_fornecedor 		= Create uo_Fornecedor
ivo_produto    		= Create uo_produto
ivo_forn					= Create uo_Fornecedor
ivo_Agrup_Dev_Compra	= Create uo_ge252_agrupamento_devolucao_compra
io_Comprador			= Create uo_ge149_comprador

String lvds_Devolucao

Tab_1.TabPage_1.dw_9.Event ue_AddRow()
Tab_1.TabPage_1.dw_1.Reset()
Tab_1.TabPage_1.dw_1.Event ue_AddRow()

DataWindowChild lvdwc

Integer lvi_Retorno,	lvi_Row

If Tab_1.TabPage_1.dw_1.GetChild("cd_motivo_devolucao", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_motivo_devolucao", 0)
	lvdwc.SetItem(1, "de_motivo_devolucao", "TODOS")
	
	Tab_1.TabPage_1.dw_1.Object.cd_motivo_devolucao [1] = 0
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do grupo.")
End If

Tab_1.TabPage_1.dw_1.SetFocus()

Tab_1.TabPage_1.dw_1.Object.dt_registro_de [1] = gvo_Parametro.of_DH_Movimentacao()
Tab_1.TabPage_1.dw_1.Object.dt_Registro_Ate[1] = gvo_Parametro.of_DH_Movimentacao()
Tab_1.TabPage_1.dw_1.Object.dt_devolucao   [1] = RelativeDate(Date(gvo_Parametro.of_DH_Movimentacao()), - 365)

ivdt_Movimento = Date(gvo_Parametro.of_DH_Movimentacao())

//Endere$$HEX1$$e700$$ENDHEX$$o onde v$$HEX1$$e300$$ENDHEX$$o os produtos agrupados
ivs_Endereco_Agrupamento = "B900500A"

If Not wf_carrega_parametro() Then Close(This)

lds_agrupamento_problema	= Create dc_uo_ds_base

If Not lds_agrupamento_problema.of_ChangeDataObject("ds_ge252_lista_agrupamento_problema") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao alterar ds para ds_ge252_lista_agrupamento_problema.", StopSign!)
End If

ll_total_agrupamento	= lds_agrupamento_problema.Retrieve()

if ll_total_agrupamento < 0 then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao buscar a lista de agrupamentos com notas canceadas.", StopSign!)
	Close(This)
end if

ls_lista_agrupamento	= ''

for ll_for = 1 to ll_total_agrupamento
	ll_nr_agrupamento	= lds_agrupamento_problema.GetItemNumber(ll_for, 'nr_agrupamento')
	
	ls_lista_agrupamento	+= String(ll_nr_agrupamento)
	
	if ll_for < ll_total_agrupamento then
		ls_lista_agrupamento	 += ', '
	else
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A lista a seguir de agrupamentos n$$HEX1$$e300$$ENDHEX$$o foi cancelado, no entanto existe(m) nota(s) canceladas(s).' + '~n~n' + 'Lista: ' + ls_lista_agrupamento)
	end if
next

Tab_1.TabPage_1.dw_9.of_Set_Somente_Leitura(False)

SELECT
	wp.vl_parametro
INTO
	:ls_cd_motivo_devolucao_defeito_fabrica
FROM
	wms_parametro wp
WHERE
	wp.cd_parametro	= 'CD_MOTIVO_DEVOLUCAO_DEFEITO_FABRICA';
	
Choose Case SQLCA.SQLCode
	Case -1
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel carregar o par$$HEX1$$e200$$ENDHEX$$metro CD_MOTIVO_DEVOLUCAO_DEFEITO_FABRICA. ~r~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel continuar com o funcionamento normal da tela, favor acionar a TI.' + '~r~r' + 'Erro: ' + SQLCA.SQLErrText, StopSign!)
		Close(This)
	Case 100
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi encontrado o par$$HEX1$$e200$$ENDHEX$$metro CD_MOTIVO_DEVOLUCAO_DEFEITO_FABRICA. N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel continuar com o funcionamento normal da tela, favor acionar a TI.', StopSign!)
		Close(This)
	Case 0
		if Trim(ls_cd_motivo_devolucao_defeito_fabrica) <> '' and not IsNull(ls_cd_motivo_devolucao_defeito_fabrica) then
			if IsNumber(ls_cd_motivo_devolucao_defeito_fabrica) then
				il_cd_motivo_devolucao_defeito_fabrica	= Long(ls_cd_motivo_devolucao_defeito_fabrica)
				
				SELECT
					1
				INTO
					:ll_exists
				FROM
					motivo_devolucao_compra
				WHERE
					cd_motivo_devolucao = :il_cd_motivo_devolucao_defeito_fabrica;
					
				Choose Case SQLCA.SQLCode
					Case -1
						MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel consultar a existencia do motivo de devolu$$HEX2$$e700e300$$ENDHEX$$o cadastrado.~r~rErro: ' + SQLCA.SQLErrText + '~r~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel continuar com o funcionamento normal da tela, favor acionar a TI.', StopSign!)
						Close(This)
					Case 100
						MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o encontrado o motivo de devolu$$HEX2$$e700e300$$ENDHEX$$o cadastrado.~r~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel continuar com o funcionamento normal da tela, favor acionar a TI.', StopSign!)
						Close(This)
					Case 0
						//Funcionou
				End Choose
			else
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Valor encontrado no par$$HEX1$$e200$$ENDHEX$$metro CD_MOTIVO_DEVOLUCAO_DEFEITO_FABRICA n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ em um formato v$$HEX1$$e100$$ENDHEX$$lido, s$$HEX1$$e300$$ENDHEX$$o aceitos apenas n$$HEX1$$fa00$$ENDHEX$$meros. N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel continuar com o funcionamento normal da tela, favor acionar a TI.', StopSign!)
				Close(This)
			end if
		else
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi informado nenhum valor para o par$$HEX1$$e200$$ENDHEX$$metro CD_MOTIVO_DEVOLUCAO_DEFEITO_FABRICA. N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel continuar com o funcionamento normal da tela, favor acionar a TI.', StopSign!)
			Close(This)
		end if
End Choose

//if not gf_wms_verifica_protocolo_fabrica(ist_parametros_protocolo.id_protocolo_ativo) then return
end event

event open;call super::open;Tab_1.TabPage_1.dw_1.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_1.dw_2.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_3.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_4.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_4.dw_5.of_SetMenu(This.ivm_Menu)


Tab_1.TabPage_1.dw_10.Visible = False

Tab_1.TabPage_4.Visible = False

dw_15.settransobject(sqlca)
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge252_agrupamento_devolucao_compra
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge252_agrupamento_devolucao_compra
integer taborder = 20
end type

type tab_1 from tab within w_ge252_agrupamento_devolucao_compra
integer x = 9
integer y = 4
integer width = 6277
integer height = 2316
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
end on

event selectionchanged;SetPointer(HourGlass!)

/*Choose Case NewIndex
	Case 1
		//This.Width  = 3451
		//This.Width = 3700
		This.Width = 3750
		Tab_1.TabPage_1.dw_1.SetFocus()
		Tab_1.TabPage_1.dw_1.ivm_Menu.mf_Classificar(True)
		Tab_1.TabPage_1.dw_2.ivm_Menu.mf_Classificar(True)
	Case 2
		//This.Width  = 3287
		This.Width = 3868
		Tab_1.TabPage_2.dw_3.SetFocus()
	Case 3
//		This.Width  = 3950
		This.Width  = 4200
	Case 4
		This.Width  = 3579
End Choose
	
Parent.Width  = This.Width  + 65
Parent.Height = This.Height + 160	*/	

SetPointer(Arrow!)
end event

event selectionchanging;SetPointer(HourGlass!)

LONG lvl_Linha

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

sle_localizar.visible = false
sle_localizar.text = ''

If OldIndex = 1 Then
	ivl_Linha_Selecionada = Tab_1.TabPage_1.dw_2.GetRow()
End If

If NewIndex <> 2 Then
 	If wf_Valida_Salva() = -3 Then
		Return 1
	Else
		ivm_Menu.mf_Confirmar(False)
		ivm_Menu.mf_Cancelar (False)
   End If
End If

If NewIndex = 1 and OldIndex = 2 Then
	Tab_1.TabPage_1.dw_1.ivm_Menu.mf_Classificar(True)
	Tab_1.TabPage_1.dw_2.ivm_Menu.mf_Classificar(True)
	//Tab_1.TabPage_1.dw_2.Object.vl_agrupamento[lvl_Linha] = Tab_1.TabPage_2.dw_3.GetItemDecimal(Tab_1.TabPage_2.dw_3.RowCount(), "vl_preco_unitario_total")
End If

If NewIndex = 2 Then
	
	If lvl_Linha > 0 Then
		
		If Not wf_Situacao_Agrupamento(Ref ivs_situacao) Then
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		End If
				
		// Par$$HEX1$$e200$$ENDHEX$$metro utilizado para validar se o produto realmente $$HEX1$$e900$$ENDHEX$$ do fornecedor informado no lote.
		// Este param$$HEX1$$ea00$$ENDHEX$$tro $$HEX1$$e900$$ENDHEX$$ muito importante principalmente para a Belocap que possui v$$HEX1$$e100$$ENDHEX$$rias divis$$HEX1$$f500$$ENDHEX$$es
		Tab_1.TabPage_1.dw_1.AcceptText()
		ivs_Valida_Forn = Tab_1.TabPage_1.dw_1.Object.id_valida_forn[1]
		
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas das DW de detalhes
		Tab_1.TabPage_2.dw_3.Event ue_Retrieve()

		If ivs_situacao <> 'A' Then
			//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente o agrupamento ABERTO poder$$HEX1$$e100$$ENDHEX$$ ser alterado.")
			Tab_1.TabPage_2.st_mensagem.Visible = True
			Tab_1.TabPage_2.dw_3.Object.b_editar.Visible = False
			Tab_1.TabPage_2.dw_3.Object.id_selecionar.Protect = 1
			Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Incluir (False)
			Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Excluir(False)
		Else
			Tab_1.TabPage_2.st_mensagem.Visible = False
			Tab_1.TabPage_2.dw_3.Object.b_editar.Visible = '1~tIf (IsRowNew (), 0, If(qt_devolver = 1, 0,1))'
			Tab_1.TabPage_2.dw_3.Object.id_selecionar.Protect = 0
			Tab_1.TabPage_2.dw_3.Event ue_AddRow()
			Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Incluir (False)
			Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Excluir(True)
		End If		
	
		sle_localizar.visible = true
		// Permite a troca do folder
		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um agrupamento da lista para visualizar ou incluir produtos no agrupamento.", StopSign!, Ok!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If

If NewIndex = 3 Then
	String ls_Destino_Final
	
	if not lvl_Linha > 0  then return 1
	
	ls_Destino_Final = Tab_1.TabPage_1.dw_2.object.id_destino_final[lvl_Linha]
	
	If Not wf_Situacao_Agrupamento(Ref ivs_situacao) Then
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
		
	If ((ivs_situacao = 'A') or(ivs_situacao = 'F')) and  (ls_Destino_Final = "N") Then
		Tab_1.TabPage_3.cb_alterar_nota.Enabled = True	
	Else
		Tab_1.TabPage_3.cb_alterar_nota.Enabled = False	
	End If
		
	If lvl_Linha > 0 Then
		If ls_Destino_Final = "N"  Then //Nota de devolu$$HEX2$$e700e300$$ENDHEX$$o
			Tab_1.TabPage_3.dw_4.of_ChangeDataObject("dw_ge252_lista_nota_compras_emite_nota")
		Else	
			Tab_1.TabPage_3.dw_4.of_ChangeDataObject("dw_ge252_lista_nota_compras")
		End If
		
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas das DW de detalhes
		Tab_1.TabPage_3.dw_4.Event ue_Retrieve()
		
		If Tab_1.TabPage_3.dw_4.RowCount() > 0 Then
			// Permite a troca do folder
			Return 0
		Else
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um agrupamento da lista para visualizar a lista do compras.", StopSign!, Ok!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If

If NewIndex = 4 Then
	If lvl_Linha > 0 Then
		
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas das DW de detalhes
		Tab_1.TabPage_4.dw_5.Event ue_Retrieve()
		
		If Tab_1.TabPage_4.dw_5.RowCount() > 0 Then
			// Permite a troca do folder
			Return 0
		Else
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um agrupamento da lista para visualizar a lista do fiscal.", StopSign!, Ok!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If

If NewIndex = 5 Then
	If lvl_Linha > 0 Then
		
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas das DW de detalhes
		Tab_1.TabPage_5.dw_13.Event ue_Retrieve()
		
		If Tab_1.TabPage_5.dw_13.RowCount() > 0 Then
			// Permite a troca do folder
			Return 0
		Else
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um agrupamento da lista para visualizar a lista de notas fiscais.", StopSign!, Ok!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If

If NewIndex = 6 Then
	If lvl_Linha > 0 Then
		
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas das DW de detalhes
		Tab_1.TabPage_6.dw_14.Event ue_Retrieve()
		
		If Tab_1.TabPage_6.dw_14.RowCount() > 0 Then
			// Permite a troca do folder
			Return 0
		Else
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um agrupamento da lista para visualizar a lista de notas fiscais.", StopSign!, Ok!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If

SetPointer(Arrow!)
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 6240
integer height = 2200
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
cb_7 cb_7
cb_etiq_vol cb_etiq_vol
dw_12 dw_12
cb_3 cb_3
cb_2 cb_2
cb_etiquetas cb_etiquetas
cb_incluir cb_incluir
cb_inserir_volume cb_inserir_volume
cb_reabrir cb_reabrir
cb_resolver cb_resolver
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
cb_alterar cb_alterar
cb_cancelar cb_cancelar
gb_6 gb_6
dw_9 dw_9
cb_fechar cb_fechar
dw_10 dw_10
st_1 st_1
cb_5 cb_5
cb_6 cb_6
end type

on tabpage_1.create
this.cb_7=create cb_7
this.cb_etiq_vol=create cb_etiq_vol
this.dw_12=create dw_12
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_etiquetas=create cb_etiquetas
this.cb_incluir=create cb_incluir
this.cb_inserir_volume=create cb_inserir_volume
this.cb_reabrir=create cb_reabrir
this.cb_resolver=create cb_resolver
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_alterar=create cb_alterar
this.cb_cancelar=create cb_cancelar
this.gb_6=create gb_6
this.dw_9=create dw_9
this.cb_fechar=create cb_fechar
this.dw_10=create dw_10
this.st_1=create st_1
this.cb_5=create cb_5
this.cb_6=create cb_6
this.Control[]={this.cb_7,&
this.cb_etiq_vol,&
this.dw_12,&
this.cb_3,&
this.cb_2,&
this.cb_etiquetas,&
this.cb_incluir,&
this.cb_inserir_volume,&
this.cb_reabrir,&
this.cb_resolver,&
this.gb_2,&
this.gb_1,&
this.dw_1,&
this.dw_2,&
this.cb_alterar,&
this.cb_cancelar,&
this.gb_6,&
this.dw_9,&
this.cb_fechar,&
this.dw_10,&
this.st_1,&
this.cb_5,&
this.cb_6}
end on

on tabpage_1.destroy
destroy(this.cb_7)
destroy(this.cb_etiq_vol)
destroy(this.dw_12)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_etiquetas)
destroy(this.cb_incluir)
destroy(this.cb_inserir_volume)
destroy(this.cb_reabrir)
destroy(this.cb_resolver)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_alterar)
destroy(this.cb_cancelar)
destroy(this.gb_6)
destroy(this.dw_9)
destroy(this.cb_fechar)
destroy(this.dw_10)
destroy(this.st_1)
destroy(this.cb_5)
destroy(this.cb_6)
end on

type cb_7 from commandbutton within tabpage_1
integer x = 2939
integer y = 288
integer width = 695
integer height = 104
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Filtrar Agrup. Por Planilha"
end type

event clicked;Any la_Dado

String	ls_Arquivo,&
		ls_Nome,&
		ls_Acao

Long	ll_Linhas,&
		ll_Linha,&
		ll_Agrupamento

Long ll_Index

String ls_Agrupamentos = ""

Integer li_Retorno

dc_uo_excel lo_Excel

dw_2.SetRedraw (False)

al_Agrupamentos_array = al_Array_Null

li_Retorno = GetFileOpenName('Seleciona o arquivo', + ls_Arquivo, ls_Nome, 'XLS', 'Excel Files (*.xls), *.xls' )

If li_Retorno <> 1 Then 
	Return
End If

Try
	lo_Excel = Create dc_uo_excel
	
	Open(w_Aguarde)
	
	dw_2.AcceptText()
	
	w_Aguarde.Title = 'Verificando planilha, aguarde...'
	
	Tab_1.TabPage_1.dw_2.of_RestoreOriginalSQL()
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
	If ( lo_Excel.uo_Referencia_Objeto_Excel(ls_Arquivo) ) Then
		// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
		ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo('A') 
		
		If ll_Linhas > 0 Then
			w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
			
			For ll_Linha = 1 To ll_Linhas
								
				la_Dado    = lo_Excel.uo_Lendo_Dados(ll_Linha, 'A')
				
				If ll_Linha = 1 Then
					If Not IsNumber(String(la_Dado)) Then
						If String(Upper(la_Dado)) = 'NR_AGRUPAMENTO' Then Continue
					End If
				End If
				
				ll_Agrupamento = Long(la_Dado)	
				
				al_Agrupamentos_array[UpperBound(al_Agrupamentos_array) + 1] = ll_Agrupamento
				
				w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
			Next

			If UpperBound(al_Agrupamentos_array) > 0 Then
				For ll_Index = 1 To UpperBound(al_Agrupamentos_array)
					If ll_Index > 1 Then
						ls_Agrupamentos += ","
					End If
					ls_Agrupamentos += String(al_Agrupamentos_array[ll_Index])
				Next
				
				Tab_1.TabPage_1.dw_2.of_AppendWhere_Subquery("a.nr_agrupamento in (" + ls_Agrupamentos + ")", 2)
			End If
		
		Tab_1.TabPage_1.dw_2.Retrieve()
		
		Else
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A planilha n$$HEX1$$e300$$ENDHEX$$o possui nenhuma linha.')
		End If
	End If

Catch( RuntimeError lo_dwe  )
	MessageBox (	'Erro', 'Ocorreu erro ao ler valores nas colunas do Excel. ~r~r'+ & 						
			'Erro: '+lo_dwe.GetMessage( ), StopSign!)

Finally
	Close(w_Aguarde)
	Destroy(lo_Excel)	
End Try

dw_2.SetRedraw (True)
end event

type cb_etiq_vol from commandbutton within tabpage_1
integer x = 2318
integer y = 2060
integer width = 475
integer height = 100
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Etiquetas Vol"
end type

event clicked;Any		la_notas_selecionadas[]
Long		ll_Nota_Gerada[], ll_row, ll_Volumes, ll_for, ll_nr_agrupamento
String	ls_id_situacao, ls_notas_geradas, ls_lista_notas

uo_ge224_etiqueta_vol_dev_compra	lo_Etiqueta
uo_ge040_array							luo_array


lo_Etiqueta				= Create uo_ge224_etiqueta_vol_dev_compra

ll_row	= tab_1.tabpage_1.dw_2.GetRow()

if ll_row < 1 then return

ls_id_situacao		= tab_1.tabpage_1.dw_2.Object.id_situacao[ll_row]
ll_nr_agrupamento	= tab_1.tabpage_1.dw_2.Object.nr_agrupamento[ll_row]

if ls_id_situacao <> 'R' then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel imprimir as notas de um agrupamento ainda n$$HEX1$$e300$$ENDHEX$$o resolvido.', StopSign!)
	return
end if

OpenWithParm(w_ge252_selecao_nf_agrupadas, ll_nr_agrupamento)

ls_lista_notas	= Message.StringParm

luo_array.uof_list_to_array(ls_lista_notas, la_notas_selecionadas, ',')

for ll_for = 1 to UpperBound(la_notas_selecionadas)
	ll_Volumes	= 1
	
	lo_Etiqueta.of_emite_etiqueta(Long(la_notas_selecionadas[ll_for]), ll_Volumes)
next
end event

type dw_12 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 5829
integer y = 100
integer width = 247
integer height = 184
integer taborder = 30
string dataobject = "dw_ge252_lista_planilha"
end type

event ue_preretrieve;call super::ue_preretrieve;Long ll_Agrupamento, lvl_Linha

Long ll_Motivo_Devolucao

DateTime lvdt_Registro_de,  &
			lvdt_Registro_ate, &
			lvdt_Devolucao

String	lvs_Fornecedor,&
		lvs_Situacao,&
		lvs_Comprador,&
		ls_Tipo

Tab_1.TabPage_1.dw_1.AcceptText()

ll_Agrupamento		= Tab_1.TabPage_1.dw_1.Object.nr_agrupamento			[1]
lvs_Fornecedor    		= Tab_1.TabPage_1.dw_1.Object.cd_fornecedor  				[1]
lvdt_Registro_de  		= Tab_1.TabPage_1.dw_1.Object.dt_registro_de 				[1]
lvdt_Registro_ate 		= Tab_1.TabPage_1.dw_1.Object.dt_registro_ate				[1]
lvdt_Devolucao    		= Tab_1.TabPage_1.dw_1.Object.dt_devolucao   				[1]
lvs_Situacao				= Tab_1.TabPage_1.dw_1.Object.id_situacao  					[1]
lvs_Comprador			= Tab_1.TabPage_1.dw_1.Object.nr_matricula_comprador	[1]
ll_Motivo_Devolucao	= Tab_1.TabPage_1.dw_1.Object.cd_motivo_devolucao		[1]
ls_Tipo					= Tab_1.TabPage_1.dw_1.Object.id_tipo						[1]
lvl_Linha 					= Tab_1.TabPage_1.dw_1.getrow()

If IsNull(lvdt_Registro_de) or Not IsDate(String(lvdt_Registro_de, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Information!)
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "dt_registro_de")
	Return -1
End If

If IsNull(lvdt_Registro_ate) or Not IsDate(String(lvdt_Registro_ate, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Information!)
	Tab_1.TabPage_1.dw_1.SetFocus()
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_registro_ate")
	Return -1
End If

If lvdt_Registro_de > lvdt_Registro_ate Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio deve ser menor ou igual a de t$$HEX1$$e900$$ENDHEX$$rmino.", Information!)
	Tab_1.TabPage_1.dw_1.SetFocus()
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_registro_de")
	Return -1
End If

If IsNull(lvdt_Devolucao) or Not IsDate(String(lvdt_Devolucao, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de emiss$$HEX1$$e300$$ENDHEX$$o das notas fiscais de compras corretamente.", Information!)
	Tab_1.TabPage_1.dw_1.SetFocus()
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_devolucao")
	Return -1
End If

If Not IsNull(ll_Agrupamento) or ll_Agrupamento > 0 Then
	Tab_1.TabPage_1.dw_12.of_AppendWhere_Subquery("a.nr_agrupamento = " + String(ll_Agrupamento),2)
Else
	Tab_1.TabPage_1.dw_12.of_AppendWhere_Subquery("a.dh_inclusao between '"+String(lvdt_Registro_de, "yyyymmdd")+"' and '"+String(lvdt_Registro_ate, "yyyymmdd")+"'",2)
End If

If Not IsNull(lvs_Fornecedor) Then
	Tab_1.TabPage_1.dw_12.of_AppendWhere_Subquery("a.cd_fornecedor = '" + lvs_Fornecedor + "'",2)
End If

If lvs_Situacao <> 'T' Then
	If lvs_Situacao = "B" Then
		Tab_1.TabPage_1.dw_12.of_appendwhere_subquery("a.id_situacao in('A', 'F')",2)
	Else
		Tab_1.TabPage_1.dw_12.of_appendwhere_subquery("a.id_situacao = '" + lvs_Situacao + "'",2)
	End If
End If

If Not IsNull(lvs_Comprador) and lvs_Comprador <> '' Then
	Tab_1.TabPage_1.dw_12.of_appendwhere_subquery("a.nr_matricula_comprador = '" + lvs_Comprador + "'",2)
End If

If ll_Motivo_Devolucao <> 0 Then
	Tab_1.TabPage_1.dw_12.of_appendwhere_subquery("a.cd_motivo_devolucao = " + String( ll_Motivo_Devolucao ),2)
End If

If Not IsNull(ls_Tipo) and ls_Tipo <> "T" Then
	If ls_Tipo = "N" Then
		Tab_1.TabPage_1.dw_12.of_appendwhere_subquery("isnull(a.id_destino_final, '') = 'N'",2)
	Else
		Tab_1.TabPage_1.dw_12.of_appendwhere_subquery("isnull(a.id_destino_final, '') <> 'N'",2)
	End If
End If

Return 1
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	Tab_1.TabPage_1.dw_12.Event ue_SaveAs()	
End If

Return pl_Linhas
end event

type cb_3 from commandbutton within tabpage_1
integer x = 2939
integer y = 156
integer width = 498
integer height = 104
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gerar Planilha"
end type

event clicked;Tab_1.TabPage_1.dw_12.Event ue_Retrieve()
end event

type cb_2 from commandbutton within tabpage_1
integer x = 2939
integer y = 28
integer width = 498
integer height = 104
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Marcar Via Excel"
end type

event clicked;Boolean lb_Sucesso = False

Any la_Dado

String	ls_Arquivo,&
			ls_Nome,&
			ls_Responsavel, &
			ls_Acao

Long	ll_Linhas,&
		ll_Linha,&
		ll_Agrupamento,&
		ll_Find, &
		ll_Qt_DW

Integer li_Retorno

dc_uo_excel lo_Excel

ll_Qt_DW = dw_2.RowCount ()

If ll_Qt_DW < 1 Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Nenhum agrupamento localizado.')
	Return
End If

If Not wf_Responsavel(Ref ls_Responsavel, 'GE252_MARCAR_VIA_EXCEL') Then
	Return
End If

//If gvo_aplicacao.ivo_Seguranca.Cd_Sistema = 'CO' then
//	//Tratamento para Compras (s$$HEX1$$f300$$ENDHEX$$ podem fechar)
//	li_Retorno =  MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
//									  'Os dados devem estar da seguinte forma:' + '~r~r' + &
//									  'Coluna A = Agrupamento' + '~r~r' + 'Apenas os agrupamentos com a situa$$HEX2$$e700e300$$ENDHEX$$o 'ABERTO' ser$$HEX1$$e300$$ENDHEX$$o marcados.')
//else
	//Tratamento para WMS (podem fechar e resolver)
//	li_Retorno =  MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
//									  'Voc$$HEX1$$ea00$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ importando uma lista de agrupamentos a serem FECHADOS?' + '~n~r~r' + &
//									  'SIM : a lista $$HEX1$$e900$$ENDHEX$$ de agrupamentos a serem FECHADOS. S$$HEX1$$f300$$ENDHEX$$ ser$$HEX1$$e300$$ENDHEX$$o marcados os agrupamentos com a situa$$HEX2$$e700e300$$ENDHEX$$o [ABERTO];' + '~n~r~r' + &
//									  'N$$HEX1$$c300$$ENDHEX$$O : a lista $$HEX1$$e900$$ENDHEX$$ de agrupamentos a serem RESOLVIDOS. S$$HEX1$$f300$$ENDHEX$$ ser$$HEX1$$e300$$ENDHEX$$o marcados os agrupamentos com a situa$$HEX2$$e700e300$$ENDHEX$$o [FECHADO].' + '~n~r~r' + &
//									  'Obs.: Os dados devem estar da seguinte forma:' + '~r~r' + &
//									  'Coluna A = Agrupamento', &
//									  Question!, YesNoCancel!, 3)
//End if

OpenWithParm (w_ge252_acao_importacao, ls_Acao)

ls_Acao = Message.StringParm

If IsNull (ls_Acao) then Return

dw_2.SetRedraw (False)

//Limpa a sele$$HEX2$$e700e300$$ENDHEX$$o pr$$HEX1$$e900$$ENDHEX$$-existente
For ll_linha = 1 to ll_Qt_DW
	Choose case ls_Acao
		case 'F'
			dw_2.Object.id_fechar   [ll_linha] = 'N'
		case 'R'
			dw_2.Object.id_resolver [ll_linha] = 'N'
	End choose
Next

li_Retorno = GetFileOpenName('Seleciona o arquivo', + ls_Arquivo, ls_Nome, 'XLS', 'Excel Files (*.xls), *.xls' )

If li_Retorno <> 1 Then 
	Return
End If

Try
	lo_Excel = Create dc_uo_excel
	
	Open(w_Aguarde)
	
	dw_2.AcceptText()

	w_Aguarde.Title = 'Verificando planilha, aguarde...'
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
	If ( lo_Excel.uo_Referencia_Objeto_Excel(ls_Arquivo) ) Then
		// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
		ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo('A') 
		
		If ll_Linhas > 0 Then
			w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
			
			
			For ll_Linha = 1 To ll_Linhas
								
				la_Dado    = lo_Excel.uo_Lendo_Dados(ll_Linha, 'A')
				
				If ll_Linha = 1 Then
					If Not IsNumber(String(la_Dado)) Then
						If String(Upper(la_Dado)) = 'NR_AGRUPAMENTO' Then Continue
					End If
				End If
				
				ll_Agrupamento = Long(la_Dado)	
				
				
				ll_Find = dw_2.Find('nr_agrupamento = '+String(ll_Agrupamento), 1, ll_Qt_DW)
				
				If ll_Find < 0 Then
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro no Find que localiza o agrupamento.')
					Return
				End If
				
				If ll_Find = 0 Then
					Continue
				End If
				
				If ll_Find > 0 Then
					Choose case True
						case ls_Acao = 'F' and dw_2.Object.id_situacao [ll_Find] = 'A'
							dw_2.Object.id_fechar [ll_Find] = 'S'
							lb_Sucesso = True
						case ls_Acao = 'R' and dw_2.Object.id_situacao [ll_Find] = 'F'
							dw_2.Object.id_resolver [ll_Find] = 'S'	
							lb_Sucesso = True
						case else
							MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O agrupamento ' + String (ll_Agrupamento) + ' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ com a situa$$HEX2$$e700e300$$ENDHEX$$o adequada para a a$$HEX2$$e700e300$$ENDHEX$$o escolhida.')
					End choose
				End If
																	
				w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
			Next
		  
		Else
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A planilha n$$HEX1$$e300$$ENDHEX$$o possui nenhuma linha.')
			lb_Sucesso = False
		End If
	End If
	
	If lb_Sucesso Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Agrupamentos marcados com sucesso.')
	Else
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nenhum agrupamento para ser marcado.')
	End If
	
	If ls_Acao = 'F' then
//		cb_fechar.Enabled   = lb_Sucesso
	else
		cb_resolver.Enabled = lb_Sucesso
	End if

Catch( RuntimeError lo_dwe  )
	MessageBox (	'Erro', 'Ocorreu erro ao ler valores nas colunas do Excel. ~r~r'+ & 						
			'Erro: '+lo_dwe.GetMessage( ), StopSign!)

Finally
	Close(w_Aguarde)
	Destroy(lo_Excel)	
End Try

dw_2.SetRedraw (True)
end event

type cb_etiquetas from commandbutton within tabpage_1
integer x = 1769
integer y = 2060
integer width = 475
integer height = 100
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Etiquetas"
end type

event clicked;String	ls_dw_etiqueta

Long 	ll_Row,&
		ll_Qtde_Etiquetas,&
		ll_Linha	

st_parametros_impressao_etiqueta st_etiqueta

dw_2.AcceptText()

ll_Row = dw_2.GetRow()

If ll_Row < 1 Then Return 1

SetNull (ls_dw_etiqueta)

Open (w_ge252_escolhe_impressao_etiqueta)

st_etiqueta = Message.PowerObjectParm

If IsNull (st_etiqueta.nome_dw) then
	MessageBox("Aviso", "Impress$$HEX1$$e300$$ENDHEX$$o cancelada.")
	Return 1
else
	dw_10.of_ChangeDataObject (st_etiqueta.nome_dw)
End if

//Abre tela para selecionar a impressora
If PrintSetup() = -1 Then
	MessageBox("Aviso", "Impress$$HEX1$$e300$$ENDHEX$$o cancelada.")
	Return 1
End If

ll_Qtde_Etiquetas = dw_2.object.nr_volume[ll_Row] 

If IsNull(ll_Qtde_Etiquetas) or (ll_Qtde_Etiquetas < 1) Then
	ll_Qtde_Etiquetas = 1
End If

Dw_10.Reset()

For ll_Linha = 1 To ll_Qtde_Etiquetas
	dw_10.object.de_tipo				[ll_Linha]	= dw_2.object.de_motivo_devolucao									[ll_Row]
	dw_10.object.nr_agrupamento	[ll_Linha]	= dw_2.object.nr_agrupamento										[ll_Row]
	dw_10.object.nm_fornecedor	[ll_Linha]	= dw_2.object.nm_razao_social										[ll_Row]
	dw_10.object.nm_comprador	[ll_Linha]= dw_2.object.nm_usuario_comprador_agrup	[ll_Row]
Next	

If dw_2.object.id_destino_final [ll_Row] <> "D" Then
	Dw_10.Object.t_descarte.Text = ''
Else
	Dw_10.Object.t_descarte.Text = 'DESCARTE'
End If

Dw_10.Object.DataWindow.Print.Orientation = st_etiqueta.orientacao

dw_10.Print()
end event

type cb_incluir from commandbutton within tabpage_1
integer x = 3963
integer y = 2060
integer width = 475
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Incluir"
end type

event clicked;Long lvl_Lote

SetNull(lvl_Lote)

OpenWithParm(w_ge252_cadastro_agrupamento, lvl_Lote)

Tab_1.TabPage_1.dw_2.Retrieve()
end event

type cb_inserir_volume from commandbutton within tabpage_1
integer x = 1051
integer y = 2060
integer width = 645
integer height = 100
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Incluir/Alterar Volume"
end type

event clicked;Long ll_Agrupamento

String lvs_Situacao

If Tab_1.TabPage_1.dw_2.RowCount() > 0 Then

	Tab_1.TabPage_1.dw_2.AcceptText()
	
	ll_Agrupamento = Tab_1.TabPage_1.dw_2.Object.nr_agrupamento[ Tab_1.TabPage_1.dw_2.GetRow() ]
	
	If Not wf_Situacao_Agrupamento(Ref lvs_Situacao) Then Return
		
	If lvs_Situacao = 'R' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O agrupamento j$$HEX1$$e100$$ENDHEX$$ foi RESOLVIDO. Recupere novamente as informa$$HEX2$$e700f500$$ENDHEX$$es.")
		Tab_1.TabPage_1.dw_2.SetFocus()
		Return
	ElseIf lvs_Situacao = 'X' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O agrupamento j$$HEX1$$e100$$ENDHEX$$ foi CANCELADO. Recupere novamente as informa$$HEX2$$e700f500$$ENDHEX$$es.")
		Tab_1.TabPage_1.dw_2.SetFocus()
		Return
	End If
		
	OpenWithParm( w_ge252_cadastro_volume, ll_Agrupamento )
	
	Tab_1.TabPage_1.dw_2.Retrieve()

End If
end event

type cb_reabrir from commandbutton within tabpage_1
integer x = 334
integer y = 2060
integer width = 645
integer height = 100
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Reabrir Agrup."
end type

event clicked;String 	lvs_Responsavel,&
			lvs_Situacao,&
			ls_Destino_Final,&
			ls_Erro

Long 	lvl_Agrupamento,&
		lvl_Produtos

If Tab_1.TabPage_1.dw_2.RowCount() = 0 Then Return

Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Agrupamento	= Tab_1.TabPage_1.dw_2.Object.nr_agrupamento	[Tab_1.TabPage_1.dw_2.GetRow()]
ls_Destino_Final	= Tab_1.TabPage_1.dw_2.Object.id_destino_final		[Tab_1.TabPage_1.dw_2.GetRow()]

If wf_Situacao_Agrupamento(Ref lvs_Situacao) Then
	If lvs_Situacao = 'A' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O agrupamento j$$HEX1$$e100$$ENDHEX$$ esta aberto. Recupere novamente as informa$$HEX2$$e700f500$$ENDHEX$$es.")
		Tab_1.TabPage_1.dw_2.SetFocus()
		Return
	End If
	
	If lvs_Situacao = 'P' and ib_Iniciado_Operacao_SAP Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O agrupamento j$$HEX1$$e100$$ENDHEX$$ esta resolvido e enviado para o SAP. N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel reabrir.")
		Tab_1.TabPage_1.dw_2.SetFocus()
		Return
	End If
	
	// N$$HEX1$$e300$$ENDHEX$$o pode permitir a reabertura porque o sistema n$$HEX1$$e300$$ENDHEX$$o volta a movimenta$$HEX2$$e700e300$$ENDHEX$$o e os saldos.
	If lvs_Situacao = 'X' Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O agrupamento foi [CANCELADO]. N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel reabrir.")
		Tab_1.TabPage_1.dw_2.SetFocus()
		Return
	End If
Else
	Return
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma reabertura do agrupamento '" + String(lvl_Agrupamento) + "' ?", Question!, YesNo!, 2) = 2 Then
	Return
End If	

If wf_Responsavel(Ref lvs_Responsavel, "GE252_ABRIR_AGRUPAMENTO_DEV_COMPRA") Then
	
	If lvs_Situacao = 'R'  Then
		If ls_Destino_Final <> "N" Then //Diferente de nota de devolu$$HEX2$$e700e300$$ENDHEX$$o. Descarte
		
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma reabertura do agrupamento de DESCARTE n$$HEX1$$fa00$$ENDHEX$$mero'" + String(lvl_Agrupamento) + "' ?", Question!, YesNo!, 2) = 1 Then
				If ib_Iniciado_Operacao_SAP Then
					//Verifica se todas as notas foram canceladas
					If Not wf_Notas_Canceladas(lvl_Agrupamento) Then
						Return
					End If
					
					If Not wf_Notas_Diversas_Canceladas(lvl_Agrupamento) Then
						Return
					End If
					
					if Not wf_retira_produtos_reserva_agrupamento(lvl_Agrupamento, REF ls_Erro) Then
						SqlCa.of_Rollback()
						MessageBox("Erro", "Erro ao ajustar estoque do agrupamento para a reabertura.: "+ls_Erro)	
						Tab_1.TabPage_1.dw_2.SetFocus()
						Return
					End If
				End If
				
				If Not wf_Reabrir_Agrupamento_Descarte(lvl_Agrupamento, lvs_Responsavel, Ref ls_Erro) Then
					SqlCa.of_Rollback()
					MessageBox("Erro", "Erro ao reabrir o agrupamento: "+ls_Erro)	
					Tab_1.TabPage_1.dw_2.SetFocus()
					Return
				End If
			Else
				Tab_1.TabPage_1.dw_2.SetFocus()
				Return
			End If
			
		Else
		
			//Verifica se todas as notas foram canceladas
			If Not wf_Notas_Canceladas(lvl_Agrupamento) Then
				Return
			End If
			
			If Not wf_Devolver_Reserva_Notas_Compra(lvl_Agrupamento) Then
				Return 
			End If
			
			Update agrupamento_dev_compra
			Set  id_situacao = 'F', dh_alteracao_situacao = getdate(), nr_matric_alteracao_situacao =:lvs_Responsavel
			Where nr_agrupamento =:lvl_Agrupamento
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do agrupamento.")
				Return 
			End If
		End If
	Else
		Update agrupamento_dev_compra
		Set  id_situacao = 'A', dh_alteracao_situacao = getdate(), nr_matric_alteracao_situacao =:lvs_Responsavel
		Where nr_agrupamento =:lvl_Agrupamento
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do agrupamento.")
			Return 
		End If
	End If
	
	SqlCa.of_Commit();
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O agrupamento '" + String(lvl_Agrupamento) + "' foi aberto com sucesso.")
	
	Tab_1.TabPage_1.dw_2.Retrieve()
	
End If
end event

type cb_resolver from commandbutton within tabpage_1
integer x = 2866
integer y = 2060
integer width = 475
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Resolver"
boolean cancel = true
end type

event clicked;Boolean	lb_usuario_liberado

String 	lvs_Responsavel, &
			ls_Observacao,   &
			ls_Destino_Final, &
			ls_Tipo_Resolucao, &
			ls_resolvidos

Long 		ll_Agrupamento, &
			ll_Linhas,      &
			ll_Linha,       &
			ll_Find,        &
			ll_qtd_agrup_resolv, &
			ll_Agrupamento_bkp

dw_2.AcceptText ()

ll_Linhas = dw_2.RowCount ()

If ll_Linhas = 0 Then Return

//Verifica se tem algum agrupamento marcado
ll_Find = dw_2.Find ("id_resolver = 'S'", 1, ll_Linhas)

If ll_Find = 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o tem nenhum agrupamento selecionado para ser resolvido!', Information!)
	Return
End if

SetNull(is_Cod_Transportador)
SetNull(is_Obs_NF	)
ib_Transportadora_Informada = False

ll_Agrupamento     = dw_2.Object.nr_agrupamento [ll_Find]
ll_Agrupamento_bkp = ll_Agrupamento

ll_qtd_agrup_resolv = dw_2.Object.cf_qtd_agrup_resolv [ll_Linhas]

If ll_qtd_agrup_resolv = 1 then
	If not wf_Responsavel (Ref lvs_Responsavel, "GE252_RESOLVER_AGRUPAMENTO") then Return
else
	If not wf_Responsavel (Ref lvs_Responsavel, "GE252_RESOLVER_AGRUPAMENTO_EM_MASSA") then Return
End if

If Not wf_Usuario_liberado(lvs_Responsavel, Ref lb_usuario_liberado) Then Return

If Not wf_localiza_parametro_regra_vencido () then Return

If ll_qtd_agrup_resolv = 1 then
	ls_Destino_Final = Tab_1.TabPage_1.dw_2.Object.id_destino_final [ll_Find]
	ls_Observacao    = dw_2.Object.de_observacao [ll_find]
	OpenWithParm (w_ge252_observacao, ls_Observacao)
else
	ls_Destino_Final = Tab_1.TabPage_1.dw_1.Object.id_tipo [1]
	If ls_Destino_Final = 'T' then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Para resolver mais de um agrupamento, $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio filtrar a pesquisa por tipo ("DESCARTE" OU "NOTA DE DEVOLU$$HEX2$$c700c300$$ENDHEX$$O DE COMPRA").', Information!)
		Return
	End if
	
	ls_Observacao = ''
	
	OpenWithParm (w_ge252_obs_varios_agrup, ls_Observacao)
	
	ll_Agrupamento = 0
End if

ls_Observacao = Message.StringParm

If ls_Observacao = '' Then 
	Return
End If

If ib_Iniciado_Operacao_SAP and (ls_Destino_Final = 'N' or (ls_Destino_Final = 'D' and ib_envia_sol_descarte_sap)) then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O(s) agrupamento(s) selecionado(s) ser$$HEX1$$e100$$ENDHEX$$($$HEX1$$e300$$ENDHEX$$o) RESOLVIDO(S) somente depois que o SAP gerar a NFD/Descarte.', Information!)
End if

If ls_Destino_Final = 'N' then
	
	OpenWithParm (w_ge252_resolver, ll_Agrupamento)
	
	ls_Tipo_Resolucao = Message.StringParm
	
	If ls_Tipo_Resolucao = '' then Return
else
	If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
						'Confirma a altera$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do(s) agrupamento(s) selecionado(s) para RESOLVIDO?' + '~r~r' + &
						'Obs.: O sistema ir$$HEX1$$e100$$ENDHEX$$ fazer automaticamente os ajustes de estoques.', &
						Question!, YesNo!, 2) = 2 then
		Return
	End if
End if

ls_resolvidos = ''

Open (w_aguarde)
w_aguarde.Title = 'Aguarde...'
w_aguarde.uo_progress.of_SetMax (ll_qtd_agrup_resolv)

Do Until ll_Find = 0
	SetPointer (HourGlass!)
	
	ll_Linha ++
	w_aguarde.Title = 'Resolvendo agrupamento ' + String (ll_Linha) + ' de ' + String (ll_qtd_agrup_resolv)
	w_aguarde.uo_progress.of_SetProgress (ll_Linha)
	
	If Not wf_resolve_agrupamento (ll_Find, ls_Observacao, lvs_Responsavel, lb_usuario_liberado, ls_Tipo_Resolucao, Ref ls_resolvidos) Then
		Close (w_aguarde)
		Return -1
	End If
	
	if ll_Find = ll_Linhas then
		ll_Find = 0
	else
		ll_Find = dw_2.Find ("id_resolver = 'S'", ll_Find + 1, ll_Linhas)
	End if
Loop

Close (w_aguarde)

If ls_resolvidos <> '' then
	If ib_Iniciado_Operacao_SAP and &
		(ls_Destino_Final = 'N' or (ls_Destino_Final = 'D' and ib_envia_sol_descarte_sap)) then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O(s) agrupamento(s) ' + '~n~r~r' + ls_resolvidos + '~n~r~r' + 'foi(foram) enviado(s) para o SAP com sucesso.')
	else		
		If ls_Destino_Final <> 'N' then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O(s) agrupamento(s) ' + '~n~r~r' + ls_resolvidos + '~n~r~r' + 'foi(foram) resolvido(s) com sucesso.')
		End If
	end if
End if

ll_Linhas = dw_2.Retrieve()

If ll_Linhas > 0 Then
	//Posiciona no 1o agrupamento selecionado anteriormente
	ll_Find = dw_2.Find ('nr_agrupamento = ' + String (ll_Agrupamento_bkp), 1, ll_Linhas)	
	
	If ll_Find > 0 Then
		dw_2.SetRow (ll_Find)
		dw_2.ScrollToRow (ll_Find)
	End If
End If

SetPointer (Arrow!)
end event

type gb_2 from groupbox within tabpage_1
integer x = 9
integer y = 384
integer width = 6213
integer height = 1284
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Lista de Agrupamentos"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within tabpage_1
integer x = 9
integer width = 2894
integer height = 380
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within tabpage_1
integer x = 37
integer y = 52
integer width = 2843
integer height = 320
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge252_parametro"
end type

event ue_key;String lvs_Nulo

If Key = KeyEnter! Then
	
	If This.GetColumnName() = "nm_comprador" Then
		io_Comprador.of_Localiza_Comprador(This.GetText())
		
		If io_Comprador.Localizado Then
			This.Object.nr_matricula_comprador	[1] = io_Comprador.nr_matricula
			This.Object.nm_comprador				[1] = io_Comprador.nm_usuario
		End If
	End If
	
	If This.GetColumnName() = 'nm_fantasia' Then
		ivo_Fornecedor.of_Localiza_Fornecedor(dw_1.GetText())
	
		If ivo_Fornecedor.Localizado Then
			dw_1.Object.cd_fornecedor[1] = ivo_Fornecedor.cd_fornecedor
			dw_1.Object.nm_fantasia  [1] = ivo_Fornecedor.Nm_Razao_Social
		Else
			SetNull(lvs_Nulo)
					
			dw_1.Object.cd_fornecedor[1] = lvs_Nulo
			dw_1.Object.nm_fantasia  [1] = lvs_Nulo
		End If
	End If
	
End If



end event

event itemchanged;call super::itemchanged;//If dwo.name = 'nm_fantasia'    or &
//	dwo.name = 'nr_agrupamento'        or &
//	dwo.name = 'dt_registro_de' or &
//	dwo.name = 'dt_registro_ate' Then
//	Tab_1.TabPage_1.dw_2.Reset()
//End If

If dwo.name <> 'dt_devolucao' and dwo.name <> 'id_valida_forn' Then
	Tab_1.TabPage_1.dw_2.Reset()
End If

If dwo.Name = 'nm_fantasia' Then
	If Not IsNull(data) and Trim(data) <> "" Then
		If data <> ivo_Fornecedor.Nm_Razao_Social Then
			Return 1
		End If
	Else
		ivo_Fornecedor.of_Inicializa()
	
		This.Object.cd_fornecedor[1] = ivo_Fornecedor.cd_fornecedor
		This.Object.nm_fantasia  [1] = ivo_Fornecedor.nm_razao_social
	End If
End If

If dwo.Name = "nm_comprador" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> io_Comprador.nm_usuario Then
			Return 1
		End If
	Else
		io_Comprador.of_Inicializa()
		
		This.Object.nr_matricula_comprador	[1] = io_Comprador.nr_matricula
		This.Object.nm_comprador				[1] = io_Comprador.nm_usuario
	End If
End If

//If dwo.Name = "id_filtro_planilha" Then
//	If Data = "S" Then
//		SetNull(is_Arquivo_Excel)
//		Open(w_ge250_importacao_chaves)
//		is_Arquivo_Excel = Message.StringParm
//	End If	
//End if

cb_Etiquetas.Enabled = False

end event

event losefocus;call super::losefocus;If IsValid(ivo_Fornecedor) Then
	This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
	This.Object.Nm_Fantasia  [1] = ivo_Fornecedor.Nm_Razao_Social
End If

If IsValid(io_Comprador) Then
	This.Object.nr_matricula_comprador	[1] = io_Comprador.nr_matricula
	This.Object.nm_comprador				[1] = io_Comprador.nm_usuario
End If
end event

event constructor;call super::constructor;This.of_SetColSelection(True)


end event

event ue_recuperar;// OverRide

Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
Return 1
end event

event getfocus;call super::getfocus;dw_2.ivo_Controle_Menu.of_Atualiza()



end event

event editchanged;call super::editchanged;Date ldt_Null

Long ll_Null

SetNull( ldt_Null )
SetNull( ll_Null )

If dwo.name <> 'dt_devolucao' and dwo.name <> 'id_valida_forn' Then
	Tab_1.TabPage_1.dw_2.Reset()
	
	Tab_1.TabPage_1.dw_9.Object.nr_matricula_inclusao    		[1] = ""
	Tab_1.TabPage_1.dw_9.Object.nm_responsavel					[1] = ""
	Tab_1.TabPage_1.dw_9.Object.dh_alteracao						[1] = ldt_Null
	Tab_1.TabPage_1.dw_9.Object.nr_matric_alteracao_situacao	[1] = ""
	Tab_1.TabPage_1.dw_9.Object.nm_usuario_alteracao			[1] = ""
	Tab_1.TabPage_1.dw_9.Object.de_observacao						[1] = ""
	Tab_1.TabPage_1.dw_9.Object.nr_matricula_comprador			[1] = ""
	Tab_1.TabPage_1.dw_9.Object.nm_usuario_comprador			[1] = ""
	Tab_1.TabPage_1.dw_9.Object.de_motivo_devolucao				[1] = ""
	Tab_1.TabPage_1.dw_9.Object.dh_envio_sap						[1] = ldt_Null
	Tab_1.TabPage_1.dw_9.Object.nr_volume							[1] = ll_Null
	
End If

ivw_ParentWindow.ivb_Valida_Salva = False
cb_Etiquetas.Enabled = False
end event

event ue_sort;call super::ue_sort;Tab_1.TabPage_1.dw_1.ivm_Menu.mf_Classificar(True)	
Tab_1.TabPage_1.dw_2.ivm_Menu.mf_Classificar(True)

Tab_1.TabPage_1.dw_2.Event ue_Sort()
end event

type dw_2 from dc_uo_dw_base within tabpage_1
integer x = 41
integer y = 436
integer width = 6158
integer height = 1224
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge252_lista_agrupamento"
boolean vscrollbar = true
boolean livescroll = false
end type

event ue_recuperar;// OverRide

Long ll_Agrupamento, lvl_Linha

Long ll_Motivo_Devolucao

DateTime lvdt_Registro_de,  &
			lvdt_Registro_ate, &
			lvdt_Devolucao

String	lvs_Fornecedor,&
		lvs_Situacao,&
		lvs_Comprador,&
		lvs_Tipo,&
		lvs_Controlado

Tab_1.TabPage_1.dw_1.AcceptText()

al_Agrupamentos_array = al_Array_Null

ll_Agrupamento		= Tab_1.TabPage_1.dw_1.Object.nr_agrupamento			[1]
lvs_Fornecedor    		= Tab_1.TabPage_1.dw_1.Object.cd_fornecedor  				[1]
lvdt_Registro_de  		= Tab_1.TabPage_1.dw_1.Object.dt_registro_de 				[1]
lvdt_Registro_ate 		= Tab_1.TabPage_1.dw_1.Object.dt_registro_ate				[1]
lvdt_Devolucao    		= Tab_1.TabPage_1.dw_1.Object.dt_devolucao   				[1]
lvs_Situacao				= Tab_1.TabPage_1.dw_1.Object.id_situacao  					[1]
lvs_Comprador			= Tab_1.TabPage_1.dw_1.Object.nr_matricula_comprador	[1]
ll_Motivo_Devolucao	= Tab_1.TabPage_1.dw_1.Object.cd_motivo_devolucao		[1]
lvs_Tipo					= Tab_1.TabPage_1.dw_1.Object.id_tipo						[1]
lvs_Controlado			= Tab_1.TabPage_1.dw_1.Object.id_controlado				[1]

lvl_Linha 				=  Tab_1.TabPage_1.dw_1.getrow()

If IsNull(lvdt_Registro_de) or Not IsDate(String(lvdt_Registro_de, "dd/mm/yyyy"))Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Information!)
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "dt_registro_de")
	Return -1
End If 

If IsNull(lvdt_Registro_ate) or Not IsDate(String(lvdt_Registro_ate, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Information!)
	Tab_1.TabPage_1.dw_1.SetFocus()
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_registro_ate")
	Return -1
End If 

If lvdt_Registro_de > lvdt_Registro_ate Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio deve ser menor ou igual a de t$$HEX1$$e900$$ENDHEX$$rmino.", Information!)
	Tab_1.TabPage_1.dw_1.SetFocus()
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_registro_de")
	Return -1
End If 

If IsNull(lvdt_Devolucao) or Not IsDate(String(lvdt_Devolucao, "dd/mm/yyyy"))Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de emiss$$HEX1$$e300$$ENDHEX$$o das notas fiscais de compras corretamente.", Information!)
	Tab_1.TabPage_1.dw_1.SetFocus()
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_devolucao")
	Return -1
End If


If Not IsNull(ll_Agrupamento) or ll_Agrupamento > 0 Then 
	Tab_1.TabPage_1.dw_2.of_AppendWhere_Subquery("a.nr_agrupamento = " + String(ll_Agrupamento),2)	
Else
	Tab_1.TabPage_1.dw_2.of_AppendWhere_Subquery("a.dh_inclusao between '"+String(lvdt_Registro_de, "yyyymmdd")+"' and '"+String(lvdt_Registro_ate, "yyyymmdd")+"'",2)
End If

If Not IsNull(lvs_Fornecedor) Then
	Tab_1.TabPage_1.dw_2.of_AppendWhere_Subquery("a.cd_fornecedor = '" + lvs_Fornecedor + "'",2)
End If

If lvs_Situacao <> 'T' Then
	If lvs_Situacao = "B" Then
		Tab_1.TabPage_1.dw_2.of_appendwhere_subquery("a.id_situacao in('A', 'F')",2)
	Else
		Tab_1.TabPage_1.dw_2.of_appendwhere_subquery("a.id_situacao = '" + lvs_Situacao + "'",2)
	End If
End If

If Not IsNull(lvs_Comprador) and lvs_Comprador <> '' Then
	Tab_1.TabPage_1.dw_2.of_appendwhere_subquery("a.nr_matricula_comprador = '" + lvs_Comprador + "'",2)
End If

If ll_Motivo_Devolucao <> 0 Then
	Tab_1.TabPage_1.dw_2.of_appendwhere_subquery("a.cd_motivo_devolucao = " + String( ll_Motivo_Devolucao ),2)
End If

If Not IsNull(lvs_Tipo) and lvs_Tipo <> "T" Then
	If lvs_Tipo = "N" Then
		Tab_1.TabPage_1.dw_2.of_appendwhere_subquery("isnull(a.id_destino_final, '') = 'N'",2)
	Else
		Tab_1.TabPage_1.dw_2.of_appendwhere_subquery("isnull(a.id_destino_final, '') <> 'N'",2)
	End If
End If

If Not IsNull(lvs_Controlado) and lvs_Controlado = "S" Then 
	Tab_1.TabPage_1.dw_2.of_appendwhere_subquery("  a.id_tipo =  '1' "  ,2)
End If 

Return This.Retrieve()
end event

event constructor;call super::constructor;//This.of_SetRowSelection()

//This.of_SetRowSelection("", "if( id_situacao  = ~"X~", RGB(255,0, 0), RGB(0,0,0))")
dw_2.of_SetRowSelection( "if(id_destino_final <> ~"N~",  if(getrow() = currentrow(), rgb(145, 141, 13), rgb(224, 219, 19)),  if(getrow() = currentrow(), rgb(0,128,128), rgb(255, 255, 255)) )", "if( id_situacao  = ~"X~", RGB(255,0, 0), RGB(0,0,0))", False )					

This.ivb_Ordena_Colunas = True

String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"nm_razao_social", "nr_agrupamento"}

lvs_Nome   = {"Fornecedor", "C$$HEX1$$f300$$ENDHEX$$digo"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_postretrieve;Boolean lvb_Sucesso = False

Long lvl_Linha,&
		ll_Agrupamento,&
		lvl_Produto,&
		lvl_Linha_DS,&
		lvl_Qt_Devolvida
		
Decimal lvdc_Valor_Reposicao,&
			lvdc_Desconto,&
			lvdc_Total_Agrupamento

String 	lvs_Situacao,&
			ls_Erro
			
If pl_Linhas > 0 Then
	
	cb_inserir_volume.Enabled = True
	
	//Data: 31/03/2015
	// Foi retirado porque o valor do agrupamento $$HEX1$$e900$$ENDHEX$$ atualizado quando $$HEX1$$e900$$ENDHEX$$ incluido o produto.
	// Progrador: S$$HEX1$$e900$$ENDHEX$$rgio
	
//	SetRedRaw(False)
//	
//	Open(w_aguarde)
//	w_aguarde.title = "Atualizando valores dos agrupamentos..."
//	w_aguarde.uo_progress.Of_SetMax(pl_Linhas)
//	
//  	For lvl_Linha = 1 To pl_Linhas //Dw_2
//		
//		w_aguarde.uo_progress.Of_SetProgress(lvl_Linha)
//		
//		lvs_Situacao = Tab_1.TabPage_1.dw_2.Object.id_situacao	[lvl_Linha]
//		
//		If lvs_Situacao = 'A' Then
//			
//			lvb_Sucesso = False
//			
//			lvdc_Total_Agrupamento = 0.00
//			
//			ll_Agrupamento = Tab_1.TabPage_1.dw_2.Object.nr_agrupamento	[lvl_Linha]
//			
//			dc_uo_ds_base lvds_produto
//			lvds_produto = Create dc_uo_ds_base
//			
//			If Not lvds_Produto.of_ChangeDataObject("ds_ge252_produto_agrupamento") Then 
//				Close(w_aguarde)
//				Return -1
//			End If
//																  
//			lvds_Produto.Retrieve(ll_Agrupamento)
//			
//			If lvds_Produto.RowCount() > 0 Then
//				
//				For lvl_Linha_DS = 1 To lvds_Produto.RowCount() //DataStore
//					
//					lvl_Produto 			= lvds_Produto.Object.cd_produto		[lvl_Linha_DS]
//					lvl_Qt_Devolvida	= lvds_Produto.Object.qt_devolver		[lvl_Linha_DS]
//					
//					If wf_localiza_preco_reposicao(lvl_Produto, Ref lvdc_Valor_Reposicao, Ref lvdc_Desconto, Ref ls_Erro) Then 
//					
//						If wf_atualiza_produto_agrupamento(ll_Agrupamento, lvl_Produto, lvdc_Valor_Reposicao, lvdc_Desconto) Then
//							
//							lvdc_Total_Agrupamento	 +=  round(lvl_Qt_Devolvida * round(lvdc_Valor_Reposicao * ((100 - lvdc_Desconto) / 100), 2), 2)
//														
//							lvb_Sucesso = True
//							
//						End If
//						
//					End If
//					
//					If Not lvb_Sucesso Then Exit
//					
//				Next // Itens Produto Agrupamento DataStore
//			
//			Else
//				If lvds_Produto.RowCount() = 0 Then lvb_Sucesso = True
//			End If // DataStore > 0
//									
//			If lvb_Sucesso Then
//				If wf_Update_Valor_Agrupamento(lvdc_Total_Agrupamento, ll_Agrupamento) Then 
//					Tab_1.TabPage_1.dw_2.Object.vl_agrupamento	[lvl_Linha] = lvdc_Total_Agrupamento
//					SqlCa.of_Commit();
//				Else
//					Close(w_aguarde)
//					Return -1
//				End If
//			End If
//		
//			Destroy(lvds_Produto)
//					
//		End If // Situa$$HEX2$$e700e300$$ENDHEX$$o 'A'
//		
//	Next // Situa$$HEX2$$e700e300$$ENDHEX$$o 'A' Dw_2
//	
//	//wf_Atualiza_Valores()
//	
//	Close(w_aguarde)
//	
//	SetRedRaw(True)
	
	
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
	
	Tab_1.TabPage_1.dw_1.ivm_Menu.mf_Classificar(True)
	Tab_1.TabPage_1.dw_2.ivm_Menu.mf_Classificar(True)

	cb_Etiquetas.Enabled = True
	cb_fechar.Enabled 	= True
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
	
	cb_inserir_volume.Enabled 	= False
	cb_fechar.Enabled 			= False
	
End If

This.ivo_Controle_Menu.of_Imprimir(False)

Return pl_Linhas



end event

event rowfocuschanged;call super::rowfocuschanged;DateTime	ldh_envio_sap, ldh_retorno_sap
Long		ll_nr_agrupamento
String 	lvs_Situacao

If currentrow > 0 Then
	
	cb_alterar.Enabled 			= False
	cb_cancelar.Enabled 			= False
	//cb_fechar.Enabled 			= False
	cb_resolver.Enabled 			= False
	cb_inserir_volume.Enabled 	= False
	cb_etiq_vol.Enabled			= False
	
	lvs_Situacao = This.Object.id_situacao[currentrow]
	
	// ABERTO
	If lvs_Situacao = 'A' Then
		cb_alterar.Enabled 			= True
		cb_cancelar.Enabled 			= True
		cb_inserir_volume.Enabled 	= True
	End If
	
	If lvs_Situacao = 'A' Then
		cb_reabrir.Enabled	= False
	Else
		cb_reabrir.Enabled	= True
	End If
	
	// FECHADO
	If lvs_Situacao = 'F' Then
		cb_cancelar.Enabled 			= True
		cb_resolver.Enabled 			= True
		cb_inserir_volume.Enabled 	= True
	End If
	
	//RESOLVIDO
	If lvs_Situacao = 'R' Then
		cb_cancelar.Enabled 			= True
		cb_etiq_vol.Enabled			= True
	End If
	
	Tab_1.TabPage_1.dw_9.Object.nr_matricula_inclusao		 	[1] = This.Object.nr_matricula_inclusao			[currentrow]
	Tab_1.TabPage_1.dw_9.Object.nm_responsavel					[1] = This.Object.nm_usuario							[currentrow]
	Tab_1.TabPage_1.dw_9.Object.dh_alteracao						[1] = This.Object.dh_alteracao_situacao			[currentrow]
	Tab_1.TabPage_1.dw_9.Object.nr_matric_alteracao_situacao	[1] = This.Object.nr_matric_alteracao_situacao	[currentrow]
	Tab_1.TabPage_1.dw_9.Object.nm_usuario_alteracao			[1] = This.Object.nm_usuario_alteracao				[currentrow]
	Tab_1.TabPage_1.dw_9.Object.de_observacao						[1] = This.Object.de_observacao						[currentrow]
	Tab_1.TabPage_1.dw_9.Object.nr_matricula_comprador			[1] = This.Object.nr_matricula_comprador			[currentrow]
	Tab_1.TabPage_1.dw_9.Object.nm_usuario_comprador			[1] = This.Object.nm_usuario_comprador				[currentrow]
	Tab_1.TabPage_1.dw_9.Object.de_motivo_devolucao				[1] = This.Object.de_motivo_devolucao				[currentrow]
	Tab_1.TabPage_1.dw_9.Object.nr_volume							[1] = This.Object.nr_volume							[currentrow]
	Tab_1.TabPage_1.dw_9.Object.dh_alteracao_situacao			[1] = This.Object.dh_alteracao_situacao			[currentrow]
	
	ll_nr_agrupamento = This.Object.nr_agrupamento[currentrow]
	
	SetNull(ldh_envio_sap)
	SetNull(ldh_retorno_sap)
	
	select Max(dh_envio_sap),
			 Max(dh_retorno_sap)
	  into :ldh_envio_sap,
	  		 :ldh_retorno_sap
	  from wms_int_sap
	 where nr_agrupamento_dev_compra = :ll_nr_agrupamento;
	
	if Sqlca.Sqlcode < 0 then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a data de envio para o SAP do agrupamento selecionado.', StopSign!)
	
		return -1
	end if
	
	Tab_1.TabPage_1.dw_9.Object.dh_envio_sap[1] 		= ldh_envio_sap
	Tab_1.TabPage_1.dw_9.Object.dh_retorno_sap[1] 	= ldh_retorno_sap
	
//	if(IsNull( nr_divisao_fornecedor ), "", "Divis$$HEX1$$e300$$ENDHEX$$o: "+String(nr_divisao_fornecedor)+" - "+ nm_divisao )
	If IsNull(This.Object.nr_divisao_fornecedor	[currentrow]) Then
		This.object.t_divisao_fornecedor.Text = ''
	Else
		This.object.t_divisao_fornecedor.Text = "Divis$$HEX1$$e300$$ENDHEX$$o: "+String(This.Object.nr_divisao_fornecedor	[currentrow])+" - "+ This.Object.nm_divisao[currentrow]
	End If
	
End If
end event

event itemchanged;call super::itemchanged;If dwo.Name = "id_marcar" Then
	If dw_2.Object.id_situacao[row] <> 'A' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Apenas agrupamento ABERTO pode ser fechado.", Exclamation!)
		Return 1
	End If
End If
end event

event ue_sort;call super::ue_sort;Tab_1.TabPage_1.dw_1.ivm_Menu.mf_Classificar(True)	
Tab_1.TabPage_1.dw_2.ivm_Menu.mf_Classificar(True)
end event

event doubleclicked;call super::doubleclicked;Integer	li_Retorno
Long		ll_Linha, &
			ll_Linhas
String	ls_Marcacao, &
			ls_Acao

Choose Case dwo.Name 
	case 't_fechar'
		If ivb_Check_Fechar Then
			ls_Marcacao      = 'N'
			ivb_Check_Fechar = False
		else
			ls_Marcacao      = 'S'
			ivb_Check_Fechar = True
		End if
		
		ll_Linhas = This.RowCount ()
		
		For ll_Linha = 1 To ll_Linhas
			If This.Object.id_situacao [ll_Linha] = 'A' then
				This.Object.id_fechar [ll_Linha] = ls_Marcacao
			End if
		Next
		
	case 't_resolver'
		If ivb_Check_Resolver Then
			ls_Marcacao        = 'N'
			ivb_Check_Resolver = False
		else
			ls_Marcacao        = 'S'
			ivb_Check_Resolver = True
		End if
		
		ll_Linhas = This.RowCount ()
		
		For ll_Linha = 1 To ll_Linhas
			If This.Object.id_situacao [ll_Linha] = 'F' then
				This.Object.id_resolver [ll_Linha] = ls_Marcacao
			End if
		Next
		
End choose
end event

type cb_alterar from commandbutton within tabpage_1
integer x = 4512
integer y = 2060
integer width = 475
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Alterar"
end type

event clicked;Long ll_Agrupamento

String 	lvs_Situacao,&
			ls_Erro,&
			ls_Destino_Final

If Tab_1.TabPage_1.dw_2.RowCount() = 0 Then Return

Tab_1.TabPage_1.dw_2.AcceptText()

ll_Agrupamento	= Tab_1.TabPage_1.dw_2.Object.nr_agrupamento	[Tab_1.TabPage_1.dw_2.GetRow()]
ls_Destino_Final	= Tab_1.TabPage_1.dw_2.Object.id_destino_final		[Tab_1.TabPage_1.dw_2.GetRow()]

If Not wf_Situacao_Agrupamento(Ref lvs_Situacao) Then Return

If lvs_Situacao <> 'A' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente agrupamento ABERTO pode ser ALTERADO. Recupere novamente as informa$$HEX2$$e700f500$$ENDHEX$$es.")
	Tab_1.TabPage_1.dw_2.SetFocus()
	Return
End If

OpenWithParm(w_ge252_Cadastro_Agrupamento, ll_Agrupamento)

If Not ivo_Agrup_Dev_Compra.of_atualiza_valor_agrupamento(ll_Agrupamento, ls_Destino_Final, Ref ls_Erro) Then 
	SqlCa.of_Rollback()
	MessageBox("Erro", ls_Erro)															
	Return
End If

SqlCa.of_Commit()

Tab_1.TabPage_1.dw_2.Retrieve()
end event

type cb_cancelar from commandbutton within tabpage_1
integer x = 5061
integer y = 2060
integer width = 475
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Cancelar"
end type

event clicked;String 	lvs_Responsavel,&
			lvs_OBS,&
			lvs_Situacao,&
			ls_Endereco,&
			ls_Lote,&
			ls_Erro, &
			ls_cd_fornecedor,&
			ls_Destino_Final
			
dc_uo_ds_base lds_produto

Long 	lvl_Agrupamento,&
		ll_Linhas,&
		ll_linha,&
		ll_Agrupamento,&
		ll_Produto,&
		ll_Qtde
		
Boolean 	lb_Sucesso = True	,&
			lb_Resolvido = False

DateTime ldh_Validade

If Tab_1.TabPage_1.dw_2.RowCount() = 0 Then Return

Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Agrupamento = Tab_1.TabPage_1.dw_2.Object.nr_agrupamento[Tab_1.TabPage_1.dw_2.GetRow()]

If Not wf_Situacao_Agrupamento(Ref lvs_Situacao) Then Return

If lvs_Situacao = 'X' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O agrupamento j$$HEX1$$e100$$ENDHEX$$ foi CANCELADO. Recupere novamente as informa$$HEX2$$e700f500$$ENDHEX$$es.")
	Tab_1.TabPage_1.dw_2.SetFocus()
	Return
Else 
	If lvs_Situacao = 'R' Then
		
		if not wf_verifica_notas_agrupamento(lvl_Agrupamento) then return
		if not wf_notas_canceladas(lvl_Agrupamento) then return
		if not wf_notas_diversas_canceladas(lvl_Agrupamento) then return
		
		lb_Resolvido = true
		
//		if ib_Iniciado_Operacao_SAP then
//			if not wf_verifica_notas_agrupamento(lvl_Agrupamento) then return
//			if not wf_notas_canceladas(lvl_Agrupamento) then return
//			if not wf_notas_diversas_canceladas(lvl_Agrupamento) then return
//			
//			lb_Resolvido = true
//		else
//			select count(*)
//			Into :ll_Qtde
//			from nf_devolucao_compra 
//			where cd_filial = 534 
//			and dh_cancelamento is null
//			and nr_agrupamento_dev_compra = :lvl_Agrupamento
//			Using SqlCa;
//			
//			If ll_Qtde = 0 Then
//				lb_Resolvido = True
//			Else
//				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para cancelar o agrupamento RESOLVIDO devem ser canceladas todas as notas de compra referente ao agrupamento.")
//				Tab_1.TabPage_1.dw_2.SetFocus()
//				Return
//			End If
//		end if
	End If
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma o cancelamento do agrupamento '" + String(lvl_Agrupamento) +&
						"' ?", Question!, YesNo!, 2) = 2 Then
		Return
	End If	
End If

If wf_Responsavel(Ref lvs_Responsavel, "GE252_CANCELAR_AGRUPAMENTO_DEV_COMPRA") Then
	Try
		ivo_Movimentacao = Create uo_ge258_movimentacao
		ivo_Movimentacao.ivb_Commit = False
		
		lds_produto = Create dc_uo_ds_base
		
		If Not lds_Produto.of_ChangeDataObject("ds_ge252_lista_produto") Then Return -1
															  
		ll_Linhas = lds_Produto.Retrieve(lvl_Agrupamento) 
		
		If ll_Linhas > 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existe "+ String(ll_linhas)+ " produtos no agrupamento '" + String(lvl_Agrupamento), Question!)
			Return
		End If 
		
		Open(w_ge252_observacao)

		lvs_Obs = Message.StringParm
		
		If lvs_Obs = "" Then Return
		
//		For ll_Linha = 1 To ll_Linhas
//			ll_Agrupamento 	= lds_Produto.Object.nr_agrupamento[ll_linha]
//			ll_Produto			= lds_Produto.Object.cd_produto[ll_linha]
//			ls_Endereco			= lds_Produto.Object.cd_endereco_localizacao[ll_linha]
//			ls_Lote				= lds_Produto.Object.nr_lote[ll_linha]
//			ldh_Validade		= lds_Produto.Object.dh_validade[ll_linha]
//			ll_Qtde				= lds_Produto.Object.qt_devolver[ll_linha]
//			ls_cd_fornecedor	= lds_Produto.Object.cd_fornecedor[ll_linha]
//			
//			If Not wf_Retira_Reserva(	ll_Agrupamento,&
//												ll_Produto,&
//												ls_Endereco,&
//												ls_Lote,&
//												lb_Resolvido,&
//												Ref ls_Erro, &
//												true) Then
//				lb_Sucesso = False
//				Exit
//			End If		
//			
//			// Apaga Agrupamento do Produto com Protocolo, usando Produto e Lote
//			ist_parametros_protocolo.nr_agrupamento		= ll_Agrupamento
//			ist_parametros_protocolo.cd_produto			= ll_Produto
//			ist_parametros_protocolo.nr_lote         			= ls_lote
//			ist_parametros_protocolo.cd_endereco_wms	= ls_endereco
//			ist_parametros_protocolo.de_situacao_exclusao = 'S'
//			
//			If not ivo_Agrup_Dev_Compra.of_atualiza_agrupamento_protocolo(ist_parametros_protocolo, ls_erro) then
//				lb_Sucesso = False
//				Exit
//			End if			
//			
//			If Not wf_Deleta_Produto (ll_Agrupamento,   &
//								  ll_Produto,       &
//								  ls_Endereco,      &
//								  ls_Lote,          &
//								  ldh_Validade,     &
//								  ll_Qtde,          &
//								  ls_Destino_Final, &
//								  Ref ls_Erro) then
//				lb_Sucesso = False
//				Exit	
//			End if
//			
//			If Not ivo_Agrup_Dev_Compra.of_atualiza_valor_agrupamento (ll_Agrupamento, ls_Destino_Final, Ref ls_Erro) then 
//				lb_Sucesso = False
//				Exit	
//			End if	
//			
//			If Not IsNull(ll_Produto) Then		
//				If Not wf_Movimenta_Produto(	ll_Produto,&
//														ivs_Endereco_Agrupamento,&
//														ls_Endereco,&
//														ls_Lote,&
//														ldh_Validade,&
//														ll_Qtde,&
//														lvs_Responsavel,&
//														"I",&
//														ll_Agrupamento, &
//														Ref ls_Erro) Then		
//					lb_Sucesso = False
//					Exit
//				End If
//			End If
//			
//		Next
		
		If Not lb_Sucesso Then
			SqlCa.of_Rollback()
			MessageBox("Erro",ls_Erro)
			Return 1
		End If
		
		Update agrupamento_dev_compra
		Set	id_situacao = 'X', 
				dh_alteracao_situacao = getdate(), 
				nr_matric_alteracao_situacao =:lvs_Responsavel, 
				de_observacao = de_observacao + '   '+:lvs_Obs
		Where nr_agrupamento =:lvl_Agrupamento
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrtext
			SqlCa.of_Rollback()
			MessageBox("Erro","Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do agrupamento. "+ ls_Erro)
			Return 
		End If
		
//		// Apaga Agrupamento do Produto com o Agrupamento
//	   	setnull(ist_parametros_protocolo.cd_produto)
//		setnull(ist_parametros_protocolo.nr_lote)
//		setnull(ist_parametros_protocolo.cd_endereco_wms)
//		ist_parametros_protocolo.nr_agrupamento = lvl_Agrupamento
//		ist_parametros_protocolo.de_situacao_exclusao = 'S'
//		if not ivo_Agrup_Dev_Compra.of_atualiza_agrupamento_protocolo(ist_parametros_protocolo, ls_erro) then
//			SqlCa.of_Rollback()
//			MessageBox("Erro", ls_Erro)
//			Return	
//		end if	
		
		SqlCa.of_Commit();
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O agrupamento '" + String(lvl_Agrupamento) + "' foi cancelado com sucesso.")
		
		Tab_1.TabPage_1.dw_2.Retrieve()
	Finally
		Destroy(ivo_Movimentacao)
		Destroy(lds_produto)
	End Try
End If

end event

type gb_6 from groupbox within tabpage_1
integer x = 9
integer y = 1668
integer width = 6213
integer height = 352
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Detalhes"
borderstyle borderstyle = styleraised!
end type

type dw_9 from dc_uo_dw_base within tabpage_1
integer x = 41
integer y = 1720
integer width = 6158
integer height = 284
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge252_detalhe_agrupamento"
end type

event doubleclicked;call super::doubleclicked;Long 	ll_Agrupamento,&
		ll_Row

String 	ls_Obs,&
			ls_Erro,&
			ls_Situacao,&
			ls_Observacao

ll_Row 			= Tab_1.TabPage_1.dw_2.GetRow()

If ll_Row < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um agrupamento.")
	Return
End If

ls_Situacao 		= Tab_1.TabPage_1.dw_2.Object.id_situacao[ll_Row]
ls_Observacao	= Tab_1.TabPage_1.dw_9.Object.de_observacao[1]

If ls_Situacao <> "A" and ls_Situacao <> "F" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente agrupamentos abertor e fechados poder$$HEX1$$e300$$ENDHEX$$o ser alterados.")
	Return
End If

Choose Case dwo.Name 
			
	Case 'de_observacao'
		
		ll_Agrupamento = Tab_1.TabPage_1.dw_2.Object.nr_agrupamento[ll_Row]
		
		OpenWithParm(w_ge252_observacao, ls_Observacao)
		
		ls_Obs = Message.StringParm
		
		If ls_Obs = "" Then Return
		
		Update agrupamento_dev_compra
		Set	de_observacao =:ls_Obs
		Where nr_agrupamento =:ll_Agrupamento
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SQLErrText
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da observa$$HEX2$$e700e300$$ENDHEX$$o do agrupamento': "+ ls_Erro)	
			Return 
		End If	
		
		SqlCa.of_Commit()
		
		Tab_1.TabPage_1.dw_2.object.de_observacao[ll_Row] 	= ls_Obs
		Tab_1.TabPage_1.dw_9.object.de_observacao[1] 		= ls_Obs
End Choose
end event

event constructor;call super::constructor;Send( 10, 1200, 0, UnitsToPixels( 1500, xUnitsToPixels! ) )


end event

type cb_fechar from commandbutton within tabpage_1
integer x = 3415
integer y = 2060
integer width = 475
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Fechar"
end type

event clicked;String 	lvs_Responsavel,&
			lvs_Situacao,&
			ls_Erro,&
			ls_Mensagem_Sem_Produtos

Long 	ll_Agrupamento,&
		lvl_Produtos,&
		ll_Find,&
		ll_Linha,&
		ll_Linhas
		

If Tab_1.TabPage_1.dw_2.RowCount() = 0 Then Return

Tab_1.TabPage_1.dw_2.AcceptText()

ll_Linhas = Tab_1.TabPage_1.dw_2.RowCount()

//Verifica se tem algum agrupamento marcado
ll_Find = Tab_1.TabPage_1.dw_2.Find("id_fechar = 'S'", 1, ll_Linhas)

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se tem algum agrupamento marcado.", StopSign!)
	Return
End If

If ll_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o tem nenhum agrupamento marcado para ser fechado.", Information!)
	Return
End If

//Verifica se tem algum agrupamento marcado que a situa$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ diferente de aberto
ll_Find = Tab_1.TabPage_1.dw_2.Find("id_fechar = 'S' and id_situacao <> 'A'", 1, ll_Linhas)

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se tem algum agrupamento com situa$$HEX2$$e700e300$$ENDHEX$$o diferente de aberto marcado.", StopSign!)
	Return
End If

If ll_Find > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O agrupamento "+String(Tab_1.TabPage_1.dw_2.Object.nr_agrupamento[ll_Find])+" n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ com a situa$$HEX2$$e700e300$$ENDHEX$$o ABERTO, n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser fechado..", Information!)
	Return
End If


If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma o fechamento do(s) agrupamento(s) selecionado(s)?", Question!, YesNo!, 2) = 2 Then
	Return
End If

If wf_Responsavel(Ref lvs_Responsavel, "GE252_FECHAR_AGRUPAMENTO_DEV_COMPRA") Then

	SetNull(ls_Mensagem_Sem_Produtos)
	
	For ll_Linha = 1 To ll_Linhas 
		
		If Tab_1.TabPage_1.dw_2.Object.id_fechar[ll_Linha] = "S" Then
			
			ll_Agrupamento = Tab_1.TabPage_1.dw_2.Object.nr_agrupamento[ll_Linha]	
			
			If wf_situacao_agrupamento_fechar(ll_Agrupamento, Ref lvs_Situacao) Then
				If lvs_Situacao <> 'A' Then
					Continue
				End If
			Else
				SqlCa.of_Rollback()
				Return
			End If						
			
			Select count(cd_produto)
			Into :lvl_Produtos
			From agrupamento_dev_compra_prd
			Where nr_agrupamento =:ll_Agrupamento
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = sqlCa.SqlErrText
				MessageBox("Erro", "Localiza$$HEX2$$e700e300$$ENDHEX$$o dos produtos do agrupamento: "+ls_Erro)
				SqlCa.of_Rollback()
				Return
			End If
			
			If lvl_Produtos = 0 Then
				If IsNull(ls_Mensagem_Sem_Produtos) Then
					ls_Mensagem_Sem_Produtos = "N$$HEX1$$e300$$ENDHEX$$o existe produto informado para o(s) agrupamento(s): "+ String(ll_Agrupamento)
				Else
					ls_Mensagem_Sem_Produtos = ls_Mensagem_Sem_Produtos +", "+String(ll_Agrupamento)
				End If
				Continue
			End If
			
					
			Update agrupamento_dev_compra
			Set  id_situacao = 'F', dh_alteracao_situacao = getdate(), nr_matric_alteracao_situacao =:lvs_Responsavel
			Where nr_agrupamento =:ll_Agrupamento
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = sqlCa.SqlErrText
				MessageBox("Erro", "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do agrupamento: "+ls_Erro)
				SqlCa.of_Rollback()
				Return
			End If
		End If	
	Next
	
	SqlCa.of_Commit()
	
	If Not IsNull(ls_Mensagem_Sem_Produtos) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem_Sem_Produtos + ".~rOs demais agrupamentos selecionados foram fechados com sucesso.")
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os agrupamentos selecionados foram fechados com sucesso.")
	End If
	
	Tab_1.TabPage_1.dw_2.Retrieve()
	
End If
end event

type dw_10 from dc_uo_dw_base within tabpage_1
integer x = 1312
integer y = 728
integer width = 370
integer height = 308
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge252_etiqueta_agrupamento"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type st_1 from statictext within tabpage_1
integer x = 18
integer y = 2028
integer width = 6213
integer height = 160
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8421376
long backcolor = 8421376
string text = "0"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_5 from commandbutton within tabpage_1
boolean visible = false
integer x = 5829
integer y = 1808
integer width = 955
integer height = 108
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Buscar Saldo Diverg$$HEX1$$ea00$$ENDHEX$$ncia SAP"
end type

event clicked;Boolean	lb_erro	= false
DateTime	ldt_dh_validade_retirada, ldt_dh_validade_agrupamento
Long		ll_row, ll_nr_agrupamento, ll_for, ll_linhas, ll_qt_devolver_restante, ll_qt_devolver, ll_cd_produto, &
			ll_linhas_saldo_divergencia, ll_for_saldo_divergencia, ll_qt_saldo_retirada, ll_qt_caixa_padrao_retirada, &
			ll_qt_movto, ll_nr_controle, ll_nr_nf_retirada, ll_nr_nf_agrupamento, ll_exists, ll_qt_caixa_padrao_agrupamento
String	ls_nr_lote, ls_cd_endereco_retirada, ls_nr_lote_retirada, ls_erro, ls_cd_fornecedor_retirada, &
			ls_de_serie_retirada, ls_de_especie_retirada, ls_cd_fornecedor_agrupamento, ls_de_especie_agrupamento, &
			ls_de_serie_agrupamento, ls_nr_lote_agrupamento, ls_endereco_divergencia[]

dc_uo_ds_base	lds_ajuste_saldo_agrupamento, lds_lista_saldo_divergencia


for ll_row = 1 to tab_1.tabpage_1.dw_2.RowCount()
	lds_ajuste_saldo_agrupamento	= Create dc_uo_ds_base
	
	If Not lds_ajuste_saldo_agrupamento.of_ChangeDataObject('dw_ge252_ajuste_saldo_agrupamento') Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no of_ChangeDataObject da 'dw_ge252_ajuste_saldo_agrupamento'.", StopSign!)
		Return 1
	End If
	
	lds_lista_saldo_divergencia	= Create dc_uo_ds_base
	
	If Not lds_lista_saldo_divergencia.of_ChangeDataObject('ds_ge258_saldo_divergencia_sap') Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no of_ChangeDataObject da 'ds_ge258_saldo_divergencia_sap'.", StopSign!)
		Return 1
	End If
	
	ll_nr_agrupamento	= tab_1.tabpage_1.dw_2.GetItemNumber(ll_row, 'nr_agrupamento')
	
	if ll_nr_agrupamento <= 0 or IsNull(ll_nr_agrupamento) then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi encontrado o n$$HEX1$$fa00$$ENDHEX$$mero do agrupamento.", StopSign!)
		Return 1
	end if
	
	ll_linhas	= lds_ajuste_saldo_agrupamento.Retrieve(ll_nr_agrupamento)
	
	ls_endereco_divergencia[1] = 'A900060A'
	ls_endereco_divergencia[2] = 'A900090A'
	
	for ll_for = 1 to ll_linhas
		if lb_erro then
			Exit
		end if
		
		ll_cd_produto							= lds_ajuste_saldo_agrupamento.GetItemNumber(ll_for, 'cd_produto')
		ll_qt_devolver							= lds_ajuste_saldo_agrupamento.GetItemNumber(ll_for, 'qt_devolver')
		ll_nr_nf_agrupamento					= lds_ajuste_saldo_agrupamento.GetItemNumber(ll_for, 'qt_devolver')
		ls_cd_fornecedor_agrupamento		= lds_ajuste_saldo_agrupamento.GetItemString(ll_for, 'cd_fornecedor')
		ls_de_especie_agrupamento			= lds_ajuste_saldo_agrupamento.GetItemString(ll_for, 'de_especie')
		ls_de_serie_agrupamento				= lds_ajuste_saldo_agrupamento.GetItemString(ll_for, 'de_serie')
		ls_nr_lote_agrupamento				= lds_ajuste_saldo_agrupamento.GetItemString(ll_for, 'nr_lote')
		ldt_dh_validade_agrupamento		= lds_ajuste_saldo_agrupamento.GetItemDateTime(ll_for, 'dh_validade')
		ll_qt_caixa_padrao_agrupamento	= lds_ajuste_saldo_agrupamento.GetItemNumber(ll_for, 'qt_caixa_padrao')
		
		ll_qt_devolver_restante	= ll_qt_devolver
		
		ll_linhas_saldo_divergencia	= lds_lista_saldo_divergencia.Retrieve(ll_cd_produto, ls_endereco_divergencia)
		
		for ll_for_saldo_divergencia	= 1 to ll_linhas_saldo_divergencia
			ls_cd_endereco_retirada			= lds_lista_saldo_divergencia.GetItemString(ll_for_saldo_divergencia, 'cd_endereco')
			ls_nr_lote_retirada				= lds_lista_saldo_divergencia.GetItemString(ll_for_saldo_divergencia, 'nr_lote')
			ls_cd_fornecedor_retirada		= lds_lista_saldo_divergencia.GetItemString(ll_for_saldo_divergencia, 'cd_fornecedor')
			ls_de_serie_retirada				= lds_lista_saldo_divergencia.GetItemString(ll_for_saldo_divergencia, 'de_serie')
			ls_de_especie_retirada			= lds_lista_saldo_divergencia.GetItemString(ll_for_saldo_divergencia, 'de_especie')
			ldt_dh_validade_retirada		= lds_lista_saldo_divergencia.GetItemDateTime(ll_for_saldo_divergencia, 'dh_validade')
			ll_qt_saldo_retirada				= lds_lista_saldo_divergencia.GetItemNumber(ll_for_saldo_divergencia, 'qt_lote')
			ll_qt_caixa_padrao_retirada	= lds_lista_saldo_divergencia.GetItemNumber(ll_for_saldo_divergencia, 'qt_caixa_padrao')
			ll_nr_controle						= lds_lista_saldo_divergencia.GetItemNumber(ll_for_saldo_divergencia, 'nr_controle')
			ll_nr_nf_retirada					= lds_lista_saldo_divergencia.GetItemNumber(ll_for_saldo_divergencia, 'nr_nf')
			
			//Delete do segregado recebimento
			delete from wms_segregado_recebimento
					where nr_controle = :ll_nr_controle
			Using SqlCa;
			
			if SQLCA.SQLCode = -1 Then
				ls_erro	= 'Problema ao deletar registro da tabela wms_segregado_recebimento. ~r~rErro: ' + SQLCA.SQLErrText
				SQLCA.of_rollback()
				lb_erro	= True
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_erro, StopSign!)
				Exit
			End If
			
			//Caso o saldo estiver negativo, n$$HEX1$$e300$$ENDHEX$$o faz nada
			if ll_qt_saldo_retirada < 0 then
				continue
			end if
			
			select top 1 1
			  into :ll_exists
			  from wms_localizacao wl
			 where wl.cd_endereco		= :ls_cd_endereco_retirada
				and wl.cd_produto			= :ll_cd_produto
				and wl.qt_caixa_padrao	= 1
				and wl.nr_lote				= :ls_nr_lote_retirada
				and wl.dh_validade		= :ldt_dh_validade_retirada;
			
			Choose Case SQLCA.SQLCode
				Case -1
					ls_erro	= SQLCA.SQLErrText
					
					SQLCA.of_rollback()
					
					lb_erro	= True
					
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Problema ao consultar a wms_localizacao. ~r~rErro: ' + ls_erro, StopSign!)
					
					Exit
				Case 100
					Continue
			End Choose
			
			if ll_qt_saldo_retirada > ll_qt_devolver_restante then
				ll_qt_movto					= ll_qt_devolver_restante
				ll_qt_devolver_restante	= 0
			else
				ll_qt_movto	= ll_qt_saldo_retirada
				ll_qt_devolver_restante	= ll_qt_devolver_restante - ll_qt_movto
			end if
			
			//Criar fun$$HEX2$$e700e300$$ENDHEX$$o para transportar de um endere$$HEX1$$e700$$ENDHEX$$o para outro e chamar aqui
			if Not wf_movimenta_saldo_divergente_para_agrup(ll_cd_produto, ls_nr_lote_retirada, ldt_dh_validade_retirada, ll_qt_caixa_padrao_retirada, &
																			ll_qt_movto, ls_cd_endereco_retirada, 'B900500A', ls_cd_fornecedor_agrupamento, &
																			ll_nr_nf_agrupamento, ls_de_especie_agrupamento, ls_de_serie_agrupamento, &
																			ls_nr_lote_agrupamento, ldt_dh_validade_agrupamento, ll_qt_caixa_padrao_agrupamento, &
																			ll_nr_agrupamento, ls_erro) Then
				SQLCA.of_rollback()
				lb_erro	= True
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_erro, StopSign!)
				Exit
			End If
			
			ll_qt_saldo_retirada	= ll_qt_saldo_retirada - ll_qt_movto
			
			if ll_qt_devolver_restante = 0 then
				if ll_qt_saldo_retirada > 0 then
					//Caso sobre quantidade na retirada, insere registro no segregado recebimento novamente com o restante.
					insert into wms_segregado_recebimento(
							  cd_endereco,
							  cd_fornecedor,
							  nr_nf,
							  de_especie,
							  de_serie,
							  cd_produto,
							  nr_lote,
							  dh_validade,
							  qt_lote,
							  dh_inclusao)
					values (:ls_cd_endereco_retirada,
							  :ls_cd_fornecedor_retirada,
							  :ll_nr_nf_retirada,
							  :ls_de_especie_retirada,
							  :ls_de_serie_retirada,
							  :ll_cd_produto,
							  :ls_nr_lote_retirada,
							  :ldt_dh_validade_retirada,
							  :ll_qt_saldo_retirada,
							  GetDate())
					using SqlCa;
						
					If SQLCA.SQLCode = -1 Then
						ls_erro	= SQLCA.SQLErrText
						
						SqlCa.of_Rollback()
						
						lb_erro	= True
						
						MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro no Insert da tabela 'wms_segregado_recebimento'. ~r~rErro: " + ls_erro, StopSign!)
						
						Exit
					End If
				end if
				
				exit
			end if
		next
	next
	
	if lb_erro then
		SQLCA.of_rollback()
	else
		SQLCA.of_commit()
	end if
next
end event

type cb_6 from commandbutton within tabpage_1
boolean visible = false
integer x = 4791
integer y = 1804
integer width = 855
integer height = 112
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Inserir WMS_INT_SAP faltante"
end type

event clicked;Boolean lb_Sucesso = false

String ls_Nulo

SetNull(ls_Nulo)

ivo_Movimentacao = Create uo_ge258_movimentacao
ivo_Movimentacao.ivb_Commit = False
		
if not wf_inserir_wms_int_sap(93281, &
										743726, &
										'W294', &
										9, &
										DateTime('2023-11-01'), &
										'B900140A', &
										1, &
										'053405408', &
										'N', &
										'995670', &
										'B900140A', &
										350908, &
										'NFE', &
										'1',0,0, 0, ls_Nulo, ls_Nulo, 0, 0) then 
	lb_Sucesso = False
else
	lb_Sucesso = True
end if 

if lb_Sucesso then
	SQLCA.of_commit()
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Inserido')
else
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', SQLCA.SQLErrText)
	SQLCA.of_rollback()
end if

destroy ivo_Movimentacao
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 6240
integer height = 2200
long backcolor = 80269524
string text = "Lista de Produtos para Devolu$$HEX2$$e700e300$$ENDHEX$$o"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
st_2 st_2
gb_3 gb_3
dw_3 dw_3
dw_8 dw_8
cb_buscar cb_buscar
st_mensagem st_mensagem
cb_1 cb_1
cb_4 cb_4
cb_alterar_lote cb_alterar_lote
end type

on tabpage_2.create
this.st_2=create st_2
this.gb_3=create gb_3
this.dw_3=create dw_3
this.dw_8=create dw_8
this.cb_buscar=create cb_buscar
this.st_mensagem=create st_mensagem
this.cb_1=create cb_1
this.cb_4=create cb_4
this.cb_alterar_lote=create cb_alterar_lote
this.Control[]={this.st_2,&
this.gb_3,&
this.dw_3,&
this.dw_8,&
this.cb_buscar,&
this.st_mensagem,&
this.cb_1,&
this.cb_4,&
this.cb_alterar_lote}
end on

on tabpage_2.destroy
destroy(this.st_2)
destroy(this.gb_3)
destroy(this.dw_3)
destroy(this.dw_8)
destroy(this.cb_buscar)
destroy(this.st_mensagem)
destroy(this.cb_1)
destroy(this.cb_4)
destroy(this.cb_alterar_lote)
end on

type st_2 from statictext within tabpage_2
integer x = 18
integer y = 2028
integer width = 6002
integer height = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8421376
long backcolor = 8421376
string text = "0"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type gb_3 from groupbox within tabpage_2
integer y = 12
integer width = 6016
integer height = 2000
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Lista de Produtos"
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within tabpage_2
integer x = 5
integer y = 76
integer width = 6007
integer height = 1912
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge252_lista_produto_adicionar"
boolean vscrollbar = true
boolean livescroll = false
end type

event ue_recuperar;// OverRide

Long ll_Agrupamento

Tab_1.TabPage_1.dw_2.AcceptText()

ll_Agrupamento = Tab_1.TabPage_1.dw_2.Object.nr_agrupamento[Tab_1.TabPage_1.dw_2.GetRow()]

Return This.Retrieve(ll_Agrupamento)

end event

event ue_postretrieve;Long lvl_Linha, lvl_qt_devolver


For lvl_Linha = 1 To This.RowCount()
	Tab_1.TabPage_2.dw_3.Object.nm_produto[lvl_Linha] = Tab_1.TabPage_2.dw_3.Object.de_produto[lvl_Linha] + " : " +&
																		 Tab_1.TabPage_2.dw_3.Object.de_apresentacao_estoque[lvl_Linha]
																		 
	lvl_qt_devolver = This.object.qt_devolver[lvl_Linha]
	
	If lvl_qt_devolver = 1 Then
//		This.Object.b_editar.Visible = '1~tIf (qt_devolver='string(lvl_qt_devolver)', 0, 1)'
	End If
Next




// Ap$$HEX1$$f300$$ENDHEX$$s o retrieve a DW j$$HEX1$$e100$$ENDHEX$$ vem modificada, essa fun$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ para n$$HEX1$$e300$$ENDHEX$$o vir modificada
This.ResetUpdate()

Return 1
end event

event ue_key;Long	lvl_Find, &
		lvl_Linha, &
		lvl_Qtde_Produto,&
		ll_Agrupamento,&
		ll_Qtde,&
		ll_Saldo,&
		ll_Nota,&
		ll_Natureza_Operacao,&
		ll_Motivo_Devolucao,&
		ll_Divisao_Fornecedor,&
		ll_Divisao_Fornecedor_Prd
		
String		lvs_Nulo,&
			lvs_Fornecedor,&
			lvs_Id_Distribuidora,&
			lvs_Situacao,&
			lvs_Fornecedor_Usual,&
			ls_Endereco,&
			ls_Lote,&
			ls_Matricula,&
			ls_Grupo_Psico,&
			ls_Tipo,&
			ls_Especie,&
			ls_Serie,&
			ls_Erro,&
			ls_Destino_Final,&
			ls_Subcategoria,&
			ls_Matricula_Comprador,&
			ls_Matricula_Comprador_Prod,&
			ls_Nome_Comprador,&
			ls_Nm_Divisao_Fornecedor_Prd
	  
Decimal 	ldc_Preco_Reposicao,&
			ldc_Desconto_Fornecedor

Integer lvi_Retorno

DateTime ldh_Validade

uo_ge040_args luo_args[]

If key = KeyEnter! Then
	Tab_1.TabPage_1.dw_2.AcceptText()

	lvs_Fornecedor 			= Tab_1.TabPage_1.dw_2.Object.cd_fornecedor				[Tab_1.TabPage_1.dw_2.GetRow()]
	lvs_Id_Distribuidora 	= Tab_1.TabPage_1.dw_2.Object.id_distribuidora				[Tab_1.TabPage_1.dw_2.GetRow()]
	ll_Agrupamento				= Tab_1.TabPage_1.dw_2.Object.nr_agrupamento			[Tab_1.TabPage_1.dw_2.GetRow()]
	ls_Tipo 						= Tab_1.TabPage_1.dw_2.Object.id_tipo						[Tab_1.TabPage_1.dw_2.GetRow()]
	ls_Destino_Final			= Tab_1.TabPage_1.dw_2.Object.id_destino_final				[Tab_1.TabPage_1.dw_2.GetRow()]
	ll_Motivo_Devolucao		= Tab_1.TabPage_1.dw_2.Object.cd_motivo_devolucao		[Tab_1.TabPage_1.dw_2.GetRow()]
	ls_Matricula_Comprador	= Tab_1.TabPage_1.dw_2.Object.nr_matricula_comprador	[Tab_1.TabPage_1.dw_2.GetRow()]
	ll_Divisao_Fornecedor	= Tab_1.TabPage_1.dw_2.Object.nr_divisao_fornecedor	[Tab_1.TabPage_1.dw_2.GetRow()]

	If This.GetColumnName() = "nm_produto" Then
		
		Try
			if ll_Motivo_Devolucao = il_cd_motivo_devolucao_defeito_fabrica then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Devido a necessidade de controle de protocolo, essa tela n$$HEX1$$e300$$ENDHEX$$o permite ainda inserir material com defeito de f$$HEX1$$e100$$ENDHEX$$brica. Favor utilizar a tela WMS > Manuten$$HEX2$$e700e300$$ENDHEX$$o > Segregados > Devolu$$HEX2$$e700e300$$ENDHEX$$o de Loja para inserir materiais neste agrupamento.", StopSign!)
				Return 1
			end if
			
			ivo_Movimentacao = Create uo_ge258_movimentacao
			ivo_Movimentacao.ivb_Commit = False
			
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				
				ls_Subcategoria = Mid(ivo_Produto.cd_subcategoria, 1, 1)
				
				ls_Grupo_Psico = ivo_Produto.cd_grupo_psico
								
				Choose Case ls_Tipo
					Case "1" //Controlado
						If IsNull(ls_Grupo_Psico) Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esse $$HEX1$$e900$$ENDHEX$$ um agrupamento de produtos CONTROLADOS.~rSer$$HEX1$$e100$$ENDHEX$$ permitido apenas produtos controlados.")
							Return 1
						End If
					Case "2" //N$$HEX1$$e300$$ENDHEX$$o caontrolado
						If Not IsNull(ls_Grupo_Psico) Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esse $$HEX1$$e900$$ENDHEX$$ um agrupamento de produtos N$$HEX1$$c300$$ENDHEX$$O CONTROLADOS.~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ permitido produtos controlados.")
							Return 1
						End If
					Case "3" //Todos
						
				End Choose
				
				lvl_Linha = Tab_1.TabPage_2.dw_3.GetRow()
					
				If ivs_Valida_Forn = "S" Then
					If lvs_Fornecedor <> ivo_Produto.Cd_Fornecedor_Usual Then
						ivo_Forn.of_Localiza_Fornecedor(ivo_Produto.Cd_Fornecedor_Usual)
									
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + ivo_Produto.ivs_Descricao_Apresentacao_Estoque + " (" + String(ivo_Produto.cd_produto) + ")'  n$$HEX1$$e300$$ENDHEX$$o pertence ao fornecedor informado no lote.~r~r" + &
													"O fornecedor correto do produto $$HEX1$$e900$$ENDHEX$$ '" + ivo_Forn.nm_razao_social + " (" + ivo_Produto.Cd_Fornecedor_Usual + ")'.", Information!)
						SetNull(lvs_Nulo)
						Tab_1.TabPage_2.dw_3.Object.nm_Produto[lvl_Linha] = lvs_Nulo
						Return 
					End If

					
					If Not wf_comprador_do_produto(	ivo_Produto.cd_produto,&
																Ref ls_Matricula_Comprador_Prod,&
																Ref ls_Nome_Comprador) Then
						Return 
					End If
					
					If ls_Matricula_Comprador <> ls_Matricula_Comprador_Prod Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + ivo_Produto.ivs_Descricao_Apresentacao_Estoque + " (" + String(ivo_Produto.cd_produto) + ")'  n$$HEX1$$e300$$ENDHEX$$o pertence ao comprador informado no agrupamento.~r~r" + &
														"O comprador correto do produto $$HEX1$$e900$$ENDHEX$$ '" + ls_Nome_Comprador + " (" +ls_Matricula_Comprador_Prod + ")'.", Information!)
					
						SetNull(lvs_Nulo)
						Tab_1.TabPage_2.dw_3.Object.nm_Produto[lvl_Linha] = lvs_Nulo
						Return 
					End If
					
					If Not wf_Divisao_Forncedor_Produto(	lvs_Fornecedor,&
																		ivo_Produto.cd_produto,&
																		Ref ll_Divisao_Fornecedor_Prd,&
																		Ref ls_Nm_Divisao_Fornecedor_Prd) Then
						Return
					End If
					
					If Not IsNull(ll_Divisao_Fornecedor_Prd) Then
						If ll_Divisao_Fornecedor <> ll_Divisao_Fornecedor_Prd Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + ivo_Produto.ivs_Descricao_Apresentacao_Estoque + " (" + String(ivo_Produto.cd_produto) + ")'  n$$HEX1$$e300$$ENDHEX$$o pertence $$HEX1$$e000$$ENDHEX$$ divis$$HEX1$$e300$$ENDHEX$$o de fornecedor informada no agrupamento.~r~r" + &
														"A divis$$HEX1$$e300$$ENDHEX$$o correto do produto $$HEX1$$e900$$ENDHEX$$ '" + String(ll_Divisao_Fornecedor_Prd) +" - "+ls_Nm_Divisao_Fornecedor_Prd , Information!)
						End If
					End If
				End If
						
				//Verifica Produto Ativo na Distribuidora
				If lvs_Id_Distribuidora = "S" Then
					
					lvi_Retorno = wf_Verifica_Produto_Distribuidora(ivo_Produto.cd_produto,lvs_Fornecedor)
					
					If  lvi_Retorno = 0 Then
						//n$$HEX1$$e300$$ENDHEX$$o tem
						//incluir mesmo assim
						If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O produto : " + ivo_Produto.ivs_Descricao_Apresentacao_Estoque + " (" + String(ivo_Produto.cd_Produto) + ")" + " n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ relacionado com a distribuidora selecionada. ~r~r" + &
										"Deseja inclu$$HEX1$$ed00$$ENDHEX$$-lo mesmo assim?.",Question!, yesNo!, 2) = 2 Then
							Return -1
						End If
					Else
						If lvi_Retorno = -1 Then
							Return -1
						End If
					End If
							
				End If
				//	
				
				//Pega o endere$$HEX1$$e700$$ENDHEX$$o do produto no segregado
				If Not wf_Tipo_Ajuste(ivo_Produto.cd_produto, Ref ls_Endereco, Ref ls_Lote, Ref ldh_Validade, Ref ll_Saldo) Then
					Return 1
				End If
				
				SetNull (ll_Qtde)
				
				//Tela para informar a quantidade do produto
				If Not wf_Qtde_Produto('I', Ref ll_Qtde) Then
					Return 1
				End If
				
				If ll_Qtde < 1 Then
					MessageBox("Aviso", "A quantidade deve ser maior do que zero.")
					Return 1
				End If
				
				If ll_Qtde > ll_Saldo Then
					MessageBox("Aviso", "A quantidade m$$HEX1$$e100$$ENDHEX$$xima para o produto '"+ ivo_Produto.ivs_Descricao_Apresentacao_Estoque+"' lote '"+ls_Lote+"' $$HEX1$$e900$$ENDHEX$$ "+String(ll_Saldo)+"." )
					Return 1
				End If
				
				//Aqui 
				SetNull(ls_Serie)
				SetNull(ll_Nota)
				If Not	ivo_Agrup_Dev_Compra.of_Insere_Produto_No_Agrupamento(ll_Agrupamento,&
																										lvs_Fornecedor,&
																										ll_Nota,&
																										ls_Serie,&
																										ivo_Produto.cd_produto,&
																										ls_Lote,&
																										ls_Endereco,&
																										ll_Qtde,&
																										ls_Destino_Final,&
																										ldh_Validade,&
																										ll_Motivo_Devolucao,&
																										ls_Subcategoria,&
																										Ref ldc_Preco_Reposicao,&
																										Ref ldc_Desconto_Fornecedor,&
																										Ref luo_args,&
																										Ref ls_erro) Then
					SqlCa.of_Rollback()
					If Trim(ls_erro) <> "" and Not Isnull(ls_erro) Then	
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_erro)
					End if
					Return 1
				Else
					Tab_1.TabPage_2.dw_3.Object.vl_preco						[Tab_1.TabPage_2.dw_3.GetRow()] = ldc_Preco_Reposicao
					Tab_1.TabPage_2.dw_3.Object.pc_desconto_fornecedor[Tab_1.TabPage_2.dw_3.GetRow()] = ldc_Desconto_Fornecedor
					SqlCa.of_Commit()
				End If
				
				Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
				This.Event ue_AddRow()
	
			End If
		Finally
			Destroy(ivo_Movimentacao)
		End Try
	End If
	
	If This.GetColumnName() = "qt_devolver" Then
		If IsNull(This.Object.cd_produto[This.RowCount()]) Then
			This.Event ue_Pos(This.RowCount(), "nm_produto")
		Else
	   	This.Event ue_AddRow()
		End If
	End If
End If
end event

event ue_preinsertrow;call super::ue_preinsertrow;If This.RowCount() > 0 Then
//	If ivs_Situacao <> 'A' Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A inclus$$HEX1$$e300$$ENDHEX$$o de produto so $$HEX1$$e900$$ENDHEX$$ permitida em agrupamento ABERTO.")
//		Return -1
//	Else
		If IsNull(Tab_1.TabPage_2.dw_3.Object.cd_produto[This.RowCount()]) Then Return -1
//	End If
End If

Return 1
end event

event editchanged;call super::editchanged;//If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
//	ivm_Menu.mf_Confirmar(True)
//	ivm_Menu.mf_Cancelar(True)
//End If

end event

event itemchanged;call super::itemchanged;long ll_Tipo

//If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
//	ivm_Menu.mf_Confirmar(True)
//	ivm_Menu.mf_Cancelar(True)
//End If

//If row > 0 Then 
//	ist_parametros_protocolo.nr_agrupamento = Object.nr_agrupamento[row]
//	cb_4.enabled = wf_verifica_protocolo()
//End If 
// 

end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()

end event

event ue_addrow;call super::ue_addrow;// Agrupamento aberto
//If This.RowCount() > 0 and ivs_Situacao = 'A' Then
//	This.ivo_Controle_Menu.of_Excluir(True)
//End If

Return AncestorReturnValue

end event

event constructor;call super::constructor;This.of_SetRowSelection()

This.ShareData(dw_8)
end event

event ue_printimmediate;//OverRide

If wf_Verifica_Pendente() Then
	If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem altera$$HEX2$$e700f500$$ENDHEX$$es que n$$HEX1$$e300$$ENDHEX$$o foram salvas.~r~r" +&
			  	     "Deseja imprimir mesmo assim ?", Question!, YesNo!, 2) = 1 Then
					  
		dw_8.Event ue_PrintImmediate()
	End If
Else
	dw_8.Event ue_PrintImmediate()
End If
end event

event ue_deleterow;//OverRide

Long	ll_Linha, &
		ll_Linhas

This.AcceptText()
ll_Linhas = This.RowCount()

If This.Find ( "id_selecionar = 'S'", 1, ll_Linhas ) < 1 Then
	MessageBox("Aviso", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nenhum item selecionado para ser exclu$$HEX1$$ed00$$ENDHEX$$do.")
	Return False
End If

If  MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja excluir o registro?", Question!, YesNo!, 1) = 2 Then
	Return False
End If

Try
	ivo_Movimentacao = Create uo_ge258_movimentacao 
	ivo_Movimentacao.ivb_Commit = False
	
	For ll_linha = 1 to ll_Linhas
		
		If dw_3.Object.id_selecionar[ll_linha] = "S" Then
			If not wf_processa_exclusao_produto (ll_linha, 'S') then
				Return False
			End if
		End If
	Next

	SqlCa.of_Commit()
	
	This.Event ue_Recuperar()
	This.Event ue_PostRetrieve(0) //Colocado aqui, pois, programaram sem pensar corretamente nas gen$$HEX1$$e900$$ENDHEX$$ricas.
	This.Event ue_AddRow()
Finally
	Destroy(ivo_Movimentacao)
End Try

Return True


end event

event ue_saveas;dw_8.Event ue_SaveAs()
end event

event ue_print;//OverRide

If wf_Verifica_Pendente() Then
	If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem altera$$HEX2$$e700f500$$ENDHEX$$es que n$$HEX1$$e300$$ENDHEX$$o foram salvas.~r~r" +&
			  	     "Deseja imprimir mesmo assim ?", Question!, YesNo!, 2) = 1 Then
					  
		dw_8.Event ue_Print()
	End If
Else
	dw_8.Event ue_Print()
End If
end event

event rowfocuschanged;call super::rowfocuschanged;Long ll_Tipo

If currentrow > 0 Then 
	
	ll_Tipo = This.Object.cd_tipo[currentrow]

	ist_parametros_protocolo.cd_produto = Object.cd_produto[currentrow]
	ist_parametros_protocolo.nr_lote = Object.nr_lote[currentrow]
	ist_parametros_protocolo.nr_agrupamento = Object.nr_agrupamento[currentrow]
	cb_4.enabled = wf_verifica_protocolo()
	
End If 
 

end event

event ue_preupdate;call super::ue_preupdate;//Long ll_Agrupamento,  &
//	  lvl_Linha
//
//Tab_1.TabPage_1.dw_2.AcceptText()
//
//ll_Agrupamento = Tab_1.TabPage_1.dw_2.Object.nr_agrupamento[Tab_1.TabPage_1.dw_2.GetRow()]
//
//If This.RowCount() > 0 Then
//	
//	If IsNull(This.Object.cd_produto[This.RowCount()]) Then
//		This.DeleteRow(This.RowCount())
//	End If
//	
//	For lvl_Linha = 1 To This.RowCount()
//		This.Object.nr_Agrupamento[lvl_Linha] = ll_Agrupamento
//	Next
//	
//	//If This.RowCount() > 0 Then
//		If Not wf_Atualiza_Valor_Agrupamento(ll_Agrupamento) Then
//			Return -1
//		End If
//	//End If
//		
//End If

Return 1
end event

event buttonclicked;call super::buttonclicked;//DECLARA$$HEX2$$c700d500$$ENDHEX$$ES
DateTime							ldh_Validade

Long								ll_qtd_prod,     	&
									ll_qtd_orig,     	&
									ll_qtd_restante, 	&
									ll_Produto,      	&
									ll_Agrupamento, 	&
									ll_cd_motivo_devolucao

String							ls_Endereco, &
									ls_Lote, &
									ls_protocolo,&
									ls_novo_agrupamento,&
									ls_erro

st_parametros_qtd_produto	lstr_qtde

Tab_1.TabPage_1.dw_2.AcceptText()
This.Accepttext( )

ll_Agrupamento 			= Tab_1.TabPage_1.dw_2.Object.nr_agrupamento[Tab_1.TabPage_1.dw_2.GetRow()]
ll_cd_motivo_devolucao	= Tab_1.TabPage_1.dw_2.Object.cd_motivo_devolucao[Tab_1.TabPage_1.dw_2.GetRow()]

ls_Lote 						= This.Object.nr_lote[this.GetRow()]
ll_Produto 					= This.Object.cd_produto[this.GetRow()]

//PROCEDIMENTOS
Choose case dwo.Name
	case 'b_editar'
		ll_qtd_prod = This.Object.qt_devolver [row]
		ll_qtd_orig = ll_qtd_prod
		
		If Not ivo_Agrup_Dev_Compra.of_verificar_novo_agrupamento(ll_Agrupamento ,Ref ls_novo_agrupamento) Then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Error em buscar a informa$$HEX2$$e700e300$$ENDHEX$$o data de agrupamento para condi$$HEX2$$e700e300$$ENDHEX$$o.')
			Return 1
		End if
				
		If ls_novo_agrupamento = 'S' and ll_cd_motivo_devolucao = il_cd_motivo_devolucao_defeito_fabrica Then
			If Not wf_verifica_protocolo_agrupamento(ll_Produto, ls_Lote, ll_Agrupamento, Ref ll_qtd_prod) then 
				return 1
			End If
		Else	
			If not IsNull (ll_qtd_prod) and ll_qtd_prod > 0 then
				If not wf_qtde_produto ('E', Ref ll_qtd_prod) then
					Return 1
				End If
			End if
		End If
		
		If ll_qtd_prod > ll_qtd_orig Then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A quantidade a excluir n$$HEX1$$e300$$ENDHEX$$o pode ser maior que a original!')
			Return 1
		Else
			ivo_Movimentacao            = Create uo_ge258_movimentacao
			ivo_Movimentacao.ivb_Commit = False
			
			Try
				
//				If ll_qtd_prod = ll_qtd_orig
				
				//1. processa exclus$$HEX1$$e300$$ENDHEX$$o do produto (s$$HEX1$$f300$$ENDHEX$$ do banco, sem excluir da DW)
				If not wf_processa_exclusao_produto (row, 'N') then
					Return 1
				End if
				//2. faz a reinclus$$HEX1$$e300$$ENDHEX$$o do produto com os dados da DW, que n$$HEX1$$e300$$ENDHEX$$o foram exclu$$HEX1$$ed00$$ENDHEX$$dos e a quantidade restante
				ll_qtd_restante = ll_qtd_orig - ll_qtd_prod
				
				If not wf_reinsere_produto (row, ll_qtd_restante, ls_novo_agrupamento) then
					Return 1
				End if
				
				SQLCA.of_Commit ()
				
				This.Event ue_Retrieve ()
				This.Event ue_AddRow   ()
			Finally
				Destroy ivo_Movimentacao
			End Try
		End If
End choose
end event

type dw_8 from dc_uo_dw_base within tabpage_2
boolean visible = false
integer x = 187
integer y = 496
integer width = 1586
integer height = 492
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge252_lista_produto_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;If AncestorReturnValue > 0 Then
	dw_8.Object.st_agrupamento.text		 = String(Tab_1.TabPage_1.dw_2.Object.nr_agrupamento          [Tab_1.TabPage_1.dw_2.GetRow()])
	dw_8.Object.st_emissao.text    = STring((Tab_1.TabPage_1.dw_2.Object.dh_inclusao      [Tab_1.TabPage_1.dw_2.GetRow()]), "dd/mm/yyyy")
	dw_8.Object.st_fornecedor.text = Tab_1.TabPage_1.dw_2.Object.nm_razao_social  [Tab_1.TabPage_1.dw_2.GetRow()] + "(" +&
												Tab_1.TabPage_1.dw_2.Object.cd_fornecedor    [Tab_1.TabPage_1.dw_2.GetRow()] + ")"
End If

Return AncestorReturnValue
end event

event ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

type cb_buscar from commandbutton within tabpage_2
integer x = 1298
integer y = 88
integer width = 247
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Buscar"
end type

event clicked;Long ll_Find, ll_Linha, ll_Linhas

ll_Linha = dw_3.getrow()

ll_Linhas = dw_3.rowcount()

If ll_Linha = ll_Linhas Then ll_Linha = 0

If ll_Linhas > 0 Then
	If Not IsNull(sle_localizar.Text) Then
		If IsNumber(sle_localizar.Text) Then
			ll_Find = dw_3.Find("cd_produto = " + string(sle_localizar.Text), ll_Linha+1, ll_Linhas)
			If ll_Find <= 0 Then
				ll_Find = dw_3.Find("cd_produto = " + string(sle_localizar.Text), 1, ll_Linhas)
			End If
		Else
			ll_Find = dw_3.Find("de_produto like '%" + string(sle_localizar.Text) + "%'", ll_Linha+1, ll_Linhas)
			If ll_Find <= 0 Then
				ll_Find = dw_3.Find("de_produto like '%" + string(sle_localizar.Text) + "%'", 1, ll_Linhas)
			End If
		End If
	End If
	
	Dw_3.SetFocus()
	Dw_3.SetRow(ll_Find)
	Dw_3.ScrollToRow(ll_Find)
	
End If



end event

type st_mensagem from statictext within tabpage_2
integer x = 270
integer y = 2064
integer width = 2313
integer height = 96
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 16777215
long backcolor = 8421376
string text = "Somente o agrupamento ABERTO poder$$HEX1$$e100$$ENDHEX$$ ser alterado."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within tabpage_2
integer x = 4896
integer y = 2060
integer width = 471
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Alterar Validade"
end type

event clicked;st_parametros_altera_validade lst_Parametro

Long ll_Row

String ls_Retorno

If ivs_situacao = 'R' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esse agrupamento j$$HEX1$$e100$$ENDHEX$$ foi resolvido. N$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser alterado a validade.")
	Return 1
End If

Tab_1.TabPage_2.dw_3.AcceptText()

ll_Row = Tab_1.TabPage_2.dw_3.getRow()

lst_Parametro.id_agrupamento	= "S"
lst_Parametro.cd_produto		= Tab_1.TabPage_2.dw_3.Object.cd_produto[ll_Row]
lst_Parametro.de_produto		= Tab_1.TabPage_2.dw_3.Object.de_produto[ll_Row]
lst_Parametro.nr_lote				= Tab_1.TabPage_2.dw_3.Object.nr_lote[ll_Row]
lst_Parametro.dh_validade		= Tab_1.TabPage_2.dw_3.Object.dh_validade[ll_Row]
lst_Parametro.nr_agrupamento	= Tab_1.TabPage_2.dw_3.Object.nr_agrupamento[ll_Row]

OpenWithParm(w_ge252_altera_validade, lst_Parametro)
ls_Retorno = Message.StringParm

If ls_Retorno = "S" Then
	Tab_1.TabPage_2.dw_3.Event ue_Retrieve ()
	
	If ivs_situacao = 'A' Then
		Tab_1.TabPage_2.dw_3.Event ue_AddRow()
	End If	
	
	Tab_1.TabPage_2.dw_3.SetRow(ll_Row)
	Tab_1.TabPage_2.dw_3.ScrollToRow(ll_Row)
End If

end event

type cb_4 from commandbutton within tabpage_2
integer x = 5477
integer y = 2056
integer width = 471
integer height = 104
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Lista Protocolo"
end type

event clicked;OpenWithParm(w_ge252_lista_protocolos,ist_parametros_protocolo)
end event

type cb_alterar_lote from commandbutton within tabpage_2
boolean visible = false
integer x = 4384
integer y = 2068
integer width = 402
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Alterar Lote"
end type

event clicked;//Long									ll_Row
//String								ls_Retorno
//st_parametros_altera_validade	lst_Parametro
//
//If ivs_situacao = 'R' then
//	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Esse agrupamento j$$HEX1$$e100$$ENDHEX$$ foi resolvido. O lote n$$HEX1$$e300$$ENDHEX$$o pode ser alterado!')
//	Return 1
//End if
//
//Tab_1.TabPage_2.dw_3.AcceptText ()
//
//ll_Row = Tab_1.TabPage_2.dw_3.getRow ()
//
//lst_Parametro.id_agrupamento	= 'S'
//lst_Parametro.cd_produto		= Tab_1.TabPage_2.dw_3.Object.cd_produto     [ll_Row]
//lst_Parametro.de_produto		= Tab_1.TabPage_2.dw_3.Object.de_produto     [ll_Row]
//lst_Parametro.nr_lote			= Tab_1.TabPage_2.dw_3.Object.nr_lote        [ll_Row]
//lst_Parametro.dh_validade		= Tab_1.TabPage_2.dw_3.Object.dh_validade    [ll_Row]
//lst_Parametro.nr_agrupamento	= Tab_1.TabPage_2.dw_3.Object.nr_agrupamento [ll_Row]
//
//OpenWithParm (w_ge252_altera_lote, lst_Parametro)
//ls_Retorno = Message.StringParm
//
//If ls_Retorno = 'S' then
//	Tab_1.TabPage_2.dw_3.Event ue_Retrieve ()
//	
//	If ivs_situacao = 'A' then
//		Tab_1.TabPage_2.dw_3.Event ue_AddRow ()
//	End if
//	
//	Tab_1.TabPage_2.dw_3.SetRow (ll_Row)
//	Tab_1.TabPage_2.dw_3.ScrollToRow (ll_Row)
//End if
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 6240
integer height = 2200
long backcolor = 80269524
string text = "Lista do Compras"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
cb_alterar_nota cb_alterar_nota
gb_4 gb_4
dw_4 dw_4
dw_6 dw_6
dw_11 dw_11
st_3 st_3
end type

on tabpage_3.create
this.cb_alterar_nota=create cb_alterar_nota
this.gb_4=create gb_4
this.dw_4=create dw_4
this.dw_6=create dw_6
this.dw_11=create dw_11
this.st_3=create st_3
this.Control[]={this.cb_alterar_nota,&
this.gb_4,&
this.dw_4,&
this.dw_6,&
this.dw_11,&
this.st_3}
end on

on tabpage_3.destroy
destroy(this.cb_alterar_nota)
destroy(this.gb_4)
destroy(this.dw_4)
destroy(this.dw_6)
destroy(this.dw_11)
destroy(this.st_3)
end on

type cb_alterar_nota from commandbutton within tabpage_3
boolean visible = false
integer x = 2766
integer y = 2060
integer width = 498
integer height = 100
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Alterar Nota"
end type

event clicked;Long 	ll_Agrupamento,&
		ll_produto,&
		ll_Nota,&
		ll_Natureza_Operacao,&
		ll_Row,&
		ll_Qtde,&
		ll_Linha,&
		ll_Linhas,&
		ll_Nota_Nova,&
		ll_Natureza_Operacao_Nova,&
		ll_Qt_Localizada		
		
String 	ls_Fornecedor,&
			ls_Lote,&
			ls_Especie,&
			ls_Serie,&
			ls_Erro,&
			ls_Parametro,&
			ls_Especie_Nova,&
			ls_Serie_Nova,&
			ls_Lote_Novo,&
			ls_Endereco_Segregado,&
			ls_Destino_Final
			
Decimal	ldc_Preco_Unitario,&
			ldc_Pc_Desconto
					
dc_uo_ds_base lds_NF_Origem 		

ls_Destino_Final = Tab_1.TabPage_1.dw_2.object.id_destino_final[Tab_1.TabPage_1.dw_2.GetRow()]

If ls_Destino_Final <> "N" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esse agrupamento $$HEX1$$e900$$ENDHEX$$ de descarte, n$$HEX1$$e300$$ENDHEX$$o pede ser utilizado essa funcionalidade.")															
	Return 1	
End If
		
If ivs_situacao <> 'A' and ivs_situacao <> 'F' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Poder$$HEX1$$e100$$ENDHEX$$ ser alterado a nota apenas de agrupamentos abertos e fechados.")															
	Return 1	
End If

Try
	
	dw_4.AcceptText()

	ll_Row = dw_4.GetRow()
	
	ll_Agrupamento			= dw_4.object.nr_agrupamento			[ll_Row]
	ll_produto					= dw_4.object.cd_produto					[ll_Row]
	ls_Lote						= dw_4.object.nr_lote						[ll_Row]
	ls_Fornecedor				= dw_4.object.cd_fornecedor				[ll_Row]
	ll_Qtde						= dw_4.object.qt_devolver					[ll_Row]
	ll_Nota						= dw_4.object.nr_nf							[ll_Row]
	ll_Natureza_Operacao	= dw_4.object.cd_natureza_operacao	[ll_Row]
	ls_Especie					= dw_4.object.de_especie					[ll_Row]
	ls_Serie						= dw_4.object.de_serie						[ll_Row]
	ls_Endereco_Segregado	= dw_4.object.cd_endereco_segregado	[ll_Row]
	
	ls_Parametro = ls_Fornecedor+Right("0000000000"+String(ll_Produto), 10)+String(ll_Qtde)
	
	OpenWithParm(w_ge252_notas_compra, ls_Parametro)
	
	lds_NF_Origem = Message.PowerObjectParm
	
	ll_Linhas = lds_NF_Origem.RowCount()
	
	If ll_Linhas > 0 Then
		If Not wf_retira_reserva(ll_Agrupamento,&
										 ll_produto,&
										 ls_Endereco_Segregado,&
										 ls_Lote,&
										 False,&
										 Ref ls_Erro, &
										 False) Then
			SqlCa.of_RollBack()															
			MessageBox("Erro", ls_Erro)															
			Return 1														
		End If
		
		If Not wf_Exclui_Nota_Compra(	ll_Agrupamento,&
												ll_Produto,&
												ls_Endereco_Segregado,&
												ls_Lote,&
												534,&
												ls_Fornecedor,&
												ll_Nota,&
												ls_Especie,&
												ls_Serie,&
												ll_Natureza_Operacao,&
												Ref ls_Erro) Then
			SqlCa.of_RollBack()															
			MessageBox("Erro", ls_Erro)															
			Return 1		
		End If
		
		For ll_Linha = 1 To ll_Linhas
			
			ll_Nota_Nova						= lds_NF_Origem.Object.nr_nf							[ll_Linha]
			ls_Especie_Nova					= lds_NF_Origem.Object.de_especie					[ll_Linha]
			ls_Serie_Nova						= lds_NF_Origem.Object.de_serie						[ll_Linha]
			ll_Natureza_Operacao_Nova		= lds_NF_Origem.Object.cd_natureza_operacao	[ll_Linha]
			ll_Qt_Localizada					= lds_NF_Origem.Object.qt_lote						[ll_Linha]
			ldc_Preco_Unitario				= lds_NF_Origem.Object.vl_preco_unitario			[ll_Linha]
			ldc_Pc_Desconto					= lds_NF_Origem.Object.pc_desconto				[ll_Linha]
			ls_Lote_Novo						= lds_NF_Origem.Object.nr_lote						[ll_Linha]
			
			If Not ivo_Agrup_Dev_Compra.of_Insere_Agrupamento_Dev_Compra_Prd_Nf(	ll_Agrupamento,&
																												ll_Produto,&																	
																												ls_Endereco_Segregado,&
																												ls_Lote,&
																												534,&
																												ls_Fornecedor,&
																												ll_Nota_Nova,&
																												ls_Especie_Nova,&
																												ls_Serie_Nova,&
																												ll_Natureza_Operacao_Nova,&
																												ll_Qt_Localizada,&
																												ldc_Preco_Unitario,&
																												ldc_Pc_Desconto,&
																												ls_Lote_Novo,&
																												Ref ls_Erro) Then
				SqlCa.of_RollBack()															
				MessageBox("Erro", ls_Erro)															
				Return 1																	
			End If																	
			
			If Not ivo_Agrup_Dev_Compra.of_Atualiza_Reserva_Item_Nf_Compra_Lote(534,&
																											ls_Fornecedor,&
																											ll_Nota_Nova,&
																											ls_Especie_Nova,&
																											ls_Serie_Nova,&
																											ll_Natureza_Operacao_Nova,&
																											ll_Produto,&
																											ls_Lote_Novo,&
																											ll_Qt_Localizada,&
																											Ref ls_erro) Then
				SqlCa.of_RollBack()															
				MessageBox("Erro", ls_Erro)															
				Return 1																	
			End If
			
		Next
		
		If Not ivo_Agrup_Dev_Compra.of_atualiza_valor_agrupamento(ll_Agrupamento, "N", Ref ls_Erro) Then 
			SqlCa.of_RollBack()															
			MessageBox("Erro", ls_Erro)															
			Return 1
		End If
		
		SqlCa.of_Commit()

		dw_4.Event ue_Recuperar()
		
	End If

Finally
	Destroy(lds_NF_Origem)	
End Try

Return 1




end event

type gb_4 from groupbox within tabpage_3
integer x = 9
integer y = 12
integer width = 6011
integer height = 2004
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Lista de Produtos"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within tabpage_3
integer x = 27
integer y = 64
integer width = 5989
integer height = 1936
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge252_lista_nota_compras"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;// OverRide

long ll_Agrupamento
long ll_return

Tab_1.TabPage_1.dw_2.AcceptText()

ll_Agrupamento = Tab_1.TabPage_1.dw_2.Object.nr_agrupamento[Tab_1.TabPage_1.dw_2.GetRow()]

dw_15.retrieve(ll_Agrupamento)

ll_return = Retrieve(ll_Agrupamento)

wf_ajusta_lista_compras()

Return ll_return


end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event constructor;call super::constructor;This.of_SetRowSelection()

This.ShareData(dw_6)
end event

event ue_printimmediate;//OverRide

String ls_Destino_Final

ls_Destino_Final = Tab_1.TabPage_1.dw_2.object.id_destino_final[Tab_1.TabPage_1.dw_2.GetRow()]
		
If ls_Destino_Final = "N"  Then //Nota de devolu$$HEX2$$e700e300$$ENDHEX$$o
		
	This.ShareData(dw_11)
	dw_11.Event ue_PrintImmediate()
	
Else

	This.ShareData(dw_6)
	dw_6.Event  ue_PrintImmediate()
	
End If
end event

event ue_postretrieve;Boolean lvb_Imprimir

If pl_Linhas > 0 Then
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
	lvb_Imprimir = True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	lvb_Imprimir = False
End If

This.of_SetRowSelection()

This.ivo_Controle_Menu.of_Imprimir(lvb_Imprimir)

Return pl_Linhas
end event

event ue_print;//OverRide
String ls_Destino_Final

ls_Destino_Final = Tab_1.TabPage_1.dw_2.object.id_destino_final[Tab_1.TabPage_1.dw_2.GetRow()]

If ls_Destino_Final = "N"  Then //Nota de devolu$$HEX2$$e700e300$$ENDHEX$$o
	This.ShareData(dw_11)
	dw_11.Event ue_Print()
Else
	This.ShareData(dw_6)
	dw_6.Event  ue_Print()
End If
end event

event ue_saveas;//OverRide

String ls_Destino_Final

ls_Destino_Final = Tab_1.TabPage_1.dw_2.object.id_destino_final[Tab_1.TabPage_1.dw_2.GetRow()]
		
If ls_Destino_Final = "N"  Then //Nota de devolu$$HEX2$$e700e300$$ENDHEX$$o
		
	This.ShareData(dw_11)
	dw_11.Event ue_SaveAs()
	
Else

	This.ShareData(dw_6)
	dw_6.Event  ue_SaveAs()
	
End If
end event

type dw_6 from dc_uo_dw_base within tabpage_3
boolean visible = false
integer x = 91
integer y = 596
integer width = 1243
integer height = 780
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge252_lista_notas_compra_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;If AncestorReturnValue > 0 Then
	dw_6.Object.st_agrupamento.text		 = String(Tab_1.TabPage_1.dw_2.Object.nr_agrupamento          [Tab_1.TabPage_1.dw_2.GetRow()])
	dw_6.Object.st_emissao.text    = STring((Tab_1.TabPage_1.dw_2.Object.dh_inclusao      [Tab_1.TabPage_1.dw_2.GetRow()]), "dd/mm/yyyy")
	dw_6.Object.st_fornecedor.text = Tab_1.TabPage_1.dw_2.Object.nm_razao_social  [Tab_1.TabPage_1.dw_2.GetRow()] + "(" +&
												Tab_1.TabPage_1.dw_2.Object.cd_fornecedor    [Tab_1.TabPage_1.dw_2.GetRow()] + ")"
End If

Return AncestorReturnValue
end event

event ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

type dw_11 from dc_uo_dw_base within tabpage_3
boolean visible = false
integer x = 1440
integer y = 600
integer width = 1125
integer height = 752
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge252_lista_nota_compras_emite_nota_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;If AncestorReturnValue > 0 Then
	dw_11.Object.st_agrupamento.text		 = String(Tab_1.TabPage_1.dw_2.Object.nr_agrupamento          [Tab_1.TabPage_1.dw_2.GetRow()])
	dw_11.Object.st_emissao.text    = STring((Tab_1.TabPage_1.dw_2.Object.dh_inclusao      [Tab_1.TabPage_1.dw_2.GetRow()]), "dd/mm/yyyy")
	dw_11.Object.st_fornecedor.text = Tab_1.TabPage_1.dw_2.Object.nm_razao_social  [Tab_1.TabPage_1.dw_2.GetRow()] + "(" +&
												Tab_1.TabPage_1.dw_2.Object.cd_fornecedor    [Tab_1.TabPage_1.dw_2.GetRow()] + ")"
End If

Return AncestorReturnValue
end event

event ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

type st_3 from statictext within tabpage_3
integer x = 14
integer y = 2028
integer width = 6002
integer height = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8421376
long backcolor = 8421376
string text = "0"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 6240
integer height = 2200
long backcolor = 80269524
string text = "Lista do Fiscal"
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_5 gb_5
dw_5 dw_5
dw_7 dw_7
end type

on tabpage_4.create
this.gb_5=create gb_5
this.dw_5=create dw_5
this.dw_7=create dw_7
this.Control[]={this.gb_5,&
this.dw_5,&
this.dw_7}
end on

on tabpage_4.destroy
destroy(this.gb_5)
destroy(this.dw_5)
destroy(this.dw_7)
end on

type gb_5 from groupbox within tabpage_4
integer x = 9
integer y = 12
integer width = 6030
integer height = 2176
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Produtos"
borderstyle borderstyle = styleraised!
end type

type dw_5 from dc_uo_dw_base within tabpage_4
integer x = 37
integer y = 76
integer width = 5979
integer height = 2088
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge252_lista_nota_fiscal"
boolean vscrollbar = true
end type

event ue_recuperar;// OverRide

Long ll_Agrupamento

String lvs_Fornecedor

DateTime lvdt_Devolucao

Tab_1.TabPage_1.dw_1.AcceptText()
Tab_1.TabPage_1.dw_2.AcceptText()

ll_Agrupamento = Tab_1.TabPage_1.dw_2.Object.nr_agrupamento      [Tab_1.TabPage_1.dw_2.GetRow()]
lvs_Fornecedor = Tab_1.TabPage_1.dw_2.Object.cd_fornecedor[Tab_1.TabPage_1.dw_2.GetRow()]
lvdt_Devolucao = Tab_1.TabPage_1.dw_1.Object.dt_devolucao [1]

Return This.Retrieve(ll_Agrupamento, lvs_Fornecedor, lvdt_Devolucao)

end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event constructor;call super::constructor;This.ShareData(dw_7)

String lvs_Coluna[], &
       lvs_Nome[]

lvs_Coluna = {"item_nf_compra_cd_produto", "de_produto"}

lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo", "Descri$$HEX2$$e700e300$$ENDHEX$$o"}

This.of_SetSort(lvs_Coluna, lvs_Nome)

This.of_SetFilter(lvs_Coluna, lvs_Nome)


end event

event ue_printimmediate;//OverRide

dw_7.Event ue_PrintImmediate()


end event

event ue_postretrieve;Boolean lvb_Habilitar

If pl_Linhas > 0 Then
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
	lvb_Habilitar = True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	lvb_Habilitar = False
End If

This.ivo_Controle_Menu.of_Imprimir   (lvb_Habilitar)
This.ivo_Controle_Menu.of_Classificar(lvb_Habilitar)
This.ivo_Controle_Menu.of_Filtrar    (lvb_Habilitar)

Return pl_Linhas
end event

event ue_print;//override
dw_7.Event ue_Print()
end event

event ue_saveas;//override
dw_7.Event ue_SaveAs()
end event

type dw_7 from dc_uo_dw_base within tabpage_4
boolean visible = false
integer x = 82
integer y = 580
integer width = 3209
integer height = 852
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge252_lista_notas_fiscal_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;If AncestorReturnValue > 0 Then
	dw_7.Object.st_agrupamento.text		 = String(Tab_1.TabPage_1.dw_2.Object.nr_agrupamento   [Tab_1.TabPage_1.dw_2.GetRow()])
	dw_7.Object.st_emissao.text    = STring((Tab_1.TabPage_1.dw_2.Object.dh_inclusao      [Tab_1.TabPage_1.dw_2.GetRow()]), "dd/mm/yyyy")
	dw_7.Object.st_fornecedor.text = Tab_1.TabPage_1.dw_2.Object.nm_razao_social  [Tab_1.TabPage_1.dw_2.GetRow()] + "(" +&
												Tab_1.TabPage_1.dw_2.Object.cd_fornecedor    [Tab_1.TabPage_1.dw_2.GetRow()] + ")"
End If

Return AncestorReturnValue
end event

event ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 6240
integer height = 2200
long backcolor = 80269524
string text = "Notas de Entrada"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_13 dw_13
gb_7 gb_7
end type

on tabpage_5.create
this.dw_13=create dw_13
this.gb_7=create gb_7
this.Control[]={this.dw_13,&
this.gb_7}
end on

on tabpage_5.destroy
destroy(this.dw_13)
destroy(this.gb_7)
end on

type dw_13 from dc_uo_dw_base within tabpage_5
integer x = 37
integer y = 76
integer width = 5952
integer height = 2088
integer taborder = 20
string dataobject = "dw_ge252_lista_notas_agrupamento"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_postretrieve;call super::ue_postretrieve;Boolean lvb_Habilitar

If pl_Linhas > 0 Then
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
	lvb_Habilitar = True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	lvb_Habilitar = False
End If

This.ivo_Controle_Menu.of_Imprimir   (lvb_Habilitar)
This.ivo_Controle_Menu.of_Classificar(lvb_Habilitar)
This.ivo_Controle_Menu.of_Filtrar    (lvb_Habilitar)

Return pl_Linhas
end event

event ue_print;//override
dw_13.Event ue_Print()
end event

event ue_printimmediate;//OverRide

dw_13.Event ue_PrintImmediate()
end event

event ue_recuperar;// OverRide

Long ll_Agrupamento

String lvs_Fornecedor

DateTime lvdt_Devolucao

Tab_1.TabPage_1.dw_1.AcceptText()
Tab_1.TabPage_1.dw_2.AcceptText()

ll_Agrupamento = Tab_1.TabPage_1.dw_2.Object.nr_agrupamento      [Tab_1.TabPage_1.dw_2.GetRow()]
lvs_Fornecedor = Tab_1.TabPage_1.dw_2.Object.cd_fornecedor[Tab_1.TabPage_1.dw_2.GetRow()]
lvdt_Devolucao = Tab_1.TabPage_1.dw_1.Object.dt_devolucao [1]

Return This.Retrieve(ll_Agrupamento)
end event

event ue_saveas;//override
dw_13.Event ue_SaveAs()
end event

type gb_7 from groupbox within tabpage_5
integer y = 12
integer width = 6030
integer height = 2180
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Notas"
borderstyle borderstyle = styleraised!
end type

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 6240
integer height = 2200
long backcolor = 80269524
string text = "Notas Devolu$$HEX2$$e700e300$$ENDHEX$$o/Descarte"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_14 dw_14
gb_8 gb_8
end type

on tabpage_6.create
this.dw_14=create dw_14
this.gb_8=create gb_8
this.Control[]={this.dw_14,&
this.gb_8}
end on

on tabpage_6.destroy
destroy(this.dw_14)
destroy(this.gb_8)
end on

type dw_14 from dc_uo_dw_base within tabpage_6
integer x = 46
integer y = 84
integer width = 5961
integer height = 2080
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge252_lista_notas_agr_aux"
boolean vscrollbar = true
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event editchanged;call super::editchanged;//If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
//	ivm_Menu.mf_Confirmar(True)
//	ivm_Menu.mf_Cancelar(True)
//End If
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event itemchanged;call super::itemchanged;//If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
//	ivm_Menu.mf_Confirmar(True)
//	ivm_Menu.mf_Cancelar(True)
//End If
end event

event ue_addrow;call super::ue_addrow;// Agrupamento aberto
//If This.RowCount() > 0 and ivs_Situacao = 'A' Then
//	This.ivo_Controle_Menu.of_Excluir(True)
//End If

Return AncestorReturnValue
end event

event ue_key;call super::ue_key;Long	lvl_Find, &
		lvl_Linha, &
		lvl_Qtde_Produto,&
		ll_Agrupamento,&
		ll_Qtde,&
		ll_Saldo,&
		ll_Nota,&
		ll_Natureza_Operacao,&
		ll_Motivo_Devolucao,&
		ll_Divisao_Fornecedor,&
		ll_Divisao_Fornecedor_Prd
		
String		lvs_Nulo,&
			lvs_Fornecedor,&
			lvs_Id_Distribuidora,&
			lvs_Situacao,&
			lvs_Fornecedor_Usual,&
			ls_Endereco,&
			ls_Lote,&
			ls_Matricula,&
			ls_Grupo_Psico,&
			ls_Tipo,&
			ls_Especie,&
			ls_Serie,&
			ls_Erro,&
			ls_Destino_Final,&
			ls_Subcategoria,&
			ls_Matricula_Comprador,&
			ls_Matricula_Comprador_Prod,&
			ls_Nome_Comprador,&
			ls_Nm_Divisao_Fornecedor_Prd
	  
Decimal 	ldc_Preco_Reposicao,&
			ldc_Desconto_Fornecedor

Integer lvi_Retorno

DateTime ldh_Validade
		 
uo_ge040_args luo_args[] 


If key = KeyEnter! Then
	Tab_1.TabPage_1.dw_2.AcceptText()

	lvs_Fornecedor 			= Tab_1.TabPage_1.dw_2.Object.cd_fornecedor				[Tab_1.TabPage_1.dw_2.GetRow()]
	lvs_Id_Distribuidora 		= Tab_1.TabPage_1.dw_2.Object.id_distribuidora				[Tab_1.TabPage_1.dw_2.GetRow()]
	ll_Agrupamento			= Tab_1.TabPage_1.dw_2.Object.nr_agrupamento			[Tab_1.TabPage_1.dw_2.GetRow()]
	ls_Tipo 						= Tab_1.TabPage_1.dw_2.Object.id_tipo						[Tab_1.TabPage_1.dw_2.GetRow()]
	ls_Destino_Final			= Tab_1.TabPage_1.dw_2.Object.id_destino_final				[Tab_1.TabPage_1.dw_2.GetRow()]
	ll_Motivo_Devolucao		= Tab_1.TabPage_1.dw_2.Object.cd_motivo_devolucao		[Tab_1.TabPage_1.dw_2.GetRow()]
	ls_Matricula_Comprador	= Tab_1.TabPage_1.dw_2.Object.nr_matricula_comprador	[Tab_1.TabPage_1.dw_2.GetRow()]
	ll_Divisao_Fornecedor		= Tab_1.TabPage_1.dw_2.Object.nr_divisao_fornecedor	[Tab_1.TabPage_1.dw_2.GetRow()]

	If This.GetColumnName() = "nm_produto" Then
		
		Try
			ivo_Movimentacao = Create uo_ge258_movimentacao
			ivo_Movimentacao.ivb_Commit = False
			
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				
				ls_Subcategoria = Mid(ivo_Produto.cd_subcategoria, 1, 1)
				
				ls_Grupo_Psico = ivo_Produto.cd_grupo_psico
								
				Choose Case ls_Tipo
					Case "1" //Controlado
						If IsNull(ls_Grupo_Psico) Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esse $$HEX1$$e900$$ENDHEX$$ um agrupamento de produtos CONTROLADOS.~rSer$$HEX1$$e100$$ENDHEX$$ permitido apenas produtos controlados.")
							Return 1
						End If
					Case "2" //N$$HEX1$$e300$$ENDHEX$$o caontrolado
						If Not IsNull(ls_Grupo_Psico) Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esse $$HEX1$$e900$$ENDHEX$$ um agrupamento de produtos N$$HEX1$$c300$$ENDHEX$$O CONTROLADOS.~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ permitido produtos controlados.")
							Return 1
						End If
					Case "3" //Todos
						
				End Choose
				
				lvl_Linha = Tab_1.TabPage_2.dw_3.GetRow()
					
				If ivs_Valida_Forn = "S" Then
					If lvs_Fornecedor <> ivo_Produto.Cd_Fornecedor_Usual Then
						ivo_Forn.of_Localiza_Fornecedor(ivo_Produto.Cd_Fornecedor_Usual)
									
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + ivo_Produto.ivs_Descricao_Apresentacao_Estoque + " (" + String(ivo_Produto.cd_produto) + ")'  n$$HEX1$$e300$$ENDHEX$$o pertence ao fornecedor informado no lote.~r~r" + &
													"O fornecedor correto do produto $$HEX1$$e900$$ENDHEX$$ '" + ivo_Forn.nm_razao_social + " (" + ivo_Produto.Cd_Fornecedor_Usual + ")'.", Information!)
						SetNull(lvs_Nulo)
						Tab_1.TabPage_2.dw_3.Object.nm_Produto[lvl_Linha] = lvs_Nulo
						Return 
					End If

					
					If Not wf_comprador_do_produto(	ivo_Produto.cd_produto,&
																Ref ls_Matricula_Comprador_Prod,&
																Ref ls_Nome_Comprador) Then
						Return 
					End If
					
					If ls_Matricula_Comprador <> ls_Matricula_Comprador_Prod Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + ivo_Produto.ivs_Descricao_Apresentacao_Estoque + " (" + String(ivo_Produto.cd_produto) + ")'  n$$HEX1$$e300$$ENDHEX$$o pertence ao comprador informado no agrupamento.~r~r" + &
														"O comprador correto do produto $$HEX1$$e900$$ENDHEX$$ '" + ls_Nome_Comprador + " (" +ls_Matricula_Comprador_Prod + ")'.", Information!)
					
						SetNull(lvs_Nulo)
						Tab_1.TabPage_2.dw_3.Object.nm_Produto[lvl_Linha] = lvs_Nulo
						Return 
					End If
					
					If Not wf_Divisao_Forncedor_Produto(	lvs_Fornecedor,&
																		ivo_Produto.cd_produto,&
																		Ref ll_Divisao_Fornecedor_Prd,&
																		Ref ls_Nm_Divisao_Fornecedor_Prd) Then
						Return
					End If
					
					If Not IsNull(ll_Divisao_Fornecedor_Prd) Then
						If ll_Divisao_Fornecedor <> ll_Divisao_Fornecedor_Prd Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + ivo_Produto.ivs_Descricao_Apresentacao_Estoque + " (" + String(ivo_Produto.cd_produto) + ")'  n$$HEX1$$e300$$ENDHEX$$o pertence $$HEX1$$e000$$ENDHEX$$ divis$$HEX1$$e300$$ENDHEX$$o de fornecedor informada no agrupamento.~r~r" + &
														"A divis$$HEX1$$e300$$ENDHEX$$o correto do produto $$HEX1$$e900$$ENDHEX$$ '" + String(ll_Divisao_Fornecedor_Prd) +" - "+ls_Nm_Divisao_Fornecedor_Prd , Information!)
						End If
					End If
				End If
						
				//Verifica Produto Ativo na Distribuidora
				If lvs_Id_Distribuidora = "S" Then
					
					lvi_Retorno = wf_Verifica_Produto_Distribuidora(ivo_Produto.cd_produto,lvs_Fornecedor)
					
					If  lvi_Retorno = 0 Then
						//n$$HEX1$$e300$$ENDHEX$$o tem
						//incluir mesmo assim
						If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O produto : " + ivo_Produto.ivs_Descricao_Apresentacao_Estoque + " (" + String(ivo_Produto.cd_Produto) + ")" + " n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ relacionado com a distribuidora selecionada. ~r~r" + &
										"Deseja inclu$$HEX1$$ed00$$ENDHEX$$-lo mesmo assim?.",Question!, yesNo!, 2) = 2 Then
							Return -1
						End If
					Else
						If lvi_Retorno = -1 Then
							Return -1
						End If
					End If
							
				End If
				//	
				
				//Pega o endere$$HEX1$$e700$$ENDHEX$$o do produto no segregado
				If Not wf_Tipo_Ajuste(ivo_Produto.cd_produto, Ref ls_Endereco, Ref ls_Lote, Ref ldh_Validade, Ref ll_Saldo) Then
					Return 1
				End If
				
				SetNull (ll_Qtde)
				
				//Tela para informar a quantidade do produto
				If Not wf_Qtde_Produto('I', Ref ll_Qtde) Then
					Return 1
				End If
				
				If ll_Qtde < 1 Then
					MessageBox("Aviso", "A quantidade deve ser maior do que zero.")
					Return 1
				End If
				
				If ll_Qtde > ll_Saldo Then
					MessageBox("Aviso", "A quantidade m$$HEX1$$e100$$ENDHEX$$xima para o produto '"+ ivo_Produto.ivs_Descricao_Apresentacao_Estoque+"' lote '"+ls_Lote+"' $$HEX1$$e900$$ENDHEX$$ "+String(ll_Saldo)+"." )
					Return 1
				End If
				
				//Aqui 
				SetNull(ls_Serie)
				SetNull(ll_Nota)
				If Not	ivo_Agrup_Dev_Compra.of_Insere_Produto_No_Agrupamento(ll_Agrupamento,&
																										lvs_Fornecedor,&
																										ll_Nota,&
																										ls_Serie,&
																										ivo_Produto.cd_produto,&
																										ls_Lote,&
																										ls_Endereco,&
																										ll_Qtde,&
																										ls_Destino_Final,&
																										ldh_Validade,&
																										ll_Motivo_Devolucao,&
																										ls_Subcategoria,&
																										Ref ldc_Preco_Reposicao,&
																										Ref ldc_Desconto_Fornecedor,&
																										Ref luo_args,&
																										Ref ls_erro) Then
					SqlCa.of_Rollback()
					If Trim(ls_erro) <> "" and Not Isnull(ls_erro) Then	
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_erro)
					End if
					Return 1
				Else
					Tab_1.TabPage_2.dw_3.Object.vl_preco						[Tab_1.TabPage_2.dw_3.GetRow()] = ldc_Preco_Reposicao
					Tab_1.TabPage_2.dw_3.Object.pc_desconto_fornecedor[Tab_1.TabPage_2.dw_3.GetRow()] = ldc_Desconto_Fornecedor
					SqlCa.of_Commit()
				End If
				
				Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
				This.Event ue_AddRow()
	
			End If
		Finally
			Destroy(ivo_Movimentacao)
		End Try
	End If
	
	If This.GetColumnName() = "qt_devolver" Then
		If IsNull(This.Object.cd_produto[This.RowCount()]) Then
			This.Event ue_Pos(This.RowCount(), "nm_produto")
		Else
	   	This.Event ue_AddRow()
		End If
	End If
End If
end event

event ue_preinsertrow;call super::ue_preinsertrow;If This.RowCount() > 0 Then
//	If ivs_Situacao <> 'A' Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A inclus$$HEX1$$e300$$ENDHEX$$o de produto so $$HEX1$$e900$$ENDHEX$$ permitida em agrupamento ABERTO.")
//		Return -1
//	Else
		If IsNull(Tab_1.TabPage_2.dw_3.Object.cd_produto[This.RowCount()]) Then Return -1
//	End If
End If

Return 1
end event

event ue_preupdate;call super::ue_preupdate;//Long ll_Agrupamento,  &
//	  lvl_Linha
//
//Tab_1.TabPage_1.dw_2.AcceptText()
//
//ll_Agrupamento = Tab_1.TabPage_1.dw_2.Object.nr_agrupamento[Tab_1.TabPage_1.dw_2.GetRow()]
//
//If This.RowCount() > 0 Then
//	
//	If IsNull(This.Object.cd_produto[This.RowCount()]) Then
//		This.DeleteRow(This.RowCount())
//	End If
//	
//	For lvl_Linha = 1 To This.RowCount()
//		This.Object.nr_Agrupamento[lvl_Linha] = ll_Agrupamento
//	Next
//	
//	//If This.RowCount() > 0 Then
//		If Not wf_Atualiza_Valor_Agrupamento(ll_Agrupamento) Then
//			Return -1
//		End If
//	//End If
//		
//End If

Return 1
end event

event ue_recuperar;// OverRide

Long ll_Agrupamento

Tab_1.TabPage_1.dw_2.AcceptText()

ll_Agrupamento = Tab_1.TabPage_1.dw_2.Object.nr_agrupamento[Tab_1.TabPage_1.dw_2.GetRow()]

Return This.Retrieve(ll_Agrupamento)
end event

type gb_8 from groupbox within tabpage_6
integer x = 5
integer y = 20
integer width = 6030
integer height = 2172
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Notas de Devolu$$HEX2$$e700e300$$ENDHEX$$o/Descarte"
borderstyle borderstyle = styleraised!
end type

type dw_15 from datawindow within w_ge252_agrupamento_devolucao_compra
boolean visible = false
integer x = 5984
integer y = 876
integer width = 713
integer height = 632
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "ds_ge252_ajusta_lista_compras"
boolean border = false
boolean livescroll = true
end type

type sle_localizar from singlelineedit within w_ge252_agrupamento_devolucao_compra
boolean visible = false
integer x = 347
integer y = 196
integer width = 965
integer height = 64
integer taborder = 40
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
textcase textcase = upper!
boolean hideselection = false
end type

