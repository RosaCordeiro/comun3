HA$PBExportHeader$w_ge356_relatorio_falta_pedido.srw
forward
global type w_ge356_relatorio_falta_pedido from dc_w_2tab_consulta_selecao_lista_det
end type
type cb_1 from commandbutton within tabpage_1
end type
type dw_5 from dc_uo_dw_base within tabpage_1
end type
type tabpage_3 from userobject within tab_1
end type
type gb_4 from groupbox within tabpage_3
end type
type dw_4 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_4 gb_4
dw_4 dw_4
end type
end forward

global type w_ge356_relatorio_falta_pedido from dc_w_2tab_consulta_selecao_lista_det
integer width = 4855
integer height = 2484
string title = "GE356 - Relat$$HEX1$$f300$$ENDHEX$$rio de Falta nos Pedidos das Filiais"
event ue_consulta_distribuidoras ( )
event ue_consulta_filial ( )
end type
global w_ge356_relatorio_falta_pedido w_ge356_relatorio_falta_pedido

type variables
dc_uo_dw_base dw_1, dw_2, dw_3, dw_4, dw_5

uo_produto					io_Produto		//ge001
uo_fornecedor				io_Fornecedor	//ge003
uo_ge149_comprador		io_Comprador

String is_Filiais
end variables

forward prototypes
public subroutine wf_insere_grupo_default ()
public function boolean wf_saldo_em_transito ()
public function boolean wf_quantidade_pedida_cd ()
end prototypes

event ue_consulta_distribuidoras();Long ll_Produto
Long ll_Filial

String ls_Uf
String ls_Parametro

w_ge162_Consulta_Produto_Distribuidora lvw

ll_Produto = dw_3.Object.Cd_Produto[dw_3.GetRow()]

If Not IsNull(ll_Produto) And ll_Produto > 0 Then
	If dw_3.GetRow() > 0 Then
		ll_Filial	= dw_3.Object.Cd_Filial	[dw_3.GetRow()]
		ls_Uf		= dw_3.Object.Cd_Uf		[dw_3.GetRow()]
		
		ls_Parametro = ls_Uf + String(ll_Produto, "000000")
		OpenSheetWithParm(lvw, ls_Parametro, This, 0, Original! )
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.", Exclamation!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.", Exclamation!)
End If
end event

event ue_consulta_filial();Long ll_Filial

dw_3.AcceptText()

If dw_3.GetRow() > 0 Then
	ll_Filial = dw_3.Object.Cd_Filial[dw_3.GetRow()]
	
	If Not IsNull(ll_Filial) And ll_Filial > 0 Then
		OpenWithParm(w_ge161_consulta_filial_distribuidora_response, String(ll_Filial, "0000"))
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.", Exclamation!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.", Exclamation!)
End If
end event

public subroutine wf_insere_grupo_default ();DataWindowChild lvdwc

