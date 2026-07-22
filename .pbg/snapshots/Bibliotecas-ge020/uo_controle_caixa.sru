HA$PBExportHeader$uo_controle_caixa.sru
forward
global type uo_controle_caixa from nonvisualobject
end type
end forward

global type uo_controle_caixa from nonvisualobject
end type
global uo_controle_caixa uo_controle_caixa

type variables
string ivs_Caixa_INI

boolean ivb_Caixa

Integer  ivi_recibo_cheque, &
             ivi_recibo_nf_convenio_problema, &
             ivi_recibo_nf_convenio_parcial, &
             ivi_recibo_titulo_crediario, &
             ivi_recibo_titulo_convenio, &
             ivi_recibo_titulo_conta_corrente, &
             ivi_recibo_outros

string cd_caixa, &
          nr_matricula_operador, &
          nm_operador, &
          de_caixa

long nr_controle_caixa

decimal vl_saldo_final

datetime dh_abertura_caixa, &
              dh_fechamento_caixa, &
              dh_movimentacao_caixa

Decimal idc_recibo 
String     is_texto_recibo
String     is_dados_recibo[]
end variables

forward prototypes
public function integer of_recibo_nf_convenio_parcial ()
public function integer of_recibo_nf_convenio_problema ()
public function integer of_recibo_titulo_convenio ()
public function integer of_recibo_titulo_crediario ()
public function integer of_recibo_titulo_conta_corrente ()
public function long of_conta_fluxo_caixa_recibo (integer pi_tipo_recibo)
public function long of_proximo_lancamento_caixa (string ps_caixa, long pl_controle_caixa)
public function boolean of_caixa_cadastrado (string ps_caixa, long pl_filial)
public function string of_numero_recibo (long pl_filial)
public function long of_controle_caixa_aberto (string ps_caixa, boolean pb_showmessage)
public function long of_controle_caixa_aberto (string ps_caixa)
public function integer of_recibo_outros ()
public function integer of_recibo_cheque ()
public function long of_conta_fluxo_venda_avista ()
public function integer of_recibo_convenio_conta ()
public function integer of_recibo_conta_corrente_conta ()
public function long of_conta_transferencia_caixa_geral ()
public function long of_conta_transferencia_outro_caixa ()
public function boolean of_caixa_geral (string ps_caixa)
public function boolean of_caixa_aberto (string ps_caixa)
public function string of_caixa_geral (long pl_filial)
public function boolean of_insere_lancamento_caixa (string ps_caixa, long pl_controle, long pl_conta_fluxo_caixa, datetime pdh_data_lancamento, decimal pdc_valor_lancamento, string ps_historico, string ps_recibo_cobranca)
public function boolean of_insere_lancamento_caixa (string ps_caixa, long pl_conta_fluxo_caixa, datetime pdh_data_lancamento, decimal pdc_valor_lancamento, string ps_historico, string ps_recibo_cobranca)
public function boolean of_localiza_controle_caixa ()
public function datetime of_data_parametro ()
public function boolean of_localiza_controle_caixa (string ps_caixa, long pl_controle)
public function integer of_tipo_recibo (string ps_nf_convenio_parcial, string ps_nf_convenio_problema, string ps_titulo_convenio, string ps_titulo_crediario, string ps_titulo_conta_corrente, string ps_cheque, string ps_outros, string ps_convenio_conta, string ps_conta_corrente_conta, string ps_juros, string ps_desconto)
public function integer of_recibo_juros ()
public function integer of_recibo_desconto ()
public function boolean of_localiza_controle_caixa (boolean ab_nao_conferidos)
public function boolean of_caixa_finalizado (string ps_caixa, integer pl_controle)
public function boolean of_carrega_caixa ()
public function boolean of_imprime_recibo_cheque (string ps_recibo_cobranca)
public function boolean of_imprime_recibo_cv_cc_conta (string ps_recibo_cobranca, string ps_tipo_recibo)
public function boolean of_imprime_recibo_nota (string ps_recibo_cobranca)
public function boolean of_imprime_recibo_outros (string ps_recibo_cobranca)
public function boolean of_imprime_recibo_titulo_cc_cr (string ps_recibo_cobranca)
public function boolean of_imprime_recibo_titulo_cv (string ps_recibo_cobranca)
public subroutine of_texto_recibo ()
public function boolean of_insere_lancamento_caixa (string ps_caixa, long pl_controle, long pl_conta_fluxo_caixa, datetime pdh_data_lancamento, decimal pdc_valor_lancamento, string ps_historico, string ps_recibo_cobranca, string ps_estorno)
public function boolean of_localiza_controle_caixa (long pl_filial, boolean pb_nao_conferidos)
public function string of_insere_recibo_titulo_convenio (long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, string ps_titulo, string ps_caixa, string ps_forma_pagamento, decimal pdc_valor_multa)
public function string of_insere_recibo_titulo_conta_corrente (long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, string ps_titulo, string ps_caixa, string ps_forma_pagamento, decimal pdc_valor_multa)
public function boolean of_insere_lancamento_caixa (string ps_caixa, long pl_controle, long pl_conta_fluxo_caixa, datetime pdh_data_lancamento, decimal pdc_valor_lancamento, string ps_historico, string ps_recibo_cobranca, string ps_estorno, string ps_nr_documento)
public function string of_insere_recibo_outros (string ps_recibo_cobranca, long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, string ps_cliente, string ps_cheque, string ps_banco, string ps_caixa, string ps_forma_pagamento)
public function string of_insere_recibo_outros (long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, string ps_cliente, string ps_observacao, string ps_forma_pagamento)
public function string of_insere_recibo_cc_conta (long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, string ps_responsavel, string ps_cliente, string ps_observacao, string ps_caixa, long pl_nr_controle_caixa, string ps_forma_pagamento)
public function string of_insere_recibo_cv_conta (long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, string ps_responsavel, string ps_cliente, string ps_observacao, string ps_caixa, long pl_nr_controle_caixa, string ps_forma_pagamento)
public function string of_insere_recibo_nf_convenio_problema (long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, long pl_filial_venda, long pl_nf, string ps_especie, string ps_serie, string ps_observacao, string ps_caixa, long pl_nr_controle_caixa, string ps_conveniado, string ps_forma_pagamento)
public function string of_insere_recibo_nf_clube_parcial (long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, string ps_titulo, long pl_filial_venda, long pl_nf, string ps_especie, string ps_serie, string ps_caixa, string ps_cliente, string ps_forma_pagamento)
public function string of_insere_recibo_vale_caixa (long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, string ps_colaborador, string ps_motivo, string ps_forma_pagamento)
public function string of_insere_recibo_nf_convenio_parcial (long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, string ps_titulo, long pl_filial_venda, long pl_nf, string ps_especie, string ps_serie, string ps_caixa, string ps_conveniado, long pl_conta_parcial, string ps_forma_pagamento)
public function string of_insere_recibo_titulo_crediario (long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, string ps_titulo, string ps_caixa, string ps_forma_pagamento, decimal pdc_valor_multa)
public function boolean of_insere_recibo_cheque (long pl_filial, string ps_cd_banco, string ps_nr_agencia, string ps_nr_conta, string ps_nr_cheque, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_pago, string ps_historico, string ps_caixa, long pl_controle_caixa, string ps_responsavel, string ps_forma_pagamento, string ps_nome_cliente, string ps_nome_banco)
public function boolean of_insere_recibo_cobranca (string ps_recibo_cobranca, long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, integer pi_tipo_recibo, string ps_titulo, string ps_cliente, string ps_cheque, string ps_nome_banco, long pl_filial_venda, long pl_nf, string ps_especie, string ps_serie, string ps_observacao, date pdh_data_cheque, decimal pdc_valor_cheque, decimal pdc_valor_multa, string ps_forma_pagamento)
public function boolean of_insere_recibo_cobranca (string ps_recibo_cobranca, long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, integer pi_tipo_recibo, string ps_titulo, string ps_cliente, string ps_cheque, string ps_nome_banco, long pl_filial_venda, long pl_nf, string ps_especie, string ps_serie, string ps_observacao, date pdh_data_cheque, decimal pdc_valor_cheque, decimal pdc_valor_multa, string ps_forma_pagamento, string ps_cd_banco, string ps_nr_agencia, string ps_nr_conta)
public function boolean of_caixa_geral_movimento (long pl_filial, ref string ps_caixa, ref long pl_controle)
end prototypes

