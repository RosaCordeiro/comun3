HA$PBExportHeader$w_ge198_manutencao_pedido_empurrado.srw
forward
global type w_ge198_manutencao_pedido_empurrado from dc_w_2tab_consulta_selecao_lista_det
end type
type cb_cancelar from commandbutton within tabpage_2
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

global type w_ge198_manutencao_pedido_empurrado from dc_w_2tab_consulta_selecao_lista_det
integer width = 4133
integer height = 2488
string title = "GE198 - Manuten$$HEX2$$e700e300$$ENDHEX$$o de Pedidos Empurrados"
end type
global w_ge198_manutencao_pedido_empurrado w_ge198_manutencao_pedido_empurrado

type variables
uo_filial						ivo_filial		//GE009
uo_produto					ivo_produto	//GE001
uo_pedido_empurrado	io_Pedido	//GE198
end variables

on w_ge198_manutencao_pedido_empurrado.create
int iCurrent
call super::create
end on

on w_ge198_manutencao_pedido_empurrado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;This.ivl_Altura_1	= 2325
This.ivl_Largura_1	= 4115

This.ivl_Altura_2	= 1850
This.ivl_Largura_2	= 3744
end event

event open;call super::open;ivo_Filial		= Create uo_Filial
ivo_Produto	= Create uo_Produto
io_Pedido	= Create uo_pedido_empurrado
end event

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Produto)
Destroy(io_Pedido)
end event

event ue_postopen;call super::ue_postopen;Tab_1.TabPage_1.dw_1.Object.Dt_Inicio [1] = Today()
Tab_1.TabPage_1.dw_1.Object.Dt_Termino[1] = Today()
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge198_manutencao_pedido_empurrado
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge198_manutencao_pedido_empurrado
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge198_manutencao_pedido_empurrado
integer x = 0
integer y = 4
integer width = 4073
integer height = 2288
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

event tab_1::selectionchanging;SetPointer(HourGlass!)

Choose Case NewIndex 
	
	Case 2,3
		
		If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
			// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
			// das DW's de detalhes
			
			if NewIndex = 2 then
				Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
			Elseif NewIndex = 3 Then
				Tab_1.TabPage_3.dw_4.Event ue_Retrieve()
			ENd if
	
			// Permite a troca do folder
			Return 0
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		End If
		
ENd Choose

SetPointer(Arrow!)
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 4037
integer height = 2172
end type

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer x = 9
integer y = 348
integer width = 3991
integer height = 1792
string text = "Lista de Pedidos"
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer x = 9
integer y = 8
integer width = 2075
integer height = 332
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 50
integer y = 68
integer width = 2016
integer height = 256
string dataobject = "dw_ge198_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "nm_filial"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
		End If
		
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
		End If
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia	
End If

If IsValid(ivo_Produto) Then
	This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If
end event

event dw_1::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
				This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
			End If
			
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
			End If
	End Choose
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "nm_filial"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
		End If
		
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
		End If
End Choose
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer x = 37
integer y = 404
integer width = 3931
integer height = 1708
string dataobject = "dw_ge198_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Filial, &
     lvl_Produto
	  
dw_1.AcceptText()

lvl_Filial   = dw_1.Object.Cd_Filial [1]
lvl_Produto  = dw_1.Object.Cd_Produto[1]

If Not IsNull(lvl_Filial) and lvl_Filial > 0 Then
	This.of_AppendWhere("p.cd_filial = " + String(lvl_Filial))
End If

If Not IsNull(lvl_Produto) and lvl_Produto > 0 Then
	This.of_AppendFrom("pedido_empurrado_produto b")
	This.of_AppendWhere("b.cd_filial = p.cd_filial and b.nr_pedido_empurrado = p.nr_pedido_empurrado and b.cd_produto = " + String(lvl_Produto))
End If

Return 1
end event

event dw_2::ue_recuperar;// Override

Date lvdt_Inicio, &
     lvdt_Termino
	  
lvdt_Inicio  = dw_1.Object.Dt_Inicio [1]
lvdt_Termino = dw_1.Object.Dt_Termino[1]

If IsNull(lvdt_Inicio) or Not IsDate(String(lvdt_Inicio)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdt_Termino) or Not IsDate(String(lvdt_Termino)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_termino")	
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Information!)
	dw_1.Event ue_Pos(1, "dt_termino")	
	Return -1
End If

Return This.Retrieve(lvdt_Inicio, lvdt_Termino)
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 4037
integer height = 2172
cb_cancelar cb_cancelar
end type

on tabpage_2.create
this.cb_cancelar=create cb_cancelar
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancelar
end on

