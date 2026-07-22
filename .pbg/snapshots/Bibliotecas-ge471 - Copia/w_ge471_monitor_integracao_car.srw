HA$PBExportHeader$w_ge471_monitor_integracao_car.srw
forward
global type w_ge471_monitor_integracao_car from dc_w_2tab_consulta_selecao_lista_det
end type
type cb_reprocessar from commandbutton within tabpage_1
end type
type st_confirmar from statictext within tabpage_1
end type
type cb_revisar from commandbutton within tabpage_1
end type
type gb_detalhe_log from groupbox within tabpage_2
end type
type gb_itens from groupbox within tabpage_2
end type
type dw_4 from dc_uo_dw_base within tabpage_2
end type
type dw_5 from dc_uo_dw_base within tabpage_2
end type
end forward

global type w_ge471_monitor_integracao_car from dc_w_2tab_consulta_selecao_lista_det
integer width = 4544
integer height = 2524
string title = "GE471 - Monitor Interface - CAR"
end type
global w_ge471_monitor_integracao_car w_ge471_monitor_integracao_car

type variables
Boolean ivb_Check = False

uo_filial ivo_filial

end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/* Integra$$HEX2$$e700e300$$ENDHEX$$o CAR */
ldwc_Child  = Tab_1.Tabpage_1.dw_1.of_InsertRow_DDDW("cd_integracao" )			

ldwc_Child.SetItem(1, "cd_integracao", ""	)
ldwc_Child.SetItem(1, "de_integracao", "TODOS")
ldwc_Child.SetItem(1, "id_situacao", "A")

ldwc_Child.SetFilter("id_situacao = 'A'")
ldwc_Child.Filter()

Tab_1.Tabpage_1.dw_1.Object.cd_integracao[1] = ""
end subroutine

on w_ge471_monitor_integracao_car.create
int iCurrent
call super::create
end on

on w_ge471_monitor_integracao_car.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;ivo_filial = Create uo_filial

Maxheight = 9999
ivl_largura_1 = 4500
ivl_largura_2 = 4500

ivm_menu.ivb_permite_imprimir = True
end event

event resize;call super::resize;Tab_1.Height	= NewHeight - Tab_1.Y - 16
Tab_1.Width	= NewWidth - Tab_1.X - 16

Tab_1.Tabpage_1.gb_2.Height =  Tab_1.Height - Tab_1.Tabpage_1.gb_2.Y - 140
Tab_1.Tabpage_1.dw_2.Height =  Tab_1.Height - Tab_1.Tabpage_1.dw_2.Y - 170

Tab_1.Tabpage_2.gb_itens.Height =  Tab_1.Height - Tab_1.Tabpage_2.gb_itens.Y - 140
Tab_1.Tabpage_2.dw_4.Height =  Tab_1.Height - Tab_1.Tabpage_2.dw_4.Y - 170 - Tab_1.Tabpage_2.gb_detalhe_log.Height
Tab_1.Tabpage_2.gb_detalhe_log.Y = Tab_1.Height - Tab_1.Tabpage_2.gb_detalhe_log.Height - 170
Tab_1.Tabpage_2.dw_5.Y = Tab_1.Tabpage_2.gb_detalhe_log.Y + 80

ivl_altura_1 = NewHeight - 4
ivl_altura_2 = ivl_altura_1
end event

event close;call super::close;If IsValid(ivo_filial) Then Destroy(ivo_filial)
end event

event ue_print;call super::ue_print;SetPointer(HourGlass!)

Choose Case Tab_1.SelectedTab
	Case 1
		Tab_1.TabPage_1.dw_2.Event ue_Print()
		
	Case 2
		Tab_1.TabPage_2.dw_4.Event ue_Print()
		
End Choose

SetPointer(Arrow!)
end event

event ue_printimmediate;call super::ue_printimmediate;SetPointer(HourGlass!)

