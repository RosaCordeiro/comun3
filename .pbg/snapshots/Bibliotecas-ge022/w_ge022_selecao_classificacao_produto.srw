HA$PBExportHeader$w_ge022_selecao_classificacao_produto.srw
forward
global type w_ge022_selecao_classificacao_produto from dc_w_response
end type
type cb_selecionar from commandbutton within w_ge022_selecao_classificacao_produto
end type
type cb_cancelar from commandbutton within w_ge022_selecao_classificacao_produto
end type
type tv_1 from treeview within w_ge022_selecao_classificacao_produto
end type
end forward

global type w_ge022_selecao_classificacao_produto from dc_w_response
integer x = 457
integer y = 436
integer width = 2757
integer height = 1512
boolean controlmenu = false
cb_selecionar cb_selecionar
cb_cancelar cb_cancelar
tv_1 tv_1
end type
global w_ge022_selecao_classificacao_produto w_ge022_selecao_classificacao_produto

type variables
integer ivi_nivel_selecao

Private:
	dc_uo_ds_base ivds_subcategoria
	dc_uo_ds_base ivds_categoria
	dc_uo_ds_base ivds_subgrupo
	
end variables

forward prototypes
public subroutine wf_mostra_subgrupos (string as_grupo, long al_handle)
public subroutine wf_mostra_subgrupos ()
public subroutine wf_mostra_grupos ()
public subroutine wf_mostra_categorias (string as_subgrupo, long al_handle)
public subroutine wf_mostra_subcategorias (string as_categoria, long al_handle)
end prototypes

public subroutine wf_mostra_subgrupos (string as_grupo, long al_handle);Long lvl_Total, &
     lvl_Contador, &
	  lvl_Handle

String lvs_Codigo, &
       lvs_Descricao, &
       lvs_Label

ivds_subgrupo.SetFilter("cd_grupo='"+as_grupo+"'")
ivds_subgrupo.Filter()
lvl_Total = ivds_subgrupo.RowCount()

If lvl_Total > 0 Then
	For lvl_Contador = 1 To lvl_Total
		lvs_Codigo		= ivds_subgrupo.Object.Cd_SubGrupo	[lvl_Contador]
		lvs_Descricao	= ivds_subgrupo.Object.De_SubGrupo	[lvl_Contador]
		
		lvs_Label = LeftA(lvs_Codigo, 1) + "." + RightA(lvs_Codigo, 2) + " - " + lvs_Descricao
		
		If lvl_Contador = 1 Then
			lvl_Handle = tv_1.InsertItemFirst(al_Handle, lvs_Label, 2)
		Else
			lvl_Handle = tv_1.InsertItemLast(al_Handle, lvs_Label, 2)	
		End If

		If lvl_Handle > 0 Then
			If This.ivi_Nivel_Selecao >= 3 Then wf_Mostra_Categorias(lvs_Codigo, lvl_Handle)
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inser$$HEX2$$e700e300$$ENDHEX$$o do subgrupo '" + lvs_Label + "' na lista.", StopSign!)
		End If
	Next
End If
end subroutine

public subroutine wf_mostra_subgrupos ();Long lvl_Item

TreeViewItem ltvi

String lvs_Label, &
		 lvs_Grupo

lvl_Item = tv_1.FindItem(RootTreeItem!, 0)

If lvl_Item > 0 Then
	Do While lvl_Item > 0
		If tv_1.GetItem(lvl_Item, ltvi) = 1 Then
			lvs_Label = ltvi.Label
			
			lvs_Grupo = LeftA(lvs_Label, 1)
			
			wf_Mostra_SubGrupos(lvs_Grupo, lvl_Item)
			
			lvl_Item = tv_1.FindItem(NextTreeItem!, lvl_Item)
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getitem.", StopSign!)
		End If
	Loop
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem grupos cadastrados.", StopSign!)
End If
end subroutine

public subroutine wf_mostra_grupos ();Long lvl_Total, &
     lvl_Contador, &
	  lvl_Handle

String lvs_Codigo, &
       lvs_Descricao, &
       lvs_Label

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("dw_ge022_treeview_grupo") Then 
	Destroy(lvds_1)
	Return
End If

Open(w_Aguarde)
w_Aguarde.Title = "Recuperando as Classifica$$HEX2$$e700f500$$ENDHEX$$es Cadastradas..."

ivds_subcategoria.Retrieve()
ivds_categoria.Retrieve()
ivds_subgrupo.Retrieve()

lvl_Total = lvds_1.Retrieve()

