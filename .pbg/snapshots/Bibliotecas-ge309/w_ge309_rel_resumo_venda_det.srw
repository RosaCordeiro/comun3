HA$PBExportHeader$w_ge309_rel_resumo_venda_det.srw
forward
global type w_ge309_rel_resumo_venda_det from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge309_rel_resumo_venda_det from dc_w_selecao_lista_relatorio
string tag = "w_ge309_rel_resumo_venda_det"
integer width = 3643
integer height = 1908
string title = "GE309 - Relat$$HEX1$$f300$$ENDHEX$$rio de Resumo Detalhado de Vendas"
end type
global w_ge309_rel_resumo_venda_det w_ge309_rel_resumo_venda_det

type variables
uo_filial ivo_filial
end variables

forward prototypes
public subroutine wf_insere_regiao_default ()
public subroutine wf_atualiza_vendas_cartao (string ps_operacao)
public subroutine wf_atualiza_operacoes_debito ()
public subroutine wf_atualiza_pagamento_avista ()
end prototypes

public subroutine wf_insere_regiao_default ();Integer 	lvi_Retorno, &
        		lvi_Linha

DataWindowChild lvdwc

Long lvl_Regiao

lvi_Retorno = dw_1.GetChild("cd_regiao", lvdwc)

If lvi_Retorno = 1 Then
	lvi_Linha = lvdwc.InsertRow(1)
	
	If lvi_Linha > 0 Then
		lvdwc.SetItem(lvi_Linha, "cd_regiao", 0)
		lvdwc.SetItem(lvi_Linha, "de_regiao", "TODAS")
		
		dw_1.Object.Cd_Regiao[1] = 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o da regi$$HEX1$$e300$$ENDHEX$$o default.", StopSign!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da regi$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
End If

select cd_regiao
Into :lvl_Regiao
From regiao
Where nr_matricula_regional = :gvo_aplicacao.ivo_seguranca.nr_matricula
Using SQLCa;

If SQLCa.SQLCode = 0 Then
	dw_1.Object.cd_regiao[1] = lvl_Regiao
Else
	dw_1.Object.cd_regiao[1] = 0	
End If
end subroutine

public subroutine wf_atualiza_vendas_cartao (string ps_operacao);Long 	lvl_Linha, &
 		lvl_Filial
		 
Decimal 	lvdc_Vl_Venda, &
			lvdc_Vl_Convenio, &
			lvdc_Vl_Crediario, &
			lvdc_Vl_Conta_Corrente
			
Date 	lvdt_Inicio, &
		lvdt_Termino
		
String lvs_Forma_Pagto

lvs_Forma_Pagto = IIF(ps_operacao = 'C', 'CP', 'CA')
		 
dw_1.AcceptText()

lvdt_Inicio 		= dw_1.Object.Dt_Inicio		[1]
lvdt_Termino 	= dw_1.Object.Dt_Termino	[1]

dw_2.AcceptText()

