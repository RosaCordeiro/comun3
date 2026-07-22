HA$PBExportHeader$w_ge121_cadastro_classificacao_produto.srw
forward
global type w_ge121_cadastro_classificacao_produto from dc_w_sheet
end type
type tv_1 from treeview within w_ge121_cadastro_classificacao_produto
end type
type dw_1 from dc_uo_dw_base within w_ge121_cadastro_classificacao_produto
end type
type gb_selecao from groupbox within w_ge121_cadastro_classificacao_produto
end type
type gb_cadastro from groupbox within w_ge121_cadastro_classificacao_produto
end type
end forward

global type w_ge121_cadastro_classificacao_produto from dc_w_sheet
integer width = 3639
integer height = 1672
string title = "GE121 - Cadastro de Classifica$$HEX2$$e700f500$$ENDHEX$$es de Produtos"
event ue_addrow ( )
event ue_deleterow ( )
tv_1 tv_1
dw_1 dw_1
gb_selecao gb_selecao
gb_cadastro gb_cadastro
end type
global w_ge121_cadastro_classificacao_produto w_ge121_cadastro_classificacao_produto

type variables
long ivl_handle

integer ivi_level

string ivs_label, &
         ivs_operacao

boolean ivb_children, &
             ivb_inclusao_mesmo_nivel = true


end variables

forward prototypes
public subroutine wf_mostra_subcategorias (string as_categoria, long al_handle)
public subroutine wf_mostra_categorias (string as_subgrupo, long al_handle)
public subroutine wf_mostra_subgrupos (string as_grupo, long al_handle)
public subroutine wf_mostra_grupos ()
public function boolean wf_valida_grupo ()
public function boolean wf_ultimo_grupo (ref long al_codigo)
public function boolean wf_ultimo_subgrupo (string as_grupo, ref long al_codigo)
public function boolean wf_valida_subgrupo ()
public function boolean wf_ultima_categoria (string as_subgrupo, ref long al_codigo)
public function boolean wf_valida_categoria ()
public function boolean wf_ultima_subcategoria (string as_categoria, ref long al_codigo)
public function boolean wf_valida_subcategoria ()
public subroutine wf_limpa_lista ()
end prototypes

event ue_addrow;dw_1.Event ue_AddRow()
end event

event ue_deleterow;dw_1.Event ue_DeleteRow()
end event

public subroutine wf_mostra_subcategorias (string as_categoria, long al_handle);Long lvl_Total, &
     lvl_Contador, &
	  lvl_Handle

String lvs_Codigo, &
       lvs_Descricao, &
       lvs_Label

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("dw_ge022_treeview_subcategoria") Then 
	Destroy(lvds_1)
	Return
End If

lvl_Total = lvds_1.Retrieve(as_Categoria)

If lvl_Total > 0 Then
	For lvl_Contador = 1 To lvl_Total
		lvs_Codigo    = lvds_1.Object.Cd_SubCategoria[lvl_Contador]
		lvs_Descricao = lvds_1.Object.De_SubCategoria[lvl_Contador]
		
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

Destroy(lvds_1)
end subroutine

public subroutine wf_mostra_categorias (string as_subgrupo, long al_handle);Long lvl_Total, &
     lvl_Contador, &
	  lvl_Handle

String lvs_Codigo, &
       lvs_Descricao, &
       lvs_Label

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("dw_ge022_treeview_categoria") Then 
	Destroy(lvds_1)
	Return
End If

lvl_Total = lvds_1.Retrieve(as_SubGrupo)

If lvl_Total > 0 Then
	For lvl_Contador = 1 To lvl_Total
		lvs_Codigo    = lvds_1.Object.Cd_Categoria[lvl_Contador]
		lvs_Descricao = lvds_1.Object.De_Categoria[lvl_Contador]
		
		lvs_Label = LeftA(lvs_Codigo, 1) + "." + MidA(lvs_Codigo, 2, 2) + "." + RightA(lvs_Codigo, 3) + " - " + lvs_Descricao
		
		If lvl_Contador = 1 Then
			lvl_Handle = tv_1.InsertItemFirst(al_Handle, lvs_Label, 2)
		Else
			lvl_Handle = tv_1.InsertItemLast(al_Handle, lvs_Label, 2)	
		End If

		If lvl_Handle > 0 Then
			wf_Mostra_SubCategorias(lvs_Codigo, lvl_Handle)
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inser$$HEX2$$e700e300$$ENDHEX$$o da categoria '" + lvs_Label + "' na lista.", StopSign!)
		End If
	Next
