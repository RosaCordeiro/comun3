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
type cb_alt_finaliz from commandbutton within tabpage_1
end type
type gb_detalhe_log from groupbox within tabpage_2
end type
type gb_itens from groupbox within tabpage_2
end type
type dw_4 from dc_uo_dw_base within tabpage_2
end type
type dw_5 from dc_uo_dw_base within tabpage_2
end type
type uo_1 from uo_data_atual within w_ge471_monitor_integracao_car
end type
end forward

global type w_ge471_monitor_integracao_car from dc_w_2tab_consulta_selecao_lista_det
string accessiblename = "GE471 Monitor Interface CAR TDF"
integer width = 4768
integer height = 2524
string title = "GE471 - Monitor Interface - CAR/TDF"
uo_1 uo_1
end type
global w_ge471_monitor_integracao_car w_ge471_monitor_integracao_car

type variables
Boolean ivb_Check = False
string ivs_Where_Mult, ivs_SQL_TDF_Original
String ivs_Ambiente_CAR, ivs_Ambiente_TDF, ivs_Ambiente_Guep, ivs_id_usuario_informatica

uo_filial ivo_filial

dc_uo_transacao 	ivtr_Mult, ivtr_geral
dc_uo_ds_base 	ids_dw2_tdf

datawindowchild dwc_tipo_doc, dwc_especie_car_tdf, dwc_nm_usuario_revisao, dwc_id_tipo_docto, dwc_ambiente_sap
end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();String lvs_Tipo_Interface

DataWindowChild	ldwc_Child

/* Integra$$HEX2$$e700e300$$ENDHEX$$o CAR */
ldwc_Child  = Tab_1.Tabpage_1.dw_1.of_InsertRow_DDDW("cd_integracao" )			

ldwc_Child.SetItem(1, "cd_integracao", ""	)
ldwc_Child.SetItem(1, "de_integracao", "TODOS")
ldwc_Child.SetItem(1, "id_situacao", "A")

ldwc_Child.SetFilter("id_situacao = 'A'")
ldwc_Child.Filter()

Tab_1.Tabpage_1.dw_1.Object.cd_integracao[1] = ""
if day(Relativedate(today() , - (day(Today())-1) )) = 1 then
	Tab_1.Tabpage_1.dw_1.setitem( 1, 'dt_inicio_movimentacao',  Relativedate(today() , - 30 )  )
else
	Tab_1.Tabpage_1.dw_1.setitem( 1, 'dt_inicio_movimentacao',  Relativedate(today() , - (day(Today())-1) )  )
end if

Tab_1.Tabpage_1.dw_1.setitem( 1, 'dt_termino_movimentacao', today())

lvs_Tipo_Interface = Tab_1.Tabpage_1.dw_1.Object.nm_destino [1]

/*Ambiente SAP*/
select vl_parametro
Into :ivs_Ambiente_CAR
from parametro_geral
Where cd_parametro = 'CD_AMBIENTE_CAR'
Using SQLCa;

/*Ambiente TDF*/
select vl_parametro
Into :ivs_Ambiente_TDF
from parametro_geral
Where cd_parametro = 'CD_AMBIENTE_TDF'
Using SQLCa;

/*Ambiente Guepardo*/
select vl_parametro
Into :ivs_Ambiente_Guep
from parametro_geral
Where cd_parametro = 'CD_AMBIENTE_GUEPARDO'
Using SQLCa;


//CAR
Choose Case lvs_Tipo_Interface
	Case "C" 
		Tab_1.Tabpage_1.dw_1.Object.cd_ambiente_sap [1] = ivs_Ambiente_CAR
		dwc_ambiente_sap.SetFilter("id_car='S'")
		dwc_ambiente_sap.Filter()
	Case "G"
		Tab_1.Tabpage_1.dw_1.Object.cd_ambiente_sap [1] = ivs_Ambiente_Guep
		dwc_ambiente_sap.SetFilter("id_guepardo='S'")
		dwc_ambiente_sap.Filter()
	Case "T"
		Tab_1.Tabpage_1.dw_1.Object.cd_ambiente_sap [1] = ivs_Ambiente_TDF
		dwc_ambiente_sap.SetFilter("id_tdf='S'")
		dwc_ambiente_sap.Filter()
	Case Else
		Tab_1.Tabpage_1.dw_1.Object.cd_ambiente_sap [1] = ""
End Choose



end subroutine

on w_ge471_monitor_integracao_car.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_ge471_monitor_integracao_car.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
end on

event ue_preopen;call super::ue_preopen;ivo_filial 			= Create uo_filial
ivtr_Mult			= Create dc_uo_transacao
ivtr_geral			= Create dc_uo_transacao
ids_dw2_tdf 	= Create dc_uo_ds_base

ids_dw2_tdf.DataObject = "dw_ge471_lista_tdf"
ivs_SQL_TDF_original = ids_dw2_tdf.Object.DataWindow.Table.SQLSelect

Maxheight = 9999
ivl_largura_1 = 4731
ivl_largura_2 = 4500

ivm_menu.ivb_permite_imprimir = True

select top 1 id_usuario_informatica
Into :ivs_id_usuario_informatica
from usuario
Where nr_matricula = :gvo_Aplicacao.ivo_seguranca.nr_matricula
Using SQLCa;

end event

event resize;call super::resize;Tab_1.Height	= NewHeight - Tab_1.Y - 16
Tab_1.Width	= NewWidth - Tab_1.X - 16

Tab_1.Tabpage_1.gb_2.Height 	=  Tab_1.Height - Tab_1.Tabpage_1.gb_2.Y - 140
Tab_1.Tabpage_1.dw_2.Height 	=  Tab_1.Height - Tab_1.Tabpage_1.dw_2.Y - 170

