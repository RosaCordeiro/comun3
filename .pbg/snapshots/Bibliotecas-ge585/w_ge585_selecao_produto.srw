HA$PBExportHeader$w_ge585_selecao_produto.srw
forward
global type w_ge585_selecao_produto from dc_w_selecao_generica
end type
type cb_marcar from commandbutton within w_ge585_selecao_produto
end type
type cb_1 from commandbutton within w_ge585_selecao_produto
end type
end forward

global type w_ge585_selecao_produto from dc_w_selecao_generica
integer x = 206
integer y = 364
integer width = 3406
integer height = 1900
string title = "GE585 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Produtos"
long backcolor = 80269524
cb_marcar cb_marcar
cb_1 cb_1
end type
global w_ge585_selecao_produto w_ge585_selecao_produto

type variables
uo_Produto ivo_Produto
end variables

on w_ge585_selecao_produto.create
int iCurrent
call super::create
this.cb_marcar=create cb_marcar
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_marcar
this.Control[iCurrent+2]=this.cb_1
end on

on w_ge585_selecao_produto.destroy
call super::destroy
destroy(this.cb_marcar)
destroy(this.cb_1)
end on

event open;call super::open;String lvs_Produto, &
       lvs_DW

//ivo_Produto_Parent = Message.PowerObjectParm

//lvs_Produto = ivo_Produto_Parent.ivs_Parametro

//If lvs_Produto <> "" Then
//	dw_1.Object.De_Produto[1] = lvs_Produto
//	dw_1.AcceptText()
//	
//	ivb_Pesquisa_Direta = True	
//End If
end event

event ue_postopen;call super::ue_postopen;ivo_Produto = Create uo_Produto
end event

event close;call super::close;Destroy(ivo_Produto)
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge585_selecao_produto
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge585_selecao_produto
integer x = 18
integer y = 384
integer width = 3342
integer height = 1272
long backcolor = 80269524
string text = "Lista de Produtos"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge585_selecao_produto
integer x = 18
integer y = 8
integer width = 3346
integer height = 368
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge585_selecao_produto
integer x = 46
integer y = 72
integer width = 3223
integer height = 288
string dataobject = "dw_ge585_selecao_produto"
end type

event dw_1::itemchanged;call super::itemchanged;cb_marcar.enabled = False

If dwo.Name = "de_produto_codigo" Then 
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Trim(Data) <> ivo_Produto.de_produto Then
			Return 1
		End If
	Else
		
		ivo_Produto.of_Inicializa()
				
		dw_1.Object.de_produto_codigo	[1] = ivo_Produto.de_produto
		dw_1.Object.cd_produto				[1] = ivo_Produto.cd_produto

	End If
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then 
	
	Choose Case This.GetColumnName()
			
		Case "de_produto_codigo"
				
			ivo_Produto.of_localiza_Produto(This.GetText())
			
			If ivo_Produto.localizado Then
				
				dw_1.Object.de_produto_codigo	[1] = ivo_Produto.de_produto + " : " + ivo_Produto.de_apresentacao_venda
				dw_1.Object.cd_produto				[1] = ivo_Produto.cd_produto
				
				dw_1.Object.de_produto				[1] = ""
				
				cb_Pesquisar.Event Clicked()
				 
			Else
				
				ivo_Produto.of_Inicializa()
				
				dw_1.Object.de_produto_codigo	[1] = ivo_Produto.de_produto
				dw_1.Object.cd_produto				[1] = ivo_Produto.cd_produto
			End If
			
	End Choose
End If
end event

event dw_1::getfocus;//OverRide
end event

event dw_1::editchanged;call super::editchanged;If dwo.Name = 'de_produto' Then
	cb_Pesquisar.Default = True
Else
	cb_Pesquisar.Default = False

End If
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge585_selecao_produto
integer x = 46
integer y = 432
integer width = 3287
integer height = 1200
string dataobject = "dw_ge585_lista_produtos"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Descricao, &
       lvs_Barras, &
		 lvs_Situacao, &
		 lvs_Ativo, &
		 lvs_Pendente, &
		 lvs_Inativo

Long ll_Produto

dw_1.AcceptText()

lvs_Descricao   	= dw_1.Object.De_Produto      		[1]
lvs_Barras    	 	= dw_1.Object.De_Codigo_Barras	[1]
lvs_Ativo       		= dw_1.Object.Id_Ativos      		[1]
lvs_Pendente    	= dw_1.Object.Id_Pendentes    	[1]
lvs_Inativo     		= dw_1.Object.Id_Inativos     		[1]
ll_Produto			= dw_1.Object.cd_produto	    		[1]


