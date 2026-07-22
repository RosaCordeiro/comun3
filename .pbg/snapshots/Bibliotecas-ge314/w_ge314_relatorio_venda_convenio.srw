HA$PBExportHeader$w_ge314_relatorio_venda_convenio.srw
forward
global type w_ge314_relatorio_venda_convenio from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge314_relatorio_venda_convenio from dc_w_selecao_lista_relatorio
string tag = "w_ge314_relatorio_venda_convenio"
integer width = 4238
integer height = 1904
string title = "GE314 - Relat$$HEX1$$f300$$ENDHEX$$rio de Vendas para Conv$$HEX1$$ea00$$ENDHEX$$nios por Produto"
boolean resizable = false
long backcolor = 80269524
end type
global w_ge314_relatorio_venda_convenio w_ge314_relatorio_venda_convenio

type variables
uo_convenio 		ivo_convenio
uo_conveniado 		ivo_conveniado
uo_filial              	ivo_filial
uo_produto			ivo_Produto
end variables

forward prototypes
public subroutine wf_localiza_conveniado ()
public subroutine wf_localiza_convenio ()
public subroutine wf_localiza_filial ()
public subroutine wf_localiza_produto ()
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
	dw_1.Object.Cd_Filial	[1] 	= ivo_Filial.Cd_Filial
	dw_1.Object.Nm_Filial[1] 	= ivo_Filial.Nm_Fantasia
Else
	dw_1.Object.Nm_Filial[1]   	= ""
	dw_1.Object.Cd_Filial[1] 	= lvl_Cd_Filial
End If
end subroutine

public subroutine wf_localiza_produto ();String lvs_Produto

Long lvl_Cd_Produto

lvs_Produto = dw_1.GetText()

SetNull(lvl_Cd_Produto)

ivo_Produto.of_Localiza_Produto(lvs_Produto)

If ivo_Produto.Localizado Then
	dw_1.Object.Cd_Produto	[1] 	= ivo_Produto.Cd_Produto
	dw_1.Object.Nm_Produto[1] 	= ivo_Produto.De_Produto
Else
	dw_1.Object.Nm_Produto[1]   	= ""
	dw_1.Object.Cd_Produto[1] 	= lvl_Cd_Produto
End If
end subroutine

on w_ge314_relatorio_venda_convenio.create
call super::create
end on

on w_ge314_relatorio_venda_convenio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Convenio)
Destroy(ivo_Conveniado)
Destroy(ivo_Filial)
Destroy(ivo_Produto)

end event

event ue_postopen;call super::ue_postopen;This.ivm_Menu.ivb_Permite_Imprimir = True

ivo_Convenio   		= Create uo_Convenio
ivo_Conveniado 	= Create uo_Conveniado
ivo_Filial				= Create uo_Filial
ivo_Produto			= Create uo_Produto

dw_1.Object.Dt_Inicio		[1] = Today()
dw_1.Object.Dt_Termino	[1] = Today()

end event

event ue_preprint;call super::ue_preprint;String lvs_Periodo

Date   lvdt_Inicio, &
       lvdt_Termino

lvdt_Inicio  		= dw_1.Object.Dt_Inicio[1]
lvdt_Termino 	= dw_1.Object.Dt_Termino[1]

lvs_Periodo = String(lvdt_Inicio,  "dd/mm/yyyy") + " $$HEX1$$e000$$ENDHEX$$ " + &
				  String(lvdt_Termino, "dd/mm/yyyy")

dw_3.Object.Periodo.Text = lvs_Periodo

Return AncestorReturnValue
end event

event ue_saveas;dw_3.Event ue_SaveAs()



end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge314_relatorio_venda_convenio
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge314_relatorio_venda_convenio
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge314_relatorio_venda_convenio
integer x = 14
integer y = 340
integer width = 4197
integer height = 1396
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge314_relatorio_venda_convenio
integer x = 14
integer y = 0
integer width = 3387
integer height = 332
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge314_relatorio_venda_convenio
integer x = 41
integer y = 56
integer width = 3342
integer height = 268
integer taborder = 40
string dataobject = "dw_ge314_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;String lvs_Nulo

Long lvl_Nulo

SetNull(lvl_Nulo)
SetNull(lvs_Nulo)
			
Choose Case dwo.Name		
	Case "nm_fantasia"
		If Trim(Data) <> "" Then
			If Data <> ivo_Convenio.Nm_Fantasia Then
				Return 1
			End If
		Else
			This.Object.Cd_Convenio[1]   		= lvl_Nulo
			This.Object.Cd_Conveniado[1] 		= lvs_Nulo
			This.Object.Nm_Conveniado[1] 	= ""
			
			ivo_Convenio.Cd_Convenio			= lvl_Nulo
			ivo_Convenio.Nm_Fantasia     		= ""
			ivo_Conveniado.Cd_Conveniado	= ""
			ivo_Conveniado.Nm_Conveniado 	= ""			
		End If
	Case "nm_conveniado"
		If Trim(Data) <> "" Then
			If Data <> ivo_Conveniado.Nm_Conveniado Then
				Return 1
			End If
		Else
			This.Object.Cd_Conveniado[1] 		= lvs_Nulo
			This.Object.Nm_Conveniado[1] 	= ""
			
			ivo_Conveniado.Cd_Conveniado 	= ""
			ivo_Conveniado.Nm_Conveniado 	= ""			
		End If	
		
	Case "nm_filial"
		If Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			This.Object.Cd_Filial[1]	= lvl_Nulo
			This.Object.Nm_Filial[1] 	= ""
			
			ivo_Filial.Cd_Filial			= lvl_Nulo
			ivo_Filial.Nm_Fantasia 	= ""			
		End If		
		
	Case "nm_produto"
		If Trim(Data) <> "" Then
			If Data <> ivo_Produto.De_Produto Then
				Return 1
			End If
		Else
			This.Object.Cd_Produto[1]	= lvl_Nulo
			This.Object.Nm_Produto[1] 	= ""
			
			ivo_Produto.Cd_Produto	= lvl_Nulo
			ivo_Produto.De_Produto 	= ""			
		End If		
		
