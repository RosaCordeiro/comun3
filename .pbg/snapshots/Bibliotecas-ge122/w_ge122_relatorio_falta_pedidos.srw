HA$PBExportHeader$w_ge122_relatorio_falta_pedidos.srw
forward
global type w_ge122_relatorio_falta_pedidos from dc_w_sheet
end type
type tab_1 from tab within w_ge122_relatorio_falta_pedidos
end type
type tabpage_1 from userobject within tab_1
end type
type gb_2 from groupbox within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type dw_3 from datawindow within tabpage_1
end type
type dw_2 from dc_uo_dw_base within tabpage_1
end type
type tabpage_1 from userobject within tab_1
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_3 dw_3
dw_2 dw_2
end type
type tabpage_2 from userobject within tab_1
end type
type gb_6 from groupbox within tabpage_2
end type
type dw_6 from dc_uo_dw_base within tabpage_2
end type
type tabpage_2 from userobject within tab_1
gb_6 gb_6
dw_6 dw_6
end type
type tab_1 from tab within w_ge122_relatorio_falta_pedidos
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_ge122_relatorio_falta_pedidos from dc_w_sheet
string accessiblename = "Relat$$HEX1$$f300$$ENDHEX$$rio de Faltas dos Pedidos do Almoxarifado (GE122)"
integer width = 3054
integer height = 1968
string title = "GE122 - Relat$$HEX1$$f300$$ENDHEX$$rio de Faltas dos Pedidos do Almoxarifado"
long backcolor = 80269524
event ue_retrieve ( )
tab_1 tab_1
end type
global w_ge122_relatorio_falta_pedidos w_ge122_relatorio_falta_pedidos

type variables
uo_filial ivo_filial

uo_produto ivo_produto

long ivl_Produto
end variables

forward prototypes
public function boolean wf_saldo_em_transito ()
end prototypes

event ue_retrieve;Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
end event

public function boolean wf_saldo_em_transito ();st_saldo_transito str

Long ll_Find
Long ll_Linha
Long ll_Linhas

gf_Saldo_em_transito(Ref str)

ll_Linhas = UpperBound(str.Cd_Produto[])

For ll_Linha = 1 To ll_Linhas
	
//	//Quando o fornecedor n$$HEX1$$e300$$ENDHEX$$o informa o c$$HEX1$$f300$$ENDHEX$$digo de barras no XML, o item no agendamento fica sem o c$$HEX1$$f300$$ENDHEX$$digo de produtos
//	If IsNull(str.Cd_Produto[ll_Linha]) Or str.Cd_Produto[ll_Linha] = 0 Then Continue
	
	ll_Find = Tab_1.TabPage_1.dw_2.Find("cd_produto = " + String(str.Cd_Produto[ll_Linha]), 1, Tab_1.TabPage_1.dw_2.RowCount())
	
	If ll_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw 2.", StopSign!)
		Return False
	End If
	
	If ll_Find > 0 Then
		Tab_1.TabPage_1.dw_2.Object.Qt_Est_Transito[ll_Find] = str.Qt_Saldo[ll_Linha] 
	End If
Next

Return True
end function

on w_ge122_relatorio_falta_pedidos.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_ge122_relatorio_falta_pedidos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event open;call super::open;ivo_Filial		= Create uo_Filial
ivo_Produto	= Create uo_Produto


end event

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Produto)
end event

event ue_postopen;call super::ue_postopen;Date lvdt_Base
This.ivm_Menu.ivb_Permite_Imprimir = True
	
Tab_1.TabPage_1.dw_1.of_SetMenu(ivm_Menu)
Tab_1.TabPage_1.dw_2.of_SetMenu(ivm_Menu)
Tab_1.TabPage_2.dw_6.of_SetMenu(ivm_Menu)

Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Recuperar(True)
Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Recuperar(True)

Tab_1.TabPage_1.dw_1.Event ue_AddRow()

lvdt_Base = RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), -1)

Tab_1.TabPage_1.dw_1.Object.Dt_Inicio		[1] = lvdt_Base
Tab_1.TabPage_1.dw_1.Object.Dt_Termino	[1] = lvdt_Base

