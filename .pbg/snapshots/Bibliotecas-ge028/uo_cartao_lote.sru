HA$PBExportHeader$uo_cartao_lote.sru
forward
global type uo_cartao_lote from nonvisualobject
end type
end forward

global type uo_cartao_lote from nonvisualobject
end type
global uo_cartao_lote uo_cartao_lote

type variables
date 	ivdt_deposito, &
        	ivdt_credito, &
		ivdt_venda

string ivs_estabelecimento, &
         ivs_estabelecimento_matriz, &
         ivs_estabelecimento_grupo, &
         ivs_lote, &
         ivs_tipo_operacao, &
         ivs_tipo_comprovante, &
         ivs_opcao_extrato, &
         ivs_plano_operacao, &
         ivs_debito_credito, &
         ivs_arquivo_em_processamento, &
	 	ivs_Banco, &
	 	ivs_Agencia, &
	 	ivs_Conta, &
		ivs_Nr_RV

decimal ivdc_valor_bruto, &
             ivdc_valor_desconto, &
             ivdc_valor_liquido, &
             ivdc_valor_comissao, &
             ivdc_valor_rejeitado, &
             ivdc_valor_bruto_cv, &
             ivdc_valor_desconto_cv, &
             ivdc_valor_liquido_cv, &
             ivdc_valor_rejeitado_cv, &
             ivdc_valor_bruto_geral, &
		    ivdc_valor_comissao_geral, &
             ivdc_valor_desconto_geral, &
             ivdc_valor_liquido_geral, &
             ivdc_valor_gorjeta_geral, &
             ivdc_valor_rotativo_geral, &
             ivdc_valor_rejeitado_geral, &
             ivdc_valor_parcelado_sj_geral, &
             ivdc_valor_saque

Decimal{2}  ivdc_Perc_Comissao
            
long ivl_qtde_aceita, &
        ivl_qtde_rejeitada, &
        ivl_qtde_aceita_cv, &
        ivl_qtde_rejeitada_cv, &
        ivl_tipo_operacao, &
        ivl_qtd_comprovantes, &
        ivl_qtd_comprovantes_cv, &
        ivl_qtd_comprovantes_geral, &
        ivl_nr_pontos_venda, &
        ivl_qtd_compr_rejeitados_geral, &
        ivl_total_registros, &
        ivl_total_matrizes

Constant String VENDA_DEBITO = 'E', &
                         VENDA_CREDITO = ' ', &
                         AJUSTE = '07', &
                         ALUGUEL_POS = '12', &
                         LIQUIDACAO = '14'
end variables

forward prototypes
public function boolean of_proximo_sequencial (long al_administradora, string as_estabelecimento, string as_lote, ref long al_sequencial, ref string as_mensagem)
public function boolean of_inclui_operacao (long al_administradora, string as_estabelecimento, string as_lote, long al_tipo, date adt_deposito, date adt_credito, decimal adc_bruto, decimal adc_comissao, decimal adc_rejeitado, string as_plano, string as_aceleracao_revenda, string as_situacao, string as_banco, string as_agencia, string as_conta, ref string as_mensagem)
public function boolean of_inclui_operacao (long al_administradora, string as_estabelecimento, string as_lote, long al_tipo, date adt_deposito, date adt_credito, decimal adc_bruto, decimal adc_comissao, decimal adc_rejeitado, string as_plano, string as_aceleracao_revenda, string as_situacao, string as_banco, string as_agencia, string as_conta, ref string as_mensagem, decimal adc_ajuste, string as_motivo_ajuste, long al_comprovante, string as_problema_conciliacao, string as_nr_rv, string as_nr_rv_original, decimal adc_liquido, string as_cd_motivo_ajuste, long al_cd_tipo_operacao_ajuste)
end prototypes

public function boolean of_proximo_sequencial (long al_administradora, string as_estabelecimento, string as_lote, ref long al_sequencial, ref string as_mensagem);Boolean lvb_Sucesso = True

String lvs_Chave

lvs_Chave = String(al_Administradora) + "-" + as_Estabelecimento + "-" + as_Lote

Select max(nr_operacao) Into :al_Sequencial
From cartao_lote_operacao
Where cd_administradora  = :al_Administradora
  and cd_estabelecimento = :as_Estabelecimento
  and nr_lote            = :as_Lote
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(al_Sequencial) Then al_Sequencial = 0
		al_Sequencial ++
	Case 100
		al_Sequencial = 1
	Case -1
		as_Mensagem += "Erro na Verifica$$HEX2$$e700e300$$ENDHEX$$o da Pr$$HEX1$$f300$$ENDHEX$$xima Opera$$HEX2$$e700e300$$ENDHEX$$o do Lote '" + lvs_Chave + "'. " + SqlCa.SqlErrText
		lvb_Sucesso = False
End Choose

Return lvb_Sucesso
end function

public function boolean of_inclui_operacao (long al_administradora, string as_estabelecimento, string as_lote, long al_tipo, date adt_deposito, date adt_credito, decimal adc_bruto, decimal adc_comissao, decimal adc_rejeitado, string as_plano, string as_aceleracao_revenda, string as_situacao, string as_banco, string as_agencia, string as_conta, ref string as_mensagem);Long lvl_Null

