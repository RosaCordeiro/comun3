HA$PBExportHeader$w_ge587_relatorio_produtividade_abast.srw
forward
global type w_ge587_relatorio_produtividade_abast from dc_w_2tab_consulta_selecao_lista_det
end type
type dw_4 from dc_uo_dw_base within tabpage_1
end type
type dw_5 from dc_uo_dw_base within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
end forward

global type w_ge587_relatorio_produtividade_abast from dc_w_2tab_consulta_selecao_lista_det
string tag = "w_ge587_relatorio_produtividade_abast"
integer width = 2249
integer height = 1840
string title = "GE587 - Relat$$HEX1$$f300$$ENDHEX$$rio de Produtividade do Abastecimento"
end type
global w_ge587_relatorio_produtividade_abast w_ge587_relatorio_produtividade_abast

type variables
Long ivl_Linha_Selecionada
end variables

forward prototypes
public subroutine wf_insere_padrao ()
public subroutine _documentacao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild lvdwc

If Tab_1.TabPage_1.dw_1.GetChild("cd_esteira", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	lvdwc.SetItem(1, "cd_esteira", 0)
	lvdwc.SetItem(1, "de_esteira", "TODAS")
	Tab_1.TabPage_1.dw_1.Object.cd_esteira[1] = 0
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da esteira.")
End If

If Tab_1.TabPage_1.dw_1.GetChild("cd_grupo", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	lvdwc.SetItem(1, "cd_grupo", "0")
	lvdwc.SetItem(1, "de_grupo", "TODOS")
	Tab_1.TabPage_1.dw_1.Object.Cd_Grupo[1] = "0"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do grupo.")
End If

end subroutine

public subroutine _documentacao ();/*
	Tela com detalhamento do abastecimento e relatorio mensal e diario do m$$HEX1$$ea00$$ENDHEX$$s
	
	Tabelas:
		wms_historico_abast_flow_rack 
		produto_geral 
*/
end subroutine

on w_ge587_relatorio_produtividade_abast.create
int iCurrent
call super::create
end on

on w_ge587_relatorio_produtividade_abast.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;Tab_1.tabpage_1.Dw_1.Object.dt_inicio	[1] = RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), -2)
Tab_1.tabpage_1.Dw_1.Object.dt_fim	[1] = RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), 0)

wf_insere_padrao()

ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
ivm_Menu.mf_salvarcomo(False)
ivm_Menu.mf_imprimir(False)

end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge587_relatorio_produtividade_abast
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge587_relatorio_produtividade_abast
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge587_relatorio_produtividade_abast
integer width = 2153
integer height = 1636
end type

event tab_1::selectionchanging;call super::selectionchanging;SetPointer(HourGlass!)

LONG lvl_Linha

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

If OldIndex = 1 Then
	ivl_Linha_Selecionada = Tab_1.TabPage_1.dw_2.GetRow()
End If

//If NewIndex = 1 and OldIndex = 2 Then
//	If ivl_Linha_Selecionada > 0 Then
//		Tab_1.TabPage_1.dw_2.SetRow(ivl_Linha_Selecionada)
//	End If
//End If
//
//Choose Case NewIndex
//	Case 1
//		Tab_1.TabPage_1.dw_2.Event ue_Reset()
//		Tab_1.TabPage_1.dw_4.Event ue_Reset()
//		Tab_1.TabPage_1.dw_5.Event ue_Reset()
//End Choose

SetPointer(Arrow!)

end event

event tab_1::selectionchanged;//Override
SetPointer(HourGlass!)

If NewIndex = 2 Then
	If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
		// das DW's de detalhes
		Tab_1.TabPage_2.dw_3.Event ue_Retrieve()

		ivm_Menu.mf_Incluir(False)
		ivm_Menu.mf_Excluir(False)

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

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 2117
integer height = 1520
dw_4 dw_4
dw_5 dw_5
st_1 st_1
end type

