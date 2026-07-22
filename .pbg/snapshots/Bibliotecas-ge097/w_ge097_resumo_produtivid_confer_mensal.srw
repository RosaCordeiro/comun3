HA$PBExportHeader$w_ge097_resumo_produtivid_confer_mensal.srw
forward
global type w_ge097_resumo_produtivid_confer_mensal from dc_w_2tab_consulta_selecao_lista_det
end type
type dw_4 from dc_uo_dw_base within tabpage_1
end type
type dw_6 from dc_uo_dw_base within tabpage_1
end type
type dw_5 from dc_uo_dw_base within tabpage_2
end type
type dw_7 from dc_uo_dw_base within tabpage_2
end type
end forward

global type w_ge097_resumo_produtivid_confer_mensal from dc_w_2tab_consulta_selecao_lista_det
integer width = 3401
string title = "GE097 - Resumo Mensal da Confer$$HEX1$$ea00$$ENDHEX$$ncia"
end type
global w_ge097_resumo_produtivid_confer_mensal w_ge097_resumo_produtivid_confer_mensal

on w_ge097_resumo_produtivid_confer_mensal.create
int iCurrent
call super::create
end on

on w_ge097_resumo_produtivid_confer_mensal.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;Tab_1.TabPage_1.dw_1.Object.dh_inicio	[1] = gf_getServerDate()
Tab_1.TabPage_1.dw_1.Object.dh_termino	[1] = gf_getServerDate()

This.ivm_menu.ivb_Permite_Imprimir = True
end event

event open;call super::open;Tab_1.TabPage_1.dw_4.Visible = False
Tab_1.TabPage_1.dw_6.Visible = False
Tab_1.TabPage_2.dw_5.Visible = False
Tab_1.TabPage_2.dw_7.Visible = False
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge097_resumo_produtivid_confer_mensal
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge097_resumo_produtivid_confer_mensal
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge097_resumo_produtivid_confer_mensal
integer width = 3314
end type

event tab_1::selectionchanging;//OverRide

DateTime	ldh_Mes

String	ls_Filter


SetPointer(HourGlass!)

If NewIndex = 2 Then
	If Tab_1.TabPage_1.dw_2.GetRow() < 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
		Return 1
	End If
	
	Tab_1.TabPage_2.dw_3.of_SetMenu(ivm_Menu)
	Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_salvarcomo( True)
	Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Imprimir(True)
	
ElseIf NewIndex = 1 Then
	Tab_1.TabPage_1.dw_2.of_SetMenu(ivm_Menu)
	Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_salvarcomo( True)
	Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Imprimir(True)
End If		

SetPointer(Arrow!)
end event

event tab_1::selectionchanged;//OverRide

Choose Case newIndex
	Case 1
		Parent.width						= 2000
		Tab_1.width							= 1888
		Tab_1.TabPage_1.gb_2.width	= 1787
		Tab_1.TabPage_1.dw_2.width	= 1733
		
		Tab_1.TabPage_1.dw_2.SetFocus()
		
	Case 2
		Parent.width						= 3080
		Tab_1.width							= 2958
		Tab_1.TabPage_2.gb_3.width	= 2875
		Tab_1.TabPage_2.dw_3.width	= 2807
		
		Tab_1.TabPage_2.dw_3.SetFocus()
		
End Choose
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 3278
dw_4 dw_4
dw_6 dw_6
end type

on tabpage_1.create
this.dw_4=create dw_4
this.dw_6=create dw_6
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.dw_6
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_4)
destroy(this.dw_6)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 188
integer width = 2085
integer height = 1116
string text = "Resumo M$$HEX1$$e900$$ENDHEX$$dia Mensal"
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 1061
integer height = 164
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 41
integer width = 1029
integer height = 80
string dataobject = "dw_ge097_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Tab_1.TabPage_1.dw_2.Reset()
Tab_1.TabPage_2.dw_3.Reset()
end event

event dw_1::editchanged;call super::editchanged;Tab_1.TabPage_1.dw_2.Reset()
Tab_1.TabPage_2.dw_3.Reset()
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer x = 55
integer y = 260
integer width = 2030
integer height = 1028
string dataobject = "dw_ge097_lista"
end type

event dw_2::ue_recuperar;//OverRide

DateTime	ldh_Inicio,&
				ldh_Termino
				
Long ll_Linhas		

Try
	Open(w_Aguarde)
	w_Aguarde.Title = "Recuperando produtividade... Aguarde..."
	w_Aguarde.uo_Progress.of_SetMax(2)
	
	Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_salvarcomo( False)
	Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_salvarcomo( False)
	Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Imprimir(True)
	Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Imprimir(True)
				
	Tab_1.TabPage_1.dw_1.AcceptText()
	
	ldh_Inicio		=	DateTime(String(Tab_1.TabPage_1.dw_1.Object.dh_inicio		[1], "01/mm/yyyy 00:00:00"))
	
	ldh_Termino	= DateTime(gf_Retorna_Ultimo_Dia_Mes(Date(Tab_1.TabPage_1.dw_1.Object.dh_termino	[1])))
	ldh_Termino	=	DateTime(String(ldh_Termino, "dd/mm/yyyy 23:59:59"))
	
	ll_Linhas	= This.Retrieve(ldh_Inicio, ldh_Termino)

	w_Aguarde.uo_Progress.of_SetProgress(1)
	
	If ll_Linhas > 0 Then
		This.sharedata(Tab_1.TabPage_1.dw_6)
		
		w_Aguarde.Title = "Recuperando produtividade por colaborador... Aguarde..."
		
		Tab_1.TabPage_2.dw_3.Retrieve(ldh_Inicio, ldh_Termino)
		
		Tab_1.TabPage_2.dw_3.sharedata(Tab_1.TabPage_2.dw_7)
		
		w_Aguarde.uo_Progress.of_SetProgress(1)
		Sleep(1)
		
		Tab_1.TabPage_1.dw_2.of_SetMenu(This.ivm_Menu)
		Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_salvarcomo( True)
		Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Imprimir(True)
	End If
