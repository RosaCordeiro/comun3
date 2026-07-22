HA$PBExportHeader$dc_uo_parametro_impressao.sru
forward
global type dc_uo_parametro_impressao from nonvisualobject
end type
end forward

global type dc_uo_parametro_impressao from nonvisualobject
end type
global dc_uo_parametro_impressao dc_uo_parametro_impressao

type variables
boolean ivb_cancelar_impressao, &
             ivb_todas_paginas, &
             ivb_agrupar_copias

integer ivi_pagina_inicial, &
            ivi_pagina_final, &
            ivi_qtde_copias

end variables

on dc_uo_parametro_impressao.create
TriggerEvent( this, "constructor" )
end on

on dc_uo_parametro_impressao.destroy
TriggerEvent( this, "destructor" )
end on

