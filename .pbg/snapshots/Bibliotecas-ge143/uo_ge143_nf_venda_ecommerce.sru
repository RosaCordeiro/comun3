HA$PBExportHeader$uo_ge143_nf_venda_ecommerce.sru
forward
global type uo_ge143_nf_venda_ecommerce from nonvisualobject
end type
end forward

global type uo_ge143_nf_venda_ecommerce from nonvisualobject
end type
global uo_ge143_nf_venda_ecommerce uo_ge143_nf_venda_ecommerce

type variables
uo_atributo_fiscal_item_nf 	ivo_atributo
uo_tratamento_fiscal			ivo_tratamento_fiscal
uo_Parametro_Geral			ivo_Parametro
uo_Filial							ivo_Filial
uo_Produto 						ivo_Produto
//UO_NOTA_FISCAL              	io_nota_fiscal //GE033

dc_uo_ds_base ids_Itens

string cd_situacao_tributaria, cd_cst_origem, cd_cst_tributacao

long cd_natureza_operacao, cd_tributacao_produto 

Long il_Nota_Fiscal

Long il_Sequencial_Item = 0

// Cabe$$HEX1$$e700$$ENDHEX$$alho da Nota
String nr_pedido_drogaexpress, cd_caixa, nr_matricula_operador, cd_cliente

// Cabe$$HEX1$$e700$$ENDHEX$$alho da Nota
Long nr_pedido_ecommerce, nr_controle_caixa, cd_filial_ecommerce

// Cabe$$HEX1$$e700$$ENDHEX$$alho da Nota
Decimal vl_frete, vl_preco_total_bruto, qt_pontos_clube_total, pc_desconto, vl_desconto
Decimal idc_Total_NF
Decimal vl_desconto_nf //tratamento produtos gratis

// Cabe$$HEX1$$e700$$ENDHEX$$alho da NF_VENDA_LOJA
//String nm_cliente_entrega, de_endereco_entrega, de_bairro_entrega, nr_telefone_entrega
//String nr_cep_entrega, nm_cidade_entrega, nr_cpf_cheque, nr_endereco_entrega, cd_uf_entrega

// Cabe$$HEX1$$e700$$ENDHEX$$alho da NF_VENDA_LOJA
String nm_cliente, de_endereco, de_bairro, nr_cep, nr_cgc_cpf
String nm_cidade, cd_uf_faturamento, nr_telefone, nr_endereco
String de_dados_adicionais
//Decimal ldc_Frete

//BENEFICIO NFE	
String cd_beneficio

// Cabe$$HEX1$$e700$$ENDHEX$$alho da NF_VENDA_LOJA
Long cd_cidade

decimal{4} vl_bc_icms_st_prd, vl_icms_st_prd, vl_preco_venda_maximo, vl_mva, pc_reducao_base_icms, vl_bc_icms, vl_icms

decimal pc_icms_st, pc_reducao_base_st, pc_icms 

Decimal idc_Vl_Maximo_Produto_Gratis

decimal 	vl_bc_icms_uf_destino,& 
    			pc_icms_uf_destino,&  
           	pc_icms_fcp_uf_destino,&
           	pc_partilha,&   
           	vl_icms_fcp_uf_destino,&
			vl_bc_icms_fcp_uf_destino,&
           	vl_icms_uf_destino,&   
           	vl_icms_uf_origem
				  
String cd_forma_pagamento
end variables

forward prototypes
public subroutine of_grava_uf_origem_destino ()
public subroutine of_grava_uf_origem_destino (string as_origem, string as_destino)
public function boolean of_verifica_situacao_tributaria ()
public function boolean of_grava_lote (long al_filial_origem, long al_nota_fiscal, string as_especie, string as_serie, long al_natoperacao, long al_produto, long al_filial, long al_pedido)
public function boolean of_grava_romaneio_faltante (long al_filial)
public function boolean of_tipo_venda (string as_tipo_venda)
public function boolean of_tributacao (uo_produto ao_produto, ref decimal adc_preco_unitario, decimal adc_perc_desconto, string as_uf_origem, string as_uf_destino, long al_quantidade)
public function boolean of_grava_venda_loja (long al_filial, long al_nota, string as_especie, string as_serie)
public function string of_retira_caracteres (string as_parametro)
public function boolean of_grava_itens_nf (long al_filial, long al_nota_fiscal, string as_especie, string as_serie, long al_produtos[])
public function boolean of_grava_nota ()
public function boolean of_proximo_nsu (ref long al_proximo)
public function boolean of_grava_nota (long al_filial, ref long al_nota, string as_especie, string as_serie, decimal adc_vl_bc_icms, decimal adc_vl_icms, decimal adc_vl_bc_icms_st, decimal adc_vl_icms_st, decimal adc_vl_total_produtos, decimal adc_vl_total_nf)
end prototypes

public subroutine of_grava_uf_origem_destino ();
end subroutine

public subroutine of_grava_uf_origem_destino (string as_origem, string as_destino);ivo_Tratamento_Fiscal.Of_Grava_Uf_Origem_Destino(as_origem, as_destino)
end subroutine

public function boolean of_verifica_situacao_tributaria ();Long ll_Row, lvl_Produto

String lvs_Situacao_Trib_Faturamento, ls_Situacao_Tributaria

Boolean lvb_Sucesso = True

Open(w_Aguarde)
w_Aguarde.uo_Progress.of_SetMax(ids_Itens.RowCount())

w_Aguarde.Title = 'Verificando a situa$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria dos produtos ...'

For ll_Row = 1 To ids_Itens.RowCount()
	
	w_Aguarde.uo_Progress.of_SetProgress(ll_Row)				
				
	lvl_Produto 			= ids_Itens.Object.Cd_Produto				[ll_Row]
	
	// Somente para faturamento dentro do estado
	If gvo_Parametro.ivs_uf_filial <> ivo_filial.cd_unidade_federacao Then
		ids_Itens.Object.cd_situacao_trib_faturamento[ll_Row] = '00'
		Continue
	End If
	
	ivo_Produto.Of_Localiza_Codigo_Interno(lvl_Produto)

	//Aborta Faturamento
	If Not ivo_Produto.Localizado Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto " + String(lvl_Produto) + " n$$HEX1$$e300$$ENDHEX$$o foi localizado.",StopSign!)
		lvb_Sucesso = False
		Exit
	End If	

	//Carrega os atributos fiscais
	ivo_atributo = ivo_tratamento_fiscal.of_atributo_fiscal_produto(ivo_produto)

	//Aborta Faturamento
	If Not ivo_atributo.Localizado Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Atributos fiscais do produto " + String(lvl_Produto) + " n$$HEX1$$e300$$ENDHEX$$o foram localizados.",StopSign!)
		lvb_Sucesso = False
		Exit
	End If	
	
	ls_Situacao_Tributaria = '0' + Mid(ivo_atributo.cd_situacao_tributaria, 2,1)
	
	//If ivo_tratamento_fiscal.ivi_tributacao_produto = 0 and ivo_atributo.cd_situacao_tributaria = '01' Then
	If ivo_tratamento_fiscal.ivi_tributacao_produto = 0 and ls_Situacao_Tributaria = '01' Then
		//ids_Itens.Object.cd_situacao_trib_faturamento[ll_Row] = ivo_atributo.cd_situacao_tributaria
		ids_Itens.Object.cd_situacao_trib_faturamento[ll_Row] = ls_Situacao_Tributaria
	Else
		ids_Itens.Object.cd_situacao_trib_faturamento[ll_Row] = '00'
	End If
	
	ids_Itens.Object.cd_tipo_icms	[ll_Row] = ivo_produto.cd_tipo_icms
