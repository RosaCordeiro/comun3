HA$PBExportHeader$w_ge525_inclui_altera_lote.srw
forward
global type w_ge525_inclui_altera_lote from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge525_inclui_altera_lote
end type
type cb_1 from commandbutton within w_ge525_inclui_altera_lote
end type
type dw_3 from dc_uo_dw_base within w_ge525_inclui_altera_lote
end type
type cb_2 from commandbutton within w_ge525_inclui_altera_lote
end type
type gb_2 from groupbox within w_ge525_inclui_altera_lote
end type
end forward

global type w_ge525_inclui_altera_lote from dc_w_response_ok_cancela
integer width = 2318
integer height = 888
string title = "GE525 - Incluir/Alterar Lote"
dw_2 dw_2
cb_1 cb_1
dw_3 dw_3
cb_2 cb_2
gb_2 gb_2
end type
global w_ge525_inclui_altera_lote w_ge525_inclui_altera_lote

type variables
str_ge525_parametro st

Boolean ib_Alteracao = False
end variables

forward prototypes
public function boolean wf_grava_lote ()
public function boolean wf_verifica_exclusao_lote ()
public function long wf_carrega_distribuidora ()
end prototypes

public function boolean wf_grava_lote ();Long ll_Linha
Long ll_Produto
Long ll_Find
Long ll_Achou

String ls_Distribuidora
String ls_Lote
String ls_Erro

dw_1.AcceptText()
dw_2.AcceptText()

For ll_Linha = 1 To dw_2.RowCount()
	ls_Distribuidora	= dw_2.Object.Cd_Distribuidora	[ll_Linha]
	ls_Lote			= dw_2.Object.Nr_Lote				[ll_Linha]
	
	ll_Find = dw_3.Find("cd_distribuidora = '" + ls_Distribuidora + "' and nr_lote = '" + ls_Lote + "'", 1, dw_3.RowCount())
		
	If ll_Find < 0 Then
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_3.", StopSign!)
		Return False
	End If
	
	//Se n$$HEX1$$e300$$ENDHEX$$o encontrou registro na dw_4 $$HEX1$$e900$$ENDHEX$$ porque foi adicionado um novo registro na dw_2 e ir$$HEX1$$e100$$ENDHEX$$ fazer o insert
	If ll_Find = 0 Then		
			
		Insert Into distribuidora_acordo_validade(cd_distribuidora, cd_produto, nr_lote, dh_inclusao, nr_matricula)
				Values(:ls_Distribuidora, :st.Cd_Produto, :ls_Lote, getdate(), :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula)
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_Rollback();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao inserir o lote [" + ls_Lote + "] do produto [" + String(st.Cd_Produto) + "] e distribuidora [" + ls_Distribuidora + "].~r" + ls_Erro, StopSign!)
			Return False
		End If
		
		ib_Alteracao = True
		
		If Not gf_ge525_Revisao_Desconto_Preste(st.Cd_Produto, false) Then Return False
		
		
	End If
Next
end function

public function boolean wf_verifica_exclusao_lote ();Long ll_Linha
Long ll_Find

String ls_Distribuidora
String ls_Lote
String ls_Erro

dw_2.AcceptText()

For ll_Linha = 1 To dw_3.RowCount()
	ls_Distribuidora	= dw_3.Object.Cd_Distribuidora	[ll_Linha]
	ls_Lote			= dw_3.Object.Nr_Lote				[ll_Linha]
	
	ll_Find = 0
	
	If dw_2.RowCount() > 0 Then
		ll_Find = dw_2.Find("cd_distribuidora = '" + ls_Distribuidora + "' and nr_lote = '" + ls_Lote + "'", 1, dw_2.RowCount())
		
		If ll_Find < 0 Then
			SqlCa.of_Rollback();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_2.", StopSign!)
			Return False
		End If
	End If
	
	If ll_Find = 0 Then
		Delete From distribuidora_acordo_validade
		Where cd_distribuidora = :ls_Distribuidora
			And cd_produto = :st.Cd_Produto
			And nr_lote = :ls_Lote
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_Rollback();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o lote [" + ls_Lote + "] do produto [" + String(st.Cd_Produto) + "] e distribuidora [" + ls_Distribuidora + "].~r" + ls_Erro, StopSign!)
			Return False
		End If
		
		ib_Alteracao = True
		
		If Not gf_ge525_Revisao_Desconto_Preste(st.Cd_Produto, false) Then Return False  	
		
	End If
Next

Return True
end function

public function long wf_carrega_distribuidora ();String ls_SQL

DataWindowChild lvdwc

If dw_2.GetChild("cd_distribuidora", lvdwc) = 1 Then

