HA$PBExportHeader$w_ge070_consulta_pedido_completo.srw
forward
global type w_ge070_consulta_pedido_completo from dc_w_2tab_consulta_selecao_lista_det
end type
end forward

global type w_ge070_consulta_pedido_completo from dc_w_2tab_consulta_selecao_lista_det
integer width = 6811
integer height = 3000
string title = "GE070 - Consulta de Pedidos Completos"
long backcolor = 80269524
end type
global w_ge070_consulta_pedido_completo w_ge070_consulta_pedido_completo

type variables
uo_filial ivo_filial
end variables

forward prototypes
public subroutine wf_exporta_pedido ()
public subroutine wf_localiza_filial ()
end prototypes

public subroutine wf_exporta_pedido ();String lvs_Exe, &
       lvs_Parametro
		 
Long lvl_Filial

Date lvdt_Exportacao

lvs_EXE = "c:\sistemas\troca_dados_loja\exe\troca_dados_loja.exe"
	
If FileExists(lvs_EXE) Then
	lvl_Filial      = gvo_Parametro.of_Filial()
	lvdt_Exportacao = Date(gvo_Parametro.of_Dh_Movimentacao())
	
	lvs_Parametro = "P" + String(lvl_Filial, "0000") + String(lvdt_Exportacao, "dd/mm/yyyy")
	Run(lvs_EXE + " " + lvs_Parametro)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A exporta$$HEX2$$e700e300$$ENDHEX$$o dos arquivos n$$HEX1$$e300$$ENDHEX$$o pode ser efetuada.~r~r" + &
								 "O execut$$HEX1$$e100$$ENDHEX$$vel '" + lvs_EXE + "' do sistema de troca dados de loja n$$HEX1$$e300$$ENDHEX$$o foi localizado.", StopSign!)
End If
end subroutine

public subroutine wf_localiza_filial ();Integer lvi_Nulo

SetNull(lvi_Nulo)

Tab_1.TabPage_1.dw_1.AcceptText()

ivo_Filial.of_Localiza_Filial(Tab_1.TabPage_1.dw_1.GetText())

If ivo_Filial.Localizada Then
	Tab_1.TabPage_1.dw_1.Object.Cd_Filial			[1]	= ivo_Filial.Cd_Filial
	Tab_1.TabPage_1.dw_1.Object.Nm_Fantasia	[1]	= ivo_Filial.Nm_Fantasia
Else
	Tab_1.TabPage_1.dw_1.Object.Cd_Filial			[1]	= lvi_Nulo
	Tab_1.TabPage_1.dw_1.Object.Nm_Fantasia	[1]	= ""
End If
end subroutine

on w_ge070_consulta_pedido_completo.create
call super::create
end on

on w_ge070_consulta_pedido_completo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;Date lvdt_Parametro

This.ivm_Menu.ivb_Permite_Imprimir = False

lvdt_Parametro = Date(gvo_Parametro.of_Dh_Movimentacao())

Tab_1.TabPage_1.dw_1.Object.Dt_Inicio		[1] = RelativeDate(lvdt_Parametro, -1)
Tab_1.TabPage_1.dw_1.Object.Dt_Termino[1] = lvdt_Parametro


end event

event ue_preopen;call super::ue_preopen;// Determina as dimens$$HEX1$$f500$$ENDHEX$$es dos folders
// Sele$$HEX2$$e700e300$$ENDHEX$$o
ivl_Largura_1	= 4030
ivl_Altura_1		= 2000

// Detalhes
ivl_Largura_2	= 6775
ivl_Altura_2 		= 2820
end event

event open;call super::open;ivo_Filial = Create uo_Filial
end event

event close;call super::close;Destroy ivo_Filial
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge070_consulta_pedido_completo
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge070_consulta_pedido_completo
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge070_consulta_pedido_completo
integer x = 5
integer y = 4
integer width = 6738
integer height = 2788
end type

event tab_1::selectionchanging;//OverRide

SetPointer(HourGlass!)

If NewIndex = 2 Then
	If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
		// das DW's de detalhes
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

event tab_1::selectionchanged;call super::selectionchanged;If oldindex = 1 Then
	ivm_Menu.mf_Classificar(True)
	ivm_Menu.mf_Filtrar(True)
Else
	ivm_Menu.mf_Classificar(False)
	ivm_Menu.mf_Filtrar(False)
End If

ivm_Menu.mf_Localizar(False)
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 6702
integer height = 2672
end type

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer x = 14
integer y = 364
integer width = 3931
integer height = 1488
string text = "Lista de Pedidos"
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer x = 9
integer width = 2587
integer height = 344
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 32
integer width = 2528
integer height = 264
string dataobject = "dw_ge070_selecao_new"
end type