Next

If ids_Itens.Sort() = -1 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao ordenar os dados da DataStore")
	lvb_Sucesso = False
End If
		
If ids_Itens.GroupCalc() = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",  "Erro ao reagrupar os dados da DataStore")
	lvb_Sucesso = False
End If

Close(w_Aguarde)

Return lvb_Sucesso
end function

public function boolean of_grava_lote (long al_filial_origem, long al_nota_fiscal, string as_especie, string as_serie, long al_natoperacao, long al_produto, long al_filial, long al_pedido);Long  		lvl_Linha,&
			lvl_Linhas,&
		  	lvl_Qtde
				  
String		lvs_Lote

Boolean     lvb_Sucesso = True

SetPointer(HourGlass!)

w_Aguarde.Title = 'Gravando lotes da nota fiscal : ' + String(al_nota_fiscal,'000000') + '/' + as_especie + '/' + as_serie

dc_uo_ds_base lds 
lds = Create dc_uo_ds_base

If Not lds.of_ChangeDataObject("ds_ge143_lote_pedido")  Then
	Destroy(lds)
	Return False
End If

lvl_Linhas = lds.Retrieve(al_Filial, al_Pedido, al_Produto)

For lvl_Linha = 1 To lvl_Linhas
	
	lvs_Lote				= Mid(Trim(lds.Object.nr_lote[lvl_Linha]), 1, 10)
	lvl_Qtde				= lds.Object.qt_lote[lvl_Linha]
	
	 INSERT INTO item_nf_transferencia_lote ( cd_filial_origem, nr_nf, de_especie,   
															de_serie,cd_natureza_operacao,   
															cd_produto, nr_lote, qt_lote )  
	 VALUES ( :al_Filial_Origem, :al_nota_fiscal, :as_especie,   
				  :as_serie, :al_natoperacao, :al_Produto,   
				  :lvs_Lote, :lvl_Qtde )
	 Using Sqlca;
		
	If Sqlca.Sqlcode = -1 Then
		Sqlca.of_MsgDbError('Erro ao gravar o lote do produto' +  String(al_nota_fiscal,'000000') + '/' + as_especie + '/' + as_serie + '/' + string(al_Produto) + '/' + lvs_Lote)
		lvb_Sucesso = False
		Exit
	End If

Next

Destroy(lds)

Return lvb_Sucesso
end function

public function boolean of_grava_romaneio_faltante (long al_filial);Long ll_Romaneio

Date ldt_Data

String ls_MSG

Select nr_romaneio
Into :ll_Romaneio
from wms_romaneio
where cd_filial = :al_Filial
  and dh_movimentacao = (select dh_movimentacao from parametro where id_parametro = '1')
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		ldt_Data = Date(gf_GetServerDate())
		
		Insert into wms_romaneio(	nr_romaneio, cd_filial, dh_movimentacao, nr_matricula_inclusao, dh_inclusao)
		select max(nr_romaneio) + 1, :al_Filial, :ldt_Data, '14330', GetDate() from wms_romaneio
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_MSG = 	"Inser$$HEX2$$e700e300$$ENDHEX$$o do romaneio da filial '" + string(al_Filial) + "', fun$$HEX2$$e700e300$$ENDHEX$$o 'wf_Grava_Romaneio_Faltante'" + SQLCA.SQLErrText
			SqlCa.of_Rollback()
			MessageBox("Erro", ls_MSG, StopSign!)
			Return False
		End If
		
	Case -1
		ls_MSG = 	"Localiza$$HEX2$$e700e300$$ENDHEX$$o do romaneio da filial '" + string(al_Filial) + "', fun$$HEX2$$e700e300$$ENDHEX$$o 'wf_Grava_Romaneio_Faltante'" + SQLCA.SQLErrText
		SqlCa.of_Rollback()
		MessageBox("Erro", ls_MSG, StopSign!)
		Return False
End Choose

Return True
end function

public function boolean of_tipo_venda (string as_tipo_venda);//Choose Case Trim(ivo_venda.id_tipo_venda)
//	Case "AV"
//		ls_tipo_venda = ivo_venda.id_tipo_venda
//		
//	Case "CV"
//		If ivo_Venda.Id_Rede = 'DC' or ivo_Venda.Id_Rede = 'MP' or ivo_Venda.Id_Rede = 'CP' Then						
//			If ivo_venda.id_cliente_caixa = 'S' Then
//				wf_selecao_cliente_ponto()
//			End If
//		End If
//		
//		If TEF.Transacao = "VIL" and TEF.status = "0" Then
//			ls_tipo_venda   = "CV"
//			//Se for Vidalink pagando com conv$$HEX1$$ea00$$ENDHEX$$nio interno, o calculo $$HEX1$$e900$$ENDHEX$$ diferente de quando $$HEX1$$e900$$ENDHEX$$ somente vidalink.
//			If ivo_venda.id_venda_pbm_convenio = "S" Then
//				If ivo_venda.pc_convenio_pago_avista <> 100 Then
//					ldc_pago_avista =  Round( ivo_venda.vl_convenio_pago_avista ,02)
//				Else
//					ls_tipo_venda = "AV"					
//				End If
//			Else
//				ldc_pago_avista =  Round( ivo_venda.vl_total_venda - ivo_venda.vl_pago_avista ,02)
//			End If
//		Else
//			If ivo_venda.pc_convenio_pago_avista <> 100 Then
//				ls_tipo_venda   = "CV"
//				ldc_pago_avista = ivo_venda.vl_convenio_pago_avista
//			Else
//				ls_tipo_venda = "AV"
//			End If
//		End If	
//		
//		//Considera venda para o clube se n$$HEX1$$e300$$ENDHEX$$o for PP
//		If ivo_venda.id_rede <> "PP" And Not IsNull(ivo_venda.cd_cliente) Then
//			ls_venda_clube = "S"
//		End If
//		
//	Case "CR"
//		ls_tipo_venda = ivo_venda.id_tipo_venda
//   			
//	Case "CC" 
//		ls_tipo_venda = ivo_venda.id_tipo_venda
//
//	Case "TR"
//		
//		If ivo_venda.vl_subsidio_pbm > 000.00 Then
//			ls_tipo_venda = "CV"
//		Else
//			ls_tipo_venda = "AV"
//			SetNull(ivo_venda.cd_convenio)
//			SetNull(ivo_venda.cd_conveniado)
//			SetNull(ivo_venda.cd_condicao_convenio)					
//		End If	
//		
//		ldc_pago_avista = Round( ivo_venda.vl_total_venda - ivo_venda.vl_subsidio_pbm , 02 )
//		
//	Case "EP"
//		
//		If ivo_venda.ib_epharma_um_centavo = True Or (ivo_Venda.vl_total_venda = ivo_Venda.vl_Pago_Avista - ivo_Venda.vl_Troco) Then
//			
//			ls_Tipo_Venda = "AV"
//			
//			SetNull(ivo_venda.cd_convenio)
//			SetNull(ivo_venda.cd_conveniado)
//			SetNull(ivo_venda.cd_condicao_convenio)
//		Else
//			
//			ivo_venda.cd_convenio			 = Sitef.ePharma.cd_Convenio
////			ivo_venda.cd_conveniado 		 = Sitef.ePharma.cd_Conveniado
//			ivo_venda.cd_conveniado 		 = Sitef.ePharma.cd_Convenio_ePharma			
//			ivo_venda.cd_condicao_convenio = Sitef.ePharma.cd_Condicao
//			ivo_venda.nm_conveniado			 = Sitef.ePharma.de_convenio
//			
//			ls_Tipo_Venda = "CV"
//			
//			ldc_pago_avista = ivo_Venda.vl_Pago_Avista - ivo_Venda.vl_Troco
//			
//		End If
//		
//	Case "PS"
//		
//		ls_tipo_venda = "AV"
//	
//		SetNull(ivo_venda.cd_convenio)
//		SetNull(ivo_venda.cd_conveniado)
//		SetNull(ivo_venda.cd_condicao_convenio)		
//				
//	Case "CLUBE"
//		
//		If ivo_venda.ib_avista Then
//			ls_tipo_venda = "AV"
//		Else
//			ls_tipo_venda = "CC"
//		End If
//		
//		ls_venda_clube = "S"
//		
//	Case "VL"
//		
//		If ivo_venda.vl_pago_avista - ivo_venda.vl_troco >= ivo_venda.vl_total_venda Then
//			
//			ls_tipo_venda = "AV"
//			
//			SetNull(ivo_venda.cd_convenio)
//			SetNull(ivo_venda.cd_conveniado)
//			SetNull(ivo_venda.cd_condicao_convenio)					
//			
//		Else 
//			
//			ls_tipo_venda = "CV"
//			
//			ldc_pago_avista = Round( ivo_venda.vl_pago_avista - ivo_venda.vl_troco , 02 )
//			
//		End If	
//		
//	Case "FC"
//		
//		If ivo_Venda.vl_total_venda = ivo_Venda.vl_Pago_Avista - ivo_Venda.vl_Troco Then
//			
//			ls_Tipo_Venda = "AV"
//			
//			SetNull(ivo_venda.cd_convenio)
//			SetNull(ivo_venda.cd_conveniado)
//			SetNull(ivo_venda.cd_condicao_convenio)
//		Else		
//			
//			ls_Tipo_Venda = "CV"
//			
//			ldc_pago_avista = ivo_Venda.vl_Pago_Avista - ivo_Venda.vl_Troco
//			
//		End If				
//		
//	Case Else	
//		
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao localizar tipo de venda " + ivo_venda.id_tipo_venda + ". Favor contactar suporte." , StopSign!)
//		Return False
//		
//End Choose