Tab_1.Tabpage_2.gb_itens.Height =  Tab_1.Height - Tab_1.Tabpage_2.gb_itens.Y - 140
Tab_1.Tabpage_2.dw_4.Height =  Tab_1.Height - Tab_1.Tabpage_2.dw_4.Y - 170 - Tab_1.Tabpage_2.gb_detalhe_log.Height
Tab_1.Tabpage_2.gb_detalhe_log.Y = Tab_1.Height - Tab_1.Tabpage_2.gb_detalhe_log.Height - 170
Tab_1.Tabpage_2.dw_5.Y = Tab_1.Tabpage_2.gb_detalhe_log.Y + 80

ivl_altura_1 = NewHeight - 4
ivl_altura_2 = ivl_altura_1
end event

event close;call super::close;If IsValid(ivo_filial) Then Destroy(ivo_filial)

If IsValid(ids_dw2_tdf) Then Destroy(ids_dw2_tdf)

If IsValid(ivtr_Mult) Then 
	if ivtr_Mult.of_isconnected( ) then	Destroy ivtr_Mult
end if

//If IsValid(ivtr_geral) Then 
//	if ivtr_geral.of_isconnected( ) then	Destroy ivtr_geral
//end if


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
integer width = 4709
integer height = 2320
end type

event tab_1::selectionchanging;//overhide

SetPointer(HourGlass!)

If NewIndex = 2 Then
	if Tab_1.TabPage_1.dw_2.getitemstring( Tab_1.TabPage_1.dw_2.GetRow(), 'base_dados') = 'MULT' then

		Tab_1.TabPage_2.dw_3.itr_transacao = ivtr_Mult
		Tab_1.TabPage_2.dw_3.of_changedataobject( 'dw_ge471_detalhe_tdf')
		Tab_1.TabPage_2.dw_3.SetTrans(ivtr_Mult)
		
		Tab_1.TabPage_2.dw_4.itr_transacao = ivtr_Mult
		Tab_1.TabPage_2.dw_4.of_changedataobject( 'dw_ge471_detalhe_item_tdf')
		Tab_1.TabPage_2.dw_4.SetTrans(ivtr_Mult)
		
		Tab_1.TabPage_2.dw_5.itr_transacao = ivtr_Mult
		Tab_1.TabPage_2.dw_5.of_changedataobject( 'dw_ge471_detalhe_log')
		Tab_1.TabPage_2.dw_5.SetTrans(ivtr_Mult)
	else
		Tab_1.TabPage_2.dw_3.itr_transacao = sqlca
		Tab_1.TabPage_2.dw_3.of_changedataobject( 'dw_ge471_detalhe')
		Tab_1.TabPage_2.dw_3.SetTrans(sqlca)

		Tab_1.TabPage_2.dw_4.itr_transacao = sqlca
		Tab_1.TabPage_2.dw_4.of_changedataobject( 'dw_ge471_detalhe_item')
		Tab_1.TabPage_2.dw_4.SetTrans(sqlca)
		
		Tab_1.TabPage_2.dw_5.of_changedataobject( 'dw_ge471_detalhe_log')
		Tab_1.TabPage_2.dw_5.itr_transacao = sqlca
		Tab_1.TabPage_2.dw_5.SetTrans(sqlca)
	end if

	If NewIndex = 2 Then
		If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
		   Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
		   Tab_1.TabPage_2.dw_4.Event ue_Retrieve()
		   Tab_1.TabPage_2.dw_5.Event ue_Retrieve()
		   Return 0
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
			Return 1
		End If
	End If
Else
	ivm_menu.mf_salvarcomo( Tab_1.TabPage_1.dw_2.RowCount() > 0 )
End If		

SetPointer(Arrow!)
end event

event tab_1::selectionchanged;SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		
		This.TabPage_1.dw_2.ivm_menu.mf_SalvarComo(This.TabPage_1.dw_2.RowCount() > 0)
		This.TabPage_1.dw_2.ivm_menu.mf_Imprimir(This.TabPage_1.dw_2.RowCount() > 0)
		
		This.Width  = Parent.ivl_Largura_1
		This.Height = Parent.ivl_Altura_1
		
		Tab_1.TabPage_1.dw_2.SetFocus()
		
	Case 2

		This.TabPage_2.dw_3.ivm_menu.mf_SalvarComo(This.TabPage_2.dw_3.RowCount() > 0)
		This.TabPage_2.dw_3.ivm_menu.mf_Imprimir(This.TabPage_2.dw_3.RowCount() > 0)
		
		This.Width  = Parent.ivl_Largura_2		
		This.Height = Parent.ivl_Altura_2
	
		Tab_1.TabPage_2.dw_4.Of_SetRowSelection( )
		Tab_1.TabPage_2.dw_3.SetFocus()
		Tab_1.TabPage_2.dw_3.Enabled = True
End Choose

SetPointer(Arrow!)

Parent.Width  = This.Width + This.X + 75	
//Parent.Height = This.Height + This.Y + 155
//This.Height = This.Height - 16
//This.Width = This.Width - 16

Return 1

end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 4672
integer height = 2204
cb_reprocessar cb_reprocessar
st_confirmar st_confirmar
cb_revisar cb_revisar
cb_alt_finaliz cb_alt_finaliz
end type

on tabpage_1.create
this.cb_reprocessar=create cb_reprocessar
this.st_confirmar=create st_confirmar
this.cb_revisar=create cb_revisar
this.cb_alt_finaliz=create cb_alt_finaliz
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_reprocessar
this.Control[iCurrent+2]=this.st_confirmar
this.Control[iCurrent+3]=this.cb_revisar
this.Control[iCurrent+4]=this.cb_alt_finaliz
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_reprocessar)
destroy(this.st_confirmar)
destroy(this.cb_revisar)
destroy(this.cb_alt_finaliz)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 596
integer width = 4617
integer height = 1592
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 4617
integer height = 480
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer width = 4553
integer height = 400
string dataobject = "dw_ge471_selecao"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)