on tabpage_1.create
this.dw_4=create dw_4
this.dw_5=create dw_5
this.st_1=create st_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.dw_5
this.Control[iCurrent+3]=this.st_1
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.st_1)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 380
integer width = 2062
integer height = 1136
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 1202
integer height = 348
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 32
integer y = 80
integer width = 1179
integer height = 244
string dataobject = "dw_ge587_selecao"
boolean livescroll = false
end type

event dw_1::editchanged;call super::editchanged;tab_1.tabpage_1.dw_2.Event ue_Reset()
end event

event dw_1::itemchanged;call super::itemchanged;tab_1.tabpage_1.dw_2.Reset()

ivm_Menu.mf_salvarcomo(False)
ivm_Menu.mf_imprimir(False)
ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
end event

event dw_1::losefocus;call super::losefocus;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
end event

event dw_1::getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer y = 440
integer width = 2021
integer height = 1044
string dataobject = "dw_ge587_lista_totais"
end type

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
		lvs_Nome[]

ivb_ordena_colunas = True
		 
lvs_Coluna = {"mes","ano","qtd_caixa_sai_pulmao", "qtd_unidades_entra_flow"}

lvs_Nome = {"Mes","Ano","Qtd. Caixa Sai Pulmao", "Qtd. Unidades Entra Flow"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)

If pl_Linhas > 0 Then
	This.ivm_Menu.ivb_Permite_Imprimir = True
	This.ivo_Controle_Menu.of_Imprimir(True)
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_Imprimir(False)
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::ue_recuperar;//Override

Long ll_Esteira
String ls_Grupo
Date ldt_Inicio, ldt_Termino
Datetime ldth_Inicio, ldth_Termino

dw_1.AcceptText()

ldt_Inicio			= dw_1.Object.dt_inicio	[1]
ldt_Termino		= dw_1.Object.dt_fim		[1]
ls_Grupo			= dw_1.Object.cd_grupo	[1]
ll_Esteira			= dw_1.Object.cd_esteira[1]
  
