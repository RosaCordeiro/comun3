HA$PBExportHeader$uo_titulo.sru
forward
global type uo_titulo from nonvisualobject
end type
end forward

global type uo_titulo from nonvisualobject
end type
global uo_titulo uo_titulo

type variables
datastore ids_parcelas

String  ivs_nr_titulo []

Integer	ivi_Cont_Excecao

Long  ivl_nr_movimento, &
         cd_filial_movimento, &
	    cd_convenio

String nr_titulo,&
          de_historico, &
          cd_caixa, &
          id_Tipo_Titulo, &
          ivs_recibo_cobranca, &
          Nr_Matric_Liberacao_Juros_Desconto, &
		 cd_cliente, &
		 cd_forma_pagamento, &
 		 cd_motivo_estorno

Decimal{2} vl_juros_recebidos, &
                  vl_desconto_concedido, &
                  vl_recebido, &
                  vl_despesas_pagas, &
                  vl_despesas_recebidas, &
                  vl_aberto, &
                  vl_abatimento, &
				vl_multa_recebida, &
				vl_multa_paga

DateTime dh_Baixa, &
                dh_Vencimento, &
                dh_Movimento, &
                dh_Registro, &
                dh_Credito, &
                dh_Calculo_Juros

Boolean ib_imprime_recibo

//Variaveis para pagamento de titulos/conta com cheque
Boolean	ib_pag_cheque
String		is_cpf_cnpj, &
			id_tipo_cheque, &
			cd_banco, &
			nr_agencia, &
			nr_conta, &
			nr_cheque, &
			nr_cmc7, &
			id_tipo_deposito, &
			nr_conta_sap
			
DateTime 	dh_emissao_cheque, &
				dh_vencimento_cheque

Decimal {2} vl_cheque
end variables

forward prototypes
public function integer of_movto_abertura ()
public function string of_descricao_movimento (integer pi_tipo_movimento)
public function boolean of_permite_estorno (integer pi_tipo_movto)
public function integer of_movto_cancelamento ()
public function string of_tipo_titulo (string ps_titulo)
public function integer of_movto_pagto ()
public function integer of_movto_estorno_abertura ()
public function integer of_movto_estorno_pagto ()
public function string of_insere_titulo (long pl_filial, string ps_cliente, long pl_portador, datetime pdh_vencimento, decimal pdc_valor_nominal, decimal pdc_saldo_anterior, string ps_carne_bloqueto, datetime pdh_venda_inicial, datetime pdh_venda_final, string ps_responsavel, string ps_tipo_titulo)
public function integer of_proximo_movimento (string ps_titulo, long pl_filial)
public function long of_filial_abertura (string ps_titulo)
public function integer of_tipo_movto (string ps_abertura, string ps_pagto, string ps_cancelamento, string ps_estorno, string ps_devolucao)
public function integer of_movto_devolucao ()
public function boolean of_proximo_movimento (string as_titulo, long al_filial, ref integer ai_movto)
public function boolean of_estorna_abertura_old (string ps_titulo, datetime pdh_data_movimento, string ps_responsavel, string ps_historico, long pl_filial_movto)
public function string of_insere_titulo_conta_corrente (long pl_filial, string ps_cliente, long pl_portador, string ps_nr_titulo_banco, date pdt_vencimento, decimal pdc_valor_nominal, decimal pdc_saldo_anterior, string ps_carne_bloqueto, date pdt_venda_inicial, date pdt_venda_final, string ps_responsavel, string ps_tipo_titulo, datetime pdh_movimento)
public function string of_proximo_titulo (long pl_filial)
public function boolean of_insere_movimento (string ps_titulo, integer pi_tipo_movimento, datetime pdh_data_movimento, datetime pdh_data_credito, decimal pdc_valor_movimento, decimal pdc_valor_multa, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_despesas, string ps_estorno, string ps_responsavel, string ps_historico, long pl_recibo, long pl_filial_movto)
public function boolean of_valida_emails (string ps_email, ref string ps_emails_incorretos[])
public function boolean of_notifica_faturas_convenio_vencidas (long pl_dias)
public function boolean of_notifica_faturas_convenio_a_vencer (long pl_dias)
public function boolean of_insere_titulo_clube (long al_filial, long al_nf, string as_especie, string as_serie, datetime adh_datahora, string as_cliente, string as_responsavel, string as_caixa, long al_proximo_titulo, string as_forma_pagamento)
public function boolean of_insere_titulo_convenio (long al_filial, long al_nf, string as_especie, string as_serie, datetime adh_datahora, string as_conveniado, string as_responsavel, string as_caixa, long al_proximo_titulo, long al_conta_parcial, string as_forma_pagamento)
public function boolean of_insere_titulos_crediario (long al_filial, long al_nf, string as_especie, string as_serie, datetime adh_datahora, string as_responsavel, string as_caixa, long al_proximo_titulo, string as_forma_pagamento)
end prototypes

public function integer of_movto_abertura ();Return of_Tipo_Movto("S", "N", "N", "N", "N")
end function

public function string of_descricao_movimento (integer pi_tipo_movimento);String lvs_Tipo_Movimento

Select de_tipo_movimento Into :lvs_Tipo_Movimento
From tipo_movimento_receber
Where cd_tipo_movimento = :pi_Tipo_Movimento;
  
Choose Case SqlCa.SqlCode
	Case 0
		Return lvs_Tipo_Movimento
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Tipo de movimento " + String(pi_Tipo_Movimento) + " n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!, Ok!)
		Return ""
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da descri$$HEX2$$e700e300$$ENDHEX$$o do tipo de movimento " + String(pi_Tipo_Movimento) + ".", StopSign!, Ok!)
		Return ""
End Choose


end function

public function boolean of_permite_estorno (integer pi_tipo_movto);Integer lvi_Tipo_Abertura, &
        lvi_Tipo_Pagto
		  
lvi_Tipo_Abertura = of_Movto_Abertura()
lvi_Tipo_Pagto    = of_Movto_Pagto()

Choose Case pi_Tipo_Movto
	Case lvi_Tipo_Abertura, lvi_Tipo_Pagto
		Return True
	Case Else
		Return False
End Choose
end function

public function integer of_movto_cancelamento ();Return of_Tipo_Movto("N", "N", "S", "N", "N")
end function

public function string of_tipo_titulo (string ps_titulo);Select nr_titulo,
       id_tipo_titulo 
Into :Nr_Titulo, &
  	  :id_Tipo_Titulo
From titulo_receber
Where nr_titulo = :ps_Titulo;

If ( Sqlca.SqlCode = -1 ) Then
	
	Sqlca.of_RollBack()
	Sqlca.of_MsgDBError( "Erro ao localizar tipo do T$$HEX1$$ed00$$ENDHEX$$tulo a Receber." )
	
	Id_Tipo_Titulo = ''
	
End If	

Return Id_Tipo_Titulo

end function

public function integer of_movto_pagto ();Return of_Tipo_Movto("N", "S", "N", "N", "N")
end function

public function integer of_movto_estorno_abertura ();Return of_Tipo_Movto("S", "N", "N", "S", "N")
end function

