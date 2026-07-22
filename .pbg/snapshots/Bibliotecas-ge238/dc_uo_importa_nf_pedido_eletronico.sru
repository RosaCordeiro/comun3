HA$PBExportHeader$dc_uo_importa_nf_pedido_eletronico.sru
forward
global type dc_uo_importa_nf_pedido_eletronico from nonvisualobject
end type
end forward

global type dc_uo_importa_nf_pedido_eletronico from nonvisualobject
end type
global dc_uo_importa_nf_pedido_eletronico dc_uo_importa_nf_pedido_eletronico

type variables
Long il_Filial, il_Nf, il_Pedido

String is_Fornecedor, is_Especie, is_Serie, is_Nm_Fantasia

boolean ivb_Inclui_Pedido_Projeto_Conexao = False

Boolean ib_Imp_Manual_Sem_Pedido_Conexao = False

boolean ib_sem_xvan = False

Boolean ib_Icms_Diferenca = False

Boolean ib_Distrib_Conv = False

Boolean ib_inicio_operacao_sap = False

Boolean ib_Reimportacao = False

Boolean ib_valida_teste_integrado = False

Boolean ib_Pedido_Informado

String is_Divergencias_ST[]

String	is_Recebimento_SAP = ''

String is_ID_Conexao

String is_id_fornecedor_uso_consumo = 'N'

Private:
uo_tratamento_fiscal ivo_Fiscal
end variables

forward prototypes
public function boolean of_atualiza_crt (string as_crt, string as_fornecedor, ref string as_mensagem_log)
public function boolean of_nota_importada_anteriormente (long al_nf, string as_especie, readonly string as_serie, string as_fornecedor, long al_filial, ref string as_mensagem_log)
public function boolean of_verifica_nota_excluida (long al_filial, string as_fornecedor, long al_nota, string as_especie, ref string as_mensagem_log)
public function boolean of_atualiza_pedido_distribuidora (long al_filial, long al_pedido, ref string as_mensagem_log)
public function boolean of_inclui_pedido_pharmalink (long al_filial, string as_distribuidora, date adh_emissao, long al_pedido_filial, ref long al_pedido, string as_ean, ref string as_mensagem)
public function boolean of_verifica_nota_excluida (string as_chave_acesso, ref string as_mensagem_log)
public function boolean of_valida_valores_nota (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, ref string as_mensagem)
public function boolean of_verifica_tributacao (string as_tributacao, ref string as_icms, ref string as_icms_st, ref string as_mensagem)
private subroutine of_envia_email_divergencias_st ()
public function boolean of_codigo_distribuidora (string as_chave_acesso, ref string as_distribuidora, ref string as_mensagem)
public function boolean of_busca_xml_ftp (string as_chave_acesso, date adt_emissao, long al_filial, string as_diretorio_xml, boolean ab_download_sefaz, ref string as_mensagem_log)
public function boolean of_atualiza_finalidade_nfe (string as_finnfe, string as_chave, ref string as_mensagem)
public subroutine of_envia_email (string ps_assunto, string ps_texto_email)
public function boolean of_atualiza_data_reimportacao (long al_filial, string as_fornecedor, long al_nf, string as_chave, ref string as_erro)
public function boolean of_verifica_projeto_conexao (string as_de_projeto, string as_distribuidora, string as_infadicional, ref string as_id_conexao, ref string as_mensagem_erro)
public function boolean of_verifica_pedido_conexao_aberto (string as_distribuidora, long al_filial, string as_ean, ref string as_pedido_conexao, ref string as_mensagem_log)
public function boolean of_verifica_pedido_conexao_aberto (string as_distribuidora, long al_filial, string as_projeto, t_infnfe at_infnfe, ref long al_pedido_distribuidora, ref string as_mensagem_log)
public function boolean of_grava_log (integer ai_arquivo, string as_mensagem)
public function boolean of_atualiza_qtde_itens_cabecalho (ref string as_mensagem_log)
public function boolean of_insere_itens_nf_quimidrol (t_infnfe a_infnfe, long al_filial, string as_fornecedor, long al_nota, string as_serie, ref string as_mensagem_erro)
public function boolean of_verifica_preco_maior_que_da_clamed (decimal adc_preco_unitario, decimal adc_desconto, decimal adc_vl_st, decimal adc_repasse, string as_uf, long al_produto, ref string as_mensagem_log)
public function boolean of_download_xml_sefaz (string as_chave_nota, long al_filial, ref string as_mensagem_log, string as_diretorio_importacao, string as_diretorio_importacao_xml)
public function boolean of_verifica_cancelamento (string as_chave_acesso, ref string as_mensagem_log)
public function boolean of_embalagem_padrao_distribuidora (long al_filial, long al_pedido, long al_produto, ref long al_caixa_padrao, ref string as_mensagem_log, string as_uf)
public function boolean of_valida_parcelas_titulo (ref t_infnfe at_infnfe, string as_fornecedor, ref string as_mensagem_log)
public function boolean of_atualiza_reimportada (long al_filial, string as_fornecedor, long al_nf, string as_chave, ref string as_erro)
public function boolean of_insere_lotes (long al_natureza_operacao, long al_produto, decimal adc_fator_conversao, t_prod at_prod, ref string as_mensagem_log, long al_embalagem_padrao_dist, integer al_qt_faturada)
public function boolean of_localiza_codigo_fornecedor (string as_cnpj, ref string as_codigo_fornecedor, ref string as_erro)
public function boolean of_verifica_pedido_normal_aberto (string as_distribuidora, long al_filial, string as_projeto, t_infnfe at_infnfe, ref long al_pedido_distribuidora, ref string as_mensagem_log)
public subroutine of_envia_email_sem_tag_xvan (ref t_infnfe at_infnfe, string as_fornecedor, string as_projeto)
public function boolean of_verifica_ped_conexao_aberto (string as_distribuidora, long al_filial, long al_pedido_conexao, ref boolean ab_pedido_aberto, ref string as_mensagem_log)
public function boolean of_verifica_conexao_produto (string as_ean, ref string as_projeto, boolean ab_importa_sem_pedido, ref string as_mensagem_log)
public function boolean of_verifica_filial_ped_conveniencia (long al_filial, ref string as_liberada, ref string as_mensagem_log)
public function boolean of_verifica_registro_recebimento (string as_chave_acesso, ref boolean ab_registrada, ref string as_mensagem_log)
public function boolean of_insere_itens (t_infnfe a_infnfe, ref string as_mensagem_log, long al_pedido, string as_permite_nota_sem_pedido)
public function boolean of_emb_padrao_distrib_prod (long al_filial, long al_pedido, long al_produto, ref long al_caixa_padrao, ref string as_mensagem_log, string as_uf)
public function boolean of_preco_produto_pedido (long al_filial, long al_pedido, long al_produto, ref decimal adc_preco_bruto, ref decimal adc_preco_liquido, ref long al_qt_emb_padrao_ped, ref string as_mensagem_log)
public function boolean of_insere_titulos (t_infnfe at_infnfe, long al_pedido, string as_permite_nota_sem_pedido, ref string as_mensagem_log)
public function boolean of_nosso_codigo_produto (string as_produto, string as_distribuidora, ref long al_produto, ref decimal adc_fator_conversao, ref decimal adc_repasse_icms, ref decimal adc_icms, ref decimal adc_reducao_icms, long al_filial, ref integer ai_tributacao_produto, ref decimal pc_icms_st, ref string as_subcategoria, ref string as_lei_generico, string as_ean, string as_ean_trib, ref string as_lista_pis_cofins, ref string as_cd_produto_sap, ref string as_mensagem_log)
public function boolean of_localiza_codigo_barras_like_novo (string as_codigo_barras, ref long al_produto)
public function boolean of_importa_nf (string as_chave_acesso, date adt_emissao, long al_pedido, long al_filial, string as_diretorio_xml, boolean ab_importa_sem_pedido, boolean ab_download_sefaz, boolean ab_reimportacao, ref string as_mensagem_log, ref string as_nat_operacao, integer ai_log, long al_pedido_sap, string as_permite_nota_sem_pedido, string ls_sistema_java, string as_fornecedor, ref string as_resolvido, ref datetime adt_resolvido)
public function boolean of_verifica_pedido_central (long al_pedido, long al_filial, string as_fornecedor, ref string as_mensagem_log)
public function boolean of_insere_log_importacao (string as_chave_acesso, long al_filial, string as_fornecedor, ref string as_mensagem_log, date adt_emissao, long al_pedido, long al_nr_nf)
public function boolean of_insere_nf_quimidrol (string as_chave_acesso, string as_diretorio_leitura, ref string as_mensagem_log)
public function boolean of_insere_titulos_quimidrol (t_infnfe at_infnfe, long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, ref string as_mensagem_log)
public function boolean of_localiza_forma_pagamento (string as_xml, ref string as_pagamento, ref string as_mensagem_log)
public function boolean of_verifica_pedido (long al_filial, ref long al_pedido, string as_chave_acesso, string as_ean, string as_dados_adicionais, ref string as_mensagem, ref long al_pedido_incluido, date adt_emissao_nota, string as_id_conexao, string as_infadicional, string as_fornecedor, boolean ab_importa_sem_pedido, boolean ab_reimportacao, t_infnfe at_infnfe, string ls_sistema_java, ref boolean ab_pedido_central, ref long al_pedido_informado)
public function boolean of_obtem_pedido_pela_chave (string as_chave_acesso, ref long al_pedido, ref string as_erro)
public function boolean of_registra_importacao_nfe_sem_pedido (string as_chave_acesso, ref string as_erro)
public function boolean of_valida_pedido_xml (string as_pedido_compra, string as_pedido_produto, string as_distribuidora, boolean ab_importa_sem_pedido, ref long al_pedido, ref string as_projeto, ref string as_mensagem_log, long al_filial, string as_ean, string as_chave_acesso)
public function boolean of_insere_cabecalho (t_infnfe a_infnfe, long al_pedido, string as_chave_nota, long al_filial, string ls_permite_nota_sem_pedido, string as_fornecedor, boolean ab_pedido_central, ref string as_mensagem_log)
public function boolean of_verifica_produto_hardcode (string as_cd_produto_xml, ref string as_ean, ref string as_ean_trib)
public function boolean of_nosso_codigo_produto (string as_xprod, string as_ean, string as_eantrib, string as_distribuidora, ref long al_produto, ref string as_mensagem_log, ref boolean ab_erro)
public function boolean of_verifica_produto_cod_distribuidora (string as_cd_produto_xml, string as_distribuidora, ref string as_ean, ref string as_ean_trib, ref long as_cd_produto, ref string as_mensagem_log)
end prototypes

public function boolean of_atualiza_crt (string as_crt, string as_fornecedor, ref string as_mensagem_log);String ls_Crt

If as_Crt = "1" Then
	ls_Crt = "1"
Else
	ls_Crt = "2"
End If

Update fornecedor 
set id_regime_tributario = :ls_Crt
where cd_fornecedor = :as_Fornecedor
	and id_regime_tributario <> :ls_Crt
Using SqlCa;
		
Choose Case  SqlCa.SqlCode 
	Case -1		
		as_mensagem_log = SqlCa.SQLErrText
		Return False
End Choose

Return True 
end function

public function boolean of_nota_importada_anteriormente (long al_nf, string as_especie, readonly string as_serie, string as_fornecedor, long al_filial, ref string as_mensagem_log);Long ll_Qtde

as_Mensagem_Log = ""	

select 	count(*)  
	into 	:ll_Qtde
from(	
	select nr_nf 
	from nf_compra
	where cd_filial = :al_Filial
		and cd_fornecedor = :as_Fornecedor
		and nr_nf = :al_Nf
		and de_especie = :as_Especie
		and de_serie = :as_Serie
	union all
	select nr_nf 
	from nf_compra_pendente
	where cd_filial = :al_Filial
		and cd_fornecedor = :as_Fornecedor
		and nr_nf = :al_Nf
		and de_especie = :as_Especie
		and de_serie = :as_Serie
) as tudo
Using SqlCa;

If  SqlCa.SqlCode = -1 Then
	as_Mensagem_Log = SqlCa.SQLErrText
	Return False
End If

If ll_Qtde > 0 Then
	Return False	
Else
	Return True
End If
end function

public function boolean of_verifica_nota_excluida (long al_filial, string as_fornecedor, long al_nota, string as_especie, ref string as_mensagem_log);DateTime lvdt_Movimentacao, lvdt_Exclusao

String lvs_Mensagem

Select dh_movimentacao_caixa, dh_exclusao
Into :lvdt_Movimentacao, :lvdt_Exclusao
From log_exclusao_nf_compra
Where cd_filial			=:al_Filial
  	and cd_fornecedor	=:as_Fornecedor
  	and nr_nf				=:al_Nota
 	and de_especie		=:as_Especie
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 0
		as_Mensagem_Log = " - A NF '" + String (al_Nota) + "' entrou no sistema dia '" + string(lvdt_Movimentacao, "dd/mm/yyyy") + "' e foi exclu$$HEX1$$ed00$$ENDHEX$$da dia " + STring(lvdt_Exclusao, "dd/mm/yyyy hh:mm:ss")
		Return False
	Case 100
		Return True
	Case -1 
		as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o da Nota Fiscal Exclu$$HEX1$$ed00$$ENDHEX$$da. " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_atualiza_pedido_distribuidora (long al_filial, long al_pedido, ref string as_mensagem_log);
Update pedido_distribuidora 
Set 	id_situacao = 'F',
		dh_nota_fiscal = GetDate()
where nr_pedido_distribuidora = :al_Pedido
	and cd_filial = :al_Filial 
Using SqlCa;

Choose Case  SqlCa.SqlCode 
	Case -1		
		as_mensagem_log = "Erro ao atualizar pedido_distribuidora: "+SqlCa.SQLErrText
		Return False
End Choose


insert into log_exportacao_filial (cd_filial_atualizacao,
										     nm_tabela,
											  dh_atualizacao,
											  de_chave,
											  id_atualizacao)
select i.cd_filial,
       'PEDIDO_DISTRIBUIDORA',
		 getdate(),
		 convert(char(4), i.cd_filial) + '@#!' + convert(char(8), i.nr_pedido_distribuidora),
       'A'
from pedido_distribuidora i
where i.cd_filial               = :al_filial
  and i.nr_pedido_distribuidora = :al_Pedido
Using SqlCa;

If  SqlCa.SqlCode = -1 Then
	as_mensagem_log = "Erro ao incluir o log exporta$$HEX2$$e700e300$$ENDHEX$$o: "+SqlCa.SQLErrText
	Return False
End If

Return True
end function

public function boolean of_inclui_pedido_pharmalink (long al_filial, string as_distribuidora, date adh_emissao, long al_pedido_filial, ref long al_pedido, string as_ean, ref string as_mensagem);Long lvl_Proximo_Pedido, lvl_Pedido_Filial , ll_Existe, ll_Pedido_Filial

String ls_Projeto,&
		ls_Erro

select id_projeto_conexao
Into :ls_Projeto
From produto_central
where cd_produto in (select cd_produto from codigo_barras_produto where de_codigo_barras =:as_ean)
Using SqlCa;

Choose Case Sqlca.Sqlcode
	Case 0
		If Isnull(ls_Projeto) Then		
			// Reposicao
			ls_Projeto = '3'		
		End If
	case 100
		
		// Verifica se $$HEX1$$e900$$ENDHEX$$ produto de reposi$$HEX2$$e700e300$$ENDHEX$$o
		Select pp.cd_produto
		Into :ll_Existe
		From pbm p
		Inner join pbm_produto pp on pp.cd_pbm = p.cd_pbm
		Where p.id_tipo_reposicao = 'P'
		  and pp.cd_produto in (select cd_produto from codigo_barras_produto where de_codigo_barras =:as_ean)
		Using SqlCa;
		
		If SqlCa.Sqlcode = 0 Then
			// Reposicao
			ls_Projeto = '3'
		Else
			as_ean = gf_Tira_Zero_Esquerda(as_ean)
			
			select id_projeto_conexao
			Into :ls_Projeto
			From produto_central
			where cd_produto in (select cd_produto from codigo_barras_produto where de_codigo_barras like '%' + :as_ean + '%')
			Using SqlCa;
			
			Choose Case Sqlca.Sqlcode
					Case 0
						If Isnull(ls_Projeto) Then
							// Reposicao
							ls_Projeto = '3'	
						End if
						
					Case 100
						as_mensagem = 'O Projeto conex$$HEX1$$e300$$ENDHEX$$o do produto: ' + as_ean + ', n$$HEX1$$e300$$ENDHEX$$o encontrado.'
						Return false
				
					Case -1
						Return False
			End choose	
		End If
		
	Case -1
		Return False
End Choose

Select Max(nr_pedido_filial)
Into :ll_Pedido_Filial
From pedido_filial
Where cd_filial = :al_Filial
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_mensagem = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Pedido Filial. " + SqlCa.SqlErrText
	Return False
End If	
	 
//Select max(nr_pedido_distribuidora)
//Into :lvl_Proximo_Pedido
//From pedido_distribuidora
//Where cd_filial = :al_Filial
//Using SqlCa;
//
//If SqlCa.SqlCode = -1 Then
////	as_Mensagem = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Pr$$HEX1$$f300$$ENDHEX$$ximo Pedido. " + SqlCa.SqlErrText
//	Return False
//End If
//
//If IsNull(lvl_Proximo_Pedido) Then lvl_Proximo_Pedido = 0
//
//lvl_Proximo_Pedido = lvl_Proximo_Pedido + 1

If Not gf_ge040_proximo_pedido_distribuidora(Ref lvl_Proximo_Pedido, Ref ls_Erro) Then
	Return False
End If

Insert Into pedido_distribuidora (	cd_filial,   
											nr_pedido_distribuidora,   
											dh_emissao,   
											 vl_total_pedido,   
											 id_situacao,   
											 nr_pedido_filial,   
											 cd_distribuidora,   
											 nr_pedido_conexao,
											 id_projeto_conexao)  
Select	:al_Filial,   
		:lvl_Proximo_Pedido,   
		:adh_emissao,   
		0,   
		"C",   
		:ll_Pedido_Filial,   
		:as_Distribuidora,   
		:al_pedido_filial,
		:ls_projeto
From parametro
Using SqlCa;

If SqlCa.SqlCode = -1 Then
//	as_Mensagem = "Inclus$$HEX1$$e300$$ENDHEX$$o do pedido distribuidora. (" + as_Distribuidora + " - " + String(al_Filial) + ") " +  SqlCa.SqlErrText
	//Sqlca.of_RollBack();
	Return False
Else
	//SqlCa.of_Commit();
End If

al_Pedido = lvl_Proximo_Pedido

Return True
end function

public function boolean of_verifica_nota_excluida (string as_chave_acesso, ref string as_mensagem_log);DateTime lvdt_Movimentacao, lvdt_Exclusao

String lvs_Mensagem, ls_Nota


ls_Nota = Mid(as_chave_acesso, 26, 9)

Select dh_movimentacao_caixa, dh_exclusao
Into :lvdt_Movimentacao, :lvdt_Exclusao
From log_exclusao_nf_compra
Where de_chave_acesso =:as_chave_acesso
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 0
		as_Mensagem_Log = " - A Nota Fiscal '" + ls_Nota + "' entrou no sistema no dia '" + string(lvdt_Movimentacao, "dd/mm/yyyy") + "' e foi exclu$$HEX1$$ed00$$ENDHEX$$da no dia " + STring(lvdt_Exclusao, "dd/mm/yyyy hh:mm:ss")
		Return False
	Case 100
		Return True
	Case -1 
		as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o da Nota Fiscal Exclu$$HEX1$$ed00$$ENDHEX$$da. " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_valida_valores_nota (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, ref string as_mensagem);Decimal ldc_Total_Produtos, ldc_Total_Produtos_NF_Conf, ldc_ICMS_ST, ldc_ICMS_ST_Conf

Decimal ldc_ICMS, ldc_ICMS_Conf

Decimal lvdc_Diferenca_Produtos, lvdc_Diferenca_ST, lvdc_Diferenca_ICMS

String ls_Chave

ls_Chave = "(" + String(al_filial) + "-" + as_fornecedor + "-" + string(al_nota) + ")"

//Desenvolvimento
//Return True

Select n.vl_total_produtos, 
		sum(coalesce(vl_total_item, 0)) - sum(coalesce(vl_desconto_total, 0)), 
		n.vl_icms_st, 
		sum(isnull(i.vl_icms_st_total,0)), 
		n.vl_icms, 
		sum(round(isnull(i.vl_icms,0) * qt_faturada,2))
Into 	:ldc_Total_Produtos, 
		:ldc_Total_Produtos_NF_Conf, 
		:ldc_ICMS_ST, 
		:ldc_ICMS_ST_Conf, 
		:ldc_ICMS, 
		:ldc_ICMS_Conf
From nf_compra_pendente n
Inner join nf_compra_pendente_produto i 	on i.cd_filial 			= n.cd_filial
										  and i.cd_fornecedor	= n.cd_fornecedor
										  and i.nr_nf			 	= n.nr_nf
										  and i.de_especie	 	= n.de_especie
										  and i.de_serie		 	= n.de_serie
Where n.cd_filial 			= :al_Filial
	 and n.nr_nf 				= :al_Nota
	 and n.cd_fornecedor	= :as_Fornecedor
	 and n.de_especie 	= :as_Especie
	 and n.de_serie 			= :as_Serie
group by n.vl_total_produtos, n.vl_icms_st, n.vl_icms
Using SqlCa;

Choose Case Sqlca.SqlCode
	Case 0
		
		
		If ldc_Total_Produtos <=0 or ldc_Total_Produtos_NF_Conf <=0 Then
			as_Mensagem = "O valor total dos produtos da nota $$HEX1$$e900$$ENDHEX$$ invalido. " + ls_Chave
			Return False
		End If
		
//		if ldc_ICMS <= 0 or ldc_ICMS_Conf <=0 then
//			as_Mensagem = "O valor total do ICMS da nota $$HEX1$$e900$$ENDHEX$$ invalido. " + ls_Chave
//		End If		
//		
//		if ldc_ICMS_ST <= 0 or ldc_ICMS_ST_Conf <=0 then
//			as_Mensagem = "O valor total da ST da nota $$HEX1$$e900$$ENDHEX$$ invalido. " + ls_Chave
//		End If		
		
		lvdc_Diferenca_Produtos = abs(round((1 - (ldc_Total_Produtos / ldc_Total_Produtos_NF_Conf))  * 100, 2))
		
		//If lvdc_Diferenca_Produtos > 5 Then
		If ldc_Total_Produtos <> ldc_Total_Produtos_NF_Conf Then
			as_Mensagem = "ERRO - Diferen$$HEX1$$e700$$ENDHEX$$a no valor total de produtos do cabe$$HEX1$$e700$$ENDHEX$$alho com a somat$$HEX1$$f300$$ENDHEX$$ria dos itens '" + String(al_Nota) + "' " + ls_Chave
			//as_Mensagem = "ERRO - O valor total dos produtos da nota '" + String(al_Nota) + "' $$HEX1$$e900$$ENDHEX$$ maior que 5%. " + ls_Chave
			//gf_inclui_log_exportacao_nf_importacao(al_Filial, as_Fornecedor,0, '', as_Mensagem)
			Return False
		End If
		//End If
		
		If ldc_ICMS_ST > 0 Then
			if ldc_ICMS_ST_Conf <=0 then
				as_Mensagem = "ERRO - O valor da ST dos itens da nota $$HEX1$$e900$$ENDHEX$$ invalido. " + ls_Chave
			End If	
						
			lvdc_Diferenca_ST = abs(round((1 - (ldc_ICMS_ST / ldc_ICMS_ST_Conf))  * 100, 2))
			
			If lvdc_Diferenca_ST > 6 Then
				as_Mensagem = "ERRO - O valor total da ST da nota '" + String(al_Nota) + "' $$HEX1$$e900$$ENDHEX$$ maior que 6%. " + 'ST NF: ' + String(ldc_ICMS_ST) + ' ST Itens:' + string(ldc_ICMS_ST_Conf) +  ls_Chave
			//	gf_inclui_log_exportacao_nf_importacao(al_Filial, as_Fornecedor,0, '', as_Mensagem)
				Return False
			End If
		End If
		
		If ldc_ICMS > 0 Then
			if ldc_ICMS_Conf <=0 then
				as_Mensagem = "ERRO - O valor do ICMS dos itens da nota $$HEX1$$e900$$ENDHEX$$ invalido. " + ls_Chave
			End If	
			
			If Not ib_Icms_Diferenca Then //Produto informado mais de uma vez no XML com pc_icms diferente (um registro do outro), se for esta situa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o faz a valida$$HEX2$$e700e300$$ENDHEX$$o abaixo
				lvdc_Diferenca_ICMS = abs(round((1 - (ldc_ICMS / ldc_ICMS_Conf))  * 100, 2))
				
				If lvdc_Diferenca_ICMS > 5 Then
					as_Mensagem = "ERRO - O valor total do ICMS dos itens da ST da nota '" + String(al_Nota) + "' $$HEX1$$e900$$ENDHEX$$ maior que 5%. " + 'ICMS NF: ' + String(ldc_ICMS) + ' ICMS Itens:' + string(ldc_ICMS_Conf) +  ls_Chave
				//	gf_inclui_log_exportacao_nf_importacao(al_Filial, as_Fornecedor,0, '', as_Mensagem)
					Return False
				End If
			End If
		End If
								
	Case 100
		Return False
	Case -1
		as_Mensagem = "Erro na consulta dos valores da nf "+ String(al_Nota) +": "+ SqlCa.SQLErrText
		Return False
End Choose

Return True
end function

public function boolean of_verifica_tributacao (string as_tributacao, ref string as_icms, ref string as_icms_st, ref string as_mensagem);Select id_icms_normal, id_icms_st 
Into :as_icms, :as_icms_st
From tributacao_icms
Where cd_tributacao_icms = :as_tributacao
Using Sqlca;

Choose Case SqlCa.SqlCode 
	Case 0
		Return True
	Case 100
		as_Mensagem = "ERRO - Tributa$$HEX2$$e700e300$$ENDHEX$$o de ICMS n$$HEX1$$e300$$ENDHEX$$o foi localizada '" + as_Tributacao + "' . "+ SqlCa.SQLErrText
	Case -1
		as_Mensagem = "Erro ao localizar a tributa$$HEX2$$e700e300$$ENDHEX$$o do produto. "+ SqlCa.SQLErrText
End Choose	

Return False
end function

private subroutine of_envia_email_divergencias_st ();uo_smtp lo_smtp
Long ll_Linha, ll_Linhas
String ls_Texto_Email
String ls_Divergencias
String ls_destinatarios[] 		= {"lucineide.schneider@clamed.com.br"}
String ls_Email_Copia[]


ls_Divergencias = "Filial: "+String(il_filial)+"<br>Fornecedor: "+is_Fornecedor+"<br>Nota: "+String(il_Nf)+"<br>S$$HEX1$$e900$$ENDHEX$$rie: "+is_Serie+"<br><b>"

ll_Linhas = UpperBound(is_Divergencias_ST[])

For ll_Linha = 1 to ll_Linhas
	ls_Divergencias = ls_Divergencias + "<br>" +	 is_Divergencias_ST[ll_Linha]
Next

ls_Divergencias = ls_Divergencias +"<br><br>A NOTA J$$HEX1$$c100$$ENDHEX$$ FOI IMPORTADA PARA O SISTEMA."

lo_smtp = Create uo_smtp
lo_smtp.ib_grava_log_db = False

lo_smtp.of_envia_email( "RO", &
								"sistemas@clamed.com.br", &
								"Diverg$$HEX1$$ea00$$ENDHEX$$ncias ST", &
								ls_Divergencias, &
								ls_destinatarios,&
								ls_Email_Copia) 
								
Destroy(lo_smtp)								
end subroutine

public function boolean of_codigo_distribuidora (string as_chave_acesso, ref string as_distribuidora, ref string as_mensagem);String ls_CGC_Fornecedor

is_Nm_Fantasia = ""

ls_CGC_Fornecedor = Mid(as_chave_acesso, 7, 14)

Select cd_fornecedor, nm_fantasia, Coalesce(id_uso_consumo, 'N') as id_uso_consumo
Into :as_distribuidora, :is_Nm_Fantasia, :is_id_fornecedor_uso_consumo 
From fornecedor
Where nr_cgc = :ls_CGC_Fornecedor
    and (id_distribuidora = 'S' or id_permite_nota_sem_pedido = 'S')
	and ( id_situacao ='A' or id_situacao is null)
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 0
	Case 100
		as_Mensagem = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum fornecedor cadastrado com o CGC '" + ls_CGC_Fornecedor  + "'."
		Return False
	Case -1
		as_Mensagem = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Fornecedor CGC: '" +  ls_CGC_Fornecedor + "'. " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_busca_xml_ftp (string as_chave_acesso, date adt_emissao, long al_filial, string as_diretorio_xml, boolean ab_download_sefaz, ref string as_mensagem_log);String ls_Ano, ls_Mes, ls_Dia, ls_Cnpj, ls_Arquivo_Xml, ls_Mensagem, ls_Diretorio
Long ll_Ano, ll_Mes, ll_Dia
Boolean lb_Localizado
dc_uo_Ftp lo_Ftp
//lo_Ftp = Create dc_uo_Ftp

//If Not lo_Ftp.of_Conecta_Ftp("", "10.0.0.4", "nfe", "nfe",ref as_mensagem_log ) Then
//	Destroy lo_Ftp	
//	Return False
//End If
//
//ll_Ano = Year(adt_Emissao)
//ll_Mes = Month(adt_Emissao)
//ll_Dia = Day(adt_Emissao)
//
//ls_Ano = "Ano_"+String(ll_Ano)
//If ll_Mes < 10 Then ls_Mes = "Mes_0"+String(ll_Mes) Else ls_Mes = "Mes_"+String(ll_Mes)
//If ll_Dia < 10 Then ls_Dia = "Dia_0"+String(ll_Dia) Else ls_Dia = "Dia_"+String(ll_Dia)
//ls_Cnpj = Mid(as_Chave_Acesso, 7, 14)
//ls_Arquivo_Xml = as_Chave_Acesso+"-nfe.xml"
//
////lb_Localizado = True
////If lo_Ftp.of_Ftp_Set_Dir(ls_Ano, Ref ls_Mensagem) = -1 Then 
////	as_mensagem_log = "XML n$$HEX1$$e300$$ENDHEX$$o localizado"
////	lb_Localizado = False	
////End If
////
////If lb_Localizado Then
////	If lo_Ftp.of_Ftp_Set_Dir(ls_Mes, Ref ls_Mensagem) = -1 Then 
////		as_mensagem_log = "XML n$$HEX1$$e300$$ENDHEX$$o localizado"
////		lb_Localizado = False	
////	End If
////End If
////
////If lb_Localizado Then
////	If lo_Ftp.of_Ftp_Set_Dir(ls_Dia, Ref ls_Mensagem) = -1 Then 
////		as_mensagem_log = "XML n$$HEX1$$e300$$ENDHEX$$o localizado"
////		lb_Localizado = False	
////	End If
////End If
////
////If lb_Localizado Then
////	If lo_Ftp.of_Ftp_Set_Dir(ls_Cnpj, Ref ls_Mensagem) = -1 Then 
////		as_mensagem_log = "XML n$$HEX1$$e300$$ENDHEX$$o localizado"
////		lb_Localizado = False	
////	End If
////End If	
////
//
//ls_Diretorio = ls_Ano + "/" + ls_Mes + "/" + ls_Dia + "/" + ls_CNPJ
//
//lb_Localizado = True
//
//If lo_Ftp.of_Ftp_Set_Dir(ls_Diretorio, Ref ls_Mensagem) = -1 Then 
//	as_mensagem_log = "XML n$$HEX1$$e300$$ENDHEX$$o localizado"
//	lb_Localizado = False	
//End If
//
//If lb_Localizado Then
//	If not lo_Ftp.of_Ftp_GetFile(ls_Arquivo_Xml, as_Diretorio_Xml+ls_Arquivo_Xml, Ref ls_Mensagem) Then
//		as_mensagem_log = "XML n$$HEX1$$e300$$ENDHEX$$o localizado na area FTP CLAMED"
//		lb_Localizado = False
//	End If
//End If	
//
//Destroy(lo_Ftp)
//
// Desenvolvimento
//If Not lb_Localizado Then
//	Return False
//End If

lb_Localizado = False

If ab_download_sefaz Then
	If Not lb_Localizado Then
		ls_Mensagem = ""
		lb_Localizado = True
		//If Not FileExists("C:\Windows\System32\Eventos_Sefaz.dll") Then
