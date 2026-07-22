HA$PBExportHeader$w_ge344_manutencao_ped_almoxarifado.srw
forward
global type w_ge344_manutencao_ped_almoxarifado from dc_w_2tab_consulta_selecao_lista_det
end type
type gb_4 from groupbox within tabpage_1
end type
type cb_cancela from commandbutton within tabpage_1
end type
type cb_ped_emp from commandbutton within tabpage_1
end type
type cd_ped_inicial from commandbutton within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type dw_4 from dc_uo_dw_base within tabpage_1
end type
type cb_cancel_produt_massa from commandbutton within tabpage_1
end type
type cb_cancel_produt_pedido from commandbutton within tabpage_2
end type
end forward

global type w_ge344_manutencao_ped_almoxarifado from dc_w_2tab_consulta_selecao_lista_det
integer width = 3808
integer height = 3024
string title = "GE344 - Manuten$$HEX2$$e700e300$$ENDHEX$$o de Pedido do Almoxarifado"
end type
global w_ge344_manutencao_ped_almoxarifado w_ge344_manutencao_ped_almoxarifado

type variables
uo_filial		io_Filial		//ge009
uo_produto 	io_Produto	//ge001

dc_uo_dw_base dw_1, dw_2, dw_3, dw_4

Boolean	ib_Check
end variables

forward prototypes
public subroutine wf_set_somente_consulta ()
public function boolean wf_verifica_situacao_pedido (ref string as_situacao)
public function boolean wf_verifica_inicio_geracao_pedido_cd ()
public function boolean wf_prepara_exclusao_produto ()
end prototypes

public subroutine wf_set_somente_consulta ();dw_4.of_Set_Somente_Leitura(False)
end subroutine

public function boolean wf_verifica_situacao_pedido (ref string as_situacao);//O campo de situa$$HEX2$$e700e300$$ENDHEX$$o do pedido j$$HEX1$$e100$$ENDHEX$$ existe na dw_2, por$$HEX1$$e900$$ENDHEX$$m foi criada esta consulta para verificar se houve uma altera$$HEX2$$e700e300$$ENDHEX$$o na situa$$HEX2$$e700e300$$ENDHEX$$o no meio do caminho

Long ll_Filial
Long ll_Pedido

dw_2.AcceptText()

ll_Filial	= dw_2.Object.Cd_Filial		[dw_2.GetRow()]
ll_Pedido	= dw_2.Object.Nr_Pedido	[dw_2.GetRow()]

Select id_situacao
	Into :as_situacao
From pedido_almoxarifado
Where cd_filial = :ll_Filial
	And nr_pedido = :ll_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro ao consultar a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido.")
	Return False
End If

Return True
end function

public function boolean wf_verifica_inicio_geracao_pedido_cd ();Boolean	lb_sucesso
Date		ldt_hoje
Datetime	ldh_inicio_geracao

lb_sucesso = False
ldt_hoje   = Date (gf_GetServerDate ())

SELECT dh_inicio_geracao
  INTO :ldh_inicio_geracao
  FROM controle_geracao_pedido
 WHERE id_multitask_logistica = 'S'
	AND dh_pedido = :ldt_hoje
 USING SQLCA;

	Choose case SQLCA.SQLCode
		case is < 0
			SQLCA.of_msgdberror ('Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do in$$HEX1$$ed00$$ENDHEX$$cio do processo de gera$$HEX2$$e700e300$$ENDHEX$$o de pedido do CD.~n~rProcessamento cancelado!')
		case 0
			//A gera$$HEX2$$e700e300$$ENDHEX$$o de pedidos j$$HEX1$$e100$$ENDHEX$$ come$$HEX1$$e700$$ENDHEX$$ou
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
							'A gera$$HEX2$$e700e300$$ENDHEX$$o de pedido do CD j$$HEX1$$e100$$ENDHEX$$ come$$HEX1$$e700$$ENDHEX$$ou. A exclus$$HEX1$$e300$$ENDHEX$$o de produto n$$HEX1$$e300$$ENDHEX$$o pode ser feita neste momento.', &
							Exclamation!)
		case 100
			lb_sucesso = True
	End choose

Return lb_sucesso
end function

public function boolean wf_prepara_exclusao_produto ();Boolean	lb_Sucesso
String	ls_Operador

lb_Sucesso = False

