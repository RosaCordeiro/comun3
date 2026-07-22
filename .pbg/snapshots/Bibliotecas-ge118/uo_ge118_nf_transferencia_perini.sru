HA$PBExportHeader$uo_ge118_nf_transferencia_perini.sru
forward
global type uo_ge118_nf_transferencia_perini from nonvisualobject
end type
type str_custo_invalido from structure within uo_ge118_nf_transferencia_perini
end type
end forward

type str_custo_invalido from structure
	long		produto		descriptor "comment" = "C$$HEX1$$f300$$ENDHEX$$digo do produto com custo zerado ou inv$$HEX1$$e100$$ENDHEX$$lido"
	decimal		custo		descriptor "comment" = "Valor do custo zerado ou inv$$HEX1$$e100$$ENDHEX$$lido"
end type

global type uo_ge118_nf_transferencia_perini from nonvisualobject
end type
global uo_ge118_nf_transferencia_perini uo_ge118_nf_transferencia_perini

type variables
uo_atributo_fiscal_item_nf 	ivo_atributo
uo_tratamento_fiscal			ivo_tratamento_fiscal
uo_Parametro_Geral			ivo_Parametro
uo_Filial							ivo_Filial
uo_Produto 						ivo_Produto

dc_uo_ds_base ids_Itens

dc_uo_ds_Base ids_UF

string cd_situacao_tributaria, cd_cst_origem, cd_cst_tributacao, cd_cst_pis, cd_cst_cofins, ivs_pedido_geladeira  

long cd_natureza_operacao, cd_tributacao_produto

decimal{4} vl_bc_icms_st_prd, vl_icms_st_prd, vl_preco_venda_maximo, vl_mva, pc_reducao_base_icms, vl_bc_icms, vl_icms

decimal pc_icms_st, pc_reducao_base_st, pc_icms, pc_fcp, vl_fcp

Boolean	ib_custo_invalido
private str_custo_invalido	istr_custo_invalido []


end variables

forward prototypes
public function boolean of_filial_liberada_farmacia_popular (long al_filial, ref string as_liberada_farmacia_popular)
public subroutine of_grava_uf_origem_destino ()
public subroutine of_grava_uf_origem_destino (string as_origem, string as_destino)
public function boolean of_verifica_situacao_tributaria ()
public function boolean of_grava_itens_nf_transferencia (long al_filial_origem, long al_nota_fiscal, string as_especie, string as_serie, long al_filial_destino, long al_produtos[], long al_pedido)
public function boolean of_inicializa (long al_filial_destino)
public function boolean of_tributacao (uo_produto ao_produto, ref decimal adc_custo, string as_uf_origem, string as_uf_destino, long al_quantidade)
public function boolean of_grava_lote (long al_filial_origem, long al_nota_fiscal, string as_especie, string as_serie, long al_natoperacao, long al_produto, long al_filial, long al_pedido)
public function boolean of_grava_romaneio_faltante (long al_filial)
public function boolean of_grava_nota (long al_filial_destino, long al_pedido, long al_centro_custo, string as_pedido_almoxarifado, string as_devolucao_urgente, ref long al_array_nf[])
public function boolean of_grava_volumes_nota (long al_filial_origem, long al_nota_fiscal, string as_especie, string as_serie, long al_qt_volumes)
public function boolean of_qtde_volumes_pedido (long al_filial_destino, long al_pedido, ref long al_qtde_volumes)
public function boolean of_localiza_filial (string as_uf, ref long al_filial)
public function boolean of_grava_itens_preco_transferencia ()
public function long of_verifica_dias_pgto_distribuidor (long al_produto)
public subroutine of_messagebox (string as_mensagem)
public function boolean of_verifica_perini_distribuidora (long al_produto, string as_uf, ref long al_achou)
public subroutine _documentacao ()
public subroutine of_envia_msg_custo_invalido ()
public subroutine of_custo_invalido (long al_produto, decimal adc_custo)
end prototypes

public function boolean of_filial_liberada_farmacia_popular (long al_filial, ref string as_liberada_farmacia_popular);Select vl_parametro
Into :as_liberada_farmacia_popular
From parametro_loja
where cd_filial				= :al_Filial
	and cd_parametro  	= 'ID_POSSUI_VIDALINK'
	and vl_parametro 		= 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		as_liberada_farmacia_popular = Upper(as_liberada_farmacia_popular)
	Case 100
		as_liberada_farmacia_popular = 'N'
	Case -1
		SqlCa.of_MsgDbError("Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro para ver se a loja esta liberada para a farm$$HEX1$$e100$$ENDHEX$$cia popular.")
		Return False
End Choose
//

Return True
end function

public subroutine of_grava_uf_origem_destino ();
end subroutine

public subroutine of_grava_uf_origem_destino (string as_origem, string as_destino);ivo_Tratamento_Fiscal.Of_Grava_Uf_Origem_Destino(as_origem, as_destino)
end subroutine

public function boolean of_verifica_situacao_tributaria ();Long lvl_Row, lvl_Produto

String lvs_Situacao_Trib_Faturamento, ls_Situacao_Tributaria

Boolean lvb_Sucesso = True

Open(w_Aguarde)
w_Aguarde.uo_Progress.of_SetMax(ids_Itens.RowCount())

w_Aguarde.Title = 'Verificando a situa$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria dos produtos ...'

For lvl_Row = 1 To ids_Itens.RowCount()
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Row)				
				
	lvl_Produto = ids_Itens.Object.Cd_Produto[lvl_Row]
	
	// Somente para faturamento dentro do estado
	If gvo_Parametro.ivs_uf_filial <> ivo_filial.cd_unidade_federacao Then
		ids_Itens.Object.cd_situacao_trib_faturamento[lvl_Row] = '00'
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
		//ids_Itens.Object.cd_situacao_trib_faturamento[lvl_Row] = ivo_atributo.cd_situacao_tributaria
		ids_Itens.Object.cd_situacao_trib_faturamento[lvl_Row] = ls_Situacao_Tributaria
	Else
		ids_Itens.Object.cd_situacao_trib_faturamento[lvl_Row] = '00'
	End If
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

public function boolean of_grava_itens_nf_transferencia (long al_filial_origem, long al_nota_fiscal, string as_especie, string as_serie, long al_filial_destino, long al_produtos[], long al_pedido);Long  		lvl_Linha,&
      		lvl_Produto,&
		  	lvl_Qtde,&
 			lvl_Natureza_Operacao,&
  			lvl_Find,&
			lvl_Psico
				  
Decimal {2}	lvdc_Custo,&
			lvdc_Custo_Gerencial,&
			lvdc_pc_Icms,&
			lvdc_BC_Icms_ST,&
			lvdc_Icms_St,&
			lvdc_BC_ICMS,&
			lvdc_ICMS,&
			lvdc_PC_ICMS_ST,&
			lvdc_preco_venda_maximo,&
			lvdc_Nulo,&
			ldc_Red_Base_ICMS,&
			ldc_PC_FCP,&
			ldc_VL_FCP
			
Decimal {4} ldc_PC_MVA

String      lvs_Situacao_Tributaria,&
			lvs_ID_Psico,&
			lvs_CST_Origem,&
			lvs_CST_Tributacao,&
			ls_CST_PIS,&
			ls_CST_COFINS

Decimal {5} lvdc_PC_Reducao_Base_ST

Boolean     lvb_Erro

SetPointer(HourGlass!)

SetNull(lvdc_Nulo)

lvb_Erro = False

w_Aguarde.Title = 'Gravando produtos da nota fiscal : ' + String(al_nota_fiscal,'000000') + '/' + as_especie + '/' + as_serie

