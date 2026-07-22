HA$PBExportHeader$w_ge407_divergencia_cadastro_produto_dis.srw
forward
global type w_ge407_divergencia_cadastro_produto_dis from dc_w_selecao_lista_relatorio
end type
type cb_1 from commandbutton within w_ge407_divergencia_cadastro_produto_dis
end type
type cb_2 from commandbutton within w_ge407_divergencia_cadastro_produto_dis
end type
end forward

global type w_ge407_divergencia_cadastro_produto_dis from dc_w_selecao_lista_relatorio
string accessiblename = "Diverg$$HEX1$$ea00$$ENDHEX$$ncia de Cadastro Produto Distribuidora (GE407)"
integer width = 5550
integer height = 2548
string title = "GE407 - Diverg$$HEX1$$ea00$$ENDHEX$$ncia de Cadastro Produto Distribuidora"
cb_1 cb_1
cb_2 cb_2
end type
global w_ge407_divergencia_cadastro_produto_dis w_ge407_divergencia_cadastro_produto_dis

type variables
uo_produto io_Produto

Boolean ivb_Check
end variables

forward prototypes
public subroutine wf_insere_distribuidora_default ()
public subroutine wf_insere_uf_default ()
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
	
	lvdwc.SetItem(1, "cd_unidade_federacao", "T")
	lvdwc.SetItem(1, "nm_unidade_federacao", "TODAS")
	
	dw_1.Object.Cd_UF[1] = "T"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da U.F..")
End If
end subroutine

on w_ge407_divergencia_cadastro_produto_dis.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
end on

on w_ge407_divergencia_cadastro_produto_dis.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event ue_postopen;call super::ue_postopen;wf_Insere_Distribuidora_Default()

wf_Insere_Uf_Default()
end event

event open;call super::open;io_Produto = Create uo_produto
end event

event close;call super::close;Destroy(io_Produto)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge407_divergencia_cadastro_produto_dis
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge407_divergencia_cadastro_produto_dis
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge407_divergencia_cadastro_produto_dis
integer y = 384
integer width = 5426
integer height = 1952
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge407_divergencia_cadastro_produto_dis
integer width = 3451
integer height = 344
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge407_divergencia_cadastro_produto_dis
integer x = 64
integer y = 80
integer width = 3406
integer height = 252
string dataobject = "dw_ge407_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

If dwo.Name = "de_produto" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque Then
			Return 1
		End If
	Else
		io_Produto.of_Inicializa()
		
		This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
		This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

If dwo.Name = "de_produto" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque Then
			Return 1
		End If
	Else
		io_Produto.of_Inicializa()
		
		This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
		This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
	End If
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "de_produto" Then
		io_Produto.of_Localiza_Produto(This.GetText())
		
		If Not io_Produto.Localizado Then
			io_Produto.of_Inicializa()
		End If
		
		This.Object.Cd_Produto	[1]	= io_Produto.Cd_Produto
		This.Object.De_Produto	[1]	= io_Produto.ivs_Descricao_Apresentacao_Estoque
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge407_divergencia_cadastro_produto_dis
integer y = 444
integer width = 5362
integer height = 1864
string dataobject = "dw_ge407_lista"
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
	dw_2.Sort()
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long ll_Produto

String ls_Distribuidora
String ls_Uf
String ls_Id_Sit_Clamed
String ls_Id_Sit_Dist
String ls_id_tipo

dw_1.AcceptText()

ls_Distribuidora	= dw_1.Object.Cd_Distribuidora	[1]
ls_Uf					= dw_1.Object.Cd_Uf					[1]
ls_Id_Sit_Clamed	= dw_1.Object.Id_Sit_Clamed		[1]
ls_Id_Sit_Dist		= dw_1.Object.Id_Sit_Dist			[1]
ll_Produto			= dw_1.Object.Cd_Produto			[1]
ls_id_tipo        = dw_1.Object.id_tipo				[1]

If ls_Distribuidora <> '000000000' Then
	This.of_AppendWhere_subquery("a.cd_distribuidora = '" + ls_Distribuidora + "'", 1)
	This.of_AppendWhere_subquery("a.cd_distribuidora = '" + ls_Distribuidora + "'", 2)
End If

If ls_Uf <> 'T' Then
	This.of_AppendWhere_subquery("a.cd_unidade_federacao = '" + ls_Uf + "'", 1)
	This.of_AppendWhere_subquery("a.cd_unidade_federacao = '" + ls_Uf + "'", 2)
End If

If ls_Id_Sit_Clamed <> 'T' Then
	This.of_AppendWhere_subquery("x.id_situacao = '" + ls_Id_Sit_Clamed + "'", 1)
	This.of_AppendWhere_subquery("x.id_situacao = '" + ls_Id_Sit_Clamed + "'", 2)
End If

If ls_Id_Sit_Dist <> 'T' Then
	This.of_AppendWhere_subquery("a.id_situacao = '" + ls_Id_Sit_Dist + "'", 1)
	This.of_AppendWhere_subquery("a.id_situacao = '" + ls_Id_Sit_Dist + "'", 2)
End If

If Not IsNull(ll_Produto) And ll_Produto > 0 Then
	This.of_AppendWhere_subquery("a.cd_produto = " + String(ll_Produto), 1)
	This.of_AppendWhere_subquery("a.cd_produto = " + String(ll_Produto), 2)
End If

