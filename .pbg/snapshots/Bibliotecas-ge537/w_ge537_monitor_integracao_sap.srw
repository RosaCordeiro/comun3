HA$PBExportHeader$w_ge537_monitor_integracao_sap.srw
forward
global type w_ge537_monitor_integracao_sap from dc_w_2tab_consulta_selecao_lista_det
end type
type gb_4 from groupbox within tabpage_1
end type
type dw_4 from dc_uo_dw_base within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type cb_3 from commandbutton within tabpage_1
end type
type dw_5 from dc_uo_dw_base within tabpage_2
end type
type dw_6 from dc_uo_dw_base within tabpage_2
end type
type gb_7 from groupbox within tabpage_2
end type
type gb_6 from groupbox within tabpage_2
end type
type st_confirmar from statictext within w_ge537_monitor_integracao_sap
end type
type gb_5 from groupbox within w_ge537_monitor_integracao_sap
end type
end forward

global type w_ge537_monitor_integracao_sap from dc_w_2tab_consulta_selecao_lista_det
string tag = "w_ge537_monitor_integracao_sap"
integer width = 5088
integer height = 2556
string title = "GE537 - Monitor Notas Fiscais - Integra$$HEX2$$e700e300$$ENDHEX$$o SAP"
st_confirmar st_confirmar
gb_5 gb_5
end type
global w_ge537_monitor_integracao_sap w_ge537_monitor_integracao_sap

type variables
uo_filial io_filial

Boolean ivb_Check
String ivs_Operador

uo_ge473_comum iuo_ge473_comum
end variables

forward prototypes
public subroutine wf_insere_padrao ()
public subroutine wf_setar_parametros_monitor_erros (long al_filial, string as_tipo)
public function boolean wf_habilitar_menu ()
public function boolean wf_salvar ()
end prototypes

public subroutine wf_insere_padrao ();
end subroutine

public subroutine wf_setar_parametros_monitor_erros (long al_filial, string as_tipo);Date	ld_null


SetNull(ld_null)

This.Tab_1.TabPage_1.dw_1.Object.dt_inicio_inclusao[1] = Date('1900-01-01')
This.Tab_1.TabPage_1.dw_1.Object.dt_termino_inclusao[1] = Date('2500-12-31')

This.Tab_1.TabPage_1.dw_1.Object.id_status[1]	= as_tipo

io_Filial.of_Localiza_Filial(String(al_filial))
		
If io_Filial.Localizada  Then
	Tab_1.TabPage_1.dw_1.Object.cd_filial			[1] = io_Filial.cd_filial
	Tab_1.TabPage_1.dw_1.Object.nm_fantasia	[1] = io_Filial.nm_fantasia
End If

This.Tab_1.TabPage_1.dw_2.Trigger Event ue_recuperar()
end subroutine

public function boolean wf_habilitar_menu ();ivm_Menu.mf_confirmar(True)
ivm_Menu.mf_Cancelar(True)

Return True
end function

public function boolean wf_salvar ();Dec{2}	ldc_nftot_alt, ldc_nfnett_alt, ldc_nfoth_alt
Long		ll_row_dw3, ll_nr_sequencial, ll_docnum, ll_rowcount_dw5, ll_for, ll_itmnum
String	ls_mandt, ls_sqlerr


This.tab_1.tabpage_2.dw_3.AcceptText()
This.tab_1.tabpage_2.dw_5.AcceptText()

ll_row_dw3	= This.tab_1.tabpage_2.dw_3.GetRow()

if ll_row_dw3 <= 0 then Return False

ldc_nftot_alt		= This.tab_1.tabpage_2.dw_3.GetItemNumber(ll_row_dw3, 'nftot_alt')
ls_mandt				= This.tab_1.tabpage_2.dw_3.GetItemString(ll_row_dw3, 'mandt')
ll_docnum			= This.tab_1.tabpage_2.dw_3.GetItemNumber(ll_row_dw3, 'docnum')
ll_nr_sequencial	= This.tab_1.tabpage_2.dw_3.GetItemNumber(ll_row_dw3, 'nr_sequencial')

if IsNull(ldc_nftot_alt ) then ldc_nfoth_alt = 0

update j_1bnfdoc_1
	set nftot_alt	= :ldc_nftot_alt
 where mandt 			= :ls_mandt 
	and docnum 			= :ll_docnum 
	and nr_sequencial	= :ll_nr_sequencial;
	
Choose Case SQLCA.SQLCode
	Case -1
		ls_sqlerr	= SQLCA.SQLErrText
		SQLCA.of_rollback()
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Problema ao atualizar o campo nftot_alt da tabela j_1bnfdoc_1. Erro: ' + ls_sqlerr, StopSign!)
		Return False