Return True
end function

public function boolean of_tributacao (uo_produto ao_produto, ref decimal adc_preco_unitario, decimal adc_perc_desconto, string as_uf_origem, string as_uf_destino, long al_quantidade);Boolean lb_Repasse_ICMS

//String ls_Situacao_Tributaria
String ls_Pis_Cofins, ls_Fornecedor

Decimal ldc_Aliquota, ldc_PC_ICMS, ldc_IPI, ldc_Desconto_NF

Decimal {4} ldc_Redutor

//Carrega os atributos fiscais
ivo_atributo = ivo_tratamento_fiscal.of_atributo_fiscal_produto(ao_produto)

//Aborta Faturamento / Aborta calculo
If Not ivo_atributo.Localizado Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Atributos fiscais do produto " + String(ao_produto.cd_produto) + " n$$HEX1$$e300$$ENDHEX$$o foram localizados.",StopSign!)
	Return False
End If	
	
//Aborta Faturamento
If IsNull(adc_preco_unitario) or adc_preco_unitario <= 0 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor unit$$HEX1$$e100$$ENDHEX$$rio do produto " + String(ao_produto.cd_produto) + " n$$HEX1$$e300$$ENDHEX$$o localizado ou inv$$HEX1$$e100$$ENDHEX$$lido.",StopSign!)
	Return False
End If	
				
ldc_PC_ICMS = ivo_atributo.pc_icms
		
// Vari$$HEX1$$e100$$ENDHEX$$veis que s$$HEX1$$e300$$ENDHEX$$o passadas para calculo da tributa$$HEX2$$e700e300$$ENDHEX$$o que n$$HEX1$$e300$$ENDHEX$$o s$$HEX1$$e300$$ENDHEX$$o utilizadas
ldc_IPI 				= 0.00
ldc_Desconto_NF 	= This.pc_desconto
lb_Repasse_ICMS = False
SetNull(ls_Pis_Cofins)
SetNull(ls_Fornecedor)

ivo_Tratamento_Fiscal.of_Grava_ICMS_Produto(	ao_produto, &
														  		al_quantidade, &
														  		adc_preco_unitario, &
														  		adc_perc_desconto, &
														  		ivo_atributo.cd_tributacao_icms, &
														  		ldc_PC_ICMS, &
																ldc_IPI, &  
																lb_Repasse_ICMS, &
																ls_Pis_Cofins, & 
																ls_Fornecedor, &
																ldc_Desconto_NF)

															  
If ivo_Tratamento_Fiscal.ivb_erro Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na apura$$HEX2$$e700e300$$ENDHEX$$o dos impostos do produto " + String(ao_produto.cd_produto) + ".",StopSign!)			
	Return False
End If

//CHamado: 536829-12	
This.cd_beneficio					= ivo_Tratamento_Fiscal.ivo_Atributo_NF.cd_beneficio
	
This.cd_situacao_tributaria		= ivo_atributo.cd_situacao_tributaria
This.cd_natureza_operacao		= ivo_atributo.cd_natureza_operacao

This.vl_bc_icms					= ivo_tratamento_fiscal.ivo_atributo_nf.vl_bc_icms_prd
This.pc_reducao_base_icms 	= ivo_tratamento_fiscal.ivo_atributo_nf.pc_reducao_base_icms
This.pc_icms						= ldc_PC_ICMS
This.vl_icms							= ivo_tratamento_fiscal.ivo_atributo_nf.vl_icms_prd_nfe 

This.vl_bc_icms_st_prd			= ivo_tratamento_fiscal.ivo_atributo_nf.vl_bc_icms_st_prd
This.pc_reducao_base_st		= ivo_tratamento_fiscal.ivo_Atributo_NF.pc_Reducao_Base_ST
This.pc_icms_st					= ivo_tratamento_fiscal.ivo_atributo_nf.PC_ICMS_ST
This.vl_icms_st_prd				= ivo_tratamento_fiscal.ivo_atributo_nf.vl_icms_st_prd

This.cd_cst_origem				= ivo_tratamento_fiscal.ivo_Atributo_NF.cd_st_origem
This.cd_cst_tributacao			= ivo_tratamento_fiscal.ivo_Atributo_NF.cd_st_tributacao

This.vl_mva							= ivo_tratamento_fiscal.ivo_Atributo_NF.vl_mva

This.cd_tributacao_produto		= ivo_tratamento_fiscal.ivi_tributacao_produto

//If ivo_tratamento_fiscal.ivi_tributacao_produto = 0 and ls_Situacao_Tributaria= '01' Then
If ivo_tratamento_fiscal.ivi_tributacao_produto = 0 and ivo_atributo.cd_cst_tributacao = '10' Then
	// PMC
	This.vl_preco_venda_maximo = ivo_tratamento_fiscal.ivdc_preco_venda_maximo
End If		

