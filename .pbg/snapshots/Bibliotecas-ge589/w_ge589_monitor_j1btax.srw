HA$PBExportHeader$w_ge589_monitor_j1btax.srw
forward
global type w_ge589_monitor_j1btax from dc_w_2tab_consulta_selecao_lista_2det
end type
type cbx_monitorar_retorno from checkbox within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type gb_aguard_ret from groupbox within tabpage_3
end type
type gb_painel from groupbox within tabpage_3
end type
type cbx_monitora from checkbox within tabpage_3
end type
type gb_aguard_aprov from groupbox within tabpage_3
end type
type dw_retorno_pend from dc_uo_dw_base within tabpage_3
end type
type dw_aprovacao_pend from dc_uo_dw_base within tabpage_3
end type
type dw_sel_ambiente from dc_uo_dw_base within tabpage_3
end type
type gb_aguard_env from groupbox within tabpage_3
end type
type dw_envio_pend from dc_uo_dw_base within tabpage_3
end type
type uo_envio from uo_ge589_tarefas within tabpage_3
end type
type uo_retorno from uo_ge589_tarefas within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_aguard_ret gb_aguard_ret
gb_painel gb_painel
cbx_monitora cbx_monitora
gb_aguard_aprov gb_aguard_aprov
dw_retorno_pend dw_retorno_pend
dw_aprovacao_pend dw_aprovacao_pend
dw_sel_ambiente dw_sel_ambiente
gb_aguard_env gb_aguard_env
dw_envio_pend dw_envio_pend
uo_envio uo_envio
uo_retorno uo_retorno
end type
type tabpage_4 from userobject within tab_1
end type
type pb_env_reprocessa from picturebutton within tabpage_4
end type
type gb_env_painel from groupbox within tabpage_4
end type
type p_env_clamed from picture within tabpage_4
end type
type gb_env_aguard from groupbox within tabpage_4
end type
type gb_env_proc from groupbox within tabpage_4
end type
type pb_env_periodo from picturebutton within tabpage_4
end type
type dw_subidas_processadas from dc_uo_dw_base within tabpage_4
end type
type uo_enviadas from uo_ge589_tarefas within tabpage_4
end type
type cbx_env_monitora from checkbox within tabpage_4
end type
type dw_sel_ambiente_env from dc_uo_dw_base within tabpage_4
end type
type dw_subidas_paradas from dc_uo_dw_base within tabpage_4
end type
type tabpage_4 from userobject within tab_1
pb_env_reprocessa pb_env_reprocessa
gb_env_painel gb_env_painel
p_env_clamed p_env_clamed
gb_env_aguard gb_env_aguard
gb_env_proc gb_env_proc
pb_env_periodo pb_env_periodo
dw_subidas_processadas dw_subidas_processadas
uo_enviadas uo_enviadas
cbx_env_monitora cbx_env_monitora
dw_sel_ambiente_env dw_sel_ambiente_env
dw_subidas_paradas dw_subidas_paradas
end type
type tabpage_5 from userobject within tab_1
end type
type p_receb_clamed from picture within tabpage_5
end type
type gb_receb_atualizadas from groupbox within tabpage_5
end type
type pb_reprocessar from picturebutton within tabpage_5
end type
type pb_visualizar_regras from picturebutton within tabpage_5
end type
type pb_receb_periodo from picturebutton within tabpage_5
end type
type gb_receb_aguard from groupbox within tabpage_5
end type
type gb_receb_proc from groupbox within tabpage_5
end type
type cbx_receb_monitora from checkbox within tabpage_5
end type
type dw_regras_atualizadas from dc_uo_dw_base within tabpage_5
end type
type dw_descidas_paradas from dc_uo_dw_base within tabpage_5
end type
type dw_descidas_processadas from dc_uo_dw_base within tabpage_5
end type
type uo_recebidas from uo_ge589_tarefas within tabpage_5
end type
type dw_sel_ambiente_receb from dc_uo_dw_base within tabpage_5
end type
type gb_receb_painel from groupbox within tabpage_5
end type
type tabpage_5 from userobject within tab_1
p_receb_clamed p_receb_clamed
gb_receb_atualizadas gb_receb_atualizadas
pb_reprocessar pb_reprocessar
pb_visualizar_regras pb_visualizar_regras
pb_receb_periodo pb_receb_periodo
gb_receb_aguard gb_receb_aguard
gb_receb_proc gb_receb_proc
cbx_receb_monitora cbx_receb_monitora
dw_regras_atualizadas dw_regras_atualizadas
dw_descidas_paradas dw_descidas_paradas
dw_descidas_processadas dw_descidas_processadas
uo_recebidas uo_recebidas
dw_sel_ambiente_receb dw_sel_ambiente_receb
gb_receb_painel gb_receb_painel
end type
end forward

global type w_ge589_monitor_j1btax from dc_w_2tab_consulta_selecao_lista_2det
string tag = "w_ge589_monitor_j1btax"
integer width = 5787
integer height = 2880
string title = "GE589 - Monitor J1BTAX"
integer maxwidth = 5751
integer maxheight = 2700
end type
global w_ge589_monitor_j1btax w_ge589_monitor_j1btax

type variables
dc_uo_dw_base dw_Selecao
dc_uo_dw_base dw_Lista
dc_uo_dw_base dw_Aprovacao
dc_uo_dw_base dw_Aprovacao_Lista
dc_uo_dw_base dw_Aprovacao_Pend
dc_uo_dw_base dw_Envio_Pend
dc_uo_dw_base dw_Retorno_Pend
dc_uo_dw_base dw_Descidas_Paradas
dc_uo_dw_base dw_Descidas_Processadas
dc_uo_dw_base dw_Regras_Atualizadas
dc_uo_dw_base dw_Subidas_Processadas
dc_uo_dw_base dw_Subidas_Paradas

dc_uo_dw_base dw_Origem_Aprovacao
dc_uo_dw_base dw_Sel_Ambiente
dc_uo_dw_base dw_Sel_Ambiente_Env
dc_uo_dw_base dw_Sel_Ambiente_Receb

Long ivl_nr_controle
Long ivl_oldindex
Boolean ivb_Atualizou_Aprovacao

Long ivl_Segundos_Monitorar = 5
Long ivl_Segundos_qt = 0

uo_ge589_exportacao_j1btax iuo_ge589	
end variables

forward prototypes
public function boolean wf_atualiza_monitoramento ()
public subroutine wf_atualiza_recebidas_sap ()
public function boolean wf_seleciona_aprovacao ()
public function boolean wf_carrega_lista_aprovacao ()
public function long wf_carrega_atualizadas ()
public subroutine wf_atualiza_enviadas_sap ()
public subroutine wf_recolher_atualizadas ()
public subroutine wf_expandir_atualizadas ()
public subroutine wf_inverte_colunas_dh (string ps_coluna_principal, dc_uo_dw_base pdw)
public subroutine wf_resize_tabpage2 ()
public subroutine wf_resize_reset ()
end prototypes

public function boolean wf_atualiza_monitoramento ();DateTime lvdh_Ultimo_Envio, lvdh_Proximo_Envio, lvdh_Ultimo_Retorno, lvdh_Proximo_Retorno
String lvs_Erro, lvs_Mask, lvs_cd_ambiente_sap

This.SetRedraw(False)

// Atualizar datas das tarefas 218 e 221 na tela
Tab_1.TabPage_3.uo_Envio.of_atualiza()
Tab_1.TabPage_3.uo_Retorno.of_atualiza()

// Restaurar SQL
dw_Aprovacao_Pend.of_RestoreOriginalSql()
dw_Envio_Pend.of_RestoreOriginalSql()
dw_Retorno_Pend.of_RestoreOriginalSql()

// Ambiente SAP
If dw_sel_ambiente.RowCount() = 0 Then dw_sel_ambiente.event ue_addrow()
lvs_cd_ambiente_sap = dw_sel_ambiente.GetItemString(1, 'cd_ambiente_sap')
dw_Aprovacao_Pend.of_AppendWhere_SubQuery	("l.cd_ambiente_sap ='"+lvs_cd_ambiente_sap+"'", 4)
dw_Envio_Pend.of_AppendWhere_SubQuery		("l.cd_ambiente_sap ='"+lvs_cd_ambiente_sap+"'", 4)
dw_Retorno_Pend.of_AppendWhere_SubQuery	("l.cd_ambiente_sap ='"+lvs_cd_ambiente_sap+"'", 4)

// Alterar SQL de cada dw cfe. suas condi$$HEX2$$e700e300$$ENDHEX$$o
dw_Aprovacao_Pend.of_AppendWhere_SubQuery	("l.id_situacao_aprovacao = 'P'", 4)
dw_Envio_Pend.of_AppendWhere_SubQuery		("l.id_situacao_aprovacao = 'A' and l.id_situacao_exportacao = 'A'", 4)
dw_Retorno_Pend.of_AppendWhere_SubQuery	("l.id_situacao_exportacao = 'E'", 4)

