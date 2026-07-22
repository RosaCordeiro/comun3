HA$PBExportHeader$w_ge347_produto_vinculado.srw
forward
global type w_ge347_produto_vinculado from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge347_produto_vinculado
end type
type cb_1 from commandbutton within w_ge347_produto_vinculado
end type
type cb_3 from commandbutton within w_ge347_produto_vinculado
end type
type cb_2 from commandbutton within w_ge347_produto_vinculado
end type
type gb_2 from groupbox within w_ge347_produto_vinculado
end type
end forward

global type w_ge347_produto_vinculado from dc_w_response_ok_cancela
integer width = 2176
integer height = 1520
string title = "GE347 - Grupo de Produtos Vinculados"
dw_2 dw_2
cb_1 cb_1
cb_3 cb_3
cb_2 cb_2
gb_2 gb_2
end type
global w_ge347_produto_vinculado w_ge347_produto_vinculado

type variables
uo_produto io_Produto
dc_uo_ds_base ids
str_ge347_promocao st

Boolean ib_Exclusao = False
Boolean ib_Permite_Alteracao
end variables

forward prototypes
public function boolean wf_verifica_produto_ja_foi_vinculado (long al_produto, string as_alteracao)
public function boolean wf_exclui_produto ()
end prototypes

public function boolean wf_verifica_produto_ja_foi_vinculado (long al_produto, string as_alteracao);String ls_Vinculo

Select v.de_vinculo
	Into :ls_Vinculo
From promocao_sos_vinculo v
	Inner Join promocao_sos_vinculo_prd p
		On p.cd_promocao_sos = v.cd_promocao_sos
		And p.nr_vinculo = v.nr_vinculo
Where v.cd_promocao_sos = :st.Cd_Promocao_Sos
	And p.cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		If as_Alteracao = "I" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto '" + io_Produto.ivs_Descricao_Apresentacao_Venda + " (" + String(al_Produto) + ")' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ vinculado $$HEX1$$e000$$ENDHEX$$ promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(st.Cd_Promocao_Sos) + "' no grupo '" + ls_Vinculo + "'.", Exclamation!)
			Return False
		End If
		
	Case 100
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar produto j$$HEX1$$e100$$ENDHEX$$ vinculado. " + SqlCa.SqlErrText, StopSign!)
		Return False
End Choose

Return True
end function

public function boolean wf_exclui_produto ();Long ll_Linha
Long ll_Produto
Long ll_Find

String ls_Erro
String ls_Chave
String ls_Nulo

dw_2.AcceptText()

SetNull(ls_Nulo)

For ll_Linha = 1 To ids.RowCount()

	ll_Produto = ids.Object.Cd_Produto[ll_Linha]

	ll_Find = dw_2.Find("cd_produto = " + String(ll_Produto), 1, dw_2.RowCount())

	If ll_Find < 0 Then
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da dw_2.", StopSign!)
		Return False
	End If

	If ll_Find > 0 Then Continue

	Delete From promocao_sos_vinculo_prd
		Where cd_promocao_sos = :st.Cd_Promocao_Sos
		And nr_vinculo = :st.Nr_Vinculo
		And cd_produto = :ll_Produto
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao deletar o produto. " + ls_Erro, StopSign!)
		Return False
	End If
	
	ls_Chave = MidA(String(st.Cd_Promocao_Sos) + Space(5), 1, 5) + "@#!" + String(st.Nr_Vinculo) + "@#!" + MidA(String(ll_Produto) + Space(6), 1, 6)
	
	If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_VINCULO_PRD', ls_Chave, 'CD_PRODUTO', String(ll_Produto), ls_Nulo, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'E', Ref ls_Erro, True) Then
		Return False
	End If
Next
end function

on w_ge347_produto_vinculado.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_1=create cb_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.gb_2
end on

on w_ge347_produto_vinculado.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.gb_2)
end on

event ue_postopen;call super::ue_postopen;st = Message.PowerObjectParm

io_Produto = Create uo_produto
ids = Create dc_uo_ds_base

ib_Exclusao = False

