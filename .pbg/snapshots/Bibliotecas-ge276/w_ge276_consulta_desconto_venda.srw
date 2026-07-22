HA$PBExportHeader$w_ge276_consulta_desconto_venda.srw
forward
global type w_ge276_consulta_desconto_venda from dc_w_2tab_consulta_selecao_lista_det
end type
type gb_4 from groupbox within tabpage_2
end type
type dw_vendas_funcionario from dc_uo_dw_base within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type gb_5 from groupbox within tabpage_3
end type
type gb_vendas from groupbox within tabpage_3
end type
type dw_vendas from dc_uo_dw_base within tabpage_3
end type
type dw_produtos_venda from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_5 gb_5
gb_vendas gb_vendas
dw_vendas dw_vendas
dw_produtos_venda dw_produtos_venda
end type
type dw_relatorio from dc_uo_dw_base within w_ge276_consulta_desconto_venda
end type
end forward

global type w_ge276_consulta_desconto_venda from dc_w_2tab_consulta_selecao_lista_det
string tag = "w_ge276_consulta_desconto_venda"
integer width = 4009
integer height = 2356
string title = "GE276 - Consulta Desconto Comercial de Venda"
dw_relatorio dw_relatorio
end type
global w_ge276_consulta_desconto_venda w_ge276_consulta_desconto_venda

type variables
uo_filial ivo_Filial

dc_uo_ds_base ivds_Prestes

Long ivl_Largura_3
Long ivl_Altura_3
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
	
	Tab_1.TabPage_1.dw_1.Object.cd_regiao[1] = 0
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o item 'TODAS' na coluna regi$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
End If

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
end subroutine

on w_ge276_consulta_desconto_venda.create
int iCurrent
call super::create
this.dw_relatorio=create dw_relatorio
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_relatorio
end on

on w_ge276_consulta_desconto_venda.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_relatorio)
end on

event ue_preopen;call super::ue_preopen;ivo_Filial = Create uo_Filial
ivds_Prestes = Create dc_uo_ds_base
ivds_Prestes.Of_ChangeDataObject('ds_ge276_desconto_prestes_filial')

dw_relatorio.Visible = False

ivm_menu.ivb_permite_imprimir = True
end event

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivds_Prestes)
end event

event ue_postopen;call super::ue_postopen;String lvs_Param
String lvs_Data

Date lvdt_Inicio
Date lvdt_Fim

lvs_Param = Message.StringParm

If (Trim(lvs_Param)<>'')and(not(IsNull(lvs_Param))) Then
	lvs_Data = Mid(lvs_Param,1,Pos(lvs_Param,';') - 1)
	If IsDate(lvs_Data) Then
		lvdt_Inicio = Date(lvs_Data)
	Else
		lvdt_Inicio	= RelativeDate(Today(),-1)
	End If

	lvs_Data = Mid(lvs_Param,Pos(lvs_Param,';') + 1)
	If IsDate(lvs_Data) Then
		lvdt_Fim = Date(lvs_Data)
	Else
		lvdt_Fim	= RelativeDate(Today(),-1)
	End If
Else
	lvdt_Inicio	= RelativeDate(Today(),-1)
	lvdt_Fim		= RelativeDate(Today(),-1)
End If

Tab_1.TabPage_1.dw_1.Object.dt_Inicio 	[1]	 = lvdt_Inicio
Tab_1.TabPage_1.dw_1.Object.dt_fim		[1] = lvdt_Fim

wf_insere_padrao()

//Valores Padr$$HEX1$$e300$$ENDHEX$$o da janela por Aba
ivl_Largura_1 = 3936
ivl_Largura_2 = 3936
ivl_Largura_3 = 3936
ivl_altura_1 = 2152
ivl_altura_2 = 2152
ivl_altura_3 = 2152

//Atribui valores Padr$$HEX1$$e300$$ENDHEX$$o da janela para abertura
Tab_1.Width	= ivl_Largura_1
Tab_1.Height	= ivl_altura_1
This.Width		= Tab_1.Width + 90
This.Height		= Tab_1.Height + 165	
end event

