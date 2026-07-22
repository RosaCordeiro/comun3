HA$PBExportHeader$w_ge282_vendas_convenio.srw
forward
global type w_ge282_vendas_convenio from dc_w_2tab_consulta_selecao_lista_2det
end type
end forward

global type w_ge282_vendas_convenio from dc_w_2tab_consulta_selecao_lista_2det
integer width = 3410
integer height = 1788
string title = "GE282 - Consulta Vendas Conv$$HEX1$$ea00$$ENDHEX$$nio"
end type
global w_ge282_vendas_convenio w_ge282_vendas_convenio

type variables
uo_Convenio 	ivo_Convenio
uo_Conveniado	ivo_Conveniado
uo_Filial			ivo_Filial

dc_uo_ds_base ivds_comparativo

String ivs_Agrupamento
String ivs_Conveniado

Date ivdt_Inicio
Date ivdt_Fim

Long ivl_Convenio
Long ivl_Filial
end variables

on w_ge282_vendas_convenio.create
call super::create
end on

on w_ge282_vendas_convenio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;ivds_comparativo = Create dc_uo_ds_base
ivds_comparativo.of_changedataobject('ds_ge282_venda_filial')
ivs_Agrupamento = 'F'

ivo_Convenio	= Create uo_Convenio
ivo_Conveniado	= Create uo_Conveniado
ivo_Filial			= Create uo_Filial
end event

event close;call super::close;Destroy(ivds_comparativo)
Destroy(ivo_Convenio)
Destroy(ivo_Conveniado)
Destroy(ivo_Filial)
end event

event ue_postopen;call super::ue_postopen;Tab_1.Tabpage_1.dw_1.Object.dt_inicio	[1] = RelativeDate(Today(),-1)
Tab_1.Tabpage_1.dw_1.Object.dt_fim	[1] = RelativeDate(Today(),-1)
end event

type tab_1 from dc_w_2tab_consulta_selecao_lista_2det`tab_1 within w_ge282_vendas_convenio
integer width = 3333
integer height = 1576
end type

event tab_1::selectionchanged;//override
end event

event tab_1::selectionchanging;call super::selectionchanging;If NewIndex = 2 Then
	Choose Case ivs_Agrupamento
		Case 'F' 
			Tabpage_2.gb_3.Text = 'Conv$$HEX1$$ea00$$ENDHEX$$nios - Filial ('+String(ivl_Filial,'0000')+')'
			Tabpage_2.gb_4.Text = 'Conveniados'
		Case 'C'
			Tabpage_2.gb_3.Text = 'Notas - Conveniado ('+ivs_Conveniado+')'
			Tabpage_2.gb_4.Text = 'Itens Nota'
		Case 'V'
			Tabpage_2.gb_3.Text = 'Filiais - Conv$$HEX1$$ea00$$ENDHEX$$nio ('+String(ivl_Convenio)+')'
			Tabpage_2.gb_4.Text = 'Conveniado'
	End Choose
	Tabpage_2.dw_3.Modify("DataWindow.Summary.Height.AutoSize='No'")
	Tabpage_2.dw_4.Modify("DataWindow.Summary.Height.AutoSize='No'")
	Tabpage_2.dw_3.Modify("DataWindow.Summary.Height='0'")
	Tabpage_2.dw_4.Modify("DataWindow.Summary.Height='0'")
	Tabpage_2.dw_3.SetFocus()
Else
	Tabpage_1.dw_2.SetFocus()
End If

Return AncestorReturnValue
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_1 within tab_1
integer width = 3296
integer height = 1460
end type

type gb_2 from dc_w_2tab_consulta_selecao_lista_2det`gb_2 within tabpage_1
integer width = 3246
integer height = 1044
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_2det`gb_1 within tabpage_1
integer width = 3241
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_2det`dw_1 within tabpage_1
integer width = 3159
string dataobject = "dw_ge282_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case Dwo.Name
	Case 'id_agrupamento'
		If Data <> ivs_Agrupamento Then
			Choose Case Data
				Case 'F'
					Parent.dw_2.Of_ChangeDataObject('dw_ge282_lista_filial')
					ivds_comparativo.of_changedataobject('ds_ge282_venda_filial')
					Tab_1.Tabpage_2.dw_3.of_ChangeDataObject('dw_ge282_lista_convenio')
					Tab_1.Tabpage_2.dw_4.of_ChangeDataObject('dw_ge282_lista_conveniado')
				Case 'C'
					Parent.dw_2.Of_ChangeDataObject('dw_ge282_lista_conveniado')
					Tab_1.Tabpage_2.dw_3.of_ChangeDataObject('dw_ge282_lista_nf')
					Tab_1.Tabpage_2.dw_4.of_ChangeDataObject('dw_ge282_lista_item_nf')
				Case 'V'
					Parent.dw_2.Of_ChangeDataObject('dw_ge282_lista_convenio')
					Tab_1.Tabpage_2.dw_3.of_ChangeDataObject('dw_ge282_lista_filial')
					Tab_1.Tabpage_2.dw_4.of_ChangeDataObject('dw_ge282_lista_conveniado')
			End Choose
		End If
		ivs_Agrupamento = Data
		Parent.dw_2.of_SetRowSelection( )
		Tab_1.Tabpage_2.dw_3.of_SetRowSelection( )
		Tab_1.Tabpage_2.dw_4.of_SetRowSelection( )
