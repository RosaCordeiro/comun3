HA$PBExportHeader$uo_ge577_relatorio_f5.sru
forward
global type uo_ge577_relatorio_f5 from nonvisualobject
end type
end forward

global type uo_ge577_relatorio_f5 from nonvisualobject
end type
global uo_ge577_relatorio_f5 uo_ge577_relatorio_f5

forward prototypes
public function boolean of_controla_ds (ref dc_uo_ds_base ads, ref dc_uo_ds_base ads_aux, ref dc_uo_ds_base ads_aux_uf)
public function boolean of_busca_dados_view (long al_cd_produto, string as_cd_uf, string as_cd_distribuidora, ref decimal adc_vl_repasse, ref decimal adc_vl_compra, ref decimal adc_pc_desconto_financeiro, ref decimal adc_vl_melhor_compra, ref decimal adc_vl_juros_decrescimo_dist, ref decimal adc_vl_preco_atual, ref decimal adc_vl_icms_st, ref decimal adc_vl_base_icms, ref decimal adc_vl_icms, ref string as_log)
public function boolean of_escrever_arquivo (ref integer ai_arquivo, string as_cd_fornecedor_sap, string as_cd_uf, string as_cd_produto_sap, string as_cd_produto_distrib, decimal adc_vl_repasse_icms, decimal adc_vl_preco_ordem, decimal adc_pc_desconto_financeiro, decimal adc_vl_juros, decimal adc_vl_preco_venda, decimal adc_vl_icms_st, decimal adc_vl_base_icms, decimal adc_vl_icms, decimal adc_vl_preco, decimal adc_pc_desconto, decimal adc_vl_compra, decimal adc_pc_icms, decimal adc_pc_reducao_base_icms, decimal adc_pc_comissao_midia, long al_qt_est_disponivel, long al_qt_emb_pdr_distrib, datetime adt_dt_atualiz_distrib, long al_nr_dias_pagamento, datetime adt_dh_atualiz_estoque, string as_id_situacao, string as_id_situacao_anterior)
public function boolean of_busca_dados (long al_for, ref dc_uo_ds_base ads, ref string as_cd_uf, ref string as_cd_fornecedor_sap, ref string as_cd_produto_sap, ref decimal adc_vl_repasse_icms, ref decimal adc_vl_preco_ordem, ref decimal adc_pc_desconto_financeiro, ref decimal adc_vl_preco_ordem_melhor_compra, ref decimal adc_vl_juros, ref decimal adc_vl_preco_venda, ref decimal adc_vl_icms_st, ref decimal adc_vl_base_icms, ref decimal adc_vl_icms, ref string as_cd_produto_distribuidora, ref long al_qt_est_disponivel, ref long al_qt_emb_pdr_distrib, ref datetime adt_dt_atualiz_distrib, ref long al_nr_dias_pagamento, ref decimal adc_vl_preco, ref decimal adc_pc_desconto, ref decimal adc_vl_compra, ref string as_id_situacao, ref string as_id_situacao_anterior, ref decimal adc_pc_icms, ref decimal adc_pc_reducao_base_icms, ref decimal adc_pc_comissao_midia, ref datetime adt_dh_atualiz_estoque)
public function boolean of_cria_arquivo (string as_nome_arquivo, ref integer ai_arquivo, ref string as_arquivo)
end prototypes

public function boolean of_controla_ds (ref dc_uo_ds_base ads, ref dc_uo_ds_base ads_aux, ref dc_uo_ds_base ads_aux_uf);ads 			= Create dc_uo_ds_base
ads_aux 		= Create dc_uo_ds_base
ads_aux_uf 	= Create dc_uo_ds_base

If Not ads.of_ChangeDataObject('ds_ge481_envio_distribuidora_produto', False) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao alterar a DW '" + 'ds_ge481_envio_distribuidora_produto' + "' - " + 'uo_ge481_distribuidora_produto', StopSign!)
	Return False
End If

If Not ads_aux.of_ChangeDataObject('ds_ge481_envio_distribuidora_produto', False) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao alterar a DW '" + 'ds_ge481_envio_distribuidora_produto' + "' - " + 'uo_ge481_distribuidora_produto', StopSign!)
	Return False
End If

If Not ads_aux_uf.of_ChangeDataObject('ds_ge481_envio_distribuidora_produto_uf', False) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao alterar a DW '" + 'ds_ge481_envio_distribuidora_produto_uf' + "' - " + 'uo_ge481_distribuidora_produto', StopSign!)
	Return False
End If

ads_aux_uf.Retrieve()

