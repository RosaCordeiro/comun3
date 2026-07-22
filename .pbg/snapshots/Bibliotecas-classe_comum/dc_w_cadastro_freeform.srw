HA$PBExportHeader$dc_w_cadastro_freeform.srw
forward
global type dc_w_cadastro_freeform from dc_w_sheet
end type
type dw_1 from dc_uo_dw_base within dc_w_cadastro_freeform
end type
type gb_1 from groupbox within dc_w_cadastro_freeform
end type
end forward

global type dc_w_cadastro_freeform from dc_w_sheet
integer width = 2565
dw_1 dw_1
gb_1 gb_1
end type
global dc_w_cadastro_freeform dc_w_cadastro_freeform

type variables

end variables

forward prototypes
public subroutine wf_set_somente_consulta ()
end prototypes

public subroutine wf_set_somente_consulta ();dw_1.of_set_somente_leitura(This.ivm_Menu.ivb_permite_alterar)
end subroutine

on dc_w_cadastro_freeform.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.gb_1
end on

on dc_w_cadastro_freeform.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()
dw_1.SetFocus()

dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_1}
This.wf_SetUpdate_DW(lvo_Update)

This.ivm_Menu.mf_Incluir(True)
//This.ivm_Menu.mf_Recuperar(True)
end event

event ue_cancel;call super::ue_cancel;dw_1.Event ue_Cancel()
end event

event ue_historico;call super::ue_historico;String lvs_Tabelas, lvs_PK, lvs_Chave

If This.wf_informacoes_historico( ref lvs_Tabelas, ref lvs_PK, ref lvs_Chave) Then
	gvo_aplicacao.ivo_historico.of_exibe_log( lvs_Tabelas, "", lvs_Chave)
End If
end event

type dw_visual from dc_w_sheet`dw_visual within dc_w_cadastro_freeform
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within dc_w_cadastro_freeform
end type

type dw_1 from dc_uo_dw_base within dc_w_cadastro_freeform
event ue_habilita_historico ( )
integer x = 82
integer y = 88
integer width = 2158
integer height = 1156
boolean bringtotop = true
boolean vscrollbar = true
end type

event ue_habilita_historico();If Parent.ivb_grava_log Then This.ivm_Menu.mf_historico( This.RowCount() > 0 )

end event

event constructor;call super::constructor;ivi_Tipo_Cancelar = ADDROW
end event

event editchanged;call super::editchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	Parent.ivm_Menu.mf_Confirmar(True)
	Parent.ivm_Menu.mf_Cancelar(True)
End If
end event

event itemchanged;call super::itemchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	Parent.ivm_Menu.mf_Confirmar(True)
	Parent.ivm_Menu.mf_Cancelar(True)
End If
end event

event ue_postretrieve;call super::ue_postretrieve;Boolean lvb_Ok = False

If pl_Linhas > 0 Then
	lvb_Ok = True
	
	This.SetRow(1)
	This.SetFocus()
	
	This.ivi_Tipo_Cancelar = RETRIEVE
ElseIf pl_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
End If

Parent.ivm_Menu.mf_Excluir(lvb_Ok)

Parent.ivm_Menu.mf_Confirmar(False)
Parent.ivm_Menu.mf_Cancelar(False)

Return pl_Linhas
end event

event ue_preinsertrow;call super::ue_preinsertrow;If Parent.wf_Valida_Salva() > 0 Then
	This.Reset()
	Return 1
Else
	Return -1
End If
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	This.ivi_Tipo_Cancelar = ADDROW
	Parent.ivm_Menu.mf_Excluir(False)
	
	Parent.ivm_Menu.mf_Confirmar(False)
	Parent.ivm_Menu.mf_Cancelar(False)
End If

Return AncestorReturnValue
end event

event ue_preretrieve;call super::ue_preretrieve;If Parent.wf_Valida_Salva() > 0 Then
	Return 1
Else
	Return -1
End If
end event

event ue_deleterow;call super::ue_deleterow;Integer lvi_Retorno

If AncestorReturnValue Then
	ivi_Tipo_Cancelar = ADDROW
	lvi_Retorno = Parent.Event ue_Save()
	
	If lvi_Retorno > 0 Then
		This.Event ue_Cancel()
	Else
		This.Reset()
		This.Event ue_AddRow()
	End If
End If

Return AncestorReturnValue
end event

event ue_reset;call super::ue_reset;Parent.ivm_Menu.mf_historico( False )
end event

event ue_retrieve;call super::ue_retrieve;This.Post Event ue_habilita_historico()

Return AncestorReturnValue
end event

type gb_1 from groupbox within dc_w_cadastro_freeform
integer x = 37
integer y = 12
integer width = 2254
integer height = 1276
integer taborder = 10
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