End Choose

Parent.dw_2.Event ue_Reset()
end event

event dw_1::editchanged;call super::editchanged;Parent.dw_2.Event ue_Reset()

Choose Case Dwo.Name
	Case "nm_filial"
		If Data <> "" Then
			Return 1
		Else			
			ivo_Filial.Of_Inicializa()
			
			This.Object.Cd_Filial[1] 	= ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] 	= ivo_Filial.Nm_Fantasia				
		End If
		
		
	Case "nm_convenio"
		If Data <> "" Then
			Return 1
		Else			
			ivo_Convenio.Of_Inicializa()
			
			This.Object.Cd_Convenio		[1] = ivo_Convenio.Cd_convenio
			This.Object.Nm_Convenio	[1] = ivo_Convenio.Nm_fantasia				
		End If
		
	Case "nm_conveniado"
		If Data <> "" Then
			Return 1
		Else			
			ivo_Conveniado.Of_Inicializa()
			
			This.Object.Cd_Conveniado	[1] = ivo_Conveniado.Cd_conveniado
			This.Object.Nm_Conveniado	[1] = ivo_Conveniado.nm_conveniado			
		End If
End Choose
end event

event dw_1::ue_key;call super::ue_key;Long lvl_Convenio

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_filial" 	
			ivo_Filial.of_Localiza_Filial( This.GetText() )
			
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial	[1] = ivo_Filial.Cd_Filial
				This.Object.Nm_Filial	[1] = ivo_Filial.Nm_Fantasia
			End If
		Case "nm_convenio"
			ivo_Convenio.of_localiza_convenio(This.GetText())
			
			If ivo_Convenio.Localizado Then
				This.Object.Cd_Convenio		[1] = ivo_Convenio.Cd_Convenio
				This.Object.Nm_Convenio	[1] = ivo_Convenio.nm_fantasia
			End If
		Case "nm_conveniado"
			This.AcceptText( )
			lvl_Convenio = This.Object.cd_convenio [1]
			
			If lvl_Convenio > 0 Then
				ivo_Conveniado.of_Localiza_Conveniado(lvl_Convenio, This.GetText())
				
				If ivo_Conveniado.Localizado Then
					This.Object.cd_conveniado	[1] = ivo_Conveniado.Cd_Conveniado
					This.Object.nm_conveniado	[1] = ivo_Conveniado.Nm_Conveniado
				End If
			Else
				ivo_Conveniado.of_inicializa( )
				This.Object.cd_conveniado	[1] = ivo_Conveniado.Cd_Conveniado
				This.Object.nm_conveniado	[1] = ivo_Conveniado.Nm_Conveniado
				
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Selecione primeiro o conv$$HEX1$$ea00$$ENDHEX$$nio!')
				This.Event ue_Pos(1,'nm_convenio')
				Return -1
			End If
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Convenio) Then
	This.Object.Nm_Convenio[1] = ivo_Convenio.nm_fantasia
