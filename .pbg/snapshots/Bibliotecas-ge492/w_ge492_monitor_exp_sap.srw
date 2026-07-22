HA$PBExportHeader$w_ge492_monitor_exp_sap.srw
forward
global type w_ge492_monitor_exp_sap from dc_w_2tab_consulta_selecao_lista_det
end type
type cb_cancelamento from commandbutton within tabpage_1
end type
type cb_executar from commandbutton within tabpage_1
end type
type gb_4 from groupbox within tabpage_1
end type
type dw_4 from dc_uo_dw_base within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
end forward

global type w_ge492_monitor_exp_sap from dc_w_2tab_consulta_selecao_lista_det
string tag = "w_ge492_monitor_exp_sap"
integer width = 4763
integer height = 2352
string title = "GE492 - Monitor Exporta$$HEX2$$e700e300$$ENDHEX$$o SAP [Subida]"
boolean resizable = false
end type
global w_ge492_monitor_exp_sap w_ge492_monitor_exp_sap

type variables
boolean ivb_Check

String ivs_Operador

uo_ge543_tabela_interface_sap	io_ge543_tabela_interface_sap
end variables

forward prototypes
public function boolean wf_processa ()
public subroutine wf_setar_parametros_monitor_erros (long al_tabela, long al_erros)
public function boolean wf_prepara_aba_detalhes (long al_cd_tabela)
end prototypes

public function boolean wf_processa ();Boolean 	lb_retorno = true
Int  		li_ret
Long 		ll_Linhas, ll_Linha, ll_nr_atualizacao, ll_Tabela, ll_qt_selecionados, ll_tabela_ant, &
			ll_linhas_filtro, ll_progresso_1=0, ll_progresso_2, ll_cd_modelo_exportacao_sap, ll_null
String 	ls_Log, ls_Chave, ls_status, ls_nm_Tabela, ls_nr_atualizacao

datastore 					lds_dados, lds_aux
uo_ge492_exportacao_sap luo_exportacao


try
	SetNull(ll_null)
	
	luo_exportacao = Create uo_ge492_exportacao_sap

	lds_dados = Create DataStore
	lds_dados.DataObject = tab_1.TabPage_1.dw_2.DataObject
	
	lds_aux = Create DataStore
	lds_aux.DataObject = tab_1.TabPage_1.dw_2.DataObject
	
	if tab_1.TabPage_1.dw_2.RowsCopy(1,tab_1.TabPage_1.dw_2.RowCount(), primary!, lds_dados, 1, primary!) < 0 then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao copiar dados (Rowscopy) da datawindow "dw_ge492_lista".')
		Return False
	end if
	
	if tab_1.TabPage_1.dw_2.RowsCopy(1, tab_1.TabPage_1.dw_2.RowCount(), primary!, lds_Aux, 1, primary!) < 0 then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao copiar dados (Rowscopy) da datawindow "dw_ge492_lista".')
		Return False
	end if
	
	lds_dados.SetSort('cd_tabela A, dh_exportacao A')
	lds_dados.Sort()

	ll_Linhas = lds_dados.RowCount()
	
	If ll_Linhas > 0 Then
		ll_qt_selecionados = tab_1.TabPage_1.dw_2.object.c_total_tab_selecionadas[ll_linhas]
		
		Open(w_Aguarde)
		
		w_aguarde.uo_progress.of_setmax(ll_qt_selecionados)	
					
		For ll_Linha =1 To ll_Linhas
			If lds_dados.Object.id_processa[ll_Linha] = 'S' and (lds_dados.Object.id_status_integracao[ll_Linha]  = 'C' or &
				lds_dados.Object.id_status_integracao[ll_Linha]  = 'E' or lds_dados.Object.id_status_integracao[ll_Linha]  = 'I') Then
				ls_nr_atualizacao 				= lds_dados.Object.nr_atualizacao[ll_Linha]
				ll_Tabela 							= lds_dados.Object.cd_tabela[ll_Linha]
				ls_status 							= lds_dados.Object.id_status_integracao[ll_Linha]
				ls_nm_Tabela 						= lds_dados.Object.de_tabela[ll_Linha]
				ll_cd_modelo_exportacao_sap	= lds_dados.Object.cd_modelo_exportacao_sap[ll_Linha]
				
				if ll_cd_modelo_exportacao_sap = 1 then
					ll_nr_atualizacao	= Long(ls_nr_atualizacao)
					
					//A l$$HEX1$$f300$$ENDHEX$$gica abaixo deve ser alterada assim que poss$$HEX1$$ed00$$ENDHEX$$vel - Guilherme Cordeiro
					//Se for a interface de Pedido Distribuidora e o pedido estiver como Integrado: Chama a interface de Retorno.
					if ll_tabela = 45 and (ls_status = 'I' or ls_status = 'E') Then
						ll_tabela = 65
					end if
					
					if luo_exportacao.uf_executar( ll_tabela , ll_nr_atualizacao, REF ls_Log ) = false Then
						lb_retorno = False
					end if
				else
					if luo_exportacao.uf_executar( ll_tabela , ll_null, ls_nr_atualizacao, REF ls_Log ) = false Then
						lb_retorno = False
					end if
				end if
				
				ll_progresso_1++
			End If
		
			w_aguarde.uo_progress.of_setprogress(ll_progresso_1)
		Next
	End If