lvl_Psico = 0

For lvl_Linha = 1 TO UpperBound(al_produtos)
	
	lvl_Produto = al_produtos[lvl_Linha]
	
	lvl_Find = ids_Itens.Find('cd_produto = ' + String(lvl_Produto),1,ids_Itens.RowCount())
	
	If lvl_Find > 0 Then
		
		lvl_Produto          				= ids_Itens.Object.Cd_Produto         	[lvl_Find]
		lvl_Qtde             				= ids_Itens.Object.qt_pedida			[lvl_Find]
		lvdc_Custo           				= ids_Itens.Object.vl_custo           	[lvl_Find]
		lvdc_Custo_Gerencial 			= ids_Itens.Object.vl_custo_gerencial	[lvl_Find]
		lvdc_pc_Icms         			= ids_Itens.Object.pc_icms            	[lvl_Find]
		
		lvs_Situacao_Tributaria 		= ids_Itens.Object.cd_situacao_tributaria	[lvl_Find]
		lvl_Natureza_Operacao   	= ids_Itens.Object.cd_natureza_operacao	[lvl_Find]
		
		lvdc_BC_ICMS					= ids_Itens.Object.vl_bc_icms					[lvl_Find]
		lvdc_ICMS						= ids_Itens.Object.vl_icms						[lvl_Find]
		lvdc_BC_Icms_ST				= ids_Itens.Object.vl_bc_icms_st				[lvl_Find]
		lvdc_Icms_St					= ids_Itens.Object.vl_icms_st   				[lvl_Find]
		lvdc_PC_ICMS_ST				= ids_Itens.Object.pc_icms_st   				[lvl_Find]
		lvdc_preco_venda_maximo 	= ids_Itens.Object.vl_preco_venda_maximo	[lvl_Find] 
		lvdc_PC_Reducao_Base_ST	= ids_Itens.Object.pc_reducao_base_st		[lvl_Find]
		lvs_CST_Origem 				= ids_Itens.Object.cd_cst_origem				[lvl_Find]
		lvs_CST_Tributacao 			= ids_Itens.Object.cd_cst_tributacao			[lvl_Find]
		ldc_PC_MVA						= ids_Itens.Object.vl_mva						[lvl_Find]
		ldc_PC_FCP						= ids_Itens.Object.pc_fcp						[lvl_Find]
		ldc_VL_FCP						= ids_Itens.Object.vl_fcp							[lvl_Find]
		ls_CST_PIS						= ids_Itens.Object.cd_cst_pis					[lvl_Find]
		ls_CST_COFINS				= ids_Itens.Object.cd_cst_cofins				[lvl_Find]
		ldc_Red_Base_ICMS			= ids_Itens.Object.pc_reducao_base_icms	[lvl_Find]
	
//		If lvdc_PC_Reducao_Base_ST > 0.00 Then
//			lvdc_PC_Reducao_Base_ST = round((1 - lvdc_PC_Reducao_Base_ST) * 100, 4)
//		End If
		
		If lvdc_preco_venda_maximo <= 0.00 Then lvdc_preco_venda_maximo = lvdc_Nulo
		
		Insert Into item_nf_transferencia  
				( cd_filial_origem,   
				  nr_nf,   
				  de_especie,   
				  de_serie,   
				  cd_natureza_operacao,   
				  cd_produto,   
				  cd_filial_destino,   
				  cd_situacao_tributaria,   
				  qt_transferida,   
				  vl_custo_unitario,
				  vl_custo_gerencial,
				  pc_icms,
				  vl_bc_icms_st,
				  vl_icms_st,
				  vl_bc_icms,
				  vl_icms,
				  pc_icms_st,
				  vl_preco_venda_maximo,
				  pc_reducao_base_st,
				  cd_cst_origem,
				  cd_cst_tributacao,
				  pc_mva,
				  pc_fcp,
				  vl_fcp,
				  cd_cst_pis,
				  cd_cst_cofins,
				  pc_reducao_base_icms,
				  nr_sequencial)  
	  Values ( :al_filial_origem,
				  :al_nota_fiscal,   
				  :as_especie,   
				  :as_serie,   
				  :lvl_natureza_operacao,   
				  :lvl_produto,   
				  :al_filial_destino,   
				  :lvs_situacao_tributaria,   
				  :lvl_qtde,   
				  :lvdc_custo,
				  :lvdc_custo_gerencial,
				  :lvdc_pc_icms,
				  :lvdc_BC_Icms_ST,
				  :lvdc_Icms_ST,
				  :lvdc_BC_Icms,
				  :lvdc_Icms,
				  :lvdc_PC_ICMS_ST,
				  :lvdc_preco_venda_maximo,
				  :lvdc_PC_Reducao_Base_ST,
				  :lvs_CST_Origem,
				  :lvs_CST_Tributacao,
				  :ldc_PC_MVA,
				  :ldc_PC_FCP,
				  :ldc_VL_FCP,
				  :ls_CST_PIS,
				  :ls_CST_COFINS,
				  :ldc_Red_Base_ICMS,
				  :lvl_Linha)
		Using Sqlca;
		
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_MsgDbError('Gravando o item da nota fiscal.')
			Return False
		End If
		
		If Not Isnull(al_pedido) Then
			If Not of_grava_lote(	al_filial_origem,al_nota_fiscal,&
										as_especie, 	as_serie, lvl_natureza_operacao,&
										lvl_produto, al_filial_destino, al_Pedido) Then
				Return False
			End If
		End If
		
//		If Not wf_Grava_Melhor_Compra_Distribuidora(al_filial_origem,al_nota_fiscal,&
//																	as_especie, 	as_serie, lvl_natureza_operacao,&
//																	lvl_produto, al_filial_destino) Then
//			Return False
//		End If
		
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Find ao localizar produto : " + String(lvl_Produto),StopSign!)
		Return False
	End If	
Next

Return True
end function

public function boolean of_inicializa (long al_filial_destino);String ls_Liberada_Farmacia_Popular

ivo_tratamento_fiscal.Of_Inicializa()

If of_filial_liberada_farmacia_popular(al_filial_destino, ref ls_Liberada_Farmacia_Popular) Then 
	ivo_tratamento_fiscal.ivs_filial_farmacia_popular =  ls_Liberada_Farmacia_Popular
Else
	Return False
End If

ivo_Tratamento_Fiscal.ivl_Filial_Destino = al_filial_destino


Select  coalesce(vl_parametro , 'N')  
Into :ivs_pedido_geladeira
From wms_parametro wp 
Where wp.cd_parametro = 'ID_PEDIDO_GELADEIRA_SEPARADO'
Using SqlCA;

Choose Case SqlCa.Sqlcode
	Case 0
	Case 100		
		Return False
	Case -1
		Return False
End Choose

Return True
end function

public function boolean of_tributacao (uo_produto ao_produto, ref decimal adc_custo, string as_uf_origem, string as_uf_destino, long al_quantidade);Boolean lb_Repasse_ICMS

String ls_Situacao_Tributaria, ls_Pis_Cofins, ls_Fornecedor, lvs_Tributacao_Icms

Decimal ldc_Aliquota, ldc_PC_ICMS, ldc_IPI, ldc_Desconto_NF

Decimal {4} ldc_Redutor

//Carrega os atributos fiscais
ivo_atributo = ivo_tratamento_fiscal.of_atributo_fiscal_produto(ao_produto)

//Aborta Faturamento / Aborta calculo
If Not ivo_atributo.Localizado Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Atributos fiscais do produto " + String(ao_produto.cd_produto) + " n$$HEX1$$e300$$ENDHEX$$o foram localizados.",StopSign!)
	Return False
