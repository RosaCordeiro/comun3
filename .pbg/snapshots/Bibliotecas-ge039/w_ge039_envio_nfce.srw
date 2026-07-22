HA$PBExportHeader$w_ge039_envio_nfce.srw
forward
global type w_ge039_envio_nfce from dc_w_response_ok_cancela
end type
type cb_selecao from commandbutton within w_ge039_envio_nfce
end type
end forward

global type w_ge039_envio_nfce from dc_w_response_ok_cancela
integer width = 1984
string title = "GE039 - Envio NFC-e Pendente"
cb_selecao cb_selecao
end type
global w_ge039_envio_nfce w_ge039_envio_nfce

type variables
uo_tributacao_icms 	ivo_tributacao_icms
uo_produto 				ivo_produto	

dc_uo_ds_base 		ids_itens_nfce
dc_uo_ds_base 		ids_dados_tef
dc_uo_ds_base 		ids_pgto


STRING  cd_tipo_pagamento[]
STRING  de_dados_tef[]
STRING 	cd_cliente
STRING 	nm_cliente
STRING 	is_endereco_cliente
STRING 	is_bairro_cliente
STRING 	is_cep_cliente
STRING 	is_uf_cliente
STRING 	id_cliente_pf_pj
STRING 	id_tipo_cliente_clube
STRING 	cd_cidade_ibge
STRING 	is_cidade_cliente
STRING 	de_email
STRING 	nr_endereco_cliente
STRING	cd_cest_generico
STRING	nr_chave_nfce
STRING 	cd_status_nfce
STRING 	de_motivo_nfce
STRING 	cd_protocolo_nfce
STRING  de_dir_xml_nfce
STRING 	nr_chave_nova
STRING 	id_envia_responsavel
STRING	id_presenca
STRING	id_intermediador_nfce
STRING  nr_cpf_transp
STRING	nr_cnpj_transp
STRING	de_nome_transp
STRING	de_end_transp
STRING	de_cidade_transp
STRING	cd_uf_transp
STRING 	dt_envio_codigo_sap

STRING is_Plataforma_Ecommerce

DECIMAL {2} vl_tipo_pagamento[]
DECIMAL {2} vl_total_imposto
DECIMAL {2} vl_total_desconto_itens_nfce
DECIMAL {2} vl_total_PIS
DECIMAL {2} vl_total_COFINS
DECIMAL {2} vl_total_icms
DECIMAL {2} vl_total_base_icms
DECIMAL {2} vl_maximo_produto_gratis
DECIMAL {2} pc_imposto_padrao
DECIMAL {2} vl_total_ICMS_Desonerado


DateTime dt_data_recebimento_nfce

LONG id_retorno_nfce
end variables

forward prototypes
public function boolean wf_processa_itens (long pl_filial, long pl_nf, string ps_especie, string ps_serie, decimal pdc_pc_desconto_subtotal, decimal pdc_vl_desconto_gratis)
public subroutine wf_inicia_variaveis ()
public function boolean wf_carrega_formas_pgto (long pl_filial, long pl_nf, string ps_especie, string ps_serie, string ps_forma_pgto, decimal pdc_total_nf, string ps_tipo_venda, decimal pdc_pago_avista)
public function boolean wf_busca_dados_entregador (string ps_cod_fornecedor)
end prototypes

public function boolean wf_processa_itens (long pl_filial, long pl_nf, string ps_especie, string ps_serie, decimal pdc_pc_desconto_subtotal, decimal pdc_vl_desconto_gratis);Long 	ll_row, &
		ll_find, &
		ll_start, &
		ll_pag, &
		ll_classificacao_fiscal, &
		ll_contador
		
String 	ls_produto, &
			ls_descricao, &
			ls_unidade, &
			ls_PIS_COFINS, &
			ls_cest, &
			ls_cod_sap

String ls_Beneficio
String ls_Motivo_Desoneracao
String ls_Cst_Tributacao
String ls_Cst_Pis
String ls_Cst_Cofins

Integer li_Nr_Item

Decimal {2}	ldc_pc_imposto, &
				ldc_total_icms, &
				ldc_total_base_icms
Decimal ldc_pRedBCEfet, ldc_vBCEfet, ldc_pICMSEfet, ldc_vICMSEfet				
Decimal ldc_Valor_ICMS_Desonerado

String ls_complemento, ls_tributacao_icms,  ls_cst_origem
Long ll_qtd, ll_natureza_operacao
Decimal {2} ldc_unitario, ldc_PrecoTotal, ldc_pc_icms, ldc_vl_desconto, ldc_vl_imposto,ldc_praticado,ldc_pc_desconto

