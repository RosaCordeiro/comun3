HA$PBExportHeader$w_ge249_relatorio_falta_distribuidora.srw
forward
global type w_ge249_relatorio_falta_distribuidora from dc_w_sheet
end type
type tab_1 from tab within w_ge249_relatorio_falta_distribuidora
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
type dw_8 from dc_uo_dw_base within tabpage_1
end type
type tabpage_1 from userobject within tab_1
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
dw_8 dw_8
end type
type tabpage_2 from userobject within tab_1
end type
type gb_7 from groupbox within tabpage_2
end type
type gb_4 from groupbox within tabpage_2
end type
type gb_3 from groupbox within tabpage_2
end type
type dw_3 from dc_uo_dw_base within tabpage_2
end type
type dw_4 from dc_uo_dw_base within tabpage_2
end type
type dw_7 from dc_uo_dw_base within tabpage_2
end type
type tabpage_2 from userobject within tab_1
gb_7 gb_7
gb_4 gb_4
gb_3 gb_3
dw_3 dw_3
dw_4 dw_4
dw_7 dw_7
end type
type tabpage_3 from userobject within tab_1
end type
type gb_6 from groupbox within tabpage_3
end type
type gb_5 from groupbox within tabpage_3
end type
type dw_5 from dc_uo_dw_base within tabpage_3
end type
type dw_6 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_6 gb_6
gb_5 gb_5
dw_5 dw_5
dw_6 dw_6
end type
type tab_1 from tab within w_ge249_relatorio_falta_distribuidora
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_ge249_relatorio_falta_distribuidora from dc_w_sheet
integer width = 3954
integer height = 1904
string title = "GE249 - Relat$$HEX1$$f300$$ENDHEX$$rio de Faltas de Distribuidoras"
long backcolor = 80269524
event ue_retrieve ( )
tab_1 tab_1
end type
global w_ge249_relatorio_falta_distribuidora w_ge249_relatorio_falta_distribuidora

type variables
uo_filial ivo_filial

uo_produto ivo_produto
end variables

forward prototypes
public subroutine wf_insere_grupo_todos ()
public subroutine wf_insere_distribuidora_default ()
public subroutine wf_insere_esteira_todos ()
end prototypes

event ue_retrieve;Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
end event

public subroutine wf_insere_grupo_todos ();DataWindowChild lvdwc

If Tab_1.TabPage_1.dw_1.GetChild("cd_grupo", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_grupo", "0")
	lvdwc.SetItem(1, "de_grupo", "TODOS")
	
	Tab_1.TabPage_1.dw_1.Object.Cd_Grupo[1] = "0"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do grupo.")
End If
end subroutine

public subroutine wf_insere_distribuidora_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If Tab_1.TabPage_1.dw_1.GetChild("cd_distribuidora", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_fornecedor", "000000000")
	lvdwc.SetItem(1, "nm_fantasia",   "TODAS")
	
	Tab_1.TabPage_1.dw_1.Object.Cd_Distribuidora[1] = "000000000"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da distribuidora.")
End If
end subroutine

public subroutine wf_insere_esteira_todos ();DataWindowChild lvdwc

If Tab_1.TabPage_1.dw_1.GetChild("cd_esteira", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_esteira", 0)
	lvdwc.SetItem(1, "de_esteira", "TODOS")
	
	Tab_1.TabPage_1.dw_1.Object.cd_esteira[1] = 0
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da esteira.")
End If
end subroutine

on w_ge249_relatorio_falta_distribuidora.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_ge249_relatorio_falta_distribuidora.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event open;call super::open;ivo_Filial = Create uo_Filial

ivo_Produto = Create uo_Produto
end event

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Produto) 
end event

event ue_postopen;call super::ue_postopen;Date lvdt_Base

Tab_1.TabPage_1.dw_1.of_SetMenu(ivm_Menu)
Tab_1.TabPage_1.dw_2.of_SetMenu(ivm_Menu)
Tab_1.TabPage_2.dw_3.of_SetMenu(ivm_Menu)
Tab_1.TabPage_2.dw_4.of_SetMenu(ivm_Menu)
Tab_1.TabPage_3.dw_5.of_SetMenu(ivm_Menu)
Tab_1.TabPage_3.dw_6.of_SetMenu(ivm_Menu)
Tab_1.TabPage_2.dw_7.of_SetMenu(ivm_Menu)

Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Recuperar(True)
Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Recuperar(True)

Tab_1.TabPage_1.dw_1.Event ue_AddRow()
//Tab_1.TabPage_2.dw_3.Event ue_AddRow()
Tab_1.TabPage_3.dw_5.Event ue_AddRow()

lvdt_Base = RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), -1)

