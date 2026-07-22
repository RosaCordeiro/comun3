HA$PBExportHeader$uo_ge216_filiais.sru
forward
global type uo_ge216_filiais from userobject
end type
end forward

global type uo_ge216_filiais from userobject
integer width = 480
integer height = 840
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type
global uo_ge216_filiais uo_ge216_filiais

type variables
long ivl_filial[]

long cd_filial[]

string nm_fantasia[]

string ivs_filiais

boolean ib_todas_filiais = True

end variables

forward prototypes
public subroutine of_inicializa ()
end prototypes

public subroutine of_inicializa ();Long lvl_Vazio[]
String lvs_Vazio[]

ivl_filial		= lvl_Vazio
cd_filial		= lvl_Vazio
nm_fantasia	= lvs_Vazio

ivs_filiais = ""
ib_todas_filiais = True
end subroutine

on uo_ge216_filiais.create
end on

on uo_ge216_filiais.destroy
end on

