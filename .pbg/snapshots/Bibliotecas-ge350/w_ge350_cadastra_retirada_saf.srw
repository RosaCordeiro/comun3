HA$PBExportHeader$w_ge350_cadastra_retirada_saf.srw
forward
global type w_ge350_cadastra_retirada_saf from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge350_cadastra_retirada_saf
end type
type cb_1 from commandbutton within w_ge350_cadastra_retirada_saf
end type
type cb_2 from commandbutton within w_ge350_cadastra_retirada_saf
end type
type gb_2 from groupbox within w_ge350_cadastra_retirada_saf
end type
end forward

global type w_ge350_cadastra_retirada_saf from dc_w_response_ok_cancela
integer width = 2757
integer height = 1060
string title = "GE350 - Grava Retirada SAF"
dw_2 dw_2
cb_1 cb_1
cb_2 cb_2
gb_2 gb_2
end type
global w_ge350_cadastra_retirada_saf w_ge350_cadastra_retirada_saf

type variables
uo_filial io_Filial
uo_produto io_Produto

DateTime idh_Inicio
DateTime idh_Termino
end variables

forward prototypes
public subroutine wf_insere_retirada_default ()
public function boolean wf_grava_cabecalho (long al_filial, string as_tipo, ref long al_retirada)
public subroutine wf_prepara_email (long al_filial, long al_retirada, string as_tipo)
public function boolean wf_verifica_retirada_efetuada (long al_filial, long al_nf_dev_venda, long al_produto, string as_lote)
public function boolean wf_valida_lote ()
public function boolean wf_custo_produto (long al_produto, long al_filial, ref decimal adc_custo)
public function boolean wf_grava_item (long al_filial, long al_retirada)
public function boolean wf_grava_lote (long al_filial, long al_retirada)
end prototypes

public subroutine wf_insere_retirada_default ();DataWindowChild lvdwc

Integer lvi_Retorno

If dw_1.GetChild("id_tipo", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "id_tipo", "N")
	lvdwc.SetItem(1, "de_tipo", "NENHUMA")
	
	dw_1.Object.Id_Tipo[1] = "N"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do tipo de retirada.")
End If
end subroutine

public function boolean wf_grava_cabecalho (long al_filial, string as_tipo, ref long al_retirada);DateTime ldh_Nulo

String ls_Nulo
String ls_Erro

dw_1.AcceptText()
dw_2.AcceptText()

Select max(nr_retirada_estoque) + 1
	Into :al_Retirada
From retirada_estoque
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o pr$$HEX1$$f300$$ENDHEX$$ximo sequencial da retirada.~r" + SqlCa.SqlErrText, StopSign!)
	Return False
End If

SetNull(ls_Nulo)
SetNull(ldh_Nulo)

idh_Inicio	= gvo_Parametro.of_Dh_Movimentacao()
idh_Termino= DateTime(RelativeDate(Date(idh_Inicio), 7))

Insert Into retirada_estoque(cd_filial, nr_retirada_estoque, id_tipo_retirada, id_situacao, dh_inclusao, nr_matricula_responsavel, de_observacao, dh_inicio, dh_termino,
									dh_aprovacao, nr_matricula_aprovacao, dh_vencimento_minimo, de_dados_adicionais, de_mensagem_logistica, cd_retirada_estoque_sap)
									
	Values(:al_Filial, :al_Retirada, :as_Tipo, "A", getdate(), :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, :ls_Nulo, :idh_Inicio, :idh_Termino,
									getdate(), :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, :ldh_Nulo, :ls_Nulo, :ls_Nulo, :ldh_Nulo)									
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o cabe$$HEX1$$e700$$ENDHEX$$alho da retirada de estoque.~r" + ls_Erro, StopSign!)
	Return False
End If

Return True
end function

public subroutine wf_prepara_email (long al_filial, long al_retirada, string as_tipo);DateTime ldh_Nulo