public function integer of_recibo_nf_convenio_parcial ();Return of_Tipo_Recibo("S", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N")
end function

public function integer of_recibo_nf_convenio_problema ();Return of_Tipo_Recibo("N", "S", "N", "N", "N", "N", "N", "N", "N", "N", "N")
end function

public function integer of_recibo_titulo_convenio ();Return of_Tipo_Recibo( "N", "N", "S", "N", "N", "N", "N", "N", "N", "N", "N")
end function

public function integer of_recibo_titulo_crediario ();Return of_Tipo_Recibo("N", "N", "N", "S", "N", "N", "N", "N", "N", "N", "N")
end function

public function integer of_recibo_titulo_conta_corrente ();Return of_Tipo_Recibo( "N", "N", "N", "N", "S", "N", "N", "N", "N", "N", "N")
end function

public function long of_conta_fluxo_caixa_recibo (integer pi_tipo_recibo);Long lvl_Conta

Select cd_conta_fluxo_caixa Into :lvl_Conta
From tipo_recibo_cobranca
Where cd_tipo_recibo = :pi_Tipo_Recibo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return lvl_Conta
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Conta de fluxo de caixa n$$HEX1$$e300$$ENDHEX$$o encontrada.", StopSign!)
		Return -1		
	Case -1
		Sqlca.of_RollBack()
		Sqlca.of_MsgDBError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da conta de fluxo de caixa.")
		Return -1
End Choose
end function

public function long of_proximo_lancamento_caixa (string ps_caixa, long pl_controle_caixa);Long lvl_Lancamento

Select Max(nr_lancamento) Into :lvl_Lancamento
From lancamento_caixa
Where cd_caixa          = :ps_Caixa
  and nr_controle_caixa = :pl_Controle_Caixa;
  
Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(lvl_Lancamento) and lvl_Lancamento > 0 Then
			Return lvl_Lancamento + 1
		Else
			Return 1
		End If
	Case 100
		Return 1
	Case -1		
		Sqlca.of_RollBack()	
		Sqlca.of_MsgDBError( "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo n$$HEX1$$fa00$$ENDHEX$$mero de lan$$HEX1$$e700$$ENDHEX$$amento do caixa." )
		Sqlca.of_LogDBError(gvo_aplicacao.ivi_log,"Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo n$$HEX1$$fa00$$ENDHEX$$mero de lan$$HEX1$$e700$$ENDHEX$$amento do caixa.")
		Return -1
End Choose
end function

public function boolean of_caixa_cadastrado (string ps_caixa, long pl_filial);Long lvl_Filial

Select cd_filial Into :lvl_Filial
From caixa
Where cd_caixa = :ps_Caixa;
  
Choose Case SqlCa.SqlCode
	Case 0
		If lvl_Filial = pl_Filial Then
			Return True
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O caixa '" + ps_Caixa + "' n$$HEX1$$e300$$ENDHEX$$o pertence a filial '" + String(pl_Filial) + "'.", StopSign!, Ok!)
			Return False
		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Caixa '" + ps_Caixa + "' n$$HEX1$$e300$$ENDHEX$$o cadastrado.", StopSign!, Ok!)
		Return False
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do caixa." + SqlCa.SqlErrText, StopSign!, Ok!)
		Return False
End Choose
end function

public function string of_numero_recibo (long pl_filial);//
STRING lvs_recibo 
LONG   lvl_nr_recibo
//
select max(nr_recibo_cobranca)
  into :lvs_recibo
  from recibo_cobranca
  Using SqlCa;  
 
 ///
IF SQLCA.SQLCode = -1 THEN 
	Sqlca.of_RollBack()	
	Sqlca.of_MsgDBError( "Erro ao selecionar n$$HEX1$$fa00$$ENDHEX$$mero do recibo." )
	Sqlca.of_LogDBError(gvo_aplicacao.ivi_log,"Erro ao selecionar n$$HEX1$$fa00$$ENDHEX$$mero do recibo.")
	RETURN ""
END IF
//
lvs_recibo = MidA(lvs_recibo,5)
lvl_nr_recibo = LONG(lvs_recibo)
//
IF ISNULL(lvl_nr_recibo) THEN lvl_nr_recibo = 0
//
lvl_nr_recibo ++
//
lvs_recibo = STRING(pl_filial, "0000") + STRING(lvl_nr_recibo,"0000000")
//
RETURN lvs_recibo
//
end function

public function long of_controle_caixa_aberto (string ps_caixa, boolean pb_showmessage);Long lvl_Controle

Select nr_controle_caixa Into :lvl_Controle
From   controle_caixa
Where  cd_caixa = :ps_Caixa
  and  dh_fechamento_caixa is null;
  
Choose Case SqlCa.SqlCode
	Case 0
		Return lvl_Controle
	Case 100
		IF pb_showmessage THEN
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O caixa '" + ps_Caixa + "' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ aberto.", Exclamation!, Ok!)
		END IF
		Return -1
	Case -1
		IF pb_showmessage THEN
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do n$$HEX1$$fa00$$ENDHEX$$mero de controle do caixa em aberto." + SqlCa.SqlErrText, StopSign!, Ok!)
			gvo_aplicacao.of_grava_log("Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do n$$HEX1$$fa00$$ENDHEX$$mero de controle do caixa em aberto." + SqlCa.SqlErrText)
		END IF
		Return -1
End Choose
end function

public function long of_controle_caixa_aberto (string ps_caixa);//
RETURN of_controle_caixa_aberto(ps_caixa, TRUE)
//
end function

public function integer of_recibo_outros ();Return of_Tipo_Recibo("N", "N", "N", "N", "N", "N", "S", "N", "N", "N", "N")
end function

public function integer of_recibo_cheque ();Return of_Tipo_Recibo("N", "N", "N", "N", "N", "S", "N", "N", "N", "N", "N")
end function

public function long of_conta_fluxo_venda_avista ();Long lvl_Conta

Select cd_conta_fluxo_caixa Into :lvl_Conta
From tipo_recibo_cobranca
Where id_venda_avista          = 'S'
  and id_nf_convenio_parcial   = 'N'
  and id_nf_convenio_problema  = 'N'
  and id_titulo_convenio       = 'N'
  and id_titulo_crediario      = 'N'
  and id_titulo_conta_corrente = 'N'
  and id_cheque                = 'N'
  and id_outros					 = 'N';

Choose Case SqlCa.SqlCode
	Case 0
		Return lvl_Conta
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Conta fluxo das vendas a vista n$$HEX1$$e300$$ENDHEX$$o localizada.", StopSign!, Ok!)
		Return -1		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da conta fluxo das vendas a vista." + SqlCa.SqlErrText, StopSign!, Ok!)
		gvo_aplicacao.of_grava_log("Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da conta fluxo das vendas a vista." + SqlCa.SqlErrText)
		Return -1
End Choose
end function

public function integer of_recibo_convenio_conta ();Return of_Tipo_Recibo("N", "N", "N", "N", "N", "N", "N", "S", "N", "N", "N")
end function

public function integer of_recibo_conta_corrente_conta ();Return of_Tipo_Recibo("N", "N", "N", "N", "N", "N", "N", "N", "S", "N", "N")
end function

public function long of_conta_transferencia_caixa_geral ();Long lvl_Conta

Select cd_conta_fluxo_caixa Into :lvl_Conta
From tipo_recibo_cobranca
Where id_venda_avista              = 'N'
  and id_nf_convenio_parcial       = 'N'
  and id_nf_convenio_problema      = 'N'
  and id_titulo_convenio           = 'N'
  and id_titulo_crediario          = 'N'
  and id_titulo_conta_corrente     = 'N'
  and id_cheque                    = 'N'
  and id_outros					     = 'N'
  and id_transferencia_outro_caixa = 'N'
  and id_transferencia_caixa_geral = 'S';

Choose Case SqlCa.SqlCode
	Case 0
		Return lvl_Conta
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Conta fluxo de transfer$$HEX1$$ea00$$ENDHEX$$ncia para o caixa geral.", StopSign!, Ok!)
		Return -1		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da conta fluxo das vendas a vista." + SqlCa.SqlErrText, StopSign!, Ok!)
		gvo_aplicacao.of_grava_log("Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da conta fluxo das vendas a vista." + SqlCa.SqlErrText)
		Return -1
End Choose
end function

public function long of_conta_transferencia_outro_caixa ();Long lvl_Conta

Select cd_conta_fluxo_caixa Into :lvl_Conta
From tipo_recibo_cobranca
Where id_venda_avista              = 'N'
  and id_nf_convenio_parcial       = 'N'
  and id_nf_convenio_problema      = 'N'
  and id_titulo_convenio           = 'N'
  and id_titulo_crediario          = 'N'
  and id_titulo_conta_corrente     = 'N'
  and id_cheque                    = 'N'
  and id_outros					     = 'N'
  and id_transferencia_outro_caixa = 'S'
  and id_transferencia_caixa_geral = 'N';

Choose Case SqlCa.SqlCode
	Case 0
		Return lvl_Conta
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Conta fluxo de transfer$$HEX1$$ea00$$ENDHEX$$ncia para o caixa geral.", StopSign!, Ok!)
		Return -1		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da conta fluxo das vendas a vista." + SqlCa.SqlErrText, StopSign!, Ok!)
		gvo_aplicacao.of_grava_log("Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da conta fluxo das vendas a vista." + SqlCa.SqlErrText)
		Return -1
End Choose
end function

public function boolean of_caixa_geral (string ps_caixa);String lvs_Geral

Select id_caixa_geral Into :lvs_Geral
From caixa
Where cd_caixa = :ps_Caixa
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If lvs_Geral = "S" Then
			Return True
		Else
			Return False
		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Caixa '" + ps_Caixa + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
		Return False		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do caixa." + SqlCa.SqlErrText, StopSign!)
		gvo_aplicacao.of_grava_log("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do caixa." + SqlCa.SqlErrText)
		Return False
End Choose
end function

public function boolean of_caixa_aberto (string ps_caixa);Long lvl_Controle

Select nr_controle_caixa Into :lvl_Controle
From   controle_caixa
Where  cd_caixa = :ps_Caixa
  and  dh_fechamento_caixa is null;
  
Choose Case SqlCa.SqlCode
	Case 0
		Return True
	Case 100
		Return False
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do caixa aberto." + SqlCa.SqlErrText, StopSign!)
		Return False
End Choose
end function

public function string of_caixa_geral (long pl_filial);String lvs_Geral

Select cd_caixa Into :lvs_Geral
From caixa
Where cd_filial      = :pl_Filial
  and id_caixa_geral = 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return lvs_Geral
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Caixa geral n$$HEX1$$e300$$ENDHEX$$o localizado para a filial '" + String(pl_Filial) + "'.", StopSign!)
		Return ""
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do caixa geral." + SqlCa.SqlErrText, StopSign!)
		Return ""
End Choose
end function

public function boolean of_insere_lancamento_caixa (string ps_caixa, long pl_controle, long pl_conta_fluxo_caixa, datetime pdh_data_lancamento, decimal pdc_valor_lancamento, string ps_historico, string ps_recibo_cobranca);Long lvl_Lancamento

lvl_Lancamento = of_Proximo_Lancamento_Caixa(ps_Caixa, pl_Controle)

Insert Into lancamento_caixa (cd_caixa,   
							  nr_controle_caixa,   
							  nr_lancamento,   
							  cd_conta_fluxo_caixa,   
							  dh_lancamento,   
							  vl_lancamento,   
							  de_historico,   
							  nr_recibo_cobranca)  
Values(:ps_Caixa,   
       :pl_Controle,   
       :lvl_Lancamento,   
       :pl_Conta_Fluxo_Caixa,   
       :pdh_Data_Lancamento,   
       :pdc_Valor_Lancamento,   
       :ps_Historico,   
       :ps_Recibo_Cobranca);

If SqlCa.SqlCode = -1 Then
	Sqlca.of_RollBack()
	Sqlca.of_MsgDBError("Erro na inclus$$HEX1$$e300$$ENDHEX$$o do lan$$HEX1$$e700$$ENDHEX$$amento do caixa.")
	gvo_aplicacao.of_grava_log("Erro na inclus$$HEX1$$e300$$ENDHEX$$o do lan$$HEX1$$e700$$ENDHEX$$amento do caixa." + SqlCa.SqlErrText)
	Return False
Else
	Return True
End If
end function

public function boolean of_insere_lancamento_caixa (string ps_caixa, long pl_conta_fluxo_caixa, datetime pdh_data_lancamento, decimal pdc_valor_lancamento, string ps_historico, string ps_recibo_cobranca);Long lvl_Controle

lvl_Controle = of_Controle_Caixa_Aberto(ps_Caixa)

Return This.of_Insere_Lancamento_Caixa(ps_Caixa, &
												   lvl_Controle, &
												   pl_Conta_Fluxo_Caixa, &
												   pdh_Data_Lancamento, &
												   pdc_Valor_Lancamento, &
												   ps_Historico, &
												   ps_Recibo_Cobranca)

end function

public function boolean of_localiza_controle_caixa ();Return This.of_Localiza_Controle_Caixa(True)
end function

public function datetime of_data_parametro ();DateTime lvdh_Parametro

SetNull(lvdh_Parametro)

Select dh_movimentacao Into :lvdh_Parametro
From parametro 
Where id_parametro = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data de movimenta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o localizada nos par$$HEX1$$e200$$ENDHEX$$metros.", StopSign!)
	Case -1
		Sqlca.of_RollBack()	
		Sqlca.of_MsgDBError( "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da data de movimenta$$HEX2$$e700e300$$ENDHEX$$o nos par$$HEX1$$e200$$ENDHEX$$metros." )
		Sqlca.of_LogDBError(gvo_aplicacao.ivi_log,"Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da data de movimenta$$HEX2$$e700e300$$ENDHEX$$o nos par$$HEX1$$e200$$ENDHEX$$metros.")
End Choose

Return lvdh_Parametro
end function

public function boolean of_localiza_controle_caixa (string ps_caixa, long pl_controle);Select cc.cd_caixa,
       cc.nr_controle_caixa,
       cc.dh_abertura_caixa,
		 cc.dh_fechamento_caixa,
		 cc.dh_movimentacao_caixa, 
		 cc.vl_saldo_final,
		 cc.nr_matricula_operador,
		 us.nm_usuario,
		 cx.de_caixa
Into :This.Cd_Caixa,
     :This.Nr_Controle_Caixa,
     :This.Dh_Abertura_Caixa,
	  :This.Dh_Fechamento_Caixa,
	  :This.Dh_Movimentacao_Caixa,
	  :This.Vl_Saldo_Final,
	  :This.Nr_Matricula_Operador,
	  :This.Nm_Operador,
	  :This.De_Caixa
From controle_caixa cc,
	  usuario us,
	  caixa cx
Where cc.nr_matricula_operador = us.nr_matricula
  and cc.cd_caixa              = cx.cd_caixa
  and cc.cd_caixa          = :ps_Caixa
  and cc.nr_controle_caixa = :pl_Controle;
  
Choose Case SqlCa.SqlCode
	Case 0
		Return True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Controle do caixa n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
		Return False			
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do controle do caixa." + SqlCa.SqlErrText, StopSign!)
		gvo_aplicacao.of_grava_log("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do controle do caixa." + SqlCa.SqlErrText)
		Return False
End Choose
end function

public function integer of_tipo_recibo (string ps_nf_convenio_parcial, string ps_nf_convenio_problema, string ps_titulo_convenio, string ps_titulo_crediario, string ps_titulo_conta_corrente, string ps_cheque, string ps_outros, string ps_convenio_conta, string ps_conta_corrente_conta, string ps_juros, string ps_desconto);Integer lvi_Tipo_Recibo

Select cd_tipo_recibo Into :lvi_Tipo_Recibo
From tipo_recibo_cobranca
Where id_nf_convenio_parcial   = :ps_NF_Convenio_Parcial   
  and id_nf_convenio_problema  = :ps_NF_Convenio_Problema   
  and id_titulo_convenio       = :ps_Titulo_Convenio
  and id_titulo_crediario      = :ps_Titulo_Crediario    
  and id_titulo_conta_corrente = :ps_Titulo_Conta_Corrente   
  and id_cheque                = :ps_Cheque
  and id_outros					 = :ps_Outros
  and id_convenio_conta        = :ps_Convenio_Conta
  and id_conta_corrente_conta  = :ps_Conta_Corrente_Conta
  and id_juros_obtidos         = :ps_Juros
  and id_desconto_concedido    = :ps_Desconto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return lvi_Tipo_Recibo
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do recibo n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
		Return -1		
	Case -1
		Sqlca.of_RollBack()	
		Sqlca.of_MsgDBError( "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do tipo do recibo." )
		Sqlca.of_LogDBError( gvo_aplicacao.ivi_log,"Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do tipo do recibo." )
		Return -1
End Choose
end function

public function integer of_recibo_juros ();Return of_Tipo_Recibo("N", "N", "N", "N", "N", "N", "N", "N", "N", "S", "N")
end function

public function integer of_recibo_desconto ();Return of_Tipo_Recibo("N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "S")
end function

public function boolean of_localiza_controle_caixa (boolean ab_nao_conferidos);Return This.of_localiza_controle_caixa(gvo_parametro.of_filial(),ab_nao_conferidos)
end function

public function boolean of_caixa_finalizado (string ps_caixa, integer pl_controle);Boolean lvb_Finalizado = True

DateTime lvdh_Finalizado

Select dh_conferencia Into :lvdh_Finalizado
From controle_caixa
Where cd_caixa          = :ps_caixa
  and nr_controle_caixa = :pl_controle
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(lvdh_Finalizado) Then 
			lvb_Finalizado = False
		End If
	Case -1
		SqlCa.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do controle do caixa")
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Controle do caixa n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
End Choose

Return lvb_Finalizado
end function

public function boolean of_carrega_caixa ();Try
	uo_parametro_pdv lo_parametro_pdv
	lo_parametro_pdv = create uo_parametro_pdv
	This.ivs_Caixa_INI = lo_parametro_pdv.of_get_cd_caixa( )
	
Catch( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ) + '~ruo_controle_caixa.of_carrega_caixa( )', StopSign! )
Finally
	Destroy lo_parametro_pdv
End Try

If LeftA(ivs_Caixa_INI, 1) = "*" Then
	ivb_Caixa = False
	ivs_Caixa_INI = MidA(ivs_Caixa_INI, 2)
Else
	ivb_Caixa = True
End If

Return True
end function

public function boolean of_imprime_recibo_cheque (string ps_recibo_cobranca);SetPointer(HourGlass!)

STRING  lvs_extenso, lvs_extenso1, lvs_Texto, lvs_Pagto, lvs_Cliente, lvs_Banco, lvs_Nulo[]
LONG 	  lvl_linha, lvl_Ind
DECIMAL lvdc_valor_cheque, lvdc_valor_permanencia
INTEGER lvi_cd_tipo_recibo
BOOLEAN lvb_Impressao_Recibo

SetNull(This.is_texto_recibo)

This.idc_recibo = 000.00

/*DataStore lds_datastore

lds_datastore = Create DataStore

lds_datastore.DataObject = 'dw_emissao_recibo_cheque'

lds_datastore.SetTransObject(SqlCa)

lds_datastore.Retrieve(ps_recibo_cobranca)

lvl_Linha = lds_datastore.RowCount()

If lvl_linha <> 1 Then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na Verifica$$HEX2$$e700e300$$ENDHEX$$o dos dados para emiss$$HEX1$$e300$$ENDHEX$$o do recibo.", Information!, OK!)
	Return False
End If*/

dc_uo_ds_base lds_datastore
lds_datastore = Create dc_uo_ds_base

If Not lds_datastore.of_ChangeDataObject("dw_emissao_recibo_cheque") Then 
	Destroy(lds_datastore)
	Return False
End If

lvl_Linha = lds_datastore.Retrieve(ps_recibo_cobranca)

If lvl_Linha <> 1 Then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na Verifica$$HEX2$$e700e300$$ENDHEX$$o dos dados para emiss$$HEX1$$e300$$ENDHEX$$o do recibo." + &
									"Linhas: "+String(lvl_Linha) , Information!, OK!)
	Destroy(lds_datastore)
	Return False									