End If

If IsValid(ivo_Conveniado) Then
	This.Object.Nm_Conveniado[1] = ivo_Conveniado.nm_conveniado
End If

If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::ue_saveas;dw_2.Event ue_SaveAs()
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_2det`dw_2 within tabpage_1
integer width = 3163
integer height = 932
string dataobject = "dw_ge282_lista_filial"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Convenio
Long lvl_Filial

String lvs_Conveniado

Parent.Dw_1.Accepttext( )

lvl_Convenio		= Parent.Dw_1.Object.cd_convenio 	[1]
lvs_Conveniado	= Parent.Dw_1.Object.cd_conveniado	[1]
lvl_Filial			= Parent.Dw_1.Object.cd_filial			[1]

If  Not(IsNull(lvl_Convenio)) and (lvl_Convenio > 0) Then
	This.Of_AppendWhere("n.cd_convenio="+String(lvl_Convenio))
ElseIf ivs_Agrupamento = 'C' Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Para agrupamento por conveniado $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar um conv$$HEX1$$ea00$$ENDHEX$$nio!',Exclamation!)
	dw_1.Event ue_Pos(1,'nm_convenio')
	Return -1
End If

If (Not(IsNull(lvs_Conveniado))) and (lvs_Conveniado<>"") Then
	This.Of_AppendWhere("n.cd_conveniado='"+lvs_Conveniado+"'")
End If

If  Not(IsNull(lvl_Filial)) and (lvl_Filial > 0) Then
	This.Of_AppendWhere('n.cd_filial='+String(lvl_Filial))
End If

Return AncestorReturnValue

end event

event dw_2::ue_recuperar;//override
Long lvl_Convenio

Parent.Dw_1.Accepttext( )

ivl_Convenio	= Parent.Dw_1.Object.cd_convenio 	[1]
ivdt_Inicio	= Parent.Dw_1.Object.dt_inicio 		[1]
ivdt_Fim		= Parent.Dw_1.Object.dt_fim	 		[1]

Return This.Retrieve(ivdt_Inicio,ivdt_Fim)


end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Date lvdt_Inicio
Date lvdt_Fim

Long lvl_Convenio
Long lvl_Filial
Long lvl_Linha
Long lvl_Find
Long lvl_Qtde
Long lvl_Qt_Conv

Decimal{2} lvdc_Valor
Decimal{2} lvdc_Convenio

String lvs_Conveniado

ivds_comparativo.of_RestoreSQLOriginal( )
Parent.Dw_1.Accepttext( )

lvl_Convenio		= Parent.Dw_1.Object.cd_convenio 	[1]
lvdt_Inicio		= Parent.Dw_1.Object.dt_inicio 		[1]
lvdt_Fim			= Parent.Dw_1.Object.dt_fim	 		[1]
lvs_Conveniado	= Parent.Dw_1.Object.cd_conveniado	[1]
lvl_Filial			= Parent.Dw_1.Object.cd_filial			[1]

If pl_linhas > 0 Then
	If ivs_Agrupamento = 'F' Then
		ivds_comparativo.Retrieve(lvdt_Inicio,lvdt_Fim)
	Else
		lvdc_Valor	= This.Object.vl_convenio_total	[1]
		lvl_Qtde		= This.Object.qt_convenio_total	[1]
	End If
	
	This.SetRedraw(False)
	
	Open(w_aguarde)
	w_aguarde.uo_Progress.of_SetMax(pl_linhas)

	For lvl_Linha = 1 To pl_linhas		
		w_aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		
		If ivs_Agrupamento = 'F' Then
			lvl_Filial 	= This.Object.cd_filial [lvl_Linha]
			lvl_Find	= ivds_comparativo.Find('cd_filial='+String(lvl_Filial),1,ivds_comparativo.RowCount())
			If lvl_Find > 0 Then
				lvdc_Valor	= ivds_comparativo.Object.valor	[lvl_Find]
				lvl_Qtde		= ivds_comparativo.Object.qtde	[lvl_Find]				
			End If
		End If
		
		lvl_Qt_Conv		= This.Object.qt_convenio	[lvl_linha]
		lvdc_Convenio	= This.Object.vl_convenio	[lvl_linha]
		
		This.Object.qt_venda				[lvl_linha] = lvl_Qtde
		This.Object.vl_venda_liquida	[lvl_linha] = lvdc_Valor
		This.Object.pc_qtde				[lvl_linha] = (lvl_Qt_Conv / lvl_Qtde ) * 100
		This.Object.pc_valor				[lvl_linha] = (lvdc_Convenio / lvdc_Valor) * 100
	Next
	
	This.Sort()
	This.Event RowFocusChanged(1)
	Close(w_aguarde)
	This.SetRedraw(True)
End If

ivm_menu.mf_SalvarComo(pl_Linhas > 0)

Return AncestorReturnValue
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	Choose Case ivs_Agrupamento
		Case 'F'
			ivl_Filial 			= This.Object.cd_filial [CurrentRow]
			ivs_Conveniado	= ''
		Case 'C'
			ivs_Conveniado	= This.Object.cd_conveniado [CurrentRow]
			SetNull(ivl_Filial)
		Case 'V'
			ivl_Convenio		= This.Object.cd_convenio [CurrentRow]
	End Choose
End if
end event

event dw_2::clicked;call super::clicked;If This.RowCount() > 0 and ivb_Ordena_Colunas and Row = 0 Then
	This.Event RowFocusChanged(1)
End If
end event

event dw_2::ue_reset;call super::ue_reset;ivm_menu.mf_SalvarComo(False)
end event

event dw_2::losefocus;call super::losefocus;ivm_menu.mf_SalvarComo(False)
end event

event dw_2::getfocus;call super::getfocus;This.ivm_menu.mf_SalvarComo(This.RowCount()>0)
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_2 within tab_1
integer width = 3296
integer height = 1460
end type

type gb_4 from dc_w_2tab_consulta_selecao_lista_2det`gb_4 within tabpage_2
integer y = 640
integer width = 3241
integer height = 768
integer weight = 700
string facename = "Verdana"
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_2det`gb_3 within tabpage_2
integer width = 3241
integer height = 616
integer weight = 700
string facename = "Verdana"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_2det`dw_3 within tabpage_2
integer x = 46
integer width = 3209
integer height = 516
string dataobject = "dw_ge282_lista_convenio"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_3::ue_recuperar;//override
Return This.Retrieve(ivdt_Inicio,ivdt_Fim)
end event

