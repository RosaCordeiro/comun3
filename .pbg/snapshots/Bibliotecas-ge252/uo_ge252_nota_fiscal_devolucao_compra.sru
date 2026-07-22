HA$PBExportHeader$uo_ge252_nota_fiscal_devolucao_compra.sru
forward
global type uo_ge252_nota_fiscal_devolucao_compra from nonvisualobject
end type
end forward

global type uo_ge252_nota_fiscal_devolucao_compra from nonvisualobject
end type
global uo_ge252_nota_fiscal_devolucao_compra uo_ge252_nota_fiscal_devolucao_compra

type variables
Boolean ib_Processo_Motivo_Transporte_Canc = False

Long il_Filial[], il_Nota[], il_Produto[], il_Qtde_Devolver[], il_Sequencial[], il_Nr_Controle[]

Long il_Motivo_Devolucao, il_Qtde_Volume, il_Agrupamento, il_nr_integracao, il_nr_nf_ant

String is_Fornecedor[], is_Especie[], is_Serie[], is_Lote[], is_Endereco[], is_Lote_Nota[], is_fornecedor_ant, is_serie_ant, is_de_especie_ant, is_Motivo_Devolucao_ant

String is_Operador, is_Motivo_Devolucao, is_Numero_Volume, is_Marca_Volume, is_Especie_Volume, is_Descricao_Endereco_WMS

String is_Obs_NF

String is_Chave_Movimento[]

Date idh_Validade[]

Decimal{2} idc_BC_ICMS_ST, idc_ICMS_ST, idc_BC_ICMS, idc_ICMS, idc_BC_IPI, idc_IPI, idc_Outras_Despesas 

Decimal {2} idc_BC_ICMS_ST_DA, idc_ICMS_ST_DA

Decimal idc_Total_Produtos, idc_Total_Desconto

Decimal{3} idc_peso_bruto, idc_peso_liquido


// Dados para Transporte
String is_Transp_Codigo

Boolean ib_Iniciado_Operacao_SAP = false


// Feito para Testar
//  idc_VALIDA_ICMS_TOTAL 	=  Acumula os valores do campo :  lds_Devolucao_PRD.Object.vl_icms_total
//  idc_VALIDA_ICMS  			=  Acumula os valores do campo :  lds_Devolucao_PRD.Object.vl_icms
//	idc_ICMS_AUX					= 	Feito para Valida$$HEX2$$e700e300$$ENDHEX$$o
Decimal{2} idc_VALIDA_ICMS_TOTAL ,  idc_VALIDA_ICMS, idc_ICMS_AUX

Boolean ivb_Valida_Inventario = False 
Boolean ivb_Endereco_Bloqueado = False 


end variables

forward prototypes
public function boolean of_verifica_icms_st (string as_situacao_tributaria, ref string as_icms_st, ref string as_mensagem)
public function boolean of_uf_fornecedor (ref string as_uf, ref string as_mensagem)
public function boolean of_grava_nota (long al_nota, string as_especie, string as_serie, ref string as_mensagem)
public function boolean of_proxima_nota (ref long al_nota, ref string as_especie, ref string as_serie)
public function boolean of_atualiza_motivo_dev_dados_transp (long al_nota, string as_especie, string as_serie, string as_mensagem)
public function boolean of_grava_nota (datastore ads_produtos, ref long al_nota, ref string as_erro)
public function boolean of_processa_geracao_nota (ref long al_nota, ref string as_erro)
public function boolean of_atualiza_segregado_recebimento (string as_endereco, string as_fornecedor, long al_nota, string as_especie, string as_serie, long al_produto, string as_lote, date adt_validade, long al_qtde_devolvida, long al_nr_controle, ref string as_mensagem)
public function boolean of_localiza_fornecedor_dev_compra (string as_fornecedor, ref string as_fornecedor_dev_compra, ref string as_erro)
end prototypes

public function boolean of_verifica_icms_st (string as_situacao_tributaria, ref string as_icms_st, ref string as_mensagem);Select id_icms_st 
into :as_ICMS_ST
From tributacao_icms
Where cd_tributacao_icms =:as_situacao_tributaria
Using SqlCa;

Choose Case Sqlca.Sqlcode
	Case 0
		Return True
	Case 100
		as_Mensagem = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar a tributa$$HEX2$$e700e300$$ENDHEX$$o ICMS '" + as_Situacao_Tributaria + "'."
	Case -1
		as_Mensagem = "Erro ao localizar a tributa$$HEX2$$e700e300$$ENDHEX$$o de ICMS '" + SQLCA.SQLErrText + "'."
End Choose

Return False

end function

public function boolean of_uf_fornecedor (ref string as_uf, ref string as_mensagem);String	lvs_Fornecedor

lvs_Fornecedor = is_Fornecedor[1]

Select cd_unidade_federacao 
Into :as_UF
From cidade
Where cd_cidade in (select cd_cidade
								 from fornecedor
								 where cd_fornecedor = :lvs_Fornecedor)
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0		
		Return True
	Case 100
		as_Mensagem = "Unidade de Federa$$HEX2$$e700e300$$ENDHEX$$o do fornecedore n$$HEX1$$e300$$ENDHEX$$o localizada."
	Case -1
		as_Mensagem = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da Unidade de Federa$$HEX2$$e700e300$$ENDHEX$$o do fornecedor '" + SQLCA.SQLErrText + "'."
End Choose

Return False
end function

public function boolean of_grava_nota (long al_nota, string as_especie, string as_serie, ref string as_mensagem);Decimal ldc_Valor_NF

Date ldh_Movimento
DateTime	ldt_dh_emissao
Long	ll_Nota_Compra,&
		ll_Motivo_Devolucao

String	ls_Fornecedor,&
		ls_Especie_Compra,&
		ls_Serie_Compra,&
		ls_Dados_Adicionais,&
		ls_Fornecedor_Dev_Compra, &
		ls_de_dados_adicionais

ls_Fornecedor 			=	is_Fornecedor	[1]
ll_Nota_Compra 		=	il_Nota			[1]
ls_Especie_Compra		=	is_Especie		[1]
ls_Serie_Compra		=	is_Serie			[1]

ldc_Valor_NF = (idc_Total_Produtos - idc_Total_Desconto) +  idc_ICMS_ST + idc_IPI + idc_Outras_Despesas

ldh_Movimento = Date(gf_GetServerDate())

is_Operador = gvo_Aplicacao.ivo_Seguranca.nr_matricula

If Not Isnull(idc_BC_ICMS_ST_DA) and idc_BC_ICMS_ST_DA > 0 Then
	ls_Dados_Adicionais = 'BC ST: ' + String(idc_BC_ICMS_ST_DA) + '   VL ST: ' + String(idc_ICMS_ST_DA)
End If

If Not IsNull(is_Obs_NF) and Trim(is_Obs_NF) <> '' Then
	If Not Isnull(ls_Dados_Adicionais) and Trim(ls_Dados_Adicionais) <> '' Then
		ls_Dados_Adicionais = ls_Dados_Adicionais + ' - ' + is_Obs_NF
	Else
		ls_Dados_Adicionais = is_Obs_NF
	End If
End If

If Not Isnull(ls_Dados_Adicionais) and Trim(ls_Dados_Adicionais) <> '' Then
	ls_Dados_Adicionais = ls_Dados_Adicionais +  ' - Agrupamento: ' + String(il_Agrupamento)
Else
	ls_Dados_Adicionais = 'Agrupamento: ' + String(il_Agrupamento)
End If

If Not of_Localiza_Fornecedor_Dev_Compra(ls_Fornecedor, Ref ls_Fornecedor_Dev_Compra, Ref as_Mensagem) Then
	Return False
End If

if ib_Iniciado_Operacao_SAP then
	if is_Motivo_Devolucao <> is_Motivo_Devolucao_ant or &
		ls_Fornecedor <> is_fornecedor_ant or &
		is_serie_ant <> ls_Serie_Compra or&
		is_de_especie_ant <> ls_Especie_Compra or &
		ll_Nota_Compra <> il_nr_nf_ant or &
		ISNull(il_nr_nf_ant) then
		is_Motivo_Devolucao_ant	= is_Motivo_Devolucao
		is_fornecedor_ant			= ls_Fornecedor
		is_serie_ant				= ls_Serie_Compra
		is_de_especie_ant			= ls_Especie_Compra
		il_nr_nf_ant				= ll_Nota_Compra

		If not gf_proximo_seq_int_wms(ref il_nr_integracao, ref as_mensagem) Then
			 Return False
		End If
		
		//Dados adicionais 		
		ls_de_dados_adicionais	= ''
	
		//ls_Dados_Adicionais += ''String(il_Nota)
		
		//ls_de_dados_adicionais = 'NOTAS DEVOLVIDAS: (' + ls_de_dados_adicionais + ')' Comentado pois essa informa$$HEX2$$e700e300$$ENDHEX$$o agora est$$HEX1$$e100$$ENDHEX$$ no SAP
		
		If Not IsNull(is_Descricao_Endereco_WMS) Then
			ls_Dados_Adicionais += ' - MOTIVO DEVOLUCAO: ' + is_Descricao_Endereco_WMS
		End If
		
		If Not IsNull(is_Motivo_Devolucao) Then
			ls_Dados_Adicionais += ' (' + is_Motivo_Devolucao + ')'
		End If
		
		select dh_emissao
		  into :ldt_dh_emissao
		  from nf_compra
		 where nr_nf			= :ll_Nota_Compra
		 	and cd_fornecedor	= :ls_Fornecedor
			and cd_filial		= 534
			and de_serie		= :ls_Serie_Compra
			and de_especie		= :ls_Especie_Compra;

		Choose Case SQLCA.SQLCode
			Case -1
				as_mensagem	= 'Erro ao buscar a data de emiss$$HEX1$$e300$$ENDHEX$$o da nota fiscal de origem. ~r~rErro: ' + SQLCA.SQLErrText
				Return False
			Case 100
				as_mensagem	= 'N$$HEX1$$e300$$ENDHEX$$o foi localizada a data de emiss$$HEX1$$e300$$ENDHEX$$o da nota fiscal de origem.'
				Return False
		End Choose
		
		ls_Dados_Adicionais += ' - Dt. Emiss$$HEX1$$e300$$ENDHEX$$o: ' + String(ldt_dh_emissao, 'dd/mm/yyyy')

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
						 nr_agrupamento_dev_compra)
			 VALUES  (:il_nr_integracao,
						 2,
						 getdate(),
						 'C',
						 :is_Fornecedor[1],
						 null,
						 null,
						 null,
						 :is_Transp_Codigo,
						 :il_Qtde_Volume,
						 :is_Especie_Volume,
						 :is_Marca_Volume,
						 :is_Numero_Volume,
						 :idc_peso_liquido,
						 :idc_peso_bruto,
						 :ls_Dados_Adicionais,
						 null,
						 null,
						 null,
						 :il_Motivo_Devolucao,
						 :il_Agrupamento) 
		Using SqlCa;		
		
		If SqlCa.SqlCode = -1 Then
			as_Mensagem = "Erro ao incluir wms_int_sap para a devolu$$HEX2$$e700e300$$ENDHEX$$o. Erro: '" + SQLCA.SQLErrText + "'."
			Return False
		End If
	end if