Tab_1.TabPage_1.dw_1.Object.Dt_Inicio 		[1] = lvdt_Base
Tab_1.TabPage_1.dw_1.Object.Dt_Termino		[1] = lvdt_Base

Tab_1.TabPage_1.dw_1.SetFocus()

wf_Insere_Grupo_Todos()

wf_Insere_Distribuidora_Default()

wf_insere_esteira_todos()

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge249_relatorio_falta_distribuidora
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge249_relatorio_falta_distribuidora
end type

type tab_1 from tab within w_ge249_relatorio_falta_distribuidora
integer x = 5
integer width = 3890
integer height = 1716
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanging;Long lvl_Linha

Choose Case OldIndex
	Case 1	
		If Tab_1.TabPage_1.dw_2.GetRow() = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto na lista para visualizar os detalhes.")
			Return 1
		End If

		If NewIndex = 3 and Tab_1.TabPage_2.dw_4.GetRow() = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma distribuidora na lista para visualizar os pedidos.")
			Return 1
		End If		
		
	Case 2
		If NewIndex = 3 and Tab_1.TabPage_2.dw_4.GetRow() = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma distribuidora na lista para visualizar os pedidos.")
			Return 1
		End If		
End Choose

Choose Case NewIndex
	Case 1
		Tab_1.TabPage_2.dw_4.Event ue_Reset()
		Tab_1.TabPage_2.dw_7.Event ue_Reset()
		Tab_1.TabPage_2.dw_3.Event ue_Reset()
	Case 2
		Tab_1.TabPage_2.dw_4.Event ue_Retrieve()
	Case 3
		Tab_1.TabPage_3.dw_6.Event ue_Retrieve()
End Choose
end event

event selectionchanged;Choose Case NewIndex
	Case 1 ; Tab_1.TabPage_1.dw_2.SetFocus()
	Case 2 ; Tab_1.TabPage_2.dw_4.SetFocus()
	Case 3 ; Tab_1.TabPage_3.dw_6.SetFocus()
End Choose
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3854
integer height = 1600
long backcolor = 80269524
string text = "Produtos"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
dw_8 dw_8
end type

on tabpage_1.create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_8=create dw_8
this.Control[]={this.gb_2,&
this.gb_1,&
this.dw_1,&
this.dw_2,&
this.dw_8}
end on

on tabpage_1.destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_8)
end on

type gb_2 from groupbox within tabpage_1
integer x = 9
integer y = 420
integer width = 3831
integer height = 1168
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Produtos em Falta"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within tabpage_1
integer x = 9
integer width = 3205
integer height = 404
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within tabpage_1
integer x = 32
integer y = 52
integer width = 3168
integer height = 332
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_GE249_selecao"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
		
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
		End If		
End Choose
end event

event ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
			End If
			
		Case "nm_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
				This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
			End If		
	End Choose
End If
end event

event losefocus;call super::losefocus;If IsValid(ivo_Produto) Then
	This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
End If

If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If		
end event

event editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

type dw_2 from dc_uo_dw_base within tabpage_1
integer x = 46
integer y = 464
integer width = 3771
integer height = 1108
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_GE249_lista_produto"
boolean vscrollbar = true
end type

