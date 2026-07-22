HA$PBExportHeader$w_ge374_consulta_promocao_filial.srw
forward
global type w_ge374_consulta_promocao_filial from dc_w_2tab_consulta_selecao_lista_det
end type
type cb_1 from commandbutton within tabpage_1
end type
type dw_4 from dc_uo_dw_base within tabpage_1
end type
end forward

global type w_ge374_consulta_promocao_filial from dc_w_2tab_consulta_selecao_lista_det
string accessiblename = "Consulta Promo$$HEX2$$e700e300$$ENDHEX$$o por Filial (GE374)"
integer width = 3163
integer height = 2416
string title = "GE374 - Consulta Promo$$HEX2$$e700e300$$ENDHEX$$o por Filial"
end type
global w_ge374_consulta_promocao_filial w_ge374_consulta_promocao_filial

type variables
uo_Filial io_Filial
uo_produto ivo_produto

dc_uo_dw_base dw_1, dw_2, dw_3, dw_4
end variables

forward prototypes
public function boolean wf_valida_campos (dc_uo_dw_base adw)
end prototypes

public function boolean wf_valida_campos (dc_uo_dw_base adw);Long ll_Filial
Long ll_Produto

String ls_Vigencia
String ls_Tipo

dw_1.AcceptText()

ll_Filial 		= dw_1.Object.cd_filial		 [ 1 ]
ls_Vigencia	= dw_1.Object.id_vigencia	 [ 1 ]
ls_Tipo		= dw_1.Object.id_tipo		 [ 1 ]
ll_Produto	= dw_1.Object.cd_produto	 [ 1 ]

