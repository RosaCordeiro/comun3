HA$PBExportHeader$uo_parametro_filial.sru
forward
global type uo_parametro_filial from nonvisualobject
end type
end forward

global type uo_parametro_filial from nonvisualobject
end type
global uo_parametro_filial uo_parametro_filial

forward prototypes
public function boolean of_localiza_parametro (string as_codigo, ref string as_valor)
public function boolean of_atualiza_parametro (string as_codigo, string as_valor)
public function boolean of_localiza_parametro (string as_parametro, ref datetime adh_data)
public function boolean of_atualiza_parametro (string as_parametro, long al_valor)
public function boolean of_atualiza_sequencial (string as_parametro)
public function boolean of_localiza_parametro (string as_parametro, ref decimal adc_valor)
public function boolean of_localiza_parametro (string as_parametro, ref long al_valor)
public function boolean of_localiza_parametro (string as_parametro, ref date adt_data)
public function boolean of_atualiza_parametro (string as_parametro, date adt_valor)
public function boolean of_atualiza_parametro (string as_parametro, datetime adh_valor)
public function boolean of_atualiza_parametro (string as_parametro, decimal adc_valor)
public function boolean of_atualiza_parametro (string as_parametro, integer ai_valor)
public function boolean of_localiza_parametro (string as_parametro, ref integer ai_valor)
public function boolean of_localiza_parametro (string as_parametro, ref boolean ab_valor)
public function boolean of_proximo_sequencial (string as_parametro, ref long al_proximo)
public function boolean of_localiza_parametro (string as_codigo, ref string as_valor, boolean ab_mostra_mensagem)
end prototypes

public function boolean of_localiza_parametro (string as_codigo, ref string as_valor);Return This.of_Localiza_Parametro( as_Codigo, ref as_Valor, True )
end function

public function boolean of_atualiza_parametro (string as_codigo, string as_valor);Update parametro_loja
Set vl_parametro = :as_Valor
Where cd_parametro = :as_Codigo
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Par$$HEX1$$e200$$ENDHEX$$metro '" + as_Codigo + "'")
	Return False
End If

If SqlCa.SqlnRows <> 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Codigo + "'.~r" + &
	                      "N$$HEX1$$fa00$$ENDHEX$$mero de linhas atualizadas '" + String(SqlCa.SqlnRows) + "'.", StopSign!)
	Return False
End If

Return True
end function

public function boolean of_localiza_parametro (string as_parametro, ref datetime adh_data);Boolean lvb_Sucesso = False

String lvs_Valor, &
       lvs_Data, &
		 lvs_Hora

// Formato do par$$HEX1$$e200$$ENDHEX$$metro: dd/mm/yyyy hh:mm:ss:fff
	
If This.of_Localiza_Parametro(as_Parametro, lvs_Valor) Then 
	lvs_Data = LeftA(lvs_Valor, 10)
	lvs_Hora = MidA(lvs_Valor, 12)
	
	If IsDate(lvs_Data) and IsTime(lvs_Hora) Then
		adh_Data = DateTime(Date(lvs_Data), Time(lvs_Hora))
		
		lvb_Sucesso = True
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor '" + lvs_Valor + "' do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "' inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_atualiza_parametro (string as_parametro, long al_valor);String lvs_Valor

lvs_Valor = String(al_Valor)

Return This.of_Atualiza_Parametro(as_Parametro, lvs_Valor)
end function

public function boolean of_atualiza_sequencial (string as_parametro);Update parametro_loja
Set vl_parametro = Cast( Cast(vl_parametro As integer ) + 1 As varchar )
Where cd_parametro = :as_Parametro
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Sequencial do Par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "'")
	Return False
End If

If SqlCa.SqlnRows <> 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do sequencial do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "'.~r" + &
	                      "N$$HEX1$$fa00$$ENDHEX$$mero de linhas atualizadas '" + String(SqlCa.SqlnRows) + "'.", StopSign!)
	Return False
End If

Return True
end function

public function boolean of_localiza_parametro (string as_parametro, ref decimal adc_valor);Boolean lvb_Sucesso = False

String lvs_Valor

Integer lvi_Pos

// Formato do Par$$HEX1$$e200$$ENDHEX$$metro: 0.00

If This.of_Localiza_Parametro(as_Parametro, lvs_Valor) Then 
	lvi_Pos = PosA(lvs_Valor, ".")
	
	If lvi_Pos > 0 Then
		lvs_Valor = LeftA(lvs_Valor, lvi_Pos - 1) + "," + MidA(lvs_Valor, lvi_Pos + 1)
	End If
	
	If IsNumber(lvs_Valor) Then
		adc_Valor = Dec(lvs_Valor)	
		
		lvb_Sucesso = True
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor '" + lvs_Valor + "' do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "' inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_localiza_parametro (string as_parametro, ref long al_valor);Boolean lvb_Sucesso = False

String lvs_Valor

