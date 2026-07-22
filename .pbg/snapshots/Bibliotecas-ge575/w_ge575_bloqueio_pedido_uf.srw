HA$PBExportHeader$w_ge575_bloqueio_pedido_uf.srw
forward
global type w_ge575_bloqueio_pedido_uf from dc_w_cadastro_selecao_lista
end type
type cb_marcartodos from commandbutton within w_ge575_bloqueio_pedido_uf
end type
type cb_incluir from commandbutton within w_ge575_bloqueio_pedido_uf
end type
type cb_excluir_antigos from commandbutton within w_ge575_bloqueio_pedido_uf
end type
end forward

global type w_ge575_bloqueio_pedido_uf from dc_w_cadastro_selecao_lista
integer width = 3118
integer height = 2072
string title = "GE575 - Bloqueio de Pedidos para Distribuidoras por UF e Per$$HEX1$$ed00$$ENDHEX$$odo"
boolean resizable = false
cb_marcartodos cb_marcartodos
cb_incluir cb_incluir
cb_excluir_antigos cb_excluir_antigos
end type
global w_ge575_bloqueio_pedido_uf w_ge575_bloqueio_pedido_uf

type variables
uo_ge575_Bloqueio_Pedido_UF ivo_GE575
String ivs_TituloMSG = "Aten$$HEX2$$e700e300$$ENDHEX$$o"
end variables

forward prototypes
public subroutine wf_marcar_todos (string as_marcar)
public subroutine wf_incluir_bloqueio ()
end prototypes

public subroutine wf_marcar_todos (string as_marcar);Long lvl_For

For lvl_For = 1 To dw_2.RowCount()
	dw_2.SetItem(lvl_For, 'id_excluir', as_Marcar)
	dw_2.Post SetItemStatus(lvl_For, 'id_excluir', Primary!, NotModified!) // N$$HEX1$$e300$$ENDHEX$$o considerar DW modificada para este campo.
Next

If as_Marcar = 'S' Then
	cb_MarcarTodos.Text = '&Desmarcar Todos'
	cb_MarcarTodos.Tag = 'N'
Else
	cb_MarcarTodos.Text = '&Marcar Todos'
	cb_MarcarTodos.Tag = 'S'
End If

dw_2.AcceptText()
dw_2.SetFocus()
end subroutine

public subroutine wf_incluir_bloqueio ();String lvs_Distribuidora
Int lvi_RetMsg

// Salvar antes de incluir outra.
lvi_RetMsg = wf_Valida_Salva()
Choose Case lvi_RetMsg
	Case OK_SUCESSO_UPDATE, OK_SEM_PENDENCIAS
		// Vai abrir a tela de inclus$$HEX1$$e300$$ENDHEX$$o.
	Case OK_SEM_UPDATE, OK_COM_PENDENCIAS // N$$HEX1$$e300$$ENDHEX$$o quer salvar, ent$$HEX1$$e300$$ENDHEX$$o limpar.
		dw_2.Event ue_Cancel()
	Case CANCELAR_UPDATE, CANCELAR_ERRO_PENDENCIAS
		Return
End Choose

// Abrir a tela de inclus$$HEX1$$e300$$ENDHEX$$o enviando a distribuidora selecionada.
lvs_Distribuidora = dw_1.GetItemString(dw_1.GetRow(), 'cd_distribuidora')
If ivo_GE575.of_Incluir_Bloqueio(ref dw_2, ref lvs_Distribuidora) Then
	If ivo_GE575.ivs_Msg <> '' Then
		MessageBox(ivs_TituloMSG, ivo_GE575.ivs_Msg)
	Else
		MessageBox(ivs_TituloMSG, "Bloqueio(s) inclu$$HEX1$$ed00$$ENDHEX$$do(s) com sucesso!")
	End If
	dw_1.SetItem(dw_1.GetRow(), 'cd_distribuidora', lvs_Distribuidora)
	dw_2.Event ue_Retrieve()
ElseIf Len(ivo_GE575.ivs_Msg) > 0 Then
	MessageBox(ivs_TituloMSG, ivo_GE575.ivs_Msg, StopSign!)
End If

dw_2.SetFocus()
end subroutine

on w_ge575_bloqueio_pedido_uf.create
int iCurrent
call super::create
this.cb_marcartodos=create cb_marcartodos
this.cb_incluir=create cb_incluir
this.cb_excluir_antigos=create cb_excluir_antigos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_marcartodos
this.Control[iCurrent+2]=this.cb_incluir
this.Control[iCurrent+3]=this.cb_excluir_antigos
end on

on w_ge575_bloqueio_pedido_uf.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_marcartodos)
destroy(this.cb_incluir)
destroy(this.cb_excluir_antigos)
end on

