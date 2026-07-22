HA$PBExportHeader$uo_nota_fiscal.sru
forward
global type uo_nota_fiscal from nonvisualobject
end type
end forward

global type uo_nota_fiscal from nonvisualobject
end type
global uo_nota_fiscal uo_nota_fiscal

type variables

dc_uo_ds_base	ids_itens_nf
dc_uo_ds_base	ids_report_nf
dc_uo_ds_base	ids_produto_manip
dc_uo_ds_base	ids_mensagem_fiscal

end variables

forward prototypes
public function boolean selecionar_informacoes_cliente (string a_cliente, ref string a_razao_social, ref string a_cgc, ref string a_endereco, ref string a_bairro, ref string a_cep, ref string a_municipio, ref string a_fone, ref string a_uf, ref string a_inscr_est)
public function boolean selecionar_informacoes_convenio (long a_convenio, ref string a_razao_social, ref string a_cgc, ref string a_endereco, ref string a_bairro, ref string a_cep, ref string a_municipio, ref string a_fone, ref string a_fax, ref string a_uf, ref string a_inscr_est)
public function boolean selecionar_informacoes_filial (long a_filial, ref string a_razao_social, ref string a_cgc, ref string a_endereco, ref string a_bairro, ref string a_cep, ref string a_municipio, ref string a_fone, ref string a_fax, ref string a_uf, ref string a_inscr_est)
public subroutine imprimir_fatura (long a_numero1, datetime a_vencto1, decimal a_valor1, long a_numero2, datetime a_vencto2, decimal a_valor2, long a_numero3, datetime a_vencto3, decimal a_valor3)
public subroutine imprimir_transportador (string a_razao_social_transp, integer a_frete_por_conta, string a_placa_veiculo, string a_uf_placa, string a_cgc_transp, string a_endereco_transp, string a_municipio_transp, string a_uf_transp, string a_inscr_est_transp, long a_qt_transp, string a_especie_transp, string a_marca_transp, long a_nr_transp, decimal a_peso_bruto, decimal a_peso_liquido)
public subroutine emitir_nf_devolucao_venda (long a_filial_origem, long a_nr_nf, string a_especie, string a_serie)
public subroutine emitir_nf_transferencia (long a_filial_origem, long a_nr_nf, string a_especie, string a_serie)
public subroutine emitir_nf_venda (long a_filial_origem, long a_nr_nf, string a_especie, string a_serie)
public subroutine inserir_produto_manipulado (string a_tipo, long a_filial_origem, long a_nr_nf, string a_especie, string a_serie)
public subroutine imprimir_dados_adicionais (string ps_texto)
public subroutine imprimir_dados_adicionais_transferencia ()
public function boolean selecionar_informacoes_devolucao_venda (long pl_nr_filial, long pl_nr_nf, string de_especie, string de_serie, ref long pl_cd_filial_venda, ref long pl_nr_nf_venda, ref string ps_de_especie_venda, ref string ps_serie_venda, ref datetime pdth_emissao_nf_venda, ref decimal pdc_total_nf_venda)
public function long of_insere_mensagem_fiscal (ref string ls_mensagem_fiscal_1, ref string ls_mensagem_fiscal_2)
public function long of_localiza_codigo_fiscal (long pl_cd_filial, long pl_nr_nf, string ps_especie, string ps_serie, ref string ps_mensagem_fiscal, ref string ps_de_natureza_operacao)
public function boolean of_verifica_cupom (long pl_filial, long pl_nota, string ps_especie, string ps_serie)
public subroutine of_emitir_nf_anexa (long pl_filial, long pl_nota, string ps_especie_cf, string ps_serie_cf, string ps_especie_nf, string ps_serie_nf)
public function string of_nf_anexa (long pl_filial, long pl_nr_nf, string ps_especie, string ps_serie)
public subroutine imprimir_cabecalho_icms (string a_operador, string a_vendedor, string a_endereco_origem, string a_bairro_origem, string a_cidade_origem, string a_uf_origem, string a_fone_origem, string a_cep_origem, string a_saida_entrada, long a_nr_nf, string a_natureza_oper, string a_natureza_oper1, long a_cfop, string a_inscr_est_subst_trib, string a_cgc_origem, string a_inscr_est_origem, string a_razao_social_dest, string a_cgc_dest, string a_endereco_dest, string a_bairro_dest, string a_cep_dest, string a_municipio_dest, string a_fone_fax_dest, string a_uf_dest, string a_inscr_est_dest, datetime a_data_emissao, datetime a_data_saida_entr, datetime a_hora_saida)
public subroutine emitir_nf_devolucao_compra (long a_filial_origem, long a_nr_nf, string a_especie, string a_serie)
public function boolean selecionar_informacoes_fornecedor (string a_fornecedor, ref string a_razao_social, ref string a_cgc, ref string a_endereco, ref string a_bairro, ref string a_cep, ref string a_municipio, ref string a_fone, ref string a_uf, ref string a_inscr_est)
public subroutine emitir_nf_devolucao_compra_central (long a_filial_origem, long a_nr_nf, string a_especie, string a_serie)
public subroutine imprimir_calc_imposto (datastore ids_report, decimal a_base_calc_icms, decimal a_valor_icms, decimal a_base_calc_icms_subst, decimal a_valor_icms_subst, decimal a_valor_total_produto, decimal a_valor_frete, decimal a_valor_seguro, decimal a_outras_desp_acess, decimal a_valor_total_ipi, decimal a_valor_total_nota)
public subroutine imprimir_detalhe (datastore ids_report, long a_quebra, long a_linha, long a_cd_produto, string a_de_produto, long a_natureza_oper, string a_cst_produto, string a_unid_produto, long a_qt_produto, decimal a_vl_unit_produto, decimal a_pc_desc_produto, decimal a_vl_total_produto, integer a_aliq_icms)
public subroutine imprimir_ds (datastore ids_report)
public subroutine imprimir_detalhe_dev_compra (datastore ids_report, long a_quebra, long a_linha, long a_cd_produto, string a_de_produto, long a_natureza_oper, string a_cst_produto, string a_unid_produto, long a_qt_produto, decimal a_vl_unit_produto, decimal a_pc_desc_produto, decimal a_vl_total_produto, integer a_aliq_icms, string a_lista_pis_cofins, string a_icms_repassado)
public subroutine emitir_nf_diversa (long a_filial_origem, long a_nr_nf, string a_especie, string a_serie)
public subroutine of_trocar_ds (string a_tipo, string a_serie)
public subroutine emitir_nf_diversa_central (long a_filial_origem, long a_nr_nf, string a_especie, string a_serie)
public function boolean of_verifica_entrada_saida_natureza_op (integer pl_natureza, ref string ps_entrada_saida)
public function string of_localiza_nome_cidade (long pl_cidade)
public subroutine imprimir_cabecalho (datastore ids_report, string a_operador, string a_vendedor, string a_endereco_origem, string a_bairro_origem, string a_cidade_origem, string a_uf_origem, string a_fone_origem, string a_cep_origem, string a_saida_entrada, long a_nr_nf, string a_natureza_oper, string a_cfop, string a_inscr_est_subst_trib, string a_cgc_origem, string a_inscr_est_origem, string a_razao_social_dest, string a_cgc_dest, string a_endereco_dest, string a_bairro_dest, string a_cep_dest, string a_municipio_dest, string a_fone_fax_dest, string a_uf_dest, string a_inscr_est_dest, datetime a_data_emissao, datetime a_data_saida_entr, datetime a_hora_saida)
public subroutine of_prepara_natureza_operacao (ref string as_natureza)
public function boolean selecionar_informacoes_diversas_central (long a_filial, long a_nr_nf, string a_especie, string a_serie, ref string a_razao_social, ref string a_cgc_cpf, ref string a_endereco, ref string a_bairro, ref string a_cep, ref string a_municipio, ref string a_fone, ref string a_uf, ref string a_inscr_est, ref datetime a_dh_movimentacao_caixa, ref datetime a_dh_emissao, ref decimal a_vl_bc_icms, ref decimal a_vl_icms, ref decimal a_vl_bc_icms_st, ref decimal a_vl_icms_st, ref decimal a_vl_total_produtos, ref decimal a_vl_frete, ref decimal a_vl_outras_despesas, ref decimal a_vl_total_nf, ref long a_cd_natureza_operacao, ref decimal a_vl_total_ipi, ref long a_nr_nsu)
public function boolean selecionar_informacoes_devolucao_compra (long pl_nr_filial, long pl_nr_nf, string de_especie, string de_serie, ref long pl_cd_filial_compra, ref long pl_nr_nf_compra, ref string ps_de_especie_compra, ref string ps_serie_compra, ref datetime pd_movimentacao, ref datetime pd_emissao, ref long pl_nsu)
public function boolean of_proximo_nsu (ref long al_Proximo)
public function boolean selecionar_informacoes_diversas (long a_filial, long a_nr_nf, string a_especie, string a_serie, ref string a_razao_social, ref string a_cgc_cpf, ref string a_endereco, ref string a_bairro, ref string a_cep, ref string a_municipio, ref string a_fone, ref string a_uf, ref string a_inscr_est, ref datetime a_dh_emissao, ref decimal a_vl_bc_icms, ref decimal a_vl_icms, ref decimal a_vl_bc_icms_st, ref decimal a_vl_icms_st, ref decimal a_vl_total_produtos, ref decimal a_vl_frete, ref decimal a_vl_outras_despesas, ref decimal a_vl_total_nf, ref long a_cd_natureza_operacao, ref datetime a_dh_movimento, ref long a_nr_nsu)
public subroutine emitir_nf_transferencia_icms (string operador, long a_filial_origem, long a_filial_matriz, long a_nr_nf, string a_especie, string a_serie, datetime a_data_movimento, datetime a_data_emissao, long a_nr_nsu)
public subroutine emitir_nf_lancamento_imobilizado (string operador, long a_filial_origem, long a_filial_matriz, long a_nr_nf, string a_especie, string a_serie, datetime a_data_movimento, datetime a_data_emissao, long a_nr_nsu)
public subroutine selecionar_dados_adicionais (long a_filial_origem, long a_nr_nf, string a_especie, string a_serie, ref string a_dados_adicionais_1, ref string a_dados_adicionais_2, ref string a_dados_adicionais_3, ref string a_dados_adicionais_4, ref string a_dados_adicionais_5, ref string a_dados_adicionais_6, ref string a_dados_adicionais_7, ref string a_dados_adicionais_8)
public function boolean of_inclui_nf_venda_nfe (long al_filial, long al_nota, string as_especie, string as_serie)
public function boolean of_mensagem_impressao_nfe (string as_especie)
public function boolean of_verifica_dados_cliente (string as_cliente)
public function boolean of_ultima_versao_nfe (ref long pl_versao_nfe)
public function boolean of_nat_operacao_nf_anexa (string as_uf_filial, string as_uf_dados_adicionais, string as_cliente, ref long al_nat_operacao, ref string as_erro)
public function string of_cst_origem_produto (long pl_produto)
public subroutine of_emitir_nf_anexa (long pl_filial, long pl_nota, string ps_especie_cf, string ps_serie_cf, string ps_especie_nf, string ps_serie_nf, string ps_operador)
end prototypes

public function boolean selecionar_informacoes_cliente (string a_cliente, ref string a_razao_social, ref string a_cgc, ref string a_endereco, ref string a_bairro, ref string a_cep, ref string a_municipio, ref string a_fone, ref string a_uf, ref string a_inscr_est);uo_Cliente	luo_Cliente

luo_Cliente = Create uo_Cliente

luo_Cliente.of_Localiza_Codigo(a_cliente)

If luo_Cliente.Localizado Then
	
	a_razao_social = luo_Cliente.nm_cliente
	a_uf           = luo_Cliente.cd_unidade_federacao
	a_municipio    = of_Localiza_Nome_Cidade(luo_Cliente.cd_cidade)
	a_endereco     = luo_Cliente.de_endereco
	a_bairro       = luo_Cliente.de_bairro
	a_cep          = luo_Cliente.nr_cep
//	ls_fone        = luo_Cliente.nr_ddd_fone + luo_Cliente.nr_fone
	a_cgc          = luo_Cliente.nr_cpf_cgc
	a_inscr_est  	= luo_Cliente.nr_inscricao_estadual
	
	If Isnull(a_inscr_est) Then a_inscr_est = ""
	
	If IsNull(luo_Cliente.Nr_DDD_Fone) Then luo_Cliente.Nr_DDD_Fone = ""
	
	If IsNull(luo_Cliente.Nr_Fone) Then luo_Cliente.Nr_Fone = ""
	
	a_Fone = "(" + luo_Cliente.Nr_DDD_Fone + ") " + luo_Cliente.Nr_Fone
	
//	a_fone = "(" + MID(ls_fone, 1, 3) + ")" + MID(ls_fone, 4, 3) + "-" + MID(ls_fone, 7, 4)
	
//	If Len(a_cgc) = 11 Then
//		a_cgc = Gf_Colocar_Mascara_CPF(a_cgc)		
//	ElseIf Len(a_cgc) = 14 Then
//		a_cgc = Gf_Colocar_Mascara_CGC(a_cgc)		
//	End IF

Else
	
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informa$$HEX2$$e700f500$$ENDHEX$$es do cliente '" + Trim(a_Cliente) + "' n$$HEX1$$e300$$ENDHEX$$o cadastradas.", StopSign!)
	Return False
End IF

Destroy(luo_Cliente)

Return True

end function

public function boolean selecionar_informacoes_convenio (long a_convenio, ref string a_razao_social, ref string a_cgc, ref string a_endereco, ref string a_bairro, ref string a_cep, ref string a_municipio, ref string a_fone, ref string a_fax, ref string a_uf, ref string a_inscr_est);//
STRING	ls_ddd_fone,	ls_ddd_fax	, ls_fone	, ls_fax
LONG		ll_aux
//
SELECT 	convenio.nm_razao_social,   
       	convenio.nr_cgc,   
         convenio.nr_inscricao_estadual,   
         convenio.de_endereco,   
         convenio.de_bairro,   
         convenio.nr_cep,   
         convenio.nr_telefone,   
         convenio.nr_fax,   
         cidade.cd_unidade_federacao,   
         cidade.nm_cidade  
INTO 		:a_razao_social,   
         :a_cgc,   
         :a_inscr_est,   
         :a_endereco,   
         :a_bairro,   
         :a_cep,   
         :a_fone,   
         :a_fax,   
         :a_uf,   
         :a_municipio  
FROM 		convenio,   
			cidade  
WHERE 	cidade.cd_cidade 		= convenio.cd_cidade and  
			convenio.cd_convenio = :a_convenio 
USING    SQLCA;
//
IF SQLCA.SQLCode = -1 THEN
	MESSAGEBOX("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro: " + SQLCA.SQLErrText, StopSign!)
	RETURN FALSE
END IF
//
IF SQLCA.SQLCode <> 0 THEN
	MESSAGEBOX("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informa$$HEX2$$e700f500$$ENDHEX$$es do conv$$HEX1$$ea00$$ENDHEX$$nio " + STRING(a_convenio) + " n$$HEX1$$e300$$ENDHEX$$o cadastradas.", StopSign!)
	RETURN FALSE
END IF
//
a_cgc = Gf_Colocar_Mascara_CGC(a_cgc)
//
RETURN TRUE
//
end function

public function boolean selecionar_informacoes_filial (long a_filial, ref string a_razao_social, ref string a_cgc, ref string a_endereco, ref string a_bairro, ref string a_cep, ref string a_municipio, ref string a_fone, ref string a_fax, ref string a_uf, ref string a_inscr_est);//
STRING	ls_ddd_fone,	ls_ddd_fax	, ls_fone	, ls_fax
LONG		ll_aux
//
SELECT filial.nm_razao_social,   
		 filial.nr_cgc,   
		 filial.de_endereco,   
		 filial.de_bairro,   
		 filial.nr_cep,   
		 cidade.nm_cidade,   
		 filial.nr_ddd_telefone,   
		 filial.nr_telefone,   
		 filial.nr_ddd_fax,   
		 filial.nr_fax,   
		 cidade.cd_unidade_federacao,   
		 filial.nr_inscricao_estadual  
INTO	 :a_razao_social,   
		 :a_cgc,   
		 :a_endereco,   
		 :a_bairro,   
		 :a_cep,   
		 :a_municipio,   
		 :ls_ddd_fone,   
		 :ls_fone,   
		 :ls_ddd_fax,   
		 :ls_fax,   
		 :a_uf,   
		 :a_inscr_est  
FROM  filial,   
	   cidade  
WHERE cidade.cd_cidade = filial.cd_cidade and  
		filial.cd_filial = :a_filial 
USING SQLCA;
//
IF SQLCA.SQLCode = -1 THEN
	MESSAGEBOX("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro: " + SQLCA.SQLErrText, StopSign!)
	RETURN FALSE
END IF
//
IF SQLCA.SQLCode <> 0 THEN
	MESSAGEBOX("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informa$$HEX2$$e700f500$$ENDHEX$$es da filial " + STRING(a_filial) + " n$$HEX1$$e300$$ENDHEX$$o cadastradas.", StopSign!)
	RETURN FALSE
END IF
//
IF NOT ISNULL(ls_ddd_fone) THEN a_fone  = "(" + ls_ddd_fone + ") "
IF NOT ISNULL(ls_fone) 	   THEN 
	ll_aux  = LONG(ls_fone)	
	a_fone += STRING(ll_aux, "####-####")
END IF
//
IF NOT ISNULL(ls_ddd_fax)  THEN a_fax  += "(" + ls_ddd_fax + ") "
IF NOT ISNULL(ls_fax) 	   THEN 
	ll_aux = LONG(ls_fax)
	a_fax += STRING(ll_aux,  "####-####")
END IF
//
a_cgc = Gf_Colocar_Mascara_CGC(a_cgc)
//
RETURN TRUE
//
end function

public subroutine imprimir_fatura (long a_numero1, datetime a_vencto1, decimal a_valor1, long a_numero2, datetime a_vencto2, decimal a_valor2, long a_numero3, datetime a_vencto3, decimal a_valor3);//
ids_report_nf.Object.numero1_fatura_t	.Text = STRING(a_numero1)
ids_report_nf.Object.vencto1_fatura_t	.Text = STRING(a_vencto1 , "DD/MM/YYYY")	
ids_report_nf.Object.valor1_fatura_t	.Text = STRING(a_valor1  , "#,###,##0.00")	
ids_report_nf.Object.numero2_fatura_t	.Text = STRING(a_numero2)
ids_report_nf.Object.vencto2_fatura_t	.Text = STRING(a_vencto2 , "DD/MM/YYYY")	
ids_report_nf.Object.valor2_fatura_t	.Text = STRING(a_valor2  , "#,###,##0.00")		
ids_report_nf.Object.numero3_fatura_t	.Text = STRING(a_numero3)
ids_report_nf.Object.vencto3_fatura_t	.Text = STRING(a_vencto3 , "DD/MM/YYYY")	
ids_report_nf.Object.valor3_fatura_t	.Text = STRING(a_valor3  , "#,###,##0.00")		
//
end subroutine

public subroutine imprimir_transportador (string a_razao_social_transp, integer a_frete_por_conta, string a_placa_veiculo, string a_uf_placa, string a_cgc_transp, string a_endereco_transp, string a_municipio_transp, string a_uf_transp, string a_inscr_est_transp, long a_qt_transp, string a_especie_transp, string a_marca_transp, long a_nr_transp, decimal a_peso_bruto, decimal a_peso_liquido);//
ids_report_nf.Object.razao_social_transp_t	.Text = a_razao_social_transp
ids_report_nf.Object.frete_por_conta_t			.Text = STRING(a_frete_por_conta)
ids_report_nf.Object.placa_veiculo_transp_t	.Text = a_placa_veiculo
ids_report_nf.Object.uf_placa_transp_t			.Text = a_uf_placa
ids_report_nf.Object.cgc_transp_t				.Text = a_cgc_transp
ids_report_nf.Object.endereco_transp_t			.Text = a_endereco_transp
ids_report_nf.Object.municipio_transp_t		.Text = a_municipio_transp
ids_report_nf.Object.uf_transp_t					.Text = a_uf_transp
ids_report_nf.Object.inscr_est_transp_t		.Text = a_inscr_est_transp
ids_report_nf.Object.qt_transp_t					.Text = STRING(a_qt_transp		, "#,###,##0")
ids_report_nf.Object.especie_transp_t			.Text = a_especie_transp	
ids_report_nf.Object.marca_transp_t				.Text = a_marca_transp
ids_report_nf.Object.nr_transp_t					.Text = STRING(a_nr_transp		, "#,###,##0")
ids_report_nf.Object.peso_bruto_transp_t		.Text = STRING(a_peso_bruto	, "#,###,##0.00")
ids_report_nf.Object.peso_liquido_transp_t	.Text = STRING(a_peso_liquido	, "#,###,##0.00")
//
end subroutine

public subroutine emitir_nf_devolucao_venda (long a_filial_origem, long a_nr_nf, string a_especie, string a_serie);// Controle para n$$HEX1$$e300$$ENDHEX$$o imprimir nota fiscal eletr$$HEX1$$f400$$ENDHEX$$nica
//If a_especie = 'NFE' Then Return

// Se for NFE vai mostrar a mensagem e retornar como falso
// N$$HEX1$$e300$$ENDHEX$$o vai imprimir a NFE
If Not This.of_Mensagem_Impressao_NFE(a_especie) Then
	Return
End If

Long ll_row, &
	  ll_max, &
	  ll_nulo, &
	  ll_quebra, &
	  ll_insert, &
	  ll_linha, &
	  lvl_cd_filial_venda, &
	  lvl_nr_nf_venda, &
	  ll_qt_mensagem_fiscal, &
	  ll_mensagem

Integer lvi_Linha, &
        lvi_Qt_Linhas_Nf

String ls_cgc_dest, &
       ls_endereco_dest, &
		 ls_bairro_dest, &
		 ls_municipio_dest, &	 
	    ls_cgc_ori, &
		 ls_endereco_ori, &
		 ls_bairro_ori, &
		 ls_municipio_ori, &	 
		 ls_fone_dest, &
		 ls_uf_dest, &
		 ls_cep_dest, &
		 ls_inscr_est_ori, &	 
		 ls_fone_ori, &
		 ls_uf_ori, &
		 ls_cep_ori, &
		 ls_inscr_est_dest, &
		 ls_fax, &
		 ls_razao_social, &
		 ls_nulo, &
		 ls_mensagem, &
		 ls_aux, &
		 lvs_de_especie_venda, &
		 lvs_de_serie_venda  , &
	    ls_mensagem_fiscal_1, &
		 ls_mensagem_fiscal_2, &
		 ls_dados_adicionais1, &
		 ls_dados_adicionais2, &
		 ls_dados_adicionais3, &
		 ls_dados_adicionais4, &
		 ls_dados_adicionais5
		 
DateTime ld_nulo, &
         lvdth_emissao_nf_venda
			
Decimal{2} ldc_nulo, &
           ldc_sum_total, &
			  lvdc_vl_total_nf_venda
			  
String lvs_Natureza_Operacao
	
Open(w_ge033_prepara_impressora)

of_Trocar_Ds("DV", a_serie)

ll_max = ids_itens_nf.Retrieve(a_filial_origem, a_nr_nf, a_especie, a_serie)

