HA$PBExportHeader$w_ge179_compras_valor_maior_aceite.srw
forward
global type w_ge179_compras_valor_maior_aceite from dc_w_2tab_consulta_selecao_lista_det
end type
type cb_planilha from commandbutton within tabpage_1
end type
end forward

global type w_ge179_compras_valor_maior_aceite from dc_w_2tab_consulta_selecao_lista_det
string accessiblename = "Compras com Valor Acima do Aceit$$HEX1$$e100$$ENDHEX$$vel (GE179)"
integer width = 5042
integer height = 2128
string title = "GE179 - Compras com Valor Acima do Aceit$$HEX1$$e100$$ENDHEX$$vel"
end type
global w_ge179_compras_valor_maior_aceite w_ge179_compras_valor_maior_aceite

type variables
String ivs_filiais, ivs_nulo

Decimal	ivdc_pc_pis
Decimal	ivdc_pc_cofins

Date idh_inicio_pis_cofins

uo_produto io_Produto
end variables

on w_ge179_compras_valor_maior_aceite.create
int iCurrent
call super::create
end on

on w_ge179_compras_valor_maior_aceite.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;io_Produto = Create uo_produto 

Tab_1.TabPage_1.dw_1.Object.dh_inicio	[1] = RelativeDate(Date(gf_GetServerDate()), -1)
Tab_1.TabPage_1.dw_1.Object.dh_termino	[1] = Tab_1.TabPage_1.dw_1.Object.dh_inicio[1]

Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_SalvarComo(True)
end event

event close;call super::close;Destroy io_Produto
end event

event ue_preopen;call super::ue_preopen;ivl_Largura_1 = This.Width + 40
ivl_Largura_2 = ivl_Largura_1 + 375
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge179_compras_valor_maior_aceite
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge179_compras_valor_maior_aceite
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge179_compras_valor_maior_aceite
integer width = 4965
integer height = 1920
end type

event tab_1::selectionchanged;// OverRide

Choose Case NewIndex
	Case 1 
		Parent.Width 	= Parent.ivl_Largura_1
		This.Width  		= Parent.Width - 100
		
		Tab_1.TabPage_1.dw_2.SetFocus()
		
	Case 2
		Parent.Width 	= Parent.ivl_Largura_2
		This.Width  		= Parent.Width - 100
		
		Tab_1.TabPage_2.dw_3.SetFocus()
		
End Choose
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 4928
integer height = 1804
cb_planilha cb_planilha
end type

on tabpage_1.create
this.cb_planilha=create cb_planilha
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_planilha
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_planilha)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 424
integer width = 4032
integer height = 1372
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 2629
integer height = 408
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 32
integer width = 2578
integer height = 320
string dataobject = "dw_ge179_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long lvl_Lojas

dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "id_filiais"
		
		Setnull(ivs_nulo)
		
		ivs_filiais = ivs_nulo 
		
		If Data = 'C' Then
			uo_ge216_filiais uo_filiais
			
			uo_Filiais = Create uo_ge216_filiais
			
			OpenWithParm(w_ge216_selecao_filiais, uo_Filiais)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				ivs_filiais = uo_Filiais.ivs_filiais
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			End If
			
			Destroy(uo_Filiais)
			
		End If
		
	Case "de_produto"
		
		If Not IsNull(Data) and Trim(Data) <> '' Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque Then 	Return 1
		Else
			io_Produto.of_Inicializa()
			
			This.Object.cd_produto[1] = io_Produto.cd_produto
			This.Object.de_produto[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque		
		End If	
		
End Choose


end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() =  "de_produto" Then
		io_Produto.of_Localiza_Produto(This.GetText())
			
		If io_Produto.Localizado Then
			This.Object.cd_produto	[1] = io_Produto.cd_produto
			This.Object.de_produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
	End If
End If

end event

event dw_1::getfocus;call super::getfocus;//This.ivo_Controle_Menu.of_Atualiza()
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer x = 50
integer y = 488
integer width = 3982
integer height = 1288
string dataobject = "dw_ge179_lista"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_2::ue_recuperar;//OverRide
Date ldh_Inicio
Date ldh_Termino

Long		ll_Produto

String	lvs_SQL
String	ls_Conexao
String	ls_Filiais
String	ls_Compra_Bloq
String	ls_msg

Tab_1.TabPage_1.dw_1.AcceptText()

ls_Filiais				= Tab_1.TabPage_1.dw_1.object.id_filiais				[1]
ldh_Inicio				= Tab_1.TabPage_1.dw_1.object.dh_inicio				[1]
ldh_Termino				= Tab_1.TabPage_1.dw_1.object.dh_termino				[1]
ll_Produto				= Tab_1.TabPage_1.dw_1.object.cd_produto				[1]
ls_Compra_Bloq			= Tab_1.TabPage_1.dw_1.object.id_compra_bloqueada	[1]
ls_Conexao				= Tab_1.TabPage_1.dw_1.object.id_conexao				[1]

If IsNull(ldh_Inicio) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ldh_Termino) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If ldh_Inicio > ldh_Termino Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If ls_Filiais = 'C' Then
	If Not IsNull(ivs_Filiais) and trim(ivs_Filiais) <> '' Then
		This.of_appendwhere_subquery("p1.cd_filial in (" + ivs_Filiais + ")", 1)
		This.of_appendwhere_subquery("p1.cd_filial in (" + ivs_Filiais + ")", 5)
	End If
