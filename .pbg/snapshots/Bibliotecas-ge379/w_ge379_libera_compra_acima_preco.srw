HA$PBExportHeader$w_ge379_libera_compra_acima_preco.srw
forward
global type w_ge379_libera_compra_acima_preco from dc_w_cadastro_lista
end type
type cb_incluir from commandbutton within w_ge379_libera_compra_acima_preco
end type
type cb_1 from commandbutton within w_ge379_libera_compra_acima_preco
end type
end forward

global type w_ge379_libera_compra_acima_preco from dc_w_cadastro_lista
string accessiblename = "Libera a Compra com Valor Acima do Aceit$$HEX1$$e100$$ENDHEX$$vel (GE379)"
integer width = 2331
integer height = 1856
string title = "GE379 - Libera Compra de Distribuidora com Pre$$HEX1$$e700$$ENDHEX$$o Acima do Aceit$$HEX1$$e100$$ENDHEX$$vel"
cb_incluir cb_incluir
cb_1 cb_1
end type
global w_ge379_libera_compra_acima_preco w_ge379_libera_compra_acima_preco

type variables
uo_produto ivo_Produto
end variables

forward prototypes
public function boolean wf_grava_historico_alteracao (string as_tabela, string as_chave, string as_coluna, string as_de, string as_para, string as_operador, string as_tipo_alteracao)
end prototypes

public function boolean wf_grava_historico_alteracao (string as_tabela, string as_chave, string as_coluna, string as_de, string as_para, string as_operador, string as_tipo_alteracao);Insert Into historico_alteracao_tabela(nm_tabela, de_chave, nm_coluna, de_alteracao_de, de_alteracao_para, nr_matric_alteracao, id_alteracao)
Values (:as_Tabela, :as_chave, :as_Coluna, :as_De, :as_Para, :as_Operador, :as_tipo_alteracao)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700f500$$ENDHEX$$es. " + SqlCa.SQLErrText, StopSign!)
	SqlCa.of_RollBack()
	Return False
End If

Return True
end function

on w_ge379_libera_compra_acima_preco.create
int iCurrent
call super::create
this.cb_incluir=create cb_incluir
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_incluir
this.Control[iCurrent+2]=this.cb_1
end on

on w_ge379_libera_compra_acima_preco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_incluir)
destroy(this.cb_1)
end on

event close;call super::close;Destroy(ivo_Produto)
end event

event ue_postopen;call super::ue_postopen;ivo_Produto = Create uo_produto 

dw_1.ivo_Controle_Menu.of_SalvarComo(True)
//Parent.ivm_Menu.mf_SalvarComo(True)


end event

event ue_save;//OverRide

Long ll_Linhas, ll_Linha, ll_Produto
String ls_Erro, ls_bloqueado

dw_1.AcceptText()

ll_Linhas = dw_1.RowCount()

For ll_Linha = 1 To ll_Linhas
	
	ls_bloqueado = dw_1.Object.id_retira_bloq_compra_distrib[ll_linha]
	
	If ls_bloqueado <> "S" or IsNull(ls_bloqueado) Then
		
		ll_Produto = dw_1.Object.cd_produto[ll_linha]
		
		If Not IsNull(ll_Produto) And ll_Produto > 0 Then
		
			Update produto_central
			Set id_retira_bloq_compra_distrib = 'S'
			where cd_produto = :ll_Produto
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SQLErrText
				SqlCa.of_Rollback()
				MessageBox("Erro", "Erro ao atualizar o produto "+String(ll_Produto)+": "+ls_Erro)
				Return -1
			End If
			
			If Not wf_Grava_Historico_Alteracao("PRODUTO_CENTRAL", String(ll_Produto), "ID_RETIRA_BLOQ_COMPRA_DISTRIB" , "N", "S", String(gvo_Aplicacao.ivo_Seguranca.Nr_Matricula), "A") Then
				Return -1
			End If
		End If
	End If
Next

SqlCa.of_Commit()

This.ivm_Menu.mf_Confirmar(False)
This.ivm_Menu.mf_Cancelar(False)

dw_1.Retrieve()

Return 1
end event

event ue_cancel;//OverRide
This.ivm_Menu.mf_Confirmar(False)
This.ivm_Menu.mf_Cancelar(False)

dw_1.Retrieve()
end event

event ue_update;//OverRide
Return True
end event