For lvl_Linha = 1 To dw_2.RowCount()
	
	lvl_Filial = dw_2.Object.Cd_Filial[lvl_Linha]
	
	Select sum(case when n.id_tipo_venda = 'CV' then vl_pago_avista else 0.00 end) as vl_convenio,
			 sum(case when n.id_tipo_venda = 'CC' then vl_pago_avista else 0.00 end) as vl_conta_corrente,	
			 sum(case when n.id_tipo_venda = 'CR' then vl_pago_avista else 0.00 end) as vl_crediario				
	  Into :lvdc_Vl_Convenio, :lvdc_Vl_Conta_Corrente, :lvdc_Vl_Crediario
	From nf_venda n
	Where n.cd_filial = :lvl_Filial
	    and n.dh_movimentacao_caixa between :lvdt_Inicio and :lvdt_Termino
	    and n.id_tipo_venda <> 'AV'
	    and n.cd_forma_pagamento = :lvs_Forma_Pagto
	    and n.dh_cancelamento is null
	    and n.nr_nf_anexa is null
	    and exists (Select 1 
					 From cartao_comprovante_operacao co
					Where co.cd_filial 			= n.cd_filial
						and co.nr_nf 			= n.nr_nf
						and co.de_especie 	= n.de_especie
						and co.de_serie 		= n.de_serie)
	Using SqlCa;					
	
	If SqlCa.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos valores de vendas de cart$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e000$$ENDHEX$$ cr$$HEX1$$e900$$ENDHEX$$dito - outros tipo de vendas. - " + SqlCa.SqlErrText)
	End If

	If IsNull(lvdc_Vl_Convenio) Then lvdc_Vl_Convenio = 0.00
	If IsNull(lvdc_Vl_Conta_Corrente) Then lvdc_Vl_Conta_Corrente = 0.00
	If IsNull(lvdc_Vl_Crediario) Then lvdc_Vl_Crediario = 0.00
	
	If ps_operacao = 'C' Then
		//Aumenta o valor pago em cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito
		lvdc_Vl_Venda = dw_2.Object.Vl_Venda_Cartao_Credito[lvl_Linha]
		If IsNull(lvdc_Vl_Venda) Then lvdc_Vl_Venda = 0.00
		dw_2.Object.Vl_Venda_Cartao_Credito[lvl_Linha] = lvdc_Vl_Venda + lvdc_Vl_Convenio + lvdc_Vl_Conta_Corrente + lvdc_Vl_Crediario
	Else
		//Aumenta o valor pago em cart$$HEX1$$e300$$ENDHEX$$o de d$$HEX1$$e900$$ENDHEX$$bito
		lvdc_Vl_Venda = dw_2.Object.vl_venda_cartao_debito[lvl_Linha]
		If IsNull(lvdc_Vl_Venda) Then lvdc_Vl_Venda = 0.00
		dw_2.Object.vl_venda_cartao_debito[lvl_Linha] = lvdc_Vl_Venda + lvdc_Vl_Convenio + lvdc_Vl_Conta_Corrente + lvdc_Vl_Crediario
	End If

	//Reduz o valor pago em cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito das vendas do tipo credi$$HEX1$$e100$$ENDHEX$$rio
	lvdc_Vl_Venda = dw_2.Object.vl_venda_crediario[lvl_Linha]
	If IsNull(lvdc_Vl_Venda) Then lvdc_Vl_Venda = 0.00
	dw_2.Object.vl_venda_crediario[lvl_Linha] = lvdc_Vl_Venda - lvdc_Vl_Crediario
	
	//Reduz o valor pago em cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito das vendas do tipo conv$$HEX1$$ea00$$ENDHEX$$nio
	lvdc_Vl_Venda = dw_2.Object.vl_venda_convenio[lvl_Linha]
	If IsNull(lvdc_Vl_Venda) Then lvdc_Vl_Venda = 0.00
	dw_2.Object.vl_venda_convenio[lvl_Linha] = lvdc_Vl_Venda - lvdc_Vl_Convenio

	//Reduz o valor pago em cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito das vendas do tipo conta corrente
	lvdc_Vl_Venda = dw_2.Object.vl_venda_conta_corrente[lvl_Linha]
	If IsNull(lvdc_Vl_Venda) Then lvdc_Vl_Venda = 0.00
	dw_2.Object.vl_venda_conta_corrente[lvl_Linha] = lvdc_Vl_Venda - lvdc_Vl_Conta_Corrente
Next
end subroutine

public subroutine wf_atualiza_operacoes_debito ();Long 	lvl_Linha, &
 		lvl_Filial
		 
Decimal 	lvdc_Vl_Venda_Recarga, &
			lvdc_Vl_Venda_Titulo
			
Date 	lvdt_Inicio, &
		lvdt_Termino
		 
dw_1.AcceptText()

lvdt_Inicio 		= dw_1.Object.Dt_Inicio		[1]
lvdt_Termino 	= dw_1.Object.Dt_Termino	[1]

dw_2.AcceptText()

