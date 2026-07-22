HA$PBExportHeader$w_ge431_rel_falta_faturado_distribuidora.srw
forward
global type w_ge431_rel_falta_faturado_distribuidora from dc_w_2tab_consulta_selecao_lista_det
end type
type tabpage_3 from userobject within tab_1
end type
type gb_4 from groupbox within tabpage_3
end type
type dw_4 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_4 gb_4
dw_4 dw_4
end type
end forward

global type w_ge431_rel_falta_faturado_distribuidora from dc_w_2tab_consulta_selecao_lista_det
integer width = 2802
integer height = 1644
string title = "GE431 - Produtos Atendidos n$$HEX1$$e300$$ENDHEX$$o Faturados"
end type
global w_ge431_rel_falta_faturado_distribuidora w_ge431_rel_falta_faturado_distribuidora

type variables
uo_usuario ivo_usuario
end variables

forward prototypes
public subroutine wf_insere_distribuidora_default ()
public subroutine wf_insere_uf_default ()
end prototypes

public subroutine wf_insere_distribuidora_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row
												
If Tab_1.TabPage_1.dw_1.GetChild("cd_distribuidora", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_fornecedor", "000000000")
	lvdwc.SetItem(1, "nm_fantasia",   "TODAS")
	
	Tab_1.TabPage_1.dw_1.Object.Cd_Distribuidora[1] = "000000000"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da distribuidora.")
End If
end subroutine

public subroutine wf_insere_uf_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If This.Tab_1.TabPage_1.dw_1.GetChild("cd_uf", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_unidade_federacao", "00")
	lvdwc.SetItem(1, "nm_unidade_federacao",   "TODOS")
	
	This.Tab_1.TabPage_1.dw_1.Object.cd_uf[1] = "00"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da UF.")
End If
end subroutine

on w_ge431_rel_falta_faturado_distribuidora.create
int iCurrent
call super::create
end on

on w_ge431_rel_falta_faturado_distribuidora.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;Date lvdt_Base

lvdt_Base = RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), -1)

Tab_1.TabPage_1.dw_1.Object.Dt_Inicio 	[1] = lvdt_Base
Tab_1.TabPage_1.dw_1.Object.Dt_Fim		[1] = lvdt_Base

Tab_1.TabPage_1.dw_1.SetFocus()

wf_insere_distribuidora_default()

wf_insere_uf_default()



end event

event close;call super::close;Destroy(ivo_Usuario)
end event

event open;call super::open;ivo_Usuario    		= Create uo_Usuario
end event

event resize;call super::resize;This.Tab_1.TabPage_1.gb_2.Width  = NewWidth - 211
This.Tab_1.TabPage_1.gb_2.Height = NewHeight - 596

This.Tab_1.TabPage_1.dw_2.Width = NewWidth - 265
This.Tab_1.TabPage_1.dw_2.Height = NewHeight - 688

This.Tab_1.Width = NewWidth - 19
This.Tab_1.Height = NewHeight - 20

This.Tab_1.TabPage_2.gb_3.Width  = NewWidth - 92
This.Tab_1.TabPage_2.gb_3.Height = NewHeight - 176

This.Tab_1.TabPage_2.dw_3.Width = NewWidth - 151
This.Tab_1.TabPage_2.dw_3.Height = NewHeight - 252

This.Tab_1.TabPage_3.gb_4.Width  = NewWidth - 517
This.Tab_1.TabPage_3.gb_4.Height = NewHeight - 172

This.Tab_1.TabPage_3.dw_4.Width = NewWidth - 576
This.Tab_1.TabPage_3.dw_4.Height = NewHeight - 268
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge431_rel_falta_faturado_distribuidora
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge431_rel_falta_faturado_distribuidora
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge431_rel_falta_faturado_distribuidora
integer x = 9
integer width = 2747
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_3=create tabpage_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_3
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_3)
end on

event tab_1::selectionchanged;//OverRide

Choose Case NewIndex
	Case 1  
		Tab_1.TabPage_1.dw_2.SetFocus()
		If Tab_1.TabPage_1.dw_2.RowCount() > 0 Then
			ivm_Menu.mf_SalvarComo(True)
		End If	
	Case 2  
		Tab_1.TabPage_2.dw_3.SetFocus()
		ivm_Menu.mf_SalvarComo(True)
	Case 3 
		Tab_1.TabPage_3.dw_4.SetFocus()
		ivm_Menu.mf_SalvarComo(True)
		
End Choose

ivm_Menu.mf_excluir( False)
ivm_Menu.mf_incluir( False)
end event

event tab_1::selectionchanging;//OverRider

Long lvl_Linha


Choose Case OldIndex
	Case 1	
		If Tab_1.TabPage_1.dw_2.GetRow() = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma Distribuidora na lista para visualizar os detalhes.")
			Return 1
		End If	
		
		If NewIndex = 3 and Tab_1.TabPage_2.dw_3.GetRow() = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um Produto na lista para visualizar os pedidos.")
			Return 1
		End If	
		
	Case 2
		If NewIndex = 3 and Tab_1.TabPage_2.dw_3.GetRow() = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um Produto na lista para visualizar os pedidos.")
			Return 1
		End If		
End Choose

Choose Case NewIndex
	Case 1
		Tab_1.TabPage_2.dw_3.Event ue_Reset()
		Tab_1.TabPage_3.dw_4.Event ue_Reset()
	Case 2
		If OldIndex = 1 Then		  
			Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
		End If  
		Tab_1.TabPage_3.dw_4.Event ue_Reset()
	Case 3	
		Tab_1.TabPage_3.dw_4.Event ue_Retrieve()