public function integer of_movto_estorno_pagto ();Return of_Tipo_Movto("N", "S", "N", "S", "N")
end function

public function string of_insere_titulo (long pl_filial, string ps_cliente, long pl_portador, datetime pdh_vencimento, decimal pdc_valor_nominal, decimal pdc_saldo_anterior, string ps_carne_bloqueto, datetime pdh_venda_inicial, datetime pdh_venda_final, string ps_responsavel, string ps_tipo_titulo);STRING   lvs_Titulo, &
         lvs_Historico

DATETIME lvdth_Data_Atual

LONG     lvl_Recibo

INTEGER  lvi_Tipo_Movimento

lvs_Titulo = of_Proximo_Titulo(pl_Filial)

lvdth_Data_Atual = DateTime(Today(), Now())

Insert Into titulo_receber (cd_filial,   
								    nr_titulo,   
								    cd_portador,
								    cd_cliente,   
								    dh_emissao,   
								    dh_vencimento,									 
									 dh_calculo_juros,
								    vl_nominal,   
								    vl_juros_recebidos,   
								    vl_desconto_concedido,   
								    vl_despesas_recebidas,   
								    vl_despesas_pagas,
								    vl_recebido,   
								    id_situacao,   
								    id_carne_bloqueto,
								    id_protesto,   
								    vl_aberto,
								    dh_venda_inicial,
								    dh_venda_final,
								    id_tipo_titulo)  
Values (:pl_Filial,   
		  :lvs_Titulo,   
		  :pl_Portador,   
		  :ps_Cliente,   
		  :lvdth_Data_Atual,   
		  :pdh_Vencimento,   
		  :pdh_Vencimento,	  
		  :pdc_Valor_Nominal,   
		  000.00,   
		  000.00,   
		  000.00,   
		  000.00,   
		  000.00,
		  'A',   
		  :ps_Carne_Bloqueto,   
		  'N',   
		  :pdc_Valor_Nominal,			
		  :pdh_Venda_Inicial,
		  :pdh_Venda_Final,
		  :ps_Tipo_Titulo);

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do t$$HEX1$$ed00$$ENDHEX$$tulo. ~r~rMensagem : " + Sqlca.SqlErrText , StopSign!, Ok!)
	Return ""
Else

	lvi_Tipo_Movimento = of_Movto_Abertura()
	
	SetNull(lvs_Historico)
	SetNull(lvl_Recibo)
	
	If of_Insere_Movimento(lvs_Titulo, &
	                       lvi_Tipo_Movimento, &
								  lvdth_Data_Atual, &
								  lvdth_Data_Atual, &
								  pdc_Valor_Nominal, &
								  0.00, &
								  0.00, &
								  0.00, &
								  0.00, &
								  'N', &
								  ps_Responsavel, &
								  lvs_Historico, &
								  lvl_Recibo, &
								  pl_Filial) Then
							 
		Return lvs_Titulo			
	Else
		Return ""
	End If
End If
end function

public function integer of_proximo_movimento (string ps_titulo, long pl_filial);Integer lvi_Movimento

Select max(nr_movimento) Into :lvi_Movimento
From movimento_titulo_receber
Where nr_titulo           = :ps_Titulo
  and cd_filial_movimento = :pl_Filial;

If SqlCa.SqlCode = 0 Then
	If IsNull(lvi_Movimento) Then
		Return 1
	Else
		Return lvi_Movimento + 1
	End If
ElseIf SqlCa.SqlCode = -1 Then
	Sqlca.of_RollBack()	
	SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o do Pr$$HEX1$$f300$$ENDHEX$$ximo Movimento do T$$HEX1$$ed00$$ENDHEX$$tulo")
	Return 0
End If
end function

public function long of_filial_abertura (string ps_titulo);Long lvl_Filial

Select cd_filial Into :lvl_Filial
From titulo_receber
Where nr_titulo = :ps_Titulo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return lvl_Filial
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial de abertura do t$$HEX1$$ed00$$ENDHEX$$tulo n$$HEX1$$e300$$ENDHEX$$o localizada.", StopSign!)
		Return -1
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da filial de abertura do t$$HEX1$$ed00$$ENDHEX$$tulo." + SqlCa.SqlErrText, StopSign!)
		Return -1		
End Choose
end function

public function integer of_tipo_movto (string ps_abertura, string ps_pagto, string ps_cancelamento, string ps_estorno, string ps_devolucao);Integer lvi_Tipo_Movimento

Select cd_tipo_movimento Into :lvi_Tipo_Movimento
From tipo_movimento_receber
Where id_abertura     = :ps_Abertura
  and id_pagamento    = :ps_Pagto
  and id_cancelamento = :ps_Cancelamento
  and id_estorno      = :ps_Estorno
  and id_devolucao    = :ps_Devolucao;
  
Choose Case SqlCa.SqlCode
	Case 0
		Return lvi_Tipo_Movimento
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Tipo de movimento n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!, Ok!)
		Return 0
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na determina$$HEX2$$e700e300$$ENDHEX$$o do tipo de movimento.", StopSign!, Ok!)
		Return 0
End Choose
end function

public function integer of_movto_devolucao ();Return of_Tipo_Movto("N", "N", "N", "N", "S")
end function

public function boolean of_proximo_movimento (string as_titulo, long al_filial, ref integer ai_movto);Boolean lvb_Sucesso = True

Select max(nr_movimento) Into :ai_Movto
From movimento_titulo_receber
Where nr_titulo           = :as_Titulo
  and cd_filial_movimento = :al_Filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(ai_Movto) Then ai_Movto = 0
		ai_Movto ++
		
	Case 100
		ai_Movto = 1
		
	Case -1
		Sqlca.of_RollBack()		
		SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o do Pr$$HEX1$$f300$$ENDHEX$$ximo Movimento do T$$HEX1$$ed00$$ENDHEX$$tulo")
		lvb_Sucesso = False
End Choose

Return lvb_Sucesso
end function

public function boolean of_estorna_abertura_old (string ps_titulo, datetime pdh_data_movimento, string ps_responsavel, string ps_historico, long pl_filial_movto);Boolean lvb_Retorno

Long lvl_Filial_Abertura

Integer lvi_Tipo_Movimento, &
        lvi_Numero_Movimento

DateTime lvdth_Data_Sistema

Decimal lvdc_Valor_Movimento, &
		  lvdc_Valor_Juros, &
		  lvdc_Valor_Desconto, &
		  lvdc_Valor_Despesas

// Verifica qual a filial que abriu o t$$HEX1$$ed00$$ENDHEX$$tulo
lvl_Filial_Abertura = This.of_Filial_Abertura(ps_Titulo)
If lvl_Filial_Abertura = -1 Then Return False

// Verifica os valores do movimento de abertura do t$$HEX1$$ed00$$ENDHEX$$tulo
Select vl_movimento, 
       vl_juros_recebidos,
		 vl_desconto_concedido,
		 vl_despesas_recebidas
Into :lvdc_Valor_Movimento,
	  :lvdc_Valor_Juros,
	  :lvdc_Valor_Desconto,
	  :lvdc_Valor_Despesas 