End If

Destroy(lvds_1)
end subroutine

public subroutine wf_mostra_subgrupos (string as_grupo, long al_handle);Long lvl_Total, &
     lvl_Contador, &
	  lvl_Handle

String lvs_Codigo, &
       lvs_Descricao, &
       lvs_Label

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("dw_ge022_treeview_subgrupo") Then 
	Destroy(lvds_1)
	Return
End If

lvl_Total = lvds_1.Retrieve(as_Grupo)

If lvl_Total > 0 Then
	For lvl_Contador = 1 To lvl_Total
		lvs_Codigo    = lvds_1.Object.Cd_SubGrupo[lvl_Contador]
		lvs_Descricao = lvds_1.Object.De_SubGrupo[lvl_Contador]
		
		lvs_Label = LeftA(lvs_Codigo, 1) + "." + RightA(lvs_Codigo, 2) + " - " + lvs_Descricao
		
		If lvl_Contador = 1 Then
			lvl_Handle = tv_1.InsertItemFirst(al_Handle, lvs_Label, 2)
		Else
			lvl_Handle = tv_1.InsertItemLast(al_Handle, lvs_Label, 2)	
		End If

		If lvl_Handle > 0 Then
			wf_Mostra_Categorias(lvs_Codigo, lvl_Handle)
		Else	
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inser$$HEX2$$e700e300$$ENDHEX$$o do subgrupo '" + lvs_Label + "' na lista.", StopSign!)
		End If
	Next
End If

Destroy(lvds_1)
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

lvl_Total = lvds_1.Retrieve()

If lvl_Total > 0 Then
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)	
	tv_1.SetRedraw(False)
	
	For lvl_Contador = 1 To lvl_Total
		lvs_Codigo    = lvds_1.Object.Cd_Grupo[lvl_Contador]
		lvs_Descricao = lvds_1.Object.De_Grupo[lvl_Contador]
		
		lvs_Label = lvs_Codigo + " - " + lvs_Descricao
		
		If lvl_Contador = 1 Then
			lvl_Handle = tv_1.InsertItemFirst(0, lvs_Label, 2)
		Else
			lvl_Handle = tv_1.InsertItemLast(0, lvs_Label, 2)	
		End If
		
		If lvl_Handle > 0 Then
			wf_Mostra_SubGrupos(lvs_Codigo, lvl_Handle)
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inser$$HEX2$$e700e300$$ENDHEX$$o do grupo '" + lvs_Label + "' na lista.", StopSign!)
		End If
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
	
	tv_1.SetRedraw(True)
	
	tv_1.SelectItem(1)
	tv_1.SetFocus()
	
	lvl_Handle = tv_1.FindItem(RootTreeItem!, 0)
	
	tv_1.CollapseItem(lvl_Handle)
End If

Close(w_Aguarde)
Destroy(lvds_1)
end subroutine

public function boolean wf_valida_grupo ();Long lvl_Ultimo_Codigo, &
     lvl_Linha

If wf_Ultimo_Grupo(ref lvl_Ultimo_Codigo) Then
	For lvl_Linha = 1 To dw_1.RowCount()
		If IsNull(dw_1.Object.De_Grupo[lvl_Linha]) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a descri$$HEX2$$e700e300$$ENDHEX$$o do grupo.", Information!)
			dw_1.Event ue_Pos(lvl_Linha, "de_grupo")
			Return False
		End If
		
		If IsNull(dw_1.Object.Cd_Grupo[lvl_Linha]) Then
			lvl_Ultimo_Codigo ++
			
			dw_1.Object.Cd_Grupo[lvl_Linha] = String(lvl_Ultimo_Codigo)
		End If
	Next

	Return True
