HA$PBExportHeader$w_ge417_manutencao_divisao_fornecedor.srw
forward
global type w_ge417_manutencao_divisao_fornecedor from dc_w_selecao_lista_detalhe
end type
type cbx_produtos_ativos from checkbox within w_ge417_manutencao_divisao_fornecedor
end type
type cb_inserir from commandbutton within w_ge417_manutencao_divisao_fornecedor
end type
type cb_importar from commandbutton within w_ge417_manutencao_divisao_fornecedor
end type
end forward

global type w_ge417_manutencao_divisao_fornecedor from dc_w_selecao_lista_detalhe
string accessiblename = "Divis$$HEX1$$e300$$ENDHEX$$o do Fornecedor (GE417)"
integer width = 2939
integer height = 2064
string title = "GE417 - Divis$$HEX1$$e300$$ENDHEX$$o do Fornecedor"
event ue_addrow ( )
cbx_produtos_ativos cbx_produtos_ativos
cb_inserir cb_inserir
cb_importar cb_importar
end type
global w_ge417_manutencao_divisao_fornecedor w_ge417_manutencao_divisao_fornecedor

type variables
uo_fornecedor ivo_fornecedor
uo_Produto io_Produto

Boolean ib_Check


end variables

forward prototypes
public subroutine wf_excluir_produtos ()
public function boolean wf_verifica_fornecedor ()
end prototypes

event ue_addrow();dw_3.Event ue_AddRow()
end event

public subroutine wf_excluir_produtos ();Boolean lb_Sucesso = True

Long ll_Find, ll_Contador, ll_Divisao, ll_Produto

String ls_Fornecedor, ls_MSG

ll_Find = dw_3.Find("id_selecionar = 'S'", 1, dw_3.RowCount())

IF ll_Find = 0 then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem produtos selecionados para serem excluidos")
	Return
Elseif ll_Find < 0 then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no FIND ao localizar o produto selecionado.", StopSign!)
	Return
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a exclus$$HEX1$$e300$$ENDHEX$$o do produtos selecionados ?", Question!, YesNo!, 2) = 2 Then Return

For ll_Contador = 1 To dw_3.RowCount()
	
	If dw_3.Object.id_selecionar[ll_Contador]= 'S' Then
		
		ls_Fornecedor 	= dw_3.Object.cd_fornecedor	[ll_Contador]
		ll_Divisao 		= dw_3.Object.nr_divisao		[ll_Contador]
		ll_Produto		= dw_3.Object.cd_produto		[ll_Contador]
		
		Delete from fornecedor_divisao_produto
		Where cd_fornecedor	= :ls_Fornecedor
			and nr_divisao		= :ll_Divisao
			and cd_produto		= :ll_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_MSG = SQLCA.SQLErrText
			SqlCa.of_RollBack();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o produto '" + String(ll_Produto) + "'." + ls_MSG)
			lb_Sucesso = False
			Return 
		End If
	End If
	
Next

If lb_Sucesso Then
	SqlCa.of_Commit();
	dw_3.Event ue_Retrieve()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os produtos foram excluidos com sucesso.")
End If

end subroutine

public function boolean wf_verifica_fornecedor ();Boolean lb_Produto_Div = False

Long ll_Linha, ll_Linhas, ll_produto, ll_conta_registros, ll_Divisao, ll_Div_Cadastrada

String ls_Fornecedor,ls_cd_fornecedor,ls_Produto, ls_Nome_Fantasia, ls_Divisao, ls_Sort

dw_1.AcceptText()
dw_2.AcceptText()
dw_3.AcceptText()

ls_Fornecedor 	= dw_1.Object.cd_fornecedor[1]
ll_Divisao 		= dw_2.Object.nr_divisao[dw_2.GetRow()]

If IsNull(ll_Divisao) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a divis$$HEX1$$e300$$ENDHEX$$o do fornecedor.")
	Return False
End If

ll_Linhas = dw_3.RowCount()

