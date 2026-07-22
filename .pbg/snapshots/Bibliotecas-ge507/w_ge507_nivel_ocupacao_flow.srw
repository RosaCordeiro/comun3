HA$PBExportHeader$w_ge507_nivel_ocupacao_flow.srw
forward
global type w_ge507_nivel_ocupacao_flow from dc_w_2tab_consulta_selecao_lista_det
end type
end forward

global type w_ge507_nivel_ocupacao_flow from dc_w_2tab_consulta_selecao_lista_det
integer width = 3291
integer height = 1952
string title = "GE507 - Ocupa$$HEX2$$e700e300$$ENDHEX$$o dos Endere$$HEX1$$e700$$ENDHEX$$os - Flow Rack"
end type
global w_ge507_nivel_ocupacao_flow w_ge507_nivel_ocupacao_flow

type variables
dc_uo_dw_base dw_1, dw_2, dw_3

uo_produto io_produto
end variables

forward prototypes
public subroutine wf_rua_default ()
public subroutine wf_lista_rua (integer ai_esteira)
end prototypes

public subroutine wf_rua_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        	lvi_Row

If dw_1.GetChild("cd_rua", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_rua", "")
	lvdwc.SetItem(1, "de_rua", "TODAS")
	
	dw_1.Object.cd_rua[1] = ""
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da rua.")
End If
end subroutine

public subroutine wf_lista_rua (integer ai_esteira);DataWindowChild lvdwc

String ls_SQL
	
If dw_1.GetChild("cd_rua", lvdwc) = 1 Then
	
	lvdwc.SetTransObject(SQLCA)
	
	ls_SQL = " select a.cd_rua, space(5)+a.cd_rua as de_rua from wms_endereco a inner " +&
				 " join wms_endereco_produto b on b.cd_endereco = a.cd_endereco " +& 
				 " where a.cd_esteira = " + string(ai_esteira) + " "+&
				 " group by a.cd_rua order by a.cd_rua "
	
	lvdwc.SetSQLSelect(ls_SQL)
	
	//ls_teste = lvdwc.GetSQLSelect ( )
		
	lvdwc.Retrieve()
	wf_Rua_Default()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild ruas.")
End If
end subroutine

on w_ge507_nivel_ocupacao_flow.create
call super::create
end on

on w_ge507_nivel_ocupacao_flow.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;io_Produto = Create uo_produto

This.ivl_Altura_1  = This.Height
This.ivl_Largura_1 = This.Width

ivl_Largura_1 = 2710
ivl_Altura_1  = 1220

ivl_Largura_2 = 3255
ivl_Altura_2  = 1772

//MaxHeight = 9999
//MaxWidth = 9999

dw_1 = Tab_1.TabPage_1.dw_1
dw_2 = Tab_1.TabPage_1.dw_2
dw_3 = Tab_1.TabPage_2.dw_3
end event

event close;call super::close;Destroy(io_Produto)
end event

event ue_postopen;call super::ue_postopen;wf_Rua_Default()
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge507_nivel_ocupacao_flow
integer x = 37
integer y = 992
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge507_nivel_ocupacao_flow
integer x = 0
integer y = 920
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge507_nivel_ocupacao_flow
integer y = 4
integer width = 3195
integer height = 1724
end type

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 3159
integer height = 1608
end type

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 284
integer width = 2597
integer height = 780
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 1934
integer height = 272
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer width = 1851
integer height = 164
string dataobject = "dw_ge507_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			
			io_Produto.of_Localiza_Produto(This.GetText())
						
			If io_Produto.Localizado Then				
				This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
				This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque				
			Else
				io_Produto.of_Inicializa()
			End If
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
			
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
			This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
		
	Case "cd_esteira"
		
		wf_lista_Rua(Integer(data))
End Choose
end event

event dw_1::editchanged;call super::editchanged;Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
			
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
			This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
End Choose
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer y = 356
integer width = 2528
integer height = 672
string dataobject = "dw_ge507_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long ll_Esteira
Long ll_Produto

String ls_Rua

dw_1.AcceptText()

ll_Esteira		= dw_1.Object.Cd_Esteira	[1]
ls_Rua		= dw_1.Object.Cd_Rua		[1]
ll_Produto	= dw_1.Object.Cd_Produto	[1]

If ll_Esteira > 0 Then
	This.of_AppendWhere_SubQuery("e.cd_esteira = " + String(ll_Esteira), 3)
End If

If Not IsNull(ls_Rua) and ls_Rua <> "" Then
	This.of_Appendwhere_Subquery("e.cd_rua = '" + ls_Rua + "'", 3)
End If

If ll_Produto > 0 Then
	This.of_Appendwhere_Subquery("p.cd_produto = " + String(ll_Produto), 3)
End If

Return 1
end event

event dw_2::ue_recuperar;//OverRide

Date ldt_Saldo

ldt_Saldo = gf_Primeiro_Dia_Mes(Date(gf_GetServerDate()))

Return This.Retrieve(ldt_Saldo)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 3159
integer height = 1608
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 3104
integer height = 1580
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 55
integer width = 3035
integer height = 1484
string dataobject = "dw_ge507_detalhe"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_3::ue_recuperar;//OverRide

dw_1.AcceptText()

Return This.Retrieve(dw_2.Object.Cd_Esteira[dw_2.GetRow()])
end event

event dw_3::constructor;call super::constructor;This.ivb_Ordena_Colunas = True

This.of_SetRowSelection()
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_3::ue_preretrieve;call super::ue_preretrieve;Long ll_Esteira
Long ll_Produto

String ls_Rua

dw_1.AcceptText()

ll_Esteira		= dw_1.Object.Cd_Esteira	[1]
ls_Rua		= dw_1.Object.Cd_Rua		[1]
ll_Produto	= dw_1.Object.Cd_Produto	[1]

If ll_Esteira > 0 Then
	This.of_AppendWhere_SubQuery("e.cd_esteira = " + String(ll_Esteira), 5)
End If

If Not IsNull(ls_Rua) and ls_Rua <> "" Then
	This.of_Appendwhere_Subquery("e.cd_rua = '" + ls_Rua + "'", 5)
End If

If ll_Produto > 0 Then
	This.of_Appendwhere_Subquery("p.cd_produto = " + String(ll_Produto), 5)
End If

Return 1
end event

