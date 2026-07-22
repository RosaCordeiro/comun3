HA$PBExportHeader$w_ge664_cadastro_nfe_sem_pedido.srw
forward
global type w_ge664_cadastro_nfe_sem_pedido from dc_w_cadastro_freeform
end type
end forward

global type w_ge664_cadastro_nfe_sem_pedido from dc_w_cadastro_freeform
string tag = "w_ge664_cadastro_nfe_sem_pedido"
integer width = 2249
integer height = 1120
string title = "GE664 - NFE sem Pedido"
end type
global w_ge664_cadastro_nfe_sem_pedido w_ge664_cadastro_nfe_sem_pedido

on w_ge664_cadastro_nfe_sem_pedido.create
call super::create
end on

on w_ge664_cadastro_nfe_sem_pedido.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;dw_1.of_SetMenu (This.ivm_Menu)
end event

event ue_postopen;call super::ue_postopen;String	ls_Matricula 

//ivm_Menu.ivb_Permite_Excluir = False
//ivm_Menu.ivb_Permite_Incluir = False
ivm_Menu.mf_incluir (False)
ivm_Menu.mf_excluir (False)

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento ('W_GE664_CADASTRO_NFE_SEM_PEDIDO', Ref ls_Matricula) then
	Post Close (This)
	Return	
End if
end event

event ue_presave;call super::ue_presave;Long	ll_Pedido

If dw_1.AcceptText () < 0 then
	Return False
End if

ll_Pedido = dw_1.Object.nr_pedido [1]

If IsNull (ll_Pedido) or ll_Pedido = 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe o n$$HEX1$$fa00$$ENDHEX$$mero do pedido!', Exclamation!)
	dw_1.Event ue_Pos (1, 'nr_pedido')
	Return False
End if

dw_1.Object.dh_registro_pedido           [1] = gf_GetServerDate ()
dw_1.Object.nr_matricula_registro_pedido [1] = gvo_aplicacao.ivo_Seguranca.nr_matricula
dw_1.Object.nm_usuario                   [1] = gvo_aplicacao.ivo_Seguranca.nm_usuario

Return True
end event

type dw_visual from dc_w_cadastro_freeform`dw_visual within w_ge664_cadastro_nfe_sem_pedido
integer y = 796
end type

type gb_aux_visual from dc_w_cadastro_freeform`gb_aux_visual within w_ge664_cadastro_nfe_sem_pedido
integer y = 724
end type

type dw_1 from dc_w_cadastro_freeform`dw_1 within w_ge664_cadastro_nfe_sem_pedido
integer width = 2053
integer height = 768
string dataobject = "dw_ge664_chave_acesso"
boolean vscrollbar = false
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection (True)
This.ivs_Coluna_Sem_Validacao_Salva = {'localizacao'}
end event

event dw_1::ue_key;call super::ue_key;String	ls_Coluna

ls_Coluna = This.GetColumnName ()

If Key = KeyEnter! then
	Choose case ls_Coluna
		Case 'localizacao'
			This.SetRedraw (False)
			This.Event ue_Retrieve ()
			This.SetRedraw (True)
	End choose
End if
end event

event dw_1::ue_recuperar;//Override

Integer	li_Linhas
String	ls_Chave_Acesso

If This.AcceptText () < 0 then
	Return -1
End if

ls_Chave_Acesso = This.Object.localizacao [1]

li_Linhas = This.Retrieve (ls_Chave_Acesso)

If li_Linhas = 0 then
	this.Post Event ue_addrow ()
else
	If IsNull (This.Object.dh_importacao_nfe [1]) then
		This.Object.nr_pedido.Protect = 0
		this.Post SetColumn ('nr_pedido')
	else
		This.Object.nr_pedido.Protect = 1
	End if
End if

Return li_Linhas
end event

type gb_1 from dc_w_cadastro_freeform`gb_1 within w_ge664_cadastro_nfe_sem_pedido
integer width = 2149
integer height = 888
integer taborder = 0
end type