End If	

ls_Situacao_Tributaria = '0' + Mid(ivo_atributo.cd_situacao_tributaria, 2,1)

lvs_Tributacao_Icms	= ivo_atributo.cd_tributacao_icms
	
// Solicitante: Fernando Correa
// Motivo: Mudan$$HEX1$$e700$$ENDHEX$$a do faturamento do Perini
// Data: 27/12/2011
// Medicamento
// Acrescenta o valor do ICMS no custo do produto.  Custo: 10,00 Aliquota: 12% => (10,00 / 0,88) => 11,36
If ivo_tratamento_fiscal.ivi_tributacao_produto = 0 and ls_Situacao_Tributaria = '01'  Then
	ldc_Aliquota = (100 - ivo_atributo.pc_icms) / 100
	adc_custo = round(adc_custo / ldc_Aliquota, 2)
End If		
	
If Not ivo_tratamento_fiscal.of_Redutor_Custo_Produto(as_uf_origem, as_uf_destino, ao_produto.cd_produto, Ref ldc_Redutor) Then Return False
	
adc_custo = Round(adc_custo /  ldc_Redutor, 2)
	
//Aborta Faturamento
If IsNull(adc_custo) or adc_custo <= 0 Then
	//Produtos com custo inv$$HEX1$$e100$$ENDHEX$$lido s$$HEX1$$e300$$ENDHEX$$o jogados numa lista a ser enviada por e-mail ao final do processo
	ib_custo_invalido = True
	Return True
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Custo do produto " + String(ao_produto.cd_produto) + " n$$HEX1$$e300$$ENDHEX$$o localizado ou inv$$HEX1$$e100$$ENDHEX$$lido.",StopSign!)
//	Return False
else
	ib_custo_invalido = False
End If	
				
ldc_PC_ICMS = ivo_atributo.pc_icms
		
//ivo_Tratamento_Fiscal.of_Grava_ICMS_Produto(ao_produto.cd_produto,  al_quantidade,  adc_custo, 0, ls_Situacao_Tributaria, ldc_PC_ICMS)

// Vari$$HEX1$$e100$$ENDHEX$$veis que s$$HEX1$$e300$$ENDHEX$$o passadas para calculo da tributa$$HEX2$$e700e300$$ENDHEX$$o que n$$HEX1$$e300$$ENDHEX$$o s$$HEX1$$e300$$ENDHEX$$o utilizadas
ldc_IPI 				= 0.00
ldc_Desconto_NF 	= 0.00
lb_Repasse_ICMS = False
SetNull(ls_Pis_Cofins)
SetNull(ls_Fornecedor)

