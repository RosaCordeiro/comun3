HA$PBExportHeader$w_ge236_analise_eb_loja_nova.srw
forward
global type w_ge236_analise_eb_loja_nova from dc_w_2tab_cadastro_selecao_lista_det
end type
end forward

global type w_ge236_analise_eb_loja_nova from dc_w_2tab_cadastro_selecao_lista_det
integer width = 6144
integer height = 2576
string title = "GE236 - An$$HEX1$$e100$$ENDHEX$$lise de Estoque Base das Lojas Novas"
end type
global w_ge236_analise_eb_loja_nova w_ge236_analise_eb_loja_nova

type variables
uo_Filial io_Filial //ge009

dc_uo_dw_base dw_1, dw_2, dw_3

Date idt_Movimentacao

Long il_Filial
end variables

forward prototypes
public subroutine wf_menu_desabilitado ()
public function boolean wf_carrega_informacoes ()
public function boolean wf_recupera_venda (dc_uo_ds_base ads, long al_produto, ref long al_qt_venda, ref decimal adc_media_venda)
public function boolean wf_recupera_transferencia (dc_uo_ds_base ads, long al_produto, ref long al_qt_transferida)
public function boolean wf_localiza_usuario (string as_matricula, ref string as_nome)
end prototypes

public subroutine wf_menu_desabilitado ();dw_1.ivo_Controle_Menu.of_Incluir(False)
dw_1.ivo_Controle_Menu.of_Excluir(False)

dw_2.ivo_Controle_Menu.of_Incluir(False)
dw_2.ivo_Controle_Menu.of_Excluir(False)

dw_3.ivo_Controle_Menu.of_Incluir(False)
dw_3.ivo_Controle_Menu.of_Excluir(False)
end subroutine

public function boolean wf_carrega_informacoes ();DateTime ldh_Termino
DateTime ldh_Termino_Bloqueio
DateTime ldh_Movimentacao

Decimal ldc_Media_Venda

Long ll_Linha
Long ll_Qtd_Venda
Long ll_Produto
Long ll_Qtd_Transferida
Long ll_Dias_Bloqueio

String ls_Matricula
String ls_Nome

dw_3.AcceptText()

wf_Menu_Desabilitado()

ldh_Termino = gf_GetServerDate()

Try
	
	Open(w_Aguarde)
	
	w_Aguarde.Title = "Carregando informa$$HEX2$$e700f500$$ENDHEX$$es... Aguarde"

	dc_uo_ds_base lds_Venda
	lds_Venda = Create dc_uo_ds_base
	
	dc_uo_ds_base lds_Transferencia
	lds_Transferencia = Create dc_uo_ds_base
	
	If Not lds_Venda.of_ChangeDataObject("ds_ge236_venda") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'ds_ge236_venda'.", StopSign!)
		Return False
	End If
	
	If lds_Venda.Retrieve(DateTime(idt_Movimentacao), il_Filial) < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve do data store 'ds_ge236_venda'.", StopSign!)
		Return False
	End If

	If Not lds_Transferencia.of_ChangeDataObject("ds_ge236_transferencia") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'ds_ge236_transferencia'.", StopSign!)
		Return False
	End If
	
	If lds_Transferencia.Retrieve(il_Filial, DateTime(idt_Movimentacao), ldh_Termino) < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve do data store 'ds_ge236_transferencia'.", StopSign!)
		Return False
	End If
	
	For ll_Linha = 1 To dw_3.RowCount()
		ll_Produto = dw_3.Object.Cd_Produto[ll_Linha]
		
		If Not wf_Recupera_Venda(lds_Venda, ll_Produto, Ref ll_Qtd_Venda, Ref ldc_Media_Venda) Then
			Return False
		End If
		
		If Not wf_Recupera_Transferencia(lds_Transferencia, ll_Produto, Ref ll_Qtd_Transferida) Then
			Return False
		End If
		
		dw_3.Object.Qt_Venda	[ll_Linha] = ll_Qtd_Venda
		dw_3.Object.Med_Venda	[ll_Linha] = ldc_Media_Venda
		
		dw_3.Object.Qt_Transf_Receb	[ll_Linha] = ll_Qtd_Transferida
		
		ls_Matricula					= dw_3.Object.Nr_Matricula_Alteracao	[ll_Linha]
		ldh_Termino_Bloqueio	= dw_3.Object.Dh_Termino_Bloqueio		[ll_Linha]
		ldh_Movimentacao			= dw_3.Object.Dh_Movimentacao			[ll_Linha]
		
		If Not IsNull(ls_Matricula) And Trim(ls_Matricula) <> "" Then
			If wf_Localiza_Usuario(ls_Matricula, Ref ls_Nome) Then
				dw_3.Object.Nm_Alteracao[ll_Linha] = ls_Nome
			End If
		End If
		
		If Not IsNull(ldh_Termino_Bloqueio) Then
			ll_Dias_Bloqueio = DaysAfter(Date(ldh_Movimentacao), Date(ldh_Termino_Bloqueio))
		Else
			ll_Dias_Bloqueio = 0
		End If
		
		dw_3.Object.Nr_Dias_Bloqueio[ll_Linha] = ll_Dias_Bloqueio
	Next