If (IsNull(lvs_Descricao) or Trim(lvs_Descricao) = "") and (IsNull(lvs_Barras) or Trim(lvs_Barras) = "")  And IsNull(ll_Produto) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe algum par$$HEX1$$e200$$ENDHEX$$metro de sele$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
	dw_1.Event ue_Pos(1, "de_produto")
	Return -1	
End If

//If ivo_Produto_Parent.ivb_Produto_Resgate_Clube Then
//	This.of_AppendWhere("qt_pontos_resgate > 0")
//End If

If Not IsNull( ll_Produto ) Then
	This.of_AppendWhere("cd_produto = " + String( ll_Produto ) )
End If

If Not IsNull(lvs_Descricao) and Trim(lvs_Descricao) <> "" Then
	This.of_AppendWhere("de_produto like '" + lvs_Descricao + "%'")
End If

If Not IsNull(lvs_Barras) and Trim(lvs_Barras) <> "" Then	
	This.of_AppendWhere("cd_produto in (select cd_produto from codigo_barras_produto where de_codigo_barras = '" + lvs_Barras + "')")
End If

// Verifica o filtro da situa$$HEX2$$e700e300$$ENDHEX$$o
If lvs_Ativo    = "S" Then	lvs_Situacao  = "A"
If lvs_Pendente = "S" Then	lvs_Situacao += "P"
If lvs_Inativo  = "S" Then	lvs_Situacao += "I"

If LenA(lvs_Situacao) > 0 Then
	If LenA(lvs_Situacao) < 3 Then
		If LenA(lvs_Situacao) = 1 Then
			This.of_AppendWhere("id_situacao = '" + lvs_Situacao + "'")
		Else
			This.of_AppendWhere("id_situacao in ('" + LeftA(lvs_Situacao, 1) + "', '" + RightA(lvs_Situacao, 1) + "')")
		End If
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos uma situa$$HEX2$$e700e300$$ENDHEX$$o.")
	dw_1.Event ue_Pos(1, "id_ativos")
	Return -1
End If

Return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	cb_marcar.enabled = True
Else
	cb_marcar.enabled = False
End If

Return pl_Linhas
end event

event dw_2::editchanged;call super::editchanged;cb_marcar.enabled = False
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge585_selecao_produto
boolean visible = false
integer x = 1600
integer y = 1684
end type

event cb_selecionar::clicked;Long lvl_Linha

String lvs_Produto

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Produto = String(dw_2.Object.Cd_Produto[lvl_Linha])
	CloseWithReturn(Parent, lvs_Produto)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto na lista.")
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge585_selecao_produto
integer x = 2990
integer y = 1688
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Produto

SetNull(lvs_Produto)

CloseWithReturn(Parent, lvs_Produto)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge585_selecao_produto
integer x = 1257
integer y = 1688
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge585_selecao_produto
integer x = 37
integer y = 1700
integer width = 960
long backcolor = 80269524
end type

type cb_marcar from commandbutton within w_ge585_selecao_produto
integer x = 1728
integer y = 1688
integer width = 539
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Selecionar &Todos"
end type

event clicked;String lvs_Marcar

Long lvl_Linha

If cb_marcar.Text = "Selecionar &Todos" Then
	cb_marcar.Text = "&Desmarcar Todos"
	lvs_Marcar = 'S'
Else
	cb_marcar.Text = "Selecionar &Todos"
	lvs_Marcar = 'N'
End If

For lvl_Linha = 1 To dw_2.RowCount()
	dw_2.Object.id_selecionar[lvl_Linha] = lvs_Marcar
Next

end event

type cb_1 from commandbutton within w_ge585_selecao_produto
integer x = 2363
integer y = 1688
integer width = 581
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Confirmar Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;Long lvl_Linhas, lvl_Linha

String lvs_Produtos

dw_2.AcceptText()

lvl_Linhas = dw_2.RowCount()

If dw_2.Find("id_selecionar = 'S'", 1, lvl_Linhas ) <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.")
	Return
End If

For lvl_Linha = 1 to lvl_Linhas
	
	If dw_2.Object.id_selecionar[lvl_Linha] = 'S' Then
		lvs_Produtos = lvs_Produtos  + "|" + String(dw_2.Object.cd_produto[lvl_Linha]) 
	End If
	
	If lvl_Linha = lvl_Linhas Then
		lvs_Produtos = lvs_Produtos + "|"
	End If
Next

CloseWithReturn(Parent, lvs_Produtos)



end event