If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Deseja continuar com o cancelamento do(s) produto(s) selecionado(s)?', Question!, YesNo!, 2) = 1 Then
	If gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento('W_GE344_CANCELA_PRODUTO_DO_PEDIDO', ref ls_Operador) Then 
		If wf_verifica_inicio_geracao_pedido_cd () then
			lb_Sucesso = True
		End if
	End If
End If

Return lb_Sucesso
end function

on w_ge344_manutencao_ped_almoxarifado.create
int iCurrent
call super::create
end on

on w_ge344_manutencao_ped_almoxarifado.destroy
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

event ue_postopen;call super::ue_postopen;dw_1.Object.Dh_Inicio		[1] = gvo_Parametro.of_Dh_Movimentacao()
dw_1.Object.Dh_Termino	[1] = dw_1.Object.Dh_Inicio[1]
end event

event ue_preopen;call super::ue_preopen;//// Dimens$$HEX1$$f500$$ENDHEX$$es da Primeira Tela
//ivl_Largura_1	= 2917
//ivl_Altura_1		= 2752
//// Dimens$$HEX1$$f500$$ENDHEX$$es da Segunda Tela
//ivl_Largura_2 	= 3109
//ivl_Altura_2 		= 1596
end event

event ue_cancel;call super::ue_cancel;ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)
ivb_Valida_Salva = False
dw_3.Event ue_Cancel()
end event

event ue_save;call super::ue_save;Boolean lb_Sucesso = True

Long ll_Linha
Long ll_Qt_Pedida
Long ll_Pedido
Long ll_Filial
Long ll_Produto
Long ll_Find

String ls_ValorPara
String ls_Situacao

dw_2.AcceptText()
dw_3.AcceptText()

If Not wf_Verifica_Situacao_Pedido(Ref ls_Situacao) Then Return -1

If ls_Situacao <> "C" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente pedido com situa$$HEX2$$e700e300$$ENDHEX$$o 'COLOCADO' poder$$HEX1$$e100$$ENDHEX$$ ser alterado.")
	Return -1
End If

ll_Find = dw_3.Find("qt_pedida = 0 or isnull(qt_pedida)", 1, dw_3.RowCount())

If ll_Find > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a quantidade pedida do produto.", Exclamation!)
	dw_3.Event ue_Pos(ll_Find, 'qt_pedida')
	Return -1
End If

For ll_Linha = 1 To dw_3.RowCount()
	
	If gf_Houve_Alteracao_Dw(dw_3, 'QT_PEDIDA', ll_Linha, Ref ls_ValorPara) Then
		
		ll_Qt_Pedida	= Long(ls_ValorPara)
		ll_Filial		= dw_2.Object.Cd_Filial		[dw_2.GetRow()]
		ll_Pedido		= dw_2.Object.Nr_Pedido	[dw_2.GetRow()]
		ll_Produto	= dw_3.Object.Cd_Produto	[ll_Linha]
		
		Update pedido_almoxarifado_produto
			Set qt_pedida = :ll_Qt_Pedida
		Where cd_filial = :ll_Filial
			And nr_pedido = :ll_Pedido
			And cd_produto = :ll_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack();
			SqlCa.of_MsgdbError("Erro ao gravar altera$$HEX2$$e700e300$$ENDHEX$$on na quantidade pedida." + SqlCa.SqlErrText)
			lb_Sucesso = False
			Exit
		End If
	End If
Next

If lb_Sucesso Then
	SqlCa.of_Commit();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Altera$$HEX2$$e700e300$$ENDHEX$$o gravada com sucesso.")
	
	ivm_Menu.mf_Confirmar(False)
	ivm_Menu.mf_Cancelar(False)
	ivb_Valida_Salva = False
	
	dw_2.Event ue_Recuperar()
End If

Return AncestorReturnValue
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge344_manutencao_ped_almoxarifado
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge344_manutencao_ped_almoxarifado
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge344_manutencao_ped_almoxarifado
integer width = 3671
integer height = 2792
end type

event tab_1::selectionchanging;SetPointer(HourGlass!)

If NewIndex = 1 Then
	If ivb_Valida_Salva Then		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem informa$$HEX2$$e700f500$$ENDHEX$$es que ainda n$$HEX1$$e300$$ENDHEX$$o foram salvas. ~r~r" + &
										 "Deseja sair dessa aba sem salv$$HEX1$$e100$$ENDHEX$$-las ?", Question!, YesNo!, 2) = 1 Then
										 
			Parent.Event ue_Cancel()
		Else			
			Return 1
		End If	
	End If