else
	INSERT INTO nf_devolucao_compra	( cd_filial,   
															  nr_nf,   
															  de_especie,   
															  de_serie,   
															  dh_movimentacao_caixa,   
															  vl_bc_icms,   
															  vl_icms,   
															  vl_bc_icms_st,   
															  vl_icms_st,   
															  vl_icms_repassado,   
															  vl_total_produtos,   
															  vl_ipi,   
															  vl_frete,   
															  vl_seguro,   
															  vl_outras_despesas,   
															  vl_desconto,   
															  vl_indenizacao,   
															  vl_total_nf,   
															  cd_fornecedor,   
															  nr_nf_compra,   
															  de_especie_compra,   
															  de_serie_compra,   
															  nr_matricula_operador,   
															  dh_cancelamento,   
															  nr_matricula_cancelamento,   
															  nr_titulo_receber,   
															  de_motivo_devolucao,   
															  nr_nsu,   
															  dh_emissao,   
															  id_motivo_devolucao,   
															  cd_motivo_devolucao,
															  de_dados_adicionais,
															  nr_agrupamento_dev_compra,
															  cd_fornecedor_dev_compra)  
	 VALUES (534,   
					:al_Nota,   
					:as_Especie, 					//de_especie,   
					:as_Serie, 						//de_serie,   
					:ldh_Movimento,				//dh_movimentacao_caixa,   
					:idc_BC_ICMS,					//vl_bc_icms,   
					:idc_ICMS,						//vl_icms,   
					:idc_BC_ICMS_ST,				//vl_bc_icms_st,   
					:idc_ICMS_ST,					//vl_icms_st,   
					0.00,								//vl_icms_repassado,   
					:idc_Total_Produtos,			//vl_total_produtos,   
					:idc_IPI,						//vl_ipi,   
					0.00,								//vl_frete,   
					0.00,								//vl_seguro,   
					:idc_Outras_Despesas,		//vl_outras_despesas,   
					:idc_Total_Desconto,      	//vl_desconto,   
					0.00,								//vl_indenizacao,   
					:ldc_Valor_NF,					//vl_total_nf,   
					:ls_Fornecedor,				//cd_fornecedor,   
					:ll_Nota_Compra,				//nr_nf_compra,   
					:ls_Especie_Compra,			//de_especie_compra,   
					:ls_Serie_Compra,				//de_serie_compra,   
					:is_Operador,					//nr_matricula_operador,   
					null,								//dh_cancelamento,   
					null,								//nr_matricula_cancelamento,   
					null,								//nr_titulo_receber,   
					:is_Motivo_Devolucao,		//de_motivo_devolucao,   
					null,								//nr_nsu,   
					getdate(),						//dh_emissao,   
					null,								//id_motivo_devolucao,   
					:il_Motivo_Devolucao,		//cd_motivo_devolucao		
					:ls_Dados_Adicionais,		//de_dados_adicionais
					:il_Agrupamento,				//nr_agrupamento_dev_compra
					:ls_Fornecedor_Dev_Compra)	//cd_fornecedor_dev_compra
					
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Mensagem = "Erro ao incluir a nota de devolu$$HEX2$$e700e300$$ENDHEX$$o de compra '" + SQLCA.SQLErrText + "'."
		Return False
	End If	
end if

Return True
end function

public function boolean of_proxima_nota (ref long al_nota, ref string as_especie, ref string as_serie);uo_Parametro_Geral lvo_Parametro

lvo_Parametro =  Create uo_Parametro_Geral

If Not lvo_Parametro.of_proxima_nf(Ref al_nota) Then
	Destroy(lvo_Parametro)
	Return False
End If

If Not lvo_Parametro.of_Especie_NF(Ref as_especie) Then
	Destroy(lvo_Parametro)
	Return False
End If

If Not lvo_Parametro.of_Serie_NF(Ref as_serie) Then
	Destroy(lvo_Parametro)
	Return False
End If

Destroy(lvo_Parametro)

Return True

end function

public function boolean of_atualiza_motivo_dev_dados_transp (long al_nota, string as_especie, string as_serie, string as_mensagem);Update nf_devolucao_compra_nfe 
set 	qt_peso_liquido 		= 	:idc_peso_liquido, 
		qt_peso_bruto 			=	:idc_peso_bruto,
		nr_volume 				=	:is_Numero_Volume,
		de_marca_volume 		= 	:is_Marca_Volume, 
		de_especie_volume 	=	:is_Especie_Volume, 
		qt_volume 				= 	:il_Qtde_Volume,
		cd_transportadora		=	:is_transp_codigo		
where 	cd_filial 			=	534
   	and  	nr_nf 			=	:al_nota
	and 	de_especie  	=	:as_especie
	and 	de_serie		=	:as_serie
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1 
		as_Mensagem = "Erro ao atualizar os dados do transporte '" + SQLCA.SQLErrText + "'."
		Return False
End Choose

Return True



		
end function

public function boolean of_grava_nota (datastore ads_produtos, ref long al_nota, ref string as_erro);Boolean lb_Sucesso = True

Long	ll_Linha,&
		ll_Nota,&
		ll_Produto,&
		ll_Nat_Operacao,&
		ll_Qtde_Devolvida,&
		ll_Classificacao_Fiscal,&
		ll_NF_Compra,&
		ll_Nulo,&
		ll_Sequencial,&
		ll_Nr_Controle,&
		ll_Motivo_Deson_ICMS

String	ls_Especie,&
		ls_Serie,&
		ls_CST_Origem,&
		ls_CST_Tributacao,&
		ls_Pis_Cofins,&
		ls_CST_IPI,&
		ls_Lote,&
		ls_Situacao_Tribut,&
		ls_ICMS_ST,&
		ls_Fornecedor,&
		ls_Especie_Compra,&
		ls_Serie_Compra,&
		ls_UF_Fornecedor,&
		ls_Endereco_WMS,&
		ls_Nulo,&
		ls_CST_PIS,&
		ls_CST_COFINS,&
		ls_Cd_Beneficio,&
		ls_cd_cest, &
		ls_de_chave_acesso_origem, &
		ls_cd_deposito_sap

Decimal	ldc_Preco_Unitario,&
			ldc_Desconto,&
			ldc_Aliquota_ICMS,&
			ldc_Reduca_ICMS,&
			ldc_Aliquota_ICMS_ST,&
			ldc_Reducao_ICMS_ST,&
			ldc_Aliquota_IPI,&
			ldc_Preco_Maximo,&
			ldc_BC_PIS,&
			ldc_PIS,&
			ldc_BC_COFINS,&
			ldc_COFINS,&
			ldc_Pc_St_Retido,&
			ldc_Vl_Icms_Retido,&
			ldc_Vl_Total_Item,&
			ldc_Vl_Desc_Total,&
			ldc_Vl_BC_ICMS_Total,&
			ldc_Vl_ICMS_Total,&
			ldc_Vl_BC_IPI_Total,&
			ldc_Vl_IPI_Total,&
			ldc_Vl_ICMS_Desonerado,&
			ldc_VL_ICMS_Operacao

Decimal{4}	ldc_BC_ICMS,&
				ldc_ICMS,&
				ldc_BC_ICMS_ST,&
				ldc_ICMS_ST,&
				ldc_BC_IPI,&
				ldc_IPI,&
				ldc_MVA,&
				ldc_VL_Desconto,&
				ldc_Frete,&
				ldc_Outras_Despesas,&
				ldc_BC_ICMS_Retido,&
				ldc_ICMS_Retido,&
				ldc_BC_ICMS_ST_Aux,&
				ldc_ICMS_ST_Aux

Date	ldh_Validade,&
		ldh_Fabricacao

SetNull(ls_Nulo)
SetNull(ll_Nulo)

uo_tratamento_fiscal			lvo_tratamento_fiscal
uo_atributo_fiscal_item_nf	lvo_atributo
uo_Produto						lvo_Produto
uo_ge258_movimentacao	lo_Movimentacao