event constructor;call super::constructor;String 	lvs_Coluna[]		, &
			lvs_Nome[]		, &
			lvs_Bloqueio[]

lvs_Coluna = {	"id_distribuidora"	, &
					"cd_produto"		, &
					"de_produto"		, &
					"qt_pedida"			, &
					"qt_faturada"		, &
					"qt_falta"}

lvs_Nome = {	"Atendido pela Distribuidora", &
					"C$$HEX1$$f300$$ENDHEX$$digo"				, &
					"Descri$$HEX2$$e700e300$$ENDHEX$$o"			, &
					"Qtde. Pedida"		, &
					"Qtde. Faturada"	, &
					"Qtde. Falta"}
				  
lvs_Bloqueio = {"S", "N", "N", "N", "N", "N"}

This.of_SetSort(lvs_Coluna, lvs_Nome, lvs_Bloqueio)
This.of_SetFilter(lvs_Coluna, lvs_Nome)


end event

event ue_recuperar;// Override

Date		lvdt_Inicio	, &
			lvdt_Termino

Long 		lvl_Filial	, &
    	 	lvl_Produto	, &
	  		lvl_Esteira
	  
String	lvs_Grupo	, &
			lvs_Distribuidora,&
			lvs_Pedido_comp

dw_1.AcceptText()

lvdt_Inicio  	  	= dw_1.Object.Dt_Inicio 			[1]
lvdt_Termino 	  	= dw_1.Object.Dt_Termino			[1]
lvl_Filial   	  	= dw_1.Object.Cd_Filial 	  		[1]
lvl_Produto  	  	= dw_1.Object.Cd_Produto			[1]
lvs_Grupo    	  	= dw_1.Object.Cd_Grupo  	    	[1]
lvs_Distribuidora = dw_1.Object.cd_distribuidora	[1]
lvl_Esteira			= dw_1.Object.cd_esteira			[1]
lvs_Pedido_comp	= dw_1.Object.id_Pedido_comp		[1]

If lvs_Pedido_comp = 'N' Then

	If lvs_Distribuidora <> "000000000" Then
	
		// Distribuidoras
		If lvs_Distribuidora <> "053404705" Then
			If Not This.of_ChangeDataObject("dw_GE249_lista_produto_distribuidora") Then Return -1
			If Not dw_8.of_ChangeDataObject("dw_GE249_rel_produto_distribuidora") Then Return -1	
		
			This.of_AppendWhere("a.cd_distribuidora = '" + lvs_Distribuidora + "'", 1)
		Else
			// Estoque Central
			If Not This.of_ChangeDataObject("dw_GE249_lista_produto_estoque_central") Then Return -1	
			If Not dw_8.of_ChangeDataObject("dw_GE249_rel_produto_estoque_central") Then Return -1	
		End If
	
		If Not IsNull(lvl_Filial) and lvl_Filial <> 0 Then
			This.of_AppendWhere("a.cd_filial = " + String(lvl_Filial), 1)
		End If

		If Not IsNull(lvl_Produto) and lvl_Produto <> 0 Then
			This.of_AppendWhere("b.cd_produto = " + String(lvl_Produto), 1)
		End If

		If Not IsNull(lvs_Grupo) and lvs_Grupo <> "0" Then
			This.of_AppendWhere("substring(g.cd_subcategoria, 1, 1) = '" + lvs_Grupo + "'", 1)
		End If
	
		If Not IsNull(lvl_Esteira) and lvl_Esteira <> 0 Then
			This.of_AppendWhere(" b.cd_produto in (select x.cd_produto from wms_endereco_produto x where cd_esteira = "+String(lvl_Esteira)+")", 1)
		End If
	Else
		// Lista produto distribuidoras e estoque central
			If Not This.of_ChangeDataObject("dw_GE249_lista_produto") Then Return -1
			If Not dw_8.of_ChangeDataObject("dw_GE249_rel_produto") Then Return -1	
	
		If Not IsNull(lvl_Filial) and lvl_Filial <> 0 Then
			This.of_AppendWhere("a.cd_filial = " + String(lvl_Filial), 1)
			This.of_AppendWhere("a.cd_filial = " + String(lvl_Filial), 3)
		End If
	
		If Not IsNull(lvl_Produto) and lvl_Produto <> 0 Then
			This.of_AppendWhere("b.cd_produto = " + String(lvl_Produto), 1)
			This.of_AppendWhere("b.cd_produto = " + String(lvl_Produto), 3)
		End If
	
		If Not IsNull(lvs_Grupo) and lvs_Grupo <> "0" Then
			This.of_AppendWhere("substring(g.cd_subcategoria, 1, 1) = '" + lvs_Grupo + "'", 1)
			This.of_AppendWhere("substring(g.cd_subcategoria, 1, 1) = '" + lvs_Grupo + "'", 3)
		End If
	
		If Not IsNull(lvl_Esteira) and lvl_Esteira <> 0 Then
			This.of_AppendWhere(" b.cd_produto in (select x.cd_produto from wms_endereco_produto x where cd_esteira = "+String(lvl_Esteira)+")", 1)
			This.of_AppendWhere(" b.cd_produto in (select x.cd_produto from wms_endereco_produto x where cd_esteira = "+String(lvl_Esteira)+")", 4)
		End If
	End If

