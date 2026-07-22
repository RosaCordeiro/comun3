HA$PBExportHeader$uo_ge144_pedido_drogaexpress.sru
forward
global type uo_ge144_pedido_drogaexpress from nonvisualobject
end type
end forward

global type uo_ge144_pedido_drogaexpress from nonvisualobject
end type
global uo_ge144_pedido_drogaexpress uo_ge144_pedido_drogaexpress

type variables
String Retorno

string nr_pedido_drogaexpress, &
		cd_cliente_drogaexpress, &
		cd_tipo_venda, &
		cd_cliente, &
		cd_conveniado, &
		nr_cpf_cgc,&
		nr_matric_liberacao_bloqueio, &
		nr_matric_liberacao_restricao, &
		nr_matric_alteracao_preco, &          
		nm_fantasia, &
		nr_cpf_cheque,&
		nm_cliente_cheque,&
		nm_cliente_cartao,&
		nm_cartao_credito,&
		nm_cliente_drogaexpress,&
		nm_cliente, &
		nm_dependente_cliente,&
		nm_dependente_conveniado, &        
		nm_conveniado, &
		nr_cep,&
		id_obedece_restricao, &
		id_situacao, &
		nr_matricula_operador, &
		nr_matricula_vendedor,&
		de_especie_doc_fiscal, &
		cd_forma_pagamento, &
		nr_cartao_credito, &
		cd_seguranca_cartao,&
		nm_vendedor, &
		nm_operador,&
		de_condicao_convenio,&
		de_condicao_crediario,&
		de_observacao,&
		de_endereco_entrega,&
		de_complemento_entrega	, &
		de_referencia_entrega		, &
		de_bairro_entrega				, &
		nr_cep_entrega				, &
		nr_endereco_entrega			, &
		nr_telefone_entrega			, &
		id_considera_desc_produto	, &
		id_desconto_clube,&
		id_venda_clube, &
		cd_conveniado_cliente, &
		nr_telefone_principal, &
		nr_telefone_adicional, &
		nr_matric_liberacao_frete, &
		id_plataforma_ecommerce

string nr_cartao_unimed
string nr_cartao_edm

long	cd_convenio, &        
		cd_condicao_convenio, &
		cd_condicao_crediario, &
		cd_dependente_conveniado, &
		cd_convenio_cliente,&
		nr_pedido_ecommerce, &
		cd_filial, &
		nr_bairro

decimal {2} vl_total_produtos, &
                  vl_total_pedido, &
                  vl_total_geral, &
                  vl_desconto_produtos, &
                  vl_taxa_entrega, &
                  vl_cobrar, &
                  vl_pago, &
                  vl_entrada, &
                  vl_desconto_unimed,&
                  vl_desconto_unimed_prazo,&
                   pc_desconto_convenio, &
                   vl_desconto_convenio,&
                   pc_avista,&
                   pc_comissao_vendedor,&
                   pc_desconto_taxa_entrega,&
                   pc_desconto_minimo_convenio,&
                   pc_desconto_unimed,&
                   pc_desconto_unimed_drogaria,&            
                   vl_bc_unimed,&      
                   vl_bc_unimed_prazo,&
                   vl_total_tabela,&
                   vl_total_bruto

datetime dh_emissao, &
              dh_movimentacao_caixa,&
              dh_validade_cartao, &
              dh_entrega_marcada

boolean Localizado

dc_uo_ds_base ivds_Formas_Pgto

STRING nr_cartao_clube
STRING cd_cliente_dependente
STRING id_tipo_cliente_clube
end variables

forward prototypes
public function string of_localiza_tipo_venda (string ps_pedido)
public subroutine of_imprime_cc (string ps_pedido)
public subroutine of_imprime_cr (string ps_pedido)
public subroutine of_imprime_cv (string ps_pedido)
public subroutine of_imprime_av (string ps_pedido)
public subroutine of_imprime (string ps_pedido)
public subroutine of_inicializa ()
public function string of_situacao_atual ()
public subroutine of_localiza_pedido (string ps_pedido)
public function string of_proximo_pedido (long pl_filial)
public function decimal of_taxa_entrega ()
public subroutine of_imprime_ecommerce (string ps_pedido)
public function boolean of_pedido_paga_frete (decimal pdc_valor)
public function boolean of_inclui_produto_frete ()
public function boolean of_carrega_pagamentos (string as_pedido)
public function boolean of_valor_minimo_entrega ()
public function boolean of_busca_vending_machine (long pl_nr_vm, ref string ps_descricao)
public subroutine of_imprime_ecommerce (string ps_pedido, boolean pb_exibir_msg)
end prototypes

public function string of_localiza_tipo_venda (string ps_pedido);String lvs_Tipo_Venda

