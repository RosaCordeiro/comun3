HA$PBExportHeader$w_ge407_consulta_historico.srw
forward
global type w_ge407_consulta_historico from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge407_consulta_historico from dc_w_selecao_lista_relatorio
integer width = 4489
integer height = 2456
string title = "GE407 - Hist$$HEX1$$f300$$ENDHEX$$rico de Exclus$$HEX1$$e300$$ENDHEX$$o de Relacionamento de Produto Distribuidora"
end type
global w_ge407_consulta_historico w_ge407_consulta_historico

type variables
uo_produto io_Produto
end variables

forward prototypes
public subroutine wf_insere_distribuidora_default ()
public subroutine wf_insere_uf_default ()
public function boolean wf_preenche_dados ()
public function boolean wf_localiza_distribuidora (string as_distribuidora, ref string as_nome_fantasia)
public function boolean wf_localiza_produto (long al_produto, ref string as_de_produto, ref string as_id_situacao)
public function boolean wf_localiza_responsavel (string as_matricula, ref string as_nome_responsavel)
public subroutine wf_pesquisa ()
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

If dw_1.GetChild("cd_unidade_federacao", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_unidade_federacao", "T")
	lvdwc.SetItem(1, "nm_unidade_federacao", "TODAS")
	
	dw_1.Object.Cd_Unidade_Federacao[1] = "T"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da U.F..")
End If
end subroutine

public function boolean wf_preenche_dados ();Long ll_Linha
Long ll_Produto

String ls_Distribuidora
String ls_Nome_Fantasia
String ls_De_Produto
String ls_Id_Situacao
String ls_Uf
String ls_Matricula
String ls_Nome_Responsavel

dw_2.AcceptText()

For ll_Linha = 1 To dw_2.RowCount()
	
	ls_Distribuidora	= dw_2.Object.Cd_Distribuidora			[ll_Linha]
	ll_Produto		= dw_2.Object.Cd_Produto					[ll_Linha]
	ls_Uf 				= dw_2.Object.Cd_Unidade_Federacao	[ll_Linha]
	ls_Matricula 	= dw_2.Object.Nr_Matric_Alteracao		[ll_Linha]
	
	If Not wf_Localiza_Distribuidora(ls_Distribuidora, Ref ls_Nome_Fantasia) Then Return False
	
	If Not wf_Localiza_Produto(ll_Produto, Ref ls_De_Produto, Ref ls_Id_Situacao) Then Return False
	
	If Not wf_Localiza_Responsavel(ls_Matricula, Ref ls_Nome_Responsavel) Then Return False
	
	dw_2.Object.Nm_Fantasia		[ll_Linha] = ls_Nome_Fantasia
	dw_2.Object.De_Produto			[ll_Linha] = ls_De_Produto
	dw_2.Object.Id_Situacao			[ll_Linha] = ls_Id_Situacao
	dw_2.Object.Nm_Responsavel	[ll_Linha] = ls_Nome_Responsavel
Next

wf_Pesquisa()

Return True
end function

public function boolean wf_localiza_distribuidora (string as_distribuidora, ref string as_nome_fantasia);Select nm_fantasia
	Into :as_Nome_Fantasia
From fornecedor
Where cd_fornecedor = :as_Distribuidora
	And id_distribuidora = 'S'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da distribuidora." + SqlCa.SqlErrText)
	Return False
End If

Return True
end function

public function boolean wf_localiza_produto (long al_produto, ref string as_de_produto, ref string as_id_situacao);Select de_produto + ' : ' + de_apresentacao_estoque, id_situacao
	Into :as_De_Produto, :as_Id_Situacao
From produto_geral
Where cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto." + SqlCa.SqlErrText)
	Return False
End If

Return True
end function

public function boolean wf_localiza_responsavel (string as_matricula, ref string as_nome_responsavel);Select nm_usuario
	Into: as_Nome_Responsavel
From usuario
Where nr_matricula = :as_Matricula
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do respons$$HEX1$$e100$$ENDHEX$$vel." + SqlCa.SqlErrText)
	Return False
End If

Return True
end function

public subroutine wf_pesquisa ();Long ll_Produto

String ls_Sort
String ls_Filter
String ls_Distribuidora
String ls_Uf

dw_1.AcceptText()

ls_Distribuidora	= dw_1.Object.Cd_Distribuidora			[1]
ll_Produto 		= dw_1.Object.Cd_Produto					[1]
ls_Uf				= dw_1.Object.Cd_Unidade_Federacao	[1]

//Todos os filtros selecionados
If (ls_Distribuidora <> "000000000") And (Not IsNull(ll_Produto)) And (ls_Uf <> "T") Then
	ls_Filter = "cd_distribuidora = '" + ls_Distribuidora + "' and cd_produto = " + String(ll_Produto) + " and cd_unidade_federacao = '" + ls_Uf + "'"
End If

//Somente distribuidora
If (ls_Distribuidora <> "000000000") And (IsNull(ll_Produto)) And (ls_Uf = "T") Then
	ls_Filter = "cd_distribuidora = '" + ls_Distribuidora + "'"
End If

//Distribuidora e produto
If (ls_Distribuidora <> "000000000") And (Not IsNull(ll_Produto)) And (ls_Uf = "T") Then
	ls_Filter = "cd_distribuidora = '" + ls_Distribuidora + "' and cd_produto = " + String(ll_Produto)
End If

//Distribuidora e UF
If (ls_Distribuidora <> "000000000") And (IsNull(ll_Produto)) And (ls_Uf <> "T") Then
	ls_Filter = "cd_distribuidora = '" + ls_Distribuidora + "' and cd_unidade_federacao = '" + ls_Uf + "'"
End If

//Somente produto
If (ls_Distribuidora = "000000000") And (Not IsNull(ll_Produto)) And (ls_Uf = "T") Then
	ls_Filter = "cd_produto = " + String(ll_Produto)
End If

//Produto e UF
If (ls_Distribuidora = "000000000") And (Not IsNull(ll_Produto)) And (ls_Uf <> "T") Then
	ls_Filter = "cd_produto = " + String(ll_Produto) + " and cd_unidade_federacao = '" + ls_Uf + "'"
End If

//Somente UF
If (ls_Distribuidora = "000000000") And (IsNull(ll_Produto)) And (ls_Uf <> "T") Then
	ls_Filter = "cd_unidade_federacao = '" + ls_Uf + "'"
End If

ls_Sort = "nm_fantasia, de_produto, cd_unidade_federacao, dh_alteracao desc"

dw_2.SetFilter( ls_Filter )
dw_2.Filter( )
dw_2.SetSort( ls_Sort )
dw_2.Sort( )

dw_2.GroupCalc()
end subroutine

on w_ge407_consulta_historico.create
call super::create
end on

on w_ge407_consulta_historico.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;Long ll_Produto

String ls_Parametro
String ls_Distribuidora
String ls_Uf

wf_Insere_Distribuidora_Default()

wf_Insere_Uf_Default()

dw_1.Object.Dh_Termino	[1] = gvo_Parametro.of_Dh_Movimentacao()
dw_1.Object.Dh_Inicio		[1] = DateTime(RelativeDate(Date(dw_1.Object.Dh_Termino[1]), -1))

ls_Parametro = Message.StringParm

ls_Distribuidora	= MidA(ls_Parametro, 1, 9)
ll_Produto		= Long(MidA(ls_Parametro, 10, 6))
ls_Uf				= MidA(ls_Parametro, 16)

If ls_Distribuidora <> "000000000" Then
	dw_1.Object.Cd_Distribuidora[1] = ls_Distribuidora
End If

If ll_Produto > 0 Then
	dw_1.Object.Cd_Produto[1] = ll_Produto
	
	io_Produto.of_Localiza_Produto(String(ll_Produto))

	dw_1.Object.De_Produto	[1]	= io_Produto.ivs_Descricao_Apresentacao_Estoque
End If

If ls_Uf <> "T" Then
	dw_1.Object.Cd_Unidade_Federacao[1] = ls_Uf
End If

dw_1.SetFocus()
end event

event open;call super::open;io_Produto = Create uo_produto
end event

event close;call super::close;Destroy(io_Produto)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge407_consulta_historico
integer x = 37
integer y = 848
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge407_consulta_historico
integer x = 0
integer y = 776
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge407_consulta_historico
integer y = 456
integer width = 4366
integer height = 1784
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge407_consulta_historico
integer width = 2039
integer height = 436
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge407_consulta_historico
integer width = 1970
integer height = 320
string dataobject = "dw_ge407_selecao_historico"
end type

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

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge407_consulta_historico
integer y = 532
integer width = 4297
integer height = 1680
string dataobject = "dw_ge407_lista_historico"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;DateTime ldh_Inicio
DateTime ldh_Termino

Long ll_Produto

String ls_Distribuidora
String ls_Uf
String ls_Chave

dw_1.AcceptText()

ldh_Inicio		= dw_1.Object.Dh_Inicio						[1]
ldh_Termino	= dw_1.Object.Dh_Termino					[1]	
ls_Distribuidora	= dw_1.Object.Cd_Distribuidora			[1]
ll_Produto		= dw_1.Object.Cd_Produto					[1]
ls_Uf				= dw_1.Object.Cd_Unidade_Federacao	[1]

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

Return 1
end event

event dw_2::ue_recuperar;//OverRide

String ls_Filter
String ls_Sort

SetRedraw(False)

dw_1.AcceptText()

//Limpa o filtro que $$HEX1$$e900$$ENDHEX$$ utilizado no evento ue_postretrieve da dw_2
ls_Filter = ''
ls_Sort = ''
	
dw_2.SetFilter( ls_Filter )
dw_2.Filter( )
dw_2.SetSort( ls_Sort )
dw_2.Sort()
//Fim filtro

Return This.Retrieve(dw_1.Object.Dh_Inicio[1], dw_1.Object.Dh_Termino[1])
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	If Not wf_Preenche_Dados() Then Return -1
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

SetRedraw(True)

Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge407_consulta_historico
integer x = 2176
integer y = 120
end type

