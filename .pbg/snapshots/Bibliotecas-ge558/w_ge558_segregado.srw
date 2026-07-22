HA$PBExportHeader$w_ge558_segregado.srw
forward
global type w_ge558_segregado from dc_w_base
end type
type cb_2 from commandbutton within w_ge558_segregado
end type
type cb_1 from commandbutton within w_ge558_segregado
end type
type dw_1 from dc_uo_dw_base within w_ge558_segregado
end type
type gb_1 from groupbox within w_ge558_segregado
end type
end forward

global type w_ge558_segregado from dc_w_base
string tag = "w_ge558_segregado"
integer width = 2071
integer height = 664
string title = "GE558 - Produto Segregado"
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge558_segregado w_ge558_segregado

type variables
String is_Endereco_Origem,&
		is_Lote,&
		is_Matricula,&
		is_tipo_segregado
		
DateTime idh_Validade		

Long il_Qt_Movimento_Original, il_Sequencial, il_Produto
end variables

forward prototypes
protected function boolean wf_nr_movimentacao (long al_produto, long al_cx_padrao, ref long al_nr_movimentacao, ref string as_erro)
public function boolean wf_destino (string id_tipo_movimento, ref string as_endereco_destino, ref string as_erro)
public function boolean wf_inclui_segregado_recebimento (long al_qtde_movimento, string as_endereco)
public function boolean wf_diminui_segregado (long al_qtde_movimento, string as_endereco)
public function boolean wf_localiza_saldo_momento_wms (long al_produto, string as_endereco, string as_lote, long al_cx_padrao, date adt_validade, long al_qtd_formulario)
end prototypes

protected function boolean wf_nr_movimentacao (long al_produto, long al_cx_padrao, ref long al_nr_movimentacao, ref string as_erro);//Pega o n$$HEX1$$fa00$$ENDHEX$$mero da movimenta$$HEX2$$e700e300$$ENDHEX$$o
select Top 1	nr_movimentacao
Into 		:al_Nr_Movimentacao
from wms_movimentacao
where cd_produto 						= :al_Produto
and	nr_matricula_responsavel 	= :is_Matricula
and 	cd_endereco_saida 			= :is_Endereco_Origem
and 	nr_lote							= :is_Lote
and	qt_caixa_padrao 				= :al_Cx_Padrao
and 	dh_validade 					= :idh_Validade
and nr_sequencial_saida					= :il_Sequencial
and id_tipo_movimento = 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1		
		as_Erro = "Erro selecionar dados do produto: "+ SqlCa.SQLErrText
		Return False
		
	Case 100
		as_Erro = "O Produto '"+String(al_Produto)+"' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ em movimenta$$HEX2$$e700e300$$ENDHEX$$o."
		Return False	
End Choose

Return True
end function

public function boolean wf_destino (string id_tipo_movimento, ref string as_endereco_destino, ref string as_erro);String ls_Cd_Parametro

Choose Case id_Tipo_Movimento
	
	Case 'O'	//	Almoxarifado 'E'
		ls_Cd_Parametro = "CD_ENDERECO_SEGREGADO_RECEBIMENTO_ALMOX"
	
	Case "A"	//	Avaria 'R'
		ls_Cd_Parametro = "CD_ENDERECO_SEGREGADO_RECEBIMENTO_AVARIA"
		
	Case 'D'	//	Diverg$$HEX1$$ea00$$ENDHEX$$ncias 'E'
		ls_Cd_Parametro = "CD_ENDERECO_SEGREGADO_RECEBIMENTO_DIVERG"
		
	Case "F"	//	Falta 'R'
		ls_Cd_Parametro = "CD_ENDERECO_SEGREGADO_RECEBIMENTO_FALTA"
		
	Case "L"	//	Licita$$HEX2$$e700e300$$ENDHEX$$o 'E'
		ls_Cd_Parametro = "CD_ENDERECO_SEGREGADO_RECEBIMENTO_LICITA "
		
	Case 'M'	//	Marketing 'E'
		ls_Cd_Parametro = "CD_ENDERECO_SEGREGADO_RECEBIMENTO_MKT"

	Case 'P'	//	Pedido Urg$$HEX1$$ea00$$ENDHEX$$nte 'E'
		ls_Cd_Parametro = "CD_ENDERECO_SEGREGADO_RECEBIMENTO_PEDIDO"
		
	Case "V"	//	Vencido 'R'
		ls_Cd_Parametro = "CD_ENDERECO_SEGREGADO_RECEBIMENTO_VENCID"	

	Case 'X'	//	Outros 'R'
		ls_Cd_Parametro = "CD_ENDERECO_SEGREGADO_RECEBIMENTO_OUTROS"
		
	Case 'B'	//	Balaceamento'E'
		ls_Cd_Parametro = "CD_ENDERECO_SEGREGADO_RECEBIMENTO_BALANC"
		