If Not ids.of_ChangeDataObject("dw_ge347_lista_produto_vinculado") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'dw_ge347_lista_produto_vinculado'.", StopSign!)
	Return
End If

If st.Id_Permite = "S" Then
	ib_Permite_Alteracao = True
Else
	ib_Permite_Alteracao = False
	
	cb_1.enabled = false
	cb_2.enabled = false
	cb_3.enabled = false
	
End If

dw_1.Event ue_Retrieve()
dw_2.Event ue_Retrieve()
end event

event close;call super::close;Destroy(io_Produto)
Destroy(ids)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge347_produto_vinculado
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge347_produto_vinculado
integer width = 1655
integer height = 184
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge347_produto_vinculado
integer width = 1595
integer height = 92
string dataobject = "dw_ge347_selecao_prd_vinculado"
end type

event dw_1::ue_recuperar;//OverRide

Return This.Retrieve(st.Cd_Promocao_Sos, st.Nr_Vinculo)
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge347_produto_vinculado
integer x = 1486
integer y = 1304
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Long ll_Linha
Long ll_Produto
Long ll_Achou
Long ll_Qtd
Long ll_Len

String ls_Alteracao
String ls_Erro
String ls_Nulo
String ls_Chave
String ls_Vinculo

dw_1.AcceptText()
dw_2.AcceptText()

If Not ib_Permite_Alteracao Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o tem permiss$$HEX1$$e300$$ENDHEX$$o para altera$$HEX2$$e700e300$$ENDHEX$$o.")
	Return -1
End If

If Not ib_Exclusao Then
	If dw_2.RowCount() = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe nenhum registro para ser alterado.")
		Return -1
	End If
End If

//If ib_Exclusao Then
//	If dw_2.RowCount() = 0 Then
//		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "TODOS os produtos foram exclu$$HEX1$$ed00$$ENDHEX$$dos. O V$$HEX1$$ed00$$ENDHEX$$nculo tamb$$HEX1$$e900$$ENDHEX$$m ser$$HEX1$$e100$$ENDHEX$$ exclu$$HEX1$$ed00$$ENDHEX$$do.~rDeseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then
//			SqlCa.of_Rollback();
//			dw_2.Event ue_Retrieve()
//			Return -1
//		End If
//	End If
//End If

SetNull(ls_Nulo)

If ib_Exclusao Or dw_2.ModifiedCount() > 0 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma as altera$$HEX2$$e700f500$$ENDHEX$$es?", Question!, YesNo!, 2) = 2 Then Return -1
End If

If dw_2.RowCount() > 0 Then
	If IsNull(dw_2.Object.Cd_Produto[dw_2.RowCount()]) Then
		dw_2.DeleteRow(dw_2.RowCount())
	End If
End If

If Not wf_Exclui_Produto() Then Return -1

If dw_2.ModifiedCount() > 0 Then

	For ll_Linha = 1 To dw_2.RowCount()
		
		ll_Produto	= dw_2.Object.Cd_Produto	[ll_Linha]
		ls_Alteracao	= dw_2.Object.Id_Alteracao	[ll_Linha]
		
//		If Not wf_Verifica_Produto_Ja_Foi_Vinculado(ll_Produto, ls_Alteracao) Then
//			SqlCa.of_Rollback();
//			Return -1
//		End If
			
		dw_2.Object.Cd_Promocao_Sos	[ll_Linha] = st.Cd_Promocao_Sos
		dw_2.Object.Nr_Vinculo				[ll_Linha] = st.Nr_Vinculo
		
		Select Count(*)
			Into: ll_Achou
		From promocao_sos_vinculo_prd
		Where cd_promocao_sos = :st.Cd_Promocao_Sos
			And nr_vinculo = :st.Nr_Vinculo
			And cd_produto = :ll_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback();
			SqlCa.of_MsgdbError("Erro ao consultar o produto vinculado. " + SqlCa.SqlErrText )
			Return -1
		End If
		
		If ll_Achou = 0 Then
			Insert Into promocao_sos_vinculo_prd(cd_promocao_sos, nr_vinculo, cd_produto)
				Values(:st.Cd_Promocao_Sos, :st.Nr_Vinculo, :ll_Produto)
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SqlErrText
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao salvar as altera$$HEX2$$e700f500$$ENDHEX$$es. " + ls_Erro, StopSign!)
				Return -1
			End If
			
			ll_Len = LenA(String(st.Cd_Promocao_Sos))
			
			ls_Chave = MidA(String(st.Cd_Promocao_Sos) + Space(ll_Len), 1, ll_Len) + "@#!" + String(st.Nr_Vinculo) + "@#!" + MidA(String(ll_Produto) + Space(6), 1, 6)
					
			If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_VINCULO_PRD', ls_Chave, 'CD_PRODUTO', ls_Nulo, String(ll_Produto), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'I', Ref ls_Erro, True) Then
				Return -1
			End If
		End If
	Next