IF ll_max <= 0 THEN
	MESSAGEBOX("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Dados da nota fiscal " + STRING(a_nr_nf) + " n$$HEX1$$e300$$ENDHEX$$o localizados para impress$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
	RETURN
END IF

// Funcao que verifica se existe mensagem fiscal
ll_qt_mensagem_fiscal = of_insere_mensagem_fiscal(ls_mensagem_fiscal_1, ls_mensagem_fiscal_2)

SETNULL(ll_nulo)
SETNULL(ls_nulo)
SETNULL(ld_nulo)
SETNULL(ldc_nulo)

// Filial Origem
Selecionar_Informacoes_Filial(a_filial_origem		  , &
										ls_razao_social		  , &
										ls_cgc_ori				  , &
										ls_endereco_ori		  , &
										ls_bairro_ori			  , &
										ls_cep_ori				  , &
										ls_municipio_ori		  , &
										ls_fone_ori				  , &
										ls_fax					  , &	
										ls_uf_ori				  , &
										ls_inscr_est_ori)

// Seleciona as informa$$HEX2$$e700f500$$ENDHEX$$es do destino
// Primeiramente verifica se existem informa$$HEX2$$e700f500$$ENDHEX$$es do cliente n$$HEX1$$e300$$ENDHEX$$o cadastrado
// Se n$$HEX1$$e300$$ENDHEX$$o existir, localiza os dados do cliente, se houver
Select de_endereco,
		 de_bairro,
		 nr_cep,
		 nr_telefone,
		 nm_cidade,
		 nm_uf,
		 nm_cliente,
		 nr_cgc_cpf
Into :ls_endereco_dest,
	  :ls_bairro_dest,
	  :ls_cep_dest,
	  :ls_fone_dest,
	  :ls_municipio_dest,
	  :ls_uf_dest,
	  :ls_razao_social,
	  :ls_cgc_dest
From nf_devolucao_venda_loja
Where cd_filial  = :a_filial_origem
  and nr_nf		  = :a_nr_nf
  and de_especie = :a_especie
  and de_serie   = :a_serie
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		IF NOT ISNULL(ids_itens_nf.Object.cd_cliente[1]) THEN
			
			Selecionar_Informacoes_Cliente(ids_itens_nf.Object.cd_cliente[1]	, &
													 ls_razao_social		   				, &
													 ls_cgc_dest				  				, &
													 ls_endereco_dest		   				, &
													 ls_bairro_dest			  				, &
													 ls_cep_dest				  				, &
													 ls_municipio_dest		  				, &
													 ls_fone_dest								, &
													 ls_uf_dest				   				, &
													 ls_inscr_est_dest)
			
		END IF
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos Dados do Cliente n$$HEX1$$e300$$ENDHEX$$o Cadastrado")
		Return
End Choose

Selecionar_Informacoes_devolucao_venda( a_filial_origem		  , &
			                               a_nr_nf        		  , &
													 a_especie      		  , &
													 a_serie        		  , &
													 lvl_cd_filial_venda	  , &
													 lvl_nr_nf_venda       , &
													 lvs_de_especie_venda  , &
													 lvs_de_serie_venda    , &
													 lvdth_emissao_nf_venda, &
													 lvdc_vl_total_nf_venda)

Imprimir_Dados_Adicionais("Dev. NF " + String(lvl_nr_nf_venda) 	 + " " + &
                                              lvs_de_especie_venda + " " + &
													       lvs_de_serie_venda)
Imprimir_Dados_Adicionais("Filial: " + String(lvl_cd_filial_venda,"0000"))
Imprimir_Dados_Adicionais("de: " + String(lvdth_emissao_nf_venda,"dd/mm/yyyy"))
Imprimir_Dados_Adicionais("Valor: " + String(lvdc_vl_total_nf_venda))

//Dados adicionais NSU
If ids_itens_nf.Object.dh_movimentacao_caixa[1] >= datetime(date("2007/07/01")) Then
	ls_dados_adicionais1 = ''
	ls_dados_adicionais2 = 'NSU: '+string(ids_itens_nf.Object.nr_nsu[1])+' em'
	ls_dados_adicionais3 = string(ids_itens_nf.Object.dh_recebimento[1],'dd/mm/yyyy hh:mm')
	ls_dados_adicionais4 = '~rBase c$$HEX1$$e100$$ENDHEX$$lculo ST: ' + String(lvdc_vl_total_nf_venda)
	ls_dados_adicionais5 = 'Valor do ST: ' + String(lvdc_vl_total_nf_venda * 0.03,"#,##0.00")
	
	Imprimir_Dados_Adicionais(ls_dados_adicionais1)
	Imprimir_Dados_Adicionais(ls_dados_adicionais2)
	Imprimir_Dados_Adicionais(ls_dados_adicionais3)
	Imprimir_Dados_Adicionais(ls_dados_adicionais4)
	Imprimir_Dados_Adicionais(ls_dados_adicionais5)
End If

If LenA(ls_cgc_dest) = 11 Then
	ls_cgc_dest = Gf_Colocar_Mascara_CPF(ls_cgc_dest)		
ElseIf LenA(ls_cgc_dest) = 14 Then
	ls_cgc_dest = Gf_Colocar_Mascara_CGC(ls_cgc_dest)		
End IF

This.of_Prepara_Natureza_Operacao(ref lvs_Natureza_Operacao)

Imprimir_Cabecalho(ids_report_nf, &
                   "Operador: " + ids_itens_nf.Object.nr_matricula_operador[1], &
						 ""											, &
						 ls_endereco_ori							, &
						 ls_bairro_ori								, &
						 ls_municipio_ori							, &
						 ls_uf_ori									, &
						 ls_fone_ori								, &
						 ls_cep_ori									, &
						 "E"											, &
						 a_nr_nf										, &
						 "DEVOLU$$HEX2$$c700c300$$ENDHEX$$O VENDA"						, &
						 lvs_Natureza_Operacao				, &
						 ls_nulo										, &
						 ls_cgc_ori									, &
						 ls_inscr_est_ori							, &
						 ls_razao_social							, &
						 ls_cgc_dest								, &
						 ls_endereco_dest							, &
						 ls_bairro_dest							, &
						 ls_cep_dest								, &
						 ls_municipio_dest						, &
						 ls_fone_dest								, &
						 ls_uf_dest									, &
						 ls_inscr_est_dest						, &
						 ids_itens_nf.Object.dh_movimentacao_caixa[1]	, &
						 ld_nulo										, &
						 ld_nulo)

Imprimir_Calc_Imposto(ids_report_nf, &
   						 ids_itens_nf.Object.vl_bc_icms			[1], &
							 ids_itens_nf.Object.vl_icms				[1], &
							 ids_itens_nf.Object.vl_bc_icms_st		[1], &
							 ids_itens_nf.Object.vl_icms_st			[1], &
							 ids_itens_nf.Object.vl_total_produtos	[1], &
							 ids_itens_nf.Object.vl_frete				[1], &
							 ldc_nulo, &
							 ids_itens_nf.Object.vl_outras_despesas[1], &
							 ldc_nulo, &
							 ids_itens_nf.Object.vl_total_nf			[1])

ll_quebra = 1

Inserir_Produto_Manipulado("DV", a_filial_origem, a_nr_nf, a_especie, a_serie)

CHOOSE CASE ll_qt_mensagem_fiscal
	CASE 1
		ids_itens_nf.InsertRow(0)
	CASE 2
		ids_itens_nf.InsertRow(0)
		ids_itens_nf.InsertRow(0)
END CHOOSE

ll_max    = ids_itens_nf.RowCount()
lvi_Linha = 1

FOR ll_row = 1 TO ll_max
	
	If lvi_Linha = 1 Then
		lvi_Qt_Linhas_Nf = 7
	Else
		lvi_Qt_Linhas_Nf = 5
	End If
	
	IF MOD(ll_row, lvi_Qt_Linhas_Nf) = 0 THEN 
		
		ll_insert = ids_report_nf.InsertRow(0)
		ls_mensagem = "A TRANSPORTAR "//PARA A NOTA FISCAL " + STRING(a_nr_nf) + "/" + STRING(ll_quebra +1) + ": " + String(ldc_sum_total,"###,###,##0.00")
		ids_report_nf.Object.mensagem		[ll_insert] = ls_mensagem  
		ids_report_nf.Object.vl_sum_total[ll_insert] = ldc_sum_total
		ids_report_nf.Object.quebra	 	[ll_insert] = ll_quebra
		ll_linha += 1
		ids_report_nf.Object.linha	 		[ll_insert] = ll_linha
		
		ll_quebra += 1
		
		ll_insert = ids_report_nf.InsertRow(0)
		ls_mensagem = "DE TRANSPORTE "// DA NOTA FISCAL " + STRING(a_nr_nf) + "/" + STRING(ll_quebra -1) + ": " + String(ldc_sum_total,"###,###,##0.00")
		ids_report_nf.Object.mensagem		[ll_insert] = ls_mensagem
		ids_report_nf.Object.vl_sum_total[ll_insert] = ldc_sum_total
		ids_report_nf.Object.quebra	 	[ll_insert] = ll_quebra
		ll_linha += 1
		ids_report_nf.Object.linha	 		[ll_insert] = ll_linha
		
		lvi_Linha = 2
		//ldc_sum_total  = 0
		
	END IF
		
	ldc_sum_total = ldc_sum_total + ids_itens_nf.Object.c_valor_total [ll_row]
	ll_linha 	 += 1
	
	Imprimir_Detalhe(ids_report_nf, &
						  ll_quebra															, &
						  ll_linha															, &	
						  ids_itens_nf.Object.cd_produto				 	[ll_row] , &
						  ids_itens_nf.Object.de_produto				 	[ll_row] , &
						  ids_itens_nf.Object.cd_natureza_operacao	[ll_row] , &
						  ids_itens_nf.Object.cd_situacao_tributaria	[ll_row] , &
						  ids_itens_nf.Object.cd_unidade_medida_venda[ll_row] , &
						  ids_itens_nf.Object.qt_devolvida				[ll_row]	, &
						  ids_itens_nf.Object.vl_preco_unitario		[ll_row]	, &
						  ids_itens_nf.Object.pc_desconto				[ll_row]	, &
						  ids_itens_nf.Object.c_valor_total			 	[ll_row]	, &
						  ids_itens_nf.Object.pc_icms					 	[ll_row])
										
END FOR

ll_max      = ids_report_nf.RowCount()
ll_mensagem = ll_max

ll_insert = ids_report_nf.InsertRow(0)
ls_mensagem = "DESCONTO NA NOTA FISCAL DE : " + STRING(ids_itens_nf.Object.pc_desconto_nf[1], "##0.00") + "%"
ids_report_nf.Object.mensagem		[ll_insert] = ls_mensagem  
ids_report_nf.Object.quebra	 	[ll_insert] = ll_quebra
ll_linha += 1
ids_report_nf.Object.linha	 		[ll_insert] = ll_linha

ll_max = ids_report_nf.RowCount()

// Insere linhas no detalhe at$$HEX1$$e900$$ENDHEX$$ completar 7.
DO WHILE ll_max < (ll_quebra * 7) 
	ll_insert = ids_report_nf.InsertRow(0)
	ids_report_nf.Object.quebra[ll_insert] = ll_quebra
	ll_linha += 1
	ids_report_nf.Object.linha [ll_insert] = ll_linha
	ll_max += 1
LOOP

If ll_qt_mensagem_fiscal = 1 Then
	
	ll_insert = ll_mensagem
	
ElseIf ll_qt_mensagem_fiscal = 2 Then
	
	ll_insert = ll_mensagem - 1
	
End If

// Imprime Mensagem Fiscal

CHOOSE CASE ll_qt_mensagem_fiscal
	CASE 1
		ids_report_nf.Object.mensagem[ll_insert    ] = ls_mensagem_fiscal_1 
	CASE 2
		ids_report_nf.Object.mensagem[ll_insert    ] = ls_mensagem_fiscal_1 
	   ids_report_nf.Object.mensagem[ll_insert + 1] = ls_mensagem_fiscal_2 
END CHOOSE

Imprimir_Ds(ids_report_nf)
end subroutine

public subroutine emitir_nf_transferencia (long a_filial_origem, long a_nr_nf, string a_especie, string a_serie);// Controle para n$$HEX1$$e300$$ENDHEX$$o imprimir nota fiscal eletr$$HEX1$$f400$$ENDHEX$$nica
//If a_especie = 'NFE' Then Return

// Se for NFE vai mostrar a mensagem e retornar como falso
// N$$HEX1$$e300$$ENDHEX$$o vai imprimir a NFE
If Not This.of_Mensagem_Impressao_NFE(a_especie) Then
	Return
End If

//
OPEN(w_ge033_prepara_impressora)
//
LONG		ll_row		         , ll_max			, ll_nulo	, ll_quebra	, ll_insert, ll_linha
LONG     ll_qt_mensagem_fiscal, ll_mensagem	
INTEGER  lvi_Qt_Linhas_NF, lvi_Linha
STRING	ls_cgc_dest	, ls_endereco_dest, ls_bairro_dest	, ls_municipio_dest	 
STRING	ls_cgc_ori	, ls_endereco_ori	, ls_bairro_ori	, ls_municipio_ori	 
STRING	ls_fone_dest, ls_uf_dest		, ls_cep_dest		, ls_inscr_est_ori	 
STRING	ls_fone_ori	, ls_uf_ori			, ls_cep_ori		, ls_inscr_est_dest	
STRING	ls_fax		, ls_razao_social , ls_nulo			, ls_mensagem			, ls_aux
STRING   ls_mensagem_fiscal_1          , ls_mensagem_fiscal_2
STRING   ls_dados_adicionais1 , ls_dados_adicionais2 , ls_dados_adicionais3
DATETIME	ld_nulo
DEC{2}	ldc_nulo		, ldc_sum_total

String lvs_Natureza_Operacao
	
of_Trocar_Ds("TR",a_serie)

ll_max = ids_itens_nf.Retrieve(a_filial_origem, a_nr_nf, a_especie, a_serie)

IF ll_max <= 0 THEN
	MESSAGEBOX("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nota Fiscal " + STRING(a_nr_nf) + " n$$HEX1$$e300$$ENDHEX$$o cont$$HEX1$$e900$$ENDHEX$$m itens cadastrados.", StopSign!)
	RETURN
END IF

// Funcao que verifica se existe mensagem fiscal
ll_qt_mensagem_fiscal = of_insere_mensagem_fiscal(ls_mensagem_fiscal_1, &
																  ls_mensagem_fiscal_2)
SETNULL(ll_nulo)
SETNULL(ls_nulo)
SETNULL(ld_nulo)
SETNULL(ldc_nulo)

// Filial Origem
Selecionar_Informacoes_Filial(a_filial_origem		  , &
										ls_razao_social		  , &
										ls_cgc_ori				  , &
										ls_endereco_ori		  , &
										ls_bairro_ori			  , &
										ls_cep_ori				  , &
										ls_municipio_ori		  , &
										ls_fone_ori				  , &
										ls_fax					  , &	
										ls_uf_ori				  , &
										ls_inscr_est_ori)

// Filial Destino
Selecionar_Informacoes_Filial(ids_itens_nf.Object.cd_filial_destino[1]	, &
										ls_razao_social		   						, &
										ls_cgc_dest				   						, &
										ls_endereco_dest		   						, &
										ls_bairro_dest			   						, &
										ls_cep_dest				   						, &
										ls_municipio_dest		   						, &
										ls_fone_dest										, &
										ls_fax												, & 
										ls_uf_dest				   						, &
										ls_inscr_est_dest)

This.of_Prepara_Natureza_Operacao(ref lvs_Natureza_Operacao)

Imprimir_Cabecalho(ids_report_nf, &
						 "Operador: " + ids_itens_nf.Object.nr_matricula_operador[1], &
						 ""											, &
						 ls_endereco_ori							, &
						 ls_bairro_ori								, &
						 ls_municipio_ori							, &
						 ls_uf_ori									, &
						 ls_fone_ori								, &
						 ls_cep_ori									, &
						 "S"											, &
						 a_nr_nf										, &
						 "TRANSFER$$HEX1$$ca00$$ENDHEX$$NCIA"							, &
						 lvs_Natureza_Operacao				, &
						 ls_nulo										, &
						 ls_cgc_ori									, &
						 ls_inscr_est_ori							, &
						 ls_razao_social							, &
						 ls_cgc_dest								, &
						 ls_endereco_dest							, &
						 ls_bairro_dest							, &
						 ls_cep_dest								, &
						 ls_municipio_dest						, &
						 ls_fone_dest								, &
						 ls_uf_dest									, &
						 ls_inscr_est_dest						, &
						 ids_itens_nf.Object.dh_movimentacao_caixa[1], &
						 ld_nulo										, &
						 ld_nulo)

Imprimir_Calc_Imposto(ids_report_nf, &
							 ids_itens_nf.Object.vl_bc_icms			[1], &
							 ids_itens_nf.Object.vl_icms				[1], &
							 ids_itens_nf.Object.vl_bc_icms_st		[1], &
							 ids_itens_nf.Object.vl_icms_st			[1], &
							 ids_itens_nf.Object.vl_total_produtos	[1], &
							 ldc_nulo, &
							 ldc_nulo, &
							 ldc_nulo, &
							 ldc_nulo, &
							 ids_itens_nf.Object.vl_total_nf			[1])

Imprimir_dados_adicionais_transferencia()

//Dados adicionais NSU
If ids_itens_nf.Object.dh_movimentacao_caixa[1] >= datetime(date("2007/07/01")) Then
	ls_dados_adicionais1 = ''
	ls_dados_adicionais2 = 'NSU: '+string(ids_itens_nf.Object.nr_nsu[1])+' em'
	ls_dados_adicionais3 = string(ids_itens_nf.Object.dh_emissao[1],'dd/mm/yyyy hh:mm')
	Imprimir_Dados_Adicionais(ls_dados_adicionais1)
	Imprimir_Dados_Adicionais(ls_dados_adicionais2)
	Imprimir_Dados_Adicionais(ls_dados_adicionais3)
End If

Inserir_Produto_Manipulado("TR", a_filial_origem, a_nr_nf, a_especie, a_serie)

CHOOSE CASE ll_qt_mensagem_fiscal
	CASE 1
		ids_itens_nf.InsertRow(0)
	CASE 2
		ids_itens_nf.InsertRow(0)
		ids_itens_nf.InsertRow(0)
END CHOOSE

ll_max = ids_itens_nf.RowCount() 

ll_quebra      = 1
ldc_sum_total  = 0
lvi_Linha      = 1

FOR ll_row = 1 TO ll_max 
	
	If lvi_Linha = 1 Then
		lvi_Qt_Linhas_Nf = 7
	Else
		lvi_Qt_Linhas_Nf = 5
	End If

	IF (MOD(ll_row    , lvi_Qt_Linhas_Nf) = 0 AND ll_row <> ll_max and lvi_linha = 1) or &
		(MOD(ll_row - 2, lvi_Qt_Linhas_Nf) = 0 AND ll_row <> ll_max and lvi_linha = 2) THEN 
		
		ll_insert = ids_report_nf.InsertRow(0)
		ls_mensagem = "A TRANSPORTAR " //+ String(ldc_sum_total,"###,###,##0.00")//PARA A NOTA FISCAL " + STRING(a_nr_nf) + "/" + STRING(ll_quebra +1) + ": " + String(ldc_sum_total,"###,###,##0.00")
		ids_report_nf.Object.mensagem		[ll_insert] = ls_mensagem  
		ids_report_nf.Object.vl_sum_total[ll_insert] = ldc_sum_total
		ids_report_nf.Object.quebra	 	[ll_insert] = ll_quebra
		ll_linha += 1
		ids_report_nf.Object.linha	 		[ll_insert] = ll_linha
		
		ll_quebra += 1
		
		ll_insert = ids_report_nf.InsertRow(0)
		ls_mensagem = "DE TRANSPORTE " //+ String(ldc_sum_total,"###,###,##0.00") //DA NOTA FISCAL " + STRING(a_nr_nf) + "/" + STRING(ll_quebra -1) + ": " + String(ldc_sum_total,"###,###,##0.00")
		ids_report_nf.Object.mensagem		[ll_insert] = ls_mensagem
		ids_report_nf.Object.vl_sum_total[ll_insert] = ldc_sum_total
		ids_report_nf.Object.quebra	 	[ll_insert] = ll_quebra
		ll_linha += 1
		ids_report_nf.Object.linha	 		[ll_insert] = ll_linha
		
		lvi_Linha = 2
		//ldc_sum_total  = 0
		
	END IF
			
	// Verifica se a linha $$HEX1$$e900$$ENDHEX$$ menor ou igual que a quantidade de itens da nota
	If ll_row <= ids_itens_nf.RowCount() Then
		ldc_sum_total = ldc_sum_total + ids_itens_nf.Object.c_valor_total [ll_row]
		ll_linha 	 += 1
		
		Imprimir_Detalhe(ids_report_nf, &
							  ll_quebra, ll_linha											, &	
							  ids_itens_nf.Object.cd_produto				 	[ll_row] , &
							  ids_itens_nf.Object.de_produto				 	[ll_row] , &
							  ids_itens_nf.Object.cd_natureza_operacao	[ll_row] , &
							  ids_itens_nf.Object.cd_situacao_tributaria [ll_row] , &
							  ids_itens_nf.Object.cd_unidade_medida_venda[ll_row] , &
							  ids_itens_nf.Object.qt_transferida			[ll_row]	, &
							  ids_itens_nf.Object.vl_custo_unitario		[ll_row]	, &
							  0																	, &	 
							  ids_itens_nf.Object.c_valor_total			 	[ll_row]	, &
							  ids_itens_nf.Object.pc_icms					 	[ll_row])
	End If
END FOR

ll_max      = ids_report_nf.RowCount() 
ll_mensagem = ll_max

// Insere linhas no detalhe at$$HEX1$$e900$$ENDHEX$$ completar 7
DO WHILE ll_max < (ll_quebra * lvi_Qt_Linhas_Nf) 
	ll_insert = ids_report_nf.InsertRow(0)	
	ids_report_nf.Object.quebra[ll_insert] = ll_quebra
	ll_linha += 1
	ids_report_nf.Object.linha [ll_insert] = ll_linha
	ll_max += 1
LOOP

If ll_qt_mensagem_fiscal = 1 Then
	ll_insert = ll_mensagem
	ll_insert = ids_report_nf.RowCount()
ElseIf ll_qt_mensagem_fiscal = 2 Then
	ll_insert = ll_mensagem -1
	ll_insert = ids_report_nf.RowCount() - 1
End If

// Imprime Mensagem Fiscal
CHOOSE CASE ll_qt_mensagem_fiscal
	CASE 1
		ids_report_nf.Object.mensagem[ll_insert    ] = ls_mensagem_fiscal_1 
	CASE 2
		ids_report_nf.Object.mensagem[ll_insert    ] = ls_mensagem_fiscal_1 
	   ids_report_nf.Object.mensagem[ll_insert + 1] = ls_mensagem_fiscal_2 
END CHOOSE

Imprimir_Ds(ids_report_nf)
end subroutine

public subroutine emitir_nf_venda (long a_filial_origem, long a_nr_nf, string a_especie, string a_serie);// Controle para n$$HEX1$$e300$$ENDHEX$$o imprimir nota fiscal eletr$$HEX1$$f400$$ENDHEX$$nica
If a_especie = 'NFE' Then Return

OPEN(w_ge033_prepara_impressora)

LONG		ll_row		, ll_max				, ll_nulo			, ll_quebra		, ll_insert, ll_linha
LONG     ll_qt_mensagem_fiscal, ll_mensagem 
INTEGER  lvi_Linha, lvi_Qt_Linhas_Nf
STRING	ls_cgc_dest	, ls_endereco_dest, ls_bairro_dest	, ls_municipio_dest	 
STRING	ls_cgc_ori	, ls_endereco_ori	, ls_bairro_ori	, ls_municipio_ori	 
STRING	ls_fone_dest, ls_uf_dest		, ls_cep_dest		, ls_inscr_est_ori	 
STRING	ls_fone_ori	, ls_uf_ori			, ls_cep_ori		, ls_inscr_est_dest	
STRING	ls_fax		, ls_razao_social , ls_nulo			, ls_mensagem			, ls_aux
STRING   ls_mensagem_fiscal_1          , ls_mensagem_fiscal_2 , ls_Anexa 
STRING   ls_dados_adicionais1 , ls_dados_adicionais2 , ls_dados_adicionais3, ls_dados_adicionais4, ls_dados_adicionais5
DATETIME	ld_nulo
DEC{2}	ldc_nulo		, ldc_sum_total, ldc_pago_avista, ldc_total_nf

String lvs_Natureza_Operacao
	
of_Trocar_Ds("VE",a_serie)

ll_max = ids_itens_nf.Retrieve(a_filial_origem, a_nr_nf, a_especie, a_serie)

IF ll_max <= 0 THEN
	MESSAGEBOX("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nota Fiscal " + STRING(a_nr_nf) + " n$$HEX1$$e300$$ENDHEX$$o cont$$HEX1$$e900$$ENDHEX$$m itens cadastrados.", StopSign!)
	RETURN
END IF

// Funcao que verifica se existe mensagem fiscal
ll_qt_mensagem_fiscal = of_insere_mensagem_fiscal(ls_mensagem_fiscal_1, &
																  ls_mensagem_fiscal_2)

SETNULL(ll_nulo)
SETNULL(ls_nulo)
SETNULL(ld_nulo)
SETNULL(ldc_nulo)

// Filial Origem
Selecionar_Informacoes_Filial(a_filial_origem		  , &
										ls_razao_social		  , &
										ls_cgc_ori				  , &
										ls_endereco_ori		  , &
										ls_bairro_ori			  , &
										ls_cep_ori				  , &
										ls_municipio_ori		  , &
										ls_fone_ori				  , &
										ls_fax					  , &	
										ls_uf_ori				  , &
										ls_inscr_est_ori)

ls_Anexa = Of_Nf_Anexa(a_filial_origem,a_nr_nf,a_especie,a_serie)										
//
IF Trim(ls_Anexa) <> "" THEN Imprimir_Dados_Adicionais("CFE CUPOM FISCAL :" + ls_Anexa)
//
IF NOT ISNULL(ids_itens_nf.Object.cd_convenio[1]) THEN
		
	Selecionar_Informacoes_Convenio(ids_itens_nf.Object.cd_convenio[1]	, &
											  ls_razao_social		   					, &
											  ls_cgc_dest				   				, &
											  ls_endereco_dest		   				, &
											  ls_bairro_dest			   				, &
											  ls_cep_dest				   				, &
											  ls_municipio_dest		   				, &
											  ls_fone_dest									, &
											  ls_fax											, & 
											  ls_uf_dest				   				, &
											  ls_inscr_est_dest)
	
ELSEIF NOT ISNULL(ids_itens_nf.Object.cd_cliente[1]) THEN
	
	Selecionar_Informacoes_Cliente(ids_itens_nf.Object.cd_cliente[1]	, &
											 ls_razao_social		   				, &
											 ls_cgc_dest				  				, &
											 ls_endereco_dest		   				, &
											 ls_bairro_dest			  				, &
											 ls_cep_dest				  				, &
											 ls_municipio_dest		  				, &
											 ls_fone_dest							, &
											 ls_uf_dest				   				, &
											 ls_inscr_est_dest)
	
ELSE
	
	ls_razao_social	= ids_itens_nf.Object.nm_cliente	[1]
	ls_cgc_dest			= ids_itens_nf.Object.nr_cgc_cpf	[1]
	If LenA(ls_cgc_dest) >= 14 Then
		ls_cgc_dest = gf_colocar_mascara_cgc(ls_cgc_dest)
	Else
		ls_cgc_dest = gf_colocar_mascara_cpf(ls_cgc_dest)
	End If
	ls_endereco_dest	= ids_itens_nf.Object.de_endereco			[1]
	ls_bairro_dest		= ids_itens_nf.Object.de_bairro				[1]
	ls_cep_dest			= ids_itens_nf.Object.nr_cep					[1]
	ls_municipio_dest	= ids_itens_nf.Object.nm_cidade				[1]
	ls_fone_dest		= ids_itens_nf.Object.nr_telefone				[1]
	ls_fax					= ""
	ls_uf_dest			= ids_itens_nf.Object.nm_uf					[1]
	ls_inscr_est_dest	= ids_itens_nf.Object.nr_inscricao_estadual	[1]
	
END IF

ldc_pago_avista 		= ids_itens_nf.Object.vl_pago_avista			[1]
ldc_total_nf				= ids_itens_nf.Object.vl_total_nf 				[1]

//Dados adicionais NSU
If DateTime(ids_itens_nf.Object.dh_movimentacao_caixa[1]) >= datetime(date("2007/07/01")) Then
	ls_dados_adicionais1 = ''
	ls_dados_adicionais2 = 'NSU: '+string( ids_itens_nf.Object.nr_nsu[1] )+' em'
	ls_dados_adicionais3 = string( ids_itens_nf.Object.dh_emissao[1],'dd/mm/yyyy hh:mm' )
	ls_dados_adicionais4 = '~rBase c$$HEX1$$e100$$ENDHEX$$lculo ST: ' + String( ids_itens_nf.Object.vl_total_nf[1] )
	ls_dados_adicionais5 = 'Valor do ST: ' + String( ids_itens_nf.Object.vl_total_nf[1] * 0.03,"#,##0.00" )
	
	Imprimir_Dados_Adicionais(ls_dados_adicionais1)
	Imprimir_Dados_Adicionais(ls_dados_adicionais2)
	Imprimir_Dados_Adicionais(ls_dados_adicionais3)
	Imprimir_Dados_Adicionais(ls_dados_adicionais4)
	Imprimir_Dados_Adicionais(ls_dados_adicionais5)
End If

This.of_Prepara_Natureza_Operacao(ref lvs_Natureza_Operacao)

Imprimir_Cabecalho(ids_report_nf, &
						 "Operador: " + ids_itens_nf.Object.nr_matric_operador	[1], &
						 "Vendedor: " + ids_itens_nf.Object.nr_matricula_vendedor[1], &
						 ls_endereco_ori							, &
						 ls_bairro_ori								, &
						 ls_municipio_ori							, &
						 ls_uf_ori										, &
						 ls_fone_ori									, &
						 ls_cep_ori									, &
						 "S"											, &
						 a_nr_nf										, &
						 "VENDA"										, &
						 lvs_Natureza_Operacao					, &
						 ls_nulo										, &
						 ls_cgc_ori									, &
						 ls_inscr_est_ori							, &
						 ls_razao_social							, &
						 ls_cgc_dest									, &
						 ls_endereco_dest							, &
						 ls_bairro_dest								, &
						 ls_cep_dest									, &
						 ls_municipio_dest							, &
						 ls_fone_dest								, &
						 ls_uf_dest									, &
						 ls_inscr_est_dest							, &
						 DateTime(ids_itens_nf.Object.dh_movimentacao_caixa[1])	, &
						 ld_nulo										, &
						 ld_nulo)

Imprimir_Calc_Imposto(ids_report_nf, &
							 ids_itens_nf.Object.vl_bc_icms			[1], &
							 ids_itens_nf.Object.vl_icms				[1], &
							 ids_itens_nf.Object.vl_bc_icms_st		[1], &
							 ids_itens_nf.Object.vl_icms_st			[1], &
							 ids_itens_nf.Object.vl_total_produtos	[1], &
							 ids_itens_nf.Object.vl_frete				[1], &
							 ldc_nulo, &
							 ids_itens_nf.Object.vl_outras_despesas[1], &
							 ldc_nulo, &
							 ids_itens_nf.Object.vl_total_nf			[1])

//Incui o valor pago a receber
ids_report_nf.Object.vl_pago_avista_t.text	 	= STRING( ldc_pago_avista 						, "#,###,##0.00" )
ids_report_nf.Object.valor_imp_total_nf_t.text	= STRING( ldc_total_nf - ldc_pago_avista 	, "#,###,##0.00" )

ll_quebra = 1

Inserir_Produto_Manipulado( "VE", a_filial_origem, a_nr_nf, a_especie, a_serie )

CHOOSE CASE ll_qt_mensagem_fiscal
	CASE 1
		ids_itens_nf.InsertRow(0)
	CASE 2
		ids_itens_nf.InsertRow(0)
		ids_itens_nf.InsertRow(0)
END CHOOSE

ll_max    = ids_itens_nf.RowCount()
lvi_Linha = 1

FOR ll_row = 1 TO ll_max
	
	If lvi_Linha = 1 Then
		lvi_Qt_Linhas_Nf = 7
	Else
		lvi_Qt_Linhas_Nf = 5
	End If
	
	IF MOD(ll_row, lvi_Qt_Linhas_Nf) = 0 AND ll_row <> ll_max THEN 
		
		ll_insert = ids_report_nf.InsertRow(0)
		ls_mensagem = "A TRANSPORTAR" //PARA A NOTA FISCAL " + STRING(a_nr_nf) + "/" + STRING(ll_quebra +1) + ": " + String(ldc_sum_total,"###,###,##0.00")
		ids_report_nf.Object.mensagem		[ll_insert] = ls_mensagem  
		ids_report_nf.Object.vl_sum_total[ll_insert] = ldc_sum_total
		ids_report_nf.Object.quebra	 	[ll_insert] = ll_quebra
		ll_linha += 1
		ids_report_nf.Object.linha	 		[ll_insert] = ll_linha
		
		ll_quebra += 1
		
		ll_insert = ids_report_nf.InsertRow(0)
		ls_mensagem = "DE TRANSPORTE"// DA NOTA FISCAL " + STRING(a_nr_nf) + "/" + STRING(ll_quebra -1) + ": " + String(ldc_sum_total,"###,###,##0.00")
		ids_report_nf.Object.mensagem	[ll_insert] = ls_mensagem
		ids_report_nf.Object.vl_sum_total	[ll_insert] = ldc_sum_total
		ids_report_nf.Object.quebra	 		[ll_insert] = ll_quebra
		ll_linha += 1
		ids_report_nf.Object.linha	 		[ll_insert] = ll_linha
			
		lvi_Linha = 2
		//ldc_sum_total  = 0
		
	END IF
		
	ldc_sum_total = ldc_sum_total + ids_itens_nf.Object.c_valor_total [ll_row]
	ll_linha 	 += 1
	
	Imprimir_Detalhe(ids_report_nf, &
						  ll_quebra															, &
						  ll_linha															, &	
						  ids_itens_nf.Object.cd_produto				 		[ll_row] , &
						  ids_itens_nf.Object.de_produto				 		[ll_row] , &
						  ids_itens_nf.Object.cd_natureza_operacao			[ll_row] , &
						  ids_itens_nf.Object.cd_situacao_tributaria			[ll_row] , &
						  ids_itens_nf.Object.cd_unidade_medida_venda	[ll_row] , &
						  ids_itens_nf.Object.qt_vendida						[ll_row]	, &
						  ids_itens_nf.Object.c_vl_unitario						[ll_row]	, &
						  ids_itens_nf.Object.c_pc_desc						[ll_row]	, &
						  ids_itens_nf.Object.c_valor_total			 			[ll_row]	, &
						  ids_itens_nf.Object.pc_icms					 		[ll_row])
										
END FOR

ll_max      = ids_report_nf.RowCount()
ll_mensagem = ll_max

// Insere linhas no detalhe at$$HEX1$$e900$$ENDHEX$$ completar 7
DO WHILE ll_max < (ll_quebra * 7) 
	ll_insert = ids_report_nf.InsertRow(0)
	ids_report_nf.Object.quebra[ll_insert] = ll_quebra
	ll_linha += 1
	ids_report_nf.Object.linha [ll_insert] = ll_linha
	ll_max += 1
LOOP

If ll_qt_mensagem_fiscal = 1 Then
	ll_insert = ll_mensagem
ElseIf ll_qt_mensagem_fiscal = 2 Then
	ll_insert = ll_mensagem - 1
End If

// Imprime Mensagem Fiscal
CHOOSE CASE ll_qt_mensagem_fiscal
	CASE 1
		ids_report_nf.Object.mensagem	[ll_insert    ] = ls_mensagem_fiscal_1 
	CASE 2
		ids_report_nf.Object.mensagem	[ll_insert    	] = ls_mensagem_fiscal_1 
	   ids_report_nf.Object.mensagem		[ll_insert + 1] = ls_mensagem_fiscal_2 
END CHOOSE

Imprimir_Ds(ids_report_nf)
end subroutine

public subroutine inserir_produto_manipulado (string a_tipo, long a_filial_origem, long a_nr_nf, string a_especie, string a_serie);//
LONG		ll_max		, ll_find	, ll_row	, ll_insert
STRING	ls_sit_trib	, ls_un		
DEC{2}	ld_pc_icms
//
ll_max = ids_produto_manip.Retrieve(a_filial_origem, a_nr_nf, a_especie, a_serie)
//
IF ll_max <= 0 THEN RETURN
//
ll_find = ids_itens_nf.Find("cd_produto = " + STRING(ids_produto_manip.Object.cd_produto[1]), 1, ids_itens_nf.RowCount()) 
IF ll_find > 0 THEN 
	//
	ls_sit_trib = ids_itens_nf.Object.cd_situacao_tributaria [ll_find]
	ls_un			= ids_itens_nf.Object.cd_unidade_medida_venda[ll_find]	
	ld_pc_icms	= ids_itens_nf.Object.pc_icms					  	[ll_find]	
	//
	ids_itens_nf.DeleteRow(ll_find)
	//
END IF
//
FOR ll_row = 1 TO ll_max
	//
	ll_insert = ids_itens_nf.InsertRow(0)
	//
	IF a_tipo = "VE" THEN
		ids_itens_nf.Object.pc_desconto_tabela  [ll_insert] = 0
		ids_itens_nf.Object.qt_vendida			 [ll_insert] = ids_produto_manip.Object.qt_registro[ll_row]
		ids_itens_nf.Object.vl_preco_unitario	 [ll_insert] = ids_produto_manip.Object.vl_registro[ll_row]
		ids_itens_nf.Object.vl_preco_praticado	 [ll_insert] = ids_produto_manip.Object.vl_registro[ll_row]		
	END IF
	//
	IF a_tipo = "DV" THEN
		ids_itens_nf.Object.qt_devolvida			 [ll_insert] = ids_produto_manip.Object.qt_registro[ll_row]
		ids_itens_nf.Object.vl_preco_unitario	 [ll_insert] = ids_produto_manip.Object.vl_registro[ll_row]
	END IF
	//
	IF a_tipo = "TR" THEN
		ids_itens_nf.Object.qt_transferida		 [ll_insert] = ids_produto_manip.Object.qt_registro[ll_row]
		ids_itens_nf.Object.vl_custo_unitario	 [ll_insert] = ids_produto_manip.Object.vl_registro[ll_row]
	END IF
	//
	ids_itens_nf.Object.cd_produto				 [ll_insert] = ids_produto_manip.Object.cd_produto[ll_row] 
	ids_itens_nf.Object.desc_produto				 [ll_insert] = "MANIPULA$$HEX2$$c700c300$$ENDHEX$$O"
	ids_itens_nf.Object.de_apresentacao_venda	 [ll_insert] = "REG. " + STRING(ids_produto_manip.Object.nr_registro[ll_row])
	ids_itens_nf.Object.cd_natureza_operacao	 [ll_insert] = ids_produto_manip.Object.cd_natureza_operacao[ll_row]
	ids_itens_nf.Object.cd_situacao_tributaria [ll_insert] = ls_sit_trib
	ids_itens_nf.Object.cd_unidade_medida_venda[ll_insert] = ls_un
	ids_itens_nf.Object.pc_icms					 [ll_insert] = ld_pc_icms
	//
END FOR
//
end subroutine

public subroutine imprimir_dados_adicionais (string ps_texto);//
String lvs_mensagem
//
If IsNull(ps_texto) Then ps_texto = ""
//
lvs_mensagem = ids_report_nf.Object.dados_adicionais_t.text
//
If Not IsNull(lvs_mensagem) AND lvs_mensagem <> "" THEN
	lvs_mensagem += "~r" + ps_texto
ELSE
	lvs_mensagem = ps_texto
END IF
//
ids_report_nf.Object.dados_adicionais_t.text = lvs_mensagem
//
end subroutine

public subroutine imprimir_dados_adicionais_transferencia ();//
String lvs_mensagem
//
If ids_itens_nf.Object.id_produto_vencido [1] = "S" Then
	If lvs_mensagem <> "" Then
		lvs_mensagem = ""
		Imprimir_dados_adicionais(lvs_mensagem)
	End If
	lvs_mensagem = "Obs: Produtos vencidos ou danificados."	
	Imprimir_dados_adicionais(lvs_mensagem)
End If
//
end subroutine

public function boolean selecionar_informacoes_devolucao_venda (long pl_nr_filial, long pl_nr_nf, string de_especie, string de_serie, ref long pl_cd_filial_venda, ref long pl_nr_nf_venda, ref string ps_de_especie_venda, ref string ps_serie_venda, ref datetime pdth_emissao_nf_venda, ref decimal pdc_total_nf_venda);select	cd_filial_venda 		  ,
       	nr_nf_venda     		  ,
		 	de_especie_venda	 	  ,
		 	de_serie_venda 		  ,
			dh_emissao_nf_venda    ,
			vl_total_nf_venda
  Into 	:pl_cd_filial_venda	  ,
  			:pl_nr_nf_venda		  ,
			:ps_de_especie_venda	  ,
			:ps_serie_venda        ,
			:pdth_emissao_nf_venda ,
			:pdc_total_nf_venda
	From nf_devolucao_venda
  Where cd_filial  = :pl_nr_filial
    and nr_nf      = :pl_nr_nf
	 and de_especie = :de_especie
 	 and de_serie   = :de_serie;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao consulta nf_devolucao_venda: " + SqlCa.SqlErrText + ".", &
					StopSign!,Ok!)
		Return False				
