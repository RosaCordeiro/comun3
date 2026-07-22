HA$PBExportHeader$w_ge377_alteracao_preco.srw
forward
global type w_ge377_alteracao_preco from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge377_alteracao_preco from dc_w_selecao_lista_relatorio
integer width = 2249
integer height = 1276
string title = "GE377 - Altera$$HEX2$$e700e300$$ENDHEX$$o R$$HEX1$$e100$$ENDHEX$$pida de Pre$$HEX1$$e700$$ENDHEX$$os"
long backcolor = 80269524
end type
global w_ge377_alteracao_preco w_ge377_alteracao_preco

type variables
uo_produto ivo_produto

date ivdt_parametro
end variables

forward prototypes
public function boolean wf_update_produto (long al_produto, string as_uf, decimal ad_preco_venda)
public function boolean wf_verifica_bloqueio ()
end prototypes

public function boolean wf_update_produto (long al_produto, string as_uf, decimal ad_preco_venda);DateTime ldvt_Movimento

ldvt_Movimento = gvo_Parametro.of_Dh_Movimentacao()

Update produto_uf
Set vl_preco_venda_atual  			= :ad_preco_venda,
	vl_preco_venda_futuro 			= Null,
	nr_matric_preco_venda_atual    	= :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
	nr_matric_preco_venda_futuro 	= Null,
	dh_preco_venda_atual 			= :ldvt_Movimento,
	dh_preco_venda_futuro 			= Null
Where cd_produto 			= :al_Produto
  and cd_unidade_federacao 	= :as_UF
Using SqlCa;       

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o de venda atual do produto '" + String(al_Produto) + "'")
	Return False
End If

Return True
end function

public function boolean wf_verifica_bloqueio ();Long ll_Achou
Long ll_Linha
Long ll_Produto

String ls_Uf

dw_1.AcceptText()
dw_2.AcceptText()

ll_Produto = dw_1.Object.Cd_Produto[1]

For ll_Linha = 1 To dw_2.RowCount()

	ls_Uf = dw_2.Object.Cd_Uf[ll_Linha]

	Select Count(*)
	Into :ll_Achou
	from vw_promocao_estoque_minimo v
	where v.cd_produto = :ll_Produto
	 and v.cd_uf = :ls_Uf
	 and v.id_preco_bloqueado = 'S'
	 and v.id_situacao = 'L'
	 Using SqlCa;
	 
	 Choose Case SqlCa.SqlCode
		Case 0
			//Se estiver com bloqueio na promo$$HEX2$$e700e300$$ENDHEX$$o ou bloqueio no cadastro do produto o id_bloqueio ser$$HEX1$$e100$$ENDHEX$$ setado para 'S'
			If ll_Achou > 0 Then
				dw_2.Object.Id_Bloqueado_Promocao[ll_Linha] = "S"
			Else
				dw_2.Object.Id_Bloqueado_Promocao[ll_Linha] = "N"
			End If
			
			If dw_2.Object.Id_Bloqueado_Cadastro[ll_Linha] = "S" Or dw_2.Object.Id_Bloqueado_Promocao[ll_Linha] = "S" Then
				dw_2.Object.Id_Bloqueio[ll_Linha] = "S"
			End If
			
		Case -1
			SqlCa.of_MsgdbError("Erro ao consultar produto bloqueado na promoca$$HEX2$$e700e300$$ENDHEX$$o. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_bloqueio")
			Return False
	 End Choose
Next

Return True
end function

on w_ge377_alteracao_preco.create
call super::create
end on

on w_ge377_alteracao_preco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;ivo_Produto = Create uo_Produto
end event

event ue_save;//OverRide

Boolean lvb_Sucesso  = True

Long lvl_Linha   ,&
     lvl_Produto
	 
String lvs_Uf

Decimal lvdc_Preco_Atual,&
		lvdc_Preco_Novo

dw_1.AcceptText()
dw_2.AcceptText()

lvl_Produto = dw_1.Object.cd_produto[1]

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$os alterados entrar$$HEX1$$e300$$ENDHEX$$o em vigor hoje. ~r~r" +&
			  "Confirma a atualiza$$HEX2$$e700e300$$ENDHEX$$o mesmo assim ?", Question!, YesNo!, 2) = 2 Then
			  Return -1
End If

For lvl_Linha = 1 To dw_2.RowCount()
	
	lvdc_Preco_Atual   	= dw_2.Object.vl_preco_atual		[lvl_Linha]
	lvdc_Preco_Novo		= dw_2.Object.vl_preco_novo		[lvl_Linha]
	lvs_UF		       	= dw_2.Object.cd_uf						[lvl_linha]
	
	If Isnull(lvdc_Preco_Novo) or lvdc_Preco_Novo <= 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o pre$$HEX1$$e700$$ENDHEX$$o de venda atual corretamente.")
		dw_2.Event ue_Pos(lvl_Linha, "vl_preco_novo")
		dw_2.SetFocus()
		lvb_Sucesso = False
		Exit
	Else
		If lvdc_Preco_Novo <> lvdc_Preco_Atual Then
			If Not wf_Update_Produto(lvl_Produto, lvs_UF, lvdc_Preco_Novo) Then
				lvb_Sucesso = False
				Exit
			End If
		End If
	End If
	
