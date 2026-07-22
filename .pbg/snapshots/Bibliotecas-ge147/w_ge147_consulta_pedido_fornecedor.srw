HA$PBExportHeader$w_ge147_consulta_pedido_fornecedor.srw
forward
global type w_ge147_consulta_pedido_fornecedor from dc_w_sheet
end type
type tab_1 from tab within w_ge147_consulta_pedido_fornecedor
end type
type tabpage_1 from userobject within tab_1
end type
type cb_5 from commandbutton within tabpage_1
end type
type cb_3 from commandbutton within tabpage_1
end type
type cb_cancela_1 from commandbutton within tabpage_1
end type
type cb_vincula from commandbutton within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type gb_3 from groupbox within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type dw_3 from dc_uo_dw_base within tabpage_1
end type
type cb_cancelar_pedido from commandbutton within tabpage_1
end type
type cb_imprimir_pedido from commandbutton within tabpage_1
end type
type cb_pedido_edi from commandbutton within tabpage_1
end type
type dw_2 from dc_uo_dw_base within tabpage_1
end type
type cb_descancelar from commandbutton within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_5 cb_5
cb_3 cb_3
cb_cancela_1 cb_cancela_1
cb_vincula cb_vincula
cb_1 cb_1
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_3 dw_3
cb_cancelar_pedido cb_cancelar_pedido
cb_imprimir_pedido cb_imprimir_pedido
cb_pedido_edi cb_pedido_edi
dw_2 dw_2
cb_descancelar cb_descancelar
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
type tabpage_2 from userobject within tab_1
end type
type cb_4 from commandbutton within tabpage_2
end type
type cb_2 from commandbutton within tabpage_2
end type
type gb_4 from groupbox within tabpage_2
end type
type dw_4 from dc_uo_dw_base within tabpage_2
end type
type tabpage_2 from userobject within tab_1
cb_4 cb_4
cb_2 cb_2
gb_4 gb_4
dw_4 dw_4
end type
type tabpage_3 from userobject within tab_1
end type
type gb_5 from groupbox within tabpage_3
end type
type gb_6 from groupbox within tabpage_3
end type
type dw_6 from dc_uo_dw_base within tabpage_3
end type
type dw_5 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_5 gb_5
gb_6 gb_6
dw_6 dw_6
dw_5 dw_5
end type
type tab_1 from tab within w_ge147_consulta_pedido_fornecedor
tabpage_1 tabpage_1
tabpage_4 tabpage_4
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_ge147_consulta_pedido_fornecedor from dc_w_sheet
string tag = "w_ge147_consulta_pedido_fornecedor"
string accessiblename = "Consulta Pedido Fornecedor (GE147)"
integer width = 4247
integer height = 2412
string title = "GE147 - Consulta de Pedidos de Fornecedores"
boolean maxbox = true
long backcolor = 80269524
event ue_retrieve ( )
tab_1 tab_1
end type
global w_ge147_consulta_pedido_fornecedor w_ge147_consulta_pedido_fornecedor

type variables
uo_Fornecedor				ivo_Fornecedor
uo_Produto					ivo_produto
uo_pedido_central_edi	ivo_pedido_edi
uo_Filial						ivo_Filial
uo_ge149_Comprador	io_Comprador

String is_Controla_Liberacao_Pedido
String is_responsavel
String is_Resp_Canc
end variables

forward prototypes
public function boolean wf_localiza_usuario (string as_matricula, ref string as_nome)
public function decimal wf_percentual_atendido (long al_pedido)
public subroutine wf_insere_filial_default ()
public subroutine wf_imprimir_relatorio ()
public function boolean wf_retorna_situacao_pedido (long al_pedido, ref string as_situacao)
public function boolean wf_verifica_parametro_liberacao_pedido ()
public function long wf_verifica_produto ()
public function boolean wf_verifica_nf_compra_pendente (string as_fornecedor, long al_pedido)
public function boolean wf_verifica_nf_compra_pendente_produto (string as_fornecedor, long al_produto, long al_pedido)
public function boolean wf_saldo_em_transito ()
public function boolean wf_verifica_nf_pendente (long al_pedido, long al_produto)
public subroutine wf_tipo_pedido ()
public function boolean wf_valida_canc_pend (long al_origem, string as_operacao)
public function boolean wf_verifica_pend_canc (long al_pedido, long al_produto, string as_operacao)
public function boolean wf_grava_pendencia (long al_pedido, long al_produto, ref string as_erro, string as_operacao)
public function boolean wf_grava_historico_alteracao_pedido (long al_pedido, long al_produto, ref string as_erro, string as_retira_qtd)
public function boolean wf_habilita_botao ()
end prototypes

event ue_retrieve;Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
end event

public function boolean wf_localiza_usuario (string as_matricula, ref string as_nome);Boolean lvb_Sucesso = False

Select nm_usuario Into :as_Nome
From usuario
Where nr_matricula = :as_Matricula
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
		
	Case 100
		//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio com a matr$$HEX1$$ed00$$ENDHEX$$cula '" + as_Matricula + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", Information!)
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Usu$$HEX1$$e100$$ENDHEX$$rio")
End Choose

If Not lvb_Sucesso Then
	as_Nome = ""
End If

Return lvb_Sucesso
end function

public function decimal wf_percentual_atendido (long al_pedido);Decimal lvdc_Percentual

Long lvl_Pedida,&
     lvl_Recebida
	 
Select sum(case when id_situacao <> 'C' then 0 else qt_pedida end), 
		 sum(case when id_situacao <> 'C' then 0 else qt_recebida end)
  Into :lvl_Pedida, 
  		 :lvl_Recebida
  From pedido_central_produto
 Where nr_pedido =:al_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Sumariza$$HEX2$$e700e300$$ENDHEX$$o das quantidades atendidas.")
	Return 0
End If
	
If IsNull(lvl_Pedida)   Then lvl_Pedida   = 0
If IsNull(lvl_Recebida) Then lvl_Recebida = 0

If lvl_Pedida > 0 Then
	lvdc_Percentual = Round((lvl_Recebida * 100) / lvl_Pedida, 2)
Else
	lvdc_Percentual = 0.00
End If

Return lvdc_Percentual
end function

public subroutine wf_insere_filial_default ();ivo_Filial.of_Localiza_Filial(String(534))

If ivo_Filial.Localizada Then
	Tab_1.TabPage_1.dw_1.Object.Cd_Filial	[1] = ivo_Filial.Cd_Filial
	Tab_1.TabPage_1.dw_1.Object.Nm_filial	[1] = ivo_Filial.Nm_Fantasia
Else
	ivo_Filial.of_Inicializa()
	
	Tab_1.TabPage_1.dw_1.Object.cd_filial	[1] = ivo_Filial.Cd_Filial
	Tab_1.TabPage_1.dw_1.Object.nm_filial	[1] = ivo_Filial.Nm_Fantasia
End If


end subroutine

public subroutine wf_imprimir_relatorio ();
end subroutine

public function boolean wf_retorna_situacao_pedido (long al_pedido, ref string as_situacao);Select id_situacao
Into :as_situacao
From pedido_central
Where nr_pedido =:al_Pedido
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pedido n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do pedido.")
		Return False
End Choose

Return True
end function

public function boolean wf_verifica_parametro_liberacao_pedido ();String ls_Parametro

//is_Controla_Liberacao_Pedido = 'N'
//
//Return True

Select vl_parametro
Into :ls_Parametro
From parametro_geral
Where cd_parametro = 'ID_CONTROLE_LIBERACAO_PEDIDO_CENTRAL'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(ls_Parametro) or (ls_Parametro <> 'N' and ls_Parametro <> 'S') Then 
			is_Controla_Liberacao_Pedido = 'N'
		Else
			is_Controla_Liberacao_Pedido = ls_Parametro
		End If
	Case 100
		is_Controla_Liberacao_Pedido = 'N'
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o de libera$$HEX1$$e700$$ENDHEX$$ao de pedido central 'ID_CONTROLE_LIBERACAO_PEDIDO_CENTRAL'")
		Return False
End Choose

Return True
end function

public function long wf_verifica_produto ();Long ll_Linha
Long ll_Linhas

String ls_Farm_Popular
String ls_PBM

Tab_1.TabPage_1.dw_2.AcceptText()

ll_Linhas = Tab_1.TabPage_1.dw_2.RowCount()

If ll_Linhas > 0 Then

	For ll_Linha = 1 To ll_Linhas
					
		ls_Farm_Popular	= Tab_1.TabPage_1.dw_2.Object.Id_Farmacia_Governo	[ll_Linha]
		ls_PBM				= Tab_1.TabPage_1.dw_2.Object.Id_Pbm					[ll_Linha]
	Next	
End If
	
Return 1
end function

public function boolean wf_verifica_nf_compra_pendente (string as_fornecedor, long al_pedido);Long ll_Achou

Select count(*)
	Into :ll_Achou
From nf_compra_pendente
Where cd_filial = 534
And cd_fornecedor = :as_Fornecedor
And nr_pedido = :al_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError('Erro ao consultar a nf_compra_pendente. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_nf_pendente')
	Return False
End If

If ll_Achou > 0  Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O XML da nota fiscal eletr$$HEX1$$f400$$ENDHEX$$nica deste pedido j$$HEX1$$e100$$ENDHEX$$ foi importado, portanto n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel gravar uma mensagem.", Exclamation!)
	Return False
Else
	Return True
End If
end function

public function boolean wf_verifica_nf_compra_pendente_produto (string as_fornecedor, long al_produto, long al_pedido);Long ll_Achou

Select Count(*)
	Into :ll_Achou
From nf_compra_pendente as n
	Inner Join nf_compra_pendente_produto as p
		On p.cd_filial = n.cd_filial
		And p.cd_fornecedor = n.cd_fornecedor
		And p.nr_nf = n.nr_nf
		And p.de_especie = n.de_especie
		And p.de_serie = n.de_serie
Where n.cd_filial = 534
	And n.cd_fornecedor = :as_Fornecedor
	And p.cd_produto = :al_Produto
	And n.nr_pedido = :al_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError('Erro ao localizar a nf_compra_pendente_produto. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_nf_compra_pendente_produto')
	Return False
End If

If ll_Achou > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O XML da nota fiscal eletr$$HEX1$$f400$$ENDHEX$$nica deste pedido com este produto j$$HEX1$$e100$$ENDHEX$$ foi importado, portanto n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel gravar uma mensagem.", Exclamation!)
	Return False
Else
	Return True
End If
end function

public function boolean wf_saldo_em_transito ();st_saldo_transito str

Long ll_Find
Long ll_Linha
Long ll_Linhas

gf_Saldo_em_transito(Ref str)

ll_Linhas = UpperBound(str.Cd_Produto[])

For ll_Linha = 1 To ll_Linhas
	