// Consultar pend$$HEX1$$ea00$$ENDHEX$$ncias
dw_Aprovacao_Pend.Retrieve()
dw_Envio_Pend.Retrieve()
dw_Retorno_Pend.Retrieve()

// Ordena$$HEX2$$e700e300$$ENDHEX$$o
dw_Aprovacao_Pend.SetSort("dh_termino_geracao")
dw_Aprovacao_Pend.Sort()
dw_Envio_Pend.SetSort("dh_aprovacao")
dw_Envio_Pend.Sort()
dw_Retorno_Pend.SetSort("dh_exportacao")
dw_Retorno_Pend.Sort()

This.SetRedraw(True)

Return True
end function

public subroutine wf_atualiza_recebidas_sap ();This.SetRedraw(False)

Tab_1.tabpage_5.uo_recebidas.of_atualiza()

// Ambiente SAP
If dw_sel_ambiente_receb.RowCount() = 0 Then dw_sel_ambiente_receb.event ue_addrow()

dw_Descidas_Paradas.Event ue_Retrieve()
dw_Descidas_Processadas.Event ue_Retrieve()

This.SetRedraw(True)
end subroutine

public function boolean wf_seleciona_aprovacao ();Long lvl_RowLista, lvl_Ret, lvl_For
String lvs_Sit_Aprovacao, lvs_Sit_Exportacao

lvl_RowLista = dw_Origem_Aprovacao.GetRow()

If lvl_RowLista <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um relat$$HEX1$$f300$$ENDHEX$$rio para visualizar as regras.", Exclamation!)
	Return False
End If

lvs_Sit_Aprovacao  = dw_Origem_Aprovacao.GetItemString(lvl_RowLista, "id_situacao_aprovacao")
lvs_Sit_Exportacao = dw_Origem_Aprovacao.GetItemString(lvl_RowLista, "id_situacao_exportacao")

// Pode visualizar "Aprova$$HEX2$$e700e300$$ENDHEX$$o Pend.", "Aprovado" ou "Reprovado".
If Pos("P,A,R,N", lvs_Sit_Aprovacao) = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Permitido apenas para relat$$HEX1$$f300$$ENDHEX$$rios com situa$$HEX2$$e700e300$$ENDHEX$$o "Aprova$$HEX2$$e700e300$$ENDHEX$$o Pendente", "Aprovado" ou "Reprovado".', Exclamation!)
	Return False
End If

// N$$HEX1$$e300$$ENDHEX$$o permite monitorar automaticamente por enquanto
Tab_1.TabPage_2.cbx_monitorar_retorno.enabled = false
Tab_1.TabPage_2.cbx_monitorar_retorno.checked = false

dw_Aprovacao.Reset()

//// Alterado para fazer retrieve nas das datawindows na wf_Carrega_Lista_Aprovacao
//// Copia o controle selecionado para a aba Aprova$$HEX2$$e700e300$$ENDHEX$$o
//lvl_Ret = dw_Origem_Aprovacao.RowsCopy(lvl_RowLista, lvl_RowLista, Primary!, dw_Aprovacao, 1, Primary!) 
//If lvl_Ret = -1 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar os dados para aprova$$HEX2$$e700e300$$ENDHEX$$o!", StopSign!)
//	Return False
//End If
	
// Carrega a lista de regras do controle
ivl_nr_controle = dw_Origem_Aprovacao.GetItemNumber(lvl_RowLista, "nr_controle")
If Not wf_Carrega_Lista_Aprovacao() Then Return False

Choose Case lvs_Sit_Aprovacao 
	Case 'P' // pendente
		
		// Marca todos para aprova$$HEX2$$e700e300$$ENDHEX$$o.
		For lvl_For = 1 to dw_Aprovacao_Lista.RowCount()
			dw_Aprovacao_Lista.SetItem(lvl_For, "id_aprovado", 'S')
		Next
		ivm_Menu.mf_Confirmar(True) // Libera o bot$$HEX1$$e300$$ENDHEX$$o "Aprovar"
		
	Case 'A' // aprovado
		
		// Se j$$HEX1$$e100$$ENDHEX$$ foi enviado e est$$HEX1$$e100$$ENDHEX$$ aguardando retorno
		If lvs_Sit_Exportacao = 'E' Then 
			Tab_1.TabPage_2.cbx_monitorar_retorno.enabled = true // libera o monitoramento
			wf_inverte_colunas_dh("dh_exportacao", dw_Aprovacao) // traz a data de envio pra tela
		Else
			wf_inverte_colunas_dh("dh_aprovacao", dw_Aprovacao)  // traz a data de aprova$$HEX2$$e700e300$$ENDHEX$$o pra tela
		End If
		
End Choose

dw_Aprovacao_Lista.Post SetFocus()

Return True
end function

public function boolean wf_carrega_lista_aprovacao ();Long lvl_Ret

// Carrega o cabe$$HEX1$$e700$$ENDHEX$$alho
lvl_Ret = dw_Aprovacao.Event ue_Retrieve()
If lvl_Ret = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O relat$$HEX1$$f300$$ENDHEX$$rio selecionado n$$HEX1$$e300$$ENDHEX$$o possui regras para aprova$$HEX2$$e700e300$$ENDHEX$$o!!", Exclamation!)
	Return False
ElseIf lvl_Ret = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar os dados para aprova$$HEX2$$e700e300$$ENDHEX$$o!", StopSign!)
	Return False
End If

// Carrega as regras
lvl_Ret = dw_Aprovacao_Lista.Event ue_Retrieve() 
If lvl_Ret = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O relat$$HEX1$$f300$$ENDHEX$$rio selecionado n$$HEX1$$e300$$ENDHEX$$o possui regras para aprova$$HEX2$$e700e300$$ENDHEX$$o!", Exclamation!)
	Return False
ElseIf lvl_Ret = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar os dados para aprova$$HEX2$$e700e300$$ENDHEX$$o!", StopSign!)
	Return False
End If



//// Se recuperar todos em um relat$$HEX1$$f300$$ENDHEX$$rio APROVADO e n$$HEX1$$e300$$ENDHEX$$o tiver pend$$HEX1$$ea00$$ENDHEX$$ncia de retorno
//// Atualizar o cabe$$HEX1$$e700$$ENDHEX$$alho e a dw origem
//If dw_Aprovacao.GetItemString(dw_Aprovacao.GetRow(), "id_situacao_aprovacao") = 'A' Then
//	// Apenas quando alguma regra j$$HEX1$$e100$$ENDHEX$$ subiu pro SAP
//	If dw_Aprovacao_Lista.Find("Not isNull(dh_exportacao)", 1, dw_Aprovacao_Lista.RowCount()) > 0 Then
//		// Sem pend$$HEX1$$ea00$$ENDHEX$$ncia de retorno
//		If dw_Aprovacao_Lista.Find("id_aprovado = 'S' and isNull(dh_retorno_sap)", 1, dw_Aprovacao_Lista.RowCount()) = 0 Then
//			// Finalizado
//			dw_Aprovacao.SetItem(1, "id_situacao_exportacao", 'F')
//			dw_Origem_Aprovacao.SetItem(dw_Origem_Aprovacao.GetRow(), "id_situacao_exportacao", 'F')
//			dw_Origem_Aprovacao.SetItem(dw_Origem_Aprovacao.GetRow(), "dh_exportacao", Now())
//			ivb_Atualizou_Aprovacao = True
//		End If
//	End If
//End If

Return True
end function

public function long wf_carrega_atualizadas ();Long lvl_Row

lvl_Row  = dw_Descidas_Processadas.GetRow()

If lvl_Row > 0 Then
	Return dw_Regras_Atualizadas.Event ue_Retrieve()
End If

Return 0
end function

public subroutine wf_atualiza_enviadas_sap ();This.SetRedraw(False)

Tab_1.tabpage_4.uo_enviadas.of_atualiza()

// Ambiente SAP
If dw_sel_ambiente_env.RowCount() = 0 Then dw_sel_ambiente_env.event ue_addrow()

dw_Subidas_Paradas.Event ue_Retrieve()
dw_Subidas_Processadas.Event ue_Retrieve()

This.SetRedraw(True)
end subroutine

public subroutine wf_recolher_atualizadas ();Tab_1.TabPage_5.gb_Receb_Atualizadas.Hide()
dw_Regras_Atualizadas.Hide()

Tab_1.TabPage_5.pb_visualizar_regras.PowerTipText = "Mostrar regras atualizadas"
Tab_1.TabPage_5.pb_visualizar_regras.Tag = "contraido"
Tab_1.TabPage_5.pb_visualizar_regras.PictureName = "S:\Sistemas_PB12\Comuns\Figuras\Expandir16Cinza.bmp"
end subroutine

