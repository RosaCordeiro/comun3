HA$PBExportHeader$w_ge167_relatorio_nf_transf_vencido.srw
forward
global type w_ge167_relatorio_nf_transf_vencido from dc_w_sheet
end type
type tab_1 from tab within w_ge167_relatorio_nf_transf_vencido
end type
type tabpage_1 from userobject within tab_1
end type
type gb_2 from groupbox within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type dw_2 from dc_uo_dw_base within tabpage_1
end type
type dw_4 from dc_uo_dw_base within tabpage_1
end type
type tabpage_1 from userobject within tab_1
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
dw_4 dw_4
end type
type tabpage_2 from userobject within tab_1
end type
type gb_3 from groupbox within tabpage_2
end type
type dw_3 from dc_uo_dw_base within tabpage_2
end type
type dw_5 from dc_uo_dw_base within tabpage_2
end type
type tabpage_2 from userobject within tab_1
gb_3 gb_3
dw_3 dw_3
dw_5 dw_5
end type
type tab_1 from tab within w_ge167_relatorio_nf_transf_vencido
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_ge167_relatorio_nf_transf_vencido from dc_w_sheet
integer width = 2496
integer height = 1840
string title = "GE167 - Relat$$HEX1$$f300$$ENDHEX$$rio de Produtos Vencidos para o Estoque Central"
boolean resizable = false
long backcolor = 80269524
event ue_retrieve ( )
tab_1 tab_1
end type
global w_ge167_relatorio_nf_transf_vencido w_ge167_relatorio_nf_transf_vencido

type variables
uo_fornecedor ivo_fornecedor
uo_produto ivo_produto
uo_filial ivo_filial
end variables

event ue_retrieve;Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
end event

on w_ge167_relatorio_nf_transf_vencido.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_ge167_relatorio_nf_transf_vencido.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event ue_postopen;call super::ue_postopen;Tab_1.TabPage_1.dw_1.Event ue_AddRow()
Tab_1.TabPage_1.dw_1.SetFocus()

Tab_1.TabPage_1.dw_1.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_1.dw_2.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_3.of_SetMenu(This.ivm_Menu)

Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Recuperar(True)
Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Recuperar(True)
Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Imprimir(True)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Imprimir(True)
Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_SalvarComo(True)

This.ivm_Menu.ivb_Permite_Imprimir = True

Tab_1.TabPage_1.dw_1.Object.DT_Inicio [1] = Today()
Tab_1.TabPage_1.dw_1.Object.Dt_Termino[1] = Today()

ivo_Fornecedor = Create uo_Fornecedor
ivo_Filial	   = Create uo_Filial
ivo_Produto	   = Create uo_Produto




end event

event close;call super::close;Destroy(ivo_Fornecedor)


end event

event ue_print;If Tab_1.Selectedtab = 1 Then
	Tab_1.TabPage_1.dw_4.Event ue_Print()
Else
	Tab_1.TabPage_2.dw_5.Event ue_Print()
End If
end event

event ue_printimmediate;call super::ue_printimmediate;If Tab_1.Selectedtab = 1 Then
	Tab_1.TabPage_1.dw_4.Event ue_PrintImmediate()
Else
	Tab_1.TabPage_2.dw_5.Event ue_PrintImmediate()
End If
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge167_relatorio_nf_transf_vencido
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge167_relatorio_nf_transf_vencido
end type

type tab_1 from tab within w_ge167_relatorio_nf_transf_vencido
integer x = 14
integer y = 12
integer width = 2459
integer height = 1664
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 80269524
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanging;SetPointer(HourGlass!)

If NewIndex = 2 Then
	If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
		// das DW's de detalhes
		Tab_1.TabPage_2.dw_3.Event ue_Retrieve()

		// Permite a troca do folder
		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If		

//If NewIndex = 3 Then
//	If Tab_1.TabPage_2.dw_3.GetRow() > 0 Then
//		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
//		// das DW's de detalhes
//		//Tab_1.TabPage_3.dw_6.Event ue_Retrieve()
//
//		// Permite a troca do folder
//		Return 0
//	Else
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um fornecedor para visualizar os produtos.", StopSign!)
//		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
//		Return 1
//	End If
//End If

SetPointer(Arrow!)
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2423
integer height = 1548
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
dw_4 dw_4
end type

on tabpage_1.create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_4=create dw_4
this.Control[]={this.gb_2,&
this.gb_1,&
this.dw_1,&
this.dw_2,&
this.dw_4}
end on

on tabpage_1.destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_4)
end on

type gb_2 from groupbox within tabpage_1
integer x = 14
integer y = 480
integer width = 2386
integer height = 1036
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within tabpage_1
integer x = 14
integer y = 24
integer width = 2222
integer height = 432
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within tabpage_1
integer x = 32
integer y = 88
integer width = 2190
integer height = 336
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge167_selecao"
end type

event ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "de_produto" Then
		ivo_Produto.of_Localiza_Produto(This.GetText())
		
		If ivo_Produto.Localizado Then
			This.Object.cd_produto[1] = ivo_Produto.cd_produto
			This.Object.de_produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
	End If
	
	If This.GetColumnName() = "nm_filial" Then
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
			This.Object.cd_filial[1]  = ivo_Filial.cd_filial
			This.Object.nm_filial[1]  = ivo_Filial.nm_fantasia
		End If
	End If
	
	If This.GetColumnName() = "nm_fornecedor" Then
		ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
		
		If ivo_Fornecedor.Localizado Then
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
	End If
End If
end event

event itemchanged;call super::itemchanged;If dwo.Name = "de_produto" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque Then
			Return 1
		End If
	Else
		ivo_Produto.of_Inicializa()
		
		This.Object.Cd_produto[1] = ivo_Produto.cd_produto
		This.Object.de_produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
	End If
End If

If dwo.Name = "nm_filial" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Filial.nm_fantasia Then
			Return 1
		End If
	Else
		ivo_Filial.of_Inicializa()
		
		This.Object.cd_Filial[1] = ivo_Filial.cd_filial
		This.Object.nm_Filial[1] = ivo_Filial.nm_fantasia
	End If
End If

If dwo.Name = "nm_fornecedor" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Fornecedor.Nm_Razao_Social Then
			Return 1
		End If
	Else
		ivo_Fornecedor.of_Inicializa()
		
		This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
		This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
	End If
End If

end event

event losefocus;call super::losefocus;If IsValid(ivo_Produto) Then
	This.Object.Cd_produto[1] = ivo_Produto.cd_produto
	This.Object.de_produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
End If

If IsValid(ivo_Filial) Then
	This.Object.Cd_Filial[1] = ivo_Filial.cd_filial
	This.Object.Nm_Filial[1] = ivo_Filial.nm_fantasia
End If

If IsValid(ivo_Fornecedor) Then
	This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
	This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
End If


end event

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event editchanged;call super::editchanged;Tab_1.TabPage_1.dw_2.Reset()
end event

type dw_2 from dc_uo_dw_base within tabpage_1
integer x = 41
integer y = 544
integer width = 2331
integer height = 944
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge167_lista_produto"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;// OverRide

Date lvdt_Inicio,&
	 lvdt_Termino
	 
String lvs_Fornecedor
String lvs_Conveniencia

Long lvl_Filial,&
     lvl_Produto
	 
Parent.dw_1.AcceptText()

lvdt_Inicio			= Parent.dw_1.Object.dt_inicio				[1]
lvdt_Termino		= Parent.dw_1.Object.dt_termino			[1]
lvl_Produto			= Parent.dw_1.Object.cd_produto			[1]
lvl_Filial				= Parent.dw_1.Object.cd_filial   	 		[1]
lvs_Fornecedor		= Parent.dw_1.Object.cd_fornecedor		[1]
lvs_Conveniencia	= Parent.dw_1.Object.id_conveniencia	[1]

