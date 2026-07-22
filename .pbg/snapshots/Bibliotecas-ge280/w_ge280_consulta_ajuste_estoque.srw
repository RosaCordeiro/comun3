HA$PBExportHeader$w_ge280_consulta_ajuste_estoque.srw
forward
global type w_ge280_consulta_ajuste_estoque from dc_w_2tab_consulta_selecao_lista_det
end type
type dw_relatorio from dc_uo_dw_base within tabpage_1
end type
type tab_2 from tab within tabpage_2
end type
type tabpage_4 from userobject within tab_2
end type
type gb_6 from groupbox within tabpage_4
end type
type dw_6 from dc_uo_dw_base within tabpage_4
end type
type tabpage_4 from userobject within tab_2
gb_6 gb_6
dw_6 dw_6
end type
type tabpage_3 from userobject within tab_2
end type
type gb_4 from groupbox within tabpage_3
end type
type dw_4 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_2
gb_4 gb_4
dw_4 dw_4
end type
type tabpage_5 from userobject within tab_2
end type
type gb_7 from groupbox within tabpage_5
end type
type dw_7 from dc_uo_dw_base within tabpage_5
end type
type tabpage_5 from userobject within tab_2
gb_7 gb_7
dw_7 dw_7
end type
type tabpage_6 from userobject within tab_2
end type
type gb_9 from groupbox within tabpage_6
end type
type dw_8 from dc_uo_dw_base within tabpage_6
end type
type tabpage_6 from userobject within tab_2
gb_9 gb_9
dw_8 dw_8
end type
type tabpage_7 from userobject within tab_2
end type
type gb_8 from groupbox within tabpage_7
end type
type dw_9 from dc_uo_dw_base within tabpage_7
end type
type tabpage_7 from userobject within tab_2
gb_8 gb_8
dw_9 dw_9
end type
type tabpage_8 from userobject within tab_2
end type
type gb_10 from groupbox within tabpage_8
end type
type dw_10 from dc_uo_dw_base within tabpage_8
end type
type tabpage_8 from userobject within tab_2
gb_10 gb_10
dw_10 dw_10
end type
type tab_2 from tab within tabpage_2
tabpage_4 tabpage_4
tabpage_3 tabpage_3
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
end type
end forward

global type w_ge280_consulta_ajuste_estoque from dc_w_2tab_consulta_selecao_lista_det
string tag = "w_ge280_consulta_ajuste_estoque"
integer width = 3625
integer height = 2020
string title = "GE280 - Consulta Ajustes Estoque"
end type
global w_ge280_consulta_ajuste_estoque w_ge280_consulta_ajuste_estoque

type variables
uo_Filial ivo_Filial
uo_Produto ivo_Produto

Datetime ivdh_Inicio
Datetime ivdh_Fim

Long ivl_Filial
Long ivl_Motivo
Long ivl_Produto

String ivs_Filial

Decimal ivdc_Vl_Total
end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();// Coloca o item TODAS
DataWindowChild ldw_Child

Long lvl_Regiao

If Tab_1.TabPage_1.dw_1.GetChild("cd_regiao", ldw_Child) = 1 Then
	
	ldw_Child.InsertRow(1)

	ldw_Child.SetItem(1,"cd_regiao",0)
	ldw_Child.SetItem(1,"de_regiao","TODAS")
	
	select cd_regiao
	Into :lvl_Regiao
	From regiao
	Where nr_matricula_regional = :gvo_aplicacao.ivo_seguranca.nr_matricula
	Using SQLCa;
	
	If SQLCa.SQLCode = 0 Then
		Tab_1.TabPage_1.dw_1.Object.cd_regiao[1] = lvl_Regiao
	Else
		Tab_1.TabPage_1.dw_1.Object.cd_regiao[1] = 0	
	End If
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o item 'TODAS' na coluna regi$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
End If

If Tab_1.TabPage_1.dw_1.GetChild("cd_motivo", ldw_Child) = 1 Then
	
	ldw_Child.InsertRow(1)

	ldw_Child.SetItem(1,"cd_motivo_ajuste",0)
	ldw_Child.SetItem(1,"de_motivo_ajuste","TODOS")
	
	Tab_1.TabPage_1.dw_1.Object.cd_motivo[1] = 0
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o item 'TODOS' na coluna motivo.", StopSign!)
End If
end subroutine