//		If Not FileExists("C:\Eventos_Sefaz.dll") Then
//			MessageBox("Alerta", "N$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ instalado a DLL Eventos_Sefaz.dll.")	
//			lb_Localizado = False	
//		End If
	
		If lb_Localizado Then
			If Not FileExists("C:\NF\") Then
				MessageBox("Alerta", "N$$HEX1$$e300$$ENDHEX$$o exixte o diret$$HEX1$$f300$$ENDHEX$$rio 'C:\NF\' utilizado para fazer o download do XML.")	
				lb_Localizado = False	
			End If
		End If	
		
		If lb_Localizado Then
			// comentado sergio 08/07/2016
			//lb_Localizado = of_Download_Xml_Sefaz(as_Chave_Acesso, al_Filial, Ref ls_Mensagem)
			//as_mensagem_log = ls_Mensagem
		End If	
	End If
End If

Return lb_Localizado
end function

public function boolean of_atualiza_finalidade_nfe (string as_finnfe, string as_chave, ref string as_mensagem);Boolean lb_Sucesso = True

Update nfe_indexacao
    set id_finnfe = :as_finnfe
Where id_nf = :as_chave
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Mensagem = "Tab_nfe_indexacao - Erro no update da finalidadade NFe. "+ SqlCa.SqlErrText
	SqlCa.of_Rollback()
	Return False
End If

Update nfe_destinadas
    set id_finnfe = :as_finnfe
Where de_chave_acesso = :as_chave
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Mensagem = "Tab_nfe_destinadas - Erro no update da finalidadade NFe. "+ SqlCa.SqlErrText
	SqlCa.of_Rollback()
	Return False
End If

SqlCa.of_Commit()

Return lb_Sucesso
end function

public subroutine of_envia_email (string ps_assunto, string ps_texto_email);String ls_To	[] 	= {"wagner.frasseto@clamed.com.br", "sergio.gol@clamed.com.br"}

uo_smtp lo_smtp
lo_smtp = Create uo_smtp
lo_smtp.ib_grava_log_db = False

lo_smtp.of_envia_email( "GN", &
								"sistemas@clamed.com.br", &
								ps_Assunto, &
								ps_texto_email, &
								ls_To) 
								
Destroy lo_smtp								
end subroutine

public function boolean of_atualiza_data_reimportacao (long al_filial, string as_fornecedor, long al_nf, string as_chave, ref string as_erro);Update nf_compra_reimportacao
	Set dh_importacao  = getdate()
Where cd_filial 					= :al_Filial
	and cd_fornecedor 		= :as_Fornecedor
	and nr_nf					= :al_Nf
	and de_chave_acesso 	= :as_Chave
Using SqlCa;
	
If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao atualizar a dh_importacao da nf_compra_reimportacao. " + SqlCa.SqlErrText
	Return False
End If

Return True
end function

public function boolean of_verifica_projeto_conexao (string as_de_projeto, string as_distribuidora, string as_infadicional, ref string as_id_conexao, ref string as_mensagem_erro);as_de_projeto = Upper(as_de_projeto)

//Tratamento ProFarma para ENTIRE E FIDELIZE
If as_distribuidora = '053404408' or as_distribuidora = '053405364' or as_distribuidora = '053405857' Or as_distribuidora = '053406098' Then
	If Pos(upper(as_infadicional),  	'ENTIRE') > 0 Then 
		as_de_projeto = 'ENTIRE'
	ElseIf Pos(upper(as_infadicional),  'REPOSICAO') > 0 Then
		as_de_projeto = 'REPOSICAO'
	ElseIf Pos(upper(as_infadicional),  'FIDELIZE') > 0 Then
		as_de_projeto = 'FIDELIZE'
	End If		
End If

//Faturamento da Naz$$HEX1$$e100$$ENDHEX$$ria via Fidelize $$HEX1$$e900$$ENDHEX$$ informado PBM FIDELIZE/SANOFI MEDLEY na tag xVan
If as_Distribuidora = '053406101' Then
	If Pos(upper(as_de_projeto),  	'FIDELIZE') > 0 Then 
		as_de_projeto = 'FIDELIZE'
	End If
End If

If ib_sem_xvan Then
	// A STACRUZ n$$HEX1$$e300$$ENDHEX$$o esta enviando a tag XVAN para algumas lojas.
	// Data Inclus$$HEX1$$e300$$ENDHEX$$o: 24/11/2015 - S$$HEX1$$e900$$ENDHEX$$rgio
	If (as_distribuidora = '053405539' or as_distribuidora = '053400519') and as_de_projeto = "" Then
		If Pos(upper(as_infadicional),  	'PHARMALINK') > 0 Then 
			as_de_projeto = 'PHARMALINK'
			// Colocar um e-mail listar os pedidos que est$$HEX1$$e300$$ENDHEX$$o vindo sem a tag xvan
		End If
		
		If Pos(upper(as_infadicional),  	'ENTIRE') > 0 Then 
			as_de_projeto = 'ENTIRE'
			// Colocar um e-mail listar os pedidos que est$$HEX1$$e300$$ENDHEX$$o vindo sem a tag xvan
		End If
	End If
End If

Choose Case as_de_projeto
	Case  'SEVEN PDV' ,  'VIDALINK'
		as_de_projeto	= 'REPOSICAO'
End Choose

If Not IsNull(as_de_projeto) And as_de_projeto <> "" Then

	select id_projeto_conexao
	into 	:as_id_conexao
	from conexao
	where de_projeto_conexao = :as_De_Projeto
	Using SqlCa;
	
	If  SqlCa.SqlCode = -1 Then
		as_mensagem_erro = "Erro ao localizar o projeto conex$$HEX1$$e300$$ENDHEX$$o usando o parametro:  " + as_De_Projeto + ". " + SqlCa.SqlErrText
		Return False
	End If
	
End If

Return True
end function

public function boolean of_verifica_pedido_conexao_aberto (string as_distribuidora, long al_filial, string as_ean, ref string as_pedido_conexao, ref string as_mensagem_log);Long ll_Pedido_Conexao

select top 1 nr_pedido_conexao
Into :ll_Pedido_Conexao
from pedido_distribuidora p
inner join pedido_distribuidora_produto pp on pp.cd_filial = p.cd_filial and pp.nr_pedido_distribuidora = p.nr_pedido_distribuidora
where p.cd_filial 				= :al_Filial
  	and p.cd_distribuidora 	= :as_Distribuidora
  	and p.dh_emissao 		>= dateadd(dd, -15, cast(getdate() as date))
 	and pp.cd_produto in (select cd_produto from codigo_barras_produto where de_codigo_barras = :as_ean)
	and p.nr_pedido_conexao is not null
	and p.id_situacao <> 'F'
Using SqlCa;

Choose Case Sqlca.SqlCode
	Case 0
		as_pedido_conexao = String(ll_Pedido_Conexao)
	Case 100
		as_pedido_conexao = ''
	Case -1
		as_mensagem_log = "Erro ao localizar o pedido conex$$HEX1$$e300$$ENDHEX$$o em aberto. " + SQLCA.SQLErrText
		Return False
End Choose
 
Return True
end function

public function boolean of_verifica_pedido_conexao_aberto (string as_distribuidora, long al_filial, string as_projeto, t_infnfe at_infnfe, ref long al_pedido_distribuidora, ref string as_mensagem_log);Long ll_Linhas, ll_Linha, ll_Pedido_Dist, ll_Linhas_XML, ll_Linha_XML, ll_Achou, ll_Produtos_Encontrados

String ls_EAN

try
	
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge238_pedido_conexao") Then Return False
	
	//EAN
	ls_EAN = at_infnfe.det[1].prod.cean
	
	lds.Retrieve(al_filial, as_distribuidora, ls_EAN, as_projeto)
	
	ll_Linhas = lds.RowCount()
	
	If ll_Linhas > 0 Then
		
		For ll_Linha = 1 To ll_Linhas
			
			ll_Pedido_Dist = lds.Object.nr_pedido_distribuidora[ll_Linha]
			
			ll_Produtos_Encontrados = 0
			
			ll_Linhas_XML = UpperBound(at_infnfe.det[])
			
			For ll_Linha_XML = 1 To ll_Linhas_XML
				
				ls_EAN = at_infnfe.det[ll_Linha_XML].prod.cean
				
				Select Count(cd_produto) 
				Into :ll_Achou
				from pedido_distribuidora_produto p
				where p.cd_filial = :al_filial
				  and p.nr_pedido_distribuidora = :ll_Pedido_Dist
				  and p.cd_produto in (select cd_produto 
												from codigo_barras_produto
												where de_codigo_barras = :ls_EAN)
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					as_mensagem_log = "Erro ao localizar o pedido conex$$HEX1$$e300$$ENDHEX$$o em aberto. " + SQLCA.SQLErrText
					Return False
				End If
				
				If ll_Achou > 0 Then
					ll_Produtos_Encontrados ++
				End If
				
			Next
			
			If ll_Produtos_Encontrados = ll_Linhas_XML Then
				al_pedido_distribuidora = ll_Pedido_Dist
				Return True
			Else
				SetNull(al_pedido_distribuidora)
			End If
			
		Next
		
	Else
		SetNull(al_pedido_distribuidora)
	End If
		
finally
	Destroy lds
end try
 
Return True
end function

public function boolean of_grava_log (integer ai_arquivo, string as_mensagem);String lvs_Mensagem

Integer lvi_Write
	
lvs_Mensagem = String(Today(), "dd/mm/yyyy") + " " + String(Now(), "hh:mm:ss") + &
               " - " + as_Mensagem

lvi_Write = FileWrite(ai_Arquivo, lvs_Mensagem)

If lvi_Write = LenA(lvs_Mensagem) Then
	Return True
Else
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo de LOG.", StopSign!)
	Return False
End If
end function

public function boolean of_atualiza_qtde_itens_cabecalho (ref string as_mensagem_log);Long ll_Itens

Select count(*)
Into :ll_Itens
from nf_compra_pendente_produto
where cd_filial 				=:il_Filial
	and cd_fornecedor 	= :is_Fornecedor
	and nr_nf				= :il_NF
	and de_especie			= :is_Especie
	and de_serie			= :is_Serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Mensagem_Log = "Erro ao localizar a quantidade de itens na nota: "+ SqlCa.sqlerrtext
	Return False
Else
	If ll_Itens > 0 Then
		update nf_compra_pendente
		set nr_itens = :ll_Itens
		where cd_filial 				=:il_Filial
			and cd_fornecedor 	= :is_Fornecedor
			and nr_nf				= :il_NF
			and de_especie			= :is_Especie
			and de_serie			= :is_Serie
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Mensagem_Log = "Erro ao atualizar a quantidade de itens na nota: "+ SqlCa.sqlerrtext
			Return False
		End If
	End If
End If

Return True




end function

public function boolean of_insere_itens_nf_quimidrol (t_infnfe a_infnfe, long al_filial, string as_fornecedor, long al_nota, string as_serie, ref string as_mensagem_erro);Boolean lb_Erro

Long 	i,&
		ll_Qt_Itens,&
		ll_Cd_Produto,&
		ll_Qt_Faturada,&
		ll_Qt_Recebida,&
		ll_Nr_Classificacao_Fiscal,&
		ll_Cd_Natureza_Operacao,&
		ll_qCom,&
		ll_Qtde,&
		ll_Nulo,&
		ll_NrItem

String 	ls_Cd_Produto_Xml,&
			ls_Ean_Xml,&
			ls_Mensagem_Log,&
			ls_Lei_Generico,&
			ls_EAN,&
			ls_Cd_Situacao_Tributaria,&
			ls_Id_Lista_Pis_Cofins,&
			ls_Id_Reducao_Base_Icms,&
			ls_Cd_Cst_Origem,&
			ls_Cd_Cst_Tributacao,&
			ls_Uf_Origem,&
			ls_Uf_Destino,&
			ls_ICMS_ST,&
			ls_Chave,&
			ls_Chave_ST,&
			ls_Null[],&
			ls_Reducao_Base_Icms,&
			ls_Nome,&
			ls_Unidade,&
			ls_Nat_Op,&
			ls_Natureza_Operacao,&
			ls_cd_produto_sap, &
			ls_cd_cst_is, &
			ls_cd_classificacao_trib_is, &
			ls_cd_un_trib_is, &
			ls_cd_cst_ibscbs, &
			ls_cd_class_trib_ibscbs, &
			ls_cd_cst_ibscbs_reg, &
			ls_cd_class_trib_ibscbs_reg, &
			ls_cd_class_cred_pres_ibs, &
			ls_cd_class_cred_pres_cbs

Decimal 	ldc_Fator_Conversao,&
			ldc_Vl_Preco_Unitario,&
			ldc_Pc_Desconto,&
			ldc_Pc_Icms,&
			ldc_Pc_Ipi,&
			ldc_Vl_Icms_Repassado,&
			ldc_bc_icms,&
			ldc_bc_icms_1,&
			ldc_Pc_Red,&
			ldc_Pc_Reducao_Base_Icms,&
			ldc_Vl_Bc_Icms_St_Total,&
			ldc_Vl_Icms_St_Total,&
			ldc_Vl_Preco_Base_Icms_St,&
			ldc_Vl_Icms_St,&
			ldc_Vl_Bc_Icms,&
			ldc_Vl_Icms,&
			ldc_Vl_Bc_Ipi,&
			ldc_Vbc,&
			ldc_Vipi,&
			ldc_Vl_Ipi,&
			ldc_Vl_Outras_Despesas,&
			ldc_Pc_Icms_St,&
			ldc_Vl_Preco_Unitario_Fiscal,&
			ldc_Vl_Bc_Icms_St_Retido,&
			ldc_Vl_Icms_St_Retido,&
			ldc_ST_Aux,&
			ldc_ICMS_Aux,&
			ldc_Frete,&
			ldc_OutDesp,&
			ldc_Red_ST,&
			ldc_Vl_Desconto_Total,&
			ldc_Vl_Prod_Bruto, &
			ldc_vUnCom, &
			ldc_vl_bc_is, &
			ldc_pc_is, &
			ldc_pc_is_espec, &
			ldc_vl_bc_ibscbs, &
			ldc_qt_trib_is, &
			ldc_vl_is, &
			ldc_vl_ibs, &
			ldc_pc_ibs_uf, &
			ldc_vl_ibs_uf, &
			ldc_pc_dif_ibs_uf, &
			ldc_vl_dif_ibs_uf, &
			ldc_vl_dev_trib_ibs_uf, &
			ldc_pc_reducao_ibs_uf, &
			ldc_pc_efetiva_ibs_uf, &
			ldc_pc_ibs_mun, &
			ldc_vl_ibs_mun, &
			ldc_pc_dif_ibs_mun, &
			ldc_vl_dif_ibs_mun, &
			ldc_vl_dev_trib_ibs_mun, &
			ldc_pc_reducao_ibs_mun, &
			ldc_pc_efetiva_ibs_mun, &
			ldc_pc_cbs, &
			ldc_pc_dif_cbs, &
			ldc_vl_dif_cbs, &
			ldc_vl_dev_trib_cbs, &
			ldc_pc_reducao_cbs, &
			ldc_pc_efetiva_cbs, &
			ldc_vl_cbs, &
			ldc_pc_efetiva_reg_ibs_uf, &
			ldc_vl_trib_reg_ibs_uf, &
			ldc_pc_efetiva_reg_ibs_mun, &
			ldc_vl_trib_reg_ibs_mun, &
			ldc_pc_efetiva_reg_cbs, &
			ldc_vl_trib_reg_cbs, &
			ldc_pc_cred_pres_ibs, &
			ldc_vl_cred_pres_ibs, &
			ldc_vl_cred_pres_ibs_cond_sus, &
			ldc_pc_cred_pres_cbs, &
			ldc_vl_cred_pres_cbs, &
			ldc_vl_cred_pres_cbs_cond_sus

SetNull(ll_Nulo)

Try		
	ll_Qt_Itens = UpperBound(a_InfNFe.det[])
	
	For i = 1 to  ll_Qt_Itens

		ll_CD_Produto         	= ll_Nulo
		ll_qCom               	= a_InfNFe.det[i].prod.qCom 
		ls_Cd_Produto_Xml     	= a_InfNFe.det[i].prod.cProd
		ls_Ean_Xml			    	= a_InfNFe.det[i].prod.cEan
 		ll_NrItem				 	= Long(a_InfNFe.det[i].nitem) 
		ldc_Vl_Desconto_Total 	= a_InfNFe.det[i].prod.vDesc
		ldc_Vl_Prod_Bruto		 	= a_InfNFe.det[i].prod.vProd	
		ldc_vUnCom					= a_InfNFe.det[i].prod.vUnCom
	   
		if ldc_vUnCom <= 0 then
			as_mensagem_erro = "Valor unit$$HEX1$$e100$$ENDHEX$$rio do produto "+ String(ll_Cd_Produto) + " est$$HEX1$$e100$$ENDHEX$$ zerado."
			Return False
		end if
		
		/*
		Se for o fornecedor Beal, n$$HEX1$$e300$$ENDHEX$$o localiza nosso c$$HEX1$$f300$$ENDHEX$$digo do produto. 
		S$$HEX1$$e300$$ENDHEX$$o brinde de natal e n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e300$$ENDHEX$$o cadastrados
		*/
		If as_Fornecedor  <> "053479783" Then 
			of_Nosso_Codigo_Produto(ls_Cd_Produto_Xml, &
											ls_Ean_Xml,&
											ls_Ean_Xml,&
											as_fornecedor, &
											ref ll_Cd_Produto, &
											ref as_mensagem_erro,&
											ref lb_Erro)
			 If lb_Erro Then Return False
		End If
				
		If Not IsNull(ll_Cd_Produto) and ll_Cd_Produto > 0 Then
			SELECT vl_fator_conversao
			     , id_situacao_pis_cofins
				  , cd_produto_sap
			  INTO :ldc_Fator_Conversao
			     , :ls_Id_Lista_Pis_Cofins
				  , :ls_cd_produto_sap
			  FROM produto_geral
			 WHERE cd_produto = :ll_Cd_Produto
			 USING SqlCa;
			
			Choose Case SqlCa.SqlCode 
				Case 0
				Case 100
					as_mensagem_erro = "Produto n$$HEX1$$e300$$ENDHEX$$o localizado "+ String(ll_Cd_Produto)
					Return False
				Case -1
					as_mensagem_erro = "Erro ao localizar o produto "+ String(ll_Cd_Produto) +": "+ SqlCa.SQLErrText
					Return False
			End Choose
		
			if isnull(ls_cd_produto_sap) or trim(ls_cd_produto_sap) = '' then ll_CD_Produto = ll_Nulo
		end if
		
		if IsNull(ll_Cd_Produto) or ll_Cd_Produto = 0 then
			
			ll_CD_Produto = ll_Nulo
			If a_InfNFe.det[i].imposto.pis.pisaliq.vpis > 0 Then
				ls_Id_Lista_Pis_Cofins = 'T'
			Else
				ls_Id_Lista_Pis_Cofins = 'N'
			End If
			ldc_Fator_Conversao = 1.00
		End If
			 
		ll_Cd_Produto				  = ll_Cd_Produto
		ls_Cd_Situacao_Tributaria = "0"+Mid(String(a_InfNFe.det[i].imposto.ICMS.CST), 1, 1) 
		ll_Qt_Faturada				  = Long(ll_qCom * ldc_Fator_Conversao)
		ll_Qt_Recebida				  = Long(ll_qCom * ldc_Fator_Conversao)
		ldc_Vl_Preco_Unitario	  = a_InfNFe.det[i].prod.vUnCom / ldc_Fator_Conversao
		ldc_Pc_Desconto 			  = (a_InfNFe.det[i].prod.vDesc /(ll_qCom * ldc_vUnCom))* 100
		ldc_Pc_Icms 				  = a_InfNFe.det[i].imposto.ICMS.pICMS
		
		If ldc_Pc_Desconto < 0.00 Or ldc_Pc_Desconto > 100.00 Then
			as_mensagem_erro = "PC desconto invalido. EAN: " + ls_Ean_Xml
			Return False
		End If
		
		// Verifica qual a natureza de opera$$HEX2$$e700e300$$ENDHEX$$o		
		ls_Uf_Origem = a_InfNFe.emit.endereco.uf
		ls_Uf_Destino = a_InfNFe.dest.endereco.uf		
		
		If a_InfNFe.det[i].imposto.IPI.TipoIpi = "IPITrib" Then
			ldc_Vipi = a_InfNFe.det[i].imposto.IPI.IPITrib.vIPI
			ldc_Vbc = a_InfNFe.det[i].imposto.IPI.IPITrib.vBC
			ldc_Pc_Ipi = a_InfNFe.det[i].imposto.ipi.IPITrib.pIPI
		Else
			ldc_Vipi = 0
			ldc_Vbc = 0
			ldc_Pc_Ipi = 0
		End If
		
		ldc_Vl_Bc_Icms_St_Total   = a_InfNFe.det[i].imposto.ICMS.vBCST			
		ldc_Vl_Icms_St_Total 	  = a_InfNFe.det[i].imposto.ICMS.vICMSST					
		ldc_Vl_Icms_Repassado 	  = 0.00		
		ldc_bc_icms 				  = round(a_InfNFe.det[i].imposto.ICMS.vBC / (ll_qCom / ldc_Fator_Conversao)	, 2)
		ldc_bc_icms_1 				  = ldc_Vl_Preco_Unitario * (ldc_Pc_Desconto / 100)
		ldc_Pc_Reducao_Base_Icms  = a_InfNFe.det[i].imposto.ICMS.pRedBC		
						
		// Inicio Altera$$HEX2$$e700e300$$ENDHEX$$o S$$HEX1$$e900$$ENDHEX$$rgio
		ldc_Vl_Preco_Base_Icms_St = (ldc_Vl_Bc_Icms_St_Total / ll_qCom) / ldc_Fator_Conversao
		ldc_Vl_Icms_St 			  = (ldc_Vl_Icms_St_Total / ll_qCom	) / ldc_Fator_Conversao
		ldc_Vl_Bc_Icms 			  = (a_InfNFe.det[i].imposto.ICMS.vBC / ll_qCom ) / ldc_Fator_Conversao
		ldc_Vl_Icms 				  = (a_InfNFe.det[i].imposto.ICMS.vICMS / ll_qCom ) / ldc_Fator_Conversao
		ldc_Vl_Bc_Ipi 				  = (ldc_Vbc / ll_qCom) / ldc_Fator_Conversao
		ldc_Vl_Ipi 					  = (ldc_Vipi / ll_qCom) / ldc_Fator_Conversao
		// T$$HEX1$$e900$$ENDHEX$$rmino altera$$HEX2$$e700e300$$ENDHEX$$o S$$HEX1$$e900$$ENDHEX$$rgio
		
		ldc_Vl_Outras_Despesas 	  = a_InfNFe.det[i].prod.vOutro // Valor total
		ldc_Pc_Icms_St            = a_InfNFe.det[i].imposto.ICMS.pICMSST
		ls_Cd_Cst_Origem 			  = String(a_InfNFe.det[i].imposto.ICMS.orig)
		ls_Cd_Cst_Tributacao 	  = a_InfNFe.det[i].imposto.ICMS.CST
		
		If ldc_Pc_Reducao_Base_Icms > 0 Then 
			ls_Id_Reducao_Base_Icms = "S" 
		Else 
			ls_Id_Reducao_Base_Icms = "N"
		End If
		
		ldc_Vl_Preco_Unitario_Fiscal = a_InfNFe.det[i].prod.vUnCom / ldc_Fator_Conversao 
		ll_Nr_Classificacao_Fiscal   = a_InfNFe.det[i].prod.NCM
		// In$$HEX1$$ed00$$ENDHEX$$cio altera$$HEX2$$e700e300$$ENDHEX$$o S$$HEX1$$e900$$ENDHEX$$rgio
		ldc_Vl_Bc_Icms_St_Retido 	  = (a_InfNFe.det[i].imposto.ICMS.vBCSTRet / ll_qCom) / ldc_Fator_Conversao 
		ldc_Vl_Icms_St_Retido 		  = (a_InfNFe.det[i].imposto.ICMS.vICMSSTRet / ll_qCom) / ldc_Fator_Conversao 
		// Fim altera$$HEX2$$e700e300$$ENDHEX$$o S$$HEX1$$e900$$ENDHEX$$rgio
		ldc_Frete                    = round(a_InfNFe.det[i].prod.vfrete, 2)
		ldc_OutDesp                  = a_InfNFe.det[i].prod.voutro
		ls_Nome                      = a_InfNFe.det[i].prod.xprod
		ls_Nat_Op                    = a_InfNFe.det[i].prod.cfop
		
		/* Campos Reforma Tribut$$HEX1$$e100$$ENDHEX$$ria */
		ls_cd_cst_ibscbs			= a_InfNFe.det[i].imposto.ibscbs.cst
		ls_cd_class_trib_ibscbs	= a_InfNFe.det[i].imposto.ibscbs.cclasstrib
		ldc_vl_bc_ibscbs			= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.vbc, 2)
		ldc_vl_ibs					= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.vibs, 2)
		
		//IBS UF
		ldc_pc_ibs_uf				= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gibsuf.pibsuf, 4)
		ldc_vl_ibs_uf				= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gibsuf.vibsuf, 2)
		ldc_pc_dif_ibs_uf			= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gibsuf.gdif.pdif, 4)
		ldc_vl_dif_ibs_uf			= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gibsuf.gdif.vdif, 2)
		ldc_pc_reducao_ibs_uf	= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gibsuf.gred.predaliq, 4)
		ldc_pc_efetiva_ibs_uf 	= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gibsuf.gred.paliqefet, 4)
		ldc_vl_dev_trib_ibs_uf	= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gibsuf.gdevtrib.vdevtrib, 2)
		
		//IBS Mun.
		ldc_pc_ibs_mun				= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gibsmun.pibsmun, 4)
		ldc_vl_ibs_mun				= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gibsmun.vibsmun, 2)
		ldc_pc_dif_ibs_mun		= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gibsmun.gdif.pdif, 4)
		ldc_vl_dif_ibs_mun		= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gibsmun.gdif.vdif, 2)
		ldc_vl_dev_trib_ibs_mun	= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gibsmun.gdevtrib.vdevtrib, 2)
		ldc_pc_reducao_ibs_mun	= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gibsmun.gred.predaliq, 4)
		ldc_pc_efetiva_ibs_mun	= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gibsmun.gred.paliqefet, 4)
	
		//CBS
		ldc_pc_cbs 				= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gcbs.pcbs, 4)
		ldc_pc_dif_cbs			= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gcbs.gdif.pdif, 4)
		ldc_vl_dif_cbs 		= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gcbs.gdif.vdif, 2)
		ldc_vl_dev_trib_cbs 	= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gcbs.gdevtrib.vdevtrib, 2)
		ldc_pc_reducao_cbs	= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gcbs.gred.predaliq, 4)
		ldc_pc_efetiva_cbs 	= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gcbs.gred.paliqefet, 4)
		ldc_vl_cbs				= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gcbs.vcbs, 2)
	
		//Tributa$$HEX2$$e700e300$$ENDHEX$$o Regular
		ls_cd_cst_ibscbs_reg				= a_InfNFe.det[i].imposto.ibscbs.gibscbs.gtribregular.cstreg
		ls_cd_class_trib_ibscbs_reg  	= a_InfNFe.det[i].imposto.ibscbs.gibscbs.gtribregular.cclasstribreg
		ldc_pc_efetiva_reg_ibs_uf	 	= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gtribregular.paliqefetregibsuf, 4)
		ldc_vl_trib_reg_ibs_uf			= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gtribregular.vtribregibsuf, 2)
		ldc_pc_efetiva_reg_ibs_mun		= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gtribregular.paliqefetregibsmun, 4)
		ldc_vl_trib_reg_ibs_mun			= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gtribregular.vtribregibsmun, 2)
		ldc_pc_efetiva_reg_cbs			= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gtribregular.paliqefetregcbs, 4)
		ldc_vl_trib_reg_cbs				= Round(a_InfNFe.det[i].imposto.ibscbs.gibscbs.gtribregular.vtribregcbs, 2)
		
		//Cr$$HEX1$$e900$$ENDHEX$$dito Presumido
//		ls_cd_class_cred_pres_ibs
//		ldc_pc_cred_pres_ibs
//		ldc_vl_cred_pres_ibs
//		ldc_vl_cred_pres_ibs_cond_sus
//		ls_cd_class_cred_pres_cbs
//		ldc_pc_cred_pres_cbs
//		ldc_vl_cred_pres_cbs
//		ldc_vl_cred_pres_cbs_cond_sus
		
		//Imposto Seletivo
		ls_cd_cst_is 						= a_InfNFe.det[i].imposto.isel.cstis
		ls_cd_classificacao_trib_is	= a_InfNFe.det[i].imposto.isel.cclasstribis
		ldc_vl_bc_is 						= Round(a_InfNFe.det[i].imposto.isel.vbcis, 2)
		ldc_pc_is							= Round(a_InfNFe.det[i].imposto.isel.pis, 4)
		ldc_pc_is_espec					= Round(a_InfNFe.det[i].imposto.isel.pisespec, 4)
		ls_cd_un_trib_is					= a_InfNFe.det[i].imposto.isel.utrib
		ldc_qt_trib_is						= Round(a_InfNFe.det[i].imposto.isel.qtrib, 4)
		ldc_vl_is							= Round(a_InfNFe.det[i].imposto.isel.vis, 2)
		/* Fim Campos Reforma Tribut$$HEX1$$e100$$ENDHEX$$ria */

		
		//Fixo como Notas de Uso Consumo 
		//Adicionado [ls_Nat_Op='6405'] referente as notas da QUIMIDROL de Curitiba
//		If (ls_Nat_Op='6101')or(ls_Nat_Op='6102')or(ls_Nat_Op='6401')or(ls_Nat_Op='6403')or(ls_Nat_Op='6405')or(ls_Nat_Op='6404')or(ls_Nat_Op='6108') then
//			ls_Nat_Op = '2556'
//		ElseIf (ls_Nat_Op='5101')or(ls_Nat_Op='5102')or(ls_Nat_Op='5403')or(ls_Nat_Op='5405')or(ls_Nat_Op='5929') then
//			ls_Nat_Op = '1556'
//		ElseIf (ls_Nat_Op='5117') Then
//			ls_Nat_Op = '1949' //Para nota do fornecedor 053479783 -> Beal
//		ElseIf (ls_Nat_Op = '6117') Then
//			ls_Nat_Op = '2949' //Para nota do fornecedor 053479783 -> Beal
//		Else
//			as_mensagem_erro = "CFOP [" + ls_Nat_Op + "] n$$HEX1$$e300$$ENDHEX$$o prevista para a opera$$HEX2$$e700e300$$ENDHEX$$o. Item do XML [" + string(i) + "]." 
//			Return False
//			 // wf_Log("CFOP ["+String(lvl_natureza_operacao)+"] N$$HEX1$$e300$$ENDHEX$$o Prevista para a Opera$$HEX2$$e700e300$$ENDHEX$$o.",3,lvs_Log_NF)
//			//				  //Diminui a CFOP para obter a CFOP de entrada
//			//lvl_natureza_operacao -= 4000
//		End If
		
		Choose Case ls_Nat_Op
			Case '6101', '6102', '6401', '6403', '6405', '6404', '6108'
				// Chamado  1189687: Corre$$HEX2$$e700e300$$ENDHEX$$o Regra NFe compra QUIMIDROL
				If ls_Uf_Destino = "PR" and ls_Cd_Cst_Tributacao = "10" Then 
					ls_Natureza_Operacao = '2407'
				Else
					ls_Natureza_Operacao = '2556'						
				End If 
			Case '5101', '5102', '5403', '5405', '5929'
				ls_Natureza_Operacao = '1556'
			Case '5117' //Para nota do fornecedor 053479783 -> Beal
				ls_Natureza_Operacao = '1949' 
			Case '6117' //Para nota do fornecedor 053479783 -> Beal
				ls_Natureza_Operacao = '2949' 
			Case '5949', '6949', '5910', '6910'
				//Chamado 2084657 - Notas contabilista n$$HEX1$$e300$$ENDHEX$$o alterar cfop e entrar como destinadas
				ls_Natureza_Operacao = ls_Nat_Op
			Case Else
				as_mensagem_erro = "CFOP [" + ls_Nat_Op + "] n$$HEX1$$e300$$ENDHEX$$o prevista para a opera$$HEX2$$e700e300$$ENDHEX$$o. Item do XML [" + string(i) + "]." 
				Return False
		End Choose
 
		ls_Unidade = a_InfNFe.det[i].prod.ucom
		ldc_Red_ST = a_InfNFe.det[i].imposto.ICMS.predbcst
								
		//Limita as casas decimais
		ldc_Vl_Preco_Unitario 	     = Round(ldc_Vl_Preco_Unitario ,2)
		ldc_Pc_Desconto 			     = Round(ldc_Pc_Desconto ,2)
		ldc_Pc_Icms 				     = Round(ldc_Pc_Icms ,2)
		ldc_Pc_Ipi 					     = Round(ldc_Pc_Ipi ,2)
		ldc_Vl_Icms_Repassado 	     = Round(ldc_Vl_Icms_Repassado ,2)
		ldc_Pc_Reducao_Base_Icms     = Round(ldc_Pc_Reducao_Base_Icms ,2)
		ldc_Vl_Preco_Base_Icms_St    = Round(ldc_Vl_Preco_Base_Icms_St ,2)
		ldc_Vl_Icms_St 			     = Round(ldc_Vl_Icms_St ,2)
		ldc_Vl_Bc_Icms 			     = Round(ldc_Vl_Bc_Icms ,2)
		ldc_Vl_Icms 				     = Round(ldc_Vl_Icms ,2)
		ldc_Vl_Bc_Ipi 				     = Round(ldc_Vl_Bc_Ipi ,2)
		ldc_Vl_Ipi 				        = Round(ldc_Vl_Ipi ,2)
		ldc_Vl_Outras_Despesas 	     = Round(ldc_Vl_Outras_Despesas ,2)
		ldc_Pc_Icms_St 			     = Round(ldc_Pc_Icms_St ,2)
		ldc_Vl_Bc_Icms_St_Total      = Round(ldc_Vl_Bc_Icms_St_Total ,2)
		ldc_Vl_Icms_St_Total 		  = Round(ldc_Vl_Icms_St_Total ,2)
		ldc_Vl_Preco_Unitario_Fiscal = Round(ldc_Vl_Preco_Unitario_Fiscal ,2)
		ldc_Vl_Bc_Icms_St_Retido 	  = Round(ldc_Vl_Bc_Icms_St_Retido ,2)
		ldc_Vl_Icms_St_Retido 		  = Round(ldc_Vl_Icms_St_Retido ,2)
		ldc_Vl_Desconto_Total 		  = Round(ldc_Vl_Desconto_Total ,2)
		ldc_Vl_Prod_Bruto				  = Round(ldc_Vl_Prod_Bruto ,2)
		
		//ls_Nat_Op = String(ll_Cd_Natureza_Operacao)
					
		INSERT INTO nfe_compra_pendente_prd
		           ( cd_filial
					  , cd_fornecedor
					  , nr_nf
					  , de_especie
					  , de_serie
					  , cd_natureza_operacao
					  , cd_item
					  , cd_produto
					  , de_produto
					  , cd_situacao_tributaria
					  , qt_faturada
					  , vl_preco_unitario
					  , pc_desconto
					  , vl_desconto
					  , bc_icms
					  , pc_icms
					  , pc_reducao_icms
					  , vl_icms
					  , bc_icms_st
					  , pc_icms_st
					  , pc_reducao_icms_st
					  , vl_icms_st
					  , bc_ipi
					  , pc_ipi
					  , vl_ipi
					  , vl_outras_despesas
					  , id_lista_pis_confins
					  , cd_cst_origem
					  , nr_classificacao_fiscal
					  , cd_cst_tributacao
					  , de_codigo_barras
					  , vl_frete
					  , vl_outras_desp_acessorias
					  , cd_unidade_medida
					  , nr_sequencial
					  , cd_cst_is
					  , cd_classificacao_trib_is
					  , vl_bc_is
					  , pc_is
					  , pc_is_espec
					  , cd_un_trib_is
					  , qt_trib_is
					  , vl_is
					  , cd_cst_ibscbs
					  , cd_class_trib_ibscbs
					  , vl_bc_ibscbs
					  , vl_ibs
					  , pc_ibs_uf
					  , vl_ibs_uf
					  , pc_dif_ibs_uf
					  , vl_dif_ibs_uf
					  , vl_dev_trib_ibs_uf
					  , pc_reducao_ibs_uf
					  , pc_efetiva_ibs_uf
					  , pc_ibs_mun
					  , vl_ibs_mun
					  , pc_dif_ibs_mun
					  , vl_dif_ibs_mun
					  , vl_dev_trib_ibs_mun
					  , pc_reducao_ibs_mun
					  , pc_efetiva_ibs_mun
					  , pc_cbs
					  , pc_dif_cbs
					  , vl_dif_cbs
					  , vl_dev_trib_cbs
					  , pc_reducao_cbs
					  , pc_efetiva_cbs
					  , vl_cbs
					  , cd_cst_ibscbs_reg
					  , cd_class_trib_ibscbs_reg
					  , pc_efetiva_reg_ibs_uf
					  , vl_trib_reg_ibs_uf
					  , pc_efetiva_reg_ibs_mun
					  , vl_trib_reg_ibs_mun
					  , pc_efetiva_reg_cbs
					  , vl_trib_reg_cbs
					  , cd_class_cred_pres_ibs
					  , pc_cred_pres_ibs
					  , vl_cred_pres_ibs
					  , vl_cred_pres_ibs_cond_sus
					  , cd_class_cred_pres_cbs
					  , pc_cred_pres_cbs
					  , vl_cred_pres_cbs
					  , vl_cred_pres_cbs_cond_sus
					  )
			 VALUES ( :al_Filial							//cd_filial
					  , :as_Fornecedor					//cd_fornecedor
					  , :al_Nota							//nr_nf
					  , 'NFE'								//de_especie
					  , :as_Serie							//de_serie
					  , :ls_Natureza_Operacao   		//cd_natureza_operacao
					  //, :ls_Nat_Op                   //cd_natureza_operacao
					  , :i									//cd_item
					  , :ll_Cd_Produto					//cd_produto
					  , :ls_Nome							//de_produto
					  , :ls_Cd_Situacao_Tributaria	//cd_situacao_tributaria
					  , :ll_Qt_Faturada					//qt_faturada
					  , :ldc_Vl_Preco_Unitario  		//vl_preco_unitario
					  , :ldc_Pc_Desconto  				//pc_desconto
					  , 0.00									//vl_desconto
					  , :ldc_Vl_Bc_Icms					//bc_icms
					  , :ldc_Pc_Icms						//pc_icms
					  , :ldc_Pc_Reducao_Base_Icms  	//pc_reducao_icms
					  , :ldc_Vl_Icms						//vl_icms
					  , :ldc_Vl_Preco_Base_Icms_St 	//bc_icms_st
					  , :ldc_Pc_Icms_St					//pc_icms_st
					  , :ldc_Red_ST						//pc_reducao_icms_st
					  , :ldc_Vl_Icms_St					//vl_icms_st
					  , :ldc_Vl_Bc_Ipi					//bc_ipi
					  , :ldc_Pc_Ipi						//pc_ipi
					  , :ldc_Vl_Ipi						//vl_ipi
					  , :ldc_Vl_Outras_Despesas		//vl_outras_despesas
					  , :ls_Id_Lista_Pis_Cofins		//id_lista_pis_confins
					  , :ls_Cd_Cst_Origem				//cd_cst_origem
					  , :ll_Nr_Classificacao_Fiscal	//nr_classificacao_fiscal
					  , :ls_Cd_Cst_Tributacao			//cd_cst_tributacao
					  , :ls_Ean_Xml						//de_codigo_barras
					  , :ldc_Frete							//vl_frete
					  , :ldc_OutDesp						//vl_outras_desp_acessorias
					  , :ls_Unidade				      //cd_unidade_medida
					  , :ll_NrItem							//Numero Sequencial
					  , :ls_cd_cst_is						//cd_cst_is
					  , :ls_cd_classificacao_trib_is //cd_classificacao_trib_is
					  , :ldc_vl_bc_is						//vl_bc_is
					  , :ldc_pc_is							//pc_is
					  , :ldc_pc_is_espec					//pc_is_espec
					  , :ls_cd_un_trib_is				//cd_un_trib_is
					  , :ldc_qt_trib_is					//qt_trib_is
					  , :ldc_vl_is							//vl_is
					  , :ls_cd_cst_ibscbs				//cd_cst_ibscbs
					  , :ls_cd_class_trib_ibscbs		//cd_class_trib_ibscbs
					  , :ldc_vl_bc_ibscbs				//vl_bc_ibscbs
					  , :ldc_vl_ibs						//vl_ibs
					  , :ldc_pc_ibs_uf					//pc_ibs_uf
					  , :ldc_vl_ibs_uf					//vl_ibs_uf
					  , :ldc_pc_dif_ibs_uf				//pc_dif_ibs_uf
					  , :ldc_vl_dif_ibs_uf				//vl_dif_ibs_uf
					  , :ldc_vl_dev_trib_ibs_uf		//vl_dev_trib_ibs_uf
					  , :ldc_pc_reducao_ibs_uf			//pc_reducao_ibs_uf
					  , :ldc_pc_efetiva_ibs_uf			//pc_efetiva_ibs_uf
					  , :ldc_pc_ibs_mun					//pc_ibs_mun
					  , :ldc_vl_ibs_mun					//vl_ibs_mun
					  , :ldc_pc_dif_ibs_mun				//pc_dif_ibs_mun
					  , :ldc_vl_dif_ibs_mun				//vl_dif_ibs_mun
					  , :ldc_vl_dev_trib_ibs_mun		//vl_dev_trib_ibs_mun
					  , :ldc_pc_reducao_ibs_mun		//pc_reducao_ibs_mun
					  , :ldc_pc_efetiva_ibs_mun		//pc_efetiva_ibs_mun
					  , :ldc_pc_cbs						//pc_cbs
					  , :ldc_pc_dif_cbs					//pc_dif_cbs
					  , :ldc_vl_dif_cbs					//vl_dif_cbs
					  , :ldc_vl_dev_trib_cbs			//vl_dev_trib_cbs
					  , :ldc_pc_reducao_cbs				//pc_reducao_cbs
					  , :ldc_pc_efetiva_cbs				//pc_efetiva_cbs
					  , :ldc_vl_cbs						//vl_cbs
					  , :ls_cd_cst_ibscbs_reg			//cd_cst_ibscbs_reg
					  , :ls_cd_class_trib_ibscbs_reg	//cd_class_trib_ibscbs_reg
					  , :ldc_pc_efetiva_reg_ibs_uf	//pc_efetiva_reg_ibs_uf
					  , :ldc_vl_trib_reg_ibs_uf		//vl_trib_reg_ibs_uf
					  , :ldc_pc_efetiva_reg_ibs_mun	//pc_efetiva_reg_ibs_mun
					  , :ldc_vl_trib_reg_ibs_mun		//vl_trib_reg_ibs_mun
					  , :ldc_pc_efetiva_reg_cbs		//pc_efetiva_reg_cbs
					  , :ldc_vl_trib_reg_cbs			//vl_trib_reg_cbs
					  , :ls_cd_class_cred_pres_ibs	//cd_class_cred_pres_ibs
					  , :ldc_pc_cred_pres_ibs			//pc_cred_pres_ibs
					  , :ldc_vl_cred_pres_ibs			//vl_cred_pres_ibs
					  , :ldc_vl_cred_pres_ibs_cond_sus //vl_cred_pres_ibs_cond_sus
					  , :ls_cd_class_cred_pres_cbs	//cd_class_cred_pres_cbs
					  , :ldc_pc_cred_pres_cbs			//pc_cred_pres_cbs
					  , :ldc_vl_cred_pres_cbs			//vl_cred_pres_cbs
					  , :ldc_vl_cred_pres_cbs_cond_sus //vl_cred_pres_cbs_cond_sus
					  )  						 
			  USING SqlCa;
	
		If SqlCa.SqlCode =  -1 Then
			as_mensagem_erro = "Erro no insert 'nfe_compra_pendente_prd' "+ String(ll_Cd_Produto) +": "+ SqlCa.SQLErrText
			SqlCa.of_RollBack();
			Return False
		End If
	Next