if ls_id_tipo <> 'T' then
	if ls_id_tipo = 'P' then
		This.of_AppendWhere_subquery("0=1", 2)
	else
		This.of_AppendWhere_subquery("0=1", 1)
	end if
end if

Return 1
end event

event dw_2::doubleclicked;call super::doubleclicked;If dwo.Name = 'st_pedido_selecionado' Then	
	
	Long ll_Row
	
	String ls_Marcacao
	
	If ivb_Check Then
		ls_Marcacao = 'N'
		ivb_Check = False
	Else
		ls_Marcacao = 'S'
		ivb_Check = True
	End If
	
	For ll_Row = 1 To This.RowCount()				
		This.Object.Id_Selecionado[ll_Row] = ls_Marcacao
	Next	
End If
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge407_divergencia_cadastro_produto_dis
integer x = 4791
integer y = 0
integer width = 549
end type

type cb_1 from commandbutton within w_ge407_divergencia_cadastro_produto_dis
integer x = 3529
integer y = 248
integer width = 667
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Excluir Relacionamento"
end type

event clicked;Boolean lb_Sucesso = False

Long ll_Find
Long ll_Linha
Long ll_Produto
Long ll_Pedidos

String ls_Distribuidora
String ls_Selecionado
String ls_Uf
String ls_Chave
String ls_Nulo
String ls_Erro

dw_2.AcceptText()

Select count(*)
Into :ll_Pedidos
From pedido_filial
Where dh_emissao in (select dh_movimentacao from parametro where id_parametro = '1')
Using Sqlca;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao verificar se j$$HEX1$$e100$$ENDHEX$$ iniciou a gera$$HEX2$$e700e300$$ENDHEX$$o dos pedidos.")
	Return -1
End If

If ll_Pedidos > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel excluir os relacionamentos, pois j$$HEX1$$e100$$ENDHEX$$ iniciou a gera$$HEX2$$e700e300$$ENDHEX$$o dos pedidos.", Exclamation!)
	Return -1
End If

ll_Find = dw_2.Find("id_selecionado = 'S'", 1, dw_2.RowCount())

If (ll_Find = 0) Or (dw_2.RowCount() = 0) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.", Exclamation!)
	Return -1
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a exclus$$HEX1$$e300$$ENDHEX$$o dos produtos divergentes?", Question!, YesNo!, 2) = 2 Then Return -1

SetNull(ls_Nulo)

For ll_Linha = 1 To dw_2.RowCount()
	
	ls_Selecionado = dw_2.Object.Id_Selecionado[ll_Linha]
	
	If ls_Selecionado = "N" Then
		Continue
	Else
		
		ls_Distribuidora	= dw_2.Object.Cd_Distribuidora			[ll_Linha]
		ll_Produto		= dw_2.Object.Cd_Produto					[ll_Linha]
		ls_Uf				= dw_2.Object.Cd_Unidade_Federacao	[ll_Linha]
		
		// se cd_produto = null , significa que a divergencia eh do tipo EAN nao cadastrado, entao pega o cd_produto_ref_ean para excluir o registro da distribuidora_produto
		if isnull(ll_Produto) then ll_Produto = dw_2.Object.cd_produto_ref_ean[ll_Linha]
		
		Delete From distribuidora_produto
		Where cd_distribuidora = :ls_Distribuidora
			And cd_produto = :ll_Produto
			And cd_unidade_federacao = :ls_Uf
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback();
			SqlCa.of_MsgdbError("Erro ao excluir o relacionamento do produto/distribuidora." + SqlCa.SqlErrText)
			Return -1
		End If
		
		ls_Chave = ls_Distribuidora + "@#!" + MidA(String(ll_Produto) + Space(6), 1, 6) + "@#!" + ls_Uf
		
		//A fun$$HEX2$$e700e300$$ENDHEX$$o gf_Grava_Historico_Alteracao_Tabela j$$HEX1$$e100$$ENDHEX$$ faz Rollback(); em caso de erro
		If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_PRODUTO', ls_Chave, 'CD_PRODUTO', MidA(String(ll_Produto) + Space(6), 1, 6), ls_Nulo, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'E', Ref ls_Erro, True) Then
			Return -1
		End If
		
		lb_Sucesso = True
	End If
Next

If lb_Sucesso Then
	SqlCa.of_Commit();
	dw_2.Event ue_Recuperar()
End If

Return 1
end event

type cb_2 from commandbutton within w_ge407_divergencia_cadastro_produto_dis
integer x = 4238
integer y = 248
integer width = 667
integer height = 104
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Hist$$HEX1$$f300$$ENDHEX$$rico de Exclus$$HEX1$$e300$$ENDHEX$$o"
end type

event clicked;Long ll_Produto

String ls_Distribuidora
String ls_Uf
String ls_Parametro

dw_1.AcceptText()
dw_2.AcceptText()

ls_Distribuidora	= dw_1.Object.Cd_Distribuidora	[1]
ll_Produto		= dw_1.Object.Cd_Produto			[1]
ls_Uf				= dw_1.Object.Cd_Uf					[1]

w_ge407_Consulta_Historico lvw

If IsNull(ll_Produto) Then ll_Produto = 0

ls_Parametro = ls_Distribuidora + String(ll_Produto, "000000") + ls_Uf

OpenSheetWithParm( lvw, ls_Parametro, Parent, 0, Original! )
end event