End If
//
This.idc_recibo    = lds_datastore.Object.recibo_cobranca_vl_recebido[lvl_linha]
lvdc_valor_Cheque  = lds_datastore.Object.recibo_cobranca_vl_cheque  [lvl_linha]
lvdc_valor_permanencia = lds_datastore.Object.recibo_cobranca_vl_juros[lvl_linha] + lds_datastore.Object.recibo_cobranca_vl_multa_recebida[lvl_linha]
//
lvs_extenso  = "(" + gf_extenso_valor(This.idc_recibo) + ")"
lvs_extenso1 = "(" + gf_extenso_valor(lvdc_valor_Cheque) + ")"
//
lvs_Pagto = "INTEGRAL"
//
IF MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Confirma impress$$HEX1$$e300$$ENDHEX$$o do Recibo ?",Question!,YesNo!,1) = 1 THEN
	//	
	lvs_Texto = ""
	//
	lvs_Cliente = lds_datastore.Object.recibo_cobranca_nm_cliente[lvl_Linha]
	lvs_Banco   = lds_datastore.Object.recibo_cobranca_de_banco  [lvl_Linha]
	//	
	IF IsNull(lvs_Cliente) THEN lvs_Cliente = ""
	IF IsNull(lvs_Banco)   THEN lvs_Banco   = ""
	//
	This.is_dados_recibo = lvs_Nulo
	//
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "NUMERO...........: " + lds_datastore.Object.recibo_cobranca_nr_recibo_cobranca[lvl_Linha]
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = space(50)
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "VALOR............:           " + RightA(SPACE(10) + String(lds_datastore.Object.recibo_cobranca_vl_nominal[lvl_Linha] ,'###,##0.00') ,10 )
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "DESCONTO.........:           " + RightA(SPACE(10) + String(lds_datastore.Object.recibo_cobranca_vl_desconto[lvl_Linha],'###,##0.00') ,10 )
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "TAXA PERMANENCIA.:           " + RightA(SPACE(10) + String(lvdc_valor_permanencia,'###,##0.00') ,10 )
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "VALOR RECIBO.....:           " + RightA(SPACE(10) + String(lds_datastore.Object.recibo_cobranca_vl_recebido[lvl_Linha],'###,##0.00') ,10 )
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = space(50)
	//
	IF ( lds_datastore.Object.recibo_cobranca_vl_cheque[lvl_Linha] <> lds_datastore.Object.recibo_cobranca_vl_nominal[lvl_Linha] ) THEN lvs_Pagto =  'PARCIAL'
	//
	lvs_Texto += "RECEBEMOS DE " + lvs_Cliente + " "
	lvs_Texto += "A QUANTIA DE " + lvs_extenso + " REFERENTE AO PAGAMENTO " + lvs_Pagto + " DO CHEQUE NUMERO " + lds_datastore.Object.recibo_cobranca_nr_cheque[lvl_Linha] + " "
	lvs_Texto += "DO BANCO "     + lvs_Banco + ", EMITIDO EM " + String(lds_datastore.Object.recibo_cobranca_dh_emissao[lvl_Linha],'dd/mm/yyyy') + " ,"
	lvs_Texto += "NO VALOR DE "  + lvs_extenso1 + "."
	//
	This.is_texto_recibo = lvs_Texto
	This.of_texto_recibo()
	//
	Destroy(lds_datastore)
	Return True
	//
End If
	
lds_datastore.Object.extenso [lvl_linha] = lvs_extenso
lds_datastore.Object.extenso1[lvl_linha] = lvs_extenso1

//lds_datastore.Print()

SetPointer(Arrow!)
Destroy(lds_datastore)

Return False
end function

public function boolean of_imprime_recibo_cv_cc_conta (string ps_recibo_cobranca, string ps_tipo_recibo);SetPointer(HourGlass!)

STRING  lvs_extenso, lvs_nr_titulo, lvs_Texto, lvs_Cliente, lvs_Nulo[]
LONG	  lvl_linha, lvl_ind
INTEGER lvi_cd_tipo_recibo
BOOLEAN lvb_Impressao_Recibo

SetNull(This.is_texto_recibo)

This.idc_recibo = 000.00

/*DataStore lds_datastore

lds_datastore = Create DataStore

lds_datastore.DataObject = "dw_emissao_recibo_cv_cc_conta"
	
lds_datastore.SetTransObject(SqlCa)

lds_datastore.Retrieve(ps_recibo_cobranca)

lvl_Linha = lds_datastore.RowCount()

If lvl_linha <> 1 Then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na Verifica$$HEX2$$e700e300$$ENDHEX$$o dos dados para emiss$$HEX1$$e300$$ENDHEX$$o do recibo.", Information!, OK!)
	Return False
End If*/

dc_uo_ds_base lds_datastore
lds_datastore = Create dc_uo_ds_base

If Not lds_datastore.of_ChangeDataObject("dw_emissao_recibo_cv_cc_conta") Then 
	Destroy(lds_datastore)
	Return False
End If

lvl_Linha = lds_datastore.Retrieve(ps_recibo_cobranca)

If lvl_Linha <> 1 Then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na Verifica$$HEX2$$e700e300$$ENDHEX$$o dos dados para emiss$$HEX1$$e300$$ENDHEX$$o do recibo." + &
									"Linhas: "+String(lvl_Linha) , Information!, OK!)
	Destroy(lds_datastore)
	Return False									
End If

This.idc_recibo = lds_datastore.Object.recibo_cobranca_vl_recebido[lvl_linha]

lvs_extenso = "( " + gf_extenso_valor(This.idc_recibo) + " )"

lds_datastore.Object.extenso[lvl_linha] = lvs_extenso

If ps_tipo_recibo = 'CC' Then
	lds_datastore.Object.complemento[lvl_linha] = 'parcial da conta do m$$HEX1$$ea00$$ENDHEX$$s corrente.'
Else
	lds_datastore.Object.complemento[lvl_linha] = 'do m$$HEX1$$ea00$$ENDHEX$$s corrente ' + lvs_nr_titulo + '.'
End If

IF MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Confirma impress$$HEX1$$e300$$ENDHEX$$o do Recibo ?",Question!,YesNo!,1) = 1 THEN
	//	
	lvs_Texto   = ""
	lvs_Cliente = lds_datastore.Object.recibo_cobranca_nm_cliente[lvl_Linha]
	//
	IF IsNull(lvs_Cliente) THEN lvs_Cliente = ""
	//
	This.is_dados_recibo = lvs_Nulo
	//
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "NUMERO...........: " + lds_datastore.Object.recibo_cobranca_nr_recibo_cobranca[lvl_Linha]
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = space(50)
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "VALOR............:           " + RightA(SPACE(10) + String(lds_datastore.Object.recibo_cobranca_vl_recebido[lvl_Linha] ,'###,##0.00') ,10 )
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = space(50)
	//
	lvs_Texto += "RECEBEMOS DE " + lvs_Cliente + " "
	lvs_Texto += "A QUANTIA DE " + lvs_extenso + " REFERENTE AO PAGAMENTO " + UPPER(lds_datastore.Object.complemento[lvl_Linha]) + " "
	//
	This.is_texto_recibo = lvs_Texto
	This.of_texto_recibo()
	//
	Destroy(lds_datastore)	
	Return True
	//
END IF

//lds_datastore.Print()
Destroy(lds_datastore)

RETURN False
end function

public function boolean of_imprime_recibo_nota (string ps_recibo_cobranca);SetPointer(HourGlass!)

STRING  lvs_extenso, lvs_Texto, lvs_Cliente, lvs_Convenio, lvs_Nulo[]
LONG 	  lvl_linha, lvl_Ind
INTEGER lvi_cd_tipo_recibo
BOOLEAN lvb_Impressao_Recibo

SetNull(This.is_texto_recibo)

This.idc_recibo = 000.00

/*DataStore lds_datastore

lds_datastore = Create DataStore

// Imprime recibo tipo nota fiscal	   	
lds_datastore.DataObject = 'dw_emissao_recibo_nota'

lds_datastore.SetTransObject(SqlCa)

lds_datastore.Retrieve(ps_recibo_cobranca)

lvl_Linha = lds_datastore.RowCount()

If lvl_linha <> 1 Then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na Verifica$$HEX2$$e700e300$$ENDHEX$$o dos dados para emiss$$HEX1$$e300$$ENDHEX$$o do recibo.", Information!, OK!)
	Return False
End If*/

dc_uo_ds_base lds_datastore
lds_datastore = Create dc_uo_ds_base

If Not lds_datastore.of_ChangeDataObject("dw_emissao_recibo_nota") Then 
	Destroy(lds_datastore)
	Return False
End If

lvl_Linha = lds_datastore.Retrieve(ps_recibo_cobranca)

If lvl_Linha <> 1 Then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na Verifica$$HEX2$$e700e300$$ENDHEX$$o dos dados para emiss$$HEX1$$e300$$ENDHEX$$o do recibo." + &
									"Linhas: "+String(lvl_Linha) , Information!, OK!)
	Destroy(lds_datastore)
	Return False									
End If

This.idc_recibo = lds_datastore.Object.recibo_cobranca_vl_recebido[lvl_linha]

lvs_extenso = "( " + gf_extenso_valor(This.idc_recibo) + " )"

lds_datastore.Object.extenso[lvl_linha] = lvs_extenso

IF MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Confirma impress$$HEX1$$e300$$ENDHEX$$o do Recibo ?",Question!,YesNo!,1) = 1 THEN
	//	
	lvs_Texto = ""
	lvs_Cliente  = lds_datastore.Object.recibo_cobranca_nm_cliente[lvl_Linha]
	lvs_Convenio = Trim(lds_datastore.Object.convenio_nm_fantasia[lvl_Linha]) + ' (' +  String(lds_datastore.Object.convenio_cd_convenio[lvl_Linha]) + ').'
	//
	IF IsNull(lvs_Cliente)  THEN lvs_Cliente = ""
	IF IsNull(lvs_Convenio) THEN lvs_Convenio = ""
	//
	This.is_dados_recibo = lvs_Nulo
	//
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "NUMERO...........: " + lds_datastore.Object.recibo_cobranca_nr_recibo_cobranca[lvl_Linha]
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = space(50)
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "VALOR............:           " + RightA(SPACE(10) + String(lds_datastore.Object.recibo_cobranca_vl_recebido[lvl_Linha] ,'###,##0.00') ,10 )
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = space(50)
	//
	lvs_Texto += "RECEBEMOS DE " + lvs_Cliente + " "
	lvs_Texto += "A QUANTIA DE " + lvs_extenso + " REFERENTE AO PAGAMENTO DA NOTA FISCAL NUMERO " + String(lds_datastore.Object.nf_venda_nr_nf[lvl_Linha]) + " "
	lvs_Texto += "EMITIDA EM " + String(lds_datastore.Object.nf_venda_dh_emissao[lvl_Linha],'dd/mm/yyyy') + " "
	lvs_Texto += "DO CONVENIO " + lvs_Convenio
	//	
	This.is_texto_recibo = lvs_Texto
	This.of_texto_recibo()
	//
	Destroy(lds_datastore)	
	Return True
	//
END IF

//lds_datastore.Print()
Destroy(lds_datastore)

Return False
end function

public function boolean of_imprime_recibo_outros (string ps_recibo_cobranca);SetPointer(HourGlass!)
//
STRING  lvs_extenso, lvs_Texto, lvs_Cliente, lvs_Obs, lvs_Nulo[], lvs_vale
LONG	  lvl_linha, lvl_Ind
INTEGER lvi_cd_tipo_recibo
BOOLEAN lvb_Impressao_Recibo

SetNull(This.is_texto_recibo)

This.is_dados_recibo = lvs_nulo

This.idc_recibo = 000.00

dc_uo_ds_base lds_datastore
lds_datastore = Create dc_uo_ds_base

If Not lds_datastore.of_ChangeDataObject("dw_emissao_recibo_outros") Then 
	Destroy(lds_datastore)
	Return False
End If

lvl_Linha = lds_datastore.Retrieve(ps_recibo_cobranca)

If lvl_Linha <> 1 Then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na Verifica$$HEX2$$e700e300$$ENDHEX$$o dos dados para emiss$$HEX1$$e300$$ENDHEX$$o do recibo." + &
									"Linhas: "+String(lvl_Linha) , Information!, OK!)
	Destroy(lds_datastore)
	Return False									
