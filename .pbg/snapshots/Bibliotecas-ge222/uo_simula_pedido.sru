HA$PBExportHeader$uo_simula_pedido.sru
forward
global type uo_simula_pedido from nonvisualobject
end type
end forward

global type uo_simula_pedido from nonvisualobject
end type
global uo_simula_pedido uo_simula_pedido

type variables
long 	cd_produto,&
		nr_dias_pgto_dist,&
		cd_condicao_pagamento,&
		cd_tributacao_produto,&
		nr_classificacao_fiscal
Long qt_embalagem_padrao_distrib		

string de_produto,&
		cd_grupo,&
		id_icms_normal,&
		cd_distribuidora,&
		cd_uf_fornecedor,&
		cd_uf_filial,&
		nm_razao_distribuidora,&
		id_alteracao_pedido,&
		cd_tributacao_icms,&
		id_caderno_abcfarma,&
		id_lei_generico,&
		id_situacao_pis_cofins,&
		cd_fornecedor,&
		id_considera_repasse
		

decimal 	vl_preco_unitario,&
			pc_desconto,&
			pc_desconto_pedido,&
			pc_repasse,&
			vl_repasse,&
			vl_bc_icms_st,&
			vl_icms_st,&
			pc_tx_adm_logistica,&
			pc_juros_diario_pedido_eletronico,&
			pc_icms,&
			vl_preco_final_fab,&
			vl_preco_dist,&
			pc_repasse_dist,&
			pc_desc_dist,&
			vl_repasse_dist,&
			vl_icms_st_dist,&
			vl_preco_compra_dist,&
			pc_ipi,&
			vl_ipi,&
			vl_juros_decrescimo,&
			vl_juros_decrescimo_dist,&
			vl_acrescimo_logistica,&
			vl_preco_venda_maximo,&
			vl_mva,&
			vl_bc_ipi,&
			pc_icms_venda,&
			pc_icms_compra,&
			pc_reducao_base_icms,&
			vl_bc_icms,&
			vl_icms,&
			pc_Reducao_Base_ST,&
			vl_pmc, &
			pc_reducao_icms_dist, &
			pc_icms_dist, &
			pc_desc_finan_dist, &
			pc_promocao_desconto_finan,&
			pc_pis,&
			pc_cofins,&
			vl_pis_pedido,&
			vl_cofins_pedido,&
			vl_pis_distribuidora,&
			vl_cofins_distribuidora,&
			pc_midia_calculada,&
			pc_juros,&
			vl_preco_compra_calculado,&
			vl_juros,&
			pc_repasse_icms_dist

Boolean ib_Parametro_Pis_Cofins = False

private:
uo_tratamento_fiscal 			ivo_tratamento_fiscal
uo_atributo_fiscal_item_nf 	ivo_atributo
end variables

forward prototypes
public subroutine of_inicializa ()
public function decimal of_valor_compra_nova (decimal adc_preco, decimal adc_desconto, decimal adc_desconto_pedido, string as_uf_filial, string as_uf_fornecedor, uo_produto ao_produto, decimal adc_pc_ipi, string as_fornecedor, decimal adc_perc_icms)
public function string of_considera_ipi (string as_fornecedor)
public function boolean of_calcula_juros_diario (long al_condicao, decimal adc_valor, ref decimal adc_valor_juros)
public function boolean of_inicio_operacao_pis_cofins (long al_produto)
public function boolean of_calculo_melhor_compra ()
end prototypes

public subroutine of_inicializa ();
end subroutine

public function decimal of_valor_compra_nova (decimal adc_preco, decimal adc_desconto, decimal adc_desconto_pedido, string as_uf_filial, string as_uf_fornecedor, uo_produto ao_produto, decimal adc_pc_ipi, string as_fornecedor, decimal adc_perc_icms);Boolean lb_Repasse_ICMS

Decimal ldc_Desconto_NF, lvdc_Preco_Liquido, lvdc_Valor_IPI, lvdc_Retorno

String ls_Situacao_Tributaria, ls_Pis_Cofins, ls_Fornecedor, ls_ICMS_Normal 

SetNull(ls_Pis_Cofins)
SetNull(ls_Fornecedor)
ldc_Desconto_NF = 0.00

ib_Parametro_Pis_Cofins = This.of_inicio_operacao_pis_cofins(ao_produto.cd_produto)

