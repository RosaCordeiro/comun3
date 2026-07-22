HA$PBExportHeader$w_ge135_consulta_pedido_filial_produto.srw
forward
global type w_ge135_consulta_pedido_filial_produto from dc_w_selecao_lista_detalhe
end type
end forward

global type w_ge135_consulta_pedido_filial_produto from dc_w_selecao_lista_detalhe
string tag = "w_ge135_consulta_pedido_filial_produto"
string accessiblename = "Consulta de Pedidos de Filiais por Produto (GE135)"
integer width = 3593
integer height = 2236
string title = "GE135 - Consulta de Pedidos de Filiais por Produto"
long backcolor = 80269524
event ue_consulta_distribuidoras ( )
event ue_consulta_filial ( )
end type
global w_ge135_consulta_pedido_filial_produto w_ge135_consulta_pedido_filial_produto

type variables
uo_filial ivo_filial
uo_produto ivo_produto

String ivs_filiais, ivs_nulo

uo_ge216_filiais ivo_Selecao_filiais
end variables

forward prototypes
public subroutine wf_consulta_promocao ()
public subroutine wf_consulta_pedido ()
public function boolean wf_localiza_grupo (ref string as_grupo)
public subroutine wf_consulta_detalhe_pedido ()
public subroutine wf_consulta_ordem_distribuicao ()
end prototypes

event ue_consulta_distribuidoras();Long lvl_Produto
Long ll_Filial
Long ll_Linha

String ls_Uf
String ls_Parametro

w_ge162_Consulta_Produto_Distribuidora lvw

ll_Linha		= dw_2.GetRow()
lvl_Produto	= dw_1.Object.Cd_Produto[1]

If Not IsNull(lvl_Produto) And lvl_Produto > 0 Then
	If ll_Linha > 0 Then
		ll_Filial	= dw_2.Object.Cd_Filial						[ll_Linha]
		ls_Uf		= dw_2.Object.Cd_Unidade_Federacao	[ll_Linha]
		
		ls_Parametro = ls_Uf + String(lvl_Produto, "000000")
		OpenSheetWithParm(lvw, ls_Parametro, This, 0, Original! )
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi localizada na Lista de Pedidos Completos.", Exclamation!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar as distribuidoras.", Exclamation!)
End If
end event

event ue_consulta_filial();Long ll_Filial
Long ll_Linha

dw_2.AcceptText()

ll_Linha	= dw_2.GetRow()

If ll_Linha > 0 Then
	ll_Filial	= dw_2.Object.Cd_Filial[ll_Linha]
	
	If Not IsNull(ll_Filial) and ll_Filial > 0 Then
		OpenWithParm(w_ge161_consulta_filial_distribuidora_response, String(ll_Filial, "0000"))
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi localizada na Lista de Pedidos Completos.", Exclamation!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi localizada na Lista de Pedidos Completos.", Exclamation!)
End If
end event

public subroutine wf_consulta_promocao ();Long ll_Filial, ll_Promocao, ll_Produto

String ls_Parametro

dw_1.acceptText()
dw_3.AcceptText()

ll_Filial	 		= dw_2.Object.cd_filial				[ dw_2.GetRow() ]
ll_Produto 		= ivo_produto.cd_Produto
ll_Promocao 	= dw_3.Object.cd_promocao_sos [ dw_3.GetRow() ]

If IsNull( ll_Promocao ) Then Return

ls_Parametro  = String( ll_Filial,'0000') + String( ll_Promocao,'000000') + String( ll_Produto,'0000000')

If Not IsNull( ls_Parametro ) Or ls_Parametro <> "" Then
	If dw_3.Object.Id_Tipo_Promocao[dw_3.GetRow()] <> "P" Then
		OpenWithParm( w_ge135_consulta_promocao, ls_Parametro )
	Else
		OpenWithParm( w_ge135_consulta_promocao_plan, ls_Parametro )
	End If
End If
end subroutine

public subroutine wf_consulta_pedido ();Long ll_Filial, ll_Produto, ll_Ped_Emp

String ls_Pesquisa

dw_2.AcceptText()
dw_3.AcceptText()

ll_Filial	 		= dw_2.Object.cd_filial					[dw_2.GetRow()]
ll_Ped_Emp 		= dw_3.Object.nr_pedido_empurrado[dw_3.GetRow()]
ll_Produto 		= ivo_produto.cd_Produto

ls_Pesquisa		= String(ll_Filial) +  '@#!' + String(ll_Ped_Emp) +  '@#!' + String(ll_Produto)