This.GetChild( 'id_tipo_doc', dwc_tipo_doc)
dwc_tipo_doc.SetTransObject( SQLCa ) 

This.GetChild( 'de_especie', dwc_especie_car_tdf)
dwc_especie_car_tdf.SetTransObject( SQLCa ) 

This.GetChild( 'cd_ambiente_sap', dwc_ambiente_sap)
dwc_ambiente_sap.SetTransObject( SQLCa ) 
dwc_ambiente_sap.SetFilter("id_situacao='A'")
dwc_ambiente_sap.Filter()

dwc_tipo_doc.Retrieve(3)
dwc_especie_car_tdf.Retrieve(3)

end event

event dw_1::itemchanged;call super::itemchanged;
Choose Case Dwo.Name	
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
		
	case 'nm_destino'
		
		This.SetItem( 1, 'de_especie', 'TODOS')
		This.SetItem( 1, 'id_tipo_doc', 'TODOS')	
		
		Choose Case Data
			Case 'T' //TDF 
				This.Object.cd_integracao.TabSequence = 0
				This.SetItem( 1, 'cd_ambiente_sap', ivs_Ambiente_TDF)	
			Case 'G' //Guepardo
				This.Object.cd_integracao.TabSequence = 0
				This.SetItem( 1, 'cd_ambiente_sap', ivs_Ambiente_Guep)	
			Case 'C' //CAR
				This.Object.cd_integracao.TabSequence = 50
				This.SetItem( 1, 'cd_ambiente_sap', ivs_Ambiente_CAR)	
		End Choose

		If Data = 'C' Then //CAR
			dwc_tipo_doc.retrieve(1)
			dwc_especie_car_tdf.retrieve(1)
			dwc_ambiente_sap.SetFilter("id_car='S' and id_situacao='A'")
			dwc_ambiente_sap.Filter()
		ElseIf data = 'T' Then //TDF
			dwc_tipo_doc.retrieve(2)
			dwc_especie_car_tdf.retrieve(2)
			dwc_ambiente_sap.SetFilter("id_tdf='S' and id_situacao='A'")
			dwc_ambiente_sap.Filter()
		ElseIf data = 'G' Then //Guepardo
			dwc_tipo_doc.retrieve(4)
			dwc_especie_car_tdf.retrieve(4)
			dwc_ambiente_sap.SetFilter("id_guepardo='S' and id_situacao='A'")
			dwc_ambiente_sap.Filter()
		ElseIf data = 'A' Then //Todos
			dwc_tipo_doc.retrieve(3)
			dwc_especie_car_tdf.retrieve(3)
			dwc_ambiente_sap.SetFilter("id_situacao='A'")
			dwc_ambiente_sap.Filter()
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
string accessiblename = "GE471 Monitor Interface CAR TDF"
integer x = 46
integer y = 664
integer width = 4576
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

event dw_2::ue_atualiza_botoes();Long lvl_Find
Long lvl_RowCount

lvl_RowCount = This.RowCount()

If lvl_RowCount > 0 Then
	lvl_Find = This.Find("id_selecionar='S'", 1, lvl_RowCount)
	Parent.cb_reprocessar.Enabled = (lvl_Find > 0)
	Parent.cb_revisar.Enabled = Parent.cb_reprocessar.Enabled
	
	//Verifica se tem algum LOG do CAR marcado
	lvl_Find = This.Find("nm_destino='CAR' and id_selecionar='S'", 1, lvl_RowCount)
	//Se h$$HEX1$$e100$$ENDHEX$$ pelo menos 1 marcado e a linha $$HEX1$$e900$$ENDHEX$$ menor que o final da lista, pode conter mais registros
	If lvl_Find > 0 and lvl_Find < lvl_RowCount Then
		//Habilita somente se houver apenas 1 marcado
		Parent.cb_alt_finaliz.Enabled = (This.Find("nm_destino='CAR' and id_selecionar='S'", lvl_Find + 1, lvl_RowCount) = 0)
	Else
		Parent.cb_alt_finaliz.Enabled = (lvl_Find > 0)
	End If
Else
	Parent.cb_reprocessar.Enabled = False
	Parent.cb_revisar.Enabled = False
	Parent.cb_alt_finaliz.Enabled = False
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
		
		Open(w_aguarde)
		w_aguarde.Title = IIF(ivb_Check, 'Marcando', 'Desmarcando')+' registros...'
		w_aguarde.uo_progress.Of_SetMax(This.RowCount())
		
		This.SetRedraw(False)
		For lvl_Row = 1 To This.RowCount()				
			This.Object.id_selecionar[lvl_Row] = lvs_Marcacao
			w_aguarde.uo_progress.Of_SetProgress(lvl_Row)
		Next
		This.SetRedraw(True)
		
		If IsValid(w_aguarde) Then Close(w_aguarde)
		
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
String lvs_CD_Setor
String lvs_ID_Interface
String lvs_Filtro_Aux

Long lvl_Filial
Decimal{0} lvdc_Transacao
Decimal{0} lvdc_Nr_Nf
Long lvl_Lote

Date lvdt_Export_Ini
Date lvdt_Export_Fim
Date lvdt_Movto_Ini
Date lvdt_Movto_Fim
Date lvdt_Proces_Ini
Date lvdt_Proces_Fim

Parent.dw_1.Accepttext( )