From movimento_titulo_receber
Where nr_titulo           = :ps_Titulo
  and cd_filial_movimento = :lvl_Filial_Abertura
  and nr_movimento        = 1;
		 
Choose Case SqlCa.SqlCode
	Case 0
		
		lvi_Tipo_Movimento   = of_Movto_Estorno_Abertura()
		lvi_Numero_Movimento = of_Proximo_Movimento(ps_Titulo, pl_Filial_Movto)
		
		lvdth_Data_Sistema = DateTime(Today(), Now())
		
		Insert Into movimento_titulo_receber (nr_titulo,
														  nr_movimento,
														  cd_tipo_movimento,   
														  dh_movimento,   
														  dh_sistema,   
														  dh_credito,   
														  vl_movimento,   
														  vl_juros_recebidos,   
														  vl_desconto_concedido,   
														  vl_despesas_recebidas,
														  id_estorno,   
														  nr_matricula_responsavel,   
														  de_historico,
														  cd_filial_movimento)
		Values (:ps_Titulo,  
				  :lvi_Numero_Movimento,
				  :lvi_Tipo_Movimento,
				  :pdh_Data_Movimento,  
				  :lvdth_Data_Sistema,  
				  :pdh_Data_Movimento,
				  :lvdc_Valor_Movimento,
				  :lvdc_Valor_Juros,
				  :lvdc_Valor_Desconto,
				  :lvdc_Valor_Despesas,
				  'N',   
				  :ps_Responsavel,
				  :ps_Historico,
				  :pl_Filial_Movto);
		
		If SqlCa.SqlCode = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do movimento de estorno de abertura do t$$HEX1$$ed00$$ENDHEX$$tulo." + SqlCa.SqlErrText, StopSign!, Ok!)
			lvb_Retorno = False
		Else
			
			Update titulo_receber
			Set vl_aberto             = 0.00,
				 vl_recebido           = 0.00,
				 vl_juros_recebidos    = 0.00,
				 vl_desconto_concedido = 0.00,
				 vl_despesas_recebidas = 0.00,
				 dh_baixa              = :pdh_Data_Movimento,
				 id_situacao           = 'E'
			Where nr_titulo = :ps_Titulo;
			
			If SqlCa.SqlCode = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do t$$HEX1$$ed00$$ENDHEX$$tulo." + SqlCa.SqlErrText, StopSign!, Ok!)
				lvb_Retorno = False				
			Else
				Update movimento_titulo_receber
				Set id_estorno = 'S'
				Where nr_titulo           = :ps_Titulo
				  and cd_filial_movimento = :lvl_Filial_Abertura
				  and nr_movimento        = 1;
				  
				If SqlCa.SqlCode = -1 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do movimento de abertura do t$$HEX1$$ed00$$ENDHEX$$tulo." + SqlCa.SqlErrText, StopSign!, Ok!)
					lvb_Retorno = False				
				Else
					lvb_Retorno = True
				End If		  
			End If			
		End If				
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do t$$HEX1$$ed00$$ENDHEX$$tulo '" + ps_Titulo + "'." + SqlCa.SqlErrText, StopSign!, Ok!)
		lvb_Retorno = False		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "T$$HEX1$$ed00$$ENDHEX$$tulo '" + ps_Titulo + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", Information!, Ok!)
		lvb_Retorno = False
End Choose

Return lvb_Retorno
end function

public function string of_insere_titulo_conta_corrente (long pl_filial, string ps_cliente, long pl_portador, string ps_nr_titulo_banco, date pdt_vencimento, decimal pdc_valor_nominal, decimal pdc_saldo_anterior, string ps_carne_bloqueto, date pdt_venda_inicial, date pdt_venda_final, string ps_responsavel, string ps_tipo_titulo, datetime pdh_movimento);Boolean lvb_Chave_Duplicada = False

String 	lvs_Titulo, &
         	lvs_Historico

DateTime lvdth_Data_Atual

Long 	lvl_Recibo

Integer	lvi_Tipo_Movimento

lvs_Titulo = of_Proximo_Titulo(pl_Filial)

lvdth_Data_Atual = DateTime(Today(), Time('00:00') )

Insert Into titulo_receber (cd_filial,   
								    nr_titulo,   
								    cd_portador,
									 nr_titulo_banco,
								    cd_cliente,   
								    dh_emissao,   
								    dh_vencimento,									 
									 dh_calculo_juros,
								    vl_nominal,   
								    vl_juros_recebidos,   
								    vl_desconto_concedido,   
								    vl_despesas_recebidas,   
								    vl_despesas_pagas,
								    vl_recebido,   
								    id_situacao,   
								    id_carne_bloqueto,
								    id_protesto,   
								    vl_aberto,
								    dh_venda_inicial,
								    dh_venda_final,
								    id_tipo_titulo)  
Values (:pl_Filial,   
		  :lvs_Titulo,   
		  :pl_Portador,
		  :ps_Nr_Titulo_Banco,
		  :ps_Cliente,   
		  :lvdth_Data_Atual,   
		  :pdt_Vencimento,   
		  :pdt_Vencimento,	  
		  :pdc_Valor_Nominal,   
		  000.00,   
		  000.00,   
		  000.00,   
		  000.00,   
		  000.00,
		  'A',   
		  :ps_Carne_Bloqueto,   
		  'N',   
		  :pdc_Valor_Nominal,			
		  :pdt_Venda_Inicial,
		  :pdt_Venda_Final,
		  :ps_Tipo_Titulo);

If SqlCa.SqlCode = -1 Then
	Choose Case Upper(gvo_Aplicacao.ivs_DataBase)	
		Case "SYBASE"
			If SqlCa.SqldbCode = 2601 Then lvb_Chave_Duplicada = True		
		Case "ANYWHERE"		
			If SqlCa.SqldbCode = -193 Then lvb_Chave_Duplicada = True
	End Choose

	// Resgistro j$$HEX1$$e100$$ENDHEX$$ existe na tabela	
	If lvb_Chave_Duplicada Then
		
		gf_Delay(3)		
		ivi_Cont_Excecao ++
		
		If ivi_Cont_Excecao < 3 Then
			This.of_Insere_Titulo_Conta_Corrente(	pl_Filial, ps_Cliente, pl_Portador, ps_Nr_Titulo_Banco, pdt_Vencimento, pdc_Valor_Nominal, &
																pdc_Saldo_Anterior, ps_Carne_Bloqueto, pdt_Venda_Inicial, pdt_Venda_Final, ps_Responsavel, &
																ps_Tipo_Titulo, pdh_Movimento )
		End If
	End If
	
	ivi_Cont_Excecao = 1	
	SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do T$$HEX1$$ed00$$ENDHEX$$tulo de Conta Corrente")
	
	Return ""
