HA$PBExportHeader$w_ge223_consulta_nf_devolucao_venda.srw
forward
global type w_ge223_consulta_nf_devolucao_venda from dc_w_2tab_consulta_selecao_lista_2det
end type
type dw_5 from dc_uo_dw_base within tabpage_1
end type
type pb_1 from picturebutton within tabpage_2
end type
end forward

global type w_ge223_consulta_nf_devolucao_venda from dc_w_2tab_consulta_selecao_lista_2det
string tag = "w_ge223_consulta_nf_devolucao_venda"
integer width = 4073
integer height = 2016
string title = "GE223 - Consulta de Notas Fiscais de Devolu$$HEX2$$e700e300$$ENDHEX$$o de Venda"
long backcolor = 80269524
end type
global w_ge223_consulta_nf_devolucao_venda w_ge223_consulta_nf_devolucao_venda

type variables
uo_Filial 			ivo_Filial
uo_convenio		ivo_Convenio
uo_usuario		ivo_Operador
uo_cliente		ivo_Cliente
uo_Produto		ivo_Produto
end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/* Lei Generico*/
ldwc_Child  = Tab_1.TabPage_1.dw_1.of_InsertRow_DDDW("id_lei_generico" )			

ldwc_Child.SetItem(1, "id_lei_generico", "")
ldwc_Child.SetItem(1, "de_lei_generico", "TODAS")

Tab_1.TabPage_1.dw_1.Object.id_lei_generico[1] = ""

/* Gruipo Produto*/
ldwc_Child  = Tab_1.TabPage_1.dw_1.of_InsertRow_DDDW("cd_grupo" )			

ldwc_Child.SetItem(1, "cd_grupo", "")
ldwc_Child.SetItem(1, "de_grupo", "TODAS")

Tab_1.TabPage_1.dw_1.Object.cd_grupo[1] = ""
end subroutine

on w_ge223_consulta_nf_devolucao_venda.create
int iCurrent
call super::create
end on

on w_ge223_consulta_nf_devolucao_venda.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Convenio)
Destroy(ivo_Operador	)
Destroy(ivo_Produto)
Destroy(ivo_Cliente)

end event

event ue_postopen;call super::ue_postopen;ivo_Filial 			= Create uo_Filial
ivo_Convenio	= Create uo_convenio
ivo_Operador	= Create uo_usuario
ivo_Cliente		= Create uo_cliente
ivo_Produto		= Create uo_Produto

ivm_menu.ivb_permite_imprimir = True

wf_insere_padrao()
end event

event ue_preopen;call super::ue_preopen;ivl_Largura_1 = 3870
ivl_Altura_1  = 9999

ivl_Largura_2 = 4000
ivl_Altura_2  = 1810

//ivl_Largura_1 = 3282
//ivl_Altura_1  = 1712 
//
//ivl_Largura_2 = 3282
//ivl_Altura_2  = 1712 

Maxheight = 9999
end event

event ue_saveas;//override
Tab_1.Tabpage_1.dw_5.Event ue_SaveAs()
end event

event resize;call super::resize;Tab_1.Height	= NewHeight - Tab_1.Y - 10
Tab_1.Width	= NewWidth - Tab_1.X - 10

Tab_1.Tabpage_1.gb_2.Height =  Tab_1.Height - Tab_1.Tabpage_1.gb_2.Y - 140
Tab_1.Tabpage_1.dw_2.Height =  Tab_1.Height - Tab_1.Tabpage_1.dw_2.Y - 170