Else
	Return False
End If
end function

public function boolean wf_ultimo_grupo (ref long al_codigo);Boolean lvb_Sucesso = True

String lvs_Codigo

Select max(cd_grupo) Into :lvs_Codigo
From grupo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(lvs_Codigo) Then
			al_Codigo = 0
		Else
			al_Codigo = Long(lvs_Codigo)
		End If
	Case 100
		al_Codigo = 0
	Case -1
		SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o do $$HEX1$$da00$$ENDHEX$$ltimo C$$HEX1$$f300$$ENDHEX$$digo")
		lvb_Sucesso = False
End Choose

Return lvb_Sucesso
end function

public function boolean wf_ultimo_subgrupo (string as_grupo, ref long al_codigo);Boolean lvb_Sucesso = True

String lvs_Codigo

Select max(cd_subgrupo) Into :lvs_Codigo
From subgrupo
Where cd_grupo = :as_Grupo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(lvs_Codigo) Then
			al_Codigo = 0
		Else
			al_Codigo = Long(lvs_Codigo)
		End If
	Case 100
		al_Codigo = 0
	Case -1
		SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o do $$HEX1$$da00$$ENDHEX$$ltimo C$$HEX1$$f300$$ENDHEX$$digo")
		lvb_Sucesso = False
End Choose

Return lvb_Sucesso
end function

public function boolean wf_valida_subgrupo ();Long lvl_Linha, &
     lvl_Ultimo_Codigo

String lvs_Grupo

lvs_Grupo = dw_1.Object.Cd_Grupo[1]

If Not wf_Ultimo_SubGrupo(lvs_Grupo, ref lvl_Ultimo_Codigo) Then Return False

If lvl_Ultimo_Codigo = 0 Then
	lvl_Ultimo_Codigo = Long(lvs_Grupo + "00")
End If

For lvl_Linha = 1 To dw_1.RowCount()
	If IsNull(dw_1.Object.De_SubGrupo[lvl_Linha]) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a descri$$HEX2$$e700e300$$ENDHEX$$o do subgrupo.", Information!)
		dw_1.Event ue_Pos(lvl_Linha, "de_subgrupo")
		Return False
	End If
	
	If IsNull(dw_1.Object.Cd_SubGrupo[lvl_Linha]) Then
		lvl_Ultimo_Codigo ++
		
		dw_1.Object.Cd_SubGrupo[lvl_Linha] = String(lvl_Ultimo_Codigo)
	End If
Next

Return True
end function

public function boolean wf_ultima_categoria (string as_subgrupo, ref long al_codigo);Boolean lvb_Sucesso = True

String lvs_Codigo

Select max(cd_categoria) Into :lvs_Codigo
From categoria
Where cd_subgrupo = :as_SubGrupo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(lvs_Codigo) Then
			al_Codigo = 0
		Else
			al_Codigo = Long(lvs_Codigo)
		End If
	Case 100
		al_Codigo = 0
	Case -1
		SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o do $$HEX1$$da00$$ENDHEX$$ltimo C$$HEX1$$f300$$ENDHEX$$digo")
		lvb_Sucesso = False
End Choose

Return lvb_Sucesso
end function

public function boolean wf_valida_categoria ();Long lvl_Linha, &
     lvl_Ultimo_Codigo

String lvs_SubGrupo

lvs_SubGrupo = dw_1.Object.Cd_SubGrupo[1]

If Not wf_Ultima_Categoria(lvs_SubGrupo, ref lvl_Ultimo_Codigo) Then Return False

If lvl_Ultimo_Codigo = 0 Then
	lvl_Ultimo_Codigo = Long(lvs_SubGrupo + "000")
End If