SetNull(lvl_Null)

Return This.of_Inclui_Operacao(	al_administradora,  &
									as_estabelecimento, &
									as_lote, &
									al_tipo, &
									adt_deposito, &
									adt_credito, &
									adc_bruto, &
									adc_comissao, &
									adc_rejeitado, &
									as_plano, &
									as_aceleracao_revenda, &
									as_situacao, &
									as_banco, &
									as_agencia, &
									as_conta, &
									ref as_mensagem, &
									0.00, &
									"", &
									0, &
									"", &
									"", &
									"", &
									0.00, &
									"", &
									lvl_Null)

end function

public function boolean of_inclui_operacao (long al_administradora, string as_estabelecimento, string as_lote, long al_tipo, date adt_deposito, date adt_credito, decimal adc_bruto, decimal adc_comissao, decimal adc_rejeitado, string as_plano, string as_aceleracao_revenda, string as_situacao, string as_banco, string as_agencia, string as_conta, ref string as_mensagem, decimal adc_ajuste, string as_motivo_ajuste, long al_comprovante, string as_problema_conciliacao, string as_nr_rv, string as_nr_rv_original, decimal adc_liquido, string as_cd_motivo_ajuste, long al_cd_tipo_operacao_ajuste);String lvs_Chave

Long lvl_Sequencial

Decimal lvdc_Vl_Liquido

lvs_Chave = String(al_Administradora) + "-" + as_Estabelecimento + "-" + as_Lote

If as_banco = '000' or as_banco = '   ' or as_banco = '' Then 
	SetNull(as_banco)
Else
	as_banco = String(Long(as_banco),"000")
End If

If as_agencia = '00000' or as_agencia = '000000' or as_agencia = '      ' or as_agencia = '' Then 
	SetNull(as_agencia)
Else
	as_agencia = String(Long(as_agencia),"000000")
End If

If as_conta = ' ' or as_conta = space(11) or as_conta = '' Then 
	SetNull(as_conta)
Else
	as_conta = String(Long(as_conta), "00000000000")
End If

If Not This.of_Proximo_Sequencial(al_Administradora, &
										    as_Estabelecimento, &
										    as_Lote, &
										    ref lvl_Sequencial, &
										    ref as_Mensagem) Then
	Return False
End If

If adc_liquido = 0.00 Then
	lvdc_Vl_Liquido = adc_Bruto - adc_Comissao
Else 
	lvdc_Vl_Liquido = adc_liquido
End If

Insert Into cartao_lote_operacao (	cd_administradora,   
									cd_estabelecimento,   
									nr_lote,   
									nr_operacao,   
									cd_tipo_operacao,   
									dh_deposito,   
									dh_credito,
									dh_registro,   
									vl_bruto,   
									vl_comissao,   
									vl_rejeitado,
									de_plano,
									id_aceleracao_revenda,
									id_conciliada,
									de_problema_conciliacao,
									cd_banco,
									nr_agencia,
									nr_conta,
									vl_ajuste,
									de_motivo_ajuste,
									nr_comprovante,
									cd_motivo_ajuste,
									nr_rv,
									nr_rv_original,
									vl_liquido,
									cd_tipo_operacao_ajuste)  									
Select :al_Administradora,
        	:as_Estabelecimento,
		:as_Lote,
		:lvl_Sequencial,
		:al_Tipo,
		:adt_Deposito,
		:adt_Credito,
		getdate(),
		:adc_Bruto,
		:adc_Comissao,
		:adc_Rejeitado,
		:as_Plano,
		:as_Aceleracao_Revenda,
		:as_Situacao,
		:as_problema_conciliacao,
		:as_banco,
		:as_agencia,
		:as_conta,
		:adc_ajuste,
		:as_motivo_ajuste,
		:al_comprovante,
		:as_cd_motivo_ajuste,
		:as_nr_rv,
		:as_nr_rv_original,
		:lvdc_Vl_Liquido,
		:al_cd_tipo_operacao_ajuste
 From cartao_administradora
 where cd_administradora = :al_Administradora
      and not exists (select 1 
					  from cartao_lote_operacao
					where cd_administradora 			= :al_Administradora
						and cd_estabelecimento			= :as_Estabelecimento
						and nr_operacao					= :lvl_Sequencial
						and dh_credito						= :adt_Credito
						and cd_tipo_operacao			= :al_Tipo
						and vl_bruto						= :adc_Bruto
						and nr_comprovante				= :al_Comprovante
						and cd_tipo_operacao_ajuste	= :al_cd_tipo_operacao_ajuste
						and vl_ajuste						= :adc_ajuste
						and nr_rv							= :as_nr_rv
						and de_motivo_ajuste			= :as_motivo_ajuste
					)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Mensagem += "Erro na Inclus$$HEX1$$e300$$ENDHEX$$o do Movimento do Lote '" + lvs_Chave + "'. " + SqlCa.SqlErrText
	Return False
End If

Return True
end function

on uo_cartao_lote.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cartao_lote.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