ivo_Tratamento_Fiscal.of_Grava_ICMS_Produto(	ao_produto, &
														  		al_quantidade, &
														  		adc_custo, &
														  		0, &
														  		lvs_Tributacao_Icms, &
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
	
This.cd_situacao_tributaria		= ls_Situacao_Tributaria
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

This.pc_fcp							= ivo_tratamento_fiscal.ivo_Atributo_NF.pc_fcp
This.vl_fcp							= ivo_tratamento_fiscal.ivo_Atributo_NF.vl_fcp

This.cd_cst_pis						= ivo_tratamento_fiscal.ivo_Atributo_NF.cd_cst_pis
This.cd_cst_cofins					= ivo_tratamento_fiscal.ivo_Atributo_NF.cd_cst_cofins

If ivo_tratamento_fiscal.ivi_tributacao_produto = 0 and ls_Situacao_Tributaria= '01' Then
	// PMC
	This.vl_preco_venda_maximo = ivo_tratamento_fiscal.ivdc_preco_venda_maximo
End If		

// 0.90 => 10 %
If This.pc_reducao_base_st > 0 Then
	This.pc_reducao_base_st	=	(1 - This.pc_reducao_base_st) * 100	
End If

// 1,9947		=>	99,47 %
If This.vl_mva > 0 Then
	This.vl_mva = (This.vl_mva - 1) * 100
End If
		
ivo_tratamento_fiscal.Of_Calcula_Icms(0)
		
Return True
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

If Not lds.of_ChangeDataObject("ds_ge118_lote_pedido")  Then
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

public function boolean of_grava_nota (long al_filial_destino, long al_pedido, long al_centro_custo, string as_pedido_almoxarifado, string as_devolucao_urgente, ref long al_array_nf[]);Decimal {2} lvdc_vl_bc_icms,&
				lvdc_vl_icms,&
				lvdc_vl_bc_icms_st,&
				lvdc_vl_icms_st,&
				lvdc_vl_total_produtos,&
				lvdc_vl_total_nf,&
            		lvdc_Fator,&
            		lvdc_Custo,&
            		lvdc_Custo_Gerencial,&
    		   		lvdc_pc_Icms,&
				lvdc_Aliquota

Decimal {4} lvdc_Redutor

DateTime	lvdh_Movimentacao,&
				lvdh_Emissao

String	lvs_Situacao_Tributaria,&
         lvs_Especie,&
		lvs_Serie,&
		lvs_Operador,&
		lvs_Distribuidora_Estoque,&
		lvs_Situacao_ST_Faturamento,&
		lvs_Proxima_ST_Faturamento

Long       lvl_Filial_Origem,&
			lvl_Qtde,&
	  	    	lvl_Natureza_Operacao,&
		    	lvl_Nota_Fiscal,&
			lvl_nr_nsu,&
   	      	lvl_Produto,&
			lvl_Row,&
			lvl_Itens,&				
			lvl_Itens_Nota[],&
			lvl_Nulo[],&
			lvl_Contador,&
			ll_Qt_Total_Volumes,&
			ll_Qt_Volumes,&
			ll_Percentual,&
			ll_Qt_Volumes_Utilizados
				
Boolean     lvb_Erro

SetPointer(HourGlass!)

//*************************************************
// CONFERIR FATURAMENTO URGENTE, NAS ROTINAS DE ATUALIZA$$HEX2$$c700c300$$ENDHEX$$O DE LOTES.
//*************************************************
		
lvl_Filial_Origem  = gvo_Parametro.of_filial()		
		
//Carrega dados dos parametros		
lvdh_Movimentacao  	= gvo_Parametro.of_dh_Movimentacao()
lvdh_Emissao       		= gf_getserverdate()

lvs_Distribuidora_Estoque = gvo_Parametro.of_distribuidora_estoque()
		  
If Not ivo_Parametro.of_Especie_NF(ref lvs_Especie) Then Return False

If Not ivo_Parametro.of_Serie_NF(ref lvs_Serie) Then Return False

lvs_Operador = gvo_Aplicacao.ivo_Seguranca.nr_matricula



If gvb_Auto    Then
	lvs_Operador = '14330'
Else
	lvs_Operador = gvo_Aplicacao.ivo_Seguranca.nr_matricula
End If 




ivo_Filial.Of_Localiza_Codigo(al_filial_destino)

//Configura Uf das filiais
This.of_grava_uf_origem_destino(gvo_Parametro.ivs_uf_filial,ivo_filial.cd_unidade_federacao)

//Carrega itens do pedido
If ids_Itens.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foram localizados os itens para o faturamento do pedido da filial '" + string(al_Filial_Destino) + "'.", StopSign!)
	Return False
End If

//Flag para controle de erros
lvb_Erro = False

If Not This.of_inicializa(al_filial_destino) Then Return False

lvdc_Vl_Total_Produtos 	= 000.00
lvdc_vl_bc_icms		   	= 000.00
lvdc_vl_icms		   			= 000.00
lvdc_vl_bc_icms_st		= 0.00
lvdc_vl_icms_st				= 0.00
lvl_Contador					= 0

// Esta fun$$HEX2$$e700e300$$ENDHEX$$o preenche o c$$HEX1$$f300$$ENDHEX$$digo da ST na ids_Itens, sendo que todos os produtos diferentes de 01 ser$$HEX1$$e300$$ENDHEX$$o considerados como 00, 
// isso vale somente para que o sistema consiga separar o faturamento dos produtos com ou sem ST
If Not  This.of_Verifica_Situacao_Tributaria() Then Return False

try

	Open(w_Aguarde)
	w_Aguarde.uo_Progress.of_SetMax(ids_Itens.RowCount())
	
	If Not of_Qtde_Volumes_Pedido(al_filial_destino, al_Pedido, Ref ll_Qt_Total_Volumes) Then
		Return False
	End If

	lvl_Itens = 0
	ll_Qt_Volumes_Utilizados = 0
	
	For lvl_Row = 1 To ids_Itens.RowCount()
	
		w_Aguarde.Title = "Faturando o pedido da filial '" + String(al_filial_destino) + "'."
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Row)				
					
		lvl_Produto 	= ids_Itens.Object.Cd_Produto 		[lvl_Row]
		lvl_Qtde    	= ids_Itens.Object.qt_pedida		[lvl_Row]

		ivo_Produto.Of_Localiza_Codigo_Interno(lvl_Produto)
	
		//Aborta Faturamento
		If Not ivo_Produto.Localizado Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto " + String(lvl_Produto) + " n$$HEX1$$e300$$ENDHEX$$o foi localizado.",StopSign!)
			lvb_Erro = True
			Exit
		End If	
	
		//Contador de Itens da Nota Fiscal
		lvl_Itens ++
		
		lvdc_Custo 			 	= ivo_Produto.of_Custo_Medio()
		lvdc_Custo_Gerencial = ivo_Produto.of_Custo_Gerencial()
		
		If Not This.of_tributacao(ivo_produto, ref lvdc_Custo, gvo_Parametro.ivs_uf_filial,&
										ivo_filial.cd_unidade_federacao, lvl_Qtde) Then
			lvb_Erro = True
			Exit
		End If
		
		lvs_Situacao_Tributaria = '0' + Mid(ivo_atributo.cd_situacao_tributaria, 2,1)
					
		lvdc_pc_Icms = ivo_atributo.pc_icms
		
		lvl_Natureza_Operacao   = ivo_atributo.cd_natureza_operacao	
		
		// Solicitante: Fernando Correa
		// Motivo: Mudan$$HEX1$$e700$$ENDHEX$$a do faturamento do Perini
		// Data: 27/12/2011
		lvdc_Custo_Gerencial = lvdc_Custo + This.vl_icms_st_prd
																  
		ids_Itens.Object.vl_custo              		[lvl_Row] = lvdc_Custo
		ids_Itens.Object.vl_custo_gerencial    	[lvl_Row] = lvdc_Custo_Gerencial
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
		
		ids_Itens.Object.vl_mva						[lvl_Row] = This.vl_mva
		
		ids_Itens.Object.pc_fcp						[lvl_Row] = This.pc_fcp
		ids_Itens.Object.vl_fcp						[lvl_Row] = This.vl_fcp
		
		ids_Itens.Object.cd_cst_pis					[lvl_Row] = This.cd_cst_pis
		ids_Itens.Object.cd_cst_cofins				[lvl_Row] = This.cd_cst_cofins
		
		ids_Itens.Object.pc_reducao_base_icms	[lvl_Row] = This.pc_reducao_base_icms
						
		If ivo_tratamento_fiscal.ivi_tributacao_produto = 0 and lvs_Situacao_Tributaria= '01' Then
			// PMC
			ids_Itens.Object.vl_preco_venda_maximo[lvl_Row] = ivo_tratamento_fiscal.ivdc_preco_venda_maximo
		End If		
			
		// Acumula o valor do ICMS para a NF
		lvdc_vl_bc_icms		+= Round(This.vl_bc_icms * lvl_Qtde, 2)
		lvdc_vl_icms	 			+= Round(This.vl_icms * lvl_Qtde, 2)
		
		lvdc_vl_bc_icms_st	+= ids_Itens.Object.vl_bc_icms_st				[lvl_Row]
		lvdc_vl_icms_st			+= ids_Itens.Object.vl_icms_st		  			[lvl_Row]
		
		lvdc_Vl_Total_Produtos += ( lvdc_Custo * lvl_Qtde )
			
		//Armazena os itens da nota fiscal
		lvl_Itens_Nota[lvl_Itens] = ivo_Produto.cd_produto
		
		// Controla quebra de nota por ST
		lvs_Situacao_ST_Faturamento = ids_Itens.Object.cd_situacao_trib_faturamento[lvl_Row]
		
		//Verifica o grupo do pr$$HEX1$$f300$$ENDHEX$$ximo produto
		If ( lvl_Row < ids_Itens.RowCount() ) Then
			 lvs_Proxima_ST_Faturamento	= ids_Itens.Object.cd_situacao_trib_faturamento	[lvl_Row+1]		 
		End If
			
		//Fecha Nota Fiscal
		If	( lvl_Itens = 500 ) or ( lvl_Row = ids_Itens.RowCount() ) Then
			
			//-------------------Calcula quantos volumes ir$$HEX1$$e300$$ENDHEX$$o por nota-----------------------------------------
			If  ids_Itens.RowCount() <=  500 Then
				ll_Qt_Volumes = ll_Qt_Total_Volumes
			Else				
				If lvl_Row = ids_Itens.RowCount() Then				
					ll_Qt_Volumes	= ll_Qt_Total_Volumes	-	ll_Qt_Volumes_Utilizados
				Else
					ll_Percentual	= Truncate( (500 / ids_Itens.RowCount()) * 100, 0)
					ll_Qt_Volumes	= Truncate((ll_Percentual * ll_Qt_Total_Volumes) / 100, 0)
				End If
				
			End If
			
			ll_Qt_Volumes_Utilizados += ll_Qt_Volumes
			//--------------------------------------------------------------------------------------------------------
			
			If Not ivo_Parametro.of_Proxima_NF(ref lvl_Nota_Fiscal) Then 
				lvb_Erro = True
				Exit
			End If
			
			lvl_Contador ++
			
			al_Array_NF[lvl_Contador] = lvl_Nota_Fiscal
					
			If Not ivo_Parametro.of_Proximo_Nsu(ref lvl_nr_nsu) Then 
				lvb_Erro = True
				Exit
			End If
			
			If Not Isnull(al_pedido) Then
				w_Aguarde.Title = 'Faturando filial : ' + String(al_filial_destino) + ' pedido : ' + String(al_pedido) + ' Nota Fiscal : ' + String(lvl_Nota_Fiscal)
			Else
				w_Aguarde.Title = 'Faturando filial : ' + String(al_filial_destino) + ' Nota Fiscal : ' + String(lvl_Nota_Fiscal)
			End If
			
			lvdc_vl_total_nf   	  = lvdc_Vl_Total_Produtos + lvdc_vl_icms_st
			
			Insert Into nf_transferencia  ( 	cd_filial_origem, nr_nf, de_especie, de_serie, cd_filial_destino, dh_emissao, dh_movimentacao_caixa,   
					  								vl_bc_icms, vl_icms, vl_bc_icms_st, vl_icms_st, vl_total_produtos, vl_total_nf, nr_matricula_operador,   
					  								id_produto_vencido, cd_distribuidora, nr_pedido_distribuidora, nr_nsu, id_atualizacao_mov_estoque, cd_centro_custo, id_almoxarifado, id_devolucao, nr_itens)
			Values (	:lvl_Filial_Origem, :lvl_Nota_Fiscal, :lvs_Especie,:lvs_Serie, :al_filial_destino,:lvdh_Emissao, :lvdh_Movimentacao,
					  	:lvdc_vl_bc_icms, :lvdc_vl_icms,:lvdc_vl_bc_icms_st, :lvdc_vl_icms_st, :lvdc_vl_total_produtos, :lvdc_vl_total_nf,
					  	:lvs_Operador,  'N', :lvs_Distribuidora_Estoque, :al_pedido, :lvl_nr_nsu, 'N', :al_centro_custo, :as_pedido_almoxarifado, :as_devolucao_urgente, :lvl_Itens)
			Using Sqlca;
		
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_MsgDbError('Gravando nota fiscal.')
				lvb_Erro = True
			Else
				If of_grava_volumes_nota(lvl_Filial_Origem, lvl_Nota_Fiscal, lvs_Especie, lvs_Serie, ll_Qt_Volumes) Then
					If of_Grava_Itens_Nf_Transferencia(lvl_Filial_Origem,lvl_Nota_Fiscal,lvs_Especie,lvs_Serie,al_filial_destino,lvl_Itens_Nota[], al_Pedido) Then
						
						// Desenvolvimento
						//wf_teste(lvl_Filial_Origem, lvl_Nota_Fiscal, lvs_especie, lvs_Serie, 'dw_fa008_nf_somente_teste')
						//wf_teste(lvl_Filial_Origem, lvl_Nota_Fiscal, lvs_especie, lvs_Serie, 'dw_fa008_item_nf_somente_teste')
										
						ivo_tratamento_fiscal.Of_Inicializa()
						
						//Limpa array de produtos da nota faturada
						lvl_Itens_Nota = lvl_Nulo
						
						lvdc_Vl_Total_Produtos 	= 000.00
						lvdc_vl_bc_icms		   		= 000.00
						lvdc_vl_icms		   			= 000.00
						lvl_Itens 			   			= 0
						lvdc_vl_bc_icms_st			= 0.00
						lvdc_vl_icms_st				= 0.00
						
						Continue
						
					Else
						lvb_Erro = True
					End If	
				Else
					lvb_Erro = True
				End If
			End If		
			
		End If	
		
		//Aborta Faturamento em caso de erro
		If lvb_Erro Then Exit
			
	Next
	
	// Desenvolvimento
	//lvb_Erro = True
	
	If Not lvb_Erro Then
		If Not IsNull(al_Pedido) Then
			If al_Filial_Destino <> 534 and al_Filial_Destino <> 2 Then
				If Not of_grava_romaneio_faltante(al_filial_destino) Then
					lvb_Erro = True	
				End If
					
				If Not gf_grava_volume_romaneio(al_filial_destino, al_Pedido, ivs_pedido_geladeira, Date(lvdh_Emissao)) Then
					lvb_Erro = True
				End If
			End If
		End If
	End If

