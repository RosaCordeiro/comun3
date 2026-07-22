HA$PBExportHeader$w_ge270_transferencia_almoxarifado_prd.srw
forward
global type w_ge270_transferencia_almoxarifado_prd from dc_w_2tab_consulta_selecao_lista_det
end type
type dw_4 from dc_uo_dw_base within tabpage_1
end type
end forward

global type w_ge270_transferencia_almoxarifado_prd from dc_w_2tab_consulta_selecao_lista_det
string tag = "w_ge270_transferencia_almoxarifado_prd"
integer width = 2523
integer height = 1976
string title = "GE270 - Relat$$HEX1$$f300$$ENDHEX$$rio Transfer$$HEX1$$ea00$$ENDHEX$$ncia Almoxarifado Produto"
boolean resizable = false
long backcolor = 80269524
end type
global w_ge270_transferencia_almoxarifado_prd w_ge270_transferencia_almoxarifado_prd

type variables
uo_filial ivo_filial

uo_centro_custo ivo_centro_custo

uo_usuario ivo_usuario

uo_produto ivo_produto
end variables

on w_ge270_transferencia_almoxarifado_prd.create
int iCurrent
call super::create
end on

on w_ge270_transferencia_almoxarifado_prd.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;Tab_1.TabPage_1.dw_1.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_1.dw_2.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_1.dw_4.of_SetMenu(This.ivm_Menu)

Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Recuperar(True)

Tab_1.TabPage_1.dw_1.Object.dt_inicio		[1] = gvo_Parametro.of_DH_Movimentacao()
Tab_1.TabPage_1.dw_1.Object.dt_termino	[1] = gvo_Parametro.of_DH_Movimentacao()

ivo_Filial 		 		= Create uo_Filial
ivo_Centro_Custo	= Create uo_Centro_Custo
ivo_Produto		 	= Create uo_Produto
ivo_usuario			= Create uo_Usuario

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Centro_Custo)
Destroy(ivo_Usuario)
Destroy(ivo_Produto)
end event

event ue_printimmediate;call super::ue_printimmediate;Tab_1.TabPage_1.dw_4.Event ue_PrintImmediate()
end event

event ue_saveas;Tab_1.TabPage_1.dw_4.Event ue_SaveAs()
end event

event ue_print;call super::ue_print;Tab_1.TabPage_1.dw_4.Event ue_Print()
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge270_transferencia_almoxarifado_prd
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge270_transferencia_almoxarifado_prd
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge270_transferencia_almoxarifado_prd
integer width = 2487
integer height = 1800
long backcolor = 80269524
end type

event tab_1::selectionchanged;// OverRide
If NewIndex = 2 Then
	If This.TabPage_1.dw_2.GetRow() > 0 Then
		This.TabPage_2.dw_3.Event ue_Retrieve()
		This.TabPage_2.gb_3.text = This.TabPage_1.dw_2.Object.descricao[This.TabPage_1.dw_2.GetRow()]+" ("+&
		                            	String(This.TabPage_1.dw_2.Object.cd_produto[This.TabPage_1.dw_2.GetRow()])+")"
		This.TabPage_2.dw_3.SetFocus()
											 
		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para ver os detalhes.", StopSign!)
		Return 1
	End If
Else
	This.TabPage_1.dw_2.SetFocus()
End If
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 2450
integer height = 1684
dw_4 dw_4
end type

on tabpage_1.create
this.dw_4=create dw_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_4)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 516
integer width = 2400
integer height = 1152
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 1819
integer height = 484
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 55
integer y = 80
integer width = 1755
integer height = 396
string dataobject = "dw_ge270_selecao"
end type

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

lvs_Coluna = This.GetColumnName()

