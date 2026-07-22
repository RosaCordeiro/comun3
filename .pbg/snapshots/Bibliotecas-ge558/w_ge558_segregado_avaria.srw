HA$PBExportHeader$w_ge558_segregado_avaria.srw
forward
global type w_ge558_segregado_avaria from dc_w_base
end type
type cb_2 from commandbutton within w_ge558_segregado_avaria
end type
type cb_1 from commandbutton within w_ge558_segregado_avaria
end type
type dw_1 from dc_uo_dw_base within w_ge558_segregado_avaria
end type
type gb_1 from groupbox within w_ge558_segregado_avaria
end type
end forward

global type w_ge558_segregado_avaria from dc_w_base
string tag = "w_ge558_segregado_avaria"
integer width = 2190
integer height = 664
string title = "GE558 - Produto Segregado Avaria"
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge558_segregado_avaria w_ge558_segregado_avaria

type variables
String	is_Endereco_Origem,  &
			is_Endereco_Destino, &
			is_Lote_Original,    &
			is_Matricula
		
DateTime idh_Validade_Original		

Long		il_Qt_Movimento_Original, &
			il_Sequencial,            &
			il_Produto,               &
			il_qt_caixa_padrao
end variables

forward prototypes
public function boolean wf_destino (ref string as_endereco_destino, ref string as_erro)
public function boolean wf_movimenta_segregado (long al_produto, long al_qt_movimento, long al_cx_padrao, string as_lote, datetime adh_validade)
public function boolean wf_sequencial_saida (string as_endereco, long al_produto, string as_lote, long al_cx_padrao, datetime adh_validade, ref long al_sequencial)
protected function boolean wf_nr_movimentacao (long al_produto, long al_cx_padrao, string as_lote, datetime adh_validade, ref long al_nr_movimentacao, ref string as_erro)
public function boolean wf_inclui_segregado_recebimento (long al_qtde_movimento, string as_lote, datetime adh_validade)
end prototypes

public function boolean wf_destino (ref string as_endereco_destino, ref string as_erro);String	ls_Cd_Parametro

ls_Cd_Parametro = 'CD_ENDERECO_SEGREGADO_DEVOLUCAO_AVARIA'

SELECT vl_parametro
  INTO :as_Endereco_Destino
  FROM wms_parametro
 WHERE cd_parametro = :ls_Cd_Parametro
 USING SQLCA;

Choose Case SQLCA.SQLCode
	Case -1
		as_Erro = 'Erro no SELECT da wms_parametro:~n~r~r' + SQLCA.SQLErrText
		Return False
	Case 100
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o valor do par$$HEX1$$e200$$ENDHEX$$metro '" + ls_Cd_Parametro + "'."
		Return False
End Choose

Return True
end function

public function boolean wf_movimenta_segregado (long al_produto, long al_qt_movimento, long al_cx_padrao, string as_lote, datetime adh_validade);//	Declara$$HEX2$$e700f500$$ENDHEX$$es

Long		ll_Nr_Movimentacao, &
			ll_sequencial,      &
			ll_qt_segregado,    &
			ll_Nulo
					
String 	ls_Endereco_Entrada, &
			ls_Erro,             &
			ls_Nulo
			
uo_ge258_movimentacao lo_Movimentacao

//	Procedimentos

SetNull (ll_Nulo)
SetNull (ls_Nulo)

//Valida$$HEX2$$e700e300$$ENDHEX$$o se endere$$HEX1$$e700$$ENDHEX$$o de destino est$$HEX1$$e100$$ENDHEX$$ bloqueado
If Not gf_Verifica_Endereco_Bloqueado (is_Endereco_Destino, Ref ls_Erro) then
	SQLCA.of_Rollback ()
	Messagebox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_Erro)
	Return False
End if

ll_qt_segregado = al_qt_movimento * il_qt_caixa_padrao

//If Not wf_Inclui_Segregado_Recebimento (ll_qt_segregado, as_lote, adh_validade) Then Return False

Try
	
	lo_Movimentacao = Create uo_ge258_movimentacao
	
	lo_Movimentacao.ivb_Commit = False
	
	SetNull (ls_Endereco_Entrada)
	If Not lo_Movimentacao.of_insere_movimentacao (	ls_Endereco_Entrada, &
																	is_Endereco_Origem,  &
																	al_Produto,          &
																	al_Cx_Padrao,        &
																	as_Lote,             &
																	Date (adh_Validade), &
																	al_Qt_Movimento,     &
																	"S",                 &
																	ll_Nulo,             &
																	ls_Nulo,             &
																	ll_Nulo,             &
																	ls_Nulo,             &
																	ls_Nulo,             &
																	is_Matricula,        &
																	ll_Nulo) then
