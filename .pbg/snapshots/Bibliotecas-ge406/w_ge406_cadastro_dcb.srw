HA$PBExportHeader$w_ge406_cadastro_dcb.srw
forward
global type w_ge406_cadastro_dcb from dc_w_cadastro_lista
end type
end forward

global type w_ge406_cadastro_dcb from dc_w_cadastro_lista
string tag = "w_ge406_cadastro_dbc"
integer width = 1810
integer height = 1612
string title = "GE406 - Cadastro de DCB Produtos"
boolean resizable = false
end type
global w_ge406_cadastro_dcb w_ge406_cadastro_dcb

on w_ge406_cadastro_dcb.create
call super::create
end on

on w_ge406_cadastro_dcb.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preupdate;call super::ue_preupdate;If Not gf_Verifica_Cutover("DH_CUTOVER_MATCH_CODE") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ mais permitida atualiza$$HEX2$$e700e300$$ENDHEX$$o por esta tela. Utilizar o SAP.", Exclamation!)
	Return False
End If

Return True
end event

type dw_visual from dc_w_cadastro_lista`dw_visual within w_ge406_cadastro_dcb
end type

type gb_aux_visual from dc_w_cadastro_lista`gb_aux_visual within w_ge406_cadastro_dcb
end type

type dw_1 from dc_w_cadastro_lista`dw_1 within w_ge406_cadastro_dcb
integer x = 50
integer y = 48
integer width = 1678
integer height = 1340
string dataobject = "dw_ge406_lista_dcb"
end type

type gb_1 from dc_w_cadastro_lista`gb_1 within w_ge406_cadastro_dcb
integer width = 1710
integer height = 1400
end type

