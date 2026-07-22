HA$PBExportHeader$w_ge426_cadastro_dimensao_peso.srw
forward
global type w_ge426_cadastro_dimensao_peso from dc_w_cadastro_freeform
end type
end forward

global type w_ge426_cadastro_dimensao_peso from dc_w_cadastro_freeform
integer width = 1925
integer height = 816
string title = "GE426 - Cadastro de Produto: Dimens$$HEX1$$e300$$ENDHEX$$o e Peso"
long backcolor = 80269524
end type
global w_ge426_cadastro_dimensao_peso w_ge426_cadastro_dimensao_peso

type variables
uo_produto ivo_produto
end variables

forward prototypes
public function boolean wf_salva_pendente ()
end prototypes

public function boolean wf_salva_pendente ();Long lvl_Modificado

dw_1.AcceptText()

lvl_Modificado = dw_1.ModifiedCount() + dw_1.DeletedCount()
							 
If lvl_Modificado > 0 Then
	Return True
Else
	Return False
End If


end function

on w_ge426_cadastro_dimensao_peso.create
call super::create
end on

on w_ge426_cadastro_dimensao_peso.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;//Override

ivo_dbError = Create dc_uo_dbError

dw_1.Event ue_AddRow()
dw_1.SetFocus()

dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_1}
This.wf_SetUpdate_DW(lvo_Update)

ivo_Produto = Create uo_Produto
end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_dbError)
end event

type dw_visual from dc_w_cadastro_freeform`dw_visual within w_ge426_cadastro_dimensao_peso
end type

type gb_aux_visual from dc_w_cadastro_freeform`gb_aux_visual within w_ge426_cadastro_dimensao_peso
end type

type dw_1 from dc_w_cadastro_freeform`dw_1 within w_ge426_cadastro_dimensao_peso
integer x = 41
integer y = 64
integer width = 1801
integer height = 528
string dataobject = "dw_ge426_cadastro_dimensao_peso"
boolean vscrollbar = false
boolean livescroll = false
end type

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
		
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = "de_localizacao" Then
				
		ivo_Produto.of_Localiza_Produto(This.GetText())
		
		If ivo_Produto.Localizado Then
			This.SetRedraw(False)
			
			This.Object.De_Localizacao	[1] = ivo_Produto.De_Produto
			This.Object.Cd_Produto		[1] = ivo_Produto.Cd_Produto
			This.Event ue_Retrieve()
			
			This.SetRedraw(True)
		End If

	End If
	
End If
end event

event dw_1::ue_preretrieve;call super::ue_preretrieve;Long lvl_Produto

lvl_Produto = This.Object.Cd_Produto[1]

If Not IsNull(lvl_Produto) and lvl_Produto <> 0 Then
	This.of_AppendWhere("cd_produto = " + String(lvl_Produto))
	Return 1
End If

Return -1



end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)

This.ivs_Coluna_Sem_Validacao_Salva = {"de_localizacao"}
end event

event dw_1::ue_postretrieve;//Override

If pl_Linhas > 0 Then
	
	This.SetRow(1)
	This.SetFocus()
	This.Event ue_Pos(1,"qt_altura_cm")
	
	This.ivi_Tipo_Cancelar = RETRIEVE
ElseIf pl_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
End If

Parent.ivm_Menu.mf_Confirmar(False)
Parent.ivm_Menu.mf_Cancelar(False)

Return pl_Linhas
end event

event dw_1::ue_preupdate;call super::ue_preupdate;Decimal	lvdc_Altura, &
			lvdc_Largura, &
			lvdc_Profundidade, &
			lvdc_Peso

dw_1.AcceptText()

lvdc_Altura			= This.Object.qt_altura_cm[1]
lvdc_Largura		= This.Object.qt_largura_cm[1]
lvdc_Profundidade	= This.Object.qt_profundidade_cm[1]
lvdc_Peso			= This.Object.qt_peso_grama[1]


// Verifica CutOver Material
If not gf_verifica_cutover('DH_CUTOVER_MATERIAL') Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ mais permitida atualiza$$HEX2$$e700e300$$ENDHEX$$o do produto por esta tela! Utilizar o SAP")
	dw_1.SetFocus()
	Return - 1
End If 


If IsNull(lvdc_Altura) or lvdc_Altura = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a altura correntamente.")
	This.Event ue_Pos(1,"qt_altura_cm")
	Return -1
End If 

If IsNull(lvdc_Largura) or lvdc_Largura = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a largura correntamente.")
	This.Event ue_Pos(1,"qt_largura_cm")
	Return -1
End If 

If IsNull(lvdc_Profundidade) or lvdc_Profundidade = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a profundidade correntamente.")
	This.Event ue_Pos(1,"qt_profundidade_cm")
	Return -1
End If 

If IsNull(lvdc_Peso) or lvdc_Peso = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o peso correntamente.")
	This.Event ue_Pos(1,"qt_peso_grama")
	Return -1
End If 

Return 1
end event

type gb_1 from dc_w_cadastro_freeform`gb_1 within w_ge426_cadastro_dimensao_peso
integer x = 23
integer y = 4
integer width = 1838
integer height = 604
integer taborder = 20
end type