finally
	Close(w_Aguarde)
end try

If Not lvb_Erro Then
	
	If Not IsNull(al_pedido) Then
		Update pedido_distribuidora
		set id_situacao = 'F'
		Where cd_filial = :al_filial_destino
		  and nr_pedido_distribuidora = :al_pedido
		Using Sqlca;
		
		If Sqlca.Sqlcode = -1 Then
			Sqlca.Of_RollBack()
			Sqlca.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do pedido.")
			Return False
		Else	
			Sqlca.of_Commit()		
			Return True
		End If
	Else
		Sqlca.of_Commit()		
	End If
		
Else		
	Sqlca.of_RollBack()
	
	If Not IsNull(al_Pedido) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Faturamento do pedido da filial : " + String(al_filial_destino) + " pedido : " + String(al_Pedido) + " foi abortado !",StopSign!)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Faturamento do pedido da filial : " + String(al_filial_destino) + " foi abortado !",StopSign!)
	End If
		
	Return False
End If

return true
end function

public function boolean of_grava_volumes_nota (long al_filial_origem, long al_nota_fiscal, string as_especie, string as_serie, long al_qt_volumes);
Update nf_transferencia_nfe
Set qt_volume = :al_Qt_Volumes
Where	cd_filial_origem	= :al_Filial_Origem
	And	nr_nf 					= :al_Nota_Fiscal
	And	de_especie			= :as_Especie
	And	de_serie				= :as_Serie
Using SqlCa;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_MsgDbError("Erro na grava$$HEX2$$e700e300$$ENDHEX$$o da quantidade de volumes da nota.")
	Return False
End If

Return True
end function

public function boolean of_qtde_volumes_pedido (long al_filial_destino, long al_pedido, ref long al_qtde_volumes);Long ll_Qtde

select count(*)
Into :al_Qtde_Volumes
from wms_lista_separacao
where cd_filial					= :al_filial_destino
and nr_pedido_distribuidora	= :al_Pedido
Using SqlCa;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_MsgDbError("Erro ao consultar a quantidade de volumes do pedido "+String(al_Pedido)+" da filial "+String(al_Filial_Destino)+".")
	Return False
End If

Return True
end function

public function boolean of_localiza_filial (string as_uf, ref long al_filial);String ls_MSG

Select top 1 cd_filial
Into :al_Filial
From vw_filial
where cd_uf = :as_Uf
Using SqlCa;

Choose Case Sqlca.SqlCode
	Case 0
		Return True
		
	Case 100
		This.of_MessageBox("N$$HEX1$$e300$$ENDHEX$$o foi localizada filial para a UF '" + as_UF + "'.")
		
	Case -1
		This.of_MessageBox("Erro ao localizar a filial da UF '" + as_UF + "'. " + SqlCa.SqlErrText)
		
End Choose

Return False
end function

public function boolean of_grava_itens_preco_transferencia ();Boolean lb_Sucesso = False

Long   ll_Linhas,&
		 ll_RowUF,&
		 ll_Filial,&
		 ll_Produtos,&
		 ll_RowProdutos,&
		 ll_Produto,&
		 ll_CdProduto,&
		 ll_LojaFilial,&
		 ll_SaldoCD,&
		 ll_Hora,&		 
		 ll_DiasPagamento, &
		 ll_Achou, &
		 ll_Commit

String  ls_UF,&
		  ls_Produto,&
		  ls_MSG,&
		  ls_DataAtualiza,&
		  ls_Erro

Date ldh_saldo	   
DateTime ldh_data		

Decimal  lvl_Vl_Custo,&
			lvl_Vl_ICMS_St,&
			lvl_Vl_Transf,&
			lvl_Pc_Icms			

uo_Produto 								lo_Produto			
uo_ge118_nf_transferencia_perini lo_NF
dc_uo_ds_base							lds_Produtos 
	
Try 
	
	ll_Hora			 = Hour(Now())	
	ldh_saldo 		 = Date("01/" + String(DateTime(gf_GetServerDate()), "mm/yyyy"))
	ldh_data			 = 	DateTime(gf_GetServerDate())
	ls_DataAtualiza  = String(ldh_data,"DD/MM/YYYY HH:MM:SS")
			
	// Consulta Ultima Data de Execu$$HEX2$$e700e300$$ENDHEX$$o
//	select vl_parametro
//	Into :ls_DataUltimaExecucao
//	from  parametro_geral
//	where cd_parametro = 'DH_ULTIMA_ATUALIZACAO_CD_DISTRIBUIDORA'
//	Using SqlCa;	
//	
//	If Sqlca.Sqlcode = -1 Then
//		ls_MSG = "Erro Consulta Parametro :DH_ULTIMA_ATUALIZACAO_CD_DISTRIBUIDORA. " + SqlCa.SqlErrText		
//		This.of_MessageBox(ls_MSG)
//		Return False
//	End If
	