Choose Case Tab_1.SelectedTab
	Case 1
		Tab_1.TabPage_1.dw_2.Event ue_PrintImmediate()
		
	Case 2
		Tab_1.TabPage_2.dw_4.Event ue_PrintImmediate()
		
End Choose

SetPointer(Arrow!)
end event

event ue_saveas;call super::ue_saveas;SetPointer(HourGlass!)

Choose Case Tab_1.SelectedTab
	Case 1
		Tab_1.TabPage_1.dw_2.Event ue_SaveAs()
		
	Case 2
		Tab_1.TabPage_2.dw_4.Event ue_SaveAs()
		
End Choose

SetPointer(Arrow!)
end event

event ue_postopen;call super::ue_postopen;wf_insere_padrao()
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge471_monitor_integracao_car
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge471_monitor_integracao_car
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge471_monitor_integracao_car
integer y = 4
integer width = 4475
integer height = 2320
end type

event tab_1::selectionchanging;call super::selectionchanging;SetPointer(HourGlass!)

If NewIndex = 2 Then
	If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
		// das DW's de detalhes
		Tab_1.TabPage_2.dw_4.Event ue_Retrieve()
	End If
End If		

SetPointer(Arrow!)

Return AncestorReturnValue
end event

event tab_1::selectionchanged;call super::selectionchanged;SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		
		This.TabPage_1.dw_2.ivm_menu.mf_SalvarComo(This.TabPage_1.dw_2.RowCount() > 0)
		This.TabPage_1.dw_2.ivm_menu.mf_Imprimir(This.TabPage_1.dw_2.RowCount() > 0)
	Case 2

		This.TabPage_2.dw_3.ivm_menu.mf_SalvarComo(This.TabPage_2.dw_3.RowCount() > 0)
		This.TabPage_2.dw_3.ivm_menu.mf_Imprimir(This.TabPage_2.dw_3.RowCount() > 0)
End Choose

SetPointer(Arrow!)

This.Height = This.Height - 16
This.Width = This.Width - 16

Return AncestorReturnValue
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 4439
integer height = 2204
cb_reprocessar cb_reprocessar
st_confirmar st_confirmar
cb_revisar cb_revisar
end type

on tabpage_1.create
this.cb_reprocessar=create cb_reprocessar
this.st_confirmar=create st_confirmar
this.cb_revisar=create cb_revisar
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_reprocessar
this.Control[iCurrent+2]=this.st_confirmar
this.Control[iCurrent+3]=this.cb_revisar
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_reprocessar)
destroy(this.st_confirmar)
destroy(this.cb_revisar)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 596
integer width = 4393
integer height = 1592
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 4393
integer height = 480
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer width = 4329
integer height = 400
string dataobject = "dw_ge471_selecao"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case Dwo.Name	
	Case 'nm_fantasia' 
		If Data <> ivo_filial.nm_fantasia Then
			If Data <> '' Then
				Return 1
			Else
				ivo_filial.of_inicializa( )
				This.Object.cd_filial		[Row] = ivo_filial.cd_filial
				This.Object.nm_fantasia	[Row] = ivo_filial.nm_fantasia
			End If
		End If
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	This.AcceptText( )
	
	Choose Case This.GetColumnName() 
			
		Case "nm_fantasia"
			ivo_filial.Of_Inicializa( )
			ivo_filial.Of_Localiza_Filial(This.GetText()) 
			
			If ivo_filial.Localizada Then
				This.Object.cd_filial		[1] = ivo_filial.cd_filial
				This.Object.nm_fantasia	[1] = ivo_filial.nm_fantasia
			End If		
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then 
	This.Object.nm_fantasia[1] = ivo_Filial.Nm_Fantasia
End If