event open;call super::open;ivo_GE575 = Create uo_ge575_Bloqueio_Pedido_UF
end event

event close;call super::close;Destroy ivo_GE575
end event

event ue_postopen;call super::ue_postopen;ivm_Menu.mf_Incluir(False)

If Not ivo_GE575.of_Inserir_Distribuidora_Default(dw_1) Then
	MessageBox(ivs_TituloMSG, ivo_GE575.ivs_Msg, StopSign!)
End If

dw_1.of_Populate_dddw('cd_uf')
dw_2.Event ue_Retrieve()
end event

event ue_presave;call super::ue_presave;// Valida$$HEX2$$e700e300$$ENDHEX$$o do per$$HEX1$$ed00$$ENDHEX$$odo informado para bloqueio.
If Not ivo_GE575.of_Validar_Periodo(dw_2) Then
	MessageBox(ivs_TituloMSG, ivo_GE575.ivs_Msg, Exclamation!)
	dw_2.Event ue_Pos(ivo_GE575.ivl_Row_Set, ivo_GE575.ivs_SetColumn)
	dw_2.SetFocus()
	Return False
End If

Return True
end event

event ue_preupdate;call super::ue_preupdate;Return ivo_GE575.of_Gravar_Historico_Alteracao(dw_2)
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge575_bloqueio_pedido_uf
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge575_bloqueio_pedido_uf
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge575_bloqueio_pedido_uf
integer x = 69
integer y = 72
integer width = 2990
integer height = 164
string dataobject = "dw_ge575_selecao"
boolean ivb_ddw_multiselecao = true
string ivs_ddw_multiselecao_coluna = "cd_uf"
end type

event dw_1::itemchanged;call super::itemchanged;Int lvi_Update

If dw_2.RowCount() > 0 Or dw_2.FilteredCount() > 0 Then
	// Com modifica$$HEX2$$e700f500$$ENDHEX$$es, perguntar se deseja gravar antes... Depois limpar lista.
	lvi_Update = wf_Valida_Salva()
	// Limpar quando: N$$HEX1$$e300$$ENDHEX$$o tiver pend$$HEX1$$ea00$$ENDHEX$$ncias; Gravar com sucesso; N$$HEX1$$e300$$ENDHEX$$o quiser gravar.
	If (lvi_Update = OK_SEM_PENDENCIAS Or lvi_Update = OK_SUCESSO_UPDATE Or lvi_Update = OK_SEM_UPDATE) Then
		dw_2.Event ue_Cancel()
	// Se cancelar a mensagem, n$$HEX1$$e300$$ENDHEX$$o aceitar o novo filtro.
	ElseIf lvi_Update = CANCELAR_UPDATE Then
		This.SetItem(row, dwo.Name, String(dwo.Primary[row]))
		Return 2
	End If
End If
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::ue_populate_dddw;call super::ue_populate_dddw;pdwc_dddw.SetTransObject(SQLCA)
pdwc_dddw.Retrieve('000000000') // Todas
pdwc_dddw.SetRow(1)
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge575_bloqueio_pedido_uf
integer y = 284
integer width = 3040
integer height = 1492
string text = "Bloqueios cadastrados"
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge575_bloqueio_pedido_uf
integer width = 3040
integer height = 256
string text = "Consultar bloqueios"
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge575_bloqueio_pedido_uf
integer x = 64
integer y = 368
integer width = 2990
integer height = 1364
string dataobject = "dw_ge575_lista_bloqueios"
boolean ivb_updateable = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Where

This.SetRedraw(False)
This.Post SetRedraw(True)

// Valida$$HEX2$$e700e300$$ENDHEX$$o para consulta.
If Not ivo_GE575.of_Validar_Filtros_Consulta(dw_1) Then
	MessageBox(ivs_TituloMSG, ivo_GE575.ivs_Msg, Exclamation!)
	dw_1.SetColumn(ivo_GE575.ivs_SetColumn)
	Return -1
End If

lvs_Where = ivo_GE575.of_Get_Where_Consulta(dw_1)

If lvs_Where <> '' Then
	This.of_ChangeSQL(This.ivs_SQL_Original + lvs_Where)
End If

This.SetFilter('')

Return 1
end event