Else
	
	If lvs_Distribuidora <> "000000000" Then
	
		// Distribuidoras
		If lvs_Distribuidora <> "053404705" Then
			If Not This.of_ChangeDataObject("dw_Ge249_lista_prod_distrib_agrup_dt") Then Return -1
			If Not dw_8.of_ChangeDataObject("dw_Ge249_rel_produto_distrib_agrup_dt") Then Return -1	
		
			This.of_AppendWhere("a.cd_distribuidora = '" + lvs_Distribuidora + "'", 1)
		Else
			// Estoque Central
			If Not This.of_ChangeDataObject("dw_Ge249_lista_prod_est_central_agrup_dt") Then Return -1	
			If Not dw_8.of_ChangeDataObject("dw_Ge249_rel_prod_est_central_agrup_dt") Then Return -1	
		End If
	
		If Not IsNull(lvl_Filial) and lvl_Filial <> 0 Then
			This.of_AppendWhere("a.cd_filial = " + String(lvl_Filial), 1)
		End If

		If Not IsNull(lvl_Produto) and lvl_Produto <> 0 Then
			This.of_AppendWhere("b.cd_produto = " + String(lvl_Produto), 1)
		End If

		If Not IsNull(lvs_Grupo) and lvs_Grupo <> "0" Then
			This.of_AppendWhere("substring(g.cd_subcategoria, 1, 1) = '" + lvs_Grupo + "'", 1)
		End If
	
		If Not IsNull(lvl_Esteira) and lvl_Esteira <> 0 Then
			This.of_AppendWhere(" b.cd_produto in (select x.cd_produto from wms_endereco_produto x where cd_esteira = "+String(lvl_Esteira)+")", 1)
		End If
	Else
		// Lista produto distribuidoras e estoque central
			If Not This.of_ChangeDataObject("dw_GE249_lista_produto_agrup_data") Then Return -1
			If Not dw_8.of_ChangeDataObject("dw_ge249_rel_produto_agrup_data") Then Return -1	
	
		If Not IsNull(lvl_Filial) and lvl_Filial <> 0 Then
			This.of_AppendWhere("a.cd_filial = " + String(lvl_Filial), 1)
			This.of_AppendWhere("a.cd_filial = " + String(lvl_Filial), 3)
		End If
	
		If Not IsNull(lvl_Produto) and lvl_Produto <> 0 Then
			This.of_AppendWhere("b.cd_produto = " + String(lvl_Produto), 1)
			This.of_AppendWhere("b.cd_produto = " + String(lvl_Produto), 3)
		End If
	
		If Not IsNull(lvs_Grupo) and lvs_Grupo <> "0" Then
			This.of_AppendWhere("substring(g.cd_subcategoria, 1, 1) = '" + lvs_Grupo + "'", 1)
			This.of_AppendWhere("substring(g.cd_subcategoria, 1, 1) = '" + lvs_Grupo + "'", 3)
		End If
	
		If Not IsNull(lvl_Esteira) and lvl_Esteira <> 0 Then
			This.of_AppendWhere(" b.cd_produto in (select x.cd_produto from wms_endereco_produto x where cd_esteira = "+String(lvl_Esteira)+")", 1)
			This.of_AppendWhere(" b.cd_produto in (select x.cd_produto from wms_endereco_produto x where cd_esteira = "+String(lvl_Esteira)+")", 4)
		End If
	End If
	