This.vl_bc_icms_uf_destino			= ivo_tratamento_fiscal.ivo_Atributo_NF.vl_bc_icms_uf_destino
This.pc_icms_uf_destino				= ivo_tratamento_fiscal.ivo_Atributo_NF.pc_icms_uf_destino 
This.pc_icms_fcp_uf_destino		= ivo_tratamento_fiscal.ivo_Atributo_NF.pc_icms_fcp_uf_destino
This.pc_partilha						= ivo_tratamento_fiscal.ivo_Atributo_NF.pc_partilha
This.vl_icms_fcp_uf_destino			= ivo_tratamento_fiscal.ivo_Atributo_NF.vl_icms_fcp_uf_destino
This.vl_bc_icms_fcp_uf_destino	= ivo_tratamento_fiscal.ivo_Atributo_NF.vl_bc_icms_fcp_uf_destino
This.vl_icms_uf_destino				= ivo_tratamento_fiscal.ivo_Atributo_NF.vl_icms_uf_destino
This.vl_icms_uf_origem				= ivo_tratamento_fiscal.ivo_Atributo_NF.vl_icms_uf_origem	

// 0.90 => 10 %
If This.pc_reducao_base_st > 0 Then
	This.pc_reducao_base_st	=	(1 - This.pc_reducao_base_st) * 100	
End If

// 1,9947		=>	99,47 %
If This.vl_mva > 0 Then
	This.vl_mva = (This.vl_mva - 1) * 100
End If

// 0.8951		=>	10,49 %
If This.pc_reducao_base_icms > 0 Then
	This.pc_reducao_base_icms 	= (1 - This.pc_reducao_base_icms) * 100
End If	
		
ivo_tratamento_fiscal.Of_Calcula_Icms(0)
		
Return True
end function

public function boolean of_grava_venda_loja (long al_filial, long al_nota, string as_especie, string as_serie);INSERT INTO nf_venda_loja  
				( cd_filial,   
				  nr_nf,   
				  de_especie,   
				  de_serie,   
				  nm_cliente,   
				  nr_cgc_cpf,   
				  nm_cidade,   
				  nm_uf,   
				  de_endereco,   
				  de_bairro,   
				  nr_cep,   
				  nr_telefone,   
				  nr_inscricao_estadual,   
				  cd_cidade,   
				  nr_endereco )  
							  
VALUES (:al_Filial,							//cd_filial,   
			:al_Nota,							//nr_nf,   
			:as_especie,					//de_especie,   
			:as_serie,						//de_serie,   
			:This.nm_cliente,				//nm_cliente,   
			:This.nr_cgc_cpf,				//nr_cgc_cpf,   
			:This.nm_cidade, 				//nm_cidade,   
			:This.cd_uf_faturamento,	//nm_uf,   
			:This.de_endereco,			//de_endereco,   
			:This.de_bairro,				//de_bairro,   
			:This.nr_cep,					//nr_cep,   
			:This.nr_telefone,				//nr_telefone,   
			null,								// nr_inscricao_estadual,   
			:This.cd_cidade,				// cd_cidade,   
			:This.nr_endereco) 			// nr_endereco)  ;
Using SqlCa;

If Sqlca.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao incluir os dados do cliente na NFE.")
	Return False
End If

Return True
end function

public function string of_retira_caracteres (string as_parametro);String lvs_Retorno

lvs_Retorno = gf_Replace(as_Parametro, ' ', '', 0)
lvs_Retorno = gf_Replace(lvs_Retorno, '.', '', 0)
lvs_Retorno = gf_Replace(lvs_Retorno, '-', '', 0)
lvs_Retorno = gf_Replace(lvs_Retorno, '(', '', 0)
lvs_Retorno = gf_Replace(lvs_Retorno, ')', '', 0)

Return lvs_Retorno
end function

public function boolean of_grava_itens_nf (long al_filial, long al_nota_fiscal, string as_especie, string as_serie, long al_produtos[]);Long  		lvl_Linha,&
      		lvl_Produto,&
		  	lvl_Qtde,&
 			lvl_Natureza_Operacao,&
  			lvl_Find,&
			lvl_Psico,&
			lvl_Prestes,&
			lvl_promocao_sos

 Long ll_Tipo_ICMS 
 
Decimal {2}	ldc_Preco_Unitario,&
				lvdc_pc_Icms,&
				lvdc_BC_Icms_ST,&
				lvdc_Icms_St,&
				lvdc_BC_ICMS,&
				lvdc_ICMS,&
				lvdc_PC_ICMS_ST,&
				lvdc_preco_venda_maximo,&
				lvdc_Nulo,&
				ldc_Desconto,&
				ldc_Preco_Praticado,&
				ldc_Pontos_Clube,&
				ldc_Aliquota_Difa_Origem,&
				ldc_Aliquota_Difa_Destino,&
				ldc_BC_ICMS_FCP_UF_Destino
				
Decimal {2} ldc_BC_ICMS_UF_Destino,&
				ldc_PC_ICMS_UF_Destino,&
				ldc_PC_ICMS_FCP_UF_Destino,&
				ldc_PC_Partilha,&
				ldc_ICMS_FCP_UF_Destino,&
				ldc_ICMS_UF_Destino,&
				ldc_ICMS_UF_Origem

Decimal ldc_BC_PIS, ldc_PIS, ldc_BC_COFINS, ldc_Aliq_PIS, ldc_Aliq_COFINS, ldc_COFINS

String      lvs_Situacao_Tributaria,&
			lvs_ID_Psico,&
			lvs_CST_Origem,&
			lvs_CST_Tributacao,&
			lvs_Etiqueta_Preste,&
			ls_CST_PIS,&
			ls_CST_COFINS,&
			ls_Mensagem_Log

String ls_Beneficio
String ls_Tipo_ICMS

Decimal {5} lvdc_PC_Reducao_Base_ST

Decimal ldc_pc_red_bc_icms_efetivo, ldc_bc_icms_efetivo, ldc_pc_icms_efetivo, ldc_vl_icms_efetivo

Boolean     lvb_Erro

DateTime ldh_Movimentacao

SetPointer(HourGlass!)

SetNull(lvdc_Nulo)

lvb_Erro = False

w_Aguarde.Title = 'Gravando produtos da nota fiscal : ' + String(al_nota_fiscal,'000000') + '/' + as_especie + '/' + as_serie

lvl_Psico 					= 0
il_Sequencial_Item 	= 0

ldh_Movimentacao  	= gvo_Parametro.of_dh_Movimentacao()