//																	il_Sequencial) Then
		SQLCA.of_Rollback ()
		Return False
	End if
	
	If Not wf_Nr_Movimentacao (al_Produto, al_Cx_Padrao, as_lote, adh_validade, Ref ll_Nr_Movimentacao, Ref ls_Erro) then
		SQLCA.of_Rollback ()
		Messagebox ('Aviso', ls_Erro)
		Return False
	End if
	
	If Not lo_Movimentacao.of_Atualiza_Movimentacao (	is_Endereco_Destino, &
																		al_Produto,          &
																		ll_Nr_Movimentacao,  &
																		al_Qt_Movimento,     &
																		as_Lote,             &
																		al_Cx_Padrao,        &
																		adh_Validade) then
		SQLCA.of_Rollback ()
		Return False
	End if
	
	SQLCA.of_Commit ()

Finally
	Destroy lo_Movimentacao
	
End Try

Return True
end function

public function boolean wf_sequencial_saida (string as_endereco, long al_produto, string as_lote, long al_cx_padrao, datetime adh_validade, ref long al_sequencial);//String ls_Erro, ls_Chave
//
//select nr_sequencial
//Into :al_sequencial
//from wms_localizacao 
//where cd_endereco 		= :as_Endereco
//  and cd_produto 			= :al_Produto
//  and nr_lote 				= :as_Lote
//  and qt_caixa_padrao 	= :al_Cx_Padrao
//  and dh_validade			= :adh_Validade
//Using SqlCa;
//
//Choose Case SqlCa.SqlCode 
//	Case -1
//		ls_Erro = "Erro ao localizar o sequencial End:'" + as_Endereco + "' Produto: '" +  String(al_Produto) + "' Lote: '" + as_Lote + "' Validade: '" + String(adh_Validade, "dd/mm/yyyy") + "'" + '~n~r~r' + SqlCa.SQLErrText
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro, StopSign!)
//		
//		Return False
//	Case 100
//		ls_Erro	= "Sequencial n$$HEX1$$e300$$ENDHEX$$o localizado.~r~r"+&
//						 	"Endere$$HEX1$$e700$$ENDHEX$$o: "+as_Endereco+"~r"+&
//							"Produto: "+String(al_Produto)+"~r"+&
//							"Lote: "+as_Lote+"~r"+&
//							"Cx. Padrao: "+String(al_Cx_Padrao)+"~r"+&
//							"Validade: "+String(adh_Validade, "dd-mm-yyyy") 
//		
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro, StopSign!)
//		
//		Return False
//End Choose

Return True
end function

protected function boolean wf_nr_movimentacao (long al_produto, long al_cx_padrao, string as_lote, datetime adh_validade, ref long al_nr_movimentacao, ref string as_erro);//Pega o n$$HEX1$$fa00$$ENDHEX$$mero da movimenta$$HEX2$$e700e300$$ENDHEX$$o
SELECT TOP 1 nr_movimentacao
  INTO 		:al_Nr_Movimentacao
  FROM wms_movimentacao
 WHERE cd_produto               = :al_Produto
	AND nr_matricula_responsavel = :is_Matricula
	AND cd_endereco_saida        = :is_Endereco_Origem
	AND nr_lote                  = :as_lote
	AND qt_caixa_padrao          = :al_Cx_Padrao
	AND dh_validade              = :adh_validade
//	AND nr_sequencial_saida      = :al_Sequencial
	AND id_tipo_movimento        = 'S'
 USING SQLCA;

Choose Case SQLCA.SQLCode
	Case -1
		as_Erro = 'Erro ao selecionar dados de movimenta$$HEX2$$e700e300$$ENDHEX$$o do produto:~n~r~r' + SQLCA.SQLErrText
		Return False
		
	Case 100
		as_Erro = 'O produto ' + String (al_Produto) + ' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ em movimenta$$HEX2$$e700e300$$ENDHEX$$o.'
		Return False
End Choose

Return True
end function

public function boolean wf_inclui_segregado_recebimento (long al_qtde_movimento, string as_lote, datetime adh_validade);Long		ll_Controle

String	ls_Msg