public subroutine wf_expandir_atualizadas ();Tab_1.TabPage_5.gb_Receb_Atualizadas.Show()
dw_Regras_Atualizadas.Show()

Tab_1.TabPage_5.pb_visualizar_regras.PowerTipText = "Esconder regras atualizadas"
Tab_1.TabPage_5.pb_visualizar_regras.Tag = "expandido"
Tab_1.TabPage_5.pb_visualizar_regras.PictureName = "S:\Sistemas_PB12\Comuns\Figuras\Contrair16Cinza.bmp"
end subroutine

public subroutine wf_inverte_colunas_dh (string ps_coluna_principal, dc_uo_dw_base pdw);String xGerado, xAprovado, xEnviado

xGerado 		= pdw.Object.dh_inicio_geracao.x

Choose Case ps_coluna_principal
	Case 'dh_aprovacao' // Inverter posi$$HEX2$$e700e300$$ENDHEX$$o dos campos "Gerado em" e "Aprovado em"

		xAprovado 	= pdw.Object.dh_aprovacao.x
		
		pdw.Object.dh_inicio_geracao_t.x	= xAprovado
		pdw.Object.dh_inicio_geracao.x		= xAprovado
		pdw.Object.dh_aprovacao_t.x 			= xGerado
		pdw.Object.dh_aprovacao.x 				= xGerado
		pdw.Object.dh_aprovacao_t.text		= "Aprovado em"
		
	Case 'dh_exportacao' // Inverter posi$$HEX2$$e700e300$$ENDHEX$$o dos campos "Gerado em" e "Enviado ao SAP em"
		
		xEnviado 	= pdw.Object.dh_exportacao.x
		
		pdw.Object.dh_inicio_geracao_t.x		= xEnviado
		pdw.Object.dh_inicio_geracao.x		= xEnviado
		pdw.Object.dh_exportacao_t.x 			= xGerado
		pdw.Object.dh_exportacao.x 			= xGerado
		
End Choose
end subroutine

public subroutine wf_resize_tabpage2 ();Long ll_espaco = 50

Tab_1.TabPage_2.Width = Tab_1.Width - 25
Tab_1.TabPage_2.gb_3.Width = Tab_1.TabPage_2.Width 		- ll_espaco
Tab_1.TabPage_2.dw_3.Width = Tab_1.TabPage_2.gb_3.Width 	- ll_espaco
Tab_1.TabPage_2.gb_4.Width = Tab_1.TabPage_2.Width 		- ll_espaco
Tab_1.TabPage_2.dw_4.Width = Tab_1.TabPage_2.gb_4.Width 	- ll_espaco
end subroutine

public subroutine wf_resize_reset ();This.Width = MaxWidth
This.Height = MaxHeight
end subroutine

on w_ge589_monitor_j1btax.create
int iCurrent
call super::create
end on

on w_ge589_monitor_j1btax.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;ivl_altura_1 = MaxHeight -344
ivl_altura_2 = MaxHeight -344
ivl_largura_1 = MaxWidth -123
ivl_largura_2 = MaxWidth -123

dw_Selecao 				= Tab_1.TabPage_1.dw_1
dw_Lista					= Tab_1.TabPage_1.dw_2

dw_Aprovacao			= Tab_1.TabPage_2.dw_3
dw_Aprovacao_Lista	= Tab_1.TabPage_2.dw_4

dw_Aprovacao_Pend		= Tab_1.TabPage_3.dw_aprovacao_pend
dw_envio_pend			= Tab_1.TabPage_3.dw_envio_pend
dw_retorno_pend		= Tab_1.TabPage_3.dw_retorno_pend
dw_Sel_Ambiente		= Tab_1.TabPage_3.dw_sel_ambiente

dw_Subidas_Paradas		= Tab_1.tabpage_4.dw_Subidas_Paradas
dw_Subidas_Processadas	= Tab_1.tabpage_4.dw_Subidas_Processadas
dw_Sel_Ambiente_Env		= Tab_1.tabpage_4.dw_Sel_Ambiente_Env

dw_Descidas_Paradas		= Tab_1.tabpage_5.dw_Descidas_Paradas
dw_Descidas_Processadas	= Tab_1.tabpage_5.dw_Descidas_Processadas
dw_Regras_Atualizadas	= Tab_1.tabpage_5.dw_Regras_Atualizadas
dw_Sel_Ambiente_Receb	= Tab_1.tabpage_5.dw_Sel_Ambiente_Receb

ivm_Menu.ivb_permite_localizar = false

iuo_ge589 = Create uo_ge589_exportacao_j1btax

dw_Sel_Ambiente.ShareData(dw_Sel_Ambiente_Env)
dw_Sel_Ambiente.ShareData(dw_Sel_Ambiente_Receb)


end event

event ue_presave;call super::ue_presave;Integer lvi_Ret
String lvs_Msg

// Defensiva
If iuo_ge589.of_Get_id_situacao_aprovacao(ivl_nr_controle) <> 'P' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Aprova$$HEX2$$e700e300$$ENDHEX$$o permitida apenas para "Aprova$$HEX2$$e700e300$$ENDHEX$$o Pendente".', Exclamation!)
	Tab_1.SelectedTab = ivl_oldindex
	Return False
End If

// Confirma$$HEX2$$e700e300$$ENDHEX$$o - se aprovou algum
If dw_Aprovacao_Lista.Find("id_aprovado = 'S'", 1, dw_Aprovacao_Lista.RowCount()) > 0 Then
	lvs_Msg = "Confirma o envio das regras aprovadas para o SAP?"
Else // reprovou todas
	lvs_Msg = "Nenhuma regra aprovada.~r~rConfirma a reprova$$HEX2$$e700e300$$ENDHEX$$o do relat$$HEX1$$f300$$ENDHEX$$rio?"
End If
lvi_Ret = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Msg, Question!, YesNo!)
If lvi_Ret = 2 Then Return False // Cancelou

Return True
end event

event close;call super::close;Destroy iuo_ge589
end event

event timer;call super::timer;ivl_Segundos_qt++

// Aba "Aprova$$HEX2$$e700e300$$ENDHEX$$o"
If Tab_1.Selectedtab = 2 Then
	// Apenas se stiver com "Monitorar Retorno" marcado
	If Tab_1.TabPage_2.cbx_monitorar_retorno.checked Then
		If ivl_Segundos_qt >= ivl_Segundos_Monitorar Then
			// Cancela o autom$$HEX1$$e100$$ENDHEX$$tico se der erro
			If Not wf_Carrega_Lista_Aprovacao() Then
				Timer(0)
				Tab_1.TabPage_2.cbx_monitorar_retorno.Checked = False
			End If
			ivl_Segundos_qt = 0
		End If
		Tab_1.TabPage_2.cbx_monitorar_retorno.Text = "Monitorar retorno"+Fill('.', ivl_Segundos_qt)
		Tab_1.TabPage_2.cbx_monitorar_retorno.TextColor = Tab_1.TabPage_2.cbx_monitorar_retorno.TextColor
	End If
End If


// Aba "Monitoramento"
If Tab_1.Selectedtab = 3 Then
	// Apenas se stiver com "Monitoramento Ativo" marcado
	If Tab_1.TabPage_3.cbx_monitora.checked Then
		If ivl_Segundos_qt >= ivl_Segundos_Monitorar Then
			wf_Atualiza_Monitoramento( )
			ivl_Segundos_qt = 0
		End If
		Tab_1.TabPage_3.cbx_monitora.Text = "Monitoramento ativo"+Fill('.', ivl_Segundos_qt)
		Tab_1.TabPage_3.cbx_monitora.TextColor = Tab_1.TabPage_3.cbx_monitora.TextColor
	End If
End If


// Aba "Envios Sybase -> SAP"
If Tab_1.Selectedtab = 4 Then
// Apenas se stiver com "Monitorar recebimentos" marcado
	If Tab_1.TabPage_4.cbx_env_monitora.checked Then
		If ivl_Segundos_qt >= ivl_Segundos_Monitorar Then
			wf_Atualiza_Enviadas_SAP( )
			ivl_Segundos_qt = 0
		End If
		Tab_1.TabPage_4.cbx_env_monitora.Text = "Monitorar envios"+Fill('.', ivl_Segundos_qt)
		Tab_1.TabPage_4.cbx_env_monitora.TextColor = Tab_1.TabPage_4.cbx_env_monitora.TextColor
	End If
End If