Return True
end function

public function boolean of_busca_dados_view (long al_cd_produto, string as_cd_uf, string as_cd_distribuidora, ref decimal adc_vl_repasse, ref decimal adc_vl_compra, ref decimal adc_pc_desconto_financeiro, ref decimal adc_vl_melhor_compra, ref decimal adc_vl_juros_decrescimo_dist, ref decimal adc_vl_preco_atual, ref decimal adc_vl_icms_st, ref decimal adc_vl_base_icms, ref decimal adc_vl_icms, ref string as_log);Long  ll_cd_filial


select min(f.cd_filial)
  into :ll_cd_filial 
  from filial f 
  inner join cidade c  
  			 on c.cd_cidade		= f.cd_cidade 
 where f.id_situacao				= 'A'
	and f.cd_filial 				not in (1, 2, 534)  
   and c.cd_unidade_federacao	= :as_cd_uf
 Using SQLCA;

If SQLCA.SQLCode = -1 Then 
	as_log = 'Problemas ao consultar a tabela "filial de referencia": ' + SQLCA.SQLErrText
	Return False
End If

select coalesce(vl_repasse, 0),
       coalesce(vl_compra, 0),
       coalesce(pc_desconto_financeiro, 0),
       coalesce(vl_melhor_compra, 0),
       coalesce(vl_juros_decrescimo_dist, 0),
       coalesce(vl_preco_atual, 0),
       coalesce(vl_icms_st, 0),
		 round(( cast(coalesce(vl_compra, 0) as decimal(9,2)) -   cast(coalesce(vl_repasse, 0) as decimal(9,2) ) ) * (( 100 -  coalesce(pc_repasse_icms, 0) ) / 100 ), 2),
		 coalesce(vl_icms, 0)
  into :adc_vl_repasse,
		 :adc_vl_compra,
		 :adc_pc_desconto_financeiro,
		 :adc_vl_melhor_compra,
		 :adc_vl_juros_decrescimo_dist,
		 :adc_vl_preco_atual,
		 :adc_vl_icms_st,
		 :adc_vl_base_icms,
		 :adc_vl_icms
  from vw_preco_distribuidora
 where cd_produto             = :al_cd_produto 
   and cd_unidade_federacao   = :as_cd_uf
   and cd_distribuidora   		= :as_cd_distribuidora
   and cd_filial           	= :ll_cd_filial
 using SQLCA;

If SQLCA.SQLCode = -1 then 
	as_log = 'Problemas ao consultar a tabela "vw_preco_distribuidora": ' + SQLCA.SQLErrText
	Return False
End If

Return True 
end function

public function boolean of_escrever_arquivo (ref integer ai_arquivo, string as_cd_fornecedor_sap, string as_cd_uf, string as_cd_produto_sap, string as_cd_produto_distrib, decimal adc_vl_repasse_icms, decimal adc_vl_preco_ordem, decimal adc_pc_desconto_financeiro, decimal adc_vl_juros, decimal adc_vl_preco_venda, decimal adc_vl_icms_st, decimal adc_vl_base_icms, decimal adc_vl_icms, decimal adc_vl_preco, decimal adc_pc_desconto, decimal adc_vl_compra, decimal adc_pc_icms, decimal adc_pc_reducao_base_icms, decimal adc_pc_comissao_midia, long al_qt_est_disponivel, long al_qt_emb_pdr_distrib, datetime adt_dt_atualiz_distrib, long al_nr_dias_pagamento, datetime adt_dh_atualiz_estoque, string as_id_situacao, string as_id_situacao_anterior);String	ls_texto, ls_vl_repasse_icms, ls_vl_preco_ordem, ls_pc_desconto_financeiro, ls_vl_juros, ls_vl_preco_venda, &
			ls_vl_icms_st, ls_vl_base_icms, ls_vl_icms, ls_vl_preco, ls_pc_desconto, ls_vl_compra, ls_pc_icms, &
			ls_pc_reducao_base_icms, ls_pc_comissao_midia, ls_qt_est_disponivel, ls_qt_emb_pdr_distrib, &
			ls_dt_atualiz_distrib, ls_nr_dias_pagamento, ls_dh_atualiz_estoque


