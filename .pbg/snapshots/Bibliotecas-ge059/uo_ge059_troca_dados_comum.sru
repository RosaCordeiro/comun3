HA$PBExportHeader$uo_ge059_troca_dados_comum.sru
forward
global type uo_ge059_troca_dados_comum from nonvisualobject
end type
end forward

global type uo_ge059_troca_dados_comum from nonvisualobject
end type
global uo_ge059_troca_dados_comum uo_ge059_troca_dados_comum

type variables
long ivl_Filial_Parametro

string ivs_UF_Filial
end variables

forward prototypes
public function string of_coluna_chave_log (string ps_chave, integer pi_coluna)
public function string of_date (datetime pdh_data)
public function string of_datetime (datetime pdh_data)
public function string of_string (string ps_string, integer pi_tamanho)
public function long of_long (string ps_string)
public function date of_date (string ps_string)
public function datetime of_datetime (string ps_string)
public function boolean of_registro_conta_corrente (string ps_chave, string ps_atualizacao, ref string ps_registro)
public function long of_filial_parametro ()
public function boolean of_atualiza_conta_corrente (string ps_registro, integer pi_log)
public function boolean of_atualiza_conveniado (string ps_registro, integer pi_log)
public function boolean of_atualiza_usuario (string ps_registro, integer pi_log)
public function string of_decimal (decimal pdc_valor, integer pi_tamanho, integer pi_decimal)
public function string of_decimal (decimal pdc_valor, integer pi_tamanho)
public function decimal of_decimal (string ps_valor, integer pi_decimal)
public function decimal of_decimal (string ps_valor)
public function boolean of_registro_titulo_receber (string ps_chave, string ps_atualizacao, ref string ps_registro)
public function boolean of_registro_movimento_titulo_receber (string ps_chave, string ps_atualizacao, ref string ps_registro)
public function boolean of_atualiza_bloqueio (string ps_registro, integer pi_log)
public function boolean of_atualiza_titulo_receber (string ps_registro, integer pi_log)
public function boolean of_atualiza_movimento_titulo_receber (string ps_registro, integer pi_log)
public function boolean of_atualiza_item_nf_transferencia (string ps_registro, integer pi_log)
public function boolean of_verifica_saldo_atual_cc (string ps_conta, ref decimal pdc_saldo_atual)
public function boolean of_verifica_titulos_aberto_cr (string ps_conta, ref decimal pdc_vl_titulos_aberto)
public function boolean of_registro_problema_bloqueio (string ps_chave, string ps_atualizacao, ref string ps_registro)
public function boolean of_registro_problema_titulo_receber (string ps_chave, string ps_atualizacao, ref string ps_registro)
public function boolean of_registro_problema_movimento_titulo_re (string ps_chave, string ps_atualizacao, ref string ps_registro)
public function boolean of_atualiza_problema_bloqueio (string ps_registro, integer pi_log)
public function boolean of_atualiza_problema_titulo_receber (string ps_registro, integer pi_log)
public function boolean of_atualiza_problema_movimento_titulo_re (string ps_registro, integer pi_log)
public function boolean of_verifica_titulo_pago_dia (string ps_titulo, ref integer pi_qt_movimentos)
public function string of_retira_caracter_enter (string ps_string)
public function boolean of_atualiza_cliente_dependente (string ps_registro, integer pi_log)
public function boolean of_registro_bloqueio (string ps_chave, string ps_atualizacao, ref string ps_registro)
public function string of_number_string (long pl_valor, integer pi_tamanho)
public function long of_parametro_filial ()
public function boolean of_registro_cliente_dependente (string ps_chave, string ps_atualizacao, ref string ps_registro)
public function boolean of_registro_item_nf_transferencia (string ps_chave, string ps_atualizacao, ref string ps_registro)
public function boolean of_registro_item_nf_compra_lote (string ps_chave, string ps_atualizacao, ref string ps_registro)
public function boolean of_registro_item_nf_transferencia_lote (string ps_chave, string ps_atualizacao, ref string ps_registro)
public function boolean of_atualiza_item_nf_transferencia_lote (string ps_registro, integer pi_log)
public subroutine of_run (string ps_exe)
public subroutine of_nome_arquivo (string ps_tabela, ref string ps_arquivo)
public function boolean of_exclui_item_nf_compra (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, long al_natope, long al_produto, integer ai_log, string as_chave_log)
public function boolean of_registro_nf_compra (string ps_chave, string ps_atualizacao, ref string ps_registro)
public function boolean of_registro_item_nf_compra (string ps_chave, string ps_atualizacao, ref string ps_registro)
end prototypes

public function string of_coluna_chave_log (string ps_chave, integer pi_coluna);String lvs_Coluna

Integer lvi_Contador, &
        lvi_Posicao = -2, &
        lvi_Start

For lvi_Contador = 1 To pi_Coluna
	lvi_Start = lvi_Posicao + 3
	
	lvi_Posicao = PosA(ps_Chave, "@#!", lvi_Start)
Next

If lvi_Posicao = 0 Then
	lvs_Coluna = MidA(ps_Chave, lvi_Start)
Else
	lvs_Coluna = MidA(ps_Chave, lvi_Start, lvi_Posicao - lvi_Start)
End If

If Trim(lvs_Coluna) = "" Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da coluna '" + String(pi_Coluna) + "' " + &
//	                      "da chave '" + ps_Chave + "'.", StopSign!)
End If

Return lvs_Coluna
end function

public function string of_date (datetime pdh_data);String lvs_String

If Not IsNull(pdh_Data) Then
	lvs_String  = String(pdh_Data, "ddmmyyyy")
Else
	lvs_String = "00000000"
End If

Return lvs_String
end function

public function string of_datetime (datetime pdh_data);String lvs_String

If Not IsNull(pdh_Data) Then
	lvs_String = String(pdh_Data, "ddmmyyyyhhmmss")
Else
	lvs_String = "00000000000000"
End If

Return lvs_String
end function

public function string of_string (string ps_string, integer pi_tamanho);String lvs_String

Integer lvi_Pos

If IsNull(ps_String) Then ps_String = ""

If ps_String <> "" Then
	
	ps_String = This.of_Retira_Caracter_Enter(ps_String)
	
End If

lvs_String = LeftA(ps_String, pi_Tamanho) + Space(pi_Tamanho - LenA(ps_String))

Return lvs_String
end function

public function long of_long (string ps_string);If Not IsNumber(ps_String) Then	
	Return 0
Else
	Return Long(ps_String)
End If
end function

public function date of_date (string ps_string);Date lvdt_Data

String lvs_Data

If ps_String <> "00000000" Then
	lvs_Data = LeftA(ps_String, 2)   + "/" + &
				  MidA(ps_String, 3, 2) + "/" + &
				  MidA(ps_String, 5, 4)
	
	If Not IsDate(lvs_Data) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Imposs$$HEX1$$ed00$$ENDHEX$$vel converter a string '" + lvs_Data + "' para uma data.", StopSign!)
		SetNull(lvdt_Data)
	Else
		lvdt_Data = Date(lvs_Data)
	End If
Else
	SetNull(lvdt_Data)
End If

Return lvdt_Data
end function

public function datetime of_datetime (string ps_string);DateTime lvdh_Data

String lvs_Data, &
       lvs_Hora
		 
If ps_String <> "00000000000000" Then
	lvs_Data = LeftA(ps_String, 2) + "/" + &
				  MidA(ps_String, 3, 2) + "/" + &
				  MidA(ps_String, 5, 4)
	
	lvs_Hora = MidA(ps_String, 9, 2) + ":" + &
				  MidA(ps_String, 11, 2) + ":" + &
				  MidA(ps_String, 13, 2)
	
	If Not IsDate(lvs_Data) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Imposs$$HEX1$$ed00$$ENDHEX$$vel converter a string '" + lvs_Data + "' para uma data.", StopSign!)
		SetNull(lvdh_Data)
	Else
		If Not IsTime(lvs_Hora) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Imposs$$HEX1$$ed00$$ENDHEX$$vel converter a string '" + lvs_Hora + "' para uma hora.", StopSign!)
			SetNull(lvdh_Data)
		Else
			lvdh_Data = DateTime(Date(lvs_Data), Time(lvs_Hora))
		End If
	End If
Else
	SetNull(lvdh_Data)
End If

Return lvdh_Data
end function

public function boolean of_registro_conta_corrente (string ps_chave, string ps_atualizacao, ref string ps_registro);Boolean lvb_Retorno = True

String lvs_Tabela = "010", &
       lvs_Cliente, &
       lvs_Usuario_Aprovacao, &
		 lvs_Titular

Decimal lvdc_Limite_Credito, &
        lvdc_Taxa_Administracao, &
		  lvdc_Saldo_Atual

Long lvl_Filial_Centralizadora, &
     lvl_Portador, &
	  lvl_Dia_Base, &
	  lvl_Dias_Vencimento

DateTime lvdh_Ultima_Movimentacao, &
			lvdh_Aprovacao
			
lvs_Cliente = This.of_Coluna_Chave_Log(ps_Chave, 1)

If ps_Atualizacao <> "E" Then
	
	If Not This.of_Verifica_Saldo_Atual_CC(lvs_Cliente, Ref lvdc_Saldo_Atual) Then Return False
	
	Select cd_portador,   
          'N',   
          nr_matric_aprov_credito,   
          dh_aprovacao_credito,   
          vl_limite_credito_aprovado,   
          cd_filial_centralizadora,   
          "00",   
          "00",   
          pc_taxa_administracao
   Into :lvl_Portador,   
        :lvs_Titular,   
        :lvs_Usuario_Aprovacao,   
        :lvdh_Aprovacao,   
        :lvdc_Limite_Credito,   
        :lvl_Filial_Centralizadora,   
        :lvl_Dia_Base,   
        :lvl_Dias_Vencimento,   
        :lvdc_Taxa_Administracao
   From cliente  
   Where cd_cliente = :lvs_Cliente
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			
			If lvl_Portador = 0 Or IsNull(lvl_Portador) Then lvl_Portador = 10
			If lvs_Usuario_Aprovacao = "" Or IsNull(lvs_Usuario_Aprovacao) Then lvs_Usuario_Aprovacao = '14512'
			If lvl_Filial_Centralizadora = 0 Or IsNull(lvl_Filial_Centralizadora) Then lvl_Filial_Centralizadora = 534
			If IsNull(lvdh_Aprovacao) Then lvdh_Aprovacao = This.of_DateTime('1/1/1999 000000')
			
			ps_Registro = lvs_Tabela + ps_Atualizacao + &
							  lvs_Cliente + &
							  String(lvl_Portador, "0000") + &
							  This.of_String(lvs_Titular, 1) + &
							  This.of_String(lvs_Usuario_Aprovacao, 6) + &
							  This.of_Date(lvdh_Aprovacao) + &
							  This.of_Decimal(lvdc_Limite_Credito, 9) + &
							  String(lvl_Filial_Centralizadora, "0000") + &
							  String(lvl_Dia_Base, "00") + &
							  String(lvl_Dias_Vencimento, "00") + &
							  This.of_Decimal(lvdc_Saldo_Atual, 9) + &
							  This.of_Decimal(lvdc_Taxa_Administracao, 5) + &
							  "00000000" + &
							  "00000000" + &
							  "00000000"
							  
		Case 100
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Conta Corrente")
			Return False
	End Choose	
Else
	ps_Registro = lvs_Tabela + ps_Atualizacao + lvs_Cliente
End If		

Return lvb_Retorno
end function

public function long of_filial_parametro ();Long lvl_Filial

Select cd_filial Into :lvl_Filial
From parametro 
Where id_parametro = '1'
Using SqlCa;

Choose Case Sqlca.SqlCode
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o localizado na verifica$$HEX2$$e700e300$$ENDHEX$$o da filial..~rGE059.uo_ge059_troca_dados_comum.of_filial_parametro( )", StopSign!)
		SetNull(lvl_Filial)
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar filial do par$$HEX1$$e200$$ENDHEX$$metro." + SqlCa.SqlErrText, StopSign!)
		SetNull(lvl_Filial)
End Choose

Return lvl_Filial
end function

public function boolean of_atualiza_conta_corrente (string ps_registro, integer pi_log);String lvs_Chave_LOG, &
       lvs_Operacao, &
		 lvs_Cliente, &
       lvs_Usuario_Aprovacao, &
		 lvs_Somente_Titular

Long lvl_Portador, &
	  lvl_Filial_Centralizadora, &
	  lvl_Dia_Base, &
	  lvl_Dias_Vencimento
	  
Integer lvi_Controle

Date lvdt_Primeira_Compra, &
     lvdt_Ultima_Compra, &
	  lvdt_Aprovacao_Credito, &
	  lvdt_Ultima_Movimentacao
	  
Decimal lvdc_Limite_Credito, &
        lvdc_Saldo_Atual, &
		  lvdc_Taxa_Administracao
		  
Boolean lvb_Sucesso = True

lvs_Operacao = MidA(ps_Registro, 4, 1)
lvs_Cliente  = MidA(ps_Registro, 5, 11)

lvs_Chave_Log = "CONTA_CORRENTE (" + lvs_Cliente + ") "

If lvs_Operacao = "E" Then
	Delete From conta_corrente
	Where cd_cliente = :lvs_Cliente
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback()
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o")
		lvb_Sucesso = False
	End If				
Else
	If LenA(ps_Registro) <> 89 and LenA(ps_Registro) <> 90 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Registro Inv$$HEX1$$e100$$ENDHEX$$lido")	
		Return False
	End If
	
	lvl_Portador              = Long(MidA(ps_Registro, 16, 4))
	lvs_Somente_Titular       = MidA(ps_Registro, 20, 1)
	lvs_Usuario_Aprovacao     = Trim(MidA(ps_Registro, 21, 6))
	lvdt_Aprovacao_Credito    = This.of_Date(MidA(ps_Registro, 27, 8))
	lvdc_Limite_Credito       = This.of_Decimal(MidA(ps_Registro, 35, 9))
	lvl_Filial_Centralizadora = Long(MidA(ps_Registro, 44, 4))
	lvl_Dia_Base              = Long(MidA(ps_Registro, 48, 2))
	lvl_Dias_Vencimento       = Long(MidA(ps_Registro, 50, 2))
	lvdc_Saldo_Atual          = This.of_Decimal(MidA(ps_Registro, 52, 9))
	lvdc_Taxa_Administracao   = This.of_Decimal(MidA(ps_Registro, 61, 5))
	lvdt_Primeira_Compra      = This.of_Date(MidA(ps_Registro, 66, 8))
	lvdt_Ultima_Compra        = This.of_Date(MidA(ps_Registro, 74, 8))
	lvdt_Ultima_Movimentacao  = This.of_Date(MidA(ps_Registro, 82, 8))
	
	Select cd_cliente Into :lvs_Cliente
	From conta_corrente
	Where cd_cliente = :lvs_Cliente
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			Update conta_corrente
			Set cd_portador              = :lvl_Portador,   
			    id_somente_titular       = :lvs_Somente_Titular,   
			    nr_matricula_aprovacao   = :lvs_Usuario_Aprovacao,   
			    dh_aprovacao             = :lvdt_Aprovacao_Credito,   
			    vl_limite_credito        = :lvdc_Limite_Credito,   
			    cd_filial_centralizadora = :lvl_Filial_Centralizadora,   
			    nr_dia_base              = :lvl_Dia_Base,   
			    qt_dias_vencimento       = :lvl_Dias_Vencimento,   
			    vl_saldo_atual           = :lvdc_Saldo_Atual,   
			    pc_taxa_administracao    = :lvdc_Taxa_Administracao,   
			    dh_primeira_compra       = :lvdt_Primeira_Compra,   
			    dh_ultima_compra         = :lvdt_Ultima_Compra,   
			    dh_ultima_movimentacao   = :lvdt_Ultima_Movimentacao
			Where cd_cliente = :lvs_Cliente
			Using SqlCa;
						
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_Rollback()
				SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Atualiza$$HEX2$$e700e300$$ENDHEX$$o")
				lvb_Sucesso = False
			End If				
		Case 100
			Insert Into conta_corrente (cd_cliente,   
												 cd_portador,   
												 id_somente_titular,   
												 nr_matricula_aprovacao,   
												 dh_aprovacao,   
												 vl_limite_credito,   
												 cd_filial_centralizadora,   
												 nr_dia_base,   
												 qt_dias_vencimento,   
												 vl_saldo_atual,   
												 pc_taxa_administracao,   
												 dh_primeira_compra,   
												 dh_ultima_compra,   
												 dh_ultima_movimentacao)  
			Values (:lvs_Cliente,   
					  :lvl_Portador,   
					  :lvs_Somente_Titular,   
					  :lvs_Usuario_Aprovacao,   
					  :lvdt_Aprovacao_Credito,   
					  :lvdc_Limite_Credito,   
					  :lvl_Filial_Centralizadora,   
					  :lvl_Dia_Base,   
					  :lvl_Dias_Vencimento,   
					  :lvdc_Saldo_Atual,   
					  :lvdc_Taxa_Administracao,   
					  :lvdt_Primeira_Compra,   
					  :lvdt_Ultima_Compra,   
					  :lvdt_Ultima_Movimentacao)
			Using SqlCa;

			If SqlCa.SqlCode = -1 Then
				SqlCa.of_Rollback()
				SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Inclus$$HEX1$$e300$$ENDHEX$$o")
				lvb_Sucesso = False
			End If				
		Case -1
			SqlCa.of_Rollback()
			SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o")
			lvb_Sucesso = False
	End Choose		