lvl_Filial			= Parent.dw_1.Object.cd_filial						[1]
lvs_Status			= Parent.dw_1.Object.id_status						[1]
lvs_Ambiente		= Parent.dw_1.Object.cd_ambiente_sap				[1]
lvs_Tipo_Doc		= Parent.dw_1.Object.id_tipo_doc						[1]
lvs_Integracao		= Parent.dw_1.Object.cd_integracao					[1]
lvdt_Export_Ini	= Parent.dw_1.Object.dt_inicio_exportacao			[1]
lvdt_Export_Fim	= Parent.dw_1.Object.dt_termino_exportacao		[1]
lvdt_Movto_Ini		= Parent.dw_1.Object.dt_inicio_movimentacao		[1]
lvdt_Movto_Fim		= Parent.dw_1.Object.dt_termino_movimentacao		[1]
lvs_Revisao			= Parent.dw_1.Object.id_revisao						[1]
lvs_Especie			= Parent.dw_1.Object.de_especie						[1]
lvs_Serie			= Parent.dw_1.Object.de_serie							[1]
lvdc_Transacao		= Parent.dw_1.Object.nr_transacao					[1]
lvdc_Nr_Nf			= Parent.dw_1.Object.nr_nf								[1]
lvs_Docto_SAP		= Parent.dw_1.Object.nr_documento_sap				[1]
lvl_Lote				= Parent.dw_1.Object.nr_lote_envio					[1]
lvs_Excluido		= Parent.dw_1.Object.id_excluidos					[1]
lvdt_Proces_Ini	= Parent.dw_1.Object.dt_proc_ini						[1]
lvdt_Proces_Fim	= Parent.dw_1.Object.dt_proc_fim						[1]
lvs_CD_Setor		= Parent.dw_1.Object.cd_setor							[1]
lvs_ID_Interface	= Parent.dw_1.Object.nm_destino						[1]

ivs_Where_Mult 	= ''
if lvs_Tipo_Doc 	= 'TODOS' then lvs_Tipo_Doc 	= ''
if lvs_Especie 	= 'TODOS' then lvs_Especie 	= ''
if lvs_CD_Setor 	= 'TODOS' then lvs_CD_Setor 	= ''

If lvs_Ambiente <> "" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Ambiente: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(cd_ambiente_sap)',1)")
	This.Of_AppendWhere_Subquery( "a.cd_ambiente_sap = '"+ lvs_Ambiente+"'", 2)
	ivs_Where_Mult += "~r and a.cd_ambiente_sap = '"+ lvs_Ambiente+"'"
End If

If lvs_Revisao <> "" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Status Revis$$HEX1$$e300$$ENDHEX$$o: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(id_revisao)',1)")
	This.Of_AppendWhere_Subquery( "coalesce(a.id_revisado,'P') = '"+ lvs_Revisao+"'", 2)	
	ivs_Where_Mult +=  "~r and coalesce(a.id_revisado,'P') = '"+ lvs_Revisao+"'"
End If

If lvs_Status <> "" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Status Log: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(id_status)',1)")
	If lvs_Status = "Y" Then
		This.Of_AppendWhere_Subquery( "a.id_situacao_log in ('E', 'F', 'V')", 2)
		ivs_Where_Mult +=  "~r and a.id_situacao_log in ('E', 'F', 'V')"
	elseif lvs_Status = "B" Then
		This.Of_AppendWhere_Subquery( "exists (select 1 from log_exportacao_docto_det b where b.nr_atualizacao_log = a.nr_atualizacao and b.nr_mensagem = 12)", 2)
	Else
		This.Of_AppendWhere_Subquery( "a.id_situacao_log = '"+ lvs_Status+"'", 2)
		ivs_Where_Mult +=  "~r and a.id_situacao_log = '"+ lvs_Status+"'"
	End If	
End If

If lvs_Especie <> "" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Esp$$HEX1$$e900$$ENDHEX$$cie: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(de_especie)',1)")
	This.Of_AppendWhere_Subquery( "a.de_especie = '"+ lvs_Especie+"'", 2)	
	ivs_Where_Mult +=  "~r and a.de_especie = '"+ lvs_Especie+"'"
End If

If lvs_Serie <> "" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "S$$HEX1$$e900$$ENDHEX$$rie: "+lvs_Serie
	This.Of_AppendWhere_Subquery( "a.de_serie = '"+ lvs_Serie+"'", 2)	
	ivs_Where_Mult +=  "~r and a.de_serie = '"+ lvs_Serie+"'"	
End If

If Not IsNull(lvl_Filial) and (lvl_Filial > 0) Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Filial: "+ivo_filial.nm_fantasia+" ("+String(ivo_filial.cd_filial)+")"
	This.Of_AppendWhere_Subquery( "a.cd_filial = "+ String(lvl_Filial), 2)
	ivs_Where_Mult +=  "~r and a.cd_filial = "+ String(lvl_Filial)
End If

If Not IsNull(lvdc_Transacao) and (lvdc_Transacao > 0) Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Transa$$HEX2$$e700e300$$ENDHEX$$o: "+String(lvdc_Transacao)
	This.Of_AppendWhere_Subquery( "a.nr_transacao = "+ String(lvdc_Transacao), 2)
	ivs_Where_Mult +=  "~r and a.nr_transacao = "+ String(lvdc_Transacao)
End If

If Not IsNull(lvdc_Nr_Nf) and (lvdc_Nr_Nf > 0) Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Nota: "+String(lvdc_Nr_Nf)
	This.Of_AppendWhere_Subquery( "a.nr_nf = "+ String(lvdc_Nr_Nf), 2)
	ivs_Where_Mult +=  "~r and a.nr_nf = "+ String(lvdc_Nr_Nf)
End If

