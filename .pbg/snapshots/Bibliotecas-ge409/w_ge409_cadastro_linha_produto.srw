HA$PBExportHeader$w_ge409_cadastro_linha_produto.srw
forward
global type w_ge409_cadastro_linha_produto from dc_w_cadastro_lista
end type
end forward

global type w_ge409_cadastro_linha_produto from dc_w_cadastro_lista
string tag = "w_ge409_cadastro_linha_produto"
integer width = 1737
integer height = 1312
string title = "GE409 - Cadastro de Linhas de Produto"
end type
global w_ge409_cadastro_linha_produto w_ge409_cadastro_linha_produto

on w_ge409_cadastro_linha_produto.create
call super::create
end on

on w_ge409_cadastro_linha_produto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preupdate;call super::ue_preupdate;If Not gf_Verifica_Cutover("DH_CUTOVER_MATCH_CODE") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ mais permitida atualiza$$HEX2$$e700e300$$ENDHEX$$o por esta tela. Utilizar o SAP.", Exclamation!)
	Return False
End If

Return True
end event

type dw_visual from dc_w_cadastro_lista`dw_visual within w_ge409_cadastro_linha_produto
end type

type gb_aux_visual from dc_w_cadastro_lista`gb_aux_visual within w_ge409_cadastro_linha_produto
end type

type dw_1 from dc_w_cadastro_lista`dw_1 within w_ge409_cadastro_linha_produto
integer width = 1545
integer height = 984
string dataobject = "dw_ge409_lista_linha_produto"
end type

type gb_1 from dc_w_cadastro_lista`gb_1 within w_ge409_cadastro_linha_produto
integer width = 1618
integer height = 1084
end type