Try
		
	lvo_tratamento_fiscal = Create uo_tratamento_fiscal	
	lvo_atributo 				= Create uo_atributo_fiscal_item_nf
	lvo_Produto 				= Create uo_Produto
	lo_Movimentacao 		= Create uo_ge258_movimentacao
	
	lo_Movimentacao.ivb_Commit = False

	If This.of_Proxima_Nota(ref ll_Nota, ref ls_Especie, ref ls_Serie) Then
		If (IsNull(ll_Nota) or ll_Nota <= 0) or Trim(ls_Especie) = '' or Trim(ls_Serie) = '' Then
			as_Erro = "N$$HEX1$$fa00$$ENDHEX$$mero da nota, esp$$HEX1$$e900$$ENDHEX$$cie ou s$$HEX1$$e900$$ENDHEX$$rie s$$HEX1$$e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lidos."
			lb_Sucesso = False
			Return False
		End If
		al_Nota = ll_Nota
	Else
		lb_Sucesso = False
		Return False
	End If
	
	If Not This.of_Grava_Nota(ll_Nota, ls_Especie, ls_Serie, ref as_Erro) Then
		lb_Sucesso = False
		Return False
	End If
	
	If Not This.of_Atualiza_Motivo_Dev_Dados_Transp(ll_Nota, ls_Especie, ls_Serie, ref as_Erro) Then
		lb_Sucesso = False
		Return False
	End If
	
	If Not This.of_uf_fornecedor(ref ls_UF_Fornecedor, ref as_Erro) Then
		lb_Sucesso = False
		Return False
	End If
	
	lvo_tratamento_fiscal.of_grava_contribuinte(True)
	lvo_tratamento_fiscal.of_grava_uf_origem_destino(ls_UF_Fornecedor,gvo_parametro.ivs_UF_Filial)
	lvo_tratamento_fiscal.of_grava_operacao(lvo_tratamento_fiscal.DEVOLUCAO_COMPRA)
	
	For ll_Linha = 1 To ads_Produtos.RowCount()
					
		ll_Produto 	= ads_produtos.Object.cd_produto [ll_Linha]
			
		lvo_produto.of_localiza_codigo_interno(ll_Produto) 
		
		If Not lvo_produto.Localizado Then
			as_Erro = 	"O produto '"+ String(ll_Produto) + "  n$$HEX1$$e300$$ENDHEX$$o foi localizado."
			lb_Sucesso 	= False
			Exit
		End If
		
		lvo_atributo = lvo_tratamento_fiscal.of_atributo_fiscal_produto(lvo_produto)
			
		If Not lvo_atributo.Localizado THEN		
			as_Erro = "Problemas nos atributos fiscais do produto '" + String(ll_Produto)  + "'."
			lb_Sucesso 	= False
			Exit
		End If
		
		ls_Fornecedor 				= ads_produtos.Object.cd_fornecedor				[ll_Linha]	
		ll_NF_Compra 				= ads_produtos.Object.nr_nf							[ll_Linha]
		ls_Especie_Compra		= ads_produtos.Object.de_especie					[ll_Linha]
		ls_Serie_Compra			= ads_produtos.Object.de_serie						[ll_Linha]
		
		ll_Qtde_Devolvida			= ads_produtos.Object.qt_devolvida					[ll_Linha]
		ldc_Preco_Unitario			= ads_produtos.Object.vl_preco_unitario				[ll_Linha]
		ldc_Desconto				= ads_produtos.Object.pc_desconto					[ll_Linha]
		ls_CST_Origem				= ads_produtos.Object.cd_cst_origem				[ll_Linha]
		ls_CST_Tributacao		= ads_produtos.Object.cd_cst_tributacao			[ll_Linha]
		ls_Pis_Cofins				= ads_produtos.Object.id_lista_pis_cofins			[ll_Linha]
		
		ldc_BC_ICMS				= ads_produtos.Object.vl_bc_icms						[ll_Linha]
		ldc_Aliquota_ICMS	 		= ads_produtos.Object.pc_icms						[ll_Linha]
		ldc_ICMS						= ads_produtos.Object.vl_icms							[ll_Linha]
		ldc_Reduca_ICMS			= ads_produtos.Object.pc_reducao_bc_icms		[ll_Linha]
			
		ldc_BC_ICMS_ST			= ads_produtos.Object.vl_bc_icms_st					[ll_Linha]
		ldc_Aliquota_ICMS_ST	= ads_produtos.Object.pc_icms_st					[ll_Linha]
		ldc_ICMS_ST				= ads_produtos.Object.vl_icms_st						[ll_Linha]
		ldc_Reducao_ICMS_ST	= ads_produtos.Object.pc_reducao_bc_icms_st	[ll_Linha]
		
		ldc_BC_IPI					= ads_produtos.Object.vl_bc_ipi						[ll_Linha]
		ldc_Aliquota_IPI			= ads_produtos.Object.pc_ipi							[ll_Linha]
		ldc_IPI						= ads_produtos.Object.vl_IPI							[ll_Linha]
		ls_CST_IPI					= ads_produtos.Object.cd_cst_ipi						[ll_Linha]
		
		ll_Classificacao_Fiscal		=	ads_produtos.Object.nr_classificacao_fiscal		[ll_Linha]
		ldc_Preco_Maximo			=	ads_produtos.Object.vl_preco_venda_maximo	[ll_Linha]	
		ldc_MVA						=	ads_produtos.Object.pc_mva						[ll_Linha]	
		ldc_VL_Desconto			=	ads_produtos.Object.vl_desconto					[ll_Linha]
		ldc_Frete						= ads_produtos.Object.vl_frete							[ll_Linha]
		ldc_Outras_Despesas		= ads_produtos.Object.vl_outras_despesas			[ll_Linha]
		ldc_BC_ICMS_Retido		= ads_produtos.Object.vl_bc_icms_st_retido		[ll_Linha]
		ldc_ICMS_Retido			= ads_produtos.Object.vl_icms_st_retido			[ll_Linha]
		ls_Situacao_Tribut			= ads_produtos.Object.cd_situacao_tributaria		[ll_Linha]
		
		ls_Lote						=	ads_produtos.Object.nr_lote						[ll_Linha]
		ls_Endereco_WMS			=	ads_produtos.Object.cd_endereco					[ll_Linha]
		ldh_Validade				=	date(ads_produtos.Object.dh_validade			[ll_Linha])
		ll_Sequencial				=	ads_produtos.Object.nr_sequencial				[ll_Linha]
		ll_Nr_Controle				=	ads_produtos.Object.nr_controle					[ll_Linha]
		
		ldc_BC_ICMS_ST_Aux	=	ads_produtos.Object.vl_bc_icms_st_auxiliar		[ll_Linha]
		ldc_ICMS_ST_Aux			=	ads_produtos.Object.vl_icms_st_auxiliar			[ll_Linha]
		
		ls_CST_PIS					= ads_produtos.Object.cd_cst_pis						[ll_Linha]
		ldc_BC_PIS					= ads_produtos.Object.vl_bc_pis						[ll_Linha]
		ldc_PIS						= ads_produtos.Object.vl_pis							[ll_Linha]
		
		ls_CST_COFINS			= ads_produtos.Object.cd_cst_cofins					[ll_Linha]
		ldc_BC_COFINS				= ads_produtos.Object.vl_bc_cofins					[ll_Linha]
		ldc_COFINS					= ads_produtos.Object.vl_cofins						[ll_Linha]
		
		ldc_Pc_St_Retido			= ads_produtos.Object.pc_st_retido					[ll_Linha]
		ldc_Vl_Icms_Retido		= ads_produtos.Object.vl_icms_retido				[ll_Linha]
		
		ls_Cd_Beneficio				= ads_produtos.Object.cd_beneficio					[ll_Linha]
		ls_cd_cest					= ads_produtos.Object.cd_cest							[ll_Linha]
		
		ldc_Vl_Total_Item			= ads_produtos.Object.vl_total_item					[ll_Linha]
		ldc_Vl_Desc_Total			= ads_produtos.Object.vl_desconto_total			[ll_Linha]
		
		ldc_Vl_BC_ICMS_Total 	= ads_produtos.Object.vl_bc_icms_total				[ll_Linha]
		ldc_Vl_ICMS_Total 		= ads_produtos.Object.vl_icms_total					[ll_Linha]
		ldc_Vl_BC_IPI_Total 		= ads_produtos.Object.vl_bc_ipi_total				[ll_Linha]
		ldc_Vl_IPI_Total 			= ads_produtos.Object.vl_ipi_total						[ll_Linha]
		
		ldc_Vl_ICMS_Desonerado	= ads_produtos.Object.Vl_ICMS_Desonerado				[ll_Linha]
		ll_Motivo_Deson_ICMS		= ads_produtos.Object.Id_Motivo_Desoneracao_ICMS	[ll_Linha]
		ldc_VL_ICMS_Operacao		= ads_produtos.Object.Vl_ICMS_Operacao					[ll_Linha]
		
		
		
		//ls_Endereco_WMS	= is_Endereco	[ll_Linha]
		//ldh_Validade			= idh_Validade	[ll_Linha]
		//ll_Sequencial			= il_Sequencial	[ll_Linha]
		
		If IsNull(ldc_BC_ICMS) 				Then ldc_BC_ICMS 					= 0.00
		If IsNull(ldc_Aliquota_ICMS) 		Then ldc_Aliquota_ICMS 				= 0.00
		If IsNull(ldc_BC_ICMS) 				Then ldc_BC_ICMS 					= 0.00
		If IsNull(ldc_Reduca_ICMS) 			Then ldc_Reduca_ICMS 				= 0.00
		If IsNull(ldc_BC_ICMS_ST) 			Then ldc_BC_ICMS_ST 				= 0.00
		If IsNull(ldc_Aliquota_ICMS_ST) 	Then ldc_Aliquota_ICMS_ST 		= 0.00
		If IsNull(ldc_ICMS_ST)				Then ldc_ICMS_ST 					= 0.00
		If IsNull(ldc_Reducao_ICMS_ST) 	Then ldc_Reducao_ICMS_ST 		= 0.00
		If IsNull(ldc_BC_IPI)					Then ldc_BC_IPI 						= 0.00
		If IsNull(ldc_Aliquota_IPI) 			Then ldc_Aliquota_IPI 				= 0.00
		If IsNull(ldc_IPI) 						Then ldc_IPI 							= 0.00
		If IsNull(ldc_BC_ICMS_ST_Aux)		Then ldc_BC_ICMS_ST_Aux 		= 0.00
		If IsNull(ldc_ICMS_ST_Aux)			Then ldc_ICMS_ST_Aux				= 0.00
		If IsNull(ldc_Pc_St_Retido)			Then ldc_Pc_St_Retido				= 0.00
		If IsNull(ldc_Vl_Icms_Retido)		Then ldc_Vl_Icms_Retido			= 0.00
		
		If lvo_tratamento_fiscal.is_produto_almoxarifado = 'S'  and ldc_ICMS_ST > 0 Then
			as_erro = "O sistema n$$HEX1$$e300$$ENDHEX$$o esta preparado para emitir nota com ST de produtos do almoxarifado.~r~r" + "Solicitar a emiss$$HEX1$$e300$$ENDHEX$$o da nota ao depto fiscal."
			lb_Sucesso 	= False
			Exit				
		End If
				
		If IsNull(ls_CST_Tributacao	) Then
			ls_CST_Tributacao = Mid(ls_Situacao_Tribut, 2, 1) + "0"
		End If
		
		If Not This.of_Verifica_ICMS_ST(mid(ls_CST_Tributacao, 1,1), ref ls_ICMS_ST, ref as_Erro) Then
			lb_Sucesso 	= False
			Exit
		End If
		
		// pela nova regra a tributa$$HEX2$$e700e300$$ENDHEX$$o mudou para 00.
		If ldc_BC_ICMS_ST_Aux > 0 Then ls_ICMS_ST = 'S'
		
		If ls_ICMS_ST = 'S' or mid(ls_CST_Tributacao, 1,1) = '6' Then
			lvo_tratamento_fiscal.of_NatOpe(True, ref ll_Nat_Operacao)
		Else
			lvo_tratamento_fiscal.of_NatOpe(False, ref ll_Nat_Operacao)
		End If
		
		If IsNull(ls_CST_Origem) Then
			If Not IsNull(lvo_produto.cd_st_origem) and trim(lvo_produto.cd_st_origem) <> "" Then
				ls_CST_Origem = lvo_produto.cd_st_origem
			Else
				ls_CST_Origem	 =  "0"
			End If
		End If
		
		//Se a vari$$HEX1$$e100$$ENDHEX$$vel estiver nula $$HEX1$$e900$$ENDHEX$$ segragado recebimento
		If IsNull(il_Agrupamento) Then
			If Not of_atualiza_segregado_recebimento(	ls_Endereco_WMS, ls_Fornecedor,&
																	ll_NF_Compra, ls_Especie_Compra,&
																	ls_Serie_Compra, ll_Produto, ls_Lote,&
																	ldh_validade, ll_Qtde_Devolvida, ll_Nr_Controle, ref as_Erro) Then
				lb_Sucesso 	= False
				Exit	
			End If
		End If
			
		If Not lo_Movimentacao.of_Insere_Movimentacao(	ls_Nulo,	ls_Endereco_WMS,ll_Produto,	1,ls_Lote,ldh_Validade,&
																					ll_Qtde_Devolvida,'G',	534,ls_Nulo,ll_Nota,&
																					ls_Especie,ls_Serie,is_Operador, ll_Sequencial) Then
			lb_Sucesso 	= False
			Exit																						 
		End If
		
		If ls_CST_Tributacao = "60" Then
			If IsNull(ldc_BC_ICMS_Retido) or (ldc_BC_ICMS_Retido <= 0) Then
				ldc_BC_ICMS_Retido	=	Round(ldc_Preco_Unitario * ll_Qtde_Devolvida, 2)
				ldc_Pc_St_Retido		=	lvo_atributo.pc_icms
				ldc_ICMS_Retido		=	Round((ldc_Pc_St_Retido / 100) * ldc_BC_ICMS_Retido, 2)
			End If
		End If
			
		if not ib_Iniciado_Operacao_SAP then			
			INSERT INTO nf_devolucao_compra_produto (	cd_filial,   
																		nr_nf,   
																		de_especie,   
																		de_serie,   
																		nr_item,   
																		cd_produto,   
																		cd_natureza_operacao,   
																		qt_devolvida,   
																		vl_preco_unitario,   
																		pc_desconto,   
																		cd_cst_origem,   
																		cd_cst_tributacao,   
																		id_lista_pis_cofins,   
																		vl_bc_icms,   
																		pc_icms,   
																		vl_icms,   
																		pc_reducao_bc_icms,   
																		vl_bc_icms_st,   
																		pc_icms_st,   
																		vl_icms_st,   
																		pc_reducao_bc_icms_st, 																		
																		vl_bc_ipi,   
																		pc_ipi,   
																		vl_ipi,   
																		cd_cst_ipi,   
																		nr_classificacao_fiscal,   
																		vl_preco_venda_maximo,   
																		pc_mva,   
																		vl_desconto,   
																		vl_frete,   
																		vl_outras_despesas,   
																		vl_bc_icms_st_retido,   
																		vl_icms_st_retido,
																		vl_bc_icms_st_auxiliar,
																		vl_icms_st_auxiliar,
																		cd_cst_pis,
																		vl_bc_pis,
																		vl_pis,																	
																		cd_cst_cofins,
																		vl_bc_cofins,
																		vl_cofins,
																		pc_st_retido,
																		vl_icms_retido,
																		cd_beneficio,
																		cd_cest,
																		vl_total_item,
																		vl_desconto_total,
																		vl_bc_icms_total,
																		vl_icms_total,
																		vl_bc_ipi_total,
																		vl_ipi_total,
																		vl_icms_desonerado,
																		id_motivo_desoneracao_icms,
																		vl_icms_operacao)
			VALUES (	534,							//cd_filial,   
							:ll_Nota,						//nr_nf,   
							:ls_Especie,					//de_especie,   
							:ls_Serie,					//de_serie,   
							:ll_Linha,						//nr_item,   
							:ll_Produto,					//cd_produto,   
							:ll_Nat_Operacao,			//cd_natureza_operacao,   
							:ll_Qtde_Devolvida,		//qt_devolvida,   
							:ldc_Preco_Unitario, 		//vl_preco_unitario,   
							:ldc_Desconto,				//pc_desconto,   
							:ls_CST_Origem,			//cd_cst_origem,   
							:ls_CST_Tributacao,		//cd_cst_tributacao,   
							:ls_Pis_Cofins,				//id_lista_pis_cofins,   
							:ldc_BC_ICMS	,			//vl_bc_icms,   
							:ldc_Aliquota_ICMS,		//pc_icms,   
							:ldc_ICMS,					//vl_icms,   
							:ldc_Reduca_ICMS,		//pc_reducao_bc_icms,   
							:ldc_BC_ICMS_ST,			//vl_bc_icms_st,   
							:ldc_Aliquota_ICMS_ST, 	//pc_icms_st,   
							:ldc_ICMS_ST,				//vl_icms_st,   
							:ldc_Reducao_ICMS_ST,	//pc_reducao_bc_icms_st,   
							:ldc_BC_IPI,					//vl_bc_ipi,   
							:ldc_Aliquota_IPI,			//pc_ipi,   
							:ldc_IPI,						//vl_ipi,   
							:ls_CST_IPI,					//cd_cst_ipi,   
							:ll_Classificacao_Fiscal,	//nr_classificacao_fiscal,   
							:ldc_Preco_Maximo,		//vl_preco_venda_maximo,   
							:ldc_MVA,					//pc_mva,   
							:ldc_VL_Desconto,			//vl_desconto,   
							:ldc_Frete,					//vl_frete,   
							:ldc_Outras_Despesas,	//vl_outras_despesas,   
							:ldc_BC_ICMS_Retido,	//vl_bc_icms_st_retido,   
							:ldc_ICMS_Retido, 		//vl_icms_st_retido
							:ldc_BC_ICMS_ST_Aux,	//vl_bc_icms_st_auxiliar
							:ldc_ICMS_ST_Aux,		//vl_icms_st_auxiliar
							:ls_CST_PIS,				//cd_cst_pis
							:ldc_BC_PIS,				//vl_bc_pis,
							:ldc_PIS,						//vl_pis,																	
							:ls_CST_COFINS,			//cd_cst_cofins,
							:ldc_BC_COFINS,			//vl_bc_cofins,
							:ldc_COFINS,				//vl_cofins
							:ldc_Pc_St_Retido,			//pc_st_retido
							:ldc_Vl_Icms_Retido,		//vl_icms_retido
							:ls_Cd_Beneficio,			//cd_beneficio
							:ls_cd_cest,					//cd_cest
							:ldc_Vl_Total_Item,		//vl_total_item
							:ldc_Vl_Desc_Total,		//vl_desconto_total
							:ldc_Vl_BC_ICMS_Total,	//vl_bc_icms_total
							:ldc_Vl_ICMS_Total,		//vl_icms_total
							:ldc_Vl_BC_IPI_Total,		//vl_bc_ipi_total
							:ldc_Vl_IPI_Total,			//vl_ipi_total
							:ldc_Vl_ICMS_Desonerado, //vl_icms_desonerado																
							:ll_Motivo_Deson_ICMS, //id_motivo_desoneracao_icms
							:ldc_VL_ICMS_Operacao)  // vl_icms_operacao 
			Using SqlCa;
		end if
		
		If SqlCa.SqlCode = -1 Then
			as_Erro = "Erro ao gravar o item da nota fiscal '" + SQLCA.SQLErrText + "'."
			lb_Sucesso 	= False
			Exit
		End If
		
		If IsNull(ldh_Validade) Then
			ldh_Validade = Date(gf_GetServerDate())
		End If
		
		ldh_Fabricacao = RelativeDate(ldh_Validade, -90)
		
		If ldh_Fabricacao >= Date(gf_GetServerDate()) Then
			ldh_Fabricacao = RelativeDate(Date(gf_GetServerDate()), -30)
		End If
			
		if ib_Iniciado_Operacao_SAP then			
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
							 cd_deposito_sap_saida)
			VALUES      (:il_nr_integracao,
							 :ll_Linha,
							 :ll_Produto,
							 :ls_Lote,
							 :ll_Qtde_Devolvida,
							 :ldh_Fabricacao,
							 :ldh_Validade,
							 :is_Chave_Movimento[ll_linha],
							 'S',
							 :ls_cd_deposito_sap) 
			Using SqlCa;
		else
			INSERT INTO nf_devolucao_compra_prd_lote (	  cd_filial,   
																		  nr_nf,   
																		  de_especie,   
																		  de_serie,   
																		  nr_item,   
																		  nr_lote,   
																		  qt_lote,
																		  dh_validade,
																		  dh_fabricacao)  
			VALUES ( 	534, 						//cd_filial,   
							:ll_Nota,					//nr_nf,   
							:ls_Especie, 			//de_especie,   
							:ls_Serie,				//de_serie,   
							:ll_Linha,					//nr_item,   
							:ls_Lote,					//nr_lote,   
							:ll_Qtde_Devolvida, 	//qt_lote
							:ldh_Validade,  		//dh_validade
							:ldh_Fabricacao)		//dh_fabricacao
			Using SqlCa; 
		end if
		
		If SqlCa.SqlCode = -1 Then
			as_Erro = "Erro ao gravar o item da nota fiscal '" + SQLCA.SQLErrText + "'."
			lb_Sucesso 	= False
			Exit
		End If
		
		if not ib_Iniciado_Operacao_SAP then
		  INSERT INTO nf_devolucao_compra_prd_ent	( cd_filial,   
																	  nr_nf,   
																	  de_especie,   
																	  de_serie,   
																	  nr_item,   
																	  cd_fornecedor,   
																	  nr_nf_compra,   
																	  de_especie_compra,   
																	  de_serie_compra )  
			VALUES (	534,									//cd_filial,   
							:ll_Nota,							//nr_nf,   
							:ls_Especie,						//de_especie,   
							:ls_Serie,							//de_serie,   
							:ll_Linha,							//nr_item,   
							:ls_Fornecedor,					//cd_fornecedor,   
							:ll_NF_Compra,					//nr_nf_compra,   
							:ls_Especie_Compra,			//de_especie_compra,   
							:ls_Serie_Compra) 			//de_serie_compra
			Using SqlCa;
		end if
		
		If SqlCa.SqlCode = -1 Then
			as_Erro = "Erro ao gravar o registro na NF de entrada '" + SQLCA.SQLErrText + "'."
			lb_Sucesso 	= False
			Exit
		End If
				
		if ib_Iniciado_Operacao_SAP then
			select de_chave_acesso
			  into :ls_de_chave_acesso_origem
			  from nf_compra
			 where cd_filial = 534 and 
			 		 cd_fornecedor = :ls_Fornecedor and 
					 nr_nf 			= :ll_Nota and 
					 de_especie 	= :ls_Especie and 
					 de_serie 		= :ls_Serie
			Using SqlCa;
				
			If SqlCa.SqlCode = -1 Then
				as_Erro	= "Erro ao consultar na tabela {nf_compra}. Erro: "+SqlCa.SqlErrText
				Return False
			End If
				
			INSERT INTO wms_int_sap_auxiliar
							(nr_integracao,
							 nr_sequencial,
							 nr_item,
							 nr_nf_origem,
							 de_chave_acesso_origem)
			VALUES      (:il_nr_integracao,
							 :ll_linha,
							 :ll_linha,
							 :ll_Nota,
							 :ls_de_chave_acesso_origem)  
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Erro	= "Erro ao gravar na tabela {wms_int_sap_auxiliar}. Erro: "+SqlCa.SqlErrText
				Return False
			End If
		else
			INSERT INTO nf_devolucao_compra_entrada ( cd_filial, nr_nf, de_especie, de_serie, de_chave_acesso)  
			select distinct a.cd_filial, a.nr_nf, a.de_especie, a.de_serie, n.de_chave_acesso
			from nf_devolucao_compra_prd_ent a
			inner join nf_compra n on n.cd_filial 			= a.cd_filial
										  and n.cd_fornecedor 	= a.cd_fornecedor
										  and n.nr_nf				= a.nr_nf_compra
										  and n.de_especie		= a.de_especie_compra
										  and n.de_serie			= a.de_serie_compra
			where a.cd_filial 		= 534
				and a.nr_nf 			= :ll_Nota
				and a.de_especie 	= :ls_Especie
				and a.de_serie		= :ls_Serie
				and not exists (select * from nf_devolucao_compra_entrada e
									where e.cd_filial 				= 534
										and e.nr_nf 					= a.nr_nf
										and e.de_especie 			= a.de_especie
										and e.de_serie 				= a.de_serie
										and e.de_chave_acesso 	= n.de_chave_acesso)
			Using SqlCa;
		end if
		
		If SqlCa.SqlCode = -1 Then
			as_Erro = "Erro ao gravar o registro na NF de entrada nf_devolucao_compra_entrada '" + SQLCA.SQLErrText + "'."
			lb_Sucesso 	= False
			Exit
		End If
	Next
	
