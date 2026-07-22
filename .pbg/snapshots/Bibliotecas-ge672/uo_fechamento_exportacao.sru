HA$PBExportHeader$uo_fechamento_exportacao.sru
forward
global type uo_fechamento_exportacao from nonvisualobject
end type
end forward

global type uo_fechamento_exportacao from nonvisualobject
end type
global uo_fechamento_exportacao uo_fechamento_exportacao

type variables
uo_produto 		ivo_produto						//GE001

Decimal vl_Preco_Venda_Produto
Decimal vl_Preco_Clube
end variables

forward prototypes
public function boolean of_data_parametro (ref date adt_data)
public function boolean of_atualiza_vencimento_pontos (date adt_limite, date adt_atual)
public function boolean of_atualiza_utilizacao_pontos (string as_cliente, date adt_limite, double adb_movto, decimal adc_pontos)
public function boolean of_grava_log (integer ai_log, string as_mensagem)
public function boolean of_tipo_movto_vencimento_pontos (ref long al_tipo)
public function boolean of_numero_movto_vencimento (string as_cliente, long al_tipo, datetime adh_movto, ref double adb_movto)
public function boolean of_fechamento_pontuacao_clube ()
public function boolean of_atualiza_pontos_vencidos ()
end prototypes

public function boolean of_data_parametro (ref date adt_data);Boolean lvb_Sucesso = False

DateTime lvdh_Movto

Select dh_movimentacao Into :lvdh_Movto
From parametro
Where id_parametro = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		adt_Data = Date(lvdh_Movto)
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data do par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o localizada.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Data do Par$$HEX1$$e200$$ENDHEX$$metro")
End Choose

Return lvb_Sucesso
end function

public function boolean of_atualiza_vencimento_pontos (date adt_limite, date adt_atual);Boolean	lvb_Sucesso = True

Long	lvl_Total, &
		lvl_Contador, &
		lvl_Tipo_Movto
	  
String	lvs_Cliente, &
		lvs_Historico

Decimal	lvdc_Pontos

Double	lvdb_Movto_Vencimento
		  
// Localiza o tipo do movimento de vencimento de pontos
If Not This.of_Tipo_Movto_Vencimento_Pontos(ref lvl_Tipo_Movto) Then Return False

dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge672_total_pontuacao_vencida") Then
	Destroy(lvds)
	Return False
End If

lvl_Total = lvds.Retrieve(adt_Limite)

If lvl_Total > 0 Then
	
	For lvl_Contador = 1 To lvl_Total
		lvs_Cliente = lvds.Object.Cd_Cliente        [lvl_Contador]
		lvdc_Pontos = lvds.Object.Qt_Pontos_Vencidos[lvl_Contador]
		
		If lvdc_Pontos > 0 Then
			// Lan$$HEX1$$e700$$ENDHEX$$a o movimento de vencimento de pontos
			Insert Into pontuacao_clube_movimento (cd_cliente,   
																dh_movimento,   
																cd_tipo_movimento,   
																vl_movimento,   
																qt_pontos,   
																cd_filial,   
																dh_registro,   
																nr_cartao_clube,   
																cd_dependente_cliente,   
																nr_documento,   
																de_historico,   
																qt_saldo_pontos,   
																id_situacao_pontos)
			Values (:lvs_Cliente,
					  :adt_Atual,
					  :lvl_Tipo_Movto,
					  0,
					  :lvdc_Pontos,
					  534,
					  getdate(),
					  null,
					  null,
					  null,
					  :lvs_Historico,
					  0,
					  'U')
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				gvo_Aplicacao.of_Grava_Log("Erro: of_atualiza_vencimento_pontos" + "Lan$$HEX1$$e700$$ENDHEX$$amento do Movimento de Vencimento de Pontos do Cliente '" + lvs_Cliente + "'.") 
				SqlCa.of_MsgdbError("Lan$$HEX1$$e700$$ENDHEX$$amento do Movimento de Vencimento de Pontos do Cliente '" + lvs_Cliente + "'.")
				lvb_Sucesso = False
				Exit
			End If				
	
			// Localiza o n$$HEX1$$fa00$$ENDHEX$$mero do movimento de vencimento que foi inclu$$HEX1$$ed00$$ENDHEX$$do
			If Not This.of_Numero_Movto_Vencimento(lvs_Cliente, lvl_Tipo_Movto, DateTime(adt_Atual), ref lvdb_Movto_Vencimento) Then
				gvo_Aplicacao.of_Grava_Log("Erro: of_Numero_Movto_Vencimento" + "Localiza o n$$HEX1$$fa00$$ENDHEX$$mero do movimento de vencimento que foi inclu$$HEX1$$ed00$$ENDHEX$$do '" + lvs_Cliente + "'.") 
				lvb_Sucesso = False
				Exit
			End If
			
			// Atualiza o saldo de pontos dos movimentos vencidos
			If Not This.of_Atualiza_Utilizacao_Pontos(lvs_Cliente, adt_Limite, lvdb_Movto_Vencimento, lvdc_Pontos) Then
				gvo_Aplicacao.of_Grava_Log("Erro: of_Atualiza_Utilizacao_Pontos" + "Lan$$HEX1$$e700$$ENDHEX$$amento do Movimento de Vencimento de Pontos do Cliente '" + lvs_Cliente + "'.") 
				lvb_Sucesso = False
				SqlCa.of_RollBack()
				Exit
			End If																
			
			If lvb_Sucesso Then
			   SqlCa.of_Commit()
			Else
			   lvb_Sucesso = True
			End If	

		End If
	Next