End If

If Not IsNull(ll_Produto) Then
	This.of_appendwhere_subquery("p2.cd_produto = " + String(ll_Produto), 1 )
	This.of_appendwhere_subquery("p2.cd_produto = " + String(ll_Produto), 5 )
End If

If ls_Compra_Bloq <> 'T' Then
	If ls_Compra_Bloq = 'S' Then
		This.of_appendwhere_subquery("tudo.id_bloq_compra_maior_limite = 'S'", 9)
	Else
		This.of_appendwhere_subquery("tudo.id_bloq_compra_maior_limite = 'N'", 9)
	End If
End If

If ls_Conexao <> 'T' Then

	Choose case ls_Conexao
	
		Case 'N' //Ir$$HEX1$$e100$$ENDHEX$$ mostrar os dados como hoje.
			This.of_appendwhere_subquery("pfdi.cd_fornecedor_conexao is null", 1)
			This.of_appendwhere_subquery("pfdi.cd_fornecedor_conexao is null", 5)
			
		Case 'C' //Ir$$HEX1$$e100$$ENDHEX$$ mostrar os dados apenas de pedido conex$$HEX1$$e300$$ENDHEX$$o.
			This.of_appendwhere_subquery("pfdi.cd_fornecedor_conexao is not null", 1)
			This.of_appendwhere_subquery("pfdi.cd_fornecedor_conexao is not null", 5)	
			
		Case Else //Mostr$$HEX1$$e100$$ENDHEX$$ por projeto conex$$HEX1$$e300$$ENDHEX$$o: Uma lista com os projetos conex$$HEX1$$e300$$ENDHEX$$o dispon$$HEX1$$ed00$$ENDHEX$$veis para o usu$$HEX1$$e100$$ENDHEX$$rio poder ver espec$$HEX1$$ed00$$ENDHEX$$fico por projeto. ex : 053400162,053404648
			This.of_appendwhere_subquery("pfdi.cd_fornecedor_conexao = '" + ls_Conexao +"'", 1)
			This.of_appendwhere_subquery("pfdi.cd_fornecedor_conexao = '" + ls_Conexao +"'", 5)	
	End choose
	
End If

lvs_SQL = this.Object.DataWindow.Table.Select

If Not gf_ge179_busca_parametro_pis_cofins(Ref ivdc_pc_pis,Ref ivdc_pc_cofins,Ref idh_inicio_pis_cofins,Ref ls_msg) Then
	Messagebox('Erro', ls_msg, stopsign!)
	Return -1
End if

Return This.Retrieve(ldh_Inicio, ldh_Termino,ivdc_pc_pis,ivdc_pc_cofins)


end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection()

// Habilitar a ordena$$HEX2$$e700e300$$ENDHEX$$o na coluna
This.ivb_Ordena_Colunas = True
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 4928
integer height = 1804
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 4869
integer height = 1692
integer textsize = -7
long textcolor = 128
string text = ""
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer width = 4768
integer height = 1600
string dataobject = "dw_ge179_detalhe"
boolean vscrollbar = true
end type

event dw_3::ue_recuperar;// OverRide

Date ldh_Inicio, ldh_Termino

Long ll_Produto

String ls_Compra_Bloq

decimal ldc_pc_limite

Tab_1.TabPage_1.dw_1.AcceptText()
Tab_1.TabPage_1.dw_2.AcceptText()

ldh_Inicio   			= Tab_1.TabPage_1.dw_1.object.dh_inicio 		[1]
ldh_Termino		= Tab_1.TabPage_1.dw_1.object.dh_termino	[1]

ll_Produto			= Tab_1.TabPage_1.dw_2.object.cd_produto							[Tab_1.TabPage_1.dw_2.GetRow()]
ls_Compra_Bloq		= Tab_1.TabPage_1.dw_2.object.id_bloq_compra_maior_limite	[Tab_1.TabPage_1.dw_2.GetRow()]
ldc_pc_limite		= Tab_1.TabPage_1.dw_2.object.pc_limite_aceite_preco_distrib[Tab_1.TabPage_1.dw_2.GetRow()]