end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
event ue_mouve_move pbm_mousemove
event ue_atualiza_botoes ( )
integer y = 664
integer width = 4334
integer height = 1484
string title = "Listagem Documentos Exportados"
string dataobject = "dw_ge471_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_mouve_move;If This.RowCount() > 0 Then
	If (xpos >= Long(This.Object.id_selecionado_t.X)  and (xpos <= (Long(This.Object.id_selecionado_t.X)  + 73))) and &
		  (ypos >= Long(This.Object.id_selecionado_t.Y)	and (ypos <= (Long(This.Object.id_selecionado_t.Y) + 64))) Then	 
		
		st_confirmar.Visible = True
		
		If ivb_Check Then
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
		Else
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
		End If
	Else
		st_confirmar.Visible = False
	End If
End If
end event

event dw_2::ue_atualiza_botoes();If This.RowCount() > 0 Then
	Parent.cb_reprocessar.Enabled = (This.Find("id_selecionar='S'", 1, This.RowCount()) > 0)
	Parent.cb_revisar.Enabled = Parent.cb_reprocessar.Enabled
Else
	Parent.cb_reprocessar.Enabled = False
	Parent.cb_revisar.Enabled = False
End If
end event

event dw_2::doubleclicked;call super::doubleclicked;Long lvl_Row
	  
String lvs_Marcacao,&
	   lvs_Nulo 

SetNull(lvs_Nulo)

Choose Case dwo.Name 
			
	Case 'id_selecionado_t'
			
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
		
		This.Post Event ue_Atualiza_Botoes()
End Choose
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Status
String lvs_Ambiente
String lvs_Tipo_Doc
String lvs_Revisao
String lvs_Especie
String lvs_Serie
String lvs_Excluido
String lvs_Docto_SAP
String lvs_Integracao

Long lvl_Filial
Long lvl_Transacao
Long lvl_Lote

Date lvdt_Export_Ini
Date lvdt_Export_Fim
Date lvdt_Movto_Ini
Date lvdt_Movto_Fim
Date lvdt_Proces_Ini
Date lvdt_Proces_Fim

Parent.dw_1.Accepttext( )

lvl_Filial				= Parent.dw_1.Object.cd_filial							[1]
lvs_Status			= Parent.dw_1.Object.id_status						[1]
lvs_Ambiente		= Parent.dw_1.Object.cd_ambiente_sap				[1]
lvs_Tipo_Doc		= Parent.dw_1.Object.id_tipo_doc						[1]
lvs_Integracao		= Parent.dw_1.Object.cd_integracao					[1]
lvdt_Export_Ini		= Parent.dw_1.Object.dt_inicio_exportacao			[1]
lvdt_Export_Fim	= Parent.dw_1.Object.dt_termino_exportacao		[1]
lvdt_Movto_Ini		= Parent.dw_1.Object.dt_inicio_movimentacao		[1]
lvdt_Movto_Fim		= Parent.dw_1.Object.dt_termino_movimentacao	[1]
lvs_Revisao			= Parent.dw_1.Object.id_revisao						[1]
lvs_Especie			= Parent.dw_1.Object.de_especie						[1]
lvs_Serie				= Parent.dw_1.Object.de_serie							[1]
lvl_Transacao		= Parent.dw_1.Object.nr_transacao					[1]
lvs_Docto_SAP		= Parent.dw_1.Object.nr_documento_sap			[1]
lvl_Lote				= Parent.dw_1.Object.nr_lote_envio					[1]
lvs_Excluido			= Parent.dw_1.Object.id_excluidos					[1]
lvdt_Proces_Ini		= Parent.dw_1.Object.dt_proc_ini						[1]
lvdt_Proces_Fim	= Parent.dw_1.Object.dt_proc_fim					[1]

If lvs_Ambiente <> "" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Ambiente: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(cd_ambiente_sap)',1)")
	This.Of_AppendWhere_Subquery( "a.cd_ambiente_sap = '"+ lvs_Ambiente+"'", 2)
End If

If lvs_Revisao <> "" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Status Revis$$HEX1$$e300$$ENDHEX$$o: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(id_revisao)',1)")
	This.Of_AppendWhere_Subquery( "coalesce(a.id_revisado,'P') = '"+ lvs_Revisao+"'", 2)	