event ue_print;call super::ue_print;dw_relatorio.Event ue_Print()
end event

event ue_printimmediate;call super::ue_printimmediate;dw_relatorio.Event ue_PrintImmediate()
end event

event ue_saveas;call super::ue_saveas;dw_relatorio.Event ue_SaveAs()
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge276_consulta_desconto_venda
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge276_consulta_desconto_venda
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge276_consulta_desconto_venda
integer width = 3936
integer height = 2152
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_3=create tabpage_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_3
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_3)
end on

event tab_1::selectionchanging;//override
String lvs_Filial

Long lvl_Desconto
Long lvl_Linha

SetPointer(HourGlass!)

If TabPage_1.dw_2.GetRow() > 0 Then
	lvl_Linha			= TabPage_1.dw_2.GetRow()
	lvl_Desconto		= TabPage_1.dw_2.Object.qt_desc_geral	 	[lvl_Linha]
	lvs_Filial 			= TabPage_1.dw_2.Object.nm_fantasia 			[lvl_Linha] + &
							' ('+ String(TabPage_1.dw_2.Object.cd_filial [lvl_Linha])+')'
	
	If lvl_Desconto > 0 Then
		If NewIndex = 2 Then
			// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
			// das DW's de detalhes
			TabPage_2.dw_3.Event ue_Retrieve()
			TabPage_2.gb_3.Text = lvs_Filial
		ElseIf NewIndex = 3 Then
			// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
			// das DW's de detalhes
			TabPage_3.dw_vendas.Event ue_Retrieve()
			TabPage_3.gb_vendas.Text = lvs_Filial
		End If
		// Permite a troca do folder
		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ descontos concedidos pela filial registrados no per$$HEX1$$ed00$$ENDHEX$$odo.",Exclamation!)
		Return 1
	End If
ElseIf NewIndex <> 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", Exclamation!)
	// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
	Return 1
End If

SetPointer(Arrow!)
end event

event tab_1::selectionchanged;//override
SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		This.Width  = Parent.ivl_Largura_1
		This.Height = Parent.ivl_Altura_1
		
		ivm_menu.mf_imprimir(Tabpage_1.dw_2.RowCount() > 0)
		ivm_menu.mf_salvarcomo(Tabpage_1.dw_2.RowCount() > 0)
		
		TabPage_1.dw_2.SetFocus()
	Case 2
		This.Width  = Parent.ivl_Largura_2		
		This.Height = Parent.ivl_Altura_2
		
		ivm_menu.mf_imprimir(False)
		ivm_menu.mf_salvarcomo(False)
		
		TabPage_2.dw_3.SetFocus()
	Case 3
		This.Width  = Parent.ivl_Largura_3	
		This.Height = Parent.ivl_Altura_3
		
		ivm_menu.mf_imprimir(False)
		ivm_menu.mf_salvarcomo(False)
		
		TabPage_3.dw_vendas.SetFocus()
End Choose
	
Parent.Width  = This.Width + 90
Parent.Height = This.Height + 165			

SetPointer(Arrow!)
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 3899
integer height = 2036
string text = "Filiais"
end type

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer width = 3845
integer height = 1632
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 1774
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer width = 1691
string dataobject = "dw_ge276_selecao"
end type

event dw_1::ue_key;call super::ue_key;If key = KeyEnter! Then
	If Tab_1.TabPage_1.dw_1.GetColumnName() = "nm_filial" Then
		
		ivo_Filial.of_Localiza_Filial(GetText())
		
		If ivo_Filial.Localizada Then
			
			Tab_1.TabPage_1.dw_1.Object.cd_filial[1] = ivo_Filial.cd_filial
			Tab_1.TabPage_1.dw_1.Object.nm_filial[1] = ivo_Filial.nm_fantasia
			
			Tab_1.TabPage_1.dw_1.Object.cd_regiao[1] = 0
		End If
		
	End If
