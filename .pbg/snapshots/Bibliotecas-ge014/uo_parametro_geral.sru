HA$PBExportHeader$uo_parametro_geral.sru
forward
global type uo_parametro_geral from nonvisualobject
end type
end forward

global type uo_parametro_geral from nonvisualobject
end type
global uo_parametro_geral uo_parametro_geral

type variables
String is_Mensagem_Log

Boolean ib_Mostra_Mensagem = True
end variables

forward prototypes
public function boolean of_localiza_parametro (string as_codigo, ref string as_valor)
public function boolean of_proxima_nf (ref long al_proxima)
public function boolean of_serie_nf (ref string as_serie)
public function boolean of_especie_nf (ref string as_especie)
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
public function boolean of_proximo_sequencial (string as_parametro, ref long al_proximo)
public function boolean of_localiza_parametro (string as_parametro, ref boolean ab_valor)
public function boolean of_localiza_parametro (string as_parametro, ref integer ai_valor)
public function boolean of_especie_nf_fiscal (ref string as_especie)
public function boolean of_serie_nf_fiscal (ref string as_serie)
public function boolean of_proxima_nf_fiscal (ref long al_proxima)
public function boolean of_proximo_nsu (ref long al_proxima)
end prototypes

public function boolean of_localiza_parametro (string as_codigo, ref string as_valor);Boolean lvb_Sucesso = False

Select vl_parametro Into :as_Valor
From parametro_geral
Where cd_parametro = :as_Codigo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
	Case 100
		is_Mensagem_Log = "Par$$HEX1$$e200$$ENDHEX$$metro '" + as_Codigo + "' n$$HEX1$$e300$$ENDHEX$$o localizado."
		
	Case -1
		is_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Par$$HEX1$$e200$$ENDHEX$$metro '" + as_Codigo + "' - " + SqlCa.SqlerrText

End Choose

If ib_Mostra_Mensagem Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_Mensagem_Log , StopSign!)
End If

Return lvb_Sucesso
end function

public function boolean of_proxima_nf (ref long al_proxima);Boolean lvb_Sucesso = False

Long lvl_Ultima
	  
String lvs_Ultima, &
       lvs_Proxima

If This.of_Localiza_Parametro("NR_NF", ref lvl_Ultima) Then
	al_Proxima = lvl_Ultima + 1
	
	lvs_Ultima  = String(lvl_Ultima)
	lvs_Proxima = String(al_Proxima)

	Update parametro_geral
	Set vl_parametro = :lvs_Proxima
	Where cd_parametro = 'NR_NF'
	  and vl_parametro = :lvs_Ultima
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da $$HEX1$$da00$$ENDHEX$$ltima Nota")
	Else	
		If SqlCa.SqlnRows = 0 Then
			lvb_Sucesso = This.of_Proxima_NF(ref al_Proxima)
		Else
			lvb_Sucesso = True
		End If
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_serie_nf (ref string as_serie);If Not This.of_Localiza_Parametro("DE_SERIE_NF", as_Serie) Then 
	Return False
End If

Return True
end function

public function boolean of_especie_nf (ref string as_especie);If Not This.of_Localiza_Parametro("DE_ESPECIE_NF", as_Especie) Then 
	Return False
End If

Return True
end function

public function boolean of_atualiza_parametro (string as_codigo, string as_valor);Update parametro_geral
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

public function boolean of_atualiza_sequencial (string as_parametro);Update parametro_geral
Set vl_parametro = convert(varchar, convert(integer, vl_parametro) + 1)
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

// Formato do Par$$HEX1$$e200$$ENDHEX$$metro: 0,00

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
		
		If ib_Mostra_Mensagem Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor '" + lvs_Valor + "' do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "' inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
		Else
			is_Mensagem_Log = "Valor '" + lvs_Valor + "' do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "' inv$$HEX1$$e100$$ENDHEX$$lido."
		End If
		
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

public function boolean of_proximo_sequencial (string as_parametro, ref long al_proximo);Boolean lvb_Sucesso = False