// Aba "Recebimentos SAP -> Sybase"
If Tab_1.Selectedtab = 5 Then
	// Apenas se stiver com "Monitorar recebimentos" marcado
	If Tab_1.TabPage_5.cbx_receb_monitora.checked Then
		If ivl_Segundos_qt >= ivl_Segundos_Monitorar Then
			wf_Atualiza_Recebidas_SAP()
			ivl_Segundos_qt = 0
		End If
		Tab_1.TabPage_5.cbx_receb_monitora.Text = "Monitorar recebimentos"+Fill('.', ivl_Segundos_qt)
		Tab_1.TabPage_5.cbx_receb_monitora.TextColor = Tab_1.TabPage_5.cbx_receb_monitora.TextColor
	End If
End If
end event

event ue_save;Boolean 	lb_Todas_Aprovadas, lb_Todas_Reprovadas
Long 		lvl_Row_Aba_Orig
String 	lvs_Aprovacao

Try
	dw_Aprovacao_Lista.SetFilter("")
	dw_Aprovacao_Lista.Filter()
	
	// Valida$$HEX2$$e700f500$$ENDHEX$$es
	If Not This.Event ue_PreSave() Then Return -1
	
	uo_ge589_exportacao_j1btax luo_Exportacao
	luo_Exportacao = Create uo_ge589_exportacao_j1btax
	luo_Exportacao.of_Inicializa( dw_Aprovacao.GetItemString(1, "cd_tabela_sap") )
	luo_Exportacao.of_SetDwRegras(dw_Aprovacao_Lista)
	
	lb_Todas_Aprovadas  = (dw_Aprovacao_Lista.Find("id_aprovado = 'N'", 1, dw_Aprovacao_Lista.RowCount()) = 0) // Nenhuma reprovada
	lb_Todas_Reprovadas = (dw_Aprovacao_Lista.Find("id_aprovado = 'S'", 1, dw_Aprovacao_Lista.RowCount()) = 0) // Nenhuma aprovada
	
	If Not luo_Exportacao.of_Aprovar_Subida(ivl_nr_controle, dw_Aprovacao.GetItemString(1, "cd_ambiente_sap"), Ref lb_Todas_Aprovadas, Ref lb_Todas_Reprovadas) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Falha ao aprovar a subida das regras para o SAP.~r"+luo_Exportacao.ivs_Log, StopSign!)
		Return -1
	End If
	
	// Recarregar as regras para atualizar seus status atuais
	dw_Aprovacao_Lista.Event ue_Retrieve()
	
	// Se reprovou todas, reprovar o relat$$HEX1$$f300$$ENDHEX$$rio
	If lb_Todas_Reprovadas Then
		lvs_Aprovacao = 'R'
	Else // Sen$$HEX1$$e300$$ENDHEX$$o, aprovar
		lvs_Aprovacao = 'A'
	End If
	
	dw_Aprovacao.SetItem(1, "id_situacao_aprovacao", lvs_Aprovacao)
	dw_Aprovacao.SetItem(1, "nm_responsavel_aprovacao", gvo_Aplicacao.ivo_seguranca.Nm_Usuario)
	dw_Aprovacao.SetItem(1, "dh_aprovacao", Now())
	
	// Procurar o controle na outra aba, se estiver l$$HEX1$$e100$$ENDHEX$$, tamb$$HEX1$$e900$$ENDHEX$$m atualiza na tela
	lvl_Row_Aba_Orig = dw_Lista.Find("nr_controle = "+String(ivl_nr_controle), 1, dw_Lista.RowCount())
	If lvl_Row_Aba_Orig > 0 Then
		dw_Lista.SetItem(lvl_Row_Aba_Orig, "id_situacao_aprovacao", lvs_Aprovacao)
		dw_Lista.SetItem(lvl_Row_Aba_Orig, "nm_responsavel_aprovacao", gvo_Aplicacao.ivo_seguranca.Nm_Usuario)
		dw_Lista.SetItem(lvl_Row_Aba_Orig, "dh_aprovacao", Now())
	End If
	
	ivm_Menu.mf_Confirmar(False) // Desabilita o salvar
	
	// Se reprovou todas, avisar que o relat$$HEX1$$f300$$ENDHEX$$rio foi reprovado com sucesso
	If lvs_Aprovacao = 'R' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Relat$$HEX1$$f300$$ENDHEX$$rio reprovado!~r~rNenhuma das regras ser$$HEX1$$e100$$ENDHEX$$ enviada ao SAP.")
	Else // Sen$$HEX1$$e300$$ENDHEX$$o, avisar que foi aprovado
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Subida aprovada!~r~rPor gentileza aguarde o envio das regras aprovadas ao SAP.")
	End If
	
	ivb_Atualizou_Aprovacao = True
	
	Return 1
Finally
	Destroy luo_Exportacao
End Try
end event

event ue_saveas;call super::ue_saveas;MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados ser$$HEX1$$e300$$ENDHEX$$o exportados apenas para confer$$HEX1$$ea00$$ENDHEX$$ncia.~r~rA planilha gerada n$$HEX1$$e300$$ENDHEX$$o deve ser inserida no SAP.")

dw_Aprovacao_Lista.SaveAs()
end event

event resize;call super::resize;If Tab_1.Width <> (This.Width - 100) Then Tab_1.Width = (This.Width - 100) // Largura Tab

// Permite resize horizontal na aba Aprova$$HEX2$$e700e300$$ENDHEX$$o
If Tab_1.SelectedTab = 2 Then
	This.Height = MaxHeight // n$$HEX1$$e300$$ENDHEX$$o faz resize vertical
	wf_resize_tabpage2()
Else // Nas outras reseta 
	wf_resize_reset()
End If
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_2det`dw_visual within w_ge589_monitor_j1btax
integer width = 1664
integer height = 192
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_2det`gb_aux_visual within w_ge589_monitor_j1btax
integer width = 1755
integer height = 280
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_2det`tab_1 within w_ge589_monitor_j1btax
integer x = 18
integer y = 4
integer width = 5586
integer height = 2684
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

event tab_1::selectionchanging;Long 		lvl_Ret, lvl_RowLista
String 	lvs_Sit_Aprovacao
dc_uo_dw_base ldw_Origem_Aprovacao

// Desabilita (habilita s$$HEX1$$f300$$ENDHEX$$ na aba 2)
ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_SalvarComo(False)
ivm_Menu.mf_Filtrar(False)

ivm_Menu.mf_Recuperar(False) // Hab. S$$HEX1$$f300$$ENDHEX$$ na aba 1

Choose Case newIndex
	Case 1 // Sele$$HEX2$$e700e300$$ENDHEX$$o
		dw_Lista.Post SetFocus()
		ivm_Menu.mf_Recuperar(True)
		
	Case 2 // Aprova$$HEX2$$e700e300$$ENDHEX$$o/Envio
		ivb_Atualizou_Aprovacao = False
		If Not wf_Seleciona_Aprovacao() Then
			Return 1 // N$$HEX1$$e300$$ENDHEX$$o deixa mudar para a aba
		End If
		dw_Aprovacao_Lista.SetFocus()
		
	Case 3 // Monitoramento
		If oldindex <> 2 Or ivb_Atualizou_Aprovacao or dw_sel_ambiente.rowcount()=0 Then 
			wf_Atualiza_Monitoramento()
		End If
	
	Case 4 // Envios Syb -> SAP
		wf_Atualiza_Enviadas_Sap()
	
	Case 5 // Recebimentos SAP -> Syb
		wf_Atualiza_Recebidas_Sap()
		
End Choose

Return 0 // Deixa mudar para a aba
end event

event tab_1::selectionchanged;// N$$HEX1$$e300$$ENDHEX$$o precisa mexer na altura e largura aqui
ivl_oldindex = oldindex

If newIndex = 2 Then 
	wf_resize_tabpage2()
Else
	wf_resize_reset()
End If
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_1 within tab_1
integer width = 5550
integer height = 2568
end type

type gb_2 from dc_w_2tab_consulta_selecao_lista_2det`gb_2 within tabpage_1
integer width = 5504
integer height = 2036
string text = "Relat$$HEX1$$f300$$ENDHEX$$rios"
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_2det`gb_1 within tabpage_1
integer width = 4238
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_2det`dw_1 within tabpage_1
integer y = 56
integer width = 4155
integer height = 296
string dataobject = "dw_ge589_monitor_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;String lvdhNull

Choose Case dwo.Name
	Case 'id_revisao'
		SetNull(lvdhNull)
		This.SetItem(1, 'dh_revisao', lvdhNull)
		
End Choose

dw_Lista.Reset()
end event

event dw_1::ue_addrow;SUPER::Event ue_AddRow()

Int li_row, li_total_rows, li_find_result
String ls_grupo

DataWindowChild	ldwc_Child
ldwc_Child  = This.of_InsertRow_DDDW("id_grupo" )			

ldwc_Child.SetItem(1, "cd_grupo", "TODOS")
ldwc_Child.SetItem(1, "de_grupo", "TODOS")

