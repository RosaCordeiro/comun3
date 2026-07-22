HA$PBExportHeader$uo_controle_menu_dw.sru
forward
global type uo_controle_menu_dw from nonvisualobject
end type
end forward

global type uo_controle_menu_dw from nonvisualobject
end type
global uo_controle_menu_dw uo_controle_menu_dw

type variables
Boolean ivb_Recuperar, &
              ivb_Incluir, &
              ivb_Alterar, &
              ivb_Excluir, &
              ivb_Classificar, &
              ivb_Filtrar, &
              ivb_Localizar, &
              ivb_Imprimir

Protected:
m_Janelas ivm_Menu
end variables

forward prototypes
public subroutine of_atualiza ()
public subroutine of_setmenu (menu pm_menu)
public subroutine of_recuperar (boolean pb_habilita)
public subroutine of_classificar (boolean pb_habilita)
public subroutine of_filtrar (boolean pb_habilita)
public subroutine of_localizar (boolean pb_habilita)
public subroutine of_excluir (boolean pb_habilita)
public subroutine of_incluir (boolean pb_habilita)
public subroutine of_alterar (boolean pb_habilita)
public subroutine of_imprimir (boolean pb_habilita)
end prototypes

public subroutine of_atualiza ();ivm_Menu.m_Editar.m_Recuperar.Enabled = ivb_Recuperar
ivm_Menu.m_Editar.m_Incluir.Enabled   = ivb_Incluir
ivm_Menu.m_Editar.m_Alterar.Enabled   = ivb_Alterar
ivm_Menu.m_Editar.m_Excluir.Enabled   = ivb_Excluir

ivm_Menu.m_Editar.m_Classificar.Enabled = ivb_Classificar
ivm_Menu.m_Editar.m_Localizar.Enabled   = ivb_Localizar
ivm_Menu.m_Editar.m_Filtrar.Enabled     = ivb_Filtrar
end subroutine

public subroutine of_setmenu (menu pm_menu);ivm_Menu = pm_Menu
end subroutine

public subroutine of_recuperar (boolean pb_habilita);ivb_Recuperar = pb_Habilita
ivm_Menu.m_Editar.m_Recuperar.Enabled = pb_Habilita
end subroutine

public subroutine of_classificar (boolean pb_habilita);ivb_Classificar = pb_Habilita
ivm_Menu.m_Editar.m_Classificar.Enabled = pb_Habilita
end subroutine

public subroutine of_filtrar (boolean pb_habilita);ivb_Filtrar = pb_Habilita
ivm_Menu.m_Editar.m_Filtrar.Enabled = pb_Habilita
end subroutine

public subroutine of_localizar (boolean pb_habilita);ivb_Localizar = pb_Habilita
ivm_Menu.m_Editar.m_Localizar.Enabled = pb_Habilita
end subroutine

public subroutine of_excluir (boolean pb_habilita);ivb_Excluir = pb_Habilita
ivm_Menu.m_Editar.m_Excluir.Enabled = pb_Habilita
end subroutine

public subroutine of_incluir (boolean pb_habilita);ivb_Incluir = pb_Habilita
ivm_Menu.m_Editar.m_Incluir.Enabled = pb_Habilita
end subroutine

public subroutine of_alterar (boolean pb_habilita);ivb_Alterar = pb_Habilita
ivm_Menu.m_Editar.m_Alterar.Enabled = pb_Habilita
end subroutine

public subroutine of_imprimir (boolean pb_habilita);ivb_Imprimir = pb_Habilita
ivm_Menu.m_Arquivo.m_Imprimir.Enabled = pb_Habilita
ivm_Menu.m_Arquivo.m_ImprimirImediato.Enabled = pb_Habilita
end subroutine

on uo_controle_menu_dw.create
TriggerEvent( this, "constructor" )
end on

on uo_controle_menu_dw.destroy
TriggerEvent( this, "destructor" )
end on