End Choose

Select vl_parametro
Into :as_Endereco_Destino
From wms_parametro
Where cd_parametro = :ls_Cd_Parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		as_Erro = "Erro no select da wms_parametro: "+SqlCa.SQLErrText
		Return False
	Case 100
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o valor do par$$HEX1$$e200$$ENDHEX$$metro '" + ls_Cd_Parametro + "'."
		Return False
End Choose

Return True
end function

public function boolean wf_inclui_segregado_recebimento (long al_qtde_movimento, string as_endereco);Long ll_Controle

String ls_MSG

Select nr_controle
Into :ll_Controle
From wms_segregado_recebimento
Where cd_endereco 	= :as_endereco
	and cd_produto		= :il_Produto
	and nr_lote			= :is_Lote
	and dh_validade		= :idh_Validade
	and cd_fornecedor	is null
	and nr_nf				is null
	and de_especie		is null
	and de_serie			is null
Using SqlCa;

Choose Case Sqlca.SqlCode
	Case 0
		
		UPDATE wms_segregado_recebimento  
		Set qt_lote = qt_lote + :al_qtde_movimento
		Where nr_controle = :ll_Controle
		Using SqlCa;
		
		If Sqlca.SqlCode = -1 Then
			ls_MSG = "Erro ao atualizar a quantidade do lote do produto '" + String(il_Produto) + "' na tabela wms_segregado_recebimento '" + SQLCA.SQLErrText + "'."
			SqlCa.of_Rollback();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
			Return False
		End If
				
	Case 100
		
		INSERT INTO wms_segregado_recebimento  (cd_endereco, cd_produto, nr_lote, dh_validade, qt_lote )  
		VALUES ( :as_endereco, :il_produto, :is_lote, :idh_Validade, :al_qtde_movimento)
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_MSG = "Inclus$$HEX1$$e300$$ENDHEX$$o do lote na tabela wms_segregado_receb_liberado '" + SQLCA.SQLErrText + "'."
			SqlCa.of_RollBack()
			MessageBox("Erro", ls_MSG, StopSign!)
			Return False
		End If
		
	Case -1
		ls_MSG = "Inclus$$HEX1$$e300$$ENDHEX$$o do lote na tabela wms_segregado_receb_liberado '" + SQLCA.SQLErrText + "'."
		SqlCa.of_RollBack()
		MessageBox("Erro", ls_MSG, StopSign!)
		Return False
		
End Choose


Return True

end function

public function boolean wf_diminui_segregado (long al_qtde_movimento, string as_endereco);Long ll_Controle

String ls_MSG

Select nr_controle
Into :ll_Controle
From wms_segregado_recebimento
Where cd_endereco 	= :as_endereco
	and cd_produto		= :il_Produto
	and nr_lote			= :is_Lote
	and dh_validade	= :idh_Validade
Using SqlCa;

