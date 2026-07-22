HA$PBExportHeader$w_ge030_altera_adiciona_lote.srw
forward
global type w_ge030_altera_adiciona_lote from dc_w_base
end type
type cb_excluir_lote from commandbutton within w_ge030_altera_adiciona_lote
end type
type dw_2 from dc_uo_dw_base within w_ge030_altera_adiciona_lote
end type
type cb_adicionar_lote from commandbutton within w_ge030_altera_adiciona_lote
end type
type dw_1 from dc_uo_dw_base within w_ge030_altera_adiciona_lote
end type
type cb_salvar from commandbutton within w_ge030_altera_adiciona_lote
end type
type cb_sair from commandbutton within w_ge030_altera_adiciona_lote
end type
type gb_1 from groupbox within w_ge030_altera_adiciona_lote
end type
type gb_2 from groupbox within w_ge030_altera_adiciona_lote
end type
end forward

global type w_ge030_altera_adiciona_lote from dc_w_base
integer width = 2976
integer height = 1116
string title = "GE030 - Alterar Lote"
boolean controlmenu = false
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
cb_excluir_lote cb_excluir_lote
dw_2 dw_2
cb_adicionar_lote cb_adicionar_lote
dw_1 dw_1
cb_salvar cb_salvar
cb_sair cb_sair
gb_1 gb_1
gb_2 gb_2
end type
global w_ge030_altera_adiciona_lote w_ge030_altera_adiciona_lote

type variables
String 	is_Endereco,&
			is_Lote,&
			is_Agrupamento
			
Long 	il_Produto,&
		il_Agrupamento, &
		il_Qt_Caixa_Pad, &
		il_Sequencial,&
		il_Saldo_Endereco

DateTime idh_Validade

st_ge030_parametros_alt_lote	ist_Parametro
end variables

forward prototypes
public subroutine wf_confere_total ()
public function boolean wf_grava_historico (string as_lote_ant, string as_lote_atu, string as_qtde_ant, string as_qtde_atu, string as_dhvl_ant, string as_dhvl_atu, string as_dhfb_ant, string as_dhfb_atu, string as_acao, ref string as_erro)
public function boolean wf_registra_exclusao ()
public function boolean wf_registra_inclusao_alteracao ()
public function boolean wf_grava_historico (string as_lote_ant, string as_lote_atu, string as_qtde_ant, string as_qtde_atu, string as_dhvl_ant, string as_dhvl_atu, string as_dhfb_ant, string as_dhfb_atu, string as_qtdv_ant, string as_qtrs_ant, string as_qtav_ant, string as_qtfa_ant, string as_acao, ref string as_erro)
end prototypes

public subroutine wf_confere_total ();Choose case True
		
	case dw_2.Object.cf_qt_lote [1] = dw_1.Object.qt_faturada [1]	//ist_Parametro.qt_lote
		dw_2.Object.t_situacao.Text  = 'Quantidade correta!'
		dw_2.Object.t_situacao.Color = RGB (0, 102, 0)
		
	case dw_2.Object.cf_qt_lote [1] < dw_1.Object.qt_faturada [1]	//ist_Parametro.qt_lote
		dw_2.Object.t_situacao.Text  = 'Quantidade inferior $$HEX1$$e000$$ENDHEX$$ faturada!'
		dw_2.Object.t_situacao.Color = RGB (153, 102, 51)
		
	case dw_2.Object.cf_qt_lote [1] > dw_1.Object.qt_faturada [1]	//ist_Parametro.qt_lote
		dw_2.Object.t_situacao.Text  = 'Quantidade maior que a faturada!'
		dw_2.Object.t_situacao.Color = RGB (255, 0, 0)
		
End choose
end subroutine

public function boolean wf_grava_historico (string as_lote_ant, string as_lote_atu, string as_qtde_ant, string as_qtde_atu, string as_dhvl_ant, string as_dhvl_atu, string as_dhfb_ant, string as_dhfb_atu, string as_acao, ref string as_erro);String	ls_Nulo

SetNull (ls_Nulo)

