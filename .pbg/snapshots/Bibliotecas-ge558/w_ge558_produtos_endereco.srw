HA$PBExportHeader$w_ge558_produtos_endereco.srw
forward
global type w_ge558_produtos_endereco from dc_w_cadastro_selecao_lista
end type
type cb_1 from commandbutton within w_ge558_produtos_endereco
end type
type dw_3 from dc_uo_dw_base within w_ge558_produtos_endereco
end type
type cb_2 from commandbutton within w_ge558_produtos_endereco
end type
type cb_3 from commandbutton within w_ge558_produtos_endereco
end type
type cb_4 from commandbutton within w_ge558_produtos_endereco
end type
type st_1 from statictext within w_ge558_produtos_endereco
end type
type cb_5 from commandbutton within w_ge558_produtos_endereco
end type
type cb_6 from commandbutton within w_ge558_produtos_endereco
end type
type cb_7 from commandbutton within w_ge558_produtos_endereco
end type
type gb_3 from groupbox within w_ge558_produtos_endereco
end type
end forward

global type w_ge558_produtos_endereco from dc_w_cadastro_selecao_lista
string tag = "w_ge558_produtos_endereco"
integer width = 4549
integer height = 2604
string title = "GE558 - Consulta de Produtos por Endere$$HEX1$$e700$$ENDHEX$$o"
cb_1 cb_1
dw_3 dw_3
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
st_1 st_1
cb_5 cb_5
cb_6 cb_6
cb_7 cb_7
gb_3 gb_3
end type
global w_ge558_produtos_endereco w_ge558_produtos_endereco

type variables
uo_produto ivo_Produto

String is_Fornecedor

Long il_Nota

String is_Endereco_Recebimento, is_cd_endereco_agrupamento, is_cd_endereco_transito

datawindowchild dddw

String is_Endereco_Geladeira
Boolean ib_inicio_controle_temp_rdc = False
end variables

forward prototypes
public subroutine wf_insere_bairro_default ()
public function boolean wf_endereco_recebimento ()
public subroutine wf_insere_esteira_default ()
public function boolean wf_produto_agrupado (string as_endereco_origem)
public function boolean wf_movimenta_para_pulmao (string as_endereco_flow, long al_sequencial_saida, long al_produto, long al_cx_padrao, string as_lote, datetime adt_validade, string as_operador, string as_endereco_pulmao, long al_qt_cx_pulmao, long al_cx_padrao_pulmao)
public function boolean wf_valida_produto_endereco_destino (string as_endereco_pulmao, long al_produto, long al_cx_padrao, string as_lote, datetime adh_validade)
public function boolean wf_gera_etiqueta (long al_produto, long al_cx_padrao, string as_lote, datetime adh_validade, ref long al_etiqueta)
public function boolean wf_valida_qtde_saida_flow (string as_endereco_flow, long al_produto, string as_lote, long al_qt_movimento)
public subroutine _documentacao ()
public function boolean wf_busca_endereco_segregado_agrupamento ()
public function boolean wf_busca_endereco_segregado_transito ()
public function boolean wf_valida_endereco_origem (string as_cd_endereco_origem)
public subroutine wf_filtra_filial ()
public subroutine wf_verifica_acesso_tela ()
end prototypes

public subroutine wf_insere_bairro_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        	lvi_Row