End Choose

ll_rowcount_dw5	= This.tab_1.tabpage_2.dw_5.RowCount()

for ll_for	= 1 to ll_rowcount_dw5
	ll_itmnum		= This.tab_1.tabpage_2.dw_5.GetItemNumber(ll_for, 'itmnum')
	ldc_nfnett_alt	= This.tab_1.tabpage_2.dw_5.GetItemNumber(ll_for, 'nfnett_alt')
	ldc_nfoth_alt	= This.tab_1.tabpage_2.dw_5.GetItemNumber(ll_for, 'nfoth_alt')
	
	if IsNull(ldc_nfnett_alt) then ldc_nfnett_alt = 0
	if IsNull(ldc_nfoth_alt) then ldc_nfoth_alt = 0
	
	update j_1bnflin
		set nfnett_alt	= :ldc_nfnett_alt,
			 nfoth_alt	= :ldc_nfoth_alt
	 where mandt 			= :ls_mandt 
		and docnum 			= :ll_docnum 
		and nr_sequencial	= :ll_nr_sequencial
		and itmnum			= :ll_itmnum;
		
	Choose Case SQLCA.SQLCode
		Case -1
			ls_sqlerr	= SQLCA.SQLErrText
			SQLCA.of_rollback()
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Problema ao atualizar o campo nftot_alt da tabela j_1bnflin. Erro: ' + ls_sqlerr, StopSign!)
			Return False
	End Choose
next

SQLCA.of_commit()

MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Opera$$HEX2$$e700e300$$ENDHEX$$o realizada com sucesso.')

This.tab_1.SelectTab('tabpage_1')
This.tab_1.tabpage_1.dw_2.trigger event ue_recuperar()

Return True
end function

on w_ge537_monitor_integracao_sap.create
int iCurrent
call super::create
this.st_confirmar=create st_confirmar
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_confirmar
this.Control[iCurrent+2]=this.gb_5
end on

on w_ge537_monitor_integracao_sap.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_confirmar)
destroy(this.gb_5)
end on

event ue_postopen;call super::ue_postopen;Tab_1.TabPage_1.dw_1.Object.dt_inicio_inclusao[1] = RelativeDate(Date(gf_GetServerDate()),  -6)
Tab_1.TabPage_1.dw_1.Object.dt_termino_inclusao[1] = Date(gf_GetServerDate())

wf_insere_padrao()

Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Recuperar(True)

Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_SalvarComo(True)

iuo_ge473_comum	= Create uo_ge473_comum

//#if defined DEBUG then
//   tab_1.tabpage_1.cb_processar.visible = True
//#end if
//

end event

event open;call super::open;io_Filial = Create uo_Filial

ivb_Check = False
end event

event close;call super::close;Destroy(io_Filial)
end event

event ue_save;call super::ue_save;wf_salvar()

return 0
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge537_monitor_integracao_sap
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge537_monitor_integracao_sap
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge537_monitor_integracao_sap
integer x = 23
integer y = 4
integer width = 5006
integer height = 2352
end type

event tab_1::selectionchanged;//OverRide

//Tab_1.TabPage_2.cbx_1.Checked = False
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 4969
integer height = 2236
gb_4 gb_4
dw_4 dw_4
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
end type

on tabpage_1.create
this.gb_4=create gb_4
this.dw_4=create dw_4
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.dw_4
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_3
end on

on tabpage_1.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.dw_4)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer x = 46
integer y = 344
integer width = 4896
integer height = 1564
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer x = 37
integer width = 4050
integer height = 324
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 59
integer y = 72
integer width = 4014
integer height = 260
string dataobject = "dw_ge537_parametros"
end type

event dw_1::itemchanged;call super::itemchanged;Long	ll_Nulo

If dwo.Name = "nm_fantasia" Then
	
	SetNull(ll_Nulo)
	
	If data = "" or IsNull(data) Then
		This.Object.cd_filial[1] = ll_Nulo
	Else
		If Data <> io_filial.nm_fantasia Then Return 1
	End If	
	
End If


end event

event dw_1::ue_key;call super::ue_key;String	ls_Coluna,&
		ls_Filial