End If

If lvs_Status <> "" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Status Log: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(id_status)',1)")
	If lvs_Status = "Y" Then
		This.Of_AppendWhere_Subquery( "a.id_situacao_log in ('E', 'F', 'V')", 2)
	Else
		This.Of_AppendWhere_Subquery( "a.id_situacao_log = '"+ lvs_Status+"'", 2)
	End If	
End If

If lvs_Especie <> "" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Esp$$HEX1$$e900$$ENDHEX$$cie: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(de_especie)',1)")
	This.Of_AppendWhere_Subquery( "a.de_especie = '"+ lvs_Especie+"'", 2)	
End If

If lvs_Serie <> "" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "S$$HEX1$$e900$$ENDHEX$$rie: "+lvs_Serie
	This.Of_AppendWhere_Subquery( "a.de_serie = '"+ lvs_Serie+"'", 2)	
End If

If Not IsNull(lvl_Filial) and (lvl_Filial > 0) Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Filial: "+ivo_filial.nm_fantasia+" ("+String(ivo_filial.cd_filial)+")"
	This.Of_AppendWhere_Subquery( "a.cd_filial = "+ String(lvl_Filial), 2)
End If

If Not IsNull(lvl_Transacao) and (lvl_Transacao > 0) Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Transa$$HEX2$$e700e300$$ENDHEX$$o: "+String(lvl_Transacao)
	This.Of_AppendWhere_Subquery( "a.nr_transacao = "+ String(lvl_Transacao), 2)
End If

If Not IsNull(lvs_Docto_SAP) and (lvs_Docto_SAP<>"") Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "N$$HEX1$$ba00$$ENDHEX$$ Docto SAP: "+lvs_Docto_SAP
	This.Of_AppendWhere_Subquery( "a.nr_documento_sap = '"+ lvs_Docto_SAP+ "'", 2)
End If

If Not IsNull(lvl_Lote) and (lvl_Lote > 0) Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Lote Envio: "+String(lvl_Lote)
	This.Of_AppendWhere_Subquery( "a.nr_lote_envio = "+ String(lvl_Lote), 2)
End If

If lvs_Tipo_Doc <> "" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Tipo Documento: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(id_tipo_doc)',1)")
	This.Of_AppendWhere_Subquery( "a.id_tipo_docto = '"+ lvs_Tipo_Doc+"'", 2)
End If

If lvs_Integracao <> "" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Tipo Opera$$HEX2$$e700e300$$ENDHEX$$o: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(cd_integracao)',1)")
	This.Of_AppendWhere_Subquery( "a.cd_integracao = '"+ lvs_Integracao+"'", 2)
End If

If Not IsNull(lvdt_Export_Ini) and (lvdt_Export_Ini >= Date("2018/01/01")) Then
	If IsNull(lvdt_Export_Fim) or (lvdt_Export_Fim < Date("2018/01/01")) Then lvdt_Export_Fim = lvdt_Export_Ini
	
	If lvdt_Export_Fim < lvdt_Export_Ini Then
		Parent.dw_1.Event ue_Pos(1, "dt_termino_exportacao")
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma data final de exporta$$HEX2$$e700e300$$ENDHEX$$o", Exclamation!)
		Return -1
	End If
	
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Data Exporta$$HEX2$$e700e300$$ENDHEX$$o: "+String(lvdt_Export_Ini, "DD/MM/YYYY")+" $$HEX1$$e000$$ENDHEX$$ "+String(lvdt_Export_Fim, "DD/MM/YYYY")
	This.Of_AppendWhere_Subquery( "a.dh_exportacao >= '"+ String(lvdt_Export_Ini, "YYYY.MM.DD")+"' and a.dh_exportacao < '"+ String(RelativeDate(lvdt_Export_Fim, 1), "YYYY.MM.DD")+"'", 2)
End If