Try
	ids_itens_nfce.of_RestoreSqlOriginal()
	ids_itens_nfce.Retrieve(gvo_parametro.cd_filial,pl_nf,ps_especie,ps_serie)
	
	vl_total_icms 					= 000.00
	vl_total_base_icms 			= 000.00
	vl_total_ICMS_Desonerado	= 0.00
	
	uo_tratamento_fiscal lvo_tratamento_fiscal  //GE021
	lvo_tratamento_fiscal = Create uo_tratamento_fiscal 
	
	lvo_tratamento_fiscal.of_grava_contribuinte(FALSE)
	
	lvo_tratamento_fiscal.of_grava_uf_origem_destino(gvo_parametro.ivs_uf_filial,gvo_parametro.ivs_uf_filial)
	
	lvo_tratamento_fiscal.of_grava_operacao(lvo_tratamento_fiscal.VENDA)
	
	If ids_itens_nfce.RowCount() > 0 Then				
		For ll_row = 1 TO ids_itens_nfce.RowCount()
			If ids_itens_nfce.Object.id_cancelado[ll_row] = "S" Then Continue												

			ls_produto = String(ids_itens_nfce.Object.cd_produto[ll_row])
			ivo_produto.of_Localiza_Produto(ls_Produto)						
			If Not ivo_produto.Localizado Then
				Return False
			End If						
			ls_descricao	 			= ivo_produto.de_produto + " " + ivo_produto.De_Apresentacao_venda
			ls_unidade				= ivo_produto.Cd_Unidade_Medida_venda
			ls_PIS_COFINS 		= ivo_produto.id_situacao_pis_cofins
			ll_classificacao_fiscal = ivo_produto.nr_classificacao_fiscal
			ls_cest					= ivo_produto.cd_cest
			If IsNull(ls_cest) Or Trim(ls_cest) = '' Then
				ls_cest = cd_cest_generico
			End If						
			If ll_classificacao_fiscal = 99999999 Then ll_classificacao_fiscal = 0									
			If IsNull(ivo_produto.pc_imposto_cupom) or ivo_produto.pc_imposto_cupom = 000.00 Then
				ldc_pc_imposto =	pc_imposto_padrao
			Else	
				ldc_pc_imposto = ivo_produto.pc_imposto_cupom
			End If
			//Verificar data para come$$HEX1$$e700$$ENDHEX$$ar a alimentar, sen$$HEX1$$e300$$ENDHEX$$o passar vazio
			If IsDate(dt_envio_codigo_sap) Then
				If Date(gf_getserverdate()) >= Date(dt_envio_codigo_sap)  Then
					ls_cod_sap 			    = ivo_produto.cd_produto_sap
				Else
					ls_cod_sap = ''
				End If
			End If				
			
			ls_complemento 	= ''
			ll_qtd 					= 0
			ldc_unitario			= 0
			ldc_PrecoTotal		= 0
			ldc_pc_icms			= 0
			ldc_vl_desconto	= 0
			ldc_vl_imposto		= 0
			ldc_praticado		= 0 
			ldc_pc_desconto	= 0
						
			ll_contador 	= ids_itens_nfce.Object.nr_sequencial		[ll_row]		
			ls_produto 	= String(ids_itens_nfce.Object.cd_produto	[ll_row])		
			ll_qtd	       	= ids_itens_nfce.Object.qt_vendida			[ll_row]		
			ldc_unitario	= ids_itens_nfce.Object.vl_preco_unitario 	[ll_row]
			
			ls_Beneficio		= ids_itens_nfce.Object.cd_beneficio	[ll_row]		
			li_Nr_Item		= ids_itens_nfce.Object.nr_item		[ll_row]		
			ls_Cst_Pis		= ids_itens_nfce.Object.cd_cst_pis	[ll_row]		
			ls_Cst_Cofins	= ids_itens_nfce.Object.cd_cst_cofins	[ll_row]		
						
			//Na NFCe o desconto subtotal deve ser rateado entre os itens.
			If pdc_pc_desconto_subtotal > 0 Then
				ldc_praticado   = ids_itens_nfce.Object.vl_preco_praticado[ll_row] - Round(((ids_itens_nfce.Object.vl_preco_praticado[ll_row] * pdc_pc_desconto_subtotal)  / 100 ) , 2 )
			Else
				ldc_praticado   = ids_itens_nfce.Object.vl_preco_praticado[ll_row]
			End If
			
			//Tratamento para produto Gratis(0,01)
			If (pdc_vl_desconto_gratis > 0) And Round(ids_itens_nfce.Object.vl_preco_praticado[ll_row],2) <= vl_maximo_produto_gratis Then
				ldc_praticado = 000.00
			End If	
			
			If ldc_praticado > ldc_unitario Then
				ldc_unitario = ldc_praticado
			End If
			
			ldc_PrecoTotal 						= Round(ll_qtd * ldc_unitario,2)
			ls_tributacao_icms 				= ids_itens_nfce.Object.cd_situacao_tributaria		[ll_row]		
			ldc_vl_desconto 					= Round(ll_qtd * ldc_unitario,2) - Round(ll_qtd * ldc_praticado,2)		
			
			//Calculo para lei De Olho no Imposto na NFCE
			ldc_vl_imposto 						= Round( ldc_pc_imposto * ( ldc_praticado / 100 ) , 2 )	* ll_qtd
			ll_natureza_operacao 			= ids_itens_nfce.Object.cd_natureza_operacao		[ll_row]
			ls_Cst_Tributacao					= ids_itens_nfce.Object.cd_cst_tributacao			[ll_row]
			
			ls_cst_origem 						= ids_itens_nfce.Object.cd_cst_origem				[ll_row]
			ldc_pc_icms 						= ids_itens_nfce.Object.pc_icms						[ll_row]
			vl_total_imposto 					+= ldc_vl_imposto
			vl_total_desconto_itens_nfce 	+= ldc_vl_desconto
			
			If ls_pis_cofins = "T" And ls_Cst_Pis = '01' Then
				vl_total_PIS 		+= ((ldc_praticado * ll_qtd) * 1.65) / 100
				vl_total_COFINS 	+= ((ldc_praticado * ll_qtd) * 7.60) / 100 
			End If
			
			If IsNull(ids_itens_nfce.Object.vl_bc_icms_efetivo[ll_row]) Then
				If Not lvo_tratamento_fiscal.of_calcula_icms_efetivo( ivo_produto.Cd_Produto, RightA(ls_tributacao_icms,1) + '0', ivo_produto.cd_tipo_icms, ids_itens_nfce.Object.qt_vendida[ll_row], ldc_praticado, &
						ref ldc_pRedBCEfet, ref ldc_vBCEfet, ref ldc_pICMSEfet, ref ldc_vICMSEfet) Then
					Return False								
				End If
			Else
				ldc_pRedBCEfet 	= ids_itens_nfce.Object.pc_red_bc_icms_efetivo	[ll_row]
				ldc_vBCEfet			= ids_itens_nfce.Object.vl_bc_icms_efetivo			[ll_row]
				ldc_pICMSEfet		= ids_itens_nfce.Object.pc_icms_efetivo				[ll_row]
				ldc_vICMSEfet		= ids_itens_nfce.Object.vl_icms_efetivo				[ll_row]				
			End If		
			
			ivo_tributacao_icms.of_localiza_tributacao_cst( ls_Cst_Tributacao )
			
			lvo_tratamento_fiscal.of_grava_icms_produto(	 ivo_produto.cd_produto, &
																		 ll_qtd, & 
																		 ldc_praticado, &
																		 0,&
																		 ivo_tributacao_icms.cd_tributacao_icms, &
																		 ldc_pc_icms)
		
			ls_Motivo_Desoneracao 					= lvo_tratamento_fiscal.ivo_atributo_nf.id_motivo_desoneracao
				
			ldc_Valor_ICMS_Desonerado 			= Round( lvo_tratamento_fiscal.ivo_atributo_nf.vl_icms_desonerado * ll_qtd, 3)
			If ldc_Valor_ICMS_Desonerado >= 0.001 And Round(ldc_Valor_ICMS_Desonerado,2) = 0.00 Then
				ldc_Valor_ICMS_Desonerado = 0.01
			End If		
			
			If IsNull( ldc_Valor_ICMS_Desonerado ) Then ldc_Valor_ICMS_Desonerado = 0
			
			VL_Total_ICMS_Desonerado += ldc_Valor_ICMS_Desonerado
			
			//ls_Cst_Pis = ls_Cst_Cofins
			If Not pdv.of_registra_item_nfce(ll_contador, ls_produto, ll_qtd, ldc_unitario, ldc_PrecoTotal, ls_descricao,ldc_pc_icms,&
													  ls_complemento, ls_Cst_Tributacao, ls_Unidade,ll_classificacao_fiscal ,ll_natureza_operacao,&
													  ldc_vl_desconto,ldc_vl_imposto,ls_cst_origem,ls_pis_cofins, ldc_praticado, Ref ldc_total_icms,&
													  Ref ldc_total_base_icms, ls_cest, ivo_produto.cd_tributacao_icms, ivo_produto.de_codigo_barras, &
													  ldc_pRedBCEfet, ldc_vBCEfet, ldc_pICMSEfet, ldc_vICMSEfet, ls_Beneficio, li_Nr_Item, &
													  ldc_Valor_ICMS_Desonerado, ls_Motivo_Desoneracao, ls_cod_sap, ls_Cst_Pis) THEN	
				Return False
			End If
	
			vl_total_icms += ldc_total_icms
			vl_total_base_icms += ldc_total_base_icms
		Next
		//ldc_icms = ivo_venda.vl_total_icms
		//ldc_bc_icms = ivo_venda.vl_total_base_icms
	Else
		Return False
	End If	
	
