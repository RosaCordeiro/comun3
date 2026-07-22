HA$PBExportHeader$w_ge030_altera_lote.srw
forward
global type w_ge030_altera_lote from dc_w_base
end type
type dw_1 from dc_uo_dw_base within w_ge030_altera_lote
end type
type cb_2 from commandbutton within w_ge030_altera_lote
end type
type cb_1 from commandbutton within w_ge030_altera_lote
end type
type gb_1 from groupbox within w_ge030_altera_lote
end type
end forward

global type w_ge030_altera_lote from dc_w_base
integer width = 1929
integer height = 712
string title = "GE030 - Alterar Lote"
boolean controlmenu = false
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
end type
global w_ge030_altera_lote w_ge030_altera_lote

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
public function boolean wf_atualiza_lote (string as_lote_novo)
public function boolean wf_localiza_lote (string as_lote, ref long al_qtde)
public function boolean wf_historico_exclusao ()
public function boolean wf_historico_alteracao (string as_lote_novo)
public function boolean wf_historico_alteracao (string as_lote_novo, long al_qtde_anterior, long al_qtde_novo)
end prototypes

public function boolean wf_atualiza_lote (string as_lote_novo);// A fun$$HEX2$$e700e300$$ENDHEX$$o verifica:
//	1. se o lote ANTERIOR n$$HEX1$$e300$$ENDHEX$$o existir, $$HEX1$$e900$$ENDHEX$$ erro;
// 2. se n$$HEX1$$e300$$ENDHEX$$o houver registro do NOVO lote nesta nota, substitui o lote ANTERIOR pelo NOVO
// 3. se houver, atualiza o NOVO, adicionando a quantidade do lote ANTERIOR e exclui o ANTERIOR

Long		ll_Qtde_Anterior, ll_Qtde_Novo
String	ls_Erro

// Localiza o lote a ser alterado
If not wf_localiza_lote (ist_Parametro.nr_lote, Ref ll_Qtde_Anterior) then
	Return False
End if

If ll_Qtde_Anterior = 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Produto [' + String (ist_Parametro.cd_produto) + ']/lote [' + ist_Parametro.nr_lote + '] n$$HEX1$$e300$$ENDHEX$$o encontrado entre os itens desta NF', Exclamation!)
	Return False
End if

// Verifica se o novo lote j$$HEX1$$e100$$ENDHEX$$ existe na nota
If not wf_localiza_lote (as_lote_novo, Ref ll_Qtde_Novo) then
	Return False
End if

If ll_Qtde_Novo = 0 then
	// Novo lote n$$HEX1$$e300$$ENDHEX$$o existe na NF. Substitui o anterior pelo novo:
	UPDATE item_nf_compra_lote
		SET nr_lote = :as_Lote_Novo
	 WHERE cd_filial            = :ist_Parametro.cd_filial
		AND cd_fornecedor        = :ist_Parametro.cd_fornecedor
		AND nr_nf                = :ist_Parametro.nr_nf
		AND de_especie           = :ist_Parametro.de_especie
		AND de_serie             = :ist_Parametro.de_serie
		AND cd_natureza_operacao = :ist_Parametro.cd_natureza_operacao
		AND cd_produto           = :ist_Parametro.cd_produto
		AND nr_lote              = :ist_Parametro.nr_lote
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		ls_Erro = SQLCA.SQLErrText
		SQLCA.of_RollBack ()
		MessageBox ('Erro', "Erro ao substituir o lote na tabela 'item_nf_compra_lote': " + '~n~r~r' + ls_Erro, StopSign!)
		Return False
	End if
	
	If Not wf_historico_alteracao (as_Lote_Novo) then
		Return False
	End if