End If

This.ShareData(dw_8)

This.of_SetRowSelection()

Return This.Retrieve(lvdt_Inicio, lvdt_Termino)
end event

event ue_postretrieve;Boolean	lvb_Classificar	, &
			lvb_Filtrar		, &
			lvb_Localizar	, &
			lvb_Imprimir	, &
			lvb_SalvarComo

If pl_Linhas > 0 Then
	lvb_Classificar	= IsValid(This.ivo_Sort)
	lvb_Filtrar		= IsValid(This.ivo_Filter)
	lvb_Localizar	= IsValid(This.ivo_Find)
	
	lvb_Imprimir   = True
	lvb_SalvarComo = True

	This.SetRow(1)
	This.SetFocus()
	
	If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "WS" Then
		dw_8.Object.Custo.Visible = 0
		dw_8.Object.Custo_L.Visible = 0
		dw_8.Object.Vl_Custo_Gerencial.Visible = 0
	Else
		dw_8.Object.Custo.Visible = 1
		dw_8.Object.Custo_L.Visible = 1
		dw_8.Object.Vl_Custo_Gerencial.Visible = 1
	End If
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma falta localizada.", Information!)
	End If
End If

This.ivo_Controle_Menu.of_Classificar(lvb_Classificar)
This.ivo_Controle_Menu.of_Filtrar(lvb_Filtrar)
This.ivo_Controle_Menu.of_Localizar(lvb_Localizar)
This.ivo_Controle_Menu.of_Imprimir(lvb_Imprimir)
This.ivo_Controle_Menu.of_SalvarComo(lvb_SalvarComo)

Return pl_Linhas
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_print;//OverRide

Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas = This.Event ue_PrePrint()

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		dw_8.Event ue_Print()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
	End If
End If

SetPointer(Arrow!)





end event

event ue_printimmediate;//OverRide

Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas = This.Event ue_PrePrint()

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		dw_8.Event ue_Printimmediate()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
	End If
End If

SetPointer(Arrow!)
end event

type dw_8 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 2560
integer y = 1092
integer width = 613
integer height = 460
integer taborder = 50
boolean bringtotop = true
boolean hscrollbar = true
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;String ls_Distribuidora

String ls_Texto

dw_1.AcceptText()


DataWindowChild ldwc

If dw_1.GetChild("cd_distribuidora", ldwc) = 1 Then
	
	ls_Distribuidora = ldwc.GetItemString(ldwc.GetRow(), "cd_fornecedor")
	
	If ls_Distribuidora = "000000000" Then 
		ls_Texto = "TODAS"
	Else	
		ls_Texto = ls_Distribuidora + " -  " + ldwc.GetItemString(ldwc.GetRow(), "nm_fantasia")
	End If
	
End If

This.Object.periodo_t.Text = 	STRING(dw_1.Object.dt_inicio [1], "DD/MM/YYYY") + " at$$HEX1$$e900$$ENDHEX$$ " + &
									  		STRING(dw_1.Object.dt_termino[1], "DD/MM/YYYY")