If Tab_1.TabPage_1.dw_1.GetChild("cd_grupo", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_grupo", "0")
	lvdwc.SetItem(1, "de_grupo", "TODOS")
	
	Tab_1.TabPage_1.dw_1.Object.Cd_Grupo[1] = "0"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do grupo.")
End If
end subroutine

public function boolean wf_saldo_em_transito ();st_saldo_transito str

Long ll_Find
Long ll_Linha
Long ll_Linhas

gf_Saldo_em_transito(Ref str)

ll_Linhas = UpperBound(str.Cd_Produto[])

For ll_Linha = 1 To ll_Linhas
	
	//Quando o fornecedor n$$HEX1$$e300$$ENDHEX$$o informa o c$$HEX1$$f300$$ENDHEX$$digo de barras no XML, o item no agendamento fica sem o c$$HEX1$$f300$$ENDHEX$$digo de produtos
	If IsNull(str.Cd_Produto[ll_Linha]) Or str.Cd_Produto[ll_Linha] = 0 Then Continue
	
	ll_Find = dw_2.Find("cd_produto = " + String(str.Cd_Produto[ll_Linha]), 1, dw_2.RowCount())
	
	If ll_Find > 0 Then
		dw_2.Object.Qt_Est_Transito[ll_Find] = str.Qt_Saldo[ll_Linha] 
	End If
Next

Return True
end function

public function boolean wf_quantidade_pedida_cd ();Long ll_Linha
Long ll_Linhas
Long ll_Find

DateTime ldh_Emissao

ldh_Emissao = gvo_Parametro.of_Dh_Movimentacao()

ldh_Emissao = DateTime(RelativeDate(Date(ldh_Emissao), -90))

st_ge356_produto_ped_cd str_ped

DECLARE lcu CURSOR FOR

Select p.cd_produto, coalesce(sum(p.qt_pedida), 0) qt_pedida
	From pedido_central c
		Inner Join pedido_central_produto p
			On p.nr_pedido = c.nr_pedido
	Where c.cd_filial = 534
		And c.id_situacao = 'C'
		And c.dh_emissao >= :ldh_Emissao
		Group By p.cd_produto;

// Declara$$HEX2$$e700e300$$ENDHEX$$o vari$$HEX1$$e100$$ENDHEX$$veis de destino
Long ll_Produto, ll_Qt_Pedida

// Abrindo o cursor
OPEN lcu;

// Buscar a primeira linha do resultado
FETCH lcu INTO :ll_Produto, :ll_Qt_Pedida;

// Repetir Enquanto Houver Linhas
DO WHILE SQLCA.sqlcode = 0
	
	ll_Linha ++
	
	str_ped.Cd_Produto		[ll_Linha]	= ll_Produto
	str_ped.Qt_Pedida_Cd	[ll_Linha]	= ll_Qt_Pedida
	
	FETCH lcu INTO :ll_Produto, :ll_Qt_Pedida;
LOOP

// No fim fechar o cursor
CLOSE lcu;

ll_Linhas = UpperBound(str_ped.Cd_Produto[])

For ll_Linha = 1 To ll_Linhas

	//Quando o fornecedor n$$HEX1$$e300$$ENDHEX$$o informa o c$$HEX1$$f300$$ENDHEX$$digo de barras no XML, o item no agendamento fica sem o c$$HEX1$$f300$$ENDHEX$$digo de produtos
	If IsNull(str_ped.Cd_Produto[ll_Linha]) Or str_ped.Cd_Produto[ll_Linha] = 0 Then Continue
		
	ll_Find = dw_2.Find("cd_produto = " + String(str_ped.Cd_Produto[ll_Linha]), 1, dw_2.	RowCount())
		
	If ll_Find > 0 Then
		dw_2.Object.Qt_Pedida_Cd[ll_Find] = str_ped.Qt_Pedida_Cd[ll_Linha]
	End If
Next

Return True
end function

on w_ge356_relatorio_falta_pedido.create
int iCurrent
call super::create
end on

on w_ge356_relatorio_falta_pedido.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;dw_1 = Tab_1.TabPage_1.dw_1
dw_2 = Tab_1.TabPage_1.dw_2
dw_3 = Tab_1.TabPage_2.dw_3
dw_4 = Tab_1.TabPage_3.dw_4
dw_5 = Tab_1.TabPage_1.dw_5

io_Produto		= Create uo_produto
io_Fornecedor	= Create uo_fornecedor
io_Comprador	= Create uo_ge149_comprador
end event

event close;call super::close;Destroy(io_Produto)
Destroy(io_Fornecedor)
Destroy(io_Comprador)
end event

event ue_postopen;call super::ue_postopen;DateTime ldh_Atual

If Not gf_Data_Parametro(Ref ldh_Atual) Then Return

ldh_Atual = DateTime(RelativeDate(Date(ldh_Atual), -1))

dw_1.Object.Dh_Inicio		[1] = ldh_Atual
dw_1.Object.Dh_Termino	[1] = ldh_Atual

wf_Insere_Grupo_Default()

If Not gf_ge003_Lista_Divisao_Fornecedor(dw_1, "", 1) Then Return
end event

event ue_preopen;call super::ue_preopen;//ivl_Altura_1		= 2525
//ivl_Largura_1	= 4840

//ivl_Altura_2 		= 2520
//ivl_Largura_2 	= 4030
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge356_relatorio_falta_pedido
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge356_relatorio_falta_pedido
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge356_relatorio_falta_pedido
integer width = 4786
integer height = 2280
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_3=create tabpage_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_3
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_3)
end on

