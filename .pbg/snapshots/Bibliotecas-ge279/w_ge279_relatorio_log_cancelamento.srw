HA$PBExportHeader$w_ge279_relatorio_log_cancelamento.srw
forward
global type w_ge279_relatorio_log_cancelamento from dc_w_sheet
end type
type tab_1 from tab within w_ge279_relatorio_log_cancelamento
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
type cb_salvar from commandbutton within tabpage_1
end type
type tabpage_1 from userobject within tab_1
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
cb_salvar cb_salvar
end type
type tabpage_2 from userobject within tab_1
end type
type gb_3 from groupbox within tabpage_2
end type
type dw_3 from dc_uo_dw_base within tabpage_2
end type
type tabpage_2 from userobject within tab_1
gb_3 gb_3
dw_3 dw_3
end type
type tabpage_3 from userobject within tab_1
end type
type gb_4 from groupbox within tabpage_3
end type
type dw_4 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_4 gb_4
dw_4 dw_4
end type
type tab_1 from tab within w_ge279_relatorio_log_cancelamento
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type dw_5 from dc_uo_dw_base within w_ge279_relatorio_log_cancelamento
end type
type dw_6 from dc_uo_dw_base within w_ge279_relatorio_log_cancelamento
end type
end forward

global type w_ge279_relatorio_log_cancelamento from dc_w_sheet
integer width = 3822
integer height = 1800
string title = "GE279 - Relat$$HEX1$$f300$$ENDHEX$$rio de Cancelamentos Fiscais"
boolean resizable = false
long backcolor = 80269524
event ue_retrieve ( )
event type long ue_preprint ( )
tab_1 tab_1
dw_5 dw_5
dw_6 dw_6
end type
global w_ge279_relatorio_log_cancelamento w_ge279_relatorio_log_cancelamento

type variables
uo_filial ivo_filial

long ivl_filial

date ivd_inicio  ,&
        ivd_termino

string ivs_nm_fantasia

long ivl_altura_1,   &
        ivl_altura_2,   &
        ivl_altura_3,   &
        ivl_largura_1, &
        ivl_largura_2, &
        ivl_largura_3

end variables

event ue_retrieve;Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
end event

on w_ge279_relatorio_log_cancelamento.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_5=create dw_5
this.dw_6=create dw_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_5
this.Control[iCurrent+3]=this.dw_6
end on

on w_ge279_relatorio_log_cancelamento.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.dw_5)
destroy(this.dw_6)
end on

event ue_postopen;call super::ue_postopen;String lvs_Param
String lvs_Data

Date lvdt_Inicio
Date lvdt_Fim

Long lvl_Regiao

Long lvl_Tipo
Long lvl_Mostra

ivo_Filial = Create uo_Filial

Tab_1.TabPage_1.dw_1.Event ue_AddRow()
Tab_1.TabPage_1.dw_1.SetFocus()

lvs_Param = Message.StringParm

//Parametros passados pela GE278
If (Trim(lvs_Param)<>'')and(not(IsNull(lvs_Param))) Then
	lvs_Data = Mid(lvs_Param,1,Pos(lvs_Param,';') - 1)
	If IsDate(lvs_Data) Then
		lvdt_Inicio = Date(lvs_Data)
	Else
		lvdt_Inicio	= Today()		
	End If

	lvs_Param = Mid(lvs_Param,Pos(lvs_Param,';') + 1)
	lvs_Data = Mid(lvs_Param,1,Pos(lvs_Param,';') - 1)
	If IsDate(lvs_Data) Then
		lvdt_Fim = Date(lvs_Data)
	Else
		lvdt_Fim	= Today()		
	End If
	
	lvs_Param 	= Mid(lvs_Param,Pos(lvs_Param,';') + 1)
	lvs_Data 		= Mid(lvs_Param,1,Pos(lvs_Param,';') - 1)
	lvl_Tipo 		=	Long(lvs_Data)
	
	lvs_Param 	= Mid(lvs_Param,Pos(lvs_Param,';') + 1)
	lvs_Data 		= Mid(lvs_Param,1,Pos(lvs_Param,';') - 1)
	lvl_Mostra 	=	Long(lvs_Data)
	
	If (lvl_Tipo = 1) Then  //Por Quantidade
		Tab_1.Tabpage_1.dw_2.SetSort('pc_qtde desc')
	Else //Por Valor
		Tab_1.Tabpage_1.dw_2.SetSort('pc_valor desc')
	End If