If Not IsNull(lvdt_Movto_Ini) and (lvdt_Movto_Ini >= Date("2018/01/01")) Then
	If IsNull(lvdt_Movto_Fim) or (lvdt_Movto_Fim < Date("2018/01/01")) Then lvdt_Movto_Fim = lvdt_Movto_Ini
	
	If lvdt_Movto_Fim < lvdt_Movto_Ini Then
		Parent.dw_1.Event ue_Pos(1, "dt_termino_exportacao")
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma data final de exporta$$HEX2$$e700e300$$ENDHEX$$o", Exclamation!)
		Return -1
	End If
	
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Data Movimenta$$HEX2$$e700e300$$ENDHEX$$o: "+String(lvdt_Movto_Ini, "DD/MM/YYYY")+" $$HEX1$$e000$$ENDHEX$$ "+String(lvdt_Movto_Fim, "DD/MM/YYYY")
	This.Of_AppendWhere_Subquery( "a.dh_documento >= '"+ String(lvdt_Movto_Ini, "YYYY.MM.DD")+"' and a.dh_documento < '"+ String(RelativeDate(lvdt_Movto_Fim, 1), "YYYY.MM.DD")+"'", 2)
End If

If Not IsNull(lvdt_Proces_Ini) and (lvdt_Proces_Ini >= Date("2018/01/01")) Then
	If IsNull(lvdt_Proces_Fim) or (lvdt_Proces_Fim < Date("2018/01/01")) Then lvdt_Proces_Fim = lvdt_Proces_Ini
	
	If lvdt_Proces_Fim < lvdt_Proces_Ini Then
		Parent.dw_1.Event ue_Pos(1, "dt_proc_fim")
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma data final de exporta$$HEX2$$e700e300$$ENDHEX$$o", Exclamation!)
		Return -1
	End If
	
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Data Processamento: "+String(lvdt_Proces_Ini, "DD/MM/YYYY")+" $$HEX1$$e000$$ENDHEX$$ "+String(lvdt_Proces_Ini, "DD/MM/YYYY")
	This.Of_AppendWhere_Subquery( "a.dh_processamento >= '"+ String(lvdt_Proces_Ini, "YYYY.MM.DD")+"' and a.dh_processamento < '"+ String(RelativeDate(lvdt_Proces_Ini, 1), "YYYY.MM.DD")+"'", 2)
End If

If lvs_Excluido = "N" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "[ X ] Exibir Log's Exclu$$HEX1$$ed00$$ENDHEX$$dos"
	This.Of_AppendWhere_Subquery( "coalesce(a.id_situacao_log,'C') <> 'X'", 2)
End If

lvs_Status = This.GetSQLSelect()

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection( '', 'if( id_situacao_log = "X", rgb(255, 0, 0), if( CurrentRow()=GetRow(), rgb(255,255,255), rgb(0,0,0) ))', False )
//This.of_SetRowSelection( 'if( status = 6, rgb(255, 0, 0), ' + This.ivs_Cor_Linha_Padrao + ')', '', False )
end event

event dw_2::itemchanged;call super::itemchanged;This.Post Event ue_Atualiza_Botoes()
end event

event dw_2::ue_reset;call super::ue_reset;Parent.cb_reprocessar.Enabled = False
Parent.cb_revisar.Enabled = False
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Parent.cb_reprocessar.Enabled = False
Parent.cb_revisar.Enabled = False

ivm_menu.mf_SalvarComo( pl_linhas > 0 )
	
Return AncestorReturnValue
end event

event dw_2::ue_print;//override
This.Event ue_Imprimir_Relatorio( This.Title, "CL", False)
end event

event dw_2::ue_printimmediate;//override
This.Event ue_Imprimir_Relatorio( This.Title, "CL", True)
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 4439
integer height = 2204
gb_detalhe_log gb_detalhe_log
gb_itens gb_itens
dw_4 dw_4
dw_5 dw_5
end type