//Tratar Campos
ls_vl_repasse_icms			= gf_valor_com_ponto(adc_vl_repasse_icms) 
ls_vl_preco_ordem				= gf_valor_com_ponto(adc_vl_preco_ordem) 
ls_pc_desconto_financeiro	= gf_valor_com_ponto(adc_pc_desconto_financeiro) 
ls_vl_juros						= gf_valor_com_ponto(adc_vl_juros) 
ls_vl_preco_venda				= gf_valor_com_ponto(adc_vl_preco_venda) 
ls_vl_icms_st					= gf_valor_com_ponto(adc_vl_icms_st) 
ls_vl_base_icms				= gf_valor_com_ponto(adc_vl_base_icms) 
ls_vl_icms						= gf_valor_com_ponto(adc_vl_icms) 
ls_vl_preco 					= gf_valor_com_ponto(adc_vl_preco) 
ls_pc_desconto 				= gf_valor_com_ponto(adc_pc_desconto) 
ls_vl_compra					= gf_valor_com_ponto(adc_vl_compra) 
ls_pc_icms						= gf_valor_com_ponto(adc_pc_icms) 
ls_pc_reducao_base_icms		= gf_valor_com_ponto(adc_pc_reducao_base_icms) 
ls_pc_comissao_midia			= gf_valor_com_ponto(adc_pc_comissao_midia) 	
ls_qt_est_disponivel			= String(al_qt_est_disponivel)
ls_qt_emb_pdr_distrib		= String(al_qt_emb_pdr_distrib)
ls_dt_atualiz_distrib 		= String(adt_dt_atualiz_distrib)
ls_nr_dias_pagamento 		= String(al_nr_dias_pagamento)
ls_dh_atualiz_estoque 		= String(adt_dh_atualiz_estoque)

//Validar campos nulos
If IsNull(ls_dh_atualiz_estoque) or ls_dh_atualiz_estoque = '' Then ls_dh_atualiz_estoque = "01/01/1900 00:00:00" 
If IsNull(ls_dt_atualiz_distrib) or ls_dt_atualiz_distrib = '' Then ls_dt_atualiz_distrib = "01/01/1900 00:00:00" 
If IsNull(ls_qt_est_disponivel) or ls_qt_est_disponivel = '' Then ls_qt_est_disponivel = '0' 
If IsNull(ls_nr_dias_pagamento) or ls_nr_dias_pagamento = '' Then ls_nr_dias_pagamento = '0' 
If IsNull(ls_vl_preco) or ls_vl_preco = '' Then ls_vl_preco = '0.00' 
If IsNull(ls_vl_compra) or ls_vl_compra = '' Then ls_vl_compra ='0.00' 
If IsNull(ls_pc_comissao_midia) or ls_pc_comissao_midia = "" or len(ls_pc_comissao_midia) <= 1 Then ls_pc_comissao_midia = '0.00' 
If IsNull(ls_pc_icms) or ls_pc_icms = '' Then ls_pc_icms = '0.00' 
If IsNull(ls_vl_icms) or ls_vl_icms = '' Then ls_vl_icms = '0.00' 
If IsNull(ls_vl_preco_ordem) or ls_vl_preco_ordem = '' Then ls_vl_preco_ordem = '0.00' 
If IsNull(ls_vl_juros) or ls_vl_juros = '' Then ls_vl_juros = '0.00'
If IsNull(ls_pc_reducao_base_icms) or ls_pc_reducao_base_icms = '' Then ls_pc_reducao_base_icms = '0.00'
If IsNull(ls_vl_base_icms) or ls_vl_base_icms = '' Then ls_vl_base_icms = '0.00'
	
ls_texto =		as_cd_fornecedor_sap + ',' +&
					as_cd_uf + ',' +&
					as_cd_produto_sap + ','+&
					as_cd_produto_distrib + ','+&
					ls_qt_emb_pdr_distrib+','+&
					ls_qt_est_disponivel+','+&
					ls_dt_atualiz_distrib +','+&
					ls_vl_preco +','+&
					ls_pc_desconto +','+&
					ls_vl_repasse_icms + ','+&
					ls_vl_icms_st + ','+&						
					ls_vl_compra + ','+&
					ls_nr_dias_pagamento + ','+&
					as_id_situacao + ','+&
					as_id_situacao_anterior +','+&
					ls_pc_icms+','+&
					ls_pc_reducao_base_icms + ','+&
					ls_vl_base_icms + ','+&					
					ls_vl_icms + ','+&			
					ls_pc_desconto_financeiro + ','+&
					ls_pc_comissao_midia + ','+&
					ls_vl_juros + ','+&
					ls_vl_preco_ordem + ','+&
					ls_vl_preco_venda + ','+&
					ls_dh_atualiz_estoque
					
if IsNull(ls_texto) then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Texto com linha em branco.", StopSign!)
	Return False
end if