ElseIf SQLCA.SQLCode = 100 THEN
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nota fiscal n$$HEX1$$e300$$ENDHEX$$o encontrada.", StopSign!,Ok!)
	Return False
End If				
	  
Return True	  
end function

public function long of_insere_mensagem_fiscal (ref string ls_mensagem_fiscal_1, ref string ls_mensagem_fiscal_2);Long 	  lvl_cd_natureza_operacao , &
     	  lvl_linha_encontrada     , &
		  lvl_linha_inclusa			, &
   	  lvl_linha						, &
		  lvl_cd_mensagem_fiscal	, &
		  lvl_qt_mensagem_fiscal

String  lvs_mensagem_fiscal

FOR lvl_linha = 1 TO ids_itens_nf.RowCount()
	
	lvl_cd_natureza_operacao = ids_itens_nf.Object.cd_natureza_operacao[lvl_linha]
	
	// Verifica se j$$HEX1$$e100$$ENDHEX$$ foi cadastrada a mensagem fiscal na ids_mensagem fiscal
	lvl_linha_encontrada = ids_mensagem_fiscal.Find("cd_natureza_operacao = " + &
	                       String(lvl_cd_natureza_operacao), 1, ids_mensagem_fiscal.RowCount())	 
	
	If lvl_linha_encontrada = 0 Then
		
		// Verifica se a natureza de operacao possui mensagem fiscal
		SELECT mf.cd_mensagem_fiscal,   
      		 mf.de_mensagem_fiscal Into :lvl_cd_mensagem_fiscal, :lvs_mensagem_fiscal
		  FROM mensagem_fiscal mf,   
		       natureza_operacao no 
		 WHERE no.cd_mensagem_fiscal   = mf.cd_mensagem_fiscal 
		   and no.cd_natureza_operacao = :lvl_cd_natureza_operacao ;

		If SqlCa.SqlCode = -1 Then
			// Verifica se deu erro na consulta do sql
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na consulta da mensagem fiscal: " + &
			            SqlCa.SqlErrText + ".",StopSign!,Ok!)
		ElseIf SqlCa.SqlCode = 0 Then
			
			// Inclui a mensagem fiscal  na ids_mensagem_fiscal
			lvl_linha_inclusa = ids_mensagem_fiscal.InsertRow(0)
			
			ids_mensagem_fiscal.Object.cd_natureza_operacao[lvl_linha_inclusa] = lvl_cd_natureza_operacao
			ids_mensagem_fiscal.Object.cd_mensagem_fiscal  [lvl_linha_inclusa] = lvl_cd_mensagem_fiscal
			ids_mensagem_fiscal.Object.de_mensagem_fiscal  [lvl_linha_inclusa] = String(lvl_cd_natureza_operacao) + ":" + &
			                                                                     Trim(lvs_mensagem_fiscal) 
			
		End If
	
	ElseIf lvl_linha_encontrada < 0 Then	
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na consulta da ivs_mensagem_fiscal",StopSign!,Ok!)
		
	End If
		
	
NEXT

lvs_mensagem_fiscal    = ''
lvl_qt_mensagem_fiscal = 0

FOR lvl_linha = 1 TO ids_mensagem_fiscal.RowCount()
	
	lvs_mensagem_fiscal = lvs_mensagem_fiscal + ids_mensagem_fiscal.Object.de_mensagem_fiscal[lvl_linha] + ' '
	
NEXT

ls_mensagem_fiscal_1 = MidA(lvs_mensagem_fiscal,001,114)
ls_mensagem_fiscal_2 = MidA(lvs_mensagem_fiscal,115,228)

// Verifica se existe mensagem_fiscal
If trim(ls_mensagem_fiscal_2) <> '' and Not IsNull(ls_mensagem_fiscal_2)Then
	lvl_qt_mensagem_fiscal = 2
ElseIf trim(ls_mensagem_fiscal_1) <> '' and Not IsNull(ls_mensagem_fiscal_1)Then 
	lvl_qt_mensagem_fiscal = 1
Else
	lvl_qt_mensagem_fiscal = 0
End IF

// Retorna a quantidade de linhas que deve ter a mensagem (1 ou 2)
Return lvl_qt_mensagem_fiscal




end function

public function long of_localiza_codigo_fiscal (long pl_cd_filial, long pl_nr_nf, string ps_especie, string ps_serie, ref string ps_mensagem_fiscal, ref string ps_de_natureza_operacao);Long   lvl_cd_natureza_operacao

Select nf_diversa.cd_natureza_operacao,
       nf_diversa.de_natureza_operacao
Into :lvl_cd_natureza_operacao,
     :ps_de_natureza_operacao        
From nf_diversa  
Where nf_diversa.cd_filial_origem 	= :pl_cd_filial 
  and nf_diversa.nr_nf 		   		= :pl_nr_nf
  and nf_diversa.de_especie 			= :ps_especie
  and nf_diversa.de_serie 		   	= :ps_serie ;

If SqlCa.SqlCode = -1 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na consulta nf_diversa: " + SqlCa.SqlErrText + ".",&
	            StopSign!,Ok!)
ElseIf SqlCa.SqlCode = 100 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Esta nota fiscal n$$HEX1$$e300$$ENDHEX$$o possui natureza de operacao.",StopSign!,Ok!)
End If	

// Verifica se a natureza de operacao possui mensagem fiscal
SELECT mf.de_mensagem_fiscal Into :ps_mensagem_fiscal
  FROM mensagem_fiscal mf,   
		 natureza_operacao no 
 WHERE no.cd_mensagem_fiscal   = mf.cd_mensagem_fiscal 
	and no.cd_natureza_operacao = :lvl_cd_natureza_operacao ;

If SqlCa.SqlCode = -1 Then
	
	// Verifica se deu erro na consulta do sql
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na consulta da mensagem fiscal: " + &
					SqlCa.SqlErrText + ".",StopSign!,Ok!)
					
ElseIf SqlCa.SqlCode = 0 Then
	
	ps_mensagem_fiscal = String(lvl_cd_natureza_operacao) + ":" + Trim(ps_mensagem_fiscal) 
	
End If


// Verifica se existe mensagem_fiscal
If trim(ps_mensagem_fiscal) <> '' and Not IsNull(ps_mensagem_fiscal)Then
	Return 1
Else
	Return 0
End IF


end function

public function boolean of_verifica_cupom (long pl_filial, long pl_nota, string ps_especie, string ps_serie);Select nr_nf 
  Into :pl_nota
  From nf_venda
 Where cd_filial        = :pl_filial
   and nr_nf_anexa      = :pl_nota
	and de_especie_anexa = :ps_especie
	and de_serie_anexa   = :ps_serie
	and dh_cancelamento is null;

Choose Case SQLCA.SQLCode 
	Case -1 
		SQLCA.Of_MsgDbError()
		Return False
	Case 0
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","J$$HEX1$$e100$$ENDHEX$$ foi gerada uma nota fiscal deste cupom fiscal. N$$HEX1$$fa00$$ENDHEX$$mero da nota fiscal gerada : '"+String(pl_nota)+"'.", StopSign!)
		Return False
End Choose

Return True
end function