For ll_Linha = 1 To ll_Linhas
	
	ll_Produto 	= dw_3.Object.cd_produto[ll_Linha]
	ls_Produto 	= dw_3.Object.de_produto[ll_Linha] + ' (' + String(dw_3.Object.cd_produto[ll_Linha]) + ')'
			
	Select g.cd_fornecedor_usual, f.nm_fantasia
		Into :ls_cd_fornecedor, :ls_Nome_Fantasia
	From produto_geral g
		inner join fornecedor f
			on f.cd_fornecedor = g.cd_fornecedor_usual
	Where g.cd_produto = :ll_produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o fornecedor associado ao produto. " + SqlCa.SqlErrText, StopSign!)
		Return False
	End If
	
	If ls_cd_fornecedor <> ls_Fornecedor Then
		dw_3.Object.Id_Divergencia[ll_Linha] = "1"
		dw_3.Object.De_Divergencia[ll_Linha] = "O produto pertence ao fornecedor '" + ls_Nome_Fantasia + ' ('	+ mid(ls_cd_fornecedor, 5,5) + ")'."
		dw_3.Object.Id_Selecionado[ll_Linha] = "S"
		lb_Produto_Div = True
		//Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto pertence ao fornecedor '" + ls_Nome_Fantasia + ' ('	+ mid(ls_cd_fornecedor, 5,5) + ")'.", Exclamation!)
		//dw_3.Event ue_Pos(ll_Linha, 'de_produto')
		//Return False
	End If
	
	//----
	
	ll_Div_Cadastrada = 0
	
	select top 1 coalesce(f.nr_divisao, 0), d.nm_divisao
	Into :ll_Div_Cadastrada, :ls_Divisao
	from fornecedor_divisao d
		inner join fornecedor_divisao_produto f
			on f.cd_fornecedor = d.cd_fornecedor
			and f.nr_divisao = d.nr_divisao
	where f.cd_fornecedor = :ls_Fornecedor
		and  f.nr_divisao <> :ll_Divisao
		and f.cd_produto = :ll_produto
	Using SqlCa	;

	If SqlCa.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o total de fornecedores. " + SqlCa.SqlErrText, StopSign!)
		Return False
	End If
	
	If ll_Div_Cadastrada > 0 Then
		If ll_Div_Cadastrada <> ll_Divisao Then
			dw_3.Object.Id_Divergencia[ll_Linha] = "2"
			dw_3.Object.De_Divergencia[ll_Linha] = "O produto est$$HEX1$$e100$$ENDHEX$$ relacionado para a divis$$HEX1$$e300$$ENDHEX$$o '" + String(ll_Div_Cadastrada) + " - " + ls_Divisao + "' deste fornecedor."
			dw_3.Object.Id_Selecionado[ll_Linha] = "S"
			lb_Produto_Div = True
	//		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto j$$HEX1$$e100$$ENDHEX$$ esta relacionado com outra divis$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
	//		dw_3.Event ue_Pos(ll_Linha, 'de_produto')
	//		Return False
		End If
	End If

	//----

Next

If lb_Produto_Div Then
	//Ordena para mostrar os produtos com diverg$$HEX1$$ea00$$ENDHEX$$ncia antes dos demais
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem produto(s) que est$$HEX1$$e300$$ENDHEX$$o com problema(s). Verifique antes de prosseguir.", Exclamation!)
	
	ls_Sort = "id_selecionado = 'N', de_produto"

	dw_3.SetSort( ls_Sort )
	dw_3.Sort()
	
	SetRedraw(True)
	
	dw_3.Event RowFocusChanged(1)
	
	Return False
End If

Return True
end function

on w_ge417_manutencao_divisao_fornecedor.create
int iCurrent
call super::create
this.cbx_produtos_ativos=create cbx_produtos_ativos
this.cb_inserir=create cb_inserir
this.cb_importar=create cb_importar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_produtos_ativos
this.Control[iCurrent+2]=this.cb_inserir
this.Control[iCurrent+3]=this.cb_importar
end on

on w_ge417_manutencao_divisao_fornecedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_produtos_ativos)
destroy(this.cb_inserir)
destroy(this.cb_importar)
end on

event ue_postopen;call super::ue_postopen;ivo_Fornecedor = Create uo_Fornecedor
io_Produto = Create uo_Produto

dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_3}
This.wf_SetUpdate_DW(lvo_Update)