catch (RunTimeError RTE)	
	ls_Log = RTE.GetMessage()
	lb_retorno	= False
finally
	Destroy (lds_dados) 
	Destroy (lds_aux)
	Destroy (luo_exportacao)
	
	If Isvalid(w_Aguarde) Then Close(w_Aguarde)
	
	if Not lb_retorno Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_Log, Information!)
	end if
end try

Return True
end function

public subroutine wf_setar_parametros_monitor_erros (long al_tabela, long al_erros);Date	ld_null


SetNull(ld_null)

This.Tab_1.TabPage_1.dw_1.Object.dh_inicio[1] = ld_null
This.Tab_1.TabPage_1.dw_1.Object.dh_fim[1] = ld_null

if al_erros > 0 then
	This.Tab_1.TabPage_1.dw_1.Object.id_situacao[1]	= 'E'
end if

io_ge543_tabela_interface_sap.of_Localiza_tabela_interface_sap(String(al_tabela))

If io_ge543_tabela_interface_sap.ib_Localizado Then
	This.Tab_1.TabPage_1.dw_1.Object.cd_tabela[1] = io_ge543_tabela_interface_sap.il_cd_tabela
	This.Tab_1.TabPage_1.dw_1.Object.de_tabela[1] = io_ge543_tabela_interface_sap.is_de_tabela
End If

This.Tab_1.TabPage_1.dw_2.Trigger Event ue_recuperar()
end subroutine

public function boolean wf_prepara_aba_detalhes (long al_cd_tabela);String	ls_de_integer1, ls_de_integer2, ls_de_integer3, ls_de_integer4, ls_de_integer5, &
    		ls_de_varchar1, ls_de_varchar2, ls_de_varchar3, ls_de_varchar4, ls_de_varchar5, &
			ls_de_varchar6, ls_de_varchar7, ls_de_varchar8, ls_de_varchar9, &
    		ls_de_datetime1, ls_de_datetime2, ls_de_datetime3, ls_de_datetime4, ls_de_datetime5

SELECT
    Coalesce(tisd.de_integer1, 'N$$HEX1$$e300$$ENDHEX$$o Utilizado'),
    Coalesce(tisd.de_integer2, 'N$$HEX1$$e300$$ENDHEX$$o Utilizado'),
    Coalesce(tisd.de_integer3, 'N$$HEX1$$e300$$ENDHEX$$o Utilizado'),
    Coalesce(tisd.de_integer4, 'N$$HEX1$$e300$$ENDHEX$$o Utilizado'),
    Coalesce(tisd.de_integer5, 'N$$HEX1$$e300$$ENDHEX$$o Utilizado'),
    Coalesce(tisd.de_varchar1, 'N$$HEX1$$e300$$ENDHEX$$o Utilizado'),
    Coalesce(tisd.de_varchar2, 'N$$HEX1$$e300$$ENDHEX$$o Utilizado'),
    Coalesce(tisd.de_varchar3, 'N$$HEX1$$e300$$ENDHEX$$o Utilizado'),
    Coalesce(tisd.de_varchar4, 'N$$HEX1$$e300$$ENDHEX$$o Utilizado'),
    Coalesce(tisd.de_varchar5, 'N$$HEX1$$e300$$ENDHEX$$o Utilizado'),
	 Coalesce(tisd.de_varchar6, 'N$$HEX1$$e300$$ENDHEX$$o Utilizado'),
    Coalesce(tisd.de_varchar7, 'N$$HEX1$$e300$$ENDHEX$$o Utilizado'),
    Coalesce(tisd.de_varchar8, 'N$$HEX1$$e300$$ENDHEX$$o Utilizado'),
    Coalesce(tisd.de_varchar9, 'N$$HEX1$$e300$$ENDHEX$$o Utilizado'),
    Coalesce(tisd.de_datetime1, 'N$$HEX1$$e300$$ENDHEX$$o Utilizado'),
    Coalesce(tisd.de_datetime2, 'N$$HEX1$$e300$$ENDHEX$$o Utilizado'),
    Coalesce(tisd.de_datetime3, 'N$$HEX1$$e300$$ENDHEX$$o Utilizado'),
    Coalesce(tisd.de_datetime4, 'N$$HEX1$$e300$$ENDHEX$$o Utilizado'),
    Coalesce(tisd.de_datetime5, 'N$$HEX1$$e300$$ENDHEX$$o Utilizado')
