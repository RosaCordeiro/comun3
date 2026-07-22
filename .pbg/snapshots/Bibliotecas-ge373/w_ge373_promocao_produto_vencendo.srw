HA$PBExportHeader$w_ge373_promocao_produto_vencendo.srw
forward
global type w_ge373_promocao_produto_vencendo from dc_w_cadastro_lista
end type
type cb_filial from commandbutton within w_ge373_promocao_produto_vencendo
end type
end forward

global type w_ge373_promocao_produto_vencendo from dc_w_cadastro_lista
integer width = 7314
integer height = 1480
string title = "GE373 - Promo$$HEX2$$e700e300$$ENDHEX$$o de Produtos a Vencer"
long backcolor = 80269524
cb_filial cb_filial
end type
global w_ge373_promocao_produto_vencendo w_ge373_promocao_produto_vencendo

type variables
boolean ivb_inclusao = false

uo_subgrupo			io_subgrupo			//GE613
uo_categoria		io_categoria		//GE022
uo_subcategoria	io_subcategoria	//GE022
uo_produto			io_produto			//GE001
end variables

forward prototypes
public function boolean wf_exclui_filiais_promocao (long al_promocao)
end prototypes

public function boolean wf_exclui_filiais_promocao (long al_promocao);Delete from promocao_vencimento_filial
Where cd_promocao =:al_Promocao
Using sqlca;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir as filias da promo$$HEX2$$e700e300$$ENDHEX$$o.")
	Return False
End If

Return True
end function

on w_ge373_promocao_produto_vencendo.create
int iCurrent
call super::create
this.cb_filial=create cb_filial
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_filial
end on

on w_ge373_promocao_produto_vencendo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_filial)
end on

event ue_save;call super::ue_save;Long lvl_Promocao

If AncestorReturnValue = 1 Then
	
	dw_1.Retrieve()
	
	// Se for uma inclus$$HEX1$$e300$$ENDHEX$$o
	If ivb_inclusao Then
		
		dw_1.SetRow(dw_1.RowCount())
		
		Select max(cd_promocao) 
		Into :lvl_Promocao
		From promocao_vencimento
		Using sqlca;
		
		If Sqlca.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da promo$$HEX2$$e700e300$$ENDHEX$$o cadastrada.")
			Return -1
		End If
		
		OpenwithParm(w_ge373_promocao_filial, lvl_Promocao)
	End If
End If

Return AncestorReturnValue
end event

event close;call super::close;Destroy io_subgrupo
Destroy io_categoria
Destroy io_subcategoria
Destroy io_produto
end event

event ue_preopen;call super::ue_preopen;io_subgrupo     = Create uo_subgrupo
io_categoria    = Create uo_categoria
io_produto      = Create uo_produto
io_subcategoria = Create uo_subcategoria
end event

event resize;call super::resize;cb_filial.Y = NewHeight - cb_filial.Height - 16
gb_1.Height = NewHeight - gb_1.Y - 24 - cb_filial.Height
dw_1.Height = gb_1.Height - 112
end event

type dw_visual from dc_w_cadastro_lista`dw_visual within w_ge373_promocao_produto_vencendo
integer y = 1008
end type

type gb_aux_visual from dc_w_cadastro_lista`gb_aux_visual within w_ge373_promocao_produto_vencendo
integer y = 864
end type