End Choose

end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Convenio) Then
	This.Object.Nm_Fantasia[1] = ivo_Convenio.Nm_Fantasia
End If

If IsValid(ivo_Conveniado) Then
	This.Object.Nm_Conveniado[1] = ivo_Conveniado.Nm_Conveniado
End If

If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If

If IsValid(ivo_Produto) Then
	This.Object.Nm_Produto[1] = ivo_Produto.De_Produto
End If

end event

event dw_1::ue_key;String lvs_Coluna, &
       lvs_Nulo

Long lvl_Nulo

SetNull(lvl_Nulo)
SetNull(lvs_Nulo)

If Key = KeyEnter! Then
	lvs_Coluna = This.GetColumnName()
	
	Choose Case lvs_Coluna
		Case "nm_fantasia"
			wf_Localiza_Convenio()
			This.Object.Cd_Conveniado[1] = lvs_Nulo
			This.Object.Nm_Conveniado[1] = ""
			
			ivo_Conveniado.Nm_Conveniado = ""	
		Case "nm_conveniado"
			wf_Localiza_Conveniado()

		Case "nm_filial"
			wf_Localiza_Filial()

		Case "nm_produto"
			wf_Localiza_Produto()			
	End Choose	
End If

			

			
			
end event

event dw_1::ue_addrow;call super::ue_addrow;This.SetTransObject(SqlCa)
//This.of_Populate_DDDW("cd_condicao_convenio")*/

Return AncestorReturnValue



end event

event dw_1::editchanged;call super::editchanged;String lvs_Nulo

Long   lvl_Nulo

SetNull(lvl_Nulo)
SetNull(lvs_Nulo)
			
Choose Case dwo.Name		
	Case "nm_fantasia"
	  This.Object.Cd_Convenio[1]   = lvl_Nulo
	  This.Object.Cd_Conveniado[1] = lvs_Nulo
	  This.Object.Nm_Conveniado[1] = ""		
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge314_relatorio_venda_convenio
integer x = 27
integer y = 412
integer width = 4155
integer height = 1308
integer taborder = 50
string dataobject = "dw_ge314_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long 	lvl_Filial   ,&
     	lvl_Convenio ,&
	  	lvl_Condicao,&
		lvl_Lote_Inicio,&
		lvl_Lote_Termino, &
		lvl_Produto

String lvs_Conveniado, &
		 lvs_Group, &
		 lvs_DW_Consulta, &
		 lvs_DW_Relatorio

Date 	lvdt_Inicio, &
     	lvdt_Termino

dw_1.AcceptText()

lvs_DW_Relatorio = "dw_ge314_relatorio"

If lvs_DW_Relatorio <> dw_3.DataObject Then
	dw_3.of_ChangeDataObject(lvs_DW_Relatorio)
	This.ShareData(dw_3)
End If	

lvl_Convenio   		= dw_1.Object.Cd_Convenio	[1]
lvdt_Inicio    		= dw_1.Object.Dt_Inicio			[1]
lvdt_Termino   		= dw_1.Object.Dt_Termino		[1]
lvs_Conveniado 	= dw_1.Object.Cd_Conveniado	[1]
lvl_Lote_Inicio		= dw_1.Object.lote_inicio		[1]
lvl_Lote_Termino	= dw_1.Object.lote_termino		[1]
lvl_Filial				= dw_1.Object.Cd_Filial			[1]
lvl_Produto			= dw_1.Object.Cd_Produto		[1]

If Not IsNull(lvl_Lote_Inicio) And IsNull(lvl_Lote_Termino) Or Not IsNull(lvl_Lote_Termino) And IsNull(lvl_Lote_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Informe corretamente o n$$HEX1$$fa00$$ENDHEX$$mero do lote: Inicial e Final.", Exclamation!)
	dw_1.Event ue_Pos(1,"lote_inicio")
	Return -1
End If

If Not IsNull(lvl_Convenio) Then
	This.of_AppendWhere("nf.cd_convenio = " + String(lvl_Convenio))
Else
	This.of_AppendWhere("nf.cd_convenio > 0")
End If

If Not IsNull(lvl_Filial) or lvl_Filial > 0 Then
	This.of_AppendWhere("nf.cd_filial = " + String(lvl_Filial))
End If

If Not IsNull(lvs_Conveniado) Then
	This.of_AppendWhere("nf.cd_conveniado = '" + lvs_Conveniado + "'")
End If

If Not IsNull(lvl_Produto) or lvl_Produto > 0 Then
	This.of_AppendWhere("pg.cd_produto = " + String(lvl_Produto))
End If

If Not IsNull(lvl_Lote_Inicio) And Not IsNull(lvl_Lote_Termino) Then
	This.Of_AppendWhere("nf.nr_lote_convenio between " + String(lvl_Lote_Inicio) + " and " + String(lvl_Lote_Termino))
Else
	This.of_AppendWhere("nf.dh_movimentacao_caixa between '" + String(lvdt_Inicio,"yyyymmdd") + "'" + &
                    " and '" + String(lvdt_Termino,"yyyymmdd") + "'")
End If
 
This.of_SetRowSelection()

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_Menu.mf_SalvarComo(pl_linhas > 0)

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge314_relatorio_venda_convenio
integer x = 2734
integer y = 1184
integer height = 164
integer taborder = 60
string dataobject = "dw_ge314_relatorio"
end type