End If
end event

event dw_1::losefocus;call super::losefocus;If Not IsNull(Tab_1.TabPage_1.dw_1.Object.cd_filial[1]) Then
	If IsValid(ivo_Filial) Then
		Tab_1.TabPage_1.dw_1.Object.cd_filial[1] = ivo_Filial.cd_filial
		Tab_1.TabPage_1.dw_1.Object.nm_filial[1] = ivo_Filial.nm_fantasia
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "nm_filial" Then
	If data <> "" Then
		If Trim(Data) <> ivo_Filial.nm_fantasia Then
			Return 1 
		End If
	End If
End If

end event

event dw_1::editchanged;call super::editchanged;If dwo.Name = "nm_filial" Then
	If Data = "" or IsNull(Data) Then
		ivo_Filial.of_inicializa( )
		Tab_1.TabPage_1.dw_1.Object.cd_filial[1] = ivo_Filial.cd_filial
		Return 0
	End If
End If
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer width = 3762
integer height = 1520
string dataobject = "dw_ge276_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;//override
Date lvdt_Inicio
Date lvdt_Fim

Parent.dw_1.Accepttext( )

lvdt_Inicio	= Parent.dw_1.Object.dt_inicio	[1]
lvdt_Fim		= Parent.dw_1.Object.dt_fim	[1]

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Filial 
Long lvl_regiao

Parent.dw_1.Accepttext( )

lvl_Filial 		= Parent.dw_1.Object.cd_filial 		[1]
lvl_Regiao 	= Parent.dw_1.Object.cd_regiao	[1]

If lvl_Filial > 0 Then
	This.of_appendwhere_subquery('r.cd_filial = '+String(lvl_Filial),2)
	This.of_appendwhere_subquery('nf1.cd_filial = '+String(lvl_Filial),1)
End If

If lvl_Regiao > 0 Then
	This.of_appendwhere_subquery('f.cd_regiao = '+String(lvl_Regiao),2)
	This.of_appendwhere_subquery('f1.cd_regiao = '+String(lvl_Regiao),1)
End If

ivm_menu.mf_imprimir(False)
ivm_menu.mf_salvarcomo(False)

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long lvl_Filial
Long lvl_Linha

Date lvdt_Inicio
Date lvdt_Fim

Tab_1.TabPage_1.dw_1.Accepttext( )

lvdt_Inicio	= Tab_1.TabPage_1.dw_1.Object.dt_inicio		[1]
lvdt_Fim		= Tab_1.TabPage_1.dw_1.Object.dt_fim			[1]

Open(w_aguarde)
w_aguarde.Title = 'Recuperando Vendas de Produtos Prestes a Vencer'
w_aguarde.uo_progress.of_SetMax(This.RowCount())
For lvl_Linha = 1 To This.RowCount()
	lvl_Filial = This.Object.cd_filial [lvl_Linha]
	If ivds_Prestes.Retrieve(lvdt_Inicio, lvdt_Fim, lvl_Filial) > 0 Then 
		This.Object.vl_desconto_pve [lvl_Linha] = ivds_Prestes.Object.vl_desconto[1]
	End If
	w_aguarde.uo_progress.of_SetProgress(lvl_Linha)
Next
Close(w_Aguarde)

ivm_menu.mf_imprimir(pl_linhas > 0)
ivm_menu.mf_salvarcomo(pl_linhas > 0)

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;This.ShareData(dw_relatorio)
end event

event dw_2::ue_reset;call super::ue_reset;ivm_menu.mf_imprimir(False)
ivm_menu.mf_salvarcomo(False)
end event

event dw_2::clicked;call super::clicked;If This.RowCount() > 0 and ivb_Ordena_Colunas and Row = 0 Then
	This.Event RowFocusChanged(1)
End If
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 3899
integer height = 2036
string text = "Funcion$$HEX1$$e100$$ENDHEX$$rios"
gb_4 gb_4
dw_vendas_funcionario dw_vendas_funcionario
end type