String ls_Tipo

dw_1.AcceptText()
dw_2.AcceptText()

SetNull(ldh_Nulo)

str_ge350_lista_email str
gf_ge350_Dados_Email(Ref str, al_Filial, al_Retirada, idh_Inicio, idh_Termino, as_Tipo, ldh_Nulo)
gf_ge350_Envia_Email(str, as_Tipo, True)
end subroutine

public function boolean wf_verifica_retirada_efetuada (long al_filial, long al_nf_dev_venda, long al_produto, string as_lote);Long ll_Retirada

String ls_Erro

Select Top 1 Coalesce(r.nr_retirada_estoque, 0)
	Into :ll_Retirada
From retirada_estoque r
	Inner Join retirada_estoque_produto p
		On p.cd_filial = r.cd_filial	
		And p.nr_retirada_estoque = r.nr_retirada_estoque
	Inner Join retirada_estoque_produto_lote l
		On l.cd_filial = r.cd_filial
		And l.nr_retirada_estoque = r.nr_retirada_estoque
		And l.cd_produto = p.cd_produto
Where r.cd_filial = :al_Filial
	And l.nr_nf_dev_venda = :al_NF_Dev_Venda
	And p.cd_produto = :al_Produto
	And l.nr_lote = :as_Lote
	And r.id_situacao <> 'X'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se o produto '" + String(al_Produto) + "' e lote '" + as_Lote + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e300$$ENDHEX$$o vinvulados a alguma nota de devolu$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
	Return False
End If

If ll_Retirada > 0 Then
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Retirada '" + String(ll_Retirada) + "' est$$HEX1$$e100$$ENDHEX$$ cadastrada para o produto '" + String(al_Produto) + "' e lote '" + as_Lote + ".", Exclamation!)
	Return False
End If

Return True
end function

public function boolean wf_valida_lote ();Long ll_Find

dw_2.AcceptText()

If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi informado.")
	dw_2.SetFocus()
	Return False
End If

