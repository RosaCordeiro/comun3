HA$PBExportHeader$w_ge408_cadatro_tipo_comissao.srw
forward
global type w_ge408_cadatro_tipo_comissao from dc_w_cadastro_lista
end type
end forward

global type w_ge408_cadatro_tipo_comissao from dc_w_cadastro_lista
integer width = 1678
integer height = 1496
string title = "GE408 - Cadastro Tipo de Comiss$$HEX1$$e300$$ENDHEX$$o"
long backcolor = 80269524
end type
global w_ge408_cadatro_tipo_comissao w_ge408_cadatro_tipo_comissao

forward prototypes
public function boolean wf_proximo_codigo (ref long al_tipo)
end prototypes

public function boolean wf_proximo_codigo (ref long al_tipo);Select Max(cd_tipo_comissao)
Into :al_Tipo
From tipo_comissao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo do pr$$HEX1$$f300$$ENDHEX$$ximo tipo de comiss$$HEX1$$e300$$ENDHEX$$o")
	Return False
Else
	If IsNull(al_Tipo) Then al_Tipo = 0
	
	al_Tipo = al_Tipo + 1
End If

Return True

end function

on w_ge408_cadatro_tipo_comissao.create
call super::create
end on

on w_ge408_cadatro_tipo_comissao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_visual from dc_w_cadastro_lista`dw_visual within w_ge408_cadatro_tipo_comissao
integer x = 37
integer y = 936
end type

type gb_aux_visual from dc_w_cadastro_lista`gb_aux_visual within w_ge408_cadatro_tipo_comissao
integer x = 0
integer y = 864
end type

type dw_1 from dc_w_cadastro_lista`dw_1 within w_ge408_cadatro_tipo_comissao
integer x = 50
integer y = 48
integer width = 1518
integer height = 1208
string dataobject = "dw_ge408_lista_tipo_comissao"
end type

event dw_1::ue_preinsertrow;call super::ue_preinsertrow;If dw_1.RowCount() > 0 Then
	If IsNull(dw_1.Object.cd_tipo_comissao[dw_1.RowCount()])Then
		Return -1
	End If
End If

Return 1
end event

event dw_1::ue_preupdate;call super::ue_preupdate;Integer lvi_Retorno = 1

Long lvl_Tipo,&
	 lvl_Linhas,&
	 lvl_Linha

String lvs_DE_Tipo
	 
lvl_Linhas = dw_1.RowCount()

If lvl_Linhas > 0 Then
	
	For lvl_Linha = 1 To lvl_Linhas
		lvs_DE_Tipo = dw_1.Object.de_tipo_comissao[lvl_Linha]
		
		If IsNull(lvs_DE_Tipo) or Trim(lvs_De_Tipo) = "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a descri$$HEX2$$e700e300$$ENDHEX$$o corretamente.")
			dw_1.Event ue_Pos(lvl_Linha, "de_tipo_comissao")
			dw_1.SetFocus()
			lvi_Retorno = -1
			Exit
		End If
	Next
		
	lvl_Tipo = dw_1.Object.cd_tipo_comissao[lvl_Linhas]
	
	If IsNull(lvl_Tipo) Then 
		If Not wf_Proximo_Codigo(Ref lvl_Tipo) Then Return -1
		
		dw_1.Object.cd_tipo_comissao[lvl_Linhas]  = lvl_Tipo
	End If
End If

Return lvi_Retorno
end event

type gb_1 from dc_w_cadastro_lista`gb_1 within w_ge408_cadatro_tipo_comissao
integer x = 14
integer y = 0
integer width = 1577
end type