If Key = KeyEnter! Then
	
	If lvs_Coluna = "de_produto" Then
		
		ivo_Produto.of_Localiza_Produto(This.GetText())
		
		If ivo_Produto.Localizado Then
			This.Object.cd_produto[1] = ivo_Produto.cd_produto
			This.Object.de_produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
		End If

	End If 

	If lvs_Coluna = "nm_fantasia" Then
		
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
			This.Object.cd_filial	[1] = ivo_Filial.cd_filial
			This.Object.nm_fantasia	[1] = ivo_Filial.nm_fantasia			
		End If
		
	End If
	
	If lvs_Coluna = "de_centro_custo" Then
		
		ivo_Centro_Custo.ivb_Centro_Custo = True
		
		ivo_Centro_Custo.of_Localiza_Centro_Custo(This.GetText())
		
		If ivo_Centro_Custo.Localizada Then
			This.Object.cd_centro_custo[1] = ivo_Centro_Custo.cd_centro_custo
			This.Object.de_centro_custo[1] = ivo_Centro_Custo.de_centro_custo
		End If
		
	End If
	
	If lvs_Coluna = "nm_requisitante" Then
		
		ivo_Usuario.of_Localiza_Usuario(This.GetText())
		
		If ivo_Usuario.Localizado Then
			This.Object.nr_matricula_requisitante	[1] = ivo_Usuario.nr_matricula
			This.Object.nm_requisitante  			[1] = ivo_Usuario.nm_usuario
		End If
		
	End If
		
End If

end event

event dw_1::editchanged;call super::editchanged;Tab_1.TabPage_1.dw_2.Reset()
end event

event dw_1::itemchanged;call super::itemchanged;Tab_1.TabPage_1.dw_2.Reset()

If dwo.Name = 'nm_fantasia' Then
	If Not IsNull(Data) and Trim(Data) <> '' Then
		If Data <> ivo_Filial.nm_fantasia Then
			Return 1
		End If
	Else
		ivo_Filial.of_Inicializa()
		
		This.Object.cd_filial	[1] = ivo_Filial.cd_filial
		This.Object.nm_fantasia	[1] = ivo_Filial.nm_fantasia
	End If
End If

If dwo.Name = 'de_centro_custo' Then
	If Not IsNull(Data) and Trim(Data) <> '' Then
		If Data <> ivo_Centro_Custo.de_centro_custo Then
			Return 1
		End If
	Else
		ivo_Centro_Custo.of_Inicializa()
		
		This.Object.cd_centro_custo	[1] = ivo_Centro_Custo.cd_centro_custo
		This.Object.de_centro_custo	[1] = ivo_Centro_Custo.de_centro_custo
	End If
End If

If dwo.Name = 'de_produto' Then
	If Not IsNull(Data) and Trim(Data) <> '' Then
		If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
			Return 1
		End If
	Else
		ivo_Produto.of_Inicializa()
		
		This.Object.cd_produto[1] = ivo_Produto.cd_produto
		This.Object.de_produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
	End If
End If

If dwo.Name = 'nm_requisitante' Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Usuario.nm_usuario Then
			Return 1
		End If
	Else
		ivo_Usuario.of_Inicializa()
		
		This.Object.nr_matricula_requisitante	[1] = ivo_Usuario.nr_matricula
		This.Object.nm_requisitante				[1] = ivo_Usuario.nm_usuario
	End If
End If



end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Cd_Filial	[1] = ivo_Filial.Cd_Filial
	This.Object.Nm_Fantasia	[1] = ivo_Filial.nm_fantasia
End If

If IsValid(ivo_Centro_Custo) Then
	This.Object.cd_centro_custo	[1] = ivo_Centro_Custo.cd_centro_custo
	This.Object.de_centro_custo	[1] = ivo_Centro_Custo.de_centro_custo
End If

If IsValid(ivo_Usuario) Then
	This.Object.nr_matricula_requisitante	[1] = ivo_Usuario.nr_matricula
	This.Object.nm_requisitante  			[1] = ivo_Usuario.nm_usuario
End If

If IsValid(ivo_Produto) Then
	This.Object.cd_produto[1] = ivo_Produto.cd_produto
	This.Object.de_produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer y = 588
integer width = 2341
integer height = 1048
string dataobject = "dw_ge270_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;// OverRide
DateTime lvdt_Inicio  ,&
		   lvdt_Termino
		 
Long lvl_Filial       ,&
	  lvl_Centro_Custo, lvl_de_produto
	 
String lvs_Requisitante

dw_1.AcceptText()