SELECT nr_controle
  INTO :ll_Controle
  FROM wms_segregado_recebimento
 WHERE cd_endereco   = :is_Endereco_Destino
	AND cd_produto    = :il_Produto
	AND nr_lote       = :as_lote
	AND dh_validade   = :adh_validade
	AND cd_fornecedor IS NULL
	AND nr_nf         IS NULL
	AND de_especie    IS NULL
	AND de_serie      IS NULL
 USING SQLCA;

Choose Case SQLCA.SQLCode
	Case 0
		
		UPDATE wms_segregado_recebimento
			SET qt_lote = qt_lote + :al_qtde_movimento
		 WHERE nr_controle = :ll_Controle
		 USING SQLCA;
		
		If SQLCA.SQLCode = -1 then
			ls_Msg = 'Erro ao atualizar a quantidade do lote do produto ' + String (il_Produto) + ' na tabela wms_segregado_recebimento:~n~r~r' + SQLCA.SQLErrText
			SQLCA.of_Rollback ()
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_Msg, StopSign!)
			Return False
		End if
		
	Case 100
		
		INSERT INTO wms_segregado_recebimento (cd_endereco, &
															cd_produto,  &
															nr_lote,     &
															dh_validade, &
															qt_lote)
												VALUES  (:is_Endereco_Destino,  &
															:il_produto,   &
															:as_lote,      &
															:adh_validade, &
															:al_qtde_movimento)
		 USING SQLCA;
		
		If SQLCA.SQLCode = -1 then
			ls_Msg = 'Erro na inclus$$HEX1$$e300$$ENDHEX$$o do lote na tabela wms_segregado_recebimento:~n~r~r' + SQLCA.SQLErrText
			SQLCA.of_RollBack ()
			MessageBox ('Erro', ls_Msg, StopSign!)
			Return False
		End if
		
	Case -1
		ls_Msg = 'Erro na leitura do lote na tabela wms_segregado_recebimento:~n~r~r' + SQLCA.SQLErrText
		SQLCA.of_RollBack ()
		MessageBox ('Erro', ls_Msg, StopSign!)
		Return False
		
End Choose

Return True
end function

on w_ge558_segregado_avaria.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_ge558_segregado_avaria.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;call super::open;st_ge558_dados_produto	lst_Produto

lst_Produto = Message.PowerObjectParm

dw_1.Object.cd_produto			[1]	= lst_Produto.cd_produto
dw_1.Object.de_produto			[1]	= lst_Produto.de_produto
dw_1.Object.qt_caixa_padrao	[1] 	= lst_Produto.qt_caixa_padrao
dw_1.Object.qt_saldo				[1] 	= lst_Produto.qt_movimento
dw_1.Object.nr_lote				[1]	= lst_Produto.nr_lote
dw_1.Object.dh_Validade			[1]	= lst_Produto.dh_Validade

il_Produto							= lst_Produto.cd_produto
is_Endereco_Origem              = lst_Produto.cd_endereco_origem
il_Sequencial                  		= lst_Produto.nr_sequencial
il_qt_caixa_padrao              	= lst_Produto.qt_caixa_padrao
il_Qt_Movimento_Original		= lst_Produto.qt_movimento
idh_Validade_Original			= lst_Produto.dh_validade
is_Lote_Original					= lst_Produto.nr_lote

If Not IsNull (idh_Validade_Original) then
	idh_Validade_Original		= DateTime (String (idh_Validade_Original, '01/mm/yyyy'))
End if

is_Matricula = gvo_aplicacao.ivo_seguranca.nr_matricula
end event

event ue_postopen;call super::ue_postopen;String	ls_Erro

If Not wf_Destino (Ref is_Endereco_Destino, Ref ls_Erro) then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_Erro)
	Post Close (This)
	Return
End if

If is_Endereco_Origem = is_Endereco_Destino then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Esse produto j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ no segregado avariados.')
	Post Close (This)
	Return
End if

If Not f_ge558_permite_movimento_produto (is_Endereco_Origem, il_Produto) then
	Post Close (This)
End if

Return
end event

type cb_2 from commandbutton within w_ge558_segregado_avaria
integer x = 1349
integer y = 452
integer width = 402
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Confirmar"
end type

event clicked;//	DECLARA$$HEX2$$c700d500$$ENDHEX$$ES

DateTime					ldh_validade

Long						ll_Qt_Movimento,    &
							ll_Qt_Segregado,    &
							ll_Nr_Movimentacao, &
							ll_Nulo

String 					ls_Nr_Lote,          &
							ls_Endereco_Entrada, &
							ls_Erro_End_Bloq,    &
							ls_Erro,             &
							ls_Nulo