For lvl_Linha = 1 To dw_2.RowCount()
	
	lvl_Filial = dw_2.Object.Cd_Filial[lvl_Linha]
	
	select sum(lc.vl_lancamento)
	 into :lvdc_Vl_Venda_Recarga
	from caixa cx,
		  filial f,
		  controle_caixa cc,
		  lancamento_caixa lc,
		  conta_fluxo_caixa cfc
	where cx.cd_filial 					= f.cd_filial
	  and cx.id_caixa_geral 			= 'N'
	  and f.cd_filial not in (1,534)
	  and cc.cd_caixa 					= cx.cd_caixa
	  and lc.cd_caixa 					= cc.cd_caixa
	  and lc.nr_controle_caixa 		= cc.nr_controle_caixa
	  and f.cd_filial 						= :lvl_Filial
	  and cc.dh_movimentacao_caixa between :lvdt_Inicio and  :lvdt_Termino
	  and lc.de_historico like '%CEL%DEB%'	
	  and lc.id_estorno 				= 'N'
	  and cfc.cd_conta_fluxo_caixa 	= lc.cd_conta_fluxo_caixa
	  and cfc.id_tipo_conta 			= 'R'
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos valores de vendas de cart$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e000$$ENDHEX$$ d$$HEX1$$e900$$ENDHEX$$bito de recargas. - " + SqlCa.SqlErrText)
	End If
	
	If IsNull(lvdc_Vl_Venda_Recarga) Then lvdc_Vl_Venda_Recarga = 0.00
	
	dw_2.Object.Vl_Venda_Cartao_Debito_Recarga[lvl_Linha] = lvdc_Vl_Venda_Recarga
	
	select sum(lc.vl_lancamento)
	 into :lvdc_Vl_Venda_Titulo
	from caixa cx,
		  filial f,
		  controle_caixa cc,
		  lancamento_caixa lc
	where cx.cd_filial 					= f.cd_filial
	  and cx.id_caixa_geral 			= 'N'
	  and f.cd_filial not in (1,534)
	  and cc.cd_caixa 					= cx.cd_caixa
	  and lc.cd_caixa 					= cc.cd_caixa
	  and lc.nr_controle_caixa 		= cc.nr_controle_caixa
	  and f.cd_filial 						= :lvl_Filial
	  and cc.dh_movimentacao_caixa between :lvdt_Inicio and  :lvdt_Termino
	  and lc.de_historico like '%T$$HEX1$$cd00$$ENDHEX$$TULO%DEB%'	
	  and lc.id_estorno 				= 'N'
	using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos valores de vendas de cart$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e000$$ENDHEX$$ d$$HEX1$$e900$$ENDHEX$$bito de pagto de t$$HEX1$$ed00$$ENDHEX$$tulos. - " + SqlCa.SqlErrText)
	End If
	
	If IsNull(lvdc_Vl_Venda_Titulo) Then lvdc_Vl_Venda_Titulo = 0.00
	
	dw_2.Object.Vl_Venda_Cartao_Deb_Pagto_Tit[lvl_Linha] = lvdc_Vl_Venda_Titulo		
Next
end subroutine

public subroutine wf_atualiza_pagamento_avista ();Decimal{2} lvdc_CC_Dinheiro
Decimal{2} lvdc_CC_Cheque_AV
Decimal{2} lvdc_CC_Cheque_AP
Decimal{2} lvdc_CC_Cartao_Debito
Decimal{2} lvdc_CC_Cartao_Credito

Decimal{2} lvdc_CR_Dinheiro
Decimal{2} lvdc_CR_Cheque_AV
Decimal{2} lvdc_CR_Cheque_AP
Decimal{2} lvdc_CR_Cartao_Debito
Decimal{2} lvdc_CR_Cartao_Credito

Decimal{2} lvdc_CV_Dinheiro
Decimal{2} lvdc_CV_Cheque_AV
Decimal{2} lvdc_CV_Cheque_AP
Decimal{2} lvdc_CV_Cartao_Debito
Decimal{2} lvdc_CV_Cartao_Credito

Decimal{2} lvdc_Valor

Date 	lvdt_Inicio
Date	lvdt_Termino

Long lvl_Linha
Long lvl_Filial

dw_1.AcceptText()

lvdt_Inicio 		= dw_1.Object.Dt_Inicio		[1]
lvdt_Termino 	= dw_1.Object.Dt_Termino	[1]

dw_2.AcceptText()

