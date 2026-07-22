HA$PBExportHeader$w_ge210_consulta_pbm.srw
forward
global type w_ge210_consulta_pbm from w_ge210_cadastro_pbm
end type
end forward

global type w_ge210_consulta_pbm from w_ge210_cadastro_pbm
string tag = "w_ge210_consulta_pbm"
string title = "GE210 - Consulta de PBM e Produtos"
end type
global w_ge210_consulta_pbm w_ge210_consulta_pbm

on w_ge210_consulta_pbm.create
call super::create
end on

on w_ge210_consulta_pbm.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;
dw_1.ivo_Controle_Menu.of_Incluir(False)
dw_1.ivm_menu.mf_Confirmar(False)
dw_1.ivm_Menu.mf_Cancelar(False)		
dw_1.ivo_Controle_Menu.of_Excluir(False)
dw_1.ivm_Menu.mf_excluir(False)


dw_2.ivo_Controle_Menu.of_Incluir(False)
dw_2.ivm_menu.mf_Confirmar(False)
dw_2.ivm_Menu.mf_Cancelar(False)		
dw_2.ivo_Controle_Menu.of_Excluir(False)
dw_2.ivm_Menu.mf_excluir(False)
end event

type dw_visual from w_ge210_cadastro_pbm`dw_visual within w_ge210_consulta_pbm
end type

type gb_aux_visual from w_ge210_cadastro_pbm`gb_aux_visual within w_ge210_consulta_pbm
end type

type dw_1 from w_ge210_cadastro_pbm`dw_1 within w_ge210_consulta_pbm
end type

event dw_1::ue_postretrieve;call super::ue_postretrieve;dw_1.ivo_Controle_Menu.of_Incluir(False)
dw_1.ivm_menu.mf_Confirmar(False)
dw_1.ivm_Menu.mf_Cancelar(False)		
dw_1.ivo_Controle_Menu.of_Excluir(False)
dw_1.ivm_Menu.mf_excluir(False)

Return 1
end event

type gb_1 from w_ge210_cadastro_pbm`gb_1 within w_ge210_consulta_pbm
end type

type dw_2 from w_ge210_cadastro_pbm`dw_2 within w_ge210_consulta_pbm
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;dw_2.ivo_Controle_Menu.of_Incluir(False)
dw_2.ivm_menu.mf_Confirmar(False)
dw_2.ivm_Menu.mf_Cancelar(False)		
dw_2.ivo_Controle_Menu.of_Excluir(False)
dw_2.ivm_Menu.mf_excluir(False)

Return 1
end event

type gb_2 from w_ge210_cadastro_pbm`gb_2 within w_ge210_consulta_pbm
end type