Finally
//	Destroy lo_fiscal
End Try

Return True
end function

public function boolean of_verifica_preco_maior_que_da_clamed (decimal adc_preco_unitario, decimal adc_desconto, decimal adc_vl_st, decimal adc_repasse, string as_uf, long al_produto, ref string as_mensagem_log);Decimal ldc_Preco_Liqui
Decimal ldc_Preco_Venda
Decimal ldc_Percent
Decimal ldc_Percent_Parametro

String ls_Mensagem
String ls_Anexo[]
String ls_Aux

ldc_Preco_Liqui = round(adc_Preco_Unitario * ((100 -  adc_Desconto) / 100), 2)

If IsNull(adc_Vl_St) Then
	adc_Vl_St = 0
End If

If IsNull(adc_Repasse) Then
	adc_Repasse = 0
End If

ldc_Preco_Liqui = Round(ldc_Preco_Liqui * ((100 - adc_Repasse) / 100), 2)

ldc_Preco_Liqui = ldc_Preco_Liqui + adc_Vl_St

Select vl_preco_venda_atual
Into :ldc_Preco_Venda
From produto_uf
Where cd_unidade_federacao = :as_uf
And cd_produto = :al_produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o pre$$HEX1$$e700$$ENDHEX$$o de venda atual do produto '" + String(al_produto) + "'."
		Return False
		
	Case -1
		as_Mensagem_Log = "Erro ao consultar pre$$HEX1$$e700$$ENDHEX$$o de venda atual do produto '" + String(al_Produto) + "'." + SqlCa.SqlErrText
		Return False
End Choose

Select vl_parametro
Into :ls_Aux
From parametro_geral
Where cd_parametro = 'PC_VALIDACAO_PRECO_DISTRIB'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o parametro_geral 'PC_VALIDACAO_PRECO_DISTRIB'."
		Return False
		
	Case -1
		as_Mensagem_Log = "Erro ao consultar o parametro_geral 'PC_VALIDACAO_PRECO_DISTRIB'." + SqlCa.SqlErrText
		Return False
End Choose

ldc_Percent = Round(((ldc_Preco_Liqui / ldc_Preco_Venda) -1) * 100, 2)

ldc_Percent_Parametro = Dec(ls_Aux)

If ldc_Percent > ldc_Percent_Parametro Then
	ls_Mensagem = "Produto '" + String(al_Produto) + "' UF '" + as_Uf + "' distribuidora '" + is_Fornecedor + "' est$$HEX1$$e100$$ENDHEX$$ com valor acima do valor de venda da CLAMED."
	gf_ge202_envia_email_automatico(66, "", ls_Mensagem, ls_Anexo)
End If

Return True
end function

public function boolean of_download_xml_sefaz (string as_chave_nota, long al_filial, ref string as_mensagem_log, string as_diretorio_importacao, string as_diretorio_importacao_xml);Boolean lb_Sucesso = True

DateTime ldh_Data_Atual

String ls_Anexo[]

Long ll_Qtde

//Select dh_download_sefaz
//	Into :ldh_Download_Sefaz
//From nfe_destinadas
//Where de_chave_acesso = :as_chave_nota
//	And id_situacao_nf = '1'
//Using SqlCa;
//
//Choose Case SqlCa.SqlCode
//	Case 0
		//Se foi tentado baixar a NF anteriormente o programa n$$HEX1$$e300$$ENDHEX$$o tenta baix$$HEX1$$e100$$ENDHEX$$-lo novamente
//		If Not IsNull(ldh_Download_Sefaz) Then
//			Return True
//		End If
//
//	Case 100	
//		
//	Case -1
//		as_mensagem_log = "Erro ao consultar se j$$HEX1$$e100$$ENDHEX$$ foi tentado baixar a NF " + as_chave_nota + " do SEFAZ anteriormente. Campo dh_download_sefaz da tabela nfe_destinadas"
//		Return False
//End Choose

Try	
	dc_uo_Eventos_Sefaz lo_Eventos_Sefaz
	lo_Eventos_Sefaz = Create dc_uo_Eventos_Sefaz
	
	if gvo_aplicacao.ivs_datasource = 'central' then
		//Verifica se j$$HEX1$$e100$$ENDHEX$$ foi feito manifesta$$HEX1$$e700$$ENDHEX$$ao do destinat$$HEX1$$e100$$ENDHEX$$rio. Caso j$$HEX1$$e100$$ENDHEX$$ foi feito n$$HEX1$$e300$$ENDHEX$$o precisa fazer novamente
		Select count(*)
			Into :ll_Qtde
		From nfe_manifestacao
		Where de_chave_acesso = :as_chave_nota
			And id_situacao_nf = '1'
		Using SqlCa;
		
		If SqlCa.SqlCode =  -1 Then
				as_mensagem_log = "Erro ao consultar se j$$HEX1$$e100$$ENDHEX$$ foi emitido manifesta$$HEX2$$e700e300$$ENDHEX$$o do destinat$$HEX1$$e100$$ENDHEX$$rio. Chave:  " + as_chave_nota + ". Erro: "+ SqlCa.sqlerrtext
				Return False
		End If

		If ll_Qtde < 1 Then
			If Not lo_Eventos_Sefaz.of_envia_manifestacao_destinatario(2, as_Chave_Nota, "Ciencia da Operacao", al_Filial, Ref as_mensagem_log) Then
				as_mensagem_log = as_mensagem_log + "<br><br>Chave: " + as_chave_nota
				gf_ge202_envia_email_automatico(78, '- Ciencia da Operacao', as_Mensagem_Log, ls_Anexo) 
				lb_Sucesso = False
				Return lb_Sucesso
			End If
			
			Sleep(6)
		End If
	end if
		
	If lb_Sucesso Then		
		If Not lo_Eventos_Sefaz.of_download_xml(as_Chave_Nota, al_Filial, Ref as_mensagem_log, as_diretorio_importacao,as_diretorio_importacao_xml) Then
			as_mensagem_log = as_mensagem_log + "<br><br>Chave: " + as_chave_nota
			gf_ge202_envia_email_automatico(78, '- Download XML SEFAZ', as_Mensagem_Log, ls_Anexo)  
			lb_Sucesso = False
			Return lb_Sucesso
		End If
	End If
	
	//Atualiza id_download_sefaz = 'S' - tabela nfe_destinadas
	If lb_Sucesso Then
		If Not lo_Eventos_Sefaz.of_atualiza_id_download_sefaz(as_Chave_Nota, Ref as_mensagem_log) Then
			as_mensagem_log = as_mensagem_log + "<br><br>Chave: " + as_chave_nota
			lb_Sucesso = False
			Return lb_Sucesso
		End If
	End If
	
	Return lb_Sucesso
			
Catch (RunTimeError lo_error)
	as_Mensagem_Log = lo_error.GetMessage( )
	Return False
Finally
	Destroy(lo_Eventos_Sefaz)
	 
	If lb_Sucesso Then		
		ldh_Data_Atual = gf_GetServerDate()
		 
		Update nfe_destinadas
		Set dh_download_sefaz = :ldh_Data_Atual
		Where de_chave_acesso = :as_chave_nota
		And id_situacao_nf = '1'
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Mensagem_Log = "Erro ao atualizar o campo dh_download_sefaz da tabela nfe_destinadas"
			SqlCa.of_Rollback()
			Return False
		End If
		
		SqlCa.of_Commit();		
	End If
	
End Try
Return True
end function

public function boolean of_verifica_cancelamento (string as_chave_acesso, ref string as_mensagem_log);Long ll_Cancelamento

Select count(*) 
Into :ll_Cancelamento
From nfe_destinadas
Where de_chave_acesso 	= :as_chave_acesso
  	and id_situacao_nf 		= '3'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Mensagem_Log = "Erro ao verificar o cancelamento no SEFAZ: "+ SqlCa.sqlerrtext
	SqlCa.of_RollBack();
	Return False
End If

If ll_Cancelamento > 0 Then
	as_mensagem_log = "A nota esta cancelada no SEFAZ."
	Return False
End If

Return True
end function

public function boolean of_embalagem_padrao_distribuidora (long al_filial, long al_pedido, long al_produto, ref long al_caixa_padrao, ref string as_mensagem_log, string as_uf);String ls_conv_embalagem_padrao

If Not ib_Reimportacao Then
	
	Select id_conv_emb_padr_dist_ent
	Into :ls_conv_embalagem_padrao
	From fornecedor 
	Where cd_fornecedor = :is_fornecedor
		Using SqlCa;
				
	Choose Case SqlCa.SqlCode
		Case 0
		// Verifica se o campo est$$HEX1$$e100$$ENDHEX$$ configurado como 'N'
		If ls_conv_embalagem_padrao = 'N' Then
			 al_caixa_padrao = 1
			 Return True
		End If
		
		Case 100
			as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o fornecedor para a filial: " + String(al_filial) + "."
			Return False
			
		Case -1
			as_Mensagem_Log = "Erro ao consultar o fornecedor para a filial: " + String(al_filial) + ". " + SqlCa.SqlErrText
			Return False
	End Choose	
	
	
	Select coalesce(qt_embalagem_padrao_distrib, 1) 
	Into :al_caixa_padrao
	From pedido_distribuidora_produto
	Where cd_filial 							= :al_filial
		and nr_pedido_distribuidora 	= :al_pedido
		and cd_produto 					= :al_produto
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If al_caixa_padrao = 0 Then al_caixa_padrao = 1
			Return True
		Case 100	
			
			//Se n$$HEX1$$e300$$ENDHEX$$o localizar a embalagem padr$$HEX1$$e300$$ENDHEX$$o no pedido, faz a consulta na distribuidora_produto		
			If Not of_emb_padrao_distrib_prod (al_Filial, al_pedido, al_Produto, ref al_caixa_padrao, ref as_mensagem_log, as_uf) Then Return False
	
		Case -1
			as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o da embalagem padr$$HEX1$$e300$$ENDHEX$$o da distribuidora FILIAL/PEDIDO/PRODUTO: " + String(al_filial)  + '/' + String(al_Pedido) + '/' + String(al_produto) + "." + SqlCa.SqlErrText
			Return False
	End Choose
	
Else
	
	If Not of_emb_padrao_distrib_prod (al_Filial, al_pedido, al_Produto, ref al_caixa_padrao, ref as_mensagem_log, as_uf) Then Return False
End If
end function

public function boolean of_valida_parcelas_titulo (ref t_infnfe at_infnfe, string as_fornecedor, ref string as_mensagem_log);Long ll_Qt_Titulos, i
decimal ld_Total_Parcelas
String ls_Texto_Email
Boolean lb_Sucesso = True

If as_fornecedor = "053403312" or as_fornecedor = '053405539' or as_fornecedor = '053400519' or as_fornecedor = '053405356' or as_fornecedor = '053405860' Then Return True

ll_Qt_Titulos = UpperBound( at_infnfe.cobr.dup[] )
						
ls_Texto_Email = "<br><br><table><tr><td>Filial:</td><td>" + String(il_Filial) +"</td>" + &
	"<tr><td>CNPJ:</td><td>"						+ at_infnfe.dest.cnpj + "</td>" + &
	"<tr><td>Fornecedor:</td><td>"				+ is_Nm_Fantasia + " (" + as_fornecedor + ")" + "</td>" + &
	"<tr><td>Nr NF:</td><td>"						+ String(at_infnfe.ide.nNf)		+ "</td>" + &
	"<tr><td>Chave NF:</td><td>" 					+  at_infnfe.id						+ "</td></table>"					

For i = 1 To ll_Qt_Titulos
	ld_Total_Parcelas += Dec(at_infnfe.cobr.dup[ i ].vdup)
Next

Try

	ld_Total_Parcelas = Round(ld_Total_Parcelas, 2)
	
//corrigir o problema na concilia$$HEX2$$e700e300$$ENDHEX$$o da MULTI
//	If (ld_Total_Parcelas - Round(dec(at_infnfe.total.ICMSTot.vNF), 2)) > 0.30 Then
//		as_mensagem_log = "O valor do t$$HEX1$$ed00$$ENDHEX$$tulo [" + String( ld_Total_Parcelas ) + "] $$HEX1$$e900$$ENDHEX$$ maior que o valor total da NF [" + String( at_infnfe.total.ICMSTot.vNF ) + "]"	
//		lb_Sucesso = False
//		Return lb_Sucesso
//	End If
	
	//Desconto concedido na parcela
	//O abatimento deve ocorrer diretamente no sistema da MULTI
	If ll_Qt_Titulos = 1 Then
		If (Round(dec(at_infnfe.total.ICMSTot.vNF), 2) - ld_Total_Parcelas) > 0.30  Then
			as_mensagem_log = "O valor do t$$HEX1$$ed00$$ENDHEX$$tulo [" + String( ld_Total_Parcelas ) + "] $$HEX1$$e900$$ENDHEX$$ MENOR que o valor total da NF [" + String( at_infnfe.total.ICMSTot.vNF ) + "]" + &
										"<br> - Titulo corrigido pelo valor total da NF."
			at_infnfe.cobr.dup[ 1 ].vdup = at_infnfe.total.ICMSTot.vNF
			lb_Sucesso = True
		End If
				
		//corrigir o problema na concilia$$HEX2$$e700e300$$ENDHEX$$o da MULTI
		//Quando o valor $$HEX1$$e900$$ENDHEX$$ maior (geralmente quando a distribuidora cobra o valor da emiss$$HEX1$$e300$$ENDHEX$$o do boleto) n$$HEX1$$e300$$ENDHEX$$o estava sendo inserido o t$$HEX1$$ed00$$ENDHEX$$tulo e acontecia um erro que fechava a aplica$$HEX2$$e700e300$$ENDHEX$$o.
		//Esta altera$$HEX2$$e700e300$$ENDHEX$$o foi feita para que seja inserido o valor do t$$HEX1$$ed00$$ENDHEX$$tulo conforme o valor da nota.
		If (ld_Total_Parcelas - Round(dec(at_infnfe.total.ICMSTot.vNF), 2)) > 0.30 Then
			as_mensagem_log = "O valor do t$$HEX1$$ed00$$ENDHEX$$tulo [" + String( ld_Total_Parcelas ) + "] $$HEX1$$e900$$ENDHEX$$ MAIOR que o valor total da NF [" + String( at_infnfe.total.ICMSTot.vNF ) + "]" + &
										"<br> - Titulo corrigido pelo valor total da NF."
			at_infnfe.cobr.dup[ 1 ].vdup = at_infnfe.total.ICMSTot.vNF
			lb_Sucesso = True
		End If
				
	Else
		
		//Medchap est$$HEX1$$e100$$ENDHEX$$ faturando com dois t$$HEX1$$ed00$$ENDHEX$$tulos e pra essa distribuidora n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ enviado e-mail sobre a quantidade de parecelas
		If as_Fornecedor <> "053406168" Then
			as_mensagem_log = "Divergencia na qtde. de parcela [ " + String( ll_Qt_Titulos ) + " ]"
		End If
		
//		Duas ou mais Parcelas e mesmo assim o valor $$HEX1$$e900$$ENDHEX$$ menor ou maior que o valor Total NF
		If ((Round(dec(at_infnfe.total.ICMSTot.vNF), 2) - ld_Total_Parcelas) > 0.30) Or (ld_Total_Parcelas - (Round(dec(at_infnfe.total.ICMSTot.vNF), 2)) > 0.30) Then 
			lb_Sucesso = False
			
			as_mensagem_log += "<br> - Valor total da nota: " + String(at_infnfe.total.ICMSTot.vNF)
			as_mensagem_log += "<br> - Valor total da soma dos t$$HEX1$$ed00$$ENDHEX$$tulos: " + String(ld_Total_Parcelas)
			as_mensagem_log += "<br><br> O T$$HEX1$$cd00$$ENDHEX$$TULO N$$HEX1$$c300$$ENDHEX$$O FOI IMPORTADO."
			lb_Sucesso = False
		Else
			lb_Sucesso = True
		End If
	End If

Finally
	
	If Not IsNull(as_mensagem_log) And as_mensagem_log <> "" Then gf_ge202_envia_email_automatico(19, '', as_mensagem_log + ls_Texto_Email, {''} )
	
	Return lb_Sucesso
End Try

//If Abs(( ld_Total_Parcelas - Round(dec(at_infnfe.total.ICMSTot.vNF), 2) )) > 2  Then
//	as_mensagem_log = "O valor do t$$HEX1$$ed00$$ENDHEX$$tulo [" + String( ld_Total_Parcelas ) + "] difere do valor total da NF [" + String( at_infnfe.total.ICMSTot.vNF ) + "]"
//	gf_ge202_envia_email_automatico(19, '', as_mensagem_log + ls_Texto_Email, {''} )
//	Return False
//Else
//	If ll_Qt_Titulos > 1 Then
//		as_mensagem_log = "Divergencia na qtde de parcela [ " + String( ll_Qt_Titulos ) + " ]"
//		gf_ge202_envia_email_automatico(19, '', as_mensagem_log + ls_Texto_Email, {''} )
//	End If
//End If

//Return True
end function

public function boolean of_atualiza_reimportada (long al_filial, string as_fornecedor, long al_nf, string as_chave, ref string as_erro);String ls_Erro

Update log_exclusao_nf_compra
	Set id_reimportada = 'S'
Where cd_filial = :al_Filial
	And cd_fornecedor = :as_Fornecedor
	And nr_nf = :al_Nf
	And de_especie = :is_Especie
	And de_serie = :is_Serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback()
	as_Erro = "Erro ao atualizar o id_reimportada da log_exclusao_nf_compra. " + ls_Erro
	Return False
End If

Return True
end function

public function boolean of_insere_lotes (long al_natureza_operacao, long al_produto, decimal adc_fator_conversao, t_prod at_prod, ref string as_mensagem_log, long al_embalagem_padrao_dist, integer al_qt_faturada);Long	ll_Qt_Itens,&
		i,&
		ll_Qt_Lote,&
		ll_Psico

String ls_Lote

Date	ldt_Validade,&
		ldt_Fabricacao,&
		ldt_Atual
		
String ls_Teste[]

ll_Qt_Itens = UpperBound(at_Prod.med[])

If ll_Qt_Itens > 0 Then

	For i = 1 to  ll_Qt_Itens
		
		ls_Lote = Upper (Mid(gf_Replace(at_Prod.med[i].nLote, " ", "", 0), 1, 10))
			
		select	qt_lote
			Into :ll_Qt_Lote
		from nf_compra_pendente_prd_lote
		where cd_filial 						= :il_Filial
			and cd_fornecedor 			= :is_Fornecedor
			and nr_nf 						= :il_Nf
			and de_especie 				= :is_Especie
			and de_serie 					= :is_Serie
			and cd_natureza_operacao 	= :al_Natureza_Operacao
			and cd_produto 				= :al_Produto
			and nr_lote 						= :ls_Lote
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode						
			Case -1
				as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o dos lotes do produto " + String(al_Produto) + ": " + SqlCa.SqlErrText
				Return False
				
			Case 0	
				ll_Qt_Lote = Round(ll_Qt_Lote + ((at_Prod.med[i].qLote * al_embalagem_padrao_dist) * adc_fator_conversao), 0)
				
				update nf_compra_pendente_prd_lote
				set qt_lote = :ll_Qt_Lote
				where cd_filial 						= :il_Filial
					and cd_fornecedor 			= :is_Fornecedor
					and nr_nf 						= :il_Nf
					and de_especie 				= :is_Especie
					and de_serie 					= :is_Serie
					and cd_natureza_operacao 	= :al_Natureza_Operacao
					and cd_produto 				= :al_Produto
					and nr_lote 						= :ls_Lote
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					as_Mensagem_Log = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da quantidade do lote do produto " + String(al_Produto) + ": " + SqlCa.SqlErrText
					Return False
				End If
				
			Case 100	
				ll_Qt_Lote 		= Round((at_Prod.med[i].qLote * al_embalagem_padrao_dist) * adc_fator_conversao, 0)
				ldt_Validade 	= at_Prod.med[i].dval
				ldt_Fabricacao	= at_Prod.med[i].dfab
				ldt_Atual			= Date(gf_GetServerDate())
				
				If ldt_Fabricacao	> ldt_Atual Then
					ldt_Fabricacao	= ldt_Atual
				End If
				
				If ldt_Validade <= ldt_Fabricacao then 
					ldt_Validade	= ldt_Atual
				End If
				
				insert into nf_compra_pendente_prd_lote(
					cd_filial,
					cd_fornecedor,
					nr_nf,
					de_especie,
					de_serie,
					cd_natureza_operacao,
					cd_produto,
					nr_lote,
					qt_lote,
					dh_validade,
					qt_lote_original,
					dh_fabricacao)
				values(
					:il_Filial,
					:is_Fornecedor,
					:il_Nf,
					:is_Especie,
					:is_Serie,
					:al_Natureza_Operacao,
					:al_Produto,
					:ls_Lote,
					:ll_Qt_Lote,
					:ldt_Validade,
					:ll_Qt_Lote,
					:ldt_Fabricacao)
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					as_Mensagem_Log = "Inserir a quantidade do lote do produto " + String(al_Produto) + ": " + SqlCa.SqlErrText
					Return False
				End If	
		
		End Choose
		 
	Next
	
Else
	
	//Se n$$HEX1$$e300$$ENDHEX$$o foi informada a tag <Med>, se for filial e o produto for psico, grava o lote em branco
	If il_Filial = 534 Then Return True
	
	Select Count(*)
		Into: ll_Psico
	From produto_geral
	Where cd_produto = :al_Produto
		And cd_grupo_psico Is Not Null
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Mensagem_Log = "Erro ao verificar se o prodtuo $$HEX1$$e900$$ENDHEX$$ controlado." + SqlCa.SqlErrText
		Return False
	End If
	
	If ll_Psico = 0 Then Return True
	
	ls_Lote = ''
	
	select	qt_lote
		Into :ll_Qt_Lote
	from nf_compra_pendente_prd_lote
	where cd_filial 						= :il_Filial
		and cd_fornecedor 			= :is_Fornecedor
		and nr_nf 						= :il_Nf
		and de_especie 				= :is_Especie
		and de_serie 					= :is_Serie
		and cd_natureza_operacao 	= :al_Natureza_Operacao
		and cd_produto 				= :al_Produto
		and nr_lote 						= :ls_Lote
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode						
		Case -1
			as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o dos lotes do produto " + String(al_Produto) + " : " + SqlCa.SqlErrText
			Return False
			
		Case 0
			ll_Qt_Lote = Round(ll_Qt_Lote + ((al_qt_faturada * al_embalagem_padrao_dist) * adc_fator_conversao), 0)
							
			update nf_compra_pendente_prd_lote
				set qt_lote = :ll_Qt_Lote
			where cd_filial 						= :il_Filial
				and cd_fornecedor 			= :is_Fornecedor
				and nr_nf 						= :il_Nf
				and de_especie 				= :is_Especie
				and de_serie 					= :is_Serie
				and cd_natureza_operacao 	= :al_Natureza_Operacao
				and cd_produto 				= :al_Produto
				and nr_lote 						= :ls_Lote
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Mensagem_Log = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da quantidade do lote do produto " + String(al_Produto) + ": " + SqlCa.SqlErrText
				Return False
			End If
			
			gf_ge202_Envia_Email_Automatico(129, '', 'FILIAL = ' + String(il_Filial) + " | DISTRIBUIDORA = " + is_Fornecedor + " | NF = " + String(il_Nf) + " | PRODUTO = " + String(al_Produto), ls_Teste[], False)
			
		Case 100
			ll_Qt_Lote = Round((al_qt_faturada * al_embalagem_padrao_dist) * adc_fator_conversao, 0)
			
			SetNull(ldt_Validade)
			SetNull(ldt_Fabricacao)
			
			insert into nf_compra_pendente_prd_lote(
				cd_filial,
				cd_fornecedor,
				nr_nf,
				de_especie,
				de_serie,
				cd_natureza_operacao,
				cd_produto,
				nr_lote,
				qt_lote,
				dh_validade,
				qt_lote_original,
				dh_fabricacao)
			values(
				:il_Filial,
				:is_Fornecedor,
				:il_Nf,
				:is_Especie,
				:is_Serie,
				:al_Natureza_Operacao,
				:al_Produto,
				:ls_Lote,
				:ll_Qt_Lote,
				:ldt_Validade,
				:ll_Qt_Lote,
				:ldt_Fabricacao)
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Mensagem_Log = "Inserir a quantidade do lote do produto " + String(al_Produto) + ": " + SqlCa.SqlErrText
				Return False
			End If
			
			gf_ge202_Envia_Email_Automatico(129, '', 'FILIAL = ' + String(il_Filial) + " | DISTRIBUIDORA = " + is_Fornecedor + " | NF = " + String(il_Nf) + " | PRODUTO = " + String(al_Produto), ls_Teste[], False)
			
	End Choose
	
End If	

Return True
end function

public function boolean of_localiza_codigo_fornecedor (string as_cnpj, ref string as_codigo_fornecedor, ref string as_erro);Boolean			lb_Sucesso
dc_uo_ds_base	lds_Fornecedor
Integer			li_Find, li_Linhas

lds_Fornecedor = Create dc_uo_ds_base

If not lds_Fornecedor.of_ChangeDataObject ('ds_ge238_lista_fornecedor', False) then
	as_Erro = 'Erro no ChangeDataObject da ds_ge238_lista_fornecedor'
	Return False
End if

Try
	li_Linhas = lds_Fornecedor.Retrieve (as_cnpj)
	
	//Verifica se CNPJ est$$HEX1$$e100$$ENDHEX$$ cadastrado
	If li_Linhas = 0 then
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado fornecedor com o CNPJ '" + as_Cnpj + "'"
		lb_Sucesso = False
	else
		
		If This.is_id_fornecedor_uso_consumo = 'N' Then
			li_Find = lds_Fornecedor.Find ("id_importacao_nfe = 'S' and id_situacao = 'A'", 1, li_Linhas)
		Else
			li_Find = lds_Fornecedor.Find ("id_situacao = 'A'", 1, li_Linhas)
		End If
		
		//Verifica se fornecedor est$$HEX1$$e100$$ENDHEX$$ ativo e habilitado para importa$$HEX2$$e700e300$$ENDHEX$$o de NFE
		If li_Find > 0 then
			as_codigo_fornecedor = lds_Fornecedor.Object.cd_fornecedor [li_Find]
			lb_Sucesso = True
		else
			
			li_Find = lds_Fornecedor.Find ("id_situacao = 'A'", 1, li_Linhas)
			
			If li_Find = 0 then
				as_Erro = "O CNPJ '" + as_Cnpj + "' est$$HEX1$$e100$$ENDHEX$$ cadastrado mas n$$HEX1$$e300$$ENDHEX$$o tem nenhum fornecedor ativo associado a ele"
			else
				as_Erro = "O CNPJ '" + as_Cnpj + "' est$$HEX1$$e100$$ENDHEX$$ cadastrado e relacionado a um fornecedor ativo mas que n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ habilitado para importa$$HEX2$$e700e300$$ENDHEX$$o de NFE"
			End if
			
			lb_Sucesso = False
		End if
	End if

Finally
	Destroy lds_Fornecedor
	Return lb_Sucesso
End try
end function

public function boolean of_verifica_pedido_normal_aberto (string as_distribuidora, long al_filial, string as_projeto, t_infnfe at_infnfe, ref long al_pedido_distribuidora, ref string as_mensagem_log);Long ll_Linhas, ll_Linha, ll_Pedido_Dist, ll_Linhas_XML, ll_Linha_XML, ll_Achou, ll_Produtos_Encontrados

String ls_EAN

try
	
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge238_pedido_normal") Then Return False
	
	//EAN
	ls_EAN = at_infnfe.det[1].prod.cean
	
	lds.Retrieve(al_filial, as_distribuidora, ls_EAN)
	
	ll_Linhas = lds.RowCount()
	
	If ll_Linhas > 0 Then
		
		For ll_Linha = 1 To ll_Linhas
			
			ll_Pedido_Dist = lds.Object.nr_pedido_distribuidora[ll_Linha]
			
			ll_Produtos_Encontrados = 0
			
			ll_Linhas_XML = UpperBound(at_infnfe.det[])
			
			For ll_Linha_XML = 1 To ll_Linhas_XML
				
				ls_EAN = at_infnfe.det[ll_Linha_XML].prod.cean
				
				Select Count(cd_produto) 
				Into :ll_Achou
				from pedido_distribuidora_produto p
				where p.cd_filial = :al_filial
				  and p.nr_pedido_distribuidora = :ll_Pedido_Dist
				  and p.cd_produto in (select cd_produto 
												from codigo_barras_produto
												where de_codigo_barras = :ls_EAN)
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					as_mensagem_log = "Erro ao localizar o pedido conex$$HEX1$$e300$$ENDHEX$$o em aberto. " + SQLCA.SQLErrText
					Return False
				End If
				
				If ll_Achou > 0 Then
					ll_Produtos_Encontrados ++
				End If
				
			Next
			
			If ll_Produtos_Encontrados = ll_Linhas_XML Then
				al_pedido_distribuidora = ll_Pedido_Dist
				Return True
			Else
				SetNull(al_pedido_distribuidora)
			End If
			
		Next
		
	Else
		SetNull(al_pedido_distribuidora)
	End If
		
finally
	Destroy lds
end try
 
Return True
end function

public subroutine of_envia_email_sem_tag_xvan (ref t_infnfe at_infnfe, string as_fornecedor, string as_projeto);String ls_Texto_Email

ls_Texto_Email = "N$$HEX1$$c300$$ENDHEX$$O FOI INFORMADA A TAG XVAN."

ls_Texto_Email += "<br><br><table><tr><td>Filial:</td><td>" + String(il_Filial) +"</td>" + &
	"<tr><td>CNPJ:</td><td>"						+ at_infnfe.dest.cnpj + "</td>" + &
	"<tr><td>Distribuidora:</td><td>"				+ is_Nm_Fantasia + " (" + as_fornecedor + ")" + "</td>" + &
	"<tr><td>Nr NF:</td><td>"						+ String(at_infnfe.ide.nNf)		+ "</td>" + &
	"<tr><td>Chave NF:</td><td>" 					+  at_infnfe.id						+ "</td>" + &	
	"<tr><td>Van Conex$$HEX1$$e300$$ENDHEX$$o:</td><td>" 				+  as_projeto						+ "</td></table>"	

gf_ge202_envia_email_automatico(19, '', ls_Texto_Email, {''} )
end subroutine

public function boolean of_verifica_ped_conexao_aberto (string as_distribuidora, long al_filial, long al_pedido_conexao, ref boolean ab_pedido_aberto, ref string as_mensagem_log);Long ll_Achou

Select Count(*)
	Into :ll_Achou
From fornecedor f
	Inner Join conexao_distribuidora c
		On c.cd_distribuidora = f.cd_fornecedor
Where c.cd_distribuidora = :as_Distribuidora
	And (f.id_situacao Is Null Or f.id_situacao = 'A')
	And f.id_distribuidora = 'S'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Mensagem_Log = "Erro ao verificar se a distribuidora " + as_Distribuidora + " faz parte do projeto conex$$HEX1$$e300$$ENDHEX$$o. " + SqlCa.SqlErrText
	Return False
End If

If ll_Achou = 0 Then Return True

Select Count(*)
	Into :ll_Achou
From pedido_distribuidora
Where cd_filial = :al_Filial
	And cd_distribuidora  = :as_Distribuidora
	And nr_pedido_conexao = :al_Pedido_Conexao
	And dh_emissao >= dateadd(day, -15, cast(getdate() as date))
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Mensagem_Log = "Erro ao localizar o pedido conex$$HEX1$$e300$$ENDHEX$$o " + String(al_Pedido_Conexao) + " da filial " + String(al_Filial) + " da distribuidora " + as_Distribuidora + ". " + SqlCa.SqlErrText
	Return False
End If

If ll_Achou > 0 Then
	ab_Pedido_Aberto = True
Else
	ab_Pedido_Aberto = False
End If

Return True
end function

public function boolean of_verifica_conexao_produto (string as_ean, ref string as_projeto, boolean ab_importa_sem_pedido, ref string as_mensagem_log);Select c.de_projeto_conexao
Into :as_projeto
From produto_central pc
Inner Join conexao c
On c.id_projeto_conexao = pc.id_projeto_conexao
Where pc.cd_produto in (select cd_produto from codigo_barras_produto where de_codigo_barras = :as_ean)
Using SqlCa;

Choose Case SqlCa.Sqlcode
    Case 0
        Return True
    Case -1 
        as_Mensagem_Log = "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do projeto conex$$HEX1$$e300$$ENDHEX$$o do produto '" + as_Ean + "'. " + SqlCa.SqlErrText
        Return False
    Case 100
       as_Ean = String(Double(as_Ean))

        Select c.de_projeto_conexao
        Into :as_projeto
        From produto_central pc
        Inner Join conexao c
        On c.id_projeto_conexao = pc.id_projeto_conexao
        Where pc.cd_produto in (select cd_produto from codigo_barras_produto where de_codigo_barras = :as_ean)
        Using SqlCa;

        Choose Case SqlCa.Sqlcode
            Case 0
                Return True
            Case 100
                //S$$HEX1$$f300$$ENDHEX$$ mostra o log se a importa$$HEX2$$e700e300$$ENDHEX$$o da nota for acionada pela tela da ge250
                If ib_Imp_Manual_Sem_Pedido_Conexao and ab_importa_sem_pedido Then
                    as_Mensagem_Log = "Produto n$$HEX1$$e300$$ENDHEX$$o localizado para verifica$$HEX2$$e700e300$$ENDHEX$$o do projeto conex$$HEX1$$e300$$ENDHEX$$o '" + as_Ean + "'."
                    Return False
                End If
            Case -1 
                as_Mensagem_Log = "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do projeto conex$$HEX1$$e300$$ENDHEX$$o do produto '" + as_Ean + "'. " + SqlCa.SqlErrText
                Return False
        End Choose