on tabpage_2.create
this.gb_detalhe_log=create gb_detalhe_log
this.gb_itens=create gb_itens
this.dw_4=create dw_4
this.dw_5=create dw_5
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_detalhe_log
this.Control[iCurrent+2]=this.gb_itens
this.Control[iCurrent+3]=this.dw_4
this.Control[iCurrent+4]=this.dw_5
end on

on tabpage_2.destroy
call super::destroy
destroy(this.gb_detalhe_log)
destroy(this.gb_itens)
destroy(this.dw_4)
destroy(this.dw_5)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 4393
integer height = 888
string text = ""
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 37
integer y = 40
integer width = 4334
integer height = 836
string dataobject = "dw_ge471_detalhe"
end type

event dw_3::ue_recuperar;//override
Long lvl_Linha
Decimal{0} lvdc_Atualizacao

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

If Not lvl_Linha > 0 Then Return -1

lvdc_Atualizacao = Tab_1.TabPage_1.dw_2.Object.nr_atualizacao [lvl_Linha]

Return This.Retrieve(lvdc_Atualizacao)
end event

type cb_reprocessar from commandbutton within tabpage_1
integer x = 4014
integer y = 508
integer width = 402
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
string text = "Reprocessar"
end type

event clicked;Long lvl_Linha
Long lvl_Filial
Long lvl_NF

Longlong lvl_ID_Log

String lvs_Situacao
String lvs_Especie
String lvs_Serie
String lvs_Tipo_Doc
String lvs_Chave_NF

Try
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ao marcar essa nota para reprocessar o sistema ir$$HEX1$$e100$$ENDHEX$$ marcar "+&
						"este log como exclu$$HEX1$$ed00$$ENDHEX$$do e far$$HEX1$$e100$$ENDHEX$$ uma nova tentativa de envio ao SAP/CAR.~r~r"+ &
						"Deseja continuar?", Question!, YesNo!, 2) = 1 Then
		
		Parent.dw_2.SetRedraw(False)
		
		Parent.dw_2.SetFilter("id_selecionar='S'")
		Parent.dw_2.Filter()
		
		For lvl_Linha = 1 To Parent.dw_2.RowCount()
			lvl_ID_Log 		= Parent.dw_2.Object.nr_atualizacao		[lvl_Linha]
			lvs_Situacao		= Parent.dw_2.Object.id_situacao_log	[lvl_Linha]
			lvl_Filial			= Parent.dw_2.Object.cd_filial				[lvl_Linha]	
			lvl_NF				= Parent.dw_2.Object.nr_nf					[lvl_Linha]	
			lvs_Especie		= Parent.dw_2.Object.de_especie			[lvl_Linha]	
			lvs_Serie			= Parent.dw_2.Object.de_serie				[lvl_Linha]
			lvs_Tipo_Doc	= Parent.dw_2.Object.de_tipo_docto		[lvl_Linha]
			
			lvs_Chave_NF	= String(lvl_Filial, "0000")+"/"+String(lvl_NF)+"/"+lvs_Especie+"/"+lvs_Serie
			
			//Registro j$$HEX1$$e100$$ENDHEX$$ exclu$$HEX1$$ed00$$ENDHEX$$do
			If lvs_Situacao = "X" Then Continue	
			//Registro processado
			If lvs_Situacao = "P" or lvs_Situacao = "I" Then
				If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A opera$$HEX2$$e700e300$$ENDHEX$$o "+lvs_Tipo_Doc+" do documento "+lvs_Chave_NF+" j$$HEX1$$e100$$ENDHEX$$ foi processada/integrada no SAP. "+ &
									"O reprocessamento far$$HEX1$$e100$$ENDHEX$$ com que o sistema envie essa opera$$HEX2$$e700e300$$ENDHEX$$o novamente.~r~r" + &
									"Deseja realmente excluir este log e tentar reprocess$$HEX1$$e100$$ENDHEX$$-lo?", Question!, YesNo!, 2) = 2 Then Exit
			End If
	
			Update log_exportacao_docto
			set id_situacao_log = 'X',
				 nr_matricula_revisao = :gvo_aplicacao.ivo_seguranca.nr_matricula,
				 dh_revisao		=	getdate(),
				 dh_exclusao	=	getdate(),
				 de_revisao		=	'REPROCESSADO',
				 id_revisado		=	'R'
			Where nr_atualizacao = :lvl_ID_Log
				And coalesce(id_situacao_log, '') <> 'X'
			Using SQLCa;
			
			If SQLCa.SQLCode = -1 Then
				SQLCa.Of_RollBack()
				SQLCa.Of_Msgdberror( "Falha ao atualizar status do log de exporta$$HEX2$$e700e300$$ENDHEX$$o." )
			Else
				SQLCa.Of_Commit()
				Parent.dw_2.Object.id_selecionar		[lvl_Linha] = "N"
				Parent.dw_2.Object.id_situacao_log 	[lvl_Linha] = "X"
				Parent.dw_2.Object.id_revisado	 	[lvl_Linha] = "R"
				Parent.dw_2.Object.status				[lvl_Linha] = 6
			End If
		Next
		
		Parent.dw_2.Post Event ue_Atualiza_Botoes()
	End If

