HA$PBExportHeader$w_ge442_consulta_nf_diversa.srw
forward
global type w_ge442_consulta_nf_diversa from dc_w_2tab_consulta_selecao_lista_2det
end type
type dw_relatorio from dc_uo_dw_base within tabpage_1
end type
type cb_cancelar from picturebutton within tabpage_1
end type
type cb_imprimir_nota from commandbutton within tabpage_1
end type
type cb_copia_chave_acesso from picturebutton within tabpage_2
end type
end forward

global type w_ge442_consulta_nf_diversa from dc_w_2tab_consulta_selecao_lista_2det
string tag = "w_ge442_consulta_nf_diversa"
integer x = 215
integer y = 220
integer width = 4782
integer height = 2180
string title = "GE442 - Consulta de Notas Fiscais Diversas"
end type
global w_ge442_consulta_nf_diversa w_ge442_consulta_nf_diversa

type variables
uo_Filial  ivo_Filial
uo_Filial  ivo_Filial_Destino
uo_Cidade ivo_Cidade
uo_natureza_operacao ivo_natureza_operacao
uo_Produto ivo_Produto
uo_usuario ivo_Operador

Long il_Filial
Long il_Filial_Matriz

Date ivdt_Parametro

dc_uo_dw_base dw_3

Boolean ib_iniciado_operacao_sap = false
end variables

forward prototypes
public subroutine wf_localiza_filial ()
public subroutine wf_localiza_filial_destino ()
public function boolean wf_localiza_nf_matriz (string ps_sql, ref string as_dados)
public function boolean wf_localizar_no_distribuido ()
public function boolean wf_cancelada_sefaz (string as_chave)
public function boolean wf_possui_ativo (long al_filial, long al_nf, string as_especie, string as_serie)
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_localiza_filial ();String lvs_Filial

lvs_filial = Tab_1.TabPage_1.dw_1.GetText()

ivo_filial.of_localiza_filial(lvs_filial)


If ivo_filial.localizada Then
	
	Tab_1.TabPage_1.dw_1.Object.cd_filial[1] = ivo_filial.cd_filial 
	Tab_1.TabPage_1.dw_1.Object.de_filial[1] = ivo_filial.nm_fantasia
	
End If
end subroutine

public subroutine wf_localiza_filial_destino ();ivo_Filial_Destino.of_localiza_filial( Tab_1.TabPage_1.dw_1.GetText() )

If ivo_Filial_Destino.localizada Then
	
	Tab_1.TabPage_1.dw_1.Object.cd_filial_destino	[1] = ivo_Filial_Destino.cd_filial 
	Tab_1.TabPage_1.dw_1.Object.de_filial_destino	[1] = ivo_Filial_Destino.nm_fantasia
	
End If
end subroutine

public function boolean wf_localiza_nf_matriz (string ps_sql, ref string as_dados);String ls_SQL

Long ll_Retorno

Boolean lb_Retorno = False
		
Try
	SetPointer(HourGlass!)
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Localizando informa$$HEX2$$e700f500$$ENDHEX$$es na Matriz..."
	
	uo_Transacao_Remota lo_Conexao  //GE105
	lo_Conexao = Create uo_Transacao_Remota
	
	lo_Conexao.of_BancoProducao()
	lo_Conexao.of_Relatorio(True)
	lo_Conexao.of_ConverteVirgula(True)

	lo_Conexao.of_Retrieve(ps_SQL, Ref as_Dados)
	
	If lo_Conexao.of_Erro_Execucao() Or lo_Conexao.of_Erro_Conexao() Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.")
	Else
		lb_Retorno = True
		w_Aguarde.Title = "Finalizando a comunica$$HEX2$$e700e300$$ENDHEX$$o com a matriz, aguarde..."
	End If
	
Finally
	If IsValid( lo_Conexao ) Then Destroy lo_Conexao
	
	SetPointer(Arrow!)
	Close(w_Aguarde)
	Return lb_Retorno
End Try
end function

public function boolean wf_localizar_no_distribuido ();Long ll_Filial_Origem

ll_Filial_Origem	 = Tab_1.TabPage_1.dw_1.Object.cd_filial[ 1 ]

If il_Filial <> il_Filial_Matriz Then
	If ll_Filial_Origem <> il_Filial Or IsNull( ll_Filial_Origem )  Then
		Return True
	End If
End If

Return False
end function

public function boolean wf_cancelada_sefaz (string as_chave);DateTime ldh_cancelamento

select dh_cancelamento
into :ldh_cancelamento
from nf_diversa_nfe
where de_chave_acesso = :as_chave
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError("Erro ao localizar a nota fiscal com a chave de acesso: " + as_chave)
		Return False
	Case 100
		//SetNull(ldh_cancelamento)
		Return False
	Case 0
		If IsNull( ldh_cancelamento ) Then
			Return False
		Else
			Return True
		End If
End Choose


end function

public function boolean wf_possui_ativo (long al_filial, long al_nf, string as_especie, string as_serie);Long ll_Linhas

dc_uo_ds_base lo
lo = Create dc_uo_ds_base

