HA$PBExportHeader$w_ge392_aprovacao_autom_ret_est.srw
forward
global type w_ge392_aprovacao_autom_ret_est from dc_w_cadastro_selecao_lista
end type
type dw_3 from dc_uo_dw_base within w_ge392_aprovacao_autom_ret_est
end type
type cb_1 from commandbutton within w_ge392_aprovacao_autom_ret_est
end type
type dw_4 from dc_uo_dw_base within w_ge392_aprovacao_autom_ret_est
end type
type dw_5 from dc_uo_dw_base within w_ge392_aprovacao_autom_ret_est
end type
type st_1 from statictext within w_ge392_aprovacao_autom_ret_est
end type
type st_2 from statictext within w_ge392_aprovacao_autom_ret_est
end type
type gb_3 from groupbox within w_ge392_aprovacao_autom_ret_est
end type
end forward

global type w_ge392_aprovacao_autom_ret_est from dc_w_cadastro_selecao_lista
integer width = 4334
integer height = 2072
string title = "GE392 - Cadastro para Aprova$$HEX2$$e700e300$$ENDHEX$$o Autom$$HEX1$$e100$$ENDHEX$$tica de Retirada de Estoque"
dw_3 dw_3
cb_1 cb_1
dw_4 dw_4
dw_5 dw_5
st_1 st_1
st_2 st_2
gb_3 gb_3
end type
global w_ge392_aprovacao_autom_ret_est w_ge392_aprovacao_autom_ret_est

type variables
uo_produto io_Produto

DateTime idh_Data_Atual

Long il_Linha = 0
end variables

forward prototypes
public subroutine wf_set_somente_consulta ()
public function boolean wf_sequencial_aprov (ref long al_prox_seq)
public function boolean wf_verifica_inclusao_exclusao ()
end prototypes

public subroutine wf_set_somente_consulta ();dw_3.of_Set_Somente_Leitura(False)
end subroutine

public function boolean wf_sequencial_aprov (ref long al_prox_seq);Select coalesce(max(nr_aprovacao), 0)
	Into :al_prox_seq
From aprovacao_retirada_estq
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o n$$HEX1$$fa00$$ENDHEX$$mero da $$HEX1$$fa00$$ENDHEX$$ltima aprova$$HEX2$$e700e300$$ENDHEX$$o. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

al_Prox_Seq++

Return True
end function

public function boolean wf_verifica_inclusao_exclusao ();Long ll_Find = 0
Long ll_Linha
Long ll_Linha_Dw_5
Long ll_Produto
Long ll_Aprov
Long ll_Prox_Aprov

String ls_Erro

dw_2.AcceptText()
dw_4.AcceptText()

//Verifica inclus$$HEX1$$e300$$ENDHEX$$o
For ll_Linha = 1 To dw_2.RowCount()
	ll_Aprov		= dw_2.Object.Nr_Aprovacao	[ll_Linha]
	ll_Produto	= dw_2.Object.Cd_Produto		[ll_Linha]
	
	ll_Find = dw_4.Find("nr_aprovacao = " + String(ll_Aprov) + " and cd_produto = " + String(ll_Produto), 1, dw_4.RowCount())
	
	If ll_Find = 0 Or IsNull(ll_Find) Then
	
		If Not wf_Sequencial_Aprov(Ref ll_Prox_Aprov) Then Return False
		
		dw_2.Object.Nr_Aprovacao					[ll_Linha] = ll_Prox_Aprov
		dw_2.Object.Nr_Matricula_Responsavel	[ll_Linha] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
	End If
Next

ll_Linha = 0
ll_Find = 0