public subroutine of_emitir_nf_anexa (long pl_filial, long pl_nota, string ps_especie_cf, string ps_serie_cf, string ps_especie_nf, string ps_serie_nf);String ls_Null

SetNull( ls_Null )

This.of_emitir_nf_anexa( pl_filial, pl_nota, ps_especie_cf, ps_serie_cf, ps_especie_nf, ps_serie_nf, ls_Null )
end subroutine

public function string of_nf_anexa (long pl_filial, long pl_nr_nf, string ps_especie, string ps_serie);LONG   lvl_Nr_Anexa
STRING lvs_Especie_Anexa, lvs_Serie_Anexa, lvs_Nf_Anexa
//
lvs_Nf_Anexa = ""
//
Select nr_nf_anexa,
       de_especie_anexa,
		 de_serie_anexa
Into   :lvs_Nf_Anexa,
		 :lvs_Especie_Anexa,
		 :lvs_Serie_Anexa		
From nf_venda
where cd_filial  = :pl_filial
  and nr_nf      = :pl_nr_nf
  and de_especie = :ps_especie
  and de_serie   = :ps_serie;
//
IF SQLCA.Sqlcode = -1 THEN
	SQLCA.Of_MsgDbError("Dados nota fiscal anexa.")	
ELSEIF SQLCA.Sqlcode	= 0 THEN
	//
	IF NOT IsNull(lvs_Nf_Anexa) THEN
		lvs_Nf_Anexa = String(lvs_Nf_Anexa)+'/'+lvs_especie_anexa+'/'+lvs_serie_anexa
	END IF
	//
END IF
//
RETURN lvs_Nf_Anexa
end function

public subroutine imprimir_cabecalho_icms (string a_operador, string a_vendedor, string a_endereco_origem, string a_bairro_origem, string a_cidade_origem, string a_uf_origem, string a_fone_origem, string a_cep_origem, string a_saida_entrada, long a_nr_nf, string a_natureza_oper, string a_natureza_oper1, long a_cfop, string a_inscr_est_subst_trib, string a_cgc_origem, string a_inscr_est_origem, string a_razao_social_dest, string a_cgc_dest, string a_endereco_dest, string a_bairro_dest, string a_cep_dest, string a_municipio_dest, string a_fone_fax_dest, string a_uf_dest, string a_inscr_est_dest, datetime a_data_emissao, datetime a_data_saida_entr, datetime a_hora_saida);//
ids_report_nf.Object.operador_t					 .Text = a_operador
ids_report_nf.Object.vendedor_t					 .Text = a_vendedor
ids_report_nf.Object.endereco_origem_t			 .Text = a_endereco_origem
ids_report_nf.Object.bairro_cidade_uf_origem_t.Text = TRIM(a_bairro_origem) + " " + TRIM(a_cidade_origem) + "-" + TRIM(a_uf_origem)
ids_report_nf.Object.fone_cep_origem_t			 .Text = TRIM(a_fone_origem) + " CEP: " + TRIM(a_cep_origem)	

IF a_saida_entrada = "S" THEN
	ids_report_nf.Object.saida_t  .Visible = 1
	ids_report_nf.Object.entrada_t.Visible = 0
ELSEIF a_saida_entrada = "N" THEN
	ids_report_nf.Object.saida_t  .Visible = 0
	ids_report_nf.Object.entrada_t.Visible = 1
ELSE 
	ids_report_nf.Object.saida_t  .Visible = 0
	ids_report_nf.Object.entrada_t.Visible = 0
END IF	
	
ids_report_nf.Object.nr_nf_t						.Text = STRING(a_nr_nf)
ids_report_nf.Object.nr_nf_rodape_t				.Text = STRING(a_nr_nf)
ids_report_nf.Object.natureza_oper_t			.Text = a_natureza_oper
ids_report_nf.Object.natureza_oper1_t			.Text = a_natureza_oper1
ids_report_nf.Object.cfop_t						.Text = STRING(a_cfop)
ids_report_nf.Object.inscr_est_subst_trib_t	.Text = a_inscr_est_subst_trib
ids_report_nf.Object.cgc_origem_t				.Text = a_cgc_origem
ids_report_nf.Object.inscr_est_origem_t		.Text = a_inscr_est_origem
ids_report_nf.Object.razao_social_destino_t	.Text = a_razao_social_dest
ids_report_nf.Object.cgc_destino_t			 	.Text = a_cgc_dest
ids_report_nf.Object.endereco_destino_t		.Text = a_endereco_dest
ids_report_nf.Object.bairro_destino_t			.Text = a_bairro_dest
ids_report_nf.Object.cep_destino_t				.Text = a_cep_dest
ids_report_nf.Object.municipio_destino_t		.Text = a_municipio_dest
ids_report_nf.Object.fone_destino_t				.Text = a_fone_fax_dest
ids_report_nf.Object.uf_destino_t				.Text = a_uf_dest
ids_report_nf.Object.inscr_est_destino_t		.Text = a_inscr_est_dest
ids_report_nf.Object.data_emissao_t				.Text = STRING(a_data_emissao	  , "DD/MM/YYYY")
ids_report_nf.Object.data_saida_entrada_t		.Text = STRING(a_data_saida_entr, "DD/MM/YYYY")
ids_report_nf.Object.hora_saida_t				.Text = STRING(a_hora_saida	  , "HH:MM")	

end subroutine

public subroutine emitir_nf_devolucao_compra (long a_filial_origem, long a_nr_nf, string a_especie, string a_serie);// Controle para n$$HEX1$$e300$$ENDHEX$$o imprimir nota fiscal eletr$$HEX1$$f400$$ENDHEX$$nica
//If a_especie = 'NFE' Then Return

// Se for NFE vai mostrar a mensagem e retornar como falso
// N$$HEX1$$e300$$ENDHEX$$o vai imprimir a NFE
If Not This.of_Mensagem_Impressao_NFE(a_especie) Then
	Return
End If

//
OPEN(w_ge033_prepara_impressora)
//
LONG		ll_row		, ll_max				, ll_nulo			, ll_quebra		, ll_insert, ll_linha
LONG     lvl_cd_filial_compra           , lvl_nr_nf_compra , ll_nr_nsu
LONG     ll_qt_mensagem_fiscal, ll_mensagem
INTEGER  lvi_Linha, lvi_Qt_Linhas_Nf
STRING	ls_cgc_dest	, ls_endereco_dest, ls_bairro_dest	, ls_municipio_dest	 
STRING	ls_cgc_ori	, ls_endereco_ori	, ls_bairro_ori	, ls_municipio_ori	 
STRING	ls_fone_dest, ls_uf_dest		, ls_cep_dest		, ls_inscr_est_ori	 
STRING	ls_fone_ori	, ls_uf_ori			, ls_cep_ori		, ls_inscr_est_dest	
STRING	ls_fax		, ls_razao_social , ls_nulo			, ls_mensagem			, ls_aux
STRING   lvs_de_especie_compra         , lvs_de_serie_compra
STRING   ls_mensagem_fiscal_1          , ls_mensagem_fiscal_2
STRING   lvs_Id_Lista_Pis, lvs_Sinal_Impressao_Repassado
STRING   ls_dados_adicionais1 , ls_dados_adicionais2 , ls_dados_adicionais3
DATETIME	ld_nulo     , lvdth_emissao_nf_venda , ld_movimentacao_caixa , ld_emissao
DEC{2}	ldc_nulo		, ldc_sum_total   , lvdc_vl_total_nf_venda, lvdc_vl_outras_despesa
DEC{2}	ldc_vl_desconto, lvdc_Icms_Repassado

String lvs_Natureza_Operacao, &
       lvs_Motivo_Devolucao

of_Trocar_Ds("DC",a_serie)

ll_max = ids_itens_nf.Retrieve(a_filial_origem, a_nr_nf, a_especie, a_serie)

IF ll_max <= 0 THEN
	MESSAGEBOX("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Nota Fiscal " + STRING(a_nr_nf) + " n$$HEX1$$e300$$ENDHEX$$o cont$$HEX1$$e900$$ENDHEX$$m itens cadastrados.", StopSign!)
	RETURN
END IF

// Funcao que verifica se existe mensagem fiscal
ll_qt_mensagem_fiscal = of_insere_mensagem_fiscal(ls_mensagem_fiscal_1, &
																  ls_mensagem_fiscal_2)

SETNULL(ll_nulo)
SETNULL(ls_nulo)
SETNULL(ld_nulo)
SETNULL(ldc_nulo)

// Filial Origem
Selecionar_Informacoes_Filial(a_filial_origem		  , &
										ls_razao_social		  , &
										ls_cgc_ori				  , &
										ls_endereco_ori		  , &
										ls_bairro_ori			  , &
										ls_cep_ori				  , &
										ls_municipio_ori		  , &
										ls_fone_ori				  , &
										ls_fax					  	  , &	
										ls_uf_ori				  	  , &
										ls_inscr_est_ori)

	
Selecionar_Informacoes_fornecedor(ids_itens_nf.Object.cd_fornecedor[1], &
										    ls_razao_social		   				 , &
										    ls_cgc_dest				  				 , &
										    ls_endereco_dest		   				 , &
										    ls_bairro_dest			  				 , &
										    ls_cep_dest				  				 , &
										    ls_municipio_dest		  				 , &
										    ls_fone_dest								 , &
										    ls_uf_dest				   				 , &
										    ls_inscr_est_dest)
	

Selecionar_Informacoes_devolucao_compra( a_filial_origem		   , &
			                                a_nr_nf        		   , &
													  a_especie      		   , &
													  a_serie        		   , &
													  lvl_cd_filial_compra	, &
													  lvl_nr_nf_compra      , &
													  lvs_de_especie_compra , &
													  lvs_de_serie_compra   , &
													  ld_movimentacao_caixa , &
													  ld_emissao            , &
													  ll_nr_nsu)

Imprimir_Dados_Adicionais("Dev. NF " + String(lvl_nr_nf_compra) 	 + " " + &
                                              lvs_de_especie_compra + " " + &
													       lvs_de_serie_compra)

Imprimir_Dados_Adicionais("Filial: " + String(lvl_cd_filial_compra,"0000"))

// Verifica o motivo da devolu$$HEX2$$e700e300$$ENDHEX$$o para impress$$HEX1$$e300$$ENDHEX$$o
lvs_Motivo_Devolucao = Trim(ids_Itens_NF.Object.De_Motivo_Devolucao[1])

If IsNull(lvs_Motivo_Devolucao) Then lvs_Motivo_Devolucao = ""

If lvs_Motivo_Devolucao <> "" Then
	Imprimir_Dados_Adicionais("~rMotivo Devolu$$HEX2$$e700e300$$ENDHEX$$o")
	
	Imprimir_Dados_Adicionais(LeftA(lvs_Motivo_Devolucao, 20))
	
	If LenA(lvs_Motivo_Devolucao) > 20 Then
		Imprimir_Dados_Adicionais(MidA(lvs_Motivo_Devolucao, 21))
	End If
End If
//Dados adicionais NSU
If ld_movimentacao_caixa >= datetime(date("2007/07/01")) Then
	ls_dados_adicionais1 = ''
	ls_dados_adicionais2 = 'NSU: '+string(ll_nr_nsu)+' em'
	ls_dados_adicionais3 = string(ld_emissao,'dd/mm/yyyy hh:mm')
	Imprimir_Dados_Adicionais(ls_dados_adicionais1)
	Imprimir_Dados_Adicionais(ls_dados_adicionais2)
	Imprimir_Dados_Adicionais(ls_dados_adicionais3)
End If

This.of_Prepara_Natureza_Operacao(ref lvs_Natureza_Operacao)

Imprimir_Cabecalho(ids_report_nf, &
                   "Operador: " + ids_itens_nf.Object.nr_matricula_operador[1], &
						 ""											, &
						 ls_endereco_ori							, &
						 ls_bairro_ori								, &
						 ls_municipio_ori							, &
						 ls_uf_ori									, &
						 ls_fone_ori								, &
						 ls_cep_ori									, &
						 "S"											, &
						 a_nr_nf										, &
						 "DEVOLU$$HEX2$$c700c300$$ENDHEX$$O COMPRA"						, &
						 lvs_Natureza_Operacao,  &
						 ls_nulo										, &
						 ls_cgc_ori									, &
						 ls_inscr_est_ori							, &
						 ls_razao_social							, &
						 ls_cgc_dest								, &
						 ls_endereco_dest							, &
						 ls_bairro_dest							, &
						 ls_cep_dest								, &
						 ls_municipio_dest						, &
						 ls_fone_dest								, &
						 ls_uf_dest									, &
						 ls_inscr_est_dest						, &
						 ld_movimentacao_caixa           	, &
						 ld_nulo										, &
						 ld_nulo)

ldc_vl_desconto        = ids_itens_nf.Object.vl_desconto       [1] 
lvdc_vl_outras_despesa = ids_itens_nf.Object.vl_outras_despesas[1] + &
								 ids_itens_nf.Object.vl_indenizacao    [1] 

Imprimir_Calc_Imposto(ids_report_nf, &
                      ids_itens_nf.Object.vl_bc_icms			[1], &
							 ids_itens_nf.Object.vl_icms				[1], &
							 ids_itens_nf.Object.vl_bc_icms_st		[1], &
							 ids_itens_nf.Object.vl_icms_st			[1], &
							 ids_itens_nf.Object.vl_total_produtos	[1], &
							 ids_itens_nf.Object.vl_frete				[1], &
							 ids_itens_nf.Object.vl_seguro			[1], &
							 lvdc_vl_outras_despesa							, &
							 ids_itens_nf.Object.vl_ipi				[1], &
							 ids_itens_nf.Object.vl_total_nf			[1])

ll_quebra = 1

//Inserir_Produto_Manipulado("DV", a_filial_origem, a_nr_nf, a_especie, a_serie)

CHOOSE CASE ll_qt_mensagem_fiscal
	CASE 1
		ids_itens_nf.InsertRow(0)
	CASE 2
		ids_itens_nf.InsertRow(0)
		ids_itens_nf.InsertRow(0)
END CHOOSE

ll_max    = ids_itens_nf.RowCount()
lvi_Linha = 1

FOR ll_row = 1 TO ll_max
	
	If lvi_Linha = 1 Then
		lvi_Qt_Linhas_Nf = 7
	Else
		lvi_Qt_Linhas_Nf = 5
	End If
	
	IF MOD(ll_row, lvi_Qt_Linhas_Nf) = 0 THEN 
		
		ll_insert = ids_report_nf.InsertRow(0)
		ls_mensagem = "A TRANSPORTAR "//PARA A NOTA FISCAL " + STRING(a_nr_nf) + "/" + STRING(ll_quebra +1) + ": " + String(ldc_sum_total,"###,###,##0.00")
		ids_report_nf.Object.mensagem		[ll_insert] = ls_mensagem  
		ids_report_nf.Object.vl_sum_total[ll_insert] = ldc_sum_total
		ids_report_nf.Object.quebra	 	[ll_insert] = ll_quebra
		ll_linha += 1
		ids_report_nf.Object.linha	 		[ll_insert] = ll_linha
		
		ll_quebra += 1
		
		ll_insert = ids_report_nf.InsertRow(0)
		ls_mensagem = "DE TRANSPORTE "// DA NOTA FISCAL " + STRING(a_nr_nf) + "/" + STRING(ll_quebra -1) + ": " + String(ldc_sum_total,"###,###,##0.00")
		ids_report_nf.Object.mensagem		[ll_insert] = ls_mensagem
		ids_report_nf.Object.vl_sum_total[ll_insert] = ldc_sum_total
		ids_report_nf.Object.quebra	 	[ll_insert] = ll_quebra
		ll_linha += 1
		ids_report_nf.Object.linha	 		[ll_insert] = ll_linha
		
		lvi_Linha = 2
		//ldc_sum_total  = 0
		
	END IF
		
	ldc_sum_total = ldc_sum_total + ids_itens_nf.Object.c_valor_total [ll_row]
	ll_linha 	 += 1
	
	If ids_itens_nf.Object.id_lista_pis_cofins[ll_row] = "P" Then
		lvs_Id_Lista_Pis = "+"
	ElseIf ids_itens_nf.Object.id_lista_pis_cofins[ll_row] = "N" Then
		lvs_Id_Lista_Pis = "-"
	Else
		lvs_Id_Lista_Pis = ""
	End If
	
	If ids_itens_nf.Object.item_vl_icms_repassado  [ll_row] > 0 Then
		lvs_Sinal_Impressao_Repassado = "*"
	Else
		lvs_Sinal_Impressao_Repassado = ""
	End If
	
	Imprimir_Detalhe_Dev_Compra(ids_report_nf, &
	                            ll_quebra															, &
            			    		 ll_linha												   		, &	
						  		   	 ids_itens_nf.Object.cd_produto				 	[ll_row] , &
						  			    ids_itens_nf.Object.desc_produto				[ll_row] , &
						  			    ids_itens_nf.Object.cd_natureza_operacao	   [ll_row] , &
						  			    ids_itens_nf.Object.cd_situacao_tributaria	[ll_row] , &
						  			    ids_itens_nf.Object.cd_unidade_medida_compra[ll_row] , &
						  			    ids_itens_nf.Object.qt_devolvida				[ll_row] , &
						  			    ids_itens_nf.Object.vl_preco_unitario		   [ll_row] , &
						  			    ids_itens_nf.Object.pc_desconto				   [ll_row] , &
						  			    ids_itens_nf.Object.c_valor_total			 	[ll_row] , &
						  			    ids_itens_nf.Object.pc_icms					 	[ll_row] , &
						  			    lvs_Id_Lista_Pis                                     , &
						  			    lvs_Sinal_Impressao_Repassado)
	
  lvdc_Icms_Repassado = ids_itens_nf.Object.vl_icms_repassado[ll_row]
						 
										
END FOR

ll_max      = ids_report_nf.RowCount()
ll_mensagem = ll_max

ll_insert = ids_report_nf.InsertRow(0)

If ldc_vl_desconto > 0 Then
	ls_mensagem = "DESCONTO NA NOTA FISCAL DE : " + STRING(ldc_vl_desconto, "###,###,##0.00")
Else	
	ls_mensagem = ''
End If

ids_report_nf.Object.mensagem		[ll_insert] = ls_mensagem  
ids_report_nf.Object.quebra	 	[ll_insert] = ll_quebra
ll_linha += 1
ids_report_nf.Object.linha	 		[ll_insert] = ll_linha

ll_max = ids_report_nf.RowCount()

// Insere linhas no detalhe at$$HEX1$$e900$$ENDHEX$$ completar 7.
DO WHILE ll_max < (ll_quebra * 7) 
	ll_insert = ids_report_nf.InsertRow(0)
	ids_report_nf.Object.quebra[ll_insert] = ll_quebra
	ll_linha += 1
	ids_report_nf.Object.linha [ll_insert] = ll_linha
	ll_max += 1
LOOP                                                                                                                                                                                                                                                                                                                                                                                             

If ll_qt_mensagem_fiscal = 1 Then
	
	ll_insert = ll_mensagem
	
ElseIf ll_qt_mensagem_fiscal = 2 Then
	
	ll_insert = ll_mensagem - 1
	
End If

// Imprime Mensagem Fiscal

CHOOSE CASE ll_qt_mensagem_fiscal
	CASE 1
		ids_report_nf.Object.mensagem[ll_insert    ] = ls_mensagem_fiscal_1 
	CASE 2
		ids_report_nf.Object.mensagem[ll_insert    ] = ls_mensagem_fiscal_1 
	   ids_report_nf.Object.mensagem[ll_insert + 1] = ls_mensagem_fiscal_2 
END CHOOSE

If lvdc_Icms_Repassado > 0.00 Then
	ids_report_nf.Modify('de_icms_repassado.Visible = 1')
	ids_report_nf.Modify('de_icms_repassado.X = 207')
	ids_report_nf.Modify('de_icms_repassado.Width = 132')
	ids_report_nf.Object.de_icms_repassado[ids_report_nf.RowCount()] = 'ICMS Repassado: ' + String(lvdc_Icms_Repassado)
Else
	ids_report_nf.Modify('de_icms_repassado.Visible = 0')
End If

Imprimir_Ds(ids_report_nf)
end subroutine

public function boolean selecionar_informacoes_fornecedor (string a_fornecedor, ref string a_razao_social, ref string a_cgc, ref string a_endereco, ref string a_bairro, ref string a_cep, ref string a_municipio, ref string a_fone, ref string a_uf, ref string a_inscr_est);//
UO_CLIENTE	luo_cliente
STRING		ls_nome		, ls_id, ls_fone
//
SELECT fornecedor.nm_fantasia,   
		 fornecedor.nr_ddd_telefone + nr_telefone	,
       cidade.cd_unidade_federacao,   
       cidade.nm_cidade,  
		 fornecedor.de_endereco,   
		 fornecedor.de_bairro,   
		 fornecedor.nr_cep,
 		 fornecedor.nm_razao_social,
		 fornecedor.nr_cgc,
		 fornecedor.nr_inscricao_estadual
INTO   :ls_nome,   
		 :ls_fone,
		 :a_uf,   
		 :a_municipio,   
		 :a_endereco,   
		 :a_bairro,
		 :a_cep,
		 :a_razao_social,   
		 :a_cgc,   
		 :a_inscr_est  
FROM 	 fornecedor,   
		 cidade
WHERE  cidade.cd_cidade         = fornecedor.cd_cidade  and  
		 fornecedor.cd_fornecedor = :a_fornecedor			  
USING  SQLCA;
//
IF SQLCA.SQLCode = -1 THEN
	MESSAGEBOX("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro: " + SQLCA.SQLErrText, StopSign!)
	RETURN FALSE
END IF
//
IF SQLCA.SQLCode <> 0 THEN
	MESSAGEBOX("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informa$$HEX2$$e700f500$$ENDHEX$$es do fornecedor " + TRIM(a_fornecedor) + " n$$HEX1$$e300$$ENDHEX$$o cadastradas.", StopSign!)
	RETURN FALSE
END IF
//
a_fone = "(" + MidA(ls_fone, 1, 3) + ")" + MidA(ls_fone, 4, 3) + "-" + MidA(ls_fone, 7, 4)
//
a_cgc = Gf_Colocar_Mascara_CGC(a_cgc)
//
RETURN TRUE
//
end function

public subroutine emitir_nf_devolucao_compra_central (long a_filial_origem, long a_nr_nf, string a_especie, string a_serie);// Controle para n$$HEX1$$e300$$ENDHEX$$o imprimir nota fiscal eletr$$HEX1$$f400$$ENDHEX$$nica
If a_especie = 'NFE' Then Return
//
OPEN(w_ge033_prepara_impressora)
//
LONG		ll_row, ll_max, ll_nulo, ll_quebra, ll_insert, ll_linha, lvl_cd_filial_compra, lvl_nr_nf_compra
LONG     ll_qt_mensagem_fiscal, ll_mensagem, ll_nr_nsu

INTEGER  lvi_Linha, lvi_Qt_Linhas_Nf

STRING	ls_cgc_dest	, ls_endereco_dest, ls_bairro_dest	, ls_municipio_dest	 
STRING	ls_cgc_ori	, ls_endereco_ori	, ls_bairro_ori	, ls_municipio_ori	 
STRING	ls_fone_dest, ls_uf_dest		, ls_cep_dest		, ls_inscr_est_ori	 
STRING	ls_fone_ori	, ls_uf_ori			, ls_cep_ori		, ls_inscr_est_dest	
STRING	ls_fax		, ls_razao_social , ls_nulo			, ls_mensagem			, ls_aux
STRING   lvs_de_especie_compra         , lvs_de_serie_compra
STRING   ls_mensagem_fiscal_1          , ls_mensagem_fiscal_2 , ls_dados_adicionais 

DATETIME	ld_nulo     , lvdth_emissao_nf_venda  , ld_emissao , ld_movimentacao_caixa

DEC{2}	ldc_nulo		, ldc_sum_total   , lvdc_vl_total_nf_venda, lvdc_vl_outras_despesa
DEC{2}	ldc_vl_desconto, lvdc_Icms_Repassado

of_Trocar_Ds("DC",a_serie)

ll_max = ids_itens_nf.Retrieve(a_filial_origem, a_nr_nf, a_especie, a_serie)

