HA$PBExportHeader$w_ge310_cadastro_prioridade_faturamento.srw
forward
global type w_ge310_cadastro_prioridade_faturamento from dc_w_cadastro_lista
end type
end forward

global type w_ge310_cadastro_prioridade_faturamento from dc_w_cadastro_lista
integer width = 3502
integer height = 1988
string title = "GE310 - Prioridades de Faturamento / Rota"
boolean resizable = false
end type
global w_ge310_cadastro_prioridade_faturamento w_ge310_cadastro_prioridade_faturamento

on w_ge310_cadastro_prioridade_faturamento.create
call super::create
end on

on w_ge310_cadastro_prioridade_faturamento.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;DataWindowChild lvdwc

Integer lvi_Retorno,&
        	lvi_Row
Long ls_Null			  

ivm_Menu.mf_Recuperar(False)
ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)

SetNull(ls_Null)

If dw_1.GetChild("nr_rota_entrega", lvdwc) = 1 Then
	//lvdwc.InsertRow(1)
	
	lvi_Row = lvdwc.Find("nr_rota = 0",1, lvdwc.RowCount())
	
	lvdwc.SetItem(lvi_Row, "nr_rota", ls_Null)
	lvdwc.SetItem(lvi_Row, "de_rota", "")
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da rota.")
End If

end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 Then dw_1.Sort()

Return AncestorReturnValue
end event

type dw_1 from dc_w_cadastro_lista`dw_1 within w_ge310_cadastro_prioridade_faturamento
integer x = 59
integer y = 56
integer width = 3369
integer height = 1732
string dataobject = "dw_ge310_lista"
end type

event dw_1::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_filial", "nm_fantasia","nr_prioridade_faturamento","id_24horas","id_periodo_faturamento", "nr_rota_entrega","nr_dias_entrega"}

lvs_Nome   = {"C$$HEX1$$f300$$ENDHEX$$digo" , "Filial" ,"Prioridade", "24horas" , "Per$$HEX1$$ed00$$ENDHEX$$odo", "Rota","Dias Entrega"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.ivb_Ordena_Colunas = True

end event

event dw_1::itemchanged;call super::itemchanged;Long   lvl_Filial,&
       lvl_Find
	  
String lvs_Filial	  

If This.GetColumnName() = "nr_prioridade_faturamento" Then
	
	lvl_Filial = dw_1.Object.cd_filial[row]
	
	lvl_Find = dw_1.Find("cd_filial <> " + String(lvl_Filial) + " and nr_prioridade_faturamento = " + String(data),1,dw_1.RowCount())
	
	If lvl_Find > 0 Then
		
		lvs_Filial = dw_1.Object.nm_fantasia[lvl_Find] + " (" + String(lvl_Filial) + ")"
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Filial : " + lvs_Filial + " j$$HEX1$$e100$$ENDHEX$$ esta com prioridade " + data)
		
		Return 1
		
	End If
End If
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;SelectText(1,10)
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivm_Menu.mf_SalvarComo(True)
End If

Return pl_Linhas
end event

type gb_1 from dc_w_cadastro_lista`gb_1 within w_ge310_cadastro_prioridade_faturamento
integer x = 23
integer y = 0
integer width = 3433
integer height = 1804
end type

