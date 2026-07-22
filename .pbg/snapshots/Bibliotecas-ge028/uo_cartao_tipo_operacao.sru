HA$PBExportHeader$uo_cartao_tipo_operacao.sru
forward
global type uo_cartao_tipo_operacao from nonvisualobject
end type
end forward

global type uo_cartao_tipo_operacao from nonvisualobject
end type
global uo_cartao_tipo_operacao uo_cartao_tipo_operacao

type variables
long 	ivl_deposito_venda_credito, &
       	ivl_deposito_venda_debito, &
       	ivl_deposito_aluguel_pos, &
       	ivl_deposito_estorno_aluguel_pos, &
       	ivl_deposito_ajuste_credito, &
       	ivl_deposito_ajuste_debito, &
       	ivl_credito_venda_credito, &
       	ivl_credito_venda_debito, &
       	ivl_credito_aluguel_pos, &
       	ivl_credito_estorno_aluguel_pos, &
       	ivl_credito_ajuste_credito, &
       	ivl_credito_ajuste_debito, &
		ivl_aluguel_pinpad, &
		ivl_antecipacao, &
		ivl_desagendamento, &
		ivl_cancelamento, &
		ivl_desagendamento_1
end variables

forward prototypes
public function boolean of_localiza_todos ()
public function boolean of_ajuste_credito (ref long al_tipo, string as_deposito_credito)
public function boolean of_ajuste_debito (ref long al_tipo, string as_deposito_credito)
public function boolean of_aluguel_pos (ref long al_tipo, string as_deposito_credito)
public function boolean of_venda_credito (ref long al_tipo, string as_deposito_credito)
public function boolean of_venda_debito (ref long al_tipo, string as_deposito_credito)
public function boolean of_estorno_aluguel_pos (ref long al_tipo, string as_deposito_credito)
public function boolean of_ajuste_contestacao (ref long al_tipo, string as_deposito_credito)
public function boolean of_aluguel_pinpad (ref long al_tipo, string as_deposito_credito)
public function boolean of_antecipacao (ref long al_tipo, string as_deposito_credito)
public function boolean of_cancelamento (ref long al_tipo, string as_deposito_credito)
end prototypes

public function boolean of_localiza_todos ();Boolean lvb_Sucesso = False

If This.of_Venda_Credito(ref ivl_Deposito_Venda_Credito, "D") Then
	If This.of_Venda_Debito(ref ivl_Deposito_Venda_Debito, "D") Then
		If This.of_Aluguel_POS(ref ivl_Deposito_Aluguel_POS, "D") Then
			If This.of_Estorno_Aluguel_POS(ref ivl_Deposito_Estorno_Aluguel_POS, "D") Then
				If This.of_Ajuste_Credito(ref ivl_Deposito_Ajuste_Credito, "D") Then
					If This.of_Ajuste_Debito(ref ivl_Deposito_Ajuste_Debito, "D") Then
						If This.of_Venda_Credito(ref ivl_Credito_Venda_Credito, "C") Then
							If This.of_Venda_Debito(ref ivl_Credito_Venda_Debito, "C") Then
								If This.of_Aluguel_POS(ref ivl_Credito_Aluguel_POS, "C") Then
									If This.of_Estorno_Aluguel_POS(ref ivl_Credito_Estorno_Aluguel_POS, "C") Then
										If This.of_Ajuste_Credito(ref ivl_Credito_Ajuste_Credito, "C") Then
											If This.of_Ajuste_Debito(ref ivl_Credito_Ajuste_Debito, "C") Then
												If This.of_Ajuste_Contestacao(ref ivl_Desagendamento, "C") Then
													If This.of_Aluguel_PinPad(ref ivl_Aluguel_PinPad, "C") Then
														If This.of_Antecipacao(ref ivl_Antecipacao, "C") Then
															If This.of_Cancelamento(ref ivl_Cancelamento, "C") Then
																If This.of_Ajuste_Contestacao(ref ivl_Desagendamento_1, "D") Then
																	lvb_Sucesso = True
																End If
															End If
														End If
													End If
												End If
											End If
										End If
									End If
								End If
							End If
						End If
					End If
				End If
			End If
		End If
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_ajuste_credito (ref long al_tipo, string as_deposito_credito);Boolean lvb_Sucesso = False

Select cd_tipo_operacao Into :al_Tipo
From cartao_lote_tipo_operacao
Where id_deposito_credito = :as_Deposito_Credito
  and id_ajuste_credito   = 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do movimento de ajuste de cr$$HEX1$$e900$$ENDHEX$$dito n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Tipo do Movimento de Ajuste de Cr$$HEX1$$e900$$ENDHEX$$dito")
