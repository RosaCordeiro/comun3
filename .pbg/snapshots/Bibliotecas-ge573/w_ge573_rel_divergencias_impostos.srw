HA$PBExportHeader$w_ge573_rel_divergencias_impostos.srw
forward
global type w_ge573_rel_divergencias_impostos from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge573_rel_divergencias_impostos from dc_w_selecao_lista_relatorio
string tag = "w_ge573_rel_divergencias_impostos"
integer width = 5792
integer height = 2308
string title = "GE573 - Diverg$$HEX1$$ea00$$ENDHEX$$ncia de Impostos"
end type
global w_ge573_rel_divergencias_impostos w_ge573_rel_divergencias_impostos

type variables
uo_produto ivo_produto

uo_fornecedor ivo_fornecedor

uo_ge149_comprador io_comprador

string 	is_Distribuidoras, &
			is_Produto, is_campo_anterior

long il_count_campos_div_sel


end variables

forward prototypes
public subroutine wf_insere_distribuidora_default ()
public subroutine wf_insere_uf_default ()
public subroutine wf_insere_grupo_default ()
public subroutine _documentacao ()
end prototypes

public subroutine wf_insere_distribuidora_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_distribuidora", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_fornecedor", "000000000")
	lvdwc.SetItem(1, "nm_fantasia",   "TODAS")
	
	dw_1.Object.Cd_Distribuidora[1] = "000000000"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da distribuidora.")
End If
end subroutine

public subroutine wf_insere_uf_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_uf", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_unidade_federacao", "XX")
	lvdwc.SetItem(1, "nm_unidade_federacao", "TODAS")
	
	dw_1.Object.Cd_UF[1] = "XX"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da U.F..")
End If
end subroutine

public subroutine wf_insere_grupo_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_grupo", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_grupo", "0")
	lvdwc.SetItem(1, "de_grupo", "TODOS")
	
	dw_1.Object.Cd_grupo[1] = "0"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do Grupo.")
End If

end subroutine

public subroutine _documentacao ();// GE537 - Relat$$HEX1$$f300$$ENDHEX$$rio de diverg$$HEX1$$ea00$$ENDHEX$$ncia de Impostos

// Esta interface exibe os produtos que possuem diverg$$HEX1$$ea00$$ENDHEX$$ncias em algum dos dados de impostos dentre os listados abaixo. 

//NCM
//SITUA$$HEX2$$c700c300$$ENDHEX$$O
//CEST
//CST
//ICMS ST(%)
//MVA(%)
//VL. PMC

// Conforme solicitado, os filtros presentes neste relat$$HEX1$$f300$$ENDHEX$$rio s$$HEX1$$e300$$ENDHEX$$o semelhantes aos da interface GE162, com a adi$$HEX2$$e700e300$$ENDHEX$$o do filtro "Campos Divergentes", 
// onde o usu$$HEX1$$e100$$ENDHEX$$rio poder$$HEX1$$e100$$ENDHEX$$ selecionar quais campos de impostos ele quer que sejam aplicados como filtro.
// ao listar os itens, a interface exibir$$HEX1$$e100$$ENDHEX$$ em vermelho os campos com valores divergentes.
// habilitada ordena$$HEX2$$e700e300$$ENDHEX$$o de colunas e gera$$HEX2$$e700e300$$ENDHEX$$o de excel.
end subroutine

on w_ge573_rel_divergencias_impostos.create
call super::create
end on

on w_ge573_rel_divergencias_impostos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Fornecedor)
Destroy(io_comprador)
end event

event open;call super::open;
ivo_Produto 		= Create uo_Produto
ivo_Fornecedor = Create uo_Fornecedor
io_comprador	= Create uo_ge149_comprador


end event

event ue_postopen;call super::ue_postopen;

wf_Insere_Distribuidora_Default()

wf_Insere_UF_Default()

wf_Insere_Grupo_Default()