If dw_1.GetChild("cd_bairro", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_bairro", "T")
	lvdwc.SetItem(1, "nm_bairro", "TODOS")
	lvdwc.SetItem(1, "cd_filial", gl_cd_filial)
	
	dw_1.Object.cd_bairro[1] = "T"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do BAIRRO.")
End If
end subroutine

public function boolean wf_endereco_recebimento ();Select vl_parametro
Into :is_Endereco_Recebimento
From wms_parametro
Where cd_parametro = 'CD_ENDERECO_RECEBIMENTO_LIBERADO'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		MessageBox("Erro", "Erro no select da wms_parametro: "+SqlCa.SQLErrText)
		Return False
	Case 100
		MessageBox("Aviso", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o valor do par$$HEX1$$e200$$ENDHEX$$metro 'CD_ENDERECO_RECEBIMENTO_LIBERADO'.")
		Return False
End Choose

Return True
end function

public subroutine wf_insere_esteira_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        	lvi_Row
Long ll_Null

SetNull(ll_Null)

If dw_1.GetChild("cd_esteira", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_esteira", ll_Null)
	lvdwc.SetItem(1, "de_esteira", "TODAS")
	
	dw_1.Object.cd_esteira[1] = ll_Null
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do BAIRRO.")
End If
end subroutine

public function boolean wf_produto_agrupado (string as_endereco_origem);String ls_Endereco_Agrupamento

Select vl_parametro
Into :ls_Endereco_Agrupamento
from wms_parametro 
where cd_parametro = 'CD_ENDERECO_SEGREGADO_AGRUPAMENTO_DEV'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1 
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do endere$$HEX1$$e700$$ENDHEX$$o do segregado agrupamento.")
		Return False
End Choose

If as_Endereco_Origem = ls_Endereco_Agrupamento Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ em um agrupamento. Exclua o produto do agrupamento para moviment$$HEX1$$e100$$ENDHEX$$-lo.")
	Return False
End If

Return True
end function

public function boolean wf_movimenta_para_pulmao (string as_endereco_flow, long al_sequencial_saida, long al_produto, long al_cx_padrao, string as_lote, datetime adt_validade, string as_operador, string as_endereco_pulmao, long al_qt_cx_pulmao, long al_cx_padrao_pulmao);Long 	ll_Qt_Movimento,&
		ll_Nr_Movimentacao,&
		ll_Nulo,&
		ll_Sequencial_Entrada,&
		ll_Etiqueta

String	ls_Erro,&
		ls_Nulo

uo_ge258_movimentacao lo_Movimentacao

Try
	lo_Movimentacao = Create uo_ge258_movimentacao
	
	lo_Movimentacao.ivb_Commit = False
	
	SetNull(ls_Nulo)
	SetNull(ll_Nulo)
	ll_Qt_Movimento = al_qt_cx_pulmao * al_cx_padrao_pulmao
	
	If Not lo_Movimentacao.of_insere_movimentacao(		ls_Nulo,&
																		as_Endereco_Flow,&
																		al_Produto,&
																		al_cx_Padrao,&
																		as_Lote,&
																		Date(adt_validade),&
																		ll_Qt_Movimento,&
																		"X",&
																		ll_Nulo,&
																		ls_Nulo,&
																		ll_Nulo,&
																		ls_Nulo,&
																		ls_Nulo,&
																		as_Operador,&
																		al_Sequencial_Saida) Then
		SqlCa.of_Rollback()
		Return False
	End If	
	

	//Localiza o n$$HEX1$$fa00$$ENDHEX$$mero da movimenta$$HEX2$$e700e300$$ENDHEX$$o
	select Top 1	nr_movimentacao
	Into 		:ll_Nr_Movimentacao
	from wms_movimentacao
	where cd_produto 					= :al_Produto
	and	nr_matricula_responsavel 	= :as_Operador
	and 	cd_endereco_saida 			= :as_Endereco_Flow
	and 	nr_lote							= :as_Lote
	and	qt_caixa_padrao 				= :al_Cx_Padrao
	and 	dh_validade 					= :adt_Validade
	and nr_sequencial_saida				= :al_Sequencial_Saida
	and id_tipo_movimento 				= 'X'
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case -1		
			ls_Erro = "Erro selecionar o n$$HEX1$$fa00$$ENDHEX$$mero da movimenta$$HEX2$$e700e300$$ENDHEX$$o: "+ SqlCa.SQLErrText
			SqlCa.of_Rollback()
			MessageBox("Erro", ls_Erro)
			Return False
			
		Case 100
			ls_Erro = "O Produto '"+String(al_Produto)+"' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ em movimenta$$HEX2$$e700e300$$ENDHEX$$o."
			SqlCa.of_Rollback()
			MessageBox("Erro", ls_Erro)
			Return False	
	End Choose

	//Localiza o sequencial do endere$$HEX1$$e700$$ENDHEX$$o de destino
	Select top 1 nr_sequencial
	Into :ll_Sequencial_Entrada
	From wms_localizacao
	Where cd_endereco 		= :as_Endereco_Pulmao
		and cd_produto 		= :al_Produto
		and nr_lote				= :as_Lote
		and qt_caixa_padrao = :al_Cx_Padrao_Pulmao
		and dh_validade 		= :adt_Validade
	Order by nr_sequencial desc	
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode 	
		Case 100
			Select isnull(max(nr_sequencial), 0) + 1
			Into :ll_Sequencial_Entrada
			From wms_localizacao
			Where cd_endereco = :as_Endereco_Pulmao
			Using SqlCa;
			Choose Case SqlCa.SqlCode 
				Case -1
					ls_Erro = "Erro ao localizar o pr$$HEX1$$f300$$ENDHEX$$ximo sequencial: "+ SqlCa.SQLErrText
					SqlCa.of_Rollback()
					MessageBox("Erro", ls_Erro)
					Return False	
			End Choose
		Case -1
			ls_Erro = "Erro ao localizar o pr$$HEX1$$f300$$ENDHEX$$ximo sequencial: "+ SqlCa.SQLErrText
			SqlCa.of_Rollback()
			MessageBox("Erro", ls_Erro)
			Return False	
	End Choose
	
	//Atualiza a movimenta$$HEX2$$e700e300$$ENDHEX$$o
	Update wms_movimentacao
		set cd_endereco_entrada 	= :as_Endereco_Pulmao,
			nr_sequencial_entrada 	= :ll_Sequencial_Entrada,
			qt_movimento 				= :al_Qt_Cx_Pulmao,
			qt_caixa_padrao			= :al_Cx_Padrao_Pulmao
	where nr_movimentacao = :ll_Nr_Movimentacao
	Using SqlCa;
	
	If SqlCa.SqlCode = -1	 Then
		ls_Erro = "Erro ao atualizar a movimenta$$HEX2$$e700e300$$ENDHEX$$o :"+SqlCa.SQLErrText
		SqlCa.of_RollBack()
		MessageBox("Erro", ls_Erro)		
		Return False	
	End If


Finally
	Destroy(lo_Movimentacao)
End Try


If Not wf_Gera_Etiqueta(al_Produto, al_Cx_Padrao_Pulmao, as_Lote, adt_Validade, Ref ll_Etiqueta) Then
	Return False
End If

SqlCa.of_Commit()
MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto movimentado com sucesso.~rEtiqueta "+String(ll_Etiqueta)+".")
Return True
end function

public function boolean wf_valida_produto_endereco_destino (string as_endereco_pulmao, long al_produto, long al_cx_padrao, string as_lote, datetime adh_validade);Long ll_Qtde

Select  count(*)
Into :ll_Qtde
From wms_localizacao
where cd_endereco = :as_Endereco_Pulmao
	and cd_produto = :al_Produto
	and ((qt_caixa_padrao <> :al_Cx_Padrao) or(nr_lote <> :as_Lote) or (dh_validade <> :adh_Validade))
Using SqlCa;	

Choose Case SqlCa.SqlCode
	Case 0
		If ll_Qtde > 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "J$$HEX1$$e100$$ENDHEX$$ existe esse produto nesse endere$$HEX1$$e700$$ENDHEX$$o com outra caixa padr$$HEX1$$e300$$ENDHEX$$o ou com outro lote ou com outra validade.")
			Return False
		End If
		
	Case -1		
		MessageBox("Erro", "Erro ao validar o produto no endere$$HEX1$$e700$$ENDHEX$$o de destino: "+  SqlCa.SQLErrText)
		Return False	
End Choose

Return True
end function

public function boolean wf_gera_etiqueta (long al_produto, long al_cx_padrao, string as_lote, datetime adh_validade, ref long al_etiqueta);String ls_Erro

//Verifica se j$$HEX1$$e100$$ENDHEX$$ existe a etiqueta do produto
Select nr_etiqueta
Into :al_Etiqueta
From wms_etiqueta_produto
Where cd_produto = :al_Produto
	and qt_caixa_padrao = :al_Cx_Padrao
	and nr_lote				= :as_Lote
	and dh_validade		= :adh_Validade
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
		
	Case 100
		If f_ge558_proxima_etiqueta_produto(Ref al_Etiqueta) Then								
			Insert Into wms_etiqueta_produto(nr_etiqueta,	cd_produto, qt_caixa_padrao, nr_lote, dh_validade, id_flow_rack)
			Values(:al_Etiqueta,	:al_Produto, :al_Cx_Padrao, :as_Lote, :adh_Validade, 'N')
			Using SqlCa;
			
			If SqlCa.SqlCode  = -1 Then
				ls_Erro = SqlCa.SQLErrText
				SqlCa.of_Rollback()
				MessageBox("Erro", "Erro no insert da 'wms_etiqueta_produto', etiqueta "+String(al_Etiqueta)+": "+ls_Erro )								
				Return False	
			End If			
		End If
		
	Case -1
	ls_Erro = SqlCa.SQLErrText
	SqlCa.of_Rollback()
	MessageBox("Erro", "Erro ao verificar se j$$HEX1$$e100$$ENDHEX$$ existe a etiqueta: "+ls_Erro )								
	Return False	
End Choose
	

Return True
end function

public function boolean wf_valida_qtde_saida_flow (string as_endereco_flow, long al_produto, string as_lote, long al_qt_movimento);Long ll_Saldo

Select sum(qt_saldo) 
Into :ll_Saldo
from wms_localizacao
where cd_endereco	= :as_Endereco_Flow
	and cd_produto		= :al_Produto
	and nr_lote			= :as_Lote
Using SqlCa;	

If SqlCa.SqlCode = -1 Then
	MessageBox("Erro", "Erro ao verificar o saldo do produto e lote no flow rack: "+  SqlCa.SQLErrText)
	Return False	
End If

If ll_Saldo < al_qt_movimento Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade m$$HEX1$$e100$$ENDHEX$$xima do lote '"+as_Lote+"' do produto "+String(al_produto)+" $$HEX1$$e900$$ENDHEX$$ "+String(ll_Saldo)+".")
	Return False	
End If

Return True
end function

public subroutine _documentacao ();/*Tela utilizada para listar os endere$$HEX1$$e700$$ENDHEX$$os da wms_localizacao, permite gerar planilha e o relat$$HEX1$$f300$$ENDHEX$$rio em PDF

	Tabelas principais: wms_localizacao, vw_wms_endereco

*/
end subroutine

public function boolean wf_busca_endereco_segregado_agrupamento ();Select vl_parametro
  Into :is_cd_endereco_agrupamento
  From wms_parametro 
 Where cd_parametro = 'CD_ENDERECO_SEGREGADO_AGRUPAMENTO_DEV'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1 
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar par$$HEX1$$e200$$ENDHEX$$metro CD_ENDERECO_SEGREGADO_AGRUPAMENTO_DEV na tabela wms_parametro.~r~rErro: ' + SQLCA.SQLErrText, StopSign!)
		Return False
	Case 100
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro CD_ENDERECO_SEGREGADO_AGRUPAMENTO_DEV n$$HEX1$$e300$$ENDHEX$$o localizado na tabela wms_parametro.', StopSign!)
		Return False
End Choose

Return True
end function

public function boolean wf_busca_endereco_segregado_transito ();Select vl_parametro
  Into :is_cd_endereco_transito
  From wms_parametro 
 Where cd_parametro = 'CD_ENDERECO_SEGREGADO_MERCADORIA_TRANSIT'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1 
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar par$$HEX1$$e200$$ENDHEX$$metro CD_ENDERECO_SEGREGADO_MERCADORIA_TRANSIT na tabela wms_parametro.~r~rErro: ' + SQLCA.SQLErrText, StopSign!)
		Return False
	Case 100
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro CD_ENDERECO_SEGREGADO_MERCADORIA_TRANSIT n$$HEX1$$e300$$ENDHEX$$o localizado na tabela wms_parametro.', StopSign!)
		Return False
End Choose

Return True
end function

public function boolean wf_valida_endereco_origem (string as_cd_endereco_origem);String 	ls_bairro

if as_cd_endereco_origem = is_cd_endereco_agrupamento then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel movimentar um produto do endere$$HEX1$$e700$$ENDHEX$$o de AGRUPAMENTO desta tela, favor procurar respons$$HEX1$$e100$$ENDHEX$$vel pelo setor de segregado para ajustar.', StopSign!)
	Return False
end if

if as_cd_endereco_origem = is_cd_endereco_transito then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel movimentar um produto do endere$$HEX1$$e700$$ENDHEX$$o de TRANSITO desta tela, favor procurar respons$$HEX1$$e100$$ENDHEX$$vel pelo setor de recebimento de devolu$$HEX2$$e700e300$$ENDHEX$$o de loja para ajustar.', StopSign!)
	Return False
end if

SELECT cd_bairro
  INTO :ls_bairro
  FROM wms_endereco
 WHERE cd_endereco = :as_cd_endereco_origem
 USING SQLCA;

Choose Case SQLCA.SqlCode
	case is < 0
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar o bairro do endere$$HEX1$$e700$$ENDHEX$$o ' + as_cd_endereco_origem + '.~r~rErro: ' + SQLCA.SQLErrText, StopSign!)
		Return False
	Case 100
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Endere$$HEX1$$e700$$ENDHEX$$o ' + as_cd_endereco_origem + ' n$$HEX1$$e300$$ENDHEX$$o localizado na tabela wms_endereco.', StopSign!)
		Return False
End Choose

If ls_bairro = 'A' then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido movimentar produtos do bairro A (SEGREG. EXPEDICAO) para o flow atrav$$HEX1$$e900$$ENDHEX$$s desta tela.', StopSign!)
	Return False
End if

Return True
end function

public subroutine wf_filtra_filial ();DataWindowChild	ldwcAux
 
dw_1.GetChild ('cd_bairro', ldwcAux)
 
ldwcAux.SetFilter ("wb.cd_filial = " + String (gl_cd_filial))
ldwcAux.Filter()

Return
end subroutine

public subroutine wf_verifica_acesso_tela ();If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> "WS" or gl_cd_filial <> 534 Then
	cb_1.Visible = False
	cb_3.Visible = False
	cb_4.Visible = False
	cb_5.Visible = False
	cb_6.Visible = False
	cb_7.Visible = False
	gb_3.Visible	= False
	dw_1.Object.id_listar_produtos_bloqueados.Visible = False
	dw_1.Object.id_listar_bloqueados.Visible = False
End If

end subroutine

on w_ge558_produtos_endereco.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_3=create dw_3
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.st_1=create st_1
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cb_7=create cb_7
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.cb_4
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.cb_5
this.Control[iCurrent+8]=this.cb_6
this.Control[iCurrent+9]=this.cb_7
this.Control[iCurrent+10]=this.gb_3
end on

on w_ge558_produtos_endereco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.st_1)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.gb_3)
end on