Catch (RuntimeError lvo_Erro)
	MessageBox("Erro", lvo_Erro.GetMessage(), StopSign!)
	Return -1
	
Finally
	Parent.dw_2.SetFilter("")
	Parent.dw_2.Filter()
		
	Parent.dw_2.SetRedraw(True)
End Try
end event

type st_confirmar from statictext within tabpage_1
boolean visible = false
integer x = 3278
integer y = 676
integer width = 951
integer height = 60
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

type cb_revisar from commandbutton within tabpage_1
integer x = 3575
integer y = 508
integer width = 402
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Revisar"
end type

event clicked;Long lvl_Linha
Longlong lvl_ID_Log

String lvs_Situacao
String lvs_Revisao

Try
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja realmente marcar como revisado esses registros?", Question!, YesNo!, 2) = 1 Then
						
		Open(w_ge471_revisao_log)
		
		If Message.StringParm <> '' Then
			lvs_Situacao	= Mid(Message.StringParm, 1, 1)
			lvs_Revisao	= Mid(Message.StringParm, 3)
		
			Parent.dw_2.SetRedraw(False)
			
			Parent.dw_2.SetFilter("id_selecionar='S'")
			Parent.dw_2.Filter()
			
			For lvl_Linha = 1 To Parent.dw_2.RowCount()
				lvl_ID_Log 	= Parent.dw_2.Object.nr_atualizacao		[lvl_Linha]
		
				Update log_exportacao_docto
				set nr_matricula_revisao = :gvo_aplicacao.ivo_seguranca.nr_matricula,
					 dh_revisao		=	getdate(),
					 de_revisao		=	:lvs_Revisao,
					 id_revisado		=	:lvs_Situacao
				Where nr_atualizacao = :lvl_ID_Log
				Using SQLCa;
				
				If SQLCa.SQLCode = -1 Then
					SQLCa.Of_RollBack()
					SQLCa.Of_Msgdberror( "Falha ao atualizar status do log de exporta$$HEX2$$e700e300$$ENDHEX$$o." )
				Else
					SQLCa.Of_Commit()
					Parent.dw_2.Object.id_selecionar		[lvl_Linha] = "N"
					Parent.dw_2.Object.id_revisado		[lvl_Linha] = lvs_Situacao
					Parent.dw_2.Object.status				[lvl_Linha] = IIF(lvs_Situacao='X', 6, 5)
				End If
			Next
			
		End If
		
		Parent.dw_2.Post Event ue_Atualiza_Botoes()
	End If

Catch (RuntimeError lvo_Erro)
	MessageBox("Erro", lvo_Erro.GetMessage(), StopSign!)
	Return -1
	
Finally
	Parent.dw_2.SetFilter("")
	Parent.dw_2.Filter()
		
	Parent.dw_2.SetRedraw(True)