INTO
    :ls_de_integer1,
    :ls_de_integer2,
    :ls_de_integer3,
    :ls_de_integer4,
    :ls_de_integer5,
    :ls_de_varchar1,
    :ls_de_varchar2,
    :ls_de_varchar3,
    :ls_de_varchar4,
    :ls_de_varchar5,
	 :ls_de_varchar6,
    :ls_de_varchar7,
    :ls_de_varchar8,
    :ls_de_varchar9,
    :ls_de_datetime1,
    :ls_de_datetime2,
    :ls_de_datetime3,
    :ls_de_datetime4,
    :ls_de_datetime5
FROM
    tabela_interface_sap_detalhes tisd
WHERE
    tisd.cd_tabela = :al_cd_tabela;
	 
Choose Case SQLCA.SQLCode
	Case -1
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao carregar a nomenclatura das colunas da tabela ' + String(al_cd_tabela) + ' [tabela_interface_sap_campos_exportacao].~r~rErro: ' + SQLCA.SQLErrText, StopSign!)
		Return False
	Case 100
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi encontrada a nomenclatura das colunas da tabela ' + String(al_cd_tabela) + ' [tabela_interface_sap_campos_exportacao].', StopSign!)
		Return False
End Choose

tab_1.tabpage_2.dw_3.Object.cd_integer1_t.Text = ls_de_integer1 + ':'
tab_1.tabpage_2.dw_3.Object.cd_integer2_t.Text = ls_de_integer2 + ':'
tab_1.tabpage_2.dw_3.Object.cd_integer3_t.Text = ls_de_integer3 + ':'
tab_1.tabpage_2.dw_3.Object.cd_integer4_t.Text = ls_de_integer4 + ':'
tab_1.tabpage_2.dw_3.Object.cd_integer5_t.Text = ls_de_integer5 + ':'

tab_1.tabpage_2.dw_3.Object.cd_varchar1_t.Text = ls_de_varchar1 + ':'
tab_1.tabpage_2.dw_3.Object.cd_varchar2_t.Text = ls_de_varchar2 + ':'
tab_1.tabpage_2.dw_3.Object.cd_varchar3_t.Text = ls_de_varchar3 + ':'
tab_1.tabpage_2.dw_3.Object.cd_varchar4_t.Text = ls_de_varchar4 + ':'
tab_1.tabpage_2.dw_3.Object.cd_varchar5_t.Text = ls_de_varchar5 + ':'
tab_1.tabpage_2.dw_3.Object.cd_varchar6_t.Text = ls_de_varchar6 + ':'
tab_1.tabpage_2.dw_3.Object.cd_varchar7_t.Text = ls_de_varchar7 + ':'
tab_1.tabpage_2.dw_3.Object.cd_varchar8_t.Text = ls_de_varchar8 + ':'
tab_1.tabpage_2.dw_3.Object.cd_varchar9_t.Text = ls_de_varchar9 + ':'

tab_1.tabpage_2.dw_3.Object.cd_datetime1_t.Text = ls_de_datetime1 + ':'
tab_1.tabpage_2.dw_3.Object.cd_datetime2_t.Text = ls_de_datetime2 + ':'
tab_1.tabpage_2.dw_3.Object.cd_datetime3_t.Text = ls_de_datetime3 + ':'
tab_1.tabpage_2.dw_3.Object.cd_datetime4_t.Text = ls_de_datetime4 + ':'
tab_1.tabpage_2.dw_3.Object.cd_datetime5_t.Text = ls_de_datetime5 + ':'

Return True
end function

on w_ge492_monitor_exp_sap.create
int iCurrent
call super::create
end on

on w_ge492_monitor_exp_sap.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;DataWindowChild lvdwc

String ls_SQL
String ls_Ambiente
String ls_Log

Long ll_Tabela_Defaut

Tab_1.TabPage_1.dw_1.AcceptText()

Tab_1.TabPage_1.dw_2.of_SetMenu(This.ivm_Menu)

Tab_1.TabPage_1.dw_1.Object.dh_inicio[1] = relativedate(date(gf_GetServerDate()),- 5)
Tab_1.TabPage_1.dw_1.Object.dh_fim[1] = date(gf_GetServerDate())

Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_SalvarComo(True)