event ue_postopen;//OverRide

String lvs_data, ls_Erro
DateTime ldt_data

 dw_3.Visible = False

ivo_dbError = Create dc_uo_dbError

dw_1.Event ue_AddRow()
dw_1.SetFocus()

wf_Insere_Bairro_Default()
wf_Insere_Esteira_Default()
wf_Verifica_Acesso_Tela()

This.ivm_Menu.mf_Recuperar(True)

This.ivm_Menu.ivb_Permite_Imprimir = true

ivo_Produto = Create uo_Produto

If Not wf_Endereco_Recebimento() Then
	Close(This)
End If

If Not wf_busca_endereco_segregado_transito() Then
	Close(This)
End If

If Not wf_busca_endereco_segregado_agrupamento() Then
	Close(This)
End If

ldt_data	= gf_getserverdate()
lvs_data	= String(ldt_data, 'dd/mm/yy hh:mm') 
st_1.text	= lvs_data

dw_1.GetChild('cd_bairro', dddw)

ib_inicio_controle_temp_rdc = gf_inicio_controle_temp_rdc()

If Not gf_localiza_endereco_wms_parametro('CD_ENDERECO_SEGREGADO_RECEBIMENTO_GELAD', Ref is_Endereco_Geladeira, Ref ls_Erro) Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o',ls_Erro)
	Close(This)