//Origem -> Fornecedor              Destino -> Filial
ivo_Tratamento_Fiscal.Of_Grava_Uf_Origem_Destino(as_uf_fornecedor,as_uf_filial)

ivo_tratamento_fiscal.Of_Inicializa()

// Par$$HEX1$$e200$$ENDHEX$$metro para s$$HEX1$$f300$$ENDHEX$$ considerar a redu$$HEX2$$e700e300$$ENDHEX$$o caso haja redu$$HEX2$$e700e300$$ENDHEX$$o na ultima compra do produto do fornecedor
ivo_tratamento_fiscal.is_calculo_venda_simulacao_compra = 'S'

ivo_tratamento_fiscal.ivs_filial_farmacia_popular = 'S'

//Carrega os atributos fiscais
ivo_atributo = ivo_tratamento_fiscal.of_atributo_fiscal_produto(ao_produto)

If Not ivo_atributo.Localizado Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Atributos fiscais do produto " + String(ao_produto.cd_produto) + " n$$HEX1$$e300$$ENDHEX$$o foram localizados.",StopSign!)
	//lvb_Erro = True
	//Exit
	Return -1
End If	

lvdc_Preco_Liquido = (round(round(adc_Preco * (100 - adc_Desconto) / 100, 2) * ((100 - adc_Desconto_Pedido) / 100), 2))

// Inicializa vari$$HEX1$$e100$$ENDHEX$$veis
This.vl_bc_ipi						= 0.00 
This.vl_ipi 						= 0.00 
This.pc_repasse 					= 0.00
This.vl_repasse 					= 0.00
This.vl_bc_icms_st				= 0.00
This.vl_icms_st 					= 0.00
This.vl_mva							= 0.00
This.pc_icms_venda				= 0.00
This.pc_icms_compra				= 0.00
This.pc_reducao_base_icms		= 0.00
This.vl_bc_icms					= 0.00
This.vl_icms						= 0.00
This.pc_Reducao_Base_ST			= 0.00
This.vl_pmc							= 0.00
This.vl_pis_pedido				= 0.00
This.vl_cofins_pedido			= 0.00
This.pc_midia_calculada			= 0.00 

ls_Situacao_Tributaria 	= '0' + Mid(ivo_atributo.cd_situacao_tributaria, 2,1)
ls_ICMS_Normal 			= ivo_Tratamento_Fiscal.ivs_ICMS_Normal

This.cd_tributacao_icms = ls_Situacao_Tributaria

If IsNull(ls_ICMS_Normal) or  ls_ICMS_Normal = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro que indica que o produto possui ICMS normal $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido.")
	Return -1
End If

//If ao_produto.cd_tributacao_produto = 0 and as_uf_filial <> as_uf_fornecedor and ls_ICMS_Normal = 'S' and id_considera_repasse = 'S' Then
//	lb_Repasse_ICMS = True
//Else
//	lb_Repasse_ICMS = False
//End If

If id_considera_repasse = 'S' Then
	lb_Repasse_ICMS = ivo_Tratamento_Fiscal.of_verifica_repasse_icms(ao_produto.nr_classificacao_fiscal)
End If

If Not IsNull(adc_perc_icms) and adc_perc_icms > 0 Then
	ivo_atributo.pc_icms = adc_perc_icms
End If

ivo_Tratamento_Fiscal.of_Grava_ICMS_Produto(	ao_produto, &
														  		1, &
														  		lvdc_Preco_Liquido, &
														  		0, &
														  		ls_Situacao_Tributaria, &
														  		ivo_atributo.pc_icms, &
																adc_pc_ipi, &
																lb_Repasse_ICMS, &
																ls_Pis_Cofins, & 
																as_fornecedor, &
																ldc_Desconto_NF)
														  
If ivo_Tratamento_Fiscal.ivb_erro Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na apura$$HEX2$$e700e300$$ENDHEX$$o dos impostos do produto " + String(ao_produto.cd_produto) + ".",StopSign!)			
	//lvb_Erro = True
	//Exit
	Return -1
End If

This.vl_bc_icms_st				= ivo_tratamento_fiscal.ivo_atributo_nf.Vl_BC_ICMS_ST
This.vl_icms_st 	 			= ivo_tratamento_fiscal.ivo_atributo_nf.Vl_ICMS_ST

// n$$HEX1$$e300$$ENDHEX$$o-medicamento ESTADUAL n$$HEX1$$e300$$ENDHEX$$o possui ST
If ao_produto.cd_tributacao_produto <> 0 and as_uf_filial = as_uf_fornecedor Then
	This.vl_bc_icms_st		= 0.00
	This.vl_icms_st 		= 0.00