event dw_3::ue_preretrieve;call super::ue_preretrieve;Long lvl_Convenio
Long lvl_Filial

String lvs_Conveniado

Tab_1.tabpage_1.Dw_1.Accepttext( )

lvs_Conveniado	= Tab_1.tabpage_1.Dw_1.Object.cd_conveniado	[1]
lvl_Convenio		= Tab_1.tabpage_1.Dw_1.Object.cd_convenio		[1]
lvl_Filial			= Tab_1.tabpage_1.Dw_1.Object.cd_filial			[1]

If (Not IsNull(lvs_Conveniado))and(lvs_Conveniado<>'') Then
	This.Of_appendwhere("n.cd_conveniado='"+(lvs_Conveniado)+"'")		
End If

If (Not IsNull(lvl_Filial))and(lvl_Filial > 0) Then
	This.Of_appendwhere('n.cd_filial='+String(lvl_Filial))		
End If

If (Not IsNull(lvl_Convenio))and(lvl_Convenio > 0) Then
	This.Of_appendwhere('n.cd_convenio='+String(lvl_Convenio))		
End If

Choose Case ivs_Agrupamento
	Case 'F'
		This.Of_appendwhere('n.cd_filial='+String(ivl_Filial))	
	Case 'C'
		This.Of_appendwhere("n.cd_conveniado='"+ivs_Conveniado+"'")
	Case 'V'
		This.Of_appendwhere("n.cd_convenio="+String(ivl_Convenio))	