End If

If NewIndex = 2 Then
	If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
		// das DW's de detalhes
		Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
		
		dw_2.AcceptText()

		If dw_2.Object.Id_Situacao[dw_2.GetRow()] = "COLOCADO" And dw_2.Object.Nr_Pedido[dw_2.GetRow()] > 30000 Then
			dw_3.SetTabOrder('qt_pedida', 1)
		Else
			dw_3.SetTabOrder('qt_pedida', 0)
		End If
		
		If dw_2.Object.Id_Situacao[dw_2.GetRow()] <> "COLOCADO" then	//chamado 1311088
			//N$$HEX1$$e300$$ENDHEX$$o permite o cancelamento de produtos
			Tab_1.TabPage_2.cb_cancel_produt_pedido.Enabled = False
		else
			Tab_1.TabPage_2.cb_cancel_produt_pedido.Enabled = True
		End if

		// Permite a troca do folder
		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If		

SetPointer(Arrow!)
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
cb_ped_emp cb_ped_emp
cd_ped_inicial cd_ped_inicial
cb_1 cb_1
dw_4 dw_4
cb_cancel_produt_massa cb_cancel_produt_massa
end type

on tabpage_1.create
this.gb_4=create gb_4
this.cb_cancela=create cb_cancela
this.cb_ped_emp=create cb_ped_emp
this.cd_ped_inicial=create cd_ped_inicial
this.cb_1=create cb_1
this.dw_4=create dw_4
this.cb_cancel_produt_massa=create cb_cancel_produt_massa
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.cb_cancela
this.Control[iCurrent+3]=this.cb_ped_emp
this.Control[iCurrent+4]=this.cd_ped_inicial
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_4
this.Control[iCurrent+7]=this.cb_cancel_produt_massa
end on

on tabpage_1.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.cb_cancela)
destroy(this.cb_ped_emp)
destroy(this.cd_ped_inicial)
destroy(this.cb_1)
destroy(this.dw_4)
destroy(this.cb_cancel_produt_massa)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 456
integer width = 3561
integer height = 1616
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 3191
integer height = 420
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer y = 88
integer width = 3127
integer height = 324
string dataobject = "dw_ge344_selecao"
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
string dataobject = "dw_ge344_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;DateTime ldh_Inicio
DateTime ldh_Termino

Long ll_Filial
Long ll_Produto

String ls_Situacao
String ls_Tipo
String ls_Id_Gerado_Filial

dw_1.AcceptText()

ldh_Inicio			= dw_1.Object.Dh_Inicio					[1]
ldh_Termino		= dw_1.Object.Dh_Termino				[1]
ll_Filial				= dw_1.Object.Cd_Filial					[1]
ll_Produto			= dw_1.Object.Cd_Produto				[1]
ls_Situacao			= dw_1.Object.Id_Situacao				[1]
ls_Tipo				= dw_1.Object.Id_Tipo_Pedido			[1]
ls_Id_Gerado_Filial= dw_1.Object.Id_Ped_Gerado_Filial	[1]

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If Not IsNull(ll_Filial) And ll_Filial > 0 Then
	This.of_AppendWhere("p.cd_filial = " + String(ll_Filial))
End If

If Not IsNull(ll_Produto) And ll_Produto > 0 Then
	This.of_AppendWhere("pp.cd_produto = " + String(ll_Produto))
End If

//Se for diferente de TODOS
If ls_Situacao <> "O" Then
	This.of_AppendWhere("p.id_situacao = '" + String(ls_Situacao) + "'")
End If

//Se for diferente de TODOS
If ls_Tipo <> "T" Then
	This.of_AppendWhere("p.id_tipo_pedido = '" + String(ls_Tipo) + "'")
End If

If ls_Id_Gerado_Filial = "N" Then
	This.of_AppendWhere("p.nr_pedido >= 30000")
//	This.of_AppendWhere("p.id_tipo_pedido in ('E', 'I', 'A')")
Else
	This.of_AppendWhere("p.nr_pedido < 30000")
//	This.of_AppendWhere("v.cd_subgrupo = '509'")
End If

Return 1
end event