IF ll_max <= 0 THEN
	MESSAGEBOX("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Nota Fiscal " + STRING(a_nr_nf) + " n$$HEX1$$e300$$ENDHEX$$o cont$$HEX1$$e900$$ENDHEX$$m itens cadastrados.", StopSign!)
	RETURN
END IF

// Funcao que verifica se existe mensagem fiscal
ll_qt_mensagem_fiscal = of_insere_mensagem_fiscal(ls_mensagem_fiscal_1, &
																  ls_mensagem_fiscal_2)

SETNULL(ll_nulo)
SETNULL(ls_nulo)
SETNULL(ld_nulo)
SETNULL(ldc_nulo)

// Filial Origem
Selecionar_Informacoes_Filial(a_filial_origem		  , &
										ls_razao_social		  , &
										ls_cgc_ori				  , &
										ls_endereco_ori		  , &
										ls_bairro_ori			  , &
										ls_cep_ori				  , &
										ls_municipio_ori		  , &
										ls_fone_ori				  , &
										ls_fax					  , &	
										ls_uf_ori				  , &
										ls_inscr_est_ori)

	
Selecionar_Informacoes_fornecedor(ids_itens_nf.Object.cd_fornecedor[1], &
										    ls_razao_social		   				 , &
										    ls_cgc_dest				  				 , &
										    ls_endereco_dest		   				 , &
										    ls_bairro_dest			  				 , &
										    ls_cep_dest				  				 , &
										    ls_municipio_dest		  				 , &
										    ls_fone_dest								 , &
										    ls_uf_dest				   				 , &
										    ls_inscr_est_dest)
	

Selecionar_Informacoes_devolucao_compra( a_filial_origem		   , &
			                                a_nr_nf        		   , &
													  a_especie      		   , &
													  a_serie        		   , &
													  lvl_cd_filial_compra	, &
													  lvl_nr_nf_compra      , &
													  lvs_de_especie_compra , &
													  lvs_de_serie_compra   , &
													  ld_movimentacao_caixa , &
													  ld_emissao            , &
													  ll_nr_nsu)

imprimir_cabecalho(ids_report_nf, &
						 "Operador: " + ids_itens_nf.Object.nr_matricula_operador[1], &
						 ""											, &
						 ls_endereco_ori							, &
						 ls_bairro_ori								, &
						 ls_municipio_ori							, &
						 ls_uf_ori									, &
						 ls_fone_ori								, &
						 ls_cep_ori									, &
						 "S"											, &
						 a_nr_nf										, &
						 "DEVOLU$$HEX2$$c700c300$$ENDHEX$$O COMPRA"						, &
						 ls_nulo										, &
						 ls_nulo										, &
						 ls_cgc_ori									, &
						 ls_inscr_est_ori							, &
						 ls_razao_social							, &
						 ls_cgc_dest								, &
						 ls_endereco_dest							, &
						 ls_bairro_dest							, &
						 ls_cep_dest								, &
						 ls_municipio_dest						, &
						 ls_fone_dest								, &
						 ls_uf_dest									, &
						 ls_inscr_est_dest						, &
						 ld_movimentacao_caixa           	, &
						 ld_nulo										, &
						 ld_nulo)

ldc_vl_desconto        = ids_itens_nf.Object.vl_desconto       [1] 
lvdc_vl_outras_despesa = ids_itens_nf.Object.vl_outras_despesas[1] + &
								 ids_itens_nf.Object.vl_indenizacao    [1] 

imprimir_calc_imposto(ids_report_nf, &
							 ids_itens_nf.Object.vl_bc_icms			[1], &
							 ids_itens_nf.Object.vl_icms				[1], &
							 ids_itens_nf.Object.vl_bc_icms_st		[1], &
							 ids_itens_nf.Object.vl_icms_st			[1], &
							 ids_itens_nf.Object.vl_total_produtos	[1], &
							 ids_itens_nf.Object.vl_frete				[1], &
							 ids_itens_nf.Object.vl_seguro			[1], &
							 lvdc_vl_outras_despesa							, &
							 ids_itens_nf.Object.vl_ipi				[1], &
							 ids_itens_nf.Object.vl_total_nf			[1])

ll_quebra = 1

//Dados adicionais NSU
If ld_movimentacao_caixa >= datetime(date("2007/11/01")) Then
	ls_dados_adicionais = 'NSU: '+string(ll_nr_nsu)+' em '+string(ld_emissao,'dd/mm/yyyy hh:mm')
	Imprimir_Dados_Adicionais(ls_dados_adicionais)
End If
//Inserir_Produto_Manipulado("DV", a_filial_origem, a_nr_nf, a_especie, a_serie)

CHOOSE CASE ll_qt_mensagem_fiscal
	CASE 1
		ids_itens_nf.InsertRow(0)
	CASE 2
		ids_itens_nf.InsertRow(0)
		ids_itens_nf.InsertRow(0)
END CHOOSE

ll_max    = ids_itens_nf.RowCount()
lvi_Linha = 1

FOR ll_row = 1 TO ll_max
	
	If lvi_Linha = 1 Then
		lvi_Qt_Linhas_Nf = 19
	Else
		lvi_Qt_Linhas_Nf = 17
	End If
	
	IF MOD(ll_row, lvi_Qt_Linhas_Nf) = 0 THEN 
		
		ll_insert = ids_report_nf.InsertRow(0)
		
		ls_mensagem = "A TRANSPORTAR PARA A NOTA FISCAL " + STRING(a_nr_nf) + "/" + STRING(ll_quebra +1) + ": " + String(ldc_sum_total,"###,###,##0.00")
		ids_report_nf.Object.mensagem	 [ll_insert] = ls_mensagem  
		ids_report_nf.Object.vl_sum_total[ll_insert] = ldc_sum_total
		ids_report_nf.Object.quebra	 	 [ll_insert] = ll_quebra
		ll_linha += 1                     
		ids_report_nf.Object.linha		 [ll_insert] = ll_linha
		
		ll_quebra += 1
		
		ll_insert = ids_report_nf.InsertRow(0)
		ls_mensagem = "DE TRANSPORTE DA NOTA FISCAL " + STRING(a_nr_nf) + "/" + STRING(ll_quebra -1) + ": " + String(ldc_sum_total,"###,###,##0.00")
		ids_report_nf.Object.mensagem		[ll_insert] = ls_mensagem
		ids_report_nf.Object.vl_sum_total  [ll_insert] = ldc_sum_total
		ids_report_nf.Object.quebra	 	   [ll_insert] = ll_quebra
		ll_linha += 1 
		ids_report_nf.Object.linha	 		[ll_insert] = ll_linha
		
		lvi_Linha = 2
		//ldc_sum_total  = 0
		
	END IF
		
	ldc_sum_total = ldc_sum_total + ids_itens_nf.Object.c_valor_total [ll_row]
	ll_linha 	 += 1
	
	imprimir_detalhe(ids_report_nf, &
						  ll_quebra															 , &
						  ll_linha															 , &	
						  ids_itens_nf.Object.cd_produto				 	 [ll_row] , &
						  ids_itens_nf.Object.desc_produto				 [ll_row] , &
						  ids_itens_nf.Object.cd_natureza_operacao	 [ll_row] , &
						  ids_itens_nf.Object.cd_situacao_tributaria	 [ll_row] , &
						  ids_itens_nf.Object.cd_unidade_medida_compra[ll_row] , &
						  ids_itens_nf.Object.qt_devolvida				 [ll_row] , &
						  ids_itens_nf.Object.vl_preco_unitario		 [ll_row] , &
						  ids_itens_nf.Object.pc_desconto				 [ll_row] , &
						  ids_itens_nf.Object.c_valor_total			 	 [ll_row] , &
						  ids_itens_nf.Object.pc_icms					 	 [ll_row])
	
	lvdc_Icms_Repassado = ids_itens_nf.Object.vl_icms_repassado[ll_row]						 
										
END FOR

ll_max      = ids_report_nf.RowCount()
ll_mensagem = ll_max

ll_insert = ids_report_nf.InsertRow(0)
//

If ldc_vl_desconto > 0 Then
	ls_mensagem = "DESCONTO NA NOTA FISCAL DE : " + STRING(ldc_vl_desconto, "###,###,##0.00")
Else	
	ls_mensagem = ''
End If
//
ids_report_nf.Object.mensagem	[ll_insert] = ls_mensagem  
ids_report_nf.Object.quebra	 	[ll_insert] = ll_quebra
ll_linha += 1
ids_report_nf.Object.linha	 	[ll_insert] = ll_linha

ll_max = ids_report_nf.RowCount()

// Insere linhas no detalhe at$$HEX1$$e900$$ENDHEX$$ completar 19.
DO WHILE ll_max < (ll_quebra * 19) 
	ll_insert = ids_report_nf.InsertRow(0)
	ids_report_nf.Object.quebra[ll_insert] = ll_quebra
	ll_linha += 1
	ids_report_nf.Object.linha [ll_insert] = ll_linha
	ll_max += 1
LOOP                                                                                                                                                                                                                                                                                                                                                                                             

If ll_qt_mensagem_fiscal = 1 Then
	
	ll_insert = ll_mensagem
	
ElseIf ll_qt_mensagem_fiscal = 2 Then
	
	ll_insert = ll_mensagem - 1
	
End If

// Imprime Mensagem Fiscal

CHOOSE CASE ll_qt_mensagem_fiscal
	CASE 1
		ids_report_nf.Object.mensagem[ll_insert    ] = ls_mensagem_fiscal_1 
	CASE 2
		ids_report_nf.Object.mensagem[ll_insert    ] = ls_mensagem_fiscal_1 
	   ids_report_nf.Object.mensagem[ll_insert + 1] = ls_mensagem_fiscal_2 
END CHOOSE

If lvdc_Icms_Repassado > 0.00 Then
	ids_report_nf.Object.icms_repassado_t.Text = 'ICMS Repassado: ' + String(lvdc_Icms_Repassado, "#,###,##0.00")
End If

Imprimir_Ds(ids_report_nf)
end subroutine

public subroutine imprimir_calc_imposto (datastore ids_report, decimal a_base_calc_icms, decimal a_valor_icms, decimal a_base_calc_icms_subst, decimal a_valor_icms_subst, decimal a_valor_total_produto, decimal a_valor_frete, decimal a_valor_seguro, decimal a_outras_desp_acess, decimal a_valor_total_ipi, decimal a_valor_total_nota);//
ids_report.Object.base_calc_icms_t.Text 			= STRING(a_base_calc_icms		 	, "#,###,##0.00")	
ids_report.Object.valor_icms_t.Text 					= STRING(a_valor_icms			 		, "#,###,##0.00")	
ids_report.Object.base_calc_icms_subst_t.Text 	= STRING(a_base_calc_icms_subst 	, "#,###,##0.00")	
ids_report.Object.valor_icms_subst_t.Text			= STRING(a_valor_icms_subst	 	 , "#,###,##0.00")	
ids_report.Object.vl_imp_total_produtos_t.Text	 	= STRING(a_valor_total_produto 	 , "#,###,##0.00")		
ids_report.Object.valor_frete_t.Text 					= STRING(a_valor_frete			 	 , "#,###,##0.00")	
ids_report.Object.valor_seguro_t.Text 				= STRING(a_valor_seguro			 , "#,###,##0.00")	
ids_report.Object.outras_desp_acess_t.Text 		= STRING(a_outras_desp_acess	 , "#,###,##0.00")	
ids_report.Object.valor_total_ipi_t.Text 				= STRING(a_valor_total_ipi		 	 , "#,###,##0.00")	
ids_report.Object.valor_imp_total_nf_t.Text 		= STRING(a_valor_total_nota	 	 , "#,###,##0.00")	
//
end subroutine

public subroutine imprimir_detalhe (datastore ids_report, long a_quebra, long a_linha, long a_cd_produto, string a_de_produto, long a_natureza_oper, string a_cst_produto, string a_unid_produto, long a_qt_produto, decimal a_vl_unit_produto, decimal a_pc_desc_produto, decimal a_vl_total_produto, integer a_aliq_icms);/*		 Testar no in$$HEX1$$ed00$$ENDHEX$$cio do la$$HEX1$$e700$$ENDHEX$$o de inser$$HEX2$$e700e300$$ENDHEX$$o se o MOD(linha_inserida, 12) = 0, 
		 	ent$$HEX1$$e300$$ENDHEX$$o incrementar a variavel de QUEBRA.
		 Cada nota deve conter 12 linhas. Caso contr$$HEX1$$e100$$ENDHEX$$rio, dar insert at$$HEX1$$e900$$ENDHEX$$ completar as 12 linhas
		 	passando a quebra e linha (ordena$$HEX2$$e700e300$$ENDHEX$$o).
		 Campo linha serve para a ordena$$HEX2$$e700e300$$ENDHEX$$o. Deve ser incrementado a cada novo insert.	 
*/
//
LONG	ll_insert
//
ll_insert = ids_report.InsertRow(0)
//
ids_report.Object.quebra				[ll_insert] = a_quebra
ids_report.Object.linha					[ll_insert] = a_linha
ids_report.Object.cd_produto			[ll_insert] = a_cd_produto
ids_report.Object.de_produto			[ll_insert] = a_de_produto
ids_report.Object.nat_oper_produto	[ll_insert] = a_natureza_oper
ids_report.Object.cst_produto			[ll_insert] = a_cst_produto
ids_report.Object.unid_produto		[ll_insert] = a_unid_produto
ids_report.Object.qt_produto			[ll_insert] = a_qt_produto
ids_report.Object.vl_unit_produto	[ll_insert] = a_vl_unit_produto
// Mostra o percentual de desconto se o produto n$$HEX1$$e300$$ENDHEX$$o for nulo
If Not IsNull(a_cd_produto) Then
	ids_report.Object.pc_desc_produto	[ll_insert] = a_pc_desc_produto
End If
ids_report.Object.vl_total_produto	[ll_insert] = a_vl_total_produto
ids_report.Object.aliq_icms_produto	[ll_insert] = a_aliq_icms
//
end subroutine

public subroutine imprimir_ds (datastore ids_report);//
ids_report.SetSort("quebra a, linha a")
ids_report.Sort()
ids_report.GroupCalc()
ids_report.Print()
//

end subroutine

public subroutine imprimir_detalhe_dev_compra (datastore ids_report, long a_quebra, long a_linha, long a_cd_produto, string a_de_produto, long a_natureza_oper, string a_cst_produto, string a_unid_produto, long a_qt_produto, decimal a_vl_unit_produto, decimal a_pc_desc_produto, decimal a_vl_total_produto, integer a_aliq_icms, string a_lista_pis_cofins, string a_icms_repassado);/*		 Testar no in$$HEX1$$ed00$$ENDHEX$$cio do la$$HEX1$$e700$$ENDHEX$$o de inser$$HEX2$$e700e300$$ENDHEX$$o se o MOD(linha_inserida, 12) = 0, 
		 	ent$$HEX1$$e300$$ENDHEX$$o incrementar a variavel de QUEBRA.
		 Cada nota deve conter 12 linhas. Caso contr$$HEX1$$e100$$ENDHEX$$rio, dar insert at$$HEX1$$e900$$ENDHEX$$ completar as 12 linhas
		 	passando a quebra e linha (ordena$$HEX2$$e700e300$$ENDHEX$$o).
		 Campo linha serve para a ordena$$HEX2$$e700e300$$ENDHEX$$o. Deve ser incrementado a cada novo insert.	 
*/
//
LONG	ll_insert
//
ll_insert = ids_report.InsertRow(0)
//
ids_report.Object.quebra				    [ll_insert] = a_quebra
ids_report.Object.linha					    [ll_insert] = a_linha
ids_report.Object.cd_produto			    [ll_insert] = a_cd_produto
ids_report.Object.de_produto			    [ll_insert] = a_de_produto
ids_report.Object.nat_oper_produto	    [ll_insert] = a_natureza_oper
ids_report.Object.cst_produto			    [ll_insert] = a_cst_produto
ids_report.Object.unid_produto		    [ll_insert] = a_unid_produto
ids_report.Object.qt_produto			    [ll_insert] = a_qt_produto
ids_report.Object.vl_unit_produto	    [ll_insert] = a_vl_unit_produto
ids_report.Object.pis_cofins            [ll_insert] = a_lista_pis_cofins
ids_report.Object.icms_repassado        [ll_insert] = a_icms_repassado

// Mostra o percentual de desconto se o produto n$$HEX1$$e300$$ENDHEX$$o for nulo
If Not IsNull(a_cd_produto) Then
	ids_report.Object.pc_desc_produto	[ll_insert] = a_pc_desc_produto
End If
ids_report.Object.vl_total_produto	[ll_insert] = a_vl_total_produto
ids_report.Object.aliq_icms_produto	[ll_insert] = a_aliq_icms
//
end subroutine

public subroutine emitir_nf_diversa (long a_filial_origem, long a_nr_nf, string a_especie, string a_serie);// Controle para n$$HEX1$$e300$$ENDHEX$$o imprimir nota fiscal eletr$$HEX1$$f400$$ENDHEX$$nica
//If a_especie = 'NFE' Then Return

// Se for NFE vai mostrar a mensagem e retornar como falso
// N$$HEX1$$e300$$ENDHEX$$o vai imprimir a NFE
If Not This.of_Mensagem_Impressao_NFE(a_especie) Then
	Return
End If

OPEN(w_ge033_prepara_impressora)

LONG		ll_row		, ll_max				, ll_nulo			, ll_quebra		, ll_insert, ll_linha
LONG     ll_cd_natureza_operacao       , ll_nr_nsu
LONG     ll_qt_mensagem_fiscal, ll_mensagem
INTEGER  lvi_Linha, lvi_Qt_Linhas_NF
STRING   ls_matricula, lvs_de_natureza_operacao
STRING	ls_cgc_dest	, ls_endereco_dest, ls_bairro_dest	, ls_municipio_dest	 
STRING	ls_cgc_ori	, ls_endereco_ori	, ls_bairro_ori	, ls_municipio_ori	 
STRING	ls_fone_dest, ls_uf_dest		, ls_cep_dest		, ls_inscr_est_ori	 
STRING	ls_fone_ori	, ls_uf_ori			, ls_cep_ori		, ls_inscr_est_dest	
STRING	ls_fax		, ls_razao_social , ls_nulo			, ls_mensagem	, ls_aux
STRING   ls_mensagem_fiscal , ls_dados_adicionais_1, ls_dados_adicionais_2, ls_dados_adicionais_3
STRING   ls_dados_adicionais_4, ls_dados_adicionais_5, ls_dados_adicionais_6, ls_dados_adicionais_7,ls_dados_adicionais_8
STRING   ls_dados_adicionais_9, ls_dados_adicionais_10
DATETIME	ld_nulo     , ld_emissao , ld_movimento
DEC{2}	ldc_nulo		, ldc_sum_total   , ldc_vl_bc_icms  , ldc_vl_icms  , ldc_vl_bc_icms_st
DEC{2}   ldc_vl_icms_st                , ldc_vl_total_produtos          , ldc_vl_frete    
DEC{2}	ldc_vl_total_nf               , ldc_vl_outras_despesas
	
of_Trocar_Ds("DI",a_serie)

ll_max = ids_itens_nf.Retrieve(a_filial_origem, a_nr_nf, a_especie, a_serie)

IF ll_max <= 0 THEN
	MESSAGEBOX("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nota Fiscal " + STRING(a_nr_nf) + " n$$HEX1$$e300$$ENDHEX$$o cont$$HEX1$$e900$$ENDHEX$$m itens cadastrados.", StopSign!)
	RETURN
END IF

ll_qt_mensagem_fiscal = of_localiza_codigo_fiscal(a_filial_origem, a_nr_nf, a_especie,&
								a_serie,ls_mensagem_fiscal,lvs_de_natureza_operacao)

// Funcao que verifica se existe mensagem fiscal
// ll_qt_mensagem_fiscal = of_localiza_codigo_fiscal()

SETNULL(ll_nulo)
SETNULL(ls_nulo)
SETNULL(ld_nulo)
SETNULL(ldc_nulo)

// Filial Origem
Selecionar_Informacoes_Filial(a_filial_origem		  , &
										ls_razao_social		  , &
										ls_cgc_ori				  , &
										ls_endereco_ori		  , &
										ls_bairro_ori			  , &
										ls_cep_ori				  , &
										ls_municipio_ori		  , &
										ls_fone_ori				  , &
										ls_fax					  , &	
										ls_uf_ori				  , &
										ls_inscr_est_ori)

Selecionar_informacoes_diversas(	a_filial_origem                  , &
											a_nr_nf									, &
											a_especie								, &
											a_serie									, &
											ls_razao_social		   			, &
											ls_cgc_dest				  				, &
											ls_endereco_dest		   			, &
											ls_bairro_dest			  				, &
											ls_cep_dest				  				, &
											ls_municipio_dest		  				, &
											ls_fone_dest							, &
											ls_uf_dest				   			, &
											ls_inscr_est_dest                , &
											ld_emissao								, &
											ldc_vl_bc_icms  						, &
											ldc_vl_icms  							, &
											ldc_vl_bc_icms_st 					, &
										   ldc_vl_icms_st 						, &
											ldc_vl_total_produtos            , &
											ldc_vl_frete  							, &
											ldc_vl_outras_despesas				, &
										   ldc_vl_total_nf 						, &
											ll_cd_natureza_operacao          , &
											ld_movimento                     , &
											ll_nr_nsu)
											
If LenA(ls_cgc_dest) = 11 Then
	ls_cgc_dest = Gf_Colocar_Mascara_CPF(ls_cgc_dest)		
ElseIf LenA(ls_cgc_dest) = 14 Then
	ls_cgc_dest = Gf_Colocar_Mascara_CGC(ls_cgc_dest)		
End IF



Imprimir_Cabecalho(ids_report_nf, &
  						 ""                                 ,& 
						 ""											, &
						 ls_endereco_ori  						, &
						 ls_bairro_ori 							, &
						 ls_municipio_ori 						, &
						 ls_uf_ori									, &
						 ls_fone_ori								, &
						 ls_cep_ori    							, &
						 "S"											, &
						 a_nr_nf										, &
						 lvs_de_natureza_operacao				, &
						 String(ll_cd_natureza_operacao)  	, &
						 ls_nulo										, &
						 ls_cgc_ori								   , &
 						 ls_inscr_est_ori							, &
						 ls_razao_social							, &
						 ls_cgc_dest								, &
						 ls_endereco_dest							, &
						 ls_bairro_dest							, &
						 ls_cep_dest								, &
						 ls_municipio_dest						, &
						 ls_fone_dest								, &
						 ls_uf_dest									, &
						 ls_inscr_est_dest						, &
						 ld_movimento  							, &
						 ld_nulo										, &
						 ld_nulo)

Imprimir_Calc_Imposto(ids_report_nf, &
							 ldc_vl_bc_icms			, &
							 ldc_vl_icms				, &
							 ldc_vl_bc_icms_st		, &
							 ldc_vl_icms_st			, &
							 ldc_vl_total_produtos	, &
							 ldc_vl_frete				, &
							 ldc_nulo					, &
							 ldc_vl_outras_despesas , &
							 ldc_nulo					, &
							 ldc_vl_total_nf			)


//Dados adicionais so existem na tabela nf_diversa da matriz	
If ids_report_nf.dataobject = 'dw_relatorio_padrao_nf_grande' Then
	
	Selecionar_Dados_Adicionais(a_filial_origem, &
										 a_nr_nf, &
										 a_especie, &
										 a_serie, &
                               Ref ls_dados_adicionais_1,& 
										 Ref ls_dados_adicionais_2,& 
										 Ref ls_dados_adicionais_3,& 
										 Ref ls_dados_adicionais_4,& 
 									    Ref ls_dados_adicionais_5,&
										 Ref ls_dados_adicionais_6,& 
										 Ref ls_dados_adicionais_7,&
										 Ref ls_dados_adicionais_8)
										  
	Imprimir_Dados_Adicionais(ls_dados_adicionais_1)
	Imprimir_Dados_Adicionais(ls_dados_adicionais_2)
	Imprimir_Dados_Adicionais(ls_dados_adicionais_3)
	Imprimir_Dados_Adicionais(ls_dados_adicionais_4)
	Imprimir_Dados_Adicionais(ls_dados_adicionais_5)
	Imprimir_Dados_Adicionais(ls_dados_adicionais_6)
	Imprimir_Dados_Adicionais(ls_dados_adicionais_7)
	Imprimir_Dados_Adicionais(ls_dados_adicionais_8)
	