End Choose

end function

public function boolean of_verifica_filial_ped_conveniencia (long al_filial, ref string as_liberada, ref string as_mensagem_log);Select coalesce(vl_parametro, 'N')
	Into :as_Liberada
From parametro_loja
Where cd_parametro = 'ID_LIBERADO_PEDIDO_AUTO_CONVENIENCIA'
	And cd_filial = :al_Filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		
	Case -1
		as_Mensagem_Log = "Erro ao verificar se a filial " + String(al_Filial) + " est$$HEX1$$e100$$ENDHEX$$ liberada para o pedido autom$$HEX1$$e100$$ENDHEX$$tico de conveni$$HEX1$$ea00$$ENDHEX$$ncia. " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_verifica_registro_recebimento (string as_chave_acesso, ref boolean ab_registrada, ref string as_mensagem_log);//Esta funcionalidade $$HEX1$$e900$$ENDHEX$$ somente para as notas de conveni$$HEX1$$ea00$$ENDHEX$$ncia

Long ll_Achou

Select Count(*)
	Into :ll_Achou
From nf_compra_recebimento
Where de_chave_acesso = :as_Chave_Acesso
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Mensagem_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da nota na nf_compra_recebimento. Chave de acesso: " + as_Chave_Acesso
	Return False
End If

If ll_Achou > 0 Then
	ab_Registrada = True
Else
	ab_Registrada = False
End If

Return True
end function

public function boolean of_insere_itens (t_infnfe a_infnfe, ref string as_mensagem_log, long al_pedido, string as_permite_nota_sem_pedido);Boolean	lb_Erro
Long 	i,&
		ll_Qt_Itens,&
		ll_Cd_Produto,&
		ll_Qt_Faturada,&
		ll_Qt_Recebida,&
		ll_Nr_Classificacao_Fiscal,&
		ll_Cd_Natureza_Operacao,&
		ll_CFOP_XML,&
		ll_qCom,&
		ll_Qtde,&
		ll_Emb_Padrao,&
		ll_Emb_Padrao_Ped,&
		ll_NrItem,&
		ll_Id_Motivo_Desoneracao_Icms, &
		ll_qt_recebida_sap

String 	ls_Cd_Produto_Xml,&
			ls_Ean_Xml,&
			ls_Mensagem_Log,&
			ls_SubCategoria,&
			ls_Lei_Generico,&
			ls_EAN_Trib,&
			ls_Cd_Situacao_Tributaria,&
			ls_Id_Lista_Pis_Cofins,&
			ls_Id_Reducao_Base_Icms,&
			ls_Cd_Cst_Origem,&
			ls_Cd_Cst_Tributacao,&
			ls_Uf_Origem,&
			ls_Uf_Destino,&
			ls_ICMS,&
			ls_ICMS_ST,&
			ls_Chave,&
			ls_Chave_ST,&
			ls_Null[],&
			ls_Reducao_Base_Icms,&
			ls_CST_PIS_XML,&
			ls_CST_COFINS_XML,&
			ls_CST_PIS_Entrada,&
			ls_CST_COFINS_Entrada,&
			ls_Nulo,&
			ls_cd_unidade_comercial,&
			ls_cd_unidade_tributavel,&
			ls_Cbenef,&
			ls_cd_mod_bc_st,&
			ls_cd_cest,&
			ls_cd_produto_sap, &
			ls_id_almox
			
String ls_ModDC

Decimal 	ldc_Fator_Conversao,&
			ldc_Repasse_ICMS_Base,&
			ldc_ICMS_Base,&
			ldc_Reducao_ICMS_Base,&
			ldc_ICMS_ST,&
			ldc_Vl_Preco_Unitario,&
			ldc_Pc_Desconto,&
			ldc_Pc_Icms,&
			ldc_Pc_Ipi,&
			ldc_Vl_Icms_Repassado,&
			ldc_Pc_Red,&
			ldc_Pc_Reducao_Base_Icms,&
			ldc_Vl_Bc_Icms_St_Total,&
			ldc_Vl_Icms_St_Total,&
			ldc_Vl_Preco_Base_Icms_St,&
			ldc_Vl_Icms_St,&
			ldc_Vl_Bc_Icms,&
			ldc_Vl_Icms,&
			ldc_Vl_Bc_Ipi,&
			ldc_Vbc,&
			ldc_Vipi,&
			ldc_Vl_Ipi,&
			ldc_Vl_Outras_Despesas,&
			ldc_Pc_Icms_St,&
			ldc_Vl_Preco_Unitario_Fiscal,&
			ldc_Vl_Bc_Icms_St_Retido_Unit,&
			ldc_Vl_Icms_St_Retido_Unit,&
			ldc_Vl_Bc_Icms_St_Retido_Total,&
			ldc_Vl_Icms_St_Retido_Total,&
			ldc_ST_Aux,&
			ldc_ICMS_Aux,&
			ldc_BC_Antecipa_ICMS,&
			ldc_MVA_Antecipa_ICMS,&
			ldc_Pc_Antecipa_ICMS,&
			ldc_Vl_Antecipa_ICMS,&
			ldc_qt_tributavel,&	
			ldc_qt_comercial,&
			ldc_pc_mva, &
			ldc_PMC,&
			ldc_Vl_Icms_Desonerado,&
			ldc_vl_icms_retido,&
			ldc_vl_icms_retido_unit,&
			ldc_pc_st_retido, &
			ldc_Preco_Bruto_Ped, &
			ldc_Preco_Liqui_Ped, &
			ldc_Resultado, &
			ldc_BC_PIS_XML, &
			ldc_PC_PIS_XML, &
			ldc_VL_PIS_XML, &
			ldc_BC_Cofins_XML, &
			ldc_PC_Cofins_XML, &
			ldc_VL_Cofins_XML, &
			ldc_Ded_ICMS_PIS_Cofins, &
			ldc_BC_PIS_Entrada, &
			ldc_PC_PIS_Entrada, &
			ldc_VL_PIS_Entrada, &
			ldc_BC_Cofins_Entrada, &
			ldc_PC_Cofins_Entrada, &
			ldc_VL_Cofins_Entrada,&
			ldc_Vl_Preco_Unitario_Conf
			
Decimal ldc_ICMS_Operacao, ldc_Pc_Dif_Icms, ldc_ICMS_Dif,ldc_Pc_Icms_Conf

Decimal	ldc_Vl_BC_FCP,&
			ldc_Pc_FCP,&
			ldc_Vl_FCP,&
			ldc_Vl_BC_ST_FCP,&
			ldc_Pc_ST_FCP,&
			ldc_Vl_ST_FCP,&
			ldc_Vl_BC_Ret_FCP,&
			ldc_Pc_Ret_FCP,&
			ldc_Vl_Ret_FCP

Decimal 	ldc_Vl_Desconto_Total,&
			ldc_Vl_Prod_Bruto,&
			ldc_VL_Bc_Icms_Origem,&
			ldc_Vl_Icms_Origem,&
			ldc_Vl_Bc_Ipi_Origem,&
			ldc_Vl_Ipi_Origem		

Integer li_Tributacao_Produto

Long	ll_Qt_Faturada_Xml

Decimal	ldc_Vl_Preco_Unitario_Xml,&
			ldc_Vl_Bc_St_Xml,&
			ldc_Vl_Bc_Icms_Xml,&
			ldc_Vl_Icms_Xml,&
			ldc_Vl_Bc_Ipi_Xml,&
			ldc_Vl_Ipi_Xml

String 	ls_cd_cst_is, ls_cd_classificacao_trib_is, ls_cd_un_trib_is, ls_cd_cst_ibscbs, ls_cd_class_trib_ibscbs, ls_cd_cst_ibscbs_reg, &
			ls_cd_class_trib_ibscbs_reg
Dec{2}	ldc_vl_bc_is, ldc_vl_is, ldc_vl_bc_ibscbs, ldc_vl_ibs, ldc_vl_ibs_uf, ldc_vl_dif_ibs_uf, ldc_vl_dev_trib_ibs_uf, &
			ldc_vl_ibs_mun, ldc_vl_dif_ibs_mun, ldc_vl_dev_trib_ibs_mun, ldc_vl_dif_cbs, ldc_vl_dev_trib_cbs, ldc_vl_cbs, ldc_vl_trib_reg_ibs_uf, &
			ldc_vl_trib_reg_ibs_mun, ldc_vl_trib_reg_cbs
Dec{4}	ldc_pc_is, ldc_pc_is_espec, ldc_qt_trib_is, ldc_pc_ibs_uf, ldc_pc_dif_ibs_uf, ldc_pc_reducao_ibs_uf, ldc_pc_efetiva_ibs_uf, &
			ldc_pc_ibs_mun, ldc_pc_dif_ibs_mun, ldc_pc_reducao_ibs_mun, ldc_pc_efetiva_ibs_mun, ldc_pc_cbs, ldc_pc_dif_cbs, ldc_pc_reducao_cbs, &
			ldc_pc_efetiva_cbs, ldc_pc_efetiva_reg_ibs_uf, ldc_pc_efetiva_reg_ibs_mun, ldc_pc_efetiva_reg_cbs


SetNull(ls_Nulo)

uo_tratamento_fiscal lo_fiscal

dc_uo_ds_base lvds

ib_Icms_Diferenca = False

