HA$PBExportHeader$w_ge121_cadastro_esteira_subcategoria.srw
forward
global type w_ge121_cadastro_esteira_subcategoria from dc_w_cadastro_freeform
end type
type st_1 from statictext within w_ge121_cadastro_esteira_subcategoria
end type
end forward

global type w_ge121_cadastro_esteira_subcategoria from dc_w_cadastro_freeform
string tag = "w_ge121_cadastro_esteira_subcategoria"
integer width = 2281
integer height = 1308
string title = "WS121 - Cadastro Esteira Subcategoria"
boolean ivb_grava_log = true
st_1 st_1
end type
global w_ge121_cadastro_esteira_subcategoria w_ge121_cadastro_esteira_subcategoria

type variables
uo_subcategoria			 	io_subcategoria	//GE022
end variables

on w_ge121_cadastro_esteira_subcategoria.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_ge121_cadastro_esteira_subcategoria.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
end on

event close;call super::close;Destroy(io_subcategoria)
end event

event open;call super::open;io_subcategoria	= Create uo_subcategoria
end event

event ue_postopen;//Overide
ivo_dbError = Create dc_uo_dbError

dw_1.Event ue_AddRow()
dw_1.SetFocus()

dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_1}
This.wf_SetUpdate_DW(lvo_Update)

//This.ivm_Menu.mf_Incluir(True)

//// Verifica CutOver Material
//If not gf_verifica_cutover('DH_CUTOVER_MATERIAL') Then 
//	dw_1.Object.qt_largura_cm_caixa_estoque.protect = 1
//	dw_1.Object.qt_altura_cm_caixa_estoque.protect = 1
//	dw_1.Object.qt_profund_cm_caixa_estoque.protect = 1
//	dw_1.Object.qt_peso_kg_estoque.protect = 1
//	dw_1.Object.dh_alteracao_dimensao_estoque.protect = 1
//	dw_1.Object.dh_alteracao_peso_estoque.protect = 1
//	dw_1.Object.qt_peso_kg_estoque_1.protect = 1
//	dw_1.Object.qt_peso_grama.protect = 1
//	dw_1.Object.qt_peso_kg_estoque.protect = 1
//	st_1.visible = True
//	st_1.text = 'Os campos de Produto n$$HEX1$$e300$$ENDHEX$$o podem mais serem alterados devido ao SAP.'
//End If 

dw_1.SetFocus()
This.ivm_Menu.mf_incluir( False)


end event

type dw_visual from dc_w_cadastro_freeform`dw_visual within w_ge121_cadastro_esteira_subcategoria
end type

type gb_aux_visual from dc_w_cadastro_freeform`gb_aux_visual within w_ge121_cadastro_esteira_subcategoria
end type

type dw_1 from dc_w_cadastro_freeform`dw_1 within w_ge121_cadastro_esteira_subcategoria
integer x = 55
integer y = 100
integer width = 2153
integer height = 948
string dataobject = "dw_ge121_cadastro_esteira"
boolean vscrollbar = false
end type

event dw_1::constructor;call super::constructor;ivs_Coluna_Sem_Validacao_Salva = {"cd_subcategoria"}

This.of_SetColSelection(True)
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()			
		Case 'de_localizacao'

			io_subcategoria.of_localiza(This.GetText(),'0','0','0')
			
			If io_subcategoria.Localizado Then
				This.Object.cd_subcategoria	[1] = io_subcategoria.cd_subcategoria
				This.Object.de_subcategoria	[1] = io_subcategoria.de_subcategoria
				This.Event ue_Retrieve()
			End If
	End Choose
End If
end event

event dw_1::ue_recuperar;// OverRide
String ls_subcategoria

dw_1.AcceptText()

ls_subcategoria = this.Object.cd_subcategoria[1] 

Return This.Retrieve(ls_subcategoria)
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;This.ivm_Menu.mf_excluir( False)
This.ivm_Menu.mf_incluir( False)

Return -1
end event

event dw_1::editchanged;//Override
If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	Parent.ivm_Menu.mf_Confirmar(False)
	Parent.ivm_Menu.mf_Cancelar(False)
End If
end event

event dw_1::itemchanged;//Overide
If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	If dwo.Name = 'cd_esteira' Then
		Parent.ivm_Menu.mf_Confirmar(True)
		Parent.ivm_Menu.mf_Cancelar(True)
		
		If ivb_UpdateAble Then
			ivw_ParentWindow.ivb_Valida_Salva = True
		End If
	End If
End If

If ivb_ddw_MultiSelecao Then
	If dwo.Name = ivs_ddw_MultiSelecao_Coluna Then
		This.of_ddw_MultiSelecao()
	End If
End If
end event

type gb_1 from dc_w_cadastro_freeform`gb_1 within w_ge121_cadastro_esteira_subcategoria
integer x = 18
integer width = 2213
integer height = 1096
integer weight = 700
string facename = "Verdana"
end type

type st_1 from statictext within w_ge121_cadastro_esteira_subcategoria
boolean visible = false
integer x = 32
integer y = 1068
integer width = 2190
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