dw_1.ivo_Controle_Menu.of_Incluir(True)
dw_2.ivo_Controle_Menu.of_Incluir(True)
dw_3.ivo_Controle_Menu.of_Incluir(True)

dw_1.ivo_Controle_Menu.of_Excluir(True)
dw_2.ivo_Controle_Menu.of_Excluir(True)
dw_3.ivo_Controle_Menu.of_Excluir(True)


//dw_1.ivo_Controle_Menu.of_Incluir(True)
//dw_2.ivo_Controle_Menu.of_Incluir(True)
//dw_3.ivo_Controle_Menu.of_Incluir(True)

//This.ivm_Menu.mf_Incluir(True)
//This.ivm_Menu.mf_Recuperar(True)


end event

event close;call super::close;Destroy ivo_Fornecedor
end event

event open;call super::open;dw_1.of_SetMenu(This.ivm_Menu)
dw_2.of_SetMenu(This.ivm_Menu)
dw_3.of_SetMenu(This.ivm_Menu)
end event

event ue_cancel;call super::ue_cancel;dw_2.Event ue_Cancel()
dw_3.Event ue_Cancel()
end event

type dw_visual from dc_w_selecao_lista_detalhe`dw_visual within w_ge417_manutencao_divisao_fornecedor
end type

type gb_aux_visual from dc_w_selecao_lista_detalhe`gb_aux_visual within w_ge417_manutencao_divisao_fornecedor
end type

type gb_3 from dc_w_selecao_lista_detalhe`gb_3 within w_ge417_manutencao_divisao_fornecedor
integer x = 27
integer y = 772
integer width = 2825
integer height = 1080
integer weight = 700
string text = "Produtos"
end type

type gb_1 from dc_w_selecao_lista_detalhe`gb_1 within w_ge417_manutencao_divisao_fornecedor
integer x = 27
integer y = 4
integer width = 2258
integer height = 184
integer weight = 700
end type