Else
	lvdt_Inicio	= Today()
	lvdt_Fim		= Today()
End If

Tab_1.TabPage_1.dw_1.Object.dt_Inicio 	[1] = lvdt_Inicio
Tab_1.TabPage_1.dw_1.Object.dt_Termino	[1] = lvdt_Fim

This.ivm_Menu.ivb_Permite_Imprimir = True

// Coloca o item TODAS
DataWindowChild ldw_Child

If Tab_1.TabPage_1.dw_1.GetChild("cd_regiao", ldw_Child) = 1 Then
	
	ldw_Child.InsertRow(1)

	ldw_Child.SetItem(1,"cd_regiao",0)
	ldw_Child.SetItem(1,"de_regiao","TODAS")
	
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
end event

event close;call super::close;Destroy(ivo_Filial)
end event

event open;call super::open;Tab_1.TabPage_1.dw_1.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_1.dw_2.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_3.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_4.of_SetMenu(This.ivm_Menu)

Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Recuperar(True)
Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Recuperar(True)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Recuperar(False)
Tab_1.TabPage_3.dw_4.ivo_Controle_Menu.of_Recuperar(False)

Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Classificar(True)
Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Filtrar(True)

Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Classificar(True)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Filtrar(True)

Tab_1.TabPage_3.dw_4.ivo_Controle_Menu.of_Filtrar(True)
end event

event ue_preopen;call super::ue_preopen;This.ivl_Altura_1  = This.Height
This.ivl_Largura_1 = This.Width

ivl_Largura_1 = 3776
ivl_Altura_1  = 1620

ivl_Largura_2 = 2546
ivl_Altura_2  = 1620

ivl_Largura_3 = 2875
ivl_Altura_3  = 1620

end event

type tab_1 from tab within w_ge279_relatorio_log_cancelamento
integer x = 5
integer width = 3776
integer height = 1620
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

event selectionchanged;SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		This.Width  = Parent.ivl_Largura_1
		This.Height = Parent.ivl_Altura_1
		
		Tab_1.TabPage_1.dw_2.SetFocus()
	Case 2
		This.Width  = Parent.ivl_Largura_2		
		This.Height = Parent.ivl_Altura_2
		
		Tab_1.TabPage_2.dw_3.SetFocus()
	Case 3
		This.Width  = Parent.ivl_Largura_3		
		This.Height = Parent.ivl_Altura_3
		
		Tab_1.TabPage_3.dw_4.SetFocus()
End Choose
	
Parent.Width  = This.Width + 45
Parent.Height = This.Height + 110			

SetPointer(Arrow!)
end event

event selectionchanging;
Choose Case NewIndex
	Case 2
		
		If oldindex = 3 Then
		
		Else
				
			IF Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
				
				Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
				// Permite a troca de folder
				Return 0
			Else
				
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os produtos.", StopSign!)
				// N$$HEX1$$e300$$ENDHEX$$o permite a troca de folder
				Return 1
			End If
		
		End If
		
	Case 3
		
		If oldindex = 2 Then
			
			IF Tab_1.TabPage_2.dw_3.GetRow() > 0 Then
				
				Tab_1.TabPage_2.dw_3.Event rowfocuschanged(1)
							
				Tab_1.TabPage_3.dw_4.Event ue_Retrieve()
				// Permite a troca de folder
				Return 0
			End If
		Else
			
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o produto para visualizar os detalhes.", StopSign!)			
			
			SelectTab(2)
			Tab_1.TabPage_2.SetFocus()
			
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca de folder			
			Return 1
		End If
End Choose