Tab_1.TabPage_1.dw_1.SetFocus()
end event

event ue_printimmediate;call super::ue_printimmediate;Date 	lvdt_inicio, &
		lvdt_termino
		
Long lvl_cd_filial, lvl_cd_produto

String lvs_nm_filial, lvs_de_produto

Tab_1.tabpage_1.dw_1.AcceptText()	

lvdt_inicio		=	tab_1.tabpage_1.dw_1.Object.dt_inicio		[1]
lvdt_termino		=	tab_1.tabpage_1.dw_1.Object.dt_termino	[1]
lvs_nm_filial		=	tab_1.tabpage_1.dw_1.Object.nm_filial		[1]
lvl_cd_filial		=	tab_1.tabpage_1.dw_1.Object.cd_filial		[1]
lvs_de_produto	=	tab_1.tabpage_1.dw_1.Object.de_produto	[1]
lvl_cd_produto	=	tab_1.tabpage_1.dw_1.Object.cd_produto	[1]

Tab_1.tabpage_1.dw_3.Object.st_periodo.Text = String(lvdt_Inicio, "dd/mm/yyyy") + " at$$HEX1$$e900$$ENDHEX$$ : " + String(lvdt_Termino, "dd/mm/yyyy")

If Not IsNull(lvl_cd_filial )  Then 
	Tab_1.tabpage_1.dw_3.Object.filial.Text = String(lvs_nm_filial) + " ("+String(lvl_cd_filial)+")"
Else
	Tab_1.tabpage_1.dw_3.Object.filial.Text = "TODAS" 
End If

If Not IsNull(lvl_cd_produto) Then 
	Tab_1.tabpage_1.dw_3.Object.produto.Text = String(lvs_de_produto)+ " ("+String(lvl_cd_produto)+")"
Else
	 Tab_1.tabpage_1.dw_3.Object.produto.Text = "TODOS" 	
End If

Tab_1.tabpage_1.dw_3.Print()
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge122_relatorio_falta_pedidos
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge122_relatorio_falta_pedidos
end type

type tab_1 from tab within w_ge122_relatorio_falta_pedidos
integer x = 5
integer width = 2976
integer height = 1752
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

event selectionchanging;Long lvl_Linha

Choose Case OldIndex
	Case 1	
		If Tab_1.TabPage_1.dw_2.GetRow() = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto na lista para visualizar os detalhes.")
			Return 1
		End If
		
End Choose

Choose Case NewIndex
	Case 2	
		Tab_1.TabPage_2.dw_6.Event ue_Retrieve()
End Choose

end event

event selectionchanged;Choose Case NewIndex
	Case 1 ; Tab_1.TabPage_1.dw_2.SetFocus()	
	Case 2 ; Tab_1.TabPage_2.dw_6.SetFocus()
End Choose
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2939
integer height = 1636
long backcolor = 80269524
string text = "Produtos"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_3 dw_3
dw_2 dw_2
end type

on tabpage_1.create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_3=create dw_3
this.dw_2=create dw_2
this.Control[]={this.gb_2,&
this.gb_1,&
this.dw_1,&
this.dw_3,&
this.dw_2}
end on

on tabpage_1.destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.dw_2)
end on

type gb_2 from groupbox within tabpage_1
integer x = 9
integer y = 396
integer width = 2894
integer height = 1208
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
integer width = 1906
integer height = 376
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
integer x = 50
integer y = 52
integer width = 1833
integer height = 316
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge122_selecao"
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

type dw_3 from datawindow within tabpage_1
boolean visible = false
integer x = 1966
integer y = 28
integer width = 526
integer height = 372
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge122_lista_relatorio"
boolean border = false
boolean livescroll = true
end type

type dw_2 from dc_uo_dw_base within tabpage_1
integer x = 37
integer y = 456
integer width = 2830
integer height = 1108
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge122_lista"
boolean vscrollbar = true
end type

event constructor;call super::constructor;ivb_Ordena_Colunas = True
end event

event ue_recuperar;// Override