If gf_ambiente_sap(ls_Ambiente, ref ls_Log) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Log)
	Close(This)
End If

If ls_Ambiente = 'PRD' Then
	Tab_1.TabPage_1.dw_2.Object.t_ambiente_sap.text = ""
Else
	Tab_1.TabPage_1.dw_2.Object.t_ambiente_sap.text = "Ambiente SAP: [" + ls_Ambiente + "]"
End If
end event

event open;call super::open;String	ls_sistema


io_ge543_tabela_interface_sap = Create uo_ge543_tabela_interface_sap
io_ge543_tabela_interface_sap.is_tipo	= 'S'

ls_sistema	= gvo_aplicacao.ivo_seguranca.cd_sistema

if ls_sistema = 'EX' then
	SetNull(ls_sistema)
End If

io_ge543_tabela_interface_sap.is_cd_sistema	= ls_sistema
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge492_monitor_exp_sap
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge492_monitor_exp_sap
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge492_monitor_exp_sap
integer x = 0
integer y = 0
integer width = 4713
integer height = 2188
end type

event tab_1::selectionchanged;//OverRide

//Tab_1.TabPage_2.cbx_1.Checked = False
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 4677
integer height = 2072
cb_cancelamento cb_cancelamento
cb_executar cb_executar
gb_4 gb_4
dw_4 dw_4
cb_1 cb_1
end type

on tabpage_1.create
this.cb_cancelamento=create cb_cancelamento
this.cb_executar=create cb_executar
this.gb_4=create gb_4
this.dw_4=create dw_4
this.cb_1=create cb_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancelamento
this.Control[iCurrent+2]=this.cb_executar
this.Control[iCurrent+3]=this.gb_4
this.Control[iCurrent+4]=this.dw_4
this.Control[iCurrent+5]=this.cb_1
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_cancelamento)
destroy(this.cb_executar)
destroy(this.gb_4)
destroy(this.dw_4)
destroy(this.cb_1)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer x = 9
integer y = 456
integer width = 4654
integer height = 1432
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer x = 9
integer y = 24
integer width = 3703
integer height = 428
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer y = 92
integer width = 3643
integer height = 332
string dataobject = "dw_ge492_selecao"
end type

event dw_1::ue_key;call super::ue_key;String	ls_Coluna

If Key = KeyEnter! Then

	ls_Coluna = This.GetColumnName()
	
	if ls_coluna	= "de_tabela" then
		io_ge543_tabela_interface_sap.of_Localiza_tabela_interface_sap(This.GetText())
		
		If io_ge543_tabela_interface_sap.ib_Localizado Then
			This.Object.cd_tabela[1] = io_ge543_tabela_interface_sap.il_cd_tabela
			This.Object.de_tabela[1] = io_ge543_tabela_interface_sap.is_de_tabela
		else
			SetNull(io_ge543_tabela_interface_sap.il_cd_tabela)
			io_ge543_tabela_interface_sap.is_de_tabela = ""
			
			This.Object.cd_tabela[1] = io_ge543_tabela_interface_sap.il_cd_tabela
			This.Object.de_tabela[1] = io_ge543_tabela_interface_sap.is_de_tabela
		End If
	end if
end if
end event

event dw_1::itemchanged;call super::itemchanged;Long	ll_Nulo

If dwo.Name = "de_tabela" Then
	
	SetNull(ll_Nulo)
	
	If data = "" or IsNull(data) Then
		This.Object.cd_tabela[1] = ll_Nulo
	Else
		If Data <> io_ge543_tabela_interface_sap.is_de_tabela Then Return 1
	End If	
	
End If
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer y = 528
integer width = 4576
integer height = 1336
string dataobject = "dw_ge492_lista"
end type

event dw_2::ue_recuperar;DateTime	ldh_Inicio,	ldh_Fim
Long		ll_Tabela, ll_Index_SubQuery, ll_cd_produto
String	ls_Situacao, ls_chave, ls_id_valor_exato, ls_cd_fornecedor, ls_cd_sistema, ls_nr_controle


This.of_RestoreOriginalSQL()

dw_1.AcceptText()

ldh_Inicio			= dw_1.Object.dh_inicio[1]
ldh_Fim				= dw_1.Object.dh_fim[1]
ll_Tabela			= dw_1.Object.cd_tabela[1]
ls_Situacao			= dw_1.Object.id_situacao[1]
ls_nr_controle		= dw_1.Object.nr_controle[1]
ls_chave 			= dw_1.Object.cd_chave[1]
ls_id_valor_exato = dw_1.Object.id_valor_exato[1]
ll_cd_produto 		= dw_1.Object.cd_produto[1]
ls_cd_fornecedor 	= dw_1.Object.cd_fornecedor[1]