If Not IsNull(lvs_Docto_SAP) and (lvs_Docto_SAP<>"") Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "N$$HEX1$$ba00$$ENDHEX$$ Docto SAP: "+lvs_Docto_SAP
	This.Of_AppendWhere_Subquery( "a.nr_documento_sap = '"+ lvs_Docto_SAP+ "'", 2)
	ivs_Where_Mult +=  "~r and a.nr_documento_sap = '"+ lvs_Docto_SAP+ "'"
End If

If Not IsNull(lvl_Lote) and (lvl_Lote > 0) Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Lote Envio: "+String(lvl_Lote)
	This.Of_AppendWhere_Subquery( "a.nr_lote_envio = "+ String(lvl_Lote), 2)
	ivs_Where_Mult +=  "~r and a.nr_lote_envio = "+ String(lvl_Lote)
End If

If lvs_Tipo_Doc <> "" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Tipo Documento: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(id_tipo_doc)',1)")
	This.Of_AppendWhere_Subquery( "a.id_tipo_docto = '"+ lvs_Tipo_Doc+"'", 2)
	ivs_Where_Mult +=  "~r and a.id_tipo_docto = '"+ lvs_Tipo_Doc+"'"
End If

If lvs_Integracao <> "" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Tipo Opera$$HEX2$$e700e300$$ENDHEX$$o: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(cd_integracao)',1)")
	This.Of_AppendWhere_Subquery( "a.cd_integracao = '"+ lvs_Integracao+"'", 2)
	ivs_Where_Mult +=  "~r and a.cd_integracao = '"+ lvs_Integracao+"'"
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
	ivs_Where_Mult +=  "~r and a.dh_exportacao >= to_date('"+ String(lvdt_Export_Ini,"YYYY/MM/DD")+"','YYYY/MM/DD') and a.dh_exportacao < to_date('"+ String(RelativeDate(lvdt_Export_Fim, 1), 'YYYY/MM/DD')+"','YYYY/MM/DD')"
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
	ivs_Where_Mult +=  "~r and a.dh_documento >= to_date('"+ String(lvdt_Movto_Ini,"YYYY/MM/DD")+"','YYYY/MM/DD') and a.dh_documento < to_date('"+ String(RelativeDate(lvdt_Movto_Fim, 1), 'YYYY/MM/DD')+"','YYYY/MM/DD')"	
End If

If Not IsNull(lvdt_Proces_Ini) and (lvdt_Proces_Ini >= Date("2018/01/01")) Then
	If IsNull(lvdt_Proces_Fim) or (lvdt_Proces_Fim < Date("2018/01/01")) Then lvdt_Proces_Fim = lvdt_Proces_Ini
	
	If lvdt_Proces_Fim < lvdt_Proces_Ini Then
		Parent.dw_1.Event ue_Pos(1, "dt_proc_fim")
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma data final de exporta$$HEX2$$e700e300$$ENDHEX$$o", Exclamation!)
		Return -1
	End If
	
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Data Processamento: "+String(lvdt_Proces_Ini, "DD/MM/YYYY")+" $$HEX1$$e000$$ENDHEX$$ "+String(lvdt_Proces_Ini, "DD/MM/YYYY")
	This.Of_AppendWhere_Subquery( "a.dh_processamento >= '"+ String(lvdt_Proces_Ini, "YYYY.MM.DD")+"' and a.dh_processamento < '"+ String(RelativeDate(lvdt_Proces_Fim, 1), "YYYY.MM.DD")+"'", 2)
	ivs_Where_Mult +=  "~r and a.dh_processamento >= to_date('"+ String(lvdt_Proces_Ini,"YYYY/MM/DD")+"','YYYY/MM/DD') and a.dh_processamento < to_date('"+ String(RelativeDate(lvdt_Proces_Fim, 1), 'YYYY/MM/DD')+"','YYYY/MM/DD')"	
End If

If lvs_Excluido = "N" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "[ X ] Exibir Log's Exclu$$HEX1$$ed00$$ENDHEX$$dos"
	This.Of_AppendWhere_Subquery( "coalesce(a.id_situacao_log,'C') <> 'X'", 2)
	ivs_Where_Mult +=  "~r and coalesce(a.id_situacao_log,'C') <> 'X'"
End If

If lvs_CD_Setor <> "" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Setor: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(cd_setor)',1)")
	This.Of_AppendWhere_Subquery( "exists (select 1 from log_exportacao_docto_det b where b.nr_atualizacao_log = a.nr_atualizacao and b.cd_setor = '"+ lvs_CD_Setor+"'"+ ')', 2)
			 ivs_Where_Mult += "~r and exists (select 1 from log_exportacao_docto_det b where b.nr_atualizacao_log = a.nr_atualizacao and b.cd_setor = '"+ lvs_CD_Setor+"'" + ')'
End If

If lvs_ID_Interface<>"A" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Interface: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(nm_destino)',1)")
	
	Choose Case lvs_ID_Interface
		Case 'C' //CAR
			lvs_Filtro_Aux = 'CAR'
		Case 'T' //TDF
			lvs_Filtro_Aux = 'TDF'
		Case 'G' //Guepardo
			lvs_Filtro_Aux = 'GUE'
		Case Else
			lvs_Filtro_Aux=''
	End Choose

	This.Of_AppendWhere_Subquery( "coalesce(a.id_interface,'CAR')='"+lvs_Filtro_Aux+"'", 2)
	ivs_Where_Mult += "~r and coalesce(a.id_interface,'TDF')='"+lvs_Filtro_Aux+"'"
End If

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection( '', 'if( id_situacao_log = "X", rgb(255, 0, 0), if( CurrentRow()=GetRow(), rgb(255,255,255), rgb(0,0,0) ))', False )
//This.of_SetRowSelection( 'if( status = 6, rgb(255, 0, 0), ' + This.ivs_Cor_Linha_Padrao + ')', '', False )