Finally
	Destroy(lvo_tratamento_fiscal)	
	
End Try

Return True
end function

public subroutine wf_inicia_variaveis ();String ls_nulo[]
Decimal {2} ld_nulo[]

cd_tipo_pagamento = ls_nulo
vl_tipo_pagamento = ld_nulo
de_dados_tef = ls_nulo

SetNull(cd_cliente)
SetNull(nm_cliente)
SetNull(is_endereco_cliente)
SetNull(is_bairro_cliente)
SetNull(is_cep_cliente)
SetNull(is_uf_cliente)
SetNull(id_cliente_pf_pj)
SetNull(id_tipo_cliente_clube)
SetNull(cd_cidade_ibge)
SetNull(is_cidade_cliente)
SetNull(de_email)
SetNull(nr_endereco_cliente)
SetNull(nr_chave_nfce)
SetNull(cd_status_nfce)
SetNull(de_motivo_nfce)
SetNull(cd_protocolo_nfce)
SetNull(de_dir_xml_nfce)
SetNull(nr_chave_nova)
SetNull(nr_cpf_transp)
SetNull(nr_cnpj_transp)
SetNull(de_nome_transp)
SetNull(de_end_transp)
SetNull(de_cidade_transp)
SetNull(cd_uf_transp)
SetNull(is_Plataforma_Ecommerce)

id_presenca = '1'
id_intermediador_nfce = '0'

vl_total_imposto 				= 0.000
vl_total_desconto_itens_nfce= 0.000
vl_total_PIS 						= 0.000
vl_total_COFINS 				= 0.000
vl_total_icms 					= 0.000
vl_total_base_icms 			= 0.000
vl_total_ICMS_Desonerado 	= 0.00

SetNull(dt_data_recebimento_nfce)
SetNull(id_retorno_nfce)
end subroutine

public function boolean wf_carrega_formas_pgto (long pl_filial, long pl_nf, string ps_especie, string ps_serie, string ps_forma_pgto, decimal pdc_total_nf, string ps_tipo_venda, decimal pdc_pago_avista);Long 	ll_ind, &
		ll_find, &
		ll_start, &
		ll_pag

Decimal {2} ldc_total_convenio