Choose Case Sqlca.SqlCode
	Case 0
		
		UPDATE wms_segregado_recebimento  
		Set qt_lote = qt_lote - :al_qtde_movimento
		Where nr_controle = :ll_Controle
		Using SqlCa;
		
		If Sqlca.SqlCode = -1 Then
			ls_MSG = "Erro ao atualizar a quantidade do lote do produto '" + String(il_Produto) + "' na tabela wms_segregado_recebimento '" + SQLCA.SQLErrText + "'."
			SqlCa.of_Rollback();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
			Return False
			
		Else
			Delete from wms_segregado_recebimento  
			Where nr_controle = :ll_Controle
				and qt_lote 			= 0
			Using SqlCa;
			
			If Sqlca.SqlCode = -1 Then
				ls_MSG = "Erro excluir o produto '" + String(il_Produto) + "' na tabela wms_segregado_recebimento '" + SQLCA.SQLErrText + "'."
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG)
				Return False
			End If
			
		End If
				
	Case 100

		ls_MSG = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o n$$HEX1$$fa00$$ENDHEX$$mero de controle da tabela wms_segregado_receb_liberado para diminuir o saldo do segregado do endere$$HEX1$$e700$$ENDHEX$$o "+as_endereco+"."
		SqlCa.of_RollBack()
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
		Return False
		
	Case -1
		ls_MSG = "Erro ao localizar o n$$HEX1$$fa00$$ENDHEX$$mero de controle da tabela wms_segregado_receb_liberado '" + SQLCA.SQLErrText + "'."
		SqlCa.of_RollBack()
		MessageBox("Erro", ls_MSG, StopSign!)
		Return False
		
End Choose


Return True

end function

public function boolean wf_localiza_saldo_momento_wms (long al_produto, string as_endereco, string as_lote, long al_cx_padrao, date adt_validade, long al_qtd_formulario);Long  ll_saldo_atual
String lvs_msg

SetNull(lvs_msg) 
ll_saldo_atual = 0 

Select sum(qt_saldo)
Into :ll_saldo_atual
From wms_localizacao
Where cd_produto=:al_produto
And cd_endereco=:as_endereco
And nr_lote=:as_lote
And qt_caixa_padrao=:al_cx_padrao
And dh_validade=:adt_validade
Using SqlCA;

Choose Case SqlCa.SqlCode
	Case -1
		lvs_msg = "Erro ao Localizar: Produto:"+String(al_produto)+" Endereco:"+String(as_endereco)+" Lote:"+String(as_lote)+" Validade:"+String(adt_validade)
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_msg)
		Return False
	Case 100
		lvs_msg = "N$$HEX1$$e300$$ENDHEX$$o Localizado Saldo: Produto:"+String(al_produto)+" Endereco:"+String(as_endereco)+" Lote:"+String(as_lote)+" Validade:"+String(adt_validade)
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_msg)
		Return False
	Case 0
		If ll_saldo_atual >=al_qtd_formulario Then 
			Return True 
		Else	
			lvs_msg = "O endere$$HEX1$$e700$$ENDHEX$$o selecionado est$$HEX1$$e100$$ENDHEX$$ com saldo diferente do que era quando selecionado. Favor cancelar o processo, recarregar a tela e tentar novamente."
			SqlCa.of_Rollback();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_msg)
			Return False
		End If 
End Choose
end function

on w_ge558_segregado.create
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

on w_ge558_segregado.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;call super::open; st_ge558_dados_produto lst_Produto


lst_Produto = Message.PowerObjectParm	

dw_1.Object.cd_produto[1] 				=	lst_Produto.cd_produto
dw_1.Object.de_produto[1] 				=	lst_Produto.de_produto
dw_1.Object.qt_caixa_padrao[1] 		=	lst_Produto.qt_caixa_padrao
dw_1.Object.qt_movimento[1] 			=	lst_Produto.qt_movimento
il_Produto										= 	lst_Produto.cd_produto
is_Endereco_Origem							=	lst_Produto.cd_endereco_origem
is_Lote											=	lst_Produto.nr_lote
idh_Validade									=	lst_Produto.dh_validade
il_Sequencial									=	lst_Produto.nr_sequencial
is_tipo_segregado							=	lst_Produto.id_tipo_segregado

If is_tipo_segregado = 'R' then
	dw_1.Modify("id_tipo_movimento.Values = 'AVARIA~tA/FALTA~tF/VENCIDO~tV/OUTROS~tX'")