end event

event dw_2::itemchanged;call super::itemchanged;This.Post Event ue_Atualiza_Botoes()
end event

event dw_2::ue_reset;call super::ue_reset;Parent.cb_reprocessar.Enabled = False
Parent.cb_revisar.Enabled = False

This.ivo_controle_menu.of_salvarcomo( False )
ivm_menu.mf_salvarcomo( False )

ids_dw2_tdf.Reset()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Parent.cb_reprocessar.Enabled = False
Parent.cb_revisar.Enabled = False

This.ivo_controle_menu.of_salvarcomo(  pl_linhas > 0 )
ivm_menu.mf_SalvarComo( pl_linhas > 0 )

ivb_Check = False
	
Return AncestorReturnValue
end event

event dw_2::ue_print;//override
This.Event ue_Imprimir_Relatorio( This.Title, "CL", False)
end event

event dw_2::ue_printimmediate;//override
This.Event ue_Imprimir_Relatorio( This.Title, "CL", True)
end event

event dw_2::ue_recuperar;//Override
//TODOS = A | CAR = C | TDF = T
long lvl_linhas_dw2, lvl_Posicao, lvl_Contador, lvl_linhas_tdf, lvl_dw2_linha_tdf, lvl_dw2_linha
string lvs_conect_to
String lvs_nm_destino 
decimal lvl_nr_atualizacao
string lvs_cd_setor

Try
	Parent.dw_2.SetRedraw(False)
	
	lvs_nm_destino	= Parent.dw_1.Object.nm_destino[1]
	//Recupera Informa$$HEX2$$e700f500$$ENDHEX$$es Sybase (tem TDF e CAR)
	lvl_linhas_dw2 = This.Retrieve()
	
	for lvl_dw2_linha = 1 to lvl_linhas_dw2
		
		if this.getitemstring( lvl_dw2_linha, 'nm_destino') = 'CAR' then
		
			lvl_nr_atualizacao = this.getitemdecimal( lvl_dw2_linha, 'nr_atualizacao')
			
			select top 1 coalesce(b.cd_setor, '') into :lvs_cd_setor 
			from log_exportacao_docto_det b (index pk_log_exportacao_docto_det) 
			where b.nr_atualizacao_log = :lvl_nr_atualizacao
				and coalesce(b.cd_setor, 'nulo') <> 'nulo'
			using sqlca;
			
			this.setitem( lvl_dw2_linha, 'cd_setor', lvs_cd_setor)
	
		end if	
	next
	
	//Se for diferente de C = CAR, ent$$HEX1$$e300$$ENDHEX$$o busca tamb$$HEX1$$e900$$ENDHEX$$m na Mult
	If lvs_nm_destino <> 'C' Then		
		If ivtr_Mult.of_isConnected() Then ivtr_Mult.of_Disconnect()
		
		if Lower(gvo_aplicacao.ivs_datasource) = 'central' then
			lvs_conect_to = 'CLAMPROD'
		elseif Lower(gvo_aplicacao.ivs_datasource) = 'homologa' then
			lvs_conect_to = 'clamteste'
		else
			lvs_conect_to = 'clamteste'
		end if
		
		If Not gf_conecta_banco_mult(ivtr_Mult,lvs_conect_to) Then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Ocorreu erro ao tentar conectar no banco da Mult no ambiente ' + lvs_conect_to )
			return -1
		else
			ids_dw2_tdf.SetTransObject(ivtr_Mult)	
		End If
		
		lvl_Posicao = Pos(Upper(ivs_SQL_TDF_original), "AND 1=1")
		If lvl_Posicao = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao tentar localizar a cl$$HEX1$$e100$$ENDHEX$$usula no select.", StopSign!)
			Return -1
		End If
		
		ids_dw2_tdf.Object.DataWindow.Table.Select = Replace(ivs_SQL_TDF_original, lvl_Posicao, 7, ivs_Where_Mult)
		ids_dw2_tdf.ivb_SQL_Alterado = True
		
		lvl_linhas_tdf = ids_dw2_tdf.retrieve()
		
		if lvl_linhas_tdf > 0 then
			
			for lvl_dw2_linha_tdf = 1 to lvl_linhas_tdf 
						
				lvl_nr_atualizacao = ids_dw2_tdf.getitemdecimal( lvl_dw2_linha_tdf, 'nr_atualizacao')
			
				select nvl(b.cd_setor, '') into :lvs_cd_setor 
				from log_exportacao_docto_det b
				where b.nr_atualizacao_log = :lvl_nr_atualizacao
					and nvl(b.cd_setor, 'nulo') <> 'nulo'
					and rownum = 1
				using ivtr_Mult;
			
				ids_dw2_tdf.setitem( lvl_dw2_linha_tdf, 'cd_setor', lvs_cd_setor)
					
			next
			
			//retrieve e rowscopy da dw do TDF
			If ids_dw2_tdf.RowsCopy(1, lvl_linhas_tdf, Primary!, dw_2, 1, Primary!) = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro copiar as informa$$HEX2$$e700f500$$ENDHEX$$es da Mult.")
				Return -1
			End If
		end if	
		
	end if
	
Catch (RuntimeError lvo_Erro)
	MessageBox("Erro", lvo_Erro.GetMessage(),StopSign!)
	Return -1
	
Finally	
	Parent.dw_2.SetFilter("")
	Parent.dw_2.Filter()
	Parent.dw_2.setsort("dh_exportacao ds, nr_atualizacao as")
	Parent.dw_2.sort()
	Parent.dw_2.SetRedraw(true)
End Try

return lvl_linhas_dw2+lvl_linhas_tdf
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 4672
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
integer y = 56
integer width = 4334
integer height = 836
string dataobject = "dw_ge471_detalhe"
end type