End If

This.idc_recibo = lds_datastore.Object.recibo_cobranca_vl_recebido[lvl_linha]

If IsNull(lds_datastore.Object.recibo_cobranca_nr_titulo[lvl_Linha]) Then
	lvs_vale = ''
Else
	lvs_vale = lds_datastore.Object.recibo_cobranca_nr_titulo[lvl_Linha]
End If

lvs_extenso = "( " + gf_extenso_valor(This.idc_recibo) + " )"

lds_datastore.Object.extenso[lvl_linha] = lvs_extenso

IF MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Confirma impress$$HEX1$$e300$$ENDHEX$$o do recibo de cobran$$HEX1$$e700$$ENDHEX$$a '" + ps_Recibo_Cobranca + "' ?",Question!,YesNo!,1) = 1 THEN
	If lvs_Vale <> 'VALECAIXA' Then
		//	
		lvs_Texto = ""
		lvs_Cliente = lds_datastore.Object.recibo_cobranca_nm_cliente[lvl_Linha]
		lvs_Obs     = lds_datastore.Object.recibo_cobranca_de_observacao[lvl_Linha]
		//
		IF IsNull(lvs_Cliente) THEN lvs_Cliente = ""
		IF IsNull(lvs_Obs)     THEN lvs_Obs = ""
		//
		This.is_dados_recibo = lvs_Nulo
		//
		lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "NUMERO...........: " + lds_datastore.Object.recibo_cobranca_nr_recibo_cobranca[lvl_Linha]
		lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = space(50)
		lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "VALOR............:           " + RightA(SPACE(10) + String(lds_datastore.Object.recibo_cobranca_vl_recebido[lvl_Linha] ,'###,##0.00') ,10 )
		lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = space(50)
		//
		lvs_Texto += "RECEBEMOS DE " + lvs_Cliente + " "
		lvs_Texto += "A QUANTIA DE " + lvs_extenso + " REFERENTE A " + lvs_Obs + "."
		//
		This.is_texto_recibo = lvs_Texto
		This.of_texto_recibo()	
		//
	Else
		String ls_texto, ls_texto2, ls_texto3

		lvs_Cliente = lds_datastore.Object.recibo_cobranca_nm_cliente[lvl_Linha]
		lvs_Obs     = lds_datastore.Object.recibo_cobranca_de_observacao[lvl_Linha]
	
		lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = Space(48)
		lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = Space(20) + "VALE CAIXA"			
		lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = Space(48)
		
		ls_texto = "Colaborador: " + lvs_Cliente
		If LenA(ls_texto) > 48 Then			
			ls_texto2 = ls_texto
			Do While ls_Texto2 > ''
				ls_texto3 = LeftA(ls_texto2,48)
				
				lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = ls_texto3
				
				ls_texto2 = MidA(ls_texto2, 49)
			Loop
		Else
			lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = ls_texto
		End If		
			
		lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "       Data: " + String(lds_datastore.Object.recibo_cobranca_dh_emissao[lvl_linha],'dd/mm/yyyy')
		lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "     Filial: "  + String(gvo_Parametro.Cd_Filial) + " - " + gvo_Parametro.nm_Fantasia_Filial
		lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "     Motivo: " + lvs_Obs
		lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = Space(48)		
		
		ls_texto = "Valor: R$( " +  String(lds_datastore.Object.recibo_cobranca_vl_recebido[lvl_Linha] ,'###,##0.00') + " ) " + lvs_extenso
		If LenA(ls_texto) > 48 Then			
			ls_texto2 = ls_texto
			Do While ls_Texto2 > ''
				ls_texto3 = LeftA(ls_texto2,48)
				
				lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = ls_texto3
				
				ls_texto2 = MidA(ls_texto2, 49)
			Loop
		Else
			lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = ls_texto
		End If		
		
		lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = Space(48)
		lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "* Autorizo o Desconto em Folha de Pagamento"
		lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = Space(48)	
		lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = Space(48)
		lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "Ass.: " + FillA("_", 42)
		
		ls_texto = MidA(lvs_Cliente, PosA(lvs_Cliente,'- ') + 2)
		If LenA(ls_texto) > 48 Then			
			ls_texto2 = ls_texto
			Do While ls_Texto2 > ''
				ls_texto3 = LeftA(ls_texto2,48)
				
				lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = ls_texto3
				
				ls_texto2 = MidA(ls_texto2, 49)
			Loop
		Else
			lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = ls_texto
		End If				
	End If
	Destroy(lds_datastore)	
	Return True
	//
END IF

//lds_datastore.Print()

SetPointer(Arrow!)
Destroy(lds_datastore)

Return False
end function

public function boolean of_imprime_recibo_titulo_cc_cr (string ps_recibo_cobranca);SetPointer(HourGlass!)

STRING  lvs_extenso, lvs_extenso1, lvs_Texto, lvs_Nulo[], lvs_Pagto, lvs_Valor, lvs_Complemento, lvs_Juros
STRING  lvs_Cliente
LONG 	  lvl_linha, lvl_Ind
DECIMAL lvdc_valor_titulo, lvdc_valor_permanencia
INTEGER lvi_cd_tipo_recibo

SetNull(This.is_texto_recibo)

This.idc_recibo = 000.00

lvs_Pagto = ", INTEGRAL"

/*DataStore lds_datastore

lds_datastore = Create DataStore
	
// Recibo tipo T$$HEX1$$ed00$$ENDHEX$$tulo Credi$$HEX1$$e100$$ENDHEX$$rio / Conta-Corrente
lds_datastore.DataObject = 'dw_emissao_recibo_titulo_cc_cr'
	
lds_datastore.SetTransObject(SqlCa)

lds_datastore.Retrieve(ps_recibo_cobranca)

lvl_Linha = lds_datastore.RowCount()

If lvl_linha <> 1 Then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na Verifica$$HEX2$$e700e300$$ENDHEX$$o dos dados para emiss$$HEX1$$e300$$ENDHEX$$o do recibo.", Information!, OK!)
	Return False
End If*/

dc_uo_ds_base lds_datastore
lds_datastore = Create dc_uo_ds_base

If Not lds_datastore.of_ChangeDataObject("dw_emissao_recibo_titulo_cc_cr") Then 
	Destroy(lds_datastore)
	Return False
End If

lvl_Linha = lds_datastore.Retrieve(ps_recibo_cobranca)

If lvl_Linha <> 1 Then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na Verifica$$HEX2$$e700e300$$ENDHEX$$o dos dados para emiss$$HEX1$$e300$$ENDHEX$$o do recibo." + &
									"Linhas: "+String(lvl_Linha) , Information!, OK!)
	Destroy(lds_datastore)
	Return False									
End If

This.idc_recibo   = lds_datastore.Object.recibo_cobranca_vl_recebido[lvl_linha]
lvdc_valor_titulo = lds_datastore.Object.titulo_receber_vl_nominal  [lvl_linha]
lvdc_valor_permanencia = lds_datastore.Object.recibo_cobranca_vl_juros[lvl_linha] + lds_datastore.Object.recibo_cobranca_vl_multa_recebida[lvl_linha]

lvs_extenso  = "(" + gf_extenso_valor(This.idc_recibo) + ")"
lvs_extenso1 = "(" + gf_extenso_valor(lvdc_valor_titulo) + ")"

lds_datastore.Object.extenso [lvl_linha] = lvs_extenso
lds_datastore.Object.extenso1[lvl_linha] = lvs_extenso1

IF MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Confirma impress$$HEX1$$e300$$ENDHEX$$o do Recibo ?",Question!,YesNo!,1) = 1 THEN
	//	
	lvs_Texto   = ""
	lvs_Cliente = lds_datastore.Object.nome_cliente[lvl_Linha]
	//
	IF IsNull(lvs_Cliente) THEN lvs_Cliente = ""
	//
	This.is_dados_recibo = lvs_Nulo
	//
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "NUMERO...........: " + lds_datastore.Object.recibo_cobranca_nr_recibo_cobranca[lvl_Linha]
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = space(50)
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "VALOR............:           " + RightA(SPACE(10) + String(lds_datastore.Object.recibo_cobranca_vl_nominal[1] ,'###,##0.00') ,10 )
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "DESCONTO.........:           " + RightA(SPACE(10) + String(lds_datastore.Object.recibo_cobranca_vl_desconto[1],'###,##0.00') ,10 )
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "TAXA PERMANENCIA.:           " + RightA(SPACE(10) + String(lvdc_valor_permanencia,'###,##0.00') ,10 )
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "VALOR RECIBO.....:           " + RightA(SPACE(10) + String(lds_datastore.Object.recibo_cobranca_vl_recebido[1],'###,##0.00') ,10 )
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = space(50)
	//
	lvs_Valor = ""
	lvs_Juros = "."
	lvs_Complemento = ""
	//
	IF ( lds_datastore.Object.titulo_receber_vl_nominal[1] <> lds_datastore.Object.recibo_cobranca_vl_nominal[1] ) THEN 
		 lvs_Pagto = ", PARCIAL"
		 lvs_Valor = " NO VALOR DE "
		 lvs_Complemento = lvs_extenso1
	END IF	 
	//
	IF lds_datastore.Object.recibo_cobranca_vl_juros[lvl_Linha] > 0  THEN
		lvs_Juros = ", MAIS JUROS E VARIACAO MONETARIA PELO ATRASO."
	END IF	
	//
	lvs_Texto += "RECEBEMOS DE " + lvs_Cliente + " "
	lvs_Texto += "A QUANTIA DE " + lvs_extenso + " REFERENTE AO PAGAMENTO " + lvs_Pagto + " DO TITULO NUMERO " + lds_datastore.Object.titulo_receber_nr_titulo[lvl_Linha] + " "
	lvs_Texto += "EMITIDO EM : " +  String(lds_datastore.Object.titulo_receber_dh_emissao[lvl_linha],'dd/mm/yyyy') + ", COM VENCIMENTO EM " + String(lds_datastore.Object.titulo_receber_dh_vencimento[lvl_Linha] ,'dd/mm/yyyy') + " "
	lvs_Texto += lvs_Valor + lvs_Complemento + lvs_Juros
	//
	This.is_texto_recibo = lvs_Texto
	This.of_texto_recibo()	
	//
	Destroy(lds_datastore)
	Return True
	//
End If

//lds_datastore.Print()

SetPointer(Arrow!)
Destroy(lds_datastore)

Return False
end function

public function boolean of_imprime_recibo_titulo_cv (string ps_recibo_cobranca);SetPointer(HourGlass!)

STRING  lvs_extenso, lvs_extenso1, lvs_Texto, lvs_Nulo[], lvs_Juros, lvs_Valor, lvs_Pagto
STRING  lvs_Convenio
LONG 	  lvl_linha, lvl_Ind
DECIMAL lvdc_valor_titulo, lvdc_valor_permanencia
INTEGER lvi_cd_tipo_recibo
BOOLEAN lvb_Impressao_Recibo

SetNull(This.is_texto_recibo)

This.idc_recibo = 000.00

/*DataStore lds_datastore

lds_datastore = Create DataStore

// Recibo tipo T$$HEX1$$ed00$$ENDHEX$$tulo Conv$$HEX1$$ea00$$ENDHEX$$nio
lds_datastore.DataObject = 'dw_emissao_recibo_titulo_conv'
	
lds_datastore.SetTransObject(SqlCa)

lds_datastore.Retrieve(ps_recibo_cobranca)

lvl_Linha = lds_datastore.RowCount()

If lvl_linha <> 1 Then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na Verifica$$HEX2$$e700e300$$ENDHEX$$o dos dados para emiss$$HEX1$$e300$$ENDHEX$$o do recibo.", Information!, OK!)
	Return False
End If*/

dc_uo_ds_base lds_datastore
lds_datastore = Create dc_uo_ds_base

If Not lds_datastore.of_ChangeDataObject("dw_emissao_recibo_titulo_conv") Then 
	Destroy(lds_datastore)
	Return False
End If

lvl_Linha = lds_datastore.Retrieve(ps_recibo_cobranca)

If lvl_Linha <> 1 Then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na Verifica$$HEX2$$e700e300$$ENDHEX$$o dos dados para emiss$$HEX1$$e300$$ENDHEX$$o do recibo." + &
									"Linhas: "+String(lvl_Linha) , Information!, OK!)
	Destroy(lds_datastore)
	Return False									
End If

This.idc_recibo   = lds_datastore.Object.recibo_cobranca_vl_recebido[lvl_linha]
lvdc_valor_titulo = lds_datastore.Object.titulo_receber_vl_nominal[lvl_linha]
lvdc_valor_permanencia = lds_datastore.Object.recibo_cobranca_vl_juros[lvl_linha] + lds_datastore.Object.recibo_cobranca_vl_multa_recebida[lvl_linha]

lvs_extenso  = "(" + gf_extenso_valor(This.idc_recibo) + ")"
lvs_extenso1 = "(" + gf_extenso_valor(lvdc_valor_titulo) + ")"

lds_datastore.Object.extenso [lvl_linha]  = lvs_extenso
lds_datastore.Object.extenso1[lvl_linha] = lvs_extenso1

