HA$PBExportHeader$dc_w_cadastro_lista.srw
forward
global type dc_w_cadastro_lista from dc_w_sheet
end type
type dw_1 from dc_uo_dw_base within dc_w_cadastro_lista
end type
type gb_1 from groupbox within dc_w_cadastro_lista
end type
end forward

global type dc_w_cadastro_lista from dc_w_sheet
integer width = 2427
integer height = 1512
dw_1 dw_1
gb_1 gb_1
end type
global dc_w_cadastro_lista dc_w_cadastro_lista

forward prototypes
public subroutine wf_set_somente_consulta ()
end prototypes

public subroutine wf_set_somente_consulta ();dw_1.of_set_somente_leitura(This.ivm_Menu.ivb_permite_alterar)
end subroutine

on dc_w_cadastro_lista.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.gb_1
end on

on dc_w_cadastro_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;This.ivm_Menu.mf_Incluir(True)
This.ivm_Menu.mf_Recuperar(True)

dw_1.Event ue_Retrieve()
dw_1.SetFocus()

dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_1}
This.wf_SetUpdate_DW(lvo_Update)
end event

event ue_cancel;call super::ue_cancel;dw_1.Event ue_Cancel()
end event

type dw_1 from dc_uo_dw_base within dc_w_cadastro_lista
integer x = 82
integer y = 88
integer width = 2158
integer height = 1156
boolean bringtotop = true
boolean vscrollbar = true
end type

event ue_postretrieve;Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Excluir

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	lvb_Excluir = True

	This.SetRow(1)
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

Parent.ivm_Menu.mf_Classificar(lvb_Classificar)
Parent.ivm_Menu.mf_Filtrar(lvb_Filtrar)
Parent.ivm_Menu.mf_Localizar(lvb_Localizar)
Parent.ivm_Menu.mf_Excluir(lvb_Excluir)

Return pl_Linhas
end event

event editchanged;call super::editchanged;Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)

end event

event itemchanged;call super::itemchanged;Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)
end event

event constructor;call super::constructor;ivi_Tipo_Cancelar = RETRIEVE

//ivb_Selecao_Linhas = True

This.of_SetRowSelection()
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	Parent.ivm_Menu.mf_Excluir(True)
End If

Return AncestorReturnValue
end event

type gb_1 from groupbox within dc_w_cadastro_lista
integer x = 37
integer y = 12
integer width = 2254
integer height = 1276
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

