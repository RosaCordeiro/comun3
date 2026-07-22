HA$PBExportHeader$w_ge331_manutencao_divergencia_nf_compra.srw
forward
global type w_ge331_manutencao_divergencia_nf_compra from dc_w_2tab_consulta_selecao_lista_det
end type
type gb_5 from groupbox within tabpage_1
end type
type dw_5 from dc_uo_dw_base within tabpage_1
end type
type cb_liberacao from commandbutton within tabpage_1
end type
type cb_cancelar_agendamento from commandbutton within tabpage_1
end type
type cb_validar_nf from commandbutton within tabpage_1
end type
type cb_reenvia from commandbutton within tabpage_1
end type
type cb_descancelar_agendamento from commandbutton within tabpage_1
end type
type st_sap from statictext within tabpage_1
end type
type cb_reenvio_portal from commandbutton within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type cb_copiar from commandbutton within tabpage_2
end type
type cb_localizar_pedido from commandbutton within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type cb_alterar_cx_padrao from commandbutton within tabpage_3
end type
type cb_alterar_st from commandbutton within tabpage_3
end type
type cbx_1 from checkbox within tabpage_3
end type
type gb_4 from groupbox within tabpage_3
end type
type dw_4 from dc_uo_dw_base within tabpage_3
end type
type gb_6 from groupbox within tabpage_3
end type
type dw_6 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
cb_alterar_cx_padrao cb_alterar_cx_padrao
cb_alterar_st cb_alterar_st
cbx_1 cbx_1
gb_4 gb_4
dw_4 dw_4
gb_6 gb_6
dw_6 dw_6
end type
type tabpage_4 from userobject within tab_1
end type
type gb_7 from groupbox within tabpage_4
end type
type dw_7 from dc_uo_dw_base within tabpage_4
end type
type tabpage_4 from userobject within tab_1
gb_7 gb_7
dw_7 dw_7
end type
type tabpage_5 from userobject within tab_1
end type
type cb_1 from commandbutton within tabpage_5
end type
type cb_exclui_msg from commandbutton within tabpage_5
end type
type cb_gravar from commandbutton within tabpage_5
end type
type gb_8 from groupbox within tabpage_5
end type
type cb_enviar from commandbutton within tabpage_5
end type
type dw_8 from dc_uo_dw_base within tabpage_5
end type
type dw_9 from dc_uo_dw_base within tabpage_5
end type
type tabpage_5 from userobject within tab_1
cb_1 cb_1
cb_exclui_msg cb_exclui_msg
cb_gravar cb_gravar
gb_8 gb_8
cb_enviar cb_enviar
dw_8 dw_8
dw_9 dw_9
end type
end forward

global type w_ge331_manutencao_divergencia_nf_compra from dc_w_2tab_consulta_selecao_lista_det
integer width = 3845
integer height = 2224
string title = "GE331 - Manuten$$HEX2$$e700e300$$ENDHEX$$o do Agendamento de Entrega"
end type
global w_ge331_manutencao_divergencia_nf_compra w_ge331_manutencao_divergencia_nf_compra

type variables
uo_fornecedor io_fornecedor

String is_Chave_Acesso

DateTime idh_Liberado_Agendamento

Boolean ib_Somente_Consulta = False, ib_valida_teste_integrado  = False

Date ldt_Emissao_NF
Boolean ib_DivergenciaCNPJFornecedor = False
end variables

forward prototypes
public subroutine wf_popula_datawindow ()
public subroutine wf_habilita_menu ()
public function boolean wf_salvar ()
public subroutine wf_reset_dw ()
public function boolean wf_verifica_novas_divergencias ()
public function boolean wf_exclui_divergencias ()
public function boolean wf_possui_divergencias (string as_chave_acesso, ref boolean ab_possui_divergencia)
public function boolean wf_valida_pedido (long al_pedido, string as_cnpj_fornecedor, long al_nota, ref string as_erro)
public subroutine wf_verifica_divergencias ()
public subroutine wf_set_somente_consulta ()
public function boolean wf_envia_email_cancelamento_agend (string as_matricula, string as_motivo)
public function boolean wf_permite_cancelamento (ref boolean ab_permite)
public function boolean wf_atualiza_data_envio_email_recusa (string as_chave_acesso)
public function boolean wf_verifica_tamanho_anexo ()
public function boolean wf_verifica_msg_recusa (string as_chave_acesso)
public function boolean wf_permite_processamento (ref boolean ab_permite)
public function boolean wf_envia_email_recusa_fornecedor (string as_fornecedor, ref string as_email_fornecedor)
public function boolean wf_insere_historico_alteracao (string as_chave_acesso, string as_tabela, string as_coluna, datetime adt_previsao_anterior, datetime adt_previsao_inserida, ref string as_erro)
end prototypes

public subroutine wf_popula_datawindow ();tab_1.tabPage_1.dw_2.AcceptText()

If tab_1.tabPage_1.dw_2.RowCount() > 0 Then
	is_Chave_Acesso				= tab_1.tabPage_1.dw_2.Object.de_chave_acesso				[tab_1.tabPage_1.dw_2.GetRow()]
	idh_Liberado_Agendamento	= tab_1.tabPage_1.dw_2.Object.dh_liberacao_agendamento	[tab_1.tabPage_1.dw_2.GetRow()]
	
	If Not IsNull(idh_Liberado_Agendamento) Then
		Tab_1.TabPage_2.dw_3.Modify("nr_pedido_central.tabsequence=0")
	Else
		Tab_1.TabPage_2.dw_3.Modify("nr_pedido_central.tabsequence=10")
	End If
	
	Tab_1.TabPage_1.dw_5.Retrieve(is_Chave_Acesso)
	Tab_1.TabPage_2.dw_3.Retrieve(is_Chave_Acesso)
	Tab_1.TabPage_3.dw_4.Retrieve(is_Chave_Acesso)
	Tab_1.TabPage_4.dw_7.Retrieve(is_Chave_Acesso)
	Tab_1.TabPage_5.dw_8.Retrieve(is_Chave_Acesso)
	
	Tab_1.TabPage_5.dw_9.Event ue_Reset()
	Tab_1.TabPage_5.dw_9.Event ue_AddRow()
End If




end subroutine

public subroutine wf_habilita_menu ();This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)

//Tab_1.TabPage_1.Enabled = False
end subroutine

public function boolean wf_salvar ();Long	ll_Pedido,&
		ll_Pedido_Original,&
		ll_Produto,&
		ll_produto_Original,&
		ll_Linha,&
		ll_Linhas,&
		ll_Item,&
		ll_Nota
		
String 	ls_Erro,&
			ls_ST,&
			ls_ST_Origem,&
			ls_Cnpj_Fornecedor,&
			ls_Chave_Acesso
			
Datetime	ldt_Previsao_Entrega,&
			ldt_Previsa_Entrega_original,&
			ldt_Previsao_Entrega_original,&
			ldt_Atual
			
ldt_Atual = gf_GetServerDate()

Tab_1.TabPage_2.dw_3.AcceptText()

//Salva altera$$HEX2$$e700e300$$ENDHEX$$o no pedido
ll_Pedido								= Tab_1.TabPage_2.dw_3.Object.nr_pedido_central				[1]
ll_Pedido_Original					= Tab_1.TabPage_2.dw_3.Object.nr_pedido_central_original	[1]
ls_Cnpj_Fornecedor					= Tab_1.TabPage_2.dw_3.Object.nr_cgc_fornecedor				[1]
ll_Nota									= Tab_1.TabPage_2.dw_3.Object.nr_nf								[1]

If IsNull(ll_Pedido_Original) Then ll_Pedido_Original = 0

If ll_Pedido <> ll_Pedido_Original Then
	If IsNull(ll_Pedido) or ll_Pedido = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o pedido.")
		Tab_1.SelectTab(2)
		Tab_1.tabPage_2.dw_3.SetFocus()
		Return False
	End If
	
	//Verifica se o pedido $$HEX1$$e900$$ENDHEX$$ do fornecedor da nota e se a emiss$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ menor do que 45 dias
	If Not wf_Valida_Pedido(ll_Pedido, ls_Cnpj_Fornecedor, ll_Nota, Ref ls_Erro) Then
		SqlCa.of_RollBack()
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro)		
		Return False
	End If
	
	Update nf_agendamento_ent
	Set nr_pedido_central = :ll_Pedido
	Where de_chave_acesso = :is_Chave_Acesso
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SQLErrText
		SqlCa.of_RollBack()
		MessageBox("Erro", "Erro ao atualizar o pedido: "+ ls_Erro)		
		Return False
	End If
	
End If

//Salva altera$$HEX2$$e700e300$$ENDHEX$$o no produto
Tab_1.TabPage_3.dw_4.AcceptText()

ll_Linhas	= Tab_1.TabPage_3.dw_4.RowCount()

For ll_Linha = 1 To ll_Linhas
	ll_produto				= Tab_1.TabPage_3.dw_4.Object.cd_produto						[ll_Linha]
	ll_produto_Original	= Tab_1.TabPage_3.dw_4.Object.cd_produto_original			[ll_Linha]
	ls_ST						= Tab_1.TabPage_3.dw_4.Object.cd_cst_tributacao				[ll_Linha]
	ls_ST_Origem			= Tab_1.TabPage_3.dw_4.Object.cd_cst_tributacao_original	[ll_Linha]
	ll_Item					= Tab_1.TabPage_3.dw_4.Object.nr_item							[ll_Linha]	
	
	If IsNull(ll_produto) Then ll_produto = 0
	If IsNull(ll_produto_Original) Then ll_produto_Original = 0
	
	If ll_produto <> ll_produto_Original Then
		Update nf_agendamento_ent_item
		Set cd_produto = :ll_Produto
		Where de_chave_acesso	= :is_Chave_Acesso
			and nr_item				= :ll_Item
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SQLErrText
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro ao atualizar o c$$HEX1$$f300$$ENDHEX$$digo do produto: "+ ls_Erro)		
			Return False
		End If	
	End If	
	
	If ls_ST <> ls_ST_Origem Then
		Update nf_agendamento_ent_item
		Set cd_cst_tributacao = :ls_ST
		Where de_chave_acesso	= :is_Chave_Acesso
			and nr_item				= :ll_Item
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SQLErrText
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro ao atualizar o ST do produto: "+ ls_Erro)		
			Return False
		End If	
	End If

Next

//Salva altera$$HEX2$$e700e300$$ENDHEX$$o da precvisao de entrega
Tab_1.TabPage_1.dw_2.AcceptText()

ll_Linhas	= Tab_1.TabPage_1.dw_2.RowCount()