event tab_1::selectionchanging;//OverRide

SetPointer(HourGlass!)

If OldIndex = 1 Then
	If NewIndex = 2 Then
		If dw_2.GetRow() > 0 Then
			// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
			// das DW's de detalhes
			dw_3.Event ue_Retrieve()
	
			// Permite a troca do folder
			Return 0
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		End If
	End If
End If

If OldIndex = 2 Then
	If NewIndex = 3 Then
		If dw_3.GetRow() > 0 Then
			// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
			// das DW's de detalhes
			dw_4.Event ue_Retrieve()
	
			// Permite a troca do folder
			Return 0
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		End If
	End If
End If

SetPointer(Arrow!)
end event

event tab_1::selectionchanged;//OverRide

SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
//		This.Width  = Parent.ivl_Largura_1
//		This.Height = Parent.ivl_Altura_1
		
		dw_2.SetFocus()
	Case 2
//		This.Width  = Parent.ivl_Largura_2
//		This.Height = Parent.ivl_Altura_2
		
		dw_3.SetFocus()
		
	Case 3
		
		dw_4.SetFocus()
End Choose
	
//Parent.Width  = This.Width + This.X + 75	
//Parent.Height = This.Height + This.Y + 155

SetPointer(Arrow!)
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 4750
integer height = 2164
string text = "Produtos"
cb_1 cb_1
dw_5 dw_5
end type

on tabpage_1.create
this.cb_1=create cb_1
this.dw_5=create dw_5
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_5
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_5)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 544
integer width = 4695
integer height = 1592
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 3113
integer height = 520
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer width = 3040
integer height = 428
string dataobject = "dw_ge356_selecao"
end type

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
			This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
		
	Case "nm_fantasia"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Fornecedor.Nm_Fantasia Then
				Return 1
			End If
		Else
			io_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor	[1] = io_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fantasia		[1] = io_Fornecedor.Nm_Fantasia
		End If
		
		If Not gf_ge003_Lista_Divisao_Fornecedor(dw_1, io_Fornecedor.Cd_Fornecedor, 1) Then Return
		
	Case "nm_usuario"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Comprador.Nm_Usuario Then
				Return 1
			End If
		Else
			io_Comprador.of_Inicializa()
			
			This.Object.Nr_Matricula	[1] = io_Comprador.Nr_Matricula
			This.Object.Nm_Usuario	[1] = io_Comprador.Nm_Usuario
		End If
End Choose
end event

event dw_1::itemchanged;call super::itemchanged;Long ll_Lojas

String ls_Nulo

SetNull(ls_Nulo)

dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
			This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
		
	Case "nm_fantasia"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Fornecedor.Nm_Fantasia Then
				Return 1
			End If
		Else
			io_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor	[1] = io_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fantasia		[1] = io_Fornecedor.Nm_Fantasia
		End If
		
		If Not gf_ge003_Lista_Divisao_Fornecedor(dw_1, io_Fornecedor.Cd_Fornecedor, 1) Then Return
		
	Case "nm_usuario"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Comprador.Nm_Usuario Then
				Return 1
			End If
		Else
			io_Comprador.of_Inicializa()
			
			This.Object.Nr_Matricula	[1] = io_Comprador.Nr_Matricula
			This.Object.Nm_Usuario	[1] = io_Comprador.Nm_Usuario
		End If
		
	Case 'id_filiais'
		
		If Data = 'C' Then
			
			is_Filiais = ls_Nulo
			
			uo_ge216_filiais uo_filiais
			uo_Filiais = Create uo_ge216_filiais
			
			OpenWithParm(w_ge216_selecao_filiais, uo_Filiais)
			
			ll_Lojas = Message.DoubleParm
			
			If ll_Lojas > 0 Then
				is_filiais = uo_Filiais.ivs_filiais
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			End If
			
			Destroy(uo_Filiais)
		End If
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			io_Produto.of_Localiza_Produto(This.GetText())
			
			If io_Produto.Localizado Then
				This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
				This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
			End If
	
		Case "nm_fantasia"
			io_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			
			If io_Fornecedor.Localizado Then
				This.Object.Cd_Fornecedor	[1] = io_Fornecedor.Cd_Fornecedor
				This.Object.Nm_Fantasia		[1] = io_Fornecedor.Nm_Razao_Social
				
				If Not gf_ge003_Lista_Divisao_Fornecedor(dw_1, io_Fornecedor.Cd_Fornecedor, 1) Then Return
			End If
	
		Case "nm_usuario"
			io_Comprador.of_Localiza_Comprador(This.GetText())
			
			If io_Comprador.Localizado Then
				This.Object.Nr_Matricula	[1] = io_Comprador.Nr_Matricula
				This.Object.Nm_Usuario	[1] = io_Comprador.Nm_Usuario
			End If
	End Choose
End If
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer y = 616
integer width = 4631
integer height = 1492
string dataobject = "dw_ge356_lista_produtos"
end type

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;DateTime ldh_Inicio
DateTime ldh_Termino

Long ll_Produto
Long ll_Divisao

String ls_Fornecedor
String ls_Comprador
String ls_Filiais
String ls_Grupo
String ls_Planograma
String ls_Ativo
String ls_Conexao

dw_1.AcceptText()

ldh_Inicio		= dw_1.Object.Dh_Inicio						[1]
ldh_Termino	= dw_1.Object.Dh_Termino					[1]
ll_Produto		= dw_1.Object.Cd_Produto					[1]
ls_Fornecedor	= dw_1.Object.Cd_Fornecedor				[1]
ll_Divisao			= dw_1.Object.Nr_Divisao_Fornecedor	[1]
ls_Comprador	= dw_1.Object.Nr_Matricula					[1]
ls_Filiais			= dw_1.Object.Id_Filiais						[1]
ls_Grupo			= dw_1.Object.Cd_Grupo					[1]
ls_Planograma	= dw_1.Object.Id_Planograma				[1]
ls_Ativo			= dw_1.Object.Id_Ativo						[1]
ls_Conexao		= dw_1.Object.Id_Projeto_Conexao		[1]

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If Not IsNull(ll_Produto) And ll_Produto > 0 Then
	This.of_AppendWhere_SubQuery("pp.cd_produto = " + String(ll_Produto), 2)
End If

If Not IsNull(ls_Fornecedor) And Trim(ls_Fornecedor) <> "" Then
	This.of_AppendWhere_SubQuery("g.cd_fornecedor_usual = '" + ls_Fornecedor + "'", 2)
End If

