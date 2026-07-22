HA$PBExportHeader$uo_calculo.sru
forward
global type uo_calculo from nonvisualobject
end type
end forward

global type uo_calculo from nonvisualobject
end type
global uo_calculo uo_calculo

type variables
Long ivl_Filial_Parametro
Long ivl_Filial_Matriz
end variables

forward prototypes
public function decimal of_juros_composto (decimal pdc_valor, date pdt_vencimento, date pdt_pagamento, decimal pdc_taxa_juros)
public function decimal of_juros_simples (decimal pdc_valor, date pdt_vencimento, date pdt_pagamento, decimal pdc_taxa_juros)
public function decimal of_multa (decimal pdc_valor, date pdt_vencimento, date pdt_pagamento, decimal pdc_taxa_multa)
public function boolean of_vencimento_feriado (date pdt_vencimento)
end prototypes

public function decimal of_juros_composto (decimal pdc_valor, date pdt_vencimento, date pdt_pagamento, decimal pdc_taxa_juros);DECIMAL lvdc_Valor_Juros, &
        lvdc_Base_Juros, &
		  lvdc_Juros_diario

INTEGER lvi_Dias_Vencimento 

DATE    lvdt_Data_Auxilio

lvi_Dias_Vencimento = DaysAfter(pdt_vencimento,pdt_pagamento)

lvdc_Valor_Juros  = 000.00
lvdc_Base_Juros   = 000.00
lvdc_Juros_diario = 000.00

// Calcula Juros
If ( lvi_Dias_Vencimento > 0 and pdc_valor > 0 ) Then 
	
	lvdt_Data_Auxilio = RelativeDate(pdt_vencimento, 1)
	
	lvdc_Base_Juros   = pdc_valor
	
	Do While DaysAfter(lvdt_Data_Auxilio,pdt_pagamento) >= 0 
		
		lvdc_Juros_diario = Round(lvdc_Base_Juros * pdc_taxa_juros,2) / 100
		lvdc_Valor_Juros += lvdc_Juros_diario
		lvdc_Base_Juros  += lvdc_Juros_diario
		
		lvdt_Data_Auxilio = RelativeDate(lvdt_Data_Auxilio,1)
		
	Loop
			
End If

Return lvdc_Valor_Juros
end function

public function decimal of_juros_simples (decimal pdc_valor, date pdt_vencimento, date pdt_pagamento, decimal pdc_taxa_juros);DECIMAL lvdc_Valor_Juros, &
		  lvdc_Juros_diario

INTEGER lvi_Dias_Vencimento
Date ldt_vencimento
String ls_dia_semana
Boolean lb_vence_Feriado

ldt_vencimento = pdt_vencimento

lb_vence_Feriado = This.of_vencimento_feriado(pdt_vencimento)

lvi_Dias_Vencimento = DaysAfter(ldt_vencimento,pdt_pagamento)

lvdc_Valor_Juros  = 000.00
lvdc_Juros_diario = 000.00

If lvi_dias_vencimento > 0 and lvi_dias_vencimento <= 3 Then	
	
	ls_Dia_Semana = Upper(DayName(pdt_pagamento))		
	//Se est$$HEX1$$e100$$ENDHEX$$ vencido a 3 dias ou menos, verifica se $$HEX1$$e900$$ENDHEX$$ Segunda-feira e se o vencimento n$$HEX1$$e300$$ENDHEX$$o ocorreu no final de semana
	//Se ocorreu no final se semana n$$HEX1$$e300$$ENDHEX$$o considera juros.
	If ls_dia_semana = "MONDAY" Then
		ls_Dia_Semana = Upper(DayName(ldt_Vencimento))		
		Choose Case ls_Dia_Semana
			 Case "SATURDAY" ; ldt_Vencimento = RelativeDate(ldt_Vencimento, 2)
			 Case "SUNDAY"   ; ldt_Vencimento = RelativeDate(ldt_Vencimento, 1)
			 Case "FRIDAY"
				If lb_vence_feriado Then
					ldt_Vencimento = RelativeDate(ldt_Vencimento, 3)		
				End If				
		End Choose
		lvi_Dias_Vencimento = DaysAfter(ldt_vencimento,pdt_pagamento)		
	Else
		If ls_dia_semana = "SUNDAY" Then
			ls_Dia_Semana = Upper(DayName(ldt_Vencimento))
			Choose Case ls_Dia_Semana
				 Case "SATURDAY" ; ldt_Vencimento = RelativeDate(ldt_Vencimento, 1)
				 Case "FRIDAY"
					If lb_vence_feriado Then
						ldt_Vencimento = RelativeDate(ldt_Vencimento, 2)
					End If				
			End Choose
			lvi_Dias_Vencimento = DaysAfter(ldt_vencimento,pdt_pagamento)			
		Else
			If lb_vence_feriado and lvi_dias_vencimento = 1 Then
				ldt_Vencimento = RelativeDate(ldt_Vencimento, 1)
				lvi_Dias_Vencimento = DaysAfter(ldt_vencimento,pdt_pagamento)							
			End If		
		End If
	End If	