//Valida produto
ll_Find = dw_2.Find("cd_produto = 0 Or isnull(cd_produto)", 1, dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find do produto.", StopSign!)
	dw_1.Event ue_Pos(ll_Find, "de_produto")
	Return False
End If

If ll_Find > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o produto.", Exclamation!)
	dw_2.Event ue_Pos(ll_Find, "de_produto")
	Return False
End If

//Valida lote
ll_Find = dw_2.Find("trim(nr_lote) = '' Or isnull(nr_lote)", 1, dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find do lote.", StopSign!)
	dw_1.Event ue_Pos(ll_Find, "nr_lote")
	Return False
End If

If ll_Find > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o lote.", Exclamation!)
	dw_2.Event ue_Pos(ll_Find, "nr_lote")
	Return False
End If

//Validade quantidade
ll_Find = dw_2.Find("qt_lote <= 0 Or isnull(qt_lote)", 1, dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da quantidade.", StopSign!)
	dw_1.Event ue_Pos(ll_Find, "qt_lote")
	Return False
End If

If ll_Find > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a quantidade.", Exclamation!)
	dw_2.Event ue_Pos(ll_Find, "qt_lote")
	Return False
End If

Return True
end function

public function boolean wf_custo_produto (long al_produto, long al_filial, ref decimal adc_custo);Select Coalesce(vl_custo_gerencial, 0.00)
	Into :adc_Custo
From vw_saldo_atual_produto
Where cd_filial = :al_Filial
	And cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//
		
	Case 100
		Select Coalesce(vl_custo_gerencial, 0.00)
			Into :adc_Custo
		From vw_saldo_atual_produto
		Where cd_filial = 534
			And cd_produto = :al_Produto
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				//
				
			Case 100
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o custo do produto '" + String(al_Produto) + "' na filial '" + String(al_Filial) + "' e na Matriz.", Exclamation!)
				Return False
				
			Case -1
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o custo do produto na Matriz. " + SqlCa.SqlErrText, StopSign!)
				Return False
		End Choose
		
	Case -1
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o custo do produto na filial '" + String(al_Filial) + "'. " + SqlCa.SqlErrText, StopSign!)
		Return False
End Choose

Return True
end function

public function boolean wf_grava_item (long al_filial, long al_retirada);Long ll_Linha
Long ll_Produto
Long ll_Qt_Devolvida = 0
Long ll_Tipo_Prd_Fiscal
Long ll_Prd_Ant = 0
Long ll_Qtd
Long ll_Nulo
Long ll_Achou
Long ll_Class_Fiscal

Decimal ldc_Custo

String ls_Erro
String ls_Nulo

dw_1.AcceptText()
dw_2.AcceptText()

Try

	SetNull(ls_Nulo)
	SetNull(ll_Nulo)
	
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge021_tipo_permissao_matriz") Then
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no change da ds 'ds_ge021_tipo_permissao_matriz'.", StopSign!)
		Return False
	End If
	
	For ll_Linha = 1 To dw_2.RowCount()		
			
		ll_Produto 		= dw_2.Object.Cd_Produto					[ll_Linha]		
		ll_Class_Fiscal	= dw_2.Object.Nr_Classificacao_Fiscal	[ll_Linha]
		ll_Qt_Devolvida	= dw_2.Object.Qt_Devolvida				[ll_Linha]
		
//		ll_Qt_Devolvida = dw_2.GetItemNumber(ll_Linha, 'qt_devolvida')
		
		//Controle pra gravar apenas uma vez o item
		If ll_Produto <> ll_Prd_Ant Then
			
			lds.Reset()
		
			If lds.Retrieve(ll_Class_Fiscal, io_Filial.Cd_Unidade_Federacao) < 0 Then
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da ds 'ds_ge021_tipo_permissao_matriz'.", StopSign!)
				Return False
			End If
				
			If lds.RowCount() > 0 Then
				ll_Tipo_Prd_Fiscal = lds.Object.Cd_Tipo_Produto_Fiscal[1]
			End If
			
			If Not wf_Custo_Produto(ll_Produto, al_Filial, Ref ldc_Custo) Then Return False
			
			Insert Into retirada_estoque_produto(cd_filial, nr_retirada_estoque, cd_produto, qt_solicitada, qt_aprovada, vl_custo_medio, de_observacao, cd_tipo_produto_fiscal, id_devolucao_transferencia)									
				Values(:al_Filial, :al_Retirada, :ll_Produto, :ll_Qt_Devolvida, 0, :ldc_Custo, :ls_Nulo, :ll_Tipo_Prd_Fiscal, "T")
			Using SqlCa;
	
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SqlErrText
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar a retirada_estoque_produto do produto '" + String(ll_Produto) + "'.~r" + ls_Erro, StopSign!)
				Return False
			End If
		End If
		
		ll_Prd_Ant = ll_Produto
	Next
	
	Return True
	
Catch (RunTimeError lo_error)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lo_error.GetMessage())
	Return False
	
Finally
	If IsValid(lds) Then Destroy(lds)
End Try
end function

public function boolean wf_grava_lote (long al_filial, long al_retirada);Long ll_Linha
Long ll_Produto
Long ll_Qtd
Long ll_Nulo
Long ll_Achou

String ls_Erro
String ls_Nulo
String ls_Lote

dw_1.AcceptText()
dw_2.AcceptText()

Try

	SetNull(ls_Nulo)
	SetNull(ll_Nulo)
	
	For ll_Linha = 1 To dw_2.RowCount()		
			
		ll_Produto	= dw_2.Object.Cd_Produto	[ll_Linha]
		ls_Lote		= dw_2.Object.Nr_Lote		[ll_Linha]
		ll_Qtd			= dw_2.Object.Qt_Lote		[ll_Linha]
		
		Select Count(*)
			Into :ll_Achou
		From retirada_estoque_produto_lote
		Where cd_filial = :al_Filial
			And nr_retirada_estoque = :al_Retirada
			And cd_produto = :ll_Produto
			And nr_lote = :ls_Lote
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_Rollback();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se o lote lote '" + ls_Lote + "' foi informado para o produto '" + String(ll_Produto) + "'.")
			Return False
		End If
		
		If ll_Achou > 0 Then
			SqlCa.of_Rollback();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Lote '" + ls_Lote + "' j$$HEX1$$e100$$ENDHEX$$ foi informado para o produto '" + String(ll_Produto) + "'.", Exclamation!)
			Return False
		End If
		
		//Grava o lote
		Insert Into retirada_estoque_produto_lote(cd_filial, nr_retirada_estoque, cd_produto, nr_lote, qt_lote, qt_aprovada, nr_nf, id_tipo_avaria)
			Values(:al_Filial, :al_Retirada, :ll_Produto, :ls_Lote, :ll_Qtd, :ll_Qtd, :ll_Qtd, :ls_Nulo)
		Using SqlCa;
		
		If SqlCa.SqlCode = - 1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_Rollback();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar a retirada_estoque_produto_lote do produto '" + String(ll_Produto) + "' e lote '" + ls_Lote + "'.~r" + ls_Erro, StopSign!)
			Return False
		End If		
	Next
	
	SqlCa.of_Commit();
	
	Return True
	
Catch (RunTimeError lo_error)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lo_error.GetMessage())
	Return False
	
Finally
	
End Try
end function

on w_ge350_cadastra_retirada_saf.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.gb_2
end on

on w_ge350_cadastra_retirada_saf.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.gb_2)
end on