IF MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Confirma impress$$HEX1$$e300$$ENDHEX$$o do Recibo ?",Question!,YesNo!,1) = 1 THEN
	//
	lvs_Texto = ""
	lvs_Convenio = Trim(lds_datastore.Object.convenio_nm_fantasia[lvl_Linha]) + ' (' +  String(lds_datastore.Object.convenio_cd_convenio[lvl_Linha]) + ')' + " "
	//
	IF IsNull(lvs_Convenio) THEN lvs_Convenio = ""
	//
	This.is_dados_recibo = lvs_Nulo
	//
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "NUMERO...........: " + lds_datastore.Object.recibo_cobranca_nr_recibo_cobranca[lvl_Linha]
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = space(50)
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "VALOR............:           " + RightA(SPACE(10) + String(lds_datastore.Object.recibo_cobranca_vl_nominal[1] ,'###,##0.00') ,10 )
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "DESCONTO.........:           " + RightA(SPACE(10) + String(lds_datastore.Object.recibo_cobranca_vl_desconto[1],'###,##0.00') ,10 )
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "TAXA PERMANENCIA.:           " + RightA(SPACE(10) + String(lvdc_valor_permanencia,'###,##0.00') ,10 )
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = "VALOR RECIBO.....:           " + RightA(SPACE(10) + String(lds_datastore.Object.recibo_cobranca_vl_recebido[1],'###,##0.00') ,10 )
	lvl_ind ++ ; This.is_dados_recibo[lvl_ind] = space(50)
	//
	lvs_Pagto = "INTEGRAL "
	lvs_Valor = ""	
	lvs_Juros = "."
	//
	IF ( lds_datastore.Object.titulo_receber_vl_nominal[1] <> lds_datastore.Object.recibo_cobranca_vl_nominal[1] ) THEN 
		 lvs_Pagto = ", PARCIAL"
		 lvs_Valor = " NO VALOR DE " + lvs_extenso1
	 End If
	//
	IF lds_datastore.Object.recibo_cobranca_vl_juros[lvl_Linha] > 0  THEN
		lvs_Juros = ", MAIS JUROS E VARIACAO MONETARIA PELO ATRASO."
	END IF
	//
	lvs_Texto += "RECEBEMOS DA " + lvs_Convenio
	lvs_Texto += "A QUANTIA DE " + lvs_extenso + " REFERENTE AO PAGAMENTO " + lvs_Pagto + "DO TITULO NUMERO " + lds_datastore.Object.titulo_receber_nr_titulo[lvl_Linha] + " "
	lvs_Texto += "EMITIDO EM "   + String(lds_datastore.Object.titulo_receber_dh_emissao[lvl_Linha] ,'dd/mm/yyyy') + ", COM VENCIMENTO EM " + String(lds_datastore.Object.titulo_receber_dh_vencimento[lvl_Linha] ,'dd/mm/yyyy')
	lvs_Texto += lvs_Valor + lvs_Juros
	//
	This.is_texto_recibo = lvs_Texto
	This.of_texto_recibo()	
	//
	Destroy(lds_datastore)
	Return True
	//
END IF

//lds_datastore.Print()

SetPointer(Arrow!)
Destroy(lds_datastore)

Return False
end function

public subroutine of_texto_recibo ();Long lvl_Ind,&
     lvl_Pos,&
	 lvl_Tamanho
	 
String lvs_Texto	 

lvl_Pos = 1

lvl_Ind = UpperBound(This.is_dados_recibo)

lvl_Tamanho = LenA(This.is_texto_recibo)

Do While True
	
	lvs_Texto = MidA(This.is_texto_recibo,lvl_Pos,50)

	lvl_Ind ++
	This.is_dados_recibo[lvl_ind] = lvs_Texto
	
	lvl_Pos = lvl_Pos + 50
	
	If Not lvl_Tamanho - ( lvl_Pos + 1 ) > 0 Then Exit
	
Loop
end subroutine

public function boolean of_insere_lancamento_caixa (string ps_caixa, long pl_controle, long pl_conta_fluxo_caixa, datetime pdh_data_lancamento, decimal pdc_valor_lancamento, string ps_historico, string ps_recibo_cobranca, string ps_estorno);Long 		lvl_Lancamento
String 	lvs_Estorno

If Trim(Upper(ps_Estorno)) = 'S' Then
	lvs_Estorno = 'S'
Else
	SetNull(lvs_Estorno)
End If

lvl_Lancamento = of_Proximo_Lancamento_Caixa(ps_Caixa, pl_Controle)

Insert Into lancamento_caixa (cd_caixa,   
							  nr_controle_caixa,   
							  nr_lancamento,   
							  cd_conta_fluxo_caixa,   
							  dh_lancamento,   
							  vl_lancamento,   
							  de_historico,   
							  nr_recibo_cobranca,
							  id_estorno)  
Values(:ps_Caixa,   
       :pl_Controle,   
       :lvl_Lancamento,   
       :pl_Conta_Fluxo_Caixa,   
       :pdh_Data_Lancamento,   
       :pdc_Valor_Lancamento,   
       :ps_Historico,   
       :ps_Recibo_Cobranca,
	   :lvs_Estorno);

If SqlCa.SqlCode = -1 Then
	Sqlca.of_RollBack()	
	Sqlca.of_MsgDBError( "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do lan$$HEX1$$e700$$ENDHEX$$amento do caixa." )
	Sqlca.of_LogDBError(gvo_aplicacao.ivi_log,"Erro na inclus$$HEX1$$e300$$ENDHEX$$o do lan$$HEX1$$e700$$ENDHEX$$amento do caixa.")
	Return False
Else
	Return True
End If
end function

public function boolean of_localiza_controle_caixa (long pl_filial, boolean pb_nao_conferidos);String lvs_Parametro, &
       lvs_Retorno, &
       lvs_Caixa
		 
Long lvl_Controle

If pb_nao_conferidos Then
	lvs_Parametro = "S"
Else
	lvs_Parametro = "N"
End If

If IsNull(pl_filial) Then pl_filial = gvo_parametro.of_filial()

lvs_Parametro += ';'+String(pl_filial)

OpenWithParm(w_ge020_Selecao_Controle_Caixa, lvs_Parametro)

lvs_Retorno = Message.StringParm

If Not IsNull(lvs_Retorno) Then
	lvs_Caixa    = LeftA(lvs_Retorno, 6)
	lvl_Controle = Long(MidA(lvs_Retorno, 7))

	Return This.of_Localiza_Controle_Caixa(lvs_Caixa, lvl_Controle)
Else
	Return False
End If
end function

public function string of_insere_recibo_titulo_convenio (long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, string ps_titulo, string ps_caixa, string ps_forma_pagamento, decimal pdc_valor_multa);Boolean lvb_Sucesso

Integer lvi_Tipo_Recibo

Date lvdt_Cheque

Decimal lvdc_Cheque

Long lvl_Conta_Fluxo_Caixa, &
     lvl_Controle_Caixa

String lvs_Cheque, &
		 lvs_Banco, &
		 lvs_Especie, &
		 lvs_Serie, &
		 lvs_Observacao, &
		 lvs_Recibo, &
		 lvs_Cliente, &
		 lvs_Historico, &
		 lvs_hist_forma_pgto											
		 
Long lvl_Filial_Venda, &
     lvl_NF

SetNull(lvs_Cheque)
SetNull(lvs_Banco)
SetNull(lvs_Especie)
SetNull(lvs_Serie)
SetNull(lvs_Observacao)
SetNull(lvl_Filial_Venda)
SetNull(lvl_NF)
SetNull(lvdt_Cheque)
SetNull(lvdc_Cheque)
SetNull(lvs_Cliente)

lvi_Tipo_Recibo = This.of_Recibo_Titulo_Convenio()

lvs_Recibo = This.of_Numero_Recibo(pl_Filial)

lvb_Sucesso = This.of_Insere_Recibo_Cobranca(lvs_recibo , & 
														   pl_Filial,          &
														   pdh_Data_Emissao,   &
														   pdc_Valor_Nominal,  &
														   pdc_Valor_Juros,    &
														   pdc_Valor_Desconto, &  
														   pdc_Valor_Recebido, & 
														   ps_Responsavel,     &
														   lvi_Tipo_Recibo,    &
														   ps_Titulo,          &
														   lvs_Cliente,        &  
														   lvs_Cheque,         &
														   lvs_Banco,          &
														   lvl_Filial_Venda,   &
														   lvl_NF,             &
														   lvs_Especie,        &
														   lvs_Serie,          &
														   lvs_Observacao,     &
														   lvdt_Cheque,        &
														   lvdc_Cheque,  &
														   pdc_valor_multa, &
														   ps_forma_pagamento)
													 
If lvb_Sucesso Then
	lvs_Historico = "T$$HEX1$$cd00$$ENDHEX$$TULO : " + LeftA(ps_Titulo, 4)   + "-" + &
	                              MidA(ps_Titulo, 5, 7) + "-" + &
										   RightA(ps_Titulo, 2)											
	Choose Case ps_forma_pagamento
		Case 'DI'			
			lvs_hist_forma_pgto = '(DH)'
		Case 'CA'
			lvs_hist_forma_pgto = '(DEB)'
		Case 'HA'
			lvs_hist_forma_pgto = '(CHQ)'
		Case Else
			lvs_hist_forma_pgto = ''
	End Choose			
	lvs_Historico += " " + lvs_hist_forma_pgto
	
	// Lan$$HEX1$$e700$$ENDHEX$$amento do Valor Nominal
	lvl_Conta_Fluxo_Caixa = This.of_Conta_Fluxo_Caixa_Recibo(lvi_Tipo_Recibo)

	lvb_Sucesso = This.of_Insere_Lancamento_Caixa(ps_Caixa, &
															    lvl_Conta_Fluxo_Caixa, &   
															    pdh_Data_Emissao, &
															    pdc_Valor_Nominal, &
															    lvs_Historico, &
															    lvs_Recibo)	

	// Lan$$HEX1$$e700$$ENDHEX$$amento de Juros Obtidos
	If lvb_Sucesso Then
		If pdc_Valor_Juros > 0 Or pdc_valor_multa > 0 Then
			lvi_Tipo_Recibo       = This.of_Recibo_Juros()
			lvl_Conta_Fluxo_Caixa = This.of_Conta_Fluxo_Caixa_Recibo(lvi_Tipo_Recibo)
			
			lvb_Sucesso = This.of_Insere_Lancamento_Caixa(ps_Caixa, &
																       lvl_Conta_Fluxo_Caixa, &   
																       pdh_Data_Emissao, &
																       pdc_Valor_Juros + pdc_valor_multa, &
																       lvs_Historico, &
																       lvs_Recibo)	
		End If
	End If

	// Lan$$HEX1$$e700$$ENDHEX$$amento de Desconto Concedido
	If lvb_Sucesso Then
		If pdc_Valor_Desconto > 0 Then
			lvi_Tipo_Recibo       = This.of_Recibo_Desconto()
			lvl_Conta_Fluxo_Caixa = This.of_Conta_Fluxo_Caixa_Recibo(lvi_Tipo_Recibo)
			
			lvb_Sucesso = This.of_Insere_Lancamento_Caixa(ps_Caixa, &
																       lvl_Conta_Fluxo_Caixa, &   
																       pdh_Data_Emissao, &
																       pdc_Valor_Desconto, &
																       lvs_Historico, &
																       lvs_Recibo)	
		End If
	End If
End If

If Not lvb_Sucesso Then lvs_Recibo = ""

Return lvs_recibo
end function

public function string of_insere_recibo_titulo_conta_corrente (long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, string ps_titulo, string ps_caixa, string ps_forma_pagamento, decimal pdc_valor_multa);Boolean lvb_Sucesso

Integer lvi_Tipo_Recibo

Date lvdt_Cheque

Decimal lvdc_Cheque

Long lvl_Conta_Fluxo_Caixa, &
     lvl_Controle_Caixa, &
     lvl_Filial_Venda, &
     lvl_NF

String lvs_Cheque, &
		 lvs_Banco, &
		 lvs_Especie, &
		 lvs_Serie, &
		 lvs_Observacao, &
		 lvs_Recibo, &
		 lvs_Cliente, &
		 lvs_Historico, &
		 lvs_hist_forma_pgto

SetNull(lvs_Cheque)
SetNull(lvs_Banco)
SetNull(lvs_Especie)
SetNull(lvs_Serie)
SetNull(lvs_Observacao)
SetNull(lvl_Filial_Venda)
SetNull(lvl_NF)
SetNull(lvdt_Cheque)
SetNull(lvdc_Cheque)
SetNull(lvs_Cliente)

lvs_Recibo = This.of_Numero_Recibo(pl_Filial)

lvi_Tipo_Recibo = This.of_Recibo_Titulo_Conta_Corrente()

lvb_Sucesso = This.of_Insere_Recibo_Cobranca(lvs_recibo, & 
													 pl_Filial,          &
													 pdh_Data_Emissao,   &
													 pdc_Valor_Nominal,  &
													 pdc_Valor_Juros,    &
													 pdc_Valor_Desconto, &  
													 pdc_Valor_Recebido, & 
													 ps_Responsavel,     &
													 lvi_Tipo_Recibo,    &
													 ps_Titulo,          &
													 lvs_Cliente,        &  
													 lvs_Cheque,         &
													 lvs_Banco,          &
													 lvl_Filial_Venda,   &
													 lvl_NF,             &
													 lvs_Especie,        &
													 lvs_Serie,          &
													 lvs_Observacao,     &
													 lvdt_Cheque,        &
													 lvdc_Cheque, 	&
													 pdc_valor_multa, &
													 ps_forma_pagamento)
													 