If Key = KeyEnter! Then

	ls_Coluna = This.GetColumnName()

	If ls_Coluna = "nm_fantasia" Then

		ls_Filial = Tab_1.TabPage_1.dw_1.GetText()

		io_Filial.of_Localiza_Filial(ls_Filial)
		
		// Verifica se a Filial foi localizada e atualiza a DW
		If io_Filial.Localizada  Then
			Tab_1.TabPage_1.dw_1.Object.cd_filial			[1] = io_Filial.cd_filial
			Tab_1.TabPage_1.dw_1.Object.nm_fantasia	[1] = io_Filial.nm_fantasia
		Else
		
			SetNull(io_Filial.Cd_Filial)
			io_Filial.Nm_Fantasia = ""
			
			Tab_1.TabPage_1.dw_1.Object.cd_filial			[1] = io_filial.cd_filial
			Tab_1.TabPage_1.dw_1.Object.nm_fantasia	[1] = io_filial.nm_fantasia
			
		End If
		
	End If
End If
end event

event dw_1::constructor;call super::constructor;// Habilitar a coluna de sele$$HEX2$$e700e300$$ENDHEX$$o (freform)
This.of_SetColSelection(True)
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
event ue_mousemove pbm_mousemove
integer x = 69
integer y = 400
integer width = 4837
integer height = 1492
string dataobject = "dw_ge537_detalhes"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;//OverRide
Long	ll_Linhas,&
		ll_Filial,&
		ll_Linha,&
		ll_New_Row,&
		ll_Doc_Externo,&
		ll_Tipo_Log,&
		ll_Nr_NF
		
String ls_sql	

dc_uo_transacao    lo_transacao_SYB
dc_uo_ds_base 	 lds_SYB

Date	ldt_Inicio_Movimento,&
		ldt_Termino_Movimento,&
		ldt_Inicio_Inclusao,&
		ldt_Termino_Inclusao, &
		ldt_inicio_processada, &
		ldt_termino_processada
		
String	ls_Tipo_Doc,&
		ls_Documento_Sap,&
		ls_Ambiente_Sap,&
		ls_Status,&
		ls_Tipo_Doc_Mult,&
		ls_Tipo_Documento,&
		ls_Caixa,&
		ls_Contabil,&
		ls_NR_Doc,&
		ls_Chave_Legado,&
		ls_Divisao,&
		ls_Chave, ls_valor_exato
		
Tab_1.TabPage_1.dw_1.AcceptText()		

ldt_Inicio_Inclusao		= Tab_1.TabPage_1.dw_1.Object.dt_inicio_Inclusao[1]
ldt_Termino_Inclusao		= Tab_1.TabPage_1.dw_1.Object.dt_termino_Inclusao[1]
ldt_Inicio_Movimento		= Tab_1.TabPage_1.dw_1.Object.dt_inicio_movimentacao[1]
ldt_Termino_Movimento	= Tab_1.TabPage_1.dw_1.Object.dt_termino_movimentacao[1]
ldt_inicio_processada	= Tab_1.TabPage_1.dw_1.Object.dt_inicio_processada[1]
ldt_termino_processada	= Tab_1.TabPage_1.dw_1.Object.dt_termino_processada[1]
ll_Filial					= Tab_1.TabPage_1.dw_1.Object.cd_filial[1]
ls_Tipo_Doc 				= Tab_1.TabPage_1.dw_1.Object.id_tipo_doc[1]
ls_Status					= Tab_1.TabPage_1.dw_1.Object.id_status[1]
ls_Caixa						= Tab_1.TabPage_1.dw_1.Object.id_caixa[1]
ls_Contabil					= Tab_1.TabPage_1.dw_1.Object.id_contabilizacao[1]
ls_NR_Doc					= Tab_1.TabPage_1.dw_1.Object.nr_documento_sap[1]
ll_Doc_Externo				= Tab_1.TabPage_1.dw_1.Object.nr_documento_externo[1]
ls_Chave						= Tab_1.TabPage_1.dw_1.Object.cd_chave[1]
ll_Tipo_Log					= Tab_1.TabPage_1.dw_1.Object.id_tipo_log[1]
ls_Divisao					= String(Tab_1.TabPage_1.dw_1.Object.nr_divisao_sap[1])
ls_valor_exato 			= Tab_1.TabPage_1.dw_1.Object.id_valor_exato[1]
ll_Nr_NF						= Parent.dw_1.Object.nr_nf[1]

If IsNull(ldt_Inicio_Movimento) and Not IsNull(ldt_Termino_Movimento) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio da movimenta$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio_movimentacao")
	Return -1
End If

If IsNull(ldt_Termino_Movimento) and Not IsNull(ldt_Inicio_Movimento) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino da movimenta$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_termino_movimentacao")
	Return -1
End If

If ldt_Inicio_Movimento > ldt_Termino_Movimento Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio da movimenta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino da movimenta$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio_movimentacao")
	Return -1
End If

If IsNull(ldt_Inicio_Inclusao) and Not IsNull(ldt_Termino_Inclusao) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio da Inclus$$HEX1$$e300$$ENDHEX$$o.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio_inclusao")
	Return -1