on w_ge280_consulta_ajuste_estoque.create
int iCurrent
call super::create
end on

on w_ge280_consulta_ajuste_estoque.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;String lvs_Param
String lvs_Data

Date lvdt_Inicio
Date lvdt_Fim

lvs_Param = Message.StringParm

If (Trim(lvs_Param)<>'')and(not(IsNull(lvs_Param))and(lvs_Param<>This.Tag)) Then
	lvs_Data = Mid(lvs_Param,1,Pos(lvs_Param,';') - 1)
	If IsDate(lvs_Data) Then
		lvdt_Inicio = Date(lvs_Data)
	Else
		lvdt_Inicio	= Today()		
	End If

	lvs_Data = Mid(lvs_Param,Pos(lvs_Param,';') + 1)
	If IsDate(lvs_Data) Then
		lvdt_Fim = Date(lvs_Data)
	Else
		lvdt_Fim	= Today()		
	End If
Else
	lvdt_Inicio	= RelativeDate(Today(),-1)
	lvdt_Fim		= RelativeDate(Today(),-1)
End If

Tab_1.TabPage_1.dw_1.Object.dt_inicio	[1] = lvdt_Inicio
Tab_1.TabPage_1.dw_1.Object.dt_fim	[1] = lvdt_Fim

wf_insere_padrao()


ivm_menu.ivb_permite_imprimir = True
end event

event ue_preopen;call super::ue_preopen;ivo_Produto 	= Create uo_Produto
ivo_Filial		= Create uo_Filial

Tab_1.TabPage_1.dw_relatorio.Visible = False
end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Filial)
end event

event open;call super::open;Width = 3665
Height = 1980
end event

event ue_print;call super::ue_print;Choose Case Tab_1.SelectedTab
	Case 1
		Tab_1.tabpage_1.dw_relatorio.Event ue_Print()
	Case 2
		//
End Choose
end event

event ue_printimmediate;call super::ue_printimmediate;Choose Case Tab_1.SelectedTab
	Case 1
		Tab_1.tabpage_1.dw_relatorio.Event ue_PrintImmediate()
	Case 2
		//
End Choose
end event

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge280_consulta_ajuste_estoque
integer width = 3566
integer height = 1812
end type

event tab_1::selectionchanged;//override
Choose Case NewIndex
	Case 1
		TabPage_1.dw_2.SetFocus()
		ivm_menu.mf_imprimir(TabPage_1.dw_relatorio.RowCount() > 0)
	Case 2
		Tabpage_2.dw_3.Setfocus( )
		Tabpage_2.gb_3.Text = 'Detalhes - '+ivs_filial+' ('+String(ivl_filial)+')'
		ivm_menu.mf_imprimir(False)
End Choose
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 3529
integer height = 1696
dw_relatorio dw_relatorio
end type

on tabpage_1.create
this.dw_relatorio=create dw_relatorio
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_relatorio
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_relatorio)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer width = 3488
integer height = 1296
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 3337
integer height = 352
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer width = 3255
integer height = 244
string dataobject = "dw_ge280_selecao"
end type

event dw_1::editchanged;call super::editchanged;If dwo.Name = "de_filial" Then
	If Data = "" or IsNull(Data) Then
		ivo_filial.of_inicializa()
		This.Object.cd_filial[1] = ivo_filial.cd_filial
		Return 0
	End If
End If

If dwo.Name = "de_produto" Then
	If Data = "" or IsNull(Data) Then
		ivo_Produto.of_inicializa()
		This.Object.cd_produto [1] = ivo_Produto.cd_produto
		Return 0
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;If Dwo.Name = "de_filial" Then
	If Data <> "" Then
		If Trim(Data) <> ivo_Filial.nm_fantasia Then
			Return 1 
		End If
	End If
End If

If Dwo.Name = "de_produto" Then
	If Data <> "" Then
		If Trim(Data) <> ivo_Produto.de_produto Then
			Return 1 
		End If
	End If
End If