If lvb_Sucesso Then
	lvs_Historico = "T$$HEX1$$cd00$$ENDHEX$$TULO : " + LeftA(ps_Titulo, 4)   + "-" + &
	                              MidA(ps_Titulo, 5, 7) + "-" + &
										   RightA(ps_Titulo, 2)
	Choose Case ps_forma_pagamento
		Case 'DI'			
			lvs_hist_forma_pgto = '(DH)'
		Case 'CA'
			lvs_hist_forma_pgto = '(DEB)'
		Case 'HA'
			lvs_hist_forma_pgto = '(CHQ)'
		Case Else
			lvs_hist_forma_pgto = ''
	End Choose			
	lvs_Historico += " " + lvs_hist_forma_pgto
	
	// Lan$$HEX1$$e700$$ENDHEX$$amento do Valor Nominal
	lvl_Conta_Fluxo_Caixa = This.of_Conta_Fluxo_Caixa_Recibo(lvi_Tipo_Recibo)
	
	lvb_Sucesso = This.of_Insere_Lancamento_Caixa(ps_Caixa, &
															    lvl_Conta_Fluxo_Caixa, &   
															    pdh_Data_Emissao, &
															    pdc_Valor_Nominal, &
															    lvs_Historico, &
															    lvs_Recibo)	
														  
	// Lan$$HEX1$$e700$$ENDHEX$$amento de Juros Obtidos
	If lvb_Sucesso Then
		If pdc_Valor_Juros > 0 Or pdc_valor_multa > 0 Then
			lvi_Tipo_Recibo       = This.of_Recibo_Juros()
			lvl_Conta_Fluxo_Caixa = This.of_Conta_Fluxo_Caixa_Recibo(lvi_Tipo_Recibo)
			
			lvb_Sucesso = This.of_Insere_Lancamento_Caixa(ps_Caixa, &
																       lvl_Conta_Fluxo_Caixa, &   
																       pdh_Data_Emissao, &
																       pdc_Valor_Juros + pdc_valor_multa, &
																       lvs_Historico, &
																       lvs_Recibo)	
		End If
	End If

	// Lan$$HEX1$$e700$$ENDHEX$$amento de Desconto Concedido
	If lvb_Sucesso Then
		If pdc_Valor_Desconto > 0 Then
			lvi_Tipo_Recibo       = This.of_Recibo_Desconto()
			lvl_Conta_Fluxo_Caixa = This.of_Conta_Fluxo_Caixa_Recibo(lvi_Tipo_Recibo)
			
			lvb_Sucesso = This.of_Insere_Lancamento_Caixa(ps_Caixa, &
																       lvl_Conta_Fluxo_Caixa, &   
																       pdh_Data_Emissao, &
																       pdc_Valor_Desconto, &
																       lvs_Historico, &
																       lvs_Recibo)	
		End If
	End If
End If

If Not lvb_Sucesso Then lvs_Recibo = ""

Return lvs_recibo
end function

public function boolean of_insere_lancamento_caixa (string ps_caixa, long pl_controle, long pl_conta_fluxo_caixa, datetime pdh_data_lancamento, decimal pdc_valor_lancamento, string ps_historico, string ps_recibo_cobranca, string ps_estorno, string ps_nr_documento);Long 		lvl_Lancamento
String 	lvs_Estorno

If Trim(Upper(ps_Estorno)) = 'S' Then
	lvs_Estorno = 'S'
Else
	SetNull(lvs_Estorno)
End If

If Trim( ps_nr_documento ) = '' Then SetNull( ps_nr_documento )

lvl_Lancamento = of_Proximo_Lancamento_Caixa(ps_Caixa, pl_Controle)

Insert Into lancamento_caixa (cd_caixa,   
							  nr_controle_caixa,   
							  nr_lancamento,   
							  cd_conta_fluxo_caixa,   
							  dh_lancamento,   
							  vl_lancamento,   
							  de_historico,   
							  nr_recibo_cobranca,
							  id_estorno,
							  nr_documento)  
Values(:ps_Caixa,   
       :pl_Controle,   
       :lvl_Lancamento,   
       :pl_Conta_Fluxo_Caixa,   
       :pdh_Data_Lancamento,   
       :pdc_Valor_Lancamento,   
       :ps_Historico,   
       :ps_Recibo_Cobranca,
	   :lvs_Estorno,
	    :ps_nr_documento);

If SqlCa.SqlCode = -1 Then
	Sqlca.of_RollBack()	
	Sqlca.of_MsgDBError( "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do lan$$HEX1$$e700$$ENDHEX$$amento do caixa." )
	Sqlca.of_LogDBError(gvo_aplicacao.ivi_log,"Erro na inclus$$HEX1$$e300$$ENDHEX$$o do lan$$HEX1$$e700$$ENDHEX$$amento do caixa.")
	Return False
Else
	Return True
End If
end function

public function string of_insere_recibo_outros (string ps_recibo_cobranca, long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, string ps_cliente, string ps_cheque, string ps_banco, string ps_caixa, string ps_forma_pagamento);Boolean lvb_Retorno

Integer lvi_Tipo_Recibo

Date lvdt_Cheque

Long lvl_Conta_Fluxo_Caixa, &
     lvl_Controle_Caixa, &
	  lvl_Filial_Venda, &
	  lvl_NF

Decimal lvdc_Cheque

String lvs_Titulo, &
		 lvs_Observacao, &
		 lvs_Especie, &
		 lvs_Serie, lvs_recibo
		 
SetNull(lvl_Filial_Venda)
SetNull(lvl_NF)
SetNull(lvs_Especie)
SetNull(lvs_Serie)
SetNull(lvs_Titulo)
SetNull(lvs_Observacao)
SetNull(lvdt_Cheque)
SetNull(lvdc_Cheque)

lvi_Tipo_Recibo = of_Recibo_Cheque()

lvb_Retorno = of_Insere_Recibo_Cobranca(lvs_recibo				, & 
														pl_Filial					, &
														pdh_Data_Emissao	, &
														pdc_Valor_Nominal	, &
														pdc_Valor_Juros		, &
														pdc_Valor_Desconto	, &  
														pdc_Valor_Recebido	, & 
														ps_Responsavel		, &
														lvi_Tipo_Recibo			, &
														lvs_Titulo				, &
														ps_Cliente				, &  
														ps_Cheque				, &
														ps_Banco				, &
														lvl_Filial_Venda,   &
														lvl_NF,             &
														lvs_Especie,        &
														lvs_Serie,          &
														lvs_Observacao,     &
														lvdt_Cheque,        &
														lvdc_Cheque, &
														0.00, &
														ps_forma_pagamento) //multa
													 
If lvb_Retorno Then
	lvl_Conta_Fluxo_Caixa = of_Conta_Fluxo_Caixa_Recibo(lvi_Tipo_Recibo)
	
	lvb_Retorno = of_Insere_Lancamento_Caixa(ps_Caixa,              &
														  lvl_Conta_Fluxo_Caixa, &   
														  pdh_Data_Emissao,      &
														  pdc_Valor_Recebido,    &
														  lvs_Observacao,        &
														  ps_Recibo_Cobranca)	
End If

If Not lvb_Retorno Then lvs_Recibo = ""

Return lvs_Recibo


end function

public function string of_insere_recibo_outros (long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, string ps_cliente, string ps_observacao, string ps_forma_pagamento);Boolean lvb_Retorno

Integer lvi_Tipo_Recibo

Date lvdt_Cheque

Long lvl_Conta_Fluxo_Caixa, &
     lvl_Controle_Caixa, lvl_filial_venda, lvl_nr_nf

String lvs_Cheque, &
		 lvs_Banco, &
		 lvs_Titulo, &
		 lvs_recibo , lvs_especie, lvs_serie

Decimal lvdc_Cheque
		 
SetNull(lvs_Cheque)
SetNull(lvs_Banco)
SetNull(lvs_Titulo)
SetNull(lvl_filial_venda)
SetNull(lvs_especie)
SetNull(lvs_serie)
SetNull(lvl_nr_nf)
SetNull(lvdt_Cheque)
SetNull(lvdc_Cheque)

lvi_Tipo_Recibo = of_Recibo_outros()

lvs_recibo = of_numero_recibo (pl_filial)

lvb_Retorno = of_Insere_Recibo_Cobranca(lvs_recibo, & 
													 pl_Filial,          &
													 pdh_Data_Emissao,   &
													 pdc_Valor_Nominal,  &
													 pdc_Valor_Juros,    &
													 pdc_Valor_Desconto, &  
													 pdc_Valor_Recebido, & 
													 ps_Responsavel,     &
													 lvi_Tipo_Recibo,    &
													 lvs_Titulo,         &
													 ps_Cliente,         &  
													 lvs_Cheque,         &
													 lvs_Banco,          &
													 lvl_Filial_Venda,   &
													 lvl_nr_nf,          &
													 lvs_Especie,        &
													 lvs_Serie,          &
													 ps_Observacao,      &
													 lvdt_Cheque,        &
													 lvdc_Cheque, &
					/*Multa*/					 0.00, &
													 ps_forma_pagamento) 												 

If Not lvb_Retorno Then lvs_Recibo = ""

Return lvs_Recibo


end function

public function string of_insere_recibo_cc_conta (long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, string ps_responsavel, string ps_cliente, string ps_observacao, string ps_caixa, long pl_nr_controle_caixa, string ps_forma_pagamento);Boolean lvb_Retorno

Integer lvi_Tipo_Recibo

Date lvdt_Cheque

Long lvl_Conta_Fluxo_Caixa, &
     lvl_Controle_Caixa, &
	  lvl_Filial_Venda, &
	  lvl_NF

String lvs_Titulo, &
		 lvs_Especie, &
		 lvs_Serie, &
		 lvs_Recibo, &
		 lvs_Banco, &
		 lvs_Cheque
		 
Decimal lvdc_Juros, &
        lvdc_Desconto, &
		  lvdc_Recebido, &
		  lvdc_Cheque

SetNull(lvl_Filial_Venda)
SetNull(lvl_NF)
SetNull(lvs_Especie)
SetNull(lvs_Serie)
SetNull(lvs_Titulo)
SetNull(lvs_Banco)
SetNull(lvs_Cheque)
SetNull(lvdt_Cheque)
SetNull(lvdc_Cheque)

lvdc_Juros    = 000.00
lvdc_Desconto = 000.00

lvs_Recibo = of_Numero_Recibo(pl_Filial)

If lvs_Recibo <> "" Then	
	lvdc_Recebido = pdc_Valor_Nominal
	
	lvi_Tipo_Recibo = of_Recibo_Conta_Corrente_Conta()
	
	lvb_Retorno = of_Insere_Recibo_Cobranca(lvs_Recibo,         & 
														 pl_Filial,          &
														 pdh_Data_Emissao,   &
														 pdc_Valor_Nominal,  &
														 lvdc_Juros,         &
														 lvdc_Desconto,      &  
														 lvdc_Recebido,      & 
														 ps_Responsavel,     &
														 lvi_Tipo_Recibo,    &
														 lvs_Titulo,         &
														 ps_Cliente,         &  
														 lvs_Cheque,         &
														 lvs_Banco,          &
														 lvl_Filial_Venda,   &
														 lvl_NF,             &
														 lvs_Especie,        &
														 lvs_Serie,          &
														 ps_Observacao,      &
														 lvdt_Cheque,        &
														 lvdc_Cheque,  &
					/* Multa */						 0.00, &
														 ps_forma_pagamento)
														 
	If lvb_Retorno Then
		lvl_Conta_Fluxo_Caixa = of_Conta_Fluxo_Caixa_Recibo(lvi_Tipo_Recibo)
		
		lvb_Retorno = of_Insere_Lancamento_Caixa(ps_Caixa,              &
		                                         pl_nr_controle_caixa,  &
															  lvl_Conta_Fluxo_Caixa, &   
															  pdh_Data_Emissao,      &
															  lvdc_Recebido,         &
															  ps_Observacao,         &
															  lvs_Recibo)	
	End If
End If

If Not lvb_Retorno Then lvs_Recibo = ""

Return lvs_Recibo
end function

public function string of_insere_recibo_cv_conta (long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, string ps_responsavel, string ps_cliente, string ps_observacao, string ps_caixa, long pl_nr_controle_caixa, string ps_forma_pagamento);Boolean lvb_Retorno

Integer lvi_Tipo_Recibo

Date lvdt_Cheque

Long lvl_Conta_Fluxo_Caixa, &
     lvl_Controle_Caixa, &
	  lvl_Filial_Venda, &
	  lvl_NF

String lvs_Titulo, &
		 lvs_Especie, &
		 lvs_Serie, &
		 lvs_Recibo, &
		 lvs_Banco, &
		 lvs_Cheque
		 
Decimal lvdc_Juros, &
        lvdc_Desconto, &
		  lvdc_Recebido, &
		  lvdc_Cheque

SetNull(lvl_Filial_Venda)
SetNull(lvl_NF)
SetNull(lvs_Especie)
SetNull(lvs_Serie)
SetNull(lvs_Titulo)
SetNull(lvs_Banco)
SetNull(lvs_Cheque)
SetNull(lvdt_Cheque)
SetNull(lvdc_Cheque)

lvdc_Juros     = 000.00
lvdc_Desconto  = 000.00

lvs_Recibo = of_Numero_Recibo(pl_Filial)