End If

If lvb_Sucesso Then
	If SqlCa.of_Commit() = -1 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Commit")
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_atualiza_conveniado (string ps_registro, integer pi_log);String lvs_Chave_LOG, &
       lvs_Operacao, &
		 lvs_Conveniado, &
		 lvs_Nome, &
		 lvs_Restricao, &
		 lvs_Titular, &
		 lvs_Usuario_Atualizacao,&
		 lvs_Senha, &
		 lvs_Cliente, &
		 lvs_Bloqueio_Unimed
		 
Long lvl_Convenio, &
     lvl_Filial_Atualizacao, &
	  lvl_Filial_Parametro
	  
DateTime lvdh_Atualizacao

Boolean lvb_Sucesso = True

lvs_Operacao   = MidA(ps_Registro, 4, 1)
lvl_Convenio   = Long(MidA(ps_Registro, 5, 5))
lvs_Conveniado = Trim(MidA(ps_Registro, 10, 15))

lvs_Chave_Log = "CONVENIADO (" + String(lvl_Convenio, "00000")  + "-" + lvs_Conveniado + ") "

If lvs_Operacao = "E" Then
	Delete From conveniado
	Where cd_convenio      = :lvl_Convenio
	  and cd_conveniado = :lvs_Conveniado
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback()
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o")
		lvb_Sucesso = False
	End If				
Else
	If LenA(ps_Registro) <> 95 and LenA(ps_Registro) <> 107 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Registro Inv$$HEX1$$e100$$ENDHEX$$lido")	
		Return False
	End If
	
	lvs_Nome                = Trim(MidA(ps_Registro, 25, 40))
	lvs_Titular             = MidA(ps_Registro, 65, 1)
	lvs_Restricao           = MidA(ps_Registro, 66, 1)
	lvl_Filial_Atualizacao  = Long(MidA(ps_Registro, 67, 4))
	lvdh_Atualizacao        = This.of_DateTime(MidA(ps_Registro, 71, 14))
	lvs_Usuario_Atualizacao = Trim(MidA(ps_Registro, 85, 6))
	lvs_Senha               = Trim(MidA(ps_Registro, 91, 4))
	lvs_Cliente             = Trim(MidA(ps_Registro, 95, 11))
	lvs_Bloqueio_Unimed		= Trim(MidA(ps_Registro, 106, 1))
	
	If lvl_Filial_Atualizacao = 0  Then SetNull(lvl_Filial_Atualizacao)
	If lvs_Cliente				  = "" Then SetNull(lvs_Cliente)
	
	If LenA(ps_Registro) = 91 Then
		SetNull(lvs_Senha)
	End If	
	
	Select cd_convenio Into :lvl_Convenio
	  From conveniado
	 Where cd_convenio   = :lvl_Convenio
	   and cd_conveniado = :lvs_Conveniado
	 Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			lvl_Filial_Parametro = This.of_Filial_Parametro()
			
			// Verifica se a atualiza$$HEX2$$e700e300$$ENDHEX$$o foi feita pela pr$$HEX1$$f300$$ENDHEX$$pria filial
			//If lvl_Filial_Atualizacao <> lvl_Filial_Parametro Then				
				Update conveniado
				Set nm_conveniado            = :lvs_Nome,   
					 id_somente_titular       = :lvs_Titular,
					 id_obedece_restricao     = :lvs_Restricao,
					 cd_filial_atualizacao    = :lvl_Filial_Atualizacao,
					 dh_atualizacao           = :lvdh_Atualizacao,
					 nr_matricula_atualizacao = :lvs_Usuario_Atualizacao,
					 de_senha                 = :lvs_senha,
					 cd_cliente               = :lvs_Cliente,
					 id_bloqueio_unimed		  = :lvs_Bloqueio_Unimed
				Where cd_convenio   = :lvl_Convenio
				  and cd_conveniado = :lvs_Conveniado
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_Rollback()
					SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Atualiza$$HEX2$$e700e300$$ENDHEX$$o")
					lvb_Sucesso = False
				End If				
			//End If			
		Case 100
			Insert Into conveniado (cd_convenio,   
											cd_conveniado,   
											nm_conveniado,   
											id_somente_titular,   
											id_obedece_restricao,   
											cd_filial_atualizacao,   
											dh_atualizacao,   
											nr_matricula_atualizacao,
											de_senha,
											cd_cliente,
											id_bloqueio_unimed)
			Values (:lvl_Convenio,   
					  :lvs_Conveniado,   
					  :lvs_Nome,   
					  :lvs_Titular,   
					  :lvs_Restricao,   
					  :lvl_Filial_Atualizacao,   
					  :lvdh_Atualizacao,   
					  :lvs_Usuario_Atualizacao,
					  :lvs_senha,
					  :lvs_Cliente,
					  :lvs_Bloqueio_Unimed)
			Using SqlCa;

			If SqlCa.SqlCode = -1 Then
				SqlCa.of_Rollback()
				SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Inclus$$HEX1$$e300$$ENDHEX$$o")
				lvb_Sucesso = False
			End If				
		Case -1
			SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o")
			lvb_Sucesso = False
	End Choose		
End If

If lvb_Sucesso Then
	If SqlCa.of_Commit() = -1 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Commit")
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_atualiza_usuario (string ps_registro, integer pi_log);String lvs_Chave_LOG, &
       lvs_Operacao, &
		 lvs_Matricula, &
       lvs_Nome, &
		 lvs_Senha, &
		 lvs_Id_Situacao

Long lvl_Filial_Atualizacao, &
     lvl_Filial_Parametro, &
	  lvl_Filial

DateTime lvdh_Atualizacao

Boolean lvb_Sucesso = True

lvs_Operacao  = MidA(ps_Registro, 4, 1)
lvs_Matricula = Trim(MidA(ps_Registro, 5, 6))

lvs_Chave_Log = "USUARIO (" + lvs_Matricula  + ") "

If lvs_Operacao = "E" Then
	Delete From usuario
	Where nr_matricula = :lvs_Matricula
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback()
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o")
		lvb_Sucesso = False
	End If				
Else
	If LenA(ps_Registro) <> 79 and LenA(ps_Registro) <> 80 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Registro Inv$$HEX1$$e100$$ENDHEX$$lido")	
		Return False
	End If
	
	lvs_Nome               = Trim(MidA(ps_Registro, 11, 40))
	lvs_Senha              = Trim(MidA(ps_Registro, 51, 6))
	lvl_Filial			     = Long(MidA(ps_Registro, 57, 4))
	lvl_Filial_Atualizacao = Long(MidA(ps_Registro, 61, 4))
	lvdh_Atualizacao       = This.of_DateTime(MidA(ps_Registro, 65, 14))
	lvs_Id_Situacao        = Trim(MidA(ps_Registro, 79, 1))
	
	If lvl_Filial_Atualizacao = 0   Then SetNull(lvl_Filial_Atualizacao)
	If lvs_Id_Situacao        = '0' Then SetNull(lvs_Id_Situacao)
	
	Select nr_matricula Into :lvs_Matricula
  	  From usuario
	 Where nr_matricula = :lvs_Matricula
	 Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			lvl_Filial_Parametro = This.of_Filial_Parametro()

			// Verifica se a atualiza$$HEX2$$e700e300$$ENDHEX$$o foi feita pela pr$$HEX1$$f300$$ENDHEX$$pria filial
			If lvl_Filial_Atualizacao <> lvl_Filial_Parametro Then
				Update usuario
				Set nm_usuario            = :lvs_Nome,
					 de_senha				  = :lvs_Senha,
					 cd_filial             = :lvl_Filial,
					 cd_filial_atualizacao = :lvl_Filial_Atualizacao,
					 dh_atualizacao_filial = :lvdh_Atualizacao,
					 id_situacao           = :lvs_Id_Situacao
				Where nr_matricula = :lvs_Matricula
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_Rollback()
					SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Atualiza$$HEX2$$e700e300$$ENDHEX$$o")
					lvb_Sucesso = False
				End If
			End If
			
		Case 100
			Insert Into usuario (nr_matricula,
										nm_usuario,
										de_senha,
										cd_filial,
										cd_filial_atualizacao,
										dh_atualizacao_filial,
										id_situacao)  
			Values (:lvs_Matricula,
					  :lvs_Nome,
					  :lvs_Senha,
					  :lvl_Filial,
					  :lvl_Filial_Atualizacao,
					  :lvdh_Atualizacao,
					  :lvs_Id_Situacao)
			Using SqlCa;

			If SqlCa.SqlCode = -1 Then
				SqlCa.of_Rollback()
				SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Inclus$$HEX1$$e300$$ENDHEX$$o")
				lvb_Sucesso = False
			End If				
		Case -1
			SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o")
			lvb_Sucesso = False
	End Choose		
End If

If lvb_Sucesso Then
	If SqlCa.of_Commit() = -1 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Commit")
	End If
End If

Return lvb_Sucesso
end function

public function string of_decimal (decimal pdc_valor, integer pi_tamanho, integer pi_decimal);String lvs_Valor, &
       lvs_Zeros, &
		 lvs_Decimal

Integer lvi_Contador

If IsNull(pdc_Valor) Then pdc_Valor = 0

For lvi_Contador = 1 To pi_Decimal
	lvs_Decimal += "0"
Next

lvs_Valor = String(pdc_Valor, "0." + lvs_Decimal)

lvs_Valor = LeftA(lvs_Valor, LenA(lvs_Valor) - pi_Decimal - 1) + RightA(lvs_Valor, pi_Decimal)

For lvi_Contador = 1 To pi_Tamanho - LenA(lvs_Valor)
	lvs_Zeros += "0"
Next

lvs_Valor = lvs_Zeros + lvs_Valor

Return lvs_Valor
end function

public function string of_decimal (decimal pdc_valor, integer pi_tamanho);Return This.of_Decimal(pdc_Valor, pi_Tamanho, 2)
end function

public function decimal of_decimal (string ps_valor, integer pi_decimal);Decimal lvdc_Valor

String lvs_Temp

lvs_Temp = LeftA(ps_Valor, LenA(ps_Valor) - pi_Decimal) + "," + RightA(ps_Valor, pi_Decimal)

lvdc_Valor = Dec(lvs_Temp)

Return lvdc_Valor
end function

public function decimal of_decimal (string ps_valor);Return This.of_Decimal(ps_Valor, 2)
end function

public function boolean of_registro_titulo_receber (string ps_chave, string ps_atualizacao, ref string ps_registro);Boolean lvb_Retorno = True

String lvs_Tabela = "017", &
       lvs_Titulo, &
		 lvs_Tipo, &
		 lvs_Situacao, &
		 lvs_Carne, &
		 lvs_Titulo_AS400, &
		 lvs_Protesto, &
		 lvs_Cliente, &
		 lvs_Serie, &
		 lvs_Especie, &
		 lvs_Titulo_Banco

Long lvl_Filial_Atualizacao, &
     lvl_Filial, &
	  lvl_Filial_NF, &
	  lvl_NF, &
	  lvl_Convenio, &
	  lvl_Portador, &
	  lvl_Remessa

Decimal lvdc_Juros, &
        lvdc_Nominal, &
		  lvdc_Desconto, &
		  lvdc_Despesas_Pagas, &
		  lvdc_Despesas_Recebidas, &
		  lvdc_Recebido, &
		  lvdc_Aberto

DateTime lvdh_Atualizacao, &
         lvdh_Emissao, &
			lvdh_Vencimento, &
			lvdh_Juros, &
			lvdh_Venda_Inicial, &
			lvdh_Venda_Final, &
			lvdh_Baixa
			
lvs_Titulo = This.of_Coluna_Chave_Log(ps_Chave, 1)

If ps_Atualizacao <> "E" Then	
	Select cd_filial,   
          id_tipo_titulo,   
          cd_portador,   
          dh_emissao,   
          dh_vencimento,   
          dh_calculo_juros,   
          vl_nominal,   
          vl_juros_recebidos,   
          vl_desconto_concedido,   
          vl_despesas_pagas,   
          vl_despesas_recebidas,   
          vl_recebido,   
          vl_aberto,   
          id_situacao,   
          id_carne_bloqueto,   
          id_protesto,   
          nr_titulo_banco,   
          dh_baixa,   
          cd_convenio,   
          cd_cliente,   
          cd_filial_nf,   
          nr_nf,   
          de_especie,   
          de_serie,   
          nr_titulo_as400,   
          nr_remessa,   
          dh_venda_inicial,   
          dh_venda_final
   Into :lvl_Filial,   
        :lvs_Tipo,   
        :lvl_Portador,   
        :lvdh_Emissao,   
        :lvdh_Vencimento,   
        :lvdh_Juros,   
        :lvdc_Nominal,   
        :lvdc_Juros,   
        :lvdc_Desconto,   
        :lvdc_Despesas_Pagas,   
        :lvdc_Despesas_Recebidas,   
        :lvdc_Recebido,   
        :lvdc_Aberto,   
        :lvs_Situacao,   
        :lvs_Carne,   
        :lvs_Protesto,   
        :lvs_Titulo_Banco,   
        :lvdh_Baixa,   
        :lvl_Convenio,   
        :lvs_Cliente,   
        :lvl_Filial_NF,   
        :lvl_NF,   
        :lvs_Especie,   
        :lvs_Serie,   
        :lvs_TItulo_AS400,   
        :lvl_Remessa,   
        :lvdh_Venda_Inicial,   
        :lvdh_Venda_Final
   From titulo_receber  
   Where nr_titulo = :lvs_Titulo
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
		   lvl_Filial_Atualizacao = 534
		   lvdh_Atualizacao       = DateTime(Date("01/01/2010"))
			
			If IsNull(lvl_Convenio) Then lvl_Convenio = 0
			If IsNull(lvl_Filial_NF) Then lvl_Filial_NF = 0
			If IsNull(lvl_NF) Then lvl_NF = 0
			If IsNull(lvl_Remessa) Then lvl_Remessa = 0
			If IsNull(lvl_Filial_Atualizacao) Then lvl_Filial_Atualizacao = 0
			
			ps_Registro = lvs_Tabela + ps_Atualizacao + &
							  lvs_Titulo + &
							  String(lvl_Filial, "0000") + &
							  This.of_String(lvs_Tipo, 2) + &
							  String(lvl_Portador, "0000") + &
							  This.of_Date(lvdh_Emissao) + &
							  This.of_Date(lvdh_Vencimento) + &
							  This.of_Date(lvdh_Juros) + &
							  This.of_Decimal(lvdc_Nominal, 9) + &
							  This.of_Decimal(lvdc_Juros, 9) + &
							  This.of_Decimal(lvdc_Desconto, 9) + &
							  This.of_Decimal(lvdc_Despesas_Pagas, 9) + &
							  This.of_Decimal(lvdc_Despesas_Recebidas, 9) + &
							  This.of_Decimal(lvdc_Recebido, 9) + &
							  This.of_Decimal(lvdc_Aberto, 9) + &
  							  lvs_Situacao + &
							  This.of_String(lvs_Carne, 1) + &
							  This.of_String(lvs_Protesto, 1) + &
							  This.of_String(lvs_Titulo_Banco, 20) + &
							  This.of_Date(lvdh_Baixa) + &
							  String(lvl_Convenio, "00000") + &
							  This.of_String(lvs_Cliente, 11) + &
							  String(lvl_Filial_NF, "0000") + &
							  String(lvl_NF, "00000000") + &
							  This.of_String(lvs_Especie, 3) + &
							  This.of_String(lvs_Serie, 3) + &
							  This.of_String(lvs_Titulo_AS400, 8) + &
							  String(lvl_Remessa, "00000") + &
							  This.of_Date(lvdh_Venda_Inicial) + &
							  This.of_Date(lvdh_Venda_Final) + &
							  String(lvl_Filial_Atualizacao, "0000") + &
							  This.of_DateTime(lvdh_Atualizacao)
							  
		Case 100
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do T$$HEX1$$ed00$$ENDHEX$$tulo")
			Return False
	End Choose	
Else
	ps_Registro = lvs_Tabela + ps_Atualizacao + lvs_Titulo
End If		

Return lvb_Retorno
end function

public function boolean of_registro_movimento_titulo_receber (string ps_chave, string ps_atualizacao, ref string ps_registro);Boolean lvb_Retorno = True

String lvs_Tabela = "018", &
       lvs_Titulo, &
		 lvs_Usuario, &
		 lvs_Usuario_Juros, &
		 lvs_Historico, &
		 lvs_Estorno, &
		 lvs_Recibo

Long lvl_Filial_Atualizacao, &
     lvl_Tipo, &
	  lvl_Filial_Movimento, &
	  lvl_Movimento

DateTime lvdh_Atualizacao, &
         lvdh_Sistema, &
			lvdh_Movimento, &
			lvdh_Credito
	
Decimal lvdc_Movimento, &
        lvdc_Juros, &
		  lvdc_Desconto, &
		  lvdc_Despesas
			
lvs_Titulo           = This.of_Coluna_Chave_Log(ps_Chave, 1)
lvl_Filial_Movimento = Long(This.of_Coluna_Chave_Log(ps_Chave, 2))
lvl_Movimento        = Long(This.of_Coluna_Chave_Log(ps_Chave, 3))