End Choose

Return lvb_Sucesso

end function

public function boolean of_ajuste_debito (ref long al_tipo, string as_deposito_credito);Boolean lvb_Sucesso = False

Select cd_tipo_operacao Into :al_Tipo
From cartao_lote_tipo_operacao
Where id_deposito_credito = :as_Deposito_Credito
  and id_ajuste_debito = 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do movimento de ajuste de d$$HEX1$$e900$$ENDHEX$$bito n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Tipo do Movimento de Ajuste de D$$HEX1$$e900$$ENDHEX$$bito")
End Choose

Return lvb_Sucesso

end function

public function boolean of_aluguel_pos (ref long al_tipo, string as_deposito_credito);Boolean lvb_Sucesso = False

Select cd_tipo_operacao Into :al_Tipo
From cartao_lote_tipo_operacao
Where id_deposito_credito = :as_Deposito_Credito
  and id_aluguel_pos = 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do movimento de aluguel de pos n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Tipo do Movimento de Aluguel de POS")
End Choose

Return lvb_Sucesso

end function

public function boolean of_venda_credito (ref long al_tipo, string as_deposito_credito);Boolean lvb_Sucesso = False

Select cd_tipo_operacao Into :al_Tipo
From cartao_lote_tipo_operacao
Where id_deposito_credito = :as_Deposito_Credito
  and id_venda_credito = 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do movimento de venda a cr$$HEX1$$e900$$ENDHEX$$dito n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Tipo do Movimento de Venda a Cr$$HEX1$$e900$$ENDHEX$$dito")
End Choose

Return lvb_Sucesso

end function

public function boolean of_venda_debito (ref long al_tipo, string as_deposito_credito);Boolean lvb_Sucesso = False

Select cd_tipo_operacao Into :al_Tipo
From cartao_lote_tipo_operacao
Where id_deposito_credito = :as_Deposito_Credito
  and id_venda_debito = 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do movimento de venda a d$$HEX1$$e900$$ENDHEX$$bito n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Tipo do Movimento de Venda a D$$HEX1$$e900$$ENDHEX$$bito")
End Choose

Return lvb_Sucesso

end function

public function boolean of_estorno_aluguel_pos (ref long al_tipo, string as_deposito_credito);Boolean lvb_Sucesso = False

Select cd_tipo_operacao Into :al_Tipo
From cartao_lote_tipo_operacao
Where id_deposito_credito = :as_Deposito_Credito
  and id_estorno_aluguel_pos = 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do movimento de estorno de aluguel de pos n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Tipo do Movimento de Estorno de Aluguel de POS")
End Choose

Return lvb_Sucesso

end function

public function boolean of_ajuste_contestacao (ref long al_tipo, string as_deposito_credito);Boolean lvb_Sucesso = False

Select cd_tipo_operacao Into :al_Tipo
From cartao_lote_tipo_operacao
Where id_deposito_credito = :as_Deposito_Credito
  and id_desagendamento   = 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do movimento de desagendamento n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Tipo do Movimento de Desagendamento")
End Choose

Return lvb_Sucesso

end function

public function boolean of_aluguel_pinpad (ref long al_tipo, string as_deposito_credito);Boolean lvb_Sucesso = False

Select cd_tipo_operacao Into :al_Tipo
From cartao_lote_tipo_operacao
Where id_deposito_credito = :as_Deposito_Credito
  and id_aluguel_pinpad = 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do movimento de aluguel de pinpad n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Tipo do Movimento de Aluguel de PINPAD")
End Choose

Return lvb_Sucesso

end function

public function boolean of_antecipacao (ref long al_tipo, string as_deposito_credito);Boolean lvb_Sucesso = False

Select cd_tipo_operacao Into :al_Tipo
From cartao_lote_tipo_operacao
Where id_deposito_credito = :as_Deposito_Credito
  and id_antecipacao   = 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do movimento de antecipa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Tipo do Movimento de Antecipa$$HEX2$$e700e300$$ENDHEX$$o")
End Choose

Return lvb_Sucesso

end function

public function boolean of_cancelamento (ref long al_tipo, string as_deposito_credito);Boolean lvb_Sucesso = False

Select cd_tipo_operacao Into :al_Tipo
From cartao_lote_tipo_operacao
Where id_deposito_credito = :as_Deposito_Credito
  and id_cancelamento   = 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do movimento de cancelamento n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Tipo do Movimento de Cancelamento")
End Choose

Return lvb_Sucesso

end function

on uo_cartao_tipo_operacao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cartao_tipo_operacao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