Catch ( runtimeerror  lo_rte )
  as_Erro = "Erro '"+ lo_rte.GetMessage( ) + "'."
  lb_Sucesso 	= False

Finally

//	If lb_Sucesso Then
//		Sqlca.of_Commit();
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A nota fiscal de devolu$$HEX2$$e700e300$$ENDHEX$$o de compra foi gerada com sucesso.")
//	Else
//		SqlCa.of_RollBack();
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem, StopSign!)
//	End If
	
	Destroy lvo_tratamento_fiscal
	Destroy lvo_atributo
	Destroy lvo_Produto
	Destroy lo_Movimentacao
	
	Return lb_Sucesso
	
End Try
end function

public function boolean of_processa_geracao_nota (ref long al_nota, ref string as_erro);Boolean lb_Sucesso = True
Boolean lb_Utilizou_Tot_NF = False

Long	ll_Linha,&
		ll_Filial,&
		ll_Itens_NF_Origem,&
		ll_Insert,&
		ll_Nota,&
		ll_Produto,&
		ll_Qte_Devolver,&
		ll_Qtde_Faturada,&
		ll_Sequencial,&
		ll_Nr_Controle

String	ls_Fornecedor,&
		ls_Especie,&
		ls_Serie,&
		ls_Lote,&
		ls_Endereceo,&
		ls_CST,&
		ls_Sit_Tribut_Nova,&
		ls_Lote_Nota,&
		ls_CST_PIS,&
		ls_CST_COFINS,&
		ls_Mensagem_Log,&
		ls_Nulo,&
		ls_Cd_Beneficio,&
		ls_Uf_Fornecedor,&
		ls_cd_cest_nf_Compra,&
		ls_cd_cest_nf_DevCompra,&
		ls_Log