If lvl_Total > 0 Then
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Contador = 1 To lvl_Total
		lvs_Codigo		= lvds_1.Object.Cd_Grupo	[lvl_Contador]
		lvs_Descricao	= lvds_1.Object.De_Grupo	[lvl_Contador]
		
		lvs_Label = lvs_Codigo + " - " + lvs_Descricao
		
		If lvl_Contador = 1 Then
			lvl_Handle = tv_1.InsertItemFirst(0, lvs_Label, 2)
		Else
			lvl_Handle = tv_1.InsertItemLast(0, lvs_Label, 2)	
		End If
		
		If lvl_Handle > 0 Then
			If This.ivi_Nivel_Selecao >= 2 Then wf_Mostra_SubGrupos(lvs_Codigo, lvl_Handle)
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inser$$HEX2$$e700e300$$ENDHEX$$o do grupo '" + lvs_Label + "' na lista.", StopSign!)
		End If
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Grupos n$$HEX1$$e300$$ENDHEX$$o localizados.", StopSign!)
End If

Close(w_Aguarde)
Destroy(lvds_1)
end subroutine

public subroutine wf_mostra_categorias (string as_subgrupo, long al_handle);Long lvl_Total, &
     lvl_Contador, &
	  lvl_Handle

String lvs_Codigo, &
       lvs_Descricao, &
       lvs_Label

ivds_categoria.SetFilter("cd_subgrupo='"+as_subgrupo+"'")
ivds_categoria.Filter()
lvl_Total = ivds_categoria.RowCount()

If lvl_Total > 0 Then
	For lvl_Contador = 1 To lvl_Total
		lvs_Codigo		= ivds_categoria.Object.Cd_Categoria[lvl_Contador]
		lvs_Descricao	= ivds_categoria.Object.De_Categoria[lvl_Contador]
		
		lvs_Label = LeftA(lvs_Codigo, 1) + "." + MidA(lvs_Codigo, 2, 2) + "." + RightA(lvs_Codigo, 3) + " - " + lvs_Descricao		
		
		If lvl_Contador = 1 Then
			lvl_Handle = tv_1.InsertItemFirst(al_Handle, lvs_Label, 2)
		Else
			lvl_Handle = tv_1.InsertItemLast(al_Handle, lvs_Label, 2)	
		End If

		If lvl_Handle > 0 Then
			If This.ivi_Nivel_Selecao = 4 Then wf_Mostra_SubCategorias(lvs_Codigo, lvl_Handle)
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inser$$HEX2$$e700e300$$ENDHEX$$o da categoria '" + lvs_Label + "' na lista.", StopSign!)
		End If
	Next
End If
end subroutine

public subroutine wf_mostra_subcategorias (string as_categoria, long al_handle);Long lvl_Total, &
     lvl_Contador, &
	  lvl_Handle

String lvs_Codigo, &
       lvs_Descricao, &
       lvs_Label

ivds_subcategoria.SetFilter("cd_categoria='"+as_Categoria+"'")
ivds_subcategoria.Filter()
lvl_Total = ivds_subcategoria.RowCount()

If lvl_Total > 0 Then
	For lvl_Contador = 1 To lvl_Total
		lvs_Codigo		= ivds_subcategoria.Object.Cd_SubCategoria[lvl_Contador]
		lvs_Descricao	= ivds_subcategoria.Object.De_SubCategoria[lvl_Contador]
		
		lvs_Label = LeftA(lvs_Codigo, 1) + "." + MidA(lvs_Codigo, 2, 2) + "." + MidA(lvs_Codigo, 4, 3) + "." + RightA(lvs_Codigo, 3) + " - " + lvs_Descricao
		
		If lvl_Contador = 1 Then
			lvl_Handle = tv_1.InsertItemFirst(al_Handle, lvs_Label, 2)
		Else
			lvl_Handle = tv_1.InsertItemLast(al_Handle, lvs_Label, 2)	
		End If

		If lvl_Handle = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inser$$HEX2$$e700e300$$ENDHEX$$o da categoria '" + lvs_Label + "' na lista.", StopSign!)
		End If
	Next
End If
end subroutine

on w_ge022_selecao_classificacao_produto.create
int iCurrent
call super::create
this.cb_selecionar=create cb_selecionar
this.cb_cancelar=create cb_cancelar
this.tv_1=create tv_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_selecionar
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.tv_1
end on

on w_ge022_selecao_classificacao_produto.destroy
call super::destroy
destroy(this.cb_selecionar)
destroy(this.cb_cancelar)
destroy(this.tv_1)
end on

event ue_postopen;call super::ue_postopen;wf_Mostra_Grupos()

tv_1.SelectItem(1)
tv_1.SetFocus()
end event

event open;call super::open;String lvs_Parametro, &
       lvs_Titulo