End If

If IsNull(ldt_Termino_Inclusao) and Not IsNull(ldt_Inicio_Inclusao) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino da inclus$$HEX1$$e300$$ENDHEX$$o.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_termino_inclusao")
	Return -1
End If

If ldt_Inicio_Inclusao > ldt_Termino_Inclusao Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio da inclus$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino da inclus$$HEX1$$e300$$ENDHEX$$o.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_termino_inclusao")
	Return -1
End If

If ldt_inicio_processada > ldt_termino_processada Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio de processamento n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino de processamento.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio_processada")
	Return -1
End If

If ls_Status = 'I'  or  ls_Status = 'T' Then
//	If DaysAfter ( ldt_Inicio_inclusao, ldt_Termino_inclusao) > 20 Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Devido ao grande volume de informa$$HEX2$$e700f500$$ENDHEX$$es, o per$$HEX1$$ed00$$ENDHEX$$odo entre as datas de inclus$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser superior a 20 dias.")
//		Return -1
//	End If
	
	If IsNull(ll_Filial) and IsNull(ls_Documento_Sap) and IsNull(ls_Caixa) and IsNull(ls_NR_Doc) and IsNull(ls_Tipo_Doc) Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe pelo menos um par$$HEX1$$e200$$ENDHEX$$metro [FILIAL, DOC. SAP, NR DOC ou TIPO DE DOC].")
		Return -1
	End If
End If

dw_2.SetRedraw(False)

If Not IsNUll(ldt_Inicio_Movimento) and Not IsNull(ldt_Termino_Movimento) Then
	This.of_AppendWhere_SubQuery(" cast(jdoc.docdat as date)  between '"+String(ldt_Inicio_Movimento, "YYYYMMDD")+"' and '"+String(ldt_Termino_Movimento, "YYYYMMDD")+"'", 1)
End If

If Not IsNUll(ldt_inicio_processada) and Not IsNull(ldt_termino_processada) Then
	This.of_AppendWhere_SubQuery(" cast(jdoc2.pstdat as date)  between '"+String(ldt_inicio_processada, "YYYYMMDD")+"' and '"+String(ldt_termino_processada, "YYYYMMDD")+"'", 1)
End If

If Not IsNUll(ldt_Inicio_inclusao) and Not IsNull(ldt_Termino_inclusao) Then
	This.of_AppendWhere_SubQuery("jdoc.dh_inclusao between '"+String(ldt_Inicio_inclusao, "YYYYMMDD 00:00:00")+"' and '"+String(ldt_Termino_inclusao, "YYYYMMDD 23:59:59")+"'", 1)
End If

ls_sql = this.Object.DataWindow.Table.Select

If Not IsNUll(ll_Filial) Then
	This.of_AppendWhere_SubQuery("f.cd_filial = "+String(ll_Filial), 1)
End If

If ll_Nr_NF > 0 Then
	This.of_AppendWhere_SubQuery("cast(coalesce(case when jdoc2.nfnum = 0 then null else jdoc2.nfnum end, cast(jdoc2.nfenum as integer)) as varchar) like '"+String(ll_Nr_NF) + "'", 1)
End If

If Not IsNull(ls_Divisao) and ls_Divisao <> "" Then
	This.of_AppendWhere_SubQuery("jdoc.branch = "+ls_Divisao, 1)
End If

If Not IsNUll(ls_Tipo_Doc) and (ls_Tipo_Doc <> "" )	Then
	If ls_Tipo_Doc = 'T' then 
		This.of_AppendWhere_SubQuery("upper(jdoc2.nftype) IN ('Z4', 'A1', 'YP', 'YB', 'ZA', 'Z6', 'YC', 'ZI', 'ZV', 'ZS', 'ZF', 'YA', 'ZM', 'ZJ', 'YU', 'Z2', 'YY', 'YH', 'LE', 'SM', 'SC', 'RC', 'S5', 'CM') ", 1)
	 else
		This.of_AppendWhere_SubQuery("upper(jdoc2.nftype) = '"+upper(ls_Tipo_Doc)+"'", 1)
	End If
End If 

If Not IsNull(ls_NR_Doc) and Trim(ls_NR_Doc) <> '' Then  /* Belnr- SAP */
		This.of_AppendWhere_SubQuery("jdoc.belnr = '"  + ls_NR_Doc + "'" , 1)
End If

If Not IsNull(ll_Doc_Externo) and ll_Doc_Externo > 0 Then
	This.of_AppendWhere_SubQuery("jdoc.docnum = " + String(ll_Doc_Externo),1)
End If