Date ldh_Validade

//Decimal{4} ldc_Preco_Liquido

Decimal	ldc_BC_PIS,&
			ldc_Aliq_PIS,&
			ldc_PIS,&
			ldc_BC_COFINS,&
			ldc_Aliq_COFINS,&
			ldc_COFINS

Decimal{2} ldc_Bc_Icms, ldc_Total_Item

Decimal ldc_Nulo
Decimal ldc_vl_total_item
Decimal ldc_vl_desconto_total
Decimal ldc_bc_icms_total
Decimal ldc_icms_total
Decimal ldc_bc_ipi_total
Decimal ldc_ipi_total

SetNull(ldc_Nulo)

dc_uo_ds_base lds_Item_NF_Origem 

dc_uo_ds_base lds_Devolucao_PRD

uo_tratamento_fiscal lo_fiscal
uo_cest lo_Cest


Try 
	lds_Item_NF_Origem	= Create dc_uo_ds_base
	lds_Devolucao_PRD	= Create dc_uo_ds_base
	lo_Fiscal					= Create uo_tratamento_fiscal
	lo_Cest					= Create uo_cest
	
	If Not lds_Item_NF_Origem.of_ChangeDataObject("ds_ge252_item_nf_compra") Then
		Return False
	End If
	
	If Not lds_Devolucao_PRD.of_ChangeDataObject("ds_ge252_nf_devolucao_compra_produto") Then
		Return False
	End If
	
	idc_BC_ICMS_ST 			= 0.00
	idc_ICMS_ST				= 0.00
	idc_BC_ICMS				= 0.00
	idc_ICMS						= 0.00
	idc_ICMS_AUX				= 0.00
	idc_BC_IPI					= 0.00
	idc_IPI						= 0.00
	idc_Outras_Despesas		= 0.00
	idc_Total_Produtos		= 0.00
	idc_BC_ICMS_ST_DA		= 0.00
	idc_ICMS_ST_DA			= 0.00
	idc_Total_Desconto		= 0.00
	
	SetNull(ls_Nulo)
	
	idc_VALIDA_ICMS_TOTAL 	= 0.00
	idc_VALIDA_ICMS				= 0.00
	
	
	For ll_Linha = 1 To UpperBound(il_Filial[])
		
		ll_Filial 				= il_Filial				[ll_Linha]
		ls_Fornecedor		= is_Fornecedor	[ll_Linha]
		ll_Nota				= il_Nota				[ll_Linha]
		ls_Especie			= is_Especie		[ll_Linha]
		ls_Serie				= is_Serie			[ll_Linha]
		ll_Produto			= il_Produto			[ll_Linha]
		ll_Qte_Devolver		= il_Qtde_Devolver[ll_Linha]
		ls_Lote				= is_Lote				[ll_Linha]
		ldh_Validade		= idh_Validade		[ll_Linha]
		ll_Sequencial		= il_Sequencial		[ll_Linha]
		ls_Endereceo		= is_Endereco		[ll_Linha]
	 	ls_Lote_Nota		= is_Lote_Nota		[ll_Linha] //Novo
		ll_Nr_Controle		= il_Nr_Controle	[ll_Linha]
		
			
		If lds_Item_NF_Origem.Retrieve(ll_Filial, ls_Fornecedor, ll_Nota, ls_Especie, ls_Serie, ll_Produto) >= 0 Then
			
			If lds_Item_NF_Origem.RowCount() = 1 Then
				
				ll_Insert = lds_Devolucao_PRD.InsertRow(0)
				
				If ll_Insert > 0 Then
									
					lds_Devolucao_PRD.Object.cd_filial						[ll_Insert] 	= lds_Item_NF_Origem.Object.cd_filial						[1]
					lds_Devolucao_PRD.Object.nr_nf							[ll_Insert] 	= lds_Item_NF_Origem.Object.nr_nf							[1]
					lds_Devolucao_PRD.Object.de_especie					[ll_Insert] 	= lds_Item_NF_Origem.Object.de_especie					[1]
					lds_Devolucao_PRD.Object.de_serie						[ll_Insert]	= lds_Item_NF_Origem.Object.de_serie						[1]
					lds_Devolucao_PRD.Object.nr_item						[ll_Insert]	= ll_Insert
					lds_Devolucao_PRD.Object.cd_produto					[ll_Insert]	= lds_Item_NF_Origem.Object.cd_produto					[1]
					lds_Devolucao_PRD.Object.cd_natureza_operacao		[ll_Insert]	= lds_Item_NF_Origem.Object.cd_natureza_operacao	[1]
					lds_Devolucao_PRD.Object.nr_lote							[ll_Insert]  	= ls_Lote
					lds_Devolucao_PRD.Object.nr_lote_nota					[ll_Insert] 	= ls_Lote_Nota
					lds_Devolucao_PRD.Object.dh_validade					[ll_Insert]  	= String(ldh_Validade, "dd/mm/yyyy")
					lds_Devolucao_PRD.Object.nr_sequencial				[ll_Insert]  	= ll_Sequencial
					lds_Devolucao_PRD.Object.cd_endereco					[ll_Insert]  	= ls_Endereceo
					lds_Devolucao_PRD.Object.nr_controle					[ll_Insert]  	= ll_Nr_Controle
					lds_Devolucao_PRD.Object.qt_devolvida					[ll_Insert]	= ll_Qte_Devolver
					lds_Devolucao_PRD.Object.pc_desconto					[ll_Insert]	= lds_Item_NF_Origem.Object.pc_desconto					[1]							
					lds_Devolucao_PRD.Object.cd_cst_origem				[ll_Insert]	= lds_Item_NF_Origem.Object.cd_cst_origem				[1]				
					lds_Devolucao_PRD.Object.cd_cst_tributacao			[ll_Insert]	= lds_Item_NF_Origem.Object.cd_cst_tributacao			[1]				
					lds_Devolucao_PRD.Object.id_lista_pis_cofins			[ll_Insert]	= lds_Item_NF_Origem.Object.id_lista_pis_cofins			[1]				
					lds_Devolucao_PRD.Object.pc_icms						[ll_Insert]	= lds_Item_NF_Origem.Object.pc_icms						[1]				
					lds_Devolucao_PRD.Object.pc_reducao_bc_icms		[ll_Insert]	= lds_Item_NF_Origem.Object.pc_reducao_base_icms	[1]				
					lds_Devolucao_PRD.Object.pc_icms_st					[ll_Insert]	= lds_Item_NF_Origem.Object.pc_icms_st					[1]				
					lds_Devolucao_PRD.Object.pc_ipi							[ll_Insert]	= lds_Item_NF_Origem.Object.pc_ipi							[1]				
					lds_Devolucao_PRD.Object.nr_classificacao_fiscal		[ll_Insert]	= lds_Item_NF_Origem.Object.nr_classificacao_fiscal		[1]				
					lds_Devolucao_PRD.Object.cd_situacao_tributaria		[ll_Insert]	= lds_Item_NF_Origem.Object.cd_situacao_tributaria		[1]
					lds_Devolucao_PRD.Object.cd_fornecedor				[ll_Insert]	= lds_Item_NF_Origem.Object.cd_fornecedor				[1]
					
					lds_Devolucao_PRD.Object.id_motivo_desoneracao_icms	[ll_Insert]	= lds_Item_NF_Origem.Object.id_motivo_desoneracao_icms	[1]
					
					lds_Devolucao_PRD.Object.vl_icms_desonerado				[ll_Insert]	= lds_Item_NF_Origem.Object.vl_icms_desonerado[1] / (lds_Item_NF_Origem.Object.qt_faturada[1] / ll_Qte_Devolver)
					
					// Chamado 
					lds_Devolucao_PRD.Object.vl_icms_operacao					[ll_Insert]	= ((lds_Item_NF_Origem.Object.vl_icms_operacao[1] / lds_Item_NF_Origem.Object.qt_faturada[1])  * ll_Qte_Devolver)
					
					ll_Qtde_Faturada	= 	lds_Item_NF_Origem.Object.qt_faturada	[1]	
					
					lb_Utilizou_Tot_NF = False
										
					// INICIO - Pega os valores totais para n$$HEX1$$e300$$ENDHEX$$o dar problema de arredondamento
					// Pega os dados da ITEM_NF_COMPRA, totais que foram importados do GN (XML)
					ldc_vl_total_item			= lds_Item_NF_Origem.Object.vl_total_item			[1]
					ldc_vl_desconto_total 	= lds_Item_NF_Origem.Object.vl_desconto_total	[1]
					ldc_bc_icms_total			= lds_Item_NF_Origem.Object.vl_bc_icms_total	[1]	
					ldc_icms_total				= lds_Item_NF_Origem.Object.vl_icms_total		[1]	
					ldc_bc_ipi_total				= lds_Item_NF_Origem.Object.vl_bc_ipi_total		[1]	
					ldc_ipi_total					= lds_Item_NF_Origem.Object.vl_ipi_total			[1]	
					
					// Confirma se os totais foram realmente informados na ITEM_NF_COMPRA (igual ao XML)
					If Not lf_ge252_item_nf_compra(	ll_Filial, ls_Fornecedor, ll_Nota, ls_Especie,&
																ls_Serie, ll_Produto, ref lb_Utilizou_Tot_NF) Then
						lb_Sucesso = False
						Exit
					End If
					
					// Se n$$HEX1$$e300$$ENDHEX$$o localizou na ITEM_NF_COMPRA, olha no agendamento
					If Not lb_Utilizou_Tot_NF Then
						// Pega os dados da NF_AGENDAMENTO_ENT_ITEM
						If Not lf_ge252_nf_agend_ent_item(ll_Filial, ls_Fornecedor, ll_Nota, ls_Especie, ls_Serie, ll_Produto, & 
																ref ldc_vl_total_item, ref ldc_vl_desconto_total, &
																ref ldc_bc_icms_total, ref ldc_icms_total, &
																ref ldc_bc_ipi_total,  ref ldc_ipi_total, ref ls_log, &
																ref lb_Utilizou_Tot_NF ) Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Log)
							lb_Sucesso = False
							Exit
						End If
					End If
										
					If lb_Utilizou_Tot_NF Then
						lds_Devolucao_PRD.Object.vl_total_item			[ll_Insert]	= Round((ldc_vl_total_item / ll_Qtde_Faturada) * ll_Qte_Devolver, 2)
						lds_Devolucao_PRD.Object.vl_desconto_total	[ll_Insert]	= Round((ldc_vl_desconto_total / ll_Qtde_Faturada) * ll_Qte_Devolver, 2)					
						lds_Devolucao_PRD.Object.vl_bc_icms_total		[ll_Insert]	= Round((ldc_bc_icms_total / ll_Qtde_Faturada) * ll_Qte_Devolver, 2)
						lds_Devolucao_PRD.Object.vl_icms_total			[ll_Insert]	= Round((ldc_icms_total / ll_Qtde_Faturada) * ll_Qte_Devolver, 2)
						lds_Devolucao_PRD.Object.vl_bc_ipi_total		[ll_Insert]	= Round((ldc_bc_ipi_total / ll_Qtde_Faturada) * ll_Qte_Devolver, 2)
						lds_Devolucao_PRD.Object.vl_ipi_total			[ll_Insert]	= Round((ldc_ipi_total / ll_Qtde_Faturada) * ll_Qte_Devolver, 2)
						
						// Utiliza os valores totais, da pr$$HEX1$$f300$$ENDHEX$$pria NF de origem ou da NF_AGENDAMENTO_ENT
						lds_Devolucao_PRD.Object.vl_preco_unitario	[ll_Insert]	= round(ldc_vl_total_item / ll_Qtde_Faturada, 4)
						lds_Devolucao_PRD.Object.vl_bc_icms				[ll_Insert]	= Round((ldc_bc_icms_total / ll_Qtde_Faturada) * ll_Qte_Devolver, 2)
					Else
						lds_Devolucao_PRD.Object.vl_total_item			[ll_Insert]	= ldc_Nulo
						lds_Devolucao_PRD.Object.vl_desconto_total	[ll_Insert]	= ldc_Nulo
						lds_Devolucao_PRD.Object.vl_bc_icms_total		[ll_Insert]	= ldc_Nulo
						lds_Devolucao_PRD.Object.vl_icms_total			[ll_Insert]	= ldc_Nulo
						lds_Devolucao_PRD.Object.vl_bc_ipi_total		[ll_Insert]	= ldc_Nulo
						lds_Devolucao_PRD.Object.vl_ipi_total			[ll_Insert]	= ldc_Nulo
						
						// Utiliza os valores da NF de origem
						lds_Devolucao_PRD.Object.vl_preco_unitario	[ll_Insert]	= lds_Item_NF_Origem.Object.vl_preco_unitario			[1]	
						lds_Devolucao_PRD.Object.vl_bc_icms				[ll_Insert]	= round(lds_Item_NF_Origem.Object.vl_bc_icms	[1] * ll_Qte_Devolver, 2)
					End If
					// INICIO - Pega os valores totais para n$$HEX1$$e300$$ENDHEX$$o dar problema de arredondamento
										
					lds_Devolucao_PRD.Object.vl_desconto					[ll_Insert]	= round(lds_Devolucao_PRD.Object.vl_preco_unitario	[ll_Insert] * (lds_Item_NF_Origem.Object.pc_desconto	[1]	 / 100), 4)

					lds_Devolucao_PRD.Object.vl_bc_icms_st_retido		[ll_Insert]	= round(lds_Item_NF_Origem.Object.vl_bc_icms_st_retido	[1]	* ll_Qte_Devolver, 2)
					lds_Devolucao_PRD.Object.vl_icms_st_retido			[ll_Insert]	= round(lds_Item_NF_Origem.Object.vl_icms_st_retido		[1]	* ll_Qte_Devolver, 2)	
					
				
					lds_Devolucao_PRD.Object.vl_icms						[ll_Insert]	=  round(lds_Devolucao_PRD.Object.vl_bc_icms[ll_Insert] * (lds_Devolucao_PRD.Object.pc_icms	[ll_Insert] / 100), 2)
					
					lds_Devolucao_PRD.Object.pc_st_retido					[ll_Insert]	= lds_Item_NF_Origem.Object.pc_st_retido	[1]
					lds_Devolucao_PRD.Object.vl_icms_retido				[ll_Insert]	= round(lds_Item_NF_Origem.Object.vl_icms_retido	[1]	* ll_Qte_Devolver, 2)
					
					ldc_Bc_Icms 	= lds_Devolucao_PRD.Object.vl_bc_icms	[ll_Insert] 
					
					ldc_Total_Item	= round(ll_Qte_Devolver * (round(lds_Devolucao_PRD.Object.vl_preco_unitario[ll_Insert] * ((100 - lds_Devolucao_PRD.Object.pc_desconto[ll_Insert]) / 100), 4)), 2)
					
					If Not lb_Utilizou_Tot_NF Then
						//Caso a base de calculo do icms for maior do que o total do item coloca o total do item na BC ICMS
						If ldc_Bc_Icms > ldc_Total_Item Then
							lds_Devolucao_PRD.Object.vl_bc_icms				[ll_Insert]	= ldc_Total_Item
						End If	
					End If
					
					//Se tiver percentual de ICMS e n$$HEX1$$e300$$ENDHEX$$o teiver a Base de C$$HEX1$$e100$$ENDHEX$$lculo. Essa situa$$HEX2$$e700e300$$ENDHEX$$o ocorre em notas de compra antigas.
					If (lds_Devolucao_PRD.Object.pc_icms	[ll_Insert] > 0) and (lds_Devolucao_PRD.Object.vl_bc_icms	[ll_Insert] = 0) Then
						lds_Devolucao_PRD.Object.vl_bc_icms	[ll_Insert]	=	round((((lds_Devolucao_PRD.Object.vl_preco_unitario[ll_Insert] * lds_Devolucao_PRD.Object.qt_devolvida [ll_Insert]) * 	((100 - lds_Devolucao_PRD.Object.pc_desconto[ll_Insert]) / 100))) * ((100 - lds_Devolucao_PRD.Object.pc_reducao_bc_icms[ll_Insert]) / 100), 2)
						lds_Devolucao_PRD.Object.vl_icms		[ll_Insert]	=	round(lds_Devolucao_PRD.Object.vl_bc_icms[ll_Insert] * (lds_Devolucao_PRD.Object.pc_icms	[ll_Insert] / 100), 2)																	
					End If
					
					// IPI
					lds_Devolucao_PRD.Object.vl_ipi							[ll_Insert]	= round(lds_Item_NF_Origem.Object.vl_ipi[1] * ll_Qte_Devolver, 2)
					
					If  lds_Devolucao_PRD.Object.pc_ipi[ll_Insert] > 0 Then
						lds_Devolucao_PRD.Object.vl_bc_ipi					[ll_Insert]	= round((lds_Devolucao_PRD.Object.vl_ipi[ll_Insert] / lds_Devolucao_PRD.Object.pc_ipi[ll_Insert]) * 100, 2)
					Else
						lds_Devolucao_PRD.Object.vl_bc_ipi					[ll_Insert]	= 0
					End If
					
					// ST
					lds_Devolucao_PRD.Object.vl_bc_icms_st	[ll_Insert]	= round((lds_Item_NF_Origem.Object.vl_bc_icms_st_total	[1] / ll_Qtde_Faturada) * ll_Qte_Devolver, 2)
					
					If round(lds_Devolucao_PRD.Object.vl_bc_icms_st	[ll_Insert] * (lds_Devolucao_PRD.Object.pc_icms_st[ll_Insert] / 100), 2) > 0 Then
						lds_Devolucao_PRD.Object.vl_icms_st			[ll_Insert]	= round(lds_Devolucao_PRD.Object.vl_bc_icms_st	[ll_Insert] * (lds_Devolucao_PRD.Object.pc_icms_st[ll_Insert] / 100), 2) - lds_Devolucao_PRD.Object.vl_icms	[ll_Insert]
					Else
						lds_Devolucao_PRD.Object.vl_icms_st			[ll_Insert]	= 0.00
					End If
								
					lds_Devolucao_PRD.Object.vl_outras_despesas		[ll_Insert]	= round((lds_Item_NF_Origem.Object.vl_outras_despesas[1] / ll_Qtde_Faturada) * ll_Qte_Devolver, 2)						
					
					ls_CST = lds_Devolucao_PRD.Object.cd_cst_tributacao[ll_Insert]
					
					If ls_CST = '10' or ls_CST = '70' Then
						
						If ls_CST = '70' Then
							ls_Sit_Tribut_Nova = '02'
						Else
							ls_Sit_Tribut_Nova = '00'
						End If
						
						lds_Devolucao_PRD.Object.vl_bc_icms_st_auxiliar	[ll_Insert]	= lds_Devolucao_PRD.Object.vl_bc_icms_st	[ll_Insert]
						lds_Devolucao_PRD.Object.vl_icms_st_auxiliar		[ll_Insert]	= lds_Devolucao_PRD.Object.vl_icms_st			[ll_Insert]										
						
						// Acrescenta ao vlr da despesas existente o vlr do icms st
						lds_Devolucao_PRD.Object.vl_outras_despesas[ll_Insert] = 	lds_Devolucao_PRD.Object.vl_outras_despesas[ll_Insert] + lds_Devolucao_PRD.Object.vl_icms_st[ll_Insert]						
																												
						// Multiplicado por 1 somente para efetuar o arrendondamento para 2 casas decimais
						idc_BC_ICMS_ST_DA	+= round(lds_Devolucao_PRD.Object.vl_bc_icms_st[ll_Insert] * 1, 2)
						idc_ICMS_ST_DA		+= round(lds_Devolucao_PRD.Object.vl_icms_st	[ll_Insert] * 1, 2)
																												
						lds_Devolucao_PRD.Object.vl_bc_icms_st		[ll_Insert]	= 0.00
						lds_Devolucao_PRD.Object.vl_icms_st				[ll_Insert]	= 0.00
						lds_Devolucao_PRD.Object.cd_cst_tributacao	[ll_Insert]	= ls_Sit_Tribut_Nova
						lds_Devolucao_PRD.Object.pc_icms_st			[ll_Insert]	= 0.00
					End If
													
					// Multiplicado por 1 somente para efetuar o arrendondamento para 2 casas decimais
					idc_BC_ICMS_ST			+= round(lds_Devolucao_PRD.Object.vl_bc_icms_st			[ll_Insert] * 1, 2)
					idc_ICMS_ST				+= round(lds_Devolucao_PRD.Object.vl_icms_st				[ll_Insert] * 1, 2)
					idc_Outras_Despesas		+= round(lds_Devolucao_PRD.Object.vl_outras_despesas	[ll_Insert] * 1, 2)
									
					// Chamado: 1023779, objetivo $$HEX1$$e900$$ENDHEX$$ utilizar os valores totais da nota que vieram do XML
					If lb_Utilizou_Tot_NF Then
						idc_Total_Produtos		+=	 lds_Devolucao_PRD.Object.vl_total_item				[ll_Insert]
						idc_Total_Desconto		+=	 lds_Devolucao_PRD.Object.vl_desconto_total		[ll_Insert]
						idc_BC_ICMS				+= lds_Devolucao_PRD.Object.vl_bc_icms_total		[ll_Insert]
						
						idc_ICMS						+=	 lds_Devolucao_PRD.Object.vl_icms_total			[ll_Insert]						
						// Campo Auxiliar: Caso d$$HEX1$$ea00$$ENDHEX$$ diferen$$HEX1$$e700$$ENDHEX$$as este $$HEX1$$e900$$ENDHEX$$ utilizado
						idc_ICMS_AUX				+=	 lds_Devolucao_PRD.Object.vl_icms					[ll_Insert]			
						
						idc_BC_IPI					+= lds_Devolucao_PRD.Object.vl_bc_ipi_total			[ll_Insert]
						idc_IPI						+= lds_Devolucao_PRD.Object.vl_ipi_total				[ll_Insert]	
					Else
						// Continua do jeito antigo
						idc_Total_Produtos		+=	round(lds_Devolucao_PRD.Object.vl_preco_unitario	[ll_Insert] * ll_Qte_Devolver, 2)
						idc_Total_Desconto		+=	round(lds_Devolucao_PRD.Object.vl_desconto	[ll_Insert] * ll_Qte_Devolver, 2)
					
						idc_BC_ICMS				+= lds_Devolucao_PRD.Object.vl_bc_icms					[ll_Insert]
						idc_ICMS						+= lds_Devolucao_PRD.Object.vl_icms						[ll_Insert]							
						idc_BC_IPI					+= lds_Devolucao_PRD.Object.vl_bc_ipi						[ll_Insert]
						idc_IPI						+= lds_Devolucao_PRD.Object.vl_ipi							[ll_Insert]	
					End If
					
					// Campos Auxiliares: Caso d$$HEX1$$ea00$$ENDHEX$$ diferen$$HEX1$$e700$$ENDHEX$$as estes s$$HEX1$$e300$$ENDHEX$$o utilizados
					idc_VALIDA_ICMS_TOTAL += lds_Devolucao_PRD.Object.vl_icms_total			[ll_Insert]			
					idc_VALIDA_ICMS			  += lds_Devolucao_PRD.Object.vl_icms					[ll_Insert]		
									
					
					SetNull(ls_CST_PIS)
					SetNull(ls_CST_COFINS)
					
					If Not lo_Fiscal.of_Retorna_Tributacao_Pis_Cofins(	lds_Devolucao_PRD.Object.cd_natureza_operacao	[ll_Insert],&
																						lds_Devolucao_PRD.Object.cd_produto				[ll_Insert],&
																						lds_Devolucao_PRD.Object.vl_preco_unitario		[ll_Insert],&
																						idc_ICMS , &
																						Ref ls_CST_PIS,&
																						Ref ldc_BC_PIS,&
																						Ref ldc_Aliq_PIS,&
																						Ref ldc_PIS,&
																						Ref ls_CST_COFINS,&
																						Ref ldc_BC_COFINS,&
																						Ref ldc_Aliq_COFINS,&
																						Ref ldc_COFINS,&
																						False,&
																						Ref ls_Mensagem_Log) Then
						lb_Sucesso = False
						Exit
					End If
						
					lds_Devolucao_PRD.Object.cd_cst_pis		[ll_Insert]	= ls_CST_PIS
					lds_Devolucao_PRD.Object.vl_bc_pis		[ll_Insert]	= ldc_BC_PIS
					lds_Devolucao_PRD.Object.vl_pis			[ll_Insert]	= round(ldc_PIS,2) //ldc_PIS
					lds_Devolucao_PRD.Object.cd_cst_cofins	[ll_Insert]	= ls_CST_COFINS
					lds_Devolucao_PRD.Object.vl_bc_cofins	[ll_Insert]	= ldc_BC_COFINS
					lds_Devolucao_PRD.Object.vl_cofins		[ll_Insert]	= round(ldc_COFINS,2) //ldc_COFINS
					
					
					If (ls_CST = "20") or (ls_CST = "30") or (ls_CST = "40") or (ls_CST = "41") or (ls_CST = "50") or (ls_CST = "51") or (ls_CST = "70") Then
						ls_Cd_Beneficio = lds_Item_NF_Origem.Object.cd_beneficio	[1]
						
						If ls_Cd_Beneficio <> "" Then
							lds_Devolucao_PRD.Object.cd_beneficio	[ll_Insert]	= ls_Cd_Beneficio
						Else
							If Not of_uf_fornecedor(Ref ls_Uf_Fornecedor, Ref as_Erro) Then
								lb_Sucesso = False
								Exit
							End If
							
							ls_Cd_Beneficio	= lo_Fiscal.of_retorna_codigo_beneficio( "SC",  lds_Item_NF_Origem.Object.cd_natureza_operacao[1], ls_CST, ll_Produto)
							
							lds_Devolucao_PRD.Object.cd_beneficio	[ll_Insert]	= ls_Cd_Beneficio
						End If
					Else
						lds_Devolucao_PRD.Object.cd_beneficio	[ll_Insert]	= ls_Nulo
					End If

					// Cest Da Nota De Compra		
					SetNull(ls_cd_cest_nf_Compra)
					ls_cd_cest_nf_Compra =  lds_Item_NF_Origem.Object.cd_cest[1]
					SetNull(ls_cd_cest_nf_DevCompra)
					
					If  ls_cd_cest_nf_Compra<>'0000000'  Then 
						lds_Devolucao_PRD.Object.cd_cest	[ll_Insert]	=ls_cd_cest_nf_Compra
					Else
						If (ls_CST = "10") or (ls_CST = "30") or (ls_CST = "60") or (ls_CST = "70") Then
							If lo_Cest.of_localiza_cest_produto (ll_Produto , Ref ls_cd_cest_nf_DevCompra) Then 
								lds_Devolucao_PRD.Object.cd_cest	[ll_Insert]    = ls_cd_cest_nf_DevCompra
							End If 
						Else
							// Nulo
							lds_Devolucao_PRD.Object.cd_cest	[ll_Insert]    = ls_cd_cest_nf_DevCompra
						End If 
					End If
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Erro ao inserir um novo registro de devolu$$HEX2$$e700e300$$ENDHEX$$o.')
					lb_Sucesso = False
					Exit
				End If
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'O sistema retornou mais registro do que o esperado.')
				lb_Sucesso = False
				Exit
			End If
		Else
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar os itens da nota fiscal de origem.")	
			lb_Sucesso = False
			Exit
		End If
			
	Next

	// Campos Auxiliares: Caso d$$HEX1$$ea00$$ENDHEX$$ diferen$$HEX1$$e700$$ENDHEX$$as estes s$$HEX1$$e300$$ENDHEX$$o utilizados
	If idc_VALIDA_ICMS_TOTAL = 0	or  IsNull(idc_VALIDA_ICMS_TOTAL) Then 
		idc_VALIDA_ICMS_TOTAL 	= 0.00
	End If 
		
	If idc_VALIDA_ICMS = 0 or  IsNull(idc_VALIDA_ICMS) Then 
		idc_VALIDA_ICMS 	= 0.00
	End If 	
	
	// Somente faz a Troca quando tiver a diferen$$HEX1$$e700$$ENDHEX$$a de Centavos.
	If idc_VALIDA_ICMS_TOTAL <> 0 and idc_VALIDA_ICMS <> 0 Then 
		If idc_VALIDA_ICMS_TOTAL <>  idc_VALIDA_ICMS Then 
				idc_ICMS		 = idc_ICMS_AUX
		End If 
	End If 
			

	If lb_Sucesso Then
		If lds_Devolucao_PRD.RowCount() > 0 Then
			If Not This.of_Grava_Nota(lds_Devolucao_PRD, Ref al_Nota, Ref as_Erro) Then
				lb_Sucesso = False
			End If
		End If
	End If

