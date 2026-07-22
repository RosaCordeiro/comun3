HA$PBExportHeader$w_ge197_relatorio_estoque_filial.srw
forward
global type w_ge197_relatorio_estoque_filial from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge197_relatorio_estoque_filial from dc_w_selecao_lista_relatorio
integer width = 4942
integer height = 2156
string title = "GE197 - Relat$$HEX1$$f300$$ENDHEX$$rio de Estoque por Filial"
event ue_consulta_historico ( )
event ue_consulta_saldo_pendente ( )
end type
global w_ge197_relatorio_estoque_filial w_ge197_relatorio_estoque_filial

type variables
uo_filial							io_filial				//GE009
uo_classificacao_produto		io_classificacao 	//GE022
uo_categoria					io_categoria	 		//GE022
uo_subcategoria			 	io_subcategoria	//GE022
uo_produto						io_Produto			//GE001
end variables

forward prototypes
public subroutine wf_insere_padrao ()
public subroutine wf_altera_filtro (string ps_campo, string ps_valor)
public function boolean wf_qt_venda ()
public function boolean wf_qt_saldo_pendente ()
public function boolean wf_qt_estoque_minimo ()
end prototypes

event ue_consulta_historico();Long ll_Filial
Long ll_Produto

String ls_Parametro

w_ge168_historico_alteracao lvw

dw_1.AcceptText()
dw_2.AcceptText()

If dw_2.RowCount() > 0 Then 
	
	ll_Filial		= dw_1.Object.cd_filial		[1]
	ll_Produto 	= dw_2.Object.cd_produto	[dw_2.GetRow()]
	
	ls_Parametro = String( ll_Filial, '0000') + String( ll_Produto )
	
	OpenWithParm(w_ge168_historico_alteracao, ls_Parametro)
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum produto foi localizado para listar o hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700f500$$ENDHEX$$es.")
	Return
End If
end event

event ue_consulta_saldo_pendente();Long ll_Filial
Long ll_Produto

dw_1.AcceptText()
dw_2.AcceptText()

If dw_2.RowCount() > 0 Then
	
	ll_Filial		= dw_1.Object.cd_filial		[1]
	ll_Produto 	= dw_2.Object.cd_produto	[dw_2.GetRow()]
	
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("dw_ge197_lista_pendencia_saldo") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store.", StopSign!)
		Destroy(lds)
		Return
	End If
	
	lds.Retrieve(ll_Filial, ll_Produto)
	
	If lds.RowCount() < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve do data store 'dw_ge197_lista_pendencia_saldo'.", StopSign!)
		Destroy(lds)
		Return
	ElseIf lds.RowCount() > 0 Then
		OpenWithParm(w_ge197_saldo_pendente, lds)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto n$$HEX1$$e300$$ENDHEX$$o tem saldo pendente.")
	End If
		
	If IsValid(lds) Then Destroy(lds)
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum produto foi localizado para listar o saldo pendente.")
	Return
End If
end event

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/* Grupo Produto */
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_grupo" )			
ldwc_Child.SetItem(1, "cd_grupo", "0")
ldwc_Child.SetItem(1, "de_grupo", "TODOS")
dw_1.Object.cd_grupo [1] = "0"

/* Subgrupo Produto */
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_subgrupo" )			
ldwc_Child.SetItem(1, "cd_grupo", "0")	
ldwc_Child.SetItem(1, "cd_subgrupo", "0")
ldwc_Child.SetItem(1, "de_subgrupo", "TODOS")
dw_1.Object.cd_subgrupo [1] = "0"
end subroutine

public subroutine wf_altera_filtro (string ps_campo, string ps_valor);DatawindowChild ldwc_Child