Return wf_grava_historico (as_lote_ant, as_lote_atu, &
									as_qtde_ant, as_qtde_atu, &
									as_dhvl_ant, as_dhvl_atu, &
									as_dhfb_ant, as_dhfb_atu, &
									ls_Nulo,     ls_Nulo, &
									ls_Nulo,     ls_Nulo, &
									as_acao,     Ref as_erro)
end function

public function boolean wf_registra_exclusao ();Integer			li_Linha, &
					li_Tot_Del
String			ls_Lote, &
					ls_Qtde, &
					ls_Qtdv, &
					ls_Qtrs, &
					ls_Qtav, &
					ls_Qtfa, &
					ls_DhVl, &
					ls_DhFb, &
					ls_Erro, &
					ls_Nulo

SetNull (ls_Nulo)

li_Tot_Del = dw_2.DeletedCount ()

For li_Linha = 1 to li_Tot_Del
	ls_Lote =         dw_2.GetItemString   (li_Linha, 'nr_lote',              Delete!, True)
	ls_Qtde = String (dw_2.GetItemNumber   (li_Linha, 'qt_lote',              Delete!, True))
	ls_DhVl = String (dw_2.GetItemDateTime (li_Linha, 'dh_validade',          Delete!, True), 'dd/mm/yyyy')
	ls_DhFb = String (dw_2.GetItemDateTime (li_Linha, 'dh_fabricacao',        Delete!, True), 'dd/mm/yyyy')
	ls_Qtdv = String (dw_2.GetItemNumber   (li_Linha, 'qt_devolvida',         Delete!, True))
	ls_Qtrs = String (dw_2.GetItemNumber   (li_Linha, 'qt_reserva_devolucao', Delete!, True))
	ls_Qtav = String (dw_2.GetItemNumber   (li_Linha, 'qt_avariada',          Delete!, True))
	ls_Qtfa = String (dw_2.GetItemNumber   (li_Linha, 'qt_falta',             Delete!, True))
	
	If not wf_grava_historico (ls_Lote, ls_Nulo, &
										ls_Qtde, ls_Nulo, &
										ls_DhVl, ls_Nulo, &
										ls_DhFb, ls_Nulo, &
										ls_Qtdv, ls_Qtrs, &
										ls_Qtav, ls_Qtfa, &
										'E', Ref ls_Erro) then
		SQLCA.of_RollBack ()
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_Erro, Exclamation!)
		Return False
	End if
Next

Return True
end function

public function boolean wf_registra_inclusao_alteracao ();Boolean	lb_Sucesso
Integer	li_Find
String	ls_Lote_Ant, ls_Lote_Atu, &
			ls_Qtde_Ant, ls_Qtde_Atu, &
			ls_DhVl_Ant, ls_DhVl_Atu, &
			ls_DhFb_Ant, ls_DhFb_Atu, &
			ls_Acao, &
			ls_Erro
			
DwItemStatus	ldis_status

li_Find = dw_2.GetNextModified (0, Primary!)