event ue_postopen;call super::ue_postopen;wf_Insere_Retirada_Default()
end event

event close;call super::close;If IsValid(io_Filial) Then Destroy(io_Filial)
If IsValid(io_Produto) Then Destroy(io_Produto)
end event

event ue_preopen;call super::ue_preopen;io_Filial = Create uo_filial
io_Produto = Create uo_produto
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge350_cadastra_retirada_saf
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge350_cadastra_retirada_saf
integer y = 12
integer width = 1618
integer height = 256
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge350_cadastra_retirada_saf
integer y = 76
integer width = 1554
integer height = 156
string dataobject = "dw_ge350_selecao_retirada_saf"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	Choose Case This.GetColumnName()
		Case "nm_fantasia"
		
			io_Filial.of_Localiza_Filial(This.GetText())
			
			If io_Filial.Localizada Then
				This.Object.cd_filial			[1] = io_Filial.cd_filial
				This.Object.nm_fantasia		[1] = io_Filial.nm_fantasia
			Else
				io_Filial.of_Inicializa()
			End If
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;dw_1.AcceptText()

Choose Case dwo.Name
	Case "nm_fantasia"
		If Not IsNull(Data) and Trim(Data) <> '' Then
			If Data <> io_Filial.nm_fantasia Then
				Return 1
			End If
		Else
			io_Filial.of_Inicializa()
			
			This.Object.cd_filial		[1] = io_Filial.cd_filial
			This.Object.nm_fantasia	[1] = io_Filial.nm_fantasia
		End If
		
	Case "id_tipo"
		Choose Case Data
			Case "F"
				dw_1.Object.Detalhe_t.Text = "COM PRODUTO"
				
			Case "S"
				dw_1.Object.Detalhe_t.Text = "SEM PRODUTO"
				
			Case Else				
				dw_1.Object.Detalhe_t.Text = ""
				
		End Choose
End Choose
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge350_cadastra_retirada_saf
integer x = 1925
integer y = 860
string text = "&Gravar"
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Long ll_Retirada

String ls_Tipo

dw_1.AcceptText()
dw_2.AcceptText()

