HA$PBExportHeader$dc_uo_multitable_dw.sru
forward
global type dc_uo_multitable_dw from nonvisualobject
end type
end forward

global type dc_uo_multitable_dw from nonvisualobject
end type
global dc_uo_multitable_dw dc_uo_multitable_dw

type variables
Protected:

dc_uo_atributo_multitable_dw ivo_controle[]

// datawindow onde ser$$HEX1$$e100$$ENDHEX$$ aplicado o sort
dc_uo_dw_base ivdw_update

string ivs_coluna_dw[]
end variables

forward prototypes
public subroutine of_setupdatetable (string ps_tabela, string ps_chave[], string ps_coluna[])
public function integer of_update ()
public function boolean of_isupdateable (dc_uo_atributo_multitable_dw po_controle, string ps_coluna)
public function boolean of_iskey (dc_uo_atributo_multitable_dw po_controle, string ps_coluna)
public function boolean of_modify (dc_uo_atributo_multitable_dw po_controle)
public subroutine of_storeoriginalupdate (ref dc_uo_atributo_multitable_dw po_controle)
public subroutine of_setdw (dc_uo_dw_base pdw)
public function boolean of_coluna_ok (string ps_coluna, string ps_tipo, string ps_tabela)
public function boolean of_coluna_ok (ref string ps_coluna[], string ps_tipo, string ps_tabela)
end prototypes

public subroutine of_setupdatetable (string ps_tabela, string ps_chave[], string ps_coluna[]);Integer lvi_Controle
		  
// Verifica se as colunas chaves e update existem na DW
If This.of_Coluna_Ok(ps_Chave, "C", ps_Tabela) Then
	If This.of_Coluna_Ok(ps_Coluna, "U", ps_Tabela) Then
		lvi_Controle = UpperBound(ivo_Controle) + 1
		
		ivo_Controle[lvi_Controle] = Create dc_uo_Atributo_MultiTable_DW
		
		ivo_Controle[lvi_Controle].ivs_Tabela = ps_Tabela
		ivo_Controle[lvi_Controle].ivs_Chave  = ps_Chave
		ivo_Controle[lvi_Controle].ivs_Coluna = ps_Coluna		
	End If
End If
end subroutine

public function integer of_update ();dc_uo_Atributo_Multitable_DW lvo_OriginalUpdate

Integer lvi_Total, &
		  lvi_Contador, &
		  lvi_Update
		  
lvo_OriginalUpdate = Create dc_uo_Atributo_Multitable_DW

// Guarda a configura$$HEX2$$e700e300$$ENDHEX$$o de update original
This.of_StoreOriginalUpdate(lvo_OriginalUpdate)

// Verifica o n$$HEX1$$fa00$$ENDHEX$$mero de tabelas que dever$$HEX1$$e300$$ENDHEX$$o sofrer o update da DW
lvi_Total = UpperBound(ivo_Controle) 

// Loop para cada tabela do update
For lvi_Contador = 1 To lvi_Total

	If This.of_Modify(ivo_Controle[lvi_Contador]) Then
		// Aplica o Update na DW
		lvi_Update = ivdw_Update.Update(True, False) 
		
		If lvi_Update <> 1 Then
			Return -1
		End If
	Else
		Return -1
	End If
	
Next

If ivdw_Update.ResetUpdate() = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na execu$$HEX2$$e700e300$$ENDHEX$$o do ResetUpdate.", StopSign!)
	Return -1
End If

// Volta as configura$$HEX2$$e700f500$$ENDHEX$$es de update originais
If This.of_Modify(lvo_OriginalUpdate) Then
	Return 1
Else
	Return -1
End If
end function

public function boolean of_isupdateable (dc_uo_atributo_multitable_dw po_controle, string ps_coluna);Boolean lvb_Retorno = False

Integer lvi_Contador, &
        lvi_Total

lvi_Total = UpperBound(po_Controle.ivs_Coluna)

For lvi_Contador = 1 To lvi_Total
	
	If Lower(ps_Coluna) = Lower(po_Controle.ivs_Coluna[lvi_Contador]) Then
		lvb_Retorno = True
		Exit
	End If
	
Next

Return lvb_Retorno
end function

public function boolean of_iskey (dc_uo_atributo_multitable_dw po_controle, string ps_coluna);Boolean lvb_Retorno = False

Integer lvi_Contador, &
        lvi_Total

lvi_Total = UpperBound(po_Controle.ivs_Chave)

For lvi_Contador = 1 To lvi_Total
	
	If Lower(ps_Coluna) = Lower(po_Controle.ivs_Chave[lvi_Contador]) Then
		lvb_Retorno = True
		Exit
	End If
	
Next

Return lvb_Retorno
end function

public function boolean of_modify (dc_uo_atributo_multitable_dw po_controle);String lvs_Modify, &
       lvs_Coluna

Integer lvi_Numero_Colunas, &
        lvi_Contador_Coluna

Boolean lvb_UpdateAble, &
        lvb_Key
		  
lvi_Numero_Colunas = Integer(ivdw_Update.Describe("DataWindow.Column.Count")) 

lvs_Modify = "DataWindow.Table.UpdateTable='" + po_Controle.ivs_Tabela + "' "

lvs_Modify += "DataWindow.Table.UpdateWhere=" + String(po_Controle.ivi_WhereOption) + " " 

If po_Controle.ivb_KeyUpdateInPlace Then
	lvs_Modify += "DataWindow.Table.UpdateKeyInPlace=yes " 
Else
	lvs_Modify += "DataWindow.Table.UpdateKeyInPlace=no " 
End If