If  ls_Status <> "T" Then
	This.of_AppendWhere_SubQuery("coalesce(jdoc.id_status,'C') = '" + ls_Status + "'", 1)
End If	

ls_sql = this.Object.DataWindow.Table.Select

If This.Retrieve(1000) < 0 Then
	This.Reset()
	Return -1
End If

ll_Linhas = This.RowCount()

//S$$HEX1$$f300$$ENDHEX$$ pega os lan$$HEX1$$e700$$ENDHEX$$amentos do Sybase
If ls_Contabil = 'S' or ls_Caixa = "S"Then 
	dw_2.SetRedraw(True)
	Return ll_Linhas
End If

If IsValid(lo_transacao_SYB) Then
		If lo_transacao_SYB.Of_IsConnected() Then	lo_transacao_SYB.Of_disconnect()
		Destroy(lo_transacao_SYB)
End If
	
If IsValid(lds_SYB) Then
		Destroy(lds_SYB)
End If
	
If IsValid(w_Aguarde) Then
		Close(w_Aguarde)
End If
	
SetPointer(Arrow!)

This.Trigger Event RowFocusChanged(dw_2.getRow())

dw_2.SetRedraw(True)

Return This.RowCount()
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;String	ls_Erro_Item	= "",&
		ls_Erro_Cabecalho = "", &
		ls_id_status


Tab_1.TabPage_1.dw_4.reset()

If currentRow > 0 Then
	ls_id_status	= This.Object.id_status[currentRow]
	
	If ls_id_status = 'E' Then
		ls_Erro_Item = "H$$HEX1$$c100$$ENDHEX$$ ERROS NOS ITENS DESSE DOCUMENTO"
		
		ls_Erro_Cabecalho	= This.Object.observacao[currentRow]
	
		Tab_1.TabPage_1.dw_4.Object.de_erro[1] = ls_Erro_Cabecalho + "  " + ls_Erro_Item
	End If
End If
end event

event dw_2::doubleclicked;call super::doubleclicked;Long lvl_Row
	  
String lvs_Marcacao,&
	   lvs_Nulo 

SetNull(lvs_Nulo)

Choose Case dwo.Name 
			
	Case 'st_selecionar'
			
		If ivb_Check Then
			lvs_Marcacao = 'N'
			ivb_Check = False
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
		Else
			lvs_Marcacao = 'S'
			ivb_Check = True
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
		End If
		
		For lvl_Row = 1 To This.RowCount()
					
			This.Object.id_selecionar[lvl_Row] = lvs_Marcacao
			
		Next
		
End Choose
end event

event dw_2::constructor;call super::constructor;// Habilitar a linha de sele$$HEX2$$e700e300$$ENDHEX$$o (list)
This.of_SetRowSelection()

end event

event dw_2::destructor;call super::destructor;destroy iuo_ge473_comum
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 4969
integer height = 2236
dw_5 dw_5
dw_6 dw_6
gb_7 gb_7
gb_6 gb_6
end type

on tabpage_2.create
this.dw_5=create dw_5
this.dw_6=create dw_6
this.gb_7=create gb_7
this.gb_6=create gb_6
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_5
this.Control[iCurrent+2]=this.dw_6
this.Control[iCurrent+3]=this.gb_7
this.Control[iCurrent+4]=this.gb_6
end on

on tabpage_2.destroy
call super::destroy
destroy(this.dw_5)
destroy(this.dw_6)
destroy(this.gb_7)
destroy(this.gb_6)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer x = 5
integer y = 24
integer width = 4521
integer height = 488
string text = "Detalhes SAP"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 32
integer y = 80
integer width = 4480
integer height = 408
string dataobject = "dw_ge537_consulta_nf_detalhes"
end type

event dw_3::ue_recuperar;Integer 	li_linha_ativa, li_linhas
Long		ll_docnum, ll_nr_sequencial
String	ls_mandt


tab_1.tabpage_2.dw_6.Reset()

li_linha_ativa = Tab_1.TabPage_1.dw_2.GetRow()

ll_docnum			= Tab_1.TabPage_1.dw_2.Object.docnum[li_linha_ativa]
ll_nr_sequencial	= Tab_1.TabPage_1.dw_2.Object.nr_sequencial[li_linha_ativa]
ls_mandt				= Tab_1.TabPage_1.dw_2.Object.mandt[li_linha_ativa]

li_linhas = This.Retrieve(ls_mandt, ll_docnum, ll_nr_sequencial)

if li_linhas > 0 then
	Tab_1.TabPage_2.dw_5.trigger event ue_recuperar()
end if

Return li_linhas
end event