end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3739
integer height = 1504
long backcolor = 80269524
string text = "Filiais"
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
cb_salvar cb_salvar
end type

on tabpage_1.create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_salvar=create cb_salvar
this.Control[]={this.gb_2,&
this.gb_1,&
this.dw_1,&
this.dw_2,&
this.cb_salvar}
end on

on tabpage_1.destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_salvar)
end on

type gb_2 from groupbox within tabpage_1
integer x = 14
integer y = 372
integer width = 3703
integer height = 1120
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Filiais"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within tabpage_1
integer x = 14
integer y = 16
integer width = 2537
integer height = 332
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
integer x = 41
integer y = 80
integer width = 2496
integer height = 236
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge279_selecao"
end type

event ue_key;If key = KeyEnter! Then
	If This.GetColumnName() = "nm_filial" Then
		
		ivo_Filial.of_Localiza_Filial(GetText())
		
		If ivo_Filial.Localizada Then
			
			This.Object.cd_filial	[1] = ivo_Filial.cd_filial
			This.Object.nm_filial	[1] = ivo_Filial.nm_fantasia
			This.Object.cd_regiao	[1] = 0
		End If
		
	End If
End If
end event

event losefocus;call super::losefocus;If Not IsNull(This.Object.cd_filial[1]) Then
	If IsValid(ivo_Filial) Then
		This.Object.cd_filial	[1] = ivo_Filial.cd_filial
		This.Object.nm_filial	[1] = ivo_Filial.nm_fantasia
	End If
End If
end event

event itemchanged;call super::itemchanged;If dwo.Name = "nm_filial" Then
	If data <> "" Then
		If Trim(Data) <> ivo_Filial.nm_fantasia Then
			Return 1 
		End If
	End If
End If

If Dwo.Name = "cd_regiao" Then
	ivo_Filial.of_Inicializa()
	This.Object.cd_filial	[1] = ivo_Filial.cd_filial
	This.Object.nm_filial	[1] = ivo_Filial.nm_fantasia
End If

Parent.dw_2.Reset()
cb_salvar.Enabled = False
end event

event editchanged;call super::editchanged;Long lvl_Nulo

String lvs_Nulo

If dwo.Name = "nm_filial" Then
	If Data = "" or IsNull(Data) Then
		SetNull(lvl_Nulo)
		Tab_1.TabPage_1.dw_1.Object.cd_filial[1] = lvl_Nulo
		Return 0
	End If
End If

If dwo.Name = "cd_regiao" Then
	SetNull(lvl_Nulo)
	SetNull(lvs_Nulo)
	Tab_1.TabPage_1.dw_1.Object.cd_filial[1]   = lvl_Nulo
	Tab_1.TabPage_1.dw_1.Object.nm_filial[1] = lvs_Nulo
End If

Tab_1.TabPage_1.dw_2.Reset()
cb_salvar.Enabled = False
end event

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

type dw_2 from dc_uo_dw_base within tabpage_1
integer x = 50
integer y = 428
integer width = 3621
integer height = 1024
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge279_lista_filial"
boolean vscrollbar = true
end type

event ue_recuperar;//OverRide
Parent.dw_1.AcceptText()

ivd_Inicio		= Parent.dw_1.Object.dt_Inicio 	[1]
ivd_Termino	= Parent.dw_1.Object.dt_Termino	[1] 

Return Retrieve(ivd_Inicio, ivd_Termino)
end event

event constructor;call super::constructor;This.ShareData(dw_5)

This.of_SetRowSelection()

String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_filial", "nm_fantasia", "qtde_produto", "qtde_cancelamento", "qtde_venda","pc_qtde", "vlr_cancelamento","vlr_venda", "pc_valor"}

lvs_Nome = {"Filial", "Fantasia", "Produtos", "Qtde. Canc.", "Qtde. Venda", "% Qtde", "Valor Canc.","Valor Venda", "% Valor"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)	
This.ivb_ordena_colunas = True
end event

event ue_postretrieve;Boolean lvb_Imprimir