For lvl_Linha = 1 To dw_1.RowCount()
	If IsNull(dw_1.Object.De_Categoria[lvl_Linha]) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a descri$$HEX2$$e700e300$$ENDHEX$$o da categoria.", Information!)
		dw_1.Event ue_Pos(lvl_Linha, "de_categoria")
		Return False
	End If
	
	If IsNull(dw_1.Object.Cd_Categoria[lvl_Linha]) Then
		lvl_Ultimo_Codigo ++
		
		dw_1.Object.Cd_Categoria[lvl_Linha] = String(lvl_Ultimo_Codigo)
	End If
Next

Return True
end function

public function boolean wf_ultima_subcategoria (string as_categoria, ref long al_codigo);Boolean lvb_Sucesso = True

String lvs_Codigo

Select max(cd_subcategoria) Into :lvs_Codigo
From subcategoria
Where cd_categoria = :as_Categoria
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(lvs_Codigo) Then
			al_Codigo = 0
		Else
			al_Codigo = Long(lvs_Codigo)
		End If
	Case 100
		al_Codigo = 0
	Case -1
		SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o do $$HEX1$$da00$$ENDHEX$$ltimo C$$HEX1$$f300$$ENDHEX$$digo")
		lvb_Sucesso = False
End Choose

Return lvb_Sucesso
end function

public function boolean wf_valida_subcategoria ();Long lvl_Linha, &
     lvl_Ultimo_Codigo

String lvs_Categoria

lvs_Categoria = dw_1.Object.Cd_Categoria[1]

If Not wf_Ultima_SubCategoria(lvs_Categoria, ref lvl_Ultimo_Codigo) Then Return False

If lvl_Ultimo_Codigo = 0 Then
	lvl_Ultimo_Codigo = Long(lvs_Categoria + "000")
End If

For lvl_Linha = 1 To dw_1.RowCount()
	If IsNull(dw_1.Object.De_SubCategoria[lvl_Linha]) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a descri$$HEX2$$e700e300$$ENDHEX$$o da subcategoria.", Information!)
		dw_1.Event ue_Pos(lvl_Linha, "de_subcategoria")
		Return False
	End If
	
	If IsNull(dw_1.Object.Cd_SubCategoria[lvl_Linha]) Then
		lvl_Ultimo_Codigo ++
		
		dw_1.Object.Cd_SubCategoria[lvl_Linha] = String(lvl_Ultimo_Codigo)
	End If
Next

Return True
end function

public subroutine wf_limpa_lista ();Long lvl_Handle

tv_1.SetRedraw(False)

lvl_Handle = tv_1.FindItem(RootTreeItem!, 0)

Do While lvl_Handle > 0
	tv_1.DeleteItem(lvl_Handle)
	
	lvl_Handle = tv_1.FindItem(RootTreeItem!, 0)
Loop

tv_1.SetRedraw(True)
end subroutine

on w_ge121_cadastro_classificacao_produto.create
int iCurrent
call super::create
this.tv_1=create tv_1
this.dw_1=create dw_1
this.gb_selecao=create gb_selecao
this.gb_cadastro=create gb_cadastro
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.gb_selecao
this.Control[iCurrent+4]=this.gb_cadastro
end on

on w_ge121_cadastro_classificacao_produto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tv_1)
destroy(this.dw_1)
destroy(this.gb_selecao)
destroy(this.gb_cadastro)
end on

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_1}
This.wf_SetUpdate_DW(lvo_Update)

This.ivm_Menu.mf_Incluir(True)
This.ivm_Menu.mf_Excluir(True)

wf_Mostra_Grupos()
end event

event ue_preupdate;call super::ue_preupdate;Boolean lvb_Sucesso = True

Integer lvi_Nivel

// Verifica se a linha n$$HEX1$$e300$$ENDHEX$$o foi exclu$$HEX1$$ed00$$ENDHEX$$da
If dw_1.RowCount() > 0 Then
	lvi_Nivel = ivi_Level
	
	If ivs_Operacao = "I" and Not ivb_Inclusao_Mesmo_Nivel Then
		lvi_Nivel ++
	End If
	
	Choose Case lvi_Nivel
		Case 0, 1 ; lvb_Sucesso = wf_Valida_Grupo()
		Case 2    ; lvb_Sucesso = wf_Valida_SubGrupo()
		Case 3    ; lvb_Sucesso = wf_Valida_Categoria()
		Case 4    ; lvb_Sucesso = wf_Valida_SubCategoria()
	End Choose