Else

	lvi_Tipo_Movimento = of_Movto_Abertura()
	
	SetNull(lvs_Historico)
	SetNull(lvl_Recibo)
	
	If of_Insere_Movimento(	lvs_Titulo, &
	                      				lvi_Tipo_Movimento, &
								  	pdh_Movimento, &
								  	pdh_Movimento, &
								  	pdc_Valor_Nominal, &
								  	0.00, &
								  	0.00, &
								  	0.00, &
									0.00, &
								  	'N', &
								  	ps_Responsavel, &
								  	lvs_Historico, &
								  	lvl_Recibo, &
								  	pl_Filial) Then
							 
		Return lvs_Titulo			
	Else
		Return ""
	End If
End If
end function

public function string of_proximo_titulo (long pl_filial);String		lvs_Ultimo_Titulo, &
       		lvs_Proximo_Titulo
		 
Long	lvl_Nr_Titulo		 

Select max(nr_titulo) Into :lvs_Ultimo_Titulo
From titulo_receber
Where cd_filial = :pl_filial
Using SqlCa;

If SqlCa.SqlCode <> -1 Then	
	If IsNull(lvs_Ultimo_Titulo) Then
		lvs_Proximo_Titulo = String(pl_filial,'0000') + '000000100'  
	Else
		lvl_Nr_Titulo      = Long(MidA(lvs_Ultimo_Titulo,5,7))
		lvl_Nr_Titulo ++
		lvs_Proximo_Titulo = String(pl_filial,'0000') + String( lvl_Nr_Titulo , '0000000' ) + '00'
	End If		
Else	
	SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o do Pr$$HEX1$$f300$$ENDHEX$$ximo T$$HEX1$$ed00$$ENDHEX$$tulo $$HEX1$$e000$$ENDHEX$$ Receber")
End If	

SqlCa.of_Commit()

Return lvs_Proximo_Titulo
end function

public function boolean of_insere_movimento (string ps_titulo, integer pi_tipo_movimento, datetime pdh_data_movimento, datetime pdh_data_credito, decimal pdc_valor_movimento, decimal pdc_valor_multa, decimal pdc_valor_juros, decimal pdc_valor_desconto, decimal pdc_valor_despesas, string ps_estorno, string ps_responsavel, string ps_historico, long pl_recibo, long pl_filial_movto);Integer lvi_Movto

String lvs_Recibo

If Not This.of_Proximo_Movimento(ps_Titulo, pl_Filial_Movto, ref lvi_Movto) Then
	Return False
End If

pdc_valor_movimento = round(pdc_valor_movimento,2)

ivl_nr_movimento = lvi_Movto
lvs_Recibo = String(pl_Recibo)

Insert Into movimento_titulo_receber (nr_titulo,
                                      				  nr_movimento,
												  cd_tipo_movimento,   
												  dh_movimento,   
												  dh_sistema,   
												  dh_credito,   
												  vl_movimento,   
												  vl_multa_recebida,
												  vl_juros_recebidos,   
												  vl_desconto_concedido,   
												  vl_despesas_recebidas,
												  id_estorno,   
												  nr_matricula_responsavel,   
												  de_historico,
												  nr_recibo_cobranca,
												  cd_filial_movimento)
Values (	:ps_Titulo,  
        		:lvi_Movto,
		  	:pi_Tipo_Movimento,
			:pdh_Data_Movimento,  
			getdate(),  
			:pdh_Data_Credito,
			:pdc_Valor_Movimento,
			:pdc_valor_multa,
			:pdc_Valor_Juros,
			:pdc_Valor_Desconto,
			:pdc_Valor_Despesas,
			:ps_Estorno,   
			:ps_Responsavel,
			:ps_Historico,
			:lvs_Recibo,
			:pl_Filial_Movto)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Sqlca.of_RollBack()
	SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Movimento do T$$HEX1$$ed00$$ENDHEX$$tulo")
	Return False
End If

Return True
end function

public function boolean of_valida_emails (string ps_email, ref string ps_emails_incorretos[]);String lvs_Email
String lvs_Mensagem
Integer lvi_Next = 1

ps_emails_incorretos = {""}

ps_email = gf_replace(ps_email, '~r~n','',0)
ps_email = gf_replace(ps_email, '~n','',0)

//Enquanto houver ";"
Do While Pos(ps_email, ";") > 0
	//Captura o email existente at$$HEX1$$e900$$ENDHEX$$ o pr$$HEX1$$f300$$ENDHEX$$ximo ";"
	lvs_Email = Trim(Mid(ps_email, 1, Pos(ps_email, ";") - 1))
	//Verifica se email n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ vazio
	If Trim(lvs_Email)<>"" Then
		If Not gf_valida_email(lvs_Email, False, lvs_Mensagem) Then
			ps_emails_incorretos [ lvi_Next ] = lvs_Email
			lvi_Next ++
		End If
	End If
	//Exclui o email j$$HEX1$$e100$$ENDHEX$$ adicionado no array da vari$$HEX1$$e100$$ENDHEX$$vel
	ps_email = Mid(ps_email, Pos(ps_email, ";") + 1)
Loop

//Armazena o valor restante na vari$$HEX1$$e100$$ENDHEX$$vel pois pode acontecer de n$$HEX1$$e300$$ENDHEX$$o ter nenhum ";"
If Trim(ps_email) <> "" Then
	If Not gf_valida_email(Trim(lvs_Email), False, lvs_Mensagem) Then
		ps_emails_incorretos [ lvi_Next ] = Trim(ps_email)
	End If
End If

Return Not (lvi_Next > 1)
end function

public function boolean of_notifica_faturas_convenio_vencidas (long pl_dias);String lvs_Titulo
String lvs_Razao
String lvs_Fantasia
String lvs_CNPJ
String lvs_Email
String lvs_Emails_Incorretos[]
String lvs_Msg_Email

Long lvl_Convenio

Datetime lvdh_Vencto

Decimal{2} lvdc_Valor

s_email lst_email

/*Utiliza$$HEX2$$e700e300$$ENDHEX$$o do cursor com SQL fixo*/
DECLARE lcu_titulo CURSOR FOR
select t.nr_titulo, t.cd_convenio, cv.nm_razao_social, cv.nm_fantasia, cv.nr_cgc, cv.de_endereco_email, t.dh_vencimento, t.vl_aberto 
from titulo_receber t
inner join convenio cv
	on cv.cd_convenio = t.cd_convenio
Where t.id_situacao = 'A'
	and coalesce(t.id_perdas_lucros,'N')='N'
	and t.dh_vencimento = cast(dateadd(dd, 0 - :pl_dias, getdate()) as date)
	and t.vl_aberto > 0
	and t.dh_baixa is null
	and coalesce(cv.id_notificacao_cobranca,'S') = 'S'
	and rtrim(coalesce(cv.de_endereco_email,''))<>''
Using SQLCa;

Open(w_aguarde)
w_aguarde.Title = 'Enviando emails t$$HEX1$$ed00$$ENDHEX$$tulos conv$$HEX1$$ea00$$ENDHEX$$nio vencidos...'
// Abrindo o cursor
OPEN lcu_titulo;

// Buscar a primeira linha do resultado
FETCH lcu_titulo INTO :lvs_Titulo, :lvl_Convenio, :lvs_Razao, :lvs_Fantasia, :lvs_CNPJ, :lvs_Email, :lvdh_Vencto, :lvdc_Valor;