If ps_Atualizacao <> "E" Then	
	Select cd_tipo_movimento,   
          nr_matricula_responsavel,   
          dh_sistema,   
          dh_movimento,   
          dh_credito,   
          vl_movimento,   
          vl_juros_recebidos,   
          vl_desconto_concedido,   
          vl_despesas_recebidas,   
          id_estorno,   
          de_historico,   
          nr_recibo_cobranca,   
          nr_matric_juros_desconto
   Into :lvl_Tipo,   
        :lvs_Usuario,   
        :lvdh_Sistema,   
        :lvdh_Movimento,   
        :lvdh_Credito,   
        :lvdc_Movimento,   
        :lvdc_Juros,   
        :lvdc_Desconto,   
        :lvdc_Despesas,   
        :lvs_Estorno,   
        :lvs_Historico,   
        :lvs_Recibo,   
        :lvs_Usuario_Juros
   From movimento_titulo_receber  
   Where nr_titulo           = :lvs_Titulo
     and cd_filial_movimento = :lvl_Filial_Movimento
     and nr_movimento        = :lvl_Movimento
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
		  lvl_Filial_Atualizacao = 534
		  lvdh_Atualizacao       = DateTime(Date("01/01/2010"))

			If IsNull(lvl_Filial_Atualizacao) Then lvl_Filial_Atualizacao = 0
			
			ps_Registro = lvs_Tabela + ps_Atualizacao + &
							  lvs_Titulo + &
							  String(lvl_Filial_Movimento, "0000") + &
							  String(lvl_Movimento, "000") + &
							  String(lvl_Tipo, "00") + &
							  This.of_String(lvs_Usuario, 6) + &
							  This.of_DateTime(lvdh_Sistema) + &
							  This.of_Date(lvdh_Movimento) + &
							  This.of_Date(lvdh_Credito) + &
							  This.of_Decimal(lvdc_Movimento, 9) + &
							  This.of_Decimal(lvdc_Juros, 9) + &
							  This.of_Decimal(lvdc_Desconto, 9) + &
							  This.of_Decimal(lvdc_Despesas, 9) + &
							  This.of_String(lvs_Estorno, 1) + &
							  This.of_String(lvs_Historico, 50) + &
							  This.of_String(lvs_Recibo, 11) + &
							  This.of_String(lvs_Usuario_Juros, 6) + &
							  String(lvl_Filial_Atualizacao, "0000") + &
							  This.of_DateTime(lvdh_Atualizacao)
							  
		Case 100
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Movimento do T$$HEX1$$ed00$$ENDHEX$$tulo")
			Return False
	End Choose	
Else
	ps_Registro = lvs_Tabela + ps_Atualizacao + &
					  lvs_Titulo + &
					  String(lvl_Filial_Movimento, "0000") + &
					  String(lvl_Movimento, "000")
End If		

Return lvb_Retorno
end function

public function boolean of_atualiza_bloqueio (string ps_registro, integer pi_log);String lvs_Chave_LOG, &
       lvs_Operacao, &
       lvs_Tipo, &
		 lvs_Motivo, &
		 lvs_Usuario_Bloqueio, &
		 lvs_Usuario_Liberacao, &
		 lvs_Cliente, &
		 lvs_Conveniado, &
		 lvs_Cd_Cliente_Dependente

Long lvl_Filial_Atualizacao, &
        lvl_Filial, &
	   lvl_Bloqueio, &
	  lvl_Convenio, &
	  lvl_Clube, &
	  lvl_Dependente, &
	  lvl_Filial_Parametro

DateTime lvdh_Atualizacao

Date lvdt_Bloqueio, &
	  lvdt_Liberacao

Boolean lvb_Sucesso = True

lvs_Operacao = TRim( MidA(ps_Registro, 4, 1) )
lvl_Filial   = Long(MidA(ps_Registro, 5, 4))
lvl_Bloqueio = Long(MidA(ps_Registro, 9, 8))

lvs_Chave_Log = "BLOQUEIO (" + String(lvl_Filial, "0000")  + "-" + &
										 String(lvl_Bloqueio) + ") "

If lvs_Operacao = "E" Then
	Delete From bloqueio
	Where cd_filial   = :lvl_Filial
	  and nr_bloqueio = :lvl_Bloqueio
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback()
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o")
		lvb_Sucesso = False
	End If				
Else
	If LenA(ps_Registro) <> 106 and LenA(ps_Registro) <> 119 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Registro Inv$$HEX1$$e100$$ENDHEX$$lido")	
		Return False
	End If

	lvs_Tipo                  = Trim(MidA(ps_Registro, 17, 3))
	lvs_Motivo                = Trim( This.of_String(Trim(MidA(ps_Registro, 20, 3)), 3) )
	lvdt_Bloqueio             = This.of_Date(MidA(ps_Registro, 23, 8))
	lvs_Usuario_Bloqueio      = Trim(MidA(ps_Registro, 31, 6))
	lvs_Cliente               = Trim(MidA(ps_Registro, 37, 11))
	lvl_Clube                 = Long(MidA(ps_Registro, 48, 3))
	lvl_Convenio              = Long(MidA(ps_Registro, 51, 5))
	lvs_Conveniado            = Trim(MidA(ps_Registro, 56, 15))
	lvl_Dependente            = Long(MidA(ps_Registro, 71, 3))
	lvdt_Liberacao            = This.of_Date(MidA(ps_Registro, 74, 8))
	lvs_Usuario_Liberacao     = Trim(MidA(ps_Registro, 82, 6))
	lvl_Filial_Atualizacao    = Long(MidA(ps_Registro, 88, 4))
	lvdh_Atualizacao          = This.of_DateTime(MidA(ps_Registro, 92, 14))
	lvs_Cd_Cliente_Dependente = Trim(MidA(ps_Registro, 106, 13))
	
	If lvl_Convenio 						  = 0  Then SetNull(lvl_Convenio)
	If lvl_Clube 							  = 0  Then SetNull(lvl_Clube)
	If lvl_Dependente 					  = 0  Then SetNull(lvl_Dependente)
	If Trim(lvs_Conveniado) 			  = "" Then SetNull(lvs_Conveniado)
	If Trim(lvs_Usuario_Liberacao)	  = "" Then SetNull(lvs_Usuario_Liberacao)
	If Trim(lvs_Cliente) 				  = "" Then SetNull(lvs_Cliente)
	If Trim(lvs_Cd_Cliente_Dependente) = "" Then SetNull(lvs_Cd_Cliente_Dependente)
	
	Select cd_filial Into :lvl_Filial
	From bloqueio
	Where cd_filial   = :lvl_Filial
	  and nr_bloqueio = :lvl_Bloqueio
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			lvl_Filial_Parametro = This.of_Filial_Parametro()
			
			// Verifica se a atualiza$$HEX2$$e700e300$$ENDHEX$$o foi feita pela pr$$HEX1$$f300$$ENDHEX$$pria filial
			If lvl_Filial_Atualizacao <> lvl_Filial_Parametro Then				
				Update bloqueio
				Set id_tipo_bloqueio       = :lvs_Tipo,
					 cd_motivo_bloqueio     = :lvs_Motivo,
					 dh_bloqueio            = :lvdt_Bloqueio,
					 nr_matricula_bloqueio  = :lvs_Usuario_Bloqueio,
					 cd_cliente             = :lvs_Cliente,
					 cd_clube_cliente       = :lvl_Clube,
					 cd_convenio            = :lvl_Convenio,
					 cd_conveniado          = :lvs_Conveniado,
					 cd_dependente          = :lvl_Dependente,
					 dh_liberacao           = :lvdt_Liberacao,
					 nr_matricula_liberacao = :lvs_Usuario_Liberacao,
					 cd_cliente_dependente  = :lvs_Cd_Cliente_Dependente
				Where cd_filial   = :lvl_Filial
				  and nr_bloqueio = :lvl_Bloqueio 
				Using SqlCa;
			
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_Rollback()
					SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Atualiza$$HEX2$$e700e300$$ENDHEX$$o")
					lvb_Sucesso = False
				End If				
			End If
		Case 100
			Insert Into bloqueio (cd_filial,   
										 nr_bloqueio,   
										 id_tipo_bloqueio,   
										 cd_motivo_bloqueio,   
										 dh_bloqueio,   
										 nr_matricula_bloqueio,   
										 cd_cliente,   
										 cd_clube_cliente,   
										 cd_convenio,   
										 cd_conveniado,   
										 cd_dependente,   
										 dh_liberacao,   
										 nr_matricula_liberacao,
										 cd_cliente_dependente)  
			Values (:lvl_Filial,
					  :lvl_Bloqueio,   
					  :lvs_Tipo,   
					  :lvs_Motivo,   
					  :lvdt_Bloqueio,   
					  :lvs_Usuario_Bloqueio,   
					  :lvs_Cliente,   
					  :lvl_Clube,   
					  :lvl_Convenio,   
					  :lvs_Conveniado,   
					  :lvl_Dependente,   
					  :lvdt_Liberacao,   
					  :lvs_Usuario_Liberacao,
					  :lvs_Cd_Cliente_Dependente)
			Using SqlCa;

			If SqlCa.SqlCode = -1 Then
				SqlCa.of_Rollback()
				SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Inclus$$HEX1$$e300$$ENDHEX$$o")
				lvb_Sucesso = False
			End If				
		Case -1
			SqlCa.of_Rollback()
			SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o")
			lvb_Sucesso = False
	End Choose		
End If

If lvb_Sucesso Then
	If SqlCa.of_Commit() = -1 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Commit")
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_atualiza_titulo_receber (string ps_registro, integer pi_log);String lvs_Chave_LOG, &
       lvs_Operacao, &
		 lvs_Titulo, &
		 lvs_Tipo, &
		 lvs_Situacao, &
		 lvs_Carne, &
		 lvs_Titulo_AS400, &
		 lvs_Protesto, &
		 lvs_Cliente, &
		 lvs_Serie, &
		 lvs_Especie, &
		 lvs_Titulo_Banco, &
		 lvs_Achou

Long lvl_Filial, &
	  lvl_Filial_NF, &
	  lvl_NF, &
	  lvl_Convenio, &
	  lvl_Portador, &
	  lvl_Remessa

Decimal lvdc_Juros, &
        lvdc_Nominal, &
		  lvdc_Desconto, &
		  lvdc_Despesas_Pagas, &
		  lvdc_Despesas_Recebidas, &
		  lvdc_Recebido, &
		  lvdc_Aberto

Date lvdt_Emissao, &
	  lvdt_Vencimento, &
	  lvdt_Juros, &
	  lvdt_Venda_Inicial, &
	  lvdt_Venda_Final, &
	  lvdt_Baixa

Boolean lvb_Sucesso = True

lvs_Operacao = MidA(ps_Registro, 4, 1)
lvs_Titulo   = MidA(ps_Registro, 5, 13)

lvs_Chave_Log = "TITULO_RECEBER (" + lvs_Titulo  + ") "

If lvs_Operacao = "E" Then
	Delete From titulo_receber
	Where nr_titulo = :lvs_Titulo
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback()
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o")
		lvb_Sucesso = False
	End If				
Else
	If LenA(ps_Registro) <> 226 and LenA(ps_Registro) <> 227 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Registro Inv$$HEX1$$e100$$ENDHEX$$lido")	
		Return False
	End If
	
	lvl_Filial              = Long(MidA(ps_Registro, 18, 4))
	lvs_Tipo                = Trim(MidA(ps_Registro, 22, 2))
	lvl_Portador            = Long(MidA(ps_Registro, 24, 4))
	lvdt_Emissao            = This.of_Date(MidA(ps_Registro, 28, 8))
	lvdt_Vencimento         = This.of_Date(MidA(ps_Registro, 36, 8))
	lvdt_Juros              = This.of_Date(MidA(ps_Registro, 44, 8))
	lvdc_Nominal            = This.of_Decimal(MidA(ps_Registro, 52, 9))
	lvdc_Juros              = This.of_Decimal(MidA(ps_Registro, 61, 9))
	lvdc_Desconto           = This.of_Decimal(MidA(ps_Registro, 70, 9))
	lvdc_Despesas_Pagas     = This.of_Decimal(MidA(ps_Registro, 79, 9))
	lvdc_Despesas_Recebidas = This.of_Decimal(MidA(ps_Registro, 88, 9))
	lvdc_Recebido           = This.of_Decimal(MidA(ps_Registro, 97, 9))
	lvdc_Aberto             = This.of_Decimal(MidA(ps_Registro, 106, 9))
	lvs_Situacao            = Trim(MidA(ps_Registro, 115, 1))
	lvs_Carne               = Trim(MidA(ps_Registro, 116, 1))
	lvs_Protesto            = Trim(MidA(ps_Registro, 117, 1))
	lvs_Titulo_Banco        = Trim(MidA(ps_Registro, 118, 20))
	lvdt_Baixa              = This.of_Date(MidA(ps_Registro, 138, 8))
	lvl_Convenio            = Long(MidA(ps_Registro, 146, 5))
	lvs_Cliente             = Trim(MidA(ps_Registro, 151, 11))
	lvl_Filial_NF           = Long(MidA(ps_Registro, 162, 4))
	lvl_NF                  = Long(MidA(ps_Registro, 166, 8))
	lvs_Especie             = Trim(MidA(ps_Registro, 174, 3))
	lvs_Serie               = Trim(MidA(ps_Registro, 177, 3))
	lvs_Titulo_AS400        = Trim(MidA(ps_Registro, 180, 8))
	lvl_Remessa             = Long(MidA(ps_Registro, 188, 5))
	lvdt_Venda_Inicial      = This.of_Date(MidA(ps_Registro, 193, 8))
	lvdt_Venda_Final        = This.of_Date(MidA(ps_Registro, 201, 8))
	
	If lvl_Convenio = 0  Then SetNull(lvl_Convenio)
	If Trim(lvs_Cliente) = "" Then SetNull(lvs_Cliente)
	
	If lvl_Filial_NF = 0 Then SetNull(lvl_Filial_NF)
	If lvl_NF = 0        Then SetNull(lvl_NF)
	If Trim(lvs_Especie) = "" Then SetNull(lvs_Especie)
	If Trim(lvs_Serie) = "" Then SetNull(lvs_Serie)
	If lvl_Remessa = 0 Then SetNull(lvl_Remessa)
	
	Select nr_titulo Into :lvs_Achou
	From titulo_receber
	Where nr_titulo = :lvs_Titulo
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			Update titulo_receber
			Set cd_filial             = :lvl_Filial,   
				 id_tipo_titulo        = :lvs_Tipo,
				 cd_portador           = :lvl_Portador,
				 dh_emissao            = :lvdt_Emissao,
				 dh_vencimento         = :lvdt_Vencimento,
				 vl_despesas_pagas     = :lvdc_Despesas_Pagas,
				 id_carne_bloqueto     = :lvs_Carne,
				 id_protesto           = :lvs_Protesto,
				 nr_titulo_banco       = :lvs_Titulo_Banco,
				 cd_convenio           = :lvl_Convenio,
				 cd_cliente            = :lvs_Cliente,
				 cd_filial_nf          = :lvl_Filial_NF,
				 nr_nf                 = :lvl_NF,
				 de_especie            = :lvs_Especie,
				 de_serie              = :lvs_Serie, 
				 nr_titulo_as400       = :lvs_Titulo_AS400,
				 nr_remessa            = :lvl_Remessa,
				 dh_venda_inicial      = :lvdt_Venda_Inicial,
				 dh_venda_final        = :lvdt_Venda_Final,
				 cd_filial_atualizacao = 534,
				 dh_atualizacao_filial = getdate()
			Where nr_titulo = :lvs_Titulo
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_Rollback()
				SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Atualiza$$HEX2$$e700e300$$ENDHEX$$o")
				lvb_Sucesso = False
			End If				
			
		Case 100
			// Os t$$HEX1$$ed00$$ENDHEX$$tulos s$$HEX1$$e300$$ENDHEX$$o inclu$$HEX1$$ed00$$ENDHEX$$dos sempre em aberto,
			// pois os movimentos far$$HEX1$$e300$$ENDHEX$$o a atualiza$$HEX2$$e700e300$$ENDHEX$$o dos valores atrav$$HEX1$$e900$$ENDHEX$$s da trigger
			lvdc_Juros              = 0   
			lvdc_Desconto           = 0   
			lvdc_Despesas_Recebidas = 0 
			lvdc_Recebido           = 0   
			lvdc_Aberto             = lvdc_Nominal  
			lvs_Situacao            = 'A'   
			lvdt_Juros              = lvdt_Vencimento
			SetNull(lvdt_Baixa)
			
			Insert Into titulo_receber (nr_titulo,   
												 cd_filial,   
												 id_tipo_titulo,   
												 cd_portador,   
												 dh_emissao,   
												 dh_vencimento,   
												 dh_calculo_juros,   
												 vl_nominal,   
												 vl_juros_recebidos,   
												 vl_desconto_concedido,   
												 vl_despesas_pagas,   
												 vl_despesas_recebidas,   
												 vl_recebido,   
												 vl_aberto,   
												 id_situacao,   
												 id_carne_bloqueto,   
												 id_protesto,   
												 nr_titulo_banco,   
												 dh_baixa,   
												 cd_convenio,   
												 cd_cliente,   
												 cd_filial_nf,   
												 nr_nf,   
												 de_especie,   
												 de_serie,   
												 nr_titulo_as400,   
												 nr_remessa,   
												 dh_venda_inicial,   
												 dh_venda_final,
												 cd_filial_atualizacao,
												 dh_atualizacao_filial)  
			Values (:lvs_Titulo,
					  :lvl_Filial,   
					  :lvs_Tipo,   
					  :lvl_Portador,   
					  :lvdt_Emissao,   
					  :lvdt_Vencimento,   
					  :lvdt_Juros,   
					  :lvdc_Nominal,   
					  :lvdc_Juros,   
					  :lvdc_Desconto,   
					  :lvdc_Despesas_Pagas,   
					  :lvdc_Despesas_Recebidas,   
					  :lvdc_Recebido,   
					  :lvdc_Aberto,   
					  :lvs_Situacao,   
					  :lvs_Carne,   
					  :lvs_Protesto,   
					  :lvs_Titulo_Banco,   
					  :lvdt_Baixa,   
					  :lvl_Convenio,   
					  :lvs_Cliente,   
					  :lvl_Filial_NF,   
					  :lvl_NF,   
					  :lvs_Especie,   
					  :lvs_Serie,   
					  :lvs_Titulo_AS400,   
					  :lvl_Remessa,   
					  :lvdt_Venda_Inicial,   
					  :lvdt_Venda_Final,
					  534,
					  getdate())
			Using SqlCa;

			If SqlCa.SqlCode = -1 Then
				SqlCa.of_Rollback()
				SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Inclus$$HEX1$$e300$$ENDHEX$$o")
				lvb_Sucesso = False
			End If				
		Case -1
			SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o")
			lvb_Sucesso = False
	End Choose		