End If


end event

event close;call super::close;
Destroy(ivo_Produto)
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge558_produtos_endereco
integer y = 1292
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge558_produtos_endereco
integer y = 1220
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge558_produtos_endereco
integer x = 59
integer y = 52
integer width = 1728
integer height = 464
string dataobject = "dw_ge558_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.cd_produto	[1] = ivo_Produto.cd_produto
				This.Object.nm_produto	[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
			End If
	End Choose
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Reset()
Parent.ivm_Menu.mf_salvarcomo(False)
Parent.ivm_Menu.mf_imprimir(False)
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Reset()
Parent.ivm_Menu.mf_salvarcomo(False)
Parent.ivm_Menu.mf_imprimir(False)

Choose Case dwo.Name
	Case "nm_produto"
		If Not IsNull(Data) and Trim(Data) <> '' Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque	Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.cd_produto[1] = ivo_Produto.cd_produto
			This.Object.Nm_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque		
		End If
			
End Choose

end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Produto) Then
	This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
	This.Object.Nm_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
End If
end event

event dw_1::ue_print;//OverRide

dw_3.Print()
end event

event dw_1::ue_preprint;//OverRide

Long lvl_Linhas

If IsValid(ivds_Relatorio) Then
	lvl_Linhas = ivds_Relatorio.RowCount()
Else
	lvl_Linhas = dw_3.RowCount()
End If

Return lvl_Linhas
end event

event dw_1::ue_printimmediate;//OverRide

Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas = dw_3.Event ue_PrePrint()

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		dw_3.of_Print(True)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
	End If
End If

SetPointer(Arrow!)
end event

event dw_1::ue_addrow;call super::ue_addrow;If AncestorReturnValue = 1 Then
	wf_filtra_filial()
End If

Return AncestorReturnValue
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge558_produtos_endereco
integer y = 572
integer width = 4457
integer height = 1828
string text = "Posi$$HEX2$$e700e300$$ENDHEX$$o de:"
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge558_produtos_endereco
integer y = 4
integer width = 1769
integer height = 540
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge558_produtos_endereco
integer x = 69
integer y = 640
integer width = 4411
integer height = 1748
string dataobject = "dw_ge558_lista"
end type

event dw_2::ue_recuperar;//OverRide
String 	ls_Bairro,&
			ls_Endereco,&
			ls_Negativo,&
			ls_Controlado,&
			ls_Listar_Bloqueados,&
			ls_id_tipo_segregado,&
			ls_Listar_Produtos_Bloqueados

Long 	ll_Produto,&
		ll_Esteira

dw_1.AcceptText()

//Limpa Filtros Anteriores
dw_2.SetFilter("")

ls_Bairro 						= dw_1.Object.cd_bairro				[1]
ls_Endereco 				= Trim(dw_1.Object.cd_endereco		[1])
ll_Produto					= dw_1.Object.cd_produto				[1]
ls_Negativo  				= dw_1.Object.id_negativo				[1]
ls_Controlado				= dw_1.Object.id_controlado			[1]
ll_Esteira						= dw_1.Object.cd_esteira				[1]
ls_Listar_Bloqueados		= dw_1.Object.id_listar_bloqueados	[1]
ls_Listar_Produtos_Bloqueados	= dw_1.Object.id_listar_produtos_bloqueados	[1]

If dddw.getrow() > 0 then
	ls_id_tipo_segregado = dddw.describe("evaluate('id_tipo_segregado', " + string(dddw.getrow()) + ")")
End if

If Not IsNull(ls_Bairro) and ls_Bairro <> 'T' Then
	This.of_appendwhere_subquery("v.cd_bairro = '" + ls_Bairro + "'", 12)
End If

If Not IsNull(ls_Endereco) and ls_Endereco <> '' Then
	This.of_appendwhere_subquery("v.cd_endereco = '" + ls_Endereco + "'", 12)
End If

If Not IsNull(ll_Produto) Then
	This.of_appendwhere_subquery("w.cd_produto = " + String(ll_Produto) , 12)
End If

If ls_Controlado = 'S'  Then
	This.of_appendwhere_subquery("g.cd_grupo_psico is not null" , 12)
End If

If Not IsNull(ls_Negativo) and ls_Negativo =  'S' Then
	This.of_appendwhere_subquery("w.qt_saldo < 0", 12)
End If