Date	lvdt_Inicio, &
     	lvdt_Termino

Long	lvl_Filial, &
     	lvl_Produto
	  
String	lvs_Grupo, &
	   	lvs_Distribuidora, &
		ls_Ativo

dw_1.AcceptText()

lvdt_Inicio		= dw_1.Object.Dt_Inicio 		[1]
lvdt_Termino	= dw_1.Object.Dt_Termino	[1]
lvl_Filial			= dw_1.Object.Cd_Filial		[1]
lvl_Produto		= dw_1.Object.Cd_Produto	[1]
ls_Ativo			= dw_1.Object.Id_Ativo		[1]

If Not IsNull(lvl_Filial) Then
	This.of_AppendWhere("p.cd_filial = " + String(lvl_Filial))
End If

If Not IsNull(lvl_Produto) And lvl_Produto <> 0 Then
	This.of_AppendWhere("pp.cd_produto = " + String(lvl_Produto))
End If

If ls_Ativo = "S" Then
	This.of_AppendWhere("g.id_situacao = 'A'")
End If

If This.ShareData(dw_3) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Share Data da dw_3.", StopSign!)
	Return -1
End If

This.of_SetRowSelection()

Return This.Retrieve(lvdt_Inicio, lvdt_Termino)
end event

event ue_postretrieve;Boolean lvb_Classificar, &
        lvb_Filtrar, &
		lvb_Localizar, &
		lvb_Imprimir, &
		lvb_SalvarComo
		
If pl_Linhas > 0 Then
	
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	lvb_Imprimir   = True
	lvb_SalvarComo = True

	This.SetRow(1)
	This.SetFocus()
	
	If Not wf_Saldo_Em_Transito() Then Return -1
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma falta localizada.", Information!)
	End If
End If

ivo_Controle_Menu.of_Classificar(lvb_Classificar)
ivo_Controle_Menu.of_Filtrar(lvb_Filtrar)
ivo_Controle_Menu.of_Localizar(lvb_Localizar)
ivo_Controle_Menu.of_Imprimir(lvb_Imprimir)
ivo_Controle_Menu.of_SalvarComo(lvb_SalvarComo)

Return pl_Linhas
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event rowfocuschanged;call super::rowfocuschanged;If dw_2.Rowcount() > 0 Then
	ivl_produto = dw_2.Object.cd_produto[CurrentRow]
End If
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2939
integer height = 1636
long backcolor = 80269524
string text = "Pedidos"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_6 gb_6
dw_6 dw_6
end type

on tabpage_2.create
this.gb_6=create gb_6
this.dw_6=create dw_6
this.Control[]={this.gb_6,&
this.dw_6}
end on

on tabpage_2.destroy
destroy(this.gb_6)
destroy(this.dw_6)
end on

type gb_6 from groupbox within tabpage_2
integer x = 9
integer y = 32
integer width = 2496
integer height = 1464
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Pedidos - EM SEPARAC$$HEX1$$c300$$ENDHEX$$O"
borderstyle borderstyle = styleraised!
end type

type dw_6 from dc_uo_dw_base within tabpage_2
integer x = 41
integer y = 88
integer width = 2437
integer height = 1388
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge122_lista_pedido"
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

event ue_recuperar;//Override

Long lvl_Produto, lvl_Filial

Date	lvdt_Inicio, &
		lvdt_Termino  
	 
Tab_1.TabPage_1.dw_1.AcceptText()

If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then

	lvdt_Inicio		= Tab_1.TabPage_1.dw_1.Object.dt_inicio		[1]
	lvdt_Termino	= Tab_1.TabPage_1.dw_1.Object.dt_termino	[1]
	lvl_Produto		= Tab_1.TabPage_1.dw_1.Object.cd_produto	[1]
	lvl_Filial			= Tab_1.TabPage_1.dw_1.Object.cd_filial		[1]
	
	If Not IsNull(lvl_Filial) Then
		This.of_AppendWhere("p.cd_filial = " + String(lvl_Filial))
	End If
		
	Return This.Retrieve(lvdt_Inicio, lvdt_Termino, ivl_Produto)
End If
end event

