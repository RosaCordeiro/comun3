HA$PBExportHeader$w_ge263_consulta_falta_prod_filial.srw
forward
global type w_ge263_consulta_falta_prod_filial from dc_w_2tab_consulta_selecao_lista_det
end type
type dw_relatorio from dc_uo_dw_base within tabpage_1
end type
type dw_relatorio_detalhes from dc_uo_dw_base within tabpage_2
end type
end forward

global type w_ge263_consulta_falta_prod_filial from dc_w_2tab_consulta_selecao_lista_det
integer width = 2958
integer height = 1736
string title = "GE263 - Consulta Produtos Procurados em Falta Filiais"
end type
global w_ge263_consulta_falta_prod_filial w_ge263_consulta_falta_prod_filial

type variables
DataWindowChild	idwc_Child

uo_filial ivo_Filial
dc_uo_ds_base ivds_Venda
end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();/* Regiao */
idwc_Child  = Tab_1.tabpage_1.Dw_1.of_InsertRow_DDDW("cd_regiao" )			

idwc_Child.SetItem(1, "cd_regiao", 0	)
idwc_Child.SetItem(1, "de_regiao", "TODOS")

Tab_1.tabpage_1.dw_1.Object.cd_regiao[1] = 0

idwc_Child  = Tab_1.tabpage_1.Dw_1.of_InsertRow_DDDW("cd_grupo" )			

idwc_Child.SetItem(1, "cd_grupo", "0"	)
idwc_Child.SetItem(1, "de_grupo", "TODOS")

Tab_1.tabpage_1.dw_1.Object.cd_grupo[1] = 0
end subroutine

on w_ge263_consulta_falta_prod_filial.create
int iCurrent
call super::create
end on

on w_ge263_consulta_falta_prod_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;ivo_Filial = Create uo_Filial

ivds_Venda = Create dc_uo_ds_base
ivds_Venda.of_ChangeDataObject('ds_ge263_venda_grupo')

ivm_menu.ivb_permite_imprimir = True

MaxHeight = 9999
end event

event close;call super::close;Destroy(ivo_Filial)
end event

event ue_postopen;call super::ue_postopen;Tab_1.Tabpage_1.Dw_1.Object.dt_inicio	[1] = gf_primeiro_dia_mes(Today())
Tab_1.Tabpage_1.Dw_1.Object.dt_fim	[1] = Today()

wf_insere_padrao()
end event

event ue_saveas;call super::ue_saveas;If Tab_1.SelectedTab = 1 Then
	Tab_1.Tabpage_1.dw_relatorio.Event ue_SaveAs()
Else
	Tab_1.Tabpage_2.dw_relatorio_detalhes.Event ue_SaveAs()
End If
end event

event open;call super::open;

If  gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> "CO" Then
	Tab_1.Tabpage_1.dw_1.object.id_zero.visible = False
End If	



end event

event resize;call super::resize;Tab_1.Height = NewHeight - Tab_1.Y - 10
Tab_1.Tabpage_1.gb_2.Height = NewHeight - Tab_1.Tabpage_1.gb_2.Y - 160
Tab_1.Tabpage_1.dw_2.Height = NewHeight - Tab_1.Tabpage_1.dw_2.Y - 200


Tab_1.Tabpage_2.gb_3.Height = NewHeight - Tab_1.Tabpage_2.gb_3.Y - 160
Tab_1.Tabpage_2.dw_3.Height = NewHeight - Tab_1.Tabpage_2.dw_3.Y - 200
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge263_consulta_falta_prod_filial
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge263_consulta_falta_prod_filial
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge263_consulta_falta_prod_filial
integer width = 2898
integer height = 1536
end type

event tab_1::selectionchanging;call super::selectionchanging;Long lvl_Linha
Long lvl_Filial

If NewIndex = 2 Then
	lvl_Linha = Tabpage_1.Dw_2.GetRow()
	If lvl_Linha > 0 Then
		lvl_Filial = Tabpage_1.Dw_2.Object.cd_filial [lvl_Linha]
		Tabpage_2.gb_3.text = 'Detalhes - Filial ('+String(lvl_Filial)+')'
	End If
End If
end event

event tab_1::selectionchanged;//override
If NewIndex = 1 Then
	Tabpage_2.dw_3.ivm_menu.mf_imprimir(False)
	Tabpage_2.dw_3.ivm_menu.mf_salvarcomo(False)
	Tabpage_1.dw_2.ivm_menu.mf_imprimir(Tabpage_1.dw_2.RowCount()>0)
	Tabpage_1.dw_2.ivm_menu.mf_salvarcomo(Tabpage_1.dw_2.RowCount()>0)	
ElseIf NewIndex = 2 Then
	Tabpage_1.dw_2.ivm_menu.mf_imprimir(False)
	Tabpage_1.dw_2.ivm_menu.mf_salvarcomo(False)
	Tabpage_2.dw_3.ivm_menu.mf_imprimir(Tabpage_2.dw_3.RowCount()>0)
	Tabpage_2.dw_3.ivm_menu.mf_salvarcomo(Tabpage_2.dw_3.RowCount()>0)