//gf_ge003_lista_divisao_fornecedor(dw_1, "", 1)



end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge573_rel_divergencias_impostos
integer y = 1396
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge573_rel_divergencias_impostos
integer y = 1324
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge573_rel_divergencias_impostos
integer y = 540
integer width = 5701
integer height = 1576
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge573_rel_divergencias_impostos
integer width = 5001
integer height = 508
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge573_rel_divergencias_impostos
integer width = 4933
integer height = 400
string dataobject = "dw_ge573_selecao"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)

end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
		
		If IsNull(dw_1.Object.Cd_Produto[1]) Then
			dw_1.Object.Id_Planilha.Visible = True
		Else
			dw_1.Object.Id_Planilha.Visible = False
		End If
		
	Case "cd_distribuidora"
		If IsNull(dw_1.Object.Cd_Produto[1]) Then
			If Data <> "000000000" Then
				dw_1.Object.Id_Planilha.Visible = True
				
				dw_1.Object.Id_Seleciona_Distrib[1] = "N"
				is_Distribuidoras = ""
			End If
			
		End If
		
		If Data <> "000000000" Then
			dw_1.Object.Id_Homologacao.Visible = False
		Else
			dw_1.Object.Id_Homologacao.Visible = True
		End If
		
	Case "nm_fornecedor"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
		
		gf_ge003_lista_divisao_fornecedor(dw_1, ivo_Fornecedor.Cd_Fornecedor, 1)
		
	Case "nm_usuario"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_comprador.nm_usuario Then
				Return 1
			End If
		Else
			io_comprador.of_Inicializa()
				
			This.Object.nr_matricula	[1] = io_comprador.nr_matricula
			This.Object.nm_usuario  [1] = io_comprador.nm_usuario
		End If
End Choose

If dwo.Name = "de_produto" Then
	If IsNull(dw_1.Object.Cd_Produto[1]) Then
		If Data <> "000000000" Then
			dw_1.Object.Id_Planilha.Visible = True
		End If
		
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;datawindowchild ldwc

long i

dw_2.Event ue_Reset()

Long ll_Nulo

String ls_Nulo

SetNull(ll_Nulo)
SetNull(ls_Nulo)

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
		
	Case "cd_distribuidora"
		If IsNull(dw_1.Object.Cd_Produto[1]) Then
			If Data <> "000000000" Then
				dw_1.Object.Id_Planilha.Visible = True
				
				dw_1.Object.Id_Seleciona_Distrib[1] = "N"
				is_Distribuidoras = ""
			End If
			
		End If
		
		If Data <> "000000000" Then
			dw_1.Object.Id_Homologacao.Visible = False
		Else
			dw_1.Object.Id_Homologacao.Visible = True
		End If
		
	Case "nm_fornecedor"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
		
		gf_ge003_lista_divisao_fornecedor(dw_1, ivo_Fornecedor.Cd_Fornecedor, 1)
		
	Case "nm_usuario"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_comprador.nm_usuario Then
				Return 1
			End If
		Else
			io_comprador.of_Inicializa()
				
			This.Object.nr_matricula	[1] = io_comprador.nr_matricula
			This.Object.nm_usuario  [1] = io_comprador.nm_usuario
		End If
		
	Case "id_planilha"
		If Data = "S" Then
			OpenWithParm(w_ge162_filtro_via_planilha, '')
			
			is_Produto = Message.StringParm
			
			If Trim(is_Produto) = "" Or IsNull(is_Produto) Then
				Return 1
			End If
					
			dw_1.Object.De_Produto[1] = ls_Nulo
			dw_1.Object.Cd_Produto[1] = ll_Nulo
			
		Else
			is_Produto = ""
		End If
		
		Case "id_seleciona_distrib"
			If Data = "S" Then
				OpenWithParm(w_ge162_selecao_distribuidoras, "")
				
				is_Distribuidoras = Message.StringParm
				
				If Trim(is_Distribuidoras) = "" Or IsNull(is_Distribuidoras) Then
					Return 1
				End If
						
				dw_1.Object.Cd_Distribuidora[1] = "000000000"
				
			Else
				is_Distribuidoras = ""
			End If


	case 'id_campos_divergencia' 
		il_count_campos_div_sel = 0
				
		if this.getchild('id_campos_divergencia', ldwc) = -1 then
			messagebox('Erro', 'Erro ao buscar datawindowchild do campo id_campos_convergencia. Contate o suporte.', stopsign!)
			return
		end if

		if ldwc.getrow() > 0 then
			if ldwc.getrow() <> 1 then
				ldwc.setitem(ldwc.getrow(), 'id_selecionado', 'S')
				
				ldwc.setitem(1, 'id_selecionado', 'N')
				
				// conta quantos campos estao selecionados
				for i = 2 to ldwc.rowcount()
					if ldwc.getitemstring(i, 'id_selecionado' ) = 'S' then il_count_campos_div_sel ++
				next
			else
				ldwc.setitem(1, 'id_selecionado', 'S')
				
				for i = 2 to ldwc.rowcount()
					ldwc.setitem(i, 'id_selecionado', 'N')
				next
			end if
		end if
	
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Produto) Then
	This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