ll_Index_SubQuery	= 1

If Not IsNull(ldh_Inicio) and Not IsNull(ldh_Fim) Then
	If ldh_Inicio > ldh_Fim Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data inicial n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data final.")
		dw_1.SetColumn("dh_inicio")
		Return 1
	End If
End If

ls_cd_sistema	= gvo_Aplicacao.ivo_Seguranca.Cd_Sistema

If ls_cd_sistema <> "EX" Then
	This.of_AppendWhere_SubQuery("tis.cd_sistema = '"+ls_cd_sistema+"'", ll_Index_SubQuery)
	This.of_AppendWhere_SubQuery("tis.cd_sistema = '"+ls_cd_sistema+"'", 2)
	This.of_AppendWhere_SubQuery("tis.cd_sistema = '"+ls_cd_sistema+"'", 3)
	This.of_AppendWhere_SubQuery("tis.cd_sistema = '"+ls_cd_sistema+"'", 4)
End If

If Not IsNull(ldh_Inicio) Then
	This.of_AppendWhere_SubQuery("ls.dh_exportacao >= '"+String(ldh_Inicio, "yyyymmdd")+"'", ll_Index_SubQuery)
	This.of_AppendWhere_SubQuery("le.dh_inclusao >= '"+String(ldh_Inicio, "yyyymmdd")+"'", 2)
	This.of_AppendWhere_SubQuery("pd.dh_emissao >= '"+String(ldh_Inicio, "yyyymmdd")+"'", 3)
	This.of_AppendWhere_SubQuery("pd.dh_emissao >= '"+String(ldh_Inicio, "yyyymmdd")+"'", 4)
End If

If Not IsNull(ldh_Fim) Then
	This.of_AppendWhere_SubQuery("ls.dh_exportacao <= '"+String(ldh_Fim, "yyyymmdd 23:59:59")+"'", ll_Index_SubQuery)
	This.of_AppendWhere_SubQuery("le.dh_inclusao <= '"+String(ldh_Fim, "yyyymmdd 23:59:59")+"'", 2)
	This.of_AppendWhere_SubQuery("pd.dh_emissao <= '"+String(ldh_Fim, "yyyymmdd 23:59:59")+"'", 3)
	This.of_AppendWhere_SubQuery("pd.dh_emissao <= '"+String(ldh_Fim, "yyyymmdd 23:59:59")+"'", 4)
End If


If Not IsNull(ll_Tabela) and (ll_Tabela <> 0) Then
	This.of_AppendWhere_SubQuery("tis.cd_tabela = "+String(ll_Tabela), ll_Index_SubQuery)
	This.of_AppendWhere_SubQuery("tis.cd_tabela = "+String(ll_Tabela), 2)
	This.of_AppendWhere_SubQuery("tis.cd_tabela = "+String(ll_Tabela), 3)
	This.of_AppendWhere_SubQuery("tis.cd_tabela = "+String(ll_Tabela), 4)
End If

If Not IsNull(ls_nr_controle) and Trim(ls_nr_controle) <> '' Then
	This.of_AppendWhere_SubQuery("le.nr_exportacao = '"+ls_nr_controle +"'", 2)
	
	if IsNumber(ls_nr_controle) then
		This.of_AppendWhere_SubQuery("ls.nr_atualizacao = "+ls_nr_controle, ll_Index_SubQuery)
		This.of_AppendWhere_SubQuery("pd.nr_pedido_distribuidora = "+ls_nr_controle, 3)
		This.of_AppendWhere_SubQuery("pd.nr_pedido_sap = "+ls_nr_controle, 4)
	else
		This.of_AppendWhere_SubQuery("1 = 2", ll_Index_SubQuery)
		This.of_AppendWhere_SubQuery("1 = 2", 3)
		This.of_AppendWhere_SubQuery("1 = 2", 4)
	end if
End If

if Not Isnull(ls_chave) and ls_chave <> '' Then
	if ls_id_valor_exato = 'S' Then
		This.of_AppendWhere_SubQuery("ls.cd_chave = '" + ls_chave + "'" , ll_Index_SubQuery)
		This.of_AppendWhere_SubQuery("le.cd_chave = '" + ls_chave + "'", 2)
		This.of_AppendWhere_SubQuery("convert(varchar,pd.nr_pedido_distribuidora) = '" + ls_chave + "'", 3)
		This.of_AppendWhere_SubQuery("convert(varchar,pd.nr_pedido_sap) = '" + ls_chave + "'", 4)
	else
		This.of_AppendWhere_SubQuery("ls.cd_chave like ('%" + ls_chave + "%')" , ll_Index_SubQuery)
		This.of_AppendWhere_SubQuery("le.cd_chave like ('%" + ls_chave + "%')" , 2)
		This.of_AppendWhere_SubQuery("convert(varchar,pd.nr_pedido_distribuidora) like ('%" + ls_chave + "%')", 3)
		This.of_AppendWhere_SubQuery("convert(varchar,pd.nr_pedido_sap) like ('%" + ls_chave + "%')", 4)
	end if
	