lst_email.pb_assinatura = False
lst_email.pb_nao_formata = True

// Repetir Enquanto Houver Linhas
DO WHILE SQLCA.SQLCode = 0	
	If Not This.of_valida_emails(lvs_Email, ref lvs_Emails_Incorretos) Then
		lvs_Msg_Email = gf_formata_email_email_invalido(lvl_Convenio, lvs_Razao, lvs_Email)
		gf_ge202_envia_email_automatico(132, "Email Incorreto", lvs_Msg_Email)
	Else
		lvs_Msg_Email = gf_formata_email_vencimento_titulo(2, lvs_Razao, lvs_Titulo, lvdc_Valor, lvdh_Vencto)
		lst_email.ps_to = {''}
		lst_email.ps_assunto = 'T$$HEX1$$ed00$$ENDHEX$$tulo Vencido'
		lst_email.ps_mensagem = lvs_Msg_Email
		lst_email.ps_to [1] = lvs_Email
		gf_ge202_envia_email_padrao(132, lst_email, False)
	End If
	
	//Busca pr$$HEX1$$f300$$ENDHEX$$ximo valor
	FETCH lcu_titulo INTO :lvs_Titulo, :lvl_Convenio, :lvs_Razao, :lvs_Fantasia, :lvs_CNPJ, :lvs_Email, :lvdh_Vencto, :lvdc_Valor;
LOOP

// No fim fechar o cursor
CLOSE lcu_titulo;
Close(w_aguarde)

Return True
end function

public function boolean of_notifica_faturas_convenio_a_vencer (long pl_dias);String lvs_Titulo
String lvs_Razao
String lvs_Fantasia
String lvs_CNPJ
String lvs_Email
String lvs_Emails_Incorretos[]
String lvs_Msg_Email

Long lvl_Convenio

Datetime lvdh_Vencto

Decimal{2} lvdc_Valor

s_email lst_email

/*Utiliza$$HEX2$$e700e300$$ENDHEX$$o do cursor com SQL fixo*/
DECLARE lcu_titulo CURSOR FOR
select t.nr_titulo, t.cd_convenio, cv.nm_razao_social, cv.nm_fantasia, cv.nr_cgc, cv.de_endereco_email, t.dh_vencimento, t.vl_aberto 
from titulo_receber t
inner join convenio cv
	on cv.cd_convenio = t.cd_convenio
Where t.id_situacao = 'A'
	and coalesce(t.id_perdas_lucros,'N')='N'
	and t.dh_vencimento = cast(dateadd(dd, :pl_dias, getdate()) as date)
	and t.vl_aberto > 0
	and coalesce(cv.id_notificacao_cobranca,'S') = 'S'
	and rtrim(coalesce(cv.de_endereco_email,''))<>''
Using SQLCa;

Open(w_aguarde)
w_aguarde.Title = 'Enviando emails t$$HEX1$$ed00$$ENDHEX$$tulos pr$$HEX1$$f300$$ENDHEX$$ximos ao vencimento...'
// Abrindo o cursor
OPEN lcu_titulo;

// Buscar a primeira linha do resultado
FETCH lcu_titulo INTO :lvs_Titulo, :lvl_Convenio, :lvs_Razao, :lvs_Fantasia, :lvs_CNPJ, :lvs_Email, :lvdh_Vencto, :lvdc_Valor;

lst_email.pb_assinatura = False
lst_email.pb_nao_formata = True

// Repetir Enquanto Houver Linhas
DO WHILE SQLCA.SQLCode = 0	
	If Not This.of_valida_emails(lvs_Email, ref lvs_Emails_Incorretos) Then
		lvs_Msg_Email = gf_formata_email_email_invalido(lvl_Convenio, lvs_Razao, lvs_Email)
		gf_ge202_envia_email_automatico(131, "Email Incorreto", lvs_Msg_Email)
	Else
		lvs_Msg_Email = gf_formata_email_vencimento_titulo(1, lvs_Razao, lvs_Titulo, lvdc_Valor, lvdh_Vencto)
		lst_email.ps_to = {''}
		lst_email.ps_assunto = 'T$$HEX1$$ed00$$ENDHEX$$tulo Pr$$HEX1$$f300$$ENDHEX$$ximo do Vencimento'
		lst_email.ps_mensagem = lvs_Msg_Email
		lst_email.ps_to [1] = lvs_Email
		gf_ge202_envia_email_padrao(131, lst_email, False)
	End If
	
	//Busca pr$$HEX1$$f300$$ENDHEX$$ximo valor
	FETCH lcu_titulo INTO :lvs_Titulo, :lvl_Convenio, :lvs_Razao, :lvs_Fantasia, :lvs_CNPJ, :lvs_Email, :lvdh_Vencto, :lvdc_Valor;
LOOP

// No fim fechar o cursor
CLOSE lcu_titulo;
Close(w_aguarde)

Return True
end function

public function boolean of_insere_titulo_clube (long al_filial, long al_nf, string as_especie, string as_serie, datetime adh_datahora, string as_cliente, string as_responsavel, string as_caixa, long al_proximo_titulo, string as_forma_pagamento);String lvs_Chave_NF, &
       lvs_Titulo, &
		 lvs_Historico, &
		 lvs_Recibo, &
	 	 lvs_cliente

Long lvl_Recibo, &
	  lvl_Condicao, &
	  lvl_Portador
	  
Integer lvi_Tipo_Movimento

Date lvd_Data_Atual

DateTime lvdth_Data_Atual_Hora, &
         lvdh_Vencimento

Decimal{2} lvdc_total_avista

lvs_Chave_NF = "Nota Fiscal (" + String(al_Filial) + "-" + String(al_NF) + "-" + as_Especie + "-" + as_Serie + ")~r~r"

Select n.cd_cliente, 
       n.cd_condicao_crediario, 
		 n.vl_pago_avista,
		 c.cd_portador
Into :lvs_Cliente, 
     :lvl_Condicao, 
	  :lvdc_Total_AVista,
	  :lvl_Portador
From nf_venda n
	Join cliente c on c.cd_cliente = n.cd_cliente
Where n.cd_filial  = :al_Filial
  and n.nr_nf      = :al_NF
  and n.de_especie = :as_Especie
  and n.de_serie   = :as_Serie
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		Sqlca.of_RollBack()
		SqlCa.of_MsgdbError(lvs_Chave_NF + "Localiza$$HEX2$$e700e300$$ENDHEX$$o dos Dados para Inclus$$HEX1$$e300$$ENDHEX$$o do T$$HEX1$$ed00$$ENDHEX$$tulo a Receber")
		Return False
		
	Case 100
		Sqlca.of_MsgDBError( lvs_Chave_NF + "Dados para inclus$$HEX1$$e300$$ENDHEX$$o do t$$HEX1$$ed00$$ENDHEX$$tulo a receber n$$HEX1$$e300$$ENDHEX$$o foram localizados." )
		Return False		
End Choose

SetNull(lvs_Historico)
SetNull(lvl_Recibo)