Tab_1.Tabpage_2.gb_4.Height =  Tab_1.Height - Tab_1.Tabpage_2.gb_4.Y - 140
Tab_1.Tabpage_2.dw_4.Height =  Tab_1.Height - Tab_1.Tabpage_2.dw_4.Y - 170
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_2det`dw_visual within w_ge223_consulta_nf_devolucao_venda
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_2det`gb_aux_visual within w_ge223_consulta_nf_devolucao_venda
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_2det`tab_1 within w_ge223_consulta_nf_devolucao_venda
integer y = 4
integer width = 4000
integer height = 1812
long backcolor = 80269524
end type

event tab_1::selectionchanged;call super::selectionchanged;Parent.Width  = This.Width + This.X + 75	
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_1 within tab_1
integer width = 3963
integer height = 1696
dw_5 dw_5
end type

on tabpage_1.create
this.dw_5=create dw_5
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_5
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_5)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_2det`gb_2 within tabpage_1
integer x = 18
integer y = 528
integer width = 3785
integer height = 1152
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_2det`gb_1 within tabpage_1
integer x = 14
integer width = 3639
integer height = 504
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_2det`dw_1 within tabpage_1
integer x = 46
integer width = 3598
integer height = 408
string dataobject = "dw_ge223_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.name
	Case "de_filial"
		If data <> ivo_Filial.nm_Fantasia Then
			Return 1
		End If	
		
		If IsNull(Data) Then
					
			ivo_filial.Of_inicializa( )
			
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.De_Filial[1] = ivo_Filial.Nm_Fantasia
			
		End If
		
	Case "de_produto"
		If data <> ivo_Produto.ivs_descricao_apresentacao_venda Then
			Return 1
		End If	
		
		If IsNull(Data) Then
					
			ivo_Produto.Of_inicializa( )
			
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_descricao_apresentacao_venda
			
		End If
		
	Case "nm_cliente"
		If Data <> ivo_Cliente.nm_cliente Then
			Return 1
		End If	
		
		If IsNull(Data) or (Trim(Data)="") Then
					
			ivo_Cliente.of_inicializa( )			
			This.Object.cd_cliente	[1] = ivo_Cliente.cd_cliente
			This.Object.nm_cliente	[1] = ivo_Cliente.nm_cliente
			
		End If
		
	Case "nm_convenio"
		If Data <> ivo_Convenio.nm_fantasia Then
			Return 1
		End If	
		
		If IsNull(Data) or (Trim(Data)="") Then
					
			ivo_Convenio.of_inicializa( )			
			This.Object.cd_convenio	[1] = ivo_Convenio.cd_convenio
			This.Object.nm_convenio[1] = ivo_Convenio.nm_fantasia
			
		End If
		
	Case "nm_operador"
		If Data <> ivo_Operador.nm_usuario Then
			Return 1
		End If	
		
		If IsNull(Data) or (Trim(Data)="") Then
					
			ivo_Operador.of_inicializa( )			
			This.Object.nr_matricula_operador	[1] = ivo_Operador.nr_matricula
			This.Object.nm_operador				[1] = ivo_Operador.nm_usuario
			
		End If
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then 
	dw_1.Object.De_Filial[1] = ivo_Filial.Nm_Fantasia
End If	

If IsValid(ivo_Convenio) Then 
	dw_1.Object.nm_convenio[1] = ivo_Convenio.Nm_Fantasia
End If	

If IsValid(ivo_Operador) Then 
	dw_1.Object.nm_operador[1] = ivo_Operador.nm_usuario
End If	

If IsValid(ivo_Cliente) Then 
	dw_1.Object.nm_cliente[1] = ivo_Cliente.Nm_cliente
End If	

If IsValid(ivo_Produto) Then 
	dw_1.Object.de_produto[1] = ivo_Produto.ivs_descricao_apresentacao_venda
End If	
end event

event dw_1::ue_addrow;call super::ue_addrow;Date ldt_Inicio

ldt_Inicio = Date( gf_GetServerDate() )

This.Object.Dt_Recebimento_De [1] = RelativeDate( ldt_Inicio, -1 )
This.Object.Dt_Recebimento_Ate[1] = gf_GetServerDate()



Return AncestorReturnValue
end event