end if

if ls_cd_fornecedor <> '' and not isnull(ls_cd_fornecedor) Then
	This.of_AppendWhere_SubQuery("ls.cd_fornecedor = '" + ls_cd_fornecedor + "'" , ll_Index_SubQuery)
	This.of_AppendWhere_SubQuery(" 1 = 2", 2)
	This.of_AppendWhere_SubQuery("pd.cd_distribuidora = '" + ls_cd_fornecedor + "'", 3)
	This.of_AppendWhere_SubQuery(" 1 = 2", 4)
end if

if ll_cd_produto > 0 and not isnull(ll_cd_produto) Then
	This.of_AppendWhere_SubQuery("ls.cd_produto = " + String(ll_cd_produto) , ll_Index_SubQuery)
	This.of_AppendWhere_SubQuery(" 1 = 2", 2)
	This.of_AppendWhere_SubQuery(" 1 = 2", 3)
	This.of_AppendWhere_SubQuery(" 1 = 2", 4)
end if

If ls_Situacao <> "T" Then
	If ls_Situacao = 'CE' Then //COLOCADO ou ERRO
		This.of_AppendWhere_SubQuery("ls.id_status_integracao in ('C', 'E')", ll_Index_SubQuery)
		This.of_AppendWhere_SubQuery("le.id_situacao_exportacao in ('C', 'E')", 2)
		This.of_AppendWhere_SubQuery("pd.id_exportacao_sap in ('C', 'E')", 3)
		This.of_AppendWhere_SubQuery("pd.id_exportacao_sap in ('C', 'E')", 4)
	Else
		This.of_AppendWhere_SubQuery("ls.id_status_integracao = '"+ls_Situacao+"'", ll_Index_SubQuery)
		This.of_AppendWhere_SubQuery("le.id_situacao_exportacao = '"+ls_Situacao+"'", 2)
		This.of_AppendWhere_SubQuery("pd.id_exportacao_sap = '"+ls_Situacao+"'", 3)
		This.of_AppendWhere_SubQuery("pd.id_exportacao_sap = '"+ls_Situacao+"'", 4)
	End If
End If
	
Return This.Retrieve()
end event

event dw_2::doubleclicked;call super::doubleclicked;String	lvs_Marcacao

Long	ll_Row

If dwo.Name = 'id_imagem' Then
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True
	End If
	
	For ll_Row = 1 To This.RowCount()
				
		If lvs_Marcacao = 'S' Then
			If This.Object.id_status_integracao[ll_Row] = 'C' or This.Object.id_status_integracao[ll_Row] = 'E'  Then
				This.Object.id_processa[ll_Row] = lvs_Marcacao
			End If
		Else
			This.Object.id_processa[ll_Row] = lvs_Marcacao
		End If
	
	Next
	
End If		
end event

event dw_2::constructor;call super::constructor;// Habilitar a ordena$$HEX2$$e700e300$$ENDHEX$$o na coluna
This.ivb_Ordena_Colunas = True

This.ivo_Controle_Menu.of_Atualiza()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 then
	cb_cancelamento.Enabled = True
Else
	cb_cancelamento.Enabled = False
End If

Return pl_Linhas
end event

event dw_2::clicked;call super::clicked;If row > 0 Then
	Tab_1.TabPage_1.dw_4.Object.de_erro[1] = This.Object.de_erro[Row]
End If
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;If Tab_1.TabPage_1.dw_2.RowCount() > 0 Then
	Tab_1.TabPage_1.dw_4.Object.de_erro[1] = This.Object.de_erro[Tab_1.TabPage_1.dw_2.GetRow()]
End If
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 4677
integer height = 2072
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 4622
integer height = 2040
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer width = 4535
integer height = 1948
string dataobject = "dw_ge492_monitor_log_exportacao"
boolean livescroll = false
boolean exibemensagem = false
end type

event dw_3::ue_recuperar;Long		ll_row, ll_nr_atualizacao, ll_cd_modelo_exportacao_sap, ll_cd_tabela
String	ls_nr_atualizacao


ll_row	= tab_1.tabpage_1.dw_2.GetRow()

if ll_row < 1 then return 0