For lvl_Linha = 1 To dw_2.RowCount()
	
	lvl_Filial = dw_2.Object.Cd_Filial[lvl_Linha]

	Select		coalesce(sum(case when n.id_tipo_venda = 'CC' and n.cd_forma_pagamento = 'DI'  then n.vl_pago_avista else 0.00 end),0) as vl_cc_dinheiro,		
				coalesce(sum(case when n.id_tipo_venda = 'CC' and n.cd_forma_pagamento = 'HA' then n.vl_pago_avista else 0.00 end),0) as vl_cc_cheque_av,	
				coalesce(sum(case when n.id_tipo_venda = 'CC' and n.cd_forma_pagamento = 'HP' then n.vl_pago_avista else 0.00 end),0) as vl_cc_cheque_ap,
				coalesce(sum(case when n.id_tipo_venda = 'CC' and n.cd_forma_pagamento = 'CA' then n.vl_pago_avista else 0.00 end),0) as vl_cc_cartao_debito,
				coalesce(sum(case when n.id_tipo_venda = 'CC' and n.cd_forma_pagamento = 'CP' then n.vl_pago_avista else 0.00 end),0) as vl_cc_cartao_credito,
				coalesce(sum(case when n.id_tipo_venda = 'CR' and n.cd_forma_pagamento = 'DI'  then n.vl_pago_avista else 0.00 end),0) as vl_cr_dinheiro,		
				coalesce(sum(case when n.id_tipo_venda = 'CR' and n.cd_forma_pagamento = 'HA' then n.vl_pago_avista else 0.00 end),0) as vl_cr_cheque_av,	
				coalesce(sum(case when n.id_tipo_venda = 'CR' and n.cd_forma_pagamento = 'HP' then n.vl_pago_avista else 0.00 end),0) as vl_cr_cheque_ap,
				coalesce(sum(case when n.id_tipo_venda = 'CR' and n.cd_forma_pagamento = 'CA' then n.vl_pago_avista else 0.00 end),0) as vl_cr_cartao_debito,
				coalesce(sum(case when n.id_tipo_venda = 'CR' and n.cd_forma_pagamento = 'CP' then n.vl_pago_avista else 0.00 end),0) as vl_cr_cartao_credito,
				coalesce(sum(case when n.id_tipo_venda = 'CV' and n.cd_forma_pagamento = 'DI'  then n.vl_pago_avista else 0.00 end),0) as vl_cv_dinheiro,		
				coalesce(sum(case when n.id_tipo_venda = 'CV' and n.cd_forma_pagamento = 'HA' then n.vl_pago_avista else 0.00 end),0) as vl_cv_cheque_av,	
				coalesce(sum(case when n.id_tipo_venda = 'CV' and n.cd_forma_pagamento = 'HP' then n.vl_pago_avista else 0.00 end),0) as vl_cv_cheque_ap,
				coalesce(sum(case when n.id_tipo_venda = 'CV' and n.cd_forma_pagamento = 'CA' then n.vl_pago_avista else 0.00 end),0) as vl_cv_cartao_debito,
				coalesce(sum(case when n.id_tipo_venda = 'CV' and n.cd_forma_pagamento = 'CP' then n.vl_pago_avista else 0.00 end),0) as vl_cv_cartao_credito
	Into 	:lvdc_CC_Dinheiro,
			:lvdc_CC_Cheque_AV,
			:lvdc_CC_Cheque_AP,
			:lvdc_CC_Cartao_Debito,
			:lvdc_CC_Cartao_Credito,
			:lvdc_CR_Dinheiro,
			:lvdc_CR_Cheque_AV,
			:lvdc_CR_Cheque_AP,
			:lvdc_CR_Cartao_Debito,
			:lvdc_CR_Cartao_Credito,
			:lvdc_CV_Dinheiro,
			:lvdc_CV_Cheque_AV,
			:lvdc_CV_Cheque_AP,
			:lvdc_CV_Cartao_Debito,
			:lvdc_CV_Cartao_Credito
	From nf_venda n
	Where n.dh_movimentacao_caixa between :lvdt_Inicio and :lvdt_Termino
		 and n.cd_filial = :lvl_Filial
		 and n.id_tipo_venda <> 'AV'
		 and n.cd_forma_pagamento not in (n.id_tipo_venda, 'MF')
		 and n.dh_cancelamento is null
		 and n.nr_nf_anexa is null
		 and n.vl_pago_avista > 0.00
	Using SQLCa;
	
	If SqlCa.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos valores de pagamentos $$HEX1$$e000$$ENDHEX$$ vista. - " + SqlCa.SqlErrText)
	elseIf SqlCa.SqlCode = 100 Then
		Continue
	End If

	//Aumenta o valor pago em dinheiro
	lvdc_Valor = dw_2.Object.vl_venda_dinheiro[lvl_Linha]
	If IsNull(lvdc_Valor) Then lvdc_Valor = 0.00
	dw_2.Object.vl_venda_dinheiro[lvl_Linha] = lvdc_Valor + lvdc_CC_Dinheiro + lvdc_CR_Dinheiro + lvdc_CV_Dinheiro

	//Aumenta o valor pago em cheque a vista
	lvdc_Valor = dw_2.Object.vl_venda_cheque_avista[lvl_Linha]
	If IsNull(lvdc_Valor) Then lvdc_Valor = 0.00
	dw_2.Object.vl_venda_cheque_avista[lvl_Linha] = lvdc_Valor + lvdc_CC_Cheque_AV + lvdc_CR_Cheque_AV + lvdc_CV_Cheque_AV

	//Aumenta o valor pago em cheque a prazo
	lvdc_Valor = dw_2.Object.vl_venda_cheque_aprazo[lvl_Linha]
	If IsNull(lvdc_Valor) Then lvdc_Valor = 0.00
	dw_2.Object.vl_venda_cheque_aprazo[lvl_Linha] = lvdc_Valor + lvdc_CC_Cheque_AP + lvdc_CR_Cheque_AP + lvdc_CV_Cheque_AP
	
	//Aumenta o valor pago em cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito
	lvdc_Valor = dw_2.Object.Vl_Venda_Cartao_Credito[lvl_Linha]
	If IsNull(lvdc_Valor) Then lvdc_Valor = 0.00
	dw_2.Object.Vl_Venda_Cartao_Credito[lvl_Linha] = lvdc_Valor + lvdc_CC_Cartao_Credito + lvdc_CR_Cartao_Credito + lvdc_CV_Cartao_Credito
	
	//Aumenta o valor pago em cart$$HEX1$$e300$$ENDHEX$$o de d$$HEX1$$e900$$ENDHEX$$bito
	lvdc_Valor = dw_2.Object.vl_venda_cartao_debito[lvl_Linha]
	If IsNull(lvdc_Valor) Then lvdc_Valor = 0.00
	dw_2.Object.vl_venda_cartao_debito[lvl_Linha] = lvdc_Valor + lvdc_CC_Cartao_Debito + lvdc_CR_Cartao_Debito + lvdc_CV_Cartao_Debito 
	
	//Reduz o valor pago em cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito das vendas do tipo conta corrente
	lvdc_Valor = dw_2.Object.vl_venda_conta_corrente[lvl_Linha]
	If IsNull(lvdc_Valor) Then lvdc_Valor = 0.00
	dw_2.Object.vl_venda_conta_corrente[lvl_Linha] = lvdc_Valor - lvdc_CC_Cartao_Credito - lvdc_CC_Cartao_Debito - lvdc_CC_Cheque_AV - lvdc_CC_Cheque_AP - lvdc_CC_Dinheiro
	
	//Reduz o valor pago em cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito das vendas do tipo credi$$HEX1$$e100$$ENDHEX$$rio
	lvdc_Valor = dw_2.Object.vl_venda_crediario[lvl_Linha]
	If IsNull(lvdc_Valor) Then lvdc_Valor = 0.00
	dw_2.Object.vl_venda_crediario[lvl_Linha] = lvdc_Valor - lvdc_CR_Cartao_Credito - lvdc_CR_Cartao_Debito - lvdc_CR_Cheque_AV - lvdc_CR_Cheque_AP - lvdc_CR_Dinheiro
	
	//Reduz o valor pago em cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito das vendas do tipo conv$$HEX1$$ea00$$ENDHEX$$nio
	lvdc_Valor = dw_2.Object.vl_venda_convenio[lvl_Linha]
	If IsNull(lvdc_Valor) Then lvdc_Valor = 0.00
	dw_2.Object.vl_venda_convenio[lvl_Linha] = lvdc_Valor - lvdc_CV_Cartao_Credito - lvdc_CV_Cartao_Debito - lvdc_CV_Cheque_AV - lvdc_CV_Cheque_AP - lvdc_CV_Dinheiro
	
	Select		coalesce(sum(case when n.id_tipo_venda = 'CC' and n.cd_forma_pagamento = 'DI'  then np.vl_pagamento else 0.00 end),0) as vl_cc_dinheiro,		
				coalesce(sum(case when n.id_tipo_venda = 'CC' and n.cd_forma_pagamento = 'HA' then np.vl_pagamento else 0.00 end),0) as vl_cc_cheque_av,	
				coalesce(sum(case when n.id_tipo_venda = 'CC' and n.cd_forma_pagamento = 'HP' then np.vl_pagamento else 0.00 end),0) as vl_cc_cheque_ap,
				coalesce(sum(case when n.id_tipo_venda = 'CC' and n.cd_forma_pagamento = 'CA' then np.vl_pagamento else 0.00 end),0) as vl_cc_cartao_debito,
				coalesce(sum(case when n.id_tipo_venda = 'CC' and n.cd_forma_pagamento = 'CP' then np.vl_pagamento else 0.00 end),0) as vl_cc_cartao_credito,
				coalesce(sum(case when n.id_tipo_venda = 'CR' and n.cd_forma_pagamento = 'DI'  then np.vl_pagamento else 0.00 end),0) as vl_cr_dinheiro,		
				coalesce(sum(case when n.id_tipo_venda = 'CR' and n.cd_forma_pagamento = 'HA' then np.vl_pagamento else 0.00 end),0) as vl_cr_cheque_av,	
				coalesce(sum(case when n.id_tipo_venda = 'CR' and n.cd_forma_pagamento = 'HP' then np.vl_pagamento else 0.00 end),0) as vl_cr_cheque_ap,
				coalesce(sum(case when n.id_tipo_venda = 'CR' and n.cd_forma_pagamento = 'CA' then np.vl_pagamento else 0.00 end),0) as vl_cr_cartao_debito,
				coalesce(sum(case when n.id_tipo_venda = 'CR' and n.cd_forma_pagamento = 'CP' then np.vl_pagamento else 0.00 end),0) as vl_cr_cartao_credito,
				coalesce(sum(case when n.id_tipo_venda = 'CV' and n.cd_forma_pagamento = 'DI'  then np.vl_pagamento else 0.00 end),0) as vl_cv_dinheiro,		
				coalesce(sum(case when n.id_tipo_venda = 'CV' and n.cd_forma_pagamento = 'HA' then np.vl_pagamento else 0.00 end),0) as vl_cv_cheque_av,	
				coalesce(sum(case when n.id_tipo_venda = 'CV' and n.cd_forma_pagamento = 'HP' then np.vl_pagamento else 0.00 end),0) as vl_cv_cheque_ap,
				coalesce(sum(case when n.id_tipo_venda = 'CV' and n.cd_forma_pagamento = 'CA' then np.vl_pagamento else 0.00 end),0) as vl_cv_cartao_debito,
				coalesce(sum(case when n.id_tipo_venda = 'CV' and n.cd_forma_pagamento = 'CP' then np.vl_pagamento else 0.00 end),0) as vl_cv_cartao_credito
	Into 	:lvdc_CC_Dinheiro,
			:lvdc_CC_Cheque_AV,
			:lvdc_CC_Cheque_AP,
			:lvdc_CC_Cartao_Debito,
			:lvdc_CC_Cartao_Credito,
			:lvdc_CR_Dinheiro,
			:lvdc_CR_Cheque_AV,
			:lvdc_CR_Cheque_AP,
			:lvdc_CR_Cartao_Debito,
			:lvdc_CR_Cartao_Credito,
			:lvdc_CV_Dinheiro,
			:lvdc_CV_Cheque_AV,
			:lvdc_CV_Cheque_AP,
			:lvdc_CV_Cartao_Debito,
			:lvdc_CV_Cartao_Credito
	From nf_venda n
	inner join nf_venda_pagamento np
		on np.cd_filial = n.cd_filial
		and np.nr_nf = n.nr_nf
		and np.de_especie = n.de_especie
		and np.de_serie = n.de_serie
	Where n.dh_movimentacao_caixa between :lvdt_Inicio and :lvdt_Termino
		 and n.cd_filial = :lvl_Filial
		 and n.id_tipo_venda <> 'AV'
		 and n.cd_forma_pagamento = 'MF'
		 and np.cd_forma_pagamento <> n.id_tipo_venda
		 and n.dh_cancelamento is null
		 and n.nr_nf_anexa is null
		 and n.vl_pago_avista > 0.00
	Using SQLCa;
	
	//Aumenta o valor pago em dinheiro
	lvdc_Valor = dw_2.Object.vl_venda_dinheiro[lvl_Linha]
	If IsNull(lvdc_Valor) Then lvdc_Valor = 0.00
	dw_2.Object.vl_venda_dinheiro[lvl_Linha] = lvdc_Valor + lvdc_CC_Dinheiro + lvdc_CR_Dinheiro + lvdc_CV_Dinheiro

	//Aumenta o valor pago em cheque a vista
	lvdc_Valor = dw_2.Object.vl_venda_cheque_avista[lvl_Linha]
	If IsNull(lvdc_Valor) Then lvdc_Valor = 0.00
	dw_2.Object.vl_venda_cheque_avista[lvl_Linha] = lvdc_Valor + lvdc_CC_Cheque_AV + lvdc_CR_Cheque_AV + lvdc_CV_Cheque_AV

	//Aumenta o valor pago em cheque a prazo
	lvdc_Valor = dw_2.Object.vl_venda_cheque_aprazo[lvl_Linha]
	If IsNull(lvdc_Valor) Then lvdc_Valor = 0.00
	dw_2.Object.vl_venda_cheque_aprazo[lvl_Linha] = lvdc_Valor + lvdc_CC_Cheque_AP + lvdc_CR_Cheque_AP + lvdc_CV_Cheque_AP
	
	//Aumenta o valor pago em cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito
	lvdc_Valor = dw_2.Object.Vl_Venda_Cartao_Credito[lvl_Linha]
	If IsNull(lvdc_Valor) Then lvdc_Valor = 0.00
	dw_2.Object.Vl_Venda_Cartao_Credito[lvl_Linha] = lvdc_Valor + lvdc_CC_Cartao_Credito + lvdc_CR_Cartao_Credito + lvdc_CV_Cartao_Credito
	
	//Aumenta o valor pago em cart$$HEX1$$e300$$ENDHEX$$o de d$$HEX1$$e900$$ENDHEX$$bito
	lvdc_Valor = dw_2.Object.vl_venda_cartao_debito[lvl_Linha]
	If IsNull(lvdc_Valor) Then lvdc_Valor = 0.00
	dw_2.Object.vl_venda_cartao_debito[lvl_Linha] = lvdc_Valor + lvdc_CC_Cartao_Debito + lvdc_CR_Cartao_Debito + lvdc_CV_Cartao_Debito 
	
	//Reduz o valor pago em cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito das vendas do tipo conta corrente
	lvdc_Valor = dw_2.Object.vl_venda_conta_corrente[lvl_Linha]
	If IsNull(lvdc_Valor) Then lvdc_Valor = 0.00
	dw_2.Object.vl_venda_conta_corrente[lvl_Linha] = lvdc_Valor - lvdc_CC_Cartao_Credito - lvdc_CC_Cartao_Debito - lvdc_CC_Cheque_AV - lvdc_CC_Cheque_AP - lvdc_CC_Dinheiro
	
	//Reduz o valor pago em cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito das vendas do tipo credi$$HEX1$$e100$$ENDHEX$$rio
	lvdc_Valor = dw_2.Object.vl_venda_crediario[lvl_Linha]
	If IsNull(lvdc_Valor) Then lvdc_Valor = 0.00
	dw_2.Object.vl_venda_crediario[lvl_Linha] = lvdc_Valor - lvdc_CR_Cartao_Credito - lvdc_CR_Cartao_Debito - lvdc_CR_Cheque_AV - lvdc_CR_Cheque_AP - lvdc_CR_Dinheiro
	
	//Reduz o valor pago em cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito das vendas do tipo conv$$HEX1$$ea00$$ENDHEX$$nio
	lvdc_Valor = dw_2.Object.vl_venda_convenio[lvl_Linha]
	If IsNull(lvdc_Valor) Then lvdc_Valor = 0.00
	dw_2.Object.vl_venda_convenio[lvl_Linha] = lvdc_Valor - lvdc_CV_Cartao_Credito - lvdc_CV_Cartao_Debito - lvdc_CV_Cheque_AV - lvdc_CV_Cheque_AP - lvdc_CV_Dinheiro