Select cd_tipo_venda
Into  :lvs_Tipo_Venda
from pedido_drogaexpress
where nr_pedido_drogaexpress = :ps_pedido
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return lvs_Tipo_Venda
	Case 100
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Pedido Nr. '" + ps_pedido + "' n$$HEX1$$e300$$ENDHEX$$o localizado." + SqlCa.SqlErrText, Information!,Ok!)
	Case -1
		SqlCa.of_MsgdbError()
End Choose
end function

public subroutine of_imprime_cc (string ps_pedido);// Imprime Conta-Corrente

Long lvl_Linhas

DataStore lvds_1

lvds_1 = Create DataStore
lvds_1.DataObject = "ds_ge144_impressao_cc"
lvds_1.SetTransObject(SqlCa)

lvl_Linhas = lvds_1.Retrieve(ps_pedido)

Choose Case gvo_parametro.id_rede_filial
	Case 'FA';lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\Marca_Farmagora_AF.bmp" 
	Case 'DC';lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\logo_dc_rel.png"
	Case 'PP';lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\Logo_PP_Horizontal_RGB.jpg"	
	Case 'MP';lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\logo_dc_rel.png"
End Choose

If lvl_Linhas > 0 Then
	lvds_1.Print()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Dados para impress$$HEX1$$e300$$ENDHEX$$o do pedido '" + ps_pedido + "' n$$HEX1$$e300$$ENDHEX$$o localizados.",StopSign!)
End If

Destroy(lvds_1)
end subroutine

public subroutine of_imprime_cr (string ps_pedido);// Imprime Credi$$HEX1$$e100$$ENDHEX$$rio

Long lvl_Linhas

DataStore lvds_1

lvds_1 = Create DataStore
lvds_1.DataObject = "ds_ge144_impressao_cr"
lvds_1.SetTransObject(SqlCa)

lvl_Linhas = lvds_1.Retrieve(ps_pedido)

Choose Case gvo_parametro.id_rede_filial
	Case 'FA';lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\Marca_Farmagora_AF.bmp" 
	Case 'DC';lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\logo_dc_rel.png"
	Case 'PP';lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\Logo_PP_Horizontal_RGB.jpg"	
	Case 'MP';lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\logo_dc_rel.png"
End Choose

If lvl_Linhas > 0 Then
	lvds_1.Print()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Dados para impress$$HEX1$$e300$$ENDHEX$$o do pedido '" + ps_pedido + "' n$$HEX1$$e300$$ENDHEX$$o localizados.",StopSign!)
End If

Destroy(lvds_1)
end subroutine

public subroutine of_imprime_cv (string ps_pedido);// Imprime Conv$$HEX1$$ea00$$ENDHEX$$nio

Long lvl_Linhas

DataStore lvds_1

lvds_1 = Create DataStore
lvds_1.DataObject = "ds_ge144_impressao_cv"
lvds_1.SetTransObject(SqlCa)

lvl_Linhas = lvds_1.Retrieve(ps_pedido)

Choose Case gvo_parametro.id_rede_filial
	Case 'FA';lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\Marca_Farmagora_AF.bmp" 
	Case 'DC';lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\logo_dc_rel.png"
	Case 'PP';lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\Logo_PP_Horizontal_RGB.jpg"	
	Case 'MP';lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\logo_dc_rel.png"
End Choose

If lvl_Linhas > 0 Then
	lvds_1.Print()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Dados para impress$$HEX1$$e300$$ENDHEX$$o do pedido '" + ps_pedido + "' n$$HEX1$$e300$$ENDHEX$$o localizados.",StopSign!)
End If

Destroy(lvds_1)
end subroutine

public subroutine of_imprime_av (string ps_pedido);// Imprime $$HEX1$$e000$$ENDHEX$$ Vista

Long lvl_Linhas

DataStore lvds_1

lvds_1 = Create DataStore
lvds_1.DataObject = "ds_ge144_impressao_av"
lvds_1.SetTransObject(SqlCa)

lvl_Linhas = lvds_1.Retrieve(ps_pedido)

Choose Case gvo_parametro.id_rede_filial
	Case 'FA';lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\Marca_Farmagora_AF.bmp" 
	Case 'DC';lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\logo_dc_rel.png"
	Case 'PP';lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\Logo_PP_Horizontal_RGB.jpg"	
	Case 'MP';lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\logo_dc_rel.png"
End Choose

If lvl_Linhas > 0 Then
	lvds_1.Print()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Dados para impress$$HEX1$$e300$$ENDHEX$$o do pedido '" + ps_pedido + "' n$$HEX1$$e300$$ENDHEX$$o localizados.",StopSign!)
End If

Destroy(lvds_1)
end subroutine

public subroutine of_imprime (string ps_pedido);String lvs_Tipo_Venda

lvs_Tipo_Venda = of_localiza_tipo_venda(ps_pedido)

Choose Case lvs_Tipo_Venda
	Case 'CC' ;  of_imprime_cc(ps_pedido)				
	Case 'CR' ;  of_imprime_cr(ps_pedido)				
	Case 'CV' ;  of_imprime_cv(ps_pedido)				
	Case 'AV' ;  of_imprime_av(ps_pedido)