else
	//Acrescenta a qtde do lote anterior no novo lote
	UPDATE item_nf_compra_lote
		SET qt_lote = qt_lote + :ll_Qtde_Anterior
	 WHERE cd_filial     = :ist_Parametro.cd_filial
		AND cd_fornecedor = :ist_Parametro.cd_fornecedor
		AND nr_nf         = :ist_Parametro.nr_nf
		AND de_especie    = :ist_Parametro.de_especie
		AND de_serie      = :ist_Parametro.de_serie
		AND cd_produto    = :ist_Parametro.cd_produto
		AND nr_lote       = :as_lote_novo
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		ls_Erro = SQLCA.SQLErrText
		SQLCA.of_RollBack ()
		MessageBox ('Erro', "Erro ao atualizar a quantidade do novo lote na tabela 'item_nf_compra_lote': " + '~n~r~r' + ls_Erro, StopSign!)
		Return False
	End if
	
	If Not wf_historico_alteracao (as_Lote_Novo, ll_Qtde_Anterior, ll_Qtde_Novo) then
		Return False
	End if
	
	//Exclui o lote anterior
	DELETE item_nf_compra_lote
	 WHERE cd_filial     = :ist_Parametro.cd_filial
		AND cd_fornecedor = :ist_Parametro.cd_fornecedor
		AND nr_nf         = :ist_Parametro.nr_nf
		AND de_especie    = :ist_Parametro.de_especie
		AND de_serie      = :ist_Parametro.de_serie
		AND cd_produto    = :ist_Parametro.cd_produto
		AND nr_lote       = :ist_Parametro.nr_lote
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		ls_Erro = SQLCA.SQLErrText
		SQLCA.of_RollBack ()
		MessageBox ('Erro', "Erro ao excluir o lote anterior na tabela 'item_nf_compra_lote': " + '~n~r~r' + ls_Erro, StopSign!)
		Return False
	End if
	
	If not wf_historico_exclusao () then
		Return False
	End if
End if

Return True


//			If Not gf_Grava_Historico_Alteracao_Tabela ('INTEGRACAO_SAP', &
//																	  String (il_Empresa_Sap) + '@#!' + This.Object.cd_chave_legado [ll_linha] + '@#!' + is_tp_tabela, &
//																	  'CD_CHAVE_LEGADO', ls_valor_ant, ls_valor_atu, gvo_Aplicacao.ivo_seguranca.nr_matricula, 'A', Ref ls_log, True) then
//				Return -1
//			End if
//
//
//
//	If Not gf_Grava_Historico_Alteracao_Tabela ('INTEGRACAO_SAP', &
//															  String (il_Empresa_Sap) + '@#!' + ls_valor_ant + '@#!' + is_tp_tabela, &
//															  'CD_EMPRESA', String (This.GetItemNumber (ll_linha, 'cd_empresa', Delete!, True)), ls_nulo, gvo_Aplicacao.ivo_seguranca.nr_matricula, 'E', Ref ls_log, True) then
//		Return -1
//	End if
//
end function

public function boolean wf_localiza_lote (string as_lote, ref long al_qtde);String	ls_Erro

// Localiza o lote a ser alterado
SELECT COALESCE (qt_lote, 0)
  INTO :al_Qtde
  FROM item_nf_compra_lote
 WHERE cd_filial     = :ist_Parametro.cd_filial
	AND cd_fornecedor = :ist_Parametro.cd_fornecedor
	AND nr_nf         = :ist_Parametro.nr_nf
	AND de_especie    = :ist_Parametro.de_especie
	AND de_serie      = :ist_Parametro.de_serie
	AND cd_produto    = :ist_Parametro.cd_produto
	AND nr_lote       = :as_lote
 USING SQLCA;

iF SQLCA.SQLCode < 0 then
	SQLCA.of_msgdberror ('Erro ao consultar o lote ' + as_lote + " na tabela 'item_nf_compra_lote'")
	Return False
End if

Return True
end function

public function boolean wf_historico_exclusao ();String	ls_nulo, ls_log

SetNull (ls_nulo)

If Not gf_Grava_Historico_Alteracao_Tabela ( &
								'ITEM_NF_COMPRA_LOTE', &
								String (ist_Parametro.cd_filial) + '@#!' + ist_Parametro.cd_fornecedor + '@#!' + String (ist_Parametro.nr_nf) + '@#!' + &
								ist_Parametro.de_especie + '@#!' + ist_Parametro.de_serie + '@#!' + String (ist_Parametro.cd_natureza_operacao) + '@#!' + &
								String (ist_Parametro.cd_produto) + '@#!' + ist_Parametro.nr_lote, &
								'NR_LOTE', ist_Parametro.nr_lote, ls_nulo, &
								gvo_Aplicacao.ivo_seguranca.nr_matricula, 'E', Ref ls_log, True) then
	Return False
End if

Return True
end function

public function boolean wf_historico_alteracao (string as_lote_novo);//
// Registra substitui$$HEX2$$e700e300$$ENDHEX$$o do lote
//
String	ls_log