End If
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 2862
integer height = 1420
dw_relatorio dw_relatorio
end type

on tabpage_1.create
this.dw_relatorio=create dw_relatorio
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_relatorio
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_relatorio)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 404
integer width = 2811
integer height = 1000
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer y = 4
integer width = 2085
integer height = 400
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer y = 72
integer width = 2007
integer height = 304
string dataobject = "dw_ge263_selecao"
end type

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()	
		Case "nm_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
				This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
			End If
			
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name		
	Case "nm_filial"
		If Data <> ivo_Filial.Nm_Fantasia Then
			If Data <> '' Then
				Return 1
			Else
				ivo_Filial.of_inicializa( )
				This.Object.cd_filial [Row] = ivo_Filial.cd_filial
			End If
		End If
End Choose
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer y = 468
integer width = 2729
integer height = 908
string dataobject = "dw_ge263_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Regiao
Long lvl_Filial
Long lvl_Grupo
String lvs_Id_Zero


ivds_Venda.of_restoresqloriginal( )

Parent.Dw_1.Accepttext( )

This.ivm_menu.mf_imprimir(False)
This.ivm_menu.mf_salvarcomo(False)

lvl_Filial 		= Parent.Dw_1.Object.cd_filial		[1]
lvl_Regiao	= Parent.Dw_1.Object.cd_regiao	[1]
lvl_Grupo		= Parent.Dw_1.Object.cd_grupo	[1]
lvs_Id_Zero	= Parent.Dw_1.Object.id_zero      [1]



If lvl_Grupo > 0 Then
	ivds_Venda.of_changedataobject('ds_ge263_venda_grupo')
	This.Of_AppendWhere("substring(pg.cd_subcategoria,1,1) = '"+String(lvl_Grupo)+"'")
	ivds_Venda.Of_AppendWhere("substring(pg.cd_subcategoria,1,1) = '"+String(lvl_Grupo)+"'")
End If

If lvl_Filial > 0 Then
	This.Of_AppendWhere('ppc.cd_filial = '+String(lvl_Filial))
	ivds_Venda.Of_AppendWhere('r.cd_filial = '+String(lvl_Filial))
End If

If lvl_Regiao > 0 Then
	This.Of_AppendWhere('f.cd_regiao = '+String(lvl_Regiao))	
	ivds_Venda.Of_AppendWhere('f.cd_regiao = '+String(lvl_Regiao))	
End If


This.Of_appendWhere("ppc.id_tipo = '"+String(lvs_Id_Zero)+"'")


Return AncestorReturnValue
end event

event dw_2::ue_recuperar;//override
Date lvdt_Inicio
Date lvdt_Fim

Parent.Dw_1.Accepttext( )

lvdt_Inicio 	= Parent.Dw_1.Object.dt_inicio	[1]
lvdt_Fim		= Parent.Dw_1.Object.dt_fim	[1]

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long lvl_Linha
Long lvl_Find
Long lvl_Filial

Decimal{2} lvdc_Venda
Decimal{2} lvpc_Falta
Decimal{2} lvdc_Falta

//override
Date lvdt_Inicio
Date lvdt_Fim

If (pl_linhas > 0) then	
	Parent.Dw_1.Accepttext( )

	lvdt_Inicio 	= Parent.Dw_1.Object.dt_inicio	[1]
	lvdt_Fim		= Parent.Dw_1.Object.dt_fim	[1]
	
	Open(w_aguarde)
	w_aguarde.uo_progress.of_setmax(pl_linhas)
	w_aguarde.Title = 'Recuperando Valores de Venda Bruta do Per$$HEX1$$ed00$$ENDHEX$$odo...'
	
	For lvl_Linha = 1 To pl_linhas
		w_aguarde.uo_progress.of_setprogress(lvl_Linha)
		lvl_Filial 		= This.Object.cd_filial	[lvl_Linha]
		lvdc_Falta 	= This.Object.vl_falta	[lvl_Linha]
		lvdc_Venda 	= 0.00
		lvpc_Falta	= 0.00
		
		If ivds_Venda.Retrieve(lvdt_Inicio,lvdt_Fim,lvl_Filial) > 0 Then
			lvl_Find = ivds_Venda.Find('cd_filial='+String(lvl_Filial),1,ivds_Venda.RowCount())
			If lvl_Find > 0 then
				lvdc_Venda 	= ivds_Venda.Object.vl_venda_bruta [lvl_Find]
				
				If lvdc_Venda > 0 Then
					lvpc_Falta	= Round((lvdc_Falta / lvdc_Venda) * 100,2)
				End If
			End If
		End If
		
		This.Object.vl_venda	[lvl_Linha] = lvdc_Venda
		This.Object.pc_falta	[lvl_Linha] = lvpc_Falta	
	Next
	Close(w_aguarde)
End If