For lvl_Linha = 1 TO ids_Itens.RowCount()	

	lvl_Produto          			= ids_Itens.Object.Cd_Produto         	[lvl_Linha]
	lvl_Qtde             			= ids_Itens.Object.qt_pedida			[lvl_Linha]
	lvdc_pc_Icms         		= ids_Itens.Object.pc_icms            	[lvl_Linha]
	
	lvs_Situacao_Tributaria 	= ids_Itens.Object.cd_situacao_tributaria	[lvl_Linha]
	lvl_Natureza_Operacao   = ids_Itens.Object.cd_natureza_operacao	[lvl_Linha]
	
	lvdc_BC_ICMS					= ids_Itens.Object.vl_bc_icms					[lvl_Linha]
	lvdc_ICMS						= ids_Itens.Object.vl_icms						[lvl_Linha]
	lvdc_BC_Icms_ST				= ids_Itens.Object.vl_bc_icms_st				[lvl_Linha]
	lvdc_Icms_St					= ids_Itens.Object.vl_icms_st   				[lvl_Linha]
	lvdc_PC_ICMS_ST				= ids_Itens.Object.pc_icms_st   				[lvl_Linha]
	lvdc_preco_venda_maximo 	= ids_Itens.Object.vl_preco_venda_maximo	[lvl_Linha] 
	lvdc_PC_Reducao_Base_ST	= ids_Itens.Object.pc_reducao_base_st		[lvl_Linha]
	lvs_CST_Origem 				= ids_Itens.Object.cd_cst_origem				[lvl_Linha]
	lvs_CST_Tributacao 			= ids_Itens.Object.cd_cst_tributacao			[lvl_Linha]
	ldc_Desconto					= ids_Itens.Object.pc_desconto_tabela		[lvl_Linha]
	ldc_Preco_Praticado			= ids_Itens.Object.vl_preco_praticado		[lvl_Linha]
	ldc_Preco_Unitario				= ids_Itens.Object.vl_preco_unitario			[lvl_Linha]
			
	ldc_BC_ICMS_UF_Destino			=	ids_Itens.Object.vl_bc_icms_uf_destino			[lvl_Linha]	
	ldc_PC_ICMS_UF_Destino			=	ids_Itens.Object.pc_icms_uf_destino				[lvl_Linha]	
	ldc_PC_ICMS_FCP_UF_Destino		=	ids_Itens.Object.pc_icms_fcp_uf_destino			[lvl_Linha]
	ldc_PC_Partilha							=	ids_Itens.Object.pc_partilha							[lvl_Linha]
	ldc_ICMS_FCP_UF_Destino			=	ids_Itens.Object.vl_icms_fcp_uf_destino			[lvl_Linha]
	ldc_BC_ICMS_FCP_UF_Destino		=	ids_Itens.Object.vl_bc_icms_fcp_uf_destino		[lvl_Linha]
	ldc_ICMS_UF_Destino					=	ids_Itens.Object.vl_icms_uf_destino				[lvl_Linha]
	ldc_ICMS_UF_Origem					= 	ids_Itens.Object.vl_icms_uf_origem				[lvl_Linha]
	ldc_Pontos_Clube						= 	ids_Itens.Object.qt_pontos_clube					[lvl_Linha]
	lvl_Prestes								= 	ids_Itens.Object.id_atualiza_preste				[lvl_Linha]
	lvs_Etiqueta_Preste					= 	ids_Itens.Object.nr_etiqueta_preste				[lvl_Linha]
	lvl_promocao_sos						= 	ids_Itens.Object.cd_promocao_sos				[lvl_Linha]
	ls_Beneficio								= 	ids_Itens.Object.cd_beneficio						[lvl_Linha]
	ll_Tipo_ICMS							=	ids_Itens.Object.cd_tipo_icms						[lvl_Linha]
				
	If lvdc_preco_venda_maximo 		<= 0.00 Then lvdc_preco_venda_maximo = lvdc_Nulo
	
	If gvo_Parametro.ivs_uf_filial <> This.cd_uf_faturamento Then
		If ldc_PC_Partilha = 0.00 Then
			If Not ivo_tratamento_fiscal.of_aliquota_icms_difa(ref ldc_Aliquota_Difa_Origem, ref ldc_Aliquota_Difa_Destino) Then 
				Return False
			End If
					
			ldc_PC_Partilha = ldc_Aliquota_Difa_Destino
		End If
	End If
	
//		Aqui calculo novamente o ICMS efetivo, pois pode ter sofrido altera$$HEX2$$e700e300$$ENDHEX$$o com descontos vinculados ou PBMS ou de subtotal
	ivo_tratamento_fiscal.of_calcula_icms_efetivo( lvl_Produto, lvs_CST_Tributacao, ll_Tipo_ICMS, lvl_Qtde, ldc_Preco_Praticado, ref ldc_pc_red_bc_icms_efetivo, ref ldc_bc_icms_efetivo, ref ldc_pc_icms_efetivo, ref ldc_vl_icms_efetivo) 
			
	SetNull(ls_CST_PIS)
	SetNull(ls_CST_COFINS)
			
	If Not ivo_tratamento_fiscal.of_Retorna_Tributacao_Pis_Cofins(	lvl_Natureza_Operacao,&
																						lvl_Produto,&
																						ldc_Preco_Unitario,&
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
		Return False
	End If
	
	//Atribui o sequencial dos itens
	il_Sequencial_Item++
			
	INSERT INTO item_nf_venda  (	  cd_filial,   
											  nr_nf,   
											  de_especie,   
											  de_serie, 
											  nr_sequencial,
											  cd_produto,   
													 cd_natureza_operacao,   
											  cd_situacao_tributaria,   
											  qt_vendida,   
											  vl_preco_unitario,   
											  pc_desconto_tabela,   
											  vl_preco_praticado,   
											  pc_icms,   
											  pc_comissao_extra,   
											  pc_comissao_normal,   
											  id_alteracao_preco,   
											  id_restricao_convenio,   
											  id_comissionado,   
											  qt_pontos_clube,   
											  id_cancelado,   
											  cd_cst_origem,   
											  cd_cst_tributacao,   
											  cd_promocao_sos,
											  cd_cst_pis,
											  cd_cst_cofins,
											  cd_beneficio,
											  nr_item,
											  pc_red_bc_icms_efetivo,
											  vl_bc_icms_efetivo,
											  pc_icms_efetivo,
											  vl_icms_efetivo)  
	  VALUES (:al_filial,								//cd_filial,   
				  :al_nota_fiscal,						//nr_nf,   
				  :as_especie,							//de_especie,   
				  :as_serie,								//de_serie,   
				  :il_Sequencial_Item,					//nr_sequencial
				  :lvl_Produto,							//cd_produto,   
				  :lvl_Natureza_Operacao,			//cd_natureza_operacao,   
				  :lvs_Situacao_Tributaria,			//cd_situacao_tributaria,   
				  :lvl_Qtde,								//qt_vendida,   
				  :ldc_Preco_Unitario,					//vl_preco_unitario,   
				  :ldc_Desconto,						//pc_desconto_tabela,   
				  :ldc_Preco_Praticado,				//vl_preco_praticado,   
				  :lvdc_pc_Icms,						//pc_icms,   
				  0.00,									//pc_comissao_extra,   
				  0.00,									//pc_comissao_normal,   
				  'N',										//id_alteracao_preco,   
				  'N',										//id_restricao_convenio,   
				  'N',										//id_comissionado,   
				  :ldc_Pontos_Clube,					//qt_pontos_clube,   
				  'N',										//id_cancelado,   
				  :lvs_CST_Origem,					//cd_cst_origem,   
				  :lvs_CST_Tributacao,				//cd_cst_tributacao,   
				  :lvl_promocao_sos,					//cd_promocao_sos)  ;
				  :ls_CST_PIS,							//cd_cst_pis
				  :ls_CST_COFINS,					//cd_cst_cofins
				  :ls_Beneficio,							//cd_beneficio
				  :il_Sequencial_Item,					//nr_item Sequencial do XML
				  :ldc_pc_red_bc_icms_efetivo,		//pc_red_bc_icms_efetivo
				  :ldc_bc_icms_efetivo,				//vl_bc_icms_efetivo
				  :ldc_pc_icms_efetivo,				//pc_icms_efetivo
				  :ldc_vl_icms_efetivo)				//vl_icms_efetivo
	Using SqlCa;	
					
	If Sqlca.Sqlcode = -1 Then
		Sqlca.of_MsgDbError('Gravando o item da nota fiscal.')
		Return False
	End If	
			
	INSERT INTO item_nf_venda_destino  (  cd_filial,   
														  nr_nf,   
														  de_especie,   
														  de_serie,
														  nr_sequencial,															  
														  cd_produto,   
														  cd_natureza_operacao,   
														  cd_uf_destino,   
														  vl_bc_icms_uf_destino,   
														  pc_icms_uf_destino,   
														  pc_icms_fcp_uf_destino,   
														  pc_partilha,   
														  vl_bc_icms_fcp_uf_destino,  
														  vl_icms_fcp_uf_destino,   
														  vl_icms_uf_destino,   
														  vl_icms_uf_origem )  
	VALUES (	:al_filial,									//cd_filial,   
					:al_nota_fiscal,							//nr_nf,   
					:as_especie,							//de_especie,   
					:as_serie,								//de_serie,  
					:il_Sequencial_Item,					//nr_sequencial,
					:lvl_Produto,							//cd_produto,
					:lvl_Natureza_Operacao,				//cd_natureza_operacao,   
					:This.cd_uf_faturamento,			//cd_uf_destino,   
					:ldc_BC_ICMS_UF_Destino,			//vl_bc_icms_uf_destino,   
					:ldc_PC_ICMS_UF_Destino,			//pc_icms_uf_destino,   
					:ldc_PC_ICMS_FCP_UF_Destino,	//pc_icms_fcp_uf_destino,   
					:ldc_PC_Partilha,						//pc_partilha,   
					:ldc_BC_ICMS_FCP_UF_Destino,	//vl_bc_icms_fcp_uf_destino,   
					:ldc_ICMS_FCP_UF_Destino,		//vl_icms_fcp_uf_destino,   
					:ldc_ICMS_UF_Destino,				//vl_icms_uf_destino,   
					:ldc_ICMS_UF_Origem	)			//vl_icms_uf_origem  )  ;
		Using SqlCa;
		
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_MsgDbError('Gravando o item da nota fiscal.')
			Return False
		End If	
		
		//Atualiza etiqueta Prestes
		If lvl_Prestes = 1 Then				
			Update produto_preste_a_vencer
				Set id_situacao 			= 'B', 
					 cd_filial 					= :al_Filial,
					 nr_nf 					= :al_nota_fiscal,
					 de_especie 			= :as_Especie,
					 de_serie 				= :as_serie,
					 dh_baixa 				= :ldh_Movimentacao,
					 nr_matricula_baixa 	= '14330',
					 id_tipo_baixa 			= 'V',
					 nr_sequencial			= :il_Sequencial_Item
			 Where nr_etiqueta  			= :lvs_etiqueta_preste
			 Using Sqlca;		 
				
			If Sqlca.Sqlcode <> 0 Then
				SqlCa.of_RollBack( )			
				If Sqlca.Sqlcode = -1 Then
					SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log, "Atualiza$$HEX2$$e700e300$$ENDHEX$$o Etiqueta Preste." )
					Sqlca.of_MsgDBError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o Etiqueta Preste.")
				End If
				Return False
			End If
		End If
		//Fim Atulizacao Prestes				
		