Try
	Do Until li_Find = 0
		
		ls_Lote_Atu = Trim (dw_2.Object.nr_lote [li_Find])
		
		If IsNull (ls_Lote_Atu) or ls_Lote_Atu = '' then
			ls_Erro = 'Informe o lote!'
			dw_2.Post SetRow    (li_Find)
			dw_2.Post SetColumn ('nr_lote')
			Return False
		End if
		
		ls_Qtde_Atu = String (dw_2.Object.qt_lote [li_Find])
		
		If IsNull (ls_Qtde_Atu) then
			ls_Erro = 'Informe a quantidade do lote!'
			dw_2.Post SetRow    (li_Find)
			dw_2.Post SetColumn ('qt_lote')
			Return False
		End if
		
		ls_DhVl_Atu = String (dw_2.Object.dh_validade [li_Find], 'dd/mm/yyyy')
		
		If ls_DhVl_Atu = '' then
			ls_Erro = 'Informe a data de validade do lote!'
			dw_2.Post SetRow    (li_Find)
			dw_2.Post SetColumn ('dh_validade')
			Return False
		End if
		
		ldis_status = dw_2.GetItemStatus(li_Find, "dh_fabricacao", Primary!)

		IF ldis_status = DataModified! OR ldis_status = NewModified! or ldis_status = New! THEN
			 ls_DhFb_Atu = String (dw_2.Object.dh_fabricacao [li_Find], 'dd/mm/yyyy')
		
			If ls_DhFb_Atu = '' then
				ls_Erro = 'Informe a data de fabrica$$HEX2$$e700e300$$ENDHEX$$o do lote!'
				dw_2.Post SetRow    (li_Find)
				dw_2.Post SetColumn ('dh_fabricacao')
				Return False
			End if
		END IF
		

		
		If dw_2.GetItemStatus (li_Find, 0, Primary!) = NewModified! then
			ls_Acao = 'I'
			SetNull (ls_Lote_Ant)
			SetNull (ls_Qtde_Ant)
			SetNull (ls_DhVl_Ant)
			SetNull (ls_DhFb_Ant)
		else
			ls_Acao     = 'A'
			ls_Lote_Ant =         dw_2.GetItemString   (li_Find, 'nr_lote',       Primary!, True)
			ls_Qtde_Ant = String (dw_2.GetItemNumber   (li_Find, 'qt_lote',       Primary!, True))
			ls_DhVl_Ant = String (dw_2.GetItemDateTime (li_Find, 'dh_validade',   Primary!, True), 'dd/mm/yyyy')
			ls_DhFb_Ant = String (dw_2.GetItemDateTime (li_Find, 'dh_fabricacao', Primary!, True), 'dd/mm/yyyy')
		End if
		
		
	//	ls_Lote_Ant = gf_coalesce (        dw_2.GetItemString   (li_Find, 'nr_lote',     Primary!, True),                '')
	//	ls_Qtde_Ant = gf_coalesce (String (dw_2.GetItemNumber   (li_Find, 'qt_lote',     Primary!, True)),               '')
	//	ls_DhVl_Ant = gf_coalesce (String (dw_2.GetItemDateTime (li_Find, 'dh_validade', Primary!, True), 'dd/mm/yyyy'), '')
	//	ls_DhFb_Ant = gf_coalesce (String (dw_2.GetItemDateTime (li_Find, 'dh_fabricacao', Primary!, True), 'dd/mm/yyyy'), '')
		
		If not wf_grava_historico (ls_Lote_Ant, ls_Lote_Atu, &
											ls_Qtde_Ant, ls_Qtde_Atu, &
											ls_DhVl_Ant, ls_DhVl_Atu, &
											ls_DhFb_Ant, ls_DhFb_Atu, &
											ls_Acao,     Ref ls_Erro) then
			dw_2.Post SetRow (li_Find)
			Return False
		End if
		
		li_Find = dw_2.GetNextModified (li_Find, Primary!)
	Loop
	
	lb_Sucesso = True
	
Finally
	If not lb_Sucesso then
		SQLCA.of_RollBack ()
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_Erro, Exclamation!)
	End if
End Try

Return lb_Sucesso
end function

public function boolean wf_grava_historico (string as_lote_ant, string as_lote_atu, string as_qtde_ant, string as_qtde_atu, string as_dhvl_ant, string as_dhvl_atu, string as_dhfb_ant, string as_dhfb_atu, string as_qtdv_ant, string as_qtrs_ant, string as_qtav_ant, string as_qtfa_ant, string as_acao, ref string as_erro);String	ls_Nulo, &
			ls_Lote

SetNull (ls_Nulo)

If as_acao = 'E' then
	ls_Lote = as_lote_ant
else
	ls_Lote = as_lote_atu
End if