Else
	dw_1.Modify("id_tipo_movimento.Values = 'ALMOXARIFADO~tO/DIVERG$$HEX1$$ca00$$ENDHEX$$NCIAS~tD/LICITA$$HEX2$$c700c300$$ENDHEX$$O~tL/MARKETING~tM/PEDIDO URGENTE~tP/BALANCEAMENTO~tB'")
End If

If Not IsNull(idh_Validade) and idh_Validade <> DateTime('2099-12-31') Then
	idh_Validade	= DateTime(String(idh_Validade, '01/mm/yyyy'))
End If

il_Qt_Movimento_Original = lst_Produto.qt_movimento

is_Matricula = gvo_aplicacao.ivo_seguranca.nr_matricula


end event

type cb_2 from commandbutton within w_ge558_segregado
integer x = 1157
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

event clicked;uo_ge258_movimentacao lo_Movimentacao

Long 	ll_Qt_Movimento,&
			ll_Produto,&
			ll_Cx_Padrao,&
			ll_Qt_Movimentada,&
			ll_Nr_Movimentacao,&
			ll_Nulo,&
			ll_Qt_Segregado
					
String 	ls_Tipo_Movimento,&
			ls_Endereco_Entrada,&
			ls_Erro,&
			ls_Endereco_Destino,&
			ls_Nulo,&
			ls_Erro_End_Bloq
			
If  MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a movimenta$$HEX2$$e700e300$$ENDHEX$$o do produto?", Question!, YesNo!, 2) = 2 Then
	Return	
End If			

dw_1.AcceptText()

ll_Qt_Movimento 	= dw_1.Object.qt_movimento[1]
ls_Tipo_Movimento 	= dw_1.Object.id_tipo_movimento[1]
ll_Produto				= dw_1.Object.cd_produto[1]
ll_Cx_Padrao			= dw_1.Object.qt_caixa_padrao[1]
ll_Qt_Movimentada	= dw_1.Object.qt_movimento[1]

If Not f_ge558_permite_movimento_produto(is_Endereco_Origem,  ll_Produto)Then
	Return 
End If

SetNull(ll_Nulo)
SetNull(ls_Nulo)

If ll_Qt_Movimento > il_Qt_Movimento_Original Then
	MessageBox("Aviso", "A quantidade movimentada n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que "+String(il_Qt_Movimento_Original))
	dw_1.Object.qt_movimento[1] = il_Qt_Movimento_Original
	dw_1.Event ue_Pos(1, "qt_movimento")
	Return
End If

If isnull(ls_Tipo_Movimento) or  ls_Tipo_Movimento = '' Then
	MessageBox("Aviso", "Informe o tipo do movimento.")
	dw_1.Event ue_Pos(1, "id_tipo_movimento")
	Return
End If

// Tratativa
If ll_Qt_Movimento < 1 Then 
	MessageBox("Aviso", "A quantidade movimentada n$$HEX1$$e300$$ENDHEX$$o pode ser NEGATIVA/ZERO")
	dw_1.Object.qt_movimento[1] = il_Qt_Movimento_Original
	dw_1.Event ue_Pos(1, "qt_movimento")
	Return
End If