End Choose	 
end subroutine

public subroutine of_inicializa ();id_venda_clube = "N"

SetNull(id_desconto_clube)
SetNull(nr_pedido_drogaexpress)
SetNull(cd_cliente_drogaexpress)
SetNull(cd_tipo_venda)
SetNull(cd_cliente)
SetNull(cd_convenio)
SetNull(cd_conveniado)
SetNull(cd_condicao_convenio)
SetNull(cd_condicao_crediario)
SetNull(nm_dependente_conveniado)
SetNull(nm_dependente_cliente)
SetNull(nr_matric_liberacao_bloqueio)
SetNull(nr_matric_liberacao_restricao)
SetNull(nr_matric_alteracao_preco)
SetNull(cd_dependente_conveniado)
SetNull(nm_fantasia)
SetNull(nm_cliente_drogaexpress)
SetNull(nm_cliente)
SetNull(nm_conveniado)
SetNull(id_situacao)
SetNull(id_obedece_restricao)
SetNull(nr_matricula_vendedor)
SetNull(nr_matricula_operador)
SetNull(de_especie_doc_fiscal)
SetNull(cd_forma_pagamento)
SetNull(nr_cartao_credito)
SetNull(nr_cartao_unimed)
SetNull(nr_cartao_edm)
SetNull(cd_seguranca_cartao)
SetNull(de_observacao)
SetNull(dh_emissao)
SetNull(dh_validade_cartao)
SetNull(dh_entrega_marcada)
SetNull(nr_cpf_cheque)
SetNull(nm_cliente_cheque)
SetNull(nm_vendedor)
SetNull(nm_operador)
SetNull(de_condicao_convenio)
SetNull(de_condicao_crediario)
SetNull(nr_cpf_cgc)
SetNull(de_endereco_entrega)
SetNull(de_referencia_entrega)
SetNull(de_bairro_entrega)
SetNull(nr_bairro)
SetNull(nr_telefone_entrega)
SetNull(nr_cep)
SetNull(id_considera_desc_produto)
SetNull(cd_convenio_cliente)
SetNull(cd_conveniado_cliente)
SetNull(nr_telefone_principal)
SetNull(nr_telefone_adicional)
SetNull(nm_cartao_credito)
SetNull(nm_cliente_cartao)
SetNull(nr_matric_liberacao_frete)

SetNull(nr_cartao_clube)
SetNull(cd_cliente_dependente)
SetNull(id_tipo_cliente_clube)

vl_total_produtos           = 000.00
vl_total_pedido             = 000.00
vl_taxa_entrega             = 000.00
vl_total_geral              = 000.00
vl_desconto_produtos        = 000.00 
vl_cobrar                   = 000.00
vl_pago                     = 000.00
vl_entrada  			       = 000.00
vl_total_tabela             = 000.00
vl_total_bruto              = 000.00
vl_desconto_convenio        = 000.00
vl_desconto_unimed          = 000.00
vl_desconto_unimed_prazo    = 000.00
vl_bc_unimed                = 000.00
vl_bc_unimed_prazo          = 000.00
pc_desconto_convenio        = 000.00
pc_avista                   = 000.00
pc_comissao_vendedor        = 000.00
pc_desconto_taxa_entrega    = 000.00
pc_desconto_unimed          = 000.00
pc_desconto_unimed_drogaria = 000.00

pc_desconto_minimo_convenio = 000.00

dh_movimentacao_caixa = gvo_Parametro.of_dh_movimentacao()

Localizado = FALSE

ivds_Formas_Pgto.Reset()
end subroutine

public function string of_situacao_atual ();STRING lvs_Situacao
//
CHOOSE CASE id_situacao
	CASE "A"
		lvs_Situacao = "ABERTO"
	CASE "E"
		lvs_Situacao = "ENTREGUE"
	CASE "F"
		lvs_Situacao = "FATURADO"
	CASE "R"
		lvs_Situacao = "ROTEIRO"
	CASE "X"
		lvs_Situacao = "CANCELADO"
	CASE ELSE
		lvs_Situacao = "INDEFINIDA"
END CHOOSE
//
RETURN lvs_Situacao

		
		
		
end function

public subroutine of_localiza_pedido (string ps_pedido);	LONG     lvl_filial,&
         lvl_cd_convenio,& 
	     lvl_cd_dependente_conveniado,&
         lvl_cd_condicao_convenio,&   
         lvl_cd_condicao_crediario,&
		 lvl_Pedido_Ecommerce, &
		 lvl_Nr_Bairro
	  
DATETIME lvdh_emissao,&
		 lvdh_validade_cartao,&
         lvdh_entrega_marcada   
		 		 