Finally
	Destroy(lds_Item_NF_Origem)
	Destroy(lds_Devolucao_PRD)
	Destroy(lo_Fiscal)
	Destroy(lo_Cest)
End Try

Return lb_Sucesso
end function

public function boolean of_atualiza_segregado_recebimento (string as_endereco, string as_fornecedor, long al_nota, string as_especie, string as_serie, long al_produto, string as_lote, date adt_validade, long al_qtde_devolvida, long al_nr_controle, ref string as_mensagem);Long ll_Rows

UPDATE wms_segregado_recebimento  
Set qt_lote = qt_lote - :al_qtde_devolvida
Where cd_endereco 		= :as_Endereco
  	and cd_fornecedor 	= :as_Fornecedor   
  	and nr_nf 				= :al_nota  
  	and de_especie 		= :as_especie
  	and de_serie 			= :as_serie
  	and cd_produto 		= :al_produto
  	and nr_lote 				= :as_Lote
  	and dh_validade 		= :adt_Validade
	and nr_controle		= :al_Nr_Controle
Using SqlCa;

If Sqlca.SqlCode = -1 Then
	as_Mensagem = "Erro ao atualizar a qtde do lote do produto '" + String(al_Produto) + "' na tabela wms_segregado_recebimento '" + SQLCA.SQLErrText + "'."
	Return False