If Dwo.Name = "cd_regiao" Then
	ivo_Filial.of_Inicializa()
	This.Object.cd_filial	[1] = ivo_Filial.cd_filial
	This.Object.de_filial	[1] = ivo_Filial.nm_fantasia
End If

Parent.dw_2.Reset()
end event

event dw_1::losefocus;call super::losefocus;If Not IsNull(This.Object.cd_filial[1]) Then
	If IsValid(ivo_Filial) Then
		This.Object.cd_filial	[1] = ivo_Filial.cd_filial
		This.Object.de_filial	[1] = ivo_Filial.nm_fantasia
	End If
End If

If Not IsNull(This.Object.cd_produto[1]) Then
	If IsValid(ivo_Produto) Then
		This.Object.cd_produto	[1] = ivo_Produto.cd_produto
		This.Object.de_produto	[1] = ivo_Produto.de_produto
	End If
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName() 
		Case "de_filial" 
		
			ivo_Filial.of_Localiza_Filial(GetText())
			
			If ivo_Filial.Localizada Then	
				This.Object.cd_filial	[1] = ivo_Filial.cd_filial
				This.Object.de_filial	[1] = ivo_Filial.nm_fantasia
				This.Object.cd_regiao	[1] = 0
			Else
				ivo_Filial.of_inicializa()
				This.Object.cd_filial	[1] = ivo_Filial.cd_filial
				This.Object.de_filial	[1] = ivo_Filial.nm_fantasia
			End If			
		Case "de_produto" 
		
			ivo_produto.of_localiza_produto(GetText())
			
			If ivo_produto.localizado Then	
				This.Object.cd_produto	[1] = ivo_produto.cd_produto
				This.Object.de_produto	[1] = ivo_produto.de_produto
			Else
				ivo_produto.of_inicializa()
				This.Object.cd_produto	[1] = ivo_produto.cd_produto
				This.Object.de_produto	[1] = ivo_produto.de_produto
			End If		
	End Choose
End If
end event

event dw_1::constructor;call super::constructor;This.Of_SetColSelection(True)
end event

event dw_1::ue_saveas;call super::ue_saveas;dw_2.Event ue_SaveAs()
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer width = 3438
integer height = 1184
string dataobject = "dw_ge280_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Filial
Long lvl_Regiao

Parent.dw_1.Accepttext( )

lvl_Filial		= Parent.dw_1.Object.cd_filial		[1]
ivl_Produto	= Parent.dw_1.Object.cd_produto	[1]
ivl_Motivo	= Parent.dw_1.Object.cd_motivo	[1]
lvl_Regiao	= Parent.dw_1.Object.cd_regiao	[1]

If lvl_Filial > 0 Then
	This.of_AppendWhere_Subquery('m.cd_filial_ajuste='+String(lvl_Filial), 2)
	This.of_AppendWhere_Subquery('r1.cd_filial='+String(lvl_Filial), 1)
End If

If ivl_Produto > 0 Then
	This.of_AppendWhere_Subquery('m.cd_produto='+String(ivl_Produto), 2)
End If

If ivl_Motivo > 0 Then
	This.of_AppendWhere_Subquery('m.cd_motivo_ajuste='+String(ivl_Motivo), 2)
End If

If lvl_Regiao > 0 Then
	This.of_AppendWhere_Subquery('f.cd_regiao='+String(lvl_Regiao), 2)
End If

Return AncestorReturnValue
end event

event dw_2::ue_recuperar;//override
Datetime lvdh_Inicio
Datetime lvdh_Fim

Parent.dw_1.Accepttext( )

lvdh_Inicio	= Parent.dw_1.Object.dt_inicio	[1]
lvdh_Fim		= Parent.dw_1.Object.dt_fim	[1]

lvdh_Inicio	= Datetime(Date(lvdh_Inicio),Time('00:00'))
lvdh_Fim		= Datetime(Date(lvdh_Fim),Time('23:59:59'))

ivdh_Inicio 	= lvdh_Inicio
ivdh_Fim 	= lvdh_Fim

Return This.Retrieve(lvdh_Inicio,lvdh_Fim)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;ivm_menu.mf_imprimir(pl_Linhas > 0)
ivm_menu.mf_SalvarComo(pl_Linhas > 0)