End If

If lvb_Sucesso Then
	If SqlCa.of_Commit() = -1 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Commit")
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_atualiza_movimento_titulo_receber (string ps_registro, integer pi_log);String lvs_Chave_LOG, &
       lvs_Operacao, &
       lvs_Titulo, &
		 lvs_Usuario, &
		 lvs_Liberacao_Juros, &
		 lvs_Historico, &
		 lvs_Estorno, &
		 lvs_Recibo, &
		 lvs_Achou

DateTime lvdh_Sistema
	
Date lvdt_Movto, &
     lvdt_Credito
	  
Decimal lvdc_Movimento, &
        lvdc_Juros, &
		  lvdc_Desconto, &
		  lvdc_Despesas

Long lvl_Filial_Movto, &
	  lvl_Movto, &
	  lvl_Tipo

Boolean lvb_Sucesso = True, &
        lvb_Atualiza

lvs_Operacao     = MidA(ps_Registro, 4, 1)
lvs_Titulo       = MidA(ps_Registro, 5, 13)
lvl_Filial_Movto = Long(MidA(ps_Registro, 18, 4))
lvl_Movto        = Long(MidA(ps_Registro, 22, 3))

lvs_Chave_Log = "MOVIMENTO_TITULO_RECEBER (" + lvs_Titulo  + "-" + &
                                               String(lvl_Filial_Movto, "0000") + "-" + &
															  String(lvl_Movto, "000") + ") "

If lvs_Operacao = "E" Then
	Delete From movimento_titulo_receber
	Where nr_titulo           = :lvs_Titulo
	  and nr_movimento        = :lvl_Movto
 	  and cd_filial_movimento = :lvl_Filial_Movto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback()
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o")
		lvb_Sucesso = False
		
	End If				
Else
	If LenA(ps_Registro) <> 184 and LenA(ps_Registro) <> 185 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Registro Inv$$HEX1$$e100$$ENDHEX$$lido")	
		Return False
	End If
	
	lvl_Tipo            = Long(MidA(ps_Registro, 25, 2))
	lvs_Usuario         = Trim(MidA(ps_Registro, 27, 6))
	lvdh_Sistema        = This.of_DateTime(MidA(ps_Registro, 33, 14))
	lvdt_Movto          = This.of_Date(MidA(ps_Registro, 47, 8))
	lvdt_Credito        = This.of_Date(MidA(ps_Registro, 55, 8))
	lvdc_Movimento      = This.of_Decimal(MidA(ps_Registro, 63, 9))
	lvdc_Juros          = This.of_Decimal(MidA(ps_Registro, 72, 9))
	lvdc_Desconto       = This.of_Decimal(MidA(ps_Registro, 81, 9))
	lvdc_Despesas       = This.of_Decimal(MidA(ps_Registro, 90, 9))
	lvs_Estorno         = Trim(MidA(ps_Registro, 99, 1))
	lvs_Historico       = Trim(MidA(ps_Registro, 100, 50))
	lvs_Recibo          = Trim(MidA(ps_Registro, 150, 11))
	lvs_Liberacao_Juros = Trim(MidA(ps_Registro, 161, 6))
	
	If Trim(lvs_Recibo)          = "" Then SetNull(lvs_Recibo)
	If Trim(lvs_Liberacao_Juros) = "" Then SetNull(lvs_Liberacao_Juros)
	
	Select nr_titulo Into :lvs_Achou
	From movimento_titulo_receber
	Where nr_titulo           = :lvs_Titulo
	  and cd_filial_movimento = :lvl_Filial_Movto
	  and nr_movimento        = :lvl_Movto
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			Update movimento_titulo_receber
			Set id_estorno            = :lvs_Estorno,
				 cd_filial_atualizacao = 534,
				 dh_atualizacao_filial = getdate()
			Where nr_titulo           = :lvs_Titulo
			  and cd_filial_movimento = :lvl_Filial_Movto
			  and nr_movimento        = :lvl_Movto
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_Rollback()
				SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Atualiza$$HEX2$$e700e300$$ENDHEX$$o")
				lvb_Sucesso = False
			End If				
					
		Case 100
			Insert Into movimento_titulo_receber (nr_titulo,   
															  cd_filial_movimento,   
															  nr_movimento,   
															  cd_tipo_movimento,   
															  nr_matricula_responsavel,   
															  dh_sistema,   
															  dh_movimento,   
															  dh_credito,   
															  vl_movimento,   
															  vl_juros_recebidos,   
															  vl_desconto_concedido,   
															  vl_despesas_recebidas,   
															  id_estorno,   
															  de_historico,   
															  nr_recibo_cobranca,   
															  nr_matric_juros_desconto,   
															  cd_filial_atualizacao,   
															  dh_atualizacao_filial)  
			Values (:lvs_Titulo,   
					  :lvl_Filial_Movto,   
					  :lvl_Movto,   
					  :lvl_Tipo,   
					  :lvs_Usuario,   
					  :lvdh_Sistema,   
					  :lvdt_Movto,   
					  :lvdt_Credito,   
					  :lvdc_Movimento,   
					  :lvdc_Juros,   
					  :lvdc_Desconto,   
					  :lvdc_Despesas,   
					  :lvs_Estorno,   
					  :lvs_Historico,   
					  :lvs_Recibo,   
					  :lvs_Liberacao_Juros,   
					  534,   
					  getdate())
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_Rollback()
				SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Inclus$$HEX1$$e300$$ENDHEX$$o")
				lvb_Sucesso = False
			End If				
		Case -1
			SqlCa.of_Rollback()
			SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o")
			lvb_Sucesso = False
	End Choose		
End If

If lvb_Sucesso Then
	If SqlCa.of_Commit() = -1 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Commit")
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_atualiza_item_nf_transferencia (string ps_registro, integer pi_log);String lvs_Chave_LOG, &
       lvs_Operacao, &
       lvs_Especie, &
		 lvs_Serie, &
		 lvs_Situacao_Tributaria

Long lvl_Filial_Origem, &
     lvl_Filial_Destino, &
	  lvl_NF, &
	  lvl_Produto, &
     lvl_Natureza, &
	  lvl_Qtde
	  
Decimal lvdc_Custo, &
		  lvdc_ICMS, &
		  lvdc_Custo_Gerencial
	 
Boolean lvb_Sucesso = True

lvs_Operacao = MidA(ps_Registro, 4, 1)

If lvs_Operacao = "E" Then Return True

lvl_Filial_Destino = Long(MidA(ps_Registro, 44, 4))

If lvl_Filial_Destino <> This.of_Filial_Parametro() Then Return True

lvl_Filial_Origem       = Long(MidA(ps_Registro, 5, 4))
lvl_NF                  = Long(MidA(ps_Registro, 9, 8))
lvs_Especie             = Trim(MidA(ps_Registro, 17, 3))
lvs_Serie               = Trim(MidA(ps_Registro, 20, 3))
lvl_Natureza            = Long(MidA(ps_Registro, 23, 15))
lvl_Produto             = Long(MidA(ps_Registro, 38, 6))
lvs_Situacao_Tributaria = Trim(MidA(ps_Registro, 48, 2))
lvl_Qtde                = Long(MidA(ps_Registro, 50, 5))
lvdc_Custo              = This.of_Decimal(MidA(ps_Registro, 55, 7))
lvdc_ICMS               = This.of_Decimal(MidA(ps_Registro, 62, 5))
lvdc_Custo_Gerencial    = This.of_Decimal(MidA(ps_Registro, 67, 7))
		
lvs_Chave_Log = "ITEM_NF_TRANSFERENCIA (" + String(lvl_Filial_Origem, "0000") + "-" + &
														  String(lvl_NF, "00000000") + "-" + &
														  lvs_Especie + "-" + &
														  lvs_Serie + "-" + &
														  String(lvl_Natureza) + "-" + &
														  String(lvl_Produto, "000000") + ") "
		
If LenA(ps_Registro) <> 66 and LenA(ps_Registro) <> 74 Then
	SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Registro Inv$$HEX1$$e100$$ENDHEX$$lido")	
	Return False
End If

Select nr_nf Into :lvl_NF
From item_nf_transferencia
Where cd_filial_origem     = :lvl_Filial_Origem
  and nr_nf                = :lvl_NF
  and de_especie           = :lvs_Especie
  and de_serie             = :lvs_Serie
  and cd_natureza_operacao = :lvl_Natureza
  and cd_produto           = :lvl_Produto
Using SqlCa;
			
Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100		
		If lvdc_Custo_Gerencial = 0 Then SetNull(lvdc_Custo_Gerencial)
		
		Insert Into item_nf_transferencia (cd_filial_origem,   
													  nr_nf,   
													  de_especie,   
													  de_serie,   
													  cd_natureza_operacao,   
													  cd_produto,   
													  cd_filial_destino,   
													  cd_situacao_tributaria,   
													  qt_transferida,   
													  vl_custo_unitario,   
													  pc_icms,
													  vl_custo_gerencial)  
		Values (:lvl_Filial_Origem,   
				  :lvl_NF,   
				  :lvs_Especie,   
				  :lvs_Serie,   
				  :lvl_Natureza,   
				  :lvl_Produto,   
				  :lvl_Filial_Destino,   
				  :lvs_Situacao_Tributaria,   
				  :lvl_Qtde,   
				  :lvdc_Custo,   
				  :lvdc_ICMS,
				  :lvdc_Custo_Gerencial)
		Using SqlCa;

		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback()
			SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Inclus$$HEX1$$e300$$ENDHEX$$o")
			lvb_Sucesso = False
		End If				
	Case -1
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o")
		lvb_Sucesso = False
End Choose		
	
If lvb_Sucesso Then
	If SqlCa.of_Commit() = -1 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Commit")
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_verifica_saldo_atual_cc (string ps_conta, ref decimal pdc_saldo_atual);Decimal lvdc_Vendas, &
        lvdc_Titulos, &
		  lvdc_Outros

select vl_vendas,
       vl_titulos,
		 vl_outros
Into :lvdc_Vendas,
     :lvdc_Titulos,
	  :lvdc_Outros
From contas_receber_saldo crs,
     parametro p
Where crs.cd_conta      = :ps_Conta
  and crs.id_tipo_conta = 'CC'
  and crs.dh_conta      = p.dh_fechamento_contas_receber
  and p.id_parametro    = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do saldo atual para o cliente: " + ps_Conta)
		Return False
	Case 100
		pdc_Saldo_Atual = 0.00
		
		Return True
	Case 0
		pdc_Saldo_Atual = lvdc_Vendas + lvdc_Titulos - lvdc_Outros
		
		If pdc_Saldo_Atual < 0 Then pdc_Saldo_Atual = 0.00
		
		Return True
End Choose
end function

public function boolean of_verifica_titulos_aberto_cr (string ps_conta, ref decimal pdc_vl_titulos_aberto);select vl_titulos
Into :pdc_Vl_Titulos_Aberto
From contas_receber_saldo crs,
     parametro p
Where crs.cd_conta      = :ps_Conta
  and crs.id_tipo_conta = 'CR'
  and crs.dh_conta      = p.dh_fechamento_contas_receber
  and p.id_parametro    = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do valor de t$$HEX1$$ed00$$ENDHEX$$tulos em aberto para o cliente: " + ps_Conta)
		Return False
	Case 100
		pdc_Vl_Titulos_Aberto = 0.00
		
		Return True
	Case 0
		Return True
End Choose
end function

public function boolean of_registro_problema_bloqueio (string ps_chave, string ps_atualizacao, ref string ps_registro);Boolean lvb_Retorno = True

String lvs_Tabela = "991", &
       lvs_Tipo, &
		 lvs_Motivo, &
		 lvs_Usuario_Bloqueio, &
		 lvs_Cliente, &
		 lvs_Conveniado

Long lvl_Filial, &
	  lvl_Bloqueio, &
	  lvl_Convenio, &
	  lvl_Clube, &
	  lvl_Dependente

DateTime lvdh_Bloqueio
			
lvl_Filial   = Long(This.of_Coluna_Chave_Log(ps_Chave, 1))
lvl_Bloqueio = Long(This.of_Coluna_Chave_Log(ps_Chave, 2))

If ps_Atualizacao <> "E" Then	
	Select id_tipo_bloqueio,   
          cd_motivo_bloqueio,   
          dh_bloqueio,   
          nr_matricula_bloqueio,   
          cd_cliente,   
          cd_clube_cliente,   
          cd_convenio,   
          cd_conveniado,   
          cd_dependente
   Into :lvs_Tipo,   
        :lvs_Motivo,   
        :lvdh_Bloqueio,   
        :lvs_Usuario_Bloqueio,   
        :lvs_Cliente,   
        :lvl_Clube,   
        :lvl_Convenio,   
        :lvs_Conveniado,   
        :lvl_Dependente
   From bloqueio  
   Where cd_filial   = :lvl_Filial
     and nr_bloqueio = :lvl_Bloqueio
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If IsNull(lvl_Convenio)           Then lvl_Convenio = 0
			If IsNull(lvl_Dependente)         Then lvl_Dependente = 0
			If IsNull(lvl_Clube)              Then lvl_Clube = 0
			
			ps_Registro = lvs_Tabela + ps_Atualizacao + &
							  String(lvl_Filial, "0000") + &
							  String(lvl_Bloqueio, "00000000") + &
							  This.of_String(lvs_Tipo, 3) + &
							  This.of_String(lvs_Motivo, 3) + &
							  This.of_Date(lvdh_Bloqueio) + &
							  This.of_String(lvs_Usuario_Bloqueio, 6) + &
							  This.of_String(lvs_Cliente, 11) + &
							  String(lvl_Clube, "000") + &
							  String(lvl_Convenio, "00000") + &
							  This.of_String(lvs_Conveniado, 15) + &
							  String(lvl_Dependente, "000")
							  
		Case 100
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Bloqueio (Problema)")
			Return False
	End Choose	
Else
	ps_Registro = lvs_Tabela + ps_Atualizacao + &
					  String(lvl_Filial, "0000") + &
					  String(lvl_Bloqueio, "00000000")
End If		

Return lvb_Retorno
end function

public function boolean of_registro_problema_titulo_receber (string ps_chave, string ps_atualizacao, ref string ps_registro);Boolean lvb_Retorno = True

String lvs_Tabela = "992", &
       lvs_Titulo, &
		 lvs_Tipo, &
		 lvs_Situacao, &
		 lvs_Carne, &
		 lvs_Protesto, &
		 lvs_Cliente, &
		 lvs_Serie, &
		 lvs_Especie

Long lvl_Filial, &
	  lvl_Filial_NF, &
	  lvl_NF, &
	  lvl_Convenio, &
	  lvl_Portador

Decimal lvdc_Juros, &
        lvdc_Nominal, &
		  lvdc_Desconto, &
		  lvdc_Despesas_Pagas, &
		  lvdc_Despesas_Recebidas, &
		  lvdc_Recebido, &
		  lvdc_Aberto

DateTime lvdh_Emissao, &
			lvdh_Vencimento, &
			lvdh_Juros, &
			lvdh_Baixa
			
lvs_Titulo = This.of_Coluna_Chave_Log(ps_Chave, 1)