Try

	ids_dados_tef.of_RestoreSqlOriginal()
	ids_dados_tef.Retrieve(pl_filial,pl_nf,ps_especie,ps_serie)		
	
	If This.is_Plataforma_Ecommerce = '6' Then //Rappi
		This.cd_tipo_pagamento	[01] = "06"							
		This.de_dados_tef			[01] = ""		
		This.vl_tipo_pagamento 	[01] = pdc_total_nf
		Return True
	End If
	
	If ps_forma_pgto = 'MF' Then
		ids_pgto.of_RestoreSqlOriginal()
		ids_pgto.Retrieve(pl_filial,pl_nf,ps_especie,ps_serie)				
		If ids_pgto.RowCount() > 0 Then				
			For ll_pag = 1 TO ids_pgto.RowCount()
				ll_ind ++
				Choose Case ids_pgto.Object.cd_forma_pagamento[ll_pag]
					Case "DI"
						This.cd_tipo_pagamento[ll_ind] = "01"
						This.de_dados_tef[ll_ind] = ""
					Case "HA"
						This.cd_tipo_pagamento[ll_ind] = "02"
						This.de_dados_tef[ll_ind] = ""								
					Case "HP"
						This.cd_tipo_pagamento[ll_ind] = "03"
						This.de_dados_tef[ll_ind] = ""
					Case "CP"
						This.cd_tipo_pagamento[ll_ind] = "04"
						ll_find    = ids_dados_tef.Find ("nr_nf = " + STRING(pl_nf),ll_start,ids_dados_tef.RowCount())
						If ll_find >= 1 Then
							This.de_dados_tef[ll_ind] = String(ids_dados_tef.Object.cd_bandeira_sefaz[ll_find],"00") + '|' + ids_dados_tef.Object.nr_nsu[ll_find] + '|' + ids_dados_tef.Object.nr_cnpj_credenciadora[ll_find]
							ll_start = ll_find + 1
						Else
							//Sen$$HEX1$$e300$$ENDHEX$$o encontrar comprovante de cart$$HEX1$$e300$$ENDHEX$$o para venda, envia como dinheiro.
							This.cd_tipo_pagamento[ll_ind] = "01"									
							This.de_dados_tef[ll_ind] = ""											
						End If													
					Case "CA","CD"
						This.cd_tipo_pagamento[ll_ind] = "05"
						ll_find    = ids_dados_tef.Find ("nr_nf = " + STRING(pl_nf),ll_start,ids_dados_tef.RowCount())
						If ll_find >= 1 Then
							Choose Case Trim(ids_dados_tef.Object.nm_produto[ll_find])
								Case 'CARTEIRA DIGITAL PIX'
									This.cd_tipo_pagamento[ll_ind] = "17"
									This.de_dados_tef[ll_ind] = ""
								Case 	'CARTEIRA DIGITAL PICPAY', 'CARTEIRA MERCADO PAGO', 'CARTEIRA DIGITAL AME'
									This.cd_tipo_pagamento[ll_ind] = "18"
									This.de_dados_tef[ll_ind] = ""
								Case Else							
									This.de_dados_tef[ll_ind] = String(ids_dados_tef.Object.cd_bandeira_sefaz[ll_find],"00") + '|' + ids_dados_tef.Object.nr_nsu[ll_find] + '|' + ids_dados_tef.Object.nr_cnpj_credenciadora[ll_find]									
							End Choose
							ll_start = ll_find + 1
						Else
							//Sen$$HEX1$$e300$$ENDHEX$$o encontrar comprovante de cart$$HEX1$$e300$$ENDHEX$$o para venda, envia como dinheiro.
							This.cd_tipo_pagamento[ll_ind] = "01"																		
							This.de_dados_tef[ll_ind] = ""											
						End If																					
					Case "CV"
						This.cd_tipo_pagamento[ll_ind] = "06"
						This.de_dados_tef[ll_ind] = ""								
					Case "CR"
						This.cd_tipo_pagamento[ll_ind] = "07"												
						This.de_dados_tef[ll_ind] = ""								
					Case "CC"
						This.cd_tipo_pagamento[ll_ind] = "08"												
						This.de_dados_tef[ll_ind] = ""								
					Case Else
						This.cd_tipo_pagamento[ll_ind] = "10"
						This.de_dados_tef[ll_ind] = "PBM"								
				End Choose
				This.vl_tipo_pagamento 	[ll_ind] = ids_pgto.Object.vl_pagamento[ll_pag]				
			Next
			If ps_tipo_venda = 'CV' And (pdc_pago_avista > 0) Then
				If (pdc_total_nf - pdc_pago_avista) > 0 Then
					ldc_total_convenio = pdc_total_nf - pdc_pago_avista
					ll_ind ++
					This.cd_tipo_pagamento[ll_ind] 	= "06"
					This.de_dados_tef[ll_ind] 			= ""
					This.vl_tipo_pagamento 	[ll_ind] 	= ldc_total_convenio
				End If
			End If								
		End If
	Else
		Choose Case ps_forma_pgto
			Case "DI"
				This.cd_tipo_pagamento[01] = "01"
				This.de_dados_tef[01] = ""						
			Case "HA"
				This.cd_tipo_pagamento[01] = "02"
				This.de_dados_tef[01] = ""						
			Case "HP"
				This.cd_tipo_pagamento[01] = "03"
				This.de_dados_tef[01] = ""						
			Case "CP"
				This.cd_tipo_pagamento[01] = "04"
				ll_find    = ids_dados_tef.Find ("nr_nf = " + STRING(pl_nf),ll_start,ids_dados_tef.RowCount())
				If ll_find >= 1 Then
					This.de_dados_tef[01] = String(ids_dados_tef.Object.cd_bandeira_sefaz[ll_find],"00") + '|' + ids_dados_tef.Object.nr_nsu[ll_find] + '|' + ids_dados_tef.Object.nr_cnpj_credenciadora[ll_find]
					ll_start = ll_find + 1
				Else
					//Sen$$HEX1$$e300$$ENDHEX$$o encontrar comprovante de cart$$HEX1$$e300$$ENDHEX$$o para venda, envia como dinheiro.
					This.cd_tipo_pagamento[01] = "01"							
					This.de_dados_tef[01] = ""											
				End If
			Case "CA"
				This.cd_tipo_pagamento[01] = "05"
				ll_find    = ids_dados_tef.Find ("nr_nf = " + STRING(pl_nf),ll_start,ids_dados_tef.RowCount())
				If ll_find >= 1 Then
					Choose Case Trim(ids_dados_tef.Object.nm_produto[ll_find])
						Case 'CARTEIRA DIGITAL PIX'
							This.cd_tipo_pagamento[01] = "17"
							This.de_dados_tef[01] = ""
						Case 	'CARTEIRA DIGITAL PICPAY', 'CARTEIRA MERCADO PAGO', 'CARTEIRA DIGITAL AME'
							This.cd_tipo_pagamento[01] = "18"
							This.de_dados_tef[01] = ""
						Case Else							
							This.de_dados_tef[01] = String(ids_dados_tef.Object.cd_bandeira_sefaz[ll_find],"00") + '|' + ids_dados_tef.Object.nr_nsu[ll_find] + '|' + ids_dados_tef.Object.nr_cnpj_credenciadora[ll_find]
					End Choose
					ll_start = ll_find + 1
				Else
					//Sen$$HEX1$$e300$$ENDHEX$$o encontrar comprovante de cart$$HEX1$$e300$$ENDHEX$$o para venda, envia como dinheiro.
					This.cd_tipo_pagamento[01] = "01"																
					This.de_dados_tef[01] = ""											
				End If						
			Case "CV"
				This.cd_tipo_pagamento[01] = "06"
				This.de_dados_tef[01] = ""						
			Case "CR"
				This.cd_tipo_pagamento[01] = "07"												
				This.de_dados_tef[01] = ""						
			Case "CC"
				This.cd_tipo_pagamento[01] = "08"												
				This.de_dados_tef[01] = ""						
			Case Else
				This.cd_tipo_pagamento[01] = "10"
				This.de_dados_tef[01] = "PBM"						
		End Choose
		If ps_tipo_venda = 'CV' And (pdc_pago_avista > 0) Then
			If (pdc_total_nf - pdc_pago_avista) > 0 Then
				This.vl_tipo_pagamento 	[01] = pdc_pago_avista		
				 
				ldc_total_convenio = pdc_total_nf - pdc_pago_avista				
				This.cd_tipo_pagamento[02] 	= "06"
				This.de_dados_tef[02] 			= ""
				This.vl_tipo_pagamento 	[02] 	= ldc_total_convenio
			Else
				This.vl_tipo_pagamento 	[01] = pdc_total_nf
			End If
		Else
			This.vl_tipo_pagamento 	[01] = pdc_total_nf			
		End If		
	End If
	
Finally
	
End Try

Return True
end function