Return AncestorReturnValue
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	ivl_Filial			= This.Object.cd_filial			[CurrentRow]
	ivs_Filial			= This.Object.nm_fantasia	[CurrentRow]
	ivdc_Vl_Total 	= This.Object.vl_total			[CurrentRow]
Else
	SetNull(ivl_Filial)
	ivdc_Vl_Total = 0.00
	ivs_Filial			= ''
End If
end event

event dw_2::ue_reset;call super::ue_reset;Parent.dw_relatorio.ivm_menu.mf_imprimir(False)
ivm_menu.mf_SalvarComo(False)
end event

event dw_2::constructor;call super::constructor;This.ShareData(Parent.dw_relatorio)
end event

event dw_2::clicked;call super::clicked;If This.RowCount() > 0 and ivb_Ordena_Colunas and Row = 0 Then
	This.Event RowFocusChanged(1)
End If
end event

event dw_2::losefocus;call super::losefocus;ivm_menu.mf_SalvarComo(False)
end event

event dw_2::getfocus;call super::getfocus;ivm_menu.mf_SalvarComo(This.RowCount()>0)
end event

event dw_2::ue_saveas;//override
dw_relatorio.Event ue_SaveAs()
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
event create ( )
event destroy ( )
integer width = 3529
integer height = 1696
tab_2 tab_2
end type

on tabpage_2.create
this.tab_2=create tab_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_2
end on

on tabpage_2.destroy
call super::destroy
destroy(this.tab_2)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 3483
integer height = 676
integer weight = 700
string facename = "Verdana"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer width = 3406
integer height = 596
string dataobject = "dw_ge280_lista_produto"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_3::rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	Choose Case Tab_2.SelectedTab
		Case 1
			Parent.Tab_2.Tabpage_4.dw_6.Event ue_Retrieve()
		Case 2
			Parent.Tab_2.Tabpage_3.dw_4.Event ue_Retrieve()
		Case 3
			Parent.Tab_2.Tabpage_5.dw_7.Event ue_Retrieve()
		Case 4
			Parent.Tab_2.Tabpage_6.dw_8.Event ue_Retrieve()
		Case 5
			Parent.Tab_2.Tabpage_7.dw_9.Event ue_Retrieve()
		Case 6
			Parent.Tab_2.Tabpage_8.dw_10.Event ue_Retrieve()
	End Choose
End If
end event

event dw_3::ue_recuperar;//override
Return This.Retrieve(ivdh_Inicio,ivdh_Fim,ivl_Filial)
end event

event dw_3::constructor;call super::constructor;This.Of_SetRowSelection( )
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;Long lvl_Linha

Decimal{2} lvdc_Valor

For lvl_Linha = 1 To pl_Linhas
	lvdc_Valor = This.Object.vl_total [lvl_Linha] 
	This.Object.pc_valor [lvl_Linha] = Round((lvdc_Valor / ivdc_Vl_Total) * 100,2)
Next

Return AncestorReturnValue
end event

event dw_3::ue_preretrieve;call super::ue_preretrieve;If ivl_Produto > 0 Then
	This.of_AppendWhere('m.cd_produto='+String(ivl_Produto))
End If

If ivl_Motivo > 0 Then
	This.of_AppendWhere('m.cd_motivo_ajuste='+String(ivl_Motivo))
End If

Return AncestorReturnValue
end event

event dw_3::ue_sort;call super::ue_sort;This.Event RowFocusChanged(1)
end event

event dw_3::getfocus;call super::getfocus;ivm_menu.mf_SalvarComo(This.RowCount()>0)
end event

event dw_3::losefocus;call super::losefocus;ivm_menu.mf_SalvarComo(False)
end event

type dw_relatorio from dc_uo_dw_base within tabpage_1
integer x = 3049
integer y = 16
integer width = 306
integer height = 240
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge280_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;This.of_SetMenu(ivm_Menu)
end event

event ue_preprint;call super::ue_preprint;This.Object.st_periodo.Text = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(ivdh_inicio,'dd/mm/yyyy')+' $$HEX1$$e000$$ENDHEX$$ '+String(ivdh_fim,'dd/mm/yyyy')

Return AncestorReturnValue
end event