//	If Date(ls_DataAtualiza) = Date(ls_DataUltimaExecucao) Then 
//   		ls_MSG = "J$$HEX1$$e100$$ENDHEX$$ executado neste Dia:DH_ULTIMA_ATUALIZACAO_CD_DISTRIBUIDORA"
//	    gf_ge202_envia_email_automatico(154, ls_MSG, ls_Anexo)
//		Sqlca.of_MsgDbError("Erro Atualiza$$HEX2$$e700e300$$ENDHEX$$o : J$$HEX1$$e100$$ENDHEX$$ Executado Processo neste Dia. Contate Inform$$HEX1$$e100$$ENDHEX$$tica")
//		Close(w_Aguarde)
//		Return False
//	End If 

	gvo_Aplicacao.of_Grava_Log("In$$HEX1$$ed00$$ENDHEX$$cio da Carga dos Produtos para a Distribuidora Estoque Central")
					
	lo_Produto 		= Create uo_Produto
	lo_NF 			= Create uo_ge118_nf_transferencia_perini
	ids_UF 			= Create dc_uo_ds_Base	
	
	If Not ids_UF.Of_ChangeDataObject( "ds_ge118_uf" ) Then
		ls_MSG = "Erro ao carregar a ds ds_ge118_uf. Fun$$HEX2$$e700e300$$ENDHEX$$o uo_ge118_nf_transferencia_perini.of_grava_itens_preco_transferencia"		
		This.of_MessageBox(ls_MSG)		
		Return False
	End If

	ll_Linhas = ids_UF.Retrieve()
	
	If ll_Linhas <= 0 Then
		If ll_Linhas = 0 Then
			ls_MSG = "Nenhuma UF est$$HEX1$$e100$$ENDHEX$$ cadastrada para considerar a ordem de compra do CD. Fun$$HEX2$$e700e300$$ENDHEX$$o uo_ge118_nf_transferencia_perini.of_grava_itens_preco_transferencia"
		Else
			ls_MSG = "Erro ao carregar as UFs que consideram a odrem de compra do CD. Fun$$HEX2$$e700e300$$ENDHEX$$o uo_ge118_nf_transferencia_perini.of_grava_itens_preco_transferencia"
		End If
		
		This.of_MessageBox(ls_MSG)		
		Return False
	End If

	// Dw dos Produtos Com Saldo
	lds_Produtos = Create dc_uo_ds_base
	
	If Not lds_Produtos.Of_ChangeDataObject( "ds_ge118_produto_com_saldo" ) Then
		ls_MSG = "Erro ao carregar a ds ds_ge118_produto_com_saldo. Fun$$HEX2$$e700e300$$ENDHEX$$o uo_ge118_nf_transferencia_perini.of_grava_itens_preco_transferencia"			
		This.of_MessageBox(ls_MSG)			
		Return False
	End If
	
	ll_Produtos = lds_Produtos.Retrieve(ldh_saldo)
	
	If ll_Produtos <= 0 Then
		If ll_Produtos = 0 Then
			ls_MSG = "Nenhum produto com saldo no CD. Fun$$HEX2$$e700e300$$ENDHEX$$o uo_ge118_nf_transferencia_perini.of_grava_itens_preco_transferencia"
		Else
			ls_MSG = "Erro ao carregar os produtos com saldo no CD. Fun$$HEX2$$e700e300$$ENDHEX$$o uo_ge118_nf_transferencia_perini.of_grava_itens_preco_transferencia"
		End If
		
		This.of_MessageBox(ls_MSG)		
		Return False
	End If
	
	Open(w_Aguarde)
	w_Aguarde.uo_Progress.of_SetMax(lds_Produtos.RowCount())
	
	/// Estados  ( Conforme Parametro Tabela Unidade_Federacao)
	For ll_RowUF=1 to ll_Linhas
		ls_UF = ids_UF.Object.cd_uf[ll_RowUF]
		
		//Desenvolvimento
//		If ls_UF <> "MS" Then Continue
		
		lo_NF.of_grava_uf_origem_destino('SC', ls_UF)
		
		w_Aguarde.Title = 'Carga dos Produtos da Distribuidora EC para a UF ' + ls_UF
		
    		// Localiza Filial   
	    If Not of_Localiza_Filial(ls_UF, ref ll_LojaFilial) Then Return False
		 
		 ll_Commit = 0
	  
		For ll_RowProdutos = 1 To ll_Produtos
			w_Aguarde.uo_Progress.of_SetProgress(ll_RowProdutos)									
			ll_CdProduto = lds_Produtos.Object.cd_produto[ll_RowProdutos]
			
			ll_Commit++
				  
			lo_Produto.of_localiza_codigo_interno(ll_CdProduto)
					 
			ls_Produto = String (ll_CdProduto)
			ll_SaldoCD =  lds_Produtos.Object.saldocd[ll_RowProdutos]
					 
			If ll_SaldoCD=0 Then Continue							
	