This.ivm_menu.mf_imprimir(pl_linhas > 0)
This.ivm_menu.mf_salvarcomo(pl_linhas > 0)

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_menu.mf_imprimir(False)
This.ivm_menu.mf_salvarcomo(False)
end event

event dw_2::ue_print;//override
dw_relatorio.Event ue_print()
end event

event dw_2::ue_printimmediate;//override
dw_relatorio.Event ue_PrintImmediate()
end event

event dw_2::constructor;call super::constructor;This.Sharedata(dw_relatorio)
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 2862
integer height = 1420
dw_relatorio_detalhes dw_relatorio_detalhes
end type

on tabpage_2.create
this.dw_relatorio_detalhes=create dw_relatorio_detalhes
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_relatorio_detalhes
end on

on tabpage_2.destroy
call super::destroy
destroy(this.dw_relatorio_detalhes)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 2816
integer height = 1384
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer width = 2734
integer height = 1280
string dataobject = "dw_ge263_detalhes"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_3::ue_recuperar;//override
Long lvl_Linha
Long lvl_Filial
Long lvl_Grupo

String lvs_Id_Zero

Date lvdt_Inicio
Date lvdt_Fim

Tab_1.Tabpage_1.dw_1.accepttext( )

lvl_Linha 		= Tab_1.Tabpage_1.Dw_2.GetRow()
lvl_Filial		= Tab_1.Tabpage_1.Dw_2.Object.cd_filial	[lvl_Linha]
lvdt_Inicio	= Tab_1.Tabpage_1.dw_1.Object.dt_inicio	[1]
lvdt_Fim		= Tab_1.Tabpage_1.dw_1.Object.dt_fim		[1]
lvl_Grupo		= Tab_1.Tabpage_1.dw_1.Object.cd_grupo	[1]
lvs_Id_Zero	= Tab_1.Tabpage_1.dw_1.Object.id_zero   [1]

If lvl_Grupo > 0 Then
	This.Of_appendwhere("substring(pg.cd_subcategoria,1,1) = '"+String(lvl_Grupo)+"'")
End if

This.Of_appendWhere("ppc.id_tipo = '"+String(lvs_Id_Zero)+"'")



Return This.Retrieve(lvdt_Inicio,lvdt_Fim,lvl_Filial)
end event

event dw_3::constructor;call super::constructor;This.of_setrowselection( )

This.Sharedata(dw_relatorio_detalhes)
end event

event dw_3::ue_reset;call super::ue_reset;This.ivm_menu.mf_imprimir(False)
This.ivm_menu.mf_salvarcomo(False)
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;This.ivm_menu.mf_imprimir(pl_linhas > 0)
This.ivm_menu.mf_salvarcomo(pl_linhas > 0)

Return AncestorReturnValue
end event

event dw_3::ue_preretrieve;call super::ue_preretrieve;This.ivm_menu.mf_imprimir(False)
This.ivm_menu.mf_salvarcomo(False)

Return AncestorReturnValue
end event

event dw_3::ue_print;//override
dw_relatorio_detalhes.Event ue_Print()
end event

event dw_3::ue_printimmediate;//override
dw_relatorio_detalhes.Event ue_PrintImmediate()
end event

type dw_relatorio from dc_uo_dw_base within tabpage_1
integer x = 2441
integer y = 12
integer width = 421
integer height = 188
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge263_relatorio_filial"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;Date lvdt_Inicio
Date lvdt_Fim

dw_1.AcceptText()

lvdt_Inicio	= dw_1.Object.dt_inicio	[1]
lvdt_Fim		= dw_1.Object.dt_fim		[1]

This.Object.st_filtro.Text = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(lvdt_Inicio)+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdt_Fim)

Return AncestorReturnValue
end event

event constructor;call super::constructor;This.Visible = False
end event

event ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

type dw_relatorio_detalhes from dc_uo_dw_base within tabpage_2
integer x = 494
integer y = 728
integer width = 878
integer height = 260
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge263_relatorio_detalhes"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;Date lvdt_Inicio
Date lvdt_Fim

Long lvl_Linha
Long lvl_Filial 

String lvs_Filial

Tab_1.TabPage_1.dw_1.AcceptText()

lvdt_Inicio	= Tab_1.TabPage_1.dw_1.Object.dt_inicio	[1]
lvdt_Fim		= Tab_1.TabPage_1.dw_1.Object.dt_fim		[1]

lvl_Linha		= Tab_1.TabPage_1.dw_2.GetRow()
lvl_Filial		= Tab_1.TabPage_1.dw_2.Object.cd_filial 		[lvl_Linha]
lvs_Filial		= Tab_1.TabPage_1.dw_2.Object.nm_fantasia	[lvl_Linha]

This.Object.st_filtro.Text = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(lvdt_Inicio)+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdt_Fim)
This.Object.st_Titulo_filial.Text = lvs_Filial + ' ('+String(lvl_Filial)+')'

Return AncestorReturnValue
end event

event constructor;call super::constructor;This.Visible = False
end event

event ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

