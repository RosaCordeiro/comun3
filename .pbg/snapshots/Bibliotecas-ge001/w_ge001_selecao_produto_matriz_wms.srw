HA$PBExportHeader$w_ge001_selecao_produto_matriz_wms.srw
forward
global type w_ge001_selecao_produto_matriz_wms from dc_w_selecao_generica
end type
end forward

global type w_ge001_selecao_produto_matriz_wms from dc_w_selecao_generica
integer x = 206
integer y = 364
integer width = 4032
integer height = 1900
string title = "GE001 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Produtos"
long backcolor = 80269524
end type
global w_ge001_selecao_produto_matriz_wms w_ge001_selecao_produto_matriz_wms

type variables
uo_Produto ivo_Produto_Parent
end variables

on w_ge001_selecao_produto_matriz_wms.create
call super::create
end on

on w_ge001_selecao_produto_matriz_wms.destroy
call super::destroy
end on

event open;call super::open;String lvs_Produto, &
       lvs_DW

ivo_Produto_Parent = Message.PowerObjectParm

lvs_Produto = ivo_Produto_Parent.ivs_Parametro

If lvs_Produto <> "" Then
	dw_1.Object.De_Produto[1] = lvs_Produto
	dw_1.AcceptText()
	
	ivb_Pesquisa_Direta = True	
End If
end event

event ue_postopen;call super::ue_postopen;dw_2.Object.De_Registro_Ms.EditMask.Mask = "#.####.####.###-#"
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge001_selecao_produto_matriz_wms
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge001_selecao_produto_matriz_wms
integer x = 18
integer y = 384
integer width = 3950
integer height = 1272
long backcolor = 80269524
string text = "Lista de Produtos"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge001_selecao_produto_matriz_wms
integer x = 18
integer y = 8
integer width = 3063
integer height = 368
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge001_selecao_produto_matriz_wms
integer x = 37
integer y = 72
integer width = 3031
integer height = 288
string dataobject = "dw_ge001_selecao_matriz"
end type

event dw_1::editchanged;call super::editchanged;string ls_cd_produto_sap

if dwo.name = 'cd_produto_sap' Then
	
		ls_cd_produto_sap = data
	
		if len(ls_cd_produto_sap) >= 2 and mid(ls_cd_produto_sap,1,1) = '%' Then
			
			dw_2.event ue_retrieve()
			
			post setcolumn('cd_produto_sap')
			post setfocus()
			post selecttext(len(ls_cd_produto_sap) +1,0)
		end if
	
	
end if
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge001_selecao_produto_matriz_wms
integer x = 46
integer y = 432
integer width = 3913
integer height = 1200
string dataobject = "dw_ge001_lista_matriz_wms"
boolean hscrollbar = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Descricao, &
       lvs_Barras, &
		 lvs_Situacao, &
		 lvs_Ativo, &
		 lvs_Pendente, &
		 lvs_Inativo , &
		 lvs_Registro_MS, &
		 lvs_Descricao_Busca, &
		 lvs_Sap, &
		 lvs_GTIN, &
		 ls_where, &
		 ls_lista
Long	 lvl_Codigo

uo_udi	luo_udi

dw_1.AcceptText()

lvs_Descricao     = dw_1.Object.De_Produto      		   [1]
lvs_Barras    	  = dw_1.Object.De_Codigo_Barras 	   [1]
lvs_Registro_MS = Trim(dw_1.Object.De_Registro_MS [1])
lvs_Ativo        	  = dw_1.Object.Id_Ativos       			   [1]
lvs_Pendente   	  = dw_1.Object.Id_Pendentes    		   [1]
lvs_Inativo       	  = dw_1.Object.Id_Inativos     			   [1]
lvs_Sap           	  = dw_1.Object.cd_produto_sap 		   [1]

If (IsNull(lvs_Descricao) or Trim(lvs_Descricao) = "") and (IsNull(lvs_Barras) or Trim(lvs_Barras) = "") and (IsNull(lvs_Registro_MS) or Trim(lvs_Registro_MS) = "") and (IsNull(lvs_Sap) or Trim(lvs_Sap) = "") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe algum par$$HEX1$$e200$$ENDHEX$$metro de sele$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
	dw_1.Event ue_Pos(1, "de_produto")
	Return -1	
End If

If ivo_Produto_Parent.ivb_Produto_Resgate_Clube Then
	This.of_AppendWhere("pg.qt_pontos_resgate > 0")
End If