End If

//If ib_Exclusao Then
//	If dw_2.RowCount() = 0 Then
//		Delete From promocao_sos_vinculo
//		Where cd_promocao_sos = :il_Promocao
//		And nr_vinculo = :il_Vinculo
//		Using SqlCa;
//		
//		If SqlCa.SqlCode = -1 Then
//			ls_Erro = SqlCa.SqlErrText
//			SqlCa.of_Rollback();
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o v$$HEX1$$ed00$$ENDHEX$$nculo." + ls_Erro, StopSign!)
//		End If
//		
//		ls_Vinculo	= dw_1.Object.De_Vinculo	[1]
//		ll_Qtd			= dw_1.Object.Qt_Vinculo	[1]
//		
//		ls_Chave = MidA(String(il_Promocao) + Space(4), 1, 4) + "@#!" + String(il_Vinculo)
//		
//		If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_VINCULO', ls_Chave, 'DT_VINCULO', ls_Vinculo, ls_Nulo, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'E', Ref ls_Erro, True) Then
//			Return -1
//		End If
//			
//		If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_VINCULO', ls_Chave, 'QT_VINCULO', String(ll_Qtd), ls_Nulo, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'E', Ref ls_Erro, True) Then
//			Return -1
//		End If
//	End If
//End If

SqlCa.of_Commit();

CloseWithReturn(Parent, "OK")
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge347_produto_vinculado
integer x = 1819
integer y = 1304
end type

event cb_cancelar::clicked;//OverRide

CloseWithReturn(Parent, "")
end event

type dw_2 from dc_uo_dw_base within w_ge347_produto_vinculado
integer x = 59
integer y = 244
integer width = 2039
integer height = 1024
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge347_lista_produto_vinculado"
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event ue_recuperar;//OverRide

Return This.Retrieve(st.Cd_Promocao_Sos, st.Nr_Vinculo)
end event

event ue_key;call super::ue_key;Long ll_Find
Long ll_Nulo

String ls_Nulo

dw_2.AcceptText()

If Key = KeyEnter! Then
	If This.GetColumnName() = "de_produto" Then
		io_Produto.of_Localiza_Produto(This.GetText())
		
		If Not io_Produto.Localizado Then
			io_Produto.of_Inicializa()
		End If
		
		ll_Find = This.Find("cd_produto = " + String(io_Produto.Cd_Produto), 1, dw_2.RowCount())
		
		If ll_Find > 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto '" + String(io_Produto.Cd_Produto) + "' j$$HEX1$$e100$$ENDHEX$$ consta na lista.", Exclamation!)
			io_Produto.of_Inicializa()
			SetNull(ls_Nulo)
			SetNull(ll_Nulo)
			This.Object.Cd_Produto[This.GetRow()] = ll_Nulo
			This.Object.De_Produto[This.GetRow()] = ls_Nulo
			This.Event ue_Pos(This.GetRow(), "de_produto")
			Return -1
		End If
		
		If Not wf_Verifica_Produto_Ja_Foi_Vinculado(io_Produto.Cd_Produto, dw_2.Object.Id_Alteracao[This.GetRow()]) Then
			io_Produto.of_Inicializa()
			SetNull(ls_Nulo)
			SetNull(ll_Nulo)
			This.Object.Cd_Produto[This.GetRow()] = ll_Nulo
			This.Object.De_Produto[This.GetRow()] = ls_Nulo
			This.Event ue_Pos(This.GetRow(), "de_produto")
			Return -1
		End If
		
		This.Object.Cd_Produto	[This.GetRow()]= io_Produto.Cd_Produto
		This.Object.De_Produto	[This.GetRow()]= io_Produto.ivs_Descricao_Apresentacao_Venda
		dw_2.Event ue_AddRow()
	End If