event dw_3::getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;Long		ll_linha_atual, ll_cd_filial, ll_cd_filial_destino, ll_null
String	ls_cd_fornecedor_sap, ls_nm_razao_social, ls_log, ls_cd_filial_sap, ls_nm_fantasia, ls_cd_fornecedor, ls_nr_cgc, &
			ls_nftype, ls_null


SetNull(ls_null)
SetNull(ll_null)

ll_linha_atual	= Tab_1.TabPage_1.dw_2.GetRow()

if ll_linha_atual < 1 then return -1

ls_nr_cgc 				= Tab_1.TabPage_1.dw_2.Object.nr_cgc[ll_linha_atual]
ls_nftype				= Tab_1.TabPage_1.dw_2.Object.nftype[ll_linha_atual]

ll_linha_atual	= Tab_1.TabPage_2.dw_3.GetRow()

if ll_linha_atual < 1 then return -1

//ls_cd_fornecedor_sap	= Tab_1.TabPage_2.dw_3.Object.cd_fornecedor_sap[ll_linha_atual]
ls_cd_filial_sap		= Tab_1.TabPage_2.dw_3.Object.cd_filial_sap[ll_linha_atual]

if ls_nftype = 'ZA' or ls_nftype = 'Z6' or ls_nftype = 'YC' then
	ll_cd_filial_destino	= 0
	
	select top 1 cd_filial,
			 nm_fantasia
	  into :ll_cd_filial_destino,
			 :ls_nm_fantasia
	  from filial 
	 where nr_cgc 			= :ls_nr_cgc and
			 id_situacao 	= 'A';
			 
	if sqlca.SqlCode < 0 then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia' + '~nErro ao encontrar filial pelo cgc: ~n' + sqlca.SqlErrText, StopSign!)
		
		return -1
	end if
	
//	if ll_cd_filial_destino > 0 and not IsNull(ll_cd_filial_destino) then
//		Tab_1.TabPage_2.dw_3.SetItem(ll_linha_atual, 'nm_fornecedor', ls_nm_fantasia + ' (' + ls_nr_cgc + ')')
//		Tab_1.TabPage_2.dw_3.SetItem(ll_linha_atual, 'cd_fornecedor_sap', ll_cd_filial_destino)
//	else
//		Tab_1.TabPage_2.dw_3.SetItem(ll_linha_atual, 'nm_fornecedor', ls_null)
//		Tab_1.TabPage_2.dw_3.SetItem(ll_linha_atual, 'cd_fornecedor_sap', ll_null)
//	end if
	
	//Tab_1.TabPage_2.dw_3.Object.cd_fornecedor_t.text	= 'Filial Destino: '
	//Tab_1.TabPage_2.dw_3.Object.cd_filial_sap_t.text	= 'Filial Origem: '
else	 
//	select nm_razao_social,
//			 cd_fornecedor
//	  into :ls_nm_razao_social,
//			 :ls_cd_fornecedor
//	  from fornecedor
//	 where cd_fornecedor_sap	= :ls_cd_fornecedor_sap;
	 
//	if Trim(ls_cd_fornecedor) <> '' and not IsNull(ls_cd_fornecedor) then
//		Tab_1.TabPage_2.dw_3.SetItem(ll_linha_atual, 'nm_fornecedor', ls_nm_razao_social + ' (' + ls_cd_fornecedor_sap + ')')
//		Tab_1.TabPage_2.dw_3.SetItem(ll_linha_atual, 'cd_fornecedor_sap', ls_cd_fornecedor)
//	else
//		Tab_1.TabPage_2.dw_3.SetItem(ll_linha_atual, 'nm_fornecedor', ls_null)
//		Tab_1.TabPage_2.dw_3.SetItem(ll_linha_atual, 'cd_fornecedor_sap', ll_null)
//	end if
//	
//	Tab_1.TabPage_2.dw_3.Object.cd_fornecedor_t.text	= 'Fornecedor: '
//	Tab_1.TabPage_2.dw_3.Object.cd_filial_sap_t.text	= 'Filial: '
end if

if not iuo_ge473_comum.of_localiza_codigo_filial_legado(ls_cd_filial_sap, ref ll_cd_filial, ref ls_log) then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi localizada a filial com o c$$HEX1$$f300$$ENDHEX$$digo sap: ' + ls_cd_filial_sap + '.', StopSign!)
	
	return -1
end if

select nm_fantasia
  into :ls_nm_fantasia
  from filial
 where cd_filial	= :ll_cd_filial;