event dw_1::ue_key;If Key = KeyEnter! Then
	
	Choose Case This.GetColumnName()
		Case "de_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				
				This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
				This.Object.De_Filial[1] = ivo_Filial.Nm_Fantasia			
			End If		
			
		Case "nm_cliente"
			ivo_Cliente.of_Localiza_cliente( This.GetText() )
			
			If ivo_Cliente.Localizado Then
				
				This.Object.cd_cliente	[1] = ivo_Cliente.cd_cliente
				This.Object.nm_cliente	[1] = ivo_Cliente.nm_cliente			
			End If			
			
		Case "de_produto"
			ivo_Produto.Of_Inicializa()
			ivo_Produto.of_Localiza_Produto( This.GetText() )
				
			This.Object.cd_produto	[1] = ivo_Produto.cd_produto
			This.Object.de_produto	[1] = ivo_Produto.ivs_descricao_apresentacao_venda				
			
		Case "nm_operador"
			ivo_Operador.of_Localiza_Usuario( This.GetText() )
			
			If ivo_Operador.Localizado Then
				
				This.Object.nr_matricula_operador	[1] = ivo_Operador.nr_matricula
				This.Object.nm_operador				[1] = ivo_Operador.nm_usuario			
			End If	
			
		Case "nm_convenio"
			ivo_Convenio.of_Localiza_convenio( This.GetText() )
			
			If ivo_Convenio.Localizado Then
				
				This.Object.cd_convenio	[1] = ivo_Convenio.Cd_convenio
				This.Object.nm_convenio[1] = ivo_Convenio.Nm_Fantasia			
			End If		
			
			
	End Choose