End If

Destroy(lvds)

Return lvb_Sucesso
end function

public function boolean of_atualiza_utilizacao_pontos (string as_cliente, date adt_limite, double adb_movto, decimal adc_pontos);Boolean lvb_Sucesso = True

Long	lvl_Total, &
		lvl_Contador
	  
Double	lvdb_Movto

Decimal	lvdc_Saldo, &
			lvdc_Utilizacao_Acumulada

String	lvs_Situacao, &
		lvs_Tipo

dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge672_pontuacao_vencida_cliente") Then
	Destroy(lvds)
	Return False
End If

lvl_Total = lvds.Retrieve(as_Cliente, adt_Limite)

If lvl_Total > 0 Then
	For lvl_Contador = 1 To lvl_Total
		lvdb_Movto = lvds.Object.Nr_Movimento     [lvl_Contador]
		lvdc_Saldo = lvds.Object.Qt_Saldo_Pontos  [lvl_Contador]
		lvs_Tipo   = lvds.Object.Id_Credito_Debito[lvl_Contador]
		
		If lvs_Tipo = "C" Then
			lvdc_Utilizacao_Acumulada += lvdc_Saldo
		Else
			lvdc_Utilizacao_Acumulada -= lvdc_Saldo
		End If
		
		// Atualiza o saldo e a situa$$HEX2$$e700e300$$ENDHEX$$o dos pontos
		Update pontuacao_clube_movimento
		Set qt_saldo_pontos    = 0,
			 id_situacao_pontos = 'V'
		Where nr_movimento = :lvdb_Movto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			gvo_Aplicacao.of_Grava_Log("Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_utilizacao_pontos / Atualiza$$HEX2$$e700e300$$ENDHEX$$o do saldo dos pontos do movimento vencido '" + String(lvdb_Movto) + "' do cliente '" + as_Cliente + "'."  ) 
			SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do saldo dos pontos do movimento vencido '" + String(lvdb_Movto) + "' do cliente '" + as_Cliente + "'.")
			lvb_Sucesso = False
			Exit
		End If	
		
		// Inclui na lista dos movimentos utilizados no resgate
		Insert Into pontuacao_clube_utilizacao (nr_movimento_utilizacao,   
															 nr_movimento_utilizado,
															 qt_pontos)  
		Values (:adb_Movto,
				  :lvdb_Movto,
				  :lvdc_Saldo)
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			gvo_Aplicacao.of_Grava_Log("Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_utilizacao_pontos / Inclus$$HEX1$$e300$$ENDHEX$$o do movimento '" + String(lvdb_Movto) + "' utilizado no vencimento do cliente '" + as_Cliente + "'.")
			SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do movimento '" + String(lvdb_Movto) + "' utilizado no vencimento do cliente '" + as_Cliente + "'.")
			lvb_Sucesso = False
			Exit
		End If	
	Next
	
	If lvb_Sucesso Then
		If lvdc_Utilizacao_Acumulada <> adc_Pontos Then
			gvo_Aplicacao.of_Grava_Log("Erro: of_atualiza_utilizacao_pontos / Utiliza$$HEX2$$e700e300$$ENDHEX$$o acumulada '" + String(lvdc_Utilizacao_Acumulada, "0.00") + "' diferente do total de pontos vencidos '" + String(adc_Pontos, "0.00") + "' do cliente '" + as_Cliente + "'.")
			lvb_Sucesso = False
		End If
	End If
