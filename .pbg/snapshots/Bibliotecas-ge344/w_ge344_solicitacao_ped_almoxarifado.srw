HA$PBExportHeader$w_ge344_solicitacao_ped_almoxarifado.srw
forward
global type w_ge344_solicitacao_ped_almoxarifado from dc_w_2tab_consulta_selecao_lista_det
end type
type gb_4 from groupbox within tabpage_1
end type
type cb_cancela from commandbutton within tabpage_1
end type
type cb_inserir_almoxarifado from commandbutton within tabpage_1
end type
type dw_4 from dc_uo_dw_base within tabpage_1
end type
type cb_cancel_produt_massa from commandbutton within tabpage_1
end type
type cb_inserir_encarte from commandbutton within tabpage_1
end type
type cb_cancel_produt_solicitacao from commandbutton within tabpage_2
end type
end forward

global type w_ge344_solicitacao_ped_almoxarifado from dc_w_2tab_consulta_selecao_lista_det
integer width = 3735
integer height = 2996
string title = "GE344 - Solicita$$HEX2$$e700e300$$ENDHEX$$o de Pedido do Almoxarifado"
end type
global w_ge344_solicitacao_ped_almoxarifado w_ge344_solicitacao_ped_almoxarifado

type variables
uo_filial	io_Filial	//ge009
uo_produto	io_Produto	//ge001

dc_uo_dw_base dw_1, dw_2, dw_3, dw_4

Boolean	ib_Check_sol, ib_Check_prd
end variables

forward prototypes
public subroutine wf_set_somente_consulta ()
public function boolean wf_prepara_exclusao_produto ()
public function boolean wf_verifica_situacao_solicitacao (ref string as_situacao)
public function boolean wf_verifica_inicio_geracao_pedido_cd (ref boolean ab_comecou, ref date adt_hoje)
public function boolean wf_exclui_produto_massa (long al_solicitacao, long al_filial, long al_produto, decimal al_valor)
end prototypes

public subroutine wf_set_somente_consulta ();dw_4.of_Set_Somente_Leitura(False)
end subroutine

public function boolean wf_prepara_exclusao_produto ();//DECLARA$$HEX2$$c700d500$$ENDHEX$$ES
Boolean	lb_Sucesso
Boolean	lb_Comecou_Geracao

Date		ldt_Hoje

String	ls_Operador

//PROCEDIMENTOS
lb_Sucesso = False

If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Deseja continuar com o cancelamento do(s) produto(s) selecionado(s)?', Question!, YesNo!, 2) = 1 Then
	If gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento('W_GE344_CANCELA_PRODUTO_DA_SOLICITACAO', ref ls_Operador) Then 
		If wf_verifica_inicio_geracao_pedido_cd (Ref lb_Comecou_Geracao, Ref ldt_Hoje) then
			If lb_Comecou_Geracao then
				If dw_2.Object.dh_pedido [dw_2.GetRow ()] > ldt_Hoje then
					lb_Sucesso = True
				else
					MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A gera$$HEX2$$e700e300$$ENDHEX$$o de pedidos de hoje j$$HEX1$$e100$$ENDHEX$$ come$$HEX1$$e700$$ENDHEX$$ou e esta solicita$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode mais ser alterada!', Exclamation!)
				End if
			else
				lb_Sucesso = True
			End if
		End if
	End If
End If

Return lb_Sucesso
end function

public function boolean wf_verifica_situacao_solicitacao (ref string as_situacao);//O campo de situa$$HEX2$$e700e300$$ENDHEX$$o do pedido j$$HEX1$$e100$$ENDHEX$$ existe na dw_2, por$$HEX1$$e900$$ENDHEX$$m foi criada esta consulta para verificar se houve uma altera$$HEX2$$e700e300$$ENDHEX$$o na situa$$HEX2$$e700e300$$ENDHEX$$o no meio do caminho

Long	ll_Filial
Long	ll_Solicitacao

dw_2.AcceptText()

ll_Filial	   = dw_2.Object.Cd_Filial      [dw_2.GetRow ()]
ll_Solicitacao	= dw_2.Object.Nr_solicitacao [dw_2.GetRow ()]

SELECT id_situacao
  INTO :as_situacao
  FROM pedido_solicitacao
 WHERE nr_solicitacao = :ll_Solicitacao
	AND cd_filial      = :ll_Filial
 USING SQLCA;

If SQLCA.SQLCode = -1 then
	SQLCA.of_MsgdbError ('Erro ao consultar a situa$$HEX2$$e700e300$$ENDHEX$$o da solicita$$HEX2$$e700e300$$ENDHEX$$o')
	Return False
End if

Return True
end function

public function boolean wf_verifica_inicio_geracao_pedido_cd (ref boolean ab_comecou, ref date adt_hoje);Boolean	lb_sucesso
Datetime	ldh_inicio_geracao

lb_sucesso = True
adt_hoje   = Date (gf_GetServerDate ())

SELECT dh_inicio_geracao
  INTO :ldh_inicio_geracao
  FROM controle_geracao_pedido
 WHERE id_multitask_logistica = 'S'
	AND dh_pedido              = :adt_hoje
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		SQLCA.of_msgdberror ('Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do in$$HEX1$$ed00$$ENDHEX$$cio do processo de gera$$HEX2$$e700e300$$ENDHEX$$o de pedido do CD.~n~rProcessamento cancelado!')
		lb_sucesso = False
	case 0
		//A gera$$HEX2$$e700e300$$ENDHEX$$o de pedidos j$$HEX1$$e100$$ENDHEX$$ come$$HEX1$$e700$$ENDHEX$$ou
		ab_comecou = True
//		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
//						'A gera$$HEX2$$e700e300$$ENDHEX$$o de pedido do CD j$$HEX1$$e100$$ENDHEX$$ come$$HEX1$$e700$$ENDHEX$$ou. A exclus$$HEX1$$e300$$ENDHEX$$o de produto n$$HEX1$$e300$$ENDHEX$$o pode ser feita neste momento.', &
//						Exclamation!)
	case 100
		ab_comecou = False