uo_ge558_ajuste_lote	luo_ajuste_lote

//	PROCEDIMENTOS

If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Confirma a movimenta$$HEX2$$e700e300$$ENDHEX$$o do produto?', Question!, YesNo!, 2) = 2 then
	Return
End if

SetPointer (Hourglass!)

SetNull (ll_Nulo)
SetNull (ls_Nulo)

dw_1.AcceptText ()

ll_Qt_Movimento = dw_1.Object.qt_movimento [1]
ls_Nr_Lote      = dw_1.Object.nr_lote      [1]
ldh_validade    = dw_1.Object.dh_validade  [1]

Try
	//
	//Valida$$HEX2$$e700f500$$ENDHEX$$es
	//
	If IsNull (ll_Qt_Movimento) then
		MessageBox ('Aviso', 'Informe a quantidade avariada!')
		dw_1.Event ue_Pos (1, 'qt_movimento')
		Return
	End if
	
	If ll_Qt_Movimento < 1 then
		MessageBox ('Aviso', 'A quantidade avariada n$$HEX1$$e300$$ENDHEX$$o pode ser NEGATIVA/ZERO')
		dw_1.Event ue_Pos (1, 'qt_movimento')
		Return
	End if
	
	If ll_Qt_Movimento > il_Qt_Movimento_Original then
		MessageBox ('Aviso', 'A quantidade avariada n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que ' + String (il_Qt_Movimento_Original))
		dw_1.Event ue_Pos (1, 'qt_movimento')
		Return
	End if
	
	//
	//Movimenta$$HEX2$$e700e300$$ENDHEX$$o
	//
	If ls_Nr_Lote = is_Lote_Original and ldh_validade = idh_Validade_Original then
		//
		// 1o cen$$HEX1$$e100$$ENDHEX$$rio: sem altera$$HEX2$$e700e300$$ENDHEX$$o de lote/validade
		//
		If wf_movimenta_segregado (il_produto,         &
											ll_qt_movimento,    &
											il_qt_caixa_padrao, &
											is_Lote_Original,   &
											idh_Validade_Original) then
			MessageBox ('Aviso', 'Movimento confirmado.')
			Post Close (Parent)
		End if
	else
		//
		// 2o cen$$HEX1$$e100$$ENDHEX$$rio: com altera$$HEX2$$e700e300$$ENDHEX$$o de lote/validade
		//
		If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o',  'Voc$$HEX1$$ea00$$ENDHEX$$ alterou o lote e/ou a validade e ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio fazer um movimento de ajuste do lote.~n~r~r' + &
											'Deseja prosseguir com a altera$$HEX2$$e700e300$$ENDHEX$$o?', Question!, YesNo!, 2) = 2 then
			dw_1.Object.nr_lote     [1] = is_Lote_Original
			dw_1.Object.dh_validade [1] = idh_Validade_Original
			Return
		else
			Try
				luo_ajuste_lote = Create uo_ge558_ajuste_lote
				
				If luo_ajuste_lote.of_ajusta_lote (	il_produto,               &
																il_qt_caixa_padrao,       &
																is_Lote_Original,         &
																idh_Validade_Original,    &
																il_Qt_Movimento_Original, &
																ls_Nr_Lote,               &
																ldh_validade,             &
																ll_qt_movimento,          &
																is_Endereco_Origem,       &
																is_matricula) then
					If wf_movimenta_segregado (il_produto,            &
														ll_qt_movimento,       &
														il_qt_caixa_padrao,    &
														ls_Nr_Lote,            &
														ldh_validade) then
						MessageBox ('Aviso', 'Movimento confirmado.')
						Post Close (Parent)
					End if
				End if
			Finally
				Destroy luo_ajuste_lote
			End try
		End if
	End if
	
Finally
	SetPointer (Arrow!)
End try
end event

type cb_1 from commandbutton within w_ge558_segregado_avaria
integer x = 1760
integer y = 452
integer width = 402
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar"
end type

event clicked;If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Deseja cancelar e sair da tela?', Question!, YesNo!, 2) = 1 then
	Close (Parent)
End if
end event

type dw_1 from dc_uo_dw_base within w_ge558_segregado_avaria
integer x = 37
integer y = 68
integer width = 2089
integer height = 332
string dataobject = "dw_ge558_segregado_avaria"
end type

type gb_1 from groupbox within w_ge558_segregado_avaria
integer x = 18
integer width = 2144
integer height = 428
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
end type