type tab_2 from tab within tabpage_2
event create ( )
event destroy ( )
integer x = 9
integer y = 716
integer width = 3511
integer height = 968
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_4 tabpage_4
tabpage_3 tabpage_3
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
end type

on tab_2.create
this.tabpage_4=create tabpage_4
this.tabpage_3=create tabpage_3
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.tabpage_8=create tabpage_8
this.Control[]={this.tabpage_4,&
this.tabpage_3,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8}
end on

on tab_2.destroy
destroy(this.tabpage_4)
destroy(this.tabpage_3)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
destroy(this.tabpage_8)
end on

event selectionchanged;Choose Case NewIndex
	Case 1
		Parent.Tab_2.Tabpage_4.dw_6.Event ue_Retrieve()
	Case 2
		Parent.Tab_2.Tabpage_3.dw_4.Event ue_Retrieve()
	Case 3
		Parent.Tab_2.Tabpage_5.dw_7.Event ue_Retrieve()
	Case 4
		Parent.Tab_2.Tabpage_6.dw_8.Event ue_Retrieve()
	Case 5
		Parent.Tab_2.Tabpage_7.dw_9.Event ue_Retrieve()
	Case 6
		Parent.Tab_2.Tabpage_8.dw_10.Event ue_Retrieve()
End Choose
end event

type tabpage_4 from userobject within tab_2
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3474
integer height = 852
long backcolor = 79741120
string text = "Ajustes"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_6 gb_6
dw_6 dw_6
end type

on tabpage_4.create
this.gb_6=create gb_6
this.dw_6=create dw_6
this.Control[]={this.gb_6,&
this.dw_6}
end on

on tabpage_4.destroy
destroy(this.gb_6)
destroy(this.dw_6)
end on

type gb_6 from groupbox within tabpage_4
integer x = 14
integer width = 3447
integer height = 844
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_6 from dc_uo_dw_base within tabpage_4
integer x = 32
integer y = 68
integer width = 3351
integer height = 744
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge280_lista_produto_ajuste"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.Of_SetRowSelection( )
end event

event itemchanged;//override
Long lvl_Linha
Long lvl_Produto

lvl_Linha 		= Tab_1.Tabpage_2.Dw_3.GetRow()
lvl_Produto	= Tab_1.Tabpage_2.Dw_3.Object.cd_produto [lvl_Linha]

Return This.Retrieve(ivdh_Inicio,ivdh_Fim,ivl_Filial,lvl_Produto)
end event

event ue_recuperar;//override
Long lvl_Linha
Long lvl_Produto

lvl_Linha		= Tab_1.Tabpage_2.Dw_3.GetRow()
If lvl_Linha > 0 Then
	lvl_Produto	= Tab_1.Tabpage_2.Dw_3.Object.cd_produto [lvl_Linha]
End If

Return This.Retrieve(ivdh_Inicio,ivdh_Fim,ivl_Filial,lvl_Produto)
end event

event ue_preretrieve;call super::ue_preretrieve;If ivl_Motivo > 0 Then
	This.of_AppendWhere('a.cd_motivo_ajuste='+String(ivl_Motivo))
End If

Return AncestorReturnValue
end event

event losefocus;call super::losefocus;ivm_menu.mf_SalvarComo(False)
end event

event getfocus;call super::getfocus;ivm_menu.mf_SalvarComo(This.RowCount()>0)
end event

type tabpage_3 from userobject within tab_2
integer x = 18
integer y = 100
integer width = 3474
integer height = 852
long backcolor = 79741120
string text = "Mov. Estoque"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_4 gb_4
dw_4 dw_4
end type

on tabpage_3.create
this.gb_4=create gb_4
this.dw_4=create dw_4
this.Control[]={this.gb_4,&
this.dw_4}
end on

on tabpage_3.destroy
destroy(this.gb_4)
destroy(this.dw_4)
end on

type gb_4 from groupbox within tabpage_3
integer x = 14
integer width = 3447
integer height = 840
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_4 from dc_uo_dw_base within tabpage_3
integer x = 27
integer y = 64
integer width = 3387
integer height = 748
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge280_lista_produto_mov_estoque"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;//override
Long lvl_Linha
Long lvl_Produto

DateTime lvdh_Inicio
DateTime lvdh_Fim