lvdth_Data_Atual_Hora = adh_datahora
lvd_data_atual        = Date(adh_datahora)
//
IF SQLCA.SQLCode = -1 THEN
	SqlCa.of_MsgdbError()
	RETURN FALSE
END IF 
//
lvs_Titulo = String(al_Filial, "0000") + String(al_Proximo_Titulo, "0000000") + "00"
//
lvdh_vencimento    = lvdth_Data_Atual_Hora
//
Insert Into titulo_receber (cd_filial,   
									 nr_titulo,   
									 cd_cliente, 
									 cd_portador,
									 dh_emissao,   
									 dh_vencimento,									 
									 dh_calculo_juros,
									 vl_nominal,   
									 vl_juros_recebidos,   
									 vl_desconto_concedido,   
									 vl_despesas_recebidas,   
									 vl_despesas_pagas,
									 vl_recebido,   
									 id_situacao,   
									 id_carne_bloqueto,
									 id_protesto,   
									 vl_aberto,
									 id_tipo_titulo,
									 cd_filial_nf,
									 nr_nf,
									 de_especie,
									 de_serie)  
Values (:al_Filial,   
		  :lvs_Titulo,   
		  :lvs_cliente,
		  :lvl_portador,   
		  :lvdth_Data_Atual_Hora,   
		  :lvdh_Vencimento,   
		  :lvdh_Vencimento,	  
		  :lvdc_total_avista,   
		  000.00,   
		  000.00,   
		  000.00,   
		  000.00,   
		  000.00,
		  'A',   
		  'N',   
		  'N',   
		  :lvdc_total_avista,			
		  'CC',
		  :al_Filial,
		  :al_NF,
		  :as_especie,
		  :as_serie);

If SqlCa.SqlCode = -1 Then
	Sqlca.of_RollBack()
	Sqlca.of_MsgDBError( "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do t$$HEX1$$ed00$$ENDHEX$$tulo." )
	Return FALSE
End If
//
lvi_Tipo_Movimento = of_Movto_Abertura()
//
If NOT of_Insere_Movimento(lvs_Titulo, &
								  lvi_Tipo_Movimento, &
								  lvdth_Data_Atual_Hora, &
								  lvdth_Data_Atual_Hora, &
								  lvdc_total_avista, &
								  0.00, &
								  0.00, &
								  0.00, &
								  0.00, &
								  'N', &
								  as_Responsavel, &
								  lvs_Historico, &
								  lvl_Recibo, &
								  al_Filial) THEN RETURN FALSE
//
lvi_Tipo_Movimento = of_Movto_Pagto()
//
If NOT of_Insere_Movimento(lvs_Titulo, &
								  lvi_Tipo_Movimento, &
								  lvdth_Data_Atual_Hora, &
								  lvdth_Data_Atual_Hora, &
								  lvdc_total_avista, &
								  0.00, &
								  0.00, &
								  0.00, &
								  0.00, &
								  'N', &
								  as_Responsavel, &
								  lvs_Historico, &
								  lvl_Recibo, &
								  al_Filial) THEN RETURN FALSE
//
UO_CONTROLE_CAIXA lvo_controle_caixa
lvo_controle_caixa = Create UO_CONTROLE_CAIXA
//
lvs_recibo = lvo_controle_caixa.of_insere_recibo_nf_clube_parcial (	al_Filial				, &
																						adh_datahora       , &
																						lvdc_total_avista	, &
																						0.00					, &
																						0.00					, &
																						lvdc_total_avista	, &
																						as_responsavel		, &
																						lvs_titulo				, &
																						al_Filial				, & 
																						al_NF					, &
																						as_especie			, &
																						as_serie				, &
																						as_caixa				, &
																						as_cliente			, &
																						as_forma_pagamento)
				//
Destroy lvo_controle_caixa
//
If lvs_recibo = "" Then
	Return False
End If
//


// Atualiza no movimento o n$$HEX1$$fa00$$ENDHEX$$mero do recibo gerado
Update movimento_titulo_receber
	Set nr_recibo_cobranca = :lvs_recibo
 Where nr_titulo = :lvs_titulo AND
		 nr_movimento = :ivl_nr_movimento ;
//
If SQLCA.SQLCode = -1 Then
	Sqlca.of_RollBack()
	SqlCa.of_MsgdbError()
	Return False
End If
// Atualiza o n$$HEX1$$fa00$$ENDHEX$$mero do recibo gerado em uma vari$$HEX1$$e100$$ENDHEX$$vel de inst$$HEX1$$e200$$ENDHEX$$ncia, para poder
// ser lido caso necess$$HEX1$$e100$$ENDHEX$$rio
ivs_recibo_cobranca = lvs_recibo
//
//
RETURN TRUE
//
end function

public function boolean of_insere_titulo_convenio (long al_filial, long al_nf, string as_especie, string as_serie, datetime adh_datahora, string as_conveniado, string as_responsavel, string as_caixa, long al_proximo_titulo, long al_conta_parcial, string as_forma_pagamento);String lvs_Chave_NF, &
       lvs_Titulo, &
		 lvs_Historico, &
		 lvs_Recibo

Long lvl_Recibo, &
	  lvl_Condicao, &
	  lvl_Convenio, &
	  lvl_Portador
	  
Integer lvi_Tipo_Movimento

Date lvd_Data_Atual

DateTime lvdth_Data_Atual_Hora, &
         lvdh_Vencimento

Decimal{2} lvdc_total_avista

lvs_Chave_NF = "Nota Fiscal (" + String(al_Filial) + "-" + String(al_NF) + "-" + as_Especie + "-" + as_Serie + ")~r~r"

Select n.cd_convenio, 
       n.cd_condicao_convenio, 
		 n.vl_pago_avista,
		 c.cd_portador
Into :lvl_Convenio, 
     :lvl_Condicao, 
	  :lvdc_Total_AVista,
	  :lvl_Portador
From nf_venda n,
	  convenio c
Where n.cd_filial  = :al_Filial
  and n.nr_nf      = :al_NF
  and n.de_especie = :as_Especie
  and n.de_serie   = :as_Serie
  and c.cd_convenio = n.cd_convenio
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		Sqlca.of_RollBack()
		SqlCa.of_MsgdbError(lvs_Chave_NF + "Localiza$$HEX2$$e700e300$$ENDHEX$$o dos Dados para Inclus$$HEX1$$e300$$ENDHEX$$o do T$$HEX1$$ed00$$ENDHEX$$tulo a Receber")
		Return False
		
	Case 100
		Sqlca.of_MsgDBError( lvs_Chave_NF + "Dados para inclus$$HEX1$$e300$$ENDHEX$$o do t$$HEX1$$ed00$$ENDHEX$$tulo a receber n$$HEX1$$e300$$ENDHEX$$o foram localizados." )
		Return False		
End Choose

SetNull(lvs_Historico)
SetNull(lvl_Recibo)

lvdth_Data_Atual_Hora = adh_datahora
lvd_data_atual        = Date(adh_datahora)
//
IF SQLCA.SQLCode = -1 THEN
	SqlCa.of_MsgdbError()
	RETURN FALSE