If ps_Atualizacao <> "E" Then	
	Select cd_filial,   
          id_tipo_titulo,   
          cd_portador,   
          dh_emissao,   
          dh_vencimento,   
          dh_calculo_juros,   
          vl_nominal,   
          vl_juros_recebidos,   
          vl_desconto_concedido,   
          vl_despesas_pagas,   
          vl_despesas_recebidas,   
          vl_recebido,   
          vl_aberto,   
          id_situacao,   
          id_carne_bloqueto,   
          id_protesto,   
          dh_baixa,   
          cd_convenio,   
          cd_cliente,   
          cd_filial_nf,   
          nr_nf,   
          de_especie,   
          de_serie
   Into :lvl_Filial,   
        :lvs_Tipo,   
        :lvl_Portador,   
        :lvdh_Emissao,   
        :lvdh_Vencimento,   
        :lvdh_Juros,   
        :lvdc_Nominal,   
        :lvdc_Juros,   
        :lvdc_Desconto,   
        :lvdc_Despesas_Pagas,   
        :lvdc_Despesas_Recebidas,   
        :lvdc_Recebido,   
        :lvdc_Aberto,   
        :lvs_Situacao,   
        :lvs_Carne,   
        :lvs_Protesto,   
        :lvdh_Baixa,   
        :lvl_Convenio,   
        :lvs_Cliente,   
        :lvl_Filial_NF,   
        :lvl_NF,   
        :lvs_Especie,   
        :lvs_Serie
   From titulo_receber  
   Where nr_titulo = :lvs_Titulo
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If IsNull(lvl_Convenio) Then lvl_Convenio = 0
			If IsNull(lvl_Filial_NF) Then lvl_Filial_NF = 0
			If IsNull(lvl_NF) Then lvl_NF = 0
			
			ps_Registro = lvs_Tabela + ps_Atualizacao + &
							  lvs_Titulo + &
							  String(lvl_Filial, "0000") + &
							  This.of_String(lvs_Tipo, 2) + &
							  String(lvl_Portador, "0000") + &
							  This.of_Date(lvdh_Emissao) + &
							  This.of_Date(lvdh_Vencimento) + &
							  This.of_Date(lvdh_Juros) + &
							  This.of_Decimal(lvdc_Nominal, 9) + &
							  This.of_Decimal(lvdc_Juros, 9) + &
							  This.of_Decimal(lvdc_Desconto, 9) + &
							  This.of_Decimal(lvdc_Despesas_Pagas, 9) + &
							  This.of_Decimal(lvdc_Despesas_Recebidas, 9) + &
							  This.of_Decimal(lvdc_Recebido, 9) + &
							  This.of_Decimal(lvdc_Aberto, 9) + &
  							  lvs_Situacao + &
							  This.of_String(lvs_Carne, 1) + &
							  This.of_String(lvs_Protesto, 1) + &
							  This.of_Date(lvdh_Baixa) + &
							  String(lvl_Convenio, "00000") + &
							  This.of_String(lvs_Cliente, 11) + &
							  String(lvl_Filial_NF, "0000") + &
							  String(lvl_NF, "00000000") + &
							  This.of_String(lvs_Especie, 3) + &
							  This.of_String(lvs_Serie, 3)
							  
		Case 100
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do T$$HEX1$$ed00$$ENDHEX$$tulo (Problema)")
			Return False
	End Choose	
Else
	ps_Registro = lvs_Tabela + ps_Atualizacao + lvs_Titulo
End If		

Return lvb_Retorno
end function

public function boolean of_registro_problema_movimento_titulo_re (string ps_chave, string ps_atualizacao, ref string ps_registro);Boolean lvb_Retorno = True

String lvs_Tabela = "993", &
       lvs_Titulo, &
		 lvs_Usuario, &
		 lvs_Historico, &
		 lvs_Estorno, &
		 lvs_Recibo

Long lvl_Tipo, &
	  lvl_Filial_Movimento, &
	  lvl_Movimento

DateTime lvdh_Sistema, &
			lvdh_Movimento, &
			lvdh_Credito
	
Decimal lvdc_Movimento, &
        lvdc_Juros, &
		  lvdc_Desconto, &
		  lvdc_Despesas
			
lvs_Titulo           = This.of_Coluna_Chave_Log(ps_Chave, 1)
lvl_Filial_Movimento = Long(This.of_Coluna_Chave_Log(ps_Chave, 2))
lvl_Movimento        = Long(This.of_Coluna_Chave_Log(ps_Chave, 3))

If ps_Atualizacao <> "E" Then	
	Select cd_tipo_movimento,   
          nr_matricula_responsavel,   
          dh_sistema,   
          dh_movimento,   
          dh_credito,   
          vl_movimento,   
          vl_juros_recebidos,   
          vl_desconto_concedido,   
          vl_despesas_recebidas,   
          id_estorno,   
          de_historico,   
          nr_recibo_cobranca
   Into :lvl_Tipo,   
        :lvs_Usuario,   
        :lvdh_Sistema,   
        :lvdh_Movimento,   
        :lvdh_Credito,   
        :lvdc_Movimento,   
        :lvdc_Juros,   
        :lvdc_Desconto,   
        :lvdc_Despesas,   
        :lvs_Estorno,   
        :lvs_Historico,   
        :lvs_Recibo
   From movimento_titulo_receber  
   Where nr_titulo           = :lvs_Titulo
     and cd_filial_movimento = :lvl_Filial_Movimento
     and nr_movimento        = :lvl_Movimento
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			ps_Registro = lvs_Tabela + ps_Atualizacao + &
							  lvs_Titulo + &
							  String(lvl_Filial_Movimento, "0000") + &
							  String(lvl_Movimento, "000") + &
							  String(lvl_Tipo, "00") + &
							  This.of_String(lvs_Usuario, 6) + &
							  This.of_DateTime(lvdh_Sistema) + &
							  This.of_Date(lvdh_Movimento) + &
							  This.of_Date(lvdh_Credito) + &
							  This.of_Decimal(lvdc_Movimento, 9) + &
							  This.of_Decimal(lvdc_Juros, 9) + &
							  This.of_Decimal(lvdc_Desconto, 9) + &
							  This.of_Decimal(lvdc_Despesas, 9) + &
							  This.of_String(lvs_Estorno, 1) + &
							  This.of_String(lvs_Historico, 50) + &
							  This.of_String(lvs_Recibo, 11)
							  
		Case 100
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Movimento do T$$HEX1$$ed00$$ENDHEX$$tulo (Problema)")
			Return False
	End Choose	
Else
	ps_Registro = lvs_Tabela + ps_Atualizacao + &
					  lvs_Titulo + &
					  String(lvl_Filial_Movimento, "0000") + &
					  String(lvl_Movimento, "000")
End If		

Return lvb_Retorno
end function

public function boolean of_atualiza_problema_bloqueio (string ps_registro, integer pi_log);String lvs_Chave_LOG, &
       lvs_Operacao, &
       lvs_Tipo, &
		 lvs_Motivo, &
		 lvs_Usuario_Bloqueio, &
		 lvs_Cliente, &
		 lvs_Conveniado

Long lvl_Filial, &
	  lvl_Bloqueio, &
	  lvl_Convenio, &
	  lvl_Clube, &
	  lvl_Dependente, &
	  lvl_Filial_Parametro

Date lvdt_Bloqueio

Boolean lvb_Sucesso = True

lvs_Operacao = MidA(ps_Registro, 4, 1)
lvl_Filial   = Long(MidA(ps_Registro, 5, 4))
lvl_Bloqueio = Long(MidA(ps_Registro, 9, 8))

lvs_Chave_Log = "PROBLEMA_BLOQUEIO (" + String(lvl_Filial, "0000")  + "-" + &
										 String(lvl_Bloqueio) + ") "

If lvs_Operacao = "E" Then
	Delete From bloqueio
	Where cd_filial   = :lvl_Filial
	  and nr_bloqueio = :lvl_Bloqueio
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback()
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o")
		lvb_Sucesso = False
	End If
Else
	If LenA(ps_Registro) <> 73 and LenA(ps_Registro) <> 74 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Registro Inv$$HEX1$$e100$$ENDHEX$$lido")	
		Return False
	End If

	lvs_Tipo               = Trim(MidA(ps_Registro, 17, 3))
	lvs_Motivo             = Trim(MidA(ps_Registro, 20, 3))
	lvdt_Bloqueio          = This.of_Date(MidA(ps_Registro, 23, 8))
	lvs_Usuario_Bloqueio   = Trim(MidA(ps_Registro, 31, 6))
	lvs_Cliente            = Trim(MidA(ps_Registro, 37, 11))
	lvl_Clube              = Long(MidA(ps_Registro, 48, 3))
	lvl_Convenio           = Long(MidA(ps_Registro, 51, 5))
	lvs_Conveniado         = Trim(MidA(ps_Registro, 56, 15))
	lvl_Dependente         = Long(MidA(ps_Registro, 71, 3))
	
	If lvl_Convenio = 0                 Then SetNull(lvl_Convenio)
	If lvl_Clube = 0                    Then SetNull(lvl_Clube)
	If lvl_Dependente = 0               Then SetNull(lvl_Dependente)
	If Trim(lvs_Conveniado) = ""        Then SetNull(lvs_Conveniado)
	If Trim(lvs_Cliente) = ""           Then SetNull(lvs_Cliente)
	
	Update bloqueio
	Set id_tipo_bloqueio       = :lvs_Tipo,
		 cd_motivo_bloqueio     = :lvs_Motivo,
		 dh_bloqueio            = :lvdt_Bloqueio,
		 nr_matricula_bloqueio  = :lvs_Usuario_Bloqueio,
		 cd_cliente             = :lvs_Cliente,
		 cd_clube_cliente       = :lvl_Clube,
		 cd_convenio            = :lvl_Convenio,
		 cd_conveniado          = :lvs_Conveniado,
		 cd_dependente          = :lvl_Dependente
	Where cd_filial   = :lvl_Filial
	  and nr_bloqueio = :lvl_Bloqueio 
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback()
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Atualiza$$HEX2$$e700e300$$ENDHEX$$o")
		lvb_Sucesso = False
	Else
		If SqlCa.SqlNRows = 0 Then
			Insert Into bloqueio (cd_filial,   
										 nr_bloqueio,   
										 id_tipo_bloqueio,   
										 cd_motivo_bloqueio,   
										 dh_bloqueio,   
										 nr_matricula_bloqueio,   
										 cd_cliente,   
										 cd_clube_cliente,   
										 cd_convenio,   
										 cd_conveniado,   
										 cd_dependente)  
			Values (:lvl_Filial,
					  :lvl_Bloqueio,   
					  :lvs_Tipo,   
					  :lvs_Motivo,   
					  :lvdt_Bloqueio,   
					  :lvs_Usuario_Bloqueio,   
					  :lvs_Cliente,   
					  :lvl_Clube,   
					  :lvl_Convenio,   
					  :lvs_Conveniado,   
					  :lvl_Dependente)
			Using SqlCa;

			If SqlCa.SqlCode = -1 Then
				SqlCa.of_Rollback()
				SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Inclus$$HEX1$$e300$$ENDHEX$$o")
				lvb_Sucesso = False
			End If
		End If
	End If
End If

If lvb_Sucesso Then
	If SqlCa.of_Commit() = -1 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Commit")
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_atualiza_problema_titulo_receber (string ps_registro, integer pi_log);String lvs_Chave_LOG, &
       lvs_Operacao, &
		 lvs_Titulo, &
		 lvs_Tipo, &
		 lvs_Situacao, &
		 lvs_Carne, &
		 lvs_Protesto, &
		 lvs_Cliente, &
		 lvs_Serie, &
		 lvs_Especie, &
		 lvs_Achou

Integer lvi_Qt_Movimentos

Long lvl_Filial, &
	  lvl_Filial_NF, &
	  lvl_NF, &
	  lvl_Convenio, &
	  lvl_Portador

Decimal lvdc_Juros, &
        lvdc_Nominal, &
		  lvdc_Desconto, &
		  lvdc_Despesas_Pagas, &
		  lvdc_Despesas_Recebidas, &
		  lvdc_Recebido, &
		  lvdc_Aberto

Date lvdt_Emissao, &
	  lvdt_Vencimento, &
	  lvdt_Juros, &
	  lvdt_Baixa

Boolean lvb_Sucesso = True

lvs_Operacao = MidA(ps_Registro, 4, 1)
lvs_Titulo   = MidA(ps_Registro, 5, 13)

lvs_Chave_Log = "PROBLEMA_TITULO_RECEBER (" + lvs_Titulo  + ") "

// Verifica se existem pagamentos no dia, se existirem os mesmos n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e300$$ENDHEX$$o ser 
// exclu$$HEX1$$ed00$$ENDHEX$$dos
If Not This.of_Verifica_Titulo_Pago_Dia(lvs_Titulo, lvi_Qt_Movimentos) Then Return False

If lvi_Qt_Movimentos > 0 Then
	SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Existem pagamentos deste t$$HEX1$$ed00$$ENDHEX$$tulo")
	Return True
Else
	// Exclui os movimentos
	Delete From movimento_titulo_receber
	Where nr_titulo = :lvs_Titulo
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback()
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o Movimento_Titulo_Receber")
		lvb_Sucesso = False
	End If				

	// Exclui o t$$HEX1$$ed00$$ENDHEX$$tulo
	Delete From titulo_receber
	Where nr_titulo = :lvs_Titulo
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback()
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o Titulo_Receber")
		lvb_Sucesso = False
	End If				
	
	If lvs_Operacao = "I" Then
		
		If LenA(ps_Registro) <> 159 and LenA(ps_Registro) <> 160 Then
			SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Registro Inv$$HEX1$$e100$$ENDHEX$$lido")	
			Return False
		End If
		
		lvl_Filial              = Long(MidA(ps_Registro, 18, 4))
		lvs_Tipo                = Trim(MidA(ps_Registro, 22, 2))
		lvl_Portador            = Long(MidA(ps_Registro, 24, 4))
		lvdt_Emissao            = This.of_Date(MidA(ps_Registro, 28, 8))
		lvdt_Vencimento         = This.of_Date(MidA(ps_Registro, 36, 8))
		lvdt_Juros              = This.of_Date(MidA(ps_Registro, 44, 8))
		lvdc_Nominal            = This.of_Decimal(MidA(ps_Registro, 52, 9))
		lvdc_Juros              = This.of_Decimal(MidA(ps_Registro, 61, 9))
		lvdc_Desconto           = This.of_Decimal(MidA(ps_Registro, 70, 9))
		lvdc_Despesas_Pagas     = This.of_Decimal(MidA(ps_Registro, 79, 9))
		lvdc_Despesas_Recebidas = This.of_Decimal(MidA(ps_Registro, 88, 9))
		lvdc_Recebido           = This.of_Decimal(MidA(ps_Registro, 97, 9))
		lvdc_Aberto             = This.of_Decimal(MidA(ps_Registro, 106, 9))
		lvs_Situacao            = Trim(MidA(ps_Registro, 115, 1))
		lvs_Carne               = Trim(MidA(ps_Registro, 116, 1))
		lvs_Protesto            = Trim(MidA(ps_Registro, 117, 1))
		lvdt_Baixa              = This.of_Date(MidA(ps_Registro, 118, 8))
		lvl_Convenio            = Long(MidA(ps_Registro, 126, 5))
		lvs_Cliente             = Trim(MidA(ps_Registro, 131, 11))
		lvl_Filial_NF           = Long(MidA(ps_Registro, 142, 4))
		lvl_NF                  = Long(MidA(ps_Registro, 146, 8))
		lvs_Especie             = Trim(MidA(ps_Registro, 154, 3))
		lvs_Serie               = Trim(MidA(ps_Registro, 157, 3))
		
		If lvl_Convenio = 0  Then SetNull(lvl_Convenio)
		If Trim(lvs_Cliente) = "" Then SetNull(lvs_Cliente)
		
		If lvl_Filial_NF = 0 Then SetNull(lvl_Filial_NF)
		If lvl_NF = 0        Then SetNull(lvl_NF)
		If Trim(lvs_Especie) = "" Then SetNull(lvs_Especie)
		If Trim(lvs_Serie) = "" Then SetNull(lvs_Serie)
		
		// Os t$$HEX1$$ed00$$ENDHEX$$tulos s$$HEX1$$e300$$ENDHEX$$o inclu$$HEX1$$ed00$$ENDHEX$$dos sempre em aberto,
		// pois os movimentos far$$HEX1$$e300$$ENDHEX$$o a atualiza$$HEX2$$e700e300$$ENDHEX$$o dos valores atrav$$HEX1$$e900$$ENDHEX$$s da trigger
		lvdc_Juros              = 0   
		lvdc_Desconto           = 0   
		lvdc_Despesas_Recebidas = 0 
		lvdc_Recebido           = 0   
		lvdc_Aberto             = lvdc_Nominal  
		lvs_Situacao            = 'A'   
		lvdt_Juros              = lvdt_Vencimento
		SetNull(lvdt_Baixa)
		
		Insert Into titulo_receber (nr_titulo,   
											 cd_filial,   
											 id_tipo_titulo,   
											 cd_portador,   
											 dh_emissao,   
											 dh_vencimento,   
											 dh_calculo_juros,   
											 vl_nominal,   
											 vl_juros_recebidos,   
											 vl_desconto_concedido,   
											 vl_despesas_pagas,   
											 vl_despesas_recebidas,   
											 vl_recebido,   
											 vl_aberto,   
											 id_situacao,   
											 id_carne_bloqueto,   
											 id_protesto,   
											 dh_baixa,   
											 cd_convenio,   
											 cd_cliente,   
											 cd_filial_nf,   
											 nr_nf,   
											 de_especie,   
											 de_serie,   
											 cd_filial_atualizacao,
											 dh_atualizacao_filial)  
		Values (:lvs_Titulo,
				  :lvl_Filial,   
				  :lvs_Tipo,   
				  :lvl_Portador,   
				  :lvdt_Emissao,   
				  :lvdt_Vencimento,   
				  :lvdt_Juros,   
				  :lvdc_Nominal,   
				  :lvdc_Juros,   
				  :lvdc_Desconto,   
				  :lvdc_Despesas_Pagas,   
				  :lvdc_Despesas_Recebidas,   
				  :lvdc_Recebido,   
				  :lvdc_Aberto,   
				  :lvs_Situacao,   
				  :lvs_Carne,   
				  :lvs_Protesto,   
				  :lvdt_Baixa,   
				  :lvl_Convenio,   
				  :lvs_Cliente,   
				  :lvl_Filial_NF,   
				  :lvl_NF,   
				  :lvs_Especie,   
				  :lvs_Serie,   
				  534,
				  getdate())
		Using SqlCa;
	
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback()
			SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Inclus$$HEX1$$e300$$ENDHEX$$o")
			lvb_Sucesso = False
		End If
	End If