End choose

Return lb_sucesso
end function

public function boolean wf_exclui_produto_massa (long al_solicitacao, long al_filial, long al_produto, decimal al_valor);Boolean	lb_cancelar_solic
DateTime	ldh_HojeAgora
Decimal	ldc_custo_orig, &
			ldc_custo_total
Long		ll_qtd
String	ls_Nulo, &
			ls_Log

SetNull (ls_Nulo)

DELETE pedido_solicitacao_produto
 WHERE nr_solicitacao = :al_solicitacao
   AND cd_filial      = :al_filial
	AND cd_produto     = :al_produto
 USING SQLCA;

If SQLCA.SQLCode < 0 then
	SQLCA.of_RollBack ()
	SQLCA.of_MsgDBError ('Erro ao excluir o produto ' + String (al_produto) + ' da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + String (al_solicitacao) + ' da filial ' + String (al_filial))
	Return False
End if

SELECT COUNT (*)
  INTO :ll_qtd
  FROM pedido_solicitacao_produto
 WHERE nr_solicitacao = :al_solicitacao
   AND cd_filial      = :al_filial
 USING SQLCA;

If SQLCA.SQLCode < 0 then
	SQLCA.of_RollBack ()
	SQLCA.of_MsgDBError ('Erro ao verificar se h$$HEX1$$e100$$ENDHEX$$ mais produtos na solicita$$HEX2$$e700e300$$ENDHEX$$o ' + String (al_solicitacao) + ' da filial ' + String (al_filial))
	Return False
End if

SELECT vl_custo_total
  INTO :ldc_custo_orig
  FROM pedido_solicitacao
 WHERE nr_solicitacao = :al_solicitacao
	AND cd_filial      = :al_filial
 USING SQLCA;

If SQLCA.SQLCode < 0 then
	SQLCA.of_RollBack ()
	SQLCA.of_MsgDBError ('Erro ao verificar o custo total da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + String (al_solicitacao) + ' da filial ' + String (al_filial))
	Return False
End if

If ll_qtd > 0 then
	
	ldc_custo_total = ldc_custo_orig - al_valor
	
	If ldc_custo_total <= 0 then
		ldc_custo_total = 0
	End if
	
	lb_cancelar_solic = False
else
	ldc_custo_total   = 0
	lb_cancelar_solic = True
End if

If lb_cancelar_solic then
	ldh_HojeAgora = gf_GetServerDate ()
	
	UPDATE pedido_solicitacao
		SET id_situacao               = 'X'
		  , vl_custo_total            = :ldc_custo_total
		  , dh_cancelamento           = :ldh_HojeAgora
		  , nr_matricula_cancelamento = :gvo_aplicacao.ivo_seguranca.nr_matricula
	 WHERE nr_solicitacao = :al_solicitacao
		AND cd_filial      = :al_filial
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		SQLCA.of_RollBack ()
		SQLCA.of_MsgDBError ('Erro ao cancelar a solicita$$HEX2$$e700e300$$ENDHEX$$o ' + String (al_solicitacao) + ' da filial ' + String (al_filial))
		Return False
	End if
	
	If Not gf_Grava_Historico_Alteracao_Tabela ('PEDIDO_SOLICITACAO', String (al_solicitacao) + '@#!' + String (al_filial), 'ID_SITUACAO', 'A', 'X', &
															  gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', ref ls_Log, True) then
		Return False
	End if
	If Not gf_Grava_Historico_Alteracao_Tabela ('PEDIDO_SOLICITACAO', String (al_solicitacao) + '@#!' + String (al_filial), 'DH_CANCELAMENTO', ls_nulo, String (ldh_HojeAgora, 'DD/MM/YYYY HH:MM:SS'), &
															  gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', ref ls_Log, True) then
		Return False
	End if
	If Not gf_Grava_Historico_Alteracao_Tabela ('PEDIDO_SOLICITACAO', String (al_solicitacao) + '@#!' + String (al_filial), 'NR_MATRICULA_CANCELAMENTO', ls_nulo, gvo_aplicacao.ivo_seguranca.nr_matricula, &
															  gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', ref ls_Log, True) then
		Return False
	End if
	
else
	UPDATE pedido_solicitacao
		SET vl_custo_total = :ldc_custo_total
	 WHERE nr_solicitacao = :al_solicitacao
		AND cd_filial      = :al_filial
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		SQLCA.of_RollBack ()
		SQLCA.of_MsgDBError ('Erro ao atualizar a solicita$$HEX2$$e700e300$$ENDHEX$$o ' + String (al_solicitacao) + ' da filial ' + String (al_filial))
		Return False
	End if
	
End if

If Not gf_Grava_Historico_Alteracao_Tabela ('PEDIDO_SOLICITACAO', String (al_solicitacao) + '@#!' + String (al_filial), 'VL_CUSTO_TOTAL', String (ldc_custo_orig), String (ldc_custo_total), &
														  gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', ref ls_Log, True) then
	Return False
End if

If Not gf_Grava_Historico_Alteracao_Tabela ('PEDIDO_SOLICITACAO_PRODUTO', String (al_solicitacao) + '@#!' + String (al_filial) + '@#!' + String (al_produto), 'CD_PRODUTO', String (al_produto), ls_Nulo, &
														  gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'E', ref ls_Log, True) then
	Return False
End if

Return True
end function

on w_ge344_solicitacao_ped_almoxarifado.create
int iCurrent
call super::create
end on

on w_ge344_solicitacao_ped_almoxarifado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;io_Filial		= Create uo_filial
io_Produto	= Create uo_produto

dw_1 = Tab_1.TabPage_1.dw_1
dw_2 = Tab_1.TabPage_1.dw_2
dw_3 = Tab_1.TabPage_2.dw_3
dw_4 = Tab_1.TabPage_1.dw_4
end event

event close;call super::close;Destroy(io_Filial)
Destroy(io_Produto)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.Dh_Inicio	[1] = gvo_Parametro.of_Dh_Movimentacao()
dw_1.Object.Dh_Termino	[1] = dw_1.Object.Dh_Inicio[1]
end event

event ue_cancel;call super::ue_cancel;ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)
ivb_Valida_Salva = False
dw_3.Event ue_Cancel()
end event

event ue_save;call super::ue_save;//DECLARA$$HEX2$$c700d500$$ENDHEX$$ES
Boolean lb_Sucesso = True

Long ll_Linha
Long ll_Linhas
Long ll_Qt_Pedida
Long ll_Solicitacao
Long ll_Filial
Long ll_Produto
Long ll_Find

String ls_ValorPara
String ls_Situacao

//PROCEDIMENTOS
dw_2.AcceptText()
dw_3.AcceptText()

If Not wf_Verifica_Situacao_Solicitacao (Ref ls_Situacao) Then Return -1

If ls_Situacao <> 'A' then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Somente solicita$$HEX2$$e700e300$$ENDHEX$$o com situa$$HEX2$$e700e300$$ENDHEX$$o 'ATIVA' poder$$HEX1$$e100$$ENDHEX$$ ser alterada.")
	Return -1
End if

ll_Linhas = dw_3.RowCount ()
ll_Find   = dw_3.Find('qt_pedida = 0 or isnull(qt_pedida)', 1, ll_Linhas)

If ll_Find > 0 Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe a quantidade pedida do produto.', Exclamation!)
	dw_3.Event ue_Pos(ll_Find, 'qt_pedida')
	Return -1
End If

For ll_Linha = 1 To ll_Linhas
	
	If gf_Houve_Alteracao_Dw(dw_3, 'QT_PEDIDA', ll_Linha, Ref ls_ValorPara) Then
		
		ll_Qt_Pedida	= Long(ls_ValorPara)
		ll_Filial		= dw_2.Object.Cd_Filial		[dw_2.GetRow()]
		ll_Solicitacao		= dw_2.Object.Nr_Pedido	[dw_2.GetRow()]
		ll_Produto	= dw_3.Object.Cd_Produto	[ll_Linha]
		
		Update pedido_almoxarifado_produto
			Set qt_pedida = :ll_Qt_Pedida
		Where cd_filial = :ll_Filial
			And nr_pedido = :ll_Solicitacao
			And cd_produto = :ll_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack();
			SqlCa.of_MsgdbError('Erro ao gravar altera$$HEX2$$e700e300$$ENDHEX$$on na quantidade pedida.' + SqlCa.SqlErrText)
			lb_Sucesso = False
			Exit
		End If
	End If
Next

If lb_Sucesso Then
	SqlCa.of_Commit();
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Altera$$HEX2$$e700e300$$ENDHEX$$o gravada com sucesso.')
	
	ivm_Menu.mf_Confirmar(False)
	ivm_Menu.mf_Cancelar(False)
	ivb_Valida_Salva = False
	
	dw_2.Event ue_Recuperar()
End If

Return AncestorReturnValue
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge344_solicitacao_ped_almoxarifado
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge344_solicitacao_ped_almoxarifado
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge344_solicitacao_ped_almoxarifado
integer width = 3671
integer height = 2792
end type

event tab_1::selectionchanging;Long	ll_Linha

SetPointer(HourGlass!)

If NewIndex = 1 Then
	If ivb_Valida_Salva Then		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem informa$$HEX2$$e700f500$$ENDHEX$$es que ainda n$$HEX1$$e300$$ENDHEX$$o foram salvas. ~r~r" + &
										 "Deseja sair dessa aba sem salv$$HEX1$$e100$$ENDHEX$$-las ?", Question!, YesNo!, 2) = 1 Then
										 
			Parent.Event ue_Cancel()
		Else			
			Return 1
		End If	
	End If
	If OldIndex = 2 then
		ll_Linha = dw_2.GetRow()
		dw_2.Event ue_Recuperar ()
		dw_2.ScrollToRow (ll_Linha)
	End if
	
	ib_Check_sol = False
	
End If

If NewIndex = 2 Then
	If dw_2.GetRow() > 0 Then
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
		// das DW's de detalhes
		dw_3.Event ue_Retrieve()
		
		dw_2.AcceptText()

		If dw_2.Object.Id_Situacao [dw_2.GetRow ()] = 'A' then
//			dw_3.SetTabOrder ('qt_pedida', 1)
			Tab_1.TabPage_2.cb_cancel_produt_solicitacao.Enabled = True
		Else
//			dw_3.SetTabOrder ('qt_pedida', 0)
			//N$$HEX1$$e300$$ENDHEX$$o permite o cancelamento de produtos
			Tab_1.TabPage_2.cb_cancel_produt_solicitacao.Enabled = False
		End if
		
		ib_Check_prd = False
		
		// Permite a troca do folder
		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If		

SetPointer (Arrow!)
end event

event tab_1::selectionchanged;// OverRide

SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1			
		Tab_1.TabPage_1.dw_2.SetFocus()
		
	Case 2		
		Tab_1.TabPage_2.dw_3.SetFocus()
End Choose

SetPointer(Arrow!)
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 3634
integer height = 2676
gb_4 gb_4
cb_cancela cb_cancela
cb_inserir_almoxarifado cb_inserir_almoxarifado
dw_4 dw_4
cb_cancel_produt_massa cb_cancel_produt_massa
cb_inserir_encarte cb_inserir_encarte
end type

on tabpage_1.create
this.gb_4=create gb_4
this.cb_cancela=create cb_cancela
this.cb_inserir_almoxarifado=create cb_inserir_almoxarifado
this.dw_4=create dw_4
this.cb_cancel_produt_massa=create cb_cancel_produt_massa
this.cb_inserir_encarte=create cb_inserir_encarte
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.cb_cancela
this.Control[iCurrent+3]=this.cb_inserir_almoxarifado
this.Control[iCurrent+4]=this.dw_4
this.Control[iCurrent+5]=this.cb_cancel_produt_massa
this.Control[iCurrent+6]=this.cb_inserir_encarte
end on

on tabpage_1.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.cb_cancela)
destroy(this.cb_inserir_almoxarifado)
destroy(this.dw_4)
destroy(this.cb_cancel_produt_massa)
destroy(this.cb_inserir_encarte)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 456
integer width = 3561
integer height = 1616
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 2121
integer height = 420
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer y = 88
integer width = 2057
integer height = 324
string dataobject = "dw_ge344_selecao_solicitacao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_fantasia" Then
		io_Filial.of_Localiza_Filial(This.GetText())
		
		If Not io_Filial.Localizada Then
			io_Filial.of_Inicializa()
		End If
		
		This.Object.Cd_Filial		[1]	= io_Filial.Cd_Filial
		This.Object.Nm_Fantasia	[1]	= io_Filial.Nm_Fantasia
	End If
End If

If Key = KeyEnter! Then
	If This.GetColumnName() = "de_produto" Then
		io_Produto.of_Localiza_Produto(This.GetText())
		
		If Not io_Produto.Localizado Then
			io_Produto.of_Inicializa()
		End If
		
		This.Object.Cd_Produto	[1]	= io_Produto.Cd_Produto
		This.Object.De_Produto	[1]	= io_Produto.ivs_Descricao_Apresentacao_Estoque
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
//Cb_Cancela.Enabled = False

If dwo.Name = "nm_fantasia" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
		This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
	End If
End If

If dwo.Name = "de_produto" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque Then
			Return 1
		End If
	Else
		io_Produto.of_Inicializa()
		
		This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
		This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()
//Cb_Cancela.Enabled = False

If dwo.Name = "nm_fantasia" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
		This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
	End If
End If

If dwo.Name = "de_produto" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque Then
			Return 1
		End If
	Else
		io_Produto.of_Inicializa()
		
		This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
		This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
	End If
End If
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer x = 64
integer y = 528
integer width = 3493
integer height = 1520
string dataobject = "dw_ge344_lista_solicitacao"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;//DECLARA$$HEX2$$c700d500$$ENDHEX$$ES
Date		ldt_Inicio
Date		ldt_Termino

Long		ll_Filial
Long		ll_Produto

String	ls_Situacao
String	ls_Tipo

//PROCEDIMENTOS
dw_1.AcceptText ()

ldt_Inicio  = dw_1.Object.Dh_Inicio      [1]
ldt_Termino = dw_1.Object.Dh_Termino     [1]
ll_Filial   = dw_1.Object.Cd_Filial      [1]
ll_Produto  = dw_1.Object.Cd_Produto     [1]
ls_Situacao = dw_1.Object.Id_Situacao    [1]
ls_Tipo     = dw_1.Object.Id_Tipo_Pedido [1]

If IsNull (ldt_Inicio) then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.', Exclamation!)
	dw_1.Event ue_Pos (1, 'dh_inicio')
	Return -1
End if

If IsNull (ldt_Termino) then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.', Exclamation!)
	dw_1.Event ue_Pos (1, 'dh_termino')
	Return -1
End if

If ldt_Inicio > ldt_Termino then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.', Exclamation!)
	dw_1.Event ue_Pos (1, 'dh_inicio')
	Return -1
End if

If Not IsNull (ll_Filial) and ll_Filial > 0 then
	This.of_AppendWhere ('ps.cd_filial = ' + String(ll_Filial))
End if

If Not IsNull (ll_Produto) and ll_Produto > 0 then
	This.of_AppendWhere ('EXISTS (SELECT 1' + &
								'          FROM pedido_solicitacao_produto psp'         + &
								'         WHERE psp.nr_solicitacao = ps.nr_solicitacao' + &
								'           AND psp.cd_filial      = ps.cd_filial'      + &
								'           AND psp.cd_produto     = ' + String (ll_Produto) + ')')
End if

//Se for diferente de TODOS
If ls_Situacao <> 'T' then
	This.of_AppendWhere ("ps.id_situacao = '" + ls_Situacao + "'")
End if

//Se for diferente de TODOS
If ls_Tipo <> 'T' then
	This.of_AppendWhere ("ps.id_tipo_pedido = '" + ls_Tipo + "'")
End if

Return 1
end event

event dw_2::ue_recuperar;//OverRide
dw_1.AcceptText ()

Return This.Retrieve (dw_1.Object.Dh_Inicio  [1], dw_1.Object.Dh_Termino [1])
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;dw_4.Event ue_Reset()

dw_2.AcceptText()

If dw_2.RowCount() > 0 Then
	dw_4.Event ue_AddRow()
	
	dw_4.Object.Dh_Inclusao                [1] = dw_2.Object.Dh_Inclusao                [CurrentRow]
	dw_4.Object.Nr_Matricula_Cadastramento [1] = dw_2.Object.Nr_Matricula_Cadastramento [CurrentRow]
	dw_4.Object.Nm_usuario_Cadastramento   [1] = dw_2.Object.Nm_usuario_Cadastramento   [CurrentRow]
	dw_4.Object.Dh_Cancelamento            [1] = dw_2.Object.Dh_Cancelamento            [CurrentRow]
	dw_4.Object.Nr_Matricula_Cancelamento  [1] = dw_2.Object.Nr_Matricula_Cancelamento  [CurrentRow]
	dw_4.Object.Nm_usuario_Cancelamento    [1] = dw_2.Object.Nm_usuario_Cancelamento    [CurrentRow]
	dw_4.Object.dh_processamento           [1] = dw_2.Object.dh_processamento           [CurrentRow]
	dw_4.Object.nr_pedido                  [1] = dw_2.Object.nr_pedido                  [CurrentRow]
	
	dw_2.SetFocus ()
End if
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

This.Event RowFocusChanged(1)

Return pl_Linhas
end event

event dw_2::itemchanged;call super::itemchanged;String ls_Situacao

If dwo.Name = 'id_cancela' Then
	If Data = 'S' Then
		If Not wf_Verifica_Situacao_Solicitacao (Ref ls_Situacao) Then Return 1
		
		If ls_Situacao <> 'A' Then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Somente solicita$$HEX2$$e700e300$$ENDHEX$$o com situa$$HEX2$$e700e300$$ENDHEX$$o 'ATIVA' pode ser cancelada.", Exclamation!)
			dw_2.SetFocus()
			Return 1
		End If
	End If
End If
end event

event dw_2::doubleclicked;call super::doubleclicked;Long		ll_Row
Long		ll_LInhas
String	ls_Marcacao

ll_LInhas = This.RowCount ()

If ll_LInhas > 0 then

	If dwo.Name = 'st_selecionado' then
		
		If ib_Check_sol then
			ls_Marcacao  = 'N'
			ib_Check_sol = False
		else
			ls_Marcacao = 'S'
			ib_Check_sol    = True
		End if
		
		For ll_Row = 1 to ll_LInhas
			If ls_Marcacao = 'S' then
				If This.Object.Id_Situacao [ll_Row] = 'A' then
					This.Object.id_cancela [ll_Row] = ls_Marcacao
				End if
			else
				This.Object.id_cancela [ll_Row] = ls_Marcacao
			End if
		Next
		
	End if
	
End if
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 3634
integer height = 2676
cb_cancel_produt_solicitacao cb_cancel_produt_solicitacao
end type

on tabpage_2.create
this.cb_cancel_produt_solicitacao=create cb_cancel_produt_solicitacao
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel_produt_solicitacao
end on

on tabpage_2.destroy
call super::destroy
destroy(this.cb_cancel_produt_solicitacao)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 3195
integer height = 2124
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer width = 3127
integer height = 2016
string dataobject = "dw_ge344_detalhes_solicitacao"
boolean vscrollbar = true
end type

event dw_3::ue_recuperar;//OverRide
Long	ll_linha

dw_2.AcceptText ()

ll_linha = dw_2.GetRow ()

Return This.Retrieve (dw_2.Object.nr_solicitacao [ll_linha], dw_2.Object.cd_filial [ll_linha])
end event

event dw_3::constructor;call super::constructor;This.of_SetRowSelection ()
This.ivb_Ordena_Colunas = True
end event

event dw_3::editchanged;call super::editchanged;//ivm_Menu.mf_Confirmar(True)
//ivm_Menu.mf_Cancelar(True)
//ivb_Valida_Salva = True
end event

event dw_3::itemchanged;call super::itemchanged;Choose case Lower (dwo.Name)
	case 'id_selecionado'
		If Data = 'S' then
			If dw_2.Object.Id_Situacao [dw_2.GetRow ()] <> 'A' then
				MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
								"Somente produtos de solicita$$HEX2$$e700f500$$ENDHEX$$es de pedido com situa$$HEX2$$e700e300$$ENDHEX$$o 'ATIVA' podem ser cancelados!", &
								Exclamation!)
				dw_3.SetFocus ()
				Return 1
			End if
		End if
End choose
end event

event dw_3::doubleclicked;call super::doubleclicked;Long		ll_Row
Long		ll_LInhas
String	ls_Marcacao

ll_LInhas = This.RowCount ()

If ll_LInhas > 0 then

	If dwo.Name = 'st_selecionado' then
		
		If ib_Check_prd then
			ls_Marcacao = 'N'
			ib_Check_prd    = False
		else
			If dw_2.Object.Id_Situacao [dw_2.GetRow ()] <> 'A' then
				MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
								"Somente produtos de solicita$$HEX2$$e700f500$$ENDHEX$$es de pedido com situa$$HEX2$$e700e300$$ENDHEX$$o 'ATIVA' podem ser cancelados!", &
								Exclamation!)
				Return
			End if
			
			ls_Marcacao = 'S'
			ib_Check_prd    = True
		End if
		
		For ll_Row = 1 to ll_LInhas
			This.Object.Id_Selecionado [ll_Row] = ls_Marcacao
		Next
		
	End if
	
End if
end event

type gb_4 from groupbox within tabpage_1
integer x = 23
integer y = 2220
integer width = 3191
integer height = 416
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

type cb_cancela from commandbutton within tabpage_1
integer x = 23
integer y = 2096
integer width = 585
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar Solicita$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;//DECLARA$$HEX2$$c700d500$$ENDHEX$$ES
Boolean	lb_Comecou_Geracao

Date		ldt_Hoje

Long		ll_Find
Long		ll_Filial
Long		ll_Solicitacao
Long		ll_Linhas

//PROCEDIMENTOS
ll_Linhas = dw_2.RowCount ()

If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Deseja continuar com o cancelamento?', Question!, YesNo!, 2) = 2 then
	Return -1
End if

If not wf_verifica_inicio_geracao_pedido_cd (Ref lb_Comecou_Geracao, Ref ldt_Hoje) then
	Return -1
End if

If lb_Comecou_Geracao then
	ll_Find = dw_2.Find ("id_cancela = 'S' and dh_pedido = Date ('" + String (ldt_Hoje, 'YYYY/MM/DD') + "')", 1, ll_Linhas)
	
	If ll_Find > 0 then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A gera$$HEX2$$e700e300$$ENDHEX$$o de pedidos j$$HEX1$$e100$$ENDHEX$$ come$$HEX1$$e700$$ENDHEX$$ou e as solicita$$HEX2$$e700f500$$ENDHEX$$es para o dia de hoje n$$HEX1$$e300$$ENDHEX$$o podem mais ser canceladas!', Exclamation!)
		dw_2.Event ue_pos (ll_Find, 'id_cancela')
		Return -1
	End if
End if

ll_Find = dw_2.Find ("id_cancela = 'S'", 1, ll_Linhas)

If ll_Find < 0 then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro no Find da solicita$$HEX2$$e700e300$$ENDHEX$$o a ser cancelada', StopSign!)
	dw_2.SetFocus ()
	Return -1
End if

If ll_Find = 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Nenhuma solicita$$HEX2$$e700e300$$ENDHEX$$o foi selecionada.', Exclamation!)
	dw_2.SetFocus()
	Return -1
End if

Do Until ll_Find = 0
	
	ll_Solicitacao	= dw_2.Object.nr_solicitacao [ll_Find]
	ll_Filial      = dw_2.Object.Cd_Filial      [ll_Find]
	
	UPDATE pedido_solicitacao
		SET id_situacao               = 'X'
		  , nr_matricula_cancelamento = :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
		  , dh_cancelamento           = GETDATE ()
	 WHERE nr_solicitacao = :ll_Solicitacao
		AND cd_filial      = :ll_Filial
	 USING SQLCA;
	
	If SQLCA.SQLCode = -1 then
		SQLCA.of_RollBack ()
		SQLCA.of_MsgdbError ('Erro ao cancelar a solicita$$HEX2$$e700e300$$ENDHEX$$o')
		Return -1
	End if
	
	If ll_Find = ll_Linhas then
		ll_Find = 0
	else
		ll_Find ++
		ll_Find = dw_2.Find ("id_cancela = 'S'", ll_Find, ll_Linhas)
	End if
	
Loop

SQLCA.of_Commit();

MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Solicita$$HEX2$$e700e300$$ENDHEX$$o($$HEX1$$f500$$ENDHEX$$es) cancelada(s) com sucesso.')

dw_2.Event ue_Recuperar()
end event

type cb_inserir_almoxarifado from commandbutton within tabpage_1
integer x = 1371
integer y = 2096
integer width = 891
integer height = 100
integer taborder = 42
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Inserir Solicita$$HEX2$$e700e300$$ENDHEX$$o Almoxarifado"
end type

event clicked;String ls_Retorno

OpenWithParm (w_ge344_grava_solicitacao_pedido, 'A')

ls_Retorno = Message.StringParm

If ls_Retorno = 'OK' then
	dw_2.Event ue_Recuperar ()
End if
end event

type dw_4 from dc_uo_dw_base within tabpage_1
integer x = 46
integer y = 2272
integer width = 3127
integer height = 356
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge344_dados_solicitacao"
end type

event ue_recuperar;//OverRide

Return 1
end event

type cb_cancel_produt_massa from commandbutton within tabpage_1
integer x = 631
integer y = 2096
integer width = 718
integer height = 100
integer taborder = 41
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar V$$HEX1$$e100$$ENDHEX$$rios Produtos"
end type

event clicked;//DECLARA$$HEX2$$c700d500$$ENDHEX$$ES
Any				la_dado
Boolean			lb_Sucesso, &
					lb_Comecou_Geracao
Date				ldt_Hoje
dc_uo_ds_base	lds_produtos
dc_uo_excel		lvo_Excel
Long				ll_tot_linhas_planilha, &
					ll_Linha_planilha, &
					ll_cd_produto, &
					ll_qtd_prod, &
					ll_linha, &
					ll_linhas
String			ls_Operador, &
					ls_Path,         &
					ls_Nome_Arquivo, &
					ls_produtos, &
					ls_chave, &
					ls_comando, &
					ls_Nulo, &
					ls_log, &
					ls_Msg

//PROCEDIMENTOS
lb_Sucesso = True

If not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento ('W_GE344_CANCELA_PRODUTO_EM_MASSA_SOL', ref ls_Operador) then Return

If not wf_verifica_inicio_geracao_pedido_cd (Ref lb_Comecou_Geracao, Ref ldt_Hoje) then Return

If lb_Comecou_Geracao then
	If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
						'A gera$$HEX2$$e700e300$$ENDHEX$$o de pedidos de hoje j$$HEX1$$e100$$ENDHEX$$ come$$HEX1$$e700$$ENDHEX$$ou!' + '~n~r' + &
						'Somente ser$$HEX1$$e300$$ENDHEX$$o cancelados produtos em solicita$$HEX2$$e700f500$$ENDHEX$$es agendadas para o futuro.' + '~n~r' + &
						'Deseja continuar?', &
						Question!, YesNo!, 2) = 2 then
		Return
	else
		ls_Msg = 'Todos os produtos listados na planilha ser$$HEX1$$e300$$ENDHEX$$o exclu$$HEX1$$ed00$$ENDHEX$$dos de todas as solicita$$HEX2$$e700f500$$ENDHEX$$es ATIVAS com data de gera$$HEX2$$e700e300$$ENDHEX$$o de pedido no FUTURO!'
	End if
