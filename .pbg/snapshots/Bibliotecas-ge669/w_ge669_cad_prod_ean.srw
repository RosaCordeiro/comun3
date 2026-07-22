HA$PBExportHeader$w_ge669_cad_prod_ean.srw
forward
global type w_ge669_cad_prod_ean from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge669_cad_prod_ean from dc_w_cadastro_selecao_lista
integer width = 4197
integer height = 1556
string title = "GE669 - Cadastro Produto C$$HEX1$$f300$$ENDHEX$$digo da Distribuirora"
end type
global w_ge669_cad_prod_ean w_ge669_cad_prod_ean

type variables
uo_produto ivo_produto_dw1
uo_fornecedor ivo_fornecedor_dw1

uo_produto ivo_produto_dw2
uo_fornecedor ivo_fornecedor_dw2
end variables

forward prototypes
public function boolean wf_verifica_registro_existente (string as_produto_distribuidora, string as_distribuidora, ref boolean ab_existe, ref string as_msg)
end prototypes

public function boolean wf_verifica_registro_existente (string as_produto_distribuidora, string as_distribuidora, ref boolean ab_existe, ref string as_msg);Long ll_Produtos

SELECT count(*)
	INTO :ll_Produtos
FROM distribuidora_produto_sem_ean
WHERE	cd_distribuidora = :as_distribuidora
	AND		cd_produto_distribuidora		 = :as_produto_distribuidora
USING SqlCa;

If SqlCa.SqlCode = -1 Then
	as_msg = "Erro ao consultar dados da tabela distribuidora_produto_sem_ean ." + SQLCA.SQLErrText
	Return False
End If

If ll_Produtos > 0 Then
	ab_existe = True
Else 
	ab_existe = False
End if

Return True
end function

on w_ge669_cad_prod_ean.create
call super::create
end on

on w_ge669_cad_prod_ean.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;ivo_Produto_dw1 		= Create uo_Produto
ivo_Fornecedor_dw1 = Create uo_Fornecedor

ivo_Produto_dw2 		= Create uo_Produto
ivo_Fornecedor_dw2 = Create uo_Fornecedor
end event

event close;call super::close;Destroy(ivo_Produto_dw1)
Destroy(ivo_Produto_dw2)
Destroy(ivo_Fornecedor_dw1)
Destroy(ivo_Fornecedor_dw2)
end event

event ue_cancel;call super::ue_cancel;dw_2.Event ue_Retrieve()
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge669_cad_prod_ean
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge669_cad_prod_ean
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge669_cad_prod_ean
integer width = 1911
integer height = 264
string dataobject = "dw_ge669_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;String ls_parametro

ls_parametro = dwo.Name

Choose Case ls_parametro
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Produto_dw1.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
		Else
			ivo_Produto_dw1.of_Inicializa()
			
			This.Object.Cd_Produto[1] = ivo_Produto_dw1.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto_dw1.ivs_Descricao_Apresentacao_Estoque
		End If
		
	Case "de_distribuidora"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Fornecedor_dw1.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor_dw1.of_Inicializa()
			
			This.Object.cd_distribuidora[1] = ivo_Fornecedor_dw1.Cd_Fornecedor
			This.Object.de_distribuidora[1] = ivo_Fornecedor_dw1.Nm_Razao_Social
		End If
	
		
End Choose
end event

event dw_1::editchanged;call super::editchanged;String ls_parametro

ls_parametro = dwo.Name

Choose Case ls_parametro
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Produto_dw1.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
		Else
			ivo_Produto_dw1.of_Inicializa()
			
			This.Object.Cd_Produto[1] = ivo_Produto_dw1.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto_dw1.ivs_Descricao_Apresentacao_Estoque
		End If
		
	Case "de_distribuidora"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Fornecedor_dw1.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor_dw1.of_Inicializa()
			
			This.Object.cd_distribuidora[1] = ivo_Fornecedor_dw1.Cd_Fornecedor
			This.Object.de_distribuidora[1] = ivo_Fornecedor_dw1.Nm_Razao_Social
		End If

		
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Produto_dw1) Then
	This.Object.De_Produto[1] = ivo_Produto_dw1.ivs_Descricao_Apresentacao_Estoque
End If

If IsValid(ivo_Fornecedor_dw1) Then
	This.Object.de_distribuidora[1] = ivo_Fornecedor_dw1.Nm_Razao_Social
End If
end event

event dw_1::ue_key;call super::ue_key;dw_1.AcceptText()

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto_dw1.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto_dw1.Localizado Then
				This.Object.Cd_Produto[1] = ivo_Produto_dw1.Cd_Produto
				This.Object.De_Produto[1] = ivo_Produto_dw1.ivs_Descricao_Apresentacao_Estoque
			End If
		
		Case "de_distribuidora"
			ivo_Fornecedor_dw1.of_Localiza_Fornecedor(This.GetText())
			
			If ivo_Fornecedor_dw1.Localizado Then
				This.Object.cd_distribuidora[1] = ivo_Fornecedor_dw1.Cd_Fornecedor
				This.Object.de_distribuidora[1] = ivo_Fornecedor_dw1.Nm_Razao_Social
			End If
		
	End choose	