End If

This.pc_icms_venda			= ivo_tratamento_fiscal.ivo_atributo_nf.PC_ICMS_ST

///Chamado: 934960 - In$$HEX1$$ed00$$ENDHEX$$cio
//This.pc_icms_compra			= ivo_atributo.pc_icms   /// ANTES
This.pc_icms_compra				= ivo_tratamento_fiscal.ivo_atributo_nf.pc_icms
///Chamado: 934960 - Termino

This.vl_bc_icms				= round(ivo_tratamento_fiscal.ivo_atributo_nf.vl_bc_icms_prd, 2)
This.vl_icms						= round(ivo_tratamento_fiscal.ivo_atributo_nf.vl_icms_prd, 2)
This.vl_bc_ipi					= ivo_tratamento_fiscal.ivo_atributo_nf.vl_bc_ipi
This.vl_ipi						= ivo_tratamento_fiscal.ivo_atributo_nf.vl_ipi
This.pc_Reducao_Base_ST 	= ivo_tratamento_fiscal.ivo_atributo_nf.pc_Reducao_Base_ST

This.pc_repasse				= ivo_tratamento_fiscal.ivo_atributo_nf.pc_repasse_icms
This.vl_repasse					= ivo_tratamento_fiscal.ivo_atributo_nf.vl_repasse_icms

If Not IsNull(ivo_tratamento_fiscal.ivdc_preco_venda_maximo) and ivo_tratamento_fiscal.ivdc_preco_venda_maximo > 0 Then
	This.vl_pmc		= ivo_tratamento_fiscal.ivdc_preco_venda_maximo
End If

If ivo_tratamento_fiscal.ivo_atributo_nf.pc_Reducao_Base_ST > 0 Then
	This.pc_Reducao_Base_ST	= (1 - ivo_tratamento_fiscal.ivo_atributo_nf.pc_Reducao_Base_ST) * 100
End If

If ib_Parametro_Pis_Cofins Then
	This.vl_pis_pedido			= Round(lvdc_Preco_Liquido * (pc_pis / 100), 2) 
	This.vl_cofins_pedido		= Round(lvdc_Preco_Liquido * (pc_cofins / 100), 2)
	
	lvdc_Retorno = lvdc_Retorno - (This.vl_pis_pedido + This.vl_cofins_pedido)
	
End If

// *** Valor final de compra
lvdc_Preco_Liquido = lvdc_Preco_Liquido - This.vl_repasse
lvdc_Retorno = lvdc_Preco_Liquido + This.vl_icms_st + ivo_tratamento_fiscal.ivo_atributo_nf.vl_ipi 

// ICMS normal ou ICMS normal com redu$$HEX2$$e700e300$$ENDHEX$$o
If This.cd_tributacao_icms = '00' or  This.cd_tributacao_icms = '02' Then
	// Tira o IPI
	lvdc_Retorno = lvdc_Retorno - This.vl_ipi
	// Retira o ICMS
	//lvdc_Retorno = round(lvdc_Retorno * ((100 - This.pc_icms_compra) / 100), 2)
	lvdc_Retorno = lvdc_Retorno - This.vl_icms
	// Acrescenta o IPI
	lvdc_Retorno = lvdc_Retorno + This.vl_ipi
End If

// 1,9947		=>	99,47 %
If ivo_tratamento_fiscal.ivo_atributo_nf.vl_mva > 0 Then
	This.vl_mva = (ivo_tratamento_fiscal.ivo_atributo_nf.vl_mva - 1) * 100
End If

// 0.8951		=>	10,49 %
If ivo_tratamento_fiscal.ivo_atributo_nf.pc_reducao_base_icms < 1 And ivo_tratamento_fiscal.ivo_atributo_nf.pc_reducao_base_icms <> 0 Then
	This.pc_reducao_base_icms	= (1 - ivo_tratamento_fiscal.ivo_atributo_nf.pc_reducao_base_icms) * 100
Else
	This.pc_reducao_base_icms	 = ivo_tratamento_fiscal.ivo_atributo_nf.pc_reducao_base_icms
End If

//This.of_calculo_melhor_compra()

Return lvdc_Retorno
end function

public function string of_considera_ipi (string as_fornecedor);String lvs_Retorno