For ll_Linha = 1 To dw_4.RowCount()
	ll_Aprov		= dw_4.Object.Nr_Aprovacao	[ll_Linha]
	ll_Produto	= dw_4.Object.Cd_Produto		[ll_Linha]
	
	ll_Find = dw_2.Find("nr_aprovacao = " + String(ll_Aprov) + " and cd_produto = " + String(ll_Produto), 1, dw_2.RowCount())
	
	If ll_Find = 0 Then //Produto exclu$$HEX1$$ed00$$ENDHEX$$do
		dw_5.Event ue_Reset()
		
		If dw_5.Retrieve(ll_Aprov) < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve.", StopSign!)
			Return False
		End If
		
		ll_Linha_Dw_5 = 0
		
		For ll_Linha_Dw_5 = 1 To dw_5.RowCount()
			
			Delete From aprovacao_retirada_estq_lote
			Where nr_aprovacao = :ll_Aprov
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SqlErrText
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o lote da aprova$$HEX2$$e700e300$$ENDHEX$$o " + String(ll_Aprov) + "'.")
				Return False
			End If
		Next
	End If
Next

Return True
end function

on w_ge392_aprovacao_autom_ret_est.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.cb_1=create cb_1
this.dw_4=create dw_4
this.dw_5=create dw_5
this.st_1=create st_1
this.st_2=create st_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_4
this.Control[iCurrent+4]=this.dw_5
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.gb_3
end on

on w_ge392_aprovacao_autom_ret_est.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.gb_3)
end on

event close;call super::close;Destroy(io_Produto)
end event

event ue_preopen;call super::ue_preopen;io_Produto = Create uo_produto
end event

event ue_postopen;call super::ue_postopen;DateTime ldh_Termino

dc_uo_dw_Base lvo_Dw[]
lvo_Dw = {dw_2}
This.wf_SetUpdate_Dw(lvo_Dw)

idh_Data_Atual = gvo_Parametro.of_Dh_Movimentacao()

ldh_Termino = DateTime(RelativeDate(Date(idh_Data_Atual), -30))

dw_1.Object.Dh_Inicio		[1] = ldh_Termino
dw_1.Object.Dh_Termino	[1] = idh_Data_Atual
end event

event ue_cancel;call super::ue_cancel;SqlCa.of_Rollback();

dw_3.Event ue_Cancel()

dw_1.Enabled = True
end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 Then
	il_Linha = 1
	dw_2.Event ue_Retrieve()
	dw_1.Enabled = True
End If

Return AncestorReturnValue
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge392_aprovacao_autom_ret_est
integer x = 37
integer y = 760
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge392_aprovacao_autom_ret_est
integer x = 0
integer y = 688
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge392_aprovacao_autom_ret_est
integer width = 2039
integer height = 164
string dataobject = "dw_ge392_selecao"
end type

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
dw_3.Event ue_Reset()
dw_4.Event ue_Reset()

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
			
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
			This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
End Choose
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()
dw_3.Event ue_Reset()
dw_4.Event ue_Reset()

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
			
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
			This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
						
			io_Produto.of_Localiza_Produto(This.GetText())
						
			If io_Produto.Localizado Then				
				This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
				This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque				
			Else
				io_Produto.of_Inicializa()
			End If
	End Choose
End If
end event

event dw_1::ue_cancel;//OverRide
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge392_aprovacao_autom_ret_est
integer y = 288
integer width = 4215
integer height = 1028
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge392_aprovacao_autom_ret_est
integer width = 2107
integer height = 272
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge392_aprovacao_autom_ret_est
integer x = 69
integer y = 364
integer width = 4151
integer height = 928
string dataobject = "dw_ge392_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;DateTime ldh_Inicio
DateTime ldh_Termino

Long ll_Produto

String ls_Vigente

dw_1.AcceptText()

ldh_Inicio	= dw_1.Object.Dh_Inicio		[1]
ldh_Termino= dw_1.Object.Dh_Termino	[1]
ll_Produto	= dw_1.Object.Cd_Produto	[1]
ls_Vigente	= dw_1.Object.Id_Vigente	[1]