End If

If lvb_Sucesso Then
	If SqlCa.of_Commit() = -1 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Commit")
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_atualiza_problema_movimento_titulo_re (string ps_registro, integer pi_log);String lvs_Chave_LOG, &
       lvs_Operacao, &
       lvs_Titulo, &
		 lvs_Usuario, &
		 lvs_Historico, &
		 lvs_Estorno, &
		 lvs_Recibo, &
		 lvs_Achou

DateTime lvdh_Sistema
	
Date lvdt_Movto, &
     lvdt_Credito
	  
Decimal lvdc_Movimento, &
        lvdc_Juros, &
		  lvdc_Desconto, &
		  lvdc_Despesas

Long lvl_Filial_Movto, &
	  lvl_Movto, &
	  lvl_Tipo

Boolean lvb_Sucesso = True, &
        lvb_Atualiza

lvs_Operacao     = MidA(ps_Registro, 4, 1)
lvs_Titulo       = MidA(ps_Registro, 5, 13)
lvl_Filial_Movto = Long(MidA(ps_Registro, 18, 4))
lvl_Movto        = Long(MidA(ps_Registro, 22, 3))

lvs_Chave_Log = "PROBLEMA_MOVIMENTO_TITULO_RECEBER (" + lvs_Titulo  + "-" + &
                                               String(lvl_Filial_Movto, "0000") + "-" + &
															  String(lvl_Movto, "000") + ") "

If lvs_Operacao = "I" Then
	
	If LenA(ps_Registro) <> 160 and LenA(ps_Registro) <> 161 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Registro Inv$$HEX1$$e100$$ENDHEX$$lido")	
		Return False
	End If
	
	lvl_Tipo            = Long(MidA(ps_Registro, 25, 2))
	lvs_Usuario         = Trim(MidA(ps_Registro, 27, 6))
	lvdh_Sistema        = This.of_DateTime(MidA(ps_Registro, 33, 14))
	lvdt_Movto          = This.of_Date(MidA(ps_Registro, 47, 8))
	lvdt_Credito        = This.of_Date(MidA(ps_Registro, 55, 8))
	lvdc_Movimento      = This.of_Decimal(MidA(ps_Registro, 63, 9))
	lvdc_Juros          = This.of_Decimal(MidA(ps_Registro, 72, 9))
	lvdc_Desconto       = This.of_Decimal(MidA(ps_Registro, 81, 9))
	lvdc_Despesas       = This.of_Decimal(MidA(ps_Registro, 90, 9))
	lvs_Estorno         = Trim(MidA(ps_Registro, 99, 1))
	lvs_Historico       = Trim(MidA(ps_Registro, 100, 50))
	lvs_Recibo          = Trim(MidA(ps_Registro, 150, 11))
	
	If Trim(lvs_Recibo) = "" Then SetNull(lvs_Recibo)
	
	Update movimento_titulo_receber
	Set id_estorno            = :lvs_Estorno,
		 cd_filial_atualizacao = 534,
		 dh_atualizacao_filial = getdate()
	Where nr_titulo           = :lvs_Titulo
	  and cd_filial_movimento = :lvl_Filial_Movto
	  and nr_movimento        = :lvl_Movto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback()
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Atualiza$$HEX2$$e700e300$$ENDHEX$$o")
		lvb_Sucesso = False
	Else
		If SqlCa.SqlNRows = 0 Then
			Insert Into movimento_titulo_receber (nr_titulo,   
															  cd_filial_movimento,   
															  nr_movimento,   
															  cd_tipo_movimento,   
															  nr_matricula_responsavel,   
															  dh_sistema,   
															  dh_movimento,   
															  dh_credito,   
															  vl_movimento,   
															  vl_juros_recebidos,   
															  vl_desconto_concedido,   
															  vl_despesas_recebidas,   
															  id_estorno,   
															  de_historico,   
															  nr_recibo_cobranca,   
															  cd_filial_atualizacao,   
															  dh_atualizacao_filial)  
			Values (:lvs_Titulo,   
					  :lvl_Filial_Movto,   
					  :lvl_Movto,   
					  :lvl_Tipo,   
					  :lvs_Usuario,   
					  :lvdh_Sistema,   
					  :lvdt_Movto,   
					  :lvdt_Credito,   
					  :lvdc_Movimento,   
					  :lvdc_Juros,   
					  :lvdc_Desconto,   
					  :lvdc_Despesas,   
					  :lvs_Estorno,   
					  :lvs_Historico,   
					  :lvs_Recibo,   
					  534,   
					  getdate())
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_Rollback()
				SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Inclus$$HEX1$$e300$$ENDHEX$$o")
				lvb_Sucesso = False
			End If
		End If
	End If
End If

If lvb_Sucesso Then
	If SqlCa.of_Commit() = -1 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Commit")
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_verifica_titulo_pago_dia (string ps_titulo, ref integer pi_qt_movimentos);Boolean lvb_Sucesso = True

select count(*) into :pi_Qt_Movimentos
from movimento_titulo_receber m,
     parametro p
where m.nr_titulo             = :ps_Titulo
  and m.cd_filial_atualizacao = p.cd_filial
  and m.dh_atualizacao_filial = p.dh_movimentacao
  and p.id_parametro          = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.Of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos movimentos de pagamentos do t$$HEX1$$ed00$$ENDHEX$$tulo: " + ps_Titulo)
		lvb_Sucesso = False
	Case 100
	Case 0
End Choose

Return lvb_Sucesso
end function

public function string of_retira_caracter_enter (string ps_string);String lvl_limpo, &
       lvl_auxlimpo
		 
Integer lvl_posicao1, &
        lvl_contador, &
		  lvl_posicao2
		  
Boolean lvl_exist

//Procura o caracter enter
lvl_posicao1 = PosA(ps_string,CharA(13))
lvl_posicao2 = PosA(ps_string,CharA(10))

//VerIfica se existe pelo menos 1 dos caracteres que
//constituem o <e> -> char(10)+char(13)

If lvl_posicao1 > 0 and not isnull(lvl_posicao1) Then
	lvl_exist = True
ElseIf lvl_posicao2 > 0 and not isnull(lvl_posicao2) Then
	lvl_exist = True
Else
	lvl_exist = False
	Return(ps_string)
End If

//A primeira vez, vai ser o valor do parametro
lvl_limpo = ps_string

//Rotina para retirar todos os caracteres "enter" da string

DO WHILE lvl_exist = True
  lvl_auxlimpo = lvl_limpo
  lvl_posicao1 = PosA(lvl_auxlimpo,CharA(13))
  If  lvl_posicao1 > 0 and not isnull(lvl_posicao1) Then
    lvl_limpo = ReplaceA (lvl_auxlimpo,lvl_posicao1,1,' ')
  Else
    lvl_exist = False
End If

LOOP

lvl_exist = True

//Rotina para retirar todos os caracteres "enter" da string

DO WHILE lvl_exist = True
  lvl_auxlimpo = lvl_limpo
  lvl_posicao1 = PosA(lvl_auxlimpo,CharA(10))

 If  lvl_posicao1 > 0 and not isnull(lvl_posicao1) Then
  lvl_limpo = ReplaceA (lvl_auxlimpo,lvl_posicao1,1,' ')
 Else
  lvl_exist = False
End If

LOOP

//Retorna a string j$$HEX1$$e100$$ENDHEX$$ limpa
Return(lvl_limpo)
end function

public function boolean of_atualiza_cliente_dependente (string ps_registro, integer pi_log);Boolean lvb_Sucesso = True

Long lvl_Cd_Filial_Atualizacao, &
	  lvl_Filial_Parametro, &
	  lvl_Cd_Filial_Alteracao_Senha

String lvs_Chave_LOG, &
       lvs_Operacao, &
		 lvs_Cd_Dependente_Cliente, &
		 lvs_Nm_Dependente, &
		 lvs_Id_Grau_Parentesco, &
		 lvs_id_situacao, &
		 lvs_Cd_Cliente, &
		 lvs_Nr_Matricula_Atualizacao, &
		 lvs_De_Senha_Venda_Credito, &
		 lvs_Nr_Matric_Alteracao_Senha

DateTime lvdh_Dh_Nascimento, &
		   lvdh_Dh_Atualizacao, &
			lvdh_Dh_Alteracao_Senha

lvs_Operacao   			 	= MidA(ps_Registro, 4, 1)
lvs_Cd_Dependente_Cliente  = MidA(ps_Registro, 5, 13)
lvs_Chave_Log 					= "CLIENTE_DEPENDENTE (" + This.of_String(lvs_Cd_Dependente_Cliente, 13) + ") "

If lvs_Operacao = "E" Then
	Delete From cliente_dependente
	Where cd_dependente_cliente = :lvs_Cd_Dependente_Cliente
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback()
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o")
		lvb_Sucesso = False
	End If				
Else
	If LenA(ps_Registro) <> 143 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Registro Inv$$HEX1$$e100$$ENDHEX$$lido")	
		Return False
	End If
	
	lvs_Nm_Dependente					= Trim(MidA(ps_Registro, 18, 40))
	lvdh_Dh_Nascimento			 	= This.of_DateTime(MidA(ps_Registro, 58, 14))
	lvs_Id_Grau_Parentesco 			= Trim(MidA(ps_Registro, 72, 1))
	lvs_Cd_Cliente    		  		= Trim(MidA(ps_Registro, 73, 11))
	lvs_id_situacao					= Trim(MidA(ps_Registro, 84, 1))
	lvl_Cd_Filial_Atualizacao		= Long(MidA(ps_Registro, 85, 4))
	lvdh_Dh_Atualizacao				= This.of_DateTime(MidA(ps_Registro, 89, 14))
	lvs_Nr_Matricula_Atualizacao  = Trim(MidA(ps_Registro, 103, 6))
	lvs_De_Senha_Venda_Credito    = Trim(MidA(ps_Registro, 109, 10))
	lvdh_Dh_Alteracao_Senha       = This.of_DateTime(MidA(ps_Registro, 119, 133))
	lvl_Cd_Filial_Alteracao_Senha = Long(Trim(MidA(ps_Registro, 133, 4)))
	lvs_Nr_Matric_Alteracao_Senha = Trim(MidA(ps_Registro, 137, 6))
	
	If lvl_Cd_Filial_Alteracao_Senha = 0 Then SetNull(lvl_Cd_Filial_Alteracao_Senha)

	Select cd_dependente_cliente Into :lvs_Cd_Dependente_Cliente
  	  From cliente_dependente  
	 Where cd_dependente_cliente = :lvs_Cd_Dependente_Cliente
	 Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			lvl_Filial_Parametro = This.of_Filial_Parametro()
			
			If lvl_Filial_Parametro <> lvl_Cd_Filial_Atualizacao Then
				
				Update cliente_dependente
				Set nm_dependente					= :lvs_Nm_Dependente,
					 dh_nascimento					= :lvdh_Dh_Nascimento,
					 id_grau_parentesco			= :lvs_Id_Grau_Parentesco,
					 cd_cliente			 			= :lvs_Cd_Cliente,
					 id_situacao					= :lvs_id_situacao,
					 cd_filial_Atualizacao		= :lvl_Cd_Filial_Atualizacao,
					 dh_atualizacao 				= :lvdh_Dh_Atualizacao,
					 nr_matricula_atualizacao  = :lvs_Nr_Matricula_Atualizacao, 
					 de_senha_venda_credito       = :lvs_De_Senha_Venda_Credito,
					 dh_alteracao_senha           = :lvdh_Dh_Alteracao_Senha,
					 cd_filial_alteracao_senha    = :lvl_Cd_Filial_Alteracao_Senha,
					 nr_matricula_alteracao_senha = :lvs_Nr_Matric_Alteracao_Senha
				Where cd_dependente_cliente   = :lvs_Cd_Dependente_Cliente
				Using SqlCa;
							
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_Rollback()
					SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Atualiza$$HEX2$$e700e300$$ENDHEX$$o")
					lvb_Sucesso = False
				End If
				
			End If
		Case 100
			Insert Into cliente_dependente (cd_dependente_cliente,
													  nm_dependente,
													  dh_nascimento,
													  id_grau_parentesco,
													  cd_cliente,
													  id_situacao,
													  cd_filial_atualizacao,
													  dh_atualizacao,
													  nr_matricula_atualizacao,
													  de_senha_venda_credito,
													  dh_alteracao_senha,
													  cd_filial_alteracao_senha,
													  nr_matricula_alteracao_senha)  
		   Values (:lvs_cd_dependente_cliente,
					  :lvs_nm_dependente,
					  :lvdh_dh_nascimento,
					  :lvs_id_grau_parentesco,
					  :lvs_cd_cliente,
					  :lvs_id_situacao,
					  :lvl_Cd_Filial_Atualizacao,
					  :lvdh_Dh_Atualizacao,
					  :lvs_Nr_Matricula_Atualizacao,
					  :lvs_De_Senha_Venda_Credito,
					  :lvdh_Dh_Alteracao_Senha,
					  :lvl_Cd_Filial_Alteracao_Senha,
					  :lvs_Nr_Matric_Alteracao_Senha)  
			Using SqlCa;

			If SqlCa.SqlCode = -1 Then
				SqlCa.of_Rollback()
				SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Inclus$$HEX1$$e300$$ENDHEX$$o")
				lvb_Sucesso = False
			End If				
		Case -1
			SqlCa.of_Rollback()
			SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o")
			lvb_Sucesso = False
	End Choose		
End If

If lvb_Sucesso Then
	If SqlCa.of_Commit() = -1 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Commit")
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_registro_bloqueio (string ps_chave, string ps_atualizacao, ref string ps_registro);Boolean lvb_Retorno = True

String lvs_Tabela = "703", &
       lvs_Tipo, &
		 lvs_Motivo, &
		 lvs_Usuario_Bloqueio, &
		 lvs_Usuario_Liberacao, &
		 lvs_Cliente, &
		 lvs_Conveniado, &
		 lvs_Cd_Cliente_Dependente

Long lvl_Filial_Atualizacao, &
     lvl_Filial, &
	  lvl_Bloqueio, &
	  lvl_Convenio, &
	  lvl_Clube, &
	  lvl_Dependente

DateTime lvdh_Atualizacao, &
			lvdh_Bloqueio, &
			lvdh_Liberacao
			
lvl_Filial   = Long(This.of_Coluna_Chave_Log(ps_Chave, 1))
lvl_Bloqueio = Long(This.of_Coluna_Chave_Log(ps_Chave, 2))

If ps_Atualizacao <> "E" Then	
	Select id_tipo_bloqueio,   
          cd_motivo_bloqueio,   
          dh_bloqueio,   
          nr_matricula_bloqueio,   
          cd_cliente,   
          cd_clube_cliente,   
          cd_convenio,   
          cd_conveniado,   
          cd_dependente,   
          dh_liberacao,   
          nr_matricula_liberacao,   
          cd_filial_atualizacao,   
          dh_atualizacao_filial,
			 cd_cliente_dependente
   Into :lvs_Tipo,   
        :lvs_Motivo,   
        :lvdh_Bloqueio,   
        :lvs_Usuario_Bloqueio,   
        :lvs_Cliente,   
        :lvl_Clube,   
        :lvl_Convenio,   
        :lvs_Conveniado,   
        :lvl_Dependente,   
        :lvdh_Liberacao,   
        :lvs_Usuario_Liberacao,   
        :lvl_Filial_Atualizacao,   
        :lvdh_Atualizacao,
		  :lvs_Cd_Cliente_Dependente
   From bloqueio  
   Where cd_filial   = :lvl_Filial
     and nr_bloqueio = :lvl_Bloqueio
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If IsNull(lvl_Convenio)           Then lvl_Convenio = 0
			If IsNull(lvl_Dependente)         Then lvl_Dependente = 0
			If IsNull(lvl_Clube)              Then lvl_Clube = 0
			If IsNull(lvl_Filial_Atualizacao) Then lvl_Filial_Atualizacao = 0
			
			ps_Registro = lvs_Tabela + ps_Atualizacao + &
							  String(lvl_Filial, "0000") + &
							  String(lvl_Bloqueio, "00000000") + &
							  This.of_String(lvs_Tipo, 3) + &
							  This.of_String(lvs_Motivo, 3) + &
							  This.of_Date(lvdh_Bloqueio) + &
							  This.of_String(lvs_Usuario_Bloqueio, 6) + &
							  This.of_String(lvs_Cliente, 11) + &
							  String(lvl_Clube, "000") + &
							  String(lvl_Convenio, "00000") + &
							  This.of_String(lvs_Conveniado, 15) + &
							  String(lvl_Dependente, "000") + &
							  This.of_Date(lvdh_Liberacao) + &
							  This.of_String(lvs_Usuario_Liberacao, 6) + &
							  String(lvl_Filial_Atualizacao, "0000") + &
							  This.of_DateTime(lvdh_Atualizacao) + &
							  This.of_String(lvs_Cd_Cliente_Dependente, 13)
							  
		Case 100
		Case -1
			SqlCa.of_Rollback()
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Bloqueio.")
			Return False
	End Choose	
Else
	ps_Registro = lvs_Tabela + ps_Atualizacao + &
					  String(lvl_Filial, "0000") + &
					  String(lvl_Bloqueio, "00000000")