lvl_Linha		= Tab_1.Tabpage_2.Dw_3.GetRow()
If lvl_Linha > 0 Then
	lvl_Produto	= Tab_1.Tabpage_2.Dw_3.Object.cd_produto [lvl_Linha]
End If

lvdh_Inicio 	= Datetime(RelativeDate(Date(ivdh_Inicio),-5),Time('00:00'))
lvdh_Fim	 	= Datetime(RelativeDate(Date(lvdh_Fim),3),Time('23:59:59'))

Return This.Retrieve(lvdh_Inicio,ivdh_Fim,ivl_Filial,lvl_Produto)
end event

event constructor;call super::constructor;This.of_Setrowselection( )
end event

event losefocus;call super::losefocus;ivm_menu.mf_SalvarComo(False)
end event

event getfocus;call super::getfocus;ivm_menu.mf_SalvarComo(This.RowCount()>0)
end event

type tabpage_5 from userobject within tab_2
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3474
integer height = 852
long backcolor = 79741120
string text = "Canc. Venda"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_7 gb_7
dw_7 dw_7
end type

on tabpage_5.create
this.gb_7=create gb_7
this.dw_7=create dw_7
this.Control[]={this.gb_7,&
this.dw_7}
end on

on tabpage_5.destroy
destroy(this.gb_7)
destroy(this.dw_7)
end on

type gb_7 from groupbox within tabpage_5
integer x = 14
integer width = 3438
integer height = 844
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_7 from dc_uo_dw_base within tabpage_5
integer x = 27
integer y = 68
integer width = 3397
integer height = 748
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge280_lista_produto_cancelamento"
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.Of_SetRowSelection( )
end event

event itemchanged;//override
Long lvl_Linha
Long lvl_Produto

lvl_Linha 		= Tab_1.Tabpage_2.Dw_3.GetRow()
lvl_Produto	= Tab_1.Tabpage_2.Dw_3.Object.cd_produto [lvl_Linha]

Return This.Retrieve(ivdh_Inicio,ivdh_Fim,ivl_Filial,lvl_Produto)
end event

event ue_recuperar;//override
Long lvl_Linha
Long lvl_Produto

DateTime lvdh_Inicio

lvl_Linha		= Tab_1.Tabpage_2.Dw_3.GetRow()
If lvl_Linha > 0 Then
	lvl_Produto	= Tab_1.Tabpage_2.Dw_3.Object.cd_produto [lvl_Linha]
End If

lvdh_Inicio = Datetime(RelativeDate(Date(ivdh_Inicio),-30),Time('00:00'))

Return This.Retrieve(lvdh_Inicio,ivdh_Fim,ivl_Filial,lvl_Produto)
end event

event getfocus;call super::getfocus;ivm_menu.mf_SalvarComo(This.RowCount()>0)
end event

event losefocus;call super::losefocus;ivm_menu.mf_SalvarComo(False)
end event

type tabpage_6 from userobject within tab_2
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3474
integer height = 852
long backcolor = 79741120
string text = "Transf. Sa$$HEX1$$ed00$$ENDHEX$$da"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_9 gb_9
dw_8 dw_8
end type

on tabpage_6.create
this.gb_9=create gb_9
this.dw_8=create dw_8
this.Control[]={this.gb_9,&
this.dw_8}
end on

on tabpage_6.destroy
destroy(this.gb_9)
destroy(this.dw_8)
end on

type gb_9 from groupbox within tabpage_6
integer x = 14
integer width = 3442
integer height = 840
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_8 from dc_uo_dw_base within tabpage_6
integer x = 27
integer y = 68
integer width = 3406
integer height = 748
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge280_lista_produto_transf_saida"
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;//override
Long lvl_Linha
Long lvl_Produto

DateTime lvdh_Inicio
DateTime lvdh_Fim

lvl_Linha		= Tab_1.Tabpage_2.Dw_3.GetRow()
If lvl_Linha > 0 Then
	lvl_Produto	= Tab_1.Tabpage_2.Dw_3.Object.cd_produto [lvl_Linha]
End If

