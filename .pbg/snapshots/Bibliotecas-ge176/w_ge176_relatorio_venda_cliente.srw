HA$PBExportHeader$w_ge176_relatorio_venda_cliente.srw
forward
global type w_ge176_relatorio_venda_cliente from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge176_relatorio_venda_cliente from dc_w_selecao_lista_relatorio
integer width = 3552
integer height = 1912
string title = "GE176 - Relat$$HEX1$$f300$$ENDHEX$$rio de Vendas para Clientes por Produto"
long backcolor = 80269524
end type
global w_ge176_relatorio_venda_cliente w_ge176_relatorio_venda_cliente

type variables
uo_convenio ivo_convenio
uo_conveniado ivo_conveniado
uo_filial              ivo_filial
uo_Cliente         ivo_Cliente
end variables

forward prototypes
public subroutine wf_localiza_conveniado ()
public subroutine wf_localiza_convenio ()
public subroutine wf_localiza_filial ()
public subroutine wf_insere_condicao_default ()
public subroutine wf_localiza_cliente ()
end prototypes

public subroutine wf_localiza_conveniado ();String lvs_Conveniado

Long lvl_Convenio

dw_1.AcceptText()

If dw_1.Object.Cd_Convenio[1] <> 0 Then
 lvl_Convenio = dw_1.Object.Cd_Convenio[1]
 lvs_Conveniado = dw_1.GetText()

 ivo_Conveniado.of_Localiza_Conveniado(lvl_Convenio, lvs_Conveniado)

 If ivo_Conveniado.Localizado Then
	dw_1.Object.Cd_Conveniado[1] = ivo_Conveniado.Cd_Conveniado
	dw_1.Object.Nm_Conveniado[1] = ivo_Conveniado.Nm_Conveniado
 End If
ELSE
 lvs_Conveniado = dw_1.GetText()

// ivo_Conveniado.of_Localiza_Conveniado(lvs_Conveniado)

 //If ivo_Conveniado.Localizado Then
	dw_1.Object.Cd_Conveniado[1] = ivo_Conveniado.Cd_Conveniado
	dw_1.Object.Nm_Conveniado[1] = ivo_Conveniado.Nm_Conveniado
// End If
END If 
	 
end subroutine

public subroutine wf_localiza_convenio ();String lvs_Convenio

lvs_Convenio = dw_1.GetText()

ivo_Convenio.of_Localiza_Convenio(lvs_Convenio)

If ivo_Convenio.Localizado Then
	dw_1.Object.Cd_Convenio[1] = ivo_Convenio.Cd_Convenio
	dw_1.Object.Nm_Fantasia[1] = ivo_Convenio.Nm_Fantasia
	
	//dw_1.of_Populate_DDDW("cd_condicao_convenio")
End If
end subroutine

public subroutine wf_localiza_filial ();String lvs_Filial

Long lvl_Cd_Filial

lvs_Filial = dw_1.GetText()
SetNull(lvl_Cd_Filial)

ivo_Filial.of_Localiza_Filial(lvs_Filial)

If ivo_Filial.Localizada Then
	dw_1.Object.Cd_Filial_Centralizadora[1] = ivo_Filial.Cd_Filial
	dw_1.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
Else
	dw_1.Object.Nm_Filial[1]                = ""
	dw_1.Object.Cd_Filial_Centralizadora[1] = lvl_Cd_Filial
End If
end subroutine

public subroutine wf_insere_condicao_default ();Integer lvi_Retorno, &
        lvi_Linha

DataWindowChild lvdwc

lvi_Retorno = dw_1.GetChild("cd_condicao_convenio", lvdwc)

If lvi_Retorno = 1 Then
	lvi_Linha = lvdwc.InsertRow(1)
	
	If lvi_Linha > 0 Then
		lvdwc.SetItem(lvi_Linha, "cd_condicao_convenio", 0)
		lvdwc.SetItem(lvi_Linha, "de_condicao_convenio", "TODAS")
		
		dw_1.Object.Cd_Condicao_Convenio[1] = 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o da condi$$HEX2$$e700e300$$ENDHEX$$o default.", StopSign!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da condi$$HEX2$$e700e300$$ENDHEX$$o do conv$$HEX1$$ea00$$ENDHEX$$nio.", StopSign!)
End If
end subroutine

public subroutine wf_localiza_cliente ();ivo_Cliente.of_Localiza_Cliente(dw_1.GetText())

If ivo_Cliente.Localizado Then
	
	dw_1.Object.Cd_Cliente[1] = ivo_Cliente.Cd_Cliente
	dw_1.Object.Nm_Cliente[1] = ivo_Cliente.Nm_Cliente
End If
end subroutine

on w_ge176_relatorio_venda_cliente.create
call super::create
end on

on w_ge176_relatorio_venda_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Convenio)
Destroy(ivo_Conveniado)
Destroy(ivo_Filial)
Destroy(ivo_Cliente)

end event

event ue_postopen;call super::ue_postopen;This.ivm_Menu.ivb_Permite_Imprimir = True

ivo_Convenio   = Create uo_Convenio
ivo_Conveniado = Create uo_Conveniado
ivo_Cliente    = Create uo_Cliente

dw_1.Object.Dt_Inicio[1]  = Today()
dw_1.Object.Dt_Termino[1] = Today()

end event

event ue_saveas;dw_3.Event ue_SaveAs()



end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge176_relatorio_venda_cliente
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge176_relatorio_venda_cliente
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge176_relatorio_venda_cliente
integer x = 23
integer y = 272
integer width = 3461
integer height = 1440
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge176_relatorio_venda_cliente
integer x = 14
integer y = 0
integer width = 1874
integer height = 260
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge176_relatorio_venda_cliente
integer x = 27
integer y = 60
integer width = 1842
integer height = 192
integer taborder = 40
string dataobject = "dw_ge176_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;String lvs_Nulo