// Abre a Tela com a Chave para DataWindow
If (len(ls_Pesquisa)>0) Then
	openwithparm(w_ge135_historico_alteracao,ls_Pesquisa)
End If
end subroutine

public function boolean wf_localiza_grupo (ref string as_grupo);Select de_grupo
	Into: as_Grupo
From vw_classificacao_produto
Where cd_subcategoria = :ivo_Produto.Cd_Subcategoria
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//
	Case 100
		//
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o grupo do produto." + SqlCa.SqlErrText)
		Return False
End Choose

Return True
end function

public subroutine wf_consulta_detalhe_pedido ();Long ll_Filial, ll_Produto, ll_Pedido

String ls_Parametro

dw_2.acceptText()

If dw_2.RowCount() > 0 Then
	ll_Filial	 	= dw_2.Object.cd_filial			[ dw_2.GetRow() ]
	ll_Pedido		= dw_2.Object.nr_pedido_filial	[ dw_2.GetRow() ]
	ll_Produto 	= ivo_produto.cd_Produto
	
	ls_Parametro  = String( ll_Filial,'0000') + String( ll_Pedido,'00000000') + String( ll_Produto,'0000000')
	
	If Not IsNull( ls_Parametro ) Or ls_Parametro <> "" Then OpenWithParm( w_ge135_consulta_detalhe, ls_Parametro )
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum pedido foi selecionado.")	
End If
end subroutine

public subroutine wf_consulta_ordem_distribuicao ();dw_1.acceptText()
dw_2.acceptText()

str_parametros st

If dw_2.RowCount() > 0 Then
	st.cd_filial 			= dw_2.Object.cd_filial			[ dw_2.GetRow() ]
	st.nr_pedido_filial 	= dw_2.Object.nr_pedido_filial	[ dw_2.GetRow() ]
	st.cd_produto		= ivo_produto.cd_Produto

	OpenWithParm( w_ge135_lista_distribuicao, st )	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum pedido foi selecionado.")	
End If



end subroutine

on w_ge135_consulta_pedido_filial_produto.create
call super::create
end on

on w_ge135_consulta_pedido_filial_produto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Produto)
Destroy(ivo_Selecao_filiais)
end event

event ue_postopen;call super::ue_postopen;ivo_Filial  = Create uo_Filial
ivo_Produto = Create uo_Produto

ivo_Selecao_filiais 	= Create uo_ge216_filiais

dw_1.Object.Dt_Inicio[1] = Today()
dw_1.Object.Dt_Fim   [1] = Today()

dw_2.ivo_Controle_Menu.of_SalvarComo(True)
end event

event key;call super::key;//If dw_3.RowCount() > 0 Then
//	
//	SetPointer(HourGlass!)
//	
//	Choose Case Key
//			
//		Case KeyF2!	
//			wf_Consulta_Promocao()
//						
//	End Choose
//	
//	SetPointer(Arrow!)
//
//End If
end event

type dw_visual from dc_w_selecao_lista_detalhe`dw_visual within w_ge135_consulta_pedido_filial_produto
integer y = 1468
integer height = 180
end type

type gb_aux_visual from dc_w_selecao_lista_detalhe`gb_aux_visual within w_ge135_consulta_pedido_filial_produto
integer y = 1452
integer height = 268
end type

type gb_3 from dc_w_selecao_lista_detalhe`gb_3 within w_ge135_consulta_pedido_filial_produto
integer x = 14
integer y = 1400
integer width = 3506
integer height = 628
string text = "Lista de Pedidos por Distribuidora"
end type

type gb_1 from dc_w_selecao_lista_detalhe`gb_1 within w_ge135_consulta_pedido_filial_produto
integer x = 14
integer y = 0
integer width = 3502
integer height = 484
end type

type gb_2 from dc_w_selecao_lista_detalhe`gb_2 within w_ge135_consulta_pedido_filial_produto
integer x = 14
integer y = 496
integer width = 3502
integer height = 880
string text = "Lista de Pedidos Completos"
end type

type dw_1 from dc_w_selecao_lista_detalhe`dw_1 within w_ge135_consulta_pedido_filial_produto
integer x = 41
integer y = 56
integer width = 3451
integer height = 412
string dataobject = "dw_ge135_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long lvl_Lojas
Long lvl_Nulo

SetNull(lvl_Nulo)

