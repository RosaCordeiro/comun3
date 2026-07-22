HA$PBExportHeader$dc_uo_data.sru
forward
global type dc_uo_data from nonvisualobject
end type
end forward

global type dc_uo_data from nonvisualobject
end type
global dc_uo_data dc_uo_data

forward prototypes
public function date of_ultimo_dia_mes (integer ai_mes, integer ai_ano)
public function date of_mesmo_dia_proximo_mes (date adt_base)
public function date of_ultimo_dia_mes (date adt_base, integer ai_meses)
end prototypes

public function date of_ultimo_dia_mes (integer ai_mes, integer ai_ano);Date lvdt_Data

ai_Mes += 1

If ai_Mes = 13 Then
	ai_Mes  = 1
	ai_Ano += 1
End If

lvdt_Data = Date("01/" + String(ai_Mes, "00") + "/" + String(ai_Ano, "0000"))

lvdt_Data = RelativeDate(lvdt_Data, -1)

Return lvdt_Data
end function

public function date of_mesmo_dia_proximo_mes (date adt_base);Date lvdt_Retorno, &
     lvdt_Ultimo_Dia_Mes

Integer lvi_Dia, &
        lvi_Mes, &
		  lvi_Ano

lvi_Dia = Day  (adt_Base)
lvi_Mes = Month(adt_Base)
lvi_Ano = Year (adt_Base)

If lvi_Mes = 12 Then
	lvi_Mes = 1
	lvi_Ano ++
Else
	lvi_Mes ++
End If

lvdt_Ultimo_Dia_Mes = This.of_Ultimo_Dia_Mes(lvi_Mes, lvi_Ano)

If Day(lvdt_Ultimo_Dia_Mes) > lvi_Dia Then
	lvdt_Retorno = Date(String(lvi_Dia) + "/" + String(lvdt_Ultimo_Dia_Mes, "mm/yyyy"))
Else
	lvdt_Retorno = lvdt_Ultimo_Dia_Mes
End If

Return lvdt_Retorno
end function

public function date of_ultimo_dia_mes (date adt_base, integer ai_meses);Integer lvi_Contador, &
        lvi_Mes, &
		  lvi_Ano

Date lvdt_Ultimo_Dia

lvi_Mes = Month(adt_Base)
lvi_Ano = Year(adt_Base)

If ai_Meses >= 0 Then
	For lvi_Contador = 1 To ai_Meses + 1
		If lvi_Mes = 12 Then
			lvi_Mes = 1
			lvi_Ano ++
		Else
			lvi_Mes ++
		End If
	Next
Else
	For lvi_Contador = 1 To Abs(ai_Meses) - 1
		If lvi_Mes = 1 Then
			lvi_Mes = 12
			lvi_Ano --
		Else
			lvi_Mes --
		End If
	Next
End If

lvdt_Ultimo_Dia = Date("01/" + String(lvi_Mes, "00") + "/" + String(lvi_Ano, "0000"))

lvdt_Ultimo_Dia = RelativeDate(lvdt_Ultimo_Dia, -1)

Return lvdt_Ultimo_Dia
end function

on dc_uo_data.create
TriggerEvent( this, "constructor" )
end on

on dc_uo_data.destroy
TriggerEvent( this, "destructor" )
end on