End If	

//Dados adicionais NSU
If ld_movimento >= datetime(date("2007/07/01")) Then
	ls_dados_adicionais_9  = 'NSU: '+string(ll_nr_nsu)+' em'
	ls_dados_adicionais_10 = string(ld_emissao,'dd/mm/yyyy hh:mm')
	Imprimir_Dados_Adicionais(ls_dados_adicionais_9)
	Imprimir_Dados_Adicionais(ls_dados_adicionais_10)
End If

ll_quebra = 1

//Inserir_Produto_Manipulado("VE", a_filial_origem, a_nr_nf, a_especie, a_serie)

CHOOSE CASE ll_qt_mensagem_fiscal
	CASE 1
		ids_itens_nf.InsertRow(0)
END CHOOSE

ll_max    = ids_itens_nf.RowCount()
lvi_Linha = 1

FOR ll_row = 1 TO ll_max
	
	If lvi_Linha = 1 Then
		If a_serie = '2' or a_serie = '4' Then 
			lvi_Qt_Linhas_Nf = 21
		Else
			lvi_Qt_Linhas_Nf = 7
		End If
	Else
		If a_serie = '2' or a_serie = '4' Then
			lvi_Qt_Linhas_Nf = 20
		Else
			lvi_Qt_Linhas_Nf = 5
		End If
	End If
	
	IF MOD(ll_row, lvi_Qt_Linhas_Nf) = 0 AND ll_row <> ll_max THEN 
		
		ll_insert = ids_report_nf.InsertRow(0)
		
		ls_mensagem = "A TRANSPORTAR..." //PARA A NOTA FISCAL " + STRING(a_nr_nf) + "/" + STRING(ll_quebra +1) + ": " + String(ldc_sum_total,"###,###,##0.00")
		ids_report_nf.Object.mensagem		[ll_insert] = ls_mensagem  
		ids_report_nf.Object.vl_sum_total[ll_insert] = ldc_sum_total
		ids_report_nf.Object.quebra	 	[ll_insert] = ll_quebra
		ll_linha += 1
		ids_report_nf.Object.linha	 		[ll_insert] = ll_linha
		
		ll_quebra += 1
		
		ll_insert = ids_report_nf.InsertRow(0)
		ls_mensagem = "DE TRANSPORTE..." // DA NOTA FISCAL " + STRING(a_nr_nf) + "/" + STRING(ll_quebra -1) + ": " + String(ldc_sum_total,"###,###,##0.00")
		ids_report_nf.Object.mensagem		[ll_insert] = ls_mensagem
		ids_report_nf.Object.vl_sum_total[ll_insert] = ldc_sum_total
		ids_report_nf.Object.quebra	 	[ll_insert] = ll_quebra
		ll_linha += 1
		ids_report_nf.Object.linha	 		[ll_insert] = ll_linha
		
		lvi_Linha = 2
		//ldc_sum_total  = 0
		
	END IF
		
	ldc_sum_total = ldc_sum_total + ids_itens_nf.Object.c_valor_total [ll_row]
	ll_linha 	 += 1
	
	Imprimir_Detalhe(ids_report_nf, &
	 					  ll_quebra															, &
						  ll_linha															, &	
						  ids_itens_nf.Object.cd_item 				 	[ll_row] , &
						  ids_itens_nf.Object.de_item 				 	[ll_row] , &
						  ll_nulo															, &
                    ''																	, &
						  ids_itens_nf.Object.de_unidade_medida      [ll_row] , &
						  ids_itens_nf.Object.qt_item  					[ll_row]	, &
						  ids_itens_nf.Object.vl_preco_unitario		[ll_row]	, &
						  ids_itens_nf.Object.pc_desconto				[ll_row]	, &
						  ids_itens_nf.Object.c_valor_total			 	[ll_row]	, &
						  ids_itens_nf.Object.pc_icms					 	[ll_row])
										
END FOR

ll_max      = ids_report_nf.RowCount()
ll_mensagem = ll_max

If a_serie = '2' or a_serie = '4' Then 
	lvi_Qt_Linhas_NF = 21
Else
	lvi_Qt_Linhas_NF = 7
End If	

// Insere linhas no detalhe at$$HEX1$$e900$$ENDHEX$$ completar linhas nota fiscal
DO WHILE ll_max < (ll_quebra * lvi_Qt_Linhas_NF) 
	ll_insert = ids_report_nf.InsertRow(0)
	ids_report_nf.Object.quebra[ll_insert] = ll_quebra
	ll_linha += 1
	ids_report_nf.Object.linha [ll_insert] = ll_linha
	ll_max += 1
LOOP

// Imprime Mensagem Fiscal

CHOOSE CASE ll_qt_mensagem_fiscal
	CASE 1
		ids_report_nf.Object.mensagem[ll_mensagem] = ls_mensagem_fiscal
END CHOOSE

Imprimir_Ds(ids_report_nf)
end subroutine

public subroutine of_trocar_ds (string a_tipo, string a_serie);//
CHOOSE CASE a_tipo 
	CASE "TR"	// TRANSFERENCIA
		//
		ids_itens_nf.of_ChangeDataObject( 'ds_itens_nf_transferencia' )
		//
		ids_produto_manip.DataObject = ""
		ids_produto_manip.of_ChangeDataObject( 'ds_registro_transferencia_manip' )
		//
	CASE "DV"	// DEVOLUCAO VENDA
		ids_itens_nf.of_ChangeDataObject( 'ds_itens_nf_devolucao_venda' )
		//
		ids_produto_manip.of_ChangeDataObject( 'ds_registro_devolucao_venda_manip' )
		//
	CASE "DC"	// DEVOLUCAO COMPRA
		ids_itens_nf.of_ChangeDataObject( 'ds_itens_nf_devolucao_compra' )
		//
	CASE "VE"	// VENDA
		ids_itens_nf.of_ChangeDataObject( 'ds_itens_nf_venda' )
		//
		ids_produto_manip.of_ChangeDataObject( 'ds_registro_venda_manip' )
		//
	CASE "DI"	// DIVERSA
		ids_itens_nf.of_ChangeDataObject( 'ds_itens_nf_diversa' )
		//
END CHOOSE

//Configura formul$$HEX1$$e100$$ENDHEX$$rio a ser impresso
If a_serie = '2' or a_serie = '4' Then
	ids_report_nf.of_ChangeDataObject( 'dw_relatorio_padrao_nf_grande' )
Else
	ids_report_nf.of_ChangeDataObject( 'dw_relatorio_padrao_nf' )
End If

ids_mensagem_fiscal.of_ChangeDataObject( 'ds_mensagem_fiscal' )
end subroutine

public subroutine emitir_nf_diversa_central (long a_filial_origem, long a_nr_nf, string a_especie, string a_serie);// Controle para n$$HEX1$$e300$$ENDHEX$$o imprimir nota fiscal eletr$$HEX1$$f400$$ENDHEX$$nica
If a_especie = 'NFE' Then Return

OPEN(w_ge033_prepara_impressora)

LONG		ll_row		, ll_max				, ll_nulo			, ll_quebra		, ll_insert, ll_linha
LONG     ll_cd_natureza_operacao       , ll_nr_nsu
LONG     ll_qt_mensagem_fiscal, ll_mensagem
Long     lvl_controle
INTEGER  lvi_Linha, lvi_Qt_Linhas_NF
STRING   ls_matricula, lvs_de_natureza_operacao
STRING	ls_cgc_dest	, ls_endereco_dest, ls_bairro_dest	, ls_municipio_dest	 
STRING	ls_cgc_ori	, ls_endereco_ori	, ls_bairro_ori	, ls_municipio_ori	 
STRING	ls_fone_dest, ls_uf_dest		, ls_cep_dest		, ls_inscr_est_ori	 
STRING	ls_fone_ori	, ls_uf_ori			, ls_cep_ori		, ls_inscr_est_dest	
STRING	ls_fax		, ls_razao_social , ls_nulo			, ls_mensagem	, ls_aux
STRING   ls_mensagem_fiscal , ls_dados_adicionais
STRING   ls_dados_adicionais_1, ls_dados_adicionais_2, ls_dados_adicionais_3, ls_dados_adicionais_4, ls_dados_adicionais_5
STRING   ls_dados_adicionais_6, ls_dados_adicionais_7, ls_dados_adicionais_8
String lvs_Entrada_Saida
DATETIME	ld_nulo     , ld_emissao      , ld_movimentacao_caixa
DEC{2}	ldc_nulo		, ldc_sum_total   , ldc_vl_bc_icms  , ldc_vl_icms  , ldc_vl_bc_icms_st
DEC{2}   ldc_vl_icms_st                , ldc_vl_total_produtos          , ldc_vl_frete    
DEC{2}	ldc_vl_total_nf               , ldc_vl_outras_despesas         , ldc_vl_ipi
	
of_Trocar_Ds("DI",a_serie)

ll_max = ids_itens_nf.Retrieve(a_filial_origem, a_nr_nf, a_especie, a_serie)

IF ll_max <= 0 THEN
	MESSAGEBOX("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nota Fiscal " + STRING(a_nr_nf) + " n$$HEX1$$e300$$ENDHEX$$o cont$$HEX1$$e900$$ENDHEX$$m itens cadastrados.", StopSign!)
	RETURN
END IF

ll_qt_mensagem_fiscal = of_localiza_codigo_fiscal(a_filial_origem, a_nr_nf, a_especie,&
								a_serie,ls_mensagem_fiscal,lvs_de_natureza_operacao)

// Funcao que verifica se existe mensagem fiscal
// ll_qt_mensagem_fiscal = of_localiza_codigo_fiscal()

SETNULL(ll_nulo)
SETNULL(ls_nulo)
SETNULL(ld_nulo)
SETNULL(ldc_nulo)

// Filial Origem
Selecionar_Informacoes_Filial(a_filial_origem		  , &
										ls_razao_social		  , &
										ls_cgc_ori				  , &
										ls_endereco_ori		  , &
										ls_bairro_ori			  , &
										ls_cep_ori				  , &
										ls_municipio_ori		  , &
										ls_fone_ori				  , &
										ls_fax					  , &	
										ls_uf_ori				  , &
										ls_inscr_est_ori)

Selecionar_informacoes_diversas_central(a_filial_origem  , &
											a_nr_nf						, &
											a_especie					, &
											a_serie						, &
											ls_razao_social		   , &
											ls_cgc_dest				  	, &
											ls_endereco_dest		   , &
											ls_bairro_dest			  	, &
											ls_cep_dest				  	, &
											ls_municipio_dest		  	, &
											ls_fone_dest				, &
											ls_uf_dest				   , &
											ls_inscr_est_dest       , &
											ld_movimentacao_caixa   , &
											ld_emissao					, &
											ldc_vl_bc_icms  			, &
											ldc_vl_icms  				, &
											ldc_vl_bc_icms_st 		, &
										   ldc_vl_icms_st 			, &
											ldc_vl_total_produtos   , &
											ldc_vl_frete  				, &
											ldc_vl_outras_despesas	, &
										   ldc_vl_total_nf 			, &
											ll_cd_natureza_operacao , &
											ldc_vl_ipi              , &
											ll_nr_nsu)
											
If Not of_Verifica_Entrada_Saida_Natureza_Op(ll_Cd_Natureza_Operacao, Ref lvs_Entrada_Saida) Then Return

Imprimir_Cabecalho(ids_report_nf, &
  						 ""                           ,& 
						 ""								   , &
						 ls_endereco_ori  				, &
						 ls_bairro_ori 					, &
						 ls_municipio_ori 				, &
						 ls_uf_ori							, &
						 ls_fone_ori						, &
						 ls_cep_ori    					, &
						 lvs_Entrada_Saida 			   , &
						 a_nr_nf								, &
						 lvs_de_natureza_operacao		, &
						 String(ll_cd_natureza_operacao), &
						 ls_nulo								, &
						 ls_cgc_ori							, &
 						 ls_inscr_est_ori					, &
						 ls_razao_social					, &
						 ls_cgc_dest						, &
						 ls_endereco_dest					, &
						 ls_bairro_dest					, &
						 ls_cep_dest						, &
						 ls_municipio_dest				, &
						 ls_fone_dest						, &
						 ls_uf_dest							, &
						 ls_inscr_est_dest				, &
						 ld_movimentacao_caixa			, &
						 ld_nulo								, &
						 ld_nulo)

Imprimir_Calc_Imposto(ids_report_nf, &
							 ldc_vl_bc_icms			, &
							 ldc_vl_icms				, &
							 ldc_vl_bc_icms_st		, &
							 ldc_vl_icms_st			, &
							 ldc_vl_total_produtos	, &
							 ldc_vl_frete				, &
							 ldc_nulo					, &
							 ldc_vl_outras_despesas , &
							 ldc_vl_ipi	 				, &
							 ldc_vl_total_nf			)

//Dados adicionais NSU
ll_linha += 1

If ld_movimentacao_caixa >= datetime(date("2007/11/01")) Then
	ls_dados_adicionais = 'NSU: '+string(ll_nr_nsu)+' em '+string(ld_emissao,'dd/mm/yyyy hh:mm')
	Imprimir_Dados_Adicionais(ls_dados_adicionais)
End If
	
//Dados adicionais so existem na tabela nf_diversa da matriz	
If ids_report_nf.dataobject = 'dw_relatorio_padrao_nf_grande' Then
	
	Selecionar_Dados_Adicionais(a_filial_origem, &
										 a_nr_nf, &
										 a_especie, &
										 a_serie, &
                               Ref ls_dados_adicionais_1,& 
										 Ref ls_dados_adicionais_2,& 
										 Ref ls_dados_adicionais_3,& 
										 Ref ls_dados_adicionais_4,& 
 									    Ref ls_dados_adicionais_5,&
										 Ref ls_dados_adicionais_6,& 
										 Ref ls_dados_adicionais_7,&
										 Ref ls_dados_adicionais_8 )
										 
										  
	Imprimir_Dados_Adicionais(ls_dados_adicionais_1)
	Imprimir_Dados_Adicionais(ls_dados_adicionais_2)
	Imprimir_Dados_Adicionais(ls_dados_adicionais_3)
	Imprimir_Dados_Adicionais(ls_dados_adicionais_4)
	Imprimir_Dados_Adicionais(ls_dados_adicionais_5)
	Imprimir_Dados_Adicionais(ls_dados_adicionais_6)
	Imprimir_Dados_Adicionais(ls_dados_adicionais_7)
	Imprimir_Dados_Adicionais(ls_dados_adicionais_8)
	ll_linha += 8  
End If	

ll_quebra = 1

//Inserir_Produto_Manipulado("VE", a_filial_origem, a_nr_nf, a_especie, a_serie)

CHOOSE CASE ll_qt_mensagem_fiscal
	CASE 1
		ids_itens_nf.InsertRow(0)
END CHOOSE

ll_max    = ids_itens_nf.RowCount()
lvi_Linha = 1

lvl_controle = 0
	
FOR ll_row = 1 TO ll_max
	lvl_controle++
	
	If lvi_Linha = 1 Then
		If a_serie = '2' or a_serie = '4' Then 
			lvi_Qt_Linhas_Nf = 21
		Else
			lvi_Qt_Linhas_Nf = 11
		End If
	Else
		If a_serie = '2' or a_serie = '4' Then
			lvi_Qt_Linhas_Nf = 19
		Else
			lvi_Qt_Linhas_Nf = 8
		End If
	End If
	
	IF MOD(lvl_controle, lvi_Qt_Linhas_Nf) = 0 AND ll_row <> ll_max THEN 
		lvl_controle = 0
		
		ll_insert = ids_report_nf.InsertRow(0)
		
		ls_mensagem = "A TRANSPORTAR..."//PARA A NOTA FISCAL " + STRING(a_nr_nf) + "/" + STRING(ll_quebra +1) + ": " + String(ldc_sum_total,"###,###,##0.00")
		ids_report_nf.Object.mensagem		[ll_insert] = ls_mensagem  
		ids_report_nf.Object.vl_sum_total[ll_insert] = ldc_sum_total
		ids_report_nf.Object.quebra	 	[ll_insert] = ll_quebra
		ll_linha += 1
		ids_report_nf.Object.linha	 		[ll_insert] = ll_linha
		
		ll_quebra += 1
		
		ll_insert = ids_report_nf.InsertRow(0)
		ls_mensagem = "DE TRANSPORTE..."//DA NOTA FISCAL " + STRING(a_nr_nf) + "/" + STRING(ll_quebra -1) + ": " + String(ldc_sum_total,"###,###,##0.00")
		ids_report_nf.Object.mensagem		[ll_insert] = ls_mensagem
		ids_report_nf.Object.vl_sum_total[ll_insert] = ldc_sum_total
		ids_report_nf.Object.quebra	 	[ll_insert] = ll_quebra
		ll_linha += 1
		ids_report_nf.Object.linha	 		[ll_insert] = ll_linha
		
		lvi_Linha = 2
		//ldc_sum_total  = 0
	
	END IF
		
	ldc_sum_total = ldc_sum_total + ids_itens_nf.Object.c_valor_total [ll_row]
	
	ll_linha 	 += 1
	Imprimir_Detalhe(ids_report_nf, &
	 					  ll_quebra															, &
						  ll_linha															, &	
						  ids_itens_nf.Object.cd_item 				 	[ll_row] , &
						  ids_itens_nf.Object.de_item 				 	[ll_row] , &
						  ll_nulo															, &
                    ''																	, &
						  ids_itens_nf.Object.de_unidade_medida      [ll_row] , &
						  ids_itens_nf.Object.qt_item  					[ll_row]	, &
						  ids_itens_nf.Object.vl_preco_unitario		[ll_row]	, &
						  ids_itens_nf.Object.pc_desconto				[ll_row]	, &
						  ids_itens_nf.Object.c_valor_total			 	[ll_row]	, &
						  ids_itens_nf.Object.pc_icms					 	[ll_row])
  
   					  
										
END FOR

ll_max      = ids_report_nf.RowCount()
ll_mensagem = ll_max

If a_serie = '2' or a_serie = '4' Then 
	lvi_Qt_Linhas_NF = 21
Else
	lvi_Qt_Linhas_NF = 11
End If	

// Insere linhas no detalhe at$$HEX1$$e900$$ENDHEX$$ completar linhas nota fiscal
DO WHILE ll_max < (ll_quebra * lvi_Qt_Linhas_NF) 
	ll_insert = ids_report_nf.InsertRow(0)
	ids_report_nf.Object.quebra[ll_insert] = ll_quebra
	ll_linha += 1
	ids_report_nf.Object.linha [ll_insert] = ll_linha
	ll_max += 1
LOOP

// Imprime Mensagem Fiscal

CHOOSE CASE ll_qt_mensagem_fiscal
	CASE 1
		ids_report_nf.Object.mensagem[ll_mensagem] = ls_mensagem_fiscal
		ll_linha += 1
END CHOOSE

Imprimir_Ds(ids_report_nf)
end subroutine

public function boolean of_verifica_entrada_saida_natureza_op (integer pl_natureza, ref string ps_entrada_saida);Select id_entrada_saida Into :ps_Entrada_Saida
From natureza_operacao
Where cd_natureza_operacao = :pl_natureza
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgdbError("Tipo Entrada/Sa$$HEX1$$ed00$$ENDHEX$$da da Natureza de Opera$$HEX2$$e700e300$$ENDHEX$$o")
		Return False
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi localizado o tipo entrada/sa$$HEX1$$ed00$$ENDHEX$$da para a natureza: " + String(pl_Natureza), StopSign!)
		Return False		
	Case 0
End Choose

Return True
end function

public function string of_localiza_nome_cidade (long pl_cidade);String lvs_Cidade,&
		 lvs_Nulo

Select nm_cidade
Into :lvs_Cidade
From cidade
Where cd_cidade = :pl_cidade
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do nome da cidade")
		SetNull(lvs_Nulo)
		Return lvs_Nulo	
	Case 100
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nome da cidade '" + String(pl_Cidade) + "' n$$HEX1$$e300$$ENDHEX$$o foi encontrada.", Information!)
		SetNull(lvs_Nulo)
		Return lvs_Nulo	
	Case 0
		Return lvs_Cidade
End Choose

end function

public subroutine imprimir_cabecalho (datastore ids_report, string a_operador, string a_vendedor, string a_endereco_origem, string a_bairro_origem, string a_cidade_origem, string a_uf_origem, string a_fone_origem, string a_cep_origem, string a_saida_entrada, long a_nr_nf, string a_natureza_oper, string a_cfop, string a_inscr_est_subst_trib, string a_cgc_origem, string a_inscr_est_origem, string a_razao_social_dest, string a_cgc_dest, string a_endereco_dest, string a_bairro_dest, string a_cep_dest, string a_municipio_dest, string a_fone_fax_dest, string a_uf_dest, string a_inscr_est_dest, datetime a_data_emissao, datetime a_data_saida_entr, datetime a_hora_saida);ids_report.Object.operador_t					 .Text = a_operador
ids_report.Object.vendedor_t					 .Text = a_vendedor
ids_report.Object.endereco_origem_t			 .Text = a_endereco_origem
ids_report.Object.bairro_cidade_uf_origem_t.Text = TRIM(a_bairro_origem) + " " + TRIM(a_cidade_origem) + "-" + TRIM(a_uf_origem)
ids_report.Object.fone_cep_origem_t			 .Text = TRIM(a_fone_origem) + " CEP: " + TRIM(a_cep_origem)	

IF a_saida_entrada = "S" THEN
	ids_report.Object.saida_t  .Visible = 1
	ids_report.Object.entrada_t.Visible = 0
ELSE
	ids_report.Object.saida_t  .Visible = 0
	ids_report.Object.entrada_t.Visible = 1
END IF	

If IsNull(a_cfop) Then a_cfop = ""

If ISNull(a_inscr_est_subst_trib) Then a_inscr_est_subst_trib = ""

If ISNull(a_cgc_origem) Then a_cgc_origem = ""

If ISNull(a_inscr_est_origem) Then a_inscr_est_origem = ""

If ISNull(a_razao_social_dest) Then a_razao_social_dest = ""

If ISNull(a_cgc_dest) Then a_cgc_dest = ""

If ISNull(a_endereco_dest) Then a_endereco_dest = ""

If ISNull(a_bairro_dest) Then a_bairro_dest = ""

If ISNull(a_cep_dest) Then a_cep_dest = ""

If ISNull(a_municipio_dest) Then a_municipio_dest = ""

If ISNull(a_fone_fax_dest) Then a_fone_fax_dest = ""

If ISNull(a_uf_dest) Then a_uf_dest = ""

If ISNull(a_inscr_est_dest) Then a_inscr_est_dest = ""

ids_report.Object.nr_nf_t						.Text = STRING(a_nr_nf)
ids_report.Object.nr_nf_rodape_t				.Text = STRING(a_nr_nf)
ids_report.Object.natureza_oper_t			.Text = a_natureza_oper
ids_report.Object.cfop_t						.Text = a_cfop
ids_report.Object.cgc_origem_t				.Text = a_cgc_origem
ids_report.Object.inscr_est_origem_t		.Text = a_inscr_est_origem
ids_report.Object.razao_social_destino_t	.Text = a_razao_social_dest
ids_report.Object.cgc_destino_t			 	.Text = a_cgc_dest
ids_report.Object.endereco_destino_t		.Text = a_endereco_dest
ids_report.Object.bairro_destino_t			.Text = a_bairro_dest
ids_report.Object.cep_destino_t				.Text = a_cep_dest
ids_report.Object.municipio_destino_t		.Text = a_municipio_dest
ids_report.Object.fone_destino_t				.Text = a_fone_fax_dest
ids_report.Object.uf_destino_t				.Text = a_uf_dest
ids_report.Object.inscr_est_destino_t		.Text = a_inscr_est_dest
ids_report.Object.data_emissao_t				.Text = STRING(a_data_emissao	  , "DD/MM/YYYY")
ids_report.Object.data_saida_entrada_t		.Text = STRING(a_data_saida_entr, "DD/MM/YYYY")
ids_report.Object.hora_saida_t				.Text = STRING(a_hora_saida	  , "HH:MM")	
end subroutine