//Produto feito nota e n$$HEX1$$e300$$ENDHEX$$o enviado a filial destino
lvdh_Inicio 	= Datetime(RelativeDate(Date(ivdh_Inicio),-5),Time('00:00'))
//Produto separado (retirado prateleira) para enviar a outra filial
lvdh_Fim	 	= Datetime(RelativeDate(Date(lvdh_Fim),3),Time('23:59:59'))

Return This.Retrieve(lvdh_Inicio,ivdh_Fim,ivl_Filial,lvl_Produto)
end event

event constructor;call super::constructor;This.Of_SetRowSelection( )
end event

event getfocus;call super::getfocus;ivm_menu.mf_SalvarComo(This.RowCount()>0)

end event

event losefocus;call super::losefocus;ivm_menu.mf_SalvarComo(False)
end event

type tabpage_7 from userobject within tab_2
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3474
integer height = 852
long backcolor = 79741120
string text = "Transf. Entr."
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_8 gb_8
dw_9 dw_9
end type

on tabpage_7.create
this.gb_8=create gb_8
this.dw_9=create dw_9
this.Control[]={this.gb_8,&
this.dw_9}
end on

on tabpage_7.destroy
destroy(this.gb_8)
destroy(this.dw_9)
end on

type gb_8 from groupbox within tabpage_7
integer x = 14
integer width = 3438
integer height = 840
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_9 from dc_uo_dw_base within tabpage_7
integer x = 27
integer y = 68
integer width = 3401
integer height = 736
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge280_lista_produto_transf_entrada"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;//override
Long lvl_Linha
Long lvl_Produto

DateTime lvdh_Inicio
DateTime lvdh_Fim

lvl_Linha		= Tab_1.Tabpage_2.Dw_3.GetRow()
If lvl_Linha > 0 Then
	lvl_Produto	= Tab_1.Tabpage_2.Dw_3.Object.cd_produto [lvl_Linha]
End If

lvdh_Inicio 	= Datetime(RelativeDate(Date(ivdh_Inicio),-5),Time('00:00'))
lvdh_Fim	 	= Datetime(RelativeDate(Date(lvdh_Fim),3),Time('23:59:59'))

Return This.Retrieve(lvdh_Inicio,ivdh_Fim,ivl_Filial,lvl_Produto)
end event

event constructor;call super::constructor;This.Of_SetRowSelection( )
end event

event getfocus;call super::getfocus;ivm_menu.mf_SalvarComo(This.RowCount()>0)
end event

event losefocus;call super::losefocus;ivm_menu.mf_SalvarComo(False)
end event

type tabpage_8 from userobject within tab_2
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3474
integer height = 852
long backcolor = 79741120
string text = "Compra"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_10 gb_10
dw_10 dw_10
end type

on tabpage_8.create
this.gb_10=create gb_10
this.dw_10=create dw_10
this.Control[]={this.gb_10,&
this.dw_10}
end on

on tabpage_8.destroy
destroy(this.gb_10)
destroy(this.dw_10)
end on

type gb_10 from groupbox within tabpage_8
integer x = 14
integer width = 3438
integer height = 840
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_10 from dc_uo_dw_base within tabpage_8
integer x = 27
integer y = 68
integer width = 3392
integer height = 760
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge280_lista_produto_compra"
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;//override
Long lvl_Linha
Long lvl_Produto

DateTime lvdh_Inicio
DateTime lvdh_Fim

lvl_Linha		= Tab_1.Tabpage_2.Dw_3.GetRow()
If lvl_Linha > 0 Then
	lvl_Produto	= Tab_1.Tabpage_2.Dw_3.Object.cd_produto [lvl_Linha]
End If

lvdh_Inicio 	= Datetime(RelativeDate(Date(ivdh_Inicio),-5),Time('00:00'))
lvdh_Fim	 	= Datetime(RelativeDate(Date(lvdh_Fim),3),Time('23:59:59'))

Return This.Retrieve(lvdh_Inicio,ivdh_Fim,ivl_Filial,lvl_Produto)
end event

event constructor;call super::constructor;This.Of_SetRowSelection( )
end event

event getfocus;call super::getfocus;ivm_menu.mf_SalvarComo(This.RowCount()>0)
end event

event losefocus;call super::losefocus;ivm_menu.mf_SalvarComo(False)
end event