For ll_Linha = 1 To ll_Linhas

	ldt_Previsao_Entrega_original		= Tab_1.TabPage_1.dw_2.Object.dh_previsao_entrega_og	[ll_Linha]
	ldt_Previsao_Entrega					= Tab_1.TabPage_1.dw_2.Object.dh_previsao_entrega		[ll_Linha]
	ls_Chave_Acesso						= Tab_1.TabPage_1.dw_2.Object.de_chave_acesso 			[ll_Linha]
	ll_Nota									= Tab_1.TabPage_1.dw_2.Object.nr_nf							[ll_Linha]
	
	If IsNull(ldt_Previsao_Entrega_original) Then
		ldt_Previsao_Entrega_original = datetime(1900-01-01)
	End if

	If ldt_Previsao_Entrega <> ldt_Previsao_Entrega_original Then
		
		If date(ldt_Previsao_Entrega) > date(ldt_Atual) Then
		
			If Time(ldt_Atual) >= Time('12:00:00') And Time(ldt_Atual) <= Time('18:00:00') Then
				MessageBox("Erro", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido alterar a previs$$HEX1$$e300$$ENDHEX$$o de entrega entre 12:00 e 18:00.")
				Return False
			Else
				
				Update nf_agendamento_ent
				Set dh_previsao_entrega = :ldt_Previsao_Entrega
				Where de_chave_acesso	= :ls_Chave_Acesso
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					ls_Erro = SqlCa.SQLErrText
					SqlCa.of_RollBack()
					MessageBox("Erro", "Erro ao atualizar a previs$$HEX1$$e300$$ENDHEX$$o de chegada da nota: "+string(ll_Nota) + ls_Erro)		
					Return False
				End If
				
				Update nf_agendamento_ent_item
				Set	id_entregue_cd		= 'N'
				Where de_chave_acesso	= :ls_Chave_Acesso
				And	id_entregue_cd		<> 'S'
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					ls_Erro = SqlCa.SQLErrText
					SqlCa.of_RollBack()
					MessageBox("Erro", "Erro ao atualizar o status de entraga da nota: "+string(ll_Nota) + ls_Erro)	
					Return False
				End If
				
				If Not wf_insere_historico_alteracao(ls_Chave_Acesso,'NF_AGENDAMENTO_ENT','DH_PREVISAO_ENTREGA',ldt_Previsao_Entrega_original,ldt_Previsao_Entrega,ls_Erro) Then 
					MessageBox("Erro", "Erro ao atualizar o status de entraga da nota: "+string(ll_Nota) + ls_Erro)
					Return False
				End If
				
			End if
		Else
			MessageBox("Erro", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ possivel cadastrar a data de entrega menor que hoje. Nota:" + string(ll_Nota))
			Return False
		End If
	End if
	
Next
Return True
end function

public subroutine wf_reset_dw ();Tab_1.TabPage_1.dw_5.Reset()
Tab_1.TabPage_1.dw_2.Reset()
Tab_1.TabPage_2.dw_3.Reset()
Tab_1.TabPage_3.dw_4.Reset()
Tab_1.TabPage_3.dw_6.Reset()
Tab_1.TabPage_4.dw_7.Reset()
end subroutine

public function boolean wf_verifica_novas_divergencias ();String ls_MSG

dc_uo_verifica_divergencia_notas lo //GE238

Try
	lo = Create dc_uo_verifica_divergencia_notas
	
	Try
		
		If  lo.of_verifica_divergencias_agendamento(is_Chave_Acesso, ldt_Emissao_Nf,ref ls_MSG) Then
			SqlCa.of_Commit()
		Else
			SqlCa.of_RollBack()
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu erro ao verificar novas diverg$$HEX1$$ea00$$ENDHEX$$ncias.~r~r"+ls_MSG)
			Return False
		End If
		
	Catch ( runtimeerror  lo_rte )
		SqlCa.of_RollBack()
		MessageBox("Erro", "Ocorreu erro ao verificar novas diverg$$HEX1$$ea00$$ENDHEX$$ncias.~r~r"+lo_rte.GetMessage( ))
		Return False						 
	End Try	
	
Finally
	Destroy(lo)
End Try

Return True
end function

public function boolean wf_exclui_divergencias ();String	ls_Erro,&
		ls_Usuario

ls_Usuario = gvo_aplicacao.ivo_seguranca.nr_matricula

//Grava hist$$HEX1$$f300$$ENDHEX$$rico referente as diverg$$HEX1$$ea00$$ENDHEX$$ncias dos produtos
insert into historico_alteracao_tabela( 
	nm_tabela,
	de_chave,
	nm_coluna,
	dh_alteracao,
	de_alteracao_de,
	nr_matric_alteracao,
	id_alteracao)
select		'NF_AGENDAMENTO_ENT_ITEM_DIVERG',
			de_chave_acesso,
			'CD_TIPO_DIVERGENCIA - DE_DIVERGENCIA',
			GetDate(),
			cast(cd_tipo_divergencia as varchar)+' - '+de_divergencia,
			:ls_Usuario,
			'E'
from nf_agendamento_ent_item_diverg
where de_chave_acesso = :is_Chave_Acesso
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SQLErrText
	SqlCa.of_RollBack()
	MessageBox("Erro", "Erro ao gravar hist$$HEX1$$f300$$ENDHEX$$rico da tabela 'nf_agendamento_ent_item_diverg': "+ ls_Erro)		
	Return False
End If	

//Deleta as diverg$$HEX1$$ea00$$ENDHEX$$ncias referente aos produtos
Delete From nf_agendamento_ent_item_diverg
Where de_chave_acesso = :is_Chave_Acesso
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SQLErrText
	SqlCa.of_RollBack()
	MessageBox("Erro", "Erro ao excluir as diverg$$HEX1$$ea00$$ENDHEX$$ncias da tabela 'nf_agendamento_ent_item_diverg': "+ ls_Erro)		
	Return False
End If	

//Grava hist$$HEX1$$f300$$ENDHEX$$rico referente as diverg$$HEX1$$ea00$$ENDHEX$$ncias da nota
insert into historico_alteracao_tabela( 
	nm_tabela,
	de_chave,
	nm_coluna,
	dh_alteracao,
	de_alteracao_de,
	nr_matric_alteracao,
	id_alteracao)
select		'NF_AGENDAMENTO_ENT_DIVERGENCIA',
			de_chave_acesso,
			'CD_TIPO_DIVERGENCIA - DE_DIVERGENCIA',
			GetDate(),
			cast(cd_tipo_divergencia as varchar)+' - '+de_divergencia,
			:ls_Usuario,
			'E'
from nf_agendamento_ent_divergencia
where de_chave_acesso = :is_Chave_Acesso
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SQLErrText
	SqlCa.of_RollBack()
	MessageBox("Erro", "Erro ao gravar hist$$HEX1$$f300$$ENDHEX$$rico da tabela 'nf_agendamento_ent_divergencia': "+ ls_Erro)		
	Return False
End If	

//Deleta as diverg$$HEX1$$ea00$$ENDHEX$$ncias referente a nota
Delete From nf_agendamento_ent_divergencia
Where de_chave_acesso = :is_Chave_Acesso
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SQLErrText
	SqlCa.of_RollBack()
	MessageBox("Erro", "Erro ao excluir as diverg$$HEX1$$ea00$$ENDHEX$$ncias da tabela 'nf_agendamento_ent_divergencia': "+ ls_Erro)		
	Return False
End If	

Return True

end function

public function boolean wf_possui_divergencias (string as_chave_acesso, ref boolean ab_possui_divergencia);Integer	li_Divergencia_NF,&
			li_Divergencia_Item,&
			li_Divergencia_CNPJ
			
ab_Possui_Divergencia = False


Select count(*)
Into :li_Divergencia_NF
from nf_agendamento_ent_divergencia
Where de_chave_acesso = :as_Chave_Acesso
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar as diverg$$HEX1$$ea00$$ENDHEX$$ncias da nota.")
	Return False
End If

Select count(*)
Into :li_Divergencia_Item
from nf_agendamento_ent_item_diverg
Where de_chave_acesso = :as_Chave_Acesso
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar as diverg$$HEX1$$ea00$$ENDHEX$$ncias da nota.")
	Return False
End If


// Nova Verifica$$HEX2$$e700e300$$ENDHEX$$o de Divergencia CNPJ
Select		count(*) 
Into		:li_Divergencia_CNPJ
From		nf_agendamento_ent_divergencia a
Where	de_divergencia like  'O CNPJ DO EMISSOR DA NOTA%'
And 		de_divergencia like   '%DIFERENTE DO FORNECEDOR DO PEDI%'
And		de_chave_acesso = :as_chave_acesso
Using SqlCA;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar as diverg$$HEX1$$ea00$$ENDHEX$$ncias da nota.")
	Return False
End If

If li_Divergencia_CNPJ > 0 Then 
	ib_DivergenciaCNPJFornecedor = True
Else
	ib_DivergenciaCNPJFornecedor	 = False
End If 

If (li_Divergencia_NF > 0) or (li_Divergencia_Item > 0)  Then
	ab_Possui_Divergencia = True
End If

Return True
end function

public function boolean wf_valida_pedido (long al_pedido, string as_cnpj_fornecedor, long al_nota, ref string as_erro);Date	ldt_Pedido,&
		ldt_Data

String ls_Cnpj_Pedido	
	
//Localiza o CNPJ do fornecedor do pedido
Select b.nr_cgc
Into :ls_Cnpj_Pedido
From pedido_central a
Inner Join fornecedor b on b.cd_fornecedor = a.cd_fornecedor
Where a.nr_pedido = :al_Pedido
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o pedido "+String(al_Pedido)+"."
		Return False
	Case -1
		as_Erro = "Erro ao verificar se o pedido $$HEX1$$e900$$ENDHEX$$ do fornecedor da nota: "+ SqlCa.SQLErrText
		Return False
End Choose

If ls_Cnpj_Pedido <> as_Cnpj_Fornecedor Then
	as_Erro = "O pedido '"+String(al_Pedido)+"' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ do fornecedor da nota '"+String(al_Nota)+"'."
	Return False
End If
	

//Localiza a data do pedido	
Select dh_pedido
Into :ldt_Pedido
From pedido_central 
Where nr_pedido = :al_Pedido
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o pedido "+String(al_Pedido)+"."
		Return False
	Case -1
		as_Erro = "Erro ao localizar a data do pedido '"+String(al_Pedido)+"': "+ SqlCa.SQLErrText
		Return False
End Choose

ldt_Data = RelativeDate(Date(gf_GetServerDate()), -365)

If ldt_Pedido < ldt_Data Then
	as_Erro = "O pedido '"+String(al_Pedido)+"' foi emitido $$HEX1$$e000$$ENDHEX$$ mais de 1 ano."
	Return False
End If

Return True
end function

public subroutine wf_verifica_divergencias ();Boolean lb_Sucesso

String ls_Chave_Acesso

Long	ll_Find

If wf_Exclui_Divergencias() Then
	SqlCa.of_Commit() //Colocado commit aqui porque ao verificar novas diverg$$HEX1$$ea00$$ENDHEX$$ncias est$$HEX1$$e100$$ENDHEX$$ bloqueando outra transa$$HEX2$$e700e300$$ENDHEX$$o do banco
	If wf_verifica_novas_divergencias() Then
		lb_Sucesso = True
	End If
End If	

If lb_Sucesso Then
	SqlCa.of_Commit()
Else
	SqlCa.of_Rollback()
	MessageBox("Erro", "AVISO IMPORTANTE!~r~rOcorreu erro e n$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel verificar novas diverg$$HEX1$$ea00$$ENDHEX$$ncias.")	
	Return 
End If

ls_Chave_Acesso = is_Chave_Acesso

tab_1.SelectTab(1)
tab_1.tabPage_1.dw_2.SetFocus()

Tab_1.TabPage_1.dw_2.Reset()
Tab_1.TabPage_1.dw_2.Event ue_Recuperar()

wf_Popula_DataWindow()


ll_Find = Tab_1.TabPage_1.dw_2.Find("de_chave_acesso = '" +ls_Chave_Acesso+"'" , 1, Tab_1.TabPage_1.dw_2.RowCount())
		
If ll_Find < 0 Then
	MessageBox("Erro", "Erro no Find do evento ue_Save")	
	Return 
End If

If ll_Find > 0 Then
	Tab_1.TabPage_1.dw_2.SetRow(ll_Find)
	Tab_1.TabPage_1.dw_2.ScrollToRow(ll_Find)
End If


end subroutine

public subroutine wf_set_somente_consulta ();tab_1.tabPage_3.dw_4.of_Set_Somente_Leitura(False)

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> "WS" Then
	tab_1.tabPage_5.dw_8.of_Set_Somente_Leitura(False)
End If
end subroutine

public function boolean wf_envia_email_cancelamento_agend (string as_matricula, string as_motivo);Boolean lb_Inclui = True

DateTime ldh_Emissao

Decimal ldc_Valor_Nf

Long ll_Linha
Long ll_Nr_Nf
Long ll_Row
Long ll_Pedido

String ls_Texto_Agend
String ls_Nm_Fornecedor
String ls_Nat_Operacao
String ls_Pedido
String ls_Msg_Email_Erro
String ls_Null[]
String ls_Responsavel
String ls_Ds

//Desenvolvimento
If gvo_Aplicacao.ivs_DataSource <> 'central' Then Return True

Try
	Tab_1.TabPage_1.dw_2.AcceptText()
	Tab_1.TabPage_2.dw_3.AcceptText()
		
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	dc_uo_ds_base lds_Interno
	lds_Interno = Create dc_uo_ds_base

	If Not lds.of_ChangeDataObject("ds_ge238_email_fornecedor_agendamento") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'ds_ge238_email_fornecedor_agendamento'.")
		Return False
	End If
	
	If lds.Retrieve(is_Chave_Acesso) < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve do data store 'ds_ge238_email_fornecedor_agendamento'.")
		Return False
	End If
	
	s_email str
	
	//Contato do fornecedor $$HEX1$$e900$$ENDHEX$$ COM C$$HEX1$$d300$$ENDHEX$$PIA
	For ll_Linha = 1 To lds.RowCount()
		str.ps_cc[ll_Linha] = lds.Object.De_Email[ll_Linha]
	Next
	
	ll_Pedido = Tab_1.TabPage_2.dw_3.Object.Nr_Pedido_Central[1]
	
	If Not IsNull(ll_Pedido) And ll_Pedido > 0 Then
		ls_Ds = "ds_ge331_email_comprador"
	Else
		ls_Ds = "ds_ge238_email_coordenador"		
	End If
	
	If Not lds_Interno.of_ChangeDataObject(ls_Ds) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store '" + ls_Ds + "'.", StopSign!)
		Return False
	End If
	
	If Not IsNull(ll_Pedido) And ll_Pedido > 0 Then		
		If lds_Interno.Retrieve(ll_Pedido) < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve do data store '" + ls_Ds +"'.", StopSign!)
			Return False
		End If
	Else
		If lds_Interno.Retrieve() < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve do data store '" + ls_Ds +"'.", StopSign!)
			Return False
		End If
	End If
	
	ll_Linha = 0
	
	For ll_Linha = 1 To lds_Interno.RowCount()
		str.ps_to[ll_Linha] = lds_Interno.Object.De_Email[ll_Linha]
	Next
	
	ll_Row = Tab_1.TabPage_1.dw_2.GetRow()
	
	ls_Nm_Fornecedor	= Tab_1.TabPage_1.dw_2.Object.Nm_Razao_Social			[ll_Row]
	ll_Nr_Nf				= Tab_1.TabPage_1.dw_2.Object.Nr_Nf							[ll_Row]
	ldc_Valor_Nf		= Tab_1.TabPage_1.dw_2.Object.Vl_Total_Nf					[ll_Row]
	ls_Nat_Operacao	= Tab_1.TabPage_1.dw_2.Object.De_Natureza_Operacao		[ll_Row]
	ldh_Emissao			= Tab_1.TabPage_1.dw_2.Object.Dh_Emissao					[ll_Row]
	
	uo_usuario lo_Usuario //ge010
	lo_Usuario = Create uo_usuario
	
	lo_Usuario.of_Localiza_Usuario(as_Matricula)
	
	If Not lo_Usuario.Localizado Then Return False
	
	ls_Responsavel = lo_Usuario.Nm_Usuario
		
	ls_Texto_Agend = 	"E-mail autom$$HEX1$$e100$$ENDHEX$$tico enviado pela CIA LATINO AMERICANA DE MEDICAMENTOS (CLAMED)<br><br>" + &
							"Motivo: Cancelamento de Agendamento<br><br>" + &
							"FORNECEDOR: " + ls_Nm_Fornecedor+ "<br>" + & 
							"NOTA: " + String(ll_Nr_Nf) + "<br>" + &
							"EMISS$$HEX1$$c300$$ENDHEX$$O: " + String(ldh_Emissao, "dd/mm/yyyy") + "<br>" + &
							"VALOR: " + String(ldc_Valor_Nf, "###,###.00") + "<br>" + &
							"NAT. OPERA$$HEX2$$c700c300$$ENDHEX$$O: " + ls_Nat_Operacao + "<br>" + &
							"RESPONS$$HEX1$$c100$$ENDHEX$$VEL: " + ls_Responsavel + "<br><br><br>" + &
							"DESCRI$$HEX2$$c700c300$$ENDHEX$$O DO MOTIVO: " + as_Motivo
	
	//O e-mail do heder j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ nos contatos do c$$HEX1$$f300$$ENDHEX$$digo 114. Se o Heder for o operador, o endere$$HEX1$$e700$$ENDHEX$$o de e-mail dele ser$$HEX1$$e100$$ENDHEX$$ adicionado somente uma vez
	If lo_Usuario.De_Email <> "heder@clamed.com.br" Then	
		ll_Linha = 0
		
		For ll_Linha = 1 To lds_Interno.RowCount()
			If lds_Interno.Object.De_Email[ll_Linha] = lo_Usuario.De_Email Then
				lb_Inclui = False
				Exit
			End If
		Next
		
		If lb_Inclui Then
			str.ps_to[UpperBound(str.ps_to) + 1] = lo_Usuario.De_Email
		End If
	End If
	
	str.ps_Mensagem = ls_Texto_Agend
	
	str.pb_Assinatura = True
		
	If Not gf_ge202_envia_email_padrao(114, str, True) Then
		ll_Linha = 0
	
		//TO
		If UpperBound(str.ps_to) > 0 Then ls_Msg_Email_Erro += '<br>PARA: <i>'
		For ll_Linha = 1 to UpperBound(str.ps_to)
			If ll_Linha > 1 Then ls_Msg_Email_Erro += ', '
			ls_Msg_Email_Erro += str.ps_to[ll_Linha]
		Next
		
		If UpperBound(str.ps_to) > 0 Then ls_Msg_Email_Erro += '</i>'
		//CC
		If UpperBound(str.ps_cc) > 0 Then ls_Msg_Email_Erro += '<br>C$$HEX1$$d300$$ENDHEX$$PIA: <i>'
		For ll_Linha = 1 to UpperBound(str.ps_cc)
			If ll_Linha > 1 Then ls_Msg_Email_Erro += ', '
			ls_Msg_Email_Erro += str.ps_cc[ll_Linha]
		Next
		
		If UpperBound(str.ps_cc) > 0 Then ls_Msg_Email_Erro += '</i>'
		//CCO
		If UpperBound(str.ps_co) > 0 Then ls_Msg_Email_Erro += '<br>C$$HEX1$$d300$$ENDHEX$$PIA OCULTA: <i>'
		For ll_Linha = 1 to UpperBound(str.ps_co)
			If ll_Linha > 1 Then ls_Msg_Email_Erro += ', '
			ls_Msg_Email_Erro += str.ps_co[ll_Linha]
		Next
		
		If UpperBound(str.ps_co) > 0 Then ls_Msg_Email_Erro += '</i>'
		//MSG
		
		ls_Msg_Email_Erro += '<br><br>MENSAGEM ORIGINAL: <i>'+str.ps_mensagem+'</i>'
	
		//Limpa o str.ps_cc[] que cont$$HEX1$$e900$$ENDHEX$$m o contato dos fornecedores
		str.ps_cc[] = ls_Null[]
		str.ps_mensagem = ""
		
		str.ps_mensagem = 'Caro(a) Comprador(a), ~r~n~r~n'+ &
									'Ocorreu um erro na tentativa do sistema GN enviar o email [GN] - Cancelamento de Agendamento (cod. '+String(114)+').~r~n~r~n' + &
									 ls_Msg_Email_Erro						
	
		gf_ge202_envia_email_padrao(86, str, True)
	End If
	
	Return True
	
Finally
	If IsValid(lds) Then Destroy(lds)
	If IsValid(lds_Interno) Then Destroy(lds_Interno)
	If IsValid(lo_Usuario) Then Destroy(lo_Usuario)
End Try
end function

public function boolean wf_permite_cancelamento (ref boolean ab_permite);Long ll_Nf

Select nr_nf
	Into :ll_Nf
From nf_compra
Where de_chave_acesso = :is_Chave_Acesso
	And cd_filial = 534

Union

Select nr_nf
From nf_compra_pendente
Where de_chave_acesso = :is_Chave_Acesso
	And cd_filial = 534
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ab_Permite = False
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "NF dispon$$HEX1$$ed00$$ENDHEX$$vel no sistema. N$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ter o agendamento cancelado.")
		
	Case 100
		ab_Permite = True
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se a NF dispon$$HEX1$$ed00$$ENDHEX$$vel est$$HEX1$$e100$$ENDHEX$$ no sistema.")
		Return False	
End Choose

Return True
end function

public function boolean wf_atualiza_data_envio_email_recusa (string as_chave_acesso);String ls_Erro

Update nf_agendamento_ent_msg_recusa
	Set dh_envio_msg_email = getdate()
Where de_chave_acesso = :as_Chave_Acesso
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar a data de envio de e-mail da mensagem de recusa. " + ls_Erro, StopSign!)
	Return False
End If

SqlCa.of_Commit();
end function

public function boolean wf_verifica_tamanho_anexo ();Long ll_Linha
Long ll_Tamanho = 0
Long ll_Aux = 0

String ls_Nome_Arquivo

Tab_1.TabPage_5.dw_9.AcceptText()

For ll_Linha = 1 To Tab_1.TabPage_5.dw_9.RowCount()
	ls_Nome_Arquivo = Tab_1.TabPage_5.dw_9.Object.Nm_Arquivo_Reduzido[ll_Linha]
	
	If IsNull(ls_Nome_Arquivo) Then Continue

	ll_Aux = FileLength(ls_Nome_Arquivo)
	
	If ll_Aux = -1 Or IsNull(ll_Aux) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na chamada da fun$$HEX2$$e700e300$$ENDHEX$$o FileLength.", StopSign!)
		Return False
	End If

	ll_Tamanho += ll_Aux
Next

//Se o tamanho dos arquivos for maior que 2 mb n$$HEX1$$e300$$ENDHEX$$o envia e-mail
If ll_Tamanho > 2000000 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O tamanho TOTAL dos anexos N$$HEX1$$c300$$ENDHEX$$O pode ser maior que 2 MB.", Exclamation!)
	Return False
End If

Return True
end function

public function boolean wf_verifica_msg_recusa (string as_chave_acesso);Long ll_Achou

Select Count(*)
	Into :ll_Achou
From nf_agendamento_ent_msg_recusa
Where de_chave_acesso = :as_Chave_Acesso
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se a NF possui mensagem de recusa. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

If ll_Achou > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "NF possui mensagem de recusa.~r~rPara liberar a NF para o portal deve ser exclu$$HEX1$$ed00$$ENDHEX$$da a recusa na aba [Mensagem de Recusa].", Exclamation!)
	Return False