event open;call super::open;String ls_Responsavel

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE379_LIBERACAO_PROCEDIMENTO", Ref ls_Responsavel) Then 
	Return Close(This)
End If
end event

type dw_visual from dc_w_cadastro_lista`dw_visual within w_ge379_libera_compra_acima_preco
end type

type gb_aux_visual from dc_w_cadastro_lista`gb_aux_visual within w_ge379_libera_compra_acima_preco
end type

type dw_1 from dc_w_cadastro_lista`dw_1 within w_ge379_libera_compra_acima_preco
integer y = 72
integer width = 2139
integer height = 1424
string dataobject = "dw_ge379_produtos"
end type

event dw_1::ue_deleterow;//OverRide

Long ll_Produto
String ls_Erro
If This.Event ue_PreDeleteRow() Then
	dw_1.AcceptText()
	
	ll_Produto = dw_1.Object.cd_produto[dw_1.GetRow()]
	
	Event ue_Save()
	
	If Not IsNull(ll_Produto) And ll_Produto > 0 Then
	
		Update produto_central
		Set 	id_retira_bloq_compra_distrib = 'N'
		where cd_produto = :ll_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SQLErrText
			SqlCa.of_Rollback()
			MessageBox("Erro", "Erro ao excluir o produto: "+ls_Erro)
			Return False
		End If
		
		If Not wf_Grava_Historico_Alteracao("PRODUTO_CENTRAL", String(ll_Produto), "ID_RETIRA_BLOQ_COMPRA_DISTRIB" , "S", "N", String(gvo_Aplicacao.ivo_Seguranca.Nr_Matricula), "A") Then
			Return False
		End If
	End If
	
	SqlCa.of_Commit()
	
	dw_1.Retrieve()
	Return True
End If

Return False
end event

event dw_1::ue_key;call super::ue_key;Long ll_Find

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			ll_Find = This.Find("cd_produto = " + String(ivo_Produto.cd_produto), 1, This.RowCount())
			
			If ll_Find > 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto " + ivo_Produto.ivs_Descricao_Apresentacao_Estoque + " (" + String(ivo_Produto.cd_produto) + ") j$$HEX1$$e100$$ENDHEX$$ consta na lista.", Exclamation!)
				ivo_Produto.of_Inicializa()
				Return -1
			End If
			
			If ivo_Produto.Localizado Then
				This.Object.cd_produto	[This.GetRow()] = ivo_Produto.cd_produto
				This.Object.de_produto	[This.GetRow()] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
			End If
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> '' Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque	Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.cd_produto[This.GetRow()] = ivo_Produto.cd_produto
			This.Object.de_Produto[This.GetRow()] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque		
		End If
			
End Choose
end event

event dw_1::ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	This.ivm_Menu.mf_Cancelar(True)
End If

Return AncestorReturnValue
end event

event dw_1::ue_cancel;//OverRide

SetPointer(HourGlass!)

ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)
ivm_Menu.m_Editar.m_Desfazer.Enabled = False

This.Event ue_Retrieve()

SetPointer(Arrow!)
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;
//If AncestorReturnValue > 0 Then
//	ivm_Menu.mf_Imprimir(True)
//Else
//	ivm_Menu.mf_Imprimir(False)
//End If
//
//This.ShareData(dw_2)

Return AncestorReturnValue
end event

type gb_1 from dc_w_cadastro_lista`gb_1 within w_ge379_libera_compra_acima_preco
integer width = 2217
integer height = 1504
integer weight = 700
string text = "N$$HEX1$$e300$$ENDHEX$$o Bloqueia a Compra de Distribuidora"
end type

type cb_incluir from commandbutton within w_ge379_libera_compra_acima_preco
integer x = 1413
integer y = 1540
integer width = 379
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Incluir (.xls)"
end type

event clicked;String ls_Retorno

OpenWithParm(w_ge379_inclui_exclui_planilha, "S")

ls_Retorno = Message.StringParm

If ls_Retorno = "OK" Then
	dw_1.Event ue_Retrieve()
End If
end event

type cb_1 from commandbutton within w_ge379_libera_compra_acima_preco
integer x = 1838
integer y = 1540
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Excluir (.xls)"
end type

event clicked;String ls_Retorno

OpenWithParm(w_ge379_inclui_exclui_planilha, "N")

ls_Retorno = Message.StringParm

If ls_Retorno = "OK" Then
	dw_1.Event ue_Retrieve()
End If
end event

