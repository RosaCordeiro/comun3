HA$PBExportHeader$w_ge046_cadastro_cidade.srw
$PBExportComments$Cadastro de Cidades
forward
global type w_ge046_cadastro_cidade from dc_w_cadastro_lista
end type
end forward

global type w_ge046_cadastro_cidade from dc_w_cadastro_lista
integer width = 2578
integer height = 1908
string title = "GE046 - Cadastro de Cidades"
end type
global w_ge046_cadastro_cidade w_ge046_cadastro_cidade

forward prototypes
public function integer wf_ultimo_codigo ()
end prototypes

public function integer wf_ultimo_codigo ();Integer lvi_Ultimo

Select Max(cd_cidade) into :lvi_Ultimo
from cidade
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgdbError("localiza$$HEX2$$e700e300$$ENDHEX$$o do $$HEX1$$fa00$$ENDHEX$$ltimo c$$HEX1$$f300$$ENDHEX$$digo de cidade")
		Return -1
	Case 0
	
		If IsNull(lvi_Ultimo) Then
			
			lvi_Ultimo = 0 		
		End If	
End Choose

Return lvi_Ultimo
end function

on w_ge046_cadastro_cidade.create
call super::create
end on

on w_ge046_cadastro_cidade.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_1 from dc_w_cadastro_lista`dw_1 within w_ge046_cadastro_cidade
integer x = 50
integer y = 56
integer width = 2469
integer height = 1636
string dataobject = "dw_ge046_lista"
boolean ivb_ordena_colunas = true
end type

event dw_1::ue_preupdate;call super::ue_preupdate;Integer lvi_Proximo_Codigo

Long  lvl_Linha, &
      lvl_Total

// Verifica o n$$HEX1$$fa00$$ENDHEX$$mero de linhas da DW
lvl_Total = This.RowCount()

// Localiza a primeira linha sem c$$HEX1$$f300$$ENDHEX$$digo
lvl_Linha = This.Find("isnull(cd_cidade)", 0, lvl_Total)

lvi_Proximo_Codigo = wf_Ultimo_Codigo()

If lvi_Proximo_Codigo = -1 Then Return -1
	
// Executa enquanto existirem linhas sem c$$HEX1$$f300$$ENDHEX$$digo
Do While lvl_Linha > 0
	lvi_Proximo_Codigo ++
	
	// Atualiza a DW com o c$$HEX1$$f300$$ENDHEX$$digo sequencial
	This.Object.Cd_Cidade[lvl_Linha] = lvi_Proximo_Codigo
	
	lvl_Linha = This.Find("isnull(cd_cidade)", lvl_Linha, lvl_Total)
Loop

Return 1
end event

event dw_1::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_cidade", &
              "nm_cidade", &
				  "cd_unidade_federacao", &
				  "cd_uf_ibge", &
				  "cd_cidade_ibge"}

lvs_Nome = {"Cidade", &
            "Nome da Cidade", &
				"U.F.", &
				"U.F.(ibge)" , &
				"Cidade (ibge)"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)
 

end event

type gb_1 from dc_w_cadastro_lista`gb_1 within w_ge046_cadastro_cidade
integer x = 14
integer y = 0
integer width = 2519
integer height = 1708
end type