If (ps_campo = 'cd_grupo') or (ps_campo = 'cd_subgrupo') or (ps_campo = 'de_categoria')  Then 
	io_subcategoria.Of_inicializa( )
	
	dw_1.Object.cd_subcategoria	[1] = io_subcategoria.cd_subcategoria
	dw_1.Object.de_subcategoria	[1] = io_subcategoria.de_subcategoria
	
	If (ps_campo = 'cd_grupo') or (ps_campo = 'cd_subgrupo')  Then 
		io_categoria.Of_inicializa( )
		
		dw_1.Object.cd_categoria	[1] = io_categoria.cd_categoria
		dw_1.Object.de_categoria	[1] = io_categoria.de_categoria
		
		
		If ps_campo = 'cd_grupo' Then 	
			If dw_1.GetChild("cd_subgrupo", ldwc_Child) = 1 Then
				ldwc_Child.SetFilter("( cd_grupo = '0' or  cd_grupo = '"+ps_valor+"')")
				ldwc_Child.Filter()
			End If
			
			dw_1.Object.cd_subgrupo [1] = '0'
		End If
	End If
End If

Choose Case ps_campo
	Case 'cd_grupo' 
		If ps_valor <> '' Then dw_1.Post Event ue_Pos(1,'cd_subgrupo')
	Case 'cd_subgrupo' 
		If ps_valor <> '' Then dw_1.Post Event ue_Pos(1,'de_categoria')
	Case 'de_categoria' 
		If ps_valor <> '' Then dw_1.Post Event ue_Pos(1,'de_subcategoria')
	Case 'de_subcategoria' 
		If ps_valor <> '' Then 
		End If
End Choose
end subroutine

public function boolean wf_qt_venda ();Try
	Date ldt_Data_Atual
	
	Long ll_Linha
	Long ll_Produto
	Long ll_Filial
	Long ll_Find
	
	dw_1.AcceptText()
	dw_2.AcceptText()
	
	w_Aguarde.Title = "Aguarde... Verificando Vendas."
	
	dc_uo_ds_base lds_Qt_Venda
	lds_Qt_Venda = Create dc_uo_ds_base
	
	If Not lds_Qt_Venda.of_ChangeDataObject("ds_ge197_lista_qt_venda") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'ds_ge197_lista_qt_venda'.", StopSign!)
		Return False
	End If
	
	ll_Filial = dw_1.Object.Cd_Filial[1]
	
	ldt_Data_Atual = RelativeDate(Date(gf_GetServerDate()), -30)
	
	lds_Qt_Venda.Retrieve(ldt_Data_Atual, ll_Filial)
	
	For ll_Linha = 1 To lds_Qt_Venda.RowCount()
		ll_Produto = lds_Qt_Venda.Object.Cd_Produto[ll_Linha]
		
		ll_Find = dw_2.Find("cd_produto = " + String(ll_Produto), 1, dw_2.RowCount())
		
		If ll_Find > 0 Then
			dw_2.Object.Qt_Venda	[ll_Find]	= lds_Qt_Venda.Object.Qt_Venda[ll_Linha]
			dw_2.Object.Vl_Venda	[ll_Find]	= dw_2.Object.Qt_Venda[ll_Find] * dw_2.Object.Vl_Custo[ll_Find]
		ElseIf ll_Find < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da data store 'ds_ge197_lista_qt_venda'.", StopSign!)
			Return False
		End If
	Next
		
	Return True
	
Finally
	If IsValid(lds_Qt_Venda) Then Destroy(lds_Qt_Venda)
End Try
end function

public function boolean wf_qt_saldo_pendente ();Try
	Long ll_Linha
	Long ll_Produto
	Long ll_Filial
	Long ll_Find
	
	dw_1.AcceptText()
	dw_2.AcceptText()
	
	w_Aguarde.Title = "Aguarde... Verificando Saldo Pendente."
	
	dc_uo_ds_base lds_Qt_Saldo_Pend
	lds_Qt_Saldo_Pend = Create dc_uo_ds_base
	
	If Not lds_Qt_Saldo_Pend.of_ChangeDataObject("ds_ge197_lista_qt_saldo_pendente") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'ds_ge197_lista_qt_saldo_pendente'.", StopSign!)
		Return False
	End If
	
	ll_Filial = dw_1.Object.Cd_Filial[1]
	
	lds_Qt_Saldo_Pend.Retrieve(ll_Filial)
	
	For ll_Linha = 1 To lds_Qt_Saldo_Pend.RowCount()
		ll_Produto = lds_Qt_Saldo_Pend.Object.Cd_Produto[ll_Linha]
		
		ll_Find = dw_2.Find("cd_produto = " + String(ll_Produto), 1, dw_2.RowCount())
				
		If ll_Find > 0 Then
			dw_2.Object.Qt_Saldo_Pend		[ll_Find] = lds_Qt_Saldo_Pend.Object.Qt_Saldo_Pend[ll_Linha]
			dw_2.Object.Vl_Estoque_Transito	[ll_Find] = dw_2.Object.Qt_Saldo_Pend[ll_Find] * dw_2.Object.Vl_Custo[ll_Find]
		ElseIf ll_Find < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find do data store 'ds_ge197_lista_qt_saldo_pendente'.", StopSign!)
			Return False
		End If
			
	Next
	
	Return True
	