Long lvl_Nulo

SetNull(lvl_Nulo)
SetNull(lvs_Nulo)
			
Choose Case dwo.Name
	
	Case "nm_cliente"
		If Trim(Data) <> "" Then
			If Data <> ivo_Cliente.Nm_Cliente Then
				Return 1
			End If
		Else
			This.Object.Cd_Cliente[1] = lvs_Nulo
			This.Object.Nm_Cliente[1] = ""
			
			ivo_Cliente.Nm_Cliente = ""			
		End If	
	
End Choose

end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Cliente) Then
	This.Object.Nm_Cliente[1] = ivo_Cliente.Nm_Cliente
End If


end event

event dw_1::ue_key;String lvs_Coluna

dw_1.AcceptText()

If Key = KeyEnter! Then
	
	lvs_Coluna = dw_1.GetColumnName()
	
	Choose Case lvs_Coluna
		Case "nm_cliente"  ; wf_Localiza_Cliente()
	End Choose
End If
			

			
			
end event

event dw_1::ue_addrow;call super::ue_addrow;This.SetTransObject(SqlCa)
//This.of_Populate_DDDW("cd_condicao_convenio")*/

Return AncestorReturnValue



end event

event dw_1::ue_preinsertrow;call super::ue_preinsertrow;This.DataObject = "dw_ge176_selecao"

Return 1
end event

event dw_1::ue_populate_dddw;Long lvl_cd_cliente, &
     lvl_Nulo

pdwc_DDDW.SetTransObject(SqlCa)

This.AcceptText()

lvl_cd_cliente = This.Object.cd_cliente[1]

If Not IsNull(lvl_cd_cliente) and lvl_Cd_Cliente > 0 Then
	pdwc_DDDW.Retrieve(lvl_Cd_Cliente)
	

End If

end event

event dw_1::editchanged;call super::editchanged;/*String lvs_Nulo

Long   lvl_Nulo

SetNull(lvl_Nulo)
SetNull(lvs_Nulo)
			
Choose Case dwo.Name
			
	Case "nm_cliente"
	  //This.Object.Cd_Cliente[1]   = lvl_Nulo
	  This.Object.Nm_Cliente[1] = ""		
	
End Choose*/
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge176_relatorio_venda_cliente
integer x = 37
integer y = 332
integer width = 3406
integer height = 1364
integer taborder = 50
string dataobject = "dw_ge176_lista_produto_cliente"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Filial   ,&
     lvl_Convenio ,&
	  lvl_Condicao ,&
	  lvl_Cliente

String lvs_Conveniado, &
		 lvs_Group, &
		 lvs_DW_Consulta, &
		 lvs_DW_Relatorio, &
		 lvs_cliente

Date lvdt_Inicio, &
     lvdt_Termino

dw_1.AcceptText()
	
lvs_DW_Relatorio = "dw_ge176_rel_venda_produto"

If lvs_DW_Relatorio <> dw_3.DataObject Then
	dw_3.of_ChangeDataObject(lvs_DW_Relatorio)
	This.ShareData(dw_3)
End If	

lvs_cliente		= dw_1.Object.Cd_Cliente	[1]
lvdt_Inicio		= dw_1.Object.Dt_Inicio		[1]
lvdt_Termino	= dw_1.Object.Dt_Termino	[1]

If IsNull(lvdt_Inicio) or Not IsDate(String(lvdt_Inicio)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdt_Termino) or Not IsDate(String(lvdt_Termino)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_termino")	
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_termino")	
	Return -1
End If

If IsNull(lvs_cliente) or (Trim(lvs_cliente)="") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Favor informar o cliente.", Exclamation!)
	dw_1.Event ue_Pos(1, "nm_cliente")	
	Return -1
End If

This.of_AppendWhere("nf_venda.dh_movimentacao_caixa between '" + String(lvdt_Inicio,"yyyymmdd") + "'" + &
                    " and '" + String(lvdt_Termino,"yyyymmdd") + "'")

If Not IsNull(lvs_Cliente) Then
	This.of_AppendWhere("nf_venda.cd_cliente = '" + lvs_Cliente + "'" ,1)
End If

This.of_SetRowSelection()

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_linhas > 0 Then
	This.ivm_Menu.mf_SalvarComo(True)
Else
	This.ivm_Menu.mf_SalvarComo(False)
End If

Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge176_relatorio_venda_cliente
integer x = 2734
integer y = 1184
integer width = 416
integer height = 240
integer taborder = 60
string dataobject = "dw_ge176_rel_venda_produto"
end type

event dw_3::ue_preprint;call super::ue_preprint;String lvs_Periodo ,& 
       lvs_Nome    ,&
		 lvs_Cliente 


Date   lvdt_Inicio, &
       lvdt_Termino


	lvdt_Inicio		= dw_1.Object.Dt_Inicio		[1]
	lvdt_Termino	= dw_1.Object.Dt_Termino	[1]
	lvs_Nome		= dw_1.Object.Nm_Cliente	[1]
	lvs_Cliente		= dw_1.Object.Cd_Cliente	[1] 
	
	lvs_Periodo = String(lvdt_Inicio,  "dd/mm/yyyy") + " $$HEX1$$e000$$ENDHEX$$ " + &
					  String(lvdt_Termino, "dd/mm/yyyy")
	
	dw_3.Object.Periodo.Text = lvs_Periodo
	
	If Not IsNull(lvs_Cliente) Then
	 dw_3.Object.Cliente.Text = lvs_Nome + " - (" + lvs_Cliente  + ")" 
   End If  

Return AncestorReturnValue
end event