Next

Return True
end function

public function boolean of_grava_nota ();Decimal {2} lvdc_vl_bc_icms,&
				lvdc_vl_icms,&
				lvdc_vl_bc_icms_st,&
				lvdc_vl_icms_st,&
				lvdc_vl_total_produtos,&
            		lvdc_Fator,&
    		   		lvdc_pc_Icms,&
				lvdc_Aliquota,&
				ldc_Preco,&
				ldc_Perc_Desc				

Decimal ldc_Preco_Liquido				
				
Decimal {2} ldc_Preco_Praticado

Decimal {4} lvdc_Redutor, ldc_Desc_Cab

DateTime	lvdh_Movimentacao,&
				lvdh_Emissao

String	lvs_Situacao_Tributaria,&
         lvs_Especie,&
		lvs_Serie,&
		lvs_Situacao_ST_Faturamento,&
		ls_tipo_venda
		
String ls_Matric_Operador

Long       lvl_Filial_Origem,&
			lvl_Qtde,&
	  	    	lvl_Natureza_Operacao,&
			lvl_nr_nsu,&
   	      	lvl_Produto,&
			lvl_Row,&
			lvl_Itens,&				
			lvl_Itens_Nota[],&
			lvl_Nulo[],&
			ll_Pedido_Droga_Express			
			
Long ll_Filial, ll_nr_nsu
				
Boolean     lvb_Erro

SetPointer(HourGlass!)

//Iniicializa o numero de nota
SetNull(il_Nota_Fiscal)		
		
lvl_Filial_Origem  = gvo_Parametro.of_filial()

ll_Filial =  gvo_Parametro.of_filial()
		
//Carrega dados dos parametros		
lvdh_Movimentacao  	= gvo_Parametro.of_dh_Movimentacao()
lvdh_Emissao       		= gf_getserverdate()

lvs_Especie 	= gvo_parametro.de_especie_nf
lvs_Serie		= gvo_parametro.de_serie_nf

ls_Matric_Operador = gvo_Aplicacao.ivo_Seguranca.nr_matricula

ivo_Filial.Of_Localiza_Codigo(ll_Filial)

This.of_grava_uf_origem_destino(gvo_Parametro.ivs_uf_filial, This.cd_uf_faturamento)

//Carrega itens do pedido
If ids_Itens.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foram localizados os itens para o faturamento do pedido " + This.nr_pedido_drogaexpress +  "'.", StopSign!)
	Return False
End If

//Flag para controle de erros
lvb_Erro = False

ivo_tratamento_fiscal.Of_Inicializa()

lvdc_Vl_Total_Produtos 		= 000.00
lvdc_vl_bc_icms		   		= 000.00
lvdc_vl_icms		   				= 000.00
lvdc_vl_bc_icms_st			= 0.00
lvdc_vl_icms_st					= 0.00

// Esta fun$$HEX2$$e700e300$$ENDHEX$$o preenche o c$$HEX1$$f300$$ENDHEX$$digo da ST na ids_Itens, sendo que todos os produtos diferentes de 01 ser$$HEX1$$e300$$ENDHEX$$o considerados como 00, 
// isso vale somente para que o sistema consiga separar o faturamento dos produtos com ou sem ST
//If Not  This.of_Verifica_Situacao_Tributaria() Then Return False

try

	Open(w_Aguarde)
	w_Aguarde.uo_Progress.of_SetMax(ids_Itens.RowCount())

	lvl_Itens = 0	
	
	ldc_Desc_Cab = This.pc_desconto
	
	For lvl_Row = 1 To ids_Itens.RowCount()
	
		w_Aguarde.Title = "Faturando o pedido da filial '" + String(ll_Filial) + "'."
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Row)				
					
		lvl_Produto 				= ids_Itens.Object.Cd_Produto 				[lvl_Row]
		lvl_Qtde    				= ids_Itens.Object.qt_pedida				[lvl_Row]
		ldc_Preco				= ids_Itens.Object.vl_preco_unitario		[lvl_Row]
		ldc_Perc_Desc 			= ids_Itens.Object.pc_desconto_tabela	[lvl_Row]
		ldc_Preco_Praticado 	= ids_Itens.Object.vl_preco_praticado	[lvl_Row]

		ivo_Produto.Of_Localiza_Codigo_Interno(lvl_Produto)
			
		//Aborta Faturamento
		If Not ivo_Produto.Localizado Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto " + String(lvl_Produto) + " n$$HEX1$$e300$$ENDHEX$$o foi localizado.",StopSign!)
			lvb_Erro = True
			Exit
		End If	
	
		//Contador de Itens da Nota Fiscal
		lvl_Itens ++
		
		lvdc_Vl_Total_Produtos += Round(ldc_Preco_Praticado * lvl_Qtde, 2)
				
		If Not This.of_tributacao(ivo_produto, ldc_Preco_Praticado, 0, gvo_Parametro.ivs_uf_filial,&
											ivo_filial.cd_unidade_federacao, lvl_Qtde) Then
			lvb_Erro = True
			Exit
		End If	
		