Next

If lvb_Sucesso Then
	SqlCa.of_Commit();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os pre$$HEX1$$e700$$ENDHEX$$os foram atualizados com sucesso.")
	dw_2.Event ue_Retrieve()
Else
	SqlCa.of_Rollback();
	Return -1
End If

Return 1


end event

event ue_cancel;call super::ue_cancel;dw_2.Event ue_Cancel()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge377_alteracao_preco
integer x = 37
integer y = 656
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge377_alteracao_preco
integer x = 0
integer y = 584
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge377_alteracao_preco
integer x = 27
integer y = 216
integer width = 2130
integer height = 852
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge377_alteracao_preco
integer x = 27
integer y = 0
integer width = 2130
integer height = 204
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge377_alteracao_preco
integer x = 50
integer y = 68
integer width = 2085
integer height = 96
string dataobject = "dw_ge377_selecao"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "de_produto" Then
If Not IsNull(Data) and Trim(Data) <> "" Then
	If Not IsNull(This.Object.Cd_Produto[1]) Then
		If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque Then
			Return 1
		End If
	End If
Else
	ivo_Produto.of_Inicializa()			
	
	This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
	This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque			
End If	
	
End If



end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Produto) Then
	If Not IsNull(This.Object.Cd_Produto[1]) Then
		This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
	End If
End If





end event

event dw_1::ue_key;Integer lvi_Visible 

If Key = KeyEnter! Then
	If This.GetColumnName() = "de_produto" Then
		ivo_Produto.of_Localiza_Produto(This.GetText())		
		If ivo_Produto.Localizado Then
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
		End If			
	End If
End If


end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge377_alteracao_preco
integer x = 64
integer y = 292
integer width = 2062
integer height = 756
string dataobject = "dw_ge377_lista"
end type

event dw_2::ue_recuperar;//OverRide
Long lvl_Produto

dw_1.AcceptText()
lvl_Produto = dw_1.Object.cd_produto[1]

Return This.Retrieve(lvl_Produto)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long Lvl_Produto

dw_1.AcceptText()
lvl_Produto = dw_1.Object.cd_produto[1]

If IsNull(lvl_Produto) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar o produto.",Information!)
	Return -1 
End If

return AncestorReturnValue 
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

	This.Event RowFocusChanged(1)
	This.SetRow(1)
	
	If Not wf_Verifica_Bloqueio() Then
		Return -1
	End If
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

Parent.ivm_Menu.mf_Classificar(lvb_Classificar)
Parent.ivm_Menu.mf_Filtrar(lvb_Filtrar)
Parent.ivm_Menu.mf_Localizar(lvb_Localizar)
Parent.ivm_Menu.mf_Imprimir(lvb_Imprimir)

Return pl_Linhas
end event

event dw_2::itemchanged;call super::itemchanged;String ls_Bloqueado_Cadastro
String ls_Bloqueado_Promocao
String ls_Mensagem

If dwo.Name = "id_bloqueio" Then
	If Data = "N" Then
		ls_Bloqueado_Cadastro	= This.Object.Id_Bloqueado_Cadastro	[Row]
		ls_Bloqueado_Promocao	= This.Object.Id_Bloqueado_Promocao	[Row]
		
		If ls_Bloqueado_Cadastro = "S" And ls_Bloqueado_Promocao = "S" Then
			ls_Mensagem = "O produto est$$HEX1$$e100$$ENDHEX$$ com o pre$$HEX1$$e700$$ENDHEX$$o bloqueado no cadastro de produtos e na promo$$HEX2$$e700e300$$ENDHEX$$o."
		End If	
			
		If ls_Bloqueado_Cadastro = "S" And ls_Bloqueado_Promocao = "N" Then
			ls_Mensagem = "O produto est$$HEX1$$e100$$ENDHEX$$ com o pre$$HEX1$$e700$$ENDHEX$$o bloqueado no cadastro de produtos."
		End If	

		If ls_Bloqueado_Cadastro = "N" And ls_Bloqueado_Promocao = "S" Then
			ls_Mensagem = "O produto est$$HEX1$$e100$$ENDHEX$$ com o pre$$HEX1$$e700$$ENDHEX$$o bloqueado na promo$$HEX2$$e700e300$$ENDHEX$$o."
		End If	
		
		If ls_Bloqueado_Cadastro = "S" Or ls_Bloqueado_Promocao = "S" Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem + "~r~rDeseja alterar o pre$$HEX1$$e700$$ENDHEX$$o mesmo assim ?", Question!, YesNo!, 2) = 2 Then 
				Return 1
			End If
		End If
	End If
End If

ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)
end event

event dw_2::ue_cancel;call super::ue_cancel;ivi_Tipo_Cancelar = RETRIEVE
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_2::editchanged;call super::editchanged;ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge377_alteracao_preco
integer x = 1225
integer y = 496
integer width = 443
integer height = 236
integer taborder = 50
boolean vscrollbar = false
end type

