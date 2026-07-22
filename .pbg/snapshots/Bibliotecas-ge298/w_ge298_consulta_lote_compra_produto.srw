HA$PBExportHeader$w_ge298_consulta_lote_compra_produto.srw
forward
global type w_ge298_consulta_lote_compra_produto from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge298_consulta_lote_compra_produto from dc_w_selecao_lista_relatorio
string accessiblename = "NF Compra por Produto Lote (GE298)"
integer width = 3616
integer height = 1760
string title = "GE298 - NF Compra por Produto / Lote"
end type
global w_ge298_consulta_lote_compra_produto w_ge298_consulta_lote_compra_produto

type variables
uo_produto ivo_Produto

uo_filial ivo_filial

uo_fornecedor ivo_fornecedor

String is_Produto
end variables

on w_ge298_consulta_lote_compra_produto.create
call super::create
end on

on w_ge298_consulta_lote_compra_produto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;ivo_Produto = Create uo_Produto

ivo_Filial	= Create uo_Filial

ivo_Fornecedor = Create uo_Fornecedor
end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Filial)
Destroy(ivo_Fornecedor)
end event

event ue_saveas;call super::ue_saveas;dw_2.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge298_consulta_lote_compra_produto
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge298_consulta_lote_compra_produto
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge298_consulta_lote_compra_produto
integer x = 14
integer y = 524
integer width = 3543
integer height = 1036
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge298_consulta_lote_compra_produto
integer x = 14
integer width = 1943
integer height = 496
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge298_consulta_lote_compra_produto
integer x = 46
integer width = 1874
integer height = 396
string dataobject = "dw_ge298_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long ll_Nulo

String ls_Nulo

SetNull(ll_Nulo)
SetNull(ls_Nulo)


Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> '' Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque	Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			dw_1.Object.Id_Planilha[1] = "N"
			
			This.Object.cd_produto[1] = ivo_Produto.cd_produto
			This.Object.de_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque		
		End If
		
	Case "de_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.de_Filial[1] = ivo_Filial.Nm_Fantasia
		End If
		
	Case "nm_fornecedor"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
		

	Case "id_planilha"
		If Data = "S" Then
			OpenWithParm(w_ge298_filtro_via_planilha, '')
			
			is_Produto = Message.StringParm
			
			If Trim(is_Produto) = "" Or IsNull(is_Produto) Then
				Return 1
			End If
			
			dw_1.Object.De_Produto[1] = ls_Nulo
			dw_1.Object.Cd_Produto[1] = ll_Nulo			
		Else
			is_Produto = ""
		End If		
		
			
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.cd_produto	[1] = ivo_Produto.cd_produto
				This.Object.de_produto	[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
			End If
			
			dw_1.Object.Id_Planilha[1] = "N"
			//dw_1.Object.Id_Planilha.Visible = False
			is_Produto = ""			
			
			
		Case "nm_fornecedor"
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			
			If ivo_Fornecedor.Localizado Then
				This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
				This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
			End If

		Case "de_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
	
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial 
				This.Object.de_Filial[1] = ivo_Filial.Nm_Fantasia
			End If	
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge298_consulta_lote_compra_produto
integer x = 46
integer y = 572
integer width = 3474
integer height = 972
string dataobject = "dw_ge298_lista"
boolean hscrollbar = true
end type

event dw_2::ue_recuperar;//OverRide
Long 	ll_Filial,&
		ll_Produto,&
		ll_Linhas
		
String 	ls_Fornecedor,&
			ls_Lote,&
			ls_Planilha
			
DateTime ldh_Emissao			

dw_1.AcceptText()

ll_Filial			= dw_1.Object.cd_filial			[1]
ll_Produto		= dw_1.Object.cd_produto		[1]
ls_Fornecedor	= dw_1.Object.cd_fornecedor	[1]
ls_Lote			= dw_1.Object.nr_lote			[1]
ldh_Emissao		= dw_1.Object.dh_inicio			[1]
ls_Planilha		= dw_1.Object.id_planilha		[1]

If is_Produto="" and IsNull(ll_Produto) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe um Produto ou uma planilha com Produtos.")
	dw_1.Event ue_Pos(1, "cd_produto")
	Return -1
End If

If Not IsNull(ll_Filial) Then
	dw_2.of_appendwhere("a.cd_filial = "+String(ll_Filial))
End If

If IsNull(is_Produto) or is_Produto="" Then 
	If Not IsNull(ll_Produto) and ll_Produto <> 0 Then
		dw_2.of_AppendWhere("a.cd_produto = " + String(ll_Produto))
	End If
Else 
	dw_2.of_appendwhere("a.cd_produto in ("+is_Produto + ")")	
End If  

If Not IsNull(ls_Fornecedor) and ls_Fornecedor <> "" Then
	dw_2.of_appendwhere("a.cd_fornecedor = '"+ls_Fornecedor+"'")
End If

If Not IsNull(ls_Lote) and ls_Lote <> "" Then
	dw_2.of_appendwhere("a.nr_lote = '"+ls_Lote+"'")
End If

If Not IsNull(ldh_Emissao) Then
	dw_2.of_appendwhere("b.dh_emissao >= '"+String(ldh_Emissao, "yyyymmdd")+"'")
End If

ll_Linhas = dw_2.Retrieve()

If ll_Linhas > 0 Then
	dw_2.ivo_Controle_Menu.of_salvarcomo( True)
Else
	dw_2.ivo_Controle_Menu.of_salvarcomo( False)
End If

Return ll_Linhas


end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge298_consulta_lote_compra_produto
integer x = 2203
integer y = 108
end type