//if ll_cd_filial > 0 and not IsNull(ll_cd_filial) then
//	Tab_1.TabPage_2.dw_3.SetItem(ll_linha_atual, 'nm_filial', ls_nm_fantasia + ' (' + String(ls_cd_filial_sap) + ')')
//	Tab_1.TabPage_2.dw_3.SetItem(ll_linha_atual, 'cd_filial_sap', String(ll_cd_filial))
//end if

return pl_linhas
end event

event dw_3::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_3::itemchanged;call super::itemchanged;wf_habilitar_menu()
end event

event dw_3::editchanged;call super::editchanged;wf_habilitar_menu()
end event

type gb_4 from groupbox within tabpage_1
integer x = 46
integer y = 1904
integer width = 4896
integer height = 328
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Erro de Integra$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within tabpage_1
integer x = 69
integer y = 1956
integer width = 4837
integer height = 268
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge537_erro"
end type

type cb_1 from commandbutton within tabpage_1
integer x = 4489
integer y = 136
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
string text = "Ressincronizar"
end type

event clicked;Boolean	lb_passou	= false
DateTime	ldh_null
Long		ll_for, ll_nr_sequencial, ll_docnum
String	ls_mandt, ls_null, ls_id_selecionar


SetNull(ls_null)
SetNull(ldh_null)


If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE537_EXECUTA_RESINCRONIZA", ref ivs_Operador) Then 
	Return
End If


for ll_for = 1 to Tab_1.TabPage_1.dw_2.RowCount()
	ls_id_selecionar	= Tab_1.TabPage_1.dw_2.Object.id_selecionar[ll_for]
	
	if ls_id_selecionar = 'S' then
		lb_passou	= true
		
		ll_nr_sequencial	= Tab_1.TabPage_1.dw_2.Object.nr_sequencial[ll_for]
		ll_docnum			= Tab_1.TabPage_1.dw_2.Object.docnum[ll_for]
		ls_mandt				= Tab_1.TabPage_1.dw_2.Object.mandt[ll_for]
		
		update j_1bnfdoc_1
			set j_1bnfdoc_1.id_status 			= 'C', 
				 j_1bnfdoc_1.dh_processamento = :ldh_null, 
				 j_1bnfdoc_1.de_log 				= :ls_null
		 where j_1bnfdoc_1.docnum 			= :ll_docnum and 
				 j_1bnfdoc_1.mandt 			= :ls_mandt and 
				 j_1bnfdoc_1.nr_sequencial = :ll_nr_sequencial;
			
		if sqlca.SqlCode = -1 then
			sqlca.of_rollback()
			
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: clicked' + '~nProblemas ao atualizar nota para ressincronizar: ~n' + sqlca.SqlErrText)
			
			return
		end if
	end if
next

if not lb_passou then
	sqlca.of_rollback()
			
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Selecione ao menos uma nota.')
	
	return
end if

sqlca.of_commit()

Tab_1.TabPage_1.dw_2.Trigger Event ue_recuperar()
end event

type cb_2 from commandbutton within tabpage_1
integer x = 4489
integer y = 244
integer width = 462
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Processar Nota"
end type

event clicked;Long 		ll_DocNum, ll_for
String	ls_id_selecionar

uo_ge537_nota_fiscal  lvo_nota



If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE537_PROCESSA_NOTA", ref ivs_Operador) Then 
	Return
End If


If Tab_1.TabPage_1.dw_2.RowCount() <= 0 Then Return

Tab_1.TabPage_1.dw_2.AcceptText( )

for ll_for = 1 to Tab_1.TabPage_1.dw_2.RowCount()
	ls_id_selecionar	= Tab_1.TabPage_1.dw_2.Object.id_selecionar[ll_for]
	
	if ls_id_selecionar = 'S' then
		lvo_nota = Create uo_ge537_nota_fiscal
		
		ll_DocNum = Tab_1.TabPage_1.dw_2.Object.docnum[ll_for]
		
		lvo_nota.of_processa_atualizacao(ll_DocNum)
		
		Destroy uo_ge537_nota_fiscal
	end if
next

dw_2.Trigger Event ue_recuperar()

Destroy(lvo_nota)

return 
end event

type cb_3 from commandbutton within tabpage_1
boolean visible = false
integer x = 4210
integer y = 28
integer width = 475
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar DOC"
end type

event clicked;uo_ge537_nota_fiscal  lvo_nota

string ls_log




//for ll_for = 1 to Tab_1.TabPage_1.dw_2.RowCount()
//	ls_id_selecionar	= Tab_1.TabPage_1.dw_2.Object.id_selecionar[ll_for]
//	
//	if ls_id_selecionar = 'S' then
lvo_nota = Create uo_ge537_nota_fiscal