Next 
end subroutine

on w_ge309_rel_resumo_venda_det.create
call super::create
end on

on w_ge309_rel_resumo_venda_det.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.Dt_Inicio 	[1] 	= Today()
dw_1.Object.Dt_Termino[1] 	= Today()

wf_Insere_Regiao_Default()

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

event close;call super::close;Destroy(ivo_Filial)
end event

event ue_preopen;call super::ue_preopen;MaxWidth	= 5585
MaxHeight	= 9999

ivo_Filial = Create uo_Filial
end event

event ue_saveas;dw_3.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge309_rel_resumo_venda_det
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge309_rel_resumo_venda_det
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge309_rel_resumo_venda_det
integer x = 9
integer y = 172
integer width = 3579
integer height = 1540
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge309_rel_resumo_venda_det
integer x = 9
integer y = 0
integer width = 3483
integer height = 172
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge309_rel_resumo_venda_det
integer x = 32
integer y = 56
integer width = 3442
integer height = 108
string dataobject = "dw_ge309_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;If dwo.name = "nm_filial" Then
	If Trim(Data) <> "" Then
		If Data <> ivo_Filial.Nm_Fantasia Then
			Return 1
		End If	
	Else	
		SetNull(ivo_Filial.Cd_Filial)
		ivo_Filial.Nm_Fantasia = ""
		
		This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
		This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
	End If