If Not gf_Grava_Historico_Alteracao_Tabela ( 'ITEM_NF_COMPRA_LOTE', &
															String (ist_Parametro.cd_filial) + '@#!' + ist_Parametro.cd_fornecedor + '@#!' + String (ist_Parametro.nr_nf) + '@#!' + &
															ist_Parametro.de_especie + '@#!' + ist_Parametro.de_serie + '@#!' + String (ist_Parametro.cd_natureza_operacao) + '@#!' + &
															String (ist_Parametro.cd_produto) + '@#!' + ls_Lote, &
															'NR_LOTE', as_lote_ant, as_lote_atu, &
															gvo_Aplicacao.ivo_seguranca.nr_matricula, as_acao, Ref as_erro, False) then
	Return False
End if

If Not gf_Grava_Historico_Alteracao_Tabela ( 'ITEM_NF_COMPRA_LOTE', &
															String (ist_Parametro.cd_filial) + '@#!' + ist_Parametro.cd_fornecedor + '@#!' + String (ist_Parametro.nr_nf) + '@#!' + &
															ist_Parametro.de_especie + '@#!' + ist_Parametro.de_serie + '@#!' + String (ist_Parametro.cd_natureza_operacao) + '@#!' + &
															String (ist_Parametro.cd_produto) + '@#!' + ls_Lote, &
															'QT_LOTE', as_qtde_ant, as_qtde_atu, &
															gvo_Aplicacao.ivo_seguranca.nr_matricula, as_acao, Ref as_erro, False) then
	Return False
End if

If Not gf_Grava_Historico_Alteracao_Tabela ( 'ITEM_NF_COMPRA_LOTE', &
															String (ist_Parametro.cd_filial) + '@#!' + ist_Parametro.cd_fornecedor + '@#!' + String (ist_Parametro.nr_nf) + '@#!' + &
															ist_Parametro.de_especie + '@#!' + ist_Parametro.de_serie + '@#!' + String (ist_Parametro.cd_natureza_operacao) + '@#!' + &
															String (ist_Parametro.cd_produto) + '@#!' + ls_Lote, &
															'DH_VALIDADE', as_dhvl_ant, as_dhvl_atu, &
															gvo_Aplicacao.ivo_seguranca.nr_matricula, as_acao, Ref as_erro, False) then
	Return False
End if

If Not gf_Grava_Historico_Alteracao_Tabela ( 'ITEM_NF_COMPRA_LOTE', &
															String (ist_Parametro.cd_filial) + '@#!' + ist_Parametro.cd_fornecedor + '@#!' + String (ist_Parametro.nr_nf) + '@#!' + &
															ist_Parametro.de_especie + '@#!' + ist_Parametro.de_serie + '@#!' + String (ist_Parametro.cd_natureza_operacao) + '@#!' + &
															String (ist_Parametro.cd_produto) + '@#!' + ls_Lote, &
															'DH_FABRICACAO', as_dhfb_ant, as_dhfb_atu, &
															gvo_Aplicacao.ivo_seguranca.nr_matricula, as_acao, Ref as_erro, False) then
	Return False
End if

If Not gf_Grava_Historico_Alteracao_Tabela ( 'ITEM_NF_COMPRA_LOTE', &
															String (ist_Parametro.cd_filial) + '@#!' + ist_Parametro.cd_fornecedor + '@#!' + String (ist_Parametro.nr_nf) + '@#!' + &
															ist_Parametro.de_especie + '@#!' + ist_Parametro.de_serie + '@#!' + String (ist_Parametro.cd_natureza_operacao) + '@#!' + &
															String (ist_Parametro.cd_produto) + '@#!' + ls_Lote, &
															'QT_DEVOLVIDA', as_qtdv_ant, ls_Nulo, &
															gvo_Aplicacao.ivo_seguranca.nr_matricula, as_acao, Ref as_erro, False) then
	Return False
End if

If Not gf_Grava_Historico_Alteracao_Tabela ( 'ITEM_NF_COMPRA_LOTE', &
															String (ist_Parametro.cd_filial) + '@#!' + ist_Parametro.cd_fornecedor + '@#!' + String (ist_Parametro.nr_nf) + '@#!' + &
															ist_Parametro.de_especie + '@#!' + ist_Parametro.de_serie + '@#!' + String (ist_Parametro.cd_natureza_operacao) + '@#!' + &
															String (ist_Parametro.cd_produto) + '@#!' + ls_Lote, &
															'QT_RESERVA_DEVOLUCAO', as_qtrs_ant, ls_Nulo, &
															gvo_Aplicacao.ivo_seguranca.nr_matricula, as_acao, Ref as_erro, False) then
	Return False