If pl_Linhas > 0 Then

	lvb_Imprimir = True

	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
	
	cb_salvar.Enabled = True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	
	cb_salvar.Enabled = False
End If

This.ivo_Controle_Menu.of_Imprimir(lvb_Imprimir)

Return pl_Linhas
end event

event rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	ivl_Filial      = Tab_1.TabPage_1.dw_2.Object.cd_filial  [CurrentRow]
	ivs_nm_fantasia = Tab_1.TabPage_1.dw_2.Object.nm_fantasia[CurrentRow]
End If


end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_printimmediate;//OVERRIDE

dw_5.Event ue_Print()

end event

event clicked;call super::clicked;If This.RowCount() > 0 and ivb_Ordena_Colunas and Row = 0 Then
	This.Event RowFocusChanged(1)
End If
end event

event ue_preretrieve;call super::ue_preretrieve;//OverRide
//Se adicionar novos filtros, lembrar de tratar no bot$$HEX1$$e300$$ENDHEX$$o "Salvar Excel"
Long lvl_Filial

Integer lvi_Regiao

String lvs_Prox_Venda

Parent.dw_1.AcceptText()

ivd_Inicio			= Parent.dw_1.Object.dt_Inicio 		[1]
ivd_Termino		= Parent.dw_1.Object.dt_Termino		[1] 
lvl_Filial			= Parent.dw_1.Object.cd_filial 			[1] 
lvi_Regiao		= Parent.dw_1.Object.cd_regiao 		[1] 
lvs_Prox_Venda= Parent.dw_1.Object.id_prox_venda [1] 