else
	ls_Msg = 'Todos os produtos listados na planilha ser$$HEX1$$e300$$ENDHEX$$o exclu$$HEX1$$ed00$$ENDHEX$$dos de todas as solicita$$HEX2$$e700f500$$ENDHEX$$es em situa$$HEX2$$e700e300$$ENDHEX$$o ATIVA!'
End if

MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
				'A planilha deve estar no mesmo formato abaixo, com apenas uma coluna:~r~r' + &
				'Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto a ser exclu$$HEX1$$ed00$$ENDHEX$$do das solicita$$HEX2$$e700f500$$ENDHEX$$es' + '~n~n~r' + &
				'OBSERVA$$HEX2$$c700c300$$ENDHEX$$O:' + '~n~n~r' + &
				'Qualquer linha em branco indica o fim da planilha!')

If GetFileOpenName ('Selecione o arquivo', ls_Path, ls_Nome_Arquivo, 'XLS, XLSX', &
						+ 'Excel 2007 (*.XLSX), *.XLSX, Excel 97-2003 (*.XLS), *.XLS') <> 1 then
	Return
End if

If Messagebox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
					'Confirma a importa$$HEX2$$e700e300$$ENDHEX$$o da planilha ' + ls_Path + '?' + '~n~n~r' + ls_Msg, &
					Question!, YesNo!, 2) = 2 then
	Return