li_total_rows = ldwc_Child.RowCount()

// Apagar grupos repetidos (para n$$HEX1$$e300$$ENDHEX$$o precisar de manuten$$HEX2$$e700e300$$ENDHEX$$o futura no SQL)
FOR li_row = 1 TO li_total_rows
	ls_grupo = ldwc_Child.GetItemString(li_row, "cd_grupo")
	li_find_result = ldwc_Child.Find("cd_grupo = '" + ls_grupo + "'", li_row + 1, li_total_rows)
	DO WHILE li_find_result > 0 // apaga as encontradas
		ldwc_Child.DeleteRow(li_find_result)
		li_total_rows --
		li_find_result = ldwc_Child.Find("cd_grupo = '" + ls_grupo + "'", li_row + 1, li_total_rows)
	LOOP
NEXT

This.Setitem(1, 'id_grupo', "TODOS")

Return 1
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_2det`dw_2 within tabpage_1
integer y = 460
integer width = 5435
integer height = 1916
string dataobject = "dw_ge589_monitor_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_id_imposto
String lvs_id_grupo
String lvs_id_modulo
String lvs_id_revisao
String lvs_cd_ambiente_sap
String lvs_id_situacao, lvs_Where_Situacao

DateTime	lvdh_inicio
DateTime lvdh_revisao
DateTime lvdh_geracao

dw_1.AcceptText()

// Strings

lvs_cd_ambiente_sap = dw_1.GetItemString(1, 'cd_ambiente_sap')
This.of_AppendWhere_SubQuery("l.cd_ambiente_sap ='"+lvs_cd_ambiente_sap+"'", 4)

lvs_id_imposto = dw_1.GetItemString(1, 'id_imposto')
If lvs_id_imposto <> "TODOS" Then
	This.of_AppendWhere_SubQuery("l.id_imposto ='"+lvs_id_imposto+"'", 4)
End If

lvs_id_grupo = dw_1.GetItemString(1, 'id_grupo')
If lvs_id_grupo <> "TODOS" Then
	This.of_AppendWhere_SubQuery("l.id_grupo ='"+lvs_id_grupo+"'", 4)
End If

lvs_id_modulo = dw_1.GetItemString(1, 'id_modulo')
If lvs_id_modulo <> "TODOS" Then
	This.of_AppendWhere_SubQuery("l.id_modulo ='"+lvs_id_modulo+"'", 4)
End If

lvs_id_revisao = dw_1.GetItemString(1, 'id_revisao')
If lvs_id_revisao <> "A" Then // Dif Ambos
	This.of_AppendWhere_SubQuery("l.id_revisao ='"+lvs_id_revisao+"'", 4)
End If

// Situa$$HEX2$$e700f500$$ENDHEX$$es	
lvs_id_situacao = dw_1.GetItemString(1, 'id_situacao')
If lvs_id_situacao <> "TODAS" Then
	Choose Case lvs_id_situacao
		Case 'X'  // Erro
			lvs_Where_Situacao = "( l.id_situacao_relatorio = 'X' or" +&
										"  l.id_situacao_aprovacao = 'X' or"+&
										"  l.id_situacao_exportacao = 'X' )"
			
		Case 'GG' // Gerado
			lvs_Where_Situacao = "l.id_situacao_relatorio = 'G'"
			
		Case 'GA' // Confirmado
			lvs_Where_Situacao = "l.id_situacao_relatorio = 'C'"
			
		Case 'AP' // Aprova$$HEX2$$e700e300$$ENDHEX$$o Pend.
			lvs_Where_Situacao = "l.id_situacao_aprovacao = 'P'"
			
		Case 'AA' // Aprovado
			lvs_Where_Situacao = "l.id_situacao_aprovacao = 'A'"
		
		Case 'AR' // Reprovado
			lvs_Where_Situacao = "l.id_situacao_aprovacao = 'R'"
			
		Case 'EA' // Envio Pend.
			lvs_Where_Situacao = "l.id_situacao_aprovacao = 'A' and l.id_situacao_exportacao = 'A'"
			
		Case 'EE' // Enviado
			lvs_Where_Situacao = "l.id_situacao_exportacao = 'E'"
			
		Case 'EF' // Finalizado
			lvs_Where_Situacao = "l.id_situacao_exportacao = 'F'"
			
	End Choose
	
	This.of_AppendWhere_SubQuery(lvs_Where_Situacao, 4)
	
End If


// Datas

lvdh_inicio = dw_1.GetItemDateTime(1, 'dt_inicio')
If Not IsNull(lvdh_inicio) Then
	This.of_AppendWhere_SubQuery("l.dh_inicio = '"+String(lvdh_inicio, "yyyy-mm-dd")+"'", 4)
End If

lvdh_revisao = dw_1.GetItemDateTime(1, 'dh_revisao')
If Not IsNull(lvdh_revisao) And lvs_id_revisao = 'S' Then
	This.of_AppendWhere_SubQuery("'"+String(lvdh_revisao, "yyyy-mm-dd")+"' BETWEEN Cast(l.dh_revisao_ini as Date) and Cast(l.dh_revisao_fim as Date)", 4)
End If

lvdh_geracao = dw_1.GetItemDateTime(1, 'dh_geracao')
If Not IsNull(lvdh_geracao) Then
	This.of_AppendWhere_SubQuery("'"+String(lvdh_geracao, "yyyy-mm-dd")+"' BETWEEN Cast(l.dh_inicio_geracao as Date) and Cast(l.dh_termino_geracao as Date)", 4)
End If


Return This.Retrieve()
end event

event dw_2::getfocus;call super::getfocus;This.ivo_controle_menu.ivb_salvarcomo 	= false
This.ivo_controle_menu.ivb_filtrar 		= false
This.ivo_controle_menu.ivb_Localizar 	= false
This.ivo_controle_menu.ivb_classificar	= (This.RowCount() > 0)

dw_Origem_Aprovacao = This
end event

event dw_2::doubleclicked;call super::doubleclicked;if row = 0 then return

Tab_1.SelectedTab = 2
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_2 within tab_1
integer width = 5550
integer height = 2568
string text = "Aprova$$HEX2$$e700e300$$ENDHEX$$o"
cbx_monitorar_retorno cbx_monitorar_retorno
end type

on tabpage_2.create
this.cbx_monitorar_retorno=create cbx_monitorar_retorno
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_monitorar_retorno
end on

on tabpage_2.destroy
call super::destroy
destroy(this.cbx_monitorar_retorno)
end on

type gb_4 from dc_w_2tab_consulta_selecao_lista_2det`gb_4 within tabpage_2
integer y = 468
integer width = 5504
integer height = 1952
string text = "Regras"
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_2det`gb_3 within tabpage_2
integer width = 5504
integer height = 360
string text = "Relat$$HEX1$$f300$$ENDHEX$$rio"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_2det`dw_3 within tabpage_2
integer x = 64
integer y = 92
integer width = 5358
integer height = 236
string dataobject = "dw_ge589_monitor_lista"
boolean hscrollbar = true
end type

event dw_3::constructor;call super::constructor;This.Modify("DataWindow.Footer.Height='0'")
end event

event dw_3::ue_preretrieve;call super::ue_preretrieve;This.of_AppendWhere_SubQuery("l.nr_controle = "+String(ivl_nr_controle), 4)

Return 1
end event