If FileWriteEx(ai_arquivo, ls_texto) < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao escrever arquivo.", StopSign!)
	Return False
End If

Return True
end function

public function boolean of_busca_dados (long al_for, ref dc_uo_ds_base ads, ref string as_cd_uf, ref string as_cd_fornecedor_sap, ref string as_cd_produto_sap, ref decimal adc_vl_repasse_icms, ref decimal adc_vl_preco_ordem, ref decimal adc_pc_desconto_financeiro, ref decimal adc_vl_preco_ordem_melhor_compra, ref decimal adc_vl_juros, ref decimal adc_vl_preco_venda, ref decimal adc_vl_icms_st, ref decimal adc_vl_base_icms, ref decimal adc_vl_icms, ref string as_cd_produto_distribuidora, ref long al_qt_est_disponivel, ref long al_qt_emb_pdr_distrib, ref datetime adt_dt_atualiz_distrib, ref long al_nr_dias_pagamento, ref decimal adc_vl_preco, ref decimal adc_pc_desconto, ref decimal adc_vl_compra, ref string as_id_situacao, ref string as_id_situacao_anterior, ref decimal adc_pc_icms, ref decimal adc_pc_reducao_base_icms, ref decimal adc_pc_comissao_midia, ref datetime adt_dh_atualiz_estoque);Long		ll_cd_produto
String	ls_log, ls_cd_distribuidora


as_cd_uf	= ads.Object.cd_uf[al_for]
If IsNull(as_cd_uf) Then Return False

as_cd_fornecedor_sap	= String(ads.Object.cd_fornecedor_sap [al_for])
If IsNull(as_cd_fornecedor_sap) Then Return False

as_cd_produto_sap	= ads.Object.cd_produto_sap [al_for]
If IsNull(as_cd_produto_sap) Then Return False
		
ll_cd_produto			= ads.Object.cd_produto[al_for]
ls_cd_distribuidora	= ads.Object.cd_distribuidora [al_for]
	
If Not of_busca_dados_view(ll_cd_produto,&
									as_cd_uf,&
									ls_cd_distribuidora,& 
									Ref adc_vl_repasse_icms,&
									Ref adc_vl_preco_ordem,&
									Ref adc_pc_desconto_financeiro,&
									Ref adc_vl_preco_ordem_melhor_compra,&
									Ref adc_vl_juros,&
									Ref adc_vl_preco_venda,&
									Ref adc_vl_icms_st,&
									Ref adc_vl_base_icms,&
									Ref adc_vl_icms,&
									Ref ls_log) Then 																											

	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_log, StopSign!)
	Return False
End If 

as_cd_produto_distribuidora	= ads.Object.cd_produto_distribuidora[al_for]
al_qt_est_disponivel				= ads.Object.qt_est_disponivel[al_for]
al_qt_emb_pdr_distrib			= ads.Object.qt_emb_pdr_distrib[al_for]
adt_dt_atualiz_distrib			= ads.Object.dt_atualiz_distrib[al_for]
al_nr_dias_pagamento				= ads.Object.nr_dias_pagamento[al_for]
adc_vl_preco						= ads.Object.vl_preco[al_for]
adc_pc_desconto					= ads.Object.pc_desconto[al_for]
adc_vl_compra						= ads.Object.vl_compra[al_for]
as_id_situacao						= ads.Object.id_situacao[al_for]
as_id_situacao_anterior			= ads.Object.id_situacao_anterior[al_for]
adc_pc_icms							= ads.Object.pc_icms[al_for]
adc_pc_reducao_base_icms		= ads.Object.pc_reducao_base_icms[al_for]
adc_pc_comissao_midia			= ads.Object.pc_comissao_midia[al_for]
adt_dh_atualiz_estoque			= ads.Object.dh_atualiz_estoque[al_for]

Return True
end function

public function boolean of_cria_arquivo (string as_nome_arquivo, ref integer ai_arquivo, ref string as_arquivo);String	ls_caminho_pasta


ls_caminho_pasta = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "")

as_arquivo = ls_caminho_pasta + as_nome_arquivo + '.txt'

if FileExists(as_arquivo) then
	FileDelete(as_arquivo)
end if

ai_arquivo = FileOpen(as_arquivo, LineMode!, Write!)
	
If ai_arquivo = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao abrir o arquivo para inser$$HEX2$$e700e300$$ENDHEX$$o de dados '" + as_arquivo + "'.", StopSign!)
	Return False
End If

Return true
end function

on uo_ge577_relatorio_f5.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge577_relatorio_f5.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