End if

lvo_Excel = Create dc_uo_excel

Try
	If (lvo_Excel.uo_Referencia_Objeto_Excel (ls_path)) then
	
		// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
		ll_tot_linhas_planilha = lvo_Excel.uo_Verifica_Tamanho_Arquivo ('A') 
		
		If ll_tot_linhas_planilha > 0 then
			For ll_Linha_planilha = 1 To ll_tot_linhas_planilha
				la_dado = lvo_Excel.uo_Lendo_Dados (ll_linha_planilha, 'A')
				
				If IsNull (la_dado) then
					Continue
				else
					If Not IsNumber (String (la_dado)) then
						Continue
					End if
				End if
				
				ll_cd_produto = Long (la_dado)
				io_Produto.of_Localiza_Produto (String (ll_cd_produto), False)
				
				If Not io_Produto.Localizado then
					MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
									'O produto informado na c$$HEX1$$e900$$ENDHEX$$lula A' + String (ll_linha_planilha) + &
									' n$$HEX1$$e300$$ENDHEX$$o foi localizado!~n~r' + &
									'Favor corrigir a planilha e importar novamente.', Stopsign!)
					lb_Sucesso = False
					Return
				End if
				
				ll_qtd_prod ++
				If ll_qtd_prod = 1 then
					ls_produtos = String (ll_cd_produto)
				else
					ls_produtos = ls_produtos + ', ' + String (ll_cd_produto)
				End if
			Next
		End if
	End if