End If

Return lvb_Sucesso
end event

event ue_save;call super::ue_save;Long lvl_Handle

String lvs_Codigo, &
       lvs_Descricao

Integer lvi_Nivel

TreeViewItem ltvi

If AncestorReturnValue = 1 Then
	// Atualiza a TreeView ap$$HEX1$$f300$$ENDHEX$$s a atualiza$$HEX2$$e700e300$$ENDHEX$$o da base de dados
	lvi_Nivel = ivi_Level
	
	If ivs_Operacao = "I" and Not ivb_Inclusao_Mesmo_Nivel Then
		lvi_Nivel ++
	End If
	
	Choose Case ivs_Operacao
		Case "I", "A"
			Choose Case lvi_Nivel
				Case 0, 1
					lvs_Codigo    = dw_1.Object.Cd_Grupo[1]
					lvs_Descricao = dw_1.Object.De_Grupo[1]
					
				Case 2
					lvs_Codigo    = dw_1.Object.Cd_SubGrupo[1]
					lvs_Descricao = dw_1.Object.De_SubGrupo[1]
					
					lvs_Codigo = LeftA(lvs_Codigo, 1) + "." + RightA(lvs_Codigo, 2)
				Case 3
					lvs_Codigo    = dw_1.Object.Cd_Categoria[1]
					lvs_Descricao = dw_1.Object.De_Categoria[1]
					
					lvs_Codigo = LeftA(lvs_Codigo, 1) + "." + MidA(lvs_Codigo, 2, 2) + "." + RightA(lvs_Codigo, 3)
				Case 4
					lvs_Codigo    = dw_1.Object.Cd_SubCategoria[1]
					lvs_Descricao = dw_1.Object.De_SubCategoria[1]
					
					lvs_Codigo = LeftA(lvs_Codigo, 1) + "." + MidA(lvs_Codigo, 2, 2) + "." + MidA(lvs_Codigo, 4, 3) + "." + RightA(lvs_Codigo, 3)
			End Choose

			If ivs_Operacao = "I" Then
				If ivi_Level = 0 or ivi_Level = 1 Then
					If ivb_Inclusao_Mesmo_Nivel Then
						lvl_Handle = tv_1.InsertItemLast(0, lvs_Codigo + " - " + lvs_Descricao, 4)	
					Else
						lvl_Handle = tv_1.InsertItemLast(ivl_Handle, lvs_Codigo + " - " + lvs_Descricao, 4)	
					End If
				Else
					If ivb_Inclusao_Mesmo_Nivel Then
						lvl_Handle = tv_1.FindItem(ParentTreeItem!, ivl_Handle)
						
						If lvl_Handle > 0 Then
							lvl_Handle = tv_1.InsertItemLast(lvl_Handle, lvs_Codigo + " - " + lvs_Descricao, 4)	
						Else
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do item na lista.", StopSign!)
						End If
					Else
						lvl_Handle = tv_1.InsertItemLast(ivl_Handle, lvs_Codigo + " - " + lvs_Descricao, 4)	
					End If
				End If
	
				If lvl_Handle = -1 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do item na lista.", StopSign!)
				Else
					tv_1.SelectItem(lvl_Handle)
				End If
			Else
				If tv_1.GetItem(ivl_Handle, ltvi) = 1 Then
					ltvi.Label = lvs_Codigo + " - " + lvs_Descricao
					
					If tv_1.SetItem(ivl_Handle, ltvi) = -1 Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no setitem para atualiza$$HEX2$$e700e300$$ENDHEX$$o da lista.", StopSign!)
					End If
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getitem para atualiza$$HEX2$$e700e300$$ENDHEX$$o da lista.", StopSign!)
				End If
			End If
			
		Case "E"
			If tv_1.DeleteItem(ivl_Handle) = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do item para atualiza$$HEX2$$e700e300$$ENDHEX$$o da lista.", StopSign!)
			End If
	End Choose
	
	//wf_Limpa_Lista()
	//wf_Mostra_Grupos()
	
	//This.ivm_Menu.mf_Excluir(True)