End If

Return True
end function

public function boolean wf_permite_processamento (ref boolean ab_permite);Long ll_Nf

Select nr_nf
	Into :ll_Nf
From nf_compra
Where de_chave_acesso = :is_Chave_Acesso
	And cd_filial = 534
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ab_Permite = False
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nota Fiscal j$$HEX1$$e100$$ENDHEX$$ foi confirmada.", Exclamation!)
		
	Case 100
		ab_Permite = True
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se a NF confirmada.")
		Return False	
End Choose

Select nr_nf
Into :ll_NF
From nf_compra_pendente
Where de_chave_acesso = :is_Chave_Acesso
	And cd_filial = 534
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ab_Permite = False
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O processo de confer$$HEX1$$ea00$$ENDHEX$$ncia j$$HEX1$$e100$$ENDHEX$$ foi iniciada.", Exclamation!)
		
	Case 100
		ab_Permite = True
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se j$$HEX1$$e100$$ENDHEX$$ foi iniciado o processo de confer$$HEX1$$ea00$$ENDHEX$$ncia.")
		Return False	
End Choose

Return True
end function

public function boolean wf_envia_email_recusa_fornecedor (string as_fornecedor, ref string as_email_fornecedor);Long ll_linhas,&
	  ll_linha
String ls_valor

Try
    dc_uo_ds_base lds
    lds = Create dc_uo_ds_base
    

    If Not lds.of_ChangeDataObject("ds_ge331_email_fornecedor") Then
        MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'ds_ge331_email_fornecedor'.")
        Return False
    End If
    

    ll_linhas = lds.retrieve(as_fornecedor)
    
    IF ll_linhas > 0 Then
        
		  as_email_fornecedor = ''
		  
        For ll_linha = 1 To ll_linhas

            ls_valor = lds.object.de_email[ll_linha]
            
            If Not Isnull(ls_valor) Then
					If as_email_fornecedor = '' Then
						as_email_fornecedor = ls_valor
					Else
						as_email_fornecedor += ';'+ ls_valor
					End If
				End If
        Next
        
    ElseIf ll_linhas = -1 Then
        MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar os dados.", exclamation!)
        Return False
    End If
	 
Finally
    If IsValid(lds) Then Destroy(lds)
End Try

end function

public function boolean wf_insere_historico_alteracao (string as_chave_acesso, string as_tabela, string as_coluna, datetime adt_previsao_anterior, datetime adt_previsao_inserida, ref string as_erro);String	ls_Usuario
String	ls_previsao_inserida
String	ls_previsao_anterior

Datetime	ldt_Atual

ls_Usuario = gvo_aplicacao.ivo_seguranca.nr_matricula

ldt_Atual = gf_GetServerDate()


ls_previsao_anterior = String(adt_previsao_anterior, "yyyy-mm-dd")
ls_previsao_inserida = String(adt_previsao_inserida, "yyyy-mm-dd")

//Grava hist$$HEX1$$f300$$ENDHEX$$rico referente as diverg$$HEX1$$ea00$$ENDHEX$$ncias dos produtos
insert into historico_alteracao_tabela( 
	nm_tabela,
	de_chave,
	nm_coluna,
	dh_alteracao,
	de_alteracao_de,
	de_alteracao_para,
	nr_matric_alteracao,
	id_alteracao)
values (
			:as_tabela,
			:as_chave_acesso,
			:as_coluna,
			:ldt_Atual,
			:ls_previsao_anterior,
			:ls_previsao_inserida,
			:ls_Usuario,
			'A')
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro = SqlCa.SQLErrText
	SqlCa.of_RollBack()
	Return False
End If	

Return True
end function

on w_ge331_manutencao_divergencia_nf_compra.create
int iCurrent
call super::create
end on

on w_ge331_manutencao_divergencia_nf_compra.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;Boolean lb_Iniciado_Operacao_SAP

String ls_Mensagem

io_Fornecedor = Create uo_Fornecedor

If Not gf_verifica_inicio_operacao_sap('DH_INICIO_OPERACAO_SAP', ref lb_Iniciado_Operacao_SAP, ref ls_Mensagem) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem, Exclamation!)
	Close(This)
	Return
End If
 
If lb_Iniciado_Operacao_SAP Then
	ib_Somente_Consulta = True

	Tab_1.TabPage_1.cb_validar_nf.Enabled					= False
	//Tab_1.TabPage_1.cb_descancelar_agendamento.Enabled	= False
	Tab_1.TabPage_2.cb_localizar_pedido.Enabled			= False	
	Tab_1.TabPage_3.cb_alterar_cx_padrao.Enabled			= False
	//Tab_1.TabPage_3.cb_alterar_st.Enabled					= False

	Tab_1.TabPage_2.dw_3.Enabled = False
	
	Tab_1.TabPage_1.st_sap.visible = True
Else
	//Poder$$HEX1$$e100$$ENDHEX$$ alterar a nota semente se o sistema for o Compras
	If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> "CO" Then
		ib_Somente_Consulta = True
		
		Tab_1.TabPage_1.cb_cancelar_agendamento.Enabled	= False
		Tab_1.TabPage_2.cb_localizar_pedido.Enabled		= False	
		Tab_1.TabPage_3.cb_alterar_cx_padrao.Enabled		= False
		
		If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> "FI"  Then
			Tab_1.TabPage_3.cb_alterar_st.Enabled	= False
			Tab_1.TabPage_1.cb_validar_nf.Enabled	= False
		End If
		
		Tab_1.TabPage_2.dw_3.Enabled = False
		
	Else
		Tab_1.TabPage_3.cb_alterar_st.Enabled	= False		
	End If
	
	If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> "WS" Then
		Tab_1.TabPage_5.cb_Enviar.Enabled	= False
		Tab_1.TabPage_5.cb_Gravar.Enabled	= False
	End If
End If

Tab_1.TabPage_5.cb_Exclui_Msg.Enabled	= False
end event

event close;call super::close;Destroy(io_Fornecedor)
end event

event ue_postopen;call super::ue_postopen;Tab_1.TabPage_2.dw_3.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_4.of_SetMenu(This.ivm_Menu)

Tab_1.TabPage_1.dw_1.Object.dh_inicio	[1] = RelativeDate(Date(gf_GetServerDate()),  -30)
Tab_1.TabPage_1.dw_1.Object.dh_fim		[1] = Date(gf_GetServerDate())

tab_1.TabPage_1.dw_2.Event ue_Recuperar()

String ls_Vl_Parametro

Select vl_parametro
	Into :ls_Vl_Parametro
From parametro_geral
Where cd_parametro = 'ID_ENVIA_EMAIL_CANCELAMENTO_AGEND'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If ls_Vl_Parametro = "S" Then
			Tab_1.TabPage_1.cb_reenvia.Visible = True
		Else
			Tab_1.TabPage_1.cb_reenvia.Visible = False
		End If
		
	Case 100
		Tab_1.TabPage_1.cb_reenvia.Visible = False
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro geral 'ID_ENVIA_EMAIL_CANCELAMENTO_AGEND'. " + SqlCa.SqlErrText, StopSign!)
		Return
End Choose

ib_valida_teste_integrado	= gf_valida_teste_integrado()
end event

event ue_cancel;//OverRide
wf_Popula_DataWindow()

This.ivm_Menu.mf_Confirmar(False)
This.ivm_Menu.mf_Cancelar(False)

Tab_1.TabPage_1.Enabled = True
Tab_1.TabPage_5.cb_Gravar.Enabled	 = False
end event

event ue_save;//OverRide

Boolean lb_Sucesso = False

Long ll_Find

String ls_Chave_Acesso

If wf_Salvar() Then	
	If wf_Exclui_Divergencias() Then
		lb_Sucesso = True
	End If
End If

If lb_Sucesso Then
	This.ivm_Menu.mf_Confirmar(False)
	This.ivm_Menu.mf_Cancelar(False)
	
	Tab_1.TabPage_1.Enabled = True
	
	SqlCa.of_Commit()
	
	wf_verifica_novas_divergencias()
	
	ls_Chave_Acesso = is_Chave_Acesso
	
	//Tab_1.TabPage_1.dw_2.Event ue_Recuperar()
	
	
	ll_Find = Tab_1.TabPage_1.dw_2.Find("de_chave_acesso = '" +ls_Chave_Acesso+"'" , 1, Tab_1.TabPage_1.dw_2.RowCount())
			
	If ll_Find < 0 Then
		MessageBox("Erro", "Erro no Find do evento ue_Save")	
		Return 1
	End If
	If ll_Find > 0 Then		
		Tab_1.TabPage_1.dw_2.SetRow(ll_Find)
		Tab_1.TabPage_1.dw_2.ScrollToRow(ll_Find)
	End If	
	
	This.Tab_1.SelectTab(1)
	
	MessageBox("Sucesso", "Altera$$HEX2$$e700f500$$ENDHEX$$es realizadas com Sucesso!")
	
Else
	SqlCa.of_Rollback()
	
	Return -1 
End If
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge331_manutencao_divergencia_nf_compra
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge331_manutencao_divergencia_nf_compra
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge331_manutencao_divergencia_nf_compra
integer x = 18
integer width = 3767
integer height = 2004
boolean powertips = true
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type

on tab_1.create
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_3
this.Control[iCurrent+2]=this.tabpage_4
this.Control[iCurrent+3]=this.tabpage_5
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
end on

event tab_1::selectionchanging;//OverRide

Choose Case oldIndex
	Case 1
		If Tab_1.TabPage_1.dw_2.RowCount() < 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um nota.")
			Return 1
		End If
		
	Case  2 
		Tab_1.TabPage_2.dw_3.AcceptText()
		If Tab_1.TabPage_2.dw_3.ModifiedCount() > 0 Then		
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem informa$$HEX2$$e700f500$$ENDHEX$$es que ainda n$$HEX1$$e300$$ENDHEX$$o foram salvas. ~r~r" + &
											 "Deseja sair dessa aba sem salv$$HEX1$$e100$$ENDHEX$$-las ?", Question!, YesNo!, 2) = 1 Then
											 
				Parent.Event ue_Cancel()
			Else			
				Return 1
			End If	
		End If
		
	Case 3
		Tab_1.TabPage_3.dw_4.AcceptText()
		If Tab_1.TabPage_3.dw_4.ModifiedCount() > 0 Then		
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem informa$$HEX2$$e700f500$$ENDHEX$$es que ainda n$$HEX1$$e300$$ENDHEX$$o foram salvas. ~r~r" + &
											 "Deseja sair dessa aba sem salv$$HEX1$$e100$$ENDHEX$$-las ?", Question!, YesNo!, 2) = 1 Then
											 
				Parent.Event ue_Cancel()
			Else			
				Return 1
			End If	
		End If
		
		tab_1.tabPage_3.dw_4.ivo_Controle_Menu.of_SalvarComo(False)
		
		If  NewIndex = 1 Then
			Tab_1.TabPage_1.dw_1.SetFocus()
		End If
		
	Case 5
		Tab_1.TabPage_3.dw_4.AcceptText()
		If Tab_1.TabPage_3.dw_4.ModifiedCount() > 0 Then		
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem informa$$HEX2$$e700f500$$ENDHEX$$es que ainda n$$HEX1$$e300$$ENDHEX$$o foram salvas. ~r~r" + &
											 "Deseja sair dessa aba sem salv$$HEX1$$e100$$ENDHEX$$-las ?", Question!, YesNo!, 2) = 1 Then
											 
				Parent.Event ue_Cancel()
			Else			
				Return 1
			End If	
		End If
		
		If  NewIndex = 1 Then
			Tab_1.TabPage_1.dw_1.SetFocus()
		End If
		
End Choose
end event

event tab_1::selectionchanged;//OverRide
Long ll_Item

If newIndex = 1 Then
	Parent.ivm_Menu.mf_recuperar( True)
	
	If oldIndex <> 1 Then
		Tab_1.TabPage_1.dw_2.SetFocus()	
	End If
	
	If oldIndex = 3 Then
		Tab_1.TabPage_1.dw_1.SetFocus()	
	End If