Finally
	If IsValid(lds_Qt_Saldo_Pend) Then Destroy(lds_Qt_Saldo_Pend)
End Try
end function

public function boolean wf_qt_estoque_minimo ();Try
	Long ll_Linha
	Long ll_Produto
	Long ll_Produto_Ant = 0
	Long ll_Filial
	Long ll_Find
		
	dw_1.AcceptText()
	dw_2.AcceptText()
	
	w_Aguarde.Title = "Aguarde... Verificando Estoque M$$HEX1$$ed00$$ENDHEX$$nimo."
	
	dc_uo_ds_base lds_Qt_Estoque_Min
	lds_Qt_Estoque_Min = Create dc_uo_ds_base
			
	If Not lds_Qt_Estoque_Min.of_ChangeDataObject("ds_ge197_lista_qt_estoque_minimo") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'ds_ge197_lista_qt_estoque_minimo'.", StopSign!)
		Return False
	End If
	
	ll_Filial = dw_1.Object.Cd_Filial[1]
	
	lds_Qt_Estoque_Min.Retrieve(ll_Filial)
	
	For ll_Linha = 1 To lds_Qt_Estoque_Min.RowCount()
		ll_Produto = lds_Qt_Estoque_Min.Object.Cd_Produto[ll_Linha]
			
		ll_Find = dw_2.Find("cd_produto = " + String(ll_Produto), 1, dw_2.RowCount())
				
		If ll_Find > 0 Then
			If ll_Produto = ll_Produto_Ant Then
				Continue
			End If
			
			dw_2.Object.Qt_Estoque_Minimo	[ll_Find] = lds_Qt_Estoque_Min.Object.Qt_Estoque_Minimo	[ll_Linha]
			
			If lds_Qt_Estoque_Min.Object.Qt_Estoque_Minimo	[ll_Linha] > 0 Then
				dw_2.Object.Cd_Promocao_Sos[ll_Find] = lds_Qt_Estoque_Min.Object.Cd_Promocao_Sos[ll_Linha]
			End If
			
			ll_Produto_Ant = ll_Produto
		ElseIf ll_Find < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find do data store 'ds_ge197_lista_qt_estoque_minimo'.", StopSign!)
			Return False
		End If
	Next
	
	Return True
	
Finally
	If IsValid(lds_Qt_Estoque_Min) Then Destroy(lds_Qt_Estoque_Min)
End Try
end function

on w_ge197_relatorio_estoque_filial.create
call super::create
end on

on w_ge197_relatorio_estoque_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;MaxWidth	= 7098
MaxHeight	= 9999
end event

event ue_postopen;call super::ue_postopen;wf_Insere_Padrao()

dw_1.SetFocus()
end event

event close;call super::close;Destroy(io_categoria)
Destroy(io_subcategoria)
Destroy(io_classificacao)
Destroy(io_Filial)
Destroy(io_Produto)
end event