Try		
	lo_fiscal = Create uo_tratamento_fiscal
	
	lvds = Create dc_uo_ds_base
		
	If Not lvds.of_ChangeDataObject("ds_ge238_existe_produto") Then 
		as_Mensagem_Log ="Erro no of_ChangeDataObject('ds_ge238_existe_produto')."
		Return False
	End If
	
	is_Divergencias_ST = ls_Null

	ll_Qt_Itens = UpperBound(a_InfNFe.det[])
	
	For i = 1 to  ll_Qt_Itens
		// Verifica qual a natureza de opera$$HEX2$$e700e300$$ENDHEX$$o		
		ls_Uf_Origem 	= a_InfNFe.emit.endereco.uf
		ls_Uf_Destino 	= a_InfNFe.dest.endereco.uf	
		
		ll_qCom 							= 	a_InfNFe.det[i].prod.qCom 
		ldc_Vl_Preco_Unitario			= 	a_InfNFe.det[i].prod.vUnCom
		ls_Cd_Produto_Xml 			=	a_InfNFe.det[i].prod.cProd
		ls_Ean_Xml						= 	a_InfNFe.det[i].prod.cEan
		ls_Ean_Trib						= 	a_InfNFe.det[i].prod.cEantrib
 		ll_NrItem							= Long(a_InfNFe.det[i].nitem) 
		ldc_Vl_Desconto_Total		= a_InfNFe.det[i].prod.vDesc
		ldc_Vl_Prod_Bruto				= a_InfNFe.det[i].prod.vProd	
		ls_cd_unidade_comercial		= a_InfNFe.det[i].prod.uCom		
		ls_cd_unidade_tributavel		= a_InfNFe.det[i].prod.uTrib
		ldc_qt_tributavel				= a_InfNFe.det[i].prod.qTrib			
		ldc_qt_comercial				= a_InfNFe.det[i].prod.qCom
		ls_cd_cest						= a_InfNFe.det[i].prod.cest
		ll_CFOP_XML					= Long(a_InfNFe.det[i].prod.cfop)
		ldc_PMC							= a_InfNFe.det[i].prod.vPMC

		If as_permite_nota_sem_pedido = "S" Then			
			If Not of_nosso_codigo_produto(	ls_Cd_Produto_Xml,&
														ls_Ean_Xml, ls_Ean_Trib,&
														is_fornecedor,&
														ref ll_Cd_Produto, &
														ref ls_Mensagem_Log,&
														ref lb_Erro) Then
				as_Mensagem_Log = ls_Mensagem_Log
				Return False
			End If
			
			select id_situacao_pis_cofins, vl_fator_conversao, cd_subcategoria
			into :ls_Id_Lista_Pis_Cofins, :ldc_Fator_Conversao, :ls_SubCategoria
			from produto_geral
			where cd_produto = :ll_Cd_Produto
			Using SqlCa;
			
			If sqlca.sqldbcode = -1 Then
				as_mensagem_log = 'Erro ao buscar id_situacao_pis_cofins. Produto: ' + String(ll_Cd_Produto) + '. Erro: ' + SQLCA.SqlErrText
				Return False
			End If
			
			ll_Emb_Padrao = 1
		Else
			If Not of_Nosso_Codigo_Produto(	ls_Cd_Produto_Xml, &
														is_Fornecedor, &
														ref ll_Cd_Produto, &
														ref ldc_Fator_Conversao, &
														ref ldc_Repasse_ICMS_Base, &
														ref ldc_ICMS_Base, &
														ref ldc_Reducao_ICMS_Base, &
														il_Filial,&
														ref li_Tributacao_Produto,&
														ref ldc_ICMS_ST,&
														ref ls_SubCategoria,&
														ref ls_Lei_Generico,&
														ls_Ean_Xml,&
														ls_Ean_Trib,&
														ref ls_Id_Lista_Pis_Cofins,&
														ref ls_cd_produto_sap,&
														ref ls_Mensagem_Log) Then
				as_Mensagem_Log = ls_Mensagem_Log
				Return False
			End If
			
			If Not of_embalagem_padrao_distribuidora (il_Filial, al_pedido, ll_Cd_Produto, ref ll_Emb_Padrao, ref as_mensagem_log, ls_Uf_Destino) Then Return False
			
			//Se for reimporta$$HEX2$$e700e300$$ENDHEX$$o, nota do pedido normal e n$$HEX1$$e300$$ENDHEX$$o for distribuidora de converni$$HEX1$$ea00$$ENDHEX$$ncia (Femsa/Spal)
			If ib_Reimportacao And is_ID_Conexao = "" And Not ib_Distrib_Conv Then
				
				If Not of_Preco_Produto_Pedido (il_Filial, al_pedido, ll_Cd_Produto, ref ldc_Preco_Bruto_Ped, ref ldc_Preco_Liqui_Ped, ref ll_Emb_Padrao_Ped, ref as_mensagem_log) Then Return False				
				
				//Se a embalagem padr$$HEX1$$e300$$ENDHEX$$o do pedido $$HEX1$$e900$$ENDHEX$$ a mesma da distribuidora_produto, n$$HEX1$$e300$$ENDHEX$$o precisa fazer a valida$$HEX2$$e700e300$$ENDHEX$$o dos pre$$HEX1$$e700$$ENDHEX$$os
				If ll_Emb_Padrao_Ped <> ll_Emb_Padrao Then
					//Se o pre$$HEX1$$e700$$ENDHEX$$o informado no xml for 10% diferente do pre$$HEX1$$e700$$ENDHEX$$o l$$HEX1$$ed00$$ENDHEX$$quido ou pre$$HEX1$$e700$$ENDHEX$$o bruto
					If abs(round((1 - (ldc_Vl_Preco_Unitario / ldc_Preco_Liqui_Ped)) * 100, 2)) > 10 Then
						If abs(round((1 - (ldc_Vl_Preco_Unitario / ldc_Preco_Bruto_Ped)) * 100, 2)) > 10 Then
							as_Mensagem_Log = "ERRO na reimporta$$HEX2$$e700e300$$ENDHEX$$o - A diferen$$HEX1$$e700$$ENDHEX$$a do pre$$HEX1$$e700$$ENDHEX$$o informado no XML '" + String(ldc_Vl_Preco_Unitario) + " da NF " + String(il_Nf) + "' $$HEX1$$e900$$ENDHEX$$ 10% maior que o pre$$HEX1$$e700$$ENDHEX$$o l$$HEX1$$ed00$$ENDHEX$$quido do pedido '" + String(ldc_Preco_Liqui_Ped) + "'. " + &
														"(" + String(il_filial) + "-" + is_fornecedor + "-" + string(il_nf) + "-" + is_Especie + "-" + is_Serie + "-" +String(ll_CD_Produto) + ")"
							Return False
						End If
					End If
				End If
			End If
		End If
				
		ls_Chave = "(" + String(il_filial) + "-" + is_fornecedor + "-" + string(il_nf) + "-" + is_Especie + "-" + is_Serie + "-" +String(ll_CD_Produto) + ")"
		
		//Tratamento embalagem padr$$HEX1$$e300$$ENDHEX$$o
		ll_qCom 							= (ll_qCom * ll_Emb_Padrao) * ldc_Fator_Conversao
		ldc_Vl_Preco_Unitario			= round(Round(ldc_Vl_Preco_Unitario / ll_Emb_Padrao, 2) / ldc_Fator_Conversao, 2)
		 
		ll_Cd_Produto					= ll_Cd_Produto
		ls_Cd_Situacao_Tributaria 	= "0"+Mid(String(a_InfNFe.det[i].imposto.ICMS.CST), 1, 1) 
		ll_Qt_Faturada					= ll_qCom
		ll_Qt_Recebida					= ll_qCom
				
		// % DESCONTO => VALOR DO DESCONTO / (QTDE FAT * PRECO UNITARIO)
		ldc_Pc_Desconto	=	(a_InfNFe.det[i].prod.vDesc /(a_InfNFe.det[i].prod.qCom * a_InfNFe.det[i].prod.vUnCom))* 100
		ldc_Pc_Icms			=	a_InfNFe.det[i].imposto.ICMS.pICMS

		If ldc_Pc_Desconto < 0.00 Or ldc_Pc_Desconto > 100.00 Then
			as_Mensagem_Log = "PC desconto invalido. EAN: " + ls_Ean_Xml
			Return False
		End If
				
		If Not This.of_Verifica_Tributacao(Mid(String(a_InfNFe.det[i].imposto.ICMS.CST), 1, 1) , ref ls_ICMS, ref ls_ICMS_ST, ref as_Mensagem_Log) Then
			Return False
		End If
		
		lo_fiscal.of_Grava_Contribuinte(True)	
		lo_fiscal.of_set_fornecedor_uso_consumo(is_id_fornecedor_uso_consumo)
		lo_fiscal.of_Grava_UF_Origem_Destino(ls_Uf_Origem, ls_Uf_Destino)	
		lo_fiscal.of_Grava_Operacao(lo_fiscal.COMPRA)
		lo_fiscal.ivl_Filial_Destino = il_Filial
		
		if left(ls_SubCategoria, 1) = '5' then
			ls_id_almox = 'S'
		else
			ls_id_almox = 'N'
		end if
			
		lo_fiscal.is_produto_almoxarifado	= ls_id_almox
		
		If Not lo_Fiscal.of_NatOpe_Compra(is_Fornecedor, ls_Cd_Situacao_Tributaria, ref ll_Cd_Natureza_Operacao) Then
			as_Mensagem_Log = "Erro na Determina$$HEX2$$e700e300$$ENDHEX$$o da Natureza de Opera$$HEX2$$e700e300$$ENDHEX$$o"
			Return False
		End If		
				
		If a_InfNFe.det[i].imposto.IPI.TipoIpi = "IPITrib" Then
			ldc_Vipi 		= a_InfNFe.det[i].imposto.IPI.IPITrib.vIPI
			ldc_Vbc 		= a_InfNFe.det[i].imposto.IPI.IPITrib.vBC
			ldc_Pc_Ipi 	= a_InfNFe.det[i].imposto.ipi.IPITrib.pIPI
			
			ldc_Vl_Bc_Ipi 	= (ldc_Vbc / ll_qCom)
			ldc_Vl_Ipi 		= (ldc_Vipi / ll_qCom)
		Else
			ldc_Vipi = 0
			ldc_Vbc = 0
			ldc_Pc_Ipi = 0
		End If
		
		ldc_Vl_Bc_Icms_St_Total 	= a_InfNFe.det[i].imposto.ICMS.vBCST			
		ldc_Vl_Icms_St_Total 		= a_InfNFe.det[i].imposto.ICMS.vICMSST
		ldc_pc_st_retido				= Round(a_InfNFe.det[i].imposto.ICMS.pST, 2)
		
		ldc_Vl_Icms_Repassado 		= 0.00		
										
		// Inicio Altera$$HEX2$$e700e300$$ENDHEX$$o S$$HEX1$$e900$$ENDHEX$$rgio
		ldc_Vl_Preco_Base_Icms_St 	= (ldc_Vl_Bc_Icms_St_Total / ll_qCom)
		ldc_Vl_Icms_St 					= (ldc_Vl_Icms_St_Total / ll_qCom)
		ldc_Vl_Bc_Icms 					= (a_InfNFe.det[i].imposto.ICMS.vBC / ll_qCom )
		ldc_Vl_Icms 						= (a_InfNFe.det[i].imposto.ICMS.vICMS / ll_qCom )
		ldc_Pc_Reducao_Base_Icms 		= a_InfNFe.det[i].imposto.ICMS.pRedBC		

		// Campos com Dados Originais do XML
		ldc_VL_Bc_Icms_Origem 			= a_InfNFe.det[i].imposto.ICMS.vBC
		ldc_Vl_Icms_Origem				=  a_InfNFe.det[i].imposto.ICMS.vICMS
		ldc_Vl_Bc_Ipi_Origem				=	a_InfNFe.det[i].imposto.IPI.IPITrib.vBC
		ldc_Vl_Ipi_Origem					=  a_InfNFe.det[i].imposto.IPI.IPITrib.vIPI

		If ls_ICMS = 'S' Then
			If IsNull(ldc_Pc_Icms ) or ldc_Pc_Icms <= 0 Then
				as_Mensagem_Log ="ERRO  - A tributa$$HEX2$$e700e300$$ENDHEX$$o '" + ls_Cd_Situacao_Tributaria + "' exige aliquota de ICMS maior que zero." + ls_Chave
				is_Divergencias_ST[ UpperBound(is_Divergencias_ST[])+1 ] = "Produto: "+String(ll_Cd_Produto)+" ERRO  - A tributa$$HEX2$$e700e300$$ENDHEX$$o '" + ls_Cd_Situacao_Tributaria + "' exige aliquota de ICMS maior que zero."
			End If
			
			If IsNull(ldc_Vl_Bc_Icms ) or ldc_Vl_Bc_Icms <= 0 Then
				as_Mensagem_Log ="ERRO  - A tributa$$HEX2$$e700e300$$ENDHEX$$o '" + ls_Cd_Situacao_Tributaria + "' exige o valor da base de ICMS maior que zero." + ls_Chave
				is_Divergencias_ST[ UpperBound(is_Divergencias_ST[])+1 ] = "Produto: "+String(ll_Cd_Produto)+" ERRO  - A tributa$$HEX2$$e700e300$$ENDHEX$$o '" + ls_Cd_Situacao_Tributaria + "' exige o valor da base de ICMS maior que zero."
			End If
			
			If IsNull(ldc_Vl_Icms) or ldc_Vl_Icms <= 0 Then
				as_Mensagem_Log ="ERRO  - A tributa$$HEX2$$e700e300$$ENDHEX$$o '" + ls_Cd_Situacao_Tributaria + "' exige o valor do ICMS maior que zero." + ls_Chave
				is_Divergencias_ST[ UpperBound(is_Divergencias_ST[])+1 ] = "Produto: "+String(ll_Cd_Produto)+" ERRO  - A tributa$$HEX2$$e700e300$$ENDHEX$$o '" + ls_Cd_Situacao_Tributaria + "' exige o valor do ICMS maior que zero."
			End If
		End If
				
		ldc_Vl_Outras_Despesas	= a_InfNFe.det[i].prod.vOutro // Valor total
		ldc_Pc_Icms_St 			= a_InfNFe.det[i].imposto.ICMS.pICMSST
		ls_Cd_Cst_Origem 			= String(a_InfNFe.det[i].imposto.ICMS.orig)
		ls_Cd_Cst_Tributacao		= a_InfNFe.det[i].imposto.ICMS.CST
		
		If ldc_Pc_Reducao_Base_Icms > 0 Then 
			ls_Id_Reducao_Base_Icms 	= "S" 
		Else 
			ls_Id_Reducao_Base_Icms 	= "N"
		End If
		
		If ls_ICMS_ST = 'S' Then

			If IsNull(ldc_Vl_Preco_Base_Icms_St ) or ldc_Vl_Preco_Base_Icms_St <= 0 Then
				as_Mensagem_Log ="ERRO  - A tributa$$HEX2$$e700e300$$ENDHEX$$o '" + ls_Cd_Situacao_Tributaria + "' exige o valor da base de ICMS ST maior que zero." + ls_Chave
				is_Divergencias_ST[ UpperBound(is_Divergencias_ST[])+1 ] = "Produto: "+String(ll_Cd_Produto)+" ERRO  - A tributa$$HEX2$$e700e300$$ENDHEX$$o '" + ls_Cd_Situacao_Tributaria + "' exige o valor da base de ICMS ST maior que zero."
			End If
			
			If IsNull(ldc_Vl_Icms_St) or ldc_Vl_Icms_St <= 0 Then
				//Calcula a ST
				ldc_ST_Aux = round(ldc_Vl_Preco_Base_Icms_St * (ldc_Pc_Icms_St / 100), 2) - ldc_Vl_Icms
				
				If ldc_ST_Aux <= 0.02 Then
					//ldc_Vl_Icms_St = 0.0 Colocar 1 centavo???
				Else
					as_Mensagem_Log ="ERRO  - A tributa$$HEX2$$e700e300$$ENDHEX$$o '" + ls_Cd_Situacao_Tributaria + "' exige o valor do ICMS ST maior que zero." + ls_Chave
					is_Divergencias_ST[ UpperBound(is_Divergencias_ST[])+1 ] = "Produto: "+String(ll_Cd_Produto)+" ERRO  - A tributa$$HEX2$$e700e300$$ENDHEX$$o '" + ls_Cd_Situacao_Tributaria + "' exige o valor do ICMS ST maior que zero."
				End If
			End If
		End If
			
		ldc_Vl_Preco_Unitario_Fiscal 	= (a_InfNFe.det[i].prod.vUnCom /  ll_Emb_Padrao) / ldc_Fator_Conversao 
		
		ll_Nr_Classificacao_Fiscal 	= a_InfNFe.det[i].prod.NCM
		
		// Chamado 807083: alterado para total, para poder fazer o ac$$HEX1$$fa00$$ENDHEX$$mulo correto
		ldc_Vl_Bc_Icms_St_Retido_Total 	= a_InfNFe.det[i].imposto.ICMS.vBCSTRet
		ldc_vl_icms_retido					= a_InfNFe.det[i].imposto.ICMS.vICMSSubstituto
		ldc_Vl_Icms_St_Retido_Total 		= a_InfNFe.det[i].imposto.ICMS.vICMSSTRet 
		
		//Limita as casas decimais
		ldc_Vl_Preco_Unitario 			= Round(ldc_Vl_Preco_Unitario ,2)
		ldc_Pc_Desconto 					= Round(ldc_Pc_Desconto ,2)
		ldc_Pc_Icms 						= Round(ldc_Pc_Icms ,2)
		ldc_Pc_Ipi 							= Round(ldc_Pc_Ipi ,2)
		ldc_Vl_Icms_Repassado 			= Round(ldc_Vl_Icms_Repassado ,2)
		ldc_Pc_Reducao_Base_Icms 	= Round(ldc_Pc_Reducao_Base_Icms ,2)
		ldc_Vl_Preco_Base_Icms_St 	= Round(ldc_Vl_Preco_Base_Icms_St ,2)
		ldc_Vl_Icms_St 					= Round(ldc_Vl_Icms_St ,2)
		ldc_Vl_Bc_Icms 					= Round(ldc_Vl_Bc_Icms ,4)
		ldc_Vl_Icms 						= Round(ldc_Vl_Icms ,4)
		ldc_Vl_Bc_Ipi 						= Round(ldc_Vl_Bc_Ipi ,4)
		ldc_Vl_Ipi 							= Round(ldc_Vl_Ipi ,4)
		ldc_Vl_Desconto_Total 			= Round(ldc_Vl_Desconto_Total ,2)
		ldc_Vl_Prod_Bruto					= Round(ldc_Vl_Prod_Bruto ,2)		
		ldc_Vl_Outras_Despesas 		= Round(ldc_Vl_Outras_Despesas ,2)		
		ldc_Pc_Icms_St 					= Round(ldc_Pc_Icms_St ,2)		
		ldc_Vl_Bc_Icms_St_Total 		= Round(ldc_Vl_Bc_Icms_St_Total ,2)
		ldc_Vl_Icms_St_Total 			= Round(ldc_Vl_Icms_St_Total ,2)		
		ldc_Vl_Preco_Unitario_Fiscal 	= Round(ldc_Vl_Preco_Unitario_Fiscal ,4)
		ldc_PMC								= Round(ldc_PMC, 2)
		ldc_Vl_BC_FCP						= Round(a_InfNFe.det[i].imposto.ICMS.VBCFCP	 / ll_qCom, 4)
		ldc_Pc_FCP							= Round(a_InfNFe.det[i].imposto.ICMS.PFCP, 2)
		ldc_Vl_FCP							= Round(a_InfNFe.det[i].imposto.ICMS.VFCP / ll_qCom, 4)
		ldc_Vl_BC_ST_FCP				= Round(a_InfNFe.det[i].imposto.ICMS.VBCFCPST, 4)
		ldc_Pc_ST_FCP						= Round(a_InfNFe.det[i].imposto.ICMS.PFCPST, 2)
		ldc_Vl_ST_FCP						= Round(a_InfNFe.det[i].imposto.ICMS.VFCPST, 4)
		ldc_Vl_BC_Ret_FCP				= Round(a_InfNFe.det[i].imposto.ICMS.VBCFCPSTRET / ll_qCom, 4)
		ldc_Pc_Ret_FCP					= Round(a_InfNFe.det[i].imposto.ICMS.PFCPSTRET, 2)
		ldc_Vl_Ret_FCP						= Round(a_InfNFe.det[i].imposto.ICMS.VFCPSTRET / ll_qCom, 4)
		ls_Cbenef							= a_InfNFe.det[i].prod.cBenef
		ls_cd_mod_bc_st					= String(a_InfNFe.det[i].imposto.ICMS.modBCST)
		ldc_pc_mva							= Round(a_InfNFe.det[i].imposto.ICMS.pMVAST, 4)
		
		If Trim(ls_Cbenef) = "" Then SetNull(ls_Cbenef)
		If Trim(ls_cd_mod_bc_st) = "" Then SetNull(ls_cd_mod_bc_st)
		
		If lvds.Retrieve(il_Filial, is_Fornecedor, il_Nf, is_Especie, is_Serie, ll_Cd_Produto) = -1 Then
			as_Mensagem_Log ="Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da dw_ge238_existe_produto."
			Return False
		End If
		
		/* PIS e COFINS de entrada */
		ls_CST_PIS_Entrada		= ls_Nulo
		ls_CST_COFINS_Entrada	= ls_Nulo
		//Soma campos que comp$$HEX1$$f500$$ENDHEX$$em a dedu$$HEX2$$e700e300$$ENDHEX$$o de ICMS na base PIS/COFINS (Lei 14.592/2023)
		ldc_Ded_ICMS_PIS_Cofins = gf_coalesce(a_InfNFe.det[i].imposto.ICMS.vICMS, 0) + &
											 gf_coalesce(a_InfNFe.det[i].imposto.ICMS.vFCP, 0)

		If Not lo_fiscal.of_retorna_tributacao_pis_cofins(	ll_Cd_Natureza_Operacao, ll_Cd_Produto, ldc_Vl_Prod_Bruto - ldc_Vl_Desconto_Total, ldc_Ded_ICMS_PIS_Cofins, &
																		ref ls_CST_PIS_Entrada, ref ldc_BC_PIS_Entrada,  ref ldc_PC_PIS_Entrada, &
																		ref ldc_VL_PIS_Entrada,	ref ls_CST_Cofins_Entrada, ref ldc_BC_Cofins_Entrada, &
																		ref ldc_PC_Cofins_Entrada, ref ldc_VL_Cofins_Entrada, False, Ref as_Mensagem_Log) Then
			Return False
		End If
		
		// PIS do XML
		Choose Case Lower(a_InfNFe.det[i].imposto.pis.tipopis)
			Case "pisnt"
				ls_CST_PIS_XML	=	a_InfNFe.det[i].imposto.pis.pisnt.cst
				ldc_BC_PIS_XML	=	0.00
				ldc_PC_PIS_XML	=	0.00
				ldc_VL_PIS_XML	=	0.00
			Case "pisaliq"
				ls_CST_PIS_XML	=	a_InfNFe.det[i].imposto.pis.pisaliq.cst
				ldc_BC_PIS_XML	=	round(a_InfNFe.det[i].imposto.pis.pisaliq.vbc, 2)
				ldc_PC_PIS_XML	=	round(a_InfNFe.det[i].imposto.pis.pisaliq.ppis, 2)
				ldc_VL_PIS_XML	=	round(a_InfNFe.det[i].imposto.pis.pisaliq.vpis, 4)
			Case "pisqtde"
				ls_CST_PIS_XML	=	a_InfNFe.det[i].imposto.pis.pisqtde.cst
				ldc_BC_PIS_XML	=	round(a_InfNFe.det[i].imposto.pis.pisqtde.qbcprod, 2)
				ldc_PC_PIS_XML	=	round(a_InfNFe.det[i].imposto.pis.pisqtde.valiqprod, 2)
				ldc_VL_PIS_XML	=	round(a_InfNFe.det[i].imposto.pis.pisqtde.vpis, 4)
			Case "pisoutr"
				ls_CST_PIS_XML	=	a_InfNFe.det[i].imposto.pis.pisoutr.cst
				ldc_BC_PIS_XML	=	round(a_InfNFe.det[i].imposto.pis.pisoutr.vbc, 2)
				ldc_PC_PIS_XML	=	round(a_InfNFe.det[i].imposto.pis.pisoutr.ppis, 2)
				ldc_VL_PIS_XML	=	round(a_InfNFe.det[i].imposto.pis.pisoutr.vpis, 4)
			Case  ""
				as_Mensagem_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do PIS e COFINS no XML."+ SqlCa.SQLErrText
			Return False
		End Choose
		
		// COFINS do XML
		Choose Case Lower(a_InfNFe.det[i].imposto.cofins.tipocofins)
			Case "cofinsnt"
				ls_CST_Cofins_XML	=	a_InfNFe.det[i].imposto.cofins.cofinsnt.cst
				ldc_BC_Cofins_XML	=	0.00
				ldc_PC_Cofins_XML	=	0.00
				ldc_VL_Cofins_XML	=	0.00
			Case "cofinsaliq"
				ls_CST_Cofins_XML	=	a_InfNFe.det[i].imposto.cofins.cofinsaliq.cst
				ldc_BC_Cofins_XML	=	round(a_InfNFe.det[i].imposto.cofins.cofinsaliq.vbc, 2)
				ldc_PC_Cofins_XML	=	round(a_InfNFe.det[i].imposto.cofins.cofinsaliq.pCofins, 2)
				ldc_VL_Cofins_XML	=	round(a_InfNFe.det[i].imposto.cofins.cofinsaliq.vCofins, 4)
			Case "cofinsqtde"
				ls_CST_Cofins_XML	=	a_InfNFe.det[i].imposto.cofins.cofinsqtde.cst
				ldc_BC_Cofins_XML	=	round(a_InfNFe.det[i].imposto.cofins.cofinsqtde.qbcprod, 2)
				ldc_PC_Cofins_XML	=	round(a_InfNFe.det[i].imposto.cofins.cofinsqtde.valiqprod, 2)
				ldc_VL_Cofins_XML	=	round(a_InfNFe.det[i].imposto.cofins.cofinsqtde.vcofins, 4)
			Case "cofinsoutr"
				ls_CST_Cofins_XML	=	a_InfNFe.det[i].imposto.cofins.cofinsoutr.cst
				ldc_BC_Cofins_XML	=	round(a_InfNFe.det[i].imposto.cofins.cofinsoutr.vbc, 2)
				ldc_PC_Cofins_XML	=	round(a_InfNFe.det[i].imposto.cofins.cofinsoutr.pcofins, 2)
				ldc_VL_Cofins_XML	=	round(a_InfNFe.det[i].imposto.cofins.cofinsoutr.vcofins, 4)
			Case  ""
				as_Mensagem_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do COFINS no XML."+ SqlCa.SQLErrText
			Return False
		End Choose
		
		ls_ModDC 					= String(a_InfNFe.det[i].imposto.icms.modbc)
		ldc_ICMS_Operacao 		= round(a_InfNFe.det[i].imposto.ICMS.vICMSOp, 4)
		ldc_Pc_Dif_Icms			= round(a_InfNFe.det[i].imposto.ICMS.pDif, 2)
		ldc_ICMS_Dif				= round(a_InfNFe.det[i].imposto.ICMS.vICMSDif,4)
		ldc_Vl_Icms_Desonerado	= round(a_InfNFe.det[i].imposto.ICMS.vICMSDeson,2)

		If a_InfNFe.det[i].imposto.ICMS.motDesICMS <> '' And Not IsNull(a_InfNFe.det[i].imposto.ICMS.motDesICMS) Then
			ll_Id_Motivo_Desoneracao_Icms = Long(a_InfNFe.det[i].imposto.ICMS.motDesICMS)
		Else
			Setnull(ll_Id_Motivo_Desoneracao_Icms)
		End If
		
		ll_Qtde		 = lvds.RowCount()
		
		//Se tiver ICMS ST, n$$HEX1$$e300$$ENDHEX$$o deve calcular antecipa$$HEX2$$e700e300$$ENDHEX$$o de ICMS
		If IsNull(ldc_Vl_Icms_St_Total) or (ldc_Vl_Icms_St_Total = 0.00) Then
			//2017.02.02 - Chamado 212416
			//Calcula Antecipa$$HEX2$$e700e300$$ENDHEX$$o de ICMS
			If Not IsValid(ivo_Fiscal) Then ivo_Fiscal = Create uo_tratamento_fiscal
			ivo_Fiscal.Of_Calcula_Antecipacao_ICMS( &	
					/* UF Origem Aquisi$$HEX2$$e700e300$$ENDHEX$$o */		ls_Uf_Origem,&
					/* UF Filial Destino */			ls_Uf_Destino,&
					/* C$$HEX1$$f300$$ENDHEX$$digo Produto */				ll_Cd_Produto,&
					/* CST NF	*/						Mid(ls_Cd_Situacao_Tributaria,2,1),&
					/* Qtde Produto */				ll_Qt_Faturada,&
					/* Valor Total do Prod. NF */	(ldc_Vl_Preco_Unitario * (1 - ldc_Pc_Desconto/100))+ ldc_Vl_Ipi + ldc_Vl_Outras_Despesas,& 
					/* Aliq. ICMS Destac. NF */	ldc_Pc_Icms,&
					/* Valor ICMS Destac. NF */	ldc_Vl_Icms,&
					/* Base ICMS Antecip. */		ref ldc_BC_Antecipa_ICMS, &
					/* MVA ICMS Antecip. */			ref ldc_MVA_Antecipa_ICMS,&
					/* Aliq. ICMS Antecip. */		ref ldc_Pc_Antecipa_ICMS,&
					/* Valor ICMS Antecip. */		ref ldc_Vl_Antecipa_ICMS)
		Else
			SetNull(ldc_BC_Antecipa_ICMS)
			SetNull(ldc_MVA_Antecipa_ICMS)
			SetNull(ldc_Pc_Antecipa_ICMS)
			SetNull(ldc_Vl_Antecipa_ICMS)
		End If
		
		//Chamado 	807083
		ldc_Vl_Bc_Icms_St_Retido_Unit	= Round(ldc_Vl_Bc_Icms_St_Retido_Total / ll_Qt_Faturada, 4)
		ldc_vl_icms_retido_unit			= Round(ldc_vl_icms_retido / ll_Qt_Faturada, 4)
		ldc_Vl_Icms_St_Retido_Unit		= Round(ldc_Vl_Icms_St_Retido_Total / ll_Qt_Faturada, 4)
		
		ll_qt_recebida_sap	= 0
		
		If ib_inicio_operacao_sap and il_Filial <> 534 Then
			select Sum(qt_recebida)
			  into :ll_qt_recebida_sap
			  from recebimento_sap_item
			 where nr_recebimento 	= :is_Recebimento_SAP and
					 cd_produto			= :ll_Cd_Produto;
			
			Choose Case sqlca.sqldbcode
				case -1
					as_mensagem_log = 'Erro ao buscar quantidade recebida do SAP para validar a inser$$HEX2$$e700e300$$ENDHEX$$o da nf_compra_pendente_prd_item. Produto: ' + String(ll_Cd_Produto) + '. Erro: ' + SQLCA.SqlErrText
					return false
				case 100
					as_mensagem_log = 'N$$HEX1$$e300$$ENDHEX$$o foi encontrado registro na recebimento_sap_item para validar a inser$$HEX2$$e700e300$$ENDHEX$$o da nf_compra_pendente_prd_item. Produto: ' + String(ll_Cd_Produto)
					return false
				case 0
					If ll_qt_recebida_sap <> ll_Qt_Faturada Then
						as_mensagem_log = 'As quantidades do recebimento_sap_item e da nf_compra_pendente_prd_item n$$HEX1$$e300$$ENDHEX$$o conferem. Produto: ' + String(ll_Cd_Produto)
						return false
					End If
			End Choose
		End If
		
		//IS
		ls_cd_cst_is						= a_InfNFe.det[i].imposto.ISEL.cstis
		ls_cd_classificacao_trib_is	= a_InfNFe.det[i].imposto.ISEL.cClassTribIS
		ldc_vl_bc_is						= a_InfNFe.det[i].imposto.ISEL.vBCIS
		ldc_pc_is							= a_InfNFe.det[i].imposto.ISEL.pIS
		ldc_pc_is_espec					= a_InfNFe.det[i].imposto.ISEL.pISEspec
		ls_cd_un_trib_is					= a_InfNFe.det[i].imposto.ISEL.uTrib
		ldc_qt_trib_is						= a_InfNFe.det[i].imposto.ISEL.qTrib
		ldc_vl_is							= a_InfNFe.det[i].imposto.ISEL.vIS

		//IBSCBS
		ls_cd_cst_ibscbs					= a_InfNFe.det[i].imposto.IBSCBS.CST
		ls_cd_class_trib_ibscbs			= a_InfNFe.det[i].imposto.IBSCBS.cClassTrib
		ldc_vl_bc_ibscbs					= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.vBC

		//IBSUF
		ldc_pc_ibs_uf						= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSUF.pibsuf
		ldc_vl_ibs_uf						= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSUF.vibsuf
		ldc_pc_dif_ibs_uf					= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSUF.gDif.pdif
		ldc_vl_dif_ibs_uf					= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSUF.gDif.vdif
		ldc_vl_dev_trib_ibs_uf			= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSUF.gDevTrib.vdevtrib
		ldc_pc_reducao_ibs_uf			= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSUF.gred.predaliq
		ldc_pc_efetiva_ibs_uf			= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSUF.gred.paliqefet
		
		//IBSMUN
		ldc_pc_ibs_mun						= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSMun.pibsmun
		ldc_vl_ibs_mun						= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSMun.vibsmun
		ldc_pc_dif_ibs_mun 				= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSMun.gDif.pdif
		ldc_vl_dif_ibs_mun				= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSMun.gDif.vdif
		ldc_vl_dev_trib_ibs_mun			= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSMun.gDevTrib.vdevtrib
		ldc_pc_reducao_ibs_mun			= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSMun.gred.predaliq
		ldc_pc_efetiva_ibs_mun			= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSMun.gred.paliqefet

		//IBS
		ldc_vl_ibs							= ldc_vl_ibs_mun + ldc_vl_ibs_uf

		//CBS
		ldc_pc_cbs							= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gCBS.pcbs
		ldc_pc_dif_cbs						= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gCBS.gDif.pdif
		ldc_vl_dif_cbs						= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gCBS.gDif.vdif
		ldc_vl_dev_trib_cbs				= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gCBS.gDevTrib.vdevtrib
		ldc_pc_reducao_cbs				= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gCBS.gred.predaliq
		ldc_pc_efetiva_cbs				= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gCBS.gred.paliqefet
		ldc_vl_cbs 							= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gCBS.vcbs
		
		//IBSCBS Regular
		ls_cd_cst_ibscbs_reg 			= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gtribregular.cstreg
		ls_cd_class_trib_ibscbs_reg	= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gtribregular.cClassTribReg

		//IBSUF
		ldc_pc_efetiva_reg_ibs_uf		= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gtribregular.pAliqEfetRegIBSUF
		ldc_vl_trib_reg_ibs_uf			= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gtribregular.vTribRegIBSUF
		
		//IBSMUN
		ldc_pc_efetiva_reg_ibs_mun		= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gtribregular.pAliqEfetRegIBSMun
		ldc_vl_trib_reg_ibs_mun			= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gtribregular.vTribRegIBSMun
		
		//CBS
		ldc_pc_efetiva_reg_cbs			= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gtribregular.pAliqEfetRegCBS
		ldc_vl_trib_reg_cbs				= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gtribregular.vTribRegCBS

		
		/***************Insere os dados dos itens da nota itegralmente********************/
		Insert into nf_compra_pendente_prd_item (
			cd_filial,
			cd_fornecedor,
			nr_nf,
			de_especie,
			de_serie,
			cd_produto,
			qt_faturada,
			vl_preco_unitario,
			pc_desconto,
			pc_icms,
			pc_ipi,
			vl_icms_repassado,
			pc_reducao_base_icms,
			vl_bc_icms,
			vl_icms,
			vl_bc_ipi,
			vl_ipi,
			vl_outras_despesas,
			pc_icms_st,
			vl_bc_icms_st_total,
			vl_icms_st_total,
			cd_cst_origem,
			cd_cst_tributacao,
			vl_bc_icms_st_retido,
			vl_icms_st_retido,
			vl_bc_icms_antecipacao,
			pc_mva_icms_antecipacao,
			pc_icms_antecipacao,
			vl_icms_antecipacao,
			vl_bc_fcp,
			pc_fcp,
			vl_fcp,
			vl_bc_st_fcp,
			pc_st_fcp,
			vl_st_fcp,
			vl_bc_ret_fcp,
			pc_ret_fcp,
			vl_ret_fcp,
			nr_sequencial,
			vl_desconto_total,
			vl_total_item,
			cd_unidade_comercial,
			cd_unidade_tributavel,
			qt_comercial,
			qt_tributavel,
			cd_cest,
			vl_icms_retido,
			pc_st_retido,
			cd_cst_pis_entrada,
			vl_bc_pis_entrada,
			pc_pis_entrada,
			vl_pis_entrada,
			cd_cst_cofins_entrada,
			vl_bc_cofins_entrada,
			pc_cofins_entrada,
			vl_cofins_entrada,
			vl_bc_pis_xml,
			pc_pis_xml,
			vl_pis,
			vl_bc_cofins_xml,
			pc_cofins_xml,
			vl_cofins,
			vl_icms_operacao,
			pc_icms_diferido,
			vl_icms_diferido,
			vl_icms_desonerado,
			id_motivo_desoneracao_icms,
			cd_cst_is,
			cd_classificacao_trib_is,
			vl_bc_is,
			pc_is,
			pc_is_espec,
			cd_un_trib_is,
			qt_trib_is,
			vl_is,
			cd_cst_ibscbs,
			cd_class_trib_ibscbs,
			vl_bc_ibscbs,
			vl_ibs,
			pc_ibs_uf,
			vl_ibs_uf,
			pc_dif_ibs_uf,
			vl_dif_ibs_uf,
			vl_dev_trib_ibs_uf,
			pc_reducao_ibs_uf,
			pc_efetiva_ibs_uf,
			pc_ibs_mun,
			vl_ibs_mun,
			pc_dif_ibs_mun,
			vl_dif_ibs_mun,
			vl_dev_trib_ibs_mun,
			pc_reducao_ibs_mun,
			pc_efetiva_ibs_mun,
			pc_cbs,
			pc_dif_cbs,
			vl_dif_cbs,
			vl_dev_trib_cbs,
			pc_reducao_cbs,
			pc_efetiva_cbs,
			vl_cbs,
			cd_cst_ibscbs_reg,
			cd_class_trib_ibscbs_reg,
			pc_efetiva_reg_ibs_uf,
			vl_trib_reg_ibs_uf,
			pc_efetiva_reg_ibs_mun,
			vl_trib_reg_ibs_mun,
			pc_efetiva_reg_cbs,
			vl_trib_reg_cbs)
		Values(
			:il_Filial,
			:is_Fornecedor,
			:il_Nf,
			:is_Especie,
			:is_Serie,
			:ll_Cd_Produto,
			:ll_Qt_Faturada,
			:ldc_Vl_Preco_Unitario_Fiscal,
			Round(:ldc_Pc_Desconto,2),
			Round(:ldc_Pc_Icms,2),
			Round(:ldc_Pc_Ipi,2) ,
			Round(:ldc_Vl_Icms_Repassado,2),
			Round(:ldc_Pc_Reducao_Base_Icms,2),
			Round(:ldc_Vl_Bc_Icms_Origem,2),
			Round(:ldc_Vl_Icms_Origem,2),
			Round(:ldc_Vl_Bc_Ipi_Origem,2),
			Round(:ldc_Vl_Ipi_Origem,2),
			Round(:ldc_Vl_Outras_Despesas,2),
			Round(:ldc_Pc_Icms_St,2),
			Round(:ldc_Vl_Bc_Icms_St_Total,2),
			Round(:ldc_Vl_Icms_St_Total,2),
			:ls_Cd_Cst_Origem,
			:ls_Cd_Cst_Tributacao,
			Round(:ll_Qt_Faturada * :ldc_Vl_Bc_Icms_St_Retido_Unit,2),
			Round(:ll_Qt_Faturada * :ldc_Vl_Icms_St_Retido_Unit,2),
			Round(:ldc_BC_Antecipa_ICMS,2),
			Round(:ldc_MVA_Antecipa_ICMS,2),
			Round(:ldc_Pc_Antecipa_ICMS,2),
			Round(:ldc_Vl_Antecipa_ICMS,2),
			Round(:ldc_Vl_BC_FCP,2),
			Round(:ldc_Pc_FCP,2),
			Round(:ldc_Vl_FCP,2),
			Round(:ldc_Vl_BC_ST_FCP,2),
			Round(:ldc_Pc_ST_FCP,2),
			Round(:ldc_Vl_ST_FCP,2),
			Round(:ldc_Vl_BC_Ret_FCP,2),
			Round(:ldc_Pc_Ret_FCP,2),
			Round(:ldc_Vl_Ret_FCP, 2),
			:ll_NrItem,
			:ldc_Vl_Desconto_Total,
			:ldc_Vl_Prod_Bruto,
			:ls_cd_unidade_comercial,
			:ls_cd_unidade_tributavel,
			:ldc_qt_comercial,
			:ldc_qt_tributavel,
			:ls_cd_cest,
			Round(:ldc_vl_icms_retido, 2),
			Round(:ldc_pc_st_retido, 2),
			:ls_CST_PIS_Entrada,
			Round(:ldc_BC_PIS_Entrada, 2),
			Round(:ldc_PC_PIS_Entrada, 2),
			Round(:ldc_VL_PIS_Entrada, 2),
			:ls_CST_COFINS_Entrada,
			Round(:ldc_BC_COFINS_Entrada, 2),
			Round(:ldc_PC_COFINS_Entrada, 2),
			Round(:ldc_VL_COFINS_Entrada, 2),
			:ldc_BC_PIS_XML,
			:ldc_PC_PIS_XML,
			Round(:ldc_VL_PIS_XML, 2),
			:ldc_BC_COFINS_XML,
			:ldc_PC_COFINS_XML,
			Round(:ldc_VL_COFINS_XML, 2),
			:ldc_ICMS_Operacao,
			:ldc_Pc_Dif_Icms,
			:ldc_ICMS_Dif,
			:ldc_Vl_Icms_Desonerado,
			:ll_Id_Motivo_Desoneracao_Icms,
			:ls_cd_cst_is,
			:ls_cd_classificacao_trib_is,
			:ldc_vl_bc_is,
			:ldc_pc_is,
			:ldc_pc_is_espec,
			:ls_cd_un_trib_is,
			:ldc_qt_trib_is,
			:ldc_vl_is,
			:ls_cd_cst_ibscbs,
			:ls_cd_class_trib_ibscbs,
			:ldc_vl_bc_ibscbs,
			:ldc_vl_ibs,
			:ldc_pc_ibs_uf,
			:ldc_vl_ibs_uf,
			:ldc_pc_dif_ibs_uf,
			:ldc_vl_dif_ibs_uf,
			:ldc_vl_dev_trib_ibs_uf,
			:ldc_pc_reducao_ibs_uf,
			:ldc_pc_efetiva_ibs_uf,
			:ldc_pc_ibs_mun,
			:ldc_vl_ibs_mun,
			:ldc_pc_dif_ibs_mun,
			:ldc_vl_dif_ibs_mun,
			:ldc_vl_dev_trib_ibs_mun,
			:ldc_pc_reducao_ibs_mun,
			:ldc_pc_efetiva_ibs_mun,
			:ldc_pc_cbs,
			:ldc_pc_dif_cbs,
			:ldc_vl_dif_cbs,
			:ldc_vl_dev_trib_cbs,
			:ldc_pc_reducao_cbs,
			:ldc_pc_efetiva_cbs,
			:ldc_vl_cbs,
			:ls_cd_cst_ibscbs_reg,
			:ls_cd_class_trib_ibscbs_reg,
			:ldc_pc_efetiva_reg_ibs_uf,
			:ldc_vl_trib_reg_ibs_uf,
			:ldc_pc_efetiva_reg_ibs_mun,
			:ldc_vl_trib_reg_ibs_mun,
			:ldc_pc_efetiva_reg_cbs,
			:ldc_vl_trib_reg_cbs)
		Using SqlCa;
			
		If SqlCa.SqlCode = -1 Then
			as_Mensagem_Log = "Erro no insert: nf_compra_pendente_prd_item"+ String(ll_Cd_Produto) +": "+ SqlCa.SQLErrText
			Return False
		End If
		
		ll_Qt_Faturada_Xml			= a_InfNFe.det[i].prod.qCom
		ldc_Vl_Preco_Unitario_Xml	= Round(a_InfNFe.det[i].prod.vUnCom, 2)
		ldc_Vl_Bc_St_Xml				= Round(a_InfNFe.det[i].imposto.ICMS.vBCST, 2)
		ldc_Vl_Bc_Icms_Xml			= Round(a_InfNFe.det[i].imposto.ICMS.vBC, 4)
		ldc_Vl_Icms_Xml				= Round(a_InfNFe.det[i].imposto.ICMS.vICMS, 4)
		ldc_Vl_Bc_Ipi_Xml				= Round(a_InfNFe.det[i].imposto.IPI.IPITrib.vBC, 4)
		ldc_Vl_Ipi_Xml					= Round(a_InfNFe.det[i].imposto.IPI.IPITrib.vIPI, 4)
		ldc_vl_icms_retido_unit		= Round(ldc_vl_icms_retido_unit, 2)
		ldc_Vl_BC_ST_FCP				= round(a_InfNFe.det[i].imposto.ICMS.VBCFCPST / ll_qCom, 4)
		ldc_Vl_ST_FCP					= round(a_InfNFe.det[i].imposto.ICMS.VFCPST / ll_qCom, 4)
		ldc_VL_PIS_Entrada			= Round(ldc_VL_PIS_Entrada, 2)
		ldc_VL_Cofins_Entrada		= Round(ldc_VL_Cofins_Entrada, 2)
				
		If ll_Qtde = 0 Then
			if (ll_Cd_Natureza_Operacao = 1556 or ll_Cd_Natureza_Operacao = 2556 or ll_Cd_Natureza_Operacao = 1407 or ll_Cd_Natureza_Operacao = 2407) &
				and is_id_fornecedor_uso_consumo = 'S' then
				ls_Cd_Situacao_Tributaria	= '90'
			end if
			
			Insert into nf_compra_pendente_produto(
				cd_filial,
				cd_fornecedor,
				nr_nf,
				de_especie,
				de_serie,
				cd_natureza_operacao,
				cd_produto,
				cd_situacao_tributaria,
				qt_faturada,
				qt_recebida,
				vl_preco_unitario,
				pc_desconto,
				pc_icms,
				pc_ipi,
				vl_icms_repassado,
				id_lista_pis_cofins,
				pc_reducao_base_icms,
				vl_preco_base_icms_st,
				vl_icms_st,
				vl_bc_icms,
				vl_icms,
				vl_bc_ipi,
				vl_ipi,
				vl_outras_despesas,
				pc_icms_st,
				vl_bc_icms_st_total,
				vl_icms_st_total,
				cd_cst_origem,
				cd_cst_tributacao,
				id_reducao_base_icms,
				vl_preco_unitario_fiscal,
				nr_classificacao_fiscal,
				vl_bc_icms_st_retido,
				vl_icms_st_retido,
				cd_mod_bc_icms,
				vl_icms_operacao,
				pc_dif_icms,
				vl_icms_dif,
				vl_bc_icms_antecipacao,
				pc_mva_icms_antecipacao,
				pc_icms_antecipacao,
				vl_icms_antecipacao,
				vl_bc_fcp,
				pc_fcp,
				vl_fcp,
				vl_bc_st_fcp,
				pc_st_fcp,
				vl_st_fcp,
				vl_bc_ret_fcp,
				pc_ret_fcp,
				vl_ret_fcp,
				nr_sequencial,
				vl_desconto_total,
				vl_total_item,
				cd_unidade_comercial,
				cd_unidade_tributavel,
				qt_comercial,
				qt_tributavel,
				cd_beneficio,
				cd_mod_bc_st,
				pc_mva,
				vl_pmc,
				vl_icms_desonerado,
				id_motivo_desoneracao_icms,
				cd_cest,
				qt_faturada_original,
				vl_preco_unitario_original,
				vl_preco_base_st_original,
				vl_bc_icms_original,
				vl_icms_original,
				vl_bc_ipi_original,
				vl_ipi_original,
				vl_icms_retido,
				pc_st_retido,
				cd_cst_pis_entrada,
				vl_bc_pis_entrada,
				pc_pis_entrada,
				vl_pis_entrada,
				cd_cst_cofins_entrada,
				vl_bc_cofins_entrada,
				pc_cofins_entrada,
				vl_cofins_entrada,
				cd_cst_pis,
				vl_bc_pis_xml,
				pc_pis_xml,
				vl_pis,
				cd_cst_cofins,
				vl_bc_cofins_xml,
				pc_cofins_xml,
				vl_cofins,
				cd_natureza_operacao_xml,
				cd_cst_is,
				cd_classificacao_trib_is,
				vl_bc_is,
				pc_is,
				pc_is_espec,
				cd_un_trib_is,
				qt_trib_is,
				vl_is,
				cd_cst_ibscbs,
				cd_class_trib_ibscbs,
				vl_bc_ibscbs,
				vl_ibs,
				pc_ibs_uf,
				vl_ibs_uf,
				pc_dif_ibs_uf,
				vl_dif_ibs_uf,
				vl_dev_trib_ibs_uf,
				pc_reducao_ibs_uf,
				pc_efetiva_ibs_uf,
				pc_ibs_mun,
				vl_ibs_mun,
				pc_dif_ibs_mun,
				vl_dif_ibs_mun,
				vl_dev_trib_ibs_mun,
				pc_reducao_ibs_mun,
				pc_efetiva_ibs_mun,
				pc_cbs,
				pc_dif_cbs,
				vl_dif_cbs,
				vl_dev_trib_cbs,
				pc_reducao_cbs,
				pc_efetiva_cbs,
				vl_cbs,
				cd_cst_ibscbs_reg,
				cd_class_trib_ibscbs_reg,
				pc_efetiva_reg_ibs_uf,
				vl_trib_reg_ibs_uf,
				pc_efetiva_reg_ibs_mun,
				vl_trib_reg_ibs_mun,
				pc_efetiva_reg_cbs,
				vl_trib_reg_cbs)
			Values(	
				:il_Filial,
				:is_Fornecedor,
				:il_Nf,
				:is_Especie,
				:is_Serie,
				:ll_Cd_Natureza_Operacao,
				:ll_Cd_Produto,
				:ls_Cd_Situacao_Tributaria,
				:ll_Qt_Faturada,
				:ll_Qt_Recebida,
				:ldc_Vl_Preco_Unitario,
				:ldc_Pc_Desconto,
				:ldc_Pc_Icms,
				:ldc_Pc_Ipi,
				:ldc_Vl_Icms_Repassado,
				:ls_Id_Lista_Pis_Cofins,
				:ldc_Pc_Reducao_Base_Icms,
				:ldc_Vl_Preco_Base_Icms_St,
				:ldc_Vl_Icms_St,
				:ldc_Vl_Bc_Icms,
				:ldc_Vl_Icms,
				:ldc_Vl_Bc_Ipi,
				:ldc_Vl_Ipi,
				:ldc_Vl_Outras_Despesas,
				:ldc_Pc_Icms_St,
				:ldc_Vl_Bc_Icms_St_Total,
				:ldc_Vl_Icms_St_Total,
				:ls_Cd_Cst_Origem,
				:ls_Cd_Cst_Tributacao	,
				:ls_Id_Reducao_Base_Icms,
				:ldc_Vl_Preco_Unitario_Fiscal,
				:ll_Nr_Classificacao_Fiscal,
				:ldc_Vl_Bc_Icms_St_Retido_Unit,
				:ldc_Vl_Icms_St_Retido_Unit,
				:ls_ModDC,
				:ldc_ICMS_Operacao,
				:ldc_Pc_Dif_Icms, 
				:ldc_ICMS_Dif,
				:ldc_BC_Antecipa_ICMS,
				:ldc_MVA_Antecipa_ICMS,
				:ldc_Pc_Antecipa_ICMS,
				:ldc_Vl_Antecipa_ICMS,
				:ldc_Vl_BC_FCP,
				:ldc_Pc_FCP,
				:ldc_Vl_FCP,
				:ldc_Vl_BC_ST_FCP,
				:ldc_Pc_ST_FCP,
				:ldc_Vl_ST_FCP,
				:ldc_Vl_BC_Ret_FCP,
				:ldc_Pc_Ret_FCP,
				:ldc_Vl_Ret_FCP, 
				:ll_NrItem,
				:ldc_Vl_Desconto_Total,
				:ldc_Vl_Prod_Bruto,
				:ls_cd_unidade_comercial,	
				:ls_cd_unidade_tributavel,	
				:ldc_qt_comercial,			
				:ldc_qt_tributavel,
				:ls_Cbenef,
				:ls_cd_mod_bc_st,
				:ldc_pc_mva,
				:ldc_PMC,
				:ldc_Vl_Icms_Desonerado,
				:ll_Id_Motivo_Desoneracao_Icms,
				:ls_cd_cest,
				:ll_Qt_Faturada_Xml,
				:ldc_Vl_Preco_Unitario_Xml,
				:ldc_Vl_Bc_St_Xml,
				:ldc_Vl_Bc_Icms_Xml,
				:ldc_Vl_Icms_Xml,
				:ldc_Vl_Bc_Ipi_Xml,
				:ldc_Vl_Ipi_Xml,
				:ldc_vl_icms_retido_unit,
				:ldc_pc_st_retido,
				:ls_CST_PIS_Entrada,
				Round(:ldc_BC_PIS_Entrada, 2),
				:ldc_PC_PIS_Entrada,
				Round(:ldc_VL_PIS_Entrada, 2),
				:ls_CST_COFINS_Entrada,
				Round(:ldc_BC_COFINS_Entrada, 2),
				:ldc_PC_COFINS_Entrada,
				Round(:ldc_VL_COFINS_Entrada, 2),
				:ls_CST_PIS_XML,
				:ldc_BC_PIS_XML,
				:ldc_PC_PIS_XML,
				:ldc_VL_PIS_XML,
				:ls_CST_COFINS_XML,
				:ldc_BC_COFINS_XML,
				:ldc_PC_COFINS_XML,
				:ldc_VL_COFINS_XML,
				:ll_CFOP_XML,
				:ls_cd_cst_is,
				:ls_cd_classificacao_trib_is,
				:ldc_vl_bc_is,
				:ldc_pc_is,
				:ldc_pc_is_espec,
				:ls_cd_un_trib_is,
				:ldc_qt_trib_is,
				:ldc_vl_is,
				:ls_cd_cst_ibscbs,
				:ls_cd_class_trib_ibscbs,
				:ldc_vl_bc_ibscbs,
				:ldc_vl_ibs,
				:ldc_pc_ibs_uf,
				:ldc_vl_ibs_uf,
				:ldc_pc_dif_ibs_uf,
				:ldc_vl_dif_ibs_uf,
				:ldc_vl_dev_trib_ibs_uf,
				:ldc_pc_reducao_ibs_uf,
				:ldc_pc_efetiva_ibs_uf,
				:ldc_pc_ibs_mun,
				:ldc_vl_ibs_mun,
				:ldc_pc_dif_ibs_mun,
				:ldc_vl_dif_ibs_mun,
				:ldc_vl_dev_trib_ibs_mun,
				:ldc_pc_reducao_ibs_mun,
				:ldc_pc_efetiva_ibs_mun,
				:ldc_pc_cbs,
				:ldc_pc_dif_cbs,
				:ldc_vl_dif_cbs,
				:ldc_vl_dev_trib_cbs,
				:ldc_pc_reducao_cbs,
				:ldc_pc_efetiva_cbs,
				:ldc_vl_cbs,
				:ls_cd_cst_ibscbs_reg,
				:ls_cd_class_trib_ibscbs_reg,
				:ldc_pc_efetiva_reg_ibs_uf,
				:ldc_vl_trib_reg_ibs_uf,
				:ldc_pc_efetiva_reg_ibs_mun,
				:ldc_vl_trib_reg_ibs_mun,
				:ldc_pc_efetiva_reg_cbs,
				:ldc_vl_trib_reg_cbs)
			Using SqlCa;
		Else
			If Not ib_Icms_Diferenca Then			
				Select	pc_icms,
						vl_preco_unitario
				Into	:ldc_Pc_Icms_Conf,
						:ldc_Vl_Preco_Unitario_Conf
				From nf_compra_pendente_produto
				Where cd_filial      		= :il_Filial
	  				And cd_fornecedor	= :is_Fornecedor
	 				And nr_nf				= :il_Nf
					And de_especie		= :is_Especie
					And de_serie			= :is_Serie
					And cd_produto		= :ll_Cd_Produto
				Using SqlCa;			
				
				If ldc_Pc_Icms_Conf <> ldc_Pc_Icms or ldc_Vl_Preco_Unitario_Conf <> ldc_Vl_Preco_Unitario Then
					ib_Icms_Diferenca = True
				End If
				
				If SqlCa.SqlCode = -1 Then
					as_Mensagem_Log = "Erro ao localizar o PC ICMS do produto '" + String(ll_Cd_Produto) + "'." + SqlCa.SQLErrText
					Return False
				End If
			End If
			
			ll_Qt_Faturada 						+= lvds.Object.qt_faturada[1]
			ll_Qt_Recebida        				+= lvds.Object.qt_recebida[1]
			ldc_Vl_Outras_Despesas 				+= lvds.Object.Vl_Outras_Despesas[1]
			ldc_Vl_Bc_Icms_St_Total				+= lvds.Object.vl_bc_icms_st_total[1]
			ldc_Vl_Icms_St_Total 				+= lvds.Object.Vl_Icms_St_Total[1]
			
			//Chamado 807083: Acumula o total e depois divide o acumulado total pela quantidade total para obter uma m$$HEX1$$e900$$ENDHEX$$dia ponderada
			ldc_Vl_Bc_Icms_St_Retido_Total 	+= (lvds.Object.Vl_Bc_Icms_St_Retido[1] * lvds.Object.qt_faturada[1] ) 
			ldc_Vl_Icms_St_Retido_Total		+= (lvds.Object.Vl_Icms_St_Retido[1] * lvds.Object.qt_faturada[1] )  
			ldc_Vl_Bc_Icms_St_Retido_Unit		= Round(ldc_Vl_Bc_Icms_St_Retido_Total / ll_Qt_Faturada, 4)  
			ldc_Vl_Icms_St_Retido_Unit			= Round(ldc_Vl_Icms_St_Retido_Total / ll_Qt_Faturada, 4) 
			ldc_vl_icms_retido_unit				= Round(ldc_vl_icms_retido_unit, 2)
			
			//PIS e COFINS
			ldc_BC_PIS_XML				+= lvds.Object.vl_bc_pis_xml[1]
			ldc_VL_PIS_XML				+= lvds.Object.vl_pis[1]
			ldc_BC_Cofins_XML			+= lvds.Object.vl_bc_cofins_xml[1]
			ldc_VL_Cofins_XML			+= lvds.Object.vl_cofins[1]
			ldc_BC_PIS_Entrada		+= lvds.Object.vl_bc_pis_entrada[1]
			ldc_VL_PIS_Entrada		+= lvds.Object.vl_pis_entrada[1]
			ldc_BC_Cofins_Entrada	+= lvds.Object.vl_bc_cofins_entrada[1]
			ldc_VL_Cofins_Entrada	+= lvds.Object.vl_cofins_entrada[1]
			
			// Novos Campos
			ldc_Vl_Desconto_Total			+= lvds.Object.vl_desconto_total[1]
			ldc_Vl_Prod_Bruto					+= lvds.Object.vl_total_item[1]
			ldc_qt_tributavel					+= lvds.Object.qt_tributavel[1]
			ldc_qt_comercial					+= lvds.Object.qt_comercial[1]
			ldc_Vl_Icms_Desonerado    		+= lvds.Object.vl_icms_desonerado[1]
			ldc_ICMS_Dif						+= lvds.Object.vl_icms_dif[1]
			ll_Qt_Faturada_Xml				+= lvds.Object.qt_faturada_original[1]
			ldc_Vl_Bc_St_Xml					+= lvds.Object.vl_preco_base_st_original[1]
			ldc_Vl_Bc_Icms_Xml				+= lvds.Object.vl_bc_icms_original[1]
			ldc_Vl_Icms_Xml					+= lvds.Object.vl_icms_original[1]
			ldc_Vl_Bc_Ipi_Xml					+= lvds.Object.vl_bc_ipi_original[1]
			ldc_Vl_Ipi_Xml						+= lvds.Object.vl_ipi_original[1]
			
			update 
				nf_compra_pendente_produto
			set 
				qt_faturada						= :ll_Qt_Faturada,
				qt_recebida						= :ll_Qt_Recebida,
				vl_outras_despesas 			= :ldc_Vl_Outras_Despesas,
				vl_bc_icms_st_total 			= :ldc_Vl_Bc_Icms_St_Total,
				vl_icms_st_total 				= :ldc_Vl_Icms_St_Total,
				vl_bc_icms_st_retido			= :ldc_Vl_Bc_Icms_St_Retido_Unit,
				vl_icms_st_retido 			= :ldc_Vl_Icms_St_Retido_Unit, 			 
				vl_desconto_total				= :ldc_Vl_Desconto_Total,
				vl_total_item					= :ldc_Vl_Prod_Bruto,
				qt_comercial					= :ldc_qt_comercial,				
				qt_tributavel					= :ldc_qt_tributavel,
				vl_icms_desonerado			= :ldc_Vl_Icms_Desonerado,
				qt_faturada_original			= :ll_Qt_Faturada_Xml,
				vl_preco_base_st_original	= :ldc_Vl_Bc_St_Xml,
				vl_bc_icms_original			= :ldc_Vl_Bc_Icms_Xml,
				vl_icms_original				= :ldc_Vl_Icms_Xml,
				vl_bc_ipi_original			= :ldc_Vl_Bc_Ipi_Xml,
				vl_ipi_original				= :ldc_Vl_Ipi_Xml,
				vl_icms_retido					= :ldc_vl_icms_retido_unit,
				vl_bc_pis_entrada				= Round(:ldc_BC_PIS_Entrada, 2),
				vl_pis_entrada					= Round(:ldc_VL_PIS_Entrada, 2),
				vl_bc_cofins_entrada			= Round(:ldc_BC_Cofins_Entrada, 2),
				vl_cofins_entrada				= Round(:ldc_VL_Cofins_Entrada, 2),
				vl_bc_pis_xml					= :ldc_BC_PIS_XML,
				vl_pis							= :ldc_VL_PIS_XML,
				vl_bc_cofins_xml				= :ldc_BC_Cofins_XML,
				vl_cofins						= :ldc_VL_Cofins_XML,
				vl_icms_dif						= :ldc_ICMS_Dif,
				cd_cst_is 						= :ls_cd_cst_is,
			 	cd_classificacao_trib_is 	= :ls_cd_classificacao_trib_is,
			 	vl_bc_is 						= :ldc_vl_bc_is,
			 	pc_is 							= :ldc_pc_is,
			 	pc_is_espec 					= :ldc_pc_is_espec,
			 	cd_un_trib_is 					= :ls_cd_un_trib_is,
			 	qt_trib_is 						= :ldc_qt_trib_is,
			 	vl_is 							= :ldc_vl_is,
			 	cd_cst_ibscbs 					= :ls_cd_cst_ibscbs,
			 	cd_class_trib_ibscbs 		= :ls_cd_class_trib_ibscbs,
			 	vl_bc_ibscbs 					= :ldc_vl_bc_ibscbs,
			 	vl_ibs 							= :ldc_vl_ibs,
			 	pc_ibs_uf 						= :ldc_pc_ibs_uf,
			 	vl_ibs_uf 						= :ldc_vl_ibs_uf,
			 	pc_dif_ibs_uf 					= :ldc_pc_dif_ibs_uf,
			 	vl_dif_ibs_uf 					= :ldc_vl_dif_ibs_uf,
			 	vl_dev_trib_ibs_uf 			= :ldc_vl_dev_trib_ibs_uf,
			 	pc_reducao_ibs_uf 			= :ldc_pc_reducao_ibs_uf,
			 	pc_efetiva_ibs_uf 			= :ldc_pc_efetiva_ibs_uf,
			 	pc_ibs_mun 						= :ldc_pc_ibs_mun,
			 	vl_ibs_mun 						= :ldc_vl_ibs_mun,
			 	pc_dif_ibs_mun 				= :ldc_pc_dif_ibs_mun,
			 	vl_dif_ibs_mun 				= :ldc_vl_dif_ibs_mun,
			 	vl_dev_trib_ibs_mun 			= :ldc_vl_dev_trib_ibs_mun,
			 	pc_reducao_ibs_mun 			= :ldc_pc_reducao_ibs_mun,
			 	pc_efetiva_ibs_mun 			= :ldc_pc_efetiva_ibs_mun,
			 	pc_cbs 							= :ldc_pc_cbs,
			 	pc_dif_cbs 						= :ldc_pc_dif_cbs,
			 	vl_dif_cbs 						= :ldc_vl_dif_cbs,
			 	vl_dev_trib_cbs				= :ldc_vl_dev_trib_cbs,
			 	pc_reducao_cbs 				= :ldc_pc_reducao_cbs,
			 	pc_efetiva_cbs 				= :ldc_pc_efetiva_cbs,
			 	vl_cbs 							= :ldc_vl_cbs,
			 	cd_cst_ibscbs_reg 			= :ls_cd_cst_ibscbs_reg,
			 	cd_class_trib_ibscbs_reg 	= :ls_cd_class_trib_ibscbs_reg,
			 	pc_efetiva_reg_ibs_uf 		= :ldc_pc_efetiva_reg_ibs_uf,
				vl_trib_reg_ibs_uf 			= :ldc_vl_trib_reg_ibs_uf,
				pc_efetiva_reg_ibs_mun 		= :ldc_pc_efetiva_reg_ibs_mun,
				vl_trib_reg_ibs_mun 			= :ldc_vl_trib_reg_ibs_mun,
				pc_efetiva_reg_cbs 			= :ldc_pc_efetiva_reg_cbs,
				vl_trib_reg_cbs 				= :ldc_vl_trib_reg_cbs
			where 
				cd_filial   					= :il_Filial
				and cd_fornecedor 			= :is_Fornecedor
				and nr_nf         			= :il_Nf
				and de_especie    			= :is_Especie
				and de_serie      			= :is_Serie
				and cd_produto 				= :ll_Cd_Produto			 
			Using SqlCa;
		End If
	
		Choose Case SqlCa.SqlCode 
			Case -1
				as_Mensagem_Log = "Erro no insert/update do produto "+ String(ll_Cd_Produto) +": "+ SqlCa.SQLErrText
				Return False
			Case 0
				If Not of_Insere_Lotes(ll_Cd_Natureza_Operacao, ll_Cd_Produto, ldc_Fator_Conversao, a_InfNFe.det[i].prod, Ref ls_Mensagem_Log, ll_Emb_Padrao, ll_Qt_Faturada) Then
					as_Mensagem_Log = ls_Mensagem_Log
					Return False	
				End If
		End Choose		
	Next
	
	If UpperBound(is_Divergencias_ST[]) > 0 Then
		of_Envia_Email_Divergencias_ST()	
	End If
	
	If Not of_Valida_Valores_Nota(il_Filial,is_Fornecedor,il_Nf,is_Especie,is_Serie, as_Mensagem_Log) Then
		Return False
	End If
	
	Return True