DECIMAL {2} lvdc_vl_total_pedido,&   
			lvdc_vl_total_produtos,&   
			lvdc_vl_taxa_entrega,&   
			lvdc_vl_cobrar,&   
			lvdc_vl_pago,&
			lvdc_pc_comissao_vendedor,&
			lvdc_desconto_convenio,&
			lvdc_pc_avista,&
			lvdc_pc_desconto_taxa_entrega,&
			lvdc_vl_total_tabela,&
			lvdc_pc_desconto_unimed,&
			lvdc_pc_desconto_unimed_drogaria,&
	        lvdc_vl_base_calculo_unimed
				 			
STRING   lvs_cliente_drogaexpress,&   
         lvs_id_situacao,&   
         lvs_cd_tipo_venda,&   
         lvs_forma_pagamento,&   
         lvs_nr_matricula_vendedor,&   
         lvs_nr_matricula_operador,&   
         lvs_de_especie_doc_fiscal,&      
         lvs_nr_cartao_credito,&               
			lvs_cd_seguranca_cartao,&
         lvs_cd_conveniado,&   
			lvs_id_considera_desc_produto,&
         lvs_cd_cliente,&          
         lvs_de_observacao,&   
         lvs_nr_matric_alteracao_preco,&   
         lvs_nr_matric_liberacao_bloqueio,&
         lvs_nr_matric_liberacao_restricao,&
 			lvs_nm_fantasia,&
			lvs_nm_cliente_drogaexpress,&
			lvs_nm_cliente,&
			lvs_nm_dependente_conveniado,&
			lvs_nm_dependente_cliente,&
			lvs_nm_conveniado,&
			lvs_id_obedece_restricao,&
			lvs_nm_vendedor, &
			lvs_nm_operador,&
			lvs_de_condicao_convenio,&
			lvs_de_condicao_crediario,&
			lvs_nr_cpf_cgc,&
			lvs_cep,&
			lvs_endereco_entrega,&
			lvs_referencia_entrega,&
			lvs_bairro_entrega,&			
			lvs_telefone_entrega,&
			lvs_cartao_unimed,&
			lvs_nr_cartao_clube,&
		   lvs_id_venda_clube,&
		   lvs_cd_cliente_dependente, &
			lvs_nm_cartao_credito, &
		   lvs_nm_cliente_cartao_credito
					
This.Of_Inicializa()

Select	pde.cd_filial,
		pde.dh_emissao,   
		pde.cd_cliente_drogaexpress,   
		pde.cd_cliente,
		cd.nm_cliente,
		(CASE WHEN cli.nm_social is not null and TRIM(cli.nm_social)<> '' THEN cli.nm_social ELSE cli.nm_cliente END),
		pde.vl_total_pedido,   
		pde.vl_total_produtos,   
		pde.vl_taxa_entrega,   
		pde.vl_cobrar,   
		pde.vl_pago,   
		pde.vl_total_tabela, 
		pde.id_situacao,   
		pde.cd_tipo_venda,   
		pde.cd_forma_pagamento,
		pde.nr_matricula_vendedor,   
		pde.nr_matricula_operador,   
		pde.de_especie_doc_fiscal,
		pde.nm_cartao_credito,
		pde.nm_cliente_cartao,
		pde.nr_cartao_credito,   
		pde.cd_seguranca_cartao,
		pde.dh_validade_cartao,   
		pde.cd_convenio,   
		pde.cd_conveniado,   
		rcc.id_considera_desc_produto,
		pde.cd_dependente_conveniado,   
		pde.cd_condicao_convenio,   
		pde.cd_condicao_crediario,   
		pde.dh_entrega_marcada,   
		pde.de_observacao,   
		pde.nr_matric_alteracao_preco,   
		pde.nr_matric_liberacao_bloqueio,
		pde.nr_matric_liberacao_restricao,
		pde.pc_desconto,
		convenio.nm_fantasia,
		conveniado.nm_conveniado,
		dco.nm_dependente,
		conveniado.id_obedece_restricao, 
		vendedor.nm_usuario,
		operador.nm_usuario,
		cvc.de_condicao_convenio,
		cdep.nm_dependente,
		pde.nr_matricula_operador,
		pde.nr_matricula_vendedor,
		cd.nr_cgc_cpf,
		cvcr.de_condicao_crediario,
		ven.pc_comissao,		 
		pde.de_endereco_entrega,
		pde.de_complemento_endereco,
		pde.de_referencia_entrega,
		pde.de_bairro_entrega,
		cd.Nr_Bairro,
		pde.nr_cep_entrega,
		pde.nr_endereco_entrega,
		pde.nr_telefone_entrega,
		cd.nr_cep,
		rcc.pc_avista,
		pde.pc_desconto_unimed,
		pde.pc_desconto_unimed_drogaria,
		pde.vl_base_calculo_unimed,
		pde.nr_cartao_unimed,
		pde.nr_cartao_clube,
		pde.id_venda_clube,
		pde.cd_cliente_dependente,
		pde.nr_pedido_ecommerce,
		cd.nr_telefone_principal,
		cd.nr_telefone_adicional,
		pde.nm_cliente_cheque,
		pde.nr_cpf_cheque,
		pde.nr_matricula_liberacao_frete,
		pde.id_plataforma_ecommerce