Finally
	Destroy (lvo_Excel)
	
	If lb_sucesso then
		If ll_qtd_prod = 0 then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Nenhum produto listado na planilha.', Exclamation!)
		else
			lds_produtos = Create dc_uo_ds_base
			
			If not lds_produtos.of_ChangeDataObject ('ds_ge344_produtos_cancelar_solic') then Return
			
			lds_produtos.of_AppendWhere ('psp.cd_produto IN (' + ls_produtos + ')')
			
			If lb_Comecou_Geracao then
				lds_produtos.of_AppendWhere ("ps.dh_pedido > '" + String (ldt_Hoje, 'YYYY-MM-DD') + "'")
			End if
			
			ll_linhas = lds_produtos.Retrieve ()
			
			Choose case ll_linhas
				case is < 0
					SQLCA.of_msgdberror ('Erro na leitura dos produtos ' + ls_produtos + ' para cancelamento em massa.~n~rProcessamento cancelado!')
					
				case is > 0
					For ll_Linha = 1 to ll_Linhas
						If not wf_exclui_produto_massa  (lds_produtos.Object.nr_solicitacao [ll_Linha], &
																	lds_produtos.Object.cd_filial      [ll_Linha], &
																	lds_produtos.Object.cd_produto     [ll_Linha], &
																	lds_produtos.Object.vl_custo       [ll_Linha]) then
							Return
						End if
					Next
					SQLCA.of_commit ()
					MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
									'Cancelamento de ' + String (ll_qtd_prod) + ' produto(s) executado com sucesso')
				case 0
					MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Produto(s) ' + ls_produtos + ' n$$HEX1$$e300$$ENDHEX$$o encontrado(s) nas solicita$$HEX2$$e700f500$$ENDHEX$$es.~n~rProcessamento cancelado!')
					
			End choose
			
			Destroy lds_produtos
		End if
	End if
	