event dw_2::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case 'dh_termino_bloqueio'
		// Em branco ou menor que inicial
		If  IsNull(DateTime(data)) Or DateTime(data) < This.GetItemDateTime(row, 'dh_inicio_bloqueio') Then
			MessageBox(ivs_TituloMSG, 'A data de t$$HEX1$$e900$$ENDHEX$$rmino do bloqueio deve ser igual ou posterior $$HEX1$$e000$$ENDHEX$$ data de in$$HEX1$$ed00$$ENDHEX$$cio!~rFavor verificar!', Exclamation!)
			Return 1
		// Menor que hoje
		ElseIf DateTime(data) < gvo_Parametro.dh_Movimentacao Then
			MessageBox(ivs_TituloMSG, 'A data de t$$HEX1$$e900$$ENDHEX$$rmino do bloqueio deve ser igual ou posterior $$HEX1$$e000$$ENDHEX$$ data atual!~rFavor verificar!', Exclamation!)
			Return 1
		End If
		// Reatribuir id_vigente
		This.SetItem(row, 'id_vigente', ivo_GE575.of_Vigente(This.GetItemDateTime(row, 'dh_inicio_bloqueio'), DateTime(data)))
	Case 'id_excluir'
		ivm_Menu.mf_Excluir(True)
		This.Post SetItemStatus(row, 'id_excluir', Primary!, NotModified!) // N$$HEX1$$e300$$ENDHEX$$o considerar modifica$$HEX2$$e700e300$$ENDHEX$$o neste campo
End Choose
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If dw_1.GetItemString(dw_1.GetRow(), 'id_bloqueio_vigente') = 'S' And This.RowCount() > 0 Then
	This.SetFilter("id_vigente = 'S'")
	This.Filter()
	If This.RowCount() = 0 Then 
		MessageBox(ivs_TituloMsg, 'Nenhum bloqueio vigente para essa consulta!')
		Return 0
	End If
	This.GroupCalc()
End If

ivm_Menu.mf_Excluir(False)
ivm_Menu.mf_Alterar(False)
cb_Excluir_Antigos.Enabled = True
cb_MarcarTodos.Enabled = True

Return This.RowCount()
end event

event dw_2::ue_deleterow;// N$$HEX1$$e300$$ENDHEX$$o selecionou
If This.Find("id_excluir = 'S'", 1, This.RowCount()) = 0 Then
	MessageBox(ivs_TituloMSG, "Selecione o(s) bloqueio(s) que deseja excluir!", Exclamation!)
	Return False
End If

// Confirma$$HEX2$$e700e300$$ENDHEX$$o
If MessageBox(ivs_TituloMSG, "Confirma exclus$$HEX1$$e300$$ENDHEX$$o dos bloqueios selecionados?", Question!, YesNo!, 2) = 2 Then
	Return False
End If

// Excluir os selecionados
If Not ivo_GE575.of_Excluir_Bloqueios(This, False) Then
	MessageBox(ivs_TituloMSG, ivo_GE575.ivs_Msg, StopSign!)
	Return False
End If

MessageBox(ivs_TituloMSG, "Bloqueio(s) exclu$$HEX1$$ed00$$ENDHEX$$do(s) com sucesso!")
Return True
end event

event dw_2::ue_cancel;call super::ue_cancel;cb_Excluir_Antigos.Enabled = False
cb_MarcarTodos.Enabled = False
wf_Marcar_Todos('N')
end event

type cb_marcartodos from commandbutton within w_ge575_bloqueio_pedido_uf
string tag = "S"
integer x = 2597
integer y = 1792
integer width = 480
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Marcar Todos"
end type

event clicked;wf_Marcar_Todos(This.Tag)
end event

type cb_incluir from commandbutton within w_ge575_bloqueio_pedido_uf
integer x = 2085
integer y = 1792
integer width = 480
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Incluir Bloqueio"
end type

event clicked;wf_Incluir_Bloqueio()
end event

type cb_excluir_antigos from commandbutton within w_ge575_bloqueio_pedido_uf
integer x = 37
integer y = 1792
integer width = 480
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Excluir Antigos"
end type

event clicked;// Se existe algum antigo...
If dw_2.Find("dh_termino_bloqueio < DateTime('" + String(gvo_Parametro.dh_Movimentacao, 'dd/mm/yyyy')+"')", 1, dw_2.RowCount()) > 0 Then
	If MessageBox(ivs_TituloMSG, "Confirma exclus$$HEX1$$e300$$ENDHEX$$o dos bloqueios antigos?", Question!, YesNo!, 2) = 2 Then Return
	If Not ivo_GE575.of_Excluir_Bloqueios(Ref dw_2, True) Then
		MessageBox(ivs_TituloMSG, ivo_GE575.ivs_Msg, StopSign!)
	End If
	dw_2.SetFocus()
	MessageBox(ivs_TituloMSG, "Bloqueio(s) exclu$$HEX1$$ed00$$ENDHEX$$do(s) com sucesso!")
Else
	MessageBox(ivs_TituloMSG, "Nenhum bloqueio antigo encontrado para exclus$$HEX1$$e300$$ENDHEX$$o.")
End If
end event

