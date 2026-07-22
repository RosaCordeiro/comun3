HA$PBExportHeader$w_ge558_movimenta_flow.srw
forward
global type w_ge558_movimenta_flow from dc_w_base
end type
type cb_confirmar from commandbutton within w_ge558_movimenta_flow
end type
type cb_cancelar from commandbutton within w_ge558_movimenta_flow
end type
type dw_1 from dc_uo_dw_base within w_ge558_movimenta_flow
end type
type gb_1 from groupbox within w_ge558_movimenta_flow
end type
end forward

global type w_ge558_movimenta_flow from dc_w_base
string tag = "w_ge558_movimenta_flow"
integer width = 2190
integer height = 664
string title = "GE558 - Movimentar Produto para o Flow"
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
cb_confirmar cb_confirmar
cb_cancelar cb_cancelar
dw_1 dw_1
gb_1 gb_1
end type
global w_ge558_movimenta_flow w_ge558_movimenta_flow

type variables
String	is_Endereco_Origem,  &
			is_Lote,             &
			is_Matricula
		
DateTime idh_Validade		

Long		il_Qt_Movimento_Original, &
			il_Produto,               &
			il_qt_caixa_padrao
end variables

forward prototypes
protected function boolean wf_nr_movimentacao (long al_produto, long al_cx_padrao, string as_lote, datetime adh_validade, ref long al_nr_movimentacao, ref string as_erro)
public function boolean wf_verifica_endereco_flow (string as_endereco)
public function boolean wf_movimenta_para_flow (long al_produto, long al_qt_movimento, long al_cx_padrao, string as_lote, datetime adh_validade, string as_endereco_destino)
end prototypes

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

public function boolean wf_verifica_endereco_flow (string as_endereco);String	ls_id_flow, &
			ls_bairro

SELECT id_flow_rack
	  , cd_bairro
  INTO :ls_id_flow
  	  , :ls_bairro
  FROM wms_endereco
 WHERE cd_endereco = :as_endereco
 USING SQLCA;

Choose case SQLCA.SQLCode
	case 0
		If ls_id_flow = 'N' then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Este endere$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ do flowrack!')
			Return False
		else
			If ls_bairro = 'S' then
				MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Este endere$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ do flowrack!')
				Return False
			End if
		End if
	case 100
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Este endere$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ cadastrado!')
		Return False
	case else
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do endere$$HEX1$$e700$$ENDHEX$$o: ' + SQLCA.SQLErrText)
		Return False
End choose

Return True
end function

public function boolean wf_movimenta_para_flow (long al_produto, long al_qt_movimento, long al_cx_padrao, string as_lote, datetime adh_validade, string as_endereco_destino);//	Declara$$HEX2$$e700f500$$ENDHEX$$es

Long		ll_Nr_Movimentacao, &
			ll_Nulo
					
String 	ls_Endereco_Entrada, &
			ls_Erro,             &
			ls_Nulo
			
uo_ge258_movimentacao lo_Movimentacao

//	Procedimentos