End if

If Not gf_Grava_Historico_Alteracao_Tabela ( 'ITEM_NF_COMPRA_LOTE', &
															String (ist_Parametro.cd_filial) + '@#!' + ist_Parametro.cd_fornecedor + '@#!' + String (ist_Parametro.nr_nf) + '@#!' + &
															ist_Parametro.de_especie + '@#!' + ist_Parametro.de_serie + '@#!' + String (ist_Parametro.cd_natureza_operacao) + '@#!' + &
															String (ist_Parametro.cd_produto) + '@#!' + ls_Lote, &
															'QT_AVARIADA', as_qtav_ant, ls_Nulo, &
															gvo_Aplicacao.ivo_seguranca.nr_matricula, as_acao, Ref as_erro, False) then
	Return False
End if

If Not gf_Grava_Historico_Alteracao_Tabela ( 'ITEM_NF_COMPRA_LOTE', &
															String (ist_Parametro.cd_filial) + '@#!' + ist_Parametro.cd_fornecedor + '@#!' + String (ist_Parametro.nr_nf) + '@#!' + &
															ist_Parametro.de_especie + '@#!' + ist_Parametro.de_serie + '@#!' + String (ist_Parametro.cd_natureza_operacao) + '@#!' + &
															String (ist_Parametro.cd_produto) + '@#!' + ls_Lote, &
															'QT_FALTA', as_qtfa_ant, ls_Nulo, &
															gvo_Aplicacao.ivo_seguranca.nr_matricula, as_acao, Ref as_erro, False) then
	Return False
End if

Return True
end function

on w_ge030_altera_adiciona_lote.create
int iCurrent
call super::create
this.cb_excluir_lote=create cb_excluir_lote
this.dw_2=create dw_2
this.cb_adicionar_lote=create cb_adicionar_lote
this.dw_1=create dw_1
this.cb_salvar=create cb_salvar
this.cb_sair=create cb_sair
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_excluir_lote
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_adicionar_lote
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.cb_salvar
this.Control[iCurrent+6]=this.cb_sair
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.gb_2
end on

on w_ge030_altera_adiciona_lote.destroy
call super::destroy
destroy(this.cb_excluir_lote)
destroy(this.dw_2)
destroy(this.cb_adicionar_lote)
destroy(this.dw_1)
destroy(this.cb_salvar)
destroy(this.cb_sair)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;ist_Parametro = Message.PowerObjectParm
end event

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow ()

dw_1.Object.cd_produto  [1] = ist_Parametro.cd_produto
dw_1.Object.de_produto  [1] = ist_Parametro.de_produto
dw_1.Object.qt_faturada [1] = ist_Parametro.qt_faturada

dw_2.Post Event ue_Retrieve ()
end event

type cb_excluir_lote from commandbutton within w_ge030_altera_adiciona_lote
integer x = 494
integer y = 912
integer width = 425
integer height = 112
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Excluir Lote"
end type

event clicked;Integer	li_Linha
Long		ll_Qt_Lote
String	ls_Lote

dw_2.AcceptText ()

li_Linha = dw_2.GetRow ()

If li_linha < 1 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Selecione o lote a ser exclu$$HEX1$$ed00$$ENDHEX$$do!')
	Return
End if

ls_Lote    = dw_2.Object.nr_lote [li_Linha]
ll_Qt_Lote = dw_2.Object.qt_lote [li_Linha]

If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
					'Confirma a exclus$$HEX1$$e300$$ENDHEX$$o do lote ' + ls_Lote + ' (Qtd.: ' + String (ll_Qt_Lote) + ') ?', &
					Question!, YesNo!, 2) = 2 then
	Return
End if