//	//Quando o fornecedor n$$HEX1$$e300$$ENDHEX$$o informa o c$$HEX1$$f300$$ENDHEX$$digo de barras no XML, o item no agendamento fica sem o c$$HEX1$$f300$$ENDHEX$$digo de produtos
//	If IsNull(str.Cd_Produto[ll_Linha]) Or str.Cd_Produto[ll_Linha] = 0 Then Continue
	
	ll_Find = Tab_1.TabPage_2.dw_4.Find("cd_produto = " + String(str.Cd_Produto[ll_Linha]), 1, Tab_1.TabPage_2.dw_4.RowCount())
	
	If ll_Find > 0 Then
		Tab_1.TabPage_2.dw_4.Object.Qt_Est_Transito[ll_Find] = str.Qt_Saldo[ll_Linha] 
	End If
Next

Return True
end function

public function boolean wf_verifica_nf_pendente (long al_pedido, long al_produto);Long ll_Achou

If al_Produto = 0 Then

	Select Count(*)
		Into: ll_Achou
	From nf_agendamento_ent n
	Inner Join pedido_central p
		On p.nr_pedido = n.nr_pedido_central
	Where n.dh_emissao>= p.dh_emissao 
	  And p.nr_pedido = :al_Pedido
	  And n.nr_matricula_canc_agendamento Is Null
	  And Not Exists (Select *
						  From nf_compra nc
						  Where nc.de_chave_acesso = n.de_chave_acesso)
	 And Not Exists (Select * 
						  From nfe_destinadas d
						  Where d.de_chave_acesso = n.de_chave_acesso
							 And d.id_situacao_nf = '3')
	Using SqlCa;
		
Else
	
	Select Count(*)
		Into :ll_Achou
	From nf_agendamento_ent n
		Inner Join nf_agendamento_ent_item i
			On i.de_chave_acesso = n.de_chave_acesso
		Inner Join pedido_central p
			On p.nr_pedido = n.nr_pedido_central
	Where n.dh_emissao>= p.dh_emissao 
	  And p.nr_pedido = :al_Pedido
	  And i.cd_produto = :al_Produto
	  And n.nr_matricula_canc_agendamento Is Null
	  And Not Exists (Select *
						  From nf_compra nc
						  Where nc.de_chave_acesso = n.de_chave_acesso)
	  And Not Exists (Select * 
						  From nfe_destinadas d
						  Where d.de_chave_acesso = n.de_chave_acesso
							 And d.id_situacao_nf = '3')
	Using SqlCa;
End If

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar as notas pendentes. Fun$$HEX2$$e700e300$$ENDHEX$$o 'wf_verifica_nf_pendente'. " + SqlCa.SqlErrText)
	Return False
End If

If ll_Achou > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A pend$$HEX1$$ea00$$ENDHEX$$ncia n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser cancelada porque existem notas pendentes.")
	Return False
End If

Return True
end function

public subroutine wf_tipo_pedido ();String ls_Tipo_Pedido
String ls_Pbm
String ls_Farmacia_Gov
String ls_Falta_BA

Tab_1.TabPage_1.dw_2.AcceptText()

ls_Pbm				= Tab_1.TabPage_1.dw_2.Object.Id_Pbm							[Tab_1.TabPage_1.dw_2.GetRow()]
ls_Farmacia_Gov	= Tab_1.TabPage_1.dw_2.Object.Id_Farmacia_Governo			[Tab_1.TabPage_1.dw_2.GetRow()]
ls_Falta_BA			= Tab_1.TabPage_1.dw_2.Object.Id_Atende_Falta_Pedido_Uf	[Tab_1.TabPage_1.dw_2.GetRow()]

If ls_Pbm = "N" And ls_Farmacia_Gov = "N" And ls_Falta_BA = "N" Then
	ls_Tipo_Pedido = "PEDIDO NORMAL"
End If

If ls_Pbm = "S" Then
	ls_Tipo_Pedido = "REPOSI$$HEX2$$c700c300$$ENDHEX$$O PBM"
End If

If ls_Farmacia_Gov = "S" Then
	ls_Tipo_Pedido = "FARM$$HEX1$$c100$$ENDHEX$$CIA DO GOVERNO"
End If

If ls_Falta_BA = "BA" Then
	ls_Tipo_Pedido = "FALTAS DA BAHIA"
End If

Tab_1.TabPage_4.dw_7.Object.Id_Tipo_Pedido[1] = ls_Tipo_Pedido
end subroutine

public function boolean wf_valida_canc_pend (long al_origem, string as_operacao);Boolean lb_Sucesso = False

Decimal ldc_Atend

Long ll_Linha
Long ll_Qt_Pedida
Long ll_Qt_Recebida
Long ll_Pedido
Long ll_Produto

String ls_Situacao
String ls_Erro
String ls_Responsavel

Tab_1.TabPage_1.dw_2.AcceptText()
Tab_1.TabPage_2.dw_4.AcceptText()

If al_Origem = 0 Then
	If Not gvo_aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE147_CANCELAMENTO_PENDENCIA", Ref ls_Responsavel) Then Return False
Else
	If IsNull(is_Resp_Canc) Then
		If Not gvo_aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE147_CANCELAMENTO_PENDENCIA", Ref is_Resp_Canc) Then Return False
	End If
End If

ll_Pedido = Tab_1.TabPage_1.dw_2.Object.Nr_Pedido[Tab_1.TabPage_1.dw_2.GetRow()]

If al_Origem = 0 Then
	If Not wf_Verifica_Pend_Canc(ll_Pedido, 0, as_Operacao) Then Return False
Else
	ll_Produto = Tab_1.TabPage_2.dw_4.Object.Cd_Produto[Tab_1.TabPage_2.dw_4.GetRow()]
	If Not wf_Verifica_Pend_Canc(ll_Pedido, ll_Produto, as_Operacao) Then Return False
End If

If as_Operacao = "C" Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja cancelar as pend$$HEX1$$ea00$$ENDHEX$$ncias para n$$HEX1$$e300$$ENDHEX$$o considerar na meta de compra?", Question!, YesNo!, 2) = 2 Then Return False
Else
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja descancelar as pend$$HEX1$$ea00$$ENDHEX$$ncias?", Question!, YesNo!, 2) = 2 Then Return False
End If

ls_Situacao = Tab_1.TabPage_1.dw_2.Object.Id_Situacao[Tab_1.TabPage_1.dw_2.GetRow()]

If ls_Situacao <> "A" Then
	If as_Operacao = "C" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente pedidos com situa$$HEX2$$e700e300$$ENDHEX$$o 'ATENDIDO' poder$$HEX1$$e300$$ENDHEX$$o ter as pend$$HEX1$$ea00$$ENDHEX$$ncias canceladas.", Exclamation!)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente pedidos com situa$$HEX2$$e700e300$$ENDHEX$$o 'ATENDIDO' poder$$HEX1$$e300$$ENDHEX$$o ter as pend$$HEX1$$ea00$$ENDHEX$$ncias descanceladas.", Exclamation!)
	End If
	
	Return False
End If

ldc_Atend = Tab_1.TabPage_1.dw_2.Object.Pc_Ped_Atendido[Tab_1.TabPage_1.dw_2.GetRow()]

If ldc_Atend >= 100.00 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O percentual de atendimento do pedido deve ser menor que 100%.", Exclamation!)	
	Return False
End If

Try
		
	If al_Origem = 0 Then
		
		If as_Operacao = "C" Then
			If Not wf_Verifica_Nf_Pendente(ll_Pedido, 0) Then Return False
		End If
		
		If Not wf_Grava_Pendencia(ll_Pedido, 0, Ref ls_Erro, as_Operacao) Then Return False
			
	Else
			
		ll_Qt_Recebida	= Tab_1.TabPage_2.dw_4.Object.Qt_Recebida	[Tab_1.TabPage_2.dw_4.GetRow()]
		ll_Qt_Pedida		= Tab_1.TabPage_2.dw_4.Object.Qt_Pedida	[Tab_1.TabPage_2.dw_4.GetRow()]
			
		If as_Operacao = "C" Then
			If ll_Qt_Recebida >= ll_Qt_Pedida Then
				ls_Erro = "A quantidade recebida deve ser menor do que a quantidade pedida."
				Return False
			End If
				
			If Not wf_Verifica_Nf_Pendente(ll_Pedido, ll_Produto) Then Return False
		End If
			
		If Not wf_Grava_Pendencia(ll_Pedido, ll_Produto, Ref ls_Erro, as_Operacao) Then Return False
	End If
	
	lb_Sucesso = True
	
Finally
	
	If lb_Sucesso Then
		SqlCa.of_Commit();
		
		If as_Operacao = "C" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cancelamento de pend$$HEX1$$ea00$$ENDHEX$$ncia realizado com sucesso.")
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Descancelamento de pend$$HEX1$$ea00$$ENDHEX$$ncia realizado com sucesso.")
		End If
				
		If al_Origem = 0 Then
			Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
		Else
			Tab_1.TabPage_2.dw_4.Event ue_Retrieve()
		End If
	Else
		SqlCa.of_Rollback();
		
		If Not IsNull(ls_Erro) And ls_Erro <> "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro, StopSign!)
		End If
	End If
End Try
end function

public function boolean wf_verifica_pend_canc (long al_pedido, long al_produto, string as_operacao);String ls_Retira

If al_Produto = 0 Then
	
	Select coalesce(id_retira_qtde_pendente_meta, 'N')
		Into: ls_Retira
	From pedido_central
	Where nr_pedido = :al_Pedido
	Using SqlCa;
		
	Choose Case SqlCa.SqlCode
		Case 0
			If as_Operacao = "C" Then
				If ls_Retira = "S" Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pedido j$$HEX1$$e100$$ENDHEX$$ teve a pend$$HEX1$$ea00$$ENDHEX$$ncia cancelada.")
					Return False
				End If
			Else
				If ls_Retira = "N" Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pedido N$$HEX1$$c300$$ENDHEX$$O est$$HEX1$$e100$$ENDHEX$$ marcado para cancelar pend$$HEX1$$ea00$$ENDHEX$$ncia.")
					Return False
				End If
			End If
			
		Case 100
		Case -1
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o 'id_retira_qtde_pendente_meta' da tabela pedido_central " + SqlCa.SqlErrText)
			Return False
	End Choose
	
Else
	
	Select coalesce(id_retira_qtde_pendente_meta, 'N')
		Into: ls_Retira
	From pedido_central_produto
	Where nr_pedido = :al_Pedido
		And cd_produto = :al_Produto
	Using SqlCa;
		
	Choose Case SqlCa.SqlCode
		Case 0
			If as_Operacao = "C" Then
				If ls_Retira = "S" Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto j$$HEX1$$e100$$ENDHEX$$ teve a pend$$HEX1$$ea00$$ENDHEX$$ncia cancelada.")
					Return False
				End If
			Else
				If ls_Retira = "N" Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto N$$HEX1$$c300$$ENDHEX$$O est$$HEX1$$e100$$ENDHEX$$ marcado para cancelar pend$$HEX1$$ea00$$ENDHEX$$ncia.")
					Return False
				End If
			End If
			
		Case 100
		Case -1
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o 'id_retira_qtde_pendente_meta' da tabela pedido_central_produto " + SqlCa.SqlErrText)
			Return False
	End Choose