event dw_2::ue_recuperar;//OverRide

dw_1.AcceptText()

Return This.Retrieve(dw_1.Object.Dh_Inicio[1], dw_1.Object.Dh_Termino[1])
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;dw_4.Event ue_Reset()

dw_2.AcceptText()

If dw_2.RowCount() > 0 Then
	dw_4.Event ue_AddRow()
	
	dw_4.Object.Dh_Inclusao						[1] = dw_2.Object.Dh_Inclusao							[CurrentRow]
	dw_4.Object.Nr_Matricula_Cadastramento	[1] = dw_2.Object.Nr_Matricula_Cadastramento	[CurrentRow]
	dw_4.Object.Nm_Resp_Cad						[1] = dw_2.Object.Nm_Resp_Cad						[CurrentRow]
	dw_4.Object.Dh_Cancelamento					[1] = dw_2.Object.Dh_Cancelamento					[CurrentRow]
	dw_4.Object.Nr_Matricula_Cancelamento	[1] = dw_2.Object.Nr_Matricula_Cancelamento	[CurrentRow]
	dw_4.Object.Nm_Resp_Canc					[1] = dw_2.Object.Nm_Resp_Canc					[CurrentRow]
	dw_4.Object.De_Dados_Adicionais				[1] = dw_2.Object.De_Dados_Adicionais				[CurrentRow]
	
	dw_2.SetFocus()
End If
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
//	dw_1.AcceptText()
	
//	If dw_1.Object.Id_Ped_Gerado_Filial[1] = "N" Then
//		Cb_Cancela.Enabled = True
//	Else
//		Cb_Cancela.Enabled = False
//	End If

	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

This.Event RowFocusChanged(1)

Return pl_Linhas
end event

event dw_2::itemchanged;call super::itemchanged;String ls_Situacao

If dwo.Name = "id_cancela" Then
	If Data = "S" Then
		If Not wf_Verifica_Situacao_Pedido(Ref ls_Situacao) Then Return 1
		
		If ls_Situacao <> "C" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente pedido com situa$$HEX2$$e700e300$$ENDHEX$$o 'COLOCADO' pode ser cancelado.", Exclamation!)
			dw_2.SetFocus()
			Return 1
		End If
	End If
End If
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 3634
integer height = 2676
cb_cancel_produt_pedido cb_cancel_produt_pedido
end type

on tabpage_2.create
this.cb_cancel_produt_pedido=create cb_cancel_produt_pedido
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel_produt_pedido
end on

on tabpage_2.destroy
call super::destroy
destroy(this.cb_cancel_produt_pedido)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 3072
integer height = 2124
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer width = 3003
integer height = 2016
string dataobject = "dw_ge344_detalhes"
boolean vscrollbar = true
end type

event dw_3::ue_recuperar;//OverRide

dw_2.AcceptText()

Return This.Retrieve(dw_2.Object.Cd_Filial[dw_2.GetRow()], dw_2.Object.Nr_Pedido[dw_2.GetRow()])
end event

event dw_3::constructor;call super::constructor;This.of_SetRowSelection()
This.ivb_Ordena_Colunas = True
end event

event dw_3::editchanged;call super::editchanged;ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)
ivb_Valida_Salva = True
end event

event dw_3::itemchanged;call super::itemchanged;Choose case Lower (dwo.Name)
	case 'id_selecionado'	//Chamado 1311088
		If Data = 'S' Then
			If dw_2.Object.Id_Situacao[dw_2.GetRow ()] <> 'COLOCADO' then
				MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
								"Somente produtos de pedidos com situa$$HEX2$$e700e300$$ENDHEX$$o 'COLOCADO' podem ser cancelados!", &
								Exclamation!)
				dw_3.SetFocus()
				Return 1
			End If
		End if
End choose
end event

event dw_3::doubleclicked;call super::doubleclicked;//Chamado 1311088
Long		ll_Row
String	ls_Marcacao

If This.RowCount() > 0 Then

	If dwo.Name = 'st_selecionado' Then
			
		If ib_Check Then
			ls_Marcacao = 'N'
			ib_Check    = False
		Else
			If dw_2.Object.Id_Situacao[dw_2.GetRow ()] <> 'COLOCADO' then
				MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
								"Somente produtos de pedidos com situa$$HEX2$$e700e300$$ENDHEX$$o 'COLOCADO' podem ser cancelados!", &
								Exclamation!)
				Return
			End If
			
			ls_Marcacao = 'S'
			ib_Check    = True
		End If
		
		For ll_Row = 1 To This.RowCount()				
			This.Object.Id_Selecionado[ll_Row] = ls_Marcacao		
		Next
		
	End If
	