END IF 
//
lvs_Titulo = String(al_Filial, "0000") + String(al_Proximo_Titulo, "0000000") + "00"
//
lvdh_vencimento    = lvdth_Data_Atual_Hora
//
Insert Into titulo_receber (cd_filial,   
									 nr_titulo,   
									 cd_convenio, 
									 cd_portador,
									 dh_emissao,   
									 dh_vencimento,									 
									 dh_calculo_juros,
									 vl_nominal,   
									 vl_juros_recebidos,   
									 vl_desconto_concedido,   
									 vl_despesas_recebidas,   
									 vl_despesas_pagas,
									 vl_recebido,   
									 id_situacao,   
									 id_carne_bloqueto,
									 id_protesto,   
									 vl_aberto,
									 id_tipo_titulo,
									 cd_filial_nf,
									 nr_nf,
									 de_especie,
									 de_serie)  
Values (:al_Filial,   
		  :lvs_Titulo,   
		  :lvl_convenio,
		  :lvl_portador,   
		  :lvdth_Data_Atual_Hora,   
		  :lvdh_Vencimento,   
		  :lvdh_Vencimento,	  
		  :lvdc_total_avista,   
		  000.00,   
		  000.00,   
		  000.00,   
		  000.00,   
		  000.00,
		  'A',   
		  'N',   
		  'N',   
		  :lvdc_total_avista,			
		  'CV',
		  :al_Filial,
		  :al_NF,
		  :as_especie,
		  :as_serie);

If SqlCa.SqlCode = -1 Then
	Sqlca.of_RollBack()
	Sqlca.of_MsgDBError( "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do t$$HEX1$$ed00$$ENDHEX$$tulo." )
	Return FALSE
End If
//
lvi_Tipo_Movimento = of_Movto_Abertura()
//
If NOT of_Insere_Movimento(lvs_Titulo, &
								  lvi_Tipo_Movimento, &
								  lvdth_Data_Atual_Hora, &
								  lvdth_Data_Atual_Hora, &
								  lvdc_total_avista, &
								  0.00, &
								  0.00, &
								  0.00, &
								  0.00, &
								  'N', &
								  as_Responsavel, &
								  lvs_Historico, &
								  lvl_Recibo, &
								  al_Filial) THEN RETURN FALSE
//
lvi_Tipo_Movimento = of_Movto_Pagto()
//
If NOT of_Insere_Movimento(lvs_Titulo, &
								  lvi_Tipo_Movimento, &
								  lvdth_Data_Atual_Hora, &
								  lvdth_Data_Atual_Hora, &
								  lvdc_total_avista, &
								  0.00, &
								  0.00, &
								  0.00, &
								  0.00, &
								  'N', &
								  as_Responsavel, &
								  lvs_Historico, &
								  lvl_Recibo, &
								  al_Filial) THEN RETURN FALSE
//
UO_CONTROLE_CAIXA lvo_controle_caixa
lvo_controle_caixa = Create UO_CONTROLE_CAIXA
//
lvs_recibo = lvo_controle_caixa.of_insere_recibo_nf_convenio_parcial (	al_Filial				, &
																							adh_datahora		, &
																							lvdc_total_avista	, &
																							0.00					, &
																							0.00					, &
																							lvdc_total_avista	, &
																							as_responsavel		, &
																							lvs_titulo				, &
																							al_Filial				, & 
																							al_NF					, &
																							as_especie			, &
																							as_serie				, &
																							as_caixa				, &
																							as_conveniado		, &
																							al_conta_parcial	, &
																							as_forma_pagamento)
//
Destroy lvo_controle_caixa
//
If lvs_recibo = "" Then
	Return False
End If
//


// Atualiza no movimento o n$$HEX1$$fa00$$ENDHEX$$mero do recibo gerado
Update movimento_titulo_receber
	Set nr_recibo_cobranca = :lvs_recibo
 Where nr_titulo = :lvs_titulo AND
		 nr_movimento = :ivl_nr_movimento ;
//
If SQLCA.SQLCode = -1 Then
	Sqlca.of_RollBack()	
	SqlCa.of_MsgdbError()
	Return False
End If
// Atualiza o n$$HEX1$$fa00$$ENDHEX$$mero do recibo gerado em uma vari$$HEX1$$e100$$ENDHEX$$vel de inst$$HEX1$$e200$$ENDHEX$$ncia, para poder
// ser lido caso necess$$HEX1$$e100$$ENDHEX$$rio
ivs_recibo_cobranca = lvs_recibo
//
//
RETURN TRUE
//
end function

public function boolean of_insere_titulos_crediario (long al_filial, long al_nf, string as_especie, string as_serie, datetime adh_datahora, string as_responsavel, string as_caixa, long al_proximo_titulo, string as_forma_pagamento);String 	lvs_Chave_NF, &
			lvs_Titulo, &
			lvs_Historico, &
			lvs_Cliente, &
			lvs_Recibo, &
			lvs_Forma_Pagto_AV
		 
Long lvl_Recibo, &
     lvl_Row, &
	  lvl_Portador, &
	  lvl_Condicao, &
     lvl_Max
	  
Integer lvi_Movto_Abertura, &
        lvi_Movto_Pagto

Date lvd_data_atual

DateTime lvdth_Data_Atual_Hora, &
         lvdh_Vencimento

Decimal{2} lvdc_Valor_Nominal, &
           lvdc_Total_NF

lvs_Chave_NF = "Nota Fiscal (" + String(al_Filial) + "-" + String(al_NF) + "-" + as_Especie + "-" + as_Serie + ")~r~r"

Select n.cd_cliente, 
       n.cd_condicao_crediario, 
	   n.vl_total_nf,
	   c.cd_portador
Into :lvs_Cliente, 
     :lvl_Condicao, 
	 :lvdc_Total_NF,
	 :lvl_Portador
From nf_venda n,
	  cliente c
Where n.cd_filial  = :al_Filial
  and n.nr_nf      = :al_NF
  and n.de_especie = :as_Especie
  and n.de_serie   = :as_Serie
  and c.cd_cliente = n.cd_cliente
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		Sqlca.of_RollBack()
		SqlCa.of_MsgdbError(lvs_Chave_NF + "Localiza$$HEX2$$e700e300$$ENDHEX$$o dos Dados para Inclus$$HEX1$$e300$$ENDHEX$$o dos T$$HEX1$$ed00$$ENDHEX$$tulos de Credi$$HEX1$$e100$$ENDHEX$$rio")
		Return False
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Chave_NF + "Dados para inclus$$HEX1$$e300$$ENDHEX$$o dos t$$HEX1$$ed00$$ENDHEX$$tulos de credi$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o foram localizados.", StopSign!)
		Return False		
End Choose

SetNull(lvs_Historico)
SetNull(lvl_Recibo)

lvdth_Data_Atual_Hora	= adh_DataHora
lvd_data_atual				= Date(adh_DataHora)