End If

If IsValid(ivo_Fornecedor) Then
	This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
End If
end event

event dw_1::ue_key;call super::ue_key;dw_1.AcceptText()

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
				
				dw_1.Object.Id_Planilha[1] = "N"
				dw_1.Object.Id_Planilha.Visible = False
				is_Produto = ""
				
			End If
		
		Case "nm_fornecedor"
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			
			If ivo_Fornecedor.Localizado Then
				This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
				This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
			End If
			
			gf_ge003_lista_divisao_fornecedor(dw_1, ivo_Fornecedor.Cd_Fornecedor, 1)
			
		Case "nm_usuario"
			io_comprador.of_Localiza_comprador( This.GetText() )
		
			If io_comprador.Localizado Then
				This.Object.nr_matricula	[1] = io_comprador.nr_matricula
				This.Object.nm_usuario  [1] = io_comprador.nm_usuario
			End If
			
	End Choose
End If


end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;if dwo.name = 'id_campos_divergencia_sel' then
	this.post setcolumn('id_campos_divergencia')
	this.object.id_campos_divergencia_sel.visible = '0'
end if

if is_campo_anterior = 'id_campos_divergencia' then
	if il_count_campos_div_sel = 1 then
		this.object.id_campos_divergencia_sel[1] = String(il_count_campos_div_sel) + ' SELECIONADO'
	elseif il_count_campos_div_sel > 1 then
		this.object.id_campos_divergencia_sel[1] = String(il_count_campos_div_sel) + ' SELECIONADOS'
	else
		this.object.id_campos_divergencia_sel[1] = 'TODOS'
	end if
	
	this.object.id_campos_divergencia_sel.visible = '1'
end if

is_campo_anterior = dwo.name
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge573_rel_divergencias_impostos
integer x = 59
integer y = 604
integer width = 5627
integer height = 1476
string dataobject = "dw_ge573_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Produto
Long ll_Divisao
Long i, lvl_VersaoLayout

String lvs_Distribuidora
String lvs_Situacao
String lvs_Fornecedor
String lvs_Produto_Distribuidora
String lvs_DW
String lvs_DW3
String lvs_UF
String lvs_grupo
String lvs_Comprador
String lvs_Situacao_Clamed
String ls_Sit
String ls_Planilha
String ls_Homologacao
String lvs_Coluna[]
String lvs_Nome[]
String ls_Tipo_Preco
String ls_sql
String lvs_Erro
datawindowchild ldwc

dw_1.AcceptText()