Else
	
	Parent.ivm_Menu.mf_recuperar( False)
	
	If newIndex = 3 Then
		Tab_1.TabPage_3.dw_6.Reset()
		
		If tab_1.tabPage_3.dw_4.GetRow() > 0 Then
			tab_1.tabPage_3.dw_4.AcceptText()
			
			ll_Item	= tab_1.tabPage_3.dw_4.Object.nr_item	[tab_1.tabPage_3.dw_4.GetRow()]
			
			Tab_1.TabPage_3.dw_6.Retrieve(is_Chave_Acesso, ll_Item)
			
			tab_1.tabPage_3.dw_4.ivo_Controle_Menu.of_SalvarComo(True)
		End If
	End If
	
	If newIndex = 5 Then
		
		If Not IsNull(Tab_1.tabPage_5.dw_8.Object.De_Mensagem[1]) And Tab_1.tabPage_5.dw_8.Object.De_Mensagem[1] <> "" Then
			Tab_1.TabPage_5.cb_Exclui_Msg.Enabled = True
		Else
			Tab_1.TabPage_5.cb_Exclui_Msg.Enabled = False
		End If
		
		If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "WS" Then
			
//			If Not IsNull(Tab_1.TabPage_5.dw_8.Object.Dh_Envio_Site[1]) Then
				Tab_1.TabPage_5.cb_Gravar.Enabled = True
//			Else
//				Tab_1.TabPage_5.cb_Gravar.Enabled = False			
//			End If
//			
//			 If Not IsNull(Tab_1.TabPage_5.dw_8.Object.Dh_Envio_Site[1]) And Not IsNull(Tab_1.TabPage_5.dw_8.Object.De_Mensagem[1]) And Tab_1.TabPage_5.dw_8.Object.De_Mensagem[1] <> "" Then
				Tab_1.TabPage_5.cb_Enviar.Enabled = True
//			 Else
//				Tab_1.TabPage_5.cb_Enviar.Enabled = False
//			 End If
			 
		Else
			
			Tab_1.TabPage_5.cb_Enviar.Enabled			= False
			Tab_1.TabPage_5.cb_Gravar.Enabled			= False
//			Tab_1.TabPage_5.cb_Exclui_Msg.Enabled	= False
		End If
	End If
End If
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 3730
integer height = 1888
gb_5 gb_5
dw_5 dw_5
cb_liberacao cb_liberacao
cb_cancelar_agendamento cb_cancelar_agendamento
cb_validar_nf cb_validar_nf
cb_reenvia cb_reenvia
cb_descancelar_agendamento cb_descancelar_agendamento
st_sap st_sap
cb_reenvio_portal cb_reenvio_portal
cb_2 cb_2
end type

on tabpage_1.create
this.gb_5=create gb_5
this.dw_5=create dw_5
this.cb_liberacao=create cb_liberacao
this.cb_cancelar_agendamento=create cb_cancelar_agendamento
this.cb_validar_nf=create cb_validar_nf
this.cb_reenvia=create cb_reenvia
this.cb_descancelar_agendamento=create cb_descancelar_agendamento
this.st_sap=create st_sap
this.cb_reenvio_portal=create cb_reenvio_portal
this.cb_2=create cb_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_5
this.Control[iCurrent+2]=this.dw_5
this.Control[iCurrent+3]=this.cb_liberacao
this.Control[iCurrent+4]=this.cb_cancelar_agendamento
this.Control[iCurrent+5]=this.cb_validar_nf
this.Control[iCurrent+6]=this.cb_reenvia
this.Control[iCurrent+7]=this.cb_descancelar_agendamento
this.Control[iCurrent+8]=this.st_sap
this.Control[iCurrent+9]=this.cb_reenvio_portal
this.Control[iCurrent+10]=this.cb_2
end on

on tabpage_1.destroy
call super::destroy
destroy(this.gb_5)
destroy(this.dw_5)
destroy(this.cb_liberacao)
destroy(this.cb_cancelar_agendamento)
destroy(this.cb_validar_nf)
destroy(this.cb_reenvia)
destroy(this.cb_descancelar_agendamento)
destroy(this.st_sap)
destroy(this.cb_reenvio_portal)
destroy(this.cb_2)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 444
integer width = 3675
integer height = 1072
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 3675
integer height = 324
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 55
integer y = 80
integer width = 3515
integer height = 236
string dataobject = "dw_ge331_selecao"
boolean maxbox = true
end type

event dw_1::itemchanged;call super::itemchanged;wf_Reset_DW()

If dwo.Name = "nm_fornecedor" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> io_Fornecedor.Nm_Razao_Social Then
			Return 1
		End If
	Else
		io_Fornecedor.of_Inicializa()
		
		This.Object.Cd_Fornecedor	[1] = io_Fornecedor.Cd_Fornecedor
		This.Object.Nm_Fornecedor	[1] = io_Fornecedor.Nm_Razao_Social
	End If
End If

end event

event dw_1::losefocus;call super::losefocus;If IsValid(io_Fornecedor) Then
	This.Object.Cd_Fornecedor	[1] = io_Fornecedor.Cd_Fornecedor
	This.Object.Nm_Fornecedor	[1] = io_Fornecedor.Nm_Razao_Social
End If

end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_fornecedor" Then
		io_Fornecedor.of_Localiza_Fornecedor(This.GetText())
		
		If io_Fornecedor.Localizado Then
			This.Object.Cd_Fornecedor	[1] = io_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor	[1] = io_Fornecedor.Nm_Razao_Social
		End If
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;wf_Reset_DW()
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer y = 488
integer width = 3611
integer height = 996
string dataobject = "dw_ge331_lista"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_2::rowfocuschanged;call super::rowfocuschanged;String ls_Retorno_Site
Date   ldt_Envio_Site
Date   ldt_Cancelamento

If currentRow > 0 Then
		
	ls_Retorno_Site 	= 	Tab_1.TabPage_1.dw_2.Object.de_retorno_webservice[Tab_1.TabPage_1.dw_2.GetRow()]
	ldt_Envio_Site 		= 	Date (Tab_1.TabPage_1.dw_2.Object.dh_envio_site[Tab_1.TabPage_1.dw_2.GetRow()]) 	
    ldt_Cancelamento =  Date (Tab_1.TabPage_1.dw_2.Object.dh_cancelamento_agendamento[Tab_1.TabPage_1.dw_2.GetRow()]) 	 
	
	If Not IsNull(ls_Retorno_Site) Then
		Tab_1.TabPage_1.gb_5.Text = "Diverg$$HEX1$$ea00$$ENDHEX$$ncia Retorno Site: PROBLEMA NO PORTAL.COM"
		Tab_1.TabPage_1.dw_5.of_ChangeDataObject("dw_ge331_divergencia_site")
	Else
		Tab_1.TabPage_1.gb_5.Text = "Diverg$$HEX1$$ea00$$ENDHEX$$ncias"
		Tab_1.TabPage_1.dw_5.of_ChangeDataObject("dw_ge331_lista_divergencias")
	End If
	
	// Habilita e Desbilita Bot$$HEX1$$e300$$ENDHEX$$o Re-EnvioPortal	
	If IsNull (ldt_Cancelamento)    Then 
		//If Not IsNull (ldt_Envio_Site) Then 
		cb_reenvio_portal.enabled  = True 
		//Else
		//	cb_reenvio_portal.enabled  = False
		//End If 
	Else
		cb_reenvio_portal.enabled  = False	
	End If 
	
	
	Tab_1.TabPage_1.dw_5.of_SetRowSelection()
	
	wf_Popula_DataWindow()	
End If

end event

event dw_2::constructor;call super::constructor;//Tab_1.TabPage_1.dw_2.of_SetRowSelection("if(not isnull(dh_envio_site), if(getrow() = currentrow(), rgb(0, 176, 176), rgb(140, 255, 255)), if(not isnull(de_retorno_webservice),  if(getrow() = currentrow(), rgb(198, 198, 0),rgb(255, 255, 0)), if (not isnull(dh_liberacao_agendamento), if(getrow() = currentrow(), rgb(0, 111, 0), rgb(0, 255, 0)), if((qt_divergencia_nota > 0) or (qt_divergencia_produto > 0), if(getrow() = currentrow(), rgb(187, 0, 0), rgb(255, 130, 130)), if(getrow() = currentrow(), rgb(0,128,128), rgb(255,255,255))))))", "", false)
//Tab_1.TabPage_1.dw_2.of_SetRowSelection("if(qt_nf_cancelada > 0, if(getrow() = currentrow(), rgb(108, 0, 217), rgb(210, 166, 255)), if(not isnull(dh_envio_site), if(getrow() = currentrow(), rgb(0, 176, 176), rgb(140, 255, 255)), if(not isnull(de_retorno_webservice),  if(getrow() = currentrow(), rgb(198, 198, 0),rgb(255, 255, 0)), if (not isnull(dh_liberacao_agendamento), if(getrow() = currentrow(), rgb(0, 111, 0), rgb(0, 255, 0)), if((qt_divergencia_nota > 0) or (qt_divergencia_produto > 0), if(getrow() = currentrow(), rgb(187, 0, 0), rgb(255, 130, 130)), if(getrow() = currentrow(), rgb(0,128,128), rgb(255,255,255)))))))", "", false)
//Tab_1.TabPage_1.dw_2.of_SetRowSelection("if(not isnull(dh_cancelamento_agendamento), if(getrow() = currentrow(), rgb(0, 0, 255), rgb(85, 85, 255)), if(qt_nf_cancelada > 0, if(getrow() = currentrow(), rgb(108, 0, 217), rgb(210, 166, 255)), if(not isnull(dh_envio_site), if(getrow() = currentrow(), rgb(0, 176, 176), rgb(140, 255, 255)), if(not isnull(de_retorno_webservice),  if(getrow() = currentrow(), rgb(198, 198, 0),rgb(255, 255, 0)), if (not isnull(dh_liberacao_agendamento), if(getrow() = currentrow(), rgb(0, 111, 0), rgb(0, 255, 0)), if((qt_divergencia_nota > 0) or (qt_divergencia_produto > 0), if(getrow() = currentrow(), rgb(187, 0, 0), rgb(255, 130, 130)), if(getrow() = currentrow(), rgb(0,128,128), rgb(255,255,255))))))))", "", false)
end event

event dw_2::ue_recuperar;//OverRide

DateTime 	ldh_Inicio,&
				ldh_Fim	
				
String	ls_Fornecedor,&
		ls_Situacao,&
		ls_Chave_Acesso,&
		ls_Especie,&
		ls_Serie
		
Long	ll_Nota	,&
		ll_Pedido

This.of_RestoreOriginalSQL()
				
Tab_1.TabPage_1.dw_1.AcceptText()

ldh_Inicio			= Tab_1.TabPage_1.dw_1.Object.dh_inicio				[1]
ldh_Fim				= Tab_1.TabPage_1.dw_1.Object.dh_fim				[1]
ls_Fornecedor		= Tab_1.TabPage_1.dw_1.Object.cd_fornecedor		[1]
ls_Situacao			= Tab_1.TabPage_1.dw_1.Object.id_situacao			[1]
ls_Chave_Acesso	= Tab_1.TabPage_1.dw_1.Object.de_chave_acesso	[1]
ls_Especie			= Tab_1.TabPage_1.dw_1.Object.de_especie			[1]
ls_Serie				= Tab_1.TabPage_1.dw_1.Object.de_serie				[1]
ll_Nota				= Tab_1.TabPage_1.dw_1.Object.nr_nf					[1]
ll_Pedido				= Tab_1.TabPage_1.dw_1.Object.nr_pedido			[1]

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe  a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ldh_Fim) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe  a data final.")
	dw_1.Event ue_Pos(1, "dh_fim")
	Return -1
End If

If ldh_Inicio > ldh_Fim Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data final.")
	dw_1.Event ue_Pos(1, "dh_inicio")	
	Return -1
End If
	
If Not IsNull(ls_Chave_Acesso) and ls_Chave_Acesso <> "" Then
	if ib_valida_teste_integrado then
		This.of_AppendWhere_subquery(" exists (select 1 from recebimento_sap rs where rs.de_chave_acesso_alterada = '" + ls_Chave_Acesso + "' and de_chave_acesso = a.de_chave_acesso)", 11)
	else
		This.of_AppendWhere_subquery("a.de_chave_acesso = '"+ls_Chave_Acesso+"'", 11)
	end if
End If

If Not IsNull(ll_Nota) and ll_Nota <> 0 Then
	This.of_AppendWhere_subquery("a.nr_nf = "+String(ll_Nota), 11)
End If

If Not IsNull(ls_Especie) and ls_Especie <> "" Then
	This.of_AppendWhere_subquery("a.de_especie = '"+ls_Especie+"'", 11)
End If

If Not IsNull(ls_Serie) and ls_Serie <> "" Then
	This.of_AppendWhere_subquery("a.de_serie = '"+ls_Serie+"'", 11)
End If

If Not IsNull(ls_Fornecedor) and ls_Fornecedor <> "" Then
	This.of_AppendWhere_subquery("d.cd_fornecedor = '"+ls_Fornecedor+"'", 11)
End If

If Not IsNull(ll_Pedido) and ll_Pedido <> 0 Then
	This.of_AppendWhere_subquery("a.nr_pedido_central = "+String(ll_Pedido), 11)
End If

If ls_Situacao <> "T" Then
	Choose Case ls_Situacao
		Case "L" //LIBERADOS P/ AGENDAMENTO
			This.of_AppendWhere_subquery("a.dh_liberacao_agendamento is not null and a.de_retorno_webservice is null and a.dh_envio_site is null", 11)
			
		Case "D" //DIVERGENTES
			
			// Notas que n$$HEX1$$e300$$ENDHEX$$o foram liberadas e com divergencia na nota ou nos itens
			This.of_AppendWhere_subquery("((a.dh_liberacao_agendamento is null and  (exists (select * from nf_agendamento_ent_divergencia x where x.de_chave_acesso = a.de_chave_acesso) or exists (select * from nf_agendamento_ent_item_diverg z where z.de_chave_acesso = a.de_chave_acesso) ) ) or a.de_retorno_webservice is not null)", 11)
			// N$$HEX1$$e300$$ENDHEX$$o considerar as canceladas
			This.of_AppendWhere_subquery("not exists (select * from nfe_destinadas where de_chave_acesso = a.de_chave_acesso and id_situacao_nf = '3')", 11)
			//N$$HEX1$$e300$$ENDHEX$$o considera agendamento cancelado
			This.of_AppendWhere_subquery("a.dh_cancelamento_agendamento is null", 11)
		
			