public function boolean wf_busca_dados_entregador (string ps_cod_fornecedor);String ls_fantasia, ls_tipo, ls_cnpj, ls_cpf, ls_endereco, ls_uf, ls_cidade

select f.nm_fantasia, f.id_fisica_juridica, f.nr_cgc, f.nr_cpf, f.de_endereco, c.cd_unidade_federacao, c.nm_cidade
	Into :ls_fantasia, :ls_tipo, :ls_cnpj, :ls_cpf, :ls_endereco, :ls_uf, :ls_cidade
from fornecedor f 
	inner join cidade c
		on c.cd_cidade = f.cd_cidade  
where f.cd_fornecedor = :ps_cod_fornecedor;

Choose Case Sqlca.Sqlcode
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao verificar dados transp Disque.",StopSign!)
		Return False
	Case 100		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cadastro transp. Disque n$$HEX1$$e300$$ENDHEX$$o encontrado. Cod. Fornecedor: " + ps_cod_fornecedor ,StopSign!)
		Return False
	Case 0
		This.nr_cpf_transp = ls_cpf
		This.nr_cnpj_transp = ls_cnpj
		This.de_nome_transp = ls_fantasia
		This.de_cidade_transp = ls_cidade
		This.de_end_transp = ls_endereco
		This.cd_uf_transp	=	ls_uf
		
End Choose	

Return True
end function

on w_ge039_envio_nfce.create
int iCurrent
call super::create
this.cb_selecao=create cb_selecao
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_selecao
end on

on w_ge039_envio_nfce.destroy
call super::destroy
destroy(this.cb_selecao)
end on

event ue_postopen;call super::ue_postopen;String ls_valor_gratis

If gvo_aplicacao.ivo_seguranca.cd_sistema = 'CL' Then
	dw_1.of_AppendWhere("n.cd_caixa = '" + PDV.cd_caixa + "'")
End If

dw_1.Event ue_Retrieve()

If dw_1.RowCount() = 0 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma NFC-e pendente de envio!")
	This.cb_selecao.enabled = False
	This.cb_OK.enabled 		= False
End If

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

lvo_Parametro.of_Localiza_Parametro("VL_MAXIMO_PRODUTO_GRATIS", ref ls_valor_gratis, False)
If Not IsNull(ls_valor_gratis) And Trim(ls_valor_gratis) <> '' Then
	If IsNumber(ls_valor_gratis) Then
		vl_maximo_produto_gratis = Dec(ls_valor_gratis)
	End If
End If
lvo_Parametro.of_Localiza_Parametro("CD_CEST_GENERICO", ref cd_cest_generico, False)
lvo_Parametro.of_Localiza_Parametro('PC_IMPOSTO_PADRAO', ref pc_imposto_padrao)
lvo_Parametro.of_Localiza_Parametro("ID_RESPONSAVEL_TECNICO_NF", ref id_envia_responsavel, False)
If Not IsNull(id_envia_responsavel) And Trim(id_envia_responsavel) <> '' Then
	id_envia_responsavel = Trim(Upper(id_envia_responsavel))
End If
lvo_Parametro.of_Localiza_Parametro("DH_INICIO_ENVIO_CODIGO_SAP_XML", ref dt_envio_codigo_sap, False)

Destroy(lvo_Parametro)

ivo_produto 				= Create uo_produto
ivo_tributacao_icms 	= Create uo_tributacao_icms

ids_itens_nfce = Create dc_uo_ds_base
If Not ids_itens_nfce.of_ChangeDataObject('ds_ge039_itens_nfce') Then Return

ids_dados_tef = Create dc_uo_ds_base
If Not ids_dados_tef.of_ChangeDataObject('ds_ge039_dados_tef') Then Return

ids_pgto = Create dc_uo_ds_base				
If Not ids_pgto.of_ChangeDataObject('ds_ge039_formas_pgto') Then Return


end event

event close;call super::close;If IsValid( ids_dados_tef ) 			Then Destroy(ids_dados_tef)
If IsValid( ids_pgto ) 					Then Destroy(ids_pgto)
If IsValid( ivo_produto ) 				Then Destroy(ivo_produto)
If IsValid( ids_itens_nfce ) 			Then Destroy(ids_itens_nfce)
If IsValid( ids_dados_tef	)			Then Destroy(ids_dados_tef)
If IsValid( ids_pgto ) 					Then Destroy(ids_pgto)
If IsValid( ivo_tributacao_icms ) 	Then Destroy(ivo_tributacao_icms)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge039_envio_nfce
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge039_envio_nfce
integer width = 1929
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge039_envio_nfce
integer width = 1874
integer height = 1036
string dataobject = "dw_ge039_envio_nfce"
boolean vscrollbar = true
end type

event dw_1::constructor;call super::constructor;This.of_SetRowSelection( 'if( id_possui_rejeicao = ~"S~", rgb(255, 0, 0), ' + This.ivs_Cor_Linha_Padrao + ")", "", False )
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge039_envio_nfce
integer x = 1289
integer y = 1164
end type

event cb_ok::clicked;call super::clicked;Long ll_row, &
	   ll_nota, &
	   ll_find, &
	   ll_seqcaixa
Boolean 	lb_programa_governo, &
			lb_mesmo_cpf

String ls_cpf_cgc
String ls_nulo[]
String ls_especie
String ls_serie
String ls_inf_adicional
String ls_inf_Fisco
String ls_ident_intermediador_ifood
String ls_ident_intermediador_cr
String ls_ident_intermediador_RAPPI
String ls_ident_intermediador_envio
String ls_entregador
String ls_pedido_drogaexpress

Decimal {2} ldc_bc_icms, ldc_icms, ldc_bc_icms_st, ldc_icms_st, ldc_total_produtos, ldc_frete, ldc_outros, & 
				ldc_pc_desconto_subtotal, ldc_total_nf, ldc_total_bruto, ldc_pc_imposto, ldc_vl_desconto_gratis, &
				ldc_total_icms, ldc_total_base_icms
				
DateTime ldt_data_emi				

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial		
lvo_Parametro.of_Localiza_Parametro("CD_IFOOD_FILIAL", ref ls_ident_intermediador_ifood, False) //Ifood
lvo_Parametro.of_Localiza_Parametro("CD_CONSULTA_REMEDIO_FILIAL", ref ls_ident_intermediador_cr, False) //Consulta Rem$$HEX1$$e900$$ENDHEX$$dio
lvo_Parametro.of_Localiza_Parametro("CD_PRESTADOR_SERVICO_DISQUE_ENTREGA", ref ls_entregador, False)		
lvo_Parametro.of_Localiza_Parametro("CD_RAPPI_FILIAL", ref ls_ident_intermediador_RAPPI, False)	//Rappi
Destroy(lvo_Parametro)