End if
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_2det`dw_2 within tabpage_1
integer x = 55
integer y = 600
integer width = 3707
integer height = 1060
string dataobject = "dw_ge223_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String	lvs_Cliente				, &
		lvs_Especie				, &
		lvs_Especie_Venda	, &
		lvs_Serie					, &
		lvs_Serie_Venda		, &
		lvs_Operador			, &
		lvs_Situacao				, &
		lvs_Grupo				, &
		lvs_Lei_G

Long	lvl_NF				, &
		lvl_NF_Venda	, &
		lvl_Filial			, &
		lvl_Convenio		, &
		lvl_Produto

dw_1.AcceptText()

lvl_Filial					= dw_1.Object.Cd_Filial						[1]
lvl_NF_Venda			= dw_1.Object.Nr_NF_Venda				[1]
lvl_NF						= dw_1.Object.Nr_NF							[1]
lvs_Especie				= Trim(dw_1.Object.De_Especie			[1])
lvs_Especie_Venda	= Trim(dw_1.Object.De_Especie_Venda	[1])
lvs_Serie					= Trim(dw_1.Object.De_Serie				[1])
lvs_Serie_Venda		= Trim(dw_1.Object.De_Serie_Venda	[1])
lvs_Situacao				= Trim(dw_1.Object.Id_Situacao			[1])
lvs_Cliente				= dw_1.Object.cd_cliente					[1]
lvs_Operador			= dw_1.Object.nr_matricula_operador	[1]
lvl_Convenio				= dw_1.Object.cd_convenio					[1]
lvl_Produto				= dw_1.Object.cd_produto					[1]
lvs_Grupo				= dw_1.Object.cd_grupo						[1]
lvs_Lei_G					= dw_1.Object.id_lei_generico				[1]

If Not IsNull(lvs_Cliente) and lvs_Cliente <> "" Then
	This.of_AppendWhere("((n.cd_cliente = '" + lvs_Cliente + "') or (coalesce(nl.nr_cgc_cpf,'')='"+ivo_cliente.nr_cpf_cgc+"'))")
End If

If Not IsNull(lvl_Filial) and lvl_Filial > 0 Then
	This.of_AppendWhere("n.cd_filial = " + String(lvl_Filial))
End If

If Not IsNull(lvl_NF) and lvl_NF > 0 Then
	This.of_AppendWhere("n.nr_nf = " + String(lvl_NF))
End If

If Not IsNull(lvs_Especie) and lvs_Especie <> "" Then
	This.of_AppendWhere("n.de_especie = '" + lvs_Especie + "'")
End If

If Not IsNull(lvs_Serie) and lvs_Serie <> "" Then
	This.of_AppendWhere("n.de_serie = '" + lvs_Serie + "'")
End If

If Not IsNull(lvl_NF_Venda) and lvl_NF_Venda > 0 Then
	This.of_AppendWhere("n.nr_nf_venda = " + String(lvl_NF_Venda))
End If

If Not IsNull(lvs_Especie_Venda) and lvs_Especie_Venda <> "" Then
	This.of_AppendWhere("n.de_especie_venda = '" + lvs_Especie_Venda + "'")
End If

If Not IsNull(lvs_Serie_Venda) and lvs_Serie_Venda <> "" Then
	This.of_AppendWhere("n.de_serie_venda = '" + lvs_Serie_Venda + "'")
End If

Choose Case lvs_Situacao
	Case "C" // Notas fiscais canceladas
		This.of_AppendWhere("n.dh_cancelamento is not null")
	Case "N" // Notas fiscais n$$HEX1$$e300$$ENDHEX$$o canceladas
		This.of_AppendWhere("n.dh_cancelamento is null")
End Choose

If Not IsNull(lvl_Convenio) and lvl_Convenio > 0 Then
	This.of_AppendWhere("n.cd_convenio = " + String(lvl_Convenio))
End If

If Not IsNull(lvs_Operador) and lvs_Operador <> "" Then
	This.of_AppendWhere("n.nr_matricula_operador = '" + lvs_Operador + "'")
End If

If Not IsNull(lvl_Produto) and lvl_Produto > 0 Then
	This.of_AppendWhere("exists (Select 1 from item_nf_devolucao_venda i1 "+ &
											" where i1.cd_filial = n.cd_filial "+&
											" and i1.nr_nf = n.nr_nf "+  &
											" and i1.de_especie = n.de_especie "+ &
											" and i1.de_serie = n.de_serie " + &
											" and i1.cd_produto = " + String(lvl_Produto)+")")
End If

If Not IsNull(lvs_Grupo) and lvs_Grupo<>"" Then
	This.of_AppendWhere("exists (Select 1 from item_nf_devolucao_venda i1 " + &
											" inner join produto_geral g1 " + &
											" on g1.cd_produto = i1.cd_produto " + &
											" where i1.cd_filial = n.cd_filial " + &
											" and i1.nr_nf = n.nr_nf "+  &
											" and i1.de_especie = n.de_especie "+ &
											" and i1.de_serie = n.de_serie " + &
											" and substring(g1.cd_subcategoria, 1, 1) = '" + lvs_Grupo+"')")
End If

If Not IsNull(lvs_Lei_G) and lvs_Lei_G<>"" Then
	This.of_AppendWhere("exists (Select 1 from item_nf_devolucao_venda i1 " + &
											" inner join produto_geral g1 " + &
											" on g1.cd_produto = i1.cd_produto " + &
											" where i1.cd_filial = n.cd_filial " + &
											" and i1.nr_nf = n.nr_nf "+  &
											" and i1.de_especie = n.de_especie "+ &
											" and i1.de_serie = n.de_serie " + &
											" and g1.id_lei_generico = '" + lvs_Lei_G+"')")
End If

Return AncestorReturnValue
end event

event dw_2::ue_recuperar;// OverRide

Date lvdt_Movimentacao_De, &
     lvdt_Movimentacao_Ate
	  
Tab_1.TabPage_1.dw_1.AcceptText()

lvdt_Movimentacao_De  = Tab_1.TabPage_1.dw_1.Object.Dt_Recebimento_De [1]
lvdt_Movimentacao_Ate = Tab_1.TabPage_1.dw_1.Object.Dt_Recebimento_Ate[1]

Return This.Retrieve(lvdt_Movimentacao_De, lvdt_Movimentacao_Ate)
end event

event dw_2::ue_postretrieve;// OverRide
Boolean lvb_Habilita = False

If pl_Linhas > 0 Then
	
	This.ScrollToRow(1)
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
ElseIf pl_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
End If

This.ivo_Controle_Menu.of_Classificar(pl_Linhas > 0)
This.ivo_Controle_Menu.of_Filtrar(pl_Linhas > 0)
This.ivo_Controle_Menu.of_SalvarComo(pl_Linhas > 0)
This.ivo_Controle_Menu.of_Imprimir(pl_Linhas > 0)
This.ivo_Controle_Menu.of_Localizar(lvb_Habilita)

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection("", "if( not isnull( dh_cancelamento ), RGB(255,0, 0), RGB(0,0,0) )")
This.ShareData(dw_5)
end event

event dw_2::ue_reset;call super::ue_reset;This.ivo_Controle_Menu.of_Classificar(False)
This.ivo_Controle_Menu.of_Imprimir(False)
This.ivo_Controle_Menu.of_Filtrar(False)
This.ivo_Controle_Menu.of_SalvarComo(False)
end event

event dw_2::ue_print;//override
dw_5.Event ue_Print()
end event

event dw_2::ue_printimmediate;//override
dw_5.Event ue_PrintImmediate()
end event

event dw_2::ue_saveas;//override
dw_5.Event ue_SaveAs()
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_2 within tab_1
integer width = 3963
integer height = 1696
pb_1 pb_1
end type

on tabpage_2.create
this.pb_1=create pb_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
end on

on tabpage_2.destroy
call super::destroy
destroy(this.pb_1)
end on

type gb_4 from dc_w_2tab_consulta_selecao_lista_2det`gb_4 within tabpage_2
integer y = 1044
integer width = 3913
integer height = 632
string text = "Produtos"
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_2det`gb_3 within tabpage_2
boolean visible = false
integer y = 8
integer width = 3909
integer height = 1036
string text = ""
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_2det`dw_3 within tabpage_2
integer x = 0
integer y = 16
integer width = 3954
integer height = 1028
string dataobject = "dw_ge223_detalhe_nf"
end type