lvo_nota.il_docnum_ref = 1019666
lvo_nota.il_cd_filial = 534
lvo_nota.il_nr_nf = 612344
lvo_nota.is_de_especie	= 'NFE'
lvo_nota.is_de_serie	= '3'
						
if lvo_nota.of_cancela_documento(ls_log) then
	SQLCA.of_commit()
else
	messagebox('', ls_log)
end if
//next
end event

type dw_5 from dc_uo_dw_base within tabpage_2
integer x = 32
integer y = 564
integer width = 4480
integer height = 1040
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge537_det_item_nf"
boolean vscrollbar = true
end type

event ue_recuperar;Integer 	li_linha_ativa, li_linhas
Long		ll_docnum, ll_nr_sequencial, ll_nr_integracao, ll_cd_motivo_devolucao, ll_linha
String	ls_mandt, ls_contrato, ls_de_motivo_devolucao


li_linha_ativa = Tab_1.TabPage_1.dw_2.GetRow()

ll_docnum			= Tab_1.TabPage_1.dw_2.Object.docnum[li_linha_ativa]
ll_nr_sequencial	= Tab_1.TabPage_1.dw_2.Object.nr_sequencial[li_linha_ativa]
ls_mandt				= Tab_1.TabPage_1.dw_2.Object.mandt[li_linha_ativa]

li_linhas = This.Retrieve(ls_mandt, ll_docnum, ll_nr_sequencial)

if li_linhas > 0 then
	ls_contrato	= this.Object.contrato[1]
		
	ls_contrato	= gf_replace(ls_contrato, 'DV|','', 1)
	
	if IsNumber(ls_contrato) then
		ll_nr_integracao	= Long(ls_contrato)
	else
		SetNull(ll_nr_integracao)
	end if
	
	select de_motivo_devolucao
	  into :ls_de_motivo_devolucao
	  from wms_int_sap as w inner join motivo_devolucao_compra as m on w.cd_motivo_devolucao = m.cd_motivo_devolucao
	 where nr_integracao	= :ll_nr_integracao;
	
	ll_linha	= tab_1.tabpage_2.dw_3.GetRow()
	
	if ll_linha > 0 then
		tab_1.tabpage_2.dw_3.SetItem(ll_linha, 'de_motivo_devolucao', ls_de_motivo_devolucao)
	end if
end if

if li_linhas > 0 then
	Tab_1.TabPage_2.dw_6.trigger event ue_recuperar()
end if

Return li_linhas
end event

event rowfocuschanged;call super::rowfocuschanged;Tab_1.TabPage_2.dw_6.trigger event ue_recuperar()
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event itemchanged;call super::itemchanged;wf_habilitar_menu()
end event

type dw_6 from dc_uo_dw_base within tabpage_2
integer x = 32
integer y = 1672
integer width = 4320
integer height = 500
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge537_det_item_imp_nf"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;Integer 	li_linha_ativa, li_linhas
Long		ll_docnum, ll_nr_sequencial, ll_itmnum
String	ls_mandt


li_linha_ativa = Tab_1.TabPage_1.dw_2.GetRow()

if li_linha_ativa < 1 then return li_linha_ativa

ll_docnum			= Tab_1.TabPage_1.dw_2.Object.docnum[li_linha_ativa]
ll_nr_sequencial	= Tab_1.TabPage_1.dw_2.Object.nr_sequencial[li_linha_ativa]
ls_mandt				= Tab_1.TabPage_1.dw_2.Object.mandt[li_linha_ativa]

li_linha_ativa = Tab_1.TabPage_2.dw_5.GetRow()

if li_linha_ativa < 1 then return li_linha_ativa

ll_itmnum	= Tab_1.TabPage_2.dw_5.Object.itmnum[li_linha_ativa]

li_linhas = This.Retrieve(ls_mandt, ll_docnum, ll_nr_sequencial, ll_itmnum)

Return li_linhas
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type gb_7 from groupbox within tabpage_2
integer x = 5
integer y = 1612
integer width = 4521
integer height = 572
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Impostos SAP"
borderstyle borderstyle = styleraised!
end type

type gb_6 from groupbox within tabpage_2
integer x = 5
integer y = 512
integer width = 4521
integer height = 1104
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos SAP"
borderstyle borderstyle = styleraised!
end type

type st_confirmar from statictext within w_ge537_monitor_integracao_sap
boolean visible = false
integer x = 3968
integer y = 732
integer width = 846
integer height = 68
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 15793151
string text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos"
boolean focusrectangle = false
end type

type gb_5 from groupbox within w_ge537_monitor_integracao_sap
integer x = 23
integer y = 812
integer width = 3456
integer height = 1168
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos"
borderstyle borderstyle = styleraised!
end type

