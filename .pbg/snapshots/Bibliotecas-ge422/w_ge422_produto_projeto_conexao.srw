HA$PBExportHeader$w_ge422_produto_projeto_conexao.srw
forward
global type w_ge422_produto_projeto_conexao from dc_w_selecao_lista_relatorio
end type
type cb_selecao from commandbutton within w_ge422_produto_projeto_conexao
end type
type cb_1 from commandbutton within w_ge422_produto_projeto_conexao
end type
end forward

global type w_ge422_produto_projeto_conexao from dc_w_selecao_lista_relatorio
string accessiblename = "Filiais por Projeto de Conex$$HEX1$$e300$$ENDHEX$$o (GE422)"
integer width = 2656
integer height = 1912
string title = "GE422 - Cadastro de Produtos por Projeto de Conex$$HEX1$$e300$$ENDHEX$$o (Atualiza$$HEX2$$e700e300$$ENDHEX$$o no SAP)"
boolean resizable = false
cb_selecao cb_selecao
cb_1 cb_1
end type
global w_ge422_produto_projeto_conexao w_ge422_produto_projeto_conexao

type variables
uo_fornecedor io_Fornecedor
end variables

on w_ge422_produto_projeto_conexao.create
int iCurrent
call super::create
this.cb_selecao=create cb_selecao
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_selecao
this.Control[iCurrent+2]=this.cb_1
end on

on w_ge422_produto_projeto_conexao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_selecao)
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;io_Fornecedor = Create uo_Fornecedor

gf_ge003_lista_divisao_fornecedor(dw_1, "", 1)
end event

event close;call super::close;Destroy io_Fornecedor
end event

event ue_save;call super::ue_save;Long ll_Row
Long ll_Produto

String ls_Marcado
String ls_Marcado_Anterior
String ls_Update
String ls_Nulo
String ls_Projeto
String ls_Fornecedor
String ls_Id_Alteracao

SetNull(ls_Nulo)

ls_Fornecedor = dw_1.Object.cd_fornecedor[1]

If AncestorReturnValue = 1 Then

	Select id_projeto_conexao
	Into :ls_Projeto
	From fornecedor
	Where cd_fornecedor = :ls_Fornecedor
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Erro ao localizar o fornecedor.")
		Return -1
	End If
	
	For ll_Row = 1 To dw_2.RowCount()
		
		ll_Produto 					= dw_2.Object.cd_produto 				[ ll_Row ]
		ls_Marcado 					= dw_2.Object.id_Marcado				[ ll_Row ] 
		ls_Marcado_Anterior 		= dw_2.Object.id_Marcado_Anterior	[ ll_Row ]
		
		If ls_Marcado <> ls_Marcado_Anterior Then
		
			If ls_Marcado = 'S' Then
				ls_Projeto		= ls_Projeto
				ls_Id_Alteracao	= 'I'
			Else
				ls_Projeto		= ls_Nulo  //Nenhum 
				ls_Id_Alteracao	= 'E'
			End If
			
			Update produto_central
				set id_projeto_conexao = :ls_Projeto
			Where cd_produto = :ll_Produto
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgDbError("Erro ao atualizar o projeto conex$$HEX1$$e300$$ENDHEX$$o do produto " + String(ll_Produto) + "." )
				SqlCa.of_RollBack()	
				Return -1
			End If
			
			Insert historico_produto_conexao(cd_produto, dh_alteracao, id_alteracao)
											Values(:ll_Produto, getDate(), :ls_Id_Alteracao)
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgDbError("Erro ao gravar o hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700e300$$ENDHEX$$o do produto " + String(ll_Produto) + "." )
				SqlCa.of_RollBack()
				Return -1
			End If
			
			SqlCa.of_Commit()
			
		End If
		
	Next
	
	ivm_Menu.mf_Confirmar( False )
	ivm_Menu.mf_Cancelar( False )
	
	cb_selecao.Text = 'Selecionar Todos'
	cb_selecao.Enabled = False
	
	dw_2.Event ue_Retrieve()

End If

Return AncestorReturnValue

end event

event ue_saveas;call super::ue_saveas;
dw_2.Event ue_SaveAs()
end event

event open;call super::open;dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_2}
This.wf_SetUpdate_DW(lvo_Update)
end event

event ue_cancel;call super::ue_cancel;dw_2.Event ue_Cancel()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge422_produto_projeto_conexao
integer x = 658
integer y = 1132
integer height = 320
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge422_produto_projeto_conexao
integer x = 613
integer y = 460
integer height = 240
long backcolor = 16777215
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge422_produto_projeto_conexao
integer x = 32
integer y = 284
integer width = 2583
integer height = 1340
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge422_produto_projeto_conexao
integer y = 8
integer width = 2025
integer height = 268
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge422_produto_projeto_conexao
integer x = 64
integer y = 80
integer width = 1975
integer height = 176
string dataobject = "dw_ge422_selecao"
end type

event dw_1::ue_key;call super::ue_key;//If Key = KeyEnter! Then
//
//	If This.GetColumnName() = "nm_fornecedor" Then
//		
//		io_Fornecedor.of_Localiza_Fornecedor( This.GetText() )
//		
//		If io_Fornecedor.Localizado Then
//	
//			This.Object.nm_fornecedor	[1] = io_Fornecedor.nm_Fantasia
//			This.Object.cd_fornecedor  	[1] = io_Fornecedor.cd_fornecedor
//			
//		End If
//		
//	End If
//
//End If
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