If dw_2.GetItemStatus (li_Linha, 0, Primary!) = DataModified! or &
	dw_2.GetItemStatus (li_Linha, 0, Primary!) = NotModified!  then
	If dw_2.Object.qt_devolvida [li_Linha] + dw_2.Object.qt_reserva_devolucao [li_Linha] + dw_2.Object.qt_avariada [li_Linha] + dw_2.Object.qt_falta [li_Linha] > 0 then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Este lote n$$HEX1$$e300$$ENDHEX$$o pode ser exclu$$HEX1$$ed00$$ENDHEX$$do pois ele tem quantidades n$$HEX1$$e300$$ENDHEX$$o dispon$$HEX1$$ed00$$ENDHEX$$veis', Exclamation!)
		Return
	End if
End if

dw_2.DeleteRow (li_Linha)

wf_confere_total ()

Return


end event

type dw_2 from dc_uo_dw_base within w_ge030_altera_adiciona_lote
integer x = 37
integer y = 224
integer width = 2871
integer height = 648
integer taborder = 20
string dataobject = "dw_ge030_lista_lote_produto"
end type

event itemchanged;call super::itemchanged;Date		ldt_Limite

Choose case Lower (dwo.Name)
	case 'nr_lote'
		If IsNull (data) or Trim (data) = '' then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe o lote!', Exclamation!)
			Return 1
		End if
		
		If This.Find ("nr_lote = '" + data + "'", 1, This.RowCount ()) > 0 then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Este lote j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ listado para este produto!', Exclamation!)
			Return 1
		End if
		
	case 'qt_lote'
		If IsNull (data) or Long (data) = 0 then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe a quantidade!', Exclamation!)
			Return 1
		End if
		
		If This.GetItemStatus (row, 0, Primary!) <> NewModified! then
			If Long (data) < This.Object.qt_devolvida [row] + This.Object.qt_reserva_devolucao [row] then
				MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A quantidade do lote n$$HEX1$$e300$$ENDHEX$$o pode ser menor que a soma da quantidade devolvida com a quantidade reservada para devolu$$HEX2$$e700e300$$ENDHEX$$o!', Exclamation!)
				Return 1
			End if
		End if
		
		Post wf_confere_total ()
		
	case 'dh_validade'
		If IsNull (data) then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe a data de validade!', Exclamation!)
			Return 1
		End if
		
		If Date (data) < Date (gf_GetServerDate ()) then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A validade n$$HEX1$$e300$$ENDHEX$$o pode ser anterior $$HEX1$$e000$$ENDHEX$$ data corrente!', Exclamation!)
			Return 1
		End if
		
	case 'dh_fabricacao'
		If IsNull (data) then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe a data de fabrica$$HEX2$$e700e300$$ENDHEX$$o!', Exclamation!)
			Return 1
		End if
		
		If Date (data) > Date (gf_GetServerDate ()) then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A data de fabrica$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser posterior $$HEX1$$e000$$ENDHEX$$ data corrente!', Exclamation!)
			Return 1
		End if
		
		ldt_Limite = RelativeDate (Date (This.Object.dh_validade [row]), -90)
		
		If Date (data) >= ldt_Limite then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A data de fabrica$$HEX2$$e700e300$$ENDHEX$$o deve ser anterior a ' + String (ldt_Limite, 'dd/mm/yyyy') + ' (90 dias antes da data de validade)!', Exclamation!)
			Return 1
		End if
		
End choose
end event

event ue_recuperar;//Evento em override
Long	ll_Linhas

ll_Linhas = This.Retrieve (ist_Parametro.cd_filial,            &
									ist_Parametro.cd_fornecedor,        &
									ist_Parametro.nr_nf,                &
									ist_Parametro.de_especie,           &
									ist_Parametro.de_serie,             &
									ist_Parametro.cd_natureza_operacao, &
									ist_Parametro.cd_produto)
Return ll_Linhas
end event

event constructor;call super::constructor;This.of_SetRowSelection ()
end event

type cb_adicionar_lote from commandbutton within w_ge030_altera_adiciona_lote
integer x = 46
integer y = 912
integer width = 425
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Adicionar Lote"
end type