event dw_1::itemchanged;call super::itemchanged;Long lvl_Nulo

If dwo.Name = "nm_fantasia" Then
	
	SetNull(lvl_Nulo)
	
	If Data = "" Or IsNull(Data) Then
			This.Object.Cd_Filial[1] = lvl_nulo
			Return 0
		End If	
		
	If Data <> ivo_Filial.Nm_Fantasia Then Return 1
End if

dw_2.Event ue_Reset()
end event

event dw_1::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = 'nm_fantasia' Then
		
		wf_Localiza_Filial()
		
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer x = 32
integer y = 412
integer width = 3877
integer height = 1396
string dataobject = "dw_ge070_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date lvdt_Inicio
Date lvdt_Termino

Long lvl_Filial
Long ll_Pedido

String lvs_Situacao
String ls_Responsavel

Tab_1.TabPage_1.dw_1.AcceptText()

lvdt_Inicio		= Tab_1.TabPage_1.dw_1.Object.Dt_Inicio			[1]
lvdt_Termino	= Tab_1.TabPage_1.dw_1.Object.Dt_Termino		[1]
lvl_Filial			= Tab_1.TabPage_1.dw_1.Object.Cd_Filial			[1]
lvs_Situacao		= Tab_1.TabPage_1.dw_1.Object.Id_Situacao		[1]
ls_Responsavel	= Tab_1.TabPage_1.dw_1.Object.Id_Responsavel	[1]
ll_Pedido			= Tab_1.TabPage_1.dw_1.Object.Nr_Pedido		[1]

If IsNull(lvdt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	Return -1
End If

If Not IsNull(lvl_Filial) And lvl_Filial > 0 Then
	This.of_AppendWhere("p.cd_filial = " +  String(lvl_Filial))
End If

This.of_AppendWhere("p.dh_emissao >= '" + String(lvdt_Inicio, "yyyy/mm/dd") + "'")
This.of_AppendWhere("p.dh_emissao <= '" + String(lvdt_Termino, "yyyy/mm/dd") + "'")

If lvs_Situacao <> "T" Then
	This.of_AppendWhere("p.id_situacao = '" + lvs_Situacao + "'" )
End If

If ls_Responsavel <> 'T' Then
	This.of_AppendWhere("p.id_gerado_logistica = '" + ls_Responsavel + "'" )
End If

If Not IsNull(ll_Pedido) And ll_Pedido > 0 Then
	This.of_AppendWhere("p.nr_pedido_filial = " + String(ll_Pedido))
End If

Return 1
end event

event dw_2::ue_retrieve;call super::ue_retrieve;If AncestorReturnValue > 0 Then 
	This.Event RowFocusChanged(1)
	
	// Habilita o bot$$HEX1$$e300$$ENDHEX$$o imprimir
	This.ivm_Menu.mf_Classificar(False)
	This.ivm_Menu.mf_Filtrar(False)
	This.ivm_Menu.mf_Localizar(False)

End if	

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection("", "if(id_situacao = ~"X~", rgb(255,0,0), rgb(0,0,0))")
This.ivb_Ordena_Colunas = True
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 6702
integer height = 2672
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer x = 14
integer width = 6670
integer height = 2632
string text = "Produtos do Pedido"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 37
integer y = 64
integer width = 6619
integer height = 2560
string dataobject = "dw_ge070_detalhe"
boolean vscrollbar = true
end type

event dw_3::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_produto", "produto", "qt_sugerida", "qt_pedida", "qt_atendida", "qt_faturada", "qt_saldo_final", "qt_saldo_momento","vl_custo_unitario", "de_grupo", "de_subgrupo", "de_categoria", "de_subcategoria"}

lvs_Nome = {"c$$HEX1$$f300$$ENDHEX$$digo", "descri$$HEX2$$e700e300$$ENDHEX$$o", "qtd sugerida", "qtd pedida", "qtd atendida", "qtd faturada", "qtd saldo atual", "qtd saldo momento", "custo", "grupo", "subgrupo", "categoria", "subcategoria"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.of_SetRowSelection()
end event

event dw_3::ue_recuperar;// OverRide

Long lvl_Linha, &
     lvl_Filial, &
     lvl_Pedido
	  
lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Filial = Tab_1.TabPage_1.dw_2.Object.Cd_Filial       [lvl_Linha]
lvl_Pedido = Tab_1.TabPage_1.dw_2.Object.Nr_Pedido_Filial[lvl_Linha]

Return This.Retrieve(lvl_Filial, lvl_Pedido)
end event

event dw_3::getfocus;//OverRide
This.ivm_Menu.mf_Classificar(True)
This.ivm_Menu.mf_Filtrar(True)
This.ivm_Menu.mf_Localizar(False)
This.ivm_Menu.mf_Recuperar(False)
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