If Not IsNull(lvs_Descricao) and Trim(lvs_Descricao) <> "" Then
	If IsNumber (lvs_Descricao) then
		This.of_AppendWhere ('pg.cd_produto = ' + lvs_Descricao)
	else
		/* Gambiarra - 28/01/2016 - Adapta$$HEX2$$e700e300$$ENDHEX$$o para a busca sempre mostrar tamb$$HEX1$$e900$$ENDHEX$$m os produtos de geladeira que comecem com o texto buscado
			Exemplo: NORIPURUM - ZZNORIPURU
		*/
		
		lvs_Descricao_Busca = lvs_Descricao
	
		If LeftA( lvs_Descricao, 2 ) = 'ZZ' Then
			lvs_Descricao_Busca = MidA( lvs_Descricao, 3 )
		End If
	
		If LeftA( lvs_Descricao, 3 ) = '%ZZ' Then
			This.of_AppendWhere("( pg.de_produto like '%" + MidA( lvs_Descricao, 4 ) + "%' Or pg.de_produto like '%ZZ" + MidA( lvs_Descricao, 4 ) + "%' )")
		Else
			This.of_AppendWhere("( pg.de_produto like '" + lvs_Descricao_Busca + "%' Or pg.de_produto like 'ZZ" + lvs_Descricao_Busca + "%' )")
		End If
		/***/
	End if
End If

If Not IsNull(lvs_Barras) and Trim(lvs_Barras) <> "" Then	
	lvs_GTIN = lvs_Barras
	
	If Len (lvs_Barras) > 20 then	//C$$HEX1$$f300$$ENDHEX$$digo de barras no formato UDI
		luo_udi = Create uo_udi
		Try
			If luo_udi.of_parse_udi (lvs_Barras) then
				lvs_GTIN = gf_tira_zero_esquerda (luo_udi.is_gtin)
			End if
		Finally
			Destroy luo_udi
		End try
	End if
	
	This.of_AppendWhere("pg.cd_produto in (select cd_produto from codigo_barras_produto where de_codigo_barras = '" + lvs_GTIN + "')")
End If

If Not IsNull(lvs_Registro_MS) and Trim(lvs_Registro_MS) <> "" Then	
	This.of_AppendWhere("pg.de_registro_ms like '" + lvs_Registro_MS + "%'") 
End If

// Monta lista de situa$$HEX2$$e700f500$$ENDHEX$$es
If lvs_Ativo = "S" Then
    ls_lista += "'A',"
End If

If lvs_Pendente = "S" Then
    ls_lista += "'P',"
End If

If lvs_Inativo = "S" Then
    ls_lista += "'I',"
End If

// Remove $$HEX1$$fa00$$ENDHEX$$ltima v$$HEX1$$ed00$$ENDHEX$$rgula
If Len(ls_lista) > 0 Then
    ls_lista = Left(ls_lista, Len(ls_lista) - 1)
End If

// Valida$$HEX2$$e700e300$$ENDHEX$$o
If Len(ls_lista) > 0 Then
    ls_where = "pg.id_situacao IN (" + ls_lista + ")"
    This.of_AppendWhere(ls_where)
Else
    MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos uma situa$$HEX2$$e700e300$$ENDHEX$$o.")
    dw_1.Event ue_Pos(1, "id_ativos")
    Return -1
End If

If Not IsNull(lvs_Sap) and Trim(lvs_Sap) <> "" Then
	if mid(lvs_Sap,1,1) = '%' Then
		This.of_AppendWhere("pg.cd_produto_sap like '" + lvs_Sap + "'")	
	else
		This.of_AppendWhere("pg.cd_produto_sap = '" + lvs_Sap + "'")
	end if
	
End If

Return 1
end event

event dw_2::ue_postretrieve;If pl_Linhas > 0 Then
	cb_Selecionar.Enabled = True
	This.SetRow(1)
	This.ScrollToRow(1)
	This.SetFocus()

	If pl_Linhas = 1 Then
		st_Mensagem.Text = "1 registro."
	Else
		st_Mensagem.Text = String(pl_Linhas, "###,###,##0") + " registros."
	End If
Else
	cb_Selecionar.Enabled = False
	dw_1.SetFocus()
	st_Mensagem.Text = "Nenhum registro encontrado."
End If

Return pl_Linhas
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge001_selecao_produto_matriz_wms
integer x = 3200
integer y = 1688
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

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge001_selecao_produto_matriz_wms
integer x = 3598
integer y = 1688
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Produto

SetNull(lvs_Produto)

CloseWithReturn(Parent, lvs_Produto)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge001_selecao_produto_matriz_wms
integer x = 2606
integer y = 1688
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge001_selecao_produto_matriz_wms
integer x = 37
integer y = 1708
integer width = 2021
long backcolor = 80269524
end type