End If
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
integer width = 462
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar Pedido"
end type

event clicked;DateTime ldh_Atual

Long ll_Find
Long ll_Filial
Long ll_Pedido
Long ll_Linha

String ls_Selecionado

ll_Find = dw_2.Find("id_cancela = 'S'", 1, dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find.", StopSign!)
	dw_2.SetFocus()
	Return -1
End If

If ll_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum pedido foi selecionado.", Exclamation!)
	dw_2.SetFocus()
	Return -1
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja continuar com o cancelamento?", Question!, YesNo!, 2) = 2 Then
	Return -1
End If

ldh_Atual = gf_GetServerDate()

For ll_Linha = 1 To dw_2.RowCount()
	
	ls_Selecionado = dw_2.Object.Id_Cancela[ll_Linha]
	
	If ls_Selecionado = "S" Then

		ll_Filial	= dw_2.Object.Cd_Filial		[ll_Linha]
		ll_Pedido	= dw_2.Object.Nr_Pedido	[ll_Linha]
		
		Update pedido_almoxarifado
			Set id_situacao = 'X',
				 nr_matricula_cancelamento = :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
				 dh_cancelamento = :ldh_Atual
		Where cd_filial = :ll_Filial
			And nr_pedido = :ll_Pedido
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack();
			SqlCa.of_MsgdbError("Erro ao cancelar o pedido.")
			Return -1
		End If
	End If
Next

SqlCa.of_Commit();

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pedido(s) cancelado(s) com sucesso.")

dw_2.Event ue_Recuperar()
end event

type cb_ped_emp from commandbutton within tabpage_1
integer x = 1989
integer y = 2096
integer width = 1019
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Inserir Pedido Empurrado - ENCARTE"
end type

event clicked;String ls_Retorno

OpenWithParm(w_ge344_grava_pedido, "E")

ls_Retorno = Message.StringParm

If ls_Retorno = "OK" Then
	dw_2.Event ue_Recuperar()
End If
end event

type cd_ped_inicial from commandbutton within tabpage_1
integer x = 3013
integer y = 2096
integer width = 581
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Inserir Pedido Inicial"
end type

event clicked;String ls_Retorno

OpenWithParm(w_ge344_grava_pedido, "I")

ls_Retorno = Message.StringParm

If ls_Retorno = "OK" Then
	dw_2.Event ue_Recuperar()
End If
end event

type cb_1 from commandbutton within tabpage_1
integer x = 1211
integer y = 2096
integer width = 773
integer height = 100
integer taborder = 42
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Inserir Pedido Almoxarifado"
end type

event clicked;String ls_Retorno

OpenWithParm(w_ge344_grava_pedido, "A")

ls_Retorno = Message.StringParm

If ls_Retorno = "OK" Then
	dw_2.Event ue_Recuperar()
End If
end event

type dw_4 from dc_uo_dw_base within tabpage_1
integer x = 46
integer y = 2272
integer width = 3127
integer height = 356
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge344_dados_pedido"
end type

event ue_recuperar;//OverRide

Return 1
end event

type cb_cancel_produt_massa from commandbutton within tabpage_1
integer x = 489
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

event clicked;Any			la_dado
Boolean		lb_Sucesso
Long			ll_tot_linhas_planilha, &
				ll_Linha_planilha, &
				ll_cd_produto, &
				ll_qtd_prod
String		ls_Operador, &
				ls_Path,         &
	      	ls_Nome_Arquivo, &
				ls_produtos, &
				ls_chave, &
				ls_comando, &
				ls_Nulo, &
				ls_log
dc_uo_excel	lvo_Excel

lb_Sucesso = False

If gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento('W_GE344_CANCELA_PRODUTO_EM_MASSA', ref ls_Operador) Then 
	If wf_verifica_inicio_geracao_pedido_cd () then
		lb_Sucesso = True
	End if
End If

If not lb_Sucesso then
	Return
End if

MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
				'A planilha deve estar no mesmo formato abaixo, com apenas uma coluna:~r~r' + &
				'Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto a ser exclu$$HEX1$$ed00$$ENDHEX$$do dos pedidos' + '~n~n~r' + &
				'OBSERVA$$HEX2$$c700c300$$ENDHEX$$O:' + '~n~n~r' + &
				'Qualquer linha em branco indica o fim da planilha!')