on tabpage_2.destroy
call super::destroy
destroy(this.cb_cancelar)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer x = 9
integer y = 8
integer width = 3744
integer height = 1564
string text = "Produtos do Pedido"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 32
integer y = 64
integer width = 3680
integer height = 1492
string dataobject = "dw_ge198_detalhe"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_3::constructor;call super::constructor;This.of_SetRowSelection()
This.ivb_Ordena_Colunas = True
end event

event dw_3::ue_recuperar;// Override

Long lvl_Linha, &
     lvl_Filial, &
     lvl_Pedido

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Filial = Tab_1.TabPage_1.dw_2.Object.Cd_Filial          [lvl_Linha]
	lvl_Pedido = Tab_1.TabPage_1.dw_2.Object.Nr_Pedido_Empurrado[lvl_Linha]
	
	Return This.Retrieve(lvl_Filial, lvl_Pedido)
End If

Return -1
end event

event dw_3::rowfocuschanged;call super::rowfocuschanged;Boolean lvb_Habilita = False

Long lvl_Linha

String lvs_Processado, &
       lvs_Situacao

If CurrentRow > 0 Then
	lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()
	
	lvs_Processado = Tab_1.TabPage_1.dw_2.Object.Id_Processado[lvl_Linha]
	lvs_Situacao   = This.Object.Id_Situacao[CurrentRow]
	
	If lvs_Situacao = "C" Then
		lvb_Habilita = True
	End If
End If

cb_Cancelar.Enabled = lvb_Habilita
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
	cb_Cancelar.Enabled = False
End If

Return pl_Linhas
end event

type cb_cancelar from commandbutton within tabpage_2
integer x = 2802
integer y = 1596
integer width = 901
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Cancelar Pend$$HEX1$$ea00$$ENDHEX$$ncia do Produto"
end type

event clicked;Long	lvl_Linha, &
		lvl_Filial, &
		lvl_Pedido, &
		lvl_Produto
		
Long ll_existe
	  
lvl_Linha = dw_3.GetRow()

lvl_Filial  = dw_3.Object.Cd_Filial          				[lvl_Linha]
lvl_Pedido  = dw_3.Object.Nr_Pedido_Empurrado	[lvl_Linha]
lvl_Produto = dw_3.Object.Cd_Produto         		[lvl_Linha]

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma o cancelamento da pend$$HEX1$$ea00$$ENDHEX$$ncia do produto selecionado ?", Question!, YesNo!, 2) = 1 Then
	SetPointer(HourGlass!)
	
	//Avisar o usu$$HEX1$$e100$$ENDHEX$$rio caso o protuto seja para atender algum pedido do ecommerce:
	Select count(*)
	into :ll_existe
	from pedido_empurrado_produto
	where cd_filial = :lvl_filial
		and nr_pedido_empurrado = :lvl_Pedido
		and cd_produto = :lvl_produto
		and id_ecommerce = 'S';
	
	if sqlca.sqlcode = -1 then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Problemas ao consultar a tabela pedido_empurrado_produto: " + sqlca.sqlerrtext, StopSign!)
		return -1
	ENd if
	
	if ll_existe > 0 Then
		if MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Este item foi inserido para atender uma demanda do e-Commerce. Deseja continuar mesmo assim ?", Question!, YesNo!, 2) = 2 Then return -1
	ENd if
	
	If Not io_Pedido.of_Cancela_Produto_Pedido(lvl_Filial, lvl_Pedido, lvl_Produto) Then Return -1
	
	SqlCa.of_Commit()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cancelamento da pend$$HEX1$$ea00$$ENDHEX$$ncia do produto realizada com sucesso.", Information!)
	dw_3.Event ue_Retrieve()
	
	SetPointer(Arrow!)
End If
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4037
integer height = 2172
long backcolor = 67108864
string text = "Pedido e-Commerce"
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
integer x = 46
integer y = 20
integer width = 3963
integer height = 2104
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Pedidos:"
end type

type dw_4 from dc_uo_dw_base within tabpage_3
integer x = 82
integer y = 108
integer width = 3909
integer height = 1980
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge198_ecommerce"
boolean vscrollbar = true
end type

event ue_recuperar;// Override

Long lvl_Linha, &
     lvl_Filial, &
     lvl_Pedido

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Filial = Tab_1.TabPage_1.dw_2.Object.Cd_Filial[lvl_Linha]
	lvl_Pedido = Tab_1.TabPage_1.dw_2.Object.Nr_Pedido_Empurrado[lvl_Linha]
	
	Return This.Retrieve(lvl_Filial, lvl_Pedido)
End If

Return -1
end event

