HA$PBExportHeader$w_ge477_cadastro_prd_conveniencia_ped.srw
forward
global type w_ge477_cadastro_prd_conveniencia_ped from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge477_cadastro_prd_conveniencia_ped from dc_w_cadastro_selecao_lista
integer width = 3346
integer height = 2300
string title = "GE477 - Manuten$$HEX2$$e700e300$$ENDHEX$$o de Produtos de Conveni$$HEX1$$ea00$$ENDHEX$$ncia para Pedido Autom$$HEX1$$e100$$ENDHEX$$tico"
end type
global w_ge477_cadastro_prd_conveniencia_ped w_ge477_cadastro_prd_conveniencia_ped

type variables
uo_produto		io_Produto
uo_fornecedor 	io_Fornecedor

Boolean ivb_Check
end variables

on w_ge477_cadastro_prd_conveniencia_ped.create
call super::create
end on

on w_ge477_cadastro_prd_conveniencia_ped.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;If IsValid(io_Produto) 		Then Destroy(io_Produto)
If IsValid(io_Fornecedor)	Then Destroy(io_Fornecedor)
end event

event ue_preopen;call super::ue_preopen;io_Produto 		= Create uo_produto
io_Fornecedor 	= Create uo_fornecedor
end event

event ue_postopen;call super::ue_postopen;dw_1.ivo_Controle_Menu.of_Incluir(False)
dw_1.ivo_Controle_Menu.of_Excluir(False)
end event

event ue_preupdate;call super::ue_preupdate;Boolean lb_Alteracao = False

Long ll_Linha
Long ll_Produto
Long ll_Get_Row

String ls_Liberado
String ls_Lib_Ant
String ls_Erro

dw_2.AcceptText()

For ll_Linha = 1 To dw_2.RowCount()
	ls_Liberado	= dw_2.Object.Id_Liberado			[ll_Linha]
	ls_Lib_Ant	= dw_2.Object.Id_Liberado_Ant	[ll_Linha]
	ll_Produto	= dw_2.Object.Cd_Produto			[ll_Linha]
	
	If ls_Liberado <> ls_Lib_Ant Then
		lb_Alteracao = True
		
		If ls_Liberado = "S" Then
			Insert Into conveniencia_prd_pedido_auto(cd_produto)
				Values(:ll_Produto)
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SqlErrText
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao inserir o produto " + String(ll_Produto) + " na tabela conveniencia_prd_pedido_auto. " + ls_Erro, StopSign!)
				Return False
			End If
			
			If Not gf_Grava_Historico_Alteracao_Tabela('CONVENIENCIA_PRD_PEDIDO_AUTO', String(ll_Produto), 'CD_PRODUTO', ls_Lib_Ant, ls_Liberado, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "A", Ref ls_Erro, True) Then Return False			
		Else
			
			Delete From conveniencia_prd_pedido_auto
			Where cd_produto = :ll_Produto
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SqlErrText
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o produto " + String(ll_Produto) + " da tabela conveniencia_prd_pedido_auto. " + ls_Erro, StopSign!)
				Return False
			End If
			
			If Not gf_Grava_Historico_Alteracao_Tabela('CONVENIENCIA_PRD_PEDIDO_AUTO', String(ll_Produto), 'CD_PRODUTO', ls_Lib_Ant, ls_Liberado, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "A", Ref ls_Erro, True) Then Return False		
		End If
	End If
Next

If lb_Alteracao Then
	SqlCa.of_Commit();
	dw_1.ivo_Controle_Menu.of_Incluir(False)
	dw_1.ivo_Controle_Menu.of_Excluir(False)
	ivm_Menu.mf_Confirmar(False)
	ivm_Menu.mf_Cancelar(False)
	ll_Get_Row = dw_2.GetRow()
	dw_2.Event ue_Retrieve()
	dw_2.SetRow(ll_Get_Row)
End If

Return True
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge477_cadastro_prd_conveniencia_ped
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge477_cadastro_prd_conveniencia_ped
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge477_cadastro_prd_conveniencia_ped
integer width = 2770
string dataobject = "dw_ge477_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