Select id_considera_ipi_pedido
Into :lvs_Retorno
From fornecedor
Where cd_fornecedor = :as_Fornecedor
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Isnull(lvs_Retorno) Then lvs_Retorno = "N"
	Case 100
	Case -1
		SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o de considera$$HEX2$$e700e300$$ENDHEX$$o do IPI na simula$$HEX2$$e700e300$$ENDHEX$$o.")
		lvs_Retorno = 'N'
End Choose

Return lvs_Retorno
end function

public function boolean of_calcula_juros_diario (long al_condicao, decimal adc_valor, ref decimal adc_valor_juros);Decimal lvdc_PC_Total_Parcela, lvdc_PC_Juros_Total_Dias, lvdc_Valor_Juros

Long lvl_Linhas, lvl_Linha

dc_uo_ds_base lvds

lvds = Create dc_uo_ds_base

If Not lvds.of_ChangeDataObject("dw_ge222_parcela_pagto") Then
	Destroy(lvds)
	Return False	
End If

lvds.Retrieve(al_Condicao)

lvl_Linhas = lvds.RowCount()

If lvl_Linhas > 0 Then	
	
	For lvl_Linha = 1 To lvl_Linhas
		//lvl_Dias 							= lvds.Object.qt_dias_vencimento	[lvl_Linha]
		lvdc_PC_Total_Parcela		= lvds.Object.pc_valor_total			[lvl_Linha]
		lvdc_PC_Juros_Total_Dias	= lvds.Object.pc_juro_total_dias	[lvl_Linha] // 30 * 0,035 => 1,05 / 100 => 0,0105
		
		lvdc_Valor_Juros = round((adc_valor * (lvdc_PC_Total_Parcela / 100))  * lvdc_PC_Juros_Total_Dias, 2)
		
		adc_valor_juros = adc_valor_juros + lvdc_Valor_Juros
		
	Next
	
	If IsNull(adc_Valor_Juros) or adc_Valor_Juros <= 0.00 Then
		adc_Valor_Juros = 0.00
		//Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao calcular o juros ao contr$$HEX1$$e100$$ENDHEX$$rio.", StopSign!)
		//Destroy(lvds)
		//Return False
	End If
	
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao calcular o juros ao contr$$HEX1$$e100$$ENDHEX$$rio.", StopSign!)
	Destroy(lvds)
	Return False
End If

Destroy(lvds)

end function

public function boolean of_inicio_operacao_pis_cofins (long al_produto);Datetime ldh_Parametro
Long ll_Achou

Select vl_parametro
Into :ldh_Parametro
From parametro_geral
Where cd_parametro = 'DH_INICIO_OPERACAO_PIS_COFINS'
Using SqlCA;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar parametro geral DH_INICIO_OPERACAO_PIS_COFINS" + SqlCa.SQLErrText, StopSign!)
	Return False
End If 

If ldh_Parametro <= gf_getserverdate() Then
	SELECT 
		 (SELECT vl_parametro 
		  FROM parametro_geral 
		  WHERE cd_parametro = 'PC_PIS'),
		 (SELECT vl_parametro 
		  FROM parametro_geral 
		  WHERE cd_parametro = 'PC_COFINS')
	INTO :pc_pis, :pc_cofins
	FROM dummy
	Using SqlCA;
	
	If SqlCa.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar parametro PC_PIS e PC_COFINS. Produto: " + String(al_produto) + '. ' + SqlCa.SQLErrText, StopSign!)
		Return False
	End If 
	
	Select count(*)
	Into :ll_Achou
	From produto_geral
	Where id_situacao_pis_cofins = 'T'
			And cd_produto = :al_produto
	Using Sqlca;
	
	If SqlCa.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar id_situacao_pis_cofins da tabela produto_geral. Produto: " + String(al_produto) + '. ' + SqlCa.SQLErrText, StopSign!)
		Return False
	End If 
	
	If ll_Achou > 0 Then
		Return True
	Else 
		Return False
	End If
	
Else
	Return False
End If


end function

public function boolean of_calculo_melhor_compra ();Decimal pc_desconto_acordo_sellin
Decimal pc_repasse_icms
Decimal ldc_Vl_liquido
Decimal ldc_Vl_Repasse_icms 
Decimal ldc_Total_Impostos
Decimal ldc_Vl_Promo_finan
Decimal ldc_Vl_midia
Decimal ldc_Vl_Acordo_sellin
Decimal ldc_Vl_Total_descontos
Decimal ldc_Vl_Icms_compra
Decimal ldc_Vl_Compra
Decimal ldc_Base_Icms_Reduzida