dw_4.Event ue_Reset()

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
	dw_2.of_AppendWhere("a.cd_produto = " + String(ll_Produto))
End If

If ls_Vigente = "S" Then
	dw_2.of_AppendWhere("a.dh_inicio <= (Select dh_movimentacao From parametro Where id_parametro = '1') And (a.dh_termino >= (Select dh_movimentacao From parametro Where id_parametro = '1') or a.dh_termino is null)")
End If

Return 1
end event

event dw_2::ue_recuperar;//OverRide

dw_1.AcceptText()

Return This.Retrieve(dw_1.Object.Dh_Inicio[1], dw_1.Object.Dh_Termino[1])
end event

event dw_2::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			io_Produto.of_Localiza_Produto(This.GetText())
			
			If io_Produto.Localizado Then															
				This.Object.Cd_Produto	[This.GetRow()] = io_Produto.Cd_Produto
				This.Object.De_Produto	[This.GetRow()] = io_Produto.ivs_Descricao_Apresentacao_Estoque
			Else
				io_Produto.of_Inicializa()
			End If
	End Choose
End If
end event

event dw_2::ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	This.Object.Dh_Inclusao[This.GetRow()] = idh_Data_Atual
End If

Return AncestorReturnValue
end event

event dw_2::ue_preupdate;call super::ue_preupdate;DateTime ldh_Inicio
DateTime ldh_Termino

Long ll_Produto
Long ll_Aprov
Long ll_Prox_Aprov
Long ll_Linha

String ls_ValorPara

This.AcceptText()

For ll_Linha = 1 To This.RowCount()

	ll_Produto		= This.Object.Cd_Produto		[ll_Linha]
	ldh_Inicio		= This.Object.Dh_Inicio			[ll_Linha]
	ldh_Termino	= This.Object.Dh_Termino		[ll_Linha]
	ll_Aprov			= This.Object.Nr_Aprovacao	[ll_Linha]
	
	If IsNull(ll_Produto) Or ll_Produto = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o produto.")
		dw_2.Event ue_Pos(ll_Linha, "cd_produto")
		Return -1
	End If
	
	If IsNull(ldh_Inicio) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
		dw_2.Event ue_Pos(ll_Linha, "dh_inicio")
		Return -1
	End If
	
	If gf_Houve_Alteracao_Dw(This, 'DH_INICIO', ll_Linha, Ref ls_ValorPara) Or IsNull(ll_Aprov) Then
		If ldh_Inicio < idh_Data_Atual Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser menor do que a data atual.")
			dw_2.Event ue_Pos(ll_Linha, "dh_inicio")
			Return -1
		End If		
	End If
		
	If IsNull(ldh_Termino) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
		dw_2.Event ue_Pos(ll_Linha, "dh_termino")
		Return -1
	End If
	
	If gf_Houve_Alteracao_Dw(This, 'DH_Termino', ll_Linha, Ref ls_ValorPara) Or IsNull(ll_Aprov) Then
		If ldh_Termino < idh_Data_Atual Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino n$$HEX1$$e300$$ENDHEX$$o pode ser menor do que a data atual.")
			dw_2.Event ue_Pos(ll_Linha, "dh_termino")
			Return -1 
		End If
	End If
	
	If ldh_Termino < ldh_Inicio Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino n$$HEX1$$e300$$ENDHEX$$o pode ser menor que a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
		dw_2.Event ue_Pos(ll_Linha, "dh_termino")
		Return -1
	End If
Next

If Not wf_Verifica_Inclusao_Exclusao() Then Return -1

Return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	dw_2.Event ue_Pos(il_Linha, "de_produto")
	dw_3.Event ue_Recuperar()
	
	If dw_2.RowsCopy(1, dw_2.RowCount(), Primary!, dw_4, 1, Primary!) = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Rowscopy da dw_4.")
		Return -1
	End If
Else
	dw_4.Event ue_Reset()
End If

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True