End Choose

Return AncestorReturnValue
end event

event dw_3::rowfocuschanged;call super::rowfocuschanged;Parent.dw_4.Event ue_Retrieve()
end event

event dw_3::ue_sort;call super::ue_sort;This.Event RowFocusChanged(1)
end event

event dw_3::constructor;call super::constructor;This.Of_SetRowSelection( )
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;Long lvl_Linha
Long lvl_Linha_1
Long lvl_Find
Long lvl_Filial
Long lvl_Qtde

Decimal{2} lvdc_Valor

If ivs_Agrupamento <> 'C' Then
	lvl_Linha_1 	= Tab_1.Tabpage_1.dw_2.GetRow()
	
	If ivs_Agrupamento = 'V' Then
		ivds_comparativo.Retrieve(ivdt_Inicio,ivdt_Fim)
	Else
		lvl_Qtde		= Tab_1.Tabpage_1.dw_2.Object.qt_convenio	[lvl_Linha_1]
		lvdc_Valor	= Tab_1.Tabpage_1.dw_2.Object.vl_convenio	[lvl_Linha_1]
	End If
	
	This.SetRedraw(False)
	FOr lvl_Linha = 1 To pl_Linhas
		If ivs_Agrupamento = 'V' Then
			lvl_Filial = This.Object.cd_filial	[lvl_Linha]
			lvl_Find = ivds_comparativo.Find('cd_filial='+String(lvl_Filial),1,ivds_comparativo.RowCount())
			
			lvl_Qtde		= ivds_comparativo.Object.qtde	[lvl_Find]
			lvdc_Valor	= ivds_comparativo.Object.valor	[lvl_Find]
		End If
		
		This.Object.qt_venda				[lvl_Linha] = lvl_Qtde
		This.Object.pc_qtde				[lvl_Linha] = Round(This.Object.qt_convenio [lvl_Linha] / lvl_Qtde,4) * 100
		This.Object.vl_venda_liquida	[lvl_Linha] = lvdc_Valor	
		This.Object.pc_valor				[lvl_Linha] = Round(This.Object.vl_convenio [lvl_Linha] / lvdc_Valor,4) * 100
	Next
	This.Sort()
	This.Event RowFocusChanged(1)
	This.SetRedraw(True)	
End If

This.ivm_menu.mf_SalvarComo(This.RowCount()>0)

Return AncestorReturnValue
end event

event dw_3::getfocus;call super::getfocus;This.ivm_menu.mf_SalvarComo(This.RowCount()>0)
end event

event dw_3::losefocus;call super::losefocus;This.ivm_menu.mf_SalvarComo(False)
end event

event dw_3::ue_reset;call super::ue_reset;This.ivm_menu.mf_SalvarComo(False)
end event