Try
	uo_cliente	lvo_cliente
	lvo_Cliente   = Create uo_Cliente
	
	ll_find    = dw_1.Find ("id_selecao = 'S'",1,dw_1.RowCount())
	If ll_find = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma NFC-e selecionada para envio.")
		Return -1		
	End If	
	
	For ll_row = 1 TO dw_1.RowCount()	
		If dw_1.Object.id_selecao[ll_row] = "S" Then
			
			wf_inicia_variaveis()
			
			Open(w_Janela_Aguarde)	
			
			SetNull(ls_ident_intermediador_envio)
			ll_nota 							= dw_1.Object.nr_nf								[ll_row]
			ls_especie 						= dw_1.Object.de_especie						[ll_row]
			ls_serie							= dw_1.Object.de_serie							[ll_row]
			ls_pedido_drogaexpress 		= dw_1.Object.nr_pedido_drogaexpress		[ll_row]
			ll_seqcaixa  						= dw_1.Object.nr_sequencial					[ll_row]
			is_Plataforma_Ecommerce 	= dw_1.Object.id_plataforma_ecommerce	[ll_row]
			
			If dw_1.Object.id_tipo[ll_row] = 'D' And IsNull(ls_pedido_drogaexpress) Then
				If Not IsNull(ls_entregador) And Trim(ls_entregador) <> '' Then
					If Not wf_busca_dados_entregador( ls_entregador ) Then Return -1
					id_presenca = '4'				
				End If
			End If
			If ( is_plataforma_ecommerce = '3' Or is_plataforma_ecommerce = '5' Or is_plataforma_ecommerce = '6' ) Then //3 iFood - 5 Consulta rem$$HEX1$$e900$$ENDHEX$$dio - 6 Rappi
				id_presenca = '4'
				id_intermediador_nfce = '1'
				If is_plataforma_ecommerce = '3' Then	
					ls_ident_intermediador_envio = ls_ident_intermediador_ifood
				End If
				If is_plataforma_ecommerce = '5' Then	
					ls_ident_intermediador_envio = ls_ident_intermediador_cr
				End If				
				If is_plataforma_ecommerce = '6' Then	
					ls_ident_intermediador_envio = ls_ident_intermediador_Rappi
				End If				
				
				nr_cnpj_transp		= dw_1.Object.nr_cgc				[ll_row]
				de_nome_transp 	= dw_1.Object.nm_fantasia			[ll_row]
				de_end_transp 		= dw_1.Object.de_endereco_cv	[ll_row]
				
				If is_plataforma_ecommerce = '6' Then
					de_cidade_transp 	= dw_1.Object.de_cidade_transp	[ll_row]
					cd_uf_transp 			= dw_1.Object.cd_uf_transp	[ll_row]
				Else
					de_cidade_transp 	= gvo_parametro.nm_cidade_filial
					cd_uf_transp 		= gvo_parametro.ivs_uf_filial
				End If
				
				If IsNull(ls_cpf_cgc) Or Trim(ls_cpf_cgc) = '' Then
					ls_cpf_cgc = dw_1.Object.nr_cpf_cheque[ll_row]
				End If				
				
			ElseIf is_plataforma_ecommerce = '2' Then
				 If dw_1.Object.nm_transportadora[ll_row] = 'MOTOBOY' Then
					If Not IsNull(ls_entregador) And Trim(ls_entregador) <> '' Then	
						If Not wf_busca_dados_entregador( ls_entregador ) Then Return -1
						id_presenca = '4'
						If IsNull(ls_cpf_cgc) Or Trim(ls_cpf_cgc) = '' Then
							ls_cpf_cgc = dw_1.Object.nr_cpf_cheque[ll_row]
						End If
					End If
				 End If
			End If			
			
			w_Janela_Aguarde.Wf_Mensagem("ENVIANDO NFC - " + String(ll_nota))			
			
			If Not wf_carrega_formas_pgto(gvo_parametro.cd_filial, ll_nota, ls_especie, ls_serie, dw_1.Object.cd_forma_pagamento[ll_row], dw_1.Object.vl_total_nf[ll_row], dw_1.Object.id_tipo_venda[ll_row], dw_1.Object.vl_pago_avista[ll_row]) Then
				Return -1
			End If
			
			ls_cpf_cgc = dw_1.Object.nr_cpf_cgc[ll_row]
			
			//Se tem cpf no campo da nf_venda, foi informado que o cliente queria participar de programa do governo no momento da venda.
			If Not IsNull(ls_cpf_cgc) And Trim(ls_cpf_cgc) > '' Then
				lb_programa_governo = True
			Else
				lb_programa_governo = False		
			End If
			
			//Se tem cliente cadastrado na nota, busca os dados.
			If Not IsNull(dw_1.Object.cd_cliente[ll_row]) And Trim(dw_1.Object.cd_cliente[ll_row]) > '' Then
				lvo_Cliente.of_Localiza_Cliente(dw_1.Object.cd_cliente[ll_row])						
				If lvo_Cliente.Localizado Then
					If lb_programa_governo Then
						If Trim(ls_cpf_cgc) = lvo_cliente.nr_cpf_cgc Then
							lb_mesmo_cpf = True
							ls_cpf_cgc       = lvo_cliente.nr_cpf_cgc														
						Else
							lb_mesmo_cpf = False	
						End If
					End If
					cd_cliente 				 = lvo_cliente.cd_cliente
					nm_cliente 				 = lvo_cliente.nm_cliente
					is_endereco_cliente   = lvo_cliente.de_endereco
					is_bairro_cliente     = lvo_cliente.de_bairro
					is_uf_cliente	       = lvo_cliente.cd_unidade_federacao
					is_cidade_cliente     = lvo_cliente.nm_cidade
					is_cep_cliente	       	= lvo_cliente.nr_cep	
					id_tipo_cliente_clube= lvo_cliente.id_tipo_cliente
					id_cliente_pf_pj		 = lvo_cliente.id_fisica_juridica
					cd_cidade_ibge		 = lvo_cliente.cd_cidade_ibge
					de_email				 = lvo_cliente.de_email
					nr_endereco_cliente = lvo_cliente.nr_endereco	
					If dw_1.Object.id_tipo[ll_row] = 'D' And IsNull(ls_pedido_drogaexpress) And id_presenca = '4' Then //Busca dados da entrega venda disque-entrega
						lb_mesmo_cpf = true
						select r.nr_cep, r.de_endereco, r.de_bairro, r.nr_endereco, c.nm_cidade, c.cd_unidade_federacao, c.cd_cidade_ibge
							into :is_cep_cliente, :is_endereco_cliente, :is_bairro_cliente,
								  :nr_endereco_cliente, :is_cidade_cliente, :is_uf_cliente, :cd_cidade_ibge
						from roteiro_entrega r
							inner join cidade c
								on c.cd_cidade = r.cd_cidade
						where r.nr_sequencial_cliente_caixa = :ll_seqcaixa;
						
						If Sqlca.Sqlcode = -1 Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao verificar dados entrega Disque.",StopSign!)
							Return -1
						End If
						If IsNull(nr_endereco_cliente) Or Trim (nr_endereco_cliente) = '' Then nr_endereco_cliente = 'S/N'						
						If is_uf_cliente <> gvo_parametro.ivs_uf_filial Then
							id_presenca = '1'
						End If													
					End IF
				End If
			End If
			
			//iFood / Cons. Remedio / Rappi / Entrega por motiboy - Coloca os dados de entrega do pedido			
			If is_plataforma_ecommerce = '3' Or is_plataforma_ecommerce = '5' Or	is_plataforma_ecommerce = '6' Or &
				(is_plataforma_ecommerce = '2' And dw_1.Object.nm_transportadora[ll_row] = 'MOTOBOY' ) Then 
				nm_cliente 				= dw_1.Object.nm_cliente_entrega	[ll_row]
				is_endereco_cliente   	= dw_1.Object.de_endereco_entrega	[ll_row]
				is_bairro_cliente     	= dw_1.Object.de_bairro_entrega		[ll_row]
				is_uf_cliente	       		= dw_1.Object.cd_uf_entrega			[ll_row]
				is_cidade_cliente     	= dw_1.Object.nm_cidade_entrega	[ll_row]
				is_cep_cliente	       	= dw_1.Object.nr_cep_entrega			[ll_row]
				nr_endereco_cliente 	= dw_1.Object.nr_endereco_entrega	[ll_row]				
				cd_cidade_ibge		 	= gvo_parametro.cd_cidade_ibge
				lb_mesmo_cpf	 		= True					
			End If
			
			If pdv.of_inicializa_cupom(ls_cpf_cgc) Then
				ldt_data_emi = gf_getserverdate()
				If Not pdv.of_cabecalho_nfce(String(ll_nota), dw_1.Object.id_tipo_venda[ll_row], 'VENDA MERC.ADQ.REC.TERC', dw_1.Object.dh_emissao[ll_row], "4", "9", "1", "1", id_presenca, id_intermediador_nfce,&
												 	  nr_cpf_transp,nr_cnpj_transp,de_nome_transp,de_end_transp,de_cidade_transp,cd_uf_transp) Then
					Return -1
				End If
				
				If Not pdv.of_emitente_nfce() Then
					Return -1
				End If
								
				If Not pdv.of_destinatario_nfce(ls_cpf_cgc,cd_cliente,nm_cliente,is_endereco_cliente, nr_endereco_cliente, &
														is_bairro_cliente, cd_cidade_ibge, is_cidade_cliente, is_uf_cliente, &
														de_email, lb_programa_governo, lb_mesmo_cpf) Then	
					Return -1
				End If	
				
				//Tratamento de total da venda a 0,01
				ldc_vl_desconto_gratis = dw_1.Object.vl_desconto_nf[ll_row]
				If dw_1.Object.vl_total_nf[ll_row] <= ldc_vl_desconto_gratis Then
					ldc_vl_desconto_gratis = 000.00
				End If	
				
				If Not wf_processa_itens(gvo_parametro.cd_filial, ll_nota, ls_especie, ls_serie, dw_1.Object.pc_desconto[ll_row], dw_1.Object.vl_desconto_nf[ll_row]) Then
					Return -1
				End If
				
				ls_inf_adicional = 'CAIXA: ' + dw_1.Object.cd_caixa[ll_row] + ' CONTROLE: ' + String(dw_1.Object.nr_controle_caixa[ll_row]) + ' Operador: ' + dw_1.Object.nr_matric_operador[ll_row] + ' Vendedor: ' + dw_1.Object.nr_matricula_vendedor[ll_row]
				
				If gvo_parametro.ivs_uf_filial = 'SC' And not IsNull(dw_1.Object.nr_pedido_drogaexpress[ll_row]) and dw_1.Object.cd_forma_pagamento[ll_row] = 'CV' Then
					ls_inf_fisco = dw_1.Object.de_dados_adicionais[ll_row]
				End If
				
				If Not PDV.of_totais_nfce(vl_total_base_icms, vl_total_icms, dw_1.Object.vl_bc_icms_st[ll_row], dw_1.Object.vl_icms_st[ll_row], dw_1.Object.vl_total_nf_bruto[ll_row], 0, 0,  & 
												 vl_total_desconto_itens_nfce, 0, 0, vl_total_PIS, vl_total_COFINS, 0, dw_1.Object.vl_total_nf[ll_row], &
												 vl_total_imposto, '9', cd_tipo_pagamento, vl_tipo_pagamento, 0.00, &
												 Ref nr_chave_nfce,'',de_dados_tef, id_envia_responsavel, VL_Total_ICMS_Desonerado, &
												 ls_inf_adicional, ls_inf_fisco, dw_1.Object.nr_cgc[ll_row], ls_ident_intermediador_envio)  Then
					Return -1
				End If				
				
				If Not PDV.of_assina_valida_nfce() Then
					Return -1
				End If			
			
				pdv.of_fecha_cupom(ls_nulo, false,ls_nulo,'', 'C', de_email, Ref nr_chave_nfce, Ref cd_status_nfce,&
							 Ref de_motivo_nfce, Ref de_dir_xml_nfce, Ref dt_data_recebimento_nfce,&
							 Ref cd_protocolo_nfce, Ref id_retorno_nfce, 0, 0, 'N')		
				
				If id_retorno_nfce = -1 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Problemas de comunica$$HEX2$$e700e300$$ENDHEX$$o com o SEFAZ, tente novamente mais tarde.", Exclamation!)
					Return -1
				End If
				
				//Retornou que a nota j$$HEX1$$e100$$ENDHEX$$ existe no SEFAZ, ent$$HEX1$$e300$$ENDHEX$$o apenas vai atualizar os dados de envio.
				If id_retorno_nfce = -3 Then
					String ls_chaveRec
					Long ll_Pos
					//RS
					If PosA(de_motivo_nfce,'chNFe:',1) > 0 Then
						ll_Pos = PosA(de_motivo_nfce,'chNFe:',1)
						ls_ChaveRec = MidA(de_motivo_nfce, ll_Pos + 6, 44)
						If IsNumber(ls_ChaveRec) Then nr_chave_nova = ls_ChaveRec
					//PR
					ElseIf PosA(de_motivo_nfce,'[',1) > 0 Then
						ll_Pos = PosA(de_motivo_nfce,'[',1)
						ls_ChaveRec = MidA(de_motivo_nfce, ll_Pos + 1, 44)
						If IsNumber(ls_ChaveRec) Then nr_chave_nova = ls_ChaveRec
					End If
					//Se a chave capturada acima n$$HEX1$$e300$$ENDHEX$$o for nula ela deve ser armazenada, pois na duplica$$HEX2$$e700e300$$ENDHEX$$o de nota h$$HEX1$$e100$$ENDHEX$$ o retorno da chave correta
					If Not IsNull(nr_chave_nova)and(LenA(nr_chave_nova)=44) Then nr_chave_nfce = nr_chave_nova
						
					If PDV.of_consulta_nfce(nr_chave_nfce, Ref cd_protocolo_nfce, Ref cd_status_nfce, &
													Ref de_motivo_nfce, Ref dt_data_recebimento_nfce, Ref ls_chaveRec) Then
						If LenA(ls_chaveRec)=44 Then nr_chave_nfce = ls_chaveRec
					End If
				End If		
				
				If id_retorno_nfce = 1 Or id_retorno_nfce = -3 Then				
					String ls_situacao
					long ll_nfe
					ls_situacao = 'A'
					
					Select nr_nf Into :ll_nfe
					From nf_venda_nfe
					where cd_filial = :gvo_parametro.cd_filial
						and nr_nf = :ll_nota
						and de_especie = :ls_especie
						and de_serie = :ls_serie
					Using SqlCa;
				
					Choose Case SqlCa.SqlCode
						Case 0							
							Update nf_venda_nfe  
							Set de_chave_acesso		= :nr_chave_nfce,
								 nr_protocolo_envio	= :cd_protocolo_nfce,   
								 dh_envio			   	= :dt_data_recebimento_nfce,   
								 id_situacao			 	= :ls_situacao
							where cd_filial = :gvo_parametro.cd_filial
								and nr_nf = :ll_nota
								and de_especie = :ls_especie
								and de_serie = :ls_serie
							Using SqlCa;
										
							If SqlCa.SqlCode = -1 Then
								SqlCa.of_MsgDBError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da NFCE na NF_VENDA_NFE")
								Return -1
							Else
								Sqlca.of_Commit()								
							End If				
							
						Case 100		
							Insert Into nf_venda_nfe(cd_filial, nr_nf, de_especie, de_serie, de_chave_acesso, nr_protocolo_envio, dh_envio, id_situacao)  
							Values (:gvo_parametro.cd_filial, ll_nota, ls_especie, ls_serie, &
										:nr_chave_nfce, :cd_protocolo_nfce, :dt_data_recebimento_nfce, :ls_situacao)
							Using SqlCa;
							
							If SqlCa.SqlCode = -1 Then
								SqlCa.of_MsgDBError("Inclus$$HEX1$$e300$$ENDHEX$$o da NFCE na NF_VENDA_NFE")
								Return -1
							Else
								Sqlca.of_Commit()
							End If						
							
					End Choose
				Else
					Return -1
				End If
				//Return True		
		
			End If			
		End If		
	Next
	
	If IsValid(w_Janela_Aguarde) Then Close(w_Janela_Aguarde)			