This.Object.distribuidora_t.Text = ls_Texto

Return This.Rowcount()
end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3854
integer height = 1600
long backcolor = 80269524
string text = "Distribuidoras"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_7 gb_7
gb_4 gb_4
gb_3 gb_3
dw_3 dw_3
dw_4 dw_4
dw_7 dw_7
end type

on tabpage_2.create
this.gb_7=create gb_7
this.gb_4=create gb_4
this.gb_3=create gb_3
this.dw_3=create dw_3
this.dw_4=create dw_4
this.dw_7=create dw_7
this.Control[]={this.gb_7,&
this.gb_4,&
this.gb_3,&
this.dw_3,&
this.dw_4,&
this.dw_7}
end on

on tabpage_2.destroy
destroy(this.gb_7)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.dw_7)
end on

type gb_7 from groupbox within tabpage_2
integer x = 9
integer y = 172
integer width = 3205
integer height = 744
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Distribuidoras Cadastradas"
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within tabpage_2
integer x = 9
integer y = 928
integer width = 3205
integer height = 644
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Distribuidoras com Pedidos"
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within tabpage_2
integer x = 9
integer width = 1760
integer height = 164
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within tabpage_2
integer x = 37
integer y = 52
integer width = 1723
integer height = 100
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_GE249_produto_selecionado"
end type

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_reset;call super::ue_reset;This.Event ue_AddRow()
end event

type dw_4 from dc_uo_dw_base within tabpage_2
integer x = 37
integer y = 976
integer width = 3159
integer height = 580
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_GE249_lista_distribuidora"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_recuperar;// Override

Long lvl_Linha, &
     lvl_Produto

String lvs_Descricao, &
       lvs_Distribuidora, &
		 lvs_Distribuidora_id

Date lvdt_Inicio, &
     lvdt_Termino

Tab_1.TabPage_1.dw_1.AcceptText()

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

lvdt_Inicio  	  = Tab_1.TabPage_1.dw_1.Object.Dt_Inicio 	    [1]
lvdt_Termino 	  = Tab_1.TabPage_1.dw_1.Object.Dt_Termino	    [1]
lvs_Distribuidora = Tab_1.TabPage_1.dw_1.Object.cd_distribuidora[1]

lvl_Produto   = Tab_1.TabPage_1.dw_2.Object.Cd_Produto[lvl_Linha]
lvs_Descricao = Tab_1.TabPage_1.dw_2.Object.De_Produto[lvl_Linha]

Tab_1.TabPage_2.dw_3.AcceptText()

If IsNull(Tab_1.TabPage_2.dw_3.Object.Cd_Produto[1]) or Tab_1.TabPage_2.dw_3.Object.Cd_Produto[1] <> lvl_Produto Then
	lvs_Distribuidora_id = Tab_1.TabPage_1.dw_2.Object.id_distribuidora[lvl_Linha]
			
	If lvs_Distribuidora_id = 'S' Then
		Tab_1.TabPage_2.dw_4.of_ChangeDataObject("dw_GE249_lista_distribuidora")			
	Else
		Tab_1.TabPage_2.dw_4.of_ChangeDataObject("dw_GE249_lista_dist_estoque_central")
	End If
	
	Tab_1.TabPage_2.dw_3.Object.Cd_Produto[1] = lvl_Produto
	Tab_1.TabPage_2.dw_3.Object.De_Produto[1] = lvs_Descricao
	
	If lvs_Distribuidora <> "000000000" Then
		This.of_AppendWhere("a.cd_distribuidora = '" + lvs_Distribuidora + "'")
	End If
	
	This.Retrieve(lvdt_Inicio, lvdt_Termino, lvl_Produto)
	
	dw_7.Event ue_Retrieve()
End If

Return This.RowCount()
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
	This.of_SetRowSelection()
	This.SetFocus()
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

type dw_7 from dc_uo_dw_base within tabpage_2
integer x = 37
integer y = 220
integer width = 3159
integer height = 676
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_GE249_lista_preco_distribuidora"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event ue_recuperar;// Override