End If

Return AncestorReturnValue
end event

event ue_cancel;call super::ue_cancel;wf_Limpa_Lista()
wf_Mostra_Grupos()

This.ivm_Menu.mf_Excluir(True)
This.ivm_Menu.mf_Confirmar(False)
This.ivm_Menu.mf_Cancelar(False)
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge121_cadastro_classificacao_produto
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge121_cadastro_classificacao_produto
end type

type tv_1 from treeview within w_ge121_cadastro_classificacao_produto
integer x = 50
integer y = 68
integer width = 1806
integer height = 1372
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean linesatroot = true
string picturename[] = {"Custom035!","Search!"}
long picturemaskcolor = 79741120
long statepicturemaskcolor = 536870912
end type

event selectionchanged;TreeViewItem ltvi

If This.GetItem(NewHandle, ltvi) = 1 Then
	ivl_Handle   = NewHandle
	ivi_Level    = ltvi.Level
	ivs_Label    = ltvi.Label	
	ivb_Children = ltvi.Children
	
	dw_1.Event ue_Retrieve()
	
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

event selectionchanging;If wf_Valida_Salva() <= 0 Then
	Return 1
Else
	Parent.ivm_Menu.mf_Excluir(True)
	Parent.ivm_Menu.mf_Confirmar(False)
	Parent.ivm_Menu.mf_Cancelar(False)	
	
	Return 0
End If
end event

type dw_1 from dc_uo_dw_base within w_ge121_cadastro_classificacao_produto
integer x = 1938
integer y = 64
integer width = 1605
integer height = 1396
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge121_cadastro_subgrupo"
end type

event ue_recuperar;// Override
Long lvl_Retorno = -1

String lvs_Classificacao, &
		 lvs_DW

This.SetRedraw(False)

Choose Case ivi_Level
	Case 1
		lvs_DW = "dw_ge121_cadastro_grupo"
		lvs_Classificacao = LeftA(ivs_Label, 1)				
	Case 2
		lvs_DW = "dw_ge121_cadastro_subgrupo"
		lvs_Classificacao = LeftA(ivs_Label, 1) + MidA(ivs_Label, 3, 2)
	Case 3
		lvs_DW = "dw_ge121_cadastro_categoria"
		lvs_Classificacao = LeftA(ivs_Label, 1) + MidA(ivs_Label, 3, 2) + MidA(ivs_Label, 6, 3)
	Case 4
		lvs_DW = "dw_ge121_cadastro_subcategoria"
		lvs_Classificacao = LeftA(ivs_Label, 1) + MidA(ivs_Label, 3, 2) + MidA(ivs_Label, 6, 3) + MidA(ivs_Label, 10, 3)
End Choose

If This.of_ChangeDataObject(lvs_DW) Then		
	lvl_Retorno = This.Retrieve(lvs_Classificacao)
End If

This.SetRedraw(True)

Return lvl_Retorno
end event

event editchanged;call super::editchanged;Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)
end event

event itemchanged;call super::itemchanged;Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)
end event

event ue_preinsertrow;call super::ue_preinsertrow;String lvs_Mensagem, &
       lvs_DW

If wf_Valida_Salva() <= 0 Then
	Return -1