If This.of_Localiza_Parametro(as_Parametro, lvs_Valor) Then 
	If IsNumber(lvs_Valor) Then
		al_Valor = Long(lvs_Valor)	
		
		lvb_Sucesso = True
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor '" + lvs_Valor + "' do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "' inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_localiza_parametro (string as_parametro, ref date adt_data);Boolean lvb_Sucesso = False

String lvs_Valor

// Formato do par$$HEX1$$e200$$ENDHEX$$metro: dd/mm/yyyy

If This.of_Localiza_Parametro(as_Parametro, lvs_Valor) Then 	
	If IsDate(lvs_Valor) Then
		adt_Data = Date(lvs_Valor)
		
		lvb_Sucesso = True
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor '" + lvs_Valor + "' do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "' inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_atualiza_parametro (string as_parametro, date adt_valor);String lvs_Valor

lvs_Valor = String(adt_Valor, "dd/mm/yyyy")

Return This.of_Atualiza_Parametro(as_Parametro, lvs_Valor)
end function

public function boolean of_atualiza_parametro (string as_parametro, datetime adh_valor);String lvs_Valor

lvs_Valor = String(adh_Valor, "dd/mm/yyyy hh:mm:ss:fff")

Return This.of_Atualiza_Parametro(as_Parametro, lvs_Valor)
end function

public function boolean of_atualiza_parametro (string as_parametro, decimal adc_valor);String lvs_Valor

lvs_Valor = String(adc_Valor, "0.00")

Return This.of_Atualiza_Parametro(as_Parametro, lvs_Valor)
end function

public function boolean of_atualiza_parametro (string as_parametro, integer ai_valor);String lvs_Valor

lvs_Valor = String(ai_Valor)

Return This.of_Atualiza_Parametro(as_Parametro, lvs_Valor)
end function

public function boolean of_localiza_parametro (string as_parametro, ref integer ai_valor);Boolean lvb_Sucesso = False

String lvs_Valor

If This.of_Localiza_Parametro(as_Parametro, lvs_Valor) Then 
	If IsNumber(lvs_Valor) Then
		ai_Valor = Integer(lvs_Valor)	
		
		lvb_Sucesso = True
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor '" + lvs_Valor + "' do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "' inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_localiza_parametro (string as_parametro, ref boolean ab_valor);Boolean lvb_Sucesso = False

String lvs_Valor

If This.of_Localiza_Parametro(as_Parametro, lvs_Valor) Then 
	lvb_Sucesso = True
	
	If lvs_Valor = "S" Then
		ab_Valor = True
	Else
		ab_Valor = False
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_proximo_sequencial (string as_parametro, ref long al_proximo);String lvs_nr_nfce

Try
	Update parametro_loja
		 Set vl_parametro		= CAST( ( CAST( COALESCE( vl_parametro, '0' ) AS INTEGER ) + 1 ) AS VARCHAR )
	 Where cd_parametro	= :as_Parametro
	   Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_RollBack( )
		SqlCa.of_MsgDbError( "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do sequencial do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "'.~r uo_parametro_filial.of_proximo_sequencial( string, long )" )
		Return False
	Else
		If SqlCa.SqlnRows = 0 Then Return This.of_Proximo_Sequencial( as_Parametro, ref al_Proximo )
	End If			
	
	If Not This.of_Localiza_Parametro( as_Parametro, ref al_Proximo ) Then Return False
	
	Return True
	
Finally
	
End Try
end function

public function boolean of_localiza_parametro (string as_codigo, ref string as_valor, boolean ab_mostra_mensagem);Boolean lvb_Sucesso = False

Select vl_parametro Into :as_Valor
From parametro_loja
Where cd_parametro = :as_Codigo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100

		//Chamado 163798
		Choose Case as_Codigo
			Case 	'QT_LIMITE_ALTERACAO_EB_CURVA_A', &
					'QT_LIMITE_ALTERACAO_EB_CURVA_A_CAIXA', &
					'QT_LIMITE_ALTERACAO_EB_CURVA_B', &
					'QT_LIMITE_ALTERACAO_EB_CURVA_B_CAIXA', &
					'QT_LIMITE_ALTERACAO_EB_CURVA_C', &
					'QT_LIMITE_ALTERACAO_EB_CURVA_C_CAIXA', &
					'QT_LIMITE_ALTERACAO_EB_CURVA_D', &
					'QT_LIMITE_ALTERACAO_EB_CURVA_D_CAIXA', &
					'QT_LIMITE_ALTERACAO_EB_CURVA_E', &
					'QT_LIMITE_ALTERACAO_EB_CURVA_E_CAIXA'
				MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "A altera$$HEX2$$e700e300$$ENDHEX$$o de estoque base foi bloqueada pela Matriz.~r~ruo_parametro_filial.of_localiza_parametro( string, string, boolean )", Exclamation! )
				Return False
		End Choose
		//
		
		If ab_Mostra_Mensagem Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro '" + as_Codigo + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
		End If
	Case -1
		If ab_Mostra_Mensagem Then
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Par$$HEX1$$e200$$ENDHEX$$metro '" + as_Codigo + "'")
		End If
End Choose

Return lvb_Sucesso
end function

on uo_parametro_filial.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_parametro_filial.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