End Try
end event

type cb_inserir_encarte from commandbutton within tabpage_1
integer x = 2286
integer y = 2096
integer width = 1138
integer height = 100
integer taborder = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Inserir Solicita$$HEX2$$e700e300$$ENDHEX$$o Empurrado - ENCARTE"
end type

event clicked;String ls_Retorno

OpenWithParm (w_ge344_grava_solicitacao_pedido, 'E')

ls_Retorno = Message.StringParm

If ls_Retorno = 'OK' then
	dw_2.Event ue_Recuperar ()
End if
end event

type cb_cancel_produt_solicitacao from commandbutton within tabpage_2
integer x = 2295
integer y = 2172
integer width = 800
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar itens da solicita$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;Decimal	ldc_vl_item
Decimal	ldc_vl_total
Long		ll_Find
Long		ll_filial
Long		ll_produto
Long		ll_Solicitacao
Long		ll_qtd_prd
Long		ll_Linhas
String	ls_Chave
String	ls_Log
String	ls_Nulo
String	ls_Situacao
String	ls_Msg

ll_Linhas = dw_3.RowCount ()

//Primeiro verifica se foi selecionado algum produto, pois n$$HEX1$$e300$$ENDHEX$$o faz sentido prosseguir se nenhum foi selecionado.
ll_Find = dw_3.Find ("id_selecionado= 'S'", ll_Linhas, 1) //Pesquisa de tr$$HEX1$$e100$$ENDHEX$$s pra frente, para ir excluindo as linhas tratadas