Finally
	Close(w_Aguarde)
End Try

Return ll_Linhas
end event

event dw_2::ue_saveas;//OverRide
Long	ll_Linha,&
		ll_Linhas
		
dc_uo_ds_base	lds_Itens	

		
ll_Linhas = This.RowCount()

If ll_Linhas > 0 Then
	
	For ll_Linha = 1 To ll_Linhas
		Tab_1.TabPage_1.dw_4.Object.dh_mes_conferencia	[ll_Linha]	= Date(This.Object.dh_mes_conferencia[ll_Linha])
		Tab_1.TabPage_1.dw_4.Object.qt_separada			[ll_Linha]	= This.Object.qt_separada[ll_Linha]
		Tab_1.TabPage_1.dw_4.Object.ds_tempo				[ll_Linha]	= This.GetItemString(ll_Linha, "compute_2")
		Tab_1.TabPage_1.dw_4.Object.nr_media_hora		[ll_Linha]	= This.GetItemDecimal(ll_Linha, "compute_1")
	Next
	
	Tab_1.TabPage_1.dw_4.Event ue_SaveAs()
	
End If
end event

event dw_2::ue_print;//OverRide

end event

event dw_2::ue_printimmediate;//OverRide
Long lvl_Linhas

DateTime	ldh_Inicio,&
				ldh_Termino

SetPointer(HourGlass!)

lvl_Linhas = Tab_1.TabPage_1.dw_6.Event ue_PrePrint()

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		ldh_Inicio		= Tab_1.TabPage_1.dw_1.object.dh_inicio		[1]
		ldh_Termino	= Tab_1.TabPage_1.dw_1.object.dh_termino	[1]
				
		Tab_1.TabPage_1.dw_6.object.t_periodo.text = "Per$$HEX1$$ed00$$ENDHEX$$odo de "+String(ldh_Inicio, "mm/yyyy")+" at$$HEX1$$e900$$ENDHEX$$ "+String(ldh_Termino, "mm/yyyy")
		Tab_1.TabPage_1.dw_6.of_Print(False)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
	End If
End If

SetPointer(Arrow!)
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 3278
dw_5 dw_5
dw_7 dw_7
end type

on tabpage_2.create
this.dw_5=create dw_5
this.dw_7=create dw_7
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_5
this.Control[iCurrent+2]=this.dw_7
end on

on tabpage_2.destroy
call super::destroy
destroy(this.dw_5)
destroy(this.dw_7)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 3223
string text = "Resumo por Colaborador"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer width = 3154
integer height = 1200
string dataobject = "dw_ge097_lista_por_colaborador"
boolean vscrollbar = true
end type

event dw_3::ue_saveas;//OverRide
Long	ll_Linha,&
		ll_Linhas
				
ll_Linhas = This.RowCount()

If ll_Linhas > 0 Then

	For ll_Linha = 1 To ll_Linhas
		Tab_1.TabPage_2.dw_5.Object.nr_matricula			[ll_Linha]	= This.Object.nr_matricula_conferente	[ll_Linha]
		Tab_1.TabPage_2.dw_5.Object.nm_usuario				[ll_Linha]	= This.Object.nm_usuario					[ll_Linha]
		Tab_1.TabPage_2.dw_5.Object.qt_separada			[ll_Linha]	= This.Object.qt_separada					[ll_Linha]
		Tab_1.TabPage_2.dw_5.Object.de_tempo				[ll_Linha]	= This.GetItemString(ll_Linha, "compute_1")
		Tab_1.TabPage_2.dw_5.Object.qt_media_hora		[ll_Linha]	= This.GetItemDecimal(ll_Linha, "compute_4")
	Next
	
	Tab_1.TabPage_2.dw_5.Event ue_SaveAs()
End If

end event

event dw_3::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_3::ue_print;//OverRide

end event

event dw_3::ue_printimmediate;//OverRide
Long lvl_Linhas

DateTime	ldh_Inicio,&
				ldh_Termino

SetPointer(HourGlass!)

lvl_Linhas = Tab_1.TabPage_2.dw_7.Event ue_PrePrint()

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		ldh_Inicio		= Tab_1.TabPage_1.dw_1.object.dh_inicio		[1]
		ldh_Termino	= Tab_1.TabPage_1.dw_1.object.dh_termino	[1]
				
		Tab_1.TabPage_2.dw_7.object.t_periodo.text = "Per$$HEX1$$ed00$$ENDHEX$$odo de "+String(ldh_Inicio, "mm/yyyy")+" at$$HEX1$$e900$$ENDHEX$$ "+String(ldh_Termino, "mm/yyyy")
		
		Tab_1.TabPage_2.dw_7.of_Print(False)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
	End If
End If

SetPointer(Arrow!)
end event

type dw_4 from dc_uo_dw_base within tabpage_1
integer x = 2418
integer y = 648
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge097_lista_excel"
end type

type dw_6 from dc_uo_dw_base within tabpage_1
integer x = 2437
integer y = 80
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge097_lista_rel"
end type

type dw_5 from dc_uo_dw_base within tabpage_2
integer x = 1897
integer y = 772
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge097_lista_por_colaborador_excel"
end type

type dw_7 from dc_uo_dw_base within tabpage_2
integer x = 1161
integer y = 780
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge097_lista_por_colaborador_rel"
end type