lvdwc.SetTransObject(SQLCA)

	ls_Sql = "SELECT f.cd_fornecedor, f.nm_fantasia " + &
				" FROM fornecedor f " + &
				"	INNER JOIN distribuidora_acordo_devolucao d " + &
				"		ON d.cd_distribuidora = f.cd_fornecedor " + &
				" WHERE d.cd_produto = " + String(st.Cd_Produto) + &
				"	ORDER BY f.nm_fantasia "

	lvdwc.SetSQLSelect(ls_SQL)

	If lvdwc.Retrieve() < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a distribuidora.")
		Return -1
	End If		
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild distribuidora")
	Return -1
End If	
end function

on w_ge525_inclui_altera_lote.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_1=create cb_1
this.dw_3=create dw_3
this.cb_2=create cb_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.gb_2
end on

on w_ge525_inclui_altera_lote.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.cb_2)
destroy(this.gb_2)
end on

event ue_postopen;call super::ue_postopen;st = Message.PowerObjectParm

dw_1.Object.Cd_Produto[1] = st.Cd_Produto
dw_1.Object.De_Produto[1] = st.De_Produto

dw_1.Enabled = False

dw_2.Event ue_Retrieve()
dw_3.Event ue_Retrieve()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge525_inclui_altera_lote
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge525_inclui_altera_lote
integer width = 2245
integer height = 196
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge525_inclui_altera_lote
integer width = 2185
integer height = 104
string dataobject = "dw_ge525_selecao_inclusao_prd"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge525_inclui_altera_lote
integer x = 1010
integer y = 680
string text = "&Gravar"
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Long ll_Find

dw_2.AcceptText()

ll_Find = dw_2.Find("IsNull(cd_distribuidora) or IsNull(nr_lote) or Trim(nr_lote) = '' ", 1, dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_2.", StopSign!)
	dw_2.SetFocus()
	Return -1
End If

If ll_Find > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o pode haver registro em branco.")
	dw_2.SetFocus()
	Return -1
End If

If Not wf_Grava_Lote() Then Return -1

If Not wf_Verifica_Exclusao_Lote() Then Return -1


SqlCa.of_Commit();

CloseWithReturn(Parent, "OK")
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge525_inclui_altera_lote
integer x = 1344
integer y = 680
end type

type dw_2 from dc_uo_dw_base within w_ge525_inclui_altera_lote
integer x = 55
integer y = 248
integer width = 1678
integer height = 380
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge525_lote_cadastro"
boolean vscrollbar = true
end type

event ue_recuperar;//OverRide

Return This.Retrieve(st.Cd_Produto)
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_preinsertrow;call super::ue_preinsertrow;This.AcceptText()

If This.RowCount() > 0 Then
	If IsNull(This.Object.Cd_Distribuidora[This.RowCount()]) Or IsNull(This.Object.Nr_Lote[This.RowCount()]) Then
		Return -1
	End If
End If

Return 1
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue = 1 Then
	If wf_Carrega_Distribuidora() = -1 Then Return -1
End If

Return AncestorReturnValue
end event

event clicked;call super::clicked;If dwo.Name = "cd_distribuidora" Then	
	If wf_Carrega_Distribuidora() = -1 Then Return -1
End If

Return AncestorReturnValue
end event

event itemfocuschanged;call super::itemfocuschanged;If dwo.Name = "cd_distribuidora" Then
	If wf_Carrega_Distribuidora() = -1 Then Return -1
End If
end event

type cb_1 from commandbutton within w_ge525_inclui_altera_lote
integer x = 1815
integer y = 300
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

type dw_3 from dc_uo_dw_base within w_ge525_inclui_altera_lote
boolean visible = false
integer x = 1746
integer y = 532
integer height = 216
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge525_lote_cadastro"
end type

event ue_recuperar;//OverRide

Return This.Retrieve(st.Cd_Produto)
end event

type cb_2 from commandbutton within w_ge525_inclui_altera_lote
integer x = 1815
integer y = 416
integer width = 402
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Excluir Linha"
end type

event clicked;String ls_operador

Boolean lb_retorno

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE525_INCLUI_ALTERA_LOTE", ref ls_Operador) Then 
	Return -1
End If

lb_retorno = gvo_Aplicacao.ivo_Seguranca.of_Get_Id_Exclusao()

If Not lb_retorno Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o possui permiss$$HEX1$$e300$$ENDHEX$$o para realizar exclus$$HEX1$$e300$$ENDHEX$$o de lote.", Exclamation!)
	Return -1
End If


dw_2.Event ue_DeleteRow()
end event

type gb_2 from groupbox within w_ge525_inclui_altera_lote
integer x = 23
integer y = 212
integer width = 1746
integer height = 444
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