If ll_Find < 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro no Find de produtos selecionados!', StopSign!)
	dw_3.SetFocus ()
	Return
End if

If ll_Find = 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Nenhum produto foi selecionado!', Exclamation!)
	dw_3.SetFocus ()
	Return
End if

If not wf_prepara_exclusao_produto () then Return

If Not wf_verifica_situacao_solicitacao (Ref ls_Situacao) then Return

If ls_Situacao <> 'A' then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
					"Somente produtos de solicita$$HEX2$$e700f500$$ENDHEX$$es de pedido com situa$$HEX2$$e700e300$$ENDHEX$$o 'ATIVA' podem ser cancelados!", &
					Exclamation!)
	Return
End if

SetNull (ls_Nulo)

ll_Solicitacao = dw_2.Object.nr_solicitacao [dw_2.GetRow ()]
ll_filial      = dw_2.Object.cd_filial      [dw_2.GetRow ()]

Do while ll_Find > 0
	ll_produto = dw_3.Object.cd_produto [ll_find]
	
	SELECT qt_pedida * vl_custo_unitario
	  INTO :ldc_vl_item
	  FROM pedido_solicitacao_produto 
	 WHERE nr_solicitacao = :ll_Solicitacao
		AND cd_filial      = :ll_filial
		AND cd_produto     = :ll_produto
	USING SQLCA;
	
	Choose case SQLCA.SQLCode
		case 0
			ldc_vl_total += ldc_vl_item
		case is < 0
			SQLCA.of_RollBack ()
			SQLCA.of_MsgDBError ('Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto ' + String (ll_produto) + '-' + dw_3.Object.de_produto [ll_find] + ' da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + String (ll_Solicitacao) + &
										' da filial ' + String (ll_filial) + '.~n~rProcessamento cancelado!')
			Return
		case 100
			SQLCA.of_RollBack ()
			SQLCA.of_msgdberror ('Produto ' + String (ll_produto) + '-' + dw_3.Object.de_produto [ll_find] + ' n$$HEX1$$e300$$ENDHEX$$o encontrado na solicita$$HEX2$$e700e300$$ENDHEX$$o ' + String (ll_Solicitacao) + &
										' da filial ' + String (ll_filial) + '.~n~rProcessamento cancelado!')
			Return
	End choose
	
	DELETE FROM pedido_solicitacao_produto 
	 WHERE nr_solicitacao = :ll_Solicitacao
		AND cd_filial      = :ll_filial
		AND cd_produto     = :ll_produto
	USING SQLCA;
	
	Choose case SQLCA.SQLCode
		case is < 0
			SQLCA.of_RollBack ()
			SQLCA.of_MsgDBError ('Erro no cancelamento do produto ' + String (ll_produto) + '-' + dw_3.Object.de_produto [ll_find] + ' da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + String (ll_Solicitacao) + &
										' da filial ' + String (ll_filial) + '.~n~rProcessamento cancelado!')
			Return
		case 0
			//Grava o hist$$HEX1$$f300$$ENDHEX$$rico
			ls_chave = String (ll_Solicitacao) + '@#!' + String (ll_filial) + '@#!' + String (ll_produto)
			If Not gf_Grava_Historico_Alteracao_Tabela ('PEDIDO_SOLICITACAO_PRODUTO', ls_Chave, 'CD_PRODUTO', String (ll_produto), ls_Nulo, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, &
																	  'E', ref ls_Log, True) then
				//Em caso de erro, a fun$$HEX2$$e700e300$$ENDHEX$$o acima j$$HEX1$$e100$$ENDHEX$$ faz o rollback
				Return
			End if
		case 100
			SQLCA.of_RollBack ()
			SQLCA.of_msgdberror ('Produto ' + String (ll_produto) + '-' + dw_3.Object.de_produto [ll_find] + ' n$$HEX1$$e300$$ENDHEX$$o encontrado na solicita$$HEX2$$e700e300$$ENDHEX$$o ' + String (ll_Solicitacao) + &
										' da filial ' + String (ll_filial) + '.~n~rProcessamento cancelado!')
			Return
	End choose
	
	ll_qtd_prd ++
	dw_3.DeleteRow (ll_Find)
	ll_Find --
	If ll_Find = 0 then
		Exit
	End if
	ll_Find = dw_3.Find ("id_selecionado= 'S'", ll_Find, 1) //Pesquisa de tr$$HEX1$$e100$$ENDHEX$$s pra frente, para ir excluindo as linhas tratadas
