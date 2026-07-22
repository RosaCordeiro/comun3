HA$PBExportHeader$w_ge333_cad_marca_ecommerce.srw
forward
global type w_ge333_cad_marca_ecommerce from dc_w_cadastro_freeform
end type
end forward

global type w_ge333_cad_marca_ecommerce from dc_w_cadastro_freeform
integer width = 1998
integer height = 628
string title = "GE333 - Cadastro de Marca de E-Commerce"
end type
global w_ge333_cad_marca_ecommerce w_ge333_cad_marca_ecommerce

type variables
uo_ge199_marca_ecommerce io_Marca
end variables

forward prototypes
public function boolean wf_proximo_codigo ()
end prototypes

public function boolean wf_proximo_codigo ();Long ll_Marca, &
     ll_Proxima

Select max(cd_marca)
Into :ll_Marca
From marca_ecommerce
Using SqlCa;

If SqlCa.SqlCode = 0 Then
	If IsNull(ll_Marca) Then
		ll_Proxima = 1
	Else
		ll_Proxima = ll_Marca + 1
	End If
	
	dw_1.Object.Cd_Marca [1] = ll_Proxima
	
	Return True
Else
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo da marca produto")
	Return False
End If

Return True
end function

on w_ge333_cad_marca_ecommerce.create
call super::create
end on

on w_ge333_cad_marca_ecommerce.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy io_Marca
end event

event open;call super::open;io_Marca = Create uo_ge199_marca_ecommerce

end event

event ue_preupdate;call super::ue_preupdate;If Not gf_Verifica_Cutover("DH_CUTOVER_MATCH_CODE") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ mais permitida atualiza$$HEX2$$e700e300$$ENDHEX$$o por esta tela. Utilizar o SAP.", Exclamation!)
	Return False
End If

Return True
end event

type dw_visual from dc_w_cadastro_freeform`dw_visual within w_ge333_cad_marca_ecommerce
end type

type gb_aux_visual from dc_w_cadastro_freeform`gb_aux_visual within w_ge333_cad_marca_ecommerce
end type

type dw_1 from dc_w_cadastro_freeform`dw_1 within w_ge333_cad_marca_ecommerce
integer x = 64
integer width = 1829
integer height = 296
string dataobject = "dw_ge333_marca_ecommerce"
boolean vscrollbar = false
end type

event dw_1::constructor;call super::constructor;This.ivs_Coluna_Sem_Validacao_Salva = {"de_localizacao"}

This.of_SetColSelection(True)
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	If This.GetColumnName() = "de_localizacao" Then
		
			io_Marca.of_Localiza_Marca_Ecommerce(This.GetText())
			
			If io_Marca.Localizada Then
				This.Event ue_Reset()
				This.Event ue_Retrieve()
			End If
			
	End If
	
End If
end event

event dw_1::ue_recuperar;//Override

Return This.Retrieve(io_Marca.Cd_Marca)
end event

event dw_1::ue_preupdate;call super::ue_preupdate;Long ll_Marca
String ls_Descricao

dw_1.AcceptText()

If dw_1.RowCount() > 0 Then

	ll_Marca 			= dw_1.Object.cd_marca[1]
	ls_Descricao 	= dw_1.Object.de_marca[1]
	
	If IsNull(ls_Descricao) Or Trim(ls_Descricao) = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a descri$$HEX2$$e700e300$$ENDHEX$$o da marca")
		dw_1.Event ue_Pos(1, "de_marca")
		Return -1
	End If
	
	If IsNull(ll_Marca) Then
		If Not wf_Proximo_Codigo() Then Return -1
	End If
	
End If

Return 1
end event

event dw_1::ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	io_Marca.of_Inicializa()
End If

Return AncestorReturnValue
end event

event dw_1::editchanged;call super::editchanged;ivm_Menu.mf_Excluir(False)
end event

event dw_1::ue_cancel;call super::ue_cancel;ivm_Menu.mf_Excluir(False)
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;ivm_Menu.mf_Excluir(False)

Return pl_Linhas
end event

type gb_1 from dc_w_cadastro_freeform`gb_1 within w_ge333_cad_marca_ecommerce
integer width = 1897
integer height = 408
end type