If Not gf_Grava_Historico_Alteracao_Tabela ( &
							'ITEM_NF_COMPRA_LOTE', &
							String (ist_Parametro.cd_filial) + '@#!' + ist_Parametro.cd_fornecedor + '@#!' + String (ist_Parametro.nr_nf) + '@#!' + &
							ist_Parametro.de_especie + '@#!' + ist_Parametro.de_serie + '@#!' + String (ist_Parametro.cd_natureza_operacao) + '@#!' + &
							String (ist_Parametro.cd_produto) + '@#!' + as_Lote_Novo, &
							'NR_LOTE', ist_Parametro.nr_lote, as_Lote_Novo, &
							gvo_Aplicacao.ivo_seguranca.nr_matricula, 'A', Ref ls_log, True &
														 ) then
	Return False
End if

Return True
end function

public function boolean wf_historico_alteracao (string as_lote_novo, long al_qtde_anterior, long al_qtde_novo);//
// Registra acr$$HEX1$$e900$$ENDHEX$$scimo na quantidade do lote novo
//
String	ls_log

If Not gf_Grava_Historico_Alteracao_Tabela ( &
							'ITEM_NF_COMPRA_LOTE', &
							String (ist_Parametro.cd_filial) + '@#!' + ist_Parametro.cd_fornecedor + '@#!' + String (ist_Parametro.nr_nf) + '@#!' + &
							ist_Parametro.de_especie + '@#!' + ist_Parametro.de_serie + '@#!' + String (ist_Parametro.cd_natureza_operacao) + '@#!' + &
							String (ist_Parametro.cd_produto) + '@#!' + as_Lote_Novo, &
							'QT_LOTE', String (al_Qtde_Novo), String (al_Qtde_Novo + al_Qtde_Anterior), &
							gvo_Aplicacao.ivo_seguranca.nr_matricula, 'A', Ref ls_log, True &
														 ) then
	Return False
End if

Return True
end function

on w_ge030_altera_lote.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_ge030_altera_lote.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
end on

event open;call super::open;ist_Parametro = Message.PowerObjectParm	

dw_1.InsertRow (0)
dw_1.Object.cd_produto      [1] = ist_Parametro.cd_produto
dw_1.Object.de_produto      [1] = ist_Parametro.de_produto
dw_1.Object.nr_lote         [1] = ist_Parametro.nr_lote
dw_1.Object.dh_Validade     [1] = ist_Parametro.dh_validade
dw_1.Object.cd_filial       [1] = ist_Parametro.cd_filial
dw_1.Object.nm_fantasia     [1] = ist_Parametro.nm_fantasia
dw_1.Object.cd_fornecedor   [1] = ist_Parametro.cd_fornecedor
dw_1.Object.nm_razao_social [1] = ist_Parametro.nm_razao_social
dw_1.Object.nr_nf           [1] = ist_Parametro.nr_nf
dw_1.Object.de_especie      [1] = ist_Parametro.de_especie
dw_1.Object.de_serie        [1] = ist_Parametro.de_serie


end event

type dw_1 from dc_uo_dw_base within w_ge030_altera_lote
integer x = 37
integer y = 36
integer width = 1847
integer height = 420
string dataobject = "dw_ge030_altera_lote"
end type

type cb_2 from commandbutton within w_ge030_altera_lote
integer x = 1033
integer y = 500
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Confirmar"
end type

event clicked;String	ls_Retorno
String	ls_Lote_Novo

dw_1.AcceptText ()

ls_Lote_Novo = Trim (dw_1.Object.nr_lote [1])

If IsNull (ls_Lote_Novo) then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe o lote!', Exclamation!)
	dw_1.Event ue_Pos (1, 'nr_lote')
	Return 1
End if

If ls_Lote_Novo = ist_Parametro.nr_lote then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O novo lote n$$HEX1$$e300$$ENDHEX$$o pode ser igual ao anterior!', Exclamation!)
	dw_1.Event ue_Pos (1, 'nr_lote')
	Return 1
End if

//validar lote com espa$$HEX1$$e700$$ENDHEX$$o no inicio e fim
If ls_Lote_Novo <> Trim(ls_Lote_Novo)  then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ possivel colocar espa$$HEX1$$e700$$ENDHEX$$os no inicio e fim do lote!', Exclamation!)
	dw_1.Event ue_Pos (1, 'nr_lote')
	Return 1
End if

If not wf_atualiza_lote (ls_Lote_Novo) then
	Return 1
End if

SQLCA.of_Commit ()

CloseWithReturn (Parent, 'S')
end event

type cb_1 from commandbutton within w_ge030_altera_lote
integer x = 1568
integer y = 500
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

type gb_1 from groupbox within w_ge030_altera_lote
integer x = 23
integer width = 1879
integer height = 484
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