Try
	If Not lo.of_Changedataobject( "dw_ge442_detalhe_item" ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento changeDataObject. wf_Possui_Ativo(long,long,string,string)")
		Return True
	End If
	
	lo.of_appendwhere( "i.cd_bem is not null" )
	
	ll_Linhas = lo.Retrieve( al_Filial, al_NF, as_Especie, as_Serie )
	
	If ll_Linhas < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no retrieve. wf_Possui_Ativo(long,long,string,string)")
		Return True
	End If
	
	If ll_linhas > 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A nota fiscal " + String(al_NF) + " possui bens de patrim$$HEX1$$f400$$ENDHEX$$nio e n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser cancelada.", Exclamation! )
		Return True
	Else
		Return False
	End If	
	
Finally
	If IsValid(lo) Then Destroy lo	
End Try
end function

public subroutine wf_insere_padrao ();DatawindowChild lvdwc_Child
Long lvl_Null

SetNull(lvl_Null)

//Motivo Ajuste
If Tab_1.Tabpage_1.dw_1.GetChild("cd_motivo_ajuste", lvdwc_Child) > 0 Then
	lvdwc_Child.InsertRow(1)
	
	lvdwc_Child.SetItem(1, "cd_motivo_ajuste", lvl_Null)
	lvdwc_Child.SetItem(1, "de_motivo_ajuste", "TODOS")
End If

//Perfil NF
If Tab_1.Tabpage_1.dw_1.GetChild("cd_perfil_nf", lvdwc_Child) > 0 Then
	lvdwc_Child.InsertRow(1)
	
	lvdwc_Child.SetItem(1, "cd_perfil_nf", lvl_Null)
	lvdwc_Child.SetItem(1, "de_perfil_nf", "TODOS")
End If
end subroutine

on w_ge442_consulta_nf_diversa.create
int iCurrent
call super::create
end on

on w_ge442_consulta_nf_diversa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;If IsValid( ivo_filial ) 					Then Destroy ivo_filial
If IsValid(ivo_Filial_Destino) 		Then Destroy ivo_Filial_Destino
If IsValid(ivo_Cidade)					Then Destroy ivo_Cidade
If IsValid(ivo_natureza_operacao)	Then Destroy ivo_natureza_operacao
If IsValid( dw_3 ) 						Then Destroy dw_3
If IsValid( ivo_Produto )				Then Destroy ivo_Produto
If IsValid( ivo_Operador )			Then Destroy ivo_Operador
end event

event ue_postopen;call super::ue_postopen;String ls_msg

dc_uo_dw_Base lvo_Update[]
lvo_Update = {Tab_1.TabPage_2.dw_3,Tab_1.TabPage_2.dw_4}
This.wf_SetUpdate_DW(lvo_Update)

dw_3 = Tab_1.TabPage_2.dw_3

il_Filial 			= gvo_Parametro.Of_Filial()
il_Filial_Matriz	= gvo_parametro.of_filial_matriz()

If il_Filial <> il_Filial_Matriz Then
	
	ivo_Filial.of_localiza_codigo(il_Filial)
	
	If ivo_Filial.localizada Then
		tab_1.tabpage_1.dw_1.Object.cd_filial[1]  = il_Filial
		tab_1.tabpage_1.dw_1.Object.de_filial[1]  = ivo_Filial.nm_fantasia
		
		tab_1.tabpage_1.dw_1.Event ue_Pos(1, 'dt_inicio')
		
		//ivo_Filial.Nm_Fantasia 		 = gvo_parametro.nm_fantasia_filial
	End If

End If

ivdt_Parametro = Date( gvo_Parametro.of_Dh_Movimentacao() )

Tab_1.TabPage_1.dw_1.Object.dt_inicio		[1] = ivdt_Parametro
Tab_1.TabPage_1.dw_1.Object.dt_termino	[1] = ivdt_Parametro
If il_Filial <> il_Filial_Matriz Then
	Tab_1.TabPage_1.dw_1.Object.nr_agrupamento_dev.TabSequence = 0
End If

wf_insere_padrao()

Tab_1.TabPage_1.cb_cancelar.Enabled = False

If Not gf_verifica_inicio_operacao_sap('DH_INICIO_OPERACAO_SAP', ref ib_iniciado_operacao_sap, ref ls_msg ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_msg,StopSign!)
	Post Event Close(this)
End If
end event

event ue_presave;call super::ue_presave;dw_3.AcceptText()

//Nome
If Not gf_Valida_Informacoes_Cliente(dw_3.Object.nm_destinatario[1],1) Then
	Tab_1.SelectedTab = 2
	dw_3.Event ue_Pos( 1, "nm_destinatario" )
	Return False
End If

//CPF/ CNPJ
If Not gf_Valida_Informacoes_Cliente(dw_3.Object.nr_cgc_cpf[1],4) Then
	Tab_1.SelectedTab = 2
	dw_3.Event ue_Pos( 1, "nr_cgc_cpf" )
	Return False
End If

//Endereco
If Not gf_Valida_Informacoes_Cliente(dw_3.Object.de_endereco[1], 2) Then
	Tab_1.SelectedTab = 2
	dw_3.Event ue_Pos( 1, "de_endereco" )
	Return False
End If

//N$$HEX1$$fa00$$ENDHEX$$mero Endere$$HEX1$$e700$$ENDHEX$$o
If IsNull(dw_3.Object.nr_endereco[1]) or dw_3.Object.nr_endereco[1] = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o n$$HEX1$$fa00$$ENDHEX$$mero do endere$$HEX1$$e700$$ENDHEX$$o.",Information!,Ok!)
	Tab_1.SelectedTab = 2
	dw_3.Event ue_Pos( 1, "nr_endereco" )
	Return False
End If

//Bairro
If Not gf_Valida_Informacoes_Cliente(dw_3.Object.de_bairro[1], 3) Then
	Tab_1.SelectedTab = 2
	dw_3.Event ue_Pos( 1, "de_bairro" )
	Return False
End If 

//CEP
If Not gf_Valida_Informacoes_Cliente(dw_3.Object.nr_cep[1], 6) Then
	Tab_1.SelectedTab = 2
	dw_3.Event ue_Pos( 1, "nr_cep" )
	Return False
End If

//Tel
If Not IsNull(dw_3.Object.nr_telefone[1]) And Trim(dw_3.Object.nr_telefone[1]) <> "" Then
	If Not gf_Valida_Informacoes_Cliente(dw_3.Object.nr_telefone[1], 5) Then
		Tab_1.SelectedTab = 2
		dw_3.Event ue_Pos( 1, "nr_telefone" )
		Return False
	End If
End If

//cidade
If dw_3.Object.nm_cidade[1] = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar a cidade.",Information!,Ok!)
	Tab_1.SelectedTab = 2
	dw_3.Event ue_Pos( 1, "nm_cidade" )
	Return False
End If

//Natureza Operacao
If IsNull(dw_3.Object.cd_natureza_operacao[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a natureza de opera$$HEX2$$e700e300$$ENDHEX$$o.",Information!,Ok!)
	Tab_1.SelectedTab = 2
	dw_3.Event ue_Pos( 1, "cd_natureza_operacao" )
	Return False
End If

Return True
end event

event ue_preopen;call super::ue_preopen;ivo_Filial 						= Create uo_filial
ivo_Filial_Destino			= Create uo_filial
ivo_Cidade 					= Create uo_Cidade
ivo_natureza_operacao 	= Create uo_natureza_operacao
ivo_Produto					= Create uo_Produto
ivo_Operador				= Create uo_usuario

Maxheight = 9999
ivl_largura_1 = 4750
ivl_largura_2 = 3800

ivm_menu.ivb_permite_imprimir = True
end event

event ue_print;Tab_1.Tabpage_1.dw_relatorio.Event ue_Print()
end event

event ue_printimmediate;Tab_1.Tabpage_1.dw_relatorio.Event ue_PrintImmediate()
end event

event resize;call super::resize;Tab_1.Height	= NewHeight - Tab_1.Y - 10
Tab_1.Width	= NewWidth - Tab_1.X - 10

Tab_1.Tabpage_1.gb_2.Height =  Tab_1.Height - Tab_1.Tabpage_1.gb_2.Y - 140
Tab_1.Tabpage_1.dw_2.Height =  Tab_1.Height - Tab_1.Tabpage_1.dw_2.Y - 170

Tab_1.Tabpage_2.gb_4.Height =  Tab_1.Height - Tab_1.Tabpage_2.gb_4.Y - 140
Tab_1.Tabpage_2.dw_4.Height =  Tab_1.Height - Tab_1.Tabpage_2.dw_4.Y - 170
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_2det`dw_visual within w_ge442_consulta_nf_diversa
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_2det`gb_aux_visual within w_ge442_consulta_nf_diversa
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_2det`tab_1 within w_ge442_consulta_nf_diversa
integer x = 9
integer width = 4722
integer height = 1976
long backcolor = 79741120
end type

event tab_1::selectionchanged;//OverRide
DateTime lvdt_Envio

Boolean lb_Habilita = False

Long ll_Filial_Origem

SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		This.Width  = Parent.ivl_Largura_1
		If OldIndex = 2 Then
			ivm_Menu.mf_Recuperar(True)
			ivm_Menu.mf_Imprimir(Tab_1.Tabpage_1.dw_2.RowCount() > 0)	
		End If
	Case 2
		This.Width  = Parent.ivl_Largura_2		
		ivm_Menu.mf_Imprimir(False)		
		ivm_Menu.mf_Recuperar(False)
		ivm_Menu.mf_Incluir(False)
		ivm_Menu.mf_Excluir(False)
		ivm_Menu.mf_Classificar(False)
		ivm_Menu.mf_Localizar(False)
		ivm_Menu.mf_Filtrar(False)
		
		lvdt_Envio		= DateTime( dw_3.Object.dh_envio[1])
		ll_Filial_Origem	= dw_3.Object.Cd_Filial_Origem[1]
		
		If IsNull( lvdt_Envio ) Then 			
			If il_Filial = il_Filial_Matriz And ll_Filial_Origem = 2 Then
				lb_Habilita = True
			End If
			
			If ll_Filial_Origem = il_Filial Then
				lb_Habilita = True
			End If
		Else
			If ll_Filial_Origem = il_Filial Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nota fiscal j$$HEX1$$e100$$ENDHEX$$ AUTORIZADA. Portanto, n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser alterada." , StopSign!)	
			End If
		End If
		
		tab_1.TabPage_2.dw_3.of_Set_somente_leitura(lb_Habilita )
		tab_1.TabPage_2.dw_4.of_Set_somente_leitura(lb_Habilita )
				
End Choose

Parent.Width  = This.Width + This.X + 75	

SetPointer(Arrow!)
end event

event tab_1::selectionchanging;//OverRide
SetPointer(HourGlass!)

If NewIndex = 2 Then
	If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
		// das DW's de detalhes
		dw_3.Reset()
		Tab_1.TabPage_2.dw_4.Reset()
		dw_3.Event ue_Recuperar()
		Tab_1.TabPage_2.dw_4.Event ue_Recuperar()

		// Permite a troca do folder
		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
Else
	Tab_1.TabPage_1.dw_2.SetFocus()
End If

SetPointer(Arrow!)
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_1 within tab_1
event create ( )
event destroy ( )
integer width = 4686
integer height = 1860
dw_relatorio dw_relatorio
cb_cancelar cb_cancelar
cb_imprimir_nota cb_imprimir_nota
end type

on tabpage_1.create
this.dw_relatorio=create dw_relatorio
this.cb_cancelar=create cb_cancelar
this.cb_imprimir_nota=create cb_imprimir_nota
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_relatorio
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.cb_imprimir_nota
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_relatorio)
destroy(this.cb_cancelar)
destroy(this.cb_imprimir_nota)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_2det`gb_2 within tabpage_1
integer x = 27
integer y = 740
integer width = 4640
integer height = 1108
fontcharset fontcharset = defaultcharset!
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_2det`gb_1 within tabpage_1
integer x = 27
integer y = 8
integer width = 4064
integer height = 724
fontcharset fontcharset = defaultcharset!
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_2det`dw_1 within tabpage_1
integer x = 50
integer y = 52
integer width = 4027
integer height = 648
string dataobject = "dw_ge442_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial[Row] 	= ivo_Filial.Cd_Filial
			This.Object.De_Filial[Row] 	= ivo_Filial.Nm_Fantasia
		End If
		
	Case "de_filial_destino"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial_Destino.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial_Destino.of_Inicializa()
			
			This.Object.Cd_Filial_Destino	[Row] = ivo_Filial_Destino.Cd_Filial
			This.Object.De_Filial_Destino	[Row] = ivo_Filial_Destino.Nm_Fantasia
		End If
		
	Case "nm_produto"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Produto.ivs_descricao_apresentacao_venda Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.cd_produto	[Row] = ivo_Produto.cd_produto
			This.Object.nm_produto	[Row] = ivo_Produto.ivs_descricao_apresentacao_venda
		End If

	Case "nm_operador"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Operador.nm_usuario Then
				Return 1
			End If
		Else
			ivo_Operador.of_Inicializa()
			
			This.Object.nr_matricula_operador	[Row] = ivo_Operador.nr_matricula
			This.Object.nm_operador				[Row] = ivo_Operador.nm_usuario
		End If
		
	Case "de_natureza_operacao"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_natureza_operacao.De_Natureza_Operacao Then
				Return 1
			End If
		Else
			ivo_natureza_operacao.of_Inicializa()
			
			This.Object.Cd_Natureza_Operacao[Row] 	= ivo_natureza_operacao.Cd_Natureza_Operacao
			This.Object.De_Natureza_Operacao[Row] 	= ivo_natureza_operacao.De_Natureza_Operacao
		End If
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then 
	This.Object.De_Filial[1] = ivo_Filial.Nm_Fantasia
End If	

If IsValid(ivo_natureza_operacao) Then 
	This.Object.De_Natureza_Operacao[1] = ivo_Natureza_Operacao.De_Natureza_Operacao
End If	

If IsValid(ivo_Operador) Then 
	This.Object.nm_operador	[1] = ivo_Operador.nm_usuario
End If	

If IsValid(ivo_Produto) Then 
	This.Object.nm_produto[1] = ivo_Produto.ivs_descricao_apresentacao_venda
End If	
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	Choose Case This.GetColumnName() 
		Case "de_filial"
			wf_Localiza_Filial()
			
		Case "de_filial_destino"
			wf_Localiza_Filial_destino()
			
		Case "nm_produto"
			ivo_Produto.Of_Inicializa()
			
			ivo_Produto.of_Localiza_produto( This.getText() )
			
			This.Object.cd_produto	[1] = ivo_Produto.cd_produto
			This.Object.nm_produto	[1] = ivo_Produto.ivs_descricao_apresentacao_venda
	
		Case "nm_operador"
			ivo_Operador.Of_Inicializa()
			
			ivo_Operador.of_Localiza_usuario( This.GetText() )
			
			This.Object.nr_matricula_operador	[1] = ivo_Operador.nr_matricula
			This.Object.nm_operador				[1] = ivo_Operador.nm_usuario
			
		Case "de_natureza_operacao"			
			ivo_Natureza_Operacao.of_Localiza_Natureza(This.GetText())
			
			If ivo_Natureza_Operacao.Localizado Then
				This.Object.Cd_Natureza_Operacao[1] = ivo_Natureza_Operacao.Cd_Natureza_Operacao
				This.Object.De_Natureza_Operacao[1] = ivo_Natureza_Operacao.De_Natureza_Operacao
			End If
	End Choose
	
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
Tab_1.TabPage_1.cb_Cancelar.Enabled = False
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_2det`dw_2 within tabpage_1
integer x = 55
integer y = 788
integer width = 4590
integer height = 1036
string dataobject = "dw_ge442_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::constructor;call super::constructor;This.of_SetRowSelection( "if( (not isnull( dh_cancelamento )), rgb(255, 0, 0), " + This.ivs_Cor_Linha_Padrao + ")", "", False )
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	ivm_Menu.mf_SalvarComo(True)
Else
	ivm_Menu.mf_SalvarComo(False)
End If

This.ShareData(Parent.dw_relatorio)

Return pl_Linhas
end event

event dw_2::ue_recuperar;//OverRide

String ls_Especie
String ls_Serie
String ls_Dados
String ls_Mensagem
String ls_Situacao
String ls_Desc_Item
String ls_Ajuste_Estoque
String ls_Carreg_Itens_Audit
String ls_Matric_Operador
String ls_Oculta_NF_Dest_Filial

Long ll_Filial_Origem
Long ll_NF
Long ll_CFOP
Long ll_Filial_Destino
Long ll_Retorno
Long ll_Mot_Ajuste
Long ll_Perfil_NF
Long ll_Prod
Long ll_NR_Ajuste
Long ll_nr_agrupamento_dev

Date ldt_Inicio
Date ldt_Termino

Char	lc_Id_Habilitade_Entrada

This.Reset()

// Verifica quais os par$$HEX1$$e200$$ENDHEX$$metros informados
Parent.dw_1.AcceptText()

ll_Filial_Origem				= Parent.dw_1.Object.Cd_Filial							[1]
ll_NF							= Parent.dw_1.Object.Nr_NF							[1]
ls_Especie					= Parent.dw_1.Object.De_Especie						[1]
ls_Serie						= Parent.dw_1.Object.De_Serie						[1]
ldt_Inicio						= Parent.dw_1.Object.Dt_Inicio							[1]
ldt_Termino					= Parent.dw_1.Object.Dt_Termino						[1]
ll_CFOP						= Parent.dw_1.Object.cd_natureza_operacao		[1]
ll_Filial_Destino 			= Parent.dw_1.Object.Cd_Filial_Destino				[1]
ls_Situacao					= Parent.dw_1.Object.id_situacao						[1]
ls_Desc_Item				= Parent.dw_1.Object.de_item							[1]
ll_Mot_Ajuste				= Parent.dw_1.Object.cd_motivo_ajuste				[1]
ll_Perfil_NF					= Parent.dw_1.Object.cd_perfil_nf						[1]
ls_Ajuste_Estoque			= Parent.dw_1.Object.id_ajusta_estoque			[1]
ls_Carreg_Itens_Audit	= Parent.dw_1.Object.id_perfil_auditoria				[1]
ll_Prod						= Parent.dw_1.Object.cd_produto						[1]
ls_Matric_Operador		= Parent.dw_1.Object.nr_matricula_operador		[1]
ll_NR_Ajuste				= Parent.dw_1.Object.nr_ajuste_estoque			[1]
ls_Oculta_NF_Dest_Filial	= Parent.dw_1.Object.id_oculta_dest_propria_fil	[1]
ll_nr_agrupamento_dev	= Parent.dw_1.Object.nr_agrupamento_dev		[1]
lc_Id_Habilitade_Entrada	= Parent.dw_1.Object.id_habilitade_entrada		[1]

//Somente nas Filiais
If il_Filial <> il_Filial_Matriz Then
	
	ls_Mensagem = "A filial de origem ou a filial de destino deve ser a sua filial ( " + String(il_Filial) + " )."
	
	If IsNull( ll_Filial_Origem ) And IsNull( ll_Filial_Destino ) Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem )
		dw_1.Event ue_Pos(1, "cd_filial_destino" )
		Return -1
	End If
	
	//Quando n$$HEX1$$e300$$ENDHEX$$o for informada a filial Origem.
	//Verificacao de notas emitidas contra a filial do parametro.
	If IsNull( ll_Filial_Origem ) And Not IsNull( ll_Filial_Destino ) And ( ll_Filial_Destino <> il_Filial ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem )
		dw_1.Event ue_Pos(1, "cd_filial_destino" )
		Return -1
	End If
	
	//Quando for informada a filial Origem diferente da filial do parametro
	If IsNull( ll_Filial_Destino ) And Not IsNull( ll_Filial_Origem ) And ( ll_Filial_Origem <> il_Filial ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem )
		dw_1.Event ue_Pos(1, "cd_filial" )
		Return -1
	End If
	
	//Quando a filial origem e filial destino diferem da filial do parametro
	If Not IsNull( ll_Filial_Destino ) And Not IsNull( ll_Filial_Origem ) And ( (ll_Filial_Origem <> il_Filial) And (ll_Filial_Destino <> il_Filial) ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem )
		dw_1.Event ue_Pos(1, "cd_filial" )
		Return -1
	End If
	
Else
	
	If Not IsNull( ll_nr_agrupamento_dev ) and ll_nr_agrupamento_dev > 0 Then
		This.of_AppendWhere("n.nr_agrupamento_dev_compra_wms = " + String( ll_nr_agrupamento_dev ) )
	End If
		
End If

If Not IsNull( ll_Filial_Destino ) and ll_Filial_Destino > 0 Then
	This.of_AppendWhere("n.cd_filial_destino = " + String( ll_Filial_Destino ) )
End If

If Not IsNull( ll_Mot_Ajuste ) and ll_Mot_Ajuste > 0 Then
	This.of_AppendWhere("n.cd_motivo_ajuste = " + String( ll_Mot_Ajuste ) )
End If

If Not IsNull( ll_Perfil_NF ) and ll_Perfil_NF > 0 Then
	This.of_AppendWhere("n.cd_perfil_nf = " + String( ll_Perfil_NF ) )
End If

// Formula a cl$$HEX1$$e100$$ENDHEX$$usula where correspondente
If Not IsNull(ll_Filial_Origem) and ll_Filial_Origem > 0 Then
	This.of_AppendWhere("n.cd_filial_origem = " + String(ll_Filial_Origem) )
End If

If Not IsNull(ldt_Inicio) Then
	This.of_AppendWhere("n.dh_movimentacao_caixa >= '" + string(ldt_Inicio,"yyyymmdd") + "'" )
End If

If Not IsNull(ldt_Termino) Then
	This.of_AppendWhere("n.dh_movimentacao_caixa <= '" + string(ldt_Termino,"yyyymmdd") + "'" )
End If

If Not IsNull(ll_NF) and ll_NF > 0 Then
	This.of_AppendWhere("n.nr_nf = " + String(ll_NF) )
End If

If Not IsNull(ls_Especie) and ls_Especie <> "" Then
	This.of_AppendWhere("n.de_especie = '" + ls_Especie + "'" )
End If

If Not IsNull(ls_Matric_Operador) and ls_Matric_Operador <> "" Then
	This.of_AppendWhere("n.nr_matricula_operador = '" + ls_Matric_Operador + "'" )
End If

If Not IsNull(ls_Serie) and ls_Serie <> "" Then
	This.of_AppendWhere("n.de_serie = '" + ls_Serie + "'" )
End If

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'PT' Then
	This.of_AppendWhere("n.id_patrimonio = 'S'")
End If

If Not IsNull(ll_CFOP) and ll_CFOP > 0 Then
	This.of_AppendWhere("n.cd_natureza_operacao = " + String(ll_CFOP) )
End If

If ls_Situacao <> 'T' Then
	If ls_Situacao = 'C' Then
		This.Of_appendwhere('n.dh_cancelamento is not null')
	Else
		This.Of_appendwhere('n.dh_cancelamento is null')
	End if
End if

If Not IsNull(ls_Desc_Item) and Trim(ls_Desc_Item)<>"" Then
	This.Of_appendwhere("exists (select 1 from item_nf_diversa i1 "+ &
								 "where i1.cd_filial_origem = n.cd_filial_origem " + &
								 "and i1.nr_nf = n.nr_nf  " + &
								 "and i1.de_serie = n.de_serie " + &
								 "and i1.de_especie = n.de_especie " + &
								 "and i1.de_item like '%"+ls_Desc_Item+"%')")	
End If

If Not IsNull(ll_Prod) and ll_Prod > 0 Then
	This.Of_appendwhere("exists (select 1 from item_nf_diversa i1 "+ &
								 "where i1.cd_filial_origem = n.cd_filial_origem " + &
								 "and i1.nr_nf = n.nr_nf  " + &
								 "and i1.de_serie = n.de_serie " + &
								 "and i1.de_especie = n.de_especie " + &
								 "and i1.cd_produto ="+String(ll_Prod)+")")	
End If

If Not IsNull(ll_NR_Ajuste) and ll_NR_Ajuste > 0 Then
	This.Of_appendwhere("exists (select 1 from item_nf_diversa i1 "+ &
								 "where i1.cd_filial_origem = n.cd_filial_origem " + &
								 "and i1.nr_nf = n.nr_nf  " + &
								 "and i1.de_serie = n.de_serie " + &
								 "and i1.de_especie = n.de_especie " + &
								 "and i1.nr_ajuste_estoque ="+String(ll_NR_Ajuste)+")")	
End If

If Not IsNull(ls_Ajuste_Estoque) and (ls_Ajuste_Estoque<>"") Then
	This.Of_AppendWhere("n.id_ajusta_estoque='"+ls_Ajuste_Estoque+"'")
End If

If Not IsNull(ls_Carreg_Itens_Audit) and (ls_Carreg_Itens_Audit<>"") Then
	This.Of_AppendWhere("n.id_ajuste_auditoria='"+ls_Carreg_Itens_Audit+"'")
End If

If ls_Oculta_NF_Dest_Filial = "S" Then
	This.Of_appendwhere("coalesce(n.nr_cgc_cpf, '') <> coalesce(f.nr_cgc, '')")
End If

If lc_Id_Habilitade_Entrada = "S" Then
	This.Of_appendwhere("exists(select 1 from perfil_nota_diversa pnd where pnd.cd_perfil_nf = n.cd_perfil_nf and coalesce(pnd.id_exporta_nf_entrada, 'S')<>'N')")
End If

String ls_Sql
ls_Sql = this.GetSqlSelect()

ivm_menu.mf_imprimir(False)

If wf_localizar_no_distribuido() Then
	//Somente nas Filiais
	//quando a filial origem for diferente da filial do parametro
	Try
				
		If Not wf_localiza_nf_matriz( This.GetSQLSelect(), Ref ls_Dados ) Then Return -1
	
		ll_Retorno = This.ImportString( ls_Dados )
			
	Finally
		If ll_Retorno = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.")
		ElseIf ll_Retorno < -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao copiar as informa$$HEX2$$e700f500$$ENDHEX$$es do servidor distribu$$HEX1$$ed00$$ENDHEX$$do para a DataWindow local (DW_2).")
		End If
	End Try

Else
	ll_Retorno = This.Retrieve()
End If

Return ll_Retorno
	


end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;Long ll_Filial_Origem
Boolean lb_Habilita = False

If currentRow > 0 Then
	
	ll_Filial_Origem = This.Object.cd_filial_origem[ currentRow ]
	
	If il_Filial <> il_Filial_Matriz Then
		If il_Filial = ll_Filial_Origem Then
			lb_Habilita = True
		End If	
	End If
	
	Tab_1.TabPage_1.cb_Cancelar.Enabled = lb_Habilita
End If
end event

event dw_2::ue_saveas;//override
dw_relatorio.Event ue_SaveAs()
end event

event dw_2::getfocus;call super::getfocus;If This.RowCount() > 0 Then
	ivm_Menu.mf_SalvarComo(True)
Else
	ivm_Menu.mf_SalvarComo(False)
End If
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_2 within tab_1
integer width = 4686
integer height = 1860
cb_copia_chave_acesso cb_copia_chave_acesso
end type

on tabpage_2.create
this.cb_copia_chave_acesso=create cb_copia_chave_acesso
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_copia_chave_acesso
end on

on tabpage_2.destroy
call super::destroy
destroy(this.cb_copia_chave_acesso)
end on

type gb_4 from dc_w_2tab_consulta_selecao_lista_2det`gb_4 within tabpage_2
integer x = 27
integer y = 1224
integer width = 3707
integer height = 616
fontcharset fontcharset = defaultcharset!
string text = "Itens da Nota Fiscal"
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_2det`gb_3 within tabpage_2
integer x = 27
integer y = 8
integer width = 3712
integer height = 1196
fontcharset fontcharset = defaultcharset!
long backcolor = 79741120
string text = "Detalhes da Nota Fiscal"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_2det`dw_3 within tabpage_2
integer x = 50
integer y = 68
integer width = 3653
integer height = 1116
string dataobject = "dw_ge442_detalhe"
end type

event dw_3::ue_recuperar;// OverRide
Long ll_Filial
Long ll_Nr
Long ll_Linha
Long ll_Retorno

String ls_Especie
String ls_Serie
String ls_SqL
String ls_Dados
		 
ll_Linha = Tab_1.TabPage_1.dw_2.GetRow()

ll_Filial		= Tab_1.TabPage_1.dw_2.Object.cd_filial_origem		[ll_linha]
ll_nr			= Tab_1.TabPage_1.dw_2.Object.nr_nf     				[ll_linha]
ls_Especie	= Tab_1.TabPage_1.dw_2.Object.de_especie			[ll_linha]
ls_Serie		= Trim( Tab_1.TabPage_1.dw_2.Object.de_serie		[ll_linha] )

This.ivo_controle_menu.Of_SalvarComo(False)

If wf_localizar_no_distribuido() Then
	
	Try
	
		ls_SqL = This.GetSQLSelect()
		
		//Filial
		ls_SqL = gf_replace( ls_SqL, ":cd_filial_origem", String(ll_Filial), 1 )
		ls_SqL = gf_replace( ls_SqL, ":nr_nf", String( ll_nr ),  1 )
		ls_SqL = gf_replace( ls_SqL, ":de_especie", "'" + ls_Especie + "'", 1 )
		ls_SqL = gf_replace( ls_SqL, ":de_serie", "'" +ls_Serie + "'", 1 )
		
		If Not wf_localiza_nf_matriz( ls_SqL, Ref ls_Dados ) Then Return -1
	
		ll_Retorno = This.ImportString( ls_Dados )
			
	Finally
		If ll_Retorno = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.")
		ElseIf ll_Retorno < -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao copiar as informa$$HEX2$$e700f500$$ENDHEX$$es do servidor distribu$$HEX1$$ed00$$ENDHEX$$do para a DataWindow local (DW_3).")
		End If
	End Try
	
Else
	ll_Retorno = This.Retrieve(ll_filial, ll_nr, ls_especie, ls_serie)
End If

Return this.event ue_postretrieve( ll_Retorno )
end event

event dw_3::editchanged;call super::editchanged;ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)
end event

event dw_3::itemchanged;call super::itemchanged;Long lvl_nulo

SetNull(lvl_Nulo)

ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)

Choose Case dwo.Name
	Case "nm_cidade"
		If Not Isnull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Cidade.nm_cidade Then 
				Return 1
			End If
		Else
			ivo_Cidade.of_Inicializa()
									
			This.Object.nm_cidade	[1] = ivo_cidade.nm_cidade
			This.Object.cd_cidade	[1] = ivo_cidade.cd_cidade
			This.Object.nm_uf	 		[1] = ivo_cidade.cd_unidade_federacao
			
		End If
	Case "de_natureza_operacao"
		If Trim(Data) = "" Then
			This.Object.Cd_natureza_operacao	[1]        		= lvl_Nulo
			ivo_natureza_operacao.cd_natureza_operacao 	= lvl_Nulo
			ivo_natureza_operacao.de_natureza_operacao 	= ""
		End If
End Choose
end event

event dw_3::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_3::ue_key;call super::ue_key;String lvs_Coluna

lvs_Coluna = This.GetColumnName()

If Key = KeyEnter! Then
	Choose Case lvs_Coluna
		Case "de_natureza_operacao"
			ivo_natureza_operacao.of_Localiza_Natureza(This.GetText())
			
			If ivo_natureza_operacao.Localizado Then		
				
				dw_3.Object.cd_natureza_operacao[1] = ivo_natureza_operacao.cd_natureza_operacao
				dw_3.Object.de_natureza_operacao[1] = ivo_natureza_operacao.de_natureza_operacao
				
			End If
			
		Case "nm_cidade"
			ivo_Cidade.of_Localiza_Cidade(This.GetText())
			
			If ivo_Cidade.Localizada Then
				
				dw_3.Object.nm_cidade	[1] = ivo_cidade.nm_cidade
				dw_3.Object.cd_cidade	[1] = ivo_cidade.cd_cidade
				dw_3.Object.nm_uf	 	[1] = ivo_cidade.cd_unidade_federacao
			
			End If
			
	End Choose
	
End If
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;If pl_linhas > 0 And ( il_Filial = il_Filial_Matriz ) Then
	long	ll_nr_agrupamento_dev_compra, &
			ll_cd_filial_origem, &
			ll_nr_nf
	String	ls_de_especie, &
			ls_de_serie
			
	ll_cd_filial_origem = this.Object.cd_filial_origem[1]
	ll_nr_nf =this.Object.nr_nf[1]
	ls_de_especie = this.Object.de_especie[1]
	ls_de_serie = this.Object.de_serie[1]
	
	Select nr_agrupamento_dev_compra_wms
	Into :ll_nr_agrupamento_dev_compra
	From nf_diversa
	Where cd_filial_origem = :ll_cd_filial_origem
		And nr_nf = :ll_nr_nf
		And de_especie = :ls_de_especie
		And de_serie = :ls_de_serie
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		Sqlca.of_MsgDbError("Erro ao buscar o nr_agrupamento_dev_compra_wms  na tabela nf_diversa.")
		Return -1
	Else
		Return this.setitem( 1, "nr_agrupamento_dev_compra", ll_nr_agrupamento_dev_compra)
	End If
End If
end event

type dw_4 from dc_w_2tab_consulta_selecao_lista_2det`dw_4 within tabpage_2
integer x = 50
integer y = 1280
integer width = 3657
integer height = 544
string dataobject = "dw_ge442_detalhe_item"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_4::ue_recuperar;// OverRide

Long ll_Filial
Long ll_Nr
Long ll_Linha
Long ll_Retorno = -1

String ls_Especie
String ls_Serie
String ls_SqL
String ls_Dados
		  
Datetime ldh_Envio

Try	
	
	ll_Linha = Tab_1.TabPage_1.dw_2.GetRow()
	
	ll_Filial  		= Tab_1.TabPage_1.dw_2.Object.cd_filial_origem 		[ll_Linha]
	ll_nr      		= Tab_1.TabPage_1.dw_2.Object.nr_nf     					[ll_linha]
	ls_Especie 	= Tab_1.TabPage_1.dw_2.Object.de_especie				[ll_linha]
	ls_Serie  	= Trim( Tab_1.TabPage_1.dw_2.Object.de_serie  		[ll_linha] )
	ldh_Envio	= DateTime( dw_3.Object.dh_envio  	[1] )
		
	This.Of_Set_Somente_Leitura(IsNull(ldh_Envio))

	ll_Retorno =  This.Retrieve(ll_filial, ll_nr, ls_especie, ls_serie)
	
Catch ( runtimeerror  lo_rte )
	MessageBox (	"Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro ao localizar os itens da nota ~r~r"+ & 						
 						"Erro: "+lo_rte.GetMessage( ))	
	Return -1
Finally
	
End Try

Return ll_Retorno
end event

event dw_4::constructor;call super::constructor;This.of_SetRowSelection()

end event

event dw_4::editchanged;call super::editchanged;ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)
end event

event dw_4::itemchanged;call super::itemchanged;ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)
end event

event dw_4::getfocus;call super::getfocus;ivm_Menu.mf_Imprimir(False)		
ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
ivm_Menu.mf_Classificar(False)
ivm_Menu.mf_Localizar(False)
ivm_Menu.mf_Filtrar(False)
end event

event dw_4::ue_preupdate;call super::ue_preupdate;String ls_Null, ls_CEST

Long ll_Linha

SetNull( ls_Null )

If This.RowCount() > 0 Then
	For ll_linha = 1  To This.RowCount()
		ls_CEST = Trim ( This.Object.cd_Cest[ ll_linha ] )
		
		If ls_Cest = "" Then
			ls_CEST = ls_Null
		End If		
		
		This.Object.cd_Cest[ ll_linha ] = ls_CEST
	Next	
End If

Return 1
end event

type dw_relatorio from dc_uo_dw_base within tabpage_1
integer x = 3095
integer y = 804
integer width = 215
integer height = 228
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge442_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;Date lvdt_Inicio
Date lvdt_Termino
		
// Verifica quais os par$$HEX1$$e200$$ENDHEX$$metros informados
Parent.dw_1.AcceptText()

lvdt_Inicio		= Parent.dw_1.Object.Dt_Inicio						[1]
lvdt_Termino	= Parent.dw_1.Object.Dt_Termino					[1]

This.Object.img_logo.Visible 	= (gvo_parametro.cd_filial = gvo_parametro.cd_filial_matriz)
This.Object.st_periodo.Text 	= "Per$$HEX1$$ed00$$ENDHEX$$odo: "+String(lvdt_Inicio,'dd/mm/yyyy')+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdt_Termino,'dd/mm/yyyy')

Return AncestorReturnValue
end event

event ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

event constructor;call super::constructor;This.Visible = False
end event

type cb_cancelar from picturebutton within tabpage_1
integer x = 4110
integer y = 560
integer width = 535
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_cancelar.png"
string disabledname = "S:\Sistemas_PB12\Comuns\Figuras\botao_cancelar_desabilitado.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;Boolean lb_Retrieve = False

String ls_msg
String ls_Prot_Canc
String ls_Especie
String ls_Serie
String ls_Cancela_Sefaz = 'S'
String ls_Motivo
String ls_Prot_Envio
String ls_Chave_Acesso
String ls_Log
String ls_Matric_Cancelamento

Date ldh_emissao
Date ldt_Caixa

Datetime ldh_Cancelamento
Datetime ldh_Caixa

Long ll_row
Long ll_max
Long ll_NF
Long ll_Filial

/*--------
ESTE BOT$$HEX1$$c300$$ENDHEX$$O DEVE FICAR HABILITADO SOMENTE NAS FILIAIS
----------*/

Try
	ll_row = tab_1.tabpage_1.dw_2.GetRow()
	
	IF ll_row <= 0 THEN RETURN 1
	
	ll_Filial				= Parent.dw_2.Object.cd_filial_origem					[ll_row]
	ll_NF					= Parent.dw_2.Object.nr_nf									[ll_row]
	ls_Especie 			= Parent.dw_2.Object.de_especie							[ll_row]
	ls_Serie				= Parent.dw_2.Object.de_serie								[ll_row]
	ls_Prot_Canc 		= Parent.dw_2.Object.nr_protocolo_cancelamento	[ll_row]
	ls_Prot_Envio 		= Parent.dw_2.Object.nr_protocolo_envio				[ll_row]
	ls_Chave_Acesso 	= Parent.dw_2.Object.de_chave_acesso					[ll_row]
	ldh_Cancelamento	= DateTime( Parent.dw_2.Object.dh_cancelamento	[ll_row] )
	ldt_Caixa				= Parent.dw_2.Object.dh_movimentacao_caixa		[ll_row]
	ldh_Emissao 		= Date( Parent.dw_2.Object.dh_emissao					[1] )

	If Not gf_Data_Parametro( ivdt_parametro ) Then Return -1
			
	//NAO Autorizada na SEFAZ
	If IsNull( ls_Prot_Envio ) Or Trim( ls_Prot_Envio ) = '' Then
		ls_msg = "A nota fiscal '" + String(ll_NF) + "' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ AUTORIZADA no Sefaz."
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_msg, Exclamation!)
		Return 1
	End If
	
	//Cfme chamado 311616, se o mes da emissao for inferior ao atual, e o dia for maior ou igual a 2, nao pode cancelar
	If ( Month( ivdt_parametro ) > Month( ldt_Caixa ) ) And Day( ivdt_parametro ) >= 2 Then
		ls_msg = "Expirou o prazo para cancelamento desta nota fiscal.~rNota: " + String(ll_NF) + " ~rEsp$$HEX1$$e900$$ENDHEX$$cie: " + ls_Especie + "~rS$$HEX1$$e900$$ENDHEX$$rie: " + ls_Serie
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_msg, Exclamation! )
		Return 1
	End If
	
	//Cancelada RL e SEFAZ
	If Not IsNull(ldh_Cancelamento) And ( Not IsNull( ls_Prot_Canc ) Or Trim( ls_Prot_Canc ) <> '' ) Then
		ls_msg = "A nota fiscal '" + String(ll_NF) + "', esp$$HEX1$$e900$$ENDHEX$$cie '" + ls_Especie + "', s$$HEX1$$e900$$ENDHEX$$rie '" + ls_Serie + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cancelada."
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_msg, Exclamation!)
		Return 1
	End If
	
	//Se possuir bens de patrimonio n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser cancelada.
	If wf_Possui_Ativo( ll_Filial, ll_NF, ls_Especie, ls_Serie ) Then 
		Return 1
	End If	
	
	//Se a nf foi cancelada no sefaz pelo sistema NFe com esta janela aberta.
	If wf_Cancelada_Sefaz( ls_Chave_Acesso ) Then 
		ls_Cancela_Sefaz = 'N'		
	End If
	
	ls_msg =	 "Confirma cancelamento da nota fiscal " +String( ll_NF ) + " esp$$HEX1$$e900$$ENDHEX$$cie " + ls_Especie +" s$$HEX1$$e900$$ENDHEX$$rie " + ls_Serie+"?"
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", ls_msg, Question!, OKCancel!) = 1 Then

		If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("CANCELAMENTO_NOTAS_FISCAIS", Ref ls_Matric_Cancelamento) Then 
			Return
		End If

		If ls_Cancela_Sefaz = 'S' Then
			//Qtde m$$HEX1$$ed00$$ENDHEX$$nima exigida pela Sefaz --> 15 caracteres
			OpenWithParm( w_justificativa, '15' + 'Informe o motivo do cancelamento:' )
			ls_Motivo = Message.StringParm
			
			If IsNull(ls_Motivo) Then Return
		
			//Cancelamento na SEFAZ
			uo_ge140_cancela_nf_sefaz lo_sefaz
			lo_sefaz = Create uo_ge140_cancela_nf_sefaz
			
			If Not lo_sefaz.of_cancela_nfe( ll_Filial, ls_Chave_Acesso, ls_Prot_Envio, ls_Motivo, Ref ls_Prot_Canc, Ref ls_Log  ) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Log )
				Return
			Else
				Update nf_diversa_nfe
					Set nr_protocolo_cancelamento 	= :ls_Prot_Canc,
						 dh_cancelamento					= GetDate(),
						 nr_matricula_cancelamento	= :ls_Matric_Cancelamento,
						 id_situacao							= 'X'
				 Where	cd_filial_origem	= :ll_Filial
				 	and 	nr_nf					= :ll_NF
					and	de_especie			= :ls_Especie
					and	de_serie				= :ls_Serie
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_RollBack( )
					SqlCa.of_MsgDbError("Erro no cancelamento da nf_diversa_nfe.")
				Else
					//Garantir que as informa$$HEX2$$e700f500$$ENDHEX$$es Cancelamento do sefaz sejam gravadas na tabela "_nfe"
					SqlCa.of_Commit()
				End If
			End If
		End If	
		
		//Verifica se pode cancelar no retaguarda de acordo com a regra do depto fiscal
		If Not gf_ge033_cancela_nf_regra_depto_fiscal( ldt_Caixa ) Then
			Return 1
		End If
		
		Update nf_diversa 	Set dh_cancelamento = dbo.uf_dh_parametro() 
		Where cd_filial_origem	= :ll_Filial
		  and nr_nf      				= :ll_NF
		  and de_especie 			= :ls_Especie
		  and de_serie   			= :ls_Serie
		Using SqlCa;

		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback()
			SqlCa.of_MsgDbError("Erro ao cancelar a nota fiscal " + String(ll_NF) + '.')
		Else
			SqlCa.of_Commit()
			lb_Retrieve = True		
		End If
	End If

Catch (RuntimeError e)
	MessageBox("Erro","Erro ao cancelar a nota fiscal " + String(ll_NF) + ".~r" + &
					 "Erro: " + e.GetMessage(), StopSign!)
	
Finally
	If IsValid(lo_sefaz) Then Destroy lo_sefaz
	If lb_Retrieve Then Parent.dw_2.Event ue_Retrieve()
End Try
end event

type cb_imprimir_nota from commandbutton within tabpage_1
integer x = 4128
integer y = 464
integer width = 535
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Imprimir Nota"
end type

event clicked;dc_uo_ds_base	lds_nota

Long				lvl_Cd_Filial, &
					lvl_Nr_NF
	  
String			lvs_De_Especie, &
					lvs_De_Serie
		 
Integer			lvi_Linha_Ativa, &
					lvi_Linhas
		  
lvi_Linha_Ativa = dw_2.GetRow ()

If lvi_Linha_Ativa = 0 then Return

lds_nota = Create dc_uo_ds_base

Try
	If not lds_nota.of_ChangeDataObject ('dw_ge442_imagem_nota') then Return
	
	lvl_Cd_Filial  = dw_2.Object.Cd_Filial_Origem [lvi_Linha_Ativa]
	lvl_Nr_NF      = dw_2.Object.Nr_NF            [lvi_Linha_Ativa]
	lvs_De_Especie = dw_2.Object.De_Especie       [lvi_Linha_Ativa]
	lvs_De_Serie   = dw_2.Object.De_Serie         [lvi_Linha_Ativa]
	
	lvi_Linhas = lds_nota.Retrieve (lvl_Cd_Filial,  &
											  lvl_Nr_NF,      &
											  lvs_De_Especie, &
											  lvs_De_Serie)
	
	If lvi_Linhas > 0 then
		If PrintSetup () <> 1 then Return
		
		lds_nota.Print (False)
	End if

Finally
	Destroy lds_nota
End try

Return
end event

type cb_copia_chave_acesso from picturebutton within tabpage_2
integer x = 2523
integer y = 1088
integer width = 110
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\Copy.png"
string disabledname = "S:\Sistemas_PB12\Comuns\Figuras\Copy.png"
alignment htextalign = left!
end type

event clicked;Integer lvi_Retorno

dw_3.setColumn( "de_chave_acesso")

dw_3.SelectText(1, 44)

lvi_Retorno = dw_3.Copy()

Choose Case lvi_Retorno
	Case -1  // Vazio
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o foi selecionada para a c$$HEX1$$f300$$ENDHEX$$pia.")
	Case -2  // Erro na c$$HEX1$$f300$$ENDHEX$$pia
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na c$$HEX1$$f300$$ENDHEX$$pia.")
	Case -9  // Erro na c$$HEX1$$f300$$ENDHEX$$pia
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na c$$HEX1$$f300$$ENDHEX$$pia.")
End Choose
end event