If lvs_Recibo <> "" Then	
	lvdc_Recebido = pdc_Valor_Nominal
	
	lvi_Tipo_Recibo = of_Recibo_Convenio_Conta()
	
	lvb_Retorno = of_Insere_Recibo_Cobranca(lvs_Recibo,         & 
														 pl_Filial,          &
														 pdh_Data_Emissao,   &
														 pdc_Valor_Nominal,  &
														 lvdc_Juros,         &
														 lvdc_Desconto,      &  
														 lvdc_Recebido,      & 
														 ps_Responsavel,     &
														 lvi_Tipo_Recibo,    &
														 lvs_Titulo,         &
														 ps_Cliente,         &  
														 lvs_Cheque,         &
														 lvs_Banco,          &
														 lvl_Filial_Venda,   &
														 lvl_NF,             &
														 lvs_Especie,        &
														 lvs_Serie,          &
														 ps_Observacao,      &
														 lvdt_Cheque,        &
														 lvdc_Cheque, &
						/*Multa*/					 0.00, &
														 ps_forma_pagamento)
														 
	If lvb_Retorno Then
		lvl_Conta_Fluxo_Caixa = of_Conta_Fluxo_Caixa_Recibo(lvi_Tipo_Recibo)
		
		If Not IsNull(pl_nr_controle_caixa) Then
			lvb_Retorno = of_Insere_Lancamento_Caixa(ps_Caixa,              &
																  pl_nr_controle_caixa,  &
																  lvl_Conta_Fluxo_Caixa, &   
																  pdh_Data_Emissao,      &
																  lvdc_Recebido,         &
																  ps_Observacao,         &
																  lvs_Recibo)	
		Else
			lvb_Retorno = of_Insere_Lancamento_Caixa(ps_Caixa,              &
																  lvl_Conta_Fluxo_Caixa, &   
																  pdh_Data_Emissao,      &
																  lvdc_Recebido,         &
																  ps_Observacao,         &
																  lvs_Recibo)	
		End If
	End If
End If

If Not lvb_Retorno Then lvs_Recibo = ""

Return lvs_Recibo
end function

public function string of_insere_recibo_nf_convenio_problema (long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, long pl_filial_venda, long pl_nf, string ps_especie, string ps_serie, string ps_observacao, string ps_caixa, long pl_nr_controle_caixa, string ps_conveniado, string ps_forma_pagamento);Boolean lvb_Retorno

Integer lvi_Tipo_Recibo

Date lvdt_Cheque

Long lvl_Conta_Fluxo_Caixa, &
     lvl_Controle_Caixa

String lvs_Cheque, &
		 lvs_Banco, &
		 lvs_Titulo, &
		 lvs_Recibo

Decimal lvdc_Cheque

SetNull(lvs_Cheque)
SetNull(lvs_Banco)
SetNull(lvs_Titulo)
SetNull(lvdt_Cheque)
SetNull(lvdc_Cheque)

lvs_Recibo = of_Numero_Recibo(pl_Filial)

If lvs_Recibo <> "" Then	
	lvi_Tipo_Recibo = of_Recibo_NF_Convenio_Problema()
	
	lvb_Retorno = of_Insere_Recibo_Cobranca(lvs_Recibo,         & 
														 pl_Filial,          &
														 pdh_Data_Emissao,   &
														 pdc_Valor_Nominal,  &
														 pdc_Valor_Juros,    &
														 pdc_Valor_Desconto, &  
														 pdc_Valor_Recebido, & 
														 ps_Responsavel,     &
														 lvi_Tipo_Recibo,    &
														 lvs_Titulo,         &
														 ps_conveniado,      &  
														 lvs_Cheque,         &
														 lvs_Banco,          &
														 pl_Filial_Venda,    &
														 pl_NF,              &
														 ps_Especie,         &
														 ps_Serie,           &
														 ps_Observacao,      &
														 lvdt_Cheque,        &
														 lvdc_Cheque, &
						/*Multa*/					 0.00, &
														 ps_forma_pagamento)
													 
	If lvb_Retorno Then
		lvl_Conta_Fluxo_Caixa = of_Conta_Fluxo_Caixa_Recibo(lvi_Tipo_Recibo)
		
		lvb_Retorno = of_Insere_Lancamento_Caixa(ps_Caixa,              &  
		                                         pl_nr_controle_caixa,  &
															  lvl_Conta_Fluxo_Caixa, &   
															  pdh_Data_Emissao,      &
															  pdc_Valor_Recebido,    &
															  ps_Observacao,         &
															  lvs_Recibo)	
	End If
End If

If Not lvb_Retorno Then lvs_Recibo = ""

Return lvs_Recibo
end function

public function string of_insere_recibo_nf_clube_parcial (long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, string ps_titulo, long pl_filial_venda, long pl_nf, string ps_especie, string ps_serie, string ps_caixa, string ps_cliente, string ps_forma_pagamento);Boolean lvb_Retorno

Integer lvi_Tipo_Recibo

Date lvdt_Cheque

Long lvl_Conta_Fluxo_Caixa, &
     lvl_Controle_Caixa

String lvs_Cheque, &
		 lvs_Banco, &
		 lvs_Observacao, &
		 lvs_Recibo, &
		 lvs_Historico

Decimal lvdc_Cheque
		 
SetNull(lvs_Cheque)
SetNull(lvs_Banco)
SetNull(lvs_Observacao)
SetNull(lvdt_Cheque)
SetNull(lvdc_Cheque)

lvi_Tipo_Recibo = of_Recibo_titulo_conta_corrente()

lvs_recibo = of_numero_recibo (pl_filial)

lvb_Retorno = of_Insere_Recibo_Cobranca(lvs_recibo, & 
													 pl_Filial,          &
													 pdh_Data_Emissao,   &
													 pdc_Valor_Nominal,  &
													 pdc_Valor_Juros,    &
													 pdc_Valor_Desconto, &  
													 pdc_Valor_Recebido, & 
													 ps_Responsavel,     &
													 lvi_Tipo_Recibo,    &
													 ps_Titulo,          &
													 ps_cliente,      &  
													 lvs_Cheque,         &
													 lvs_Banco,          &
													 pl_Filial_Venda,    &
													 pl_NF,              &
													 ps_Especie,         &
													 ps_Serie,           &
													 lvs_Observacao,     &
													 lvdt_Cheque,        &
													 lvdc_Cheque,   &
				/* Multa */						 0.00, &
													 ps_forma_pagamento) 
													 
If lvb_Retorno Then
	lvs_Historico = "T$$HEX1$$cd00$$ENDHEX$$TULO:" + LeftA(ps_Titulo, 4)   + "-" + &
	                              MidA(ps_Titulo, 5, 7) + "-" + &
										   RightA(ps_Titulo, 2) + "(AVISTA)"+"/NF:" + String(pl_NF) + "-" + ps_Especie + "-" + ps_serie
											
	lvs_Historico = LeftA(lvs_Historico,50)
	
//	lvl_Conta_Fluxo_Caixa = of_Conta_Fluxo_Caixa_Recibo(lvi_Tipo_Recibo)
	lvl_Conta_Fluxo_Caixa = 216 //Conta fluxo Fixa.
	
	lvb_Retorno = of_Insere_Lancamento_Caixa(ps_Caixa, &
														  lvl_Conta_Fluxo_Caixa, &   
														  pdh_Data_Emissao, &
														  pdc_Valor_Recebido, &
														  lvs_Historico, &
														  lvs_Recibo)	
End If

If Not lvb_Retorno Then lvs_Recibo = ""

Return lvs_Recibo


end function

public function string of_insere_recibo_vale_caixa (long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, string ps_colaborador, string ps_motivo, string ps_forma_pagamento);Boolean lvb_Retorno

Integer lvi_Tipo_Recibo

Date lvdt_Cheque

Long lvl_Conta_Fluxo_Caixa, &
     lvl_Controle_Caixa, lvl_filial_venda, lvl_nr_nf

String lvs_Cheque, &
		 lvs_Banco, &
		 lvs_Titulo, &
		 lvs_recibo , lvs_especie, lvs_serie

Decimal lvdc_Cheque
		 
SetNull(lvs_Cheque)
SetNull(lvs_Banco)
SetNull(lvl_filial_venda)
SetNull(lvs_especie)
SetNull(lvs_serie)
SetNull(lvl_nr_nf)
SetNull(lvdt_Cheque)
SetNull(lvdc_Cheque)
lvs_titulo = 'VALECAIXA'

//Busca o codigo de recibo outros, na informa$$HEX1$$e700$$ENDHEX$$ao de nr_titulo grava o texto VALECAIXA para na reimpress$$HEX1$$e300$$ENDHEX$$o imprimir o modelo de vale caixa.
lvi_Tipo_Recibo = of_Recibo_outros() 

lvs_recibo = of_numero_recibo (pl_filial)

lvb_Retorno = of_Insere_Recibo_Cobranca(lvs_recibo, & 
													 pl_Filial,          &
													 pdh_Data_Emissao,   &
													 pdc_Valor_Nominal,  &
													 pdc_Valor_Juros,    &
													 pdc_Valor_Desconto, &  
													 pdc_Valor_Recebido, & 
													 ps_Responsavel,     &
													 lvi_Tipo_Recibo,    &
													 lvs_Titulo,         &
													 ps_Colaborador,         &  
													 lvs_Cheque,         &
													 lvs_Banco,          &
													 lvl_Filial_Venda,   &
													 lvl_nr_nf,          &
													 lvs_Especie,        &
													 lvs_Serie,          &
													 ps_Motivo,      &
													 lvdt_Cheque,        &
													 lvdc_Cheque, &
					/* Multa */					 0.00, &
													 ps_forma_pagamento)

If Not lvb_Retorno Then lvs_Recibo = ""

Return lvs_Recibo


end function

public function string of_insere_recibo_nf_convenio_parcial (long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, string ps_titulo, long pl_filial_venda, long pl_nf, string ps_especie, string ps_serie, string ps_caixa, string ps_conveniado, long pl_conta_parcial, string ps_forma_pagamento);Boolean lvb_Retorno

Integer lvi_Tipo_Recibo

Date lvdt_Cheque

Long lvl_Conta_Fluxo_Caixa, &
     lvl_Controle_Caixa

String lvs_Cheque, &
		 lvs_Banco, &
		 lvs_Observacao, &
		 lvs_Recibo, &
		 lvs_Historico

Decimal lvdc_Cheque
		 
SetNull(lvs_Cheque)
SetNull(lvs_Banco)
SetNull(lvs_Observacao)
SetNull(lvdt_Cheque)
SetNull(lvdc_Cheque)

lvi_Tipo_Recibo = of_Recibo_NF_Convenio_Parcial()

lvs_recibo = of_numero_recibo (pl_filial)

lvb_Retorno = of_Insere_Recibo_Cobranca(lvs_recibo, & 
													 pl_Filial,          &
													 pdh_Data_Emissao,   &
													 pdc_Valor_Nominal,  &
													 pdc_Valor_Juros,    &
													 pdc_Valor_Desconto, &  
													 pdc_Valor_Recebido, & 
													 ps_Responsavel,     &
													 lvi_Tipo_Recibo,    &
													 ps_Titulo,          &
													 ps_conveniado,      &  
													 lvs_Cheque,         &
													 lvs_Banco,          &
													 pl_Filial_Venda,    &
													 pl_NF,              &
													 ps_Especie,         &
													 ps_Serie,           &
													 lvs_Observacao,     &
													 lvdt_Cheque,        &
													 lvdc_Cheque,  &
								/* Multa */		 0.00, &
													ps_forma_pagamento)
													 
If lvb_Retorno Then
	lvs_Historico = "T$$HEX1$$cd00$$ENDHEX$$TULO: " + LeftA(ps_Titulo, 4)   + "-" + &
	                              MidA(ps_Titulo, 5, 7) + "-" + &
										   RightA(ps_Titulo, 2) +"/NF: " + String(pl_NF) + " - " + ps_Especie + " - " + ps_serie
											
	lvs_Historico = LeftA(lvs_Historico,50)											
	
	If pl_conta_parcial = 0 Then //Continua a gravar como sempre gravou
		If ps_especie = 'NFC' or ps_especie = 'SAT' Then  //Para vendas NFC-e/SAT a conta de pagamento parcial de conv$$HEX1$$ea00$$ENDHEX$$nio $$HEX1$$e900$$ENDHEX$$ a 212
			lvl_Conta_Fluxo_Caixa = 212
		Else
			lvl_Conta_Fluxo_Caixa = of_Conta_Fluxo_Caixa_Recibo(lvi_Tipo_Recibo)
		End If
	Else //Forma nova, separando as contas - inicio 01/11/2016
		If pl_conta_parcial = 2 Then
			If ps_especie = 'NFC' or ps_especie = 'SAT' Then  //Para vendas NFC-e/SAT a conta de pagamento parcial de conv$$HEX1$$ea00$$ENDHEX$$nio $$HEX1$$e900$$ENDHEX$$ a 212
				lvl_Conta_Fluxo_Caixa = 212
			Else
				lvl_Conta_Fluxo_Caixa = of_Conta_Fluxo_Caixa_Recibo(lvi_Tipo_Recibo)
			End If
		Else
			lvl_Conta_Fluxo_Caixa = pl_conta_parcial
		End If		
	End If
	
	lvb_Retorno = of_Insere_Lancamento_Caixa(ps_Caixa, &
														  lvl_Conta_Fluxo_Caixa, &   
														  pdh_Data_Emissao, &
														  pdc_Valor_Recebido, &
														  lvs_Historico, &
														  lvs_Recibo)	
End If

If Not lvb_Retorno Then lvs_Recibo = ""

Return lvs_Recibo


end function

public function string of_insere_recibo_titulo_crediario (long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, string ps_titulo, string ps_caixa, string ps_forma_pagamento, decimal pdc_valor_multa);Boolean lvb_Sucesso

Integer lvi_Tipo_Recibo

Date lvdt_Cheque

Decimal lvdc_Cheque

Long lvl_Conta_Fluxo_Caixa, &
     lvl_Controle_Caixa, &
	  lvl_Filial_NF, &
	  lvl_NF

String lvs_Cheque, &
		 lvs_Banco, & 
		 lvs_Observacao, &
		 lvs_Recibo, &
		 lvs_Especie, &
		 lvs_Serie, &
		 lvs_Cliente, &
		 lvs_Historico, &
		 lvs_hist_forma_pgto											
		 