Finally
	wf_inicia_variaveis()
	If IsValid(w_Janela_Aguarde) Then Close(w_Janela_Aguarde)
	Destroy(lvo_cliente)
	
	If gvo_aplicacao.ivo_seguranca.cd_sistema = 'CL' Then
		dw_1.of_AppendWhere("n.cd_caixa = '" + PDV.cd_caixa + "'")
	End If
	
	dw_1.Event ue_Retrieve()
	
	If dw_1.RowCount() = 0 Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma NFC-e pendente de envio!")
		cb_selecao.enabled = False
		cb_OK.enabled		  = False		
	End If	
End Try

end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge039_envio_nfce
integer x = 1623
end type

type cb_selecao from commandbutton within w_ge039_envio_nfce
integer x = 635
integer y = 1168
integer width = 530
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Marcar &Todos"
end type

event clicked;String ls_Marcacao
String ls_Possui_Rejeicao
Long ll_Row

Try
	If cb_selecao.Text = 'Marcar &Todos' Then
		ls_Marcacao = 'S'
		cb_selecao.Text = 'Desmarcar &Todos'
	Else
		ls_Marcacao = 'N'
		cb_selecao.Text = 'Marcar &Todos'	
	End If
	
	//Desabilita controles visuais da DW para acelerar a marca$$HEX2$$e700e300$$ENDHEX$$o das notas
	dw_1.SetRedraw(False)
	For ll_Row = 1 To dw_1.RowCount()
		//Pega valor se possui rejei$$HEX2$$e700e300$$ENDHEX$$o
		ls_Possui_Rejeicao = dw_1.Object.id_possui_rejeicao [ ll_Row ]
		//Se houver uma rejei$$HEX2$$e700e300$$ENDHEX$$o ativa para a nota n$$HEX1$$e300$$ENDHEX$$o marca a nota automaticamente
		If ls_Possui_Rejeicao = "S" and ls_Marcacao = "S" Then Continue
		
		//Marca/desmarca registro
		dw_1.Object.id_selecao[ ll_Row ] = ls_Marcacao
	Next
	
Catch (RuntimeError lvo_Erro)
	MessageBox("ERRO", lvo_Erro.GetMessage(), StopSign!)
	Return -1
	
Finally
	//Habilita controles visuais da DW
	dw_1.SetRedraw(True)
End Try
end event