If IsNull(ivd_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data inicial.", StopSign!)
	Parent.dw_1.Event ue_Pos(1, "dt_inicio")
	Parent.dw_1.SetFocus()
	Return -1
End If

If IsNull(ivd_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data final.", StopSign!)
	Parent.dw_1.Event ue_Pos(1, "dt_termino")
	Parent.dw_1.SetFocus()
	Return -1
End If

If Not IsNull(lvl_Filial) Then
	This.of_appendwhere_subquery("f.cd_filial = " + String(lvl_Filial),3)
	This.of_appendwhere_subquery("nf1.cd_filial = " + String(lvl_Filial),2)
	This.of_appendwhere_subquery("lo1.cd_filial = " + String(lvl_Filial),1)
End If

If lvi_Regiao > 0 Then
	This.of_appendwhere_subquery("rg.cd_regiao = " + String(lvi_Regiao),3)
End If

If lvs_Prox_Venda = 'S' Then
	This.of_appendwhere_subquery("not exists (	select i2.cd_produto " + &
																"from nf_venda n2 " + &
																"inner join item_nf_venda i2 " + &
																	"on i2.cd_filial = n2.cd_filial " + &
																	"and i2.nr_nf = n2.nr_nf " + &
																	"and i2.de_serie = n2.de_serie " + &
																	"and i2.de_especie = n2.de_especie " + &
																"where n2.dh_movimentacao_caixa = lo1.dh_movimentacao_caixa " + &
																	"and n2.cd_filial = lo1.cd_filial " + &
																	"and n2.dh_emissao between lo1.dh_cancelamento and dateadd(mi,7,lo1.dh_cancelamento) " + &
																	"and i2.cd_produto = lo1.cd_produto " + &
																	"and n2.cd_caixa = lo1.cd_caixa " + &
																	"and n2.nr_controle_caixa = lo1.nr_controle_caixa " + &
																	"and n2.nr_ecf = lo1.nr_ecf"+&
																	")",1)
End If
											
Return AncestorReturnValue
end event

type cb_salvar from commandbutton within tabpage_1
integer x = 2583
integer y = 248
integer width = 526
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Salvar em Excel"
end type

event clicked;Boolean lvb_Sucesso = True

Date lvd_Inicio
Date lvd_Termino

Long lvl_Filial
Long lvl_Linha
Long lvl_Regiao

String lvs_Arquivo
String lvs_Nome_Arquivo
String ls_Filiais
String lvs_Prox_Venda

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja salvar as informa$$HEX2$$e700f500$$ENDHEX$$es em excel da(s) filial(is) listada(s) ?", Question!, OkCancel!,2) = 2 Then
	Return
End If

SetPointer( HourGlass! )

Tab_1.TabPage_1.dw_2.AcceptText()

dc_uo_ds_base lvds
lvds = Create dc_uo_ds_base

If Not lvds.of_ChangeDataObject("ds_ge279_detalhe_produto_excel") Then
	Destroy(lvds)
	SetPointer(Arrow!)
	Return
End If

lvd_Inicio  		= Tab_1.TabPage_1.dw_1.Object.dt_Inicio			[1]
lvd_Termino 	= Tab_1.TabPage_1.dw_1.Object.dt_Termino		[1]
lvl_Filial			= Tab_1.TabPage_1.dw_1.Object.cd_filial			[1]
lvs_Prox_Venda= Tab_1.TabPage_1.dw_1.Object.id_prox_venda	[1]
lvl_Regiao		= Tab_1.TabPage_1.dw_1.Object.cd_regiao		[1]

If Not IsNull( lvl_Filial ) Then
	ls_Filiais 				= String( lvl_Filial )
	lvs_Nome_Arquivo 	= Tab_1.TabPage_1.dw_1.Object.nm_filial	[1]
Else
	
	For lvl_Linha = 1 To Tab_1.TabPage_1.dw_2.RowCount()
		If lvl_Linha = Tab_1.TabPage_1.dw_2.RowCount() Then
			ls_Filiais	+= String(Tab_1.TabPage_1.dw_2.Object.cd_Filial  [lvl_Linha])
		Else
			ls_Filiais	+= String(Tab_1.TabPage_1.dw_2.Object.cd_Filial  [lvl_Linha]) + ", "
		End If
	Next
	
	lvs_Nome_Arquivo = "CANCELAMENTOS_FISCAIS"
	
End If

If lvs_Prox_Venda = 'S' Then
	lvds.of_appendwhere_subquery("not exists (	select i2.cd_produto " + &
																"from nf_venda n2 " + &
																"inner join item_nf_venda i2 " + &
																	"on i2.cd_filial = n2.cd_filial " + &
																	"and i2.nr_nf = n2.nr_nf " + &
																	"and i2.de_serie = n2.de_serie " + &
																	"and i2.de_especie = n2.de_especie " + &
																"where n2.dh_movimentacao_caixa = l.dh_movimentacao_caixa " + &
																	"and n2.cd_filial = l.cd_filial " + &
																	"and n2.dh_emissao between l.dh_cancelamento and dateadd(mi,7,l.dh_cancelamento) " + &
																	"and i2.cd_produto = l.cd_produto " + &
																	"and n2.cd_caixa = l.cd_caixa " + &
																	"and n2.nr_controle_caixa = l.nr_controle_caixa " + &
																	"and n2.nr_ecf = l.nr_ecf"+&
																	")",1)
End If

If lvl_Regiao > 0 Then
	lvds.of_AppendWhere( "f.cd_regiao="+String(lvl_Regiao) )
End If

lvds.of_AppendWhere( "l.cd_filial in (" + ls_Filiais + ")" )

lvs_Arquivo = gvo_Aplicacao.ivs_Path_Arquivos + lvs_Nome_Arquivo + " - " + &
					  String( lvd_Inicio, "ddmm") + " ate " + String( lvd_Termino, "ddmm") +  ".XLS"
					  
If lvds.Retrieve( lvd_Inicio, lvd_Termino) > 0 Then
	lvds.of_exporta_excel(lvs_Arquivo)
	/*If lvds.SaveAs(lvs_Arquivo, XLSX! , True) = -1 Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao salvar o arquivo.", StopSign!)
		lvb_Sucesso = False
	End If*/
End If

/*If lvb_Sucesso Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo gerado com sucesso.~r" + &
					Upper(lvs_Arquivo) + ".", Information!)
End If*/

Destroy(lvds)
SetPointer(Arrow!)

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3739
integer height = 1504
long backcolor = 80269524
string text = "Produtos"
long tabbackcolor = 80269524
long picturemaskcolor = 553648127
gb_3 gb_3
dw_3 dw_3
end type

on tabpage_2.create
this.gb_3=create gb_3
this.dw_3=create dw_3
this.Control[]={this.gb_3,&
this.dw_3}
end on

on tabpage_2.destroy
destroy(this.gb_3)
destroy(this.dw_3)
end on

type gb_3 from groupbox within tabpage_2
integer x = 14
integer y = 16
integer width = 2478
integer height = 1468
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Lista de Produtos"
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within tabpage_2
integer x = 46
integer y = 84
integer width = 2418
integer height = 1372
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge279_lista_produto"
boolean vscrollbar = true
end type

event ue_recuperar;//OverRide
String lvs_Prox_Venda

Tab_1.TabPage_1.Dw_1.accepttext( )
lvs_Prox_Venda= Tab_1.TabPage_1.dw_1.Object.id_prox_venda [1] 

If lvs_Prox_Venda = 'S' Then
	This.of_appendwhere_subquery("not exists (	select i2.cd_produto " + &
																"from nf_venda n2 " + &
																"inner join item_nf_venda i2 " + &
																	"on i2.cd_filial = n2.cd_filial " + &
																	"and i2.nr_nf = n2.nr_nf " + &
																	"and i2.de_serie = n2.de_serie " + &
																	"and i2.de_especie = n2.de_especie " + &
																"where n2.dh_movimentacao_caixa = lo.dh_movimentacao_caixa " + &
																	"and n2.cd_filial = lo.cd_filial " + &
																	"and n2.dh_emissao between lo.dh_cancelamento and dateadd(mi,5,lo.dh_cancelamento) " + &
																	"and i2.cd_produto = lo.cd_produto " + &
																	"and n2.cd_caixa = lo.cd_caixa " + &
																	"and n2.nr_controle_caixa = lo.nr_controle_caixa " + &
																	"and n2.nr_ecf = lo.nr_ecf)",1)
End If

Return Retrieve(ivd_Inicio, ivd_Termino, ivl_Filial)


end event

event constructor;call super::constructor;This.ShareData(dw_6)

This.of_SetRowSelection()

String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_produto","de_produto", "qtde_cancelamentos", "qtde_cancelados", "vl_cancelamento"}

lvs_Nome = {"Produto", "Descri$$HEX2$$e700e300$$ENDHEX$$o", "Cancelamentos", "Qtde.", "Valor"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)	
end event

event ue_postretrieve;Boolean lvb_Imprimir = False

If pl_Linhas > 0 Then
		
	lvb_Imprimir = True

	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

This.ivo_Controle_Menu.of_Imprimir(lvb_Imprimir)

If This.RowCount() > 0 Then
	Tab_1.TabPage_2.dw_3.Object.st_filial.text = ivs_nm_fantasia + " (" + String(ivl_Filial) + ")"
End If

Return pl_Linhas
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_printimmediate;//OVERRIDE

dw_6.Event ue_Print()

end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3739
integer height = 1504
long backcolor = 80269524
string text = "Detalhes do Produto"
long tabbackcolor = 80269524
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
integer x = 18
integer y = 20
integer width = 2802
integer height = 1464
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Detalhes do Produto"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within tabpage_3
integer x = 55
integer y = 88
integer width = 2734
integer height = 1360
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge279_detalhe_produto"
boolean vscrollbar = true
end type

event ue_recuperar;// OverRide

Long lvl_Produto, &
     lvl_Linha


lvl_Linha =  Tab_1.TabPage_2.dw_3.GetRow()

If lvl_Linha > 0 Then
	lvl_Produto = Tab_1.TabPage_2.dw_3.Object.cd_produto[lvl_Linha]
End If

Return This.Retrieve(ivd_inicio,ivd_termino,ivl_filial,lvl_Produto)

end event

event ue_postretrieve;This.Object.st_responsavel.text

If This.RowCount() > 0 Then
	
	This.Object.st_responsavel.text = This.Object.nm_usuario[1] + " (" +&
												 This.Object.nr_matricula_responsavel[1] + ")"
	
	Tab_1.TabPage_3.dw_4.Object.st_Produto.text = Tab_1.TabPage_2.dw_3.Object.de_produto[Tab_1.TabPage_2.dw_3.GetRow()] + &
													 			" (" + String(Tab_1.TabPage_2.dw_3.Object.cd_produto[Tab_1.TabPage_2.dw_3.GetRow()]) + ")"
End If

Return 1
end event

event constructor;call super::constructor;This.of_SetRowSelection()


String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"nr_matricula_responsavel"}

lvs_Nome = {"Respons$$HEX1$$e100$$ENDHEX$$vel"}

This.of_SetFilter(lvs_Coluna, lvs_Nome)	
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()


end event

event rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	This.Object.st_responsavel.text = This.Object.nm_usuario[currentrow] + " (" +&
												 This.Object.nr_matricula_responsavel[currentrow] + ")"
End If
											 
end event

event ue_preretrieve;call super::ue_preretrieve;String lvs_Prox_Venda

Tab_1.TabPage_1.Dw_1.accepttext( )
lvs_Prox_Venda= Tab_1.TabPage_1.dw_1.Object.id_prox_venda [1] 

If lvs_Prox_Venda = 'S' Then
	This.of_appendwhere_subquery("not exists (	select i2.cd_produto " + &
																"from nf_venda n2 " + &
																"inner join item_nf_venda i2 " + &
																	"on i2.cd_filial = n2.cd_filial " + &
																	"and i2.nr_nf = n2.nr_nf " + &
																	"and i2.de_serie = n2.de_serie " + &
																	"and i2.de_especie = n2.de_especie " + &
																"where n2.dh_movimentacao_caixa = lo.dh_movimentacao_caixa " + &
																	"and n2.cd_filial = lo.cd_filial " + &
																	"and n2.dh_emissao between lo.dh_cancelamento and dateadd(mi,5,lo.dh_cancelamento) " + &
																	"and i2.cd_produto = lo.cd_produto " + &
																	"and n2.cd_caixa = lo.cd_caixa " + &
																	"and n2.nr_controle_caixa = lo.nr_controle_caixa " + &
																	"and n2.nr_ecf = lo.nr_ecf)",1)
End If

Return AncestorReturnValue
end event

type dw_5 from dc_uo_dw_base within w_ge279_relatorio_log_cancelamento
boolean visible = false
integer x = 2976
integer y = 60
integer width = 439
integer height = 136
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge279_relatorio_lista_filial"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;This.Object.st_periodo.text = String(ivd_Inicio) + " at$$HEX1$$e900$$ENDHEX$$: " + String(ivd_Termino)

If IsNull(Tab_1.TabPage_1.dw_1.Object.cd_filial[1]) Then
	This.Object.st_filial.text = "Todas"
Else
	This.Object.st_filial.text = Tab_1.TabPage_1.dw_1.Object.nm_filial[1] + &
										  " (" + String(Tab_1.TabPage_1.dw_1.Object.cd_filial[1]) + ")"
End If

Return 1
end event

type dw_6 from dc_uo_dw_base within w_ge279_relatorio_log_cancelamento
boolean visible = false
integer x = 3003
integer y = 228
integer width = 434
integer height = 140
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge279_relatorio_lista_produto"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;Long lvl_Linha

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

This.Object.st_Filial.text = Tab_1.TabPage_1.dw_2.Object.nm_fantasia[lvl_Linha] + " (" +&
									  String(Tab_1.TabPage_1.dw_2.Object.cd_filial[lvl_Linha]) + ")"	

This.Object.st_periodo.text = String(ivd_Inicio) + " at$$HEX1$$e900$$ENDHEX$$: " + String(ivd_Termino)


Return 1
end event