SetNull(lvs_Cheque)
SetNull(lvs_Banco)
SetNull(lvs_Observacao)
SetNull(lvl_Filial_NF)
SetNull(lvl_NF)
SetNull(lvs_Especie)
SetNull(lvs_Serie)
SetNull(lvdt_Cheque)
SetNull(lvdc_Cheque)
SetNull(lvs_Cliente)

lvs_Recibo = This.of_Numero_Recibo(pl_Filial)

lvi_Tipo_Recibo = This.of_Recibo_Titulo_Crediario()

lvb_Sucesso = This.of_Insere_Recibo_Cobranca(lvs_Recibo,         & 
														   pl_Filial,          &
														   pdh_Data_Emissao,   &
														   pdc_Valor_Nominal,  &
														   pdc_Valor_Juros,    &
														   pdc_Valor_Desconto, &  
														   pdc_Valor_Recebido, & 
														   ps_Responsavel,     &
														   lvi_Tipo_Recibo,    &
														   ps_Titulo,          &
														   lvs_Cliente,        &  
														   lvs_Cheque,         &
														   lvs_Banco,          &
														   lvl_Filial_NF,      &
														   lvl_NF,             &
														   lvs_Especie,        &
														   lvs_Serie,          &
														   lvs_Observacao,     &
														   lvdt_Cheque,        &
														   lvdc_Cheque, &
														   pdc_valor_multa, &
														   ps_forma_pagamento)
													 
If lvb_Sucesso Then
	lvs_Historico = "T$$HEX1$$cd00$$ENDHEX$$TULO : " + LeftA(ps_Titulo, 4)   + "-" + &
	                              MidA(ps_Titulo, 5, 7) + "-" + &
										   RightA(ps_Titulo, 2)
	Choose Case ps_forma_pagamento
		Case 'DI'			
			lvs_hist_forma_pgto = '(DH)'
		Case 'CA'
			lvs_hist_forma_pgto = '(DEB)'
		Case 'HA'
			lvs_hist_forma_pgto = '(CHQ)'
		Case Else
			lvs_hist_forma_pgto = ''
	End Choose			
	lvs_Historico += " " + lvs_hist_forma_pgto
	
	// Lan$$HEX1$$e700$$ENDHEX$$amento do Valor Nominal
	lvl_Conta_Fluxo_Caixa = This.of_Conta_Fluxo_Caixa_Recibo(lvi_Tipo_Recibo)
	
	lvb_Sucesso = This.of_Insere_Lancamento_Caixa(ps_Caixa, &
															    lvl_Conta_Fluxo_Caixa, &   
															    pdh_Data_Emissao, &
															    pdc_Valor_Nominal, &
															    lvs_Historico, &
															    lvs_Recibo)	
														  
	// Lan$$HEX1$$e700$$ENDHEX$$amento de Juros Obtidos
	If lvb_Sucesso Then
		If pdc_Valor_Juros > 0 Or pdc_Valor_Multa > 0 Then
			lvi_Tipo_Recibo       = This.of_Recibo_Juros()
			lvl_Conta_Fluxo_Caixa = This.of_Conta_Fluxo_Caixa_Recibo(lvi_Tipo_Recibo)
			
			lvb_Sucesso = This.of_Insere_Lancamento_Caixa(ps_Caixa, &
																       lvl_Conta_Fluxo_Caixa, &   
																       pdh_Data_Emissao, &
																       pdc_Valor_Juros + pdc_valor_multa, &
																       lvs_Historico, &
																       lvs_Recibo)	
		End If
	End If

	// Lan$$HEX1$$e700$$ENDHEX$$amento de Desconto Concedido
	If lvb_Sucesso Then
		If pdc_Valor_Desconto > 0 Then
			lvi_Tipo_Recibo       = This.of_Recibo_Desconto()
			lvl_Conta_Fluxo_Caixa = This.of_Conta_Fluxo_Caixa_Recibo(lvi_Tipo_Recibo)
			
			lvb_Sucesso = This.of_Insere_Lancamento_Caixa(ps_Caixa, &
																       lvl_Conta_Fluxo_Caixa, &   
																       pdh_Data_Emissao, &
																       pdc_Valor_Desconto, &
																       lvs_Historico, &
																       lvs_Recibo)	
		End If
	End If
End If

If Not lvb_Sucesso Then lvs_Recibo = ""

Return lvs_Recibo
end function

public function boolean of_insere_recibo_cheque (long pl_filial, string ps_cd_banco, string ps_nr_agencia, string ps_nr_conta, string ps_nr_cheque, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_pago, string ps_historico, string ps_caixa, long pl_controle_caixa, string ps_responsavel, string ps_forma_pagamento, string ps_nome_cliente, string ps_nome_banco);Boolean lvb_Sucesso, lvb_Retorno

Integer lvi_Tipo_Recibo

Long lvl_Conta_Fluxo_Caixa, lvl_Filial_Venda, lvl_NF

String lvs_Recibo, lvs_Titulo, lvs_Especie, lvs_Serie

Decimal lvdc_Valor_Juros, lvdc_Desconto, lvdc_Recebido, lvdc_Cheque

Date lvdt_Cheque

SetNull(lvs_Titulo)
SetNull(lvl_Filial_Venda)
SetNull(lvl_NF)
SetNull(lvs_Especie)
SetNull(lvs_Serie)
		 
If pdc_Valor_Pago < pdc_Valor_Nominal Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor pago n$$HEX1$$e300$$ENDHEX$$o pode ser menor que o valor nominal do cheque.", StopSign!)
	Return False
End If

// Lan$$HEX1$$e700$$ENDHEX$$amento do Valor Nominal
lvi_Tipo_Recibo				= This.of_Recibo_Cheque()
lvl_Conta_Fluxo_Caixa	= This.of_Conta_Fluxo_Caixa_Recibo( lvi_Tipo_Recibo )
lvs_Recibo 					= This.of_Numero_Recibo( pl_filial)
lvdc_Valor_Juros 			= pdc_Valor_Pago - pdc_Valor_Nominal
lvdc_Desconto				= 0.00
lvdc_Cheque				= pdc_Valor_Nominal
lvdt_Cheque					= Date(pdh_data_emissao)

If lvs_Recibo <> "" Then	
	lvdc_Recebido = pdc_Valor_Nominal
	
	lvi_Tipo_Recibo = This.of_Recibo_Cheque( )
	
	lvb_Retorno = of_Insere_Recibo_Cobranca( lvs_Recibo				, & 
															 pl_Filial					, &
															 pdh_Data_Emissao	, &
															 pdc_Valor_Nominal	, &
															 lvdc_Valor_Juros		, &
															 lvdc_Desconto			, &  
															 lvdc_Recebido 			, & 
															 ps_Responsavel		, &
															 lvi_Tipo_Recibo		, &
					/* N$$HEX1$$ba00$$ENDHEX$$ T$$HEX1$$ed00$$ENDHEX$$tulo */						 lvs_Titulo				, &
															 ps_nome_cliente		, &  
															 ps_nr_cheque			, &
															 ps_nome_banco		, &
															 lvl_Filial_Venda		, &
															 lvl_NF					, &
															 lvs_Especie				, &
															 lvs_Serie				, &
															 ps_historico			, &
															 lvdt_Cheque			, &
															 lvdc_Cheque			, &
						/* Multa */						 0.00						, &
															 ps_forma_pagamento, &
															 ps_cd_banco			, &
															 ps_nr_agencia			, &
															 ps_nr_conta)

	lvb_Sucesso = This.of_Insere_Lancamento_Caixa( ps_Caixa, &
																	 pl_Controle_Caixa, &
																	 lvl_Conta_Fluxo_Caixa, &   
																	 pdh_Data_Emissao, &
																	 pdc_Valor_Nominal, &
																	 ps_Historico, &
																	 lvs_Recibo)
	
	If lvb_Sucesso Then
		// Lan$$HEX1$$e700$$ENDHEX$$amento de Juros Obtidos	
		If lvdc_Valor_Juros > 0 Then
			lvi_Tipo_Recibo       		= This.of_Recibo_Juros()
			lvl_Conta_Fluxo_Caixa	= This.of_Conta_Fluxo_Caixa_Recibo(lvi_Tipo_Recibo)
			
			lvb_Sucesso = This.of_Insere_Lancamento_Caixa(	ps_Caixa, &
																				pl_Controle_Caixa, &
																				lvl_Conta_Fluxo_Caixa, &   
																				pdh_Data_Emissao, &
																				lvdc_Valor_Juros, &
																				ps_Historico, &
																				lvs_Recibo)	
		End If
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_insere_recibo_cobranca (string ps_recibo_cobranca, long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, integer pi_tipo_recibo, string ps_titulo, string ps_cliente, string ps_cheque, string ps_nome_banco, long pl_filial_venda, long pl_nf, string ps_especie, string ps_serie, string ps_observacao, date pdh_data_cheque, decimal pdc_valor_cheque, decimal pdc_valor_multa, string ps_forma_pagamento);String lvs_Cd_Banco, lvs_Nr_Agencia, lvs_Nr_Conta

SetNull(lvs_Cd_Banco)
SetNull(lvs_Nr_Agencia)
SetNull(lvs_Nr_Conta)

Return This.of_insere_recibo_cobranca (ps_recibo_cobranca, pl_filial, pdh_data_emissao, pdc_valor_nominal, pdc_valor_juros, pdc_valor_desconto, pdc_valor_recebido, ps_responsavel, pi_tipo_recibo, ps_titulo, ps_cliente, ps_cheque, ps_nome_banco, pl_filial_venda, pl_nf, ps_especie, ps_serie, ps_observacao, pdh_data_cheque, pdc_valor_cheque, pdc_valor_multa, ps_forma_pagamento, lvs_Cd_Banco, lvs_Nr_Agencia, lvs_Nr_Conta);
end function

public function boolean of_insere_recibo_cobranca (string ps_recibo_cobranca, long pl_filial, datetime pdh_data_emissao, decimal pdc_valor_nominal, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_recebido, string ps_responsavel, integer pi_tipo_recibo, string ps_titulo, string ps_cliente, string ps_cheque, string ps_nome_banco, long pl_filial_venda, long pl_nf, string ps_especie, string ps_serie, string ps_observacao, date pdh_data_cheque, decimal pdc_valor_cheque, decimal pdc_valor_multa, string ps_forma_pagamento, string ps_cd_banco, string ps_nr_agencia, string ps_nr_conta);DateTime lvdh_Data_Parametro

lvdh_Data_Parametro = This.of_Data_Parametro()

Insert Into recibo_cobranca (nr_recibo_cobranca,   
									  cd_filial,   
									  dh_emissao,   
									  vl_nominal,   
									  vl_juros,   
									  vl_desconto,   
									  vl_recebido,   
									  nr_matricula_responsavel,   
									  cd_tipo_recibo,   
									  nr_titulo,   
									  nm_cliente,   
									  nr_cheque,   
									  de_banco,   
									  cd_filial_venda,   
									  nr_nf_venda,   
									  de_especie_venda,   
									  de_serie_venda,   
									  de_observacao,
									  dh_emissao_cheque,
									  vl_cheque,
									  vl_multa_recebida,
									  cd_forma_pagamento,
									  cd_banco,
									  nr_agencia,
									  nr_conta)  
Values(:ps_Recibo_Cobranca,   
		:pl_Filial,   
		:lvdh_Data_Parametro,   
		:pdc_Valor_Nominal,   
		:pdc_Valor_Juros,   
		:pdc_Valor_Desconto,   
		:pdc_Valor_Recebido,   
		:ps_Responsavel,   
		:pi_Tipo_Recibo,   
		:ps_Titulo,   
		:ps_Cliente,   
		:ps_Cheque,   
		:ps_nome_banco,   
		:pl_Filial_Venda,   
		:pl_NF,   
		:ps_Especie,   
		:ps_Serie,   
		:ps_Observacao,
		:pdh_Data_Cheque,
		:pdc_Valor_Cheque,
		:pdc_valor_multa,
		:ps_forma_pagamento,
		:ps_cd_banco,
		:ps_nr_agencia,
		:ps_nr_conta)
Using SqlCa;
			  
If SqlCa.SqlCode = -1 Then
	Sqlca.of_RollBack()	
	Sqlca.of_MsgDBError("Erro na inclus$$HEX1$$e300$$ENDHEX$$o do recibo de cobran$$HEX1$$e700$$ENDHEX$$a.")
	Return False
Else
	Return True
End If
end function

public function boolean of_caixa_geral_movimento (long pl_filial, ref string ps_caixa, ref long pl_controle);Long ll_controle
String ls_Geral

Select cx.cd_caixa, ct.nr_controle_caixa Into :ls_geral, :ll_controle
From caixa cx
	inner join controle_caixa ct
		on ct.cd_caixa = cx.cd_caixa
		and ct.dh_movimentacao_caixa = (select p.dh_movimentacao from parametro p where p.id_parametro = '1' and p.cd_filial = cx.cd_filial)
		and ct.dh_conferencia is null
where  cx.cd_filial      = :pl_filial
  	and cx.id_caixa_geral = 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ps_caixa 		= ls_Geral
		pl_controle 	= ll_controle 
		
		Return True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Caixa geral n$$HEX1$$e300$$ENDHEX$$o localizado ou j$$HEX1$$e100$$ENDHEX$$ finalizado para a filial '" + String(pl_Filial) + "'.", StopSign!)
		Return False
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do caixa geral." + SqlCa.SqlErrText, StopSign!)
		Return False
End Choose
end function

on uo_controle_caixa.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_controle_caixa.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