Catch (RunTimeError lo_error)
	as_Mensagem_Log = lo_error.GetMessage( )
	Return False
Finally
	Destroy lo_fiscal
	Destroy lvds
End Try
end function

public function boolean of_emb_padrao_distrib_prod (long al_filial, long al_pedido, long al_produto, ref long al_caixa_padrao, ref string as_mensagem_log, string as_uf);String ls_conv_embalagem_padrao

Select id_conv_emb_padr_dist_ent
Into :ls_conv_embalagem_padrao
From fornecedor 
Where cd_fornecedor = :is_fornecedor
	Using SqlCa;
			
Choose Case SqlCa.SqlCode
	Case 0
	// Verifica se o campo est$$HEX1$$e100$$ENDHEX$$ configurado como 'N'
	If ls_conv_embalagem_padrao = 'N' Then
		 al_caixa_padrao = 1
		 Return True
	End If
	
	Case 100
		as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o fornecedor para a filial: " + String(al_filial) + "."
		Return False
		
	Case -1
		as_Mensagem_Log = "Erro ao consultar o fornecedor para a filial: " + String(al_filial) + ". " + SqlCa.SqlErrText
		Return False
		
End Choose

Select coalesce(qt_embalagem_padrao_distrib, 1) 
Into :al_caixa_padrao
From distribuidora_produto
Where cd_distribuidora 			= :is_Fornecedor
	and cd_produto 				= :al_produto
	and cd_unidade_federacao 	= :as_uf
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If al_caixa_padrao = 0 Then al_caixa_padrao = 1
		Return True
	Case 100
		as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizada a embalagem padr$$HEX1$$e300$$ENDHEX$$o da distribuidora na tabela DISTRIBUIDORA_PRODUTO FILIAL/PEDIDO/PRODUTO: " + String(al_filial)  + '/' + String(al_Pedido) + '/' + String(al_produto) + "."
		Return False	
	Case -1
		as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o da embalagem padr$$HEX1$$e300$$ENDHEX$$o da distribuidora na tabela DISTRIBUIDORA_PRODUTO FILIAL/PEDIDO/PRODUTO: " + String(al_filial)  + '/' + String(al_Pedido) + '/' + String(al_produto) + "." + SqlCa.SqlErrText
		Return False
End Choose
end function

public function boolean of_preco_produto_pedido (long al_filial, long al_pedido, long al_produto, ref decimal adc_preco_bruto, ref decimal adc_preco_liquido, ref long al_qt_emb_padrao_ped, ref string as_mensagem_log);Boolean	lb_verifica_pedido_manual	= False
String	ls_conv_embalagem_padrao

adc_Preco_Bruto 		= 0.00
adc_Preco_Liquido 	= 0.00
al_Qt_Emb_Padrao_Ped = 1

SELECT
	Coalesce(vl_preco, 0.00), 
	Coalesce(vl_preco_unitario, 0.00), 
	Coalesce(qt_embalagem_padrao_distrib, 1)
INTO
	:adc_Preco_Bruto, 
	:adc_Preco_Liquido, 
	:al_Qt_Emb_Padrao_Ped
FROM
	pedido_distribuidora_produto
WHERE
	cd_filial = :al_Filial
	AND nr_pedido_distribuidora = :al_Pedido
	AND cd_produto = :al_Produto
USING SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		lb_verifica_pedido_manual	= True
	Case -1		
		as_Mensagem_Log = "Erro ao localizar o vl_preco e vl_preco_unitario da pedido_distribuidora_produto FILIAL/PEDIDO/PRODUTO: " + String(al_filial)  + '/' + String(al_Pedido) + '/' + String(al_produto) + "." + SqlCa.SqlErrText
		Return False
	Case 0 
		//consultar na tabela fornecedor coluna id_conv_emb_padr_dist_ent e ajustar a variavel al_qt_emb_padrao_ped = 1 se o id estiver como 'N
			Select id_conv_emb_padr_dist_ent
			Into	:ls_conv_embalagem_padrao
			From	fornecedor 
			Where	cd_fornecedor = :is_fornecedor
				Using SqlCa;
						
			Choose Case SqlCa.SqlCode
				Case 0
				// Verifica se o campo est$$HEX1$$e100$$ENDHEX$$ configurado como 'N'
				If ls_conv_embalagem_padrao = 'N' Then
					 al_qt_emb_padrao_ped = 1
					 Return True
				End If
				
				Case 100
					as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o fornecedor para a filial: " + String(al_filial) + "."
					Return False
					
				Case -1
					as_Mensagem_Log = "Erro ao consultar o fornecedor para a filial: " + String(al_filial) + ". " + SqlCa.SqlErrText
					Return False
					
			End Choose
End Choose

If lb_verifica_pedido_manual Then
	SELECT
		Coalesce(vl_preco_unitario, 0.00), 
		Coalesce(vl_preco_unitario, 0.00), 
		Coalesce(qt_embalagem_padrao_distrib, 1)
	INTO
		:adc_Preco_Bruto, 
		:adc_Preco_Liquido, 
		:al_Qt_Emb_Padrao_Ped
	FROM
		pedido_central_produto
	WHERE
		nr_pedido		= :al_Pedido
		AND cd_produto = :al_Produto
	USING SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 100
			as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o vl_preco e vl_preco_unitario da pedido_distribuidora_produto/pedido_central_produto FILIAL/PEDIDO/PRODUTO: " + String(al_filial)  + '/' + String(al_Pedido) + '/' + String(al_produto) + "." + SqlCa.SqlErrText
			Return False
		Case -1		
			as_Mensagem_Log = "Erro ao localizar o vl_preco e vl_preco_unitario da pedido_central_produto PEDIDO/PRODUTO: " + String(al_filial)  + '/' + String(al_Pedido) + '/' + String(al_produto) + "." + SqlCa.SqlErrText
			Return False		
	End Choose
End If

Return True
end function

public function boolean of_insere_titulos (t_infnfe at_infnfe, long al_pedido, string as_permite_nota_sem_pedido, ref string as_mensagem_log);Long ll_Qt_Titulos, i, ll_Dias_Pagto
Date ldt_Emissao, ldt_Vencimento
String ls_Nr_Titulo_Pagar
Double ld_Vl_Pagar
String ls_Alfabeto, ls_Nosso_Numero
Long ll_Linhas, ll_Linha

ll_Qt_Titulos = UpperBound(at_infnfe.cobr.dup[])
ldt_Emissao = at_infnfe.ide.demi 
ls_Alfabeto = "ABCDEFGHIJKLMNOPQRSTUVXZYW"

as_mensagem_log = ""

//Se for fornecedor que permite nota sem pedido e n$$HEX1$$e300$$ENDHEX$$o tiver duplicatas na nota insere t$$HEX1$$ed00$$ENDHEX$$tulo conforme a condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento
If as_permite_nota_sem_pedido = "S" and ll_Qt_Titulos < 1 Then
	
	dc_uo_ds_base lds
	Long ll_qt_dias_vencimento
	Double ld_pc_valor_total
	Double ld_soma_titulos = 0.00

	Try
		lds = Create dc_uo_ds_base
		If Not lds.of_ChangeDataObject('ds_ge238_titulo_pagar_parcelas', False) Then
			as_mensagem_log = "Erro na mudan$$HEX1$$e700$$ENDHEX$$a na DW [ds_ge238_titulo_pagar_parcelas]."
			Return False
		End If	
		
		ll_Linhas = lds.retrieve(is_Fornecedor)
	
		For ll_Linha = 1 To  ll_Linhas
			ll_qt_dias_vencimento	= lds.Object.qt_dias_vencimento	[ll_linha]
			ld_pc_valor_total			= lds.Object.pc_valor_total			[ll_linha]
			
			ls_Nr_Titulo_Pagar	= String(il_Nf)+is_Serie+Mid(ls_Alfabeto, ll_Linha, 1)	
			ldt_Vencimento			= RelativeDate(ldt_Emissao, ll_qt_dias_vencimento)
			
			If ll_linha = ll_Linhas Then
				ld_Vl_Pagar	= at_infnfe.total.ICMSTot.vNF - ld_soma_titulos
			Else	
				ld_Vl_Pagar	= Round((ld_pc_valor_total / 100) * at_infnfe.total.ICMSTot.vNF, 2)
				
				ld_soma_titulos+= ld_Vl_Pagar
			End If
			
			Insert into titulo_pagar_pendente(	
						cd_filial,
						cd_fornecedor,
						nr_titulo_pagar,
						dh_emissao,
						dh_vencimento,
						vl_pagar,
						nr_nf,
						de_especie,
						de_serie,
						de_nosso_numero)
			values(	:il_Filial,
						:is_Fornecedor,
						:ls_Nr_Titulo_Pagar,
						:ldt_Emissao,
						:ldt_Vencimento,
						:ld_Vl_Pagar,
						:il_Nf,
						:is_Especie,
						:is_Serie,
						null)
			Using SqlCa;	
			
			Choose Case SqlCa.SqlCode
				Case -1		
					as_Mensagem_Log = "Erro ao inserir os t$$HEX1$$ed00$$ENDHEX$$tulos da nota: "+ SqlCa.SqlErrText
					Return False
				Case 0		
					//Return True
				Case Else
					as_Mensagem_Log = "Erro desconhecido ao inserir os t$$HEX1$$ed00$$ENDHEX$$tulos da nota"
					Return False
			End Choose
		Next
	Finally
		Destroy(lds)
	End Try
Else
	
	//Valida Parcelas Titulos
	If Not of_valida_parcelas_titulo( at_infnfe, is_Fornecedor, Ref as_mensagem_log ) Then Return True
	
	For i = 1 to  ll_Qt_Titulos
	
		ls_Nr_Titulo_Pagar	= String(il_Nf)+is_Serie+Mid(ls_Alfabeto, i, 1)	
		ldt_Vencimento 		= at_infnfe.cobr.dup[ i ].dvenc
		
		//Tratamento StCruz, o valor do t$$HEX1$$ed00$$ENDHEX$$tulo ser$$HEX1$$e100$$ENDHEX$$ o proprio valor da nota fiscal
		If is_Fornecedor = "053403312" or is_Fornecedor = '053405539' or is_Fornecedor = '053400519' or is_Fornecedor = '053405356' or is_Fornecedor = '053405860' or is_Fornecedor = '053406093' Then
			ld_Vl_Pagar			= at_infnfe.total.ICMSTot.vNF
			//Wagner 06/08/2015: A pedido do Contas a Pagar esta informa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ gravada.
			//Motivo: O pagamento ser$$HEX1$$e100$$ENDHEX$$ via dep bancario
			//ls_Nosso_Numero	= at_infnfe.cobr.dup[ i ].ndup
		Else
			ld_Vl_Pagar			= at_infnfe.cobr.dup[ i ].vdup
		End If
		
		Insert into titulo_pagar_pendente(	
					cd_filial,
					cd_fornecedor,
					nr_titulo_pagar,
					dh_emissao,
					dh_vencimento,
					vl_pagar,
					nr_nf,
					de_especie,
					de_serie,
					de_nosso_numero)
		values(	:il_Filial,
					:is_Fornecedor,
					:ls_Nr_Titulo_Pagar,
					:ldt_Emissao,
					:ldt_Vencimento,
					:ld_Vl_Pagar,
					:il_Nf,
					:is_Especie,
					:is_Serie,
					null)
		Using SqlCa;	
		
		Choose Case SqlCa.SqlCode
			Case -1		
				as_Mensagem_Log = "Erro ao inserir os t$$HEX1$$ed00$$ENDHEX$$tulos da nota: "+ SqlCa.SqlErrText
				Return False
			Case 0		
				//Return True
			Case Else
				as_Mensagem_Log = "Erro desconhecido ao inserir os t$$HEX1$$ed00$$ENDHEX$$tulos da nota"
				Return False
		End Choose
		
		If is_Fornecedor = "053403312" or is_Fornecedor = '053405539' or is_Fornecedor = '053400519' or is_Fornecedor = '053405356' or is_Fornecedor = '053405860' or is_Fornecedor = '053406093' Then
			//StCruz gravar$$HEX1$$e100$$ENDHEX$$ somente 1 registro...
			Exit
		End If
		
	Next
	
	If ll_Qt_Titulos > 0 Then
		Update pedido_distribuidora 
		Set dh_titulo_pagar = GetDate()
		where nr_pedido_distribuidora 	= :al_Pedido
			and cd_filial 							= :il_Filial
		Using SqlCa;
		
		Choose Case  SqlCa.SqlCode 
			Case -1		
				as_mensagem_log = "Erro ao atualizar dh_titulo_pagar pedido_distribuidora: "+SqlCa.SQLErrText
				Return False
		End Choose
	End If
End If

Return True
end function

public function boolean of_nosso_codigo_produto (string as_produto, string as_distribuidora, ref long al_produto, ref decimal adc_fator_conversao, ref decimal adc_repasse_icms, ref decimal adc_icms, ref decimal adc_reducao_icms, long al_filial, ref integer ai_tributacao_produto, ref decimal pc_icms_st, ref string as_subcategoria, ref string as_lei_generico, string as_ean, string as_ean_trib, ref string as_lista_pis_cofins, ref string as_cd_produto_sap, ref string as_mensagem_log);String lvs_Produto
String ls_Cd_Produto
String ls_ean
String ls_ean_novo

Long ll_Cd_Produto

lvs_Produto = "(" + as_Distribuidora + "-" + as_Produto + ")"
ls_Cd_Produto = gf_Tira_Zero_Esquerda(as_Produto)
//ll_Cd_Produto = Long(ls_Cd_Produto)

If Not ib_Distrib_Conv Then		
	If of_localiza_codigo_barras_like_novo (as_ean, ref al_produto) Then 
		//Localiza o ean no XML
		Select d.cd_produto
		     , p.vl_fator_conversao
			  , d.pc_repasse_icms
			  , d.pc_icms
			  , d.pc_reducao_base_icms
			  , p.cd_tributacao_produto
			  , t.pc_icms
			  , p.cd_subcategoria
			  , p.id_lei_generico
			  , p.id_situacao_pis_cofins
			  , p.cd_produto_sap
		  Into :al_Produto
		     , :adc_Fator_Conversao
			  , :adc_Repasse_ICMS
			  , :adc_ICMS
			  , :adc_Reducao_ICMS
			  , :ai_tributacao_produto
			  , :pc_ICMS_ST
			  , :as_Subcategoria
			  , :as_lei_generico
			  , :as_Lista_Pis_Cofins
			  , :as_cd_produto_sap
		  From distribuidora_produto d
		     , produto_geral p
			  , produto_uf u
			  , tipo_icms t
  		 Where d.cd_distribuidora = :as_Distribuidora
		  and d.cd_produto = :al_produto
		  and d.cd_unidade_federacao = (Select c.cd_unidade_federacao
												    From filial f
													    , cidade c
												   Where f.cd_filial = :al_Filial
													  and c.cd_cidade = f.cd_cidade)  
		  and p.cd_produto = d.cd_produto
		  and u.cd_produto = p.cd_produto
		  and u.cd_unidade_federacao in (Select c.cd_unidade_federacao
													 From filial f
													    , cidade c
													Where f.cd_filial = :al_Filial
													  and c.cd_cidade = f.cd_cidade)  
		  and t.cd_tipo_icms		 = u.cd_tipo_icms
		Using SqlCa;
		

		Choose Case SqlCa.SqlCode
			Case 0
				If IsNull(ai_Tributacao_Produto) Then ai_Tributacao_Produto = 0
				Return True
			
			Case 100
			Case -1
				as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Nosso C$$HEX1$$f300$$ENDHEX$$digo do Produto " + lvs_Produto + ". " + SqlCa.SqlErrText
				Return False
		End Choose
	Else
		
		Select d.cd_produto
			  , p.vl_fator_conversao
			  , d.pc_repasse_icms
			  , d.pc_icms
			  , d.pc_reducao_base_icms
			  , p.cd_tributacao_produto
			  , t.pc_icms
			  , p.cd_subcategoria
			  , p.id_lei_generico
			  , p.id_situacao_pis_cofins
			  , p.cd_produto_sap
		Into :al_Produto,
			  :adc_Fator_Conversao,
			 :adc_Repasse_ICMS,
			 :adc_ICMS,
			 :adc_Reducao_ICMS,
			 :ai_tributacao_produto,
			 :pc_ICMS_ST,
			 :as_Subcategoria,
			 :as_lei_generico,
			 :as_Lista_Pis_Cofins,
			 :as_cd_produto_sap
		From distribuidora_produto d,
			  produto_geral p,
			 produto_uf u,
			 tipo_icms t
		Where d.cd_distribuidora         = :as_Distribuidora
		  and (d.cd_produto_distribuidora = :as_Produto or d.cd_produto_distribuidora = :ls_Cd_Produto)
		  and d.cd_unidade_federacao = (Select c.cd_unidade_federacao
												  From filial f,
														 cidade c
												  Where f.cd_filial = :al_Filial
													 and c.cd_cidade = f.cd_cidade)  
		  and p.cd_produto 			 = d.cd_produto
		  and u.cd_produto 			 = p.cd_produto
		  and u.cd_unidade_federacao in (Select c.cd_unidade_federacao
													From filial f,
														  cidade c
													Where f.cd_filial = :al_Filial
													  and c.cd_cidade = f.cd_cidade)  
		  and t.cd_tipo_icms		 = u.cd_tipo_icms
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				If IsNull(ai_Tributacao_Produto) Then ai_Tributacao_Produto = 0
				Return True
				
			Case 100	
				as_Mensagem_Log = "Nosso C$$HEX1$$f300$$ENDHEX$$digo do Produto " + lvs_Produto + " n$$HEX1$$e300$$ENDHEX$$o Localizado. EAN: " + as_ean
				Return False	
				
			Case -1
				as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Nosso C$$HEX1$$f300$$ENDHEX$$digo do Produto " + lvs_Produto + ". " + SqlCa.SqlErrText
				Return False
		End Choose
		
	End If
	
Else
	
	//Se for distribuidora de conveni$$HEX1$$ea00$$ENDHEX$$ncia, tenta primeiro pela tag cean trib, se n$$HEX1$$e300$$ENDHEX$$o localizar procura pela tag cean
	//Spal/Femsa informarmam o EAN do produto na tag ceantrib e o c$$HEX1$$f300$$ENDHEX$$digo do fardo na tag cean
	
	Select 	d.cd_produto,
			 	p.vl_fator_conversao,
				d.pc_repasse_icms,
				d.pc_icms,
				d.pc_reducao_base_icms,
				p.cd_tributacao_produto,
				t.pc_icms,
				p.cd_subcategoria,
				p.id_lei_generico,
				p.id_situacao_pis_cofins,
				p.cd_produto_sap
	Into	:al_Produto,
		  	:adc_Fator_Conversao,
		 	:adc_Repasse_ICMS,
		 	:adc_ICMS,
		 	:adc_Reducao_ICMS,
		 	:ai_tributacao_produto,
		 	:pc_ICMS_ST,
		 	:as_Subcategoria,
		 	:as_lei_generico,
		 	:as_Lista_Pis_Cofins,
			:as_cd_produto_sap
	From distribuidora_produto d,
		  	produto_geral p,
		 	produto_uf u,
		 	tipo_icms t
	Where d.cd_distribuidora         = :as_Distribuidora
	  and d.cd_produto in (select cd_produto from codigo_barras_produto where de_codigo_barras = :as_ean_trib)
	  and d.cd_unidade_federacao = (Select c.cd_unidade_federacao
											  From filial f,
													 cidade c
											  Where f.cd_filial = :al_Filial
												 and c.cd_cidade = f.cd_cidade)  
	  and p.cd_produto 			 = d.cd_produto
	  and u.cd_produto 			 = p.cd_produto
	  and u.cd_unidade_federacao in (Select c.cd_unidade_federacao
												From filial f,
													  cidade c
												Where f.cd_filial = :al_Filial
												  and c.cd_cidade = f.cd_cidade)  
	  and t.cd_tipo_icms		 = u.cd_tipo_icms
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(ai_Tributacao_Produto) Then ai_Tributacao_Produto = 0
		Return True
		
	Case 100
	Case -1
		as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Nosso C$$HEX1$$f300$$ENDHEX$$digo do Produto " + lvs_Produto + ". " + SqlCa.SqlErrText
		Return False
	End Choose

	//Localiza o ean sem os zeros na frente

	ls_ean = gf_Tira_Zero_Esquerda(as_ean_trib)

	Select 	d.cd_produto,
			 	p.vl_fator_conversao,
				d.pc_repasse_icms,
				d.pc_icms,
				d.pc_reducao_base_icms,
				p.cd_tributacao_produto,
				t.pc_icms,
				p.cd_subcategoria,
				p.id_lei_generico,
				p.id_situacao_pis_cofins,
				p.cd_produto_sap
	Into	:al_Produto,
		  	:adc_Fator_Conversao,
		 	:adc_Repasse_ICMS,
		 	:adc_ICMS,
		 	:adc_Reducao_ICMS,
		 	:ai_tributacao_produto,
		 	:pc_ICMS_ST,
		 	:as_Subcategoria,
		 	:as_lei_generico,
		 	:as_Lista_Pis_Cofins,
			:as_cd_produto_sap
	From distribuidora_produto d,
		  	produto_geral p,
		 	produto_uf u,
		 	tipo_icms t
	Where d.cd_distribuidora         = :as_Distribuidora
	  and d.cd_produto in (select cd_produto from codigo_barras_produto where de_codigo_barras = :ls_ean)
	  and d.cd_unidade_federacao = (Select c.cd_unidade_federacao
											  From filial f,
													 cidade c
											  Where f.cd_filial = :al_Filial
												 and c.cd_cidade = f.cd_cidade)  
	  and p.cd_produto 			 = d.cd_produto
	  and u.cd_produto 			 = p.cd_produto
	  and u.cd_unidade_federacao in (Select c.cd_unidade_federacao
												From filial f,
													  cidade c
												Where f.cd_filial = :al_Filial
												  and c.cd_cidade = f.cd_cidade)  
	  and t.cd_tipo_icms		 = u.cd_tipo_icms
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(ai_Tributacao_Produto) Then ai_Tributacao_Produto = 0
		Return True
		
	Case 100 // Se n$$HEX1$$e300$$ENDHEX$$o localizou pelo cean trib, faz a consulta pelo cean
	Case -1
		as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Nosso C$$HEX1$$f300$$ENDHEX$$digo do Produto " + lvs_Produto + ". " + SqlCa.SqlErrText
		Return False
	End Choose
	
	//Preenche com zeros a esquerda at$$HEX1$$e900$$ENDHEX$$ completar os 13 caracteres
	
	If LenA(ls_Ean) < 13 Then
		
		ls_Ean = RightA("0000000000000" + ls_Ean, 13)
		
		Select 	d.cd_produto,
					p.vl_fator_conversao,
					d.pc_repasse_icms,
					d.pc_icms,
					d.pc_reducao_base_icms,
					p.cd_tributacao_produto,
					t.pc_icms,
					p.cd_subcategoria,
					p.id_lei_generico,
					p.id_situacao_pis_cofins,
				   p.cd_produto_sap
		Into	:al_Produto,
				:adc_Fator_Conversao,
				:adc_Repasse_ICMS,
				:adc_ICMS,
				:adc_Reducao_ICMS,
				:ai_tributacao_produto,
				:pc_ICMS_ST,
				:as_Subcategoria,
				:as_lei_generico,
				:as_Lista_Pis_Cofins,
				:as_cd_produto_sap
		From distribuidora_produto d,
				produto_geral p,
				produto_uf u,
				tipo_icms t
		Where d.cd_distribuidora         = :as_Distribuidora
		  and d.cd_produto in (select cd_produto from codigo_barras_produto where de_codigo_barras = :ls_ean)
		  and d.cd_unidade_federacao = (Select c.cd_unidade_federacao
												  From filial f,
														 cidade c
												  Where f.cd_filial = :al_Filial
													 and c.cd_cidade = f.cd_cidade)  
		  and p.cd_produto 			 = d.cd_produto
		  and u.cd_produto 			 = p.cd_produto
		  and u.cd_unidade_federacao in (Select c.cd_unidade_federacao
													From filial f,
														  cidade c
													Where f.cd_filial = :al_Filial
													  and c.cd_cidade = f.cd_cidade)  
		  and t.cd_tipo_icms		 = u.cd_tipo_icms
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
		Case 0
			If IsNull(ai_Tributacao_Produto) Then ai_Tributacao_Produto = 0
			Return True
			
		Case 100 // Se n$$HEX1$$e300$$ENDHEX$$o localizou pelo cean trib, faz a consulta pelo cean
		Case -1
			as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Nosso C$$HEX1$$f300$$ENDHEX$$digo do Produto " + lvs_Produto + ". " + SqlCa.SqlErrText
			Return False
		End Choose
	End If
	
	//Procura pela tag cean
	Select 	d.cd_produto,
			 	p.vl_fator_conversao,
				d.pc_repasse_icms,
				d.pc_icms,
				d.pc_reducao_base_icms,
				p.cd_tributacao_produto,
				t.pc_icms,
				p.cd_subcategoria,
				p.id_lei_generico,
				p.id_situacao_pis_cofins,
				p.cd_produto_sap
	Into	:al_Produto,
		  	:adc_Fator_Conversao,
		 	:adc_Repasse_ICMS,
		 	:adc_ICMS,
		 	:adc_Reducao_ICMS,
		 	:ai_tributacao_produto,
		 	:pc_ICMS_ST,
		 	:as_Subcategoria,
		 	:as_lei_generico,
		 	:as_Lista_Pis_Cofins,
			:as_cd_produto_sap
	From distribuidora_produto d,
		  	produto_geral p,
		 	produto_uf u,
		 	tipo_icms t
	Where d.cd_distribuidora         = :as_Distribuidora
	  and d.cd_produto in (select cd_produto from codigo_barras_produto where de_codigo_barras = :as_ean)
	  and d.cd_unidade_federacao = (Select c.cd_unidade_federacao
											  From filial f,
													 cidade c
											  Where f.cd_filial = :al_Filial
												 and c.cd_cidade = f.cd_cidade)  
	  and p.cd_produto 			 = d.cd_produto
	  and u.cd_produto 			 = p.cd_produto
	  and u.cd_unidade_federacao in (Select c.cd_unidade_federacao
												From filial f,
													  cidade c
												Where f.cd_filial = :al_Filial
												  and c.cd_cidade = f.cd_cidade)  
	  and t.cd_tipo_icms		 = u.cd_tipo_icms
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(ai_Tributacao_Produto) Then ai_Tributacao_Produto = 0
		Return True
		
	Case 100
	Case -1
		as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Nosso C$$HEX1$$f300$$ENDHEX$$digo do Produto " + lvs_Produto + ". " + SqlCa.SqlErrText
		Return False
	End Choose

	//Localiza o ean sem os zeros na frente

	ls_ean = gf_Tira_Zero_Esquerda(as_ean)

	Select 	d.cd_produto,
			 	p.vl_fator_conversao,
				d.pc_repasse_icms,
				d.pc_icms,
				d.pc_reducao_base_icms,
				p.cd_tributacao_produto,
				t.pc_icms,
				p.cd_subcategoria,
				p.id_lei_generico,
				p.id_situacao_pis_cofins,
			   p.cd_produto_sap				
	Into	:al_Produto,
		  	:adc_Fator_Conversao,
		 	:adc_Repasse_ICMS,
		 	:adc_ICMS,
		 	:adc_Reducao_ICMS,
		 	:ai_tributacao_produto,
		 	:pc_ICMS_ST,
		 	:as_Subcategoria,
		 	:as_lei_generico,
		 	:as_Lista_Pis_Cofins,
			:as_cd_produto_sap
	From distribuidora_produto d,
		  	produto_geral p,
		 	produto_uf u,
		 	tipo_icms t
	Where d.cd_distribuidora         = :as_Distribuidora
	  and d.cd_produto in (select cd_produto from codigo_barras_produto where de_codigo_barras = :ls_ean)
	  and d.cd_unidade_federacao = (Select c.cd_unidade_federacao
											  From filial f,
													 cidade c
											  Where f.cd_filial = :al_Filial
												 and c.cd_cidade = f.cd_cidade)  
	  and p.cd_produto 			 = d.cd_produto
	  and u.cd_produto 			 = p.cd_produto
	  and u.cd_unidade_federacao in (Select c.cd_unidade_federacao
												From filial f,
													  cidade c
												Where f.cd_filial = :al_Filial
												  and c.cd_cidade = f.cd_cidade)  
	  and t.cd_tipo_icms		 = u.cd_tipo_icms
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(ai_Tributacao_Produto) Then ai_Tributacao_Produto = 0
		Return True
		
	Case 100 
		as_Mensagem_Log = "Nosso C$$HEX1$$f300$$ENDHEX$$digo do Produto " + lvs_Produto + " n$$HEX1$$e300$$ENDHEX$$o Localizado. EAN: " + as_ean_trib
		Return False	
	Case -1
		as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Nosso C$$HEX1$$f300$$ENDHEX$$digo do Produto " + lvs_Produto + ". " + SqlCa.SqlErrText
		Return False
	End Choose
		
End If
end function

public function boolean of_localiza_codigo_barras_like_novo (string as_codigo_barras, ref long al_produto);Boolean lb_Continue
Boolean lb_Localizado 
Long ll_Linhas
Long ll_Linha
//Long ll_Produto
Long ll_Cont

String ls_EAN
String ls_Achou

al_produto = 0

dc_uo_ds_base lds 

If IsNull(as_codigo_barras) or Trim(as_codigo_barras) = '' Then
	SetNull(al_produto)
	Return False
End If

try
	lds = Create dc_uo_ds_base
	If Not lds.of_ChangeDataObject("ds_ge238_codigo_barras") Then
		Return False
	End If
	
	as_codigo_barras = gf_tira_zero_esquerda(as_codigo_barras)
	
	ll_Linhas = lds.Retrieve(as_codigo_barras)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			lb_Continue = True
			
			ls_EAN = lds.Object.de_codigo_barras[ll_Linha]
			//0030768001841
			ls_Achou = Mid(ls_EAN, 1,Pos(ls_EAN, as_codigo_barras) -1)
							
			//00
			For ll_Cont = 1 To Len(ls_Achou)
				// Se encontrar um n$$HEX1$$fa00$$ENDHEX$$mero diferente de zero significa que n$$HEX1$$e300$$ENDHEX$$o encontrou o produto correto
				If Long(Mid(ls_Achou, ll_Cont, 1)) <> 0 Then 
					lb_Continue = False
					Exit
				End If
			Next
			
			If lb_Continue Then
				If al_produto > 0 Then
					// Se encontrar mais de um produto com um mesmo c$$HEX1$$f300$$ENDHEX$$digo de barras, retorna falso
					If al_produto <> lds.Object.cd_produto[ll_Linha] Then
						SetNull(al_produto)
						lb_Localizado = False
					End If
				Else
					al_produto =  lds.Object.cd_produto[ll_Linha]
				End If
			End If						
		Next
		
		// Valida$$HEX2$$e700e300$$ENDHEX$$o Final
		If Not IsNull(al_produto) and al_produto > 0 Then
			lb_Localizado = True 
		Else
			lb_Localizado = False
		End If		
	Else
		lb_Localizado = False
	End If	
Finally
	Destroy lds
End Try

Return lb_Localizado
end function

public function boolean of_importa_nf (string as_chave_acesso, date adt_emissao, long al_pedido, long al_filial, string as_diretorio_xml, boolean ab_importa_sem_pedido, boolean ab_download_sefaz, boolean ab_reimportacao, ref string as_mensagem_log, ref string as_nat_operacao, integer ai_log, long al_pedido_sap, string as_permite_nota_sem_pedido, string ls_sistema_java, string as_fornecedor, ref string as_resolvido, ref datetime adt_resolvido);String ls_Xml, ls_Diretorio_Xml, ls_CEAN, ls_Dados_Adicionais, ls_Projeto_Conexao, ls_Log_Validacao
integer li_FileOpen
Long ll_Pedido_Incluido, ll_Pedido_Informado
Boolean lb_Commit = False, lb_Registrada = False
dc_uo_nfe lo_NFE
t_infnfe lt_InfNFe
String ls_Mensagem_Log
Boolean lb_Pedido_Null
String ls_Distribuidora, ls_Projeto
Long ll_Pos
String ls_Excecao_Riomed
String ls_Aux_Entire
Boolean lb_Incluido_Xvan = False
Boolean lb_Ped_Conexao_Aberto = False
String ls_Fil_Lib_Conv
Long ll_Pedido_GAM
Boolean	lb_Pedido_Central
String ls_temp

SetNull(adt_resolvido)
SetNull(as_resolvido)

ib_Pedido_Informado = False

Try
	
	ib_Reimportacao = ab_Reimportacao
	is_ID_Conexao = ""
	
	ls_Diretorio_Xml = as_Diretorio_Xml + as_Chave_Acesso+"-nfe.xml"
	
