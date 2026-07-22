HA$PBExportHeader$dc_uo_filter_dw.sru
forward
global type dc_uo_filter_dw from nonvisualobject
end type
end forward

global type dc_uo_filter_dw from nonvisualobject
end type
global dc_uo_filter_dw dc_uo_filter_dw

type variables
// ivds_1 = filter dispon$$HEX1$$ed00$$ENDHEX$$vel
// ivds_2 = filter aplicado
dc_uo_ds_base ivds_1, &
                          ivds_2

string ivs_filtro, &
         ivs_filtro_traduzido

Protected:
// datawindow onde ser$$HEX1$$e100$$ENDHEX$$ aplicado o sort
dc_uo_dw_base ivdw_filter


end variables

forward prototypes
public subroutine of_setdw (dc_uo_dw_base pdw)
public function string of_nome_coluna (string ps_coluna)
public subroutine of_setfiltercolumns (string ps_coluna[], string ps_nome[])
public subroutine of_filter ()
public subroutine of_buildfilter ()
public subroutine of_clearfilter ()
public function string of_coltype (string ps_coluna)
end prototypes

public subroutine of_setdw (dc_uo_dw_base pdw);This.ivdw_Filter = pdw
end subroutine

public function string of_nome_coluna (string ps_coluna);Integer lvi_Find

String lvs_Nome

ps_Coluna = Upper(ps_Coluna)

lvi_Find = This.ivds_1.Find("coluna = '" + ps_Coluna + "'", 1, This.ivds_1.RowCount())

If lvi_Find > 0 Then
	lvs_Nome = This.ivds_1.Object.Nome[lvi_Find]
Else
	SetNull(lvs_Nome)
End If

Return lvs_Nome


end function

public subroutine of_setfiltercolumns (string ps_coluna[], string ps_nome[]);Long lvl_Contador

ivds_1.Reset()

For lvl_Contador = 1 To UpperBound(ps_Coluna)
	ivds_1.InsertRow(0)
	
	ivds_1.Object.Coluna[lvl_Contador] = Upper(ps_Coluna[lvl_Contador])
	ivds_1.Object.Nome[lvl_Contador]   = Upper(ps_Nome[lvl_Contador])
Next
end subroutine

public subroutine of_filter ();String lvs_Filtro

OpenWithParm(dc_w_Filter_DW, This)

lvs_Filtro = Message.StringParm

If Not IsNull(lvs_Filtro) Then
	This.of_BuildFilter()
	
	This.ivdw_Filter.SetFilter(This.ivs_Filtro)
	
	If This.ivdw_Filter.Filter() = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filtro inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
		
		This.ivs_Filtro           = ""
		This.ivs_Filtro_Traduzido = ""
	End If
End If
end subroutine

public subroutine of_buildfilter ();Long lvl_Max
Long lvl_Linha
Long lvl_Row	 
	  
String lvs_Column
String lvs_Coluna
String lvs_Operador
String lvs_Operacao
String lvs_Value
String lvs_Valor
String lvs_ANDOR
String lvs_EOU
String lvs_Tipo
		 
lvl_Max = ivds_2.RowCount()

This.ivs_Filtro          	 	= ""
This.ivs_Filtro_Traduzido	= ""

For lvl_Linha = 1 To lvl_Max
	lvs_Column   	= ivds_2.Object.Coluna  		[ lvl_Linha ]
	lvs_Operador 	= ivds_2.Object.Operador	[ lvl_Linha ]
	lvs_Value		= ivds_2.Object.Valor   		[ lvl_Linha ]
	lvs_Valor			= lvs_Value
	lvs_AndOr    	= ivds_2.Object.And_Or		[ lvl_Linha ]

	lvs_Coluna = This.of_Nome_Coluna(lvs_Column)
	
	If IsNull(lvs_AndOr) Then lvs_AndOr = ""
	
	lvs_Tipo = This.of_ColType(lvs_Column)
	
	Choose Case Lower(LeftA(lvs_Tipo, 5))
		Case "date"
			lvs_Value = "Date(" + lvs_Value  + ")" 

		Case "datet"				
			lvs_Value = "DateTime(" + lvs_Value + ")" 

		Case "time", "times"		
			lvs_Value = "Time(" + lvs_Value + ")" 
	End Choose
	
	Choose Case Upper(lvs_AndOr)
		Case "AND" ; lvs_EOU = "E"
		Case "OR"  ; lvs_EOU = "OU"
		Case ""    ; lvs_EOU = ""
	End Choose
	
	Choose Case lvs_Operador
		Case "="  	; lvs_Operacao = "IGUAL A"
		Case ">"  	; lvs_Operacao = "MAIOR QUE"
		Case "<"  	; lvs_Operacao = "MENOR QUE"
		Case ">=" 	; lvs_Operacao = "MAIOR OU IGUAL A"
		Case "<=" 	; lvs_Operacao = "MENOR OU IGUAL A"
		Case "<>" 	; lvs_Operacao = "DIFERENTE DE"		
			
		Case "X%" //Filtro COME$$HEX1$$c700$$ENDHEX$$A COM EX. nm_fantasia like 'CLAMED%'
			lvs_Operacao 	= "COME$$HEX1$$c700$$ENDHEX$$A COM"
			lvs_Operador 	= 'LIKE'
			lvs_Value		= gf_replace(lvs_Value, "'", "", 2)
			lvs_Value		= "'" + lvs_Value + "%'"
			
		Case "%X" //Filtro TERMINA COM EX. nm_fantasia like '%CLAMED'
			lvs_Operacao 	= "TERMINA COM"
			lvs_Operador 	= 'LIKE'
			lvs_Value		= gf_replace(lvs_Value, "'", "", 2)
			lvs_Value		= "'%" + lvs_Value + "'"
						
		Case "%"   //Filtro CONTEM EX. nm_fantasia like '%CLAMED%'
			lvs_Operacao 	= "CONT$$HEX1$$c900$$ENDHEX$$M"
			lvs_Operador 	= 'LIKE'
			lvs_Value		= gf_replace(lvs_Value, "'", "", 2)
			lvs_Value		= "'%" + lvs_Value + "%'"
			
	End Choose
	
	This.ivs_Filtro += "(" + lvs_Column + " " + &
	                   		lvs_Operador + " " + &
							 lvs_Value + ") " + &
							 lvs_ANDOR + " "
							 

	This.ivs_Filtro_Traduzido += lvs_Coluna + " " + &
	                             				lvs_Operacao + " " + &
										  	lvs_Valor + " " + &
										  	lvs_EOU + " "
										  
Next
end subroutine

public subroutine of_clearfilter ();This.ivdw_Filter.SetFilter("")
This.ivdw_Filter.Filter()

This.ivdw_Filter.Sort()

This.ivds_2.Reset()

This.ivs_Filtro           = ""
This.ivs_Filtro_Traduzido = ""
end subroutine

public function string of_coltype (string ps_coluna);String lvs_Tipo

lvs_Tipo = This.ivdw_Filter.Describe(ps_Coluna + ".ColType" )

Return lvs_Tipo
end function

on dc_uo_filter_dw.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_filter_dw.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivds_1 = Create dc_uo_ds_Base
ivds_2 = Create dc_uo_ds_Base

ivds_1.of_ChangeDataObject("dc_dw_filtro_disponivel")
ivds_2.of_ChangeDataObject("dc_dw_filtro_aplicado")
end event

event destructor;Destroy(ivds_1)
Destroy(ivds_2)
end event