event dw_3::ue_recuperar;//override
Long lvl_Linha, lvl_ret
Decimal{0} lvdc_Atualizacao

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

If Not lvl_Linha > 0 Then Return -1

lvdc_Atualizacao = Tab_1.TabPage_1.dw_2.Object.nr_atualizacao [lvl_Linha]

Tab_1.TabPage_2.dw_3.reset()
lvl_ret = Tab_1.TabPage_2.dw_3.Retrieve(lvdc_Atualizacao)

If lvl_ret > 0 then

	Tab_1.TabPage_2.dw_3.getchild( 'id_tipo_docto', dwc_id_tipo_docto)
	dwc_id_tipo_docto.settransobject( sqlca ) 
	dwc_id_tipo_docto.retrieve(3)

	if Tab_1.TabPage_1.dw_2.getitemstring( Tab_1.TabPage_1.dw_2.GetRow(), 'nm_destino') = 'TDF' then
		Tab_1.TabPage_2.dw_3.getchild( 'nm_usuario_revisao', dwc_nm_usuario_revisao)
		dwc_nm_usuario_revisao.settransobject( sqlca ) 
		dwc_nm_usuario_revisao.retrieve()
	end if

End if

Return lvl_ret
end event

event dw_3::getfocus;//override
end event

type cb_reprocessar from commandbutton within tabpage_1
integer x = 4187
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
Long lvl_ret

DateTime lvdh_Servidor

Longlong lvl_ID_Log

String lvs_Situacao
String lvs_Especie
String lvs_Serie
String lvs_Tipo_Doc
String lvs_Chave_NF
String lvs_BD

Try
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ao marcar essa nota para reprocessar o sistema ir$$HEX1$$e100$$ENDHEX$$ marcar "+&
						"este log como exclu$$HEX1$$ed00$$ENDHEX$$do e far$$HEX1$$e100$$ENDHEX$$ uma nova tentativa de envio ao SAP/CAR-TDF.~r~r"+ &
						"Deseja continuar?", Question!, YesNo!, 2) = 1 Then
		
		Parent.dw_2.SetRedraw(False)
		
		Parent.dw_2.SetFilter("id_selecionar='S'")
		Parent.dw_2.Filter()
		
		Open(w_aguarde)
		w_aguarde.Title = "Marcando log's como exclu$$HEX1$$ed00$$ENDHEX$$dos..."
		w_aguarde.uo_Progress.Of_SetMax( Parent.dw_2.RowCount() )
		
		For lvl_Linha = 1 To Parent.dw_2.RowCount()
			w_aguarde.uo_Progress.Of_SetProgress(lvl_Linha)
			lvl_ID_Log 		= Parent.dw_2.Object.nr_atualizacao		[lvl_Linha]
			lvs_Situacao	= Parent.dw_2.Object.id_situacao_log	[lvl_Linha]
			lvl_Filial		= Parent.dw_2.Object.cd_filial			[lvl_Linha]	
			lvl_NF			= Parent.dw_2.Object.nr_nf					[lvl_Linha]	
			lvs_Especie		= Parent.dw_2.Object.de_especie			[lvl_Linha]	
			lvs_Serie		= Parent.dw_2.Object.de_serie				[lvl_Linha]
			lvs_Tipo_Doc	= Parent.dw_2.Object.de_tipo_docto		[lvl_Linha]
			lvs_BD			= Parent.dw_2.Object.base_dados			[lvl_Linha]
			
			lvs_Chave_NF	= String(lvl_Filial, "0000")+"/"+String(lvl_NF)+"/"+lvs_Especie+"/"+lvs_Serie
			
			//Registro j$$HEX1$$e100$$ENDHEX$$ exclu$$HEX1$$ed00$$ENDHEX$$do
			If lvs_Situacao = "X" Then Continue	
			//Registro processado
			If lvs_Situacao = "P" or lvs_Situacao = "I" Then
				if lvl_ret = 0 then 
					lvl_ret = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A opera$$HEX2$$e700e300$$ENDHEX$$o "+lvs_Tipo_Doc+" do documento "+lvs_Chave_NF+" j$$HEX1$$e100$$ENDHEX$$ foi processada/integrada no SAP. "+ "O reprocessamento far$$HEX1$$e100$$ENDHEX$$ com que o sistema envie essa opera$$HEX2$$e700e300$$ENDHEX$$o novamente.~r~r" + "Deseja realmente excluir este log e tentar reprocess$$HEX1$$e100$$ENDHEX$$-lo?", Question!, YesNo!, 2)
					if lvl_ret = 1 then
						lvl_ret = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja repetir a opera$$HEX2$$e700e300$$ENDHEX$$o para todas as linhas selecionadas?", Question!, YesNo!, 2)
					end if
				end if
				If lvl_ret = 2 Then Exit
			End If
			
			if lvs_BD = 'SYBASE' then
				ivtr_geral = sqlca
			elseif lvs_BD = 'MULT' then
				ivtr_geral = ivtr_Mult
			else
				continue
			end if

			lvdh_Servidor = gf_getserverdate()
				
			Update log_exportacao_docto
			set id_situacao_log = 'X',
				 nr_matricula_revisao = :gvo_aplicacao.ivo_seguranca.nr_matricula,
				 dh_revisao		=	:lvdh_Servidor,
				 dh_exclusao	=	:lvdh_Servidor,
				 de_revisao		=	'REPROCESSADO',
				 id_revisado		=	'R'
			Where nr_atualizacao = :lvl_ID_Log
				And coalesce(id_situacao_log, '') <> 'X'
			Using ivtr_geral;
			
			If ivtr_geral.SQLCode = -1 Then
				ivtr_geral.Of_RollBack()
				ivtr_geral.Of_Msgdberror( "Falha ao atualizar status do log de exporta$$HEX2$$e700e300$$ENDHEX$$o." )
			Else
				ivtr_geral.Of_Commit()
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
	If IsValid(w_aguarde) Then Close(w_aguarde)
	
	Parent.dw_2.SetFilter("")
	Parent.dw_2.Filter()
	Parent.dw_2.setsort("dh_exportacao ds, nr_atualizacao as")
	Parent.dw_2.sort()
	Parent.dw_2.SetRedraw(True)