If GetFileOpenName ("Selecione o arquivo", ls_Path, ls_Nome_Arquivo, "XLS, XLSX", &
						+ "Excel 2007 (*.XLSX), *.XLSX, Excel 97-2003 (*.XLS), *.XLS") <> 1 Then
	Return
End if

If Messagebox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
					'Confirma a importa$$HEX2$$e700e300$$ENDHEX$$o da planilha ' + ls_Path + '?' + '~n~n~r' + &
					'Todos os produtos listados na planilha ser$$HEX1$$e300$$ENDHEX$$o exclu$$HEX1$$ed00$$ENDHEX$$dos de todos os produtos em situ$$HEX2$$e700e300$$ENDHEX$$o COLOCADO!', &
					Question!, OkCancel!, 2) = 2 Then
	Return
End if

lb_Sucesso = True
lvo_Excel  = Create dc_uo_excel

Try
	If (lvo_Excel.uo_Referencia_Objeto_Excel (ls_path)) Then
	
		// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
		ll_tot_linhas_planilha = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
		
		If ll_tot_linhas_planilha > 0 Then
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
				
				If Not io_Produto.Localizado Then
					MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
									'O produto informado na c$$HEX1$$e900$$ENDHEX$$lula A' + String (ll_linha_planilha) + &
									' n$$HEX1$$e300$$ENDHEX$$o foi localizado!~n~r' + &
									'Favor corrigir a planilha e importar novamente.', Stopsign!)
					lb_Sucesso = False
					Return
				End If
				
				ll_qtd_prod ++
				If ll_qtd_prod = 1 then
					ls_produtos = String (ll_cd_produto)
				else
					ls_produtos = ls_produtos + ', ' + String (ll_cd_produto)
				End if
			Next
		End If
	End if
Finally
	Destroy (lvo_Excel)
	
	If lb_sucesso then
		If ll_qtd_prod = 0 then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Nenhum produto listado na planilha.', Exclamation!)
		else
			ls_comando = 'DELETE pedido_almoxarifado_produto ' + &
								'FROM pedido_almoxarifado_produto, pedido_almoxarifado ' + &
							  'WHERE pedido_almoxarifado_produto.cd_produto in (' + ls_produtos + ') ' + &
								 'AND pedido_almoxarifado_produto.cd_filial  =  pedido_almoxarifado.cd_filial ' + &
								 'AND pedido_almoxarifado_produto.nr_pedido  =  pedido_almoxarifado.nr_pedido ' + &
								 "AND pedido_almoxarifado.id_situacao        =  'C'"
			
			Execute immediate :ls_comando Using SqlCa;
			
			Choose case SQLCA.SQLCode
				case is < 0
					SQLCA.of_msgdberror ('Erro no cancelamento em massa dos produtos ' + ls_produtos + '.~n~rProcessamento cancelado!')
					SQLCA.of_rollback ()
					Return
				case 0
					//Grava o hist$$HEX1$$f300$$ENDHEX$$rico
					SetNull (ls_Nulo)
					ls_produtos = gf_replace (ls_produtos, ' ', '', 0)
					ls_chave = Iif (Len (ls_produtos) > 57, Left (ls_produtos, 57) + '...', ls_produtos)
					If Not gf_Grava_Historico_Alteracao_Tabela ('PEDIDO_ALMOXARIFADO_PRODUTO', ls_Chave, 'CD_PRODUTO', ls_produtos, ls_Nulo, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, &
																			  'E', ref ls_Log, True) Then
						//Em caso de erro, a fun$$HEX2$$e700e300$$ENDHEX$$o acima j$$HEX1$$e100$$ENDHEX$$ faz o rollback
						Return
					End If
					SQLCA.of_commit ()
					MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
									'Cancelamento de ' + + String (ll_qtd_prod) + ' produto(s) executado com sucesso')
				case 100
					SQLCA.of_msgdberror ('Produto(s) ' + ls_produtos + ' n$$HEX1$$e300$$ENDHEX$$o encontrado(s) nos pedidos.~n~rProcessamento cancelado!')
					SQLCA.of_rollback ()
					Return
			End choose
		End if
	End if
	