End IF

Return lvb_Retorno
end function

public function string of_number_string (long pl_valor, integer pi_tamanho);String lvs_Zeros

Integer lvi_Contador

If IsNull(pl_Valor) Then pl_Valor = 0

For lvi_Contador = 1 To pi_Tamanho - LenA(String(pl_Valor))
	lvs_Zeros += "0"
Next

Return lvs_Zeros + String(pl_Valor)
end function

public function long of_parametro_filial ();Long lvl_Filial

SELECT p.cd_filial,
		 u.cd_unidade_federacao
  INTO :ivl_Filial_Parametro,
  		 :ivs_UF_Filial
  FROM filial f,
		 parametro p,
		 unidade_federacao u,
		 cidade c
 WHERE p.id_parametro = '1'
   AND f.cd_filial				= p.cd_filial
   AND c.cd_cidade				= f.cd_cidade
   AND u.cd_unidade_federacao = c.cd_unidade_federacao
USING SQLCA;

Choose Case Sqlca.SqlCode
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o localizado na verifica$$HEX2$$e700e300$$ENDHEX$$o da filial.GE059.uo_ge059_troca_dados_comum.of_parametro_filial( )", StopSign!)
		SetNull(ivl_Filial_Parametro)
		SetNull(ivs_UF_Filial)
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar filial do par$$HEX1$$e200$$ENDHEX$$metro." + SqlCa.SqlErrText, StopSign!)
		SetNull(ivl_Filial_Parametro)
		SetNull(ivs_UF_Filial)
End Choose

Return lvl_Filial
end function

public function boolean of_registro_cliente_dependente (string ps_chave, string ps_atualizacao, ref string ps_registro);Boolean lvb_Retorno = True

Long lvl_Cd_Filial_Atualizacao, &
	  lvl_Cd_Filial_Alteracao_Senha

String lvs_Tabela = "025", &
       lvs_Cd_Dependente_Cliente, &
		 lvs_Nm_Dependente, &
		 lvs_Id_grau_Parentesco, &
		 lvs_Cd_Cliente, &
		 lvs_id_situacao, &
		 lvs_Nr_Matricula_Atualizacao, &
		 lvs_De_Senha_Venda_Credito  , &
		 lvs_Nr_Matricula_Alteracao_Senha, &
		 lvs_Registro

DateTime lvdh_Dh_Nascimento, &
			lvdh_Dh_Atualizacao, &
			lvdh_Alteracao_Senha

lvs_Cd_Dependente_Cliente = This.of_Coluna_Chave_Log(ps_Chave, 1)



If ps_Atualizacao <> "E" Then
	Select nm_dependente,
			 dh_nascimento,
			 id_grau_parentesco,
			 cd_cliente,
			 id_situacao,
			 cd_filial_atualizacao,
			 dh_atualizacao,
			 nr_matricula_atualizacao,
			 de_senha_venda_credito,
			 dh_alteracao_senha,
			 cd_filial_alteracao_senha,
			 nr_matricula_alteracao_senha
	Into :lvs_Nm_Dependente,
		  :lvdh_Dh_Nascimento,
		  :lvs_Id_grau_Parentesco,
		  :lvs_Cd_Cliente,
		  :lvs_Id_Situacao,
		  :lvl_Cd_Filial_Atualizacao,
		  :lvdh_Dh_Atualizacao,
		  :lvs_Nr_Matricula_Atualizacao,
		  :lvs_De_Senha_Venda_Credito,
		  :lvdh_Alteracao_Senha,
		  :lvl_Cd_Filial_Alteracao_Senha,
		  :lvs_Nr_Matricula_Alteracao_Senha
	From cliente_dependente
	Where cd_dependente_cliente = :lvs_Cd_Dependente_Cliente
	Using SqlCa;
	
	If IsNull(lvs_Id_Situacao)                  Then lvs_Id_Situacao                  = ""
	If IsNull(lvs_de_senha_venda_credito)       Then lvs_de_senha_venda_credito       = ""
	If IsNull(lvl_Cd_Filial_Alteracao_Senha)    Then lvl_Cd_Filial_Alteracao_Senha    = 0
	If IsNull(lvs_Nr_Matricula_Alteracao_Senha) Then lvs_Nr_Matricula_Alteracao_Senha = ""	
	If IsNull(lvdh_Alteracao_Senha)             Then lvdh_Alteracao_Senha = This.of_DateTime('01011900000000')
	
	
	Choose Case SqlCa.SqlCode
		Case 0
			ps_Registro = lvs_Tabela + ps_Atualizacao + &
							  This.of_String(lvs_Cd_Dependente_Cliente, 13) + &
							  This.of_String(lvs_Nm_Dependente, 40) + &
							  This.of_DateTime(lvdh_Dh_Nascimento) + &
							  lvs_Id_grau_Parentesco + &
							  This.of_String(lvs_Cd_Cliente, 11) + &
							  This.of_String(lvs_id_situacao, 1) + &
							  String(lvl_cd_filial_atualizacao, "0000") + &
							  This.of_DateTime(lvdh_Dh_Atualizacao) + &
							  This.of_String(lvs_nr_matricula_atualizacao, 6) + &
							  This.of_String(lvs_de_senha_venda_credito, 10) + &
							  This.of_DateTime(lvdh_Alteracao_Senha)         + &
							  String(lvl_Cd_Filial_Alteracao_Senha, '0000')  + &
							  This.of_String(lvs_Nr_Matricula_Alteracao_Senha, 6)
		Case 100
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Dependente do Cliente")
			Return False
	End Choose	
Else
	ps_Registro = lvs_Tabela + ps_Atualizacao + &
					  lvs_Cd_Cliente + &
					  This.of_String(lvs_Cd_Dependente_Cliente, 13)
End If

Return lvb_Retorno
end function

public function boolean of_registro_item_nf_transferencia (string ps_chave, string ps_atualizacao, ref string ps_registro);Boolean lvb_Retorno = True

String lvs_Tabela = "028", &
       lvs_Especie, &
		 lvs_Serie, &
		 lvs_Situacao_Tributaria

Long lvl_Filial_Origem, &
     lvl_Filial_Destino, &
	  lvl_NF, &
	  lvl_Produto, &
     lvl_Natureza, &
	  lvl_Qtde
	  
Decimal lvdc_Custo, &
		  lvdc_ICMS , &
		  lvdc_Custo_Gerencial

lvl_Filial_Origem = Long(This.of_Coluna_Chave_Log(ps_Chave, 1))
lvl_NF            = Long(This.of_Coluna_Chave_Log(ps_Chave, 2))
lvs_Especie       = This.of_Coluna_Chave_Log(ps_Chave, 3)
lvs_Serie         = This.of_Coluna_Chave_Log(ps_Chave, 4)
lvl_Natureza      = Long(This.of_Coluna_Chave_Log(ps_Chave, 5))
lvl_Produto       = Long(This.of_Coluna_Chave_Log(ps_Chave, 6))

If ps_Atualizacao <> "E" Then	
	Select cd_filial_destino,
          cd_situacao_tributaria,
			 qt_transferida,
			 vl_custo_unitario,
			 pc_icms,
			 vl_custo_gerencial
   Into :lvl_Filial_Destino,
		  :lvs_Situacao_Tributaria,
		  :lvl_Qtde,
		  :lvdc_Custo,
		  :lvdc_ICMS,
		  :lvdc_Custo_Gerencial
   From item_nf_transferencia  
   Where cd_filial_origem     = :lvl_Filial_Origem
     and nr_nf                = :lvl_NF  
     and de_especie           = :lvs_Especie
     and de_serie             = :lvs_Serie
	  and cd_natureza_operacao = :lvl_Natureza
	  and cd_produto           = :lvl_Produto
 	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			
			If IsNull(lvdc_Custo_Gerencial) Then lvdc_Custo_Gerencial = 0
			
			If Trim( lvs_Situacao_Tributaria ) = '0' Then lvs_Situacao_Tributaria = '00'
			
			ps_Registro = lvs_Tabela + ps_Atualizacao + &
							  String(lvl_Filial_Origem, "0000") + &
							  String(lvl_NF, "00000000") + &
							  This.of_String(lvs_Especie, 3) + &
							  This.of_String(lvs_Serie, 3) + &
							  String(lvl_Natureza, "000000000000000") + &
							  String(lvl_Produto, "000000") + &
							  String(lvl_Filial_Destino, "0000") + &
							  lvs_Situacao_Tributaria + &
							  String(lvl_Qtde, "00000") + &
							  This.of_Decimal(lvdc_Custo, 7) + &
							  This.of_Decimal(lvdc_ICMS, 5)  + &
							  This.of_Decimal(lvdc_Custo_Gerencial, 7)
							  
							  
		Case 100
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Item da Nota Fiscal de Transfer$$HEX1$$ea00$$ENDHEX$$ncia")
			Return False
	End Choose	
Else
	ps_Registro = lvs_Tabela + ps_Atualizacao + &
					  String(lvl_Filial_Origem, "0000") + &
					  String(lvl_NF, "00000000") + &
					  This.of_String(lvs_Especie, 3) + &
					  This.of_String(lvs_Serie, 3) + &
					  String(lvl_Natureza, "000000000000000") + &
					  String(lvl_Produto, "000000")
End If		

Return lvb_Retorno
end function

public function boolean of_registro_item_nf_compra_lote (string ps_chave, string ps_atualizacao, ref string ps_registro);Boolean lvb_Retorno = True

String lvs_Tabela = "715", &
       lvs_Especie		 , &
		 lvs_Serie			 , &
		 lvs_Fornecedor	 , &
		 lvs_Nr_Lote
		 
Long lvl_Filial , &
	  lvl_NF		 ,	&
	  lvl_Produto, &
	  lvl_Qt_Lote, &
	  lvl_Natureza
	  
lvl_Filial     = Long(This.of_Coluna_Chave_Log(ps_Chave, 1))
lvs_Fornecedor = This.of_Coluna_Chave_Log(ps_Chave, 2)
lvl_NF         = Long(This.of_Coluna_Chave_Log(ps_Chave, 3))
lvs_Especie    = This.of_Coluna_Chave_Log(ps_Chave, 4)
lvs_Serie      = This.of_Coluna_Chave_Log(ps_Chave, 5)
lvl_Natureza   = Long(This.of_Coluna_Chave_Log(ps_Chave, 6))
lvl_Produto    = Long(This.of_Coluna_Chave_Log(ps_Chave, 7))
lvs_Nr_Lote    = This.of_Coluna_Chave_Log(ps_Chave, 8)

If ps_Atualizacao <> "E" Then	
	Select qt_lote
     Into :lvl_Qt_Lote
    From item_nf_compra_lote
   Where cd_filial            = :lvl_Filial
	  and cd_fornecedor        = :lvs_Fornecedor
     and nr_nf                = :lvl_NF  
     and de_especie           = :lvs_Especie
     and de_serie             = :lvs_Serie
	  and cd_natureza_operacao = :lvl_Natureza
	  and cd_produto           = :lvl_Produto
	  and nr_lote					= :lvs_Nr_Lote
 	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			ps_Registro = lvs_Tabela + ps_Atualizacao 				+ &						  
							  String(lvl_Filial, "0000") 					+ &
							  This.of_String(lvs_Fornecedor, 9) 		+ &
							  String(lvl_NF, "00000000") 					+ &
							  This.of_String(lvs_Especie, 3) 			+ &
							  This.of_String(lvs_Serie, 3)		 		+ &
							  String(lvl_Natureza, "000000000000000") + &
							  String(lvl_Produto, "000000") 				+ &
							  This.of_String(lvs_Nr_Lote, 10) 			+ &
							  String(lvl_Qt_Lote, "000000")
								
		Case 100
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Item da Nota Fiscal de Compra Lote")
			Return False
	End Choose	
Else
	ps_Registro = lvs_Tabela + ps_Atualizacao 				+ &
					  String(lvl_Filial, "0000") 					+ &
					  This.of_String(lvs_Fornecedor, 9)		 	+ &
					  String(lvl_NF, "00000000") 					+ &
					  This.of_String(lvs_Especie, 3) 			+ &
					  This.of_String(lvs_Serie, 3) 				+ &
					  String(lvl_Natureza, "000000000000000") + &
					  String(lvl_Produto, "000000") 				+ &
					  lvs_Nr_Lote
						
End If		

Return lvb_Retorno
end function

public function boolean of_registro_item_nf_transferencia_lote (string ps_chave, string ps_atualizacao, ref string ps_registro);Boolean lvb_Retorno = True

String lvs_Tabela = "716", &
       lvs_Especie, &
		 lvs_Serie	, &
		 lvs_Nr_Lote

Long lvl_NF		  , &
	  lvl_Produto , &
     lvl_Natureza, &
	  lvl_Qt_Lote , &
	  lvl_Filial_Origem
	  
lvl_Filial_Origem = Long(This.of_Coluna_Chave_Log(ps_Chave, 1))
lvl_NF            = Long(This.of_Coluna_Chave_Log(ps_Chave, 2))
lvs_Especie       = This.of_Coluna_Chave_Log(ps_Chave, 3)
lvs_Serie         = This.of_Coluna_Chave_Log(ps_Chave, 4)
lvl_Natureza      = Long(This.of_Coluna_Chave_Log(ps_Chave, 5))
lvl_Produto       = Long(This.of_Coluna_Chave_Log(ps_Chave, 6))
lvs_Nr_Lote       = This.of_Coluna_Chave_Log(ps_Chave, 7)

If IsNull(lvs_Nr_Lote) Then lvs_Nr_Lote = ""

If ps_Atualizacao <> "E" Then	
	Select qt_lote
   Into :lvl_Qt_Lote
   From item_nf_transferencia_lote
   Where cd_filial_origem     = :lvl_Filial_Origem
     and nr_nf                = :lvl_NF  
     and de_especie           = :lvs_Especie
     and de_serie             = :lvs_Serie
	  and cd_natureza_operacao = :lvl_Natureza
	  and cd_produto           = :lvl_Produto
	  and nr_lote					= :lvs_Nr_Lote
 	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			
			ps_Registro = lvs_Tabela + ps_Atualizacao + &
							  String(lvl_Filial_Origem, "0000") + &
							  String(lvl_NF, "00000000") + &
							  This.of_String(lvs_Especie, 3) + &
							  This.of_String(lvs_Serie, 3) + &
							  String(lvl_Natureza, "000000000000000") + &
							  String(lvl_Produto, "000000") + &
							  This.of_String(lvs_Nr_Lote, 10) + &
							  String(lvl_Qt_Lote, "000000")
							  
		Case 100
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Item da Nota Fiscal de Transfer$$HEX1$$ea00$$ENDHEX$$ncia Lote")
			Return False
	End Choose	
Else
	ps_Registro = lvs_Tabela + ps_Atualizacao + &
					  String(lvl_Filial_Origem, "0000") + &
					  String(lvl_NF, "00000000") + &
					  This.of_String(lvs_Especie, 3) + &
					  This.of_String(lvs_Serie, 3) + &
					  String(lvl_Natureza, "000000000000000") + &
					  String(lvl_Produto, "000000") + &
					  This.of_String(lvs_Nr_Lote, 10)
End If		

Return lvb_Retorno
end function

public function boolean of_atualiza_item_nf_transferencia_lote (string ps_registro, integer pi_log);String lvs_Chave_LOG, &
       lvs_Operacao, &
       lvs_Especie, &
		 lvs_Serie, &
		 lvs_Nr_Lote

Long lvl_Filial_Origem, &
	  lvl_NF, &
	  lvl_Produto, &
     lvl_Natureza, &
	  lvl_Qt_Lote
	  
Decimal lvdc_Custo, &
		  lvdc_ICMS, &
		  lvdc_Custo_Gerencial
	 
Boolean lvb_Sucesso = True

lvs_Operacao = MidA(ps_Registro, 4, 1)

lvl_Filial_Origem = Long(MidA(ps_Registro, 5, 4))
lvl_NF            = Long(MidA(ps_Registro, 9, 8))
lvs_Especie       = Trim(MidA(ps_Registro, 17, 3))
lvs_Serie         = Trim(MidA(ps_Registro, 20, 3))
lvl_Natureza      = Long(MidA(ps_Registro, 23, 15))
lvl_Produto       = Long(MidA(ps_Registro, 38, 6))
lvs_Nr_Lote			= Trim(MidA(ps_Registro, 44, 10))
lvl_Qt_Lote       = Long(MidA(ps_Registro, 54, 6))

lvs_Chave_Log = "ITEM_NF_TRANSFERENCIA_LOTE (" + String(lvl_Filial_Origem, "0000") + "-" + &
														 		 String(lvl_NF, "00000000") + "-" + &
														  		 lvs_Especie + "-" + &
														 		 lvs_Serie + "-" + &
														 		 String(lvl_Natureza) + "-" + &
														 		 String(lvl_Produto, "000000") + "-" + &
														 		 lvs_Nr_Lote + ") "