//			This.of_AppendWhere_subquery("a.dh_liberacao_agendamento is null and  (exists (select * from nf_agendamento_ent_divergencia x where x.de_chave_acesso = a.de_chave_acesso) or	exists (select * from nf_agendamento_ent_item_diverg z where z.de_chave_acesso = a.de_chave_acesso) or a.de_retorno_webservice is not null)", 6)
//			// N$$HEX1$$e300$$ENDHEX$$o considerar as canceladas
//			This.of_AppendWhere_subquery("not exists (select * from nfe_destinadas where de_chave_acesso = a.de_chave_acesso and id_situacao_nf = '3')", 6)	
//			// Considera as notas que deram erro ao enviar ao sefaz
//			This.of_AppendWhere_subquery("a.de_retorno_webservice is not null", 6)
			
		Case "X" //ERRO AO ENVIAR NF P/ SITE
			This.of_AppendWhere_subquery("a.de_retorno_webservice is not null", 11)
			
		Case "E" //ENVIADO P/ SITE
			This.of_AppendWhere_subquery("a.dh_envio_site is not null", 11)
			
		Case "C" //CANCELADAS SEFAZ
			This.of_AppendWhere_subquery("exists (select * from nfe_destinadas where de_chave_acesso = a.de_chave_acesso and id_situacao_nf = '3')", 11)
			
		Case "A" //AGENDAMENTO CANCELADO
			This.of_AppendWhere_subquery("a.dh_cancelamento_agendamento is not null", 11)
			
		Case "J"  // NOTAS NAO ENTREGUES NO CD   :   
			This.of_AppendWhere_subquery("not exists (select * from nfe_destinadas where de_chave_acesso = a.de_chave_acesso and id_situacao_nf = '3')", 11)
			This.of_AppendWhere_subquery("a.dh_envio_site is not null", 11)
			This.of_AppendWhere_subquery("a.dh_cancelamento_agendamento is null", 11)
			This.of_AppendWhere_subquery("(select count(*) from nf_compra_pendente where de_chave_acesso = n.id_nf)  + (select count(*) from nf_compra where de_chave_acesso = n.id_nf)=0", 11)
			
		Case "R"
			This.of_AppendWhere_subquery("r.dh_atualizacao is not null", 11)
	End Choose
End If

//messagebox("", String(This.Object.Datawindow.Table.Select))

Return This.Retrieve(Date(ldh_Inicio), Date(ldh_Fim))
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Boolean lvb_Habilita = False

If pl_Linhas > 0 Then
	This.ScrollToRow(1)
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
	
	lvb_Habilita = True
	
ElseIf pl_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
End If

This.ivo_Controle_Menu.of_Imprimir(lvb_Habilita)
This.ivo_Controle_Menu.of_SalvarComo(lvb_Habilita)

Return pl_Linhas
end event

event dw_2::editchanged;call super::editchanged;Long ll_Produto, lvl_Linha

Datetime ldt_Previsa_Entrega

lvl_Linha=GetRow()

//ll_Produto= This.Object.cd_produto[lvl_Linha]
ldt_Previsa_Entrega= This.Object.dh_previsao_entrega[lvl_Linha]

If This.GetColumnName() ='dh_previsao_entrega' Then
	
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Cancelar(True)
		
End If
end event

event dw_2::buttonclicked;call super::buttonclicked;string	ls_chave_acesso

ls_chave_acesso = string(Tab_1.TabPage_1.dw_2.Object.de_chave_acesso[row])

   Choose case dwo.name
		Case 'cb_historico'
			OpenWithParm(w_ge331_historico_agendamento, ls_chave_acesso)
		
End Choose
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 3730
integer height = 1888
cb_copiar cb_copiar
cb_localizar_pedido cb_localizar_pedido
end type

on tabpage_2.create
this.cb_copiar=create cb_copiar
this.cb_localizar_pedido=create cb_localizar_pedido
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_copiar
this.Control[iCurrent+2]=this.cb_localizar_pedido
end on

on tabpage_2.destroy
call super::destroy
destroy(this.cb_copiar)
destroy(this.cb_localizar_pedido)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 3310
integer height = 1804
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 64
integer y = 60
integer width = 3255
integer height = 1668
string dataobject = "dw_ge331_detalhes_nota"
end type

event dw_3::editchanged;call super::editchanged;wf_Habilita_Menu()
end event

event dw_3::itemchanged;call super::itemchanged;wf_Habilita_Menu()
end event

type gb_5 from groupbox within tabpage_1
integer x = 23
integer y = 1524
integer width = 3685
integer height = 344
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Diverg$$HEX1$$ea00$$ENDHEX$$ncias"
borderstyle borderstyle = styleraised!
end type

type dw_5 from dc_uo_dw_base within tabpage_1
integer x = 64
integer y = 1580
integer width = 3625
integer height = 272
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge331_lista_divergencias"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_liberacao from commandbutton within tabpage_1
integer x = 805
integer y = 352
integer width = 402
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Liberar Agend."
end type

event clicked;String	ls_Operador, ls_Chave_Acesso, ls_Motivo, ls_Nulo, ls_msg

Date ldh_Liberacao

DateTime ldh_Cancelamento, ldh_Nulo

Integer li_Divergencia_NF, li_Divergencia_Item, li_Nat_Op_Nao_Liberada, li_CFOP, li_Pedido_Central

Long ll_Bloqueado
Long ll_BloqueadoCNPJ

Boolean lb_Possui_Divergencia

Tab_1.TabPage_1.dw_2.RowCount()

If Tab_1.TabPage_1.dw_2.RowCount() < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma nota.")
	Return 1
End If

SetNull(ldh_Nulo)
SetNull(ls_Nulo)

ls_Chave_Acesso = Tab_1.TabPage_1.dw_2.Object.de_chave_acesso			[Tab_1.TabPage_1.dw_2.getrow()]
li_CFOP 			   = Tab_1.TabPage_3.dw_4.Object.cd_natureza_operacao		[1]
li_Pedido_Central = Tab_1.TabPage_1.dw_2.Object.nr_pedido_central			[Tab_1.TabPage_1.dw_2.getrow()]

If Not wf_Verifica_Msg_Recusa(ls_Chave_Acesso) Then Return -1

//Se for nota de remessa de amostra gr$$HEX1$$e100$$ENDHEX$$tis (CFOP 5911 dentro do estado e 6911 fora do estado), permite o usu$$HEX1$$e100$$ENDHEX$$rio liberar a NF sem pedido e sem c$$HEX1$$f300$$ENDHEX$$digo de produto
If (li_CFOP = 5911 Or li_CFOP = 5949 Or li_CFOP = 6910 Or li_CFOP = 6911) And IsNull(li_Pedido_Central)  Then
	
		select count(*)
		Into :ll_Bloqueado
		from nf_agendamento_ent n
		where exists (	select *
						from nf_agendamento_ent_item_diverg d
						inner join tipo_divergencia_ped_central t
						on t.cd_tipo_divergencia = d.cd_tipo_divergencia
						 where d.de_chave_acesso = n.de_chave_acesso
						 and t.id_bloqueia_entrada_xml = 'S'	
						 and t.cd_tipo_divergencia not in (6, 7)) //C$$HEX1$$f300$$ENDHEX$$digos de divergencia de 6 - Cd produto nao localizado e 7 - Produto sem EAN
		and n.de_chave_acesso = :ls_Chave_Acesso
		Using SqlCa;
	
	Else
		select count(*)
		Into :ll_Bloqueado
		from nf_agendamento_ent n
		where exists (	select *
						from nf_agendamento_ent_item_diverg d
						inner join tipo_divergencia_ped_central t
						on t.cd_tipo_divergencia = d.cd_tipo_divergencia
						 where d.de_chave_acesso = n.de_chave_acesso
						 and t.id_bloqueia_entrada_xml = 'S'	)
		and n.de_chave_acesso = :ls_Chave_Acesso
		Using SqlCa;
		
		If ll_Bloqueado = 0 Then
			If IsNull(li_Pedido_Central) or li_Pedido_Central = 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitida a libera$$HEX2$$e700e300$$ENDHEX$$o <<SEM PEDIDO>>.")
				Return -1
			End If
		End If	
		
End If

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro ao consultar se existe algum bloqueio que n$$HEX1$$e300$$ENDHEX$$o permita a libera$$HEX2$$e700e300$$ENDHEX$$o do agendamento.")
	Return -1
End If

If ll_Bloqueado > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existe(m) diverg$$HEX1$$ea00$$ENDHEX$$ncia(s) que n$$HEX1$$e300$$ENDHEX$$o permite(m) a libera$$HEX2$$e700e300$$ENDHEX$$o para o agendamento.", Exclamation!)
	Return -1
End If

Select dh_liberacao_agendamento 
Into :ldh_Liberacao
From nf_agendamento_ent
where de_chave_acesso = :ls_Chave_Acesso
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(ldh_Liberacao) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nota j$$HEX1$$e100$$ENDHEX$$ liberada para agendamento.")
			Return
		End If
	Case 100
	Case -1
		SqlCa.of_MsgDbError("Erro ao localizar a data de libera$$HEX2$$e700e300$$ENDHEX$$o do agendamento.")
		Return
End Choose

Select dh_cancelamento_agendamento
	Into :ldh_Cancelamento
From nf_agendamento_ent
Where de_chave_acesso = :ls_Chave_Acesso
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(ldh_Cancelamento) Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O agendamento j$$HEX1$$e100$$ENDHEX$$ foi cancelado. Deseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then
				Return -1
			End If
			
			Update nf_agendamento_ent
				Set 	dh_cancelamento_agendamento	= :ldh_Nulo,
						nr_matricula_canc_agendamento	= :ls_Nulo,
						de_motivo_lib_agendamento 		= :ls_Nulo
				Where de_chave_acesso = :ls_Chave_Acesso
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_RollBack()
				MessageBox("Erro", "Erro ao cancelar o agendamento: "+ SqlCa.SQLErrText)
				Return 1
			End If
		End If
		
	Case 100
		SqlCa.of_MsgdbError("Erro ao localizar a data de cancelamento do agendamento.")
		Return -1
	Case -1
End Choose

If Not wf_Possui_Divergencias(ls_Chave_Acesso, Ref lb_Possui_Divergencia) Then
	Return 1
End If

// Nova Valida$$HEX2$$e700e300$$ENDHEX$$o: O CNPJ DO EMISSOR DA NOTA $$HEX1$$e800$$ENDHEX$$ DIFERENTE DO FORNECEDOR DO PEDIDO: N$$HEX1$$e300$$ENDHEX$$o Permite Liberar!
If ib_DivergenciaCNPJFornecedor Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existe(m) diverg$$HEX1$$ea00$$ENDHEX$$ncia(s) que n$$HEX1$$e300$$ENDHEX$$o permite(m) a libera$$HEX2$$e700e300$$ENDHEX$$o para o agendamento.", Exclamation!)
	Return -1	
End If 

If lb_Possui_Divergencia Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem diverg$$HEX1$$ea00$$ENDHEX$$ncias para a nota selecionada.~rDeseja liberar para o agendamento mesmo assim ?", Question!, YesNo!, 2) = 2 Then
		Return 1	
	End If
End If

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE331_LIBERAR_AGENDAMENTO", ref ls_Operador) Then 
	Return
End If	

OpenWithParm(w_ge331_motivo_liberacao,"")
ls_Motivo = Message.StringParm
	
If IsNull(ls_Motivo) Then Return

Update nf_agendamento_ent
Set 	dh_liberacao_agendamento		= getdate(),
		nr_matricula_lib_agendamento	= :ls_Operador,
		de_motivo_lib_agendamento 	= :ls_Motivo
Where de_chave_acesso = :is_Chave_Acesso
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack()
	MessageBox("Erro", "Erro ao liberar a nota para agendamento: "+ SqlCa.SQLErrText)		
	Return 1
End If	

SqlCa.of_Commit()

Tab_1.TabPage_1.dw_2.Reset()
Tab_1.TabPage_1.dw_2.Event ue_Recuperar()
end event

type cb_cancelar_agendamento from commandbutton within tabpage_1
integer x = 343
integer y = 352
integer width = 457
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar Agend."
end type

event clicked;Boolean lb_Possui_Divergencia
Boolean lb_Permite

DateTime ldh_Cancelamento

String	ls_Operador,&
		ls_Motivo

Tab_1.TabPage_1.dw_2.AcceptText()

If Tab_1.TabPage_1.dw_2.RowCount() > 0 Then

	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE331_CANCELA_AGENDAMENTO", ref ls_Operador) Then 
		Return 1
	End If
	
	ldh_Cancelamento = Tab_1.TabPage_1.dw_2.Object.Dh_Cancelamento_Agendamento[Tab_1.TabPage_1.dw_2.GetRow()]
	
	If Not IsNull(ldh_Cancelamento) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Este agendamento j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cancelado.")
		Return -1
	End If
	
	If Not wf_Permite_Cancelamento(Ref lb_Permite) Then Return -1
	
	If Not lb_Permite Then Return -1
	
//	If Not wf_Possui_Divergencias(is_Chave_Acesso, Ref lb_Possui_Divergencia) Then
//		Return 1
//	End If
//	
//	If Not lb_Possui_Divergencia Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Apenas notas com diverg$$HEX1$$ea00$$ENDHEX$$ncias poder$$HEX1$$e300$$ENDHEX$$o ser canceladas.")
//		Return 1
//	End If
	
	OpenWithParm(w_ge331_motivo_liberacao,"CANCELAR")
	ls_Motivo = Message.StringParm
		
	If IsNull(ls_Motivo) Then Return
	
	Update nf_agendamento_ent
		Set dh_cancelamento_agendamento	= getdate(),
			nr_matricula_canc_agendamento	= :ls_Operador,
			de_motivo_canc_agendamento  	= :ls_Motivo
	Where de_chave_acesso = :is_Chave_Acesso
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_RollBack()
		MessageBox("Erro", "Erro ao cancelar o agendamento: "+ SqlCa.SQLErrText)		
		Return 1
	End If
		
	SqlCa.of_Commit()
	
	If gvo_Aplicacao.ivs_DataSource = 'central' Then	
		If Not wf_Envia_Email_Cancelamento_Agend(ls_Operador, ls_Motivo) Then Return -1
	End If
	
	Tab_1.TabPage_1.dw_2.Reset()
	Tab_1.TabPage_1.dw_2.Event ue_Recuperar()
End If
end event

type cb_validar_nf from commandbutton within tabpage_1
integer x = 27
integer y = 352
integer width = 311
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Validar NF"
end type

event clicked;String	ls_Chave_Acesso

Long	ll_Pedido

If Tab_1.TabPage_1.dw_2.RowCount() > 0 Then
	
	ls_Chave_Acesso	=	Tab_1.TabPage_1.dw_2.Object.de_chave_acesso	[Tab_1.TabPage_1.dw_2.GetRow()]
	ldt_Emissao_Nf		=	Date(Tab_1.TabPage_1.dw_2.Object.dh_emissao	[Tab_1.TabPage_1.dw_2.GetRow()])
	
	Select nr_pedido_central
	Into	:ll_Pedido
	From  nf_agendamento_ent 
	Where de_chave_acesso = :ls_Chave_Acesso
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If IsNull(ll_Pedido) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para validar a nota primeiro deve ser preenchido o pedido.")
				tab_1.SelectTab(2)
				tab_1.tabPage_2.dw_3.SetFocus()
				Return 1
			End If
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado a nota no agendamento com a chave de acesso '"+ls_Chave_Acesso+"'.")
			Return 1
		Case -1
			SqlCa.of_MsgDbError("Erro ao verificar se o pedido est$$HEX1$$e100$$ENDHEX$$ vinculado a nota.")
			Return 1
	End Choose
	
	If Not wf_Verifica_Msg_Recusa(ls_Chave_Acesso) Then Return -1
	
	wf_Verifica_Divergencias()
	
End If
end event

type cb_reenvia from commandbutton within tabpage_1
integer x = 1367
integer y = 56
integer width = 443
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Reenvia E-mail"
end type

event clicked;String ls_Operador
String ls_Motivo

Tab_1.TabPage_1.dw_2.AcceptText()

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE331_CANCELA_AGENDAMENTO", Ref ls_Operador) Then 
	Return 1
End If