event clicked;Integer	li_Linha

If dw_2.Find ("IsNull (nr_lote) or Trim (nr_lote) = ''", 1, dw_2.RowCount ()) > 0 then Return

li_Linha = dw_2.Event ue_AddRow ()

dw_2.Object.cd_filial            [li_Linha] = ist_Parametro.cd_filial
dw_2.Object.cd_fornecedor        [li_Linha] = ist_Parametro.cd_fornecedor
dw_2.Object.nr_nf                [li_Linha] = ist_Parametro.nr_nf
dw_2.Object.de_especie           [li_Linha] = ist_Parametro.de_especie
dw_2.Object.de_serie             [li_Linha] = ist_Parametro.de_serie
dw_2.Object.cd_natureza_operacao [li_Linha] = ist_Parametro.cd_natureza_operacao
dw_2.Object.cd_produto           [li_Linha] = ist_Parametro.cd_produto
dw_2.Object.qt_devolvida         [li_Linha] = 0
dw_2.Object.qt_reserva_devolucao [li_Linha] = 0
dw_2.Object.qt_avariada          [li_Linha] = 0
dw_2.Object.qt_falta             [li_Linha] = 0

dw_2.SetItemStatus (li_Linha, 0, Primary!, NotModified!)

Return
end event

type dw_1 from dc_uo_dw_base within w_ge030_altera_adiciona_lote
integer x = 37
integer y = 36
integer width = 2871
integer height = 88
string dataobject = "dw_ge030_produto_nota"
end type

type cb_salvar from commandbutton within w_ge030_altera_adiciona_lote
integer x = 2171
integer y = 912
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Salvar"
end type

event clicked;Boolean	lb_Sucesso

String	ls_Erro
String	ls_Lote

Long ll_Linhas
Long ll_Linha

If dw_2.AcceptText () < 1 then
	Return
End if

If dw_2.Object.cf_qt_lote [1] <> dw_1.Object.qt_faturada [1] then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A quantidade total nos lotes est$$HEX1$$e100$$ENDHEX$$ diferente da quantidade faturada do produto na nota!', Exclamation!)
	Return
End if

ll_Linhas = dw_2.RowCount()

If ll_Linhas > 0 then
	
	For ll_Linha = 1 to ll_Linhas
		ls_Lote = dw_2.Object.nr_lote [ll_Linha]

		//validar lote com espa$$HEX1$$e700$$ENDHEX$$o no inicio e fim
		If ls_Lote <> trim(ls_Lote) then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ possivel colocar espa$$HEX1$$e700$$ENDHEX$$os no inicio e fim do lote!', Exclamation!)
			Return
		End if
		
	Next
End if 
	
If dw_2.ModifiedCount () > 0 then
	If not wf_registra_inclusao_alteracao () then
		Return
	End if
	
	lb_Sucesso = True
End if

If dw_2.DeletedCount () > 0 then
	If not wf_registra_exclusao () then
		Return
	End if
	
	lb_Sucesso = True
End if

If lb_Sucesso then
	If dw_2.Update () < 1 then
		ls_Erro = SQLCA.SQLErrText
		SQLCA.of_RollBack ()
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o dos lotes: ' + ls_Erro, StopSign!)
		cb_sair.Event Clicked ()
		Return
	End if
	
	SQLCA.of_Commit ()
	CloseWithReturn (Parent, 'S')
else
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Nenhuma modifica$$HEX2$$e700e300$$ENDHEX$$o foi feita!', Exclamation!)
	Return
End if
end event

type cb_sair from commandbutton within w_ge030_altera_adiciona_lote
integer x = 2606
integer y = 912
integer width = 338
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sair"
end type

event clicked;CloseWithReturn (Parent, 'N')
end event

type gb_1 from groupbox within w_ge030_altera_adiciona_lote
integer x = 23
integer width = 2912
integer height = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_ge030_altera_adiciona_lote
integer x = 23
integer y = 168
integer width = 2912
integer height = 728
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lotes do produto na nota"
end type