If Not IsNull(ll_Esteira) Then
	//This.of_appendwhere_subquery("d.cd_esteira = "+String(ll_Esteira), 2)
	This.of_appendwhere_subquery("w.cd_produto in (select x.cd_produto from wms_endereco_produto x where cd_esteira = "+String(ll_Esteira)+")", 12)
End If

If Not IsNull(ls_Listar_Bloqueados) and ls_Listar_Bloqueados =  'S' Then
	This.of_appendwhere_subquery("(SELECT dbo.wms_retorna_end_bloqueado(w.cd_endereco)) = 'S'", 12)
End If

If Not IsNull(ls_Listar_Produtos_Bloqueados) and ls_Listar_Produtos_Bloqueados =  'S' Then
	This.of_appendwhere_subquery("w.id_bloqueado = 'S'", 12)
End If

If ls_Bairro = 'A' Then
	This.of_appendwhere_subquery("v.id_tipo_segregado = '" + ls_id_tipo_segregado + "'" , 12)
End If

Return This.Retrieve(gl_cd_filial)
end event

event dw_2::ue_postretrieve;// OverRide

Boolean	lvb_Classificar, &
        	    lvb_Filtrar, &
		  	lvb_Localizar, &
		  	lvb_Excluir

If pl_Linhas > 0 Then	
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	This.sharedata(dw_3)
	
	This.SetRow(1)
	This.SetFocus()
	Parent.ivm_Menu.mf_salvarcomo(True)
	This.ivm_Menu.mf_Imprimir(True)
	
	This.of_SetRowSelection("", "if(id_bloqueado = ~"SIM~", RGB(255,0, 0), RGB(0,0,0))")
	
Else
	Parent.ivm_Menu.mf_salvarcomo(False)
	This.ivm_Menu.mf_Imprimir(False)
	If pl_Linhas = 0 Then		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)		
	End If
End If

Parent.ivm_Menu.mf_Classificar(lvb_Classificar)
Parent.ivm_Menu.mf_Filtrar(lvb_Filtrar)
Parent.ivm_Menu.mf_Localizar(lvb_Localizar)
//Parent.ivm_Menu.mf_Excluir(lvb_Excluir)

Return pl_Linhas
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;String ls_Endereco

If currentRow > 0 Then
	dw_2.AcceptText()
	
	//cb_1.Enabled = True
	
	ls_Endereco = dw_2.Object.cd_endereco[currentRow]

//	If ls_Endereco = is_Endereco_Recebimento Then
//		cb_1.Enabled = True
//	Else
//		cb_1.Enabled = False
//	End If
	
	If dw_2.Object.id_movimenta_avaria [currentRow] = 'S' then
		cb_5.Enabled = True
	else
		cb_5.Enabled = False
	End if
	
	If dw_2.Object.id_bairro_flow [currentRow] = 'S' then
		cb_7.Enabled = False
	else
		cb_7.Enabled = True
	End if
	
End If
	


end event

event dw_2::constructor;call super::constructor;ivb_ordena_colunas = True
end event

event dw_2::ue_print;//OverRide

dw_3.Print()
end event

event dw_2::ue_preprint;//OverRide

Long lvl_Linhas

If IsValid(ivds_Relatorio) Then
	lvl_Linhas = ivds_Relatorio.RowCount()
Else
	lvl_Linhas = dw_3.RowCount()
End If

Return lvl_Linhas
end event

event dw_2::ue_printimmediate;//OverRide

Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas = dw_3.Event ue_PrePrint()

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		dw_3.of_Print(True)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
	End If
End If

SetPointer(Arrow!)


end event

event dw_2::ue_retrieve;call super::ue_retrieve;wf_verifica_acesso_tela()

Return 1


end event

type cb_1 from commandbutton within w_ge558_produtos_endereco
integer x = 1966
integer y = 324
integer width = 1157
integer height = 116
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Movimentar para Segregado Recebimento"
end type

event clicked;st_ge558_dados_produto lst_Produto
Long		ll_Row
String	ls_Endereco, ls_Erro

dw_2.AcceptText()

ll_Row = dw_2.GetRow( )

If ll_Row > 0 Then
	
	ls_Endereco = dw_2.Object.cd_endereco[ll_Row]
	
	If ib_inicio_controle_temp_rdc Then
		If is_Endereco_Geladeira = ls_Endereco Then 
			MessageBox("Aviso", "Movimenta$$HEX2$$e700e300$$ENDHEX$$o a partir do endere$$HEX1$$e700$$ENDHEX$$o: " + is_Endereco_Geladeira + ", n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitida!")
			Return 1
		End If
	End If
	
	If Not wf_Produto_Agrupado(ls_Endereco) Then
		Return 1
	End If
	
	If ls_Endereco <> is_Endereco_Recebimento Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ no recebimento.~rDeseja movimentar para o segregado do recebimento?", Question!, YesNo!, 2) = 2 Then
			Return 1	
		End If
	End If
	
	If Not wf_valida_endereco_origem(ls_Endereco) Then
		Return 1
	End If
	
	lst_Produto.cd_produto 						= dw_2.Object.cd_produto			[ll_Row]
	lst_Produto.de_produto 						= dw_2.Object.de_produto			[ll_Row]
	lst_Produto.qt_caixa_padrao 				= dw_2.Object.qt_caixa_padrao	[ll_Row]
	lst_Produto.qt_movimento 					= dw_2.Object.qt_saldo				[ll_Row]
	lst_Produto.cd_endereco_origem 			= dw_2.Object.cd_endereco			[ll_Row]
	lst_Produto.nr_lote								= dw_2.Object.nr_lote					[ll_Row]
	lst_Produto.dh_validade						= dw_2.Object.dh_validade			[ll_Row]
	lst_Produto.nr_sequencial					= dw_2.Object.nr_sequencial		[ll_Row]
	lst_Produto.id_tipo_segregado				= 'R'
	
	If Not f_ge558_permite_movimento_produto(ls_Endereco,  lst_Produto.cd_produto)Then
		Return 1
	End If
	
	OpenWithParm(w_ge558_segregado, lst_Produto)
	
	dw_2.Retrieve(gl_cd_filial)