End If
end event

event dw_1::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

event dw_1::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_filial" Then
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
		End If
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge309_rel_resumo_venda_det
integer x = 27
integer y = 224
integer width = 3534
integer height = 1464
string dataobject = "dw_ge309_lista"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long 	lvl_Filial, &
		lvl_Regiao

dw_1.AcceptText()

lvl_Filial 		= dw_1.Object.Cd_Filial[1]
lvl_Regiao 	= dw_1.Object.Cd_Regiao[1]

If Not IsNull(lvl_Filial) and lvl_Filial > 0 Then
	This.of_AppendWhere("f.cd_filial = " + String(lvl_Filial))
End If

If Not IsNull(lvl_Regiao) and lvl_Regiao <> 0 Then
	This.of_AppendWhere("f.cd_regiao = " + String(lvl_Regiao))
End If	 

Return 1
end event

event dw_2::ue_recuperar;// Override

Date lvdt_Inicio, &
     lvdt_Termino
	  
lvdt_Inicio  = dw_1.Object.Dt_Inicio [1]
lvdt_Termino = dw_1.Object.Dt_Termino[1]

If IsNull(lvdt_Inicio) or Not IsDate(String(lvdt_Inicio)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdt_Termino) or Not IsDate(String(lvdt_Termino)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior ou igual a data de in$$HEX1$$ed00$$ENDHEX$$cio.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

This.SetRedraw(False)
This.Retrieve(lvdt_Inicio, lvdt_Termino)

Return This.RowCount()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	
	Open(w_aguarde)
	w_aguarde.uo_progress.Of_SetMax(3)
	w_aguarde.Title = "Recuperando as opera$$HEX2$$e700f500$$ENDHEX$$es de recarga e pagamentos..."
	wf_atualiza_operacoes_debito()
	w_aguarde.uo_progress.Of_SetProgress(1)
//	w_aguarde.Title = "Recuperando valores d$$HEX1$$e900$$ENDHEX$$bito pagos parciais em vendas.."
//	wf_atualiza_vendas_cartao('D')
//	w_aguarde.uo_progress.Of_SetProgress(2)
//	w_aguarde.Title = "Recuperando valores cr$$HEX1$$e900$$ENDHEX$$dito pagos parciais em vendas.."
//	wf_atualiza_vendas_cartao('C')
//	w_aguarde.uo_progress.Of_SetProgress(3)
	w_aguarde.Title = "Recuperando valores pagamentos a vista.."
	wf_atualiza_pagamento_avista()
	Close(w_aguarde)
	
	This.ivm_Menu.mf_SalvarComo(True)
Else
	This.ivm_Menu.mf_SalvarComo(False)
End If

This.SetRedraw(True)

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_filial", &
              "nm_fantasia"}

lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo da Filial", &
            "Nome de Fantasia"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)

end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_Menu.mf_SalvarComo(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge309_rel_resumo_venda_det
integer x = 2720
integer y = 488
integer height = 148
integer taborder = 50
string dataobject = "dw_ge309_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;String 	lvs_Periodo, &
			lvs_Regiao

Date 	lvdt_Inicio, &
     	lvdt_Termino
	  
DataWindowChild lvdwc_Tipo
	  
If AncestorReturnValue > 0 Then
	lvdt_Inicio  		= dw_1.Object.Dt_Inicio 		[1]
	lvdt_Termino 	= dw_1.Object.Dt_Termino	[1]
	
	lvs_Periodo = String(lvdt_Inicio, "dd/mm/yyyy") + " $$HEX1$$e000$$ENDHEX$$ " + String(lvdt_Termino, "dd/mm/yyyy")
	
	dw_1.GetChild("cd_regiao", lvdwc_Tipo)	
	lvs_Regiao = lvdwc_Tipo.GetItemString(lvdwc_Tipo.GetRow(), "de_regiao") 	
	
	This.Object.Periodo_Cabecalho.Text 	= lvs_Periodo
	This.Object.Regiao_t.Text 				= lvs_Regiao
End If

Return AncestorReturnValue

end event