Long lvl_Linha, &
     lvl_Produto

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Produto = Tab_1.TabPage_1.dw_2.Object.Cd_Produto[lvl_Linha]

Return This.Retrieve(lvl_Produto)
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3854
integer height = 1600
long backcolor = 80269524
string text = "Pedidos"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_6 gb_6
gb_5 gb_5
dw_5 dw_5
dw_6 dw_6
end type

on tabpage_3.create
this.gb_6=create gb_6
this.gb_5=create gb_5
this.dw_5=create dw_5
this.dw_6=create dw_6
this.Control[]={this.gb_6,&
this.gb_5,&
this.dw_5,&
this.dw_6}
end on

on tabpage_3.destroy
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.dw_5)
destroy(this.dw_6)
end on

type gb_6 from groupbox within tabpage_3
integer x = 9
integer y = 256
integer width = 3205
integer height = 1316
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Pedidos"
borderstyle borderstyle = styleraised!
end type

type gb_5 from groupbox within tabpage_3
integer x = 9
integer width = 2021
integer height = 244
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_5 from dc_uo_dw_base within tabpage_3
integer x = 23
integer y = 52
integer width = 1998
integer height = 180
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_GE249_distribuidora_selecionada"
end type

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

type dw_6 from dc_uo_dw_base within tabpage_3
integer x = 37
integer y = 304
integer width = 3159
integer height = 1252
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_GE249_lista_pedido"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_recuperar;// Override

Long lvl_Linha, &
     lvl_Produto

String lvs_Descricao, &
       lvs_Distribuidora, &
		 lvs_Fantasia

Date lvdt_Inicio, &
     lvdt_Termino

lvdt_Inicio  = Tab_1.TabPage_1.dw_1.Object.Dt_Inicio [1]
lvdt_Termino = Tab_1.TabPage_1.dw_1.Object.Dt_Termino[1]

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Produto   = Tab_1.TabPage_1.dw_2.Object.Cd_Produto[lvl_Linha]
lvs_Descricao = Tab_1.TabPage_1.dw_2.Object.De_Produto[lvl_Linha]

lvl_Linha = Tab_1.TabPage_2.dw_4.GetRow()

lvs_Distribuidora = Tab_1.TabPage_2.dw_4.Object.Cd_Distribuidora[lvl_Linha]
lvs_Fantasia      = Tab_1.TabPage_2.dw_4.Object.Nm_Fantasia     [lvl_Linha]

Tab_1.TabPage_3.dw_5.AcceptText()

If IsNull(Tab_1.TabPage_3.dw_5.Object.Cd_Produto[1]) or IsNull(Tab_1.TabPage_3.dw_5.Object.Cd_Distribuidora[1]) or &
   Tab_1.TabPage_3.dw_5.Object.Cd_Produto[1] <> lvl_Produto or Tab_1.TabPage_3.dw_5.Object.Cd_Distribuidora[1] <> lvs_Distribuidora Then
	
	Tab_1.TabPage_3.dw_5.Object.Cd_Produto      [1] = lvl_Produto
	Tab_1.TabPage_3.dw_5.Object.De_Produto      [1] = lvs_Descricao
	Tab_1.TabPage_3.dw_5.Object.Cd_Distribuidora[1] = lvs_Distribuidora
	Tab_1.TabPage_3.dw_5.Object.Nm_Distribuidora[1] = lvs_Fantasia
	
	// Somente os pedidos que n$$HEX1$$e300$$ENDHEX$$o foram rejeitados
	If lvs_Distribuidora = '053404705' Then
		This.of_AppendWhere("a.id_situacao  <> 'J'")
	End If
	
	This.Retrieve(lvdt_Inicio, lvdt_Termino, lvl_Produto, lvs_Distribuidora)
End If

Return This.RowCount()
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
	
	This.SetFocus()
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