event open;call super::open;io_classificacao		= Create uo_classificacao_produto
io_subcategoria	= Create uo_subcategoria
io_categoria			= Create uo_categoria
io_Filial				= Create uo_Filial
io_Produto			= Create uo_Produto
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge197_relatorio_estoque_filial
integer x = 37
integer y = 888
integer height = 160
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge197_relatorio_estoque_filial
integer x = 0
integer y = 816
integer height = 248
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge197_relatorio_estoque_filial
integer y = 448
integer width = 4823
integer height = 1492
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge197_relatorio_estoque_filial
integer width = 4818
integer height = 424
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge197_relatorio_estoque_filial
integer width = 4750
integer height = 324
string dataobject = "dw_ge197_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;DataWindowChild ldwc_Child

Choose Case Dwo.Name

	Case 'cd_grupo'
		wf_altera_filtro(Dwo.Name,Data)
		
	Case 'cd_subgrupo'
		wf_altera_filtro(Dwo.Name,Data)
		
	Case 'de_categoria'
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_categoria.de_categoria Then
				Return 1
			End If	
		Else			
			io_categoria.of_Inicializa()
			
			This.Object.cd_categoria	[1] = io_categoria.de_categoria
			This.Object.de_categoria	[1] = io_categoria.cd_categoria
		End If	
		
		wf_altera_filtro(Dwo.Name,Data)
		
	Case 'de_subcategoria'
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_subcategoria.de_subcategoria Then
				Return 1
			End If	
		Else			
			io_subcategoria.Of_Inicializa()
			
			This.Object.cd_subcategoria	[1] = io_subcategoria.de_subcategoria
			This.Object.de_subcategoria	[1] = io_subcategoria.cd_subcategoria
		End If	
		
		wf_altera_filtro(Dwo.Name,Data)
End Choose

dw_2.Event ue_Reset()
end event

event dw_1::ue_key;call super::ue_key;String ls_Grupo
String ls_Subgrupo
String ls_Categoria

If Key = KeyEnter! Then
	This.AcceptText( )
	Choose Case This.GetColumnName()		
		Case 'nm_fantasia'
			io_Filial.of_Localiza_Filial(This.GetText())
			
			If io_Filial.Localizada Then
				This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
				This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
			Else
				io_Filial.of_Inicializa()
				
				This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
				This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
			End If
			
		Case 'de_produto'
			io_Produto.of_Localiza_Produto(This.GetText())
			
			If io_Produto.Localizado Then
				This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
				This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
			Else
				io_Produto.of_Inicializa()
				
				This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
				This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
			End If
			
		Case 'de_categoria'
			ls_Grupo		= This.Object.cd_grupo 		[1]
			ls_Subgrupo	= This.Object.cd_subgrupo	[1]
			
			io_categoria.of_localiza(This.GetText(), ls_Grupo, ls_Subgrupo)
			
			This.Object.cd_categoria	[1] = io_categoria.cd_categoria
			This.Object.de_categoria	[1] = io_categoria.de_categoria
			
			wf_altera_filtro('de_categoria', io_categoria.cd_categoria)
			
		Case 'de_subcategoria'
			ls_Grupo		= This.Object.cd_grupo 		[1]
			ls_Subgrupo	= This.Object.cd_subgrupo	[1]
			ls_Categoria	= This.Object.cd_categoria	[1]
			
			io_subcategoria.of_localiza(This.GetText(), ls_Grupo, ls_Subgrupo, ls_Categoria)
			
			This.Object.cd_subcategoria	[1] = io_subcategoria.cd_subcategoria
			This.Object.de_subcategoria	[1] = io_subcategoria.de_subcategoria
			
			wf_altera_filtro('de_subcategoria', io_subcategoria.cd_subcategoria)
			
	End Choose
End If

If Key = KeyF2! Then
	Event ue_Consulta_Saldo_Pendente()
End If

If Key = KeyF3! Then
	Event ue_Consulta_Historico()
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(io_categoria) Then
	This.Object.de_categoria [1] = io_categoria.de_categoria
End If

If IsValid(io_subcategoria) Then
	This.Object.de_subcategoria [1] = io_subcategoria.de_subcategoria
End If
end event

