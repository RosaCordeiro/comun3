HA$PBExportHeader$w_ge341_relatorio_diverg_agend.srw
forward
global type w_ge341_relatorio_diverg_agend from dc_w_2tab_consulta_selecao_lista_det
end type
type gb_4 from groupbox within tabpage_2
end type
type dw_4 from dc_uo_dw_base within tabpage_2
end type
end forward

global type w_ge341_relatorio_diverg_agend from dc_w_2tab_consulta_selecao_lista_det
integer width = 4343
integer height = 2668
string title = "GE341 - Relat$$HEX1$$f300$$ENDHEX$$rio de Diverg$$HEX1$$ea00$$ENDHEX$$ncias dos Arquivos XML"
end type
global w_ge341_relatorio_diverg_agend w_ge341_relatorio_diverg_agend

type variables
uo_fornecedor io_Fornecedor //ge003

dc_uo_dw_base dw_1, dw_2, dw_3, dw_4
end variables

on w_ge341_relatorio_diverg_agend.create
int iCurrent
call super::create
end on

on w_ge341_relatorio_diverg_agend.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;dw_1 = Tab_1.TabPage_1.dw_1
dw_2 = Tab_1.TabPage_1.dw_2
dw_3 = Tab_1.TabPage_2.dw_3
dw_4 = Tab_1.TabPage_2.dw_4
io_Fornecedor = Create uo_Fornecedor
end event

event ue_preopen;call super::ue_preopen;// Dimens$$HEX1$$f500$$ENDHEX$$es da Primeira Tela
ivl_Largura_1	= 2330
ivl_Altura_1		= 2200
// Dimens$$HEX1$$f500$$ENDHEX$$es da Segunda Tela
ivl_Largura_2 	= 4260 
ivl_Altura_2 		= 2475
end event

event close;call super::close;Destroy(io_Fornecedor)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.Dh_Inicio		[1] = gvo_Parametro.of_Dh_Movimentacao()
dw_1.Object.Dh_Termino	[1] = dw_1.Object.Dh_Inicio[1]


end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge341_relatorio_diverg_agend
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge341_relatorio_diverg_agend
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge341_relatorio_diverg_agend
integer y = 24
integer width = 4270
integer height = 2448
end type

event tab_1::selectionchanged;call super::selectionchanged;DateTime ldh_Inicio
DateTime ldh_Termino
String ls_Fornecedor
Long ll_Divergencia

if (newindex = 2) then 
	dw_3.of_RestoreOriginalSQL()
	dw_1.Accepttext()
	ldh_Inicio		= dw_1.Object.Dh_Inicio					[1]
	ldh_Termino	= dw_1.Object.Dh_Termino				[1]
	ls_Fornecedor	= dw_2.Object.Cd_Fornecedor			[dw_2.GetRow()]
	ll_Divergencia	= dw_1.Object.Id_Tipo_Divergencia	[1]
	
	If ll_Divergencia > 0 Then
		dw_3.of_AppendWhere("h.cd_tipo_divergencia = " + String(ll_Divergencia), 1)		
    End If
	
	
	dw_3.retrieve(ldh_Inicio,ldh_Termino, ls_fornecedor, ll_Divergencia )	
	dw_3.event rowfocuschanged(dw_3.GetRow())

end if 
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 4233
integer height = 2332
end type

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer width = 2226
integer height = 1676
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 2226
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 46
integer width = 2185
string dataobject = "dw_ge341_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_razao_social" Then
		io_Fornecedor.of_Localiza_Fornecedor(This.GetText())
		
		If Not io_Fornecedor.Localizado Then
			io_Fornecedor.of_Inicializa()
		End If
		
		This.Object.Cd_Fornecedor		[1]	= io_Fornecedor.Cd_Fornecedor
		This.Object.Nm_Razao_Social	[1]	= io_Fornecedor.Nm_Razao_Social
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

If dwo.Name = "nm_razao_social" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Fornecedor.Nm_Razao_Social Then
			Return 1
		End If
	Else
		io_Fornecedor.of_Inicializa()
		
		This.Object.Cd_Fornecedor		[1] = io_Fornecedor.Cd_Fornecedor
		This.Object.Nm_Razao_Social	[1] = io_Fornecedor.Nm_Razao_Social
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

If dwo.Name = "nm_razao_social" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Fornecedor.Nm_Razao_Social Then
			Return 1
		End If
	Else
		io_Fornecedor.of_Inicializa()
		
		This.Object.Cd_Fornecedor		[1] = io_Fornecedor.Cd_Fornecedor
		This.Object.Nm_Razao_Social	[1] = io_Fornecedor.Nm_Razao_Social
	End If
End If
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer width = 2144
integer height = 1584
string dataobject = "dw_ge341_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;DateTime ldh_Inicio
DateTime ldh_Termino
Long ll_Divergencia
String ls_Fornecedor

dw_1.AcceptText()
ldh_Inicio		= dw_1.Object.Dh_Inicio					[1]
ldh_Termino	= dw_1.Object.Dh_Termino				[1]
ls_Fornecedor	= dw_1.Object.Cd_Fornecedor			[1]
ll_Divergencia	= dw_1.Object.Id_Tipo_Divergencia	[1]

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If Not IsNull(ls_Fornecedor) And Trim(ls_Fornecedor) <> "" Then
	This.of_AppendWhere("f.cd_fornecedor = '" + ls_Fornecedor + "'", 1)	
End If

If ll_Divergencia > 0 Then
	This.of_AppendWhere("h.cd_tipo_divergencia = " + String(ll_Divergencia), 1)	
End If

Return 1
end event

event dw_2::ue_recuperar;//OverRide
Return This.Retrieve(dw_1.Object.Dh_Inicio[1], dw_1.Object.Dh_Termino[1])
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 4233
integer height = 2332
gb_4 gb_4
dw_4 dw_4
end type

on tabpage_2.create
this.gb_4=create gb_4
this.dw_4=create dw_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.dw_4
end on

on tabpage_2.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.dw_4)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 2496
integer height = 1228
string text = "Resumo"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer width = 2437
integer height = 1136
string dataobject = "dw_ge341_resumo"
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event dw_3::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_3::rowfocuschanged;call super::rowfocuschanged;DateTime ldh_Inicio
DateTime ldh_Termino
String ls_Fornecedor
long  ll_Divergencia

ldh_Inicio		= dw_1.Object.Dh_Inicio					[1]
ldh_Termino	= dw_1.Object.Dh_Termino				[1]
ls_Fornecedor	= dw_2.Object.Cd_Fornecedor			[dw_2.GetRow()]
ll_Divergencia   = dw_3.Object.cd_tipo_divergencia	[dw_3.GetRow()]

// Carrega os dados
dw_4.retrieve(ldh_Inicio,ldh_Termino,ls_Fornecedor,ll_Divergencia)

end event

event dw_3::ue_retrieve;// overide
return 1
end event

type gb_4 from groupbox within tabpage_2
integer x = 23
integer y = 1272
integer width = 4169
integer height = 1052
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Detalhes"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within tabpage_2
integer x = 55
integer y = 1360
integer width = 4119
integer height = 936
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge341_detalhe"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event ue_recuperar;// overide
return 1

end event