If Not IsNull(ll_Divisao) And ll_Divisao > 0 Then
	This.of_AppendWhere_SubQuery("pp.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + ls_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 2)
End If

If Not IsNull(ls_Comprador) And Trim(ls_Comprador) <> "" Then
	This.of_AppendWhere_SubQuery("c.nr_matricula_comprador = '" + ls_Comprador + "'", 2)
End If

If ls_Filiais = 'C' Then
	If Not IsNull(is_Filiais) Then
		This.of_AppendWhere_SubQuery("p.cd_filial in (" + is_Filiais + ")", 2)
	End If
End If

If Not IsNull(ls_Grupo) And ls_Grupo <> "0" Then
	This.of_AppendWhere_SubQuery("substring(g.cd_subcategoria, 1, 1) = '" + ls_Grupo + "'", 2)
End If

If ls_Planograma = "S" Then
	This.of_AppendWhere_SubQuery("s.id_tipo_promocao = 'P'", 2)
End If

If ls_Ativo = "S" Then
	This.of_AppendWhere_SubQuery("g.id_situacao = 'A'", 2)
End If

If ls_Conexao = "S" Then
	This.of_AppendWhere_SubQuery("pp.id_projeto_conexao is not null", 2)
End If

Return 1
end event

event dw_2::ue_recuperar;//OverRide

dw_1.AcceptText()

Return This.Retrieve(dw_1.Object.Dh_Inicio[1], dw_1.Object.Dh_Termino[1])
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	
	If Not wf_Saldo_Em_Transito() Then Return -1
	
	If Not wf_Quantidade_Pedida_Cd() Then Return -1
	
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 4750
integer height = 2164
string text = "Filiais"
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 3598
integer height = 2124
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer width = 3529
integer height = 2032
string dataobject = "dw_ge356_lista_filiais"
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event dw_3::constructor;call super::constructor;This.of_SetRowSelection()

This.ivb_Ordena_Colunas = True
end event

event dw_3::ue_recuperar;//OverRide

dw_1.AcceptText()
dw_2.AcceptText()

Return This.Retrieve(dw_1.Object.Dh_Inicio[1], dw_1.Object.Dh_Termino[1], dw_2.Object.Cd_Produto[dw_2.GetRow()])
end event

event dw_3::ue_key;call super::ue_key;If Key = KeyF4! Then
	Event ue_Consulta_Filial()
End If

If Key = KeyF5! Then
	Event ue_Consulta_Distribuidoras()
End If
end event

event dw_3::ue_preretrieve;call super::ue_preretrieve;String ls_Filiais, ls_Conexao

dw_1.AcceptText()

ls_Filiais 		= dw_1.Object.Id_Filiais					[1]
ls_Conexao	= dw_1.Object.Id_Projeto_Conexao	[1]

If ls_Filiais = 'C' Then
	If Not IsNull(is_Filiais) Then
		This.of_AppendWhere_SubQuery("p.cd_filial in (" + is_Filiais + ")", 2)
	End If
End If

If ls_Conexao = "S" Then
	This.of_AppendWhere_SubQuery("pp.id_projeto_conexao is not null", 2)
End If

Return 1
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;//Salvar planilha
If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

type cb_1 from commandbutton within tabpage_1
integer x = 3173
integer y = 432
integer width = 667
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gerar Planilha de Filiais"
end type

event clicked;DateTime ldh_Inicio
DateTime ldh_Termino

dw_1.AcceptText()

ldh_Inicio		= dw_1.Object.Dh_Inicio		[1]
ldh_Termino	= dw_1.Object.Dh_Termino	[1]

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

dw_5.Event ue_Retrieve()
end event

type dw_5 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 3246
integer y = 32
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge356_excel_filiais"
end type

event ue_recuperar;//OverRide

dw_1.AcceptText()

Return This.Retrieve(dw_1.Object.Dh_Inicio[1], dw_1.Object.Dh_Termino[1])
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	
	Integer lvi_Retorno
	
	Try
		
		Open(w_Aguarde)	
		w_Aguarde.Title = "Gerando planilha... Aguarde"
			
		dw_5.Event ue_SaveAs()
		
	Finally
		Close(w_Aguarde)
	End Try
End If

Return pl_Linhas
end event

event ue_preretrieve;call super::ue_preretrieve;DateTime ldh_Inicio
DateTime ldh_Termino

Long ll_Produto
Long ll_Divisao

String ls_Fornecedor
String ls_Comprador
String ls_Filiais
String ls_Grupo
String ls_Planograma
String ls_Ativo
String ls_Conexao

dw_1.AcceptText()

ldh_Inicio		= dw_1.Object.Dh_Inicio						[1]
ldh_Termino	= dw_1.Object.Dh_Termino					[1]
ll_Produto		= dw_1.Object.Cd_Produto					[1]
ls_Fornecedor	= dw_1.Object.Cd_Fornecedor				[1]
ll_Divisao			= dw_1.Object.Nr_Divisao_Fornecedor	[1]
ls_Comprador	= dw_1.Object.Nr_Matricula					[1]
ls_Filiais			= dw_1.Object.Id_Filiais						[1]
ls_Grupo			= dw_1.Object.Cd_Grupo					[1]
ls_Planograma	= dw_1.Object.Id_Planograma				[1]
ls_Ativo			= dw_1.Object.Id_Ativo						[1]
ls_Conexao		= dw_1.Object.Id_Projeto_Conexao		[1]

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If Not IsNull(ll_Produto) And ll_Produto > 0 Then
	This.of_AppendWhere_SubQuery("pp.cd_produto = " + String(ll_Produto), 6)
End If

If Not IsNull(ls_Fornecedor) And Trim(ls_Fornecedor) <> "" Then
	This.of_AppendWhere_SubQuery("g.cd_fornecedor_usual = '" + ls_Fornecedor + "'", 6)
End If

If Not IsNull(ll_Divisao) And ll_Divisao > 0 Then
	This.of_AppendWhere_SubQuery("pp.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + ls_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 6)
End If

If Not IsNull(ls_Comprador) And Trim(ls_Comprador) <> "" Then
	This.of_AppendWhere_SubQuery("c.nr_matricula_comprador = '" + ls_Comprador + "'", 6)
End If

If ls_Filiais = 'C' Then
	If Not IsNull(is_Filiais) Then
		This.of_AppendWhere_SubQuery("p.cd_filial in (" + is_Filiais + ")", 6)
	End If
End If

If Not IsNull(ls_Grupo) And ls_Grupo <> "0" Then
	This.of_AppendWhere_SubQuery("substring(g.cd_subcategoria, 1, 1) = '" + ls_Grupo + "'", 6)
End If

If ls_Planograma = "S" Then
	This.of_AppendWhere_SubQuery("s.id_tipo_promocao = 'P'", 6)
End If

If ls_Ativo = "S" Then
	This.of_AppendWhere_SubQuery("g.id_situacao = 'A'", 6)
End If

If ls_Conexao = "S" Then
	This.of_AppendWhere_SubQuery("pp.id_projeto_conexao is not null", 6)
End If

Return 1
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4750
integer height = 2164
long backcolor = 67108864
string text = "Distribuidoras"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
gb_4 gb_4
dw_4 dw_4
end type

on tabpage_3.create
this.gb_4=create gb_4
this.dw_4=create dw_4
this.Control[]={this.gb_4,&
this.dw_4}
end on

on tabpage_3.destroy
destroy(this.gb_4)
destroy(this.dw_4)
end on

type gb_4 from groupbox within tabpage_3
integer x = 32
integer y = 16
integer width = 3886
integer height = 2120
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Distribuidoras"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within tabpage_3
integer x = 73
integer y = 72
integer width = 3813
integer height = 2040
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge356_lista_distribuidoras"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_recuperar;//OverRide

dw_3.AcceptText()

This.Object.Produto.Text	= dw_3.Object.De_Produto		[dw_3.GetRow()] + " (" + String(dw_3.Object.Cd_Produto	[dw_3.GetRow()]) + ")"
This.Object.Filial.Text		= dw_3.Object.Nm_Fantasia	[dw_3.GetRow()] + " (" + String(dw_3.Object.Cd_Filial		[dw_3.GetRow()]) + ")"

Return This.Retrieve(dw_3.Object.Cd_Filial[dw_3.GetRow()], dw_3.Object.Nr_Pedido_Filial[dw_3.GetRow()], dw_3.Object.Cd_Produto[dw_3.GetRow()])
end event

event constructor;call super::constructor;This.of_SetRowSelection()

This.ivb_Ordena_Colunas = True
end event

event ue_key;call super::ue_key;If Key = KeyF4! Then
	Event ue_Consulta_Filial()
End If

If Key = KeyF5! Then
	Event ue_Consulta_Distribuidoras()
End If
end event

