HA$PBExportHeader$uo_tratamento_fiscal.sru
forward
global type uo_tratamento_fiscal from nonvisualobject
end type
end forward

global type uo_tratamento_fiscal from nonvisualobject
end type
global uo_tratamento_fiscal uo_tratamento_fiscal

type variables
Boolean ib_Decreto_Temp_PR = False

// Defini$$HEX2$$e700e300$$ENDHEX$$o das opera$$HEX2$$e700f500$$ENDHEX$$es poss$$HEX1$$ed00$$ENDHEX$$veis
Constant String 	COMPRA				= "CO", &
						VENDA					= "VE", &
						TRANSFERENCIA		= "TR", &
						DEVOLUCAO_COMPRA	= "DC", &
						DEVOLUCAO_VENDA	= "DV"

uo_Atributo_Fiscal_NF			ivo_Atributo_NF	//Inf. Itens
uo_Atributo_Fiscal_Item_NF		ivo_Atributo		//Inf. Cabe$$HEX1$$e700$$ENDHEX$$alho

uo_Aliquota_ICMS ivo_Aliquota[]

uo_Unidade_Federacao	ivo_UF_Origem, &
							ivo_UF_Destino

boolean ivb_erro, ivb_base_pmc 

long ivl_filial, ivl_filial_matriz, ivl_filial_destino, il_Produto

long ivi_tributacao_produto

decimal ivdc_preco_venda_maximo

Date idt_Movimento

string ivs_transferencia_vencido, ivs_utiliza_nova_regra_transf, ivs_devolucao_transferencia_cd, ivs_calculo_st_aux_transferencia, ivs_mensagem, ivs_resgate_clube

string ivs_filial_farmacia_popular, ivs_ICMS_Normal, is_calculo_venda_simulacao_compra, is_produto_almoxarifado
Boolean ivb_Log_Calculo = False
String ivs_Log_Calculo = ""

Protected:
String ivs_Operacao, &
          ivs_Estadual, &
          ivs_Contribuinte, &
          ivs_Tipo_Venda, &
			 ivs_fornecedor_uso_consumo = 'N'
			 
Date ivdt_Inicio_Reduz_ICMS_Base_PIS_Credito
Date ivdt_Inicio_Reduz_ICMS_Base_PIS_Debito

decimal{4} 	ivdc_base_pmc_st, &
            ivdc_base_deducao_st

Long ivl_Decimais = 2

Boolean ivb_Matriz
					 
Private:
	uo_Tributacao_ICMS				ivo_Tributacao
	uo_tipo_produto_fiscal			ivo_tipo_produto_fiscal //GE348
	uo_classificacao_tributaria	ivo_classif_tribut		//GE021
	Long ivl_CFOP_Fixa
end variables

forward prototypes
public subroutine of_grava_operacao (string ps_operacao)
public subroutine of_grava_contribuinte (boolean pb_Contribuinte)
public subroutine of_acumula_aliquotas (decimal pdc_aliquota, decimal pdc_total_produto)
public subroutine of_grava_uf_origem_destino (string ps_uf_origem, string ps_uf_destino)
public function decimal of_aliquota_icms_produto (uo_produto po_produto, uo_tributacao_icms po_tributacao)
public subroutine of_inicializa ()
public subroutine of_calcula_icms (decimal pdc_desconto_nf)
public subroutine of_grava_tipo_venda (string ps_tipo_venda)
public function decimal of_aliquota_icms_produto (uo_produto po_produto)
public function boolean of_existe_natureza_operacao (long al_natureza)
public function boolean of_inclui_natureza_operacao (long al_natureza)
public subroutine of_carrega_parametros ()
public function boolean of_natope_compra (string as_fornecedor, string as_situacao_tributaria, ref long al_natope)
public function decimal of_aliquota_tipo_icms (integer ai_tipo)
public function decimal of_aliquota_icms_produto (uo_produto po_produto, uo_tributacao_icms po_tributacao, long al_tipo_icms)
public function decimal of_pmc (uo_produto ao_produto)
public function decimal of_indice_repasse_icms (decimal adc_icms_compra, decimal adc_icms_venda)
public function uo_atributo_fiscal_item_nf of_atributo_fiscal_produto (uo_produto po_produto)
public function boolean of_localiza_tributacao_produto (uo_produto ao_produto, ref string as_tributacao_icms)
public function boolean of_reducao_base_st_cesta_basica (uo_produto ao_produto, ref decimal adc_reducao)
public function boolean of_redutor_custo_produto (string as_uf_origem, string as_uf_destino, long al_produto, ref decimal adc_redutor)
public subroutine of_aliquota_icms_origem_produto (uo_produto po_produto, ref string as_considera_pc_uf_interestadual, ref decimal adc_aliquota_icms_interestadual)
public function uo_atributo_fiscal_item_nf of_atributo_fiscal_produto (string ps_situacao_tributaria)
public function boolean of_envia_email (string as_mensagem)
public function boolean of_base_st_farmacia_popular (long al_produto, ref decimal adc_preco_base_st)
public function decimal of_reducao_base_st (string as_grupo, string as_uf, string as_lei_generico, string as_lista)
public function boolean of_localiza_tributacao_filial_destino (long al_produto, string as_uf_destino, ref string as_tributacao)
public subroutine of_grava_precisao (long pl_casas_decimais)
public function integer of_reducao_ultima_compra (string as_fornecedor, long al_produto)
public function boolean of_aliquota_icms_venda (long al_produto, string as_uf, ref decimal adc_icms, ref decimal adc_fcp)
public function boolean of_aliquota_icms_difa (ref decimal adc_aliquota_origem, ref decimal adc_aliquota_destino)
public function decimal of_fator_mva (long ai_tributacao_produto, decimal adc_icms)
public function string of_cfop_tributavel_pis_cofins (long pl_cfop, boolean pb_exibe_msg, string ps_mensagem)
public function boolean of_retorna_pis_cofins_produto (long pl_produto, string ps_entrada_saida, string ps_tributavel, ref string ps_pis, ref string ps_cst_pis, ref decimal pdc_aliq_pis, ref string ps_cofins, ref string ps_cst_cofins, ref decimal pdc_aliq_cofins, ref string ps_lista, boolean pb_exibe_msg, ref string ps_msg)
public function boolean of_natope (boolean ab_icms_st, ref long al_natureza)
public function boolean of_natope_almoxarifado (ref long al_natureza)
public function decimal of_fator_pmc (string as_lista_pis_cofins, string as_lei_generico, integer ai_tributacao_produto, decimal adc_aliq_icms_operacao, long al_ncm, decimal adc_red_base_st)
public function decimal of_fator_pmc (boolean ab_estadual, decimal adc_aliq_icms_destino, decimal adc_aliq_icms_operacao, string as_lista_pis_cofins, string as_lei_generico, long al_ncm, integer adc_red_base_st)
public function decimal of_fator_pmc (string as_lista_pis_cofins, string as_lei_generico, decimal adc_aliq_icms_operacao, long al_ncm, decimal adc_red_base_st)
public function decimal of_fator_pmc (boolean ab_estadual, decimal adc_aliq_icms_destino, decimal adc_aliq_icms_operacao, string as_lista_pis_cofins, string as_lei_generico, integer ai_tributacao_produto, long al_ncm, decimal adc_red_base_st, ref boolean ab_ajusta_mva)
public function boolean of_tributacao_produto (integer ai_tributacao_produto, decimal adc_aliq_icms_operacao, ref decimal adc_estadual, ref decimal adc_interestadual, ref boolean ab_ajusta_mva)
public function decimal of_fator_pmc (boolean ab_matriz, long al_produto, string as_uf_origem, string as_uf_destino, decimal adc_aliq_icms_operacao)
public function decimal of_ajusta_mva (decimal pdc_mva, decimal pdc_aliq_icms_interestadual, decimal pdc_aliq_icms_interna)
public function decimal of_ajusta_mva (integer pl_produto, string ps_uf_destino, integer pdc_mva)
public function boolean of_base_matriz ()
public function string of_retorna_cst_pis_cofins (long pl_cfop, long pl_produto)
private function string of_localiza_tributacao_produto (long pl_produto, string ps_uf)
public function decimal of_fator_reducao_base_st (long pi_tributacao_produto)
public function boolean of_calcula_antecipacao_icms (string ps_uf_origem, string ps_uf_destino, long pl_produto, string ps_situacao_tributaria, long pl_quantidade, decimal pdc_valor_produto, decimal pdc_aliq_icms_nf, decimal pdc_valor_icms_nf, ref decimal pdc_base_antecipacao, ref decimal pdc_mva_antecipacao, ref decimal pdc_aliquota_antecipacao, ref decimal pdc_valor_antecipacao)
public function boolean of_calcula_antecipacao_icms (string ps_uf_origem, string ps_uf_destino, long pl_produto, long pl_quantidade, decimal pdc_valor_produto, decimal pdc_aliq_icms_nf, decimal pdc_valor_icms_nf, ref decimal pdc_base_antecipacao, ref decimal pdc_mva_antecipacao, ref decimal pdc_aliquota_antecipacao, ref decimal pdc_valor_antecipacao)
public function boolean of_set_atributo_fiscal_produto (string ps_situacao_tributaria, decimal pdc_pc_icms, long pl_cfop)
private function boolean of_tributacao_fornecedor (string ps_fornecedor, ref boolean pb_fabricante, ref boolean pb_simples_nacional, ref boolean pb_regime_especial)
public function boolean of_verifica_repasse_icms (long pl_ncm)
public function boolean of_permite_desconto_prestes (long al_filial, long al_produto, boolean ab_mostra_msg, ref long al_tipo_produto_fiscal, ref string as_tipo_operacao)
public function boolean of_permite_retirada_perini (string as_tipo_retirada, long al_filial, long al_produto, boolean ab_mostra_msg, ref long al_tipo_produto_fiscal, ref string as_tipo_operacao)
public function boolean of_aliquota_icms_ncm (long pl_ncm, string ps_uf, ref decimal pdc_aliq_icms, ref decimal pdc_aliq_fcp)
public function boolean of_calcula_difa (long pl_ncm, string ps_uf_origem, string ps_uf_destino, string ps_origem_produto, decimal pdc_valor_operacao, decimal pdc_aliq_icms_nf, decimal pdc_valor_icms_nf, ref decimal pdc_base_difa, ref decimal pdc_aliq_difa, ref decimal pdc_valor_difa)
public function boolean of_calcula_icms_efetivo (long pl_produto, string ps_cst_tributacao, long pl_tipo_icms, long pl_quantidade, decimal pdc_vl_unitario_praticado, ref decimal pdc_pc_red_bc_icms_efetivo, ref decimal pdc_bc_icms_efetivo, ref decimal pdc_pc_icms_efetivo, ref decimal pdc_vl_icms_efetivo)
public function decimal of_base_st (uo_produto ao_produto, decimal adc_preco_liquido, decimal adc_red_base_st, string as_lista_pis_cofins, decimal adc_aliquota_icms, decimal adc_ip)
public function decimal of_base_st (uo_produto ao_produto, decimal adc_preco_liquido, decimal adc_red_base_st, string as_lista_pis_cofins, decimal adc_aliquota_icms, decimal adc_ipi, boolean ab_nao_ajusta_mva)
public subroutine of_calcula_icms_st (uo_produto po_produto, long al_qtde, decimal adc_aliquota_icms, boolean lvb_forn_simples)
public function decimal of_aliquota_icms_produto (uo_produto ao_produto, string as_uf_origem, string as_uf_destino)
public function string of_tributacao_icms_operacao (uo_produto ao_produto, string as_tributacao_icms)
public function string of_tributacao_icms_operacao (uo_produto ao_produto)
public subroutine of_grava_icms_produto (uo_produto ao_produto, long al_qtde, decimal adc_preco_bruto, decimal adc_desconto, string as_tributacao_icms, decimal adc_aliquota_icms, decimal adc_aliquota_ipi, boolean ab_repasse_icms, string as_lista_pis_cofins, string as_fornecedor, decimal adc_desconto_nf)
public subroutine of_grava_icms_produto (uo_produto ao_produto, long al_qtde, decimal adc_preco_bruto, decimal adc_desconto, string as_tributacao_icms, decimal adc_aliquota_icms)
public subroutine of_grava_icms_produto (long al_produto, long al_qtde, decimal adc_preco_bruto, decimal adc_desconto, string as_tributacao_icms, decimal adc_aliquota_icms, decimal adc_desconto_nf)
public subroutine of_grava_icms_produto (long al_produto, long al_qtde, decimal adc_preco_bruto, decimal adc_desconto, string as_tributacao_icms, decimal adc_aliquota_icms)
public function boolean of_retorna_mensagem_fiscal (string as_uf_emitente, long al_cfop, string as_st_origem, string as_cst, long al_produto, string as_codigo_beneficio, ref uo_atributo_fiscal_nf ao_atributo_fiscal)
public function string of_retorna_mensagem_fiscal (string as_uf_emitente, long al_cfop, string as_st_origem, string as_cst, long al_produto)
public function string of_retorna_codigo_beneficio (string as_uf_emitente_nf, long al_cfop, string as_cst, long al_produto)
public function string of_retorna_codigo_beneficio (string as_uf_emitente_nf, long al_cfop, string as_st_origem, string as_cst, long al_produto)
public subroutine of_grava_natureza_operacao (long pl_cfop)
public function boolean of_retorna_custo_desfazimento (long al_filial_origem, long al_filial_destino, long al_produto, long al_tipo_produto_fiscal, date adt_data, decimal adc_custo_original, long al_qtd_nota_origem, decimal adc_aliq_icms_operacao, ref decimal adc_custo_sem_imposto)
public function boolean of_retorna_utiliza_cbenef (readonly string ps_uf, readonly string ps_cst)
public function boolean of_localiza_dados_adicionais_uf (long al_filial_origem, string as_uf_destino, ref string as_dados_adicionais)
public function decimal of_reducao_base_icms (long pl_produto, string ps_cd_uf)
public function boolean of_permite_retirada_perini (string as_tipo_retirada, long al_filial, long al_produto, boolean ab_mostra_msg, string as_id_possui_acordo, ref long al_tipo_produto_fiscal, ref string as_tipo_operacao)
public function decimal of_indice_repasse_icms (uo_produto ao_produto, decimal adc_icms)
public function decimal of_repasse_icms (uo_produto ao_produto, decimal adc_preco, decimal adc_icms)
public function decimal of_indice_repasse_icms (uo_produto ao_produto)
public function decimal of_repasse_icms (uo_produto ao_produto, decimal adc_preco)
public function decimal of_pmpf (uo_produto ao_produto)
public subroutine of_log_calculo (string ps_log)
private function boolean of_calcula_difa_venda (uo_produto ao_produto, long al_qtde)
public function boolean of_retorna_tributacao_pis_cofins (long pl_cfop, long pl_produto, decimal pdc_vl_total_item, decimal pdc_vl_total_icms_item, ref string ps_cst_pis, ref decimal pdc_bc_pis, ref decimal pdc_aliq_pis, ref decimal pdc_pis, ref string ps_cst_cofins, ref decimal pdc_bc_cofins, ref decimal pdc_aliq_cofins, ref decimal pdc_cofins, boolean pb_exibe_msg, ref string ps_mensagem)
public function boolean of_retorna_tributacao_pis_cofins (long pl_cfop, long pl_produto, decimal pdc_vl_total_item, decimal pdc_vl_total_icms_item, ref string ps_cst_pis, ref decimal pdc_bc_pis, ref decimal pdc_aliq_pis, ref decimal pdc_pis, ref string ps_cst_cofins, ref decimal pdc_bc_cofins, ref decimal pdc_aliq_cofins, ref decimal pdc_cofins)
public function boolean of_set_fornecedor_uso_consumo (string as_id_uso_consumo)
public function boolean of_retorna_classificacao_cbs_ibs (string ps_uf_destino, long pl_cfop, long pl_produto, ref string ps_id_classe_cbs_ibs)
public function boolean of_aliquota_cbs_ibs (string ps_uf_destino, long pl_cidade_destino, ref decimal pdc_aliq_federal, ref decimal pdc_aliq_estadual, ref decimal pdc_aliq_municipal)
public function boolean of_calcula_cbs_ibs (string as_uf_destino, long al_cidade_destino, string as_id_tributacao_cbs_ibs, decimal adc_qt_item, decimal adc_vl_total_operacao, decimal adc_vl_frete, decimal adc_vl_outras, decimal adc_vl_seguro)
public function boolean of_calcula_cbs_ibs (string as_uf_destino, long al_cidade_destino, string as_id_tributacao_cbs_ibs, decimal adc_qt_item, decimal adc_vl_total_operacao, decimal adc_vl_frete, decimal adc_vl_outras, decimal adc_vl_seguro, decimal adc_vl_icms, decimal adc_vl_pis, decimal adc_vl_cofins)
end prototypes

public subroutine of_grava_operacao (string ps_operacao);Choose Case ps_Operacao
	Case COMPRA, TRANSFERENCIA, DEVOLUCAO_COMPRA, DEVOLUCAO_VENDA, VENDA
		ivs_Operacao = ps_Operacao
	Case Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Opera$$HEX2$$e700e300$$ENDHEX$$o " + ps_Operacao + " n$$HEX1$$e300$$ENDHEX$$o prevista.", StopSign!, Ok!)
End Choose
end subroutine

public subroutine of_grava_contribuinte (boolean pb_Contribuinte);If pb_Contribuinte Then
	ivs_Contribuinte = "S"
Else
	ivs_Contribuinte = "N"
End If
end subroutine

public subroutine of_acumula_aliquotas (decimal pdc_aliquota, decimal pdc_total_produto);Boolean lvb_Existe_Aliquota = False

Integer lvi_Contador, &
        lvi_Numero_Aliquotas
		  
Decimal lvdc_Valor_ICMS 
		  
// Verifica o n$$HEX1$$fa00$$ENDHEX$$mero de al$$HEX1$$ed00$$ENDHEX$$quotas existentes
lvi_Numero_Aliquotas = UpperBound(ivo_Aliquota)

If lvi_Numero_Aliquotas > 0 Then
	For lvi_Contador = 1 To lvi_Numero_Aliquotas
		// Se encontrar a al$$HEX1$$ed00$$ENDHEX$$quota, sumariza a base de c$$HEX1$$e100$$ENDHEX$$lculo
		If ivo_Aliquota[lvi_Contador].ivdc_Aliquota = pdc_Aliquota Then
			ivo_Aliquota[lvi_Contador].ivdc_Base_Calculo += pdc_Total_Produto		
			lvb_Existe_Aliquota = True
			Exit			
		End If	
	Next
	
	// Se a al$$HEX1$$ed00$$ENDHEX$$quota n$$HEX1$$e300$$ENDHEX$$o for encontrada
	If Not lvb_Existe_Aliquota Then
		ivo_Aliquota[lvi_Numero_Aliquotas + 1] = Create uo_Aliquota_ICMS		
		ivo_Aliquota[lvi_Numero_Aliquotas + 1].ivdc_Aliquota     = pdc_Aliquota
		ivo_Aliquota[lvi_Numero_Aliquotas + 1].ivdc_Base_Calculo = pdc_Total_Produto
	End If
Else
	// Se for a primeira al$$HEX1$$ed00$$ENDHEX$$quota
	ivo_Aliquota[1] = Create uo_Aliquota_ICMS	
	ivo_Aliquota[1].ivdc_Aliquota     = pdc_Aliquota
	ivo_Aliquota[1].ivdc_Base_Calculo = pdc_Total_Produto
End If
end subroutine

public subroutine of_grava_uf_origem_destino (string ps_uf_origem, string ps_uf_destino);If Not IsValid(ivo_UF_Origem) Then ivo_UF_Origem = Create uo_Unidade_Federacao
If Not IsValid(ivo_UF_Destino) Then ivo_UF_Destino = Create uo_Unidade_Federacao

If ps_uf_origem <> ivo_UF_Origem.cd_unidade_federacao Then ivo_UF_Origem.of_Localiza_UF(ps_uf_origem)
If ps_uf_destino <> ivo_UF_Destino.cd_unidade_federacao Then ivo_UF_Destino.of_Localiza_UF(ps_uf_destino)

This.ivs_Estadual = IIF(ps_UF_Origem=ps_UF_Destino,'S','N')
end subroutine

public function decimal of_aliquota_icms_produto (uo_produto po_produto, uo_tributacao_icms po_tributacao);Return This.of_Aliquota_ICMS_Produto(po_Produto, po_Tributacao, 0)
end function

public subroutine of_inicializa ();Long lvl_Cont

uo_Aliquota_ICMS lvo_Nulo[]

ivo_Aliquota = lvo_Nulo

// Reinicializa o objeto de manuten$$HEX2$$e700e300$$ENDHEX$$o dos atributos da NF
Destroy(ivo_Atributo_NF)
ivo_Atributo_NF = Create uo_Atributo_Fiscal_NF

// Vari$$HEX1$$e100$$ENDHEX$$veis utilizadas para o c$$HEX1$$e100$$ENDHEX$$lculo da subst. tribut$$HEX1$$e100$$ENDHEX$$ria
This.ivdc_Base_PMC_ST     			= 0
This.ivdc_Base_Deducao_ST 		= 0

//Libera Al$$HEX1$$ed00$$ENDHEX$$quotas
For lvl_Cont = 1 To UpperBound(ivo_Aliquota)
	Destroy(ivo_Aliquota[lvl_Cont])
Next

//SetNull(ivl_filial)
//SetNull(ivl_filial_matriz)
end subroutine

public subroutine of_calcula_icms (decimal pdc_desconto_nf);Integer lvi_Contador, &
        lvi_Numero_Aliquotas
		  
Decimal lvdc_Base, &
        lvdc_Valor
		  
// Verifica o n$$HEX1$$fa00$$ENDHEX$$mero de al$$HEX1$$ed00$$ENDHEX$$quotas existentes
lvi_Numero_Aliquotas = UpperBound(ivo_Aliquota)

For lvi_Contador = 1 To lvi_Numero_Aliquotas	
	If ivo_Aliquota[lvi_Contador].ivdc_Aliquota > 0 Then		
		// Aplica o desconto da nota fiscal na base de c$$HEX1$$e100$$ENDHEX$$lculo do icms
		lvdc_Base  = Round(ivo_Aliquota[lvi_Contador].ivdc_Base_Calculo * ((100 - pdc_Desconto_NF) / 100), 2)

		// Calcula o valor do icms
		lvdc_Valor = Round(lvdc_Base * (ivo_Aliquota[lvi_Contador].ivdc_Aliquota / 100), 2)
		
		ivo_Atributo_NF.Vl_BC_ICMS += lvdc_Base
		ivo_Atributo_NF.Vl_ICMS    += lvdc_Valor		
	End If	
Next

// Este c$$HEX1$$e100$$ENDHEX$$lculo agora $$HEX1$$e900$$ENDHEX$$ feito por produto
// of_Calcula_ICMS_ST(pdc_Desconto_NF)
end subroutine

public subroutine of_grava_tipo_venda (string ps_tipo_venda);ivs_Tipo_Venda = ps_Tipo_Venda
end subroutine

public function decimal of_aliquota_icms_produto (uo_produto po_produto);Decimal lvdc_Aliquota_ICMS

String lvs_Tributacao_ICMS

uo_Tributacao_ICMS  lvo_Tributacao
lvo_Tributacao = Create uo_Tributacao_ICMS

// Verifica qual a situa$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria do produto
lvs_Tributacao_ICMS = This.of_Tributacao_ICMS_Operacao(po_Produto)

If lvo_Tributacao.of_Localiza_Tributacao(lvs_Tributacao_ICMS) Then	
	
	ivs_ICMS_Normal = lvo_Tributacao.id_icms_normal
	
	// Verifica qual a al$$HEX1$$ed00$$ENDHEX$$quota de icms do produto
	lvdc_Aliquota_ICMS = This.of_Aliquota_ICMS_Produto(po_Produto, lvo_Tributacao)

End If
	
Destroy(lvo_Tributacao)

Return lvdc_Aliquota_ICMS
end function

public function boolean of_existe_natureza_operacao (long al_natureza);Long lvl_Natureza

Select cd_natureza_operacao Into :lvl_Natureza
From natureza_operacao
Where cd_natureza_operacao = :al_Natureza
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
	Case 100
		Return False
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Natureza de Opera$$HEX2$$e700e300$$ENDHEX$$o")
		Return True
End Choose
end function

public function boolean of_inclui_natureza_operacao (long al_natureza);Insert Into natureza_operacao (cd_natureza_operacao,
                               de_natureza_operacao,
										 id_diversa)
Values (:al_Natureza,
        'NATUREZA CADASTRADA PELO SISTEMA',
		  'N')
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o da Natureza de Opera$$HEX2$$e700e300$$ENDHEX$$o")
	Return False
Else
	Return True
End If
end function

public subroutine of_carrega_parametros ();String lvs_Valor

Select cd_filial, cd_filial_matriz, dh_movimentacao
Into :ivl_Filial, :ivl_Filial_Matriz, :idt_Movimento
From parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ivb_Matriz = (ivl_Filial = ivl_Filial_Matriz)
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O c$$HEX1$$f300$$ENDHEX$$digo da filial e da matriz do par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o localizada para tratamento fiscal.", StopSign!)
		ivb_Erro = True
	Case -1
		SqlCa.of_MsgdbError("O c$$HEX1$$f300$$ENDHEX$$digo da filial e da matriz do Par$$HEX1$$e200$$ENDHEX$$metro para Tratamento Fiscal")
		ivb_Erro = True
End Choose

//Busca o par$$HEX1$$e200$$ENDHEX$$metro de inicio da redu$$HEX2$$e700e300$$ENDHEX$$o do ICMS na base do PIS/COFINS Entrada
If This.Of_Base_Matriz() Then
	Select coalesce(vl_parametro,'01/12/2023')
	Into :lvs_Valor
	From parametro_loja pl
	Where cd_parametro = 'DT_INICIO_REDUZ_ICMS_BASE_PIS_CRED'
		and pl.cd_filial = (select p1.cd_filial 
								From parametro p1
								Where p1.id_parametro='1')
	Using SQLCa;
Else 
	Select coalesce(vl_parametro,'01/12/2023')
	Into :lvs_Valor
	From parametro_loja pl
	Where cd_parametro = 'DT_INICIO_REDUZ_ICMS_BASE_PIS_CRED'
	Using SQLCa;
End If

If SQLCa.SQLCode <> 0 or gf_coalesce(lvs_Valor,'')='' Then
	lvs_Valor = '01/12/2023'
End If

ivdt_Inicio_Reduz_ICMS_Base_PIS_Credito = Date(lvs_Valor)

//Busca o par$$HEX1$$e200$$ENDHEX$$metro de inicio da redu$$HEX2$$e700e300$$ENDHEX$$o do ICMS na base do PIS/COFINS Sa$$HEX1$$ed00$$ENDHEX$$da
If This.Of_Base_Matriz() Then
	Select coalesce(vl_parametro, '31/12/2099')
	Into :lvs_Valor
	From parametro_loja pl
	Where cd_parametro = 'DT_INICIO_REDUZ_ICMS_BASE_PIS_DEB'
		and pl.cd_filial = (select p1.cd_filial 
								From parametro p1
								Where p1.id_parametro='1')
	Using SQLCa;
Else 
	Select coalesce(vl_parametro, '31/12/2099')
	Into :lvs_Valor
	From parametro_loja pl
	Where cd_parametro = 'DT_INICIO_REDUZ_ICMS_BASE_PIS_DEB'
	Using SQLCa;
End If

If SQLCa.SQLCode <> 0 or gf_coalesce(lvs_Valor,'')='' Then
	lvs_Valor = '31/12/2099'
End If

ivdt_Inicio_Reduz_ICMS_Base_PIS_Debito = Date(lvs_Valor)
end subroutine

public function boolean of_natope_compra (string as_fornecedor, string as_situacao_tributaria, ref long al_natope);Boolean lvb_Sucesso = False, &
        lvb_ICMS_ST

If ivo_Tributacao.of_Localiza_Tributacao(RightA(as_Situacao_Tributaria, 1)) Then
	
	If ivo_Tributacao.Id_ICMS_ST = "S" Then
		lvb_ICMS_ST = True
	Else
		lvb_ICMS_ST = False
	End If
	
	If RightA(as_Situacao_Tributaria, 1) = "6" Then
		lvb_ICMS_ST = True
	End If
	
	lvb_Sucesso = This.of_NatOpe(lvb_ICMS_ST, ref al_NatOpe)
End If

Return lvb_Sucesso
end function

public function decimal of_aliquota_tipo_icms (integer ai_tipo);Decimal lvdc_ICMS, ldc_FCP , ldc_ICMS_CD


If IsNull(ai_Tipo) Then Return 0.00

Select pc_icms, coalesce(pc_fcp, 0), pc_icms_cd
Into :lvdc_ICMS, :ldc_FCP, :ldc_ICMS_CD
From tipo_icms
Where cd_tipo_icms = :ai_Tipo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de ICMS '" + String(ai_Tipo) + "' n$$HEX1$$e300$$ENDHEX$$o localizado.")
		lvdc_ICMS 	= 0
		Return -100
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Tipo de ICMS '" + String(ai_Tipo) + "'")
		lvdc_ICMS 	= 0
		Return -100
End Choose

// Chamado 636875
// Notas emitidas pelo CD ou emitidas pela loja destinadas ao CD
If (ivl_filial=ivl_filial_matriz) or (ivl_Filial_Destino = ivl_filial_matriz)  Then
	If (This.ivs_Operacao = TRANSFERENCIA) and (Ivo_Uf_Destino.cd_unidade_federacao = 'SC') and (ivi_tributacao_produto = 0) and (ivs_Estadual = 'S') Then
		If IsNull(ldc_ICMS_CD) or (ldc_ICMS_CD = 0) Then ldc_ICMS_CD = lvdc_ICMS
			Return ldc_ICMS_CD
		End If
End If

// Chamado: 126514
// Data: 18/02/2016
// Resp: S$$HEX1$$e900$$ENDHEX$$rgio
// Somar na al$$HEX1$$ed00$$ENDHEX$$quota estadual o percentual referente ao fundo de combate a pobreza
If (This.ivs_Operacao = VENDA or This.ivs_Operacao = DEVOLUCAO_VENDA)  and ivs_Estadual = 'S' Then
	lvdc_ICMS = lvdc_ICMS + ldc_FCP
End If

Return lvdc_ICMS
end function

public function decimal of_aliquota_icms_produto (uo_produto po_produto, uo_tributacao_icms po_tributacao, long al_tipo_icms);Decimal	lvdc_Aliquota_Estadual, &
        		lvdc_Aliquota,&
		  	lvdc_Aliquota_InterEstadual_Importados
		  
Long lvl_Tipo_ICMS

String ls_Utiliza_Aliquota_InterEstadual

If IsNull(al_Tipo_ICMS) or al_Tipo_ICMS = 0 Then
	lvl_Tipo_ICMS = po_Produto.Cd_Tipo_ICMS
Else
	lvl_Tipo_ICMS = al_Tipo_ICMS
End If

//Em transferencias estaduais com diferimento, verifica se o diferimento $$HEX1$$e900$$ENDHEX$$ total, caso n$$HEX1$$e300$$ENDHEX$$o seja ele possui ICMS Normal
If po_tributacao.cd_cst_tributacao = "51" and ivs_Estadual = "S" and ivs_Operacao = TRANSFERENCIA Then
	If gf_coalesce(ivo_uf_origem.pc_icms_diferido, 100) < 100 Then
		po_Tributacao.Id_ICMS_Normal = "S"
	End If
End If

ivs_ICMS_Normal = po_Tributacao.Id_ICMS_Normal

If po_Tributacao.Id_ICMS_Normal = "S" Then	
	
	If IsNull(lvl_Tipo_ICMS) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de ICMS n$$HEX1$$e300$$ENDHEX$$o definido para o produto '" + String(po_Produto.Cd_Produto) + "'.~r~r" + &
		                      "Por favor informe o pessoal de suporte ao sistema.", StopSign!)
									 
		lvdc_Aliquota_Estadual = 0
	Else
		lvdc_Aliquota_Estadual = This.of_Aliquota_Tipo_ICMS(lvl_Tipo_ICMS)		
	End If
	
	If ivs_Estadual = "S" Then
		lvdc_Aliquota = lvdc_Aliquota_Estadual
	Else
				
		Choose Case ivs_Operacao
//			Case VENDA
//				
//				If ivs_Contribuinte = "S" Then
//					lvdc_Aliquota = ivo_UF_Origem.Pc_ICMS_Interestadual
//				Else
//					lvdc_Aliquota = lvdc_Aliquota_Estadual
//				End If
				
			// Data: 01/11/2012
			// Controle colocado por causa do faturamento do MS
			// Data: 21/12/2015
			// Sergio
			// Foi inclu$$HEX1$$ed00$$ENDHEX$$do a opera$$HEX2$$e700e300$$ENDHEX$$o de VENDA juntamente com transfer$$HEX1$$ea00$$ENDHEX$$ncia para considerar a aliquota dos importados
			Case TRANSFERENCIA, COMPRA, VENDA, DEVOLUCAO_VENDA
				
				// Qualquer problema no select da fun$$HEX2$$e700e300$$ENDHEX$$o o sistema vai considerar o a aliquota padr$$HEX1$$e300$$ENDHEX$$o
				This.of_Aliquota_ICMS_Origem_Produto(po_Produto, ref ls_Utiliza_Aliquota_InterEstadual, ref lvdc_Aliquota_InterEstadual_Importados)
												
				If ls_Utiliza_Aliquota_InterEstadual = "S" Then
					lvdc_Aliquota = ivo_UF_Destino.Pc_ICMS_Interestadual
				Else
					lvdc_Aliquota = lvdc_Aliquota_InterEstadual_Importados
				End If
				
			Case Else
				lvdc_Aliquota = ivo_UF_Origem.Pc_ICMS_Interestadual
		End Choose
	End If
Else
	lvdc_Aliquota = 0.00
End If

Return lvdc_Aliquota
end function

public function decimal of_pmc (uo_produto ao_produto);Decimal lvdc_PMC           

String lvs_UF

// Se a fun$$HEX2$$e700e300$$ENDHEX$$o estiver sendo executada na loja, utiliza o PMC diretamente da tabela produto
// Sen$$HEX1$$e300$$ENDHEX$$o verifica o PMC para a UF da filial origem/destino da opera$$HEX2$$e700e300$$ENDHEX$$o

If This.ivl_Filial <> This.ivl_Filial_Matriz Then
	If Not IsNull(ao_Produto.Vl_Preco_Venda_Maximo) Then
		lvdc_PMC = Round(ao_Produto.Vl_Preco_Venda_Maximo / ao_Produto.Vl_Fator_Conversao, 2)
	Else
		lvdc_PMC = 0
	End If
Else
	Choose Case ivs_Operacao
		Case COMPRA, DEVOLUCAO_VENDA, TRANSFERENCIA
			lvs_UF = ivo_UF_Destino.Cd_Unidade_Federacao
			
		Case Else
			lvs_UF = ivo_UF_Origem.Cd_Unidade_Federacao
	End Choose
	
	Select vl_preco_venda_maximo Into :lvdc_PMC
	From produto_uf
	Where cd_unidade_federacao = :lvs_UF
	  and cd_produto           = :ao_Produto.Cd_Produto
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O PMC do produto '" + String(ao_Produto.Cd_Produto) + "' para UF '" + lvs_UF + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado.~r~r" + &
			                      "Ser$$HEX1$$e100$$ENDHEX$$ considerado zero, e calculado pelo fator PMC.")
			lvdc_PMC = 0
			
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do PMC do Produto '" + String(ao_Produto.Cd_Produto) + "' para UF '" + lvs_UF + "'")
			ivb_Erro = True
	End Choose
End If

Return lvdc_PMC
end function

public function decimal of_indice_repasse_icms (decimal adc_icms_compra, decimal adc_icms_venda);Decimal lvdc_Indice

// $$HEX1$$cd00$$ENDHEX$$ndice de desconto aplicado ao pre$$HEX1$$e700$$ENDHEX$$o do produto
// Tem o objetivo de encontrar um pre$$HEX1$$e700$$ENDHEX$$o cujo custo ap$$HEX1$$f300$$ENDHEX$$s a retirada do ICMS interestadual
// Seja o mesmo de uma compra com ICMS estadual

// Exemplo:
// Pre$$HEX1$$e700$$ENDHEX$$o de Compra: R$100.00
// ICMS Estadual:      17.00 %
// ICMS Interestadual: 12.00 %

// Sem o repasse de ICMS, o custo seria de:
// 100.00 x 0.83 = 83.00
// 100.00 x 0.88 = 88.00 respectivamente

// Ent$$HEX1$$e300$$ENDHEX$$o o fornecedor faz um repasse de ICMS de 5.68%, aplicando o pre$$HEX1$$e700$$ENDHEX$$o de R$94.32
// Portanto, com o repasse de ICMS, o custo seria o mesmo:
// 100.00 x 0.83 = 83.00
//  94.32 x 0.88 = 83.00 respectivamente

lvdc_Indice = Round((1 - ((100 - adc_ICMS_Venda) / (100 - adc_ICMS_Compra))) * 100, 2)
						 
Return lvdc_Indice
end function

public function uo_atributo_fiscal_item_nf of_atributo_fiscal_produto (uo_produto po_produto);Boolean lvb_ICMS_ST

String ls_Tributacao_ICMS_Produto, ls_Tributacao_ICMS

uo_Tributacao_ICMS         lvo_Tributacao_Original
uo_Tributacao_ICMS         lvo_Tributacao_Alterada

lvo_Tributacao_Original 	= Create uo_Tributacao_ICMS
lvo_Tributacao_Alterada = Create uo_Tributacao_ICMS

ivo_Atributo.Localizado = False

If This.of_Localiza_Tributacao_Produto(po_Produto, Ref ls_Tributacao_ICMS_Produto) Then
	
	If mid(po_produto.cd_subcategoria, 1,1) = '5' Then
		is_produto_almoxarifado = 'S'
	Else
		is_produto_almoxarifado = 'N'
	End If
	
	il_Produto = po_Produto.cd_produto
	
	If ivs_Operacao = TRANSFERENCIA Then
		ls_Tributacao_ICMS = ls_Tributacao_ICMS_Produto
	Else
		ls_Tributacao_ICMS = po_Produto.Cd_Tributacao_ICMS
	End If
	
	If lvo_Tributacao_Original.of_Localiza_Tributacao(ls_Tributacao_ICMS) Then
		
		// Quando n$$HEX1$$e300$$ENDHEX$$o for transfer$$HEX1$$ea00$$ENDHEX$$ncia o sistema vai continuar utilizando o c$$HEX1$$f300$$ENDHEX$$digo da ST do produto e n$$HEX1$$e300$$ENDHEX$$o da UF de destino.
		If ivs_Operacao <> TRANSFERENCIA Then ls_Tributacao_ICMS = ''
		
		// Verifica qual a situa$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria da opera$$HEX2$$e700e300$$ENDHEX$$o para o produto
		ls_Tributacao_ICMS = This.of_Tributacao_ICMS_Operacao(po_Produto, ls_Tributacao_ICMS)
				
		If lvo_Tributacao_Alterada.of_Localiza_Tributacao(ls_Tributacao_ICMS) Then
			//Atribui a CST e Situa$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria da opera$$HEX2$$e700e300$$ENDHEX$$o
			ivo_Atributo.Cd_Situacao_Tributaria	= lvo_Tributacao_Alterada.cd_situacao_tributaria
			ivo_Atributo.Cd_CST_Tributacao		= lvo_Tributacao_Alterada.cd_cst_tributacao
			ivo_Atributo.Cd_Tributacao_ICMS		= lvo_Tributacao_Alterada.cd_tributacao_icms
			// Verifica qual a al$$HEX1$$ed00$$ENDHEX$$quota de icms do produto
			ivo_Atributo.Pc_ICMS = This.of_Aliquota_ICMS_Produto(po_Produto, lvo_Tributacao_Alterada)
			
			// Tratar erros
			If ivs_ICMS_Normal = 'S' and (ivo_Atributo.Pc_ICMS = 0 or ivo_Atributo.Pc_ICMS = -100) Then
				ivo_Atributo.Localizado = False
				Destroy(lvo_Tributacao_Original)
				Destroy(lvo_Tributacao_Alterada)
				Return ivo_Atributo
			End If
			
			// Venda InterEstadual
			If (This.ivs_Operacao = VENDA or This.ivs_Operacao = DEVOLUCAO_VENDA)  and ivs_Estadual = 'N' Then
				// Verifica qual a natureza de opera$$HEX2$$e700e300$$ENDHEX$$o do produto
				If lvo_Tributacao_Alterada.Id_ICMS_ST = "S" Then
					lvb_ICMS_ST = True
				Else
					lvb_ICMS_ST = False
				End If
			Else
				// Venda estadual/
				// Verifica qual a natureza de opera$$HEX2$$e700e300$$ENDHEX$$o do produto
				//Adicionado a condi$$HEX2$$e700e300$$ENDHEX$$o de 06 pois na BAHIA h$$HEX1$$e100$$ENDHEX$$ antecipa$$HEX2$$e700e300$$ENDHEX$$o de ICMS para produtos "00" e estes devem ser escriturados como retido anteriormente.
				If lvo_Tributacao_Original.Id_ICMS_ST = "S"or ivo_Atributo.Cd_Situacao_Tributaria = "06" Then
					lvb_ICMS_ST = True
				Else
					lvb_ICMS_ST = False
				End If
			End If
	
			ivo_Atributo.Localizado = This.of_NatOpe(lvb_ICMS_ST, ref ivo_Atributo.Cd_Natureza_Operacao)
		End If
	End If
End If

Destroy(lvo_Tributacao_Original)
Destroy(lvo_Tributacao_Alterada)

Return ivo_Atributo
end function

public function boolean of_localiza_tributacao_produto (uo_produto ao_produto, ref string as_tributacao_icms);as_tributacao_icms = This.Of_Localiza_tributacao_produto( ao_Produto.cd_produto, ivo_UF_Destino.cd_unidade_federacao)

Return (as_tributacao_icms <> "")
end function

public function boolean of_reducao_base_st_cesta_basica (uo_produto ao_produto, ref decimal adc_reducao);Select coalesce(pc_reducao_base_st, 0)
Into :adc_reducao
From produto_uf
Where cd_produto 				=:ao_Produto.cd_produto
    and cd_unidade_federacao 	=: ivo_UF_Destino.cd_unidade_federacao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		If Not IsNull(adc_reducao) and adc_reducao > 0 Then
			adc_reducao = (100 - adc_reducao) / 100
		End If
		
//		If IsNull(adc_reducao) or adc_reducao < 0 Then
//			adc_reducao = 0.00000
//		Else
//			adc_reducao = (100 - adc_reducao) / 100
//		End If
//		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto  '" +  string(uo_produto.cd_produto)  + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela produto_uf.", StopSign!)
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto_uf '" + string(uo_produto.cd_produto) + "'")
End Choose

Return true
end function

public function boolean of_redutor_custo_produto (string as_uf_origem, string as_uf_destino, long al_produto, ref decimal adc_redutor);Decimal ldc_ICMS

Long ll_Tributacao_Produto

String ls_Tributacao_ICMS

// Inicializa
adc_redutor = 1.00

If as_UF_Origem <> as_UF_Destino Then
	
	If ivl_Filial = ivl_Filial_matriz Then
		Select p.cd_tributacao_produto, p. cd_tributacao_icms, t.pc_icms
		Into :ll_Tributacao_Produto, :ls_Tributacao_ICMS, :ldc_ICMS
		From produto_uf p, tipo_icms t
		Where p.cd_unidade_federacao 	= :ivo_UF_Origem.cd_unidade_federacao
		  and p.cd_produto  		   			= :al_Produto
		  and t.cd_tipo_icms					= p.cd_tipo_icms
		Using Sqlca;
	Else
		Select p.cd_tributacao_produto, p. cd_tributacao_icms,  t.pc_icms
		Into :ll_Tributacao_Produto, :ls_Tributacao_ICMS, :ldc_ICMS
		From produto_geral p, tipo_icms t
		where p.cd_produto = :al_Produto
		   and t.cd_tipo_icms					= p.cd_tipo_icms
		Using Sqlca;
	End If
		
	Choose Case SqlCa.SqlCode
		Case 0
		
			If ll_Tributacao_Produto <> 0 and ls_Tributacao_ICMS  = '1' Then
			
				If as_UF_Destino = 'MS' or as_UF_Destino = "BA" Then
					
					Choose Case ldc_ICMS
						Case 17; adc_redutor = 1.2048
						Case 25; adc_redutor = 1.3333
						Case 18; adc_redutor = 1.22
					End Choose
					
				Else
					
					Choose Case ldc_ICMS
						Case 17; adc_redutor = 1.17
						Case 18; adc_redutor = 1.18
						Case 20; adc_redutor = 1.20
						Case 23; adc_redutor = 1.23
						Case 25; adc_redutor = 1.25
					End Choose
				
				End If
				
			End If
					
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar a tributa$$HEX2$$e700e300$$ENDHEX$$o de ICMS do produto.", StopSign!)
			Return False
		Case -1
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da tributa$$HEX2$$e700e300$$ENDHEX$$o de ICMS do produto.")
			Return False
	End Choose
	
End If

Return True


end function

public subroutine of_aliquota_icms_origem_produto (uo_produto po_produto, ref string as_considera_pc_uf_interestadual, ref decimal adc_aliquota_icms_interestadual);// Default
as_considera_pc_uf_interestadual = "S"

// Vai ser nulo quando o cadastro n$$HEX1$$e300$$ENDHEX$$o tiver sido atualizado ou porque nas lojas ainda n$$HEX1$$e300$$ENDHEX$$o foi alterado o sistema
If Not IsNull(po_Produto.cd_st_origem) and Trim(po_Produto.cd_st_origem) <> "" Then
	
	Select id_considera_pc_uf, pc_icms_interestadual 
	Into :as_considera_pc_uf_interestadual, :adc_aliquota_icms_interestadual
	From cst_origem
	Where cd_st_origem = :po_Produto.cd_st_origem
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da aliquota de ICMS dos produtos importados.", StopSign!)
			ivb_Erro = True
		Case -1
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da aliquota de ICMS dos produtos importados")
			ivb_Erro = True
	End Choose
	
End If
end subroutine

public function uo_atributo_fiscal_item_nf of_atributo_fiscal_produto (string ps_situacao_tributaria);Boolean lvb_ICMS_ST

ivo_Atributo.Localizado = False

If ivo_Tributacao.of_Localiza_Tributacao(ps_situacao_tributaria) Then
				
	// Verifica qual a natureza de opera$$HEX2$$e700e300$$ENDHEX$$o do produto
	If ivo_Tributacao.Id_ICMS_ST = "S" Then
		lvb_ICMS_ST = True
	Else
		lvb_ICMS_ST = False
	End If
	
	If ivs_Operacao = DEVOLUCAO_COMPRA Then
		If RightA(ps_situacao_tributaria, 1) = "6" Then
			lvb_ICMS_ST = True
		End If
	End If
	
	ivo_Atributo.Localizado = This.of_NatOpe(lvb_ICMS_ST, ref ivo_Atributo.Cd_Natureza_Operacao)
	
End If

Return ivo_Atributo
end function

public function boolean of_envia_email (string as_mensagem);String ls_Anexo[]

gf_ge202_envia_email_automatico(75, "Transfer$$HEX1$$ea00$$ENDHEX$$ncia do Perini para SP", as_mensagem, ls_Anexo)

Return True
end function

public function boolean of_base_st_farmacia_popular (long al_produto, ref decimal adc_preco_base_st);Select vl_preco_farmacia_popular  
Into :adc_preco_base_st
From produto_uf
Where	cd_produto           			= :al_Produto
  	and 	cd_unidade_federacao 		= :ivo_UF_Destino.cd_unidade_federacao
  	and 	id_considera_preco_fp_st  	= 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(adc_preco_base_st) or adc_preco_base_st < 0 Then
			adc_preco_base_st = 0.00
		End If
	Case 100
		adc_preco_base_st = 0.00
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do vl_preco_farmacia_popular do produto '" + String(al_Produto) + "'- uo_tratamento_fiscal.of_base_st_farmacia_popular")
		Return False
End Choose

Return True
end function

public function decimal of_reducao_base_st (string as_grupo, string as_uf, string as_lei_generico, string as_lista);Decimal{5} ldc_Reducao = 1

//MATRIZ 
If This.of_Base_Matriz() Then

	Select coalesce(pc_reducao_base,0)
	Into :ldc_Reducao
	From reducao_base_icms_st
	Where cd_unidade_federacao 	= :as_UF
		and cd_grupo					= :as_Grupo
		and id_lei_generico			= :as_Lei_Generico
		and id_lista_pis_cofins		= :as_Lista
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If ldc_Reducao >= 99 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O percentual de redu$$HEX2$$e700e300$$ENDHEX$$o da base de ICMS ST $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida.")
				ivb_Erro = True
				Return 1
			End If
			ldc_Reducao = (100 - ldc_Reducao) / 100
			
		Case 100
			//Retorna o valor inicial da vari$$HEX1$$e100$$ENDHEX$$vel ldc_Reducao no final da fun$$HEX2$$e700e300$$ENDHEX$$o
			
		Case -1
			SqlCa.of_MsgdbError("Erro ao localizar o percentual de redu$$HEX2$$e700e300$$ENDHEX$$o da base de ICMS ST.")
			ivb_Erro = True
			//Retorna o valor inicial da vari$$HEX1$$e100$$ENDHEX$$vel ldc_Reducao no final da fun$$HEX2$$e700e300$$ENDHEX$$o
			
	End Choose

//LOJA (n$$HEX1$$e300$$ENDHEX$$o existe a tabela)
Else
	Choose Case as_uf
		Case 'BA'
			ldc_Reducao	= 1.0000
			
		Case 'MS'
			ldc_Reducao	= 0.9000
			
		Case 'PR'
			Choose Case as_lei_generico
				Case 'G'
					ldc_Reducao	= 0.7500
				Case 'S', 'E' 
					ldc_Reducao	= 0.7000
				Case 'R'
					ldc_Reducao	= 0.9000
				Case Else //outros
					ldc_Reducao	= 0.9000
			End Choose	
			
		Case 'RS'
			Choose Case as_lei_generico
				Case 'G'
					ldc_Reducao	= 0.6300
				Case 'S', 'E' 
					ldc_Reducao	= 0.8200
				Case 'R'
					ldc_Reducao	= 0.7800
				Case Else //outros
					ldc_Reducao	= 0.9000
			End Choose	
			
		Case 'SC'
			Choose Case as_lei_generico
				Case 'G'
					ldc_Reducao	= 0.7500
				Case 'S', 'E' 
					ldc_Reducao	= 0.8000
				Case 'R'
					ldc_Reducao	= 0.8000
				Case Else //outros
					ldc_Reducao	= 0.8000
			End Choose	
			
		Case 'SP'
			// Verifica se o produto $$HEX1$$e900$$ENDHEX$$ generico, similar ou referencia para calcular o desconto na base ST
			// valores atualizados conforme planilha Lucineide 29.11.2017
			Choose Case as_lei_generico
				Case 'G'
					Choose Case as_lista
						Case 'P'; ldc_Reducao	= 0.5864
						Case 'N'; ldc_Reducao	= 0.7212
						Case Else; ldc_Reducao	= 1.0000
					End Choose
				
				Case 'S', 'E' 
					Choose Case as_lista
						Case 'P'; ldc_Reducao	= 0.7444
						Case 'N'; ldc_Reducao	= 0.8384
						Case Else; ldc_Reducao	= 0.9290
					End Choose
					
				Case 'R'
					Choose Case as_lista
						Case 'P'; ldc_Reducao	= 0.7345
						Case 'N'; ldc_Reducao	= 0.8802
						Case Else; ldc_Reducao	= 0.9229
					End Choose
					
				Case Else //outros
					Choose Case as_lista
						Case 'P'; ldc_Reducao	= 0.7444
						Case 'N'; ldc_Reducao	= 0.8384
						Case Else; ldc_Reducao	= 0.9290
					End Choose
			End Choose	
		
		Case Else
			ldc_Reducao = 0.90
	End Choose
End If

Return ldc_Reducao
end function

public function boolean of_localiza_tributacao_filial_destino (long al_produto, string as_uf_destino, ref string as_tributacao);Boolean lb_Sucesso = False

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)

lvo_Conexao.of_Executa_Rotina("0134",{"'" + as_UF_Destino + "'", string(al_produto)})

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	ivs_mensagem = "Erro ao localizar a tributa$$HEX2$$e700e300$$ENDHEX$$o da filial destino na matriz."
	ivb_Erro = True
Else
	If lvo_Conexao.of_Linhas() > 0 Then
		If lvo_Conexao.of_Retorno("cd_tributacao_icms", Ref as_tributacao) Then
			lb_Sucesso = True
		End If
	Else
		ivs_mensagem = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar a tributa$$HEX2$$e700e300$$ENDHEX$$o da filial destino na matriz."
		ivb_Erro = True
	End If
End If

Destroy(lvo_Conexao)

Return lb_Sucesso
end function

public subroutine of_grava_precisao (long pl_casas_decimais);If pl_casas_decimais > 4 Then pl_casas_decimais = 4

ivl_Decimais = pl_casas_decimais
end subroutine

public function integer of_reducao_ultima_compra (string as_fornecedor, long al_produto);Decimal ldc_Reducao

// ESTA FUN$$HEX2$$c700c300$$ENDHEX$$O SER$$HEX1$$c100$$ENDHEX$$ UTILIZADA SOMENTE SE O PRODUTO POSSUIR ST + REDU$$HEX2$$c700c300$$ENDHEX$$O DA BASE DE ICMS NORMAL (INTERESTADUAL + LISTA NEGATIVA)

Select top 1 coalesce(i.pc_reducao_base_icms, 0)
Into :ldc_Reducao
From nf_compra n
inner join item_nf_compra i on i.cd_filial = n.cd_filial
									and i.cd_fornecedor = n.cd_fornecedor
									and i.nr_nf				= n.nr_nf
									and i.de_especie		= n.de_especie
									and i.de_serie			= n.de_serie
where n.cd_fornecedor 				= :as_fornecedor
  and n.dh_movimentacao_caixa >= dateadd(yy, -1, cast(getdate() as date))
  and n.cd_filial 						= 534
  and i.cd_produto 					= :al_produto
order by n.dh_movimentacao_caixa desc
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		// A ULTIMA COMPRA FOI COM REDU$$HEX2$$c700c300$$ENDHEX$$O, PODE REDUZIR.
		If ldc_Reducao > 0 Then
			Return 1
		Else
			// A ULTIMA COMPRA FOI SEM REDU$$HEX2$$c700c300$$ENDHEX$$O, N$$HEX1$$c300$$ENDHEX$$O REDUZ.
			Return 0
		End If
	Case 100
		// N$$HEX1$$c300$$ENDHEX$$O ENCONTROU,PODE REDUZIR.
		Return 1
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da $$HEX1$$fa00$$ENDHEX$$ltima compra '" + string(al_produto) + "'")
		Return -1
End Choose
end function

public function boolean of_aliquota_icms_venda (long al_produto, string as_uf, ref decimal adc_icms, ref decimal adc_fcp);Boolean lvb_Sucesso = False

Select t.pc_icms, coalesce(t.pc_fcp, 0)
Into :adc_ICMS, :adc_fcp
From produto_uf u,
     tipo_icms t
Where u.cd_produto           = :al_Produto
  and u.cd_unidade_federacao = :as_UF
  and t.cd_tipo_icms = u.cd_tipo_icms
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Al$$HEX1$$ed00$$ENDHEX$$quota de ICMS de venda n$$HEX1$$e300$$ENDHEX$$o localizada." + &
		           "~r~rProduto:" + String(al_Produto) + "~rU.F.:" + as_UF + "~rFun$$HEX2$$e700e300$$ENDHEX$$o: uo_tratamento_fiscal.of_aliquota_icms_venda") 
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Al$$HEX1$$ed00$$ENDHEX$$quota de ICMS de Venda - uo_tratamento_fiscal.of_aliquota_icms_venda")
End Choose

Return lvb_Sucesso
end function

public function boolean of_aliquota_icms_difa (ref decimal adc_aliquota_origem, ref decimal adc_aliquota_destino);Long ll_Ano

ll_Ano = Year(Today())

If ll_Ano > 2015 Then
	Choose Case ll_Ano
		Case 2016
			adc_aliquota_origem = 60.00
			adc_aliquota_destino = 40.00
		Case 2017
			adc_aliquota_origem = 40.00
			adc_aliquota_destino = 60.00
		Case 2018
			adc_aliquota_origem = 20.00
			adc_aliquota_destino = 80.00
		Case Else
			adc_aliquota_origem = 0.00
			adc_aliquota_destino = 100.00
	End Choose
Else
	adc_aliquota_origem 	= 0.00
	adc_aliquota_destino	= 0.00
End If

////em 2019 a aliquota de origem passou a ser ZERO
//If adc_aliquota_origem <= 0 or adc_aliquota_destino <= 0 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Al$$HEX1$$ed00$$ENDHEX$$quota de ICMS para c$$HEX1$$e100$$ENDHEX$$lculo da diferen$$HEX1$$e700$$ENDHEX$$a de ICMS entre estados $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida (DIFA).", StopSign!)
//	Return False
//End If

Return True
end function

public function decimal of_fator_mva (long ai_tributacao_produto, decimal adc_icms);Decimal ldc_MVA

Select pc_mva
Into :ldc_MVA
From tributa_produtos_farm_mva
Where cd_tributacao_produto 	=:ai_Tributacao_Produto
	and pc_icms 					=:adc_icms
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return ldc_MVA
	Case 100
		Return -100
	Case -1 
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do percentual do MVA do produto")
		ivb_Erro = True
		Return -100
End Choose
end function

public function string of_cfop_tributavel_pis_cofins (long pl_cfop, boolean pb_exibe_msg, string ps_mensagem);String lvs_Tributa

Select id_tributavel_pis_cofins
Into :lvs_Tributa
From natureza_operacao
Where cd_natureza_operacao = :pl_cfop
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	If pb_exibe_msg Then
		SQLCa.Of_msgdberror('Verifica$$HEX2$$e700e300$$ENDHEX$$o CFOP tribut$$HEX1$$e100$$ENDHEX$$vel.')
	Else
		ps_mensagem = 'Falha na verifica$$HEX2$$e700e300$$ENDHEX$$o de CFOP tribut$$HEX1$$e100$$ENDHEX$$vel. ~r'+SQLCa.SQLErrText
	End If
Else
	If Trim(lvs_Tributa)='' or IsNull(lvs_Tributa) Then	lvs_Tributa = 'N'
End If

Return lvs_Tributa

end function

public function boolean of_retorna_pis_cofins_produto (long pl_produto, string ps_entrada_saida, string ps_tributavel, ref string ps_pis, ref string ps_cst_pis, ref decimal pdc_aliq_pis, ref string ps_cofins, ref string ps_cst_cofins, ref decimal pdc_aliq_cofins, ref string ps_lista, boolean pb_exibe_msg, ref string ps_msg);//OPERA$$HEX2$$c700d500$$ENDHEX$$ES TRIBUT$$HEX1$$c100$$ENDHEX$$VEIS (configur$$HEX1$$e100$$ENDHEX$$vel na CFOP)
If ps_tributavel = 'S' Then 
	
	//OPERA$$HEX2$$c700d500$$ENDHEX$$ES TRIBUT$$HEX1$$c100$$ENDHEX$$VEIS DE ENTRADA
	If ps_entrada_saida = 'E' Then 
		Select	 	tp.cd_cst_entrada as cd_cst_pis,
					coalesce(tp.pc_aliquota,0) as pc_pis,
					sp.id_tributado as id_pis,
					tc.cd_cst_entrada as cd_cst_cofins,
					coalesce(tc.pc_aliquota,0) as pc_cofins,
					sc.id_tributado as id_cofins,
					p.id_situacao_pis_cofins
		Into 	:ps_cst_pis,
				:pdc_aliq_pis,
				:ps_pis,
				:ps_cst_cofins,
				:pdc_aliq_cofins,
				:ps_cofins,
				:ps_lista
		From produto_geral p
		left outer join ncm_pis_cofins n
		  on n.nr_ncm = p.nr_classificacao_fiscal
		  and n.id_lista_pis_cofins = p.id_situacao_pis_cofins
		left outer join tributacao_pis_cofins tp
		  on tp.cd_tributacao_pis_cofins = n.cd_tributacao_pis
		left outer join situacao_tributaria sp
		  on sp.cd_cst = tp.cd_cst_entrada
		left outer join tributacao_pis_cofins tc
		  on tc.cd_tributacao_pis_cofins = n.cd_tributacao_cofins
		left outer join situacao_tributaria sc
		  on sc.cd_cst = tc.cd_cst_entrada
		Where p.cd_produto = :pl_produto
		Using SQLCA;
	
	//OPERA$$HEX2$$c700d500$$ENDHEX$$ES TRIBUT$$HEX1$$c100$$ENDHEX$$VEIS DE SA$$HEX1$$cd00$$ENDHEX$$DA
	Else
		Select	 	tp.cd_cst_saida as cd_cst_pis,
					coalesce(tp.pc_aliquota,0) as pc_pis,
					sp.id_tributado as id_pis,
					tc.cd_cst_saida as cd_cst_cofins,
					coalesce(tc.pc_aliquota,0) as pc_cofins,
					sc.id_tributado as id_cofins,
					p.id_situacao_pis_cofins
		Into 	:ps_cst_pis,
				:pdc_aliq_pis,
				:ps_pis,
				:ps_cst_cofins,
				:pdc_aliq_cofins,
				:ps_cofins,
				:ps_lista
		From produto_geral p
		left outer join ncm_pis_cofins n
		  on n.nr_ncm = p.nr_classificacao_fiscal
		  and n.id_lista_pis_cofins = p.id_situacao_pis_cofins
		left outer join tributacao_pis_cofins tp
		  on tp.cd_tributacao_pis_cofins = n.cd_tributacao_pis
		left outer join situacao_tributaria sp
		  on sp.cd_cst = tp.cd_cst_saida
		left outer join tributacao_pis_cofins tc
		  on tc.cd_tributacao_pis_cofins = n.cd_tributacao_cofins
		left outer join situacao_tributaria sc
		  on sc.cd_cst = tc.cd_cst_saida
		Where p.cd_produto = :pl_produto
		Using SQLCA;
	End If
	
//OPERA$$HEX2$$c700d500$$ENDHEX$$ES N$$HEX1$$c300$$ENDHEX$$O TRIBUT$$HEX1$$c100$$ENDHEX$$VEIS
Else
	
	//OPERA$$HEX2$$c700d500$$ENDHEX$$ES N$$HEX1$$c300$$ENDHEX$$O TRIBUT$$HEX1$$c100$$ENDHEX$$VEIS DE ENTRADA	
	If ps_entrada_saida = 'E' Then
		Select	 	tp.cd_cst_transf_entrada as cd_cst_pis,
					coalesce(tp.pc_aliquota,0) as pc_pis,
					sp.id_tributado as id_pis,
					tc.cd_cst_transf_entrada as cd_cst_cofins,
					coalesce(tc.pc_aliquota,0) as pc_cofins,
					sc.id_tributado as id_cofins,
					p.id_situacao_pis_cofins
		Into 	:ps_cst_pis,
				:pdc_aliq_pis,
				:ps_pis,
				:ps_cst_cofins,
				:pdc_aliq_cofins,
				:ps_cofins,
				:ps_lista
		From produto_geral p
		left outer join ncm_pis_cofins n
		  on n.nr_ncm = p.nr_classificacao_fiscal
		  and n.id_lista_pis_cofins = p.id_situacao_pis_cofins
		left outer join tributacao_pis_cofins tp
		  on tp.cd_tributacao_pis_cofins = n.cd_tributacao_pis
		left outer join situacao_tributaria sp
		  on sp.cd_cst = tp.cd_cst_transf_entrada
		left outer join tributacao_pis_cofins tc
		  on tc.cd_tributacao_pis_cofins = n.cd_tributacao_cofins
		left outer join situacao_tributaria sc
		  on sc.cd_cst = tc.cd_cst_transf_entrada
		Where p.cd_produto = :pl_produto
		Using SQLCA;
		
	//OPERA$$HEX2$$c700d500$$ENDHEX$$ES N$$HEX1$$c300$$ENDHEX$$O TRIBUT$$HEX1$$c100$$ENDHEX$$VEIS DE SA$$HEX1$$cd00$$ENDHEX$$DA	
	Else
		Select	 	tp.cd_cst_transf_saida as cd_cst_pis,
					coalesce(tp.pc_aliquota,0) as pc_pis,
					sp.id_tributado as id_pis,
					tc.cd_cst_transf_saida as cd_cst_cofins,
					coalesce(tc.pc_aliquota,0) as pc_cofins,
					sc.id_tributado as id_cofins,
					p.id_situacao_pis_cofins
		Into 	:ps_cst_pis,
				:pdc_aliq_pis,
				:ps_pis,
				:ps_cst_cofins,
				:pdc_aliq_cofins,
				:ps_cofins,
				:ps_lista
		From produto_geral p
		left outer join ncm_pis_cofins n
		  on n.nr_ncm = p.nr_classificacao_fiscal
		  and n.id_lista_pis_cofins = p.id_situacao_pis_cofins
		left outer join tributacao_pis_cofins tp
		  on tp.cd_tributacao_pis_cofins = n.cd_tributacao_pis
		left outer join situacao_tributaria sp
		  on sp.cd_cst = tp.cd_cst_transf_saida
		left outer join tributacao_pis_cofins tc
		  on tc.cd_tributacao_pis_cofins = n.cd_tributacao_cofins
		left outer join situacao_tributaria sc
		  on sc.cd_cst = tc.cd_cst_transf_saida
		Where p.cd_produto = :pl_produto
		Using SQLCA;
	End If	
End If

If SQLCA.SQLCode = -1 Then
	If pb_exibe_msg Then
		SQLCa.Of_msgdberror('Localiza$$HEX2$$e700e300$$ENDHEX$$o configura$$HEX2$$e700e300$$ENDHEX$$o PIS/COFINS do produto '+String(pl_produto)+'.')
	Else
		ps_msg = 'Falha na localiza$$HEX2$$e700e300$$ENDHEX$$o configura$$HEX2$$e700e300$$ENDHEX$$o PIS/COFINS do produto '+String(pl_produto)+'.'
	End If
	Return False
End if

Return True
end function

public function boolean of_natope (boolean ab_icms_st, ref long al_natureza);Boolean lvb_Sucesso = True
//Vari$$HEX1$$e100$$ENDHEX$$vel para definir automaticamente a CFOP interestadual
//Defin$$HEX1$$ed00$$ENDHEX$$-la como "False" quando a CFOP interestadual for definida no c$$HEX1$$f300$$ENDHEX$$digo
Boolean lvb_Trata_Interestadual = True

//Necess$$HEX1$$e100$$ENDHEX$$rio ter possibilidade de fixar a CFOP para as notas diversas
If ivl_CFOP_Fixa > 0 Then
	al_Natureza = ivl_CFOP_Fixa
Else
	//Demais opera$$HEX2$$e700f500$$ENDHEX$$es com CFOP por regras
	Choose Case This.ivs_Operacao
		Case COMPRA
			If is_produto_almoxarifado = 'S' and ivl_Filial_Destino <> ivl_filial_matriz and ivs_fornecedor_uso_consumo = 'S' Then
				If Not ab_ICMS_ST Then
					al_Natureza = 1556
				Else
					al_Natureza = 1407
				End If
			else
				If Not ab_ICMS_ST Then
					al_Natureza = 1102
				Else
					al_Natureza = 1403
				End If
			End If
			
		Case DEVOLUCAO_COMPRA
			// Devolu$$HEX2$$e700e300$$ENDHEX$$o do almoxarifado do perini
			If (ivl_Filial = ivl_filial_matriz) and (is_produto_almoxarifado = 'S') Then
				If Not This.of_natope_almoxarifado(Ref al_Natureza) Then Return False
			Else
				If Not ab_ICMS_ST Then
					al_Natureza = 5202
				Else
					al_Natureza = 5411
				End If
			End If
			
		Case TRANSFERENCIA
			// ALMOXARIFADO
			If is_produto_almoxarifado = 'S' Then
				al_Natureza = 5557	
			Else
				// Transfer$$HEX1$$ea00$$ENDHEX$$ncia CD
				If ivl_Filial = ivl_filial_matriz  Then
					If Not ab_ICMS_ST Then
						al_Natureza = 5152
					Else
						al_Natureza = 5409
					End If
				Else
					If ivl_Filial_Destino = ivl_filial_matriz Then
						// Devolu$$HEX2$$e700e300$$ENDHEX$$o para o CD
						If ivs_devolucao_transferencia_cd = 'S' Then
							al_Natureza = 5209
						ElseIf Not ab_ICMS_ST Then
							al_Natureza = 5152
						Else
							al_Natureza = 5409
						End If
					Else
						If Not ab_ICMS_ST Then
							al_Natureza = 5152
						Else
							al_Natureza = 5409
						End If
					End If
				End If // Fim transfer$$HEX1$$ea00$$ENDHEX$$ncia CD
			End If //  TRANSFERENCIA NORMAL
			
		Case VENDA 
			If ivs_resgate_clube = "S" Then
				al_Natureza = 5910
			Else
				If Not ab_ICMS_ST Then
					al_Natureza = 5102
				Else
					al_Natureza = 5405
				End If
			End If
			
		Case DEVOLUCAO_VENDA
			//2015.11.04 - Comentado at$$HEX1$$e900$$ENDHEX$$ resolver problema de rejei$$HEX2$$e700e300$$ENDHEX$$o por UF no NFe
			//lvb_Trata_Interestadual = False
			If Not ab_ICMS_ST Then
				al_Natureza = 1202
			Else
				al_Natureza = 1411
			End If
			
	End Choose	

	// Data Altera$$HEX2$$e700e300$$ENDHEX$$o: 25/03/2014
	// Solicita$$HEX2$$e700e300$$ENDHEX$$o: Fernando Corr$$HEX1$$ea00$$ENDHEX$$a
	// Implementa$$HEX2$$e700e300$$ENDHEX$$o: Marlon Kniss
	// Objetivo: Transformar CFOP estadual em interestadual, quando estiver lvb_Trata_Interestadual como True
	If (lvb_Trata_Interestadual)and(This.ivs_Estadual <> "S") Then
		al_Natureza += 1000
	End If
End If

If Not This.of_Existe_Natureza_Operacao(al_Natureza) Then
	If Not This.of_Inclui_Natureza_Operacao(al_Natureza) Then
		lvb_Sucesso = False
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_natope_almoxarifado (ref long al_natureza);Integer li_Achou

Select Count(*)
Into :li_Achou
From produto_geral g
Inner join vw_classificacao_produto v
	on v.cd_subcategoria = g.cd_subcategoria
Inner join subgrupo s
	on s.cd_subgrupo = v.cd_subgrupo
Where g.cd_produto 			= :il_Produto
  	and s.cd_conta_contabil 	= '4127'
Using SqlCa;

If Sqlca.Sqlcode = -1 Then
	SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do SUBGRUPO para identica$$HEX2$$e700e300$$ENDHEX$$o da natureza da opera$$HEX2$$e700e300$$ENDHEX$$o do produto '" +&
								String(il_Produto) + "' - uo_tratamento_fiscal.of_natope_almoxarifado.")
	ivb_Erro = True
	Return False
End If

If li_Achou > 0 Then
	al_natureza = 5202 
Else
	al_natureza = 5556
End If

Return True
end function

public function decimal of_fator_pmc (string as_lista_pis_cofins, string as_lei_generico, integer ai_tributacao_produto, decimal adc_aliq_icms_operacao, long al_ncm, decimal adc_red_base_st);Boolean lvb_Estadual
Boolean lvb_Aliq_Fixa

If This.ivs_Estadual = "S" Then lvb_Estadual = True

Return This.of_Fator_PMC(lvb_Estadual, ivo_UF_Destino.Pc_ICMS_Estadual, adc_aliq_icms_operacao, as_Lista_PIS_COFINS, as_lei_generico, ai_Tributacao_Produto, al_ncm, adc_red_base_st, ref lvb_Aliq_Fixa)
end function

public function decimal of_fator_pmc (boolean ab_estadual, decimal adc_aliq_icms_destino, decimal adc_aliq_icms_operacao, string as_lista_pis_cofins, string as_lei_generico, long al_ncm, integer adc_red_base_st);Boolean lvb_Aliq_Fixa

//A tabela acima $$HEX1$$e900$$ENDHEX$$ agual a tabela fixa na mesma fun$$HEX2$$e700e300$$ENDHEX$$o para a tributacao 0
Return This.Of_Fator_PMC(ab_estadual, adc_aliq_icms_destino, adc_aliq_icms_operacao, as_lista_pis_cofins, as_lei_generico, 0, al_ncm, adc_red_base_st,ref lvb_Aliq_Fixa)
end function

public function decimal of_fator_pmc (string as_lista_pis_cofins, string as_lei_generico, decimal adc_aliq_icms_operacao, long al_ncm, decimal adc_red_base_st);Boolean lvb_Estadual

If This.ivs_Estadual = "S" Then lvb_Estadual = True

Return This.of_Fator_PMC(lvb_Estadual, ivo_UF_Destino.Pc_ICMS_Estadual, adc_aliq_icms_operacao, as_Lista_PIS_COFINS, as_lei_generico, al_ncm, adc_red_base_st)
end function

public function decimal of_fator_pmc (boolean ab_estadual, decimal adc_aliq_icms_destino, decimal adc_aliq_icms_operacao, string as_lista_pis_cofins, string as_lei_generico, integer ai_tributacao_produto, long al_ncm, decimal adc_red_base_st, ref boolean ab_ajusta_mva);Decimal lvdc_Fator_PMC,&
		lvdc_Fator_PMC_Estadual,&
		lvdc_Fator_PMC_Inter,&
		lvdc_Fator_PMC_Fixo

Boolean lvb_Localizado = False

String lvs_Red_Base_ST
String lvs_Lei_Generico

Long lvl_Tipo_Produto //1=MEDICAMENTO, 2=PERFUMARIA, 3=ALIMENTOS, 4=OUTROS

lvdc_Fator_PMC	= 1
ab_ajusta_mva		= True

//N$$HEX1$$e300$$ENDHEX$$o possui MVA espec$$HEX1$$ed00$$ENDHEX$$fico
If ai_Tributacao_Produto = 0 Then
	//Verifica se o objeto est$$HEX1$$e100$$ENDHEX$$ criado
	If Not IsValid(ivo_tipo_produto_fiscal) Then ivo_tipo_produto_fiscal = Create uo_tipo_produto_fiscal
	//Verifica o tipo de produto fiscal atrav$$HEX1$$e900$$ENDHEX$$s da NCM
	ivo_tipo_produto_fiscal.of_tipo_produto_fiscal_uf(ivo_UF_Destino.Cd_unidade_federacao, al_ncm, ref lvl_Tipo_Produto)
	//Se o tipo de produto for medicamento
	If lvl_Tipo_Produto = 1 Then
		//Produto EQUIVALENTE devem ser tratados como SIMILAR
		lvs_Lei_Generico = IIF(as_lei_generico = 'E','S',as_lei_generico)
		//Trata nulo
		If IsNull(adc_red_base_st) Then adc_red_base_st = 0.00
		lvs_Red_Base_ST = IIF(adc_red_base_st > 0.00, 'S', 'N')
		
		//Efetua a primeira verifica$$HEX2$$e700e300$$ENDHEX$$o, considerando se tem ou n$$HEX1$$e300$$ENDHEX$$o redu$$HEX2$$e700e300$$ENDHEX$$o de base st, 
		// por causa do estado do RS que possui al$$HEX1$$ed00$$ENDHEX$$quota diferenciada p/ produtos da cesta b$$HEX1$$e100$$ENDHEX$$sica
		select coalesce(af.pc_mva,t.pc_st_estadual), coalesce(af.pc_mva,t.pc_st_interestadual), af.pc_mva, t.pc_trava
		Into :lvdc_Fator_PMC_Estadual, :lvdc_Fator_PMC_Inter, :lvdc_Fator_PMC_Fixo, :ivo_atributo_nf.pc_trava_iva_st
		from tributa_produtos_farmaceuticos t
		left outer join tributa_produtos_farm_mva af
			on af.cd_tributacao_produto = t.cd_tributacao_produto
			and af.pc_icms = :adc_aliq_icms_operacao
		where t.cd_ncm_inicial <= :al_ncm
			and t.cd_ncm_final >= :al_ncm
			and t.cd_unidade_federacao = :ivo_UF_Destino.Cd_unidade_federacao
			and t.id_situacao_pis_cofins = :as_lista_pis_cofins
			and coalesce(t.id_reducao_base_st,'N') = :lvs_Red_Base_ST
			and ( (t.id_lei_generico = :lvs_Lei_Generico) 
					or ( (t.id_lei_generico is null) 
							and (not exists (	select 1 
													from tributa_produtos_farmaceuticos t1 
													where t1.cd_tributacao_produto <> t.cd_tributacao_produto
													 and t1.cd_ncm_inicial <= :al_ncm
													 and t1.cd_ncm_final >= :al_ncm
													 and t1.cd_unidade_federacao = t.cd_unidade_federacao
													 and t1.id_situacao_pis_cofins = :as_lista_pis_cofins
													 and t1.id_lei_generico = :lvs_Lei_Generico) ) ) )
		Using SQLCa;
		
		lvb_Localizado = (SQLCa.SQLCode = 0)
		
		//N$$HEX1$$e300$$ENDHEX$$o foi localizado? Se tiver redu$$HEX2$$e700e300$$ENDHEX$$o de base ST pode ocorrer de o estado ter al$$HEX1$$ed00$$ENDHEX$$quota $$HEX1$$fa00$$ENDHEX$$nica para ambas as situa$$HEX2$$e700f500$$ENDHEX$$es
		// e na tabela de tributa_produtos_farmaceuticos ter apenas um registro com o id_red_base_st = N
		If (Not lvb_Localizado) and (lvs_Red_Base_ST = 'S') Then
			
			select coalesce(af.pc_mva,t.pc_st_estadual), coalesce(af.pc_mva,t.pc_st_interestadual), af.pc_mva, t.pc_trava
			Into :lvdc_Fator_PMC_Estadual, :lvdc_Fator_PMC_Inter, :lvdc_Fator_PMC_Fixo, :ivo_atributo_nf.pc_trava_iva_st
			from tributa_produtos_farmaceuticos t
			left outer join tributa_produtos_farm_mva af
				on af.cd_tributacao_produto = t.cd_tributacao_produto
				and af.pc_icms = :adc_aliq_icms_operacao
			where t.cd_ncm_inicial <= :al_ncm
				and t.cd_ncm_final >= :al_ncm
				and t.cd_unidade_federacao = :ivo_UF_Destino.Cd_unidade_federacao
				and t.id_situacao_pis_cofins = :as_lista_pis_cofins
				and ( (t.id_lei_generico = :lvs_Lei_Generico) 
						or ( (t.id_lei_generico is null) 
								and (not exists (	select 1 
														from tributa_produtos_farmaceuticos t1 
														where t1.cd_tributacao_produto <> t.cd_tributacao_produto
														 and t1.cd_ncm_inicial <= :al_ncm
														 and t1.cd_ncm_final >= :al_ncm
														 and t1.cd_unidade_federacao = t.cd_unidade_federacao
														 and t1.id_situacao_pis_cofins = :as_lista_pis_cofins
														 and t1.id_lei_generico = :lvs_Lei_Generico) ) ) )
			Using SQLCa;
			
			lvb_Localizado = (SQLCa.SQLCode = 0)
			
		End If
		
		If lvb_Localizado Then lvdc_Fator_PMC = IIF(ab_estadual,lvdc_Fator_PMC_Estadual, lvdc_Fator_PMC_Inter)
	End If
	
	//Localizou uma tributa$$HEX2$$e700e300$$ENDHEX$$o para este medicamento?
	If lvb_Localizado Then	
		//Ajusta o MVA somente se n$$HEX1$$e300$$ENDHEX$$o existe % MVA fixo para a al$$HEX1$$ed00$$ENDHEX$$quota desta opra$$HEX2$$e700e300$$ENDHEX$$o
		ab_ajusta_mva = (IsNull(lvdc_Fator_PMC_Fixo))
		This.Of_Log_Calculo("Tipo MVA = Tribut. ICMS ST com MVA "+IIF(ab_ajusta_mva, "", "Ajustado")+" (Lista PIS/Lei Gen$$HEX1$$e900$$ENDHEX$$rico/UF)")	
	Else //Se n$$HEX1$$e300$$ENDHEX$$o localizou permanece a regra antiga	
		This.Of_Log_Calculo("Tipo MVA = Medicamento Tabela Fixa (Modo Antigo, por Lista e Lei Gen$$HEX1$$e900$$ENDHEX$$rico)")	
		
		//S$$HEX1$$c300$$ENDHEX$$O PAULO varia pela lista PIS/COFINS e Lei Gen$$HEX1$$e900$$ENDHEX$$rico - Retirado da fun$$HEX2$$e700e300$$ENDHEX$$o Of_Fator_PMC_SP()
		If  ivo_UF_Destino.cd_unidade_federacao = 'SP' Then
				
			If (al_ncm >= 30020000 and al_ncm <= 30049999) or (al_ncm >= 30066000 and al_ncm <= 30066099) Then
				//Atualizados valores pelo chamado 974436 (cfe CAT 40/2021)
				Choose Case as_lei_generico
					Case 'G'	// Gen$$HEX1$$e900$$ENDHEX$$rico
						ivo_atributo_nf.pc_trava_iva_st = 80.00
						
						Choose Case as_lista_pis_cofins
							Case "P"  ; lvdc_Fator_PMC	= 3.1419		// 214,19%
							Case "N"  ; lvdc_Fator_PMC	= 3.0414		// 204,14%
							Case Else ; lvdc_Fator_PMC	= 3.1115 	// 211,15%
						End Choose
												
					Case 'S', 'E' // Similar ou equivalente
						ivo_atributo_nf.pc_trava_iva_st = 90.00
						
						Choose Case as_lista_pis_cofins
							Case "P"  ; lvdc_Fator_PMC	= 1.7809		//  78,09%
							Case "N"  ; lvdc_Fator_PMC	= 2.2161		// 121,61%
							Case Else ; lvdc_Fator_PMC	= 1.2576		//  25,76%
						End Choose
						
					Case 'R'	//Refer$$HEX1$$ea00$$ENDHEX$$ncia
						ivo_atributo_nf.pc_trava_iva_st = IIF(as_lista_pis_cofins="P", 95.00, 90.00)
						
						Choose Case as_lista_pis_cofins
							Case "P"  ; lvdc_Fator_PMC	= 1.3311		//  33,11%
							Case "N"  ; lvdc_Fator_PMC	= 1.3291		//  32,91%
							Case Else ; lvdc_Fator_PMC	= 1.1020		//  10,20%
						End Choose		
				
					Case Else
						ivo_atributo_nf.pc_trava_iva_st = 90.00
						
						Choose Case as_lista_pis_cofins
							Case "P"  ; lvdc_Fator_PMC	= 1.3095		//  30,95%
							Case "N"  ; lvdc_Fator_PMC	= 1.3602		//  36,02%
							Case Else ; lvdc_Fator_PMC	= 1.6418		//  64,18%
						End Choose
						
				End Choose
				
			Else
				lvdc_Fator_PMC = 1.6854 // 68,54%
			End If
			
		//OUTROS ESTADOS
		ElseIf ab_Estadual Then
			If adc_Aliq_ICMS_Destino = 17 Then
				Choose Case as_Lista_PIS_COFINS
					Case "P"  ; lvdc_Fator_PMC	= 1.3824
					Case "N"  ; lvdc_Fator_PMC	= 1.3305
					Case Else ; lvdc_Fator_PMC	= 1.4134
				End Choose
			ElseIf adc_Aliq_ICMS_Destino = 18 Then
				Choose Case as_Lista_PIS_COFINS
					Case "P"  ; lvdc_Fator_PMC	= 1.3976
					Case "N"  ; lvdc_Fator_PMC = 1.3431
					Case Else ; lvdc_Fator_PMC	= 1.4285
				End Choose
			Else
				Choose Case as_Lista_PIS_COFINS
					Case "P"  ; lvdc_Fator_PMC	= 1.3824
					Case "N"  ; lvdc_Fator_PMC = 1.3300
					Case Else ; lvdc_Fator_PMC	= 1.4138
				End Choose
			End If
		Else
			If adc_Aliq_ICMS_Destino = 17 Then
				Choose Case as_Lista_PIS_COFINS
					Case "P"  ; lvdc_Fator_PMC	= 1.4656
					Case "N"  ; lvdc_Fator_PMC = 1.4106
					Case Else ; lvdc_Fator_PMC	= 1.4986
				End Choose
			ElseIf adc_Aliq_ICMS_Destino = 18 Then
				Choose Case as_Lista_PIS_COFINS
					Case "P"  ; lvdc_Fator_PMC	= 1.5000
					Case "N"  ; lvdc_Fator_PMC = 1.4533
					Case Else ; lvdc_Fator_PMC	= 1.5330
				End Choose
			Else
				Choose Case as_Lista_PIS_COFINS
					Case "P"  ; lvdc_Fator_PMC	= 1.4835
					Case "N"  ; lvdc_Fator_PMC = 1.4273
					Case Else ; lvdc_Fator_PMC	= 1.5173
				End Choose
			End If
		End If
	End If	
Else
 	This.Of_Log_Calculo("Tipo MVA = Tribut. ICMS ST (conforme Tipo Trib. Produto Farm. no cadastro do produto)")
	If This.of_Tributacao_Produto(ai_Tributacao_Produto, adc_aliq_icms_operacao, Ref lvdc_Fator_PMC_Estadual, Ref lvdc_Fator_PMC_Inter, ref ab_ajusta_mva) Then
		 lvdc_Fator_PMC = IIF(ab_estadual,lvdc_Fator_PMC_Estadual, lvdc_Fator_PMC_Inter)
	Else
		Return 1
	End If
End If

This.Of_Log_Calculo("MVA = "+String((lvdc_Fator_PMC - 1) * 100, "#,##0.00##"))

Return lvdc_Fator_PMC
end function

public function boolean of_tributacao_produto (integer ai_tributacao_produto, decimal adc_aliq_icms_operacao, ref decimal adc_estadual, ref decimal adc_interestadual, ref boolean ab_ajusta_mva);Decimal lvdc_Fator_PMC_Estadual 
Decimal lvdc_Fator_PMC_Inter
Decimal lvdc_Fator_PMC_Fixo

select coalesce(af.pc_mva,t.pc_st_estadual), coalesce(af.pc_mva,t.pc_st_interestadual), af.pc_mva
Into :lvdc_Fator_PMC_Estadual, :lvdc_Fator_PMC_Inter, :lvdc_Fator_PMC_Fixo
from tributa_produtos_farmaceuticos t
left outer join tributa_produtos_farm_mva af
	on af.cd_tributacao_produto = t.cd_tributacao_produto
	and af.pc_icms = :adc_aliq_icms_operacao
Where t.cd_tributacao_produto =:ai_Tributacao_Produto
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	SetNull(lvdc_Fator_PMC_Fixo)
	
	Select pc_st_estadual, 
			pc_st_interestadual
	Into :adc_Estadual, 
		 :adc_Interestadual
	From tributa_produtos_farmaceuticos
	Where cd_tributacao_produto =:ai_Tributacao_Produto
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
		Case 100
			//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o percentual de tributa$$HEX2$$e700e300$$ENDHEX$$o do produto.")
			ivs_mensagem =  "N$$HEX1$$e300$$ENDHEX$$o foi localizado o percentual de tributa$$HEX2$$e700e300$$ENDHEX$$o do produto."
			ivb_Erro = True
			Return False
		Case -1 
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do percentual de tributa$$HEX2$$e700e300$$ENDHEX$$o do produto")
			ivb_Erro = True
			Return False
	End Choose
End If

ab_ajusta_mva 	= (IsNull(lvdc_Fator_PMC_Fixo))
adc_estadual		= lvdc_Fator_PMC_Estadual
adc_interestadual	= lvdc_Fator_PMC_Inter

Return True
end function

public function decimal of_fator_pmc (boolean ab_matriz, long al_produto, string as_uf_origem, string as_uf_destino, decimal adc_aliq_icms_operacao);Decimal lvdc_Pc_Icms_Destino
Decimal lvdc_Red_Base_St

String lvs_Lei_Generico
String lvs_Lista_Pis

Long lvl_Classificao_Fiscal
Long lvl_Trib_Prod

Boolean lvb_Ajusta_MVA

If Not IsValid(ivo_UF_Origem) Then ivo_UF_Origem = Create uo_Unidade_Federacao
If Not IsValid(ivo_UF_Destino) Then ivo_UF_Destino = Create uo_Unidade_Federacao

ivo_UF_Origem.of_Localiza_UF(as_uf_origem)
ivo_UF_Destino.of_Localiza_UF(as_uf_destino)

This.ivs_estadual = IIF(as_uf_origem = as_uf_destino, 'S', 'N')

If ab_matriz Then
	select	c.pc_icms,
			coalesce(b.pc_reducao_base_st, 0),
			a.id_lei_generico,
			a.nr_classificacao_fiscal,
			b.cd_tributacao_produto,
			a.id_situacao_pis_cofins
	Into	:lvdc_Pc_Icms_Destino,
			:lvdc_Red_Base_St,
			:lvs_Lei_Generico,
			:lvl_Classificao_Fiscal,
			:lvl_Trib_Prod,
			:lvs_Lista_Pis
	from produto_geral a
	inner join produto_uf b on b.cd_produto = a.cd_produto
	inner join tipo_icms c on c.cd_tipo_icms = b.cd_tipo_icms
	where	b.cd_unidade_federacao = :as_uf_destino
		and	a.cd_produto = :al_Produto
	Using SqlCa;
Else
	select	b.pc_icms,
			0,
			a.id_lei_generico,
			a.nr_classificacao_fiscal,
			a.cd_tributacao_produto,
			a.id_situacao_pis_cofins
	Into	:lvdc_Pc_Icms_Destino,
			:lvdc_Red_Base_St,
			:lvs_Lei_Generico,
			:lvl_Classificao_Fiscal,
			:lvl_Trib_Prod,
			:lvs_Lista_Pis
	from produto_geral a
	inner join tipo_icms b
		on b.cd_tipo_icms = a.cd_tipo_icms
	where a.cd_produto = :al_Produto
	Using SqlCa;
End If

Return This.Of_Fator_pmc( (This.ivs_estadual = 'S') , &
									lvdc_Pc_Icms_Destino, &
									adc_aliq_icms_operacao, &
									lvs_Lista_Pis, &
									lvs_Lei_Generico, &
									lvl_Trib_Prod, &
									lvl_Classificao_Fiscal, &
									lvdc_Red_Base_St, &
									lvb_Ajusta_MVA)
end function

public function decimal of_ajusta_mva (decimal pdc_mva, decimal pdc_aliq_icms_interestadual, decimal pdc_aliq_icms_interna);Decimal{4} lvdc_Retorno

//MVA Ajustado = MVA * ((1 - (Aliq. ICMS Interestadual / 100)) / ( 1 - ( Aliq. ICMS interna /100) ) )	
This.Of_Log_Calculo("[ MVA Ajustado ] = ( 1 + [ % MVA ] / 100 ) * ( (1 - ( [ Aliq. ICMS Interestadual ] / 100 ) ) / ( 1 - ( [ Aliq. ICMS interna ] / 100 ) ) )")
This.Of_Log_Calculo("[ MVA Ajustado ] = ( 1 + [ "+String(pdc_mva, "#,##0.00##")+" ] / 100 ) * ( (1 - ( [ "+String(pdc_aliq_icms_interestadual, "#,##0.00##")+" ] / 100 ) ) / ( 1 - ( [ "+String(pdc_aliq_icms_interna, "#,##0.00##")+" ] / 100 ) ) )")
This.Of_Log_Calculo("[ MVA Ajustado ] = ( "+String(pdc_mva, "#,##0.00##")+") * ( "+String(1 - (pdc_aliq_icms_interestadual /100), "#,##0.00##")+" ) / ( "+String(1 - (pdc_aliq_icms_interna /100), "#,##0.00##")+" )")
lvdc_Retorno = Round(pdc_mva * ((1 - (pdc_aliq_icms_interestadual /100)) / ( 1 - (pdc_aliq_icms_interna /100))), 4)
This.Of_Log_Calculo("[ MVA Ajustado ] = "+String(lvdc_Retorno, "#,##0.00##")+"~r~n")

Return lvdc_Retorno
end function

public function decimal of_ajusta_mva (integer pl_produto, string ps_uf_destino, integer pdc_mva);Decimal{4} lvdc_Aliquota_ICMS_Estadual
Decimal{4} lvdc_FCP

If Not IsValid(ivo_UF_Destino) Then ivo_UF_Destino = Create uo_Unidade_Federacao
If ps_uf_destino <> ivo_UF_Destino.cd_unidade_federacao Then ivo_UF_Destino.of_Localiza_UF(ps_uf_destino)

This.of_Aliquota_ICMS_Venda(pl_produto, ivo_UF_Destino.Cd_Unidade_Federacao, ref lvdc_Aliquota_ICMS_Estadual, ref lvdc_FCP)

Return This.Of_ajusta_mva( pdc_mva, ivo_UF_Destino.pc_icms_interestadual, lvdc_Aliquota_ICMS_Estadual)
end function

public function boolean of_base_matriz ();Long lvl_filial
Long lvl_filial_matriz

If IsNull(ivl_filial_matriz) or IsNull(ivl_filial) Then
	Select cd_filial, cd_filial_matriz
	Into :lvl_filial, :lvl_filial_matriz
	From parametro
	Where id_parametro = '1'
	Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then
		SQLCa.Of_MsgDbError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o da filial matriz na tabela par$$HEX1$$e200$$ENDHEX$$metro.")
		Return False
	Else
		ivl_filial_matriz	= lvl_filial_matriz
		ivl_filial			= lvl_filial
		ivb_Matriz = (ivl_Filial = ivl_Filial_Matriz or ivl_Filial=2)
	End If
End If

Return (ivb_Matriz)
end function

public function string of_retorna_cst_pis_cofins (long pl_cfop, long pl_produto);String lvs_CST_Pis
String lvs_CST_Cofins
String lvs_Msg

Decimal{4} lvdc_Bc_PIS
Decimal{4} lvdc_Aliq_PIS
Decimal{4} lvdc_PIS
Decimal{4} lvdc_Bc_Cofins
Decimal{4} lvdc_Aliq_Cofins
Decimal{4} lvdc_Cofins

SetNull(lvs_CST_Pis)

If (IsNull(pl_cfop)) or (IsNull(pl_produto)) Then Return lvs_CST_Pis

If Not This.of_retorna_tributacao_pis_cofins( 	pl_cfop			, &
															pl_produto		, &
															0.00				, &
															0.00				, &
															lvs_CST_Pis		, & 
															lvdc_Bc_PIS		, & 
															lvdc_Aliq_PIS	, & 
															lvdc_PIS			, & 
															lvs_CST_Cofins	, &
															lvdc_Bc_Cofins	, & 
															lvdc_Aliq_Cofins, &
															lvdc_Cofins		, &
															True				, &
															lvs_Msg) Then
	SetNull(lvs_CST_Pis)
End If

Return lvs_CST_Pis
end function

private function string of_localiza_tributacao_produto (long pl_produto, string ps_uf);String lvs_Tributacao
String lvs_Tributacao_UF

If This.Of_Base_Matriz() Then
	Select p.cd_tributacao_produto, p. cd_tributacao_icms, coalesce(p.vl_preco_medio_ponderado_cf, 0), coalesce(p.vl_preco_venda_maximo, 0)
	Into :ivi_tributacao_produto, :lvs_Tributacao, :ivo_Atributo_nf.vl_preco_medio_ponderado_cf, :ivo_atributo_nf.vl_preco_maximo_consumidor
	From produto_uf p
	Where p.cd_unidade_federacao 	= :ps_uf
	  and p.cd_produto  		   			= :pl_produto
	Using Sqlca;
Else
	Select p.cd_tributacao_produto, p. cd_tributacao_icms, cast(null as decimal(10,2)) as vl_pmpf, coalesce(p.vl_preco_venda_maximo, 0)
	Into :ivi_tributacao_produto, :lvs_Tributacao, :ivo_Atributo_nf.vl_preco_medio_ponderado_cf, :ivo_atributo_nf.vl_preco_maximo_consumidor
	From produto_geral p
	where p.cd_produto = :pl_produto
	Using Sqlca;
End If

Choose Case SqlCa.SqlCode
	Case 0
		//Mant$$HEX1$$e900$$ENDHEX$$m compatibilidade com antiga vari$$HEX1$$e100$$ENDHEX$$vel
		ivdc_preco_venda_maximo = ivo_atributo_nf.vl_preco_maximo_consumidor
		//Se for transferencia estadual de produto tributado deve considerar a regra da UF
		If ivs_Operacao = TRANSFERENCIA and ivs_Estadual="S" and (lvs_Tributacao = "0") and Len(ivo_uf_destino.cd_cst_transf_tributada)=2 Then
			select cd_tributacao_icms
			Into :lvs_Tributacao_UF
			From tributacao_icms
			Where cd_cst_tributacao = :ivo_uf_destino.cd_cst_transf_tributada
			Using SQLCa;
			
			If SQLCa.SQLCode = -1 Then
				SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da tributa$$HEX2$$e700e300$$ENDHEX$$o de ICMS de transfer$$HEX1$$ea00$$ENDHEX$$ncia na UF "+ivo_uf_destino.cd_unidade_federacao+", na fun$$HEX2$$e700e300$$ENDHEX$$o of_localiza_tributacao_produto().")
				Return ""
			End If
			
			//Se encontrou uma parametriza$$HEX2$$e700e300$$ENDHEX$$o na UF ent$$HEX1$$e300$$ENDHEX$$o utiliza
			If Not IsNull(lvs_Tributacao_UF) and (lvs_Tributacao_UF<>"") Then lvs_Tributacao = lvs_Tributacao_UF
		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar a tributa$$HEX2$$e700e300$$ENDHEX$$o de ICMS do produto.", StopSign!)
		Return ""
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da tributa$$HEX2$$e700e300$$ENDHEX$$o de ICMS do produto, na fun$$HEX2$$e700e300$$ENDHEX$$o of_localiza_tributacao_produto().")
		Return ""
End Choose

Return lvs_Tributacao
end function

public function decimal of_fator_reducao_base_st (long pi_tributacao_produto);Decimal{4} lvdc_PC_Red_St

select coalesce(pc_reducao_base_st,0)
Into :lvdc_PC_Red_St
From tributa_produtos_farmaceuticos
Where cd_tributacao_produto = :pi_tributacao_produto
Using SQLCa;

If IsNull(lvdc_PC_Red_St) Then lvdc_PC_Red_St = 0.00

Return 1 - (lvdc_PC_Red_St / 100)



end function

public function boolean of_calcula_antecipacao_icms (string ps_uf_origem, string ps_uf_destino, long pl_produto, string ps_situacao_tributaria, long pl_quantidade, decimal pdc_valor_produto, decimal pdc_aliq_icms_nf, decimal pdc_valor_icms_nf, ref decimal pdc_base_antecipacao, ref decimal pdc_mva_antecipacao, ref decimal pdc_aliquota_antecipacao, ref decimal pdc_valor_antecipacao);/*********************************************************************************/
/*       Fun$$HEX2$$e700e300$$ENDHEX$$o: of_calcula_antecipacao_icms()																						*/
/*      Objetivo: Verificar a necessidade, calcular e retornar a antecipa$$HEX2$$e700e300$$ENDHEX$$o de ICMS										*/
/*       Cria$$HEX2$$e700e300$$ENDHEX$$o: 02/02/2017																												*/
/* 		    Autor: Marlon Kniss																											*/
/*	   Chamado: 212971																													*/
/*********************************************************************************/
/* Par$$HEX1$$e200$$ENDHEX$$metros:	ps_uf_origem					=> UF Origem Aquisi$$HEX2$$e700e300$$ENDHEX$$o 														*/	
/*                   	ps_uf_destino					=> UF Filial Destino 																*/	
/*                   	pl_produto 	 					=> C$$HEX1$$f300$$ENDHEX$$digo Interno do Produto 													*/	
/*                   	pl_quantidade		  			=> Quantidade do Produto NF 													*/	
/*                   	pdc_valor_produto  			=> Valor Unit$$HEX1$$e100$$ENDHEX$$rio do Produto NF 												*/	
/*                   	pdc_aliq_icms_nf  				=> Al$$HEX1$$ed00$$ENDHEX$$quota ICMS Destacado na NF 											*/	
/*                   	pdc_valor_icms_nf				=> Valor ICMS Destacado na NF												*/	
/*         ref      	pdc_base_antecipacao		=> Base ICMS Antecipa$$HEX2$$e700e300$$ENDHEX$$o 														*/	
/*         ref      	pdc_mva_antecipacao		=> % MVA ICMS Antecipa$$HEX2$$e700e300$$ENDHEX$$o													*/	
/*         ref     	pdc_aliquota_antecipacao	=> Al$$HEX1$$ed00$$ENDHEX$$quota ICMS Antecipa$$HEX2$$e700e300$$ENDHEX$$o													*/	
/*         ref      	pdc_valor_antecipacao		=> Valor ICMS Antecipa$$HEX2$$e700e300$$ENDHEX$$o 													*/	
/**********************************************************************************/
Boolean lvb_Ok

Long lvl_Tipo_Produto
Long lvl_Tipo_Produto_Fiscal

Decimal lvdc_MVA
Decimal lvdc_Pc_ICMS
Decimal lvdc_Pc_FCP

String lvs_antecipa_icms

SetNull(pdc_base_antecipacao)
SetNull(pdc_mva_antecipacao)
SetNull(pdc_aliquota_antecipacao)
SetNull(pdc_valor_antecipacao)

This.Of_Log_Calculo("~r~n************** Antecipa$$HEX2$$e700e300$$ENDHEX$$o de ICMS ******************" )
This.Of_Log_Calculo("Situa$$HEX2$$e700e300$$ENDHEX$$o Tribut$$HEX1$$e100$$ENDHEX$$ria = " + ps_situacao_tributaria)

If (ps_situacao_tributaria = "0") or (ps_situacao_tributaria = "2") Then
	//Verifica se objeto est$$HEX1$$e100$$ENDHEX$$ instanciado
	If Not IsValid(ivo_tipo_produto_fiscal) Then 	ivo_tipo_produto_fiscal = Create uo_tipo_produto_fiscal
	//Grava as UFs de origem e destino
	This.Of_Grava_UF_Origem_Destino( ps_uf_origem, ps_uf_destino)
	//Localiza o tipo de produto no fiscal
	lvb_Ok = ivo_tipo_produto_fiscal.of_tipo_produto_fiscal_uf(	ps_uf_destino				, &
																				pl_produto					, &
																				ps_situacao_tributaria	, &
																				lvl_Tipo_Produto			, &
																				lvl_Tipo_Produto_Fiscal	, &
																				lvs_antecipa_icms			, &
																				lvdc_MVA)
	
	If lvb_Ok Then	
		//Loga valores buscados no tipo produto
		This.Of_Log_Calculo("UF = "+ps_uf_destino)
		This.Of_Log_Calculo("Tipo Produto Calcula Antecipa$$HEX2$$e700e300$$ENDHEX$$o = "+IIF(lvs_antecipa_icms="S", "SIM", "N$$HEX1$$c300$$ENDHEX$$O"))
		This.Of_Log_Calculo("MVA Antecipa$$HEX2$$e700e300$$ENDHEX$$o = "+String(lvdc_MVA, "#,##0.00####"))
		
		//Tem Antecipa$$HEX2$$e700e300$$ENDHEX$$o de ICMS?
		If lvs_antecipa_icms = 'S' Then
			//Busca Al$$HEX1$$ed00$$ENDHEX$$quota ICMS Interna
			lvb_Ok = This.of_Aliquota_ICMS_Venda(pl_produto, ivo_UF_Destino.Cd_Unidade_Federacao, ref lvdc_Pc_ICMS, ref lvdc_Pc_FCP)
			
			If lvb_Ok Then
				This.Of_Log_Calculo("Aliq. ICMS Antecipa$$HEX2$$e700e300$$ENDHEX$$o = "+String(lvdc_Pc_ICMS, "#,##0.00####"))
				This.Of_Log_Calculo("Aliq. FCP Antecipa$$HEX2$$e700e300$$ENDHEX$$o = "+String(lvdc_Pc_FCP, "#,##0.00####"))
				
				//MVA
				If IsNull(lvdc_MVA) Then lvdc_MVA = 0.00
				lvdc_MVA = (lvdc_MVA / 100) + 1
				
				//CHAMADO 306500: Soma al$$HEX1$$ed00$$ENDHEX$$quota ICMS e FCP
				If IsNull(lvdc_Pc_FCP) Then lvdc_Pc_FCP = 0.00
				If IsNull(lvdc_Pc_ICMS) Then lvdc_Pc_ICMS = 0.00
				pdc_aliquota_antecipacao	= lvdc_Pc_ICMS + lvdc_Pc_FCP
				This.Of_Log_Calculo("~r~n[ Aliq. Antecipa$$HEX2$$e700e300$$ENDHEX$$o ] = [ Aliq. ICMS Antecipa$$HEX2$$e700e300$$ENDHEX$$o ] + [ Aliq. FCP Antecipa$$HEX2$$e700e300$$ENDHEX$$o ] ")
				This.Of_Log_Calculo("[ Aliq. Antecipa$$HEX2$$e700e300$$ENDHEX$$o ] = [ "+String(lvdc_Pc_ICMS, "##0.00")+" ] + [ "+String(lvdc_Pc_FCP, "##0.00")+" ] ")
				This.Of_Log_Calculo("[ Aliq. Antecipa$$HEX2$$e700e300$$ENDHEX$$o ] = "+String(pdc_aliquota_antecipacao, "##0.00"))
				
				//Ajusta MVA para opera$$HEX2$$e700f500$$ENDHEX$$es inteestaduais
				If ivs_Estadual = 'N' Then 
					This.Of_Log_Calculo("~r~n< ! > Opera$$HEX2$$e700e300$$ENDHEX$$o interestadual sofre ajuste do MVA")
					lvdc_MVA = This.Of_Ajusta_MVA( lvdc_MVA, pdc_aliq_icms_nf, pdc_aliquota_antecipacao)
				End If
				//C$$HEX1$$e100$$ENDHEX$$lculo
				pdc_mva_antecipacao		= Round((lvdc_MVA - 1) * 100, 4)
				pdc_base_antecipacao		= Round(pdc_valor_produto * lvdc_MVA, 4)
				This.Of_Log_Calculo("~r~n[ Base ICMS Antecipa$$HEX2$$e700e300$$ENDHEX$$o ] = [ Valor L$$HEX1$$ed00$$ENDHEX$$quido Item ] x [ % MVA ]")
				This.Of_Log_Calculo("[ Base ICMS Antecipa$$HEX2$$e700e300$$ENDHEX$$o ] = [ "+String(pdc_valor_produto, "#,###,##0.00##")+" ] x [ "+String(Round((lvdc_MVA - 1) * 100, 4), "##0.00##")+" ]")
				This.Of_Log_Calculo("[ Base ICMS Antecipa$$HEX2$$e700e300$$ENDHEX$$o ] = "+String(pdc_base_antecipacao, "#,###,##0.00##"))

				pdc_valor_antecipacao		= Round((pdc_base_antecipacao * (pdc_aliquota_antecipacao / 100)) - pdc_valor_icms_nf, 4)
				This.Of_Log_Calculo("~r~n[ Valor ICMS Antecipa$$HEX2$$e700e300$$ENDHEX$$o ] = ( [ Base ICMS Antecipa$$HEX2$$e700e300$$ENDHEX$$o ] x [ Aliq. Antecipa$$HEX2$$e700e300$$ENDHEX$$o ] / 100 ) - [ Valor ICMS NF ]")
				This.Of_Log_Calculo("[ Valor ICMS Antecipa$$HEX2$$e700e300$$ENDHEX$$o ] = ( [ "+String(pdc_base_antecipacao, "#,###,##0.00##")+" ] x [ "+ String(pdc_aliquota_antecipacao, "##0.00##") +" ] / 100 ) - [ "+String(pdc_valor_icms_nf, "#,###,##0.00##")+" ]")
				
				If pdc_valor_antecipacao < 0.00 Then 
					This.Of_Log_Calculo("< ! > Valor ICMS Antecipa$$HEX2$$e700e300$$ENDHEX$$o com valor negativo, ser$$HEX1$$e100$$ENDHEX$$ considerado o valor ZERO.")
					pdc_valor_antecipacao = 0.00
				End If
			End If
		End If	
	End If
Else
	This.Of_Log_Calculo("< ! > Antecipa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o calculada devido a situa$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria n$$HEX1$$e300$$ENDHEX$$o ter tributa$$HEX2$$e700e300$$ENDHEX$$o ICMS.")
End If

Return lvb_Ok

end function

public function boolean of_calcula_antecipacao_icms (string ps_uf_origem, string ps_uf_destino, long pl_produto, long pl_quantidade, decimal pdc_valor_produto, decimal pdc_aliq_icms_nf, decimal pdc_valor_icms_nf, ref decimal pdc_base_antecipacao, ref decimal pdc_mva_antecipacao, ref decimal pdc_aliquota_antecipacao, ref decimal pdc_valor_antecipacao);/*********************************************************************************/
/*       Fun$$HEX2$$e700e300$$ENDHEX$$o: of_calcula_antecipacao_icms()																						*/
/*      Objetivo: Verificar a necessidade, calcular e retornar a antecipa$$HEX2$$e700e300$$ENDHEX$$o de ICMS										*/
/*       Cria$$HEX2$$e700e300$$ENDHEX$$o: 02/02/2017																												*/
/* 		    Autor: Marlon Kniss																											*/
/*	   Chamado: 212971																													*/
/*********************************************************************************/
/* Par$$HEX1$$e200$$ENDHEX$$metros:	ps_uf_origem					=> UF Origem Aquisi$$HEX2$$e700e300$$ENDHEX$$o 														*/	
/*                   	ps_uf_destino					=> UF Filial Destino 																*/	
/*                   	pl_produto 	 					=> C$$HEX1$$f300$$ENDHEX$$digo Interno do Produto 													*/	
/*                   	pl_quantidade		  			=> Quantidade do Produto NF 													*/	
/*                   	pdc_valor_produto  			=> Valor Unit$$HEX1$$e100$$ENDHEX$$rio do Produto NF 												*/	
/*                   	pdc_aliq_icms_nf  				=> Al$$HEX1$$ed00$$ENDHEX$$quota ICMS Destacado na NF 											*/	
/*                   	pdc_valor_icms_nf				=> Valor ICMS Destacado na NF												*/	
/*         ref      	pdc_base_antecipacao		=> Base ICMS Antecipa$$HEX2$$e700e300$$ENDHEX$$o 														*/	
/*         ref      	pdc_mva_antecipacao		=> % MVA ICMS Antecipa$$HEX2$$e700e300$$ENDHEX$$o													*/	
/*         ref     	pdc_aliquota_antecipacao	=> Al$$HEX1$$ed00$$ENDHEX$$quota ICMS Antecipa$$HEX2$$e700e300$$ENDHEX$$o													*/	
/*         ref      	pdc_valor_antecipacao		=> Valor ICMS Antecipa$$HEX2$$e700e300$$ENDHEX$$o 													*/	
/**********************************************************************************/
String lvs_Tributacao

//Verifica se esse produto $$HEX1$$e900$$ENDHEX$$ tributado e est$$HEX1$$e100$$ENDHEX$$ fora do ICMS ST
lvs_Tributacao = This.of_localiza_tributacao_produto(pl_produto,ps_uf_destino)

Return This.of_calcula_antecipacao_icms(ps_uf_origem, &
													 ps_uf_destino, &
													 pl_produto, &
													 lvs_Tributacao, &
													 pl_quantidade, &
													 pdc_valor_produto, &
													 pdc_aliq_icms_nf, &
													 pdc_valor_icms_nf, &
													 pdc_base_antecipacao, &
													 pdc_mva_antecipacao, &
													 pdc_aliquota_antecipacao, &
													 pdc_valor_antecipacao)
end function

public function boolean of_set_atributo_fiscal_produto (string ps_situacao_tributaria, decimal pdc_pc_icms, long pl_cfop);//Utilizada na RL058 - Emissao de nf de retirada estoque perini

This.ivo_atributo.cd_situacao_tributaria	= ps_situacao_tributaria
This.ivo_atributo.pc_icms					= pdc_pc_icms
This.ivo_atributo.cd_natureza_operacao	= pl_cfop


Return True

end function

private function boolean of_tributacao_fornecedor (string ps_fornecedor, ref boolean pb_fabricante, ref boolean pb_simples_nacional, ref boolean pb_regime_especial);String lvs_Regime_Trib
String lvs_Atividade
String lvs_Regime_Esp

Long lvl_Matriz
Long lvl_Filial

//Reinicializa vari$$HEX1$$e100$$ENDHEX$$veis do par$$HEX1$$e200$$ENDHEX$$metro
pb_fabricante 			= False
pb_simples_nacional	= False
pb_regime_especial	= False

//Caso o fornecedor seja nulo n$$HEX1$$e300$$ENDHEX$$o faz a consulta
If IsNull(ps_fornecedor) or (ps_fornecedor = "") Then Return True

Select coalesce(f.id_atividade_economica,'0'), coalesce(f.id_regime_tributario,'2'), coalesce(f.id_regime_especial,'N'), p.cd_filial, p.cd_filial_matriz
Into :lvs_Atividade, :lvs_Regime_Trib, :lvs_Regime_Esp, :lvl_Filial, :lvl_Matriz
From fornecedor f
inner Join parametro p 
	on p.id_parametro = '1'
Where f.cd_fornecedor = :ps_fornecedor
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	//Mostra mensagem apenas na matriz, pois na filial ainda n$$HEX1$$e300$$ENDHEX$$o existe o campo
	If lvl_Filial <> lvl_Matriz Then 	SQLCa.Of_MsgDbError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o tributa$$HEX2$$e700e300$$ENDHEX$$o fornecedor." )
 	Return False
End If

pb_fabricante 			= (lvs_Atividade 		= "1")
pb_simples_nacional	= (lvs_Regime_Trib	= "1")
pb_regime_especial	= (lvs_Regime_Esp	= "S")

Return True
end function

public function boolean of_verifica_repasse_icms (long pl_ncm);Integer li_Achou

// Opera$$HEX2$$e700e300$$ENDHEX$$o interestadual
//If ivs_Estadual = "N" Then
//Chamado: 649859
	
	Select count(*)
	Into :li_Achou
	From ncm_situacao_especial n
	Inner join tributacao_icms t
		on t.cd_tributacao_icms = n.cd_tributacao_icms
	Where n.nr_ncm 			= :pl_ncm
	  	and n.cd_uf 				= :ivo_UF_Destino.cd_unidade_federacao
	 	and t.id_icms_normal = 'S'
		and coalesce(n.id_repasse_icms, 'N') = 'S'
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Erro ao verificar se o NCM [" + String(pl_ncm) + "] possui repasse de ICMS.")
		ivb_erro = True
	End If
	
//End If

Return (li_Achou > 0)
end function

public function boolean of_permite_desconto_prestes (long al_filial, long al_produto, boolean ab_mostra_msg, ref long al_tipo_produto_fiscal, ref string as_tipo_operacao);String ls_Tipo_Pemissao, ls_Permissao_dev, ls_Permissao_Transf, ls_DW

Long ll_Retrieve

Boolean lb_Permite_Retirada

Try
	This.ivb_Erro = False
	
	SetNull( al_tipo_produto_fiscal ) 
	SetNull( as_tipo_operacao )
	
	uo_Filial 								lo_Filial
	uo_Produto 							lo_Produto
	uo_ge040_movimento_matriz 	lo_Movimento
	
	lo_Filial 			= Create uo_Filial
	lo_Produto 		= Create uo_Produto
	lo_Movimento 	= Create uo_ge040_movimento_matriz
	
	lo_Filial.Of_localiza_Codigo( al_Filial )
	lo_Produto.of_Localiza_Codigo_Interno( al_Produto )
	
	If Not lo_Filial.localizada		Then Return False
	If Not lo_Produto.localizado	Then Return False
	
	If Not lo_Movimento.of_verifica_movimento_matriz( lo_Filial.cd_Filial, lo_Produto.Cd_Produto ) Then
		This.ivb_Erro = True
		Return False
	End If
		
	If ivb_Matriz Then
		ls_DW = 'ds_ge021_tipo_permissao_matriz'
	Else
		ls_DW = 'ds_ge021_tipo_permissao_filial' 	
	End If
	
	dc_uo_ds_base lo_DS
	lo_DS = Create dc_uo_ds_base
	
	If Not lo_Ds.of_ChangeDataObject( ls_DW ) Then
		This.ivb_Erro = True
 		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento of_ChangeDataObject. Fun$$HEX2$$e700e300$$ENDHEX$$o: uo_tratamento_fiscal.of_permite_retirada_perini(Long, Long, Boolean, ref Long)", StopSign! )
		Return False	 
	End If
	
	//Inicio
	lb_Permite_Retirada = True

	ll_Retrieve = lo_Ds.Retrieve( lo_Produto.nr_classificacao_fiscal, lo_Filial.cd_unidade_federacao )
	
	Choose Case ll_Retrieve
		Case is < 0
			This.ivb_Erro = True
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no retrieve. Fun$$HEX2$$e700e300$$ENDHEX$$o: uo_tratamento_fiscal.of_permite_retirada_perini(Long, Long, Boolean, ref Long)" , StopSign!)
			Return False	
			
		Case 0
			lb_Permite_Retirada = False
			
		Case is > 0
			If lo_Movimento.Tipo_Operacao = 'D' Then
				ls_Tipo_Pemissao = lo_Ds.Object.id_permissao_devolucao		[ 1 ]  
			Else
				ls_Tipo_Pemissao = lo_Ds.Object.id_permissao_transferencia	[ 1 ]  
			End If
			
			//Nenhum
			If ls_Tipo_Pemissao = 'N' Then
				lb_Permite_Retirada = False
			End If
			
			//Somente sem ST
			If ls_Tipo_Pemissao = 'I' AND lo_Produto.Cd_Tributacao_ICMS = '1' Then 
				lb_Permite_Retirada = False
			End If	
			
			al_Tipo_Produto_Fiscal	= lo_Ds.Object.cd_tipo_produto_fiscal	[ 1 ]		
	End Choose

	If Not lb_Permite_Retirada Then
		If ab_Mostra_Msg Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto n$$HEX1$$e300$$ENDHEX$$o pode ser "+ IIF( lo_Movimento.Tipo_Operacao="D", "devolvido", "transferido") + " para o Perini devido $$HEX1$$e000$$ENDHEX$$ regra fiscal.~r~r" +&
										"C$$HEX1$$f300$$ENDHEX$$digo: " + String(lo_Produto.cd_Produto) + "~r" +&
										"Descri$$HEX2$$e700e300$$ENDHEX$$o: " + lo_Produto.ivs_Descricao_Apresentacao_Venda + "~r" +&
										"NCM: " + String(lo_Produto.nr_Classificacao_Fiscal) , Exclamation!)
		End If
	End If
	
	as_tipo_operacao = lo_Movimento.Tipo_Operacao	
	
	Return lb_Permite_Retirada
Finally	
	If IsValid( lo_DS ) 				Then Destroy lo_DS
	If IsValid( lo_Filial ) 			Then Destroy lo_Filial
	If IsValid( lo_Produto )	 	Then Destroy lo_Produto
	If IsValid( lo_Movimento ) 	Then Destroy lo_Movimento
End Try
end function

public function boolean of_permite_retirada_perini (string as_tipo_retirada, long al_filial, long al_produto, boolean ab_mostra_msg, ref long al_tipo_produto_fiscal, ref string as_tipo_operacao);String ls_Id_Possui_Acordo

SetNull(ls_Id_Possui_Acordo)

Return This.of_Permite_Retirada_Perini(as_Tipo_Retirada, al_Filial, al_Produto, ab_Mostra_Msg, ls_Id_Possui_Acordo, Ref al_Tipo_Produto_Fiscal, Ref as_Tipo_Operacao)
end function

public function boolean of_aliquota_icms_ncm (long pl_ncm, string ps_uf, ref decimal pdc_aliq_icms, ref decimal pdc_aliq_fcp);//Utilizado para c$$HEX1$$e100$$ENDHEX$$lculo do DIFA em compras de uso consumo e ativos
Decimal{4} lvdc_ICMS, lvdc_FCP

SetNull(pdc_aliq_icms)
SetNull(pdc_aliq_fcp)

select t.pc_icms, coalesce(t.pc_fcp ,0)
Into :lvdc_ICMS, :lvdc_FCP
from ncm_situacao_especial n
inner join tipo_icms t
	on t.cd_tipo_icms = n.cd_tipo_icms
where n.nr_ncm = :pl_ncm 
	and n.cd_uf = :ps_uf 
	and n.id_padrao = 'S'
Using SQLCa;

Choose Case SQLCa.SQLCode
	Case -1
		SQLCa.Of_msgdberror("Localiza$$HEX2$$e700e300$$ENDHEX$$o al$$HEX1$$ed00$$ENDHEX$$quota ICMS por NCM.~rFun$$HEX2$$e700e300$$ENDHEX$$o: uo_tratamento_fiscal.of_aliquota_icms_ncm()")
		Return False
		
	Case 100
		select u.pc_icms_estadual,  0.00
		Into :lvdc_ICMS, :lvdc_FCP
		from unidade_federacao u
		Where u.cd_unidade_federacao = :ps_uf
		Using SQLCa;	
		
		If SQLCa.SQLCode = -1 Then
			SQLCa.Of_MsgDBError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o al$$HEX1$$ed00$$ENDHEX$$quota UF "+ps_uf+".~rFun$$HEX2$$e700e300$$ENDHEX$$o: uo_tratamento_fiscal.of_aliquota_icms_ncm()" )
			Return False
		End If
		
End Choose

pdc_aliq_icms = lvdc_ICMS
pdc_aliq_fcp = lvdc_FCP

Return True
end function

public function boolean of_calcula_difa (long pl_ncm, string ps_uf_origem, string ps_uf_destino, string ps_origem_produto, decimal pdc_valor_operacao, decimal pdc_aliq_icms_nf, decimal pdc_valor_icms_nf, ref decimal pdc_base_difa, ref decimal pdc_aliq_difa, ref decimal pdc_valor_difa);Decimal{2} lvdc_Aliq_Interestadual
Decimal{2} lvdc_Aliq_Interna_UF
Decimal{2} lvdc_Aliq_Interna_Prod
Decimal{2} lvdc_Aliq_Interna_FCP
Decimal{2} lvdc_Min_Retencao

String lvs_Tipo_Difa

//Opera$$HEX2$$e700e300$$ENDHEX$$o estadual n$$HEX1$$e300$$ENDHEX$$o tem DIFA
If ps_uf_destino = ps_uf_origem Then
	SetNull(pdc_base_difa)
	SetNull(pdc_aliq_difa)
	SetNull(pdc_valor_difa)
	
Else
	//Busca as al$$HEX1$$ed00$$ENDHEX$$quotas ICMS aplic$$HEX1$$e100$$ENDHEX$$veis a UF e origem do produto
	select case when coalesce(c.id_considera_pc_uf,'S') = 'S' then u.pc_icms_interestadual else c.pc_icms_interestadual end as pc_interestadual,
			u.pc_icms_estadual,
			u.id_tipo_calculo_difa,
			coalesce(u.vl_retencao_minimo_difa,0) as vl_retencao_minimo_difa
	Into :lvdc_Aliq_Interestadual, :lvdc_Aliq_Interna_UF, :lvs_Tipo_Difa, :lvdc_Min_Retencao
	from cst_origem c, unidade_federacao u
	Where u.cd_unidade_federacao = :ps_uf_destino
		And c.cd_st_origem = :ps_origem_produto
	Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then
		SQLCa.Of_MsgDBError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o al$$HEX1$$ed00$$ENDHEX$$quota UF "+ps_uf_destino+".~rFun$$HEX2$$e700e300$$ENDHEX$$o: uo_tratamento_fiscal.of_calcula_difa()" )
		Return False
	
	//Caso n$$HEX1$$e300$$ENDHEX$$o encontre na primeira busca com a origem do produto
	ElseIf SQLCa.SQLCode = 100 Then
		
		select u.pc_icms_interestadual as pc_interestadual,
				u.pc_icms_estadual,
				coalesce(u.vl_retencao_minimo_difa,0) as vl_retencao_minimo_difa
		Into :lvdc_Aliq_Interestadual, :lvdc_Aliq_Interna_UF, :lvdc_Min_Retencao
		from unidade_federacao u
		Where u.cd_unidade_federacao = :ps_uf_destino
		Using SQLCa;	
		
		If SQLCa.SQLCode = -1 Then
			SQLCa.Of_MsgDBError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o al$$HEX1$$ed00$$ENDHEX$$quota UF "+ps_uf_destino+".~rFun$$HEX2$$e700e300$$ENDHEX$$o: uo_tratamento_fiscal.of_calcula_difa()" )
			Return False
		End If
	End If
	
	//Para as notas de uso/consumo e ativo normalmente n$$HEX1$$e300$$ENDHEX$$o tem c$$HEX1$$f300$$ENDHEX$$digo de produto
	This.of_Aliquota_ICMS_NCM(pl_ncm, ps_uf_destino, lvdc_Aliq_Interna_Prod, lvdc_Aliq_Interna_FCP)
	
	If IsNull(lvdc_Min_Retencao) Then lvdc_Min_Retencao = 0.00
	
	//Caso haja al$$HEX1$$ed00$$ENDHEX$$quota de ICMS na nota, o sistema deve considerar a al$$HEX1$$ed00$$ENDHEX$$quota destacada
	If Not IsNull(pdc_aliq_icms_nf) and (pdc_aliq_icms_nf > 0.00) Then
		lvdc_Aliq_Interestadual = pdc_aliq_icms_nf
	End If
	
	Choose Case lvs_Tipo_Difa
		Case '1'  // COMPOSTO (BAHIA, RIO GRANDE DO SUL)
			//Caso n$$HEX1$$e300$$ENDHEX$$o haja ICMS destacado, calcula quanto seria o destaque para creditar-se no final do c$$HEX1$$e100$$ENDHEX$$lculo
			If IsNull(pdc_valor_icms_nf) or (pdc_valor_icms_nf = 0.00) Then			
				pdc_valor_icms_nf = Round(pdc_valor_operacao * (lvdc_Aliq_Interestadual / 100), 2)
			End If
			
			pdc_valor_difa	= Round( ( ( ( pdc_valor_operacao - pdc_valor_icms_nf ) / (1 - (lvdc_Aliq_Interna_Prod / 100) ) * lvdc_Aliq_Interna_Prod / 100 ) ) - pdc_valor_icms_nf , 2)
			If pdc_valor_difa > 0.00 Then
				pdc_base_difa	= pdc_valor_operacao
				pdc_aliq_difa	= Round( ( pdc_valor_difa / pdc_base_difa ) * 100, 2)
			Else
				pdc_base_difa	= 0.00
				pdc_aliq_difa	= 0.00
			End If	
			
		Case '2' //C$$HEX1$$c100$$ENDHEX$$LCULO SIMPLES (SANTA CATARINA)
			If lvdc_Aliq_Interna_UF > lvdc_Aliq_Interestadual Then
				pdc_base_difa	= pdc_valor_operacao
				pdc_aliq_difa	= ( lvdc_Aliq_Interna_UF - lvdc_Aliq_Interestadual )
				pdc_valor_difa	= Round( pdc_valor_operacao * ( ( lvdc_Aliq_Interna_UF - lvdc_Aliq_Interestadual ) / 100), 2)
			Else
				pdc_base_difa	= 0.00
				pdc_aliq_difa	= 0.00
				pdc_valor_difa	= 0.00
			End If
			
		Case '3' // COMPOSTO (PARAN$$HEX1$$c100$$ENDHEX$$)
			//Caso n$$HEX1$$e300$$ENDHEX$$o haja ICMS destacado, calcula quanto seria o destaque para creditar-se no final do c$$HEX1$$e100$$ENDHEX$$lculo
			If IsNull(pdc_valor_icms_nf) or (pdc_valor_icms_nf = 0.00) Then			
				pdc_valor_icms_nf = Round(pdc_valor_operacao * (lvdc_Aliq_Interestadual / 100), 2)
			End If
			
			pdc_valor_difa = ((( pdc_valor_operacao - pdc_valor_icms_nf ) * ( (lvdc_Aliq_Interna_Prod + lvdc_Aliq_Interna_FCP) / 100 )) + pdc_valor_operacao - pdc_valor_icms_nf) * ( (lvdc_Aliq_Interna_Prod + lvdc_Aliq_Interna_FCP) / 100 ) - pdc_valor_icms_nf

			If pdc_valor_difa > 0.00 Then
				pdc_base_difa	= pdc_valor_operacao
				pdc_aliq_difa	= Round( ( pdc_valor_difa / pdc_base_difa ) * 100, 2)
			Else
				pdc_base_difa	= 0.00
				pdc_aliq_difa	= 0.00
			End If	
			
	End Choose
	
	If pdc_valor_difa < 0.00 Then pdc_valor_difa = 0.00
End If

//Caso o valor seja inferior ao valor m$$HEX1$$ed00$$ENDHEX$$nimo de reten$$HEX2$$e700e300$$ENDHEX$$o da UF o sistema n$$HEX1$$e300$$ENDHEX$$o deve calcular DIFA
If (lvdc_Min_Retencao > 0.00) and (lvdc_Min_Retencao > pdc_valor_difa ) Then
	pdc_base_difa	= 0.00
	pdc_aliq_difa	= 0.00
	pdc_valor_difa	= 0.00
End If

Return True
end function

public function boolean of_calcula_icms_efetivo (long pl_produto, string ps_cst_tributacao, long pl_tipo_icms, long pl_quantidade, decimal pdc_vl_unitario_praticado, ref decimal pdc_pc_red_bc_icms_efetivo, ref decimal pdc_bc_icms_efetivo, ref decimal pdc_pc_icms_efetivo, ref decimal pdc_vl_icms_efetivo);Try
	SetNull(pdc_pc_red_bc_icms_efetivo)
	SetNull(pdc_bc_icms_efetivo)
	SetNull(pdc_pc_icms_efetivo)
	SetNull(pdc_vl_icms_efetivo)
	
	If ps_cst_tributacao = "60" Then
		select coalesce(pc_icms,0) + coalesce(pc_fcp,0)
		Into :pdc_pc_icms_efetivo
		from tipo_icms
		Where cd_tipo_icms = :pl_tipo_icms
		Using SQLCa;
		
		If SQLCa.SQLCode = -1 Then
			SQLCa.Of_Msgdberror( "Falha na localiza$$HEX2$$e700e300$$ENDHEX$$o do percentual de ICMS para o tipo icms "+String(pl_tipo_icms) )
			Return False
		End If
		
		pdc_pc_red_bc_icms_efetivo	= 0.00
		pdc_bc_icms_efetivo				= Round(pdc_vl_unitario_praticado * pl_quantidade * (1 - pdc_pc_red_bc_icms_efetivo / 100) , 2)
		pdc_vl_icms_efetivo				= Round(pdc_bc_icms_efetivo * pdc_pc_icms_efetivo / 100, 2)
		If IsNull(pdc_vl_icms_efetivo) Or pdc_vl_icms_efetivo = 0.00 Then
			pdc_vl_icms_efetivo = 0.01
		End If		
	End If
	
Catch (RuntimeError lvo_Erro)
	MessageBox('Erro', "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+"."+lvo_Erro.RoutineName+"().~r"+lvo_Erro.GetMessage(), StopSign!)
Finally
	
End Try

Return True
end function

public function decimal of_base_st (uo_produto ao_produto, decimal adc_preco_liquido, decimal adc_red_base_st, string as_lista_pis_cofins, decimal adc_aliquota_icms, decimal adc_ip);Return This.of_base_st(ao_produto, adc_preco_liquido, adc_red_base_st, as_lista_pis_cofins, adc_aliquota_icms, adc_ip, False)
end function

public function decimal of_base_st (uo_produto ao_produto, decimal adc_preco_liquido, decimal adc_red_base_st, string as_lista_pis_cofins, decimal adc_aliquota_icms, decimal adc_ipi, boolean ab_nao_ajusta_mva);Decimal{4} 	lvdc_Fator_PMC, lvdc_Base_ST_Farmacia_Popular

Decimal{4}	lvdc_Retorno, lvdc_PMC, lvdc_PMPF, lvdc_Vl_Trava

Decimal lvdc_Nulo, lvdc_Aliquota_ICMS_Estadual, ldc_FCP

Boolean lvb_Estadual = True
Boolean lvb_Ajusta_MVA = False

If IsNull(adc_ipi) Then  adc_ipi = 0.00
lvb_Estadual = (This.ivs_Estadual = "N")
SetNull(lvdc_Nulo)
	
// Busca o PMC do produto
lvdc_PMC	= This.of_PMC(ao_Produto)
// Busca o pre$$HEX1$$e700$$ENDHEX$$o m$$HEX1$$e900$$ENDHEX$$dio ponderado do produto
lvdc_PMPF	= This.of_PMPF(ao_Produto)
//Busca Valor refer$$HEX1$$ea00$$ENDHEX$$ncia do programa "Aqui Tem Farmacia Popular"
lvdc_Base_ST_Farmacia_Popular 			= 0.00
If ivs_filial_farmacia_popular = 'S' Then
	If Not This.of_Base_ST_Farmacia_Popular(ao_Produto.cd_produto, ref lvdc_Base_ST_Farmacia_Popular) Then
		ivb_Erro = True
	End If
	This.Of_Log_Calculo("Base ST Farm. Popular = "+String(lvdc_Base_ST_Farmacia_Popular, "##0.00####"))
End If

If ivb_Matriz and ivo_UF_Destino.cd_unidade_federacao = 'PR' Then
	If idt_Movimento <= Date('31/05/2020') Then
		If ao_Produto.id_caderno_abcfarma = 'S' and ivi_Tributacao_Produto = 0 and lvdc_PMC >= adc_preco_liquido Then
			ivdc_preco_venda_maximo 	= lvdc_PMC
			lvdc_PMC 						= 0.00
			adc_red_base_st 				= 0.00
			ib_Decreto_Temp_PR 		= True
		ElseIf ivi_Tributacao_Produto = 0 Then
			adc_red_base_st 				= 0.00
			ib_Decreto_Temp_PR 		= True
		End If		
	End If
End If

//Chamado 974436: S$$HEX1$$e300$$ENDHEX$$o Paulo existe o c$$HEX1$$e100$$ENDHEX$$lculo da trava, que pode substituir a base de PMPF para IVA-ST
If ivb_Matriz and lvdc_PMPF > 0 and ivo_UF_Destino.cd_unidade_federacao = 'SP' Then
	//Busca o MVA e % Trava
	lvdc_Fator_PMC = This.of_Fator_PMC(lvb_Estadual, ivo_UF_Destino.Pc_ICMS_Estadual, adc_aliquota_icms, as_Lista_PIS_COFINS, ao_Produto.id_lei_generico, ivi_Tributacao_Produto, ao_Produto.nr_classificacao_fiscal, adc_red_base_st, ref lvb_Ajusta_MVA)
	
	//Possui trava informada?
	If ivo_atributo_nf.pc_trava_iva_st > 0 Then
		//Se n$$HEX1$$e300$$ENDHEX$$o for opera$$HEX2$$e700e300$$ENDHEX$$o estadual, precisa ajustar a trava
		If This.ivs_Estadual = "N" Then
			// Transferencias originadas da matriz(logistica)
			If ivl_Filial = ivl_filial_matriz Then
				This.of_Aliquota_ICMS_Venda(ao_Produto.cd_produto, ivo_UF_Destino.Cd_Unidade_Federacao, ref lvdc_Aliquota_ICMS_Estadual, ref ldc_FCP)
				//Soma FCP se houver na UF e tiver habilitado 
				If (This.ivs_Operacao <> TRANSFERENCIA) or (This.ivs_Operacao = TRANSFERENCIA and ivo_UF_Destino.id_transf_soma_fcp = 'S' ) Then
					lvdc_Aliquota_ICMS_Estadual = lvdc_Aliquota_ICMS_Estadual + ldc_FCP
				End If
			Else
				lvdc_Aliquota_ICMS_Estadual = ivo_UF_Destino.Pc_ICMS_Estadual
			End If
			
			//Trava ajustada = (Trava original) x [(1 - ALQ intra) / (1 - ALQ inter)]
			This.Of_Log_Calculo("[ Trava Ajustada ] = ( 1 + [ Trava original ] / 100 ) * ( (1 - ( [ Aliq. ICMS interna ] / 100 ) ) / ( 1 - ( [ Aliq. ICMS Interestadual ] / 100 ) ) )")
			This.Of_Log_Calculo("[ Trava Ajustada ] = ( 1 + [ "+String(ivo_atributo_nf.pc_trava_iva_st, "#,##0.00##")+" ] / 100 ) * ( (1 - ( [ "+String(lvdc_Aliquota_ICMS_Estadual, "#,##0.00##")+" ] / 100 ) ) / ( 1 - ( [ "+String(adc_aliquota_icms, "#,##0.00##")+" ] / 100 ) ) )")
			This.Of_Log_Calculo("[ Trava Ajustada ] = ( "+String(ivo_atributo_nf.pc_trava_iva_st, "#,##0.00##")+") * ( "+String(1 - (lvdc_Aliquota_ICMS_Estadual /100), "#,##0.00##")+" ) / ( "+String(1 - (adc_aliquota_icms /100), "#,##0.00##")+" )")
			ivo_atributo_nf.pc_trava_iva_st = Round(ivo_atributo_nf.pc_trava_iva_st * ((1 - (lvdc_Aliquota_ICMS_Estadual /100)) / ( 1 - (adc_aliquota_icms  /100))), 4)
			This.Of_Log_Calculo("[ Trava Ajustada ] = "+String(ivo_atributo_nf.pc_trava_iva_st, "#,##0.00##"))
		End If
		
		This.Of_Log_Calculo("~r~n[ Valor Trava ] = [ PMPF ] x [ Trava ] /100")
		This.Of_Log_Calculo("[ Valor Trava ] = [ "+String(lvdc_PMPF, "#,##0.00##")+" ] x [ "+String(ivo_atributo_nf.pc_trava_iva_st, "#,##0.00##")+" ] /100")
		lvdc_Vl_Trava = round(lvdc_PMPF * ivo_atributo_nf.pc_trava_iva_st / 100, 4)
		This.Of_Log_Calculo("[ Valor Trava ] = "+String(lvdc_Vl_Trava, "#,##0.00##"))
		
		//Verifica se o valor da opera$$HEX2$$e700e300$$ENDHEX$$o for superior ao PMPF (pre$$HEX1$$e700$$ENDHEX$$o m$$HEX1$$e900$$ENDHEX$$dio ponderado) x Trava
		If adc_preco_liquido > lvdc_Vl_Trava Then
			This.Of_Log_Calculo("~r~n< ! > Valor da Opera$$HEX2$$e700e300$$ENDHEX$$o [ "+String(adc_preco_liquido, "#,###,##0.00##")+" ] $$HEX1$$e900$$ENDHEX$$ superior ao produto do valor ponderado x trava [ "+String(lvdc_Vl_Trava, "#,###,##0.00##")+" ], ent$$HEX1$$e300$$ENDHEX$$o o valor ponderado zer$$HEX1$$e100$$ENDHEX$$ zerado para n$$HEX1$$e300$$ENDHEX$$o ser utilizado como base ST. ")
			lvdc_PMPF = 0.00
		End If
	Else
		This.Of_Log_Calculo("~r~n< ! > Valor da trava est$$HEX1$$e100$$ENDHEX$$ zerado para essa lista PIS e lei gen$$HEX1$$e900$$ENDHEX$$rico, para alterar acesse 'Cadastro --> ICMS ST --> Tributa$$HEX2$$e700e300$$ENDHEX$$o ICMS ST'. ")			
	End If
End If

If lvdc_Base_ST_Farmacia_Popular > 0 Then
	ivo_atributo_nf.vl_preco_medio_ponderado_cf 	= 0.00
	lvdc_Retorno											= lvdc_Base_ST_Farmacia_Popular
	ivo_atributo_nf.cd_mod_bc_st						= '0' //0=Base ST por Pre$$HEX1$$e700$$ENDHEX$$o tabelado
	ivb_base_pmc											= False
	This.Of_Log_Calculo("~r~nTipo Determina$$HEX2$$e700e300$$ENDHEX$$o Base ST = Pre$$HEX1$$e700$$ENDHEX$$o 'Aqui Tem Farm$$HEX1$$e100$$ENDHEX$$cia Popular'")
	This.Of_Log_Calculo("[ Base ICMS ST ] = [ Pre$$HEX1$$e700$$ENDHEX$$o Farm$$HEX1$$e100$$ENDHEX$$cia Popular ]")
	This.Of_Log_Calculo("[ Base ICMS ST ] = [ "+String(lvdc_Base_ST_Farmacia_Popular, "#,###,##0.00##")+" ]")
	
	If ivi_Tributacao_Produto = 0 Then
		If gf_coalesce(ivdc_preco_venda_maximo, 0) <> gf_coalesce(lvdc_Base_ST_Farmacia_Popular, 0) Then This.Of_Log_Calculo("~r~n< ! > PMC = "+String(lvdc_Base_ST_Farmacia_Popular, "##0.00####")+" (alterado para considerar o PMC igual a base Farm. Pop.)")
		ivdc_preco_venda_maximo 							= lvdc_Base_ST_Farmacia_Popular
		ivo_atributo_nf.vl_preco_maximo_consumidor	= ivdc_preco_venda_maximo
	End If

//Chamado 966799-3: Possui Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$e900$$ENDHEX$$dio Ponderado $$HEX1$$e000$$ENDHEX$$ Consumidor Final
ElseIf lvdc_PMPF > 0 Then
	lvdc_Retorno											= lvdc_PMPF
	ivo_Atributo_NF.vl_preco_medio_ponderado_cf	= lvdc_PMPF
	ivdc_preco_venda_maximo							= IIF(ivi_Tributacao_Produto = 0 and ao_Produto.id_caderno_abcfarma = 'S', lvdc_PMC, 0.00)
	ivo_Atributo_NF.vl_preco_maximo_consumidor	= ivdc_preco_venda_maximo
	ivo_Atributo_NF.cd_mod_bc_st						= "5" //5 - Pauta
	This.Of_Log_Calculo("~r~nTipo Determina$$HEX2$$e700e300$$ENDHEX$$o Base ST = PMPF")
	This.Of_Log_Calculo("[ Base ICMS ST ] = [ Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$e900$$ENDHEX$$dio Ponderado Cons. Final (PMPF) ]")
	This.Of_Log_Calculo("[ Base ICMS ST ] = [ "+String(ivo_Atributo_NF.vl_preco_medio_ponderado_cf, "#,###,##0.00##")+" ]")

//Para SP n$$HEX1$$e300$$ENDHEX$$o calcula por PMC, o IVA-ST $$HEX1$$e900$$ENDHEX$$ utilizado primeiro, somente utiliza o PMC caso  o valor exceda o PMC
ElseIf ao_Produto.id_caderno_abcfarma = 'S' and ivi_Tributacao_Produto = 0 and lvdc_PMC >= adc_preco_liquido and  ivo_UF_Destino.cd_unidade_federacao <> 'SP' Then
	ivb_base_pmc 											= True
	lvdc_Retorno 											= lvdc_PMC
	ivdc_preco_venda_maximo							= lvdc_PMC
	ivo_Atributo_NF.vl_preco_maximo_consumidor	= ivdc_preco_venda_maximo
	ivo_Atributo_NF.cd_mod_bc_st						= "0" //0 - Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$e100$$ENDHEX$$ximo ou Tabelado
	This.Of_Log_Calculo("~r~nTipo Determina$$HEX2$$e700e300$$ENDHEX$$o Base ST = PMC")
	This.Of_Log_Calculo("[ Base ICMS ST ] = [ Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$e100$$ENDHEX$$ximo Venda ao Consumidor (PMC) ]")
	This.Of_Log_Calculo("[ Base ICMS ST ] = [ "+String(ivo_Atributo_NF.vl_preco_maximo_consumidor, "#,###,##0.00##")+" ]")
	
Else
	This.Of_Log_Calculo("~r~nTipo Determina$$HEX2$$e700e300$$ENDHEX$$o Base ST = MVA")	
	lvdc_Fator_PMC = This.of_Fator_PMC(lvb_Estadual, ivo_UF_Destino.Pc_ICMS_Estadual, adc_aliquota_icms, as_Lista_PIS_COFINS, ao_Produto.id_lei_generico, ivi_Tributacao_Produto, ao_Produto.nr_classificacao_fiscal, adc_red_base_st, ref lvb_Ajusta_MVA)

	If (lvb_Ajusta_MVA) and (This.ivs_Estadual = "N") and (Not ab_nao_ajusta_mva) Then

		// Transferencias originadas da matriz(logistica)
		If ivl_Filial = ivl_filial_matriz Then
			This.of_Aliquota_ICMS_Venda(ao_Produto.cd_produto, ivo_UF_Destino.Cd_Unidade_Federacao, ref lvdc_Aliquota_ICMS_Estadual, ref ldc_FCP)
			// Chamado ServiceDesk:118907
			// Somar o percentual do FCP na aliquota de ICMS de venda no destino 
			// Obs.: Conforme orienta$$HEX2$$e700e300$$ENDHEX$$o do Fernando Correa n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ para alterar nas transf originadas das lojas.
			If (This.ivs_Operacao <> TRANSFERENCIA) or (This.ivs_Operacao = TRANSFERENCIA and ivo_UF_Destino.id_transf_soma_fcp = 'S' ) Then
				lvdc_Aliquota_ICMS_Estadual = lvdc_Aliquota_ICMS_Estadual + ldc_FCP
			End If
		Else
			lvdc_Aliquota_ICMS_Estadual = ivo_UF_Destino.Pc_ICMS_Estadual
		End If
			
		//MVA Ajustado = MVA * ((1 $$HEX1$$1320$$ENDHEX$$ (aliq. ICMS Interestadual/100)) /(1-(aliq. ICMS interna /100)))
		lvdc_Fator_PMC = This.Of_Ajusta_MVA( lvdc_Fator_PMC, adc_aliquota_icms, lvdc_Aliquota_ICMS_Estadual)
	End If

	ivo_Atributo_NF.vl_mva 			= lvdc_Fator_PMC
	ivo_Atributo_NF.cd_mod_bc_st	= "4" //MVA
	lvdc_Retorno 						= Round((adc_preco_liquido + adc_ipi) * lvdc_Fator_PMC, 4)
	This.Of_Log_Calculo("[ Base ICMS ST ] = ( [ Pre$$HEX1$$e700$$ENDHEX$$o L$$HEX1$$ed00$$ENDHEX$$quido Item ] + [ Valor IPI ] ) * ( 1 + [ % MVA ] / 100)")
	This.Of_Log_Calculo("[ Base ICMS ST ] = ( [ "+String(adc_preco_liquido, "#,###,##0.00##")+" ] + [ "+String(adc_ipi, "#,###,##0.00##")+" ] ) * ( 1 + [ "+String((lvdc_Fator_PMC - 1) * 100, "#,###,##0.00##")+" ] / 100)")
	This.Of_Log_Calculo("[ Base ICMS ST ] = ( "+String(adc_preco_liquido + gf_coalesce(adc_ipi, 0), "#,###,##0.00##")+" ) * ( "+String((lvdc_Fator_PMC - 1) * 100, "#,###,##0.00##")+" )")
	This.Of_Log_Calculo("[ Base ICMS ST ] = "+String(lvdc_Retorno, "#,###,##0.00##"))
End If

//Se o produto possui PMC a base ST nunca deve exceder o valor do PMC
If lvdc_PMC > 0 and lvdc_Retorno > lvdc_PMC Then
	This.Of_Log_Calculo("~r~n< ! > Valor base ST [ "+String(lvdc_Retorno, "#,###,##0.00##")+" ] excedeu o valor do PMC [ "+String(lvdc_PMC, "#,###,##0.00##")+" ], e o produto n$$HEX1$$e300$$ENDHEX$$o pode ser comercializado com base superior ao PMC.")
	ivb_base_pmc 											= True
	lvdc_Retorno 											= lvdc_PMC
	ivdc_preco_venda_maximo							= lvdc_PMC
	ivo_Atributo_NF.vl_preco_maximo_consumidor	= ivdc_preco_venda_maximo
	ivo_Atributo_NF.vl_mva 								= 0.00
	ivo_Atributo_NF.vl_preco_medio_ponderado_cf	= 0.00
	ivo_Atributo_NF.cd_mod_bc_st						= "0" //0 - Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$e100$$ENDHEX$$ximo ou Tabelado
	This.Of_Log_Calculo("~r~nTipo Determina$$HEX2$$e700e300$$ENDHEX$$o Base ST = PMC")
	This.Of_Log_Calculo("[ Base ICMS ST ] = [ Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$e100$$ENDHEX$$ximo Venda ao Consumidor (PMC) ]")
	This.Of_Log_Calculo("[ Base ICMS ST ] = [ "+String(ivo_Atributo_NF.vl_preco_maximo_consumidor, "#,###,##0.00##")+" ]")
End If

Return lvdc_Retorno
end function

public subroutine of_calcula_icms_st (uo_produto po_produto, long al_qtde, decimal adc_aliquota_icms, boolean lvb_forn_simples);String ls_Utiliza_Aliquota_InterEstadual

Decimal	lvdc_Aliquota_Venda,&
			lvdc_Valor_ICMS_ST,&
			lvdc_Aliquota_InterEstadual_Importados,&
			ldc_PC_FCP

Decimal{4}  lvdc_Valor_PMC,&
				lvdc_Valor_Deducao,&
				lvdc_Valor_ICMS_ST_PRD,&
				lvdc_Valida_PMC_ICMS_ST

// Filiais
If ivl_filial <> ivl_filial_matriz Then
	ivo_Atributo_NF.PC_ICMS_ST = ivo_UF_Destino.Pc_ICMS_Estadual
	This.Of_Log_Calculo( "~r~n[ Aliq. ICMS ST ] = "+String(ivo_Atributo_NF.PC_ICMS_ST, "##0.00##") )
	
	lvdc_Valor_PMC = Round(This.ivdc_Base_PMC_ST * (ivo_Atributo_NF.PC_ICMS_ST / 100), 4)
	This.Of_Log_Calculo( "~r~n[ Valor ICMS ST ] = [ Base ICMS ST ] x [ Aliq. ICMS ST ] / 100" )
	This.Of_Log_Calculo( "[ Valor ICMS ST ] = [ "+String(This.ivdc_Base_PMC_ST, "#,###,##0.00##")+" ] x [ "+String(ivo_UF_Destino.Pc_ICMS_Estadual, "#,##0.00")+" ] / 100" )
	This.Of_Log_Calculo( "[ Valor ICMS ST ] = [ "+String(This.ivdc_Base_PMC_ST, "#,###,##0.00##")+" ] x [ "+String(ivo_UF_Destino.Pc_ICMS_Estadual, "#,##0.00")+" ] / 100" )
	This.Of_Log_Calculo( "[ Valor ICMS ST ] = [ "+String(lvdc_Valor_PMC, "#,###,##0.00##")+" ]")
	// Chamado ServiceDesk:118907
	// Somar o percentual do FCP na aliquota de ICMS de venda no destino 
	// Obs.: Conforme orienta$$HEX2$$e700e300$$ENDHEX$$o do Fernando Correa n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ para alterar nas transf originadas das lojas. 
Else
	// Isso ocorre porque n$$HEX1$$e300$$ENDHEX$$o existe a tabela produto_uf nas lojas.
	// Estoque Central
	// Localiza a aliquota de ICMS do produto na uf destino
	This.of_Aliquota_ICMS_Venda(po_produto.cd_produto, ivo_UF_Destino.Cd_Unidade_Federacao, ref lvdc_Aliquota_Venda, ref ldc_PC_FCP)

	This.Of_Log_Calculo( "~r~n[ Aliq. ICMS ST ] = "+String(lvdc_Aliquota_Venda, "##0.00##") )
	This.Of_Log_Calculo( "[ Aliq. FCP ] = "+String(ldc_PC_FCP, "##0.00##") )
	
	If (This.ivs_Estadual = "N") Then
		If (This.ivs_Operacao <> TRANSFERENCIA) or (This.ivs_Operacao = TRANSFERENCIA and ivo_UF_Destino.id_transf_soma_fcp = 'S' ) Then
			// Chamado ServiceDesk:118907
			// Somar o percentual do FCP na aliquota de ICMS de venda no destino 
			lvdc_Aliquota_Venda = lvdc_Aliquota_Venda + ldc_PC_FCP
			If ldc_PC_FCP > 0 Then This.Of_Log_Calculo( "[ Aliq. ICMS ST ] = "+String(lvdc_Aliquota_Venda, "##0.00##")+" (somado o valor de FCP)")
			
			If (This.ivs_Operacao = TRANSFERENCIA and ivo_UF_Destino.id_transf_soma_fcp = 'S' ) and  ldc_PC_FCP > 0 Then
				ivo_Atributo_NF.vl_fcp 	= round(round(This.ivdc_Base_PMC_ST *  (ldc_PC_FCP	/100), 4) * al_qtde, 2)
				This.Of_Log_Calculo( "~r~n[ Valor FCP ] = ( [ Base ICMS ST ] x [ Aliq. FCP ] / 100 ) * [ Qtde ]")
				This.Of_Log_Calculo( "[ Valor FCP ] = ( [ "+String(This.ivdc_Base_PMC_ST, "##0.00##")+" ] x [ "+String(ldc_PC_FCP, "##0.00##")+" ] / 100 ) * [ "+String(al_qtde)+" ]")
				This.Of_Log_Calculo( "[ Valor FCP ] = ( "+String(Round(This.ivdc_Base_PMC_ST * ldc_PC_FCP / 100, 4), "##0.00##")+" ) * [ "+String(al_qtde)+" ]")
				This.Of_Log_Calculo( "[ Valor FCP ] = "+String(Round(ivo_Atributo_NF.vl_fcp, 4), "#,###,##0.00##"))
				ivo_Atributo_NF.pc_fcp	= ldc_PC_FCP
			End If
		End If
	End If

	ivo_Atributo_NF.PC_ICMS_ST = lvdc_Aliquota_Venda
	lvdc_Valor_PMC = Round(This.ivdc_Base_PMC_ST * (ivo_Atributo_NF.PC_ICMS_ST / 100), 4)
	This.Of_Log_Calculo( "~r~n[ Valor ICMS ST ] = ( [ Base ICMS ST ] x [ Aliq. ICMS ST ] / 100 )")
	This.Of_Log_Calculo( "[ Valor ICMS ST ] = ( [ "+String(This.ivdc_Base_PMC_ST, "#,###,##0.00##")+" ] x [ "+String(ivo_Atributo_NF.PC_ICMS_ST, "##0.00##")+" ] / 100 )")
	This.Of_Log_Calculo( "[ Valor ICMS ST ] = "+String(lvdc_Valor_PMC, "#,###,##0.00##"))
End If

// Utilizado somente para a formula$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o de venda do compras.
// Verificar a possibilidade de utilizar neste formato tamb$$HEX1$$e900$$ENDHEX$$m para as transfer$$HEX1$$ea00$$ENDHEX$$ncias
If This.ivs_Operacao = COMPRA Then
	
	// Fornecedor Simples
	If lvb_forn_simples Then 
		lvdc_Valor_Deducao = Round(This.ivdc_Base_Deducao_ST * (ivo_UF_Destino.Pc_ICMS_Interestadual  / 100), 4)
		This.Of_Log_Calculo( "~r~n< ! > Fornecedor do Simples Nacional")
		This.Of_Log_Calculo( "[ Valor ICMS ] = ( [ Base ICMS ] x [ Aliq. ICMS ] / 100 )")
		This.Of_Log_Calculo( "[ Valor ICMS ] = ( [ "+String(This.ivdc_Base_Deducao_ST, "#,###,##0.00##")+" ] x [ "+String(ivo_UF_Destino.Pc_ICMS_Interestadual, "##0.00##")+" ] / 100 )")
	Else
		lvdc_Valor_Deducao = Round(This.ivdc_Base_Deducao_ST * (ivo_Atributo.Pc_ICMS / 100), 4)
		This.Of_Log_Calculo( "~r~n[ Valor ICMS ] = ( [ Base ICMS ] x [ Aliq. ICMS ] / 100 )")
		This.Of_Log_Calculo( "[ Valor ICMS ] = ( [ "+String(This.ivdc_Base_Deducao_ST, "#,###,##0.00##")+" ] x [ "+String(ivo_Atributo.Pc_ICMS, "##0.00##")+" ] / 100 )")
	End If 
	
Else
	If This.ivs_Estadual = "S" Then
		//lvdc_Valor_Deducao = Round(This.ivdc_Base_Deducao_ST * (ivo_UF_Origem.Pc_ICMS_Estadual / 100), 4)
		lvdc_Valor_Deducao = Round(This.ivdc_Base_Deducao_ST * (adc_aliquota_icms / 100), 4)
		This.Of_Log_Calculo( "~r~n[ Valor ICMS ] = ( [ Base ICMS ] x [ Aliq. ICMS ] / 100 )")
		This.Of_Log_Calculo( "[ Valor ICMS ] = ( [ "+String(This.ivdc_Base_Deducao_ST, "#,###,##0.00##")+" ] x [ "+String(adc_aliquota_icms, "##0.00##")+" ] / 100 )")
	Else
		// COMPRA $$HEX1$$e900$$ENDHEX$$ utilizado na simula$$HEX2$$e700e300$$ENDHEX$$o e formula$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o de venda
		If  ivs_Operacao = TRANSFERENCIA or This.ivs_Operacao = COMPRA  Then
			
			// Qualquer problema no select da fun$$HEX2$$e700e300$$ENDHEX$$o o sistema vai considerar o a aliquota padr$$HEX1$$e300$$ENDHEX$$o
			This.of_Aliquota_ICMS_Origem_Produto(po_Produto, ref ls_Utiliza_Aliquota_InterEstadual, ref lvdc_Aliquota_InterEstadual_Importados)
													
			If ls_Utiliza_Aliquota_InterEstadual = "S" Then
				lvdc_Valor_Deducao = Round(This.ivdc_Base_Deducao_ST * (ivo_UF_Destino.Pc_ICMS_Interestadual / 100), 4)
				This.Of_Log_Calculo( "~r~n[ Valor ICMS ] = ( [ Base ICMS ] x [ Aliq. ICMS Interestadual ] / 100 )")
				This.Of_Log_Calculo( "[ Valor ICMS ] = ( [ "+String(This.ivdc_Base_Deducao_ST, "#,###,##0.00##")+" ] x [ "+String(ivo_UF_Destino.Pc_ICMS_Interestadual, "##0.00##")+" ] / 100 )")		
			Else
				lvdc_Valor_Deducao = Round(This.ivdc_Base_Deducao_ST * (lvdc_Aliquota_InterEstadual_Importados / 100), 4)
				This.Of_Log_Calculo( "~r~n[ Valor ICMS ] = ( [ Base ICMS ] x [ Aliq. ICMS Interestadual Importados ] / 100 )")
				This.Of_Log_Calculo( "[ Valor ICMS ] = ( [ "+String(This.ivdc_Base_Deducao_ST, "#,###,##0.00##")+" ] x [ "+String(ivo_UF_Destino.Pc_ICMS_Interestadual, "##0.00##")+" ] / 100 )")
			End If			
		Else
			// ivo_UF_Destino.Pc_ICMS_Interestadual -> esta sendo utilizado por causa da entrada da UF MS
			lvdc_Valor_Deducao = Round(This.ivdc_Base_Deducao_ST * (ivo_UF_Destino.Pc_ICMS_Interestadual / 100), 4)
			This.Of_Log_Calculo( "~r~n[ Valor ICMS ] = ( [ Base ICMS ] x [ Aliq. ICMS Interestadual ] / 100 )")
			This.Of_Log_Calculo( "[ Valor ICMS ] = ( [ "+String(This.ivdc_Base_Deducao_ST, "#,###,##0.00##")+" ] x [ "+String(ivo_UF_Destino.Pc_ICMS_Interestadual, "##0.00##")+" ] / 100 )")
		End If
	End If
End If

This.Of_Log_Calculo( "[ Valor ICMS ] = "+String(lvdc_Valor_Deducao, "#,###,##0.00##"))	

// Acumula o valor da ST para o cabe$$HEX1$$e700$$ENDHEX$$alho da NF
ivo_Atributo_NF.Vl_BC_ICMS_ST += Round(This.ivdc_Base_PMC_ST * al_Qtde, ivl_Decimais)

lvdc_Valor_ICMS_ST = Round((lvdc_Valor_PMC - lvdc_Valor_Deducao) * al_Qtde, ivl_Decimais)
This.Of_Log_Calculo( "~r~n[ Valor ICMS ST ] = [ Valor ICMS ST ] - [ Valor ICMS ]")	
This.Of_Log_Calculo( "[ Valor ICMS ST ] = [ "+String(lvdc_Valor_PMC, "#,###,##0.00##")+" ] - [ "+String(lvdc_Valor_Deducao, "#,###,##0.00##")+" ]")	
This.Of_Log_Calculo( "[ Valor ICMS ST ] = "+String(lvdc_Valor_PMC - gf_coalesce(lvdc_Valor_Deducao,0), "#,###,##0.00##"))	

If lvdc_Valor_ICMS_ST <= 0.01 Then
	This.Of_Log_Calculo( "~r~n< ! > Valor ICMS ST negativo, o valor ser$$HEX1$$e100$$ENDHEX$$ alterado para 0,01 por quantidade")	

	lvdc_Valor_ICMS_ST = round((0.01) * al_Qtde,ivl_Decimais)
	This.Of_Log_Calculo( "[ Valor ICMS ST ] = 0,01 x [ Qtde ]")	
	This.Of_Log_Calculo( "[ Valor ICMS ST ] = 0,01 x [ "+String(al_Qtde)+" ]")	
	This.Of_Log_Calculo( "[ Valor ICMS ST ] = "+String(lvdc_Valor_ICMS_ST - gf_coalesce(lvdc_Valor_Deducao,0), "#,###,##0.00##"))	
End If


// Valor da ST por produto
ivo_Atributo_NF.Vl_BC_ICMS_ST_PRD 	= This.ivdc_Base_PMC_ST

lvdc_Valor_ICMS_ST_PRD = lvdc_Valor_PMC - lvdc_Valor_Deducao


If  ivo_UF_Destino.cd_unidade_federacao = 'PR' Then  			// Para O PR
	If ivi_tributacao_produto=0 and ivb_base_pmc Then 			// Para Medicamento
		If ivs_Estadual="N" Then 							  			// Para Interestadual
			If ivs_Operacao = TRANSFERENCIA Then 	  			// Para Transfer$$HEX1$$ea00$$ENDHEX$$ncia
				lvdc_Valida_PMC_ICMS_ST = (This.ivdc_Base_PMC_ST * 0.056 ) 	
				This.Of_Log_Calculo( "~r~n************** Checa valor ST Inferior ao M$$HEX1$$ed00$$ENDHEX$$nimo no PR **************")
				This.Of_Log_Calculo( "[ Valor M$$HEX1$$ed00$$ENDHEX$$nimo ST PR ] = [ Base ST ] x 5,6%")
				This.Of_Log_Calculo( "[ Valor M$$HEX1$$ed00$$ENDHEX$$nimo ST PR ] = "+String(lvdc_Valida_PMC_ICMS_ST, "#,###,##0.00##"))
				
				If  (lvdc_Valor_ICMS_ST_PRD < lvdc_Valida_PMC_ICMS_ST) Then  
					This.Of_Log_Calculo( "< ! > Valor ICMS ST inferior ao limite m$$HEX1$$ed00$$ENDHEX$$nimo de 5,6% da base [ "+String(lvdc_Valida_PMC_ICMS_ST, "#,###,##0.00##")+" ], o valor ser$$HEX1$$e100$$ENDHEX$$ alterado para o m$$HEX1$$ed00$$ENDHEX$$nimo.")	
					This.Of_Log_Calculo( "[ Valor ICMS ST ] = [ Valor M$$HEX1$$ed00$$ENDHEX$$nimo ST PR ]")
					This.Of_Log_Calculo( "[ Valor ICMS ST ] = "+String(lvdc_Valida_PMC_ICMS_ST, "#,###,##0.00##"))
					
					lvdc_Valor_ICMS_ST_PRD = lvdc_Valida_PMC_ICMS_ST
				End If 		
			End If 
		End If 
	End If 
End If 	

// Isto foi feito porque o valor deu 0.0045
If lvdc_Valor_ICMS_ST_PRD <= 0.01 Then
	This.Of_Log_Calculo( "~r~n< ! > Valor ICMS ST unit$$HEX1$$e100$$ENDHEX$$rico negativo, o valor ser$$HEX1$$e100$$ENDHEX$$ alterado para 0,01.")	
	lvdc_Valor_ICMS_ST_PRD = 0.01
	This.Of_Log_Calculo( "[ Valor ICMS ST] = 0,01")	
End If

ivo_Atributo_NF.Vl_ICMS_ST    += Round(lvdc_Valor_ICMS_ST_PRD * al_Qtde, ivl_Decimais)
ivo_Atributo_NF.Vl_ICMS_ST_PRD	= lvdc_Valor_ICMS_ST_PRD

// Regra conforme Fernando - 15/09/2010
// ICMS_ST = BC_ICMS_ST * ALIQUOTA_PRD no estado destino
// ICMS_NORMAL = BC_ICMS * ALIQUOTA interestadual da uf de origem
// ICMS_ST_FINAL = ICMS_ST - ICMS_NORMAL
end subroutine

public function decimal of_aliquota_icms_produto (uo_produto ao_produto, string as_uf_origem, string as_uf_destino);Boolean lvb_Sucesso = False

Decimal{2} lvdc_PC_ICMS
Decimal{2} lvdc_PC_FCP
Decimal{2} lvdc_Aliquota_Importados
Decimal{2} lvdc_Aliquota

String ls_Utiliza_Aliquota_InterEstadual

If IsNull(ivo_UF_Origem.cd_unidade_federacao) or ivo_UF_Origem.cd_unidade_federacao <> as_uf_origem Then ivo_UF_Origem.of_localiza_codigo( as_uf_origem )
If IsNull(ivo_UF_Destino.cd_unidade_federacao) or ivo_UF_Destino.cd_unidade_federacao <> as_uf_destino Then ivo_UF_Destino.of_localiza_codigo( as_uf_destino )

Select t.pc_icms, coalesce(t.pc_fcp, 0)
Into :lvdc_PC_ICMS, :lvdc_PC_FCP
From produto_uf u
Inner Join      tipo_icms t
	On t.cd_tipo_icms = u.cd_tipo_icms
Where u.cd_produto           		= :ao_produto.cd_produto
  and u.cd_unidade_federacao	= :as_uf_origem
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Al$$HEX1$$ed00$$ENDHEX$$quota de ICMS da opera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o localizada." + &
		           "~r~rProduto:" + String(ao_produto.cd_produto) + "~rU.F.:" + as_uf_destino + "~rFun$$HEX2$$e700e300$$ENDHEX$$o: uo_tratamento_fiscal.of_aliquota_icms_produto") 
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Al$$HEX1$$ed00$$ENDHEX$$quota de ICMS da Opera$$HEX2$$e700e300$$ENDHEX$$o para o Produto "+String(ao_produto.cd_produto)+" - uo_tratamento_fiscal.of_aliquota_icms_produto")
End Choose

If IsNull(lvdc_PC_FCP) Then lvdc_PC_FCP = 0.00
If IsNull(lvdc_PC_ICMS) Then lvdc_PC_ICMS = 0.00

If as_uf_origem = as_uf_destino Then
	
	//Chamado 1435037
	//Mudan$$HEX1$$e700$$ENDHEX$$a no diferimento 
	If as_uf_origem = 'SC' Then
		Choose Case ivs_Operacao
			Case TRANSFERENCIA
				If lvdc_PC_ICMS = 17.00 Then //Muda para 12
					lvdc_PC_ICMS = 12.00
				End If
		End Choose	
	End If
	
	lvdc_Aliquota = lvdc_PC_ICMS + lvdc_PC_FCP
Else
	// Qualquer problema no select da fun$$HEX2$$e700e300$$ENDHEX$$o o sistema vai considerar o a aliquota padr$$HEX1$$e300$$ENDHEX$$o
	This.of_Aliquota_ICMS_Origem_Produto(ao_produto, ref ls_Utiliza_Aliquota_InterEstadual, ref lvdc_Aliquota_Importados)
									
	If ls_Utiliza_Aliquota_InterEstadual = "S" Then
		lvdc_Aliquota = ivo_UF_Destino.Pc_ICMS_Interestadual
	Else
		lvdc_Aliquota = lvdc_Aliquota_Importados
	End If
End If
 
Return lvdc_Aliquota
end function

public function string of_tributacao_icms_operacao (uo_produto ao_produto, string as_tributacao_icms);String lvs_Tributacao_ICMS, &
		 lvs_Situacao_Tributaria, &
		 lvs_antecipa_icms = "N", &
		 lvs_Origem_Fornecedor = "P"


Try

	If IsNull(ivo_UF_Destino.cd_unidade_federacao) or (Trim(ivo_UF_Destino.cd_unidade_federacao)="") Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","UF de destino n$$HEX1$$e300$$ENDHEX$$o definida.~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_situacao_tributaria()")
		Return ""
	End If
	
	If IsNull(as_Tributacao_ICMS) or as_Tributacao_ICMS = "" Then
		lvs_Tributacao_ICMS = ao_Produto.Cd_Tributacao_ICMS
	Else
		lvs_Tributacao_ICMS = as_Tributacao_ICMS
	End If
	
	// Verifica qual a tributa$$HEX2$$e700e300$$ENDHEX$$o cadastrada no produto
	If ivo_Tributacao.of_Localiza_Tributacao(lvs_Tributacao_ICMS) Then
	
		// Verifica se existe alguma excess$$HEX1$$e300$$ENDHEX$$o para tributa$$HEX2$$e700e300$$ENDHEX$$o padr$$HEX1$$e300$$ENDHEX$$o
		Choose Case ivs_Operacao			
			Case TRANSFERENCIA	
				//Cria objeto para pegar a tributa$$HEX2$$e700e300$$ENDHEX$$o de transfer$$HEX1$$ea00$$ENDHEX$$ncia da UF
				uo_Tributacao_ICMS lvo_Tributacao_TRF_Trib
				lvo_Tributacao_TRF_Trib = Create uo_Tributacao_ICMS
				//Localiza a tributa$$HEX2$$e700e300$$ENDHEX$$o por CST, pois na UF a configura$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ por CST
				lvo_Tributacao_TRF_Trib.Of_Localiza_tributacao_CST(  ivo_uf_destino.cd_cst_transf_tributada )
				
				If IsNull(ivl_Filial_Destino) or ivl_Filial_Destino = 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial destino para a emiss$$HEX1$$e300$$ENDHEX$$o da nota fiscal de transfer$$HEX1$$ea00$$ENDHEX$$ncia n$$HEX1$$e300$$ENDHEX$$o foi informada.", StopSign!)
					ivb_Erro = True
				End If
				
				//Verifica se o objeto est$$HEX1$$e100$$ENDHEX$$ instanciado
				If Not IsValid(ivo_tipo_produto_fiscal) Then ivo_tipo_produto_fiscal = Create uo_tipo_produto_fiscal
				//Localiza o tipo de produto no fiscal
				ivo_tipo_produto_fiscal.of_tipo_produto_fiscal_uf(	ivo_UF_Destino.Cd_Unidade_Federacao	, &
																				ao_produto.Cd_Produto						, &
																				lvs_Tributacao_ICMS							, &
																				ref lvs_antecipa_icms	)
				
				//Se for opera$$HEX2$$e700e300$$ENDHEX$$o estadual e tiver antecipa$$HEX2$$e700e300$$ENDHEX$$o de ICMS a CST deve ser 60
				If ivs_Estadual = "S" and lvs_antecipa_icms = 'S' Then
					lvs_Tributacao_ICMS = "6"
				Else
					// ALMOXARIFADO
					If is_Produto_Almoxarifado = 'S' Then
						If ivs_Estadual = "S" Then
							lvs_Tributacao_ICMS = "4"
						Else
							lvs_Tributacao_ICMS = "0"
						End If
					Else
						// Transfer$$HEX1$$ea00$$ENDHEX$$ncias do PERINI
						If ivl_Filial = ivl_filial_matriz Then
							// Transfer$$HEX1$$ea00$$ENDHEX$$ncia estadual, transforma a tributa$$HEX2$$e700e300$$ENDHEX$$o de ICMS para "5"
							// Suspens$$HEX1$$e300$$ENDHEX$$o ou Diferimento              			
							If ivs_Estadual = "S" Then
								// Ir$$HEX1$$e100$$ENDHEX$$ fazer a transforma$$HEX2$$e700e300$$ENDHEX$$o somente se o produto for um n$$HEX1$$e300$$ENDHEX$$o medicamento.
								If ivi_tributacao_produto <> 0 or lvs_tributacao_icms <> '1' Then
									// Perfumaria
									If ivi_tributacao_produto <> 0 Then
										lvs_Tributacao_ICMS = "6"
									Else
										//2019.08.09 - Os produtos isentos estavam sendo colocados com CST 50, por isso foi inserido o  
										//					tratamento pela CST de cadastro
										lvs_Tributacao_ICMS = IIF(as_tributacao_icms="4", "4", lvo_Tributacao_TRF_Trib.cd_tributacao_icms)
									End If
								End If
							End If
							
						Else // Fim Tranfer$$HEX1$$ea00$$ENDHEX$$ncia PERINI
							//**********************************************//
							// INICIO DAS TRANSFER$$HEX1$$ca00$$ENDHEX$$NCIAS ORIGINADAS DAS LOJAS 	//
							//**********************************************//
							If ivs_Transferencia_Vencido = 'S' Then
								//2019.08.08 - Alterado pois antes os produtos que possuiam ICMS ST (medicamentos), produtos isentos (preservativos)
								//					e tributados integralmente estavam sendo colocados todos com a CST 50
								Choose Case as_tributacao_icms
									Case "0" 
										lvs_Tributacao_ICMS = IIF(ivs_Estadual = "S", lvo_Tributacao_TRF_Trib.cd_tributacao_icms, "0")
									Case "1" 
										lvs_Tributacao_ICMS = IIF(ivs_Estadual = "S", "6", "0")
									Case "4" 
										lvs_Tributacao_ICMS = "4"
								End Choose
							Else
								If ivs_Estadual = "S" Then
									// Medicamento (n$$HEX1$$e300$$ENDHEX$$o possui tributa$$HEX2$$e700e300$$ENDHEX$$o ICMS ST cadastrada)
									If ivi_tributacao_produto = 0 Then
										// Transfer$$HEX1$$ea00$$ENDHEX$$ncia para o CD
										If ivl_Filial_Destino = ivl_filial_matriz Then
											// Devolu$$HEX2$$e700e300$$ENDHEX$$o de uma transfer$$HEX1$$ea00$$ENDHEX$$ncia do CD
											If ivs_devolucao_transferencia_cd = 'S' Then
												If ivs_calculo_st_aux_transferencia = 'N' Then									
													If lvs_Tributacao_ICMS <> "4"  Then lvs_Tributacao_ICMS = IIF(ivs_Estadual = "S" and as_tributacao_icms <> "1" and as_tributacao_icms <> "6", lvo_Tributacao_TRF_Trib.cd_tributacao_icms, "0")
												End If
											Else								
												//2019.08.08 - Alterado pois antes os produtos que possuiam ICMS ST (medicamentos), produtos isentos (preservativos)
												 //					e tributados integralmente estavam sendo colocados todos com a CST 50
												Choose Case as_tributacao_icms
													Case "0" 
														lvs_Tributacao_ICMS = lvo_Tributacao_TRF_Trib.cd_tributacao_icms
													Case "1" 
														lvs_Tributacao_ICMS = "6"
													Case "4" 
														lvs_Tributacao_ICMS = "4"
												End Choose
											End If									
										Else
											//2019.08.08 - Alterado pois antes os produtos que possuiam ICMS ST (medicamentos), produtos isentos (preservativos)
											//					e tributados integralmente estavam sendo colocados todos com a CST 50
											Choose Case as_tributacao_icms
												Case "0" 
													lvs_Tributacao_ICMS = lvo_Tributacao_TRF_Trib.cd_tributacao_icms
												Case "1" 
													lvs_Tributacao_ICMS = "6"
												Case "4" 
													lvs_Tributacao_ICMS = "4"
											End Choose
										End If
									Else
										// PERFUMARIA
										lvs_Tributacao_ICMS = "6"
									End If					
								Else  // Fim estadual
									
									// Transfer$$HEX1$$ea00$$ENDHEX$$ncia para o CD
									If ivl_Filial_Destino = ivl_filial_matriz Then
										If ivs_calculo_st_aux_transferencia = 'N' Then	
											If lvs_Tributacao_ICMS <> "4" Then lvs_Tributacao_ICMS = IIF(ivs_Estadual = "S" and as_tributacao_icms <> "1" and as_tributacao_icms <> "6", lvo_Tributacao_TRF_Trib.cd_tributacao_icms, "0")
										End If
									Else
										// Localiza a tributa$$HEX2$$e700e300$$ENDHEX$$o do produto na filial destino na matriz.
										// Obs.: esta fun$$HEX2$$e700e300$$ENDHEX$$o s$$HEX1$$f300$$ENDHEX$$ ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$ria quando for transfer$$HEX1$$ea00$$ENDHEX$$ncia INTER e a destino n$$HEX1$$e300$$ENDHEX$$o for o Perini
										// Quando for para o Perini esta fun$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ utilizada na RL058, s$$HEX1$$f300$$ENDHEX$$ para saber se a loja poder$$HEX1$$e100$$ENDHEX$$ ou n$$HEX1$$e300$$ENDHEX$$o
										// efetuar a transfer$$HEX1$$ea00$$ENDHEX$$ncia.
										This.of_localiza_tributacao_filial_destino(ao_produto.cd_produto,  ivo_UF_Destino.cd_unidade_federacao, ref lvs_Tributacao_ICMS)
									End If	
								End If
							End If // Fim Transfer$$HEX1$$ea00$$ENDHEX$$ncia de Vencidos
							//**********************************************//
							// 	TERMINO DAS TRANSFER$$HEX1$$ca00$$ENDHEX$$NCIAS ORIGINADAS DAS LOJAS 		//
							//**********************************************//
						End If // In$$HEX1$$ed00$$ENDHEX$$cio Transfer$$HEX1$$ea00$$ENDHEX$$ncia Loja
					End If // FIM TESTE ALMOXARIFADO
				End If
							
			Case VENDA, DEVOLUCAO_VENDA	
				//Verifica se o objeto est$$HEX1$$e100$$ENDHEX$$ instanciado
				If Not IsValid(ivo_tipo_produto_fiscal) Then ivo_tipo_produto_fiscal = Create uo_tipo_produto_fiscal
				//Localiza o tipo de produto no fiscal
				ivo_tipo_produto_fiscal.of_tipo_produto_fiscal_uf(	ivo_UF_Destino.Cd_Unidade_Federacao	, &
																				ao_produto.Cd_Produto						, &
																				lvs_Tributacao_ICMS							, &
																				ref lvs_antecipa_icms	)
				
				//Se tiver antecipa$$HEX2$$e700e300$$ENDHEX$$o de ICMS a CST deve ser 60
				If ivs_Estadual = "S" and lvs_antecipa_icms = 'S' Then
					lvs_Tributacao_ICMS = "6"
				Else
					// Verifica se a tributa$$HEX2$$e700e300$$ENDHEX$$o de ICMS padr$$HEX1$$e300$$ENDHEX$$o do produto
					// $$HEX1$$e900$$ENDHEX$$ por substitui$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria
					If ivo_Tributacao.Id_ICMS_ST = "S" Then
						// Vendas InterEstadual para tratar as vendas do eCommerce
						If ivs_Estadual = "N" Then
							// Transforma a tributa$$HEX2$$e700e300$$ENDHEX$$o de ICMS para "0" - tributa$$HEX2$$e700e300$$ENDHEX$$o normal
							lvs_Tributacao_ICMS = "0"
						Else
							// Verifica se as UFs origem e destino utilizam substitui$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria
							// O estado de SP n$$HEX1$$e300$$ENDHEX$$o utiliza
							If ivo_UF_Origem.Id_Utiliza_ST = "S" and ivo_UF_Destino.Id_Utiliza_ST = "S" Then
								If ivs_Estadual = "S" or ivs_Contribuinte = "N" Then						
									// Transforma a tributa$$HEX2$$e700e300$$ENDHEX$$o de ICMS para "6"
									// ICMS cobrado anteriormente por substitui$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria
									lvs_Tributacao_ICMS = "6"
								End If					
							Else					
								// Transforma a tributa$$HEX2$$e700e300$$ENDHEX$$o de ICMS para "0" - tributa$$HEX2$$e700e300$$ENDHEX$$o normal
								lvs_Tributacao_ICMS = "0"					
							End If				
						End If
					End If
				End If
		
			Case COMPRA
				
				// Data: 08/07/2015
				// Programador: Sergio
				// Motivo: Foi comentado porque esta condi$$HEX2$$e700e300$$ENDHEX$$o era somente utilizada na entrada de compra do Perini, por$$HEX1$$e900$$ENDHEX$$m n$$HEX1$$e300$$ENDHEX$$o esta mais sendo utilizada em virtude da NFE.
				// Esta condi$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ utilizada na simula$$HEX2$$e700e300$$ENDHEX$$o de compra e tamb$$HEX1$$e900$$ENDHEX$$m na composi$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o de compra para calcular o pre$$HEX1$$e700$$ENDHEX$$o de venda. N$$HEX1$$e300$$ENDHEX$$o existe altera$$HEX2$$e700e300$$ENDHEX$$o na tributa$$HEX2$$e700e300$$ENDHEX$$o
				
	//			// Verifica se a tributa$$HEX2$$e700e300$$ENDHEX$$o de ICMS padr$$HEX1$$e300$$ENDHEX$$o do produto
	//			// $$HEX1$$e900$$ENDHEX$$ por substitui$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria
	//			If ivo_Tributacao.Id_ICMS_ST = "S" Then
	//				
	//				// Verifica se a UF origem/destino utiliza substitui$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria
	//				// O estado de SP n$$HEX1$$e300$$ENDHEX$$o utiliza
	//				If ivo_UF_Origem.Id_Utiliza_ST = "S" and ivo_UF_Destino.Id_Utiliza_ST = "S" Then
	//					
	//					// Se o produto for produzido pelo fornecedor
	//					If lvs_Origem_Fornecedor = "P" Then
	//						If ivs_Contribuinte = "N" Then
	//							lvs_Tributacao_ICMS = "0"
	//						End If
	//					Else					
	//						If ivs_Estadual = "S" or ivs_Contribuinte = "N" Then						
	//							// Transforma a tributa$$HEX2$$e700e300$$ENDHEX$$o de ICMS para "6"
	//							// ICMS cobrado anteriormente por substitui$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria
	//							lvs_Tributacao_ICMS = "6"
	//						End If					
	//					End If
	//				Else					
	//					// Transforma a tributa$$HEX2$$e700e300$$ENDHEX$$o de ICMS para "0" - tributa$$HEX2$$e700e300$$ENDHEX$$o normal
	//					lvs_Tributacao_ICMS = "0"					
	//				End If				
	//			End If			
				
		End Choose
	End If
	
	// Concatena a origem do produto com a tributa$$HEX2$$e700e300$$ENDHEX$$o de ICMS
	// para formar p c$$HEX1$$f300$$ENDHEX$$digo da situa$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria
	//lvs_Situacao_Tributaria = ao_Produto.Cd_St_Origem + lvs_Tributacao_ICMS
	
	// Data da altera$$HEX2$$e700e300$$ENDHEX$$o: 17/12/2014
	// Motivo: antigamente era utilizado a CD_ORIGEM_PRODUTO que era sempre '0', devido a mudan$$HEX1$$e700$$ENDHEX$$a para o postgree
	// foi alterado para CD_ST_ORIGEM e come$$HEX1$$e700$$ENDHEX$$ou a dar problema no faturamento.
	//ivo_Tributacao.Of_localiza_tributacao( lvs_Tributacao_ICMS )
	//lvs_Situacao_Tributaria = ivo_Tributacao.cd_situacao_tributaria

Catch (RuntimeError lvo_Erro)
	MessageBox("Erro", lvo_Erro.GetMessage(), StopSign!)
	Return ""

Finally
	If IsValid(lvo_Tributacao_TRF_Trib) Then Destroy(lvo_Tributacao_TRF_Trib)
End Try

Return lvs_Tributacao_ICMS
end function

public function string of_tributacao_icms_operacao (uo_produto ao_produto);Return This.of_tributacao_icms_operacao(ao_Produto, "")
end function

public subroutine of_grava_icms_produto (uo_produto ao_produto, long al_qtde, decimal adc_preco_bruto, decimal adc_desconto, string as_tributacao_icms, decimal adc_aliquota_icms, decimal adc_aliquota_ipi, boolean ab_repasse_icms, string as_lista_pis_cofins, string as_fornecedor, decimal adc_desconto_nf);Decimal	lvdc_Fator_PMC, &
		  	lvdc_Indice_Repasse_ICMS, &
		  	lvdc_ICMS_Repassado_Bruto, &
		  	lvdc_ICMS_Repassado_Liquido, &
		  	lvdc_Preco_Liquido, &
		  	lvdc_Total_Liquido, &
			lvdc_Base_ST_Farmacia_Popular,&
			lvdc_Nulo,&
			ldc_FCP,&
			ldc_ICMS_Destino,&
			ldc_ICMS_Dif_ICMS,&
			ldc_Aliquota_Difa_Origem,&
			ldc_Aliquota_ICMS_Diferido,&
			ldc_Aliquota_Difa_Destino,&
			ldc_Base_Antecipacao,&
			ldc_Base_Oper_Propria,&
			lvdc_PMC_Produto, &
			lvdc_Total_ICMS_Base_PIS, &
			lvdc_Aliq_ICMS_Venda, &
			lvdc_Aliq_FCP_Venda
			
Long lvl_Tipo_Produto_Fiscal
			
Decimal ldc_Base_ST, ldc_Aliquota_ICMS_UF_Dest
	
Decimal {5}	lvdc_Reducao_Base_ST,&
				lvdc_Reducao_Base_ICMS,&
		  		lvdc_Reducao_Base_ST_Cesta_Basica
				  
Decimal {4} ldc_Aliquota_ICMS_desonerado

String lvs_Lista_PIS_COFINS, ls_Reduz_ICMS, ls_MSG, ls_Nulo

Integer li_Retorno

Boolean lvb_Forn_Simples	= False
Boolean lvb_Forn_Fabric 	= False
Boolean lvb_Forn_Reg_Esp	= False

SetNull(lvdc_Nulo)
SetNull(ls_Nulo)

ivs_Log_Calculo = ""
This.Of_Log_Calculo("------------------ Fun$$HEX2$$e700e300$$ENDHEX$$o C$$HEX1$$e100$$ENDHEX$$lculo Tribut$$HEX1$$e100$$ENDHEX$$rio CLAMED --------------")
This.Of_Log_Calculo("~r~n************** Par$$HEX1$$e200$$ENDHEX$$metros de Entrada **************")
This.Of_Log_Calculo("Opera$$HEX2$$e700e300$$ENDHEX$$o = "+ivs_Operacao)
This.Of_Log_Calculo("UF Origem = "+ivo_uf_origem.cd_unidade_federacao)
This.Of_Log_Calculo("UF Destino = "+ivo_uf_destino.cd_unidade_federacao)
This.Of_Log_Calculo("Produto = "+String(ao_produto.Cd_Produto) + " - " + ao_produto.ivs_Descricao_Apresentacao_Venda)
This.Of_Log_Calculo("Quantidade NF = "+String(al_qtde, "#,###,##0"))
This.Of_Log_Calculo("Pre$$HEX1$$e700$$ENDHEX$$o Bruto = "+String(adc_preco_bruto, "#,###,##0.00"))
This.Of_Log_Calculo("% Desconto Item = "+String(adc_desconto, "#,##0.00"))
This.Of_Log_Calculo("% Desconto NF = "+String(adc_desconto_nf, "#,##0.00"))
This.Of_Log_Calculo("Tribut. ICMS = "+as_tributacao_icms)
This.Of_Log_Calculo("Tribut. ST Produto = "+String(ivi_Tributacao_produto))
This.Of_Log_Calculo("Aliq. ICMS NF = "+String(adc_aliquota_icms, "##0.00"))
This.Of_Log_Calculo("Aliq. IPI = "+String(adc_aliquota_ipi, "##0.00"))
This.Of_Log_Calculo("Lista PIS/COFINS = "+as_lista_pis_cofins)
This.Of_Log_Calculo("Cod. Fornecedor = "+as_fornecedor)
This.Of_Log_Calculo("Filial Farm. Popular = "+IIF(ivs_filial_farmacia_popular="S", "SIM", "N$$HEX1$$c300$$ENDHEX$$O"))

If ivo_Tributacao.of_Localiza_Tributacao(RightA(as_tributacao_icms, 1)) Then
	
	// Inicializa as vari$$HEX1$$e100$$ENDHEX$$vies a cada produto
	ivo_Atributo_NF.Vl_BC_ICMS_ST_PRD 	= 0.00
	ivo_Atributo_NF.Vl_ICMS_ST_PRD			= 0.00
	ivo_Atributo_NF.PC_ICMS_ST 				= 0.00
	ivo_Atributo_NF.pc_reducao_base_icms 	= 0.00
	ivo_Atributo_NF.vl_bc_ipi 					= 0.00
	ivo_Atributo_NF.vl_ipi 						= 0.00
	ivo_Atributo_NF.pc_repasse_icms 			= 0.00
	ivo_Atributo_NF.vl_repasse_icms 			= 0.00
	
	ivo_Atributo_NF.vl_icms_operacao					= lvdc_Nulo
	ivo_Atributo_NF.pc_icms_diferido					= lvdc_Nulo
	ivo_Atributo_NF.vl_icms_diferido					= lvdc_Nulo
	ivo_Atributo_NF.vl_preco_maximo_consumidor	= lvdc_Nulo
	ivo_Atributo_NF.vl_preco_medio_ponderado_cf	= lvdc_Nulo
	
	ivo_Atributo_NF.id_motivo_desoneracao	 = ls_Nulo
	ivo_Atributo_NF.vl_icms_desonerado		 = lvdc_Nulo
	
	ivo_Atributo_NF.vl_bc_icms_uf_destino	= 0.00 
	ivo_Atributo_NF.pc_icms_uf_destino		= 0.00  
	ivo_Atributo_NF.pc_icms_fcp_uf_destino	= 0.00
	ivo_Atributo_NF.pc_partilha   				= 0.00
	ivo_Atributo_NF.vl_icms_fcp_uf_destino	= 0.00
	ivo_Atributo_NF.vl_icms_uf_destino   		= 0.00
	ivo_Atributo_NF.vl_icms_uf_origem		= 0.00
	
	ivo_Atributo_NF.vl_bc_icms_antecipacao = lvdc_Nulo
	ivo_Atributo_NF.pc_mva_antecipacao		= lvdc_Nulo
	ivo_Atributo_NF.pc_icms_antecipacao		= lvdc_Nulo
	ivo_Atributo_NF.vl_icms_antecipacao		= lvdc_Nulo
	
	ivo_Atributo_NF.vl_fcp						= 0.00
	ivo_Atributo_NF.pc_fcp						= 0.00
	
	ivo_Atributo_NF.vl_mva 						= lvdc_Nulo
		
	lvdc_Reducao_Base_ST_Cesta_Basica 	= 0.00000
	
	ivo_Atributo_NF.pc_Reducao_Base_ST 	= 0.0000
	ivo_Atributo_NF.pc_trava_iva_st			= 0.0000
	
	ivdc_preco_venda_maximo 					= lvdc_Nulo
		
	ivo_Atributo_NF.cd_cst_pis					= ls_Nulo
	ivo_Atributo_NF.vl_bc_pis					= 0.00
	ivo_Atributo_NF.pc_aliq_pis					= 0.00 
	ivo_Atributo_NF.vl_pis						= 0.00
	ivo_Atributo_NF.cd_cst_cofins				= ls_Nulo
	ivo_Atributo_NF.vl_bc_cofins				= 0.00
	ivo_Atributo_NF.pc_aliq_cofins				= 0.00 
	ivo_Atributo_NF.vl_cofins						= 0.00
	ivo_Atributo_NF.pc_icms_diferido			= 0.00
		
	ivb_base_pmc 			= False
	ib_Decreto_Temp_PR = False


	This.Of_Log_Calculo("~r~n************** C$$HEX1$$e100$$ENDHEX$$lculo Valor L$$HEX1$$ed00$$ENDHEX$$quido Item **************")
	// Calcula o Pre$$HEX1$$e700$$ENDHEX$$o L$$HEX1$$ed00$$ENDHEX$$quido
	lvdc_Preco_Liquido		= Round(Round(adc_Preco_Bruto * ((100 - adc_Desconto) / 100), ivl_Decimais) * ((100 - adc_desconto_nf) / 100), ivl_Decimais)
	This.Of_Log_Calculo("[ Valor L$$HEX1$$ed00$$ENDHEX$$quido Item ] = [ Pre$$HEX1$$e700$$ENDHEX$$o Bruto ] x ( 100 - [ % Desconto Item ] ) x ( 100 - [ % Desconto NF ] ) / 100 ")
	This.Of_Log_Calculo("[ Valor L$$HEX1$$ed00$$ENDHEX$$quido Item ] = [ "+String(adc_Preco_Bruto, "#,###,##0.00")+" ] x ( 100 - [ "+String(adc_Desconto, "##0.00")+" ] ) x ( 100 - [ "+String(adc_desconto_nf, "##0.00")+"  ] ) / 100 ")
	This.Of_Log_Calculo("[ Valor L$$HEX1$$ed00$$ENDHEX$$quido Item ] = "+String(lvdc_Preco_Liquido, "#,###,##0.00"))
	
	//Base Antecipa$$HEX2$$e700e300$$ENDHEX$$o recebe o valor l$$HEX1$$ed00$$ENDHEX$$quido c$$HEX1$$e100$$ENDHEX$$lculado
	ldc_Base_Antecipacao	= lvdc_Preco_Liquido
	
	//Tratamento Origem Produto
	This.Of_Log_Calculo("~r~n************** Busca Informa$$HEX2$$e700f500$$ENDHEX$$es para C$$HEX1$$e100$$ENDHEX$$lculo **************")
	If Not IsNull(ao_Produto.cd_st_origem) and trim(ao_Produto.cd_st_origem) <> "" Then
		ivo_Atributo_NF.cd_st_origem = ao_Produto.cd_st_origem
		This.Of_Log_Calculo("Origem Produto = "+ivo_Atributo_NF.cd_st_origem)
	Else
		ivo_Atributo_NF.cd_st_origem =  "0"
		This.Of_Log_Calculo("~r~n< ! > Origem Produto n$$HEX1$$e300$$ENDHEX$$o localizada para o produto, utilizado o valor padr$$HEX1$$e300$$ENDHEX$$o '0'.")
	End If
	
	//Atribui a CST Tributa$$HEX2$$e700e300$$ENDHEX$$o
	ivo_Atributo_NF.cd_st_tributacao	= ivo_tributacao.cd_cst_tributacao
	This.Of_Log_Calculo("CST Produto = "+ivo_Atributo_NF.cd_st_tributacao)
	//Atribui o % ICMS aos atributos
	ivo_Atributo_NF.pc_icms 			= adc_Aliquota_ICMS
	
	//Chamado: 934960 - In$$HEX1$$ed00$$ENDHEX$$cio
	If This.ivs_Estadual = 'S' Then 
		If (This.ivs_Operacao = COMPRA or ivs_Operacao =  TRANSFERENCIA) Then 
			If ivo_Atributo_NF.pc_icms = ivo_UF_Destino.pc_icms_estadual Then  
				ivo_Atributo_NF.pc_icms =12 
				This.Of_Log_Calculo("~r~n< ! > Alterada Al$$HEX1$$ed00$$ENDHEX$$quota ICMS (opera$$HEX2$$e700e300$$ENDHEX$$o estadual entre contribuintes) = "+String(ivo_Atributo_NF.pc_icms,"##0.00"))
			End If 
	  End If 
	End If 
	//Chamado: 934960 - T$$HEX1$$e900$$ENDHEX$$rmino
		
	// Verifica qual a base de c$$HEX1$$e100$$ENDHEX$$lculo do ICMS por Subst. Tribut$$HEX1$$e100$$ENDHEX$$ria
	ivo_atributo_nf.vl_preco_maximo_consumidor	= This.of_PMC(	  ao_Produto )
	This.Of_Log_Calculo("Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$e100$$ENDHEX$$ximo Consumidor (PMC) = "+String(ivo_atributo_nf.vl_preco_maximo_consumidor,"###,##0.00"))
	ivdc_preco_venda_maximo							= ivo_atributo_nf.vl_preco_maximo_consumidor
	ivo_atributo_nf.vl_preco_medio_ponderado_cf	= This.Of_PMPF( ao_Produto )
	This.Of_Log_Calculo("Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$e900$$ENDHEX$$dio Ponderado (PMPF) = "+String(ivo_atributo_nf.vl_preco_medio_ponderado_cf,"###,##0.00"))
	
	//Verifica o tipo de produto fiscal atrav$$HEX1$$e900$$ENDHEX$$s da NCM
	If Not IsValid(ivo_tipo_produto_fiscal) Then ivo_tipo_produto_fiscal = Create uo_tipo_produto_fiscal
	ivo_tipo_produto_fiscal.of_Tipo_Produto_Fiscal_UF(ivo_UF_Destino.Cd_unidade_federacao, ao_produto.nr_classificacao_fiscal, ref lvl_Tipo_Produto_Fiscal)
	This.Of_Log_Calculo("Tipo Produto Fiscal = "+String(lvl_Tipo_Produto_Fiscal))
	
	//Chamado 	597361-19: Tratamento Red. Base ICMS
	ivo_Atributo_NF.pc_reducao_base_icms = This.of_Reducao_Base_ICMS( ao_produto.Cd_Produto, ivo_uf_destino.cd_unidade_federacao)	
	This.Of_Log_Calculo("% Redu$$HEX2$$e700e300$$ENDHEX$$o Base ICMS = "+String(ivo_Atributo_NF.pc_reducao_base_icms, "##0.00"))
		
	//Tratamento IPI
	If adc_Aliquota_IPI > 0.00 Then	
		This.Of_Log_Calculo("~r~n************** C$$HEX1$$e100$$ENDHEX$$lculo IPI **************")
		ivo_Atributo_NF.vl_bc_ipi 	= lvdc_Preco_Liquido
		This.Of_Log_Calculo("[ Base IPI ] = [ Valor L$$HEX1$$ed00$$ENDHEX$$quido Item ]")
		This.Of_Log_Calculo("[ Base IPI ] = "+String(lvdc_Preco_Liquido,"###,##0.00##")+"~r~n")
		
		ivo_Atributo_NF.vl_ipi 		= Round(ivo_Atributo_NF.vl_bc_ipi * (adc_Aliquota_IPI / 100), ivl_Decimais)
		This.Of_Log_Calculo("[ Valor IPI ] = [ Base IPI ] x [ Aliq. IPI ] / 100")
		This.Of_Log_Calculo("[ Valor IPI ] = [ "+String(ivo_Atributo_NF.vl_bc_ipi, "#,###,##0.00##")+" ] x [ "+String(adc_Aliquota_IPI, "##0.00")+" ] / 100")
		This.Of_Log_Calculo("[ Valor IPI ] = "+String(ivo_Atributo_NF.vl_ipi,"###,##0.00####"))
		ldc_Base_Antecipacao += ivo_Atributo_NF.vl_ipi
		This.Of_Log_Calculo("IPI Adicionado a Base da Antecipa$$HEX2$$e700e300$$ENDHEX$$o ICMS = "+String(ivo_Atributo_NF.vl_ipi,"###,##0.00####"))
	End If
	
	If (ab_Repasse_ICMS) and (This.ivs_Operacao = COMPRA) Then
		// Se for calcular repasse na simula$$HEX2$$e700e300$$ENDHEX$$o de compra, s$$HEX1$$f300$$ENDHEX$$ ir$$HEX1$$e100$$ENDHEX$$ fazer se o medicamento possuir PMC
		//Chamado: 621277 - In$$HEX1$$ed00$$ENDHEX$$cio
		If (ivi_tributacao_produto = 0) and gf_coalesce(ivo_atributo_nf.vl_preco_maximo_consumidor, 0) = 0.00 Then
			ab_Repasse_ICMS = False
			This.Of_Log_Calculo("~r~n< ! > Este produto n$$HEX1$$e300$$ENDHEX$$o tem PMC, por isso n$$HEX1$$e300$$ENDHEX$$o tem repasse, ent$$HEX1$$e300$$ENDHEX$$o o repasse foi alterado para 'N$$HEX1$$c300$$ENDHEX$$O'.")
		End If
		//Chamado: 621277 - T$$HEX1$$e900$$ENDHEX$$rmino
		
		//Chamado: 1108307 - Metrexato compra para o CD - Rever regras produtos oncologicos
		If IsNull(adc_Aliquota_ICMS) or adc_Aliquota_ICMS = 0.00 Then
			ab_Repasse_ICMS = False
			This.Of_Log_Calculo("~r~n< ! > Este produto $$HEX1$$e900$$ENDHEX$$ isento, por isso n$$HEX1$$e300$$ENDHEX$$o tem repasse, ent$$HEX1$$e300$$ENDHEX$$o o repasse foi alterado para 'N$$HEX1$$c300$$ENDHEX$$O'.")
		End If
		//Chamado: 1108307 - Metrexato compra para o CD - Rever regras produtos oncologicos
	End If
	
		
	// Calcula o ICMS Repassado
	If ab_Repasse_ICMS Then
		This.Of_Log_Calculo("~r~n************** C$$HEX1$$e100$$ENDHEX$$lculo Repasse ICMS **************")
		lvdc_Indice_Repasse_ICMS = This.of_Indice_Repasse_ICMS(ao_Produto, ivo_Atributo_NF.pc_icms )
		This.Of_Log_Calculo("% Repasse ICMS = "+String(lvdc_Indice_Repasse_ICMS, "##0.00"))
		
		If lvdc_Indice_Repasse_ICMS > 0.00 Then
			lvdc_ICMS_Repassado_Bruto	= Round(adc_Preco_Bruto    * lvdc_Indice_Repasse_ICMS / 100, ivl_Decimais)
			lvdc_ICMS_Repassado_Liquido	= Round(lvdc_Preco_Liquido * lvdc_Indice_Repasse_ICMS / 100, ivl_Decimais)	
			This.Of_Log_Calculo("[ Valor Repasse ICMS ] = [ Valor L$$HEX1$$ed00$$ENDHEX$$quido Item ] x [ % Repasse ICMS ] / 100")	
			This.Of_Log_Calculo("[ Valor Repasse ICMS ] = [ "+String(lvdc_Preco_Liquido, "#,###,##0.00##")+" ] x [ "+String(lvdc_Indice_Repasse_ICMS, "##0.00")+" ] / 100")	
			This.Of_Log_Calculo("[ Valor Repasse ICMS ] = "+String(lvdc_ICMS_Repassado_Liquido, "#,###,##0.00"))	
			
			This.Of_Log_Calculo("~r~n************** Deduz valor repasse ICMS dos valores do item **************")
			This.Of_Log_Calculo("[ Pre$$HEX1$$e700$$ENDHEX$$o Bruto Item ] = [ Pre$$HEX1$$e700$$ENDHEX$$o Bruto Item ] - [ Valor Repasse ICMS ]")
			This.Of_Log_Calculo("[ Pre$$HEX1$$e700$$ENDHEX$$o Bruto Item ] = [ "+String(adc_Preco_Bruto, "###,###,##0.00##")+" ] - [ "+String(lvdc_ICMS_Repassado_Liquido, "#,###,##0.00##")+" ]")
			adc_Preco_Bruto    = adc_Preco_Bruto    - lvdc_ICMS_Repassado_Bruto
			This.Of_Log_Calculo("[ Pre$$HEX1$$e700$$ENDHEX$$o Bruto Item ] = "+String(adc_Preco_Bruto, "###,###,##0.00"))
			
			
			This.Of_Log_Calculo("~r~n[ Pre$$HEX1$$e700$$ENDHEX$$o L$$HEX1$$ed00$$ENDHEX$$quido Item ] = [ Pre$$HEX1$$e700$$ENDHEX$$o L$$HEX1$$ed00$$ENDHEX$$quido Item ] - [ Valor Repasse ICMS ]")
			This.Of_Log_Calculo("[ Pre$$HEX1$$e700$$ENDHEX$$o L$$HEX1$$ed00$$ENDHEX$$quido Item ] = [ "+String(lvdc_Preco_Liquido, "###,###,##0.00##")+" ] - [ "+String(lvdc_ICMS_Repassado_Liquido, "#,###,##0.00##")+" ]")
			lvdc_Preco_Liquido = lvdc_Preco_Liquido - lvdc_ICMS_Repassado_Liquido
			This.Of_Log_Calculo("[ Pre$$HEX1$$e700$$ENDHEX$$o L$$HEX1$$ed00$$ENDHEX$$quido Item ] = "+String(lvdc_Preco_Liquido, "###,###,##0.00"))
			
			ivo_Atributo_NF.pc_repasse_icms 	= lvdc_Indice_Repasse_ICMS
			ivo_Atributo_NF.vl_repasse_icms	= lvdc_ICMS_Repassado_Liquido
		End If
	End If
	
	//2016.11.25 - Alterado pois n$$HEX1$$e300$$ENDHEX$$o aplicava o desconto no ICMS ST, apenas no ICMS Normal (para situa$$HEX2$$e700f500$$ENDHEX$$es com IVA)
	//ldc_Base_ST   		= adc_Preco_Bruto
	ldc_Base_ST   		= lvdc_Preco_Liquido
	lvdc_Total_Liquido = lvdc_Preco_Liquido
	
	// O par$$HEX1$$e200$$ENDHEX$$metro ps_Lista_PIS_COFINS $$HEX1$$e900$$ENDHEX$$ recebido na nota fiscal de compra
	If Not IsNull(as_Lista_PIS_COFINS) and Trim(as_Lista_PIS_COFINS) <> "" Then
		lvs_Lista_PIS_COFINS = Upper(as_Lista_PIS_COFINS)
	Else
		lvs_Lista_PIS_COFINS = ao_Produto.Id_Situacao_PIS_COFINS
		This.Of_Log_Calculo("Lista PIS/COFINS = "+lvs_Lista_PIS_COFINS)
	End If
	
	// Retorna os par$$HEX1$$e200$$ENDHEX$$metros  tribut$$HEX1$$e100$$ENDHEX$$rios do fornecedor, na fun$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ trata nulo e vazio (transfer$$HEX1$$ea00$$ENDHEX$$ncias)
	If gf_coalesce(as_fornecedor, "") <> "" Then
		This.Of_Log_Calculo("~r~n************** Busca Par$$HEX1$$e200$$ENDHEX$$metros Fornecedor **************")
		This.of_Tributacao_Fornecedor(	as_fornecedor		, &
													lvb_Forn_Fabric	, &
													lvb_Forn_Simples	, &
													lvb_Forn_Reg_Esp)
		This.Of_Log_Calculo("Forn. Fabricante = "+IIF(lvb_Forn_Fabric, "SIM", "N$$HEX1$$c300$$ENDHEX$$O"))
		This.Of_Log_Calculo("Forn. Simples = "+IIF(lvb_Forn_Simples, "SIM", "N$$HEX1$$c300$$ENDHEX$$O"))
		This.Of_Log_Calculo("Forn. Reg. Especial = "+IIF(lvb_Forn_Reg_Esp, "SIM", "N$$HEX1$$c300$$ENDHEX$$O"))
	End If
	
	// Verificar se existem dedu$$HEX2$$e700e300$$ENDHEX$$o na base de c$$HEX1$$e100$$ENDHEX$$lculo do ICMS
	//  ---> 2017.05.25 - Chamado 237240 - Apenas h$$HEX1$$e100$$ENDHEX$$ dedu$$HEX2$$e700f500$$ENDHEX$$es de base de calculo para fabricantes
	If This.ivs_Estadual = "N" and This.ivs_Contribuinte = "S" and lvs_Lista_PIS_COFINS = "N" and lvb_Forn_Fabric Then
		// Medicamento
		If ivi_tributacao_produto = 0 Then
			ls_Reduz_ICMS = 'S'
			Choose Case ivo_Atributo_NF.pc_icms
				Case 4   ; ivo_Atributo_NF.pc_reducao_base_icms		= 9.04 	//  9,04 %
				Case 7   ; ivo_Atributo_NF.pc_reducao_base_icms		= 9.34 	//  9,34 %
				Case 12 ; ivo_Atributo_NF.pc_reducao_base_icms		= 9.90 	//  9,90 %
				Case Else ; ivo_Atributo_NF.pc_reducao_base_icms	= 10.49 	// 10,49 %
			End Choose
			This.Of_Log_Calculo("~r~n< ! > Aplicada redu$$HEX2$$e700e300$$ENDHEX$$o base de ICMS para fabricantes de medicamentos da lista negativa em opera$$HEX2$$e700e300$$ENDHEX$$o interestadual.")
			This.Of_Log_Calculo("% Redu$$HEX2$$e700e300$$ENDHEX$$o Base ICMS = "+String(ivo_Atributo_NF.pc_reducao_base_icms, "##0.00"))
		Else			
			// Se houver ST e a fun$$HEX2$$e700e300$$ENDHEX$$o foi chamada pela calculo de venda ou simula$$HEX2$$e700e300$$ENDHEX$$o de compra
			// o sistema ir$$HEX1$$e100$$ENDHEX$$ verificar se a ultima compra do produto foi com redu$$HEX2$$e700e300$$ENDHEX$$o, se n$$HEX1$$e300$$ENDHEX$$o foi n$$HEX1$$e300$$ENDHEX$$o haver$$HEX1$$e100$$ENDHEX$$ a redu$$HEX2$$e700e300$$ENDHEX$$o.
			If ivo_Tributacao.Id_ICMS_ST = "S" and is_calculo_venda_simulacao_compra = 'S' and gf_coalesce(as_fornecedor, "")<>"" Then
				This.Of_Log_Calculo("~r~n************** Busca Redu$$HEX2$$e700e300$$ENDHEX$$o Base ICMS em $$HEX1$$da00$$ENDHEX$$ltimas Entradas do Fornecedor ************** ")
				li_Retorno = of_Reducao_Ultima_Compra(as_fornecedor, ao_produto.cd_produto)
				
				Choose Case li_Retorno
					Case -1
						ls_Reduz_ICMS = 'N'
						ivb_Erro = True
					Case 0  // N$$HEX1$$c300$$ENDHEX$$O TEVE REDU$$HEX2$$c700c300$$ENDHEX$$O NA ULTIMA COMPRA 
						ls_Reduz_ICMS = 'N'
						ivo_Atributo_NF.pc_reducao_base_icms 	= 0.00			
					Case 1 //Possui redu$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$fa00$$ENDHEX$$ltima compra
						ls_Reduz_ICMS = 'S'
				End Choose
			End If
			
			If ls_Reduz_ICMS = 'S' Then
				Choose Case ivo_Atributo_NF.pc_icms
					Case 4   ; ivo_Atributo_NF.pc_reducao_base_icms		= 9.59	//  9,59 %
					Case 7   ; ivo_Atributo_NF.pc_reducao_base_icms		= 9.90	//  9,90 %
					Case Else ; ivo_Atributo_NF.pc_reducao_base_icms	= 10.49	// 10,49 %
				End Choose
				This.Of_Log_Calculo("Redu$$HEX2$$e700e300$$ENDHEX$$o Base ICMS = " + String(ivo_Atributo_NF.pc_reducao_base_icms, "##0.00"))
			End If
		End If
	End If
	
	// Verifica se o fornecedor tem regime especial para redu$$HEX2$$e700e300$$ENDHEX$$o da base de c$$HEX1$$e100$$ENDHEX$$lculo
	// Recolhimento de 12% ao inv$$HEX1$$e900$$ENDHEX$$s de 17% e 25%, como se fosse de outro estado
	If Trim(as_Fornecedor) <> "" and Not IsNull(as_Fornecedor) Then
		// Estadual e n$$HEX1$$e300$$ENDHEX$$o possuir nenhuma outra redu$$HEX2$$e700e300$$ENDHEX$$o // S$$HEX1$$f300$$ENDHEX$$ vale para SC
		If This.ivs_Estadual = "S"  and ivo_UF_Origem.cd_unidade_federacao = 'SC' and ivo_Tributacao.Id_ICMS_ST = "N" Then
			If lvb_Forn_Reg_Esp Then
				Choose Case ivo_Atributo_NF.pc_icms
					Case 25   ; ivo_atributo_nf.pc_reducao_base_icms = 52.000 	// 52,00 %
					Case 17   ; ivo_atributo_nf.pc_reducao_base_icms = 29.411	// 29,411 %
					Case Else ; ivo_atributo_nf.pc_reducao_base_icms = 0.000
				End Choose
				
				This.Of_Log_Calculo("~r~n< ! > Aplicada Redu$$HEX2$$e700e300$$ENDHEX$$o Base ICMS para fornecedor com regime especial, em opera$$HEX2$$e700e300$$ENDHEX$$o estadual de "+ivo_UF_Origem.cd_unidade_federacao+" sem ICMS ST.")
				This.Of_Log_Calculo("Redu$$HEX2$$e700e300$$ENDHEX$$o Base ICMS = " + String(ivo_Atributo_NF.pc_reducao_base_icms, "##0.00"))
			End If
		End If
	End If

	//Busca CFOP Item
	If gf_coalesce(ivo_Atributo.Cd_Natureza_Operacao, 0) = 0 Then This.Of_NatOpe(ivo_Tributacao.Id_ICMS_ST = "S", ref ivo_Atributo.Cd_Natureza_Operacao)

	//Transfer$$HEX1$$ea00$$ENDHEX$$ncias do mesmo estado ir$$HEX1$$e100$$ENDHEX$$ considerar o percentual de diferimento de imposto cadastrado na UF
	If ivo_Tributacao.id_icms_diferido = "S" Then
		If This.ivs_Operacao = TRANSFERENCIA and This.ivs_Estadual = "S" Then
			ivo_Atributo_NF.pc_icms_diferido	= ivo_uf_destino.pc_icms_diferido
			This.Of_Log_Calculo("~r~n< ! >Tributa$$HEX2$$e700e300$$ENDHEX$$o estadual de transfer$$HEX1$$ea00$$ENDHEX$$ncia busca o percentual do diferimento de ICMS do cadastro da UF.")
		Else
			ivo_atributo_nf.pc_icms_diferido	= 100.00
		End If
		This.Of_Log_Calculo("[ % Diferimento ICMS ] = "+String(ivo_atributo_nf.pc_icms_diferido, "##0.00")+"~r~n")
	End If
	
	
	//Calcula Base de c$$HEX1$$e100$$ENDHEX$$lculo de ICMS ($$HEX1$$e900$$ENDHEX$$ utilizada no c$$HEX1$$e100$$ENDHEX$$lculo de ICMS ST, n$$HEX1$$e300$$ENDHEX$$o mover esta linha para depois do c$$HEX1$$e100$$ENDHEX$$lculo de ICMS ST)
	ivo_Atributo_NF.vl_bc_icms_prd	= Round(lvdc_Total_Liquido * (1 - ivo_Atributo_NF.pc_reducao_base_icms / 100), ivl_Decimais)
	This.Of_Log_Calculo("~r~n************** Calcula ICMS **************")
	This.Of_Log_Calculo("[ Base ICMS ] = [ Pre$$HEX1$$e700$$ENDHEX$$o L$$HEX1$$ed00$$ENDHEX$$quido Item ] * (1 - [ % Red. Base ICMS ] / 100)")
	This.Of_Log_Calculo("[ Base ICMS ] = [ "+String(lvdc_Total_Liquido, "#,###,##0.00####")+" ] * (1 - [ "+String(ivo_Atributo_NF.pc_reducao_base_icms, "##0.00")+" ] / 100)")
	This.Of_Log_Calculo("[ Base ICMS ] = "+String(ivo_Atributo_NF.vl_bc_icms_prd, "#,###,##0.00####"))
	
	// Acumula a base de c$$HEX1$$e100$$ENDHEX$$lculo do ICMS por substitui$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria
	If ivo_Tributacao.Id_ICMS_ST = "S" Then
		
		This.Of_Log_Calculo("~r~n************** C$$HEX1$$e100$$ENDHEX$$lculo ICMS ST **************")
		lvdc_Base_ST_Farmacia_Popular 			= 0.00
		lvdc_Reducao_Base_ST_Cesta_Basica	= 0.00
		
		// Transferencias originadas da matriz(logistica) e inserido opera$$HEX2$$e700e300$$ENDHEX$$o de compras, para que seja utilizado na valida$$HEX2$$e700e300$$ENDHEX$$o XML
		If (ivl_Filial = ivl_filial_matriz and This.ivs_Operacao = TRANSFERENCIA) or (This.ivs_Operacao = COMPRA) Then
			If Not This.of_Reducao_Base_ST_Cesta_Basica(ao_Produto, ref lvdc_Reducao_Base_ST_Cesta_Basica) Then
				ivb_Erro = True
			End If
			This.Of_Log_Calculo("Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST (Cesta B$$HEX1$$e100$$ENDHEX$$sica) = "+String((lvdc_Reducao_Base_ST_Cesta_Basica - 1 ) * ( - 100), "##0.00####")+" (valor espec$$HEX1$$ed00$$ENDHEX$$fico de redu$$HEX2$$e700e300$$ENDHEX$$o de base ST informado no produto por UF)")
		Else
			This.Of_Log_Calculo("Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST (Cesta B$$HEX1$$e100$$ENDHEX$$sica) =  Sistema n$$HEX1$$e300$$ENDHEX$$o buscou redu$$HEX2$$e700e300$$ENDHEX$$o de base de ICMS ST, pois somente busca para opera$$HEX2$$e700e300$$ENDHEX$$o COMPRA ou TRANSF. originada no CD.")
		End If
			
		// TRANSFERENCIA -> Tamb$$HEX1$$e900$$ENDHEX$$m  $$HEX1$$e900$$ENDHEX$$ utilizado na formula$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$o de Venda e Valida$$HEX2$$e700e300$$ENDHEX$$o XML fornecedores
		// COMPRA -> Esta parte $$HEX1$$e900$$ENDHEX$$ utilizada para a simula$$HEX2$$e700e300$$ENDHEX$$o de compra PERINI e valida$$HEX2$$e700e300$$ENDHEX$$o de XML
		
		//In$$HEX1$$ed00$$ENDHEX$$cio BASE ST
		If (This.ivs_Operacao = TRANSFERENCIA or This.ivs_Operacao = COMPRA) Then 
						
		 	// Transfer$$HEX1$$ea00$$ENDHEX$$ncias do PERINI ou compras
			If ivl_Filial = ivl_filial_matriz or This.ivs_Operacao = COMPRA Then
				
				If IsNull(ivs_filial_farmacia_popular) or (ivs_filial_farmacia_popular <> 'S' and ivs_filial_farmacia_popular <> 'N') Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro para identificar se a loja faz parte do programa da farm$$HEX1$$e100$$ENDHEX$$cia do governo (S/N) inv$$HEX1$$e100$$ENDHEX$$lido.")
					ivb_Erro = True
				End If
				
				If ivs_filial_farmacia_popular = 'S' Then
					If Not This.of_Base_ST_Farmacia_Popular(ao_Produto.cd_produto, ref lvdc_Base_ST_Farmacia_Popular) Then
						ivb_Erro = True
					End If
					This.Of_Log_Calculo("Base ST Farm. Popular = "+String(lvdc_Base_ST_Farmacia_Popular, "##0.00####"))
				End If
				
			End if
			
			//Segundo retorno do fiscal utiliza priorit$$HEX1$$e100$$ENDHEX$$riamente o PMPF, inclusive sobre a base do Farm. Popular
			// mas n$$HEX1$$e300$$ENDHEX$$o deve ser utilizado se for superior ao PMC (caso tenha)
			If (ivo_atributo_nf.vl_preco_medio_ponderado_cf > 0.00 and &
				  (gf_coalesce(ivo_atributo_nf.vl_preco_maximo_consumidor, 0)=0.00 or &
				   gf_coalesce(ivo_atributo_nf.vl_preco_maximo_consumidor, 0)>=ivo_atributo_nf.vl_preco_medio_ponderado_cf )) and &
				ivo_UF_Destino.cd_unidade_federacao <> 'SP' Then  //SP faz dentro da Of_Base_ST
				// Chamado: 966799 - PMPF RS
				// Chamado: 676334 - Conforme decreto do estado do MS para alguns produtos ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio utilizar a base informada no campo produto_uf.vl_preco_medio_ponderado_cf
				ldc_Base_ST							= ivo_atributo_nf.vl_preco_medio_ponderado_cf
				ivo_atributo_nf.cd_mod_bc_st		= '5' 		//5=Base ST por Pauta, informa$$HEX2$$e700e300$$ENDHEX$$o concedida pelo setor fiscal
				ivb_base_pmc							= False
				This.Of_Log_Calculo("~r~nTipo Determina$$HEX2$$e700e300$$ENDHEX$$o Base ST = PMPF")
				This.Of_Log_Calculo("[ Base ICMS ST ] = [ Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$e900$$ENDHEX$$dio Poderado Cons. Final (PMPF) ]")
				This.Of_Log_Calculo("[ Base ICMS ST ] = [ "+String(ivo_atributo_nf.vl_preco_medio_ponderado_cf, "#,###,##0.00##")+" ]")
				
				//Zera a base eventual de Farm$$HEX1$$e100$$ENDHEX$$cia Popular, para n$$HEX1$$e300$$ENDHEX$$o haver problema nas l$$HEX1$$f300$$ENDHEX$$gicas por UF
				If lvdc_Base_ST_Farmacia_Popular > 0.00 Then 
					This.Of_Log_Calculo("~r~n< ! > Valor Base ST (Farm. Popular) = 0.00 (valor zerado para n$$HEX1$$e300$$ENDHEX$$o ser considerado como priorit$$HEX1$$e100$$ENDHEX$$rio devido ao RS.")
					lvdc_Base_ST_Farmacia_Popular 	= 0.00	
				End If
				
				//Caso n$$HEX1$$e300$$ENDHEX$$o tenha o PMC informado, busca para preencher a tag de medicamento
				If ivi_Tributacao_Produto = 0 and gf_coalesce(This.ivo_atributo_nf.vl_preco_maximo_consumidor, 0) = 0 Then
					ivdc_preco_venda_maximo 							= This.Of_PMC( ao_produto )
					ivo_atributo_nf.vl_preco_maximo_consumidor	= ivdc_preco_venda_maximo
				End If
				
			ElseIf lvdc_Base_ST_Farmacia_Popular > 0.00 and ivo_UF_Destino.cd_unidade_federacao <> 'SP' Then //SP faz dentro da Of_Base_ST
				ivo_atributo_nf.vl_preco_medio_ponderado_cf 	= 0.00
				ldc_Base_ST											= lvdc_Base_ST_Farmacia_Popular
				ivo_atributo_nf.cd_mod_bc_st						= '0' //0=Base ST por Pre$$HEX1$$e700$$ENDHEX$$o tabelado
				ivb_base_pmc											= False
				This.Of_Log_Calculo("~r~nTipo Determina$$HEX2$$e700e300$$ENDHEX$$o Base ST = Pre$$HEX1$$e700$$ENDHEX$$o 'Aqui Tem Farm$$HEX1$$e100$$ENDHEX$$cia Popular'")
				This.Of_Log_Calculo("[ Base ICMS ST ] = [ Pre$$HEX1$$e700$$ENDHEX$$o Farm$$HEX1$$e100$$ENDHEX$$cia Popular ]")
				This.Of_Log_Calculo("[ Base ICMS ST ] = [ "+String(lvdc_Base_ST_Farmacia_Popular, "#,###,##0.00##")+" ]")
				
				If ivi_Tributacao_Produto = 0 Then
					If gf_coalesce(ivdc_preco_venda_maximo, 0) <> gf_coalesce(lvdc_Base_ST_Farmacia_Popular, 0) Then This.Of_Log_Calculo("~r~n< ! > PMC = "+String(lvdc_Base_ST_Farmacia_Popular, "##0.00####")+" (alterado para considerar o PMC igual a base Farm. Pop.)")
					ivdc_preco_venda_maximo 							= lvdc_Base_ST_Farmacia_Popular
					ivo_atributo_nf.vl_preco_maximo_consumidor	= ivdc_preco_venda_maximo
				End If
				
			Else
				ivo_atributo_nf.vl_preco_medio_ponderado_cf = 0.00
				
				If This.ivs_Operacao = COMPRA Then
					ldc_Base_ST = This.of_Base_ST(ao_Produto, ldc_Base_ST, lvdc_Reducao_Base_ST_Cesta_Basica, lvs_Lista_PIS_COFINS, ivo_Atributo_NF.pc_icms, 0.00, lvb_Forn_Simples  )
				Else
					ldc_Base_ST = This.of_Base_ST(ao_Produto, ldc_Base_ST, lvdc_Reducao_Base_ST_Cesta_Basica, lvs_Lista_PIS_COFINS, ivo_Atributo_NF.pc_icms, ivo_Atributo_NF.vl_ipi, lvb_Forn_Simples  )		
				End If
			End If
			
		Else
			// Verifica qual a base de c$$HEX1$$e100$$ENDHEX$$lculo do ICMS por Subst. Tribut$$HEX1$$e100$$ENDHEX$$ria
			//Se existir PMPF e o valor for inferior ao PMC (se houver) utilizar$$HEX1$$e100$$ENDHEX$$ primeiramente este valor
			If (ivo_atributo_nf.vl_preco_medio_ponderado_cf > 0.00) and &
				  (gf_coalesce(ivo_atributo_nf.vl_preco_maximo_consumidor, 0)=0.00 or &
				   gf_coalesce(ivo_atributo_nf.vl_preco_maximo_consumidor, 0)>=ivo_atributo_nf.vl_preco_medio_ponderado_cf ) Then
				ivb_base_pmc						= False
				ldc_Base_ST 						= ivo_atributo_nf.vl_preco_medio_ponderado_cf
				ivo_atributo_nf.cd_mod_bc_st	= '5' //5=Base ST por Pauta
				This.Of_Log_Calculo("~r~nTipo Determina$$HEX2$$e700e300$$ENDHEX$$o Base ST = PMPF")
				This.Of_Log_Calculo("[ Base ICMS ST ] = [ Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$e900$$ENDHEX$$dio Poderado Cons. Final (PMPF) ]")
				This.Of_Log_Calculo("[ Base ICMS ST ] = [ "+String(ivo_atributo_nf.vl_preco_medio_ponderado_cf, "#,###,##0.00##")+" ]")
				
			//CHAMADO 974436: Em SP foi removida a redu$$HEX2$$e700e300$$ENDHEX$$o de base st, e deve calcular primeiro por IVA, caso a base seja maior que o PMC ent$$HEX1$$e300$$ENDHEX$$o utiliza o PMC
			ElseIf ivo_atributo_nf.vl_preco_maximo_consumidor > adc_Preco_Bruto and ivo_uf_destino.cd_unidade_federacao<>'SP' Then
				ivb_base_pmc						= True
				ldc_Base_ST 						= ivo_atributo_nf.vl_preco_maximo_consumidor
				ivo_atributo_nf.cd_mod_bc_st	= '0' //0=Base ST por Pre$$HEX1$$e700$$ENDHEX$$o tabelado
				This.Of_Log_Calculo("~r~nTipo Determina$$HEX2$$e700e300$$ENDHEX$$o Base ST = PMC")
				This.Of_Log_Calculo("[ Base ICMS ST ] = [ Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$e100$$ENDHEX$$ximo Consumidor (PMC) ]")
				This.Of_Log_Calculo("[ Base ICMS ST ] = [ "+String(ivo_atributo_nf.vl_preco_maximo_consumidor, "#,###,##0.00##")+" ]")
				
			Else
				// Verifica os $$HEX1$$ed00$$ENDHEX$$ndices conforme a lista de PIS e COFINS
				// P = Lista Positiva, N = Lista Negativa, Outros
				// Fator PMC = $$HEX1$$cd00$$ENDHEX$$ndice para determina$$HEX2$$e700e300$$ENDHEX$$o do PRE$$HEX1$$c700$$ENDHEX$$O M$$HEX1$$c100$$ENDHEX$$XIMO AO CONSUMIDOR
				ivb_base_pmc						= False
				lvdc_Fator_PMC 					= This.of_Fator_PMC(lvs_Lista_PIS_COFINS, ao_Produto.id_lei_generico, ivo_Atributo_NF.pc_icms, ao_produto.nr_classificacao_fiscal, lvdc_Reducao_Base_ST_Cesta_Basica)
				ivo_atributo_nf.cd_mod_bc_st	= '4' //0=Base ST por MVA
				
				ldc_Base_ST = Round((ldc_Base_ST + ivo_Atributo_NF.vl_ipi) * lvdc_Fator_PMC, ivl_Decimais)
				This.Of_Log_Calculo("~r~nTipo Determina$$HEX2$$e700e300$$ENDHEX$$o Base ST = MVA")
				This.Of_Log_Calculo("[ Base ICMS ST ] = ( [ Pre$$HEX1$$e700$$ENDHEX$$o L$$HEX1$$ed00$$ENDHEX$$quido Item ] + [ Valor IPI ] ) x ( 1 + [% MVA] / 100 )")
				This.Of_Log_Calculo("[ Base ICMS ST ] = ( [ "+String(ldc_Base_ST, "#,###,##0.00##")+" ] + [ "+String(ivo_Atributo_NF.vl_ipi, "#,###,##0.00##")+" ] ) x ( 1 + ["+String((lvdc_Fator_PMC - 1) * 100, "#,###,##0.00##")+"] / 100 )")
				This.Of_Log_Calculo("[ Base ICMS ST ] = [ "+String(lvdc_Preco_Liquido - gf_coalesce(ivo_Atributo_NF.vl_ipi, 0), "#,###,##0.00##")+" ] x [ "+String(lvdc_Fator_PMC, "#,###,##0.00##")+"]")
				This.Of_Log_Calculo("[ Base ICMS ST ] = [ "+String(ldc_Base_ST, "#,###,##0.00##")+" ]")
			End If
		End If
		//T$$HEX1$$e900$$ENDHEX$$rmino BASE ST
		
		//Se o produto tiver PMC
		If ivo_atributo_nf.vl_preco_maximo_consumidor > 0 Then
			//Se a base ST for superior ao PMC
			If ldc_Base_ST > ivo_atributo_nf.vl_preco_maximo_consumidor Then
				//Base ser$$HEX1$$e100$$ENDHEX$$ igual ao PMC
				ivo_atributo_nf.vl_preco_medio_ponderado_cf	= 0.00
				lvdc_Base_ST_Farmacia_Popular 					= 0.00
				ivo_atributo_nf.vl_mva								= 0.00
				ldc_Base_ST											= ivo_atributo_nf.vl_preco_maximo_consumidor
				ivo_atributo_nf.cd_mod_bc_st						= '0' //0=Base ST por PMC
				ivb_base_pmc											= True
				This.Of_Log_Calculo("~r~n< ! > [ Base ICMS ST ] = "+String(ldc_Base_ST, "##0.00####")+" (alterado para considerar o PMC como Base ST, pois o valor da base excedia o PMC)")
			End If
		End If
		
		//Inicializa sem redu$$HEX2$$e700e300$$ENDHEX$$o
		lvdc_reducao_base_st = 1
		// Medicamento, sem base FPB (f$$HEX1$$e100$$ENDHEX$$rmacia popular do brasil) 
		If ivi_tributacao_produto = 0 and lvdc_Base_ST_Farmacia_Popular = 0.00 Then
								
			Choose Case ivo_UF_Destino.cd_unidade_federacao
				Case 'SC'
					//Caso tenha % redu$$HEX2$$e700e300$$ENDHEX$$o espec$$HEX1$$ed00$$ENDHEX$$fico informado no produto utiliza este percentual					
					If lvdc_Reducao_Base_ST_Cesta_Basica > 0.00 Then
						lvdc_reducao_base_st = lvdc_Reducao_Base_ST_Cesta_Basica
						This.Of_Log_Calculo("~r~nTipo Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST = Cesta B$$HEX1$$e100$$ENDHEX$$sica")
					//Para PMPF n$$HEX1$$e300$$ENDHEX$$o utiliza outras redu$$HEX2$$e700f500$$ENDHEX$$es aplic$$HEX1$$e100$$ENDHEX$$veis a medicamentos
					ElseIf gf_coalesce(ivo_atributo_nf.vl_preco_medio_ponderado_cf, 0) = 0.00 Then
						//Tipo produto fiscal $$HEX1$$e900$$ENDHEX$$ Medicamento
						If lvl_Tipo_Produto_Fiscal = 1 Then
							If (ivb_base_pmc) Then
								lvdc_reducao_base_st = This.of_Reducao_Base_ST(	'1', &
																									ivo_UF_Destino.cd_unidade_federacao, &
																									ao_Produto.id_lei_generico, &
																									lvs_Lista_PIS_COFINS)
								This.Of_Log_Calculo("~r~nTipo Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST = Redu$$HEX2$$e700e300$$ENDHEX$$o Medicamento PMC")
								This.Of_Log_Calculo("[ % Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST ] = "+String((lvdc_reducao_base_st - 1) * 100, "##0.00##"))
							Else
								//Considera o % Outros da UF
								This.Of_Log_Calculo("~r~nTipo Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST = Redu$$HEX2$$e700e300$$ENDHEX$$o Medicamento Outros da UF")
								lvdc_reducao_base_st = (1 - (ivo_UF_Destino.pc_red_icms_outros / 100))
								This.Of_Log_Calculo("[ % Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST ] = "+String((lvdc_reducao_base_st - 1) * 100, "##0.00##"))
							End If
						End If
					End If
					
				Case 'PR'
					//Se o decreto do PR estiver vigente n$$HEX1$$e300$$ENDHEX$$o aplica a redu$$HEX2$$e700e300$$ENDHEX$$o da ST
					If Not ib_Decreto_Temp_PR Then				
						//Para PMPF n$$HEX1$$e300$$ENDHEX$$o utiliza outras redu$$HEX2$$e700f500$$ENDHEX$$es aplic$$HEX1$$e100$$ENDHEX$$veis a medicamentos
						If gf_coalesce(ivo_atributo_nf.vl_preco_medio_ponderado_cf, 0) = 0.00 Then
							lvdc_reducao_base_st = This.of_reducao_base_st(	'1', &
																								ivo_UF_Destino.cd_unidade_federacao, &
																								ao_Produto.id_lei_generico, &
																								lvs_Lista_PIS_COFINS)
							This.Of_Log_Calculo("~r~nTipo Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST = Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST (Medicamento PMC)")
							This.Of_Log_Calculo("[ % Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST ] = "+String((lvdc_reducao_base_st - 1) * 100, "##0.00##"))
						End If
						
						If lvdc_Reducao_Base_ST_Cesta_Basica > 0.00 Then
							This.Of_Log_Calculo("[ % Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST ] = ( ( 1 + [ % Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST ] / 100 ) x ( 1 + [ % Red. Base ST (Cesta B$$HEX1$$e100$$ENDHEX$$sica) ] / 100 ) - 1 ) x 100 ")
							This.Of_Log_Calculo("[ % Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST ] = ( ( 1 + [ "+String((lvdc_Reducao_Base_ST_Cesta_Basica - 1) * 100, "#,##0.00##")+" ] / 100 ) x ( 1 + [ "+String((lvdc_reducao_base_st - 1) * 100, "##0.00##")+" ] / 100 ) - 1 ) x 100 ")
							This.Of_Log_Calculo("[ % Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST ] = ( ( "+String(lvdc_reducao_base_st , "#,##0.00##")+" ) x ( "+String(lvdc_Reducao_Base_ST_Cesta_Basica, "##0.00##")+" ) - 1 ) x 100 ")
							lvdc_reducao_base_st = lvdc_reducao_base_st * lvdc_Reducao_Base_ST_Cesta_Basica
							This.Of_Log_Calculo("[ % Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST ] = ( "+String(lvdc_reducao_base_st , "#,##0.00##")+" - 1 ) x 100 ")
						End If
					End If
					
				Case Else // Estados RS, BA, MS, SP, etc
					
					//Caso tenha % redu$$HEX2$$e700e300$$ENDHEX$$o espec$$HEX1$$ed00$$ENDHEX$$fico informado no produto utiliza este percentual
					If lvdc_Reducao_Base_ST_Cesta_Basica > 0.00 Then
						This.Of_Log_Calculo("~r~nTipo Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST = Cesta B$$HEX1$$e100$$ENDHEX$$sica")
						lvdc_reducao_base_st = lvdc_Reducao_Base_ST_Cesta_Basica
						
					//Para PMPF n$$HEX1$$e300$$ENDHEX$$o utiliza outras redu$$HEX2$$e700f500$$ENDHEX$$es aplic$$HEX1$$e100$$ENDHEX$$veis a medicamentos
					ElseIf gf_coalesce(ivo_atributo_nf.vl_preco_medio_ponderado_cf, 0) = 0.00 Then
						//Tipo produto fiscal $$HEX1$$e900$$ENDHEX$$ Medicamento
						If lvl_Tipo_Produto_Fiscal = 1 Then
							// Esta fun$$HEX2$$e700e300$$ENDHEX$$o s$$HEX1$$f300$$ENDHEX$$ funciona na matriz pois ainda precisaremos criar a tabela reducao_base_st nas lojas
							If ivb_base_pmc Then
								This.Of_Log_Calculo("~r~nTipo Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST = Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST (Medicamento PMC)")
								//Base Legal RS - Art. 105, $$HEX1$$a700$$ENDHEX$$ 5$$HEX1$$ba00$$ENDHEX$$, do Livro III do RICMS/RS
								lvdc_reducao_base_st = This.of_reducao_base_st('1', ivo_UF_Destino.cd_unidade_federacao, ao_Produto.id_lei_generico, lvs_Lista_PIS_COFINS)
							Else
								//Considera o % Outros da UF
								This.Of_Log_Calculo("~r~nTipo Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST = Redu$$HEX2$$e700e300$$ENDHEX$$o Medicamento Outros da UF")
								lvdc_reducao_base_st = (1 - (ivo_UF_Destino.pc_red_icms_outros / 100))
							End If
						End If
					End If
					
			End Choose
		Else
			This.Of_Log_Calculo("~r~nTipo Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST = Redu$$HEX2$$e700e300$$ENDHEX$$o Trib. ICMS ST (Prod. Farm.)")
			lvdc_reducao_base_st = This.of_Fator_Reducao_Base_ST(ivi_tributacao_produto)
		End If
		This.Of_Log_Calculo("[ % Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST ] = "+String((lvdc_reducao_base_st - 1 ) * ( - 100), "#,##0.00##"))
			
		//<Altera$$HEX2$$e700e300$$ENDHEX$$o :Chamado 	482171>
		If (ivl_Filial = ivl_filial_matriz) and	(ivo_UF_Destino.cd_unidade_federacao = "SC") Then	//Bloqueia a redu$$HEX2$$e700e300$$ENDHEX$$o quando o CD fatura para SC
			If	ivi_tributacao_produto	=	0 	Then     		// Medicamento
				If  lvdc_Base_ST_Farmacia_Popular=0 		Then // Valor PMC Farmacia Popular Produto
					If	lvdc_reducao_base_st	<> 1.00  			Then  		// Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST Maior que Zero
						lvdc_PMC_Produto = This.of_PMC(ao_Produto)  // Carrega o PMC do Produto
						
						If lvdc_PMC_Produto > 0 Then //[Cleser] Colocado essa condi$$HEX2$$e700e300$$ENDHEX$$o porque estava dando erro ao dividir por zero
							If	This.ivs_Estadual = "S" 				Then    //Opera$$HEX2$$e700e300$$ENDHEX$$o Estadual
								/// Calculo 1 
								If round((lvdc_Preco_Liquido / Round(lvdc_PMC_Produto, ivl_Decimais)), 4) >= 0.7018  Then 				//70,18%
									lvdc_reducao_base_st = 1
									This.Of_Log_Calculo("< ! > [ % Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST ] = 0,00% (RICMS/SC - Art. 148, $$HEX1$$a700$$ENDHEX$$4$$HEX1$$ba00$$ENDHEX$$, itens I e II) ")
								End If 
							Else										 					//Opera$$HEX2$$e700e300$$ENDHEX$$o InterEstadual					
								// Calculo 2 
								Choose Case ivo_Atributo_NF.pc_icms
									Case 12   
										If round((lvdc_Preco_Liquido / Round(lvdc_PMC_Produto, ivl_Decimais)), 4) >= 0.6602   Then   		//66,02% 
											lvdc_reducao_base_st = 1
											This.Of_Log_Calculo("< ! > [ % Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST ] = 0,00% (RICMS/SC - Art. 148, $$HEX1$$a700$$ENDHEX$$4$$HEX1$$ba00$$ENDHEX$$, itens I e II) ")
										End If 				
									Case 4
										If round((lvdc_Preco_Liquido / Round(lvdc_PMC_Produto, ivl_Decimais)), 4) >=0.6052   Then    		//60,52%
											lvdc_reducao_base_st = 1
											This.Of_Log_Calculo("< ! > [ % Redu$$HEX2$$e700e300$$ENDHEX$$o Base ST ] = 0,00% (RICMS/SC - Art. 148, $$HEX1$$a700$$ENDHEX$$4$$HEX1$$ba00$$ENDHEX$$, itens I e II) ")
										End If 					
								End Choose					
							End If
						End If
					End If 			
				End If 
			End If
		End If
		//</Alteracao>	
		
		
		// Valores em unidades
		This.ivdc_Base_Deducao_ST		= ivo_Atributo_NF.vl_bc_icms_prd
		This.ivdc_Base_PMC_ST				= Round(ldc_Base_ST * lvdc_reducao_base_st, ivl_Decimais)
		This.Of_Log_Calculo("[ Base ICMS ST ] = [ Base ICMS ST ] x ( 1 - [ % Redu$$HEX2$$e700e300$$ENDHEX$$o ICMS ST ] / 100) ")
		This.Of_Log_Calculo("[ Base ICMS ST ] = [ "+String(ldc_Base_ST, "#,###,##0.00##")+" ] x ( 1 - [ "+String((lvdc_reducao_base_st - 1 ) * ( - 100), "#,##0.00##")+" ] / 100) ")
		This.Of_Log_Calculo("[ Base ICMS ST ] = [ "+String(ldc_Base_ST, "#,###,##0.00##")+" ] x ( "+String(lvdc_reducao_base_st, "##0.00##")+" ) ")
		This.Of_Log_Calculo("[ Base ICMS ST ] = "+String(This.ivdc_Base_PMC_ST, "#,###,##0.00##"))
		ivo_Atributo_NF.pc_Reducao_Base_ST = lvdc_reducao_base_st
		
		// Calcula o valor do ICMS por produto
		// S$$HEX1$$e900$$ENDHEX$$rgio - 14/09/2010		
		This.of_Calcula_ICMS_ST(ao_produto, al_QTDE, ivo_Atributo_NF.pc_icms, lvb_Forn_Simples)
	End If
	
	//C$$HEX1$$e100$$ENDHEX$$lculo Valor ICMS Diferido
	If ivo_Tributacao.id_icms_diferido = "S" Then
		//Verifica a al$$HEX1$$ed00$$ENDHEX$$quota normal do produto sem opera$$HEX2$$e700e300$$ENDHEX$$o diferida
		ldc_Aliquota_ICMS_Diferido = This.Of_Aliquota_ICMS_Produto( ao_produto, ivo_uf_origem.cd_unidade_federacao, ivo_uf_destino.cd_unidade_federacao)
		This.Of_Log_Calculo("~r~n[ Aliq. ICMS p/ Diferido ] = "+String(ldc_Aliquota_ICMS_Diferido, "##0.00##"))
		ivo_Atributo_NF.pc_icms		= ldc_Aliquota_ICMS_Diferido
	End If
	
	If ivo_Atributo_NF.pc_icms > 0 Then
		ivo_Atributo_NF.vl_icms_prd 		= Round(ivo_Atributo_NF.vl_bc_icms_prd * (ivo_Atributo_NF.pc_icms / 100) * (1 - ivo_Atributo_NF.pc_icms_diferido/100), 6)
		This.Of_Log_Calculo("~r~n[ Valor ICMS ] = ( [ Base ICMS ] x [ Aliq. ICMS ] / 100 ) x ( 1 - [ % Diferimento ICMS ] / 100 )")
		This.Of_Log_Calculo("[ Valor ICMS ] = ( [ "+String(ivo_Atributo_NF.vl_bc_icms_prd, "#,###,##0.00")+" ] x [ "+String(ivo_Atributo_NF.pc_icms, "##0.00")+" ] / 100 x ( 1 - [ "+String(ivo_Atributo_NF.pc_icms_diferido, "##0.00")+" ] / 100 )")
		This.Of_Log_Calculo("[ Valor ICMS ] = ( "+String(ivo_Atributo_NF.vl_bc_icms_prd * ivo_Atributo_NF.pc_icms / 100, "#,###,##0.00##")+" ) x ( "+String(1 - ivo_Atributo_NF.pc_icms_diferido/100, "##0.00##")+" )")
		This.Of_Log_Calculo("[ Valor ICMS ] = "+String(Round(ivo_Atributo_NF.vl_icms_prd, 4), "#,###,##0.00##"))

		// O icms para NFE esta fazendo arrendondamento com 4 casas decimais
		ivo_Atributo_NF.vl_icms_prd_nfe	= Round(ivo_Atributo_NF.vl_icms_prd, 4)
		
		If ivo_Tributacao.id_icms_diferido = "S" Then
			ivo_Atributo_NF.vl_icms_operacao	= Round(ivo_Atributo_NF.vl_bc_icms_prd * (ldc_Aliquota_ICMS_Diferido / 100), 4)
			This.Of_Log_Calculo("~r~n[ Valor ICMS Opera$$HEX2$$e700e300$$ENDHEX$$o ] = [ Base ICMS ] x [ Aliq. ICMS p/ Diferido ] / 100")
			This.Of_Log_Calculo("[ Valor ICMS Opera$$HEX2$$e700e300$$ENDHEX$$o ] = [ "+String(ivo_Atributo_NF.vl_bc_icms_prd, "#,###,##0.00")+" ] x [ "+String(ldc_Aliquota_ICMS_Diferido, "##0.00##")+" ] / 100")
			This.Of_Log_Calculo("[ Valor ICMS Opera$$HEX2$$e700e300$$ENDHEX$$o ] = "+String(ivo_Atributo_NF.vl_icms_operacao, "#,###,##0.00"))

			ivo_Atributo_NF.vl_icms_diferido	= ivo_Atributo_NF.vl_icms_operacao - ivo_Atributo_NF.vl_icms_prd
			This.Of_Log_Calculo("~r~n[ Valor ICMS Diferido ] = [ Valor ICMS Opera$$HEX2$$e700e300$$ENDHEX$$o ] - [ Valor ICMS ]")
			This.Of_Log_Calculo("[ Valor ICMS Diferido ] = [ "+String(ivo_Atributo_NF.vl_icms_operacao, "#,###,##0.00")+" ] - [ "+String(ivo_Atributo_NF.vl_icms_prd, "#,###,##0.00")+" ]")
			This.Of_Log_Calculo("[ Valor ICMS Diferido ] = "+String(ivo_Atributo_NF.vl_icms_diferido, "#,###,##0.00"))
		End If
		
		// Calcula a diferen$$HEX1$$e700$$ENDHEX$$a de aliquota de ICMS INTERESTADUAL
		If This.ivs_Operacao = VENDA and ivs_Estadual = 'N' Then
			If Not This.Of_Calcula_Difa_Venda(ao_produto, al_qtde) Then
				ivb_Erro = True
			End If
		End If
		
		//Calcula antecipa$$HEX2$$e700e300$$ENDHEX$$o de ICMS para transfer$$HEX1$$ea00$$ENDHEX$$ncias do PERINI
		If (ivo_Tributacao.Id_ICMS_ST <> "S") and (This.ivs_Operacao = TRANSFERENCIA) and (ivl_Filial = ivl_filial_matriz) Then		
			This.Of_Calcula_Antecipacao_ICMS( &	
					/* UF Origem Aquisi$$HEX2$$e700e300$$ENDHEX$$o */		ivo_UF_Origem.Cd_Unidade_Federacao, & 
					/* UF Filial Destino */				ivo_UF_Destino.Cd_Unidade_Federacao, &
					/* C$$HEX1$$f300$$ENDHEX$$digo Produto */				ao_produto.Cd_Produto,  &
					/* Qtde Produto */				al_qtde,  &
					/* Valor Unit. Prod. NF */		ldc_Base_Antecipacao, & 
					/* Aliq. ICMS Destac. NF */		ivo_Atributo_NF.pc_icms,  &
					/* Valor ICMS Destac. NF */	ivo_Atributo_NF.vl_bc_icms_prd * (ivo_Atributo_NF.pc_icms / 100),  &
					/* Base ICMS Antecip. */		ref ivo_Atributo_NF.vl_bc_icms_antecipacao, &
					/* MVA ICMS Antecip. */		ref ivo_Atributo_NF.pc_mva_antecipacao,  &
					/* Aliq. ICMS Antecip. */			ref ivo_Atributo_NF.pc_icms_antecipacao,  &
					/* Valor ICMS Antecip. */		ref ivo_Atributo_NF.vl_icms_antecipacao)
		End If
	Else
		ivo_Atributo_NF.pc_reducao_base_icms	= 0.00
		ivo_Atributo_NF.vl_bc_icms_prd			= 0.00
		ivo_Atributo_NF.vl_icms_prd 				= 0.00
		ivo_Atributo_NF.vl_icms_prd_nfe			= 0.00
	End If
	
	//Calcula valor desonerado ICMS
	Choose Case ivo_Atributo_NF.cd_st_tributacao
		Case '20', '30', '40', '41', '50', '70', '90'
			This.Of_Log_Calculo("~r~n************** ICMS Desonerado **************")
			//Verifica a al$$HEX1$$ed00$$ENDHEX$$quota normal do produto
			ldc_Aliquota_ICMS_Desonerado = This.Of_Aliquota_ICMS_Produto( ao_produto, ivo_uf_origem.cd_unidade_federacao, ivo_uf_destino.cd_unidade_federacao)
			This.Of_Log_Calculo("Aliq. ICMS Desonerado = "+String(ldc_Aliquota_ICMS_Desonerado, "#,##0.00##"))
			ivo_Atributo_NF.id_motivo_desoneracao	 = '9'
			This.Of_Log_Calculo("Motivo Desonera$$HEX2$$e700e300$$ENDHEX$$o = '9 - Outros'")
			
			//Calcula Valores Desonerado
			ivo_Atributo_NF.vl_icms_desonerado		 = Round(lvdc_Total_Liquido * (ldc_Aliquota_ICMS_Desonerado / 100), 4) - ivo_Atributo_NF.vl_icms_prd
			This.Of_Log_Calculo("~r~n[ Valor ICMS Desonerado ] = [ Valor L$$HEX1$$ed00$$ENDHEX$$quido Item ] x [ Aliq. ICMS Desonerado ] - [ Valor ICMS ] ")
			This.Of_Log_Calculo("[ Valor ICMS Desonerado ] = [ "+String(lvdc_Total_Liquido, "#,###,##0.00##")+" ] x [ "+String(ldc_Aliquota_ICMS_Desonerado, "#,##0.00##")+" ] - [ "+ String(ivo_Atributo_NF.vl_icms_prd, "#,###,##0.00##") +" ] ")
			This.Of_Log_Calculo("[ Valor ICMS Desonerado ] = "+String(ivo_Atributo_NF.vl_icms_desonerado, "#,###,##0.00##"))
			
			//Rejeicao produto gratis NFCe
			If ivo_Atributo_NF.vl_icms_desonerado = 0 Then
				This.Of_Log_Calculo("< ! > Valor ICMS desonerado zerado ou negativo, ent$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ considerado R$0,01, devido a rejei$$HEX2$$e700f500$$ENDHEX$$es de NFCe com produto gr$$HEX1$$e100$$ENDHEX$$tis.")
				ivo_Atributo_NF.vl_icms_desonerado = 0.01
			End If
	End Choose
	
	//Se for opera$$HEX2$$e700e300$$ENDHEX$$o de venda com o ICMS ST Retido Anteriormente
	If This.ivs_Operacao = VENDA and ivo_Atributo_NF.cd_st_tributacao='60' Then
		//Verifica UF Destino informada
		If not ivo_UF_Destino.Localizado Then 
			MessageBox("Falha", "Necess$$HEX1$$e100$$ENDHEX$$rio chamar a fun$$HEX2$$e700e300$$ENDHEX$$o 'uo_tratamento_fiscal.Of_Grava_UF_Origem_Destino()', antes de calcular o ICMS.", Exclamation!)
			//Busca Aliquota
			If Not This.Of_Aliquota_ICMS_Venda(ao_produto.cd_produto, ivo_UF_Destino.Cd_Unidade_Federacao, ref lvdc_Aliq_ICMS_Venda, ref lvdc_Aliq_FCP_Venda ) Then
				lvdc_Aliq_ICMS_Venda = adc_aliquota_icms
			End If
		Else
			lvdc_Aliq_ICMS_Venda = adc_aliquota_icms
		End If
		This.Of_Log_Calculo("~r~n************** Calculo ICMS Efetivo **************")
		This.Of_Log_Calculo("[ Valor ICMS Efetivo ] = [ Valor L$$HEX1$$ed00$$ENDHEX$$quido Item ] x [ Aliq. ICMS Opera$$HEX2$$e700e300$$ENDHEX$$o ]")
		This.Of_Log_Calculo("[ Valor ICMS Efetivo ] = [ "+String(Round(al_qtde * lvdc_Preco_Liquido, 2),"#,###,##0.00")+" ] x [ "+String(adc_Aliquota_ICMS,"##0.00")+" ]")
		This.Of_Log_Calculo("[ Valor ICMS Efetivo ] = "+String(Round(ivo_Atributo_NF.vl_bc_icms_efetivo * ivo_Atributo_NF.pc_icms_efetivo/100, 2),"#,###,##0.00"))
		
		ivo_Atributo_NF.vl_bc_icms_efetivo	= Round(al_qtde * lvdc_Preco_Liquido, 2)
		ivo_Atributo_NF.pc_icms_efetivo		= lvdc_Aliq_ICMS_Venda + lvdc_Aliq_FCP_Venda
		ivo_Atributo_NF.vl_icms_efetivo 		= Round(ivo_Atributo_NF.vl_bc_icms_efetivo * ivo_Atributo_NF.pc_icms_efetivo/100, 2)
	Else
		SetNull(ivo_Atributo_NF.vl_bc_icms_efetivo)
		SetNull(ivo_Atributo_NF.pc_icms_efetivo)
		SetNull(ivo_Atributo_NF.vl_icms_efetivo)
	End If
	
	This.Of_Log_Calculo("~r~n************** Calculo PIS/COFINS **************")
	lvdc_Total_ICMS_Base_PIS = al_qtde * gf_coalesce(ivo_Atributo_NF.vl_icms_prd,0) //+ FCP Normal (n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ o FCP ST)
	If Not of_Retorna_Tributacao_Pis_Cofins(	ivo_Atributo.Cd_Natureza_Operacao, &
															ao_produto.cd_produto, &
				/* Vl. Total Item */					al_qtde * lvdc_Total_Liquido,  &
				/* Vl. Total ICMS Dedu$$HEX2$$e700e300$$ENDHEX$$o */		lvdc_Total_ICMS_Base_PIS, &
															ref ivo_Atributo_NF.cd_cst_pis, &
															ref ivo_Atributo_NF.vl_bc_pis, &
															ref ivo_Atributo_NF.pc_aliq_pis, & 
															ref ivo_Atributo_NF.vl_pis, &
															ref ivo_Atributo_NF.cd_cst_cofins, &
															ref ivo_Atributo_NF.vl_bc_cofins, &
															ref ivo_Atributo_NF.pc_aliq_cofins, & 
															ref ivo_Atributo_NF.vl_cofins, True, ref ls_MSG) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
		ivb_Erro = True
	End If

	
	This.Of_Log_Calculo("~r~n************** Mensagens e Benef$$HEX1$$ed00$$ENDHEX$$cios **************")
	//Busca c$$HEX1$$f300$$ENDHEX$$digo benef$$HEX1$$ed00$$ENDHEX$$cio
	ivo_Atributo_NF.cd_beneficio = This.of_Retorna_Codigo_Beneficio(gvo_parametro.ivs_uf_filial				, &
																						 ivo_Atributo.Cd_Natureza_Operacao	, &
																						 ao_produto.cd_st_origem				, &
																						 ivo_Atributo_NF.cd_st_tributacao		, &
																						 ao_produto.cd_produto)
	This.Of_Log_Calculo("C$$HEX1$$f300$$ENDHEX$$digo Beneficio (cBENEF) = "+gf_coalesce(ivo_Atributo_NF.cd_beneficio,""))
	

	//Mensagem Fiscal (ser$$HEX1$$e100$$ENDHEX$$ atribu$$HEX1$$ed00$$ENDHEX$$da na classe de atributo NF)
	This.Of_Retorna_Mensagem_Fiscal(	gvo_parametro.ivs_uf_filial				, &
													ivo_Atributo.Cd_Natureza_Operacao	, &
													ao_produto.cd_st_origem				, &
													ivo_Atributo_NF.cd_st_tributacao		, &
													ao_produto.cd_produto					, &
													ivo_Atributo_NF.cd_beneficio			, & 
													ref ivo_Atributo_NF)
	This.Of_Log_Calculo("Mensagem Fiscal = "+gf_coalesce(ivo_Atributo_NF.de_mensagem_fiscal, ''))
		
	// Acumula os valores de ICMS por al$$HEX1$$ed00$$ENDHEX$$quota, passar a base de c$$HEX1$$e100$$ENDHEX$$lculo total
	This.of_Acumula_Aliquotas(ivo_Atributo_NF.pc_icms, Round(ivo_Atributo_NF.vl_bc_icms_prd * al_Qtde, 2))
	
	//Arredonda vari$$HEX1$$e100$$ENDHEX$$veis para casas decimais definidas para retorno
	ivo_Atributo_NF.vl_bc_icms_prd		= Round(ivo_Atributo_NF.vl_bc_icms_prd, ivl_Decimais)
	ivo_Atributo_NF.vl_icms_prd			= Round(ivo_Atributo_NF.vl_icms_prd, ivl_Decimais)
	//ivo_Atributo_NF.vl_icms_desonerado	= Round(ivo_Atributo_NF.vl_icms_desonerado, ivl_Decimais)	
	//ivo_Atributo_NF.vl_icms_operacao		= Round(ivo_Atributo_NF.vl_icms_operacao, ivl_Decimais)	
	//ivo_Atributo_NF.vl_icms_diferido			= Round(ivo_Atributo_NF.vl_icms_diferido, ivl_Decimais)	
Else
	ivb_Erro = True
End If
end subroutine

public subroutine of_grava_icms_produto (uo_produto ao_produto, long al_qtde, decimal adc_preco_bruto, decimal adc_desconto, string as_tributacao_icms, decimal adc_aliquota_icms);This.of_Grava_ICMS_Produto(ao_Produto, &
									al_Qtde, &
									adc_Preco_Bruto, &
									adc_Desconto, &
									as_tributacao_icms, &
									adc_Aliquota_ICMS, &
									0, False, "", "",0)
end subroutine

public subroutine of_grava_icms_produto (long al_produto, long al_qtde, decimal adc_preco_bruto, decimal adc_desconto, string as_tributacao_icms, decimal adc_aliquota_icms, decimal adc_desconto_nf);uo_Produto lvo_Produto
lvo_Produto = Create uo_Produto

lvo_Produto.of_Localiza_Codigo_Interno(al_Produto)

If lvo_Produto.Localizado Then
	This.of_Grava_ICMS_Produto(lvo_Produto, &
										al_Qtde, &
										adc_Preco_Bruto, &
										adc_Desconto, &
										as_tributacao_icms, &
										adc_Aliquota_ICMS, &
										0, False, "", "",adc_desconto_nf)
End If
									
Destroy(lvo_Produto)


end subroutine

public subroutine of_grava_icms_produto (long al_produto, long al_qtde, decimal adc_preco_bruto, decimal adc_desconto, string as_tributacao_icms, decimal adc_aliquota_icms);uo_Produto lvo_Produto
lvo_Produto = Create uo_Produto

lvo_Produto.of_Localiza_Codigo_Interno(al_Produto)

ivb_Erro = False

If lvo_Produto.Localizado Then
	This.of_Grava_ICMS_Produto(lvo_Produto, &
										al_Qtde, &
										adc_Preco_Bruto, &
										adc_Desconto, &
										as_tributacao_icms, &
										adc_Aliquota_ICMS, &
										0, False, "", "",0)
End If
									
Destroy(lvo_Produto)


end subroutine

public function boolean of_retorna_mensagem_fiscal (string as_uf_emitente, long al_cfop, string as_st_origem, string as_cst, long al_produto, string as_codigo_beneficio, ref uo_atributo_fiscal_nf ao_atributo_fiscal);Long lvl_Ordem
Long lvl_CD_Mensagem_Fiscal
String lvs_DE_Mensagem_Fiscal
String lvs_CD_Beneficio
String lvs_Antecipa_ICMS
String lvs_Tributacao_ICMS

Try
	//Zera vari$$HEX1$$e100$$ENDHEX$$veis
	SetNull(ao_atributo_fiscal.cd_mensagem_fiscal)
	ao_atributo_fiscal.de_mensagem_fiscal = ""
	
	//Trata nulo
	If IsNull(as_cst) Then as_cst = ""
	If IsNull(as_st_origem) Then as_st_origem = ""
	
	//Localiza a tributa$$HEX2$$e700e300$$ENDHEX$$o ICMS pela CST
	If Not IsValid(ivo_Tributacao) Then ivo_Tributacao = Create uo_Tributacao_ICMS
	ivo_Tributacao.of_Localiza_Tributacao_CST( as_cst )
	//Localiza o tipo de produto fiscal
	If Not IsValid(ivo_tipo_produto_fiscal) Then ivo_tipo_produto_fiscal = Create uo_tipo_produto_fiscal
	If al_produto > 0 Then
		If Not ivo_tipo_produto_fiscal.Of_Tipo_Produto_Fiscal_UF( as_uf_emitente, al_produto, ivo_Tributacao.cd_tributacao_icms, ref lvs_Antecipa_ICMS) Then Return False
	End if
	
	//Ordem de Prioridade:
	//			 1 - [CFOP] + [Tipo Produto Fiscal] + [CST] + [Origem]
	//			 2 - [CFOP] + [Tipo Produto Fiscal] + [CST]
	//			 3 - [Produto UF]
	//			 4 - [CFOP] + [CST] + [Origem]
	//			 5 - [CFOP] + [CST]
	//			 6 - [CFOP] + [Origem]
	//			 7 - [CFOP]
	
	//Declara cursor	
	DECLARE lcu_Mensagem_Fiscal CURSOR FOR
	select x.nr_ordem, x.cd_beneficio, x.cd_mensagem_fiscal, x.de_mensagem_fiscal
	from (   select	case when uc.cd_tipo_produto_fiscal is null then 0 else 5 end + case when uc.cd_cst is null then 0 else 2 end + case when uc.cd_st_origem is null then 0 else 1 end as nr_ordem,
						coalesce(uc.cd_beneficio,'') as cd_beneficio,
						uc.cd_mensagem_fiscal,
						m.de_mensagem_fiscal
				from unidade_federacao_cfop uc
				left outer join mensagem_fiscal m
					on m.cd_mensagem_fiscal = uc.cd_mensagem_fiscal
				Where cd_unidade_federacao = :as_uf_emitente
					And cd_natureza_operacao = :al_cfop
					And coalesce(uc.cd_st_origem, :as_st_origem) = :as_st_origem
					And coalesce(uc.cd_cst, :as_cst) = :as_cst
					And coalesce(uc.cd_tipo_produto_fiscal, :ivo_tipo_produto_fiscal.cd_tipo_produto_fiscal) = :ivo_tipo_produto_fiscal.cd_tipo_produto_fiscal
					And coalesce(uc.cd_mensagem_fiscal, 0) > 0
			
				UNION
			
				select 	6 as nr_ordem, 
							coalesce(pu.cd_beneficio,'') as cd_beneficio, 
							pu.cd_mensagem_fiscal,
							m.de_mensagem_fiscal
				From produto_uf pu
				left outer join mensagem_fiscal m
					on m.cd_mensagem_fiscal = pu.cd_mensagem_fiscal
				Where pu.cd_produto = :al_produto
					And pu.cd_unidade_federacao = :as_uf_emitente
					And coalesce(pu.cd_mensagem_fiscal, 0)>0) x			
			
	order by 1 desc, 2 desc
	Using SQLCa;
	
	//Abre cursor
	Open lcu_Mensagem_Fiscal;
	
	//Pega o primeiro valor
	FETCH lcu_Mensagem_Fiscal INTO :lvl_Ordem, :lvs_CD_Beneficio, :lvl_CD_Mensagem_Fiscal, :lvs_DE_Mensagem_Fiscal;
	
	//Verifica erro
	Choose Case SQLCA.SQLCode
		Case -1
			SQLCa.Of_MsgDBError( "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo do benef$$HEX1$$ed00$$ENDHEX$$cio da opera$$HEX2$$e700e300$$ENDHEX$$o.")
			Return False
			
		Case 0
			//Atribui os parametros a classe para retorno
			ao_atributo_fiscal.cd_mensagem_fiscal = lvl_CD_Mensagem_Fiscal
			ao_atributo_fiscal.de_mensagem_fiscal = lvs_DE_Mensagem_Fiscal
	End Choose	
	
	//Fecha o cursor
	CLOSE lcu_Mensagem_Fiscal;

Catch (RuntimeError lvo_Erro)
	MessageBox("ERRO", lvo_Erro.GetMessage(), StopSign!)
	Return False

Finally
	//
End Try

Return True
end function

public function string of_retorna_mensagem_fiscal (string as_uf_emitente, long al_cfop, string as_st_origem, string as_cst, long al_produto);String lvs_Null
String lvs_Retorno

Try
	SetNull(lvs_Null)
	uo_atributo_fiscal_nf lvo_atributo_fiscal
	lvo_atributo_fiscal = Create uo_atributo_fiscal_nf

	If Not This.Of_Retorna_Mensagem_Fiscal( as_uf_emitente, al_cfop, as_st_origem, as_cst, al_produto, lvs_Null, ref lvo_atributo_fiscal) Then Return ""
	
	lvs_Retorno = lvo_atributo_fiscal.de_mensagem_fiscal
	
Catch (RuntimeError lvo_Erro)
	MessageBox("Erro", lvo_erro.GetMessage(), StopSign!)
	Return ""

Finally
	If IsValid(lvo_atributo_fiscal) Then Destroy(lvo_atributo_fiscal)
End Try

Return lvs_Retorno
end function

public function string of_retorna_codigo_beneficio (string as_uf_emitente_nf, long al_cfop, string as_cst, long al_produto);Return This.Of_Retorna_Codigo_Beneficio(as_uf_emitente_nf, al_cfop, "", as_cst, al_produto)
end function

public function string of_retorna_codigo_beneficio (string as_uf_emitente_nf, long al_cfop, string as_st_origem, string as_cst, long al_produto);Long lvl_Ordem
String lvs_Cod_Beneficio
String lvs_Antecipa_ICMS
String lvs_Tributacao_ICMS
String lvs_Usa_Benef_ST

Try
	//Trata nulo
	If IsNull(as_cst) Then as_cst = ""
	If IsNull(as_st_origem) Then as_st_origem = ""
	
	//Se forem diferentes das CSTs sem beneficio
	//O Rio Grande do Sul tem c$$HEX1$$f300$$ENDHEX$$digos de benef$$HEX1$$ed00$$ENDHEX$$cio para produtos com ICMS ST
	If as_cst<>"" and as_cst <> '00' then 
		//Verifica se a UF exige envio do cBenef para ICMS ST
		If ivo_UF_Origem.cd_unidade_federacao = as_uf_emitente_nf Then
			lvs_Usa_Benef_ST = ivo_UF_Origem.id_utiliza_cbenef_st
		ElseIf ivo_UF_Destino.cd_unidade_federacao = as_uf_emitente_nf Then
			lvs_Usa_Benef_ST = ivo_UF_Destino.id_utiliza_cbenef_st
		Else
			Select coalesce(id_utiliza_cbenef_st, 'N')
			Into :lvs_Usa_Benef_ST
			From unidade_federacao
			Where cd_unidade_federacao = :as_uf_emitente_nf
			Using SQLCa;
		End If
		
		//Se a UF n$$HEX1$$e300$$ENDHEX$$o necessita enviar cBenef para ICMS ST
		If (lvs_Usa_Benef_ST="N") and (as_cst = "60" or as_cst = "10") Then Return lvs_Cod_Beneficio
		
		//Localiza a tributa$$HEX2$$e700e300$$ENDHEX$$o ICMS pela CST
		If Not IsValid(ivo_Tributacao) Then ivo_Tributacao = Create uo_Tributacao_ICMS
		ivo_Tributacao.of_Localiza_Tributacao_CST( as_cst )
		//Localiza o tipo de produto fiscal
		If Not IsValid(ivo_tipo_produto_fiscal) Then ivo_tipo_produto_fiscal = Create uo_tipo_produto_fiscal
		If al_produto > 0 Then
			If Not ivo_tipo_produto_fiscal.Of_Tipo_Produto_Fiscal_UF( as_uf_emitente_nf, al_produto, ivo_Tributacao.cd_tributacao_icms, ref lvs_Antecipa_ICMS) Then Return ""
		End if
		
		//Ordem de Prioridade:
		//			 1 - [CFOP] + [Tipo Produto Fiscal] + [CST] + [Origem]
		//			 2 - [CFOP] + [Tipo Produto Fiscal] + [CST]
		//			 3 - [Produto UF]
		//			 4 - [CFOP] + [CST] + [Origem]
		//			 5 - [CFOP] + [CST]
		//			 6 - [CFOP] + [Origem]
		//			 7 - [CFOP]
		
		//Declara cursor
		DECLARE lcu_Beneficio CURSOR FOR
		select x.nr_ordem, x.cd_beneficio
		from (   select  case when uc.cd_tipo_produto_fiscal is null then 0 else 5 end + case when uc.cd_cst is null then 0 else 2 end + case when uc.cd_st_origem is null then 0 else 1 end as nr_ordem,
							 uc.cd_beneficio
					from unidade_federacao_cfop uc
					Inner Join unidade_federacao uf
						on uf.cd_unidade_federacao = uc.cd_unidade_federacao
					Where uc.cd_unidade_federacao = :as_uf_emitente_nf
						And uf.dh_inicio_envio_cbenef <= dbo.uf_dh_parametro()
						And uc.cd_natureza_operacao = :al_cfop
						And coalesce(uc.cd_st_origem, :as_st_origem) = :as_st_origem
						And coalesce(uc.cd_cst, :as_cst) = :as_cst
						And coalesce(uc.cd_tipo_produto_fiscal, :ivo_tipo_produto_fiscal.cd_tipo_produto_fiscal) = :ivo_tipo_produto_fiscal.cd_tipo_produto_fiscal
						And coalesce(uc.cd_beneficio, '') <> ''
				
					UNION
				
					select 6 as nr_ordem, pu.cd_beneficio
					From produto_uf pu
					Inner Join unidade_federacao uf
						on uf.cd_unidade_federacao = pu.cd_unidade_federacao
					Where pu.cd_produto = :al_produto
						And pu.cd_unidade_federacao = :as_uf_emitente_nf
						And uf.dh_inicio_envio_cbenef <= dbo.uf_dh_parametro()
						And coalesce(pu.cd_beneficio, '')<>'') x			
				
		order by 1 desc
		Using SQLCa;
		
		//Abre cursor
		Open lcu_Beneficio;
		
		//Pega o primeiro valor
		FETCH lcu_Beneficio INTO :lvl_Ordem, :lvs_Cod_Beneficio;
		
		//Verifica erro
		If SQLCA.SQLCode = -1 Then
			SQLCa.Of_MsgDBError( "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo do benef$$HEX1$$ed00$$ENDHEX$$cio da opera$$HEX2$$e700e300$$ENDHEX$$o.")
			SetNull(lvs_Cod_Beneficio)
		End If	
		
		//Fecha o cursor
		CLOSE lcu_Beneficio;
	Else
		SetNull(lvs_Cod_Beneficio)
	End If 
	
Catch(RuntimeError lvo_Erro)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvo_Erro.GetMessage(), StopSign!)
	SetNull(lvs_Cod_Beneficio)
	
Finally
	//Se n$$HEX1$$e300$$ENDHEX$$o tiver encontrado retorna nulo
	If lvs_Cod_Beneficio = "" Then SetNull(lvs_Cod_Beneficio)
End Try

Return lvs_Cod_Beneficio
end function

public subroutine of_grava_natureza_operacao (long pl_cfop);ivl_CFOP_Fixa = pl_cfop
end subroutine

public function boolean of_retorna_custo_desfazimento (long al_filial_origem, long al_filial_destino, long al_produto, long al_tipo_produto_fiscal, date adt_data, decimal adc_custo_original, long al_qtd_nota_origem, decimal adc_aliq_icms_operacao, ref decimal adc_custo_sem_imposto);//Utilizar somente para opera$$HEX2$$e700f500$$ENDHEX$$es que necessitam retirar o imposto de dentro do custo do produto
Boolean	lvb_Erro = False, &
			lvb_Tem_Desfazimento = False
			
Long 	ll_Linhas, &
		ll_Linha

Date 	ldt_movimento

Long 	ll_qtde_movimento,&
		ll_qtde_disponivel,&
		ll_qtde_operacao,&
		ll_qtde_necessidade, &
		ll_Tributacao_Produto
		
String		ls_Tributacao_ICMS, &
			ls_Antecipacao_ICMS = "N"

Decimal {4} ldc_Redutor
Decimal {2} ldc_custo_fator
Decimal {2} ldc_Vl_ICMS_ST 
Decimal {2} ldc_Vl_ICMS
Decimal {2} ldc_Vl_ICMS_ST_Fiscal  
Decimal {2} ldc_Vl_IPI

// Campos para Acumular
Decimal {2} ldc_acum_vl_icms_st_fiscal 	= 0	//BASE ICMS ST * ALIQ. ST
Decimal {2} ldc_acum_vl_icms 				= 0	//VALOR ICMS
Decimal {2} ldc_acum_vl_icms_st 			= 0	//VALOR ICMS ST
Decimal {2} ldc_acum_vl_ipi 				= 0	//VALOR IPI

Try
	//A necessidade a ser encontrada inicialmente $$HEX1$$e900$$ENDHEX$$ igual a quantidade transferida
	ll_qtde_necessidade  		= al_qtd_nota_origem
	//O retorno rece o valor original, para caso n$$HEX1$$e300$$ENDHEX$$o entre nas condi$$HEX2$$e700f500$$ENDHEX$$es ter o valor original como retorno
	adc_custo_sem_imposto	= adc_custo_original
	
	//Verifica se as UFs Origem/Destino foram atribu$$HEX1$$ed00$$ENDHEX$$das
	If 	IsNull(ivo_UF_Origem.cd_unidade_federacao) or (ivo_UF_Origem.cd_unidade_federacao = "") or &
		IsNull(ivo_UF_Destino.cd_unidade_federacao) or (ivo_UF_Destino.cd_unidade_federacao = "") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sem informa$$HEX2$$e700e300$$ENDHEX$$o de UF origem e destino.~r~rNecess$$HEX1$$e100$$ENDHEX$$rio antes da chamada "+&
										"da fun$$HEX2$$e700e300$$ENDHEX$$o uo_tratamento_fiscal.of_retorna_custo_desfazimento() "+ &
										"efetuar a chamada da fun$$HEX2$$e700e300$$ENDHEX$$o uo_tratamento_fiscal.Of_grava_uf_origem_destino().", Exclamation!)
		Return False
	End If
	
	//Somente para opera$$HEX2$$e700f500$$ENDHEX$$es interestaduais ou destinadas ao CD
	If (ivo_UF_Origem.cd_unidade_federacao <> ivo_UF_Destino.cd_unidade_federacao) or (al_filial_origem <> 534 and al_filial_destino = 534) Then
		//Somente para produtos n$$HEX1$$e300$$ENDHEX$$o medicamentos com sa$$HEX1$$ed00$$ENDHEX$$da do Perini, ou destinados ao CD
		If (al_filial_origem = 534 and al_tipo_produto_fiscal <> 1) or (al_filial_origem <> 534 and al_filial_destino = 534) Then
			//Verifica se est$$HEX1$$e100$$ENDHEX$$ na base da matriz ou loja
			If This.of_Base_Matriz( ) Then
				//MATRIZ (Sybase)
				Select p.cd_tributacao_produto, p. cd_tributacao_icms
				Into :ll_Tributacao_Produto, :ls_Tributacao_ICMS
				From produto_uf p, tipo_icms t
				Where p.cd_unidade_federacao 	= :ivo_UF_Origem.cd_unidade_federacao  //UF Origem, pois se a UF tem ST e est$$HEX1$$e100$$ENDHEX$$ saindo dela precisa desfazer
				  and p.cd_produto  		   			= :al_Produto
				  and t.cd_tipo_icms					= p.cd_tipo_icms
				Using Sqlca;
			Else
				//LOJA (PostgreSQL)
				Select p.cd_tributacao_produto, p. cd_tributacao_icms
				Into :ll_Tributacao_Produto, :ls_Tributacao_ICMS
				From produto_geral p, tipo_icms t
				where p.cd_produto 		= :al_Produto
					and t.cd_tipo_icms		= p.cd_tipo_icms
				Using Sqlca;
			End If
			
			If SQLCa.SQLCode = -1 Then
				SQLCa.Of_Msgdberror( "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar as informa$$HEX2$$e700f500$$ENDHEX$$es de tributa$$HEX2$$e700e300$$ENDHEX$$o para o desfazimento de imposto do produto "+String(al_produto)+".~rFun$$HEX2$$e700e300$$ENDHEX$$o: uo_tratamento_fiscal.of_retorna_custo_desfazimento().")
				Return False
			End If
			
			//Se na UF origem o produto tiver ICMS ST, ent$$HEX1$$e300$$ENDHEX$$o ter$$HEX1$$e100$$ENDHEX$$ desfazimento
			lvb_Tem_Desfazimento = (ls_Tributacao_ICMS = "1" or ls_Tributacao_ICMS="3" or ls_Tributacao_ICMS="7" or ls_Tributacao_ICMS="6")
			
			If Not lvb_Tem_Desfazimento Then
				//Recupera informa$$HEX2$$e700f500$$ENDHEX$$es do Tipo de Produto Fiscal (necess$$HEX1$$e100$$ENDHEX$$rio para antecipa$$HEX2$$e700e300$$ENDHEX$$o ICMS)
				If ls_Tributacao_ICMS = "0" or ls_Tributacao_ICMS = "2" Then
					//Verifica se para esse produto existe a antecipa$$HEX2$$e700e300$$ENDHEX$$o ICMS
					ivo_tipo_produto_fiscal.of_tipo_produto_fiscal_uf( ivo_UF_Origem.cd_unidade_federacao, al_produto, ls_Tributacao_ICMS, ref ls_Antecipacao_ICMS)
					//Se houver a antecipa$$HEX2$$e700e300$$ENDHEX$$o do ICMS, significa que no custo possui uma adi$$HEX2$$e700e300$$ENDHEX$$o de valor que precisa ser desfeita
					lvb_Tem_Desfazimento = (ls_Antecipacao_ICMS = "S")
				End If
			End If
			
			//Deve ser realizado o Desfazimento?
			If lvb_Tem_Desfazimento Then
				// Data Store
				dc_uo_ds_base lds1 
				lds1  = Create dc_uo_ds_base
				If Not lds1.of_ChangeDataObject('dw_ge021_lista_movimento_tributacao', False) Then 
					gvo_aplicacao.of_grava_log("GE021 - Lista Movimento Tributacao Produto - Erro [dw_ge021_lista_movimento_tributacao] - uo_tratamento_fiscal.of_localiza_custo_produto")
					Return False 
				End If
				
				// Executa DW - Busca no movimento_produto_tributacao as entradas dispon$$HEX1$$ed00$$ENDHEX$$veis
				ll_Linhas = lds1.Retrieve(al_filial_origem , al_produto , adt_data)
				
				If ll_Linhas > 0 Then 
					For ll_Linha = 1 To ll_Linhas	
				
						ll_qtde_movimento 		= lds1.Object.qt_movimento	[ll_Linha]
						ll_qtde_disponivel 			= lds1.Object.qt_disponivel		[ll_Linha]
						ldc_Vl_ICMS					= lds1.Object.vl_icms				[ll_Linha]
						ldc_Vl_ICMS_ST			= lds1.Object.vl_icms_st			[ll_Linha]
						ldc_Vl_ICMS_ST_Fiscal	= lds1.Object.vl_icms_st_fiscal	[ll_Linha]
						ldc_Vl_IPI					= lds1.Object.vl_ipi				[ll_Linha]
						
						//  Calculo 1
						If (ll_qtde_necessidade>=ll_qtde_disponivel) Then
							ll_qtde_operacao		= ll_qtde_disponivel
							ll_qtde_necessidade 	= ll_qtde_necessidade -  ll_qtde_disponivel
							ll_qtde_disponivel		= 0			
						Else
							ll_qtde_operacao		= ll_qtde_necessidade
							ll_qtde_disponivel		= ll_qtde_disponivel - ll_qtde_necessidade
							ll_qtde_necessidade	= 0 			
						End If 		
						
						//Pondera$$HEX2$$e700e300$$ENDHEX$$o de Valores
						ldc_Vl_ICMS					= Round(Round(ldc_Vl_ICMS / ll_qtde_movimento,4) * ll_qtde_operacao, 2)
						ldc_Vl_ICMS_ST			= Round(Round(ldc_Vl_ICMS_ST / ll_qtde_movimento,4) * ll_qtde_operacao, 2)
						ldc_Vl_IPI					= Round(Round(ldc_Vl_IPI / ll_qtde_movimento,4) * ll_qtde_operacao, 2)
						ldc_Vl_ICMS_ST_Fiscal 	= Round(Round(ldc_Vl_ICMS_ST_Fiscal / ll_qtde_movimento,4) * ll_qtde_operacao, 2)
						
						// Rotina antiga, apenas para valores zerados, para n$$HEX1$$e300$$ENDHEX$$o haver problema na pondera$$HEX2$$e700e300$$ENDHEX$$o m$$HEX1$$e900$$ENDHEX$$dia
						If (IsNull(ldc_vl_icms_st_fiscal)) or (ldc_vl_icms_st_fiscal = 0)  Then 
							ldc_vl_icms_st_fiscal	=	0		
				
							// Faz o calculo Redutor
							If Not This.of_Redutor_Custo_Produto(	gvo_Parametro.ivs_uf_filial,&
																				ivo_UF_Destino.cd_unidade_federacao,&	
																				al_produto, &
																				Ref ldc_Redutor) Then
								Return False
							End If
							//C$$HEX1$$e100$$ENDHEX$$lcula um custo reduzido
							ldc_custo_fator = Round(adc_custo_original /  ldc_Redutor, 2)
							
							//Aborta Faturamento
							If IsNull(ldc_custo_fator) or ldc_custo_fator <= 0 Then 
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Custo do produto " + String(al_produto) + " n$$HEX1$$e300$$ENDHEX$$o localizado ou inv$$HEX1$$e100$$ENDHEX$$lido.",StopSign!)
								Return False
							End If	
							
							//Calcula o valor ST fiscal, que $$HEX1$$e900$$ENDHEX$$ a diferen$$HEX1$$e700$$ENDHEX$$a do valor retirado do custo
							ldc_vl_icms_st_fiscal	= round((adc_custo_original  -  ldc_custo_fator) * ll_qtde_operacao ,2) 
							ldc_Vl_ICMS_ST		= ldc_vl_icms_st_fiscal
						End If 			
						
						// Acumula o Valor
						ldc_acum_vl_icms_st_fiscal	+= ldc_Vl_ICMS_ST_Fiscal		
						ldc_acum_vl_icms_st			+= ldc_Vl_ICMS_ST	
						ldc_acum_vl_icms 				+= ldc_Vl_ICMS			
						ldc_acum_vl_ipi 				+= ldc_Vl_IPI		
						
						//Se n$$HEX1$$e300$$ENDHEX$$o houver mais necessidade sai da fun$$HEX2$$e700e300$$ENDHEX$$o
						If ll_qtde_necessidade <= 0 Then Exit
					Next 
				Else
					// Rotina antiga, apenas para valores zerados, para n$$HEX1$$e300$$ENDHEX$$o haver problema na pondera$$HEX2$$e700e300$$ENDHEX$$o m$$HEX1$$e900$$ENDHEX$$dia	
			
					// Faz o calculo Redutor
					If Not This.of_Redutor_Custo_Produto(	gvo_Parametro.ivs_uf_filial					, &
																		ivo_UF_Destino.cd_unidade_federacao	, &	
																		al_produto										, &
																		Ref ldc_Redutor) Then
						Return False
					End If
					
					//C$$HEX1$$e100$$ENDHEX$$lcula um custo reduzido
					ldc_custo_fator = Round(adc_custo_original /  ldc_Redutor, 2)
						
					//Aborta Faturamento
					If IsNull(ldc_custo_fator) or ldc_custo_fator <= 0 Then 
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Custo do produto " + String(al_produto) + " n$$HEX1$$e300$$ENDHEX$$o localizado ou inv$$HEX1$$e100$$ENDHEX$$lido.",StopSign!)
						Return False
					End If	
						
					//Calcula o valor ST fiscal, que $$HEX1$$e900$$ENDHEX$$ a diferen$$HEX1$$e700$$ENDHEX$$a do valor retirado do custo
					ldc_acum_vl_icms_st_fiscal	= round((adc_custo_original  -  ldc_custo_fator) * al_qtd_nota_origem ,2) 
					ldc_acum_vl_icms_st			= ldc_acum_vl_icms_st_fiscal		
				End If 
				
				// Iguala os custos
				adc_custo_sem_imposto = adc_custo_original
				// Remove ICMS e ICMS ST (m$$HEX1$$e900$$ENDHEX$$dio ponderado)
				adc_custo_sem_imposto -= round( ldc_acum_vl_icms_st_fiscal / al_qtd_nota_origem, 2 )
				// Remove o IPI (m$$HEX1$$e900$$ENDHEX$$dio ponderado)
				adc_custo_sem_imposto -= round( ldc_acum_vl_ipi / al_qtd_nota_origem, 2 )
				// Embute o valor de ICMS no custo referente a al$$HEX1$$ed00$$ENDHEX$$quota de ICMS a ser praticada na nova opera$$HEX2$$e700e300$$ENDHEX$$o
				adc_custo_sem_imposto = Round(adc_custo_sem_imposto / (1 - adc_aliq_icms_operacao / 100), 2)
				// Adiciona novamente o IPI (m$$HEX1$$e900$$ENDHEX$$dio ponderado)
				adc_custo_sem_imposto += round( ldc_acum_vl_ipi / al_qtd_nota_origem, 2 )
				
			End If //Fim deve realizar desfazimento
		End If
	End If

Catch (RuntimeError lvo_Erro)
	gvo_aplicacao.of_grava_log(lvo_Erro.GetMessage())
	MessageBox('Erro', lvo_Erro.GetMessage(), StopSign! )
	lvb_Erro = False
	
Finally
	If IsValid(lds1) Then Destroy(lds1)
End Try

Return Not(lvb_Erro)
end function

public function boolean of_retorna_utiliza_cbenef (readonly string ps_uf, readonly string ps_cst);Boolean lvb_Retorno = False

String lvs_Usa_Benef_ST
Datetime lvdh_Inicio_cBenef

//CST 00 n$$HEX1$$e300$$ENDHEX$$o informa cBENEF
//CST 90 n$$HEX1$$e300$$ENDHEX$$o informa cBENEF /*Chamado: 1512367 */
If ps_cst <> "00" And ps_cst <> "90" Then	
	//Verifica se h$$HEX1$$e100$$ENDHEX$$ obrigatoriedade de envio do cBenef na UF
	Select coalesce(id_utiliza_cbenef_st, 'N'), dh_inicio_envio_cbenef
	Into :lvs_Usa_Benef_ST, :lvdh_Inicio_cBenef
	From unidade_federacao
	Where cd_unidade_federacao = :ps_uf
	Using SQLCa;	
		
	If SQLCa.SQLCode = -1 Then
		SQLCa.Of_RollBack()
		SQLCa.Of_MsgDbError('Falha ao localizar se a filial deve enviar o cBENEF.')
		Return False
	End If

	//Envio do cBenef obrigat$$HEX1$$f300$$ENDHEX$$rio
	If lvdh_Inicio_cBenef <= gf_getserverdate() then			
		//Para CSTs 60 e 10 (ICMS ST sem redu$$HEX2$$e700e300$$ENDHEX$$o) h$$HEX1$$e100$$ENDHEX$$ uma configura$$HEX2$$e700e300$$ENDHEX$$o no cadastro da UF
		If (ps_cst='60') or (ps_cst = '10') Then
			//Verifica se a UF envia cBENEF para CST 60 e 10 (atualmente somente o RS)
			If lvs_Usa_Benef_ST = "S" Then
				lvb_Retorno = True
			End If
		Else
			//Outras CSTs (n$$HEX1$$e300$$ENDHEX$$o 00, 10, 60) e a UF j$$HEX1$$e100$$ENDHEX$$ obriga o envio
			lvb_Retorno = True
		End If	
	End If
End If

Return lvb_Retorno
end function

public function boolean of_localiza_dados_adicionais_uf (long al_filial_origem, string as_uf_destino, ref string as_dados_adicionais);
Select de_msg_dados_adicionais 
Into :as_dados_adicionais
From  filial_inscricao_estadual_st
Where cd_filial =:al_filial_origem
And     cd_unidade_federacao =:as_uf_destino
Using SqlCA;


If SQLCa.SQLCode = -1 Then
	SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dados msg adicionais'" + as_uf_destino + "'")
	Return False
End If 


Return True 


end function

public function decimal of_reducao_base_icms (long pl_produto, string ps_cd_uf);Decimal{4} lvdc_Red_Base_ICMS

select pc_reducao_base_icms
Into :lvdc_Red_Base_ICMS
From produto_uf pu
Where pu.cd_produto = :pl_produto
	And pu.cd_unidade_federacao = :ps_cd_uf
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	SQLCa.Of_MsgDBError( "Falha na busca pela redu$$HEX2$$e700e300$$ENDHEX$$o de base ICMS (produto_uf.pc_reducao_base_icms)." )
End If

Return gf_coalesce(lvdc_Red_Base_ICMS, 0)
end function

public function boolean of_permite_retirada_perini (string as_tipo_retirada, long al_filial, long al_produto, boolean ab_mostra_msg, string as_id_possui_acordo, ref long al_tipo_produto_fiscal, ref string as_tipo_operacao);/********ps_Tipo_Retirada
R=RECOLHIMENTO/RECALL
A=AVARIA
D=DEFEITO DE FABRICACAO
E=EXCESSO
V=VENCIDOS
P=PRODUTOS ESPECIAIS

---------------------------------------------------------------------------
Fun$$HEX2$$e700e300$$ENDHEX$$o tambem utilizada para verificar DESCONTO DE PRESTES
RL129 -Cadastro de produtos prestes a vencer
RL095 -Relatorio de produtos prestes a vencer

Quando for validaacao de prestes: ps_tipo_retirada  = ''

***********/

String ls_Tipo_Pemissao, ls_Permissao_dev, ls_Permissao_Transf, ls_DW

Long ll_Retrieve

Boolean lb_Permite_Retirada

Try
	This.ivb_Erro = False
	
	SetNull( al_tipo_produto_fiscal ) 
	SetNull( as_tipo_operacao )
	
	uo_Filial 								lo_Filial
	uo_Produto 							lo_Produto
	uo_ge040_movimento_matriz 	lo_Movimento
	
	lo_Filial 			= Create uo_Filial
	lo_Produto 		= Create uo_Produto
	lo_Movimento 	= Create uo_ge040_movimento_matriz
	
	lo_Filial.Of_localiza_Codigo( al_Filial )
	lo_Produto.of_Localiza_Codigo_Interno( al_Produto )
	
	If Not lo_Filial.localizada		Then Return False
	If Not lo_Produto.localizado	Then Return False
	
	If MId( lo_Produto.cd_subcategoria, 1,1 ) = '5' Then
		If ab_Mostra_Msg Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitida a retirada de estoque de produtos do almoxarifado.", Exclamation! ) 
		End If
		
		Return False
	End If				
			
	//Vencido Permite retirar somente se possuir acordo de devolucao entre o fornecedor e o perini
	If as_Tipo_Retirada = 'V' And as_Id_Possui_Acordo = 'N' Then
		If ab_Mostra_Msg Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O produto " + String(lo_Produto.cd_produto) + " n$$HEX1$$e300$$ENDHEX$$o possui acordo de devolu$$HEX2$$e700e300$$ENDHEX$$o no Perini.", Exclamation!)
		End If
		
		Return False
	End If

	//Veririca movimento matriz
	If Not lo_Movimento.of_verifica_movimento_matriz( lo_Filial.cd_Filial, lo_Produto.Cd_Produto ) Then
		This.ivb_Erro = True
		Return False
	End If
		
	If ivb_Matriz Then
		ls_DW = 'ds_ge021_tipo_permissao_matriz'
	Else
		ls_DW = 'ds_ge021_tipo_permissao_filial' 	
	End If
	
	dc_uo_ds_base lo_DS
	lo_DS = Create dc_uo_ds_base
	
	If Not lo_Ds.of_ChangeDataObject( ls_DW ) Then
		This.ivb_Erro = True
 		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento of_ChangeDataObject. Fun$$HEX2$$e700e300$$ENDHEX$$o: uo_tratamento_fiscal.of_permite_retirada_perini(Long, Long, Boolean, ref Long)", StopSign! )
		Return False	 
	End If
	
	//Inicio
	lb_Permite_Retirada = True

	ll_Retrieve = lo_Ds.Retrieve( lo_Produto.nr_classificacao_fiscal, lo_Filial.cd_unidade_federacao )
	
	Choose Case ll_Retrieve
		Case is < 0
			This.ivb_Erro = True
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no retrieve. Fun$$HEX2$$e700e300$$ENDHEX$$o: uo_tratamento_fiscal.of_permite_retirada_perini(Long, Long, Boolean, ref Long)" , StopSign!)
			Return False	
			
		Case 0
			lb_Permite_Retirada = False
			
		Case is > 0
			If lo_Movimento.Tipo_Operacao = 'D' Then
				ls_Tipo_Pemissao = lo_Ds.Object.id_permissao_devolucao		[ 1 ]  
			Else
				ls_Tipo_Pemissao = lo_Ds.Object.id_permissao_transferencia	[ 1 ]  
			End If
			
			//Nenhum
			If ls_Tipo_Pemissao = 'N' Then
				lb_Permite_Retirada = False
			End If
			
			//Somente sem ST
			If ls_Tipo_Pemissao = 'I' AND lo_Produto.Cd_Tributacao_ICMS = '1' Then 
				lb_Permite_Retirada = False
			End If	
			
			al_Tipo_Produto_Fiscal	= lo_Ds.Object.cd_tipo_produto_fiscal	[ 1 ]		
	End Choose

	If Not lb_Permite_Retirada Then
		If ab_Mostra_Msg Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto n$$HEX1$$e300$$ENDHEX$$o pode ser "+ IIF( lo_Movimento.Tipo_Operacao="D", "devolvido", "transferido") + " para o Perini devido $$HEX1$$e000$$ENDHEX$$ regra fiscal.~r~r" +&
										"C$$HEX1$$f300$$ENDHEX$$digo: " + String(lo_Produto.cd_Produto) + "~r" +&
										"Descri$$HEX2$$e700e300$$ENDHEX$$o: " + lo_Produto.ivs_Descricao_Apresentacao_Venda + "~r" +&
										"NCM: " + String(lo_Produto.nr_Classificacao_Fiscal) , Exclamation!)
		End If
	End If
	
	as_tipo_operacao = lo_Movimento.Tipo_Operacao	
	
	Return lb_Permite_Retirada
Finally	
	If IsValid( lo_DS ) 				Then Destroy lo_DS
	If IsValid( lo_Filial ) 			Then Destroy lo_Filial
	If IsValid( lo_Produto )	 	Then Destroy lo_Produto
	If IsValid( lo_Movimento ) 	Then Destroy lo_Movimento
End Try
end function

public function decimal of_indice_repasse_icms (uo_produto ao_produto, decimal adc_icms);Decimal	lvdc_Aliquota_Compra, &
        		lvdc_Aliquota_Venda,&
		  	lvdc_Aliquota_InterEstadual_Importados
			  
String ls_Utiliza_Aliquota_InterEstadual

If IsNull(ao_Produto.Cd_Tipo_ICMS) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de ICMS n$$HEX1$$e300$$ENDHEX$$o definido para o produto '" + String(ao_Produto.Cd_Produto) + "'.~r~r" + &
								 "Por favor informe o pessoal de suporte ao sistema.", StopSign!)
								 
	lvdc_Aliquota_Venda = 0
Else
	lvdc_Aliquota_Venda = This.of_Aliquota_Tipo_ICMS(ao_Produto.Cd_Tipo_ICMS)		
End If

If ivs_Operacao =  TRANSFERENCIA or ivs_Operacao = COMPRA Then
	If ivs_Estadual = 'N' Then 
		// Qualquer problema no select da fun$$HEX2$$e700e300$$ENDHEX$$o o sistema vai considerar o a aliquota padr$$HEX1$$e300$$ENDHEX$$o
		This.of_Aliquota_ICMS_Origem_Produto(ao_produto, ref ls_Utiliza_Aliquota_InterEstadual, ref lvdc_Aliquota_InterEstadual_Importados)
	
		If ls_Utiliza_Aliquota_InterEstadual = "S" Then
			lvdc_Aliquota_Compra = ivo_UF_Destino.Pc_ICMS_Interestadual
		Else
			lvdc_Aliquota_Compra = lvdc_Aliquota_InterEstadual_Importados
		End If		
	Else
		///Chamado: 934960 - In$$HEX1$$ed00$$ENDHEX$$cio
		lvdc_Aliquota_Compra =  adc_icms 		
		///Chamado: 934960 - Termino
	End If 	
	
Else
	///Chamado: 934960 - In$$HEX1$$ed00$$ENDHEX$$cio
	If ivs_Estadual = 'N' Then 
		lvdc_Aliquota_Compra = ivo_UF_Origem.Pc_ICMS_Interestadual
	Else
		lvdc_Aliquota_Compra =  adc_icms 				
	End If 
	///Chamado: 934960 - Termino
End If

Return This.of_Indice_Repasse_ICMS(lvdc_Aliquota_Compra, lvdc_Aliquota_Venda)
end function

public function decimal of_repasse_icms (uo_produto ao_produto, decimal adc_preco, decimal adc_icms);Decimal lvdc_Indice, &
        lvdc_Valor

lvdc_Indice = This.of_Indice_Repasse_ICMS(ao_Produto, adc_icms )

lvdc_Valor = Round(adc_Preco * lvdc_Indice / 100, 2)

Return lvdc_Valor
end function

public function decimal of_indice_repasse_icms (uo_produto ao_produto);Decimal    lvdc_Aliquota_Compra, &
                lvdc_Aliquota_Venda,&
              lvdc_Aliquota_InterEstadual_Importados
              
String ls_Utiliza_Aliquota_InterEstadual

 

If IsNull(ao_Produto.Cd_Tipo_ICMS) Then
    MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de ICMS n$$HEX1$$e300$$ENDHEX$$o definido para o produto '" + String(ao_Produto.Cd_Produto) + "'.~r~r" + &
                                 "Por favor informe o pessoal de suporte ao sistema.", StopSign!)
                                 
    lvdc_Aliquota_Venda = 0
Else
    lvdc_Aliquota_Venda = This.of_Aliquota_Tipo_ICMS(ao_Produto.Cd_Tipo_ICMS)        
End If

 

If ivs_Operacao =  TRANSFERENCIA or ivs_Operacao = COMPRA Then
    // Qualquer problema no select da fun$$HEX2$$e700e300$$ENDHEX$$o o sistema vai considerar o a aliquota padr$$HEX1$$e300$$ENDHEX$$o
    This.of_Aliquota_ICMS_Origem_Produto(ao_produto, ref ls_Utiliza_Aliquota_InterEstadual, ref lvdc_Aliquota_InterEstadual_Importados)
                                            
    If ls_Utiliza_Aliquota_InterEstadual = "S" Then
        lvdc_Aliquota_Compra = ivo_UF_Destino.Pc_ICMS_Interestadual
    Else
        lvdc_Aliquota_Compra = lvdc_Aliquota_InterEstadual_Importados
    End If
Else
    lvdc_Aliquota_Compra = ivo_UF_Origem.Pc_ICMS_Interestadual
End If

 

Return This.of_Indice_Repasse_ICMS(lvdc_Aliquota_Compra, lvdc_Aliquota_Venda)
end function

public function decimal of_repasse_icms (uo_produto ao_produto, decimal adc_preco);Decimal lvdc_Indice, &
        lvdc_Valor

lvdc_Indice = This.of_Indice_Repasse_ICMS(ao_Produto)

lvdc_Valor = Round(adc_Preco * lvdc_Indice / 100, 2)

Return lvdc_Valor
end function

public function decimal of_pmpf (uo_produto ao_produto);Decimal lvdc_PMPF
Decimal lvdc_PMC

String lvs_UF

// Se a fun$$HEX2$$e700e300$$ENDHEX$$o estiver sendo executada na loja, utiliza o PMPF diretamente da tabela produto
// Sen$$HEX1$$e300$$ENDHEX$$o verifica o PMPF para a UF da filial origem/destino da opera$$HEX2$$e700e300$$ENDHEX$$o

If This.ivl_Filial <> This.ivl_Filial_Matriz Then
	If Not IsNull(ao_Produto.Vl_Preco_Medio_Ponderado_CF) Then
		//Segundo Rosita, se o pre$$HEX1$$e700$$ENDHEX$$o ponderado for superior ao PMC deve ser desprezado
		If ao_Produto.Vl_Preco_Medio_Ponderado_CF > ao_Produto.Vl_Preco_Venda_Maximo Then
			SetNull(ao_Produto.Vl_Preco_Medio_Ponderado_CF)
		End If
		lvdc_PMPF = Round(ao_Produto.Vl_Preco_Medio_Ponderado_CF / ao_Produto.Vl_Fator_Conversao, 2)
	Else
		lvdc_PMPF = 0
	End If
Else
	Choose Case ivs_Operacao
		Case COMPRA, DEVOLUCAO_VENDA, TRANSFERENCIA
			lvs_UF = ivo_UF_Destino.Cd_Unidade_Federacao
			
		Case Else
			lvs_UF = ivo_UF_Origem.Cd_Unidade_Federacao
	End Choose
	
	//Busca PMC e PMPF
	Select vl_preco_medio_ponderado_cf, vl_preco_venda_maximo
	Into :lvdc_PMPF, :lvdc_PMC
	From produto_uf
	Where cd_unidade_federacao	= :lvs_UF
	  and cd_produto           			= :ao_Produto.Cd_Produto
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			//Caso o PMPF exceda o PMC ent$$HEX1$$e300$$ENDHEX$$o deve ser desprezado
			If (gf_coalesce(lvdc_PMC, 0)> 0) and (gf_coalesce(lvdc_PMPF, 0) > gf_coalesce(lvdc_PMC, 0)) Then
				//Comentado para demonstrar o c$$HEX1$$e100$$ENDHEX$$lculo, e tratado na fun$$HEX2$$e700e300$$ENDHEX$$o Of_Base_ST() e Of_Grava_ICMS_Produto()
				//lvdc_PMPF = 0
			End If
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O PMPF do produto '" + String(ao_Produto.Cd_Produto) + "' para UF '" + lvs_UF + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado.~r~r" + &
			                      "Ser$$HEX1$$e100$$ENDHEX$$ considerado zero, e calculado pelo PMC ou MVA.")
			lvdc_PMPF = 0
			
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do PMPF do Produto '" + String(ao_Produto.Cd_Produto) + "' para UF '" + lvs_UF + "'")
			ivb_Erro = True
	End Choose
End If

Return lvdc_PMPF
end function

public subroutine of_log_calculo (string ps_log);If ivb_Log_Calculo Then
	If IsNull(ivs_Log_Calculo) Then ivs_Log_Calculo = ""
	ivs_Log_Calculo += IIF(ivs_Log_Calculo<>"", "~r~n", "")+gf_coalesce(ps_log, '')
End If
end subroutine

private function boolean of_calcula_difa_venda (uo_produto ao_produto, long al_qtde);// **********************************************************************//
// Chamado: 841666 - O chamado foi aberto porque a Lais achava que o c$$HEX1$$e100$$ENDHEX$$lculo estava errado, 		//
//		no entanto depois de analisar melhor descobriu que n$$HEX1$$e300$$ENDHEX$$o era necess$$HEX1$$e100$$ENDHEX$$rio alterar nada.			//
// 	Foi criada esta fun$$HEX2$$e700e300$$ENDHEX$$o, no entando n$$HEX1$$e300$$ENDHEX$$o foi utilizada. 															//
//	Caso seja necess$$HEX1$$e100$$ENDHEX$$rio utilizar $$HEX1$$e900$$ENDHEX$$ imprescind$$HEX1$$ed00$$ENDHEX$$vel que seja feito todos os testes 							//
//	e valida$$HEX2$$e700f500$$ENDHEX$$es novamente.																								//
//***********************************************************************//
// Chamado 1506337: unificado os c$$HEX1$$e100$$ENDHEX$$lculos da Of_Grava_ICMS com of_calcula_difa_venda()			//
//***********************************************************************//
Decimal{2} ldc_Aliquota_ICMS_Venda_UF_Dest
Decimal{2} ldc_FCP
Decimal{2} ldc_BC_ICMS_Dif_ICMS
Decimal{2} ldc_ICMS_Dif_ICMS
Decimal{2} ldc_Aliquota_Difa_Origem_Partilha
Decimal{2} ldc_Aliquota_Difa_Destino_Partilha
Decimal{2} ldc_ICMS_Operacao

String lvs_Tipo_Difa

ivo_Atributo_NF.vl_bc_icms_fcp_uf_destino	= 0.00
ivo_Atributo_NF.pc_icms_fcp_uf_destino 	= 0.00
ivo_Atributo_NF.vl_icms_fcp_uf_destino 		= 0.00
ivo_Atributo_NF.vl_bc_icms_uf_destino		= 0.00
ivo_Atributo_NF.pc_icms_uf_destino	   		= 0.00
ivo_Atributo_NF.vl_icms_uf_destino 			= 0.00
ivo_Atributo_NF.vl_icms_uf_origem 			= 0.00
ivo_Atributo_NF.pc_partilha						= 0.00

// Calcula a diferen$$HEX1$$e700$$ENDHEX$$a de aliquota de ICMS INTERESTADUAL
If This.ivs_Operacao = VENDA and ivs_Estadual = 'N' Then
	
	This.Of_Log_Calculo("~r~n************** DIFAL - EC 87/2015 **************" )		
	
	//Busca no cadastro da UF qual o tipo de c$$HEX1$$e100$$ENDHEX$$lculo para o Difa
	Select coalesce(u.id_tipo_calculo_difa_venda, '2')
	Into :lvs_Tipo_Difa
	From unidade_federacao u
	Where u.cd_unidade_federacao = :ivo_UF_Destino.Cd_Unidade_Federacao
	Using SQLCa;	
		
	If SQLCa.SQLCode = -1 Then
		SQLCa.Of_MsgDBError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o al$$HEX1$$ed00$$ENDHEX$$quota UF "+ivo_UF_Destino.Cd_Unidade_Federacao+".~rFun$$HEX2$$e700e300$$ENDHEX$$o: uo_tratamento_fiscal.of_calcula_difa_venda()" )	
		Return False
	End If
	This.Of_Log_Calculo("[ Tipo Difa ] = "+lvs_Tipo_Difa+" - "+IIF(lvs_Tipo_Difa='2','SIMPLES',IIF(lvs_Tipo_Difa='1','COMPOSTO (POR DENTRO)',IIF(lvs_Tipo_Difa='3','COMPOSTO 2',''))))
	
	// Retorna a al$$HEX1$$ed00$$ENDHEX$$quota de ICMS de venda no DESTINO e a al$$HEX1$$ed00$$ENDHEX$$quota do FCP
	If Not This.of_Aliquota_ICMS_Venda(ao_produto.cd_produto, ivo_UF_Destino.Cd_Unidade_Federacao, ref ldc_Aliquota_ICMS_Venda_UF_Dest, ref ldc_FCP) Then Return False
	//Atribui na classe os valores retornados
	ivo_Atributo_NF.pc_icms_uf_destino	   	= ldc_Aliquota_ICMS_Venda_UF_Dest
	ivo_Atributo_NF.pc_icms_fcp_uf_destino = ldc_FCP				
	This.Of_Log_Calculo("[ Aliq. ICMS Destino ] = "+String(ldc_Aliquota_ICMS_Venda_UF_Dest, "#,###,##0.00"))
	This.Of_Log_Calculo("[ Aliq. FCP Destino ] = "+String(ldc_FCP, "#,###,##0.00"))
	
	// Retorna o % de partilha do DIFA
	If Not This.of_Aliquota_ICMS_Difa(ref ldc_Aliquota_Difa_Origem_Partilha, ref ldc_Aliquota_Difa_Destino_Partilha) Then Return False
	ivo_Atributo_NF.pc_partilha = ldc_Aliquota_Difa_Destino_Partilha
	This.Of_Log_Calculo("~r~n[ % Partilha ICMS ] = "+String(ivo_Atributo_NF.pc_partilha, "##0.00") )
	
	// Base DIFAL
	ivo_Atributo_NF.vl_bc_icms_uf_destino = round(ivo_Atributo_NF.vl_bc_icms_prd * al_qtde, 2)
	//ICMS Opera$$HEX2$$e700e300$$ENDHEX$$o
	ldc_ICMS_Operacao	= round(ivo_Atributo_NF.vl_icms_prd * al_qtde,2)
	This.Of_Log_Calculo("[ ICMS Opera$$HEX2$$e700e300$$ENDHEX$$o ] = "+String(ldc_ICMS_Operacao, "#,###,##0.00"))
	
	//Ajusta a base, conforme o c$$HEX1$$e100$$ENDHEX$$lculo (o campo est$$HEX1$$e100$$ENDHEX$$ na tela FI069 - Cadastro UF)
	Choose case lvs_Tipo_Difa
		Case '1'  // 1506337: COMPOSTO (POR DENTRO) --> PAR$$HEX1$$c100$$ENDHEX$$ (remove o ICMS, recalcula a base por dentro e calcula o ICMS)
			ldc_BC_ICMS_Dif_ICMS = (ivo_Atributo_NF.vl_bc_icms_uf_destino - ldc_ICMS_Operacao) / ( 1 - ldc_Aliquota_ICMS_Venda_UF_Dest / 100)
			This.Of_Log_Calculo("~r~n[ Base ICMS Difal ] = ( [ Base ICMS Destino ] - [ ICMS Opera$$HEX2$$e700e300$$ENDHEX$$o ] ) / (1 - [ Al$$HEX1$$ed00$$ENDHEX$$q. ICMS Destino ] ) " )
			This.Of_Log_Calculo("[ Base ICMS Difal ] = ("+String(ivo_Atributo_NF.vl_bc_icms_uf_destino, "#,###,##0.00")+" - "+String(ldc_ICMS_Operacao, "#,###,##0.00")+" ) / (1 - "+String(ldc_Aliquota_ICMS_Venda_UF_Dest/100, "##0.00")+" ) " )
			This.Of_Log_Calculo("[ Base ICMS Difal ] = "+String(ivo_Atributo_NF.vl_bc_icms_uf_destino - ldc_ICMS_Operacao, "#,###,##0.00")+" / "+String(1 - ldc_Aliquota_ICMS_Venda_UF_Dest/100, "##0.00")+" ) " )
			This.Of_Log_Calculo("[ Base ICMS Difal ] = "+String(ldc_BC_ICMS_Dif_ICMS, "#,###,##0.00")+" ) " )
			ivo_Atributo_NF.vl_bc_icms_uf_destino = ldc_BC_ICMS_Dif_ICMS
			
		Case '2' //C$$HEX1$$c100$$ENDHEX$$LCULO SIMPLES			
			// Calcula o valor do DIFA
			ivo_Atributo_NF.vl_bc_icms_uf_destino = round(ivo_Atributo_NF.vl_bc_icms_prd * al_qtde, 2)
			This.Of_Log_Calculo("~r~n[ Base ICMS Difal ] = "+String(ivo_Atributo_NF.vl_bc_icms_uf_destino, "#,###,##0.00"))
			
		Case '3' 		//Chamado 841666	
			//{ [Valor Operacao] X ( [ 100 - PC ICMS Operacao] / [100 - PC ICMS VENDA DESTINO] ) } X [PC ICMS VENDA DESTINO / 100]  - [Valor ICMS Operacao]
			
			// Calcula a base de c$$HEX1$$e100$$ENDHEX$$lculo
			ldc_BC_ICMS_Dif_ICMS 	= Round(ivo_Atributo_NF.vl_bc_icms_uf_destino * ((1 - ivo_Atributo_NF.pc_icms/100) / (1 - ldc_Aliquota_ICMS_Venda_UF_Dest/100)), 2)
			This.Of_Log_Calculo("~r~n[ Base ICMS Difal ] = [ Base ICMS Destino ] x (1 - [ Aliq. ICMS Opera$$HEX2$$e700e300$$ENDHEX$$o ] ) x ( 1 - [  Al$$HEX1$$ed00$$ENDHEX$$q. ICMS Destino ] )")
			This.Of_Log_Calculo("[ Base ICMS Difal ] = "+String(ivo_Atributo_NF.vl_bc_icms_uf_destino, "#,###,##0.00")+" x (1 - "+String(ivo_Atributo_NF.pc_icms/100, "##0.00")+" ) x ( 1 - "+String(ldc_Aliquota_ICMS_Venda_UF_Dest / 100, "##0.00")+")")
			This.Of_Log_Calculo("[ Base ICMS Difal ] = "+String(ivo_Atributo_NF.vl_bc_icms_uf_destino, "#,###,##0.00")+" x "+String(1 - ivo_Atributo_NF.pc_icms /100, "##0.00")+" x "+String(1 - ldc_Aliquota_ICMS_Venda_UF_Dest / 100, "##0.00")+"")
			This.Of_Log_Calculo("[ Base ICMS Difal ] = "+String(ldc_BC_ICMS_Dif_ICMS, "#,###,##0.00"))
			ivo_Atributo_NF.vl_bc_icms_uf_destino = ldc_BC_ICMS_Dif_ICMS
			
		Case Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe c$$HEX1$$e100$$ENDHEX$$lculo para o tipo de DIFA a UF [" + ivo_UF_Destino.Cd_Unidade_Federacao + "]", StopSign!)			
			Return False
			
	End Choose
	
	//A f$$HEX1$$f300$$ENDHEX$$rmula do c$$HEX1$$e100$$ENDHEX$$lculo do DIFAL $$HEX1$$e900$$ENDHEX$$ fixa e validada, conforme NT 2020.005, regra 815
	ldc_ICMS_Dif_ICMS = round((ivo_Atributo_NF.vl_bc_icms_uf_destino * ldc_Aliquota_ICMS_Venda_UF_Dest/100) - ldc_ICMS_Operacao, 2)
	This.Of_Log_Calculo("~r~n[ Valor ICMS Difal ] = ( [ Base ICMS Destino ] x [ Al$$HEX1$$ed00$$ENDHEX$$q. ICMS Destino ] ) - [ ICMS Opera$$HEX2$$e700e300$$ENDHEX$$o ]" )
	This.Of_Log_Calculo("[ Valor ICMS Difal ] = ( "+String(ivo_Atributo_NF.vl_bc_icms_uf_destino, "#,###,##0.00")+" x "+String(ldc_Aliquota_ICMS_Venda_UF_Dest, "##0.00")+") - "+String(ldc_ICMS_Operacao, "#,###,##0.00") )
	This.Of_Log_Calculo("[ Valor ICMS Difal ] = "+String(ivo_Atributo_NF.vl_bc_icms_uf_destino * ldc_Aliquota_ICMS_Venda_UF_Dest/100, "#,###,##0.00##")+" - "+String(ldc_ICMS_Operacao, "#,###,##0.00") )
	This.Of_Log_Calculo("[ Valor ICMS Difal ] = "+String(Round(ldc_ICMS_Dif_ICMS,2), "#,###,##0.00"))
	
	//Se o c$$HEX1$$e100$$ENDHEX$$lculo ficar negativo, ent$$HEX1$$e300$$ENDHEX$$o recebe valor zero
	If ldc_ICMS_Dif_ICMS < 0 Then ldc_ICMS_Dif_ICMS = 0.00
	//Se n$$HEX1$$e300$$ENDHEX$$o houver DIFAL, zera a base a base
	If ldc_ICMS_Dif_ICMS = 0.00 Then
		This.Of_Log_Calculo("~r~n[ Base ICMS Difal ] = 0.00 (devido ao valor Difal ser menor ou igual a zero)" )
		ivo_Atributo_NF.vl_bc_icms_uf_destino	= 0.00
	End If		
		
	// Ap$$HEX1$$f300$$ENDHEX$$s c$$HEX1$$e100$$ENDHEX$$lculo efetua a partilha entre os estados
	If ldc_ICMS_Dif_ICMS > 0 Then
		// Faz a partilha do DIFAL
		ivo_Atributo_NF.vl_icms_uf_destino 	= round(ldc_ICMS_Dif_ICMS * (ldc_Aliquota_Difa_Destino_Partilha / 100), 2)
		This.Of_Log_Calculo("~r~n[ Valor ICMS DIFAL - Destino ] = [ Valor ICMS DIFAL ] x [ % UF Destino ] / 100")
		This.Of_Log_Calculo("[ Valor ICMS DIFAL - Destino ] = [ "+String(ldc_ICMS_Dif_ICMS, "#,###,##0.00")+" ] x [ "+String(ldc_Aliquota_Difa_Destino_Partilha, "##0.00")+" ] / 100")
		This.Of_Log_Calculo("[ Valor ICMS DIFAL - Destino ] = "+String(ivo_Atributo_NF.vl_icms_uf_destino, "#,###,##0.00"))
		
		ivo_Atributo_NF.vl_icms_uf_origem	= ldc_ICMS_Dif_ICMS - ivo_Atributo_NF.vl_icms_uf_destino
		This.Of_Log_Calculo("~r~n[ Valor ICMS DIFAL - Origem ] = [ Valor ICMS DIFAL ] - [ Valor ICMS DIFAL - Destino ]")
		This.Of_Log_Calculo("[ Valor ICMS DIFAL - Origem ] = [ "+String(ldc_ICMS_Dif_ICMS, "#,###,##0.00")+" ] - [ "+String(ivo_Atributo_NF.vl_icms_uf_destino, "##0.00")+" ]")
		This.Of_Log_Calculo("[ Valor ICMS DIFAL - Origem ] = "+String(ivo_Atributo_NF.vl_icms_uf_origem, "#,###,##0.00"))
	End If
					
	If ivo_Atributo_NF.vl_icms_uf_destino <	0 Then ivo_Atributo_NF.vl_icms_uf_destino = 0.00
	If ivo_Atributo_NF.vl_icms_uf_origem <	0 Then ivo_Atributo_NF.vl_icms_uf_origem = 0.00
	
	//Possui Fundo de Combate a Pobreza (FCP)?
	If ldc_FCP > 0 Then		
		ivo_Atributo_NF.vl_bc_icms_fcp_uf_destino 	= ivo_Atributo_NF.vl_bc_icms_uf_destino	
		This.Of_Log_Calculo("~r~n[ Base FCP Difal ] = "+String(ivo_Atributo_NF.vl_bc_icms_uf_destino	, "#,###,##0.00"))
	
		ivo_Atributo_NF.vl_icms_fcp_uf_destino = Round(ivo_Atributo_NF.vl_bc_icms_fcp_uf_destino * (ldc_FCP / 100), ivl_Decimais)
		This.Of_Log_Calculo("~r~n[ Valor FCP Difal ] = [ Base ICMS Destino ] x [ Al$$HEX1$$ed00$$ENDHEX$$q. FCP Destino ] / 100" )
		This.Of_Log_Calculo("[ Valor FCP Difal ] = "+String(ivo_Atributo_NF.vl_bc_icms_fcp_uf_destino, "#,###,##0.00")+" x "+String(ldc_FCP, "##0.00")+" / 100" )
		This.Of_Log_Calculo("[ Valor FCP Difal ] = "+String(ivo_Atributo_NF.vl_icms_fcp_uf_destino, "#,###,##0.00"))
	Else
		ivo_Atributo_NF.vl_icms_fcp_uf_destino		= 0.00
		ivo_Atributo_NF.vl_bc_icms_fcp_uf_destino	= 0.00
	End If
End If

Return True
end function

public function boolean of_retorna_tributacao_pis_cofins (long pl_cfop, long pl_produto, decimal pdc_vl_total_item, decimal pdc_vl_total_icms_item, ref string ps_cst_pis, ref decimal pdc_bc_pis, ref decimal pdc_aliq_pis, ref decimal pdc_pis, ref string ps_cst_cofins, ref decimal pdc_bc_cofins, ref decimal pdc_aliq_cofins, ref decimal pdc_cofins, boolean pb_exibe_msg, ref string ps_mensagem);String lvs_CST_PIS
String lvs_CST_Cofins
String lvs_Pis
String lvs_Cofins
String lvs_Lista
String lvs_Op_Tributavel
String lvs_Ent_Sai
String lvs_Finalidade

Decimal{4} lvdc_BC_PIS
Decimal{4} lvdc_Aliq_PIS
Decimal{4} lvdc_PIS
Decimal{4} lvdc_BC_Cofins
Decimal{4} lvdc_Aliq_Cofins
Decimal{4} lvdc_Cofins

If IsNull(pl_cfop) Then
	// Para n$$HEX1$$e300$$ENDHEX$$o anular a mensagem de erro.
	If IsNull(pl_produto) Then pl_produto = 0 
	
	If pb_exibe_msg Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!',"N$$HEX1$$e300$$ENDHEX$$o foi informada a CFOP para o c$$HEX1$$e100$$ENDHEX$$lculo do PIS/COFINS do produto "+String(pl_produto)+".",Exclamation!)
	Else
		ps_mensagem = "N$$HEX1$$e300$$ENDHEX$$o foi informada a CFOP para o c$$HEX1$$e100$$ENDHEX$$lculo do PIS/COFINS do produto "+String(pl_produto)+"."
	End If
	Return False
Else
	This.Of_Log_Calculo("CFOP = "+String(pl_cfop))
End If
//Verifica produto informado
If IsNull(pl_produto) Then Return False

//Entrada ou Sa$$HEX1$$ed00$$ENDHEX$$da?
lvs_Ent_Sai = IIF(pl_cfop > 5000,'S','E')

//Trata possibilidade de nulo na dedu$$HEX2$$e700e300$$ENDHEX$$o
pdc_vl_total_icms_item = gf_coalesce(pdc_vl_total_icms_item, 0)

//Verifica se CFOP $$HEX1$$e900$$ENDHEX$$ devolu$$HEX2$$e700e300$$ENDHEX$$o
Select id_finalidade_nfe
Into :lvs_Finalidade
From natureza_operacao
Where cd_natureza_operacao = :pl_cfop
Using SQLCa;

If SQLCa.SQLCode=-1 THen
	If gvb_Auto Then
		gvo_aplicacao.Of_Grava_Log(This.ClassName()+".of_retorna_tributacao_pis_cofins(): N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel buscar a finalidade da CFOP.~r"+SQLCa.SQLErrText)
	Else
		MessageBox("Falha", This.ClassName()+".of_retorna_tributacao_pis_cofins(): N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel buscar a finalidade da CFOP.~r"+SQLCa.SQLErrText, Exclamation!)
	End If
End If

//ENTRADA ou DEV.SA$$HEX1$$cd00$$ENDHEX$$DA: Se ainda n$$HEX1$$e300$$ENDHEX$$o tiver setada a data para remover o ICMS da Base do PIS/COFINS, zera o valor de ICMS
If ((lvs_Ent_Sai = 'E' and gf_coalesce(lvs_Finalidade,'')<>'4') or (lvs_Ent_Sai = 'S' and gf_coalesce(lvs_Finalidade,'')='4')) &
	and idt_Movimento < ivdt_Inicio_Reduz_ICMS_Base_PIS_Credito Then 
	This.Of_Log_Calculo("/ ! \ Data do par$$HEX1$$e200$$ENDHEX$$metro para reduzir o ICMS da base PIS/COFINS para cr$$HEX1$$e900$$ENDHEX$$ditos $$HEX1$$e900$$ENDHEX$$ inferior ao movimento.~r"+ &
							"O valor de dedu$$HEX2$$e700e300$$ENDHEX$$o de ICMS para a base PIS/COFINS ser$$HEX1$$e100$$ENDHEX$$ zerado.")
	pdc_vl_total_icms_item = 0.00
End If

//SA$$HEX1$$cd00$$ENDHEX$$DA ou DEV.ENTRADA: Se ainda n$$HEX1$$e300$$ENDHEX$$o tiver setada a data para remover o ICMS da Base do PIS/COFINS, zera o valor de ICMS
If ((lvs_Ent_Sai = 'S' and gf_coalesce(lvs_Finalidade,'')<>'4') or (lvs_Ent_Sai = 'E' and gf_coalesce(lvs_Finalidade,'')='4')) &
	and idt_Movimento < ivdt_Inicio_Reduz_ICMS_Base_PIS_Debito Then
	This.Of_Log_Calculo("/ ! \ Data do par$$HEX1$$e200$$ENDHEX$$metro para reduzir o ICMS da base PIS/COFINS para d$$HEX1$$e900$$ENDHEX$$bitos $$HEX1$$e900$$ENDHEX$$ inferior ao movimento.~r"+ &
							"O valor de dedu$$HEX2$$e700e300$$ENDHEX$$o de ICMS para a base PIS/COFINS ser$$HEX1$$e100$$ENDHEX$$ zerado.")
	pdc_vl_total_icms_item = 0.00
End If

/* Sem CST preenchido na chamada da fun$$HEX2$$e700e300$$ENDHEX$$o */
If IsNull(ps_cst_pis) or (ps_cst_pis='') or (ps_cst_pis='00') or IsNull(ps_cst_cofins) or (ps_cst_cofins='') or (ps_cst_cofins='00') Then
	Choose Case pl_cfop
		Case 5551, 6551  //VENDA DE ATIVO
			lvs_PIS				= 'N'
			lvs_CST_PIS		= '07'
			lvdc_Aliq_PIS		= 0.00
			lvs_Cofins			= 'N'
			lvs_CST_Cofins		= '07'
			lvdc_Aliq_Cofins	= 0.00

		Case 5556, 6556 //DEVOLU$$HEX2$$c700c200$$ENDHEX$$O COMPRA USO CONSUMO - Chamado 193957
			lvs_PIS				= 'N'
			lvs_CST_PIS		= '49'
			lvdc_Aliq_PIS		= 0.00
			lvs_Cofins			= 'N'
			lvs_CST_Cofins		= '49'		
			lvdc_Aliq_Cofins	= 0.00
			
		/* Se for devolu$$HEX2$$e700e300$$ENDHEX$$o de compra mesmo que haja outra CST parametrizada a CST ser$$HEX1$$e100$$ENDHEX$$ sempre 49, mas tributa conforme a parametriza$$HEX2$$e700e300$$ENDHEX$$o */
		Case 5202, 5411, 6202, 6411  //DEVOLUCAO DE COMPRA
			This.Of_retorna_pis_cofins_produto( pl_produto				, &
															lvs_Ent_Sai				, & 
															'S'							, &
															ref lvs_Pis				, &
															ref lvs_CST_PIS		, &
															ref lvdc_Aliq_PIS		, &
															ref lvs_Cofins			, &
															ref lvs_CST_Cofins	, &
															ref lvdc_Aliq_Cofins	, &
															ref lvs_Lista				, &
															pb_exibe_msg			, & 
															ref ps_mensagem)
			
			/*Caso n$$HEX1$$e300$$ENDHEX$$o exista parametriza$$HEX2$$e700e300$$ENDHEX$$o respeitar$$HEX1$$e100$$ENDHEX$$ a lista */
			If IsNull(lvs_CST_PIS)or(lvs_CST_PIS='') Then
				lvs_PIS = IIF(lvs_Lista='T','S','N')
			End if
			If IsNull(lvs_CST_Cofins)or(lvs_CST_Cofins='') Then
				lvs_Cofins = IIF(lvs_Lista='T','S','N')
			End if
			
			lvs_CST_PIS	= '49'
			lvs_CST_Cofins	= '49'	
			
		Case 5102, 5405, 6102, 6404 //VENDA 
			This.Of_retorna_pis_cofins_produto( pl_produto				, &
															lvs_Ent_Sai				, & 
															'S'							, &
															ref lvs_Pis				, &
															ref lvs_CST_PIS		, &
															ref lvdc_Aliq_PIS		, &
															ref lvs_Cofins			, &
															ref lvs_CST_Cofins	, &
															ref lvdc_Aliq_Cofins	, &
															ref lvs_Lista				, &
															pb_exibe_msg			, & 
															ref ps_mensagem)
				
			If IsNull(lvs_CST_PIS)or(lvs_CST_PIS='') Then
				lvs_Pis			= IIF(lvs_Lista='T','S','N')
				lvs_CST_PIS	= IIF(lvs_Lista='T','01','04')
			End if
			
			If IsNull(lvs_CST_Cofins)or(lvs_CST_Cofins='') Then
				lvs_Cofins		= IIF(lvs_Lista='T','S','N')
				lvs_CST_Cofins	= IIF(lvs_Lista='T','01','04')
			End if

		Case 1556, 2556, 1407, 2407  //Compra Uso Consumo
			lvs_PIS				= 'N'
			SetNull(lvs_CST_PIS)
			lvs_Cofins			= 'N'
			SetNull(lvs_CST_Cofins)
			
		Case 1910, 2910  //Compra Bonificada
			lvs_PIS				= 'N'
			SetNull(lvs_CST_PIS)
			lvs_Cofins			= 'N'
			SetNull(lvs_CST_Cofins)
			
		Case 1102, 2102, 1403, 2403  //COMPRA
			This.Of_retorna_pis_cofins_produto( pl_produto				, &
															lvs_Ent_Sai				, & 
															'S'							, &
															ref lvs_Pis				, &
															ref lvs_CST_PIS		, &
															ref lvdc_Aliq_PIS		, &
															ref lvs_Cofins			, &
															ref lvs_CST_Cofins	, &
															ref lvdc_Aliq_Cofins	, &
															ref lvs_Lista				, &
															pb_exibe_msg			, & 
															ref ps_mensagem)
			
			If IsNull(lvs_CST_PIS)or(lvs_CST_PIS='') Then
				lvs_PIS			= IIF(lvs_Lista='T','S','N')
				lvs_CST_PIS	= IIF(lvs_Lista='T','50','70')
			End if
			
			If IsNull(lvs_CST_Cofins)or(lvs_CST_Cofins='') Then
				lvs_Cofins		= IIF(lvs_Lista='T','S','N')
				lvs_CST_Cofins	= IIF(lvs_Lista='T','50','70')
			End if
			
		Case 1202, 1411, 2202, 2411  //DEVOLUCAO DE VENDA
			This.Of_retorna_pis_cofins_produto( pl_produto				, &
															lvs_Ent_Sai				, & 
															'S'							, &
															ref lvs_Pis				, &
															ref lvs_CST_PIS		, &
															ref lvdc_Aliq_PIS		, &
															ref lvs_Cofins			, &
															ref lvs_CST_Cofins	, &
															ref lvdc_Aliq_Cofins	, &
															ref lvs_Lista				, &
															pb_exibe_msg			, & 
															ref ps_mensagem)
			
			If IsNull(lvs_CST_PIS)or(lvs_CST_PIS='') Then
				lvs_PIS			= IIF(lvs_Lista='T','S','N')
				lvs_CST_PIS	= IIF(lvs_Lista='T','50','70')
			End if
			
			If IsNull(lvs_CST_Cofins)or(lvs_CST_Cofins='') Then
				lvs_Cofins		= IIF(lvs_Lista='T','S','N')
				lvs_CST_Cofins	= IIF(lvs_Lista='T','50','70')
			End if
	
		Case Else //NOTAS DIVERSAS
			lvs_Op_Tributavel = This.of_cfop_tributavel_pis_cofins(pl_cfop,pb_exibe_msg,ps_mensagem)
			
			This.Of_retorna_pis_cofins_produto( pl_produto				, &
															lvs_Ent_Sai				, & 
															lvs_Op_Tributavel		, &
															ref lvs_Pis				, &
															ref lvs_CST_PIS		, &
															ref lvdc_Aliq_PIS		, &
															ref lvs_Cofins			, &
															ref lvs_CST_Cofins	, &
															ref lvdc_Aliq_Cofins	, &
															ref lvs_Lista				, &
															pb_exibe_msg			, & 
															ref ps_mensagem)
			//Configura$$HEX2$$e700e300$$ENDHEX$$o Padr$$HEX1$$e300$$ENDHEX$$o Sa$$HEX1$$ed00$$ENDHEX$$da Diversas
			If lvs_Ent_Sai = 'S' Then		
				If IsNull(lvs_CST_PIS)or(lvs_CST_PIS='') Then
					lvs_CST_PIS	= IIF(lvs_Op_Tributavel = 'N','49','04')
					lvs_PIS 			= 'N'
					lvdc_Aliq_PIS	= 0.00
				End if
				If IsNull(lvs_CST_Cofins)or(lvs_CST_Cofins='') Then
					lvs_CST_Cofins		= IIF(lvs_Op_Tributavel = 'N','49','04')
					lvs_Cofins			= 'N'
					lvdc_Aliq_Cofins	= 0.00
				End if		
				
			//Configura$$HEX2$$e700e300$$ENDHEX$$o Padr$$HEX1$$e300$$ENDHEX$$o Entrada Diversas
			Else				
				If IsNull(lvs_CST_PIS)or(lvs_CST_PIS='') Then
					lvs_CST_PIS	= IIF(lvs_Op_Tributavel = 'N','98','70')
					lvs_PIS 			= 'N'
					lvdc_Aliq_PIS	= 0.00
				End if
				
				If IsNull(lvs_CST_Cofins)or(lvs_CST_Cofins='') Then
					lvs_CST_Cofins		= IIF(lvs_Op_Tributavel = 'N','98','70')
					lvs_Cofins			= 'N'
					lvdc_Aliq_Cofins	= 0.00
				End if
			End If
	End Choose
	
/* Com CST previamente definido na chamada da fun$$HEX2$$e700e300$$ENDHEX$$o*/
Else
	
	if pl_produto > 0 then
		/* Se for devolu$$HEX2$$e700e300$$ENDHEX$$o de compra apesar de vir com a CST 49 que habitualmente $$HEX1$$e900$$ENDHEX$$ n$$HEX1$$e300$$ENDHEX$$o tributada o produto tributar$$HEX1$$e100$$ENDHEX$$ conforme a lista */
		Choose Case pl_cfop
			Case 5202, 5411, 6202, 6411, 5556, 6556 //DEVOLUCAO DE COMPRA
					Select	 	coalesce(sp.id_tributado,case when p.id_situacao_pis_cofins = 'T' then 'S' else 'N' end) as id_pis,
								coalesce(sc.id_tributado,case when p.id_situacao_pis_cofins = 'T' then 'S' else 'N' end) as id_cofins
					Into 	:lvs_Pis,
							:lvs_Cofins
					From produto_geral p
					left outer join ncm_pis_cofins n
					  on n.nr_ncm = p.nr_classificacao_fiscal
					  and n.id_lista_pis_cofins = p.id_situacao_pis_cofins
					left outer join tributacao_pis_cofins tp
					  on tp.cd_tributacao_pis_cofins = n.cd_tributacao_pis
					left outer join situacao_tributaria sp
					  on sp.cd_cst = tp.cd_cst_saida
					left outer join tributacao_pis_cofins tc
					  on tc.cd_tributacao_pis_cofins = n.cd_tributacao_cofins
					left outer join situacao_tributaria sc
					  on sc.cd_cst = tc.cd_cst_saida
					Where p.cd_produto = :pl_produto
					Using SQLCA;
		
			Case Else
				Select	 	sp.id_tributado as id_pis,
							sc.id_tributado as id_cofins
				Into 	:lvs_Pis,
						:lvs_Cofins
				From situacao_tributaria sp, situacao_tributaria sc
				Where sc.cd_cst = :ps_cst_cofins
					And sp.cd_cst = :ps_cst_pis
				Using SQLCA;
		End Choose
	
	else
		Select	 	sp.id_tributado as id_pis,
							sc.id_tributado as id_cofins
				Into 	:lvs_Pis,
						:lvs_Cofins
				From situacao_tributaria sp, situacao_tributaria sc
				Where sc.cd_cst = :ps_cst_cofins
					And sp.cd_cst = :ps_cst_pis
				Using SQLCA;
	end if
	
	If (SQLCA.SQLCode = -1) Then
		If pb_exibe_msg Then
			SqlCa.of_MsgdbError("Erro na consulta da tributa$$HEX2$$e700e300$$ENDHEX$$o PIS/COFINS do produto "+String(pl_produto)+".")
		Else
			ps_mensagem = "Erro na consulta da tributa$$HEX2$$e700e300$$ENDHEX$$o PIS/COFINS do produto "+String(pl_produto)+"." + SqlCa.SQLErrtext
		End If
		
		Return False
	End If

	lvs_CST_PIS 	= ps_cst_pis
	lvs_CST_Cofins	= ps_cst_cofins
End If

//Grava log calculo
This.Of_Log_Calculo("CFOP Oper. Tribut$$HEX1$$e100$$ENDHEX$$vel = "+IIF(lvs_Op_Tributavel = 'N','N$$HEX1$$c300$$ENDHEX$$O','SIM'))
This.Of_Log_Calculo("Tipo Tribut. = "+IIF(lvs_PIS = 'S','TRIBUTADO',IIF(lvs_PIS = 'D','TRIB. ALIQ. DIFERENCIADA', 'N$$HEX1$$c300$$ENDHEX$$O TRIBUTADO')))
This.Of_Log_Calculo("CST PIS = "+lvs_CST_PIS)
This.Of_Log_Calculo("CST COFINS = "+lvs_CST_Cofins)
	
Choose Case lvs_PIS
	Case 'S'
		ps_cst_pis	= lvs_CST_PIS
		pdc_bc_pis 	= pdc_vl_total_item - pdc_vl_total_icms_item
		pdc_aliq_pis	= 1.65
		pdc_pis	 	= Round(pdc_bc_pis * (pdc_aliq_pis / 100),4)

	Case 'D'
		ps_cst_pis	= lvs_CST_PIS
		pdc_bc_pis 	= pdc_vl_total_item - pdc_vl_total_icms_item
		pdc_aliq_pis	= lvdc_Aliq_PIS
		pdc_pis	 	= Round(pdc_bc_pis * (pdc_aliq_pis / 100),4)
		
	Case 'N'
		ps_cst_pis	= lvs_CST_PIS
		pdc_bc_pis 	= 0.00
		pdc_aliq_pis	= 0.00
		pdc_pis	 	= 0.00
	
	Case Else
		if pb_exibe_msg Then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!',"Tipo de tributa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o previsto no c$$HEX1$$e100$$ENDHEX$$lculo PIS para o produto "+String(pl_produto)+".",Exclamation!)
		Else
			ps_mensagem = "Tipo de tributa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o previsto no c$$HEX1$$e100$$ENDHEX$$lculo PIS para o produto "+String(pl_produto)+"."
		End If
		
		Return False
End Choose
 
If lvs_PIS <> 'N' Then
	This.Of_Log_Calculo("[ Base PIS ] = "+String(pdc_bc_pis, "#,###,##0.00##"))
	This.Of_Log_Calculo("[ Al$$HEX1$$ed00$$ENDHEX$$q. PIS ] = "+String(pdc_aliq_pis, "##0.00"))
	This.Of_Log_Calculo("[ Valor PIS ] = [ Base PIS ] x [ Aliq. PIS ] / 100")
	This.Of_Log_Calculo("[ Valor PIS ] = [ "+String(pdc_bc_pis, "#,###,##0.00##")+" ] x [ "+String(pdc_aliq_pis, "##0.00")+" ] / 100")
	This.Of_Log_Calculo("[ Valor PIS ] = "+String(pdc_pis, "#,###,##0.00##"))
End If 

Choose Case lvs_Cofins
	Case 'S'
		ps_cst_cofins	= lvs_CST_Cofins
		pdc_bc_cofins	= pdc_vl_total_item - pdc_vl_total_icms_item
		pdc_aliq_cofins	= 7.60
		pdc_cofins	 	= Round(pdc_bc_cofins * (pdc_aliq_cofins / 100),4)

	Case 'D'		
		ps_cst_cofins	= lvs_CST_Cofins
		pdc_bc_cofins	= pdc_vl_total_item - pdc_vl_total_icms_item
		pdc_aliq_cofins	= lvdc_Aliq_Cofins
		pdc_cofins	 	= Round(pdc_bc_cofins * (pdc_aliq_cofins / 100),4)
		
	Case 'N'
		ps_cst_cofins	= lvs_CST_Cofins
		pdc_bc_cofins	= 0.00
		pdc_aliq_cofins	= 0.00
		pdc_cofins	 	= 0.00
		
	Case Else
		if pb_exibe_msg Then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!',"Tipo de tributa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o previsto no c$$HEX1$$e100$$ENDHEX$$lculo COFINS para o produto "+String(pl_produto)+".",Exclamation!)
		Else
			ps_mensagem = "Tipo de tributa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o previsto no c$$HEX1$$e100$$ENDHEX$$lculo COFINS para o produto "+String(pl_produto)+"."
		End If
		
		Return False
End Choose

If lvs_COFINS <> 'N' Then
	This.Of_Log_Calculo("[ Base COFINS ] = "+String(pdc_bc_cofins, "#,###,##0.00##"))
	This.Of_Log_Calculo("[ Al$$HEX1$$ed00$$ENDHEX$$q. COFINS ] = "+String(pdc_aliq_cofins, "##0.00"))
	This.Of_Log_Calculo("[ Valor COFINS ] = [ Base COFINS ] x [ Aliq. COFINS ] / 100")
	This.Of_Log_Calculo("[ Valor COFINS ] = [ "+String(pdc_bc_cofins, "#,###,##0.00##")+" ] x [ "+String(pdc_aliq_cofins, "##0.00")+" ] / 100")
	This.Of_Log_Calculo("[ Valor COFINS ] = "+String(pdc_cofins, "#,###,##0.00##"))
End If 

Return True
end function

public function boolean of_retorna_tributacao_pis_cofins (long pl_cfop, long pl_produto, decimal pdc_vl_total_item, decimal pdc_vl_total_icms_item, ref string ps_cst_pis, ref decimal pdc_bc_pis, ref decimal pdc_aliq_pis, ref decimal pdc_pis, ref string ps_cst_cofins, ref decimal pdc_bc_cofins, ref decimal pdc_aliq_cofins, ref decimal pdc_cofins);String lvs_Msg

Return This.of_retorna_tributacao_pis_cofins( 	pl_cfop						, &
															pl_produto					, &
															pdc_vl_total_item			, &
															pdc_vl_total_icms_item	, &
															ps_cst_pis					, & 
															pdc_bc_pis					, & 
															pdc_aliq_pis					, & 
															pdc_pis						, & 
															ps_cst_cofins				, &
															pdc_bc_cofins				, & 
															pdc_aliq_cofins				, &
															pdc_cofins					, &
															True							, &
															lvs_Msg) 

end function

public function boolean of_set_fornecedor_uso_consumo (string as_id_uso_consumo);If IsNull(as_id_uso_consumo) then as_id_uso_consumo = 'N'

ivs_fornecedor_uso_consumo = as_id_uso_consumo

return true
end function

public function boolean of_retorna_classificacao_cbs_ibs (string ps_uf_destino, long pl_cfop, long pl_produto, ref string ps_id_classe_cbs_ibs);String lvs_ID_Trib_CBS_IBS
String lvs_ID_Situacao_NCM
Long lvl_Tipo_Produto
Long lvl_NCM

Boolean lvb_Encontrada = False

Try
	SetNull(ps_id_classe_cbs_ibs)
	
	//Valida preenchimento UF
	If IsNull(ps_uf_destino) or ps_uf_destino='' Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe um estado v$$HEX1$$e100$$ENDHEX$$lido para permitir ao sistema encontrar a classifica$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria.', Exclamation!)
		Return False
	End If
	
	//Se foi informado produto (pode vir da diversas, sem produto informado)
	If Not IsNull(pl_produto) Then
		/* Busca NCM e tributa$$HEX2$$e700e300$$ENDHEX$$o IBS/CBS do produto para vendas */
		SELECT pg.nr_classificacao_fiscal, pu.id_situacao_ncm
		Into :lvl_NCM, :lvs_ID_Situacao_NCM
		FROM produto_uf pu
		INNER JOIN produto_geral pg
			ON pg.cd_produto = pu.cd_produto
		WHERE pu.cd_unidade_federacao = :ps_uf_destino
			AND pu.cd_produto = :pl_produto
		Using SQLCa;
		
		//Se encontrou NCM
		If SQLCa.SQLCode = 0 and lvl_NCM > -1 Then
			//Busca o tipo de produto fiscal
			If Not IsValid(ivo_Tipo_Produto_Fiscal) Then ivo_Tipo_Produto_Fiscal = Create uo_Tipo_Produto_Fiscal
			If Not ivo_Tipo_Produto_Fiscal.Of_Tipo_Produto_Fiscal_UF( ps_UF_Destino, lvl_NCM, ref lvl_Tipo_Produto) Then
				//Em caso de falha na busca do Tipo Produto Fiscal, busca sem o tipo
				SetNull(lvl_Tipo_Produto)
			End If
		ElseIf SQLCa.SQLCode = -1 Then
			SQLCa.Of_MsgDBError('Falha na busca da NCM e ID Situa$$HEX2$$e700e300$$ENDHEX$$o NCM na '+This.ClassName()+'.of_retorna_classificacao_cbs_ibs().')
			Return False
		End If
	Else
		SetNull(lvl_Tipo_Produto)
	End If
	
	//Se tiver Tipo Produto Fiscal
	If Not IsNull(lvl_Tipo_Produto) Then
		//Busca a classe tribut$$HEX1$$e100$$ENDHEX$$ria COM o tipo produto fiscal (medicamento, perfumaria, alimentos, etc)
		SELECT TOP 1 id_imposto_cbs_ibs
		INTO :lvs_ID_Trib_CBS_IBS
		FROM unidade_federacao_cfop
		WHERE cd_unidade_federacao = :ps_uf_destino
			AND cd_cst = 'RT'
			AND cd_natureza_operacao = :pl_cfop
			AND id_imposto_cbs_ibs is not null
			AND cd_tipo_produto_fiscal = :lvl_Tipo_Produto
		Using SQLCa;
	
		If SQLCa.SQLCode = -1 Then
			SQLCa.Of_MsgDBError('Falha ao localizar a classifica$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria na tabela unidade_federacao_cfop.~r~r'+ &
					This.ClassName()+'.of_retorna_classificacao_cbs_ibs().')
			Return False
		End If
		
		//Seta se foi encontrado
		lvb_Encontrada = (SQLCa.SQLCode = 0 and gf_coalesce(lvs_ID_Trib_CBS_IBS,'')<>'')
	End If
	
	//SE N$$HEX1$$c300$$ENDHEX$$O ENCONTROU a classe tributaria com tipo produto fiscal
	If Not lvb_Encontrada Then
		//Busca a classe tribut$$HEX1$$e100$$ENDHEX$$ria SEM o tipo produto fiscal
		SELECT TOP 1 id_imposto_cbs_ibs
		INTO :lvs_ID_Trib_CBS_IBS
		FROM unidade_federacao_cfop
		WHERE cd_unidade_federacao = :ps_uf_destino
			AND cd_cst = 'RT'
			AND cd_natureza_operacao = :pl_cfop
			AND id_imposto_cbs_ibs is not null
			AND cd_tipo_produto_fiscal is null
		Using SQLCa;
	
		If SQLCa.SQLCode = -1 Then
			SQLCa.Of_MsgDBError('Falha ao localizar a classifica$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria na tabela unidade_federacao_cfop.~r~r'+ &
					This.ClassName()+'.of_retorna_classificacao_cbs_ibs().')
			Return False
		End If
		
		//Seta se foi encontrado
		lvb_Encontrada = (SQLCa.SQLCode = 0 and gf_coalesce(lvs_ID_Trib_CBS_IBS,'')<>'')
	End If
	
	//SE N$$HEX1$$c300$$ENDHEX$$O ENCONTROU at$$HEX1$$e900$$ENDHEX$$ aqui, significa que a opera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o possui uma tratativa fixa, ent$$HEX1$$e300$$ENDHEX$$o busca pelo produto (caso haja)
	If Not lvb_Encontrada Then
		//Foi encontrado ID Situa$$HEX2$$e700e300$$ENDHEX$$o NCM?
		If Not IsNull(lvs_ID_Situacao_NCM) Then
			//Busca tributa$$HEX2$$e700e300$$ENDHEX$$o de venda vigente para o produto
			SELECT niv.id_imposto_tributacao
			INTO :lvs_ID_Trib_CBS_IBS
			FROM ncm_imposto_vigencia niv, parametro p			
			WHERE niv.id_situacao_ncm = :lvs_ID_Situacao_NCM
				AND p.id_parametro='1'
				AND niv.dh_inicio <= p.dh_movimentacao
				AND (niv.dh_termino is null or niv.dh_termino >= p.dh_movimentacao)
			USING SQLCa;
			
			If SQLCa.SQLCode = -1 Then
				SQLCa.Of_MsgDBError('Falha ao localizar a classifica$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria na tabela ncm_imposto_vigencia.~r~r'+ &
						This.ClassName()+'.of_retorna_classificacao_cbs_ibs().')
				Return False
			End If
				
			//Seta se foi encontrado
			lvb_Encontrada = (SQLCa.SQLCode = 0 and gf_coalesce(lvs_ID_Trib_CBS_IBS,'')<>'')
		End If
	End If
	
	ps_id_classe_cbs_ibs = lvs_ID_Trib_CBS_IBS
	
Catch (RuntimeError lvo_Erro)
	MessageBox('Erro',lvo_Erro.GetMessage(), StopSign!)
	Return False
	
Finally
	//
End Try

Return lvb_Encontrada
end function

public function boolean of_aliquota_cbs_ibs (string ps_uf_destino, long pl_cidade_destino, ref decimal pdc_aliq_federal, ref decimal pdc_aliq_estadual, ref decimal pdc_aliq_municipal);Boolean lvb_Encontrou = False
Try
	/***************************************************************************/
	/* A busca da al$$HEX1$$ed00$$ENDHEX$$quota deve ser da mais espec$$HEX1$$ed00$$ENDHEX$$fica para a mais abrangente	*/
	/* ou seja, se existir uma al$$HEX1$$ed00$$ENDHEX$$quota diferente para a cidade no cadastro, 	*/
	/* ent$$HEX1$$e300$$ENDHEX$$o o sistema dever$$HEX1$$e100$$ENDHEX$$ buscar essa al$$HEX1$$ed00$$ENDHEX$$quota, sen$$HEX1$$e300$$ENDHEX$$o tenta na al$$HEX1$$ed00$$ENDHEX$$quota 	*/
	/* especifica para o estado. 																*/
	/***************************************************************************/
	
	//Se foi passado o par$$HEX1$$e200$$ENDHEX$$metro da cidade
	If pl_cidade_destino > 0 Then
		SELECT TOP 1 pc_aliq_federal, pc_aliq_estadual, coalesce(pc_aliq_municipal,0)
		INTO :pdc_aliq_federal, :pdc_aliq_estadual, :pdc_aliq_municipal
		FROM imposto_aliquota ia, parametro p
		WHERE ia.cd_uf = :ps_uf_destino
			AND ia.cd_cidade = :pl_cidade_destino
			AND ia.dh_inicio <= p.dh_movimentacao
			AND (ia.dh_termino is null or ia.dh_termino >= p.dh_movimentacao)
		ORDER BY ia.dh_inicio desc
		USING SQLCa;
		
		lvb_Encontrou = (SQLCa.SQLCode = 0)
	End If
	
	If Not lvb_Encontrou Then
		/* Busca Al$$HEX1$$ed00$$ENDHEX$$quota do Estado */
		SELECT TOP 1 pc_aliq_federal, pc_aliq_estadual, pc_aliq_municipal
		INTO :pdc_aliq_federal, :pdc_aliq_estadual, :pdc_aliq_municipal
		FROM imposto_aliquota ia, parametro p
		WHERE ia.cd_uf = :ps_uf_destino
			AND ia.cd_cidade is null
			AND ia.dh_inicio <= p.dh_movimentacao
			AND (ia.dh_termino is null or ia.dh_termino >= p.dh_movimentacao)
		ORDER BY ia.dh_inicio desc
			USING SQLCa;
			
		lvb_Encontrou = (SQLCa.SQLCode = 0)
	End If
	
	If Not lvb_Encontrou Then
		SetNull(pdc_aliq_federal)
		SetNull(pdc_aliq_estadual)
		SetNull(pdc_aliq_municipal)
	End If
	
	
Catch (RuntimeError lvo_Erro)
	MessageBox('Erro',lvo_Erro.GetMessage(), StopSign!)
	Return False
Finally
	//
End Try

Return lvb_Encontrou
end function

public function boolean of_calcula_cbs_ibs (string as_uf_destino, long al_cidade_destino, string as_id_tributacao_cbs_ibs, decimal adc_qt_item, decimal adc_vl_total_operacao, decimal adc_vl_frete, decimal adc_vl_outras, decimal adc_vl_seguro);return of_calcula_cbs_ibs(as_uf_destino, al_cidade_destino, as_id_tributacao_cbs_ibs, adc_qt_item, adc_vl_total_operacao, adc_vl_frete, adc_vl_outras, adc_vl_seguro, 0, 0, 0)
end function

public function boolean of_calcula_cbs_ibs (string as_uf_destino, long al_cidade_destino, string as_id_tributacao_cbs_ibs, decimal adc_qt_item, decimal adc_vl_total_operacao, decimal adc_vl_frete, decimal adc_vl_outras, decimal adc_vl_seguro, decimal adc_vl_icms, decimal adc_vl_pis, decimal adc_vl_cofins);Try		
	/* Zeramento Vari$$HEX1$$e100$$ENDHEX$$veis */
	ivo_Atributo_NF.of_inicializa_campos_reforma()
	
	/* Valida$$HEX2$$e700e300$$ENDHEX$$o Par$$HEX1$$e200$$ENDHEX$$metros */
	If IsNull(as_id_tributacao_cbs_ibs) Then
		MessageBox('Falha', 'Par$$HEX1$$e200$$ENDHEX$$metro ID Imposto Tributa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o informado para a fun$$HEX2$$e700e300$$ENDHEX$$o '+This.ClassName()+'.of_calcula_impostos_reforma().', Exclamation!)
		Return False
	End If
	
	/* Normaliza Par$$HEX1$$e200$$ENDHEX$$metros */
	If IsNull(adc_vl_total_operacao) Then adc_vl_total_operacao = 0
	If IsNull(adc_vl_frete) Then adc_vl_frete = 0
	If IsNull(adc_vl_outras) Then adc_vl_outras = 0
	If IsNull(adc_vl_seguro) Then adc_vl_seguro = 0
	
	If ivo_classif_tribut.Of_Localiza_Codigo( as_id_tributacao_cbs_ibs ) Then
		//Atribui as CST e classe tribut$$HEX1$$e100$$ENDHEX$$ria
		ivo_Atributo_NF.id_class_trib_ibscbs	= as_id_tributacao_cbs_ibs
		ivo_Atributo_NF.cd_cst_ibscbs 			= ivo_classif_tribut.ivo_imposto_cst.cd_cst_imposto
		ivo_Atributo_NF.cd_class_trib_ibscbs	= ivo_classif_tribut.cd_classe_tributaria
		
		//Se este campo estiver marcado, significa que devem ser enviados campos de CBS/IBS
		If ivo_classif_tribut.ivo_imposto_cst.id_normal = 'S' Then
			//Composi$$HEX2$$e700e300$$ENDHEX$$o da base de c$$HEX1$$e100$$ENDHEX$$lculo
			ivo_Atributo_NF.vl_bc_ibscbs = adc_vl_total_operacao + adc_vl_frete + adc_vl_outras + adc_vl_seguro - adc_vl_icms - adc_vl_pis - adc_vl_cofins
			
			//Busca al$$HEX1$$ed00$$ENDHEX$$quotas vigentes na imposto_aliquota
			If Not This.of_Aliquota_CBS_IBS( 	as_uf_destino, &
															al_cidade_destino, &
															ref ivo_Atributo_NF.pc_cbs, &
															ref ivo_Atributo_NF.pc_ibs_uf, &
															ref ivo_Atributo_NF.pc_ibs_mun) Then
				ivo_Atributo_NF.pc_cbs = 0
				ivo_Atributo_NF.pc_ibs_uf = 0
				ivo_Atributo_NF.pc_ibs_mun = 0 
			End If
			
			//Se na CST indicar redu$$HEX2$$e700e300$$ENDHEX$$o de al$$HEX1$$ed00$$ENDHEX$$quota
			If ivo_classif_tribut.ivo_imposto_cst.id_reducao_aliq = 'S' Then
				//Atribui redu$$HEX2$$e700f500$$ENDHEX$$es conforme a tributa$$HEX2$$e700e300$$ENDHEX$$o
				ivo_Atributo_NF.pc_reducao_cbs 		= ivo_classif_tribut.pc_reducao_aliq_cbs
				ivo_Atributo_NF.pc_reducao_ibs_uf	= ivo_classif_tribut.pc_reducao_aliq_ibs
				ivo_Atributo_NF.pc_reducao_ibs_mun	= ivo_classif_tribut.pc_reducao_aliq_ibs
				
				//Calcula Al$$HEX1$$ed00$$ENDHEX$$quota Efetiva
				ivo_Atributo_NF.pc_efetiva_cbs		= Round(ivo_Atributo_NF.pc_cbs * ( 1 - ivo_Atributo_NF.pc_reducao_cbs / 100), 4)
				ivo_Atributo_NF.pc_efetiva_ibs_uf	= Round(ivo_Atributo_NF.pc_ibs_uf * ( 1 - ivo_Atributo_NF.pc_reducao_ibs_uf / 100), 4)
				ivo_Atributo_NF.pc_efetiva_ibs_mun	= Round(ivo_Atributo_NF.pc_ibs_mun * ( 1 - ivo_Atributo_NF.pc_reducao_ibs_mun / 100), 4)
			Else
				SetNull(ivo_Atributo_NF.pc_reducao_cbs)
				SetNull(ivo_Atributo_NF.pc_reducao_ibs_uf)
				SetNull(ivo_Atributo_NF.pc_reducao_ibs_mun)
				SetNull(ivo_Atributo_NF.pc_efetiva_cbs)
				SetNull(ivo_Atributo_NF.pc_efetiva_ibs_uf)
				SetNull(ivo_Atributo_NF.pc_efetiva_ibs_mun)	
			End If
			
			//Tratamento de Diferimento
			If ivo_classif_tribut.ivo_imposto_cst.id_diferimento = 'S' Then
				//	At$$HEX1$$e900$$ENDHEX$$ a data da constru$$HEX2$$e700e300$$ENDHEX$$o dessa classe, o diferimento servia apenas para comerciliza$$HEX2$$e700e300$$ENDHEX$$o	de energia el$$HEX1$$e900$$ENDHEX$$trica e insumos agr$$HEX1$$ed00$$ENDHEX$$colas															//
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Essa CST possui diferimento, e o c$$HEX1$$e100$$ENDHEX$$lculo ainda n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ previsto.~r~rContate a TI.',Exclamation!)
				Return False
			Else
				SetNull(ivo_Atributo_NF.pc_dif_cbs)
				SetNull(ivo_Atributo_NF.vl_dif_cbs)
				SetNull(ivo_Atributo_NF.pc_dif_ibs_uf)
				SetNull(ivo_Atributo_NF.vl_dif_ibs_uf)
				SetNull(ivo_Atributo_NF.pc_dif_ibs_mun)
				SetNull(ivo_Atributo_NF.vl_dif_ibs_mun)
			End If
			
			//Essa parte $$HEX1$$e900$$ENDHEX$$ dedicada a calcular a tributa$$HEX2$$e700e300$$ENDHEX$$o regular, ou seja,
			// a tributa$$HEX2$$e700e300$$ENDHEX$$o que seria caso a opera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o estivesse acobertada
			// por algum incentivo (essa defini$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ na imposto_tributacao)
			If ivo_classif_tribut.id_trib_regular = 'S' Then
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Essa Classifi$$HEX2$$e700e300$$ENDHEX$$o Tribut$$HEX1$$e100$$ENDHEX$$ria deve informar/calcular a tributa$$HEX2$$e700e300$$ENDHEX$$o regular, e o c$$HEX1$$e100$$ENDHEX$$lculo ainda n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ previsto.~r~rContate a TI.',Exclamation!)
				Return False
			Else
				SetNull(ivo_Atributo_NF.id_cst_ibscbs_reg)
				SetNull(ivo_Atributo_NF.cd_cst_ibscbs_reg)
				SetNull(ivo_Atributo_NF.id_class_trib_ibscbs_reg)
				SetNull(ivo_Atributo_NF.cd_class_trib_ibscbs_reg)
				SetNull(ivo_Atributo_NF.pc_efetiva_reg_ibs_uf)
				SetNull(ivo_Atributo_NF.vl_trib_reg_ibs_uf)
				SetNull(ivo_Atributo_NF.pc_efetiva_reg_ibs_mun)
				SetNull(ivo_Atributo_NF.vl_trib_reg_ibs_mun)
				SetNull(ivo_Atributo_NF.pc_efetiva_reg_cbs)
				SetNull(ivo_Atributo_NF.vl_trib_reg_cbs)
			End If
						
			//Valor CBS = (Base CBS x Aliq. CBS) - Diferimento CBS
			ivo_Atributo_NF.vl_cbs = Round(ivo_Atributo_NF.vl_bc_ibscbs * IIF(ivo_Atributo_NF.pc_efetiva_cbs > 0, ivo_Atributo_NF.pc_efetiva_cbs, ivo_Atributo_NF.pc_cbs)/100, 2) - gf_coalesce(ivo_Atributo_NF.vl_dif_cbs, 0)
			//Valor IBS UF = (Base IBS UF x Aliq. IBS UF) - Diferimento IBS UF
			ivo_Atributo_NF.vl_ibs_uf = Round(ivo_Atributo_NF.vl_bc_ibscbs * IIF(ivo_Atributo_NF.pc_efetiva_ibs_uf > 0, ivo_Atributo_NF.pc_efetiva_ibs_uf, gf_coalesce(ivo_Atributo_NF.pc_ibs_uf,0))/100, 2) - gf_coalesce(ivo_Atributo_NF.vl_dif_ibs_uf, 0)
			//Valor IBS Mun. = (Base IBS Mun. x Aliq. IBS Mun) - Diferimento IBS Mun
			ivo_Atributo_NF.vl_ibs_mun = Round(ivo_Atributo_NF.vl_bc_ibscbs * IIF(ivo_Atributo_NF.pc_efetiva_ibs_mun > 0, ivo_Atributo_NF.pc_efetiva_ibs_mun, gf_coalesce(ivo_Atributo_NF.pc_ibs_mun,0))/100, 2) - gf_coalesce(ivo_Atributo_NF.vl_dif_ibs_mun, 0)
		Else
			ivo_Atributo_NF.vl_bc_ibscbs = 0
			ivo_Atributo_NF.pc_cbs = 0
			ivo_Atributo_NF.vl_cbs = 0
			ivo_Atributo_NF.pc_ibs_uf = 0
			ivo_Atributo_NF.vl_ibs_uf = 0
			ivo_Atributo_NF.pc_ibs_mun = 0
			ivo_Atributo_NF.vl_ibs_mun = 0
		End If
		
		//Valor do IBS (soma de vIBSUF e vIBSMun). Quando houver cr$$HEX1$$e900$$ENDHEX$$dito presumido deve ser	abatido desse valor.
		ivo_Atributo_NF.vl_ibs = gf_coalesce(ivo_Atributo_NF.vl_ibs_uf,0) + gf_coalesce(ivo_Atributo_NF.vl_ibs_mun,0)
	Else
		MessageBox('Falha', 'ID do imposto CST inexistente para fun$$HEX2$$e700e300$$ENDHEX$$o '+This.ClassName()+'.of_calcula_impostos_reforma().', Exclamation!)
		Return False
	End If
	
Catch (RuntimeError lvo_Erro)
	MessageBox('Erro',lvo_Erro.GetMessage(), StopSign!)
	Return False
	
Finally
	//
End Try

Return True
end function

on uo_tratamento_fiscal.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_tratamento_fiscal.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;Integer lvi_Contador

For lvi_Contador = 1 To UpperBound(ivo_Aliquota)
	Destroy(ivo_Aliquota[lvi_Contador])
Next

If IsValid(ivo_tipo_produto_fiscal) Then Destroy(ivo_tipo_produto_fiscal)

Destroy(ivo_UF_Origem)
Destroy(ivo_UF_Destino)
Destroy(ivo_Atributo_NF)
Destroy(ivo_Tributacao)
Destroy(ivo_Atributo)
If IsValid(ivo_tipo_produto_fiscal) Then Destroy(uo_tipo_produto_fiscal)
If IsValid(ivo_classif_tribut) Then Destroy(ivo_classif_tribut)
end event

event constructor;ivo_UF_Origem				= Create uo_Unidade_Federacao
ivo_UF_Destino				= Create uo_Unidade_Federacao
ivo_Atributo_NF			= Create uo_Atributo_Fiscal_NF
ivo_Tributacao				= Create uo_Tributacao_ICMS
ivo_Atributo				= Create uo_Atributo_Fiscal_Item_NF
ivo_tipo_produto_fiscal = Create uo_tipo_produto_fiscal
ivo_classif_tribut		= Create uo_classificacao_tributaria	

ivb_Erro = False

ivs_transferencia_vencido 			= 'N'
ivs_utiliza_nova_regra_transf 	= 'N'
ivs_devolucao_transferencia_cd	= 'N'
ivs_calculo_st_aux_transferencia	= 'N'
ivs_filial_farmacia_popular		= 'X' // Para garantir que o par$$HEX1$$e200$$ENDHEX$$metro esteja sendo informado na tela de faturamento

is_calculo_venda_simulacao_compra = 'N'

is_produto_almoxarifado = 'N'

This.of_Carrega_Parametros()
end event