End Choose

end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 2711
string text = "Distribuidoras"
end type

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 448
integer width = 2555
integer height = 868
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 1842
integer height = 428
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 73
integer width = 1774
integer height = 328
string dataobject = "dw_ge431_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then

	If This.GetColumnName() = "nm_usuario" Then
		ivo_Usuario.of_Localiza_Usuario(This.GetText())
		
		If ivo_Usuario.Localizado Then
			This.Object.nr_matricula[1] = ivo_Usuario.nr_matricula
			This.Object.nm_usuario  [1] = ivo_Usuario.nm_usuario
		End If
	End If
		
End If
end event

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "nm_usuario" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Usuario.nm_usuario Then
			Return 1
		End If
	Else
		ivo_Usuario.of_Inicializa()
		
		This.Object.nr_matricula[1] = ivo_Usuario.nr_matricula
		This.Object.nm_usuario  [1] = ivo_Usuario.nm_usuario
	End If
End If

end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer x = 64
integer y = 528
integer width = 2501
integer height = 776
string dataobject = "dw_ge431_lista_fornecedor"
boolean hscrollbar = true
end type

event dw_2::ue_postretrieve;//OverRide
Boolean lvb_Habilita

If pl_Linhas > 0 Then
	lvb_Habilita = True
	This.SetRow(1)
	This.SetFocus()	
Else
	lvb_Habilita = False
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma distribuidora localizada.", Information!)
	End If
End If

ivm_Menu.mf_SalvarComo(lvb_Habilita)



Return pl_Linhas
end event

event dw_2::ue_recuperar;// Override

Date 	lvdt_Inicio, &
     	lvdt_Fim

String 	lvs_Distribuidora, &
			lvs_UF, &
			lvl_Comprador

dw_1.AcceptText()

lvdt_Inicio  	  		= dw_1.Object.Dt_Inicio 		[1]
lvdt_Fim 				= dw_1.Object.Dt_Fim		[1]
lvs_Distribuidora 	= dw_1.Object.cd_distribuidora[1]
lvs_UF				= dw_1.Object.cd_uf[1]
lvl_Comprador		= dw_1.Object.nr_matricula[1]

If lvs_Distribuidora <>"000000000" Then
	This.of_AppendWhere("a.cd_distribuidora = '" + lvs_Distribuidora + "'", 1)
End If	

If lvs_UF <>"00" Then
	This.of_AppendWhere("d.cd_unidade_federacao = '" + lvs_UF + "'", 1)
End If	

If lvl_Comprador <>"" Then
	This.of_AppendWhere("c.nr_matricula_comprador = '" + lvl_Comprador + "'", 1)
End If	


This.of_SetRowSelection()

Return This.Retrieve(lvdt_Inicio, lvdt_Fim)
end event

event dw_2::getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 2711
string text = "Produtos"
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 2674
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 69
integer width = 2615
integer height = 1212
string dataobject = "dw_ge431_lista_produto"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_3::ue_postretrieve;//OverRide


ivm_Menu.mf_SalvarComo(True)



Return pl_Linhas
end event

event dw_3::ue_recuperar;// Override

Date 	lvdt_Inicio, &
     	lvdt_Fim

String lvs_Distribuidora

Tab_1.TabPage_1.dw_1.AcceptText()

lvdt_Inicio  	  		= Tab_1.TabPage_1.dw_1.Object.Dt_Inicio 		[1]
lvdt_Fim 				= Tab_1.TabPage_1.dw_1.Object.Dt_Fim		[1]
lvs_Distribuidora 	= Tab_1.TabPage_1.dw_2.Object.cd_fornecedor[Tab_1.TabPage_1.dw_2.GetRow()]
	

This.of_SetRowSelection()

Return This.Retrieve(lvs_Distribuidora, lvdt_Inicio, lvdt_Fim)
end event

event dw_3::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2711
integer height = 1328
long backcolor = 67108864
string text = "Pedidos"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
gb_4 gb_4
dw_4 dw_4
end type

on tabpage_3.create
this.gb_4=create gb_4
this.dw_4=create dw_4
this.Control[]={this.gb_4,&
this.dw_4}
end on

on tabpage_3.destroy
destroy(this.gb_4)
destroy(this.dw_4)
end on

type gb_4 from groupbox within tabpage_3
integer x = 23
integer y = 12
integer width = 2249
integer height = 1292
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
end type

type dw_4 from dc_uo_dw_base within tabpage_3
integer x = 69
integer y = 96
integer width = 2190
integer height = 1196
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge431_lista_pedido"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_recuperar;// Override

Date 	lvdt_Inicio, &
     	lvdt_Fim

String lvs_Distribuidora

Long ll_Produto

Tab_1.TabPage_1.dw_1.AcceptText()

lvdt_Inicio  	  		= Tab_1.TabPage_1.dw_1.Object.Dt_Inicio 		[1]
lvdt_Fim 				= Tab_1.TabPage_1.dw_1.Object.Dt_Fim		[1]
lvs_Distribuidora 	= Tab_1.TabPage_1.dw_2.Object.cd_fornecedor[Tab_1.TabPage_1.dw_2.GetRow()]
ll_Produto   			= Tab_1.TabPage_2.dw_3.Object.cd_produto[Tab_1.TabPage_2.dw_3.GetRow()]

This.of_SetRowSelection()

Return This.Retrieve(lvs_Distribuidora, ll_Produto, lvdt_Inicio, lvdt_Fim)
end event

event constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