// Se n$$HEX1$$e300$$ENDHEX$$o exitir o arquivo na pasta para importar busca da area ftp
//	If not FileExists(ls_Diretorio_Xml) Then
//		If not of_Busca_Xml_Ftp(as_Chave_Acesso, adt_Emissao, al_Filial, as_Diretorio_Xml, ab_download_sefaz, Ref ls_Mensagem_Log) Then
//			as_Mensagem_Log = ls_Mensagem_Log
//			Return False
//		End If
//	End If

	ib_valida_teste_integrado	= gf_valida_teste_integrado()
	
	If Not FileExists(ls_Diretorio_Xml) Then
		//as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o arquivo: "+ ls_Diretorio_Xml
		as_Mensagem_Log = "O XML n$$HEX1$$e300$$ENDHEX$$o foi localizado na $$HEX1$$e100$$ENDHEX$$rea FTP."
		Return False	
	End If
	
	If FileLength(ls_Diretorio_Xml) < 1 Then
		as_Mensagem_Log = "Tamanho do arquivo: "+ ls_Diretorio_Xml +" $$HEX1$$e900$$ENDHEX$$ 0 byte"
		Return False	
	End If
	
	li_FileOpen = FileOpen (ls_Diretorio_Xml , TextMode! , Read!, LockRead! )
	FileReadEx (li_FileOpen, ls_Xml) 
	FileClose (li_FileOpen)
	
	If ls_Xml <> "" Then
		
		Try
			lo_NFE = Create dc_uo_nfe
			If not lo_NFE.of_read_xml(ls_Xml, True, Ref lt_InfNFe) Then
				as_Mensagem_Log = "Erro ao ler o arquivo XML"
				Return False		
			End If
			
			If Not lo_NFE.of_verifica_cancelamento(as_Chave_Acesso, ref as_mensagem_log) Then
				Return False
			End If
			
			//Se for uma nota de entrada, o sistema automaticamente definir$$HEX1$$e100$$ENDHEX$$ o id_resolvido como "S".
			If lt_InfNFe.ide.tpnf = 0 Then
				as_Mensagem_Log = "Essa nota foi emitida como nota de entrada."
				as_Resolvido	= 'S'
				adt_resolvido	= gf_GetServerDate()
				Return False			
			End If
			
			//Se a nota foi emitida em homologa$$HEX2$$e700e300$$ENDHEX$$o, o sistema automaticamente definir$$HEX1$$e100$$ENDHEX$$ o id_resolvido como "S".
			if not ib_valida_teste_integrado then
				If lt_InfNFe.ide.tpamb = 2 Then
					as_Mensagem_Log = "Essa nota foi emitida em ambiente de homologa$$HEX2$$e700e300$$ENDHEX$$o."
					as_Resolvido	= 'S'
					adt_resolvido	= gf_GetServerDate()
					Return False			
				End If
			end if
			
			//Verifica se o XML $$HEX1$$e900$$ENDHEX$$ de estorno
			If lt_InfNFe.ide.finnfe <> 1 Then
				If Not of_atualiza_finalidade_nfe(String(lt_InfNFe.ide.finnfe), as_Chave_Acesso, Ref as_Mensagem_Log ) Then
					Return False		
				End If
			End If
					
			as_nat_operacao = lt_InfNFe.ide.natOp
			
			If Mid(as_nat_operacao, 1, 3) = "999" Then //Nota de estorno
				as_Mensagem_Log = as_nat_operacao
				Return False
			End If
			
			//Localiza o C$$HEX1$$f300$$ENDHEX$$digo da distribuidora
			If Not of_codigo_distribuidora(as_Chave_Acesso, Ref ls_Distribuidora, Ref as_mensagem_log ) Then
				Return False
			End If
			
			If Not gf_Retorna_Distribuidora_Conveniencia(ls_Distribuidora, False, Ref ib_Distrib_Conv, Ref as_Mensagem_Log) Then Return False
			
			If ls_Distribuidora = "053400534" Or ls_Distribuidora = "053405477" Then
				//A Riomed e a Medsul informam o n$$HEX1$$fa00$$ENDHEX$$mero do pedido fatuarado via Sandoz na xVan. Ex: ENTIRE_000000000000000
				ll_Pos = PosA(lt_InfNFe.infadic.xvan, "_")
				If ll_Pos > 0 Then
					ls_Aux_Entire = MidA(lt_InfNFe.infadic.xvan, 1, ll_Pos - 1)
					
					If ls_Aux_Entire = 'ENTIRE' Then
						ll_Pos++
						//Captura o n$$HEX1$$fa00$$ENDHEX$$mero do pedido e atribui para a xPed
						ls_Excecao_Riomed = MidA(lt_InfNFe.infadic.xvan, ll_Pos)
						lt_InfNFe.compra.xped = ls_Excecao_Riomed
					End If
				End If
			End If
			
			//A Panpharma informa "ENTIRESI" na tag xVan nos pedidos via Entire
			If lt_InfNFe.infadic.xvan = "ENTIRESI" Then
				lt_InfNFe.infadic.xvan = "ENTIRE"
			End If
			
			If PosA(lt_InfNFe.infadic.xvan, "FIDELIZE") > 0 Then
				 lt_InfNFe.infadic.xvan = "FIDELIZE"
			 End If
				
			ll_Pos = PosA(lt_InfNFe.infadic.infcpl, "PHARMALINK")
			
			If ll_Pos > 0 Then
				lt_InfNFe.infadic.xvan = "PHARMALINK"
			End If
 
			 //TRATAMENTO GAM 
			 If PosA(lt_InfNFe.infadic.xvan, "MOST") > 0 Then
				 lt_InfNFe.infadic.xvan = "PHARMALINK"
			ELSEIf PosA(lt_InfNFe.infadic.xvan, "PRODOCTOR") > 0 Then
				 lt_InfNFe.infadic.xvan = "ENTIRE"
			 End If
		
			//Se n$$HEX1$$e300$$ENDHEX$$o for informado a xped no cabe$$HEX1$$e700$$ENDHEX$$alho, utiliza a xped o item
			If IsNull(lt_InfNFe.compra.xped) Or lt_InfNFe.compra.xped = "" Then
				lt_InfNFe.compra.xped = lt_InfNFe.det[1].prod.xped
			End If

			ls_temp = lt_InfNFe.compra.xped
			
			if Left(ls_temp, 6) = "951000" then
   				 ls_temp = Mid(ls_temp, 7)  // Remove os primeiros 6 caracteres
			end if
			
			il_Pedido = Long(ls_temp)
			
			lt_InfNFe.compra.xped = ls_temp
			
			//il_Pedido 	= Long(lt_InfNFe.compra.xped)
			
			
			is_Especie 	= "NFE"
			is_Serie		= lt_InfNFe.ide.serie
									
			//EAN
			ls_CEAN = lt_InfNFe.det[1].prod.cean
			
			//problemas dos EANs que n$$HEX1$$e300$$ENDHEX$$o importavam sem a tag xvan
			//Foi repassado a Ana para corre$$HEX2$$e700e300$$ENDHEX$$o mas por precau$$HEX2$$e700e300$$ENDHEX$$o, at$$HEX1$$e900$$ENDHEX$$ finalizar os testes da altera$$HEX2$$e700e300$$ENDHEX$$o na subconsulta foi deixado essa gambiarra para importar as notas com eans divergentes	
				
			// UTILIZADO TISCOSKI
			If il_Pedido = 0 or Isnull(il_Pedido) Then 
				If ls_Distribuidora = '053403680' and Today() = Date('30/09/2022') Then
					If Not of_verifica_pedido_normal_aberto(ls_Distribuidora, al_Filial, '', lt_InfNFe, ref il_Pedido, ref as_Mensagem_Log) Then
						Return False
					End If
					al_Pedido = il_Pedido
				End If
			End If
			
			//Altera$$HEX2$$e700e300$$ENDHEX$$o aqui	
			lb_Pedido_Null = False
									
			If IsNull(al_Pedido) Or (as_Permite_Nota_Sem_Pedido <> "S"	and ab_reimportacao) Then
				
				If ab_reimportacao Then
					If Not of_Atualiza_Reimportada( al_Filial, ls_Distribuidora, lt_InfNFe.ide.nNF, as_Chave_Acesso, Ref as_mensagem_log ) Then Return False
				Else
					If Not of_verifica_nota_excluida(as_Chave_Acesso, ref as_Mensagem_Log) Then Return False
				End If
	
				// Valida o n$$HEX1$$fa00$$ENDHEX$$mero do pedido informado no XML
				If as_Permite_Nota_Sem_Pedido <> 'S' Then
					If Not of_Valida_Pedido_XML (lt_InfNFe.compra.xped, lt_InfNFe.det[1].prod.xped, ls_Distribuidora, ab_importa_sem_pedido, &
															ref al_Pedido, ref ls_Projeto, ref as_mensagem_log, al_filial, ls_CEAN, as_Chave_Acesso) Then
						Return False
					End If
				End If
	
				//Atribui ENTIRE para a ls_Aux_Entire somente se a distribuidora for Riomed ou Medsul
				If ls_Aux_Entire = 'ENTIRE' Then
					lt_InfNFe.infadic.xvan = ls_Aux_Entire
				Else
					//Atribui o na tag xVan o Projeto PHARMALINK - Profarma
					If Not IsNull( ls_Projeto ) And ls_Projeto <> "" Then
						lt_InfNFe.infadic.xvan = ls_Projeto
					End If
				End If
			
				If IsNull(lt_InfNFe.infadic.xvan) or Trim(lt_InfNFe.infadic.xvan) = '' Then
					//Importa$$HEX2$$e700e300$$ENDHEX$$o manual sem pedido conex$$HEX1$$e300$$ENDHEX$$o
					If ib_Imp_Manual_Sem_Pedido_Conexao and ab_importa_sem_pedido Then
						If Not of_verifica_conexao_produto(ls_CEAN, ref ls_Projeto_Conexao, ab_importa_sem_pedido, Ref as_mensagem_log)  Then Return False
						
					Else
						
						//Importa$$HEX2$$e700e300$$ENDHEX$$o autom$$HEX1$$e100$$ENDHEX$$tica verificando a tag xvan
						If Not of_Verifica_Ped_Conexao_Aberto(ls_Distribuidora, al_Filial, al_Pedido, Ref lb_Ped_Conexao_Aberto, Ref as_Mensagem_Log) Then Return False
						
						If lb_Ped_Conexao_Aberto Then
							If Not of_verifica_conexao_produto(ls_CEAN, ref ls_Projeto_Conexao, ab_importa_sem_pedido, Ref as_mensagem_log)  Then Return False
						End If
					End If
					
					If Not IsNull(ls_Projeto_Conexao) and Trim(ls_Projeto_Conexao) <> '' Then
						lt_InfNFe.infadic.xvan = ls_Projeto_Conexao
						lb_Incluido_Xvan = True
					Else
						If ib_Imp_Manual_Sem_Pedido_Conexao and ab_importa_sem_pedido Then
							as_mensagem_log = "Entrada da NF sem pedido conex$$HEX1$$e300$$ENDHEX$$o. O produto n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ de conex$$HEX1$$e300$$ENDHEX$$o."
							Return False
						End If
					End If
				End If
								
				If Not of_verifica_projeto_conexao(lt_InfNFe.infadic.xvan, ls_Distribuidora, lt_InfNFe.infadic.infcpl, Ref is_ID_Conexao, Ref as_mensagem_log) Then
					Return False
				End If
				
				If is_ID_Conexao = "3" Then ab_importa_sem_pedido = True
				
				If as_Permite_Nota_Sem_Pedido <> "S" Then
					If Not This.of_verifica_pedido(al_Filial, al_Pedido, as_Chave_Acesso, ls_CEAN, ls_Dados_Adicionais, ref ls_Mensagem_Log, ref ll_Pedido_Incluido, &	
															 adt_emissao, is_ID_Conexao, lt_InfNFe.infadic.infcpl, ls_Distribuidora, ab_importa_sem_pedido, ab_reimportacao, &
															 lt_InfNFe, ls_Sistema_Java, Ref lb_Pedido_Central, Ref ll_Pedido_Informado) Then
						as_mensagem_log = ls_Mensagem_Log
						Return False
					End If
				End If
				
				//Se foi incluido um pedido PHARMALINK OU ENTIRE
				If Not IsNull(ll_Pedido_Incluido) and ll_Pedido_Incluido > 0 Then
					al_Pedido = ll_Pedido_Incluido
				else
					//Se era nota sem pedido e o pedido foi informado manualmente...
					If ib_Pedido_Informado then
						al_Pedido = ll_Pedido_Informado
					End if
				End If
				
				if not IsNull(al_pedido_sap) and al_pedido_sap <> 0 then
					if al_pedido_sap <> al_pedido then
						as_mensagem_log = "O pedido encontrado no XML n$$HEX1$$e300$$ENDHEX$$o confere com o pedido retornado pelo SAP. ~n~n" + &
												"Pedido XML: " + String(al_pedido) + "~n" +&
												"Pedido SAP: " + String(al_pedido_sap)
						Return False
					end if
				end if
										
				lb_Pedido_Null = True
			End If
		
			If of_Insere_Cabecalho(lt_InfNFe, al_Pedido, as_Chave_Acesso, al_Filial, as_permite_nota_sem_pedido, as_Fornecedor, lb_Pedido_Central, Ref ls_Mensagem_Log) Then		
				If of_Insere_Itens(lt_InfNFe, Ref ls_Mensagem_Log, al_Pedido, as_permite_nota_sem_pedido) Then
				
					//Alterado aqui
					If lb_Pedido_Null or (as_permite_nota_sem_pedido = "S") Then
						If  (as_permite_nota_sem_pedido <> "S") Then
							If Not of_Atualiza_Pedido_Distribuidora(al_Filial, al_Pedido, Ref ls_Mensagem_Log) Then
								as_mensagem_log = ls_Mensagem_Log
								SqlCa.of_Rollback( )
								FileDelete(ls_Diretorio_Xml)
								Return False
							End If
						End If
						
						If Not of_Insere_Titulos(lt_InfNFe, al_Pedido, as_permite_nota_sem_pedido, Ref ls_Mensagem_Log) Then
							as_mensagem_log = ls_Mensagem_Log
							SqlCa.of_Rollback( )
							FileDelete(ls_Diretorio_Xml)
							Return False	
						End If
						
						//Atualiza dh_importacao - nf_compra_reimportacao
						If ab_reimportacao Then
							If Not of_Atualiza_Data_Reimportacao( al_Filial, ls_Distribuidora, lt_InfNFe.ide.nNF, as_Chave_Acesso, Ref ls_Mensagem_Log) Then
								as_mensagem_log = ls_Mensagem_Log
								SqlCa.of_Rollback( )
								FileDelete(ls_Diretorio_Xml)
								Return False	
							End If
						End If
					End If

					If Not of_insere_log_importacao(as_Chave_Acesso,al_Filial,as_Fornecedor,Ref as_mensagem_log,adt_emissao,al_Pedido,lt_InfNFe.ide.nNF) Then
						SqlCa.of_Rollback( )
						FileDelete(ls_Diretorio_Xml)
						Return False
					End if 

					// Atualiza a qtde de itens no cabecalho da nota
					If Not of_atualiza_qtde_itens_cabecalho(Ref as_mensagem_log ) Then
						SqlCa.of_Rollback( )
						FileDelete(ls_Diretorio_Xml)
						Return False
					Else
						//Se era nota sem pedido e este foi informado manualmente, marca a nfe_sem_pedido como importada
						If ib_Pedido_Informado then
							If not of_registra_importacao_nfe_sem_pedido (as_chave_acesso, Ref as_mensagem_log) then
								SqlCa.of_Rollback ()
								FileDelete (ls_Diretorio_Xml)
								Return False
							End if
						End if
						
						SqlCa.of_Commit()
						lb_Commit = True
					End If
					
				End If
			End If
		
			If Not lb_Commit Then
				SqlCa.of_Rollback( )
			End If
			
		Catch ( RuntimeError lre )	
			If Not fileDelete(ls_Diretorio_Xml) Then
				as_mensagem_log = "Erro ao deletar o arquivo. " + lre.GetMessage( )
				Return False
			End If
			
		Finally
			Destroy(lo_NFE)
		End Try	
	
	Else
		ls_Mensagem_Log =  "XML est$$HEX1$$e100$$ENDHEX$$ vazio"
	End If
	
Finally
	If lb_Commit Then
		//TRATAMENTO an$$HEX1$$e100$$ENDHEX$$lise de XML
		//Se houver diret$$HEX1$$f300$$ENDHEX$$rio definido no .INI o XML ser$$HEX1$$e100$$ENDHEX$$ movido
		If gvs_Dir_AnaliseXML <> "" Then
			lf_move_arquivo_xml_validacao(ls_Diretorio_Xml, as_chave_acesso, ref ls_Log_Validacao)
			If Not IsNull(ls_Log_Validacao) and Trim(ls_Log_Validacao) <> '' Then
				This.of_Grava_Log(ai_log, ls_Log_Validacao)
			End If
		End If
		
		//Se foi inclu$$HEX1$$ed00$$ENDHEX$$da a tag xVan pelo programa $$HEX1$$e900$$ENDHEX$$ enviado um e-mail
		If lb_Incluido_Xvan Then
			of_Envia_Email_Sem_Tag_Xvan(lt_InfNFe, ls_Distribuidora, ls_Projeto_Conexao)
		End If
	End If
	
	If FileExists(ls_Diretorio_Xml) Then FileDelete(ls_Diretorio_Xml)
End Try
as_Mensagem_Log	= ls_Mensagem_Log
Return lb_Commit
end function

public function boolean of_verifica_pedido_central (long al_pedido, long al_filial, string as_fornecedor, ref string as_mensagem_log);Long ll_Filial
String	ls_Fornecedor

SetNull (as_mensagem_log)

select cd_filial
	into:ll_Filial
from pedido_central
where nr_pedido = :al_pedido
and dh_emissao >= dateadd( day, -500, getdate() )
Using SqlCa;

Choose Case SqlCa.SqlCode
			
	Case 0
		If al_Filial = ll_Filial Then
			select a.cd_fornecedor
				into :ls_Fornecedor
			from pedido_central a
			inner join fornecedor b on b.cd_fornecedor = a.cd_fornecedor
			where a.nr_pedido = :al_pedido
			and a.cd_filial = :ll_Filial
			Using SqlCa;
			
			Choose Case  SqlCa.SqlCode 
				Case -1
					as_Mensagem_Log = "Erro ao localizar o pedido central: " + SqlCa.SQLErrText
					Return False
				Case 100
					as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o pedido central "+String(al_pedido)+" para a filial "+String(ll_Filial)
					Return False
				Case 0
					If ls_Fornecedor <> as_Fornecedor then
						as_mensagem_log = 'Fornecedor do pedido diferente do Fornecedor da NF'
						Return False
					End if
			End Choose	
			Return True
		End If
	Case -1
		as_mensagem_log = 'Erro ao localizar o pedido dos compradores (' + String(al_pedido) + ' - ' + String( al_filial ) + '). ' + SqlCa.SqlErrText
End Choose

Return False

//Long ll_Filial
//
//select cd_filial
//	into:ll_Filial
//from pedido_central
//where nr_pedido = :al_pedido
//and dh_emissao >= dateadd( day, -60, getdate() )
//Using SqlCa;
//
//Choose Case SqlCa.SqlCode
//			
//	Case 0
//		If al_Filial = ll_Filial Then
//			as_mensagem_log = 'Pedido de Compradores: (' + String(al_pedido) + ' - ' + String( al_filial ) + ') - A filial deve lancar manualmente esta NF'
//			Return True
//		End If
//	Case -1
//		as_mensagem_log = 'Erro ao localizar o pedido dos compradores (' + String(al_pedido) + ' - ' + String( al_filial ) + '). ' + SqlCa.SqlErrText
//End Choose
//
//Return False
end function

public function boolean of_insere_log_importacao (string as_chave_acesso, long al_filial, string as_fornecedor, ref string as_mensagem_log, date adt_emissao, long al_pedido, long al_nr_nf);Long    ll_log

	SELECT	top 1 nr_log
		INTO		:ll_log
	FROM    dbo.log_importacao_nf_ped_elet
		WHERE   de_chave_acesso    = :as_chave_acesso
		AND     cd_distribuidora   = :as_fornecedor
		AND     cd_filial          = :al_filial
    USING SqlCa;

Choose Case SqlCa.SqlCode 
    Case -1
        as_Mensagem_Log = "Erro ao localizar NF na log_importacao_nf_ped_elet " + SqlCa.SQLErrText
        Return False
    Case 100
        // N$$HEX1$$e300$$ENDHEX$$o encontrado - INSERT
        INSERT INTO dbo.log_importacao_nf_ped_elet (
		  dh_movimentacao,
		  dh_importacao,
		  de_chave_acesso,
		  cd_filial,
		  cd_distribuidora,
		  nr_nf,
		  dh_emissao,
		  nr_pedido,
		  de_situacao,
		  id_situacao)
        VALUES (
		  getdate(),
		  getdate(),
		  :as_chave_acesso,
		  :al_filial, 
		  :as_fornecedor, 
		  :al_nr_nf, 
		  :adt_emissao, 
		  :al_pedido, 
		  'NOTA DISPON$$HEX1$$cd00$$ENDHEX$$VEL PARA REALIZA$$HEX2$$c700c300$$ENDHEX$$O DA ENTRADA',
		  'LE')
        USING SqlCa;
        
        Choose Case SqlCa.SqlCode
            Case -1
                as_Mensagem_Log = "Erro ao inserir situa$$HEX2$$e700e300$$ENDHEX$$o na log_importacao_nf_ped_elet " + SqlCa.SQLErrText
                Return False
            Case 0
                // Sucesso no INSERT
        End Choose
        
    Case 0
        // Encontrado - UPDATE
        UPDATE dbo.log_importacao_nf_ped_elet
        SET id_situacao					= 'LE',dh_emissao= :adt_emissao
        WHERE de_chave_acesso		= :as_chave_acesso
        AND cd_distribuidora			= :as_fornecedor
        AND cd_filial						= :al_filial
        USING SqlCa;
        
        Choose Case SqlCa.SqlCode
            Case -1
                as_Mensagem_Log = "Erro ao atualizar situa$$HEX2$$e700e300$$ENDHEX$$o na log_importacao_nf_ped_elet " + SqlCa.SQLErrText
                Return False
            Case 0
                // Sucesso no UPDATE
        End Choose
        
End Choose

Return True

end function

public function boolean of_insere_nf_quimidrol (string as_chave_acesso, string as_diretorio_leitura, ref string as_mensagem_log);String	ls_Xml,&
		ls_Arquivo_Leitura,&
		ls_Arquivo_Erro

Integer	li_FileOpen,&
			li_Cancelada

String	ls_Chave,&
		ls_Serie,&
		ls_CPNJ_Dest,&
		ls_Fornecedor,&
		ls_mensagem_log,&
		ls_pagamento
		
Date	ldt_Emissao
		
Long	ll_Nota,&
		ll_Filial,&
		ll_Achou,&
		ll_Modelo

Decimal	ld_Vl_Bc_Icms,&
			ld_Vl_ICMS,&
			ld_Vl_Bc_Icms_St,&
			ld_Vl_Icms_St,&
			ld_Vl_Total_Produtos,&
			ld_Vl_Ipi,&
			ld_Vl_Frete,&
			ld_Vl_Seguro,&
			ld_Vl_Outras_Despesas,&
			ld_Vl_Total_Nf,&
			ld_Vl_Desconto,&
			ld_vl_total_is,&
			ld_vl_total_bc_cbs_ibs,&
			ld_vl_total_dif_ibs_uf,&
			ld_vl_total_dev_ibs_uf,&
			ld_vl_total_ibs_uf,&
			ld_vl_total_dif_ibs_mun,&
			ld_vl_total_dev_ibs_mun,&
			ld_vl_total_ibs_mun,&
			ld_vl_total_ibs,&
			ld_vl_total_cred_pres_ibs,&
			ld_vl_total_cred_pres_sus_ibs,&
			ld_vl_total_dif_cbs,&
			ld_vl_total_dev_cbs,&
			ld_vl_total_cbs,&
			ld_vl_total_cred_pres_cbs,&
			ld_vl_total_cred_pres_sus_cbs

t_infnfe lt_InfNFe
dc_uo_nfe lo_NFE

try
	ls_Arquivo_Leitura = as_diretorio_leitura + as_chave_acesso+"-nfe.xml"
	
	li_FileOpen = FileOpen (ls_Arquivo_Leitura  , TextMode! , Read!, LockRead! )
	FileReadEx (li_FileOpen, ls_Xml) 
	FileClose (li_FileOpen)
	FileDelete (ls_Arquivo_Leitura)
			
	If ls_Xml <> "" Then
		
		lo_NFE 	= Create dc_uo_nfe
		If not lo_NFE.of_read_xml(ls_Xml, True, Ref lt_InfNFe) Then
		   	as_mensagem_log  = "Erro ao ler o arquivo XML '" + ls_Arquivo_Leitura
			Return  False
		End If
		
		ls_Chave 			= 	lt_InfNFe.id
		ls_Serie				=	lt_InfNFe.ide.serie
		ldt_Emissao			=	lt_InfNFe.ide.demi
		ll_Nota				=	lt_InfNFe.ide.nnf
		ll_Modelo			=	lt_InfNFe.ide.modelo
		
		//NFC-e
		If ll_Modelo = 65 Then
			Return True
		End If
		
		ld_Vl_Bc_Icms 						= round(lt_InfNfe.total.ICMSTot.vBC, 2)
		ld_Vl_ICMS 							= round(lt_InfNfe.total.ICMSTot.vICMS, 2)
		ld_Vl_Bc_Icms_St 					= round(lt_InfNfe.total.ICMSTot.vBCST, 2)
		ld_Vl_Icms_St 						= round(lt_InfNfe.total.ICMSTot.vST, 2)
		ld_Vl_Total_Produtos 	   	= Round((lt_InfNfe.total.ICMSTot.vProd - lt_InfNfe.total.ICMSTot.vDesc), 2)
		ld_Vl_Ipi 							= round(lt_InfNfe.total.ICMSTot.vIPI, 2)
		ld_Vl_Frete 						= round(lt_InfNfe.total.ICMSTot.vFrete, 2)
		ld_Vl_Seguro 						= round(lt_InfNfe.total.ICMSTot.vSeg, 2)
		ld_Vl_Outras_Despesas 			= round(lt_InfNfe.total.ICMSTot.vOutro, 2)
		ld_Vl_Desconto 					= 0
		ld_Vl_Total_Nf 					= round(lt_InfNfe.total.ICMSTot.vNF, 2)
		ls_CPNJ_Dest						= lt_InfNFe.dest.cnpj
		
		/*Reforma Tribut$$HEX1$$e100$$ENDHEX$$ria*/
		ld_vl_total_is 				= Round(lt_InfNFe.total.istot.vis, 2)
		ld_vl_total_bc_cbs_ibs 		= Round(lt_InfNFe.total.IBSCBSTot.vbcibscbs, 2)
		ld_vl_total_dif_ibs_uf		= Round(lt_InfNFe.total.IBSCBSTot.gibs_tot.gibsuf_tot.vdif, 2)
		ld_vl_total_dev_ibs_uf		= Round(lt_InfNFe.total.IBSCBSTot.gibs_tot.gibsuf_tot.vdevtrib, 2)
		ld_vl_total_ibs_uf			= Round(lt_InfNFe.total.IBSCBSTot.gibs_tot.gibsuf_tot.vibsuf, 2)
		ld_vl_total_dif_ibs_mun		= Round(lt_InfNFe.total.IBSCBSTot.gibs_tot.gibsmun_tot.vdif, 2)
		ld_vl_total_dev_ibs_mun		= Round(lt_InfNFe.total.IBSCBSTot.gibs_tot.gibsmun_tot.vdevtrib, 2)
		ld_vl_total_ibs_mun			= Round(lt_InfNFe.total.IBSCBSTot.gibs_tot.gibsmun_tot.vibsmun, 2)
		ld_vl_total_ibs				= Round(lt_InfNFe.total.IBSCBSTot.gibs_tot.vibs, 2)
		ld_vl_total_dif_cbs	 		= Round(lt_InfNFe.total.IBSCBSTot.gcbs_tot.vdif, 2)
		ld_vl_total_dev_cbs			= Round(lt_InfNFe.total.IBSCBSTot.gcbs_tot.vdevtrib, 2)
		ld_vl_total_cbs				= Round(lt_InfNFe.total.IBSCBSTot.gcbs_tot.vcbs, 2)
	//	ld_vl_total_cred_pres_cbs
	//	ld_vl_total_cred_pres_sus_cbs
	//	ld_vl_total_cred_pres_ibs
	//	ld_vl_total_cred_pres_sus_ibs
			
			
		If Not of_verifica_cancelamento(as_Chave_Acesso, ref as_mensagem_log) Then
			Return False
		End If
			
		If lt_InfNFe.ide.tpnf = 0 Then
			as_Mensagem_Log = "Essa nota foi emitida como nota de entrada."
			Return False			
		End If
			
		If lt_InfNFe.ide.tpamb = 2 Then
			as_Mensagem_Log = "Essa nota foi emitida em ambiente de homologa$$HEX2$$e700e300$$ENDHEX$$o."
			Return False			
		End If
			
		//Verifica se o XML $$HEX1$$e900$$ENDHEX$$ de estorno
		If lt_InfNFe.ide.finnfe <> 1 Then
			If Not of_atualiza_finalidade_nfe(String(lt_InfNFe.ide.finnfe), as_Chave_Acesso, Ref as_Mensagem_Log ) Then
				Return False		
			End If
		End If
				
		//QUIMIDROL De Curitiba
//		If Mid(as_Chave_Acesso, 7, 14) = "84704683000239" Then
//			ls_Fornecedor = '053402899'
//		ElseIf Mid(as_Chave_Acesso, 7, 14) = "84704683000662" Then
//			ls_Fornecedor = '053406107'
//		ElseIf Mid(as_Chave_Acesso, 7, 14) = "77765840000170" Then //CONTABILISTA PAPELARIA E SUPRI
//			ls_Fornecedor =  '053406108'	
//		Else
//			ls_Fornecedor = '053400532'
//		End If

		If Not of_Localiza_Codigo_Fornecedor(Mid(as_Chave_Acesso, 7, 14), Ref ls_Fornecedor, Ref as_Mensagem_Log) Then
			Return False
		End If
		
		If Not of_Localiza_Forma_Pagamento(ls_Xml,ref ls_pagamento,ref ls_mensagem_log) Then
			Return False
		End If
		
		Select v.cd_filial
		Into :ll_Filial
		From 	vw_filial v 
		Inner Join parametro_odbc p on p.cd_filial = v.cd_filial
		Where v.nr_cgc = :ls_CPNJ_Dest
		Using SqlCa;
		
		If SqlCa.SqlCode = - 1 Then
			as_mensagem_log = "Erro ao localizar o c$$HEX1$$f300$$ENDHEX$$digo da filial: "+ SqlCa.SQLErrText
			Return False	
		End If
		
		If IsNull(ll_Filial) or ll_Filial = 0 Then
			
			Select top 1 v.cd_filial
			Into :ll_Filial
			From 	vw_filial v 
			Where v.nr_cgc = :ls_CPNJ_Dest
			Using SqlCa;
			
			If SqlCa.SqlCode = - 1 Then
				as_mensagem_log = "Erro ao localizar o c$$HEX1$$f300$$ENDHEX$$digo da filial: "+ SqlCa.SQLErrText
				Return False	
			End If
			
		End If
		
		Select count(*) 
		Into :ll_Achou
		from nfe_compra_pendente
		Where cd_filial = :ll_Filial
			and cd_fornecedor 	= :ls_Fornecedor
			and nr_nf				= :ll_Nota
			and de_especie 		= 'NFE'
			and de_serie 			= :ls_Serie
		Using SqlCa;
		
		If SqlCa.SqlCode = - 1 Then
			as_mensagem_log = "Erro ao localizar a 'nfe_compra_pendente': "+ SqlCa.SQLErrText
			Return False	
		End If
		
		If ll_Achou > 0 Then
			Return True
		End If	
		
		INSERT INTO nfe_compra_pendente  ( 	  cd_filial,   
															  cd_fornecedor,   
															  nr_nf,   
															  de_especie,   
															  de_serie,   
															  dh_emissao,   
															  vl_bc_icms,   
															  vl_icms,   
															  vl_bc_icms_st,   
															  vl_icms_st,   
															  vl_total_produtos,   
															  vl_ipi,   
															  vl_frete,   
															  vl_seguro,   
															  vl_outras_despesas,   
															  vl_desconto,   
															  vl_total_nf,   
															  de_chave_acesso,   
															  nr_pedido,   
															  id_bonificacao,   
															  dh_importacao,
															  cd_meio_pagamento, 
															  vl_total_is, 
															  vl_total_bc_cbs_ibs,
															  vl_total_dif_ibs_uf, 
															  vl_total_dev_ibs_uf, 
															  vl_total_ibs_uf, 
															  vl_total_dif_ibs_mun, 
															  vl_total_dev_ibs_mun, 
															  vl_total_ibs_mun, 
															  vl_total_ibs, 
															  vl_total_cred_pres_ibs, 
															  vl_total_cred_pres_sus_ibs, 
															  vl_total_dif_cbs, 
															  vl_total_dev_cbs, 
															  vl_total_cbs, 
															  vl_total_cred_pres_cbs, 
															  vl_total_cred_pres_sus_cbs)  
		VALUES (  :ll_Filial,							//cd_filial,   
					  :ls_Fornecedor, 					//cd_fornecedor,   
					  :ll_Nota,								//nr_nf,   
					  'NFE',									//de_especie,   
					  :ls_Serie,							//de_serie,   
					  :ldt_Emissao,						//dh_emissao,   
					  :ld_Vl_Bc_Icms,						//vl_bc_icms,   
					  :ld_Vl_ICMS,							//vl_icms,   
					  :ld_Vl_Bc_Icms_St,					//vl_bc_icms_st,   
					  :ld_Vl_Icms_St,						//vl_icms_st,   
					  :ld_Vl_Total_Produtos,			//vl_total_produtos,   
					  :ld_Vl_Ipi,							//vl_ipi,   
					  :ld_Vl_Frete,						//vl_frete,   
					  :ld_Vl_Seguro,						//vl_seguro,   
					  :ld_Vl_Outras_Despesas,			//vl_outras_despesas,   
					  :ld_Vl_Desconto,					//vl_desconto,   
					  :ld_Vl_Total_Nf,					//vl_total_nf,   
					  :ls_Chave,							//de_chave_acesso,   
					  1,										//nr_pedido,   
					  null,									//id_bonificacao,   
					  getdate(),							//dh_importacao
					  :ls_pagamento,						//Meio de pagamento
					  :ld_vl_total_is, 					//vl_total_is
					  :ld_vl_total_bc_cbs_ibs,			//vl_total_bc_cbs_ibs
					  :ld_vl_total_dif_ibs_uf, 		//vl_total_dif_ibs_uf
					  :ld_vl_total_dev_ibs_uf, 		//vl_total_dev_ibs_uf
					  :ld_vl_total_ibs_uf,  			//vl_total_ibs_uf
					  :ld_vl_total_dif_ibs_mun, 		//vl_total_dif_ibs_mun
					  :ld_vl_total_dev_ibs_mun, 		//vl_total_dev_ibs_mun
					  :ld_vl_total_ibs_mun, 			//vl_total_ibs_mun
					  :ld_vl_total_ibs, 					//vl_total_ibs
					  :ld_vl_total_cred_pres_ibs, 	//vl_total_cred_pres_ibs
					  :ld_vl_total_cred_pres_sus_ibs,//vl_total_cred_pres_sus_ibs
					  :ld_vl_total_dif_cbs, 	 		//vl_total_dif_cbs
					  :ld_vl_total_dev_cbs, 	 		//vl_total_dev_cbs
					  :ld_vl_total_cbs, 			 		//vl_total_cbs
					  :ld_vl_total_cred_pres_cbs, 	//vl_total_cred_pres_cbs
					  :ld_vl_total_cred_pres_sus_cbs)//vl_total_cred_pres_sus_cbs
	  	Using SqlCa;
			
		If SqlCa.SqlCode = -1 Then
			as_mensagem_log = "Erro no insert da tabela 'nfe_compra_pendente': "+ SqlCa.SQLErrText
			SqlCa.of_Rollback( )
			Return False	
		End If
		
		If Not of_insere_itens_nf_quimidrol(lt_InfNFe, ll_Filial, ls_Fornecedor, ll_Nota, ls_Serie, as_mensagem_log) Then 
			SqlCa.of_RollBack()
			Return False		
		End If
			
		If Not of_Insere_Titulos_quimidrol(lt_InfNFe,ll_Filial, ls_Fornecedor,ll_Nota,'NFE',ls_Serie, Ref as_mensagem_log) Then
			SqlCa.of_Rollback( )
			Return False	
		End If
		
		Sqlca.of_Commit();
	End If

finally
	Destroy lo_NFE
end try

Return True
end function