End If

Return True
end function

public function boolean wf_grava_pendencia (long al_pedido, long al_produto, ref string as_erro, string as_operacao);String ls_Retira

If as_Operacao = "C" Then
	ls_Retira = "S"
Else
	ls_Retira = "N"
End If

If al_Produto = 0 Then
			
	Update pedido_central
		Set id_retira_qtde_pendente_meta = :ls_Retira
	Where nr_pedido = :al_Pedido
	Using SqlCa;	
	
	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao atualizar o 'id_retira_qtde_pendente_meta' da tabela pedida_central. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_grava_pendencia. " + SqlCa.SqlErrText
		Return False
	End If			

Else
	
	Update pedido_central_produto
		Set id_retira_qtde_pendente_meta = :ls_Retira
	Where nr_pedido = :al_Pedido
		And cd_produto  = :al_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao atualizar o 'id_retira_qtd_pendente_meta' da tabela = 'pedido_central_produto'. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_grava_pendencia. " + SqlCa.SqlErrText
		Return False
	End If
End If

If Not wf_Grava_Historico_Alteracao_Pedido(al_Pedido, al_Produto, Ref as_Erro, ls_Retira) Then Return False

Return True
end function

public function boolean wf_grava_historico_alteracao_pedido (long al_pedido, long al_produto, ref string as_erro, string as_retira_qtd);Long lvl_Nulo

String ls_Erro
String ls_Retira_Ant

If as_Retira_Qtd = "S" Then
	ls_Retira_Ant = "N"
Else
	ls_Retira_Ant = "S"
End If

SetNull(lvl_Nulo)

If al_Produto = 0 Then al_Produto = lvl_Nulo

Insert Into historico_alteracao_pedido
	 		( nr_pedido,
			 dh_alteracao,
			 nr_matricula_alteracao,
			 cd_tipo_alteracao,
			 cd_produto,
			 nm_coluna,
			 de_alteracao_de,
			 de_alteracao_para,
			 nr_matric_liberacao_alteracao)
Values (:al_Pedido,
		getdate(),
		:gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
		'A',
		:al_Produto,
		'ID_RETIRA_QTDE_PENDENTE_META',
		:ls_Retira_Ant,
		:as_Retira_Qtd,
		:gvo_Aplicacao.ivo_Seguranca.Nr_Matricula)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = "Erro ao gravar o hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700e300$$ENDHEX$$o do pedido. " + SqlCa.SqlErrText
	Return False
End If

Return True
end function

public function boolean wf_habilita_botao ();Long lvl_Pedido

String lvs_Situacao

lvl_Pedido = tab_1.TabPage_1.dw_2.Object.nr_pedido[tab_1.TabPage_1.dw_2.GetRow()]

If wf_Retorna_Situacao_Pedido(lvl_Pedido, ref lvs_Situacao) Then
	If lvs_Situacao = "A" or lvs_Situacao = "C" Then
		Return True
	End If
End If

Return False
end function

on w_ge147_consulta_pedido_fornecedor.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_ge147_consulta_pedido_fornecedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event ue_postopen;call super::ue_postopen;Date lvdt_Movimentacao

lvdt_Movimentacao = Date(gvo_Parametro.of_Dh_Movimentacao())

Tab_1.TabPage_1.dw_1.Event ue_AddRow()
Tab_1.TabPage_1.dw_3.Event ue_AddRow()

Tab_1.TabPage_1.dw_1.Object.dt_pedido_termino 	[1] = lvdt_Movimentacao
Tab_1.TabPage_1.dw_1.Object.dt_pedido_inicio  		[1] = lvdt_Movimentacao

Tab_1.TabPage_1.dw_1.SetFocus()

ivm_Menu.mf_Recuperar(True)

Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_SalvarComo(True)

ivm_Menu.ivb_Permite_Imprimir = True

wf_Insere_Filial_Default()

If Not wf_Verifica_Parametro_Liberacao_Pedido() Then
	Close(This)
End If

Tab_1.TabPage_1.dw_2.Object.bmp_vidalink_legenda.Visible = True
Tab_1.TabPage_1.dw_2.Object.bmp_epharma_legenda.Visible = True
Tab_1.TabPage_1.dw_2.Object.Legenda_Pedido_t.Visible = False

gf_ge003_lista_divisao_fornecedor(Tab_1.TabPage_1.dw_1, "", 1)
end event

event open;call super::open;ivo_Fornecedor 	= Create uo_Fornecedor
ivo_Produto    		= Create uo_Produto
ivo_Pedido_EDI 	= Create uo_Pedido_Central_EDI
ivo_Filial				= Create uo_Filial
io_Comprador		= Create uo_ge149_Comprador

Tab_1.TabPage_1.dw_1.of_SetMenu(ivm_Menu)
Tab_1.TabPage_1.dw_2.of_SetMenu(ivm_Menu)
Tab_1.TabPage_1.dw_3.of_SetMenu(ivm_Menu)
Tab_1.TabPage_2.dw_4.of_SetMenu(ivm_Menu)
end event

event close;call super::close;Destroy(ivo_Fornecedor)
Destroy(ivo_Produto)
Destroy(ivo_Pedido_EDI)
Destroy(ivo_Filial)
Destroy(io_Comprador)
end event

event ue_print;This.Event ue_PrintImmediate()
end event

event ue_printimmediate;Long lvl_Linha, &
     lvl_Pedido
	  
String lvs_Situacao


lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

If lvl_Linha = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um pedido para imprimir.", StopSign!)
	Return
End If

lvl_Pedido   = Tab_1.TabPage_1.dw_2.Object.Nr_Pedido  [lvl_Linha]

If Not wf_Retorna_Situacao_Pedido(lvl_Pedido,  Ref lvs_Situacao) Then
	Return
End If

//lvs_Situacao = Tab_1.TabPage_1.dw_2.Object.Id_Situacao[lvl_Linha]

If lvs_Situacao = "X" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os pedidos com situa$$HEX2$$e700e300$$ENDHEX$$o [CANCELADO] n$$HEX1$$e300$$ENDHEX$$o podem ser impressos.", Information!)
	Tab_1.TabPage_1.dw_2.SetFocus()
	Return	
End If

If lvs_Situacao = "P"  Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os pedidos com situa$$HEX2$$e700e300$$ENDHEX$$o [PENDENTE] n$$HEX1$$e300$$ENDHEX$$o podem ser impressos.", Information!)
	Tab_1.TabPage_1.dw_2.SetFocus()
	Return	
End If

If lvs_Situacao = "R"  Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os pedidos com situa$$HEX2$$e700e300$$ENDHEX$$o [RASCUNHO] n$$HEX1$$e300$$ENDHEX$$o podem ser impressos.", Information!)
	Tab_1.TabPage_1.dw_2.SetFocus()
	Return	
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a impress$$HEX1$$e300$$ENDHEX$$o do pedido '" + String(lvl_Pedido) + "' ?", Question!, YesNo!, 2) = 2 Then
	Return
End If

//Abre tela para selecionar a impressora
If PrintSetup() = -1 Then
	MessageBox("Aviso", "Impress$$HEX1$$e300$$ENDHEX$$o cancelada.")
	Tab_1.TabPage_1.dw_2.SetFocus()
	Return
End If

dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If lvl_Pedido = 142344 Then
	If Not lvds.of_ChangeDataObject("dw_ge147_impressao_pedido_ipi") Then
		Destroy(lvds)
		Return
	End If
Else
	If Not lvds.of_ChangeDataObject("dw_ge147_impressao_pedido") Then
		Destroy(lvds)
		Return
	End If
End If

SetPointer(HourGlass!)

If lvds.Retrieve(lvl_Pedido) > 0 Then
	lvds.Print()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Dados do pedido n$$HEX1$$e300$$ENDHEX$$o localizados para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
End If

SetPointer(Arrow!)


Destroy(lvds)



end event