//		If ldc_Perc_Desc = 100.00 Then
//			//Passa o preco UN e percentual desconto de 100 %
//			If Not This.of_tributacao(ivo_produto, ldc_Preco, ldc_Perc_Desc, gvo_Parametro.ivs_uf_filial,&
//											ivo_filial.cd_unidade_federacao, lvl_Qtde) Then
//				lvb_Erro = True
//				Exit
//			End If	
//		Else
//			//Passa o valor praticado com o desconto ZERO
//			If Not This.of_tributacao(ivo_produto, ldc_Preco_Praticado, 0, gvo_Parametro.ivs_uf_filial,&
//											ivo_filial.cd_unidade_federacao, lvl_Qtde) Then
//				lvb_Erro = True
//				Exit
//			End If	
//		End If
		
		lvs_Situacao_Tributaria = '0' + Mid(ivo_atributo.cd_situacao_tributaria, 2,1)
					
		lvdc_pc_Icms = ivo_atributo.pc_icms
		
		lvl_Natureza_Operacao   = ivo_atributo.cd_natureza_operacao	
																				  
		ids_Itens.Object.pc_icms               		[lvl_Row] = lvdc_pc_Icms
		
		ids_Itens.Object.cd_situacao_tributaria	[lvl_Row] = lvs_Situacao_Tributaria
		ids_Itens.Object.cd_natureza_operacao	[lvl_Row] = lvl_Natureza_Operacao
		
		ids_Itens.Object.vl_bc_icms_st				[lvl_Row] = round(This.vl_bc_icms_st_prd * lvl_Qtde, 2)
		ids_Itens.Object.vl_icms_st		  			[lvl_Row] = round(This.vl_icms_st_prd * lvl_Qtde, 2)
		
		ids_Itens.Object.vl_bc_icms					[lvl_Row] = round(This.vl_bc_icms * lvl_Qtde, 2)
		ids_Itens.Object.vl_icms		  				[lvl_Row] = round(This.vl_icms * lvl_Qtde, 2)
		
		ids_Itens.Object.pc_icms_st					[lvl_Row] = This.pc_icms_st
		
		ids_Itens.Object.pc_reducao_base_st		[lvl_Row] = This.pc_reducao_base_st
		
		ids_Itens.Object.cd_cst_origem				[lvl_Row] = This.cd_cst_origem
		ids_Itens.Object.cd_cst_tributacao			[lvl_Row] = This.cd_cst_tributacao
		
		ids_Itens.Object.vl_bc_icms_uf_destino			[lvl_Row]	= This.vl_bc_icms_uf_destino
		ids_Itens.Object.vl_bc_icms_uf_destino			[lvl_Row]	= This.vl_bc_icms_uf_destino
		ids_Itens.Object.pc_icms_uf_destino				[lvl_Row]	= This.pc_icms_uf_destino
		ids_Itens.Object.pc_icms_fcp_uf_destino			[lvl_Row]	= This.pc_icms_fcp_uf_destino
		ids_Itens.Object.pc_partilha							[lvl_Row]	= This.pc_partilha 
		ids_Itens.Object.vl_bc_icms_fcp_uf_destino		[lvl_Row]	= This.vl_bc_icms_fcp_uf_destino
		ids_Itens.Object.vl_icms_fcp_uf_destino			[lvl_Row]	= This.vl_icms_fcp_uf_destino
		
		ids_Itens.Object.vl_icms_uf_destino				[lvl_Row]	= This.vl_icms_uf_destino
		ids_Itens.Object.vl_icms_uf_origem				[lvl_Row]	= This.vl_icms_uf_origem
		
		ids_Itens.Object.cd_beneficio						[lvl_Row]	= This.cd_beneficio
		ids_Itens.Object.cd_tipo_icms						[lvl_Row]	= ivo_Produto.cd_Tipo_icms
			
		// Acumula o valor do ICMS para a NF
		// Se for produto Gratis n$$HEX1$$e300$$ENDHEX$$o soma nos totais
		If ldc_Preco_Praticado > idc_Vl_Maximo_Produto_Gratis Then
			lvdc_vl_bc_icms		+= Round(This.vl_bc_icms * lvl_Qtde, 2)
			lvdc_vl_icms	 			+= Round(This.vl_icms * lvl_Qtde, 2)
		
			lvdc_vl_bc_icms_st	+= ids_Itens.Object.vl_bc_icms_st				[lvl_Row]
			lvdc_vl_icms_st			+= ids_Itens.Object.vl_icms_st		  			[lvl_Row]
		End If
		
		//Comentado por Wagner, o calculo esta sendo feito antes da funcao of_tributacao
		//lvdc_Vl_Total_Produtos += ( round(ldc_Preco  * (( 100 - (ldc_Perc_Desc) ) / 100), 2) * lvl_Qtde )
		
		lvl_Itens_Nota[lvl_Itens] = ivo_Produto.cd_produto
		
		// Controla quebra de nota por ST
		lvs_Situacao_ST_Faturamento = ids_Itens.Object.cd_situacao_trib_faturamento[ lvl_Row ]
		
		//Fecha Nota Fiscal
		If	(lvl_Row = ids_Itens.RowCount()) Then
			
			w_Aguarde.Title = 'Faturando filial : ' + String(ll_Filial)
		
			idc_Total_NF   = lvdc_Vl_Total_Produtos + lvdc_vl_icms_st
			If ldc_Desc_Cab > 0 Then //Aplica desconto cabe$$HEX1$$e700$$ENDHEX$$alho
				idc_Total_NF   -=	Round( idc_Total_NF * ( ldc_Desc_Cab / 100 ) ,2 )
				//idc_Total_NF   -= This.vl_desconto
			End If
			idc_Total_NF -= This.vl_desconto_nf //Tratamento Produto Gratis
			
			lvb_Erro = True
			
			If This.of_grava_nota( ll_Filial, ref il_Nota_Fiscal, lvs_Especie, lvs_Serie, lvdc_vl_bc_icms, lvdc_vl_icms,  lvdc_vl_bc_icms_st, lvdc_vl_icms_st, lvdc_Vl_Total_Produtos, idc_Total_NF ) Then
				If This.of_grava_venda_loja( ll_Filial, il_Nota_Fiscal, lvs_Especie, lvs_Serie ) Then
					If This.of_Grava_Itens_NF( lvl_Filial_Origem, il_Nota_Fiscal,lvs_Especie,lvs_Serie,lvl_Itens_Nota[] ) Then
						lvb_Erro = False
					End If	
				End If
			End If	 // Grava Nota
		End If	// Fecha a Nota
		
		//Aborta Faturamento em caso de erro
		If lvb_Erro Then Exit
			
	Next
	
	// Desenvolvimento
	//lvb_Erro = True
		
finally
	Close(w_Aguarde)
end try

If Not lvb_Erro Then
	//Sqlca.of_Commit()		
Else		
	Sqlca.of_RollBack()
	Return False
End If

return true
end function

public function boolean of_proximo_nsu (ref long al_proximo);Boolean lvb_Sucesso = False

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

public function boolean of_grava_nota (long al_filial, ref long al_nota, string as_especie, string as_serie, decimal adc_vl_bc_icms, decimal adc_vl_icms, decimal adc_vl_bc_icms_st, decimal adc_vl_icms_st, decimal adc_vl_total_produtos, decimal adc_vl_total_nf);Long ll_nr_nsu

DateTime ldh_Movimentacao, ldh_Emissao

