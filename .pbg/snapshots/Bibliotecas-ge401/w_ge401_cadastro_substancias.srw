HA$PBExportHeader$w_ge401_cadastro_substancias.srw
forward
global type w_ge401_cadastro_substancias from dc_w_cadastro_lista
end type
end forward

global type w_ge401_cadastro_substancias from dc_w_cadastro_lista
string accessiblename = "CO194 - Cadastro de Subst$$HEX1$$e200$$ENDHEX$$ncia"
integer width = 1938
integer height = 1524
string title = "GE401 - Cadastro de Subst$$HEX1$$e200$$ENDHEX$$ncias"
end type
global w_ge401_cadastro_substancias w_ge401_cadastro_substancias

on w_ge401_cadastro_substancias.create
call super::create
end on

on w_ge401_cadastro_substancias.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_visual from dc_w_cadastro_lista`dw_visual within w_ge401_cadastro_substancias
end type

type gb_aux_visual from dc_w_cadastro_lista`gb_aux_visual within w_ge401_cadastro_substancias
end type

type dw_1 from dc_w_cadastro_lista`dw_1 within w_ge401_cadastro_substancias
integer width = 1723
integer height = 1180
string dataobject = "dw_ge401_cadastro_substancia"
end type

event dw_1::ue_preupdate;call super::ue_preupdate;Integer lvi_Proximo_Codigo

Long lvl_Linha, &
     lvl_Total

// Verifica o n$$HEX1$$fa00$$ENDHEX$$mero de linhas da DW
lvl_Total = This.RowCount()

// Localiza a primeira linha sem c$$HEX1$$f300$$ENDHEX$$digo
lvl_Linha = This.Find("isnull(cd_substancia)", 0, lvl_Total)

Select Max(cd_substancia) Into :lvi_Proximo_Codigo
From substancia_produto;

If SqlCa.SqlCode = 0 Then
	If IsNull(lvi_Proximo_Codigo) Then
		lvi_Proximo_Codigo = 0
	End If
End If

	
// Executa enquanto existirem linhas sem c$$HEX1$$f300$$ENDHEX$$digo
Do While lvl_Linha > 0
	lvi_Proximo_Codigo ++
	
	// Atualiza a DW com o c$$HEX1$$f300$$ENDHEX$$digo sequencial
	This.Object.cd_substancia[lvl_Linha] = lvi_Proximo_Codigo
	
	lvl_Linha = This.Find("isnull(cd_substancia)", lvl_Linha, lvl_Total)
Loop

Return 1
end event

type gb_1 from dc_w_cadastro_lista`gb_1 within w_ge401_cadastro_substancias
integer width = 1801
end type