Else
	ll_Rows = Sqlca.SQLNRows 
	
	// Se atualizou o registro, exclui se a quantidade do lote estiver zerada
	If ll_Rows = 1 Then
		Delete from wms_segregado_recebimento  
		Where cd_endereco 	= :as_Endereco
			and cd_fornecedor 	= :as_Fornecedor   
			and nr_nf 				= :al_nota  
			and de_especie 		= :as_especie
			and de_serie 			= :as_serie
			and cd_produto 		= :al_produto
			and nr_lote 			= :as_Lote
			and dh_validade 	= :adt_Validade
			and qt_lote 			= 0
		Using SqlCa;
		
		If Sqlca.SqlCode = -1 Then
			as_Mensagem = "Erro excluir o produto '" + String(al_Produto) + "' com qtde zero na tabela wms_segregado_recebimento '" + SQLCA.SQLErrText + "'."
			Return False
		End If
	ElseIf ll_Rows > 1 Then
		as_Mensagem = "Foram encontrados mais que um registro do produto '" + String(al_Produto) + "' na tabela wms_segregado_recebimento."
		Return False
	Else // Neste caso n$$HEX1$$e300$$ENDHEX$$o encontrou nehum registro com fornecedor/nota
		
		UPDATE wms_segregado_recebimento  
		Set qt_lote = qt_lote - :al_qtde_devolvida
		Where cd_endereco 		= :as_Endereco
			and cd_fornecedor 	is null
			and nr_nf 				is null
			and de_especie 		is null
			and de_serie 			is null
			and cd_produto 		= :al_produto
			and nr_lote 				= :as_Lote
			and dh_validade 		= :adt_Validade
			and nr_controle		= :al_Nr_Controle
		Using SqlCa;

		If Sqlca.SqlCode = -1 Then
			as_Mensagem = "Erro ao atualizar a qtde do lote do produto '" + String(al_Produto) + "' na tabela wms_segregado_recebimento '" + SQLCA.SQLErrText + "'."
			Return False
		Else
			ll_Rows = Sqlca.SQLNRows 

			// Se atualizou o registro, exclui se a quantidade do lote estiver zerada
			If ll_Rows = 1 Then
				Delete from wms_segregado_recebimento  
				Where cd_endereco 	= :as_Endereco
					and cd_fornecedor 	is null
					and nr_nf 				is null
					and de_especie 		is null
					and de_serie 			is null
					and cd_produto 		= :al_produto
					and nr_lote 			= :as_Lote
					and dh_validade 	= :adt_Validade
					and qt_lote 			= 0
				Using SqlCa;
		
				If Sqlca.SqlCode = -1 Then
					as_Mensagem = "Erro excluir o produto '" + String(al_Produto) + "' com qtde zero na tabela wms_segregado_recebimento '" + SQLCA.SQLErrText + "'."
					Return False
				End If
			ElseIf ll_Rows > 1 Then
				as_Mensagem = "Foram encontrados mais que um registro do produto '" + String(al_Produto) + "' na tabela wms_segregado_recebimento."
				Return False
			Else
				as_Mensagem = "N$$HEX1$$e300$$ENDHEX$$o foi encontrado lote do produto '" + String(al_Produto) + "' na tabela wms_segregado_recebimento."
				Return False				
			End If
			
		End If // Fim do update sem fornecedor/nota
		
	End If
		