Else
	MessageBox("Aviso", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nenhum produto selecionado.")
End If
end event

type dw_3 from dc_uo_dw_base within w_ge558_produtos_endereco
boolean visible = false
integer x = 3241
integer y = 64
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge558_lista_relatorio"
end type

event ue_recuperar;//Override
Return This.Retrieve(gl_Cd_Filial)
end event

type cb_2 from commandbutton within w_ge558_produtos_endereco
boolean visible = false
integer x = 2437
integer y = 160
integer width = 1056
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ajuste Saida - DESENVOLVIMENTO"
end type

event clicked;String ls_Endereco_Saida, ls_Lote, ls_Nulo

Long ll_Produto, ll_Movimento, ll_Nulo, ll_Saldo_WMS, ll_Saldo_ERP

Date ldh_Validade

String ls_Matricula

If gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE558_INCLUI_ENDERECO", ref ls_Matricula) Then 
	If ls_Matricula <> '14231' Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente a matricula 14231 poder$$HEX1$$e100$$ENDHEX$$ utilizar esta fun$$HEX2$$e700e300$$ENDHEX$$o.")
		Return
	End If
Else
	Return 
End If

ll_Produto	= dw_2.Object.cd_produto	[dw_2.GetRow()]
ls_Lote		= dw_2.Object.nr_lote			[dw_2.GetRow()]

select l.cd_endereco, l.dh_validade, l.qt_saldo, a.qt_saldo_final
Into :ls_Endereco_Saida, :ldh_Validade, :ll_Movimento, :ll_Saldo_ERP
from wms_localizacao l
inner join wms_endereco_produto e on e.cd_endereco = l.cd_endereco
inner join vw_saldo_atual_produto a on a.cd_produto = l.cd_produto
Where l.cd_produto 	= :ll_Produto
  and l.nr_lote			= :ls_Lote
  and a.cd_filial = 534
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi possivel localizar o endere$$HEX1$$e700$$ENDHEX$$o do produto.")
		Return 
	Case -1
		SqlCa.of_MSgDBError("Erro o endereco do produto.")
		Return
End Choose

uo_ge258_movimentacao  lo_Movimentacao 
lo_Movimentacao = Create uo_ge258_movimentacao
	
lo_Movimentacao.ivb_Commit = False

SetNull(ls_Nulo)	
SetNull(ll_Nulo)
If Not lo_Movimentacao.of_insere_movimentacao(	ls_Nulo,&
																			ls_Endereco_Saida,&
																			ll_Produto,&
																			1,&
																			ls_Lote,&
																			Date(ldh_Validade),&
																			ll_Movimento,&
																			"J",&
																			534,&
																			ls_Nulo,&  
																			ll_Nulo,&
																			ls_Nulo,&
																			ls_Nulo,&
																			'14231') Then
	SqlCa.of_Rollback()
	Return
End If	

Select qt_saldo
Into :ll_Saldo_WMS
from vw_saldo_produto_wms
where cd_produto = :ll_Produto
  and id_utiliza_saldo = 'S'
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		ll_Saldo_WMS = 0
	Case -1
		SqlCa.of_MSgDBError("Erro o saldo do WMS.")
		SqlCa.of_RollBack()
		Return
End Choose

If ll_Saldo_ERP <> ll_Saldo_WMS Then
	MessageBox("Aten$$HEX1$$e700$$ENDHEX$$ao", "O saldo do WMS ficou diferente do ERP.~rA atualiza$$HEX2$$e700e300$$ENDHEX$$o foi abortada.")
	SqlCa.of_RollBack();
End If

SqlCa.of_Commit();
end event

type cb_3 from commandbutton within w_ge558_produtos_endereco
integer x = 1966
integer y = 200
integer width = 1157
integer height = 116
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Movimentar para o Pulm$$HEX1$$e300$$ENDHEX$$o"
end type

event clicked;st_ge558_dados_produto lst_Produto

Long	ll_Row,&
		ll_Qt_Cx_Pulmao,&
		ll_Cx_Padrao_Pulmao,&
		ll_Produto,&
		ll_cx_Padrao,&
		ll_Sequencial_Saida
		
String		ls_Endereco_Pulmao,&
			ls_Endereco_Flow,&
			ls_Lote,&
			ls_Operador,&
			ls_Flow,&
			lvs_erro,&
			ls_Erro_End_Bloq,&
			ls_Erro
			
DateTime ldh_Validade			

dw_2.AcceptText()

ll_Row = dw_2.GetRow( )

If ll_Row > 0 Then
	
	ls_Endereco_Flow 		= dw_2.Object.cd_endereco[ll_Row]
	ll_Produto				= dw_2.Object.cd_produto[ll_Row]
	ll_Sequencial_Saida	= dw_2.Object.nr_sequencial[ll_Row]
	ll_cx_Padrao			= dw_2.Object.qt_caixa_padrao[ll_Row]
	ls_Lote					= dw_2.Object.nr_lote[ll_Row]
	ldh_Validade			= DateTime(String(dw_2.Object.dh_validade[ll_Row], "01/mm/yyyy"))
	ls_Flow					= dw_2.Object.id_bairro_flow[ll_Row]

	If ib_inicio_controle_temp_rdc Then
		If is_Endereco_Geladeira = ls_Endereco_Flow Then 
			MessageBox("Aviso", "Movimenta$$HEX2$$e700e300$$ENDHEX$$o a partir do endere$$HEX1$$e700$$ENDHEX$$o: " + is_Endereco_Geladeira + ", n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitida!")
			Return 1
		End If
	End If
	
	If ls_Flow <> "S" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O endere$$HEX1$$e700$$ENDHEX$$o selecionado n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ FLOW RACK.")
		Return 1
	End If
	
	If Not f_ge558_permite_movimento_produto(ls_Endereco_Flow,  ll_Produto) Then
		Return 1
	End If	

	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE558_MOVIMENTAR_PRODUTO_PARA_PULMAO", ref ls_Operador) Then 
		Return 1
	End If
	
	OpenWithParm(w_ge558_movimenta_produto_pulmao, lst_Produto)
	
	lst_Produto = Message.PowerObjectParm
	
	If lst_Produto.id_retorno <> "S" Then
		Return 1
	End If
	
	ls_Endereco_Pulmao	= lst_Produto.cd_endereco_pulmao
	ll_Qt_Cx_Pulmao		= lst_Produto.qt_movimento
	ll_Cx_Padrao_Pulmao	= lst_Produto.qt_caixa_padrao
	
	
	If Not wf_Valida_Qtde_Saida_Flow(ls_Endereco_Flow, ll_Produto, ls_Lote, ll_Qt_Cx_Pulmao * ll_Cx_Padrao_Pulmao) Then
		Return 1
	End If
	
	If Not wf_valida_endereco_origem(ls_Endereco_Pulmao) Then
		Return 1
	End If
	
	If Not wf_Valida_Produto_Endereco_Destino(ls_Endereco_Pulmao, ll_Produto, ll_Cx_Padrao_Pulmao, ls_Lote, ldh_Validade) Then
		Return 1
	End If
	
	// Nova Valida$$HEX2$$e700e300$$ENDHEX$$o
	If Not gf_wms_permite_mov_prd_controlado(	ll_Produto,&
															   	ls_Endereco_Pulmao,& 
																Ref lvs_erro ) Then 
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', lvs_erro)
		Return 1
	End If 
	
	//Valida$$HEX2$$e700e300$$ENDHEX$$o se endere$$HEX1$$e700$$ENDHEX$$o Flow est$$HEX1$$e100$$ENDHEX$$ bloqueado
	If Not gf_Verifica_Endereco_Bloqueado(ls_Endereco_Flow, Ref ls_Erro_End_Bloq) Then 
		Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o',ls_Erro_End_Bloq)
		Return 1
	End If
	
	//Valida$$HEX2$$e700e300$$ENDHEX$$o se endere$$HEX1$$e700$$ENDHEX$$o Pulmao est$$HEX1$$e100$$ENDHEX$$ bloqueado
	If Not gf_Verifica_Endereco_Bloqueado(ls_Endereco_Pulmao, Ref ls_Erro_End_Bloq) Then 
		Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o',ls_Erro_End_Bloq)
		Return 1
	End If
	
	If wf_Movimenta_Para_Pulmao(	ls_Endereco_Flow,&
												ll_Sequencial_Saida,&
												ll_Produto,&
												ll_cx_Padrao,&
												ls_Lote,&
												ldh_Validade,&
												ls_Operador,&
												ls_Endereco_Pulmao,&
												ll_Qt_Cx_Pulmao,&
												ll_Cx_Padrao_Pulmao) Then
		dw_2.Retrieve(gl_Cd_Filial)
	End If
Else
	MessageBox("Aviso", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nenhum produto selecionado.")
End If
end event

type cb_4 from commandbutton within w_ge558_produtos_endereco
integer x = 1966
integer y = 76
integer width = 1157
integer height = 116
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Etiqueta Endere$$HEX1$$e700$$ENDHEX$$o - Papel A4"
end type

event clicked;dc_uo_ds_base lds_Etiqueta

String	ls_Endereco_Ean128,&
		ls_Endereco,&
		ls_Bairro

Long	ll_linha

dw_2.AcceptText()

ll_Linha	= dw_2.GetRow()

If ll_Linha < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um endere$$HEX1$$e700$$ENDHEX$$o.")
	Return 1
End If

ls_Bairro = dw_2.Object.cd_bairro[ll_linha]

If ls_Bairro <> "2" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$c900$$ENDHEX$$ permitido a impres$$HEX1$$e300$$ENDHEX$$o da etiqueta apenas para o bairro 2 - Almoxarifado.")
	Return 1
End If

//Abre tela para selecionar a impressora
If PrintSetup() = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Impress$$HEX1$$e300$$ENDHEX$$o cancelada.")
	Return 1
End If

Try
	lds_Etiqueta     = Create dc_uo_ds_base
	
	If Not lds_Etiqueta.of_ChangeDataObject("dw_ge558_etiqueta_endereco_papel_a4") Then
		MessageBox("Erro", "Erro no ChangeDataObject da 'dw_ge558_etiqueta_endereco_papel_a4'.")
		Return -1
	End If
	
	ls_Endereco	= dw_2.Object.cd_endereco[ll_Linha]
	
	ls_Endereco_Ean128	= gf_ean128(ls_Endereco)
	
	lds_Etiqueta.Object.cd_endereco_flow		[1] = dw_2.Object.de_endereco_flow_rack[ll_linha]
	lds_Etiqueta.Object.cd_endereco_esn128	[1] = ls_Endereco_Ean128
	lds_Etiqueta.Object.cd_endereco				[1] = ls_Endereco
	lds_Etiqueta.Object.cd_produto					[1] = dw_2.Object.cd_produto					[ll_linha]
	
	lds_Etiqueta.Print()	
	
Finally
	Destroy(lds_Etiqueta)
End Try
end event

type st_1 from statictext within w_ge558_produtos_endereco
integer x = 430
integer y = 572
integer width = 485
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean underline = true
long textcolor = 8388608
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type cb_5 from commandbutton within w_ge558_produtos_endereco
integer x = 3131
integer y = 76
integer width = 1157
integer height = 116
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Movimentar para Avariados"
end type

event clicked;Long							ll_Row
String						ls_Endereco, &
								ls_Operador
st_ge558_dados_produto	lst_Produto

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento ('GE558_SEGREGAR_AVARIADOS', ref ls_Operador) then
	Return 1
End if

dw_2.AcceptText()

ll_Row = dw_2.GetRow( )

If ll_Row > 0 Then
	
	ls_Endereco = dw_2.Object.cd_endereco[ll_Row]
	
	If ib_inicio_controle_temp_rdc Then
		If is_Endereco_Geladeira = ls_Endereco Then 
			MessageBox("Aviso", "Movimenta$$HEX2$$e700e300$$ENDHEX$$o a partir do endere$$HEX1$$e700$$ENDHEX$$o: " + is_Endereco_Geladeira + ", n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitida!")
			Return 1
		End If
	End If
	
	If Not wf_Produto_Agrupado(ls_Endereco) Then
		Return 1
	End If
	
	If Not wf_valida_endereco_origem(ls_Endereco) Then
		Return 1
	End If
	
	If ls_Endereco <> is_Endereco_Recebimento Then
		If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O produto n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ no recebimento.~rDeseja movimentar para avariados?', Question!, YesNo!, 2) = 2 Then
			Return 1	
		End If
	End If
	
	lst_Produto.cd_endereco_origem = ls_Endereco
	lst_Produto.cd_produto         = dw_2.Object.cd_produto      [ll_Row]
	lst_Produto.de_produto         = dw_2.Object.de_produto      [ll_Row]
	lst_Produto.qt_caixa_padrao    = dw_2.Object.qt_caixa_padrao [ll_Row]
	lst_Produto.qt_movimento       = dw_2.Object.qt_saldo        [ll_Row]
	lst_Produto.nr_lote            = dw_2.Object.nr_lote         [ll_Row]
	lst_Produto.dh_validade        = dw_2.Object.dh_validade     [ll_Row]
	lst_Produto.nr_sequencial      = dw_2.Object.nr_sequencial   [ll_Row]
	
	OpenWithParm (w_ge558_segregado_avaria, lst_Produto)
	
	dw_2.Retrieve(gl_Cd_Filial)
Else
	MessageBox ('Aviso', 'N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nenhum produto selecionado.')
End If
end event

type cb_6 from commandbutton within w_ge558_produtos_endereco
integer x = 3131
integer y = 324
integer width = 1157
integer height = 116
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Movimentar para Segregado Expedi$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;st_ge558_dados_produto lst_Produto
Long		ll_Row
String	ls_Endereco
String	ls_tipo_segregado, ls_Erro
dw_2.AcceptText()

ls_tipo_segregado = 'E'
ll_Row = dw_2.GetRow( )

If ll_Row > 0 Then
	
	ls_Endereco = dw_2.Object.cd_endereco[ll_Row]
	
	If ib_inicio_controle_temp_rdc Then
		If is_Endereco_Geladeira = ls_Endereco Then 
			MessageBox("Aviso", "Movimenta$$HEX2$$e700e300$$ENDHEX$$o a partir do endere$$HEX1$$e700$$ENDHEX$$o: " + is_Endereco_Geladeira + ", n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitida!")
			Return 1
		End If
	End If
	
	If Not wf_Produto_Agrupado(ls_Endereco) Then
		Return 1
	End If
	
	If ls_Endereco <> is_Endereco_Recebimento Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ no recebimento.~rDeseja movimentar para o segregado do recebimento?", Question!, YesNo!, 2) = 2 Then
			Return 1	
		End If
	End If
	
	If Not wf_valida_endereco_origem(ls_Endereco) Then
		Return 1
	End If
	
	lst_Produto.cd_produto 						= dw_2.Object.cd_produto			[ll_Row]
	lst_Produto.de_produto 						= dw_2.Object.de_produto			[ll_Row]
	lst_Produto.qt_caixa_padrao 				= dw_2.Object.qt_caixa_padrao	[ll_Row]
	lst_Produto.qt_movimento 					= dw_2.Object.qt_saldo				[ll_Row]
	lst_Produto.cd_endereco_origem 			= dw_2.Object.cd_endereco			[ll_Row]
	lst_Produto.nr_lote								= dw_2.Object.nr_lote					[ll_Row]
	lst_Produto.dh_validade						= dw_2.Object.dh_validade			[ll_Row]
	lst_Produto.nr_sequencial					= dw_2.Object.nr_sequencial		[ll_Row]
	lst_Produto.id_tipo_segregado				= 'E'
	
	If Not f_ge558_permite_movimento_produto(ls_Endereco,  lst_Produto.cd_produto)Then
		Return 1
	End If
	
	OpenWithParm(w_ge558_segregado, lst_Produto)
	
	dw_2.Retrieve(gl_Cd_Filial)
Else
	MessageBox("Aviso", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nenhum produto selecionado.")
End If
end event

type cb_7 from commandbutton within w_ge558_produtos_endereco
integer x = 3131
integer y = 200
integer width = 1157
integer height = 116
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Movimentar para o Flow"
end type

event clicked;Long							ll_Row, &
								ll_Produto
String						ls_Endereco, &
								ls_Operador, &
								ls_Msg, ls_cd_endereco_vw, de_endereco_flow_rack, ls_Erro
st_ge558_dados_produto	lst_Produto

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento ('GE558_MOVIMENTAR_FLOW', ref ls_Operador) then
	Return 1
End if

dw_2.AcceptText()

ll_Row = dw_2.GetRow( )

If ll_Row > 0 Then
	
	ls_Endereco = dw_2.Object.cd_endereco [ll_Row]
	ll_Produto  = dw_2.Object.cd_produto  [ll_Row]
	
	If ib_inicio_controle_temp_rdc Then
		If is_Endereco_Geladeira = ls_Endereco Then 
			MessageBox("Aviso", "Movimenta$$HEX2$$e700e300$$ENDHEX$$o a partir do endere$$HEX1$$e700$$ENDHEX$$o: " + is_Endereco_Geladeira + ", n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitida!")
			Return 1
		End If
	End If
	
	If Not wf_valida_endereco_origem (ls_Endereco) Then
		Return 1
	End If
	
	If Not f_ge558_permite_movimento_produto (ls_Endereco, ll_Produto) then
		Return 1
	End if
	
	If not gf_verifica_endereco_bloqueado (ls_Endereco, Ref ls_msg) then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_msg)
		Return 1
	End if
	
	lst_Produto.cd_endereco_origem = ls_Endereco
	lst_Produto.cd_produto         = ll_Produto
	lst_Produto.de_produto         = dw_2.Object.de_produto      [ll_Row]
	lst_Produto.qt_caixa_padrao    = dw_2.Object.qt_caixa_padrao [ll_Row]
	lst_Produto.qt_movimento       = dw_2.Object.qt_saldo        [ll_Row]
	lst_Produto.nr_lote            = dw_2.Object.nr_lote         [ll_Row]
	lst_Produto.dh_validade        = dw_2.Object.dh_validade     [ll_Row]
	lst_Produto.cd_endereco_flow_rack = dw_2.Object.cd_endereco_flow_rack[ll_Row]

	OpenWithParm (w_ge558_movimenta_flow, lst_Produto)
	
	dw_2.Retrieve (gl_Cd_filial)
Else
	MessageBox ('Aviso', 'N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nenhum produto selecionado.')
End If
end event

type gb_3 from groupbox within w_ge558_produtos_endereco
integer x = 1915
integer y = 8
integer width = 2395
integer height = 464
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = " A$$HEX2$$e700f500$$ENDHEX$$es "
borderstyle borderstyle = styleraised!
end type