on tabpage_2.create
this.gb_4=create gb_4
this.dw_vendas_funcionario=create dw_vendas_funcionario
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.dw_vendas_funcionario
end on

on tabpage_2.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.dw_vendas_funcionario)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 3845
integer height = 644
string text = "Filial:"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer y = 84
integer width = 3762
integer height = 556
string dataobject = "dw_ge276_desconto_funcionario"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_3::ue_recuperar;//override
Long lvl_Filial
Long lvl_Linha

Date lvdt_Inicio
Date lvdt_Fim

Tab_1.TabPage_1.dw_1.Accepttext( )

lvl_Linha		= Tab_1.TabPage_1.dw_2.GetRow()
lvl_Filial		= Tab_1.TabPage_1.dw_2.Object.cd_filial	[lvl_Linha]
lvdt_Inicio	= Tab_1.TabPage_1.dw_1.Object.dt_inicio	[1]
lvdt_Fim		= Tab_1.TabPage_1.dw_1.Object.dt_fim		[1]

Return This.Retrieve(lvdt_Inicio,lvdt_Fim,lvl_Filial)
end event

event dw_3::ue_postretrieve;//override
If pl_Linhas > 0 Then
	Parent.dw_vendas_funcionario.Event ue_Retrieve()
End If

Return pl_Linhas
end event

event dw_3::rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	Parent.dw_vendas_funcionario.Event ue_Retrieve()
End If
end event

event dw_3::constructor;call super::constructor;This.of_setrowselection( )
end event

event dw_3::clicked;call super::clicked;If This.RowCount() > 0 and ivb_Ordena_Colunas and Row = 0 Then
	Parent.dw_vendas_funcionario.Event ue_Retrieve()
End If
end event

type gb_4 from groupbox within tabpage_2
integer x = 23
integer y = 664
integer width = 3845
integer height = 1348
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Notas"
end type

type dw_vendas_funcionario from dc_uo_dw_base within tabpage_2
integer x = 59
integer y = 720
integer width = 3762
integer height = 1268
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge276_desconto_funcionario_nf"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event itemchanged;//override
Long lvl_Linha
Long lvl_Filial

String lvs_Matricula

Date lvdt_Inicio
Date lvdt_Fim

Tab_1.TabPage_1.dw_1.Accepttext() 

lvl_Linha			= Parent.dw_3.GetRow()
lvl_Filial			= Parent.dw_3.Object.cd_filial			[lvl_Linha]
lvs_Matricula	= Parent.dw_3.Object.nr_matricula	[lvl_Linha]

lvdt_Inicio	= Tab_1.TabPage_1.dw_1.Object.dt_inicio	[1]
lvdt_Fim		= Tab_1.TabPage_1.dw_1.Object.dt_fim		[1]

Return This.Retrieve(lvdt_Inicio,lvdt_Fim,lvl_Filial,lvs_Matricula)
end event

event constructor;call super::constructor;This.of_setrowselection( )
end event

event ue_recuperar;//override
Long lvl_Filial
Long lvl_Linha

String lvs_Matricula

Date lvdt_Inicio
Date lvdt_Fim

Tab_1.TabPage_1.dw_1.Accepttext( )

lvl_Linha			= Parent.dw_3.GetRow()
lvl_Filial			= Parent.dw_3.Object.cd_filial			[lvl_Linha]
lvs_Matricula	= Parent.dw_3.Object.nr_matricula	[lvl_Linha]
lvdt_Inicio		= Tab_1.TabPage_1.dw_1.Object.dt_inicio	[1]
lvdt_Fim			= Tab_1.TabPage_1.dw_1.Object.dt_fim		[1]

Return This.Retrieve(lvdt_Inicio,lvdt_Fim,lvl_Filial,lvs_Matricula)
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3899
integer height = 2036
long backcolor = 67108864
string text = "Vendas"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
gb_5 gb_5
gb_vendas gb_vendas
dw_vendas dw_vendas
dw_produtos_venda dw_produtos_venda
end type