type gb_2 from dc_w_selecao_lista_detalhe`gb_2 within w_ge417_manutencao_divisao_fornecedor
integer x = 27
integer y = 212
integer width = 2816
integer height = 436
integer weight = 700
string text = "Divis$$HEX1$$f500$$ENDHEX$$es"
end type

type dw_1 from dc_w_selecao_lista_detalhe`dw_1 within w_ge417_manutencao_divisao_fornecedor
integer x = 46
integer y = 68
integer width = 2231
integer height = 80
string dataobject = "dw_ge417_selecao"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = 'nm_razao_social' Then
		ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			
		If ivo_Fornecedor.Localizado Then
			This.Object.Cd_Fornecedor		[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.nm_razao_social	[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;If  dwo.Name = "nm_razao_social" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Fornecedor.Nm_Razao_Social Then
			Return 1
		End If
	Else
		ivo_Fornecedor.of_Inicializa()
		
		This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
		This.Object.nm_razao_social[1] = ivo_Fornecedor.Nm_Razao_Social
	End If
End If

dw_2.Event ue_Reset()
dw_3.Event ue_Reset()
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Fornecedor) Then
	This.Object.Nm_Razao_Social[1] = ivo_Fornecedor.Nm_Razao_Social
End If
end event

event dw_1::ue_deleterow;// OverRide

wf_excluir_produtos()

Return True
end event

type dw_2 from dc_w_selecao_lista_detalhe`dw_2 within w_ge417_manutencao_divisao_fornecedor
integer x = 59
integer y = 272
integer width = 2757
integer height = 368
string dataobject = "dw_ge417_divisao"
end type

event dw_2::ue_recuperar;// OverRide

String ls_Fornecedor

dw_1.AcceptText()

ls_Fornecedor = dw_1.Object.cd_fornecedor[1]

If IsNull(ls_Fornecedor) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o fornecedor.")
	dw_1.Event ue_Pos(1, "nm_razao_social")
	Return -1
End If

Return This.Retrieve(ls_Fornecedor)
end event

event dw_2::ue_postretrieve;//OverRide

Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Imprimir

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	lvb_Imprimir = True
	
	//This.Event RowFocusChanged(1)
	
	cb_importar.Enabled = TRUE
	
	This.SetRow(1)
	This.SetFocus()
Else
	cb_importar.Enabled = False
	
	If pl_Linhas = 0 Then
		//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma divis$$HEX1$$e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

This.ivo_Controle_Menu.of_Classificar(lvb_Classificar)
This.ivo_Controle_Menu.of_Filtrar(lvb_Filtrar)
This.ivo_Controle_Menu.of_Localizar(lvb_Localizar)

This.ivo_Controle_Menu.of_Imprimir(lvb_Imprimir)
dw_1.ivo_Controle_Menu.of_Imprimir(lvb_Imprimir)
dw_2.ivo_Controle_Menu.of_Imprimir(lvb_Imprimir)

Return pl_Linhas
end event

event dw_2::buttonclicked;call super::buttonclicked;String ls_Fornecedor

Long ll_Divisao

dw_1.AcceptText()
dw_2.AcceptText()

ls_Fornecedor 	= dw_1.Object.cd_fornecedor[1]
ll_Divisao			= dw_2.Object.nr_divisao[dw_2.GetRow()]

If IsNull(ls_Fornecedor) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o fornecedor.")
	dw_1.Event ue_Pos(1, "nm_razao_social")
	Return -1
End If

OpenWithParm(w_ge417_cadastro_divisao, ls_Fornecedor + string(ll_Divisao, "00"))

dw_2.Event ue_Retrieve()
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_2::ue_deleterow;// OverRide

Return True
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;//If ivb_Selecao_Linhas Then
//	This.SelectRow(0, False)
//	This.SelectRow(CurrentRow, True)
//End If
//
//If wf_Valida_Salva() > 0 Then
//	Return 0
//Else
//	Return 1
//End If
//
//If CurrentRow > 0 Then
//	dw_3.Event ue_Retrieve()
//End If
end event

type dw_3 from dc_w_selecao_lista_detalhe`dw_3 within w_ge417_manutencao_divisao_fornecedor
integer x = 59
integer y = 836
integer width = 2766
integer height = 996
string dataobject = "dw_ge417_produtos"
boolean vscrollbar = true
end type

event dw_3::ue_recuperar;// OverRide

Long ll_Divisao

String ls_Fornecedor

dw_2.AcceptText()

ll_Divisao 		= dw_2.Object.nr_divisao[dw_2.GetRow()]
ls_Fornecedor 	= dw_2.Object.cd_fornecedor[dw_2.GetRow()]

If cbx_produtos_ativos.Checked Then
	This.of_AppendWhere("g.id_situacao in ('A')")	
End If	

Return This.Retrieve(ls_Fornecedor, ll_Divisao)
end event

event dw_3::destructor;call super::destructor;This.of_SetRowSelection()
end event

event dw_3::ue_postretrieve;// OverRide

Boolean 	lvb_Classificar, &
        		lvb_Filtrar, &
		  	lvb_Localizar, &
		  	lvb_Imprimir

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	lvb_Imprimir = True
Else
	If pl_Linhas = 0 Then
		//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem produtos relacionados para a divis$$HEX1$$e300$$ENDHEX$$o selecionada.", Information!)
	End If
End If

SetRedraw(True)

This.ivo_Controle_Menu.of_Classificar(lvb_Classificar)
This.ivo_Controle_Menu.of_Filtrar(lvb_Filtrar)
This.ivo_Controle_Menu.of_Localizar(lvb_Localizar)
This.ivo_Controle_Menu.of_Imprimir(lvb_Imprimir)

Return pl_Linhas
end event

event dw_3::ue_preinsertrow;//OverRide
dw_2.AcceptText()

If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a divis$$HEX1$$e300$$ENDHEX$$o.")
	Return -1
End If


If dw_3.RowCount() > 0 Then
	If IsNull(dw_3.Object.cd_produto[dw_3.RowCount()]) Then
		Return -1
	End If
End If

Return 1
end event

event dw_3::ue_key;call super::ue_key;Long ll_Linha, ll_Find, ll_Divisao, ll_conta_registros

String ls_Fornecedor, ls_Fornecedor_Produto

dw_1.AcceptText()
dw_2.AcceptText()

If dw_2.RowCount() > 0 Then
	ll_Divisao = dw_2.Object.nr_divisao[dw_2.GetRow()]
Else
	SetNull(ll_Divisao)
End If

ls_Fornecedor 	= dw_1.Object.cd_fornecedor[1]

If Key = KeyEnter! Then
	If Not IsNull(ll_Divisao) Then
		If This.GetColumnName() = "de_produto" Then
			io_Produto.of_Localiza_Produto(This.GetText())
			
			If io_Produto.Localizado Then
				
				ll_Find = This.Find("cd_produto = " + String(io_Produto.cd_produto), 1, This.RowCount())
				
				If ll_Find = -1 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto da DW.")
					Return -1
				ElseIf ll_Find > 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto j$$HEX1$$e100$$ENDHEX$$ foi informado.")
					Return -1
				End If
				
				ll_Linha = This.GetRow()
				
				This.Object.nr_divisao		[ll_Linha] = ll_Divisao
				This.Object.cd_fornecedor	[ll_Linha] = ls_Fornecedor
				This.Object.cd_produto		[ll_Linha] = io_Produto.cd_produto
				This.Object.de_produto		[ll_Linha] = io_Produto.ivs_Descricao_Apresentacao_Venda
				
				Choose Case io_Produto.id_situacao
					Case 'A'; This.Object.de_situacao [ll_Linha] = 'ATIVO'
					Case 'I'; This.Object.de_situacao [ll_Linha] = 'INATIVO'
					Case 'P'; This.Object.de_situacao [ll_Linha] = 'PENDENTE'
					Case Else
						This.Object.id_situacao [ll_Linha] = 'INDEFINIDA'
				End Choose
				
				If io_Produto.id_situacao = 'I' Then
					If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto esta INATIVO. ~r~rDeseja incluir mesmo assim ?", Question!, YesNo!, 2) = 2 Then
						This.DeleteRow(This.GetRow())
					End If
				End If
				
				If Not wf_Verifica_Fornecedor() Then Return -1
				
				// Colocar aqui um select para verificar se o produto j$$HEX1$$e100$$ENDHEX$$ n$$HEX1$$e300$$ENDHEX$$o esta cadastrado para a divis$$HEX1$$e300$$ENDHEX$$o deste fornecedor,
				// Pode ocorrer problema quando $$HEX1$$e900$$ENDHEX$$ inserido um produto na lista e  ao mesmo tempo alguem altera o cadastro de produto
				
//				select count(*)
//				Into :ll_conta_registros
//				from fornecedor_divisao_produto
//				where cd_fornecedor =:ls_Fornecedor  and  nr_divisao <> :ll_Divisao and cd_produto=:io_Produto.cd_produto
//          		Using SqlCa	;
//				
//				If SqlCa.SqlCode = -1 Then
//					SqlCa.of_MsgDbError("Erro ao localizar o total de fornecedores.")
//					Return -1
//				End If
//					
//				If ll_conta_registros > 0 then
//					Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto j$$HEX1$$e100$$ENDHEX$$ esta relacionado com outra divis$$HEX1$$e300$$ENDHEX$$o deste fornecedor.", Exclamation!)
//					This.DeleteRow(This.GetRow())
//					Return -1
//				End if
//				
//				If ls_Fornecedor <> io_Produto.cd_fornecedor_usual Then
//					
//					Select f.nm_fantasia + ' (' + substring(f.cd_fornecedor, 5,5) + ')' 
//					Into :ls_Fornecedor_Produto
//					from fornecedor f
//					where f.cd_fornecedor = :io_Produto.cd_fornecedor_usual
//					Using SqlCa	;
//					
//					If SqlCa.SqlCode = -1 Then
//						SqlCa.of_MsgDbError("Erro ao localizar o nome do fornecedor.")
//						Return -1
//					End If
//									
//					Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Este produto pertence ao fornecedor '" + ls_Fornecedor_Produto + "'.", Exclamation!)
//					
//					This.DeleteRow(This.GetRow())
//					
//					Return -1
//				End If
//										
			End If
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a divis$$HEX1$$e300$$ENDHEX$$o.")
		Return -1
	End If
End If
end event

event dw_3::itemchanged;call super::itemchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	This.ivm_Menu.mf_Confirmar(True)
	This.ivm_Menu.mf_Cancelar(True)
End If
end event

event dw_3::editchanged;call super::editchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	This.ivm_Menu.mf_Confirmar(True)
	This.ivm_Menu.mf_Cancelar(True)
End If

end event

event dw_3::constructor;call super::constructor;This.of_SetRowSelection()

This.ivs_Coluna_Sem_Validacao_Salva = {"id_selecionar"}

This.of_SetRowSelection("", "if(id_divergencia = ~"1~" or id_divergencia = ~"2~", rgb(255,0,0), rgb(0,0,0))")
end event

event dw_3::doubleclicked;call super::doubleclicked;Integer li_Row

String ls_Marcacao
		  
If dwo.Name = "p_imagem" Then
	
	If ib_Check Then
		ls_Marcacao = 'N'
		ib_Check 	 = False
	Else
		ls_Marcacao = 'S'
		ib_Check 	 = True
	End If
	
	For li_Row = 1 To This.RowCount()
		This.Object.id_selecionar[li_Row] = ls_Marcacao
	Next
	
End If

If dwo.Name = "p_1" Then	
	If ib_Check Then
		ls_Marcacao = 'N'
		ib_Check 	 = False
	Else
		ls_Marcacao = 'S'
		ib_Check 	 = True
	End If
	
	For li_Row = 1 To This.RowCount()
		This.Object.Id_Selecionado[li_Row] = ls_Marcacao
	Next	
End If
end event

event dw_3::ue_preupdate;call super::ue_preupdate;If Not wf_verifica_fornecedor() Then Return -1

Return 1
end event

event dw_3::rowfocuschanged;call super::rowfocuschanged;String ls_Divergencia
String ls_Descricao

If CurrentRow > 0 Then
	ls_Divergencia = This.Object.Id_Divergencia[CurrentRow]
	
	If ls_Divergencia = "1" Or ls_Divergencia = "2" Then
		ls_Descricao = This.Object.De_Divergencia[CurrentRow]
	Else
		ls_Descricao = ""
	End If
	
	This.Object.De_Divergencia_t.Text = ls_Descricao
End If
end event

event dw_3::ue_preretrieve;call super::ue_preretrieve;String ls_Sort = ''

SetRedraw(False)

This.SetSort( ls_Sort )
This.Sort()

Return 1
end event

event dw_3::ue_deleterow;//OverRide
Boolean lvb_Retorno = False

Long ll_Find
Long ll_Produto

String ls_Selecionado

This.AcceptText()

ll_Find = This.Find("id_selecionado = 'S'", 1, This.RowCount())

If ll_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado para ser exclu$$HEX1$$ed00$$ENDHEX$$do.")
	Return False
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a exclus$$HEX1$$e300$$ENDHEX$$o do(s) registro(s) selecionado(s) ?", Question!, YesNo!, 2) = 2 Then Return False

Do While ll_Find > 0
		
	ls_Selecionado = This.Object.Id_Selecionado[ll_Find]
	ll_Produto		= This.Object.Cd_Produto[ll_Find]	
	
	If ls_Selecionado = "S" Then

		If This.DeleteRow(ll_Find) = 1 Then
			If Not IsNull(ivm_Menu) Then			
				ivm_Menu.mf_Confirmar(True)
				ivm_Menu.mf_Cancelar(True)
				
				If This.RowCount() = 0 Then	
					ivm_Menu.mf_Imprimir(False)
					ivm_Menu.mf_Excluir(False)
				ElseIf This.RowCount() = 1 Then
					ivm_Menu.mf_Classificar(False)
					ivm_Menu.mf_Filtrar(False)
					ivm_Menu.mf_Localizar(False)
				End If	
			End If
			
			// Se for uma DW atualiz$$HEX1$$e100$$ENDHEX$$vel, habilita a valida$$HEX2$$e700e300$$ENDHEX$$o do closequery da janela
			If ivb_UpdateAble Then
				ivw_ParentWindow.ivb_Valida_Salva = True
			End If
			
			lvb_Retorno = True
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o registro.", StopSign!)
			Return False
		End If
	End If
	
	ll_Find = This.Find("id_selecionado = 'S'", 1, This.RowCount())
Loop

//dw_3.Event RowFocusChanged(1)

Return lvb_Retorno
end event

event dw_3::ue_cancel;call super::ue_cancel;This.Object.De_Divergencia_t.Text = ""
end event

type cbx_produtos_ativos from checkbox within w_ge417_manutencao_divisao_fornecedor
integer x = 46
integer y = 672
integer width = 800
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Somente Produtos Ativos ?"
boolean checked = true
boolean lefttext = true
end type

event clicked;If dw_2.RowCount() > 0 Then
	dw_3.Reset()
	dw_3.Event ue_Retrieve()
End If

end event

type cb_inserir from commandbutton within w_ge417_manutencao_divisao_fornecedor
integer x = 2336
integer y = 676
integer width = 507
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Incluir Divis$$HEX1$$e300$$ENDHEX$$o"
end type

event clicked;String ls_Fornecedor

Long ll_Retorno

dw_1.AcceptText()

ls_Fornecedor = dw_1.Object.cd_fornecedor[1]

If IsNull(ls_Fornecedor) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o fornecedor.")
	dw_1.Event ue_Pos(1, "nm_razao_social")
	Return -1
End If

OpenWithParm(w_ge417_cadastro_divisao, ls_Fornecedor + '00')

dw_2.Event ue_Retrieve()

//ll_Retorno = Message.DoubleParm
end event

type cb_importar from commandbutton within w_ge417_manutencao_divisao_fornecedor
integer x = 1742
integer y = 676
integer width = 571
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Importar &Produtos"
end type

event clicked;String ls_Fornecedor, ls_De_Produto, ls_Sit, ls_Fornecedor_Produto

Long ll_Linhas, ll_Linha, ll_Produto, ll_Find, ll_Insert, ll_Produtos_Inseridos, ll_Divisao

st_produto lst_produtos

dw_1.AcceptText()

ls_Fornecedor = dw_1.Object.cd_fornecedor[1]

If IsNull(ls_Fornecedor) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o fornecedor.")
	dw_1.Event ue_Pos(1, "nm_razao_social")
	Return -1
End If

If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem divis$$HEX1$$f500$$ENDHEX$$es selecionadas.")
	Return -1
Else
	ll_Divisao = dw_2.Object.nr_divisao[dw_2.GetRow()]
End If

OpenWithParm(w_ge417_importa_produtos_via_excel, ls_Fornecedor + '00')

lst_produtos = Message.PowerObjectParm	

If IsNull(lst_produtos) Then Return

ll_Linhas = UpperBound(lst_produtos.cd_produto[])

For ll_Linha = 1 To ll_Linhas
	
	ll_Produto = lst_produtos.cd_produto[ll_Linha]
	ls_De_Produto = lst_produtos.de_produto[ll_Linha]
	ls_Sit = lst_produtos.id_situacao[ll_Linha]
			
	ll_Find = dw_3.Find("cd_produto = " + String(ll_Produto) , 1, dw_3.RowCount())
	
	If ll_Find = 0 Then
		
		ll_Produtos_Inseridos ++
		
		ll_Insert = dw_3.InsertRow(0)
		
		Choose Case  ls_Sit
			Case 'A'; ls_Sit = 'ATIVO'
			Case 'I'; ls_Sit = 'INATIVO'
			Case 'P'; ls_Sit = 'PENDENTE'
		End Choose
		
		dw_3.Object.cd_produto		[ll_Insert] = ll_produto
		dw_3.Object.de_produto		[ll_Insert] = ls_De_Produto
		dw_3.Object.de_situacao	[ll_Insert] = ls_Sit
		dw_3.Object.nr_divisao		[ll_Insert] = ll_Divisao
		dw_3.Object.cd_fornecedor	[ll_Insert] = ls_Fornecedor
		
	ElseIf  ll_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no FIND ao localizar o produto na DW3.", StopSign!)
		Exit
	ElseIf ll_Find > 0 Then
		Continue
	End If

Next

If ll_Produtos_Inseridos > 0 Then
	Parent.ivm_Menu.mf_Confirmar(True)
	Parent.ivm_Menu.mf_Cancelar(True)
	
	//If Parent.ivb_UpdateAble Then
		Parent.ivb_Valida_Salva = True
	//End If
End If
end event