ls_Motivo = Tab_1.TabPage_1.dw_2.Object.De_Motivo_Lib_Agendamento[Tab_1.TabPage_1.dw_2.GetRow()]

If Not wf_Envia_Email_Cancelamento_Agend(ls_Operador, ls_Motivo) Then Return -1
end event

type cb_descancelar_agendamento from commandbutton within tabpage_1
integer x = 1211
integer y = 352
integer width = 549
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Descancelar Agend."
end type

event clicked;DateTime ldh_Cancelamento

String	ls_Operador, ls_Nulo, ls_Msg

SetNull(ls_Nulo)

Tab_1.TabPage_1.dw_2.AcceptText()

If Tab_1.TabPage_1.dw_2.RowCount() > 0 Then

	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE331_DESCANCELA_AGENDAMENTO", ref ls_Operador) Then 
		Return 1
	End If
	
	ldh_Cancelamento	= Tab_1.TabPage_1.dw_2.Object.Dh_Cancelamento_Agendamento	[Tab_1.TabPage_1.dw_2.GetRow()]
	
	If IsNull(ldh_Cancelamento) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente agendamento cancelado poder$$HEX1$$e100$$ENDHEX$$ ser DESCANCELADO.")
		Return -1
	End If
	
	//OpenWithParm(w_ge331_motivo_liberacao,"CANCELAR")
	//ls_Motivo = Message.StringParm
		
	//If IsNull(ls_Motivo) Then Return
	
	Update nf_agendamento_ent
		Set dh_cancelamento_agendamento	= null,
			nr_matricula_canc_agendamento	= null,
			de_motivo_canc_agendamento  	= null
	Where de_chave_acesso = :is_Chave_Acesso
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_RollBack()
		MessageBox("Erro", "Erro ao descancelar o agendamento: "+ SqlCa.SQLErrText)		
		Return 1
	End If
	
	//Grava hist$$HEX1$$f300$$ENDHEX$$rico se houver um "descancelamento"
	If Not gf_Grava_Historico_Alteracao_Tabela('NF_AGENDAMENTO_ENT', is_Chave_Acesso, 'DH_CANCELAMENTO_AGENDAMENTO', String(ldh_Cancelamento), ls_Nulo, ls_Operador, "A", Ref ls_Msg, True) Then Return -1
	
	SqlCa.of_Commit()
	
//	If gvo_Aplicacao.ivs_DataSource = 'central' Then	
//		If Not wf_Envia_Email_Cancelamento_Agend(ls_Operador, ls_Motivo) Then Return -1
//	End If
	Tab_1.TabPage_1.dw_2.Reset()
	Tab_1.TabPage_1.dw_2.Event ue_Recuperar()
End If
end event

type st_sap from statictext within tabpage_1
boolean visible = false
integer x = 2254
integer y = 340
integer width = 1504
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 134217856
long backcolor = 67108864
boolean enabled = false
string text = "As notas s$$HEX1$$e300$$ENDHEX$$o validas no GRC [SAP] - apenas CONSULTA "
boolean focusrectangle = false
end type

type cb_reenvio_portal from commandbutton within tabpage_1
integer x = 1765
integer y = 352
integer width = 480
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Re-Enviar Portal"
end type

event clicked;String	 	ls_Chave_Acesso, ls_Operador, ls_Nulo, ls_Msg
DateTime   	ldt_Envio_Anterior
Boolean 	lb_Sucesso  = False

SetNull(ls_Nulo)

Tab_1.TabPage_1.dw_2.AcceptText()

If Tab_1.TabPage_1.dw_2.RowCount() > 0 Then
	
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE331_REENVIO_PORTAL", ref ls_Operador) Then 
		Return 1
	End If
	
	// Chave de Acesso Para Update
	ls_Chave_Acesso		=	Tab_1.TabPage_1.dw_2.Object.de_chave_acesso		[Tab_1.TabPage_1.dw_2.GetRow()]
	ldt_Envio_Anterior		=	Tab_1.TabPage_1.dw_2.Object.dh_envio_site	[Tab_1.TabPage_1.dw_2.GetRow()]
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Antes de seguir, verifique no Entregou.Com se a Nota n$$HEX1$$e300$$ENDHEX$$o esta no portal! ~r~r" + &
									  "Deseja continuar e liberar para re-Envio?", Question!, YesNo!, 2) = 1 Then
	
		Update nf_agendamento_ent
		Set dh_envio_site	= null  ,  dh_liberacao_agendamento = getdate ()  
		Where de_chave_acesso = :is_Chave_Acesso
		Using SqlCa;
	
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro ao descancelar o agendamento: "+ SqlCa.SQLErrText)		
			Return 1
		End If 
		
		Delete From  nf_agendamento_ent_item_diverg 	
		Where de_chave_acesso = :is_Chave_Acesso
		Using SqlCA;
			
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro ao excluir diverg$$HEX1$$ea00$$ENDHEX$$ncias de Produto no Agendamento: "+ SqlCa.SQLErrText)		
			Return 1
		End If 
			
		Delete from nf_agendamento_ent_divergencia	
		Where de_chave_acesso = :is_Chave_Acesso
		Using SqlCA;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro ao excluir diverg$$HEX1$$ea00$$ENDHEX$$ncias de Gerais no Agendamento: "+ SqlCa.SQLErrText)		
			Return 1
		End If 
		
		update  recebimento_sap
		set     id_situacao  = 'P', 
				dh_nf_agend_ent_integrada =  getdate () 
		where  	de_chave_acesso = :is_Chave_Acesso
		Using SqlCA;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro ao excluir diverg$$HEX1$$ea00$$ENDHEX$$ncias de Gerais no Agendamento: "+ SqlCa.SQLErrText)		
			Return 1
		End If 
		
		lb_Sucesso = True 
	End If 	
End If 

If lb_Sucesso Then 
	//Grava hist$$HEX1$$f300$$ENDHEX$$rico se houver um "descancelamento"
	If Not gf_Grava_Historico_Alteracao_Tabela('NF_AGENDAMENTO_ENT', is_Chave_Acesso, 'DH_ENVIO_SITE', String(ldt_Envio_Anterior), ls_Nulo, ls_Operador, "A", Ref ls_Msg, True) Then 
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Problema ao gravar registro na tabela de agendamento.~r~rErro: ' + ls_Msg, StopSign!)
		SqlCa.of_RollBack()
		Return -1
	End If	
	
	SqlCa.of_Commit()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Nota Liberada para o Re-Envio. Aguarde o processamento dos envios do nosso sistema!") 
	Tab_1.TabPage_1.dw_2.Reset()
	Tab_1.TabPage_1.dw_2.Event ue_Recuperar()
else
	SqlCa.of_RollBack()
End If 
end event

type cb_2 from commandbutton within tabpage_1
integer x = 2898
integer y = 232
integer width = 763
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Excluir Registro de Entrada"
end type

event clicked;Boolean 	lb_Sucesso
Boolean lb_Permite

String	 ls_Chave_Acesso
String ls_Operador
String ls_Nulo
String ls_Msg

SetNull(ls_Nulo)

Tab_1.TabPage_1.dw_2.AcceptText()

If Tab_1.TabPage_1.dw_2.RowCount() > 0 Then
	
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE331_EXCLUIR_ENTRADA", ref ls_Operador) Then 
		Return 1
	End If

	//ls_Operador = '14231'
	
	ls_Chave_Acesso		=	Tab_1.TabPage_1.dw_2.Object.de_chave_acesso		[Tab_1.TabPage_1.dw_2.GetRow()]
	
	is_Chave_Acesso = ls_Chave_Acesso
	
	//select * from dbo.nf_compra_pendente_prd_item
//where cd_filial = 534  and cd_fornecedor = '053404408'and nr_nf = 982554 and de_especie = 'NFE' and de_serie = '21' 
//;

//select * from dbo.nf_compra_pendente_prd_lote
//where cd_filial = 534  and cd_fornecedor = '053404408'and nr_nf = 982554 and de_especie = 'NFE' and de_serie = '21' 
//;

//select * from dbo.nf_compra_pendente_produto
//where cd_filial = 534  and cd_fornecedor = '053404408'and nr_nf = 982554 and de_especie = 'NFE' and de_serie = '21' 
//;

//select * from dbo.titulo_pagar_pendente
//where cd_filial = 534  and cd_fornecedor = '053404408'and nr_nf = 982554 and de_especie = 'NFE' and de_serie = '21' 
//;
//
//select * from dbo.nf_compra_pendente
//where cd_filial = 534  and cd_fornecedor = '053404408'and nr_nf = 982554 and de_especie = 'NFE' and de_serie = '21' 
//;
	
	
	// Verifica se a nota j$$HEX1$$e100$$ENDHEX$$ n$$HEX1$$e300$$ENDHEX$$o foi recebida
	If Not wf_permite_processamento(Ref lb_Permite) Then Return 1
	
	If Not lb_Permite Then Return 1

	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja excluir todos os registros de entrada (RECEBIMENTO/NF_AGENDAMENTO/ENT). ~r~rSer$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio refazer o processo de entrada a partir do SAP. ~r~rDeseja continuar mesmo assim ?", Question!, YesNo!, 2) = 1 Then
		
		delete from nf_agendamento_ent_titulo
		where de_chave_acesso = :ls_Chave_Acesso
		Using SqlCA;
				
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro ao excluir dados da tabela: nf_agendamento_ent_titulo. "+ SqlCa.SQLErrText)		
			Return 1
		End If 
	 
		delete from nf_agendamento_ent_msg_recusa
		where de_chave_acesso = :ls_Chave_Acesso
		Using SqlCA;
				
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro ao excluir dados da tabela: nf_agendamento_ent_msg_recusa. "+ SqlCa.SQLErrText)		
			Return 1
		End If 
	
		delete from nf_agendamento_ent_item_lote
		where de_chave_acesso = :ls_Chave_Acesso
		Using SqlCA;
				
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro ao excluir dados da tabela: nf_agendamento_ent_item_lote. "+ SqlCa.SQLErrText)		
			Return 1
		End If 
	
		delete from nf_agendamento_ent_item_diverg
		where de_chave_acesso = :ls_Chave_Acesso
		Using SqlCA;
					
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro ao excluir dados da tabela: nf_agendamento_ent_item_diverg. "+ SqlCa.SQLErrText)		
			Return 1
		End If 
	
		delete from nf_agendamento_ent_item
		where de_chave_acesso = :ls_Chave_Acesso
		Using SqlCA;
				
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro ao excluir dados da tabela: nf_agendamento_ent_item. "+ SqlCa.SQLErrText)		
			Return 1
		End If 
	
		delete from nf_agendamento_ent_divergencia
		where de_chave_acesso = :ls_Chave_Acesso
		Using SqlCA;
				
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro ao excluir dados da tabela: nf_agendamento_ent_divergencia. "+ SqlCa.SQLErrText)		
			Return 1
		End If 
	
		delete from nf_agendamento_ent_diverg_hist
		where de_chave_acesso = :ls_Chave_Acesso
		Using SqlCA;
				
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro ao excluir dados da tabela: nf_agendamento_ent_diverg_hist. "+ SqlCa.SQLErrText)		
			Return 1
		End If 
	
		delete from nf_agendamento_ent
		where de_chave_acesso = :ls_Chave_Acesso
		Using SqlCA;
				
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro ao excluir dados da tabela: nf_agendamento_ent. "+ SqlCa.SQLErrText)		
			Return 1
		End If 
	
		delete from recebimento_sap_log
		where nr_recebimento in (select nr_recebimento  from dbo.recebimento_sap rs 
									where de_chave_acesso = :ls_Chave_Acesso)
		Using SqlCA;
				
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro ao excluir dados da tabela: recebimento_sap_log. "+ SqlCa.SQLErrText)		
			Return 1
		End If 
	
		delete from recebimento_sap_item
		where nr_recebimento in (select nr_recebimento  from dbo.recebimento_sap rs 
									where de_chave_acesso = :ls_Chave_Acesso)
		Using SqlCA;
				
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro ao excluir dados da tabela: nf_agendamento_ent_titulo. "+ SqlCa.SQLErrText)		
			Return 1
		End If 
	
		delete from recebimento_sap
		where de_chave_acesso = :ls_Chave_Acesso
		Using SqlCA;
				
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro ao excluir dados da tabela: recebimento_sap. "+ SqlCa.SQLErrText)		
			Return 1
		End If 
			
		Delete From  nf_agendamento_ent_item_diverg 	
		Where de_chave_acesso = :is_Chave_Acesso
		Using SqlCA;
			
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro ao excluir diverg$$HEX1$$ea00$$ENDHEX$$ncias de Produto no Agendamento: "+ SqlCa.SQLErrText)		
			Return 1
		End If 
			
		Delete from nf_agendamento_ent_divergencia	
		Where de_chave_acesso = :is_Chave_Acesso
		Using SqlCA;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro ao excluir diverg$$HEX1$$ea00$$ENDHEX$$ncias de Gerais no Agendamento: "+ SqlCa.SQLErrText)		
			Return 1
		End If 
						
		lb_Sucesso = True 
	End If 	
End If 

If lb_Sucesso Then 
	If Not gf_Grava_Historico_Alteracao_Tabela('NF_AGENDAMENTO_ENT', is_Chave_Acesso, 'EXCLUSAO_ENTRADA', "X", ls_Nulo, ls_Operador, "E", Ref ls_Msg, True) Then Return -1
	SqlCa.of_Commit()
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Registros de entrada foram exclu$$HEX1$$ed00$$ENDHEX$$dos com sucesso - Refa$$HEX1$$e700$$ENDHEX$$a o processo desde o SAP.") 
	Tab_1.TabPage_1.dw_2.Reset()
	Tab_1.TabPage_1.dw_2.Event ue_Recuperar()
End If 
end event

type cb_copiar from commandbutton within tabpage_2
integer x = 2149
integer y = 136
integer width = 704
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Copia a chave de acesso"
end type

event clicked;Integer lvi_Retorno

Try
	Tab_1.TabPage_2.dw_3.Modify("de_chave_acesso.tabsequence=20")
	Tab_1.TabPage_2.dw_3.Event ue_Pos(1, "de_chave_acesso")
	
	Tab_1.TabPage_2.dw_3.Event ue_Pos(1, "de_chave_acesso")
	
	Tab_1.TabPage_2.dw_3.SelectText(1, 44)
	
	lvi_Retorno = Tab_1.TabPage_2.dw_3.Copy()
	
	Choose Case lvi_Retorno
		Case -1  // Vazio
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum informa$$HEX2$$e700e300$$ENDHEX$$o foi selecionada para a c$$HEX1$$f300$$ENDHEX$$pia.")
		Case -2  // Erro na c$$HEX1$$f300$$ENDHEX$$pia
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na c$$HEX1$$f300$$ENDHEX$$pia.")
		Case -9  // Erro na c$$HEX1$$f300$$ENDHEX$$pia
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na c$$HEX1$$f300$$ENDHEX$$pia.")
	End Choose
Finally
	Tab_1.TabPage_2.dw_3.Modify("de_chave_acesso.tabsequence=0")
	Tab_1.TabPage_2.dw_3.Event ue_Pos(1, "nr_pedido_central")
End Try


end event

type cb_localizar_pedido from commandbutton within tabpage_2
integer x = 1047
integer y = 48
integer width = 475
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Localizar Pedido"
end type

event clicked;String ls_Parametro

Long	ll_Pedido,&
		ll_Qt_Cancelado