public function boolean of_insere_titulos_quimidrol (t_infnfe at_infnfe, long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, ref string as_mensagem_log);Date		ldt_Emissao
Date		ldt_Vencimento

Double	ld_pc_valor_total
Double 	ld_soma_titulos = 0.00
Double	ld_Vl_Pagar

Long		ll_Qt_Titulos
Long		ll_Count
Long		ll_Dias_Pagto
Long		ll_Linhas
Long		ll_Linha
Long 		ll_qt_dias_vencimento

String	ls_Alfabeto
String	ls_Nr_Titulo_Pagar
String	ls_Nosso_Numero

ll_Qt_Titulos	= UpperBound(at_infnfe.cobr.dup[])
ldt_Emissao 	= at_infnfe.ide.demi 
ls_Alfabeto		= "ABCDEFGHIJKLMNOPQRSTUVXZYW"
as_mensagem_log = ""

	//Valida Parcelas Titulos
	If Not of_valida_parcelas_titulo( at_infnfe, as_Fornecedor, Ref as_mensagem_log ) Then Return True
	
	For ll_Count = 1 to  ll_Qt_Titulos
	
		ls_Nr_Titulo_Pagar	= String(al_Nota)+as_Serie+Mid(ls_Alfabeto, ll_Count, 1)	
		ldt_Vencimento 		= at_infnfe.cobr.dup[ ll_Count ].dvenc
		
		ld_Vl_Pagar			= at_infnfe.cobr.dup[ ll_Count ].vdup
		
		Insert into nfe_compra_pendente_titulo(	
					cd_filial,
					cd_fornecedor,
					nr_titulo_pagar,
					dh_emissao,
					dh_vencimento,
					vl_pagar,
					nr_nf,
					de_especie,
					de_serie)
		values(	:al_Filial,
					:as_Fornecedor,
					:ls_Nr_Titulo_Pagar,
					:ldt_Emissao,
					:ldt_Vencimento,
					:ld_Vl_Pagar,
					:al_Nota,
					:as_Especie,
					:as_Serie)
		Using SqlCa;	
		
		Choose Case SqlCa.SqlCode
			Case -1		
				as_Mensagem_Log = "Erro ao inserir os t$$HEX1$$ed00$$ENDHEX$$tulos da nota: "+ SqlCa.SqlErrText
				Return False
				
			Case 0		
				
			Case Else
				as_Mensagem_Log = "Erro desconhecido ao inserir os t$$HEX1$$ed00$$ENDHEX$$tulos da nota"
				Return False
		End Choose
		
	Next
	
Return True
end function

public function boolean of_localiza_forma_pagamento (string as_xml, ref string as_pagamento, ref string as_mensagem_log);String 	ls_TPag_Value
String 	ls_Tag_inicio	= "<tPag>"
String 	ls_Tag_fim		= "</tPag>"
Long		ll_Posicao_inicial_tag
Long		ll_Posicao_final_tag

// Extrair o valor dentro da tag <tPag>

ll_Posicao_inicial_tag	= Pos(as_Xml, ls_Tag_inicio)
ll_Posicao_final_tag		= Pos(as_Xml, ls_Tag_fim)

If ll_Posicao_inicial_tag > 0 And ll_Posicao_final_tag > ll_Posicao_inicial_tag Then

	as_pagamento	= Mid(as_Xml, ll_Posicao_inicial_tag + Len(ls_Tag_inicio), ll_Posicao_final_tag - (ll_Posicao_inicial_tag + Len(ls_Tag_inicio)))
Else
	as_mensagem_log = "Tag <tPag> n$$HEX1$$e300$$ENDHEX$$o encontrada no XML."
	Return False
End If

end function

public function boolean of_verifica_pedido (long al_filial, ref long al_pedido, string as_chave_acesso, string as_ean, string as_dados_adicionais, ref string as_mensagem, ref long al_pedido_incluido, date adt_emissao_nota, string as_id_conexao, string as_infadicional, string as_fornecedor, boolean ab_importa_sem_pedido, boolean ab_reimportacao, t_infnfe at_infnfe, string ls_sistema_java, ref boolean ab_pedido_central, ref long al_pedido_informado);Boolean	lb_encontrado

String ls_CGC_Fornecedor, ls_distribuidora, ls_Situacao, ls_Chave, ls_Id_Conexao

DateTime ldh_Falta

Long ll_Pedido_Distribuidora, ll_Pedido_Dist_Conexao

ls_Chave = "(" + String(al_Filial) + " - " + String(al_Pedido) + ")"

ab_Pedido_Central = False

// Esta rotina foi criada porque a STACRUZ n$$HEX1$$e300$$ENDHEX$$o estava enviando a XVAN.
// A fun$$HEX2$$e700e300$$ENDHEX$$o verifica se existe algum pedido em aberto, se $$HEX1$$e900$$ENDHEX$$ verificado se todos os produtos do XML est$$HEX1$$e300$$ENDHEX$$o no pedido.
// Data: 27/11/2015
// Respons$$HEX1$$e100$$ENDHEX$$vel: S$$HEX1$$e900$$ENDHEX$$rgio
// Comentado porque esta rotina deve ser utilizada somente em casos pontuais.
If ib_sem_xvan Then
	If Not IsNull(as_Id_Conexao)  and as_Id_Conexao <> "" Then
		If of_verifica_pedido_conexao_aberto(as_fornecedor, al_filial,as_Id_Conexao, at_infnfe,  ll_Pedido_Dist_Conexao, as_mensagem) Then
			If Not IsNull(ll_Pedido_Dist_Conexao) and ll_Pedido_Dist_Conexao > 0 Then
				al_Pedido = ll_Pedido_Dist_Conexao
				Return True
			End If
		Else
			Return False
		End If
	End If
End If

If IsNull(al_Pedido) or al_Pedido = 0 Then
	as_Mensagem = "Numero do pedido zerado ou nulo da filial '" + String(al_Filial) + "' ." 
	Return False
End If

//Se for uma reimporta$$HEX2$$e700e300$$ENDHEX$$o, o sistema ir$$HEX1$$e100$$ENDHEX$$ procurar pedido de at$$HEX1$$e900$$ENDHEX$$ 500 dias atr$$HEX1$$e100$$ENDHEX$$s, sen$$HEX1$$e300$$ENDHEX$$o procura o pedido por at$$HEX1$$e900$$ENDHEX$$ 5 meses.
If Not IsNull(as_Id_Conexao) And as_Id_Conexao <> "" Then
	If ab_Reimportacao Then



		Select cd_distribuidora, id_situacao, dh_falta, nr_pedido_distribuidora
		Into :ls_Distribuidora, :ls_Situacao, :ldh_Falta, :ll_Pedido_Distribuidora
		from pedido_distribuidora 
		where nr_pedido_conexao		 		= :al_Pedido
			and cd_filial 						= :al_Filial
			and cd_distribuidora				= :as_fornecedor
			and id_projeto_conexao			= :as_Id_Conexao
			and dh_emissao						>= dateadd(day, -500, getdate() )
			and nr_pedido_distribuidora	= (
				Select min(nr_pedido_distribuidora)
					From	pedido_distribuidora
					where	nr_pedido_conexao = :al_pedido
					and cd_filial 				= :al_Filial
					and cd_distribuidora		= :as_fornecedor
					and dh_emissao				>= dateadd(day, -500, getdate() ))
		Using SqlCa;
	End If
	
	If Not ab_Reimportacao Then
		Select cd_distribuidora, id_situacao, dh_falta, nr_pedido_distribuidora
		Into :ls_Distribuidora, :ls_Situacao, :ldh_Falta, :ll_Pedido_Distribuidora
		from pedido_distribuidora 
		where nr_pedido_conexao		 		= :al_Pedido
			and cd_filial 						= :al_Filial
			and cd_distribuidora				= :as_fornecedor
			and id_projeto_conexao			= :as_Id_Conexao
			and dh_emissao						>= dateadd(day, -150, getdate() )
			and nr_pedido_distribuidora	= (
				Select min(nr_pedido_distribuidora)
					From	pedido_distribuidora
					where	nr_pedido_conexao = :al_pedido
					and cd_filial 				= :al_Filial
					and cd_distribuidora		= :as_fornecedor
					and id_projeto_conexao	= :as_Id_Conexao
					and dh_emissao				>= dateadd(day, -150, getdate() ))
		Using SqlCa;
	End If
	
Else
	
	If ab_Reimportacao Then
		Select cd_distribuidora, id_situacao, dh_falta
		Into :ls_Distribuidora, :ls_Situacao, :ldh_Falta
		from pedido_distribuidora 
		where nr_pedido_distribuidora 			= :al_Pedido
			and cd_filial 								= :al_Filial
			and cd_distribuidora						= :as_fornecedor
			and dh_emissao								>= dateadd(day, -500, getdate() )
			and nr_pedido_distribuidora			= (
				Select min(nr_pedido_distribuidora)
					From	pedido_distribuidora
					where	nr_pedido_distribuidora = :al_pedido
					and cd_filial 						= :al_Filial
					and cd_distribuidora				= :as_fornecedor
					and dh_emissao						>= dateadd(day, -500, getdate() ))
		Using SqlCa;
	End If
	
	If Not ab_Reimportacao Then
		Select cd_distribuidora, id_situacao, dh_falta
		Into :ls_Distribuidora, :ls_Situacao, :ldh_Falta
		from pedido_distribuidora 
		where nr_pedido_distribuidora 			= :al_Pedido
			and cd_filial 								= :al_Filial
			and cd_distribuidora						= :as_fornecedor
			and dh_emissao								>= dateadd(day, -500, getdate() )
			and nr_pedido_distribuidora			= (
				Select min(nr_pedido_distribuidora)
					From	pedido_distribuidora
					where	nr_pedido_distribuidora = :al_pedido
					and cd_filial 						= :al_Filial
					and cd_distribuidora				= :as_fornecedor
					and dh_emissao						>= dateadd(day, -500, getdate() ))
		Using SqlCa;
	End If
End If

Choose Case  SqlCa.SqlCode 
	Case 0
		
		// Devolve o pedido distribuidora.
		//If Upper(as_projeto_conexao) = 'PHARMALINK' Or Upper(as_projeto_conexao) = 'ENTIRE' Then
		If Not IsNull(as_Id_Conexao) And as_Id_Conexao <> "" Then
			al_Pedido = ll_Pedido_Distribuidora
		End If
		
		//Reimportacao
		If ab_reimportacao Then Return True
		
		//FOI REJEITADO MANUALMENTE 
		If ls_Situacao = 'J' and IsNull(ldh_Falta) Then
			as_Mensagem =  ls_Chave + " - Registro Cabe$$HEX1$$e700$$ENDHEX$$alho - PEDIDO FOI REJEITADO MANUALMENTE"
			Return False
		End If
		
		If ls_Situacao <> "C" and ls_Situacao <> 'F' Then
			
			//If ls_Situacao = 'N' And as_projeto_conexao <> "" Then Return True
			
			//Se o pedido for a Servimed/Servimed Jacarezinho ir$$HEX1$$e100$$ENDHEX$$ importar mesmo o pedido sendo 'X'
			//Isso acontece porque o pedido $$HEX1$$e900$$ENDHEX$$ rejeitado diretamente no BD. 
			//If ls_Situacao = 'X' And ( as_fornecedor = '053405383' Or as_fornecedor = '053405889' ) Then Return True
			
			as_Mensagem = ls_Chave + " - Situa$$HEX2$$e700e300$$ENDHEX$$o '" + ls_Situacao + "' do Pedido " + String(al_Pedido) + " Inv$$HEX1$$e100$$ENDHEX$$lida"
			Return False
		End If
		
	Case 100
		
//		// Esta rotina foi criada porque a STACRUZ n$$HEX1$$e300$$ENDHEX$$o estava enviando a XVAN.
//		// A fun$$HEX2$$e700e300$$ENDHEX$$o verifica se existe algum pedido em aberto, se $$HEX1$$e900$$ENDHEX$$ verificado se todos os produtos do XML est$$HEX1$$e300$$ENDHEX$$o no pedido.
//		// Data: 27/11/2015
//		// Respons$$HEX1$$e100$$ENDHEX$$vel: S$$HEX1$$e900$$ENDHEX$$rgio
//		// Comentado porque esta rotina deve ser utilizada somente em casos pontuais.
//		If ib_sem_xvan Then
//			If Not IsNull(as_Id_Conexao)  and as_Id_Conexao <> "" Then
//				If of_verifica_pedido_conexao_aberto(as_fornecedor, al_filial,as_Id_Conexao, at_infnfe,  ll_Pedido_Dist_Conexao, as_mensagem) Then
//					If Not IsNull(ll_Pedido_Dist_Conexao) and ll_Pedido_Dist_Conexao > 0 Then
//						al_Pedido = ll_Pedido_Dist_Conexao
//						Return True
//					End If
//				Else
//					Return False
//				End If
//			End If
//		End If
		
		If Not IsNull(as_Id_Conexao) And as_Id_Conexao <> "" And ab_importa_sem_pedido Then
			// Desenvolvimento
			If Not of_inclui_pedido_pharmalink(al_Filial,as_fornecedor, adt_emissao_nota, al_Pedido, ref al_pedido_incluido, as_ean, as_Mensagem) Then
				Return False
			End If
		Else
			//Verifica Pedido Central - Entrada Manual
			If of_verifica_pedido_central( al_Pedido, al_Filial,as_fornecedor, Ref as_mensagem ) Then
				If ls_Sistema_Java = "S" Then
					ab_Pedido_Central = True
					If ib_Pedido_informado then
						al_pedido_informado = al_Pedido
					End if
					Return True
				Else
					Return False
				End If
			Else
				If IsNUll (as_mensagem) then
					If not of_obtem_pedido_pela_chave (as_chave_acesso, Ref al_pedido_informado, Ref as_mensagem) then
						If as_mensagem = '' then
							as_Mensagem = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o pedido '" + String (al_Pedido) + "' da filial '" + String (al_Filial) + "'."
						End if
						Return False
					else
						Return True
					End if
				else
					Return False
				End if
			End If
		End If
	Case -1		
		as_mensagem = "Erro ao localizar o n$$HEX1$$fa00$$ENDHEX$$mero do pedido: "+SqlCa.SQLErrText
		Return False	
End Choose
		
Return True
end function

public function boolean of_obtem_pedido_pela_chave (string as_chave_acesso, ref long al_pedido, ref string as_erro);DateTime				ldh_importacao
dc_uo_transacao	ltr_cadastro

SetNull (al_Pedido)
as_erro = ''

SELECT
		nr_pedido,
		dh_importacao_nfe
  INTO
  		:al_pedido,
		:ldh_importacao
  FROM
  		nfe_sem_pedido
 WHERE
 		de_chave_acesso = :as_chave_acesso
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		as_erro = "Erro ao pesquisar o pedido na tabela 'nfe_sem_pedido': " + SQLCA.SQLErrText
		Return False
		
	case 100
		//Se a chave n$$HEX1$$e300$$ENDHEX$$o estiver cadastrada na tabela, insere para que o n$$HEX1$$fa00$$ENDHEX$$mero do pedido seja informado manualmente
		ltr_cadastro = Create dc_uo_transacao
		ltr_cadastro.ivs_database = "SYBASE"
		ltr_cadastro.of_Connect (gvo_Aplicacao.ivs_DataSource, 'SQLCA - Consulta (AutoCommit)')
		ltr_cadastro.AutoCommit	= True
		
		INSERT INTO nfe_sem_pedido
						(	de_chave_acesso
						,	dh_inclusao_chave
						)
			VALUES	(	:as_chave_acesso
						,	GETDATE ()
						)
		 USING ltr_cadastro;
		
		If ltr_cadastro.SQLCode < 0 then
			as_erro = "Erro ao cadastrar a chave de acesso na tabela 'nfe_sem_pedido': " + ltr_cadastro.SQLErrText
		End If
		
		Destroy ltr_cadastro
		
		Return False
		
	case 0
		If IsNull (al_Pedido) then
			Return False
		End if
		
		If not IsNull (ldh_importacao) then
			as_erro = 'Nota originalmente sem pedido j$$HEX1$$e100$$ENDHEX$$ importada'
			Return False
		End if
		
		ib_Pedido_Informado = True
		
End choose

Return True
end function

public function boolean of_registra_importacao_nfe_sem_pedido (string as_chave_acesso, ref string as_erro);UPDATE nfe_sem_pedido
	SET dh_importacao_nfe = GETDATE ()
 WHERE de_chave_acesso = :as_chave_acesso
 USING SQLCA;

If SQLCA.SQLCode < 0 then
	as_erro = 'Erro ao marcar a importa$$HEX2$$e700e300$$ENDHEX$$o da nfe_sem_pedido: ' + SQLCA.SQLErrText
	Return False
End if

Return True
end function

public function boolean of_valida_pedido_xml (string as_pedido_compra, string as_pedido_produto, string as_distribuidora, boolean ab_importa_sem_pedido, ref long al_pedido, ref string as_projeto, ref string as_mensagem_log, long al_filial, string as_ean, string as_chave_acesso);String ls_Pedido

String ls_prefixo_pharmalink

//Tratamento PROFARMA para Pharmalink
If as_distribuidora = "053404408" Or as_distribuidora = "053405364" Or as_distribuidora = "053405857" or as_distribuidora = "053406098" Then

	If Not IsNull(as_pedido_compra) and Trim(as_pedido_compra) <> '' Then
		
		ls_prefixo_pharmalink = Mid(as_pedido_compra, 1, 3)
		
		Choose Case ls_prefixo_pharmalink
			//C$$HEX1$$f300$$ENDHEX$$digo enviado pela Profarma com as possiveis combinacoes dos pedidos PHARMALINK's
			Case '26Z','09I','42B','40C','06T','13Y','90X','91P','80L','28Q','85J','31M','23U','24V','70N','30D','60W','201', '651','44P'
				ls_Pedido = Mid(as_pedido_compra, 4)
				as_projeto = "PHARMALINK"	
				
			Case Else //Pedido Normal
				ls_Pedido = Trim(as_pedido_compra)
		End Choose
				
	Else
		//Se nao tem a TAG <xPEd> $$HEX1$$e900$$ENDHEX$$ porque o pedido $$HEX1$$e900$$ENDHEX$$ de REPOSICAO
		//ivb_Inclui_Pedido_Projeto_Conexao = True
		al_Pedido = 0 
		Return True	
	End If
	
Else //Demais Distribuidoras
	If Not IsNull(as_pedido_compra) and Trim(as_pedido_compra) <> '' Then
		// Utiliza o n$$HEX1$$fa00$$ENDHEX$$mero do pedido na tag <compra>
		ls_Pedido = Trim(as_pedido_compra)
	Else
		// Utiliza o n$$HEX1$$fa00$$ENDHEX$$mero do pedido informado na tag <prod> caso nao seja informado na tag <compra>
		ls_Pedido = Trim(as_pedido_produto)
	End If

End If

//If ab_Importa_sem_Pedido Then
//	//For$$HEX1$$e700$$ENDHEX$$a a atualizacao mesmo sem o numero do pedido 
//	// *** INCLUI UM NOVO PEDIDO
//	al_Pedido = 0 
//	Return True
//End If

// Desenvolvimento
//ls_Pedido = ''

//Importa$$HEX2$$e700e300$$ENDHEX$$o manual sem pedido conex$$HEX1$$e300$$ENDHEX$$o
If ib_Imp_Manual_Sem_Pedido_Conexao and ab_importa_sem_pedido and ls_Pedido = "" Then
	If Not of_Verifica_Pedido_Conexao_Aberto(as_distribuidora, al_filial, as_ean, ref ls_Pedido, ref as_mensagem_log) Then Return False
End If

If ls_Pedido = "" Then
	If ib_sem_xvan Then
		al_Pedido = 0 
		Return True
	Else
		////
		If not of_obtem_pedido_pela_chave (as_chave_acesso, Ref al_pedido, Ref as_Mensagem_Log) then
			If as_Mensagem_Log = '' then
				as_Mensagem_Log = "O pedido da filial '" + String (al_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o foi encontrado no XML nem nas tabelas."
			End if
			Return False
		else
			Return True
		End if
		////
	End If
End If

If Not IsNumber(ls_Pedido) Then
	IF ab_Importa_sem_Pedido Then
		al_Pedido = 0 
		Return True
	Else
		as_mensagem_log = " O pedido '"+ ls_Pedido +"' no XML n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ valido, ele deve conter apenas n$$HEX1$$fa00$$ENDHEX$$meros. "
		Return False	
	End If
End If

al_Pedido	= Long(ls_Pedido)

Return True
end function

public function boolean of_insere_cabecalho (t_infnfe a_infnfe, long al_pedido, string as_chave_nota, long al_filial, string ls_permite_nota_sem_pedido, string as_fornecedor, boolean ab_pedido_central, ref string as_mensagem_log);Date 		ld_dh_recebimento_sap, ldt_Dt_Movimentacao_Caixa
DateTime ldh_Emissao, ldh_Registro
Double 	ld_Vl_Bc_Icms, ld_Vl_ICMS, ld_Vl_Bc_Icms_St, ld_Vl_Icms_St, ld_Vl_Icms_Repassado, ld_Vl_Total_Produtos, ld_Vl_Ipi, ld_Vl_Frete, &
			ld_Vl_Seguro, ld_Vl_Outras_Despesas, ld_Vl_Desconto, ld_Vl_Indenizacao, ld_Vl_Total_Nf, ld_vl_total_is, ld_vl_total_bc_cbs_ibs, &
			ld_vl_total_dif_ibs_uf, ld_vl_total_dev_ibs_uf, ld_vl_total_ibs_uf, ld_vl_total_dif_ibs_mun, ld_vl_total_dev_ibs_mun, &
			ld_vl_total_ibs_mun, ld_vl_total_ibs, ld_vl_total_dif_cbs, ld_vl_total_dev_cbs, ld_vl_total_cbs
Long 		ll_Pedido, ll_Qt_Pedido, ll_Linhas, ll_Nr_Pedido, ll_Itens, ll_Nr_Pedido_Central
			dc_uo_ds_base lvds
String 	ls_Cnpj, ls_Id_Bonificacao, ls_Nr_MAtricula_Registro, ls_De_Chave_Acesso, ls_Crt, ls_Mensagem_Log, ls_Cgc_Fornecedor


SetNull(ll_Nr_Pedido_Central)

If ls_Permite_Nota_Sem_Pedido = "S" Then
	is_Fornecedor = as_Fornecedor
	
ElseIf ab_Pedido_Central Then
	ll_Nr_Pedido_Central = al_Pedido
	
	SetNull(al_Pedido)
	
	select a.cd_fornecedor , b.nr_cgc
	into :is_Fornecedor, :ls_Cgc_Fornecedor
	from pedido_central a
	inner join fornecedor b on b.cd_fornecedor = a.cd_fornecedor
	where a.nr_pedido = :ll_Nr_Pedido_Central
	and a.cd_filial = :al_Filial
	Using SqlCa;
			
	Choose Case  SqlCa.SqlCode 
		Case -1
			as_Mensagem_Log = "Erro ao localizar o pedido central: " + SqlCa.SQLErrText
			Return False
		Case 100
			as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o pedido central "+String(ll_Nr_Pedido_Central)+" para a filial "+String(al_Filial)
			Return False
	End Choose
Else
	select a.cd_distribuidora , b.nr_cgc
	into :is_Fornecedor, :ls_Cgc_Fornecedor
	from pedido_distribuidora a
	inner join fornecedor b on b.cd_fornecedor = a.cd_distribuidora
	where a.nr_pedido_distribuidora = :al_Pedido
	and a.cd_filial = :al_Filial
	Using SqlCa;
			
	Choose Case  SqlCa.SqlCode 
		Case -1
			as_Mensagem_Log = "Erro ao localizar a filial: " + SqlCa.SQLErrText
			Return False
		Case 100
			//Pedido n$$HEX1$$e300$$ENDHEX$$o encontrado
	End Choose
End If

ls_Crt = String(a_infnfe.emit.crt)
If Not of_Atualiza_Crt(ls_Crt, is_Fornecedor, Ref ls_Mensagem_Log) Then
	as_Mensagem_Log = "Erro ao atualizar a CRT: " + ls_Mensagem_Log
	Return False
End If
	
il_Filial 							= al_Filial
il_Nf 								= a_infnfe.ide.nNF
ldh_Emissao 						= DateTime(a_infnfe.ide.dEmi)
ld_Vl_Bc_Icms 						= a_infnfe.total.ICMSTot.vBC
ld_Vl_ICMS 							= a_infnfe.total.ICMSTot.vICMS
ld_Vl_Bc_Icms_St 					= a_infnfe.total.ICMSTot.vBCST
ld_Vl_Icms_St 						= a_infnfe.total.ICMSTot.vST
ld_Vl_Icms_Repassado 			= 0
ld_Vl_Total_Produtos 			= Round((a_infnfe.total.ICMSTot.vProd - a_infnfe.total.ICMSTot.vDesc), 2)
ld_Vl_Ipi 							= a_infnfe.total.ICMSTot.vIPI
ld_Vl_Frete 						= a_infnfe.total.ICMSTot.vFrete
ld_Vl_Seguro 						= a_infnfe.total.ICMSTot.vSeg
ld_Vl_Outras_Despesas 			= a_infnfe.total.ICMSTot.vOutro
ld_Vl_Desconto 					= 0
ld_Vl_Indenizacao 				= 0
ld_Vl_Total_Nf 					= a_infnfe.total.ICMSTot.vNF
ld_vl_total_is						= a_infnfe.total.istot.vis
ld_vl_total_bc_cbs_ibs			= a_infnfe.total.IBSCBSTot.vBCIBSCBS
ld_vl_total_dif_ibs_uf			= a_infnfe.total.IBSCBSTot.gIBS_tot.gIBSUF_tot.vDif
ld_vl_total_dev_ibs_uf			= a_infnfe.total.IBSCBSTot.gIBS_tot.gIBSUF_tot.vDevTrib
ld_vl_total_ibs_uf				= a_infnfe.total.IBSCBSTot.gIBS_tot.gIBSUF_tot.vIBSUF
ld_vl_total_dif_ibs_mun			= a_infnfe.total.IBSCBSTot.gIBS_tot.gIBSMun_tot.vDif
ld_vl_total_dev_ibs_mun			= a_infnfe.total.IBSCBSTot.gIBS_tot.gIBSMun_tot.vDevTrib
ld_vl_total_ibs_mun				= a_infnfe.total.IBSCBSTot.gIBS_tot.gIBSMun_tot.vIBSMun
ld_vl_total_ibs					= a_infnfe.total.IBSCBSTot.gIBS_tot.vIBS
ld_vl_total_dif_cbs				= a_infnfe.total.IBSCBSTot.gCBS_tot.vDif
ld_vl_total_dev_cbs				= a_infnfe.total.IBSCBSTot.gCBS_tot.vDevTrib
ld_vl_total_cbs					= a_infnfe.total.IBSCBSTot.gCBS_tot.vCBS

If a_infnfe.det[1].prod.CFOP 	= "5910" Then ls_Id_Bonificacao = "C" Else ls_Id_Bonificacao = "N"

ll_Nr_Pedido 						= al_Pedido
ldh_Registro 						= gf_GetServerDate()
ls_Nr_MAtricula_Registro 		= "14330" //Usu$$HEX1$$e100$$ENDHEX$$rio inform$$HEX1$$e100$$ENDHEX$$tica
ls_De_Chave_Acesso 				= as_Chave_Nota
ldt_Dt_Movimentacao_Caixa 		= Date(gf_GetServerDate())

//Verifica o tamanho do numero da NF
If il_Nf > 2147483647 Then
	ls_Mensagem_Log = "N$$HEX1$$fa00$$ENDHEX$$mero da Nota Fiscal Deve ser at$$HEX1$$e900$$ENDHEX$$ 2147483647"
	Return False
End If

//Verifica se a nota ja foi importada anteriormente
If not of_Nota_Importada_Anteriormente(il_Nf, is_Especie, is_Serie, is_Fornecedor, il_Filial, Ref ls_Mensagem_Log) Then
	If ls_Mensagem_Log = "" Then
		as_Mensagem_Log = "A nota ja foi importada anteriormente"
	Else
		as_Mensagem_Log = "Erro ao verificar se anota ja havia sido importada: "+ls_Mensagem_Log
	End If
	Return False
End If

if not IsNull(is_recebimento_sap) and trim(is_recebimento_sap) <> '' then
	ld_dh_recebimento_sap	= Date(gf_getserverdate())
Else
	SetNull(ld_dh_recebimento_sap)
end if

ll_Itens = UpperBound(a_infnfe.det[])

Insert into nf_compra_pendente(
	cd_filial,	
	cd_fornecedor,
	nr_nf,
	de_especie,
	de_serie,
	dh_emissao,
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
	id_bonificacao,
	nr_pedido,
	nr_pedido_central,
	dh_registro,
	nr_matricula_registro,
	de_chave_acesso,
	dh_movimentacao_caixa,
	id_estoque_automatico,
	nr_itens,
	dh_recebido_sap,
	vl_total_bc_cbs_ibs,
	vl_total_dif_ibs_uf,
	vl_total_dev_ibs_uf,
	vl_total_ibs_uf,
	vl_total_dif_ibs_mun,
	vl_total_dev_ibs_mun,
	vl_total_ibs_mun,
	vl_total_ibs,
	vl_total_dif_cbs,
	vl_total_dev_cbs,
	vl_total_cbs)
Values(
	:il_Filial,
	:is_Fornecedor,
	:il_Nf,
	:is_Especie,
	:is_Serie,
	:ldh_Emissao,
	:ld_Vl_Bc_Icms,
	:ld_Vl_ICMS,
	:ld_Vl_Bc_Icms_St,
	:ld_Vl_Icms_St,
	:ld_Vl_Icms_Repassado,
	:ld_Vl_Total_Produtos,
	:ld_Vl_Ipi,
	:ld_Vl_Frete,
	:ld_Vl_Seguro,
	:ld_Vl_Outras_Despesas,
	:ld_Vl_Desconto,
	:ld_Vl_Indenizacao,
	:ld_Vl_Total_Nf,
	:ls_Id_Bonificacao,
	:ll_Nr_Pedido,
	:ll_Nr_Pedido_Central,
	:ldh_Registro,
	:ls_Nr_MAtricula_Registro,
	:ls_De_Chave_Acesso,
	:ldt_Dt_Movimentacao_Caixa,
	'N',
	:ll_Itens,
	:ld_dh_recebimento_sap,
	:ld_vl_total_bc_cbs_ibs,
	:ld_vl_total_dif_ibs_uf,
	:ld_vl_total_dev_ibs_uf,
	:ld_vl_total_ibs_uf,
	:ld_vl_total_dif_ibs_mun,
	:ld_vl_total_dev_ibs_mun,
	:ld_vl_total_ibs_mun,
	:ld_vl_total_ibs,
	:ld_vl_total_dif_cbs,
	:ld_vl_total_dev_cbs,
	:ld_vl_total_cbs)
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case -1		
		as_Mensagem_Log = "Erro ao inserir o cabe$$HEX1$$e700$$ENDHEX$$alho da nota: "+ SqlCa.sqlerrtext
		Return False
	Case 0		
		Return True
End Choose

as_Mensagem_Log = "Erro desconhecido ao inserir o cabe$$HEX1$$e700$$ENDHEX$$alho da nota"
Return False



  


end function

public function boolean of_verifica_produto_hardcode (string as_cd_produto_xml, ref string as_ean, ref string as_ean_trib);Choose Case as_cd_produto_xml
	Case '34085'
		as_ean	= '7896894900013'
		as_ean_trib = '7896894900013'		
	
	Case '45260'
		as_ean	= '7896045102440'
		as_ean_trib = '7896045102440'
	
	Case '31039'
		as_ean	= '7891040003877'
		as_ean_trib = '7891040003877'	
	
	Case '74100'
		as_ean	= '3000000011218'
		as_ean_trib = '3000000011218'		
	
	Case '103190'
		as_ean	= '3000000011188'
		as_ean_trib = '3000000011188'				
	
	Case '36467'
		as_ean	= '78930469'
		as_ean_trib = '78930469'		
	
	Case '70249'
		as_ean	= '00702492'
		as_ean_trib = '00702492'
	
	Case '70295'
		as_ean	= '00702959'
		as_ean_trib = '00702959'
	
	Case '70304'
		as_ean	= '00703048'
		as_ean_trib = '00703048'
	
	Case '70250'
		as_ean	= '00702508'
		as_ean_trib = '00702508'
	
	Case '70296'
		as_ean	= '00702966'
		as_ean_trib = '00702966'
	
	Case '70305'
		as_ean	= '00703055'
		as_ean_trib = '00703055'
	
	Case '70255'
		as_ean	= '00702553'
		as_ean_trib = '00702553'
	
	Case '70537'
		as_ean	= '00705370'
		as_ean_trib = '00705370'
	
	Case '70537'
		as_ean	= '00705370'
		as_ean_trib = '00705370'
	
	Case '70288'
		as_ean	= '00702881'
		as_ean_trib = '00702881'
	
	Case '70299'
		as_ean	= '00702997'
		as_ean_trib = '00702997'
	
	Case '70309'
		as_ean	= '00703093'
		as_ean_trib = '00703093'
	
	Case '70258'
		as_ean	= '00702584'
		as_ean_trib = '00702584'
	
	Case '70291'
		as_ean	= '00702911'
		as_ean_trib = '00702911'
	
	Case '70302'
		as_ean	= '00703024'
		as_ean_trib = '00703024'
	
	Case '70312'
		as_ean	= '00703123'
		as_ean_trib = '00703123'
	
End Choose	

Return True
end function

public function boolean of_nosso_codigo_produto (string as_xprod, string as_ean, string as_eantrib, string as_distribuidora, ref long al_produto, ref string as_mensagem_log, ref boolean ab_erro);String ls_Ean
Long ll_Produto
		
SetNull(ll_Produto)

ab_erro = False
	
If ( as_EAN = "" ) And ( as_Eantrib = "" ) Then
	as_mensagem_log = "O produto '"+as_xprod+"' est$$HEX1$$e100$$ENDHEX$$ sem o c$$HEX1$$f300$$ENDHEX$$digo de barras no arquivo XML."
	Return False  
Else
	If Trim(as_EANTrib) <> "" Then
		ls_Ean = "%"+gf_Tira_Zero_Esquerda( as_EANTrib )
	Else
		ls_Ean = "%"+gf_Tira_Zero_Esquerda( as_EAN )
	End If
	
	select top 1 cd_produto 
	Into :ll_Produto
		from codigo_barras_produto 
		where de_codigo_barras like :ls_Ean
	Using SqlCa;
	
	Choose Case SqlCa.Sqlcode
		Case 100
			ls_Ean = "%"+gf_Tira_Zero_Esquerda( as_EAN )
	
			select top 1 cd_produto 
			Into :ll_Produto
				from codigo_barras_produto 
				where de_codigo_barras like :ls_Ean
			Using SqlCa;
			
			Choose Case SqlCa.Sqlcode
				Case 100

					If not of_verifica_produto_cod_distribuidora(as_xprod,as_distribuidora,REF as_ean, REF as_eantrib,REF ll_Produto,REF as_mensagem_log) Then
						Return False
					End if
					
					If isnull(ll_Produto) Then
						as_mensagem_log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nosso c$$HEX1$$f300$$ENDHEX$$digo de produto com EAN  ("+as_ean+"), produto na distribuidora ("+as_xprod+"), do arquivo XML."
						Return False
					End if
					
				Case -1
					ab_erro  = True
					as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto atrav$$HEX1$$e900$$ENDHEX$$s do EAN '" + ls_EAN + "'." + SqlCa.SqlErrText
					Return False
			End Choose
	
		Case -1
			ab_erro  = True
			as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto atrav$$HEX1$$e900$$ENDHEX$$s do EAN '" + as_EANTrib + "'." + SqlCa.SqlErrText
			Return False
	End Choose
	
End If

al_produto = ll_Produto

Return True

end function

public function boolean of_verifica_produto_cod_distribuidora (string as_cd_produto_xml, string as_distribuidora, ref string as_ean, ref string as_ean_trib, ref long as_cd_produto, ref string as_mensagem_log);Select cd_produto
	Into :as_cd_produto
From distribuidora_produto_sem_ean
	Where cd_distribuidora = :as_distribuidora
	And cd_produto_distribuidora = :as_cd_produto_xml
Using SqlCa;
		
If	SqlCa.SqlCode =  -1 Then
	as_Mensagem_Log = "Erro ao localizar o produto na tabela distribuidora_produto_sem_ean: " + SqlCa.SQLErrText
	Return False
End if



  


end function

on dc_uo_importa_nf_pedido_eletronico.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_importa_nf_pedido_eletronico.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivb_Inclui_Pedido_Projeto_Conexao = False
end event

event destructor;If IsValid(ivo_Fiscal) Then Destroy(ivo_Fiscal)
end event