Else
	ivb_Inclusao_Mesmo_Nivel = True
	
	If ivi_Level = 0 Then
		If Not This.of_ChangeDataObject("dw_ge121_cadastro_grupo") Then		
			Return -1
		End If
	Else	
		If ivi_Level < 4 and Not ivb_Children Then
			Choose Case ivi_Level
				Case 1 
					lvs_Mensagem = "O grupo selecionado n$$HEX1$$e300$$ENDHEX$$o possui subgrupos cadastrados.~r~r" + &
										"Deseja incluir um subgrupo agora ?"
										
					lvs_DW = "dw_ge121_cadastro_subgrupo"
				Case 2
					lvs_Mensagem = "O subgrupo selecionado n$$HEX1$$e300$$ENDHEX$$o possui categorias cadastradas.~r~r" + &
										"Deseja incluir uma categoria agora ?"
					
					lvs_DW = "dw_ge121_cadastro_categoria"
				Case 3
					lvs_Mensagem = "A categoria selecionada n$$HEX1$$e300$$ENDHEX$$o possui subcategorias cadastradas.~r~r" + &
										"Deseja incluir uma subcategoria agora ?"
					
					lvs_DW = "dw_ge121_cadastro_subcategoria"
			End Choose
			
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem, Question!, YesNo!, 2) = 1 Then
				If Not This.of_ChangeDataObject(lvs_DW) Then		
					Return -1
				End If
				
				ivb_Inclusao_Mesmo_Nivel = False
			End If
		End If
	End If
	
	This.Reset()
	Return 1
End If
end event

event ue_addrow;call super::ue_addrow;Long lvl_Handle

Integer lvi_Nivel

String lvs_Label, &
       lvs_Codigo, &
       lvs_Descricao

TreeViewItem ltvi		 
		 
If AncestorReturnValue > 0 Then
	ivs_Operacao = "I"
	
	lvl_Handle = ivl_Handle
	lvi_Nivel  = ivi_Level
	
	If Not ivb_Inclusao_Mesmo_Nivel Then
		lvi_Nivel ++
	End If
	
	Do While lvi_Nivel > 1
		If lvi_Nivel <= ivi_Level Then
			lvl_Handle = tv_1.FindItem(ParentTreeItem!, lvl_Handle)
		End If
		
		If lvl_Handle > 0 Then
			If tv_1.GetItem(lvl_Handle, ltvi) = 1 Then
				lvs_Label = ltvi.Label
				
				Choose Case lvi_Nivel
					Case 4
						lvs_Codigo    = LeftA(lvs_Label, 1) + MidA(lvs_Label, 3, 2) + MidA(lvs_Label, 6, 3)
						lvs_Descricao = MidA(lvs_Label, 12)
						
						This.Object.Cd_Categoria[1] = lvs_Codigo
						This.Object.De_Categoria[1] = lvs_Descricao
						
					Case 3
						lvs_Codigo    = LeftA(lvs_Label, 1) + MidA(lvs_Label, 3, 2)
						lvs_Descricao = MidA(lvs_Label, 8)
						
						This.Object.Cd_SubGrupo[1] = lvs_Codigo
						This.Object.De_SubGrupo[1] = lvs_Descricao
						
					Case 2
						lvs_Codigo    = LeftA(lvs_Label, 1)
						lvs_Descricao = MidA(lvs_Label, 5)
						
						This.Object.Cd_Grupo[1] = lvs_Codigo
						This.Object.De_Grupo[1] = lvs_Descricao
						
				End Choose
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos dados do n$$HEX1$$ed00$$ENDHEX$$vel superior para inclus$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
			End If
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do n$$HEX1$$ed00$$ENDHEX$$vel superior para inclus$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
		End If
		
		lvi_Nivel --
	Loop
End If

Return AncestorReturnValue
end event

event ue_deleterow;call super::ue_deleterow;If AncestorReturnValue Then
	ivs_Operacao = "E"
	Parent.Event ue_Save()
End If

Return AncestorReturnValue
end event

event ue_postretrieve;If pl_Linhas > 0 Then
	ivs_Operacao = "A"
End If

Return pl_Linhas
end event

type gb_selecao from groupbox within w_ge121_cadastro_classificacao_produto
integer x = 18
integer width = 1870
integer height = 1468
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o das Classifica$$HEX2$$e700f500$$ENDHEX$$es"
borderstyle borderstyle = styleraised!
end type

type gb_cadastro from groupbox within w_ge121_cadastro_classificacao_produto
integer x = 1915
integer width = 1650
integer height = 1476
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Cadastro das Classifica$$HEX2$$e700f500$$ENDHEX$$es"
borderstyle borderstyle = styleraised!
end type