End If // Fim do update com fornecedor/nota

Return True
end function

public function boolean of_localiza_fornecedor_dev_compra (string as_fornecedor, ref string as_fornecedor_dev_compra, ref string as_erro);select cd_fornecedor_dev_compra
into :as_Fornecedor_Dev_Compra
from fornecedor
where cd_fornecedor = :as_Fornecedor
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Trim(as_fornecedor_Dev_Compra) = "" Then
			SetNull(as_fornecedor_Dev_Compra)
		End If
	Case 100
		as_Erro	= "N$$HEX1$$e300$$ENDHEX$$o foi localizdo o fornecedor '"+as_Fornecedor+"'. Fun$$HEX2$$e700e300$$ENDHEX$$o 'of_Localiza_Fornecedor_Emissao_Nfe'"
		Return False
	Case -1
		as_Erro	= "Erro ao localizar o c$$HEX1$$f300$$ENDHEX$$digo do fornecedor que ser$$HEX1$$e100$$ENDHEX$$ enviado a nota: "+SqlCa.SqlErrText
		Return False
End Choose


Return True
end function

on uo_ge252_nota_fiscal_devolucao_compra.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge252_nota_fiscal_devolucao_compra.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;String	ls_msg


if not gf_verifica_inicio_operacao_sap('DH_INICIO_OPERACAO_SAP', ref ib_Iniciado_Operacao_SAP, ref ls_msg ) then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a data de in$$HEX1$$ed00$$ENDHEX$$cio de opera$$HEX2$$e700e300$$ENDHEX$$o do SAP.', StopSign!)
	return -1
end if
end event