public subroutine of_prepara_natureza_operacao (ref string as_natureza);Boolean lvb_Existe

Long lvl_Linha, &
     lvl_Natureza, &
	  lvl_Contador
	  
String lvs_Natureza[]

// Verifica todas as naturezas existentes e monta um array com as diferentes
// Teve que utilizar o array, porque a ordem da DS n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ por natureza
For lvl_Linha = 1 To ids_Itens_NF.RowCount()
	lvl_Natureza = ids_Itens_NF.Object.Cd_Natureza_Operacao[lvl_Linha]
	
	lvb_Existe = False
	
	For lvl_Contador = 1 To UpperBound(lvs_Natureza)
		If lvs_Natureza[lvl_Contador] = String(lvl_Natureza) Then
			lvb_Existe = True
			Exit
		End If
	Next
	
	If Not lvb_Existe Then
		lvs_Natureza[UpperBound(lvs_Natureza) + 1] = String(lvl_Natureza)
	End If
Next

// Monta a string com todas as naturezas existentes na nota fiscal
For lvl_Contador = 1 To UpperBound(lvs_Natureza)
	If as_Natureza <> "" Then 
		as_Natureza += "/"
	End If
	
	as_Natureza += lvs_Natureza[lvl_Contador]
Next
end subroutine

public function boolean selecionar_informacoes_diversas_central (long a_filial, long a_nr_nf, string a_especie, string a_serie, ref string a_razao_social, ref string a_cgc_cpf, ref string a_endereco, ref string a_bairro, ref string a_cep, ref string a_municipio, ref string a_fone, ref string a_uf, ref string a_inscr_est, ref datetime a_dh_movimentacao_caixa, ref datetime a_dh_emissao, ref decimal a_vl_bc_icms, ref decimal a_vl_icms, ref decimal a_vl_bc_icms_st, ref decimal a_vl_icms_st, ref decimal a_vl_total_produtos, ref decimal a_vl_frete, ref decimal a_vl_outras_despesas, ref decimal a_vl_total_nf, ref long a_cd_natureza_operacao, ref decimal a_vl_total_ipi, ref long a_nr_nsu);//
SELECT nm_destinatario,
		 nr_cgc_cpf,
		 de_endereco,
		 de_bairro,	
		 nr_cep,
		 nm_cidade,
		 nr_telefone,
		 nm_uf,
		 nr_inscricao_estadual,
		 dh_movimentacao_caixa,
		 dh_emissao,
		 vl_bc_icms,
		 vl_icms,
		 vl_bc_icms_st,
		 vl_icms_st,
		 vl_total_produtos,
		 vl_frete,
		 vl_outras_despesas,
		 vl_total_nf,
		 cd_natureza_operacao,
		 vl_ipi,
		 nr_nsu
INTO	 :a_razao_social,   
		 :a_cgc_cpf,   
 		 :a_endereco,   
  		 :a_bairro,
		 :a_cep,
		 :a_municipio,   
		 :a_fone,
		 :a_uf,   
		 :a_inscr_est,
		 :a_dh_movimentacao_caixa,
		 :a_dh_emissao,
		 :a_vl_bc_icms, 
		 :a_vl_icms, 
		 :a_vl_bc_icms_st,
		 :a_vl_icms_st, 
		 :a_vl_total_produtos, 
		 :a_vl_frete,
		 :a_vl_outras_despesas,
	    :a_vl_total_nf,
		 :a_cd_natureza_operacao,
		 :a_vl_total_ipi,
		 :a_nr_nsu
FROM nf_diversa
WHERE cd_filial_origem = :a_filial
  AND nr_nf            = :a_nr_nf
  AND de_especie       = :a_especie
  AND de_serie         = :a_serie 
USING  SQLCA;
//
IF SQLCA.SQLCode = -1 THEN
	MESSAGEBOX("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na consulta nf_diversa: " + SQLCA.SQLErrText, StopSign!)
	RETURN FALSE
END IF
//
IF SQLCA.SQLCode = 100 THEN
	MESSAGEBOX("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nota fiscal n$$HEX1$$e300$$ENDHEX$$o encontrada.", StopSign!)
	RETURN FALSE
END IF
//
RETURN TRUE
//
end function

public function boolean selecionar_informacoes_devolucao_compra (long pl_nr_filial, long pl_nr_nf, string de_especie, string de_serie, ref long pl_cd_filial_compra, ref long pl_nr_nf_compra, ref string ps_de_especie_compra, ref string ps_serie_compra, ref datetime pd_movimentacao, ref datetime pd_emissao, ref long pl_nsu);select	cd_filial              ,
       	nr_nf_compra     		  ,
		 	de_especie_compra	 	  ,
		 	de_serie_compra 		  ,
			dh_movimentacao_caixa  ,
			dh_emissao             ,
			nr_nsu
  Into 	:pl_cd_filial_compra	  ,
  			:pl_nr_nf_compra		  ,
			:ps_de_especie_compra  ,
			:ps_serie_compra       ,
			:pd_movimentacao       ,
			:pd_emissao            ,
			:pl_nsu
	From nf_devolucao_compra
  Where cd_filial  = :pl_nr_filial
    and nr_nf      = :pl_nr_nf
	 and de_especie = :de_especie
 	 and de_serie   = :de_serie;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao consulta nf_devolucao_compra: " + SqlCa.SqlErrText + ".", &
					StopSign!,Ok!)
		Return False				
ElseIf SQLCA.SQLCode = 100 THEN
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nota fiscal n$$HEX1$$e300$$ENDHEX$$o encontrada.", StopSign!,Ok!)
	Return False
End If				
	  
Return True	  
end function

public function boolean of_proximo_nsu (ref long al_Proximo);Boolean lvb_Sucesso = False

Long lvl_Ultimo
	  
String lvs_Ultimo, &
       lvs_Proximo

Select vl_parametro Into :lvl_Ultimo
From parametro_loja
Where cd_parametro = 'NR_NSU_NF'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro NR_NSU_NF n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
		Return lvb_Sucesso
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Par$$HEX1$$e200$$ENDHEX$$metro NR_NSU_NF")
		Return lvb_Sucesso
End Choose

al_Proximo = lvl_Ultimo + 1
	
lvs_Ultimo  = String(lvl_Ultimo)
lvs_Proximo = String(al_Proximo)

Update parametro_loja
Set vl_parametro = :lvs_Proximo
Where cd_parametro = 'NR_NSU_NF'
  and vl_parametro = :lvs_Ultimo
Using SqlCa;
	
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do $$HEX1$$da00$$ENDHEX$$ltimo NSU")
Else	
	If SqlCa.SqlnRows = 0 Then
		lvb_Sucesso = This.of_proximo_nsu(ref al_Proximo)
	Else
		lvb_Sucesso = True
	End If
End If

Return lvb_Sucesso
end function

public function boolean selecionar_informacoes_diversas (long a_filial, long a_nr_nf, string a_especie, string a_serie, ref string a_razao_social, ref string a_cgc_cpf, ref string a_endereco, ref string a_bairro, ref string a_cep, ref string a_municipio, ref string a_fone, ref string a_uf, ref string a_inscr_est, ref datetime a_dh_emissao, ref decimal a_vl_bc_icms, ref decimal a_vl_icms, ref decimal a_vl_bc_icms_st, ref decimal a_vl_icms_st, ref decimal a_vl_total_produtos, ref decimal a_vl_frete, ref decimal a_vl_outras_despesas, ref decimal a_vl_total_nf, ref long a_cd_natureza_operacao, ref datetime a_dh_movimento, ref long a_nr_nsu);//
SELECT nm_destinatario,
		 nr_cgc_cpf,
		 de_endereco,
		 de_bairro,	
		 nr_cep,
		 nm_cidade,
		 nr_telefone,
		 nm_uf,
		 nr_inscricao_estadual,
		 dh_emissao,
		 vl_bc_icms,
		 vl_icms,
		 vl_bc_icms_st,
		 vl_icms_st,
		 vl_total_produtos,
		 vl_frete,
		 vl_outras_despesas,
		 vl_total_nf,
		 cd_natureza_operacao, 
		 dh_movimentacao_caixa,
		 nr_nsu
INTO	 :a_razao_social,   
		 :a_cgc_cpf,   
 		 :a_endereco,   
  		 :a_bairro,
		 :a_cep,
		 :a_municipio,   
		 :a_fone,
		 :a_uf,   
		 :a_inscr_est,
		 :a_dh_emissao,
		 :a_vl_bc_icms, 
		 :a_vl_icms, 
		 :a_vl_bc_icms_st,
		 :a_vl_icms_st, 
		 :a_vl_total_produtos, 
		 :a_vl_frete,
		 :a_vl_outras_despesas,
	    :a_vl_total_nf,
		 :a_cd_natureza_operacao,
		 :a_dh_movimento,
		 :a_nr_nsu
		 
FROM nf_diversa
WHERE cd_filial_origem = :a_filial
  AND nr_nf            = :a_nr_nf
  AND de_especie       = :a_especie
  AND de_serie         = :a_serie 
USING  SQLCA;
//
IF SQLCA.SQLCode = -1 THEN
	MESSAGEBOX("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na consulta nf_diversa: " + SQLCA.SQLErrText, StopSign!)
	RETURN FALSE
END IF
//
IF SQLCA.SQLCode = 100 THEN
	MESSAGEBOX("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nota fiscal n$$HEX1$$e300$$ENDHEX$$o encontrada.", StopSign!)
	RETURN FALSE
END IF
//
RETURN TRUE
//
end function

public subroutine emitir_nf_transferencia_icms (string operador, long a_filial_origem, long a_filial_matriz, long a_nr_nf, string a_especie, string a_serie, datetime a_data_movimento, datetime a_data_emissao, long a_nr_nsu);OPEN(w_ge033_prepara_impressora)

LONG		ll_row		, ll_max				, ll_nulo			, ll_quebra		, ll_insert, ll_linha
STRING	ls_cgc_dest	, ls_endereco_dest, ls_bairro_dest	, ls_municipio_dest	 
STRING	ls_cgc_ori	, ls_endereco_ori	, ls_bairro_ori	, ls_municipio_ori	 
STRING	ls_fone_dest, ls_uf_dest		, ls_cep_dest		, ls_inscr_est_ori	 
STRING	ls_fone_ori	, ls_uf_ori			, ls_cep_ori		, ls_inscr_est_dest	
STRING	ls_fax		, ls_razao_social , ls_nulo			, ls_mensagem			, ls_aux
STRING   ls_dados_adicionais_1, ls_dados_adicionais_2
DATETIME	ld_nulo
	
SETNULL(ll_nulo)
SETNULL(ls_nulo)
SETNULL(ld_nulo)

ids_report_nf.DataObject = "dw_relatorio_padrao_icms_nf"
ids_report_nf.SetTrans(SQLCA)

// Filial Origem
Selecionar_Informacoes_Filial(a_filial_origem		  , &
										ls_razao_social		  , &
										ls_cgc_ori				  , &
										ls_endereco_ori		  , &
										ls_bairro_ori			  , &
										ls_cep_ori				  , &
										ls_municipio_ori		  , &
										ls_fone_ori				  , &
										ls_fax					  , &	
										ls_uf_ori				  , &
										ls_inscr_est_ori)

// Filial Destino
Selecionar_Informacoes_Filial(a_filial_Matriz                           , &
										ls_razao_social		   						, &
										ls_cgc_dest				   						, &
										ls_endereco_dest		   						, &
										ls_bairro_dest			   						, &
										ls_cep_dest				   						, &
										ls_municipio_dest		   						, &
										ls_fone_dest										, &
										ls_fax												, & 
										ls_uf_dest				   						, &
										ls_inscr_est_dest)

//Dados adicionais NSU
If a_data_movimento >= datetime(date("2007/07/01")) Then
	ls_dados_adicionais_1 = 'NSU: '+string(a_nr_nsu)+' em'
	ls_dados_adicionais_2 = string(a_data_emissao,'dd/mm/yyyy hh:mm')
	Imprimir_Dados_Adicionais(ls_dados_adicionais_1)
	Imprimir_Dados_Adicionais(ls_dados_adicionais_2)
End If

Imprimir_Cabecalho_ICMS("Operador: " + operador       , &
						 ""											, &
						 ls_endereco_ori							, &
						 ls_bairro_ori								, &
						 ls_municipio_ori							, &
						 ls_uf_ori									, &
						 ls_fone_ori								, &
						 ls_cep_ori									, &
						 ls_nulo										, &
						 a_nr_nf										, &
						 "APUR. CONSOLIDADA"                , &
						 "TRANSF. SALDO ICMS"     				, &
						 5605  										, &
						 ls_nulo										, &
						 ls_cgc_ori									, &
						 ls_inscr_est_ori							, &
						 ls_razao_social							, &
						 ls_cgc_dest								, &
						 ls_endereco_dest							, &
						 ls_bairro_dest							, &
						 ls_cep_dest								, &
						 ls_municipio_dest						, &
						 ls_fone_dest								, &
						 ls_uf_dest									, &
						 ls_inscr_est_dest						, &
						 a_data_movimento                   , &
						 ld_nulo										, &
						 ld_nulo)

ll_insert = ids_report_nf.InsertRow(0)

ls_mensagem = "SALDO DEVEDOR ..."
ids_report_nf.Object.mensagem		[ll_insert] = ls_mensagem  

Imprimir_Ds(ids_report_nf)
end subroutine

public subroutine emitir_nf_lancamento_imobilizado (string operador, long a_filial_origem, long a_filial_matriz, long a_nr_nf, string a_especie, string a_serie, datetime a_data_movimento, datetime a_data_emissao, long a_nr_nsu);OPEN(w_ge033_prepara_impressora)

LONG		ll_row		, ll_max				, ll_nulo			, ll_quebra		, ll_insert, ll_linha
STRING	ls_cgc_dest	, ls_endereco_dest, ls_bairro_dest	, ls_municipio_dest	 
STRING	ls_cgc_ori	, ls_endereco_ori	, ls_bairro_ori	, ls_municipio_ori	 
STRING	ls_fone_dest, ls_uf_dest		, ls_cep_dest		, ls_inscr_est_ori	 
STRING	ls_fone_ori	, ls_uf_ori			, ls_cep_ori		, ls_inscr_est_dest	
STRING	ls_fax		, ls_razao_social , ls_nulo			, ls_mensagem			, ls_aux
STRING   ls_dados_adicionais_1 , ls_dados_adicionais_2
DATETIME	ld_nulo
	
SETNULL(ll_nulo)
SETNULL(ls_nulo)
SETNULL(ld_nulo)

ids_report_nf.DataObject = "dw_relatorio_padrao_icms_nf"
ids_report_nf.SetTrans(SQLCA)

// Filial Origem
Selecionar_Informacoes_Filial(a_filial_origem		  , &
										ls_razao_social		  , &
										ls_cgc_ori				  , &
										ls_endereco_ori		  , &
										ls_bairro_ori			  , &
										ls_cep_ori				  , &
										ls_municipio_ori		  , &
										ls_fone_ori				  , &
										ls_fax					  , &	
										ls_uf_ori				  , &
										ls_inscr_est_ori)

// Filial Destino
Selecionar_Informacoes_Filial(a_filial_Origem                           , &
										ls_razao_social		   						, &
										ls_cgc_dest				   						, &
										ls_endereco_dest		   						, &
										ls_bairro_dest			   						, &
										ls_cep_dest				   						, &
										ls_municipio_dest		   						, &
										ls_fone_dest										, &
										ls_fax												, & 
										ls_uf_dest				   						, &
										ls_inscr_est_dest)

//Dados adicionais NSU
If a_data_movimento >= datetime(date("2007/07/01")) Then
	ls_dados_adicionais_1 = 'NSU: '+string(a_nr_nsu)+' em'
	ls_dados_adicionais_2 = string(a_data_emissao,'dd/mm/yyyy hh:mm')
	Imprimir_Dados_Adicionais(ls_dados_adicionais_1)
	Imprimir_Dados_Adicionais(ls_dados_adicionais_2)
End If

Imprimir_Cabecalho_ICMS("Operador: " + operador       , &
						 ""											, &
						 ls_endereco_ori							, &
						 ls_bairro_ori								, &
						 ls_municipio_ori							, &
						 ls_uf_ori									, &
						 ls_fone_ori								, &
						 ls_cep_ori									, &
						 ls_nulo										, &
						 a_nr_nf										, &
						 "LANC. CREDITO ATIVO"              , &
						 "IMOBILIZADO"     				      , &
						 1604  										, &
						 ls_nulo										, &
						 ls_cgc_ori									, &
						 ls_inscr_est_ori							, &
						 ls_razao_social							, &
						 ls_cgc_dest								, &
						 ls_endereco_dest							, &
						 ls_bairro_dest							, &
						 ls_cep_dest								, &
						 ls_municipio_dest						, &
						 ls_fone_dest								, &
						 ls_uf_dest									, &
						 ls_inscr_est_dest						, &
						 a_data_movimento                   , &
						 ld_nulo										, &
						 ld_nulo)

ll_insert = ids_report_nf.InsertRow(0)

ls_mensagem = ""
ids_report_nf.Object.mensagem		[ll_insert] = ls_mensagem  

Imprimir_Ds(ids_report_nf)
end subroutine

public subroutine selecionar_dados_adicionais (long a_filial_origem, long a_nr_nf, string a_especie, string a_serie, ref string a_dados_adicionais_1, ref string a_dados_adicionais_2, ref string a_dados_adicionais_3, ref string a_dados_adicionais_4, ref string a_dados_adicionais_5, ref string a_dados_adicionais_6, ref string a_dados_adicionais_7, ref string a_dados_adicionais_8);Select de_dados_adicionais_1,
		 de_dados_adicionais_2,
		 de_dados_adicionais_3,
		 de_dados_adicionais_4,
		 de_dados_adicionais_5,
		 de_dados_adicionais_6,
		 de_dados_adicionais_7,
		 de_dados_adicionais_8
Into :a_dados_adicionais_1,&
     :a_dados_adicionais_2,&
	  :a_dados_adicionais_3,&
	  :a_dados_adicionais_4,&
	  :a_dados_adicionais_5,&
	  :a_dados_adicionais_6,&
	  :a_dados_adicionais_7,&
	  :a_dados_adicionais_8
	  
From nf_diversa
Where cd_filial_origem = :a_filial_origem
  and nr_nf            = :a_nr_nf
  and de_especie       = :a_especie
  and de_serie         = :a_serie
Using Sqlca;

Choose Case Sqlca.Sqlcode
	Case -1	
		Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o de dados adicionais da nota fiscal.")
	Case 100	
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Localiza$$HEX2$$e700e300$$ENDHEX$$o de dados adicionais da nota fiscal.",StopSign!)
End Choose	

If IsNull(a_dados_adicionais_1) Then a_dados_adicionais_1 = ''
If IsNull(a_dados_adicionais_2) Then a_dados_adicionais_2 = ''
If IsNull(a_dados_adicionais_3) Then a_dados_adicionais_3 = ''
If IsNull(a_dados_adicionais_4) Then a_dados_adicionais_4 = ''
If IsNull(a_dados_adicionais_5) Then a_dados_adicionais_5 = ''
If IsNull(a_dados_adicionais_5) Then a_dados_adicionais_6 = ''
If IsNull(a_dados_adicionais_5) Then a_dados_adicionais_7 = ''
If IsNull(a_dados_adicionais_5) Then a_dados_adicionais_8 = ''

Return 
end subroutine

public function boolean of_inclui_nf_venda_nfe (long al_filial, long al_nota, string as_especie, string as_serie);If as_Especie <> 'NFE' Then Return True

Insert Into nf_venda_nfe(cd_filial, nr_nf, de_especie, de_serie)  
Values (:al_Filial, :al_Nota, :as_Especie, :as_Serie)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDBError("Inclus$$HEX1$$e300$$ENDHEX$$o da NF_VENDA_ANEXA")
	Return False
End If

Return True
end function

public function boolean of_mensagem_impressao_nfe (string as_especie);If as_Especie = 'NFE' Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nota fiscal eletr$$HEX1$$f400$$ENDHEX$$nica.~r~r" + "A nota dever$$HEX1$$e100$$ENDHEX$$ ser impressa pelo sistema da NFE ap$$HEX1$$f300$$ENDHEX$$s ser autorizada pelo SEFAZ.", Exclamation!)
	Return False
End If

Return True
end function

public function boolean of_verifica_dados_cliente (string as_cliente);String lvs_Cliente, lvs_CPF, lvs_Endereco, lvs_Numero, lvs_Bairro, lvs_CEP, lvs_DDD, lvs_Fone, lvs_IBGE, lvs_Telefone

Long lvl_Cidade, lvl_Tamanho_CGC

SELECT cliente.nm_cliente,   
         cliente.nr_cpf_cgc,   
         cliente.cd_cidade,   
         cliente.de_endereco,   
         cliente.nr_endereco,   
         cliente.de_bairro,   
         cliente.nr_cep,   
         cliente.nr_ddd_fone_residencial,   
         cliente.nr_fone_residencial,
		 cidade.cd_cidade_ibge
    INTO :lvs_Cliente,
		 :lvs_CPF,
		 :lvl_Cidade,
		 :lvs_Endereco, 		 
		 :lvs_Numero,		 
		 :lvs_Bairro, 		 
		 :lvs_CEP,  
		 :lvs_DDD, 
		 :lvs_Fone,
		 :lvs_IBGE
    FROM cliente
	 		LEFT OUTER JOIN cidade 
			  ON cidade.cd_cidade = cliente.cd_cidade
	WHERE cd_cliente =:as_cliente	 
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do cliente '" + as_Cliente + "'")
		Return False
	End If
	
	If SqlCa.SqlCode = 100 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cliente n$$HEX1$$e300$$ENDHEX$$o localizado '" + as_Cliente + "'.", StopSign!)
		Return False
	End If
		
	If Isnull(lvs_Cliente) or Trim(lvs_Cliente) = '' Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O nome do cliente '" + as_Cliente + "' n$$HEX1$$e300$$ENDHEX$$o foi informado.~r~r" +&
		"A informa$$HEX2$$e700e300$$ENDHEX$$o deve ser corrigida antes da gera$$HEX2$$e700e300$$ENDHEX$$o da NFE.", StopSign!)
		Return False
	End If
	
//	If Mid(lvs_Cliente,1,1) = ' ' Then
//		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O nome do cliente '" + as_Cliente + "' esta com espa$$HEX1$$e700$$ENDHEX$$os em branco.~r~r" +&
//		"A informa$$HEX2$$e700e300$$ENDHEX$$o deve ser corrigida antes da gera$$HEX2$$e700e300$$ENDHEX$$o da NFE.", StopSign!)
//		Return False
//	End If
	
	lvl_Tamanho_CGC = LenA(lvs_CPF)
	
	If lvl_Tamanho_CGC = 11 Then
		If Not gf_nr_cpf_valido(lvs_CPF) Then
			Return False
		End If
	ElseIf lvl_tamanho_CGC = 14 Then
		If Not gf_cgc_valido(lvs_CPF)Then
			Return False
		End If
	Else
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O CPF do cliente '" + as_Cliente + "' n$$HEX1$$e300$$ENDHEX$$o foi informado ou esta incorreto.", StopSign!)		
		Return False
	End If
	
	If isnull(lvl_Cidade) Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A cidade do cliente '" + as_Cliente + "' n$$HEX1$$e300$$ENDHEX$$o foi informada.~r~r" +&
							  "A informa$$HEX2$$e700e300$$ENDHEX$$o deve ser corrigida antes da gera$$HEX2$$e700e300$$ENDHEX$$o da NFE.", StopSign!)
	  	Return False
	End If
	
	If Isnull(lvs_IBGE) Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O c$$HEX1$$f300$$ENDHEX$$digo do IBGE da cidade do cliente '" + as_Cliente + "' n$$HEX1$$e300$$ENDHEX$$o foi informado.~r~r" +&
				  "A informa$$HEX2$$e700e300$$ENDHEX$$o deve ser corrigida antes da gera$$HEX2$$e700e300$$ENDHEX$$o da NFE.", StopSign!)
	    Return False
	End If
		
	If Isnull(lvs_Endereco) or Trim(lvs_Endereco) = '' Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O endere$$HEX1$$e700$$ENDHEX$$o do cliente '" + as_Cliente + "' n$$HEX1$$e300$$ENDHEX$$o foi informado.~r~r" +&
		"A informa$$HEX2$$e700e300$$ENDHEX$$o deve ser corrigida antes da gera$$HEX2$$e700e300$$ENDHEX$$o da NFE.", StopSign!)
		Return False
	End If
	