This.AcceptText()

If dwo.Name = "cd_fornecedor" Then	
	If Not gf_ge003_lista_divisao_fornecedor(dw_1, Data, 1) Then
		Return
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge422_produto_projeto_conexao
integer y = 340
integer width = 2519
integer height = 1260
string dataobject = "dw_ge422_lista"
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;String ls_Projeto
String ls_Projeto_Atual
String ls_Fornecedor

Long ll_Produto
Long ll_Row

dw_1.AcceptText()

If pl_Linhas > 0 Then
	
	ls_Fornecedor = dw_1.Object.cd_fornecedor[1]

	Select id_projeto_conexao
	Into :ls_Projeto
	From fornecedor
	Where cd_fornecedor = :ls_Fornecedor
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Erro ao localizar o fornecedor.")
		Return -1
	End If
		
	cb_selecao.Enabled = True
	
	ivm_Menu.mf_SalvarComo(True)
	
	Open( W_Aguarde )
	
	w_Aguarde.Title = 'Localizando projeto conex$$HEX1$$e300$$ENDHEX$$o, aguarde...'
	w_Aguarde.uo_Progress.of_SetMax( pl_Linhas )
	
	For ll_Row = 1 To pl_Linhas
	
		w_Aguarde.uo_Progress.of_SetProgress( ll_Row )
	
		ll_Produto = This.Object.cd_produto [ ll_Row ]
		
		Select id_projeto_conexao
			into :ls_Projeto_Atual
		 From produto_central	
		Where cd_produto = :ll_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Erro ao localizar o produto '" + String(ll_Produto) + "'" )
			Close( w_Aguarde )
			Return -1
		End If
		
		If ls_Projeto_Atual = ls_Projeto Then
			This.Object.id_marcado 				[ ll_Row ] = 'S'
			This.Object.id_marcado_anterior 	[ ll_Row ] = 'S'
		End If
				
	Next
Else
	ivm_Menu.mf_SalvarComo(False)
	cb_selecao.Enabled = False
End If

Close( w_Aguarde )

Return pl_Linhas
end event

event dw_2::ue_recuperar;//OverRide

Long ll_Divisao

String ls_Fornecedor
String ls_Projeto

dw_1.AcceptText()

ls_Fornecedor	= dw_1.Object.cd_fornecedor				[1]
ll_Divisao			= dw_1.Object.Nr_Divisao_Fornecedor	[1]

If IsNull( ls_Fornecedor ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um laborat$$HEX1$$f300$$ENDHEX$$rio.")
	dw_1.Event ue_Pos(1, "cd_fornecedor")
	Return -1
End If

//Divis$$HEX1$$e300$$ENDHEX$$o Fornecedor
If Not IsNull(ll_Divisao) And ll_Divisao > 0 Then
	This.of_Appendwhere(" p.cd_produto in ( select cd_produto" + &
									 " from vw_divisao_fornecedor_produto" + &
									 " where cd_fornecedor = '" + ls_Fornecedor + "'" + &
									 " and nr_divisao = " + String(ll_Divisao) + ")")
End If

Return This.Retrieve( ls_Fornecedor )
end event

event dw_2::itemchanged;call super::itemchanged;Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)
end event

event dw_2::ue_preupdate;call super::ue_preupdate;Decimal ldc_Desconto

Long ll_Row

For ll_Row = 1 To dw_2.RowCount()
	
	ldc_Desconto = dw_2.Object.pc_desconto_conexao[ll_Row]
	
	If ldc_Desconto < 0 or ldc_Desconto > 99 Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O desconto $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido.", Exclamation!)
		dw_2.Event ue_Pos(ll_Row, "pc_desconto_conexao")
		Return -1
	End If

Next
end event

event dw_2::clicked;call super::clicked;If dwo.name = 'p_localizar' Then

	Long ll_GetRow
	Long ll_Produto
	
	This.AcceptText()
	
	ll_GetRow = This.GetRow()
	ll_Produto = This.Object.Cd_Produto[ll_GetRow]
	
	OpenWithParm(w_ge422_historico, String(ll_Produto))
	
End If
end event

event dw_2::editchanged;call super::editchanged;Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge422_produto_projeto_conexao
integer x = 2249
integer y = 28
integer width = 133
integer height = 124
end type

type cb_selecao from commandbutton within w_ge422_produto_projeto_conexao
integer x = 2066
integer y = 1640
integer width = 549
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Selecionar Todos"
end type

event clicked;Long ll_Linha

String ls_Marcar = 'S'

If This.Text = 'Selecionar Todos' Then
	This.Text = 'Desmarcar Todos'
Else
	This.Text = 'Selecionar Todos'
	ls_Marcar = 'N'
End If

For ll_Linha = 1 To dw_2.RowCount()
	dw_2.Object.id_Marcado[ ll_Linha ] = ls_Marcar
Next
end event

type cb_1 from commandbutton within w_ge422_produto_projeto_conexao
integer x = 32
integer y = 1640
integer width = 878
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Atualizar Desconto via Excel"
end type

event clicked;OpenWithParm(w_ge422_atualizacao_desconto, "")

If Not IsNull( dw_1.Object.cd_fornecedor[1] ) Then dw_2.Event ue_Retrieve()
end event