Long lvl_Ultima
	  
String lvs_Ultima, &
       lvs_Proxima

If This.of_Localiza_Parametro(as_Parametro, ref lvl_Ultima) Then
	al_Proximo = lvl_Ultima + 1
	
	lvs_Ultima  = String(lvl_Ultima)
	lvs_Proxima = String(al_Proximo)

	Update parametro_geral
	Set vl_parametro = :lvs_Proxima
	Where cd_parametro = :as_Parametro
	  and vl_parametro = :lvs_Ultima
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		If ib_Mostra_Mensagem Then
			SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Sequencial do Par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "'")
		Else
			is_Mensagem_Log = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Sequencial do Par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "' - " + SqlCa.SqlErrtext
		End If
	Else	
		If SqlCa.SqlnRows = 0 Then
			lvb_Sucesso = This.of_Proximo_Sequencial(as_Parametro, ref al_Proximo)
		Else
			lvb_Sucesso = True
		End If
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

public function boolean of_localiza_parametro (string as_parametro, ref integer ai_valor);Boolean lvb_Sucesso = False

String lvs_Valor

If This.of_Localiza_Parametro(as_Parametro, lvs_Valor) Then 
	If IsNumber(lvs_Valor) Then
		ai_Valor = Integer(lvs_Valor)	
		
		lvb_Sucesso = True
	Else
		is_Mensagem_Log = "Valor '" + lvs_Valor + "' do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "' inv$$HEX1$$e100$$ENDHEX$$lido."
		
		If ib_Mostra_Mensagem Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_Mensagem_Log , StopSign!)
		End If	
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_especie_nf_fiscal (ref string as_especie);If Not This.of_Localiza_Parametro("DE_ESPECIE_NF_FISCAL", as_Especie) Then 
	Return False
End If

Return True
end function

public function boolean of_serie_nf_fiscal (ref string as_serie);If Not This.of_Localiza_Parametro("DE_SERIE_NF_FISCAL", as_Serie) Then 
	Return False
End If

Return True
end function

public function boolean of_proxima_nf_fiscal (ref long al_proxima);Boolean lvb_Sucesso = False

Long lvl_Ultima
	  
String lvs_Ultima, &
       lvs_Proxima

If This.of_Localiza_Parametro("NR_NF_FISCAL", ref lvl_Ultima) Then
	al_Proxima = lvl_Ultima + 1
	
	lvs_Ultima  = String(lvl_Ultima)
	lvs_Proxima = String(al_Proxima)

	Update parametro_geral
	Set vl_parametro = :lvs_Proxima
	Where cd_parametro = 'NR_NF_FISCAL'
	  and vl_parametro = :lvs_Ultima
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da $$HEX1$$da00$$ENDHEX$$ltima Nota")
	Else	
		If SqlCa.SqlnRows = 0 Then
			lvb_Sucesso = This.of_Proxima_NF_Fiscal(ref al_Proxima)
		Else
			lvb_Sucesso = True
		End If
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_proximo_nsu (ref long al_proxima);Boolean lvb_Sucesso = False

Long lvl_Ultima
	  
String lvs_Ultima, &
       lvs_Proxima

If This.of_Localiza_Parametro("NR_NSU_NF", ref lvl_Ultima) Then
	al_Proxima = lvl_Ultima + 1
	
	lvs_Ultima  = String(lvl_Ultima)
	lvs_Proxima = String(al_Proxima)

	Update parametro_geral
	Set vl_parametro = :lvs_Proxima
	Where cd_parametro = 'NR_NSU_NF'
	  and vl_parametro = :lvs_Ultima
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da $$HEX1$$da00$$ENDHEX$$ltima Nota")
	Else	
		If SqlCa.SqlnRows = 0 Then
			lvb_Sucesso = This.of_proximo_nsu(ref al_Proxima)
		Else
			lvb_Sucesso = True
		End If
	End If
End If

Return lvb_Sucesso
end function

on uo_parametro_geral.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_parametro_geral.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