Into	:This.cd_filial,
		:lvdh_emissao,
		:lvs_cliente_drogaexpress,
		:lvs_cd_cliente,
		:lvs_nm_cliente_drogaexpress,		 
		:lvs_nm_cliente,
		:lvdc_vl_total_pedido,
		:lvdc_vl_total_produtos,
		:lvdc_vl_taxa_entrega,
		:lvdc_vl_cobrar,
		:lvdc_vl_pago,
		:lvdc_vl_total_tabela,
		:lvs_id_situacao,
		:lvs_cd_tipo_venda,
		:lvs_forma_pagamento,
		:lvs_nr_matricula_vendedor,
		:lvs_nr_matricula_operador,
		:lvs_de_especie_doc_fiscal, 
		:This.nm_cartao_credito,
		:This.nm_cliente_cartao,
		:lvs_nr_cartao_credito,
		:lvs_cd_seguranca_cartao,
		:lvdh_validade_cartao,   
		:lvl_cd_convenio,   
		:lvs_cd_conveniado,   
		:lvs_id_considera_desc_produto,
		:lvl_cd_dependente_conveniado,
		:lvl_cd_condicao_convenio,   
		:lvl_cd_condicao_crediario,   
		:lvdh_entrega_marcada,   
		:lvs_de_observacao,
		:lvs_nr_matric_alteracao_preco,   
		:lvs_nr_matric_liberacao_bloqueio,   
		:lvs_nr_matric_liberacao_restricao,
		:lvdc_desconto_convenio,
		:lvs_nm_fantasia,
		:lvs_nm_conveniado,		 
		:lvs_nm_dependente_conveniado,
		:lvs_id_obedece_restricao,
		:lvs_nm_vendedor,
		:lvs_nm_operador,
		:lvs_de_condicao_convenio,
		:lvs_nm_dependente_cliente,
		:lvs_nr_matricula_operador,
		:lvs_nr_matricula_vendedor,
		:lvs_nr_cpf_cgc,
		:lvs_de_condicao_crediario,
		:lvdc_pc_comissao_vendedor,
		:lvs_endereco_entrega,
		:This.de_complemento_entrega,
		:lvs_referencia_entrega,
		:lvs_bairro_entrega,
		:lvl_Nr_Bairro,
		:This.nr_cep_entrega,
		:This.nr_endereco_entrega,
		:lvs_telefone_entrega,
		:lvs_cep,
		:lvdc_pc_avista,
		:lvdc_pc_desconto_unimed,
		:lvdc_pc_desconto_unimed_drogaria,
		:lvdc_vl_base_calculo_unimed,
		:lvs_cartao_unimed,
		:lvs_nr_cartao_clube,
		:lvs_id_venda_clube,
		:lvs_cd_cliente_dependente,
		:lvl_Pedido_Ecommerce,
		:nr_telefone_principal,
		:nr_telefone_adicional,
		:This.nm_cliente_cheque,
		:This.nr_cpf_cheque,
		:This.nr_matric_liberacao_frete,
		:This.id_plataforma_ecommerce
From pedido_drogaexpress pde,
     cliente_drogaexpress cd,
	 cliente cli,
     convenio,
	 conveniado,
	 dependente_conveniado dco,
	 usuario vendedor,
	 usuario operador,
	 condicao_venda_convenio cvc,
	 condicao_venda_crediario cvcr,
	 vendedor ven,
	 relacao_condicao_convenio rcc,
	 cliente_dependente cdep
Where nr_pedido_drogaexpress     = :ps_Pedido
  and cd.cd_cliente_drogaexpress = pde.cd_cliente_drogaexpress
  and convenio.cd_convenio       =* pde.cd_convenio
  and conveniado.cd_convenio     =* pde.cd_convenio
  and conveniado.cd_conveniado   =* pde.cd_conveniado
  and dco.cd_convenio            =* pde.cd_convenio
  and dco.cd_conveniado          =* pde.cd_conveniado
  and dco.cd_dependente          =* pde.cd_dependente_conveniado
  and vendedor.nr_matricula      =* pde.nr_matricula_vendedor
  and operador.nr_matricula      =* pde.nr_matricula_operador
  and cvc.cd_condicao_convenio   =* pde.cd_condicao_convenio
  and cvcr.cd_condicao_crediario =* pde.cd_condicao_crediario
  and rcc.cd_convenio            =* pde.cd_convenio
  and rcc.cd_condicao_convenio   =* pde.cd_condicao_convenio
  and cli.cd_cliente             =* pde.cd_cliente
  and ven.nr_matricula_vendedor  =* pde.nr_matricula_vendedor
  and cdep.cd_dependente_cliente =* pde.cd_cliente_dependente