lvs_Distribuidora         	= dw_1.Object.Cd_Distribuidora			[1]
lvl_Produto               	= dw_1.Object.Cd_Produto					[1]
lvs_Fornecedor            	= dw_1.Object.Cd_Fornecedor				[1]
lvs_Situacao              	= dw_1.Object.Id_Situacao					[1]
lvs_Produto_Distribuidora	= dw_1.Object.Cd_Produto_Distribuidora	[1]
lvs_UF                    	= dw_1.Object.Cd_UF               		[1]
lvs_Grupo                 	= dw_1.Object.Cd_grupo            		[1]
lvs_Comprador					= dw_1.Object.nr_matricula         		[1]
lvs_Situacao_Clamed			= dw_1.Object.Id_Situacao_clamed   		[1]
ls_Planilha						= dw_1.Object.Id_Planilha					[1]
ls_Homologacao					= dw_1.Object.Id_Homologacao				[1]
ll_Divisao						= dw_1.Object.Nr_Divisao_Fornecedor		[1]
ls_Tipo_Preco					= dw_1.Object.Id_Tipo_Preco				[1]

If is_Produto = "" And is_Distribuidoras = "" Then
	If (IsNull(lvs_Distribuidora) Or lvs_Distribuidora = "000000000") And (lvs_UF = "XX") And (lvs_Situacao = "T") And (IsNull(lvl_Produto) or lvl_Produto = 0) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a distribuidora ou a UF ou a situa$$HEX2$$e700e300$$ENDHEX$$o na distribuidora ou o produto.")
		dw_1.Event ue_Pos(1, "cd_distribuidora")
		Return -1
	End If
	
	If (IsNull(lvs_Distribuidora) Or lvs_Distribuidora = "000000000") And (lvs_UF = "XX") And (lvs_Situacao = "A" Or lvs_Situacao = "B" Or lvs_Situacao = "P") And (IsNull(lvl_Produto) or lvl_Produto = 0)Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Com os par$$HEX1$$e200$$ENDHEX$$metros selecionados este relat$$HEX1$$f300$$ENDHEX$$rio pode demorar at$$HEX1$$e900$$ENDHEX$$ 10 minutos para terminar sua execu$$HEX2$$e700e300$$ENDHEX$$o." + &
						"~rDeseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then Return -1
	End If
End If

// filtra pelos campos de diverg$$HEX1$$ea00$$ENDHEX$$ncia selecionados no filtro
if dw_1.getchild('id_campos_divergencia', ldwc) = -1 then
	messagebox('Erro', 'Erro ao buscar datawindowchild do campo id_campos_convergencia. Contate o suporte.', stopsign!)
	return -1
end if

// se a primeira op$$HEX2$$e700e300$$ENDHEX$$o "Todos" estiver selecionada, monta filtro com todos os campos de diverg$$HEX1$$ea00$$ENDHEX$$ncia
ls_sql = "("

for i = 2 to ldwc.rowcount()
	if ldwc.getitemstring(1, 'id_selecionado') = 'S' or ldwc.getitemstring(i, 'id_selecionado') = 'S' then
		ls_sql += +ldwc.getitemstring(i, 'nm_campo_clamed') + " <> "+ldwc.getitemstring(i, 'nm_campo_distrib') + " or "
	end if
next

// retira o ultimo "or "
ls_sql = left(ls_sql, len(ls_sql) - 3)

ls_sql += ")"

This.of_AppendWhere(ls_sql)