If lvs_Operacao = "E" Then
	
	Delete From item_nf_transferencia_lote
	 Where cd_filial_origem     = :lvl_Filial_Origem
		and nr_nf                = :lvl_NF
		and de_especie           = :lvs_Especie
		and de_serie             = :lvs_Serie
		and cd_natureza_operacao = :lvl_Natureza
		and cd_produto           = :lvl_Produto
		and nr_lote					 = :lvs_Nr_Lote
	 Using SqlCa;
	 
	 If SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback()
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o")
		lvb_Sucesso = False
	 End If
	
	Else																  
																	  
	If LenA(ps_Registro) <> 60 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Registro Inv$$HEX1$$e100$$ENDHEX$$lido")	
		Return False
	End If
	
	Select nr_nf
	  Into :lvl_NF
	 From item_nf_transferencia_lote
	 Where cd_filial_origem     = :lvl_Filial_Origem
		and nr_nf                = :lvl_NF
		and de_especie           = :lvs_Especie
		and de_serie             = :lvs_Serie
		and cd_natureza_operacao = :lvl_Natureza
		and cd_produto           = :lvl_Produto
		and nr_lote					 = :lvs_Nr_Lote
	 Using SqlCa;
				
	Choose Case SqlCa.SqlCode
		Case 0
			
			Update item_nf_transferencia_lote
				Set qt_lote = :lvl_Qt_Lote
			 Where cd_filial_origem     = :lvl_Filial_Origem
				and nr_nf                = :lvl_NF
				and de_especie           = :lvs_Especie
				and de_serie             = :lvs_Serie
				and cd_natureza_operacao = :lvl_Natureza
				and cd_produto           = :lvl_Produto
				and nr_lote					 = :lvs_Nr_Lote
			 Using SqlCa;
			 
			 If SqlCa.SqlCode = -1 Then
				SqlCa.of_Rollback()
				SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Atualiza$$HEX2$$e700e300$$ENDHEX$$o")
				lvb_Sucesso = False
			End If	
			
		Case 100		
			Insert Into item_nf_transferencia_lote (cd_filial_origem,   
														  nr_nf,   
														  de_especie,   
														  de_serie,   
														  cd_natureza_operacao,   
														  cd_produto,   
														  nr_lote,
														  qt_lote)  
			Values (:lvl_Filial_Origem,   
					  :lvl_NF,   
					  :lvs_Especie,   
					  :lvs_Serie,   
					  :lvl_Natureza,   
					  :lvl_Produto,   
					  :lvs_Nr_Lote,
					  :lvl_Qt_Lote)
			Using SqlCa;
	
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_Rollback()
				SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Inclus$$HEX1$$e300$$ENDHEX$$o")
				lvb_Sucesso = False
			End If				
		Case -1
			SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o")
			lvb_Sucesso = False
	End Choose		
		
	If lvb_Sucesso Then
		If SqlCa.of_Commit() = -1 Then
			SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Commit")
		End If
	End If
	
End If

Return lvb_Sucesso
end function

public subroutine of_run (string ps_exe);OleObject wsh
integer li_rc
CONSTANT integer MAXIMIZED = 3
CONSTANT integer MINIMIZED = 2
CONSTANT integer NORMAL 	= 1
CONSTANT boolean WAIT 		= TRUE
CONSTANT boolean NOWAIT 	= FALSE

wsh 	= CREATE OleObject
li_rc = wsh.ConnectToNewObject( "WScript.Shell" ) 
li_rc = wsh.Run(ps_EXE, NORMAL, WAIT)

Destroy(wsh)
end subroutine

public subroutine of_nome_arquivo (string ps_tabela, ref string ps_arquivo);String lvs_Nr, &
       lvs_Arquivo

Select nr_tabela
  Into :lvs_Nr
  From tl_tabela_exportacao
 Where nm_tabela = :ps_tabela
 Using SqlCa;
 
Choose Case SqlCa.SqlCode
	Case -1
		
	Case 0
		ps_Arquivo = lvs_Nr + "_" + ps_Arquivo
		
	Case 100
		
End Choose
end subroutine

public function boolean of_exclui_item_nf_compra (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, long al_natope, long al_produto, integer ai_log, string as_chave_log);Boolean	lvb_Sucesso = False,&
			lvb_Possui_Movimento

DateTime lvdh_Data_Caixa

Long lvl_Qtde

Select dh_movimentacao_caixa,
       	qt_faturada
Into	:lvdh_Data_Caixa,
     	:lvl_Qtde
From nf_compra n, item_nf_compra i
Where i.cd_filial     					= :al_Filial
  	and i.cd_fornecedor 				= :as_Fornecedor
  	and i.nr_nf         					= :al_Nota
  	and i.de_especie    				= :as_Especie
  	and i.de_serie      					= :as_Serie
	and i.cd_natureza_operacao	=	:al_natope
	and i.cd_produto					=	:al_produto
	and n.cd_filial						= i.cd_filial
	and n.cd_fornecedor				= i.cd_fornecedor
	and n.nr_nf							= i.nr_nf
	and n.de_especie					= i.de_especie
	and n.de_serie						= i.de_serie
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		uo_ge059_exclusao_nf_compra lvo
		
		lvo = Create uo_ge059_exclusao_nf_compra
		
		If lvo.of_Exclui_Item_NF_Compra(	al_Filial, &
													as_Fornecedor, &
													al_Nota, &
													as_Especie, &
													as_Serie, &
													al_NatOpe, &
													al_Produto, &
													ai_Log, &
													as_Chave_Log) Then 
			If lvo.of_exclui_movimento_estoque_item(as_Fornecedor, &
															al_Nota, &
															as_Especie, &
															as_Serie, &
															al_Produto, &
															lvdh_Data_Caixa, &
															lvl_Qtde, &
															ai_Log, &
															as_Chave_Log,&
															Ref lvb_Possui_Movimento) Then 
				
				If lvo.of_Atualiza_Saldo_Produto(al_Produto, &
															 lvdh_Data_Caixa, &
															 lvl_Qtde, &
															 ai_Log, &
															 as_Chave_Log,&
															 lvb_Possui_Movimento) Then
					lvb_Sucesso = True				
				End If
			End If
		End If
		
		Destroy lvo
		
		If lvb_Sucesso Then
			SqlCa.of_Commit()
		Else
			SqlCa.of_RollBack()
		End If
	Case 100
		SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Item da Nota Fiscal n$$HEX1$$e300$$ENDHEX$$o Localizada para Exclus$$HEX1$$e300$$ENDHEX$$o")	
	Case -1
		SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Item Localiza$$HEX2$$e700e300$$ENDHEX$$o da Nota Fiscal para Exclus$$HEX1$$e300$$ENDHEX$$o")	
End Choose

Return lvb_Sucesso	 

end function

public function boolean of_registro_nf_compra (string ps_chave, string ps_atualizacao, ref string ps_registro);Boolean lvb_Retorno = True

String lvs_Tabela = "031", &
       lvs_Especie, &
		 lvs_Serie, &
		 lvs_Fornecedor, &
		 lvs_Bonificacao

Long lvl_Filial, &
     lvl_NF, &
	  lvl_Nr_Pedido_Filial, &
	  lvl_Nr_Pedido_Distribuidora
	  
Decimal lvdc_BC_ICMS, &
		  lvdc_ICMS, &
		  lvdc_BC_ICMS_ST, &
		  lvdc_ICMS_ST, &
		  lvdc_ICMS_Repassado, &
		  lvdc_IPI, &
		  lvdc_Frete, &
		  lvdc_Seguro, &
		  lvdc_Despesas, &
		  lvdc_Desconto, &
		  lvdc_Indenizacao, &
		  lvdc_Total_Produtos, &
		  lvdc_Total_NF

DateTime lvdh_Movimentacao_Caixa, &
			lvdh_Emissao

lvl_Filial     = Long(This.of_Coluna_Chave_Log(ps_Chave, 1))
lvs_Fornecedor = This.of_Coluna_Chave_Log(ps_Chave, 2)
lvl_NF         = Long(This.of_Coluna_Chave_Log(ps_Chave, 3))
lvs_Especie    = This.of_Coluna_Chave_Log(ps_Chave, 4)
lvs_Serie      = This.of_Coluna_Chave_Log(ps_Chave, 5)

If ps_Atualizacao <> "E" Then	
	Select dh_emissao,   
          dh_movimentacao_caixa,   
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
			 nr_pedido_filial,
			 nr_pedido_distribuidora,
			 id_bonificacao
   Into :lvdh_Emissao,   
        :lvdh_Movimentacao_Caixa,   
        :lvdc_BC_ICMS,   
        :lvdc_ICMS,   
        :lvdc_BC_ICMS_ST,   
        :lvdc_ICMS_ST,   
		  :lvdc_ICMS_Repassado,
        :lvdc_Total_Produtos,   
		  :lvdc_IPI,
		  :lvdc_Frete,
		  :lvdc_Seguro,
		  :lvdc_Despesas,
		  :lvdc_Desconto,
		  :lvdc_Indenizacao,
        :lvdc_Total_NF,
		  :lvl_Nr_Pedido_Filial,
		  :lvl_Nr_Pedido_Distribuidora,
		  :lvs_Bonificacao
   From nf_compra  
   Where cd_filial     = :lvl_Filial
	  and cd_fornecedor = :lvs_Fornecedor
     and nr_nf         = :lvl_NF  
     and de_especie    = :lvs_Especie
     and de_serie      = :lvs_Serie
 	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If IsNull(lvl_Nr_Pedido_Filial)        Then lvl_Nr_Pedido_Filial = 0
			If IsNull(lvl_Nr_Pedido_Distribuidora) Then lvl_Nr_Pedido_Distribuidora = 0
			
			ps_Registro = lvs_Tabela + ps_Atualizacao + &
							  String(lvl_Filial, "0000") + &
							  This.of_String(lvs_Fornecedor, 9) + &
							  String(lvl_NF, "00000000") + &
							  This.of_String(lvs_Especie, 3) + &
							  This.of_String(lvs_Serie, 3) + &
							  This.of_Date(lvdh_Emissao) + &
							  This.of_Date(lvdh_Movimentacao_Caixa) + &
							  This.of_Decimal(lvdc_BC_ICMS, 9) + &
							  This.of_Decimal(lvdc_ICMS, 9) + &
							  This.of_Decimal(lvdc_BC_ICMS_ST, 9) + &
							  This.of_Decimal(lvdc_ICMS_ST, 9) + &
							  This.of_Decimal(lvdc_ICMS_Repassado, 9) + &
							  This.of_Decimal(lvdc_Total_Produtos, 9) + &
							  This.of_Decimal(lvdc_IPI, 9) + &
							  This.of_Decimal(lvdc_Frete, 9) + &
							  This.of_Decimal(lvdc_Seguro, 9) + &
							  This.of_Decimal(lvdc_Despesas, 9) + &
							  This.of_Decimal(lvdc_Desconto, 9) + &
							  This.of_Decimal(lvdc_Indenizacao, 9) + &
							  This.of_Decimal(lvdc_Total_NF, 9) + &
							  String(lvl_Nr_Pedido_Filial, "00000000") + &
							  String(lvl_Nr_Pedido_Distribuidora, "00000000") + &
							  This.of_String(lvs_Bonificacao, 1)
		Case 100
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Nota Fiscal de Compra")
			Return False
	End Choose	
Else
	ps_Registro = lvs_Tabela + ps_Atualizacao + &
					  String(lvl_Filial, "0000") + &
					  This.of_String(lvs_Fornecedor, 9) + &
					  String(lvl_NF, "00000000") + &
					  This.of_String(lvs_Especie, 3) + &
					  This.of_String(lvs_Serie, 3)					  
End If		

Return lvb_Retorno
end function

public function boolean of_registro_item_nf_compra (string ps_chave, string ps_atualizacao, ref string ps_registro);Boolean lvb_Retorno = True

String lvs_Tabela = "714",      &
       lvs_Especie, 				  &
		 lvs_Serie, 				  &
		 lvs_Situacao_Tributaria, &
		 lvs_Fornecedor, 			  &
		 lvs_Id_Pis_Cofins
		 
Long lvl_Filial, 			&
	  lvl_NF, 				&
	  lvl_Produto, 		&
     lvl_Natureza, 		&
	  lvl_Qtde_Faturada, &
	  lvl_Qtde_Recebida
	  
Decimal lvdc_Preco				 , &
		  lvdc_ICMS					 , &
		  lvdc_Desconto			 , &
		  lvdc_IPI					 , &
		  lvdc_ICMS_Repassado	 , &
		  lvdc_Reducao_Base_ICMS , &
		  lvdc_Preco_Base_Icms_St, &
		  lvdc_Vl_Icms_St, &
		  lvdc_Pc_Icms_St, &
		  lvdc_Vl_Bc_Icms, &
		  lvdc_Vl_Icms, &
		  lvdc_Vl_Bc_Ipi, &
		  lvdc_Vl_Ipi, &
		  lvdc_Vl_Outras_Despesas, &
		  lvdc_Vl_Bc_Icms_St_Total, &
		  lvdc_Vl_Icms_St_Total

lvl_Filial     = Long(This.of_Coluna_Chave_Log(ps_Chave, 1))
lvs_Fornecedor = This.of_Coluna_Chave_Log(ps_Chave, 2)
lvl_NF         = Long(This.of_Coluna_Chave_Log(ps_Chave, 3))
lvs_Especie    = This.of_Coluna_Chave_Log(ps_Chave, 4)
lvs_Serie      = This.of_Coluna_Chave_Log(ps_Chave, 5)
lvl_Natureza   = Long(This.of_Coluna_Chave_Log(ps_Chave, 6))
lvl_Produto    = Long(This.of_Coluna_Chave_Log(ps_Chave, 7))

If ps_Atualizacao <> "E" Then	
	Select cd_situacao_tributaria,
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
			 pc_icms_st,
			 vl_bc_icms,
			 vl_icms,
			 vl_bc_ipi,
			 vl_ipi,
			 vl_outras_despesas,
			 vl_bc_icms_st_total,
			 vl_icms_st_total
   Into :lvs_Situacao_Tributaria,
		  :lvl_Qtde_Faturada,
		  :lvl_Qtde_Recebida,
		  :lvdc_Preco,
		  :lvdc_Desconto,
		  :lvdc_ICMS,
		  :lvdc_IPI,
		  :lvdc_ICMS_Repassado,
		  :lvs_Id_Pis_Cofins,
		  :lvdc_Reducao_Base_ICMS,
		  :lvdc_Preco_Base_Icms_St,
		  :lvdc_Vl_Icms_St,
		  :lvdc_Pc_Icms_St,
		  :lvdc_Vl_Bc_Icms,
		  :lvdc_Vl_Icms,
		  :lvdc_Vl_Bc_Ipi,
		  :lvdc_Vl_Ipi,
		  :lvdc_Vl_Outras_Despesas,
		  :lvdc_Vl_Bc_Icms_St_Total,
		  :lvdc_Vl_Icms_St_Total
   From item_nf_compra
   Where cd_filial            = :lvl_Filial
	  and cd_fornecedor        = :lvs_Fornecedor
     and nr_nf                = :lvl_NF  
     and de_especie           = :lvs_Especie
     and de_serie             = :lvs_Serie
	  and cd_natureza_operacao = :lvl_Natureza
	  and cd_produto           = :lvl_Produto
 	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			ps_Registro = lvs_Tabela + ps_Atualizacao + &						  
							  String(lvl_Filial, "0000") + &
							  This.of_String(lvs_Fornecedor, 9) + &
							  String(lvl_NF, "00000000") + &
							  This.of_String(lvs_Especie, 3) + &
							  This.of_String(lvs_Serie, 3) + &
							  String(lvl_Natureza, "000000000000000") + &
							  String(lvl_Produto, "000000") + &
							  lvs_Situacao_Tributaria + &
							  String(lvl_Qtde_Faturada, "00000") + &
							  String(lvl_Qtde_Recebida, "00000") + &
							  This.of_Decimal(lvdc_Preco, 7) + &
							  This.of_Decimal(lvdc_Desconto, 5) + &
							  This.of_Decimal(lvdc_ICMS, 5) + &
							  This.of_Decimal(lvdc_IPI, 5) + &
							  This.of_Decimal(lvdc_ICMS_Repassado, 7) + &
							  This.of_String(lvs_Id_Pis_Cofins, 1) + &
							  This.of_Decimal(lvdc_Reducao_Base_ICMS, 5) + &
							  This.of_Decimal(lvdc_Preco_Base_Icms_St, 7) + &
							  This.of_Decimal(lvdc_Vl_Icms_St, 7) + & 	
								This.of_Decimal(lvdc_Pc_Icms_St, 5) + &
								This.of_Decimal(lvdc_Vl_Bc_Icms, 11, 4) + &
								This.of_Decimal(lvdc_Vl_Icms, 11, 4) + &
								This.of_Decimal(lvdc_Vl_Bc_Ipi, 11, 4) + &
								This.of_Decimal(lvdc_Vl_Ipi, 11, 4) + &
								This.of_Decimal(lvdc_Vl_Outras_Despesas, 7) + &
								This.of_Decimal(lvdc_Vl_Bc_Icms_St_Total, 11) + &
								This.of_Decimal(lvdc_Vl_Icms_St_Total, 11)
								
		Case 100
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Item da Nota Fiscal de Compra")
			Return False
	End Choose	
Else
	ps_Registro = lvs_Tabela + ps_Atualizacao + &						  
					  String(lvl_Filial, "0000") + &
					  This.of_String(lvs_Fornecedor, 9) + &
					  String(lvl_NF, "00000000") + &
					  This.of_String(lvs_Especie, 3) + &
					  This.of_String(lvs_Serie, 3) + &
					  String(lvl_Natureza, "000000000000000") + &
					  String(lvl_Produto, "000000")						
End If		

Return lvb_Retorno
end function

on uo_ge059_troca_dados_comum.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge059_troca_dados_comum.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