lvdt_Inicio			= dw_1.Object.dt_inicio							[1]
lvdt_Termino		= dw_1.Object.dt_termino						[1]
lvl_Filial				= dw_1.Object.cd_filial							[1]
lvl_Centro_Custo	= dw_1.Object.cd_centro_custo				[1]
lvl_de_produto		= dw_1.Object.cd_produto						[1]
lvs_Requisitante	= dw_1.Object.nr_matricula_requisitante	[1]

This.Reset()

This.of_RestoreOriginalSQL()

If IsNull(lvdt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdt_Termino) or lvdt_Termino<lvdt_inicio Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If Not IsNull(lvl_Filial) and Not IsNull(lvl_Centro_Custo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial ou departamento.")
	dw_1.Event ue_Pos(1, "cd_filial")
	Return -1
End If
	
If Not IsNull(lvl_Filial) Then
	This.of_AppendWhere_SubQuery("n.cd_filial = " + String(lvl_Filial),1)
	This.of_AppendWhere_SubQuery("n.cd_filial_destino = " + String(lvl_Filial),2)
End If

If Not IsNull(lvl_Centro_Custo) Then
	This.of_AppendWhere_SubQuery("n.cd_centro_custo = " + String(lvl_Centro_Custo),1)
	This.of_AppendWhere_SubQuery("n.cd_centro_custo = " + String(lvl_Centro_Custo),2)
End If

If Not IsNull(lvl_de_produto) Then
	This.of_AppendWhere_SubQuery("i.cd_produto = " + String(lvl_de_produto),1)
	This.of_AppendWhere_SubQuery("i.cd_produto = " + String(lvl_de_produto),2)
End If

If Not IsNull(lvs_Requisitante) and (lvs_Requisitante <> "") Then
	This.of_appendwhere_subquery("nr_matricula_requisitante ='" + String(lvs_Requisitante)+"'", 1)
	This.of_appendwhere_subquery("d.nr_matricula_cadastramento ='" + String(lvs_Requisitante)+"'", 2)
End If

//messagebox("", String(This.Object.Datawindow.Table.Select))

Return This.Retrieve(lvdt_inicio, lvdt_termino)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivo_Controle_Menu.of_SalvarComo(pl_Linhas > 0)
This.ivo_Controle_Menu.of_Imprimir(pl_Linhas > 0)

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;This.ivo_Controle_Menu.of_SalvarComo(False)
This.ivo_Controle_Menu.of_Imprimir(False)
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 2450
integer height = 1684
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer y = 16
integer width = 2400
integer height = 1484
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer width = 2336
integer height = 1404
string dataobject = "dw_ge270_detalhe_lista"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_3::ue_recuperar;//OverRide

DateTime	lvdt_Inicio,&
				lvdt_Termino
		 
Long	lvl_Filial,&
		lvl_Centro_Custo ,&
		lvl_Produto
	  
String	lvs_Requisitante,&
		lvs_SQL


Tab_1.TabPage_1.dw_1.AcceptText()

lvdt_Inicio			= Tab_1.TabPage_1.dw_1.Object.dt_inicio							[1]
lvdt_Termino		= Tab_1.TabPage_1.dw_1.Object.dt_termino						[1]
lvl_Filial				= Tab_1.TabPage_1.dw_1.Object.cd_filial							[1]
lvl_Centro_Custo	= Tab_1.TabPage_1.dw_1.Object.cd_centro_custo				[1]
lvs_Requisitante	= Tab_1.TabPage_1.dw_1.Object.nr_matricula_requisitante	[1]

lvl_Produto			= Tab_1.TabPage_1.dw_2.Object.cd_produto [Tab_1.TabPage_1.dw_2.GetRow()]

If Not IsNull(lvl_Filial) Then
	This.of_AppendWhere_SubQuery("na.cd_filial = " + String(lvl_Filial),1)
	This.of_AppendWhere_SubQuery("na.cd_filial_destino = " + String(lvl_Filial),2)
End If

If Not IsNull(lvl_Centro_Custo) Then
	This.of_AppendWhere_SubQuery("na.cd_centro_custo = " + String(lvl_Centro_Custo),1)
	This.of_AppendWhere_SubQuery("na.cd_centro_custo = " + String(lvl_Centro_Custo),2)
End If

If Not IsNull(lvs_Requisitante) and (lvs_Requisitante <> "")  Then
	This.of_appendwhere_subquery("na.nr_matricula_requisitante ='" + String(lvs_Requisitante)+"'", 1)
	This.of_appendwhere_subquery("d.nr_matricula_cadastramento ='" + String(lvs_Requisitante)+"'", 2)
End If

lvs_SQL = This.GetSQLSelect()

Return This.Retrieve(lvdt_Inicio, lvdt_Termino, lvl_Produto)
end event

event dw_3::constructor;call super::constructor;This.Of_SetRowSelection()
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;This.ivo_controle_menu.of_Imprimir(False)
This.ivo_controle_menu.of_SalvarComo(False)

Return AncestorReturnValue
end event

type dw_4 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 1952
integer y = 212
integer width = 329
integer height = 244
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge270_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;DateTime 	lvdt_Inicio, &
				lvdt_Termino

Long	lvl_Filial, &
		lvl_Centro_Custo, &
		lvl_de_produto

String	lvs_Requisitante,&
		lvs_DW

Tab_1.TabPage_1.dw_1.AcceptText()

lvdt_Inicio			= Tab_1.TabPage_1.dw_1.Object.dt_inicio							[1]
lvdt_Termino		= Tab_1.TabPage_1.dw_1.Object.dt_termino						[1]
lvl_Filial				= Tab_1.TabPage_1.dw_1.Object.cd_filial							[1]
lvl_Centro_Custo	= Tab_1.TabPage_1.dw_1.Object.cd_centro_custo				[1]
lvl_de_produto		= Tab_1.TabPage_1.dw_1.Object.cd_produto						[1]
lvs_Requisitante	= Tab_1.TabPage_1.dw_1.Object.nr_matricula_requisitante	[1]

If IsNull(lvdt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdt_Termino) or lvdt_Termino<lvdt_inicio Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

Tab_1.TabPage_1.dw_4.Reset()

Tab_1.TabPage_1.dw_4.of_RestoreOriginalSQL()

If Not IsNull(lvl_Filial) Then
	Tab_1.TabPage_1.dw_4.of_AppendWhere_Subquery("na.cd_filial = " + String(lvl_Filial),1)
	Tab_1.TabPage_1.dw_4.of_AppendWhere_Subquery("na.cd_filial_destino = " + String(lvl_Filial),2)
End If

If Not IsNull(lvl_Centro_Custo) Then
	Tab_1.TabPage_1.dw_4.of_AppendWhere_Subquery("na.cd_centro_custo = " + String(lvl_Centro_Custo),1)
	Tab_1.TabPage_1.dw_4.of_AppendWhere_Subquery("na.cd_centro_custo = " + String(lvl_Centro_Custo),2)
End If

If Not IsNull(lvl_de_produto) Then
	Tab_1.TabPage_1.dw_4.of_AppendWhere_Subquery("it.cd_produto = " + String(lvl_de_produto),1)
	Tab_1.TabPage_1.dw_4.of_AppendWhere_Subquery("it.cd_produto = " + String(lvl_de_produto),2)
End If

If Not IsNull(lvs_Requisitante) and (lvs_Requisitante <> "") Then
	This.of_appendwhere_subquery("nr_matricula_requisitante ='" + String(lvs_Requisitante)+"'", 1)
	This.of_appendwhere_subquery("d.nr_matricula_cadastramento ='" + String(lvs_Requisitante)+"'", 2)
End If

This.Object.st_periodo.Text = String(Tab_1.TabPage_1.dw_1.Object.dt_inicio[1],"dd/mm/yyyy") +&
							  ' $$HEX1$$e000$$ENDHEX$$ ' + String(Tab_1.TabPage_1.dw_1.Object.dt_termino[1],"dd/mm/yyyy")

Return Tab_1.TabPage_1.dw_4.Retrieve(lvdt_Inicio, lvdt_Termino)
end event

event ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()

dw_2.ivm_menu.mf_SalvarComo(dw_2.RowCount() > 0)
end event