If IsNull(dw_1.Object.dt_inicio[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data inicial deve ser informada.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1	
End If

If IsNull(dw_1.Object.dt_fim[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data final deve ser informada.")
	dw_1.Event ue_Pos(1, "dt_fim")
	Return -1	
End If

If ldt_Inicio > ldt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data inicial deve ser menor do que a data final.")
	dw_1.Event ue_Pos(1, "dt_fim")
	Return -1
End If

If ls_Grupo <> '0' Then
	This.of_AppendWhere("b.cd_grupo_produto = " + ls_Grupo)
End If

If Not IsNull(ll_Esteira) and ll_Esteira <> 0  Then
	This.of_AppendWhere("a.cd_esteira = " + string(ll_Esteira))
End If

ldt_Termino = gf_calcula_ultimo_dia_mes( long(string(ldt_Termino, 'mm')),  long(string(ldt_Termino, 'yyyy')) )

ldth_Inicio = datetime(date(string(ldt_Inicio, '01/mm/yyyy')), Time('00:00'))
ldth_Termino = datetime(ldt_Termino, Time('23:59'))

Return This.Retrieve(ldth_Inicio, ldth_Termino)
end event

event dw_2::ue_print;//Override

Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas = This.Event ue_PrePrint()

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		dw_4.Event ue_Print()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
	End If
End If

tab_1.tabpage_1.dw_4.reset()

SetPointer(Arrow!)
end event

event dw_2::ue_printimmediate;//Override

Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas = This.Event ue_PrePrint()

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		tab_1.tabpage_1.dw_4.Event ue_Printimmediate()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
	End If
End If

tab_1.tabpage_1.dw_4.reset()

SetPointer(Arrow!)
end event

event dw_2::getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 2117
integer height = 1520
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 2053
integer height = 1508
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer width = 1993
integer height = 1436
string dataobject = "dw_ge587_lista_dias_detalhes"
boolean vscrollbar = true
end type

event dw_3::ue_recuperar;Long ll_Rows, ll_Mes, ll_Ano, ll_Esteira
String ls_Grupo

Tab_1.TabPage_1.dw_1.AcceptText()
Tab_1.TabPage_1.dw_2.AcceptText()

ls_Grupo = tab_1.tabpage_1.dw_1.Object.cd_grupo	[1]
ll_Esteira = tab_1.tabpage_1.dw_1.Object.cd_esteira[1]

ll_Mes = Tab_1.TabPage_1.dw_2.Object.mes	[Tab_1.TabPage_1.dw_2.GetRow()]
ll_Ano	 = Tab_1.TabPage_1.dw_2.Object.ano	[Tab_1.TabPage_1.dw_2.GetRow()]

This.of_SetRowSelection()

ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)

If Not tab_1.tabpage_1.dw_4.of_ChangeDataObject("dw_ge587_relatorio_mes_detalhe") Then Return -1	  

If ls_Grupo <> '0' Then
	This.of_AppendWhere("b.cd_grupo_produto = " + ls_Grupo)
End If

If Not IsNull(ll_Esteira) and ll_Esteira <> 0  Then
	This.of_AppendWhere("a.cd_esteira = " + string(ll_Esteira))
End If

ll_Rows = This.Retrieve(ll_Mes, ll_Ano)

Return ll_Rows
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)

If pl_Linhas > 0 Then
	This.ivm_Menu.ivb_Permite_Imprimir = True
	This.ivo_Controle_Menu.of_Imprimir(True)
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_Imprimir(False)
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_3::constructor;call super::constructor;String lvs_Coluna[], &
		lvs_Nome[]
		
ivb_ordena_colunas = True

lvs_Coluna = {"dh_inclusao","qtd_caixa_sai_pulmao", "qtd_unidades_entra_flow"}

lvs_Nome = {"Data","Qtd. Caixa Sai Pulmao", "Qtd. Unidades Entra Flow"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome) 
end event

event dw_3::ue_print;//Override

Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas = This.Event ue_PrePrint()

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		tab_1.tabpage_1.dw_5.Event ue_Print()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
	End If
End If

tab_1.tabpage_1.dw_5.reset()

SetPointer(Arrow!)
end event

event dw_3::ue_printimmediate;//Override

Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas = This.Event ue_PrePrint()

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		tab_1.tabpage_1.dw_5.Event ue_Printimmediate()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
	End If
End If

tab_1.tabpage_1.dw_5.reset()

SetPointer(Arrow!)
end event

type dw_4 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 1243
integer y = 1264
integer width = 823
integer height = 220
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge587_relatorio"
boolean hscrollbar = true
end type

event ue_preprint;call super::ue_preprint;String ls_Grupo, ls_Texto_Est, ls_Texto_Grupo, ls_Esteira
Long ll_Esteira
Date ldt_Inicio, ldt_Termino
Datetime ldth_Inicio, ldth_Termino

This.Reset()

dw_1.AcceptText()

ldt_Inicio			= dw_1.Object.dt_inicio	[1]
ldt_Termino		= dw_1.Object.dt_fim		[1]
ls_Grupo 		= dw_1.Object.cd_grupo	[1]
ll_Esteira 		= dw_1.Object.cd_esteira[1]

If ls_Grupo <> '0' Then
	This.of_AppendWhere("b.cd_grupo_produto = " + ls_Grupo)
End If

If Not IsNull(ll_Esteira) and ll_Esteira <> 0  Then
	This.of_AppendWhere("a.cd_esteira = " + string(ll_Esteira))
End If

DataWindowChild ldwc

If dw_1.GetChild("cd_esteira", ldwc) = 1 Then
	ls_Esteira = string(ldwc.GetItemNumber(ldwc.GetRow(), "cd_esteira"))
	If ls_Esteira = "0" Or ls_Esteira = "" Then 
		ls_Texto_Est = "TODAS"
	Else	
		ls_Texto_Est = ldwc.GetItemString(ldwc.GetRow(), "de_esteira")
	End If
End If

If dw_1.GetChild("cd_grupo", ldwc) = 1 Then
	ls_Grupo = ldwc.GetItemString(ldwc.GetRow(), "cd_grupo")
	If ls_Grupo = "0" Then 
		ls_Texto_Grupo = "TODOS"
	Else	
		ls_Texto_Grupo = ls_Grupo + " - " + ldwc.GetItemString(ldwc.GetRow(), "de_grupo")
	End If
End If

This.Object.esteira_text.Text 	= ls_Texto_Est
This.Object.grupo_text.Text 	= ls_Texto_Grupo

ldt_Termino = gf_calcula_ultimo_dia_mes( long(string(ldt_Termino, 'mm')),  long(string(ldt_Termino, 'yyyy')) )

ldth_Inicio = datetime(date(string(ldt_Inicio, '01/mm/yyyy')), Time('00:00'))
ldth_Termino = datetime(ldt_Termino, Time('23:59'))

Return This.Retrieve(ldth_Inicio, ldth_Termino)
end event

type dw_5 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 1243
integer y = 1168
integer width = 823
integer height = 220
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge587_relatorio_mes_detalhe"
boolean hscrollbar = true
end type

event ue_preprint;call super::ue_preprint;String ls_Grupo, ls_Texto_Est, ls_Texto_Grupo, ls_Esteira
Long ll_Mes, ll_Ano, ll_Esteira

This.Reset()

dw_1.AcceptText()

ll_Mes = Tab_1.TabPage_1.dw_2.Object.mes	[Tab_1.TabPage_1.dw_2.GetRow()]
ll_Ano	 = Tab_1.TabPage_1.dw_2.Object.ano	[Tab_1.TabPage_1.dw_2.GetRow()]

ls_Grupo 		= dw_1.Object.cd_grupo	[1]
ll_Esteira 		= dw_1.Object.cd_esteira[1]

If ls_Grupo <> '0' Then
	This.of_AppendWhere("b.cd_grupo_produto = " + ls_Grupo)
End If

If Not IsNull(ll_Esteira) and ll_Esteira <> 0  Then
	This.of_AppendWhere("a.cd_esteira = " + string(ll_Esteira))
End If

DataWindowChild ldwc

If dw_1.GetChild("cd_esteira", ldwc) = 1 Then
	ls_Esteira = string(ldwc.GetItemNumber(ldwc.GetRow(), "cd_esteira"))
	If ls_Esteira = "0" Or ls_Esteira = "" Then 
		ls_Texto_Est = "TODAS"
	Else	
		ls_Texto_Est = ldwc.GetItemString(ldwc.GetRow(), "de_esteira")
	End If
End If

If dw_1.GetChild("cd_grupo", ldwc) = 1 Then
	ls_Grupo = ldwc.GetItemString(ldwc.GetRow(), "cd_grupo")
	If ls_Grupo = "0" Then 
		ls_Texto_Grupo = "TODOS"
	Else	
		ls_Texto_Grupo = ls_Grupo + " - " + ldwc.GetItemString(ldwc.GetRow(), "de_grupo")
	End If
End If

This.Object.esteira_text.Text 	= ls_Texto_Est
This.Object.grupo_text.Text 	= ls_Texto_Grupo

Return This.Retrieve(ll_Mes, ll_Ano)
end event

type st_1 from statictext within tabpage_1
integer x = 1271
integer y = 132
integer width = 795
integer height = 164
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "* Filtro de Esteira s$$HEX1$$f300$$ENDHEX$$ funcionar$$HEX1$$e100$$ENDHEX$$ corretamente com M$$HEX1$$ea00$$ENDHEX$$s/Ano a partir de 02/2023"
boolean focusrectangle = false
end type