type dw_4 from dc_w_2tab_consulta_selecao_lista_2det`dw_4 within tabpage_2
integer x = 50
integer y = 708
integer width = 3186
integer height = 668
string dataobject = "dw_ge282_lista_conveniado"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_4::ue_recuperar;//override
Long lvl_Filial
Long lvl_Nf
Long lvl_Linha
Long lvl_Linhas

String lvs_Especie
String lvs_Serie

Choose Case ivs_Agrupamento
	Case 'F'
		This.Of_appendwhere('n.cd_filial='+String(ivl_Filial))
		lvl_Linhas = This.Retrieve(ivdt_Inicio,ivdt_Fim)
	Case 'C'
		lvl_Linha		= Parent.dw_3.GetRow()
		lvl_Filial		= Parent.dw_3.Object.cd_filial		[lvl_Linha]
		lvl_Nf			= Parent.dw_3.Object.nr_nf			[lvl_Linha]
		lvs_Especie	= Parent.dw_3.Object.de_especie	[lvl_Linha]
		lvs_Serie		= Parent.dw_3.Object.de_serie		[lvl_Linha]
	
		lvl_Linhas = This.Retrieve(lvl_Filial,lvl_Nf,lvs_Serie,lvs_Especie)
	Case 'V'
		This.Of_appendwhere('n.cd_convenio='+String(ivl_Convenio))
		lvl_Linhas = This.Retrieve(ivdt_Inicio,ivdt_Fim)
End Choose

Return lvl_Linhas
end event

event dw_4::ue_preretrieve;call super::ue_preretrieve;Long lvl_Linha

Long lvl_Convenio
Long lvl_Filial

String lvs_Conveniado

If ivs_Agrupamento <> 'C' Then
	Tab_1.tabpage_1.Dw_1.Accepttext( )
	
	lvs_Conveniado	= Tab_1.tabpage_1.Dw_1.Object.cd_conveniado	[1]
	lvl_Convenio		= Tab_1.tabpage_1.Dw_1.Object.cd_convenio		[1]
	lvl_Filial			= Tab_1.tabpage_1.Dw_1.Object.cd_filial			[1]
	
	If (Not IsNull(lvs_Conveniado))and(lvs_Conveniado<>'') Then
		This.Of_appendwhere("n.cd_conveniado='"+(lvs_Conveniado)+"'")		
	End If
	
	If (Not IsNull(lvl_Filial))and(lvl_Filial > 0) Then
		This.Of_appendwhere('n.cd_filial='+String(lvl_Filial))		
	End If
	
	If (Not IsNull(lvl_Convenio))and(lvl_Convenio > 0) Then
		This.Of_appendwhere('n.cd_convenio='+String(lvl_Convenio))		
	End If
	
	lvl_Linha = Parent.dw_3.GetRow()
	
	Choose Case ivs_Agrupamento
		Case 'F'
			This.Of_appendwhere('n.cd_filial='+String(ivl_Filial))	
			
			lvl_Convenio = Parent.dw_3.Object.cd_convenio [lvl_Linha]
			This.Of_AppendWhere("n.cd_convenio="+String(lvl_Convenio))
		Case 'V'
			This.Of_appendwhere("n.cd_convenio="+String(ivl_Convenio))	
			
			lvl_Filial = Parent.dw_3.Object.cd_filial [lvl_Linha]
			This.Of_AppendWhere("n.cd_filial="+String(lvl_Filial))
	End Choose
End If

Return AncestorReturnValue
end event

event dw_4::constructor;call super::constructor;This.Of_SetRowSelection( )
end event

event dw_4::getfocus;call super::getfocus;This.ivm_menu.mf_SalvarComo(This.RowCount()>0)
end event

event dw_4::ue_reset;call super::ue_reset;This.ivm_menu.mf_SalvarComo(False)
end event

event dw_4::losefocus;call super::losefocus;This.ivm_menu.mf_SalvarComo(False)
end event

event dw_4::ue_postretrieve;call super::ue_postretrieve;Long lvl_Linha
Long lvl_Linha_1
Long lvl_Qtde

Decimal{2} lvdc_Valor

If ivs_Agrupamento <> 'C' Then
	lvl_Linha_1 	= dw_3.GetRow()
	lvl_Qtde		= dw_3.Object.qt_convenio	[lvl_Linha_1]
	lvdc_Valor	= dw_3.Object.vl_convenio	[lvl_Linha_1]
	
	This.SetRedraw(False)
	FOr lvl_Linha = 1 To pl_Linhas
		This.Object.qt_venda				[lvl_Linha] = lvl_Qtde
		This.Object.pc_qtde				[lvl_Linha] = Round(This.Object.qt_convenio [lvl_Linha] / lvl_Qtde,4) * 100
		This.Object.vl_venda_liquida	[lvl_Linha] = lvdc_Valor	
		This.Object.pc_valor				[lvl_Linha] = Round(This.Object.vl_convenio [lvl_Linha] / lvdc_Valor,4) * 100
	Next
	This.Sort()
	This.Event RowFocusChanged(1)
	This.SetRedraw(True)	
End If

This.ivm_menu.mf_SalvarComo(This.RowCount()>0)

Return AncestorReturnValue
end event