Else
	gvo_Aplicacao.of_Grava_Log("Erro: of_atualiza_utilizacao_pontos / Pontua$$HEX2$$e700e300$$ENDHEX$$o vencida do cliente '" + as_Cliente + "' n$$HEX1$$e300$$ENDHEX$$o localizada para utiliza$$HEX2$$e700e300$$ENDHEX$$o.")
	lvb_Sucesso = False
End If

Destroy(lvds)
Return lvb_Sucesso
end function

public function boolean of_grava_log (integer ai_log, string as_mensagem);Return gf_grava_log_basico(ai_log, as_mensagem)
end function

public function boolean of_tipo_movto_vencimento_pontos (ref long al_tipo);Boolean lvb_Sucesso = False

Select cd_tipo_movimento Into :al_Tipo
From pontuacao_clube_tipo_movimento
Where id_vencimento = 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do movimento de vencimento de pontos n$$HEX1$$e300$$ENDHEX$$o localizado.")
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Tipo do Movimento de Vencimento de Pontos")
End Choose

Return lvb_Sucesso
end function

public function boolean of_numero_movto_vencimento (string as_cliente, long al_tipo, datetime adh_movto, ref double adb_movto);Boolean lvb_Sucesso

Select nr_movimento Into :adb_Movto
From pontuacao_clube_movimento
Where cd_cliente				= :as_Cliente
  and cd_tipo_movimento	= :al_Tipo
  and dh_movimento			= :adh_Movto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$fa00$$ENDHEX$$mero do movimento de vencimento do cliente '" + as_Cliente + "' n$$HEX1$$e300$$ENDHEX$$o localizado.")

	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do n$$HEX1$$fa00$$ENDHEX$$mero do movimento de vencimento do cliente '" + as_Cliente + "'.")
End Choose

Return lvb_Sucesso
end function

public function boolean of_fechamento_pontuacao_clube ();Date	lvdt_Parametro, &
		lvdt_Mes_Anterior, &
		lvdt_Mes_Novo

String	lvs_Mes_Novo

/*
 	Executa o fechamento se a data do par$$HEX1$$e200$$ENDHEX$$metro for maior que a data do $$HEX1$$fa00$$ENDHEX$$ltimo fechamento 
 	Durante a execu$$HEX2$$e700e300$$ENDHEX$$o do fechamento, coloca nulo na data de fechamento para impedir que
 	novos movimentos sejam efetuados (controlado por triggers)
*/

// Localiza a data do par$$HEX1$$e200$$ENDHEX$$metro
If Not This.of_Data_Parametro(ref lvdt_Parametro) Then Return False

lvdt_Mes_Novo = Date("01/" + String(lvdt_Parametro, "mm/yyyy"))

// Localiza a data do $$HEX1$$fa00$$ENDHEX$$ltimo fechamento
uo_Parametro_Geral lvo_Parametro
lvo_Parametro = Create uo_Parametro_Geral

If Not lvo_Parametro.of_Localiza_Parametro("DT_FECHAMENTO_PONTUACAO_CLUBE", ref lvdt_Mes_Anterior) Then
	Destroy(lvo_Parametro)
	Return False
End If

Destroy(lvo_Parametro)

// Verifica se h$$HEX1$$e100$$ENDHEX$$ necessidade de executar o fechamento
If lvdt_Mes_Novo <= lvdt_Mes_Anterior Then Return True

//w_Aguarde.Title = "Executando Fechamento da Pontua$$HEX2$$e700e300$$ENDHEX$$o do Clube..."

gvo_Aplicacao.of_Grava_Log("In$$HEX1$$ed00$$ENDHEX$$cio do Fechamento da Pontua$$HEX2$$e700e300$$ENDHEX$$o do Clube")

// Coloca nulo na data de fechamento para impedir novos movimentos durante o fechamento
Update parametro_geral
Set vl_parametro = null
Where cd_parametro = 'DT_FECHAMENTO_PONTUACAO_CLUBE'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Data de Fechamento da Pontua$$HEX2$$e700e300$$ENDHEX$$o do Clube")
	Return False