// Loop para todas as colunas da DW
For lvi_Contador_Coluna = 1 To lvi_Numero_Colunas
	lvs_Coluna = ivdw_Update.Describe("#" + String(lvi_Contador_Coluna) + ".Name")

	// Verifica se a coluna $$HEX1$$e900$$ENDHEX$$ atualiz$$HEX1$$e100$$ENDHEX$$vel
	lvb_UpdateAble = This.of_IsUpdateAble(po_Controle, lvs_Coluna)

	If lvb_UpdateAble Then
		lvs_Modify += lvs_Coluna + ".Update=Yes " 
	Else
		lvs_Modify += lvs_Coluna + ".Update=No " 
	End If
	
	// Verifica se a coluna $$HEX1$$e900$$ENDHEX$$ chave
	lvb_Key = This.of_IsKey(po_Controle, lvs_Coluna)

	If lvb_Key Then
		lvs_Modify += lvs_Coluna + ".Key=Yes " 
	Else
		lvs_Modify += lvs_Coluna + ".Key=No " 
	End If
Next

// Aplica o Modify na DW
If ivdw_Update.Modify(lvs_Modify) <> "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no modify da datawindow.", StopSign!)
	Return False
Else
	Return True
End If
end function

public subroutine of_storeoriginalupdate (ref dc_uo_atributo_multitable_dw po_controle);Integer lvi_Numero_Colunas, &
		  lvi_Contador_Coluna
		  
String lvs_Coluna

po_Controle.ivs_Tabela = ivdw_Update.Describe("DataWindow.Table.UpdateTable")
	
po_Controle.ivi_WhereOption = Integer(ivdw_Update.Describe("DataWindow.Table.UpdateWhere"))
	
If Lower(ivdw_Update.Describe("DataWindow.Table.UpdateKeyInPlace")) = "yes" Then 
   po_Controle.ivb_KeyUpdateInPlace = True
Else
   po_Controle.ivb_KeyUpdateInPlace = False
End If 

lvi_Numero_Colunas = Integer(ivdw_Update.Describe("DataWindow.Column.Count")) 

For lvi_Contador_Coluna = 1 To lvi_Numero_Colunas
	
	lvs_Coluna = ivdw_Update.Describe("#" + String(lvi_Contador_Coluna) + ".Name")
	
	If Lower(ivdw_Update.Describe(lvs_Coluna + ".Update")) = "yes" Then
		po_Controle.ivs_Coluna[UpperBound(po_Controle.ivs_Coluna) + 1] = lvs_Coluna
	End If
	
	If Lower(ivdw_Update.Describe(lvs_Coluna + ".Key")) = "yes" Then
		po_Controle.ivs_Chave[UpperBound(po_Controle.ivs_Chave) + 1] = lvs_Coluna
	End If
	
Next
end subroutine

public subroutine of_setdw (dc_uo_dw_base pdw);Integer lvi_Numero_Colunas, &
		  lvi_Contador_Coluna
		  
String lvs_Coluna, &
       lvs_Array_Vazio[]

// Determina a DW onde ser$$HEX1$$e300$$ENDHEX$$o feitos os updates
This.ivdw_Update = pdw

ivs_Coluna_DW = lvs_Array_Vazio

// Guarda um array com todas as colunas da DW
lvi_Numero_Colunas = Integer(ivdw_Update.Describe("DataWindow.Column.Count")) 

For lvi_Contador_Coluna = 1 To lvi_Numero_Colunas
	
	lvs_Coluna = ivdw_Update.Describe("#" + String(lvi_Contador_Coluna) + ".Name")
	
	ivs_Coluna_DW[lvi_Contador_Coluna] = lvs_Coluna
Next
end subroutine

public function boolean of_coluna_ok (string ps_coluna, string ps_tipo, string ps_tabela);Boolean lvb_Retorno = False

String lvs_Tipo

Integer lvi_Total, &
        lvi_Contador
		
lvi_Total = UpperBound(This.ivs_Coluna_DW)

For lvi_Contador = 1 To lvi_Total
	If Upper(ps_Coluna) = Upper(This.ivs_Coluna_DW[lvi_Contador]) Then
		lvb_Retorno = True
		Exit
	End If
Next

If Not lvb_Retorno Then
	If ps_Tipo = "C" Then
		lvs_Tipo = "chave"
	Else
		lvs_Tipo = "atualiz$$HEX1$$e100$$ENDHEX$$vel"
	End If
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na configura$$HEX2$$e700e300$$ENDHEX$$o do servi$$HEX1$$e700$$ENDHEX$$o de multitable.~r~r" + &
	                      "A coluna " + lvs_Tipo + " '" + Upper(ps_Coluna) + "' da tabela '" + &
	                      Upper(ps_Tabela) + "' n$$HEX1$$e300$$ENDHEX$$o existe na datawindow.", StopSign!)
End If

Return lvb_Retorno
end function

public function boolean of_coluna_ok (ref string ps_coluna[], string ps_tipo, string ps_tabela);Integer lvi_Total, &
        lvi_Contador
		
String lvs_Coluna

Boolean lvb_Retorno = True

lvi_Total = UpperBound(ps_Coluna)

For lvi_Contador = 1 To lvi_Total
	lvs_Coluna = ps_Coluna[lvi_Contador]
	
	If Not This.of_Coluna_Ok(lvs_Coluna, ps_Tipo, ps_Tabela) Then
		lvb_Retorno = False
		Exit
	End If
Next

Return lvb_Retorno
end function

on dc_uo_multitable_dw.create
TriggerEvent( this, "constructor" )
end on

on dc_uo_multitable_dw.destroy
TriggerEvent( this, "destructor" )
end on