End If

// Calcula Juros
If ( lvi_Dias_Vencimento > 0 and pdc_valor > 0 ) Then 
	
	lvdc_Juros_diario = Round(Round( pdc_valor * pdc_taxa_juros ,2 )/100,2)
	lvdc_Valor_Juros  = Round( lvdc_Juros_diario * lvi_Dias_Vencimento , 2 )
	
End If

Return lvdc_Valor_Juros
end function

public function decimal of_multa (decimal pdc_valor, date pdt_vencimento, date pdt_pagamento, decimal pdc_taxa_multa);DECIMAL lvdc_Valor_Multa
Long lvi_Dias_Vencimento
Date ldt_vencimento
String lvs_dia_semana
Boolean lb_vence_feriado

lvdc_Valor_Multa  = 000.00

lb_vence_Feriado = This.of_vencimento_feriado(pdt_vencimento)

ldt_vencimento = pdt_vencimento
// Se a data $$HEX1$$e900$$ENDHEX$$ s$$HEX1$$e100$$ENDHEX$$bado ou domingo, altera para segunda-feira
lvs_Dia_Semana = Upper(DayName(ldt_Vencimento))

Choose Case lvs_Dia_Semana
	 Case "SATURDAY" ; ldt_Vencimento = RelativeDate(ldt_Vencimento, 2)
	 Case "SUNDAY"   ; ldt_Vencimento = RelativeDate(ldt_Vencimento, 1)
	 Case "FRIDAY"
		If lb_vence_feriado Then
			ldt_Vencimento = RelativeDate(ldt_Vencimento, 3)		
		End If
	 Case Else
		If lb_vence_feriado Then
			lvi_Dias_Vencimento = DaysAfter(ldt_vencimento,pdt_pagamento)
			If lvi_Dias_Vencimento = 1 Then
				ldt_Vencimento = RelativeDate(ldt_Vencimento, 1)
			End If
		End If
		
End Choose

lvi_Dias_Vencimento = DaysAfter(ldt_vencimento,pdt_pagamento)

// Calcula Juros
If ( lvi_Dias_Vencimento > 0 and pdc_valor > 0 ) Then 
	lvdc_Valor_Multa = Round(Round( pdc_valor * pdc_taxa_multa ,2 )/100,2)
End If

Return lvdc_Valor_Multa
end function

public function boolean of_vencimento_feriado (date pdt_vencimento);String ls_sql, ls_vencimento
Long ll_grupo

If This.ivl_Filial_Parametro <> This.ivl_Filial_Matriz Then
	ls_sql = "select f.cd_grupo_feriado, f.dh_feriado, 'M' from feriado f " + &
				"join filial fl on fl.cd_filial = " + String(This.ivl_Filial_Parametro) + &
				" join feriado_grupo fg " + &
				" on fg.cd_grupo_feriado = f.cd_grupo_feriado " + &
				"where f.dh_feriado = '" + String(pdt_vencimento, 'YYYY/MM/DD') + "'" + &
				" and f.cd_grupo_feriado = fl.cd_grupo_feriado " + &
				"Union " + &
				"select cd_grupo_feriado, dh_feriado, 'N' from feriado " + &
				"where cd_grupo_feriado = 3 and dh_feriado = '" + String(pdt_vencimento, 'YYYY/MM/DD') + "'"
	
	uo_Transacao_Remota lvo_Conexao
	lvo_Conexao = Create uo_Transacao_Remota
	
	lvo_Conexao.of_BancoProducao()
	
	lvo_Conexao.of_Executa_Rotina("0006",{ls_sql})
	
	If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o de Feriados.")
		Return False
	Else
		If lvo_Conexao.of_Linhas() > 0 Then
			Return True
		Else
			Return False
		End If
	End If
Else
	ls_vencimento = String(pdt_vencimento, 'YYYY/MM/DD')
	select cd_grupo_feriado
		Into :ll_grupo
		from feriado 
		where cd_grupo_feriado = 3 
		and dh_feriado = :ls_vencimento
	Using SqlCa;	
	Choose Case SqlCa.SqlCode
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos Feriados")
			Return False			
		Case 100
			Return False		
		Case 0
			Return True
	End Choose	
End If

end function

on uo_calculo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_calculo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;Select cd_filial, 
       cd_filial_matriz
Into :This.ivl_Filial_Parametro,
     :This.ivl_Filial_Matriz
From parametro
Where id_parametro = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial dos par$$HEX1$$e200$$ENDHEX$$metros n$$HEX1$$e300$$ENDHEX$$o localizada.", StopSign!)
		SetNull(This.ivl_Filial_Parametro)		
		SetNull(This.ivl_Filial_Matriz)				
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da filial dos par$$HEX1$$e200$$ENDHEX$$metros." + SqlCa.SqlErrText, StopSign!)
		SetNull(This.ivl_Filial_Parametro)
		SetNull(This.ivl_Filial_Matriz)				
End Choose
end event