Else		
	// Inclui os saldos para o novo m$$HEX1$$ea00$$ENDHEX$$s
	Insert Into pontuacao_clube_saldo (cd_cliente,
												  dh_saldo,  
												  qt_pontos)
	Select cd_cliente,   
			 :lvdt_Mes_Novo,   
			 qt_pontos
	From pontuacao_clube_saldo
	Where dh_saldo = :lvdt_Mes_Anterior
	and qt_pontos <> 0
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		SqlCa.of_RollBack()
		SqlCa.of_MsgdbError("Fechamento da Pontua$$HEX2$$e700e300$$ENDHEX$$o do Clube")
		Return False
	Else
		// Atualiza a nova data de fechamento
		lvs_Mes_Novo = String(lvdt_Mes_Novo, "dd/mm/yyyy")
		
		Update parametro_geral
		Set vl_parametro = :lvs_Mes_Novo
		Where cd_parametro = 'DT_FECHAMENTO_PONTUACAO_CLUBE'
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()
			SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Data de Fechamento da Pontua$$HEX2$$e700e300$$ENDHEX$$o do Clube")
			Return False
		Else
			// Grava Saldo para Liberar as Lojas
			SqlCa.of_Commit()
			gvo_Aplicacao.of_Grava_Log("T$$HEX1$$e900$$ENDHEX$$rmino do Fechamento da Pontua$$HEX2$$e700e300$$ENDHEX$$o do Clube")
			Return True
		End If
	End If
End If


end function

public function boolean of_atualiza_pontos_vencidos ();Boolean lvb_Sucesso

Date	lvdt_Parametro, &
		lvdt_Mes_Anterior, &
		lvdt_Mes_Novo, &
		lvdt_Limite_Vencimento

String lvs_Mes_Novo

// Localiza a data do par$$HEX1$$e200$$ENDHEX$$metro
If Not This.of_Data_Parametro(ref lvdt_Parametro) Then Return False

lvdt_Mes_Novo = Date("01/" + String(lvdt_Parametro, "mm/yyyy"))

// Localiza a data do $$HEX1$$fa00$$ENDHEX$$ltimo fechamento
uo_Parametro_Geral lvo_Parametro
lvo_Parametro = Create uo_Parametro_Geral

If Not lvo_Parametro.of_Localiza_Parametro("DT_ATUALIZACAO_PONTOS_VENCIDOS", ref lvdt_Mes_Anterior) Then
	Destroy(lvo_Parametro)
	Return False
End If

Destroy(lvo_Parametro)

// Verifica se h$$HEX1$$e100$$ENDHEX$$ necessidade de executar a atualizacao
If lvdt_Mes_Novo <= lvdt_Mes_Anterior Then Return False

gvo_Aplicacao.of_Grava_Log("In$$HEX1$$ed00$$ENDHEX$$cio da Atualizacao de Pontos Vencidos")

// Lan$$HEX1$$e700$$ENDHEX$$a os movimentos de vencimento de pontos
lvdt_Limite_Vencimento = RelativeDate(Date(Left(String(lvdt_Mes_Novo, "dd/mm/yyyy"), 6) + String(Year(lvdt_Mes_Novo) - 1)), -1)
			
lvb_Sucesso = This.of_Atualiza_Vencimento_Pontos(lvdt_Limite_Vencimento, lvdt_Parametro)

lvs_Mes_Novo = String(lvdt_Mes_Novo, "dd/mm/yyyy")
		
Update parametro_geral
Set vl_parametro = :lvs_Mes_Novo
Where cd_parametro = 'DT_ATUALIZACAO_PONTOS_VENCIDOS'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	gvo_Aplicacao.of_Grava_Log("Erro: of_atualiza_pontos_vencidos / Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Data de Atualizacao dos Pontos Vencidos")
	SqlCa.of_RollBack()
	SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Data de Atualizacao dos Pontos Vencidos")
	lvb_Sucesso = False
End If

If lvb_Sucesso Then
	SqlCa.of_Commit()
Else
	SqlCa.of_RollBack()
End If

Return lvb_sucesso

gvo_Aplicacao.of_Grava_Log("T$$HEX1$$e900$$ENDHEX$$rmino da Atualizacao de Pontos Vencidos")
end function

on uo_fechamento_exportacao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_fechamento_exportacao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