End Try
end event

type gb_detalhe_log from groupbox within tabpage_2
integer x = 50
integer y = 1780
integer width = 4343
integer height = 376
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_itens from groupbox within tabpage_2
integer x = 23
integer y = 916
integer width = 4398
integer height = 1268
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Log~'s"
end type

type dw_4 from dc_uo_dw_base within tabpage_2
integer x = 59
integer y = 988
integer width = 4338
integer height = 800
integer taborder = 20
boolean bringtotop = true
string title = "Log~'s Exporta$$HEX2$$e700e300$$ENDHEX$$o Documento"
string dataobject = "dw_ge471_detalhe_item"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;//override
Long lvl_Linha
Decimal{0} lvdc_Atualizacao

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

If Not lvl_Linha > 0 Then Return -1

lvdc_Atualizacao = Tab_1.TabPage_1.dw_2.Object.nr_atualizacao [lvl_Linha]

Return This.Retrieve(lvdc_Atualizacao)
end event

event constructor;call super::constructor;This.Of_SetRowSelection( )
This.ShareData( Dw_5 )
end event

event ue_printimmediate;//override
This.Event ue_Imprimir_Relatorio( This.Title, "CL", True)
end event

event ue_print;//override
This.Event ue_Imprimir_Relatorio( This.Title, "CL", False)
end event

event ue_preprint;call super::ue_preprint;This.ivs_Filtro_Relatorio = {""}
This.ivs_Filtro_Relatorio [2] = "Filial: "+Parent.dw_3.Object.nm_filial[1]+" ( "+String(Parent.dw_3.Object.cd_filial[1])+" / "+Parent.dw_3.Object.cd_filial_sap[1]+" )"
This.ivs_Filtro_Relatorio [3] = "Documento: "+String(Parent.dw_3.Object.nr_nf[1])                  
This.ivs_Filtro_Relatorio [3] += Space(100 - Len(This.ivs_Filtro_Relatorio [3]) * 1.15) + "Transa$$HEX2$$e700e300$$ENDHEX$$o: "+String(Parent.dw_3.Object.nr_transacao[1])
This.ivs_Filtro_Relatorio [4] = "Esp$$HEX1$$e900$$ENDHEX$$cie: "+Parent.dw_3.Object.de_especie[1]
This.ivs_Filtro_Relatorio [4] += Space(105 - Len(This.ivs_Filtro_Relatorio [4]) * 1.15) + "S$$HEX1$$e900$$ENDHEX$$rie: "+Parent.dw_3.Object.de_serie[1]
This.ivs_Filtro_Relatorio [5] = "Tipo Documento: "+Parent.dw_3.Describe("Evaluate('LookUpDisplay(id_tipo_docto)',1)")
This.ivs_Filtro_Relatorio [5] += Space(98 - Len(This.ivs_Filtro_Relatorio [5]) * 1.15) + "Data Documento: "+String(Parent.dw_3.Object.dh_documento[1], "DD/MM/YYYY")
This.ivs_Filtro_Relatorio [6] = "Data Exporta$$HEX2$$e700e300$$ENDHEX$$o: "+String(Parent.dw_3.Object.dh_exportacao[1], "DD/MM/YYYY HH:MM")
This.ivs_Filtro_Relatorio [6] += Space(95 - Len(This.ivs_Filtro_Relatorio [6]) * 1.15) + "Data Processamento: "+String(Parent.dw_3.Object.dh_processamento[1], "DD/MM/YYYY HH:MM")

Return AncestorReturnValue

end event

event rowfocuschanged;call super::rowfocuschanged;dw_5.Post Event RowFocusChanged( CurrentRow )
dw_5.Post Function ScrollToRow( CurrentRow )
end event

type dw_5 from dc_uo_dw_base within tabpage_2
integer x = 73
integer y = 1852
integer width = 4288
integer height = 292
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge471_detalhe_log"
end type