Try
	lo_Movimentacao = Create uo_ge258_movimentacao
	
	lo_Movimentacao.ivb_Commit = False
	
	If Not wf_Destino(ls_Tipo_Movimento, Ref ls_Endereco_Destino, Ref ls_Erro) Then
		SqlCa.of_Rollback()
		MessageBox("Aviso", ls_Erro)
		Return
	End If
	
	ll_Qt_Segregado = ll_Qt_Movimentada * ll_Cx_Padrao
	
	If Not wf_Inclui_Segregado_Recebimento(ll_Qt_Segregado, ls_Endereco_Destino) Then Return
	
	//Verifica se $$HEX1$$e900$$ENDHEX$$ bairro SEGREG. RECEBIMENTO
	If Mid(is_Endereco_Origem, 1, 1) = "A" Then
		If Not wf_Diminui_Segregado(ll_Qt_Segregado, is_Endereco_Origem) Then Return
	End If
	
	//Valida$$HEX2$$e700e300$$ENDHEX$$o se endere$$HEX1$$e700$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ bloqueado
	If Not gf_Verifica_Endereco_Bloqueado(is_Endereco_Origem, Ref ls_Erro_End_Bloq) Then 
		SqlCa.of_Rollback()
		Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o',ls_Erro_End_Bloq)
		Return 
	End If
	
	
	//Valida$$HEX2$$e700e300$$ENDHEX$$o se endere$$HEX1$$e700$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ bloqueado
	If Not gf_Verifica_Endereco_Bloqueado(ls_Endereco_Destino, Ref ls_Erro_End_Bloq) Then 
		SqlCa.of_Rollback()
		Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o',ls_Erro_End_Bloq)
		Return 
	End If
	
	// Valida Saldo Momento Endere$$HEX1$$e700$$ENDHEX$$o de Origem
	If Not wf_localiza_saldo_momento_wms (ll_Produto,&
														is_Endereco_Origem,&
														is_Lote,&
														ll_Cx_Padrao,&
														Date(idh_Validade),& 
														ll_Qt_Movimentada) Then
		Return 
	End If 									
	
	

	
	SetNull(ls_Endereco_Entrada)
	If Not lo_Movimentacao.of_insere_movimentacao(		ls_Endereco_Entrada,&
																		is_Endereco_Origem,&
																		ll_Produto,&
																		ll_Cx_Padrao,&
																		is_Lote,&
																		Date(idh_Validade),&
																		ll_Qt_Movimentada,&
																		"S",&
																		ll_Nulo,&
																		ls_Nulo,&
																		ll_Nulo,&
																		ls_Nulo,&
																		ls_Nulo,&
																		is_Matricula,&
																		il_Sequencial) Then
		SqlCa.of_Rollback()
		Return
	End If	
	
	
	If Not wf_Nr_Movimentacao(ll_Produto, ll_Cx_Padrao, Ref ll_Nr_Movimentacao, Ref ls_Erro) Then
		SqlCa.of_Rollback()
		MessageBox("Aviso", ls_Erro)
		Return
	End If
	
	If is_Endereco_Origem = ls_Endereco_Destino Then
		SqlCa.of_Rollback()
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esse produto j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ no segregado recebimento.")
		Return 
	End If
	
	If Not lo_Movimentacao.of_Atualiza_Movimentacao(	ls_Endereco_Destino,&
																		ll_Produto,&
																		ll_Nr_Movimentacao,&
																		ll_Qt_Movimentada,&
																		is_Lote,&
																		ll_Cx_Padrao,&
																		idh_Validade) Then
		SqlCa.of_Rollback()
		Return 
	End If
	
	SqlCa.of_Commit()
	MessageBox("Aviso", "Movimento confirmado.")
	Close(Parent)
Finally
	Destroy(lo_Movimentacao)	
End Try	
end event

type cb_1 from commandbutton within w_ge558_segregado
integer x = 1618
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

event clicked;If  MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja cancelar e sair da tela?", Question!, YesNo!, 2) = 1 Then
	Close(Parent)	
End If
end event

type dw_1 from dc_uo_dw_base within w_ge558_segregado
integer x = 37
integer y = 68
integer width = 1957
integer height = 332
string dataobject = "dw_ge558_segregado"
end type

event constructor;String lvs_DataObject

This.of_SetTransObject(SqlCa)

lvs_DataObject = This.DataObject

If Trim(This.DataObject) <> "" Then
	ivs_SQL_Original = This.Object.DataWindow.Table.Select
End If

ivo_Controle_Menu = Create dc_uo_Menu_DW

ivo_Controle_Menu.of_SetDW(This)

SetNull(ivm_Menu)

This.of_GetParentWindow()

//Habilita aux$$HEX1$$ed00$$ENDHEX$$lio visual?
If gvo_aplicacao.ivb_Usa_Aux_Visual Then This.of_habilita_aux_visual()
end event

type gb_1 from groupbox within w_ge558_segregado
integer x = 18
integer width = 2011
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