If IsNull(dw_1.Object.Cd_Filial[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial.")
	dw_1.Event ue_Pos(1, "nm_fantasia")
	Return -1
End If

If dw_1.Object.Id_Tipo[1] = "N" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o tipo de retirada.")
	dw_1.Event ue_Pos(1, "id_tipo")
	Return -1
End If

If Not wf_Valida_Lote() Then Return -1

If dw_1.Object.Id_Tipo[1] = "F" Then
	ls_Tipo = "TRANSFER$$HEX1$$ca00$$ENDHEX$$NCIA SAF"
Else
	ls_Tipo = "AUTORIZADO SAF"
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a inclus$$HEX1$$e300$$ENDHEX$$o da Retirada de Estoque do tipo '" + ls_Tipo + "' ?", Question!, YesNo!, 2) = 2 Then Return -1

dw_2.Sort()

If Not wf_Grava_Cabecalho(dw_1.Object.Cd_Filial[1], dw_1.Object.Id_Tipo[1], Ref ll_Retirada) Then Return -1

If Not wf_Grava_Item(dw_1.Object.Cd_Filial[1], ll_Retirada) Then Return -1

If Not wf_Grava_Lote(dw_1.Object.Cd_Filial[1], ll_Retirada) Then Return -1

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Retirada '" + String(ll_Retirada) + "' gravada com sucesso.")

wf_Prepara_Email(dw_1.Object.Cd_Filial[1], ll_Retirada, dw_1.Object.Id_Tipo[1])

dw_1.Event ue_Reset()
dw_2.Event ue_Reset()
dw_1.Event ue_AddRow()
dw_1.RowCount()
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge350_cadastra_retirada_saf
integer x = 2258
integer y = 860
end type

type dw_2 from dc_uo_dw_base within w_ge350_cadastra_retirada_saf
integer x = 55
integer y = 356
integer width = 2592
integer height = 464
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge350_lista_retirada_saf"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	Choose Case This.GetColumnName()
		Case "de_produto"
		
			io_Produto.of_Localiza_Produto(This.GetText())
			
			If IsNull(io_Produto.Cd_Grupo_Psico) Or io_Produto.Cd_Grupo_Psico = "" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto selecionado n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ controlado.", Exclamation!)
				Return -1
			End If
			
			If io_Produto.Localizado Then
				This.Object.Cd_Produto					[This.GetRow()] = io_Produto.Cd_Produto
				This.Object.De_Produto					[This.GetRow()] = io_Produto.De_Produto + " : " + io_Produto.De_Apresentacao_Venda
				This.Object.Nr_Classificacao_Fiscal	[This.GetRow()] = io_Produto.Nr_Classificacao_Fiscal
			Else
				io_Produto.of_Inicializa()
			End If
	End Choose
End If
end event

event itemchanged;call super::itemchanged;dw_2.AcceptText()

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> '' Then
			If Data <> io_Produto.De_Produto Then
				Return 1
			End If
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
			This.Object.De_Produto	[1] = io_Produto.De_Produto
		End If
End Choose
end event

event ue_preinsertrow;call super::ue_preinsertrow;If This.RowCount() > 0 Then
	If IsNull(This.Object.Cd_Produto[This.RowCount()]) Then Return -1
End If

Return 1
end event

type cb_1 from commandbutton within w_ge350_cadastra_retirada_saf
integer x = 23
integer y = 860
integer width = 402
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Inserir Linha"
end type

event clicked;dw_2.Event ue_AddRow()
end event

type cb_2 from commandbutton within w_ge350_cadastra_retirada_saf
integer x = 471
integer y = 860
integer width = 448
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Remover Linha"
end type

event clicked;dw_2.Event ue_DeleteRow()
end event

type gb_2 from groupbox within w_ge350_cadastra_retirada_saf
integer x = 23
integer y = 284
integer width = 2670
integer height = 556
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