// Parcelas $$HEX1$$e900$$ENDHEX$$ uma vari$$HEX1$$e100$$ENDHEX$$vel de inst$$HEX1$$e200$$ENDHEX$$ncia porque a tela de vendas utiliza esta 
// datawindow para imprimir os valores no cupom fiscal 
ids_parcelas.DataObject = "dw_parcelas_condicao_pagamento"
ids_parcelas.SetTransObject(SqlCa)
//
lvl_max = ids_parcelas.Retrieve(lvl_condicao, STRING(lvdc_total_nf), lvd_data_atual, 0)
//
IF lvl_max < 0 THEN 
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao ler parcelas da Condi$$HEX2$$e700e300$$ENDHEX$$o de Pagamento "+STRING(lvl_condicao), StopSign!)	
	RETURN FALSE
ELSEIF lvl_max = 0 THEN
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Parcelas n$$HEX1$$e300$$ENDHEX$$o encontradas para Condi$$HEX2$$e700e300$$ENDHEX$$o de Pagamento "+STRING(lvl_condicao), StopSign!)
	RETURN FALSE
END IF
//
lvi_Movto_Abertura = of_Movto_Abertura()
lvi_Movto_Pagto    = of_Movto_Pagto()

lvs_Titulo = String(al_Filial, "0000") + String(al_Proximo_Titulo, "0000000") + "00"
//
FOR lvl_row = 1 TO lvl_max
	//	Se for gerado mais de uma parcela o n$$HEX1$$fa00$$ENDHEX$$mero final do t$$HEX1$$ed00$$ENDHEX$$tulo deve ser referente a parcela
	If lvl_max > 1 Then
		lvs_titulo = MidA(lvs_titulo,1,11) + String(lvl_row,"00")
	End If
	//
	ivs_nr_titulo [lvl_row]  = lvs_titulo	
	//
	lvdc_valor_nominal = ids_parcelas.GetItemDecimal (lvl_row, "c_valor_final_parc")
	lvdh_vencimento    = ids_parcelas.GetItemDateTime(lvl_row, "c_data_venc")
	//
	If Date(lvdh_vencimento) = lvd_data_atual Then
		This.ib_imprime_recibo = True
	Else
		This.ib_imprime_recibo = False
	End If	
	
	Insert Into titulo_receber (cd_filial,   
										 nr_titulo,   
										 cd_portador,
										 cd_cliente,   
										 dh_emissao,   
										 dh_vencimento,									 
										 dh_calculo_juros,
										 vl_nominal,   
										 vl_juros_recebidos,   
										 vl_desconto_concedido,   
										 vl_despesas_recebidas,   
										 vl_despesas_pagas,
										 vl_recebido,   
										 id_situacao,   
										 id_carne_bloqueto,
										 id_protesto,   
										 vl_aberto,
										 id_tipo_titulo,
										 cd_filial_nf,
										 nr_nf,
										 de_especie,
										 de_serie)  
	Values (:al_Filial,   
			  :lvs_Titulo,   
			  :lvl_Portador,   
			  :lvs_cliente,   
			  :lvdth_Data_Atual_Hora,   
			  :lvdh_Vencimento,   
			  :lvdh_Vencimento,	  
			  :lvdc_Valor_Nominal,   
			  000.00,   
			  000.00,   
			  000.00,   
			  000.00,   
			  000.00,
			  'A',   
			  'N',   
			  'N',   
			  :lvdc_Valor_Nominal,			
			  'CR',
			  :al_Filial,
			  :al_NF,
			  :as_Especie,
			  :as_Serie);

	If SqlCa.SqlCode = -1 Then
		Sqlca.of_RollBack()
		Sqlca.of_MsgDBError("Erro na inclus$$HEX1$$e300$$ENDHEX$$o do t$$HEX1$$ed00$$ENDHEX$$tulo.")
		Return FALSE
	End If
	
	If NOT of_Insere_Movimento(lvs_Titulo, &
									  lvi_Movto_Abertura, &
									  lvdth_Data_Atual_Hora, &
									  lvdth_Data_Atual_Hora, &
									  lvdc_Valor_Nominal, &
									  0.00, &
									  0.00, &
									  0.00, &
									  0.00, &
									  'N', &
									  as_Responsavel, &
									  lvs_Historico, &
									  lvl_Recibo, &
									  al_Filial) THEN RETURN FALSE
  //
  // Se a primeira parcela for entrada, fazer movimento de pagamento
  IF lvl_row = 1 AND ids_parcelas.GetItemDecimal (lvl_row, "nr_dias_vencimento") = 0 THEN
		lvs_Forma_Pagto_AV = IIF(as_forma_pagamento="CR", "", as_forma_pagamento)
		
		If NOT of_Insere_Movimento(lvs_Titulo, &
									  lvi_Movto_Pagto, &
									  lvdth_Data_Atual_Hora, &
									  lvdth_Data_Atual_Hora, &
									  lvdc_Valor_Nominal, &
									  0.00, &
									  0.00, &
									  0.00, &
									  0.00, &
									  'N', &
									  as_Responsavel, &
									  lvs_Historico, &
									  lvl_Recibo, &
									  al_Filial) THEN RETURN FALSE
		
		UO_CONTROLE_CAIXA lvo_controle_caixa
		lvo_controle_caixa = Create UO_CONTROLE_CAIXA
		//
	 	// Insere o recibo de cobran$$HEX1$$e700$$ENDHEX$$a
		lvs_recibo = lvo_controle_caixa.of_insere_recibo_titulo_crediario (al_Filial       , &
																					 DateTime (Today(), Now())	, &
																					 lvdc_Valor_Nominal			, &
																					 0.00								, &
																					 0.00								, &
																					 lvdc_Valor_Nominal			, &
																					 as_responsavel				, &
																					 lvs_titulo						, &																					 
																					 as_caixa							, &
																					 lvs_Forma_Pagto_AV			, &
																					 0.00)
		
		//
		DESTROY lvo_controle_caixa
		//
		IF lvs_recibo = "" THEN					
			RETURN FALSE
		END IF
		//
	
		
		// Atualiza no movimento o n$$HEX1$$fa00$$ENDHEX$$mero do recibo gerado
		Update movimento_titulo_receber
		   Set nr_recibo_cobranca = :lvs_recibo
		 Where nr_titulo = :lvs_titulo AND
		       nr_movimento = :ivl_nr_movimento ;
		//
		If SQLCA.SQLCode = -1 Then
			Sqlca.of_RollBack()
			SqlCa.of_MsgdbError()
			Return False
		End If
		// Atualiza o n$$HEX1$$fa00$$ENDHEX$$mero do recibo gerado em uma vari$$HEX1$$e100$$ENDHEX$$vel de inst$$HEX1$$e200$$ENDHEX$$ncia, para poder
		// ser lido caso necess$$HEX1$$e100$$ENDHEX$$rio
		ivs_recibo_cobranca = lvs_recibo
		//
  END IF
NEXT
//
RETURN TRUE
//
end function

on uo_titulo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_titulo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_parcelas = CREATE DataStore

SetNull(Nr_Matric_Liberacao_Juros_Desconto)

ivi_Cont_Excecao = 1
end event

event destructor;//
DESTROY ids_parcelas
//
end event