al_nota = gvo_parametro.Of_Proxima_Nf()
			
If al_nota = 0 Then Return False

If Not This.of_proximo_nsu(ref ll_nr_nsu) Then Return False

//Carrega dados dos parametros		
ldh_Movimentacao  	= gvo_Parametro.of_dh_Movimentacao()
ldh_Emissao       		= gf_getserverdate()

INSERT INTO nf_venda  	( cd_filial,   
								  nr_nf,   
								  de_especie,   
								  de_serie,   
								  id_revenda,   
								  id_tipo_venda,   
								  nr_matric_operador,   
								  dh_emissao,   
								  dh_movimentacao_caixa,   
								  vl_bc_icms,   
								  vl_icms,   
								  vl_bc_icms_st,   
								  vl_icms_st,   
								  vl_total_produtos,   
								  vl_frete,   
								  vl_outras_despesas,   
								  pc_desconto,   
								  vl_total_nf,   
								  vl_pago_avista,   
								  nr_matricula_vendedor,   
								  cd_condicao_crediario,   
								  cd_condicao_convenio,   
								  cd_cliente,   
								  cd_clube_cliente,   
								  cd_convenio,   
								  cd_conveniado,   
								  cd_dependente_cliente,   
								  cd_dependente_conveniado,   
								  nr_matric_alteracao_preco,   
								  nr_matric_liberacao_bloqueio,   
								  nr_matric_liberacao_restricao,   
								  dh_cancelamento,   
								  dh_devolucao,   
								  nr_ecf,   
								  nr_operacao_ecf,   
								  nr_nf_anexa,   
								  de_especie_anexa,   
								  de_serie_anexa,   
								  nr_matricula_cancelamento,   
								  cd_caixa,   
								  nr_controle_caixa,   
								  dh_pagamento_conta,   
								  cd_forma_pagamento,   
								  nr_pedido_drogaexpress,   
								  vl_total_nf_bruto,   
								  id_cancelamento_impressora,   
								  vl_taxa_entrega,   
								  vl_total_nf_tabela,   
								  nr_cartao_edm,   
								  cd_cliente_dependente,   
								  nr_cartao_clube,   
								  qt_pontos_clube,   
								  id_venda_clube,   
								  nr_matric_liberacao_senha,   
								  nr_nsu,   
								  nr_pedido_ecommerce,   
								  nr_ccf,   
								  cd_filial_ecommerce,   
								  nr_cpf_cgc,   
								  de_dados_adicionais,
								  vl_desconto_nf)  
 VALUES (:al_filial,								//cd_filial,   
			:al_Nota,								//nr_nf,   
			:as_especie,						//de_especie,   
			:as_serie,							//de_serie,   
			'N',									//id_revenda,   
			'AV',									//id_tipo_venda,   
			:This.nr_matricula_operador,	//nr_matric_operador,   
			:ldh_Emissao,						//dh_emissao,   
			:ldh_Movimentacao,				//dh_movimentacao_caixa,   
			:adc_vl_bc_icms,					//vl_bc_icms,   
			:adc_vl_icms,						//vl_icms,   
			:adc_vl_bc_icms_st,				//vl_bc_icms_st,   
			:adc_vl_icms_st,					//vl_icms_st,   
			:adc_vl_total_produtos,			//vl_total_produtos,   
			0.00,									//vl_frete,   
			0.00,									//vl_outras_despesas,   
			:This.pc_desconto,				//pc_desconto,   
			:adc_vl_total_nf,					//vl_total_nf,   
			0.00,									//vl_pago_avista,   
			'14330',								//nr_matricula_vendedor,   
			Null,									//cd_condicao_crediario,   
			Null,									//cd_condicao_convenio,   
			:This.cd_cliente,					//cd_cliente,   
			Null,									//cd_clube_cliente,   
			Null,									//cd_convenio,   
			Null,									//cd_conveniado,   
			Null,									//cd_dependente_cliente,   
			Null,									//cd_dependente_conveniado,   
			Null,									//nr_matric_alteracao_preco,   
			Null,									//nr_matric_liberacao_bloqueio,   
			Null,									//nr_matric_liberacao_restricao,   
			Null,									//dh_cancelamento,   
			Null,									//dh_devolucao,   
			Null,									//nr_ecf,   
			Null, 									//nr_operacao_ecf,   
			Null,									//nr_nf_anexa,   
			Null,									//de_especie_anexa,   
			Null,									//de_serie_anexa,   
			Null,									//nr_matricula_cancelamento,   
			:This.cd_caixa,						//cd_caixa,   
			:This.nr_controle_caixa,			//nr_controle_caixa,   
			Null,									//dh_pagamento_conta,   
			:This.cd_forma_pagamento,		//cd_forma_pagamento,   
			:nr_pedido_drogaexpress,		//nr_pedido_drogaexpress,   
			:This.vl_preco_total_bruto,		//vl_total_nf_bruto,   
			'N',			  						//id_cancelamento_impressora,   
			:This.vl_frete,						//			  vl_taxa_entrega,   
			:adc_vl_total_produtos,			//			  vl_total_nf_tabela,   ok
			Null,									//			  nr_cartao_edm,   
			Null,									//			  cd_cliente_dependente,   
			Null,									//			  nr_cartao_clube,   
			:This.qt_pontos_clube_total,	//			  qt_pontos_clube,   
			'N',									//			  id_venda_clube,   
			Null,									//			  nr_matric_liberacao_senha,   
			:ll_nr_nsu,							//			  nr_nsu,   
			:This.nr_pedido_ecommerce,	//			  nr_pedido_ecommerce,   
			Null,									//			  nr_ccf,   
			:This.cd_filial_ecommerce,		//			  cd_filial_ecommerce,   
			Null,									//			  nr_cpf_cgc,   
			:This.de_dados_adicionais,	    //  de_dados_adicionais
			:This.vl_desconto_nf );               //  vl_desconto_nf		   

If SqlCa.SqlCode = -1 Then
	Sqlca.of_MsgDbError('Gravando nota fiscal.')
	Return False
End If

Insert Into nf_venda_nfe(cd_filial, nr_nf, de_especie, de_serie)  
Values (:al_Filial, :al_Nota, :as_Especie, :as_Serie)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDBError("Inclus$$HEX1$$e300$$ENDHEX$$o da NF_VENDA na tabela NFE.")
	Return False
End If

Return True
end function

on uo_ge143_nf_venda_ecommerce.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge143_nf_venda_ecommerce.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;Destroy(ivo_Atributo)
Destroy(ivo_Tratamento_Fiscal)
Destroy(ivo_Parametro)
Destroy(ids_Itens)
Destroy(ivo_Filial)
Destroy(ivo_Produto)
//Destroy(io_nota_fiscal)


end event

event constructor;ivo_tratamento_fiscal = Create uo_Tratamento_Fiscal
ivo_atributo 			 	= Create uo_Atributo_Fiscal_Item_Nf
ivo_Parametro  		= Create uo_Parametro_Geral
ivo_Filial					= Create uo_Filial
ivo_Produto				= Create uo_Produto 				
//io_nota_fiscal		   	= Create UO_NOTA_FISCAL

ids_Itens					= Create dc_uo_ds_base
ids_Itens.of_ChangeDataObject("ds_ge143_itens")

//Configura$$HEX2$$e700e300$$ENDHEX$$o para VENDAS
ivo_tratamento_fiscal.Of_Grava_Contribuinte(False)
ivo_tratamento_fiscal.Of_Grava_Operacao(ivo_tratamento_fiscal.VENDA)
end event