End if
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge669_cad_prod_ean
integer y = 384
integer width = 4110
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge669_cad_prod_ean
integer width = 2039
integer height = 376
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge669_cad_prod_ean
integer y = 460
integer width = 4032
string dataobject = "dw_ge669_cad_prod_sem_ean"
boolean vscrollbar = false
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_key;call super::ue_key;Long ll_Linha

dw_1.AcceptText()

If Key = KeyEscape! Then
	Close(Parent)
End If

If Key = KeyEnter! Then
	
	ll_Linha = getrow()

	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto_dw2.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto_dw2.Localizado Then
				This.Object.Cd_Produto[ll_Linha] = ivo_Produto_dw2.Cd_Produto
				This.Object.De_Produto[ll_Linha] = ivo_Produto_dw2.ivs_Descricao_Apresentacao_Estoque
			End If
		
		Case "nm_fantasia"
			ivo_Fornecedor_dw2.of_Localiza_Fornecedor(This.GetText())
			
			If ivo_Fornecedor_dw2.Localizado Then
				This.Object.cd_distribuidora[ll_Linha] = ivo_Fornecedor_dw2.Cd_Fornecedor
				This.Object.nm_fantasia[ll_Linha] = ivo_Fornecedor_dw2.Nm_Razao_Social
			End If
		
	End choose	
End if
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long	lvl_Produto
String	lvs_Distribuidora
String	lvs_Produto_Distribuidora

dw_1.AcceptText()

lvs_Distribuidora					= dw_1.Object.Cd_Distribuidora				[1]
lvl_Produto							= dw_1.Object.Cd_Produto              			[1]
lvs_Produto_Distribuidora		= dw_1.Object.Cd_Produto_Distribuidora	[1]

If Not IsNull(lvs_Distribuidora) and lvs_Distribuidora <> "000000000" Then
	This.of_AppendWhere_SubQuery("pe.cd_distribuidora = '" + lvs_Distribuidora + "'", 1)
End If

If Not IsNull(lvl_Produto) and lvl_Produto <> 0 Then
	This.of_AppendWhere_SubQuery("pe.cd_produto = " + String(lvl_Produto), 1)
End If

If Not IsNull(lvs_Produto_Distribuidora) and Trim(lvs_Produto_Distribuidora) <> "" Then
	This.of_AppendWhere_SubQuery("pe.cd_produto_distribuidora = '" + lvs_Produto_Distribuidora + "'", 1)
End If

Return 1
end event

event dw_2::ue_preupdate;call super::ue_preupdate;Long	lvl_Produto
Long	ll_Linhas
Long	ll_Linha

String	lvs_Distribuidora
String	lvs_Produto_Distribuidora
Boolean lb_existe
String	ls_msg

dwItemStatus lds_Status

dw_2.AcceptText()

ll_Linhas = dw_2.RowCount()

For ll_Linha = 1 to ll_Linhas

	lds_Status = dw_2.GetItemStatus(ll_Linha, 0, Primary!)

	If lds_Status = DataModified! OR lds_Status = NewModified! THEN
		
		lvs_Distribuidora					= dw_2.Object.Cd_Distribuidora				[ll_Linha]
		lvl_Produto							= dw_2.Object.Cd_Produto              			[ll_Linha]
		lvs_Produto_Distribuidora		= dw_2.Object.Cd_Produto_Distribuidora	[ll_Linha]
			
		If IsNull(lvs_Distribuidora) or lvs_Distribuidora = "000000000" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a distribuidora.")
			Return -1
		End If
		
		If IsNull(lvl_Produto) or lvl_Produto = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o produto.")
			Return -1
		End If
		
		If IsNull(lvs_Produto_Distribuidora) or Trim(lvs_Produto_Distribuidora) = "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o c$$HEX1$$f300$$ENDHEX$$digo do produto na distribuidora.")
			Return -1
		End If
	
		//Chama a fun$$HEX2$$e700e300$$ENDHEX$$o que verifica se j$$HEX1$$e100$$ENDHEX$$ existe
		If not wf_verifica_registro_existente(lvs_Produto_Distribuidora,lvs_Distribuidora,lb_existe,ls_msg) Then
			MessageBox("Erro", "Ocorreu um erro ao salvar o produto, fecha a tela e tente novamente")
		End if
		
		If lb_existe = True and lds_Status = NewModified! Then
			MessageBox("Erro", "Produto '"+ string(lvl_Produto) +"' j$$HEX1$$e100$$ENDHEX$$ cadastrado, n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ possivel salvar novamente.")
			Return -1
		End if
	End if

Next

Return 1
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;integer li_row
dwItemStatus lds_Status

li_row = dw_2.GetRow()
lds_Status = dw_2.GetItemStatus(li_row, 0, Primary!)

If lds_Status = New! or lds_Status = NewModified! Then
	dw_2.Modify("DataWindow.ReadOnly=No")
Else
	dw_2.Modify("DataWindow.ReadOnly=Yes")
End if


end event

