HA$PBExportHeader$uo_ge040_array.sru
forward
global type uo_ge040_array from nonvisualobject
end type
end forward

global type uo_ge040_array from nonvisualobject autoinstantiate
end type

forward prototypes
public function string uof_array_to_list (any aarray[], string aseparator)
public function string uof_array_to_list (any aarray[])
public subroutine uof_list_to_array (string aslist, ref any aaray[], string asseparador)
public function long uo_find (any aa_array[], any aa_value)
end prototypes

public function string uof_array_to_list (any aarray[], string aseparator);Long		ll_for
String	ls_lista


ls_lista	= ''

for ll_for = 1 to UpperBound(aarray)
	ls_lista	+= String(aarray[ll_for]) + aseparator
next

return ls_lista
end function

public function string uof_array_to_list (any aarray[]);return uof_array_to_list(aarray, ',')
end function

public subroutine uof_list_to_array (string aslist, ref any aaray[], string asseparador);Int		li_cont	= 0
String	ls_valor


do while pos(aslist, asseparador) > 0
	ls_valor	= Left(aslist, pos(aslist, asseparador) -1)
	
	li_cont++
	
	aaray[li_cont]	 = ls_valor
	
	aslist	= mid(aslist, pos(aslist, asseparador) + 1, len(aslist))
loop
end subroutine

public function long uo_find (any aa_array[], any aa_value);Long	ll_for, ll_result


ll_result	= 0

for ll_for = 1 to UpperBound(aa_array)
	if aa_value = aa_array[ll_for] then
		ll_result	= ll_for
		exit
	end if
next

return ll_result
end function

on uo_ge040_array.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge040_array.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