Using SqlCa;

Choose Case Sqlca.Sqlcode
	Case -1	
	 	Sqlca.of_MsgDbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do pedido.")
		Localizado = False		
		Return
	Case 100
		Localizado = False
		Return
	Case 0
		Localizado = True
End Choose		

This.nr_pedido_drogaexpress        = ps_Pedido
This.cd_cliente_drogaexpress       = lvs_cliente_drogaexpress
This.cd_tipo_venda                 = lvs_cd_tipo_venda
This.cd_cliente                    = lvs_cd_cliente
This.cd_conveniado                 = lvs_cd_conveniado
This.nr_matric_liberacao_bloqueio  = lvs_nr_matric_liberacao_bloqueio
This.nr_matric_liberacao_restricao = lvs_nr_matric_liberacao_restricao
This.nr_matric_alteracao_preco     = lvs_nr_matric_alteracao_preco
This.cd_convenio                   = lvl_cd_convenio
This.cd_condicao_convenio          = lvl_cd_condicao_convenio
This.id_considera_desc_produto     = lvs_id_considera_desc_produto
This.de_condicao_convenio          = lvs_de_condicao_convenio
This.cd_condicao_crediario         = lvl_cd_condicao_crediario
This.de_condicao_crediario         = lvs_de_condicao_crediario
This.cd_dependente_conveniado      = lvl_cd_dependente_conveniado
This.nm_fantasia                   = lvs_nm_fantasia
This.nm_cliente                    = lvs_nm_cliente
This.nm_cliente_drogaexpress       = lvs_nm_cliente_drogaexpress
This.nm_dependente_cliente         = lvs_nm_dependente_cliente
This.nm_dependente_conveniado      = lvs_nm_dependente_conveniado
This.nm_conveniado                 = lvs_nm_conveniado
This.id_situacao                   = lvs_id_situacao
This.id_obedece_restricao          = lvs_id_obedece_restricao
This.nr_matricula_vendedor         = lvs_nr_matricula_vendedor
This.nr_matricula_operador         = lvs_nr_matricula_operador
This.nm_vendedor                   = lvs_nm_vendedor
This.nm_operador                   = lvs_nm_operador
This.de_especie_doc_fiscal         = lvs_de_especie_doc_fiscal
This.cd_forma_pagamento            = lvs_forma_pagamento
This.nr_cartao_credito             = lvs_nr_cartao_credito
This.cd_seguranca_cartao           = lvs_cd_seguranca_cartao
This.de_observacao                 = lvs_de_observacao
This.dh_emissao                    = lvdh_emissao
This.dh_validade_cartao            = lvdh_validade_cartao
This.dh_entrega_marcada            = lvdh_entrega_marcada
This.vl_total_pedido               = lvdc_vl_total_pedido
This.vl_total_produtos             = lvdc_vl_total_produtos
This.vl_taxa_entrega               = lvdc_vl_taxa_entrega
This.vl_cobrar                     = lvdc_vl_cobrar
This.vl_pago                       = lvdc_vl_pago
This.vl_total_tabela               = lvdc_vl_total_tabela
This.pc_comissao_vendedor          = lvdc_pc_comissao_vendedor
This.pc_desconto_convenio          = lvdc_desconto_convenio
This.pc_avista 					   = lvdc_pc_avista
This.nr_cep 					   = lvs_cep
This.de_endereco_entrega		   = lvs_endereco_entrega
This.de_referencia_entrega 		   = lvs_referencia_entrega
This.de_bairro_entrega			   = lvs_bairro_entrega
This.nr_bairro							=lvl_Nr_Bairro
This.nr_telefone_entrega           = lvs_telefone_entrega
This.nr_cartao_unimed              = lvs_cartao_unimed
This.pc_desconto_unimed            = lvdc_pc_desconto_unimed
This.pc_desconto_unimed_drogaria   = lvdc_pc_desconto_unimed_drogaria
This.Cd_Cliente_Dependente         = lvs_Cd_Cliente_Dependente
This.nr_pedido_ecommerce		   = lvl_Pedido_Ecommerce

If Not IsNull(This.cd_convenio) Then
	
	//Verifica o desconto recebido pelo convenio sobre a taxa de entrega 
	
	Select pc_desconto_taxa_entrega into :lvdc_pc_desconto_taxa_entrega
	From convenio
	where cd_convenio = :This.cd_convenio
	Using Sqlca;
	
	Choose Case Sqlca.Sqlcode
		Case -1	
		 	Sqlca.of_MsgDbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do convenio.")
			Localizado = False
			Return
		Case 100
			Localizado = False
			Return
		Case 0
			
			If IsNull(lvdc_pc_desconto_taxa_entrega) Then lvdc_pc_desconto_taxa_entrega = 000.00
			
			This.pc_desconto_taxa_entrega = lvdc_pc_desconto_taxa_entrega
			
	End Choose
		