lvs_Parametro = Message.StringParm

lvs_Titulo = "GE022 - Sele$$HEX2$$e700e300$$ENDHEX$$o de "

Choose Case lvs_Parametro
	Case "1" ; lvs_Titulo += "Grupos de Produtos"
	Case "2" ; lvs_Titulo += "SubGrupos de Produtos"
	Case "3" ; lvs_Titulo += "Categorias de Produtos"
	Case "4" ; lvs_Titulo += "SubCategorias de Produtos"
		
	Case Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$ed00$$ENDHEX$$vel de sele$$HEX2$$e700e300$$ENDHEX$$o '" + lvs_Parametro + "' inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
		Close(This)
		Return
End Choose

This.Title = lvs_Titulo

This.ivi_Nivel_Selecao = Integer(lvs_Parametro)
end event

event ue_preopen;call super::ue_preopen;ivds_subcategoria	= Create dc_uo_ds_base
ivds_categoria		= Create dc_uo_ds_base
ivds_subgrupo		= Create dc_uo_ds_base

ivds_subcategoria.of_ChangeDataObject("ddw_ge022_treeview_subcategoria")
ivds_categoria.of_ChangeDataObject("ddw_ge022_treeview_categoria")
ivds_subgrupo.of_ChangeDataObject("ddw_ge022_treeview_subgrupo")


end event

event close;call super::close;Destroy( ivds_subcategoria )
Destroy( ivds_categoria )
Destroy( ivds_subgrupo )
end event

type pb_help from dc_w_response`pb_help within w_ge022_selecao_classificacao_produto
end type

type cb_selecionar from commandbutton within w_ge022_selecao_classificacao_produto
integer x = 2016
integer y = 1304
integer width = 379
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Selecionar"
boolean default = true
end type

event clicked;Long lvl_Item

Integer lvi_Nivel

TreeViewItem ltvi

String lvs_Label, &
		 lvs_Classificacao

lvl_Item = tv_1.FindItem(CurrentTreeItem!, 0)

If lvl_Item > 0 Then
	If tv_1.GetItem(lvl_Item, ltvi) = 1 Then
		lvs_Label = ltvi.Label
		lvi_Nivel = ltvi.Level
		
		If lvi_Nivel <> Parent.ivi_Nivel_Selecao Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O n$$HEX1$$ed00$$ENDHEX$$vel do item selecionado est$$HEX1$$e100$$ENDHEX$$ incorreto.", StopSign!)
			tv_1.SetFocus()
			Return
		End If
		
		Choose Case Parent.ivi_Nivel_Selecao
			Case 1
				lvs_Classificacao = LeftA(lvs_Label, 1)
			Case 2
				lvs_Classificacao = LeftA(lvs_Label, 1) + MidA(lvs_Label, 3, 2)
			Case 3
				lvs_Classificacao = LeftA(lvs_Label, 1) + MidA(lvs_Label, 3, 2) + MidA(lvs_Label, 6, 3)
			Case 4
				lvs_Classificacao = LeftA(lvs_Label, 1) + MidA(lvs_Label, 3, 2) + MidA(lvs_Label, 6, 3) + MidA(lvs_Label, 10, 3)
		End Choose
		
		CloseWithReturn(Parent, lvs_Classificacao)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getitem do item selecionado.", StopSign!)
		tv_1.SetFocus()
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum item est$$HEX1$$e100$$ENDHEX$$ selecionado.", StopSign!)
	tv_1.SetFocus()
End If
end event

type cb_cancelar from commandbutton within w_ge022_selecao_classificacao_produto
integer x = 2409
integer y = 1304
integer width = 306
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;String lvs_Grupo

SetNull(lvs_Grupo)

CloseWithReturn(Parent, lvs_Grupo)
end event

type tv_1 from treeview within w_ge022_selecao_classificacao_produto
integer x = 18
integer y = 16
integer width = 2693
integer height = 1264
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = styleraised!
boolean linesatroot = true
string picturename[] = {"Custom035!","Search!"}
long picturemaskcolor = 79741120
long statepicturemaskcolor = 536870912
end type

event selectionchanged;TreeViewItem ltvi

If This.GetItem(NewHandle, ltvi) = 1 Then
	ltvi.Bold = True		
	ltvi.SelectedPictureIndex = 1
	
	This.SetItem(NewHandle, ltvi)
	
	If This.GetItem(OldHandle, ltvi) = 1 Then
		ltvi.Bold = False
		
		This.SetItem(OldHandle, ltvi)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getitem para atualiza$$HEX2$$e700e300$$ENDHEX$$o da lista.", StopSign!)
End If
end event