ivi_Tipo_Cancelar = RETRIEVE
end event

event dw_2::clicked;call super::clicked;dw_3.Event ue_Retrieve()
dw_2.SetFocus()
end event

event dw_2::ue_deleterow;call super::ue_deleterow;If AncestorReturnValue Then
	dw_3.Event ue_Reset()
End If

Return AncestorReturnValue
end event

event dw_2::editchanged;call super::editchanged;dw_1.Enabled = False

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
			
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[This.GetRow()] = io_Produto.Cd_Produto
			This.Object.De_Produto[This.GetRow()] = io_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
End Choose
end event

event dw_2::itemchanged;call super::itemchanged;dw_1.Enabled = False

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
			
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[This.GetRow()] = io_Produto.Cd_Produto
			This.Object.De_Produto[This.GetRow()] = io_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
End Choose
end event

event dw_2::itemfocuschanged;call super::itemfocuschanged;dw_3.Event ue_Retrieve()
dw_2.SetFocus()
end event

event dw_2::ue_preinsertrow;call super::ue_preinsertrow;If AncestorReturnValue = 1 Then
	If dw_2.RowCount() > 0 Then
		If IsNull(dw_2.Object.Nr_Aprovacao[dw_2.RowCount()]) Then
			Return -1
		End If
	End If
End If

Return AncestorReturnValue
end event

type dw_3 from dc_uo_dw_base within w_ge392_aprovacao_autom_ret_est
integer x = 73
integer y = 1372
integer width = 773
integer height = 460
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge392_lote"
boolean vscrollbar = true
end type

event ue_recuperar;//OverRide

dw_2.AcceptText()

If dw_2.RowCount() = 0 Then Return 0

Return This.Retrieve(dw_2.Object.Nr_Aprovacao[dw_2.GetRow()])
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_deleterow;//OverRide

Return True
end event

type cb_1 from commandbutton within w_ge392_aprovacao_autom_ret_est
integer x = 2181
integer y = 164
integer width = 745
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Incluir/Alterar/Excluir Lote"
end type

event clicked;Long ll_Linha

String ls_Retorno



If ivb_Valida_Salva Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem altera$$HEX2$$e700f500$$ENDHEX$$es pendentes. ~rSalva antes de prosseguir.", Exclamation!)
	Return -1
End If

If dw_2.RowCount() = 0 Then Return 0

If IsNull(dw_2.Object.Nr_Aprovacao[dw_2.GetRow()]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Salve a aprova$$HEX2$$e700e300$$ENDHEX$$o antes de prosseguir.")
	Return -1
End If

il_Linha = dw_2.GetRow()

OpenWithParm(w_ge392_grava_lote, String(dw_2.Object.Nr_Aprovacao[dw_2.GetRow()]))

ls_Retorno = Message.StringParm

If ls_Retorno = "OK" Then
	dw_2.Event ue_Retrieve()
End If
end event

type dw_4 from dc_uo_dw_base within w_ge392_aprovacao_autom_ret_est
boolean visible = false
integer x = 2633
integer y = 1400
integer width = 658
integer height = 328
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge392_lista_original"
end type

type dw_5 from dc_uo_dw_base within w_ge392_aprovacao_autom_ret_est
boolean visible = false
integer x = 1975
integer y = 1392
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge392_lote_original"
end type

type st_1 from statictext within w_ge392_aprovacao_autom_ret_est
integer x = 901
integer y = 1452
integer width = 695
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "Somente visualiza$$HEX2$$e700e300$$ENDHEX$$o"
boolean focusrectangle = false
end type

type st_2 from statictext within w_ge392_aprovacao_autom_ret_est
integer x = 2181
integer y = 40
integer width = 1614
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "Cadastro somente para retirada do tipo Recolhimento"
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_ge392_aprovacao_autom_ret_est
integer x = 37
integer y = 1320
integer width = 841
integer height = 540
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
end type