End Try
end event

type cb_cancel_produt_pedido from commandbutton within tabpage_2
integer x = 2345
integer y = 2172
integer width = 750
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar itens do pedido"
end type

event clicked;Long		ll_Find
Long		ll_cd_filial
Long		ll_cd_produto
Long		ll_nr_pedido
Long		ll_qtd_prd
String	ls_Chave
String	ls_Log
String	ls_Nulo
String	ls_Situacao

//Primeiro verifica se foi selecionado algum produto, pois n$$HEX1$$e300$$ENDHEX$$o faz sentido prosseguir se nenhum foi selecionado.
ll_Find = dw_3.Find ("id_selecionado= 'S'", dw_3.RowCount (), 0) //Pesquisa de tr$$HEX1$$e100$$ENDHEX$$s pra frente, para ir excluindo as linhas tratadas

If ll_Find < 0 Then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro no Find de produtos selecionados!', StopSign!)
	dw_3.SetFocus()
	Return
End If

If ll_Find = 0 Then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Nenhum produto foi selecionado!', Exclamation!)
	dw_3.SetFocus()
	Return
End If

If not wf_prepara_exclusao_produto () then
	Return
End if

If Not wf_Verifica_Situacao_Pedido(Ref ls_Situacao) Then Return

If ls_Situacao <> 'C' Then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
					"Somente produtos de pedidos com situa$$HEX2$$e700e300$$ENDHEX$$o 'COLOCADO' podem ser cancelados!", &
					Exclamation!)
	Return
End If

SetNull (ls_Nulo)

ll_cd_filial  = dw_2.Object.cd_filial[dw_2.GetRow ()]
ll_nr_pedido  = dw_2.Object.nr_pedido[dw_2.GetRow ()]

Do while ll_Find > 0
	ll_cd_produto = dw_3.Object.cd_produto[ll_find]
	
	DELETE FROM pedido_almoxarifado_produto 
	 WHERE cd_filial  = :ll_cd_filial
		AND nr_pedido  = :ll_nr_pedido
		AND cd_produto = :ll_cd_produto
	USING SQLCA;
	
	Choose case SQLCA.SQLCode
		case is < 0
			SQLCA.of_msgdberror ('Erro no cancelamento do produto ' + String (ll_cd_produto) + '-' + dw_3.Object.de_produto[ll_find] + ' do pedido ' + String (ll_nr_pedido) + &
										' da filial ' + String (ll_cd_filial) + '.~n~rProcessamento cancelado!')
			SQLCA.of_rollback ()
			Return
		case 0
			//Grava o hist$$HEX1$$f300$$ENDHEX$$rico
			ls_chave = String (ll_cd_filial) + '@#!' + String (ll_nr_pedido) + '@#!' + String (ll_cd_produto)
			If Not gf_Grava_Historico_Alteracao_Tabela ('PEDIDO_ALMOXARIFADO_PRODUTO', ls_Chave, 'CD_PRODUTO', String (ll_cd_produto), ls_Nulo, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, &
																	  'E', ref ls_Log, True) Then
				//Em caso de erro, a fun$$HEX2$$e700e300$$ENDHEX$$o acima j$$HEX1$$e100$$ENDHEX$$ faz o rollback
				Return
			End If
		case 100
			SQLCA.of_msgdberror ('Produto ' + String (ll_cd_produto) + '-' + dw_3.Object.de_produto[ll_find] + ' n$$HEX1$$e300$$ENDHEX$$o encontrado no pedido ' + String (ll_nr_pedido) + &
										' da filial ' + String (ll_cd_filial) + '.~n~rProcessamento cancelado!')
			SQLCA.of_rollback ()
			Return
	End choose
	
	ll_qtd_prd ++
	dw_3.DeleteRow (ll_Find)
	ll_Find = dw_3.Find ("id_selecionado= 'S'", dw_3.RowCount (), 0) //Pesquisa de tr$$HEX1$$e100$$ENDHEX$$s pra frente, para ir excluindo as linhas tratadas
Loop

SqlCa.of_Commit();

MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', String (ll_qtd_prd) + ' produto(s) cancelado(s) com sucesso!')

dw_3.Event ue_retrieve ()
end event