If IsNull( ll_Filial ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe uma filial.")
	dw_1.Event ue_Pos(1,"nm_filial")
	Return False
End If

If ls_Tipo <> 'T' Then
	adw.of_AppendWhere("p.id_tipo_promocao = '" + ls_Tipo + "'" )
End If

Choose Case ls_Vigencia
	Case 'N'  //N$$HEX1$$e300$$ENDHEX$$o Vigente
		adw.of_AppendWhere( 'p.dh_termino < x.dh_movimentacao' )
		
	Case 'V' //Vigente
		adw.of_AppendWhere( 'p.dh_inicio <= x.dh_movimentacao And ( p.dh_termino >= x.dh_movimentacao or p.dh_termino is null )' )
End Choose

If Not IsNull(ll_Produto) Then
	adw.of_AppendWhere("exists (select * from promocao_sos_produto pp where pp.cd_promocao_sos = p.cd_promocao_sos and pp.cd_produto = " + String(ll_Produto) +  ")" )
End If
end function

on w_ge374_consulta_promocao_filial.create
int iCurrent
call super::create
end on

on w_ge374_consulta_promocao_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;io_Filial = Create uo_Filial
ivo_Produto = Create uo_Produto

dw_1 = Tab_1.TabPage_1.dw_1
dw_2 = Tab_1.TabPage_1.dw_2
dw_3 = Tab_1.TabPage_2.dw_3
dw_4 = Tab_1.TabPage_1.dw_4

Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_SalvarComo(True)
end event

event close;call super::close;Destroy(io_Filial)
Destroy(ivo_Produto)

If IsValid( dw_1 ) Then Destroy dw_1
If IsValid( dw_2 ) Then Destroy dw_2
If IsValid( dw_3 ) Then Destroy dw_3
If IsValid( dw_4 ) Then Destroy dw_4
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge374_consulta_promocao_filial
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge374_consulta_promocao_filial
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge374_consulta_promocao_filial
integer width = 3086
integer height = 2200
end type

event tab_1::selectionchanged;//OverRide

SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		Tab_1.TabPage_1.dw_2.SetFocus()
	Case 2
		Tab_1.TabPage_2.dw_3.SetFocus()
End Choose

SetPointer(Arrow!)
end event

event tab_1::selectionchanging;//OverRide
Long ll_Row

SetPointer(HourGlass!)

If NewIndex = 2 Then
	ll_Row = Tab_1.TabPage_1.dw_2.GetRow()
	
	If ll_Row > 0 Then
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
		// das DW's de detalhes
		//Tab_1.TabPage_2.dw_3.Retrieve( Tab_1.TabPage_1.dw_2.Object.cd_promocao_sos[ ll_Row ] )
		
		Tab_1.TabPage_2.dw_3.Event ue_Retrieve()

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
integer width = 3049
integer height = 2084
cb_1 cb_1
dw_4 dw_4
end type

on tabpage_1.create
this.cb_1=create cb_1
this.dw_4=create dw_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_4
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_4)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer x = 5
integer y = 480
integer width = 3008
integer height = 1572
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer x = 5
integer width = 1696
integer height = 448
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 37
integer y = 104
integer width = 1632
integer height = 328
string dataobject = "dw_ge374_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_filial" Then

		io_Filial.of_Localiza_Filial( This.GetText() )

		If io_Filial.Localizada Then
			This.Object.cd_Filial		[1] = io_Filial.cd_Filial
			This.Object.nm_filial		[1] = io_Filial.nm_Fantasia			
		End If
	End If
	
	If This.GetColumnName() = "de_produto" Then
		ivo_Produto.of_Localiza_Produto(This.GetText())
		
		If ivo_Produto.Localizado Then
			dw_1.Object.Cd_Produto				[1] = ivo_Produto.Cd_Produto
			dw_1.Object.De_Produto				[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
		End If
	End If
End If



end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Filial.nm_Fantasia Then
				Return 1
			End If
		Else
			io_Filial.of_Inicializa()
			
			This.Object.cd_Filial		[1] = io_Filial.cd_Filial
			This.Object.nm_filial		[1] = io_Filial.nm_Fantasia
		End If
		
	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then 
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto				[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto				[1] = ivo_Produto.De_Apresentacao_Venda
		End If
End Choose
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Filial.nm_Fantasia Then
				Return 1
			End If
		Else
			io_Filial.of_Inicializa()
			
			This.Object.cd_Filial		[1] = io_Filial.cd_Filial
			This.Object.nm_filial		[1] = io_Filial.nm_Fantasia
		End If
	
	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then 
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto				[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto				[1] = ivo_Produto.De_Apresentacao_Venda
		End If
		
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Produto) Then
	This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer x = 37
integer y = 536
integer width = 2949
integer height = 1476
string dataobject = "dw_ge374_lista"
end type

event dw_2::ue_recuperar;//OverRide

If Not wf_Valida_Campos(dw_2) Then Return -1

Return This.Retrieve( dw_1.Object.Cd_Filial[1] )
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 3049
integer height = 2084
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer x = 5
integer width = 2747
integer height = 2040
string text = "Produtos"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 46
integer width = 2679
integer height = 1956
string dataobject = "dw_ge374_detalhe"
boolean vscrollbar = true
end type

event dw_3::ue_recuperar;Long ll_Promocao, ll_Produto

ll_Promocao	= dw_2.Object.cd_promocao_sos	[ dw_2.GetRow() ]
ll_Produto 	= dw_1.Object.cd_produto			[ 1 ]

If Not IsNull(ll_Produto) Then
	This.of_AppendWhere("b.cd_produto = " + String(ll_Produto))
End If

Return This.Retrieve( ll_Promocao ) 
end event

event dw_3::constructor;call super::constructor;This.of_SetRowSelection()

This.ivb_Ordena_Colunas = True
end event

type cb_1 from commandbutton within tabpage_1
integer x = 2583
integer y = 384
integer width = 425
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gerar Planilha"
end type

event clicked;If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja gerar todas as informa$$HEX2$$e700f500$$ENDHEX$$es das promo$$HEX2$$e700f500$$ENDHEX$$es listadas?", Question!, YesNo!, 2) = 2 Then Return -1

dw_4.of_RestoreOriginalSQL()

Long ll_Produto

dw_1.AcceptText()

Long ll_Linhas

If Not wf_Valida_Campos(dw_4) Then Return -1

Try
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Gerando planilha. Aguarde..."
	
	ll_Produto	= dw_1.Object.cd_produto	 [ 1 ]
	
	If Not IsNull(ll_Produto) Then
		dw_4.of_AppendWhere("pp.cd_produto = " + String(ll_Produto) )
	End If
	
	ll_Linhas 		= dw_4.Retrieve(dw_1.Object.Cd_Filial[1])
	
	If ll_Linhas < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da dw_4.", StopSign!)
		Return -1
	ElseIf ll_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma dado foi localizado com os par$$HEX1$$e200$$ENDHEX$$metros informados.")
		Return -1
	Else
		dw_4.Event ue_SaveAs()
	End If
	
Finally
	Close(w_Aguarde)
End Try
end event

type dw_4 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 2135
integer y = 20
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge374_planilha"
end type