//				select count(*) 
//				Into :ll_AchouDistribuidora
//				From distribuidora_produto
//				where cd_unidade_federacao = :ls_UF
//				and cd_produto = :ll_CdProduto
//				and id_situacao = 'A'
//				and cd_distribuidora<>( select cd_distribuidora_estoque from parametro ) 
//				Using SqlCa;
//						
//				If Sqlca.Sqlcode = -1 Then
//					ls_MSG = "Erro ao Consultar Distribuidora Produto para UF/Produto-AchouDistribuidora"
//					gf_ge202_envia_email_automatico(154, ls_MSG, ls_Anexo)
//					Sqlca.of_MsgDbError("Erro Consultar : Distribuidora_Produto Distribuidora para UF/Produto-AchouDistribuidora.")
//					Close(w_Aguarde)
//					Return False
//				End If
//					
//				If ll_AchouDistribuidora = 0 Then Continue						
											
			// SE FOR BA ANTECIPA$$HEX2$$c700c300$$ENDHEX$$O DE IMPOSTO ST...	
			// N$$HEX1$$e300$$ENDHEX$$o utilizaremos a antecipa$$HEX2$$e700e300$$ENDHEX$$o porque esta n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ informada no arquivo de pre$$HEX1$$e700$$ENDHEX$$o que recebemos das distribuidoras.	
			// Consulta PC ICM Produto na UF
			select  (i.pc_icms + i.pc_fcp)
				Into :lvl_Pc_Icms
			from produto_uf u
				inner join tipo_icms i	on i.cd_tipo_icms = u.cd_tipo_icms
					and i.cd_unidade_federacao = u.cd_unidade_federacao
			where u.cd_unidade_federacao =:ls_UF
				and u.cd_produto = :ll_CdProduto
			Using SqlCA;
		
			If Sqlca.Sqlcode = -1 Then
				ls_MSG = "Erro ao Consultar Distribuidora Produto para UF/Produto PC-ICMS"
				This.of_MessageBox(ls_MSG)
				Return False
			End If	

			// Inicializa a Filial   
			If Not lo_NF.of_inicializa(ll_LojaFilial) Then Return False
			
			lvl_Vl_Custo = lo_Produto.of_Custo_Medio()
			
			ll_DiasPagamento = of_verifica_dias_pgto_distribuidor ( ll_CdProduto )
			
			If ll_DiasPagamento = -1 Then Return False
			
			// A fun$$HEX2$$e700e300$$ENDHEX$$o ir$$HEX1$$e100$$ENDHEX$$ retornar o custo que foi utilizado na transfer$$HEX1$$ea00$$ENDHEX$$ncia conforme a UF
			If Not lo_NF.of_tributacao(lo_Produto, ref lvl_Vl_Custo, 'SC', ls_UF, 1) Then Return False
			If lo_NF.ib_custo_invalido then
				of_custo_invalido (ll_CdProduto, lvl_Vl_Custo)
				Continue
			End if
			
			lvl_Vl_ICMS_St  = round(lo_Nf.vl_icms_st_prd, 2) 
			lvl_Vl_Transf = lvl_Vl_Custo + lvl_Vl_ICMS_St						
											 
			If not of_verifica_perini_distribuidora(ll_CdProduto, ls_UF, ll_Achou) Then Return False
			
			If ll_Achou = 0 Then
				Insert into distribuidora_produto (	cd_unidade_federacao,
															cd_produto, 
															cd_distribuidora,
															cd_produto_distribuidora,
															vl_preco_atual,
															pc_desconto_atual,
															pc_repasse_icms,
															pc_icms,
															vl_icms_st,
															nr_dias_pagamento,
															pc_desconto_conexao ,
															qt_embalagem_padrao_distrib,
															qt_estoque_disponivel,
															id_situacao,
															dh_inclusao,
															dh_alteracao_situacao,
															nr_matric_alteracao_situacao,
															dh_atualizacao_distribuidora,
															vl_preco_anterior,
															pc_desconto_anterior,
															dh_alteracao_preco_desconto,
															nr_matric_alteracao_preco)																			  

				Values (	:ls_UF,  
							:ll_CdProduto, 
							'053404705',
							:ls_Produto,
							:lvl_Vl_Custo,  
							0,
							0, 
							:lvl_Pc_Icms,
							:lvl_Vl_ICMS_St, 
							:ll_DiasPagamento,
							0,
							1,
							:ll_SaldoCD,
							 'A',
							:ldh_data,
							:ldh_data,
							'14330',
							:ldh_data,
							0,
							0,
							:ldh_data,
							'14330') 
				Using SqlCa;				

				If Sqlca.Sqlcode = -1 Then
					ls_MSG = "Erro ao Inserir Distribuidora Produto para UF/Produto"
					This.of_MessageBox(ls_MSG)
					Return False
				End If
				
			Else
				
				update distribuidora_produto
				set	  vl_preco_atual=:lvl_Vl_Custo , 
					  vl_icms_st =:lvl_Vl_ICMS_St,
					  pc_icms =:lvl_Pc_Icms,
					  qt_estoque_disponivel = :ll_SaldoCD,
					  nr_matric_alteracao_situacao='14330',
					  nr_matric_alteracao_preco='14330',
					  id_situacao = 'A',
					  id_situacao_anterior = id_situacao,
					  dh_atualizacao_distribuidora=:ldh_data,
					  dh_alteracao_situacao =:ldh_data,
					  dh_alteracao_preco_desconto=:ldh_data,
					  nr_dias_pagamento = :ll_DiasPagamento							  
				where  cd_unidade_federacao =:ls_UF
					and cd_produto =:ll_CdProduto
					and cd_distribuidora=(select cd_distribuidora_estoque from parametro)
				Using SqlCa;				

				If Sqlca.Sqlcode = -1 Then
					ls_MSG = "Erro Atualiza$$HEX2$$e700e300$$ENDHEX$$o :  Distribuidora_Produto: Atualiza Registros-PrimeiroUpdate"
					This.of_MessageBox(ls_MSG)
					Return False
				End If
			End If
			
			If ll_Commit >= 100 Then
				SqlCa.of_commit()	;
				ll_Commit = 0
			End If
			
		Next
	
		SqlCa.of_commit()	
	
		//Altera pra inativo se o produto n$$HEX1$$e300$$ENDHEX$$o foi atualizado/n$$HEX1$$e300$$ENDHEX$$o tem saldo no CD
		Update	distribuidora_produto
		set			id_situacao = 'I', 
					id_situacao_anterior = id_situacao,
					qt_estoque_disponivel = 0,
					dh_atualizacao_distribuidora=:ldh_data,					
					dh_alteracao_situacao =:ldh_data,
					dh_alteracao_preco_desconto=:ldh_data,
					de_alteracao_situacao ='CD-DISTRIBUIDORA SEM SALDO'
		where   cd_distribuidora  in (select cd_distribuidora_estoque from parametro)
			and cd_unidade_federacao = :ls_UF
			and id_situacao  = 'A'		
			and dh_atualizacao_distribuidora<:ldh_data
		Using SqlCa;	
												
		If Sqlca.Sqlcode = -1 Then
			ls_MSG = "Erro Atualiza$$HEX2$$e700e300$$ENDHEX$$o : Distribuidora_Produto : Inativar Registros-SegundoUpdate"
			This.of_MessageBox(ls_MSG)
			Return False
		End If	
				
		SqlCa.of_commit()	
	Next
	
	//Update id_situacao = I para a UF que teve o id_considera_cd_ordem_compra alterado pra N
	Update	distribuidora_produto
	set			id_situacao = 'I', 
				id_situacao_anterior = id_situacao,
				qt_estoque_disponivel = 0,
				dh_atualizacao_distribuidora=:ldh_data,
				dh_inclusao=:ldh_data,
				dh_alteracao_situacao =:ldh_data,
				dh_alteracao_preco_desconto=:ldh_data,
				de_alteracao_situacao ='CD-DISTRIBUIDORA DESATIVADO UF'
	where	cd_distribuidora  = (select cd_distribuidora_estoque from parametro)
		and cd_unidade_federacao in (	select cd_unidade_federacao 
													from unidade_federacao
													where coalesce(id_considera_cd_ordem_compra, 'N') = 'N')
		and id_situacao  = 'A'		
		and dh_atualizacao_distribuidora <:ldh_data
	Using SqlCA;	
										
	If Sqlca.Sqlcode = -1 Then
		ls_MSG = "Erro Atualiza$$HEX2$$e700e300$$ENDHEX$$o : Distribuidora_Produto : Inativar Registros-TerceiroUpdate"
		This.of_MessageBox(ls_MSG)
		Return False
	End If	
	
	// Atualiza Ultima Data de Execu$$HEX2$$e700e300$$ENDHEX$$o
	Update parametro_geral
		set vl_parametro=:ls_DataAtualiza
	where cd_parametro = 'DH_ULTIMA_ATUALIZACAO_CD_DISTRIBUIDORA'
	Using SqlCa;
	
	If Sqlca.Sqlcode = -1 Then
		ls_MSG = "Erro Atualizacao parametro_geral :DH_ULTIMA_ATUALIZACAO_CD_DISTRIBUIDORA"
		This.of_MessageBox(ls_MSG)
		Return False
	End If
	
	SqlCa.of_commit()
	
	If UpperBound (istr_custo_invalido[]) > 0 then
		of_envia_msg_custo_invalido ()
	End if
	
	lb_Sucesso = True
	
Finally
	If Not lb_Sucesso Then
		SqlCa.of_Rollback();
	End If
	
	If IsValid(lo_Produto) Then Destroy(lo_Produto)
	If IsValid(lo_NF) Then Destroy(lo_NF) 
	If IsValid(lds_Produtos) Then Destroy(lds_Produtos)
	
	If IsValid(w_Aguarde) Then Close(w_Aguarde)
End Try 	

gvo_Aplicacao.of_Grava_Log("Termino Carga dos Produtos a Distribuidora Estoque Central")

Return True
end function

public function long of_verifica_dias_pgto_distribuidor (long al_produto);Long ll_Qtd_Dias
Date ldh_data