ls_nr_atualizacao					= tab_1.tabpage_1.dw_2.GetItemString(ll_row, 'nr_atualizacao')
ll_cd_tabela						= tab_1.tabpage_1.dw_2.GetItemNumber(ll_row, 'cd_tabela')
ll_cd_modelo_exportacao_sap	= tab_1.tabpage_1.dw_2.GetItemNumber(ll_row, 'cd_modelo_exportacao_sap')

if ll_cd_modelo_exportacao_sap = 1 then
	If Not tab_1.tabpage_2.dw_3.of_ChangeDataObject('dw_ge492_detalhes_monitor') Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao alterar a DW 'dw_ge492_detalhes_monitor'.", StopSign!)
		Return -1
	End If
	
	ll_nr_atualizacao	= Long(ls_nr_atualizacao)
	
	if ll_nr_atualizacao > 0 and Not IsNull(ll_nr_atualizacao) then
		this.Retrieve(ll_nr_atualizacao)
	end if
else
	If Not tab_1.tabpage_2.dw_3.of_ChangeDataObject('dw_ge492_monitor_log_exportacao') Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao alterar a DW 'dw_ge492_monitor_log_exportacao'.", StopSign!)
		Return -1
	End If
	
	if Trim(ls_nr_atualizacao) <> '' and Not IsNull(ls_nr_atualizacao) then
		if not wf_prepara_aba_detalhes(ll_cd_tabela) then
			return -1
		end if
		
		this.Retrieve(ls_nr_atualizacao)
	end if
end if
end event

event dw_3::constructor;call super::constructor;This.of_SetColSelection(True)
end event

type cb_cancelamento from commandbutton within tabpage_1
integer x = 3968
integer y = 140
integer width = 512
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Cancelar"
end type

event clicked;Long ll_Tabela
Long ll_Linha
Long ll_Linhas
Long ll_Controle
long ll_nr_atualizacao

String ls_Situacao
String ls_MSG
String ls_Motivo

tab_1.TabPage_1.dw_2.AcceptText()

ll_Linhas = tab_1.TabPage_1.dw_2.RowCount()

If ll_Linhas = 0 Then Return

ll_Tabela		= tab_1.TabPage_1.dw_1.Object.cd_tabela		[1]
ls_Situacao 	= tab_1.TabPage_1.dw_1.Object.id_situacao	[1]

If ll_Tabela = 0 or IsNull(ll_Tabela) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma tabela.", Exclamation!)
	Return
End If

If ls_Situacao = 'X' or ls_Situacao = 'T' or ls_Situacao = 'P' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a situa$$HEX2$$e700e300$$ENDHEX$$o COLOCADO ou com ERRO.", Exclamation!)
	Return
End If

If tab_1.TabPage_1.dw_2.find('id_processa = "S"',1,  tab_1.TabPage_1.dw_2.rowcount( ) ) = 0 Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Nenhum registro foi selecionado.')
	Return
End If

If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Confirma o CANCELAMENTO do processamento dos itens selecionados ?', Question!, YesNo!, 2) = 2 Then Return 

try
		
	OpenWithParm(w_ge473_motivo_cancelamento,"")
	ls_Motivo = Message.StringParm
		
	If IsNull(ls_Motivo) Then Return	
	
	ls_Motivo = ' Motivo Canc.: ' + gvo_Aplicacao.ivo_Seguranca.Nr_Matricula + ' (usu$$HEX1$$e100$$ENDHEX$$rio)  - ' + ls_Motivo
	
	Open(w_Aguarde)
	w_aguarde.uo_progress.of_setmax(ll_Linhas)
	
	w_Aguarde.Title = "Cancelando os itens selecionados..."
	
	For ll_Linha = 1 To ll_Linhas
		
		If tab_1.TabPage_1.dw_2.Object.id_processa[ll_Linha] = 'S' Then
			
			ll_nr_atualizacao	= tab_1.TabPage_1.dw_2.Object.nr_atualizacao[ll_Linha]
			ll_tabela = tab_1.TabPage_1.dw_2.Object.cd_tabela[ll_Linha]
			
			if ll_tabela = 45 Then
	
				Update pedido_distribuidora
				set id_exportacao_sap = 'X', dh_exportacao_sap = null
				where nr_pedido_distribuidora = :ll_nr_atualizacao;
			
				If SqlCa.Sqlcode = -1 Then
					ls_MSG = "Erro ao cancelar o processamento do Pedido [" + String(ll_nr_atualizacao) + "]. Erro: "+ SqlCa.SqlErrText
					SqlCa.of_Rollback( )
					Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG)
					Return 			
				End If
			
			else
				
				Update log_exportacao_sap
				Set id_status_integracao = 'D', dh_exportacao = getdate(), de_erro = (Case when de_erro is null Then :ls_Motivo else de_erro + :ls_Motivo END)
				Where nr_atualizacao = :ll_nr_atualizacao
					and id_status_integracao <> 'P'
				Using SqlCa;
				
				If SqlCa.Sqlcode = -1 Then
					ls_MSG = "Erro ao cancelar o processamento do registro [" + String(ll_nr_atualizacao) + "]. Erro: "+ SqlCa.SqlErrText
					SqlCa.of_Rollback( )
					Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG)
					Return 			
				End If
			
			End if	
			
			SqlCa.of_Commit();
			
		End If
	
		w_aguarde.uo_progress.of_setprogress(ll_Linha)
	Next
	
	tab_1.TabPage_1.dw_2.Event ue_Retrieve()