on tabpage_3.create
this.gb_5=create gb_5
this.gb_vendas=create gb_vendas
this.dw_vendas=create dw_vendas
this.dw_produtos_venda=create dw_produtos_venda
this.Control[]={this.gb_5,&
this.gb_vendas,&
this.dw_vendas,&
this.dw_produtos_venda}
end on

on tabpage_3.destroy
destroy(this.gb_5)
destroy(this.gb_vendas)
destroy(this.dw_vendas)
destroy(this.dw_produtos_venda)
end on

type gb_5 from groupbox within tabpage_3
integer x = 23
integer y = 1232
integer width = 3849
integer height = 784
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Itens NF"
borderstyle borderstyle = styleraised!
end type

type gb_vendas from groupbox within tabpage_3
integer x = 23
integer y = 12
integer width = 3845
integer height = 1204
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Filial:"
borderstyle borderstyle = styleraised!
end type

type dw_vendas from dc_uo_dw_base within tabpage_3
integer x = 69
integer y = 76
integer width = 3771
integer height = 1116
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge276_desconto_nf"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;//override
Long lvl_Filial
Long lvl_Linha

Date lvdt_Inicio
Date lvdt_Fim

Tab_1.TabPage_1.dw_1.Accepttext( )

lvl_Linha		= Tab_1.TabPage_1.dw_2.GetRow()
lvl_Filial		= Tab_1.TabPage_1.dw_2.Object.cd_filial	[lvl_Linha]
lvdt_Inicio	= Tab_1.TabPage_1.dw_1.Object.dt_inicio	[1]
lvdt_Fim		= Tab_1.TabPage_1.dw_1.Object.dt_fim		[1]

Return This.Retrieve(lvdt_Inicio,lvdt_Fim,lvl_Filial)
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	Parent.dw_produtos_venda.Event ue_Retrieve()
End If

Return AncestorReturnValue
end event

event rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	Parent.dw_produtos_venda.Event ue_Retrieve()
End If
end event

event constructor;call super::constructor;This.of_setrowselection( )
end event

event ue_sort;call super::ue_sort;If This.GetRow() > 0 Then
	Parent.dw_produtos_venda.Event ue_Retrieve()
End If
end event

event clicked;call super::clicked;If This.RowCount() > 0 and ivb_Ordena_Colunas and Row = 0 Then
	Parent.dw_produtos_venda.Event ue_Retrieve()
End If
end event

type dw_produtos_venda from dc_uo_dw_base within tabpage_3
integer x = 69
integer y = 1276
integer width = 3767
integer height = 724
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge276_desconto_item_nf"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;//override
Long lvl_Linha
Long lvl_Filial
Long lvl_NF

String lvs_Serie
String lvs_Especie

lvl_Linha		= Parent.dw_vendas.GetRow()
lvl_Filial		= Parent.dw_vendas.Object.cd_filial		[lvl_Linha]
lvl_NF			= Parent.dw_vendas.Object.nr_nf			[lvl_Linha]
lvs_Serie		= Parent.dw_vendas.Object.de_serie		[lvl_Linha]
lvs_Especie	= Parent.dw_vendas.Object.de_especie	[lvl_Linha]

Return This.Retrieve(lvl_Filial,lvl_NF,lvs_Serie,lvs_Especie)
end event

event constructor;call super::constructor;This.of_setrowselection( )
end event

type dw_relatorio from dc_uo_dw_base within w_ge276_consulta_desconto_venda
integer x = 2990
integer y = 12
integer width = 361
integer height = 176
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge276_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;Date lvdt_Inicio
Date lvdt_Fim

Tab_1.Tabpage_1.dw_1.Accepttext( )

lvdt_Inicio	= Tab_1.Tabpage_1.dw_1.Object.dt_inicio	[1]
lvdt_Fim		= Tab_1.Tabpage_1.dw_1.Object.dt_fim		[1]

Return AncestorReturnValue
end event