event dw_3::ue_recuperar;// OverRide

Integer lvi_Linha_Ativa, &
        lvi_Linhas

Long lvl_Cd_Filial, &
     lvl_Nr_NF

String lvs_Cd_Cliente, &
       lvs_De_Especie, &
		 lvs_De_Serie, &
		 lvs_Id_Origem_NF

lvi_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Cd_Filial    = Tab_1.TabPage_1.dw_2.Object.Cd_Filial[lvi_Linha_Ativa]
lvs_Cd_Cliente   = Tab_1.TabPage_1.dw_2.Object.Cd_Cliente[lvi_Linha_Ativa]
lvl_Nr_NF        = Tab_1.TabPage_1.dw_2.Object.Nr_NF[lvi_Linha_Ativa]
lvs_De_Especie   = Tab_1.TabPage_1.dw_2.Object.De_Especie[lvi_Linha_Ativa]
lvs_De_Serie     = Tab_1.TabPage_1.dw_2.Object.De_Serie[lvi_Linha_Ativa]
lvs_Id_Origem_NF = Tab_1.TabPage_1.dw_2.Object.Id_Origem_NF[lvi_Linha_Ativa]

lvi_Linhas = This.Retrieve(lvl_Cd_Filial, &
						         lvs_Cd_Cliente, &
									lvl_Nr_NF, &
									lvs_De_Especie, &
									lvs_De_Serie, &
									lvs_Id_Origem_NF)

Return lvi_Linhas
end event

