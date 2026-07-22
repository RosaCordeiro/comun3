HA$PBExportHeader$dc_uo_sort_dw.sru
forward
global type dc_uo_sort_dw from nonvisualobject
end type
end forward

global type dc_uo_sort_dw from nonvisualobject
end type
global dc_uo_sort_dw dc_uo_sort_dw

type variables
// ivds_1 = sort dispon$$HEX1$$ed00$$ENDHEX$$vel
// ivds_2 = sort aplicado
dc_uo_ds_base ivds_1, &
                          ivds_2

String ivs_Retorno

Protected:
// datawindow onde ser$$HEX1$$e100$$ENDHEX$$ aplicado o sort
dc_uo_dw_base ivdw_sort
end variables

forward prototypes
public subroutine of_setdw (dc_uo_dw_base pdw)
public subroutine of_sort ()
public subroutine of_setoriginalsort ()
public subroutine of_setsortcolumns (string as_coluna[], string as_nome[], string as_bloqueio[])
public subroutine of_verifica_coluna (string as_coluna, ref string as_nome, ref string as_bloqueio)
end prototypes

public subroutine of_setdw (dc_uo_dw_base pdw);This.ivdw_Sort = pdw
end subroutine

public subroutine of_sort ();Long lvl_Linha

String lvs_Retorno, &
       lvs_Coluna, &
       lvs_Ordem, &
		 lvs_Sort_Coluna, &
		 lvs_Sort_Geral
		 
SetNull(This.ivs_Retorno)		 

OpenWithParm(dc_w_Sort_DW, This)

lvs_Retorno = Message.StringParm

// Verifica se o novo sort foi selecionado ou se foi cancelado
If lvs_Retorno <> "S" Then 
	This.ivs_Retorno = 'CANCELAR'
	Return
End If	

For lvl_Linha = 1 To ivds_2.RowCount()
	lvs_Coluna = ivds_2.Object.Coluna[lvl_Linha]
	lvs_Ordem  = ivds_2.Object.Ordem [lvl_Linha]
	
	lvs_Sort_Coluna = lvs_Coluna + " " + lvs_Ordem
	
	If lvs_Sort_Geral <> "" Then lvs_Sort_Geral += ", "
	lvs_Sort_Geral += lvs_Sort_Coluna
Next

This.ivdw_Sort.SetRedraw(False)

This.ivdw_Sort.SetSort(lvs_Sort_Geral)
This.ivdw_Sort.Sort()
This.ivdw_Sort.GroupCalc()

This.ivdw_Sort.SetRedraw(True)

This.ivs_Retorno = 'OK'
end subroutine

public subroutine of_setoriginalsort ();String lvs_Sort, &
		 lvs_Coluna, &
		 lvs_Ordem, &
		 lvs_Nome, &
		 lvs_Bloqueio

Long lvl_Linha

Integer lvi_Pos, &
        lvi_Ini, &
		  lvi_Fim

lvs_Sort = This.ivdw_Sort.Object.DataWindow.Table.Sort

If lvs_Sort <> "?" Then
	// Exemplo : "codigo A, descricao D"
	
	lvi_Ini = 1

	Do		
		lvi_Pos = PosA(lvs_Sort, ",", lvi_Ini)
		
		If lvi_Pos > 0 Then
			lvi_Fim = lvi_Pos - 3
			
			lvs_Ordem  = MidA(lvs_Sort, lvi_Pos - 1, 1)
			lvs_Coluna = MidA(lvs_Sort, lvi_Ini, lvi_Fim - lvi_Ini + 1)
			
			//17.07.2014 - [Douglas]
			//lvi_Ini = lvi_Pos + 2
			lvi_Ini = lvi_Pos + 1
		Else
			lvs_Ordem  = RightA(lvs_Sort, 1)
			lvs_Coluna = MidA(lvs_Sort, lvi_Ini, LenA(lvs_Sort) - lvi_Ini - 1)
		End If
		
		This.of_Verifica_Coluna(lvs_Coluna, ref lvs_Nome, ref lvs_Bloqueio)
		
		lvl_Linha = This.ivds_2.InsertRow(0)
		
		This.ivds_2.Object.Coluna  [lvl_Linha] = Upper(lvs_Coluna)
		This.ivds_2.Object.Nome    [lvl_Linha] = lvs_Nome
	   This.ivds_2.Object.Ordem   [lvl_Linha] = lvs_Ordem
		This.ivds_2.Object.Bloqueio[lvl_Linha] = lvs_Bloqueio
		
	Loop Until lvi_Pos = 0
End If
end subroutine

public subroutine of_setsortcolumns (string as_coluna[], string as_nome[], string as_bloqueio[]);Long lvl_Contador

ivds_1.Reset()

For lvl_Contador = 1 To UpperBound(as_Coluna)
	ivds_1.InsertRow(0)
	
	ivds_1.Object.Coluna  [lvl_Contador] = Upper(as_Coluna[lvl_Contador])
	ivds_1.Object.Nome    [lvl_Contador] = Upper(as_Nome[lvl_Contador])
	ivds_1.Object.Ordem   [lvl_Contador] = "A"
	ivds_1.Object.Bloqueio[lvl_Contador] = Upper(as_Bloqueio[lvl_Contador])
Next

This.of_SetOriginalSort()
end subroutine

public subroutine of_verifica_coluna (string as_coluna, ref string as_nome, ref string as_bloqueio);Integer lvi_Find

as_Coluna = Upper(as_Coluna)

lvi_Find = This.ivds_1.Find("coluna = '" + as_Coluna + "'", 1, This.ivds_1.RowCount())

If lvi_Find > 0 Then
	as_Nome     = This.ivds_1.Object.Nome    [lvi_Find]
	as_Bloqueio = This.ivds_1.Object.Bloqueio[lvi_Find]
Else
	SetNull(as_Nome)
	SetNull(as_Bloqueio)
End If

end subroutine

on dc_uo_sort_dw.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_sort_dw.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivds_1 = Create dc_uo_ds_Base
ivds_2 = Create dc_uo_ds_Base

ivds_1.of_ChangeDataObject("dc_dw_sort_disponivel")
ivds_2.of_ChangeDataObject("dc_dw_sort_aplicado")
end event

event destructor;Destroy(ivds_1)
Destroy(ivds_2)
end event