End If
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_preinsertrow;call super::ue_preinsertrow;If This.Find("isnull(cd_produto)", 1, This.RowCount()) > 0 Then
	Return -1
Else
	Return 1	
End If
end event

event editchanged;call super::editchanged;Long ll_Nulo

SetNull(ll_Nulo)

This.Object.Cd_Produto[This.GetRow()] = ll_Nulo

If dwo.Name = "de_produto" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Produto.ivs_Descricao_Apresentacao_Venda Then
			Return 1
		End If
	Else
		io_Produto.of_Inicializa()
		
		This.Object.Cd_Produto	[This.GetRow()] = io_Produto.Cd_Produto
		This.Object.De_Produto	[This.GetRow()] = io_Produto.ivs_Descricao_Apresentacao_Venda
	End If
End If
end event

event itemchanged;call super::itemchanged;Long ll_Nulo

SetNull(ll_Nulo)

This.Object.Cd_Produto[This.GetRow()] = ll_Nulo

If dwo.Name = "de_produto" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Produto.ivs_Descricao_Apresentacao_Venda Then
			Return 1
		End If
	Else
		io_Produto.of_Inicializa()
		
		This.Object.Cd_Produto	[This.GetRow()] = io_Produto.Cd_Produto
		This.Object.De_Produto	[This.GetRow()] = io_Produto.ivs_Descricao_Apresentacao_Venda
	End If
End If
end event

event ue_addrow;call super::ue_addrow;If dw_2.GetRow() > 0 Then
	dw_2.Object.Id_Alteracao[dw_2.GetRow()] = "I"
End If

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;ids.Reset()

If dw_2.RowCount() > 0 Then
	If dw_2.RowsCopy(1, dw_2.RowCount(), Primary!, ids, 1, Primary!) = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no RowsCopy.", StopSign!)
		Return -1
	End If
End If

Return pl_Linhas
end event

event ue_deleterow;call super::ue_deleterow;If AncestorReturnValue Then
	ib_Exclusao = True
End If

Return AncestorReturnValue
end event

type cb_1 from commandbutton within w_ge347_produto_vinculado
integer x = 46
integer y = 1308
integer width = 274
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Inserir"
end type

event clicked;dw_2.Event ue_AddRow()
end event

type cb_3 from commandbutton within w_ge347_produto_vinculado
integer x = 352
integer y = 1308
integer width = 274
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Excluir"
end type

event clicked;If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe nenhum produto para ser exclu$$HEX1$$ed00$$ENDHEX$$do.")
	dw_2.SetFocus()
	Return -1
End If

dw_2.Event ue_DeleteRow()
end event

type cb_2 from commandbutton within w_ge347_produto_vinculado
integer x = 658
integer y = 1308
integer width = 402
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Excluir Todos"
end type

event clicked;If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe nenhum produto para ser exclu$$HEX1$$ed00$$ENDHEX$$do.")
	dw_2.SetFocus()
	Return -1
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta op$$HEX2$$e700e300$$ENDHEX$$o ir$$HEX1$$e100$$ENDHEX$$ excluir TODOS os produtos.~rDeseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then Return -1

Do While dw_2.RowCount() > 0
	If dw_2.DeleteRow(dw_2.RowCount()) = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir a linha.", StopSign!)
		Return -1
	End If
Loop

ib_Exclusao = True
end event

type gb_2 from groupbox within w_ge347_produto_vinculado
integer x = 32
integer y = 192
integer width = 2098
integer height = 1096
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