If is_Distribuidoras = "" Then
	If Not IsNull(lvs_Distribuidora) and lvs_Distribuidora <> "000000000" Then
		// 1341865
		If Not gf_ge071_versao_layout_ped_eletronico_sap(lvs_Distribuidora, Ref lvl_VersaoLayout, False, Ref lvs_Erro) Then
			MessageBox("Erro", "Erro ao verificar vers$$HEX1$$e300$$ENDHEX$$o do layout do arquivo de pre$$HEX1$$e700$$ENDHEX$$os da distribuidora.~r~r"+lvs_Erro, StopSign!)
			dw_1.Event ue_Pos(1, "cd_distribuidora")
			Return -1
		End If
		If lvl_VersaoLayout < 128 Then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A distribuidora selecionada utiliza o layout do arquivo de pre$$HEX1$$e700$$ENDHEX$$os anterior ao 1.28 e n$$HEX1$$e300$$ENDHEX$$o possui as informa$$HEX2$$e700f500$$ENDHEX$$es de tributa$$HEX2$$e700e300$$ENDHEX$$o necess$$HEX1$$e100$$ENDHEX$$rias para fazer a compara$$HEX2$$e700e300$$ENDHEX$$o.", Exclamation!)
			dw_1.Event ue_Pos(1, "cd_distribuidora")
			Return -1
		End If
		This.of_AppendWhere("d.cd_distribuidora = '" + lvs_Distribuidora + "'")
	End If
	
Else
	This.of_AppendWhere("d.cd_distribuidora in (" + is_Distribuidoras + ")")
End If

If is_Produto = "" Then
	If Not IsNull(lvl_Produto) and lvl_Produto <> 0 Then
		This.of_AppendWhere("d.cd_produto = " + String(lvl_Produto))
	End If
	
	If Not IsNull(lvs_Produto_Distribuidora) and Trim(lvs_Produto_Distribuidora) <> "" Then
		This.of_AppendWhere("d.cd_produto_distribuidora = '" + lvs_Produto_Distribuidora + "'")
	End If
Else
	This.of_AppendWhere("d.cd_produto in (" + is_Produto + ")")
End If

If Not IsNull(lvs_Fornecedor) and Trim(lvs_Fornecedor) <> "" Then
	This.of_AppendWhere("g.cd_fornecedor_usual = '" + lvs_Fornecedor + "'")
End If

//Matricula Comprador
If Not IsNull( lvs_Comprador ) Then
	This.of_AppendWhere("c.nr_matricula_comprador = '" + lvs_Comprador + "'")
End If

If lvs_Situacao <> "T" Then
	This.of_AppendWhere("d.id_situacao = '" + lvs_Situacao + "'")
End If

If lvs_Situacao_Clamed <> "T" Then
	This.of_AppendWhere("g.id_situacao = '" + lvs_Situacao_Clamed + "'")
End If

If Not IsNull(lvs_grupo) and Trim(lvs_grupo) <> "0" Then
	This.of_AppendWhere("substring(g.cd_subcategoria, 1, 1) = '" + lvs_grupo + "'")
End If

If Not IsNull(lvs_UF) and Trim(lvs_UF) <> "XX" Then
	This.of_AppendWhere("d.cd_unidade_federacao = '" + lvs_UF + "'")
End If

If lvs_Distribuidora = "000000000" Then
	If ls_Homologacao = "N" Then
		This.of_AppendWhere("duf.id_homologando_pedido= 'N'")
	End If
End If

Choose Case ls_Tipo_Preco
	Case "T" //Todos
		
	Case "M" //Maior que zero
		This.of_AppendWhere("Coalesce(d.vl_preco_novo, d.vl_preco_atual) > 0.00")
		
	Case "I" //Igual a zero
		This.of_AppendWhere("Coalesce(d.vl_preco_novo, d.vl_preco_atual) = 0.00")
End Choose

// joguei a divisao para ser adicionado por ultimo para nao criar problema com nenhum of_AppendWhere que venha depois, pois este filtro adiciona um novo where
If Not IsNull(ll_Divisao) And ll_Divisao > 0 Then
	This.of_AppendWhere("d.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + lvs_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")")
End If

Return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;ivm_Menu.mf_SalvarComo(pl_linhas > 0)

return AncestorReturnValue

end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge573_rel_divergencias_impostos
integer x = 5687
integer y = 172
end type