SetNull (ll_Nulo)
SetNull (ls_Nulo)

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
																	'S',                 &
																	ll_Nulo,             &
																	ls_Nulo,             &
																	ll_Nulo,             &
																	ls_Nulo,             &
																	ls_Nulo,             &
																	is_Matricula,        &
																	ll_Nulo) then
		SQLCA.of_Rollback ()
		Return False
	End if
	
	If Not wf_Nr_Movimentacao (al_Produto, al_Cx_Padrao, as_lote, adh_validade, Ref ll_Nr_Movimentacao, Ref ls_Erro) then
		SQLCA.of_Rollback ()
		Messagebox ('Aviso', ls_Erro)
		Return False
	End if
	
	If Not lo_Movimentacao.of_Atualiza_Movimentacao (	as_endereco_destino, &
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

on w_ge558_movimenta_flow.create
int iCurrent
call super::create
this.cb_confirmar=create cb_confirmar
this.cb_cancelar=create cb_cancelar
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_confirmar
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_ge558_movimenta_flow.destroy
call super::destroy
destroy(this.cb_confirmar)
destroy(this.cb_cancelar)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;call super::open;st_ge558_dados_produto	lst_Produto

lst_Produto = Message.PowerObjectParm

dw_1.Object.cd_produto			[1] = lst_Produto.cd_produto
dw_1.Object.de_produto			[1] = lst_Produto.de_produto
dw_1.Object.qt_caixa_padrao	[1] = lst_Produto.qt_caixa_padrao
dw_1.Object.qt_caixas         [1] = lst_Produto.qt_movimento
dw_1.Object.cd_endereco         [1] = lst_Produto.cd_endereco_flow_rack

il_Produto               = lst_Produto.cd_produto
is_Endereco_Origem       = lst_Produto.cd_endereco_origem
il_qt_caixa_padrao       = lst_Produto.qt_caixa_padrao
il_Qt_Movimento_Original = lst_Produto.qt_movimento
idh_Validade			    = lst_Produto.dh_validade
is_Lote					    = lst_Produto.nr_lote

If Not IsNull (idh_Validade) then
	idh_Validade = DateTime (String (idh_Validade, '01/mm/yyyy'))
End if

is_Matricula = gvo_aplicacao.ivo_seguranca.nr_matricula
end event

type cb_confirmar from commandbutton within w_ge558_movimenta_flow
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

Long						ll_Qt_Caixas

String 					ls_Endereco_Destino, &
							ls_Erro

uo_ge558_ajuste_lote	luo_ajuste_lote

//	PROCEDIMENTOS

If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Confirma a movimenta$$HEX2$$e700e300$$ENDHEX$$o do produto?', Question!, YesNo!, 2) = 2 then
	Return
End if

SetPointer (Hourglass!)

If dw_1.AcceptText () = -1 then
	Return
End if

ll_Qt_Caixas        = dw_1.Object.qt_caixas   [1]
ls_Endereco_Destino = dw_1.Object.cd_endereco [1]

If ll_Qt_Caixas = 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe a quantidade de caixas a serem movimentadas para o flow')
	dw_1.Post Event ue_pos (1, 'qt_caixas')
	Return
End if

If IsNull (ls_Endereco_Destino) or Trim (ls_Endereco_Destino) = '' then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe o endere$$HEX1$$e700$$ENDHEX$$o no flow')
	dw_1.Post Event ue_pos (1, 'cd_endereco')
	Return
End if

If Not wf_verifica_endereco_flow (ls_Endereco_Destino) then
	dw_1.Post Event ue_pos (1, 'cd_endereco')
	Return
End if

//Valida$$HEX2$$e700e300$$ENDHEX$$o se endere$$HEX1$$e700$$ENDHEX$$o de destino est$$HEX1$$e100$$ENDHEX$$ bloqueado
If Not gf_Verifica_Endereco_Bloqueado (ls_Endereco_Destino, Ref ls_Erro) then
	Messagebox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_Erro)
	dw_1.Post Event ue_pos (1, 'cd_endereco')
	Return
End if

Try
	//
	//Movimenta$$HEX2$$e700e300$$ENDHEX$$o
	//
	If wf_movimenta_para_flow (il_produto,         &
										ll_Qt_Caixas,       &
										il_qt_caixa_padrao, &
										is_Lote,            &
										idh_Validade,       &
										ls_Endereco_Destino) then
		MessageBox ('Aviso', 'Movimento confirmado.')
		Post Close (Parent)
	End if
	
Finally
	SetPointer (Arrow!)
End try
end event

type cb_cancelar from commandbutton within w_ge558_movimenta_flow
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

type dw_1 from dc_uo_dw_base within w_ge558_movimenta_flow
integer x = 37
integer y = 68
integer width = 2089
integer height = 340
string dataobject = "dw_ge558_movimenta_flow"
end type

event itemchanged;call super::itemchanged;Long		ll_qt_caixas
String	ls_endereco, &
			ls_Erro

Choose case dwo.Name
	case 'qt_caixas'
		ll_qt_caixas = Long (data)
		
		If ll_qt_caixas = 0 then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe a quantidade de caixas a serem movimentadas para o flow')
			Return 1
		End if
		
		If ll_qt_caixas > il_qt_movimento_original then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A quantidade de caixas n$$HEX1$$e300$$ENDHEX$$o deve ser maior que o dispon$$HEX1$$ed00$$ENDHEX$$vel neste endere$$HEX1$$e700$$ENDHEX$$o: ' + String (il_qt_movimento_original))
			Return 1
		End if
		
	case 'cd_endereco'
		ls_endereco = Trim (data)
		
		If ls_endereco = '' then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe o endere$$HEX1$$e700$$ENDHEX$$o no flow')
			Return 1
		End if
		
End choose
end event

type gb_1 from groupbox within w_ge558_movimenta_flow
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