event dw_1::editchanged;call super::editchanged;Choose Case dwo.Name
	Case "nm_fantasia"
			
		If Trim(Data) <> "" Then
			If Data <> io_Filial.Nm_Fantasia Then
				Return 1
			End If	
		Else			
			io_Filial.of_Inicializa()			
			
			This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
			This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
		End If
		
	Case "de_produto"
			
		If Trim(Data) <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If	
		Else			
			io_Produto.of_Inicializa()			
			
			This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
			This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
End Choose

dw_2.Event ue_Reset()
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge197_relatorio_estoque_filial
integer y = 556
integer width = 4745
integer height = 1360
string dataobject = "dw_ge197_lista"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_2::ue_recuperar;//OverRide

Date ldt_Saldo

Long ll_Filial
Long ll_Produto

String ls_Situacao
String ls_Grupo
String ls_Subgrupo
String ls_Categoria
String ls_Subcategoria

dw_1.AcceptText()

ll_Filial				= dw_1.Object.Cd_Filial				[1]
ll_Produto			= dw_1.Object.Cd_Produto			[1]
ls_Situacao			= dw_1.Object.Id_Situacao			[1]
ls_Grupo 			= dw_1.Object.Cd_Grupo			[1]
ls_Subgrupo			= dw_1.Object.Cd_Subgrupo		[1]
ls_Categoria			= dw_1.Object.Cd_Categoria		[1]
ls_Subcategoria	= dw_1.Object.Cd_Subcategoria	[1]

ldt_Saldo = Date(String(gf_GetServerDate(), "01/mm/yyyy"))

If IsNull(ll_Filial) Or ll_Filial = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial.", Exclamation!)
	dw_1.Event ue_Pos(1, "nm_fantasia")
	Return -1
End If

If Not IsNull(ll_Produto) And ll_Produto > 0 Then
	This.of_AppendWhere_SubQuery("g.cd_produto = " + String(ll_Produto), 6)
End If

If ls_Situacao <> 'T' Then
	This.of_AppendWhere_SubQuery("g.id_situacao = '" + ls_Situacao + "'", 6)
End If

If ls_Grupo <> '0' Then
	This.of_AppendWhere_SubQuery("substring(g.cd_subcategoria,1,1) = '" + ls_Grupo + "'", 6)
End If

If ls_Subgrupo <> '0' Then
	This.of_AppendWhere_SubQuery("substring(g.cd_subcategoria,1,3) = '" + ls_Subgrupo + "'", 6)
End If

If ls_Categoria <> '0' Then
	This.of_AppendWhere_SubQuery("substring(g.cd_subcategoria,1,6) = '" + ls_Categoria + "'", 6)
End If

If ls_Subcategoria <> '0' Then
	This.of_AppendWhere_SubQuery("g.cd_subcategoria = '" + ls_Subcategoria + "'", 6)
End If

//A w_Aguarde $$HEX1$$e900$$ENDHEX$$ fechada no evento ue_Postretrieve

Open(w_Aguarde)
w_Aguarde.Title = "Aguarde... Recuperando Informa$$HEX2$$e700f500$$ENDHEX$$es."

Return This.Retrieve(ll_Filial, ldt_Saldo)
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	SetRedraw(False)
	
	dw_2.ivo_Controle_Menu.of_SalvarComo(True)
	
	If Not wf_Qt_Venda() Then
		Close(w_Aguarde)
		Return -1
	End If
	
	If Not wf_Qt_Estoque_Minimo() Then
		Close(w_Aguarde)
		Return -1
	End If
	
	If Not wf_Qt_Saldo_Pendente() Then
		Close(w_Aguarde)
		Return -1
	End If
	
	SetRedraw(True)
End If

//A abertura da w_Aguarde $$HEX1$$e900$$ENDHEX$$ no evento ue_Recuperar
Close(w_Aguarde)

Return pl_Linhas
end event

event dw_2::ue_key;call super::ue_key;If Key = KeyF2! Then
	Event ue_Consulta_Saldo_Pendente()
End If

If Key = KeyF3! Then
	Event ue_Consulta_Historico()
End If
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge197_relatorio_estoque_filial
integer x = 485
integer y = 532
integer width = 379
integer height = 272
end type