Choose Case dwo.Name		
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If
			
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
			This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
		End If
		
	Case "nm_razao_social"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			io_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor			[1] = io_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor			[1] = io_Fornecedor.Nm_Razao_Social
			This.Object.Cd_Fornecedor_SAP	[1] = io_Fornecedor.Cd_Fornecedor_SAP
		End If
End Choose
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

Choose Case dwo.Name		
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If
			
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
			This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
		End If
		
	Case "nm_razao_social"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			io_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor			[1] = io_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Razao_Social		[1] = io_Fornecedor.Nm_Razao_Social
			This.Object.Cd_Fornecedor_SAP	[1] = io_Fornecedor.Cd_Fornecedor_SAP
		End If
End Choose
end event

event dw_1::ue_key;call super::ue_key;Choose Case Key
	Case KeyEnter!
		If This.GetColumnName() = "de_produto" Then
			io_Produto.of_Localiza_Produto(This.GetText())
						
			If io_Produto.Localizado Then				
				This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
				This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
			Else
				io_Produto.of_Inicializa()
			End If
		End If
		
		If This.GetColumnName() = "nm_razao_social" Then
			io_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			
			If io_Fornecedor.Localizado Then
				This.Object.Cd_Fornecedor			[1] = io_Fornecedor.Cd_Fornecedor
				This.Object.Nm_Razao_Social		[1] = io_Fornecedor.Nm_Razao_Social
				This.Object.Cd_Fornecedor_SAP	[1] = io_Fornecedor.Cd_Fornecedor_SAP
			Else
				io_Fornecedor.of_Inicializa()
			End If
		End If
End Choose
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge477_cadastro_prd_conveniencia_ped
integer y = 288
integer width = 3223
integer height = 1788
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge477_cadastro_prd_conveniencia_ped
integer width = 2839
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge477_cadastro_prd_conveniencia_ped
integer y = 364
integer width = 3141
integer height = 1676
string dataobject = "dw_ge477_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long ll_Produto

String ls_Fornecedor

dw_1.AcceptText()

ll_Produto		= dw_1.Object.Cd_Produto		[1]
ls_Fornecedor	= dw_1.Object.Cd_Fornecedor	[1]

If Not IsNull(ll_Produto) And ll_Produto > 0 Then
	This.of_AppendWhere_SubQuery("g.cd_produto = " + String(ll_Produto), 2)
End If

If Not IsNull(ls_Fornecedor) And ls_Fornecedor <> "" Then
	This.of_AppendWhere_SubQuery("g.cd_fornecedor_usual = '" + ls_Fornecedor + "'", 2)
End If

Return 1
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection( "if(id_liberado = ~"N~", if(getrow() = currentrow(), rgb(0,128,128), rgb(255, 255, 255)),  if(getrow() = currentrow(), rgb(139,129,76), rgb(255,236,139)) )", "", False )

ivi_Tipo_Cancelar = RETRIEVE
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_linhas > 0 Then
	dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Else
	dw_2.ivo_Controle_Menu.of_SalvarComo(False)
End If

dw_1.ivo_Controle_Menu.of_Incluir(False)
dw_1.ivo_Controle_Menu.of_Excluir(False)

Return pl_Linhas
end event

event dw_2::itemfocuschanged;call super::itemfocuschanged;dw_1.ivo_Controle_Menu.of_Incluir(False)
dw_1.ivo_Controle_Menu.of_Excluir(False)
end event

event dw_2::doubleclicked;call super::doubleclicked;If dwo.Name = 'st_selecionado' Then
	
	Long lvl_Row
	
	String lvs_Marcacao
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True
	End If
	
	For lvl_Row = 1 To This.RowCount()				
		This.Object.Id_Liberado[lvl_Row] = lvs_Marcacao
	Next
	
	dw_1.ivo_Controle_Menu.of_Incluir(False)
	dw_1.ivo_Controle_Menu.of_Excluir(False)
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Cancelar(True)
End If
end event

event dw_2::ue_predeleterow;call super::ue_predeleterow;//N$$HEX1$$e300$$ENDHEX$$o permite exclus$$HEX1$$e300$$ENDHEX$$o
Return False
end event

