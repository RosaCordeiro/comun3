HA$PBExportHeader$dc_uo_menu_dw.sru
forward
global type dc_uo_menu_dw from nonvisualobject
end type
end forward

global type dc_uo_menu_dw from nonvisualobject
end type
global dc_uo_menu_dw dc_uo_menu_dw

type variables
Boolean ivb_Recuperar, &
              ivb_Incluir, &
              ivb_Alterar, &
              ivb_Excluir, &
              ivb_Classificar, &
              ivb_Filtrar, &
              ivb_Localizar, &
              ivb_Imprimir, &
              ivb_salvarcomo

m_janelas ivm_Menu

Protected:
dc_uo_dw_base ivdw_base
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
public function menu of_getmenu ()
public subroutine of_salvarcomo (boolean pb_habilita)
public subroutine of_setdw (dc_uo_dw_base adw)
end prototypes

public subroutine of_atualiza ();If Not IsNull(ivm_Menu) Then
	ivm_Menu.mf_Recuperar(ivb_Recuperar)
	
	ivm_Menu.mf_Incluir(ivb_Incluir)
	ivm_Menu.mf_Alterar(ivb_Alterar)
	ivm_Menu.mf_Excluir(ivb_Excluir)
	
	ivm_Menu.mf_Classificar(ivb_Classificar)
	ivm_Menu.mf_Localizar(ivb_Localizar)
	ivm_Menu.mf_Filtrar(ivb_Filtrar)
	
	ivm_Menu.mf_Imprimir(ivb_Imprimir)
	ivm_Menu.mf_SalvarComo(ivb_SalvarComo)
	
	If IsValid(ivdw_Base) Then
		If ivdw_Base.FilteredCount() > 0 Then
			ivm_Menu.mf_Limpar_Filtro(True)
		Else
			ivm_Menu.mf_Limpar_Filtro(False)
		End If
	End If
End If
end subroutine

public subroutine of_setmenu (menu pm_menu);ivm_Menu = pm_Menu
end subroutine

public subroutine of_recuperar (boolean pb_habilita);ivb_Recuperar = pb_Habilita
ivm_Menu.mf_Recuperar(pb_Habilita)
end subroutine

public subroutine of_classificar (boolean pb_habilita);ivb_Classificar = pb_Habilita
ivm_Menu.mf_Classificar(pb_Habilita)
end subroutine

public subroutine of_filtrar (boolean pb_habilita);ivb_Filtrar = pb_Habilita
ivm_Menu.mf_Filtrar(pb_Habilita)
end subroutine

public subroutine of_localizar (boolean pb_habilita);ivb_Localizar = pb_Habilita
ivm_Menu.mf_Localizar(pb_Habilita)
end subroutine

public subroutine of_excluir (boolean pb_habilita);ivb_Excluir = pb_Habilita
ivm_Menu.mf_Excluir(pb_Habilita)
end subroutine

public subroutine of_incluir (boolean pb_habilita);ivb_Incluir = pb_Habilita
ivm_Menu.mf_Incluir(pb_Habilita)
end subroutine

public subroutine of_alterar (boolean pb_habilita);ivb_Alterar = pb_Habilita
ivm_Menu.mf_Alterar(pb_Habilita)
end subroutine

public subroutine of_imprimir (boolean pb_habilita);ivb_Imprimir = pb_Habilita
ivm_Menu.mf_Imprimir(pb_Habilita)
end subroutine

public function menu of_getmenu ();Return ivm_Menu
end function

public subroutine of_salvarcomo (boolean pb_habilita);ivb_SalvarComo = pb_Habilita
ivm_Menu.mf_SalvarComo(pb_Habilita)
end subroutine

public subroutine of_setdw (dc_uo_dw_base adw);ivdw_Base = adw
end subroutine

on dc_uo_menu_dw.create
TriggerEvent( this, "constructor" )
end on

on dc_uo_menu_dw.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;SetNull(ivm_Menu)
end event