Choose Case dwo.Name
	Case "nm_fantasia"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Fantasia[1] = ivo_Filial.Nm_Fantasia
		End If
		
	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then 
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto				[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto				[1] = ivo_Produto.De_Apresentacao_Venda
			This.Object.Id_Situacao				[1] = ""
			This.Object.Vl_Fator_Conversao	[1] = Long(ivo_Produto.Vl_Fator_Conversao)
			This.Object.Id_Controlado			[1] = ""
			This.Object.De_Grupo					[1] = ""
		End If
			
	Case "id_faturado", "id_pedido_para"
		dw_2.Reset()
		dw_3.Reset()		
		
	Case "id_conjunto_filial"
		
		ivs_filiais = ivs_nulo 
		
		If Data = 'C' Then
							
			OpenWithParm(w_ge216_selecao_filiais, ivo_Selecao_filiais)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				
				ivo_Filial.of_Inicializa()
			
				dw_1.Object.cd_filial  [1] = ivo_Filial.cd_filial
				dw_1.Object.nm_fantasia [1] = ivo_Filial.nm_fantasia
					
				ivs_filiais = ivo_Selecao_filiais.ivs_filiais
				
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")					
			End If

		End If
		
End Choose

dw_2.Reset()
end event

event dw_1::ue_key;String lvs_Coluna
String ls_Grupo

If Key = KeyEnter! Then
	lvs_Coluna = This.GetColumnName()
	
	Choose Case lvs_Coluna
		Case "nm_fantasia"
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				dw_1.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
				dw_1.Object.Nm_Fantasia[1] = ivo_Filial.Nm_Fantasia
				
				dw_1.Object.id_conjunto_filial[1] = "T"
			End If
			
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				dw_1.Object.Cd_Produto				[1] = ivo_Produto.Cd_Produto
				dw_1.Object.De_Produto				[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
				dw_1.Object.Id_Situacao				[1] = ivo_Produto.Id_Situacao
				dw_1.Object.Vl_Fator_Conversao	[1] = Long(ivo_Produto.Vl_Fator_Conversao)
				
				If Not wf_Localiza_Grupo(Ref ls_Grupo) Then Return -1
				
				dw_1.Object.De_Grupo[1] = ls_Grupo
				
				If (Not IsNull(ivo_Produto.Cd_Grupo_Psico)) And (ivo_Produto.Cd_Grupo_Psico <> "") Then
					This.Object.Id_Controlado[1] = "SIM"
				Else
					This.Object.Id_Controlado[1] = "N$$HEX1$$c300$$ENDHEX$$O"
				End If
			End If
	End Choose
End If

If Key = KeyF4! Then
	Event ue_Consulta_Filial()
End If

If Key = KeyF5! Then
	Event ue_Consulta_Distribuidoras()
End If

If Key = KeyF2! Then
	wf_consulta_detalhe_pedido()
End If

If Key = KeyF3! Then
	wf_consulta_ordem_distribuicao()
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Produto) Then
	This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If

If IsValid(ivo_Filial) Then
	This.Object.Nm_fantasia[1] = ivo_Filial.Nm_Fantasia
//	This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
End If
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::editchanged;call super::editchanged;Choose Case dwo.Name
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
		
	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then 
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto				[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto				[1] = ivo_Produto.De_Apresentacao_Venda
			This.Object.Id_Situacao				[1] = ""
			This.Object.Vl_Fator_Conversao	[1] = Long(ivo_Produto.Vl_Fator_Conversao)
			This.Object.Id_Controlado			[1] = ""
			This.Object.De_Grupo					[1] = ""
		End If
			
	Case "id_faturado", "id_pedido_para"
		dw_2.Reset()
		dw_3.Reset()		
		
End Choose
end event

type dw_2 from dc_w_selecao_lista_detalhe`dw_2 within w_ge135_consulta_pedido_filial_produto
integer x = 46
integer y = 552
integer width = 3442
integer height = 808
string dataobject = "dw_ge135_lista_pedido_filial"
end type

event dw_2::ue_recuperar;//OverRide

Date lvdt_Inicio, &
     lvdt_Fim
	  
Long lvl_Filial, &
     lvl_Produto
	  
 String lvs_Conjunto, &
     	lvs_Pedido_Para, &
     	lvs_WherePedido
	  
dw_1.AcceptText()

lvdt_Inicio 		= dw_1.Object.Dt_Inicio	[1]
lvdt_Fim    		= dw_1.Object.Dt_Fim	[1]
lvl_Filial  			= dw_1.Object.Cd_Filial	[1]
lvl_Produto 		= dw_1.Object.Cd_Produto[1]
lvs_Conjunto 	= dw_1.Object.Id_Conjunto_Filial[1]
lvs_Pedido_Para = dw_1.Object.Id_Pedido_Para[1]

If Not IsNull(lvl_Filial) Then
	dw_2.of_AppendWhere(" a.cd_filial = " + String(lvl_Filial) )
End If

If IsNull(lvl_Produto) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o produto.",Information!)
	dw_1.Event ue_Pos(1, "de_produto")
	Return -1
End If

If lvs_Conjunto = "C" Then
	If ivs_filiais <> "" And Not IsNull(ivs_filiais) Then
		dw_2.of_AppendWhere("a.cd_filial in (" + ivs_Filiais + ")")
	End If
End If

// 902727-27 - Mostrar pedidos para o CD ou para distribuidoras.
If lvs_Pedido_Para = 'C' Then  // Somente CD
	dw_2.of_AppendWhere("a.id_gerado_logistica = 'S'")
ElseIf lvs_Pedido_Para = 'D' Then // Somente Distribuidoras	
	dw_2.of_AppendWhere("a.id_gerado_logistica = 'N'")
End If

Return This.Retrieve(lvdt_Inicio, lvdt_Fim, lvl_Produto)
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_2::ue_key;call super::ue_key;If Key = KeyF4! Then
	Event ue_Consulta_Filial()
End If

If Key = KeyF5! Then
	Event ue_Consulta_Distribuidoras()
End If

If Key = KeyF2! Then
	wf_consulta_detalhe_pedido()
End If

If Key = KeyF3! Then
	wf_consulta_ordem_distribuicao()
End If


end event

type dw_3 from dc_w_selecao_lista_detalhe`dw_3 within w_ge135_consulta_pedido_filial_produto
integer x = 37
integer y = 1452
integer width = 3465
integer height = 556
string dataobject = "dw_ge135_lista_pedido_distribuidora"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event dw_3::ue_recuperar;// OverRide

Long lvl_Filial, &
     lvl_Produto, &
	  lvl_Pedido
	  
String lvs_Id_Faturado, &
     	lvs_Pedido_Para
	  
dw_1.AcceptText()
dw_2.AcceptText()

lvl_Produto 			= dw_1.GetItemNumber	(1, "cd_Produto")
lvs_Id_Faturado	= dw_1.GetItemString	(1, "id_Faturado")
lvs_Pedido_Para	= dw_1.GetItemString	(1, "id_Pedido_Para")

lvl_Filial  				= dw_2.GetItemNumber	(dw_2.GetRow(), "cd_Filial")
lvl_Pedido  			= dw_2.GetItemNumber	(dw_2.GetRow(), "nr_Pedido_Filial")

If lvs_Id_Faturado = 'S' Then
	This.Of_AppendWhere("b.id_situacao = 'F'")
End If

Return This.Retrieve(lvl_Filial, lvl_Pedido, lvl_Produto)
end event

event dw_3::ue_postretrieve;//Override
Return 1
end event

event dw_3::constructor;call super::constructor;This.Of_SetRowSelection()
end event

event dw_3::clicked;call super::clicked;String ls_Retorno

Long ll_Pedido_Emp, ll_Promocao

If dwo.Name = "st_localizar" Then
	If Row > 0 Then
		
		ll_Promocao 	= dw_3.Object.cd_promocao_sos[dw_3.GetRow()]
     	ll_Pedido_Emp 	= dw_3.Object.nr_pedido_empurrado[dw_3.GetRow()]
		  
		If IsNull(ll_Promocao) Then ll_Promocao = 0 
		If IsNull(ll_Pedido_Emp) Then ll_Pedido_Emp = 0 
						
		If ll_Promocao > 0 and ll_Pedido_Emp > 0 Then
			Open(w_ge135_promoco_ped_emp)
			ls_Retorno = Message.StringParm	
		ElseIf ll_Promocao > 0 Then
			ls_Retorno = 'PRO'
		Else
			ls_Retorno = 'PED'
		End If
		
		If ls_Retorno = 'PED' Then
			wf_Consulta_Pedido()
		End If
		
		If ls_Retorno = 'PRO' Then
			wf_Consulta_Promocao()
		End If
		
	End If
End If
end event

event dw_3::ue_key;call super::ue_key;If Key = KeyF4! Then
	Event ue_Consulta_Filial()
End If

If Key = KeyF5! Then
	Event ue_Consulta_Distribuidoras()
End If

If Key = KeyF2! Then
	wf_consulta_detalhe_pedido()
End If

If Key = KeyF3! Then
	wf_consulta_ordem_distribuicao()
End If
end event

event dw_3::rowfocuschanged;call super::rowfocuschanged;If currentRow > 0 then
	This.Object.t_mensagem.Text = This.Object.de_situacao[currentRow]
End If
end event