type dw_1 from dc_w_cadastro_lista`dw_1 within w_ge373_promocao_produto_vencendo
integer x = 59
integer y = 60
integer width = 7177
integer height = 1092
string dataobject = "dw_ge373_lista"
string ivs_cor_linha_padrao = ""
end type

event dw_1::ue_preinsertrow;call super::ue_preinsertrow;If This.RowCount() > 0 Then
	If IsNull(This.Object.cd_promocao[This.RowCount()]) Then
		Return -1
	End If
End If

Return 1
end event

event dw_1::ue_preupdate;call super::ue_preupdate;Date	lvdt_Inicio,&
		lvdt_Termino

Long	lvl_Linhas,&
		lvl_Linha,&
		lvl_Retorno = 1,&
		lvl_Promocao, &
		lvl_Produto

String	lvs_Promocao, &
			lvs_Grupo, &
			lvs_SubGrupo, &
			lvs_Categoria, &
			lvs_SubCategoria
 
Decimal	lvdc_Desconto

lvl_Linhas = This.RowCount()

For lvl_Linha = 1 To lvl_Linhas
	
	lvl_Promocao  = dw_1.Object.cd_promocao[lvl_Linha]
	lvs_Promocao  = dw_1.Object.nm_promocao[lvl_Linha]
	lvdc_Desconto = dw_1.Object.pc_desconto[lvl_Linha]
	lvdt_Inicio	  = Date(dw_1.Object.dh_inicio  [lvl_Linha])
	lvdt_Termino  = Date(dw_1.Object.dh_termino [lvl_Linha])
	lvs_Grupo     = dw_1.Object.cd_grupo        [lvl_Linha]
	lvl_Produto   = dw_1.Object.cd_produto      [lvl_Linha]
			
	If IsNull(lvl_Promocao) Then
		ivb_inclusao = True
	Else
		ivb_inclusao = False
	End If
		
	If Trim(lvs_Promocao) = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o nome da promo$$HEX2$$e700e300$$ENDHEX$$o.")
		dw_1.Event ue_Pos(lvl_Linha, "nm_promocao")
		lvl_Retorno = -1 
		Exit 
	End If
	
	If IsNull(lvdc_Desconto) or lvdc_Desconto < 1 or lvdc_Desconto > 99.00  Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o desconto corretamente.")
		dw_1.Event ue_Pos(lvl_Linha, "pc_desconto")
		lvl_Retorno = -1 
		Exit 
	End If
	
	If IsNull(lvdt_Inicio) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio do desconto corretamente.")
		dw_1.Event ue_Pos(lvl_Linha, "dh_inicio")
		lvl_Retorno = -1 
		Exit 
	End If
	
	If Not IsNull(lvdt_Termino) Then
		If lvdt_Inicio > lvdt_Termino Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior que a de t$$HEX1$$e900$$ENDHEX$$rmino.")
			dw_1.Event ue_Pos(lvl_Linha, "dh_inicio")
			lvl_Retorno = -1 
			Exit 
		End If
	End If
	
	If (IsNull (lvs_Grupo) and IsNull (lvl_Produto)) or &
		(Not IsNull (lvs_Grupo) and Not IsNull (lvl_Produto)) then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe o GRUPO DE PRODUTOS ou APENAS O PRODUTO.')
		dw_1.Event ue_Pos (lvl_Linha, 'cd_grupo')
		lvl_Retorno = -1
		Exit
	End if
	
Next

Return lvl_Retorno
end event

event dw_1::ue_predeleterow;call super::ue_predeleterow;Long lvl_Promocao

dw_1.AcceptText()

If AncestorReturnValue Then
	lvl_Promocao = dw_1.Object.cd_promocao[This.GetRow()]
	
	If Not wf_Exclui_Filiais_Promocao(lvl_Promocao) Then
		Return False
	End If
End If

Return AncestorReturnValue


end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;If Row > 0 Then
	If Not IsNull(dw_1.Object.cd_promocao[Row]) Then
		cb_filial.Enabled = True
	Else
		cb_filial.Enabled = False
	End If
End If


end event

event dw_1::itemchanged;call super::itemchanged;DataWindowChild	ldw_Child
String				ls_nulo

SetNull (ls_nulo)

Choose Case Dwo.Name
	Case 'cd_grupo'
		io_subgrupo.of_inicializa ()
		This.Object.cd_subgrupo [Row] = io_subgrupo.cd_subgrupo
		This.Object.de_subgrupo [Row] = io_subgrupo.de_subgrupo
		
		io_categoria.of_inicializa ()
		This.Object.cd_categoria [Row] = io_categoria.cd_categoria
		This.Object.de_categoria [Row] = io_categoria.de_categoria
		
		io_subcategoria.of_inicializa ()
		This.Object.cd_subcategoria [Row] = io_subcategoria.cd_subcategoria
		This.Object.de_subcategoria [Row] = io_subcategoria.de_subcategoria
	
	Case 'de_subgrupo'
		io_categoria.of_inicializa ()
		This.Object.cd_categoria [Row] = io_categoria.cd_categoria
		This.Object.de_categoria [Row] = io_categoria.de_categoria
		
		io_subcategoria.of_inicializa ()
		This.Object.cd_subcategoria [Row] = io_subcategoria.cd_subcategoria
		This.Object.de_subcategoria [Row] = io_subcategoria.de_subcategoria
		
		If IsNull (Data) then
			This.Object.cd_subgrupo [Row] = ls_nulo
		else
			If Data <> io_subgrupo.de_subgrupo then
				If Data <> '' then
					Return 1
				End if
			End if
		End if
		
		
	Case 'de_categoria'
		io_subcategoria.of_inicializa ()
		This.Object.cd_subcategoria [Row] = io_subcategoria.cd_subcategoria
		This.Object.de_subcategoria [Row] = io_subcategoria.de_subcategoria
		
		If IsNull (Data) then
			This.Object.cd_categoria [Row] = ls_nulo
		else
			If Data <> io_categoria.de_categoria then
				If Data <> '' then
					Return 1
				else
					io_categoria.of_inicializa ()
					This.Object.cd_categoria [Row] = io_categoria.cd_categoria
					This.Object.de_categoria [Row] = io_categoria.de_categoria
				End if
			End if
		End if
	
		
	Case 'de_subcategoria'
		If IsNull (Data) then
			This.Object.cd_subcategoria [Row] = ls_nulo
		else
			If Data <> io_subcategoria.de_subcategoria then
				If Data <> '' then
					Return 1
				else
					io_subcategoria.of_inicializa ()
					This.Object.cd_subcategoria [Row] = io_subcategoria.cd_subcategoria
					This.Object.de_subcategoria [Row] = io_subcategoria.de_subcategoria
				End if
			End if
		End if
	
	Case 'de_produto'
		If Not IsNull (Data) and Trim (Data) <> '' then
			If Not IsNull (This.Object.Cd_Produto [Row]) Then
				If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque then
					Return 1
				End if
			End if
		else
			io_Produto.of_Inicializa ()	
			This.Object.Cd_Produto [Row] = io_Produto.Cd_Produto
			This.Object.De_Produto [Row] = io_Produto.ivs_Descricao_Apresentacao_Estoque			
		End if

End choose
end event

event dw_1::ue_key;call super::ue_key;Long		ll_linha
String	ls_Grupo
String	ls_Subgrupo
String	ls_Categoria

If Key = KeyEnter! then
	ll_linha = This.GetRow ()
	
	Choose case This.GetColumnName ()
		Case 'de_subgrupo'
			ls_Grupo = This.Object.cd_grupo [ll_linha]
			io_subgrupo.of_inicializa ()
			io_subgrupo.of_localiza (ls_Grupo, This.GetText ())
			
			This.Object.cd_subgrupo [ll_linha] = io_subgrupo.cd_subgrupo
			This.Object.de_subgrupo [ll_linha] = io_subgrupo.de_subgrupo
			
			io_categoria.of_inicializa ()
			This.Object.cd_categoria [ll_linha] = io_categoria.cd_categoria
			This.Object.de_categoria [ll_linha] = io_categoria.de_categoria
			
			io_subcategoria.of_inicializa ()
			This.Object.cd_subcategoria [ll_linha] = io_subcategoria.cd_subcategoria
			This.Object.de_subcategoria [ll_linha] = io_subcategoria.de_subcategoria
		
		Case 'de_categoria'
			ls_Grupo 	= This.Object.cd_grupo    [ll_linha]
			ls_Subgrupo	= This.Object.cd_subgrupo [ll_linha]
			io_categoria.of_inicializa ()
			io_categoria.of_localiza (This.GetText (), ls_Grupo, ls_Subgrupo)
			
			This.Object.cd_categoria [ll_linha] = io_categoria.cd_categoria
			This.Object.de_categoria [ll_linha] = io_categoria.de_categoria
		
			io_subcategoria.of_inicializa ()
			This.Object.cd_subcategoria [ll_linha] = io_subcategoria.cd_subcategoria
			This.Object.de_subcategoria [ll_linha] = io_subcategoria.de_subcategoria
		
		Case 'de_subcategoria'
			ls_Grupo     = This.Object.cd_grupo     [ll_linha]
			ls_Subgrupo  = This.Object.cd_subgrupo  [ll_linha]
			ls_Categoria = This.Object.cd_categoria [ll_linha]
			io_subcategoria.of_inicializa ()
			io_subcategoria.of_localiza (This.GetText (), ls_Grupo, ls_Subgrupo, ls_Categoria)
			
			This.Object.cd_subcategoria [ll_linha] = io_subcategoria.cd_subcategoria
			This.Object.de_subcategoria [ll_linha] = io_subcategoria.de_subcategoria
		
		
		Case 'de_produto'			
			io_Produto.of_Localiza_Produto (This.GetText ())
			If io_Produto.Localizado then
				This.Object.Cd_Produto [ll_linha] = io_Produto.Cd_Produto
				This.Object.De_Produto [ll_linha] = io_Produto.ivs_Descricao_Apresentacao_Estoque
			End If
			
	End choose
	
	This.Post SetRow (ll_linha)
End If
end event

type gb_1 from dc_w_cadastro_lista`gb_1 within w_ge373_promocao_produto_vencendo
integer x = 27
integer y = 8
integer width = 7232
integer height = 1176
string text = "Promo$$HEX2$$e700f500$$ENDHEX$$es"
end type

type cb_filial from commandbutton within w_ge373_promocao_produto_vencendo
integer x = 6903
integer y = 1188
integer width = 357
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Filiais"
end type

event clicked;Long lvl_Promocao

dw_1.AcceptText()

lvl_Promocao = dw_1.Object.cd_promocao[dw_1.GetRow()]

If Not IsNull(lvl_Promocao) Then
	OpenwithParm(w_ge373_promocao_filial, lvl_Promocao)
End If


end event