If tab_1.tabPage_2.dw_3.RowCount() > 0 Then
	
	ll_Qt_Cancelado =  tab_1.tabPage_1.dw_2.Object.qt_nf_cancelada[tab_1.tabPage_1.dw_2.GetRow()]
	
	If ll_Qt_Cancelado > 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Essa nota foi cancelada na SEFAZ, n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser alterada.")
		Return 1
	End If
	
	If Not IsNull(idh_Liberado_Agendamento) Then
		If Not IsNull(tab_1.tabPage_2.dw_3.Object.nr_pedido_central[1]) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nota j$$HEX1$$e100$$ENDHEX$$ liberada para agendamento, n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser alterado o pedido.")
			Return 1
		End If
	End If
	
	ls_Parametro = tab_1.tabPage_2.dw_3.Object.nr_cgc_fornecedor[1]+is_Chave_Acesso
	
	OpenWithParm(w_ge331_pedidos, ls_Parametro)
	
	ll_Pedido	 = 	Message.DoubleParm
	
	If ll_Pedido <> -1 Then
		tab_1.tabPage_2.dw_3.Object.nr_pedido_central[1]	= ll_Pedido
	
		wf_Habilita_Menu()
	End If
End If



end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3730
integer height = 1888
long backcolor = 67108864
string text = "Produtos"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_alterar_cx_padrao cb_alterar_cx_padrao
cb_alterar_st cb_alterar_st
cbx_1 cbx_1
gb_4 gb_4
dw_4 dw_4
gb_6 gb_6
dw_6 dw_6
end type

on tabpage_3.create
this.cb_alterar_cx_padrao=create cb_alterar_cx_padrao
this.cb_alterar_st=create cb_alterar_st
this.cbx_1=create cbx_1
this.gb_4=create gb_4
this.dw_4=create dw_4
this.gb_6=create gb_6
this.dw_6=create dw_6
this.Control[]={this.cb_alterar_cx_padrao,&
this.cb_alterar_st,&
this.cbx_1,&
this.gb_4,&
this.dw_4,&
this.gb_6,&
this.dw_6}
end on

on tabpage_3.destroy
destroy(this.cb_alterar_cx_padrao)
destroy(this.cb_alterar_st)
destroy(this.cbx_1)
destroy(this.gb_4)
destroy(this.dw_4)
destroy(this.gb_6)
destroy(this.dw_6)
end on

type cb_alterar_cx_padrao from commandbutton within tabpage_3
integer x = 2199
integer y = 28
integer width = 603
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Alterar Caixa Padr$$HEX1$$e300$$ENDHEX$$o"
end type

event clicked;Long	ll_produto,&
		ll_Qt_Cx_Padrao
		
String	ls_Fornecedor,&
		ls_Nome_Fornecedor,&
		ls_Desc_Produto,&
		ls_Operacao,&
		ls_Retorno,&
		ls_Chave_Acesso
		
Boolean	lb_Tem_Cx_Padrao		

Tab_1.TabPage_1.dw_1.SetFocus()

st_ge331_parametros lst_Parametros


Tab_1.TabPAge_3.dw_4.AcceptText()
Tab_1.TabPAge_2.dw_3.AcceptText()


If Tab_1.TabPAge_3.dw_4.GetRow() < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nenhum produto selecionado!")
	Return
End If


select c.cd_fornecedor, c.nm_razao_social
Into :ls_Fornecedor, :ls_Nome_Fornecedor
from nf_agendamento_ent a
inner join pedido_central b on b.nr_pedido = a.nr_pedido_central
inner join fornecedor	c on c.cd_fornecedor = b.cd_fornecedor
where a.de_chave_acesso = :is_Chave_Acesso
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o pedido para essa nota.")
		Return 1
	Case -1
		MessageBox("Erro", "Erro ao localizar o fornecedor da nota: "+ SqlCa.SQLErrText)
		Return 1
End Choose

ll_produto				= Tab_1.TabPAge_3.dw_4.Object.cd_produto			[Tab_1.TabPAge_3.dw_4.GetRow()]
ls_Desc_Produto		= Tab_1.TabPAge_3.dw_4.Object.de_produto			[Tab_1.TabPAge_3.dw_4.GetRow()]
ls_Chave_Acesso		= Tab_1.TabPAge_3.dw_4.Object.de_chave_acesso	[Tab_1.TabPAge_3.dw_4.GetRow()]

lst_Parametros.cd_produto			= ll_produto
lst_Parametros.de_produto			= ls_Desc_Produto
lst_Parametros.cd_fornecedor		= ls_Fornecedor
lst_Parametros.nm_fornecedor		= ls_Nome_Fornecedor
lst_Parametros.de_chave_acesso	= ls_Chave_Acesso

OpenWithParm(w_ge331_altera_caixa_padrao, lst_Parametros)

ls_Retorno = Message.StringParm

If ls_Retorno = "N" Then
	Return 1
End If

wf_Verifica_Divergencias()





end event

type cb_alterar_st from commandbutton within tabpage_3
integer x = 2921
integer y = 28
integer width = 402
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Alterar ST"
boolean default = true
end type

event clicked;String		ls_ST

Long	ll_Qt_Cancelado

If tab_1.tabPage_3.dw_4.RowCount() > 0 Then
	ll_Qt_Cancelado =  tab_1.tabPage_1.dw_2.Object.qt_nf_cancelada[tab_1.tabPage_1.dw_2.GetRow()]
	
	If ll_Qt_Cancelado > 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Essa nota foi cancelada na SEFAZ, n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser alterada.")
		Return 1
	End If
	
	If Not IsNull(idh_Liberado_Agendamento) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nota j$$HEX1$$e100$$ENDHEX$$ liberada para agendamento, n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser alterado a ST.")
		Return 1
	End If
	
	tab_1.tabPage_3.dw_4.AcceptText()
	
	ls_ST = tab_1.tabPage_3.dw_4.Object.cd_cst_tributacao[tab_1.tabPage_3.dw_4.GetRow()]
	
	OpenWithParm(w_ge331_localiza_st, ls_ST)
	
	ls_ST	= Message.StringParm
	
	If ls_ST <> "" Then
		tab_1.tabPage_3.dw_4.Object.cd_cst_tributacao[tab_1.tabPage_3.dw_4.GetRow()]	= 	ls_ST
		
		wf_Habilita_Menu()	
	End If
End If
end event

type cbx_1 from checkbox within tabpage_3
integer x = 73
integer y = 36
integer width = 1285
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Mostrar apenas os produtos com diverg$$HEX1$$ea00$$ENDHEX$$ncias"
end type

event clicked;Tab_1.TabPage_3.dw_4.SetRedraw(false)

If This.Checked Then
	Tab_1.TabPage_3.dw_4.SetFilter("qt_divergencias > 0")	
	Tab_1.TabPage_3.dw_4.Filter()
Else
	Tab_1.TabPage_3.dw_4.SetFilter("")
	Tab_1.TabPage_3.dw_4.Filter()	
End If

Tab_1.TabPage_3.dw_4.Sort()
Tab_1.TabPage_3.dw_4.SetRedraw(true)
end event

type gb_4 from groupbox within tabpage_3
integer x = 23
integer y = 124
integer width = 3310
integer height = 1156
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Detalhes"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within tabpage_3
integer x = 59
integer y = 188
integer width = 3227
integer height = 1084
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge331_detalhes_itens"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;//This.of_SetRowSelection()

This.of_SetRowSelection("if(qt_divergencias > 0, if(getrow() = currentrow(), rgb(174, 174, 0), rgb(255, 255, 128)), if(getrow() = currentrow(), rgb(0,128,128), rgb(255,255,255)))", "", false)
end event

event doubleclicked;call super::doubleclicked;Long	ll_Pedido,&
		ll_Retorno,&
		ll_Produto,&
		ll_Qt_Cancelado
		
If ib_Somente_Consulta Then Return		

If tab_1.tabPage_3.dw_4.RowCount() > 0 Then
	ll_Qt_Cancelado =  tab_1.tabPage_1.dw_2.Object.qt_nf_cancelada[tab_1.tabPage_1.dw_2.GetRow()]
	
	If ll_Qt_Cancelado > 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Essa nota foi cancelada na SEFAZ, n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser alterada.")
		Return 1
	End If	
	
	If Not IsNull(idh_Liberado_Agendamento) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nota j$$HEX1$$e100$$ENDHEX$$ liberada para agendamento, n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser alterado o c$$HEX1$$f300$$ENDHEX$$digo do produto.")
		Return -1
	End If
	
	tab_1.tabPage_2.dw_3.AcceptText()
	tab_1.tabPage_3.dw_4.AcceptText()
	
	ll_Pedido 	= tab_1.tabPage_2.dw_3.Object.nr_pedido_central	[1]
	ll_Produto	= tab_1.tabPage_3.dw_4.Object.cd_produto			[tab_1.tabPage_3.dw_4.GetRow()]
	
	If IsNull(ll_Pedido) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Antes de localizar o produto deve ser informado o pedido na aba 'Detalhes'.")
		tab_1.SelectTab(2)
		tab_1.tabPage_2.dw_3.SetFocus()
		Return -1
	End If
	
	If Not IsNull(ll_Produto) Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Aten$$HEX2$$e700e300$$ENDHEX$$o! Esse produto j$$HEX1$$e100$$ENDHEX$$ possui c$$HEX1$$f300$$ENDHEX$$digo.~rDeseja alter$$HEX1$$e100$$ENDHEX$$-lo?", Question!, YesNo!, 2) = 2 Then
			Return -1
		End If
	End If
	
	OpenWithParm(w_ge331_localiza_produto_pedido, ll_Pedido)
	
	ll_Retorno	= Message.DoubleParm
	
	If ll_Retorno <> -1 Then
		tab_1.tabPage_3.dw_4.Object.cd_produto[tab_1.tabPage_3.dw_4.GetRow()]	= 	ll_Retorno
		
		wf_Habilita_Menu()	
	End If
End If
end event

event rowfocuschanged;call super::rowfocuschanged;Long ll_Item

Tab_1.TabPage_3.dw_6.Reset()

If currentRow > 0 Then
	tab_1.tabPage_3.dw_4.AcceptText()
	
	ll_Item	= tab_1.tabPage_3.dw_4.Object.nr_item	[currentRow]
	
	Tab_1.TabPage_3.dw_6.Retrieve(is_Chave_Acesso, ll_Item)
End If
end event

event editchanged;call super::editchanged;wf_Habilita_Menu()
end event

event itemchanged;call super::itemchanged;wf_Habilita_Menu()
end event

type gb_6 from groupbox within tabpage_3
integer x = 23
integer y = 1296
integer width = 3310
integer height = 528
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Diverg$$HEX1$$ea00$$ENDHEX$$ncias do Produto"
borderstyle borderstyle = styleraised!
end type

type dw_6 from dc_uo_dw_base within tabpage_3
integer x = 46
integer y = 1352
integer width = 3278
integer height = 464
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge331_lista_divergencias_produtos"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3730
integer height = 1888
long backcolor = 67108864
string text = "T$$HEX1$$ed00$$ENDHEX$$tulos a Pagar"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
gb_7 gb_7
dw_7 dw_7
end type

on tabpage_4.create
this.gb_7=create gb_7
this.dw_7=create dw_7
this.Control[]={this.gb_7,&
this.dw_7}
end on

on tabpage_4.destroy
destroy(this.gb_7)
destroy(this.dw_7)
end on

type gb_7 from groupbox within tabpage_4
integer x = 23
integer y = 12
integer width = 1993
integer height = 1824
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Detalhes"
end type

type dw_7 from dc_uo_dw_base within tabpage_4
integer x = 50
integer y = 76
integer width = 1934
integer height = 1744
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge331_titulos"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3730
integer height = 1888
long backcolor = 67108864
string text = "Mensagem de Recusa"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_1 cb_1
cb_exclui_msg cb_exclui_msg
cb_gravar cb_gravar
gb_8 gb_8
cb_enviar cb_enviar
dw_8 dw_8
dw_9 dw_9
end type

on tabpage_5.create
this.cb_1=create cb_1
this.cb_exclui_msg=create cb_exclui_msg
this.cb_gravar=create cb_gravar
this.gb_8=create gb_8
this.cb_enviar=create cb_enviar
this.dw_8=create dw_8
this.dw_9=create dw_9
this.Control[]={this.cb_1,&
this.cb_exclui_msg,&
this.cb_gravar,&
this.gb_8,&
this.cb_enviar,&
this.dw_8,&
this.dw_9}
end on

on tabpage_5.destroy
destroy(this.cb_1)
destroy(this.cb_exclui_msg)
destroy(this.cb_gravar)
destroy(this.gb_8)
destroy(this.cb_enviar)
destroy(this.dw_8)
destroy(this.dw_9)
end on

type cb_1 from commandbutton within tabpage_5
integer x = 791
integer y = 1772
integer width = 485
integer height = 104
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Hist$$HEX1$$f300$$ENDHEX$$rico Recusa"
end type

event clicked;OpenWithParm(w_ge331_historico_msg_recusa, Tab_1.TabPage_2.dw_3.Object.De_Chave_Acesso[1])
end event

type cb_exclui_msg from commandbutton within tabpage_5
integer x = 1312
integer y = 1772
integer width = 361
integer height = 104
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Excluir Msg"
end type

event clicked;String ls_Chave_Acesso
String ls_Erro
String ls_Nulo
String ls_Mensagem_Old
String ls_Operador

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE331_EXCLUI_MENSAGEM_RECUSA", Ref ls_Operador) Then
	Return 1
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a EXCLUS$$HEX1$$c300$$ENDHEX$$O da mensagem de recusa?", Question!, YesNo!, 2) = 2 Then Return -1

Tab_1.TabPage_2.dw_3.AcceptText()

ls_Chave_Acesso = Tab_1.TabPage_2.dw_3.Object.De_Chave_Acesso[1]

Delete From nf_agendamento_ent_msg_recusa
Where de_chave_acesso = :ls_Chave_Acesso
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir a mensagem de recusa. " + ls_Erro, StopSign!)
	Return -1
End If

SetNull(ls_Nulo)

ls_Mensagem_Old	= Tab_1.TabPage_5.dw_8.Object.De_Mensagem_Old[1]

If Not gf_Grava_Historico_Alteracao_Tabela('NF_AGENDAMENTO_ENT_MSG_RECUSA', ls_Chave_Acesso, 'DE_CHAVE_ACESSO', ls_Mensagem_Old, ls_Nulo, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, + &
	"E", Ref ls_Erro, True) Then Return -1

SqlCa.of_Commit();

Tab_1.TabPage_5.cb_Enviar.Enabled = False
Tab_1.TabPage_5.cb_Exclui_Msg.Enabled = False

Tab_1.TabPage_5.dw_8.Retrieve(ls_Chave_Acesso)
end event

type cb_gravar from commandbutton within tabpage_5
integer x = 1710
integer y = 1772
integer width = 315
integer height = 104
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gravar"
end type

event clicked;String ls_Mensagem
String ls_Mensagem_Old
String ls_Chave_Acesso
String ls_Matricula
String ls_Erro

Tab_1.TabPage_2.dw_3.AcceptText()
Tab_1.TabPage_5.dw_8.AcceptText()