If Not IsNull(ivs_Filiais) and trim(ivs_Filiais) <> '' Then
	This.of_appendwhere_subquery("p.cd_filial in (" + ivs_Filiais + ")"	, 1)
	This.of_appendwhere_subquery("p.cd_filial in (" + ivs_Filiais + ")"	, 4)
End If

//If ls_Compra_Bloq = 'S' Then
//	This.of_appendwhere_subquery("tudo.id_bloq_compra_maior_limite = 'S'", 6)
//Else
//	This.of_appendwhere_subquery("tudo.id_bloq_compra_maior_limite = 'N'", 6)
//End If

Tab_1.TabPage_2.gb_3.text = Tab_1.TabPage_1.dw_2.object.de_produto[Tab_1.TabPage_1.dw_2.GetRow()]  + " (" + String(ll_Produto) + ")"

Return This.Retrieve(ldh_Inicio, ldh_Termino, ll_Produto, ls_Compra_Bloq, ldc_pc_limite,ivdc_pc_pis,ivdc_pc_cofins)
end event

event dw_3::constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_planilha from commandbutton within tabpage_1
integer x = 3561
integer y = 276
integer width = 494
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Planilha Anal$$HEX1$$ed00$$ENDHEX$$tica"
end type

event clicked;String ls_Filiais, ls_Compra_Bloq, ls_Path, ls_Arquivo, lvs_SQL,ls_msg

Date ldh_Inicio, ldh_Termino

Long ll_Produto, ll_Linhas

Integer li_retorno

Tab_1.TabPage_1.dw_1.AcceptText()

ls_Filiais		= Tab_1.TabPage_1.dw_1.object.id_filiais				[1]
ldh_Inicio		= Tab_1.TabPage_1.dw_1.object.dh_inicio				[1]
ldh_Termino		= Tab_1.TabPage_1.dw_1.object.dh_termino				[1]
ll_Produto		= Tab_1.TabPage_1.dw_1.object.cd_produto				[1]
ls_Compra_Bloq	= Tab_1.TabPage_1.dw_1.object.id_compra_bloqueada	[1]

If IsNull(ldh_Inicio) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ldh_Termino) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If ldh_Inicio > ldh_Termino Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

dc_uo_ds_base lds
lds = Create dc_uo_ds_base

If Not lds.of_ChangeDataObject("dw_ge179_analitico") Then
	Destroy lds
	Return -1
End If

If ls_Filiais = 'C' Then
	If Not IsNull(ivs_Filiais) and trim(ivs_Filiais) <> '' Then
		lds.of_appendwhere_subquery("p.cd_filial in (" + ivs_Filiais + ")", 2)
		lds.of_appendwhere_subquery("p.cd_filial in (" + ivs_Filiais + ")", 5)
	End If
End If

If Not IsNull(ll_Produto) Then
	lds.of_appendwhere_subquery("pp.cd_produto = " + String(ll_Produto), 2 )
	lds.of_appendwhere_subquery("pp.cd_produto = " + String(ll_Produto), 5 )
End If

If ls_Compra_Bloq <> 'T' Then
	If ls_Compra_Bloq = 'S' Then
		lds.of_appendwhere_subquery("tudo.id_bloq_compra_maior_limite = 'S'", 7)
	Else
		lds.of_appendwhere_subquery("tudo.id_bloq_compra_maior_limite = 'N'", 7)
	End If
End If

lvs_SQL = lds.Object.DataWindow.Table.Select

If Not gf_ge179_busca_parametro_pis_cofins(Ref ivdc_pc_pis,Ref ivdc_pc_cofins,Ref idh_inicio_pis_cofins,Ref ls_msg) Then
	Messagebox('Erro', ls_msg, stopsign!)
	Return -1
End if

lds.Retrieve(ldh_Inicio, ldh_Termino,ivdc_pc_pis,ivdc_pc_cofins)

ll_Linhas = lds.RowCount()

If ll_Linhas > 0 Then
	
	lds.of_SaveAs(ls_Path)
	
//	li_retorno = GetFileSaveName('Arquivo', ls_Path, ls_Arquivo, 'xls', 'Planilha Excel (*.xls),*.xls')
//	
//	If li_retorno = 1 Then
//		
//	If lds.SaveAs(ls_Path, Excel!, True) = 1 Then
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo foi salvo com sucesso '" + ls_Path + "'.")
//		Else
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar o arquivo '" + ls_Path + "'.", StopSign!)
//		End If
//	End If
	
Else
	If ll_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.")
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar os dados na data window.")
	End If
End If
end event