//	If Mid(lvs_Endereco,1,1) = ' ' Then
//		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O endere$$HEX1$$e700$$ENDHEX$$o do cliente '" + as_Cliente + "' esta com espa$$HEX1$$e700$$ENDHEX$$os em branco.~r~r" +&
//		"A informa$$HEX2$$e700e300$$ENDHEX$$o deve ser corrigida antes da gera$$HEX2$$e700e300$$ENDHEX$$o da NFE.", StopSign!)
//		Return False
//	End If
	
//	If Isnull(lvs_Numero) or Trim(lvs_Numero) = '' Then
//		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O n$$HEX1$$fa00$$ENDHEX$$mero do endere$$HEX1$$e700$$ENDHEX$$o do cliente '" + as_Cliente + "' n$$HEX1$$e300$$ENDHEX$$o foi informado.~r~r" +&
//		"A informa$$HEX2$$e700e300$$ENDHEX$$o deve ser corrigida antes da gera$$HEX2$$e700e300$$ENDHEX$$o da NFE.", StopSign!)
//		Return False
//	End If
		
	If Isnull(lvs_Bairro) or Trim(lvs_Bairro) = '' Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O bairro do cliente '" + as_Cliente + "' n$$HEX1$$e300$$ENDHEX$$o foi informado.~r~r" +&
		"A informa$$HEX2$$e700e300$$ENDHEX$$o deve ser corrigida antes da gera$$HEX2$$e700e300$$ENDHEX$$o da NFE.", StopSign!)
		Return False
	End If
	
//	If Mid(lvs_Bairro,1,1) = ' ' Then
//		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O bairro do cliente '" + as_Cliente + "' esta com espa$$HEX1$$e700$$ENDHEX$$os em branco.~r~r" +&
//		"A informa$$HEX2$$e700e300$$ENDHEX$$o deve ser corrigida antes da gera$$HEX2$$e700e300$$ENDHEX$$o da NFE.", StopSign!)
//		Return False
//	End If
	
	lvs_CEP = gf_Replace(lvs_CEP, ' ', '', 0)
	lvs_CEP = gf_Replace(lvs_CEP, '.', '', 0)
	lvs_CEP = gf_Replace(lvs_CEP, '-', '', 0)
	
	If Isnull(lvs_CEP) or Trim(lvs_CEP) = '' Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O CEP do cliente '" + as_Cliente + "' n$$HEX1$$e300$$ENDHEX$$o foi informado.~r~r" +&
		"A informa$$HEX2$$e700e300$$ENDHEX$$o deve ser corrigida antes da gera$$HEX2$$e700e300$$ENDHEX$$o da NFE.", StopSign!)
		Return False
	End If
	
	If LenA(Trim(lvs_CEP)) <> 8 Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O CEP do cliente '" + as_Cliente + "' $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido.~r~r" +&
		"A informa$$HEX2$$e700e300$$ENDHEX$$o deve ser corrigida antes da gera$$HEX2$$e700e300$$ENDHEX$$o da NFE.", StopSign!)
		Return False
	End If
	
	lvs_Telefone = lvs_DDD + lvs_Fone
	
//	If Not gf_Valida_Telefone(lvs_Telefone) Then
//		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O telefone do cliente '" + as_Cliente + "' $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido.~r~r" +&
//		"A informa$$HEX2$$e700e300$$ENDHEX$$o deve ser corrigida antes da gera$$HEX2$$e700e300$$ENDHEX$$o da NFE.", StopSign!)
//		Return False
//	End If
				
	Return True

end function

public function boolean of_ultima_versao_nfe (ref long pl_versao_nfe);String lvs_Versao

Select nr_versao
Into :lvs_Versao
From sistema
Where cd_sistema = 'NF'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(lvs_Versao) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o n$$HEX1$$fa00$$ENDHEX$$mero da vers$$HEX1$$e300$$ENDHEX$$o da NFE.")
		Else
			pl_versao_nfe = Long(gf_Replace(lvs_Versao, '.', '',0))
			Return True
		End If		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o n$$HEX1$$fa00$$ENDHEX$$mero da vers$$HEX1$$e300$$ENDHEX$$o da NFE.")
	Case -1
		SqlCa.of_MsgDbError("Erro ao localizar o n$$HEX1$$fa00$$ENDHEX$$mero da vers$$HEX1$$e300$$ENDHEX$$o do sistema da NFE.")
End Choose

Return False


end function

public function boolean of_nat_operacao_nf_anexa (string as_uf_filial, string as_uf_dados_adicionais, string as_cliente, ref long al_nat_operacao, ref string as_erro);String ls_UF_Cliente

If Not IsNull( as_cliente ) Then
	Select i.cd_unidade_federacao
	Into :ls_UF_Cliente
	From cliente c, cidade i
	Where i.cd_cidade		= c.cd_cidade
		and c.cd_cliente = :as_Cliente
	Using SqlCa;
	
	Choose Case Sqlca.SqlCode
		Case 100
			as_erro = "UF do destinat$$HEX1$$e100$$ENDHEX$$rio CLIENTE n$$HEX1$$e300$$ENDHEX$$o foi localizada."
			Return False
		Case -1
			as_erro = "Localiza$$HEX2$$e700e300$$ENDHEX$$o da UF do destinat$$HEX1$$e100$$ENDHEX$$rio CLIENTE. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_nat_operacao_anexa. " + SqlCa.SqlErrText
			Return False
	End Choose
Else
	//UF preenchida nos dados adicionais cliente
	ls_UF_Cliente = as_uf_dados_adicionais 
End If

If IsNull( ls_UF_Cliente ) Then
	as_erro = "UF do destinat$$HEX1$$e100$$ENDHEX$$rio CLIENTE n$$HEX1$$e300$$ENDHEX$$o foi localizada."
	Return False
End If

// Alterado S$$HEX1$$e900$$ENDHEX$$rgio 19/07/2012
If ls_UF_Cliente = as_UF_Filial Then
	al_nat_operacao = 5929  //Alterado Fernando 20/10/2004
Else
	al_nat_operacao = 6929
End If

Return True
end function

public function string of_cst_origem_produto (long pl_produto);String ls_Origem

Try
	uo_Produto lo
	lo = Create uo_Produto
	
	lo.of_Localiza_Codigo_Interno( pl_Produto )
	
	If lo.Localizado Then
		ls_Origem = lo.cd_st_origem
	End If
	
Finally
	If IsValid( lo ) Then Destroy lo
	Return ls_Origem
End Try
end function

public subroutine of_emitir_nf_anexa (long pl_filial, long pl_nota, string ps_especie_cf, string ps_serie_cf, string ps_especie_nf, string ps_serie_nf, string ps_operador);LONG lvl_cupom, &
     	lvl_Nr_Nf, &
		lvl_null,  &
		lvl_row,   &
		lvl_max_itens, &
		lvl_max_reg , &
		lvl_nr_nsu,&
		lvl_NatOp
			
//Long lvl_Versao_NFE
Long ll_Retrieve_Cupom
Long ll_Retrieve_Itens
Long ll_Produto

			
STRING	ls_aux, &
         	lvs_De_Especie_Nf, &
			lvs_De_Serie_Nf

String ls_nulo
String ls_Msg
String ls_Cliente
String ls_UF_Filial
String ls_UF_Dados_Adicionais

String ls_Beneficio

Boolean lb_sucesso

DateTime lvdth_Movimento, &
         		lvdth_Emissao
			 

//If ps_Especie_CF <> 'CF' Then Return

SETNULL(lvl_null)
SETNULL(ls_nulo)

Try
		
	// Verifica se o cupom j$$HEX1$$e100$$ENDHEX$$ gerou uma Nota fiscal
	If Not of_Verifica_Cupom(pl_filial,pl_Nota,ps_especie_cf,ps_serie_cf) Then Return
	
	// Se a vers$$HEX1$$e300$$ENDHEX$$o do sistema da NFE for maior que a 2.22 a anexa ter$$HEX1$$e100$$ENDHEX$$ a base e valor do ICMS zerado
	//If Not of_ultima_versao_nfe(Ref lvl_Versao_NFE) Then Return

	dc_uo_ds_base lvds_Cupom 
	dc_uo_ds_base lvds_Itens 
	dc_uo_ds_Base lvds_Dados_Nota
	dc_uo_ds_base lvds_Registro
	
	lvds_Cupom 		= Create dc_uo_ds_base
	lvds_Itens 			= Create dc_uo_ds_base
	lvds_Dados_Nota 	= Create dc_uo_ds_Base
	lvds_Registro 		= Create dc_uo_ds_base
	
	If Not lvds_Cupom.of_ChangeDataObject( "ds_faturamento_Notas_fiscais_anexas" ) Then
		ls_Msg = "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o DataChangedObject, DS: ds_faturamento_Notas_fiscais_anexas."
		Return
	End If

	If Not lvds_Itens.of_ChangeDataObject( "ds_faturamento_Notas_fiscais_anexas_item" ) Then
		ls_Msg = "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o DataChangedObject, DS: ds_faturamento_Notas_fiscais_anexas_item."
		Return
	End If

	If Not lvds_Dados_Nota.of_ChangeDataObject("dw_nf_venda_loja") Then
		ls_Msg = "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o DataChangedObject, DS: dw_nf_venda_loja."
		Return
	End If
	
	If Not lvds_Registro.of_ChangeDataObject("ds_registro_produtos_manipulados_nf_anex") Then
		ls_Msg = "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o DataChangedObject, DS: ds_registro_produtos_manipulados_nf_anex."
		Return
	End If

	// L$$HEX1$$ea00$$ENDHEX$$ Nf, e verifica se existe nota digitada
	ll_Retrieve_Cupom =  lvds_Cupom.Retrieve(pl_filial, &
								 pl_Nota, &
								 ps_especie_cf, &
								 ps_serie_cf)
	
	If ll_Retrieve_Cupom < 0 Then
		ls_Msg = "Erro no Retrieve, DS: ds_faturamento_Notas_fiscais_anexas. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_emitir_nf_anexa.~r" + lvds_Cupom.ivo_dbError.of_Msg_Sybase()
		Return
	ElseIf ll_Retrieve_Cupom = 0 Then
		ls_Msg = "Cupom Fiscal Inexistente."
		Return 
	End If

	// Verifica se a Nota est$$HEX1$$e100$$ENDHEX$$ cancelada. Caso esteja cancela o processamento
	If Not IsNull(lvds_Cupom.Object.dh_cancelamento [1]) Then
		ls_Msg = "Cupom Fiscal cancelado."
		Return 
	End If

	If lvds_Cupom.Object.id_cancelamento_impressora[1] = 'S' Then
		ls_Msg = "Cupom Fiscal cancelado na impressora fiscal."
		Return 
	End If

	// L$$HEX1$$ea00$$ENDHEX$$ os itens da Nf
	ll_Retrieve_Itens = lvds_Itens.Retrieve(	pl_filial , &
														 pl_Nota, &
														 ps_especie_cf , &
														 ps_serie_cf)
	
	If ll_Retrieve_Itens < 0 Then
		ls_Msg = "Erro no Retrieve, DS: ds_faturamento_Notas_fiscais_anexas_item. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_emitir_nf_anexa.~r" + lvds_Itens.ivo_dbError.of_Msg_Sybase()
		Return
	ElseIf ll_Retrieve_Cupom = 0 Then
		ls_Msg = "Itens n$$HEX1$$e300$$ENDHEX$$o localizados para impress$$HEX1$$e300$$ENDHEX$$o da Nota Fiscal."
		Return 
	End If
							 
	// Copia o corpo da Nota Fiscal, utiliza a mesma datastore, copia para segunda linha
	lvds_Cupom.RowsCopy(1, 1, Primary!, lvds_Cupom, 2, Primary!)

	ls_Cliente = lvds_Cupom.Object.cd_cliente [1]
	
	If IsNull( ls_Cliente ) Then
		If IsNull( ls_Cliente ) Then ls_Cliente = ''
		
		ls_aux = STRING(pl_filial) 	+ "|" +&
					STRING(pl_Nota)   + "|" +&
					ps_especie_cf     	+ "|" +&
					ps_serie_cf
							
		OpenWithParm(w_ge033_dados_adicionais_cliente, ls_aux)
		
		ls_UF_Dados_Adicionais = Message.StringParm
		If IsNull( ls_UF_Dados_Adicionais ) Then Return
	End If
	
	//******* Sempre ser$$HEX1$$e100$$ENDHEX$$ uma opera$$HEX2$$e700e300$$ENDHEX$$o interna - ESTADUAL ************ 
	lvl_NatOp = 5929  
								
	If lvds_Dados_Nota.Retrieve( pl_filial , &
										pl_nota, &
										ps_especie_cf, &
										ps_serie_cf) < 0 Then
		ls_Msg = "Erro no Retrieve, DS: dw_nf_venda_loja. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_emitir_nf_anexa.~r" + lvds_Dados_Nota.ivo_dbError.of_Msg_Sybase()
		Return
	End If

	lvds_Dados_Nota.RowsCopy(1, 1, Primary!, lvds_Dados_Nota, 2, Primary!)

	// Altera n$$HEX1$$fa00$$ENDHEX$$mero Nf, s$$HEX1$$e900$$ENDHEX$$rie e esp$$HEX1$$e900$$ENDHEX$$cie para os parametros da Nota Fiscal
	lvl_Nr_Nf				= gvo_Parametro.of_Proxima_NF()
	lvdth_Movimento 	= gvo_Parametro.of_Dh_Movimentacao()
	lvdth_Emissao   	= gf_getserverdate()

	If lvl_Nr_Nf = 0 Then 
		ls_Msg = "Erro ao localizar n$$HEX1$$fa00$$ENDHEX$$mero da pr$$HEX1$$f300$$ENDHEX$$xima Nota Fiscal."
		Return 
	End If

	// Busca pr$$HEX1$$f300$$ENDHEX$$ximo NSU
	lvl_nr_nsu = 0

	If this.of_Proximo_NSU(lvl_nr_nsu) = False Then
		SqlCa.of_RollBack()
		ls_Msg = "Erro ao localizar n$$HEX1$$fa00$$ENDHEX$$mero do pr$$HEX1$$f300$$ENDHEX$$ximo NSU."
		Return 
	End If

	If lvds_Cupom.RowCount() > 1 Then
		
		// Altera valores Corpo Nota
		lvds_Cupom.Object.Nr_Nf                				[2] = lvl_Nr_Nf
		lvds_Cupom.Object.De_Especie           			[2] = ps_Especie_Nf
		lvds_Cupom.Object.De_Serie             			[2] = ps_Serie_Nf
		lvds_Cupom.Object.Dh_Movimentacao_Caixa	[2] = lvdth_Movimento
		lvds_Cupom.Object.Dh_Emissao           			[2] = lvdth_Emissao
		
		lvds_Cupom.Object.Nr_Nf_anexa      				[2] = lvds_Cupom.Object.Nr_Nf      	[1]
		lvds_Cupom.Object.De_Especie_anexa 			[2] = lvds_Cupom.Object.De_Especie	[1]
		lvds_Cupom.Object.De_Serie_anexa   			[2] = lvds_Cupom.Object.De_Serie   	[1]
		
		lvds_Cupom.Object.Nr_ecf           					[2] = lvl_null
		lvds_Cupom.Object.Nr_operacao_ecf  			[2] = lvl_null
		
		//Wagner 17/08/15
		//Alterado conforme chamado nr: 90333
		lvds_Cupom.Object.cd_condicao_convenio		[2] = lvl_null
		lvds_Cupom.Object.cd_convenio   					[2] = lvl_null
		lvds_Cupom.Object.cd_conveniado				[2] = ls_nulo
		
		lvds_Cupom.Object.Nr_nsu           				[2] = lvl_nr_nsu
		
		lvds_Cupom.Object.vl_bc_icms	[2] = 0.00
		lvds_Cupom.Object.vl_icms		[2] = 0.00
		
		If Not IsNull( ps_Operador ) Then
			lvds_Cupom.Object.nr_matric_operador[ 2 ] = ps_Operador
		End If
	End If

	If lvds_Dados_Nota.RowCount() > 1 Then
		lvds_Dados_Nota.Object.Nr_Nf     		[2] = lvl_Nr_Nf
		lvds_Dados_Nota.Object.De_Especie	[2] = ps_Especie_Nf
		lvds_Dados_Nota.Object.De_Serie  	[2] = ps_Serie_Nf
	End If
	
	uo_Produto lo_Produto
	lo_Produto = Create uo_produto				
	
	For lvl_row = 1 To ll_Retrieve_Itens
		SetNull(ls_Beneficio)

		lvds_Itens.RowsCopy (lvl_row, lvl_row, Primary!, lvds_Itens , lvds_Itens.RowCount() + 1 , Primary!)
		
		ll_Produto = lvds_Itens.Object.cd_produto [lvds_Itens.RowCount()]
		
		//Verifica$$HEX2$$e700e300$$ENDHEX$$o se produto tem codigo SAP, sen$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o tem n$$HEX1$$e300$$ENDHEX$$o permite gera$$HEX2$$e700e300$$ENDHEX$$o Nota.
		lo_produto.of_localiza_codigo_interno( ll_produto )		
		If lo_produto.localizado Then
			If IsNull(lo_produto.cd_produto_sap) Or Trim(lo_produto.cd_produto_sap) = '' Then
				SqlCa.of_RollBack()
				ls_Msg = "Produto " + String(ll_produto) + " sem c$$HEX1$$f300$$ENDHEX$$digo SAP. Emiss$$HEX1$$e300$$ENDHEX$$o de nota n$$HEX1$$e300$$ENDHEX$$o permitida!"
				Return 				
			End If
		Else
			SqlCa.of_RollBack()
			ls_Msg = "Produto " + String(ll_produto) + " n$$HEX1$$e300$$ENDHEX$$o localizado!"
			Return 							
		End If
		
		If lvds_Itens.Object.cd_situacao_tributaria	[lvds_Itens.RowCount()] = '00' Then				
			lvds_Itens.Object.cd_situacao_tributaria	[lvds_Itens.RowCount()] = '04'
			lvds_Itens.Object.pc_icms					[lvds_Itens.RowCount()] = 0.00
			lvds_Itens.Object.cd_cst_origem			[lvds_Itens.RowCount()] = This.of_CST_Origem_Produto( ll_Produto )
			lvds_Itens.Object.cd_cst_tributacao		[lvds_Itens.RowCount()] = '41'
		End If	
	
		If lvds_Itens.Object.cd_situacao_tributaria	[lvds_Itens.RowCount()] = '04' Then
			Try
				uo_tratamento_fiscal lo_Tratamento_fiscal
				lo_Tratamento_fiscal = Create uo_tratamento_fiscal
																										//UF da Filial				
				ls_Beneficio = lo_Tratamento_fiscal.of_retorna_codigo_beneficio(  GVO_PARAMETRO.ivs_uf_filial, &
																									  lvl_NatOp, &
																									  lvds_Itens.Object.cd_cst_origem				[lvds_Itens.RowCount()], & 
																									  lvds_Itens.Object.cd_cst_tributacao			[lvds_Itens.RowCount()], &
																									  ll_Produto )
			Finally
				If IsValid(lo_Tratamento_fiscal) Then Destroy lo_Tratamento_fiscal
			End Try
		End If
		
		lvds_Itens.Object.Nr_Nf               					[lvds_Itens.RowCount()] = lvl_Nr_Nf
		lvds_Itens.Object.De_Especie          				[lvds_Itens.RowCount()] = ps_Especie_Nf
		lvds_Itens.Object.De_Serie            				[lvds_Itens.RowCount()] = ps_Serie_Nf	
		lvds_Itens.Object.Cd_Natureza_operacao		[lvds_Itens.RowCount()] = lvl_NatOp 
		lvds_Itens.Object.cd_beneficio      					[lvds_Itens.RowCount()] = ls_Beneficio
		If IsNull(lvds_Itens.Object.nr_item[lvds_Itens.RowCount()]) Or lvds_Itens.Object.nr_item[lvds_Itens.RowCount()] = 0 Then
			lvds_Itens.Object.nr_item[lvds_Itens.RowCount()] = lvl_row 
		End If
	Next

	// Copia Registro dos produtos manipulados
	lvl_max_reg = lvds_Registro.Retrieve (pl_filial, &
													  pl_Nota,&
													  ps_especie_cf, &
													  ps_serie_cf)
													
	If lvl_max_reg < 0 Then
		ls_Msg = "Erro no Retrieve, DS: ds_registro_produtos_manipulados_nf_anex.~r" + lvds_Registro.ivo_dbError.of_Msg_Sybase()
		Return
	End If

	For lvl_row = 1 TO lvl_max_reg
		
		lvds_Registro.RowsCopy (lvl_row, lvl_row, Primary!, lvds_Registro , lvds_Registro.RowCount() + 1 , Primary!)
		
		lvds_Registro.Object.Nr_Nf      						[lvds_Registro.RowCount()] = lvl_Nr_Nf
		lvds_Registro.Object.De_Especie 					[lvds_Registro.RowCount()] = ps_Especie_Nf
		lvds_Registro.Object.De_Serie   					[lvds_Registro.RowCount()] = ps_Serie_Nf	
		lvds_Registro.Object.Cd_Natureza_Operacao 	[lvds_Registro.RowCount()] = lvl_NatOp
		
	Next

	lb_sucesso = False
	If lvds_Cupom.Update() <> -1 Then
		If lvds_Dados_Nota.Update() <> -1 Then
			If lvds_Itens.Update() <> - 1 Then
				If lvds_Registro.Update() <> -1 Then
					If of_Inclui_NF_Venda_NFE(pl_filial,lvl_Nr_Nf,ps_Especie_Nf,ps_Serie_Nf) Then
						SQLCA.of_Commit() 
						
						// Se for NFE vai mostrar a mensagem e retornar como falso
						// N$$HEX1$$e300$$ENDHEX$$o vai imprimir a NFE
						If This.of_Mensagem_Impressao_NFE(ps_Especie_nf) Then
							Emitir_Nf_Venda(pl_filial,lvl_Nr_Nf,ps_Especie_Nf,ps_Serie_Nf)	
						End If
						
						lb_sucesso = True
					End If
				End If
			End If
		End If
	End If

	If Not lb_Sucesso Then 
		SQLCA.of_RollBack()
		ls_msg = "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o dos dados para impress$$HEX1$$e300$$ENDHEX$$o da Nota Fiscal."
	End If

Finally
	If IsValid(lvds_Cupom) 		Then Destroy lvds_Cupom
	If IsValid(lvds_Itens) 			Then Destroy lvds_Itens
	If IsValid(lvds_Registro) 		Then Destroy lvds_Registro
	If IsValid(lvds_Dados_Nota) Then Destroy lvds_Dados_Nota
	If IsValid(lo_Produto) 			Then Destroy(lo_Produto)
	
	If Not IsNull( ls_Msg ) And Trim(ls_msg) <> "" Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_msg, StopSign!)
	
End Try


end subroutine

event constructor;//
ids_report_nf			= CREATE dc_uo_ds_base
ids_itens_nf				= CREATE dc_uo_ds_base
ids_produto_manip	= CREATE dc_uo_ds_base
ids_mensagem_fiscal	= CREATE dc_uo_ds_base
//
end event

on uo_nota_fiscal.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_nota_fiscal.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//
Destroy ids_report_nf
Destroy ids_itens_nf
Destroy ids_produto_manip
Destroy ids_mensagem_fiscal
//Destroy ivo_conexao
//

end event

