HA$PBExportHeader$w_ge650_considerar_saldo_agd.srw
forward
global type w_ge650_considerar_saldo_agd from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge650_considerar_saldo_agd from dc_w_cadastro_selecao_lista
string tag = "Cadastro de saldo do agendamento"
integer width = 4951
integer height = 2180
string title = "GE650 - Cadastro de saldo do agendamento"
end type
global w_ge650_considerar_saldo_agd w_ge650_considerar_saldo_agd

type variables
uo_produto ivo_produto

uo_fornecedor ivo_fornecedor

uo_ge149_comprador io_comprador

String	is_Produto

String	is_planilha
end variables

on w_ge650_considerar_saldo_agd.create
call super::create
end on

on w_ge650_considerar_saldo_agd.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;ivo_Produto 		= Create uo_Produto
ivo_Fornecedor 	= Create uo_Fornecedor
io_comprador		= Create uo_ge149_comprador
end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Fornecedor)
Destroy(io_comprador)
end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Altera$$HEX2$$e700f500$$ENDHEX$$es salvas com sucesso!")
	Open(w_Aguarde)
	w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es ..."
	dw_2.Event ue_Retrieve()
	Close(w_Aguarde)
End If

Return AncestorReturnValue
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge650_considerar_saldo_agd
integer x = 91
integer y = 1168
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge650_considerar_saldo_agd
integer x = 55
integer y = 1096
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge650_considerar_saldo_agd
integer y = 92
integer width = 2642
integer height = 416
string dataobject = "dw_ge650_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long ll_Nulo

String ls_Nulo

SetNull(ll_Nulo)
SetNull(ls_Nulo)

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
		
	Case "nm_fornecedor"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
		
//	Case "id_planilha"
//		If Data = "S" Then
//			OpenWithParm(w_ge629_filtro_via_planilha, '')
//			
//			is_Produto = Message.StringParm
//			
//			If Trim(is_Produto) = "" Or IsNull(is_Produto) Then
//				Return 1
//			End If
//					
//			dw_1.Object.De_Produto[1] = ls_Nulo
//			dw_1.Object.Cd_Produto[1] = ll_Nulo
//			
//		Else
//			is_Produto = ""
//		End If
		
	Case "nm_usuario_comprador"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_comprador.nm_usuario Then
			Return 1
			End If
		Else
			io_comprador.of_Inicializa()
				
			This.Object.nr_matricula	[1] = io_comprador.nr_matricula
			This.Object.nm_usuario		[1] = io_comprador.nm_usuario
		End If
	End Choose

end event

event dw_1::ue_key;call super::ue_key;dw_1.AcceptText()

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			If ivo_Produto.Localizado Then
				This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
				
				is_planilha = "N"
				//dw_1.Object.Id_Planilha.Visible = False
				is_Produto = ""
			End If
		
		Case "nm_fornecedor"
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			If ivo_Fornecedor.Localizado Then
				This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
				This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
			End If
			
		Case "nm_usuario_comprador"
			io_comprador.of_Localiza_comprador( This.GetText() )
			If io_comprador.Localizado Then
				This.Object.nr_matricula				[1] = io_comprador.nr_matricula
				This.Object.nm_usuario_comprador		[1] = io_comprador.nm_usuario
			End If
			
	End Choose
End If

If Key = KeyEscape! Then
	Close(Parent)
End If
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge650_considerar_saldo_agd
integer y = 540
integer width = 4855
integer height = 1428
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge650_considerar_saldo_agd
integer y = 12
integer width = 2734
integer height = 524
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge650_considerar_saldo_agd
integer y = 616
integer width = 4759
integer height = 1324
string dataobject = "dw_ge650_considerar_saldo_agd"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long		ll_Cd_Produto
Long		ll_Divisao
Long		ll_Dias_Produto_Colocado
Long		ll_Dias_Estoque

String	ls_Cd_Fornecedor
String	ls_cd_grupo
String	ls_Nm_Usuario_Comprador
String	ls_Id_Situacao_Clamed
String	ls_Dh_Saldo_Produto
String	ls_Sit_Agendamento

dw_1.AcceptText()

ll_Cd_Produto					= dw_1.Object.Cd_Produto				[1]
ls_Cd_Fornecedor 				= dw_1.Object.Cd_Fornecedor			[1]
ls_cd_grupo						= dw_1.Object.Cd_grupo					[1]
ls_Id_Situacao_Clamed		= dw_1.Object.Id_Situacao_clamed		[1]
ls_Nm_Usuario_Comprador		= dw_1.Object.nm_usuario_comprador	[1]
ll_Dias_Produto_Colocado	= dw_1.Object.nr_saldo_colocado		[1]
ll_Dias_Estoque				= dw_1.Object.nr_dias_estoque			[1]
ls_Nm_Usuario_Comprador		= dw_1.Object.nr_matricula      		[1]
ls_Sit_Agendamento			= dw_1.Object.id_situacao_agendamento [1]

If ls_Nm_Usuario_Comprador = "" then
    SetNull(ls_Nm_Usuario_Comprador)
End If

//Produto
If Not IsNull(ll_Cd_Produto) Then
	This.of_AppendWhere_SubQuery("pg.cd_produto = " + String(ll_Cd_Produto), 1)
End if

//Fornecedor
If Not IsNull(ls_Cd_Fornecedor) and Trim(ls_Cd_Fornecedor) <> "" Then
	This.of_AppendWhere_SubQuery("pg.cd_fornecedor_usual = '" + ls_Cd_Fornecedor + "'", 1)
End If

//Matricula Comprador
If Not IsNull( ls_Nm_Usuario_Comprador ) Then
	This.of_AppendWhere_SubQuery("pc.nr_matricula_comprador = '" + ls_Nm_Usuario_Comprador + "'", 1)
End If

//Situa$$HEX2$$e700e300$$ENDHEX$$o do Produto
If ls_Id_Situacao_Clamed <> "T" Then
	This.of_AppendWhere_SubQuery("pg.id_situacao = '" + ls_Id_Situacao_Clamed + "'", 1)
End If

//Grupo(Medicamentos,Perfumaria etc)
If Not IsNull(ls_cd_grupo) and Trim(ls_cd_grupo) <> "0" Then
	This.of_AppendWhere_SubQuery("substring(pg.cd_subcategoria, 1, 1) = '" + ls_cd_grupo + "'", 1)
End If

//Situ$$HEX2$$e700e300$$ENDHEX$$o Agendamento
If ls_Sit_Agendamento <> "T" Then
	This.of_AppendWhere_SubQuery("pc.id_cons_agend_saldo_cd_pesc = '" + ls_Sit_Agendamento + "'", 1)
End If

// Divisao-  Adicionado por ultimo pois este filtro adiciona um novo where
If Not IsNull(ll_Divisao) And ll_Divisao > 0 Then
	This.of_appendwhere_subquery("pg.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + ls_Cd_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 2)
End If

Return 1
end event