// Passo 1: Calcula Liquido (Pre$$HEX1$$e700$$ENDHEX$$o Bruto - Desconto Base)
ldc_Vl_Total_descontos	= Round(vl_preco_dist * (pc_desc_dist / 100), 2)
ldc_Vl_liquido				= vl_preco_dist - ldc_Vl_Total_descontos

// Passo 2: Calcula Pre$$HEX1$$e700$$ENDHEX$$o de Compra 1 (Liquido - Repasse ICMS)
ldc_Vl_Repasse_icms				= Round(ldc_Vl_liquido * (pc_repasse_icms_dist / 100), 2)
ldc_Vl_Compra						= ldc_Vl_liquido - ldc_Vl_Repasse_icms

// Passo 3: Calcula Pre$$HEX1$$e700$$ENDHEX$$o de Compra 2 (Dedu$$HEX2$$e700e300$$ENDHEX$$o de PIS, COFINS e ICMS)
If ib_Parametro_Pis_Cofins Then // verificar a situa$$HEX2$$e700e300$$ENDHEX$$o do produto tamb$$HEX1$$e900$$ENDHEX$$m
	vl_pis_distribuidora		= Round(ldc_Vl_Compra * (pc_pis / 100), 2)
	vl_cofins_distribuidora	= Round(ldc_Vl_Compra * (pc_cofins / 100), 2)
Else
	vl_pis_distribuidora = 0
	vl_cofins_distribuidora = 0
End if

ldc_Base_Icms_Reduzida	= Round(ldc_Vl_Compra * ((100 - pc_reducao_icms_dist) / 100), 2)
ldc_Vl_Icms_compra		= Round(ldc_Base_Icms_Reduzida * (pc_icms_dist / 100), 2)

//ldc_Vl_Icms_compra 		= Round(ldc_Vl_Compra * (pc_icms_dist / 100), 2)
ldc_Total_Impostos 		= vl_pis_distribuidora + vl_cofins_distribuidora + ldc_Vl_Icms_compra
ldc_Vl_Compra 				= ldc_Vl_Compra - ldc_Total_Impostos

// Passo 4: Desconto Promocional/Financeiro
ldc_Vl_Promo_finan 		= Round(ldc_Vl_Compra * (pc_promocao_desconto_finan / 100), 2)
ldc_Vl_Compra 				= ldc_Vl_Compra - ldc_Vl_Promo_finan

// Passo 5: Calcula Pre$$HEX1$$e700$$ENDHEX$$o de Compra 3 (Dedu$$HEX2$$e700e300$$ENDHEX$$o de Midia)
ldc_Vl_midia 				= Round(ldc_Vl_Compra * (pc_midia_calculada / 100), 2)
ldc_Vl_Compra				= ldc_Vl_Compra - ldc_Vl_midia

// Passo 6: Calcula Pre$$HEX1$$e700$$ENDHEX$$o de Compra 4 (Descontos Sellin)
ldc_Vl_Acordo_sellin		= Round(ldc_Vl_Compra * (pc_desconto_acordo_sellin / 100), 2)
ldc_Vl_Compra				= ldc_Vl_Compra - ldc_Vl_Acordo_sellin

// C$$HEX1$$e100$$ENDHEX$$lculo do Juros (Etapa Adicional)
vl_juros						= Round(ldc_Vl_Compra * (pc_juros / 100), 2)

// Passo 7: Resultado Final
vl_preco_compra_calculado = Round((ldc_Vl_Compra / qt_embalagem_padrao_distrib), 2)
Return True
end function

on uo_simula_pedido.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_simula_pedido.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivo_tratamento_fiscal = Create uo_tratamento_fiscal
ivo_atributo 			 	= Create uo_Atributo_Fiscal_Item_Nf


// Utiliza as mesmas configura$$HEX2$$e700f500$$ENDHEX$$es de transfer$$HEX1$$ea00$$ENDHEX$$ncias.
ivo_tratamento_fiscal.Of_Grava_Contribuinte(True)
ivo_tratamento_fiscal.Of_Grava_Operacao(ivo_tratamento_fiscal.COMPRA)

id_considera_repasse = 'S'
end event

event destructor;Destroy(ivo_Atributo)
Destroy(ivo_Tratamento_Fiscal)
end event