type dw_4 from dc_w_2tab_consulta_selecao_lista_2det`dw_4 within tabpage_2
integer x = 50
integer y = 1092
integer width = 3863
integer height = 564
string dataobject = "dw_ge223_detalhe_produto"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_4::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_4::ue_recuperar;// OverRide

Integer lvi_Linha_Ativa, &
        lvi_Linhas

Long lvl_Cd_Filial, lvl_Nr_NF

String lvs_Cd_Cliente, &
       lvs_De_Especie, &
		 lvs_De_Serie, &
		 lvs_Id_Origem_NF

lvi_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Cd_Filial    = Tab_1.TabPage_1.dw_2.Object.Cd_Filial[lvi_Linha_Ativa]
lvl_Nr_NF        = Tab_1.TabPage_1.dw_2.Object.Nr_NF[lvi_Linha_Ativa]
lvs_De_Especie   = Tab_1.TabPage_1.dw_2.Object.De_Especie[lvi_Linha_Ativa]
lvs_De_Serie     = Tab_1.TabPage_1.dw_2.Object.De_Serie[lvi_Linha_Ativa]
lvs_Id_Origem_NF = Tab_1.TabPage_1.dw_2.Object.Id_Origem_NF[lvi_Linha_Ativa]

lvi_Linhas = This.Retrieve(lvl_Cd_Filial, &
									lvl_Nr_NF, &
									lvs_De_Especie, &
									lvs_De_Serie, &
									lvs_Id_Origem_NF)

Return lvi_Linhas
end event

event dw_4::ue_postretrieve;//OverRide

Boolean lvb_Habilita = False

If pl_Linhas <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	Tab_1.TabPage_2.dw_3.Reset()
	Tab_1.TabPage_2.dw_4.Reset()
End If

This.ivo_Controle_Menu.of_Classificar(lvb_Habilita)
This.ivo_Controle_Menu.of_Filtrar(lvb_Habilita)
This.ivo_Controle_Menu.of_Localizar(lvb_Habilita)

Return pl_Linhas
end event

type dw_5 from dc_uo_dw_base within tabpage_1
integer x = 2775
integer y = 1136
integer width = 471
integer height = 212
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge223_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;This.Visible = False
end event

event ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

event ue_preprint;call super::ue_preprint;Date lvdt_Inicio
Date lvdt_Fim

String lvs_Situacao
String lvs_Filial

Long lvl_Filial

dw_1.Accepttext( )
lvdt_Inicio 		= dw_1.Object.dt_recebimento_de	[1]
lvdt_Fim			= dw_1.Object.dt_recebimento_ate	[1]
lvs_Situacao		= dw_1.Object.id_situacao				[1]
lvl_Filial			= dw_1.Object.cd_filial					[1]
lvs_Filial			= dw_1.Object.de_filial					[1]

This.Object.st_periodo.Text	= String(lvdt_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdt_Fim,'DD/MM/YYYY')
This.Object.st_situacao.Text= dw_1.Describe("Evaluate('LookUpDisplay(id_situacao)',1)")
If lvl_Filial > 0 Then
	This.Object.st_filial.Text		= lvs_Filial + ' ('+String(lvl_Filial)+')'
Else
	This.Object.st_filial.Text		= 'TODAS'
End If

Return AncestorReturnValue
end event

type pb_1 from picturebutton within tabpage_2
integer x = 1943
integer y = 896
integer width = 110
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\Copy.png"
alignment htextalign = left!
end type

event clicked;Integer lvi_Retorno

Tab_1.TabPage_2.dw_3.SetFocus()
Tab_1.TabPage_2.dw_3.Setcolumn('de_chave_acesso')
Tab_1.TabPage_2.dw_3.SelectText(1, 44)

lvi_Retorno = Tab_1.TabPage_2.dw_3.Copy()

Choose Case lvi_Retorno
	Case -1  // Vazio
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o foi selecionada para a c$$HEX1$$f300$$ENDHEX$$pia.")
	Case -2  // Erro na c$$HEX1$$f300$$ENDHEX$$pia
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na c$$HEX1$$f300$$ENDHEX$$pia.")
	Case -9  // Erro na c$$HEX1$$f300$$ENDHEX$$pia
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na c$$HEX1$$f300$$ENDHEX$$pia.")
End Choose
end event