Loop

ls_Msg = String (ll_qtd_prd) + ' produto(s) cancelado(s) com sucesso!'

SELECT COUNT (*)
  INTO :ll_qtd_prd
  FROM pedido_solicitacao_produto
 WHERE nr_solicitacao = :ll_Solicitacao
 USING SQLCA;

If SQLCA.SQLCode < 0 then
	SQLCA.of_RollBack ()
	SQLCA.of_MsgDBError ('Erro ao verificar os produtos restantes na solicita$$HEX2$$e700e300$$ENDHEX$$o ' + String (ll_Solicitacao) + '.~n~rProcessamento cancelado!')
	Return
End if

If ll_qtd_prd = 0 then
	UPDATE pedido_solicitacao
		SET id_situacao               = 'X'
		  , dh_cancelamento           = GETDATE ()
		  , nr_matricula_cancelamento = :gvo_aplicacao.ivo_seguranca.nr_matricula
	 WHERE nr_solicitacao = :ll_Solicitacao
	 USING SQLCA;
	 
	If SQLCA.SQLCode < 0 then
		SQLCA.of_RollBack ()
		SQLCA.of_MsgDBError ('Erro ao cancelar a solicita$$HEX2$$e700e300$$ENDHEX$$o ' + String (ll_Solicitacao) + ' que ficou sem produtos.' + '~n~rProcessamento cancelado!')
		Return
	End if
	
	ls_Msg += '~n~rA solicita$$HEX2$$e700e300$$ENDHEX$$o ficou sem produtos e foi cancelada!'
else
	UPDATE pedido_solicitacao
		SET vl_custo_total = vl_custo_total - :ldc_vl_total
	 WHERE nr_solicitacao = :ll_Solicitacao
	 USING SQLCA;
	 
	If SQLCA.SQLCode < 0 then
		SQLCA.of_RollBack ()
		SQLCA.of_MsgDBError ('Erro ao atualizar o custo total da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + String (ll_Solicitacao) + ' ap$$HEX1$$f300$$ENDHEX$$s o cancelamento do(s) produto(s) selecionado(s).' + '~n~rProcessamento cancelado!')
		Return
	End if
End if

SqlCa.of_Commit ();

MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_Msg)

//dw_3.Event ue_retrieve ()
end event