ldh_data = RelativeDate (    Date(gf_GetServerDate()) ,  - 180   )

select  top 1 qt_dias
Into :ll_Qtd_Dias
from
(   select  m.cd_produto, 
            m.cd_fornecedor,             
            m.cd_filial_movimento,             
            m.dh_movimento,
            m.nr_nf, 
            m.qt_movimento,
            (select sum(coalesce(i.qt_devolvida, 0) + coalesce(i.qt_avariada, 0)) 
               from item_nf_compra_lote i
               where i.cd_filial = n.cd_filial
                 and i.cd_fornecedor = n.cd_fornecedor
                 and i.nr_nf        = n.nr_nf
                 and i.de_especie   = n.de_especie
                 and i.de_serie     = n.de_serie
                 and i.cd_produto   = m.cd_produto) as qt_devolvida ,
             (select min(qt_dias_vencimento) from condicao_pagamento_parcela  c
                where cd_condicao = n.cd_condicao_pagamento) as qt_dias            
    from movimento_estoque m (index idx_produto_data_fil)
    inner join nf_compra n
        on n.cd_filial = m.cd_filial_movimento
        and n.cd_fornecedor = m.cd_fornecedor
        and n.nr_nf     = m.nr_nf
        and n.de_especie = m.de_especie
        and n.de_serie = m.de_serie
    where m.cd_filial_movimento = 534
      and m.dh_movimento >=:ldh_data
      and m.cd_produto = :al_produto
      and m.cd_tipo_movimento = 3
) as tudo
where tudo.qt_movimento - tudo.qt_devolvida > 0
order by tudo.dh_movimento desc
Using SqlCA;

If Sqlca.Sqlcode = -1 Then
	This.of_MessageBox("Erro ao consultar dias de pagamento Fornecedor para o produto " + String(al_produto) + ". " + SqlCa.SqlErrText)
	Return -1
ElseIf Sqlca.Sqlcode = 100 Then
	ll_Qtd_Dias = 1 
Else
	If IsNull(ll_Qtd_Dias) Then ll_Qtd_Dias=1		
End If 

Return ll_Qtd_Dias
end function

public subroutine of_messagebox (string as_mensagem);String ls_Anexo

If gvb_Auto Then
	gf_ge202_envia_email_automatico(154, as_Mensagem, ls_Anexo)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", as_Mensagem, StopSign!)
End If

Return
end subroutine

public function boolean of_verifica_perini_distribuidora (long al_produto, string as_uf, ref long al_achou);al_Achou = 0

select count(*) 
	Into :al_Achou
from distribuidora_produto
where cd_distribuidora = (select cd_distribuidora_estoque from parametro)
	and cd_produto = :al_produto
	and cd_unidade_federacao = :as_uf 
Using SqlCa;

If Sqlca.Sqlcode = -1 Then
	This.of_MessageBox("Erro ao consultar a existencia pedido distribuidora Perini.")
	Return False
End If

Return True
end function

public subroutine _documentacao ();/*
	Processo para colocar os produtos com Saldo do CD e utilizar este produtos
	para que o CD seja considerado como uma distribuidora.
	
	Tabela Principal:  Distribuidora_Produto
						Distribuidora_Produto_hist




*/  
end subroutine

public subroutine of_envia_msg_custo_invalido ();Long		ll_linha, ll_tot_lin
String	ls_lista
String	ls_Msg
s_email	lst_Email

ll_tot_lin = UpperBound (istr_custo_invalido [])

ls_lista = '<head> ' + &
					'<style> ' + &
						'table { ' + &
							'border:0px none; ' + &
							'border-collapse:collapse; ' + &
							'padding:5px; ' + &
						'} ' + &
						'table th { ' + &
							'border:0px none; ' + &
							'padding:5px; ' + &
							'background: #f0f0f0; ' + &
							'color: #313030; ' + &
						'} ' + &
						'table td { ' + &
							'border:0px none; ' + &
							'text-align:left; ' + &
							'padding:5px; ' + &
							'background: #ffffff; ' + &
							'color: #313030; ' + &
						'} ' + &
					'</style> ' + &
				'</head> ' + &
				'<body> ' + &
					'<table> ' + &
						'<thead> ' + &
							'<tr> ' + &
								'<th>Produto</th> ' + &
								'<th>Custo obtido</th> ' + &
							'</tr> ' + &
						'</thead> ' + &
				'<tbody> '

For ll_linha = 1 to ll_tot_lin
	ls_lista += '<tr>' + &
						'<td>&nbsp;' + String (istr_custo_invalido[ll_linha].produto) +  '</td>' + &
						'<td>&nbsp;' + Iif (IsNull (istr_custo_invalido[ll_linha].custo), 'NULO', String (istr_custo_invalido[ll_linha].custo)) + '</td>' + &
					'</tr>'
Next

ls_Msg =	"<b>URGENTE!!!!!<br><br>" +&
			"<b>Atualiza$$HEX2$$e700e300$$ENDHEX$$o Produtos CD Distribuidora" +"<br></b>"  +&
			"<b>Sistema Retaguarda Operacional" + "<br></b>"  +&
			"<b>Caro(a) Usu$$HEX1$$e100$$ENDHEX$$rio(a)," + '<br><br>' + &
			'A rela$$HEX2$$e700e300$$ENDHEX$$o abaixo lista os produtos detectados com custo inv$$HEX1$$e100$$ENDHEX$$lido e que, por isso, n$$HEX1$$e300$$ENDHEX$$o foram processados.' + "<br></b>" + &
			ls_lista

lst_Email.ps_mensagem	= ls_Msg
lst_Email.pb_assinatura = True

Gf_ge202_envia_email_padrao (306, lst_Email)

Return
end subroutine

public subroutine of_custo_invalido (long al_produto, decimal adc_custo);Long	ll_linha, ll_tot_lin

ll_tot_lin = UpperBound (istr_custo_invalido [])

For ll_Linha = 1 to ll_tot_lin
	If al_produto = istr_custo_invalido[ll_linha].produto then
		 Return
	End if
Next

ll_linha = ll_tot_lin + 1
istr_custo_invalido[ll_linha].produto = al_produto
istr_custo_invalido[ll_linha].custo   = adc_custo

Return
end subroutine

on uo_ge118_nf_transferencia_perini.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge118_nf_transferencia_perini.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;Destroy(ivo_Atributo)
Destroy(ivo_Tratamento_Fiscal)
Destroy(ivo_Parametro)
Destroy(ids_Itens)
Destroy(ivo_Filial)
Destroy(ivo_Produto)


end event

event constructor;ivo_tratamento_fiscal = Create uo_Tratamento_Fiscal
ivo_atributo 			 	= Create uo_Atributo_Fiscal_Item_Nf
ivo_Parametro  		= Create uo_Parametro_Geral
ivo_Filial					= Create uo_Filial
ivo_Produto				= Create uo_Produto 						

ids_Itens					= Create dc_uo_ds_base
ids_Itens.of_ChangeDataObject("ds_ge118_itens")

//DataStore para carregar melhor compra
//ids_Melhor_Compra = Create dc_uo_ds_Base
//ids_Melhor_Compra.of_ChangeDataObject('ds_ge118_melhor_compra')

//Configura$$HEX2$$e700e300$$ENDHEX$$o para transfer$$HEX1$$ea00$$ENDHEX$$ncias
ivo_tratamento_fiscal.Of_Grava_Contribuinte(True)
ivo_tratamento_fiscal.Of_Grava_Operacao(ivo_tratamento_fiscal.TRANSFERENCIA)
end event