type dw_visual from dc_w_sheet`dw_visual within w_ge147_consulta_pedido_fornecedor
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge147_consulta_pedido_fornecedor
end type

type tab_1 from tab within w_ge147_consulta_pedido_fornecedor
integer x = 9
integer y = 8
integer width = 4169
integer height = 2180
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_4 tabpage_4
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_4=create tabpage_4
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_4,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_4)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanging;If NewIndex = 2 Then
	If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
		Tab_1.TabPage_4.dw_7.Event ue_Retrieve()

		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um pedido para visualizar os detalhes.", StopSign!)
		Return 1
	End If
End If

If NewIndex = 3 Then
	If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
		Tab_1.TabPage_2.dw_4.Event ue_Retrieve()

		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um pedido para visualizar os produtos.", StopSign!)
		Return 1
	End If
End If

If NewIndex = 4 Then
	If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
		Tab_1.TabPage_3.dw_5.Event ue_Retrieve()
		Tab_1.TabPage_3.dw_6.Event ue_Retrieve()

		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um pedido para visualizar as mensagem da log$$HEX1$$ed00$$ENDHEX$$stica.", StopSign!)
		Return 1
	End If
End If
end event

event selectionchanged;Choose Case NewIndex
	Case 1
		Tab_1.TabPage_1.dw_2.SetFocus()
		ivm_Menu.mf_Imprimir(True)
	Case 2
		Tab_1.TabPage_4.dw_7.SetFocus()
		ivm_Menu.mf_Imprimir(True)
	Case 3
		Tab_1.TabPage_2.dw_4.SetFocus()
		ivm_Menu.mf_Imprimir(True)
	Case 4
		Tab_1.TabPage_3.dw_5.SetFocus()	
		ivm_Menu.mf_Imprimir(False)
End Choose
	
//Parent.Width  = This.Width + 45
//Parent.Height = This.Height + 110
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4133
integer height = 2064
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o de Pedidos"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
cb_5 cb_5
cb_3 cb_3
cb_cancela_1 cb_cancela_1
cb_vincula cb_vincula
cb_1 cb_1
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_3 dw_3
cb_cancelar_pedido cb_cancelar_pedido
cb_imprimir_pedido cb_imprimir_pedido
cb_pedido_edi cb_pedido_edi
dw_2 dw_2
cb_descancelar cb_descancelar
end type

on tabpage_1.create
this.cb_5=create cb_5
this.cb_3=create cb_3
this.cb_cancela_1=create cb_cancela_1
this.cb_vincula=create cb_vincula
this.cb_1=create cb_1
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_3=create dw_3
this.cb_cancelar_pedido=create cb_cancelar_pedido
this.cb_imprimir_pedido=create cb_imprimir_pedido
this.cb_pedido_edi=create cb_pedido_edi
this.dw_2=create dw_2
this.cb_descancelar=create cb_descancelar
this.Control[]={this.cb_5,&
this.cb_3,&
this.cb_cancela_1,&
this.cb_vincula,&
this.cb_1,&
this.gb_3,&
this.gb_2,&
this.gb_1,&
this.dw_1,&
this.dw_3,&
this.cb_cancelar_pedido,&
this.cb_imprimir_pedido,&
this.cb_pedido_edi,&
this.dw_2,&
this.cb_descancelar}
end on

on tabpage_1.destroy
destroy(this.cb_5)
destroy(this.cb_3)
destroy(this.cb_cancela_1)
destroy(this.cb_vincula)
destroy(this.cb_1)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.cb_cancelar_pedido)
destroy(this.cb_imprimir_pedido)
destroy(this.cb_pedido_edi)
destroy(this.dw_2)
destroy(this.cb_descancelar)
end on

type cb_5 from commandbutton within tabpage_1
integer x = 1920
integer y = 1512
integer width = 402
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Exclusivo BA"
end type

event clicked;Long ll_Pedido
Long ll_Linha

String ls_Resp_Excl_BA
String ls_Erro

dw_2.AcceptText()

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE147_PED_EXCLUSIVO_BAHIA", Ref ls_Resp_Excl_BA) Then Return

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a altera$$HEX2$$e700e300$$ENDHEX$$o do pedido para EXCLUSIVO DA BAHIA?", Question!, YesNo!, 2) = 2 Then Return -1

ll_Linha = dw_2.GetRow()

If dw_2.Object.Id_Situacao[ll_Linha] <> "C" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente pedidos com situa$$HEX2$$e700e300$$ENDHEX$$o COLOCADO podem ser alterados para EXCLUSIVO BAHIA.", Exclamation!)
	Return -1
End If

ll_Pedido = dw_2.Object.Nr_Pedido[ll_Linha]

Update pedido_central
	Set de_observacao = 'PEDIDO DE PRODUTOS EXCLUSIVOS PARA A BAHIA',
		  id_atende_falta_pedido_uf = 'BA'
Where nr_pedido = :ll_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao alterar o pedido " + String(ll_Pedido) + " para pedido exclusivo da Bahia. " + ls_Erro, StopSign!)
	Return -1
End If

SqlCa.of_Commit();

dw_2.Event ue_Retrieve()

dw_2.ScrollToRow(ll_Linha)
dw_2.SetRow(ll_Linha)
dw_2.SetFocus()
end event

type cb_3 from commandbutton within tabpage_1
integer x = 3063
integer y = 1512
integer width = 526
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Descancelar Pend."
end type

event clicked;Long		lvl_linha_dw_3
String	ls_nr_pedido_sap


lvl_linha_dw_3	= Tab_1.TabPage_1.dw_3.GetRow()

if lvl_linha_dw_3 > 0 then
	ls_nr_pedido_sap	= Tab_1.TabPage_1.dw_3.Object.nr_pedido_sap[lvl_linha_dw_3]
	
	if Not IsNull(ls_nr_pedido_sap) and Trim(ls_nr_pedido_sap) <> '' then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Este pedido foi criado dentro do SAP e n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel descancelar as pend$$HEX1$$ea00$$ENDHEX$$ncias por esta tela. Consulte respons$$HEX1$$e100$$ENDHEX$$vel.", StopSign!)
		Return -1
	end if
end if

If Not wf_Valida_Canc_Pend(0, "D") Then Return -1
end event

type cb_cancela_1 from commandbutton within tabpage_1
integer x = 2523
integer y = 1512
integer width = 507
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Canc. Pend$$HEX1$$ea00$$ENDHEX$$ncias"
end type

event clicked;Long		lvl_linha_dw_3
String	ls_nr_pedido_sap


lvl_linha_dw_3	= Tab_1.TabPage_1.dw_3.GetRow()

if lvl_linha_dw_3 > 0 then
	ls_nr_pedido_sap	= Tab_1.TabPage_1.dw_3.Object.nr_pedido_sap[lvl_linha_dw_3]
	
	if Not IsNull(ls_nr_pedido_sap) and Trim(ls_nr_pedido_sap) <> '' then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Este pedido foi criado dentro do SAP e n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel cancelar as pend$$HEX1$$ea00$$ENDHEX$$ncias por esta tela. Consulte respons$$HEX1$$e100$$ENDHEX$$vel.", StopSign!)
		Return -1
	end if
end if

If Not wf_Valida_Canc_Pend(0, "C") Then Return -1
end event

type cb_vincula from commandbutton within tabpage_1
boolean visible = false
integer x = 425
integer y = 1412
integer width = 128
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Vinc. Chave Acesso"
end type

event clicked;Long ll_Linha
Long ll_Pedido

dw_2.AcceptText()

ll_Linha = dw_2.GetRow()

ll_Pedido = dw_2.Object.Nr_Pedido[ll_Linha]

OpenWithParm(w_ge147_Vincula_Chave_Acesso, String(ll_Pedido))
end event

type cb_1 from commandbutton within tabpage_1
integer x = 594
integer y = 1512
integer width = 430
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Mens. Log$$HEX1$$ed00$$ENDHEX$$stica"
end type

event clicked;Long ll_Pedido, lvl_linha_dw_3
String ls_Fornecedor, ls_nr_pedido_sap


lvl_linha_dw_3	= Tab_1.TabPage_1.dw_3.GetRow()

if lvl_linha_dw_3 > 0 then
	ls_nr_pedido_sap	= Tab_1.TabPage_1.dw_3.Object.nr_pedido_sap[lvl_linha_dw_3]
	
	if Not IsNull(ls_nr_pedido_sap) and Trim(ls_nr_pedido_sap) <> '' then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Este pedido foi criado dentro do SAP e n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$c900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel alterar a mensagem de log$$HEX1$$ed00$$ENDHEX$$stica por essa tela. Consulte respons$$HEX1$$e100$$ENDHEX$$vel.", StopSign!)
		Return -1
	end if
end if

If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then

	Tab_1.TabPage_1.dw_2.AcceptText()
	
	ls_Fornecedor	= Tab_1.TabPage_1.dw_2.Object.Cd_Fornecedor[Tab_1.TabPage_1.dw_2.GetRow()]
	ll_Pedido			= Tab_1.TabPage_1.dw_2.Object.nr_pedido[Tab_1.TabPage_1.dw_2.GetRow()]
	
	If Not wf_Verifica_Nf_Compra_Pendente(ls_Fornecedor, ll_Pedido) Then
		Return -1
	End If
	
	OpenWithParm(w_ge147_mensagem_logistica, ll_Pedido)
End If
end event

type gb_3 from groupbox within tabpage_1
integer x = 9
integer y = 1628
integer width = 4087
integer height = 420
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Detalhes do Pedido Selecionado"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within tabpage_1
integer x = 9
integer y = 440
integer width = 4091
integer height = 1052
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Pedidos"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within tabpage_1
integer x = 9
integer y = 12
integer width = 4087
integer height = 424
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Par$$HEX1$$e200$$ENDHEX$$metros de Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within tabpage_1
integer x = 37
integer y = 76
integer width = 4032
integer height = 328
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge147_selecao"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event losefocus;call super::losefocus;If IsValid(ivo_Fornecedor) Then
	This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
	This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
End If

If IsValid(ivo_Produto) Then
	This.Object.cd_produto[1] = ivo_Produto.cd_produto
	This.Object.nm_produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
End If

If IsValid(io_Comprador) Then
	This.Object.nr_matricula[1] = io_Comprador.nr_matricula
	This.Object.nm_usuario  [1] = io_Comprador.nm_usuario
End If
end event

event itemchanged;call super::itemchanged;Tab_1.TabPage_1.dw_2.Event ue_Reset()

If dwo.Name = "nm_fornecedor" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Fornecedor.Nm_Razao_Social Then
			Return 1
		End If
	Else
		ivo_Fornecedor.of_Inicializa()
		
		This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
		This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
	End If
	
	gf_ge003_lista_divisao_fornecedor(Tab_1.TabPage_1.dw_1, ivo_Fornecedor.Cd_Fornecedor, 1)
End If

If dwo.Name = "nm_produto" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque Then
			Return 1
		End If
	Else
		ivo_Produto.of_Inicializa()
		
		This.Object.cd_produto[1] = ivo_Produto.cd_produto
		This.Object.nm_produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
	End If
End If

If dwo.Name = "nm_usuario" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> io_Comprador.nm_usuario Then
			Return 1
		End If
	Else
		io_Comprador.of_Inicializa()
		
		This.Object.nr_matricula[1] = io_Comprador.nr_matricula
		This.Object.nm_usuario  [1] = io_Comprador.nm_usuario
	End If
End If

If dwo.Name = "nm_filial" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Filial.nm_fantasia Then
			Return 1
		End If
	Else
		ivo_Filial.of_Inicializa()
		
		This.Object.cd_filial		[1] = ivo_Filial.cd_filial
		This.Object.nm_filial		[1] = ivo_Filial.nm_fantasia
	End If
End If
end event

event ue_key;If Key = KeyEnter! Then
			
	If This.GetColumnName() = "nm_fornecedor" Then
		ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
		
		If ivo_Fornecedor.Localizado Then
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
		
		gf_ge003_lista_divisao_fornecedor(Tab_1.TabPage_1.dw_1, ivo_Fornecedor.Cd_Fornecedor, 1)
	End If 
	
	If This.GetColumnName() = "nm_produto" Then
		ivo_Produto.of_Localiza_Produto(This.GetText())
		
		If ivo_Produto.Localizado Then
			This.Object.cd_produto[1] = ivo_Produto.cd_produto
			This.Object.nm_produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
	End If
	
	If This.GetColumnName() = "nm_usuario" Then
		io_Comprador.of_Localiza_Comprador(This.GetText())
		
		If io_Comprador.Localizado Then
			This.Object.nr_matricula[1] = io_Comprador.nr_matricula
			This.Object.nm_usuario  [1] = io_Comprador.nm_usuario
		End If
	End If
	
	If This.GetColumnName() = "nm_filial" Then
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
			This.Object.cd_filial	[1] = ivo_Filial.cd_filial
			This.Object.nm_filial	[1] = ivo_Filial.nm_fantasia
		End If
	End If
	
End If


	
end event

event editchanged;call super::editchanged;Tab_1.TabPage_1.dw_2.Event ue_Reset()

If dwo.Name = "nm_fornecedor" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Fornecedor.Nm_Razao_Social Then
			Return 1
		End If
	Else
		ivo_Fornecedor.of_Inicializa()
		
		This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
		This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
	End If
	
	gf_ge003_lista_divisao_fornecedor(Tab_1.TabPage_1.dw_1, ivo_Fornecedor.Cd_Fornecedor, 1)
End If

If dwo.Name = "nm_produto" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque Then
			Return 1
		End If
	Else
		ivo_Produto.of_Inicializa()
		
		This.Object.cd_produto[1] = ivo_Produto.cd_produto
		This.Object.nm_produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
	End If
End If

If dwo.Name = "nm_usuario" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> io_Comprador.nm_usuario Then
			Return 1
		End If
	Else
		io_Comprador.of_Inicializa()
		
		This.Object.nr_matricula[1] = io_Comprador.nr_matricula
		This.Object.nm_usuario  [1] = io_Comprador.nm_usuario
	End If
End If

If dwo.Name = "nm_filial" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Filial.nm_fantasia Then
			Return 1
		End If
	Else
		ivo_Filial.of_Inicializa()
		
		This.Object.cd_filial		[1] = ivo_Filial.cd_filial
		This.Object.nm_filial		[1] = ivo_Filial.nm_fantasia
	End If
End If
end event

type dw_3 from dc_uo_dw_base within tabpage_1
integer x = 27
integer y = 1696
integer width = 4041
integer height = 340
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge147_detalhe_pedido"
end type

type cb_cancelar_pedido from commandbutton within tabpage_1
integer x = 3616
integer y = 1512
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
boolean enabled = false
string text = "&Cancelar Pedido"
end type

event clicked;Long lvl_Linha
Long lvl_Pedido
Long lvl_filial
Long lvl_linha_dw_3
	  
String lvs_Situacao
String lvs_Responsavel
String ls_Procedimento
String ls_Motivo
String ls_nr_pedido_sap


lvl_linha_dw_3	= Tab_1.TabPage_1.dw_3.GetRow()

if lvl_linha_dw_3 > 0 then
	ls_nr_pedido_sap	= Tab_1.TabPage_1.dw_3.Object.nr_pedido_sap[lvl_linha_dw_3]
	
	if Not IsNull(ls_nr_pedido_sap) and Trim(ls_nr_pedido_sap) <> '' then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Este pedido foi criado dentro do SAP e n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel cancelar um pedido por esta tela. Consulte respons$$HEX1$$e100$$ENDHEX$$vel.", StopSign!)
		Return -1
	end if
end if

lvl_Linha = dw_2.GetRow()

If lvl_Linha = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um pedido para cancelar.", StopSign!)
	Return
End If

lvl_Pedido   = dw_2.Object.Nr_Pedido  [lvl_Linha]
lvs_Situacao = dw_2.Object.Id_Situacao[lvl_Linha]
lvl_filial		= dw_2.Object.cd_filial[lvl_Linha]

ls_Procedimento = "GE147_CANCELAMENTO_PEDIDO"

If lvs_Situacao <> 'R' and  lvs_Situacao <> 'C' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Situa$$HEX2$$e700e300$$ENDHEX$$o '" + lvs_Situacao + "' n$$HEX1$$e300$$ENDHEX$$o prevista para o cancelamento.")
	Return
End If

If lvl_Filial = 534 Then 
	If lvs_Situacao = 'C' Then
		// Procedimento liberado somente para os coordenadores 
		ls_Procedimento = "GE147_CANCELAMENTO_PEDIDO_COLOCADO"
	End If
Else
	If lvs_Situacao <> "C" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente pedidos com situa$$HEX2$$e700e300$$ENDHEX$$o [COLOCADO] podem ser cancelados.", Information!)
		dw_2.SetFocus()
		Return	
	End If
End If

If Not gvo_aplicacao.ivo_seguranca.of_libera_acesso_procedimento(ls_Procedimento, Ref lvs_Responsavel) Then Return

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma o cancelamento do pedido '" + String(lvl_Pedido) + "' ?", Question!, YesNo!, 2) = 2 Then
	Return
End If

OpenWithParm(w_ge147_motivo_cancelamento, "")

ls_Motivo = Message.StringParm

If IsNull(ls_Motivo) Then Return -1 //Usu$$HEX1$$e100$$ENDHEX$$rio clicou em "Cancelar" na tela w_ge147_motivo_cancelamento

SetPointer(HourGlass!)

Update pedido_central
	Set	id_situacao						= 'X',
			dh_cancelamento				= getdate(),
			nr_matricula_cancelamento	= :lvs_Responsavel,
			de_motivo_cancelamento	= :ls_Motivo
Where nr_pedido = :lvl_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Cancelamento do Pedido")
Else
	SqlCa.of_Commit()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pedido '" + String(lvl_Pedido) + "' cancelado com sucesso.", Information!)
	
	dw_2.Event ue_Retrieve()
End If

SetPointer(Arrow!)
end event

type cb_imprimir_pedido from commandbutton within tabpage_1
integer x = 1467
integer y = 1512
integer width = 430
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Imprimir Lista"
end type

event clicked;Long lvl_Pedido,&
	 lvl_Produto,&
	 lvl_Filial

Date lvdt_Pedido_I, &
     lvdt_Pedido_T, &
     lvdt_Entrega_I, &
     lvdt_Entrega_T
	  
String lvs_Fornecedor,&
	   lvs_Usuario

dc_uo_ds_base lvds

lvds = Create dc_uo_ds_base

If Not lvds.of_ChangeDataObject("dw_ge147_relatorio_pedido") Then
	Destroy(lvds)
	Return
End If

Tab_1.TabPage_1.dw_1.AcceptText()

lvl_Pedido     = long(Tab_1.TabPage_1.dw_1.Object.Nr_Pedido			[1])
lvs_Fornecedor = Tab_1.TabPage_1.dw_1.Object.Cd_Fornecedor		[1]
lvdt_Pedido_I  = Tab_1.TabPage_1.dw_1.Object.Dt_Pedido_Inicio	[1]
lvdt_Pedido_T  = Tab_1.TabPage_1.dw_1.Object.Dt_Pedido_Termino	[1]
lvdt_Entrega_I = Tab_1.TabPage_1.dw_1.Object.Dt_Entrega_Inicio	[1]
lvdt_Entrega_T = Tab_1.TabPage_1.dw_1.Object.Dt_Entrega_Termino[1]
lvl_Produto    = Tab_1.TabPage_1.dw_1.Object.cd_produto			[1]
lvs_Usuario    = Tab_1.TabPage_1.dw_1.Object.nr_matricula		[1]
lvl_Filial	   = Tab_1.TabPage_1.dw_1.Object.cd_filial			[1]

If Not IsNull(lvl_Pedido) and lvl_Pedido > 0 Then
	lvds.of_AppendWhere("p.nr_pedido = " + String(lvl_Pedido))
Else
	If Not IsNull(lvs_Fornecedor) and lvs_Fornecedor <> "" Then
		lvds.of_AppendWhere("p.cd_fornecedor = '" + lvs_Fornecedor + "'")
	End If
	
	If Not IsNull(lvdt_Pedido_I) Then
		lvds.of_AppendWhere("p.dh_pedido >= '" + String(lvdt_Pedido_I, "yyyy/mm/dd") + "'")
	End If
	
	If Not IsNull(lvdt_Pedido_T) Then
		lvds.of_AppendWhere("p.dh_pedido <= '" + String(lvdt_Pedido_T, "yyyy/mm/dd") + "'")
	End If

	If Not IsNull(lvdt_Entrega_I) Then
		lvds.of_AppendWhere("p.dh_previsao_entrega >= '" + String(lvdt_Entrega_I, "yyyy/mm/dd") + "'")
	End If
	
	If Not IsNull(lvdt_Entrega_T) Then
		lvds.of_AppendWhere("p.dh_previsao_entrega <= '" + String(lvdt_Entrega_T, "yyyy/mm/dd") + "'")
	End If
	
	If Not IsNull(lvs_Usuario) and lvs_Usuario <> ""  Then
		lvds.of_AppendWhere("p.nr_matricula_cadastramento = '" + lvs_Usuario + "'")
	End If
End If

If Not IsNull(lvl_Produto) and lvl_Produto > 0 Then
	lvds.of_AppendFrom("pedido_central_produto pp")
	
	lvds.of_AppendWhere("p.nr_pedido = pp.nr_pedido")
	lvds.of_AppendWhere("pp.cd_produto = " + String(lvl_Produto))
End If

lvds.of_AppendWhere("p.cd_filial = " + String(lvl_Filial))
lvds.Object.st_periodo.Text = String(lvdt_Pedido_I,"dd/mm/yyyy") + " $$HEX1$$e000$$ENDHEX$$ " + String(lvdt_Pedido_T,"dd/mm/yyyy")

SetPointer(HourGlass!)

If lvds.Retrieve(lvl_Pedido) > 0 Then
	//Abre tela para selecionar a impressora
	If PrintSetup() = -1 Then
		MessageBox("Aviso", "Impress$$HEX1$$e300$$ENDHEX$$o cancelada.")
		Return -1
	End If
	lvds.Print()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Dados do pedido n$$HEX1$$e300$$ENDHEX$$o localizados para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
End If

SetPointer(Arrow!)

Destroy(lvds)


end event

type cb_pedido_edi from commandbutton within tabpage_1
integer x = 1051
integer y = 1512
integer width = 384
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Pedido (EDI)"
end type

event clicked;Long lvl_Pedido

String lvs_Responsavel

//Tab_1.TabPage_1.dw_2.AcceptText()
//
//lvl_Pedido = Tab_1.TabPage_1.dw_2.Object.nr_pedido[Tab_1.TabPage_1.dw_2.GetRow()]
//
//ivo_Pedido_EDI.of_Gera_Arquivo(lvl_Pedido)


If Not gvo_aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE147_GERA_ARQUIVO_EDI", ref lvs_Responsavel) Then Return

OpenWithParm(w_ge147_gera_arquivo_edi, lvs_Responsavel)


end event

type dw_2 from dc_uo_dw_base within tabpage_1
integer x = 37
integer y = 488
integer width = 4032
integer height = 976
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge147_lista_pedido"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()

This.of_SetRowSelection("if (id_retira_qtde_pendente_meta = ~"S~", rgb(255, 0, 0), rgb(255, 255, 255))","")
end event

event ue_postretrieve;Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Imprimir, &
		  lvb_Habilitar = False

Decimal lvdc_Percentual_Atendido
Decimal ldc_Vl_Total_Pedido

Long 	lvl_Linha, &
		lvl_nro_pedido, &
		ll_Find

String    lvs_Pedido_Situacao

Tab_1.TabPage_1.dw_2.AcceptText()

If pl_Linhas > 0 Then
	lvb_Classificar	= IsValid(This.ivo_Sort)
	lvb_Filtrar     	= IsValid(This.ivo_Filter)
	lvb_Localizar  	= IsValid(This.ivo_Find)
	
	lvb_Imprimir	= True
	lvb_Habilitar	= True
	
	If wf_Verifica_Produto() = -1 Then Return -1
	
	This.ScrollToRow(1)
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
	SetNull(is_responsavel)
	SetNull(is_Resp_Canc)
	
	For lvl_Linha = 1 To pl_Linhas
		lvs_Pedido_Situacao	= Tab_1.TabPage_1.dw_2.Object.id_situacao		[lvl_Linha]
		lvl_nro_pedido			= Tab_1.TabPage_1.dw_2.Object.nr_pedido  		[lvl_Linha]
		ldc_Vl_Total_Pedido	= Tab_1.TabPage_1.dw_2.Object.Vl_Total_Pedido[lvl_Linha]
		// Verifica o percentual do atendimento do pedido
		If lvs_Pedido_Situacao = 'A' Then
			lvdc_Percentual_Atendido = wf_Percentual_Atendido(lvl_nro_pedido)
						
		Else
			lvdc_Percentual_Atendido	= 0.00
		End If
		
		Tab_1.TabPage_1.dw_2.Object.pc_ped_atendido	[lvl_Linha] = lvdc_Percentual_Atendido
	Next
			
Else
	If pl_Linhas = 0 Then
		Tab_1.TabPage_1.dw_3.Reset()
		Tab_1.TabPage_1.dw_3.Event ue_AddRow()
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum pedido localizado com os par$$HEX1$$e200$$ENDHEX$$metros informados.", Information!)
				
		Tab_1.TabPage_1.dw_3.SetFocus()
	End If
End If

ivm_Menu.mf_Classificar(lvb_Classificar)
ivm_Menu.mf_Filtrar(lvb_Filtrar)
ivm_Menu.mf_Localizar(lvb_Localizar)
ivm_Menu.mf_Imprimir(lvb_Imprimir)

cb_Cancelar_Pedido.Enabled	= lvb_Habilitar
cb_Imprimir_Pedido.Enabled	= lvb_Habilitar
cb_Descancelar.Enabled			= lvb_Habilitar
cb_Vincula.Enabled				= lvb_Habilitar

ll_Find = Tab_1.TabPage_1.dw_2.Find("id_retira_qtde_pendente_meta = 'S'", 1, Tab_1.TabPage_1.dw_2.RowCount())
	
If ll_Find > 0 Then
	Tab_1.TabPage_1.dw_2.Object.Legenda_Pedido_t.Visible = True
Else
	Tab_1.TabPage_1.dw_2.Object.Legenda_Pedido_t.Visible = False
End If

Return pl_Linhas
end event

event rowfocuschanged;call super::rowfocuschanged;Decimal lvdc_Percentual_Atendido

Long lvl_Pedido

String lvs_Nome,&
       lvs_Situacao 

If CurrentRow > 0 Then
	Tab_1.TabPage_1.dw_3.Object.Dh_Emissao                			[1] = Tab_1.TabPage_1.dw_2.Object.Dh_Emissao                			[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.Qt_Dias_Suprimento        		[1] = Tab_1.TabPage_1.dw_2.Object.Qt_Dias_Suprimento        		[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.Cd_Condicao_Pagamento     	[1] = Tab_1.TabPage_1.dw_2.Object.Cd_Condicao_Pagamento     	[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.De_Condicao_Pagamento     	[1] = Tab_1.TabPage_1.dw_2.Object.De_Condicao               			[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.Pc_desconto               			[1] = Tab_1.TabPage_1.dw_2.Object.Pc_Desconto               			[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.Nr_Matricula_Cadastramento	[1] = Tab_1.TabPage_1.dw_2.Object.Nr_Matricula_Cadastramento	[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.Dh_Cancelamento           		[1] = Tab_1.TabPage_1.dw_2.Object.Dh_Cancelamento           		[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.Nr_Matricula_Cancelamento 	[1] = Tab_1.TabPage_1.dw_2.Object.Nr_Matricula_Cancelamento 	[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.De_Transportadora         		[1] = Tab_1.TabPage_1.dw_2.Object.De_Transportadora         		[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.De_Observacao            			[1] = Tab_1.TabPage_1.dw_2.Object.De_Observacao             			[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.Id_Tipo_Frete	            			[1] = Tab_1.TabPage_1.dw_2.Object.Id_Tipo_Frete             			[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.nr_pedido_sap	            			[1] = Tab_1.TabPage_1.dw_2.Object.nr_pedido_sap             			[CurrentRow]
	
	
	lvs_Situacao = Tab_1.TabPage_1.dw_2.Object.id_situacao[CurrentRow]
	lvl_Pedido   = Tab_1.TabPage_1.dw_2.Object.nr_pedido  [CurrentRow]
			
	wf_Localiza_Usuario(Tab_1.TabPage_1.dw_3.Object.Nr_Matricula_Cadastramento[1], ref lvs_Nome)
	
	Tab_1.TabPage_1.dw_3.Object.Nm_Cadastramento[1] = lvs_Nome
	
	If Not IsNull(Tab_1.TabPage_1.dw_3.Object.Nr_Matricula_Cancelamento[1]) Then
		wf_Localiza_Usuario(Tab_1.TabPage_1.dw_3.Object.Nr_Matricula_Cancelamento[1], ref lvs_Nome)
	Else
		lvs_Nome = ""
	End If
		
// Somente os pedidos colocados podem ser cancelados	
//	If lvs_Situacao = 'C' Then
//		cb_Cancelar_Pedido.Enabled = True
//		cb_Imprimir_Pedido.Enabled = True
//	Else
//		cb_Cancelar_Pedido.Enabled = False
//		cb_Imprimir_Pedido.Enabled = False
//	End If
	
	// Verifica o percentual do atendimento do pedido
	If lvs_Situacao = 'A' Then
		lvdc_Percentual_Atendido = wf_Percentual_Atendido(lvl_Pedido)
	Else
		lvdc_Percentual_Atendido = 0.00
	End If
	
	Tab_1.TabPage_1.dw_3.Object.pc_atendido	   		[1] = lvdc_Percentual_Atendido
	Tab_1.TabPage_1.dw_3.Object.Nm_Cancelamento	[1] = lvs_Nome
End If
end event

event ue_preretrieve;call super::ue_preretrieve;Date	lvdt_Pedido_I, &
		lvdt_Pedido_T, &
		lvdt_Entrega_I, &
		lvdt_Entrega_T

Long	lvl_Produto, &
		lvl_Filial, &
		ll_Divisao
	  
String	lvs_Fornecedor, &
			lvs_Usuario, &
			ls_Id_Pedido, &
			ls_Situacao, &
			ls_nr_pedido

dw_1.AcceptText()

ls_nr_pedido     	= dw_1.Object.Nr_Pedido[1]
lvs_Fornecedor 	= dw_1.Object.Cd_Fornecedor[1]
lvdt_Pedido_I  	= dw_1.Object.Dt_Pedido_Inicio[1]
lvdt_Pedido_T 		= dw_1.Object.Dt_Pedido_Termino[1]
lvdt_Entrega_I 	= dw_1.Object.Dt_Entrega_Inicio[1]
lvdt_Entrega_T 	= dw_1.Object.Dt_Entrega_Termino[1]
lvl_Produto    	= dw_1.Object.cd_produto[1]
lvs_Usuario    	= dw_1.Object.nr_matricula[1]
lvl_Filial	   	= dw_1.Object.cd_filial[1]
ls_Situacao			= dw_1.Object.id_situacao[1]	
ls_Id_Pedido		= dw_1.Object.Id_Pedido[1]
ll_Divisao			= dw_1.Object.Nr_Divisao_Fornecedor[1]

If IsNull(lvl_Filial) Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione uma filial.")
	dw_1.Event ue_Pos(1,"nm_filial")
	Return -1
End If

If Not IsNull(ls_nr_Pedido) and Trim(ls_nr_Pedido) <> '' Then
	This.of_AppendWhere("(p.nr_pedido = " + ls_nr_Pedido + " or p.nr_pedido_sap = '" + ls_nr_Pedido + "')")
Else
	If Not IsNull(lvs_Fornecedor) and lvs_Fornecedor <> "" Then
		This.of_AppendWhere("p.cd_fornecedor = '" + lvs_Fornecedor + "'")

		If Not IsNull(ll_Divisao) And ll_Divisao > 0 Then
			This.of_AppendWhere("pp.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + lvs_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")")
		End If
	End If

	If ls_Situacao <> 'T' Then
		This.of_AppendWhere("p.id_situacao = '" + ls_Situacao + "'")
	End If

	If Not IsNull(lvdt_Pedido_I) Then
		This.of_AppendWhere("p.dh_pedido >= '" + String(lvdt_Pedido_I, "yyyy/mm/dd") + "'")
	End If

	If Not IsNull(lvdt_Pedido_T) Then
		This.of_AppendWhere("p.dh_pedido <= '" + String(lvdt_Pedido_T, "yyyy/mm/dd") + "'")
	End If

	If Not IsNull(lvdt_Entrega_I) Then
		This.of_AppendWhere("p.dh_previsao_entrega >= '" + String(lvdt_Entrega_I, "yyyy/mm/dd") + "'")
	End If

	If Not IsNull(lvdt_Entrega_T) Then
		This.of_AppendWhere("p.dh_previsao_entrega <= '" + String(lvdt_Entrega_T, "yyyy/mm/dd") + "'")
	End If

	If Not IsNull(lvs_Usuario) and lvs_Usuario <> ""  Then
		This.of_AppendWhere("p.nr_matricula_cadastramento = '" + lvs_Usuario + "'")
	End If
End If

If Not IsNull(lvl_Produto) and lvl_Produto > 0 Then
//	This.of_AppendFrom("pedido_central_produto pp")	
//	This.of_AppendWhere("p.nr_pedido = pp.nr_pedido")

	This.of_AppendWhere("pp.cd_produto = " + String(lvl_Produto))
End If

This.of_AppendWhere("p.cd_filial = " + String(lvl_Filial))

Choose Case ls_Id_Pedido
	Case "T"
		
	Case "N"
		This.of_AppendWhere("(p.id_pbm = 'N' or p.id_pbm is null) and (p.id_farmacia_governo = 'N' or p.id_farmacia_governo is null) and (p.id_atende_falta_pedido_uf = 'N' or p.id_atende_falta_pedido_uf is null)")
		
	Case "R"
		This.of_AppendWhere("p.id_pbm = 'S'")
		
	Case "F"
		This.of_AppendWhere("p.id_farmacia_governo = 'S'")
		
	Case "B"
		This.of_AppendWhere("p.id_atende_falta_pedido_uf = 'BA'")
		
	Case "A"
		This.of_AppendWhere("p.id_acordo_titulo = 'S'")
		
End Choose

Return 1
end event

type cb_descancelar from commandbutton within tabpage_1
integer x = 14
integer y = 1508
integer width = 549
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Descancelar Pedido"
end type

event clicked;Long 	lvl_Pedido, &
		lvl_Linha, &
		lvl_linha_dw_3
		
String lvs_Situacao, &
		lvs_Responsavel,&
		lvs_aux,&
		ls_Situacao_Ant,&
		ls_Motivo_Canc,&
		ls_nr_pedido_sap


lvl_linha_dw_3	= Tab_1.TabPage_1.dw_3.GetRow()

if lvl_linha_dw_3 > 0 then
	ls_nr_pedido_sap	= Tab_1.TabPage_1.dw_3.Object.nr_pedido_sap[lvl_linha_dw_3]
	
	if Not IsNull(ls_nr_pedido_sap) and Trim(ls_nr_pedido_sap) <> '' then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Este pedido foi criado dentro do SAP e n$$HEX1$$e300$$ENDHEX$$o pode ser DESCANCELADO por esta tela. Consulte respons$$HEX1$$e100$$ENDHEX$$vel.", StopSign!)
		Return -1
	end if
end if

lvl_Linha = dw_2.GetRow()

If	lvl_Linha = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione um pedido para reverter o cancelamento", StopSign!)
	Return
End If

lvs_Situacao 		= dw_2.Object.id_situacao					[lvl_Linha]
lvl_Pedido 			= dw_2.Object.nr_Pedido  					[lvl_Linha]
ls_Situacao_Ant	= dw_2.Object.id_situacao_anterior		[lvl_Linha]
ls_Motivo_Canc		= dw_2.Object.de_motivo_cancelamento[lvl_Linha]

If lvs_Situacao <> 'X' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A situa$$HEX2$$e700e300$$ENDHEX$$o do pedido n$$HEX1$$e300$$ENDHEX$$o se encontra [CANCELADO]. Selecione apenas pedidos Cancelados.", Information!)
	dw_2.setFocus()
	Return
End If

If IsNull(ls_Situacao_Ant) and ls_Motivo_Canc = 'EM RASCUNHO A MAIS DE 7 DIAS DA DATA DO PEDIDO' Then ls_Situacao_Ant = 'R'

If IsNull(ls_Situacao_Ant) Then  ls_Situacao_Ant = " "

If Not gvo_aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE147_DESCANCELAMENTO_PEDIDO", ref lvs_Responsavel) Then Return

lvs_aux = ls_Situacao_Ant + String(lvl_Pedido,"0000000000") + lvs_Responsavel

OpenWithParm(w_ge147_descancelamento_pedido, lvs_aux)

dw_2.Event ue_Retrieve()
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4133
integer height = 2064
long backcolor = 67108864
string text = "Detalhes do Pedido"
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
integer width = 3607
integer height = 1684
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Detalhe"
borderstyle borderstyle = styleraised!
end type

type dw_7 from dc_uo_dw_base within tabpage_4
integer x = 82
integer y = 96
integer width = 3497
integer height = 1536
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge147_cabecalho_detalhe"
end type

event ue_recuperar;//OverRide

Tab_1.TabPage_1.dw_2.AcceptText()

Return This.Retrieve(Tab_1.TabPage_1.dw_2.Object.Nr_Pedido[Tab_1.TabPage_1.dw_2.GetRow()])
end event

event ue_postretrieve;call super::ue_postretrieve;Tab_1.TabPage_1.dw_2.AcceptText()

If pl_Linhas > 0 Then
	If Tab_1.TabPage_1.dw_2.Object.Id_Situacao[Tab_1.TabPage_1.dw_2.GetRow()] = 'A' Then
		Tab_1.TabPage_4.dw_7.Object.Pc_Atendido[1] = wf_Percentual_Atendido(Tab_1.TabPage_1.dw_2.Object.Nr_Pedido[Tab_1.TabPage_1.dw_2.GetRow()])
	End If
	
	wf_Tipo_Pedido()
End If

Return pl_Linhas
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4133
integer height = 2064
long backcolor = 80269524
string text = "Produtos do Pedido"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
cb_4 cb_4
cb_2 cb_2
gb_4 gb_4
dw_4 dw_4
end type

on tabpage_2.create
this.cb_4=create cb_4
this.cb_2=create cb_2
this.gb_4=create gb_4
this.dw_4=create dw_4
this.Control[]={this.cb_4,&
this.cb_2,&
this.gb_4,&
this.dw_4}
end on

on tabpage_2.destroy
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.gb_4)
destroy(this.dw_4)
end on

type cb_4 from commandbutton within tabpage_2
integer x = 3529
integer y = 1948
integer width = 539
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Descancelar Pend."
end type

event clicked;Long		lvl_linha_dw_3
String	ls_nr_pedido_sap


lvl_linha_dw_3	= Tab_1.TabPage_1.dw_3.GetRow()

if lvl_linha_dw_3 > 0 then
	ls_nr_pedido_sap	= Tab_1.TabPage_1.dw_3.Object.nr_pedido_sap[lvl_linha_dw_3]
	
	if Not IsNull(ls_nr_pedido_sap) and Trim(ls_nr_pedido_sap) <> '' then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Este pedido foi criado dentro do SAP e n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel descancelar as pend$$HEX1$$ea00$$ENDHEX$$ncias por esta tela. Consulte respons$$HEX1$$e100$$ENDHEX$$vel.", StopSign!)
		Return -1
	end if
end if

If Not wf_Valida_Canc_Pend(1, "D") Then Return -1
end event

type cb_2 from commandbutton within tabpage_2
integer x = 2967
integer y = 1948
integer width = 517
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Canc. Pend$$HEX1$$ea00$$ENDHEX$$ncias"
end type

event clicked;Long		lvl_linha_dw_3
String	ls_nr_pedido_sap


lvl_linha_dw_3	= Tab_1.TabPage_1.dw_3.GetRow()

if lvl_linha_dw_3 > 0 then
	ls_nr_pedido_sap	= Tab_1.TabPage_1.dw_3.Object.nr_pedido_sap[lvl_linha_dw_3]
	
	if Not IsNull(ls_nr_pedido_sap) and Trim(ls_nr_pedido_sap) <> '' then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Este pedido foi criado dentro do SAP e n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel cancelar as pend$$HEX1$$ea00$$ENDHEX$$ncias por esta tela. Consulte respons$$HEX1$$e100$$ENDHEX$$vel.", StopSign!)
		Return -1
	end if
end if

If Not wf_Valida_Canc_Pend(1, "C") Then Return -1
end event

type gb_4 from groupbox within tabpage_2
integer x = 9
integer y = 12
integer width = 4096
integer height = 1916
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Lista de Produtos do Pedido"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within tabpage_2
integer x = 32
integer y = 68
integer width = 4041
integer height = 1824
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge147_lista_produto"
boolean vscrollbar = true
end type

event ue_postretrieve;Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Imprimir
		  
Long ll_Find

Tab_1.TabPage_2.dw_4.AcceptText()

If pl_Linhas > 0 Then
	lvb_Classificar	= IsValid(This.ivo_Sort)
	lvb_Filtrar     	= IsValid(This.ivo_Filter)
	lvb_Localizar	= IsValid(This.ivo_Find)
	
	This.ScrollToRow(1)
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
		
	 If Not wf_Saldo_Em_Transito() Then Return -1
	
	If wf_habilita_botao() Then
		This.ivm_Menu.mf_SalvarComo(True)
		lvb_Imprimir = True
	Else
		This.ivm_Menu.mf_SalvarComo(False)
		lvb_Imprimir = False
	End If
		
	ll_Find = Tab_1.TabPage_2.dw_4.Find("id_retira_qtde_pendente_meta = 'S'", 1, Tab_1.TabPage_2.dw_4.RowCount())
	
	If ll_Find > 0 Then
		Tab_1.TabPage_2.dw_4.Object.Legenda_t.Visible = True
	Else
		Tab_1.TabPage_2.dw_4.Object.Legenda_t.Visible = False
	End If
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produtos do pedido n$$HEX1$$e300$$ENDHEX$$o localizados.", Information!)
	End If
		This.ivm_Menu.mf_SalvarComo(False)
End If

ivm_Menu.mf_Classificar(lvb_Classificar)
ivm_Menu.mf_Filtrar(lvb_Filtrar)
ivm_Menu.mf_Localizar(lvb_Localizar)
ivm_Menu.mf_Imprimir(lvb_Imprimir)

Return pl_Linhas
end event

event constructor;call super::constructor;//This.of_SetRowSelection()

This.of_SetRowSelection("if (id_retira_qtde_pendente_meta = ~"S~", rgb(255, 0, 0), rgb(255, 255, 255))","")
end event

event ue_recuperar;// Override

Long lvl_Linha, &
     lvl_Pedido

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

If lvl_Linha = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um pedido para visualizar os produtos.", StopSign!)
	Return -1
End If

lvl_Pedido = Tab_1.TabPage_1.dw_2.Object.Nr_Pedido[lvl_Linha]

Return This.Retrieve(lvl_Pedido)
end event

event ue_saveas;// OverRide

String lvs_Arquivo, &
       lvs_Diretorio

Integer lvi_Retorno

Long lvl_Pedido

Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Pedido = Tab_1.TabPage_1.dw_2.Object.nr_pedido[Tab_1.TabPage_1.dw_2.GetRow()]

// Verifica o nome do arquivo
If Trim(This.ivs_Arquivo_SalvarComo) = "" or IsNull(This.ivs_Arquivo_SalvarComo) Then
	lvi_Retorno = GetFileSaveName("Selecione o caminho do arquivo", &
											lvs_Diretorio, &
											lvs_Arquivo, &
											"XLS", "Arquivos do Excel (*.XLS),*.XLS,")
	
	If lvi_Retorno = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro durante a chamada da janela de sele$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
		Return 
	Else
		If lvi_Retorno = 0 Then Return
	End If
Else
	lvs_Diretorio = This.ivs_Arquivo_SalvarComo
End If

lvs_Diretorio = Upper(lvs_Diretorio)

// Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
If FileExists(lvs_Diretorio) Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja substituir o arquivo '" + lvs_Diretorio + "' existente ?", Question!, YesNo!, 1) =  1 Then 
		If Not FileDelete(lvs_Diretorio) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + lvs_Diretorio + "'.", StopSign!)
			Return
		End If
	Else
		Return 
   End If   
End If

dc_uo_ds_base ds_lista

ds_Lista = Create dc_uo_ds_base

If Not ds_Lista.of_ChangeDataObject("ds_ge147_lista_produto_excel") Then
	Destroy(ds_Lista)
	Return 
End If

If ds_Lista.Retrieve(lvl_Pedido) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es para gerar a planilha excel.")
	Destroy(ds_Lista)
	Return 
End If

If ds_Lista.RowCount() > 0 Then
	
	// Salva o arquivo
	lvi_Retorno = ds_Lista.SaveAs(lvs_Diretorio, Excel!, True)
		
	If lvi_Retorno <> 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao salvar o arquivo '" + lvs_Diretorio + "'.", StopSign!)	
		Return 
	Else
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo '" + lvs_Diretorio + "' salvo com sucesso.", Information!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.")
End If
end event

event buttonclicked;call super::buttonclicked;String 	ls_Produto, &
			ls_Fornecedor, &
			ls_nr_pedido_sap

Long	ll_Pedido,&
		ll_Produto,&
		ll_Qt_Pedida,&
		lvl_linha_dw_3


lvl_linha_dw_3	= Tab_1.TabPage_1.dw_3.GetRow()

if lvl_linha_dw_3 > 0 then
	ls_nr_pedido_sap	= Tab_1.TabPage_1.dw_3.Object.nr_pedido_sap[lvl_linha_dw_3]
	
	if Not IsNull(ls_nr_pedido_sap) and Trim(ls_nr_pedido_sap) <> '' then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Este pedido foi criado dentro do SAP e n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel alterar a mensagem de log$$HEX1$$ed00$$ENDHEX$$stica por esta tela. Consulte respons$$HEX1$$e100$$ENDHEX$$vel.", StopSign!)
		Return -1
	end if
end if

Tab_1.TabPage_1.dw_2.AcceptText()
Tab_1.TabPage_2.dw_4.AcceptText()

ll_Produto		= Tab_1.TabPage_2.dw_4.Object.cd_produto		[Tab_1.TabPage_2.dw_4.GetRow()]
ls_Fornecedor	= Tab_1.TabPage_1.dw_2.Object.Cd_Fornecedor	[Tab_1.TabPage_1.dw_2.GetRow()]
ll_Pedido 		= Tab_1.TabPage_1.dw_2.Object.nr_pedido[Tab_1.TabPage_1.dw_2.GetRow()]

If Not wf_Verifica_Nf_Compra_Pendente_Produto(ls_Fornecedor, ll_Produto, ll_Pedido) Then
	Return -1
End If

If IsNull(is_responsavel) Then
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE147_MENSAGEM_LOGISTICA_PRODUTO", ref is_responsavel) Then
		//Close(This)
		Return
	End If
End If
	
ls_Produto	= Tab_1.TabPage_2.dw_4.Object.de_produto[Tab_1.TabPage_2.dw_4.GetRow()]+" : "+Tab_1.TabPage_2.dw_4.Object.de_apresentacao_estoque[Tab_1.TabPage_2.dw_4.GetRow()]
ll_Qt_Pedida	= Tab_1.TabPage_2.dw_4.Object.qt_pedida[Tab_1.TabPage_2.dw_4.GetRow()]

//ls_Parametro = 	Right("0000000000"	+String(ll_Pedido), 		10)+&
//						Right('0000000000'	+String(ll_Produto), 		10)+&
//						Right('0000000000'	+String(ll_Qt_Pedida), 	10)+&
//						Right('0000000000'	+String(is_responsavel),	10)+&
//						'00' + &
//						ls_Produto

st_parametros_msg_logistica_prd str
	
str.Nr_Pedido 		= ll_Pedido
str.Cd_Produto 		= ll_Produto
str.Qt_Pedida 		= ll_Qt_Pedida
str.Nr_Matricula 	= is_Responsavel
str.Cd_Mensagem 	= 0
str.De_Produto 		= ls_Produto
												
OpenWithParm(w_ge147_mensagem_logistica_produto, str)
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4133
integer height = 2064
long backcolor = 67108864
string text = "Mensagem Log$$HEX1$$ed00$$ENDHEX$$stica"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
gb_5 gb_5
gb_6 gb_6
dw_6 dw_6
dw_5 dw_5
end type

on tabpage_3.create
this.gb_5=create gb_5
this.gb_6=create gb_6
this.dw_6=create dw_6
this.dw_5=create dw_5
this.Control[]={this.gb_5,&
this.gb_6,&
this.dw_6,&
this.dw_5}
end on

on tabpage_3.destroy
destroy(this.gb_5)
destroy(this.gb_6)
destroy(this.dw_6)
destroy(this.dw_5)
end on

type gb_5 from groupbox within tabpage_3
integer x = 9
integer y = 12
integer width = 4105
integer height = 1428
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Lista de Mensagem da Log$$HEX1$$ed00$$ENDHEX$$stica por Produto"
borderstyle borderstyle = styleraised!
end type

type gb_6 from groupbox within tabpage_3
integer x = 9
integer y = 1464
integer width = 4105
integer height = 592
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Mensagem Log$$HEX1$$ed00$$ENDHEX$$stica Pedido"
end type

type dw_6 from dc_uo_dw_base within tabpage_3
integer x = 32
integer y = 1516
integer width = 4032
integer height = 512
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge147_lista_mensagem_logistica"
boolean vscrollbar = true
end type

event ue_recuperar;// Override

Long 	ll_Linha, &
     	ll_Pedido

ll_Linha = Tab_1.TabPage_1.dw_2.GetRow()

If ll_Linha = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um pedido para visualizar as mensagens da log$$HEX1$$ed00$$ENDHEX$$stica.", StopSign!)
	Return -1
End If

ll_Pedido = Tab_1.TabPage_1.dw_2.Object.Nr_Pedido[ll_Linha]

Return This.Retrieve(ll_Pedido)
end event

event doubleclicked;call super::doubleclicked;Long	ll_Pedido,&
		ll_Row,&
		lvl_linha_dw_3
		
String ls_nr_pedido_sap


lvl_linha_dw_3	= Tab_1.TabPage_1.dw_3.GetRow()

if lvl_linha_dw_3 > 0 then
	ls_nr_pedido_sap	= Tab_1.TabPage_1.dw_3.Object.nr_pedido_sap[lvl_linha_dw_3]
	
	if Not IsNull(ls_nr_pedido_sap) and Trim(ls_nr_pedido_sap) <> '' then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Este pedido foi criado dentro do SAP e n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel alterar a mensagem de log$$HEX1$$ed00$$ENDHEX$$stica por esta tela. Consulte respons$$HEX1$$e100$$ENDHEX$$vel.", StopSign!)
		Return -1
	end if
end if

ll_Row = This.GetRow()

If ll_Row > 0 Then
	
	ll_Pedido = This.Object.nr_pedido[ll_Row]
	
	OpenWithParm(w_ge147_mensagem_logistica, ll_Pedido)
End If

This.Event ue_Recuperar()
end event

type dw_5 from dc_uo_dw_base within tabpage_3
integer x = 41
integer y = 72
integer width = 4032
integer height = 1344
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge147_lista_mensagem_logistica_produto"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;// Override

Long 	ll_Linha, &
     	ll_Pedido

ll_Linha = Tab_1.TabPage_1.dw_2.GetRow()

If ll_Linha = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um pedido para visualizar as mensagens da log$$HEX1$$ed00$$ENDHEX$$stica.", StopSign!)
	Return -1
End If

ll_Pedido = Tab_1.TabPage_1.dw_2.Object.Nr_Pedido[ll_Linha]

Return This.Retrieve(ll_Pedido)
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event doubleclicked;call super::doubleclicked;DateTime ldh_Exclusao

Long ll_Row,&
		ll_Pedido,&
		ll_Produto,&
		ll_Qt_Pedida, &
		ll_Mensagem, &
		ll_Sequencial, &
		ll_Filial
		
String 	ls_Produto,&
			ls_Erro, &
			ls_Fornecedor
			
This.AcceptText()
			
ll_Row = This.GetRow()

If ll_Row > 0 Then
			
	ldh_Exclusao 	= This.Object.Dh_Exclusao[ll_Row]
	ll_Mensagem		= This.Object.Cd_Mensagem[ll_Row]
	ll_Pedido		= This.Object.nr_Pedido[ll_Row]
	ll_Produto		= This.Object.cd_produto[ll_Row]
	ls_Produto		= This.Object.de_produto[ll_Row]
	ls_Fornecedor	= Tab_1.TabPage_1.dw_2.Object.Cd_Fornecedor[Tab_1.TabPage_1.dw_2.GetRow()]
	ll_Sequencial	= This.Object.Nr_Sequencial[ll_Row]
	ll_Filial		= This.Object.Cd_Filial_Envio[ll_Row]
	
	If Not wf_Verifica_Nf_Compra_Pendente_Produto(ls_Fornecedor, ll_Produto, ll_Pedido) Then
		Return -1
	End If
	
	If Not IsNull(ldh_Exclusao) Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Este c$$HEX1$$f300$$ENDHEX$$digo de mensagem j$$HEX1$$e100$$ENDHEX$$ foi exclu$$HEX1$$ed00$$ENDHEX$$do. Deseja ativ$$HEX1$$e100$$ENDHEX$$-lo novamente?", Question!, YesNo!, 1) = 2 Then
			Return 1
		Else
			
			Update pedido_central_prd_msg_logist
			Set 	dh_exclusao = null,
					nr_matricula_exclusao = null
			Where nr_pedido 			= :ll_Pedido
				 And cd_produto 		= :ll_Produto
				 And cd_mensagem	= :ll_Mensagem
				 And nr_sequencial	= :ll_Sequencial
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SqlErrText
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao ativar mensagem." + ls_Erro, StopSign!)
				Return 1
			Else 
				SqlCa.of_Commit();
			End If
			
			This.Event ue_Recuperar()
		End If
	End If
				
	If IsNull(is_responsavel) Then
		If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE147_MENSAGEM_LOGISTICA_PRODUTO", ref is_responsavel) Then
			//Close(This)
			Return
		End If
	End If
	
	//Localiza a qtde pedida
	select qt_pedida
	Into :ll_Qt_Pedida
	from pedido_central_produto   
	where nr_pedido = :ll_Pedido
	  and cd_produto = :ll_Produto
	Using SqlCa;  
	
	Choose Case SqlCa.SqlCode
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado a quantidade pedida do produto.")
			Return 1
		Case -1
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da quantidade pedida.'")
			Return 1
	End Choose
	
	st_parametros_msg_logistica_prd str
	
	str.Nr_Pedido 		= ll_Pedido
	str.Cd_Produto 	= ll_Produto
	str.Qt_Pedida 		= ll_Qt_Pedida
	str.Nr_Matricula 	= is_Responsavel
	str.Cd_Mensagem 	= ll_Mensagem
	str.De_Produto 	= ls_Produto
	str.Nr_Sequencial	= ll_Sequencial
	str.Cd_Filial		= ll_Filial

	OpenWithParm(w_ge147_mensagem_logistica_produto, str)

	This.Event ue_Recuperar()
	
	This.SetRow(ll_Row)
End If
end event

