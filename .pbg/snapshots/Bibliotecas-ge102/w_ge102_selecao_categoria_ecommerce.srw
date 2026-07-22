HA$PBExportHeader$w_ge102_selecao_categoria_ecommerce.srw
forward
global type w_ge102_selecao_categoria_ecommerce from dc_w_response
end type
type gb_1 from groupbox within w_ge102_selecao_categoria_ecommerce
end type
type tv_1 from treeview within w_ge102_selecao_categoria_ecommerce
end type
type cb_selecionar from commandbutton within w_ge102_selecao_categoria_ecommerce
end type
type cb_cancelar from commandbutton within w_ge102_selecao_categoria_ecommerce
end type
end forward

global type w_ge102_selecao_categoria_ecommerce from dc_w_response
integer width = 2619
integer height = 1532
string title = "GE102 - Sele$$HEX2$$e700e300$$ENDHEX$$o das Categorias do eCommerce"
long backcolor = 80269524
gb_1 gb_1
tv_1 tv_1
cb_selecionar cb_selecionar
cb_cancelar cb_cancelar
end type
global w_ge102_selecao_categoria_ecommerce w_ge102_selecao_categoria_ecommerce

type variables
long ivl_handle,&
        ivl_categoria

integer ivi_level

string ivs_label,&
         ivs_retorno

boolean ivb_children


end variables

forward prototypes
public subroutine wf_carrega_categorias (long al_categoria, long al_handle)
public subroutine wf_carrega_categorias ()
public function boolean wf_valida_categoria ()
end prototypes

public subroutine wf_carrega_categorias (long al_categoria, long al_handle);Long lvl_Total, &
     lvl_Contador, &
	 lvl_Handle,&
	 lvl_Categoria

String lvs_Descricao, &
       lvs_Label

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("dw_ge102_categoria_ecommerce_filhas") Then 
	Destroy(lvds_1)
	Return
End If

lvl_Total = lvds_1.Retrieve(al_Categoria)


If lvl_Total > 0 Then
	For lvl_Contador = 1 To lvl_Total
		lvl_Categoria = lvds_1.Object.cd_categoria[lvl_Contador]
		lvs_Descricao = lvds_1.Object.de_categoria[lvl_Contador]
		
		lvs_Label = String(lvl_Categoria, '000') + " - " + lvs_Descricao
		
		If lvl_Contador = 1 Then
			lvl_Handle = tv_1.InsertItemFirst(al_Handle, lvs_Label, 2)
		Else
			lvl_Handle = tv_1.InsertItemLast(al_Handle, lvs_Label, 2)	
		End If

		If lvl_Handle > 0 Then
			wf_Carrega_Categorias(lvl_Categoria, lvl_Handle)
		Else	
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inser$$HEX2$$e700e300$$ENDHEX$$o da categoria '" + lvs_Label + "' na lista.", StopSign!)
		End If
	Next
End If

Destroy(lvds_1)
end subroutine

public subroutine wf_carrega_categorias ();Long lvl_Total, &
     lvl_Contador, &
	 lvl_Handle,&
	 lvl_Categoria

String lvs_Descricao, &
       lvs_Label

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("dw_ge102_categoria_ecommerce") Then 
	Destroy(lvds_1)
	Return
End If

Open(w_Aguarde)
w_Aguarde.Title = "Recuperando as Categorias do Ecommerce..."

lvl_Total = lvds_1.Retrieve(0)

If lvl_Total > 0 Then
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)	
	
	tv_1.SetRedraw(False)
	
	For lvl_Contador = 1 To lvl_Total
		lvl_Categoria = lvds_1.Object.cd_categoria[lvl_Contador]
		lvs_Descricao = lvds_1.Object.de_categoria[lvl_Contador]
		
		lvs_Label = String(lvl_Categoria, "000") + " - " + lvs_Descricao
		
		If lvl_Contador = 1 Then
			lvl_Handle = tv_1.InsertItemFirst(0, lvs_Label, 2)
		Else
			lvl_Handle = tv_1.InsertItemLast(0, lvs_Label, 2)	
		End If
		
		If lvl_Handle > 0 Then
			wf_Carrega_Categorias(lvl_Categoria, lvl_Handle)
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

public function boolean wf_valida_categoria ();Long lvl_Categoria,&
	 lvl_Categoria_Pai

lvl_Categoria = Long(MidA(ivs_Retorno, 1, 3))
	
Select cd_categoria_pai
Into :lvl_Categoria_Pai
From categoria_ecommerce
Where cd_categoria = :lvl_Categoria
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If lvl_Categoria_Pai = 0 and gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> 'EC' Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitida a sele$$HEX2$$e700e300$$ENDHEX$$o de uma categoria do n$$HEX1$$ed00$$ENDHEX$$vel zero.")
			Return False
		End If
	Case 100
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da categoria do eCommerce")
		Return False
End Choose	

Return True
end function

on w_ge102_selecao_categoria_ecommerce.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.tv_1=create tv_1
this.cb_selecionar=create cb_selecionar
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.tv_1
this.Control[iCurrent+3]=this.cb_selecionar
this.Control[iCurrent+4]=this.cb_cancelar
end on

on w_ge102_selecao_categoria_ecommerce.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.tv_1)
destroy(this.cb_selecionar)
destroy(this.cb_cancelar)
end on

event ue_postopen;call super::ue_postopen;wf_Carrega_Categorias()
end event

event close;call super::close;//CloseWithReturn(This, ivs_Retorno)
end event

type pb_help from dc_w_response`pb_help within w_ge102_selecao_categoria_ecommerce
end type

type gb_1 from groupbox within w_ge102_selecao_categoria_ecommerce
integer x = 32
integer y = 12
integer width = 2144
integer height = 1408
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Categorias"
borderstyle borderstyle = styleraised!
end type

type tv_1 from treeview within w_ge102_selecao_categoria_ecommerce
integer x = 78
integer y = 88
integer width = 2053
integer height = 1304
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string picturename[] = {"Custom035!","Search!"}
long picturemaskcolor = 553648127
long statepicturemaskcolor = 536870912
end type

event selectionchanged;TreeViewItem ltvi

If This.GetItem(NewHandle, ltvi) = 1 Then
	ivl_Handle   = NewHandle
	ivi_Level    = ltvi.Level
	ivs_Label    = ltvi.Label	
	ivb_Children = ltvi.Children
	
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

type cb_selecionar from commandbutton within w_ge102_selecao_categoria_ecommerce
integer x = 2208
integer y = 36
integer width = 375
integer height = 100
integer taborder = 30
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

event clicked;TreeViewItem ltvi

Long lvl_Categoria,&
	 lvl_Pai

If tv_1.GetItem(ivl_Handle, ltvi) = 1 Then
	
	ivs_Retorno = ltvi.Label

	// Valida para n$$HEX1$$e300$$ENDHEX$$o deixar selecionar uma categoria pai. Exemplo: MEDICAMENTOS
	If wf_Valida_Categoria() Then
		CloseWithReturn(Parent, ivs_Retorno)	
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo da categoria.", StopSign!)
End If




end event

type cb_cancelar from commandbutton within w_ge102_selecao_categoria_ecommerce
integer x = 2208
integer y = 156
integer width = 375
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar "
end type

event clicked;String lvs_Retorno

SetNull(lvs_Retorno)

CloseWithReturn(Parent, lvs_Retorno)
end event