End Try
end event

type st_confirmar from statictext within tabpage_1
boolean visible = false
integer x = 3479
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
integer x = 3749
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

DateTime lvdh_Servidor

String lvs_Situacao
String lvs_Revisao
String lvs_destino

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
				lvs_destino 	= ''
				lvl_ID_Log 	= Parent.dw_2.Object.nr_atualizacao		[lvl_Linha]
				lvs_destino 	= Parent.dw_2.Object.base_dados		[lvl_Linha]
		
				if lvs_destino = 'SYBASE' then
					ivtr_geral = sqlca
				elseif lvs_destino = 'MULT' then
					ivtr_geral = ivtr_Mult
				else
					continue
				end if
		
				lvdh_Servidor = gf_getserverdate()
		
				Update log_exportacao_docto
				set nr_matricula_revisao = :gvo_aplicacao.ivo_seguranca.nr_matricula,
					 dh_revisao		=	:lvdh_Servidor,
					 de_revisao		=	:lvs_Revisao,
					 id_revisado		=	:lvs_Situacao
				Where nr_atualizacao = :lvl_ID_Log
				Using ivtr_geral;
				
				If ivtr_geral.SQLCode = -1 Then
					ivtr_geral.Of_RollBack()
					ivtr_geral.Of_Msgdberror( "Falha ao atualizar status do log de exporta$$HEX2$$e700e300$$ENDHEX$$o." )
				Else
					ivtr_geral.Of_Commit()
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
	Parent.dw_2.setsort("dh_exportacao ds, nr_atualizacao as")
	Parent.dw_2.sort()
	Parent.dw_2.SetRedraw(True)
End Try
end event

type cb_alt_finaliz from commandbutton within tabpage_1
integer x = 3145
integer y = 508
integer width = 567
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "CAR - Alter. Finaliz."
end type

event clicked;Long lvl_Find
Decimal{0} lvdc_ID_Log

Try
	lvl_Find = dw_2.Find("nm_destino='CAR' and id_selecionar='S'", 1, dw_2.RowCount())

	//if ivs_id_usuario_informatica = 'N' then return
	
	If lvl_Find > 0 Then
		lvdc_ID_Log = dw_2.Object.nr_atualizacao [lvl_Find]
		
		OpenSheetWithParm(w_ge471_troca_finalizadora, lvdc_ID_Log, dc_w_mdi)
	
		dw_2.Object.id_selecionar [lvl_Find] = 'N'
		Parent.dw_2.Post Event ue_Atualiza_Botoes()
	End If

Catch (RuntimeError lvo_Erro)
	MessageBox("Erro", lvo_Erro.GetMessage(), StopSign!)
	Return -1
	
Finally
	//
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
integer width = 4402
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
Long lvl_Linha, lvl_ret
Decimal{0} lvdc_Atualizacao

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

If Not lvl_Linha > 0 Then Return -1

lvdc_Atualizacao = Tab_1.TabPage_1.dw_2.Object.nr_atualizacao [lvl_Linha]

//if Tab_1.TabPage_1.dw_2.getitemstring( Tab_1.TabPage_1.dw_2.GetRow(), 'nm_destino') = 'TDF' then
//	if This.Retrieve(lvdc_Atualizacao) = 0 then
//		lvl_ret = Tab_1.TabPage_2.dw_4.insertrow(1)
//		Tab_1.TabPage_2.dw_4.setitem(lvl_ret, 'nr_atualizacao_item',1)
//		Tab_1.TabPage_2.dw_4.setitem(lvl_ret, 'nr_item_sequencial',1)
//		Tab_1.TabPage_2.dw_4.setitem(lvl_ret, 'id_tipo_log','PROCESSADO')
//		Tab_1.TabPage_2.dw_4.setitem(lvl_ret, 'nr_mensagem',1)		
//		Tab_1.TabPage_2.dw_4.setitem(lvl_ret, 'de_log','MOVIMENTO INTEGRADO COM SUCESSO.')	
//		return lvl_ret
//	end if
//else
	Return This.Retrieve(lvdc_Atualizacao)
//end if


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

event ue_recuperar;//override
Long lvl_Linha,lvl_ret
Decimal{0} lvdc_Atualizacao

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

If Not lvl_Linha > 0 Then Return -1

lvdc_Atualizacao = Tab_1.TabPage_1.dw_2.Object.nr_atualizacao [lvl_Linha]

//if Tab_1.TabPage_1.dw_2.getitemstring( Tab_1.TabPage_1.dw_2.GetRow(), 'nm_destino') = 'TDF' then
//	if This.Retrieve(lvdc_Atualizacao) = 0 then
//		lvl_ret = Tab_1.TabPage_2.dw_5.insertrow(1)
//		Tab_1.TabPage_2.dw_5.setitem(lvl_ret, 'de_log','MOVIMENTO INTEGRADO COM SUCESSO.')	
//		return lvl_ret
//	end if
//else
	Return This.Retrieve(lvdc_Atualizacao)
//end if
end event

type uo_1 from uo_data_atual within w_ge471_monitor_integracao_car
integer x = 4238
integer y = 8
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_data_atual::destroy
end on