If IsNull(lvdt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data do in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	Tab_1.TabPage_1.dw_1.SetFocus()
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1	
End If

If IsNull(lvdt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data do t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	Tab_1.TabPage_1.dw_1.SetFocus()
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_termino")
	Return -1	
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data inicial deve ser menor que a do t$$HEX1$$e900$$ENDHEX$$rmino.")
	Tab_1.TabPage_1.dw_1.SetFocus()
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1	
End If

If Not IsNull(lvl_Produto) Then 
	This.of_AppendWhere("i.cd_produto = " + String(lvl_Produto))
End If

If Not IsNull(lvs_Fornecedor) Then
	This.of_AppendWhere("p.cd_fornecedor_usual = '" + lvs_Fornecedor + "'")
End If

If Not IsNull(lvl_Filial) Then
	This.of_AppendWhere("n.cd_filial_origem = " + String(lvl_Filial))
End If

If lvs_Conveniencia = "N" Then
	This.of_AppendWhere("substring(p.cd_subcategoria,1,1)<>'4'")	
End If

Return This.Retrieve(lvdt_Inicio, lvdt_Termino)

end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ScrollToRow(1)
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

Return pl_Linhas
end event

event constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
//lvs_Coluna = {"descricao", "qtde"}
//
//lvs_Nome = {"descricao", "qtde"}
//
//This.of_SetSort(lvs_Coluna, lvs_Nome)
//This.of_SetFilter(lvs_Coluna, lvs_Nome)		

This.of_SetRowSelection()

This.ShareData(Tab_1.TabPage_1.dw_4)

end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

type dw_4 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 2053
integer y = 1216
integer width = 165
integer height = 252
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge167_relatorio_lista_produto"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;String lvs_Inicio,&
	   lvs_Termino,&
	   lvs_Produto,&
	   lvs_Filial,&
	   lvs_Fornecedor
	   
lvs_Inicio			= String(Parent.dw_1.Object.dt_inicio[1], "dd/mm/yyyy")
lvs_Termino		= String(Parent.dw_1.Object.dt_Termino[1], "dd/mm/yyyy")
//lvs_Produto	= Parent.dw_1.Object.de_produto	[1] + " (" + String(Tab_1.TabPage_1.dw_1.Object.cd_produto[1]) + ")"
lvs_Filial     		= Parent.dw_1.Object.nm_filial		[1] + " (" + String(Parent.dw_1.Object.cd_filial[1]) + ")"
lvs_Fornecedor	= Parent.dw_1.Object.nm_fornecedor[1] + " (" + Parent.dw_1.Object.cd_fornecedor[1] + ")"

//If IsNull(Parent.dw_1.Object.cd_produto[1]) Then
//	lvs_Produto = "TODOS"
//End If

If IsNull(Parent.dw_1.Object.cd_filial[1]) Then
	lvs_Filial = "TODAS"
End If

If IsNull(Parent.dw_1.Object.cd_fornecedor[1]) Then
	lvs_Fornecedor = 'TODOS'
End If

This.Object.st_Periodo.Text 	= lvs_Inicio + " $$HEX1$$e000$$ENDHEX$$ " + lvs_Termino
//This.Object.st_Produto.Text 	= lvs_Produto
This.Object.st_Filial.Text  	= lvs_Filial
This.Object.st_Fornecedor.Text  = lvs_Fornecedor

Return AncestorReturnValue
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2423
integer height = 1548
long backcolor = 80269524
string text = "Detalhes"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_3 gb_3
dw_3 dw_3
dw_5 dw_5
end type

on tabpage_2.create
this.gb_3=create gb_3
this.dw_3=create dw_3
this.dw_5=create dw_5
this.Control[]={this.gb_3,&
this.dw_3,&
this.dw_5}
end on

on tabpage_2.destroy
destroy(this.gb_3)
destroy(this.dw_3)
destroy(this.dw_5)
end on

type gb_3 from groupbox within tabpage_2
integer x = 14
integer y = 28
integer width = 2391
integer height = 1508
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Filiais"
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within tabpage_2
integer x = 46
integer y = 88
integer width = 2336
integer height = 1424
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge167_detalhes"
boolean vscrollbar = true
end type

event ue_recuperar;// OverRide

Date lvdt_Inicio,&
	 lvdt_Termino
	 
String lvs_Fornecedor

Long lvl_Filial,&
     lvl_Produto
	 
Tab_1.TabPage_1.dw_1.AcceptText()
Tab_1.TabPage_1.dw_2.AcceptText()

lvdt_Inicio    = Tab_1.TabPage_1.dw_1.Object.dt_inicio    [1]
lvdt_Termino   = Tab_1.TabPage_1.dw_1.Object.dt_termino   [1]
lvl_Filial	   = Tab_1.TabPage_1.dw_1.Object.cd_filial    [1]
lvs_Fornecedor = Tab_1.TabPage_1.dw_1.Object.cd_fornecedor[1]

lvl_Produto	   = Tab_1.TabPage_1.dw_2.Object.cd_produto   [Tab_1.TabPage_1.dw_2.GetRow()]

If Not IsNull(lvs_Fornecedor) Then
	This.of_AppendWhere("p.cd_fornecedor_usual = '" + lvs_Fornecedor + "'")
End If

If Not IsNull(lvl_Filial) Then
	This.of_AppendWhere("n.cd_filial_origem = " + String(lvl_Filial))
End If

Return This.Retrieve(lvdt_Inicio, lvdt_Termino, lvl_Produto)

end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event constructor;call super::constructor;This.ShareData(Tab_1.TabPage_2.dw_5)
end event

type dw_5 from dc_uo_dw_base within tabpage_2
boolean visible = false
integer x = 1829
integer y = 24
integer width = 421
integer height = 324
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge167_relatorio_detalhes"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;Long lvl_Linha

String lvs_Inicio,&
	   lvs_Termino,&
	   lvs_Produto
	   
lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()
	   
lvs_Inicio     = String(Tab_1.TabPage_1.dw_1.Object.dt_inicio[1], "dd/mm/yyyy")
lvs_Termino	= String(Tab_1.TabPage_1.dw_1.Object.dt_Termino[1], "dd/mm/yyyy")
lvs_Produto	= Tab_1.TabPage_1.dw_2.Object.descricao[1] + " (" + String(Tab_1.TabPage_1.dw_2.Object.cd_produto[lvl_Linha]) + ")"

This.Object.st_Periodo.Text	= lvs_Inicio + " $$HEX1$$e000$$ENDHEX$$ " + lvs_Termino
This.Object.st_Produto.Text	= lvs_Produto

Return AncestorReturnValue
end event