End If	

Localizado = True
end subroutine

public function string of_proximo_pedido (long pl_filial);String lvs_Pedido

Long lvl_Sequencial

Select max(nr_pedido_drogaexpress) Into :lvs_Pedido
From pedido_drogaexpress
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(lvs_Pedido) Then
			lvl_Sequencial	= Long(RightA(lvs_Pedido, 7)) + 1
		Else
			lvl_Sequencial = 1
		End If
	Case 100
		lvl_Sequencial = 1
	Case -1
		SqlCa.of_MsgdbError()
		lvl_Sequencial = 0
End Choose

Return String(pl_Filial, "0000") + String(lvl_Sequencial, "0000000")
end function

public function decimal of_taxa_entrega ();Decimal lvdc_Taxa

uo_ge099_Bairro io_Bairro
io_Bairro = Create uo_GE099_Bairro
io_Bairro.of_Localiza_Codigo( This.Nr_Bairro )

lvdc_Taxa = io_Bairro.Vl_Frete

Destroy io_Bairro

If Not IsNull( lvdc_Taxa ) And lvdc_Taxa <> 0.00 Then Return lvdc_Taxa

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

If Not IsNull(cd_convenio) Then
	If Not lvo_Parametro.of_Localiza_Parametro("VL_TAXA_ENTREGA_CONVENIO", ref lvdc_Taxa) Then
		lvdc_Taxa = 0
	End If
Else
	If Not lvo_Parametro.of_Localiza_Parametro("VL_TAXA_DISQUE_ENTREGA", ref lvdc_Taxa) Then
		lvdc_Taxa = 0
	End If
End If

Destroy(lvo_Parametro)

Return lvdc_Taxa
end function

public subroutine of_imprime_ecommerce (string ps_pedido);this.of_imprime_ecommerce( ps_pedido, True)
end subroutine

public function boolean of_pedido_paga_frete (decimal pdc_valor);Decimal lvdc_Taxa

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

If Not IsNull(cd_convenio) Then
	Select vl_minimo_isencao_frete
	  Into :lvdc_Taxa
	  From convenio
	 Where cd_convenio = :This.cd_Convenio
	 Using SQLCa;
End If

If SQLCa.SQLCode =- 1 Then
	SQLCa.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o valor m$$HEX1$$ed00$$ENDHEX$$nimo de isen$$HEX2$$e700e300$$ENDHEX$$o de frete do conv$$HEX1$$ea00$$ENDHEX$$nio')	
End If

If lvdc_Taxa = 0 Or IsNull(lvdc_Taxa) Then
	If Not lvo_Parametro.of_Localiza_Parametro("VL_PEDIDO_MINIMO_ISENTO_FRETE", ref lvdc_Taxa) Then
		lvdc_Taxa = 0
	End If
End If

Destroy(lvo_Parametro)

String lvs_Taxa, lvs_Valor

//lvs_Taxa = String(lvdc_Taxa, "0,000,000.00")
//lvs_Valor = String(pdc_Valor, "0,000,000.00")

If lvdc_Taxa > pdc_Valor Then
	Return True
Else
	Return False
End If
end function

public function boolean of_inclui_produto_frete ();Decimal lvdc_Preco_Tabela

Long ll_Achou
Long ll_Produto = 712055

If This.Vl_Taxa_Entrega <= 0 Then Return True

lvdc_Preco_Tabela = This.of_Taxa_Entrega()

Select cd_produto
  Into :ll_Achou
  From produto_pedido_drogaexpress
 Where nr_pedido_drogaexpress = :This.Nr_Pedido_DrogaExpress
   And cd_produto = :ll_Produto
 Using SqlCa;
 
Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto FRETE no pedido.")
		Return False
		
	Case 100		
		Insert Into produto_pedido_drogaexpress (nr_pedido_drogaexpress,
															  cd_produto,
															  qt_pedida,
															  vl_preco_tabela,
															  vl_preco_tabela_liquido,
															  pc_desconto_tabela,
															  vl_preco_praticado,
															  id_alteracao_preco,
															  id_restricao_convenio)
		Values (:This.Nr_Pedido_DrogaExpress,
				  :ll_Produto,
				  1,
				  :lvdc_Preco_Tabela,
				  :lvdc_Preco_Tabela,
				  0.00,
				  :lvdc_Preco_Tabela,
				  'N',
				  'N')
		Using SqlCa;	

End Choose

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do produto FRETE no pedido.")
	Return False
End If

Return True
end function

public function boolean of_carrega_pagamentos (string as_pedido);If This.ivds_Formas_Pgto.Retrieve(as_Pedido) = -1 Then
	Return False
End If

Return True
end function

public function boolean of_valor_minimo_entrega ();Decimal ldc_Valor