ls_Chave_Acesso	= Tab_1.TabPage_2.dw_3.Object.De_Chave_Acesso		[1]
ls_Mensagem 		= Tab_1.TabPage_5.dw_8.Object.De_Mensagem			[1]
ls_Mensagem_Old	= Tab_1.TabPage_5.dw_8.Object.De_Mensagem_Old	[1]

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a ATUALIZA$$HEX2$$c700c300$$ENDHEX$$O do campo de mensagem de recusa?", Question!, YesNo!, 2) = 2 Then Return -1

If IsNull(ls_Mensagem) Or ls_Mensagem = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a mensagem de recusa.", Exclamation!)
	Tab_1.TabPage_5.dw_8.SetFocus()
	Return -1
End If

If LenA(ls_Mensagem) < 10 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A mensagem de recusa deve ter ao menos 10 caracteres.", Exclamation!)
	Tab_1.TabPage_5.dw_8.SetFocus()
	Return -1
End If

If IsNull(ls_Mensagem_Old) Or ls_Mensagem_Old = "" Then
	
	Insert Into nf_agendamento_ent_msg_recusa(de_chave_acesso, de_mensagem, dh_atualizacao, dh_envio_msg_email, nr_matricula_recusa)
											Values(:ls_Chave_Acesso, :ls_Mensagem, getdate(), null, :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar a mensagem de recusa. " + ls_Erro, StopSign!)
		Return -1
	End If
	
	If Not gf_Grava_Historico_Alteracao_Tabela('NF_AGENDAMENTO_ENT_MSG_RECUSA', ls_Chave_Acesso, 'DE_MENSAGEM', ls_Mensagem_Old, ls_Mensagem, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, + &
			"I", Ref ls_Erro, True) Then Return -1
	
Else
	
	If ls_Mensagem <> ls_Mensagem_Old Then
		
		Update nf_agendamento_ent_msg_recusa
			Set de_mensagem = :ls_Mensagem,
				 dh_atualizacao = getdate(),
				 nr_matricula_recusa = :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
		Where de_chave_acesso = :ls_Chave_Acesso
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_Rollback();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar a mensagem de recusa. " + ls_Erro, StopSign!)
			Return -1
		End If
		
		If Not gf_Grava_Historico_Alteracao_Tabela('NF_AGENDAMENTO_ENT_MSG_RECUSA', ls_Chave_Acesso, 'DE_MENSAGEM', ls_Mensagem_Old, ls_Mensagem, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, + &
			"A", Ref ls_Erro, True) Then Return -1
	End If
End If

SqlCa.of_Commit();

Tab_1.TabPage_5.cb_Enviar.Enabled = True
Tab_1.TabPage_5.cb_Exclui_Msg.Enabled = True

Tab_1.TabPage_5.dw_8.Retrieve(ls_Chave_Acesso)
end event

type gb_8 from groupbox within tabpage_5
integer y = 4
integer width = 2574
integer height = 1748
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Detalhes"
borderstyle borderstyle = styleraised!
end type

type cb_enviar from commandbutton within tabpage_5
integer x = 2062
integer y = 1772
integer width = 402
integer height = 104
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Enviar E-mail"
end type

event clicked;DateTime ldh_Recusa
DateTime ldh_Emissao
DateTime ldh_Email_Msg_Recusa

Long ll_Nr_NF
Long ll_Pedido
Long ll_Linha

Integer li_retorno

String ls_Mensagem
String ls_Mensagem_Old
String ls_Texto_Email
String ls_Path
String ls_Aux[]
String ls_Anexo[]
String ls_Especie
String ls_Serie
String ls_Chave_Acesso
String ls_Msg_Recusa
String ls_Resp_Recusa
String ls_Fornecedor
String ls_Razao_Social
String ls_Msg_Anexo = "E-mail cont$$HEX1$$e900$$ENDHEX$$m anexo."
String ls_De_Endereco_Email
String ls_De_Endereco_Email_Aux
String ls_Pedido
String ls_Nome_Arquivo
String ls_usuario_aux
String ls_email
String ls_email_fornecedor


Tab_1.TabPage_1.dw_2.AcceptText()
Tab_1.TabPage_5.dw_8.AcceptText()

ldh_Email_Msg_Recusa = Tab_1.TabPage_5.dw_8.Object.Dh_Envio_Msg_Email[1]

If IsNull(ldh_Email_Msg_Recusa) Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma o ENVIO de e-mail com as informa$$HEX2$$e700f500$$ENDHEX$$es cadastradas sobre a recusa?", Question!, YesNo!, 2) = 2 Then Return -1
	
Else
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "J$$HEX1$$e100$$ENDHEX$$ foi enviado e-mail com mensagem de recusa para essa NF.~r~rDeseja reenviar o e-mail?", Question!, YesNo!, 2) = 2 Then	
		Tab_1.TabPage_5.dw_8.SetFocus()
		Return -1
	End If
End If

ls_Mensagem			= Tab_1.TabPage_5.dw_8.Object.De_Mensagem		[1]
ls_Mensagem_Old	= Tab_1.TabPage_5.dw_8.Object.De_Mensagem_Old[1]

If IsNull(ls_Mensagem) Or ls_Mensagem = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a mensagem de recusa.", Exclamation!)
	Tab_1.TabPage_5.dw_8.SetFocus()
	Return -1
End If

If (ls_Mensagem <> ls_Mensagem_Old) Or IsNull(ls_Mensagem_Old) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi gravada a $$HEX1$$fa00$$ENDHEX$$ltima altera$$HEX2$$e700e300$$ENDHEX$$o na mensagem.~r~rClique no bot$$HEX1$$e300$$ENDHEX$$o [Gravar] para ap$$HEX1$$f300$$ENDHEX$$s enviar o e-mail.", Exclamation!)
	Tab_1.TabPage_5.dw_8.SetFocus()
	Return -1
End If

If Not wf_Verifica_Tamanho_Anexo() Then Return -1

For ll_Linha = 1 To Tab_1.TabPage_5.dw_9.RowCount()

	ls_Path 				= Tab_1.TabPage_5.dw_9.Object.Nm_Arquivo					[ll_Linha]
	ls_Nome_Arquivo	= Tab_1.TabPage_5.dw_9.Object.Nm_Arquivo_Reduzido		[ll_Linha]
	
	If Not IsNull(ls_Path) And ls_Path <> "" Then
		//Remove o nome do arquivo, permancendo apenas o caminho o diret$$HEX1$$f300$$ENDHEX$$rio
		ls_Path = MidA(ls_Path, 1, LenA(ls_Path) - LenA(ls_Nome_Arquivo))
		
		If gf_Dir_List(ls_Path, "*" + ls_Nome_Arquivo, 0, ls_Aux[]) = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao listar o arquivo da linha " + String(ll_Linha) + ".", Exclamation!)
			Tab_1.TabPage_5.dw_8.SetFocus()
			Return -1
		End If
		
		If Not IsNull(ls_Anexo) And ls_Path <> "" And UpperBound(ls_Aux) = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo da linha " + String(ll_Linha) + " n$$HEX1$$e300$$ENDHEX$$o foi localizado.~rVerifique se foi movido ou exclu$$HEX1$$ed00$$ENDHEX$$do.", Exclamation!)
			Tab_1.TabPage_5.dw_8.SetFocus()
			Return -1
		End If		
		
		ls_Anexo[ UpperBound(ls_Anexo[]) + 1 ] = ls_Aux[1]
	End If
Next

If UpperBound(ls_Anexo) = 0 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma o ENVIO de e-mail SEM anexo?", Question!, YesNo!, 2) = 2 Then Return -1
	
	ls_Msg_Anexo = "E-mail N$$HEX1$$c300$$ENDHEX$$O cont$$HEX1$$e900$$ENDHEX$$m anexo."
End If

ll_Nr_NF							= Tab_1.TabPage_1.dw_2.Object.Nr_NF							[Tab_1.TabPage_1.dw_2.GetRow()]
ls_Especie						= Tab_1.TabPage_1.dw_2.Object.De_Especie					[Tab_1.TabPage_1.dw_2.GetRow()]
ls_Serie							= Tab_1.TabPage_1.dw_2.Object.De_Serie						[Tab_1.TabPage_1.dw_2.GetRow()]
ls_Chave_Acesso				= Tab_1.TabPage_1.dw_2.Object.De_Chave_Acesso			[Tab_1.TabPage_1.dw_2.GetRow()]
ls_Msg_Recusa					= Tab_1.TabPage_5.dw_8.Object.De_Mensagem					[1]
ls_Resp_Recusa					= Tab_1.TabPage_5.dw_8.Object.Nm_Usuario_Recusa			[1]
ldh_Recusa						= Tab_1.TabPage_5.dw_8.Object.Dh_Atualizacao				[1]
ldh_Emissao						= Tab_1.TabPage_5.dw_8.Object.Dh_Emissao					[1]
ll_Pedido						= Tab_1.TabPage_5.dw_8.Object.Nr_Pedido_Central			[1]
ls_Fornecedor					= Tab_1.TabPage_5.dw_8.Object.Cd_Fornecedor				[1]
ls_Razao_Social				= Tab_1.TabPage_5.dw_8.Object.Nm_Razao_Social			[1]
ls_De_Endereco_Email 		= Tab_1.TabPage_5.dw_8.Object.De_Endereco_Email			[1] 
ls_De_Endereco_Email_Aux	= Tab_1.TabPage_5.dw_8.Object.De_Endereco_Email_Aux	[1]

If Not IsNull(ll_Pedido) Then
	ls_Pedido = String(ll_Pedido)
Else
	ls_Pedido = "N$$HEX1$$c300$$ENDHEX$$O INFORMADO"
End If

ls_Texto_Email =	"A NF abaixo foi recusada pela Log$$HEX1$$ed00$$ENDHEX$$stica<br><br>" + &
						"NF: " + String(ll_Nr_NF) + "<br>" + &
						"Esp$$HEX1$$e900$$ENDHEX$$cie: " + ls_Especie + "<br>" + &
						"S$$HEX1$$e900$$ENDHEX$$rie: " + ls_Serie + "<br>" + &
						"Emissao: " + String(ldh_Emissao, "dd/mm/yyyy") + "<br>" + &
						"Pedido: " + ls_Pedido + "<br>" + &
						"Fornecedor: " + ls_Razao_Social + " (" + ls_Fornecedor + ")" + "<br><br>" + &
						"Chave de Acesso: " + ls_Chave_Acesso + "<br><br>" + &	
						"<b>Mensagem de Recusa: " + ls_Msg_Recusa + "<br><br>" + &
						"Resp. Recusa: " + ls_Resp_Recusa + "<br>" + &
						"Data Recusa: " + String(ldh_Recusa, "dd/mm/yyyy hh:mm") + "<br><br>" + &
						ls_Msg_Anexo + "</b>"


If gvo_Aplicacao.ivs_DataSource = 'central' Then	
	If Not wf_envia_email_recusa_fornecedor( ls_Fornecedor, Ref ls_email_fornecedor) Then Return -1
End If

If IsNull(ls_De_Endereco_Email) Or ls_De_Endereco_Email = "" Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Comprador n$$HEX1$$e300$$ENDHEX$$o tem o e-mail cadastrado. ~rE-mail ser$$HEX1$$e100$$ENDHEX$$ enviado para o Gerente do Compras.",Exclamation!) 
	ls_De_Endereco_Email = "andre@clamed.com.br"
End if

If Not IsNull(ls_email_fornecedor) Then 
	If ls_email_fornecedor <> '' Then
		ls_De_Endereco_Email += ";"+ls_email_fornecedor
	End If
End If

If Not IsNull(ls_De_Endereco_Email_aux) Then
	If ls_De_Endereco_Email_aux <> '' Then
		ls_De_Endereco_Email += ";"+ls_De_Endereco_Email_aux
	End if
End If 

ls_email = ls_De_Endereco_Email

s_email st

st.ps_to[1] 		= ls_email
st.ps_mensagem 	= ls_Texto_Email
st.ps_anexo[] 		= ls_Anexo[]
st.pb_assinatura 	= True

If gvo_Aplicacao.ivs_DataSource = 'central' Then	
	If Not gf_ge202_envia_email_padrao(275, st, True) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao enviar o e-mail.", StopSign!)
		Return -1
	End If
End If

If Not wf_Atualiza_Data_Envio_Email_Recusa(ls_Chave_Acesso) Then Return -1		

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "E-mail enviado com sucesso.")

Tab_1.TabPage_5.dw_8.Retrieve(ls_Chave_Acesso)
end event

type dw_8 from dc_uo_dw_base within tabpage_5
integer x = 69
integer y = 92
integer width = 2487
integer height = 1640
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge331_mensagem_recusa"
end type

event editchanged;call super::editchanged;Tab_1.TabPage_5.cb_Gravar.Enabled	 = True
end event

event buttonclicked;call super::buttonclicked;Long ll_Linha
Long ll_Find

Integer li_Retorno

String ls_Arquivo
String ls_Nome_Arquivo

Tab_1.TabPage_5.dw_8.AcceptText()

//li_Retorno = GetFileOpenName("Sele$$HEX2$$e700e300$$ENDHEX$$o do Arquivo", ls_Arquivo, ls_Nome_Arquivo, "", "Arquivos PDF (*.PDF),*.PDF,")

li_Retorno = GetFileOpenName("Sele$$HEX2$$e700e300$$ENDHEX$$o do Arquivo", ls_Arquivo, ls_Nome_Arquivo, "", "Arquivos PDF (*.PDF),*.PDF,JPEG (*.JPEG), *.JPEG,JPG (*.JPG), *.JPG")

If li_Retorno = 1 Then
	
	ll_Find = Tab_1.TabPage_5.dw_9.Find("nm_arquivo_reduzido = '" + ls_Nome_Arquivo + "'", 1, Tab_1.TabPage_5.dw_9.RowCount())
	
	If ll_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da de anexo (dw_9).", StopSign!)
		Return -1
	End If
	
	If ll_Find > 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo '" + ls_Nome_Arquivo + "' j$$HEX1$$e100$$ENDHEX$$ foi anexado.", Exclamation!)
		Return -1
	End If
	
	//Se a $$HEX1$$fa00$$ENDHEX$$ltima linha da dw de anexo estiver preenchida, cria uma nova
	If Not IsNull( Tab_1.TabPage_5.dw_9.Object.Nm_Arquivo[Tab_1.TabPage_5.dw_9.RowCount()] ) Then
		ll_Linha = Tab_1.TabPage_5.dw_9.InsertRow(0)
	End If
	
	Tab_1.TabPage_5.dw_9.Object.Nm_Arquivo				[Tab_1.TabPage_5.dw_9.RowCount()] = Upper(ls_Arquivo)
	Tab_1.TabPage_5.dw_9.Object.Nm_Arquivo_Reduzido	[Tab_1.TabPage_5.dw_9.RowCount()] = ls_Nome_Arquivo
	
End If
end event

type dw_9 from dc_uo_dw_base within tabpage_5
integer x = 128
integer y = 680
integer width = 2222
integer height = 380
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge331_lista_anexo"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event itemchanged;call super::itemchanged;If dwo.Name = "id_exclui_anexo" Then
	If Data = "S" Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a exclus$$HEX1$$e300$$ENDHEX$$o do anexo selecionado?", Question!, YesNo!, 2) = 2 Then
			Data = "N"
			Return 1
		End If
		
		If This.RowCount( ) > 1 Then
			If This.DeleteRow(Row) <> 1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o anexo da linha " + String(Row) + " em anexo.", StopSign!)
				Return 1
			End If
			
		Else
			This.Event ue_Reset()
			This.Event ue_AddRow()
		End If
	End If
End If
end event

