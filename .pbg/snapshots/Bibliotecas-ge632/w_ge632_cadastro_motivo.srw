HA$PBExportHeader$w_ge632_cadastro_motivo.srw
$PBExportComments$Cadastro de Cidades
forward
global type w_ge632_cadastro_motivo from dc_w_cadastro_lista
end type
end forward

global type w_ge632_cadastro_motivo from dc_w_cadastro_lista
string tag = "w_ge632_cadastro_motivo"
integer width = 1714
integer height = 1908
string title = "GE632 - Procedimento Acordos Devolu$$HEX2$$e700e300$$ENDHEX$$o"
end type
global w_ge632_cadastro_motivo w_ge632_cadastro_motivo

forward prototypes
public function integer wf_ultimo_codigo ()
end prototypes

public function integer wf_ultimo_codigo ();Integer lvi_Ultimo

Select Max(cd_procedimento_acordo) 
into :lvi_Ultimo
from distribuidora_proced_acordo
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgdbError("localiza$$HEX2$$e700e300$$ENDHEX$$o do $$HEX1$$fa00$$ENDHEX$$ltimo c$$HEX1$$f300$$ENDHEX$$digo do motivo")
		Return -1
	Case 0
	
		If IsNull(lvi_Ultimo) Then
			
			lvi_Ultimo = 0 		
		End If	
End Choose

Return lvi_Ultimo
end function

on w_ge632_cadastro_motivo.create
call super::create
end on

on w_ge632_cadastro_motivo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_visual from dc_w_cadastro_lista`dw_visual within w_ge632_cadastro_motivo
end type

type gb_aux_visual from dc_w_cadastro_lista`gb_aux_visual within w_ge632_cadastro_motivo
end type

type dw_1 from dc_w_cadastro_lista`dw_1 within w_ge632_cadastro_motivo
integer x = 50
integer y = 56
integer width = 1563
integer height = 1636
string dataobject = "dw_ge632_lista"
boolean ivb_ordena_colunas = true
end type

event dw_1::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_motivo", &
                    "descricao"}

lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo", &
            "Descri$$HEX2$$e700e300$$ENDHEX$$o"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)
 

end event

event dw_1::ue_preupdate;call super::ue_preupdate;Integer lvi_Proximo_Codigo

Long  lvl_Linha, &
      lvl_Total

// Verifica o n$$HEX1$$fa00$$ENDHEX$$mero de linhas da DW
lvl_Total = This.RowCount()

// Localiza a primeira linha sem c$$HEX1$$f300$$ENDHEX$$digo
lvl_Linha = This.Find("isnull(cd_procedimento_acordo)", 0, lvl_Total)

lvi_Proximo_Codigo = wf_Ultimo_Codigo()

If lvi_Proximo_Codigo = -1 Then Return -1
	
// Executa enquanto existirem linhas sem c$$HEX1$$f300$$ENDHEX$$digo
Do While lvl_Linha > 0
	lvi_Proximo_Codigo ++
	
	// Atualiza a DW com o c$$HEX1$$f300$$ENDHEX$$digo sequencial
	This.Object.cd_procedimento_acordo [lvl_Linha] = lvi_Proximo_Codigo
	
	lvl_Linha = This.Find("isnull(cd_procedimento_acordo)", lvl_Linha, lvl_Total)
Loop

Return 1
end event

type gb_1 from dc_w_cadastro_lista`gb_1 within w_ge632_cadastro_motivo
integer x = 14
integer y = 0
integer width = 1637
integer height = 1708
end type