type dw_4 from dc_w_2tab_consulta_selecao_lista_2det`dw_4 within tabpage_2
integer y = 540
integer width = 5435
integer height = 1836
string dataobject = "dw_ge589_monitor_aprov_lista"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_4::constructor;call super::constructor;This.of_SetRowSelection()
This.of_SetSort()
This.of_SetFilter()
end event

event dw_4::doubleclicked;call super::doubleclicked;Boolean	lvb_Check
String	lvs_id_aprovado
Long		ll_Row

// Marca ou desmarca aprova$$HEX2$$e700e300$$ENDHEX$$o em massa
If dwo.Name = 'p_aprova_reprova' Then
	// Deixa alterar apenas se aprova$$HEX2$$e700e300$$ENDHEX$$o pendente
	If This.GetItemString(1, "id_situacao_aprovacao") = 'P' Then
		lvb_Check = (This.Describe("p_aprova_reprova.tag") = "todas")
		If lvb_Check Then
			lvs_id_aprovado = 'N'
			This.Modify("p_aprova_reprova.tag='nenhuma'")
		Else
			lvs_id_aprovado = 'S'
			This.Modify("p_aprova_reprova.tag='todas'")
		End If
		
		Open(w_aguarde)
		
		w_aguarde.uo_progress.of_setmax(This.RowCount())
		w_aguarde.title = 'Aguarde... '+iif(lvs_id_aprovado='S', "Marcando", "Desmarcando") +  " todas..."
		
		For ll_Row = 1 To This.RowCount()
			// Atualizar w_aguarde na primeira, ultima e a cada 1%
			if (ll_Row = 1 Or ll_Row = This.RowCount()) Or Mod(ll_Row, Long(This.RowCount()/100)+1) = 0 Then
				w_aguarde.uo_progress.of_SetProgress(ll_Row)
				yield()
			End If
			This.SetItem(ll_Row, "id_aprovado", lvs_id_aprovado)
		Next
		
		Close(w_aguarde)
		
	End If
	
End If		
end event

event dw_4::ue_recuperar;This.SetFilter("")
Return This.Retrieve(ivl_nr_controle)
end event

event dw_4::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.Modify("p_aprova_reprova.tag='todas'")
End If

Return pl_Linhas
end event

event dw_4::getfocus;call super::getfocus;This.ivo_controle_menu.ivb_salvarcomo 	= true
This.ivo_controle_menu.ivb_classificar	= true
This.ivo_controle_menu.ivb_filtrar 		= true


end event

type cbx_monitorar_retorno from checkbox within tabpage_2
integer x = 23
integer y = 396
integer width = 581
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Monitorar retorno"
end type

event clicked;If This.Checked Then
	If wf_Carrega_Lista_Aprovacao() Then
		Timer(1)
	End If
Else
	Timer(0)
End If
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 5550
integer height = 2568
long backcolor = 67108864
string text = "Monitoramento"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
gb_aguard_ret gb_aguard_ret
gb_painel gb_painel
cbx_monitora cbx_monitora
gb_aguard_aprov gb_aguard_aprov
dw_retorno_pend dw_retorno_pend
dw_aprovacao_pend dw_aprovacao_pend
dw_sel_ambiente dw_sel_ambiente
gb_aguard_env gb_aguard_env
dw_envio_pend dw_envio_pend
uo_envio uo_envio
uo_retorno uo_retorno
end type

on tabpage_3.create
this.gb_aguard_ret=create gb_aguard_ret
this.gb_painel=create gb_painel
this.cbx_monitora=create cbx_monitora
this.gb_aguard_aprov=create gb_aguard_aprov
this.dw_retorno_pend=create dw_retorno_pend
this.dw_aprovacao_pend=create dw_aprovacao_pend
this.dw_sel_ambiente=create dw_sel_ambiente
this.gb_aguard_env=create gb_aguard_env
this.dw_envio_pend=create dw_envio_pend
this.uo_envio=create uo_envio
this.uo_retorno=create uo_retorno
this.Control[]={this.gb_aguard_ret,&
this.gb_painel,&
this.cbx_monitora,&
this.gb_aguard_aprov,&
this.dw_retorno_pend,&
this.dw_aprovacao_pend,&
this.dw_sel_ambiente,&
this.gb_aguard_env,&
this.dw_envio_pend,&
this.uo_envio,&
this.uo_retorno}
end on

on tabpage_3.destroy
destroy(this.gb_aguard_ret)
destroy(this.gb_painel)
destroy(this.cbx_monitora)
destroy(this.gb_aguard_aprov)
destroy(this.dw_retorno_pend)
destroy(this.dw_aprovacao_pend)
destroy(this.dw_sel_ambiente)
destroy(this.gb_aguard_env)
destroy(this.dw_envio_pend)
destroy(this.uo_envio)
destroy(this.uo_retorno)
end on

type gb_aguard_ret from groupbox within tabpage_3
integer x = 23
integer y = 1628
integer width = 5504
integer height = 780
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Aguardando Retorno..."
end type

type gb_painel from groupbox within tabpage_3
integer x = 23
integer y = 12
integer width = 5504
integer height = 188
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Painel"
end type

type cbx_monitora from checkbox within tabpage_3
integer x = 1673
integer y = 84
integer width = 814
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Monitoramento ativo"
end type

event clicked;If This.Checked Then
	wf_Atualiza_Monitoramento()
	Timer(1)
Else
	Timer(0)
End If
end event

type gb_aguard_aprov from groupbox within tabpage_3
integer x = 23
integer y = 220
integer width = 5504
integer height = 584
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Aguardando Aprova$$HEX2$$e700e300$$ENDHEX$$o..."
end type

type dw_retorno_pend from dc_uo_dw_base within tabpage_3
integer x = 64
integer y = 1808
integer width = 5426
integer height = 556
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge589_monitor_lista"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()

Post wf_inverte_colunas_dh("dh_exportacao", This) // traz a data de envio pra tela
end event

event getfocus;call super::getfocus;dw_Origem_Aprovacao = This
end event

event doubleclicked;call super::doubleclicked;if row = 0 then return

Tab_1.SelectedTab = 2
end event

type dw_aprovacao_pend from dc_uo_dw_base within tabpage_3
integer x = 64
integer y = 288
integer width = 5426
integer height = 476
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge589_monitor_lista"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event doubleclicked;call super::doubleclicked;if row = 0 then return

Tab_1.SelectedTab = 2
end event

event getfocus;call super::getfocus;dw_Origem_Aprovacao = This
end event

type dw_sel_ambiente from dc_uo_dw_base within tabpage_3
integer x = 32
integer y = 76
integer width = 1637
integer height = 80
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge589_sel_ambiente"
boolean ivb_ordena_colunas = true
end type

event ue_addrow;SUPER::event ue_addrow( )

This.SetItem(1, "cd_ambiente_sap", dw_Selecao.GetItemString(1, "cd_ambiente_sap"))

Return 1
end event

event itemchanged;call super::itemchanged;Post wf_Atualiza_Monitoramento()
end event

type gb_aguard_env from groupbox within tabpage_3
integer x = 23
integer y = 820
integer width = 5504
integer height = 788
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Aguardando Envio..."
end type

type dw_envio_pend from dc_uo_dw_base within tabpage_3
integer x = 64
integer y = 1008
integer width = 5426
integer height = 556
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge589_monitor_lista"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()

Post wf_inverte_colunas_dh("dh_aprovacao", This) // traz a data de aprova$$HEX2$$e700e300$$ENDHEX$$o pra tela
end event

event getfocus;call super::getfocus;dw_Origem_Aprovacao = This
end event

event doubleclicked;call super::doubleclicked;if row = 0 then return

Tab_1.SelectedTab = 2
end event

type uo_envio from uo_ge589_tarefas within tabpage_3
integer x = 64
integer y = 892
integer width = 5426
integer height = 104
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
long ivl_cd_tarefa = 221
end type

on uo_envio.destroy
call uo_ge589_tarefas::destroy
end on

type uo_retorno from uo_ge589_tarefas within tabpage_3
integer x = 64
integer y = 1700
integer width = 5426
integer height = 104
integer taborder = 60
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
long ivl_cd_tarefa = 218
end type

on uo_retorno.destroy
call uo_ge589_tarefas::destroy
end on

type tabpage_4 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 5550
integer height = 2568
long backcolor = 67108864
string text = "Envios Sybase -> SAP"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
pb_env_reprocessa pb_env_reprocessa
gb_env_painel gb_env_painel
p_env_clamed p_env_clamed
gb_env_aguard gb_env_aguard
gb_env_proc gb_env_proc
pb_env_periodo pb_env_periodo
dw_subidas_processadas dw_subidas_processadas
uo_enviadas uo_enviadas
cbx_env_monitora cbx_env_monitora
dw_sel_ambiente_env dw_sel_ambiente_env
dw_subidas_paradas dw_subidas_paradas
end type

on tabpage_4.create
this.pb_env_reprocessa=create pb_env_reprocessa
this.gb_env_painel=create gb_env_painel
this.p_env_clamed=create p_env_clamed
this.gb_env_aguard=create gb_env_aguard
this.gb_env_proc=create gb_env_proc
this.pb_env_periodo=create pb_env_periodo
this.dw_subidas_processadas=create dw_subidas_processadas
this.uo_enviadas=create uo_enviadas
this.cbx_env_monitora=create cbx_env_monitora
this.dw_sel_ambiente_env=create dw_sel_ambiente_env
this.dw_subidas_paradas=create dw_subidas_paradas
this.Control[]={this.pb_env_reprocessa,&
this.gb_env_painel,&
this.p_env_clamed,&
this.gb_env_aguard,&
this.gb_env_proc,&
this.pb_env_periodo,&
this.dw_subidas_processadas,&
this.uo_enviadas,&
this.cbx_env_monitora,&
this.dw_sel_ambiente_env,&
this.dw_subidas_paradas}
end on

on tabpage_4.destroy
destroy(this.pb_env_reprocessa)
destroy(this.gb_env_painel)
destroy(this.p_env_clamed)
destroy(this.gb_env_aguard)
destroy(this.gb_env_proc)
destroy(this.pb_env_periodo)
destroy(this.dw_subidas_processadas)
destroy(this.uo_enviadas)
destroy(this.cbx_env_monitora)
destroy(this.dw_sel_ambiente_env)
destroy(this.dw_subidas_paradas)
end on

type pb_env_reprocessa from picturebutton within tabpage_4
boolean visible = false
integer x = 2779
integer y = 1148
integer width = 110
integer height = 96
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\reprocessar.png"
alignment htextalign = left!
boolean map3dcolors = true
string powertiptext = "Reprocessar"
end type

event clicked;Long lvl_Row, lvl_nr_atualizacao, lvl_nr_controle, lvl_opc

lvl_Row = dw_subidas_processadas.GetRow()

If lvl_Row = 0 Then Return

lvl_nr_atualizacao = dw_subidas_processadas.GetItemNumber(lvl_Row, "nr_atualizacao")
lvl_nr_controle	 = Long(dw_subidas_processadas.GetItemString(lvl_Row, "cd_chave"))

If lvl_nr_controle = 0 Then Return

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tem certeza de que deseja reenviar o controle selecionado?", Question!, YesNo!) = 2 Then Return

UPDATE log_exportacao_sap
SET	 id_status_integracao = 'C'
WHERE	 nr_atualizacao = :lvl_nr_atualizacao
USING  SQLCA;

If SQLCA.SQLCode = 0 Then
	lvl_opc = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Reenviar todas as regras?~r~r[Sim] Todas~r[N$$HEX1$$e300$$ENDHEX$$o] Apenas pendentes de retorno~r[Cancelar] Nenhuma", Question!, YesNoCancel!)
	Choose Case lvl_Opc
		Case 1 // Sim - Todas
			UPDATE log_exportacao_j1btax_item
			SET	 dh_exportacao = null,
					 dh_retorno_sap = null
			WHERE  nr_controle = :lvl_nr_controle
			USING	 SQLCA;
		Case 2 // N$$HEX1$$e300$$ENDHEX$$o - Pendentes de retorno
			UPDATE log_exportacao_j1btax_item
			SET	 dh_exportacao = null,
					 dh_retorno_sap = null
			WHERE  nr_controle = :lvl_nr_controle
				and dh_exportacao is not null // enviadas
				and dh_retorno_sap is null		// n$$HEX1$$e300$$ENDHEX$$o retornadas
			USING	 SQLCA;
		Case 3 // Cancelar
			SQLCA.of_RollBack()
			Return
	End Choose
End If

If SQLCA.SQLCode = 0 Then
	SQLCA.of_Commit()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O controle ser$$HEX1$$e100$$ENDHEX$$ reenviado.")
	wf_Atualiza_Enviadas_SAP()
Else
	SQLCA.of_RollBack()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Falha.~r"+SQLCA.SQLErrText, StopSign!)
End If
end event

event constructor;If gvo_aplicacao.ivo_seguranca.nr_matricula = '995797' Then This.Post Show()
end event

type gb_env_painel from groupbox within tabpage_4
integer x = 23
integer y = 12
integer width = 5504
integer height = 328
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Painel"
end type

type p_env_clamed from picture within tabpage_4
integer x = 4466
integer y = 448
integer width = 933
integer height = 332
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\clamed.PNG"
boolean focusrectangle = false
end type

type gb_env_aguard from groupbox within tabpage_4
integer x = 23
integer y = 356
integer width = 4315
integer height = 516
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Aguardando processamento..."
end type

type gb_env_proc from groupbox within tabpage_4
integer x = 23
integer y = 892
integer width = 2720
integer height = 676
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Enviados recentemente (D-0)"
end type

type pb_env_periodo from picturebutton within tabpage_4
integer x = 2779
integer y = 916
integer width = 110
integer height = 96
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\clock.png"
alignment htextalign = left!
string powertiptext = "Alterar per$$HEX1$$ed00$$ENDHEX$$odo"
end type

event clicked;// Quantos dias considera no Retrieve

Choose Case Long(dw_Subidas_Processadas.Tag)
	Case 0
		dw_Subidas_Processadas.Tag = '3'
	Case 3
		dw_Subidas_Processadas.Tag = '7'
	Case 7
		dw_Subidas_Processadas.Tag = '30'
	Case 30
		dw_Subidas_Processadas.Tag = '0'
End Choose

dw_Subidas_Processadas.Event ue_Retrieve()
end event

type dw_subidas_processadas from dc_uo_dw_base within tabpage_4
string tag = "0"
integer x = 69
integer y = 968
integer width = 2638
integer height = 568
integer taborder = 80
boolean bringtotop = true
string dataobject = "dw_ge589_monitor_s_proc"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_preretrieve;call super::ue_preretrieve;This.of_RestoreOriginalSql()

This.Of_AppendWhere("i.cd_ambiente_sap ='"+dw_sel_ambiente_env.GetItemString(1, 'cd_ambiente_sap')+"'")

If Long(This.Tag) > 0 Then
	This.of_AppendWhere("i.dh_exportacao >= DateAdd(dd, -"+This.Tag+", GetDate())")
	gb_env_proc.Text = "Enviados recentemente (D-"+This.Tag+")"
Else
	This.of_AppendWhere("i.dh_exportacao >= Cast(GetDate() as date)")
	gb_env_proc.Text = "Enviados recentemente (hoje)"
End If

Return 1
end event

type uo_enviadas from uo_ge589_tarefas within tabpage_4
event destroy ( )
integer x = 64
integer y = 188
integer width = 5426
integer height = 104
integer taborder = 80
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
long ivl_cd_tarefa = 221
end type

on uo_enviadas.destroy
call uo_ge589_tarefas::destroy
end on

type cbx_env_monitora from checkbox within tabpage_4
integer x = 1673
integer y = 84
integer width = 814
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Monitorar envios"
end type

event clicked;If This.Checked Then
	wf_atualiza_enviadas_sap()
	Timer(1)
Else
	Timer(0)
End If
end event

type dw_sel_ambiente_env from dc_uo_dw_base within tabpage_4
integer x = 32
integer y = 76
integer width = 1637
integer height = 80
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge589_sel_ambiente"
boolean ivb_ordena_colunas = true
end type

event itemchanged;call super::itemchanged;Post wf_Atualiza_Enviadas_SAP( )
end event

event ue_addrow;SUPER::event ue_addrow( )

This.SetItem(1, "cd_ambiente_sap", dw_Selecao.GetItemString(1, "cd_ambiente_sap"))

Return 1
end event

type dw_subidas_paradas from dc_uo_dw_base within tabpage_4
integer x = 69
integer y = 432
integer width = 4238
integer height = 408
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_ge589_monitor_s_paradas"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_preretrieve;call super::ue_preretrieve;This.of_RestoreOriginalSql()

This.Of_AppendWhere("i.cd_ambiente_sap ='"+dw_sel_ambiente_env.GetItemString(1, 'cd_ambiente_sap')+"'")

Return 1
end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 5550
integer height = 2568
long backcolor = 67108864
string text = "Recebimentos SAP -> Sybase"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
p_receb_clamed p_receb_clamed
gb_receb_atualizadas gb_receb_atualizadas
pb_reprocessar pb_reprocessar
pb_visualizar_regras pb_visualizar_regras
pb_receb_periodo pb_receb_periodo
gb_receb_aguard gb_receb_aguard
gb_receb_proc gb_receb_proc
cbx_receb_monitora cbx_receb_monitora
dw_regras_atualizadas dw_regras_atualizadas
dw_descidas_paradas dw_descidas_paradas
dw_descidas_processadas dw_descidas_processadas
uo_recebidas uo_recebidas
dw_sel_ambiente_receb dw_sel_ambiente_receb
gb_receb_painel gb_receb_painel
end type

on tabpage_5.create
this.p_receb_clamed=create p_receb_clamed
this.gb_receb_atualizadas=create gb_receb_atualizadas
this.pb_reprocessar=create pb_reprocessar
this.pb_visualizar_regras=create pb_visualizar_regras
this.pb_receb_periodo=create pb_receb_periodo
this.gb_receb_aguard=create gb_receb_aguard
this.gb_receb_proc=create gb_receb_proc
this.cbx_receb_monitora=create cbx_receb_monitora
this.dw_regras_atualizadas=create dw_regras_atualizadas
this.dw_descidas_paradas=create dw_descidas_paradas
this.dw_descidas_processadas=create dw_descidas_processadas
this.uo_recebidas=create uo_recebidas
this.dw_sel_ambiente_receb=create dw_sel_ambiente_receb
this.gb_receb_painel=create gb_receb_painel
this.Control[]={this.p_receb_clamed,&
this.gb_receb_atualizadas,&
this.pb_reprocessar,&
this.pb_visualizar_regras,&
this.pb_receb_periodo,&
this.gb_receb_aguard,&
this.gb_receb_proc,&
this.cbx_receb_monitora,&
this.dw_regras_atualizadas,&
this.dw_descidas_paradas,&
this.dw_descidas_processadas,&
this.uo_recebidas,&
this.dw_sel_ambiente_receb,&
this.gb_receb_painel}
end on

on tabpage_5.destroy
destroy(this.p_receb_clamed)
destroy(this.gb_receb_atualizadas)
destroy(this.pb_reprocessar)
destroy(this.pb_visualizar_regras)
destroy(this.pb_receb_periodo)
destroy(this.gb_receb_aguard)
destroy(this.gb_receb_proc)
destroy(this.cbx_receb_monitora)
destroy(this.dw_regras_atualizadas)
destroy(this.dw_descidas_paradas)
destroy(this.dw_descidas_processadas)
destroy(this.uo_recebidas)
destroy(this.dw_sel_ambiente_receb)
destroy(this.gb_receb_painel)
end on

type p_receb_clamed from picture within tabpage_5
integer x = 4466
integer y = 448
integer width = 933
integer height = 332
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\clamed.PNG"
boolean focusrectangle = false
end type

type gb_receb_atualizadas from groupbox within tabpage_5
boolean visible = false
integer x = 23
integer y = 1588
integer width = 5499
integer height = 832
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Regras atualizadas"
end type

type pb_reprocessar from picturebutton within tabpage_5
boolean visible = false
integer x = 2779
integer y = 1148
integer width = 110
integer height = 96
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\reprocessar.png"
alignment htextalign = left!
boolean map3dcolors = true
string powertiptext = "Reprocessar"
end type

event constructor;If gvo_aplicacao.ivo_seguranca.nr_matricula = '995797' Then This.Post Show()
end event

event clicked;Long lvl_Row, lvl_nr_controle

lvl_Row = dw_descidas_processadas.GetRow()

If lvl_Row = 0 Then Return

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tem certeza de que deseja reprocessar o controle selecionado?", Question!, YesNo!) = 2 Then Return

lvl_nr_controle = dw_descidas_processadas.GetItemNumber(lvl_Row, "nr_controle")

UPDATE interface_sap
SET	 id_situacao = 'C',
		 dh_processamento = null
WHERE	 nr_controle = :lvl_nr_controle
USING  SQLCA;

If SQLCA.SQLCode = 0 Then
	SQLCA.of_Commit()
	wf_Atualiza_Recebidas_SAP()
Else
	SQLCA.of_RollBack()
End If
end event

type pb_visualizar_regras from picturebutton within tabpage_5
string tag = "contraido"
integer x = 2779
integer y = 1032
integer width = 110
integer height = 96
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\Expandir16Cinza.bmp"
string disabledname = "S:\Sistemas_PB12\Comuns\Figuras\Expandir16Cinza.bmp"
alignment htextalign = left!
string powertiptext = "Mostrar regras atualizadas"
end type

event clicked;
If This.Tag = "contraido" And dw_descidas_processadas.GetRow() > 0 Then
	// Carregar e Mostrar
	If wf_Carrega_Atualizadas() = -1 Then Return
	
	wf_expandir_atualizadas()
Else
	wf_recolher_atualizadas()
End If
end event

type pb_receb_periodo from picturebutton within tabpage_5
integer x = 2779
integer y = 916
integer width = 110
integer height = 96
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\clock.png"
alignment htextalign = left!
string powertiptext = "Alterar per$$HEX1$$ed00$$ENDHEX$$odo"
end type

event clicked;// Quantos dias considera no Retrieve

Choose Case Long(dw_descidas_processadas.Tag)
	Case 0
		dw_descidas_processadas.Tag = '3'
	Case 3
		dw_descidas_processadas.Tag = '7'
	Case 7
		dw_descidas_processadas.Tag = '30'
	Case 30
		dw_descidas_processadas.Tag = '0'
End Choose

dw_descidas_processadas.Event ue_Retrieve()
end event

type gb_receb_aguard from groupbox within tabpage_5
integer x = 23
integer y = 356
integer width = 4315
integer height = 516
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Aguardando processamento..."
end type

type gb_receb_proc from groupbox within tabpage_5
integer x = 23
integer y = 892
integer width = 2720
integer height = 676
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Recebidos recentemente (D-0)"
end type

type cbx_receb_monitora from checkbox within tabpage_5
integer x = 1673
integer y = 84
integer width = 814
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Monitorar recebimentos"
end type

event clicked;If This.Checked Then
	wf_atualiza_recebidas_sap()
	Timer(1)
Else
	Timer(0)
End If
end event

type dw_regras_atualizadas from dc_uo_dw_base within tabpage_5
boolean visible = false
integer x = 69
integer y = 1664
integer width = 5417
integer height = 716
integer taborder = 80
boolean bringtotop = true
string dataobject = "ds_ge589_j_1btxic3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_preretrieve;call super::ue_preretrieve;Long ll_nr_controle
String ls_Tabela

ll_nr_controle = dw_Descidas_Processadas.GetItemNumber(dw_Descidas_Processadas.GetRow(), "nr_controle")
ls_Tabela = lower(dw_Descidas_Processadas.GetItemString(dw_Descidas_Processadas.GetRow(), "nm_tabela_btx"))

If Not This.of_Changedataobject("ds_ge589_"+ls_Tabela) Then Return -1

This.of_SetRowSelection()

This.of_AppendWhere("nr_controle_interface_sap = "+String(ll_nr_controle))

Return 1
end event

type dw_descidas_paradas from dc_uo_dw_base within tabpage_5
integer x = 69
integer y = 432
integer width = 4238
integer height = 408
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge589_monitor_d_paradas"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_preretrieve;call super::ue_preretrieve;String ls_ambiente

ls_ambiente = dw_sel_ambiente_receb.GetItemString(1, 'cd_ambiente_sap')
If ls_ambiente = 'PRD' Then ls_ambiente = 'S4P' // PRD = S4P

This.of_RestoreOriginalSql()

This.Of_AppendWhere("cast(ii.vl_item as varchar) ='"+ls_ambiente+"'")

Return 1
end event

type dw_descidas_processadas from dc_uo_dw_base within tabpage_5
string tag = "0"
integer x = 69
integer y = 968
integer width = 2638
integer height = 568
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_ge589_monitor_d_proc"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_preretrieve;call super::ue_preretrieve;String ls_ambiente

ls_ambiente = dw_sel_ambiente_receb.GetItemString(1, 'cd_ambiente_sap')
If ls_ambiente = 'PRD' Then ls_ambiente = 'S4P' // PRD = S4P

This.of_RestoreOriginalSql()

This.Of_AppendWhere("cast(ii.vl_item as varchar) ='"+ls_ambiente+"'")

If Long(This.Tag) > 0 Then
	This.of_AppendWhere("i.dh_processamento >= DateAdd(dd, -"+This.Tag+", GetDate())")
	gb_receb_proc.Text = "Recebidos recentemente (D-"+This.Tag+")"
Else
	This.of_AppendWhere("i.dh_processamento >= Cast(GetDate() as date)")
	gb_receb_proc.Text = "Recebidos recentemente (hoje)"
End If

Return 1
end event

event rowfocuschanged;call super::rowfocuschanged;If pb_Visualizar_Regras.Tag = "expandido" Then
	wf_Carrega_Atualizadas()
End If
end event

event doubleclicked;call super::doubleclicked;If Row > 0 Then pb_visualizar_regras.event clicked()
end event

event ue_postretrieve;call super::ue_postretrieve;If This.RowCount() = 0 Then
	wf_recolher_atualizadas( )
	pb_Visualizar_Regras.Enabled = False
Else
	pb_Visualizar_Regras.Enabled = True
End If

Return This.RowCount()
end event

type uo_recebidas from uo_ge589_tarefas within tabpage_5
integer x = 64
integer y = 188
integer width = 5426
integer height = 104
integer taborder = 70
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
long ivl_cd_tarefa = 218
end type

on uo_recebidas.destroy
call uo_ge589_tarefas::destroy
end on

type dw_sel_ambiente_receb from dc_uo_dw_base within tabpage_5
integer x = 32
integer y = 76
integer width = 1637
integer height = 80
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge589_sel_ambiente"
boolean ivb_ordena_colunas = true
end type

event itemchanged;call super::itemchanged;Post wf_Atualiza_Recebidas_SAP()
end event

event ue_addrow;SUPER::event ue_addrow( )

This.SetItem(1, "cd_ambiente_sap", dw_Selecao.GetItemString(1, "cd_ambiente_sap"))

Return 1
end event

type gb_receb_painel from groupbox within tabpage_5
integer x = 23
integer y = 12
integer width = 5504
integer height = 328
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Painel"
end type