Catch ( runtimeerror lo_rte )
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Ocorreu um erro no evento ue_postretrieve da dw_3: " + lo_rte.GetMessage(), StopSign!)
	If IsValid(lds_Venda) Then Destroy(lds_Venda)
	If IsValid(lds_Transferencia) Then	Destroy(lds_Transferencia)
	Close(w_Aguarde)
	Return False

Finally
	If IsValid(lds_Venda) Then Destroy(lds_Venda)
	If IsValid(lds_Transferencia) Then	Destroy(lds_Transferencia)
	Close(w_Aguarde)
End Try
end function

public function boolean wf_recupera_venda (dc_uo_ds_base ads, long al_produto, ref long al_qt_venda, ref decimal adc_media_venda);Long ll_Find

ll_Find = ads.Find("cd_produto = " + String(al_produto), 1, ads.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find na fun$$HEX2$$e700e300$$ENDHEX$$o wf_recupera_venda.", StopSign!)
	Return False
ElseIf ll_Find = 0 Then
	al_Qt_Venda		= 0
	adc_Media_Venda	= 0
Else
	al_Qt_Venda		= ads.Object.Qt_Venda			[ll_Find]
	adc_Media_Venda	= ads.Object.Qt_Media_Venda	[ll_Find]
End If

Return True
end function

public function boolean wf_recupera_transferencia (dc_uo_ds_base ads, long al_produto, ref long al_qt_transferida);Long ll_Find

ll_Find = ads.Find("cd_produto = " + String(al_produto), 1, ads.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find na fun$$HEX2$$e700e300$$ENDHEX$$o wf_recupera_transferencia.", StopSign!)
	Return False
ElseIf ll_Find = 0 Then
	al_Qt_Transferida = 0
Else
	al_Qt_Transferida = ads.Object.Qt_Transferida[ll_Find]
End If

Return True
end function

public function boolean wf_localiza_usuario (string as_matricula, ref string as_nome);Boolean lvb_Sucesso = True

Select nm_usuario Into :as_Nome
From usuario
Where nr_matricula = :as_Matricula
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		as_Nome = "DESCONHECIDO"
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Usu$$HEX1$$e100$$ENDHEX$$rio")
		lvb_Sucesso = False
End Choose

Return lvb_Sucesso
end function

on w_ge236_analise_eb_loja_nova.create
call super::create
end on

on w_ge236_analise_eb_loja_nova.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;ivl_Largura_1	= 2500
ivl_Altura_1		= 1484
ivl_Largura_2 	= 6107
ivl_Altura_2 		= 2396
end event

event close;call super::close;Destroy(io_Filial)
end event

event open;call super::open;io_Filial = Create uo_Filial

dw_1 = Tab_1.TabPage_1.dw_1
dw_2 = Tab_1.TabPage_1.dw_2
dw_3 = Tab_1.TabPage_2.dw_3
end event

event ue_postopen;call super::ue_postopen;wf_Menu_Desabilitado()
end event

event ue_save;call super::ue_save;Boolean lb_Sucesso = True
Boolean lb_Alteracao = False

DateTime ldh_Termino_Bloqueio

Long ll_Linha
Long ll_Produto
Long ll_Eb_Novo
Long ll_Eb_Anterior
Long ll_Fator

String ls_Alteracao
String ls_Motivo
String ls_Erro

dw_3.AcceptText()

OpenWithParm(w_ge236_motivo_alteracao, "")

ls_Motivo = Message.StringParm

If Trim(ls_Motivo) = "" Or IsNull(ls_Motivo) Then
	Return -1
End If

For ll_Linha = 1 To dw_3.RowCount()
	
	lb_Alteracao = False
	
	ll_Eb_Anterior				= dw_3.Object.Qt_Estoque_Base		[ll_Linha]
	ll_Eb_Novo					= dw_3.Object.Eb_Novo					[ll_Linha]
	ldh_Termino_Bloqueio	= dw_3.Object.Dh_Termino_Bloqueio	[ll_Linha]
	ll_Fator						= dw_3.Object.Vl_Fator_Conversao	[ll_Linha]
	
	If ll_Eb_Anterior <> ll_Eb_Novo Or gf_Houve_Alteracao_Dw(dw_3, 'DH_TERMINO_BLOQUEIO', ll_Linha, Ref ls_Alteracao) Then
		lb_Alteracao = True
	End If
	
	If Not lb_Alteracao Then
		Continue
	End If
	
	ll_Produto = dw_3.Object.Cd_Produto[ll_Linha]
	
	If Mod(ll_Eb_Novo, ll_Fator) <> 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O estoque base '" + String(ll_Eb_Novo) + "' do produto '" + String(ll_Produto) + "' deve ser m$$HEX1$$fa00$$ENDHEX$$ltiplo do fator de convers$$HEX1$$e300$$ENDHEX$$o '" + String(ll_Fator) + "' utilizado no Estoque Central.", Exclamation!)
		dw_3.Event ue_Pos(ll_Linha, "eb_novo")
		lb_Sucesso = False
		Exit
	End If
	
	// Est$$HEX1$$e100$$ENDHEX$$ fazendo update na coluna qt_estoque_base_inicial para for$$HEX1$$e700$$ENDHEX$$ar a atualiza$$HEX2$$e700e300$$ENDHEX$$o do log de exporta$$HEX2$$e700e300$$ENDHEX$$o
	
	Update resumo_reposicao_estoque
	Set qt_estoque_base_inicial	= qt_estoque_base_inicial,
		 qt_estoque_base			= :ll_EB_Novo,
		 dh_alteracao				= getdate(),
		 nr_matricula_alteracao	= :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
		 id_alteracao				= 'M',
		 dh_termino_bloqueio		= :ldh_Termino_Bloqueio,
		 de_motivo_alteracao		= :ls_Motivo
	Where cd_filial			= :il_Filial
		And cd_produto	= :ll_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_MsgdbError("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do estoque base." + ls_Erro)
		lb_Sucesso = False
		Exit
	End If
Next

If lb_Sucesso Then
	SqlCa.of_Commit();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Alterado com sucesso.")
	
	This.ivm_Menu.mf_Confirmar(False)
	This.ivm_Menu.mf_Cancelar(False)

	ivb_Valida_Salva = False

	dw_3.Event ue_Retrieve()
	
	Return 1
Else
	SqlCa.of_RollBack();	
	Return -1
End If
end event

event ue_cancel;This.ivb_Valida_Salva = False
Tab_1.TabPage_2.dw_3.Event ue_Cancel()
end event

type dw_visual from dc_w_2tab_cadastro_selecao_lista_det`dw_visual within w_ge236_analise_eb_loja_nova
end type

type gb_aux_visual from dc_w_2tab_cadastro_selecao_lista_det`gb_aux_visual within w_ge236_analise_eb_loja_nova
end type

type tab_1 from dc_w_2tab_cadastro_selecao_lista_det`tab_1 within w_ge236_analise_eb_loja_nova
integer x = 14
integer y = 0
integer width = 6066
integer height = 2376
end type

event tab_1::selectionchanging;//OverRide

SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
//		If wf_Valida_Salva() > 0 Then
//			If Tab_1.TabPage_1.dw_2.RowCount() > 0 Then Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
//			Return 0
//		Else
//			Return 1
//		End If
		
		If ivb_Valida_Salva Then		
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem informa$$HEX2$$e700f500$$ENDHEX$$es que ainda n$$HEX1$$e300$$ENDHEX$$o foram salvas. ~r~r" + &
											 "Deseja sair dessa aba sem salv$$HEX1$$e100$$ENDHEX$$-las ?", Question!, YesNo!, 2) = 1 Then
											 
				Parent.Event ue_Cancel()
			Else			
				Return 1
			End If	
		End If

	Case 2
		If Not Parent.ivb_Inclusao Then
			If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
				// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas das DW's de detalhes
				Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
		
				// Permite a troca do folder
				Return 0
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
				// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
				Return 1
			End If
		End If
End Choose

SetPointer(Arrow!)
end event

event tab_1::selectionchanged;//OverRide

SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		This.Width  = Parent.ivl_Largura_1
		This.Height = Parent.ivl_Altura_1
		
		Tab_1.TabPage_1.dw_2.SetFocus()
	Case 2
		This.Width  = Parent.ivl_Largura_2		
		This.Height = Parent.ivl_Altura_2
		
		Tab_1.TabPage_2.dw_3.SetFocus()
		ivm_Menu.mf_Limpar_Filtro(False)
		Parent.ivb_Inclusao = False
End Choose
	
Parent.Width  = This.Width + This.X + 75	
Parent.Height = This.Height + This.Y + 155		

SetPointer(Arrow!)
end event

type tabpage_1 from dc_w_2tab_cadastro_selecao_lista_det`tabpage_1 within tab_1
integer width = 6030
integer height = 2260
end type

type gb_2 from dc_w_2tab_cadastro_selecao_lista_det`gb_2 within tabpage_1
integer y = 200
integer width = 2418
integer height = 1116
end type

type gb_1 from dc_w_2tab_cadastro_selecao_lista_det`gb_1 within tabpage_1
integer width = 1545
integer height = 184
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_2tab_cadastro_selecao_lista_det`dw_1 within tabpage_1
integer width = 1463
integer height = 76
string dataobject = "dw_ge236_selecao"
end type

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "nm_fantasia"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			io_Filial.of_Inicializa()
			
			This.Object.Cd_Filial			[1] = io_Filial.Cd_Filial
			This.Object.Nm_Fantasia		[1] = io_Filial.Nm_Fantasia
		End If
End Choose
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "nm_fantasia"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			io_Filial.of_Inicializa()
			
			This.Object.Cd_Filial			[1] = io_Filial.Cd_Filial
			This.Object.Nm_Fantasia		[1] = io_Filial.Nm_Fantasia
		End If
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_fantasia" Then

		io_Filial.of_Localiza_Filial(This.GetText())

		If io_Filial.Localizada Then
			This.Object.Cd_Filial			[1] = io_Filial.Cd_Filial
			This.Object.Nm_Fantasia		[1] = io_Filial.Nm_Fantasia
		Else
			io_Filial.of_Inicializa()
		End If
	End If
End If
end event

type dw_2 from dc_w_2tab_cadastro_selecao_lista_det`dw_2 within tabpage_1
integer x = 37
integer y = 252
integer width = 2386
integer height = 1040
string dataobject = "dw_ge236_lista"
end type

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_recuperar;//OverRide

Long ll_Filial

dw_1.AcceptText()

ll_Filial = dw_1.Object.Cd_Filial[1]

If Not IsNull(ll_Filial) And ll_Filial > 0 Then
 	This.of_AppendWhere_SubQuery("p.cd_filial = " + String(ll_Filial), 3)
End If

Return This.Retrieve()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;wf_Menu_Desabilitado()

Return pl_Linhas
end event

type tabpage_2 from dc_w_2tab_cadastro_selecao_lista_det`tabpage_2 within tab_1
integer width = 6030
integer height = 2260
end type

type gb_3 from dc_w_2tab_cadastro_selecao_lista_det`gb_3 within tabpage_2
integer x = 9
integer y = 16
integer width = 5989
integer height = 2212
integer weight = 700
string facename = "Verdana"
end type

type dw_3 from dc_w_2tab_cadastro_selecao_lista_det`dw_3 within tabpage_2
integer x = 37
integer y = 60
integer width = 5947
integer height = 2140
string dataobject = "dw_ge236_detalhes"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event dw_3::ue_recuperar;//OverRide

DateTime ldh_Data_Atual

Long ll_Qtd_Mov

String ls_Filter
String ls_Sort
String ls_bloqueio

dw_2.AcceptText()
dw_3.AcceptText()

dw_3.SetRedraw(False)

//Limpa o filtro que $$HEX1$$e900$$ENDHEX$$ utilizado no evento ue_postretrieve da dw_3
ls_Filter = ''
ls_Sort = ''
	
dw_3.SetFilter( ls_Filter )
dw_3.Filter( )
dw_3.SetSort( ls_Sort )
dw_3.Sort()
//Fim filtro

ll_Qtd_Mov	= dw_2.Object.Dias_Movimento	[dw_2.GetRow()]
il_Filial		= dw_2.Object.Cd_Filial				[dw_2.GetRow()]
ls_Bloqueio	= dw_2.Object.Nm_Bloqueio		[dw_2.GetRow()]

ldh_Data_Atual = gf_GetServerDate()

idt_Movimentacao = RelativeDate(Date(ldh_Data_Atual), - ll_Qtd_Mov)

dw_3.Object.Descricao.Text = dw_2.Object.Nm_Fantasia[dw_2.GetRow()] +" (" + String(il_Filial) + ") | Per$$HEX1$$ed00$$ENDHEX$$odo Inicial: " + String(idt_Movimentacao) + " | Compra de Controlado: " + ls_Bloqueio

Return This.Retrieve(il_Filial, DateTime(idt_Movimentacao))
end event

event dw_3::constructor;call super::constructor;This.of_SetRowSelection()
This.ivb_Ordena_Colunas = True
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;String ls_Filter
String ls_Sort

If pl_Linhas > 0 Then	
	If Not wf_Carrega_Informacoes() Then
		Return -1
	End If
	
	ls_Filter	= "qt_transf_receb > 0 Or qt_venda_perdida > 0"
	ls_Sort	= "de_produto"
	
	dw_3.SetFilter( ls_Filter )
	dw_3.Filter( )
	dw_3.SetSort( ls_Sort )
	dw_3.Sort()
	
	dw_3.SetRedraw( True )
	
	dw_3.Event RowFocusChanged(1)
	
	dw_3.ivo_Controle_Menu.of_SalvarComo(True)
	ivm_Menu.mf_Filtrar( False )
Else
	dw_3.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_3::itemchanged;call super::itemchanged;DateTime ldh_Bloqueio_Novo
DateTime ldh_Data_Atual

If dwo.Name = "nr_dias_bloqueio" Then
	If Not IsNull(Long(Data)) And Long(Data) > 0 Then		
		If Not gf_Data_Parametro(Ref ldh_Data_Atual) Then
			Return -1
		End If
		
		ldh_Bloqueio_Novo = DateTime(RelativeDate(Date(ldh_Data_Atual), Long(Data)))
		
		This.Object.Dh_Termino_Bloqueio[This.GetRow()] = ldh_Bloqueio_Novo
	Else
		SetNull(ldh_Bloqueio_Novo)
		This.Object.Dh_Termino_Bloqueio[This.GetRow()] = ldh_Bloqueio_Novo
	End If
End If

ivm_Menu.mf_Limpar_Filtro(False)
end event

event dw_3::rowfocuschanged;call super::rowfocuschanged;String ls_Matricula
String ls_Nome
String ls_Descricao = ""
		 
DateTime ldh_Alteracao
DateTime ldh_Termino_Bloqueio
DateTime ldh_Movimentacao

Long ll_Dias_Bloqueio

If CurrentRow > 0 Then
	ldh_Alteracao				= This.Object.Dh_Alteracao				[CurrentRow]
	ls_Matricula					= This.Object.Nr_Matricula_Alteracao	[CurrentRow]
	ls_Nome						= This.Object.Nm_Alteracao			[CurrentRow]
	ldh_Termino_Bloqueio	= This.Object.Dh_Termino_Bloqueio	[CurrentRow]
	ldh_Movimentacao			= This.Object.Dh_Movimentacao		[CurrentRow]
	
	If Not IsNull(ldh_Alteracao) Then
		ls_Descricao = "ALTERADO EM '" + String(ldh_Alteracao, "dd/mm/yyyy hh:mm") + "' POR '" + ls_Nome + "'"
		
		If Not IsNull(ldh_Termino_Bloqueio) Then
			ll_Dias_Bloqueio = DaysAfter(Date(ldh_Movimentacao), Date(ldh_Termino_Bloqueio))
			
			If ll_Dias_Bloqueio = 1 Then
				ls_Descricao += " - BLOQUEADO POR 1 DIA"
			Else
				ls_Descricao += " - BLOQUEADO POR " + String(ll_Dias_Bloqueio) + " DIAS"
			End If
			
			ls_Descricao += " AT$$HEX1$$c900$$ENDHEX$$ '" + String(ldh_Termino_Bloqueio, "dd/mm/yyyy") + "'"
		End If
	End If
End If

This.Object.De_Alteracao.Text = ls_Descricao
end event

event dw_3::editchanged;call super::editchanged;DateTime ldh_Bloqueio_Novo
DateTime ldh_Data_Atual

If dwo.Name = "nr_dias_bloqueio" Then
	If Not IsNull(Long(Data)) And Long(Data) > 0 Then		
		If Not gf_Data_Parametro(Ref ldh_Data_Atual) Then
			Return -1
		End If
		
		ldh_Bloqueio_Novo = DateTime(RelativeDate(Date(ldh_Data_Atual), Long(Data)))
		
		This.Object.Dh_Termino_Bloqueio[This.GetRow()] = ldh_Bloqueio_Novo
	Else
		SetNull(ldh_Bloqueio_Novo)
		This.Object.Dh_Termino_Bloqueio[This.GetRow()] = ldh_Bloqueio_Novo
	End If
End If

ivm_Menu.mf_Limpar_Filtro(False)
end event