Select Coalesce( vl_minimo_entrega, 0.00 )
  Into :ldc_Valor
  From convenio
 Where cd_convenio = :This.Cd_Convenio
 Using SqlCa;
 
Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError('LOCALIZA$$HEX2$$c700c300$$ENDHEX$$O DO VALOR M$$HEX1$$cd00$$ENDHEX$$NIMO PARA ENTREGA')
		Return False
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar o valor m$$HEX1$$ed00$$ENDHEX$$nimo para entrega do pedido do conv$$HEX1$$ea00$$ENDHEX$$nio.")
		Return False
		
	Case 0
		If ldc_Valor > This.vl_Total_Pedido Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pedido m$$HEX1$$ed00$$ENDHEX$$nimo para este conv$$HEX1$$ea00$$ENDHEX$$nio deve ser de " + String(ldc_Valor, "#,##0.00"))
			Return False
		End If
		
End Choose

Return True
end function

public function boolean of_busca_vending_machine (long pl_nr_vm, ref string ps_descricao);string ls_sql, ls_descricao

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()
lvo_Conexao.of_Relatorio(True)
lvo_Conexao.of_ConverteVirgula(True)
	
ls_sql = "select de_local_vmpay from vending_machine where nr_vending_machine = " + string(pl_nr_vm)
	
If Not lvo_Conexao.of_retrieve( ls_sql, ref ls_descricao ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na altera$$HEX2$$e700e300$$ENDHEX$$o do pedido eCommerce '" + String(nr_pedido_drogaexpress) + "'.", StopSign!)
Else
	If lvo_Conexao.of_Erro_Conexao() Or lvo_Conexao.of_erro_execucao( ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com a Matriz. Tente novamente mais tarde.", StopSign!)
	End If
End If	

ps_descricao = ls_descricao

Destroy(lvo_Conexao)

return true
			
end function

public subroutine of_imprime_ecommerce (string ps_pedido, boolean pb_exibir_msg);// Imprime eCommerce

Long lvl_Linhas
Long ll_Filial_EC
Long ll_nr_vm

String lvs_Telefone,&
	   lvs_Contato
		
String ls_Rede
String ls_de_vm

DataStore lvds_1

lvds_1 = Create DataStore
lvds_1.DataObject = "ds_ge144_impressao_ecommerce"
lvds_1.SetTransObject(SqlCa)

lvl_Linhas = lvds_1.Retrieve(ps_pedido)

If lvl_Linhas > 0 Then
	ll_Filial_EC = lvds_1.Object.cd_filial_ecommerce[ 1 ]
	ls_Rede	   = lvds_1.Object.id_rede_ecommerce[ 1 ]
	
	Choose Case ls_Rede
		Case 'FA';lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\Marca_Farmagora_AF.bmp" 
		Case 'DC';lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\logo_dc_rel.png"
		Case 'PP';lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\Logo_PP_Horizontal_RGB.jpg"	
		Case 'MP';lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\logo_dc_rel.png"
	End Choose
	
//	Choose Case ll_Filial_EC
//		Case 809;lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\Marca_Farmagora_AF.bmp" 
//		Case 986;lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\logo_dc_rel.png"
//		Case 355;lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\logo_dc_rel.png"
//		//Case 355;lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\logo_manipulacao_rel.png"
//		Case 325;lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\Logo_PP_Horizontal_RGB.jpg"	
//		Case 318;lvds_1.Object.logo_dw.Filename = "S:\Sistemas_PB12\Comuns\Figuras\Logo_PP_Horizontal_RGB.jpg"
//	End Choose
				
	lvs_Telefone = lvds_1.Object.nr_telefone_entrega	[1]
	lvs_Contato  = lvds_1.Object.nr_telefone_contato	[1]
	
    If Not Isnull(lvs_Contato) Then
		lvs_Telefone = lvs_Telefone + " \ " + lvs_Contato
	End If
	
	lvds_1.Object.st_Telefone.text = lvs_Telefone
	
	ll_nr_vm = lvds_1.Object.nr_vending_machine[1]
	if ll_nr_vm > 0 and not isnull(ll_nr_vm) Then
		this.of_busca_vending_machine( ll_nr_vm, ref ls_de_vm)
		lvds_1.Object.de_local_vmpay[1] = ls_de_vm
	end if
	
	lvds_1.Print()
Else
	if pb_exibir_msg = True then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Dados para impress$$HEX1$$e300$$ENDHEX$$o do pedido '" + ps_pedido + "' n$$HEX1$$e300$$ENDHEX$$o localizados.",StopSign!)
	ENd if
End If

Destroy(lvds_1)
end subroutine

on uo_ge144_pedido_drogaexpress.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge144_pedido_drogaexpress.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivds_Formas_Pgto = Create dc_uo_ds_base

If Not ivds_Formas_Pgto.of_ChangeDataObject("ds_ge144_forma_pagamento") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao trocar para a datawindow de pagamentos no objeto uo_pedido_drogaexpress_pagamento.")
End If

This.of_Inicializa()
end event

