HA$PBExportHeader$uo_ge137_planogramas.sru
forward
global type uo_ge137_planogramas from nonvisualobject
end type
end forward

global type uo_ge137_planogramas from nonvisualobject
end type
global uo_ge137_planogramas uo_ge137_planogramas

type variables
Long il_Planogramas[]

String is_planogramas

Long il_Analise
end variables

forward prototypes
public subroutine of_inicializa ()
public subroutine uo_ge137_planogramas ()
end prototypes

public subroutine of_inicializa ();Long ll_Null[]

il_Planogramas[]	 	= ll_Null[]

is_planogramas		= ""
end subroutine

public subroutine uo_ge137_planogramas ();
end subroutine

on uo_ge137_planogramas.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge137_planogramas.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