finally
	Close(w_Aguarde)
end try







end event

type cb_executar from commandbutton within tabpage_1
integer x = 3968
integer y = 356
integer width = 512
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Executar"
end type

event clicked;//id_processa

Long ll_Itens_Selec

ll_Itens_Selec = tab_1.TabPage_1.dw_2.find('id_processa = "S" ', 1, tab_1.TabPage_1.dw_2.rowcount() )

If ll_Itens_Selec = 0 Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Nenhum registro foi selecionado.')
	Return
End If

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE492_EXECUTA_INTERFACE", ref ivs_Operador) Then 
	Return
End If

If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Cofirma a atualiza$$HEX2$$e700e300$$ENDHEX$$o dos itens selecionados ?', Question!, YesNo!, 2) = 2 Then Return 

wf_processa()

tab_1.TabPage_1.dw_2.Event ue_Recuperar()


end event

type gb_4 from groupbox within tabpage_1
integer x = 9
integer y = 1892
integer width = 4654
integer height = 172
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Mensagem"
end type

type dw_4 from dc_uo_dw_base within tabpage_1
integer x = 46
integer y = 1952
integer width = 4585
integer height = 96
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge492_erro"
end type

type cb_1 from commandbutton within tabpage_1
integer x = 3968
integer y = 44
integer width = 512
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Reenviar"
end type

event clicked;String 	ls_nr_matricula, ls_null, ls_mensagem, ls_nr_atualizacao, ls_id_processa
Long 		ll_nr_atualizacao, ll_for, ll_cd_modelo_exportacao_sap


tab_1.TabPage_1.dw_2.AcceptText()

SetNull(ls_null)

If tab_1.TabPage_1.dw_2.rowcount() = 0 Then Return

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE492_REENVIAR_DOCUMENTO", ref ls_nr_matricula) Then Return

ls_mensagem = "Usu$$HEX1$$e100$$ENDHEX$$rio respons$$HEX1$$e100$$ENDHEX$$vel reenvio: "  + ls_nr_matricula

For ll_for = 1 to tab_1.TabPage_1.dw_2.RowCount()
	ls_id_processa 					= tab_1.TabPage_1.dw_2.Object.id_processa[ll_for]
	ll_cd_modelo_exportacao_sap	= tab_1.tabpage_1.dw_2.GetItemNumber(ll_for, 'cd_modelo_exportacao_sap')
	
	if ls_id_processa = 'S' then
		ls_nr_atualizacao = tab_1.TabPage_1.dw_2.Object.nr_atualizacao[ll_for]
	
		if ll_cd_modelo_exportacao_sap = 1 then
			ll_nr_atualizacao	= Long(ls_nr_atualizacao)
			
			update log_exportacao_sap
				set id_reprocessar = 'S', 
					 id_status_integracao = 'C', 
					 de_erro = :ls_mensagem
			 where nr_atualizacao = :ll_nr_atualizacao
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgDbError("Erro ao atualizar o controle.")
				Return
			End If
			
			If Sqlca.SQLNRows > 1 Then
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Foram atualizados mais registros do que o esperado .", StopSign!)
				SqlCa.of_RollBack();
			End If
		Else
			update log_exportacao
				set id_situacao_exportacao = 'C', 
					 id_situacao_retorno = Case When id_situacao_retorno = 'P' or id_situacao_retorno = 'E' 
					 							  Then 'C' 
												  Else id_situacao_retorno
												  End, 
					 de_erro = :ls_null
			 where nr_exportacao = :ls_nr_atualizacao
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgDbError("Erro ao atualizar o controle.")
				Return
			End If
		End If
	End If
Next

SqlCa.of_Commit();

tab_1.TabPage_1.dw_2.Event ue_Recuperar()

Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Aguarde a interface rodar automaticamente ou execute manualmente nesta tela.")




end event

